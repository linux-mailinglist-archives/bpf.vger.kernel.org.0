Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92053425558
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 16:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242029AbhJGO0K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 10:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242006AbhJGO0J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 10:26:09 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8C0C061746
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 07:24:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y12so10327778eda.4
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 07:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B6vmYD6+ICi1neadqa+gL/UPoAFar0m9iXwg+MUKPe4=;
        b=Phjs2REo2zV9+Isw3WdoK0cSTIqwNWMR8nBvmVMu0YtFcChySx2wGQz4nnBuRiphTJ
         BQHgSu9TXJWSRvBTzYg+fzATpPAAcuCsHbT2jbnMV7y4lb1PgjwiOPP55XCwtvGvKowM
         tFhrvislNX0u2AQO5v7zNuS5cPKcyM5cgq7jj/quVwOobBnNYAxqKD6zj2YzcNbSSgp2
         QrwM75WQkVVEY6yO4/j2xG6mfN8SRoaq+vcyFweptAUpgM8wW8Zne7un0IC7Yko7pcWv
         06RfA/ZLK2Z1sNb//Wqb0HGmgHECRke0f7gXKEFhD75bfzGA6QqYlTHyekEV44nl8jbf
         MXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B6vmYD6+ICi1neadqa+gL/UPoAFar0m9iXwg+MUKPe4=;
        b=WcOJJP+i+L5G6cr1Uj+U8i7OzH+DXbqMZG6iko0K8xGeVRj3tAPaTucAELgbMVHsQo
         d0jpUFR/0D/USW5YPnHKf5dzwiOvdDaCjpB9kVYb4hUJ/nliKlpNWkMD2yRUgxCoybU5
         QL/DoHTxJdkXu1heow47rtP1ve78vmi2nBQrC84QZ8a8EkJn5b3EjfP69mbQ1IZsq2A0
         gI3BkILKyO5+1EaMfYCGGTbQ/00bPEWNzZ7ldhJsfBu8YJ2+OWJ53nFDow9TYb8jGiuR
         dbMK7S8smH8bcTDgzlLWdHJbBncJDxy22Wrmn5BHV6vWQKss0/gwrba9ydLV7agKjfkS
         SPeg==
X-Gm-Message-State: AOAM532tumHLb5ZwuPORvamZkd8vf6z1ggnOoe/OdxCcR2TNGuprTQYb
        NdRcSDJLrL9KCGKkXjt5SOskkA==
X-Google-Smtp-Source: ABdhPJylKK8xTutG9pv1TVWtqFx5gnnwI2eu2jsgGkaHu/K5+ooHIropO6OIH+FIxYqLMEHJP0/xcA==
X-Received: by 2002:a50:cf02:: with SMTP id c2mr6744434edk.325.1633616653200;
        Thu, 07 Oct 2021 07:24:13 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id bx11sm10526987ejb.107.2021.10.07.07.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 07:24:12 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        paulburton@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        tony.ambardar@gmail.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next] mips, bpf: Fix Makefile that referenced a removed file
Date:   Thu,  7 Oct 2021 16:23:39 +0200
Message-Id: <20211007142339.633899-1-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch removes a stale Makefile reference to the cBPF JIT that was
removed.

Fixes: 06b339fe5450 ("mips, bpf: Remove old BPF JIT implementations")
Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 arch/mips/net/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/net/Makefile b/arch/mips/net/Makefile
index 602bf242b13f..95e826781dbc 100644
--- a/arch/mips/net/Makefile
+++ b/arch/mips/net/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 # MIPS networking code
 
-obj-$(CONFIG_MIPS_CBPF_JIT) += bpf_jit.o bpf_jit_asm.o
 obj-$(CONFIG_MIPS_EBPF_JIT) += bpf_jit_comp.o
 
 ifeq ($(CONFIG_32BIT),y)
-- 
2.30.2

