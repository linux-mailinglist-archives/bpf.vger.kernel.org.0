Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DF04AE982
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 06:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbiBIFqN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 00:46:13 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbiBIFnT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 00:43:19 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F78C033254
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 21:43:18 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id qe15so1201849pjb.3
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 21:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9nLDCQ80z4+JhzlN4J0+C0ugWJ8hqgMXykPNhAZKjc=;
        b=p7ZX4a4RmbRPa3YBJk4VH6+h+MdIjnAtw13FrAwsz6YxKn8IGjbtJ6t6JMPh0csvDP
         rW/0r7PMijIjiLEEGgp64qL5F9IZfnNbX0BpE6aNCsnPLhagBeMZVwklk2Q+q2dMJFHG
         FuiJL0OknYWQ1GHsynhyOcCrXIsz8VRsTLVk6TZHtkw80+LfExL+UE5W40FBwf82VsdW
         L3RUGm3EygeO+EvUVB+JuwMQ7+lKucDyQ62E3X+7PCnms5LIYuu0OMZMT7R3A8LdenGJ
         C/nf1vXiw+zxUZt6jfWAjLMWrNJyp2FiOR52B1RqBDDZm0l4SkPWmUEWuBUJq1mtKshG
         YA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9nLDCQ80z4+JhzlN4J0+C0ugWJ8hqgMXykPNhAZKjc=;
        b=0HJTCzBTDAGw31Y/nMgeozK6CYckcfEz+9H6WDeOBdTDwk5Ll5P/4nH45Po1BlINXN
         9/5m20VXO71cSwMQ+tcvhzIaXOoEY8SiKsfZmJPWMAIC49+8owbDd43P7AuNobDdHGYP
         S5lHlSwfqsCUWqzpxaaG9Sj+0ZmY1VnjQ7V8mtu6i58dnshJnD9ZdXt+eFJt0IR+lxUh
         wR2iUupr2MVEKVUXY3rK+KtjIwAedpzBz09xNsr7pYMKpqAPvS1Y3dx53e9XdwjwTHzw
         1K1taUPqnU+xKhRUcM8tBa+df5M1Tig3OabC2RqZMHhJLdvEN/m9tI8B3M+Z8j30hLRw
         +OBw==
X-Gm-Message-State: AOAM533zcQT1yIPOlHoZ07yjY5/zeSyfd9a8dZaBVIeEACIJkvqf154B
        wAHIukjPiItNgkMf1AT1vCU20xuvvfc=
X-Google-Smtp-Source: ABdhPJy6rLWE3imTJAXE6vkRprWiUKN5SflVdBeF9uZOrONp7Ko0Qm44yDpeiRV1ekMtMFoHWmT8Fg==
X-Received: by 2002:a17:90a:7e15:: with SMTP id i21mr1672344pjl.74.1644385397394;
        Tue, 08 Feb 2022 21:43:17 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:cbf])
        by smtp.gmail.com with ESMTPSA id u12sm18759538pfk.220.2022.02.08.21.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 21:43:17 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 bpf-next 0/5] bpf: Light skeleton for the kernel.
Date:   Tue,  8 Feb 2022 21:43:10 -0800
Message-Id: <20220209054315.73833-1-alexei.starovoitov@gmail.com>
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
 .../bpf/preload/iterators/iterators.lskel.h   | 144 ++++++-------
 kernel/bpf/syscall.c                          |  40 +++-
 tools/bpf/bpftool/gen.c                       |  55 +++--
 tools/lib/bpf/gen_loader.c                    |  15 +-
 tools/lib/bpf/skel_internal.h                 | 195 ++++++++++++++++--
 13 files changed, 402 insertions(+), 362 deletions(-)
 delete mode 100644 kernel/bpf/preload/bpf_preload_umd_blob.S
 delete mode 100644 kernel/bpf/preload/iterators/bpf_preload_common.h
 delete mode 100644 kernel/bpf/preload/iterators/iterators.c

-- 
2.30.2

