Return-Path: <bpf+bounces-54917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2779CA75D91
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 03:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF6B167D89
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 01:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4620345009;
	Mon, 31 Mar 2025 01:21:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C30E33F3;
	Mon, 31 Mar 2025 01:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743384115; cv=none; b=oFRffDRGXOIhyMphIY8JrTOp0pr7YYTaZZxSgYGulwD9rw+85dL+9vivNjGz5yPFE6JOlukMIftAvcG3nggtR2jqgavVI2JUs0x+HafcnsNTbE18IWfpH8kQ8EtQ3yQM6QR4oFYEmR5J8X0jF7RPputrDqdiYPwbXeJFC6pcW3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743384115; c=relaxed/simple;
	bh=rt++s0TO7884PfQaebthhvekwVlfO+m0f55PE/NC7t8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nfViBF8CD9PNhqlkKHEk0iU148oDJWNIfu9L8VvIeoN+6XamVgQunFvgxzQr/Xi6UCgTEX8ua+ex3w+2Gq7aMYW4xLOMNc+PQm7wsSre/MJT0bDzT8PD434dmPVNCH7oB73/D3kfEUjOvpqrI2iwYmLFBCtDUZ0hhWTwe1xwnjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZQtcq0XCnz1d0sR;
	Mon, 31 Mar 2025 09:21:15 +0800 (CST)
Received: from kwepemd100023.china.huawei.com (unknown [7.221.188.33])
	by mail.maildlp.com (Postfix) with ESMTPS id A99C0180116;
	Mon, 31 Mar 2025 09:21:43 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 kwepemd100023.china.huawei.com (7.221.188.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 31 Mar 2025 09:21:42 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <edumazet@google.com>, <kuniyu@amazon.com>, <pabeni@redhat.com>,
	<willemb@google.com>, <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <horms@kernel.org>,
	<daniel@iogearbox.net>, <xiyou.wangcong@gmail.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <stfomichev@gmail.com>,
	<mrpre@163.com>, <zhangchangzhong@huawei.com>, Dong Chenchen
	<dongchenchen2@huawei.com>
Subject: [PATCH net v2 0/2] bpf, sockmap: Avoid sk_prot reset on sockmap unlink with ULP set
Date: Mon, 31 Mar 2025 09:21:24 +0800
Message-ID: <20250331012126.1649720-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100023.china.huawei.com (7.221.188.33)

Avoid sk_prot reset on sockmap unlink with ULP set to fix warning on
recurse in sock_map_close().

Dong Chenchen (2):
  bpf, sockmap: Avoid sk_prot reset on sockmap unlink with ULP set
  selftests: bpf: Add case for sockmap_ktls set when verdict attached

 net/ipv4/tcp_bpf.c                            |  3 +
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 70 +++++++++++++++++++
 2 files changed, 73 insertions(+)

-- 
2.25.1


