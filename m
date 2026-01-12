Return-Path: <bpf+bounces-78516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0945BD10B84
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 07:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4316A305DDB9
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 06:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149D031196C;
	Mon, 12 Jan 2026 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dyOpSzdL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633CB310762
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768199933; cv=none; b=NE3qoMu0HKGXuKqUBoXOjfygWnaK3uY3C86PozwX00XhVMqoJ59ClBum1kz1NOF5S9q8BO6WRJILPyhNKAOhBnIAbyse7mwp5KDag6SwyTMXazyAiNmo9JWWfVkxzEDPpPhKh8XUgHUHmePBNqSkMtKJHUL/W44fZbR55nOPo84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768199933; c=relaxed/simple;
	bh=uSEkHsH1REtKl3xcr1eJo/cD8PSr1EaGnbXhvaEtR94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qB0cMo60TuZ+gYU98r1wZpi8gz+xYgllSXkkmoIqcm+smZ/zG5gx5l1j6cRhjk6yH7j1e7+WOw4idmtstbQH1iwzTyGNlWAZA8EGKXWLHW7+ydoYUCSNNwlcS2miGV6+eVM+oq7K+horm20EdO/k4BrgjSjIR5aADRF1KRii2V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dyOpSzdL; arc=none smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-5597f78c24dso142225e0c.1
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 22:38:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768199931; x=1768804731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dc2NcPIsYn4GHcEHnwWFmYEwoZXJ29FY+pyN3/3N0k8=;
        b=hII7/tESgbw5k44917zp10cyWkAroGEGkVeK8mMtgrftlYOsxSu7lDhSEwqeN8M/KW
         RLaS9pZX9Jq+5QBdwId9RpbxjNyo2+P0wIPcUGGzS+ArYM2KifF8ZJSu8uQWmGmizhEW
         kf7mUGUYH4vDiaR6CK+uITUwXv4pfycZSWFA/uWkUiC3KWs1+csA9daEfycdJB44pDmN
         oA+ppqIGNZbwtm+pHvtz7ocxa+DSkW4Z00963mDCwZWkRFZPQGyQytq3XdBYdLY5yulH
         BCrqanw9hyiVNDBd3tZsTQZkxHeWOHPL61T5zi5bR+E7MsHJbLsW5s55PNnEEOc0YhSy
         nv4A==
X-Forwarded-Encrypted: i=1; AJvYcCXBNuqhcDHcwvIkQQb0u8Fg2wy72t1F2fwybNCFPVY6qD563wtypfIbPdu3maQTs8kmpNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6HNGETuqbEY+SU7TUKEpCHkgLGwIDIiDL+Lno00zIFx6ltth0
	mG1S+oRfGvXg1Z3PHZ/fxuPSxa8R/bKuavIy2zDiQHvA1s21i7DuGG2c5Kai73Qk73DvuzzTOrU
	KYoIHjoilfEAx2V6JeMgSXu4A7NbxEgMt49cnij2LUgrjiMjEg/bczjfDYJqiscQlhenkw58l0+
	98YWQtRyq0B1EKfW57Mlkb+ULVQlCSzPCZ5brqMYNOOZVcPb944abZBdH38gvezKNlZTRju4Z7o
	vcxSJpzHRkDbcPVZP5Z0gbU0MI=
X-Gm-Gg: AY/fxX7lJS6H1tsmIxVbUGmdajKqtjV4T4FZws4G7HoMqEd6vSg64wxTWnA1WunLWvy
	jyUoKNOJbMBR2veVs9tnxKglhJUtX2dnjQm9TrqmDYMgQckt6639jb3j0ku4VBYjLYhvRGqREZC
	MMIFz7Ilo/GvTskTTDAbBdXB0A107rW7N5Ge5R7+hW0Rg0zj0XOSKuKDiTs0C84gT1jOcMy6OyE
	mT1CajaIZR9rcV8TkXeNFfzvcNhAUVRF+uugINIzXwk1pVbU338HN0m4SSEUpKrXgtfiVIgNeXR
	vodqKtGakIFAkNp0KlD9uVB5ct+1Trw8h5tszyo1M6Cr1QcKtJNTsDEeKPrwNtxhTwYCFJK+X/g
	3kpuhAGuZdWlewCeqCaxqb3dNWwKm8L2VZFLfTfLrUaRpeJQqGs14uJPMwzf8Tnxj4sRVKhx3nG
	kph42aVdXe1SvIf+VG45TZ99QqGLdHGysPb7P4QpLPUEo4vMSSOh+XmvspwWM=
X-Google-Smtp-Source: AGHT+IFKv3Vq/YF22i7od8MGSmGtGQF+GEh3TUMSazv8+0cACPJmJanZnIGYJqAlEFgY6UN6kM0OnvvnXh0t
X-Received: by 2002:a05:6122:9003:b0:563:42b5:457d with SMTP id 71dfb90a1353d-56347fdbc21mr3901307e0c.3.1768199931222;
        Sun, 11 Jan 2026 22:38:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5636d78a25esm1048144e0c.4.2026.01.11.22.38.51
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:38:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8887c61412bso16106806d6.1
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 22:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768199930; x=1768804730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dc2NcPIsYn4GHcEHnwWFmYEwoZXJ29FY+pyN3/3N0k8=;
        b=dyOpSzdLYKn6aQCombk0oR2K02LLwJ+NCjKCgNfEkXiPLN4uIyHfOuYdTqo+A0Q1aK
         uB/spBP3B9VE5eBuIunGO7VSPNNJzGJreCk2MMEWfZpXyLWsP90QOgyHUYHhFUirZcRp
         Xs4reIhPZe7DdWC4+6dpiEuHhCjSCqPgppZsI=
X-Forwarded-Encrypted: i=1; AJvYcCVhstKIQqqSerGat2o+KDzZlfHxbUxNCUqwH7kGOYwnHh1aQDRqe8wb5BQh5xyK5raJcD4=@vger.kernel.org
X-Received: by 2002:a05:622a:4cd:b0:4ee:1063:d0f3 with SMTP id d75a77b69052e-4ffb4a8df70mr189420971cf.11.1768199930621;
        Sun, 11 Jan 2026 22:38:50 -0800 (PST)
X-Received: by 2002:a05:622a:4cd:b0:4ee:1063:d0f3 with SMTP id d75a77b69052e-4ffb4a8df70mr189420811cf.11.1768199929671;
        Sun, 11 Jan 2026 22:38:49 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e2833sm126594216d6.18.2026.01.11.22.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:38:49 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.15-v6.1 0/2] Backport fixes for CVE-2025-40149
Date: Mon, 12 Jan 2026 06:35:44 +0000
Message-ID: <20260112063546.2969089-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Following commit is a pre-requisite for the commit c65f27b9c
- 1dbf1d590 (net: Add locking to protect skb->dev access in ip_output)

Kuniyuki Iwashima (1):
  tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().

Sharath Chandra Vurukala (1):
  net: Add locking to protect skb->dev access in ip_output

 include/net/dst.h    | 12 ++++++++++++
 net/ipv4/ip_output.c | 16 +++++++++++-----
 net/tls/tls_device.c | 17 ++++++++++-------
 3 files changed, 33 insertions(+), 12 deletions(-)

-- 
2.43.7


