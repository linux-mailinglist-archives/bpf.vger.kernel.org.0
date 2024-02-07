Return-Path: <bpf+bounces-21394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A7784C692
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 09:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5653D1C21C3F
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 08:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFB3208BC;
	Wed,  7 Feb 2024 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZ5+efRE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6257120DD8;
	Wed,  7 Feb 2024 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295683; cv=none; b=QQGT0UulxUbE85JdEAN+QWjgHQYNA+oP/WQJ1xMr8OHi84ID4+5BIbNTnqtdv9ZazOa0BbtxhqTPNsgx+0Uv1BI3EaYe0Fy5Y0wJp9K4GdLCY6F6iUVjAzduwqflolt75lQSoYqdLuBuozl0+bRlGooh4w+piAs2m1ElpHavWrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295683; c=relaxed/simple;
	bh=Ob3G3uS77jv9IBqBz/Ayr/vtbRlwHRFDLvJo7yFWl0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t3gD12U/F+jwhhyOGVZYdNfJbNv7xkCBm9Vl8zpaIaRAEDF92siudj1ZgJMy3NuFYzueiGr21ap44A+YW+qufWHGJN5NL8NoQqLF8ZN8g5jiVTtOpTrxwexlREjOBAgpi2VbgXrcRQgTh+iiu3Sa4vZ53jE+5SwC/m9F4hdqJYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZ5+efRE; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33b1c33b9c9so83531f8f.0;
        Wed, 07 Feb 2024 00:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707295679; x=1707900479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PNZDQhXm5PMJ7sIVLmTHOOeuso3IU3bmrVPAnHG4hCU=;
        b=QZ5+efREi9NBkMLUI5lFvHONPBIikgOh+ZbkkJeetTyLFAinrNWzVtRbozHgtuRRQb
         S0KvHIyWsunc0d7DUydVSRtUN0qy4C9aX0YNbP+kpl/7o91Dio3Mks/gafy4A6eOzkDY
         qfoRj9kNjLEJdHHGvCLBChaeNyQ8gvMeoZmdewSNIXKVpwcemETcGcLjwBU6UFXpbzm6
         8rhS4NWyYVUxGP+YDPe5pab6O25mjgmzD7+bJYNrGoRDHl3weNjBKzRVe7VAFD9vYVyO
         Kosl8qmX42SdvN3xvdVp69RZks0Bz9GH55R037xhzQVBSzIS4/iJUS3RoQhM8fHEK2Ix
         qlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707295679; x=1707900479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PNZDQhXm5PMJ7sIVLmTHOOeuso3IU3bmrVPAnHG4hCU=;
        b=axheDrfTI7Q4wiOXmsh3xluPGJRz+lJa5zwsDmHB0ScSVlY0WcL8DjWdkteX7zTm7n
         4/g+HH8v6OJaQRGdKgxurCLba7H9kIXO+UNI4nv0wIMtj4yoXxW2bOzKMcrVmDxv4cBy
         OKjVY+CQz89NRQ/uuf8cRP1xXCXZPBHdEbvDQICEJDJV8QwIoPgIiaT4DxN1xIUO1sMV
         f9vTRbpG1AXvTz8ze4sP2QDmfi1Tx2glGT9CgbZCB13uiQwSIfJs6k8RfD6Upim3zt8r
         WvZUuUDshxjz0Qc+17KZSiu5x8br0AUmd94pvM8hmD4kyDoW514uhmsICxzKLHkWlEsx
         pdvw==
X-Gm-Message-State: AOJu0YxlTcDySPExDxnBbv6cp48aquddYqtna9CIbwM3yRo53KHeAkOv
	KNX5ofJ0tORMTrC2c38k4aJ3C6XLxKEr2wzhqWQEOMB9RJ19EvBV
X-Google-Smtp-Source: AGHT+IEnSSV9fm87Li5GQk9Ie8kmLXD/Yq2c7jpoWAU8udLECt2uQsv7ikcYdWCxQ9+dQwRUGirumg==
X-Received: by 2002:a05:600c:198f:b0:40f:bda6:ccc0 with SMTP id t15-20020a05600c198f00b0040fbda6ccc0mr4120618wmq.1.1707295679326;
        Wed, 07 Feb 2024 00:47:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbaBmjbacNDfw4uTYbb75EMgYuAMEFd/3fCWa9kU9Bb/wDmXCfkZsgQow4FlFmtBTljn8oobn8N+LOOiqPgXm9sZvSVAh5CjKlGm8q3Q5BnyZGgI/ZussR26fvgKGnixwNT+1aK7+kO4XFwRRkRZ/UqvSZ406GVebBJpygZydvjODGs7n89zX/h0f4jARrBA8Mdanv7Vbx3TpWVOWyFeAiVai1uM4kPJULX34vXnNbXIUBz2cM52UKu9vOy6ji2m7jk2RHHEJHmLKbQfxtKwAzoPeVMOPFCVz9VKBY/SRIjomzHT/lSjKExndPy/cN60tGpYEWzbnEIVmQshqj5QVqEZrhBCWdO/N+d26lnawPcOZ5AAcvd2i5LxMfjR4m1PyRgc49wJJhPKLCLUpOCbrwy9Nx59HRWrG7g2UtiKovat1I3xz5+FovvISQ829mxC4IxFZyekee06NpvvE38RHK0zVQcup5hlGUMoqkRuK0YfR9W5G+7Lf8eeffmw==
Received: from localhost.localdomain (h-158-174-22-45.NA.cust.bahnhof.se. [158.174.22.45])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c4f8d00b0040fd1629443sm1311404wmq.18.2024.02.07.00.47.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Feb 2024 00:47:58 -0800 (PST)
From: Magnus Karlsson <magnus.karlsson@gmail.com>
To: magnus.karlsson@intel.com,
	bjorn@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	maciej.fijalkowski@intel.com,
	kuba@kernel.org,
	toke@redhat.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	j.vosburgh@gmail.com,
	andy@greyhouse.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	edumazet@google.com,
	lorenzo@kernel.org
Cc: bpf@vger.kernel.org,
	Prashant Batra <prbatra.mail@gmail.com>
Subject: [PATCH net v2] bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY
Date: Wed,  7 Feb 2024 09:47:36 +0100
Message-ID: <20240207084737.20890-1-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Magnus Karlsson <magnus.karlsson@intel.com>

Do not report the XDP capability NETDEV_XDP_ACT_XSK_ZEROCOPY as the
bonding driver does not support XDP and AF_XDP in zero-copy mode even
if the real NIC drivers do.

Note that the driver used to report everything as supported before a
device was bonded. Instead of just masking out the zero-copy support
from this, have the driver report that no XDP feature is supported
until a real device is bonded. This seems to be more truthful as it is
the real drivers that decide what XDP features are supported.

Fixes: cb9e6e584d58 ("bonding: add xdp_features support")
Reported-by: Prashant Batra <prbatra.mail@gmail.com>
Link: https://lore.kernel.org/all/CAJ8uoz2ieZCopgqTvQ9ZY6xQgTbujmC6XkMTamhp68O-h_-rLg@mail.gmail.com/T/
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/net/bonding/bond_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 4e0600c7b050..a11748b8d69b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1819,6 +1819,8 @@ void bond_xdp_set_features(struct net_device *bond_dev)
 	bond_for_each_slave(bond, slave, iter)
 		val &= slave->dev->xdp_features;
 
+	val &= ~NETDEV_XDP_ACT_XSK_ZEROCOPY;
+
 	xdp_set_features_flag(bond_dev, val);
 }
 
@@ -5909,9 +5911,6 @@ void bond_setup(struct net_device *bond_dev)
 	if (BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP)
 		bond_dev->features |= BOND_XFRM_FEATURES;
 #endif /* CONFIG_XFRM_OFFLOAD */
-
-	if (bond_xdp_check(bond))
-		bond_dev->xdp_features = NETDEV_XDP_ACT_MASK;
 }
 
 /* Destroy a bonding device.

base-commit: cb88cb53badb8aeb3955ad6ce80b07b598e310b8
-- 
2.42.0


