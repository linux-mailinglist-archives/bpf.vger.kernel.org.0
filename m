Return-Path: <bpf+bounces-64596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3CEB14ACF
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 11:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B0616EABA
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 09:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1466A2874F0;
	Tue, 29 Jul 2025 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYZKIDnd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF3327A123;
	Tue, 29 Jul 2025 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780204; cv=none; b=pPy0DJdqTx2vO3Eg0ADTyEIBQJdwW5LEzSiujjwd6ouIcLZA/7+QjeEkTXxK30EXQedvR7fXLkp/Yg9/A1mFXfghg6v9gwbl8A8qLEci2Z6f5XQm8PVpAqBfcv6e7s3E6TYnIZ1gXND5ieXjpX1fX2RJLdztMxk8SQi8xc3K/fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780204; c=relaxed/simple;
	bh=9LilFwsyzXEBNISNDgSQr3EDtxWlqZW1O/7Hpct2THM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9MvwYNc0oHDzMQsxzxxDI1LDKAYrxgTYDqcRW0QGA5YuUJGatNo/JWbGGYAqXaXbkLwjD8G4DOyVy1TUC3nVO7KmgofGDm1pDdcqeXPA8HEmP17INsplDs6OA7kxGPU2KA9xqeiZKj2VhOWSFiUgQ2CmfLG9QVu1acNNxiI5uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYZKIDnd; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b782cca9a0so1841129f8f.1;
        Tue, 29 Jul 2025 02:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753780201; x=1754385001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WDxjHKxEk4bzUf242dYSPxRTJXLTbFhf7MDZw//NVfw=;
        b=AYZKIDndn/BeyVBnC1LqL5KfNdQ0m9YBUDRW1Oy3spsdy7bMrRg2vB1A4zixw2R2+y
         qu15Upi2cpl9wBejFxE88wmzYW/LwHpQe5eIJFbU0PPXYSQTWuyLPoxd8L0Y/oSZtfmQ
         iUkvHlL3IbmQ3DO+DK+tqS1WBVJjrUPmds02hyTOHMY/h5zRQoVu+o8j+Stq9+zbQTHf
         OHkOQG6vNZGKMhdGsBdzTPpUurs6vDjLZe/6YHzoHpNDs28A7pSs9NdvG47TenD+94+N
         lCh+OQHzaIXr/HVjRQAlJsBuseOBvSeoS7nQ4EuPQJOjLaf1Au/NWBb8FqwznugBfINZ
         CuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753780201; x=1754385001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDxjHKxEk4bzUf242dYSPxRTJXLTbFhf7MDZw//NVfw=;
        b=r5fcRbFxeorw5pHeRSeIRiPPbL0sAuKN2FQMJLKQY0/U5QPy17JdgwcuNWg/iVoSRl
         1Dz0yPF4pcXhiyb9f2aH3DzB0+Nul0K0Eb+BLZjlYkQGMKeiimVqa0piKqHVUzflQh0Z
         APT1MNqpUtFpnn3N3mCUNH1fNZv2BP8/0XbAgCfP6aI73deK8S6m8J5QWSHsiL6+saLv
         VZ/bI97w2ObS+hTO5PxG265amrwD3/FkMyKChx+cNB1O2CeUxXdSqffXkN8EIY/sXO9o
         fBd6tbVdLR1YLb3IrDHTB1a3SwRsBGB3z6fANWOeZp2l4KJMavWnR75zTN83wDssLzZk
         k0jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUobXvRdIUYkmsr+Z73tg/CO8eqYupjt3W2bCzArUdsDRX5mL663dUKvagl6mqG5f4qndg5HZyz@vger.kernel.org, AJvYcCWHScNOgNOHw0g7LqtP8BMnK+/5PrLYqCmFY/UbViYzgRIEUMhvpkpJnvOibIeKsu5vTJ1l8hzi2l5yfoPcyuNn@vger.kernel.org, AJvYcCWx9dkwrcYNVwmNYx/13XTEtXBelYMaCQylQj3Eabr7jWmFVyUuKu4tMVTG2x0f6dFwBW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ4QmeJ+ijMOaQL/75S0yIlsh5HCJiWAI40WVQoZJZMscMZ2th
	IDFQBaVsCW/ffRSvele1oByRnsUJwGcWBLsOhND6N/nxUY7h4g/TjDwI
X-Gm-Gg: ASbGncv9uMZpxHkvYRY/AKO43Bw6MsCia/L/NZpPW7u4U3mfVyRf03XftIVEHCZ6s7a
	8cm5rMF+sogxXZsvnFE0/ol6oasFw9aOfpkASyHl1B9dRhQHOVqeM0NtL2zPKLUiXGG84d+D/WI
	RC7uznSb3cyIZjmliDeST3/kwax2zhAmpCMUMMwSGG3Zx4nmouhbT3j4+pVWFFU0JJeQRPsLTol
	yKOzTT+juC0CdRbU7jsAMaNQmn4FyQ/lg72NSB3XVutFlXZuGaAyV3SILbnEdGKhhtl7xuNqhDa
	u04lbRsnUNQeGU0z8AS2QWHNHQPt5KjqHxn78f+QopbpBirRdwazLauxHHSZ43CMhbWzlRUB9r/
	nw9FZ+VtA+PkE0VkLVgkCdaRX5TR7vr79Wru7xBfLxxH8qNo6wPY4r5o+O4hpjIUcYQ==
X-Google-Smtp-Source: AGHT+IHH8+al9qv6iocTAD7WJesBvsnSwWK7+DrhIw3/VbdqC+a5NBS2dU6E/8+5gIjse9mgfZInQg==
X-Received: by 2002:a05:6000:4a1b:b0:3b7:78c8:93d1 with SMTP id ffacd0b85a97d-3b778c89877mr11705436f8f.21.1753780200926;
        Tue, 29 Jul 2025 02:10:00 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b78dd6cb0fsm2373722f8f.29.2025.07.29.02.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 02:10:00 -0700 (PDT)
Date: Tue, 29 Jul 2025 11:09:58 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, coreteam@netfilter.org, daniel@iogearbox.net,
	fw@strlen.de, john.fastabend@gmail.com, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	pablo@netfilter.org, lkp@intel.com
Subject: Re: [PATCH bpf-next v3 4/4] selftests/bpf: add icmp_send_unreach
 kfunc tests
Message-ID: <aIiP5l24ihrS2x-u@gmail.com>
References: <202507270940.kXGmRbg5-lkp@intel.com>
 <20250728094345.46132-1-mahe.tardy@gmail.com>
 <20250728094345.46132-5-mahe.tardy@gmail.com>
 <382ff228-704c-4e0c-9df3-2eb178adcba8@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <382ff228-704c-4e0c-9df3-2eb178adcba8@linux.dev>

On Mon, Jul 28, 2025 at 06:18:11PM -0700, Martin KaFai Lau wrote:
> On 7/28/25 2:43 AM, Mahe Tardy wrote:
> > +SEC("cgroup_skb/egress")
> > +int egress(struct __sk_buff *skb)
> > +{
> > +	void *data = (void *)(long)skb->data;
> > +	void *data_end = (void *)(long)skb->data_end;
> > +	struct iphdr *iph;
> > +	struct tcphdr *tcph;
> > +
> > +	iph = data;
> > +	if ((void *)(iph + 1) > data_end || iph->version != 4 ||
> > +	    iph->protocol != IPPROTO_TCP || iph->daddr != bpf_htonl(SERVER_IP))
> > +		return SK_PASS;
> > +
> > +	tcph = (void *)iph + iph->ihl * 4;
> > +	if ((void *)(tcph + 1) > data_end ||
> > +	    tcph->dest != bpf_htons(SERVER_PORT))
> > +		return SK_PASS;
> > +
> > +	kfunc_ret = bpf_icmp_send_unreach(skb, unreach_code);
> > +
> > +	/* returns SK_PASS to execute the test case quicker */
> 
> Do you know why the user space is slower if 0 (SK_DROP) is used?

I tried to write my understanding of this in the commit description:

"Note that the BPF program returns SK_PASS to let the connection being
established to finish the test cases quicker. Otherwise, you have to
wait for the TCP three-way handshake to timeout in the kernel and
retrieve the errno translated from the unreach code set by the ICMP
control message."

I added this comment because I already had some (offline) feedback that
this looked off, maybe I should develop and put this here directly.

> 
> > +	return SK_PASS;
> 

