Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE446A71DE
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 18:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCARMV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 12:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCARMU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 12:12:20 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DA639CE5
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 09:12:18 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cw28so7591617edb.5
        for <bpf@vger.kernel.org>; Wed, 01 Mar 2023 09:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677690737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eR3bY1/0f1pgiBB7MSj7GTnyQ5BlMMVnFcmGK87QazQ=;
        b=Qr9RF0TuQ1xptFjnh7xKj847FfFPTeHw/cE34rJkC3useLFUpDdlA9+KIhpm6LU0TY
         ePTUXvJBkhMParzieUJ5Ttvh+IXfqIIdKrk1pFgooUoXTC4yEgj7QFPl7wM+pd0Yc6Na
         dQKvMGBrqjDItzHIU++BvBJAPOZmjyfq4FXIH6YRbnSG0rV2iL+2qC1hfV+MpbhKlL2h
         Csv8oR8MBMMhcaPESreOpi9XCKffJqIVH8MbGMYFCZWSokd71FT/fjT59rddhtDRaoOv
         DqjxpyHmeAoJ214Z2ecB8rN7HbqrhH6yrvBXNOHBnM36Fw/6BzMejIV4a8VNlOZ1Yjzw
         fRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677690737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eR3bY1/0f1pgiBB7MSj7GTnyQ5BlMMVnFcmGK87QazQ=;
        b=DtvPjStxTRLaVPcghW11pwnxeDQ2NKOm0CVDCK/uJQ2bfmAw2haA3qb3RBWMQ9WNTh
         oMpIrhgyFhcivyz30J0vz+eaU6VB58JvCjPg5pNziU/0/Oc8R0wktgb6SWv3yj1yQgI3
         t1FMwFR2LDkdSc5D7pm913Jpex9TNGdLao56RFwXWlO81mDb7Bts4DCOVUU0a5krh8P/
         GGJr2RZwXSQqlBMABtXrJgrM0rHJfGnQ+hpg3tsz/r1RssSAvo1V9mzuI22CNhdlBVXP
         bYqLfklMv6eZmX8GE3arMQXTIScxUwmFvF5xKizYYqB2ifKkUmn7+EOxGdTEGAR9WRU6
         0XZw==
X-Gm-Message-State: AO0yUKW1vObSNFMJqhkN2yJItpw0IOVZUUcWq96cpqYxYoQ6wzo2BoUH
        gAu53/fmUV894KqcwBcfk6FUZ1IQG3bDLReU5po=
X-Google-Smtp-Source: AK7set/rJ6ekRZmPFnDwdjD33fPUAO/XdBM3iPrr069pcqhWGahCKUsKshFHLgfl3tx97dUFs+Md9EYMC8S/kQXOmYc=
X-Received: by 2002:a50:d0c2:0:b0:4ac:b626:378e with SMTP id
 g2-20020a50d0c2000000b004acb626378emr4305199edf.5.1677690737176; Wed, 01 Mar
 2023 09:12:17 -0800 (PST)
MIME-Version: 1.0
References: <20230123145148.2791939-1-eddyz87@gmail.com> <20230123145148.2791939-2-eddyz87@gmail.com>
 <CAEf4BzZ-9iHzotYj2K3a+USFsxmqLEA+pHm4Ot6Nr2WtZ-AHeA@mail.gmail.com> <06e29b322d777c30fe9b163f9d13f11503a303d9.camel@gmail.com>
In-Reply-To: <06e29b322d777c30fe9b163f9d13f11503a303d9.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 1 Mar 2023 09:12:04 -0800
Message-ID: <CAEf4BzbiA48Q5ODREyHXKKKO7oms_LnE6q77=T9sroZkCefVgQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 1/5] selftests/bpf: support custom per-test flags
 and multiple expected messages
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
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

On Tue, Feb 28, 2023 at 2:30=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2023-02-28 at 10:53 -0800, Andrii Nakryiko wrote:
> > On Mon, Jan 23, 2023 at 6:52=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > From: Andrii Nakryiko <andrii@kernel.org>
> > >
> > > Extend __flag attribute by allowing to specify one of the following:
> > >  * BPF_F_STRICT_ALIGNMENT
> > >  * BPF_F_ANY_ALIGNMENT
> > >  * BPF_F_TEST_RND_HI32
> > >  * BPF_F_TEST_STATE_FREQ
> > >  * BPF_F_SLEEPABLE
> > >  * BPF_F_XDP_HAS_FRAGS
> > >  * Some numeric value
> > >
> > > Extend __msg attribute by allowing to specify multiple exepcted messa=
ges.
> > > All messages are expected to be present in the verifier log in the
> > > order of application.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > [ Eduard: added commit message, formatting ]
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> >
> > hey Eduard,
> >
> > When you get a chance, can you please send this patch separately from
> > the rest of the test_verifier rework patch set (it probably makes
> > sense to also add #define __flags in this patch as well, given you are
> > parsing its definition in this patch).
> >
> > This would great help me with my work that uses all this
> > assembly-level test facilities. Thanks!
>
> Hi Andrii,
>
> Rebase didn't change anything in the patch, I added __flags macro,
> some some comments, and started the CI job: [1].
>
> Feels weird to post it, tbh, because it's 100% your code w/o added
> value from my side.

you took the effort to prepare it for submission, testing, and
integrating into your work, so feels well deserved


>
> Thanks,
> Eduard
>
> [1] https://github.com/kernel-patches/bpf/pull/4688

apart from test flakiness, looks good, please send a patch "officially"

> >
> >
> >
> > >  tools/testing/selftests/bpf/test_loader.c | 69 ++++++++++++++++++++-=
--
> > >  tools/testing/selftests/bpf/test_progs.h  |  1 +
> > >  2 files changed, 61 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testin=
g/selftests/bpf/test_loader.c
> > > index 679efb3aa785..bf41390157bf 100644
> > > --- a/tools/testing/selftests/bpf/test_loader.c
> > > +++ b/tools/testing/selftests/bpf/test_loader.c
> > > @@ -13,12 +13,15 @@
> > >  #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
> > >  #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg=3D"
> > >  #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level=3D"
> > > +#define TEST_TAG_PROG_FLAGS_PFX "comment:test_prog_flags=3D"
> > >
> >
> > [...]
>
