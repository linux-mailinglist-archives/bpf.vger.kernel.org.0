Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95736DA400
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 22:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240435AbjDFUtM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 16:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240586AbjDFUsx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 16:48:53 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F91EC65A
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 13:46:11 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id qb20so4293627ejc.6
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 13:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680813969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAUkMZtbWU10gbUkI3iK59xPc1ucDHVNy1qNLYV8+Eo=;
        b=UTw57zRIf2byFfEVSp3s5Re8KGbQYV+OSB/AxPz632zg8e+LiFycnmoBNF7gmM3V46
         3X104uPlQRNSpXtswq57VfZqwTpFUwXJ2iWhlcwQ5P2aJTTALRrxxyCieGo1VyV3yLfY
         b/U7dNmAIbitII6B++8TZaZNF8bOQHe7rstTMPevYRv3Qm10LLP3j7N6iWmWky9K6+Qi
         Mlxe1u7/Yyx2iaSK9NHAgMV6QYA2fDz3Vd1pKV2PBoXKyIMlCEUDBqNN+o2T1BF9ZKKR
         clvU5eTWi2SP1mzg4P7+KEdOrRRtKHxOEk0N86FH31Cetm2uO/OKEQd/vMxQZ8VnTPdm
         22mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAUkMZtbWU10gbUkI3iK59xPc1ucDHVNy1qNLYV8+Eo=;
        b=Dhn8npj2lqCMMMKvPJmUbHGSq44nNSUmQupL/ZjU7KkXS8bRxPH3HDfbwEHxtrhWMa
         sNIli3XejPcGQm79E2zjzq1gU4yFZNP179IEpJJA6LRmAM64XrLcXNGth8IhVeiKUBgw
         8MxtwbxxptsMMMnzvLLNrRHBBaxMT4n8XW6IbEDjCMGZGDo2iJ/5wIn7mkyWDWmMlGZ/
         ftKJ9gHbPUxgU7eOgzshmki8R1+8yaJEQ9xZg1kdevpRA+bn7UA0remoSFOT+RRcNJfc
         dVO7joYDeZjvsSQRFFv4oU0AGZ5Qj4VahT4noF60QM9UKmd4PrGUZmSlDV1xUauSyxeW
         iYYg==
X-Gm-Message-State: AAQBX9fBCpKPTYTJiiJ6o7P/3sqSg2VI9cbuDUs05P7NZIbrwOBfMRf+
        jYsfsxnTaVmIc9zBGrX23bn2i9mWnvZVAclg/8Wa5B2S+q0=
X-Google-Smtp-Source: AKy350YdRFScZwplFYidFemumA9qGA1X5uE5mI8/P/GieKRB9HlAZm2S3jSy16Gi6w52tHc25Jt8iRN4T4BpAJ2uudw=
X-Received: by 2002:a17:906:80c5:b0:931:fb3c:f88d with SMTP id
 a5-20020a17090680c500b00931fb3cf88dmr99052ejx.5.1680813969307; Thu, 06 Apr
 2023 13:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230406164450.1044952-1-yhs@fb.com> <20230406164510.1047757-1-yhs@fb.com>
In-Reply-To: <20230406164510.1047757-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 Apr 2023 13:45:57 -0700
Message-ID: <CAEf4BzYDiG0xiE-DnBomOr_Jj6S_QyEZNJwaZmzCCdF7suqG2Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: Add verifier tests for
 code pattern '<const> <cond_op> <non_const>'
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
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

On Thu, Apr 6, 2023 at 9:45=E2=80=AFAM Yonghong Song <yhs@fb.com> wrote:
>
> Add various tests for code pattern '<const> <cond_op> <non_const>' to
> exercise the previous verifier patch.
>
> The following are veristat changed number of processed insns stat
> comparing the previous patch vs. this patch:
>
> File                                                   Program           =
                                    Insns (A)  Insns (B)  Insns  (DIFF)
> -----------------------------------------------------  ------------------=
----------------------------------  ---------  ---------  -------------
> test_seg6_loop.bpf.linked3.o                           __add_egr_x       =
                                        12423      12314  -109 (-0.88%)
>

nit: a bit of veristat trivia for future uses. If you specify filters
properly, it will size the width of columns more tightly and you
wouldn't have to trim only relevant rows. The above would do,
probably:

sudo ./veristat *.linked3.o -e file,prog,insns -f 'insns_diff!=3D0'

> Only one program is affected with minor change.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  .../verifier_bounds_deduction_non_const.c     | 460 ++++++++++++++++++
>  1 file changed, 460 insertions(+)
>

Nice set of tests!

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_deduction_=
non_const.c b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction_n=
on_const.c
> index fe570d866139..823f727cf210 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds_deduction_non_con=
st.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction_non_con=
st.c
> @@ -176,4 +176,464 @@ l1_%=3D:                                           =
         \
>         : __clobber_all);
>  }
>

[...]
