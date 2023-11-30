Return-Path: <bpf+bounces-16325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D50D7FFC60
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 21:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174FF281AA7
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 20:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F414753E3C;
	Thu, 30 Nov 2023 20:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmaWdTCS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5925A53E07
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 20:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC052C433C9
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 20:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701375585;
	bh=+fS8RcfDjMPugIkkMGCUp3Ki0/f74nwRw2JMTv9k2qk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XmaWdTCS9QQJsBrr07TUy3sqB7TL0syOWNpRymu86O1K2gDWao6nmTyh5Qmlkx99u
	 tEqY0bQrHxTdlTMkTpH0h5ElbA0HDaqgmhTV3+1ErEWP8nNbFnNP9kFdaSc4+e42MH
	 E2hdKXlpwNnnyOl7RIj/FKqy9hHnTciqH/i2s5I9y+VZi4Nyid0iVW5bAs4gKdoeib
	 10f4aHcVpR2dIVUYFqT8fOVRRVUlMcieluU/+Kq7DrQn5MGuu1lDu5Z3R+ncIQTrbD
	 de5o9iqyUuelV6vc7mHd0aUW6spoR1ZV0JHTMHAh3vtbgdp/XkFTm2LqlMfqpCYtsU
	 KgTx6BELGGRhA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2c9bd3ec4f6so17016031fa.2
        for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 12:19:45 -0800 (PST)
X-Gm-Message-State: AOJu0YygiXVhPPSSo/vSrkSDku41oADukcuu/e3THreUqJYj0eYRZiwT
	672hKFVzRCinZ/bGTcRIjasFnqR+yThGsCV87Js=
X-Google-Smtp-Source: AGHT+IEi/OAHZCAK50knyHdBIWnA64vP+uXp1kOdLpPZqkw8Z+OTykgXO06m30tYu/guuOxiVRo0VyDYCg79kIm1XxU=
X-Received: by 2002:a2e:8683:0:b0:2c9:cb22:2948 with SMTP id
 l3-20020a2e8683000000b002c9cb222948mr62314lji.8.1701375583900; Thu, 30 Nov
 2023 12:19:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129195240.19091-1-9erthalion6@gmail.com> <20231129195240.19091-2-9erthalion6@gmail.com>
 <CAPhsuW6J+ZN7KQdxm+2=ZcGGkWohcQxeNS+nNjE5r0K-jdq=FQ@mail.gmail.com> <20231130100851.fymwxhwevd3t5d7m@ddolgov.remote.csb>
In-Reply-To: <20231130100851.fymwxhwevd3t5d7m@ddolgov.remote.csb>
From: Song Liu <song@kernel.org>
Date: Thu, 30 Nov 2023 12:19:31 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7Yif_mhaUsiwSFyUD7Pv4sz163DBz73EDhnTGMhwdApg@mail.gmail.com>
Message-ID: <CAPhsuW7Yif_mhaUsiwSFyUD7Pv4sz163DBz73EDhnTGMhwdApg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Relax tracing prog recursive attach rules
To: Dmitry Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev, 
	dan.carpenter@linaro.org, olsajiri@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 2:08=E2=80=AFAM Dmitry Dolgov <9erthalion6@gmail.co=
m> wrote:
>
> > On Wed, Nov 29, 2023 at 03:58:02PM -0800, Song Liu wrote:
> > We discussed this in earlier version:
> >
> > "
> > > If prog B attached to prog A, and prog C attached to prog B, then we
> > > detach B. At this point, can we re-attach B to A?
> >
> > Nope, with the proposed changes it still wouldn't be possible to
> > reattach B to A (if we're talking about tracing progs of course),
> > because this time B is an attachment target on its own.
> > "
> >
> > I think this can be problematic for some users. Basically, doing
> > profiling on prog B can cause it to not work (cannot re-attach).
>
> Sorry, I was probably not clear enough about this first time. Let me
> elaborate:
>
> * The patch affects only tracing programs (only they can reach the
>   corresponding verifier change), so I assume in your example at least B
>   and A are fentry/fexit.
>
> * The patch is less restrictive than the current kernel implementation.
>   Currently, no attach of a tracing program to another tracing program is
>   possible, thus IIUC the case you describe (A, B: tracing, C -> B -> A,
>   then re-attach B -> A) is not possible without the patch (the first B
>   -> A is going to return a verifier error).

Yes, I was aware this is less restrictive than current rules, and I think
this can be very useful.

> * I've also tried to reproduce this use case with the patch, and noticed
>   that link_detach is not supported for tracing progs. Which means the
>   re-attach part in (C -> B -> A) has to be done via unloading of prog B
>   and C, then reattaching them one-by-one back. This is another
>   limitation why the case above doesn't seem to be possible (attaching
>   one-by-one back would of course work without any issues even with the
>   patch).

I think there is an issue without re-attach:
1. Load program A, B, C;
2. Attach C to B;
3. Attach B to A will fail.

> Does it all make sense to you, or am I missing something about the
> problem you describe?
>
> > Given it is not possible to create a call circle, shall we remove
> > this issue?
>
> I was originally thinking about this when preparing the patch, even
> independently of the question above, simply remove verifier limitation
> for an impossible situation sounds interesting. I see the following
> pros/cons:
>
> * Just remove the verifier limitation on recursive attachment is of
>   course easier.
>
> * At the same time it makes the implementation less "defensive" against
>   future changes.
>
> * Tracking attachment depth & followers might be useful in some other
>   contexts.
>
> All in all I've decided that more elaborated approach is slightly
> better. But if everyone in the community agrees that less
> "defensiveness" is not an issue and verifier could be simply made less
> restrictive, I'm fine with that. What do you think?

I think the follower_cnt check is not necessary, and may cause confusions.
For tracing programs, we are very specific on "which function(s) are we
tracing". So I don't think circular attachment can be a real issue. Do we
have potential use cases that make the circular attach possible?

Thanks,
Song

