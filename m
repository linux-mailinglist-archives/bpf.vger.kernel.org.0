Return-Path: <bpf+bounces-10564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE2E7A9C71
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519291F214AD
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D7F4B22A;
	Thu, 21 Sep 2023 18:11:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBAF43AAE
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 18:11:00 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90079A70C8
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 11:00:36 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c008d8fd07so21440381fa.1
        for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 11:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695319235; x=1695924035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsoT1u7/u6X65xdCoAMe/73F6FG9WCFKQ1c7QYZKvWI=;
        b=PTr4kYO/FXscwqFs1NilO9PdxcqxprdRc9fYFy4eMRBJNRf71hUsoplC9dDtHmRoU4
         Gfk63ZtM2TY6c0OlZXS2d45S/ImAlwLCCVo83W9Hoht1+4qBlkn7vs2yPdfkQDjnXsGe
         dzlNi9Jahk9Ey3+mhqnvJR290xyBumNpMbeEl7uNWYeaQgUDV8Fe1RflAp7pdgM3hQl+
         K2uiMPSKkn9XsJMzhyqS1YWlYJewEuH82nb3MJaBepoQBDTsvgXC3jGI9hEVwz9pj6tU
         WGbUYZyBeLLK13t78tlYTi/t8HYO/FbCpBOI1PEa1KpvFUjV9eLY36AZB4P26U2DxB8O
         Vifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319235; x=1695924035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsoT1u7/u6X65xdCoAMe/73F6FG9WCFKQ1c7QYZKvWI=;
        b=foeobUX3KZDVAfOLwuUjqXL+AJ7A4zFoIIWmHJ0CRkoTGkH6R8QLH/SFJs6T28uLv+
         jziK/HPpGlLFIQpT3ZeAdbL586MOeboPOOhhbnlYhyLV9zrUfg3G6/0xExWgU4i84smr
         FW/9AAJqEqvWvS9w/UHWzNUApVOzyHtUPzA6JyYVp2AR/NuwJc6LDAkTQbNwTqMAQ2a4
         QhC+twKuJcD22HyXFTubHBPXdDUp9yl7BxWZeIZY8DDPgGCfxr53xRmYbhVbSRrsRDYz
         lqZKl8GTTqyUwzOP/tv8gjZBuNjd/hoc/UlcRJQW81GnOBSH1qGZ2DbwKSHgb/BEFV76
         4beg==
X-Gm-Message-State: AOJu0YxdkKlWjbKKMjKP1mdarg4/8a/yvreWmUuI0n8zcHA+05Xfj/i/
	QlOwkttfQJVEbdgkzWFq6ZkPKQy0FAHCOuWpJJs/llWeUM7GsA==
X-Google-Smtp-Source: AGHT+IH7KvCk/GFm88oWBeAmU5yd+d0enN+IP6akjsZLA/qsKFjVnz5s4wT0iDh5yW57lqQqRTI7T3yAbrsLm7oUU34=
X-Received: by 2002:adf:ea0e:0:b0:31f:e756:cbf9 with SMTP id
 q14-20020adfea0e000000b0031fe756cbf9mr4815022wrm.22.1695287661534; Thu, 21
 Sep 2023 02:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com>
 <CAADnVQJpLAzmUfwvWBr8a_PWHYHxHw9vdAXnWB4R4PbVY4S4mw@mail.gmail.com>
 <CAEf4Bzbubu7KjBv=98BZrVnTrcfPQrnsp-g1kOYKM=kUtiqEgw@mail.gmail.com>
 <dff1cfec20d1711cb023be38dfe886bac8aac5f6.camel@gmail.com>
 <CAP01T76duVGmnb+LQjhdKneVYs1q=ehU4yzTLmgZdG0r2ErOYQ@mail.gmail.com>
 <a2995c1d7c01794ca9b652cdea7917cac5d98a16.camel@gmail.com>
 <97a90da09404c65c8e810cf83c94ac703705dc0e.camel@gmail.com>
 <CAEf4BzYg8T_Dek6T9HYjHZCuLTQT8ptAkQRxrsgaXg7-MZmHDA@mail.gmail.com> <ee714151d7c840c82d79f9d12a0f51ef13b798e3.camel@gmail.com>
In-Reply-To: <ee714151d7c840c82d79f9d12a0f51ef13b798e3.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 21 Sep 2023 02:14:09 -0700
Message-ID: <CAADnVQJn35f0UvYJ9gyFT4BfViXn8T8rPCXRAC=m_Jx_CFjrtw@mail.gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrew Werner <awerner32@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Andrei Matei <andreimatei1@gmail.com>, 
	Tamir Duberstein <tamird@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, 
	Song Liu <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 5:19=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> > >
> > > Note that R7=3Dfp-16 in old state vs R7_w=3D57005 in cur state.
> > > The registers are considered equal because R7 does not have a read ma=
rk.
> > > However read marks are not yet finalized for old state because
> > > sl->state.branches !=3D 0.

By "liveness marks are not finalized" you mean that
regs don't have LIVE_DONE?
That shouldn't matter to state comparison.
It only needs to see LIVE_READ.
LIVE_DONE is a sanity check for liveness algorithm only.
It doesn't affect correctness.

> > > (Note: precision marks are not finalized as
> > > well, which should be a problem, but this requires another example).
> >
> > I originally convinced myself that non-finalized precision marking is
> > fine, see the comment next to process_iter_next_call() for reasoning.
> > If you can have a dedicated example for precision that would be great.
> >
> > As for read marks... Yep, that's a bummer. That r7 is not used after
> > the loop, so is not marked as read, and it's basically ignored for
> > loop invariant checking, which is definitely not what was intended.
>
> Liveness is a precondition for all subsequent checks, so example
> involving precision would also involve liveness. Here is a combined
> example:
>
>     r8 =3D 0
>     fp[-16] =3D 0
>     r7 =3D -16
>     r6 =3D bpf_get_current_pid_tgid()
>     bpf_iter_num_new(&fp[-8], 0, 10)
>     while (bpf_iter_num_next(&fp[-8])) {
>       r6++
>       if (r6 !=3D 42) {
>         r7 =3D -32
>         continue;
>       }
>       r0 =3D r10
>       r0 +=3D r7
>       r8 =3D *(u64 *)(r0 + 0)
>     }
>     bpf_iter_num_destroy(&fp[-8])
>     return r8
>
> (Complete source code is at the end of the email).
>
> The call to bpf_iter_num_next() is reachable with r7 values -16 and -32.
> State with r7=3D-16 is visited first, at which point r7 has no read mark
> and is not marked precise.
> State with r7=3D-32 is visited second:
> - states_equal() for is_iter_next_insn() should ignore absence of
>   REG_LIVE_READ mark on r7, otherwise both states would be considered
>   identical;

I think assuming live_read on all regs in regsafe() when
cb or iter body is being processed will have big impact
on processed insns.
I suspect the underlying issue is different.

In the first pass of the body with r7=3D-16 the 'r0 +=3D r7'
insn should have added the read mark to r7,
so is_iter_next_insn after 2nd pass with r7=3D-32 should reach
case SCALAR_VALUE in regsafe().
There we need to do something with lack of precision in r7=3D-16,
but assume that is fixed, the 3rd iter of the loop should continue
and 'r0 +=3D r7' in the _3rd_ iter of the loop should propagate
read mark all the way to r7=3D-32 reg.
I mean the parentage chain between regs should link
regs of iterations.
I believe the process_iter_next_call() logic maintains
correct parentage chain, since it's just a push_stack()
and is_state_visited() should be connecting parents.
So in case of iter body the issue with above loop is only
in missing precision,
but for your cb verification code I suspect the issue is due
to lack of parentage chain and liveness is not propagated ?

I could be completely off the mark.
The discussion is hard to follow.
It's probably time to post raw patch and continue with code.

