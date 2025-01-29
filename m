Return-Path: <bpf+bounces-50039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF37AA222E5
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 18:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 654917A2534
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 17:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290831E1C3A;
	Wed, 29 Jan 2025 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="xa8qBN8l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BEC1E1A16
	for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738171486; cv=none; b=gkw4es4Lln/e0gdA4AnTkxb/fFUSzceQaulYoIDQc8GIxVyKuJeov8ffjrJQOAesoC0HaIFVGdWTVOi3xSviIBxIb4z8yyzTqPVvH2/ngbbMrBVFKUNYT2zX5amqhib6c8kSXDRb9EGkaE1BOhAu128SfqNf6vbOzyMQUm6rO4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738171486; c=relaxed/simple;
	bh=N0YneRw92WXGIHdikNV2IiZfnjq0rTZVJ82U1x+yMTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nhvNDHaRHMJOflL4pQOwwMKZbybKFCvjTvbyql3x8hZwees7NEnwaPgoH/H7o4KLK2dfnFzhAdGzDbaTpWed2jWplxJeG+wIb8aN+tBoIcNg2+RfIn8HNwjkB+OUmmxl1PfQXatl8twuNCc+AX2eTEvcTZY3rQDKAZBpmd9di6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=xa8qBN8l; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21636268e43so12035945ad.2
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 09:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738171483; x=1738776283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aq4/gMpDYbPjuvYfh3I5NVoS6GqeADLR3UUjHmAsbcU=;
        b=xa8qBN8l2XoRvMYZwWZQJncjhJoLDsyLSgqNlpR+8hL6A3ivSynKS+K3QsamVnOjIO
         eDIduaBcHxNDObdNuWPYZNGjT/P8O8cJFJzKYyDzYrpdOzS38tggknJmNvH6RsGJ8S5D
         L37PcYrzG0S7e+Mve0XhvUosU3eVRqj3rfeVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738171483; x=1738776283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aq4/gMpDYbPjuvYfh3I5NVoS6GqeADLR3UUjHmAsbcU=;
        b=EZVFPqmDbIO9mkelT70SIIvPyKB1WHryViBjR6en3hqLEV9hJtCUHQGVViAifT8671
         HIrBF79XueLcIzPXSTFePmumqLLzLx4dmK4G2D1OHtIjYbBA0QI6ZK6Dl532jNpfcw8C
         XuRDCHore8Gn5IJEQLdyClpELy2VgDZ22pxBpJZAkVLyER2nf8mQRhuiFmfm0nvkRTyz
         3POJIN5PfPAkZZnXavSaC/Zx+dOM77PJufumGiujWcCj/lIVQV2zROmsFVn01hVW06SQ
         bXUdhSDdzgCrAcQG+PgT9g/7Q8qwcWShcT0K4VkyMDSAYUVZRFUYHxRS0PRaNA0CzxzA
         tY/w==
X-Forwarded-Encrypted: i=1; AJvYcCUxSuGLkA5ue8OSZNeLXlXliqeiPzsf+Jfb3CUnBtW2KfGKUptlfx/wUMFL2y08kqX0t28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8EKWK7rokunVDJ1mXsSTETxETGHJiog3AkS1SheGeaDaejn4X
	K/FxHonXUR+NVpjDvgAiJvrcU6z1bxWiOWTT4+AEwq2txqowRIbqFKshQGowcFU=
X-Gm-Gg: ASbGncvVBjTJ2rZkXKMFMGEqJrg1FNM8IjBs3BohqufxMcqS/r8rPDrHprZfrpZWVSm
	kG+WMA5VQ5AUwoG7PJhecS7b1KN3HVmlSIXnpeI1GronkP5wJKzSJdquNsXa85x2QRFyVJ9lRJn
	qWhJjsxgD+AjWPr3dq29uD3zrlcLH1BvzejXO1rbqwFn9pYrxLDBFYdbgUhu/JyyTDa3wPGPx27
	oBIGW9/G/wI0Exiu1uYcAICFl6Tf7etd4IhXvM7Ut8BdV2M6bF7Qg8c8HhOg8QUvbVBu24Jc3Fw
	5whr7UmteKv2NeOI0yfkj/0=
X-Google-Smtp-Source: AGHT+IFTb6XDnBS6Kmn63C4xyF4rg4Vtlz0IPi7h1hNldfq2r+c1V0Jig8cb4HmfqwS/oFthayJOoA==
X-Received: by 2002:a17:902:d48a:b0:216:4064:53ad with SMTP id d9443c01a7336-21dd7de20f8mr69481155ad.48.1738171483392;
        Wed, 29 Jan 2025 09:24:43 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4bc5c1fsm101147295ad.82.2025.01.29.09.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 09:24:42 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Mina Almasry <almasrymina@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [RFC net-next 0/2] netdevgenl: Add an xsk attribute to queues
Date: Wed, 29 Jan 2025 17:24:23 +0000
Message-Id: <20250129172431.65773-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

This is an attempt to followup on something Jakub asked me about [1],
adding an xsk attribute to queues and more clearly documenting which
queues are linked to NAPIs...

But:

1. I couldn't pick a good "thing" to expose as "xsk", so I chose 0 or 1.
   Happy to take suggestions on what might be better to expose for the
   xsk queue attribute.

2. I create a silly C helper program to create an XDP socket in order to
   add a new test to queues.py. I'm not particularly good at python
   programming, so there's probably a better way to do this. Notably,
   python does not seem to have a socket.AF_XDP, so I needed the C
   helper to make a socket and bind it to a queue to perform the test.

Tested this on my mlx5 machine and the test seems to pass.

Happy to take any suggestions / feedback on this one; sorry in advance
if I missed many obvious better ways to do things.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20250113143109.60afa59a@kernel.org/

Joe Damato (2):
  netdev-genl: Add an XSK attribute to queues
  selftests: drv-net: Test queue xsk attribute

 Documentation/netlink/specs/netdev.yaml       | 10 ++-
 include/uapi/linux/netdev.h                   |  1 +
 net/core/netdev-genl.c                        |  6 ++
 tools/include/uapi/linux/netdev.h             |  1 +
 tools/testing/selftests/drivers/.gitignore    |  1 +
 tools/testing/selftests/drivers/net/Makefile  |  3 +
 tools/testing/selftests/drivers/net/queues.py | 32 ++++++-
 .../selftests/drivers/net/xdp_helper.c        | 90 +++++++++++++++++++
 8 files changed, 141 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/xdp_helper.c


base-commit: 0ad9617c78acbc71373fb341a6f75d4012b01d69
-- 
2.25.1


