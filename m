Return-Path: <bpf+bounces-78512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE97D10B5A
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 07:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF0B7304DB58
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 06:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EC73101A7;
	Mon, 12 Jan 2026 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XU4tbbCu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E317421FF4D
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 06:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768199629; cv=none; b=BYTQ33SeMdwpWG4x5XiC7RVQ7BzLqLc4zVKgtjpQqacL6ZdX4CRlpdOzSeZNrsp/dsMCWZCz8OupIG6ZnpwspodtEUVF7yrRmIqZMFUEVPfRkeUGM3K3/NoJ7PEIlzMQ4qK+3uxailZajaTGxLg2JxSX5Iceb/S8nFMR0Qc6H2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768199629; c=relaxed/simple;
	bh=hADIlBZYtdDPX5eqQOXYz6UWY5u+6lD/06flIKFJ18E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O8BM0lBxbp9UJPWzT94SjIFbztg0QNY5Py78z8NNl8DWzJrsYUc1tHpAFKrKWOpaogd0rjUrJwEcPcoPv7pRczh7oa8/g5CAWCLcJCfBgDmNaS2HQqN1UCC7D6AnOnIjof4IuQNV1if1Xdkiubp1OkcXZaD9gnISoTt72mtAEN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XU4tbbCu; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a2bff5f774so18809165ad.2
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 22:33:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768199627; x=1768804427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UzlbmQPdy52FJ6wYnKqwTgesgoqrerCYySfqK64xSQ=;
        b=ixqCBTFEh+t0eYlpW8pBeQjP9F6LbAl1ic3DmSLP1Il3SxCP8AJ+hPyFEimcz6ghK8
         PyR/YJDyvDQlGgeDQ7g9S2bF9cm1tx8XK6oI2Ux6k24iMmPG7XQvT6LMJZmtimtekP1z
         UTcAj3HAB/4FI6GTLwenWV6tFRhg6eleiuKMChY8hMV+r6BFKT9gzNnlUSp1Q4WQ2V4b
         BN31w8Zq+so5jcohQkV8+sH/6FeZVPek6rApA92SdKkgVZrVbR4oWLdAU1q1j8svZrAM
         ExuwIzttczLy4nSkZqrVhrtYFT3aGhLZWaMueUEzArKgr/DKy+UMotHpqLSPl0QyZMIe
         cvTg==
X-Forwarded-Encrypted: i=1; AJvYcCX5F5qmgINKONr9UgV60HaM7Ek39gn7X6UFrovCTgVkhBrei7M4vzEiKT2BgZIIMauNxj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzfPo/6iN5pxb587ZQKNk0cK/u9Dgl6LCtlyvft2ggZ5PmTpRC
	eZ0v7Dl4tRKLZQB/vgNl/l9ARRCcZe1c/JAXwYNeTJV44ui/vA4iM0hK79LWGWKGnM42RTzWatH
	phA33m9E+N6bIzNmV1OK4XradigcjIx76rSnER3NErKHbWEavviAdjeLJOYMdvLK4HQJ7/3IjpN
	Xr7NyEpoQq97WkuDF6kbQKC7C8QF21GQmKFZrTVweKgIe20sAavL4lVv0aq/4UTdvZ1igt4nv1L
	U6OMDWxQiBK5WYi6JXnSDG2mf8=
X-Gm-Gg: AY/fxX4mjYgjcj0Nma5dt9Nt1SS23Z0dXpdENfZL9hB7McuQCWMl1mCsqR3WBBItB5B
	w504MvjrKSUAa1CSW8NbP6AM3febLATMQfxE/57HO45DO5H14SzlNOpA8Lzof93VU4DbwPMrUto
	juC0UzmIGiAV51/2M0v1hwX07A8TUCrZy6vAsZDyiQwnx7UiDiVGj8pAdebLpukZCWpufo2yhj8
	DajmfiQP+5xWnbNqStCk0w3TeIVnUsp41saSL5166nehO0v9T0h/U9HTKtdDvWKrCjUkmgsQ4Ul
	arhntpxIHYX/xUHvS1CkRgn23bGUerj6Iz5wtSCL6QnGpSjKAfwRwM5BDwHh1a5DFlEFaPjLXn7
	WAPzINmsQS/j1x2fb+4XZKihy9rjrW6OHVQ/myzSFyWaTd3DA+D4g59+c7edJFoXALhSNYZkiZU
	5HI4f3x5baDCrF967Xi7iOHSk3Ny++1q28O/hcqFJC1ISY7Zp9d8ZRmz6ZMG8=
X-Google-Smtp-Source: AGHT+IHh6S9fCYozmRrNlyEZkeJHtn/G7lJnIUbE/wefPHsb5LiZtZhxYG/qVX4qgSsqb0LyWOYXU4bF5aWi
X-Received: by 2002:a17:90b:2d50:b0:341:124f:4745 with SMTP id 98e67ed59e1d1-34f68d22540mr11342372a91.6.1768199627113;
        Sun, 11 Jan 2026 22:33:47 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-34f5f8d0c46sm2497096a91.0.2026.01.11.22.33.46
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:33:47 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b5ff26d6a9so129042185a.0
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 22:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768199626; x=1768804426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1UzlbmQPdy52FJ6wYnKqwTgesgoqrerCYySfqK64xSQ=;
        b=XU4tbbCupw0FbbNLf2BlGVoXOJwO2ULYuVAfFlj79A5O5VDYm0R+FkgDuE+BdAy02m
         uUId3s1SO/sQ6l9KdAL2yfaF+FhXxezbgGFCZalzWwciXpifP7cruxaQaa8J7BMfdc7f
         L4aCZ7EXqX3lM6xGJyiCwI2Ho/6qXP0iKAddg=
X-Forwarded-Encrypted: i=1; AJvYcCXVcrLMK3iUxRkd3sQNv3Ah8KKCh84E6kppjQAUaCDFSsziVt0OItea5prHJFOmCQyxAoI=@vger.kernel.org
X-Received: by 2002:a05:620a:d8d:b0:8a4:5856:e106 with SMTP id af79cd13be357-8c3893699c7mr1930992085a.2.1768199625721;
        Sun, 11 Jan 2026 22:33:45 -0800 (PST)
X-Received: by 2002:a05:620a:d8d:b0:8a4:5856:e106 with SMTP id af79cd13be357-8c3893699c7mr1930988785a.2.1768199625102;
        Sun, 11 Jan 2026 22:33:45 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a794bsm1472324885a.9.2026.01.11.22.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:33:44 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	sashal@kernel.org,
	leitao@debian.org,
	kuniyu@amazon.com,
	willemb@google.com,
	jramaseu@redhat.com,
	aviadye@mellanox.com,
	ilyal@mellanox.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10.y 0/3] Backport fixes for CVE-2025-40149
Date: Mon, 12 Jan 2026 06:30:36 +0000
Message-ID: <20260112063039.2968980-1-keerthana.kalyanasundaram@broadcom.com>
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
- 719a402cf (net: netdevice: Add operation ndo_sk_get_lower_dev)

Kuniyuki Iwashima (1):
  tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().

Sharath Chandra Vurukala (1):
  net: Add locking to protect skb->dev access in ip_output

Tariq Toukan (1):
  net: netdevice: Add operation ndo_sk_get_lower_dev

 include/linux/netdevice.h |  4 ++++
 include/net/dst.h         | 12 ++++++++++++
 net/core/dev.c            | 33 +++++++++++++++++++++++++++++++++
 net/ipv4/ip_output.c      | 16 +++++++++++-----
 net/tls/tls_device.c      | 18 ++++++++++--------
 5 files changed, 70 insertions(+), 13 deletions(-)

-- 
2.43.7


