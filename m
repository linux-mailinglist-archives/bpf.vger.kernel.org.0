Return-Path: <bpf+bounces-32829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666FD9137AF
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 06:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21515283510
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 04:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DECE1A28B;
	Sun, 23 Jun 2024 04:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eOVWinuy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CA212E61;
	Sun, 23 Jun 2024 04:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719118316; cv=none; b=NWVPh/+HLrtTH6sogrY3zqM4KkQj3NAnE8RmSwJnE/m0VpSNScA7dlhCotJEeOgWlqpjCx3FPXmb1GuIDp1hKkUNoAPhfVpZqAvsM1LDqf9aCMjtIeW32Z2eQ3XcGTxsWf3plCAu5MXQO/p4PnP29qAWHEUatH/crPUckVuPgls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719118316; c=relaxed/simple;
	bh=940owv6eaP5PCuVS+X6jI1QkF/GIk71BrAF7Upfr81M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJ1GeHHOU5ZFdMqjNzHNws74u/yTJPdPyqsBDUzPZKjKdvMBIMZ7kTEvxG5ctrrMQkMIfhODQCdVpHzrCwuIjLxf/P0Ih+dkV8CmxIVzsS87nT06a1qlSmH6/QP5AvcVy2u8wH2ENE1GG+Sze6XVl2Ew+76RzcCK2Xn0ReKPaI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=eOVWinuy; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719118315; x=1750654315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V1RgKYJFQRJy3r5CqsiuGsKnhQTAEykn1x9buwRCFiQ=;
  b=eOVWinuyNgveFJuJwLCX6S8RZ1u+G2mZKTnG02Efy73lgqjad2yf6sG2
   oEG9ceBmb3fNDt44Vsn+mvXRR8akI9Y6v7uFI2tKYwhsu6o5O2kV9Rqx5
   tRAnmXIVyjHq+0bkUdZYHFQbb3IdQu73vH32aLk1B/Gq8izQpaNIUeEyh
   I=;
X-IronPort-AV: E=Sophos;i="6.08,259,1712620800"; 
   d="scan'208";a="662369322"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 04:51:53 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:30970]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.208:2525] with esmtp (Farcaster)
 id ea9f1add-385c-42ec-8ce7-967b0363f329; Sun, 23 Jun 2024 04:51:52 +0000 (UTC)
X-Farcaster-Flow-ID: ea9f1add-385c-42ec-8ce7-967b0363f329
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 23 Jun 2024 04:51:51 +0000
Received: from 88665a182662.ant.amazon.com (10.142.209.217) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 23 Jun 2024 04:51:49 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <zacecob@protonmail.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <kuniyu@amazon.com>
Subject: Re: Returning negative values repeatedly from a SOCK_FILTER ebpf prog stalls kernel thread
Date: Sat, 22 Jun 2024 21:51:41 -0700
Message-ID: <20240623045141.78101-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CJrradVmkT-HM6goIYbivHNdWglG0h11_0Ky2ObV_ZCOunJaksIj9alG1UTHCkSDX_Jhm6uB5P5vS8C75QfrjWrqeHisUIDn2023xfv7jp0=@protonmail.com>
References: <CJrradVmkT-HM6goIYbivHNdWglG0h11_0Ky2ObV_ZCOunJaksIj9alG1UTHCkSDX_Jhm6uB5P5vS8C75QfrjWrqeHisUIDn2023xfv7jp0=@protonmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Zac Ecob <zacecob@protonmail.com>
Date: Sat, 22 Jun 2024 12:20:05 +0000
> Problem is title.
> 
> To trigger, I attached an EBPF prof that just returned -1, and send ~1000
> packets through it.

If you want to drop the packet, the prog must return 0.

You can see sk_filter_trim_cap() where the returned value from bpf prog
is cast to unsigned int.  Then, pskb_trim() does nothing because skb->len
is smaller than (unsigned int)-1, and 0 is set to err.

  unsigned int pkt_len;

  pkt_len = bpf_prog_run_save_cb(filter->prog, skb);
  err = pkt_len ? pskb_trim(skb, max(cap, pkt_len)) : -EPERM;

After calling sk_filter() from unix_dgram_sendmsg(), the skb is just queued
to the peer.


> 
> After doing some investigation, the `sk_wmem_alloc` member of `struct sk`
> seems to only be increasing, presumably missing some refcnt_dec somewhere.

So, no refcnt is leaked.
What is missing is recv() on the peer side.


> 
> At a certain point, in `sock_alloc_send_pskb`, we fail the check: 
> 
> `
> if (sk_wmem_alloc_get(sk) < READ_ONCE(sk->sk_sndbuf))
> ` 
> 
> Upon which we enter `sock_wait_for_wmem` and schedule a massive timeout
> (at least that's what happened in my tests).
> 
> Not sure where the missing refcnt subs are, must admit unfamiliarity with
> the network code.

The paired sub is sock_wfree() in unix_destruct_scm(), which is set
to skb->destructor() in unix_scm_to_skb() and called from kfree_skb().


> 
> Please let me know if I need to add anything. 
> 
> Thanks

