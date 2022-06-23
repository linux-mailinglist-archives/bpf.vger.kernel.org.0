Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65350558AA1
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 23:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiFWVW0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 17:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiFWVWZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 17:22:25 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81C14E390
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 14:22:23 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 3BA2E240028
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 23:22:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1656019341; bh=3QismPY3GeiYF6OPtZFCXHBuuzMIp6QCu+dXm/7WopQ=;
        h=From:To:Cc:Subject:Date:From;
        b=OZ9z2ATboaM03NqNkelQgxlSBdOTN/3FqiJYoRP4pP/yNKCbo2sEQRFnT6Eb8Ma4N
         PXnna85aq2eS0qH801LGSBXJInq0WHgIWndts3uK6cWxi+V3nZXd13jDxWFeD/+Kl7
         B3nNg9Ebb4bXEpw9WP3A7++xmVa59kdQJtP6AOr3/+nr2BUYKhh7fS8chvmPnH9EfX
         xnXTIKPy8NbUp7IY+qWr1NbZRiHfL5fNlaiYE+5asssJpEgx3j3o2qvRzXpDVZJc5z
         popzNnD8zrkoIherUNDBmvzKktTGW+1gAiWjRaBqIPHurRLbQKD/oI6/Z1LqSSeVqg
         XWc/8kHNVja/g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LTY9m2Lnpz6tns;
        Thu, 23 Jun 2022 23:22:20 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     joannelkoong@gmail.com
Subject: [PATCH bpf-next v2 0/9] Introduce type match support
Date:   Thu, 23 Jun 2022 21:21:56 +0000
Message-Id: <20220623212205.2805002-1-deso@posteo.net>
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
v1 -> v2:
- deduplicated and moved core algorithm into relo_core.c
- adjusted bpf_core_names_match to get btf_type passed in
- removed some length equality checks before strncmp usage
- correctly use kflag from targ_t instead of local_t
- added comment for meaning of kflag w/ FWD kind
- __u32 -> u32
- handle BTF_KIND_FWD properly in bpftool marking logic
- rebased

Daniel Müller (9):
  bpf: Introduce TYPE_MATCH related constants/macros
  bpftool: Honor BPF_CORE_TYPE_MATCHES relocation
  bpf: Introduce btf_int_bits() function
  libbpf: Add type match support
  bpf: Add type match support
  libbpf: Honor TYPE_MATCH relocation
  selftests/bpf: Add type-match checks to type-based tests
  selftests/bpf: Add test checking more characteristics
  selftests/bpf: Add nested type to type based tests

 include/linux/btf.h                           |   5 +
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/btf.c                              |   9 +
 tools/bpf/bpftool/gen.c                       | 107 +++++++
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/bpf_core_read.h                 |  11 +
 tools/lib/bpf/libbpf.c                        |   6 +
 tools/lib/bpf/relo_core.c                     | 292 +++++++++++++++++-
 tools/lib/bpf/relo_core.h                     |   4 +
 .../selftests/bpf/prog_tests/core_reloc.c     |  72 ++++-
 .../progs/btf__core_reloc_type_based___diff.c |   3 +
 .../selftests/bpf/progs/core_reloc_types.h    | 107 ++++++-
 .../bpf/progs/test_core_reloc_type_based.c    |  44 ++-
 13 files changed, 644 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_type_based___diff.c

-- 
2.30.2

