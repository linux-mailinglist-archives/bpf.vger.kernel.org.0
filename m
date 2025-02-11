Return-Path: <bpf+bounces-51076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA942A2FEED
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 01:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5D918891AF
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 00:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B8011CBA;
	Tue, 11 Feb 2025 00:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FujE22I1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B55264617
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 00:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739232957; cv=none; b=k+KyIbPoOwis/v+EukApGgUroqbAGt+p/8OU7bLYxtFzcUpOUxOw+QqoSJeOSF8eFKXEj6nOwJC+cULIfAITQe+MRSD6iyX+HIDZURzmoKRdf7Q0NY6rNxBcbA1uH+JyYVbVjGVmINuJYgTNJseuoRWVSRy+Jbz2pvQru2C78rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739232957; c=relaxed/simple;
	bh=T0X+BaSLWNU9L2mXHAH7CXqI2HDO4iZfT8nsxFzJ6JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oX5JITJ8hq3yRklUmdLq/zkcllca5LOGlbZcx54fqEiHhzXBaHk8YaYC88DAHl7dxwE0kU7hF63AsXb6nlEuR5cdgqlmsRp0Zj+TUrDmhr73A2jS98MAsZRPI8xu0Hq4tObyfESVtTT5qz4OdGfnc4rFR53WNb2fIY4yuwdubEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FujE22I1; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaecf50578eso984093566b.2
        for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 16:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739232954; x=1739837754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1+wKBVGAaGDcdNdECIFBcLyPokk92FR1wp5+VoJHzg=;
        b=FujE22I17v+VzCzOMLj19+UcS1XF1hOqkIJPtrBL2aSidTlc3QHWOKd3OL93BqWtDw
         7ILHdGkL5sMdq12WOVA7W1P1xmsOMfTKJgeyorN5+AgQRWXBEZANYSZJJq3RJQ9ubQG6
         yxuAqDFC/kjW8d5qfDYN+AiaAuxaJKob+g0qT5A0eWOP0fIm2YBMtnCb0WY2F1d0vTKJ
         dAa7C4TeCIz3JN6d0EijOTpKV2Dq+Ed3Gj/XBz5bTYh5hob9zBl2JL+5660vcOYqELXP
         ZUa2qfue/nC06JLHGMrG2o3duOT8dZtUBUQkkXhRxkxpfNBG+FYhpj1KyFTBpQejz/jH
         MOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739232954; x=1739837754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1+wKBVGAaGDcdNdECIFBcLyPokk92FR1wp5+VoJHzg=;
        b=DdphgfyZIm5P6d6jyCQRXvXz7BjyhCCS/MioO/O5X6Fds9AbzmxHNOUbirUi4m7zLr
         KaUtsppoOf6sIrGzCRFnhi8UwlM/JCbg2q8tKDAVima0XepCdOPSocRRBPhhzJc2M/3M
         M+PEYjx0xLE9dwNikHs/x03Pe/sGuhyfHy+PFEioB5ehsZH2X0ryad42Jod3QRhs5T7W
         tx3VeEICt5gVyPbZ+3sURZcpmt+ssBSzKS22xn/Yd7866tQyGpM01IWunOFnLphm5i5k
         1NZmARwsbJ1cJ8XTxjXoOlAoJkwvBoqfFV8Z7XCiJHY6NGeCkLcIycbWtStDjLvGsrn7
         04Rg==
X-Gm-Message-State: AOJu0YzlxH6+uF2Zc4AYU5FPVWseZHYcyIm8Eelmr43NX9zW+NdJoMqr
	LpnGLocJXCP583HOjMOn0U8+D3JygfIyZ7T1sSpu3vSs4Q20Gq0vmSjtA1Cd1OSihdkueZTBrOy
	DXtQkV60knv5bayVpipLFJ9Rja0o=
X-Gm-Gg: ASbGnctcIx2UKi+dzO+MDDiCA0KzN084uZSlIVTDI2q/0V3Yajra+FrjNBaeEFhHlED
	R2iC7a0lGdBKzf/M44gwDGyB0LukTWPzq3hb3bfUJm1+Z4YzOQMH9gw8ZtAyyHF63oe1NSXTPYM
	0NCfVumIOivRj+
X-Google-Smtp-Source: AGHT+IFZYTm9YdbJ0VykginTR6KHKGfzNO0jo1utcgRAJ7bewdckwLMQaEky+ASspdPmMxxSM5U8fe67wcBrbCuFUck=
X-Received: by 2002:a17:906:7949:b0:ab7:b5f2:ba86 with SMTP id
 a640c23a62f3a-ab7b5f2baf1mr806202866b.29.1739232953424; Mon, 10 Feb 2025
 16:15:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127162158.84906-1-leon.hwang@linux.dev> <20250127162158.84906-5-leon.hwang@linux.dev>
 <CAEf4BzYXCQi4HMvegMmsx-ppxprwNVyKohJgka8gY_B+gMy+mQ@mail.gmail.com>
 <8e25e1e9-37a0-4d4c-8af9-c2d5e12af65f@linux.dev> <CAEf4BzYeKcaYH8ZYpMo0XRyS4UYWaSZB5bMJ6FK0pUX1SUmgqg@mail.gmail.com>
 <cab242ad-a557-430f-a466-7816811aea5e@linux.dev>
In-Reply-To: <cab242ad-a557-430f-a466-7816811aea5e@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 10 Feb 2025 16:15:29 -0800
X-Gm-Features: AWEUYZkcG0u-UyIpLB10UJk4KDQt1T8QeoKgYFjx9551bMTZ2mUS1-oG7cGvR3A
Message-ID: <CAEf4BzanEFT8fq2iRp0C4E3dqXue3hZ2YHGxvLMo0RAi07V1rA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Add a case to test global
 percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, qmo@kernel.org, dxu@dxuuu.xyz, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 1:52=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 8/2/25 03:48, Andrii Nakryiko wrote:
> > On Fri, Feb 7, 2025 at 2:00=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev=
> wrote:
> >>
> >>
> >>
> >> On 6/2/25 08:09, Andrii Nakryiko wrote:
> >>> On Mon, Jan 27, 2025 at 8:22=E2=80=AFAM Leon Hwang <leon.hwang@linux.=
dev> wrote:
> >>>>
>
> [...]
>
> >>>> +void test_global_percpu_data_init(void)
> >>>> +{
> >>>> +       struct test_global_percpu_data *skel =3D NULL;
> >>>> +       u64 *percpu_data =3D NULL;
> >>>
> >>> there is that test_global_percpu_data__percpu type you are declaring
> >>> in the BPF skeleton, right? We should try using it here.
> >>>
> >>
> >> No. bpftool does not generate test_global_percpu_data__percpu. The
> >> struct for global variables is embedded into skeleton struct.
> >>
> >> Should we generate type for global variables?
> >
> > we already have custom skeleton-specific type for .data, .rodata,
> > .bss, so we should provide one for .percpu as well, yes
> >
>
> Yes, I've generated it. But it should not add '__aligned(8)' to it. Or
> bpf_map__set_initial_value() will fails because the aligned size is
> different from the actual spec's value size.
>
> If the actual value size is not __aligned(8), how should we lookup
> element from percpu_array map?

for .percpu libbpf can ensure that map is created with correct value
size that matches __aligned(8) size? It's an error-prone corner case
to non-multiple-of-8 size anyways (for per-CPU data), so just prevent
the issue altogether?...

>
> The doc[0] does not provide a good practice for this case.
>
> [0] https://docs.kernel.org/bpf/map_array.html#bpf-map-type-percpu-array
>
> >>
> >>> And for that array access, we should make sure that it's __aligned(8)=
,
> >>> so indexing by CPU index works correctly.
> >>>
> >>
> >> Ack.
> >>
> >>> Also, you define per-CPU variable as int, but here it is u64, what's
> >>> up with that?
> >>>
> >>
> >> Like __aligned(8), it's to make sure 8-bytes aligned. It's better to u=
se
> >> __aligned(8).
> >
> > It's hacky, and it won't work correctly on big-endian architectures.
> > But you shouldn't need that if we have a struct representing this
> > .percpu memory image. Just make sure that struct has 8 byte alignment
> > (from bpftool side during skeleton generation, probably).
> >
> > [...]
> >
> >>> at least one of BPF programs (don't remember which one, could be
> >>> raw_tp) supports specifying CPU index to run on, it would be nice to
> >>> loop over CPUs, triggering BPF program on each one and filling per-CP=
U
> >>> variable with current CPU index. Then we can check that all per-CPU
> >>> values have expected values.
> >>>
> >>
> >> Do you mean prog_tests/perf_buffer.c::trigger_on_cpu()?
> >>
> >
> > No, look at `cpu` field of `struct bpf_test_run_opts`. We should have
> > a selftest using it, so you can work backwards from that.
> >
>
> By referencing raw_tp, which uses `opts.cpu`, if use it to test global
> percpu data, it will fail to test on non-zero CPU, because
> bpf_prog_test_run_skb() disallows setting `opts.cpu`.
>
> Then, when `setaffinity` like perf_buffer.c::trigger_on_cpu(), it's OK
> to run the adding selftests on all CPUs.
>
> So, should I use `setaffinity` or change the bpf prog type from tc to
> raw_tp to use `opts.cpu`?

Is it a problem to use raw_tp (we do it a lot)? If not, I'd go with
raw_tp and opts.cpu.

>
> Thanks,
> Leon
>

