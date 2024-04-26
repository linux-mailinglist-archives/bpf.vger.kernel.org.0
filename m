Return-Path: <bpf+bounces-27931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FE08B3B3C
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 17:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EF00289139
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 15:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CB6168B06;
	Fri, 26 Apr 2024 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiLP9smO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49781607A2;
	Fri, 26 Apr 2024 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144820; cv=none; b=LrYGsUO7QSE58JUauuudCovqPZAeRr4D+fqnG+wNNXdsYbSyKwCb+LyPD5tnPRZEoocrcBHwafFmIHgx+UZsFrPAnDXHfbdejVXw1/Uoqe6p8YccZxuI2Fc/wYtuihgrefp0ltVLm3xAtM+qHpqlgO9vefg5JxqGculibMbfDGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144820; c=relaxed/simple;
	bh=3zKkRul2jH0sxWqgWVvdE95FmZ1KCe46FuAYXSNuAiY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UqzRJyrcWUlrXy+A7AzaDhzqylJZ1kfWdXgjcKViLVW9/PohRd0ClO7vZwYdQ5JfQQrp0exWdddNh+IY802/J76J3RkYA5kZe3SP5UV2d+bXzvAUSt7UkfgCDiswv/8i7ZIflGQT9fGkAkBxGbTm3KSJfHAEQsH48UmxlrUMUO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiLP9smO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ead2c5f3f0so1208555ad.0;
        Fri, 26 Apr 2024 08:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714144817; x=1714749617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XMvpIE0JgEXfII1JTyN/doxgX7dq3PBBUDHJsZLp1kI=;
        b=EiLP9smOrgB20A8sJuj8a8+8SOEhKxLlYVuRC3hKmmyp/gvlo+Cl0tNS+bnUIgogRJ
         iCHAv05pKZbVN4nr7Th75pNeNJmVtZFWUe8eZdS/Hk+fsy1isMQIHubKW4O5NlfI5B6N
         TVGg9lWv3NOXyy13WqdefkQ40Ytpo2zQCxhSGWJ2OPWcv3sFOhonEWjWVLBtpCx/V1/M
         X9eLSM6tNcdut1gwXOvu9LlpS73Qprm9yJRg3EE9Ky03r5hNa3DyToFq4Ls5HVkqvTQF
         COeDrltq25jqZmyU4bHdtOHG6mCcpUDtNst+EDqf0gJzw1WYXsp0JxHGKrQVilQbN1Sr
         nNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714144817; x=1714749617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMvpIE0JgEXfII1JTyN/doxgX7dq3PBBUDHJsZLp1kI=;
        b=Qz9i2DZ59XnAj8nIvQAkfTij+LlGaxq4vuLpuixAz/YMdDwaKvLPl8Y4GHA0dGvz0L
         EizCRkdJ5IL2JYZWm1gSmhdljBz1gYFs3CVxclMVmL6qJa+aBEZZdzruO1YM5fhG+KfL
         POgdQKbAhkNhs+JNctaVDFARTIcObGNDC3hQjAiRiUjQeVhaLKc9FMHGvw2WsF6RiCk2
         XqdLfwxWKUH46u4bUOsKY4xDp+zy6n4rvFRczDISacOS7mRo3olNhX6IkvBfR+UAdFqc
         +k2zfhgS+7Hj9tQ2X9Ay8OITlMlMc9zJ4kA6pOTPJx7ICO0BtqqGYq8thREJWFNwU7ZN
         BLvg==
X-Forwarded-Encrypted: i=1; AJvYcCV7KmILSlFtGYGmOOPDcWxHnCdINQHXguNTYAZLgRo2A/m3tUK8Hae/VfhC2UO9/BrfeAONZr5sfjby7Us9JhDj/sIPWP3uAqqphdiF7EL6AomRMe4ahiC8a8I5+ECu91nCCaU3hq69774maENh0WoBodcOz3Mje9D+
X-Gm-Message-State: AOJu0YwFLBcQZ3cC8mr3Cr9l6fioeC0RQzcCwhDIwz0veYgIQ5lWZTaU
	pCao4C5tb0hE4rC6kO8vAoQxRDEYy4zp0o2XJ/5kiIm1+GsIoS02
X-Google-Smtp-Source: AGHT+IHFGwMiipoYwzG3pLc3fH7d6bQSZ9zupsh+7LPrphNdqdBqvamdhDNXbAXX96e8tzxgLyrWqQ==
X-Received: by 2002:a17:902:e747:b0:1e4:397b:492c with SMTP id p7-20020a170902e74700b001e4397b492cmr3232528plf.4.1714144816828;
        Fri, 26 Apr 2024 08:20:16 -0700 (PDT)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:751f:9418:61f4:229e])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902e88600b001e4ea358407sm15575142plg.46.2024.04.26.08.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:20:16 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: edumazet@google.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] tcp_bbr: replace lambda expression with bitwise operation for bit flip
Date: Fri, 26 Apr 2024 23:20:11 +0800
Message-Id: <20240426152011.37069-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the origin implementation in function bbr_update_ack_aggregation(),
we utilize a lambda expression to flip the bit value of
bbr->extra_acked_win_idx. Since the data type of
bbr->extra_acked_win_idx is simply a single bit, we are actually trying
to perform a bit flip operation, under the fact we can simply perform a
bitwise not operation on bbr->extra_acked_win_idx.

This way we can elimate the need of possible branches which generate by
the lambda function, they could result in branch misses sometimes.
Perform a bitwise not operation is more straightforward and wouldn't
generate branches.

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 net/ipv4/tcp_bbr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
index 146792cd2..75068ba25 100644
--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -829,8 +829,7 @@ static void bbr_update_ack_aggregation(struct sock *sk,
 						bbr->extra_acked_win_rtts + 1);
 		if (bbr->extra_acked_win_rtts >= bbr_extra_acked_win_rtts) {
 			bbr->extra_acked_win_rtts = 0;
-			bbr->extra_acked_win_idx = bbr->extra_acked_win_idx ?
-						   0 : 1;
+			bbr->extra_acked_win_idx = ~(bbr->extra_acked_win_idx);
 			bbr->extra_acked[bbr->extra_acked_win_idx] = 0;
 		}
 	}
-- 
2.34.1


