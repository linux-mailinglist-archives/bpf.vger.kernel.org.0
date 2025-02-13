Return-Path: <bpf+bounces-51337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C32A33582
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 03:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747C43A7E43
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 02:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B5E20371E;
	Thu, 13 Feb 2025 02:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hEm8KbXx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3039635949;
	Thu, 13 Feb 2025 02:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739413842; cv=none; b=ieqoQRFl9Go+7tkWoSVRW04ivcaCiuy/rM9x96cdo9qWDkWmxkFQ2CELb4XVjdJc0Es6ZskGpVUR7IcR1SMAz+thLAtbmfK/BQHewxNfWpXqt4+yxbyhj51e9G2x54wE1LCMQA5QhlZQJ2vPXywf/IThHR/aunavJgq19lT7H0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739413842; c=relaxed/simple;
	bh=dV1++hcTb809Tyte/G5Kxk9zljpjotKPdog/FM5O6mY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ckAsbzovRzRLKPnP2wJtsZxMwAF5R8BACcpI1NYBGBhkpZ1vJXyEE0/P9qxYA9u+ASPx2HWXRMZQq4SYdua1jQlzORNxrX7oUcSU3SMCJDcMqVejCWiNosXYCTlpoiDYfnsOgq7yCelOchJ6bkYeEtmQfHs6LbmGpbSYN/XWRHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hEm8KbXx; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739413841; x=1770949841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BG7wTe6BqwrTgCUER7vpHc/ee8JDHtAQHvvFBwAjoR4=;
  b=hEm8KbXxax7iRBHBsWE3130jT6oMqZuS6fIUKe8BiwsrxmcSBuTLtgpK
   DKRbHw+KWGFdUov54sTZLkB7X7SCkamORB7b6RYlB6v6oI3qMNe3uDZUO
   aCfU/lQdOFjOBaAYSj9n+MLwjgIpK3jto8zEU/Yx4oAgdkTOlg/51kxfE
   U=;
X-IronPort-AV: E=Sophos;i="6.13,281,1732579200"; 
   d="scan'208";a="466419002"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 02:30:38 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:47480]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.96:2525] with esmtp (Farcaster)
 id aa1214f3-e9e3-4579-8e3e-7d9851380cb3; Thu, 13 Feb 2025 02:30:37 +0000 (UTC)
X-Farcaster-Flow-ID: aa1214f3-e9e3-4579-8e3e-7d9851380cb3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 02:30:36 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 02:30:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<eddyz87@gmail.com>, <edumazet@google.com>, <haoluo@google.com>,
	<horms@kernel.org>, <john.fastabend@gmail.com>, <jolsa@kernel.org>,
	<kpsingh@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<martin.lau@linux.dev>, <ncardwell@google.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <sdf@fomichev.me>, <song@kernel.org>,
	<yonghong.song@linux.dev>
Subject: Re: [PATCH net-next 3/3] selftests/bpf: add rto max for bpf_setsockopt test
Date: Thu, 13 Feb 2025 11:30:21 +0900
Message-ID: <20250213023021.76447-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250213004355.38918-4-kerneljasonxing@gmail.com>
References: <20250213004355.38918-4-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Feb 2025 08:43:54 +0800
> Add TCP_BPF_RTO_MAX selftests for active and passive flows
> in the BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB and
> BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB bpf callbacks.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  .../bpf/prog_tests/tcp_hdr_options.c          | 28 +++++++++++++------
>  .../bpf/progs/test_tcp_hdr_options.c          | 26 +++++++++++++++++
>  .../selftests/bpf/test_tcp_hdr_options.h      |  3 ++

It would be nice to update sol_tcp_testsp[] with TCP_RTO_MAX_MS
in tools/testing/selftests/bpf/progs/setget_sockopt.c.

