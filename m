Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F7252C887
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 02:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiESAS0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 20:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiESASV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 20:18:21 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C47C163F54
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 17:18:19 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id A07EA240109
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 02:18:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1652919497; bh=G3jBMWIgZ0bnwQxaOeM07nDjSzabi+ByQSK7kB88/VU=;
        h=From:To:Cc:Subject:Date:From;
        b=jzZBH03C3PvkanJg1OHjjmGruDNbKRNZVeQNKpkUtsxNKAnVB4eB7tE/UpxJVRH95
         5/fRVI4TzaX74jJairatLXZkLQ+So0rjZgcuxT5MWabmuHJJmCrl3xQdHwceOxwBJA
         q6ax4nXcWQnyCearjbvuLK2NjUBQp2zw7juw1vgYc1EBQCEilGaeVXQnxwgNU/9RxZ
         Jj6+zRWKfhsLIqbYXQKZjNHQ4vrJlKqdbSvsjmbHkNUh1edNCOK9oHc/BPMuZAqckk
         DNoXwLnVxxl8Yg+YQ/a8wQdRd31rsas11FOhhsFrbfuZMvDHoFFFzMumSySFfStSpT
         CHhnGTKkjjqsA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L3VnN4KcCz9rxF;
        Thu, 19 May 2022 02:18:16 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     yhs@fb.com, quentin@isovalent.com
Subject: [PATCH bpf-next v2 00/12] libbpf: Textual representation of enums
Date:   Thu, 19 May 2022 00:18:03 +0000
Message-Id: <20220519001815.1944959-1-deso@posteo.net>
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

This patch set introduces the means for querying a textual representation of
the following BPF related enum types:
- enum bpf_map_type
- enum bpf_prog_type
- enum bpf_attach_type
- enum bpf_link_type

To make that possible, we introduce a new public function for each of the types:
libbpf_bpf_<type>_type_str.

Having a way to query a textual representation has been asked for in the past
(by systemd, among others). Such representations can generally be useful in
tracing and logging contexts, among others. At this point, at least one client,
bpftool, maintains such a mapping manually, which is prone to get out of date as
new enum variants are introduced. libbpf is arguably best situated to keep this
list complete and up-to-date. This patch series adds BTF based tests to ensure
that exhaustiveness is upheld moving forward.

The libbpf provided textual representation can be inferred from the
corresponding enum variant name by removing the prefix and lowercasing the
remainder. E.g., BPF_PROG_TYPE_SOCKET_FILTER -> socket_filter. Unfortunately,
bpftool does not use such a programmatic approach for some of the
bpf_attach_type variants. We decided changing its behavior to work with libbpf
representations. However, for user inputs, specifically, we do keep support for
the traditionally used names around (please see patch "bpftool: Use
libbpf_bpf_attach_type_str").

The patch series is structured as follows:
- for each enumeration type in {bpf_prog_type, bpf_map_type, bpf_attach_type,
  bpf_link_type}:
  - we first introduce the corresponding public libbpf API function
  - we then add BTF based self-tests
  - we lastly adjust bpftool to use the libbpf provided functionality

Changelog:
v1 -> v2:
- adjusted bpftool to work with algorithmically determined attach types as
  libbpf now uses (just removed prefix from enum name and lowercased the rest)
  - adjusted tests, man page, and completion script to work with the new names
  - renamed bpf_attach_type_str -> bpf_attach_type_input_str
  - for input: added special cases that accept the traditionally used strings as
    well
- changed 'char const *' -> 'const char *'

Signed-off-by: Daniel Müller <deso@posteo.net>
Acked-by: Yonghong Song <yhs@fb.com>
Cc: Quentin Monnet <quentin@isovalent.com>

Daniel Müller (12):
  libbpf: Introduce libbpf_bpf_prog_type_str
  selftests/bpf: Add test for libbpf_bpf_prog_type_str
  bpftool: Use libbpf_bpf_prog_type_str
  libbpf: Introduce libbpf_bpf_map_type_str
  selftests/bpf: Add test for libbpf_bpf_map_type_str
  bpftool: Use libbpf_bpf_map_type_str
  libbpf: Introduce libbpf_bpf_attach_type_str
  selftests/bpf: Add test for libbpf_bpf_attach_type_str
  bpftool: Use libbpf_bpf_attach_type_str
  libbpf: Introduce libbpf_bpf_link_type_str
  selftests/bpf: Add test for libbpf_bpf_link_type_str
  bpftool: Use libbpf_bpf_link_type_str

 .../bpftool/Documentation/bpftool-cgroup.rst  |  16 +-
 .../bpftool/Documentation/bpftool-prog.rst    |   5 +-
 tools/bpf/bpftool/bash-completion/bpftool     |  18 +-
 tools/bpf/bpftool/cgroup.c                    |  49 +++--
 tools/bpf/bpftool/common.c                    |  82 +++----
 tools/bpf/bpftool/feature.c                   |  87 +++++---
 tools/bpf/bpftool/link.c                      |  61 +++---
 tools/bpf/bpftool/main.h                      |  23 +-
 tools/bpf/bpftool/map.c                       |  82 +++----
 tools/bpf/bpftool/prog.c                      |  77 +++----
 tools/lib/bpf/libbpf.c                        | 160 ++++++++++++++
 tools/lib/bpf/libbpf.h                        |  36 +++
 tools/lib/bpf/libbpf.map                      |   4 +
 .../selftests/bpf/prog_tests/libbpf_str.c     | 207 ++++++++++++++++++
 .../selftests/bpf/test_bpftool_synctypes.py   | 163 ++++++--------
 15 files changed, 736 insertions(+), 334 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libbpf_str.c

-- 
2.30.2

