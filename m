Return-Path: <bpf+bounces-27322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7A48ABE8F
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 06:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166341C20986
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 04:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12C68495;
	Sun, 21 Apr 2024 04:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bK31KVB/"
X-Original-To: bpf@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594AB205E22;
	Sun, 21 Apr 2024 04:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713673226; cv=none; b=C+oPbM0KzPJ6ypwupu70iTzHXeqtRQ36HRF6GKyWd+0GWcsL8ul4IPiolcnLhwI1sKQpmiv1qdVOQE7IpFif6mF1S1HvbKjJl2KsvAE0ZT1mGmvl/7QJDZbJek37mzM95pvXnlQBABrpqDRLcyOXbsJBtv5uddzgQB//5QVOcUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713673226; c=relaxed/simple;
	bh=Fia/NOQDg2NSKAvnGUjySIpAQpocq0N7R66l0Bxfznk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=usTK7C9rfRm7HMmvHm5eRUHo47Kqc5D4STAEYylZrIAlrlcufr/lsowMApKXbXvvJBGZF/MqwdZMMY4GaMSdn3usFFuCoTaVv1qtMuIqymxBl0962e/9csumkq/uKz7rFBRLJX3fMUHNdYp25u2xq9YziJtEf2kWZf3TAiAC05o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bK31KVB/; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713673212; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Nyr0azZbnC6nTJRwiHKGfZve/bodqQulNxxfMB3ftGo=;
	b=bK31KVB/hR1MdbFYv/f1v+EcOfCz+pb4BvHJNYifiTGplGxYCKTJCX9SHcR6fkpe35/iocN6EowH8OYl0F4tWW2AnAlQ5va79yDv5bFDglLSSIIluRxekuIgiMxmVg0tQcH/ESUQhAEcF99lf4dJa9oayp65Ael8M/V3QJYojQo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W4w6o3N_1713673209;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W4w6o3N_1713673209)
          by smtp.aliyun-inc.com;
          Sun, 21 Apr 2024 12:20:11 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	xuanzhuo@linux.alibaba.com,
	fred.cc@alibaba-inc.com
Subject: [PATCH net-next 0/2] tcp: update TCPCB_EVER_RETRANS after trace_tcp_retransmit_skb()
Date: Sun, 21 Apr 2024 12:20:07 +0800
Message-Id: <20240421042009.28046-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move TCPCB_EVER_RETRANS updating after the trace_tcp_retransmit_skb()
in __tcp_retransmit_skb(), and then we are aware of whether the skb has
ever been retransmitted in this tracepoint. This can be used, e.g., to get
retransmission efficiency by counting skbs w/ and w/o TCPCB_EVER_RETRANS
(through bpf tracing programs).

For this purpose, TCPCB_EVER_RETRANS is also needed to be exposed to bpf.
Previously, the flags are defined as macros in struct tcp_skb_cb. I moved them
out into a new enum, and then they can be accessed with vmlinux.h.

We have discussed to achieve this with BPF_SOCK_OPS in [0], and using
tracepoint is thought to be a better solution.

[0]
https://lore.kernel.org/all/20240417124622.35333-1-lulie@linux.alibaba.com/

Philo Lu (2):
  tcp: move tcp_skb_cb->sacked flags to enum
  tcp: update sacked after tracepoint in __tcp_retransmit_skb

 include/net/tcp.h     | 22 +++++++++++++---------
 net/ipv4/tcp_output.c | 11 ++++++-----
 2 files changed, 19 insertions(+), 14 deletions(-)

--
2.32.0.3.g01195cf9f


