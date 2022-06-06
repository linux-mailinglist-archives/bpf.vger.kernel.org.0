Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE1C53DF1A
	for <lists+bpf@lfdr.de>; Mon,  6 Jun 2022 02:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344616AbiFFA13 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Jun 2022 20:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241922AbiFFA12 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Jun 2022 20:27:28 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D76B1CE
        for <bpf@vger.kernel.org>; Sun,  5 Jun 2022 17:27:26 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s6so20902588lfo.13
        for <bpf@vger.kernel.org>; Sun, 05 Jun 2022 17:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9XGNkTBbD9HXSycAM7BUk1OJhbdzQoISFBweR5N1FKk=;
        b=Bur7jexyvmqWnKf5St/AOCx8WYTVKACOtjZGslxtUPq0DLCbafgaNP46oJfbaZ3LKp
         EAb5G/Sk4O6OtvWfStRrEagYUWqWaiRsWq6EO6CcRbP/fXmbOxi6A7SIAPksWJFgLt/7
         X67pngsjxNgS6S+/vz1euGzJ0GaCrfpsi0enH7ZCX8X0vnPtB4llRLSbSQjWgL5GNs5o
         5odUhp0Fy5T1FVVZAKTmpgsqga4eHPGnLqVDE/hO1vDHdwFqVtyv8CMVD3L6LJC2qTKM
         mSf1BNnldW4mC34M3ceiGC8aT43gdTgPYLCC4I9XPuRDm9OvZe4SfeVUvGi9S5bi16SO
         jBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9XGNkTBbD9HXSycAM7BUk1OJhbdzQoISFBweR5N1FKk=;
        b=r4PD5cRJeoGi8qQG72VRWN3ls5qhKPyLtqF254n+ToKt+YxlXfFMVPi9m2lkLugrUA
         pbcZpgxh88SaBeUskvXYuCZj7x6o6h/7dPjk74jEFBrkWxsFARWQtgi+/BnkwOQGyRFJ
         1bmXQ0RkDSLmfyC/kP96JQ339fk90oQT3WMsVa184KqkfLVEJisLHwXQG+TM5Z3yclFM
         at4qjILSx8gxYVcxeeOcqeSZ7LwtoedBt0JxOHHPFyEmNfQ5ZmTWo2ST9DoSHQHA88A2
         Gdr5DourAYqrysBtSJDjwS7YMtNWp05+MCqsU1aMrzdQyN+pajL2GP4WSWez/KTUOEPa
         YrbA==
X-Gm-Message-State: AOAM533LJCGyOM8+H0F4m+znsx/Ug0dgf00mFf3CIAisdqNpEWmAi3Nl
        6pas5zqrwiwzF8zDk1eRiB42fOTEewJLrA2bSGB6QuedzRI=
X-Google-Smtp-Source: ABdhPJwB+7iZsyiYHESU8sIz1g4wvzqmxfDacC5UsUUUAvDzK/mYWs7unE2ZEJQD8qwTrad2Yc5iCP2jcqD0NQxiSfw=
X-Received: by 2002:ac2:4e88:0:b0:477:c186:6e83 with SMTP id
 o8-20020ac24e88000000b00477c1866e83mr59207521lfr.663.1654475244310; Sun, 05
 Jun 2022 17:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220603190155.3924899-1-andrii@kernel.org> <87wndwvjax.fsf@toke.dk>
In-Reply-To: <87wndwvjax.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 5 Jun 2022 17:27:12 -0700
Message-ID: <CAEf4Bzb75b5cPjv1ZnM9aME3vxy4nxY0=Utp1wd0Z9P3s9mvaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/15] libbpf: remove deprecated APIs
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jun 4, 2022 at 3:01 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@kerne=
l.org> wrote:
>
> Andrii Nakryiko <andrii@kernel.org> writes:
>
> > This patch set removes all the deprecated APIs in preparation for 1.0 r=
elease.
> > It also makes libbpf_set_strict_mode() a no-op (but keeps it to let per=
-1.0
> > applications buildable and dynamically linkable against libbpf 1.0 if t=
hey
> > were already libbpf-1.0 ready) and starts enforcing all the
> > behaviors that were previously opt-in through libbpf_set_strict_mode().
> >
> > xsk.{c,h} parts that are now properly provided by libxdp ([0]) are stil=
l used
> > by xdpxceiver.c in selftest/bpf, so I've moved xsk.{c,h} with barely an=
y
> > changes to under selftests/bpf.
> >
> > Other than that, apart from removing all the LIBBPF_DEPRECATED-marked A=
PIs,
> > there is a bunch of internal clean ups allowed by that. I've also "rest=
ored"
> > libbpf.map inheritance chain while removing all the deprecated APIs. I =
think
> > that's the right way to do this, as applications using libbpf as shared
> > library but not relying on any deprecated APIs (i.e., "good citizens" t=
hat
> > prepared for libbpf 1.0 release ahead of time to minimize disruption) s=
hould
> > be able to link both against 0.x and 1.x versions. Either way, it doesn=
't seem
> > to break anything and preserve a history on when each "surviving" API w=
as
> > added.
> >
> > NOTE. This shouldn't be yet landed until Jiri's changes ([1]) removing =
last
> > deprecated API usage in perf lands. But I thought to post it now to get=
 the
> > ball rolling.
>
> Any chance you could push this to a branch of github as well? Makes it
> easier to test libxdp against it :)
>

Sure, pushed to
https://github.com/libbpf/libbpf/tree/libbpf-remove-deprecated-apis

> -Toke
