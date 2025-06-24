Return-Path: <bpf+bounces-61345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7E1AE5A69
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 05:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9147316CB64
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 03:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A681E32B9;
	Tue, 24 Jun 2025 03:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYxJWuQh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44381209F43
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 03:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750734788; cv=none; b=R0ebxoTt2zJl5oHxPBb5R1LcFTs5HUwUCCG8PSXeV6+sNBiAxItzt06k92PozTj9mM6x6SC32OETgzAe4PBDXQvUbHmt5MjVOLs8rKU+zq6SZrALaJzK6yPYdtkl5ZDP/c4doFRx2j6ki4XPxu2sNPUQVU2zOsZcGERTS5OQ/kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750734788; c=relaxed/simple;
	bh=Gp9N5evBaVBCgG5QHktE/qX6HSsv2j9p68dUzNTksxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkBP+oQdNoB3xJEstx4yc9D2iZkUj9VXf60xUPVdQj5wnpiDT0ej6DZXLcuyUBKaNGqzYPp/XLFXM3HBhL3k3gLWaworXwVpMv/lr3YyuoZvGh7vnn7clgSSsGAs7NCdYD0Ypyqlw7nuhGxPq8PfA5I9Ci932H5i5zbaDgDtu60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYxJWuQh; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ad8a8da2376so788300066b.3
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 20:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750734784; x=1751339584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyDcTldV1Lj42TSvBJeZUdRq14OXgJmOizx7usTZn50=;
        b=LYxJWuQhPUPPr+Nzc740CZUq0KPfeQ6gQSC9jK31ZyLgRhhQ7DBHpGhYpx2tHVP78n
         1MzsgZBoh10D8hkeYHkYXMlzcETs7LneRPBPnAYwsafyAX6NvqUPRluQ6kpMLGFOJ8pA
         oOCAkLSs4d3R/7c36yv1qrkakl1lCVK4bIId97o7bZ6D4Vlsf6CR7x8JGtHztPN73jns
         BpAGI4lXyv8o5CY4Oi6ZhIbNLHqR0EkNCoT32L35lfoM26PNjqjgE9LYYGjzZ92AwVyw
         /MvSQ3LLmUdXerFjA4YLjt4SFfhHHZ68ZAoocLdxEjF6HhW1NOmhIFW0nLn0EDNgqhUF
         LNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750734784; x=1751339584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DyDcTldV1Lj42TSvBJeZUdRq14OXgJmOizx7usTZn50=;
        b=KaKNrY8wsZBzEYQfH5ArHGyOhmLvodsUSsS73BFARVHvmz4yX9e0KwbXXTyI6dzhcO
         ns56md+huOXE51HiMlCI7nOJ61JuitAhZHbXt3Kr+/pROfxpJpQ2f0eQ4nIWq9dKzk4c
         a0BKH2JhRD5A1WCxeYfospk+o52u/BwodCB5kGZnZ753zH5g3kzCj1Ig6+vlkpUKWx7D
         0fqzfnFWWJ0+/e8FcN3AKoD9is9a0IZjIOxz5DjpRnediJds+1WFbS2O83lfxhUCsxT4
         W3BpP0aPpwDIc8htjaQXM2JV951Q8L2xpFNBk5rIL1xqI0zt1fo1M7yTXlNKkwjmku4y
         GXwQ==
X-Gm-Message-State: AOJu0YwCT6aIMsCh/JbHEVDIgqo+Xukl6WX3yZ7zZqqa79IjEH/IXrKc
	70f+l/Xxicn73IppTPNJF9FjE+ho2PMyn/jAeZn3XMrhrSIjC76I4b/DoeXQzIYxZeBZcw==
X-Gm-Gg: ASbGncujxO4G42vhc42qt4aMc5s37PAl074Ix7fxtRdC1I5/ueOADoSNeK6ED9w6Ah9
	gssJi8Yl1EvEwiUrWEty6MWSAJaC5jtndUHrXUIKbNkAOh2MPZ/9ebf5syqScBafYmT48jbh/XL
	TkQDlECb8mAo97/g9V7pqJhfw91XsNxknqqa1KKrf5f9Hp+8B5vU9ZD4X27O0q2oHquVGucNZl5
	ooQ3dIaA/K6RCW+w+KSflRZtYBx6g8UI8UT6Jh2xgldUY87MRinR5wuu8tTi4CFvVFU7n/eJ53K
	EanoJc/6aOrarShcF55uwRWMM7FupoqJs9qHS444D/EtGN4IGXM=
X-Google-Smtp-Source: AGHT+IGzF9GqSMk62k5e3Z+d3HQjOU/NSsJF1K0Bw6euPpAE6oPZW0+0zv5vOcpOH5CN1Xm0Q4Npjg==
X-Received: by 2002:a17:907:94c7:b0:ad5:6969:2086 with SMTP id a640c23a62f3a-ae057c1075fmr1404040366b.37.1750734784154;
        Mon, 23 Jun 2025 20:13:04 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae054209efbsm810017466b.178.2025.06.23.20.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 20:13:03 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 08/12] bpf: Report rqspinlock deadlocks/timeout to BPF stderr
Date: Mon, 23 Jun 2025 20:12:48 -0700
Message-ID: <20250624031252.2966759-9-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624031252.2966759-1-memxor@gmail.com>
References: <20250624031252.2966759-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2091; h=from:subject; bh=Gp9N5evBaVBCgG5QHktE/qX6HSsv2j9p68dUzNTksxM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoWhWeH5LnjFBUl/YTCa4zYeyhv8RqisWwVI8lyB0B 399gT+KJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaFoVngAKCRBM4MiGSL8RygNEEA C4XPYN6aHCWsStMICUkhdp6EFh/spuP3jd/e/RNTvvn7lK4ToNfOwHvxqUwxfnQdMz15gwSLSLT5sI /AE++aTsyc1RtnKeCUxiJlsZLqBIzvUCBU8M704lpeWwZRZ0y1xeM0hlNsS3G0qOWyKVNuOmmgU/da iBj0oNa01VQy7xkO9eCdnmHTkOO7M2rBbXURHr62+5hoTBHSZbsASRMQ1+OZnPlBWSmN4vjLlrYLkY H2W18+hhg71EuLOVJ7Iu534RxmaVFEGgnAiNlNFWiP5sQ+5nX+/l3377miNm8lCGbHGakYA/TIw+G5 YTpNcFRYZJ6kNFopw5PD8NfJqVFfw50bMgrdCOsT2Jo69kj8pkYHwXOXdFLAPKVQWPJd4iNDOzzY6X mSqr/m0VOlv+Z857jCcRBHcgVvtxAjyuBBT3wAWzsGNz305eoMFBrV+D9BdA1PAPA8jlUFncWLaNgJ 2+EYsg9Df41LKlwxgxSzvWH0AbkZns6mTHQD6piqQ8O0+mK+Ewk4guxUl0bCtAc22PsAWTmZfd36F2 050xGl5pQJi24By7Ap0ughah0kX6mT1P1PmbaMkTNOzN6fV2Qn4v7x1NpGRRTdFWXxSkbMKqP6PYMO hVWoYJnNZPPljDjQA2RsqQ5aLZxEUieU5oTJwAYv45D4JH58d9Plne9LRJPg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Begin reporting rqspinlock deadlocks and timeout to BPF program's
stderr.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/rqspinlock.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 338305c8852c..5ab354d55d82 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -666,6 +666,27 @@ EXPORT_SYMBOL_GPL(resilient_queued_spin_lock_slowpath);
 
 __bpf_kfunc_start_defs();
 
+static void bpf_prog_report_rqspinlock_violation(const char *str, void *lock, bool irqsave)
+{
+	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
+	struct bpf_stream_stage ss;
+	struct bpf_prog *prog;
+
+	prog = bpf_prog_find_from_stack();
+	if (!prog)
+		return;
+	bpf_stream_stage(ss, prog, BPF_STDERR, ({
+		bpf_stream_printk(ss, "ERROR: %s for bpf_res_spin_lock%s\n", str, irqsave ? "_irqsave" : "");
+		bpf_stream_printk(ss, "Attempted lock   = 0x%px\n", lock);
+		bpf_stream_printk(ss, "Total held locks = %d\n", rqh->cnt);
+		for (int i = 0; i < min(RES_NR_HELD, rqh->cnt); i++)
+			bpf_stream_printk(ss, "Held lock[%2d] = 0x%px\n", i, rqh->locks[i]);
+		bpf_stream_dump_stack(ss);
+	}));
+}
+
+#define REPORT_STR(ret) ({ (ret) == -ETIMEDOUT ? "Timeout detected" : "AA or ABBA deadlock detected"; })
+
 __bpf_kfunc int bpf_res_spin_lock(struct bpf_res_spin_lock *lock)
 {
 	int ret;
@@ -676,6 +697,7 @@ __bpf_kfunc int bpf_res_spin_lock(struct bpf_res_spin_lock *lock)
 	preempt_disable();
 	ret = res_spin_lock((rqspinlock_t *)lock);
 	if (unlikely(ret)) {
+		bpf_prog_report_rqspinlock_violation(REPORT_STR(ret), lock, false);
 		preempt_enable();
 		return ret;
 	}
@@ -698,6 +720,7 @@ __bpf_kfunc int bpf_res_spin_lock_irqsave(struct bpf_res_spin_lock *lock, unsign
 	local_irq_save(flags);
 	ret = res_spin_lock((rqspinlock_t *)lock);
 	if (unlikely(ret)) {
+		bpf_prog_report_rqspinlock_violation(REPORT_STR(ret), lock, true);
 		local_irq_restore(flags);
 		preempt_enable();
 		return ret;
-- 
2.47.1


