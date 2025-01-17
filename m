Return-Path: <bpf+bounces-49208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AECA15489
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 17:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CB6168FFF
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 16:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253BD19EEBD;
	Fri, 17 Jan 2025 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahlN8Ru4"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F37153598
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737132182; cv=none; b=cg5Z7t81r7qvhAt5jNS46iGtGXvypf4ey7SqBUAB7ikej6FcvSYO6YVe0gU/SjXtrk2gmj2Sa5s1smlXb1295PuMfnaA1QRu968ko83hZ4fd7xTe/p9dYuywF74wDaBglAY6bNT21Xh+DgOBpxNkEHYdwyQ+1A8+uw8H2lCup1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737132182; c=relaxed/simple;
	bh=FSnHYvk6TCcGSJ2aFbSgdEI20yieZkmQp81bQFGkVoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XB+l/xP0Tq9gc89K96L99Na+W+adsjT/z4mCQFdPs7GhVhmEz/GRm/XSjF+t6y/S+kjDlgUysHi5kTrHWWm6e8yD28YEKUd69Cm+4oJVmgzAhNVl0lLuUNtypo71FaKrcUgpS7EmhzafbJ3RbRSM2hNmdqHyEHaAk3hsPcp7hn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ahlN8Ru4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737132179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AzH0N3Q+fMi/HkvVqAXL9WI8l6XfmBkxagfYRz+FbjQ=;
	b=ahlN8Ru4mF/rmWbSmwFRpv929MDVucMdA71fud0mOG7IC57kmlifyrCSnJuCevT1j3D8q+
	wdLkPvEJtGjYRpqK6wHFKmc3qXIZ7Iwhokl5riMEhyB59KnOl0zdq2kIeYXkkGsLT1Y70p
	p5xrDBycPxTcHu3hq5/HT6ZvaxfSG0Y=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-M_4wzuRvOxCKIN2C4f3ahw-1; Fri, 17 Jan 2025 11:42:58 -0500
X-MC-Unique: M_4wzuRvOxCKIN2C4f3ahw-1
X-Mimecast-MFC-AGG-ID: M_4wzuRvOxCKIN2C4f3ahw
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef91d5c863so4620682a91.2
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 08:42:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737132177; x=1737736977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzH0N3Q+fMi/HkvVqAXL9WI8l6XfmBkxagfYRz+FbjQ=;
        b=cDAQ+3zYWz4DO6CXUoNmOWWuD/9bgtxR6fC0HBSZMlm/uNEq+8DEdEUZBdApaKubSX
         kCQdvIWIIbycQC7MmFarCqSRbV3H3tU4LolfYkB/6rWBtLeIlbaYvoTMOtDzYucg47tT
         7xv6dlWJCV65xWCceCsi+uc3V8w7/QZnA0TB0Uh/l2U89ZiVb871Sd9HEddmrLuepwsW
         O7t/SdW2vqZ1xP9Y7FD7V3WG2juoCGm8whwJK0iVcVnhYuTWpBaawkMfvHq/r/5Ek87h
         dhJ0BjVT7F72amzC/w0RTh+JyPqLJtvyA4sTq1GO306VpIw7OvUi3Z3yhhP4OacCgp9C
         CxIQ==
X-Gm-Message-State: AOJu0YxjFAumVkEVz8HMPHZgIap32MFEtKqQqe5Nhcj7Df21Ed/w29E8
	bY9vY3H4BX18rsINrNuOQsVUnAYyaF6rj+6kOg6NUC5RldbZcEoCSNvXoIOBtsQ1aR54seruiIr
	XSGDI/y0a3VsiPwKB7VK7pTRNQzny+W21UnBUiJ0gSdG6zUv7niBDghoQk+Fp
X-Gm-Gg: ASbGncvAoR/7lxiNCLbFKH16MVcf/MdWo9zN7mMQLeWhYbZOkqs/uZdBSLRcyKNJmzu
	EfK79YvpYbhXpg0p7fxSxUKxYZXzM01H+Vw2lEWaVEGRSdCdlpdgt5/kDu6+I9zgixeUB7woFEw
	7VPlO6SlQTLqOaFeyd3mGc8cadIYUg0MZWzYTQVUsjo1/sMgUSBNyslVdKR7Y6QJeX0BT9alKqg
	Nwi0measb+/WcVNi4bdzW+jiBRWf2n7pE0O8pi1IvxGPDYGCdOTpwqbPOQBMQi1o+ws7VNoL+3j
	dnnShd5Iixzh
X-Received: by 2002:a17:90b:534b:b0:2f6:f107:fae6 with SMTP id 98e67ed59e1d1-2f782d32397mr3983860a91.23.1737132177146;
        Fri, 17 Jan 2025 08:42:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUypNKVESCSeTPoEHheWM7U+PR1FuGloZujdrA5sBPWkQUoZirvOax+nHkVQHE1STgQctdxA==
X-Received: by 2002:a17:90b:534b:b0:2f6:f107:fae6 with SMTP id 98e67ed59e1d1-2f782d32397mr3983838a91.23.1737132176853;
        Fri, 17 Jan 2025 08:42:56 -0800 (PST)
Received: from jkangas-thinkpadp1gen3.rmtuswa.csb ([2601:1c2:4301:5e20:98fe:4ecb:4f14:576b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77619ed33sm2280866a91.23.2025.01.17.08.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 08:42:56 -0800 (PST)
Date: Fri, 17 Jan 2025 08:42:53 -0800
From: Jared Kangas <jkangas@redhat.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	martin.lau@kernel.org, ast@kernel.org, johannes.berg@intel.com,
	kafai@fb.com, songliubraving@fb.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: use attach_btf instead of vmlinux in
 bpf_sk_storage_tracing_allowed
Message-ID: <Z4qIjSMgIOqbHoef@jkangas-thinkpadp1gen3.rmtuswa.csb>
References: <20250116162356.1054047-1-jkangas@redhat.com>
 <9e5b183e-5dd5-4d3d-b3e6-09ad5e7262dc@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e5b183e-5dd5-4d3d-b3e6-09ad5e7262dc@linux.dev>

On Thu, Jan 16, 2025 at 12:03:53PM -0800, Martin KaFai Lau wrote:
> On 1/16/25 8:23 AM, Jared Kangas wrote:
> > diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> > index 2f4ed83a75ae..74584dd12550 100644
> > --- a/net/core/bpf_sk_storage.c
> > +++ b/net/core/bpf_sk_storage.c
> > @@ -352,8 +352,8 @@ const struct bpf_func_proto bpf_sk_storage_delete_proto = {
> >   static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
> >   {
> > -	const struct btf *btf_vmlinux;
> >   	const struct btf_type *t;
> > +	const struct btf *btf;
> >   	const char *tname;
> >   	u32 btf_id;
> > @@ -371,12 +371,12 @@ static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
> >   		return true;
> >   	case BPF_TRACE_FENTRY:
> >   	case BPF_TRACE_FEXIT:
> > -		btf_vmlinux = bpf_get_btf_vmlinux();
> > -		if (IS_ERR_OR_NULL(btf_vmlinux))
> > +		btf = prog->aux->attach_btf;
> > +		if (!btf)
> >   			return false;
> >   		btf_id = prog->aux->attach_btf_id;
> > -		t = btf_type_by_id(btf_vmlinux, btf_id);
> > -		tname = btf_name_by_offset(btf_vmlinux, t->name_off);
> > +		t = btf_type_by_id(btf, btf_id);
> > +		tname = btf_name_by_offset(btf, t->name_off);
> >   		return !!strncmp(tname, "bpf_sk_storage",
> >   				 strlen("bpf_sk_storage"));
> 
> Thanks for the report.
> 
> There is a prog->aux->attach_func_name, so it can be directly used, like:
> 
> 	case BPF_TRACE_FENTRY:
> 	case BPF_TRACE_FEXIT:
> 		return !!strncmp(prog->aux->attach_func_name, "bpf_sk_storage",
> 				 strlen("bpf_sk_storage"));
> 
> The above should do for the fix.
> 
> No need to check for null on attach_func_name. It should have been checked
> earlier in bpf_check_attach_target (the "tname" variable).

Good to know, that simplifies the patch quite a bit. Should I add a
Suggested-by when resubmitting?

> 
> pw-bot: cr
> 


