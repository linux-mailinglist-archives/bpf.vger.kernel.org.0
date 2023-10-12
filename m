Return-Path: <bpf+bounces-12038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 587DD7C7260
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 18:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6A62828B8
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 16:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6F2328AC;
	Thu, 12 Oct 2023 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZoGARWC"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619552AB3D
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 16:22:38 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F91EC0
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 09:22:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso995123a12.1
        for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 09:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697127755; x=1697732555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y09KrjwCf2GivS1PdNxi+2uuTwGLpLDeMFTQ+oKjADk=;
        b=BZoGARWCsrpBAFEuzoZjWGrgKNR/Y24B7NNz2SwEzIsHGtLk97ShyYj9ZYDUNEoJTV
         lvyjyua4Tpwin4FqgUz5luCUNRUE85zvPotmfimSi3aD7ABJ/fS2PczFX3zpPI9sgBXL
         Pocs/mClaq9SyjUbZQYodgPI9ZycJgAYYchMz/ezpzw2y2p0IYBmpRJuY1O9/jV04F3Q
         t1CSjmTuw7fc+xR3CO55Hxr7DK82FQdFwiqZz0Wi1vtkrD4QuFDxleGW9Nd3czGuvnw4
         GOLe2FPxRiQMgNF8Rli4v18v/rhau0K7PWEvEhmjAQAOvfb56YXYSDH9LEgfDhkTV7KR
         mk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697127755; x=1697732555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y09KrjwCf2GivS1PdNxi+2uuTwGLpLDeMFTQ+oKjADk=;
        b=fNRAQrR+cDa71mDYHK0Q12ogD52vmPJRMiDV/5tgpBJK96CMRcQFp9xfN8FnXwbQYr
         WrPfEMMrZEDoA9aCw63cAVMVXAgJDhqQ9AqNou6yKtkMIMIZLdZiKE37+bWuM0P+dERC
         4np0BO6a2FGkMPVr31RMBnqf5fqJ/7JNhxfzxbtCGtELRFxiHS9q/ZIwiKjFC1jJ5Jwi
         MkTF744BNU1WH0cJ4uT0xanyjNhLixCaeRMsm/ydZvKxHLXxCd4WtPwXEeLtyM8AWGgY
         AtcsOZyVjNR7dB5AdzHH1dSG1YvSdotm7hktdUR3PHWDb9GcpyPcqxQLeimjibCf+BQP
         l/mw==
X-Gm-Message-State: AOJu0YwlSlDv1TpTgH5dEVM9f/C0ZBd+pQDhdY8fKbkizh7k66X5Ob+H
	WfbNk22ESOfQnX1N+34gZZ/IF/XOkye5a3xGpktgH1KWXtY=
X-Google-Smtp-Source: AGHT+IEAlPANYWCEak4xB5pzDXLtv3Wst1GSiGYA4SqjXIemQFkk2ZYNK0dc+zIEKR44w2S+s5A/DL+wVVc6wXa0r2s=
X-Received: by 2002:a05:6402:27c9:b0:53e:2a65:1d9c with SMTP id
 c9-20020a05640227c900b0053e2a651d9cmr809801ede.25.1697127754656; Thu, 12 Oct
 2023 09:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011223728.3188086-1-andrii@kernel.org> <20231011223728.3188086-5-andrii@kernel.org>
 <65278534a3cb0_4a01020845@john.notmuch>
In-Reply-To: <65278534a3cb0_4a01020845@john.notmuch>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Oct 2023 09:22:23 -0700
Message-ID: <CAEf4BzaZx3_wGXqXBFt_Y4z+2L9XF7krNan4ZN4DQ0uLLXOf_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/5] bpf: disambiguate SCALAR register state
 output in verifier logs
To: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 10:33=E2=80=AFPM John Fastabend
<john.fastabend@gmail.com> wrote:
>
> Andrii Nakryiko wrote:
> > Currently the way that verifier prints SCALAR_VALUE register state (and
> > PTR_TO_PACKET, which can have var_off and ranges info as well) is very
> > ambiguous.
> >
> > In the name of brevity we are trying to eliminate "unnecessary" output
> > of umin/umax, smin/smax, u32_min/u32_max, and s32_min/s32_max values, i=
f
> > possible. Current rules are that if any of those have their default
> > value (which for mins is the minimal value of its respective types: 0,
> > S32_MIN, or S64_MIN, while for maxs it's U32_MAX, S32_MAX, S64_MAX, or
> > U64_MAX) *OR* if there is another min/max value that as matching value.
> > E.g., if smin=3D100 and umin=3D100, we'll emit only umin=3D10, omitting=
 smin
> > altogether. This approach has a few problems, being both ambiguous and
> > sort-of incorrect in some cases.
> >
> > Ambiguity is due to missing value could be either default value or valu=
e
> > of umin/umax or smin/smax. This is especially confusing when we mix
> > signed and unsigned ranges. Quite often, umin=3D0 and smin=3D0, and so =
we'll
> > have only `umin=3D0` leaving anyone reading verifier log to guess wheth=
er
> > smin is actually 0 or it's actually -9223372036854775808 (S64_MIN). And
> > often times it's important to know, especially when debugging tricky
> > issues.
>
> +1
>
> >
> > "Sort-of incorrectness" comes from mixing negative and positive values.
> > E.g., if umin is some large positive number, it can be equal to smin
> > which is, interpreted as signed value, is actually some negative value.
> > Currently, that smin will be omitted and only umin will be emitted with
> > a large positive value, giving an impression that smin is also positive=
.
> >
> > Anyway, ambiguity is the biggest issue making it impossible to have an
> > exact understanding of register state, preventing any sort of automated
> > testing of verifier state based on verifier log. This patch is
> > attempting to rectify the situation by removing ambiguity, while
> > minimizing the verboseness of register state output.
> >
> > The rules are straightforward:
> >   - if some of the values are missing, then it definitely has a default
> >   value. I.e., `umin=3D0` means that umin is zero, but smin is actually
> >   S64_MIN;
> >   - all the various boundaries that happen to have the same value are
> >   emitted in one equality separated sequence. E.g., if umin and smin ar=
e
> >   both 100, we'll emit `smin=3Dumin=3D100`, making this explicit;
> >   - we do not mix negative and positive values together, and even if
> >   they happen to have the same bit-level value, they will be emitted
> >   separately with proper sign. I.e., if both umax and smax happen to be
> >   0xffffffffffffffff, we'll emit them both separately as
> >   `smax=3D-1,umax=3D18446744073709551615`;
> >   - in the name of a bit more uniformity and consistency,
> >   {u32,s32}_{min,max} are renamed to {s,u}{min,max}32, which seems to
> >   improve readability.
>
> agree.
>
> >
> > The above means that in case of all 4 ranges being, say, [50, 100] rang=
e,
> > we'd previously see hugely ambiguous:
> >
> >     R1=3Dscalar(umin=3D50,umax=3D100)
> >
> > Now, we'll be more explicit:
> >
> >     R1=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=3D50,smax=3Dumax=3Dsmax32=
=3Dumax32=3D100)
> >
> > This is slightly more verbose, but distinct from the case when we don't
> > know anything about signed boundaries and 32-bit boundaries, which unde=
r
> > new rules will match the old case:
> >
> >     R1=3Dscalar(umin=3D50,umax=3D100)
>
> Did you consider perhaps just always printing the entire set? Its overly
> verbose I guess but I find it easier to track state across multiple
> steps this way.

I didn't consider that because it's way too distracting and verbose
(IMO) in practice. For one, those default values represent the idea
"we don't know anything", so whether we see umax=3D18446744073709551615
or just don't see umax makes little difference in practice (though
perhaps one has to come to realization that those two things are
equivalent). But also think about seeing this:

smin=3D-9223372036854775807,smax=3D9223372036854775807,umin=3D0,umax=3D1844=
6744073709551615,smin32=3D-2147483648,smax32=3D21474836487,umin32=3D0,umax3=
2=3D4294967295

How verbose and distracting that is, and how much time would it take
you to notice that this is not just "we don't know anything about this
register", but that actually smin is not a default, it's S64_MIN+1.
This is of course extreme example (I mostly wanted to show how verbose
default output will be), but I think the point stands that omitting
defaults brings out what extra information we have much better.

It's an option to do it for LOG_LEVEL_2, but I would still not do
that, I'd find it too noisy even for level 2.

>
> Otherwise patch LGTM.

