Return-Path: <bpf+bounces-49843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ECAA1D30E
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 10:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B0E163D62
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 09:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D32B1FCD13;
	Mon, 27 Jan 2025 09:09:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B79D1FC7CF;
	Mon, 27 Jan 2025 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737968991; cv=none; b=asZ9fuxD6raM0ZOw83dq0VHSAfD4quw6Tg9LZBqFGh3+pV9mI2YXhOGgzlyDek+XrMTTr+pjfBlLAhBt532yxsU3B8IPvGozgVPdpTg/sl+frqYU4GyTgbBw3mdFj0oIojRg2VmQ9azSt9x3FqUVMQcT3eFHGxScmOi6a4h2gk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737968991; c=relaxed/simple;
	bh=7rPK7uq4/ip+rhTeV5DSAFqG/1CeRak4SE9FL9IoZ8Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YZ2K25tYVkXk5NKe5jxclGPn+q1tE2eWSG9eWOEkZMeZ4GC4Qj5Mbi52eP1zaeMRUVTe8NGYyODweH+jnI2w3g+9OH+DOPbEHaUQOx3wWrEet935Hrhpk3n4/sMOzZ2c8Xq6sfV1lZaG2Ro42vC1sMKigTfmbubrM8GBwhxknsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YhMz56xWQz1JJ79;
	Mon, 27 Jan 2025 17:08:33 +0800 (CST)
Received: from dggemv704-chm.china.huawei.com (unknown [10.3.19.47])
	by mail.maildlp.com (Postfix) with ESMTPS id BA9EB180042;
	Mon, 27 Jan 2025 17:09:39 +0800 (CST)
Received: from kwepemn200003.china.huawei.com (7.202.194.126) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 Jan 2025 17:09:39 +0800
Received: from localhost.localdomain (10.175.101.6) by
 kwepemn200003.china.huawei.com (7.202.194.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Jan 2025 17:09:37 +0800
From: zhangmingyi <zhangmingyi5@huawei.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <yanan@huawei.com>,
	<wuchangye@huawei.com>, <xiesongyang@huawei.com>, <liuxin350@huawei.com>,
	<liwei883@huawei.com>, <tianmuyang@huawei.com>, <zhangmingyi5@huawei.com>
Subject: [PATCH 0/2] ipv4, bpf: Introduced to support the ULP to get or set sockets
Date: Mon, 27 Jan 2025 17:07:22 +0800
Message-ID: <20250127090724.3168791-1-zhangmingyi5@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemn200003.china.huawei.com (7.202.194.126)

We want call bpf_setsockopt to replace the kernel module in the TCP_ULP
case. The purpose is to customize the behavior in connect and sendmsg.
We have an open source community project kmesh (kmesh.net). Based on
this, we refer to some processes of tcp fastopen to implement delayed
connet and perform HTTP DNAT when sendmsg.In this case, we need to parse
HTTP packets in the bpf program and set TCP_ULP for the specified socket.

Note that tcp_getsockopt and tcp_setsockopt support TCP_ULP, while
bpf_getsockopt and bpf_setsockopt do not support TCP_ULP.
I'm not sure why there is such a difference, but I noticed that
tcp_setsockopt is called in bpf_setsockopt.I think we can add the
handling of this case.

zhangmingyi (2):
  ipv4, bpf: Introduced to support the ULP to get or set sockets
  add selftest for TCP_ULP in bpf_setsockopt

 net/core/filter.c                             |  1 +
 .../selftests/bpf/progs/setget_sockopt.c      | 21 ++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.43.0


