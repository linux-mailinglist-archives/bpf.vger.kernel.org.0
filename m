Return-Path: <bpf+bounces-27822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B37E28B25FC
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 18:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DBD11F21B67
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 16:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0CB14C58E;
	Thu, 25 Apr 2024 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VC+p+74z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726E212C466
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061201; cv=none; b=GmXRavnt1sZrXwuo6saOqxL1MmWrQuJgLH7wUX9/GDVSQXejOuyKhGNxWb7bCwmNfpQLq5w+Rw8gUoCgFGfsE3Lut4kg5G8bKnkipBu9IqFt8sWQOz4fB4FPRSNpIwBp8A0T/2bmSlOGZ0aMNfGQBgXP2i8/w9otdd2KkKN+elw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061201; c=relaxed/simple;
	bh=7DNrUZfi2QI0ao/AWMzWuBqIRSSIDlxpvtfpCIA4+1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctq6GY/nhfTJRGlZNb5oLdKwkm82ajpy3VmajFWpD6SYRmYyLXBXU2VNdlPvqqBFQ3ck6tbwRBzXVQrjbyk48qzdqgNpG3NejLt3bTtngk9e3cJBYWRnZVZg+kSh7v80lGnlfHxRd6wA5ANLSDah7YAugGgmalAKTVGjhUgTdKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VC+p+74z; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-571be483ccaso1351703a12.2
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 09:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714061198; x=1714665998; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y/kPwPw/1FACF9bgLDDz7zi17XFguuCsu/uPAeBllSo=;
        b=VC+p+74zvRESFOBAxsTHTkTQw7HNaGSYOU4m55NmcAUfHvPux4Ku6Tgt1l2dWZ1Z67
         K7IrVVtdpkN0xIRn+tnwKxnUdS6SMzkeVv5NO0roeG5P69Ago9RubXOWBTyElflE6hr8
         YcR8tBXRlui9NDe7M5q3JJRmvlHqQosPZ+//fnNS1UZ1sR5XEur8eGzzgy8oER7opoZ5
         h3IY5pUqO/5hrqATBpUW6PVrz3n+apNPo98LrN3Iev3kbyEVOdnsJ3kJgbdWGY/xD+F+
         bGdPX86Szuf4M5wF4LkumQ53oxQlDtUAAmlMuf+Awr5nC97Oz86i3EWZOfb/jOnBeKDb
         lBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714061198; x=1714665998;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/kPwPw/1FACF9bgLDDz7zi17XFguuCsu/uPAeBllSo=;
        b=sFa+86n3IcD5Cak7rBjFF4SwVAVJBdvHd7xM963lyOqorx9l35vQ9xpIHJ8Vl4/tmg
         18hPqY1BPgCCDdkztYdawr3XveQR68rdK0krCDTnCqGL871iaNXiaDay2WXzDSGxXdsE
         PTA+/J9EiwsX2VQJKkx9K2lsXvc/k/bLS8XVRiK+tFPxpgJSOWKJOxVMyUtyyw5lFT/S
         Y1Ve4bLi8juAL92x1yN4BM1cKDN3W3Zscscmc4dPEiFplD8orrbO/MmJGR7Phz7xYz1Y
         SBI4kWMf9bxuiIt0IBvmE42RqCknBS7kzbxIX4wYVI9gnHJIQwshmqtpTA1lkapDdXv5
         f95w==
X-Forwarded-Encrypted: i=1; AJvYcCUJvseWCPXJJo/YO88iN6gWFIotb6q9nvwGlsH84VYBdIzpkycjR7jP67huZyIep87/osiBh9AntH3wYLOuT7KAoRRo
X-Gm-Message-State: AOJu0Ywz4DGj8GaO5KryqEvAf49bfdZ/Nqg0XqH7v+FqHRd+WU5LvT0V
	r15nKQEHcL0AvBFUgw8c9i343CMpFAJdNWZIKFo4uKthAC4VqSFIi5oxfb1xZoHLekp6pjkvPdJ
	ing1laasYfZ3+sZ86wMQKrUPGpI5gfs2er/Q=
X-Google-Smtp-Source: AGHT+IH8vXLaCTTmtDH68FXKgxO1sV0uFYxpLoRMsz4tNlpHT88UmJxkEsdMgiMdJFv5Vl75Ivq/KDsGhYBOIWEUre4=
X-Received: by 2002:a17:906:2b8e:b0:a58:7f1b:4656 with SMTP id
 m14-20020a1709062b8e00b00a587f1b4656mr115313ejg.74.1714061197460; Thu, 25 Apr
 2024 09:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZhkbrM55MKQ0KeIV@google.com> <3f8a481e-0dfe-468f-8c87-6610528f9009@linux.dev>
 <ZiAu6YDi-F_pxLOV@google.com> <dbba17cf-4351-45ca-9f43-090a0923a2bb@linux.dev>
 <CAADnVQ+z5w4GaMudrLXw3LAq1B3Ong7FhQHdkJN7m8svkCpMgA@mail.gmail.com>
 <20240424055005.GA170502@maniforge> <CAADnVQ+xPgOCYsMk8Tot0PPTWgY5Yqat9V-qZGaWXAF+BpxCow@mail.gmail.com>
 <20240425155914.GA11295@maniforge>
In-Reply-To: <20240425155914.GA11295@maniforge>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 25 Apr 2024 18:06:00 +0200
Message-ID: <CAP01T766cfEwm1Mz63c-eQK57K0Ot7JED8k3t+0mAs5jXr6L0Q@mail.gmail.com>
Subject: Re: [RFC] bpf: allowing PTR_TO_BTF_ID | PTR_TRUSTED w/ non-zero fixed
 offset to selected KF_TRUSTED_ARGS BPF kfuncs
To: David Vernet <void@manifault.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Apr 2024 at 17:59, David Vernet <void@manifault.com> wrote:
>
> On Wed, Apr 24, 2024 at 11:36:51AM -0700, Alexei Starovoitov wrote:
>
> [...]
>
> > > The OBJ_RELEASE causes check_func_arg_reg_off() to fail to verify if
> > > there's a nonzero offset. In reality, I _think_ we only need to check
> > > for a nonzero offset for KF_RELEASE, and possibly KF_ACQUIRE.
> >
> > Why special case KF_RELEASE/ACQUIRE ?
> > I think they're no different from kfuncs with KF_TRUSTED_ARGS.
> > Should be safe to allow non-zero offset trusted arg in all cases.
>
> Yeah, after thinking about this some more I agree with you. All we need
> to do is verify that the object at the non-zero offset has a
> ref_obj_id > 0 if being passed to KF_RELEASE. No different than at
> offset 0. This will be a nice usability improvement. The offset=0
> restriction really does seem pointless and arbitrary, unless I'm
> completely missing something.
>

It will be mostly ok, especially if a type match (not just type == X,
but for PTR_TO_BTF_ID, btf_struct_ids_match) follows the ref_obj_id
check (regardless of the offset).
Just be careful when such type match won't happen, e.g. with kfuncs
like bpf_obj_drop (taking a void *). In such a case off == 0 is
necessary, otherwise we'll pass the wrong pointer to the free function
in the kfunc.

We've had bugs in absence of type matching with offset != 0, e.g.
64620e0a1e71 ("bpf: Fix out of bounds access for ringbuf helpers")
comes to mind, which slipped through.

> > > > We can allow off!=0 and it won't confuse btf_type_ids_nocast_alias.
> > > >
> > > >     struct  nf_conn___init {
> > > >             int another_field_at_off_zero;
> > > >             struct nf_conn ct;
> > > >     };
> > > >
> > > > will still trigger strict_type_match as expected.
> > >
> > > Yes, this should continue to just work, but I think we may also have to
> > > be cognizant to not allow this type of pattern:
> > >
> > > struct some_other_type {
> > >         int field_at_off_zero;
> > >         struct nf_conn___init ct;
> > > };
> > >
> > > In this case, we don't want to allow &other_type->ct to be passed to a
> > > kfunc expecting a struct nf_conn. So we'd also have to compare the type
> > > at the register offset to make sure it's not a nocast alias, not just
> > > the type in the register itself. I'm not sure if this is a problem in
> > > practice. I expect it isn't. struct nf_conn___init exists solely to
> > > allow the struct nf_conn kfuncs to enforce calling semantics so that an
> > > uninitialized struct nf_conn object can't be passed to specific kfuncs
> > > that are expecting an initialized object. I don't see why we'd ever
> > > embed a wrapper type like that inside of another type. But still
> > > something to be cognizant of.
> >
> > Agree that it's not a problem now and I wouldn't proactively
> > complicate the verifier.  __init types are in the kernel code and it
> > gets code reviewed.  So 'struct some_other_type' won't happen out of
> > nowhere.
>
> Makes sense

