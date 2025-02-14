Return-Path: <bpf+bounces-51571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7F9A3623F
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 16:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FEEF1893EFB
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 15:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03882676D6;
	Fri, 14 Feb 2025 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuAeFtD8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AFD267393;
	Fri, 14 Feb 2025 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548112; cv=none; b=Zvo5N8JB0oOzbFbMHJwQDxmrXCZZg20v3fbL26DyCMNwmp4DPzg5Oqb4NZi10bQQ3MuOOxp6PL999T2O6TfDmqsFnB/NezrKIytLR+ARcmDQCqhP/8YseN5XNpk0R3DhV5QIZQTvhSF7NLmJZEH64qtL6aLol63rUgbPEP48Ui8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548112; c=relaxed/simple;
	bh=NWNoZZi08mhdF9BunBnXIPuneqG6DB+F+MIutfniibM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnRW8Q/BWhXOTBydi954vBtVGtpUyBJWfpqPCEoF7MziKS3pBasOGETNMUuiI6wTLDUAiuHIit7fDduV/3+cSsI8WnldQfj50D7tVCg6wnQCxS6kHHrfoN97UxUeQbe4qzvuUnhfK4SDG0KcN7QmOU/83i65AO4mJQDlz70LReY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuAeFtD8; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so3312989a91.2;
        Fri, 14 Feb 2025 07:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739548110; x=1740152910; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MbGFgqbvLOcHBUcvGiNbipFzBfVJ8JzFQ+BI//Xf0wk=;
        b=HuAeFtD8/f6arQjh69d/W0pNQcRq4HdBJRaYLG8Uk/vkOre7XDzEcvqp3XM++82uwV
         +rGqixpEzXC7KQ14o07Xm8z23jU4PJwuqAhl/C0Kje8Xiu2CSVWWwdsAGS04XVHsq1a2
         0AHm2egOasNIDEAXviWNCjX2IBwA8svNe7L57AwIxhCqKz+0D9zogIZR9OBljw5rSVy7
         s/d+vxu6KZEfsmQG41kk4X57LJvOP/VydsBTLODW5N+AHxxG1UHzdIVZt7Dqyb29AeQN
         brG0BuNwdFSGjOtVcFpLvxMCSUzjVHotcXJO1DOgbrHQPNFZhqSr3OiiJqr1Xpf9d6Qc
         9MUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739548110; x=1740152910;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbGFgqbvLOcHBUcvGiNbipFzBfVJ8JzFQ+BI//Xf0wk=;
        b=H43jm8uBZGjSYfxVP7ATZWmHYo1LnSlCpEoJvAD13bpBdSEsZWFRR62zEf7qt4HThD
         x6ANkpIRKpycjiIrB/yYDAQIpVLiYHJ488PAC5wIBt8hrMmZw8n4/iT2t13Up5KkWXi+
         QKf41DjVhS+UGdQ7ZbIt8EeyY1Quy6C8/KCM4WiajLK0TTnEZAGbz/f79qAsm7Hjt5P1
         8NxtS/L/nDJneIdBOqdq5lhYePr8Q3WJVNLDYv3N0FmfRAeiA+0JYV75WqXCgd0b0+Cl
         YHBm+XHKvv2b5QIefPuxISKl8DazxNtIOpHfEemlnNOa4MjBnfGubXi1OpxbmtxNUYbI
         pc5g==
X-Forwarded-Encrypted: i=1; AJvYcCV46DoZ6wC88kajWtevQpxaczpZz4nEANaM4JS4UbbqUETxvR+dFplnFlO7+lk5hlzcf8M=@vger.kernel.org, AJvYcCVsiOGDyiUfh16kHp6YX5PuXy4th65gm1p31UHNbjbuT9w1cz7vAl7xKzc4cLQGb/ge7LZFm+lH@vger.kernel.org
X-Gm-Message-State: AOJu0Yydff0dEeCbMoBIcD1thj/BveZWzpSefir8Ak5bgA72lbALqlYz
	S7CNvJ6mlyU71lxOYz6mxbzKY10y31ujVCUHWsiI+PqeGwS3iw4=
X-Gm-Gg: ASbGnctKaZ7Al2R500qn6E+eoTk1uuYlhSDUYHQlytV76t0fCZhybQcN8QpsfS/GIa/
	EGJCFgpK30RfsOQ9ta4W9vNar9BBWgqCbv9GJKT43kEFn2arw1yd8U8A7dKI+HQ/P0fhx2Lnh95
	BQo1cQ+sKyr9tgvmUGd0FVRo2mI4Z2SAOyovIsYpzTSPbLo7qyLvI6lDBXJ/D2jLW8RWqAkf6oy
	u42ip9BnUtiUzmVgwmHlMge1qQMn8gXAPJKHxDIg3C37/QMviypZivmbwfKtYL0U0VZpFFeCk/x
	Uc5K1AxkxB4hzw4=
X-Google-Smtp-Source: AGHT+IGr3jeYjtV1QfC2fLCr4Z116zpQgygzABuzKbAsMndYuRzkjZP2i1qrMeITatTPv6gA8Uw0bA==
X-Received: by 2002:a17:90b:50d0:b0:2ee:ed1c:e451 with SMTP id 98e67ed59e1d1-2fc0e4b91ffmr12358658a91.15.1739548109891;
        Fri, 14 Feb 2025 07:48:29 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fbf98f4ff1sm5376779a91.27.2025.02.14.07.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:48:29 -0800 (PST)
Date: Fri, 14 Feb 2025 07:48:28 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org,
	ncardwell@google.com, kuniyu@amazon.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] bpf: add TCP_BPF_RTO_MAX for bpf_setsockopt
Message-ID: <Z69lzNYwBb-5CPvX@mini-arch>
References: <20250213004355.38918-1-kerneljasonxing@gmail.com>
 <20250213004355.38918-3-kerneljasonxing@gmail.com>
 <Z66DL7uda3fwNQfH@mini-arch>
 <CAL+tcoATv6HX5G6wOrquGyyj8C7bFgRZNnWBwnPTKD1gb4ZD=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoATv6HX5G6wOrquGyyj8C7bFgRZNnWBwnPTKD1gb4ZD=g@mail.gmail.com>

On 02/14, Jason Xing wrote:
> On Fri, Feb 14, 2025 at 7:41 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 02/13, Jason Xing wrote:
> > > Support bpf_setsockopt() to set the maximum value of RTO for
> > > BPF program.
> > >
> > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > ---
> > >  Documentation/networking/ip-sysctl.rst | 3 ++-
> > >  include/uapi/linux/bpf.h               | 2 ++
> > >  net/core/filter.c                      | 6 ++++++
> > >  tools/include/uapi/linux/bpf.h         | 2 ++
> > >  4 files changed, 12 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> > > index 054561f8dcae..78eb0959438a 100644
> > > --- a/Documentation/networking/ip-sysctl.rst
> > > +++ b/Documentation/networking/ip-sysctl.rst
> > > @@ -1241,7 +1241,8 @@ tcp_rto_min_us - INTEGER
> > >
> > >  tcp_rto_max_ms - INTEGER
> > >       Maximal TCP retransmission timeout (in ms).
> > > -     Note that TCP_RTO_MAX_MS socket option has higher precedence.
> > > +     Note that TCP_BPF_RTO_MAX and TCP_RTO_MAX_MS socket option have the
> > > +     higher precedence for configuring this setting.
> >
> > The cover letter needs more explanation about the motivation. And
> > the precedence as well.
> 
> I am targeting the net-next tree because of recent changes[1] made by
> Eric. It probably hasn't merged into the bpf-next tree.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=ae9b3c0e79bc
> 
> >
> > WRT precedence, can you install setsockopt cgroup program and filter out
> > calls to TCP_RTO_MAX_MS?
> 
> Yesterday, as suggested by Kuniyuki, I decided to re-use the same
> logic of TCP_RTO_MAX_MS for bpf_setsockopt():
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2ec162dd83c4..ffec7b4357f9 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5382,6 +5382,7 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
>         case TCP_USER_TIMEOUT:
>         case TCP_NOTSENT_LOWAT:
>         case TCP_SAVE_SYN:
> +       case TCP_RTO_MAX_MS:
>                 if (*optlen != sizeof(int))
>                         return -EINVAL;
>                 break;
> 
> Are you referring to using the previous way (by introducing a new flag
> for BPF) because we need to know the explicit precedence between
> setsockopt() and bpf_setsockopt() or other reasons? If so, I think
> there are more places than setsockopt() to modify.
> 
> And, sorry that I don't follow what you meant by saying "install
> setsockopt cgroup program" here. Please provide more hints.

Ah, sorry, I misread it as bpf options taking precedence over tcp ones;
ignore the suggestion about setsockopt cgroup prog.

And yes, reusing the logic of TCP_RTO_MAX_MS looks better!

