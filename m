Return-Path: <bpf+bounces-21808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAF5852423
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 01:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9421F1C2360B
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 00:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874431A708;
	Tue, 13 Feb 2024 00:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Pmv1oR6n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2206018E2A
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 00:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783698; cv=none; b=bTzRzke6bA/e4gHB5oQXXC2DaN/loIx3+WJC4O5QwnGiyBIcAb+aqSFeb4wL1RZOZPqD7ipfJl+JA1nNejsV/feweSJKSuXgUHQU8bSFHzpaAr7qDBv8oYF9ritB6MWfpyyfgNLmrp6C9rThvOtG+vqBgwUfbroytayZdwu0Ius=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783698; c=relaxed/simple;
	bh=rh0UxxbBVBUyyD90T+UF8BJUlEJhOYFEDsSr4zo70oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9YZBMBBAvQB155tfWXoQjwizs6ANAsTVt38/l0UmtM0oXvZyENpqXoBNpec9mPBIV4olPH6NnS0osMDJ/UXCKN7yvMHykrO3aWwV6riAa3EjvVKEE6Xh7zJVftmSejVfUMVb7spg3GXjrI5/fkrMmi1S13WQ2hk5HrEvIAgGq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Pmv1oR6n; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so492174266b.1
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 16:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1707783694; x=1708388494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmL2zU7mW9Y73DqyMWVGJGln68TLxpNlFJd19NRm+5w=;
        b=Pmv1oR6n7eu4pj0hyUqj4+zCD/3d1v4ntzn3gSUZBsqc6jvZBl7MXFsuLW8QvgQEMB
         pKo83wkZNG86APMnpcSzhRMV0OWbwLbM14JX4DsxPChzI0li5hS9TC23tO1CHHpEpn2l
         5cJ2pFy8tko6XPr9HRKcoCgIo+ehrvEL6qV+0erPbt5q1Tta4jJkm9FWm8VKwF1nrcrs
         grmKZ/bms85yEVLD5DvKme2HjHjdmuuPlSOlPLpF+ut82DmoO8XVsYFvCy18M4Rh3kAN
         qjAeOn2BW/wPqKGMnIa9A2cjykA2Mv+a89RtcU+IjioB1D63o6DJgI3MQ/JX0bjGJdsA
         z4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707783694; x=1708388494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmL2zU7mW9Y73DqyMWVGJGln68TLxpNlFJd19NRm+5w=;
        b=JWUu/+HT+BVVzSBAz0W3jXjispPXUU8fjdficEmdd/51jKt5jHXUeo5YtCDODKTIDi
         gXSiacdp1SvaZJkXiMpP4qD/JyB3EV3fe5rdwtHqTT8bPp8BO06v1b2ZqmzdDY8IQ1m3
         0yLqqzFY4iZx3erQL8gfx+n8KlUhNawKvSU47J7t0pTmdSYBjar+utLDhrHSadyfYkuD
         dZRVX6WFdrKaGc+yhMLdOSHGPGAmqQJ+wdp4EzdIYKrGY72zG6T/UrPxgAFJU2sFQ7DZ
         usxlc1qp5aQg3IvMIUfeMVMIqUigj08qzBCyY3DDBHt/VqHJcH53TQd/ZqPBJ4co2RYb
         tEbw==
X-Forwarded-Encrypted: i=1; AJvYcCXVYCR0j6Rt+EMIfIdM8RGhYNWH5N5yzP5yB/abv0TrwiHmIuqW8GGiZwf+BtmEsjqRQFLkI/NcwEpCqY6bMsqTNgL8
X-Gm-Message-State: AOJu0YzreqJGIp8Kue1FYCkrSZ1ItEQJVzKLZUS80U2EqIx2Zt6XM+UZ
	sbuIuPVgtBcQKs4Z88nkIadLMcElPqkgwp8JXWWXgqslt+Qxzf5jLFKkLgkk1+PELkC/RxiIZAf
	9rfsukrl0R05ZGRCLE9PXUsck3RJXAODBgWxCJA==
X-Google-Smtp-Source: AGHT+IGM0802PPiDaGCd7edF3NWUTHews6yAA5/2k6RuYM81nyDfpss583gRs6Xviz8HX+uLeoJzt3NDkgjNV/k9FY4=
X-Received: by 2002:a17:906:3c5a:b0:a3c:f8df:970c with SMTP id
 i26-20020a1709063c5a00b00a3cf8df970cmr261325ejg.0.1707783694298; Mon, 12 Feb
 2024 16:21:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZcqYNrktYhHFTtzH@debian.debian> <CAP01T74dQAt1UUGkUazx17XAj7k3LCMvw8Y+_rKzwH8eUao75g@mail.gmail.com>
 <CALrw=nGU-gBihe-08rJaxdwpRPQLBPLEQn5q+aBwzLKZ4Go+JQ@mail.gmail.com>
 <CAADnVQ+EL71GN6z3RnSBX5jfCmD9f5T9WN=sr_k+JmZzOOLqPg@mail.gmail.com>
 <CAP01T74t_w0sDaDV5zf3RsZNQg0Hz1XEYw2myOML0L=6afCjsg@mail.gmail.com> <CAADnVQLgC8wc5v8sSt=ZxAqLhwoPWXcwwLpSQwKAgaWvuuhF_g@mail.gmail.com>
In-Reply-To: <CAADnVQLgC8wc5v8sSt=ZxAqLhwoPWXcwwLpSQwKAgaWvuuhF_g@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Mon, 12 Feb 2024 18:21:23 -0600
Message-ID: <CAO3-Pbp2idpgEcf7ynvx_ucoDXKPVupWctMk1nZ0i_3zPoOTEw@mail.gmail.com>
Subject: Re: Page faults in tracepoint caused by aliased pointer
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Ignat Korchagin <ignat@cloudflare.com>, bpf <bpf@vger.kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 5:52=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Feb 12, 2024 at 3:42=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Tue, 13 Feb 2024 at 00:34, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Feb 12, 2024 at 3:16=E2=80=AFPM Ignat Korchagin <ignat@cloudf=
lare.com> wrote:
> > > >
> > > > [288931.217143][T109754] CPU: 4 PID: 109754 Comm: bpftrace Not tain=
ted
> > > > 6.6.16+ #10
> > >
> > > ...
> > > > [288931.217143][T109754]  ? copy_from_kernel_nofault+0x1d/0xe0
> > > > [288931.217143][T109754]  bpf_probe_read_compat+0x6a/0x90
> > > >
> > > > And Jakub CCed here did it for 6.8.0-rc2+
> > >
> > > I suspect something is broken in your kernels.
> > > Above is doing generic copy_from_kernel_nofault(),
> > > so one should be able to crash the kernel without any bpf.
> > >
> > > We have this in selftests/bpf:
> > > __weak noinline struct file *bpf_testmod_return_ptr(int arg)
> > > {
> > >         static struct file f =3D {};
> > >
> > >         switch (arg) {
> > >         case 1: return (void *)EINVAL;          /* user addr */
> > >         case 2: return (void *)0xcafe4a11;      /* user addr */
> > >         case 3: return (void *)-EINVAL;         /* canonical, but inv=
alid */
> > >         case 4: return (void *)(1ull << 60);    /* non-canonical and =
invalid */
> > >         case 5: return (void *)~(1ull << 30);   /* trigger extable */
> > >         case 6: return &f;                      /* valid addr */
> > >         case 7: return (void *)((long)&f | 1);  /* kernel tricks */
> > >         default: return NULL;
> > >         }
> > > }
> > > where we check that extables setup by JIT for bpf progs are working c=
orrectly.
> > > You should see the kernel crashing when you just run bpf selftests.
> >
> > I agree, this appears unrelated to BPF since it is happening when
> > using copy_from_kernel_nofault (which should be jumping to the Efault
> > label instead of the oops), but I think it's not specific to some
> > custom kernel. I can reproduce it on my dev machine on top of bpf-next
> > as well, and another machine with Ubuntu's generic 6.5 kernel for
> > 24.04. And I think Ignat tried it on the mainline 6.8-rc2 as well.
>
copy_from_kernel_nofault is called in Jakub's reproducer, but the
panic case in our production seems to be direct memory accessing
according to bpftool dumped jited code. Will faults from such
instructions also be caught correctly?

Yan

> Then it must be vsyscall address that this series are fixing:
> https://patchwork.kernel.org/project/netdevbpf/patch/20240202103935.31540=
11-3-houtao@huaweicloud.com/
>
> We're still waiting on x86 maintainers to ack them.

