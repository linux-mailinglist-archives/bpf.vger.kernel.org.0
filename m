Return-Path: <bpf+bounces-57676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1ADAAE793
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 19:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C473AE309
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 17:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5635528C5BE;
	Wed,  7 May 2025 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQVKcn/9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256711D5ABA
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638251; cv=none; b=FOo7lcSStEKOGc8G6k3nfJ+lUCHc4doI1UNmBRG5P+P/lpweKPRsIrzn5R+BsQ3xI/CH6XZcPpBuMdakO/IQWLd2ECERQUY9soWFuBnvtWfYv3/LgMjIbgUO3+K0fozsAx8zLCBMa+fVcgsVOB74JwAad8Sj9xiE8KnaZP35RU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638251; c=relaxed/simple;
	bh=DWV8ZGsHPhKlA+TgWcoKqRbcf5R+lRXXqBukLoj/ZMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dezBnYT5qrR9R7KAY3uYkGj9VZWkiXnMZERiZDWoLgj4s1rPEUlpRxoJxhECrelVYluQZe1F0cHnU0qpSthcBsErJHcxUuAdBpo8zYR/EC8Ze1786My79MsxGJeOxYG9a7Q3i6WsSb4PZO/o1reNVG0P+cQSuJk5Hex7Q28X5+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQVKcn/9; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso1422045e9.0
        for <bpf@vger.kernel.org>; Wed, 07 May 2025 10:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746638248; x=1747243048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyR670O+3W2tzkq8C2esM8ZLt9R9ed5zpjVzo2eaXdo=;
        b=FQVKcn/9TDp1La/mQ9H4hEELCei4cAwHrBaLOMFPUhrGdnDCtGFEVIC1EjcZJn6LQu
         6SxcqLbA1rW7zhsz3g27sE+PbN+s4lS52gYJfaf7sNndHURvEzYn/lbWgLfANHQlKMM2
         1e79fHWpFB9fqWxXocX7ZoAv2Xdf5UWVB78PW0UG4clia+pFQDGEGTc25iTjuNy+tXC9
         cp4Ecp94tmyxPZCvwvPVuOB0Fen8n7kx6iBPaMCJu3P2U6QHiLpUEdIl/3FWe4P29AiG
         zZ+jvp3ZQ8w8t7lxjrB87xRQVmoegI+c08jZiRyIruZJbekZJAoulGITfUGKC7cdg4zZ
         ilCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746638248; x=1747243048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyR670O+3W2tzkq8C2esM8ZLt9R9ed5zpjVzo2eaXdo=;
        b=nslXAWE7Od2OLyi9FEa2YGGQ6lTdFk75gabjDIXI77LEpJ/etk87Au3NgM/KpX3FCX
         ap+wt6s20u4xCCEOqKIQWdsL8OZVtoBTjTgIkhqJkb89LTHJxAIO6KTUgiZKZ/uCBCs3
         Ejg3x1wZ8rfAi5ZZLT9bsw/7+KgizEIhlaxLRHNrRm1y/wUk14NiBA2Jb0kTPT9GismU
         ZStI/pPoKyFI0dftUevzx2wCaT3eUBlvqb3gdEVdFlKlsYucLY7SloGdwPBFLjIpR2oz
         R/1N2E4c3jx7GjjsO+Xypm0vshQK3tBbedRpqytlDVyWsSOEyasTIf73W6AVbt6kLhgt
         +9JA==
X-Gm-Message-State: AOJu0YwCKHFQulhgGmz3T9MTPmvO7/2+cE6RMiWz84vHTGveMlhjmKG3
	1buB5xbaAy594GEBkp9QLuhnprfXPRkuG9rtg610BH5HJ0SxtImQejtL05y8bIo=
X-Gm-Gg: ASbGnctVF8Q/pNSXRArbN5usuFTr4pHxN2q6Hkfcnf3QRzRZKQw8Ypw4ZUEwMd01VbK
	m4HvU29oY2XmCikJW394mOYWbfntpdRMn9OvrIWSq4LylH2tn4Mmf/Hvv5UDqU6PQWk0BsX3FnU
	LgHNHMngTA340UAvqQYm3OhPrqLTtkWY5XAP9knbtYj/13MhP53JY9PL1o+MMx+K04H+Fdergpc
	6X8klMleHWefLYkIvOGD+AK2ffNzBmqokf9P9WyRiv23beJDuThfPOfOptrSBGW4HDP3jIzAr8r
	aXkCIuR7Fpn7jlf7F7gP5mHK9PQ=
X-Google-Smtp-Source: AGHT+IEui8zduakqx/I02VE8jagxy9sBLScf2douhzZqNrAOs01Ai0NMPX71r/YeszhC+JnWgtsEDQ==
X-Received: by 2002:a05:600c:35c8:b0:43c:e70d:44f0 with SMTP id 5b1f17b1804b1-442d02f4211mr3630745e9.19.1746638247871;
        Wed, 07 May 2025 10:17:27 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d15df749sm42967755e9.1.2025.05.07.10.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 10:17:27 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 04/11] bpf: Add function to find program from stack trace
Date: Wed,  7 May 2025 10:17:13 -0700
Message-ID: <20250507171720.1958296-5-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250507171720.1958296-1-memxor@gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2862; h=from:subject; bh=DWV8ZGsHPhKlA+TgWcoKqRbcf5R+lRXXqBukLoj/ZMQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoG5WJed8+5XHFGD3Bh0ChvnCt3P1udPliNry4seDE /a5vkZaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaBuViQAKCRBM4MiGSL8RyiL2D/ 9I9GKF8CSLXr3xgeJzVrZdEB8ZO5UYXKq8YojbXP7hYJpC4pOnpXEmGmt5wsTMxQzfy3IUeZhUehbv VDo4T6ChO9PzSt1ABwkvX7H6//QnbL2z8xq2YtViGaK36FR7uQfo0qhpCPZNI8l5p7EeR7uecDyX3j 22ENCcrncpPx1ag9eyV3C2EKl+mM3uI/2k0ST0Wtve11H/xALKiMjweiuO4wKyhvf6EQ4KQlx89vtB 1aTRKYnd8ywjvj7HqbOgxz3il0yIp8rWyWrgwEEYv/Cx8rl8GqhKplx6TdNDMFCNZC38rrsNstW/JN WNfAEntXNH56ijQ1kRVBZAXYF0JtpcYoeB1OZeih2w3Xjx/nBTYJMnju3JwnT1YxN/+AxZYr9dYKyA WOH2E7hCdoAOGDLTR5PqUcJAJ7qPJM4kFbIlUnLmb66jCTCrAPnxuEFq8QoXmAY8NeQ2e0Uqa+/N33 UiCKrhPBYliG3R+EeE9uNojYQqX+dBvJLKSeYRMzQ4j9vEywiMRzrQAWPUkzgU+Et4v71hUFCu0rkN KhzASaYcvVOt7jxUz5N0Mi4d5FyiIfAGjkZgopAl6B1bkDTDn4l/BPdp/reJiVIQE9md40suMngIrB nYC3K5h9aQ0oIpSztffOdVZ1hrwAixXmG9QkZsOjBFMzLJwTHkfHZJUfQBeg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

In preparation of figuring out the closest program that led to the
current point in the kernel, implement a function that scans through the
stack trace and finds out the closest BPF program when walking down the
stack trace.

Special care needs to be taken to skip over kernel and BPF subprog
frames. We basically scan until we find a BPF main prog frame. The
assumption is that if a program calls into us transitively, we'll
hit it along the way. If not, we end up returning NULL.

Contextually the function will be used in places where we know the
program may have called into us.

Due to reliance on arch_bpf_stack_walk(), this function only works on
x86 with CONFIG_UNWINDER_ORC, arm64, and s390. Remove the warning from
arch_bpf_stack_walk as well since we call it outside bpf_throw()
context.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c |  1 -
 include/linux/bpf.h         |  1 +
 kernel/bpf/core.c           | 26 ++++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 9e5fe2ba858f..17693ee6bb1a 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3791,7 +3791,6 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp
 	}
 	return;
 #endif
-	WARN(1, "verification of programs using bpf_throw should have failed\n");
 }
 
 void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f12a0bf536c0..b57d8a1a7758 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3645,5 +3645,6 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 }
 
 int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep, const char **linep);
+struct bpf_prog *bpf_prog_find_from_stack(void);
 
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index df1bae084abd..dcb665bff22f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3244,3 +3244,29 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
 		*linep += 1;
 	return BPF_LINE_INFO_LINE_NUM(linfo[idx].line_col);
 }
+
+struct walk_stack_ctx {
+	struct bpf_prog *prog;
+};
+
+static bool find_from_stack_cb(void *cookie, u64 ip, u64 sp, u64 bp)
+{
+	struct walk_stack_ctx *ctxp = cookie;
+	struct bpf_prog *prog;
+
+	if (!is_bpf_text_address(ip))
+		return true;
+	prog = bpf_prog_ksym_find(ip);
+	if (bpf_is_subprog(prog))
+		return true;
+	ctxp->prog = prog;
+	return false;
+}
+
+struct bpf_prog *bpf_prog_find_from_stack(void)
+{
+	struct walk_stack_ctx ctx = {};
+
+	arch_bpf_stack_walk(find_from_stack_cb, &ctx);
+	return ctx.prog;
+}
-- 
2.47.1


