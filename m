Return-Path: <bpf+bounces-10243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F137A3F58
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 03:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DEC21C208B8
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 01:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293B315B6;
	Mon, 18 Sep 2023 01:56:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6441108
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 01:56:23 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39CCD2
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 18:56:20 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31fe2c8db0dso3413830f8f.3
        for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 18:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695002179; x=1695606979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTwsNKH+avQ7OW+zEjSIJpsUglDn0Oe6O4yUHTsYWYg=;
        b=PxghDeDQLJVWs2s2nv/yd0EvCWTsyv+ES5k2Dy9oJ5hmD++iZbfhhIbb6H/ZTYXjFK
         aYETZMpJZi069KjIcOb749/+z5J7NYifUuk77vqBXMorTxFllvFAi9fo7cBId0tGCRxQ
         J8y6hqzcM9OVZCyCzr0HB4CD7cPgIabRgTclEHFq4fudqteezqAnDsf+EJzxrOdjJP4n
         fx1osSwoN+kLe3hiN3N/vzOpO0x4ttR6ePjGm2k+jm+sN0oqK/kswnafQi2f2DA91FCK
         hna5sst9IJvz7MROmcogzf0ddSXQeH+RavPBSnTBa2/Hnp2HWNFE90l5bYJd0GD6KfzS
         gW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695002179; x=1695606979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTwsNKH+avQ7OW+zEjSIJpsUglDn0Oe6O4yUHTsYWYg=;
        b=ScHe6qJk+P8o81/YRwIUcZO+jCr3hzVHbYAKqGxbNXEHZjYA3pDb6XqEytC2HZM8wV
         3dwOEL7YY526/OUNMdZPIxEFlguoxLDu5e3tZ25Y1Dm7DC2UY6C6EmOirqH5DPulHxG5
         MDg8O2pZfb46h1D6jG9h1x9Bpt/cLr2umWBNYOvSpsnyenUs/jdi+38lqLLfxgxqc+w1
         Yn0dCvOuKfarcfUir1q22k51LaEc5AQVAgIS3WGPF6rSv46En9k8OaB/Drmxud+RBiU2
         ypJr0nNYIUDTbFunogChQbHzFkZxbu4W9rwKs8nDNwOR+Wy/PJ2A5MCXjPleDGqLB+xy
         YBXQ==
X-Gm-Message-State: AOJu0YwqUNXJshI8qf8D2O0jGJ36uzEVf/wmT6QZlQWMnU1dw779J8Wi
	0BF7tPEew5CBmXsJU4wI1EdJYaENcl5lpbhsORg=
X-Google-Smtp-Source: AGHT+IGUJMnUNITM7fTzIJEAQFGFFgecz3AmOgTeOE3vVed7aVlEOYRdtvCBH3yGWdiIzfddsUa35XKH7aqGHjKl7QA=
X-Received: by 2002:a05:6000:18a6:b0:321:4df5:b85e with SMTP id
 b6-20020a05600018a600b003214df5b85emr2076982wri.26.1695002178988; Sun, 17 Sep
 2023 18:56:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912233214.1518551-1-memxor@gmail.com> <20230912233214.1518551-13-memxor@gmail.com>
 <mb61pmsxq14h4.fsf@amazon.com> <CAP01T7691P9m4ZrDQk63waC9wGu3ToK-cznsHha-r6Lteh0fWw@mail.gmail.com>
 <CAADnVQK-DoX19C-rManYh2p99ixO7QKkd6NrvpaYuoRbco_ubA@mail.gmail.com>
 <CAP01T74ZG7q_=1=bbfk-5Q978dR7UN_zwch0KWYkZPObLNSy2Q@mail.gmail.com> <CAP01T746mMPhFp5=rJBLykAPOUrE96E=P7qFE6afHDTLJRQDog@mail.gmail.com>
In-Reply-To: <CAP01T746mMPhFp5=rJBLykAPOUrE96E=P7qFE6afHDTLJRQDog@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 17 Sep 2023 18:56:07 -0700
Message-ID: <CAADnVQLjGNu+PNdrtitv8ek=U1aqdF+VS3eODqf-b4uMy-DBZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 12/17] bpf: Disallow fentry/fexit/freplace for
 exception callbacks
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 16, 2023 at 12:35=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sat, 16 Sept 2023 at 19:30, Kumar Kartikeya Dwivedi <memxor@gmail.com>=
 wrote:
> >
> > On Sat, 16 Sept 2023 at 18:44, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Sep 14, 2023 at 5:13=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > > > >                       }
> > > > > > +                     if (aux->func && aux->func[subprog]->aux-=
>exception_cb) {
> > > > > > +                             bpf_log(log,
> > > > > > +                                     "Extension programs canno=
t replace exception callback\n");
> > > > > > +                             return -EINVAL;
> > > > > > +                     }
> > > > >
> > > > > This check is redundant because you already did this check above =
if (prog_extension branch)
> > > > > Remove this as it will never be reached.
> > > > >
> > > >
> > > > Good catch, will fix it in v4.
> > >
> > > No worries. I fixed this duplicate check while applying.
> > > Everything else can be addressed in the follow ups.
> > >
> > > This spam is a bit annoying:
> > > $ ./test_progs -t exceptions
> > > func#0 @0
> > > FENTRY/FEXIT programs cannot attach to exception callback
> > > processed 0 insns (limit 1000000) max_states_per_insn 0 total_states =
0
> > > peak_states 0 mark_read 0
> > >
> > > func#0 @0
> > > FENTRY/FEXIT programs cannot attach to exception callback
> > > processed 0 insns (limit 1000000) max_states_per_insn 0 total_states =
0
> > > peak_states 0 mark_read 0
> >
> > Thanks for fixing it while applying. I will send a follow up to
> > silence these logs today.
>
> For some reason, I don't seem to see these when just running
> ./test_progs -t exceptions.

That's odd. We need to debug the difference.
I definitely see them and I don't think my setup has anything special.
Would be good for others to confirm.

> I am not sure what I'm doing differently when running the selftests.
> A bit weird, but anyway, just guessing the cause, do you see them when
> you apply this?

Yep. The patch fixes it for me. Pls submit officially.

