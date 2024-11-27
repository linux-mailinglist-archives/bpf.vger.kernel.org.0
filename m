Return-Path: <bpf+bounces-45720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2789DAAD8
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 16:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C143281D64
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 15:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029F9200117;
	Wed, 27 Nov 2024 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8ql2LOz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCD91FF5F8
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732721595; cv=none; b=Uob5yUnRPCh0bKTC/NqQgWNQA+R7LUsrxYKRU8EQaJ2Q1qXuQo8VVfDtBv0AGoNfPAObrni9QiqS8uWVpIWZ+OYQuK5ikigqvU5gVAtZf0uou3eAn5UYZg+JTNI2U1ujCs5p0T8WAXK5ip1IuFhC4jn7k6x1G7ayc4UudlLFHnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732721595; c=relaxed/simple;
	bh=mCbV2hzfoSvQXfT9CUwMciZZAlSpMRDDqFj2bBCWrIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgVPjImqlSu4zagIpYYV3eHIh5tid7rHhxY2HsUpOMwZEZpggXgCXHU1aWykqgaUGf97SmjRCvwR7SDdMIRKVICpll1p+61H5G2UkJT571KVyfX6AzjRwuTj7ffVMxtTEyxdxuyAyzOm8rCeoQAzUmag3nsadXp1T1cjFzph6gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8ql2LOz; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43494a20379so35510905e9.0
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 07:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732721592; x=1733326392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdwiHmAk6OhdkiUA9Ev7EZPLqHFZB5MK41Iiedr0ApI=;
        b=K8ql2LOzlkLNLHSwdHVuk8tb8/UCcQOkcOHF4fNvEtd9g9+kScZOJdjIBkzuCYxatQ
         XY1hyggLpfiRdIycNq8lLnbIXImrerMqjKSYi4/Rf+PMfNDwK6c4S7p6a0TPhtXA1svt
         V8zUyLXU3hHy/mMLvwWLWKZg1nc+cPl3fFfzIs2Xtdc1oNvVXd1QulQExYXOtQ6yJHH0
         qUie1lWmMFUhegFc/uwMj5CkyKzFn5s1d9olABacRaIU3AFTRuzxNxepgDrz1QYOiy7T
         CeeQW4rjKlQy9QLE01GFjUEFCFEuGgHYlAvu93/M+9Y9McjWW1wbMJXNAiIf7t5W1maG
         QZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732721592; x=1733326392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdwiHmAk6OhdkiUA9Ev7EZPLqHFZB5MK41Iiedr0ApI=;
        b=sadzH9X9pKUzAJeOIuQ1DKlOX7V9J1Zrme4/3u+trzlakv8bMb2rwiaeU8CpRgATlI
         amPaXo2o3DjHrVbUvLUy5D2JnX3W4w8Q2HWkhsdeZlHVC9lDbsUMvsm7bOgMMDghYFoo
         Hoi+BBaoiXTNsFYhJqT5qoeSX62IDvbRcXClyK/P8gs0weECu+/azJab5pdw+8SncFIv
         0dmMtFUwFrABkQgthtKlAyl9CIhvCZRP5V4G8zwheilHrwYGqSMHTCSdlOlYZj+Kxch2
         bn5CWyS/jQtJRSqpJ/BitatgGPChFLAZOvMo92H2ukLrFOoxra5sxwZcPTw0UEFVw1l4
         IO/Q==
X-Gm-Message-State: AOJu0YxMweKDJz7/Jdn6ed5Ctl/+oe6GYm7nGGNFeD0TEGQzWNunoPPk
	4W11pRAZKoqYcUxVZ6TGBrrqDM4nrY0xLVEJst9b7exFcIKbmxi/7Ldw8bJrtQc=
X-Gm-Gg: ASbGncvDSMs205GCwNtJ7XGO02GML8aqKuwrt5xkJvzidirJzlRXtaV0lK9RUVoVphj
	kVfSf2CBCNR7K3B3bDBqaL0Bh23yZTGvdyUsSrED1HWD54LNlaSdAytUhTovyx+LgwJ8AxZdlQ6
	1nI/QKmuU63Bibko+YdM+g/iV9PUjM5fERDVfU16AdNnuTUQdgIjbz07XhWEcVktVFZw8ZpY1/A
	+d2PWw0BO4OAgUE3+0T8nP/K2s9ovLpOMH4L0AGbHtJtF5Xr0HggnTef30QxS+OUGjdAFKGNzvz
X-Google-Smtp-Source: AGHT+IE+9N6yIUUtiHm1PkMTft0YrIxPyEAvsiNEI6LFbrlutl7QCUgmydECIULzqwKnatbT/O1LbQ==
X-Received: by 2002:a05:600c:3585:b0:42f:7e87:3438 with SMTP id 5b1f17b1804b1-434a9d4ff94mr35091065e9.0.1732721591556;
        Wed, 27 Nov 2024 07:33:11 -0800 (PST)
Received: from localhost (fwdproxy-cln-014.fbsv.net. [2a03:2880:31ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e2202sm24182575e9.35.2024.11.27.07.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 07:33:11 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 3/7] bpf: Refactor mark_{dynptr,iter}_read
Date: Wed, 27 Nov 2024 07:33:02 -0800
Message-ID: <20241127153306.1484562-4-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127153306.1484562-1-memxor@gmail.com>
References: <20241127153306.1484562-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2790; h=from:subject; bh=mCbV2hzfoSvQXfT9CUwMciZZAlSpMRDDqFj2bBCWrIk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnRztd5JREANWkAQkTq9sY5tFPCMEqN0mVIp6AlRAX NqsjPXSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0c7XQAKCRBM4MiGSL8RylAND/ 4sBHLqU8sdnL8k4jY55Hrba2MIHA02RPrMEWY8Dabay/1A5a+g/ek2WIlKL4P7tqlxhFjxZjF92XDS 76J4KOcEBcqJ7aA9IAjzUkjyMDZXGK9nxPbwuG9gT6qt8QDKk/NG0EXcIoO5OvRVHeDzXr23D7s0Lm HcStXInqfS3UXIUoJ4YFwcugmJ17qBfVdZE6FtBgw+i1Syi8QobPXOIzo9c6TyTn/meqplV9w6yp7a wrt5r5CVIY7aLVs8QhVKUY7Zk9ATkKJUiG46HOhPu4gez7grFvnh7JgwsyudP7HKG/LqFSMcwUFME2 2CgXBXBD3e14SHlMlUnEScDsR8hPhjqXCwU4waq/PZu8twW1oq4a2vgqAlyIrq+1HYgEt3yY5dNU4D jXPCDIwNIGPhGqhn/NjfELhBKRfj4BmkrMb1brShdy8XpcWvSy+Kt7Rb7b0LS+pBIwJwhcbcHlEVHJ qjhUxX53/RYVlKhuRM4/GIw2y+qA7qM/YpAGs02PfAHpkwP2dJDg5cYW0jtrNmVrsW6fy0mlt77Pb4 ndzyoKhjvL6Vn/dyNUHbPyWf1qz0IWPF24CYHDUfeLWV8daHVRX4sUpuf1pFl4hn086zAWMSTANMRT wQHbfqXz0QZ8dxqH+gGV/mGH7wKHtT/zaeE05JInoh5kWpw41AGxT3ZksDbA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

There is possibility of sharing code between mark_dynptr_read and
mark_iter_read for updating liveness information of their stack slots.
Consolidate common logic into mark_stack_slot_obj_read function in
preparation for the next patch which needs the same logic for its own
stack slots.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 474cca3e8f66..be2365a9794a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3192,10 +3192,27 @@ static int mark_reg_read(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static int mark_dynptr_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+static int mark_stack_slot_obj_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+				    int spi, int nr_slots)
 {
 	struct bpf_func_state *state = func(env, reg);
-	int spi, ret;
+	int err, i;
+
+	for (i = 0; i < nr_slots; i++) {
+		struct bpf_reg_state *st = &state->stack[spi - i].spilled_ptr;
+
+		err = mark_reg_read(env, st, st->parent, REG_LIVE_READ64);
+		if (err)
+			return err;
+
+		mark_stack_slot_scratched(env, spi - i);
+	}
+	return 0;
+}
+
+static int mark_dynptr_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	int spi;
 
 	/* For CONST_PTR_TO_DYNPTR, it must have already been done by
 	 * check_reg_arg in check_helper_call and mark_btf_func_reg_size in
@@ -3210,31 +3227,13 @@ static int mark_dynptr_read(struct bpf_verifier_env *env, struct bpf_reg_state *
 	 * bounds and spi is the first dynptr slot. Simply mark stack slot as
 	 * read.
 	 */
-	ret = mark_reg_read(env, &state->stack[spi].spilled_ptr,
-			    state->stack[spi].spilled_ptr.parent, REG_LIVE_READ64);
-	if (ret)
-		return ret;
-	return mark_reg_read(env, &state->stack[spi - 1].spilled_ptr,
-			     state->stack[spi - 1].spilled_ptr.parent, REG_LIVE_READ64);
+	return mark_stack_slot_obj_read(env, reg, spi, BPF_DYNPTR_NR_SLOTS);
 }
 
 static int mark_iter_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 			  int spi, int nr_slots)
 {
-	struct bpf_func_state *state = func(env, reg);
-	int err, i;
-
-	for (i = 0; i < nr_slots; i++) {
-		struct bpf_reg_state *st = &state->stack[spi - i].spilled_ptr;
-
-		err = mark_reg_read(env, st, st->parent, REG_LIVE_READ64);
-		if (err)
-			return err;
-
-		mark_stack_slot_scratched(env, spi - i);
-	}
-
-	return 0;
+	return mark_stack_slot_obj_read(env, reg, spi, nr_slots);
 }
 
 /* This function is supposed to be used by the following 32-bit optimization
-- 
2.43.5


