Return-Path: <bpf+bounces-17354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE93580BEBD
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 02:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0C3280C87
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 01:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFA7E547;
	Mon, 11 Dec 2023 01:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fg7hbl7H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31613E7
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 17:24:02 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54c70c70952so5523080a12.3
        for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 17:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702257840; x=1702862640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGtUg7OkRjEFRB79h2kd74FHGYySciWU31AQ8v+4TzQ=;
        b=Fg7hbl7HMlSRlfuYOeepUAmP/vCePgu3ExBxA62BdtvavnQK4eZ4+sDP/+nIgzEMmy
         Y/5CpISBfbnCBKJJNroroujMphPFnv+CGNL/O6Q8dNz6gH6oQrm/WY/su6hWWTX9poCD
         NGNWhykswRG/cV5JYsaAAu/T1tdm3NxHVgCRG0UDgjPXGrIU4+WSGO3hvHkedqCpOr6l
         cMQMQDEeiiq/yAaDbr5pueiH4SEtMXRcTq/EWlD5L/qePhODrz8G4bp5p+jucPYfT4NL
         fZtHWnNzgLlE7UX9m2YNRthl2O3XUxuH4gw0ylqKK3iW0D1jqtfGrFeFaQsDRoATfpfj
         cyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702257840; x=1702862640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGtUg7OkRjEFRB79h2kd74FHGYySciWU31AQ8v+4TzQ=;
        b=MMxRCPPOboTkPTWtcYglCbw3OqSVRHxUbhP53OSz87VsdRtWC7BD4bQmjduj4+cQLk
         T7lHv2bK3Erw/rjty7gxTUhoUc1j8gSby70OpIzihdkN0Rf1ij529Z6qU5gZse7SV/A5
         bxOnUfWWz6VmdIFlXa5x7zt2VWjIM7RJ5OjzAH8MeFbo1E5aprwDo1BqQ4eQSfTLKS/y
         2NCAi50CCEYceNMclg2uKph2AChdZH2GpbikDT8EIJ8LUvrLh026729cAhN22DCIRu8z
         PvE/YRrn9Q5650AIyi+/k0XLNaO3TMgUb4et5mKYGnn881ZMwbyJSwG525XKUsdnOMMg
         4jgg==
X-Gm-Message-State: AOJu0YxHR92oVK7JTgUYqVuN9S1gOd/2INLf6xr/5c4T1/413jyc5t02
	6Lko1zzfBR8qJFnt9TJbt4MnMc8Yg6xAVc9LJ69VSKKDPhwtXw==
X-Google-Smtp-Source: AGHT+IGI6T7WcX9KctimJynAZgvDcvLyoPX5Q/IQgY3Ibhx9/wgbBcaX+I23TLDpYTX/YYKp2CupHVJofaP+CPX36wc=
X-Received: by 2002:a17:906:81c7:b0:a1f:657e:649f with SMTP id
 e7-20020a17090681c700b00a1f657e649fmr1086821ejx.201.1702257840104; Sun, 10
 Dec 2023 17:24:00 -0800 (PST)
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
 <CABWLseupmKtmQX4SnRF0r9taU4QNwQunU+f79QFQ1V4KXo=TKA@mail.gmail.com>
 <CAEf4Bzac94=uum2ORYWR2i_qYpmyde2xTLucDf_+EtFE9vCw9Q@mail.gmail.com>
 <CAP01T75f6AojB2pLr9RJtrJXfsE+FMJ5HZHyew0KPLCbm9y3ig@mail.gmail.com>
 <CABWLses1dhmpqKJd--xKKOU1SObfn4OC1Lg-OKTAdJpq0ZMRNQ@mail.gmail.com> <CAP01T77M=SyNviMYCO-koxizvD6eGm=5KQ1Wv=ahbRU5XQB4bA@mail.gmail.com>
In-Reply-To: <CAP01T77M=SyNviMYCO-koxizvD6eGm=5KQ1Wv=ahbRU5XQB4bA@mail.gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Sun, 10 Dec 2023 20:23:48 -0500
Message-ID: <CABWLsevE6qDTNdBhFquE7C5iTcF7SSfdtgi005OUrNrKjF-Paw@mail.gmail.com>
Subject: Re: [PATCH bpf V2 1/1] bpf: fix verification of indirect var-off
 stack access
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 10, 2023 at 6:13=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sun, 10 Dec 2023 at 23:46, Andrei Matei <andreimatei1@gmail.com> wrote=
:
> >
> > On Fri, Dec 8, 2023 at 9:46=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@=
gmail.com> wrote:
> > >
> > > On Fri, 8 Dec 2023 at 23:15, Andrii Nakryiko <andrii.nakryiko@gmail.c=
om> wrote:
> > > >
> > > > On Thu, Dec 7, 2023 at 7:23=E2=80=AFPM Andrei Matei <andreimatei1@g=
mail.com> wrote:
> > > > >
> > > > > [...]
> > > > >
> > > > > > >
> > > > > > > Ack. Still, if you don't mind entertaining me further, two mo=
re questions:
> > > > > > >
> > > > > > > 1. What do you make of the code in check_mem_size_reg() [1] w=
here we do
> > > > > > >
> > > > > > > if (reg->umin_value =3D=3D 0) {
> > > > > > >   err =3D check_helper_mem_access(env, regno - 1, 0,
> > > > > > >         zero_size_allowed,
> > > > > > >         meta);
> > > > > > >
> > > > > > > followed by
> > > > > > >
> > > > > > > err =3D check_helper_mem_access(env, regno - 1,
> > > > > > >       reg->umax_value,
> > > > > > >       zero_size_allowed, meta);
> > > > > > >
> > > > > > > [1] https://github.com/torvalds/linux/blob/bee0e7762ad2c6025b=
9f5245c040fcc36ef2bde8/kernel/bpf/verifier.c#L7486-L7489
> > > > > > >
> > > > > > > What's the point of the first check_helper_mem_access() call =
- the
> > > > > > > zero-sized one
> > > > > > > (given that we also have the second, broader, check)? Could i=
t be
> > > > > > > simply replaced by a
> > > > > > >
> > > > > > > if (reg->umin_value =3D=3D 0 && !zero_sized_allowed)
> > > > > > >     err =3D no_bueno;
> > > > > > >
> > > > > >
> > > > > > Maybe Kumar (cc'ed) can chime in as well, but I suspect that's =
exactly
> > > > > > this, and kind of similar to the min_off/max_off discussion we =
had. So
> > > > > > yes, I suspect the above simple and straightforward check would=
 be
> > > > > > much more meaningful and targeted.
> > > > >
> > > > > I plan on trying this in a bit; sounds like you're encouraging it=
.
> > > > >
> > > > > >
> > > > > > I gotta say that the reg->smin_value < 0 check is confusing, th=
ough,
> > > > > > I'm not sure why we are mixing smin and umin/umax in this chang=
e...
> > > > >
> > > > > When you say "in this change", you mean in the existing code, yea=
h?  I'm not
> > > >
> > > > Yeah, sorry, words are hard. It's clearly a question about pre-exis=
ting code.
> > > >
> > > > > familiar enough with the smin/umin tracking to tell if `reg->smin=
_value >=3D 0`
> > > > > (the condition that the function tests first) implies that
> > > > > `reg->smin_value =3D=3D reg->umin_value` (i.e. the fact that we'r=
e currently mixing
> > > >
> > > > this is probably true most of the time, but knowing how tricky this
> > > > range tracking is, there is non-zero chance that this is not always
> > > > true. Which is why I'm a bit confused why we are freely intermixing
> > > > signed/unsigned range in this code.
> > > >
> > > > > smin/umin in check_mem_size_reg() is confusing, but benign).  Is =
that true? If
> > > > > so, are you saying that check_mem_size_reg() should exclusively u=
se smin/smax?
> > > > >
> > > >
> > > > I'd like to hear from Kumar on what was the intent before suggestin=
g
> > > > changing anything.
> > >
> > > So this was not originally from me, I just happened to move it around
> > > when adding support for this to kfuncs into a shared helper (if you
> > > look at the git blame), it's hard for me to comment on the original
> > > intent, I would know as much as anyone else.
> > >
> > > But to helpful, I digged around a bit and found the original patch
> > > adding this snippet:
> > >
> > > 06c1c049721a ("bpf: allow helpers access to variable memory")
> > >
> > > It seems the main reason to add that < 0 check on min value was to
> > > tell the user in the specific case where a spilled value is reloaded
> > > from stack that they need to mask it again using bitwise operations,
> > > because back then a spilled constant when reloaded would become
> > > unknown, and when passed as a parameter to a helper the program would
> > > be rejected with a weird error trying to access size greater than the
> > > user specified in C.
> > >
> > > Now this change predates the signed/unsigned distinction, that came i=
n:
> > >
> > > b03c9f9fdc37 ("bpf/verifier: track signed and unsigned min/max values=
")
> > >
> > > That changes reg->min_value to reg->smin_value, the < 0 comparison
> > > only makes sense for that.
> > > Since then that part of the code has stayed the same.
> > >
> > > So I think it would probably be better to just use smin/smax as you
> > > discussed above upthread, also since the BPF_MAX_VAR_SIZE is INT_MAX,
> > > so it shouldn't be a problem.
> >
> > Thank you for spelunking, Kumar!
> > There were two discussions upthread:
> > 1) whether the 0-size check_helper_mem_access() call in
> > check_mem_size_reg() can be drastically simplified
> > 2) whether the mixed use of smin with umin/umax makes sense.
> >
> > It seems that we've come up empty-handed on a good reasoning
> > for 1). I have a patch that simplifies it AND also improves
> > error messages as a result. I'm inclined to send it for your
> > consideration, Andrii, if that's cool, as you also didn't
> > seem to like the current code.
> >
>
> While that's true, I think it should probably go into
> check_helper_mem_access instead of being duplicated for handlers of
> each switch statement.
> It seems one of them (for PTR_TO_MAP_KEY) hardcodes it regardless of
> what's passed in, and there's a special case of register_is_null which
> is permitted.
>
> So it might be better to unify the handling in check_helper_mem_access
> instead of its callers. Just my $0.02.

My initial focus is getting check_mem_size_reg() to not call
check_helper_mem_access() twice. That's what patch [1] does.

Then, I tend to agree with you that
check_helper_mem_access() forwarding zero_size_allowed() to
a bunch of switch arms seems unnecessary; it also bothered
me. I did try to do something about it for a bit - terminate
the handling of zero_sized_allowed somewhere - but the thing
is that the utilities used in that switch (e.g.
check_mem_region_access()) are also called in other places,
with both true and false for zero_sized_allowed. So I didn't
immediately come up with something better and gave up for
now. But if you have throughts, let's take it to the new
patch I'd say.

[1] https://lore.kernel.org/bpf/20231210225536.70322-1-andreimatei1@gmail.c=
om/


>
> > About 2) -- the current mixing of smin/umin/umax actually
> > makes sense to me.  I'd rationalize the (smin < 0) check as
> > "does this value *look* like a negative value? If so,
> > opportunistically give the user a nice error message". Even
> > if the value did not actually come from a signed variable,
> > but instead came for a very large unsigned, the program
> > shouldn't verify anyway, so it's no big deal if the negative
> > interpretation is erroneous. After that check, the value is
> > exclusively treated as unsigned, since the size argument for
> > which it is intended is unsigned.
> > So, I think you can argue either way for the combinations of
> > signed/unsigned checks that could be done, but I personally
> > am not inclined to change the current code.
> >
>
> I think based on the thread it would be better to atleast comments
> explaining all this, even if in the end we don't decide to touch it.

Yeah... But comment what exactly? I could put a comment on
the (smin_value < 0) check saying something "if the value
looks negative, assume that it came from a signed variable
and give a helpful error message", and imply that the value
should be treated as unsigned from that moment on. But then
it gets confusing when, a few lines down,
check_helper_mem_access() takes the size as `int` instead of
`u32`. So the truth I'm not entirely sure what to say, plus
Andrii might have other ideas about how the bike shed should
be colored. If we build more consensus though, I'm all about
adding comments.


>
> >
> > [...]

