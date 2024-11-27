Return-Path: <bpf+bounces-45690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F368C9DA27A
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 07:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD951673C6
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 06:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27151148304;
	Wed, 27 Nov 2024 06:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="K/KYmiXs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C6E14AD02
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 06:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732690013; cv=none; b=MKzeXu9bP/Fq208BOJpMruAzk3NzfpYsL+yP6Rxh6hwUgv11WQS/MEosIko8KREomPxjVUsoaK9DYT2PYagd4bBUbMtJLLZ/V2CUjhJ1QYsS9FFD+JkzJcU9DXUQEUAdsRFVRfp0Amm4dqz7+8yUp5jX6cgShru8c0dw1J8XmAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732690013; c=relaxed/simple;
	bh=QRqUt4SFtEL5pKckuOZnd9DakG9D0Se/bc6K0N/TljM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKbSMyYTkNdlr74Js4nWttPBh84wiCfomKdeRhtSXnKtxdTWfGvXClTdqZ4fZ5bp92Ga0rYvsx0rt5ba8WTOXDFbnI6jab88sDVX9JrCLx3MWv/iHXiXYKr5HwizFbZ46E8ReHWk+UVeXKHlWfSD4vVa7IgS1BeV1MIqBp3ERQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=K/KYmiXs; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cfa9979cd1so811198a12.1
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 22:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1732690010; x=1733294810; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FJmbsF57TWpbdjJ8PaMofCXscD9TkSHeO3/QrlWyovs=;
        b=K/KYmiXsd/kr5bNAy8IrIoLycNmE2qJ/9mJT+5E/WXbdYXf5V9vv1642Do5zmB7/Fx
         1RY1JQ//4HPXQl2T+8WNPKcLnQCJfz18PI7JRd6wZkjJr2RrvwYveEBHAc9/uE7GSJb5
         sWyZMpv7TmZu8X7Y1h4M+Eaddpzo18NR9Q+LRdLrAjwGRsSDff9OVT5qp1E6KgYd30ZX
         RpjSXytKpcFHF7KkUIcHMvI+ewp5P6pCq9rLglby9UvzwZhfNLkNxKWje0gxlyyibv6I
         aHH3CZgT/cK+V5wgiWncidm5BzfWjAYycVm4EPX/w5WOahmLlX9fIA8CtcfJW1uAso3B
         Evjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732690010; x=1733294810;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJmbsF57TWpbdjJ8PaMofCXscD9TkSHeO3/QrlWyovs=;
        b=A667s5IDDYA5BDdKLH+H7u8gTgD3762sUMlDJvgX0WcoJJCJDKHwEpjWwsgiA/UZXx
         b5Zg1w7WX65R8ZILY2kJWVm8okOX21wHqjPIeXdV71iJvgM81S2ms3mXFCeEsdaTz4S2
         G1lKx5BUdb7tK8FccAE8qbzz7pcwUFs/qReoRxkNrjK6eLSPHz2VhF9fygxm/nE36uPz
         OojMJ7WsSxufKKnrlnfpRsQeDECtqCsEDJSeB8uC0vX4QovFV/b4+28/KowvvLmRYfY4
         FRffAfV0lcRDsvO/nH8EvmVWFCr5yOE/nOatA682H1Bud4Pxao2rXoKq/suU83nOai+g
         mXRw==
X-Forwarded-Encrypted: i=1; AJvYcCV0DR83/59VEU5EHAfiQRdpB66vvATFqdkFW6I1puUbbAe63D2EHC53FPSFKUoE+j5/uk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHG3X7CcbQxOwbZlqI5DELWYmcPY2lsh1nyYbyE8ApK9fCtPGQ
	XQr9TBYncLP2ZFYEVGhMNLdHC7nnr6cYTKeDkCFqhBtvIngHvUlA522IKdBla8wtczqFSmuZV5D
	k
X-Gm-Gg: ASbGncsLCHBNvewqelzuN30sTS9OcVsoyVgscJlP/Qdr3lORr3LyVoTDzgFpxqvzI5L
	dFmXVCvCxVVUKrmfv/O1lhsPAc83lWYLEiDdI+AP48Utb+Cc6xNAmyiuUpSaqhzr+PWewZqhpVx
	ZmQh2tRhUBhYsMOt3HyfAcWlzAKc1QcRdSVtXctVTpSr9yirfdQs7U9qAIQsDOGI0dW3KatIKpp
	BYgQgl02X3OM1wJK/f6C3hU/sLa6fJcjIDGrHI=
X-Google-Smtp-Source: AGHT+IEplqPesbOm3FaOExTBO+mhPDKKu5UbF2lyqUsG8269+3OXH8oJ+cFemADl4604Y0dszxaIjg==
X-Received: by 2002:a05:6402:90b:b0:5cf:af26:3da9 with SMTP id 4fb4d7f45d1cf-5d06adcf741mr6221983a12.12.1732690009847;
        Tue, 26 Nov 2024 22:46:49 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3fc663sm5830228a12.66.2024.11.26.22.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 22:46:49 -0800 (PST)
Date: Wed, 27 Nov 2024 06:49:22 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 3/6] bpf: add fd_array_cnt attribute for
 prog_load
Message-ID: <Z0bA8pSeRpsfeNiS@eis>
References: <20241119101552.505650-1-aspsk@isovalent.com>
 <20241119101552.505650-4-aspsk@isovalent.com>
 <CAADnVQ+=SoVvmGizF8L78j=U+MWi1XnCQEdz9tJOxwYeKuZsJw@mail.gmail.com>
 <Z0X/8ufRfLOrEXfI@eis>
 <CAEf4BzYWWmiuUU7YizOVEC_qpuUsr8NQ5RcV9oLQYK5A7mgtWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYWWmiuUU7YizOVEC_qpuUsr8NQ5RcV9oLQYK5A7mgtWw@mail.gmail.com>

On 24/11/26 10:51AM, Andrii Nakryiko wrote:
> On Tue, Nov 26, 2024 at 9:27 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > On 24/11/25 05:38PM, Alexei Starovoitov wrote:
> > > On Tue, Nov 19, 2024 at 2:17 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > >
> > > > The fd_array attribute of the BPF_PROG_LOAD syscall may contain a set
> > > > of file descriptors: maps or btfs. This field was introduced as a
> > > > sparse array. Introduce a new attribute, fd_array_cnt, which, if
> > > > present, indicates that the fd_array is a continuous array of the
> > > > corresponding length.
> > > >
> > > > If fd_array_cnt is non-zero, then every map in the fd_array will be
> > > > bound to the program, as if it was used by the program. This
> > > > functionality is similar to the BPF_PROG_BIND_MAP syscall, but such
> > > > maps can be used by the verifier during the program load.
> > > >
> > > > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > > > ---
> > > >  include/uapi/linux/bpf.h       |  10 ++++
> > > >  kernel/bpf/syscall.c           |   2 +-
> > > >  kernel/bpf/verifier.c          | 106 ++++++++++++++++++++++++++++-----
> > > >  tools/include/uapi/linux/bpf.h |  10 ++++
> > > >  4 files changed, 113 insertions(+), 15 deletions(-)
> > > >
> 
> [...]
> 
> > > > +/*
> > > > + * The add_fd_from_fd_array() is executed only if fd_array_cnt is given.  In
> > > > + * this case expect that every file descriptor in the array is either a map or
> > > > + * a BTF, or a hole (0). Everything else is considered to be trash.
> > > > + */
> > > > +static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
> > > > +{
> > > > +       struct bpf_map *map;
> > > > +       CLASS(fd, f)(fd);
> > > > +       int ret;
> > > > +
> > > > +       map = __bpf_map_get(f);
> > > > +       if (!IS_ERR(map)) {
> > > > +               ret = add_used_map(env, map);
> > > > +               if (ret < 0)
> > > > +                       return ret;
> > > > +               return 0;
> > > > +       }
> > > > +
> > > > +       if (!IS_ERR(__btf_get_by_fd(f)))
> > > > +               return 0;
> > > > +
> > > > +       if (!fd)
> > > > +               return 0;
> > >
> > > This is not allowed in new apis.
> > > zero cannot be special.
> >
> > I thought that this is ok since I check for all possible valid FDs by this
> > point: if fd=0 is a valid map or btf, then we will return it by this point.
> >
> > Why I wanted to keep 0 as a valid value, even if it is not pointing to any
> > map/btf is for case when, like in libbpf gen, fd_array is populated with map
> > fds starting from 0, and with btf fds from some offset, so in between there may
> > be 0s. This is probably better to disallow this, and, if fd_array_cnt != 0,
> > then to check if all [0...fd_array_cnt) elements are valid.
> 
> If fd_array_cnt != 0 we can define that fd_array isn't sparse anymore
> and every entry has to be valid. Let's do that.

Yes, makes sense

> >
> > > > +
> > > > +       verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", fd);
> > > > +       return PTR_ERR(map);
> > > > +}
> > > > +
> > > > +static int env_init_fd_array(struct bpf_verifier_env *env, union bpf_attr *attr, bpfptr_t uattr)
> > >
> > > What an odd name... why is 'env_' there?
> >
> 
> [...]
> 
> > > I don't get this feature.
> > > Why bother copying and checking for validity?
> > > What does it buy ?
> >
> > So, the main reason for this whole change is to allow unrelated maps, which
> > aren't referenced by a program directly, to be noticed and available during the
> > verification. Thus, I want to go through the array here and add them to
> > used_maps. (In a consequent patch, "instuction sets" maps are treated
> > additionally at this point as well.)
> >
> > The reason to discard that copy here was that "old api" when fd_array_cnt is 0
> > is still valid and in this case we can't copy fd_array in full. Later during
> > the verification fd_array elements are accessed individually by copying from
> > bpfptr. I thought that freeing this copy here is more readable than to add
> > a check at every such occasion.
> 
> I think Alexei meant why you need to make an entire copy of fd_array,
> if you can just read one element at a time (still with
> copy_from_bpfptr_offset()), validate/add map/btf from that FD, and
> move to the next element. No need to make a copy of an array.
> 
> >
> > > pw-bot: cr
> >

