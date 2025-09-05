Return-Path: <bpf+bounces-67597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2824AB46231
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 20:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 437AD7B1454
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 18:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD80E239085;
	Fri,  5 Sep 2025 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c9ZmsXD5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E282133E7
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 18:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757096610; cv=none; b=Jx3Q88+v75P1c+O3nCBKjAdepO0eOflxAAGiBXUXQeayMzqd7qIk3JVLi28p87n/OCGMfRpJF7Yd5Yeq27FdAExlfNIJRjf9a/PvfohvR4UBxZ4PYsDcmte/ZK0lhFkFJUWS7FcZ3FVTOcV7h2vbv2x01yJ1xKxXdrMnEZFIjL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757096610; c=relaxed/simple;
	bh=f9+zISEGqjgWmvuzjuNbH5wW8MYkeOXK8Iz3N3p0WOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRhOXfbbb4QmqP7fuVgPVXTtphK/ETrPCP5fe2tOJCHvbsDJkwdbvmd1olfi5c6noOI+T3n7gnMtmwX91g9mxvvDhFuMSCb8ep5W1JbDZgz/GiyAEQ+KRZJJZ+OIiZPP6I6GfmPvYprATMfrKJXpIAT2TrmCWt/11ktIwjXoAzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c9ZmsXD5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24cf5bcfb60so19755ad.0
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 11:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757096608; x=1757701408; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rgWOc0h7T/LwTAxHfFQtzP5pqZV8FThPEz2kt4MSq5E=;
        b=c9ZmsXD5jczetvj8SvIo8j59PY5OHQ1OlRTkRhXOJ+w8YduZJxha8hP3+wTBrW9jCr
         ycv8kKIZQK/oEa2AUkwNNIyqMs6IiVUgSRVSagt4m2nEcHBcLcgK9biK3wNcUOd/3CnK
         raW7i/Io0LopzVYzbPWgE9DtOqrrwHaOwU/RC8TihF6LwqfWLJzQDZHqhTjbe3mQrZo9
         F8x03iWFOGFBTRWydN6pHHisli00F7qVsI81e0h3U6PdkGJvbxNFYzRsuivzDJrx+nDs
         HvpDqXGKBz0dtCoDJB3ZiZwS0JtojWkHkLYBsW+8O3xUhcy9ASJlY1OaY3Zur1sF7GAD
         /guA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757096608; x=1757701408;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rgWOc0h7T/LwTAxHfFQtzP5pqZV8FThPEz2kt4MSq5E=;
        b=ZvqhUBHxxyj11okxMh5+271IUNjXpa8RUYWy8jT7Pn5lLtPSB/Es2nZ8JSGG/L1cLm
         RtqvpxnZH5b2kiHLeUv+nvbxBMAc5mb977BFOKXD1Iot3oHouU9/IMp+e1ISfmcMacxb
         VmjuqLpH01y+3dtq+BHYojcUGUqw7EIxORwJQhm7pBmBNK7VfstgiN1g47jndLqogYy7
         ba9OjPL1912fNTzHaFURTDuwbOX9AlhI+78Lk6vAGD6Y4iVnj1Eqeu177j1rVXVdjrxF
         vfZHCd1xUDY1fAgnIiqxHrbHrYEJo++QceJyGPaeKayahPlksPs/QVoBaE/LMtvlyTBl
         4ZtA==
X-Forwarded-Encrypted: i=1; AJvYcCXHQCGEz6eEL8m+O8aDUjFgpzjjJR6dbHVt7cicFJg6QJuD9FikRbMkt8JaDAYlBDRmSoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2P0bWStZSjZ7HW0EYoJNliIJbHxCnbXUZW0awjseuPnioaOLN
	zks1PJ99zFGW2TFoBslrbGeK/lsFmiFMHgARtFuHxE4dRr3w2R4pihgPCVrgofKSVA==
X-Gm-Gg: ASbGncuL5J9UPqIBtGa4vPpApV6Js7rF1bPrlI3xtoPV0vBac1U4GPMk21aCL4kKGB/
	HDTmGvpCA22aDT/iHJ8LZATpUCqGWU4PVtrIfvBN2pO3S9HhdhNIOirD3bihDcjr5iyjwZ2omau
	L4n/U3N3/U0sTVqNP4426HOhpXSzYDU+c4mADke+6p+Q3enZYYK/+eH4oK0q4H2DsXzfmqdkr52
	jVN5qW0w7xKmxsRnKJ2KgB4g+ZFgeGAdDkUSNvmx1KFY9O0AIth/rW06cvtJzyGgaJm4t+lQjIc
	Dh2idoZAZmD64Q4l0RJ9atTnrSLwhZ2qKa+rq5XK1lMMVBgi4POMw18BU0r8xWPE8j5zviWRQnk
	FcbxE/yATAMp8czwj9xhgAMoAhiRqNVTxuZHVDyZhIroIppJNzdnxzAD9snC1a1o9DFY=
X-Google-Smtp-Source: AGHT+IHIHCT/LHWg3smHhUZvr7cjK1B8dD2CGV1dFWXEglBs03iMs0n2W9jj0hS//Dye90GLARpV1A==
X-Received: by 2002:a17:902:f550:b0:249:2caa:d5c9 with SMTP id d9443c01a7336-25123db6d69mr166865ad.17.1757096607758;
        Fri, 05 Sep 2025 11:23:27 -0700 (PDT)
Received: from google.com (132.192.16.34.bc.googleusercontent.com. [34.16.192.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c7d2dcd2csm87587595ad.145.2025.09.05.11.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 11:23:27 -0700 (PDT)
Date: Fri, 5 Sep 2025 18:23:22 +0000
From: Peilin Ye <yepeilin@google.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	linux-mm@kvack.org
Subject: Re: [PATCH bpf] bpf/helpers: Skip memcg accounting in
 __bpf_async_init()
Message-ID: <aLsqmno0KJqrXFot@google.com>
References: <20250905061919.439648-1-yepeilin@google.com>
 <CAADnVQKAd-jubdQ9ja=xhTqahs+2bk2a+8VUTj1bnLpueow0Lg@mail.gmail.com>
 <qwrl5ivlaou2qqbrj4wh2vi4uqmeny2zyfidkjizkyyzta3uo3@z6bjemb7om6y>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qwrl5ivlaou2qqbrj4wh2vi4uqmeny2zyfidkjizkyyzta3uo3@z6bjemb7om6y>

On Fri, Sep 05, 2025 at 10:31:07AM -0700, Shakeel Butt wrote:
> On Fri, Sep 05, 2025 at 08:18:25AM -0700, Alexei Starovoitov wrote:
> > On Thu, Sep 4, 2025 at 11:20 PM Peilin Ye <yepeilin@google.com> wrote:
> > > As pointed out by Kumar, we can use bpf_mem_alloc() and friends for
> > > bpf_hrtimer and bpf_work, to skip memcg accounting.
> > 
> > This is a short term workaround that we shouldn't take.
> > Long term bpf_mem_alloc() will use kmalloc_nolock() and
> > memcg accounting that was already made to work from any context
> > except that the path of memcg_memory_event() wasn't converted.
> > 
> > Shakeel,
> > 
> > Any suggestions how memcg_memory_event()->cgroup_file_notify()
> > can be fixed?
> > Can we just trylock and skip the event?
> 
> Will !gfpflags_allow_spinning(gfp_mask) be able to detect such call
> chains? If yes, then we can change memcg_memory_event() to skip calls to
> cgroup_file_notify() if spinning is not allowed.

Thanks!  I'll try this.

Peilin Ye


