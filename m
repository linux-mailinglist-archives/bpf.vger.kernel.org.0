Return-Path: <bpf+bounces-46241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 916519E6540
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 05:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2649281EE3
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 04:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C70194AEB;
	Fri,  6 Dec 2024 04:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTXn0Nv/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59264194158
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 04:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733457810; cv=none; b=EyQv2sJ3/uwdwK8KIs0sew6cea9iuUCYhdjW4yYW9z1YH5SHpt72ennGG+tHwI9KdRnfRDerSz3oRTHnkFGCLg2t8hAGCWf5ggVi9ywR5lg6b+xLmgE0XVauBNNkdMXflG7e9aKt0HUkA5OALy6nOAmQH941lYOgyraMqUgMcSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733457810; c=relaxed/simple;
	bh=lW4mQ58JGfw7JGH8bL/drjsNfSgfvzBEqWD7FVkfokg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0XBmWN1naoB3GyRKhdwh7V8AEgvHaWbU1vd+1Ebt++xqC8LQuHFQsD0LYtUEz7e5ZtIQrgeo5mcfYLaExT/gp6bugKKVPnmOW+TUq83j5et3K99Q1qGGDGyMA5U5HVqHxWBSOsMlVq6YSZpAvA6PIPEFtktLSZZLSsQUOVuTNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTXn0Nv/; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725b93a59feso307244b3a.2
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 20:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733457808; x=1734062608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VTXn9EJbSSdNCqgtyoG6wj3OIgIOOdlJuFJ/UTprec=;
        b=PTXn0Nv/cu8G1TC73omlZTna4JpaUirZLxjLhavY2O7iiuZNEAqwM1Kioxwa7riPs4
         SW1x1dXYyVw05lg5opoVhKVmbGkp5H+H9krDWaXODt7INev885vixrCp4QNZO6Mcrnq3
         CGGynNlRdXeYayw9Z2MBKoomvyG9AxD/BeZxfi7IfM7tKtNd+d/I5BsuEBGiaHtZWPR/
         Ae/anKe1LrBYNWdFXXOOj5YroF1D4O/R8bnMAdyhGr67ibiYLDWsXKa4d4WRteTLEfz+
         P3BQ/FO9RidTS97Sk0FBHPJa2aslETlvYEiIXEDcYLQrPEMqyflcScvepUfd+rrAA3ns
         sZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733457808; x=1734062608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VTXn9EJbSSdNCqgtyoG6wj3OIgIOOdlJuFJ/UTprec=;
        b=H3UuJnRoM4yVgEC8oz5AgYKv9cwKmtt8nW7g947bCpCj839tEaMdbQ+UXdWV4jitfZ
         WJ6p/aONqfev2QdpAv6LHD4tpQDmxqC6MUZLAxUECIMwWbG2sDqRnPMO5X004Ck3buwz
         g/4x0XXw7r2bV4VD3tf3Prh9lhC0Ld3AfZIMOwi0WOX8x250TCcYgcvTE84nnpGJVIjq
         UlN6Gu5pnKU1WxTZVzXvD8X/9NCVdTOSBkjrdrhaFF47lccEz2bxnQ8uA7M7nNH89bpS
         lfNEed4rGLDQYsDF5v+ZWx/nmb9VOoIf4IlqnVRkMUaK4Yhu70t0ZuH9jn6HIsogBsuZ
         P6NQ==
X-Gm-Message-State: AOJu0YzPIMTEdQwIGs7Kuc5UgzKXLSYp19E7yF2sWQUMWYywXJWvPakc
	RL5fgfjPEpzrZSEgGXcCtZDmVS5JjXdH7HfOc02tmNcwfIM2t3C8n6iFIg==
X-Gm-Gg: ASbGncuDL5v1lAOA3m6UAFTtOYr9cWxpREZo22d0a6bp8clxemCwYYUI0/6jdsZJaMK
	qpN0og8wMpaRPBYoR/C/f4GLNycBdODIKNPW4z9yKluNHMmjxGY5xq4QFVm7s/Er9Z+K/4AUf1T
	q0/zu7Dv8k25UyefpJgJz/xYyQlhUpUo1WN5H7bSd6rtNnRAueoLZo2QPZqdCrtPRcp71r5rl1c
	kWDx0dytQg9Fr/ifNPYrIJ8nsXuhmYQCWjaC0OMeNof2w==
X-Google-Smtp-Source: AGHT+IEZuyqETvKywL0wrGsW6tHpMr+J3LuRJXV9wb/hOlVDhJgJutOO2JUFNC9XnDQ0qVaFRgr/Qw==
X-Received: by 2002:a17:90b:2803:b0:2ee:c9b6:4c42 with SMTP id 98e67ed59e1d1-2ef69e167fdmr2907136a91.16.1733457808359;
        Thu, 05 Dec 2024 20:03:28 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef26ff97ffsm4101846a91.10.2024.12.05.20.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 20:03:27 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	mejedi@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf 4/4] selftests/bpf: test for changing packet data from global functions
Date: Thu,  5 Dec 2024 20:03:07 -0800
Message-ID: <20241206040307.568065-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206040307.568065-1-eddyz87@gmail.com>
References: <20241206040307.568065-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check if verifier is aware of packet pointers invalidation done in
global functions. Based on a test shared by Nick Zavaritsky in [0].

[0] https://lore.kernel.org/bpf/0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com/

Suggested-by: Nick Zavaritsky <mejedi@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_sock.c       | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index d3e70e38e442..51826379a1aa 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -1037,4 +1037,32 @@ __naked void sock_create_read_src_port(void)
 	: __clobber_all);
 }
 
+__noinline
+long skb_pull_data2(struct __sk_buff *sk, __u32 len)
+{
+	return bpf_skb_pull_data(sk, len);
+}
+
+__noinline
+long skb_pull_data1(struct __sk_buff *sk, __u32 len)
+{
+	return skb_pull_data2(sk, len);
+}
+
+/* global function calls bpf_skb_pull_data(), which invalidates packet
+ * pointers established before global function call.
+ */
+SEC("tc")
+__failure __msg("invalid mem access")
+int invalidate_pkt_pointers_from_global_func(struct __sk_buff *sk)
+{
+	int *p = (void *)(long)sk->data;
+
+	if ((void *)(p + 1) > (void *)(long)sk->data_end)
+		return TCX_DROP;
+	skb_pull_data1(sk, 0);
+	*p = 42; /* this is unsafe */
+	return TCX_PASS;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.0


