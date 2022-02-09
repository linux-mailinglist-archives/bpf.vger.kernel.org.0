Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687854B011F
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 00:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiBIXUK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 18:20:10 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiBIXUI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 18:20:08 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10990E068F50
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 15:20:04 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id y5so7061368pfe.4
        for <bpf@vger.kernel.org>; Wed, 09 Feb 2022 15:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/PeJVlToLa1AacmOxRQ0TpLQRbNG2pegJQFcYVFHfwE=;
        b=iAlSFiuujBWduv6Buzh3uJ9wSepORsS71L47P1K7/frf4EE7EF2LdLpumG+tOYAnw/
         +EiNXSa2G+UgzW3qGXbR4Hy8ymb00RuYI/bnnYqclLAOMP9OvINx7qDsKX/H/wdYfsdq
         UfOhI0kMwMgKrRR0/Fo/MlBDabnPoiAIW0emkgQzMgCXoxHQPZWpzKqxYzxvqjVQy0uI
         XIrcACAly87+y4Hv9drwKaAeCJvxEkNU+6jDkD4WuaT603TF9s9kd9CFYhFpGfHWvJM+
         MxX7SavPeRW2ce/leXXmNiVwL2DOEwLxvqG7VkKjVst14a/52sbNi6NU1hfbcA9F+t3K
         uJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/PeJVlToLa1AacmOxRQ0TpLQRbNG2pegJQFcYVFHfwE=;
        b=6ZN/Ji1yY7hqhshIQYLnZhYrjAVoU3zqG1QsWR3ydTGfsBo51py+Jl3Z6xoRTdVFSp
         YBb3w2YmBFm+1xxPjc4s769GiRSTP3h5C4YUVBghvq1F74orKTxsMfKv1IzybEvuobfB
         +C9BvJMcUY+iKdqCF2bQtvnq4bE7AmL2PXTszxuei0h1wygrfHAIFd92Q2RHLUQpYnvG
         WuZr+4n/vt8fsA6LcaCO3w7FoX2Mej2sjwtbHpKO/Y0ScuDEbgyW8QnQk/ngo8ptyxK4
         OTo/QdGcUpLHKFj8qg2j1Pn+CqDk/G6WqTFKv1+ptqeUPNEm5qQfZ/VlIyjJYWbfq4KR
         FK1w==
X-Gm-Message-State: AOAM531YosQ0YIf0PKXVq4RiRZhdyxFs97FDgAB9KLMbxFqRhB/B/ApF
        Q0RifR3Yu8sYaDS2lTmMRlQ=
X-Google-Smtp-Source: ABdhPJxDyB5GjySUbUIf3kS+HME+9jaZplUV4P61rQq9wRig4aYmMcxjzPmMiegOREEJ3Scx1FGN0A==
X-Received: by 2002:a63:874a:: with SMTP id i71mr3728462pge.581.1644448803469;
        Wed, 09 Feb 2022 15:20:03 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:500::2:9eba])
        by smtp.gmail.com with ESMTPSA id d84sm697845pfd.164.2022.02.09.15.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 15:20:02 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 bpf-next 0/5] bpf: Light skeleton for the kernel.
Date:   Wed,  9 Feb 2022 15:19:56 -0800
Message-Id: <20220209232001.27490-1-alexei.starovoitov@gmail.com>
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

v3->v4:
- inlined skel_prep_init_value() as direct assignment in lskel

v2->v3:
- dropped vm_mmap() and switched to bpf_loader_ctx->flags & KERNEL approach.
  It allows bpf_preload.ko to be built-in.
  The kernel is able to load bpf progs before init process starts.
- added comments (Yonghong's review)
- added error checks in lskel (Andrii's review)
- added Acks in all but 2nd patch.

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
 kernel/bpf/preload/Kconfig                    |   7 +-
 kernel/bpf/preload/Makefile                   |  14 +-
 kernel/bpf/preload/bpf_preload.h              |   8 +-
 kernel/bpf/preload/bpf_preload_kern.c         | 119 +++++------
 kernel/bpf/preload/bpf_preload_umd_blob.S     |   7 -
 .../preload/iterators/bpf_preload_common.h    |  13 --
 kernel/bpf/preload/iterators/iterators.c      | 108 ----------
 .../bpf/preload/iterators/iterators.lskel.h   | 141 +++++++------
 kernel/bpf/syscall.c                          |  40 +++-
 tools/bpf/bpftool/gen.c                       |  39 ++--
 tools/lib/bpf/gen_loader.c                    |  15 +-
 tools/lib/bpf/skel_internal.h                 | 185 ++++++++++++++++--
 13 files changed, 372 insertions(+), 363 deletions(-)
 delete mode 100644 kernel/bpf/preload/bpf_preload_umd_blob.S
 delete mode 100644 kernel/bpf/preload/iterators/bpf_preload_common.h
 delete mode 100644 kernel/bpf/preload/iterators/iterators.c

-- 
2.30.2

