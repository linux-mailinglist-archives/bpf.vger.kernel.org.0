Return-Path: <bpf+bounces-74578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAD7C5F7EC
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 23:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BBC4935DE54
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593783451AB;
	Fri, 14 Nov 2025 22:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGM4ZS8z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC302FFFA6
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 22:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763158665; cv=none; b=de+01KzuLxVJZXJ8E1iHx/2dCJUiFQwMx8IB00e/O5GqTmGOEr/QBT2zaASAlaS1mFCY7bjXPHRmD9S55rOqkLw6wqxc3qSBi54rlv7RzKvXejI3zqqAxKvR6jqFWLwAaXDgpEOFDrwfTK0uDjlYCABRGhj7vzPdc2Tc0WAtv6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763158665; c=relaxed/simple;
	bh=JyjnDFMmsnIqhPDJLu5tPseer9rVq9AUhJ3TigZsnuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELyXllj2zaXsLHXJrYvD8mKa25vW+1pPLyFQ9Sv+YDEEm2Wy1b9w0jas1fl03wb7+rmj+IBh2kMXRfWlDZbT60YEKhA/bRM4xgefB6CuOBkZL5QBZtYvklzhliDEBh5sE/kPXHW9aosdu/cJYhpMmR74XkaopaHusP3F4ruoEkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGM4ZS8z; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34372216275so2849768a91.2
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 14:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763158664; x=1763763464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LOiAlHINrk8JJxNb7Yln0VGSOKqRrQSGzZ9VD8Yzow=;
        b=IGM4ZS8zDn3h7HYSZL/X4GbTL4vpvjo6KgYFKCrqNwSqmsEJMXL1NjcuAWek8CNOLw
         qvHgsWNmg5XUBcuRRD+8BGN+U5D9vMICfBHhwUkc51I9K+JLFE4WtreUy+8jVd0HuW0U
         08N68ZIF3HMpKghECxD9bXnwG4inozBrqR9aroTB0YMsJR0uyzsWZs/pI7IUGr2PHhAX
         dnwjRV7i2wF7QeMyNK8mC/QrlsBYmn6/oxQXIVU2mBwfP2u5cUmIu/1CrkGUF3jHxFTy
         yKTB2F7ZNOKD0GVXHknLhJLghcXw3VtEeqMdvyvvC2pvnwQn6QrAA/e2MPszQbJM1jpI
         ElyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763158664; x=1763763464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8LOiAlHINrk8JJxNb7Yln0VGSOKqRrQSGzZ9VD8Yzow=;
        b=FohuhPLZI80W11PaLfjcEHV08oI3+1YAcFyR5X6BnXeWgZEtxHTk3JbQg2M6LGKBzC
         wfBUAriDRL28NljgqXrIzenbI+PHMIDmcz7+SVXy4NPhdLoo9Opnn/4L/dwdXCsN8La3
         Hgc9MGrrzAdBjTIK5ZZu35fuVkcZNvDbMPQg5zEXCGx5HFQbFyekQ57uCyGLf4AKqNmP
         9O/GoD9omT0wusp8jPAiXPFw+7IywWSCv/u2cNpH46M1ImCECr0Qo6HXuRvIP3vzrgNo
         LLVjcbtFbnGmdhODUGNbZ4rfk4NE109qa/yR8VcxBHk2tivIA/RvWiPFlLhyikDU3y/t
         Pv8Q==
X-Gm-Message-State: AOJu0Yza31OVeCxIlodPlaCc2i21ahkSUun1lD62gvYV9VJPpePLAgtG
	7rmCn/Qm60FQSGbuv1U8O7Ugb6VEdK8TPyTuvA4/itCgjO8q13A/J7jasqB9oA==
X-Gm-Gg: ASbGncu94/aM1Ep5roiCf33RVKS4YST7t0a4E4owu/wZvwLvNr4ruHR1U5KAyx62BeD
	SfHpn+JlQ/h6DqWnkcnaBIxUg9VX7jjhbcgx9xE9Vx+CyiEtY+4sTrtC82BIIqMdpDHxx5PlDXX
	wAcLauhRDI/T3KeGbw737fe6PILyOm2I/6KBivy4BSBoCWQpEL1L1soQqe58oWVaLem+T3+F+SP
	VBbAjvbAXLYoh+bWT4hAB+j+ybsf1ptNbIZDpcjQKndLZWUhtcjZ9+R1skXr6BNx12hEQ9jsdeP
	rvawpc1mOeKSTtXsl3JPhYA1EWW14hI5G3pxR2E7qsl5HI5MEFz2y3/oI21jTGLE39I7hwT0f/3
	G6ALg3CqLJv90vhYgGHmRx79UHVnKqwLZ8PDq5QVMVdoT9OvhHYcg5kcPmII9rX0j03gcXkXO6L
	Ktwn0=
X-Google-Smtp-Source: AGHT+IFCg5HAtwGyVHU7YtInKyFTo7QoleFMRcjCvaQ2JmwihLAuqnhB8QsC9upj7rDGVJLnNrGIog==
X-Received: by 2002:a17:90b:2ccc:b0:340:ba29:d3b6 with SMTP id 98e67ed59e1d1-343f9e92724mr5152992a91.6.1763158663584;
        Fri, 14 Nov 2025 14:17:43 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343eacc2669sm2782166a91.12.2025.11.14.14.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 14:17:43 -0800 (PST)
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
Subject: [PATCH bpf-next v6 1/6] bpf: Allow verifier to fixup kernel module kfuncs
Date: Fri, 14 Nov 2025 14:17:36 -0800
Message-ID: <20251114221741.317631-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114221741.317631-1-ameryhung@gmail.com>
References: <20251114221741.317631-1-ameryhung@gmail.com>
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


