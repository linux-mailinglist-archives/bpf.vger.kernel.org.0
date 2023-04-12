Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327B96DFC36
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 19:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjDLREe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 13:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjDLREY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 13:04:24 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323D67EE3
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 10:03:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94a34d38291so227252766b.3
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 10:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681319027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LHiWvQPuJdDb9wJongl+n/VNV9AJ4eHylW4Q6WC3M4=;
        b=CMbdJ1MM3kaNCiCIev0R7XAwBcWknrocOW2yQ6tPZ4a4tTKg35sVqrhCC6DQQ7a3zX
         GQiOXU47tNqSJmlWAigAHac/AbBinb5GOPxVF//UE287s7u08qsXXzF808xlbrf0ma6d
         rbTCrgAJqcaOhnxaIgeYIo6e3N7CJioPSrZcRmHNScfcwdReK6LD1Ob6OwQHkYYUiX+b
         2Qf1J08cER16WpnNLOhkeyy/LOZGIexlMVC58nZKfbzEVY4uBJ6boR8erdKZGhxTUodk
         Q0FUCfknW5I7uluDn+e2KaGHGvJZ58RqFh3Bb/My7k+tQauQYZXLRS1dxtohmWl6InQv
         PmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681319027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LHiWvQPuJdDb9wJongl+n/VNV9AJ4eHylW4Q6WC3M4=;
        b=d0Y1vCXRSfivngNG3zbCjoZ7Yro0tdyNVYG3aZn85L9bmly+RyHL3dscosbE1cUkSD
         0f4xkAxvvn84MlADKmoMxLT3e9OgiU6EpDciQ38goUDWfvm4ujoggNhGfbT9YrwNBXPI
         TxNjEkYPr7UgA9lkts5p1jTnaFXgBxn2Th7rGOSuDVZ1HUYR0Bj4AG7zakp70mauHlCK
         xRQXYPAtoeQlyXatHkR421CNoor0j8pmQg9EUK+2KQf8HUdQWMAkg+jYr044/TMIQZ9T
         GMVCHALEu50qvNIPgUAojUfamJtKwaWgbD/AKbmpx17YaXhkvktQXNYVNici/MdOJKND
         kAug==
X-Gm-Message-State: AAQBX9fQZHYEV8Xil8cOKEaw5bg26LU5lkZTpuinYU3cvd4i0+CZQByJ
        /5gS6deUmr3PtuIT+PJo58RBnzTtHLJKVf6m2W8=
X-Google-Smtp-Source: AKy350a4wtIKg9k0AXR1vSB/97TdfhyboiPm/qCcFzLMHxc9Bc1FD0am5L6k/BuHCqP007sN+bzIEFrKwM/ZyWkmguE=
X-Received: by 2002:a50:9f87:0:b0:505:47d:29b5 with SMTP id
 c7-20020a509f87000000b00505047d29b5mr1472340edf.1.1681319027511; Wed, 12 Apr
 2023 10:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230406234205.323208-1-andrii@kernel.org> <CAN+4W8hhrJznohpbkx0wOt8J+S5HeBTaWhfy+=VgqGi3OjnKqg@mail.gmail.com>
In-Reply-To: <CAN+4W8hhrJznohpbkx0wOt8J+S5HeBTaWhfy+=VgqGi3OjnKqg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 12 Apr 2023 10:03:35 -0700
Message-ID: <CAEf4Bzbe4Lzbb91__CH3p-RSp6O22tVO0YpYeSn-fB8K3W72KA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 00/19] BPF verifier rotating log
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        timo@incline.eu, robin.goegge@isovalent.com, kernel-team@meta.com
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

On Wed, Apr 12, 2023 at 8:31=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> wr=
ote:
>
> On Fri, Apr 7, 2023 at 12:42=E2=80=AFAM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >
> > This patch set changes BPF verifier log behavior to behave as a rotatin=
g log,
> > by default. If user-supplied log buffer is big enough to contain entire
> > verifier log output, there is no effective difference. But where previo=
usly
> > user supplied too small log buffer and would get -ENOSPC error result a=
nd the
> > beginning part of the verifier log, now there will be no error and user=
 will
> > get ending part of verifier log filling up user-supplied log buffer.  W=
hich
> > is, in absolute majority of cases, is exactly what's useful, relevant, =
and
> > what users want and need, as the ending of the verifier log is containi=
ng
> > details of verifier failure and relevant state that got us to that fail=
ure. So
> > this rotating mode is made default, but for some niche advanced debuggi=
ng
> > scenarios it's possible to request old behavior by specifying additiona=
l
> > BPF_LOG_FIXED (8) flag.
>
> I just ran selftest/bpf/test_verifier_log on top of bpf-next which now
> fails with:
>
> Test log_level 0...
> Test log_size < 128...
> ERROR: Program load returned: ret:-1/errno:28, expected ret:-1/errno:22
>
> Seems like these tests are now superseded by test_progs?


I didn't even know we have a separate test_verifier_log binary. It
seems like newly added tests in test_prog indeed cover all the same
use cases. I'll send a patch to remove test_verifier_log.c. Thanks for
spotting this!
