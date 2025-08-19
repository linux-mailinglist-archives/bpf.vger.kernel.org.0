Return-Path: <bpf+bounces-65983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED676B2BD85
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 11:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7176807D0
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 09:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874B131E0F7;
	Tue, 19 Aug 2025 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aex/QL+l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1D0311958;
	Tue, 19 Aug 2025 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596109; cv=none; b=QlvUVAk+9pj13fBIvwd4WRjOSaamU2FwQNvzkyQZggsVYCquag5AW6DgYkBbqU7Pv4HTeCmUD9C4Mz0MgspmSOwWBNOdr+LNk+CCXwP1nIuMy0tc8YOlKaGrRoPuMfxXpBs/S+MFdr1GjLVZPHYdOPJGovpYOzsTDIhVLP4UPlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596109; c=relaxed/simple;
	bh=THRCv3ozIqTTxq6bSRfB2pdWOOnyKsRGYogE8fXxDkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFDrXny0O1ccqzz8I+d1XN1cI4OagrDTtRT0PYwVWv7KIIjjnALSkvL4IUi+H/vuAU1x3CfA5z17sFH8vkGsUOXQpqelD6WkIN6siCeGssW2UyR5B6j03ggJxmt6j6E7L/408lat9wkCUhlvUQ8tg6nX8Akd5cLrA54tRuPCLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aex/QL+l; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-76e39ec6e05so3200311b3a.2;
        Tue, 19 Aug 2025 02:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755596107; x=1756200907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Bptfhu7onpt0MqrEIJlEVMcozR6INxKRYWqNZ+YESQ=;
        b=Aex/QL+l+6kT2q0gBfiKeIka0ghIjUwlB4PTJoSSuglWux3YsI6HmIaZhYMnbbXjjI
         oS/dLzeENpPymerw+IdFikYmKueC08eiao4wQRflLrfWz5nqUDoApOLxSdszSXg7heXy
         N0vvaS7j0dLEQQ7MViZW4GAJe7GvuP4TwdOtT+vAASoa5hnC7ICylz8Fcyen14W85TUq
         xFAJUTHt5ZDgpEGBIOMAQQjMjY4AjxdRhkRVlt5za/3CvgfTDBKvFRSRQemA8Umipncu
         NCV9QuwoMgUlHTivLtvo1RBxcQoL9Mpsfr5JhZEYqmtDjqbaqmX8Mv9mam5EEXsFhvtb
         0xsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596107; x=1756200907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Bptfhu7onpt0MqrEIJlEVMcozR6INxKRYWqNZ+YESQ=;
        b=BZsejjf5PGwc+8pQguT1OtSxfCGagDeUNOEKo2UFAprCnzeTC69guinlBraG60xXBd
         Bl+ccUrxnQZxE63+VEfGd0p4FEcnAJII5R69ZlaPR3RWvtKIx/Mqt1ULst7pVKAKEfsy
         rCupaW0N1ZDhXkNLFN4BPrg4m6kSlnWtoHzqKZCN9pKxbaFZulVYk2OPZV0wmvPNbSjz
         YeAkIqoDlWWs4bupBIGiQerHrDbx/Sj+N56HHYHQdE101wV0eavSmI6RutY5UmKBVluQ
         mAxY3smRKPTxwvndi6yDKGWlDHj14Bc22m2ZQ4HwLb5srFYFyXkCwOdQAgcWzydHgcxn
         7UqA==
X-Forwarded-Encrypted: i=1; AJvYcCVM8xlfcqX/3Jwp481AMhMUQ7nva+isC6pwTy5PVMRZcd+PUAAdlqhnKTvi4HXcmxYDtZNH@vger.kernel.org, AJvYcCX7j+st6cQHLuIsK3St9mCZRWgHPOl0wd6BQG4EasHq+ySC4ba4+04WHkqbubJlSpOjhGqwsoyKiFrlSm+M@vger.kernel.org, AJvYcCX94FuGb/3piyz3NhNVJkLY3hJwnpuzAQKPc/WYAiqdP1go4hxCEfWY2V2IMQHPxJVShRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6eEvcFxqTD33h691P59QkGCLpHgkVvEJT+LLsPVWSNNVdbqca
	4Hpy0fLsbguciEPQhI6yFLFj2a+ftvUKj+rAqxyGh//RjnhGCAiljDXk
X-Gm-Gg: ASbGnct9TCXfy0EiSG94hD+TD+5/rGVQM5gazH2QlLHhnGlQ82bn9M7ClTN5YFmpa6K
	NkozWM6sWy3FYYf/4QyAxO1ygtprKKgtOUr8fIX+StmN314HHzFbBEY3vB4+he8zH9gJK+2oxkT
	dt/imlDZv334WmH7mGp6h0VQmLZiwIK84s2eiJBrsAxBRT3WV+Dc2z/p8viOiXquMJnr7UzW49p
	RN+e8erhWTAKSRudTS6Gbv6Vwtv+Xpvt3f2gJTZELf3k3lb3E/tkXE1zfZuklbcpjsh1bYjJ0Mr
	TZUqpunGTp0YS+Pp4t1xP2HC5B6ImxFNWvwa5UiQRG9e9CYYI9tQo9wflCyxxmYWmwsFdU3a11/
	AqzGq0EP8bimlN0iLsxM=
X-Google-Smtp-Source: AGHT+IHjJOb9KVBoRIx0dMtdn5Tm/ZyMgaKw1QrpeMKOEmjf5u4O9taZJ8hoZaFTbIO3uMnSpJXanw==
X-Received: by 2002:a05:6a00:180e:b0:76c:503:180d with SMTP id d2e1a72fcca58-76e80ebcca8mr2354947b3a.8.1755596106880;
        Tue, 19 Aug 2025 02:35:06 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d1314a4sm1990945b3a.41.2025.08.19.02.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:35:06 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 5/7] bpf: use rcu_read_lock_dont_migrate() for bpf_task_storage_free()
Date: Tue, 19 Aug 2025 17:34:22 +0800
Message-ID: <20250819093424.1011645-6-dongml2@chinatelecom.cn>
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

Use rcu_read_lock_dont_migrate() and rcu_read_unlock_migrate() in
bpf_task_storage_free to obtain better performance when PREEMPT_RCU is
not enabled.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- use rcu_read_lock_dont_migrate() instead of rcu_migrate_disable()
---
 kernel/bpf/bpf_task_storage.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 1109475953c0..a1dc1bf0848a 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -70,8 +70,7 @@ void bpf_task_storage_free(struct task_struct *task)
 {
 	struct bpf_local_storage *local_storage;
 
-	migrate_disable();
-	rcu_read_lock();
+	rcu_read_lock_dont_migrate();
 
 	local_storage = rcu_dereference(task->bpf_storage);
 	if (!local_storage)
@@ -81,8 +80,7 @@ void bpf_task_storage_free(struct task_struct *task)
 	bpf_local_storage_destroy(local_storage);
 	bpf_task_storage_unlock();
 out:
-	rcu_read_unlock();
-	migrate_enable();
+	rcu_read_unlock_migrate();
 }
 
 static void *bpf_pid_task_storage_lookup_elem(struct bpf_map *map, void *key)
-- 
2.50.1


