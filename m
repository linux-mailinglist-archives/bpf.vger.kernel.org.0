Return-Path: <bpf+bounces-65458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F987B23B94
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 00:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E4A3A6B30
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 22:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22ED2DA74A;
	Tue, 12 Aug 2025 22:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8ySll2q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63F82F0669;
	Tue, 12 Aug 2025 22:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755036119; cv=none; b=e1Kv1eE3hx2OPGblebjAcQxgWGSA4aZm7LNVKhYP3KKJF+cS7vdlMiR8aE/+c4C2QkYAGE6VG3O/Bxy7aHGyVOqZBZ6vSwUpUcLKoXl1c9seubQe0NDxFm0NDb+TSAVKczLJR/Ixq4dqta0yM3bgxV6uIjWyh+eSWMdhp8FlukM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755036119; c=relaxed/simple;
	bh=dZiwYUvC4jcEw/sftx0pXClvc/8dzqWFCpy9xCb+7Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=svcqE/AT774yDULeE4xvmXQkyRQ6cY28SAqvNUl0+1IpzpoXz+UCJZxNQTMhuMNa68TGrAY05D0aHe+pSMHQI7ZscVV8Qhb0YOH/dztC9ec40XB8n4h0X7YaLvWqWGaNBNZeVeaylkjtNQ2d26Ru3sj4CfuRwwrccX74cnJ2LKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8ySll2q; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a15fd04d9so1909045e9.1;
        Tue, 12 Aug 2025 15:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755036116; x=1755640916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rp8fxJWWkR9mtza5tpe4CO6y3NWSepsIKtYTyVIj8RQ=;
        b=D8ySll2qeUuiRpVDCoYPsBrUvJv2MC1iXGWHrg7etaZ2EDtBgzESj98DySaRKuCxBp
         CgcA4m3FRymncUbiGi25GWbdf/c7ELrWVUE+2wjrQG4FQD7PdQabL8Aa6r+f9UM3uTGt
         1py6JEDVq8+CMYWapmUDHD1lRVXRSAbPhKpsD0+FsCiREBdnViSV1nL2qxjE3vPieNhA
         ZTsZ7QkP2o4XdSDwiYfeJR0gSF4cPMS2gzF4qAPW1tFK+jwVoQnJlWah+zwtsKC5oQSo
         vvvsSLx5wqld/EwvN/1V8wgj6UDEbHY+MeTwlkXXGOYA51z2ipxWF3Upn4aB1xrP5jGg
         tnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755036116; x=1755640916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rp8fxJWWkR9mtza5tpe4CO6y3NWSepsIKtYTyVIj8RQ=;
        b=EsImyis4gTO1RmI6lXMtIwlbHCGmngM3vfGAVmGQKxYjY6Kqanl5KapDUJa+7U8noM
         l5kYZhF7IVJoiEHpKdi1WgtdezWcXf/A6DCl9QqsAZzTv0m+LyAXbiuKk58OCwi2Laba
         BWguuMEFC8h5wCGWXH8oiOJH/hUtULPj4vkIWrZ7+HlJf84dZuGtKcOZ/V820pYxUQUZ
         p/Upb2unxRO9hWqbSgBTNRfBhURRGR+1YLww5+N5ePy8FKt4at3lTv/T1ihhXrOz8lXc
         hUYUq7w+c55LtM4m+JQ6u+gV31I9fPEd7+2UEyR8FzxAMWwWmHmvYFxlbCW14nZWUZhj
         eTQw==
X-Forwarded-Encrypted: i=1; AJvYcCUBpezE2pBP/ttcLiCD68bhge954v4NNmDQzRJyF6tWopMsD2co/a/ieJZcuZ37iYRV/Rk=@vger.kernel.org, AJvYcCUIymtmgQZzYIO/jMkzYf8GhiREQRHrKCWTWkMf+bSAD+By0xCewPnkLlJZMJCkSxwnVx7W5v+cOiyo@vger.kernel.org, AJvYcCXK09wlqGFwBmvm6ytNtXV/jwliQIRZsMDjGdtdoQQ3GhMhNeZ+wqvwvuX8qC7lMHHH7fq8IoQBLXsTt9JW@vger.kernel.org
X-Gm-Message-State: AOJu0Ywto9Qpvu01b9s5jOfess4BILtJG/iuzMrDJpxPIVgh1FgljJZx
	+EY91wBesFh9rbYGfzqk3AIUUmabiBQgJpzmTKwWoMkVt3+Skj2kVhPqfyPzBjwL
X-Gm-Gg: ASbGncs1NA2rmviiIB4ZPkSAP+BzX9kASfRx6pckxFJH7MM20GaR4JCk1+cMQiEXRbb
	4rSbpu0BQ3oFaSoUKrPX5VzqaVY+z+0D3Reh2hagaNIHJbOdctRW2GTgn1E7hC4ZKMDwYUIpsMl
	Y38zqi+AtTaqbrx75bz8cm6wLHbnc+riOBmBNEHXgInRFE7xSUV0kyc6Is/gANpI/lGpeWJi37e
	z5G/JGG9MA55pjnilk6riKhsDkNZkllFEo6wW6VmvW54evOCyNkDca7v2DQT+fB1IX9tRwptlir
	v1bRJMQv5w2jQlhtDsJ/qcIP/iW6TXMxNSD+3hr5xRo60jD6KouRGbKYy87peizaOBkTPRVi+ii
	OBPrwubn9nrpGCleY1Zct9e+n
X-Google-Smtp-Source: AGHT+IGV0LblS3YtHRZrtAYReogzaHuNpOyxfS/BjVqhbaoBslhN1wCrsmbTiAqs57BokMy5jPLsyw==
X-Received: by 2002:a05:600c:4449:b0:459:dfa8:b85e with SMTP id 5b1f17b1804b1-45a16f9e27cmr1411995e9.0.1755036115669;
        Tue, 12 Aug 2025 15:01:55 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:2::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a16def4acsm3626955e9.23.2025.08.12.15.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 15:01:54 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: aleksander.lobakin@intel.com,
	alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	bpf@vger.kernel.org,
	corbet@lwn.net,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	hawk@kernel.org,
	horms@kernel.org,
	john.fastabend@gmail.com,
	kernel-team@meta.com,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next V3 0/9] eth: fbnic: Add XDP support for fbnic
Date: Tue, 12 Aug 2025 15:01:41 -0700
Message-ID: <20250812220150.161848-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces basic XDP support for fbnic. To enable this,
it also includes preparatory changes such as making the HDS threshold
configurable via ethtool, updating headroom for fbnic, tracking
frag state in shinfo, and prefetching the first cacheline of data.

---
Changelog:
V3:
  * P1: Add missing constant causing transient build failure
  * P1: Fix rcq_ctl config when hds_thresh is less than FBNIC_HDR_BYTES_MIN
  * P1: Update commit message to add hds.py results from selftest

V2: https://lore.kernel.org/netdev/20250811211338.857992-2-mohsin.bashr@gmail.com/
V1: https://lore.kernel.org/netdev/20250723145926.4120434-1-mohsin.bashr@gmail.com/


Mohsin Bashir (9):
  eth: fbnic: Add support for HDS configuration
  eth: fbnic: Update Headroom
  eth: fbnic: Use shinfo to track frags state on Rx
  eth: fbnic: Prefetch packet headers on Rx
  eth: fbnic: Add XDP pass, drop, abort support
  eth: fbnic: Add support for XDP queues
  eth: fbnic: Add support for XDP_TX action
  eth: fbnic: Collect packet statistics for XDP
  eth: fbnic: Report XDP stats via ethtool

 .../device_drivers/ethernet/meta/fbnic.rst    |  11 +
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  82 +++-
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  75 ++-
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   9 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 458 +++++++++++++++---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  23 +-
 6 files changed, 576 insertions(+), 82 deletions(-)

-- 
2.47.3


