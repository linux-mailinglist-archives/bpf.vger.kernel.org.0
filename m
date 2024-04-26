Return-Path: <bpf+bounces-27939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D088B3C9D
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 18:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503501C21BDE
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 16:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909DB14884B;
	Fri, 26 Apr 2024 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyTqTlQf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8499214EC4C
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714148256; cv=none; b=lF4qL7yS/7an66UtE3Fi7XaQ5t5OyY76aNn07Bomw8EkGxrGOJXQ1LJV4qWJ7s3EPhU6N2Xqx+YjuGVwYIrziCXhCxPq+p9Hey/Xv5rk2UZCtM2NXhK6JOKcQwJrCD220f6NgFjJZI+YAaAmClo7hoYd69hNWo1O/o5FJTaSu6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714148256; c=relaxed/simple;
	bh=DwyYmNUUUO+WeEyrt8xtVEcAOxk6ED+ITiFPSiej0ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4DZ0j7IqkJFlTqtIhvvKYqRqaX0hsfeabV36QLGseZ56yIazKny48nTHs0uovkhi7EynNfdmiNwYRxRi0wWUxKKKo8GqCd2yJ8TqzOd5lgYk2RXeCswLlT7Li0O43mWZYXbgN/2+1O1Eg2wZfmqNQtJxwSAOJIBQUrSvk+3XK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyTqTlQf; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34a3e0b31e6so1694341f8f.1
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 09:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714148253; x=1714753053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJlHCxJfmuAPRV94WEAHJrKHbpgMeSfba4kc4aQeSyY=;
        b=AyTqTlQftwV+1YR5mZrtkXyutxxy/9l/sSd1eW2UDOsiV5zfX9jygI8iiRG3wgaLp1
         unHnq+AsPNRySbsC2Q+TUkkYLEYnWsYNIrpqU+PuMGuOxgNvPOj7OjHR6q6SVpywW7L3
         iYcoc4hJdZB6lF67R04ZqsFizu6uPxRhTE4kLfXLExREPshpEK9GR+yb6FklBGx0Vlpy
         AA9jc6e3fuAYzZE5ElaSWkf9a5j3UyqcFHYoLdCwR4HlH/m5sDqVMymxlaNr7kWsgTCG
         awkpxqYZ5GhOPcxM2J0so+b4QRalynf9/AYvwxxQbcNdvSMxVagTn2tj/moS38vuh71g
         qi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714148253; x=1714753053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJlHCxJfmuAPRV94WEAHJrKHbpgMeSfba4kc4aQeSyY=;
        b=RIUtXRcu7LdrffDj1n4bocV+MeT2qmfiZumQx1sJCBdCF+2haiJsEtToLi5plUaZVI
         UFNH/fZpk7XlyIYwP0zyB05Eq3EW6SmLqajIQmMWLcWk6R7X0F5uV7/OePz/j3x4fPwS
         lA5rlEngxvwTbPThLI7+D4liqbMB35dQSlphVDF3Djx6nwZ2DaV5s1qFplzdnPrpaEz6
         YPMP30gw0D0hwgDwwJZJS6YYWrepYR6Xsn5kYz0kzOrkwwa6BVe25uy7aWDpaqmA1nCn
         MlzncEAaXxM4zhKFGEQZK2UdeolMn9UleEHFHvgjJPJ288yM1RGqIgCThx7s42Irs3Oj
         waNg==
X-Forwarded-Encrypted: i=1; AJvYcCWjKT4bPxQZ5Ux85e4PB4HPia67csbjfQBQnmsvChbd+ULO/b6/F1l90Xk8U2l9tDgAxhnbOR5ge+OggvOyS4oNr2pF
X-Gm-Message-State: AOJu0Yyd6uhk04SIW6kNQqD0E3+exUNTm/SLSkxGMHL6PsoNeh5eZQ2D
	1WqsTVWLsP8U+HtAiLOSO6TX5BuueJMQlZ5okOVIjUVvzVgxlKDxA1N0e1mfVRdtPgjF8FS9ExV
	tnLqdGzcwnnRchB/5XQLeQ4IAGaYSzmN9
X-Google-Smtp-Source: AGHT+IE70ll0sc24UTj7JphqKP9xMuFTJfe5Sz+EQIgoPRmwGK4YPvCdhoE8tWe0oCpWsxtu1USodri2h0vf7Xy9Dno=
X-Received: by 2002:a05:6000:14e:b0:34c:72a9:b656 with SMTP id
 r14-20020a056000014e00b0034c72a9b656mr1022234wrx.55.1714148252714; Fri, 26
 Apr 2024 09:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424224053.471771-1-cupertino.miranda@oracle.com>
 <20240424224053.471771-3-cupertino.miranda@oracle.com> <CAEf4BzYuHv7QnSAFVX0JH2YQd8xAR5ZKzWxEY=8yongH9kepng@mail.gmail.com>
 <87edasmnlr.fsf@oracle.com> <CAEf4BzazPWOgXFco=PJnGEAaJgjr2MG12=3Sr3=9gMckwTSDLg@mail.gmail.com>
In-Reply-To: <CAEf4BzazPWOgXFco=PJnGEAaJgjr2MG12=3Sr3=9gMckwTSDLg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 26 Apr 2024 09:17:20 -0700
Message-ID: <CAADnVQ+mSfUbtgk9pD+j6b3XLZJ1w7mGzbh2+t40Q81jB==wLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] bpf/verifier: refactor checks for range computation
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf <bpf@vger.kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, David Faust <david.faust@oracle.com>, 
	Jose Marchesi <jose.marchesi@oracle.com>, Elena Zannoni <elena.zannoni@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 9:12=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Apr 26, 2024 at 3:20=E2=80=AFAM Cupertino Miranda
> <cupertino.miranda@oracle.com> wrote:
> >
> >
> > Andrii Nakryiko writes:
> >
> > > On Wed, Apr 24, 2024 at 3:41=E2=80=AFPM Cupertino Miranda
> > > <cupertino.miranda@oracle.com> wrote:
> > >>
> > >> Split range computation checks in its own function, isolating pessim=
itic
> > >> range set for dst_reg and failing return to a single point.
> > >>
> > >> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> > >> Cc: Yonghong Song <yonghong.song@linux.dev>
> > >> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > >> Cc: David Faust <david.faust@oracle.com>
> > >> Cc: Jose Marchesi <jose.marchesi@oracle.com>
> > >> Cc: Elena Zannoni <elena.zannoni@oracle.com>
> > >> ---
> > >>  kernel/bpf/verifier.c | 141 +++++++++++++++++++++++----------------=
---
> > >>  1 file changed, 77 insertions(+), 64 deletions(-)
> > >>
> > >
> > > I know you are moving around pre-existing code, so a bunch of nits
> > > below are to pre-existing code, but let's use this as an opportunity
> > > to clean it up a bit.
> > >
> > >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > >> index 6fe641c8ae33..829a12d263a5 100644
> > >> --- a/kernel/bpf/verifier.c
> > >> +++ b/kernel/bpf/verifier.c
> > >> @@ -13695,6 +13695,82 @@ static void scalar_min_max_arsh(struct bpf_=
reg_state *dst_reg,
> > >>         __update_reg_bounds(dst_reg);
> > >>  }
> > >>
> > >> +static bool is_const_reg_and_valid(struct bpf_reg_state reg, bool a=
lu32,
> > >
> > > hm.. why passing reg_state by value? Use pointer?
> > >
> > Someone mentioned this in a review already and I forgot to change it.
> > Apologies if I did not reply on this.
> >
> > The reason why I pass by value, is more of an approach to programming.
> > I do it as guarantee to the caller that there is no mutation of
> > the value.
> > If it is better or worst from a performance point of view it is
> > arguable, since although it might appear to copy the value it also prov=
ides
> > more information to the compiler of the intent of the callee function,
> > allowing it to optimize further.
> > I personally would leave the copy by value, but I understand if you wan=
t
> > to keep having the same code style.
>
> It's a pretty big 120-byte structure, so maybe the compiler can
> optimize it very well, but I'd still be concerned. Hopefully it can
> optimize well even with (const) pointer, if inlining.
>
> But I do insist, if you look at (most? I haven't checked every single
> function, of course) other uses in verifier.c, we pass things like
> that by pointer. I understand the desire to specify the intent to not
> modify it, but that's why you are passing `const struct bpf_reg_state
> *reg`, so I think you don't lose anything with that.

+1
that "struct bpf_reg_state src_reg" code was written 7 years ago
when bpf_reg_state was small.
We definitely need to fix it. It might even bring
a noticeable runtime improvement.

