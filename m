Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C255631395
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 12:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiKTLNj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 06:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiKTLNd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 06:13:33 -0500
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CEF15A32
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 03:13:27 -0800 (PST)
Date:   Sun, 20 Nov 2022 11:13:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=industrialdiscipline.com; s=protonmail3; t=1668942804;
        x=1669202004; bh=hTRNh0xd4JCBfoVrUKvn2v79qy90JSZSskwMQRbjjNM=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=uF6Ika7r/L9kn2pZ77ojXUEpCQ4iUHlUi53DnFVKIoplOeQBXkEjym4PrEe4tTCSa
         OG01Cp/9MWZCMfP1+qFJDCXJPcA4UTvQeqaD8Q4Eurb4GNwgrZIc+u7xYJjBimXfx/
         cnLhj77XP2yK6FDYU+zkOW89+BK3UA+3gfZBdWECuMsfL6hRZxfT26INPNMc6kviWA
         7DS25SEAPCjN0Qnl33bgdZ6AFT2QkouWoNVYpKEidWpHLVCi+1lVp6k1BGQ8PWwaDP
         eim79l0H2qAcBZYTzUDEtZtck96JPys4pxspTmOHNYz20S3oH3QMv27AeMiuFqEFo5
         3jNhPXaKQJS1Q==
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com, yhs@fb.com
From:   Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org,
        Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Subject: [PATCH bpf-next v4 0/5] clean-up bpftool from legacy support
Message-ID: <20221120111142.35316-1-sahid.ferdjaoui@industrialdiscipline.com>
Feedback-ID: 39921202:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As part of commit 93b8952d223a ("libbpf: deprecate legacy BPF map
definitions") and commit bd054102a8c7 ("libbpf: enforce strict libbpf
1.0 behaviors") The --legacy option is not relevant anymore. #1 is
removing it. #4 is cleaning the code from using libbpf_get_error().

About patches #2 and #3 They are changes discovered while working on
this series (credits to Quentin Monnet). #2 is cleaning-up usage of an
unnecessary PTR_ERR(NULL), finally #3 is fixing an invalid value
passed to strerror().

v1 -> v2:
   - Addressed review comments from Yonghong Song on patch #4
   - Added a patch #5 that removes unwanted function noticed by
     Yonghong Song
v2 -> v3
   - Addressed review comments from Andrii Nakryiko on patch #2, #3, #4
     * clean-up usage of libbpf_get_error() (#2, #3)
     * fix possible return of an uninitialized local variable err
     * fix returned errors using errno
v3 -> v4
   - Addressed review comments from Quentin Monnet
     * fix line moved from patch #2 to patch #3
     * fix missing returned errors using errno
     * fix some returned values to errno instead of -1

Sahid Orentino Ferdjaoui (5):
  bpftool: remove support of --legacy option for bpftool
  bpftool: replace return value PTR_ERR(NULL) with 0
  bpftool: fix error message when function can't register struct_ops
  bpftool: clean-up usage of libbpf_get_error()
  bpftool: remove function free_btf_vmlinux()

 .../bpftool/Documentation/common_options.rst  |  9 --------
 .../bpftool/Documentation/substitutions.rst   |  2 +-
 tools/bpf/bpftool/bash-completion/bpftool     |  2 +-
 tools/bpf/bpftool/btf.c                       | 19 +++++++---------
 tools/bpf/bpftool/btf_dumper.c                |  2 +-
 tools/bpf/bpftool/gen.c                       | 10 ++++-----
 tools/bpf/bpftool/iter.c                      |  9 ++++----
 tools/bpf/bpftool/main.c                      | 22 +++----------------
 tools/bpf/bpftool/main.h                      |  3 +--
 tools/bpf/bpftool/map.c                       | 20 ++++++-----------
 tools/bpf/bpftool/prog.c                      | 15 +++++--------
 tools/bpf/bpftool/struct_ops.c                | 22 ++++++++-----------
 .../selftests/bpf/test_bpftool_synctypes.py   |  6 ++---
 13 files changed, 48 insertions(+), 93 deletions(-)

--
2.34.1


