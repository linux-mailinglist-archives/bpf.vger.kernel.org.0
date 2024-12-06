Return-Path: <bpf+bounces-46321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B341F9E78BA
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 20:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD611885E45
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 19:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5051D61A3;
	Fri,  6 Dec 2024 19:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbdYORL1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7922E14B08C
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512750; cv=none; b=riLds1SlTx8miNS7VOSTkhZqe79wuxJYJ/1fb8BfO3nlM0Zk+uuQ3HGkn2YbABC/zOne8YO/CN9GnpakEkrZ6f85u6OEmH70rN+62KeRNIGrMMQTwejGv1OuCW1agqsnVm2XYNmtU/Un96erPbJD6zehXJwQ3uA43ec9vClcAfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512750; c=relaxed/simple;
	bh=LgEXUFcPyPZD6g721QbhJO/eIH15TrqnDIh7ECBlBdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMYIEQYs682kPTfSRnZaQVsGaOh/0mEKUbu9zXWRFKnmxsGWhcq53fGW6t2NhJI1KsRswVskAHmZSW6nxe9K8+/Iic01VgmwUH5DFUO75VOrUiNv3qJ8ap3VrIL5tpeDMA54UUbkenPXKrgBfIyhOY7QW2lOWJsKCd4SWbk9Q+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbdYORL1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434e84b65e7so159945e9.3
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 11:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733512747; x=1734117547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgbW5smThpWfH0K/YXGpa1Hh31/k5vjnLV5q42WtnW4=;
        b=cbdYORL1WbzRBLdXzTATbZ9oHVY5YBpjH//vZXIWdyRTEOHbWI1jLf7IuJxdnqeDae
         WEhXqi7iHjehA1PJP8+T2bqbISmjN86Imx7Zz9PHfXavsICmmZeilK4gkGuQ8uH1DyFI
         ZetvvephyOZTTylYLtIoiNdyiwsTo5SZpuGGUt2kqQ0e27j3aogs2fulSrbBcHQXWSCd
         Y7kdufipMBDK72RntZSgDAbrT7/yeZ7s+Sa8+F4U5ZDxABhXWrL/EetOIC+mByV0eIZr
         VCXcJrfjG+Yk4zGzP8w3JIU9YRNfsRUA9C+U5l/ZtFaUlWiDPVFhyzBXnLj0dYi8VOD5
         GeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733512747; x=1734117547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgbW5smThpWfH0K/YXGpa1Hh31/k5vjnLV5q42WtnW4=;
        b=GsgOtudluWYpM+3uKIqp9Tgvaq1Cn4WxYWreCv3F1CKIrPC/A7iSQwlFwxrx4Yzvtu
         VLO1Ti1hSvmVbbhhEPu4PmdAV0FXp+OI3VJJ0UvdWYI77CgDIaWVUfQpE5wdeAhXlP/e
         YN5N7rcS6LdYwtVuVYHJNlmr25oMCNgidSsOTb/CDmX3Lx6wpLEEmzu07fQ++dUVbwpM
         hGPXEttwrJziNB++lj5QQXrzth90trPmEvhLpz1az4N25NOedSLuwlpjS2A6SPVh7Zb4
         VXaD/vsjw2b3OioUAmSNMwOlUQWDMMOCCo+OhxvfhI+EO3/zXIK0kYg3gfYA2dj7dbGY
         vfxA==
X-Forwarded-Encrypted: i=1; AJvYcCU3WPssqSVT5QbRskDHLfGLcqifEpV0utxqIduY5vK6qAJGelJCctu0tIncP5dAFfzGBoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqPLfOFm/sAxpRIMJQlpnxe/PHbm/4sFbiI8zzfoVX18xh6McN
	qWDVSZXLLw2vtxWdyix7yCBT5c+1A+tx96bKoE32X372W0phgEmpqI2Q74mB4A0PTOIOVsszUv8
	YtJvrgNiSga28Kq8k6scMwvBq1qU=
X-Gm-Gg: ASbGnctdAosS1CarUbzGxbdsEhAUucHk1zXUhJStSyEEMRpZNPtwE6kotwGHQ8fJLP1
	OIx4T50eSdkZnGEizB8YutVsdh03/C6WLkG4NPQSauj16Crk=
X-Google-Smtp-Source: AGHT+IFrD90rfU3J/vyRoecp9M2l8EJa0mW4Q71w9Zimsdu0e59tG5TZsjp/DcZ9RNBKBfDrlISuvoKA0Af3os8dy+0=
X-Received: by 2002:a5d:5886:0:b0:385:f092:e02 with SMTP id
 ffacd0b85a97d-3862b372e18mr3208361f8f.31.1733512746685; Fri, 06 Dec 2024
 11:19:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206161053.809580-1-memxor@gmail.com> <20241206161053.809580-3-memxor@gmail.com>
 <CAADnVQ+_XGVsxYji3WYNj1-KhYZwKaFCgQ6aN=yFB3YWpRT78A@mail.gmail.com>
 <6ef10614dfdf281663f62315247c4bb33c2609bc.camel@gmail.com>
 <CAADnVQLKROxDbx8ehfbCNvKPnrWQpGeqzdy_AipCVbwEW9Bcow@mail.gmail.com> <CAP01T75j=4A2t2pngMg_A3+NyEG3OmO2gMk3NKX4UjYj4gcR-w@mail.gmail.com>
In-Reply-To: <CAP01T75j=4A2t2pngMg_A3+NyEG3OmO2gMk3NKX4UjYj4gcR-w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Dec 2024 11:18:55 -0800
Message-ID: <CAADnVQJ_KQAKueNMqg0SjCB4A42eyYeH0M3nkoz8Eo4NZ4kC0Q@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/3] bpf: Do not mark NULL-checked raw_tp arg as scalar
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	kkd@meta.com, Manu Bretelle <chantra@meta.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 11:10=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 6 Dec 2024 at 19:37, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Dec 6, 2024 at 10:15=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Fri, 2024-12-06 at 09:59 -0800, Alexei Starovoitov wrote:
> > > > On Fri, Dec 6, 2024 at 8:11=E2=80=AFAM Kumar Kartikeya Dwivedi <mem=
xor@gmail.com> wrote:
> > > > >
> > > > > An implication of this fix, which follows from the way the raw_tp=
 fixes
> > > > > were implemented, is that all PTR_MAYBE_NULL trusted PTR_TO_BTF_I=
D are
> > > > > engulfed by these checks, and PROBE_MEM will apply to all of them=
, incl.
> > > > > those coming from helpers with KF_ACQUIRE returning maybe null tr=
usted
> > > > > pointers. This NULL tagging after this commit will be sticky. Com=
pared
> > > > > to a solution which only specially tagged raw_tp args with a diff=
erent
> > > > > special maybe null tag (like PTR_SOFT_NULL), it's a consequence o=
f
> > > > > overloading PTR_MAYBE_NULL with this meaning.
> > > > >
> > > > > Fixes: cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_N=
ULL")
> > > > > Reported-by: Manu Bretelle <chantra@meta.com>
> > > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > > ---
> > > > >  kernel/bpf/verifier.c | 6 ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > > >
> > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > index 82f40d63ad7b..556fb609d4a4 100644
> > > > > --- a/kernel/bpf/verifier.c
> > > > > +++ b/kernel/bpf/verifier.c
> > > > > @@ -15365,6 +15365,12 @@ static void mark_ptr_or_null_reg(struct =
bpf_verifier_env *env,
> > > > >                         return;
> > > > >
> > > > >                 if (is_null) {
> > > > > +                       /* We never mark a raw_tp trusted pointer=
 as scalar, to
> > > > > +                        * preserve backwards compatibility, inst=
ead just leave
> > > > > +                        * it as is.
> > > > > +                        */
> > > > > +                       if (mask_raw_tp_reg_cond(env, reg))
> > > > > +                               return;
> > > >
> > > > The blast radius is getting too big.
> > > > Patch 1 is ok, but here we're doubling down on
> > > > the hack in commit
> > > > cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
> > > >
> > > > I think we need to revert the raw_tp masking hack and
> > > > go with denylist the way Jiri proposed:
> > > > https://lore.kernel.org/bpf/ZrIj9jkXqpKXRuS7@krava/
> > > >
> > > > denylist is certainly less safer and it's a whack-a-mole
> > > > comparing to allowlist, but it's much much shorter
> > > > according to Jiri's analysis:
> > > > https://lore.kernel.org/bpf/Zr3q8ihbe8cUdpfp@krava/
> > > >
> > > > Eduard had an idea how to auto generate such allow/denylist
> > > > during the build.
> > > > That could be a follow up.
> > >
> > > If the sole goal is to avoid dead code elimination for tracepoint
> > > parameter null check, there might be another hack. Not sure if it was
> > > discussed:
> > > - don't add PTR_MAYBE_NULL (but maybe add a new tag, PTR_SOFT_NULL
> > >   from Kumar's original RFC);
> > > - in is_branch_taken() don't predict anything when tracepoint
> > >   parameters are compared;
> >
> > this part was discussed, but we didn't realize we need below bit...
> >
> > > - in mark_ptr_or_null_regs() don't propagate null for pointers to
> > >   tracepoint parameters (as in this patch).
> >
> > ... and here the 'for tp args' filter is hard to do.
> > mark_ptr_or_null_regs() is generic. arg vs non-arg is lost long ago.
>
> It is not lost. If only args are marked PTR_SOFT_NULL or
> reg->btf.is_raw_tp_arg (or w/e else), it can still be seen when we are
> in that function, and all its copies will have the same information.

ok. fair. still such PTR_SOFT_NULL can only be a temporary workaround.
We still need to revert cb4158ce8ec8.
And if we're reverting and adding soft_null knowingly to revert
later that's just too much.
The cb4158ce8ec8 approach felt ok-ish initially, but two issues
were found. soft_null looks ok-ish today, but it may have issues too.
revert plus denylist is a better way long term.
Especially with automation of allow/deny lists.

