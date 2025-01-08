Return-Path: <bpf+bounces-48274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16B7A063F4
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 19:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A78487A36A9
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 18:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADFD201269;
	Wed,  8 Jan 2025 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HrjlfYt0"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1929F201034
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736359590; cv=none; b=uM/59UVuZJS61bwK3zHnZNPnliitP+V2U3vqml987i3WWXN6oLh5L3I/vNNHsGp5Dq3Ieqig2rhcYU6QHe/L3CNWspqAP8cpIuAnykuvg4Ojtt+U2CGuzme+iAxgQ7KCZCSiTOVgUPEEsVkO2Jc6v7571Z6AsU9ty/ZugdjzKPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736359590; c=relaxed/simple;
	bh=R4UWrVe5Gaa9ndThzF20AYFG7pj0l2pER0Xs1zgkco0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IFih2sosNVQNRP+dgpyP3BvU9GP8XQzWF/nC1QcN8RW9Sb3txXRbhMABVJ9XdwyyOlEZb0ag+bELPxpXXCuGrvBm+WtYQh+UyFiA71qZUaH8YDsn8Rn6jp8t+bzUhQsqljG3Ia1mSr4gIbHOIoaW3cRMmPZel/hlsV1uhuPv3pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HrjlfYt0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736359587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bnu+BVkl+Xe97p0gYpH/rg1OlF1/gslhVoAE9Hfv1R0=;
	b=HrjlfYt0KLTcc29FlJ/KwIf1xgpjBflRKVUXoPSGQuWFY0dpMdFWwg320w28pJNexnIVPk
	avnlq7gfKb/SI8GzghqR5XScIpk/wA/5avl8Wmz3KgwEYYzFLPY7PSrgmrT1GgZl4AotoI
	JWeNQXo22kNFoPJlM3GdMAS/ky2U7v4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-CyX0isHrMQOLDeqrECKElQ-1; Wed, 08 Jan 2025 13:06:22 -0500
X-MC-Unique: CyX0isHrMQOLDeqrECKElQ-1
X-Mimecast-MFC-AGG-ID: CyX0isHrMQOLDeqrECKElQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-436328fcfeeso888395e9.1
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 10:06:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736359581; x=1736964381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bnu+BVkl+Xe97p0gYpH/rg1OlF1/gslhVoAE9Hfv1R0=;
        b=AMbaUDxuQtwfbGogkGdptkBF7AAzeKWe2n+Xeksg58BUssa5YRuu9qXDhU1Al4N/lB
         aW3GP9e4hbo8n3/IIgmglFkp0C71zLP/YyYh4b8MzFqHl5j4u2K8Eacbm76uDb38ZFTs
         BKcMzNm6BiRIvsVIg1pUyx47MZzej+7mrygXTfKeJUGhC8PHNRa8KRyYfuojIFLRmuCl
         sMNGi6wtT6ksroLcTygkRrEE4PkNdcaztnjIBdIMzh4isIh0QN5gLrpxpLFgKfkaBdIZ
         maeJph7lp6Z6NIhvxf/RRUwJ7VzibQ2KacxhJL0mfu8o+cY61VGc56L+y/1oCuQzhxB5
         dH/g==
X-Forwarded-Encrypted: i=1; AJvYcCVNTm0sb56XOvXpLZ88TCkv5D1QSULdBjN6sWynX3ItmE1XvhP78XpHih6jgtWrDM+U0/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzePPq/b84hiTVudatI1ym/0nGiMphvWCnheQ8MAA68fxrOn0Qn
	vciMr61lfifAX/yKB+cnSTO/za56/MDAlzEL0RirPnvQqIlKqyH8RdeQadX9e4xwmE/4owQ6sPx
	ktZFggt99VWFxvqQoJkzamxwGtQw9/i1Lv2piUOEp3LL4KaWVkw==
X-Gm-Gg: ASbGnctJ+SXfnc6vDUwVSJ/XxiQXVXStt2OIKLdVxlZx82OGFaLb5KcBbxSJNq3MzD9
	0WAM18ZvY0muwNuLG4/bXoElysfOJRz/H2xt32AcEU/8U4j3Pb7pnjVCLkSGZuzCPLwU32F6igb
	21JH4WPclG9yIiQrtKkCqfU1IYSmf55qt/kn7zHop0hp3XXqjXzUp9dCKtuOBS3EbBLv5bR/kNf
	v5kD6IsdTcxeFl8PnrqH4jEueJ4nszXR+a8Q1Ah0pe+pQo=
X-Received: by 2002:a05:600c:46d0:b0:431:58cd:b259 with SMTP id 5b1f17b1804b1-436e26f4d53mr37946615e9.31.1736359581543;
        Wed, 08 Jan 2025 10:06:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPzI29sT/XCixMM7XrCBkXw/ioHXUjl2FaMJjmaMr+6Pqs+CX8MLIRg6SGkdexZ2/7lWykfQ==
X-Received: by 2002:a05:600c:46d0:b0:431:58cd:b259 with SMTP id 5b1f17b1804b1-436e26f4d53mr37946165e9.31.1736359580892;
        Wed, 08 Jan 2025 10:06:20 -0800 (PST)
Received: from step1.. ([5.77.93.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847d7fsm53389298f8f.60.2025.01.08.10.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 10:06:20 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Wongi Lee <qwerty@theori.io>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	virtualization@lists.linux.dev,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Luigi Leonardi <leonardi@redhat.com>,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Hyunwoo Kim <v4bel@theori.io>,
	Michal Luczaj <mhal@rbox.co>,
	kvm@vger.kernel.org
Subject: [PATCH net 0/2] vsock: some fixes due to transport de-assignment
Date: Wed,  8 Jan 2025 19:06:15 +0100
Message-ID: <20250108180617.154053-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.47.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series includes two patches discussed in the thread started by
Hyunwoo Kim a few weeks ago [1].

The first patch is a fix more appropriate to the problem reported in
that thread, the second patch on the other hand is a related fix but
of a different problem highlighted by Michal Luczaj. It's present only
in vsock_bpf and already handled in af_vsock.c

Hyunwoo Kim, Michal, if you can test and report your Tested-by that
would be great!

[1] https://lore.kernel.org/netdev/Z2K%2FI4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX/

Stefano Garzarella (2):
  vsock/virtio: discard packets if the transport changes
  vsock/bpf: return early if transport is not assigned

 net/vmw_vsock/virtio_transport_common.c | 7 +++++--
 net/vmw_vsock/vsock_bpf.c               | 9 +++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.47.1


