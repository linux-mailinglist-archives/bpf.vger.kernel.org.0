Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FC36224D2
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 08:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiKIHpR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 02:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKIHpP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 02:45:15 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2714C186FE
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 23:45:12 -0800 (PST)
Date:   Wed, 09 Nov 2022 07:44:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=industrialdiscipline.com; s=protonmail3; t=1667979909;
        x=1668239109; bh=F45tio1Vl7sycJSJteTT5DZdwF/nsY15JFDdV900Ye4=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=LEHhsYy3jcL8LaSLYSFeAIQEEw5c0adzKRR7ikF0TLFNrizsyOuXMBKWHAeNXUV0m
         hd06Ni35tJ+fvi20Xe5fWWb3qSj7KcHe6LR6jeUIxXh+VpjbpGQCJw43zFa7kzUPjz
         BWj5SjW0A4kIsFc7nY+ZBYnoY6Jhgy6iui9lMcRGxz5vzCRBlDJ4Rn8rCJaS3KwMdY
         NMClhkiQ4tq2pVsMWHgR5lX1GJ6ibxc2CurI0tk5wXTD8MWd4mpJi7iz9XeSoxRuc1
         If6HYFeWKo/FiSHte/UKZydLef3LsHNGs+p4OE8eGL9/LCYwKwU39nOKNf+wZz9yWn
         pQQzZDKOodqFg==
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com
From:   Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Subject: [PATCH bpf-next v2 0/5] clean-up bpftool from legacy support
Message-ID: <20221109074427.141751-1-sahid.ferdjaoui@industrialdiscipline.com>
Feedback-ID: 39921202:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Sahid Orentino Ferdjaoui (5):
  bpftool: remove support of --legacy option for bpftool
  bpftool: replace return value PTR_ERR(NULL) with 0
  bpftool: fix error message when function can't register struct_ops
  bpftool: clean-up usage of libbpf_get_error()
  bpftool: remove function free_btf_vmlinux()

 .../bpftool/Documentation/common_options.rst  |  9 --------
 .../bpftool/Documentation/substitutions.rst   |  2 +-
 tools/bpf/bpftool/bash-completion/bpftool     |  2 +-
 tools/bpf/bpftool/btf.c                       | 17 ++++++--------
 tools/bpf/bpftool/btf_dumper.c                |  2 +-
 tools/bpf/bpftool/gen.c                       | 11 ++++------
 tools/bpf/bpftool/iter.c                      |  6 ++---
 tools/bpf/bpftool/main.c                      | 22 +++----------------
 tools/bpf/bpftool/main.h                      |  3 +--
 tools/bpf/bpftool/map.c                       | 20 ++++++-----------
 tools/bpf/bpftool/prog.c                      | 15 +++++--------
 tools/bpf/bpftool/struct_ops.c                | 22 ++++++++-----------
 .../selftests/bpf/test_bpftool_synctypes.py   |  6 ++---
 13 files changed, 44 insertions(+), 93 deletions(-)

--
2.34.1


