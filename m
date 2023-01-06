Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BF0660764
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 20:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbjAFTv5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 14:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjAFTvz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 14:51:55 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6580D81C1C;
        Fri,  6 Jan 2023 11:51:40 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id v14so3004283qtq.3;
        Fri, 06 Jan 2023 11:51:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQtsw9lY0h7dyAESUotPsd50CIIa1Z4iwSP2XIRccpE=;
        b=Jo/I9RBMWYV4cnAHViXi/hUC0UxAsxA9NQu8D89d1skuaMIwJaBWiCtUG2x3MF5bCD
         nrK9y3FBapH/3ler5h1w/m+LbWBm0mgHSD1jgP4UtCX+DgDzFKl0e/p4oYRLxF5/l/kk
         QN7+XhvH4xDHNDFMpyoSeofugQLLnZFelxRZe0bwzwdK6m0YAH4VGtJVcJDoE9y7qwmu
         BiNW2KpP7Vhat+IWutanv7DUXXDF6zxCersho0Jnb1bhCabaZaLtl1YeBinZ9oj5Hufc
         TJoTEcoPf3eMteho5CKQkyAYX0ibm8n+2rydfUGFy/YEaFKxqB0KhQDGGPr6vCnxwJUt
         2K+Q==
X-Gm-Message-State: AFqh2kppNIFRXzBe4IP9HYJhHPlofmHoWIO8P+AbV7YlaC37+sNqUsiY
        d7zPsl8NxwIfikjZkWXwDnnY/MZbpsHOej+U
X-Google-Smtp-Source: AMrXdXuVRMSszEdIi/u9Hnz8aTg8eofScFgMME+U5SqNKH8OWiwXAcjvOOHI6MT8GkHcSdptJW/y7A==
X-Received: by 2002:ac8:4408:0:b0:3a9:8984:1103 with SMTP id j8-20020ac84408000000b003a989841103mr72676216qtn.67.1673034699168;
        Fri, 06 Jan 2023 11:51:39 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:a6f6])
        by smtp.gmail.com with ESMTPSA id bs25-20020ac86f19000000b0039cb59f00fcsm934640qtb.30.2023.01.06.11.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 11:51:38 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 0/3] Annotate kfuncs with new __bpf_kfunc macro
Date:   Fri,  6 Jan 2023 13:51:27 -0600
Message-Id: <20230106195130.1216841-1-void@manifault.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF kfuncs are kernel functions that can be invoked by BPF programs.
kfuncs can be kernel functions which are also called elsewhere in the
main kernel (such as crash_kexec()), or may be functions that are only
meant to be used by BPF programs, such as bpf_task_acquire(), and which
are not called from anywhere else in the kernel.

While thus far we haven't observed any issues such as kfuncs being
elided by the compiler, at some point we could easily run into problems
such as the following:

- static kernel functions that are also used as kfuncs could be inlined
  and/or elided by the compiler.
- BPF-specific kfuncs with external linkage may at some point be elided
  by the compiler in LTO builds, when it's determined that they aren't
  called anywhere.

To address this, this patch set introduces a new __bpf_kfunc macro which
should be added to all kfuncs, and which will protect kfuncs from such
problems. Note that some kfuncs kind of try to do this already by
specifying noinline or __used. We are inconsistent in how this is
applied. __bpf_kfunc should provide a uniform and more-future-proof way
to do this.

David Vernet (3):
  bpf: Add __bpf_kfunc tag for marking kernel functions as kfuncs
  bpf: Document usage of the new __bpf_kfunc macro
  bpf: Add __bpf_kfunc tag to all kfuncs

 Documentation/bpf/kfuncs.rst                  | 18 +++++
 Documentation/conf.py                         |  3 +
 include/linux/btf.h                           |  9 +++
 kernel/bpf/helpers.c                          | 19 +++++
 kernel/cgroup/rstat.c                         |  2 +
 kernel/kexec_core.c                           |  2 +
 kernel/trace/bpf_trace.c                      |  4 +
 net/bpf/test_run.c                            | 76 ++++++++++++-------
 net/ipv4/tcp_bbr.c                            |  8 ++
 net/ipv4/tcp_cong.c                           |  5 ++
 net/ipv4/tcp_cubic.c                          |  6 ++
 net/ipv4/tcp_dctcp.c                          |  6 ++
 net/netfilter/nf_conntrack_bpf.c              | 14 +++-
 net/netfilter/nf_nat_bpf.c                    |  1 +
 net/xfrm/xfrm_interface_bpf.c                 |  4 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  2 +-
 16 files changed, 146 insertions(+), 33 deletions(-)

-- 
2.39.0

