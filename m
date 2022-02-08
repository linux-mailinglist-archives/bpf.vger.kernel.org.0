Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7A44AE1FE
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 20:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385287AbiBHTNM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 14:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385876AbiBHTNK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 14:13:10 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D195AC0612AA
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 11:13:08 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v4so88018pjh.2
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 11:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2U54Zji1diC16RH1LPgLVy4qAyUxl2XkWBQNoQM74Hk=;
        b=g4qCy31WdEtFI7tMnvAGXpvtIN0Ue2VRj0cpvbXjqlZMpvfc7PNwC3QkgrlkrSkvuk
         1Fplhiuv94L5+B+HiZejHLxHaBKj6zNyT8tzeMVDHt/RC4Z7zHkHeVkY1g/R1nRKBOxv
         IsXnB3UxaCU9bmHsTMcoz7bXdVBmMNHwo78A5H9HvLvk8TPBs/alB88hENayWoYKEyfX
         ra2iY6T9GhfIIul7gTl9qd5RL0BEkE3MGlsPFvuzGw5tjot320D7LncpbMEHE7GTKqbZ
         UCr6P84kochMyZV1PWl2FNuFBeBTu7vm5noa5jR4b7nMuj1sSC+tA5WbJBwwxMEgUw4F
         3usQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2U54Zji1diC16RH1LPgLVy4qAyUxl2XkWBQNoQM74Hk=;
        b=HaN2yvLTitjxEIKJ9YpjfmLcvIK8+/20/hicfvh8Wm3gybm6f9zFKgJM1Ac1klOmq0
         TLF10InmZ04Tsm8oBf3AtfupcM5XPKGpuLyioDWLad4h/q3PnevryH6fFZ+gsU4VSIXp
         ypQKvW2c2Xtm/h7+zpqT8Gq+kKuvwD7wyXRl/yMhUQfVK6G6AZJlKBHaJwb7cuEqFuBB
         tsh1xwEbffGDLPDBiLeZLZGVrtfQ/UWCmcgjWR2HGVHZTO4pdYyC/mptvAAvo7/BNeJR
         XhHdBgcnaA3qx+EyaxWSxcfS+hZfi6qDLNfq5akQ4xieY5u3Qljgq3VZjoTtBi79NV5+
         rDOw==
X-Gm-Message-State: AOAM5315xWYZmfZ7bC3t6PQKo4CJZMxlOr6lxTLxF6FQzITjjr9+eyd7
        mo17FzH9E4qcVFhGvSob8kU=
X-Google-Smtp-Source: ABdhPJzztlZ+0GfJwbUElgWbAhQteKyNOf0se22xFetDTprzdZ6UY6izxr+MkVsGnTdRaLqdNry62Q==
X-Received: by 2002:a17:90b:100e:: with SMTP id gm14mr2946925pjb.155.1644347588157;
        Tue, 08 Feb 2022 11:13:08 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:500::2:72b2])
        by smtp.gmail.com with ESMTPSA id u33sm16945421pfg.195.2022.02.08.11.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:13:07 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 bpf-next 0/5] bpf: Light skeleton for the kernel.
Date:   Tue,  8 Feb 2022 11:13:01 -0800
Message-Id: <20220208191306.6136-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

The libbpf performs a set of complex operations to load BPF programs.
With "loader program" and "CO-RE in the kernel" the loading job of
libbpf was diminished. The light skeleton became lean enough to perform
program loading and map creation tasks without libbpf.
It's now possible to tweak it further to make light skeleton usable
out of user space and out of kernel module.
This allows bpf_preload.ko to drop user-mode-driver usage,
drop host compiler dependency, allow cross compilation and simplify the code.
It's a building block toward safe and portable kernel modules.

v1->v2:
- removed redundant anon struct and added comments (Andrii's reivew)
- added Yonghong's ack
- fixed build warning when JIT is off

Alexei Starovoitov (5):
  bpf: Extend sys_bpf commands for bpf_syscall programs.
  libbpf: Prepare light skeleton for the kernel.
  bpftool: Generalize light skeleton generation.
  bpf: Update iterators.lskel.h.
  bpf: Convert bpf_preload.ko to use light skeleton.

 kernel/bpf/inode.c                            |  39 +---
 kernel/bpf/preload/Kconfig                    |   9 +-
 kernel/bpf/preload/Makefile                   |  14 +-
 kernel/bpf/preload/bpf_preload.h              |   8 +-
 kernel/bpf/preload/bpf_preload_kern.c         | 119 +++++------
 kernel/bpf/preload/bpf_preload_umd_blob.S     |   7 -
 .../preload/iterators/bpf_preload_common.h    |  13 --
 kernel/bpf/preload/iterators/iterators.c      | 108 ----------
 .../bpf/preload/iterators/iterators.lskel.h   |  28 +--
 kernel/bpf/syscall.c                          |  40 +++-
 tools/bpf/bpftool/gen.c                       |  45 ++--
 tools/lib/bpf/skel_internal.h                 | 193 ++++++++++++++++--
 12 files changed, 319 insertions(+), 304 deletions(-)
 delete mode 100644 kernel/bpf/preload/bpf_preload_umd_blob.S
 delete mode 100644 kernel/bpf/preload/iterators/bpf_preload_common.h
 delete mode 100644 kernel/bpf/preload/iterators/iterators.c

-- 
2.30.2

