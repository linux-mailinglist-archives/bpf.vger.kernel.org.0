Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2695247FD
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 10:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351519AbiELIh1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 04:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351595AbiELIhU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 04:37:20 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A5310EACB
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 01:37:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id j6so8676055ejc.13
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 01:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RiaiV9v8q8Y6DyuQdIEYCYHYfpsmh5X6kr/1iSv4xmc=;
        b=gXbv2cGF8wyTgQrjApbOlAbj3AbV9OjOhEecq0QhhJJSYwMkyuT5c/K39wkQViy0xQ
         Fg2jPWPKseNAPUbIHUhIaNdnGF7mNylLm5hj3WAe3ib19ytD91YMcb7wZX2aG8Mp8v1q
         Z17t3rBAaJwkFfFGCI5E+zjzPoXMgN6DzHrJjkkuJAXhQdDKdBj0mnHXOZGWMISvopw3
         OTQHB5XjrHhECdFca5LuOascBgnLblMZtmO/BZd4nlZj8gsqtO0hSwIeJABKv4xMuQVv
         MV1vR2FR/fJIl8iIwY5/Usiy97GYqdGI1zDA6OYIii3RLZ8OK65GUPN794XwGd01Gv3q
         cPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RiaiV9v8q8Y6DyuQdIEYCYHYfpsmh5X6kr/1iSv4xmc=;
        b=SrnxbfmsVeVxjNX37uh1Na80hF3zIrag4f5Ck84gblaVvIrsdCQZtjiA9DbTDyz5cu
         3Nqo2uKImp3VyBpqZFDso1Joq66obBXa5HCD7G/NBr8GZ5ZC4U03pSYzD15Qh1+oNsZH
         j9Du6sXIUM0p8S70NXu2+GETM77N3bS+qJgNndGJjUZtUrlpey4bvY/4+3w4n28PuPkj
         Oaz/J1nuhbNuWfIJ9UFRX8XYgoihwQ6ru/atC0lNKFrmz5H5IsQaOkWavFfXNZla8HtE
         N15MbACyIDZf08G0aUHHLW98EKensXOMuSTbnnjRbyHc60JRHGTwJzzzUUnNDNENvQMH
         4WgQ==
X-Gm-Message-State: AOAM530keIJIEz3CtjWNeQoK/QkFpGxZbHbmlnvVdYVN0yi7I5s/CI2z
        u7wbT5w2b5rBM9LwItJvdYfvoGGdF4XirQNnxG8=
X-Google-Smtp-Source: ABdhPJzmcZKKneaFoK4xx3cOcziZ6uxnFrdM84fuc7gXUECqm+3iliwhzx6tPb2kzKwtINRTJy6W+thGWDm9RtctvdE=
X-Received: by 2002:a17:907:3e03:b0:6da:8c5a:6d4a with SMTP id
 hp3-20020a1709073e0300b006da8c5a6d4amr29566585ejc.585.1652344629335; Thu, 12
 May 2022 01:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAN9vWDLY24LEY-zhBSNVRTPBqbYQd+D62av0jKK_BqMvwt5-ig@mail.gmail.com>
 <CAEf4Bza6Ks-FGAGkLCGhK1KEDRdtqv==y7nN63KejF829XQtfA@mail.gmail.com>
 <CAN9vWD+6SBQtQqxZ__bvqJ8MsrOUr4cfQcU99at1XVPSUiOsmw@mail.gmail.com>
 <CAEf4BzYtkLX8cYGC9rAnDyMBrQ8uHmgA8T8+nZ6dJe3c1X+73w@mail.gmail.com>
 <CAN9vWDJHrYUVFtBU-cAz6trvJAx903hGgO2Yj6=3Bt2CjS61Yg@mail.gmail.com> <87czgji43i.fsf@toke.dk>
In-Reply-To: <87czgji43i.fsf@toke.dk>
From:   Michael Zimmermann <sigmaepsilon92@gmail.com>
Date:   Thu, 12 May 2022 10:36:57 +0200
Message-ID: <CAN9vWDLd43B-_PLAWj-6Fr8-W6m=Scn_zNdOnJHALDdrDPM4og@mail.gmail.com>
Subject: Re: BPF maps don't work without CONFIG_TRACING/CONFIG_FTRACE
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 12, 2022 at 9:48 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@kern=
el.org> wrote:
>
> Michael Zimmermann <sigmaepsilon92@gmail.com> writes:
>
> > On Thu, May 12, 2022 at 5:21 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Mon, May 9, 2022 at 10:12 PM Michael Zimmermann
> >> <sigmaepsilon92@gmail.com> wrote:
> >> >
> >> > Thank you for your answer.
> >> > What I'm ultimately trying to do is: Use aya-rs to watch egress on a
> >> > network interface and notify userspace through a map (for certain IP=
s
> >> > only).
> >> >
> >> > In my actual use case, the userspace is supposed to do more complex
> >> > stuff but for testing I simply logged the receival of a message
> >> > through the BPF map on the console. And that is what I expect to
> >> > happen and which does happen as long as CONFIG_TRACING/CONFIG_FTRACE
> >> > are active. If not, I simply never receive any messages on any map.
> >> >
> >> > I've also tried this using an XDP program which sends a message ever=
y
> >> > time it sees a packet. And while the program seemed to be
> >> > working(since it did block certain traffic), I never saw any data in
> >> > the map when those configs were disabled.
> >> >
> >> > Also, I'm giving you two configs(tracing and ftrace) since the other
> >> > one seems to get y-selected automatically if one of them is active.
> >>
> >> Please don't top post, reply inline instead.
> > Sorry for that, GMail does that by default and even hides that it's
> > quoting at all.
> >
> >>
> >> I don't think we have enough to investigate here, even "receive any
> >> messages on any map" is so ambiguous that it's hard to even guess what
> >> you are really trying to do. BPF maps are not sending/receiving
> >> messages. So please provide some pieces of code and what you are doing
> >> to check. CONFIG_TRACING and CONFIG_FTRACE shouldn't have any effect
> >> on functioning of BPF maps, so it's most probably that you are doing
> >> something besides BPF map update/lookup, but you don't provide enough
> >> information to check anything.
> >
> > An aya project I tested where I don't receive any events:
> > https://github.com/aya-rs/book/tree/6b52a6fac5fa3e5a1165f98591b2eaff969=
2048a/examples/myapp-03
>
> It's using a PERF_EVENT_ARRAY map to send events to userspace. This
> requires CONFIG_BPF_EVENTS to work, which depends on CONFIG_PERF_EVENTS.
> Not sure if this depends on CONFIG_TRACING specifically, but maybe you
> disabled PERF_EVENTS as well?

PERF_EVENTS is enabled in both my working and my broken config.
But both directly and through others, BPF_EVENTS depends on FTRACE
(which then also selects TRACING).

So is this some weird dependency chain or expected behavior?
If it's expected, are there alternatives to achieve similar
functionality or do I have to convince my distro to enable tracing
support?

>
> -Toke
