Return-Path: <bpf+bounces-61340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E13C6AE5A62
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 05:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57DDC444207
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 03:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1CC1FDA94;
	Tue, 24 Jun 2025 03:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ii8zASXB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54701DF248
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 03:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750734782; cv=none; b=oHQyk305V7SUgmHL0TVNEN0K9BBF0Sk3E7h+XVeRO0FK0seyUE5p7a3ddJwo0v4TFEMk8q+5rW7Xj3pbgU8wlqmDzYD0scRlTRGh9qOdoqV4ZC6yIs8Eam8+ecPVX7hoZlmRPS+B/qQGdnL8msvo43jo4rHQ9g6Dz80OXtrul/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750734782; c=relaxed/simple;
	bh=bUd0XtTZi2Q1rDeeS93KIgF8ovcFjORZlwjB5QZbIuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdEhAK4gOwpDKOHmwouuu1JJqT8XU3KoQrDINzT/jYPtP1AtDYl6+UD5LeRogV4SfJXS76kZEBhh7poDhy1owmgy9PpYYQg9cXxDYeuKP9gXv6B6oQDw4XbBHrrwyONadTMuVwwO9K92K6CoJNTgd+/jJdpszRtnKYy4hUYBKvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ii8zASXB; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ade4679fba7so925161966b.2
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 20:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750734779; x=1751339579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63Leb81PN2dhXg3C9O4DvHnOUzN9Klf+iwjgcWj+dKY=;
        b=ii8zASXBUmNbnhyEqMc0Bxai18/H2OLp/71xWzODFxkYkZbo4A4MeBTCIeKYclOxO8
         8gkGh80fIt8+v5JOKgPUvrmAG1VqyvWbGa+/OIZK7K4k8OB7gKfJSQAa7Y5UNXtW2nO6
         175w41ewzO1wKB/oUkhmy7IcQ6t9DeMQYLRATwXkJcKnjTCZT+AEp9dg+0B63eC80ZvY
         w/MtfKYCwzFY9j1hN3B6a2XndSURbe6UiBW9f+3i4LualtRddRy1yLmYZJlKYWUGkY4L
         ATqlPdujm2wkhysrwaXbFWKgPsGAU0GbcJjBw2HnNYGTr/Hp18KZLfcN+jYlD5+My9I+
         nUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750734779; x=1751339579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63Leb81PN2dhXg3C9O4DvHnOUzN9Klf+iwjgcWj+dKY=;
        b=rTch+VxYBKhD7IGPlLtii6ouC0kj+LbHv+xgH7uT+GVvrKagKPbWxiSttcQu98LifK
         id8ffBF0OHqRcy0giHpmfGFye5idUB2zhO9bhSXE0QEZT9Zx288AA85X2YFybnMTh/VY
         QSnsm8vHt2jC3OlFSIyaERe4GpEFP19SL6J4fel20/F2bnL7CV2FWmHe5SH+AuUYxnZb
         KY9zx2ZcTp4HeKqqNHPdRF1DqfU3+MjKouPC+ymMEZHhbxb+0uiBAghYl1dGeIdkiXQo
         NdMN1rHR3wp2QnCMr+iMNH4izpRdDxmumAd5UVWZntYLPQSFwVIFO7Q3yYdN3rTOwtWZ
         RTOw==
X-Gm-Message-State: AOJu0Ywdz1P1fFvym7mYhSX36WD+bOLcT4rqM2xxCMavNZIcmFAaA4yN
	0vtVrNbwKm49sz845+FJIrtWOFYm8OHPuWdBg+WdmIx3AwKAsIhXgvS8NbGnbNQgLrFmWw==
X-Gm-Gg: ASbGnctSzuQ07217K7r0u253n+PviDSTsJmMIy+P4lCjmXJDXLOH5soa7+f+NEddWTh
	kviXz4dnYKwD6tSlMHAPDxWUVo+N2PoeAOuDEemqWBDV5AJRacx1057wX5ztqW2gkv0x/RzSnvd
	gnfOZ9DWXBUUcpkpzi+2rqz20Wx0B+z3FyrRg8Axgw1nQ5rUEKwfVk7COD0YZNgYlaM2o5YHT7+
	ouzhxY4RgxIoM3s5I9XSSZ3ZkrZbErgtJR7reYP2+O4TFwZnp5WD8o9vcmKmQLfdTfQlGbF7gql
	9td6hlE39SSiF1p7mp9ffdqGCN4bK9s9PLXcVhPGFG7PG2Ib2c8=
X-Google-Smtp-Source: AGHT+IGnRMaTJegQqMv1kmCoJXOFki7V3g5hVMQ4ARbtmjBXeC4ZM4Gil/FHlp65kenKa492LvTdeQ==
X-Received: by 2002:a17:907:3f90:b0:ad5:3a97:8438 with SMTP id a640c23a62f3a-ae057b4584cmr1478506466b.41.1750734778831;
        Mon, 23 Jun 2025 20:12:58 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b74b6sm799063966b.139.2025.06.23.20.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 20:12:58 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 04/12] bpf: Ensure RCU lock is held around bpf_prog_ksym_find
Date: Mon, 23 Jun 2025 20:12:44 -0700
Message-ID: <20250624031252.2966759-5-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624031252.2966759-1-memxor@gmail.com>
References: <20250624031252.2966759-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1390; h=from:subject; bh=bUd0XtTZi2Q1rDeeS93KIgF8ovcFjORZlwjB5QZbIuQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoWhWd4pvZNAKuDmZI5VnDyOVWNq2O0IWMCTGNNnLG lQM4MuCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaFoVnQAKCRBM4MiGSL8RyqYVD/ 4/kaM6PXfpJaJbMCyoeWWQ0hybWyjYfVHhEUFo3xSs2815ZWcI5kxCqJrFTKMm7yfHaZhnHlezHq10 ignOpEHCjLfeVuTfepshRkjUyFCOpMtA36HZYDHMtknVMlknpzud4vgnt2WZlHfybFC9kYIars2BgM WIvPNKOgXK/DiKCo8cjqqy6bpfw9AYTP6OvfsWJChChijBTIkFDQCuVjWTqAvPZ+cfFC7HygcY0KBg ngxKtv6JR7LpmURWkyqBFrt64oz7X1XEoq4YalIChhB6E42EeYgDWgZpo5Xe1ZsVhUQ3ebDLycJhO1 Pk7AWHBlsx8tiFcv3K1A4UyHu9vP7s/yex/DjZG6xGCPpd2gMGijtmVvD+ACdwMPfA7o8ERVUkdxbn 5PmAN2P0FzJfKuL+siBBRJnY2AsgD9p9cEspgDsEr96xECKeIMVr6hErd0BTUBeel4T5x5fCaUh/Sb g0FAy+8XZ7RkDyv2YOM0/VxMfVDtSjQo9uAR+x3HR5bRzFDpo+DJypfcspNFtmAxAkeQ/W3dWUNm0t 6qDVLcwHkcYCb6exMNy21mWHiIaG/4Ws6gCaOpcvKNxwnoAPEZtlSIJB7B75X2AWj9z6nM3XGiuCt7 isUTOcHKUwRTSDEx2zSzjl+VhewGi2fMdMLQBcB3c26qX+gp44jc40LET5tQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add a warning to ensure RCU lock is held around tree lookup, and then
fix one of the invocations in bpf_stack_walker. The program has an
active stack frame and won't disappear.

Fixes: f18b03fabaa9 ("bpf: Implement BPF exceptions")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/core.c    | 5 ++++-
 kernel/bpf/helpers.c | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 5c6e9fbb5508..b4203f68cf33 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -782,7 +782,10 @@ bool is_bpf_text_address(unsigned long addr)
 
 struct bpf_prog *bpf_prog_ksym_find(unsigned long addr)
 {
-	struct bpf_ksym *ksym = bpf_ksym_find(addr);
+	struct bpf_ksym *ksym;
+
+	WARN_ON_ONCE(!rcu_read_lock_held());
+	ksym = bpf_ksym_find(addr);
 
 	return ksym && ksym->prog ?
 	       container_of(ksym, struct bpf_prog_aux, ksym)->prog :
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8fef7b3cbd80..61b69eb08c4a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2936,7 +2936,9 @@ static bool bpf_stack_walker(void *cookie, u64 ip, u64 sp, u64 bp)
 
 	if (!is_bpf_text_address(ip))
 		return !ctx->cnt;
+	rcu_read_lock();
 	prog = bpf_prog_ksym_find(ip);
+	rcu_read_unlock();
 	ctx->cnt++;
 	if (bpf_is_subprog(prog))
 		return true;
-- 
2.47.1


