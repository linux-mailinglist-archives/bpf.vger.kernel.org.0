Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163AD6B177A
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 01:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjCIAFU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 19:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjCIAEy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 19:04:54 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2F11ABCF
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 16:03:08 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id cp12so454158pfb.5
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 16:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678320111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geMAMwLOO1uq+XDPI7e116q9+UQ4qFA7rJjF24VxJ0Y=;
        b=FM2MxX5A/KyMu5B3XjS4+/QwNjZm7pnqJo91zNk4eGYja7pE/bnEZI3an2akjpe2MS
         8Dg15oNXKNevKdLACAU79LBJCUw8ntgfMNLMQfNstKK1G2B4FOOO47vbq2grICAyeJEn
         /Y3pnLKrPP+ydiNpuUDoDDR+rNmN+cAOQDnFTjUOOEDjT5lQKM4qqZ3XPMOlo84jpC9N
         IvDVDwWbIweUIAe0LmynzpamocYCUUCh+2ugQdOTnoO2EmetBStx8JP9fU41R0WIbsI0
         AuGK6o1aqZuwMzu0MP5GJcEX7NiE8lqmn8m82RSOSbQW7hYKt8qiHtDncIjvl6UKuzYU
         xdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678320111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=geMAMwLOO1uq+XDPI7e116q9+UQ4qFA7rJjF24VxJ0Y=;
        b=Ckk/57Y6l1m8fyaGhzmK4l+OCKVu+yFkxxoCPhcotPRrMYKmXVF+wewx/2+dXNuQDx
         HwnBbkTZLU1wvljKFL+adZ3CgUp0vWV+F/c+Miy/QdSpI79i/m14lrDgcNyX+GD9Kb3c
         Jy79WpJxErnA1P83uKQ7m67wuJodhRF9ltyyjUikjhr/rsIyn90etS7mWrfp/1YjeZyV
         aucuVCOsv1YOtU6KyebPgU5+F0ogwwsr9rn0o5us0UoIrpNZ5AdW/0Hk54BNuszLJRrJ
         lbG7MrU5rf7H9CcxJEbaJkwFDy3eTKu4AmTyfM2XRZsJEHyiI0NFMT+kxghb9hKLJeSG
         sbUw==
X-Gm-Message-State: AO0yUKUpUuIBrfVXStyqZjXGMiU+MHeYa3Jc8Xn9A5FOg6fs7W8F8l9f
        dMqKzOqgrcIZVQfloVahkrp6pdxMjXEqXPAq1sexdg==
X-Google-Smtp-Source: AK7set9hklSyFqfl3N4lpSnheX6iPhPejaXaZepQ5V+SkuusYS/DZ8zl/6kVehSrAgEdPl6tad8XYq8XDTXKpcCPH90=
X-Received: by 2002:a62:87cc:0:b0:592:453c:320a with SMTP id
 i195-20020a6287cc000000b00592453c320amr8445186pfe.5.1678320111365; Wed, 08
 Mar 2023 16:01:51 -0800 (PST)
MIME-Version: 1.0
References: <CAK4Nh0igK=-wapie340gnoo4xazC8GP7EG7wjy1EEJokCLQanA@mail.gmail.com>
 <CAK4Nh0iEP5CAAe+i6o5AT=V=EfX2fW2FmoGCfU3+OgR1f-GMAg@mail.gmail.com>
In-Reply-To: <CAK4Nh0iEP5CAAe+i6o5AT=V=EfX2fW2FmoGCfU3+OgR1f-GMAg@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 8 Mar 2023 16:01:39 -0800
Message-ID: <CAKH8qBshq-J2H+Bo1xA=FzAJ6x_mo5yfW6oYjQ_u1QwLJ5CDog@mail.gmail.com>
Subject: Re: Broken build on 6.3-rc1 with uClibc-ng based toolchains due to
 poisoned strlcpy
To:     Jesus Sanchez-Palencia <jesussanp@google.com>
Cc:     rongtao@cestc.cn, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 8, 2023 at 3:51=E2=80=AFPM Jesus Sanchez-Palencia
<jesussanp@google.com> wrote:
>
> (+bpf folks, -perf folks)
>
> Please see below.
>
> On Wed, Mar 8, 2023 at 11:28=E2=80=AFAM Jesus Sanchez-Palencia
> <jesussanp@google.com> wrote:
> >
> > Hi there,
> >
> > So commit 6d0c4b11e743("libbpf: Poison strlcpy()") added the pragma
> > poison directive to libbpf_internal.h to protect against accidental
> > usage of strlcpy. This has broken the build for some toolchains and
> > the problem is that some libcs  (e.g. uClibc-ng) provide the strlcpy()
> > declaration from string.h, which leads to a problem with the following
> > include order:
> >
> >                  string.h,
> >                  from Iibbpf_common.h:12,
> >                  from libbpf.h:20,
> >                  from libbpf_internal.h:26,
> >                  from strset.c:9:
> >

[..]

> > If we patch libbpf_internal.h and move the #pragma GCC poison
> > directive to after the include list, we fix the problem but at the
> > expense of leaving libbpf.h unprotected (and libbpf_common.h as well,
> > of course).

Seems like a nice compromise? I'm assuming the original intent was to
mostly protect the c files, not the headers. Andrii WDYT?

> >We could duplicate the directive on all these other libbpf
> > headers after the include list, but that's code duplication so I
> > wanted to bring this up here before I send out a patch.
> >
> > Let me know what you think or if you have any other suggestions, please=
.
> >
> > Thanks,
> > Jesus
