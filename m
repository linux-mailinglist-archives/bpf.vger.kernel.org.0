Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54EF55E994
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 18:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348157AbiF1QCi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 12:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347466AbiF1QCY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 12:02:24 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCF437A0E
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 09:01:43 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 212B4240032
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 18:01:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1656432101; bh=tQl+Fqv9coEa5c/MTZqdBCnIzUrFzLB9VMKzx4C/bOw=;
        h=From:To:Cc:Subject:Date:From;
        b=evGiPwU1WXWWvf3ayGdXTR810/tC0WGowSROH0r4SCh+lEdlpH2ao/TW5TFGntIYO
         f9jQY898HawcDNY7yG7mGMKxLSeQA0ttyeci2PM6hSp0ZlGNKECmydNDfteUaoEpEF
         71fx8idc+pRBfT79CFnkrv8dtlryX1rQm3dEYtWXpohoUg7ZTAdt0WZMADMZ9buECS
         2WE00P82IriO9c4kNSY1Ba0WBQRnK7sARz3dbS+C02Oz0yR1vdgXWczZ8ELIKlpTae
         of7cGyhRFGHOtZnj2AVPMhvdgiRn82h+9NSiF1FFu1lL9WbphrX5l4T+KzX1qpWO1B
         AhpjVzuEJ4Jhw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LXTqS0d3nz6tmG;
        Tue, 28 Jun 2022 18:01:39 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     joannelkoong@gmail.com
Subject: [PATCH bpf-next v3 00/10] Introduce type match support
Date:   Tue, 28 Jun 2022 16:01:17 +0000
Message-Id: <20220628160127.607834-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set proposes the addition of a new way for performing type queries to
BPF. It introduces the "type matches" relation, similar to what is already
present with "type exists" (in the form of bpf_core_type_exists).

"type exists" performs fairly superficial checking, mostly concerned with
whether a type exists in the kernel and is of the same kind (enum/struct/...).
Notably, compatibility checks for members of composite types is lacking.

The newly introduced "type matches" (bpf_core_type_matches) fills this gap in
that it performs stricter checks: compatibility of members and existence of
similarly named enum variants is checked as well. E.g., given these definitions:

	struct task_struct___og { int pid; int tgid; };

	struct task_struct___foo { int foo; }

'task_struct___og' would "match" the kernel type 'task_struct', because the
members match up, while 'task_struct___foo' would not match, because the
kernel's 'task_struct' has no member named 'foo'.

More precisely, the "type match" relation is defined as follows (copied from
source):
- modifiers and typedefs are stripped (and, hence, effectively ignored)
- generally speaking types need to be of same kind (struct vs. struct, union
  vs. union, etc.)
  - exceptions are struct/union behind a pointer which could also match a
    forward declaration of a struct or union, respectively, and enum vs.
    enum64 (see below)
Then, depending on type:
- integers:
  - match if size and signedness match
- arrays & pointers:
  - target types are recursively matched
- structs & unions:
  - local members need to exist in target with the same name
  - for each member we recursively check match unless it is already behind a
    pointer, in which case we only check matching names and compatible kind
- enums:
  - local variants have to have a match in target by symbolic name (but not
    numeric value)
  - size has to match (but enum may match enum64 and vice versa)
- function pointers:
  - number and position of arguments in local type has to match target
  - for each argument and the return value we recursively check match

Enabling this feature requires a new relocation to be made known to the
compiler. This is being taken care of for LLVM as part of
https://reviews.llvm.org/D126838.

If applied, among other things, usage of this functionality could have helped
flag issues such as the one discussed here
https://lore.kernel.org/all/93a20759600c05b6d9e4359a1517c88e06b44834.camel@fb.com/
earlier.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
---
Changelog:
v2 -> v3:
- renamed btfgen_mark_types_match
- covered BTF_KIND_RESTRICT in type match marking logic
- used bpf_core_names_match in more places
- reworked "behind pointer" logic
- added test using live task_struct

v1 -> v2:
- deduplicated and moved core algorithm into relo_core.c
- adjusted bpf_core_names_match to get btf_type passed in
- removed some length equality checks before strncmp usage
- correctly use kflag from targ_t instead of local_t
- added comment for meaning of kflag w/ FWD kind
- __u32 -> u32
- handle BTF_KIND_FWD properly in bpftool marking logic
- rebased

Daniel Müller (10):
  bpf: Introduce TYPE_MATCH related constants/macros
  bpftool: Honor BPF_CORE_TYPE_MATCHES relocation
  bpf: Introduce btf_int_bits() function
  libbpf: Add type match support
  bpf: Add type match support
  libbpf: Honor TYPE_MATCH relocation
  selftests/bpf: Add type-match checks to type-based tests
  selftests/bpf: Add test checking more characteristics
  selftests/bpf: Add nested type to type based tests
  selftests/bpf: Add type match test against kernel's task_struct

 include/linux/btf.h                           |   5 +
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/btf.c                              |   9 +
 tools/bpf/bpftool/gen.c                       | 108 +++++++
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/bpf_core_read.h                 |  11 +
 tools/lib/bpf/libbpf.c                        |   6 +
 tools/lib/bpf/relo_core.c                     | 284 +++++++++++++++++-
 tools/lib/bpf/relo_core.h                     |   4 +
 .../selftests/bpf/prog_tests/core_reloc.c     |  73 ++++-
 .../progs/btf__core_reloc_type_based___diff.c |   3 +
 .../selftests/bpf/progs/core_reloc_types.h    | 108 ++++++-
 .../bpf/progs/test_core_reloc_kernel.c        |  11 +
 .../bpf/progs/test_core_reloc_type_based.c    |  44 ++-
 14 files changed, 650 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_type_based___diff.c

-- 
2.30.2

