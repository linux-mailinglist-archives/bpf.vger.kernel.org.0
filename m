Return-Path: <bpf+bounces-62040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D98BEAF091D
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 05:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F181C06D69
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 03:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542511D7E41;
	Wed,  2 Jul 2025 03:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2LvXIb5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309FC1C07C3
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 03:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751426272; cv=none; b=bqMZjf3jKmemGnVjpZVD2nSDyB71QPcMToWoSDwp7KBr0DmCjc42T1gAJYva3w+5pBw5th5YDn0Jh9Kd8Fkq6LZngITSMapLmPbtdN+ewpXO5bVM7Ri8+n6O+t9/q1mvXNCUl7XWCqzxwB02WvMat4ECEML9XXzqtJC5hUVQZis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751426272; c=relaxed/simple;
	bh=Cc+9AStwZUHp7zLEiOw5IOxXPdR5R6fgLUJj8NabZBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRemDGrc+db79kt2EBy4DQ5eJQ1xxSod6DuRF4fADfVMgikrtC+7SqjLxcWI7qhy1fx4bh2M5DLvT/XpIxrkTF2h0TIhIrDm3EauE9VppH0UMi+N7cfS8mNQ29YyO7PMOVOftFhYzOGWsKVjFJD1ik1L8dz2TECq7KyadHCNI3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2LvXIb5; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-6070293103cso6898068a12.0
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 20:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751426269; x=1752031069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDhbGhn+8m8YffjcW4vwDTzn5bTd6x2IOD+qfNoaBwA=;
        b=f2LvXIb5yZSEAZcJBtxWyR0fBzB+1bCf1stSG7mCCDJbBiHdtEJrLiRW0Q5Ba7vD/8
         +z2HZiWRVYk8g2bt7cIWtg9TV5sWyr3xoFT27f6rATRWD8xbgvcTyU0uFrsodSsi2pnK
         Oci49UwPG/nkdOtUpaH2Ha4xE906eVEL+PokLNT463qGv3LSN85sxVXgcEOEBHONZLlr
         JL77bDlsvdLg9fryZZjMYHI0nKyVWxcOHhOf86wm6YZsXg93sgOLjQmQCNT9vqDMShyx
         nNaAqDYWnQSe6llTBrtvVYpt6lvg3G0BrwmBzM23gYBQ1lOit8I0xS2LrbZiHRTrdEfr
         ztCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751426269; x=1752031069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDhbGhn+8m8YffjcW4vwDTzn5bTd6x2IOD+qfNoaBwA=;
        b=FoFWrXsQgE4/zMEcSU0EyaInok3A2/gSpfUGStKBSjid/t0jqbzoiOKMtayFTFhit4
         7bnNVp2Nd36sBpNxmdIKGoh7Iw5XPHLHQ93N1J8kLqeamsGmAjFrYlJTbNRlrl3QDPUk
         b51ZoFeBiki9lIqAujxj5HIvtwkDvDLiw3x7JHmdOQ7miRXeQ7T91EVegvLCd/YYNlg+
         tr9cfvuamus8uMDdBNGK2yMJ4HKugEek7aABNYwNub+f2C17Qj0VpUsnZ0zepYCT9lJy
         GgjsPuNLKD3ja4FG2JOZ/8NGErlTu6/eAo5Kiwjmu0BoMe12QR6SnnpyKuLyIXUIcNrF
         o4tg==
X-Gm-Message-State: AOJu0Yw5cJWBEKPIbGfqFdjhCWq6eF8vus+0kLQVvp3wCg+Gz/xJ971t
	sSIL4TIlSqwn3c8SRHeISqSke9HH7zFaDWVm3pHueRK858zN8M7dkwPAborkRHlhhbY=
X-Gm-Gg: ASbGncvsvgJM9B2ZabHQMOhxA0cFFQIVj3tpmDIsKaCpKPsIgt2jlHH26XrqCngVWP2
	wf7CpkdwFIw+sGnCaD/HN7v3DeqBNiOBR+rp6m9BgcPnEMKXqtuKoXRJWKScSZsPKws7b816Xlh
	632yqPFQS0xEPoro1pzdSqXmbzuHSYIEqr1Ek3ooq5BCge4OtmvWKKk3hNMO/2To+BUNPc4EdKw
	c07O/V2G1B7vaC7gGXoLu6DmTDV3f6VN/EoE4nQpnJSPmXHhMqZZbqNw6tt0rPrPJdEVH+Mobq6
	4k9q35Du3VBmOpyXaGwrS0XECocWHKcrGXC+pLFTFoDqcVFpT0s6MTukD/1sGl4=
X-Google-Smtp-Source: AGHT+IHLaRVqDLFI1hwHL39tduKCh1RRrM4yd1xHSn4U1Uhh5Sp6U5Rimjfgzi2h4shZdY1Ad9ZQXg==
X-Received: by 2002:a05:6402:35d3:b0:601:f3f1:f10e with SMTP id 4fb4d7f45d1cf-60e52cb3edamr880089a12.5.1751426268967;
        Tue, 01 Jul 2025 20:17:48 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c8320b592sm8514975a12.75.2025.07.01.20.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 20:17:48 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 04/12] bpf: Ensure RCU lock is held around bpf_prog_ksym_find
Date: Tue,  1 Jul 2025 20:17:29 -0700
Message-ID: <20250702031737.407548-5-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702031737.407548-1-memxor@gmail.com>
References: <20250702031737.407548-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1814; h=from:subject; bh=Cc+9AStwZUHp7zLEiOw5IOxXPdR5R6fgLUJj8NabZBQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoZKFQJolkkmYHmOF89hf8fpOM6juRGDboevMpXKYg b5diXRWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGShUAAKCRBM4MiGSL8RyhZLD/ 9dYTMQFyxPh/UBMkE0F7EeKxdhgbQQrD4cfmrTCRqY1lZ/kMofGOz9DqRSu2WvzUACTUq+bpOxQOyT YhRFnltUeZVhg3jG9fhpailNVUMq632skBkuVVKM2UEqgs85Hi5e+nABUTUcPKDCmlhj6v4kOr5mAL Kfoz78ywPzOw2s/OjqX7a694WLKbcxQtVP50PXiCRgjBFk15R6eSJq386BMNCbcKc7H+IMnNTYik5F gyClkHB1qDoWPDsk+fLDqo4UYvMJ79GBYJzshALqOjcnVYaIday676+eI0bYqGH3lk3f/A8mj+i/8k ZNKWRUT8wn2JJlCDn1BlpDkKTWyz1ThSDW+9gVatcrP76KhrrSsQOk5e6xgY4ye6t4coJ8d1p47jVN rUFDgBu1M1vUwmXcxvq7AwqW5Q1Cm6PJ3uhbka8RyFQZWMFnRVo5moEajqTNtOorHMTJ5WmFZTxh7L 8iaBbddjjHx8nuU4OMJIej58mzN7lRN1XqFTKBvAqlF1bdaCiA0h28JYpl9r4c2DLDiXfXO4yY4JgN xB8Ia6hKHZven/5tvcgjbsnnBEy2HGTX4Xu90yzbe4Ib+U9Ajsq24G/IwOttaoi0MucdifevX+ncQ+ NYtJ9EX4599VACz9OI4Kh3WVJ7mCo54ww88LMR6KAntsv/LdujBkWO5m/qOg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add a warning to ensure RCU lock is held around tree lookup, and then
fix one of the invocations in bpf_stack_walker. The program has an
active stack frame and won't disappear. Use the opportunity to remove
unneeded invocation of is_bpf_text_address.

Fixes: f18b03fabaa9 ("bpf: Implement BPF exceptions")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/core.c    |  5 ++++-
 kernel/bpf/helpers.c | 11 +++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

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
index 61fdd343d6f5..659b5d133f3e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2935,9 +2935,16 @@ static bool bpf_stack_walker(void *cookie, u64 ip, u64 sp, u64 bp)
 	struct bpf_throw_ctx *ctx = cookie;
 	struct bpf_prog *prog;
 
-	if (!is_bpf_text_address(ip))
-		return !ctx->cnt;
+	/*
+	 * The RCU read lock is held to safely traverse the latch tree, but we
+	 * don't need its protection when accessing the prog, since it has an
+	 * active stack frame on the current stack trace, and won't disappear.
+	 */
+	rcu_read_lock();
 	prog = bpf_prog_ksym_find(ip);
+	rcu_read_unlock();
+	if (!prog)
+		return !ctx->cnt;
 	ctx->cnt++;
 	if (bpf_is_subprog(prog))
 		return true;
-- 
2.47.1


