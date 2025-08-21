Return-Path: <bpf+bounces-66161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 744ADB2F350
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 11:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D1377AD71E
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 09:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EB52EE60E;
	Thu, 21 Aug 2025 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg8cLrXb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2FE2D6E53;
	Thu, 21 Aug 2025 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767196; cv=none; b=jCpa5PpAlvuKqYtyzbiHIeXnN/ix4pOmn5GtU/uthWaXCYZ04jhD8g/6IsuPGSBGj30vbDLk6xTDfPidipji7LNEThmMskesTI5IsMk4pcDuhU5Huo2egqLO+A7jPPAE3lPcvQXYfrpGJYoHx1pEJAXJcrmj3+y0Dkdboh7jXcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767196; c=relaxed/simple;
	bh=bTIHaC7j+7J/bMwGU/BkRIOcDtOKJIMEeRQy/KliUC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLd5xaxcjxS7SfToPEa8Gp04UQmMgGsdRGVO4oaeoBnSI38yvEFXqKH8lrsnMKDFNlC7xO46c7hUPoSe7g/f/aqp7e+60jkmma4wLFkKOOGEGxKyINE6+QnCNUt96Td560tiqZUkbG1OkUk4FUkEiCSZcZL1aLWcbPgbmaL7si4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dg8cLrXb; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-76e2ebe86ecso991800b3a.3;
        Thu, 21 Aug 2025 02:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755767194; x=1756371994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuCltBuqWN/DSCHw6nPVx35dtf5n5wtufyyXilS2WWQ=;
        b=dg8cLrXb88fj0GD0nLVyeZoh1ISA3k/YSAX8pigBKV9P5z072mKEkNIWlQsKwsxzh4
         sd81YDEk0Zvy/UPrIC5S77noRdQeM37Xy2OnXECQNVqdzaJgzmaNy18qS1H6giBujD2Z
         OeL7piz4QwvHiRw2UUvK11cxooGG9NZiLAOFAOAvlZLdJ/Q+JsbhitqEv5foklpfmylY
         5VodKGDCrmTZjewURCi9IX2GrCYA1HPuubTn9WdGcAeNCLV2lmwNCkPh2DP/gQpPaEEX
         mc3xTBdKSRqKfn/uPy4TkNdU8z9FWo7eKkuRDy726XebXI1xf6KFaYQAxf1FBDtfR9mP
         FR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755767194; x=1756371994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuCltBuqWN/DSCHw6nPVx35dtf5n5wtufyyXilS2WWQ=;
        b=xDufCYeQczNX0YHkQ22AhRa10WkZ9hwTIXqZ9d+h0PoGee1EuQ40QRCsbquBD30ln7
         3QQ+jasBTo8bOjW2XjzKexiuqIyfs2+xkxKrcZZ+vAjME6GojEBycgYxxWEOZsgPTtPF
         CEybN1p35Vg3hYX6AHPF8s8/+m8hl+aZbYv1ZUfBrD+qdSGyx7rwvBLuKznuwbEubNLQ
         +GYj5buKMO5Y9EFqoZaXZWBdeF17VN+DF4Tso2qUmDPPeTY+eB9mq572d6r0syTRsCtu
         Cx5Wwl7yGLFI/ympQ7ZPnSsx8WwKBfE3GJuPz3uotwUR6rIuBIQoCywfIAL2Yfg+AkJ5
         lrMg==
X-Forwarded-Encrypted: i=1; AJvYcCVjRRGpXpxaa7mHAv0SH46VcPVHj8YV2ONdqLwQMqpiawZylQizJXWiUZ5+Nh/6xhg9glo=@vger.kernel.org, AJvYcCVksyFx3wy/ZMCeNw9Q8QolEV+5WPN9V56pL43ais+mtZ98BplS9CxOLGIjMVeSoeUCcxzj@vger.kernel.org, AJvYcCX+ObHcdWrWeFjDrmFxWi5glyGEfAv55EgIMLAC6GvYQ1p6LKRBUNU6xOrDpkPwH+Qpy/LIgcfRwLQcdfzq@vger.kernel.org
X-Gm-Message-State: AOJu0YzECJ7WcPHpc2SJjvsfpzebveq+4IQTH0pRpNc9no9+bbOkxA8L
	742QnK3ZlrReOSGnSHne58+mkW6TepkY7wZhpq2wenVViAhFOLCjNrbf
X-Gm-Gg: ASbGncvzfEDNPCjJcSyjWKXolXKczfHzIOTYo6C90abE2Gf5XmGxey4RzxmeivasqyG
	KakCMyIUn+P9wVMRnCvhb8Yu7j7xKSjdRZ3GDkbCOZz8LfbiHKuEeAxW2F5QMA+WH5KLs6nBt2b
	Tgju+d+jnO3og6yyCr3h40He34I9j6/WhK4IyAUqmmACKhIFn1nQEzYFFrgjm24gREWENr4Pc8p
	J/IbVzxtL4n0dXCIBjtmGZuFaMYoaGejnOLWwtQgiKw6w0N4wiQTB7OS9xYEA3nF4qx3gwYmfrY
	NvOpJSXDjPyL44Qr3Gi1lkTkcu25krC4lT85SSEqHAAXRphXIo0KabMjK8VVH/PYsN8z9LWBODr
	sb8HDanJ41MBKU4PUp6BEVFw=
X-Google-Smtp-Source: AGHT+IEvGma+2JUsOCtxjSXnlbSq374x1K7erjquy/3NUbEf1gradL10rCdgT7ko5FE78MonWWLHBA==
X-Received: by 2002:a05:6a00:928d:b0:769:93fb:210a with SMTP id d2e1a72fcca58-76ea324adfbmr2504056b3a.21.1755767194490;
        Thu, 21 Aug 2025 02:06:34 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76ea0c16351sm1708937b3a.14.2025.08.21.02.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:06:34 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/7] bpf: use rcu_read_lock_dont_migrate() for bpf_cgrp_storage_free()
Date: Thu, 21 Aug 2025 17:06:04 +0800
Message-ID: <20250821090609.42508-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821090609.42508-1-dongml2@chinatelecom.cn>
References: <20250821090609.42508-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use rcu_read_lock_dont_migrate() and rcu_read_unlock_migrate() in
bpf_cgrp_storage_free to obtain better performance when PREEMPT_RCU is
not enabled.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- use rcu_read_lock_dont_migrate() instead of rcu_migrate_disable()
---
 kernel/bpf/bpf_cgrp_storage.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 148da8f7ff36..0687a760974a 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -45,8 +45,7 @@ void bpf_cgrp_storage_free(struct cgroup *cgroup)
 {
 	struct bpf_local_storage *local_storage;
 
-	migrate_disable();
-	rcu_read_lock();
+	rcu_read_lock_dont_migrate();
 	local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
 	if (!local_storage)
 		goto out;
@@ -55,8 +54,7 @@ void bpf_cgrp_storage_free(struct cgroup *cgroup)
 	bpf_local_storage_destroy(local_storage);
 	bpf_cgrp_storage_unlock();
 out:
-	rcu_read_unlock();
-	migrate_enable();
+	rcu_read_unlock_migrate();
 }
 
 static struct bpf_local_storage_data *
-- 
2.50.1


