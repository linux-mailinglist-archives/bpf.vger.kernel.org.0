Return-Path: <bpf+bounces-46059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1329E32C0
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 05:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B86DCB287BE
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 04:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ABD17E019;
	Wed,  4 Dec 2024 04:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrE5puTc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C177C12B17C
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 04:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733287689; cv=none; b=YVv+x9pg1pri2AvG992o5SxIqzHkMZgeTR22ULbR+gVB7v/jKYD8h/sX+aBtvQjHRtPFTPmBb741n3UI9gBbt3OLkCNohxvKnHCRrke1eziLAHkQHjI5Xjn7NqZV9KTjYnUpXyrlGU2o2dZJxR1bBXHZDCldDTb0bmNYSUPY1vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733287689; c=relaxed/simple;
	bh=Gu6ynwDLEc+arHwbd2nuJo0pV1QFFVtXpiSfI08AKgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JShT19719RTH8K05Jra6uADVQbS27457UJG8b6TQ1zCqqycksX4hmZ+sFprqvfaeeQ2+/ZMrdQbMzmUCBk4lTH8Cx4YAcNI23G97OPrd/Iaf5H2/I5mWRs0VCEPrI+7T+3rW7Fj7IY4LGyp0Ss/pB/fXvjD7vRW+AIwFyEM6/js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrE5puTc; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-434a2033562so52089135e9.1
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 20:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733287686; x=1733892486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjWwkVfCgW7gxVF5HeZs0LuHrf7Z23DitUwnrPlDP2g=;
        b=CrE5puTc5yfBSgM8i8vGYr01Bh/kTal2RCAoNCTj6oY8nsRVfmN92Jjf5uoTkl5DjP
         rhyoGH00q2kY/FrmOAtDKjD7qu/AKt3+v1v/HGgKL1COOAzKaiUsXL1q/+EPq3zZge+h
         kPqn2scnPyVslNnkG8sKnLfXFgO/0+T6PcfADqIJ2jh2zE4PyopAo3hZB6JG5Ip143vC
         0BugEIjeVBTuA4m1GMmmtIhPvUVhJjPaotxEyUYtWtXveMobn9Epr3HZSPBrcR5XPL+r
         cQyzgGDjYOg2A0Ok66C1tBuUyxAnSMMo1XVnrgvSttMWQU2JiXZLEyyWqtwi8yZmtwIw
         eiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733287686; x=1733892486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjWwkVfCgW7gxVF5HeZs0LuHrf7Z23DitUwnrPlDP2g=;
        b=agVQhn3UKTzjLnId4wvVhtKmcOgdLcghYSsPfutlPWEfX2UkPgwHIe5nWAoR1r5FaF
         fMH+KD/u8Rv0fXnPqzn8Tk0nTOdbjqpGHZ8R8Rkay7GVTRU3gy/81fsHGvYNbZ467DDx
         JkhHxvHYtHI/TVk0+KGh8rZvn51eM+BMQDhFBqiJlcMoeNSQClFiBPsDn3CPr3hW3WZ1
         qztlgCNXCuiPJXGgUHqU7MKvFqdU2XErgy5roSxfH4dny79PO8/YAW/fBb+D1hZ3FAjv
         LISgcfekjwxc8PinLsbW2tQ36bLuu3IiDcJ+76iI8VWBBuMKUgwmCqMVow1Z8R8Iohvq
         B3Dg==
X-Gm-Message-State: AOJu0Yy7TcrsXC8/wd/GU7QAY1NYzAx9n7pEszmRqS8Ocw9V8HdyAVip
	9x7xsenzqHlgAMtbmFd2MORhVr3LCkT21F3XkMCZDCYfXqhHkAH4I8Af5d296S4=
X-Gm-Gg: ASbGnctC0DbQTAJrV2c9ukR/657JcxQQ00fPCYCCO2BcE+rL7adxgsRIDenGXeIfuBd
	m9N3i9z84IGxwOxt9L7PN6zBBxdPXEugTjj5azlZcf2NIKhUDojA1G+YGP4xgn3WPYxvcT2AO3C
	yE1Qz4BTgbpCd7gjOiUMNEeDH2ER7IQtvkxbK/g0gv6/uyT7H5bd8VEHnFYUMKlsMhG1tYDDN77
	F15yh99U9spaTLCwB325I7vEBM8f/EYdHI9xJgniZQ6+VQDowa00Zml0imPq2qPUxw3yfcNhgHO
	WQ==
X-Google-Smtp-Source: AGHT+IFKOY9fLQaqLNxImeBlaHjWA3UQus4q0nD6+MpqtZANN6Mg3x2Gk9kpg+GyXRHauBR28zhvPg==
X-Received: by 2002:a05:600c:1d1c:b0:426:8884:2c58 with SMTP id 5b1f17b1804b1-434d58438e6mr5215465e9.4.1733287685469;
        Tue, 03 Dec 2024 20:48:05 -0800 (PST)
Received: from localhost (fwdproxy-cln-027.fbsv.net. [2a03:2880:31ff:1b::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d528a6ccsm10024215e9.25.2024.12.03.20.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 20:48:04 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tao Lyu <tao.lyu@epfl.ch>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>,
	kernel-team@fb.com
Subject: [PATCH bpf v4 4/5] selftests/bpf: Add test for reading from STACK_INVALID slots
Date: Tue,  3 Dec 2024 20:47:56 -0800
Message-ID: <20241204044757.1483141-5-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204044757.1483141-1-memxor@gmail.com>
References: <20241204044757.1483141-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1306; h=from:subject; bh=Gu6ynwDLEc+arHwbd2nuJo0pV1QFFVtXpiSfI08AKgY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnT97Gz0wdlq8AaUu6mEAWn5WR34Xsv+WI1ziItzeV dwmS6M6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0/exgAKCRBM4MiGSL8RyiytEA CPv02axN5mBh51KPddl3hB3q+FyDJlfsaPciSucNZPc7tUQwOxB3Utb3YaJs5ganWWNeZYuc2mhRLn cvhjpAmKZpDJRfTh4+2UN9ukS9pzwbxPkjx8+wQ0DKRQP2DGG7YYs8GsKBneeWLoM+6W2kOHx10QYR NJbXX2noQYTF5BzFwF/1QYsNtprmRnYFBPvATabaZh62Oj8C6NnpXUfQl/0YvbSgzgORX0Fzbj4tLJ 4I+TQU7t6HcuFGmSLbtqIeTWoFpbQDWjgSCXhcGptuWfGTN1MgB40mLVQNs+bBMsFDz2RKRoBosp5H lioyELdgRuqnfg4qXU1qaZRP3rbeKEY7m4KR29YJcIccYDvJLhmM59FPapXymT5Yw54rt2M83wXBCk itoG2kUwjM1jcbc9oJF8HK4jSRZbm1FKK1teKps/GpJEu4l2YVKZyPT3DFczh4ZSHlSYv0R4W/RksM G3lJhIWa4Royst2+aSF2RD3VX8rfuyBWUExmEX7TWrTcZHHdg3etpvL8i1bDKxJhSryaH+QrjolFsW A2xeXcJe+meFQOo2ejLabSwIJEaYTkVJJtomA7MwLk5AqrRF3IY5iOKgQcfKjhjjrGD81KSTKvVAPJ 4/IBS6NdZFRb/i0VtuWo1REa6gqpGFhHq1W5YmR0PZJIDBLgvezYkS4oIsOw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Ensure that when CAP_PERFMON is dropped, and the verifier sees
allow_ptr_leaks as false, we are not permitted to read from a
STACK_INVALID slot. Without the fix, the test will report unexpected
success in loading.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/verifier_spill_fill.c  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 671d9f415dbf..bab6d789ba00 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -1244,4 +1244,22 @@ __naked void old_stack_misc_vs_cur_ctx_ptr(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("stack_noperfmon: reject read of invalid slots")
+__success
+__caps_unpriv(CAP_BPF)
+__failure_unpriv __msg_unpriv("invalid read from stack off -8+1 size 8")
+__naked void stack_noperfmon_reject_invalid_read(void)
+{
+	asm volatile ("					\
+	r2 = 1;						\
+	r6 = r10;					\
+	r6 += -8;					\
+	*(u8 *)(r6 + 0) = r2;				\
+	r2 = *(u64 *)(r6 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.5


