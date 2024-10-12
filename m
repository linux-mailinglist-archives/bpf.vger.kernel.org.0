Return-Path: <bpf+bounces-41818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6575899B6FC
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 22:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1E6282A65
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 20:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EB119993B;
	Sat, 12 Oct 2024 20:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QYxo3lYT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF31946B
	for <bpf@vger.kernel.org>; Sat, 12 Oct 2024 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728765477; cv=none; b=Yp8qlyYGF9cclC1GPZfkom9VjB/rlj5VA3mj2UTHvqG6SYjJBVvC9bXdK6Q0V+34nU3/6HqyPlv4H7LMreaL3Ld8TXtfIjfeEF/FFFYD2rSuD01vFW1PPgux62x4Wy0Zf1ACyOWcFEwH4Buy3b1AK7ht6HuPqwiNhZw49gCPl9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728765477; c=relaxed/simple;
	bh=whTn9JP+II8s96FeJ4j3YEAli5FxFgZjWnSwTMdetyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pEflhrsvxQF3PCqK2HOz1eppZVrdwMcHHpu/eeqKB4Va+S51aZt1AkHP7lJYX9EMNyGv5+d4g6RcrfSOf19CQNy7arAuldaaJn/vDJX9W1UwW+8B9/6hZ8YM3dwkkyEqvlNfGBS61z26+FHOkVNGIP1u/5MXGZ9uF8PqgnSq2S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QYxo3lYT; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-460634ac984so562651cf.3
        for <bpf@vger.kernel.org>; Sat, 12 Oct 2024 13:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728765475; x=1729370275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgD3BSUNLY/utgp4Qr4bf/PgpzJfjrcPun3+s2/kyDk=;
        b=QYxo3lYTuPvFl1EUXWhQAIc6L6siMNrncP2iZXIpTD3v5S1SvqyaeHkGrkBBOhBe98
         138JHS/M2pv//AAvgtUIPPpHWc79l9T2U9mT4444+nQ+fCvgXg4cCXEO5nSgNtMqYz8d
         krOFaj26eHe1SihpytH8G/MHsKCVWBfUIeY/eL+HkHmon/THlBV9ZI7V88U43+1Xrc7q
         qszipP+D2k3pbVzqgXcwj3sJ0VyOQoco826IiN10jttT6bQQ1gVU+nW24g0DlVlnbxUA
         OKyZQRA1AYJnVMFVbBQZ4YCzPMBtiFgtLVQWys+Zy0VeBeIWRQFsbvmWpQ51SyHiYHK1
         m0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728765475; x=1729370275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgD3BSUNLY/utgp4Qr4bf/PgpzJfjrcPun3+s2/kyDk=;
        b=nItxZwcIZ6znR5kQa96IN7gtMv6mHzXA3beJcq6a8RM+8dMvGqwUawgs3TUuogI5VD
         M8zlIw/+hFKbAumnDI+BqqiIQtj5BEKCdyDT3QIvgZPQseVR0CMGxl1/Ck4DhVeK/pIg
         mUxiFSVtAyLxFmWGs0TXsEdbb1atAIwP0yGA8qiMeTmiGgDTS8sbG/es7kKzKiZ7R1rg
         3AeM0ZhjxyTy97J4XkFRfukGEwbpRExyn2UZMKuprGR+Oi/DtZFGuE35bX/vDa1HsrXZ
         V3RCdm5L+ageUFTDBdsMeOEHmqfebBZ9kpo/N77jjJbucSDV6ou3naKx0I9SQb4cQDGZ
         KVTw==
X-Gm-Message-State: AOJu0YzlBw8sgNR8EEowOVw7k8an5dqeGzfJkaSd4U+ww0LDPPuoBU87
	McldNnCunwzTtegiBbCyAG15jWbshZ1tjjesXtfvpwR47N4clwxCWnpaO9hM+sysbtTXugKsF/1
	b
X-Google-Smtp-Source: AGHT+IGwj447Ij/+7mifxeEV7EJTtK50D8hwgNBvJgD/143pyGQ9t3XRArVyzPjRyrMXVb/TXBvTww==
X-Received: by 2002:a05:622a:428b:b0:45e:fe4b:de1b with SMTP id d75a77b69052e-4604bbb85e4mr120711531cf.13.1728765475063;
        Sat, 12 Oct 2024 13:37:55 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.101])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460427895fdsm27803371cf.16.2024.10.12.13.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 13:37:54 -0700 (PDT)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
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
	mykolal@fb.com,
	shuah@kernel.org,
	bhole_prashant_q7@lab.ntt.co.jp,
	jakub@cloudflare.com,
	xiyou.wangcong@gmail.com,
	zijianzhang@bytedance.com
Subject: [PATCH bpf 2/2] selftests/bpf: Fix txmsg_redir of test_txmsg_pull in test_sockmap
Date: Sat, 12 Oct 2024 20:37:31 +0000
Message-Id: <20241012203731.1248619-3-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241012203731.1248619-1-zijianzhang@bytedance.com>
References: <20241012203731.1248619-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

txmsg_redir in "Test pull + redirect" case of test_txmsg_pull should be
1 instead of 0.

Fixes: 328aa08a081b ("bpf: Selftests, break down test_sockmap into subtests")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 8249f3c1fbd6..075c93ed143e 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -1606,7 +1606,7 @@ static void test_txmsg_pull(int cgrp, struct sockmap_options *opt)
 	test_send_large(opt, cgrp);
 
 	/* Test pull + redirect */
-	txmsg_redir = 0;
+	txmsg_redir = 1;
 	txmsg_start = 1;
 	txmsg_end = 2;
 	test_send(opt, cgrp);
-- 
2.20.1


