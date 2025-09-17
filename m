Return-Path: <bpf+bounces-68628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53329B7CC64
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9661BC1CE9
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 06:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E294B26D4EE;
	Wed, 17 Sep 2025 06:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8aicn3L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1956F298CC0
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 06:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758089379; cv=none; b=KAAIUAmCLJdI7QDyj17E8yIFDbmLFcreNudAwa+wt6STVT2rZczjKBFw1HQ5XylkeHJXpgWO1qLveMitd7W6aFwbMTCU983MfzN4Soj1+bTwJQOrgInQnz0acldI3ojWj/KeaDdL4jhnWM8200jCFZNhzu8CXzvbKbLjkGY97xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758089379; c=relaxed/simple;
	bh=sFbuMNox4i9aaUKyaARF6W36sL4xybBDCMsqhDSWuRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5AaUukAM6GSvEzMEnZj8I8RsuTGBmt4HdqowPR74ujGmRszTmcK4eZ69jK2qGYc+HsN//5XwFKZ/feFX/3TR+F+hc4AFp+4tbssIeEycPRREX37pTjY4nvS7HEVzNWDJlhq0yAK/wikRnphoj2i2fk/8n+vv+7pNiXmXYpRdGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8aicn3L; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-777ea9fa8fdso580336b3a.0
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 23:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758089377; x=1758694177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utq94C3VxoGuQS3QuI/fmnJBC+uMMJHBbGWmRbRXlAc=;
        b=R8aicn3LgkCJ6rW9Wx8Wvz311JCyTJHJDIvblHqlByDjsfmnSYkg41Xe4Jmq3wvyRU
         fewb00k0Jba5uaUvXXhg0dbyQVoaByBKVQsPxqGa5ULNWhBr3iMlCkiLEQJSPP0GL4UC
         /YlKNTWQeuJ6C81amSYfqrliVa/Zzj95ChC8cKEB8mQ6gax5uItmEOy9FxAKTyrFzqLv
         i3ojWCIW4nHSU4m7BzjznvzsmOudg0hGjwnNzibo3+vB+mtVnGPbrgeeBI/rHPZrluDF
         9x8IqtI2Wxz/zu9Bu6uVpgI9nPJXzZrTvwd9bJeh+may849EXw2mXXb4+8+EmRVP3oTb
         OSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758089377; x=1758694177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utq94C3VxoGuQS3QuI/fmnJBC+uMMJHBbGWmRbRXlAc=;
        b=J2nDCckWb4aW/wWzCMnmHhE1xmCeYNqrRwmDkcYZ0T2gkWaigU2ox+64RGDV0aIWW5
         d1h5IuSeeJ8q9gmTmTi1ImEgAAsdF7frQmRp3Nd05DfjsoabCxYv0+S4qLJ7Rr2tzaMN
         KNZrFto6wtH7b5qLzAb4byO4RW7WO3VczgYoqfQFYpvq23ExCog75V9BYGvtTy57o9x/
         aMhQ2p+Q/909ytwT65qJ4NHAEIpna/VwWGJ/eQBjNeSYx53gMI36GWiU/AEEb16kJd+U
         Qw+ubFGEP6HUiSpchA7Ye03YFU9nl1J6b/PDgxCG0zT5iiaS9IRPNTWeWyDd7jPhEax8
         ZB8g==
X-Forwarded-Encrypted: i=1; AJvYcCWXfHHVjnjDGj2r8/pxR+RRMC8mtfTVdURY/D3dl0VhfRJ162aPutZ4u70YFuF8cz1GOww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeAMRcrF/OKYK6107P6pPnInJ3icUD8mwPs8C2X1n+W6dLGp/Q
	BNk9CGueLSPIcp9fg6ybbo1mRaaat5WhbACIFiB8Hd7evzLer3hlcDyb
X-Gm-Gg: ASbGncsYfn+dCFz6G8PTBHce2YF2n3K32Yw5lnWM90bL80eQPxQwvE2L5puIlzCoyCB
	xmAZfMcrZUpxxdJGJatuc44/mzYMErO4bSuxWNp7lsf8bR0q0VEdO/ok+5kaVAgDMDLGItDk1gR
	sFgAVZL0xSOGhrgtN97zIjGJZkzHESk6EDPV8LWADHkYyUtBAKjuXrpfNTjjgqSoZ6F1JXDlXnU
	8JUbU18UIXMYgwxc4cPK1mI+68BzrLQxz7of26OrxaVABqe2P7lTHoTZ6o/jYz/UaDkxZ5MPCpc
	9LIoh5RY/GfJ6BNaDI7xNt9W8N+3TUNvd/I3/rArJcn/8qWMVsoswYOxO86yTAHtzvfZBqd7blf
	F/XzfWmRifo2EUlINxYY=
X-Google-Smtp-Source: AGHT+IHyE7wI/wBNXTL2G9Xu5VkmmyYEi5MPpXY5oaDnuD0UhDPs3k2sfKx40YqgmRplQY1pNY5FFA==
X-Received: by 2002:a05:6a20:430c:b0:246:3a6:3e47 with SMTP id adf61e73a8af0-27a21d12a46mr1286345637.12.1758089377248;
        Tue, 16 Sep 2025 23:09:37 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a3aa1c54sm15845427a12.50.2025.09.16.23.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 23:09:36 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: peterz@infradead.org,
	ast@kernel.org
Cc: mingo@redhat.com,
	paulmck@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
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
	tzimmermann@suse.de,
	simona.vetter@ffwll.ch,
	jani.nikula@intel.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v5 2/4] rcu: replace preempt.h with sched.h in include/linux/rcupdate.h
Date: Wed, 17 Sep 2025 14:09:14 +0800
Message-ID: <20250917060916.462278-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917060916.462278-1-dongml2@chinatelecom.cn>
References: <20250917060916.462278-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the next commit, we will move the definition of migrate_enable() and
migrate_disable() to linux/sched.h. However,
migrate_enable/migrate_disable will be used in commit
1b93c03fb319 ("rcu: add rcu_read_lock_dont_migrate()") in bpf-next tree.

In order to fix potential compiling error, replace linux/preempt.h with
linux/sched.h in include/linux/rcupdate.h.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/rcupdate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 120536f4c6eb..8f346c847ee5 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -24,7 +24,7 @@
 #include <linux/compiler.h>
 #include <linux/atomic.h>
 #include <linux/irqflags.h>
-#include <linux/preempt.h>
+#include <linux/sched.h>
 #include <linux/bottom_half.h>
 #include <linux/lockdep.h>
 #include <linux/cleanup.h>
-- 
2.51.0


