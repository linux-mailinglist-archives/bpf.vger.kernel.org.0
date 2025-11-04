Return-Path: <bpf+bounces-73467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFECC3252F
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 18:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF0364E75DF
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 17:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A8D339B51;
	Tue,  4 Nov 2025 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVnleedB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D2B2E6125
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277219; cv=none; b=F2Xwpm4AzBio6sxL9zrIV4eHhlCwC83BAEbW9ccNILFAVhn1vEZ4q0U+FEyTzdk3Y9r68rcHxIBQXNp4xvipxTbmt74fxgoQ0g7nbgQJ6o8UWP9ZKfhEijmovrSGTU9DIC4fXSJTEYfEP4bfSq2PL3cybZx7Bc4LzLdqa4lmax8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277219; c=relaxed/simple;
	bh=JyjnDFMmsnIqhPDJLu5tPseer9rVq9AUhJ3TigZsnuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=unVWtpakxlCmub53bsUNtJcmMhk4989T9zlKYZnRVsJNp8fDLqR3bFPDUqFZz32tI3MRCaRmBe7mJRNw1zMNe1cT9ertN59vJMji6j3WK6YLxteWMlx3DD5CUrMyylidnCW7ZLbMbvw42bcCPDleobEtlwihYDPF6VvJZkG9EUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVnleedB; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b98983bae8eso2021433a12.0
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 09:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762277217; x=1762882017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LOiAlHINrk8JJxNb7Yln0VGSOKqRrQSGzZ9VD8Yzow=;
        b=RVnleedB5SV7144M7mO9K7Ze78UsapBzFWmyvp0WK0obbS2VUI0vu3TD8guNhWqLB7
         xd3Gt7NhnChyXy2T3GjMlXSzNdUR0Gafltisb6P6kBzAb2o244vRj3dOQkVDLPX2mnHz
         bNKJHQNjXI/dKbQgHods2A5EnNCGNy7bA07eGky+hb1F3OgSvwpncXjAGxTxHiAlFDvX
         LIsOlLbvCE30HVtsOInA1KZ0v0kaJGCD5JRXBZq1/oLzdDWvk+ThNphwTNnB7y6Bky0d
         NQPiaOw2MHGg0orXpha6R4nqRRzud/3zBRia/y2JW0AdmSkCu19xtCfOZbv2J+aW53Ty
         rLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762277217; x=1762882017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LOiAlHINrk8JJxNb7Yln0VGSOKqRrQSGzZ9VD8Yzow=;
        b=DF9St5Lm0C56fKqOzBQ+YJbrk6dxuV04kojIWMNCRAJ/O/aGeKWLpBHfZAFCUrclIp
         RO9pEbAEh8L21rwe/4cWOqIdTYY40ToyGmiPNXh/5l/9XATi1R7Yr5gJqtKRssRkd4qN
         vzjpEw5OpVHS6d9+pnnDScTlBqjDjCgsBwDMPERE2Bveby6xjdHM0fT2zCn+yxLPKdHr
         ZwTiqmU+JG6sg/yVeENgfJC6iOcv77R9jOxzRoHZpdwypPlY0NMOLYYZnnoPYleMJMJR
         Kbxi8RlxWSN8GaNeuj7N2zKEt919Xz9rEWYo6V8E6IOETqCjzulY1rQmyYXj8dp+Ecp6
         dwxQ==
X-Gm-Message-State: AOJu0YzfkF762pje0T6yNW5TrN68D8GK3ZebuJUJwB8kHzrDGj4Hcn7A
	c5bzmMsUi7irWt7wz9Bmem58izViQFNC1upqlKPhVAHD0Xp1nuWxkFSdg3gs1Q==
X-Gm-Gg: ASbGnctUDWX7vcFkoRDHBVWDbVolG4UrIOCS0jO4b1yOt3+rH8csSQ3VUIAHczgrsXR
	r7QSTheaF7tefEebrU6gHXAPsWvHCboRPxZqIyEU5LqWSjxyL5hHTdIgFJmiGb5eIQyFi1bjAQZ
	yXfcoVqL9fTwvBiSFBjrnGjKJOc0IZkYwEHCv0AMV/iaQfR9eNJIIuK+feavMJ7+lPHIuNC84/c
	DgdHU4mn+R6EjP2JSw3/feEUL+cBJf/yfP1d7+07b+ekgK+mM5bucwXUsIUStEoMBYcHuBPa4Y7
	VJs+dIASK8rD3VwTkPFc+PygUuI1fblVz390kjfM9VhHHrfCBxQDSnnT8e5vCpgbDTNlTtW307Z
	VsFChCOf9MwDnkFYDbye1jPFWyI7k61dg1jatcasTEAr036AeE7lqYXhU8P0xgkD+89E=
X-Google-Smtp-Source: AGHT+IFL+hq4i/iNP5+rHpigkDApecoiJMbAcz1Yl4KByj7ek+H0NGAvo6RugGFz/Api0zLB5KdNRg==
X-Received: by 2002:a05:6a20:a126:b0:342:20f9:98b1 with SMTP id adf61e73a8af0-34f84113f07mr118747637.21.1762277216641;
        Tue, 04 Nov 2025 09:26:56 -0800 (PST)
Received: from localhost ([2a03:2880:ff:52::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd5774c21sm3579055b3a.43.2025.11.04.09.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 09:26:56 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 1/7] bpf: Allow verifier to fixup kernel module kfuncs
Date: Tue,  4 Nov 2025 09:26:46 -0800
Message-ID: <20251104172652.1746988-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251104172652.1746988-1-ameryhung@gmail.com>
References: <20251104172652.1746988-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow verifier to fixup kfuncs in kernel module to support kfuncs with
__prog arguments. Currently, special kfuncs and kfuncs with __prog
arguments are kernel kfuncs. Allowing kernel module kfuncs should not
affect existing kfunc fixup as kernel module kfuncs have BTF IDs greater
than kernel kfuncs' BTF IDs.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 542e23fb19c7..8f4410eee3b6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21973,8 +21973,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (!bpf_jit_supports_far_kfunc_call())
 		insn->imm = BPF_CALL_IMM(desc->addr);
-	if (insn->off)
-		return 0;
+
 	if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl] ||
 	    desc->func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
 		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
-- 
2.47.3


