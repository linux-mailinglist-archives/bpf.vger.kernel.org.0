Return-Path: <bpf+bounces-17305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C06AA80B1C8
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 03:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA7A281A03
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 02:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246161107;
	Sat,  9 Dec 2023 02:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqsgeaNy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8623510C7
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 18:46:36 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id a640c23a62f3a-a1d2f89ddabso325055566b.1
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 18:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702089995; x=1702694795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njyPWm3H1PAHu+sl7wbmSCAvk8ryKH+hfzWCXBq9h9A=;
        b=UqsgeaNyJViXR8ba2nTzLNnAnIFceGrtFKXyzK/o3xhDYE22LtVBZDRikOoLrQ5B1r
         KhNbFg9yk5HgDdOK/qJBfjpDWIj52+wDzeHVh4vcIFKmlGjrKCneNFWP/aDfPq0O+oIo
         +Q9vZFmfXeKY+foSSre3n2hvxg0wGAtPrJ1KqL54s+FydCgqpzsqMB8JFIWDWK3kOm+k
         lHvr5+9C3YF1+yMZ/3bz4zMC2PKUp26BdpyufSIAnHmDqJSpTrRI+rY41A3IO92YRFcv
         kry5fFUsrv0UhrOHMgC+buO9H2aS7yCIZtTRIpgFd9qM2YwJBlsKMhuWi7pIRM27uYXP
         azZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702089995; x=1702694795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njyPWm3H1PAHu+sl7wbmSCAvk8ryKH+hfzWCXBq9h9A=;
        b=Dta4Kim9wQLxU2iaXC7nHO0rTLQ78ptEugAB9JHtn68SV/y/k2zygHlvNy/tySAMK/
         ZbT6HdAIB/eEJIF74M3tDNwVv7iTEwmOKB8lK0291JluqKBqAMqUfi+TLrX1blowj9pb
         lyxSP5Zmf7/T02dLecozOtS75eJLz8S+wKJ3DD4o1FlKLyi0LbFGkv/1TK6FEdBqrRXP
         ZwOUR859D5B1xrTTp+/zxsNP8zlQWYOnBGnjQZyoFPL3VKUNBBsyckt7gN+yzSqJWz6o
         C/w3PG8gb9dFr3Ku5lHhaRGBQ3U7PtZfydF44jNopZAKYBaPwAyqkjGttYZOsZjwiq1U
         lMtQ==
X-Gm-Message-State: AOJu0YxkIqbH9MdeNSxqjgfJ79WWmVAUgLKSB5N0E2so5apk8HJ7Acw5
	LaGHzvXRz6YDcvMaW84MAkIMpvQBuMGT+wW+/axvtyt2fjErsw==
X-Google-Smtp-Source: AGHT+IGF03Og0MY5MBxKD3JaSWX4m5ZU3xRLx7tHnLU5UDrGftVWLo87a84QzvitId/LAMyYzmNx53qdClGo8J9zy1g=
X-Received: by 2002:a17:906:6955:b0:a19:a19b:789a with SMTP id
 c21-20020a170906695500b00a19a19b789amr480589ejs.93.1702089994694; Fri, 08 Dec
 2023 18:46:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204153919.11967-1-andreimatei1@gmail.com>
 <CAEf4BzZ57kAWYDBwpxxAsWRyo5fvnHf5-R+OZuPSd1L-viQDig@mail.gmail.com>
 <CABWLsetTu3fBcJaVhC8D-ZDBR0n4HM5xkhk1pA9KA+_-nZy9cw@mail.gmail.com>
 <CAEf4BzYhn7wD102_5E0jqiP4yH7prb-RyTTHaF_3fuVPVN--Og@mail.gmail.com>
 <CABWLses4A1W4kMAqiEd8drL6PKiK7egk_btT7OH3C=LxC4vefQ@mail.gmail.com>
 <CAEf4Bzb6+dF5r4rvcPakoVS_+GOXVs=3wgPEvFMoiGxwB0evqA@mail.gmail.com>
 <CABWLseupmKtmQX4SnRF0r9taU4QNwQunU+f79QFQ1V4KXo=TKA@mail.gmail.com> <CAEf4Bzac94=uum2ORYWR2i_qYpmyde2xTLucDf_+EtFE9vCw9Q@mail.gmail.com>
In-Reply-To: <CAEf4Bzac94=uum2ORYWR2i_qYpmyde2xTLucDf_+EtFE9vCw9Q@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 9 Dec 2023 03:45:58 +0100
Message-ID: <CAP01T75f6AojB2pLr9RJtrJXfsE+FMJ5HZHyew0KPLCbm9y3ig@mail.gmail.com>
Subject: Re: [PATCH bpf V2 1/1] bpf: fix verification of indirect var-off
 stack access
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrei Matei <andreimatei1@gmail.com>, bpf@vger.kernel.org, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Dec 2023 at 23:15, Andrii Nakryiko <andrii.nakryiko@gmail.com> wr=
ote:
>
> On Thu, Dec 7, 2023 at 7:23=E2=80=AFPM Andrei Matei <andreimatei1@gmail.c=
om> wrote:
> >
> > [...]
> >
> > > >
> > > > Ack. Still, if you don't mind entertaining me further, two more que=
stions:
> > > >
> > > > 1. What do you make of the code in check_mem_size_reg() [1] where w=
e do
> > > >
> > > > if (reg->umin_value =3D=3D 0) {
> > > >   err =3D check_helper_mem_access(env, regno - 1, 0,
> > > >         zero_size_allowed,
> > > >         meta);
> > > >
> > > > followed by
> > > >
> > > > err =3D check_helper_mem_access(env, regno - 1,
> > > >       reg->umax_value,
> > > >       zero_size_allowed, meta);
> > > >
> > > > [1] https://github.com/torvalds/linux/blob/bee0e7762ad2c6025b9f5245=
c040fcc36ef2bde8/kernel/bpf/verifier.c#L7486-L7489
> > > >
> > > > What's the point of the first check_helper_mem_access() call - the
> > > > zero-sized one
> > > > (given that we also have the second, broader, check)? Could it be
> > > > simply replaced by a
> > > >
> > > > if (reg->umin_value =3D=3D 0 && !zero_sized_allowed)
> > > >     err =3D no_bueno;
> > > >
> > >
> > > Maybe Kumar (cc'ed) can chime in as well, but I suspect that's exactl=
y
> > > this, and kind of similar to the min_off/max_off discussion we had. S=
o
> > > yes, I suspect the above simple and straightforward check would be
> > > much more meaningful and targeted.
> >
> > I plan on trying this in a bit; sounds like you're encouraging it.
> >
> > >
> > > I gotta say that the reg->smin_value < 0 check is confusing, though,
> > > I'm not sure why we are mixing smin and umin/umax in this change...
> >
> > When you say "in this change", you mean in the existing code, yeah?  I'=
m not
>
> Yeah, sorry, words are hard. It's clearly a question about pre-existing c=
ode.
>
> > familiar enough with the smin/umin tracking to tell if `reg->smin_value=
 >=3D 0`
> > (the condition that the function tests first) implies that
> > `reg->smin_value =3D=3D reg->umin_value` (i.e. the fact that we're curr=
ently mixing
>
> this is probably true most of the time, but knowing how tricky this
> range tracking is, there is non-zero chance that this is not always
> true. Which is why I'm a bit confused why we are freely intermixing
> signed/unsigned range in this code.
>
> > smin/umin in check_mem_size_reg() is confusing, but benign).  Is that t=
rue? If
> > so, are you saying that check_mem_size_reg() should exclusively use smi=
n/smax?
> >
>
> I'd like to hear from Kumar on what was the intent before suggesting
> changing anything.

So this was not originally from me, I just happened to move it around
when adding support for this to kfuncs into a shared helper (if you
look at the git blame), it's hard for me to comment on the original
intent, I would know as much as anyone else.

But to helpful, I digged around a bit and found the original patch
adding this snippet:

06c1c049721a ("bpf: allow helpers access to variable memory")

It seems the main reason to add that < 0 check on min value was to
tell the user in the specific case where a spilled value is reloaded
from stack that they need to mask it again using bitwise operations,
because back then a spilled constant when reloaded would become
unknown, and when passed as a parameter to a helper the program would
be rejected with a weird error trying to access size greater than the
user specified in C.

Now this change predates the signed/unsigned distinction, that came in:

b03c9f9fdc37 ("bpf/verifier: track signed and unsigned min/max values")

That changes reg->min_value to reg->smin_value, the < 0 comparison
only makes sense for that.
Since then that part of the code has stayed the same.

So I think it would probably be better to just use smin/smax as you
discussed above upthread, also since the BPF_MAX_VAR_SIZE is INT_MAX,
so it shouldn't be a problem.

>
> >
> > [...]

