Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701196CB518
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 05:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjC1Dsu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 23:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjC1DsS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 23:48:18 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E121C19AD;
        Mon, 27 Mar 2023 20:48:08 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id h8so2188272qko.8;
        Mon, 27 Mar 2023 20:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679975288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAkqCpAhSqBzJLqFuiyBvwQ7I9+v6HWI1HRkhaluBAc=;
        b=d2Cf89T7hvSTKosfUTNS+sWsPj9BxbBp/ecwRzaE3Hr1vpSvKvnpcVOOyplHnEAd85
         5DuIKpX32y1exrSYSZWoaZmCHsUhHpxlUZxc8ZyvKXAbG5YtSeBKGuPRYKKzVgBTrjpF
         8M6P6sUMzV88DcCVZQ3vBlFWU9/lSGTCNiDYbxkhwTLp52z1qB/vF1z4oOFTJawGyMXl
         UP2gpjPacP2Il7d8ZapM/aydMT6NL+MwQv5m5cTa7Uxrqk7BV8RTxRUSkGNWG3gWr1GM
         7I8TCg/Pv+hOrFBgDWyF7ADPSM1bJEd2oUQd4Uh3wj9Z9Wopmt4TSUBbrN+qfnRA5vlf
         bCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679975288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAkqCpAhSqBzJLqFuiyBvwQ7I9+v6HWI1HRkhaluBAc=;
        b=c2/6qvlrdVphmiubiOlqBRdFThgC2+fbQgwarI318MlF7bflO782zu32yPQlfxzP2+
         i1iJgmSGFZ+Bf2+3wWfe7XgmAJYUt8+sJvXpHJIwppM3NzDWTWytin6LyFBYdPMgUTCb
         j+ZsgTC+qJ2x6ogg3F6bkNgDic84T39GLz/Pspz/ft7mfOPoiS+Iu93KOhUFkoYQg50c
         pGbWIuMDLvDrl6H1oE1f+GFfwU7xv+nuJmyizz7H9ph7DAHiEa9euklso3DmpPLHQwDy
         Xv464ZnXalA6q0QAAFS39M/GIh6r4g7Sx2lB5joFAptJ1UXY84g7DZ2e1yDTaYa8sXrK
         GTow==
X-Gm-Message-State: AO0yUKXxQrKIII2PMv4E6FaJexR9gbueKViK1+IPkGSCBQ/b74yOi6Fm
        GNs84x5bhbjLcvfE6sxN1ececQ56/mpF3PHj6ss=
X-Google-Smtp-Source: AK7set/rSXPYXwvVMCJ1JsQ+u9bohwSGISSVY6AhzNe2wB7LyXgfLdcMHVRnSg1ElfUYG6q6lXTsuIbkeohT6K9TZLU=
X-Received: by 2002:a05:620a:2238:b0:742:412d:1dc6 with SMTP id
 n24-20020a05620a223800b00742412d1dc6mr3312278qkh.14.1679975287958; Mon, 27
 Mar 2023 20:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230326092208.13613-1-laoar.shao@gmail.com> <CAPhsuW43EiH0tVKU8s+JwV_V6EBETTDyXsAmMzAftpVtcgLHag@mail.gmail.com>
In-Reply-To: <CAPhsuW43EiH0tVKU8s+JwV_V6EBETTDyXsAmMzAftpVtcgLHag@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 28 Mar 2023 11:47:31 +0800
Message-ID: <CALOAHbCqCb3xmSpNe1Qvm75GBY4ZEGrAOHfVJvpZV5t=akTTgQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
To:     Song Liu <song@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Mar 28, 2023 at 3:04=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Sun, Mar 26, 2023 at 2:22=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > Currently only CAP_SYS_ADMIN can iterate BPF object IDs and convert IDs
> > to FDs, that's intended for BPF's security model[1]. Not only does it
> > prevent non-privilidged users from getting other users' bpf program, bu=
t
> > also it prevents the user from iterating his own bpf objects.
> >
> > In container environment, some users want to run bpf programs in their
> > containers. These users can run their bpf programs under CAP_BPF and
> > some other specific CAPs, but they can't inspect their bpf programs in =
a
> > generic way. For example, the bpftool can't be used as it requires
> > CAP_SYS_ADMIN. That is very inconvenient.
>
> Agreed that it is important to enable tools like bpftool without
> CAP_SYS_ADMIN. However, I am not sure whether we need a new
> namespace for this. Can we reuse some existing namespace for this?
>

It seems we can't.

> If we do need a new namespace, maybe we should share some effort
> with tracer namespace proposal [1]?
>

Thanks for your information. I will learn the tracer namespace first
and try to analyze how to cooperate with it.

> Thanks,
> Song
>
> [1] https://lpc.events/event/16/contributions/1237/


--=20
Regards
Yafang
