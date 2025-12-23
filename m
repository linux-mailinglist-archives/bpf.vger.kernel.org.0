Return-Path: <bpf+bounces-77367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2C2CD9CE2
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 16:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EB9130AA18C
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 15:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90EB34B1BE;
	Tue, 23 Dec 2025 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k15WHd2V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00052F6930
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766503624; cv=none; b=Ux3tMZh0TRh0BQBnQZxLaqXGUkUGZ9nMcIF41AJaw4RKgnt16Nwp1P6V+v4gyT9L9SbQ9KXLlr0a62/AR0c00hsVjkOCsCoYhGlUSTR3EMfNdoagY7wVKAqzlag7iA57NPlHKMeZdZfk7HfYNqsr8brMrq/WIFF10jkBWCNfVYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766503624; c=relaxed/simple;
	bh=FNjOWXAmMiSFDurxbAY5FmfDgB2timg7UJONSCEV91w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dt1tH6n+d6s3xVXA28MtCVtqmZ3Fd7Rd7eIjciz77yIesRl0wnW+GEr2E9opCaR3b5+SJ4OKQBj57ooBxvTNqx5hmBf4XcuT3S9RUvujV1bzNTXvvYk8AQOMdbXNqTcNW1O6GmJ289DIYT2xZ0hjctxj8Ola/3ugDUO7zsLFIL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k15WHd2V; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34b75fba315so5775136a91.3
        for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 07:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766503622; x=1767108422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Te/v2waHQmamwOq0sULQpKzWYSQXa6/bK0ITErWJeQ=;
        b=k15WHd2VIufNkdpblfKci8MzzeVOy1Ncf+fxBh8ETyfDdupbC4aLvdk00c5ye5al+U
         Z/gzHx31H37y+wR2Xmkn3VjZhd2/xfg+xFqdsmBOSjv+4M1onxcNZ7jaAC27OuxZWxsY
         V4bhyVoeAiQxfa8gWd+1ne0IsC9H4gflTIXbMMnQLQYcfHnZLd3I/Wle/okp3JgV0V3O
         ElTRON3u6nqmSCq28s50tSoKUqr2/7xwO0sy9dtygFuaakiprW15Z+grIZjgmhWLyDls
         FwhPPi3sKarqEITBToCmgIcFguWEe8OCLiOar4EzlPVSL43DW6a4xhwAgD/9d9QibxBQ
         Nmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766503622; x=1767108422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Te/v2waHQmamwOq0sULQpKzWYSQXa6/bK0ITErWJeQ=;
        b=fR3q8YANFICfW1gZvYpOk2PCTDZDhL1q5x/IeTr9C/M/n1z5w4xYRcvkUVsa2kyV9s
         ZPtt/544/lrYpHpApkLCaeDJ0OGPQC5Aby10ZlqpFdkH/iBFUQCFvO53Ie8PRGtfPw4H
         BBldmEEPIkUqFfJf0YVVzatrTYklR4rlseOzgTDh7v03xJXGYBhOOiTK7ME4L2rw7YgI
         L+o8UDjm8pIXWPFpWn2METPjJeE7CQamoMzbpze9AKOIIAejfBVtvUddOS8yQJ5y7vB9
         mO6YE+yHB937iPot++jXRNuC7CRKyEtSUCD/aZQsOvAGYzN1h+0wECkCmLBcSFeURoil
         fNaA==
X-Forwarded-Encrypted: i=1; AJvYcCVwYj6z0PPlAo2ER2sbJjBOveLQFavX9vWHUcgD6WkyX0Tpj3QhCrC837+Mq+1hWADvvYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw6OSf/L6C7XZ5bLHFir3FTUcjiyMVC0cvE1kmB8iK9brdJpEW
	avxtxEtM8TyQmXogQvvXIKvZYY6kpb29hJUoECyazyKmKo87gJqcxl3b
X-Gm-Gg: AY/fxX6St/8ENF91tvsIX0G44g1/iFCU1mrDaJROvtUVviBx/9mdHRS7K38DSbL4dfN
	chza2RD44ZTOq/qVDkJ2RH5LWVMOotwJeEXiF6m6ugNA4ptOdkayfwNJvAKZhlAtbH3KBke5Lq/
	JWTjqgZfman6efe6/sIxioR5Nlon65BAA9HbO9Qedouk21mbPrsbVTbFUB/hTC8RcqGomFt+R9f
	/m+rRb3NOeW1QaMRog0Vvr+4m/GMuV82SKAdnkWzRE+bvHE17nsQ8y1lWlpCrVpJsLC2NnafcoN
	nTWopUdkAM+FSw5X/rB4cyXI2GjR5FBlJZDfAq9SSDFZh7a5+ekXscl+XQip7AazMzB3lqpeNuF
	RZ8pUmltEIxFF2ColFMahGQP8p9T0OdxC0xEt0cf4Ywz+YNOwL1/U3dzcY837Yb2qXcbB0Unjja
	vA7NPVNEX6YsjTee53HBFeEXYgPA3guXbjTP4=
X-Google-Smtp-Source: AGHT+IHs+VCzqx2tYFavwNoq09qWoQGNowOUFffowxOLdmg82RfmPo0+b2W9UfBUYK3AtZWwo3w3Lg==
X-Received: by 2002:a17:90b:5608:b0:34a:9d9a:3f67 with SMTP id 98e67ed59e1d1-34e921f010bmr11520195a91.33.1766503622215;
        Tue, 23 Dec 2025 07:27:02 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:3523:f373:4d1d:e7f0])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-34e76ae7618sm8006138a91.1.2025.12.23.07.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 07:27:01 -0800 (PST)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net 0/3] virtio-net: fix the deadlock when disabling rx NAPI
Date: Tue, 23 Dec 2025 22:25:30 +0700
Message-ID: <20251223152533.24364-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling napi_disable() on an already disabled napi can cause the
deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
when pausing rx"), to avoid the deadlock, when pausing the RX in
virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
However, in the virtnet_rx_resume_all(), we enable the delayed refill
work too early before enabling all the receive queue napis.

The deadlock can be reproduced by running
selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
device and inserting a cond_resched() inside the for loop in
virtnet_rx_resume_all() to increase the success rate. Because the worker
processing the delayed refilled work runs on the same CPU as
virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
In real scenario, the contention on netdev_lock can cause the
reschedule.

In this series, we make the refill work a per receive queue work instead
so that we can manage them separately and avoid further mistakes.

- Patch 1 makes the refill work a per receive queue work. It fixes the
deadlock in reproducer because now we only need to ensure refill work is
scheduled after NAPI of its receive queue is enabled not all NAPIs of all
queues. After this patch, enable_delayed_refill is stilled called before
napi_enable in virtnet_rx_resume[_all] but I don't how the work can be
scheduled in that window.
- Patch 2 moves the enable_delayed_refill after napi_enable and fixes the
deadlock variant in virtnet_open.
- Patch 3 fixes the issue arises when enable_delayed_refill is moved after
napi_enable. The issue is that a refill work might need to be scheduled in
virtnet_receive but cannot because refill work is disabled. This can lead
to receive side stuck.So we need to set a pending bit, later when refill
work is enabled, the work is scheduled.

All 3 patches need to be applied to fix the issue so does it mean I need
to add Fixes and Cc stable for all 3?

Link to the previous approach and discussion:
https://lore.kernel.org/netdev/20251212152741.11656-1-minhquangbui99@gmail.com/

Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr

Thanks,
Quang Minh.

Bui Quang Minh (3):
  virtio-net: make refill work a per receive queue work
  virtio-net: ensure rx NAPI is enabled before enabling refill work
  virtio-net: schedule the pending refill work after being enabled

 drivers/net/virtio_net.c | 173 ++++++++++++++++++++-------------------
 1 file changed, 91 insertions(+), 82 deletions(-)

-- 
2.43.0


