Return-Path: <bpf+bounces-26618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0F78A2E61
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 14:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9361284D12
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 12:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD56A56753;
	Fri, 12 Apr 2024 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ka5gH5tD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DAB3F9D5;
	Fri, 12 Apr 2024 12:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712924792; cv=none; b=lrlVkeHm3oVJEYEWC7dofX5kGvWbAwtisnQl/kSGwKfMwOArd0nC8p/r9E/lDhRtDrtb9MkOWdCwesBd/j7jug5bJVFoZ/0SNt4eZmtl5bmOY2RVYvA/8AA6x27ZlkJ14TjQqchLTMoIzqOR3zaIYLlcoIddnATEcDq2Br7Ct0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712924792; c=relaxed/simple;
	bh=LluHyhjKemLvziSLq4mu73Bj2Ez4L1mtMOYpKAIdpW8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=mePL6wILh3YeOD39PH9tR5n4u2C7fg056cz240Qs7IIONJBZ4Bxz4BQAGpA+vm73/PmHTr1kPRZOzGLzK65FLEUUelUKyeeLsa6XKMx8QehY2sRTksFhoyAg0lnN7FvYCAr2dLmOVSLIO37u/FBAW3prZ/uI38nJC3+ipNU5E9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ka5gH5tD; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ecff85b21cso88431b3a.1;
        Fri, 12 Apr 2024 05:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712924790; x=1713529590; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJV6iNofzvP9/1KByDDXNTrF5EbVufMaGdHaNE1qGbU=;
        b=Ka5gH5tDrs8vTkH+U0jjIFPaD8xtJQ2qFcn/MqYeJHoFoXcuVwmdbdOOKbVm0Q598g
         WRH/o3+IBBFvmxupLUw63OTnEAGY3U84h8P9xaXIiTMl7nJdrkX0/2frXslxfEz9gHyl
         6JsmLcnYSpbpGx3n91mAfS0i5M3tDA1eT8siXjrRZo5Bo8nWLtO9e6+n6akxYY+JE2yT
         cxzMjrr2AEG01chc2hr+OsqvY2xIwpI8nkycNKwdfV2fonWlpxaftByQnbSJGkCfNxDr
         C26hXGhEV8GzyX30U00F3NmyOIYdJYRnhkq8S1375KqUrR6gjqpVfIeHLV1KXdc6aEr2
         mXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712924790; x=1713529590;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJV6iNofzvP9/1KByDDXNTrF5EbVufMaGdHaNE1qGbU=;
        b=InsoCPnS8zO7e0WgMmPiPJ5mtGzP3Do9XKGreSZn6njwGH8Vl1nwnL0cY9C+CCkcY8
         /1AB+ykVP3O5ftuTGBr1Azbd5KIGIGxvocS2WRBqhTSucFBEBz+zwjuOOCSkihMx//h0
         cBn/XLX71WRQ4m1QDhDaKBEx9amSF5kdKQQ9XxnDsjtOAEhY14BiDzYB+WSgjaqAzKKw
         rY2wlqmx1Er+g+BjcUKoWqLGTH7AsN2tPLJeepPWU9YNrBsKc4hSbhkqw46fDaRJJrzr
         dpXbyDlz0vu86qDx/KbJEQgDN2UV5w4lWAeoc5qO+gRfWpRUPk4YEuaN5SnIXTYbCZz7
         hWcw==
X-Forwarded-Encrypted: i=1; AJvYcCVp2yrdmKTk/+uLhAUK1i/xWOj7f/6qrH5Ajz6AnUY3u7UBjV7rqnHNF7h7xHmmapimr2pTL9RFvRD+iQhkCStLeUQ0
X-Gm-Message-State: AOJu0YyCUP7y6dyvyAzLclVJDyOqbwzKYMUZ9lfubvdUU60MBmzMx5Df
	pktFdcZvam/SW5UJaunU6T8550PdiNsfo0bvYX3A10VSemEz7qIIkc0i+6YdeZ8=
X-Google-Smtp-Source: AGHT+IGZHHvRCgK27soLLdHJCNMYJTCQVRGU/ljmn6V9QITXfATdyIL2zTmz2wVBYGPm5SebJ1Hg+g==
X-Received: by 2002:a05:6a21:99a0:b0:1a7:a3cb:7909 with SMTP id ve32-20020a056a2199a000b001a7a3cb7909mr3027724pzb.3.1712924789977;
        Fri, 12 Apr 2024 05:26:29 -0700 (PDT)
Received: from localhost.localdomain ([111.194.45.84])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902704500b001e3c972c83bsm2865885plt.76.2024.04.12.05.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 05:26:29 -0700 (PDT)
From: Zheng Li <lizheng043@gmail.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	jmorris@namei.org
Cc: James.Z.Li@Dell.com
Subject: [PATCH] neighbour: guarantee the localhost connections be established successfully even the ARP table is full
Date: Fri, 12 Apr 2024 20:25:38 +0800
Message-Id: <20240412122538.51-1-lizheng043@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

From: Zheng Li <James.Z.Li@Dell.com>

Inter-process communication on localhost should be established successfully even the ARP table is full,
many processes on server machine use the localhost to communicate such as command-line interface (CLI),
servers hope all CLI commands can be executed successfully even the arp table is full.
Right now CLI commands got timeout when the arp table is full.
Set the parameter of exempt_from_gc to be true for LOOPBACK net device to
keep localhost neigh in arp table, not removed by gc.

the steps of reproduced:
server with "gc_thresh3 = 1024" setting, ping server from more than 1024 IPv4 addresses,
run "ssh localhost" on console interface, then the command will get timeout.

Signed-off-by: Zheng Li <James.Z.Li@Dell.com>
---
 net/core/neighbour.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 552719c3bbc3..d96dee3d4af6 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -734,7 +734,10 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 struct neighbour *__neigh_create(struct neigh_table *tbl, const void *pkey,
 				 struct net_device *dev, bool want_ref)
 {
-	return ___neigh_create(tbl, pkey, dev, 0, false, want_ref);
+	if (dev->flags & IFF_LOOPBACK)
+		return ___neigh_create(tbl, pkey, dev, 0, true, want_ref);
+	else
+		return ___neigh_create(tbl, pkey, dev, 0, false, want_ref);
 }
 EXPORT_SYMBOL(__neigh_create);
 
-- 
2.17.1


