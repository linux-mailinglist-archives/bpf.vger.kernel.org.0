Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAA86A71FF
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 18:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCARXX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 12:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCARXW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 12:23:22 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6345E23C66
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 09:23:21 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-536b7ffdd34so377060807b3.6
        for <bpf@vger.kernel.org>; Wed, 01 Mar 2023 09:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677691400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9bhfMvShZZhszVkq0Y3mZ6BpIqqQ9O1HqJyw3QchIE=;
        b=E6XvLZnYw9JmoMsSdlLMx0qkTfS+NqstElzkv0d/tDp3ZUslABjW5tbj1BLmCWugC4
         AeFtCoLsxUcit21IVIiPMUBuY3PJIv895w1hIF6Ce1+YLfw6Y1OBde8u9O80M1afrk2a
         7I0kSaL4qwL/4km0UF9tvJxPf3V0Cnpe02YgNNZnDZ71Kw7eM0ht/rDg5krA4TMQ/Umc
         UjGoK53eZjXobIlQNEykuYHA93D/pR/E3ut26BvplWAojDEykdEy0hsIadP9MMOdOeip
         qxssTFkI1UsI9GXCgpPw1FPTlxLstFq4FCU0g2es1ED6nJ9rqexSCYtQuf407lcVqrju
         xAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677691400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9bhfMvShZZhszVkq0Y3mZ6BpIqqQ9O1HqJyw3QchIE=;
        b=SpZonuEqg47sxYEJ0RpV/lq76xGR7rZYFeewGIxJOraYXB8dMIHEzgXHk8UqZejsul
         AqHoZeQeZ5RF/svELhjEpEjjoC4oILncKZGetglHxfXydWk1ZzC+ghVFGK5Pm5RY+zEv
         sl4/GbadeYoHISNjee2FgvRx5URyIoXoz0n35Sv3l99nhI2S9ulcAXHpKVf4oDSdJqrM
         FRNsAuG4oZkTw30i+ZqQOPumTlJP5AEIZnxtHy12dwOFCc5Hd8aLcek2V5by9cMpvFOO
         TvZRaAK79XeO5C/r0jpnCd3qcgeO9lXBELHxe8dPErDKwDqYocYeV9i+NdbcHyfguURb
         5AFQ==
X-Gm-Message-State: AO0yUKXqJD1PXt1Arw7UehgdXLGN1K8ESUgh4FJOm4/JowUsDi9BaP42
        ImIABtFu48bfCSGierBDPCpCPFX25qdPDK9cEZ8=
X-Google-Smtp-Source: AK7set/zdSTN8I2P7AqycdyNA/vySqJ5Exy2DDZuupAV6sO2DSv8Hk/iXBzJB9zEAVgTZYQ87OUKqndLosedXDs5dzQ=
X-Received: by 2002:a81:4410:0:b0:532:e887:2c32 with SMTP id
 r16-20020a814410000000b00532e8872c32mr4343745ywa.5.1677691398969; Wed, 01 Mar
 2023 09:23:18 -0800 (PST)
MIME-Version: 1.0
References: <20230217191908.1000004-1-deso@posteo.net> <20230217191908.1000004-4-deso@posteo.net>
 <CAEf4BzasONdYA6JPvF=pAjBW9hotVw34itVG3AoGRJV5pjERBA@mail.gmail.com>
 <20230221213655.zu7zl77damfzxeat@muellerd-fedora-PC2BDTX9>
 <CAEf4BzbwoAtQO6BWm1tBe51VE_BvS+mfVdcjC+uzi5s4A=L4-Q@mail.gmail.com> <20230228222331.vjmidio5f3l7afue@muellerd-fedora-PC2BDTX9>
In-Reply-To: <20230228222331.vjmidio5f3l7afue@muellerd-fedora-PC2BDTX9>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 1 Mar 2023 09:23:03 -0800
Message-ID: <CAEf4Bzbz2xEsp+Xt60Nb+m0o=W6xXn48_dBcUrNZb3qBpacPxw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] libbpf: Add support for attaching uprobes to
 shared objects in APKs
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
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

On Tue, Feb 28, 2023 at 2:23=E2=80=AFPM Daniel M=C3=BCller <deso@posteo.net=
> wrote:
>
> On Thu, Feb 23, 2023 at 04:18:28PM -0800, Andrii Nakryiko wrote:
> > On Tue, Feb 21, 2023 at 1:37 PM Daniel M=C3=BCller <deso@posteo.net> wr=
ote:
> > >
> > > On Fri, Feb 17, 2023 at 04:32:05PM -0800, Andrii Nakryiko wrote:
> > > > On Fri, Feb 17, 2023 at 11:19 AM Daniel M=C3=BCller <deso@posteo.ne=
t> wrote:
> > > > >
> > > > > This change adds support for attaching uprobes to shared objects =
located
> > > > > in APKs, which is relevant for Android systems where various libr=
aries
> > > >
> > > > Is there a good link with description of APK that we can record
> > > > somewhere in the comments for future us?
> > >
> > > Perhaps
> > > https://en.wikipedia.org/w/index.php?title=3DApk_(file_format)&oldid=
=3D1139099120#Package_contents.
> > >
> > > Will add it.
> > >
> > > > Also, does .apk contains only shared libraries, or it could be also
> > > > just a binary?
> > >
> > > It probably could also be for a binary, judging from applications bei=
ng
> > > available for download in the form of APKs.
> > >
> > > > > may reside in APKs. To make that happen, we extend the syntax for=
 the
> > > > > "binary path" argument to attach to with that supported by variou=
s
> > > > > Android tools:
> > > > >   <archive>!/<binary-in-archive>
> > > > >
> > > > > For example:
> > > > >   /system/app/test-app/test-app.apk!/lib/arm64-v8a/libc++_shared.=
so
> > > > >
> > > > > APKs need to be specified via full path, i.e., we do not attempt =
to
> > > > > resolve mere file names by searching system directories.
> > > >
> > > > mere?
> > >
> > > Yes?
> >
> > I'm just confused what "resolve mere file names" means in this
> > context. Like, which file names are not "mere"?
>
> It's meant to convey the fact that a "mere file name" is not everything w=
e could
> be dealing with. It could also be a full path.

Ah, ok, I see. So you are just saying that we do not attempt path
resolution like we do for .so and binaries. This wasn't clear to me.

>
> [...]
>
> Thanks,
> Daniel
