Return-Path: <bpf+bounces-13998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B81287DF964
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 19:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90751C20FDA
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 18:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C2A210F6;
	Thu,  2 Nov 2023 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jL3lEzAL"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EE3210ED
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 18:01:12 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B8010CA
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 11:00:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9dbb3d12aefso146687266b.0
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 11:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698948031; x=1699552831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYrx0tP9QYlK8324Lc3B4a+LLBPMvbmqOgCE8XYy5hg=;
        b=jL3lEzAL/JAiaDt123nvwRcMLqJd7f53UNUM5aCV+16toa2UM00AbDAkLFpZ3mI0TC
         oV0i3ZmF8PcJ+Frhzw2wlTyeawzBxjE3ue2j7CfaC6WWi8U+MKFZVC8k1UbOp1JrHXom
         PC5pgj1DO9Pwy+98ZnJcl9RsNrHL1jJzvXvc4haA5Pk1L111mnLMRX2pxxNErNYbNZbI
         6UpxJJyRHeB9rzlIvxNIHbtkp8jrJReCuKxBbaJ9/srkKsKQt+qWtPEU/WEyG5X6mCns
         pp2/77CcaIir1qUTdwCjnVVI/1KCOq1Q+9vsCyrW0bymLyapk7UDmFecUV5rR+qtAwRu
         SUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698948031; x=1699552831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYrx0tP9QYlK8324Lc3B4a+LLBPMvbmqOgCE8XYy5hg=;
        b=vxxgGeHlCvbFTLtcP2Tl6p4AnsG9/gp+wHF72HYcqkL0MGDhzqlz/KCW2aw4swEEQE
         deZWkOMZVueQcyAqLq74vrLOSPylEfBeYY/ZotqPX9LBQxAt4U15GJEBzY8eNGrDi4KP
         A3p+ow5aQLXif/u9ZcV66I8j7U33yGz9qt2PTMIYds3M2yPEqjnIPlTWnMZRe0B+R+aV
         u2DI0WShPwyBIZ6sVWZc8IZKSaprObY1qf/vGY9CWR33I+xRCdghhdWINzhb+sDYH/0I
         eaFuuWevg/vPTcmg7VK3WbXzOje1NRezEZTz5QVwsWeiIm9wSq4FENlgliFU2BTA4dPh
         nKUQ==
X-Gm-Message-State: AOJu0YxAb+RoVUPYjp7RXUFNZtdEoM7HLBUzdE0Eiy88pPx9doUEvYH5
	r/o9c2i/IcZHQ2qsIoFgnp8zR+u4L8xb3at88Bs=
X-Google-Smtp-Source: AGHT+IGCWW7uSm60brRiuBElGUNT8JNlVQ3OLYLxBIqixsJHCO1QtXnw2kMJEJw+88KbIXcTAUZuv1H0nctbcd+ItXs=
X-Received: by 2002:a17:906:dac4:b0:9a9:f2fd:2a2b with SMTP id
 xi4-20020a170906dac400b009a9f2fd2a2bmr5661167ejb.73.1698948030905; Thu, 02
 Nov 2023 11:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102172640.3790869-1-andrii@kernel.org> <877cn011mj.fsf@toke.dk>
In-Reply-To: <877cn011mj.fsf@toke.dk>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 Nov 2023 11:00:19 -0700
Message-ID: <CAEf4Bzb4VbH56S2D_5Sc3u9V=OXOy20JTr4wsObBOiUA32Md2Q@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix bpf_dynptr_slice() returning ERR_PTR() on erro
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 10:55=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@kernel.org> wrote:
>
> Andrii Nakryiko <andrii@kernel.org> writes:
>
> > Let's fix it for real this time. It shouldn't just detect ERR_PTR()
> > return from bpf_xdp_pointer(), but also turn that into NULL to follow
> > bpf_dynptr_slice() contract.
> >
> > Fixes: 5426700e6841 ("bpf: fix bpf_dynptr_slice() to stop return an ERR=
_PTR.")
> > Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rd=
wr")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/helpers.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 56b0c1f678ee..04049097176c 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2309,7 +2309,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct b=
pf_dynptr_kern *ptr, u32 offset
> >       {
> >               void *xdp_ptr =3D bpf_xdp_pointer(ptr->data, ptr->offset =
+ offset, len);
> >               if (!IS_ERR_OR_NULL(xdp_ptr))
> > -                     return xdp_ptr;
> > +                     return NULL;
>
> Erm, the check in the if is inverted - so isn't this 'return xdp_ptr'
> covering the case where bpf_xdp_pointer() *does* in fact return a valid
> pointer?
>

Ah, you are right, I missed the ! part... Ok, then I don't think we
have an issue, great. Thanks for double checking!
Perhaps we should add a simple comment "/* we got a valid direct
pointer, return it */", as this looks like an error-handling case.

> -Toke

