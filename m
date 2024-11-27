Return-Path: <bpf+bounces-45691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BECD99DA281
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 07:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8E6162368
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 06:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B9B148304;
	Wed, 27 Nov 2024 06:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="RxBSMrMQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580AA13BAE4
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 06:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732690306; cv=none; b=kI9VRrixiENAnAEsDWQdMO3n4IysQ7pwovUh4a8hklDZ1go7kxkf2SsyATzTWnhXn6Oanx2U+8z20m/PTi6/lPk05W0TfeikzOvvH9e9Opd7Ho6dGv0PutzfQFi56ddBclDdItB3hvD6vlUF5AXZ/ksuxwRKyc+i6np6RkWEJs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732690306; c=relaxed/simple;
	bh=LeIclWM6iL8/Nl4ZOwePsTroGg0PcZEWMopvx1sLzV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YM6IlJ2QIRx6bkkdmkRRHPv324AKgO7PMOpzpYJtHoChIA9MZ/ZIkRXQakPW5gWNSo0xZ0HwDTI8Jds3TezLikliYmnFfVfGm1vvpKOha3hk+86IMwqevv/CKn01PqF6YcnRLSh+3e6PLL80mb5jYeQjnhrRGpc1L2QmeKrbRKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=RxBSMrMQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a1639637so21815235e9.1
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 22:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1732690302; x=1733295102; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GFFU+ytgRolEr2uohOHzMWsO8ep2js0Mk5iRvHzXZi8=;
        b=RxBSMrMQ00Pp4hIdtjt+E3bVLg9kWmA4KFhpC2ASW3gQpPqDoAT6ZoVwBbldEIaqat
         t0J4XpY54/gVPmhuwficQZK6Kv8N57HLuQESmCeTPTXBAXn9vFlwdVxSEXy1Jqnzxeyu
         gK5iaspJ7YaQHvnQ2jIDKM3fsmHyoV+HMRBn2arfX0w4G0dRwwxVBOQdbwRlP3y+Bl/n
         VSJI0vqM3S6dWcJ7YJByaS7K/q1plbldws/G6fO6JeqPiEi2IGgB4G4NRj+hPmq6gmzL
         pOB27b5NHnKYgalr/YFH8pZD1fPvj2NwryYc0sLxks1XVWDih52c++gfdu5EsL4/jYk7
         zWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732690302; x=1733295102;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFFU+ytgRolEr2uohOHzMWsO8ep2js0Mk5iRvHzXZi8=;
        b=DpjRZtwkj0mtB++LsvgJUMXa4BFRNNqdcJbjZV6XDe/tfywvG/pasDrHGkB6KcHjD3
         tJ1LGIT5N+eInWUovnAlgZdBdZ0/BbMywGceGrp6hcPTShFLvK/OnW8rGh+q4bUPSt4H
         FM5Kb9LO8g1Ajv5+nCCJbq2zJNF6QQ43ae6Nwff0o8op69LhnUik4Y5+52xODxKJBVoN
         DGSnF4GAdUNWzil1VWd//1ErbdV5Gwx8RRVpDgDBA5CDKNa38eu9dEPpVzGhAABHQFIf
         PLRM11j+bI0oONoBqP/3QyK1IGyL/X7b1Fi+SHZskVUoDwG9WNMVKeI17Yd44UbBB6bY
         7/og==
X-Forwarded-Encrypted: i=1; AJvYcCUbTRat+Hz+I3AoDu/DqFLX2F2CuIcirvlZ9OciLaho/MF3qUC4lETK23Tq7qDF6bV9RnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP0zG4tCm88TG57rE7V3m0o8c/V+n/T8sWELhz1QW5VOt48Kua
	2uqIL6qA6XfX+LCCdKDr3F8v/3qrNY184+/A1RhxbCHpFVpt0+3FsgCJ6pBOdXw=
X-Gm-Gg: ASbGncsUts/7eza2PNV8xPENgC0G62TwevzGTK7sWINEreo9OfDWWnL8fvdNPNJNa+e
	6u1dexTjw8gpmUzzLL34e6O3bU5Wl1I7TdupBIu+l356szehlGDyXFMHxxUje/e8HE3tOrKgkQ/
	5D4ObgzAZWvY2EYmhop/XZdmFGAJgIH2hRUtTPd8uuBfvhiKNcpZvGw4b2VfT5cLbqnFnWJ1qMo
	ayBqabGNFq6nJTyiS3I8L/fqvKAw9Cr75Ooenk=
X-Google-Smtp-Source: AGHT+IFqzgqZ4Vh4puQE+9jzz3m4vzZCHIUYI0c0HGKNQojCFpJY3C6SgZ6rSrEfEx0OTOMw/lvb7A==
X-Received: by 2002:a05:600c:4e8b:b0:42c:de34:34be with SMTP id 5b1f17b1804b1-434a9db8393mr17820795e9.3.1732690302618;
        Tue, 26 Nov 2024 22:51:42 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7b7917sm10779765e9.13.2024.11.26.22.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 22:51:42 -0800 (PST)
Date: Wed, 27 Nov 2024 06:54:15 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 3/6] bpf: add fd_array_cnt attribute for
 prog_load
Message-ID: <Z0bCF86eCTmBFu0m@eis>
References: <20241119101552.505650-1-aspsk@isovalent.com>
 <20241119101552.505650-4-aspsk@isovalent.com>
 <CAADnVQ+=SoVvmGizF8L78j=U+MWi1XnCQEdz9tJOxwYeKuZsJw@mail.gmail.com>
 <Z0X/8ufRfLOrEXfI@eis>
 <CAEf4BzYWWmiuUU7YizOVEC_qpuUsr8NQ5RcV9oLQYK5A7mgtWw@mail.gmail.com>
 <CAADnVQLHBEN0mAuTMkFygcTb6H+bjKz3HR4uKN6s5CRsGM7qxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLHBEN0mAuTMkFygcTb6H+bjKz3HR4uKN6s5CRsGM7qxg@mail.gmail.com>

On 24/11/26 12:40PM, Alexei Starovoitov wrote:
> On Tue, Nov 26, 2024 at 10:51 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Nov 26, 2024 at 9:27 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > >
> > > On 24/11/25 05:38PM, Alexei Starovoitov wrote:
> > > > On Tue, Nov 19, 2024 at 2:17 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > > >
> > > > > The fd_array attribute of the BPF_PROG_LOAD syscall may contain a set
> > > > > of file descriptors: maps or btfs. This field was introduced as a
> > > > > sparse array. Introduce a new attribute, fd_array_cnt, which, if
> > > > > present, indicates that the fd_array is a continuous array of the
> > > > > corresponding length.
> > > > >
> > > > > If fd_array_cnt is non-zero, then every map in the fd_array will be
> > > > > bound to the program, as if it was used by the program. This
> > > > > functionality is similar to the BPF_PROG_BIND_MAP syscall, but such
> > > > > maps can be used by the verifier during the program load.
> > > > >
> > > > > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > > > > ---
> > > > >  include/uapi/linux/bpf.h       |  10 ++++
> > > > >  kernel/bpf/syscall.c           |   2 +-
> > > > >  kernel/bpf/verifier.c          | 106 ++++++++++++++++++++++++++++-----
> > > > >  tools/include/uapi/linux/bpf.h |  10 ++++
> > > > >  4 files changed, 113 insertions(+), 15 deletions(-)
> > > > >
> >
> > [...]
> >
> > > > > +/*
> > > > > + * The add_fd_from_fd_array() is executed only if fd_array_cnt is given.  In
> > > > > + * this case expect that every file descriptor in the array is either a map or
> > > > > + * a BTF, or a hole (0). Everything else is considered to be trash.
> > > > > + */
> > > > > +static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
> > > > > +{
> > > > > +       struct bpf_map *map;
> > > > > +       CLASS(fd, f)(fd);
> > > > > +       int ret;
> > > > > +
> > > > > +       map = __bpf_map_get(f);
> > > > > +       if (!IS_ERR(map)) {
> > > > > +               ret = add_used_map(env, map);
> > > > > +               if (ret < 0)
> > > > > +                       return ret;
> > > > > +               return 0;
> > > > > +       }
> > > > > +
> > > > > +       if (!IS_ERR(__btf_get_by_fd(f)))
> > > > > +               return 0;
> > > > > +
> > > > > +       if (!fd)
> > > > > +               return 0;
> > > >
> > > > This is not allowed in new apis.
> > > > zero cannot be special.
> > >
> > > I thought that this is ok since I check for all possible valid FDs by this
> > > point: if fd=0 is a valid map or btf, then we will return it by this point.
> > >
> > > Why I wanted to keep 0 as a valid value, even if it is not pointing to any
> > > map/btf is for case when, like in libbpf gen, fd_array is populated with map
> > > fds starting from 0, and with btf fds from some offset, so in between there may
> > > be 0s. This is probably better to disallow this, and, if fd_array_cnt != 0,
> > > then to check if all [0...fd_array_cnt) elements are valid.
> >
> > If fd_array_cnt != 0 we can define that fd_array isn't sparse anymore
> > and every entry has to be valid. Let's do that.
> 
> Exactly.
> libbpf gen_loader has a very simplistic implementation of
> add_map_fd() and add_kfunc_btf_fd().
> It leaves gaps only to keep implementation simple.
> It can and probably should be changed to make it contiguous.

Ok, makes sense. I will send v3 based on all the comments.

For the libbpf gen_loader part, I can address this in one of the follow-ups
(when fd_array_cnt is actually set in libbpf).

