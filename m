Return-Path: <bpf+bounces-51778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3F6A38DFA
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 22:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937D73AA9D0
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 21:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F9823958D;
	Mon, 17 Feb 2025 21:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gObWIrLK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C858231CAE;
	Mon, 17 Feb 2025 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739827753; cv=none; b=J3FecJTSyvFA76UrzURf1bSn6AjAyCjyfSZ1XsUo0JHm2ICHiEzFJiTjno52AuuIm9o1KmtVSJhL2clibxjVQYeHG5XSmvwXa6fL+NR8MyIN/nOpC3NGMmLJoXI3Xiw6xSBzrMtaEmSSbN0q32/JeIHWhUzwSodDkz0UeLqqTWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739827753; c=relaxed/simple;
	bh=RFXSSpPMrD5aajvlqdUrOH2emqA4VTkdjJsajwFb30A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FCXCYoD79LGCCQWeBxV4Owk1wUobk2njZ2dCRxAF/KcRymIl+N/6HurunrtEno9pL8aLL0tPNs+ugX5EACW5I1tpk+w5AGOYszzmLUimPsQb+NU2NFqvmm9ssJYoDtQ8Nq9iczHXzXhzi+IQXRNrkZXeqS3ypawyNHa5YNemLGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gObWIrLK; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739827751; x=1771363751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iubb63uVNsDfJynMk+myiGV+efvOVDBh9K0Klt7gWio=;
  b=gObWIrLKCNbvcT+YmlVs8Hj1TW2Eks8IZvsiFFOJ9YcV9TmrBMkm2ZBj
   dRjduB1TyACx3ersZ352v3XmFacWPIcet94ot/1UmkJ/3NwSkYuLPFrfa
   76NDGFYk+zbeYlH7kTp8q6pnmMkDXNT3GGxO4xH0Pq0bcPHZTanxdX2YF
   4=;
X-IronPort-AV: E=Sophos;i="6.13,293,1732579200"; 
   d="scan'208";a="378180249"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 21:29:09 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:23861]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.176:2525] with esmtp (Farcaster)
 id 64de6730-b20b-4313-9626-438232c625b8; Mon, 17 Feb 2025 21:29:08 +0000 (UTC)
X-Farcaster-Flow-ID: 64de6730-b20b-4313-9626-438232c625b8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 17 Feb 2025 21:29:07 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.189.161) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 17 Feb 2025 21:29:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<eddyz87@gmail.com>, <edumazet@google.com>, <haoluo@google.com>,
	<john.fastabend@gmail.com>, <jolsa@kernel.org>, <kpsingh@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <martin.lau@linux.dev>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@fomichev.me>,
	<shuah@kernel.org>, <song@kernel.org>, <ykolal@fb.com>,
	<yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: support TCP_RTO_MAX_MS for bpf_setsockopt
Date: Mon, 17 Feb 2025 13:28:54 -0800
Message-ID: <20250217212854.62301-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250217034245.11063-3-kerneljasonxing@gmail.com>
References: <20250217034245.11063-3-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 17 Feb 2025 11:42:44 +0800
> Some applications don't want to wait for too long because the
> time of retransmission increases exponentially and can reach more
> than 10 seconds, for example. Eric implements the core logic
> on supporting rto max feature in the stack previously. Based on that,
> we can support it for BPF use.
> 
> This patch reuses the same logic of TCP_RTO_MAX_MS in do_tcp_setsockopt()
> and do_tcp_getsockopt(). BPF program can call bpf_{set/get}sockopt()
> to set/get the maximum value of RTO.
> 
> It would be good if a BPF program sets max value of RTO before
> transmission as we can see in the later patch (selftests).
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

