Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887264CB38A
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 01:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiCCA25 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 19:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiCCA25 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 19:28:57 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E9746153
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 16:28:12 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id i1so2780393ila.7
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 16:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q2GteahX/OWyWMTMVeRaIntkC6UXne7NJA8JRM8XdK8=;
        b=JiwGqLjnyGOmOeBmJT4vekCCsv8adUw3p4VA+x8JZBTjBm10guORg+OggAZ77L132g
         HQ1s6MXg5r+FDyhBJhlRalEWMbvtmI2NCtDx75kkwBqZd7Dj/FCiueViNeMx1Q91MFec
         eovmboHa0hGceOByF0C/z1QKgo5ZkptQlV4qFKpa2+7UZy/h49DhxV4Ngs6ZxZospIQR
         pcs3iSzzKXHV4xQhPXnnqukr+QCNcqCzy3NUymOyn7qb501tgPcDCPe0x1y7TDEG9EOI
         obeJmIIQNHQUWHQVWgc13e6zWRPP+9leT9uqNRRxUpINocckhRFOGLExT+9L3XwLNta0
         z/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q2GteahX/OWyWMTMVeRaIntkC6UXne7NJA8JRM8XdK8=;
        b=pPAO88+KZYhkqVdRxLymjAbBev6T5QL//h+/UiMpufgW4YXkiqxD5HxPMmBTX3T2tN
         hY6SvTvW5V1r7pfbWJ/hKMJb3IrO8A7uWtVjrENomL4x/TeE7tT2+ev67qwzMJycQJUQ
         70EY5eEcwHE0BLCCfsv2iJ1cm8wxw1YPRao2qYW4Y0szle/oVrDdDLnfdHIe8AJZKiOx
         DciFoFUhvbQrkyAz9drK6WQUIK2k1GWBcLhnBth2SjDpa8JU252Ch16cY3NNY/8a+xL5
         im8Nh4EkZBWc3HSxqiXlHlnqru3mYx447wnetvDSm8nk7zpMW2ayomEqTN5v/ruVeARs
         ZaXw==
X-Gm-Message-State: AOAM532UvP0xxU1UqqX4HBk6zxyX8WS4DwIPLgb+mRGqMSTXsciU1y4l
        dynfrxQw3SN1DQWFgMxtXBRWckR9UNOzUb0p118=
X-Google-Smtp-Source: ABdhPJyd9NrMxMjHeHimi5sUZPDe1HH2YL+R7JVAxeHlTjodVPwafZOWGM9GkI/WxyDm4hyLSc40IVSf/gbKChAGb0c=
X-Received: by 2002:a92:c148:0:b0:2c2:615a:49e9 with SMTP id
 b8-20020a92c148000000b002c2615a49e9mr29644502ilh.98.1646267292305; Wed, 02
 Mar 2022 16:28:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1646188795.git.delyank@fb.com> <13cba9e1c39e999e7bfb14f1f986b76d13e150b3.1646188795.git.delyank@fb.com>
 <364c8325-ea90-f8f6-d95b-09c9b0b4589e@iogearbox.net> <06118a1998138424c0aace9cb94d67b31b720a0d.camel@fb.com>
In-Reply-To: <06118a1998138424c0aace9cb94d67b31b720a0d.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 2 Mar 2022 16:28:01 -0800
Message-ID: <CAEf4BzaXHG-m1c6NJaKh=dK=-8tjSy4On329NXrS5+HZuhjF=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] libbpf: add subskeleton scaffolding
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Wed, Mar 2, 2022 at 4:20 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> On Wed, 2022-03-02 at 22:43 +0100, Daniel Borkmann wrote:
> >
> > Triggers CI failure with:
> >
> >  > build_kernel - Building kernel
> >
> >    libbpf.c: In function =E2=80=98bpf_object__open_subskeleton=E2=80=99=
:
> >    libbpf.c:11779:27: error: =E2=80=98i=E2=80=99 may be used uninitiali=
zed in this function [-Werror=3Dmaybe-uninitialized]
> >    11779 |      sym->section, s->syms[i].name);
> >          |                           ^
> >    cc1: all warnings being treated as errors
> >    make[5]: *** [/tmp/runner/work/bpf/bpf/tools/build/Makefile.build:96=
: /tmp/runner/work/bpf/bpf/tools/bpf/resolve_btfids/libbpf/staticobjs/libbp=
f.o] Error 1
> >    make[4]: *** [Makefile:157: /tmp/runner/work/bpf/bpf/tools/bpf/resol=
ve_btfids/libbpf/staticobjs/libbpf-in.o] Error 2
> >    make[3]: *** [Makefile:55: /tmp/runner/work/bpf/bpf/tools/bpf/resolv=
e_btfids//libbpf/libbpf.a] Error 2
> >    make[3]: *** Waiting for unfinished jobs....
> >    make[2]: *** [Makefile:72: bpf/resolve_btfids] Error 2
> >    make[1]: *** [Makefile:1334: tools/bpf/resolve_btfids] Error 2
> >    make[1]: *** Waiting for unfinished jobs....
> >    make: *** [Makefile:350: __build_one_by_one] Error 2
> >    Error: Process completed with exit code 2.
> >
> > Thanks,
> > Daniel
>
> Argh, sorry about that, sending reroll in a few.

Please hold off until you get review feedback
