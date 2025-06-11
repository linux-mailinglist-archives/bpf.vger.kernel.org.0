Return-Path: <bpf+bounces-60345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E248AAD5BF8
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 18:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34903A58F1
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 16:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B66F1E5207;
	Wed, 11 Jun 2025 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUhXIjv+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511668828;
	Wed, 11 Jun 2025 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658907; cv=none; b=kXGqPoUDc338HfpVyf1rllQg+4LGoT5uo3+pH+xnae6A7ehMZnRqk4LLgy/r/ZLgakWF3p9vkj886PvwFh1Lv2ZgHv6ntHvQrzC5dRxxpYiFfhTJbZ5t2jz89WjFnFfFUb7NwkjJd8Klbn6+l5UITZ7mAOjEBKvglT0aq47PozQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658907; c=relaxed/simple;
	bh=8CRIh69EyfjvaHKU5sQ1XIZ/l/ajlYcwJtr1I6utixQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2ybtdoTdyj9SByQ0uuKyOfnc3Lp7uRQtrvwdkAZtORCNhx9UtfhVZ4EUgjBHrmIg8276iUFzds/TKw22+Ju9yZlzXvleQKkSnXTJPjED+fLuIZjCBEYQGAZlAZNlSTuPVfj/k3RQh7Ld1aYzwwyAGdBq+YQfR7M1JIiTlJpmxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUhXIjv+; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fada2dd785so1062046d6.2;
        Wed, 11 Jun 2025 09:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749658905; x=1750263705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VP4/v4+c48z4rifbWH/5ulFSxvfp2M0yJ/8pTtIhn3U=;
        b=MUhXIjv+3mDgCLtGK2voyvNGzCYjlHC16t6QAjMGR01glXvrVqVm0VPF4hcMnWkKd8
         9uLYj4afIPPdd4F6+KRJ+wIPd3DiHURYfVOOmBGEXgRePqS0MmZBHN1dR8NyhgVOME64
         d9nohTUv/6aRHRWVzUuo2EGTrDfTYaKQYu2mSqFkA2K0/IyuTHaMYiQ/E2qdpAoRyg3g
         MOpHCk/EYbE3YFpYJOfCIrU7Sm+rSkkxv5Xj35/G8Nj2nfQfwDngexNhWensB3xuowvN
         yaJnVNAZyfZUY6QuizzDpWKMzbuCngEx3KkBECJvb0dnPM3JbWmq6Pt3ple6z6jTnQLU
         H/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749658905; x=1750263705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VP4/v4+c48z4rifbWH/5ulFSxvfp2M0yJ/8pTtIhn3U=;
        b=dVEx8r3ScLHZbczFWvq28czw7Xgjc1VdDhiPU3YQLkIHdGdMKFu9+NnDb75Mwb1+0L
         eTVEpDq5+aFYGZPFhwtuzx3eXU64LQcNpQHkWG57Kh3kGBJC/xdmtV01FzljUB8mZ6KI
         5K0UiE7OJaZZCVDyEUrxO02c9CtOZ8ioAGb/qIDNeU1U+PnblLr193XNhY7s3JJfSTCm
         MwLEIWl9H2kalnPKAaIEx5NtgXJuBAdEESAweddKlOI6ZrOJVU+835wNAkGlm4VykiNm
         VXnpmoy19KNTshXOm3Od1l3tkdN6fV5nGI7IjeGQFPEnQoe+WWbbS8r+HjNjfcw89H8H
         bXNA==
X-Forwarded-Encrypted: i=1; AJvYcCV1ujhADGtx8ywp1LU4tG0rpCjnMuGr12PI0w4n8Cfzu34/4E7hXsy8hUl94BTB0OTF7uA=@vger.kernel.org, AJvYcCWvYmINrE19HJNqPNiqd6jJv0KVZ2hx1EJ/zdstdH65k71Q2hRc1Jd+wL5vjqr0sJDv/NwJXWQuxx54sngi@vger.kernel.org, AJvYcCXLAS7v95eB2qzUtL4g3U5g/Cu0znzXsd994OoNzaoZDnOde40ko2VNXVy6u6HOAPqovYu/@vger.kernel.org
X-Gm-Message-State: AOJu0YyFHEHDQ2YRMrMk3V5MzNHxqX0nE9K+sndlPlueFREEISF3Zr1o
	jhM+htsf1FpS5YpcTruPm+/IytBSlf8KBhxQABfbEu52iTMFHvlEPvSl
X-Gm-Gg: ASbGncvftwST1rS0FV5d3kUnU3iXVDNOGQvDN/336QG57FCsY6Wpv132XE4jNkmRGBi
	4l/coFXj3ra5tXBQwvLvlQWCa+uwvSiWKJ+3W95NwaSXQyK2f16Qar+QeyvtqjnTvQemeSgySvI
	46nwUnQj2S9ndsVPrKD7mmT0yc2fHUYfuH7ZuTfnp64nZWIPS+gJMI183ACxyqv4PVqkiKZuqx9
	UWv+gtlR2oy39jtKs1/ywKYIH9Dm/Qx9bGKk3YsChkhx99JWUklyorO1SSpdG4IfwxCKbx7lTmW
	VLSOQCfkjYnbFqU1bswTkYWsOsA2XmTTpPoCyEcD3VXDS878rQoqna49L8pDWzyPuFTJF6/3J3h
	qX1w6GgSkajdW5lnFJtp9QkEb8x05L5OV3pJZqepoKBdyTBr68kin
X-Google-Smtp-Source: AGHT+IGFTqWko7Ow7Diy0KqMnYhHo7JmV0L6/EAhWea/i+8wem+djZ4ARdjdUqKqBiSkbCtF/B2wmQ==
X-Received: by 2002:a05:6214:2b08:b0:6fa:c81a:6228 with SMTP id 6a1803df08f44-6fb3466773bmr2141686d6.42.1749658905080;
        Wed, 11 Jun 2025 09:21:45 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09ab8a19sm83244206d6.8.2025.06.11.09.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 09:21:44 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 43AEE1200043;
	Wed, 11 Jun 2025 12:21:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 11 Jun 2025 12:21:44 -0400
X-ME-Sender: <xms:GK1JaG3ETSvuKcXNeKxWDBZFb7saYbVABYXq5B6IHtG5wBYOs5RJiQ>
    <xme:GK1JaJGsCDG0yaAQ0ooATrFRJBcAxGXXwLpNt5b-ky3e-mrOGc_F16NuPoaNvePQT
    2qPdD8OP2FUgIwNlA>
X-ME-Received: <xmr:GK1JaO4XyHbERZuu8j8pgwWk5UgLQgLWadGWcUt5rJsTBFSW9cQWWI_CKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdeihecutefuodetggdotefrod
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
    hopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohgvlhgrghhn
    vghlfhesnhhvihguihgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehnvggvrhgrjhdruhhprgguhhihrgihsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehjohgvlhesjhhovghlfhgvrhhnrghnuggvshdrohhr
    ghdprhgtphhtthhopehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgpdhrtghpth
    htohepuhhrvgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthes
    ghhoohgumhhishdrohhrgh
X-ME-Proxy: <xmx:GK1JaH1w_RCpQEERA8nT-dz4BoLCp22VlpAKDNpz1e2pYQ8P7exvwQ>
    <xmx:GK1JaJH3eERg-2A6MnVH9Z4vtYc9tvuplM7f7_TRArGsMCURmZpHNQ>
    <xmx:GK1JaA9LgE7LFG8-HoAWD7gG-ecphAmN9alNqHC-OBJ51GR5-02piQ>
    <xmx:GK1JaOkAgVZIHvtAv4n51GW-Q2cMvJ2HCKh5gSNy3yRJ295r_-c6Gg>
    <xmx:GK1JaBGGO6mpuJ0ep9WgtPan05sfUyS4perpJUTEUrIuGQVypnRda_Nx>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 12:21:43 -0400 (EDT)
Date: Wed, 11 Jun 2025 09:21:42 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <aEmtFr3sHCgLpWoT@tardis.local>
References: <20250609180125.2988129-1-joelagnelf@nvidia.com>
 <20250609180125.2988129-2-joelagnelf@nvidia.com>
 <aEmpMohtFsVf4Uh_@tardis.local>
 <2a0902a7-852b-4868-b0c5-2a6962f273ed@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a0902a7-852b-4868-b0c5-2a6962f273ed@paulmck-laptop>

On Wed, Jun 11, 2025 at 09:16:05AM -0700, Paul E. McKenney wrote:
> On Wed, Jun 11, 2025 at 09:05:06AM -0700, Boqun Feng wrote:
> > On Mon, Jun 09, 2025 at 02:01:24PM -0400, Joel Fernandes wrote:
> > > During rcu_read_unlock_special(), if this happens during irq_exit(), we
> > > can lockup if an IPI is issued. This is because the IPI itself triggers
> > > the irq_exit() path causing a recursive lock up.
> > > 
> > > This is precisely what Xiongfeng found when invoking a BPF program on
> > > the trace_tick_stop() tracepoint As shown in the trace below. Fix by
> > > using context-tracking to tell us if we're still in an IRQ.
> > > context-tracking keeps track of the IRQ until after the tracepoint, so
> > > it cures the issues.
> > > 
> > > irq_exit()
> > >   __irq_exit_rcu()
> > >     /* in_hardirq() returns false after this */
> > >     preempt_count_sub(HARDIRQ_OFFSET)
> > >     tick_irq_exit()
> > 
> > @Frederic, while we are at it, what's the purpose of in_hardirq() in
> > tick_irq_exit()? For nested interrupt detection?
> 
> If you are talking about the comment, these sorts of comments help
> people reading the code, the point being that some common-code function
> that invokes in_hardirq() after that point will get the wrong answer
> from it.  The context-tracking code does the same for whether or not

The thing is that tick_irq_exit() is supposed to be only called in
irq_exit() IIUC (given its name), and so without nested interrupts,
in_hardirq() will also give the wrong answer.

Regards,
Boqun

> RCU is watching.
> 
> 							Thanx, Paul
> 
> > Regards,
> > Boqun
> > 
> > >       tick_nohz_irq_exit()
> > > 	    tick_nohz_stop_sched_tick()
> > > 	      trace_tick_stop()  /* a bpf prog is hooked on this trace point */
> > > 		   __bpf_trace_tick_stop()
> > > 		      bpf_trace_run2()
> > > 			    rcu_read_unlock_special()
> > >                               /* will send a IPI to itself */
> > > 			      irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
> > > 
> > > A simple reproducer can also be obtained by doing the following in
> > > tick_irq_exit(). It will hang on boot without the patch:
> > > 
> > >   static inline void tick_irq_exit(void)
> > >   {
> > >  +	rcu_read_lock();
> > >  +	WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, true);
> > >  +	rcu_read_unlock();
> > >  +
> > > 
> > > While at it, add some comments to this code.
> > > 
> > > Reported-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> > > Closes: https://lore.kernel.org/all/9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com/
> > > Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> > > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > [...]
> 

