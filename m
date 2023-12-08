Return-Path: <bpf+bounces-17088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E58C809933
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 03:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E5028230C
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 02:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2501FB3;
	Fri,  8 Dec 2023 02:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6OlKwJv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6351708
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 18:32:23 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5d852ac9bb2so15208537b3.2
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 18:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702002742; x=1702607542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDHVdOd2jZOuEfBj79HPXJ+uCrptWlETf48sRU8/cNQ=;
        b=b6OlKwJvGike0HFFhDKRnEEXmO0f6BdZDQ4SM0N+r/3h0uqSONqtCVbIlYwKOwPLLX
         Hq8ulqXj2AruJ7StHz3SrD7nPpLvQaKaq/CP22KFaVNMsb8uGR0UpSXUv5IURhTXfFGZ
         vWdJWsczJSeu553QgX3DAm+zJ+qbb1olYbM/HcKScVFDn8mByeSe0WwwIblLt1FRtlJ1
         dOXteOKYrl2RVsPiVnsl6Hxzlpd4ysLsFVIMPLS176V8tuI12Cm/deboNxDj1Hlo/gNw
         uJSlvmN1IP2PScSmRko+PO8qmKgaa5SoF8cKhzq6RGohWHQfjmViqOfG3aCbzL3tq7Dh
         wGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702002742; x=1702607542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDHVdOd2jZOuEfBj79HPXJ+uCrptWlETf48sRU8/cNQ=;
        b=RdLBxL6OYGVIBycNSs5sxt+lLDxqcQjuNyK0Hg92ILRoEayyXqLUeJqHW5HMFtujBa
         UsvUK4u3t6rjFNiiX6uoK2OT0nG7oyZoS4z8XyFhBkE+PJSxuK3tTbGYxE7VvL0iC/RF
         7D6NgfB0j5d8PYZuknEgluzCt5UpSgzsyDBBDVXY9VlCkwcEtTNGmc1jXMcUzxpztMva
         OjrUcz1fMNuVRLtPlCnhG906DYS361Lo9rJbOsGaUTLpKTUH9bashXf8+fI1Ec64rutD
         W0kHZ6OCoryMmwVyWCSJeD8Dqpfu5cc4tk692zcbtcikTvpRp8SSXpvepZ/jYP2m+87C
         nGFw==
X-Gm-Message-State: AOJu0YxV9dtZYfzR/aI2rUGS8qmLGUBEcQNpRzaYXusLHm0qLrFmCGIy
	vApprHd2Jyfg4p/jjcEiG8bc41NBoQcrxg==
X-Google-Smtp-Source: AGHT+IEboXbrPfdOtaO6Ms43FeNaumDu8aJnj5iNU9niADzhYZFUp8dToGX1CUbTDWLuTAbjb7Z9IA==
X-Received: by 2002:a81:ad48:0:b0:5d3:7c0b:9547 with SMTP id l8-20020a81ad48000000b005d37c0b9547mr3599284ywk.12.1702002742110;
        Thu, 07 Dec 2023 18:32:22 -0800 (PST)
Received: from andrei-framework.verizon.net ([2600:4041:599b:1100:2b9f:d631:c5b3:a90f])
        by smtp.gmail.com with ESMTPSA id g5-20020ad45105000000b0067ac80bb33fsm408063qvp.125.2023.12.07.18.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 18:32:21 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: sunhao.th@gmail.com,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf v4 1/3] bpf: add some comments to stack representation
Date: Thu,  7 Dec 2023 21:31:48 -0500
Message-Id: <20231208023150.254207-2-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231208023150.254207-1-andreimatei1@gmail.com>
References: <20231208023150.254207-1-andreimatei1@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add comments to the datastructure tracking the stack state, as the
mapping between each stack slot and where its state is stored is not
entirely obvious.

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 include/linux/bpf_verifier.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index aa4d19d0bc94..6cf64338e978 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -316,7 +316,17 @@ struct bpf_func_state {
 	/* The following fields should be last. See copy_func_state() */
 	int acquired_refs;
 	struct bpf_reference_state *refs;
+	/* Size of the current stack, in bytes. The stack state is tracked below, in
+	 * `stack`. allocated_stack is always a multiple of BPF_REG_SIZE.
+	 */
 	int allocated_stack;
+	/* The state of the stack. Each element of the array describes BPF_REG_SIZE
+	 * (i.e. 8) bytes worth of stack memory.
+	 * stack[0] represents bytes [*(r10-8)..*(r10-1)]
+	 * stack[1] represents bytes [*(r10-16)..*(r10-9)]
+	 * ...
+	 * stack[allocated_stack/8 - 1] represents [*(r10-allocated_stack)..*(r10-allocated_stack+7)]
+	 */
 	struct bpf_stack_state *stack;
 };
 
@@ -630,6 +640,10 @@ struct bpf_verifier_env {
 	int exception_callback_subprog;
 	bool explore_alu_limits;
 	bool allow_ptr_leaks;
+	/* Allow access to uninitialized stack memory. Writes with fixed offset are
+	 * always allowed, so this refers to reads (with fixed or variable offset),
+	 * to writes with variable offset and to indirect (helper) accesses.
+	 */
 	bool allow_uninit_stack;
 	bool bpf_capable;
 	bool bypass_spec_v1;
-- 
2.40.1


