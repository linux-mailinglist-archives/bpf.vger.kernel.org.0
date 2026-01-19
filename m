Return-Path: <bpf+bounces-79435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CE7D3A315
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 10:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4BAE302426E
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 09:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB115355804;
	Mon, 19 Jan 2026 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KRoi2aIG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB932773FF
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814969; cv=none; b=J+e6jk6cPOcOJQL+9Hu8gMKRMJGwLxrObQOV/wpeG6lykzYkXTBas3R6nkdoRZYwb6LORdoFoP/ECR/z+NwYQxkOoTl5HpSn0Ew3SfCiUVzHiYBdjuyFgUFBv1XmSWoJ7fqASiCPAKlIKE9dfylXesXExuPZOKnFf6hln1wclEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814969; c=relaxed/simple;
	bh=MZykRSDyhj30BjSCq2J6ccjOwanVT2N1C0ACoeLLSSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ms7wTHIPvGXlxkrhX8vGNiG9n+hkmJiyzrjKaKdynnnm2IWBVWj4fPFJxkSP15OrfMTgMH5ONjwSDROH17eBA/cJsKtYuhF6OxfdW/AZAZ0paqtTQZtJY8Hu4t1JTrUlOlf7pGq08L2k6fppQ2w2V3GvCPmKOkkt+msuJZCvlA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KRoi2aIG; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-88a279995f6so3429076d6.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 01:29:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768814967; x=1769419767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCyc417zI+LatXSOTwvS8SNjJytYpjkoBZeOlVPfO0U=;
        b=NpiZ0QtVS9+GFZQdr5wJdIZ0+5OpS3Y8GGydVnnl9+yoPkqPvONPZHsjU0g+Y3XYoh
         kofFt0u7kEWQR25RvQBMLvUDHfcVRN8jiCD/tVJJRPbH+lUUBNC/i1TPgPnWxHGJmPVC
         xE4sOQa40u7otmMfL0ax0X32lavMKV0CUZHKrmmpklmqGXTpBE2HTCzlZWnyr0NZb+uX
         kxShZQbqpYoTqvirqwH4rh+Slj0O355tYjtov53qxWUfUkUc02ZDr/jqI5eVsyBsqi0c
         8rXEnJBNd+CGoVJTKkhiLVa79BNS6DnQF4W09HuHb4f4XBtyHUfrhZfcjdVH/MS4vF3e
         xPmA==
X-Forwarded-Encrypted: i=1; AJvYcCWAu7oWYJ3VeHtcLjcIaACxBJ61s8n5DhEl7Ijhjo0EBx3qwoFxlS7h38rXWpN9yw2ayLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq3ngx9isAV/s8tWvT0gby1GAy2rwIb2yywLw6nQIqZjsabbyY
	dYgSXWgkTz8CmEMEKFRAiw5nnBNY8FpiYOU/RQ0VTllh5RLYK3nXq8aaN25ZywzHadZkd2qFWxR
	UcnNHPL2VN1O19Xl9jJ683rtGSyGc0UZfVNcqduoTAgZmN3l0/IOZHHQaRd7F4qGfAp0gKP9L5i
	jxXy3StPRc9fCXGe++YVb3HssPnJeRQm1eKYiFOk4JhWXLXqghd8KYw5m46ozVOyiEFy3s6jcYH
	yGaAoWNB489Y47o1JXQw3umgYY=
X-Gm-Gg: AY/fxX45boQDu2f79IkPvGqNN9kDEAg6Sy8R2HLg+KDesS5zNvkLcPoycNNMuznWeE9
	ghFuDD66DFdXX2EYlAI5SXINp1HsLiRU7DxrycT5FJuCDH0wMDzF2lbhVpSdKMwVRta3z+ehBhD
	EQ/gLaK66mX28dpktdalTXsQ/X1fudZsGRj1naJwdnmleFGD0Vt5LXBCq8Hdq/wRmW5RkhT1qF9
	Fnfiv1/KY3ehld/jgiF8OezyRmsCYYeavGD35FQGznPzCVmK5/TBGUtZrgYxYqvVxUEDwj3AQc2
	M5aOXw0ooSepTS2e4JFwMfRKadGl8/palTmpbQcpIfJZKKbe2bA+dv1lvQCJqk3KvslTI9GKCJD
	moB0WtiS7jIDsNLjkJc69qxsmIf/q+6HRUCgnyKmUkjJIXHNzKiV2S2zbDNCByvzkMhSpIBtfmM
	AC8f2FF8IlOXKMv1XT3sz0SXSF/oM3UujXir7KyC77dI9UlZNKi/84m6ahpePshi/s
X-Received: by 2002:a0c:e013:0:b0:888:3237:6fce with SMTP id 6a1803df08f44-8942dd8fad1mr137606546d6.4.1768814966913;
        Mon, 19 Jan 2026 01:29:26 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8942e5db8d6sm6773996d6.3.2026.01.19.01.29.26
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 01:29:26 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88887682068so14924606d6.0
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 01:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768814966; x=1769419766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fCyc417zI+LatXSOTwvS8SNjJytYpjkoBZeOlVPfO0U=;
        b=KRoi2aIGi2A1wPo6877aWaCxHp0Evo2+jceFRpB0iJXDhNF1f3hc7pYpRCHy6fSUnf
         H2xC9VmunsMLQ08p9BfA1z+aiQa1NdgHzGHAJ+y+idjdiAlw7Xp7h01CLvMyGU+lQ0Ar
         Hd9PboRF8IWvi7JA5Rn8nZMRnz4hzNSFtr6eQ=
X-Forwarded-Encrypted: i=1; AJvYcCV6TkQHCx0mayNOJFOLvr5CiPTT8R/iyeDnQk0BPUTPeFOOulXKWSArizyDTB9dqzM5Bmc=@vger.kernel.org
X-Received: by 2002:a0c:e013:0:b0:888:3237:6fce with SMTP id 6a1803df08f44-8942dd8fad1mr137606336d6.4.1768814966251;
        Mon, 19 Jan 2026 01:29:26 -0800 (PST)
X-Received: by 2002:a0c:e013:0:b0:888:3237:6fce with SMTP id 6a1803df08f44-8942dd8fad1mr137605946d6.4.1768814965846;
        Mon, 19 Jan 2026 01:29:25 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6ad6f3sm76917516d6.36.2026.01.19.01.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 01:29:25 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: j.vosburgh@gmail.com,
	vfalico@gmail.com,
	andy@greyhouse.net,
	davem@davemloft.net,
	kuba@kernel.org,
	kuznet@ms2.inr.ac.ru,
	yoshfuji@linux-ipv6.org,
	borisp@nvidia.com,
	aviadye@nvidia.com,
	john.fastabend@gmail.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	kpsingh@kernel.org,
	carlos.soto@broadcom.com,
	simon.horman@corigine.com,
	luca.czesla@mail.schwarzv,
	felix.huettner@mail.schwarz,
	ilyal@mellanox.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v2 v5.10.y 0/5] Backport fixes for CVE-2025-40149
Date: Mon, 19 Jan 2026 09:25:57 +0000
Message-ID: <20260119092602.1414468-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Following commits are pre-requisite for the commit c65f27b9c
- 1dbf1d590 (net: Add locking to protect skb->dev access in ip_output)
- 5b9985454 (net/bonding: Take IP hash logic into a helper)
- 007feb87f (net/bonding: Implement ndo_sk_get_lower_dev)
- 719a402cf (net: netdevice: Add operation ndo_sk_get_lower_dev)

Kuniyuki Iwashima (1):
  tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().

Sharath Chandra Vurukala (1):
  net: Add locking to protect skb->dev access in ip_output

Tariq Toukan (3):
  net/bonding: Take IP hash logic into a helper
  net/bonding: Implement ndo_sk_get_lower_dev
  net: netdevice: Add operation ndo_sk_get_lower_dev

 drivers/net/bonding/bond_main.c | 109 ++++++++++++++++++++++++++++++--
 include/linux/netdevice.h       |   4 ++
 include/net/bonding.h           |   2 +
 include/net/dst.h               |  12 ++++
 net/core/dev.c                  |  33 ++++++++++
 net/ipv4/ip_output.c            |  16 +++--
 net/tls/tls_device.c            |  18 +++---
 7 files changed, 176 insertions(+), 18 deletions(-)

-- 
2.43.7


