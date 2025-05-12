Return-Path: <bpf+bounces-58057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECF1AB46B1
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 23:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD114A0944
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 21:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105392980C9;
	Mon, 12 May 2025 21:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFM9G6U4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2984290BC2
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 21:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747086617; cv=none; b=U4gz485OcVHzOrWVEZ8Ux6vUa5LEbQOXK6aCn7C2JafEw0axTJYb5Eabb1LpUpvy8tl4ILa2vMMK7kdpgRUOtHGkIkwDv37cUYQPs3g65FkBmLct/58JueneLB/5UmsezHjBZ+qN/VpFujzFfBw/IhN1huOPZECmajQmfPVMsao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747086617; c=relaxed/simple;
	bh=KA8FtGRsL00t8SpNNHBl3bTK8gD+QzJEBgV/vLiaimI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAa7qhQbTYw9/L2c7CDRgAko2IHmNBUkyHhUBN2mhsit0wiwxqUigHhMstu0lWWv1TYagFgTefwPRIV2jZ7Iix0ypj2BqZP5Ybjl90hok8C9K6Bfyv6XY3HfTg8MlRQLlZQQNTD3yXgqHBcRYX8bXdTPPystcGSMqYjyHSGykhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFM9G6U4; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a0be50048eso3731513f8f.0
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 14:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747086614; x=1747691414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qs7s18wtl0F/SF04ytrkvtksWDs/zYtDSA185Gi5zSg=;
        b=AFM9G6U4zbnC/S75lyKcpANf9X0cW0p3psHrWl5rBQQ6893EgHxYV+wcahd1rAi4h8
         0yHlToFfj0KnRarTDkw7mSakqOTIcDB8sruqtc18pXI0hYk2waOhKLBjD1GAmP8J/OyP
         s99dTopJhGEEPfP+8adn7WIyk6K79E6Eu8lPw5lDVgT2f9iQ/4t81R+YZuB49rwFwDLv
         Bar6aE+NWMDc6AX8Oe6IWfoAUuhgcTRzIiu3wwngBmR9Cn7IZQ4dTudSEjKWf1xdsYlT
         xuX1K/KPo+59k4aWAR58k6BmG5Kn/bRsKpHgSbhq1MW1Tjly5LoZnaxBzLV42wJIOBmi
         BokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747086614; x=1747691414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qs7s18wtl0F/SF04ytrkvtksWDs/zYtDSA185Gi5zSg=;
        b=UhS5PP5MIx9U9ykv+AU3qPbCLS+Oc0AsGFKZqpYJoXErYn1c9wm7EvsacUzfnbl57C
         jC4Wko6bshnxp8KPzlKrPu7Zsrp5/eECHjt+Nx6tN3MgV30qWHQmj5hjpLASRYZQee9M
         q9uaAQN0MPQGAH4Q4qe/1h8fgWJDTCVa+K2QYRcvhC3Y7I8UhrdBV+F/aJlqKtGK7sD1
         VBhIVYSJlq9+sImcfNf6ul8laBLKsAz2P+zecwgxATrOXpoooQMuj/E06p2CL0GWDm3m
         vdttMFNuCrNs7GH4FV+W/Qs+0UiMOa9g9AHN7Ob9t8Ovck/0j5rsaa7SpSeZwnx1OuOc
         QuyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVGuBdooWgprHTYvruIFAthQaHeCIVJEpXA9cegccdHIoxUvkUxp8zqhpwKvy7Av7+qwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkD8Lmz3D7WuDD4k7toCqf3G3PDf5RFHW43ZaeBge16PukM62e
	1JrWHfuMJ/pghSky8OY6UI5oqsr5xuCnULc6Kf6vBvOmqEQIu4F8pmWDuMPnkkp1zOKt/MADkTs
	PtyNpItbe1lHiiPbcfVstRp0Bdyw=
X-Gm-Gg: ASbGnct62JOgiHmrT7A7sxlqt3TgoOV9H4qOdb2i1qP1Zfthf9sPTMdZ9mBGw+zS5n9
	J4DjDvOEwLofjzBnomNxFhXUEmlvDysKNikUnCggYHQvGT5yY2GZktFuqCqjq5yNH/4e5r/RjeV
	PNAVCzOGTEtzA/HW+1qJJO0g7/G/ZFLqQW46zT23636cYNNreIN3VtQ3q1D8P9og==
X-Google-Smtp-Source: AGHT+IE8sc/yeGt8r03kgJTgnXTCmEo5kNIrme6jasKKxWncGooL6urMh1jO3KjtYsJKzw3tg/5702oQl8Nk/mcOk0E=
X-Received: by 2002:a05:6000:4205:b0:39f:9f:a177 with SMTP id
 ffacd0b85a97d-3a1f64339e9mr12029483f8f.17.1747086613879; Mon, 12 May 2025
 14:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507171720.1958296-1-memxor@gmail.com> <20250507171720.1958296-11-memxor@gmail.com>
 <04332abfa1e08376c10c2830373638d545fba180.camel@gmail.com>
 <CAADnVQKN2S=yb_7NUO8bsu+7CxnaGyTML6gKcPS61EnCZtvG5g@mail.gmail.com>
 <9f417b403ef541af5bc8497897e4fbf88bd4023f.camel@gmail.com>
 <CAADnVQLOjzmhf1d81Nr9n0zXL1hj7CGeG5_8BySuNY0HxYanSg@mail.gmail.com>
 <CAEf4BzanV6=_HHVVNxC1Vfsg6R7XYPxsCdEqVXsyBvA4zrGzbw@mail.gmail.com> <CAP01T75+6RsdyWXEQNcvPrZnZmH_Ykga5Km4hOgQShVgS2-rLQ@mail.gmail.com>
In-Reply-To: <CAP01T75+6RsdyWXEQNcvPrZnZmH_Ykga5Km4hOgQShVgS2-rLQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 May 2025 14:50:02 -0700
X-Gm-Features: AX0GCFtfKqgmmTRip2fYnghDN_MG-7KrEwh9mXZvaubMu9xiZAWDbZdimfZVIhs
Message-ID: <CAADnVQKgtcxQbt_Gbz=oHCa7B3u68Kw2QcFbeE--8whG=KfY1Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 10/11] bpftool: Add support for dumping streams
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 1:51=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 9 May 2025 at 17:33, Andrii Nakryiko <andrii.nakryiko@gmail.com> =
wrote:
> >
> > On Fri, May 9, 2025 at 11:48=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, May 9, 2025 at 11:31=E2=80=AFAM Eduard Zingerman <eddyz87@gma=
il.com> wrote:
> > > >
> > > > On Fri, 2025-05-09 at 10:31 -0700, Alexei Starovoitov wrote:
> > > >
> > > > [...]
> > > >
> > > > > How about we extend BPF_OBJ_GET_INFO_BY_FD to return stream data?
> > > > > Or add a new command ?
> > > >
> > > > You mean like this:
> > > >
> > > > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/li=
nux/bpf.h
> > > > index 71d5ac83cf5d..25ac28d11af5 100644
> > > > --- a/tools/include/uapi/linux/bpf.h
> > > > +++ b/tools/include/uapi/linux/bpf.h
> > > > @@ -6610,6 +6610,10 @@ struct bpf_prog_info {
> > > >         __u32 verified_insns;
> > > >         __u32 attach_btf_obj_id;
> > > >         __u32 attach_btf_id;
> > > > +       __u32 stdout_len; /* length of the buffer passed in 'stdout=
' */
> > > > +       __u32 stderr_len; /* length of the buffer passed in 'stderr=
' */
> > > > +       __aligned_u64 stdout;
> > > > +       __aligned_u64 stderr;
> > > >  } __attribute__((aligned(8)));
> > > >
> > > > And return -EAGAIN if there is more data to read?
> > >
> > > Exactly.
> > > The only concern that all other __aligned_u64 will probably be zero,
> > > but kernel will still fill in all other non-pointer fields and
> > > that information will be re-populated again and again,
> > > so new command might be cleaner.
> >
> > +1, but I'd allow reading only either stdout or stderr per each
> > command invocation to keep things simple API-wise (e.g., which stream
> > got EAGAIN, if you asked for both?) I haven't read carefully enough to
> > know if we'll allow creating custom streams beyond stderr/stdout, but
> > this would scale to that more naturally as well.
> >
>
> What's your preference/concerns re: pseudo files in sysfs?
> That does seem like it would be simplest for someone using this
> (read() on a file vs special BPF syscall).

sysfs is abi.
If we start creating directories:
/sys/kernel/bpf/<prog_id>/stdout
it will be permanent.

Though I'd like to see it, I feel we're not quite ready
to cross that bridge.

Let's add a new sys_bpf command for now,
some trivial helper function in libbpf,
and corresponding bpftool support.

