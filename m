Return-Path: <bpf+bounces-56212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57113A92EB6
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 02:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75FEE4A0934
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 00:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379C7171A1;
	Fri, 18 Apr 2025 00:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bf7fWzyB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DB5DDBC;
	Fri, 18 Apr 2025 00:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744935346; cv=none; b=TiRo7p0NP8w1OlAs77DpvhrWG7yxtEs+JWmYcuZxIoEj4ZhrLfOTbcQaY5SBEULZdAQEHpRX62c4Z4nEiQozRiOFNg+9/DHv6UDUsAgJU+TrkJ4ek4ozhAo3EfNo8Pa4U6NFyUn9BcH4fU1gRvQZUbe1YdtZY4WmX0r1UMq4s0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744935346; c=relaxed/simple;
	bh=h+cCZM44i2vHs23rd5+gGXN4EjCpnPpBb5Anhp5p8O4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HGsd3rL31hNMwRl0ZrNTR+g0sIBe7Q+bNDqnxgU3oJUPirYFazsIBdOmLVnGk/slskbBPRT39r034ZqboBHl8s+6dDhpfk7UbwSxUEU1vcO6DNGTtRuJO2UISuAw/hLNR/Uhpbf9/U+daRQwyPCrEPuEthinGBbWwVbkW7FIaOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bf7fWzyB; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744935343; x=1776471343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m8c8zloUjj46GzEcmNoX4Nz5j+Wz+pO28hChizT2zl4=;
  b=bf7fWzyBuVwnxT7GibxtDx3e1uswoCJNBVotGx46+3VfiCfEXZPjEztI
   3AUWYrbHrowNt1gAWMAsrX30uXd+sonEDL9r2ZYV2ANuW3yXPOnrbXPql
   fTjYnFallo/8/aN6V6zIvS0aJmAUCv2TPyrCaoCRc+EykavCtr6SNolLw
   c=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="512502204"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 00:15:42 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:50659]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.54:2525] with esmtp (Farcaster)
 id 9ad29bfd-f599-4502-9e02-e309a4ceca5d; Fri, 18 Apr 2025 00:15:41 +0000 (UTC)
X-Farcaster-Flow-ID: 9ad29bfd-f599-4502-9e02-e309a4ceca5d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:15:40 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:15:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jordan@jrife.io>
CC: <aditi.ghag@isovalent.com>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
	<kuniyu@amazon.com>, <martin.lau@linux.dev>, <netdev@vger.kernel.org>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/6] bpf: udp: Make sure iter->batch always contains a full bucket snapshot
Date: Thu, 17 Apr 2025 17:15:08 -0700
Message-ID: <20250418001530.45213-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <aAGVV0JtJDMR1O0Z@t14>
References: <aAGVV0JtJDMR1O0Z@t14>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jordan Rife <jordan@jrife.io>
Date: Thu, 17 Apr 2025 16:57:11 -0700
> > > @@ -3454,15 +3460,26 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
> > >  				batch_sks++;
> > >  			}
> > >  		}
> > > -		spin_unlock_bh(&hslot2->lock);
> > >  
> > >  		if (iter->end_sk)
> > >  			break;
> > > +next_bucket:
> > > +		/* Somehow the bucket was emptied or all matching sockets were
> > > +		 * removed while we held onto its lock. This should not happen.
> > > +		 */
> > > +		if (WARN_ON_ONCE(!resizes))
> > > +			/* Best effort; reset the resize budget and move on. */
> > > +			resizes = MAX_REALLOC_ATTEMPTS;
> > > +		if (lock)
> > > +			spin_unlock_bh(lock);
> > > +		lock = NULL;
> > >  	}
> > >  
> > >  	/* All done: no batch made. */
> > >  	if (!iter->end_sk)
> > > -		return NULL;
> > > +		goto done;
> > 
> > If we jump here when no UDP socket exists, uninitialised sk is returned.
> > Maybe move this condition down below the sk initialisation.
> 
> In this case, we'd want to return NULL just like it did before, since
> there's no socket in the batch. Do you want me to make this more
> explicit by setting sk = NULL here?

Sounds good to me

