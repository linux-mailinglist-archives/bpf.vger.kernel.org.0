Return-Path: <bpf+bounces-78024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BBCCFB5B4
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 00:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CDC33058786
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 23:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35072BFC8F;
	Tue,  6 Jan 2026 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="kMdQA3Ko"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A412F83A2
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 23:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767742633; cv=none; b=KQnN+DtnaUOh0Zyr/4mf+FoMf5LbLAHSzu6KbCZbHto1v8tuEQWAkBq7/fdP+Wtae6gUQn/N10hPuHOwP2V995/eqKefQ1o7jznszDQiK6oLE6QTWa90TJzj/Xi6cHUblupEDToKxuneDZes1O8phKNtUFAZZskkWOb4JBnRpfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767742633; c=relaxed/simple;
	bh=WicPW52QeHTy1tXxW3JC5HRlqNkbjwICaULCZdE8S0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B2+4rwxF2qcmagT+8gUr2e8+Yh4XTYWe6ZGm3aAm4RQ0cl2fN/aHxzz0HrCMjyH8JNZN8Y0IMOyOOnie7t3TE57TyZJix/8hvM6Rj0U70YVpWMkcx4V6IOqTOCfRadA/EFG+D1L3SVkgT4SNP9Jx9Xk6NQHZhCnCou7V4ibMgQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=kMdQA3Ko; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8ba0d6c68a8so151105285a.1
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 15:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1767742630; x=1768347430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPIu72e+YsBxxnjNr2CdBSiAE96L1ifrDRIhDuKSzN8=;
        b=kMdQA3Ko+grtVkzdRPn5Vb/SxMXXzfK8nEQf253hFUNy+M70pmHXesMkPc1jmpMlvn
         Qm9Pw5blCBjy117sGCkVMisOyP8dv90LrrosmxGebfmGB0MgSCk/huHmg5Gb7uERRQdP
         RfNGmVCuKzyWi2mHN7Eo8Yp1gnTz9ncEyHo0qot+p7/OmkrGAZyHep4/ERCvlNrMJ1Lv
         i1/ExhKkgbDynFXfx1g4XbI6otjY7aQOAy1W16j4ovha2In2OYd6GKXufGVd02KqBDzh
         5HzNOoHslhYUu2xKs4WqIThaa/63e4b6+PXHe4Sd971O0Qj5SCEtHAhgP4n7BAwmiVDc
         CF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767742630; x=1768347430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qPIu72e+YsBxxnjNr2CdBSiAE96L1ifrDRIhDuKSzN8=;
        b=OU9GisxpffTvNJKvcN2zWhRpSn6tRZse9ldDNCkDHsqpD4JqjNbtrr/z1K/VDg2rh+
         VQB0FyYNhWD8hg6Rw3os78ngP2wvUfIJkZrpcBGyN82CIw8FzCv6t9CG+oYP7muDRNRR
         d0MUZoU6uzkg/AWGiNkoShqNUZi/yLJ6pdsMFFbyQeVGb5TnPIcYRyAGsfr77WpD7grx
         7+QjIhyKYENES//X06lUvmPjAHpCBTU/c5YoF8l1Kh0dvaCOaIr4wINM6mSGpoGZB56f
         3lKbrGiBLxs3YmmjCgZsDcGvE8njSbvzRxf+zPpLl+k63siMzZPTYZmKxQhGQJcHkqUb
         +xBQ==
X-Gm-Message-State: AOJu0YythguAsknCRqZb2k20iv+5i7bMOjrRrLgpfQxFAACodMRsIoe8
	1qauJuewJJ9zRw/Ru0Ti6qqWzWsp8twGD355khElZwBqWP4e5dG7ItHP1OgM+K84a8U=
X-Gm-Gg: AY/fxX4SiBzCBBjFrmEmuohw+FOxJxP1BrtLtLXjtDf74uUN9SE5a2GGEA6ST1Z5hRy
	GLY6M0f1lklEF5O+t9kTEH6BXagcPxbOvaNJjfVuE35Aep+qeV25gwzl+Vg5IwYH8cl5QRLjtr7
	f+tYeaP4derOkh83qb6J3AABTGBNBp9AJK5xc3BEU3yofTwTS47tB/7ospP4VUFpwjaoqvmM8zl
	k9wJPM1GAfiOSGV2DMQpAecrQo1vX5p2f0xJgKQsN851qKLlSVBJZzr2yWzS9mSA85tyVMLeJTJ
	vy25DyGdeBwLOzUIXZySIT+/YUkA05gOoft5qH32UnlOv2z2IfL7h+zHqTqiSclV08yAgQIC1Oa
	i9gDgcXf6WBpLWKr5qB/5AOD/5qbdb3s8fpQyEQqzDQKqaQLXJ6QpYXEdKwc69uoh7xQKgzSBLl
	+Ppy7F5shNRYjck84K
X-Google-Smtp-Source: AGHT+IE2DdWfaJqL2RKNtMPah2lBntRPCWmTU1axE+4kzZR7m409WN+ADBYzUN1KhkmD1Q+RRaYzCw==
X-Received: by 2002:a05:620a:410e:b0:8a3:9a05:ec10 with SMTP id af79cd13be357-8c38938dc31mr84962085a.14.1767742630242;
        Tue, 06 Jan 2026 15:37:10 -0800 (PST)
Received: from [192.168.0.7] ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8907724ef8fsm22590116d6.42.2026.01.06.15.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 15:37:09 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Tue, 06 Jan 2026 18:36:44 -0500
Subject: [PATCH v2 2/3] bpf/verifier: allow calls to arena functions while
 holding spinlocks
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-arena-under-lock-v2-2-378e9eab3066@etsalapatis.com>
References: <20260106-arena-under-lock-v2-0-378e9eab3066@etsalapatis.com>
In-Reply-To: <20260106-arena-under-lock-v2-0-378e9eab3066@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>, ast@kernel.org, 
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
 eddyz87@gmail.com, song@kernel.org, memxor@gmail.com, 
 yonghong.song@linux.dev, puranjay@kernel.org
X-Mailer: b4 0.14.2

The bpf_arena_*_pages() kfuncs can be called from sleepable contexts,
but the verifier still prevents BPF programs from calling them while
holding a spinlock. Amend the verifier to allow for BPF programs
calling arena page management functions while holding a lock.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/verifier.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7f82e27dd7e7c3e8328a5c4aa629b79db2dbe03f..53635ea2e41bb6cc64eaf84eab805aaedf1cba31 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12373,6 +12373,7 @@ enum special_kfunc_type {
 	KF_bpf_task_work_schedule_resume_impl,
 	KF_bpf_arena_alloc_pages,
 	KF_bpf_arena_free_pages,
+	KF_bpf_arena_reserve_pages,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12449,6 +12450,7 @@ BTF_ID(func, bpf_task_work_schedule_signal_impl)
 BTF_ID(func, bpf_task_work_schedule_resume_impl)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
+BTF_ID(func, bpf_arena_reserve_pages)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -12884,10 +12886,17 @@ static bool is_bpf_res_spin_lock_kfunc(u32 btf_id)
 	       btf_id == special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore];
 }
 
+static bool is_bpf_arena_kfunc(u32 btf_id)
+{
+	return btf_id == special_kfunc_list[KF_bpf_arena_alloc_pages] ||
+	       btf_id == special_kfunc_list[KF_bpf_arena_free_pages] ||
+	       btf_id == special_kfunc_list[KF_bpf_arena_reserve_pages];
+}
+
 static bool kfunc_spin_allowed(u32 btf_id)
 {
 	return is_bpf_graph_api_kfunc(btf_id) || is_bpf_iter_num_api_kfunc(btf_id) ||
-	       is_bpf_res_spin_lock_kfunc(btf_id);
+	       is_bpf_res_spin_lock_kfunc(btf_id) || is_bpf_arena_kfunc(btf_id);
 }
 
 static bool is_sync_callback_calling_kfunc(u32 btf_id)

-- 
2.49.0


