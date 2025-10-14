Return-Path: <bpf+bounces-70896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAA1BD904B
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 13:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA16A3ACBB9
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 11:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2FF30F944;
	Tue, 14 Oct 2025 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/uM4FQO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D7F310630
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441232; cv=none; b=GOecU0exCpx2ivjYwcrMC6e9U7dOWh6ZpBCWdhrxYlj/RSGjtKazFeqaFPSd1JWHRGgUjMOimzqMznzdlJT9olpN0ZvuimomTSkDdBvT0kI+CghFqo30gk9K2KZP9HtLOCpd7KwCfnSIWt8w5SGVye9670Qjr8kjDt3gIvOQhXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441232; c=relaxed/simple;
	bh=LpUckPTb7jH/83BNuJSOxN+YPu0vw1zspxIFiooWH8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cea6QhhxA4MgwdyLF5xr1Hr3yhjhamyvP7+Fjdu6bcTaXL97yDKXYdKTnnrKnf1jvvq+Gg4WUFce04T+hpMM3tjbWhfhbgHTXq1HzKdC4+P1Caw2IEZyidcaCutgQOOFzetYkraMp0MwCvHnGQ+9xMsSg7eNqcEUdJPe7J2cFxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/uM4FQO; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-26e68904f0eso53565745ad.0
        for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 04:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760441230; x=1761046030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hixVqDtG5kfwkDmbrI9+bLiGthHT6YGDBRV0eBz8fPk=;
        b=J/uM4FQOeU2neSw6b2Q3CXLQX41mnJa4xiREIUXU/k5ttB6Ai89oCC3oJO/zi0i4Em
         smD+9BI6AdsTdwtFbhYrqYUHdSxdu9dcNP/wQ81Q4ZN95YKF/kny8Pp3UJclJf57e+aD
         b7TYSrlIeHMzacKNdtSqkGLP2CpEOFMsLkedE6a+J0ft8tZrS9or9RTRHDoW2oaXIsu8
         2094ih3A3111ggguyWvHMGbKpekHw1efANGxwJKdFHhUrP3tu83hZO1WTPFMC8UjtYRo
         oYbfT7V9oBMni/HJZNScjSnxxfiTEAO5EJjhxCc9yM4nub+CBCDZxF5kvaAGqfkNrVxV
         6dRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441230; x=1761046030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hixVqDtG5kfwkDmbrI9+bLiGthHT6YGDBRV0eBz8fPk=;
        b=Kk0hW+sDRD4GnXtByQHY0myIvu+dTyM68Ry+/LrQq8osHFOa7tKgV6+hTSq5TRl62x
         EpXpXtgcpGmvzhdwhYIY32wJBdSqt+8bq25fMcHIxvoMNGhGzj/txi5EPoJQe9zLqoQz
         h6wclL8+tKampKQ7VqanTvW5qL5rKpsseqWOEwlUtUjiiB+NoApmFZlj3Z+1uN+udBuU
         BqCEWeD/nyAZHR1Z8mt1RvTHKyHRP312aikqZ1sZ8LZAy+/2cySd34+zl0UIo7BwT+qJ
         b/0z5xx5503lzJeN5CJQGsoDBZAhsJbvq/5pjKSOkfm/nAQ6TdPybu1Pcydm0co9TGCB
         TPJg==
X-Forwarded-Encrypted: i=1; AJvYcCWIVwxsiFDwDHF+yS+RvOyfwGa4FMJbx01Hgxr3qEWRpzq6yLiXIZIZoXEiwPA7qg1IjlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrCZoly2fBj9YII5046rTP9WyfzILABzDyK+0azD9uJf8dVvnC
	aKk3mifajX+FM0ZvANew2nwW3zCoxxOqPoJ2pd8WuazzVQL/n2xMbV64
X-Gm-Gg: ASbGncvkdq7lpf1xvVE0ON/qx1b7ALRVa81SkcwBnnGfAngmzG6oAqJK2Pau/FGHrFe
	nd2DPLuNpepJw3FXJL1MR8pwZlU6x0x08WPpv9fKTMEXgrnWRhQ2Et0OrbIcl0AsnyCJxz+DSZm
	0wC77eWGJ13xn70fZYlSp0bFY3ymssywf3lzGYkxHw2o7XwKJLS+4srWnDUGRBVlLedI/fTO/Of
	JtfZEpug0OV5sFBjWCSdZsKHn+frKTesdrO/PK4prvUlOckYDHRDnTNZKVqQcCGr9toy50py0SN
	iwexmX1Jbz2Tm7n3hgrJTIe27aca+oMYvLtb5kKxHsT6H10ENxht6h8XQ7zph//RPI5yPFX588Y
	mZ0LgB48dhNQgw7hcgX6rMQ8nrM8ZniM7SAIpGsWo2Q==
X-Google-Smtp-Source: AGHT+IGSGyLntq28lnbnZr4P0EjlrHeHsCeSBY4tltUAlQ5AUSXAYfEcRW/aomPwYfhGFSurWqTmGA==
X-Received: by 2002:a17:902:ef06:b0:24c:ed95:2725 with SMTP id d9443c01a7336-290272135camr265404925ad.4.1760441229532;
        Tue, 14 Oct 2025 04:27:09 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e2062fsm161807285ad.48.2025.10.14.04.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:27:09 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	paulmck@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	jakub@cloudflare.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 3/4] bpf: use bpf_prog_run_pin_on_cpu_rcu() in skmsg.c
Date: Tue, 14 Oct 2025 19:26:39 +0800
Message-ID: <20251014112640.261770-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014112640.261770-1-dongml2@chinatelecom.cn>
References: <20251014112640.261770-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace bpf_prog_run_pin_on_cpu() with bpf_prog_run_pin_on_cpu_rcu() in
following functions to obtain better performance:

  sk_psock_msg_verdict
  sk_psock_tls_strp_read
  sk_psock_strp_read
  sk_psock_strp_parse
  sk_psock_verdict_recv

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 net/core/skmsg.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 2ac7731e1e0a..1d3f47b07659 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -908,7 +908,7 @@ int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
 
 	sk_msg_compute_data_pointers(msg);
 	msg->sk = sk;
-	ret = bpf_prog_run_pin_on_cpu(prog, msg);
+	ret = bpf_prog_run_pin_on_cpu_rcu(prog, msg);
 	ret = sk_psock_map_verd(ret, msg->sk_redir);
 	psock->apply_bytes = msg->apply_bytes;
 	if (ret == __SK_REDIRECT) {
@@ -993,7 +993,7 @@ int sk_psock_tls_strp_read(struct sk_psock *psock, struct sk_buff *skb)
 		skb->sk = psock->sk;
 		skb_dst_drop(skb);
 		skb_bpf_redirect_clear(skb);
-		ret = bpf_prog_run_pin_on_cpu(prog, skb);
+		ret = bpf_prog_run_pin_on_cpu_rcu(prog, skb);
 		ret = sk_psock_map_verd(ret, skb_bpf_redirect_fetch(skb));
 		skb->sk = NULL;
 	}
@@ -1101,7 +1101,7 @@ static void sk_psock_strp_read(struct strparser *strp, struct sk_buff *skb)
 		skb->sk = sk;
 		skb_dst_drop(skb);
 		skb_bpf_redirect_clear(skb);
-		ret = bpf_prog_run_pin_on_cpu(prog, skb);
+		ret = bpf_prog_run_pin_on_cpu_rcu(prog, skb);
 		skb_bpf_set_strparser(skb);
 		ret = sk_psock_map_verd(ret, skb_bpf_redirect_fetch(skb));
 		skb->sk = NULL;
@@ -1126,7 +1126,7 @@ static int sk_psock_strp_parse(struct strparser *strp, struct sk_buff *skb)
 	prog = READ_ONCE(psock->progs.stream_parser);
 	if (likely(prog)) {
 		skb->sk = psock->sk;
-		ret = bpf_prog_run_pin_on_cpu(prog, skb);
+		ret = bpf_prog_run_pin_on_cpu_rcu(prog, skb);
 		skb->sk = NULL;
 	}
 	rcu_read_unlock();
@@ -1230,7 +1230,7 @@ static int sk_psock_verdict_recv(struct sock *sk, struct sk_buff *skb)
 	if (likely(prog)) {
 		skb_dst_drop(skb);
 		skb_bpf_redirect_clear(skb);
-		ret = bpf_prog_run_pin_on_cpu(prog, skb);
+		ret = bpf_prog_run_pin_on_cpu_rcu(prog, skb);
 		ret = sk_psock_map_verd(ret, skb_bpf_redirect_fetch(skb));
 	}
 	ret = sk_psock_verdict_apply(psock, skb, ret);
-- 
2.51.0


