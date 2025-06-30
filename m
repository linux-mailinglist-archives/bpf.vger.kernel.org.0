Return-Path: <bpf+bounces-61851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FB6AEE212
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 17:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915BF3AAFF6
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 15:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6B628DF07;
	Mon, 30 Jun 2025 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVnM5hXu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B3728DB58;
	Mon, 30 Jun 2025 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296418; cv=none; b=tA1u8eHjAZstURJGu3aJ33uwbJB23M7zMcBvMHu69GK1a2xTKEHb9hJ2xCQsvCWOcU4fkruR27B9AUeu5ruYVPrM9wOqI52n0y5YBtqnuMlpt/DL+R9Htjqxa5lvW2xn1HgVxGW5YyouTV+FImYAbZr88+Y4GUJhMfwCaMDwCoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296418; c=relaxed/simple;
	bh=k58GZuJHYrRAhM90IDPE06kWAdBsf2cIPBiCOV5OIrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tn8ebZSuAtPCogSevmU7v1SYGPA9NxmiPrEC5jMjzCua8TLUftsz06nxItfddbBDC7IsA8w5L1S4uPDfvHn2j9FiEylWHUUrPWfK8pBsUgzjYO1IqjP4KNjCoyPbFHa4oaiOOqF7vjhmuqjbrPlazJ1xQbJ6zTNOk3KvfFaZDqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVnM5hXu; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7490acf57b9so1640330b3a.2;
        Mon, 30 Jun 2025 08:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751296416; x=1751901216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NlH2qMX5NPIfuMoovjH0+8ChqNtC7Dxioix+iTeV5vU=;
        b=eVnM5hXugdFhPS/48DKqRjQxRbtOPzmXKCCMmVoGcPlzVJGDdDTfLHGOoLagPC8Rmq
         1TUUZ4lebUD+sNmiRDpGVgrWMPecJJ95z9r1ot0+ta2wfyjqEtpxPJbKIvGP9yUBVxhk
         LD5eihPEB6bsC046Fz1VhPQujg4G44ZBfln50z6S3OSVigoyBWTF796YGqQOJUt4AoOj
         kr5+D37KnCywi74qiFMskCmBActtFonNKTrw12hvbPwt+VL23jT1wi3NXnqHmqqlCTXN
         Ye4GFhfKvATCA5+jBipd1PPrjWoA6PEC0hoYHxOMuQVy8SFOBGtF/h3CaH5oaDloEi54
         2kTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751296416; x=1751901216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NlH2qMX5NPIfuMoovjH0+8ChqNtC7Dxioix+iTeV5vU=;
        b=K+JQsG6l6gVrg2HpKqfe0iiiRFYL7srmhLwgpDd93ii6J+UUWTNttHXFdjqrfKkzZr
         o2bzQi0ZlM4eoxhZwe4Bzt2ucbbbJx62e211iNudnpq1jH/Eycumq+j3uJiZDm2EQ+en
         Sk66VbI34gdGJjv68iIFZTwT0wORK5gcyGTXMiGNM8CHBYtNgufHnXvjbw4T+IHpxLBd
         sqdBh/EiDtrKR17Shq6Llx1KJPUKXJzdlBvkdtDxmvYLbWk0NoGlOfSCqx8CDKil7Joc
         GWtfqTGGyMDdN2ik+Yy3vwy4ZCFuUDRycdPpQl6Hq9bNhQNZKOZG0Np4ZlyTGGbquiDd
         nXHg==
X-Forwarded-Encrypted: i=1; AJvYcCV4iGN4iNHnJ6mGnBSaqHSS6XpkGybt4l2qVfvHClszDPYlX1TUHVMpdUw8QTAL8ycvZ1FUGjQn/I6ghtnw@vger.kernel.org, AJvYcCX+PBLrTxfT5JZ9M/g8ZqKt5wVy4Zx9jsvib0WlpQpXv9qFMh2aFsvN3NeNzKfDDVcTtcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAC80asjNCLmlfWbruBytAHSJbGzomzIa9gnmNXMkvzEMJlVcf
	l8nZnUOgyEWiTB9zHroWvvTTx0ybmHiMIQ+RirwNJTYBsPD/v3LbJ3feqfTFNg==
X-Gm-Gg: ASbGncvXwBBijW/AGU4Ep5vRdu5e1A1FWylxbD7PGVGgDrZwRFpx0wLe4e8tmaBPwMT
	tY704A23JIgPX+m42AFZOJfeumZ8E9ildtSHxTTbzOBquB1eBWdZkio/RcNELBMS7Pde2b7qU5E
	5RcbBRzozu2rAqwIsr5eJdKkHMNKA8baj1DNoxaPh/KR5gmhAwSYvout7kKL1qWi7tw8rs570J/
	FGY6TQfiV2eNrjOsiudg0x+Xobw+EHzoaiYR2qbzcFx2H7f92ePKTf/i8zO74GEkeS9ZysJdxOR
	kF8vCEct5GKTH6cfCEDNQP8Y4/jzdeph+Hw+OVPN5y+OvZfuufdYunPTcDXaZzoVjaCdsrULgf/
	p0TEN65YELl4=
X-Google-Smtp-Source: AGHT+IEHjdsV4PX3mnbaFgc3eupt/9KtFkjn673YTl/KgF76XdRC/TOJHwt51lirmUp+LYcjy0ZpgQ==
X-Received: by 2002:a05:6a21:9ccb:b0:21c:f778:6736 with SMTP id adf61e73a8af0-220a16ebad9mr20642436637.27.1751296416016;
        Mon, 30 Jun 2025 08:13:36 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:2f51:de71:60e:eca9])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b34e31bea17sm8323340a12.46.2025.06.30.08.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 08:13:35 -0700 (PDT)
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
Subject: [PATCH net v3 0/2] virtio-net: xsk: rx: fix the frame's length check
Date: Mon, 30 Jun 2025 22:13:13 +0700
Message-ID: <20250630151315.86722-1-minhquangbui99@gmail.com>
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

Version 3 changes:
- Patch 2: use xdp_prepare_buff helper to initialize xdp_buff

Version 2 changes:
- Patch 1: fix kdoc

Thanks,
Quang Minh.

Bui Quang Minh (2):
  virtio-net: xsk: rx: fix the frame's length check
  virtio-net: xsk: rx: move the xdp->data adjustment to buf_to_xdp()

 drivers/net/virtio_net.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

-- 
2.43.0


