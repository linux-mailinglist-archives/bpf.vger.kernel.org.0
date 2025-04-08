Return-Path: <bpf+bounces-55431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08305A7F195
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 02:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83E516A4DF
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 00:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572291CAA4;
	Tue,  8 Apr 2025 00:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kUmsmc4I"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C7CD2FB;
	Tue,  8 Apr 2025 00:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744071428; cv=none; b=eNLS/3oKs3lMTrPsutXT3m8HByrK9plR9do+0qQpwY1Pw0K6uJTaPv52TWBkDlWGUgmMqOb6ruKQ+BFAfrsiahHOgcAeLudhNBFLwa9HC7BlGrcPVgsB7Hekx35ob2l3ZAVnpahrA2nU1BVoZVBq+PsLKHcCJ34hrDOY3quyu7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744071428; c=relaxed/simple;
	bh=z1sI6zqI2KbmUuNZWR9OauLNqva1J0bVTTZtuwY6uO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8OJBfwISDViSOfqaxWx0K/jrI/ywpZCRtkcYFfddzYThIJOB/sb9zhygAL2iS3cXwM65Bhi1NcygORf8Q2jXBNXxNW0ZwmGcPMW8kIKUEqTYjaPLt2p18qAcjHzs8UV9pfTjsndj6h/O+BJjxY2hOn+kgNdj2GlBbfazotD+xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kUmsmc4I; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744071427; x=1775607427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8yOCsx+nkQGqiyaA8CKVjQ4hpZeCm+ILtzKq52dhCgE=;
  b=kUmsmc4IgiFwHOlxD6Lxujd+JK/V/QIeWkwyo7cL5quJcB5Y2zD3m5wM
   ulq8b+eCGQnlxqLhf+abOxbcgIRIw0q79x6AQmcU5dsSeuUcdBX3d3nsd
   TYlou+uFvmWalgZjL5+YdZ68h8Uf2OO8YnS9bZ3V5iNuuQR6ZoXC5g29O
   0=;
X-IronPort-AV: E=Sophos;i="6.15,196,1739836800"; 
   d="scan'208";a="814162670"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 00:17:02 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:41354]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.120:2525] with esmtp (Farcaster)
 id 1a6f8aa9-6343-4351-ae86-e3271abdc5f1; Tue, 8 Apr 2025 00:17:01 +0000 (UTC)
X-Farcaster-Flow-ID: 1a6f8aa9-6343-4351-ae86-e3271abdc5f1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 00:17:01 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 00:16:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jordan@jrife.io>
CC: <aditi.ghag@isovalent.com>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
	<kuniyu@amazon.com>, <martin.lau@linux.dev>, <netdev@vger.kernel.org>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/3] bpf: udp: Avoid socket skips and repeats during iteration
Date: Mon, 7 Apr 2025 17:16:25 -0700
Message-ID: <20250408001649.5560-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CABi4-ogLNdQw=gLTRZ4aJ8qiQWiovHaO19sx5uz29Es6du8GKg@mail.gmail.com>
References: <CABi4-ogLNdQw=gLTRZ4aJ8qiQWiovHaO19sx5uz29Es6du8GKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jordan Rife <jordan@jrife.io>
Date: Mon, 7 Apr 2025 16:30:46 -0700
> > We may need to iterate all visited sockets again in this bucket if all
> > unvisited sockets disappear from the previous iteration.
> 
> If the next socket disappears between iterator stop and start, the
> outer loop would need to keep going until it finds a socket from last
> time that still exists. In most cases, it seems unlikely that the next
> socket will disappear between iterator reads, so in general the outer
> loop would only need to iterate once; the common case should perform
> the same as before with the offset approach. The worst case indeed
> would be if all the sockets disappear between reads. Then you'd have
> to scan through all items in the bucket n_cookies times. Again though,
> this is hopefully a rare case.
> 
> > When the number of the unvisited sockets is small like 1, the duplicated
> > records will not be rare and rather more often than before ?
> 
> Sorry if I'm missing something, but what's the relationship between
> the number of unvisited sockets and rarity of duplicated records?

Sorry, I misread the code, and s/duplicated/skipped/.

I was thinking that rarity of such unwanted events depends on how
many unvisited sockets are left before restarting.

Let's say batch has 16 sockets and the iterator stopped at 15,
it's more likely that a single socket disappear.

This should be fine given the batch size normally covers the full
bucket of the hash, and it's unlikely that many sockets are added
in the bucket between stop and restart.

In the worst case, where vmalloc() fails and the batch does not
cover full bucket, say the batch size is 16 but the list length
is 256, if the iterator stops at sk15 and sk16 disappers,
sk17 ~ sk256 will be skipped in the next iteration.

 sk1 -> ... sk15 -> sk16 -> sk17 -> ... -> sk256

