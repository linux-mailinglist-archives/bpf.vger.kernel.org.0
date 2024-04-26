Return-Path: <bpf+bounces-27915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDFF8B346B
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 11:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91F3285537
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 09:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629C713F43C;
	Fri, 26 Apr 2024 09:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oazdViId"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C61413C9A7
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714124895; cv=none; b=pMCeIUtZO5lkY3R6XjGVw3S8iVpHhaAymIx8KabaLkZk845a66izDq0gsmtFxlQHRkG31D+53lLuNZW2HPnG27GsQeGwAuW88aYldhBPcVt+vPjEqmcPiiC3wto6qw/CuIPQ5F/t44SVq2FbwqrH7YCSnjY5yxlVQmIHyeOlAwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714124895; c=relaxed/simple;
	bh=Pxci3WlXb043NuqC6AFYHpL8k5EzMqw+0UuaFcFhMT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGDovcChFboYZdKBjvqBVVAWSXywHGf0raU91EnlnjrjFtur5x5S5FjZvae347Nx6tZIKljMCARnc9mjHLyZgA2D14g73ptMbzKC6LbPnyLJ6ltfRrV8U9/8c9Joy6zL5EZdmw0yFVmnIfsaIZIbN6fej35gi32vA2+UDyLDxDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oazdViId; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57232e47a81so3293059a12.0
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 02:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714124892; x=1714729692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S755M1L2pWNA4GE6zlj60wgTFH06qKZnyQZ7IfTrRhs=;
        b=oazdViIdArYb5gxZbkLcUyWnnFZFYNC9F1pzBW7f8d/EifcH0l1LYgmwyTnczpgACK
         jveh237ICk2yK/YilSwdWOgc4DdBTwSkwQnQx2HRF3c0YCXjltFqQ2Mimco0rJLhzwsn
         sZAJuvoK/1DdJh3hxhVuPE5yQP5Ae4e3Qnd9WXc1pe1MqhbI71kTrm465mBqF9giQ2+V
         QPgJIR46TdVryiA/lk8RdgTHLKHl9Rg3V4Z0mM/s757Yij3KNlF2nk7BNyouPzsCtku9
         FMiPB/yuJTt3F2L+Z4vWqmLYxog4LMWCIYwDAm01G2tyzOgbIBtLSTYXU4HzUHN8/TUt
         ujKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714124892; x=1714729692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S755M1L2pWNA4GE6zlj60wgTFH06qKZnyQZ7IfTrRhs=;
        b=dVFlI4yeYLWM+cmhXx8mY+xDqOFJX4t4OD9rdlPwqhNE3MGhlbcBWBj5xTRQ+VxgFe
         /VEiPePuSkNeb8RCAVHjKK35YJ01kLNfjh6LRsOERMTPflAHzUz4KHg5DsloG5xTDy+o
         U44XvtXR5VzDOGgPYZD10g66QjtfLo9nYYplZXG6NzTCeIemC9S/B00oJKWFbww5re0C
         h6ZX2bybiJ8stFqyRS+IqanqlM2oVE9NPRrWttCgX5o0dDwMFjfycb0TVDnWdAloF/9c
         1Q14KtU4iXZIHYiLoYC/XS3HYHnIKIRJtjW+sIT2zzkp8umvqqHUpB5WorqBfnywlTds
         fHcw==
X-Forwarded-Encrypted: i=1; AJvYcCVeig64Yo/jViWc676ytFZ9oEeI93BCpYQWafs16fDvBIyzxZYLIY1ZqRgOt67z3axSM+xhJig6AJOCovjiPsgicX90
X-Gm-Message-State: AOJu0Yz+ZYhcsGJr1NThIMz1q8tsBLNLTiPHuIUh3KtDVLvPuv+TT+7b
	Q/4arx7QDum9Nlmw0cqUuOsspKE+bSJey9XSGknJ09zsmxuc8aQoP9uEnCFFxg==
X-Google-Smtp-Source: AGHT+IGFm0a/zg+NRIw6fBAZCRBuKHj1WXJeL5tZUxq7m3mV1zf7a7s44SWwRQbLECzrxv+IiVtMkw==
X-Received: by 2002:aa7:d389:0:b0:572:5131:83a2 with SMTP id x9-20020aa7d389000000b00572513183a2mr1840158edq.1.1714124892441;
        Fri, 26 Apr 2024 02:48:12 -0700 (PDT)
Received: from google.com (118.240.90.34.bc.googleusercontent.com. [34.90.240.118])
        by smtp.gmail.com with ESMTPSA id b18-20020a0564021f1200b00572066c5d66sm5728789edb.81.2024.04.26.02.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 02:48:11 -0700 (PDT)
Date: Fri, 26 Apr 2024 09:48:07 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: David Vernet <void@manifault.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC] bpf: allowing PTR_TO_BTF_ID | PTR_TRUSTED w/ non-zero
 fixed offset to selected KF_TRUSTED_ARGS BPF kfuncs
Message-ID: <Zit4V18JdtOUcV-s@google.com>
References: <ZhkbrM55MKQ0KeIV@google.com>
 <3f8a481e-0dfe-468f-8c87-6610528f9009@linux.dev>
 <ZiAu6YDi-F_pxLOV@google.com>
 <dbba17cf-4351-45ca-9f43-090a0923a2bb@linux.dev>
 <CAADnVQ+z5w4GaMudrLXw3LAq1B3Ong7FhQHdkJN7m8svkCpMgA@mail.gmail.com>
 <20240424055005.GA170502@maniforge>
 <CAADnVQ+xPgOCYsMk8Tot0PPTWgY5Yqat9V-qZGaWXAF+BpxCow@mail.gmail.com>
 <20240425155914.GA11295@maniforge>
 <CAP01T766cfEwm1Mz63c-eQK57K0Ot7JED8k3t+0mAs5jXr6L0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T766cfEwm1Mz63c-eQK57K0Ot7JED8k3t+0mAs5jXr6L0Q@mail.gmail.com>

Apologies about the delayed response on this thread, I've been on
parental leave for the last couple of weeks and only just catching up
on everything now.

On Thu, Apr 25, 2024 at 06:06:00PM +0200, Kumar Kartikeya Dwivedi wrote:
> On Thu, 25 Apr 2024 at 17:59, David Vernet <void@manifault.com> wrote:
> >
> > On Wed, Apr 24, 2024 at 11:36:51AM -0700, Alexei Starovoitov wrote:
> >
> > [...]
> >
> > > > The OBJ_RELEASE causes check_func_arg_reg_off() to fail to verify if
> > > > there's a nonzero offset. In reality, I _think_ we only need to check
> > > > for a nonzero offset for KF_RELEASE, and possibly KF_ACQUIRE.
> > >
> > > Why special case KF_RELEASE/ACQUIRE ?
> > > I think they're no different from kfuncs with KF_TRUSTED_ARGS.
> > > Should be safe to allow non-zero offset trusted arg in all cases.
> >
> > Yeah, after thinking about this some more I agree with you. All we need
> > to do is verify that the object at the non-zero offset has a
> > ref_obj_id > 0 if being passed to KF_RELEASE. No different than at
> > offset 0. This will be a nice usability improvement. The offset=0
> > restriction really does seem pointless and arbitrary, unless I'm
> > completely missing something.
> >
> 
> It will be mostly ok, especially if a type match (not just type == X,
> but for PTR_TO_BTF_ID, btf_struct_ids_match) follows the ref_obj_id
> check (regardless of the offset).
> Just be careful when such type match won't happen, e.g. with kfuncs
> like bpf_obj_drop (taking a void *). In such a case off == 0 is
> necessary, otherwise we'll pass the wrong pointer to the free function
> in the kfunc.
> 
> We've had bugs in absence of type matching with offset != 0, e.g.
> 64620e0a1e71 ("bpf: Fix out of bounds access for ringbuf helpers")
> comes to mind, which slipped through.
> 
> > > > > We can allow off!=0 and it won't confuse btf_type_ids_nocast_alias.
> > > > >
> > > > >     struct  nf_conn___init {
> > > > >             int another_field_at_off_zero;
> > > > >             struct nf_conn ct;
> > > > >     };
> > > > >
> > > > > will still trigger strict_type_match as expected.
> > > >
> > > > Yes, this should continue to just work, but I think we may also have to
> > > > be cognizant to not allow this type of pattern:
> > > >
> > > > struct some_other_type {
> > > >         int field_at_off_zero;
> > > >         struct nf_conn___init ct;
> > > > };
> > > >
> > > > In this case, we don't want to allow &other_type->ct to be passed to a
> > > > kfunc expecting a struct nf_conn. So we'd also have to compare the type
> > > > at the register offset to make sure it's not a nocast alias, not just
> > > > the type in the register itself. I'm not sure if this is a problem in
> > > > practice. I expect it isn't. struct nf_conn___init exists solely to
> > > > allow the struct nf_conn kfuncs to enforce calling semantics so that an
> > > > uninitialized struct nf_conn object can't be passed to specific kfuncs
> > > > that are expecting an initialized object. I don't see why we'd ever
> > > > embed a wrapper type like that inside of another type. But still
> > > > something to be cognizant of.
> > >
> > > Agree that it's not a problem now and I wouldn't proactively
> > > complicate the verifier.  __init types are in the kernel code and it
> > > gets code reviewed.  So 'struct some_other_type' won't happen out of
> > > nowhere.
> >
> > Makes sense

OK, so based on what has been discussed within this thread, I've
understood that we're OK with generally relaxing the reg->off
restriction that is currently in place for
KF_ACQUIRE/KF_RELEASE/KF_TRUSTED_ARGS/KF_RCU flagged BPF kfuncs?

This is providing that we substitute the current !reg->off checks with
the following instead moving forward:

* For arguments passed to BPF kfuncs that makes use of the
  KF_RELEASE/KF_TRUSTED_ARGS/KF_RCU flag, ensure that the backing reg
  has a reg->ref_obj_id > 0, irrespective of the value held by
  reg->off.

* Perform a type match check against reg and the arguments of the
  KF_RELEASE/KF_TRUSTED_ARGS/KF_RCU based BPF kfunc, following the
  preceding reg->ref_obj_id > 0 check.

* If we fail to type match, because the
  KF_RELEASE/KF_TRUSTED_ARGS/KF_RCU based BPF kfunc takes a void
  pointer, fallback to enforcing the !reg->off that was previously in
  place.

Please do correct me if I've misunderstood something.

/M

