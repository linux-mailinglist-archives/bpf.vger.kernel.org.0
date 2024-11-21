Return-Path: <bpf+bounces-45314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F759D4524
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 01:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D30D282CEC
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 00:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0E170801;
	Thu, 21 Nov 2024 00:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0gK7iI7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED6243ACB
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 00:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732150417; cv=none; b=G8zh/EglwV8B9OyGtKDKa1zyRVLERQ+trTJbiNY/WQJ9NaRSiDH1Zt3qOYrXJy7ZE2r5jNQQPG6qwQbio8p4m/zepmypQSObC08ow5lnu0Z8IgFyyPK30MPiNsUbZMO0rGObfV0zkH8qg890dpgHcgPZZJr1P2yAKPIcUeUdDzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732150417; c=relaxed/simple;
	bh=py+sXAh6Cy2Iyg5nd70WwzpXzbrELAhJxE4+xQCjBl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtagVyLKlxiF0scogHC8P2cOCzBAxf0Ww/7T98bmZS6y4C5zpIXUo96CZs/XpoBxaQpeaGezXW5UUXEkGp9rqiqiT0P2OkgNqUNi+ovSPFCo0M7s6FckLO9AKRzKsAYWVkDEexe9FZhyOh1DbZldz/ZMCe69pC9vadWLLtsXTo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0gK7iI7; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so2555315e9.1
        for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 16:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732150413; x=1732755213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrpkn4VDlr9O23IiU1lbT/j+TVGWZonCObJSn/4KlaE=;
        b=P0gK7iI77ocxf4feyXWeDSgGwdILVlCjv0cLQ/HI4wjVIzpiIR1hwuPM1MnWGwkLJ2
         kKqnIG1cht1gwZK+rwKRmM+YqKto2ZK735coSF4MBUlW9v/WRwq9PTUc2PwnJCl6NPKD
         r4KR9iitO6tURbYuNtGu5hH2+JMlNzX2fVeZuJn6+rDKVfLJFtkGnyF/CkbgvDIGiXlj
         dB+C+JqG1L7J9DIUaooTdBURJ2zxs8IHLwr1HpoMrpFhr+Jm98v4zAOZV4EtlR9nKSk4
         ariSByk5fYgnWPzXpTMIRzUesNqlIdVr0jcCIm/aTKis3elmzGsi3Mke6JSgky2hNxny
         Twmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732150413; x=1732755213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qrpkn4VDlr9O23IiU1lbT/j+TVGWZonCObJSn/4KlaE=;
        b=U4AV5/2GRTG3Y4YgqxoUHlEjvR/Qq6HsUfbH+LdsM4RSfq/mNtgLzblT7FXEa/q6+B
         X2XDrn5+l3iaudaV5AiiNp1hh7tbNSc3rDCq3h1YbHuLWi0t7XDUin97AhAjFj/MUx32
         yo2/sydQ49dB4IsCkpyWl/aYO33EaRFwaiWYrBMgKYg+L1pl3GHdradWWWz/jcYRsGui
         5rTPs8wOLGnY5+xsoPDpVMEODjZkRBNi6Ncnl2h8z2DWcqqFK5r3QkFoIQKy6/tHhll0
         WufU53YaPgRaUqDqi5cAKjmjv+ZQDuG3SKWVxhzgo142iVUNbmIoUxSqUY/s44dy8afx
         GDgw==
X-Gm-Message-State: AOJu0YyXq11DgYEU2oKkxhaSLuY1AN27iw9Uu+N0BIOAPc82uzgT4mlJ
	JpGELCoEtNgFupRcOZlBbl6PG3dKDtVL+a1GBxbB+J1sMwmHxuBkOWMJDjQKsIw=
X-Google-Smtp-Source: AGHT+IEssxDKMhA+bVA3GZ1WiNCQGozbFTCnfdzJtgU5P5YS6em6R+iJvKvjwgllSgQihi4kA0fRXw==
X-Received: by 2002:a05:600c:3b83:b0:42c:a89e:b0e6 with SMTP id 5b1f17b1804b1-433489b3146mr40948785e9.11.1732150413578;
        Wed, 20 Nov 2024 16:53:33 -0800 (PST)
Received: from localhost (fwdproxy-cln-016.fbsv.net. [2a03:2880:31ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825493ea2bsm3458138f8f.87.2024.11.20.16.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 16:53:33 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v1 2/7] bpf: Be consistent between {acquire,find,release}_lock_state
Date: Wed, 20 Nov 2024 16:53:24 -0800
Message-ID: <20241121005329.408873-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241121005329.408873-1-memxor@gmail.com>
References: <20241121005329.408873-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509; h=from:subject; bh=py+sXAh6Cy2Iyg5nd70WwzpXzbrELAhJxE4+xQCjBl0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnPoQ2SeQnU05BU1hNVZUVo5P0qdzIs7QWmr6x5F8Z tScTlluJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZz6ENgAKCRBM4MiGSL8RylOEEA CvvAXV4a2P2N3nL+aWyR9xktL/sVsqL65vtyuwVrip7dKmEIw5tIa4Ad6Mw+17zlmq4cd7S+RubS/A fgZ3g3MPcgN984Q5tDpex2ryYw+j6hwI0am5N5aQHlvElN2pLwoONDDNx7MhYWiuFxQCgQBsCu44UZ k3+adi0tor0RFy7YZBpKluvGTXsgeZJgA8W6riN9jRQl9mY5Zv2pPusTWPW4NMtzePDDbD/2MEQAQq F90qQ5rJRket2W9sZMj0X6HLWF8LMBHtwgA38apTSXroOL9aheLRhcpS7VJcIYSy6/GddRiOFCbVOF LYHAOT3RYK539UBxu7ji5tpCJ0wYBjevNRxKKxA+IlhygY1zffC0GlVB8tF6L7j8pAfQ/NiuOgrgq2 +V0OkkldSJ1g8eREtXLsqQQbs4JxxBaZCvmZgmxeDGRkdh2593iGnGozKUBVruF0rcmY3OU3bVqw1k oChx/jOpqglJecsTY3eXqcMeMGUqlAHppqz26bbLNqQ0aR5xhG7g9q1llor7C+GPpFeQO0eZk/MHk0 QSRZ/aHDzWCAlFf103rVHJiRbtYi+IgWwmcCu2QXOrHUTAtN0Ho4vswXgSjf/KyYfKs8ZSXUpXUtay MJxepU6nmu8A1CPlHJE32t+lipJQGK3TqqtXtjcuUngD8WMGZR7dthIp4bOQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Both acquire_lock_state and release_lock_state take the bpf_func_state
as a parameter, while find_lock_state does not. Future patches will end
up requiring operating on non-cur_func(env) bpf_func_state (for
resilient locks), hence just make the prototype consistent and take
bpf_func_state directly.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c106720d0c62..0ff436c06c13 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1436,10 +1436,9 @@ static int release_lock_state(struct bpf_func_state *state, int type, int id, vo
 	return -EINVAL;
 }
 
-static struct bpf_resource_state *find_lock_state(struct bpf_verifier_env *env, enum res_state_type type,
+static struct bpf_resource_state *find_lock_state(struct bpf_func_state *state, enum res_state_type type,
 						   int id, void *ptr)
 {
-	struct bpf_func_state *state = cur_func(env);
 	int i;
 
 	for (i = 0; i < state->acquired_res; i++) {
@@ -11873,7 +11872,7 @@ static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_
 
 	if (!cur_func(env)->active_locks)
 		return -EINVAL;
-	s = find_lock_state(env, RES_TYPE_LOCK, id, ptr);
+	s = find_lock_state(cur_func(env), RES_TYPE_LOCK, id, ptr);
 	if (!s) {
 		verbose(env, "held lock and object are not in the same allocation\n");
 		return -EINVAL;
-- 
2.43.5


