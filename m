Return-Path: <bpf+bounces-65846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05598B298F6
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 07:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB39C17F54F
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 05:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B71626FA6A;
	Mon, 18 Aug 2025 05:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GxqwK5Wz"
X-Original-To: bpf@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEEB26D4E2;
	Mon, 18 Aug 2025 05:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755495591; cv=none; b=lwMKVFpp39qfT+/HLn5ki13CZXQRqCTfZgb59Xl6bqvh3+XGi1VA6h/7L1VvfNNBFXHsbmoQpyfWBu2FL/8AS1JMshpXUs6DzsVHVD3rVzzw8bKtxlZyhqlGRHn9yoWCmSav2z+yTfN724J+4pxLGCBblhtngUgQZpxky0qf4ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755495591; c=relaxed/simple;
	bh=o3uNSVAiO3egJNj37SYbpwN8ZS+890QUO9bcSpSLBAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqissgrSBwnVrjzcBIb48fX8I1aroIOO+TdQt+CaTUNm7MDt7eBY3+Ot+/3FwFm88MLkvE1xGYopiXp9nBw3zQROTAf11lWgcTpHVQWOyNHfVZ66ocZnYGrvoruGVAB39FxAtBH1lEIqX0OZxXr/aXPvtL/42knWBcZ/xL1Sa5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GxqwK5Wz; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755495578; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=dihRxXmk6cpasMYFcjt6iSrWf1Q1lC5HSGvLlVUkcis=;
	b=GxqwK5WzuXqvw3Q5xmjX1V98cg0ogRLgw6L3Cx/XC/knZvUyeoR9vGkg4uWJSs6vnx5d0ILTUfj6kAvPbp2P47XWDZ16aiKQ6H+npIB2AQzHjkFF0ZU7kvP9GDNdKmpgt/OwSTpN9Z6uH417R0PG+KmgX+6NyNYq9q/uwH6+GQ8=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WlveepU_1755495576 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 Aug 2025 13:39:36 +0800
Date: Mon, 18 Aug 2025 13:39:36 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexandra Winter <wintera@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, sdf@google.com,
	haoluo@google.com, yhs@fb.com, edumazet@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
	Mahanta.Jambigi@ibm.com, Sidraya.Jayagond@ibm.com,
	wenjia@linux.ibm.com, dust.li@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	bpf@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
	jaka@linux.ibm.com
Subject: Re: [PATCH bpf-next 2/5] net/smc: fix UAF on smcsk after
 smc_listen_out()
Message-ID: <20250818053936.GA28521@j66a10360.sqa.eu95>
References: <20250731084240.86550-1-alibuda@linux.alibaba.com>
 <20250731084240.86550-3-alibuda@linux.alibaba.com>
 <174ccf57-6e7c-4dab-8743-33989829de01@linux.ibm.com>
 <20250811015452.GB19346@j66a10360.sqa.eu95>
 <14ec76a2-e80e-44a8-a775-ebd4668959c4@linux.ibm.com>
 <20250811083356.7911039b@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811083356.7911039b@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Aug 11, 2025 at 08:33:56AM -0700, Jakub Kicinski wrote:
> On Mon, 11 Aug 2025 11:24:50 +0200 Alexandra Winter wrote:
> > > Yes, it should be sent to net. But the problem is that if I don't carry
> > > this patch, the BPF CI test will always crash. Maybe I should send a
> > > copy to both net and bpf-next? Do you have any suggestions?
> > 
> > I do not have any experience with bpf-next. But typically patches
> > to 'net' are taken after one or two days, if there are no issues.
> > I'd assume they are then picked to net-next and bpf-next(?) almost instantly.
> > Then you would not need it in your bpf series anymore.
> 
> AFAIU the patches which land in net will make it to -next trees after
> respective PR with fixes. So
> 
> 
>  patch -> 
>           net ->
>                  [next Thu] Linus ->
>                                       [same day] net-next
>                                       [at some point] bpf PR ->
>                                                                  Linux
>                                                                         -> bpf-next
> 
> What gets applied to net should be in net-next in a week,
> and most -next trees within 2 weeks.

That's very helpful.

Based on those infomations, I will send this prerequisite patch to the net
tree first. I'll then wait for about two weeks for it to propagate to
bpf-next before submitting the rest of my BPF series.

Best regards,
D. Wythe

