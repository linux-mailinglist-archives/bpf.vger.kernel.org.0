Return-Path: <bpf+bounces-62263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6033AF73B3
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C22AD7B595F
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 12:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9805B2EA75C;
	Thu,  3 Jul 2025 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fijr9jpB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8562EA48E;
	Thu,  3 Jul 2025 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545062; cv=none; b=efVwhoMuSTk99sjPIyQWeVASQsFdpHSyGuaB8lUaKf87/FVsp21WKMQMuqG+TLVhpEfO8dT6xbeMZEzPvyG4Z9cWl0FIYYQ25nUJKEqqh3j7t6hnWIRUEN/sncUQMzyayRmij8yuIyT96nvrEO9KTJT7BgN4luC4MSowZ8IXyFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545062; c=relaxed/simple;
	bh=cvBV+pKTyC93m/WaEwCydISLTC4GlVcikW6mPugS4YA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qe67WJycY07rhkb72RazoT1RPe87Ig7F7PBEGfxE951YfC0zxN5RHaciPNlSILfDHFnRQ2dxXTd/3LJg3KFJ4jr6/HDgg/jVCLOe8oq1KsEEUZJWxHyK8Wf7QA2tYtx2neTJc3CyJ/DLmWZu+EEzNgWueEbtG/XThhXVheenwSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fijr9jpB; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso5164095b3a.3;
        Thu, 03 Jul 2025 05:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751545058; x=1752149858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaGiUNl1iBRx9vZSl1UOtUK69jC923eAmmhplXJdGDQ=;
        b=fijr9jpBDmVnR09LyNbNYIWAgMhRF1vx9ajpQfqVTkBRRUBaGM6SwGUjZuDTHwrAYT
         ZucVaKSL07ZYyMMRYFgpQ9sVDdsomSliGx8N67FJP51faXtKE93mxIHwbupx7y1rzwd5
         dZpHmdLFZlRTemMU1PisZvaBQkmoFu8AbsI+8twvDsI6JvunBJwjNpZ1KGRvCEb631FK
         QD5mBsBloCOJK7Wm7OGPjG7EunZg+wKwXqfFGErHrdOLnOc+ghjz8FsAx4Uu11aKd0wC
         UIwEG1vbaWsKmeR38eG0Ua6V+xSIBowW7kDLKA02yf6Y6aQu962Sx4WMya+Sx2BbulFY
         UHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545058; x=1752149858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gaGiUNl1iBRx9vZSl1UOtUK69jC923eAmmhplXJdGDQ=;
        b=RDyDvtoRfaYE3B33ANvfuv00zw9dPXR+OrjbL2u2XWBodBuDtF3pahg1mU2SvCc/mE
         KksP4om/JLK6NG8AlG01bEfosujABX+1wtzL1rCz1rsc8k+lArseElYx97teDHyD4LOe
         vjmlbb1r4apAYGiVe4vm+XSRgOhxkPTIbP7IJ7BLkc6VukimsFp3AbExj1O6ro5Vgqd7
         lO6I2IvQ+jBa2xdvdzDJep/Rak6StyLYPcuheXe4kthtHyJXqOmaEndE6IuujmjNMR0A
         M3pUR4iT6YyDNOCtpk1p3qxSOBWkj59iJ0QOizSNAdsDQ278jaGSibURX39wGmcOtgyF
         C5LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTphJ9Lgv5pmul3fEOGDoKCIpPPac5wmt4JNAkbCP84zFg/nXKYSV2hwvilBjozFg807Ujq/XEbQ1h51g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZRNXiMLeOJ7BEMj85Dxym3nwdB4apKesrD+a91cQ3mrzc4yTk
	kbFSm10EMof+oz/PbdmSYqiXFH5z3931xBWEOsaJ8Us/y5Lvi3ECI0GBB2tux0LPqSQgQA==
X-Gm-Gg: ASbGncvFAABI1/u/fKPSiYdcAG6vAZmbTJsuzt3jBDnDu2G+pnuPHJKSWIrCShAp7K9
	pqYu2UKirEzZOiWiHzwE3r+nGNvkmy1JEbakCaYYypWqFgu0Zbkh3E+7jS0A0nRJ8RIrl3lwBwH
	8g49vtHBFHbbxKxVHEGujZPBzbMpy9ZnuqVuWgV5N9dI+lKBwczsnU1h4dkJajCIoTdNYJSWtXi
	gKHM1bG2Ne3tpdgwmkEOnyoV5Ix2/0OuxWmxI30FfsxX+2I1AEtD+QykRuJC1x5UO338eqas8ap
	8PIH8c0JULXKTvMzg2x7Ii7TiSkh21Tc3K+P/CO6sBsXcZkY69lIl92Lpc3uUh8X4uUXD92IVAe
	t124=
X-Google-Smtp-Source: AGHT+IFd33+5uoBPSOYpZb90uEONHRbfm+KECGD2FG/1p+5d/6e0Qq5VXpLhER0kVpb4D/msj0eE8Q==
X-Received: by 2002:a05:6a20:7284:b0:21e:eb3a:dc04 with SMTP id adf61e73a8af0-224096f8744mr5591971637.3.1751545058316;
        Thu, 03 Jul 2025 05:17:38 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5575895sm18591081b3a.94.2025.07.03.05.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 05:17:38 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 08/18] bpf: verifier: add btf to the function args of bpf_check_attach_target
Date: Thu,  3 Jul 2025 20:15:11 +0800
Message-Id: <20250703121521.1874196-9-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add target btf to the function args of bpf_check_attach_target(), then
the caller can specify the btf to check.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/bpf_verifier.h | 1 +
 kernel/bpf/syscall.c         | 6 ++++--
 kernel/bpf/trampoline.c      | 1 +
 kernel/bpf/verifier.c        | 8 +++++---
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7e459e839f8b..5db2e006d5ac 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -926,6 +926,7 @@ static inline void bpf_trampoline_unpack_key(u64 key, u32 *obj_id, u32 *btf_id)
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
+			    struct btf *btf,
 			    u32 btf_id,
 			    struct bpf_attach_target_info *tgt_info);
 void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8ce061b079ec..b21bbbc4263d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3596,9 +3596,11 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		 * need a new trampoline and a check for compatibility
 		 */
 		struct bpf_attach_target_info tgt_info = {};
+		struct btf *btf;
 
-		err = bpf_check_attach_target(NULL, prog, tgt_prog, btf_id,
-					      &tgt_info);
+		btf = tgt_prog ? tgt_prog->aux->btf : prog->aux->attach_btf;
+		err = bpf_check_attach_target(NULL, prog, tgt_prog, btf,
+					      btf_id, &tgt_info);
 		if (err)
 			goto out_unlock;
 
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index f70921ce4e97..8fcb0352f36e 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -908,6 +908,7 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 	int err;
 
 	err = bpf_check_attach_target(NULL, prog, NULL,
+				      prog->aux->attach_btf,
 				      prog->aux->attach_btf_id,
 				      &tgt_info);
 	if (err)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 90e688f81a48..8e5c4280745f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23451,6 +23451,7 @@ static int check_non_sleepable_error_inject(u32 btf_id)
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
+			    struct btf *btf,
 			    u32 btf_id,
 			    struct bpf_attach_target_info *tgt_info)
 {
@@ -23463,7 +23464,6 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	const struct btf_type *t;
 	bool conservative = true;
 	const char *tname, *fname;
-	struct btf *btf;
 	long addr = 0;
 	struct module *mod = NULL;
 
@@ -23471,7 +23471,6 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		bpf_log(log, "Tracing programs must provide btf_id\n");
 		return -EINVAL;
 	}
-	btf = tgt_prog ? tgt_prog->aux->btf : prog->aux->attach_btf;
 	if (!btf) {
 		bpf_log(log,
 			"FENTRY/FEXIT program can only be attached to another program annotated with BTF\n");
@@ -23850,6 +23849,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	struct bpf_attach_target_info tgt_info = {};
 	u32 btf_id = prog->aux->attach_btf_id;
 	struct bpf_trampoline *tr;
+	struct btf *btf;
 	int ret;
 	u64 key;
 
@@ -23874,7 +23874,9 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	    prog->type != BPF_PROG_TYPE_EXT)
 		return 0;
 
-	ret = bpf_check_attach_target(&env->log, prog, tgt_prog, btf_id, &tgt_info);
+	btf = tgt_prog ? tgt_prog->aux->btf : prog->aux->attach_btf;
+	ret = bpf_check_attach_target(&env->log, prog, tgt_prog, btf,
+				      btf_id, &tgt_info);
 	if (ret)
 		return ret;
 
-- 
2.39.5


