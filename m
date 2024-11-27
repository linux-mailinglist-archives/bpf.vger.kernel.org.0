Return-Path: <bpf+bounces-45764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16339DAEFC
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 22:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A12B2136C
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 21:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45956203704;
	Wed, 27 Nov 2024 21:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b499cWgW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143672036EE
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 21:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732743345; cv=none; b=YI+0bTdu1xJjM3XPDNQqFEnIq3MKHF1gd8fsRkWC+WIH6spKyxBHRNxaN9AdiuS9k+uR85wKx/Gay5fKJgE2CwVnFa0ZFGqDEWw92MFpEDrKwTLwAfBi9eDfEIz1Jk/kUPlWTGhci4rdwLSjbrDjtg2jXOYEaN7mrKJOURsGiBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732743345; c=relaxed/simple;
	bh=mCbV2hzfoSvQXfT9CUwMciZZAlSpMRDDqFj2bBCWrIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftgKLf0wgtksaXJcqYjfCRQIAgfQwLSk0BKVy5RFiiHENJDWqNUt/v4zl70szy/msO6J8+NApDfIjvtazE08aoHrhPYHUKHTPZ0P8mD9EFIcRXCra826o5dqkbTvnV6yCvCtDN0dXWcAJ0F4UMUUCwHTLA7fVVfnzlniOfU/bE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b499cWgW; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so115733f8f.2
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 13:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732743342; x=1733348142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdwiHmAk6OhdkiUA9Ev7EZPLqHFZB5MK41Iiedr0ApI=;
        b=b499cWgWl9INsCMluUxESPnrDqX+Om9neug5hKENR5zW4n485cBlqAvFqISGA6DfDf
         DjrNIRw7X/ac8DkpM7EuO36RAGLGuWrfmb3Gdd0tQVzXI0E+tTq9TT20z1gjekGODWA2
         fBMyLnClnjGtz4t94CVCIGJBdd6OY/wuSQrObGDNlfxdB20OSpJgvJ/aMiz0Z4JT5FBe
         aABW42t6BzqyXMMzGRu2+OidTmC0U16MDvf0mOo1GXfm7tGol2/lWNrzmlfcTWiFqGhe
         8tSSzxlNy6WVpFLjnCwzV95irUc99PMugi92RaJzKDd+PSd8NkEmjaH3aqcqU8WSie2L
         xl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732743342; x=1733348142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdwiHmAk6OhdkiUA9Ev7EZPLqHFZB5MK41Iiedr0ApI=;
        b=E9gm6L3ZdSd/Ai9P6B25QfrhLoU/2SExjS4L4ReMDl6E+YKJJRuoxHXZOpcgPHL/Dn
         Oc0jXVcIh16pcetieixW/YXc2ruitBxq7D1D9YTRU1YioRasTKWbmZ98qNmDjCV5bAu6
         svu41jwb9GcxGkP6hQiuQTuNVdZswZh9SyKcojk9WxnyghfW6U131yaXEPjU+wK0yqDj
         sxFnwvBkJKPs88tcdeTNuIOmc5UuTu5hCJuZ9GcNsqS6KDtLgLxajMlYTUF+QEA3Qn/B
         nUyTh+ou3kv8NRKXccRvr/NoY18UqmfJa1+nEn7QkodO0Dy9qwXK6T7jK1ce3jd4GgQm
         0IQg==
X-Gm-Message-State: AOJu0YzfK4If989QzptuRvLvel00zmU+aL3cWe13DmgQkeRRrOa6kgGp
	T5IA4lUUn0Iy2yY/kqrBYhWD2gAAyx+j3NWBSgDjaaK8m6lfnYP/7LCui4QM/Xs=
X-Gm-Gg: ASbGncvinc5DPp1TZUJijcC0lEUGq/tiWiEvG1OLy7oZfRo00yu7HeBNThSOnPK2uzq
	mftKpyFGFduB7VqjBlZHEYaEfMco2Lz3dW17ciizeJw4pQm1c9YkPQruXYE9puwCPsfoCS7Yg67
	ZaEVFAKlhgW0SlBwo6IbzEwkTyvqvksSmv0GQ3Y3RY8kkoy5yv+DwgvZRMZwh/pciLLY5mGQ0Lt
	8gd6MbeH2H25lC818DqZ8cHpyAgOhRuLisReHCwyjMPvsV+AM+J8+BmBFX9hqW1ad1luQYL1nfD
	fg==
X-Google-Smtp-Source: AGHT+IFuSd3atbVzR81SVRi4HlNIEILAp8nauqj8+lll1NZ/hmpIcIdrRTCl1DvM63d7KVi5lKghzQ==
X-Received: by 2002:a05:6000:1865:b0:382:4eef:270 with SMTP id ffacd0b85a97d-385c6eb7283mr4089322f8f.16.1732743341534;
        Wed, 27 Nov 2024 13:35:41 -0800 (PST)
Received: from localhost (fwdproxy-cln-016.fbsv.net. [2a03:2880:31ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb2609csm17523638f8f.44.2024.11.27.13.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 13:35:40 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 3/7] bpf: Refactor mark_{dynptr,iter}_read
Date: Wed, 27 Nov 2024 13:35:31 -0800
Message-ID: <20241127213535.3657472-4-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127213535.3657472-1-memxor@gmail.com>
References: <20241127213535.3657472-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2790; h=from:subject; bh=mCbV2hzfoSvQXfT9CUwMciZZAlSpMRDDqFj2bBCWrIk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR46t5JREANWkAQkTq9sY5tFPCMEqN0mVIp6AlRAX NqsjPXSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0eOrQAKCRBM4MiGSL8RyjAdD/ 9mHy1nctt+53EqAGTEtIb2QRx+S/9sq3Pb50NiapYhHtS0eSb5kwYt0Ni6GetEhhHJVwa/PDGLpCpi FL9f5yWpU5pVifkqfWe1ycE/vdLC2q4BzrkbJF5Jcv2TWW0oAQ/WkuqQS62ooW3wyBZ/I2Uo53c8Ai UkV9qs6mpfdN+Y4/ANUpvJLFu8cmScHUzv26lvHAVEQWxnKo+fKYAB4cwAqqxcsbDPG3nPUGdTnDow wCFA9WpN56TP05z80FUwh5qoFXGEgVPoWkHhDbTETJujqJzGtm3K9mv4F79psXQmochO7r4cMvZ9Hf aepX075iGjMN0SF1wyJU51FoejtFgk10fDvNXS+oJc2qYp2gCLFNABXfxBNdzk8hA1AEWD8tq7My0N wu9qBpa/OdFsIHBHDVmrniZYkFuVHt8GK1JvMk57ijivD+YIfuBw4beBBUxAMUMNKze4yQa7AJC9Q5 XA735eMHs4Gcxk+f+nAPpJ1M/JMUcxwrelViRvZQDVGJRyXacLAHTdVRrAR8VXguz/ay5yoQ+wt1Kk 3rcqs6yVzMDE3tUkUUzPRr1hl2SQO6/UJ/T7lUIZJn4CaXJduU+RWrW5m+3rvutfa1Op86CboFtusa ONfn8SkVTDZEh63axSJ3b5RNK2R2NXLzZdRcTL9Cv/Z04oIv1c/TcwSey6wA==
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


