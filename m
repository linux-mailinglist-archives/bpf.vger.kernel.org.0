Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727B7630F52
	for <lists+bpf@lfdr.de>; Sat, 19 Nov 2022 17:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiKSQGC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Nov 2022 11:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKSQGB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Nov 2022 11:06:01 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7967DCA7;
        Sat, 19 Nov 2022 08:06:00 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id t85so3801445vkb.7;
        Sat, 19 Nov 2022 08:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWPkDw+hBBRp3rjO9oe2TksMIp/JW3/H2HSRK6dyKIM=;
        b=SVQB/mCGGYALj1YQJ10ao7Wzmt5ehbGQ4xI2v36EENVSsxeopuhp/Yc6OrIqsYCS1i
         PY+CAdBnW80Bql13cG6Y8RPlfRlu1HmwtnMBmV086iWM9lK9xbM5eGSd8LUI7AVdGA/D
         TC7u+vWV2Wf6bUSw9UlZ6Tj8BSnn08ApfdKs2ECEuHw4FP+QZLJJxNArg3o6iSDtJzaT
         n3PKfUGM4nxXec5Ye5uZWc23de2CETCkDO1B1oxCr7MO9WwXkUmSUpcf/8vmjX5J0AB2
         +8nM8/VZZf54CuXdx0aCSn7pvoyiJwPSt5oE+UWeE+WLVi6U7vhmqUW47NqGZFoMdVI/
         mSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWPkDw+hBBRp3rjO9oe2TksMIp/JW3/H2HSRK6dyKIM=;
        b=TlTYI5LE2BNBJS+Qih7MjRxGtPFLeFOdhvAqYnKrA9QKeWu5gqIv+0/OCFqFXNkVzW
         aOi0EjtSJ8t5xcGTJ8c5k8gGuFUcH6Y7AW5MN+i7jquZoHnOY9DkcWyCmCrTpSXtIuoc
         E4FZC/zHqlrc5moLyAR8K0ZUhJmbhfL3lP38e6oWwusUxWfEmttHrZob9niAqVXWzmyE
         Aj24XqUo1dLXp9b7yMkMVowmuiEUBXkbg+vPNiB2sUxbcHb2klK295dSBSkSLq1ctwaX
         xiwHQxbIkHvVv/yO8Gof2evIJyTeucqevOKA1mNXwGSlyU6SPqskr0Ne5KzwLN2iifym
         3vfQ==
X-Gm-Message-State: ANoB5plMZ85kTxTT+QKCj7E1bk6SPbl9L+WWDFS4u95LdQVxcsgZDj3m
        5ai8mxRTQ1h/uZsnhNJlghN+FH0kWyH8Ojkz39eNdB1MmsmnRe9Z
X-Google-Smtp-Source: AA0mqf4m+RsMguRNAJ0q/NrRtt5cFBlw6tkewY/D1gPrM8dGZkegzclrpmbEumXydDm+Ht7Yvdt2HuJj682yY37VTk4=
X-Received: by 2002:a1f:21c8:0:b0:3b7:6a89:4530 with SMTP id
 h191-20020a1f21c8000000b003b76a894530mr816857vkh.37.1668873959512; Sat, 19
 Nov 2022 08:05:59 -0800 (PST)
MIME-Version: 1.0
References: <20221116064631.16224-1-tegongkang@gmail.com> <CAEf4BzbqKRTzTdhD1Vt-j8NXaqnyqXCRjNgMe9_h56rbt4a9YA@mail.gmail.com>
In-Reply-To: <CAEf4BzbqKRTzTdhD1Vt-j8NXaqnyqXCRjNgMe9_h56rbt4a9YA@mail.gmail.com>
From:   Kang Minchul <tegongkang@gmail.com>
Date:   Sun, 20 Nov 2022 01:05:48 +0900
Message-ID: <CA+uqrQD58fJj_h1D6kEQKYPF8mRizgf0R7KTfa5YWNTLcu9xqw@mail.gmail.com>
Subject: Re: [PATCH] samples, bpf: Add duration option D for sampleip
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

Thanks for your reply.

2022=EB=85=84 11=EC=9B=94 18=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 8:26, =
Andrii Nakryiko <andrii.nakryiko@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> On Tue, Nov 15, 2022 at 10:46 PM Kang Minchul <tegongkang@gmail.com> wrot=
e:
> >
> > Although sampleip program can handle three options,
> > (-F for frequency, duration, and -h for help)
> > currently there is no independent option for duration.
>
> Because it's positional argument, which is very clearly documented by
> usage(). What's wrong with that and why do you want to change this?
Yes, but I'm not sure why only 'duration' should be a positional argument.

I don't think it is 'wrong', but I think it's better to treat
'duration' just as same as 'frequency' because
 frequency and duration are two independent things in this case.
(duration is not dependent on frequency)

So I thought making an option for duration like below

$ sudo ./samples/bpf/sampleip -F <Frequecny> -D <Duration>

is better than below.

$ sudo ./samples/bpf/sampleip -F <Frequecny> <Duration>

I am not insisting strongly on this, so if I have misunderstood something,
I'll respect the existing way.

Regards,

Kang Minchul
> >
> > This patch adds option -D for duration like below:
> >
> > $ sudo ./samples/bpf/sampleip -h
> > USAGE: sampleip [-F freq] [-D duration]
> >        -F freq       # sample frequency (Hertz), default 99
> >        -D duration   # sampling duration (seconds), default 5
> >
> > $ sudo ./samples/bpf/sampleip -F 120
> > Sampling at 120 Hertz for 5 seconds. Ctrl-C also ends.
> > ADDR                KSYM                          COUNT
> > ...
> >
> > $ sudo ./samples/bpf/sampleip -D 7
> > Sampling at 99 Hertz for 7 seconds. Ctrl-C also ends.
> > ADDR                KSYM                          COUNT
> > ...
> >
> > $ sudo ./samples/bpf/sampleip -F 120 -D 7
> > Sampling at 120 Hertz for 7 seconds. Ctrl-C also ends.
> > ADDR                KSYM                          COUNT
> > ...
> >
> > Signed-off-by: Kang Minchul <tegongkang@gmail.com>
> > ---
> >  samples/bpf/sampleip_user.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/samples/bpf/sampleip_user.c b/samples/bpf/sampleip_user.c
> > index 921c505bb567..ce6aadd496e1 100644
> > --- a/samples/bpf/sampleip_user.c
> > +++ b/samples/bpf/sampleip_user.c
> > @@ -28,9 +28,9 @@ static int nr_cpus;
> >
> >  static void usage(void)
> >  {
> > -       printf("USAGE: sampleip [-F freq] [duration]\n");
> > -       printf("       -F freq    # sample frequency (Hertz), default 9=
9\n");
> > -       printf("       duration   # sampling duration (seconds), defaul=
t 5\n");
> > +       printf("USAGE: sampleip [-F freq] [-D duration]\n");
> > +       printf("       -F freq       # sample frequency (Hertz), defaul=
t 99\n");
> > +       printf("       -D duration   # sampling duration (seconds), def=
ault 5\n");
> >  }
> >
> >  static int sampling_start(int freq, struct bpf_program *prog,
> > @@ -145,19 +145,20 @@ int main(int argc, char **argv)
> >         char filename[256];
> >
> >         /* process arguments */
> > -       while ((opt =3D getopt(argc, argv, "F:h")) !=3D -1) {
> > +       while ((opt =3D getopt(argc, argv, "F:D:h")) !=3D -1) {
> >                 switch (opt) {
> >                 case 'F':
> >                         freq =3D atoi(optarg);
> >                         break;
> > +               case 'D':
> > +                       secs =3D atoi(optarg);
> > +                       break;
> >                 case 'h':
> >                 default:
> >                         usage();
> >                         return 0;
> >                 }
> >         }
> > -       if (argc - optind =3D=3D 1)
> > -               secs =3D atoi(argv[optind]);
> >         if (freq =3D=3D 0 || secs =3D=3D 0) {
> >                 usage();
> >                 return 1;
> > --
> > 2.34.1
> >
