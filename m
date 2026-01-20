Return-Path: <bpf+bounces-79649-lists+bpf=lfdr.de@vger.kernel.org>
Delivered-To: lists+bpf@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gInuNIrFb2lsMQAAu9opvQ
	(envelope-from <bpf+bounces-79649-lists+bpf=lfdr.de@vger.kernel.org>)
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:12:26 +0100
X-Original-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66057492FA
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06A7F92D57E
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 16:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BE9320382;
	Tue, 20 Jan 2026 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezAqa9me"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092E331E0E6
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924775; cv=none; b=ny/nw/Iej/5VXxFDJ3Lqi7J7jdUpZ4SGdtMI/arfgjFRHNlPpj94yY68FcLXbrUQTtkCWM5HSBCVQ9P8h2kdfjIQxAOu1X52qFoSUXZDLpimJ1JsBOOQfXZbHFdLHOj8gP0XyooVCFRCYtPgfX8jmUYOnSA/QYg3LLWk3Z1X8L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924775; c=relaxed/simple;
	bh=uBgdcP/8eKiNVr9yDovBdg4OVdReyIyfSjDmeggYSt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MTC+PkK8JW7X63zmq2kr68lOIUMyqFABbLEfq9C9LWCTI4RGLPdnnXqc/3M0aXW+t47t3DWzuE2fkqzNqS4OsxBRwFnHOW5G791tH8CI6C3yV8lpcQn+ecVN0D34N0QHg4S6xCRvHvgcjPa47YYLvB8yovspeXZrga38PM1fqB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezAqa9me; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43591b55727so547577f8f.3
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 07:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768924772; x=1769529572; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMy6jiDDMpFvYB+6s8oftA+orrfkzR6Gpd384Jyt/ns=;
        b=ezAqa9meONuJ80fpMzRj39kqNenb+5xfYq1HWUUj1zcbEORrp2fZxAwtt7IjgM5LjA
         9AmMGGpJ7l6spZ2JQwv17Tj44ue70jKLc1yBGhKXusbcqXvTtlstikdmTsSYtb5R0DbW
         6A9PmpCb9kgUssmQIuvd0OpB8+H7n31vsB+Cbfz+w84MtuuJt9NoBz3V6jx6xOI4MkT0
         XBorGxyTpg8uejHKR9naFyco953UPMXkCDbB46mmkbYdXOol/qjFsBV82ZeRGiaNxCb2
         C/bu9RtcFglaKKblzsXDj96TffERB2JNWGMcvquoS0UHNxstVTTJIJX6F0dKlEGYNjke
         czmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768924772; x=1769529572;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EMy6jiDDMpFvYB+6s8oftA+orrfkzR6Gpd384Jyt/ns=;
        b=FKhuOHwj+clsaVoaTNxoSCBpDQa03IzRigteO9vi2EJ50OEN8iYsMYMsLcaIbWua6g
         ZsroW15zeY6InbXsF3pa2SVcH3Mf7qqyMzlHsQ8Ko349iyxDgYeo7aD1ZfsMmA1QZzF2
         YTE8MwlL2Ckol/1W2TlDjIQ/iB7NmHjGloojrvghAyP397NQlFCJnazK/vuokiWytkcn
         ItWLMTFJit/fn3cf7VR+9hI9YxJqLyvYAldBnYfaGVYmT0VSKN5FDihc2bKdWLipufrT
         EHbkmrvuJZF5D9ImsiZCqwWAiLcl/QnO1kBOXVA/OJWxdhCD78HUSKq9RKJNAX6/AQUX
         J4jQ==
X-Gm-Message-State: AOJu0Ywsb0WIVp4awvt5dEJgaLSf8g41V2QVoFrxoTm0sPReAFwYqQ7a
	U9QZlRAxixcVmt+BRNm9E60y68sBNqpJl2cF8bS1/0xt1l4La99z+cN3
X-Gm-Gg: AZuq6aI8vvao+pfsPDTzGckB119u+JuRounNfiVoL49ogeXGbu08+YpYIPPJLLKbCFH
	ms4DpHMNLCDLt/7/8Df6Ykgm+Xr0ctVBmENBPLK7sdEtzzlTNfaJxSVfjc+BXVjGhBoKgPzQife
	YO5w8MFr959DGHBvTPr286u9a71/rtBll6ORZtxXazAP/D2nA4nBn8+JOIK4P6NdXtUZzUcyLr3
	dk5JjvOfk2HuMqO59GdjHB+XaqXm5sC3Cj+de7LmDtgOmsJCCP/hEVJvfKB/SjEsLnrlP21EAM8
	9PIAY7bd9+sw5qyCuGG4lke1k+YqiSZ+q/ld1T8SYLudEN8ni0MQaRW+hSdWf7iUjuUXZtjTjei
	+L9bH37kYlXRsvvqetlqqSYvo7sbSz/N+E4XsipPgh2lf3QDvdXwp1tFWPmdYVb3czQoEomPAdT
	Iv9nPXfmUSR47j6A==
X-Received: by 2002:a5d:5f83:0:b0:435:90a7:8db with SMTP id ffacd0b85a97d-43590a70d49mr3916776f8f.15.1768924771999;
        Tue, 20 Jan 2026 07:59:31 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921dddsm31249849f8f.6.2026.01.20.07.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:59:31 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 20 Jan 2026 15:59:15 +0000
Subject: [PATCH bpf-next v6 06/10] bpf: Add verifier support for bpf_timer
 argument in kfuncs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-timer_nolock-v6-6-670ffdd787b4@meta.com>
References: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com>
In-Reply-To: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768924764; l=4925;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=BNPM5TqXQAZGw1YFJGlxw42Jm5obR+tkVK97zyULN9M=;
 b=50l3MRApq1TTCtcTpOcwY+xYI2nWcSujrswVtJR+XG86IukrzbFe2B2oXfEQF6Fri9hY+xkpJ
 q/PbGttJIfTB3jW77XbLB+acbzYPx/65GtoXw6F6+oEwNoj9UG817qB
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79649-lists,bpf=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,iogearbox.net,meta.com,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mykytayatsenko5@gmail.com,bpf@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[bpf];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 66057492FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mykyta Yatsenko <yatsenko@meta.com>

Extend the verifier to recognize struct bpf_timer as a valid kfunc
argument type. Previously, bpf_timer was only supported in BPF helpers.

This prepares for adding timer-related kfuncs in subsequent patches.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 59 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9de0ec0c3ed998b0b135d85d64fe07ee0f8df6d5..ae189a6af1dbcbf2da30f70dd9b848c4f90bb5cf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8566,17 +8566,15 @@ static int check_map_field_pointer(struct bpf_verifier_env *env, u32 regno,
 }
 
 static int process_timer_func(struct bpf_verifier_env *env, int regno,
-			      struct bpf_call_arg_meta *meta)
+			      struct bpf_map *map)
 {
-	struct bpf_reg_state *reg = reg_state(env, regno);
-	struct bpf_map *map = reg->map_ptr;
 	int err;
 
 	err = check_map_field_pointer(env, regno, BPF_TIMER);
 	if (err)
 		return err;
 
-	if (meta->map_ptr) {
+	if (map) {
 		verifier_bug(env, "Two map pointers in a timer helper");
 		return -EFAULT;
 	}
@@ -8584,8 +8582,36 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 		verbose(env, "bpf_timer cannot be used for PREEMPT_RT.\n");
 		return -EOPNOTSUPP;
 	}
+	return 0;
+}
+
+static int process_timer_helper(struct bpf_verifier_env *env, int regno,
+				struct bpf_call_arg_meta *meta)
+{
+	struct bpf_reg_state *reg = reg_state(env, regno);
+	int err;
+
+	err = process_timer_func(env, regno, meta->map_ptr);
+	if (err)
+		return err;
+
 	meta->map_uid = reg->map_uid;
-	meta->map_ptr = map;
+	meta->map_ptr = reg->map_ptr;
+	return 0;
+}
+
+static int process_timer_kfunc(struct bpf_verifier_env *env, int regno,
+			       struct bpf_kfunc_call_arg_meta *meta)
+{
+	struct bpf_reg_state *reg = reg_state(env, regno);
+	int err;
+
+	err = process_timer_func(env, regno, meta->map.ptr);
+	if (err)
+		return err;
+
+	meta->map.uid = reg->map_uid;
+	meta->map.ptr = reg->map_ptr;
 	return 0;
 }
 
@@ -9913,7 +9939,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		}
 		break;
 	case ARG_PTR_TO_TIMER:
-		err = process_timer_func(env, regno, meta);
+		err = process_timer_helper(env, regno, meta);
 		if (err)
 			return err;
 		break;
@@ -12166,6 +12192,7 @@ enum {
 	KF_ARG_WORKQUEUE_ID,
 	KF_ARG_RES_SPIN_LOCK_ID,
 	KF_ARG_TASK_WORK_ID,
+	KF_ARG_TIMER_ID,
 };
 
 BTF_ID_LIST(kf_arg_btf_ids)
@@ -12177,6 +12204,7 @@ BTF_ID(struct, bpf_rb_node)
 BTF_ID(struct, bpf_wq)
 BTF_ID(struct, bpf_res_spin_lock)
 BTF_ID(struct, bpf_task_work)
+BTF_ID(struct, bpf_timer)
 
 static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
 				    const struct btf_param *arg, int type)
@@ -12220,6 +12248,11 @@ static bool is_kfunc_arg_rbtree_node(const struct btf *btf, const struct btf_par
 	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_RB_NODE_ID);
 }
 
+static bool is_kfunc_arg_timer(const struct btf *btf, const struct btf_param *arg)
+{
+	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_TIMER_ID);
+}
+
 static bool is_kfunc_arg_wq(const struct btf *btf, const struct btf_param *arg)
 {
 	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_WORKQUEUE_ID);
@@ -12314,6 +12347,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_NULL,
 	KF_ARG_PTR_TO_CONST_STR,
 	KF_ARG_PTR_TO_MAP,
+	KF_ARG_PTR_TO_TIMER,
 	KF_ARG_PTR_TO_WORKQUEUE,
 	KF_ARG_PTR_TO_IRQ_FLAG,
 	KF_ARG_PTR_TO_RES_SPIN_LOCK,
@@ -12559,6 +12593,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_wq(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_WORKQUEUE;
 
+	if (is_kfunc_arg_timer(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_TIMER;
+
 	if (is_kfunc_arg_task_work(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_TASK_WORK;
 
@@ -13345,6 +13382,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 		case KF_ARG_PTR_TO_CONST_STR:
 		case KF_ARG_PTR_TO_WORKQUEUE:
+		case KF_ARG_PTR_TO_TIMER:
 		case KF_ARG_PTR_TO_TASK_WORK:
 		case KF_ARG_PTR_TO_IRQ_FLAG:
 		case KF_ARG_PTR_TO_RES_SPIN_LOCK:
@@ -13644,6 +13682,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (ret < 0)
 				return ret;
 			break;
+		case KF_ARG_PTR_TO_TIMER:
+			if (reg->type != PTR_TO_MAP_VALUE) {
+				verbose(env, "arg#%d doesn't point to a map value\n", i);
+				return -EINVAL;
+			}
+			ret = process_timer_kfunc(env, regno, meta);
+			if (ret < 0)
+				return ret;
+			break;
 		case KF_ARG_PTR_TO_TASK_WORK:
 			if (reg->type != PTR_TO_MAP_VALUE) {
 				verbose(env, "arg#%d doesn't point to a map value\n", i);

-- 
2.52.0


