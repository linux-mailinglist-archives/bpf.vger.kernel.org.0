Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD996CAAC3
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 18:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjC0Qh2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 12:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjC0Qh1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 12:37:27 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C84712F
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 09:37:26 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id cn12so38746783edb.4
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679935044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5t5zMSRGbQHhZ8q/3usq8cN2HUj3pSW/qvpP7vczfo=;
        b=XY/pFWnv1vdtZqe6Nc5s/qs8ZY76gvX3tmAMct3u19EDIYeT2tZ+Yg0kFCkFIkIK8k
         3lxmqVJmSPxRN/UvMkbYN/YE97ZQr7r33FlRCTxtGbcJIEucFYKAcXcNeNUeeEcGzDFW
         H+AyTGp212QSNdofFu7yBAyTBciv7Sib/P87rCyC844RF6OGFE2DPoVuO6XFMBH4BcC7
         vAwhyqWLd+I/NMTWGhxXLJP5f035t8TjV/IcjaSOmcOidE7KWQR3DoTVcQhhPniE9eNG
         8NdSnv2/IYcVaFO3LYpWQvcshzs6ryAG232ALvoKp5TjgynvHYorlQ5TiG53Rj0+47CM
         HUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679935044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5t5zMSRGbQHhZ8q/3usq8cN2HUj3pSW/qvpP7vczfo=;
        b=jrIFlflCB2CISJChLMdQGz/P8lS8yEtiSgoFNseHpK9Vky0ONuUU2ttIAPJdZz8WsH
         SwKbz0k+TxRiRgGWGx+51SyVPyJ/7NW49EQXhSGNTmbWRtF7OLpeGf2/7B8wVy2tiZ4V
         20ldwFH/KagmYbP3kSQmKfDCVvkDhcgonDuZM5IJRyWtEJqijNNu1IMYNrOQx0MuLgZv
         OJEOC+W+s6F50+WhvH0PzHS1mjk4v1jHwYliAdxUq9bJ/E/226kqNNIoE6FGTlj5Lq8b
         jiZnhsUoz1cNw8d/ir7XzAGYTDbrqdq9O7CcpkmIlKUFhC/4LrM0c4+dIrUDFSx0Z3MP
         nIRQ==
X-Gm-Message-State: AAQBX9eIn0RiGzbIRgea0XxfGBG9myDzzhy1QD5RpSUt5MJly8nruEEA
        HfdrBXo1c6wgE+8gCqg6y1oF3Un0iVUWPZI4h2A=
X-Google-Smtp-Source: AKy350Z0TP+lA4ECNuKU6HVR8VM9NE8ak+D4h12GTX815zle5KRvHCiFYKOZMZF1erA7F/JDPori6PtO80JtSmcxp7o=
X-Received: by 2002:a17:906:c357:b0:932:4255:5908 with SMTP id
 ci23-20020a170906c35700b0093242555908mr5870055ejb.5.1679935044515; Mon, 27
 Mar 2023 09:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230325025524.144043-1-eddyz87@gmail.com> <ZB5pFYZGnwNORSN9@google.com>
 <2ac4f6037719e25e3e8b726def6ece2907d785f0.camel@gmail.com>
 <CAKH8qBv9vYZsMFivzJ9s=i_w-RakGqECfwXBZfWnDigi6oP1EQ@mail.gmail.com>
 <CAADnVQL5O4FaDDOUn0q1urfhquek4dE9nrhWa7mVYwvMhi311A@mail.gmail.com>
 <CAEf4BzbbgLg3w5ySX8XxBHBR0gzr71XPvJ5s1Tw=A6ScA6Vmwg@mail.gmail.com>
 <CAADnVQJRDfM=iofPZF2QLPzuxYjBQLMmm1dU25xMcEueEfaNoA@mail.gmail.com> <CAEf4BzaYEpqNG_trRL=LOKBi7txBdWefLO-aktTb2Gb=1K1wDQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaYEpqNG_trRL=LOKBi7txBdWefLO-aktTb2Gb=1K1wDQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Mar 2023 09:37:12 -0700
Message-ID: <CAEf4BzYhNcgFZEr8pcUJAtPubwRwRJhO=VXBOAnYRntnnUfGtA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/43] First set of verifier/*.c migrated to
 inline assembly
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 27, 2023 at 9:35=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Mar 26, 2023 at 8:57=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sun, Mar 26, 2023 at 8:16=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Sat, Mar 25, 2023 at 6:19=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Sat, Mar 25, 2023 at 9:16=E2=80=AFAM Stanislav Fomichev <sdf@goo=
gle.com> wrote:
> > > > >
> > > > > >
> > > > > > It was my understanding from the RFC feedback that this "lighte=
r" way
> > > > > > is preferable and we already have some tests written like that.
> > > > > > Don't have a strong opinion on this topic.
> > > > >
> > > > > Ack, I'm obviously losing a bunch of context here :-(
> > > > > I like coalescing better, but if the original suggestion was to u=
se
> > > > > this lighter way, I'll keep that in mind while reviewing.
> > > >
> > > > I still prefer the clean look of the tests, so I've applied this se=
t.
> > > >
> > > > But I'm not going to insist that this is the only style developers
> > > > should use moving forward.
> > > > Whoever prefers "" style can use it in the future tests.
> > >
> > > Great, because I found out in practice that inability to add comments
> > > to the manually written asm code is a pretty big limitation.
> >
> > What do you mean by "inability" ?
> > The comments can be added. See verifier_and.c
> >         r0 &=3D 0xFFFF1234;                               \
> >         /* Upper bits are unknown but AND above masks out 1 zero'ing
> > lower bits */\
> >         if w0 < 1 goto l0_%=3D;                           \
>
> My bad. I remembered that there were problems with comments in Eduards
> previous revision and concluded that they don't work in this
> "\-delimited mode". Especially that online documentation for GCC or
> Clang didn't explicitly say that they support /* */ comments in asm
> blocks (as far as I could google that).
>
> So now I know it's possible, thanks. I still find it very tedious to
> do manually, so I appreciate the flexibility in allowing to do
> ""-delimited style for new programs.
>
> Just to explain where I'm coming from. I took one asm program I have
> locally and converted it to a new style. It was tedious with all the
> tab alignment. Then I realized that one comment block uses too long
> lines and wanted to use vim to reformat them, and that doesn't work
> with those '\' delimiters at the end (I didn't have such a problem
> with the original style). So that turned into more tedious work. So
> for something that needs iteration and adjustments, ""-delimited style
> gives more flexibility. See below for reference.
>
> '#' comments are dangerous, btw, they silently ignore everything till
> the very end of asm block. No warning or error, just wrong and
> incomplete asm is generated, unfortunately.
>
>
> SEC("?raw_tp")
> __failure __log_level(2)
> __msg("XXX")
> __naked int subprog_result_precise(void)
> {
>         asm volatile (
>                 "r6 =3D 3;"
>                 /* pass r6 through r1 into subprog to get it back as r0;
>                  * this whole chain will have to be marked as precise lat=
er
>                  */
>                 "r1 =3D r6;"
>                 "call identity_subprog;"
>                 /* now use subprog's returned value (which is a
>                  * r6 -> r1 -> r0 chain), as index into vals array, forci=
ng
>                  * all of that to be known precisely
>                  */
>                 "r0 *=3D 4;"
>                 "r1 =3D %[vals];"
>                 "r1 +=3D r0;"
>                 /* here r0->r1->r6 chain is forced to be precise and has =
to be
>                  * propagated back to the beginning, including through th=
e
>                  * subprog call
>                  */
>                 "r0 =3D *(u32 *)(r1 + 0);"
>                 "exit;"
>                 :
>                 : __imm_ptr(vals)
>                 : __clobber_common, "r6"
>         );
> }
>
> SEC("?raw_tp")
> __failure __log_level(2)
> __msg("XXX")
> __naked int subprog_result_precise2(void)
> {
>         asm volatile ("
>          \
>                 r6 =3D 3;
>          \
>                 /* pass r6 through r1 into subprog to get it back as
> r0;        \
>                  * this whole chain will have to be marked as precise
> later     \
>                  */
>          \
>                 r1 =3D r6;
>          \
>                 call identity_subprog;
>          \
>                 /* now use subprog's returned value (which is a
>          \
>                  * r6 -> r1 -> r0 chain), as index into vals array,
> forcing     \
>                  * all of that to be known precisely
>          \
>                  */
>          \
>                 r0 *=3D 4;
>          \
>                 r1 =3D %[vals];
>          \
>                 r1 +=3D r0;
>          \
>                 /* here r0->r1->r6 chain is forced to be precise and
> has to be  \
>                  * propagated back to the beginning, including through
> the      \
>                  * subprog call
>          \
>                  */
>          \
>                 r0 =3D *(u32 *)(r1 + 0);
>          \
>                 exit;
>          \

Great, Gmail doesn't like this style as well :( Sorry for the visual noise.
>                 "
>                 :
>                 : __imm_ptr(vals)
>                 : __clobber_common, "r6"
>         );
> }
