Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA15636C77
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 22:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbiKWViX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 16:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbiKWViW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 16:38:22 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF6B2717E;
        Wed, 23 Nov 2022 13:38:21 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id l24so81781edj.8;
        Wed, 23 Nov 2022 13:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCvBTJO2gbYZhcCuljQv2b50zZ/3wvAu6KPvZevAXi8=;
        b=QROKYGkeQv6MtC6IUDzEOTrXB5C9bMSSN1eK8fjYM8gNFcTgfP95pkgnTj2u2Nm+KF
         pOAVZFdHSG3ARAOBf8UxO4+VwrFOk75tCSJnyT1Gn8pK/cp+5yYg10qYiD+GH86AiMHg
         hijGs0ksGMwklQwPy6nvcx5z7JzagGNvK+Q1f50/qhwWcxwHOvPJGrgv/MLLtBn2olGd
         i3vr0FI7WIwCGGdrVepHe/7DcSiWj7GPkaihmo7upqODFBxG+Y42jKU3lGPwq+JGqCmg
         /TYvCkBgJA8H9LPZ/eDbGQvXlZVZPN0WYRDTIKJPNKqJiHtFhLVkZRdtwXfx1bU3Q/TC
         6uGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCvBTJO2gbYZhcCuljQv2b50zZ/3wvAu6KPvZevAXi8=;
        b=sZbigb93uP7MeX2ugFcs8ILo4x6EPxxe+31Z4NuAtQj7dd+Dxl/BrI7hQsUk78Sinc
         jzYmfooV5xJBevEyqdbBzH/KVimW9jlEk1JBREGcqM07+Hb2n/y7WnH1bLH/MlHekLV8
         JRHID8pAfGMoqPSQEEtRU4avIL6JHECVpxLzN0xibEdpOur9nKIIVh4jL/TuQVD7NOVV
         TsdsJ2apxjVLdzcXc1IyFxZvRefYmRG90wvBAYU6ZQedGJRBs8Aib3HLyCCNXk/zaTct
         Jo9Vn/aXrCXb6h71BL+wdOjmXHNVVxlYAfMTh8BUaSjj37JXGb6x/PcDnVGag3aJkock
         qKGg==
X-Gm-Message-State: ANoB5pmIx8PNtJPA6E4SagP+iB+qPaYYRLrMtxbh7ma/KQLRhtaDz9uJ
        W1TYLCpGRekbxs72dXsfPw8Q/DKapzlQN5sGvbA=
X-Google-Smtp-Source: AA0mqf56UReYxybYO9VN+9QRSFdwHtn/Udxe9J3TWYXL4eMaOqC66mwLfglqqi3C1FUFm7m4H2SlH3N/2H1isHzQ5aI=
X-Received: by 2002:aa7:d3c9:0:b0:459:aa70:d4b6 with SMTP id
 o9-20020aa7d3c9000000b00459aa70d4b6mr27419688edr.224.1669239499708; Wed, 23
 Nov 2022 13:38:19 -0800 (PST)
MIME-Version: 1.0
References: <20221116064631.16224-1-tegongkang@gmail.com> <CAEf4BzbqKRTzTdhD1Vt-j8NXaqnyqXCRjNgMe9_h56rbt4a9YA@mail.gmail.com>
 <CA+uqrQD58fJj_h1D6kEQKYPF8mRizgf0R7KTfa5YWNTLcu9xqw@mail.gmail.com>
In-Reply-To: <CA+uqrQD58fJj_h1D6kEQKYPF8mRizgf0R7KTfa5YWNTLcu9xqw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 23 Nov 2022 13:38:07 -0800
Message-ID: <CAEf4BzbpkhTGF8dz4kUO-y9=1BbL_=PPbEX-qVEzw5NWn_prRg@mail.gmail.com>
Subject: Re: [PATCH] samples, bpf: Add duration option D for sampleip
To:     Kang Minchul <tegongkang@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 19, 2022 at 8:06 AM Kang Minchul <tegongkang@gmail.com> wrote:
>
> Thanks for your reply.
>
> 2022=EB=85=84 11=EC=9B=94 18=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 8:26=
, Andrii Nakryiko <andrii.nakryiko@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=
=EC=84=B1:
> >
> > On Tue, Nov 15, 2022 at 10:46 PM Kang Minchul <tegongkang@gmail.com> wr=
ote:
> > >
> > > Although sampleip program can handle three options,
> > > (-F for frequency, duration, and -h for help)
> > > currently there is no independent option for duration.
> >
> > Because it's positional argument, which is very clearly documented by
> > usage(). What's wrong with that and why do you want to change this?
> Yes, but I'm not sure why only 'duration' should be a positional argument=
.
>
> I don't think it is 'wrong', but I think it's better to treat
> 'duration' just as same as 'frequency' because
>  frequency and duration are two independent things in this case.
> (duration is not dependent on frequency)
>
> So I thought making an option for duration like below
>
> $ sudo ./samples/bpf/sampleip -F <Frequecny> -D <Duration>
>
> is better than below.
>
> $ sudo ./samples/bpf/sampleip -F <Frequecny> <Duration>
>
> I am not insisting strongly on this, so if I have misunderstood something=
,
> I'll respect the existing way.
>

I think it's just a common convention (e.g., iostat has the similar
approach). Let's keep it as is.


> Regards,
>
> Kang Minchul
> > >
> > > This patch adds option -D for duration like below:
> > >
> > > $ sudo ./samples/bpf/sampleip -h
> > > USAGE: sampleip [-F freq] [-D duration]
> > >        -F freq       # sample frequency (Hertz), default 99
> > >        -D duration   # sampling duration (seconds), default 5
> > >
> > > $ sudo ./samples/bpf/sampleip -F 120
> > > Sampling at 120 Hertz for 5 seconds. Ctrl-C also ends.
> > > ADDR                KSYM                          COUNT
> > > ...
> > >
> > > $ sudo ./samples/bpf/sampleip -D 7
> > > Sampling at 99 Hertz for 7 seconds. Ctrl-C also ends.
> > > ADDR                KSYM                          COUNT
> > > ...
> > >
> > > $ sudo ./samples/bpf/sampleip -F 120 -D 7
> > > Sampling at 120 Hertz for 7 seconds. Ctrl-C also ends.
> > > ADDR                KSYM                          COUNT
> > > ...
> > >
> > > Signed-off-by: Kang Minchul <tegongkang@gmail.com>
> > > ---
> > >  samples/bpf/sampleip_user.c | 13 +++++++------
> > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/samples/bpf/sampleip_user.c b/samples/bpf/sampleip_user.=
c
> > > index 921c505bb567..ce6aadd496e1 100644
> > > --- a/samples/bpf/sampleip_user.c
> > > +++ b/samples/bpf/sampleip_user.c
> > > @@ -28,9 +28,9 @@ static int nr_cpus;
> > >
> > >  static void usage(void)
> > >  {
> > > -       printf("USAGE: sampleip [-F freq] [duration]\n");
> > > -       printf("       -F freq    # sample frequency (Hertz), default=
 99\n");
> > > -       printf("       duration   # sampling duration (seconds), defa=
ult 5\n");
> > > +       printf("USAGE: sampleip [-F freq] [-D duration]\n");
> > > +       printf("       -F freq       # sample frequency (Hertz), defa=
ult 99\n");
> > > +       printf("       -D duration   # sampling duration (seconds), d=
efault 5\n");
> > >  }
> > >
> > >  static int sampling_start(int freq, struct bpf_program *prog,
> > > @@ -145,19 +145,20 @@ int main(int argc, char **argv)
> > >         char filename[256];
> > >
> > >         /* process arguments */
> > > -       while ((opt =3D getopt(argc, argv, "F:h")) !=3D -1) {
> > > +       while ((opt =3D getopt(argc, argv, "F:D:h")) !=3D -1) {
> > >                 switch (opt) {
> > >                 case 'F':
> > >                         freq =3D atoi(optarg);
> > >                         break;
> > > +               case 'D':
> > > +                       secs =3D atoi(optarg);
> > > +                       break;
> > >                 case 'h':
> > >                 default:
> > >                         usage();
> > >                         return 0;
> > >                 }
> > >         }
> > > -       if (argc - optind =3D=3D 1)
> > > -               secs =3D atoi(argv[optind]);
> > >         if (freq =3D=3D 0 || secs =3D=3D 0) {
> > >                 usage();
> > >                 return 1;
> > > --
> > > 2.34.1
> > >
