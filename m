Return-Path: <bpf+bounces-74248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03248C4F303
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 18:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EDDA4E3206
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 17:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E31377EB7;
	Tue, 11 Nov 2025 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeD7XhjB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC88377E93
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880830; cv=none; b=Rc2B2ABybn3dOtxx86TsbCZ88Lg8tKB0edX/jVUVams0JW68CdLkome7d6ceYtzWyLtCmV5lrUoLpJ8dgY/UtdBvX7cwsf8h28K6j2fMkKd2+D8B0UX9qUwpVaXIQGxRDr5aeGMeJMPCxgsCPBVvMHQr4yS5/hf7usvK4iwyc3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880830; c=relaxed/simple;
	bh=5vaaO9pR2CCjZkXCdgxuJjsg9kXydBL5563kYInFRGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q+ut/CVkT+NXl1Q4H37LmjxU0Cm8CFLQhwnCrSw7qJgkM3t918mANyh7SQCPBGylSe8Pz4wnpxd+ulp10Q8IVYM9dndbXJUnkCK5yxo8dgrFu8WLQnpM4SL2zgvImuAlc1V8GEKvvzgmTcQkoyDsVOjrMDdKOU7QkOISmuv4CoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeD7XhjB; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso3725076b3a.3
        for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 09:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762880826; x=1763485626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aL/jx9IucWn1B4wW95e6ho+xnNSbQhwk0eKmTQPWr38=;
        b=PeD7XhjB5FQUSPtUx5lyLfD9Sqvn3TqDbF9/OhDwQ3Aj+K9hcIIV3IaaRIWGwsTSW7
         ahbYLtGlAGalajuOPNOpEIFHiQRhuGmZuRr3WnP+Vwp0TXY2nSg4aqR1EHGaVlvOHs+0
         dSFa6gvPXxT1CtLhBgbwPCmYG0yrzhvGtYps1Mp6LKdWptZTfxzFnsj14AEOXXSDtU7r
         Q00CUlWlbIWxJL9rtxYjaulhZ4xgKWINth8+JHB2d0nGkWNCGkegTrihYc8FXvZ98Ngv
         fCmbRGlhVQh6S8seK5h0Ve6INkxgKhBLRf9RsqcR9Cls9GShpc6arXfmNAVQFbbIIHzR
         SHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762880826; x=1763485626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aL/jx9IucWn1B4wW95e6ho+xnNSbQhwk0eKmTQPWr38=;
        b=r2Yv8+7zo3QzzyBlpiWhIQn6KstBHH7vv/vkOb6lu8PqDXA+WaTLNITHideCoP3r2v
         3qMxSFcEF0nEZEF0Kd1jxzYqP4E+sLXbY40F6R91d7I7a/jiEtXv20wFexOkambAVA+a
         GkknqsF7hAoSDhaPQMQHeq9SVkslkVn93U2pTUnbDbRTVq4omEOPHJNBdtVK8VAUBlJN
         Z5EhaXOv8Z4tO1VS6q/LT2hi91FvJZom5W4vR1ir0dnYArJyAloVLPrrgPIrQCHJ7Thl
         FpXsLwQ5dJBUPbn707Dj0wB7OfthuKukiT5HjLuVDI9VxIWJm8UxP+a5FdgRQhVNjtBb
         SzsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjJaFRh4X2zbBLIUygGsK1YZ3lWEeUCilkWSlcyK9VlYb6jKNioVjbpIOXAW4LJgEUXgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz8DGACe9Uf9krL5P/pxVRFfG0DFAmujJ3qAAqgBqTPBTJPTdt
	6J49Tw3RLvNRGe8qxepbcLGLjiaWhL5NxAge/BsOQOMsmNlsW90XaUzC
X-Gm-Gg: ASbGncvK5wPT6pD40INVU1Ebj0RRyY9mcYnE+zoFEBaLbw6aT7KVh0jHK+TtNJvzLAy
	n3aZj03H7hBEEJ7BPq1SUx4uwcfftNn5iG/nLBLnGlrtLZ835PeVQx3XxOWXuUDb6o7z70Lem6I
	xtxeYduXkAccbdeIw/BPobcdJ/pEXIoCMSnOaqhWRkaNFTXYblx2eK8zGYn4tmpq4FyjusDDVq+
	Va9HEQZgk0FwLzHBxOH3cTdCj3cE8661+ybcYdgEJaES0ye5wmY2r1082UVQdk1nBRMAQGASVoD
	ko0bXYewz1H7gEayM1KcMutOTflEdD2WIUZvObAKAuAA5uVIVVevIAHYiQAyfkywfVLS+i9EEkw
	niGBfSlee49w0oEJL9gIIgY5S19QDmkbPSCslLLlHKN4m4mygzoF9f7G/TYq05G18pot/tBIpTa
	diHT1tKnC01I8g+OTO
X-Google-Smtp-Source: AGHT+IEvMM/2pS7MyEg5a69COj5yb3fq6RFct2Dw9l/mClKAn/ddwxAa+tgEEicOuheNKlwfqreUvA==
X-Received: by 2002:a05:6300:210f:b0:343:5d53:c0ab with SMTP id adf61e73a8af0-353a1dcff3dmr15404798637.20.1762880826033;
        Tue, 11 Nov 2025 09:07:06 -0800 (PST)
Received: from chandna.localdomain ([106.222.233.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc868fdbsm15531625b3a.55.2025.11.11.09.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 09:07:05 -0800 (PST)
From: Sahil Chandna <chandna.sahil@gmail.com>
To: yonghong.song@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bigeasy@linutronix.de,
	bpf@vger.kernel.org
Cc: Sahil Chandna <chandna.sahil@gmail.com>,
	syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com
Subject: [PATCH bpf-next v2] bpf: use preempt_disable/enable() to protect bpf_bprintf_buffers nesting
Date: Tue, 11 Nov 2025 22:36:28 +0530
Message-ID: <20251111170628.410641-1-chandna.sahil@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_bprintf_prepare() and related helpers (bpf_try_get_buffers() /
bpf_put_buffers()) rely on a per-CPU counter bpf_bprintf_nest_level to
manage nested buffer usage. However, when invoked from different contexts
(process, softirq, NMI), the nesting counter can become inconsistent if
task  migration occurs between CPUs during these operations. This can
result in warnings such as:

WARNING: CPU: 1 PID: 6145 at kernel/bpf/helpers.c:781 bpf_try_get_buffers kernel/bpf/helpers.c:781 [inline]
WARNING: CPU: 1 PID: 6145 at kernel/bpf/helpers.c:781 bpf_bprintf_prepare+0x12cf/0x13a0 kernel/bpf/helpers.c:834

Having only migrate_disable is insufficient here to prevent nesting,
hence add preempt_disable()/enable() around buffer acquisition and release.

Reported-by: syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68f6a4c8.050a0220.1be48.0011.GAE@google.com/
Fixes: 4223bf833c849 ("bpf: Remove preempt_disable in bpf_try_get_buffers")
Suggested-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Sahil Chandna <chandna.sahil@gmail.com>

---
changes since v1:
- Remove additional call to preempt_enable() which may lead to
inconsistent preempt state if invoked without preempt_disable() called.
- Correct tags as suggested by Sebastian

Testing:
Tested using syzkaller reproducers from:
  [1] https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
  [2] https://syzkaller.appspot.com/bug?extid=b0cff308140f79a9c4cb

Validation was done on PREEMPT_FULL and PREEMPT_RT configurations.
---
 kernel/bpf/helpers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index eb25e70e0bdc..3879eb42a681 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -777,9 +777,11 @@ int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs)
 {
 	int nest_level;
 
+	preempt_disable();
 	nest_level = this_cpu_inc_return(bpf_bprintf_nest_level);
 	if (WARN_ON_ONCE(nest_level > MAX_BPRINTF_NEST_LEVEL)) {
 		this_cpu_dec(bpf_bprintf_nest_level);
+		preempt_enable();
 		return -EBUSY;
 	}
 	*bufs = this_cpu_ptr(&bpf_bprintf_bufs[nest_level - 1]);
@@ -792,6 +794,7 @@ void bpf_put_buffers(void)
 	if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0))
 		return;
 	this_cpu_dec(bpf_bprintf_nest_level);
+	preempt_enable();
 }
 
 void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
-- 
2.50.1


