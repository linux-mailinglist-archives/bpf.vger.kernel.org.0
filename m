Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB0D55A3DB
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 23:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiFXVqC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 17:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiFXVqB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 17:46:01 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673C286AE9
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 14:46:00 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id g26so7247262ejb.5
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 14:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qoNZduo1dEsmEG0XFWQx2i6mtgj34AYW9LYRR4K6k0I=;
        b=ga1iLSDSEO08ns2sWEmMAmy/lRC2Jvdg3tdCCiNQ7qqBKTNh1R/BX9EaV3ahqgthnD
         ykymYllDLx7H8zhn7XtzCfYH7DxU7eExv+tiQekYOJDnLEQyyvxqaIBGgO+PTpVeZ3Hh
         vDzoDIPjNyfw9kjUHus2sJkRoVsLe3X8J7Vu/y4QG3/BK+NQFNTireMSV2R63ewzO045
         Z/2n1jwesLHfMgsdhGCDEKUDjiSRCbebpoHc2GMbihGOc42LZMp12fzfncsdumWUVJE2
         WXVS7ZljoEJdt79LPUTMZAQrJ0Nhk3LdEegYxKJzL9d36xVtNxFdWxm4xPhgSoXYzfP1
         jEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qoNZduo1dEsmEG0XFWQx2i6mtgj34AYW9LYRR4K6k0I=;
        b=RSkpOz/pSk/wBRlDpRo2EECj5TaSyrE/SGZMUvZNWvtGp1omYjYNBKJf1G3LvSevkD
         nIDK0ABJKlEUKDUZk4SLdi+OZMttLZg/G6dqQQAzDszdWn1LpoGD4HOVkHwZND3FXInx
         iuQgSod3ZCnR5DlCjmHjGMGGK3fZYrE5d6+7kCAfLpGgMwohLnslOy29BBwtc/XKc9lS
         eD+Dpp/agkmX+w4TbEwrfjf7nNwpvcJwpDdp/O7XMuYREdTiIKspUvkrA1Oc8Lh1AjxW
         ybRT7RBLzGVM4iYeQdjJHACf2vd5RQv3s+kgbyqQ+PTLYY5NOxcLH4BI7ebv6nHMU/G2
         0TVw==
X-Gm-Message-State: AJIora/Fttky/rq6xXkABrKayGAQ8sM7HvWtDgC72BB5WU2/3oy1+UMs
        VCj5T8/4hnJMDDi65k5xfl2ozofTWEQRmatVP88=
X-Google-Smtp-Source: AGRyM1urcJ9L4hkxhWMvsZlgBb+gkUy+1uENdPufiYU+9PLyOHh0t3Bt5lZ/9KhSiRDbgmNPvTTTTacAzc23tnIK3Ic=
X-Received: by 2002:a17:906:a3ca:b0:726:2bd2:87bc with SMTP id
 ca10-20020a170906a3ca00b007262bd287bcmr1081238ejb.226.1656107159029; Fri, 24
 Jun 2022 14:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220623212205.2805002-1-deso@posteo.net> <20220623212205.2805002-10-deso@posteo.net>
In-Reply-To: <20220623212205.2805002-10-deso@posteo.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 24 Jun 2022 14:45:47 -0700
Message-ID: <CAEf4BzY14nHcG8FoGXX_5reQDdq2a7st9ECG8fgn2zGcmx4t1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 9/9] selftests/bpf: Add nested type to type
 based tests
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>
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

On Thu, Jun 23, 2022 at 2:22 PM Daniel M=C3=BCller <deso@posteo.net> wrote:
>
> This change extends the type based tests with another struct type (in
> addition to a_struct) to check relocations against: a_complex_struct.
> This type is nested more deeply to provide additional coverage of
> certain paths in the type match logic.
>
> Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>
> ---

I'd like us to have a TYPE_MATCHES test against struct task_struct,
something like below:

struct mm_struct___wrong {
    int abc_whatever_should_not_exist;
};

struct task_struct____local {
    int pid;
    struct mm_struct___wrong *mm;
};


and then use struct task_struct____local with bpf_core_type_matches()
and check that it succeeds. This will show that TYPE_MATCHES can be
used practically. Can you please add it to
progs/test_core_reloc_kernel.c?


>  .../selftests/bpf/prog_tests/core_reloc.c     |  4 ++
>  .../selftests/bpf/progs/core_reloc_types.h    | 62 +++++++++++++------
>  .../bpf/progs/test_core_reloc_type_based.c    | 12 ++++
>  3 files changed, 58 insertions(+), 20 deletions(-)
>

[...]
