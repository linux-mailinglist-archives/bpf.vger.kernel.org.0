Return-Path: <bpf+bounces-65719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12388B27902
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 08:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043D4AA1BFE
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 06:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D632BEFE5;
	Fri, 15 Aug 2025 06:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ru5hqTH1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23AF2BEC45;
	Fri, 15 Aug 2025 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755238736; cv=none; b=ZDkSlaNmB9+Lwf55MKhI6hTYtPymb/WVpYjkJRrPBgasnamC6uommxp1vLDfK55RicMNAxP84ML/eJe6HjonwGhovta5n8rWinh7om3bHWvc7kT2zvlaiIhXtKItoVT+jk3fxj+Y4LYkQ8mvyt0tc1M/aRe8+r5GTkS9o8UT3B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755238736; c=relaxed/simple;
	bh=NsTLfMZJHJXpCLXkFepb95eQuuVS8RrXqUe2lWsYzoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRb1faFUUQBrTC1lTb9hCTN9JtCJGerM/eOuZfwnl3zlAfXqrghbD1yJDgtK9tgrZJOqgtbAFex8k3xCUm0BapiZrxWhvjn0C7e1TByPnNAqYXcC1RLaZVEg4v8DFqtAQSddpPw+ESyhMSCg+Uoe4UhW9B68d/ERR5R+ulZYhgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ru5hqTH1; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-76e2ea94c7cso1608327b3a.2;
        Thu, 14 Aug 2025 23:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755238734; x=1755843534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9UFGo56n/vlzyp05DMGHWO0l7I4ZKS8r+x7sWODQkI=;
        b=Ru5hqTH1e8PeSf06TiBOBq2Osjsnjxex33Zu9+4VIKOx/oAzv691pAFqvEf/OuTlBT
         /FOmQVZu8htNLctKcKjHd/9yffxovsrqdelMw+YchaeihWrv53pDaKQOfWOm2zWsIwFj
         hdGHIApDp7e9LvkzDf+bRGT6U/HIe9xAlBJPSHK3Z4b7WfRxTmKHkDsx+r/dvNBUfiHY
         F9gRVovtUud3LrbVm0+4SCjydnEK6UObkVQYHKpwpc8/WlU3GRI7t346ujAvztiBgOBj
         KdYHRnaWPvZ/55qLzvSdE3tVP0CYS6je2NwIHU1bnkt2ekkAMnez0UAJ1EY3jA9rtTKu
         FmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755238734; x=1755843534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9UFGo56n/vlzyp05DMGHWO0l7I4ZKS8r+x7sWODQkI=;
        b=aIF7HriAY2aGCPUDFLzhv29uCwSFnE5A3zZT5iBOSjXAh5/ZFXRxDCDigRX028VHsL
         x+H7wc9VrgZqbjfrEXj+gXJpCOpuB2dU6L406vIdqCLM+vr4kwlCLOt/Y8duntA+K7sE
         7JEFynK5BI7wu1J+8FHfOY8S7ay5pIIanj+ubytSHoyC1/9nmX+2DQgDxWA7hbffIg1v
         qThYc6SfNliKyieTHYBWWpOVDVHEu3VryQ5ai2FBzKOXgBH9VLVQ1aC9qek58qdrb8ox
         xuAXz/pnYeUeTT75uoYemU4b+JsFQO8g04tBWnKMkTS4e7P3m70smMFfChS/0pfzUOcp
         96eA==
X-Forwarded-Encrypted: i=1; AJvYcCW+PmvK02T+jVa1dLfknhttdXxs6xx0IlKgypvr96LFQsLk+PwSCeBjHyFwLksrEYLJWJ8qAVNuvCXaN0ev@vger.kernel.org, AJvYcCWhaBEhT9C2uegWWMXQA0aK7HMzCjRoXY1szBn2n2Rl14i9nUyt8R7r85V28ppdbpOcq8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRYAjzaeabeG5rKDPPL1A5rLyQFWRHtqRejPtgc32sN09P9RqQ
	zn9SE6in04Bm83NFUgKuC16K1jqPqfARQlU5jb9MndC6ltAjr2czYJMaSmZ7G+v/SuI=
X-Gm-Gg: ASbGnctwxbWJICXFdbgu3RQh2MFS4XdfmmXO31daYrpxC9SPp7vVry2z2DCaxSX8jyZ
	iqdJpNekSgvU/oG0RqRp8HotyvvGHOtBT2m/RTp1M9p1Vwkjyjp90pHG0iGleLaAeH92ZuW7nwa
	9RTxqN6Q2BxA5gTqxprUr1tYdT6xrmc0A34LV5LuPXkuf4xMpY+yqZZUxJmnb6JZQ9t89rRWaXr
	L+KrjCZWRl46e9VBxSkd9X3wYQULtiAv4vGe6O+9LSE6ZuAvhQNDDIPZYTMqjfm44GJNScjfndo
	1RjJbUF0WcpJBHdw0bRjhMkwMUHnr174VhXTHMQmilWk8WU22rq9eFSmC5TTdfs3j7a1CgCPGUP
	QuuygJ6CIAqQ9lydAafc=
X-Google-Smtp-Source: AGHT+IFXvxzrWpGs+BsYWvc0w4oMbPxVzgIDu73nUQLenBzwZeujKkQmCCKVbkNwqlMgVGmraBj1Ew==
X-Received: by 2002:a05:6a00:1acc:b0:76b:ed13:40f5 with SMTP id d2e1a72fcca58-76e447fd3f8mr1409114b3a.18.1755238734294;
        Thu, 14 Aug 2025 23:18:54 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4558ae7bsm408607b3a.95.2025.08.14.23.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 23:18:53 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 5/7] bpf: use rcu_migrate_* for bpf_task_storage_free()
Date: Fri, 15 Aug 2025 14:18:22 +0800
Message-ID: <20250815061824.765906-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815061824.765906-1-dongml2@chinatelecom.cn>
References: <20250815061824.765906-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the migrate_disable/migrate_enable with
rcu_migrate_disable/rcu_migrate_enable in bpf_task_storage_free to obtain
better performance when PREEMPT_RCU is not enabled.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/bpf/bpf_task_storage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 1109475953c0..cbbf1b72eece 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -70,7 +70,7 @@ void bpf_task_storage_free(struct task_struct *task)
 {
 	struct bpf_local_storage *local_storage;
 
-	migrate_disable();
+	rcu_migrate_disable();
 	rcu_read_lock();
 
 	local_storage = rcu_dereference(task->bpf_storage);
@@ -82,7 +82,7 @@ void bpf_task_storage_free(struct task_struct *task)
 	bpf_task_storage_unlock();
 out:
 	rcu_read_unlock();
-	migrate_enable();
+	rcu_migrate_enable();
 }
 
 static void *bpf_pid_task_storage_lookup_elem(struct bpf_map *map, void *key)
-- 
2.50.1


