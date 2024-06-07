Return-Path: <bpf+bounces-31623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C0F900D87
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 23:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685571F22E8A
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 21:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D466D15531E;
	Fri,  7 Jun 2024 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="r6KBGmCS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057D54E1DD;
	Fri,  7 Jun 2024 21:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717795969; cv=none; b=UtPqq33jKtFaGFMQhK7z+v+oP8SEMxIxXN8JtTMYAhUlMZUT5KJwcaf0m7DBuCbRvKCaYVb70nvnQD2p0i+nSs83lrlO4LRJkoB/YMbZfHsjxn/8aNqkygbgD2PHjR6SXvdZrQ7c2yXhbhrsdImmojZdqgU1fxsYiKjgusMn4P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717795969; c=relaxed/simple;
	bh=DtFPPuJl5jobRcYlhii4Hbqy6pyJVCflNa8vQeo+ODw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=REWtmCwLqKjXxkGDK6zLfR79PaqKLnbepVuvHjDmflh+lbYnrx/MWoxOWiqDmoSfiv5SK5Vwf1xSNHMD4J0AGU6pP8hEem5Zj6/w8XwVHzb9GI2AkP6eBqOl+59u5TvQPvsQDJmZ4x73/s145ogX3s348crBbWMkGbFytou1r0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=r6KBGmCS; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717795968; x=1749331968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tDYZoP3d8/zCpLPWQHHudMPrUF8rr9i3P8lcsIGhdv0=;
  b=r6KBGmCSQitmi8h64oCnP1Smkrw5IoZtbkJVFNBeyam5Wb9QendXpen8
   8Mi0coQOdZPAqTZDnSttgYaQ56lnuXrjqFyTlNywqDuzevv5x8A5TaBzN
   +4lf/8/17vkxTd0VHdrdJGnf2XTSpxWg/hLHTvjdu7IVeC+0qMv35j01+
   E=;
X-IronPort-AV: E=Sophos;i="6.08,221,1712620800"; 
   d="scan'208";a="300765059"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 21:32:45 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:15518]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.213:2525] with esmtp (Farcaster)
 id cb789800-7be3-4309-aa6b-c7438c91f728; Fri, 7 Jun 2024 21:32:45 +0000 (UTC)
X-Farcaster-Flow-ID: cb789800-7be3-4309-aa6b-c7438c91f728
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 7 Jun 2024 21:32:41 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 7 Jun 2024 21:32:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <xiyou.wangcong@gmail.com>
CC: <bpf@vger.kernel.org>, <cong.wang@bytedance.com>, <fw@strlen.de>,
	<netdev@vger.kernel.org>,
	<syzbot+0c4150bff9fff3bf023c@syzkaller.appspotmail.com>, <kuniyu@amazon.com>
Subject: Re: [Patch net] net: remove the bogus overflow debug check in pskb_may_pull()
Date: Fri, 7 Jun 2024 14:32:29 -0700
Message-ID: <20240607213229.97602-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ZmMxzPoDTNu06itR@pop-os.localdomain>
References: <ZmMxzPoDTNu06itR@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Fri, 7 Jun 2024 09:14:04 -0700
> On Fri, Jun 07, 2024 at 01:27:47AM +0200, Florian Westphal wrote:
> > Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > > From: Cong Wang <cong.wang@bytedance.com>
> > > 
> > > Commit 219eee9c0d16 ("net: skbuff: add overflow debug check to pull/push
> > > helpers") introduced an overflow debug check for pull/push helpers.
> > > For __skb_pull() this makes sense because its callers rarely check its
> > > return value. But for pskb_may_pull() it does not make sense, since its
> > > return value is properly taken care of. Remove the one in
> > > pskb_may_pull(), we can continue rely on its return value.
> > 
> > See 025f8ad20f2e3264d11683aa9cbbf0083eefbdcd which would not exist
> > without this check, I would not give up yet.
> 
> What's the point of that commit?

4b911a9690d7 would be better example.  The warning actually found a
bug in NSH GSO.

Here's splats triggered by syzkaller using NSH over various tunnels.
https://lore.kernel.org/netdev/20240415222041.18537-2-kuniyu@amazon.com/

