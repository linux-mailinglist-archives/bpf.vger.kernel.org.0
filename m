Return-Path: <bpf+bounces-68072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE46B5257A
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 03:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443801C24FDE
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 01:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978F62045AD;
	Thu, 11 Sep 2025 01:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAdfqtD6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5711DF25C
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 01:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757552701; cv=none; b=F5yLeWkdpUx+Ns0FvpTstCVO8jMKuBIczkrV+ubYIOzlHQhV6oBpB5YOPlRIMtkGft7A1nkuXHHq/mvxUZoYAC31uSOKI+q3Zlrg76yL5cgOz0nM8AhET81uomsMoNumgkqrBfn+uEvqyNyR96GzmGEeft6rBJUiHfjwEj4AgEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757552701; c=relaxed/simple;
	bh=xfvIdMVhwkRkbyvyOyf+Uy6O0aEgDk5SJz2Hs9PIEoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNy2hJwk4TYr/pNxYrbJS1J2Y4+HnwQzAAFTuNN8+fguVuz0nN7kmhx9ZV3fSZ0RpF39flFRnP4dBcb2eLO5DL0TcF0iWZCHqyOCqytt3x0R7cHmM/nZ5JfNx8MYnpOHbgKH7zRmbD2InhAbyvXGH2YonLf1i8qvPVVCTImzuuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAdfqtD6; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32b70820360so137354a91.2
        for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 18:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757552699; x=1758157499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTpDAapgO6XTcnpalUcZirfS9jVm3R+VxzCuUzx49O8=;
        b=RAdfqtD6Fl6BuCOcrNv2MdCgWgaYR/AwIngrpVvoHagWl/eMa0n2UYD8cLDotJaAJy
         lBoyG7AL/VstyAUzyqCh8rCeHXXO5jxXmDncvW+XKZ75rpqkIIAaI5DPjExUmWqGNflr
         xQywOyiRUGkdhB4Rtcnfq6DjuSMjTxP+iLY4JKso+lTRrInQPMeLogtqt6B3aS4MIlBP
         5ECn84mzlZtdVJgl1SAv0rVoREGEAfXrmvyy3O3a3JLTgC+MBIkyMHVZX1bIQm+XWLLC
         iKHGO6A1WXVnzkKWUvL68wT/BYa2PMmi1oUZFwn9YxYxgtsW44ZKNUMOjfAlCWogm0qm
         3wWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757552699; x=1758157499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTpDAapgO6XTcnpalUcZirfS9jVm3R+VxzCuUzx49O8=;
        b=kQhqBrFnZMr8OmKf5mC5s6+JSvKyjXKq8qm7Kz2YZ5o5Y5BNtaCmt2rNmhSzDQZUmj
         MubkXtlF3TVzy3mynqZ6FxYSVdJEoqXhW9PEAkXI4XdtkRnV+iJvT3fCXafBluFa7UJ2
         BnzIBU+BwtuV0fbKLoj+MXUpo7AKUjtdksu6FYUg07w8eRZ7T99sKPZ2rMJV02LxT5Kb
         DNOavb1+9Agf8q0AzWuXUVN/NnWPK0jjLsuvbsEWPBzxaNT6NjIT8C9FCzxc1SiwhJw7
         V6jH9cFFZWMH1qD0RJ8GDfU/c6KZKLv1Rhq1EmjtlRrnTXdtlyVSNt/reEWwQmEFolpp
         AX/g==
X-Gm-Message-State: AOJu0YyJLXbHd2lCyfPGuy3rni1wOJ4B5uRqaXFi95X+RuI98c/8k8bt
	wQvvtzQZRu3rlDt3mY1qiRT/2qiJmWMpVoLC6jMhb7AK1Xv5LH01e0s3zLM4eA==
X-Gm-Gg: ASbGnctTJ4BeFilKn5LWdLrZoBiJPO6YQtUlg37aoWRYCdIxaaI/qjTfrTIuWSR0GJw
	5Yq/VclZKvliKCylpIKgqslOeNW0HhNwr0dNYUg/nfdwU4CdaF4AnGymPdyOObtH8BqylNqe4IW
	813AkqXg9GFTWpFI1I/HZ717zamW8gGk4eSPuG6RRkgPvJg7NMa/7taM/crwoJRXgrXydvIxG1e
	MMCfO7Kxr5jPxNP7SsLhB0XAPheiwOQHrb47MilDVzdhh6+BN9TQzQ7wLSL0Y1VhlOZ1Mbi2DGC
	toOt61F6u7zPy7mWszCHWh6zor9XofwGMCxP938iOSedKqEJcZAMDwzlfWtaKrkLx4Or15k+upi
	I1mXxYbVaMc60voHDUzl3Kyo59NqIOiEjGw==
X-Google-Smtp-Source: AGHT+IEcMII6PXxidSDi8pOlzQ5+G/fgBUPVpg8NVCpQuPeU1WIkD+8pBCwC7ugTPQCu4x3Yc+yAsA==
X-Received: by 2002:a17:90b:2d8f:b0:32b:51ab:5d3d with SMTP id 98e67ed59e1d1-32d43f98f10mr23641561a91.37.1757552698777;
        Wed, 10 Sep 2025 18:04:58 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd61eaa27sm545511a91.1.2025.09.10.18.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:04:58 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v1 08/10] bpf: signal error if old liveness is more conservative than new
Date: Wed, 10 Sep 2025 18:04:33 -0700
Message-ID: <20250911010437.2779173-9-eddyz87@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911010437.2779173-1-eddyz87@gmail.com>
References: <20250911010437.2779173-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike the new algorithm, register chain based liveness tracking is
fully path sensitive, and thus should be strictly more accurate.
Validate the new algorithm by signaling an error whenever it considers
a stack slot dead while the old algorithm considers it alive.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 1 +
 kernel/bpf/verifier.c        | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 2e3bdd50e2ba..dec5da3a2e59 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -852,6 +852,7 @@ struct bpf_verifier_env {
 	/* array of pointers to bpf_scc_info indexed by SCC id */
 	struct bpf_scc_info **scc_info;
 	u32 scc_cnt;
+	bool internal_error;
 };
 
 static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 33cb8beb8706..07115f8b9e5f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18546,6 +18546,11 @@ static void clean_func_state(struct bpf_verifier_env *env,
 
 	for (i = 0; i < st->allocated_stack / BPF_REG_SIZE; i++) {
 		if (!bpf_stack_slot_alive(env, st->frameno, i)) {
+			if (st->stack[i].spilled_ptr.live & REG_LIVE_READ) {
+				verifier_bug(env, "incorrect live marks #1 for insn %d frameno %d spi %d\n",
+					     env->insn_idx, st->frameno, i);
+				env->internal_error = true;
+			}
 			__mark_reg_not_init(env, &st->stack[i].spilled_ptr);
 			for (j = 0; j < BPF_REG_SIZE; j++)
 				st->stack[i].slot_type[j] = STACK_INVALID;
@@ -19516,6 +19521,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 		loop = incomplete_read_marks(env, &sl->state);
 		if (states_equal(env, &sl->state, cur, loop ? RANGE_WITHIN : NOT_EXACT)) {
 hit:
+			if (env->internal_error)
+				return -EFAULT;
 			sl->hit_cnt++;
 			/* reached equivalent register/stack state,
 			 * prune the search.
@@ -19630,6 +19637,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			return 1;
 		}
 miss:
+		if (env->internal_error)
+			return -EFAULT;
 		/* when new state is not going to be added do not increase miss count.
 		 * Otherwise several loop iterations will remove the state
 		 * recorded earlier. The goal of these heuristics is to have
-- 
2.47.3


