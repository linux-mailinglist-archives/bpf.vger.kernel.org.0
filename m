Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638DE528C0B
	for <lists+bpf@lfdr.de>; Mon, 16 May 2022 19:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbiEPRfv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 13:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344311AbiEPRft (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 13:35:49 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7E736B5F
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 10:35:45 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 39FFE240029
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 19:35:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1652722543; bh=2zgc+wbPmKqdOy4APQ7rhDDALkFYIdQ+aPeOGe0ViTM=;
        h=From:To:Subject:Date:From;
        b=ruTyvQ3d9vTzMSPRbDsaFZgPMWDEM9B6Jg7ql/Tr/VkSonRe0LxhFmW2th96NytXe
         87MGPGgPVIQcz/ws/sSFfyxAKaXMl202fh5hVGbjRcQRTEJuQuv6WtHFm4p/YDV9+b
         AcI7Ot2OyXsTfJxgj+52s6f03JTQkaFRHWmagv8RL+LkdezbRURVK8Fd9QUpK8NaRq
         8mgKS5QZKbfaG3nFrCexfXQitwky4EmWnT6XwZHfhP9Yg753rYQxJdXjYOyaTKKzkH
         frhKC3fFBQuBVUqks3zC4V6x5sWEc01URwXjzQuj/ud6Wy2FOP+tkOgSwYtAtjAFJg
         /ym+JLKh3y3Wg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L25xp1906z9rxB;
        Mon, 16 May 2022 19:35:42 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, quentin@isovalent.com
Subject: [PATCH bpf-next 00/12] libbpf: Textual representation of enums
Date:   Mon, 16 May 2022 17:35:28 +0000
Message-Id: <20220516173540.3520665-1-deso@posteo.net>
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
bpf_attach_type variants. We propose a work around keeping the existing behavior
for the time being in the patch titled "bpftool: Use
libbpf_bpf_attach_type_str".

The patch series is structured as follows:
- for each enumeration type in {bpf_prog_type, bpf_map_type, bpf_attach_type,
  bpf_link_type}:
  - we first introduce the corresponding public libbpf API function
  - we then add BTF based self-tests
  - we lastly adjust bpftool to use the libbpf provided functionality

Signed-off-by: Daniel Müller <deso@posteo.net>

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

 tools/bpf/bpftool/cgroup.c                    |  20 +-
 tools/bpf/bpftool/common.c                    |  46 ----
 tools/bpf/bpftool/feature.c                   |  87 +++++---
 tools/bpf/bpftool/link.c                      |  61 +++---
 tools/bpf/bpftool/main.h                      |   6 -
 tools/bpf/bpftool/map.c                       |  82 +++----
 tools/bpf/bpftool/prog.c                      |  51 +----
 tools/lib/bpf/libbpf.c                        | 160 ++++++++++++++
 tools/lib/bpf/libbpf.h                        |  36 ++++
 tools/lib/bpf/libbpf.map                      |   4 +
 .../selftests/bpf/prog_tests/libbpf_str.c     | 201 ++++++++++++++++++
 11 files changed, 539 insertions(+), 215 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libbpf_str.c

-- 
2.30.2

