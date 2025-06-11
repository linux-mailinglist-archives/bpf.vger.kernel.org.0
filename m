Return-Path: <bpf+bounces-60340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C580AD5B71
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 18:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99DD51E126F
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 16:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609BB1E5018;
	Wed, 11 Jun 2025 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nq36cBtg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B595D8F0;
	Wed, 11 Jun 2025 16:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657912; cv=none; b=o4mCVW6IgfJr9BaZPH6E9HHjk+LXHt1Siz/knv6S+nocorgzPmvPY2ppCqaP/n3XTwVotjY/XJ0aEE2EgvdAjXLBdZGvJ5KyVQI8/4CopshTApTxLGDUwGvCLyRLodD1UWeKk4RMGXacNPVG6TvV+rll/QkLXUzWWytXY0RvSwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657912; c=relaxed/simple;
	bh=CSnYZ++y6v5Y1DTSjORaDJcPADhtw0bVJx427EIGzu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsZhrAlzixmpsbFsrG/IW58AGBSkaBYdjFwrmznm4L+43A/t6WFjXjcDTb33aSJ/BunG4aXU59bcCDe96e4AnSyP8w8SD1mWgaWJDhnWm8aL9YccugVy/V0VbuEZa0jvDbyYyBSogSpTOLWYxWJdlZ7rROJavb/cMhJWCj8S3RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nq36cBtg; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a44b9b2af8so164991cf.3;
        Wed, 11 Jun 2025 09:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749657909; x=1750262709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkcAG8UDHBBCkZWTrBhZdNUZRDSiJX3R2wXFpwTsd/g=;
        b=Nq36cBtgSPWu94HnNpK2/DaW+i2dIKbMDPopIi7jWipJFVUuAgFsoN6CZJ5TpGuMss
         ARHWQ9bymjIyoHntO9h/fCSdLLfW1shvww8/sLoflQuXeCJ54OVRKRR6juC2UtgcoFci
         kLh12MkQ42UTKK4/M3/F5zR0QPW5XoArOJcTi8mujnGIMOM9ZBRW47mgwimVIS19WiqD
         97KbiGY4vp2hILWpN34rAEl3oXV4aC6lKS0Qrk172XIzRvkEr1YzQXWp9rpweWYE7IWk
         SP2+M/TD/OafVlRzlJC+QjromNdXeC8Dt5xnHVGvrbsOFEHXsEL30/jQ2pcvAr40O5xw
         HVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749657909; x=1750262709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkcAG8UDHBBCkZWTrBhZdNUZRDSiJX3R2wXFpwTsd/g=;
        b=F33Ad7Q9BwSlGe28qLQUVFf1Hl1UEdWbmDlBR+zJRs4bZhXn5x9riQaSAD0JOMHb6U
         5iGCBf92ORcwvOq8Igeuwrt+SM2xNfE1sZCyVW9PhqVBL2UjATQ7naNujbOZp8r7HNbt
         MGIQSkzri+Ncx91+i6TYXgZgbUKV9vKuk0Mmh2G1mjzheiL7SyGePjr/gaWqcTVnD11h
         8LxSTzR6MukiKBy1UYV6idT83YhaX1+DeEcF+APnjZePPbPfjfkGyLZNuFpNlRJayxi/
         0OG+xm4wPHEhtrTrv9QqmxfyuWoZ4xRT76OpKjjprQPbKtzTIDHTtdX/ZmBvVqVXVQEt
         g/iQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9WYkuH4USzdaTvkr8ijcNPpFC7QNlL97/ta9B83gB6PsdZtsyiTKGRpuW9BDDtNgWT8k=@vger.kernel.org, AJvYcCWMFWGdmky7bmmoC2ldYgHZsRKYIm8wTVUOSTdMzmKXJMvZD8rlsSwLdRgKHHmphUkd/jUD@vger.kernel.org
X-Gm-Message-State: AOJu0YyGjG1FOWfEhzcHXRlMoDd3KkDVW3JTOFg5cqS6GDvTXaoDAu8D
	Lb1jqUFTDKls+pIhxrG9h/iGs2txSyAvkDBJGhW4WVu2QMMIBPYba1wK
X-Gm-Gg: ASbGncscmelTQHpzr3Cv/tbhLH+ENsnIzW76HnhA5jqEvj2BxBfpDnhRgsi6h99d3sn
	3FpfuPkgKEZAhgKy4JjXNWJJK5lZMyOKhR9DZMrWBtZpkpKSJQPgm9Ig8q6Nfy9YtQMxtJXK5XH
	3AOpvkWgOj0Rstaev/CpCd2OQxAj6jmKu/3P+I8E8T6sTChQfKadPCzDDiV4jjwdJXGUq81wc2T
	980cbzxgQDxkekHupjxdvzmsUPiIAots6n4UJOtbYeFlmVIqhlrouutHcnjIyGalZyJw5Ng0WyU
	NNHAquPnrQi0WCmzrsJU0/csn/GLv63thTF4tTX3aQVHvbn2DcCPh3OrfFfQDpSopmmEpWESeun
	+JdTPJcobWv7+3t91mfhqSnGEGIPT/KZDrLB1T6lbyLFYcVXiiPhz
X-Google-Smtp-Source: AGHT+IHn0OfArCOgZJXiU167Jgmx7s9bhvzHybhKaFSAQ93u0NQgeMZQ6mLgt9U6w6eLj5BOQyFYYA==
X-Received: by 2002:a05:622a:1f9a:b0:4a4:30f5:b504 with SMTP id d75a77b69052e-4a713c221a0mr60374931cf.27.1749657908649;
        Wed, 11 Jun 2025 09:05:08 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a619852c5bsm91384521cf.45.2025.06.11.09.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 09:05:08 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9AB14120006C;
	Wed, 11 Jun 2025 12:05:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 11 Jun 2025 12:05:07 -0400
X-ME-Sender: <xms:M6lJaDvPDVDiOIkTw_drSiKYoU00Zd7YRGOVxM50leEH8NxGOcHCFg>
    <xme:M6lJaEdaavpZh1zrAq8ZjE4psSW8IO2J8EyXbloNWSc3lKhyy3kz1_iwaDBJDMuxZ
    w0B71xTk2FvPKrqqA>
X-ME-Received: <xmr:M6lJaGySOO8O2eq1al9gZKZlvyon9iDloASYFbTtO0u04-JniF6ZjzRGkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdet
    heduudejvdektdekfeegvddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehjohgvlhgrghhnvghlfhesnhhvihguihgrrdgtohhmpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruh
    hlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehnvggvrhgrjhdruhhprgguhhihrgihsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehjohgvlhesjhhovghlfhgvrhhnrghnuggvshdrohhr
    ghdprhgtphhtthhopehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgpdhrtghpth
    htohepuhhrvgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthes
    ghhoohgumhhishdrohhrgh
X-ME-Proxy: <xmx:M6lJaCPMFpdjuuhOVv-F_weyEjcM3-ie6kKWUoUDIAGlADuOb5wXpQ>
    <xmx:M6lJaD8hpJat4-jCD4oyz7zoC1B7-xdquVKURdFIs1ygXJFndO4tnA>
    <xmx:M6lJaCVeu2JRabQI1RqFRi70mpNKbpC3PK8crpzKyUXOYiACfP73ag>
    <xmx:M6lJaEflFbPieL9-DxqaHhjyjfcL8L1sxss53CdSzwnV5001p6nGhQ>
    <xmx:M6lJaBc2deSKQElIAIX_V3cq527YeTKgEz8RZ5qSlunGTDvfjCQ8zTjQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 12:05:07 -0400 (EDT)
Date: Wed, 11 Jun 2025 09:05:06 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Xiongfeng Wang <wangxiongfeng2@huawei.com>, rcu@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] rcu: Fix lockup when RCU reader used while IRQ
 exiting
Message-ID: <aEmpMohtFsVf4Uh_@tardis.local>
References: <20250609180125.2988129-1-joelagnelf@nvidia.com>
 <20250609180125.2988129-2-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609180125.2988129-2-joelagnelf@nvidia.com>

On Mon, Jun 09, 2025 at 02:01:24PM -0400, Joel Fernandes wrote:
> During rcu_read_unlock_special(), if this happens during irq_exit(), we
> can lockup if an IPI is issued. This is because the IPI itself triggers
> the irq_exit() path causing a recursive lock up.
> 
> This is precisely what Xiongfeng found when invoking a BPF program on
> the trace_tick_stop() tracepoint As shown in the trace below. Fix by
> using context-tracking to tell us if we're still in an IRQ.
> context-tracking keeps track of the IRQ until after the tracepoint, so
> it cures the issues.
> 
> irq_exit()
>   __irq_exit_rcu()
>     /* in_hardirq() returns false after this */
>     preempt_count_sub(HARDIRQ_OFFSET)
>     tick_irq_exit()

@Frederic, while we are at it, what's the purpose of in_hardirq() in
tick_irq_exit()? For nested interrupt detection?

Regards,
Boqun

>       tick_nohz_irq_exit()
> 	    tick_nohz_stop_sched_tick()
> 	      trace_tick_stop()  /* a bpf prog is hooked on this trace point */
> 		   __bpf_trace_tick_stop()
> 		      bpf_trace_run2()
> 			    rcu_read_unlock_special()
>                               /* will send a IPI to itself */
> 			      irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
> 
> A simple reproducer can also be obtained by doing the following in
> tick_irq_exit(). It will hang on boot without the patch:
> 
>   static inline void tick_irq_exit(void)
>   {
>  +	rcu_read_lock();
>  +	WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, true);
>  +	rcu_read_unlock();
>  +
> 
> While at it, add some comments to this code.
> 
> Reported-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Closes: https://lore.kernel.org/all/9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com/
> Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[...]

