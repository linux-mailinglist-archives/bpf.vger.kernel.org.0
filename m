Return-Path: <bpf+bounces-75729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DF0C927F5
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 17:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449933A66DC
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 16:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EAF288522;
	Fri, 28 Nov 2025 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="NFV3bS0O"
X-Original-To: bpf@vger.kernel.org
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041D2280318;
	Fri, 28 Nov 2025 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764345923; cv=none; b=Vum1TBM1GcLIGLHPZaXFpo3nUK/EhlPvkhS+Tk9nI4vSrkduzPJ7MPVn/QuLaamAV7Exs10BiuvTMbMNncNV99GO6m7W3sviof8Zn1ktgIA5Y7DIcfYs6YhU2tflQvceFbJLRsv403jYazGLMd+CODsQxarl+W72jFyZDlbDRoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764345923; c=relaxed/simple;
	bh=WUSfGOXek6kXO/ahzPhHX8X+e5SuNLbaeNdNUWkfxIA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tTY8VSV8hJlDvJiowc/WRSKKWhKyXlkCjgfZSljMXTW1BCzLIltce7mEKmOHEzWyWCUq6IgHGmYLKi8o6LxeeSOxR63182f9apIrpptv6Dw6pIrlLBRyAOmrsCAWn3pKms1dLIB9mUTM1YdbzHVCZoTZlLad/AwpgMdOmifYDuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=NFV3bS0O; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1764345922; x=1795881922;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mT7+/9Q/P3EOLCcSyseZ/1663J1tCLxnRWyZm+KTF+Y=;
  b=NFV3bS0O7XiEB7lf7iQ2y73AFP7Er9KXJaXN3EtVjvtS/qXeJFZk0yYt
   QRjvmmoj82ljmZOeaJAyHyhucMQa4CTBewTOqmBTINlC/LaTGerEtUb6Q
   cRWoUDGsKiLyLXkbXzf/ONJqcyOhzQPiyaDOE94dWg9p1lz/xCUVR1aOA
   P69T9hHjXx3+0y/NS/b3RBeNWvOisypYtPzAL3ZEzG1+jAs7R2eicgUPO
   NyEVPLojhmvOpD/qoJBQ5n6JJRUhlw1GNiwGosyg+XJ52KXesT0RrcOqQ
   iK0jpAV3pX4xw5WMU69CWzMhdea7egM/Dkj5i1mPjPdTdZJOm2uzNX+sl
   A==;
X-CSE-ConnectionGUID: c1jPkwT/SeyWqUlh8fS4Eg==
X-CSE-MsgGUID: wtXHq+54RU6w1wSCkpWX1Q==
X-IronPort-AV: E=Sophos;i="6.20,234,1758585600"; 
   d="scan'208";a="8031299"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 16:05:19 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:6869]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.165:2525] with esmtp (Farcaster)
 id 6d8b7411-2d5b-4fd7-92e1-6756c1308f5e; Fri, 28 Nov 2025 16:05:19 +0000 (UTC)
X-Farcaster-Flow-ID: 6d8b7411-2d5b-4fd7-92e1-6756c1308f5e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 28 Nov 2025 16:05:18 +0000
Received: from b0be8375a521.amazon.com (10.37.245.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 28 Nov 2025 16:05:15 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Shuah Khan <shuah@kernel.org>, <kohei.enju@gmail.com>,
	Kohei Enju <enjuk@amazon.com>
Subject: [PATCH bpf v1 0/2] bpf: cpumap: fix error propagation in
Date: Sat, 29 Nov 2025 01:04:53 +0900
Message-ID: <20251128160504.57844-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC001.ant.amazon.com (10.13.139.197) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

This series fixes incorrect error propagation in cpumap and adds
selftests that cover the failure cases.

Currently, failures returned from __cpu_map_entry_alloc() are ignored
and always converted to -ENOMEM by cpu_map_update_elem(). This series
ensures the correct error propagation and adds selftests.

Kohei Enju (2):
  bpf: cpumap: propagate underlying error in cpu_map_update_elem()
  selftests/bpf: add tests for attaching invalid fd

 kernel/bpf/cpumap.c                           | 21 ++++++++++++-------
 .../bpf/prog_tests/xdp_cpumap_attach.c        | 19 +++++++++++++++--
 2 files changed, 30 insertions(+), 10 deletions(-)

-- 
2.51.0


