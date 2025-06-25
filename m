Return-Path: <bpf+bounces-61541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AE2AE8941
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 18:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB7D165199
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 16:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40E82C08A5;
	Wed, 25 Jun 2025 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U54K+onJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCB929DB99;
	Wed, 25 Jun 2025 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867800; cv=none; b=LMCE1N+JmMhyZO4Lfq3IFtTf/StMr41TIm5moPDlXkNLQlfxuBkGqrCFEzfSDYNmOtzuJital4MXCeD6TYioCDH/ZyoOEz233kqpsRt3YmyH4tOPAKTVtnKlHR5QxTTYs6Y3Z6d/g2uhE5On6rsVbnsbTQUej0mwj86csN4WcGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867800; c=relaxed/simple;
	bh=Bts4sKMHlh38RUT+rVnq3w77/m2jbHWWcUQgUFHHQww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GdmPihL5EJCUp2UmYozENaYUoar96C2qJW50SBcFZpNNSg8gnbqZS5kww8PsdLGHw1vtdV46PaXy4R54LGrilSvQU83wQmBGP712X0UWIlebWIvPYRckjjRP3jWE0N4tZrrUko3U9vWbphKakiFf39sYETiYMUw+HDyf6l5nfZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U54K+onJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22c33677183so772875ad.2;
        Wed, 25 Jun 2025 09:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750867798; x=1751472598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eb0acdpdU/b+qFj+DYgvVF8IZl61dx31CclH/vhkiBE=;
        b=U54K+onJB9SvbfAWu8BHLHhBtOBEKUKKgpO+jd3dBUM2r0xaZZKobwQYiypEB4sdoV
         C7oPr37iM+j1mjCM6XFaJsEGsEOgNLH7I/r99dwQVBpk9MxKUcBrleFAGtd3TGqTvQH3
         6u2BzDI3CrRnz8+JOzgwCOPG2NpbqHlmt7p7VmBHlzs7tzM4wVjMysjvdbZPBdkgQaTx
         ULzhbZIal1m8X2w/L2TepTJIFf9sU47Ibnbyk2wBbkWOHp0d0p7fruQyadQc3UZPSibf
         06QD389RtWQkIXvgZKtlBPzuY8aE+X1tBvemgZL+CQB5aJaGEth8zDslFDNEkByIjBy1
         atmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750867798; x=1751472598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eb0acdpdU/b+qFj+DYgvVF8IZl61dx31CclH/vhkiBE=;
        b=T4MzVbDFL4Y26i/RKSCSDBgr2AkRm+4aQzKaltN3cNfrSN8NfmVU80F2iGwHPOCTaw
         +E4/M91C2sLHkk97+tCH5pCjtb7oEPhjNzRXkoL/kNHZLVFIzPqF/wLZe/fpS6R/L1OW
         F8/EKMSWUXe0junC9hvpihsUbmJ9M+aQKSFkKVlWidJmYBiZLOJGMjpWn0H2G/PIG6xv
         +xkskG1ZNeYtLZqv0CdILP6ywcfdGmRyOXXQmYMRb+9Qzz9i+LV06F5Yi38mt9eBGs7v
         TqXapsZDboArCXV4uSn929CQNdvZ6T9H6DZGjnrwP6naDvEX0ZsjSorWYJeUe76qwBdo
         G5MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk0BdIykqT4tvwfaqsHBq3uYzzCImiL5L8jgzE2WKd6h5+8O7qISfPB0JDgsSkLT9tUk0=@vger.kernel.org, AJvYcCXS01gqLTzOJfmx3Un54IwSoQa85q6AHl3uzPag6MCDcmvzflDWuJ7RN8TqlH9l0mj7VU5VLkap7wCaK/Q+@vger.kernel.org
X-Gm-Message-State: AOJu0YxiT3CQe92Ega37STk0DgRwaK687gqxxGYuDPyIu5/di6G3hY5Y
	7EUGHs5BRkWPPbiBntDOgondptQcPnrA572Qei0wBOGYrUSN4VUskzZOCibe3g==
X-Gm-Gg: ASbGnctWBc9o9PYBNhMNxXVml29/Ex6NKD7LnD2iygBTyql0AFAg/VK1c/xh7Pg+BCF
	eeF4ntVaUgtfCNoFant4n6jY15/v/D7QDsj/vKRlGjd/xUv+3PZgPWTQN92fy4GbIuVzqBxWe1a
	sV3QimXcLkGkYhvrAkajz/8DVpHYkhPMkD8qxa7bGbZ5gRSZxbdH60Rh0zAp7ZKXJWIHrqsseZC
	WbZq6nl7TYT/9pt0b/uq1aeI0s3e5AtJycpRAkGLDKi/kmK/lJxHvjckzcY3bJ2Q54b+NxeRqF1
	CsFZO2x/9ghSAQ/GfkcCYeeGaIYxR2M3Sj7+GfGRv67v+xzODSznBEQ+87aEFTL7uoWxsVSIjH2
	8qQ==
X-Google-Smtp-Source: AGHT+IFGkbVCJI4WQD7GIL1MO4VOQNGAkZ5VrytP8PK7QMxS5HOrsRj0liKcJ/cDXDkibp5t5sKjLA==
X-Received: by 2002:a17:903:42cf:b0:236:15b7:62f6 with SMTP id d9443c01a7336-2382424be2amr48545785ad.34.1750867797808;
        Wed, 25 Jun 2025 09:09:57 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:1cf0:45c2:bdd1:b92d])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-237d873845esm143219175ad.243.2025.06.25.09.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:09:49 -0700 (PDT)
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
Subject: [PATCH net 0/4] virtio-net: fixes for mergeable XDP receive path
Date: Wed, 25 Jun 2025 23:08:45 +0700
Message-ID: <20250625160849.61344-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This series contains fixes for XDP receive path in virtio-net
- Patch 1: add a missing check for the received data length with our
allocated buffer size in mergeable mode
- Patch 2: remove a redundant truesize check with PAGE_SIZE in mergeable
mode
- Patch 3: add a helper for mergeable received data length check to avoid
repeated code
- Patch 4: fix the flaky drivers/net/ping.py selftest due to frame drop
when the receive buffer is prefilled before XDP is set but is used after
XDP is set. It's because of current restriction that
headroom + frame's length + tailroom < PAGE_SIZE. XDP does not have this
restriction, so we can lift the restriction here and continue processing
the frame.

Thanks,
Quang Minh.

Bui Quang Minh (4):
  virtio-net: ensure the received length does not exceed allocated size
  virtio-net: remove redundant truesize check with PAGE_SIZE
  virtio-net: create a helper to check received mergeable buffer's
    length
  virtio-net: allow more allocated space for mergeable XDP

 drivers/net/virtio_net.c | 91 ++++++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 37 deletions(-)

-- 
2.43.0


