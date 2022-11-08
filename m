Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ED8621694
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 15:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiKHOaI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 09:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbiKHO3o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 09:29:44 -0500
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4DE862FB
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 06:28:03 -0800 (PST)
Date:   Tue, 08 Nov 2022 14:27:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=industrialdiscipline.com; s=protonmail3; t=1667917681;
        x=1668176881; bh=SEH01Mi6/Bbg+Ef7RRHWhv4M8xzmujHcnp1TX7I0U3w=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=GiiXhutbHB+DCjredwmwkMHgGQQsrR32MVuWxMHm78LNMvra3MNeYZe+zXrYkHWmI
         0QHqKYXqsg4SjnfpOsF6QGXrqz6TyqGw7ouar0NUm7APUAeWO72ceDy9kjivkSX6/y
         Yswi5IQ25dPLa/TXSNP/haQz/naceh00CQbiV6qh5mFUixZb73B/qD27gLBUtSZ0Ly
         p/TimnpAzFqJLOor240mJN0xK2V3UM+NdZR8zIxV9Htp4RzMBbBDHUnNwREM59JWt+
         vzsH9GM8JquGB9wlYt0TTR+3qVAsjtxCqVtIoob+IB2oxNpfkbedIR7951/W+PylQJ
         W/wYYvTsX7/aQ==
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com
From:   Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Subject: [PATCH 0/4] clean-up bpftool from legacy support
Message-ID: <20221108142515.126199-1-sahid.ferdjaoui@industrialdiscipline.com>
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

Sahid Orentino Ferdjaoui (4):
  bpftool: remove support of --legacy option for bpftool
  bpftool: replace return value PTR_ERR(NULL) with 0
  bpftool: fix error message when function can't register struct_ops
  bpftool: clean-up usage of libbpf_get_error()

 .../bpftool/Documentation/common_options.rst  |  9 --------
 .../bpftool/Documentation/substitutions.rst   |  2 +-
 tools/bpf/bpftool/bash-completion/bpftool     |  2 +-
 tools/bpf/bpftool/btf.c                       | 16 ++++++--------
 tools/bpf/bpftool/btf_dumper.c                |  2 +-
 tools/bpf/bpftool/gen.c                       | 11 ++++------
 tools/bpf/bpftool/iter.c                      |  6 ++---
 tools/bpf/bpftool/main.c                      | 22 +++----------------
 tools/bpf/bpftool/main.h                      |  3 +--
 tools/bpf/bpftool/map.c                       | 15 ++++++-------
 tools/bpf/bpftool/prog.c                      | 15 +++++--------
 tools/bpf/bpftool/struct_ops.c                | 22 ++++++++-----------
 .../selftests/bpf/test_bpftool_synctypes.py   |  6 ++---
 13 files changed, 44 insertions(+), 87 deletions(-)

--
2.34.1


