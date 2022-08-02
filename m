Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9AB5884BC
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 01:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiHBXaQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 19:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiHBXaP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 19:30:15 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07225286D3;
        Tue,  2 Aug 2022 16:30:09 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id g14so3127549ile.11;
        Tue, 02 Aug 2022 16:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=5QWtRLiCD499/3yCr+y+nC+G/Q3k69RBDAJZDLEJECY=;
        b=HN2bWP03/dkj+xhrHliTBv37pjdQhHTfRc/oyNvTdO5+tw5RJUUgwCMKdbThJRnhe/
         cLxOEUl/JjgHtQI6Lt1tY5iTKVVK1bghBlWSLVAGb3vL7LVFoxr1/xQd/fRxYqUFBfmp
         P81lt2TYNx4v56vOmmf0ZSCYB2j3cn6IXaJxMX0wPmhwSAwi8BbJGTkYQTF0XGFxZk2W
         Aii05f/1sbJXZd/5oeEBQWddsrHCtPSlMqvfXgMQAtTBJTLVEyZaiq99j692mWmpLwrp
         SENsaoZ+GsirF/FupiPpk6z5D4Yy16WKUJHh3N4PzsXG/UcEY8Hq1/+5v8PGNxDubSzm
         8Pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=5QWtRLiCD499/3yCr+y+nC+G/Q3k69RBDAJZDLEJECY=;
        b=MbILhz8c0N4jpY6v5yubbhLHmE4l/ZB7Ma5qDnPEjKJCHowWIVbPlmuGyGwJ1THTTo
         ZflPN9lytXJdm7v8A+GJDDD45O+D2bn9TIIzCGplI4jjj1SJNJssBFq8of0l9VABaezy
         5PpJQN7hIPMgeJLITb84/ibNmruUtOy7D9G/04pk9TQOl2bkuZ+OMgwma1adCjYMguOD
         9C4u+5i5uQbpZRVMjikmONOc6+UKxBqsFbh0f/q1n6aHpQXEG/g4FbOwuAULU8PW2PS4
         Cuv0zuGWRKN9PdC4G5G3KsLGqEYjkqIAbdX4NCTOMNVO+QrcQ8D3qPYr5Tq8uOXomUjT
         Jiog==
X-Gm-Message-State: AJIora+/jbpfjlUK+n+ytfiqpDTHlDQkKsPq6s/TtnCDX8tnjuX7jQ9y
        3I623uYkSBaMBMBlvNZtBqiEouJuuROtCpL6
X-Google-Smtp-Source: AGRyM1v5Gahiylfm9kEka90Bee+WJt9Uwe9mjMLtHj19CR3Q1/FYZHSDCgrND4LpyA5p/SUhz2eIbw==
X-Received: by 2002:a92:d10a:0:b0:2d9:1332:d339 with SMTP id a10-20020a92d10a000000b002d91332d339mr9781055ilb.110.1659483007659;
        Tue, 02 Aug 2022 16:30:07 -0700 (PDT)
Received: from james-x399.localdomain (71-33-133-32.hlrn.qwest.net. [71.33.133.32])
        by smtp.gmail.com with ESMTPSA id z24-20020a056638215800b00342847fc497sm1149328jaj.8.2022.08.02.16.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 16:30:06 -0700 (PDT)
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
Subject: [PATCH] libbpf: ensure functions with always_inline attribute are inline
Date:   Tue,  2 Aug 2022 17:27:41 -0600
Message-Id: <20220802232741.481145-1-james.hilliard1@gmail.com>
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
inline.

Fixes errors like:
/home/buildroot/bpf-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_tracing.h:439:1: error: ‘always_inline’ function might not be inlinable [-Werror=attributes]
  439 | ____##name(unsigned long long *ctx, ##args)
      | ^~~~

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 tools/lib/bpf/bpf_tracing.h | 14 +++++++-------
 tools/lib/bpf/usdt.bpf.h    |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 43ca3aff2292..ae67fcee912c 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -426,7 +426,7 @@ struct pt_regs;
  */
 #define BPF_PROG(name, args...)						    \
 name(unsigned long long *ctx);						    \
-static __attribute__((always_inline)) typeof(name(0))			    \
+static inline __attribute__((always_inline)) typeof(name(0))		    \
 ____##name(unsigned long long *ctx, ##args);				    \
 typeof(name(0)) name(unsigned long long *ctx)				    \
 {									    \
@@ -435,7 +435,7 @@ typeof(name(0)) name(unsigned long long *ctx)				    \
 	return ____##name(___bpf_ctx_cast(args));			    \
 	_Pragma("GCC diagnostic pop")					    \
 }									    \
-static __attribute__((always_inline)) typeof(name(0))			    \
+static inline __attribute__((always_inline)) typeof(name(0))		    \
 ____##name(unsigned long long *ctx, ##args)
 
 struct pt_regs;
@@ -460,7 +460,7 @@ struct pt_regs;
  */
 #define BPF_KPROBE(name, args...)					    \
 name(struct pt_regs *ctx);						    \
-static __attribute__((always_inline)) typeof(name(0))			    \
+static inline __attribute__((always_inline)) typeof(name(0))		    \
 ____##name(struct pt_regs *ctx, ##args);				    \
 typeof(name(0)) name(struct pt_regs *ctx)				    \
 {									    \
@@ -469,7 +469,7 @@ typeof(name(0)) name(struct pt_regs *ctx)				    \
 	return ____##name(___bpf_kprobe_args(args));			    \
 	_Pragma("GCC diagnostic pop")					    \
 }									    \
-static __attribute__((always_inline)) typeof(name(0))			    \
+static inline __attribute__((always_inline)) typeof(name(0))		    \
 ____##name(struct pt_regs *ctx, ##args)
 
 #define ___bpf_kretprobe_args0()       ctx
@@ -484,7 +484,7 @@ ____##name(struct pt_regs *ctx, ##args)
  */
 #define BPF_KRETPROBE(name, args...)					    \
 name(struct pt_regs *ctx);						    \
-static __attribute__((always_inline)) typeof(name(0))			    \
+static inline __attribute__((always_inline)) typeof(name(0))		    \
 ____##name(struct pt_regs *ctx, ##args);				    \
 typeof(name(0)) name(struct pt_regs *ctx)				    \
 {									    \
@@ -540,7 +540,7 @@ static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
 #define BPF_KSYSCALL(name, args...)					    \
 name(struct pt_regs *ctx);						    \
 extern _Bool LINUX_HAS_SYSCALL_WRAPPER __kconfig;			    \
-static __attribute__((always_inline)) typeof(name(0))			    \
+static inline __attribute__((always_inline)) typeof(name(0))		    \
 ____##name(struct pt_regs *ctx, ##args);				    \
 typeof(name(0)) name(struct pt_regs *ctx)				    \
 {									    \
@@ -555,7 +555,7 @@ typeof(name(0)) name(struct pt_regs *ctx)				    \
 		return ____##name(___bpf_syscall_args(args));		    \
 	_Pragma("GCC diagnostic pop")					    \
 }									    \
-static __attribute__((always_inline)) typeof(name(0))			    \
+static inline __attribute__((always_inline)) typeof(name(0))		    \
 ____##name(struct pt_regs *ctx, ##args)
 
 #define BPF_KPROBE_SYSCALL BPF_KSYSCALL
diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
index 4f2adc0bd6ca..2bd2d80b3751 100644
--- a/tools/lib/bpf/usdt.bpf.h
+++ b/tools/lib/bpf/usdt.bpf.h
@@ -232,7 +232,7 @@ long bpf_usdt_cookie(struct pt_regs *ctx)
  */
 #define BPF_USDT(name, args...)						    \
 name(struct pt_regs *ctx);						    \
-static __attribute__((always_inline)) typeof(name(0))			    \
+static inline __attribute__((always_inline)) typeof(name(0))		    \
 ____##name(struct pt_regs *ctx, ##args);				    \
 typeof(name(0)) name(struct pt_regs *ctx)				    \
 {									    \
@@ -241,7 +241,7 @@ typeof(name(0)) name(struct pt_regs *ctx)				    \
         return ____##name(___bpf_usdt_args(args));			    \
         _Pragma("GCC diagnostic pop")					    \
 }									    \
-static __attribute__((always_inline)) typeof(name(0))			    \
+static inline __attribute__((always_inline)) typeof(name(0))		    \
 ____##name(struct pt_regs *ctx, ##args)
 
 #endif /* __USDT_BPF_H__ */
-- 
2.34.1

