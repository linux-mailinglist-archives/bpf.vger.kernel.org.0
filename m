Return-Path: <bpf+bounces-55789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0ADA866CD
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 22:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9FC1B67114
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 20:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3A0283C8A;
	Fri, 11 Apr 2025 20:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dkjQlQyi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60EC28136B;
	Fri, 11 Apr 2025 20:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744402363; cv=none; b=AOTLf71sYua1IGkgNVWsvPX83YgkFLUok5rHkLNVwETGyZ5MfgT++bgsbj6W/qPcf7KXs06Ohcux9GnYaGZq+5fU6kDyj8bowNLp/pkal6qQjQfJMDjTwTqziwXSiAlhTROLkx1m6452B+CVsgRyscICnlZGL5cFQvUK5FEiw/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744402363; c=relaxed/simple;
	bh=2rxD55QJH+s/lN2vIGo1JKZ/1SegRCNhybDpjYlRIeM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nflTtQkwUOrshdW/N+y98Kyuk/ZEYw9JQh8uVc+JF4cNJ6hFGDiDnRUS1ZlIHPJqmHek2/YgBNXEoHXolz7R2ey3M97bQZxUdT3J+EWtHnvJFge6U5RsfMqiPJwBYraEXu++vhrlW/AR8pe5niDa648wDiBAZ6UxbuzC40vrExw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dkjQlQyi; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744402362; x=1775938362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SyawZs0m547HU+E/Laym+M+YpS8kTAjiCHfnuJB1uHY=;
  b=dkjQlQyicanOFvHfJxLrhyZtQiNH0PljPAZUvKVMmXiVBF7Ga8J/DfME
   7RJuxLj2hlKnJm9lNIOD1Lzx7iIDZ9QhySYKv0wgemFI2M0fVT9c9W+LG
   b3ENPW3Y3NQ/THwVVPK1vztz53eUTZ0PTOwAPjtQ56sMG7+nwunntdATO
   g=;
X-IronPort-AV: E=Sophos;i="6.15,206,1739836800"; 
   d="scan'208";a="9713592"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 20:12:35 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:26338]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.222:2525] with esmtp (Farcaster)
 id fefc4980-db44-4e96-82f1-88df1b110016; Fri, 11 Apr 2025 20:12:35 +0000 (UTC)
X-Farcaster-Flow-ID: fefc4980-db44-4e96-82f1-88df1b110016
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:12:34 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.240.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:12:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jordan@jrife.io>
CC: <aditi.ghag@isovalent.com>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
	<kuniyu@amazon.com>, <martin.lau@linux.dev>, <netdev@vger.kernel.org>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/5] bpf: udp: Avoid socket skips and repeats during iteration
Date: Fri, 11 Apr 2025 13:12:21 -0700
Message-ID: <20250411201223.56558-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411173551.772577-4-jordan@jrife.io>
References: <20250411173551.772577-4-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA002.ant.amazon.com (10.13.139.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jordan Rife <jordan@jrife.io>
Date: Fri, 11 Apr 2025 10:35:43 -0700
> Replace the offset-based approach for tracking progress through a bucket
> in the UDP table with one based on socket cookies. Remember the cookies
> of unprocessed sockets from the last batch and use this list to
> pick up where we left off or, in the case that the next socket
> disappears between reads, find the first socket after that point that
> still exists in the bucket and resume from there.
> 
> In order to make the control flow a bit easier to follow inside
> bpf_iter_udp_batch, introduce the udp_portaddr_for_each_entry_from macro
> and use this to split bucket processing into two stages: finding the
> starting point and adding items to the next batch. Originally, I
> implemented this patch inside a single udp_portaddr_for_each_entry loop,
> as it was before, but I found the resulting logic a bit messy. Overall,
> this version seems more readable.
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!

