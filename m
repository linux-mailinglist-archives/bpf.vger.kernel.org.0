Return-Path: <bpf+bounces-61742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E00AEB1CE
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 10:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119CD5634C3
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 08:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEF527F007;
	Fri, 27 Jun 2025 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kx1Tb/1O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B0226B2A9;
	Fri, 27 Jun 2025 08:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751014675; cv=none; b=sEdEsN/nh04SdyEP+whFUI2FAQ8rCWYzchgpBNNuY3Pzc+7sLs3N3b8ZfRKcXYh0DzFohoqECZvG5cZ0jzv4xQmDh4UvcdmQ6Kv83rGHRBlaurbgkycquHX5SZYH14GmTNR6NL5fD3ApQLmFAcwxLSBNZMPPRpITHvVwFU0ub14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751014675; c=relaxed/simple;
	bh=gy06wkgzYN/6y36022+JpiDZZtaCzcdcmuScqSz0j2s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ruVNP9RQqIrC3IKi7ZQTPAoY+thR9G4VtACq5XisNA7R+PxChVJ7ivUs/UuJKhXhiuftrX/AQmGp/dTuhsWpRojUy+VMEpiOfQvfcnuRSD/VcRA3OBmnGQJX6r/WLp9x6/Ab7BNl16BqstM/az6XtEvy5wOE2J221PK3niLJ8co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kx1Tb/1O; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-742c7a52e97so1914722b3a.3;
        Fri, 27 Jun 2025 01:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751014674; x=1751619474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qywkqaS10jNfbcCe1Qucm1CexZUdcFWqT7Q/PirttBs=;
        b=kx1Tb/1OO4i0gZmdVyxxb1tHM4O1P9TZ7V3Vg5QZjs4ZV1HPxvbO7xeIX6tysKiyQz
         elX4bj5tkTezi33q1N6vbbzpEDp0SCFyY+1jvlJXI3uY793m1KJ2wHCJd+rYgix35oTQ
         JeQZdX2OcZX+ca0a9Ie0NdRHryBU8oEoc9KbbxXqGu0V1YI2CrhTMO2gakiXzhnzVIQR
         /PDMXvlSBnELAnjjjKyqvv4KkYvkokqHBFl0Vo75nXyQHOf3LZjw04ciMadTSp8Aa+lC
         RZRGowfvdpPtCLlwmCmGW6cKiGkSZ7QHnFXC8w9m2NcAnbXoTD8EJyTG+19fXEaG101C
         yKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751014674; x=1751619474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qywkqaS10jNfbcCe1Qucm1CexZUdcFWqT7Q/PirttBs=;
        b=azmehzLBsFUP/464mvVehd5VwcE9nfxouG9HAVIYRMrdWjyckpDPi+l5nrNQZ/SY5E
         /NQGsib9ISDj3828WKVf12XxkXxH2uz9HE1/GTVmJyEpKKXIyUInuVIA07am2XHN7CMN
         GAsCoAyeZTu5uPYkLqnLfiIfa9oOTUiFWmQ7SHuL1LYgpOHZzWp6j8ykAmxnruv+M3Fk
         0vMP+ePDVHks9x+AbaPgJZxAjJCFXZcnaD4Jo3gsyQMfCmo2zgSO6958CRnd8oH2fupb
         NWljcXwSZa1WNjEP9g37yVKiSKm4zGHgShcz9dFhmxmxp74GrvtF6XMArNFpdQh53RUx
         23RA==
X-Forwarded-Encrypted: i=1; AJvYcCUehqio0TrXdebBKUVu9ZDHUSTaS0NbslDOxfsvw4QAQI1eGFQb9hTtwi3x3u419VRsRo1Gaqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9DQXhQ+JZe+Y3ISnfsD0z3NO6r7M6zAGVYETpJ+JXn5rLWEJB
	Sz6r2pXCFEDPdKYoMYWHtZnmu/LMU1woziYTzo/PGPpfq284u7SRwHOD
X-Gm-Gg: ASbGncsh6JCI0UL1aEfq9YAjU4GsHke4NMoFUvHFcD2H2yZlfDdQmZ2KpHTIbPxksY3
	P3QleT3AuqQfp//xVWKvuX82L/IbtemxrZdh74w2WoZIwYRpVkdkOqm542ADQ2ArUBtxsXP6F8q
	0S1siYOWBQNLmMAlPRjVSGaZIVO7lWZbnXPyIIIv05bNxLqc3yhqkotwRj7Wg0r7Yk7e8rClv8p
	TanbUclM0XGr7NaJ7QD2jKyLblXWu14Xev5UbR+DqGJqMi+ZQ+qaCQjEmDL78v0vu6ShwBRoN3l
	iqiS0qpP/WgtJLnllQMiUJ7oOX8P7buuEWIT6mhCmlQ53k5YOP1sBjk1qyfk1lOPtcBoljXFwRn
	KwRIYbYfGgQGswnGWHHm9FnBJvddY3Mxt4DDsHNpwrkkl
X-Google-Smtp-Source: AGHT+IES2qy1Qu14o5To39sDMwX4mYsXpTJNjcdq0ZCeobQ+w5UJH98hvV5GlniHP9X0Npx87yXTyQ==
X-Received: by 2002:a05:6a00:1493:b0:736:9f20:a175 with SMTP id d2e1a72fcca58-74af6e27849mr3462219b3a.2.1751014673647;
        Fri, 27 Jun 2025 01:57:53 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540b3d9sm1728170b3a.2.2025.06.27.01.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 01:57:53 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	joe@dama.to,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 0/2] net: xsk: update tx queue consumer
Date: Fri, 27 Jun 2025 16:57:43 +0800
Message-Id: <20250627085745.53173-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Patch 1 makes sure the consumer is updated at the end of generic xmit.
Patch 2 adds corresponding test.

Jason Xing (2):
  net: xsk: update tx queue consumer immediately after transmission
  selftests/bpf: check if the global consumer updates in time

 net/xdp/xsk.c                            | 17 ++++---
 tools/testing/selftests/bpf/xskxceiver.c | 60 +++++++++++++++++++-----
 2 files changed, 58 insertions(+), 19 deletions(-)

-- 
2.41.3


