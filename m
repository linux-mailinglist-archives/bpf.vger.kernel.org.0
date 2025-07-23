Return-Path: <bpf+bounces-64217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3510EB0FBE5
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 22:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36CBC3B30C7
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 20:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DD8233D7B;
	Wed, 23 Jul 2025 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9Hc8orF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC4B1F7060;
	Wed, 23 Jul 2025 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753303840; cv=none; b=NwJCMB1FUh5zhm5i1OL9jTV6K0ozACjP9vQ8zE3405TwBcjYf7YsfNj4HKBUNu+uhCX5VQJ6dqMusH5nGBOD9Gcovgf0l7QWsFN+FLuyux9YW4wViA+lGoclQ6/7fyCOx0XIndm7VBTCwBIakC9jZaOkH6X9FTwWJ/otyaXUpEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753303840; c=relaxed/simple;
	bh=Kt4W4LRmqP3URUZs53JYP2RLlcnLf4filFpYCdQwwpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlJPAWxqPJEYat4aZ20Kj8xpQAnHgHuzqcNLfLQLn/MvRJn5pPMfd0XAv2hW3RoZ8X9je014wSKm6nRdubRGD/IhmpPoennbRj2FRvjhtUuWXUCABXRpVpaOA5Mw5hAJt/45AxfsOjPo2+yQb9Fg7DwldcqGn6/IEH0ql0PIFd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9Hc8orF; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e62a1cbf83so35070085a.1;
        Wed, 23 Jul 2025 13:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753303837; x=1753908637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHe61ynxrIRaJjEK6/DtzGfqVDDt27fnxlcEzrAl5gs=;
        b=L9Hc8orFooKekdWh0b8PaLH+btvvrS3wJ1Mzrn/ntYu8rZErSGHQ8xkRyfgkeSA2I2
         pnPzXsGPTmBoOS6aSIIwQ/syPRPg2SnQFf6P8TklpbU0MGY40n8AEDgBg0mTG3E+wmz1
         HDJdMdy8Uim5xJ0YCn2K5AzchKf2uO79+jEZRwcbOcrtdWmYXQ7Q2kPTb9gZM6ZZjQfu
         Da2fOejwRumQ5jV1ANXEBwO2gSuA6qZASdVXXhnBtLH04EM1n0CKC/s+bA3T2oxKxuML
         ZLLk2IXvN1/MQk31+F0C+i57L0rvJRWe7BjyTsTZV2q5oHkl/yx3DCMqT61vsgoWbLZR
         zOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753303837; x=1753908637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHe61ynxrIRaJjEK6/DtzGfqVDDt27fnxlcEzrAl5gs=;
        b=T1qRjgTW51NSdFt0fJQ2jJI/7kUHcCfXF7xM2s3pXYXUqwuuvwe2BYJaDaNGNawrV+
         4BvVqSeULg0Rse9G4bZwnz9Qy1M9AzwmI2g9bOMbo7edOA8p2sVv1ArigySpA0jsYpxi
         y1vDXHJePLXXoqjIb7n51pcxmOJthc3o8LJhgZvnvyGCIh3PhuAeT2EwE86xTXNrDcy0
         0/fnbjasJNzMq4WEq8pokuyMQD6vET5pEpMkTxzDk0rcFiF57e28GyAlGqoJV4tkDrx2
         NupjXs9eaWGH1pRSX3ufSMPbSWz32iwfpuqZhqKepzDfEdXBsTkx88p5RlWA4Rnb31cF
         JR/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVL9o2WidCSkX1cNHRaIcEb9Q9QMPyDNNtpOQj1BMvFimGX0RGbdbGBwIEoBgHvZ5UMcAhdtUkYj7drJub2@vger.kernel.org, AJvYcCXTA2PwDJQuWu1bA/gGt8Iwlx2BELVw279O6CX9zbiZ+L9apJRVfXT7L0E4p1gZapDSz50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKSchxcA/KTIrj2DVUIsBGEnlwLCl4zpaHxX+fYKidA8YN7efM
	OMMT7RyIaI6XCRGTy6R0LYin++ttC7VwjlWP1Il1ht8Hl4jei3/tyO2k
X-Gm-Gg: ASbGnctxOQTm8JOUVLrPkwnINvMg14XfNPzoy1vldUwjHLoNEEBLzlEjqcqM83pfpwM
	mRLkBx5dTIYSOnzNbJePf3s4UdXwaPG9fzAIRNRyxSqlXkmoYxqw6lcU0jsqYeEeCeKeHJp26CR
	ZyKHZBOyFPpp+2cuthSLrps5OZJnzm7HTfKVEYuwj+/kVNx1sUOthXzc1clvEH42VXvLz/28Fl4
	6BiNUV8qx1mGQj5eONcYlHYVzt2Q3Oct1maRWmxX7cu+u+GhseR9yWwqHzFmZIhwkci5uwrC31/
	UEbsffL0CKuBoPbJI/CdiWHPv4mRDWflki/2NE0Hx4Xry0sJKTHcp+7pFu9x1ecY2fpqBrzeQOb
	az0Z+g39LuvAm7S8yEjZxIi+fEd3+7RuSNh4i6hpwefC6p3y478BoHTE4T0MjbFR6UTTCGD1AfO
	tcpIUT+9ocCkeHisJLQJ/utqscIHPSuYyWrA==
X-Google-Smtp-Source: AGHT+IEw4L0+jKrVa/3NbmJsoKLqWZHQF6onFwNFmAV94joAuLsy5LA12hjYo9gfi+CNR6gPyRSkdA==
X-Received: by 2002:a05:6214:c81:b0:704:f7d8:7030 with SMTP id 6a1803df08f44-707008c1463mr77921846d6.50.1753303837303;
        Wed, 23 Jul 2025 13:50:37 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7070fb380d5sm1347246d6.30.2025.07.23.13.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:50:36 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7E209F40068;
	Wed, 23 Jul 2025 16:50:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 23 Jul 2025 16:50:36 -0400
X-ME-Sender: <xms:HEuBaO_Q5f4NrGXcbok3X9IOThVOa03iL4kxjJtGFlg3wWiqdF397A>
    <xme:HEuBaMEYpXOnpsAQkZqeiiGjdqvE-GWT8tAebNOSkxWPOSuzot7rECJvr-bx9ahdG
    PWPrfgyr7JrO-A4lA>
X-ME-Received: <xmr:HEuBaNgA54PyZlVcVtVTFFzkJZWqGK5TSjYa4NKK-MMVLrUO5IEtdVIPqkU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    uddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprghulhhmtghksehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhmpdhrtghpthhtohep
    rhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopehjohgvlhgrghhnvg
    hlfhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgrthhhihgvuhdruggvshhnohih
    vghrshesvghffhhitghiohhsrdgtohhmpdhrtghpthhtohepsghighgvrghshieslhhinh
    huthhrohhnihigrdguvgdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:HEuBaBsuuFSwaL9YBw-_TfCAiS127ek9UD62BFI1UDrRQUyzMCwr1g>
    <xmx:HEuBaItpNNnWeclm5gxmoDQftXseKlRqZvZrbb2cYUunQ7Qh0ar0Dg>
    <xmx:HEuBaOEVll8y3azX8qA0n4BlAgGiKQw4wzijrjgsI8-nZvM_uau0Bw>
    <xmx:HEuBaLNJ4Mp30pftni0wMk9xfOY0YmMYPqvJtYg2CQMTjdbAnT52rw>
    <xmx:HEuBaFJOhd6GZvhb1ih8qU5goabqap4BrbE768yUhhbVOu880t0i7SwJ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 16:50:35 -0400 (EDT)
Date: Wed, 23 Jul 2025 13:50:35 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Joel Fernandes <joelagnelf@nvidia.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 2/6] srcu: Add srcu_read_lock_fast_notrace() and
 srcu_read_unlock_fast_notrace()
Message-ID: <aIFLG91VhtjN8iaf@tardis.local>
References: <45397494-544e-41c0-bf48-c66d213fce05@paulmck-laptop>
 <20250723202800.2094614-2-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723202800.2094614-2-paulmck@kernel.org>

On Wed, Jul 23, 2025 at 01:27:56PM -0700, Paul E. McKenney wrote:
> This commit adds no-trace variants of the srcu_read_lock_fast() and
> srcu_read_unlock_fast() functions for tracing use.
> 
> [ paulmck: Apply notrace feedback from Joel Fernandes, Steven Rostedt, and Mathieu Desnoyers. ]
> 
> Link: https://lore.kernel.org/all/20250721162433.10454-1-paulmck@kernel.org
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: <bpf@vger.kernel.org>
> ---
>  include/linux/srcu.h     | 30 ++++++++++++++++++++++++++++--
>  include/linux/srcutree.h |  5 +++--
>  2 files changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 478c73d067f7d..ec3b8e27d6c5a 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -271,7 +271,7 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
>   * where RCU is watching, that is, from contexts where it would be legal
>   * to invoke rcu_read_lock().  Otherwise, lockdep will complain.
>   */
> -static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *ssp) __acquires(ssp)
> +static inline struct srcu_ctr __percpu notrace *srcu_read_lock_fast(struct srcu_struct *ssp) __acquires(ssp)

Hmm.. am I missing something, why do we need ot make
srcu_read_lock_fast() notrace? I thought we only need those _notrace()
variants notrace?

Regards,
Boqun

>  {
>  	struct srcu_ctr __percpu *retval;
>  
> @@ -282,6 +282,20 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *
>  	return retval;
>  }
>  
> +/*
> + * Used by tracing, cannot be traced and cannot call lockdep.
> + * See srcu_read_lock_fast() for more information.
> + */
> +static inline struct srcu_ctr __percpu *srcu_read_lock_fast_notrace(struct srcu_struct *ssp)
> +	__acquires(ssp)
> +{
> +	struct srcu_ctr __percpu *retval;
> +
> +	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
> +	retval = __srcu_read_lock_fast(ssp);
> +	return retval;
> +}
> +
>  /**
>   * srcu_down_read_fast - register a new reader for an SRCU-protected structure.
>   * @ssp: srcu_struct in which to register the new reader.
> @@ -385,7 +399,8 @@ static inline void srcu_read_unlock(struct srcu_struct *ssp, int idx)
>   *
>   * Exit a light-weight SRCU read-side critical section.
>   */
> -static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
> +static inline void notrace
> +srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
>  	__releases(ssp)
>  {
>  	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
> @@ -394,6 +409,17 @@ static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ct
>  	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_fast().");
>  }
>  
> +/*
> + * Used by tracing, cannot be traced and cannot call lockdep.
> + * See srcu_read_unlock_fast() for more information.
> + */
> +static inline void srcu_read_unlock_fast_notrace(struct srcu_struct *ssp,
> +						 struct srcu_ctr __percpu *scp) __releases(ssp)
> +{
> +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
> +	__srcu_read_unlock_fast(ssp, scp);
> +}
> +
>  /**
>   * srcu_up_read_fast - unregister a old reader from an SRCU-protected structure.
>   * @ssp: srcu_struct in which to unregister the old reader.
> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index 043b5a67ef71e..4d2fee4d38289 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -240,7 +240,7 @@ static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct srcu_struct *ss
>   * on architectures that support NMIs but do not supply NMI-safe
>   * implementations of this_cpu_inc().
>   */
> -static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct *ssp)
> +static inline struct srcu_ctr __percpu notrace *__srcu_read_lock_fast(struct srcu_struct *ssp)
>  {
>  	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
>  
> @@ -267,7 +267,8 @@ static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct
>   * on architectures that support NMIs but do not supply NMI-safe
>   * implementations of this_cpu_inc().
>   */
> -static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
> +static inline void notrace
> +__srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
>  {
>  	barrier();  /* Avoid leaking the critical section. */
>  	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
> -- 
> 2.40.1
> 
> 

