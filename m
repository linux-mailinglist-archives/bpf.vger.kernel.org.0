Return-Path: <bpf+bounces-65979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CC9B2BD8C
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 11:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D8C1891BE8
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 09:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083B531AF1E;
	Tue, 19 Aug 2025 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TF3H8SXQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A18531AF01;
	Tue, 19 Aug 2025 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596083; cv=none; b=P8QgVzSMRPw5zD1pcnXPcy8EM5WA703IQjuTszcCc62Pk5jJGjivIWw16WX44Ss0WYBMwePnQPRt3G3H0FE/oowhMuxgFXoBNLfgTW4p7H4TpVEzrD9GusPEXgLTG9iSNeYF4rCbdvStXYj1hOrIQ+0C1ueAKPwZRIbl2am6OjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596083; c=relaxed/simple;
	bh=4DAxj5XfxLfONQDlEFKob/8R6S47MeAwkTppdmAYlP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1h6VfYfNpfCvLBGxhTp8fDBPHYb3TOduHwBroT3xoKz5TWBzTQ1Pbt9pprRsYoKLkdRYnfetFVMBC/B6WvqMsfA3RILpQg/8Ldr+MpihN1jsT7sw2iK23sBwtVnm1MHckIpgqfCiE85JKmwrccqpuRG1GzXIigjKJxdzCOTsXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TF3H8SXQ; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-76e34c4ce54so3805481b3a.0;
        Tue, 19 Aug 2025 02:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755596081; x=1756200881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaB0vGBq5NJv4vKYct/lqW2Woq/641IZ+CLzkcU8pg8=;
        b=TF3H8SXQPpyqfprqCk/goOCjXVj5X7vBtzBcR/YeMx9xyAwacixtLlu8GE0H254sD9
         lWVvSCRmvdbkJFesvEMqUxGCubzc/ymFYsvGS5EcqCNOaxnkGrHI2OFxnaleluzFfTQn
         FYKcBzpVRK9B5tRsm6tOZaCKxWRe6tO3mrnjLosbfzWZdytCbw8Ymo9RbcNDaRzl+Uhn
         OeCUTM1EAb472hSENxewRzUuHauIwR6/HoeP0CdmKhfMuua3sZZsdKlvt6XUgb8X5da5
         gflvVprFOyCuQJer0ys1KYK6pRppweCSWweP6OFyE7Xy8rjtJlvllnsBi0FfmqRnmktD
         bc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596081; x=1756200881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NaB0vGBq5NJv4vKYct/lqW2Woq/641IZ+CLzkcU8pg8=;
        b=j074gRwmAMUsjoyyepDpcw3hDq/HTveOqmQQu+JQqBE+/m9bLiAApesxLzWe+mYEDm
         Lr597FBXSbut90XN2iuZWnrKEBGG01393F6N9WCAfIP5o6EQk9SxGfmMWk1fmSP7fjk+
         xh+B7apzO1eQbmANL3bxd3047Y3Yw/s2EHXNqdHLiJ0wLGXr+s628wTFxAISB8MwBfrQ
         mb1hJUenm6/YaSiIMHhF9Nc6EhBGpt38ru6186JdEQk/zsRjhnCixLSFx5B+fklMgp5h
         fg1Cnd94PWQNEcrUYZ94jbKH3FRILAL61+6cuTr8g1Gku99WU2/pcJVNzBAM+pOKMGQV
         IbZg==
X-Forwarded-Encrypted: i=1; AJvYcCVrNnEVWIjrH5Meb42/dvKYmIICqXN33pjOKlGX+ruAKUNEguDdbGOUdxLyjjy8t8GTt30N@vger.kernel.org, AJvYcCWD3sVq7KgiSW4myhOgzysY0zVPNaTgf8elrvj/q6ZNfoGnUlVKmMso8eSrXAPlX/6eG7Y=@vger.kernel.org, AJvYcCXxPc5rRCzpObcaW2PH3pMmfEGjlHV1wNKMJhYDdVXGlmC2DyG6nTTZTLIwAnAbFePQbEsVfqusHEgcj/kg@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd7tt1TtkfmzODNChk8qmRtGH9E8UuePOkoLipMem5GQN2wW3H
	Zw4vrizTeVfdziX08pb37bKh8etdrpn3MzaAWN26+jrHvtxS4G+zoopd
X-Gm-Gg: ASbGncv6uodApQT7ppZvqN/qUvDuQZVZiHGy8puY4vYK2zeqv8rRB7VHjds8BPwsTLz
	5MPiNIVy8/Fz4AudKXFMvYR/pNXyJw9bBzvV2a+78q6zY0XXN8UplgAXauJ0r4HhT9xEkvGTo/3
	0vW1jbyo8XOS8epGVhEB9IB0+cWMnVSMU4jV5165IfUoGlNfG1gwGQL9WbCP+Z0gcpelOEUnv87
	HySNcPCjJaWfcfJQ4/VYS0/SqBjziuQhaC0aQOtp6zlv1H52XdlZGnxWTnLljSZWfVNQ+qcF9Fo
	gzeluXF5hfwe9CDwJDyHAsZMhNBL+lG+HMBAFpJ3k7CvIFpR5hmpDDbtNW27sQNsVRT0G1YWZt5
	1tJVoYnrpvpJqvZgRg8A=
X-Google-Smtp-Source: AGHT+IGonyZpH32TOEzDsZQXDq0zzesmgfi6wekH2vYDybV2Qk5abK+OPuJSljOJbLVWwf3+VArj0Q==
X-Received: by 2002:a05:6a00:8707:b0:746:1d29:5892 with SMTP id d2e1a72fcca58-76e8142b14emr1367579b3a.4.1755596081269;
        Tue, 19 Aug 2025 02:34:41 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d1314a4sm1990945b3a.41.2025.08.19.02.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:34:40 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	paulmck@kernel.org
Cc: frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	daniel@iogearbox.net,
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
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 1/7] rcu: add rcu_read_lock_dont_migrate()
Date: Tue, 19 Aug 2025 17:34:18 +0800
Message-ID: <20250819093424.1011645-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819093424.1011645-1-dongml2@chinatelecom.cn>
References: <20250819093424.1011645-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

migrate_disable() is called to disable migration in the kernel, and it is
often used together with rcu_read_lock().

However, with PREEMPT_RCU disabled, it's unnecessary, as rcu_read_lock()
will always disable preemption, which will also disable migration.

Introduce rcu_read_lock_dont_migrate() and rcu_read_unlock_migrate(),
which will do the migration enable and disable only when !PREEMPT_RCU.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- introduce rcu_read_lock_dont_migrate() instead of rcu_migrate_disable()
---
 include/linux/rcupdate.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 120536f4c6eb..8918b911911f 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -962,6 +962,30 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 	preempt_enable_notrace();
 }
 
+#ifdef CONFIG_PREEMPT_RCU
+static __always_inline void rcu_read_lock_dont_migrate(void)
+{
+	migrate_disable();
+	rcu_read_lock();
+}
+
+static inline void rcu_read_unlock_migrate(void)
+{
+	rcu_read_unlock();
+	migrate_enable();
+}
+#else
+static __always_inline void rcu_read_lock_dont_migrate(void)
+{
+	rcu_read_lock();
+}
+
+static inline void rcu_read_unlock_migrate(void)
+{
+	rcu_read_unlock();
+}
+#endif
+
 /**
  * RCU_INIT_POINTER() - initialize an RCU protected pointer
  * @p: The pointer to be initialized.
-- 
2.50.1


