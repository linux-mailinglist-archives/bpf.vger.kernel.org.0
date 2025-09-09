Return-Path: <bpf+bounces-67911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8631B503C9
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 19:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4589C7B8DCE
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 17:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077FA370592;
	Tue,  9 Sep 2025 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="PqwfAM1N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD13336CDE7
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437229; cv=none; b=MzIMMsg1g0vHeAEOb6S0pFMBdf3//gYUW+LvfQDqQs4dG+IaDk4G0U4WYro9rmLf/cmormZxrdv9UkvF5Q0pFheSzoVTSB4KZIjwxAlOglhad7NZCyDDsaI/BIcDb2gMpEWbAuoZqRT4j/4gvtTJB0WKLpiwaYiq2DA4oxAa2aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437229; c=relaxed/simple;
	bh=i9ei76HZWXEGFxtJrVdE8n0QQk9q0CIQwkPYsw8lY9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YM29ci8mCkqmdjsktESyvCt1+D0mUAOPeJCu9LT9vZoEAlmF/Y8CyFJoeTXHHWLVNSl8d/l0P91RXRr4G8y4fPf/qPH3ChVvGwxGQAjUNK6mvzm+6bVAgWLQFeAjL6LkaybZSzWl/qDd253ZQy1lRPJ2WCiQUWJ1HyXidgaxKz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=PqwfAM1N; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b5232a989a9so72515a12.1
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 10:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1757437227; x=1758042027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntPkdum4JIas65l2vIjgWtP7aF/9GTTAGBMQDfY89wY=;
        b=PqwfAM1NWp9oA4UyykJC0oUnvQ/T99Z4CSxP18cC5vM0ZKsWbGieaZBiuCLGvHU9N0
         +CcP+gXZZcRaBwPSQ+92gnvdX9A8gnLvlGNm3/XF5IQiZJLTqB0e8UKtu/RM1u4hp7Mg
         wqV2X2TB5pbpe8Ijng1ietwperHhdwxcQl0vVIkPADq300i6Ah0/MtcPHujmPFJ8P5Sv
         hVBVZ0k8xY9KHc+uB7imkq5AZnVLmltK/IcCk6U3b+ErBNSLhFgcLYXDY6u0fySYMiMl
         7JJEYEfK0K1qUVyJoYyDwn84+iMmmtrpuUOl5W0tpRXdxFTlVMbCi7NuZ/GEHOouf4r9
         XC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437227; x=1758042027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntPkdum4JIas65l2vIjgWtP7aF/9GTTAGBMQDfY89wY=;
        b=mqmhLWqdUNu999/JLKp3vHBQYAOUPIdRox0ZVU61oMjgYMxJuFwlL1qMvmUCP+JLRR
         xiEFqhg3G+OCQGkG/lzy+++GeVRsE9vZykbTBqfW2rWfK+fkwUXbLn9ZPYDt2T9NSEEJ
         Vj0GNHzLeM9+H+ufd76tKdzb6nHKWikP1fW8nK9DD5ErJiWcE19nox2H3oa6+CgiZXyF
         tXz0QbbuY2HwIQOW0PicPc0gh6cT+bU/w02ATDw1ASF0mLiLpChPQBx94eDNRRSZQwxA
         T6IPGeMOyvoN/iKYz6Vs8JmNbpxkcZ6UgNbA9Y17SYdPySpOWrHndFGPHESYN2Y9oey+
         6BPw==
X-Gm-Message-State: AOJu0YzkRErsd0tVSqPct1uaNemUi4f57fOr/xz9S8QYDVMEIvyu01pi
	Sc2Hvu3ac2y41p7HA607PrFhzxj+3sVEeH9mbjERLG5vaf5EHaN8BJ4OVIM5D6YOylH+YjaTWfn
	OFl7D
X-Gm-Gg: ASbGncuhjNoZBM+uaBkpniLbM7HcAhQCM8/fVLOYRjsIODqI2RFJxcxmCdOQ7kAFZeP
	9qpcGEnU9UJdEP+7siD4uzobDw3XPQIDfeNUCRSbRVWUJECgjIls7M8VtuA7pIYJ6KuT0IEblKn
	qGB6WVm21x8GbHIISulp1CmqNs/IKJ50AtHKBzAesX4OfQKvKoDZ7R9nCawN69E3WPv6fmGRUdq
	YXJg2Xvqqn4DBcILblA5sT77WIaiPzbxmYGqkiIYBhskVCIGN4zjojczafMk9KBjlq3iZicNT9o
	KvYfi6sK49263I5Tb/o7ssy4WAOrt6WAh9q7kfCOT1LNdrVrgqCQwTIMLgFnPHmZ9R+W/CpHcud
	hkj72epoEyhv8Z3xdR46LF0Z+b/FnHxGw5U0=
X-Google-Smtp-Source: AGHT+IEQmlU7EzM4zglr0GOpZvMozjjX/W2WHFTus6ChRNLVwg4aNDOe25tOH1775VMpAunjMzwSTQ==
X-Received: by 2002:a05:6a21:6da1:b0:252:3a33:660f with SMTP id adf61e73a8af0-2534441f65amr9965270637.4.1757437226661;
        Tue, 09 Sep 2025 10:00:26 -0700 (PDT)
Received: from t14.. ([104.133.198.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6a814esm251733a12.29.2025.09.09.10.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:00:26 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Aditi Ghag <aditi.ghag@isovalent.com>
Subject: [RFC PATCH bpf-next 03/14] bpf: Hold socket lock in socket map iterator
Date: Tue,  9 Sep 2025 09:59:57 -0700
Message-ID: <20250909170011.239356-4-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909170011.239356-1-jordan@jrife.io>
References: <20250909170011.239356-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to socket hash iterators, decouple reading from processing to
enable bpf_iter_run_prog to run while holding the socket lock and take
a reference to the current socket to ensure that it isn't freed outside
of the RCU read-side critical section.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 net/core/sock_map.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 9d972069665b..f33bfce96b9e 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -723,30 +723,39 @@ static void *sock_map_seq_lookup_elem(struct sock_map_seq_info *info)
 	if (unlikely(info->index >= info->map->max_entries))
 		return NULL;
 
+	rcu_read_lock();
 	info->sk = __sock_map_lookup_elem(info->map, info->index);
+	if (info->sk)
+		sock_hold(info->sk);
+	rcu_read_unlock();
 
 	/* can't return sk directly, since that might be NULL */
 	return info;
 }
 
+static void sock_map_seq_put_elem(struct sock_map_seq_info *info)
+{
+	if (info->sk) {
+		sock_put(info->sk);
+		info->sk = NULL;
+	}
+}
+
 static void *sock_map_seq_start(struct seq_file *seq, loff_t *pos)
-	__acquires(rcu)
 {
 	struct sock_map_seq_info *info = seq->private;
 
 	if (*pos == 0)
 		++*pos;
 
-	/* pairs with sock_map_seq_stop */
-	rcu_read_lock();
 	return sock_map_seq_lookup_elem(info);
 }
 
 static void *sock_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
-	__must_hold(rcu)
 {
 	struct sock_map_seq_info *info = seq->private;
 
+	sock_map_seq_put_elem(info);
 	++*pos;
 	++info->index;
 
@@ -754,12 +763,12 @@ static void *sock_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 }
 
 static int sock_map_seq_show(struct seq_file *seq, void *v)
-	__must_hold(rcu)
 {
 	struct sock_map_seq_info *info = seq->private;
 	struct bpf_iter__sockmap ctx = {};
 	struct bpf_iter_meta meta;
 	struct bpf_prog *prog;
+	int ret;
 
 	meta.seq = seq;
 	prog = bpf_iter_get_info(&meta, !v);
@@ -773,17 +782,23 @@ static int sock_map_seq_show(struct seq_file *seq, void *v)
 		ctx.sk = info->sk;
 	}
 
-	return bpf_iter_run_prog(prog, &ctx);
+	if (ctx.sk)
+		lock_sock(ctx.sk);
+	ret = bpf_iter_run_prog(prog, &ctx);
+	if (ctx.sk)
+		release_sock(ctx.sk);
+
+	return ret;
 }
 
 static void sock_map_seq_stop(struct seq_file *seq, void *v)
-	__releases(rcu)
 {
+	struct sock_map_seq_info *info = seq->private;
+
 	if (!v)
 		(void)sock_map_seq_show(seq, NULL);
 
-	/* pairs with sock_map_seq_start */
-	rcu_read_unlock();
+	sock_map_seq_put_elem(info);
 }
 
 static const struct seq_operations sock_map_seq_ops = {
-- 
2.43.0


