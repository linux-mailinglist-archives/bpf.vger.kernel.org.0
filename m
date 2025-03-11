Return-Path: <bpf+bounces-53794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24246A5BB4E
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 09:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56483171A22
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 08:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B4C230BF5;
	Tue, 11 Mar 2025 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIKA9Wvn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B745E22FE15;
	Tue, 11 Mar 2025 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683403; cv=none; b=IrH+WOM76x/jI7tVotrVvVArUCI6C82cwhajJ/gQrmmmqbKPim41xooHGhUD6r92BZLf0ML9dc/p52+dCJQlwxvGBtf94yvjIvnTwfDkxHUFwfNYjFTvcwfYP1/wcXRhaWUN1tnJ2oQAz9GG9psOdWKReUhUyUeupuJL9N8Asb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683403; c=relaxed/simple;
	bh=oe9IFBRxTC4K7Yl2I4dZTUYiD8zJwqLA9l5IMudw9R0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IGihR5e7/B7urqc9q52upN7k0GwajX0Xn15ZgSu1UEKIoquc3VClUW3P1l6JoHvmJ3xw5Vh5Bukfo9g5ko5vmGVYSub2CmSlPRSLE+JZ+573RAS9dSeBB4dv/B47OCSxDewdHnV+aRwP/b7EPjIur5v+GDL8U9zX8fP8wNMnvrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIKA9Wvn; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so1439824a12.0;
        Tue, 11 Mar 2025 01:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741683400; x=1742288200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbB+H6DnjKDKEGPGTN5Kwbnu/2fQ4gt3M/BOm0GQpoY=;
        b=QIKA9Wvn6RnMP/lS4AjhzMAU6fCZMqBqBX4rHlFIhVG3QqmPLpqz7E/VxVHc4nT+pQ
         qv+TIMMUX41TpwM91BAUNIF5ugqeUqLh31mtWwrTG/dwejFglnoLrGoTnh1vLpP+Ldsm
         ib2hUvd2zBFMpRPCF9zB3EDxjfWjglv/iHZRawRU4pQ/Nw9C1Iq/0aZRTgZUmCc+q1Gc
         pYpIn241AZFjD7DhC+VQwbKjCukY00Td46+rfWd8TPbH50XdMi5tJeqI3n/DEaPY0pbt
         QuOBtQhG0zMA7jlKLP20XYMX2OBqTW5FN8hNPGk0r3wtno+LVKCe/8pAxoRBmfxabeE3
         Rnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741683400; x=1742288200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbB+H6DnjKDKEGPGTN5Kwbnu/2fQ4gt3M/BOm0GQpoY=;
        b=TeGC64KvKVAA9vEHROplT5hptJYOlrUPyQw0udIMpPYmazezg6u5D9AXxukFraKaN8
         4snF+oB1Eu+3G/zmIbHsu97GWYzVS1S2rZngiEMUVeQcODMjWqWleQIhvbcsz/TRSfqX
         ZTyDoStnZEqt7Ony8dI3CoLBDkVR+uiL25uaGvopVZpLfeavDI4mxG/f722Q5od3Ox+/
         kc+5ECPY9qjNxlhM+YRbwfHrIOcS5keQjRuescritpctKHFJ0Ne2Rjr/2ERorTGaF3r1
         cCFlTpmst8JA9uOjtdBxiaLTAQTMpBcWgO+0RmxWc8FieB09TKQ75iQF623/aWKUX9vX
         pB3g==
X-Forwarded-Encrypted: i=1; AJvYcCVkLRLpxUYgqO1dLl6iCfVp+IizzM0Hwb8h18/4Acm9Fsr4wcC4ERSuXJwWWEbmE7WHkwwFK6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi9Iod0bYux/uhtnSGBF3DUUu+osPkdgO6gbznZoYSGLF2yehO
	0RivZveOTSRIM5Vlz3PXYDA682s0MvEnUpzVqeN4Rjeg24dskuJu
X-Gm-Gg: ASbGncv2H12wl+aBnkS2f8xZBR5uVH0icucIQSVR+WEkQYDwaUtGTdxeO6uD3ki875Y
	CyOJdyAPhD2b4YnbzO4SBro7kahZ+LSuVMdc0R23MgsDojWqXkwRZHozTz6sUgR8K6N8SPkS/cu
	6d4L8zIyAwOJ0xUDsJ5byUKYViiNEDuvhzuhhiMdwC238DOaLdd03Gwe5CrwUqPLh1trH6QcS4J
	qBrZ8qTpnuV0fKoGxZDXnBdhG5CwuBUNXxnnOKV51G9Q0YvCg80Ec+ZqThZ60W/xxH6hm9kHRpL
	jm+7lgQu9UJm2SbRL0Q4h0x5FszUslFi16rYhI+urPEube1rZzVqVT7TOqml05urimI4YnJ+B3I
	JlRGE8p1KjZsHuoWk
X-Google-Smtp-Source: AGHT+IHqi95HHXK4SnypYgh0Eq1F37MXtX+T9Txf0/OZIvoA/td+0E+MwNoqRrpV70efO6Y4cwctRw==
X-Received: by 2002:a05:6402:5204:b0:5db:7353:2b5c with SMTP id 4fb4d7f45d1cf-5e762fdd064mr2514128a12.11.1741683400124;
        Tue, 11 Mar 2025 01:56:40 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c766a16esm7965571a12.60.2025.03.11.01.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 01:56:39 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ast@kernel.org,
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
	horms@kernel.org,
	kuniyu@amazon.com,
	ncardwell@google.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v2 6/6] selftests: add bpf_set/getsockopt() for TCP_BPF_DELACK_MAX and TCP_BPF_RTO_MIN
Date: Tue, 11 Mar 2025 09:54:37 +0100
Message-Id: <20250311085437.14703-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250311085437.14703-1-kerneljasonxing@gmail.com>
References: <20250311085437.14703-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for TCP_BPF_DELACK_MAX and TCP_BPF_RTO_MIN BPF socket
cases.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 tools/testing/selftests/bpf/progs/setget_sockopt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
index 106fe430f41b..7a18a2d089bb 100644
--- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
@@ -61,6 +61,8 @@ static const struct sockopt_test sol_tcp_tests[] = {
 	{ .opt = TCP_NOTSENT_LOWAT, .new = 1314, .expected = 1314, },
 	{ .opt = TCP_BPF_SOCK_OPS_CB_FLAGS, .new = BPF_SOCK_OPS_ALL_CB_FLAGS,
 	  .expected = BPF_SOCK_OPS_ALL_CB_FLAGS, },
+	{ .opt = TCP_BPF_DELACK_MAX, .new = 10000, .expected = 10000, },
+	{ .opt = TCP_BPF_RTO_MIN, .new = 2000, .expected = 2000, },
 	{ .opt = TCP_RTO_MAX_MS, .new = 2000, .expected = 2000, },
 	{ .opt = 0, },
 };
-- 
2.43.5


