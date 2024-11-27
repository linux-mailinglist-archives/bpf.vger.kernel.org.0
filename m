Return-Path: <bpf+bounces-45771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5389DAFA1
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 00:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32C5D2821AA
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 23:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15274204089;
	Wed, 27 Nov 2024 23:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuZFa9TD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA29202F98
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 23:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732748514; cv=none; b=PXo0n3rdXUMtGRZ/ci+LfcaAqMCFl1Yg4RFsdt0Mwq1EOs2jEsQy0LBisY0PaFZzlf5lu1tjyp0v3CIlGbx9RYc6VFCG+tBKj/3EAtJsrAyb9DmRY4Lf+w3CvAEFBfR5iy1U5OCjrXDywh/uLZIt85R6BsIHlgapAZfxnduv43M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732748514; c=relaxed/simple;
	bh=JWUUneYv8eJXdEpOFXY3L9UGkUO5U1v8sN6VQXEEKsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAAq2f73XV3H93cEss13BCvkHC8Wy0K8E5W19UMZ9yAlY8fiSQttErvMIquba9ub7jRZ7Cct2cdb+5LIp8Gr568zAbapOfb1TtOHJ1ELYS9FJhZib/uT27TBTE5G51Bw9HRbfXQMhsvrIOhgVTG77rVUP/1riq5lEemWGaSuqxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuZFa9TD; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso1491085e9.3
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 15:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732748510; x=1733353310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhEj9lKl0l+ZK/B6XyOtKPhCvG1ZAco08kS83oLl0e8=;
        b=XuZFa9TDRNBXwfRUeVT+GqO9BmLnXlVcCerKN2v2pZrrcrjMlilgX97apogf80dBt2
         qqXNhT+e9lhlJc7jAKmC4yPdN9NOOwdxMs5wRwnS8GbZSdXS03q8hx//pyXuzaHCo07o
         VE6qPtUFlAx3p9TmoSNkaMdsO54QtnWmmjK0NkTCR+V2aptBfVy+X20ScQv0TIbqkSlG
         +ewi6/JjLKjG8pZWk3w4jit2uCC6DYMwMvF9xbnucTKlNS4Si7L26eFVssbPuGua+3Co
         rvlhsdtyNQ1gh0QmDb+qfi+6KfSC2MAu1PAAzEdNkkSYD1V/rawfHlnk/4qdFk6hufiS
         vnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732748510; x=1733353310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhEj9lKl0l+ZK/B6XyOtKPhCvG1ZAco08kS83oLl0e8=;
        b=LJYdxLrO1GdZI55WsNPV0s1pL7fhkBcY9wZx4y69iWm+WpgyHe3PKxyiSmdeRb1jR6
         6qfq+b/aygJqBR7Aszl/i2FJ3Cbr0zfJMvtEtT0AstiLA6WymqutEUrBiLm2XEdnyPYV
         exn8ClymDzvnGFE0CDPKihX/Ibys+on20Yarg5BIVPJ5VDmvlm2njIKO6bSbzLrv7zAV
         vjlEqDL8Vv2yJsIxYJYNsStWTWkOYUrZ+EkhOKviD7EgkpcguPtc1HkPtZVdYq1rywqg
         mrqWj8EC0I2NlWAc11zMba0QBZ7roNcrWhtXURoktXckv41tq6WVm4PQ3m2Fun0i5/e1
         Fjjg==
X-Gm-Message-State: AOJu0YwQHPxwomGhkYp7tq06ZD7xaud4K9LxrPc6j1X2/GPl00qo13kK
	Mp1OoW1hyTcewA9aShaH7eCAKxRekMaLMn3WbSMJZ36e6cQjArRQvr5AP/RHjro=
X-Gm-Gg: ASbGncvkwLPsU4Zwg149EosNE3pYjVybuJ50/S5eDNrNqtD2QzjtH/cPyUW/acFO1OZ
	cSUBH9GNrKGKcxSMZLvV6Nccl4CFccLgG+loPYB+Uuh9kghala4UBQ8mDYhomXxE9BOHcEtl4Vd
	kPycNBr3scFSwm3G3lz0ADWiPS6+p2CqubaafTuZifX2TyVrSKXEfns+jSFyCnnRoOW6jZAao6I
	RiuCXc53/mSRMu6mkQ0pvbsLMfgE51O5eT3OTTko53sMTGIT+wfIXfwiyzlmcvH0TtbuPZXSMO8
	wg==
X-Google-Smtp-Source: AGHT+IEFggdS6TO2kKS09OAS1BajiYwed+pbweMD+b9OXqPIudCIc14z9wNIf6A2r92rpidvKfChBA==
X-Received: by 2002:a05:6000:1ac5:b0:382:47d0:64be with SMTP id ffacd0b85a97d-385c6ebefc2mr3715335f8f.29.1732748509999;
        Wed, 27 Nov 2024 15:01:49 -0800 (PST)
Received: from localhost (fwdproxy-cln-037.fbsv.net. [2a03:2880:31ff:25::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd2db43sm77174f8f.7.2024.11.27.15.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 15:01:49 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Tao Lyu <tao.lyu@epfl.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [PATCH bpf-next v1 1/3] bpf: Ensure reg is PTR_TO_STACK in process_iter_arg
Date: Wed, 27 Nov 2024 15:01:45 -0800
Message-ID: <20241127230147.4158201-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127230147.4158201-1-memxor@gmail.com>
References: <20241127230147.4158201-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2564; i=memxor@gmail.com; h=from:subject; bh=Djrxmk+fGDtdvKlSWe5XHFPJVv1Xd5kIuafvO72r/6Q=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR6TV72yQM6U+cfoac/xp/F/Xg52i+yWCQ7IsgEjM HhtEHqiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0ek1QAKCRBM4MiGSL8RygZmD/ 91tp8ZBRF4mq11EoXP3n9l0KA5ljZtcEyRZozZ54FruRZleanwtFP8BWpsv86F46wThh5XS6qqY7Q1 jKrcVEMQ/B2Df2tsTAO5l/FH+EcKFab7mCIyQnSjs3xZFmnv7vFgaQTgXWg3kQxkuX2gn69ThM8Nqj 1n4OQhQWNWoyCcyKL0OTKsC/H0DHHtzHBViUQ9DnIuz870OeHpAG7U4cwDIGwi4Rg1RFmrrqlQrsq9 1QnfTJYIxl5zCQDccyhTN6gxstQu3aYr0623UaIuzIH9JfYpkxaybVb+ddvxJLnk2l14FSYr30UAUS RB8W1xMjBLTxqSXZVPkygHxYKDF3RhjZVEfbCsDvauMn9E7fEVXfaVpVICivPtP88VhFpWB7Rc+0Nv PIFKadGwKMPuDjZGFkVTeb/5ShVuy2WJSn2aFwl66ejL+i2m1yIYogZtKnolmgoSa/m5P8wFa4NioI WbPtGEEWM0X7xZWp1MF6iAIF3IQm3ap9sbv8PE2vHk+eyYopmKQi4jbxI+CGEEn79x1RvNiy8TEwWm oAX28rgBUL1oq+BtsNV1zArNyC3MCrOx6NAlzzqQUO1OITMdvr56DpZr9Yakp0gNkHB7DDRGWW4mkF Eg70SZLgT8nGEwM6keeJvwrYOOW1dw7RAlyKuA5OcoGHbZtMnHBRbtU0sPNQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

From: Tao Lyu <tao.lyu@epfl.ch>

Currently, KF_ARG_PTR_TO_ITER handling missed checking the reg->type and
ensuring it is PTR_TO_STACK. Instead of enforcing this in the caller of
process_iter_arg, move the check into it instead so that all callers
will gain the check by default. This is similar to process_dynptr_func.

An existing selftest in verifier_bits_iter.c fails due to this change,
but it's because it was passing a NULL pointer into iter_next helper and
getting an error further down the checks, but probably meant to pass an
uninitialized iterator on the stack (as is done in the subsequent test
below it). We will gain coverage for non-PTR_TO_STACK arguments in later
patches hence just change the declaration to zero-ed stack object.

Fixes: 06accc8779c1 ("bpf: add support for open-coded iterator loops")
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
[ Kartikeya: move check into process_iter_arg, rewrite commit log ]
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                                  | 5 +++++
 tools/testing/selftests/bpf/progs/verifier_bits_iter.c | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c4ebb326785..358a3566bb60 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8189,6 +8189,11 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
 	const struct btf_type *t;
 	int spi, err, i, nr_slots, btf_id;
 
+	if (reg->type != PTR_TO_STACK) {
+		verbose(env, "arg#%d expected pointer to an iterator on stack\n", regno - 1);
+		return -EINVAL;
+	}
+
 	/* For iter_{new,next,destroy} functions, btf_check_iter_kfuncs()
 	 * ensures struct convention, so we wouldn't need to do any BTF
 	 * validation here. But given iter state can be passed as a parameter
diff --git a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
index 7c881bca9af5..a7a6ae6c162f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
@@ -35,9 +35,9 @@ __description("uninitialized iter in ->next()")
 __failure __msg("expected an initialized iter_bits as arg #1")
 int BPF_PROG(next_uninit, struct bpf_iter_meta *meta, struct cgroup *cgrp)
 {
-	struct bpf_iter_bits *it = NULL;
+	struct bpf_iter_bits it = {};
 
-	bpf_iter_bits_next(it);
+	bpf_iter_bits_next(&it);
 	return 0;
 }
 
-- 
2.43.5


