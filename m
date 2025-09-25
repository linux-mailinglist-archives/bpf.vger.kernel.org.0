Return-Path: <bpf+bounces-69786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF777BA1E47
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 00:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA872A2612
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 22:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29372EBBB9;
	Thu, 25 Sep 2025 22:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGqNF727"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D749627381E
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 22:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758840866; cv=none; b=mvl2IwH4nDeNUdm2O/gXRfc2fCM6hw8jJ/t+qsbMd4W4227w0CAtsObsyXrFrYRmATgCEUrTmysqz4BJ6mhbLHB6j6sI17MI+XqyeIyJ+v4RDYc/SASOIVYDsdJ9jtOqKXPg+hX3a995Mg5cKxDPH7JMwyIQ3B4iFNhurSsSvrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758840866; c=relaxed/simple;
	bh=v9IHZa6UUD2fyTqSiQjOSshlFhjUT7IFby7QXTQVXmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBNpkN9q6LIEeSapqPfaFnTkhj8X8bNmkk2d73NHa4E4RGzL73LzPVfhl8uVIxg+HT3eRdfhw/cOUaoOy3N686PAseULyQ+wrFBxzhKRqBUms57rYmDjIpv9kKMCOzTwo9lylf4zGt7YuztR9+eOgrNj2bqF+42o0camm/+Kfuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGqNF727; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b54a74f9150so1375640a12.0
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 15:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758840864; x=1759445664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9IHZa6UUD2fyTqSiQjOSshlFhjUT7IFby7QXTQVXmQ=;
        b=GGqNF727UbwJkcOxpUhD8pnTyI/3Rh3sDoxjoboAZhXNIwM24P3ZpK/TH/EOrIwZ7A
         UjDT3BsKz7LZ1lahYBlT5LaNrT3CaRy9ufZv9TguL6Do7Gm2Hy2VAQsJMfkQY47OK6Wn
         yk8pN8UIgqXEjYgN+EWNQyvwzFz8lW/cVuE5Na0MwoPGCq701xse3UFY2fr26/3fcnHe
         Wj7ZIToqOrCk5KnWFIA1SuMSwvug0YdgvkrK1Ryet32tJ3IxkedBafHuHaBP+m003tke
         cVC2MBkjbgPuje/W23rCfNAsfDOONjdHauNzO3P8H4QUh9ghRI9Jd+X2Utu+jblEPaQ3
         VqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758840864; x=1759445664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9IHZa6UUD2fyTqSiQjOSshlFhjUT7IFby7QXTQVXmQ=;
        b=NhlvFXTGgKDlzBbidbG+SaGKdzTZt9y10/UaheT+x81QYxiVIS4AMaIjq0tP7CuCbg
         bEQwb6QVmWmDzqHJtx+WtD8+HTJvYzCIv89C2IacmSxFPfT7HpaAL6OI7+YDSHZIkOjs
         GrTlGk56piJjioQYakLUNz/eEnezf0xbmUEWcGBm/e1fRp2TP4khOgw8PiveP9JC2dIh
         DEPDps3mlJ2swxYKQSJFf9/4IhebuEQSw7GEuqtiGXe8eKj/GLkynwc6o9+LrhNXjCrZ
         +hEaHhCPfXUbPDNVAneBmzSED4M9j6Sk4halN91yaVN9/UiE/gVD7VH+DvktjLmSFhRX
         LYKw==
X-Forwarded-Encrypted: i=1; AJvYcCVCawQStjLd7cS53wPBeGNp3Q/WcVTrY2aJvTmBvY7f6js4Zp+G17K8Wqeqd2mXiL0w5Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGs6avpLvGy6Lk2TTS+OmP2JIeh54gqA2zhXr1maBJs6XmwNpe
	f4vWnvHqa7BkmhK1w2ZXKkzL+tOu591dYuFZoaXOeQZEkj7Wqu+C9cYNoKExAl2+SSYzOvVjVZu
	aorFdivKDVOZTtstn2HV9CQFZvfn6jEo=
X-Gm-Gg: ASbGncvOlpHVpw2Rt0ZI7t70fJZZXL4NYjPAEY6Ut69X6WoL53KNIkdis22G0v1JLYJ
	UgguM9KUcTG/eXblnTXVd5LZtoi629jGKxFbGeLK4S/0y5NKduujDDarm0/XeFapnr39zIw1BIi
	cvudhVVUqRAxHiAD1k2/Waf8a85SHI14obfOLf5JH1aypu9LHJDVsnHK0pIkiGFZRQiuSuiRe6O
	0/5OffqWljFa4tusTyQ2Ho=
X-Google-Smtp-Source: AGHT+IEG2F90O4jGCD9OhAsIUJZKquX6SjgPjBb5qsXYOBHi3LwpOs3TOyZ1k0XgKp5v4Zp/8he+0fWLFVZqq0Nqbec=
X-Received: by 2002:a17:90a:bf0f:b0:32e:3830:65d5 with SMTP id
 98e67ed59e1d1-3342a3013e9mr3710317a91.36.1758840864151; Thu, 25 Sep 2025
 15:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
 <20250924211716.1287715-2-ihor.solodrai@linux.dev> <CAADnVQLvuubey0A0Fk=bzN-=JG2UUQHRqBijZpuvqMQ+xy4W4g@mail.gmail.com>
 <6a6403ec-166a-4d48-8bf5-f43ae1759e5f@linux.dev> <CAEf4BzbYXADoUge5C7zhzZAEDESE7YJFwW_jO4-F5L3j-bwPMw@mail.gmail.com>
 <CAADnVQL+28vPquMgw+hZMT1P6NkE5jLUXf=HDNj65N9np1rgfw@mail.gmail.com>
In-Reply-To: <CAADnVQL+28vPquMgw+hZMT1P6NkE5jLUXf=HDNj65N9np1rgfw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Sep 2025 15:54:08 -0700
X-Gm-Features: AS18NWAugdjCg0SYupnLaIvvV6KxFfvW1uIZoHwM0NWXVVuUpQNblEYuU1FUVkY
Message-ID: <CAEf4BzYm=dTqT=Aj-=Jg=n8AtcxZL1CiQiY5mVbUNA-pesz=sQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/6] bpf: implement KF_IMPLICIT_PROG_AUX_ARG flag
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	dwarves <dwarves@vger.kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Tejun Heo <tj@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 12:35=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Sep 25, 2025 at 6:23=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > I do see the benefit of having the generic "KF_MAGIC_ARG(s)" flag on
> > the kernel side of things and having access to full BTF information
> > for parameters to let verifier know what specific kind of magic
> > argument that kfunc has, though. So as an alternative, maybe we can
> > create both a kfunc definition *meant for BPF programs* (i.e., without
> > magic argument(s)), and then have a full original definition (produced
> > by pahole, it will need to understand KF_MAGIC_ARGS anyways) with full
> > type information *for internal BPF verifier needs*. I don't know
> > what's the best way to do that, maybe just a special ".magic" suffix,
> > just to let the verifier easily find that? On the kernel side, if
> > kfunc has BPF_MAGIC_ARGS kflag we just look up "my_fancy_kfunc.magic"
> > FUNC definition?
>
> Interesting idea. Maybe to simplify backward compat the pahole can
> emit two BTFs: kfunc_foo(args), kfunc_foo_impl(args, void *aux)
> into vmlinux BTF.
> bpftool will emit both in vmlinux.h and bpf side doesn't need to change.
> libbpf doesn't need to change either.
> The verifier would need a special check to resolve two kfunc BTFs
> name into one kallsym name, since both kfuncs is one actual function
> on the kernel.
> bpf_wq_set_callback_impl() definition doesn't change. Only:
> -BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
> +BTF_ID_FLAGS(func, bpf_wq_set_callback_impl, KF_PROG_ARG)
>
> and the verifier can check that the last arg is aux__prog when
> KF_PROG_ARG is specified.
>
> The runtime performance will be slightly better too, since
> no need for wrappers like:
>
> +__bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
> + int (callback_fn)(void *map, int *key, void *value),
> + unsigned int flags,
> + void *aux__prog)
> +{
> + return bpf_wq_set_callback(wq, callback_fn, flags, aux__prog);
> +}
>
> It's just one jmpl insn, but still.

So basically xxx_impl() will be a phantom function that verifier will
recognize and it will need to have corresponding xxx() kfunc with
corresponding KF_PROG_ARG for everything to work. Makes sense.

Two notes:

a) KF flag would need to be more generically named, because we'll have
other implicit arguments (like those for bpf_obj_new_impl, for
example), which will be distinguished based on their BTF type

b) bpf_stream_vprintk() throws a bit of a wrench into all this because
it doesn't follow _impl naming convention. Any suggestions on how to
deal with that?

