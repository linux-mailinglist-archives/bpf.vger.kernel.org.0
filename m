Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF71C54D049
	for <lists+bpf@lfdr.de>; Wed, 15 Jun 2022 19:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241015AbiFORqc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jun 2022 13:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbiFORqc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jun 2022 13:46:32 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D5D53E18
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 10:46:31 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id r3so9283200ilt.8
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 10:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZYuXlUdndMJAXOx9LJOV9XlkMfRqA5F92V4fRt/XtDk=;
        b=n7UhfYDARgRgaED+GWCeyUbnYjdXD3t47GcfCQbAgc9V1mN47gp89/7bVHFrd6ST+q
         qDQDcUDDXkeI7KzH1oG/3TEwyt+HxtUawZZJDnO2oM9sBsJ/dTOXKAfr72rYqFyiaFeW
         ERbiCYiywRP0cuCY8UfOZrtTnh6HSbVRDL6XkI3KSh44zskPXUerkMdNrpmd7u9ArXxS
         sLF/ESr/pUmm3jxAe4QErA3cYmKI06PlDC6GJS2mliKvmAKhFGPDAqx0Wk9e+1ZrcA8Y
         tRfaz47ev/bQbz3sA7mGB4h4hFvn610S9RL0j5HANnZmyk24AafKGoFXAUKgwPhpScBL
         QaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZYuXlUdndMJAXOx9LJOV9XlkMfRqA5F92V4fRt/XtDk=;
        b=ZOgGlvDI9q+IE7hw6C88cQMmFw+oFckV1qCt9Z4zUZIhn5pDCIAE2hQVPJBOsFJYuE
         5P9/Odi0yBFG9r8S5qgJD3Wu3vz9MZnPt5IFPDKs2jRRbP1LK6x5nN1Naa3T530rHZJ1
         Sxh0WM5uV14V/15ECF0C/0NmgLDlleuMDbZEW9O/23WaSZzKykYuBBM2cJ7jelM9yyBa
         YcZwaCdK/L4SakXnFD5HcYW9GUdG4c0Xn2WRhe8eMK2fPNRq1MeceOGz/Glq5BjibyGB
         T2SJUmPVGY6A3ZZq6jN4S1cSpS/B+HfhvE192cH36/9Izgxft2kOfA5NiVv1f2+uqsC9
         OhNA==
X-Gm-Message-State: AJIora9J/oh27Q0SKYLA64qxdrkZltAhR+qVlc2lxvnQKUhatnyhwhaH
        UggepPfcOWj6t9qwANj18YH5zt0w142Sv0tT2g81JA==
X-Google-Smtp-Source: AGRyM1sPsGupk/6xxc1TZ/sGN3npk+cE4cUvKoBZiL2uvmiqmaxvLF1VR8TX/dnhkm3vbGpUwh5TkUZz9mlE4T62gkk=
X-Received: by 2002:a05:6e02:b2c:b0:2d1:ba4d:c240 with SMTP id
 e12-20020a056e020b2c00b002d1ba4dc240mr599658ilu.273.1655315190455; Wed, 15
 Jun 2022 10:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAHo-Ooy+8O16k0oyMGHaAcmLm_Pfo=Ju4moTc95kRp2Z6itBcg@mail.gmail.com>
 <CANP3RGed9Vbu=8HfLyNs9zwA=biqgyew=+2tVxC6BAx2ktzNxA@mail.gmail.com> <CAADnVQKBqjowbGsSuc2g8yP9MBANhsroB+dhJep93cnx_EmNow@mail.gmail.com>
In-Reply-To: <CAADnVQKBqjowbGsSuc2g8yP9MBANhsroB+dhJep93cnx_EmNow@mail.gmail.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Wed, 15 Jun 2022 10:46:19 -0700
Message-ID: <CANP3RGcZ4NULOwe+nwxfxsDPSXAUo50hWyN9Sb5b_d=kfDg=qg@mail.gmail.com>
Subject: Re: Curious bpf regression in 5.18 already fixed in stable 5.18.3
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Linux NetDev <netdev@vger.kernel.org>,
        BPF Mailing List <bpf@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Sasha Levin <sashal@kernel.org>,
        Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 15, 2022 at 10:38 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jun 15, 2022 at 9:57 AM Maciej =C5=BBenczykowski <maze@google.com=
> wrote:
> > >
> > > I've confirmed vanilla 5.18.0 is broken, and all it takes is
> > > cherrypicking that specific stable 5.18.x patch [
> > > 710a8989b4b4067903f5b61314eda491667b6ab3 ] to fix behaviour.
> ...
> > b8bd3ee1971d1edbc53cf322c149ca0227472e56 this is where we added EFAULT =
in 5.16
>
> There are no such sha-s in the upstream kernel.
> Sorry we cannot help with debugging of android kernels.

Yes, sdf@ quoted the wrong sha1, it's a clean cherrypick to an
internal branch of
'bpf: Add cgroup helpers bpf_{get,set}_retval to get/set syscall return val=
ue'
commit b44123b4a3dcad4664d3a0f72c011ffd4c9c4d93.

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dlinux-5.16.y&id=3Db44123b4a3dcad4664d3a0f72c011ffd4c9c4d93

Anyway, I think it's unrelated - or at least not the immediate root cause.

Also there's *no* Android kernels involved here.
This is the android net tests failing on vanilla 5.18 and passing on 5.18.3=
.
