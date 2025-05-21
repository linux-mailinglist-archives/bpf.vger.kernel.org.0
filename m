Return-Path: <bpf+bounces-58668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC8CABFD10
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 20:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5644A841C
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 18:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE54E28F92D;
	Wed, 21 May 2025 18:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="opOCPUCW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACA728F531;
	Wed, 21 May 2025 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747853723; cv=none; b=VyJdhQ4NRypbdTD/B1e6dfm7Dyn59bTUu6cUpw0J6EPZC+WfFp0fV0kzbxGexftRRT4EYGX3fpX1iFvAUy0PzovIyd37XFSkdsOB39C2uj1B4h7RSyOtkuApKctRa7bXHJizSUeD6aA4KuL7T8qc69eEDXZGRwb0m0ZxBCvAbxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747853723; c=relaxed/simple;
	bh=0wq/AfxTVnTjoaTp1I+1eJrMuahEIQVXnsXu8RfR0tY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rg3+BbQ3+X4lPkfRVYqVDBTc+AcF1kEwXph+Tb5PK22r9Ewi/WlMyhJ7jHM2eYj1lxla5Ari61WS0Vg1FfdbigyDdp+sXNT7KxEha1Dm5bqmDIR9D5wEl14wid4zM8Ytfece9mHDO1enE9ztB789wnoXjd99cjzQT/y2hv/uqFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=opOCPUCW; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747853722; x=1779389722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KG7bFjgkXr+F7h4No5I9wKA0MJvGI12KsoalsxVmNpM=;
  b=opOCPUCWP1CHMO6lrG1qPrNFhgHytbJK9euT1vrSFIbwgL8T5cfi+QBI
   ZgTdIg0vaygKMbS3hceC8qvJ26W8RSTBrVg94rQ0//0x2ukLOm+S3CR5W
   8kRoQ8BkKjNORP8xRjJxcfKIDBwBPCQAtxuHUSjOmYAkrYPcM3Ea/T2un
   Nu43gLzIlctXQXWgyjo4vO8fRaSV/6pAMkUKzemBUPvH1pYHEfmUdLx61
   T4rldu3TlQqUsjv0Ks3SCELxcfwGjo0XaT/IxoWEtahaFRhQr9mCR2j1h
   7PRT/0I16dRWkHzALoN+gO8HSADLUzzNXpAn78Fd8IgtxpA3Rcd+AWsT4
   g==;
X-IronPort-AV: E=Sophos;i="6.15,304,1739836800"; 
   d="scan'208";a="95857485"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 18:55:11 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:4253]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.191:2525] with esmtp (Farcaster)
 id b5505184-aeb3-444a-a9d6-352deaab2d16; Wed, 21 May 2025 18:55:09 +0000 (UTC)
X-Farcaster-Flow-ID: b5505184-aeb3-444a-a9d6-352deaab2d16
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 18:55:09 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.52.104) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 18:55:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jordan@jrife.io>
CC: <alexei.starovoitov@gmail.com>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <kuniyu@amazon.com>, <martin.lau@linux.dev>,
	<netdev@vger.kernel.org>, <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v1 bpf-next 01/10] bpf: tcp: Make mem flags configurable through bpf_iter_tcp_realloc_batch
Date: Wed, 21 May 2025 11:54:54 -0700
Message-ID: <20250521185458.57420-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520145059.1773738-2-jordan@jrife.io>
References: <20250520145059.1773738-2-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jordan Rife <jordan@jrife.io>
Date: Tue, 20 May 2025 07:50:48 -0700
> Prepare for the next patch which needs to be able to choose either
> GFP_USER or GFP_NOWAIT for calls to bpf_iter_tcp_realloc_batch.
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

