Return-Path: <bpf+bounces-67916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 534D8B503DA
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 19:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330A14E335B
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 17:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0CB393DC7;
	Tue,  9 Sep 2025 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="xzeheDro"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF649371E8E
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437238; cv=none; b=XAuQvmpFa9T7UUrMvev3gsXScAThojTPsE5T9aSoQWfXcEnCSITL7HffrLjwkyZzEz91DhuRozAMup865TMFJyYWsSe0fk/AdSdSlD5ypDERxZE8sfoviNHLRDxoSSbZbh/U0iUW1lignZA1q0TewVFwdZrQUNEuzBrTCSofVTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437238; c=relaxed/simple;
	bh=Dm1aTBZc9HI/GtyriEUjTFt9Gu8JrX3TSGIuhtnEeco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3t1ru/ZUcnb0yIlfqKwMPN+tDiuE1hIXrpiNY5ZDp15oQELMBxUg/lbsHsi7kMNmvfkjqg/h/669jSrQQJwQ4rDSHQIARNdI3AzpaFuLkReunkiYP6zbNhntnW6j3sucYEMNDJp6/8ONBDzjRFUgj0Sx9ZmU5bkN0dLHdJcNeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=xzeheDro; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4f8050e031so251510a12.0
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 10:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1757437236; x=1758042036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qZqsCHPlx4pn/0GrFvLfmlL0eYEuMqWlGHh8qMhlyM=;
        b=xzeheDroXE+j0DVlv6muy7ZlMDXP69PMdKh4V7VraNeFMXwsAzXakUjQghjXaql7qd
         Nz99HGjFq406Rs3I4OOqwnpystbym6x+tANf2a0Dkp7aG+LxqVdV8oy9IGvuasufakgL
         JbjP6cDF3+BA9zZVQivI/CSRM4UDyTCIvsJ40Urw5KFbyPEbTrM/7KdjK4oNeKElLoeT
         gwa7/E85W8sdAlF7gXlIsEyTHVdtEKFun63r5j/YSdC9SlNCs6ITs5mDuNgEm4xUG8KT
         HM7FN5jHh/HggcDyqnVmAEDJYx5R5sZE/fiKN+338OKwjxI3AlmyZct0i2kJ1GEVLcjb
         HRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437236; x=1758042036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qZqsCHPlx4pn/0GrFvLfmlL0eYEuMqWlGHh8qMhlyM=;
        b=g5o1E21feplRANrvPqpDvx4d3ppi9/LhgU9E04Jz8sBpVgk99WyZIEfjbrW1t037lw
         +zIoIw5oBmIXBli/cO6q7jXgpSAnCWxUxrwO9H/FFJ62ObpIGH4zPzyTgwL9ZdNoQ+Lf
         Hnw3fuixWeOgVcAMOTQZ7rXtKfhth8xSnODEhODZFFDS8xVKXZyQEgwMfK3aD13ErC2D
         jqQS8liwT8a5uVD9MuDjPVdt2JpyMcT5zyERHqxaIMKGYsYSEWemIY9wlkiV0u/eRCg3
         eC5GEYk7G/OFvO2A13DmOQiv2ZgJ83da2FhzSOmiGHonm/jRMDywpB7NfeObtwfoPYpJ
         DRQQ==
X-Gm-Message-State: AOJu0YzKdE19ZY6BopgG+EN8fEcs3aOHrQVDZv05bJkkNvR77Y9zXiDi
	ifr2szc1Z3hrCNpBA4zMERVtewl2yA8Kg7I2TqEV6a9uOzfSZMDyNUvVq4t4XDMAtZJAsszRERe
	3EWLy
X-Gm-Gg: ASbGncs5+OgOu40wwDpIRG2U7apEs9d5ywLtwWQ39LUz9NjKSLMQSoOOkbr57iMe9z+
	AlkAtSET4jJ4m4ELV5rZ6iIYD/xup+A4fGci+cZ46FHrD1heR5PMPh7BggANc61elVV/mjsTLhr
	6Pb6aAtsOVU1FoBqB2oPynzjtL1+siOY9uVySroQgMd8xXIZEUo2SC4W0s3p46688u4yorwlqiT
	YVVRWZ2uYZbUqZEOA69EuytVMxSqnLaZqYiK02+fYBidJLFpFAlayv9tp1Etq4D+Ra82oxux5rt
	6is3Di+cDenq5+Vbb5M7qR/wUSiaNk+6GVzLpKWj/hqot+iAD7U8FEThcFJMq/jgUH10wlJWfkj
	X5SdJxS7Ga4yV6H/Kg0wDFwuX
X-Google-Smtp-Source: AGHT+IGLqeGuYLqLnjSvXyqUuF3AaMwm/fPoVzI1a73i1YdUXy7AmvgtZs0o4oRpbNNTF6IcxdlpWQ==
X-Received: by 2002:a17:90b:38d0:b0:32b:6d04:e78d with SMTP id 98e67ed59e1d1-32d43fc8366mr9203963a91.6.1757437235542;
        Tue, 09 Sep 2025 10:00:35 -0700 (PDT)
Received: from t14.. ([104.133.198.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6a814esm251733a12.29.2025.09.09.10.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:00:35 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 08/14] selftests/bpf: Fix off by one error in remove_all_established
Date: Tue,  9 Sep 2025 10:00:02 -0700
Message-ID: <20250909170011.239356-9-jordan@jrife.io>
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

This test is meant to destroy all sockets left in the current bucket,
but currently destroys all sockets except the last one. This worked for
the normal TCP socket iterator tests, since the last socket was removed
from the bucket anyway when its counterpart was destroyed. However, with
socket hash iterators this doesn't work, since the last socket stays in
the bucket until it's closed or destroyed explicitly. Fix this before
the next patch which adds test coverage for socket hash iterators.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index 27781df8f2fb..e6fc4fd994f9 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -463,7 +463,7 @@ static void remove_all_established(int family, int sock_type, const char *addr,
 	for (i = 0; i < established_socks_len - 1; i++) {
 		close_idx[i] = get_nth_socket(established_socks,
 					      established_socks_len, link,
-					      listen_socks_len + i);
+					      listen_socks_len + i + 1);
 		if (!ASSERT_GE(close_idx[i], 0, "close_idx"))
 			return;
 	}
-- 
2.43.0


