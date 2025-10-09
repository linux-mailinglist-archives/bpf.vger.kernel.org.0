Return-Path: <bpf+bounces-70653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCADBC95A3
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 15:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 949FB34D531
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 13:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F802E8E08;
	Thu,  9 Oct 2025 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFC4lSDv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131152E9EAA
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760017469; cv=none; b=K9+ezuSMQ5plPtoRfV8XLzMNG+GDAFlSjDYrCJM7Dwq4aA1c8+xU1CKYeZ1ken+D/j4iRubvzn7/oTwrEuEZZs6MzGFgbz2GLQBKNdJtWVAaxpIDmmkB8MPkVqPMR36/en68ZOnDEJY5qGL8K2xEairbZh2Z1yF/f+ieoLm3D/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760017469; c=relaxed/simple;
	bh=AfQd4eXBYX6pk0lTRkKl0tbC5qgFPY+pgwyqd1nTAKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/GjA+8ShCTG7aXxwYyiHcs/VO8rCx7mmt1s2mypY4Wmeq4UafjNe9ZvyEJIAva87I3/G88Vq81IN2gWdDbuEdwunsUVGuSYnwKzxFFGGWMIbkn7tRfZpVFnOBFxqA3JYdwQK3yxjtMP3c2CTppSNaz6X+5HrNLrEOQ0XObddL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFC4lSDv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e29d65728so6012695e9.3
        for <bpf@vger.kernel.org>; Thu, 09 Oct 2025 06:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760017465; x=1760622265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h2VeigMuqBqn+JKNe17+kDrTPxxYQW4aD8ABYbzRWnQ=;
        b=MFC4lSDvouq+qwbPPgjQu7hYnGMWcPGW1DWMvmmiaqKGLGkvlerJoP3zloPFGj7K8b
         Ki6P5se0PDYjDaALUM05ND92qb6CVROQ9J7KCWR0DQdmtLAcUMrDuPfc+Cg6klg4STVa
         Cf9c7Ye2djtc9DsMeVxLP1Wekls9iI/MPJ6/9VLot+v64+M08MMPvhOqbZGFyhlfnC4k
         LtxzvUol/C9dzI8OJ5Q7nmf/XIdr3ObHoWqLaaCqwmsUnYDG7ClqfzwaRL72CTCWhvbr
         JMRHb68a9LtS14dp9w9D2YmhVyB//C9RISf0Y8+r35mMC8YJY2Pldn+RRzHyBtz0ijTt
         0tOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760017465; x=1760622265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2VeigMuqBqn+JKNe17+kDrTPxxYQW4aD8ABYbzRWnQ=;
        b=tVcQwbu0mzv5kYsWm7hsiT/Yfcg1d1ZeoKpEpKCGyIEADDJLbj6mL2cPAqVVp6fVNr
         cSayElzWWTuYZNnQz3LZEfIrBqqGhLnv19eiDReLSaHcT6Y7p7pkqt1FOyfRbWbziJF/
         gOLys7km37fp3KJUad+VTWVIccji3/KZLjy6fgQ0QBd9rsXDNwVdydDo0Qr6u6n7pZ/P
         L0ruqPSEkvh4WHOiOGgX1xbk+X92kDSU/52v/+cOMy6qEdKchVjs6jVmPdo5mamsRKw5
         Hvuz88Jr7zj0Tz1/LLHGVL8x4qKRcnb3ZoJb87idgANDS6ZEStQY+khNvEN8onDuuHpZ
         QU4w==
X-Forwarded-Encrypted: i=1; AJvYcCXXgrH6IQqovIYOHRm8cEo918RDtx9Wot26raaWYSJOHQ3xG+c2CObZrgSgk0s/zNzBiiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWNO4tdNWlR80uQuA0oJmY1rOfL4OomDgmAtoDr/kkKRzd0O23
	42YpzpRf56Brbqw71BUWizpmconOJS96OevQZ/adv7oRJ2XrVDXwmrZe
X-Gm-Gg: ASbGncsqECj5nLPMNRol1INsLhb70ilVnZxwoojeKl0e6ZSzpcG6x795dEjps8qGdbp
	T0RuBW74IeJSwx8l4AR+Hn1a+/xed0jL8TO/YeqEHLFEoJUjzbsEFU3zxO+iAE6PKxtc/8RCavs
	ZNWHfnWC8ybfyTI5cTsfhDymunVrava37sp8KWPzEGYgTS75ySVYybmnA533ReLW/TFILSn++J8
	wQUtiXJdYhWxCwaR6oNBQiQ2EDhPr4l37otM/ycEBASd8AHkOaV+NYBc62f1VgC/IBehczhjl7L
	n+zfrLVUOAii02DVCbczn7YZCYgQOcoEVxgeBeBw2Fg4jtuX/0TcXrAfyRKdqnHkXoNqHaCxfYA
	JIIsvxpbzNAilkDbyw+nRbfNxN4mCCQzMXMWUwAZ4/7MMJKsIadhDLpxflvAQSo9+fStRylhUHU
	udp4gw4sfDP6nEfzr2OyqvhWZ9nxWiMlZ22uSKG+po10aj8panllJ8qPag
X-Google-Smtp-Source: AGHT+IHEqk4IWiyKlCfKQcVglNrBYrnh8mjWf0Z7nUrsYIF4dO4I6GeqxfBn48yetEL1ry9cS//MTA==
X-Received: by 2002:a05:600d:416a:b0:46e:3f75:da49 with SMTP id 5b1f17b1804b1-46fa9b11794mr45804195e9.37.1760017465144;
        Thu, 09 Oct 2025 06:44:25 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b81184fd69385167.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b811:84fd:6938:5167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9d4c89esm86922145e9.13.2025.10.09.06.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 06:44:24 -0700 (PDT)
Date: Thu, 9 Oct 2025 15:44:23 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v6 5/5] selftests/bpf: Test direct packet access
 on non-linear skbs
Message-ID: <aOe8N8IQ_-0ILBVg@mail.gmail.com>
References: <cover.1759843268.git.paul.chaignon@gmail.com>
 <302cd8554710d04986925df1737c787c09b5ff65.1759843268.git.paul.chaignon@gmail.com>
 <62e288f3-9917-4218-84f7-01e2eb27130c@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62e288f3-9917-4218-84f7-01e2eb27130c@linux.dev>

On Tue, Oct 07, 2025 at 11:01:32AM -0700, Martin KaFai Lau wrote:
> On 10/7/25 6:38 AM, Paul Chaignon wrote:
> > +#define access_test_non_linear(name, type, desc, retval, linear_sz, off)			\
> > +	SEC(type)										\
> > +	__description("direct packet access: " #name " (non-linear, " type ", " desc ")")	\
> > +	__success __retval(retval)								\
> > +	__linear_size(linear_sz)								\
> > +	__naked void access_non_linear_##name(void)						\
> > +	{											\
> > +		asm volatile ("									\
> > +		r2 = *(u32*)(r1 + %[skb_data]);							\
> > +		r3 = *(u32*)(r1 + %[skb_data_end]);						\
> > +		r0 = r2;									\
> > +		r0 += %[offset];								\
> > +		if r0 > r3 goto l0_%=;								\
> > +		r0 = *(u8*)(r0 - 1);								\
> > +		r0 = 0;										\
> > +		exit;										\
> > +	l0_%=:	r0 = 1;										\
> > +		exit;										\
> > +	"	:										\
> > +		: __imm_const(skb_data, offsetof(struct __sk_buff, data)),			\
> > +		  __imm_const(skb_data_end, offsetof(struct __sk_buff, data_end)),		\
> > +		  __imm_const(offset, off)							\
> > +		: __clobber_all);								\
> > +	}
> > +
> > +access_test_non_linear(test31, "tc", "too short eth", 1, ETH_HLEN, 22);
> > +access_test_non_linear(test32, "tc", "too short 1", 1, 1, 22);
> > +access_test_non_linear(test33, "tc", "long enough", 0, 22, 22);
> > +access_test_non_linear(test34, "cgroup_skb/ingress", "too short eth", 1, ETH_HLEN, 8);
> > +access_test_non_linear(test35, "cgroup_skb/ingress", "too short 1", 1, 1, 8);
> > +access_test_non_linear(test36, "cgroup_skb/ingress", "long enough", 0, 22, 8);
> > +
> > +SEC("tc")
> > +__description("direct packet access: test36 (non-linear, linearized)")
> > +__success __retval(0)
> > +__linear_size(ETH_HLEN)
> > +__naked void access_non_linear_linearized(void)
> > +{
> > +	asm volatile ("									\
> > +	r6 = r1;									\
> > +	r2 = 22;									\
> > +	call %[bpf_skb_pull_data];							\
> > +	r2 = *(u32*)(r6 + %[skb_data]);							\
> > +	r3 = *(u32*)(r6 + %[skb_data_end]);						\
> > +	r0 = r2;									\
> > +	r0 += 22;									\
> > +	if r0 > r3 goto l0_%=;								\
> > +	r0 = *(u8*)(r0 - 1);								\
> > +	exit;										\
> > +l0_%=:	r0 = 1;										\
> > +	exit;										\
> > +"	:
> > +	: __imm(bpf_skb_pull_data),
> > +	  __imm_const(skb_data, offsetof(struct __sk_buff, data)),
> > +	  __imm_const(skb_data_end, offsetof(struct __sk_buff, data_end))
> > +	: __clobber_all);
> > +}
> 
> Does it have to be in asm?

Probably not, but it's easier to write that way. With the added
cgroup_skb test cases, the verifier checks that return codes are either
0 or 1. So we can't do 'return *(ptr - 1);' to force the compiler to
keep the memory access and we'd have to find some other trick.

It's also consistent with the rest of those ctx access tests. It allows
us to see exactly what is verified and the diff between the cases with
and without bpf_skb_pull_data().


