Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A666F082E
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 17:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243558AbjD0PYK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 11:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243459AbjD0PYK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 11:24:10 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65718113;
        Thu, 27 Apr 2023 08:24:09 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-5ef4885bc39so38576776d6.2;
        Thu, 27 Apr 2023 08:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682609048; x=1685201048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKhnqaYrWh0VRI0RjHLFiEQEfw/PaxTNK9hFCLYl2ZQ=;
        b=fWGEvATYqJuv/ziuBu5WMvCmI6wq3pOdiYtUJ53pYvsbBAOocRF6+VmO663imzHOMO
         aXGEJNT0zZ+lkL+Ueht76h3sFvynFXY/SEpWmI8CM7D9xySJEjzggSoClX0MoFpmOaKW
         Ni8qVuhic8ZokVYdfbS9HQb3iNt0ALCpxWSqNLv3l7XiGURMAgZEIF+XpwWHLouVfOGA
         P6CBKsGQElJ4t2S83VVRKeclIikBarmg+dN7KoGB7ODup3LqXVUSyYJnWys1hzdygZy7
         oHOB12WbypLeqYmMcIsmesfpqA4uGK+3C0gJEsrSm2eLOqj4guaUCR3XVaBN2w6ksBxa
         Z6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682609048; x=1685201048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKhnqaYrWh0VRI0RjHLFiEQEfw/PaxTNK9hFCLYl2ZQ=;
        b=LtXRHvH5B+sNNexLamBr9ohjaVVxVpyh6kYo/h00gzglsNUdUIkoGk5L9feE36N0sw
         vTlwirNFiABQ8VKvsl3w3NAjAkdTzosOgTTOR5HxaDaXN9KE4bJcPrKq8JSJnCeQsuP3
         C0zifEWKmzpew+TRj8zGAN9FWOH7roKJuP0K0csaX61P8sJx40+VqTzkSFrVH/afNPU0
         I7k/7/7Km8TcLq1V2j4sfkSzx+AT9Wt1UgfT4pjdh8bYw4FcjYcReWGOX7wljWyBu5ih
         PMRG2AluHrt/HjcMpq1/DAfM2zHoCY4Vg9KQUh9ZigqIayIIvCQqCVH3I5btFn1dyPHv
         GOww==
X-Gm-Message-State: AC+VfDxSxIFT6wRgyIbODqU+02Yva5Hd9mXFDTiieUZ6QTsOgTEEAuZa
        bPiNWDW5uJB5bfz3Iv9c1Kub/DKL8z8qBgR5a19CVbWZ4LlNbg==
X-Google-Smtp-Source: ACHHUZ4JYIpkNatZAOGXxmiMGWoALnYGPEAb4EhrkSK49IDwuZBO5ok8wCBVXl6GghlW6/Gwupu8Prvx81o66r2IR+k=
X-Received: by 2002:ad4:5aa2:0:b0:5e8:3496:e641 with SMTP id
 u2-20020ad45aa2000000b005e83496e641mr3159318qvg.13.1682609048555; Thu, 27 Apr
 2023 08:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230417154737.12740-1-laoar.shao@gmail.com> <20230417154737.12740-6-laoar.shao@gmail.com>
 <20230427092628.21fd23e4@gandalf.local.home> <CALOAHbBX1C-eg93Hf3xPLsdsaBzoGn1pHh9jb3Z_-T-7HD60wA@mail.gmail.com>
 <20230427111842.2e40fe3c@gandalf.local.home>
In-Reply-To: <20230427111842.2e40fe3c@gandalf.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 27 Apr 2023 23:23:31 +0800
Message-ID: <CALOAHbDRSNvihv5n0jJpAsK3onezRRipO78RG3rAf3LGgkzYHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/6] bpf: Improve tracing recursion prevention mechanism
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mhiramat@kernel.org,
        bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Apr 27, 2023 at 11:18=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Thu, 27 Apr 2023 22:22:22 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > IIUC, the acquire/release pair works as follows,
> >
> >    test_recursion_try_acquire
> >      [ protection area ]
> >    test_recursion_release
> >
> > After release, there will be no protection, and thus it will fail the
> > tools/testing/selftests/bpf/progs/recursion.c[1] test case, because
> > the recursion occurs in the bpf_prog_run() itself,
>
> But bpf programs are allowed to recurs. Hence, you need separate logic to
> detect that. The test_recursion_*() code is for cases that are not allowe=
d
> to recurs.
>

Agreed.

> >
> >   __bpf_prog_enter
> >      test_recursion_try_acquire
> >      [...]
> >      test_recursion_release
> >   // no protection after the release
> >   bpf_prog_run()
> >     bpf_prog_run() // the recursion can't be prevented.
>
> But I thought you can run a bpf_prog from another bpf_prog. So you don't
> want to prevent it. You need other logic to detect if it was not suppose =
to
> recurs.
>

If so, we have to keep the prog->active to prevent it, then I'm not
sure if it is worth adding test_recursion_*().

--=20
Regards
Yafang
