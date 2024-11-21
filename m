Return-Path: <bpf+bounces-45422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAD99D560B
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 00:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B8B1F23B43
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 23:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E631DDC26;
	Thu, 21 Nov 2024 23:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDgr0zP4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEF323098E
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 23:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732230524; cv=none; b=hz8kdbuPHA3s6lTMgm9maWNlWIiLsgUEC2fbZe6oYl7Mz+y55ztd1Xq1M2Y3FIt5j1EfqOT1l6GaE/3I4d0xKiHxarElPTguPL3DGtS+CXziVoX39HpnflBzfHFm5EDGn9LRmBQHOpBPOzRMX+NaSBJrrWPlGUu3vfMxneDbhkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732230524; c=relaxed/simple;
	bh=BTEhivixK6bXYqyL00qM+RkT0CjyubyMg//WI7J6y4U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sHR8eYbsF1ozRlKRX+vxcPJq1eMq9gSh3aiD8WrVhxi7Mn4EeG5JBX4pK4AZxsYngNOtAkUbtYQgDjAP83w+hh7gpWznPj9kgsHCuHup60eQvibZhEEfCk7nSxJi+0lU9atXFvzeOveeBzN+S8RWPpS4mLwbSbFG0gwlf4Q+b2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDgr0zP4; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7242f559a9fso1498941b3a.1
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 15:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732230522; x=1732835322; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=luJLt51Iggv3bUqKX5wC5umswxvrQizFBlbW9u1n/FE=;
        b=VDgr0zP4IYStxjtlbG0ib7k9eY/awqsoVDb+/9IbmUaYnQPFjbLMnqPDNylSzRDUYs
         lTXf36ZF0849x9AXwhtswcf/merm+afDEnR/USXYEnX5NTTH+fJ5DlqB9UArukBOwoc0
         pdyLJOJ2uW1H92YQyKATJdjcGw/fTwP2u4fxOelbmYBrgDd+5LE22ovTpwoRU27lyFwu
         jjYlEEipKsxW0xipKcVq/8scotEVW0/w5Mc5HB64V3r0Db+c3LrnXQy/tTPHZ/NW0zDu
         e1mk9zx3O5HB+1uLbk0eVZyjWRgfzK3EfqF8NSJA/dVGP8l/XIfx/brmDMJ/rA0QDqYJ
         aYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732230522; x=1732835322;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=luJLt51Iggv3bUqKX5wC5umswxvrQizFBlbW9u1n/FE=;
        b=I9s/UXi+iP29pyf+nPZo2Nrd+9Yz1alIgkDSk/ma0PW5EeC67xbWrmP/QkT54mYzo9
         TJat+Je0qxhzEqyTr0XPYc2Bd/Tl/r80skmAvpOLAp1BwgtNSzbEDmWYT0Uq8Lo+K9IC
         29CdQRByczM/g41tlnazIxaSJOru/8YGF5luKSJGbaE2FOvNNRU+bPH2h51dLM7eyLuD
         7F0s4MFT3pMpeO5O06hcY5DD0yuGKF9toq28aQVxsuJX9Vcc1JYcksj3zI/ffGVS8vgK
         CSsMmCrf8gkugwKYdWP6WtbECChn9E0LAT0qmqXLnilMuhACpb3PTPYPQoVlqDqNAl6i
         GUJA==
X-Gm-Message-State: AOJu0YzcvU8BsGkuiRKFd4XV6idFKxQVUDNG2jYL2zdebJIgA1zuSzgz
	NAPLwO/N4K/h+8YLQRV6WF/p32d+kQSqDpQIvOHwhPTkknqMQc2i
X-Gm-Gg: ASbGncth1g6hx4KFg2S707aiiufUsRgkhwkZ5UsDL0p6bCQ5VUFKfuBezdLz4jlBYix
	6ZRf9wk2WtohTt6BRk8SqjQi88x2U/G2wxmDza6dswrsh9SlJmIWvW5AI9gySqqmQQVmzWJgbqg
	7jID8HE5rIqtTWHq35DZpQQ1mfC8VsButLo3ldkjX5v055XGtGatMpnRFX+oJX3KoOV4Uep+GbA
	AkpWfPkziHI3Efn8cJRRH+7Z/mU980b8dvrrTDMnwgmnag=
X-Google-Smtp-Source: AGHT+IEvo2CAFPraFXNsDyT9ZKaODGmrAtYVtfRyim9EsUeS3PRcR77+ZbQrQs2wJkYeaHEbkkLMjw==
X-Received: by 2002:a05:6a00:3e1f:b0:71e:5033:c5 with SMTP id d2e1a72fcca58-724df64a700mr975980b3a.14.1732230522211;
        Thu, 21 Nov 2024 15:08:42 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de5553e0sm311529b3a.144.2024.11.21.15.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 15:08:41 -0800 (PST)
Message-ID: <46250fef76c4b78eb283c724f27fcf4e275d4839.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 5/7] bpf: Introduce support for
 bpf_local_irq_{save,restore}
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>,
 kernel-team@fb.com
Date: Thu, 21 Nov 2024 15:08:37 -0800
In-Reply-To: <CAP01T75FEfodis5YLie5kBPG4FSyyinSAa0m+ZP8H+_PhseWRQ@mail.gmail.com>
References: <20241121005329.408873-1-memxor@gmail.com>
	 <20241121005329.408873-6-memxor@gmail.com>
	 <c49e756f6e4ef492a68b7cd3b856240282963f8e.camel@gmail.com>
	 <CAP01T75FEfodis5YLie5kBPG4FSyyinSAa0m+ZP8H+_PhseWRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-21 at 23:06 +0100, Kumar Kartikeya Dwivedi wrote:

[...]

> > > +/* Keep unsinged long in prototype so that kfunc is usable when emit=
ted to
> > > + * vmlinux.h in BPF programs directly, but since unsigned long may p=
otentially
> > > + * be 4 byte, always cast to u64 when reading/writing from this poin=
ter as it
> > > + * always points to an 8-byte memory region in BPF stack.
> > > + */
> > > +__bpf_kfunc void bpf_local_irq_save(unsigned long *flags__irq_flag)
> >=20
> > Nit: 'unsigned long long' is guaranteed to be at-least 64 bit.
> >      What would go wrong if 'u64' is used here?
>=20
> It goes like this:
> If I make this unsigned long long * or u64 *, the kfunc emitted to
> vmlinux.h expects a pointer of that type.
> Typically, kernel code is always passing unsigned long flags to these
> functions, and that's what people are used to.
> Given for --target=3Dbpf unsigned long * is always a 8-byte value, I
> just did this, so that in kernels that are 32-bit,
> we don't end up relying on unsigned long still being 8 when
> fetching/storing flags on BPF stack.

So, the goal is to enable the following pattern:

  unsigned long flags;
  bpf_local_irq_save(&flags);

Right?

For a 32-bit system 'flags' would be 4 bytes long.
Consider the following example:

  unsigned long flags; // assume 'flags' and 'foo'
  int foo;             // are allocated sequentially.
 =20
  bpf_local_irq_save(&flags);

I think that in such case '*ptr =3D flags;' would overwrite foo.

[...]

> > > +{
> > > +     u64 *ptr =3D (u64 *)flags__irq_flag;
> > > +     unsigned long flags;
> > > +
> > > +     local_irq_save(flags);
> > > +     *ptr =3D flags;
> > > +}


