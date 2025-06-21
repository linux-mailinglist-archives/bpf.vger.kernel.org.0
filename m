Return-Path: <bpf+bounces-61232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F0DAE2996
	for <lists+bpf@lfdr.de>; Sat, 21 Jun 2025 16:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067ED1897D7B
	for <lists+bpf@lfdr.de>; Sat, 21 Jun 2025 14:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4A320E034;
	Sat, 21 Jun 2025 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtMrtQ0k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FCF182D0;
	Sat, 21 Jun 2025 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750517474; cv=none; b=E+r1qHGDu38tFqB6jhPVnTqjhzOIhYhmy7Tjc+Chj5NNoEv/tWEkwb+AN8p91rtNA9y/OIBA4//o4Rp9AZYWluwlrY5VRZTANOQErtkQ5QM2TzS/2QvR30QmU7EeC/hl4GQtNDoZPLXSxgYumCqCm2drnqnRBuyebfWNE8CGI8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750517474; c=relaxed/simple;
	bh=ia17Jc8KljfUY5LX34txi7oz/NXd5s4Mq/JQS8JpB7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ld8OYIYzyQqJm+XMd/TMRAn/+Fow45NgyR9d/88BQXUyAU/LJ4lhazYbn107DT4qWPzUt9AZcMN6JVQ4HaY2iSrw72W9ZPrsWNrhCbbSNxhPM1i7lDp6n5+bXUJ5e62IBmx9nUnz27lb3NnHBAI4lbi4KbI01nGFZYkAHCb9a0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtMrtQ0k; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7490cb9a892so1035480b3a.0;
        Sat, 21 Jun 2025 07:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750517472; x=1751122272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3iFx7PXU29VvAkNai5SF5w5OP1DtkiEzyXPQbCXksko=;
        b=FtMrtQ0kmcYB00ZmryvLB63IFcSPzM91Kx+Zm9CSn47u9nlX6C64IAMwjig1rFBvQS
         GBWjwbvVarGiXdLgOUbAeHgeTGu8YvPNSAFy7lYxbK6yUQEJmuScnv4cHShm7RzwRXFt
         HkyYFLEqURNriOyaL/V4El6QlvBCnHEwCpGGU8xf9nCmmcEv9vbogIayNf4zn4jgfkLZ
         /elW3Lg9ZRfTCdF7XNlWAYCIN0inw9wldkSItMs1HDYcNLfZ12OhY2RSRVppCchfzDPa
         EeZjsunj95RmHvcZ7RJlsJ0xcXRPTal/FxKpkyYjtxs4Obz3QxdzYtU8Xb2RVLMEkgAi
         57/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750517472; x=1751122272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3iFx7PXU29VvAkNai5SF5w5OP1DtkiEzyXPQbCXksko=;
        b=oJabDeegBB+b+SC/dSpvZdA/0N2lKKIi3YkquJFSVXgrXWZE2JSf3G4GrrVWmKj7Ko
         AZFo/FXRsuKi5ac150PzLb2SIU9DOl5BtNUDEZKFPnNOFZOifMAB6vgbom7I1fhMJsGw
         NngLRcy5F93edEtaPGBlDLnR3CLkcIMno4/I6W7JqzNqO6qOo84vuenyf8m+6XruPgt+
         0mGjFo4WywSiyzztydNx3PELQgK/XDKnq3yHXV1RClUCTBQZPxTY71D2BcwHPgOjkt9Q
         JuSJptxfOKEWN20uTMSnT9kyz41rPtuwLf1gs1IMzoyVex0EuEsEkvlY+/+b4ifp5fOb
         75cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqGEN3U2LljjwRJbI1UxTR+gHqwjSPTDxphBFDeAcqX96Cspd1EQpGgX6pJZNDEoRNBrhTAuRQYeiVUPq3@vger.kernel.org, AJvYcCXwmmNczPp7kCWIfCkEX7G7tFkwKy3ffVO1I7RRU/AeEPGuM+BjVyXt4daWviUKNs0Ffo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGY/xXKvLTmBrXISPBSqM+3Wvs+7MyI/2wYkg5gNE6B6dh0gBk
	Mh2bjoIHuSCBI5Tv23ZDDOysTfcoin2n6APpWdrEel1xK1ViA2iLwTuX6mZk2ik5
X-Gm-Gg: ASbGncvXiKKRQmxBTROHE/WIWhyN9AgnQrufRKP8qMIdNVZglKJEZ5uGli6ZJtyx1o+
	euxr3CpKZ6CpysCncdhaJClG59bwyGzo5mwj9ozb/L/YgukDYl1PzYnKk8WuuJ57/tcs2Eb4NU+
	dxznsNcdqZPXwRWKHZ6cERgsgvtgv5H4E6XLEw6iO6MGZjFDJavCmzHo1YmJ0agBy0BNi3fKgj5
	X3WzZ4KFB9XuYXu5r1gkK2CHNWRf522K+d6zF8BqlCUY5teVvwE48iIQ7VAm/9L3M1Mm0CtXpYQ
	lyyG50p0GcIQgtSUeIO3Au7CDmZMQ6ssfSji6blh7AkJvigcde1h5bCxLVi8+ZSPnFReeRGPvqe
	tuw==
X-Google-Smtp-Source: AGHT+IFuhiIhPgNz3xuopTzAVzt6+GxUMmMnJ9p90UmrmgAL4UiXbuo7pzh61wdir6s3OAAzbA4oEQ==
X-Received: by 2002:a05:6a20:a120:b0:220:105b:46dd with SMTP id adf61e73a8af0-22026fa9d88mr12058955637.36.1750517471900;
        Sat, 21 Jun 2025 07:51:11 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:fea9:d2f2:6451:ed3b])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7490a46acf4sm4493490b3a.11.2025.06.21.07.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 07:51:11 -0700 (PDT)
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
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net v2 0/2] virtio-net: xsk: rx: fix the frame's length check
Date: Sat, 21 Jun 2025 21:49:50 +0700
Message-ID: <20250621144952.32469-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This series contains 2 patches for the zerocopy XDP receive path in virtio
net
- Patch 1: there is a difference between first buffer and the following
buffers in this receive path. While the first buffer contains virtio
header, the following ones do not. So the length of the remaining region
for frame data is also different in 2 cases. The current maximum frame's
length check is only correct for the following buffers not the first one.
- Patch 2: no functional change. The tricky xdp->data adjustment due to
the above difference is moved to buf_to_xdp() so that this helper contains
all logic to build xdp_buff and the tricky adjustment does not scatter
over different functions.

Version 2 changes:
- Patch 1: fix kdoc

Thanks,
Quang Minh.

Bui Quang Minh (2):
  virtio-net: xsk: rx: fix the frame's length check
  virtio-net: xsk: rx: move the xdp->data adjustment to buf_to_xdp()

 drivers/net/virtio_net.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

-- 
2.43.0


