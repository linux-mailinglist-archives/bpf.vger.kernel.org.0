Return-Path: <bpf+bounces-51719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0714DA37B0B
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 06:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAE3B169B02
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 05:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B50718A6A6;
	Mon, 17 Feb 2025 05:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PX8QS+JK"
X-Original-To: bpf@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95E2137750;
	Mon, 17 Feb 2025 05:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739771066; cv=none; b=VbmruGqpg5D2TLi6lh3BmzjnBYCU+HCkelmIrjUTqyL8EaNEyswr0Egm2fVu3BkS0Pc+6IDWwxEGIw2GwioGYebzm0iElC57pc5aTaH+Kz4jQvpfKh7R+fE3vWBBie9Lc58foCdkC0s+1NhO51A3y58tnOKXPs8q42mqxHGEp80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739771066; c=relaxed/simple;
	bh=Z86hbm+AyS40zmwoHV2FxJBl2pnWWB7QD1M0ZpXBWRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRn//c5MIslQi8MwyQhsvhE1+E50Cn5G+ZwfL7JAS10sbq2lDl7qDp2uI0c6vGCnmODDgr+P0OoPYTk8uNj4/c1HU/7lMAMsoab4zgs6PdOo7HIpWHnjlmlRTq3ZmXZpZfK1AE/kr5I/wRnzCNbE2kE3JSZqvjURjkDD3uaWYUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PX8QS+JK; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739771059; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=UDJBPz4tDQX1n8wj6sZdtoJl0cQHrWxiQmekpH9nHDc=;
	b=PX8QS+JK30jhN347gQJ5PMYByXClopS5qYi68KvwJpPusxRcBW3lFF2Fhdt8FZApH4hMWht478CMmrUsr1f3xWZsvZDvUzhmbpRSlp449CSMF+36RKlKgVxAoNHCw/fnrk/J2NEXjR2PK/KtnYN4PRH7njh7pIseqdJa7DHozhM=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WPZCnV4_1739771057 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Feb 2025 13:44:17 +0800
Date: Mon, 17 Feb 2025 13:44:17 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, jaka@linux.ibm.com,
	kgraul@linux.ibm.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, pabeni@redhat.com,
	song@kernel.org, sdf@google.com, haoluo@google.com, yhs@fb.com,
	edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	jolsa@kernel.org, guwen@linux.alibaba.com, kuba@kernel.org,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 0/6] net/smc: Introduce smc_ops
Message-ID: <20250217054417.GA91494@j66a10360.sqa.eu95>
References: <20250123015942.94810-1-alibuda@linux.alibaba.com>
 <20250214092209.GA88970@j66a10360.sqa.eu95>
 <2ae65126-73a3-4c18-bef5-d4067c727cf5@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ae65126-73a3-4c18-bef5-d4067c727cf5@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Feb 14, 2025 at 12:37:55PM +0100, Wenjia Zhang wrote:
> 
> 
> On 14.02.25 10:22, D. Wythe wrote:
> >On Thu, Jan 23, 2025 at 09:59:36AM +0800, D. Wythe wrote:
> >>This patch aims to introduce BPF injection capabilities for SMC and
> >>includes a self-test to ensure code stability.
> >>
> >>Since the SMC protocol isn't ideal for every situation, especially
> >>short-lived ones, most applications can't guarantee the absence of
> >>such scenarios. Consequently, applications may need specific strategies
> >>to decide whether to use SMC. For example, an application might limit SMC
> >>usage to certain IP addresses or ports.
> >>
> >>To maintain the principle of transparent replacement, we want applications
> >>to remain unaffected even if they need specific SMC strategies. In other
> >>words, they should not require recompilation of their code.
> >>
> >>Additionally, we need to ensure the scalability of strategy implementation.
> >>While using socket options or sysctl might be straightforward, it could
> >>complicate future expansions.
> >>
> >>Fortunately, BPF addresses these concerns effectively. Users can write
> >>their own strategies in eBPF to determine whether to use SMC, and they can
> >>easily modify those strategies in the future.
> >
> >Hi smc folks, @Wenjia @Ian
> >
> >Is there any feedback regarding this patches ? This series of code has
> >gone through multiple rounds of community reviews. However, the parts
> >related to SMC, including the new sysctl and ops name, really needs
> >your input and acknowledgment.
> >
> >Additionally, this series includes a bug fix for SMC, which is easily
> >reproducible in the BPF CI tests.
> >
> >Thanks,
> >D. Wythe
> >
> Hi D.Wythe,
> 
> Thanks for the reminder! I have a few higher-priority tasks to
> handle first, but I’ll get back to you as soon as I can—hopefully
> next week.
> 
> Thanks,
> Wenjia

Hi Wenjia,

Thank you for your reply and explanation! I completely understand that
you have higher-priority tasks to handle right now. I just wanted to
ensure that this patch isn't overlooked, as it contains important
changes and fixes related to SMC.

Best wishes,
D. Wythe


