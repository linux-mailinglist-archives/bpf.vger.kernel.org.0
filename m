Return-Path: <bpf+bounces-46057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB339E32BE
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 05:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF8D280E8A
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 04:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649D317C7B6;
	Wed,  4 Dec 2024 04:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4s9eNSd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4104613A409
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 04:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733287686; cv=none; b=m4ub3P2b6qqmYGXmVnG0Pbq/ECapFY2TanG96wgH36Tp5lHX9bOJQAKF/WhLKEFXJ6jKhx2qfb0mx5X2KiH38tHVEoq63VB8Ihqc+CotbjNY7RxOBxWibjS/UFm2oDCTFaqB28O85s5Bt/pg3YB02Ev8bNc3svxJPCE0F8VsD4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733287686; c=relaxed/simple;
	bh=7zraTB4t6qK0NHyA18gJSSA90vuh8frNRUo1vvIlnfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3eS3jwppS5EExKKlonpesPpiLT5kexoI/4yXpTu+r9SVBGveWHZs6MZMMNFomByrA5jHY75LBVwpZDPFdr51pAGVjGEw5L3NDKbsOfYovNY8dLcDEDCzhPUzzWY1aBl8mj9x9mdAC9extn4whv6LpVKNh8E40+s6msnj1IoMTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4s9eNSd; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-434aabd688fso40754735e9.3
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 20:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733287682; x=1733892482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FA3G4MRxUkjHPHVc8QHcKTvZLecg2jgLMCWmbSH7n44=;
        b=j4s9eNSd8HnBfZ8QBtYpDnm9U4+3NkM9jDgqYOjvrjdOrbT+jdTeDjnWKIj2QLxATc
         ZHYt+x59Js2EaPnYfx1aO1eODQZaoHj2BAizSmAxzaLxcUkyfKDO+K1fPHRreNacKVo7
         VF/S2I2xxbVdurPXKJj6PQaqlTi6tBBV8vCY3wxvcHckzDlaQCFyXQsoPfmlofhGsp1C
         FfrRNiWMYB1dA3pqhyoMW+zseXwBOx8P6UzHVFE3hnB3SAL0PJrOwi2DFbmVfuIwZwIk
         nVwvNFd1ZObeVgtCduGHDJc1TVRCTU69OYrPtj6ySi3QDcYQ/9nBEHBEkfFqrHykWXu/
         5SoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733287682; x=1733892482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FA3G4MRxUkjHPHVc8QHcKTvZLecg2jgLMCWmbSH7n44=;
        b=RpEcUR8weo+DBuCFXsVju/nHwR4g8rdloMmv1shTE8b8a2L6ZhOiwSJ1srEzJQv7Cl
         WATpdle7IwYhVVmkvkw1EORN5TSP4d6sMZriJqSypoL5zSrsTcVxTHReU/RndSHPDmS3
         EVwxg4Hv1F8kzyK61pKQptha+JoIbB0dB0NOFRrjZFFWxUc6PWO4p8jS3NQa+v3cLBWb
         ds696LVQO4Ey2Jnk/Em/YCJf1cT3b/96kHOh343dpkmKn8hy5da3iItpG1toTScE1GAU
         9AdKqaq3VH4PDiOwtBthr2VgOcYqtKeSkQ/uXlLaLMSWN6cmv5N3i5Y+D4F5ALWwMgup
         bhyQ==
X-Gm-Message-State: AOJu0YxrAyK76NssyclPWVCCEvEoVhEtsOLSAA6UgrMo8p4wZ3O0bSY6
	qJSqIYc1sXTXCQlx6eerR2o7encisygS/zYJq7zUhD+WK3HZJuyH9Ty9ysSh2Rc=
X-Gm-Gg: ASbGncvERAzTLcvtzuZqR65Sd399GZhMrHodQcxNGizidBjYaOdkDAxD92CiQ7hhvCm
	fviFByCYGbWjMaIqBRnFD3QZ/XI2iAik0tY44O+t/0IEurqAEpmNKLanb3a2Q2dxACy0tkph7JN
	BpLFHkTXOrkpyw8Y1Cwe6/Sn3kFVgg3UybVlDT0T5lYxk45XL1rdvlWMwX8TYGLYWa0qMsBGJwq
	HZtly7tUQ8BbdmpXrXj4BvbXTt6HVBbvoLv46HPvzFtTrEU8q3cU/6Qj0gb9A+s/r0cxUYq/q4V
X-Google-Smtp-Source: AGHT+IHTggKGeJbNA/HNEHaGlbJ8HfBo6iN7shXkTcL+ko2JW1Y71F6a5Yo05OWl22Wc3wvNJfHAgA==
X-Received: by 2002:a05:600c:19ce:b0:431:5871:6c5d with SMTP id 5b1f17b1804b1-434d3f8e454mr25832605e9.3.1733287681912;
        Tue, 03 Dec 2024 20:48:01 -0800 (PST)
Received: from localhost (fwdproxy-cln-013.fbsv.net. [2a03:2880:31ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d528a683sm9957045e9.23.2024.12.03.20.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 20:48:01 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Tao Lyu <tao.lyu@epfl.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>,
	kernel-team@fb.com
Subject: [PATCH bpf v4 2/5] bpf: Fix narrow scalar spill onto 64-bit spilled scalar slots
Date: Tue,  3 Dec 2024 20:47:54 -0800
Message-ID: <20241204044757.1483141-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204044757.1483141-1-memxor@gmail.com>
References: <20241204044757.1483141-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1918; i=memxor@gmail.com; h=from:subject; bh=UgiEKh9fSP+5XzC/3bnvwvgWbv9Kje5tMYX9wJ+5u6k=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnT97G3KD36TLUD3BnYyK29AuE1TuW7OnqccI1Txx2 A1L0ZVWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0/exgAKCRBM4MiGSL8Ryn3GD/ 45R+nbQb9UZn3ojSDHAYBTc/UW8hoRKYZSaxD0teWJxeLIprfNKJwuB8oOFZBm3Kx5RkjUcLqAk0GR xScnLNOJhG9KWcginp/Bx7A23IjPP7lcmMvBXDtlxFPjMPkXCCZ+X+FB9YOrBG6PO0aKiLPYOOdPc3 WmOVIAFrwxC7ZqltlRHs8QxaCfQeP1+beMuxs4agXErubNMqySABru/+Y7I1Z/mA6MLtaY7gz10Rgb YMz4qSRL/FQ7hHXayDUxfvoLmdBLQWOTB4p0DbvytcJhYT5VRVFDc8k319Xuv6+qOBf7QkXKfZcuu/ K5y94DUvqXSwn719ZnBkym09ukAuqg/GCI3dOtFAt9N6K2JdOjgIYwv1crO6/yNl2Z3IgF55A9gDJ3 MMprrzsvWYQu08lLb3QSQkTYqV5txHC3rTd2RnXMEn1aN9ZvbgeX6YlbKV/ewqnIUoBYKPnrEcNih8 HjQGPC7MFSjUgA0PmJcARW4R8alq+wtJnccRrXlrZ2uNArXFCCi3Z1/dQDu+NobyLI36UIsOlobGEB idDB/R+jQCkuncPQmPpzjvcNA7H/x3Cn52Qp5pbWB8gaN/LQoTsqo4BDx94aEbU4Vhj8X04FOqGR/D N54/QESq+2v2lBONEJQFj86ZzU0339GA6PYfbEtqS20P1TqrI6mSpjDgfobA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

From: Tao Lyu <tao.lyu@epfl.ch>

When CAP_PERFMON and CAP_SYS_ADMIN (allow_ptr_leaks) are disabled, the
verifier aims to reject partial overwrite on an 8-byte stack slot that
contains a spilled pointer.

However, in such a scenario, it rejects all partial stack overwrites as
long as the targeted stack slot is a spilled register, because it does
not check if the stack slot is a spilled pointer.

Incomplete checks will result in the rejection of valid programs, which
spill narrower scalar values onto scalar slots, as shown below.

0: R1=ctx() R10=fp0
; asm volatile ( @ repro.bpf.c:679
0: (7a) *(u64 *)(r10 -8) = 1          ; R10=fp0 fp-8_w=1
1: (62) *(u32 *)(r10 -8) = 1
attempt to corrupt spilled pointer on stack
processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0.

Fix this by expanding the check to not consider spilled scalar registers
when rejecting the write into the stack.

Previous discussion on this patch is at link [0].

  [0]: https://lore.kernel.org/bpf/20240403202409.2615469-1-tao.lyu@epfl.ch

Fixes: ab125ed3ec1c ("bpf: fix check for attempt to corrupt spilled pointer")
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f18aad339de8..01fbef9576e0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4703,6 +4703,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	 */
 	if (!env->allow_ptr_leaks &&
 	    is_spilled_reg(&state->stack[spi]) &&
+	    !is_spilled_scalar_reg(&state->stack[spi]) &&
 	    size != BPF_REG_SIZE) {
 		verbose(env, "attempt to corrupt spilled pointer on stack\n");
 		return -EACCES;
-- 
2.43.5


