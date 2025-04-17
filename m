Return-Path: <bpf+bounces-56108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2820A91539
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 09:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC993B8A31
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 07:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF37222566;
	Thu, 17 Apr 2025 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCNgSEc4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7141E2222D5;
	Thu, 17 Apr 2025 07:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874980; cv=none; b=UUitoppi7tefHV0ggen2+5Msw7+0CTBFPWrWJV2ZqeiNbqshzLtZ3Px+3Tal5K/4eBAQuvW0+zjs9E9UrenBMHDKKbyYaJEiAKRjnD4urba+Qyt9rLJTHQBd26rhBQkLwyghmwEoM8+Z2wLHIfdiwvse0YumKdBrUbK6dG3h3Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874980; c=relaxed/simple;
	bh=NzBtddZRCsg1/4g3wwT54tpCt+iF1Q/Oq+nE2yGOUck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FA0QBoogf842MeXSKMM/xCZX/jj2jP46itiwEl7Z31jd9h6yJIgrcwQTeW/xpJA8rkLxHg0Nx0Ae1n2EyEEy6BtpsnpIKfBT0YuMqM3EVaarDUsPVHsZQ9ZmiG/pQpKUpA8AJNvtT/USO/hMUgFH2LtG+Y6QqfCvK66W+QKJhqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCNgSEc4; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-73712952e1cso350654b3a.1;
        Thu, 17 Apr 2025 00:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744874979; x=1745479779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wxx88K9tSumEw+2ZtRWFe/vr19Ozn+M+DEZTmr3En7Y=;
        b=lCNgSEc4/4oKNxcSBYoirovgCC6mn7E/+Y85xHD2FusUH8XcD1k7RtD5M726hgT+Cv
         djcaN6EG3yK76OntTXWXGKvVcZAbaGtbB1il9HxS6jF3dxLCmY75BayBHExofRb2MfoM
         fesgFhInI+FHYAp8I18rsRic/9pkMsSB26NLHZbpBi4p++MLdPCBAJhWga9I8SB/3qWF
         EYluZ7IFwXdxtWXkv5aLwNu06zxKrYxqRgcdWhfOVjgUK+Sy35KmWaOq/w3ANTRrUGOv
         sBP4zbuhpHJGl2f/GcIvcvzZVinFLqsNYtZ6wBnhQMfUqXycJ4j/hUu0hIyhJj2Zz6eu
         9o5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744874979; x=1745479779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wxx88K9tSumEw+2ZtRWFe/vr19Ozn+M+DEZTmr3En7Y=;
        b=qiOKjZThVVbaGFXx9Adz0aegB+6u4XbCr92YPF8NR2vl2QzppEM27vDfW567osRujl
         4+nkHeJENO7lPgcWoW3icxEQiIu4hC7uL77azbjxCTuGzKqnHodY7vBlQCKgktNAljXa
         0B5NrX7IJCdHEoUSnOLbJ9xtZWzapfewDIRehAFM8T3B+EpwF34VzMIXljhtcvcKOGKC
         w3nQfV++QoubJ+4tENYFJa2Vs3ui3yW3331QUtH2fzw4rV4PdytsagiCZp51Fx14f293
         KNsQDZ8vwB/ZqryCWseqbw68qhorFXAlpwMCI0jyZF/f++ytovwlQ7CeGdL1SBM7nJ6+
         ko4w==
X-Forwarded-Encrypted: i=1; AJvYcCUmiwXnx2cBrunqiYZBmzxRiA3/SQ+u18DRxnMT7iVAVDMlDPFALT7ZV2td3iuRpmMI84kHFdxJke5DjkbD@vger.kernel.org, AJvYcCW3gr6aNtitNVv0fb125iZ8r+lwNwjY4uzr6Le/fnvtLXzr6B6ytD06vUR9bHeZG8ehSsiv312e@vger.kernel.org, AJvYcCWVjiHpFwlOJ+R9KOPMr0Vj0Gpikpt5svO7UdybEmeWsJhm/mpjEetgCPjwhvzUbxvzCG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxz9QAALC6ZbEcI/EK0kPmybcANjj0ZD4xs866Eb66N0TVzlQd
	LE73Ojmwyh1M/jREfh4Fx9uNyRG6OuYYQ0CywfeZgMkuuOVxgppi
X-Gm-Gg: ASbGnctBkEFiqGeK76TnwlSFqwqVac6Xal3FfMFxf6m8MS80f+oh4xB7QUsJZvZtZcD
	RDipN+OkolT9QFF3zxaI0mL4mDxv36qEf1HifQglX8X4Dj0GioN6M861ezMq2Y2FcsTsXTtjyLg
	2HF0m1uFQcwuXLY4Q3NdRR7RdGoBoC8RRpoyAe1pe9cn1Ecv9DteR0rFA0qATxkcRoHaN3Pf6ov
	2NCzmEq60ceLpAbT3FkPiIOfmT2mA/LmDSlg9KQDF63EbTSHxGzVFnLNY4kYaCvuIZedoIIvQr1
	lBmbE0JyYmqS7mVOtNM6tglCQFaSvgi+eGkO9FYpMjyshULmeOzUBX46
X-Google-Smtp-Source: AGHT+IF/swlYlHVVTdpnx/l1Jc8S2a9LeAy6m92Hd3dKyvQqvGjdPqWMZCjUUCXypFPFgGvgke5VPw==
X-Received: by 2002:a05:6a00:3e27:b0:736:2ff4:f255 with SMTP id d2e1a72fcca58-73c267c183cmr6529845b3a.15.1744874978576;
        Thu, 17 Apr 2025 00:29:38 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:ab45:ee9c:5719:f829])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73bd22f0f3fsm11625344b3a.115.2025.04.17.00.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 00:29:38 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v4 3/4] selftests: net: add flag to force zerocopy mode in xdp_helper
Date: Thu, 17 Apr 2025 14:28:05 +0700
Message-ID: <20250417072806.18660-4-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417072806.18660-1-minhquangbui99@gmail.com>
References: <20250417072806.18660-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds an optional -z flag to xdp_helper. When this flag is
provided, the XDP socket binding is forced to be in zerocopy mode.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 tools/testing/selftests/net/lib/xdp_helper.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xdp_helper.c b/tools/testing/selftests/net/lib/xdp_helper.c
index aeed25914104..6afd77bfbe8b 100644
--- a/tools/testing/selftests/net/lib/xdp_helper.c
+++ b/tools/testing/selftests/net/lib/xdp_helper.c
@@ -81,8 +81,9 @@ int main(int argc, char **argv)
 	int sock_fd;
 	int queue;
 
-	if (argc != 3) {
-		fprintf(stderr, "Usage: %s ifindex queue_id\n", argv[0]);
+	if (argc != 3 && argc != 4) {
+		fprintf(stderr, "Usage: %s ifindex queue_id [-z]\n\n"
+			"where:\n\t-z: force zerocopy mode", argv[0]);
 		return 1;
 	}
 
@@ -132,6 +133,14 @@ int main(int argc, char **argv)
 	sxdp.sxdp_queue_id = queue;
 	sxdp.sxdp_flags = 0;
 
+	if (argc == 4 && strcmp(argv[3], "-z")) {
+		fprintf(stderr, "Usage: %s ifindex queue_id [-z]\n\n"
+			"where:\n\t-z: force zerocopy mode\n", argv[0]);
+		return 1;
+	} else if (argc == 4) {
+		sxdp.sxdp_flags = XDP_ZEROCOPY;
+	}
+
 	if (bind(sock_fd, (struct sockaddr *)&sxdp, sizeof(sxdp)) != 0) {
 		munmap(umem_area, UMEM_SZ);
 		perror("bind failed");
-- 
2.43.0


