Return-Path: <bpf+bounces-10287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CD97A4C87
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 17:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50891C210DB
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 15:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F36F1D6BD;
	Mon, 18 Sep 2023 15:36:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF3A1C289
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 15:36:09 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BD01706
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 08:33:01 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a640c23a62f3a-9adc75f6f09so474493066b.0
        for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 08:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695050989; x=1695655789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YiCPcSujgZLNKIlHUVm+vvy2lgJ4MowgcIqAbJ/rmc=;
        b=KbNe0xMHjsitcj8rdrAnZ3LUKrtLhdBFDpJeW4hHk0p863fvFHTT0wrfDy7lc7eKMh
         OWHnG8Yf+gNuuyYcfPvrPUUNBz7ak10fEZ2mSj8EIWOZknoGGoWXQyOovLD797g40kpP
         lwWF++mytXWZfrSqwkIdcD7Vup1pwqCm4X1fhU2U5V/pPHr0xmQNv5yInGw6F51sSK9p
         NKfqQAojyVr+mxHs+WR2Hc7ee6uOJFxd62niewNLfYpBchvE+MeVy13vPCKbkJqfriGP
         g3uznwMJuYFcqXfFTu8HTspiY9RNrW3tOwns72c0Xwb65GdWV6h23jweeeecLtpKc7NG
         ln5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050989; x=1695655789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YiCPcSujgZLNKIlHUVm+vvy2lgJ4MowgcIqAbJ/rmc=;
        b=CX2OWoAeaJHg9Vi7ZU/aa1CKiQVoIdtezAWlE6v72n5/aicqM2H/pO0QcdeKY8xMLm
         DCD1oaZEwfMPVBxUiIj2DxYtFc1DUe/90IySrjwRm2thhS1A3lnENtugyrAKiD3eYv4m
         RGWynS9c9mpoJ/6sekKpcFgDzzK/oapImutSV/0PAjOeDkC0CdbAPvbIjZru3lQofSfu
         yfWk4gMS8vAiXsD+vVexEQgu/WhlXABsFmo9K7Er58HGRXtfdTZCFz3kpIqHHSY4vz3C
         UbSnYrD4JlCYEgsJzGAD4HSz+CIzKk+Rm4zKwlZHwR2s54zSlQcVxyXHbp4yGCej/NRu
         2kdw==
X-Gm-Message-State: AOJu0YwTIKA1RgafpeBNk0Whq4Ii311XW9xBnGn86GV5sVFanabfB6U0
	LpRBU3WwtCK2tMs/OT9NWmAuaHmfQg1p/w==
X-Google-Smtp-Source: AGHT+IGDlgpk4SMAnwmzydIfWpcDsuXIR1s+XP+sc0EgWsJa4IQq6cy2MHd66g9m/PBnCkMZ7JOYwA==
X-Received: by 2002:a05:6512:2526:b0:503:9ea:3a67 with SMTP id be38-20020a056512252600b0050309ea3a67mr5140809lfb.26.1695047959858;
        Mon, 18 Sep 2023 07:39:19 -0700 (PDT)
Received: from localhost (vpn-253-124.epfl.ch. [128.179.253.124])
        by smtp.gmail.com with ESMTPSA id v15-20020a056402348f00b005308a170845sm4698778edc.29.2023.09.18.07.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 07:39:19 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v1 3/3] bpf: Disable exceptions when CONFIG_UNWINDER_FRAME_POINTER=y
Date: Mon, 18 Sep 2023 16:39:14 +0200
Message-ID: <20230918143914.292526-4-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918143914.292526-1-memxor@gmail.com>
References: <20230918143914.292526-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1606; i=memxor@gmail.com; h=from:subject; bh=znk/eRrHas+L6qZGPKLxKYJFS9c8+0jZu8DHA5j7bn8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBlCGDalXKT6QxLcISac8/HqhxMxlkR+GK7znj4E +bFGXLmgz+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZQhg2gAKCRBM4MiGSL8R ykQ/D/9btE9cc7zW6cRgnyZ1s6zbD2imMI5MPYJTEygnC+fvhYpOxiVDlmV15iRj86mBXeCgEmF xaxUP7crsJpgs07huyeFoM8CHSnS+/AOFZQC8yOJxJquc02mToLl2DwCz5R/RQwcoYjHxlVpe0s jbZGJ2qs2jOj3BoFm1vwxGg+6ouMPT+K49bCq9E3kZlW2+jU+CnzZKAt3pIUacW8vhvP9sTrmZC V0ijsGVK0yMWe1My7dTL2W0FhIK9iJir/1Q/cAwSQqxnqFI7tq2+RxGx38Af+0tBGGO1DnropSx ztU5vihHb9z7Qd29x43dyGZRrHai33ykYAEHbr3BvcEVlkoFv6dSk7fFv7DGlm4OPxL4/PuOx5J ZhxqAf81eETt3pYQuERXvllZgMVjPcFldbhhqQhedGmXvCbMkAlhvG80vQf6o4QHMmK48K//0dA n7jifOEa9FoDNga00DFy0a45JAqVHLLBuKymrOWptJwrZ8Yy0H4PV1xGqVZGW6rph0QvR0/gq3s elQ6V00lPnzzl9JwRmyu6O3yhdvxA4RVAjjRnF1UMSGacFvpj0k4Il8PEtJfac47zKqNMpZZnbv 8BGegR40ABbMY2mSDu3T++VzNQcYcps5S8P6+ZYamjthYV0G8pRYvRBXdo6ngOabh/eHmgYDyKo 3YBNSqOAbJk0MXw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The build with CONFIG_UNWINDER_FRAME_POINTER=y is broken for
current exceptions feature as it assumes ORC unwinder specific fields in
the unwind_state. Disable exceptions when frame_pointer unwinder is
enabled for now.

Fixes: fd5d27b70188 ("arch/x86: Implement arch_bpf_stack_walk")
Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 84005f2114e0..8c10d9abc239 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3003,16 +3003,15 @@ void bpf_jit_free(struct bpf_prog *prog)
 bool bpf_jit_supports_exceptions(void)
 {
 	/* We unwind through both kernel frames (starting from within bpf_throw
-	 * call) and BPF frames. Therefore we require one of ORC or FP unwinder
-	 * to be enabled to walk kernel frames and reach BPF frames in the stack
-	 * trace.
+	 * call) and BPF frames. Therefore we require ORC unwinder to be enabled
+	 * to walk kernel frames and reach BPF frames in the stack trace.
 	 */
-	return IS_ENABLED(CONFIG_UNWINDER_ORC) || IS_ENABLED(CONFIG_UNWINDER_FRAME_POINTER);
+	return IS_ENABLED(CONFIG_UNWINDER_ORC);
 }
 
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie)
 {
-#if defined(CONFIG_UNWINDER_ORC) || defined(CONFIG_UNWINDER_FRAME_POINTER)
+#if defined(CONFIG_UNWINDER_ORC)
 	struct unwind_state state;
 	unsigned long addr;
 
-- 
2.41.0


