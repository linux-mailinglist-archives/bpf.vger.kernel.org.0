Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75E0626EE2
	for <lists+bpf@lfdr.de>; Sun, 13 Nov 2022 11:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiKMKPM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Nov 2022 05:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMKPL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Nov 2022 05:15:11 -0500
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BD410043
        for <bpf@vger.kernel.org>; Sun, 13 Nov 2022 02:15:09 -0800 (PST)
Date:   Sun, 13 Nov 2022 10:14:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=industrialdiscipline.com; s=protonmail3; t=1668334504;
        x=1668593704; bh=Nym5MPtQvGUs+2VybqFkqkZP18RuR7D3T2sgLXnxOz4=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=APxtM7ttoExaCDPEkIjVWIzVz2J22v5ELXJAl3QGPMYhOE2Qmaxq6Lid7R+gyBCdg
         0m2lAfr0LAu887BUED6Ou95FeRjQi4vUZubcG4LHDicNNt04l2d17eZf6V615IG93G
         f+tcTyGldxeqnCkO6ehJtG79Iuryvk0f0I3KTYkg6X/u4gLa/VD9SH3BTQxdM+Grbx
         om42j3CrJtYMG38dh9JangycEf0F/CoQTtTtqJrRbc53CumJB+mfTkLzOzZA/gYZXh
         dwX5m36VlB1fT+YeioQQaC1ad2/zIFLvdxIR2L/Iwl+Skpr715ZVioKixZy6Fz2nIZ
         x2pVwvb+noEJQ==
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com, yhs@fb.com
From:   Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org,
        Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Subject: [PATCH bpf-next v3 0/5] clean-up bpftool from legacy support
Message-ID: <20221113101438.30910-1-sahid.ferdjaoui@industrialdiscipline.com>
Feedback-ID: 39921202:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
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
 tools/bpf/bpftool/gen.c                       | 11 ++++------
 tools/bpf/bpftool/iter.c                      |  6 ++---
 tools/bpf/bpftool/main.c                      | 22 +++----------------
 tools/bpf/bpftool/main.h                      |  3 +--
 tools/bpf/bpftool/map.c                       | 20 ++++++-----------
 tools/bpf/bpftool/prog.c                      | 15 +++++--------
 tools/bpf/bpftool/struct_ops.c                | 22 ++++++++-----------
 .../selftests/bpf/test_bpftool_synctypes.py   |  6 ++---
 13 files changed, 45 insertions(+), 94 deletions(-)

--
2.34.1


