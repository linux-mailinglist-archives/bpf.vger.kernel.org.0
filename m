Return-Path: <bpf+bounces-36623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355C794B1B9
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 23:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6D628234E
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 21:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885CB148FFF;
	Wed,  7 Aug 2024 21:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3lo3FM6"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D0C4D5BD
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723064694; cv=none; b=L39PR0KOixFHcQ+vpKckaNT+z7KOvjM8SvGkkQJHoIK8ejz5yzS+eQnfGchJ60crgXIILYnRQHGmnMnjO7c7jUi9/ioNN1OZQ09ng7xXso7iaofJ8+FgGE+K/opsXme1ufcahuWC/OBg/S7XbwZokNosfqf3G1pbn9Ns33FmSvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723064694; c=relaxed/simple;
	bh=jGHJLRRCHLWNUnKFRHQDi+w8kZLLsWCY7XWb0cVp3VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdneLJKZkc3jiNX6NLPHOMEXtM8NmyoG+bhUBUwaSamePrP4BQgKQRp9KD0BSXwUxHyWMREW5CGwq6iL3tv31QXF7Sno22tywl0FKQk67hKAeX2XhOPhXpQAnzGwKZK+Wkt0SxnYvES7FOik8xywCZpSXkG5ig73PSDyYtPtCN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K3lo3FM6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723064691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CO5VZoxQMGMVJu5rfcYYMsQ2+NLl+9lwePvebgkERyg=;
	b=K3lo3FM6x34G9orB4bEkkPgDc4vxRMLlPIsLnJ5faEHAw2RImayYbl08MVwWPYcponkO2P
	DazweHaW+qih+nH5XgQVkhniwAJWSvRP4JyCbHkqHw1T+kVStiozn7lhu8QOO+A/OjLKzz
	gb+OPGrZbsPd5/2TYFyMVovmesLtY10=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-ADq5JAorO9uD7y5GOqTb2A-1; Wed,
 07 Aug 2024 17:04:49 -0400
X-MC-Unique: ADq5JAorO9uD7y5GOqTb2A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79A071956054;
	Wed,  7 Aug 2024 21:04:44 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.8.85])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E481300018D;
	Wed,  7 Aug 2024 21:04:34 +0000 (UTC)
Date: Wed, 7 Aug 2024 17:04:31 -0400
From: Phil Auld <pauld@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 09/30] sched_ext: Implement BPF extensible scheduler class
Message-ID: <20240807210431.GB80631@pauld.westford.csb>
References: <20240618212056.2833381-1-tj@kernel.org>
 <20240618212056.2833381-10-tj@kernel.org>
 <20240807191004.GB47824@pauld.westford.csb>
 <ZrPKZMvrl6kGFzo-@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrPKZMvrl6kGFzo-@slm.duckdns.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Tejun,

On Wed, Aug 07, 2024 at 09:26:28AM -1000 Tejun Heo wrote:
> Hello, Phil.
> 
> On Wed, Aug 07, 2024 at 03:11:08PM -0400, Phil Auld wrote:
> > On Tue, Jun 18, 2024 at 11:17:24AM -1000 Tejun Heo wrote:
> > > Implement a new scheduler class sched_ext (SCX), which allows scheduling
> > > policies to be implemented as BPF programs to achieve the following:
> > > 
> > 
> > I looks like this is slated for v6.12 now?  That would be good. My initial
> > experimentation with scx has been positive.
> 
> Yeap and great to hear.
> 
> > I just picked one email, not completely randomly.
> > 
> > > - Both enable and disable paths are a bit complicated. The enable path
> > >   switches all tasks without blocking to avoid issues which can arise from
> > >   partially switched states (e.g. the switching task itself being starved).
> > >   The disable path can't trust the BPF scheduler at all, so it also has to
> > >   guarantee forward progress without blocking. See scx_ops_enable() and
> > >   scx_ops_disable_workfn().
> > 
> > I think, from a supportability point of view, there needs to be a pr_info, at least,
> > in each of these places, enable and disable, with the name of the scx scheduler. It
> > looks like there is at least a pr_error for when one gets ejected due to misbehavior.
> > But there needs to be a record of when such is loaded and unloaded.
> 
> Sure, that's not difficult. Will do so soon.

Thanks! That would be helpful.  I was going to offer a patch but wanted to ask first
in case there was history.

But if you are willing to do it that's even better :) 


Cheers,
Phil


> 
> Thanks.
> 
> -- 
> tejun
> 

-- 


