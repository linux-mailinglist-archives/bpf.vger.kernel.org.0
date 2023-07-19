Return-Path: <bpf+bounces-5274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490027593E7
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 13:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7995B1C20FD0
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 11:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8553B12B95;
	Wed, 19 Jul 2023 11:05:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B478830;
	Wed, 19 Jul 2023 11:05:32 +0000 (UTC)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9065197;
	Wed, 19 Jul 2023 04:05:29 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-668730696a4so4582570b3a.1;
        Wed, 19 Jul 2023 04:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689764729; x=1690369529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hFsE/K6gUAIXkP05EqNENfRpK1bhpEZsF99N61vWloE=;
        b=g23qWW+P9F4/xy1Kafm+XGVUvORdC8zJAIToX89ML26LZ6ptcANrUBMFVhtQ+2c5Ch
         B5CV9Lx3rx2c98ImyBDrDMJbuMqPD0KqeXlNw/eT+qLAvfGyonOvV8BAg5AgrKniDesd
         sPw6qi06EYniqagV0wDNOiKib5lZsCHFfVHTWZ5/mIkVIblDEIuQu6tXeUT1dG1q/55x
         b7bSeDuYiIuBlontTBRmxHhLfmX2VtTLvhgNJqxIIVVVIQHu6gHlsGYiA+ySOFb8LxP6
         CgmxC9pJ/Ir8Ji5PG6CVsavg5zsNIq6M2t/psKRf1nTMYm/xHgjC3FdMPopzgd88+eSX
         TEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689764729; x=1690369529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFsE/K6gUAIXkP05EqNENfRpK1bhpEZsF99N61vWloE=;
        b=W2WuorzFYQzsCvbGycKDzluqEx88zGTpawFlfrLwHiB5QWJsax0mYsJj/mF1GaKiw2
         i9ZITlWP7oWjErJSwZQciMxVHbtOCWwVUFdFpcEaOXQCbzu7h87xNb757PYjtiwGgT8B
         jxkFjHc7qWKxnjVIJkRkhQeTogK2S0LWKdFrCeP0TgD4eKpIbizQ1QxHhwXXGJH6HHcw
         fQ1pJFHFFMRyBXu7pm51c2YrD2xzUUnZIjrfhyFtmd4PLyeAVUUybBtP3njP/ODvisUv
         GMfnvll0fbbqW3eM+Y/A7VcLOiVjYriCBsRgxiFKBSg9uM7fevxGYbVWoaEjsKMQU7ix
         g8NQ==
X-Gm-Message-State: ABy/qLbX5E+i4gNjnbiw3c/EXfiOS0PRanLF7fo9Hc6YcFoM8NlO4BRb
	zzI3MVgFVwQNkdCiDyBoby+BtK/3wuw4BO6vSdw=
X-Google-Smtp-Source: APBJJlHZk6bMFYQH4zS8hQT5yWHMzYO7s2xc1b5R3Ge7j1Pa/VBS2SFHC++3Qll9rk0DlvSly1tR9g==
X-Received: by 2002:a05:6a21:6d89:b0:137:48cc:9cfa with SMTP id wl9-20020a056a216d8900b0013748cc9cfamr1033460pzb.24.1689764729250;
        Wed, 19 Jul 2023 04:05:29 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.81])
        by smtp.gmail.com with ESMTPSA id v10-20020a62ac0a000000b00682c864f35bsm3124196pfe.140.2023.07.19.04.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 04:05:28 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: yhs@fb.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	imagedong@tencent.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hao Peng <flyingpeng@tencent.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH bpf-next] bpf, x86: initialize the variable "first_off" in save_args()
Date: Wed, 19 Jul 2023 19:03:30 +0800
Message-Id: <20230719110330.2007949-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Menglong Dong <imagedong@tencent.com>

As Dan Carpenter reported, the variable "first_off" which is passed to
clean_stack_garbage() in save_args() can be uninitialized, which can
cause runtime warnings with KMEMsan. Therefore, init it with 0.

Fixes: 473e3150e30a ("bpf, x86: allow function arguments up to 12 for TRACING")
Cc: Hao Peng <flyingpeng@tencent.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/bpf/09784025-a812-493f-9829-5e26c8691e07@moroto.mountain/
Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 arch/x86/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 5ab531be56ac..83c4b45dc65f 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1925,7 +1925,7 @@ static int get_nr_used_regs(const struct btf_func_model *m)
 static void save_args(const struct btf_func_model *m, u8 **prog,
 		      int stack_size, bool for_call_origin)
 {
-	int arg_regs, first_off, nr_regs = 0, nr_stack_slots = 0;
+	int arg_regs, first_off = 0, nr_regs = 0, nr_stack_slots = 0;
 	int i, j;
 
 	/* Store function arguments to stack.
-- 
2.40.1


