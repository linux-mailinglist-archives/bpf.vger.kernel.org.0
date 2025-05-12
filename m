Return-Path: <bpf+bounces-58058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09693AB46DC
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 23:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1352A8C2C83
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 21:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1247299AB3;
	Mon, 12 May 2025 21:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHtcyChS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC13299AA5
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 21:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747087047; cv=none; b=FngtWVJWerBhW7B4U7/PEkYyOWcEGT7o3FIU6hzQWlSOFQEs4AR9D8fAG36KEc/eC0qyiDabP5AXQ/c/RXzSyhA3TaC2gz7zAWPvVlWzStk/dFDal31jxfO9gHr3wBNSNfLl0M/yihhShwNNx7YnFK76C7B3EHi/p23jMKQOFYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747087047; c=relaxed/simple;
	bh=B+PBg9bvAhBG0Y5Htj9/AXrvtHEGHNYSBmdDCrX0wp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsId3OEs8D6CVyzbQk3ha8R+48HKzc9Ic5M8JjaHMnm9wnjzknz66jke8uxizoKGoae7DdqHyLJbSt7JwzRLysod8k8VaMYPRB0VYLGN90WWAPcFbeXltbS0TmpyCgkttelOYcaLfhD3rPanqHbyzDsM7kAcYBkUgBbvCHEc1+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHtcyChS; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5fbee929e56so9420977a12.0
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 14:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747087044; x=1747691844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13CorzbF/orPLJXh/eGhnapGDz58xkpdHJjnXASJh5Y=;
        b=iHtcyChSSVRILGl1i8H7vBLzdWr9cJO9Hn9BZdgdEzlhwwuN9h/hkx5YeI0YNx65VS
         Fk0/mVAt31UiVXYbUyF8WhNvxyXTX/ad+Vuz0yfKp5y0QNz3f+Tjcdns19QWhgxBEhDH
         6X3fq8fNp8p0csn65Y+M4mz8OBJpeeBJw6q9GO5Y97TZ+HO+Zoib7Qq70VU3U8Uzh1dk
         TcnZrdr/nd14jtUQsiQgaeqq0/CM+ZWNB9JMHrZExFpisl8A+VXWYbItaNptH505N+vm
         drkrYsTzZvc47nQyqBebKvoeV9DkmkxM1ze0ATyDO2oV+ny9GDjaFd+xJ/Xj8NfbMX8D
         tO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747087044; x=1747691844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13CorzbF/orPLJXh/eGhnapGDz58xkpdHJjnXASJh5Y=;
        b=JZuxEeucwMGmCVIuY9ZbPiYEKFpRO3s1Ix8UZ5XjBuquNnmpT/i6V9IY+F60SRWjjA
         aEPKRY8t17NeIilgmdya/Dm/dthIqxopMcWlacukmoJ6HDK8ISHR1g0OhnAosemRDQj/
         FKvKR0oDK2Zl28FzA4j501omQyUfur28FtygT81pbaWS3T7WdsRGtdLvJ4GBiBSoso77
         Z2hm1DY8fjswgaDBgQ+TN5YDBopShvXjwH2x90sObuHodyrcHKz2J0uQdMpij0kdohIy
         QDabmTSnfwAInuBF558/Uk0gn58v4z4ymXFSIpNAcMDwPXbfMdZaAAREo1ziVeM5NkSa
         Pl8g==
X-Forwarded-Encrypted: i=1; AJvYcCXyw1ZQBF/LEq6GJGdqtjLAHJZz5dpIrp0SeIM7qtsg117SzSFPmy/dOkFFDuduT/LEZ5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPSqGQGQ5JV0GN6YqvZJLvYO6CWL7iB/JhrXBghvbOGH7N/R7c
	mjRA3xxGaLIywOfFg2zC+dUSPIybUNrQSGn/4W4y9QpsrPFDv2GiPAckdXEbltKw3b+D/dBgBOI
	aCAs+IotYOcpcpiQtHzsjug2aBMBbVXAIusjhyA==
X-Gm-Gg: ASbGncuu65dEeYUc5pDDATUs6LHIPiz0NMGXbHa1zutsdFdJHFARtb4uGaRDicDVkBD
	GS3nXx5KUTKy9bN00ZhBCmlUCdK0injPUUEB3BOJ4eBxlBD4J1QY5mCUwUvgpAWJAI3hJMLFRZz
	ZjWexsO0BWO8mrWGBPHQJbEeNhU6S1aSIRziE9LpxNQl8DOvbv
X-Google-Smtp-Source: AGHT+IFl1sRniOHXIxiV6Ao09C3meJBJIrjUTdxCjwB+0X2fZ0l2575iTBYJEvfFU3GY1WL/aCYi75a1Ahi6toUY5wI=
X-Received: by 2002:a17:907:3f97:b0:ad2:2b35:8fa5 with SMTP id
 a640c23a62f3a-ad22b359412mr1314676266b.28.1747087043609; Mon, 12 May 2025
 14:57:23 -0700 (PDT)
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
 <CAEf4BzanV6=_HHVVNxC1Vfsg6R7XYPxsCdEqVXsyBvA4zrGzbw@mail.gmail.com>
 <CAP01T75+6RsdyWXEQNcvPrZnZmH_Ykga5Km4hOgQShVgS2-rLQ@mail.gmail.com> <CAADnVQKgtcxQbt_Gbz=oHCa7B3u68Kw2QcFbeE--8whG=KfY1Q@mail.gmail.com>
In-Reply-To: <CAADnVQKgtcxQbt_Gbz=oHCa7B3u68Kw2QcFbeE--8whG=KfY1Q@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 12 May 2025 17:56:47 -0400
X-Gm-Features: AX0GCFu0OecdP6e1YPsoLPxJeZAb5OU5p2GQ378xcsxsGGKKXQ4QMnu_hyXOyO0
Message-ID: <CAP01T74qmZ4VwVoctX8yh62k=H=XvQfSNyDf_HEe8Ti6oS_MaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 10/11] bpftool: Add support for dumping streams
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 12 May 2025 at 17:50, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, May 12, 2025 at 1:51=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Fri, 9 May 2025 at 17:33, Andrii Nakryiko <andrii.nakryiko@gmail.com=
> wrote:
> > >
> > > On Fri, May 9, 2025 at 11:48=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Fri, May 9, 2025 at 11:31=E2=80=AFAM Eduard Zingerman <eddyz87@g=
mail.com> wrote:
> > > > >
> > > > > On Fri, 2025-05-09 at 10:31 -0700, Alexei Starovoitov wrote:
> > > > >
> > > > > [...]
> > > > >
> > > > > > How about we extend BPF_OBJ_GET_INFO_BY_FD to return stream dat=
a?
> > > > > > Or add a new command ?
> > > > >
> > > > > You mean like this:
> > > > >
> > > > > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/=
linux/bpf.h
> > > > > index 71d5ac83cf5d..25ac28d11af5 100644
> > > > > --- a/tools/include/uapi/linux/bpf.h
> > > > > +++ b/tools/include/uapi/linux/bpf.h
> > > > > @@ -6610,6 +6610,10 @@ struct bpf_prog_info {
> > > > >         __u32 verified_insns;
> > > > >         __u32 attach_btf_obj_id;
> > > > >         __u32 attach_btf_id;
> > > > > +       __u32 stdout_len; /* length of the buffer passed in 'stdo=
ut' */
> > > > > +       __u32 stderr_len; /* length of the buffer passed in 'stde=
rr' */
> > > > > +       __aligned_u64 stdout;
> > > > > +       __aligned_u64 stderr;
> > > > >  } __attribute__((aligned(8)));
> > > > >
> > > > > And return -EAGAIN if there is more data to read?
> > > >
> > > > Exactly.
> > > > The only concern that all other __aligned_u64 will probably be zero=
,
> > > > but kernel will still fill in all other non-pointer fields and
> > > > that information will be re-populated again and again,
> > > > so new command might be cleaner.
> > >
> > > +1, but I'd allow reading only either stdout or stderr per each
> > > command invocation to keep things simple API-wise (e.g., which stream
> > > got EAGAIN, if you asked for both?) I haven't read carefully enough t=
o
> > > know if we'll allow creating custom streams beyond stderr/stdout, but
> > > this would scale to that more naturally as well.
> > >
> >
> > What's your preference/concerns re: pseudo files in sysfs?
> > That does seem like it would be simplest for someone using this
> > (read() on a file vs special BPF syscall).
>
> sysfs is abi.
> If we start creating directories:
> /sys/kernel/bpf/<prog_id>/stdout
> it will be permanent.
>
> Though I'd like to see it, I feel we're not quite ready
> to cross that bridge.
>
> Let's add a new sys_bpf command for now,
> some trivial helper function in libbpf,
> and corresponding bpftool support.

Ok, but the new sys_bpf command is also ABI, no?
I'm fine with either, but it seems both will be permanent.
Only difference is visibility.

