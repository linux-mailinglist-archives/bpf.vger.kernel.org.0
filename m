Return-Path: <bpf+bounces-60961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E7CADF21C
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 18:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8032E17F46A
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E29A2EB5A3;
	Wed, 18 Jun 2025 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFJMJjww"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BA216EB42
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750262512; cv=none; b=qnbXIA0GuK03RxDrSrCyPvlWzhLCKpei/or+giXdC8gD/KdRU+lDyhjHbEYLKw9rhOY5F1pcH9rscABcP5ErVETgfBZfk8AaWtNppAp+EQmCe7x1fBC5r5axWoFkROG+G1eFyAjVcp5cRgzkjyg3hEgHM7GuofTwr9YettoLe0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750262512; c=relaxed/simple;
	bh=Zcd3ar7/AAphIeSTv4j4akGFlZa39ZKvxyzLGtQm8Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uU1bwSau64x6RXZ3kqycktN1Sc4hILRILTB/Wv6kq2uNJEO15X5Vsa8xwovTvGo1ShYKMAzMWus9Pqfa7Y9WuNAmdpCelDZk94oRgkOH5uWOQOAHuekf5bxq1iCoEsfTBKfIse1ZE1P7PsmsacLNte3md0d+OdiL3yVmS983O4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFJMJjww; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a588da60dfso1605091f8f.1
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 09:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750262509; x=1750867309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIHL7KmUeSrCqJJfzMfR1PenJsRrLN15ljNj9tpNMR8=;
        b=LFJMJjwwsoUY//nUBE8YDqSiyNOPOqLWz8522U5mVO075ug2ALmhskRSD9oXbTYmri
         RE+V56NSYUr6W5AUm6nipOo/sQ0uQdm+CJEzo8+pDLzVmnheLrD4C0Z51FwUIh5aV6Rq
         iAMs+jaaMIyMgKRNW5QgY31EOxzm96xLZ83hH3Vaj6+s8HLkBQUzvxoCIywdI8AAydrX
         CLhXi4GHAt+54cJhmzvlPOgEpej4WmFvLfLe5GunF9iwYzyOqN4gyTGhLvQh3xhxY9CC
         jHKEeozpUz8E6Su+HtJ1DsXC4QM4lupPQdiGpHpIkrbVo/ytkfkEzvnYXnkZC+Gne9hV
         XeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750262509; x=1750867309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIHL7KmUeSrCqJJfzMfR1PenJsRrLN15ljNj9tpNMR8=;
        b=inDaYPHT6i2KmOcc/qDtEacwyEi27fyKd4Gy3iky0lDE/Tsq0Lb+9gvkl25nwE0hpi
         sW9C4WjqpOZPodMSU8bXf2cFN1zUOvnPu84WbyEXu/CjkpigsnzSNe1/jAgJ+n31rL/G
         vhbtzkqWzqnPKgR9jl4dIkA3iV0rZT15wXy2rh1fLhUKHmcrD9M3XX9RXguEM0siWnK9
         Oh3emzQrkvBmRKhnxwE/lUVon/TrmcvnpEIb1LpY9g34vMkxx83GS6yoZR9XYRRg4tzt
         ozG1y1eh7diLFv9qPnVe7Y/G49LHfT/fMuWEGNPkzP5P6+YmXPAyLvePSPL6laqqymnB
         /bzg==
X-Gm-Message-State: AOJu0Yy9A+qikdZTgRNGloE2HuVP0W8Q89ASKLtExnJIXvbjjUnNEhPE
	fsYO9JLZy5tfMLWVwdeBcePG0J5trvp2Uj1agtG+qquCUdB8I0My9P0rv6wWIs/oIBnPOnKb1gA
	GALy7q3UCyTmYhivPlZFJuFv2uot8XQQ=
X-Gm-Gg: ASbGncs1w13/VBELusbxuolWrmcURyWfzrNrRlb5bgq/+6LU8xAkINSBk5wj90yX/CH
	vI3zMmAOeEaNOxQw+ZgSNlINkbk0CGhHd6v6P42xxdTtMF0HNPYgCWHLV1fdzYNibSMbyyB6cqm
	4jIX9xnYxdE4Pc/olZAn1e+SjJ0vl8bWn0J9dE5hRXvAOETtA9L9R/KYzouT0c4zthlluup07U
X-Google-Smtp-Source: AGHT+IFGyAkEgswW6QH1SbB7r3UtgAa8TSWr0dYw0DkBAaYc427+ySp9OD/t/6yKpW8bT01A2hN43txLxOtbAuhZ6RM=
X-Received: by 2002:a05:6000:2881:b0:3a4:f936:7882 with SMTP id
 ffacd0b85a97d-3a572e9df1emr13664546f8f.55.1750262507361; Wed, 18 Jun 2025
 09:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-10-a.s.protopopov@gmail.com> <CAADnVQKPbBRGOj2mB5Um80VFUh_vVg=oRJCdYUgyz_DrObuagQ@mail.gmail.com>
 <aFLR7NrdX3gbjC1s@mail.gmail.com>
In-Reply-To: <aFLR7NrdX3gbjC1s@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Jun 2025 09:01:35 -0700
X-Gm-Features: Ac12FXxaT76RJYfBGa4DQVSiDGM09RhJlThDhzUgmp_WLbN4rjtxAEbOyrYn5PQ
Message-ID: <CAADnVQ+nHemrEgeWYHxLi1UVeJ2u7DtSDTpcrPR7w2PgFPgQZw@mail.gmail.com>
Subject: Re: [RFC bpf-next 9/9] selftests/bpf: add selftests for indirect jumps
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 7:43=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> On 25/06/17 08:24PM, Alexei Starovoitov wrote:
> > On Sun, Jun 15, 2025 at 1:55=E2=80=AFAM Anton Protopopov
> > <a.s.protopopov@gmail.com> wrote:
> > > +SEC("syscall")
> > > +int two_towers(struct simple_ctx *ctx)
> > > +{
> > > +       switch (ctx->x) {
> > >
> >
> > Not sure why you went with switch() statements everywhere.
> > Please add few tests with explicit indirect goto
> > like interpreter does: goto *jumptable[insn->code];
>
> This requires to patch libbpf a bit more, as some meta-info
> accompanying this instruction should be emitted, like LLVM does with
> jump_table_sizes. And this probably should be a different section,
> such that it doesn't conflict with LLVM/GCC. I thought to add this
> later, but will try to add to the next version.

Hmm. I'm not sure why llvm should handle explicit indirect goto
any different than the one generated from switch.
The generated bpf.o should be the same.

> > Remove all bpf_printk() too and get easy on names.
>
> The `bpf_printk` is there to emit some instructions which later will
> be replaced by the verifier with more instructions; this is to
> additionally test "instruction set" basic functionality
> (orig->xlated mapping). Do you think this selftest shouldn't have
> this?

None of the runnable tests should have bpf_printk() since
it spams the global trace pipe.
There are few tests that have printks, but they shouldn't be runnable.
It's load only.

> > i_am_a_little_tiny_foo() sounds funny today, but
> > it won't be funny at all tomorrow.
>
> Yeah, thanks, will rename it.

