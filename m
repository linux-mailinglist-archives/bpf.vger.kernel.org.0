Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C666B4BF63F
	for <lists+bpf@lfdr.de>; Tue, 22 Feb 2022 11:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiBVKkS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Feb 2022 05:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiBVKkN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Feb 2022 05:40:13 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7572C15AF09
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 02:39:44 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s24so29387114edr.5
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 02:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vSWl+uOEl63jvuuhy3nVJsLd9KRgIYTBclYyLWwWqvo=;
        b=yFDyIQ7tHhn+3ZRXa2U5vrWF9Hq4Jfhu2i4n+HlctM7YBMOJhEMCpzvEVqzPU1X+uc
         Tkyl6p+M4WVCtYKhbutfa5VG/anzXJ6fe1Wtml4bxI0+O0QryNdDwJOmdPJz4Jpwzmcn
         02QZll8FtrF7xon/HYpBxlthe+Q7UOrROQjGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vSWl+uOEl63jvuuhy3nVJsLd9KRgIYTBclYyLWwWqvo=;
        b=Csg86HUrQl/CHD4KHKuY+zoAo6INmkergf8znDQHHn536nX28M9CRQGQ9M45vIrelu
         9qpyBPCByUXw/z23Fjb9ute172an4P1WGd7bD3pM7jt3Lgnq7/WToNDrAE6PN3LRlXNM
         602lF3ZmJblJsGJQbQFpqAxinPsLT3TZHAKJVqkSfui3sr4IPV5miWpMHPjQeoLk72+q
         YSyQlY9lX+dxGTokpWDb2lJjaX7jO1QCV1VTZlTIha7bc2PFkrbGOhHqUhuQC/gugIaq
         EIfFHpTeYJfEN38T7uPzdgC4+UlwjtfXhCeexVMIke+rBnv2Ty04ozD2C92VJMmG+MSV
         pPLA==
X-Gm-Message-State: AOAM530JbLs0xl61DzztZI2v5r1GVoPLmKzmzoNtsH/02fthXTt4eK83
        XsFH7OAhCmU7pTTBDpuGmKHHKRHDwCGvAA==
X-Google-Smtp-Source: ABdhPJz0SHPZrfQdVmDqqpde10UtSYWp5Acbw5iRJCLDnl4+7cZ15j3lHXZNdBMgiAAhsVV4mmi+WA==
X-Received: by 2002:aa7:d415:0:b0:410:a0fa:dc40 with SMTP id z21-20020aa7d415000000b00410a0fadc40mr25610381edq.46.1645526383048;
        Tue, 22 Feb 2022 02:39:43 -0800 (PST)
Received: from altair.lan (7.e.a.a.9.9.f.b.0.5.5.2.a.2.1.a.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:a12a:2550:bf99:aae7])
        by smtp.googlemail.com with ESMTPSA id p4sm6144203ejm.47.2022.02.22.02.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 02:39:42 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH 1/2] bpf: remove Lorenz Bauer from L7 BPF maintainers
Date:   Tue, 22 Feb 2022 10:39:24 +0000
Message-Id: <20220222103925.25802-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220222103925.25802-1-lmb@cloudflare.com>
References: <20220222103925.25802-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'm leaving my position at Cloudflare and therefore won't have the
necessary time and insight to maintain the sockmap code. It's in
more capable hands with Jakub anyways.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 65f5043ae48d..9d27fe05f23e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10762,7 +10762,6 @@ L7 BPF FRAMEWORK
 M:	John Fastabend <john.fastabend@gmail.com>
 M:	Daniel Borkmann <daniel@iogearbox.net>
 M:	Jakub Sitnicki <jakub@cloudflare.com>
-M:	Lorenz Bauer <lmb@cloudflare.com>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Maintained
-- 
2.32.0

