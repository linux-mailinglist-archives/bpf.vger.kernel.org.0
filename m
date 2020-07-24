Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704DC22C1A1
	for <lists+bpf@lfdr.de>; Fri, 24 Jul 2020 11:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgGXJGn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jul 2020 05:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgGXJGm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jul 2020 05:06:42 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231E7C0619D3
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2020 02:06:41 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t142so1210130wmt.4
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2020 02:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GKVJys15g3u/YKtwc9L0yZgVW6hScrCMx0azVfWiPc4=;
        b=XMCJbv0C6jPPPJ3GsMp/UwRxhK7HLwNcPU4KACk1wP03/BGWyKM0q49zlbosAajUoq
         Ezy/FhobjjtIopFsBZC/CRQEc65dFWakhxndATkLNhVunsX59FszzIsmoJjvvsMmEwJ2
         m6K4QBTB4jrKAtaMqSE6wp02Yv4wXHwqFCpqH4iGAlwYuJBgnq/5oKu7HWt/6xU7p8mv
         e/h9ESAjb9Jbd2S36dOy7aY5f4iDsNcJAN2rcaiqaQLiIHUi/a6ZNWve7/lcvUwza1bY
         +G4DeWVWcPRUpEF9avCoLX73PHb+e3qcIBfEmFBwdwMk/Px4K7h5k91BRudkcOVFIBjt
         hMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GKVJys15g3u/YKtwc9L0yZgVW6hScrCMx0azVfWiPc4=;
        b=EzNFCa1oaNO1ZJKXsoNYfUIObgfmMRNAvUV8dPXDlel2yhfMZS0+MY0mXt7QGPDvJV
         bH3LnBwNWxmAFROyvYdOC3hzv7agXuA2bwTeQxz70YTpflatxOmoY3bayw5SqUkyOsx0
         2VFhDqJVJDYWskFbVRSgy9FIeHaUJsCDk36L+6jZ5F+vZClyicI3JH22yfC14wsrf4ko
         wF2a+cu7mT1mI88IIa4z3r6xPQFfHqeoXEx5c6yoRjY2sidGBeXDqNGAQURzqAe10qfS
         0AF7E23p1vfi5JiK5r6tHblx00y2lqY8s4xN5WvCFDGgBnCh0bGUsvpEpuc8azgRpbkG
         lX2g==
X-Gm-Message-State: AOAM53279RN8AE1ICOHVQFfGvWpOAyynQKjxub9MXSXOiirBThwXEQ5S
        +kD9U4cP1v1rIFtV0RZspAX2yA==
X-Google-Smtp-Source: ABdhPJwzFR/1IwAyTe5ZwMTdZv3fdjYVZg12eQLNXCXJRylXdo1ZEPysLjeoxioWQp1AczKegZ0UQQ==
X-Received: by 2002:a1c:3142:: with SMTP id x63mr7558652wmx.62.1595581599822;
        Fri, 24 Jul 2020 02:06:39 -0700 (PDT)
Received: from localhost.localdomain ([194.35.117.75])
        by smtp.gmail.com with ESMTPSA id t11sm527915wrs.66.2020.07.24.02.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 02:06:39 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Paul Chaignon <paul@cilium.io>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 2/2] tools: bpftool: add LSM type to array of prog names
Date:   Fri, 24 Jul 2020 10:06:18 +0100
Message-Id: <20200724090618.16378-3-quentin@isovalent.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200724090618.16378-1-quentin@isovalent.com>
References: <20200724090618.16378-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Assign "lsm" as a printed name for BPF_PROG_TYPE_LSM in bpftool, so that
it can use it when listing programs loaded on the system or when probing
features.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/prog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 3e6ecc6332e2..158995d853b0 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -59,6 +59,7 @@ const char * const prog_type_name[] = {
 	[BPF_PROG_TYPE_TRACING]			= "tracing",
 	[BPF_PROG_TYPE_STRUCT_OPS]		= "struct_ops",
 	[BPF_PROG_TYPE_EXT]			= "ext",
+	[BPF_PROG_TYPE_LSM]			= "lsm",
 	[BPF_PROG_TYPE_SK_LOOKUP]		= "sk_lookup",
 };
 
-- 
2.20.1

