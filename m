Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3385032014F
	for <lists+bpf@lfdr.de>; Fri, 19 Feb 2021 23:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBSWWw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Feb 2021 17:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhBSWWv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Feb 2021 17:22:51 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19FEC061574
        for <bpf@vger.kernel.org>; Fri, 19 Feb 2021 14:22:11 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 80so6521191oty.2
        for <bpf@vger.kernel.org>; Fri, 19 Feb 2021 14:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CB8jjmzUklgL4yCDZPJKhg97BcBm0f8cSRpwfvYaXZY=;
        b=a+msYBr8Cdv35+xM6lv4DB+c5PmCDWO2VbJRvdGpDJOVD1Fi8ogTPvCK8CBT41gRVq
         kfAFlE1yMMEq+blBWca/ISyNWv4P5bhuH0c1XNVTbvHoDOyLI2THrUAj+KoxTm203g4s
         N4pBWkeOl1mkW90FW8ewiKamVqLhFsKKdO7dMWs6LhQmYGUyuJCRiPeA27SqR+EJ84Rc
         o51tsd/+niPFSWMMEy2kUpqcIbhHwRwc97OJMeYr/7lob9tPF83hfL/hCwmE+/C4p4Ht
         AaR8XhlGGdXzw8uGs01EhAq+CzfYL4AuAzRFizmHiJOemJB7hoCjRUYn/UMGXoIYOciR
         xz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CB8jjmzUklgL4yCDZPJKhg97BcBm0f8cSRpwfvYaXZY=;
        b=t8w1Q5KkGEwqVu1+EHW+xiHp28FeaD83fFi11upVpJk0wpZ0QslRuGnRObiQ/CUBI4
         8HeFaOIjBolFmorigUef/fGlO1S8PykY4pb/Ou8ryJbY5UmemoNDKDu1G0d08FBTKotT
         QY1fuuR03/bBKXcQHwyNi07YwJ0NZh4gJoOrnxNuahZ/HRygBTVMsqJmXbGfmflxU08T
         XlP9FD2IDQPSgEPWMStadQqtaQYgC8XDvyaYky2+0X/YijrdA2YXlq8PVOqY3Ln4qKgg
         z+yiaqQZv4h4dyc6hyM2vBS3qhgedPXNGdwL1xeH62nXRx5B+wW/aduu8jchrYpggd6Z
         V8hg==
X-Gm-Message-State: AOAM533T0wrmXD3sAuUCLiZHq49rXnqSWIXLkKSa1hFvaboNnvz4ZMnZ
        5rX0yvMX0OB1x/nrTk6b1rs=
X-Google-Smtp-Source: ABdhPJxvSRXYBfHoFjXKSOi1syy8b78wphPIzHcZssZR45KpxwonQx85XRpWzrVzX3E9JdLOONXOVg==
X-Received: by 2002:a05:6830:902:: with SMTP id v2mr8683174ott.56.1613773331041;
        Fri, 19 Feb 2021 14:22:11 -0800 (PST)
Received: from localhost.localdomain (162-198-41-83.lightspeed.wepbfl.sbcglobal.net. [162.198.41.83])
        by smtp.gmail.com with ESMTPSA id z30sm1977291otj.61.2021.02.19.14.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 14:22:10 -0800 (PST)
From:   grantseltzer <grantseltzer@gmail.com>
To:     andrii@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org
Cc:     bpf@vger.kernel.org, grantseltzer <grantseltzer@gmail.com>
Subject: [PATCH] add CONFIG_DEBUG_INFO_BTF check to bpftool feature command
Date:   Fri, 19 Feb 2021 22:21:35 +0000
Message-Id: <20210219222135.62118-1-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Signed-off-by: grantseltzer <grantseltzer@gmail.com>
---
 tools/bpf/bpftool/feature.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 359960a8f..34343e7fa 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -336,6 +336,8 @@ static void probe_kernel_image_config(const char *define_prefix)
 		{ "CONFIG_BPF_JIT", },
 		/* Avoid compiling eBPF interpreter (use JIT only) */
 		{ "CONFIG_BPF_JIT_ALWAYS_ON", },
+		/* Enable using BTF debug information */
+		{ "CONFIG_DEBUG_INFO_BTF", },
 
 		/* cgroups */
 		{ "CONFIG_CGROUPS", },
-- 
2.29.2

