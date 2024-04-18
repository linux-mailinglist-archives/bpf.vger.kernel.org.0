Return-Path: <bpf+bounces-27097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F688A9052
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 03:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C803B219F5
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 01:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC274F888;
	Thu, 18 Apr 2024 01:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vrqW4XQ0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947334DA15
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 01:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713402460; cv=none; b=QRVj4WYwX7A5Gd4BRMUhGQrGaOPXJgGvCFR+l/AwRPVRVNXhQloKq0X0T5F7xPUnBvmBoo02OkAyxRaYM7/aWecR0QgoaDdE6aVilU0/msHX59blvXM6D5UuSxjK6kYpujEoUXgfm9VF+hbHPB9sdGa1Tth4t71AWH+t2o317zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713402460; c=relaxed/simple;
	bh=MbU7YSyF5IXinkJkjcfT0u+2sLXGMeKghessXGBFpX0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=utgoULb7JyaAREYvCljcGd1SVhfGOazJB4Qu6hsTbidSEjOzk6mTVZUXe9PJbCAxFIFX0EYgjQyg0Z0GJq0ky1+ESkpkl+IBCNuh+aHVWmaiw/h37NYeYgfKKYBmce3Q27094lE6WXLvUbKd/Dp2DqTBOCPym0CsZaT4YhDy0qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vrqW4XQ0; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ed2f4e685bso370526b3a.0
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 18:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713402457; x=1714007257; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ftfV9j6OBLIDvLqAVZnPAyLe0oFUXv4e5neRndjdTGc=;
        b=vrqW4XQ0BFqv0ya5iqg5r4kPq6PZeBGzeCBWccj+nlXEENmt9NjQuWOFGkeQE6iEkH
         16QHTsp74nfai2CnvpThOTem9FaRneGB2TSjHWIy61OaSrQbpW5T/Wd80kNmdqLqFjYN
         LbL02t1k28RN3q+vZLEwr7NOlncyyaXwgj9kf6ywLCzpYF0ddzPuBW22/w4NBOhTb5HN
         t8LIPUs5sUinAvj6YK1g+IR31E0cIOvfIq1y5jFjI8xB7XMPQEqACM7V5sZl13SMMGoR
         jK3Ypx8eHC+mKNSAMsK7e1GMJ8XuxfrM0C8JVqB32zuGRo6w6gtLUn5Q2yXRwa81vuSf
         iSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713402457; x=1714007257;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftfV9j6OBLIDvLqAVZnPAyLe0oFUXv4e5neRndjdTGc=;
        b=RtWpX4Yd6/IDO5QGYO1YVA2A5UY0dLbnuuK8yzDjilBIatc4LFJ1zlk28sQQJudl/8
         UYVL9fXVQCA9MCB6ER82NVslPYxZ9cOnFQ/CweW1L3ChDppp8/e0f4aAQlj1f1hF31Q5
         HZ8McLxENdMGnKduIGHfYS7GYewATnGcnZjthh2Ubh4WoPcY9ZqjmquRVoztX4Pt3wQk
         sw+E7lSIF3wStS5gz7YkX70LvZKg3x8F3nJMMbK+f82Mz+Iuht3ZGKWhph0csJEVkl2l
         /OFaL+lhPgdW/Vxohj8jwtafW1r9yg/v3ki2JWM9OuMXU+UPSmDdW/CB/QSsmpbtcRTU
         oLoQ==
X-Gm-Message-State: AOJu0YzoB9kzYzrZNWmeQCOW4Rxfp95uthUD6K4WtqKAaDx1JeiJAiOx
	biCvDJdVSO3XkOJnvCVxTRLQzzrs3czuZ4if8DaLyN8rjVbrCeOBlPmWW8eoaqHReuHL57iDPyQ
	dSw==
X-Google-Smtp-Source: AGHT+IFxtjf0ehGxX7kGTEvXPkhRF0cutHHpHytnpJHlFL5/6GICLjVVayguK2OZqN59wW0vUIOO9w2oOdA=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:8509:b0:6ea:e009:1815 with SMTP id
 ha9-20020a056a00850900b006eae0091815mr8773pfb.3.1713402456770; Wed, 17 Apr
 2024 18:07:36 -0700 (PDT)
Date: Thu, 18 Apr 2024 01:07:12 +0000
In-Reply-To: <20240418010723.3069001-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <16430256912363@kroah.com> <20240418010723.3069001-1-edliaw@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418010723.3069001-4-edliaw@google.com>
Subject: [PATCH 5.15.y v2 3/5] bpf: Generally fix helper register offset check
From: Edward Liaw <edliaw@google.com>
To: stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>
Cc: bpf@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Daniel Borkmann <daniel@iogearbox.net>

Right now the assertion on check_ptr_off_reg() is only enforced for register
types PTR_TO_CTX (and open coded also for PTR_TO_BTF_ID), however, this is
insufficient since many other PTR_TO_* register types such as PTR_TO_FUNC do
not handle/expect register offsets when passed to helper functions.

Given this can slip-through easily when adding new types, make this an explicit
allow-list and reject all other current and future types by default if this is
encountered.

Also, extend check_ptr_off_reg() to handle PTR_TO_BTF_ID as well instead of
duplicating it. For PTR_TO_BTF_ID, reg->off is used for BTF to match expected
BTF ids if struct offset is used. This part still needs to be allowed, but the
dynamic off from the tnum must be rejected.

Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
Fixes: eaa6bcb71ef6 ("bpf: Introduce bpf_per_cpu_ptr()")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
(cherry picked from commit 6788ab23508bddb0a9d88e104284922cb2c22b77)
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 kernel/bpf/verifier.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 61b8a9c69b1c..14813fbebc9f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3792,14 +3792,15 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
 }
 #endif
 
-int check_ptr_off_reg(struct bpf_verifier_env *env,
-		      const struct bpf_reg_state *reg, int regno)
+static int __check_ptr_off_reg(struct bpf_verifier_env *env,
+			       const struct bpf_reg_state *reg, int regno,
+			       bool fixed_off_ok)
 {
 	/* Access to this pointer-typed register or passing it to a helper
 	 * is only allowed in its original, unmodified form.
 	 */
 
-	if (reg->off) {
+	if (!fixed_off_ok && reg->off) {
 		verbose(env, "dereference of modified %s ptr R%d off=%d disallowed\n",
 			reg_type_str(env, reg->type), regno, reg->off);
 		return -EACCES;
@@ -3817,6 +3818,12 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
 	return 0;
 }
 
+int check_ptr_off_reg(struct bpf_verifier_env *env,
+		      const struct bpf_reg_state *reg, int regno)
+{
+	return __check_ptr_off_reg(env, reg, regno, false);
+}
+
 static int __check_buffer_access(struct bpf_verifier_env *env,
 				 const char *buf_info,
 				 const struct bpf_reg_state *reg,
@@ -5080,12 +5087,6 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 				kernel_type_name(btf_vmlinux, *arg_btf_id));
 			return -EACCES;
 		}
-
-		if (!tnum_is_const(reg->var_off) || reg->var_off.value) {
-			verbose(env, "R%d is a pointer to in-kernel struct with non-zero offset\n",
-				regno);
-			return -EACCES;
-		}
 	}
 
 	return 0;
@@ -5140,10 +5141,26 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	if (err)
 		return err;
 
-	if (type == PTR_TO_CTX) {
-		err = check_ptr_off_reg(env, reg, regno);
+	switch ((u32)type) {
+	case SCALAR_VALUE:
+	/* Pointer types where reg offset is explicitly allowed: */
+	case PTR_TO_PACKET:
+	case PTR_TO_PACKET_META:
+	case PTR_TO_MAP_KEY:
+	case PTR_TO_MAP_VALUE:
+	case PTR_TO_MEM:
+	case PTR_TO_MEM | MEM_RDONLY:
+	case PTR_TO_BUF:
+	case PTR_TO_BUF | MEM_RDONLY:
+	case PTR_TO_STACK:
+		break;
+	/* All the rest must be rejected: */
+	default:
+		err = __check_ptr_off_reg(env, reg, regno,
+					  type == PTR_TO_BTF_ID);
 		if (err < 0)
 			return err;
+		break;
 	}
 
 skip_type_check:
-- 
2.44.0.769.g3c40516874-goog


