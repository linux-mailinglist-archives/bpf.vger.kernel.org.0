Return-Path: <bpf+bounces-70785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBDFBCFA65
	for <lists+bpf@lfdr.de>; Sat, 11 Oct 2025 20:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A59405A11
	for <lists+bpf@lfdr.de>; Sat, 11 Oct 2025 18:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7162B27A906;
	Sat, 11 Oct 2025 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="Np5cD2bh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466162BAF9
	for <bpf@vger.kernel.org>; Sat, 11 Oct 2025 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760205851; cv=none; b=HIQ6q1OcolJ0lq54qbP2xDJxRanruVP1ighr6vXBEzAKR9r2dgwzQWKhWGS2ocuPpVWR/m1hfZedY1zvQIFHSZbyfbPgMqlZv6SwZBi8/Mb25ob6qpLhO0CatjXj8XXUrYrLZ/Gr3XIGjmCsQI7a44HyhDoFhp3qD1mAXEboToI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760205851; c=relaxed/simple;
	bh=CfZ6Ogw1SDTfiNV1N44wJLznxd/1DH2Jp1q8mPQdEkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaV3dUnbJDDtexRmqabR58DCRqnGe9MTDQq6Y9TyyKtE6993sdSiiZ0L6O45LWI0V6uOWi02NHhR6PZDAi/4CH9pPD0uAKI2dIU2e++//khgNjIpbJGKBu72cJtaVKDHGxdka1lGsElR5clXYovuLLmz7haqb/YcOa410Z29Pi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=Np5cD2bh; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-783ad9c784cso193163b3a.0
        for <bpf@vger.kernel.org>; Sat, 11 Oct 2025 11:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1760205848; x=1760810648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M0IvAdUYDvrJ8BmCFPvW2btvMiVtD9TKPbA5D4CG4UY=;
        b=Np5cD2bhZibq71uqUZC+DsNAqdYDBMEygl2MTKzZ3z+hKgmM24foEHfBDDPDZEd26p
         WfTvu3dghN7Cu58BiVW0aDf1K4QJ8ax5hmWmdIEK/hxro4l3y6Ubin18uKOrrbCwQjWW
         oSXEu3XTLOh9Ju4gtyuVkiwi6P5tJJKIikGdFXWf/h5ZJnTqzkE78kXuB9mRbWrRsOzg
         A0ZeMPsFlMOfdDWniF09ywCD9BmiUJ0Cmjn7Lzo1Xj5exvzIUes9QUtoUizFaVzB9VrH
         rk5fBOhIRRJWZlNoBh6YEgwdV/+Y5dosuC+MOeyfEZszSMrE0X4FVqtqP19guu6XR75O
         FIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760205848; x=1760810648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0IvAdUYDvrJ8BmCFPvW2btvMiVtD9TKPbA5D4CG4UY=;
        b=kkon9RrgdqKMZjtd6zmfsqVOf5hG0iVCw5OJt8s6RPXogjNA0DEsNz+Kob7cm1xzHW
         ueKTqQtr/rbDSJeyiHDQV/6JW53A4hrvC91IJgiv1iak3IpgNS+JpG5pxgN4mV4Hkdkh
         8S3NEGWjC+aHuRs7Q7cOq/rlEnuIiBW41A3wfmL22RF9p6dKk9ZYn+DGbTtszGp55aZj
         fssRq9raLS3LjXMD0+0iOp1oQ1tAhXW/DAUwHVqJ7aIm9JaHGiT950IKHmpGaq018U9O
         gUF2+N1OtbujtGaqPr0vzPRp4Puvb4w6FsOTFAwputAWrhq+unsNdE5kneFieockN/6J
         uzSw==
X-Forwarded-Encrypted: i=1; AJvYcCWv2B6nXGi992eV8knhXjd/TirZmhwEFmxYnYJ69njvTLPqz4ZMWxSTEVqC6rzn3Z/Czl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqkatX2ZPCH+cyJJNUNbDAvOpyobzLtQbc9DwLuRsujwFs07y4
	cXkCRioDZql4XA/2p/9mX3SWLQvOrlIk6Vs7b6KQGNAbGXKtcwcZrbuwcHDDpBEgcpM=
X-Gm-Gg: ASbGncu2NHH3jHOyLHA6vCFnf45klnpIMGZKMrdk2v8+kzNRcFVeJeFakpUUKGHkXbw
	dcjdVvkPvXISxlMG9o4I+hP64Q0gDrrBT7lmxXGkjAaqHuNuQnt9CA33SYbQnoty7tf6hRdSBfj
	NOhWqZKSsw43Zv0i8nhZGFFcOKI1IN9fEbfdU3fCxDhOPY6orvQYJCAliVg2gMg2pWgeksBSH8z
	nF59GacxCU8F8i68PNVd8j5YlfK7VnAxKebxhOxDL29pSLLLHPgl0uFejEsvV1/QDb+Orf3/m9I
	owXGT5C7d8NVXtEbiULS/tvR0hmVMVnLdzluTyHq6MoZec0rT64nnqfKPQeRb9YloquoWTTLO9/
	nKE0Kzfhic1jDxC6PjECRzbpeFA==
X-Google-Smtp-Source: AGHT+IGOlsBu1O2Gi4g9BUBt3jLFQRK0wdTmxw6mBxyRBp/kPtQGAmRnuCiV8kfni5DTP5UEoGTWAA==
X-Received: by 2002:a05:6a00:3d52:b0:77f:482f:4693 with SMTP id d2e1a72fcca58-793855136ecmr9427486b3a.1.1760205848369;
        Sat, 11 Oct 2025 11:04:08 -0700 (PDT)
Received: from t14 ([2001:5a8:4519:2200:afac:e5a3:14c2:d53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b733355sm6507510b3a.26.2025.10.11.11.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 11:04:08 -0700 (PDT)
Date: Sat, 11 Oct 2025 11:04:05 -0700
From: Jordan Rife <jordan@jrife.io>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev <sdf@fomichev.me>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Aditi Ghag <aditi.ghag@isovalent.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kerneljasonxing@gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/14] bpf: Efficient socket destruction
Message-ID: <d2ncodvtjvi635zlg56yomqvjdkg3ilrpcgwhpoot362ayz3oe@ck37mtffvcep>
References: <20250909170011.239356-1-jordan@jrife.io>
 <80b309fe-6ba0-4ca5-a0b7-b04485964f5d@linux.dev>
 <ilrnfpmoawkbsz2qnyne7haznfjxek4oqeyl7x5cmtds5sdvxe@dy6fs3ej4rbr>
 <df4c8852-f6d1-4278-84d8-441aad1f9994@linux.dev>
 <CABi4-ogK1zaupzpRppGEdM0v+4BSJHbrC4Fg=j1zBSGLbkx1rQ@mail.gmail.com>
 <854e2fce-9d34-4472-b7b8-f66248f3ff01@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <854e2fce-9d34-4472-b7b8-f66248f3ff01@linux.dev>

On Tue, Oct 07, 2025 at 01:32:30PM -0700, Martin KaFai Lau wrote:
> On 10/6/25 1:19 PM, Jordan Rife wrote:
> 
> > Yeah, this is a bit tricky. I'll have to think a bit more about how
> > this would work. The ETIMEOUT thing would work for TCP, but if I'm
> > trying to extend this to UDP sockets I think you may need an explicit
> > bpf_sock_destroy() call anyway? And if you're making
> > bpf_sock_destroy() work in that context then maybe supporting ETIMEOUT
> > is redundant?
> > 
> > > [ Unrelated, but in case it needs a new BPF_SOCK_OPS_*_CB enum. I would mostly
> > > freeze any new BPF_SOCK_OPS_*_CB addition and requiring to move the bpf_sock_ops
> > > to the struct_ops infrastructure first before adding new ops. ]
> > 
> > Thanks, I'll look into this. One aspect I'm uncertain about is
> > applying this kind of approach to UDP sockets. The BPF_SOCK_OPS_RTO_CB
> > callback provides a convenient place to handle this for TCP, but UDP
> > doesn't exactly have any timeouts where a similar callback makes
> > sense. Instead, you'd need to have something like a callback for UDP
> > that executes on every sendmsg call where you run some logic similar
> > to the code above. This is less ideal, since you need to do extra work
> > on every sendmsg call instead of just when a timeout occurs as with
> 
> Yeah, regardless of ETIMEOUT or bpf_sock_destroy(), I think the
> BPF_SOCK_OPS_RTO_CB is better for TCP because of no overhead on the fastpath
> msg.
> 
> > BPF_SOCK_OPS_RTO_CB, but maybe the extra cost here would be
> > negligible. Combined, I imagine something like this:
> > 
> > switch (op) {
> > case BPF_SOCK_OPS_RTO_CB:
> > case BPF_SOCK_OPS_UDP_SENDMSG_CB:
> Beside the fastpath msg overhead, I hate to say this, no new CB enum can be
> added. I was hoping the only exception is the pending udp timestamping work
> but it has been pending for too long, so we have to move on.

Ah yeah, understood. I was a bit unclear in my last email. I get that
sockops is closed to extension until migration to struct_ops. I guess my
question was would it be worth trying to move bpf_sock_ops to struct_ops
at this stage, but this seems like a heavy lift so is probably best left
for later.

> The bpf_sock_ops needs to move to struct_ops first. I suspect some of the
> bpf_sock_destroy() hiccup being faced here is that the running context is
> only known at runtime as an enum instead of something static that the
> verifier can help to check the right kfunc to use. Once struct_ops is ready,
> adding a sendmsg ops will be in general useful.
> 
> If TCP is solved with the existing BPF_SOCK_OPS_RTO_CB+ETIMEOUT, the
> remaining is UDP and it seems you are interested in connected (iirc?) UDP
> only. It is why I asked how many UDP sockets you may have in production.
> > I think using socket callbacks like BPF_SOCK_OPS_RTO_CB would make for
> > a more elegant solution and wouldn't require as much bookkeeping,
> yeah, if it needs to iterate less, it has to do its own bookkeeping. This
> patch uses the sock_hash but it can also be done in the bpf list/rb/arena
> also. The bpf_sock_destroy_might_sleep() should be strict forward. The
> SEC("syscall")+bpf_sock_destroy_might_sleep could be useful for other use
> cases also.

For now, I'll look into the BPF_SOCK_OPS_RTO_CB+ETIMEOUT mechanism for
the TCP case and bpf_sock_destroy_might_sleep() for the connected UDP
case if that sounds good to you. Even if the UDP case could be handled
in a simpler way eventually with struct_ops (e.g. a sendmsg callback),
bpf_sock_destroy_might_sleep() would be useful to have around as you
say.

I'm curious if the migration to struct_ops is already underway. If not,
I'd be interested in exploring this more later on.

Thanks!

Jordan


