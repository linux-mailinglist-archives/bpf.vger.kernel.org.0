Return-Path: <bpf+bounces-45758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE729DAED5
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 22:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9876DB21D8A
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 21:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9852036FE;
	Wed, 27 Nov 2024 21:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlUyOTvy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBDE202F91
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732742434; cv=none; b=gXwMkrgXfMIfbb7y7VL9ux1VD0sJK2UDTVcwC0+4cPECauV+0Qe959eoCbmG2HRVrG7tVE4uVR2a59zD04UXDLwnhLDdv2pXn4hUIvS9QnCefv9fapxsfe1sbNPN2eC8ZGCmsDbAcj4GzvWZ0toB2KaHU8Gw+oijDY5AzGSouTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732742434; c=relaxed/simple;
	bh=74rzKpRwL/eGKHdxgXp12BarXCS0xTMFX5QgJJZavQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8CEmEpxztKNaQQwZrv/4to0rJ8pKyY8r+Z1MtHFHmV9ZdKz5ITsA1xbWYDNwURanAJtuEeb28vxlQDANQsG2ht7p4cnK+69RA/0yM9K8la5aZBrcGQT4H0x8I4bD7//gIPxZ733XyMk48OcTDNaMbGM2iD0yiszsRDwLjnLY+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlUyOTvy; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-434a7ee3d60so7745285e9.1
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 13:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732742430; x=1733347230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6PTl9q6lRBH3tqDgsxX3DlWVqzehzzOiqJYZ44e9sQ=;
        b=SlUyOTvyJ/1AbMCnlZaK4yPkappoBCLWf58gDR1OR+PLPA3w3gn/q1/dg2UIQwaDL8
         VjgSqaj4S32OD9JysREHU7advRoEMryp7oHKfuhC0jKJhbWnwGuCNUH//MTfElfGWUAE
         hR9P2421BayPopZ9dERvtE8UaEvqMhVqnXP4FjbycycebZkIUzZHd+2SKA4Byts2FfE/
         uIWkAXOytzk06oAXurA9QGp/6ynVIdhye0JF4O52DlOlywlz+s0fbD7XIk072cm1O18q
         bX9L4p8utNaoC8b/Aba/Nn3YBqlgLwchM6KZBcbXFvrA0G/MM7Iz9cJpXa4DyIXGD8b4
         WhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732742430; x=1733347230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6PTl9q6lRBH3tqDgsxX3DlWVqzehzzOiqJYZ44e9sQ=;
        b=QX5hboAkrd3zCk43fs1ojTX3bmGAsZFMVyiNxozhdnJDprZ/kOMw0MKnCZ9ltxiySE
         yJQprlD4v00rwvUSHDyN8oZaX1VUm4SdcsK27/1GgMoQs24wOT0hpOfyv1g4aV/+b3J0
         SEcndQZEleNxL3URNDI13WSzBb3rg3sQo8AQqWdKrzyW7ontFyTRxdTdtatqnAyOC5/j
         F7ZhyJRC4SW5JiB7svP4GdZ6eE3ZbKw0ZBnz9TsSWzZtG7XYE65Meg2ZoIwieBIQptIZ
         6R/1Cf9NUjc9J1VfR6jm28+x1Zic0tjjlqPCFQwe+Ecrz2VpCgyi61ekf66muJX59kvt
         pm+Q==
X-Gm-Message-State: AOJu0YxoS3HQWrenahxPuc3uTjy7TGsTKahyMuJvdMLpD21oBywjOXCP
	WpRijNITElc/CmSgRCwMTeO9Su0ttw32/etWELlKyB0RukbZXJsXjTkkFs950Xk=
X-Gm-Gg: ASbGncuSOAIiEQMqhIZhUCSscwAr3t5NGzaij+zDc0rEQLBFUV+OSNYcAmfl4CQQI07
	y7se0Qxh+UhLpOyfBC5kXF/cIDh651/C59kxZ8s/UovcQWtEowcQUt+0Cacj73iGZLoU0U1ktEO
	pdE3S2fp6ELQEzAfqeVOOsxLQ8xn4NNPaD/01R6eGJf4s03A5gbW0+xLhbsIf+RFkDEKoyF4lPy
	/8vmTCFViKQt9NCAcKrFYmp+C/NBV5aq7iGv897R5OZY0p3eYwwoCOPnOzHgVV8rpWhdNbuLemV
X-Google-Smtp-Source: AGHT+IH33D9vtTuZG6x1bbiiUxJ5H7jHMpdoDxsTrir1CRaRaocFEtf2tfKIi7nP0TwxPA76JySqKw==
X-Received: by 2002:a5d:64ac:0:b0:37d:47eb:b586 with SMTP id ffacd0b85a97d-385cbd5e8e5mr696820f8f.4.1732742430335;
        Wed, 27 Nov 2024 13:20:30 -0800 (PST)
Received: from localhost (fwdproxy-cln-009.fbsv.net. [2a03:2880:31ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bef8sm962145e9.7.2024.11.27.13.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 13:20:29 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tao Lyu <tao.lyu@epfl.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [PATCH bpf-next v2 2/4] bpf: Fix narrow scalar spill onto 64-bit spilled scalar slots
Date: Wed, 27 Nov 2024 13:20:24 -0800
Message-ID: <20241127212026.3580542-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127212026.3580542-1-memxor@gmail.com>
References: <20241127212026.3580542-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1823; i=memxor@gmail.com; h=from:subject; bh=VSaG2aEiYQUl4a9ZAUYAxytzW7sudkJfqBWXv3xLgKE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR40B93ZwHlbiqdt8rLpZ2/Jb2u1TW6xfu9IN4Tm8 QtS3QOGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0eNAQAKCRBM4MiGSL8RypmaD/ 90xa8EnbDdiVaQg1ndFRb0jDFRbH7MOx1vnPtFdjdN1oKNlURmXOkX2is473DNLNEKvpBBqqDz9RER lQwYooVxyP4K76IVaFOqq7BzJjparwnFhmPXLF8L6cCbzA7V6Va/lAMTuWJ7CaYEpClCH9B7onPvvL jGH5yfUiIhpoQJPxg6yEpVowqGFpsAWOfmKOh3NfAUW1qX+jJDnws0hKOpUYnlgOz1MvRigc466BK2 vMsqpoI6C9eCijqoYqVee+wCeaINHlFLKL6Z7V26Qgz8LGpYQH0PCXhJLw1WdnvHQv88oF0mLpnPIe 8woKJizK/5dWDavtD66765nuO9aht6Kq9tprA3cPEpO35+L+07JZCWAcfzXvx1IqghAsDGFN77UUSX UitgrXCuekTPuhxND0UnOPndguNwIJREXLvN4m55VI63KfcoZTEBu6TDBlJUOCBntmrQ9sjI+20pOt f5YjgZARhOs9ipbizPf1UFZCYwSCXEL8oc0xKpjjvPtrA/QLF0V0BuHVz3Z08GP/g36lEDh62TVWAB /KNsvmPIDxj7ldfNRWbcGdnKsj6kRMcmxa0jS6iPzRH8KYFE855C8njVYycgnw9qj0OjsQWa2k/+to wx4c4gB61b5SZH/cwpZdRM+Ij6Ty7Y+aU+S2jG+I5CjEb0AkHNZ2Tm+lBg1g==
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
Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f9791a001e25..7fb3aa6561f5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4700,6 +4700,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	 */
 	if (!env->allow_ptr_leaks &&
 	    is_spilled_reg(&state->stack[spi]) &&
+	    !is_spilled_scalar_reg(&state->stack[spi]) &&
 	    size != BPF_REG_SIZE) {
 		verbose(env, "attempt to corrupt spilled pointer on stack\n");
 		return -EACCES;
-- 
2.43.5


