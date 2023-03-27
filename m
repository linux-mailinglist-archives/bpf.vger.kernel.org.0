Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7686CAABF
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 18:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjC0QgC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 12:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjC0QgB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 12:36:01 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B440B212A
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 09:35:58 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x3so38608173edb.10
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 09:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679934957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Zd34DvddUxGz/PmpNtFb4qGnDQflAbxMQW2XjR7uKE=;
        b=NyQeq9oqV2x5rGj785I6EtW0gFSNmNVruYX6Ok6rLQSCgHhKRHlftET44e3GUH2b6Z
         EetHpjsqEvYsZhL5Js4M4MdE+yZDMcxUFvHp3HG0AMrlHW0YIrgK9qsjf6H6eeSVKJBa
         GftRbQi7TIJ++s9g6WYdHDSxl9cduUjRQdirC0dc9xRn1wpm0pyBDNDtw58VBQSAig/K
         oNQHO3e1/s+ED8YXmm/gIJKYK1QlI0tDt2U/Zt/hYyWZ2H2CLKDrmiXxRh1UTRoKdaIn
         ktIlZHZ5/zdSrkDuWp8tfkVYQlT8dz8vpxCbGeoWnDEGD8WVB7niYI3r7lRrvtK/mzBB
         bNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679934957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Zd34DvddUxGz/PmpNtFb4qGnDQflAbxMQW2XjR7uKE=;
        b=TVfLFZm55prTUXufJCeevOgt5bvn8KoLxamSAEMG22wda7VmTZInVJHQms0F11vCN7
         T1Zf95gr6AccDQTj4K524MkxNzVWpWIM63uXrJDGLAnqXMn2x5HJxQH80kQ9NAzEWCkG
         0uy7+qm820bCo1tuR1ThR998lAHfB8nxegevfvibpgEEakz8VYtkpQK3X7NUz9QxeHge
         af+KQk6fxMFDtE5ohN9H9SBAbVeWDFSxnxpfDNwyARnZcwQzdFhb5cQ9bYLQVoFqcQyP
         AL65DqoQAK4mLEhU9EWMi3h3CSlBuGG9zee2ZyJ1uff8Sa6+27qBZgJVPey3WvC1+31b
         z/aQ==
X-Gm-Message-State: AAQBX9dLFkmX3OliImqV+Sec6ggo09UGsK44HklHdw52OY9D/ApcKwoU
        SPydFgegTPAB/x/+WvTVJDtpXXPdB3p+6lA3ag8=
X-Google-Smtp-Source: AKy350Zjz9iiQihx1pIDrHZDGMdlyypEFa+MEaFf1jJGNDhdpSaWgxBSPByKCXPj8kAPzBli+M0v3PXLekRvsFL5ujs=
X-Received: by 2002:a50:d694:0:b0:4fb:f19:883 with SMTP id r20-20020a50d694000000b004fb0f190883mr6395304edi.1.1679934956843;
 Mon, 27 Mar 2023 09:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230325025524.144043-1-eddyz87@gmail.com> <ZB5pFYZGnwNORSN9@google.com>
 <2ac4f6037719e25e3e8b726def6ece2907d785f0.camel@gmail.com>
 <CAKH8qBv9vYZsMFivzJ9s=i_w-RakGqECfwXBZfWnDigi6oP1EQ@mail.gmail.com>
 <CAADnVQL5O4FaDDOUn0q1urfhquek4dE9nrhWa7mVYwvMhi311A@mail.gmail.com>
 <CAEf4BzbbgLg3w5ySX8XxBHBR0gzr71XPvJ5s1Tw=A6ScA6Vmwg@mail.gmail.com> <CAADnVQJRDfM=iofPZF2QLPzuxYjBQLMmm1dU25xMcEueEfaNoA@mail.gmail.com>
In-Reply-To: <CAADnVQJRDfM=iofPZF2QLPzuxYjBQLMmm1dU25xMcEueEfaNoA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Mar 2023 09:35:44 -0700
Message-ID: <CAEf4BzaYEpqNG_trRL=LOKBi7txBdWefLO-aktTb2Gb=1K1wDQ@mail.gmail.com>
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

On Sun, Mar 26, 2023 at 8:57=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Mar 26, 2023 at 8:16=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sat, Mar 25, 2023 at 6:19=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Sat, Mar 25, 2023 at 9:16=E2=80=AFAM Stanislav Fomichev <sdf@googl=
e.com> wrote:
> > > >
> > > > >
> > > > > It was my understanding from the RFC feedback that this "lighter"=
 way
> > > > > is preferable and we already have some tests written like that.
> > > > > Don't have a strong opinion on this topic.
> > > >
> > > > Ack, I'm obviously losing a bunch of context here :-(
> > > > I like coalescing better, but if the original suggestion was to use
> > > > this lighter way, I'll keep that in mind while reviewing.
> > >
> > > I still prefer the clean look of the tests, so I've applied this set.
> > >
> > > But I'm not going to insist that this is the only style developers
> > > should use moving forward.
> > > Whoever prefers "" style can use it in the future tests.
> >
> > Great, because I found out in practice that inability to add comments
> > to the manually written asm code is a pretty big limitation.
>
> What do you mean by "inability" ?
> The comments can be added. See verifier_and.c
>         r0 &=3D 0xFFFF1234;                               \
>         /* Upper bits are unknown but AND above masks out 1 zero'ing
> lower bits */\
>         if w0 < 1 goto l0_%=3D;                           \

My bad. I remembered that there were problems with comments in Eduards
previous revision and concluded that they don't work in this
"\-delimited mode". Especially that online documentation for GCC or
Clang didn't explicitly say that they support /* */ comments in asm
blocks (as far as I could google that).

So now I know it's possible, thanks. I still find it very tedious to
do manually, so I appreciate the flexibility in allowing to do
""-delimited style for new programs.

Just to explain where I'm coming from. I took one asm program I have
locally and converted it to a new style. It was tedious with all the
tab alignment. Then I realized that one comment block uses too long
lines and wanted to use vim to reformat them, and that doesn't work
with those '\' delimiters at the end (I didn't have such a problem
with the original style). So that turned into more tedious work. So
for something that needs iteration and adjustments, ""-delimited style
gives more flexibility. See below for reference.

'#' comments are dangerous, btw, they silently ignore everything till
the very end of asm block. No warning or error, just wrong and
incomplete asm is generated, unfortunately.


SEC("?raw_tp")
__failure __log_level(2)
__msg("XXX")
__naked int subprog_result_precise(void)
{
        asm volatile (
                "r6 =3D 3;"
                /* pass r6 through r1 into subprog to get it back as r0;
                 * this whole chain will have to be marked as precise later
                 */
                "r1 =3D r6;"
                "call identity_subprog;"
                /* now use subprog's returned value (which is a
                 * r6 -> r1 -> r0 chain), as index into vals array, forcing
                 * all of that to be known precisely
                 */
                "r0 *=3D 4;"
                "r1 =3D %[vals];"
                "r1 +=3D r0;"
                /* here r0->r1->r6 chain is forced to be precise and has to=
 be
                 * propagated back to the beginning, including through the
                 * subprog call
                 */
                "r0 =3D *(u32 *)(r1 + 0);"
                "exit;"
                :
                : __imm_ptr(vals)
                : __clobber_common, "r6"
        );
}

SEC("?raw_tp")
__failure __log_level(2)
__msg("XXX")
__naked int subprog_result_precise2(void)
{
        asm volatile ("
         \
                r6 =3D 3;
         \
                /* pass r6 through r1 into subprog to get it back as
r0;        \
                 * this whole chain will have to be marked as precise
later     \
                 */
         \
                r1 =3D r6;
         \
                call identity_subprog;
         \
                /* now use subprog's returned value (which is a
         \
                 * r6 -> r1 -> r0 chain), as index into vals array,
forcing     \
                 * all of that to be known precisely
         \
                 */
         \
                r0 *=3D 4;
         \
                r1 =3D %[vals];
         \
                r1 +=3D r0;
         \
                /* here r0->r1->r6 chain is forced to be precise and
has to be  \
                 * propagated back to the beginning, including through
the      \
                 * subprog call
         \
                 */
         \
                r0 =3D *(u32 *)(r1 + 0);
         \
                exit;
         \
                "
                :
                : __imm_ptr(vals)
                : __clobber_common, "r6"
        );
}
