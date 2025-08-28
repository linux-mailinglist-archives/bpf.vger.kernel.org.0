Return-Path: <bpf+bounces-66763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBBCB39032
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 02:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8AB17C2711
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 00:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5CD18A6C4;
	Thu, 28 Aug 2025 00:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QORTl2SG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C995B665
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 00:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341771; cv=none; b=TqgrsxaCAQcqkKei/KIFv+53ATsZFBM+aL8xBN1MXMKNr9wHMqSzUTVrIXblqJ7nTyF+sUw81rgFiJ9IXBOg4mEuJzF2xWpa5ZEz5COWRAA/V7dsDqZPvAncj3xa6D4OFOBiY2mUW4fEwrMMfn8bcYnSWStYvhWYrhCp6dY8CbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341771; c=relaxed/simple;
	bh=UqD4WJQh5+xx3wvRfZ8mkQjV8iffvT+n+TE/wMuc1Ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgIJoEY9ItLDhiGljNef2BiZCUlLfzY+zx+mzow2RNngrrMRFJqt0zbQJZPg6cFfaAZdFal7sEbDxhtXJOltvz4RLgNaJQXJghpM9qFWijxOoaQEzG9oSymWc32zcxd51LITvRrThtJDdm6Q1g4ZiA9+lDUFPoxaWs68QfQ5NqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QORTl2SG; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3cd59c5a953so287676f8f.0
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 17:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756341768; x=1756946568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqD4WJQh5+xx3wvRfZ8mkQjV8iffvT+n+TE/wMuc1Ys=;
        b=QORTl2SG2Qz1NRiVQkjtLHHPqz7IXI8pTA8ZjRompG+W0/+NlCPse2ifMYLoI2nswu
         uIgsWz4QM9WllmxSBHfnKxsWtfvRSLxgmCa8I09UDcpw9tZaWcRdTFn7yCFXQ58+CF0J
         tsiP0U0PRyJoXXKxxAblN7xJFb97zorjMe1wpShfcn8GnYs9/8P3CnOSkMAtwoi2yKH4
         p4B4YCortgQWbKxDKO6uSIQ/K2v+XOh99Q3Q2l4asxGcRexCcpKLPThHD1rEnQYPKv7u
         cfMlyuL3kd3O/MA+SoycE9ZijcRQF1TZZprezTUlxkhzjRELqfaeiPmwKwnMZZw72jOZ
         KAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756341768; x=1756946568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqD4WJQh5+xx3wvRfZ8mkQjV8iffvT+n+TE/wMuc1Ys=;
        b=T2gdwVQNoFlanJvMuBeEMc7+OjQQDFNlomeVCv1Cj5xYchMDajQsWovPU28Vomb9iK
         O2ErtKdHrV/9XnrPNuToWcg6QvODDmbzs58L6jbDYswznpt8q+ykDF3FiRAjWiKQNFk2
         Lrg2EFS+iMFH+Wz06AAnZzADG5SU5GpP3iPwscUDMqCt5EUJ2wmRFZFrkXJXG0Rh0jpe
         otBkdAQ2LqVJs6E66/2RhkIk/V9U98s+nkYNgvGe0HiWoO39sBIVdcd8uCkIFdNcnpOC
         LqtOMpI4psqg61cz49P+c9AEOKjNnpJ+vurhb1hdmH2plNtvyM2i284oGotgarDnWjBs
         SaSw==
X-Gm-Message-State: AOJu0YypThzOKF19fSP7uekb9Non5XAvUAJmdJhCynv/nzXeWltApN0v
	BD+S7VBeO77fte0NF/HTak9VuqVeqrWhTFIIzZME8IsSemx+rp00eSOE4tEoWK+KiK3dCPRYOO5
	uw2tqh8HQUkHrVWqVTCi422xCUVmY2PI=
X-Gm-Gg: ASbGncvtY1ccU8kparBCwR7NwrnrbI2l+Mu7ZX6RRm5iEkpKCuoHD80WDFE1d8Z4bKK
	P6Omw6gRWKNatHpYAcnXF0hVMxLb9pQZOVpWx2zVXuPtDSN6shUvqs8q1AyxR+FYaYzduLQ4Be8
	xHg1JQqk5tcgNFri3db/uwFqJ9bPLo9RcU7lwsWfh0RM6oIF1jTfl7/r4tF8BTXeko22zpwi+EW
	V/k9UQ+hefmLIR0fXGj2RO8sr84/CUZeams
X-Google-Smtp-Source: AGHT+IHAg5iDBo6vVFgBTl3aI5t3Hcr+IPPNDUeE71mGYhMmn0cBH9SYaRWwRfsG691/rzMMpNv2202AsuisMmZtFJ8=
X-Received: by 2002:a5d:5887:0:b0:3b7:78c8:9392 with SMTP id
 ffacd0b85a97d-3c5daa2b898mr14652805f8f.19.1756341767724; Wed, 27 Aug 2025
 17:42:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a08c7c19-1831-481f-9160-0583d850347a@linux.dev>
 <CAADnVQJz9ekB_LjSjRzJLmM_fvdCbeA+pFY20xviJ-qgwFtXWw@mail.gmail.com> <8dcc144e-3142-4e0d-a852-155781e41eb4@linux.dev>
In-Reply-To: <8dcc144e-3142-4e0d-a852-155781e41eb4@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Aug 2025 17:42:36 -0700
X-Gm-Features: Ac12FXw7szaFmExqtpzlR4gh0wuAJiO8ANFBmbxVfjEfz5XhzhDEtWxqwNaluyc
Message-ID: <CAADnVQLDG=Oavh9He=ivXm9MPwsqWHttbTYQh1-EZuHpwujaBA@mail.gmail.com>
Subject: Re: [BUG] Deadlock triggered by bpfsnoop funcgraph feature
To: Leon Hwang <leon.hwang@linux.dev>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 7:58=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 27/8/25 10:23, Alexei Starovoitov wrote:
> > On Tue, Aug 26, 2025 at 7:13=E2=80=AFPM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> Hi,
> >>
> >> I=E2=80=99ve encountered a reproducible deadlock while developing the =
funcgraph
> >> feature for bpfsnoop [0].
> >
> > debug it pls.
>
> It=E2=80=99s quite difficult for me. I=E2=80=99ve tried debugging it but =
didn=E2=80=99t succeed.
>
> > Sounds like you're implying that the root cause is in bpf,
> > but why do you think so?
> >
> > You're attaching to things that shouldn't be attached to.
> > Like rcu_lockdep_current_cpu_online()
> > so effectively you're recursing in that lockdep code.
> > See big lock there. It will dead lock for sure.
>
> If a function that acquires a lock can be traced by a tracing program,
> bpfsnoop=E2=80=99s funcgraph will attempt to trace it as well. In such ca=
ses, a
> deadlock is highly likely to occur.
>
> With bpfsnoop I try my best to avoid such deadlock issues. But what
> about other bpf tracing tools? If they don=E2=80=99t handle this properly=
, the
> kernel is very likely to crash.

bpf infra is trying hard not to crash it, but debug kernel is a different
category. rcu_read_lock_held() doesn't exist in production kernels.
You can propose adding "notrace" for it, but in general that doesn't scale.
Same with rcu_lockdep_current_cpu_online().
It probably deserves "notrace" too.

