Return-Path: <bpf+bounces-70309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0459BB771E
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 18:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963843A7402
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 16:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEDD2BD013;
	Fri,  3 Oct 2025 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZWC6RNs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3E629E0E5
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507483; cv=none; b=M8tDBPx0aY6AUiATnn3ru9ZmfTOdiUzX8Hdkt31SaWm5D7JG6hbocY70yc/ZwyB+qWW/ls1fcUzuBlUPaQ+qS1/Utf8GUcfphqVs8Qk5ygAEnR3QN2EBOTyRr8ADZworYOTOkMcOdRcND0wKIt+fGxfdubPX/0hdmuJ0NtA5Wjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507483; c=relaxed/simple;
	bh=uk3I6TytcVIyhPST/4akUxzoOtJlyAWfgKyaH8wXXAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHKhcB7kOBltyWTdZuCl8stjzd3O/2RnAK5LytRacCSBMEFT9CJyD0v4RVEp3tdmad3/+wn2NHgi0TZT4XclOFSDBgioZ0US3C/Le9GnSzZ+s0OcaRZy5zqWeUlC/bbid88HfB2ZYS7nrcvE8izH/zIs7hsQyc1iMTuEuvz+49U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZWC6RNs; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso22129775e9.3
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 09:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759507479; x=1760112279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyKW3MwbZ9VvsXDrg8YjfM9aJ7MpvQj5qrDOXyKVHPI=;
        b=XZWC6RNswqSpIuYEtwZjx9SCAlLZXYtsCzWi4yDlPPeXKZMFS5BcoiIkb65PSX3aBB
         W+ijWEf+CZB6DA4Ep+TqMZHXiLHfrw8MvupLaeErrTol9n5Az2UZ5xcPKEJ3JueR+0/E
         rBZ8o0zVc0QPjK6AoxncYCkb6mwUP2pLpdsd6iLULUidF7fGEEkc1wOyU7MQ1Wwr1NT9
         yHlgnB47IenysV4J2XSIB4iAgdMC3txVs6xpRBh1UWHm9LWzg47aMmX37q11q+//S+X+
         AFo47cdmC4rkCp4/JTK/NmVY5l/I/M7SYIbm6oi8xWSuD7zDVdqUU0yzfdfSd+yFCNST
         JEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759507479; x=1760112279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyKW3MwbZ9VvsXDrg8YjfM9aJ7MpvQj5qrDOXyKVHPI=;
        b=kovKyZyoD3nsUpZaH2RyFI1odw9YC3yq7Q7vftsqa/LkYv8GgdiTTnhWdH695/OVG3
         ViETbyg8rMPaXfMjueoGKG/h4OtdFwxevVsHZmtwk3YqG7hSGygMn9wvDmevwo8PN+1b
         NrOBViI3znm0zByzh/w4NCEo7dm8m0ChXyUNNWE/1Y43ZiZZpbDysVPxbIqL+zXvRkLA
         4JwxnKKF6QfMl+kKPOQKooQjB1AdbPqzzBJNWYmh+2Ng+l/6awJ/IUbVY+KM+B5/50ob
         IveQuGOkOP8Bv7Q/777wRnCX+mSLta696iHAoUqc4smGIAeCbG549ol8V7VAoybgL1W5
         ODJg==
X-Gm-Message-State: AOJu0YwprXYBdlgckl00abXNWFZl8MHZooMEKjJlOaOzKlIMmS1VE2p0
	VMjjmZFqPGcaMNBX3KVRzj/QIpAIHHoRjC1liJPjTiBvgQ9XcPCfxxFH7wK+jA==
X-Gm-Gg: ASbGncu2RSLt2efnvKjs2yYUC4q4+dZpt9ZggIKQ28HqF0dMhfGmUQM4bTopOrCgj1C
	SxSlCyzT+NGJa5xNYGXc9S0xhk045gsdSNrLaoMuv7LJ+JFPsAoVp6lMzN6Wa7J0ky7kTmM6Rf1
	R3IoTNend0/eELmIRE0rBTMh1GJfeEkaezysb2zrwojFFu8saOz0RWrpswuUmpBY82QcEDfYw2p
	XJ8esF7LHnCSqq0+Z1sLeFsDCI+ctXarNCsWY1Jw9GTA9MATxxS9peHNNPjrhY3rE/bDK7Gp1bL
	LYVCPu4zmvirJNjrhjdot4p7rrpFVu/X/G2n5lOnCTd0cW5o1mKL2OpBNA4Ls+2sgflpPVwwtHN
	EUv2BVSfN28Bq6cRMRg6oeyqR1g==
X-Google-Smtp-Source: AGHT+IEUtiNp3ympXNg36jsiV5EHQwGAYox4AUtXD+ZP2AUQL4LAjrZ8QlLX0rukS18wRY4zRPpj8A==
X-Received: by 2002:a05:600c:8b83:b0:46e:5a5b:db53 with SMTP id 5b1f17b1804b1-46e71142ca0mr23387865e9.20.1759507478767;
        Fri, 03 Oct 2025 09:04:38 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:5b97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e97fbsm8344278f8f.34.2025.10.03.09.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 09:04:38 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [RFC PATCH v1 05/10] bpf: verifier: centralize const dynptr check in unmark_stack_slots_dynptr()
Date: Fri,  3 Oct 2025 17:04:11 +0100
Message-ID: <20251003160416.585080-6-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Move the const dynptr check into unmark_stack_slots_dynptr() so callers
don’t have to duplicate it. This puts the validation next to the code
that manipulates dynptr stack slots and allows upcoming changes to reuse
it directly.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/verifier.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e892df386eed..0b4ea18584bb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -812,6 +812,10 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 	struct bpf_func_state *state = func(env, reg);
 	int spi, ref_obj_id, i;
 
+	if (reg->type == CONST_PTR_TO_DYNPTR) {
+		verifier_bug(env, "CONST_PTR_TO_DYNPTR cannot be released");
+		return -EFAULT;
+	}
 	spi = dynptr_get_spi(env, reg);
 	if (spi < 0)
 		return spi;
@@ -11487,10 +11491,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		 * is safe to do directly.
 		 */
 		if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - BPF_REG_1])) {
-			if (regs[meta.release_regno].type == CONST_PTR_TO_DYNPTR) {
-				verifier_bug(env, "CONST_PTR_TO_DYNPTR cannot be released");
-				return -EFAULT;
-			}
 			err = unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
 		} else if (func_id == BPF_FUNC_kptr_xchg && meta.ref_obj_id) {
 			u32 ref_obj_id = meta.ref_obj_id;
-- 
2.51.0


