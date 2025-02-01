Return-Path: <bpf+bounces-50255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FED1A245EA
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 01:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097663A7058
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 00:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601EDC2FD;
	Sat,  1 Feb 2025 00:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="C35D3Kc1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6571F2C9A;
	Sat,  1 Feb 2025 00:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738369512; cv=none; b=LZ1zHdcJ+1+aU8R0rZGEa63MFsFrcl1Ox3JSkD1WuU9jjrA2lfLWpur0m+rIF+oZ/HZkfCK6jqCW8fp6hr1c/w4pnPCrBoxWCuYKTAm97HK23HIkdsGfax/KQK8K77iwY3BnihIS6/jtAr12N+dJFW0C5+EwdtssZg1zve9MAkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738369512; c=relaxed/simple;
	bh=BGLyhgnUtTzljGRLKYtQdndzRt7qRo5EAj8VHCD6aVk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vC+ZNIDMV0IF17AeYExSNbhRCLUaXbMBYmAYmHQh1T3C6OOxYLbpHdP/JYGCQmt78E3CrQRtJ5dv27ZHM3ltqYzkU1KtQuIIpWOgTMTdM7bpd1yS6f7A1aMp0kt2ZNV2kco66NW9jYtBILxsu8TXNojbChb8Qol0sWGBnUuOfgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=C35D3Kc1; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738369511; x=1769905511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A/BEBHp9hIxb3VrXdxVnx77mc3IFw+KYM3ypz9gIZ/I=;
  b=C35D3Kc1W3P2bb1j17Ryjn3TdsaW29d/udy53M98wkXtoTTa9kCfLt86
   CgHKsSOe1PrI/WUAmywgy3fYGZ1awThuhnEa6zoIrYpdw1lOiOtgzMgQg
   aLT/AsHZG3sEfCyFlNZ2/UpUzb3MJVZQ8ETFeKUVOhELGYbIuUwkVBG/3
   U=;
X-IronPort-AV: E=Sophos;i="6.13,250,1732579200"; 
   d="scan'208";a="490281332"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2025 00:25:05 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:63786]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.44:2525] with esmtp (Farcaster)
 id 913a99fb-ad6f-4031-8b8a-53902811fd99; Sat, 1 Feb 2025 00:25:05 +0000 (UTC)
X-Farcaster-Flow-ID: 913a99fb-ad6f-4031-8b8a-53902811fd99
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 1 Feb 2025 00:24:58 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 1 Feb 2025 00:24:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <bpf@vger.kernel.org>, <kernel-team@cloudflare.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<yan@cloudflare.com>
Subject: Re: Unchecked sock pointer causes panic in RAW_TP
Date: Fri, 31 Jan 2025 16:24:48 -0800
Message-ID: <20250201002448.43472-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250131232851.36345-1-kuniyu@amazon.com>
References: <20250131232851.36345-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Fri, 31 Jan 2025 15:28:51 -0800
> From: Kuniyuki Iwashima <kuniyu@amazon.com>
> Date: Fri, 31 Jan 2025 14:38:38 -0800
> > From: Yan Zhai <yan@cloudflare.com>
> > Date: Fri, 31 Jan 2025 12:32:57 -0800
> > > Hello,
> > > 
> > > We encountered a panic when tracing kfree_skb with RAW_TP. The problematic
> > > argument was introduced in commit ba8de796baf4 ("net: introduce
> > > sk_skb_reason_drop function"). It turns out that the verifier still accepted
> > > the program despite it didn't test sk == NULL. And this caused kernel panic. I
> > > attached a small reproducer and panic trace at the end. It's stably
> > > reproducible when packets are dropped without a receiver (e.g. run iperf2 UDP
> > > test toward localhost), in both 6.12.11 release and a recent bpf-next master
> > > snapshot (I was using commit c03320a6768c).
> > > 
> > > As a contrast, for another tracepoint like tcp_send_reset, if sk is not checked
> > > before dereferencing, the verifier will complain and reject the program as
> > > expected. So this feels like some annotation is missing? Appreciate if someone
> > > could help me figure out.
> > 
> > Maybe __nullable is missing given we annotated skb for tcp_send_reset ?
> > https://lore.kernel.org/netdev/20240911033719.91468-4-lulie@linux.alibaba.com/

Just for the record, I posted the fix:
https://lore.kernel.org/bpf/20250201001425.42377-1-kuniyu@amazon.com/T/#u

