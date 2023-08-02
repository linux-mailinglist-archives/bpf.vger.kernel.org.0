Return-Path: <bpf+bounces-6667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CDD76C327
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 04:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3965281B80
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 02:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFB1A4C;
	Wed,  2 Aug 2023 02:55:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECDCA3D
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 02:55:32 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7C62695
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 19:55:30 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b962535808so98239151fa.0
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 19:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690944928; x=1691549728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3KawIIdSZsZuxgabCo6IdJKUkHbfL/F//FMoh+PB+w=;
        b=YsdBTrSTbcZxqWcZVhQZumdMuDYewrHBF6URjWoGOp+wigQX+n4shOSxlf5t3VoZVQ
         2VjLF845hq/DM10BQVjzXhrAVkfOjaPuRR0v/PjkeRY6ZKGLFYKHgqkUrm4XvII14L5d
         b2J2VmEIMEOGbPEgVj75lO8M5nxI1qQ5VKTW52crU3xx1eFN/IHIYH7k94+kir+YPNID
         kzRF5Pnq402MuA1AZ/e6ed39Q7jknecVkOrazDo4E7W/SAPNQ/Gj7Hj8RK6tF/IbRjpl
         P4j8MFWMkw1ry144bfLLZodMswwkjI4Ke5iUuKKkbsCpSRwUwRS15eLanPHWJaStgcQU
         p3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690944928; x=1691549728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3KawIIdSZsZuxgabCo6IdJKUkHbfL/F//FMoh+PB+w=;
        b=aM+tP2W1EGPQaUln0ZRIbdQU9TwR4s6wl6t3bj7jiBsv/X5mMv/6UKqrn1bNmQjeNJ
         MoYxb1Hz1dztWHD4RiDVT+RgczR5sle/ecZOVYz7ZyTl6jiWYSquddh2Y++93FgyrBaz
         K0QMCle0DinQgyZnAkqWUwXmSbQfURuNlzDkPWwk87ocTf3nN/v3DsSAvZrVoZBs1Bpv
         AAIzAi0lWuPEQxxKPObQowXwV/huG82EG/v4Pt0JuySopAf/ENIdvqa22I2tHghKLsuK
         COakaC1A/KRICt1UndUK8Xz8xMaV9FyD02ODVfjrYt7KU9E15nMtStINFgDuECCyUBhB
         DpjQ==
X-Gm-Message-State: ABy/qLZfogP6vVlbtSfaxOydMG6lco6Onr9KcrFuYt8z4J0CY2M2tie8
	iRkql3g8sk7m2NJ9eUSgSPuDM0e4Jvs6+PGQefk=
X-Google-Smtp-Source: APBJJlFWHBWllQEsFDmzblSk1xOzJc9L/1BTLjjsGWOcJdSOCSZkLqFKUPChM57tbfYnTFoD+2k/w5ehEQvXz7Ot71A=
X-Received: by 2002:a2e:3c0e:0:b0:2b6:cdfb:d06a with SMTP id
 j14-20020a2e3c0e000000b002b6cdfbd06amr3776757lja.22.1690944928377; Tue, 01
 Aug 2023 19:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com>
 <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com>
 <CAADnVQ+O0CZQ1-5+dBiPWgZig3MVRX92PWPwNCrL7rG+4Xrbag@mail.gmail.com> <CACsn0cmvuGBKd3erDQKugygZfhT-Cu8xYBJ3hCETp6a-1HNbYw@mail.gmail.com>
In-Reply-To: <CACsn0cmvuGBKd3erDQKugygZfhT-Cu8xYBJ3hCETp6a-1HNbYw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Aug 2023 19:55:17 -0700
Message-ID: <CAADnVQK8sGGA8dwFDH6bJMWv56_s8gzj0yUY5OvMQKiL6d8YHA@mail.gmail.com>
Subject: Re: [Bpf] Review of draft-thaler-bpf-isa-01
To: Watson Ladd <watsonbladd@gmail.com>
Cc: Dave Thaler <dthaler@microsoft.com>, "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 7:34=E2=80=AFPM Watson Ladd <watsonbladd@gmail.com> =
wrote:
>
> In reply to a long conversation:
> <snip>
> >
> > Could you please be specific which instruction in table 4 is not obviou=
s?
>
> The question isn't obvious, the question is unambigious, and C is not
> great for this. Maybe with a reference and some text it would get
> better.
> >
> > > >
> > > > > > The good news is I think this is very fixable although tedious.
> > > > > >
> > > > > > The other thornier issues are memory model etc. But the overall=
 structure seems good
> > > > > > and the document overall makes sense.
> > > >
> > > > What do you mean by "memory model" ?
> > > > Do you see a reference to it ? Please be specific.
> > >
> > > No, and that's the problem. Section 5.2 talks about atomic operations=
.
> > > I'd expect that to be paired with a description of barriers so that
> > > these work, or a big warning about when you need to use them.
> >
> > That's a good suggestion.
> > A warning paragraph that BPF ISA does not have barrier instructions
> > is necessary.
> >
> > > For
> > > clarity I'm pretty unfamiliar with bpf as a technology, and it's
> > > possible that with more knowledge this would make sense. On looking
> > > back on that I don't even know if the memory space is flat, or
> > > segmented: can I access maps through a value set to dst+offset, or
> > > must I always used index? I'm just very confused.
> >
> > flat vs segmented is an orthogonal topic.
> > We definitely need to cover it in the architecture doc.
> > BPF WG charter requires us to produce it as Informational doc eventuall=
y.
>
> Huh? If you access memory through specialized descriptors+offsets
> that's very different from arbitrary computations with addresses, even
> if they do trap. A little explanation might orient the reader to
> understand what is going on. As is I thought "ok, it's flat" and then
> saw the maps and really got thrown for a loop.

It's flat.

> >
> > As far as memory model BPF adopts LKMM (Linux Kernel Memory Model).
> > https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2020/p0124r7.html
> >
> > We can add a reference to it from BPF ISA doc, but since
> > there are no barrier instructions at the moment the memory model
> > statement would be premature.
> > The work on "BPF Memory Model" have been ongoing for quite some time.
> > For example see:
> > https://lpc.events/event/11/contributions/941/attachments/859/1667/bpf-=
memory-model.2020.09.22a.pdf
> >
> > BPF Memory Model is certainly an important topic, but out of scope for =
ISA.
>
> I expect that an ISA defines the semantics of the instructions. Which
> absolutely includes the memory model.  Now maybe we're envisioning a
> different splitting of this information, but I don't see how it can't
> be at a different level if you want to give the instructions
> semantics.

Please read the links above.
BPF ISA is not going to define TSO, dictate weak ordering or anything
like that. It follows Linux Kernel Memory Model which is closer to
C memory model than to what HW CPUs see as memory model.
It's unlikely that we will ever introduce explicit memory barrier
instructions. More likely they will be kfuncs that will map to smp_mb(),
dma_wmb(), and friends in kernel Documentation/memory-barriers.txt.
Analogies with HW ISAs are not applicable here.

