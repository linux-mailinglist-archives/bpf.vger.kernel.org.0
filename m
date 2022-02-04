Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670B44AA424
	for <lists+bpf@lfdr.de>; Sat,  5 Feb 2022 00:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbiBDXRO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 18:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378005AbiBDXRO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 18:17:14 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCC9DFDA6C9
        for <bpf@vger.kernel.org>; Fri,  4 Feb 2022 15:17:13 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id h23so6202424pgk.11
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 15:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CemGCHJn+iwxXFmAuU26RYpZWojHa0/OsOw2dHhUAwQ=;
        b=EDIcGSK2mNjN3asrCvawwLD8E+EL/B8i5jpCoEGb9tPZK8LMo1mlCYMMa6hmSQulkV
         +QFWxrP2AUpTvfXLMS6Xx1sCaCMnx1T+YDsNY04OMZAxguDID20JbHBzp8SIG2MPOKRg
         fo3yjI2LnMEo5LYpE3xJ9GEne5QpTTlwnFVGq+oPKAUo/GIhaMCk0P7dlZlNBGxaZn2L
         BIJDljCyILWFQXA7jakywqCY5zZrnNYHoADS5VWMcoOc8F0y/MQO3qpjRbotkDsU6rm2
         P023JxR0F80vCy1jevgSHaNeYpk99fI1BGIo9evR4mw2gCypm7GN+uyqa/nZ44GM+rnA
         oijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CemGCHJn+iwxXFmAuU26RYpZWojHa0/OsOw2dHhUAwQ=;
        b=7c80vcHi8aFJnPhhtsjHMOoKNKdlD+/J+gb3bD551jGYsQdkFyxFhoNpgMhjg2EF3X
         1A/KQMo/Z0NxzE3LocEffQWMd9n7+W9j9D323dVERKKXNRErU87xb0Vkor9X0X6qofKM
         IhKKjlBzIerSb9O/s9oW4cIvT6cGZdD/UYxtpJLwDRCejaO2sgtEw4OM/hQIh4Lv1hpL
         L4Omlgcn2K9H48H7JAFfUOYfrXjDIm5ebkvkk0KicQAuwXVFt/0KkgA7GH0iKCR2j/tx
         n1Sp4xD2Qc430f48n4i+Ji37ff9c+DpLvU8OUY05yUykQuSDo6iJGBgEB1SGUpkxV1rP
         EJSA==
X-Gm-Message-State: AOAM533e4DukdrO+37wiL31+4afJV91EHQB3NFgmuzCCgd+mehMNQLtI
        1iAbjvsh8a+HArP6f9bfC1o=
X-Google-Smtp-Source: ABdhPJxs7LxapaJ8TYEopKb277mxmrsifB2LKXuaNdNTZYe2Fd4GKat4WCY7gWa+dBlHvIJBJhJ5kg==
X-Received: by 2002:a63:9143:: with SMTP id l64mr1073755pge.142.1644016632689;
        Fri, 04 Feb 2022 15:17:12 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:e4ee])
        by smtp.gmail.com with ESMTPSA id lw10sm1929709pjb.28.2022.02.04.15.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:17:12 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH bpf-next 0/5] bpf: Light skeleton for the kernel.
Date:   Fri,  4 Feb 2022 15:17:05 -0800
Message-Id: <20220204231710.25139-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Alexei Starovoitov (5):
  bpf: Extend sys_bpf commands for bpf_syscall programs.
  libbpf: Prepare light skeleton for the kernel.
  bpftool: Generalize light skeleton generation.
  bpf: Update iterators.lskel.h.
  bpf: Convert bpf_preload.ko to use light skeleton.

 kernel/bpf/inode.c                            |  39 ++--
 kernel/bpf/preload/Kconfig                    |   9 +-
 kernel/bpf/preload/Makefile                   |  14 +-
 kernel/bpf/preload/bpf_preload.h              |   8 +-
 kernel/bpf/preload/bpf_preload_kern.c         | 119 +++++--------
 kernel/bpf/preload/bpf_preload_umd_blob.S     |   7 -
 .../preload/iterators/bpf_preload_common.h    |  13 --
 kernel/bpf/preload/iterators/iterators.c      | 108 -----------
 .../bpf/preload/iterators/iterators.lskel.h   |  28 ++-
 kernel/bpf/syscall.c                          |  40 ++++-
 tools/bpf/bpftool/gen.c                       |  45 +++--
 tools/lib/bpf/skel_internal.h                 | 168 ++++++++++++++++--
 12 files changed, 296 insertions(+), 302 deletions(-)
 delete mode 100644 kernel/bpf/preload/bpf_preload_umd_blob.S
 delete mode 100644 kernel/bpf/preload/iterators/bpf_preload_common.h
 delete mode 100644 kernel/bpf/preload/iterators/iterators.c

-- 
2.30.2

