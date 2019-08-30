Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53962A2BC8
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2019 02:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfH3AvH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Aug 2019 20:51:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45447 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbfH3Auz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Aug 2019 20:50:55 -0400
Received: by mail-lf1-f66.google.com with SMTP id r134so3075903lff.12
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2019 17:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rseUd9y/GnXjRY8PsudxS8BEzI5o7BH/gE6GzGNAkz0=;
        b=p+c78cGOyUo6huk/pdHK4LHWxY05E5DmCBl6Y9TnX0wvtYNQzK7/aTvz75AqmlPGvA
         lX3zJWWhAuFN7kMzRbIe4MIRTgqe2XNObWdcxwvAYdo9v+NHqraV4ztUXFoSctAfudEb
         6iWjcDghz5Lkpmgx4rrpBe3K+94vUyybq7SVTJP0KvecAGtDjApjNEeFXlxu6wHYQ2nG
         Aia65Ra96zxOxrfifKlzHZK+MklKrHz3P1CXW6V1T+wu0gkWFEF3j5zl9WfXVvgh/7Iz
         tX+fup/gKLffQChanaOEXwwKRLJP/Zl4iC0qpnp9r8NCvX0yAmZFBiQuq5bIQpJinAgf
         23aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rseUd9y/GnXjRY8PsudxS8BEzI5o7BH/gE6GzGNAkz0=;
        b=VeK67xiR06+2VCmSzGLQOS6Rln7iSvxNOIQaN3ap9BSaSKg/i48scOA8AZiK1rcRtx
         LnHhCOrWXowRaufy35SOWlYydMEyZ51ycX+cL333FKtiBSb86pg7Xbi40Ak6gfALDfNi
         dRr94i72Ons/Pd9qfyQKdOudhkyMubrZNzoJlrq6FA88VuILYMgwD6yFxzNobv5fO4mx
         Ttu/EOFgE3ETmW8Uwm5hLgiMPp5ERvqEyUW+E9kXAflPwhSkEJ9PkbzfUVrQHYcZaQHB
         6rXxaVRJ6ygsPdYES8X7m62/NHdMDQ7Ut0LynY93Zez1n911z4WSUEnbvS94WtCCCvb0
         6Osw==
X-Gm-Message-State: APjAAAUjI0OsUj5mF5mkyCBvKzOWq70QHkWKsQOm/6roGe30LLkOxhuh
        f/iS0AJstjmWmphYcjvgv1vVvQ==
X-Google-Smtp-Source: APXvYqxNrtZrcEGcDIoDRzM60F5kluGphxsbk/1Bx4tLv8SvOizz47bOc1wno61j8h21RjFX5zUA3A==
X-Received: by 2002:a19:e04f:: with SMTP id g15mr7384740lfj.46.1567126253185;
        Thu, 29 Aug 2019 17:50:53 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id f19sm628149lfk.43.2019.08.29.17.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 17:50:52 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     linux@armlinux.org.uk, ast@kernel.org, daniel@iogearbox.net,
        yhs@fb.com, davem@davemloft.net, jakub.kicinski@netronome.com,
        hawk@kernel.org, john.fastabend@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH RFC bpf-next 09/10] arm: include: asm: swab: mask rev16 instruction for clang
Date:   Fri, 30 Aug 2019 03:50:36 +0300
Message-Id: <20190830005037.24004-10-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830005037.24004-1-ivan.khoronzhuk@linaro.org>
References: <20190830005037.24004-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The samples/bpf with clang -emit-llvm reuses linux headers to build
bpf samples, and this w/a only for samples (samples/bpf/Makefile
CLANG-bpf).

It allows to build samples/bpf for arm bpf using clang.
In another way clang -emit-llvm generates errors like:

CLANG-bpf  samples/bpf/tc_l2_redirect_kern.o
<inline asm>:1:2: error: invalid register/token name
rev16 r3, r0

This decision is arguable, probably there is another way, but
it doesn't have impact on samples/bpf, so it's easier just ignore
it for clang, at least for now.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 arch/arm/include/asm/swab.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/swab.h b/arch/arm/include/asm/swab.h
index c6051823048b..a9fd9cd33d5e 100644
--- a/arch/arm/include/asm/swab.h
+++ b/arch/arm/include/asm/swab.h
@@ -25,8 +25,11 @@ static inline __attribute_const__ __u32 __arch_swahb32(__u32 x)
 	__asm__ ("rev16 %0, %1" : "=r" (x) : "r" (x));
 	return x;
 }
+
+#ifndef __clang__
 #define __arch_swahb32 __arch_swahb32
 #define __arch_swab16(x) ((__u16)__arch_swahb32(x))
+#endif
 
 static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
 {
-- 
2.17.1

