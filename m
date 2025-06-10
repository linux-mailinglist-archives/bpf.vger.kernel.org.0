Return-Path: <bpf+bounces-60232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8E4AD4324
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 21:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F2D23A44F2
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 19:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6A7264A77;
	Tue, 10 Jun 2025 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScDk9yhQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555C5231825
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749584884; cv=none; b=t+7KgIB5T6jj9ZCipBWfLsZYessaZiCqI0TQ+F4tRa4kuKhf0KT/uzQas3s5CQOXvbEm1eXaaHt5GBMDf4eXDUzuPfvYL59TSPvNEyO8vwr2yRI9D7ofOgyGR0KE6MPx7Q6avVcns7u+7SYfC5cmw6rXmWpoUjeCQReUVVr4qvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749584884; c=relaxed/simple;
	bh=yoDwG1BuVrg7AqnLEU/sETd5RaPN1ZHTvWgjj/l9WWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gc8RjvFtYnyre18545jCZn5XyAgTfIaKjrxkAuVhcFcLYlV4ZODotBUWNZ6JzREIFmF15ThlPXiegoMTcAYKDH+jaapokxi/9BAGttdRDV+C2pMT0y/3FryVDIQajB7ylZdI/si5rPrDXB3dXZbMG4hNzB6aWJaF004oM1xOxmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScDk9yhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1331C4AF0B
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 19:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749584883;
	bh=yoDwG1BuVrg7AqnLEU/sETd5RaPN1ZHTvWgjj/l9WWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ScDk9yhQCJJrHnF9vRe6XgraH5dpPyHjQPfbhywYta77xAFt184qTA1B0R8kHf4Qu
	 nkBMmj9SFf3jHKsncus7/NfyvwQ4LtNj3NZXfv/Hzaok8rm4mfWv4EQTqy2uq8f9n0
	 fB7lqxvnnazucRWBc9ZYizN0ztdD9z+nHP9VHC0Yuqi6+fyKsmp728fXeYJU+PKDqe
	 PuFrjBZomD+xXmC2lrpZLWY5moBaBAoqGtAn8gMaDZxv7Ebvt6Lk7B9xrhSXYPfGWH
	 SmBQJTf/2cfewv9MQEKRaA9KyDy2knWXrY1fEPZO6gBqzYID++6zKYiox91s9bb5XU
	 995S+3h4s9MNg==
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a58d95ea53so2413081cf.0
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 12:48:03 -0700 (PDT)
X-Gm-Message-State: AOJu0YxFgfgLZCtIbhSFspl0TqIJhBQr1mKgheQ1JWgd4n12WihLys6d
	57NtkgIgU+bkeEZ+rZSpXYK4PZ2r10dU8Gh8ULG7jwjzQMpRluScpT0ZJH5OiwqJy6e37PAFnie
	+L7IihPrwA+Fwv5RO4kFr1pjFtqFUtQLuSCRz1svQ
X-Google-Smtp-Source: AGHT+IHTQXCsE+9DO8q0fqdViAfgnnCssKsS6CPhiGfveZ0vdGCA8irgznmMsSO3Xh/YBBC0wsaX2MzrRTusR6ZQpvk=
X-Received: by 2002:a05:622a:5143:b0:4a6:f6e6:7696 with SMTP id
 d75a77b69052e-4a713ca4527mr10153551cf.26.1749584882983; Tue, 10 Jun 2025
 12:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-11-kpsingh@kernel.org>
 <87qzzrleuw.fsf@microsoft.com> <CACYkzJ6M7kA7Se4=AXWNVF1UyeHK3t+3Y_8Ap1L9pkUTbqys9Q@mail.gmail.com>
 <87o6uvlaxs.fsf@microsoft.com>
In-Reply-To: <87o6uvlaxs.fsf@microsoft.com>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 10 Jun 2025 21:47:50 +0200
X-Gmail-Original-Message-ID: <CACYkzJ74MJkwejki7kFNR4RWh+EnJ++0Vop8eRkSwY6pJepMEQ@mail.gmail.com>
X-Gm-Features: AX0GCFu6nivk5hjF7P3fcPiwxxwGtLOqd5Sw1a42cawYlnZTvT-OZKcEulInnpk
Message-ID: <CACYkzJ74MJkwejki7kFNR4RWh+EnJ++0Vop8eRkSwY6pJepMEQ@mail.gmail.com>
Subject: Re: [PATCH 10/12] libbpf: Embed and verify the metadata hash in the loader
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com, kys@microsoft.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 8:16=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>

[...]

> >
> >> to perform this check in-kernel, without impeding any of the other
> >> stated use cases. There is no possible audit log nor LSM hook for thes=
e
> >> operations. There is no way to know that this check was ever performed=
.
> >>
> >> Further, this check ends up happeing in an entirely different syscall,
> >> the LSM layer and the end user may both see invalid programs successfu=
lly
> >> being loaded into the kernel, that may fail mysteriously later.
> >>
> >> Also, this patch seems to rely on hacking into struct internals and
> >> magic binary layouts.
> >
> > These magical binary layouts are BPF programs, as I mentioned, if you
> > don't like this you (i.e an advanced user like Microsoft) can
> > implement your own trusted loader in whatever format you like. We are
> > not forcing you.
> >
> > If you really want to do it in the kernel, you can do it out of tree
> > and maintain these patches (that's what "out of tree" actually means),
> > this is not a direction the BPF maintainers are interested in as it
> > does not meet the broader community's use-cases. We don=E2=80=99t want =
an
> > unnecessary extension to the UAPI when some BPF programs do have
> > stable instructions already (e.g. network) and some that can
> > potentially have someday.
> >
>
> Yes, you are forcing us. Saying we are only allowed to use "trusted"
> loaders, and that no one is allowed to have any in-kernel, in-tree code

It's been repeatedly mentioned that trusted loaders (whether kernel or
BPF programs) are the only way because a large number of BPF use-cases
dynamically generate BPF programs. So whatever we build needs to work
for everyone and not just your specific use-case or your affinity to
an implementation.






> that inspects user inputs or target programs directly is very
> non-consentual on my end. This is a design mandate, being forced upon
> other people, by you, with no concrete reasons, other than vague statemen=
ts
> around UAPI design, need or necessity.
>
> -blaise
>
> > RE The struct internals will be replaced by calling BPF_OBJ_GET_INFO
> > directly from the loader program as I mentioned in the commit.=E2=80=9D
> >
> >
> > - KP
> >
> >
> >>
> >> -blaise
> >>
> >> >  void bpf_gen__record_attach_target(struct bpf_gen *gen, const char =
*attach_name,
> >> >                                  enum bpf_attach_type type)
> >> >  {
> >> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> >> > index b6ee9870523a..084372fa54f4 100644
> >> > --- a/tools/lib/bpf/libbpf.h
> >> > +++ b/tools/lib/bpf/libbpf.h
> >> > @@ -1803,9 +1803,10 @@ struct gen_loader_opts {
> >> >       const char *insns;
> >> >       __u32 data_sz;
> >> >       __u32 insns_sz;
> >> > +     bool gen_hash;
> >> >  };
> >> >
> >> > -#define gen_loader_opts__last_field insns_sz
> >> > +#define gen_loader_opts__last_field gen_hash
> >> >  LIBBPF_API int bpf_object__gen_loader(struct bpf_object *obj,
> >> >                                     struct gen_loader_opts *opts);
> >> >
> >> > --
> >> > 2.43.0

