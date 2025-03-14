Return-Path: <bpf+bounces-54024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FF5A60B1D
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 09:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4AC19C1ACE
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 08:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2BB1A257D;
	Fri, 14 Mar 2025 08:20:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B8D1A23B1;
	Fri, 14 Mar 2025 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940414; cv=none; b=PWnM+ThG+wqpkKTa8xsvAOA3bjAk/ZPGRRtgyKy8ov5RIMdq9ZyK2XbBWYAFU7ML9ya8UF7kzKW3Hv0vGCmDzI1GiC/P8TnTZnouFNyhLVKPdOxo3JzTn2YmmMb3tEsX3vQbKvKp5zQlJX5R/5SPCdB12Xeg9TeeNXDmJSDawjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940414; c=relaxed/simple;
	bh=rKphS0SrsLotig5CPwXIlymGuJqFQEK1x8iV6oo9EbE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mMBvrktTV0zR+9Fa7bYqIfbLHqT9JN3/xnDmNHhdhExBHsbd0ID+csiAdi1OezSHzgABNN7P4bkbOJ7RzFI2UQB+fq1n8AfpIG0HaZpm1RFM3LCSmMQAx3eypOzZmRZBwzFxH02E940JGwvhgA4uM5+8SOBBRn3bffhEQ2Y23ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZDcjt48qyz1d04P;
	Fri, 14 Mar 2025 16:20:02 +0800 (CST)
Received: from kwepemd100023.china.huawei.com (unknown [7.221.188.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 84ED8180102;
	Fri, 14 Mar 2025 16:20:09 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 kwepemd100023.china.huawei.com (7.221.188.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Mar 2025 16:20:08 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <edumazet@google.com>, <kuniyu@amazon.com>, <pabeni@redhat.com>,
	<willemb@google.com>, <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <horms@kernel.org>,
	<daniel@iogearbox.net>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <stfomichev@gmail.com>,
	<mrpre@163.com>, <xiyou.wangcong@gmail.com>, <zhangchangzhong@huawei.com>,
	<weiyongjun1@huawei.com>, Dong Chenchen <dongchenchen2@huawei.com>
Subject: [PATCH net 0/2] bpf, sockmap: Avoid sk_prot reset on sockmap unlink with ULP set
Date: Fri, 14 Mar 2025 16:20:02 +0800
Message-ID: <20250314082004.2369712-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100023.china.huawei.com (7.221.188.33)

Avoid sk_prot reset on sockmap unlink with ULP set to fix warning on
recurse in sock_map_close().

dongchenchen (2):
  bpf, sockmap: Skip sk_prot ops redo when ulp set
  selftests: bpf: Add case for sockmap_ktls set when verdict attached

 net/core/sock_map.c                           |  2 +-
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 70 +++++++++++++++++++
 2 files changed, 71 insertions(+), 1 deletion(-)

-- 
2.34.1


