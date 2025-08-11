Return-Path: <bpf+bounces-65313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B37B1FD8F
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 03:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849FB3B8C2B
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 01:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204B2248F6A;
	Mon, 11 Aug 2025 01:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="egAtIAwp"
X-Original-To: bpf@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7923B13A86C;
	Mon, 11 Aug 2025 01:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754877299; cv=none; b=trQbbgXoqJIji8iku2r+mIZmqv2C+FZQkVZdNnRVgI7Br3/Z9Jaxa4PIVFSr1Phm+Kux+1InHmjnGZ7NWKQARwpw0iw7YMy+ZpFypx5wGS+2EboMg5Ap8zKzHicYFr7EjgdarRG0k+Q+SIWL13puU4BKx1ryBZXQ2bUQMqMI1dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754877299; c=relaxed/simple;
	bh=MsW5iFYmDRDqqZxzzTPiA4jhts6VKYHuqBPN+ILaagI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhZy5wbyQnx4srb6V2k2HFx/q3W19hYMVG2qsJd3GWf9iTkSaeygxbbzHL6C+2+nJzbxqybn+XnV+zZQsd5U2eARBHy6tyKC4mhrOpMFInwnj5Zl5Fl9NJHogU0FY1avp13hkI6CqYOeObelg6lN5WzJEFbl18MhmvKkCbMJ5lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=egAtIAwp; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754877294; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=VuAw+i/G0I3oN3Fd4kbgStHeR75gs940OMeQdyhmo7Q=;
	b=egAtIAwp6wuNZV5syh/e/R2Oawfe7paNkoEMiNjD/HXThNNULQ0D8Y3x3xIrH5DJ3dt6dR+791kIFB0HtYNdqOmy/q/JK3lTFZvM0r5yVxlnpg2g5m2OBrcDpIAGmStQBIZ0gXXmldR26COXCleHqzBnIizoMVNb/o1h26xrAcc=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WlNSY4J_1754877292 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Aug 2025 09:54:52 +0800
Date: Mon, 11 Aug 2025 09:54:52 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, sdf@google.com,
	haoluo@google.com, yhs@fb.com, edumazet@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
	Mahanta.Jambigi@ibm.com, Sidraya.Jayagond@ibm.com,
	wenjia@linux.ibm.com, dust.li@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	bpf@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	netdev@vger.kernel.org, jaka@linux.ibm.com
Subject: Re: [PATCH bpf-next 2/5] net/smc: fix UAF on smcsk after
 smc_listen_out()
Message-ID: <20250811015452.GB19346@j66a10360.sqa.eu95>
References: <20250731084240.86550-1-alibuda@linux.alibaba.com>
 <20250731084240.86550-3-alibuda@linux.alibaba.com>
 <174ccf57-6e7c-4dab-8743-33989829de01@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174ccf57-6e7c-4dab-8743-33989829de01@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Jul 31, 2025 at 02:57:31PM +0200, Alexandra Winter wrote:
> 
> 
> On 31.07.25 10:42, D. Wythe wrote:
> > BPF CI testing report a UAF issue:
> > 
> [..]
> > 
> > Fixes: 3b2dec2603d5 ("net/smc: restructure client and server code in af_smc")
> > Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> > Reviewed-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> > ---
> >  net/smc/af_smc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> > index 1882bab8e00e..dc72ff353813 100644
> > --- a/net/smc/af_smc.c
> > +++ b/net/smc/af_smc.c
> > @@ -2568,8 +2568,9 @@ static void smc_listen_work(struct work_struct *work)
> >  			goto out_decl;
> >  	}
> >  
> > -	smc_listen_out_connected(new_smc);
> >  	SMC_STAT_SERV_SUCC_INC(sock_net(newclcsock->sk), ini);
> > +	/* smc_listen_out() will release smcsk */
> > +	smc_listen_out_connected(new_smc);
> >  	goto out_free;
> >  
> >  out_unlock:
> 
> 
> As this is a problem fix, you could send it directly to 'net'
> instead of including it to this series.
>

Hi Alexandra,

Yes, it should be sent to net. But the problem is that if I don't carry
this patch, the BPF CI test will always crash. Maybe I should send a
copy to both net and bpf-next? Do you have any suggestions?

Best wishes,
D. Wythe


> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>

