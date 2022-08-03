Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BDC588F2A
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 17:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbiHCPOS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 11:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbiHCPOR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 11:14:17 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F47D2A948;
        Wed,  3 Aug 2022 08:14:17 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id b12so7914122ils.9;
        Wed, 03 Aug 2022 08:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=+eg48Gqjxnl7qAw9rfss7ig1UaZHXSb7kMN4rECN/MA=;
        b=UeeDIRUKUlOmqhSfgPa0csQ1j/DmWP96LD08BcfaGtqsIiveCz55emN89+loAlaYsf
         q8Kgq8TVBAtEMjBTed4D1z0eInYAxl1Ss0GCUBdoFwlXfONbHcLvBjqv2teSQV9mbQ3Y
         GBc0TDc8gH+n+dorSzQODxdYOEkhn+pNu0jUoFWPsuOEn1IyBOl9IDtUj6hd6M18YMSq
         ++p3WcTqYnUGSd/w43xR2yHqRhMzZ0qDRVKm9E19uopZuTYpXnaGjGftMCx5OTt8lpgj
         pG8LbksnoSvxTNxFqcpUv6m2GxvUuyTDzUZsIKsBZRwfIM9RPf5VvNnq62EcbT/gPcP1
         d5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=+eg48Gqjxnl7qAw9rfss7ig1UaZHXSb7kMN4rECN/MA=;
        b=eKNmLgLen0BY24Qd6r9Sgnjr/7ynlcN96Uts1W72F4PCJOLrAp8VsgtK+WuQgraeJY
         SdbBZLi4XNrWf5vXWHC4fJLVxOAJkGCTw5UIQA5DIE41BQ/SekYHe7aYWVKPjaW1YPKh
         eTIwEqp/PGFjTA4Ltf7LehxShcpy9FOuOeSIa4Zy2sfQU6x2CR2XkjHMTQuhHiVWndLi
         1et0mR9bdyZZu8GvQ504oSq8ZsienDuSCYS7BMHl/6UfdgO64mwY4i3hbOmD8MZpRcsC
         cKpUkr6Tw8boK1gGb8KJACEXxoKO2JuMRiOh3QRZ2nwWSZwe+SOGGLshoeHatdSIMPXl
         jA8Q==
X-Gm-Message-State: ACgBeo21KbORxnW4esSol9riA1KpxyAQCXmdVPJkfEiHWaSk4A0wy1hz
        OX1C6UTikQiBMnUYcTjXpi0LWgodINvVPg==
X-Google-Smtp-Source: AA6agR4wVa18LniMwhjSzusYlgSfwRwyAlvXsA+sg3vu6a6iCWg7ZrPlP01eWxHAfqLn9nLjEmn6eg==
X-Received: by 2002:a05:6e02:1410:b0:2de:6e34:e08e with SMTP id n16-20020a056e02141000b002de6e34e08emr7479929ilo.157.1659539655874;
        Wed, 03 Aug 2022 08:14:15 -0700 (PDT)
Received: from james-x399.localdomain (71-33-138-207.hlrn.qwest.net. [71.33.138.207])
        by smtp.gmail.com with ESMTPSA id cx10-20020a056638490a00b0034142dad202sm619062jab.31.2022.08.03.08.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 08:14:15 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     bpf@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] libbpf: ensure functions with always_inline attribute are inline
Date:   Wed,  3 Aug 2022 09:14:03 -0600
Message-Id: <20220803151403.793024-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

GCC expects the always_inline attribute to only be set on inline
functions, as such we should make all functions with this attribute
use the __always_inline macro which makes the function inline and
sets the attribute.

Fixes errors like:
/home/buildroot/bpf-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_tracing.h:439:1: error: ‘always_inline’ function might not be inlinable [-Werror=attributes]
  439 | ____##name(unsigned long long *ctx, ##args)
      | ^~~~

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - use __always_inline macro
---
 tools/lib/bpf/bpf_tracing.h | 14 +++++++-------
 tools/lib/bpf/usdt.bpf.h    |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 43ca3aff2292..5fdb93da423b 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -426,7 +426,7 @@ struct pt_regs;
  */
 #define BPF_PROG(name, args...)						    \
 name(unsigned long long *ctx);						    \
-static __attribute__((always_inline)) typeof(name(0))			    \
+static __always_inline typeof(name(0))					    \
 ____##name(unsigned long long *ctx, ##args);				    \
 typeof(name(0)) name(unsigned long long *ctx)				    \
 {									    \
@@ -435,7 +435,7 @@ typeof(name(0)) name(unsigned long long *ctx)				    \
 	return ____##name(___bpf_ctx_cast(args));			    \
 	_Pragma("GCC diagnostic pop")					    \
 }									    \
-static __attribute__((always_inline)) typeof(name(0))			    \
+static __always_inline typeof(name(0))					    \
 ____##name(unsigned long long *ctx, ##args)
 
 struct pt_regs;
@@ -460,7 +460,7 @@ struct pt_regs;
  */
 #define BPF_KPROBE(name, args...)					    \
 name(struct pt_regs *ctx);						    \
-static __attribute__((always_inline)) typeof(name(0))			    \
+static __always_inline typeof(name(0))					    \
 ____##name(struct pt_regs *ctx, ##args);				    \
 typeof(name(0)) name(struct pt_regs *ctx)				    \
 {									    \
@@ -469,7 +469,7 @@ typeof(name(0)) name(struct pt_regs *ctx)				    \
 	return ____##name(___bpf_kprobe_args(args));			    \
 	_Pragma("GCC diagnostic pop")					    \
 }									    \
-static __attribute__((always_inline)) typeof(name(0))			    \
+static __always_inline typeof(name(0))					    \
 ____##name(struct pt_regs *ctx, ##args)
 
 #define ___bpf_kretprobe_args0()       ctx
@@ -484,7 +484,7 @@ ____##name(struct pt_regs *ctx, ##args)
  */
 #define BPF_KRETPROBE(name, args...)					    \
 name(struct pt_regs *ctx);						    \
-static __attribute__((always_inline)) typeof(name(0))			    \
+static __always_inline typeof(name(0))					    \
 ____##name(struct pt_regs *ctx, ##args);				    \
 typeof(name(0)) name(struct pt_regs *ctx)				    \
 {									    \
@@ -540,7 +540,7 @@ static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
 #define BPF_KSYSCALL(name, args...)					    \
 name(struct pt_regs *ctx);						    \
 extern _Bool LINUX_HAS_SYSCALL_WRAPPER __kconfig;			    \
-static __attribute__((always_inline)) typeof(name(0))			    \
+static __always_inline typeof(name(0))					    \
 ____##name(struct pt_regs *ctx, ##args);				    \
 typeof(name(0)) name(struct pt_regs *ctx)				    \
 {									    \
@@ -555,7 +555,7 @@ typeof(name(0)) name(struct pt_regs *ctx)				    \
 		return ____##name(___bpf_syscall_args(args));		    \
 	_Pragma("GCC diagnostic pop")					    \
 }									    \
-static __attribute__((always_inline)) typeof(name(0))			    \
+static __always_inline typeof(name(0))					    \
 ____##name(struct pt_regs *ctx, ##args)
 
 #define BPF_KPROBE_SYSCALL BPF_KSYSCALL
diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
index 4f2adc0bd6ca..fdfd235e52c4 100644
--- a/tools/lib/bpf/usdt.bpf.h
+++ b/tools/lib/bpf/usdt.bpf.h
@@ -232,7 +232,7 @@ long bpf_usdt_cookie(struct pt_regs *ctx)
  */
 #define BPF_USDT(name, args...)						    \
 name(struct pt_regs *ctx);						    \
-static __attribute__((always_inline)) typeof(name(0))			    \
+static __always_inline typeof(name(0))					    \
 ____##name(struct pt_regs *ctx, ##args);				    \
 typeof(name(0)) name(struct pt_regs *ctx)				    \
 {									    \
@@ -241,7 +241,7 @@ typeof(name(0)) name(struct pt_regs *ctx)				    \
         return ____##name(___bpf_usdt_args(args));			    \
         _Pragma("GCC diagnostic pop")					    \
 }									    \
-static __attribute__((always_inline)) typeof(name(0))			    \
+static __always_inline typeof(name(0))					    \
 ____##name(struct pt_regs *ctx, ##args)
 
 #endif /* __USDT_BPF_H__ */
-- 
2.34.1

