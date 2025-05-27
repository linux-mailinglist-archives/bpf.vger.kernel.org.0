Return-Path: <bpf+bounces-59000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D499EAC52EC
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 18:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2DE1BA34F2
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 16:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FAD27F728;
	Tue, 27 May 2025 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLreZqh9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D507D27AC41;
	Tue, 27 May 2025 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748362771; cv=none; b=PpRuDGZsu/PmMj15T4Q1+FbTB6teGbvwqL4AxM8j5q1NqIZegyZiFQE2P+JE9pBmgyA3oO4ZFy2lD7Mkn97JagMT0AHY94DUf4I7Ili5/Vuq6KKwsdxCMK22DS4LcU/wM/384rkIHIqkK60BkiAtkTq+MjhaXx7lHK1OKA8WBiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748362771; c=relaxed/simple;
	bh=MYkd9moW5U5NY01cRCmj+VZ39AjPIlCw1sHRRMBFGIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jVazmjqr4Hj5FoZnjwjlGaBZaROFjCTRrm561wBvrjF4q1XgakBZsYJf17A2jAQVHJiNWXZXRvbz16NVtsrYgpXIKLp+zuM9sLGK2iZ19BP/MH8FqXaeR7GlDKcfmpmV1TgSl2l/HZE2WU+cpjydsUckiG6yAXC563/nPAwuIYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLreZqh9; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-73972a54919so2863806b3a.3;
        Tue, 27 May 2025 09:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748362769; x=1748967569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JbK8myrrInjlPOn0ULLUSRCNxSgmfdtmIhscGDFMnz4=;
        b=HLreZqh95zElkDtm6k9uGPrfEpCG9zlNUK/3US+F31Hbuu0ilDXdGPDx6C/2VTGaNn
         epx5OOGnoxjLBH7Siy+uF+fCJR+IW1kKn/MJUgbgvk8wuo3MO9rD8RhkUMI977liCk0Y
         W9BGl2teVnaY10qjm7kyH4qw52eWzMw3w7EejP/gxrzNawXY/EmUD4Xmcy/oOCyin0sj
         HcHgjGdKix4NSvtb8OOxdjZp9CGQp5+0M83lqaP6GTEm51Oi9/DblTKrH2tVaHfuKpMN
         jv0D7J/ke3qkJrDyngqwXq0R0gTqZi6h0Dlp+sLkyF6fkc3VILrL/4g0+LQXgoNh1VF1
         X4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748362769; x=1748967569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbK8myrrInjlPOn0ULLUSRCNxSgmfdtmIhscGDFMnz4=;
        b=mBo8/4wMmcv41e9yGrfWnUGR6YxV5haj9bmoNxRVzkpp/B20Lu4ZkvrwTvZWyt9TGg
         U/tXclEVQN0DZW/Yctx1GCfah8MyjPKpcQ+NGhCCCH0onUhQLFvVwUCm0fG1BNOo79zW
         m73gCaxV1Elwvj5+/DBCs7xsrydo16k/sP57AQzWHJIS+Ba3encwcUsMBMJuuTNJeviJ
         4NrFOCYEB0BpnjqH72YdqRSwjR6l3rZn4TsI2pKZwh3LrfaV726fiz3JyNyD7z7IlSI1
         sGaFGPGKLeklatwEmSexHv0RVMtVkyBVfh6hGGjZR+lkR6ahBDl9+umxKFQpvRxjxHgL
         ni5A==
X-Forwarded-Encrypted: i=1; AJvYcCWc29S8eJzqpsYQEzquGYDke0Q5PyJPCI6lOO0ei/HgP92FYyU+TR/uCcWY10MYIy0dGZ6x/ui8qHRGCDHs@vger.kernel.org, AJvYcCXsmfEmMEI0zDyIl6WgaFDzelw7/MmrtIBw+FTjndrEyvuCndooiHkyqqHH5dL6pDjdshM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznu8ITteJOCwzGyepPpAQ0Pn1zkURbNbZqpsudeQHoSryWyVPk
	2RJUATljbmIy2oWCSnoMZkNENPVbrDEecqz01BP49vy7C5FiaXMtvzrBb9MDjd4fvMo=
X-Gm-Gg: ASbGncuEBhCaYIjQQPGHXc7mmQJmO6u5Vwj0TZ233fFbsQdaLjyTaolo/fPQFGZOYWV
	wAPMrst2gzFxXJ+mXdua/XXZ0myTLmWQdS7QKbGEyWouiCmG6q+DgtnSvg1Z7jwAzGbNfWwFIuA
	r3fCZZG/JhGJnDo3PeUGl/vOrFe3w3Pw8fMvn8YVmMFWne/xiUUkQIHf4bqXgnADAs7Rh9/HfSS
	bls7Q/VzzpBS4nhMl1G0BFWmlPkaVXl4zBaL/o7+GxyEAEhyJAuSFYc2CUWxDnO8d8NtJTf9Gp4
	hPANxGHPP8KfXXM10brgQuazrhNweWOCifg7WUPciq3jQz22E5xdYfpaXTJTMjvc4+xlySx9tPR
	Jbj7wRPUtNN4K
X-Google-Smtp-Source: AGHT+IGKmD2Zh5VhkMaiEIal6sHXDxc0tkPGQBPjYF8Im8Ox4Lf/IgC3904Py2SWs7grtFnUZ9zcQQ==
X-Received: by 2002:a05:6a00:1747:b0:730:75b1:7219 with SMTP id d2e1a72fcca58-745fdf4b8a4mr20489480b3a.12.1748362768405;
        Tue, 27 May 2025 09:19:28 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:52e0:fc81:ee8a:bb3f])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7462aefb414sm1118121b3a.34.2025.05.27.09.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 09:19:27 -0700 (PDT)
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
Subject: [RFC PATCH net-next v2 0/2] virtio-net: support zerocopy multi buffer XDP in mergeable
Date: Tue, 27 May 2025 23:19:02 +0700
Message-ID: <20250527161904.75259-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, in zerocopy mode with mergeable receive buffer, virtio-net
does not support multi buffer but a single buffer only. This commit adds
support for multi mergeable receive buffer in the zerocopy XDP path by
utilizing XDP buffer with frags. This happens when the MTU of tap device
is set to 9000 so that a packet can exceed a single XDP buffer. As a
result, that packet will be split into multi buffer XDP.

This series also adds the test for virtio-net rx when an XDP socket is
bound to the interface. The test exercises both copy and zerocopy mode. We
can adjust the tap device's MTU to test both single buffer and multi
buffer XDP.

Changes in RFC v2:
- Return XDP_DROP when receiving multi-buffer XDP but BPF program does not
support it
- Add selftest
- Link to RFC v1: https://lore.kernel.org/netdev/20250426082752.43222-1-minhquangbui99@gmail.com/

Thanks,
Quang Minh.

Bui Quang Minh (2):
  virtio-net: support zerocopy multi buffer XDP in mergeable
  selftests: net: add XDP socket tests for virtio-net

 drivers/net/virtio_net.c                      | 123 +++---
 .../selftests/drivers/net/hw/.gitignore       |   3 +
 .../testing/selftests/drivers/net/hw/Makefile |  12 +-
 .../drivers/net/hw/xsk_receive.bpf.c          |  43 ++
 .../selftests/drivers/net/hw/xsk_receive.c    | 398 ++++++++++++++++++
 .../selftests/drivers/net/hw/xsk_receive.py   |  75 ++++
 6 files changed, 596 insertions(+), 58 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/xsk_receive.bpf.c
 create mode 100644 tools/testing/selftests/drivers/net/hw/xsk_receive.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/xsk_receive.py

-- 
2.43.0


