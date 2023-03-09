Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861CB6B1AAA
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 06:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjCIFTv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 00:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCIFTv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 00:19:51 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4677CE958
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 21:19:49 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s11so2393069edy.8
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 21:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678339188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA9Ua6B6An6RP3rVZJ6ZH88clwhca28y6cgL9YikeQc=;
        b=P7gljFgRoN0FfATXgsTakXNbMVB+8MVmeIhCZS0lWnErCEEggI/jbT6JnluvbD0/3C
         bEXhQW4V96J2rXI4J45+0IJP3gFOflJRB6AHFLuZrviUk8isGWl9LXYZLWCZ/64lcipB
         4HuzOy3B6cy4D64xphkx91/Jevl7ikHIRsI1QwIsrx5LRJBbuiAcKpuktQpJiPvN4DYU
         dIRv7x/u50m1w+rngTsCSw5me7Axco5oWMk3L+clbC8ekrA/ewupCe7lqlFx9/Ozaayu
         dvkXgsKPatmdaozq1mA1dPhxfIiWK71TuY/61FEn9QRoBWMLZtw3FkkS/CFgtGb3Jp7k
         X3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678339188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XA9Ua6B6An6RP3rVZJ6ZH88clwhca28y6cgL9YikeQc=;
        b=GQ6OHS/LmOEZFSGhwturMgChL7+8HVlYHTL3EAkQynECnMpTEKFthe8Rb98EX+Oi7J
         8q2j8MoSlHGKGDt/gEUZuCRZqDNjRqlMzMublfsW+TY4N4PiomrC6tM09IoF2/zS7+4F
         PMgF4CAWlORgxrBkztp77Qa+4twgzlQtgtw6tC0cdXXyXOLTzEWgXmf8K4qY4TaC1cuJ
         ZTlPkXt/PtCpDE4zHnpcRU/VLvBAmos0ANjspnt5icNsGf6Fex81o7zDPSo5v1swY4lX
         GEvB3/pW3tUwvxdio65p9bP+Psck+741+UAAJm8PCMc+jwuo7Qhuaa1oPC5cM3/QmDZF
         nCjQ==
X-Gm-Message-State: AO0yUKWNdAgmyzSYZZMU8amDaEvwcc7vKkFXFDhu84ggSYrHcQLRfcWZ
        iw/+YlP/Ro2y6sLmiUxJTNB6TjZohI+93RhTiQ7/yy4K
X-Google-Smtp-Source: AK7set+IydFkLYBqKZo5hwECOIoDIqKc9MbHNPs/CFSLMiIXPh25DogGB5WIwBlgpXsfxdM4f5MUHf3oNNCmXn1mgrA=
X-Received: by 2002:a17:906:4094:b0:8b1:28e5:a1bc with SMTP id
 u20-20020a170906409400b008b128e5a1bcmr9555160ejj.5.1678339188070; Wed, 08 Mar
 2023 21:19:48 -0800 (PST)
MIME-Version: 1.0
References: <20230308035416.2591326-4-andrii@kernel.org> <1399021d-b06a-447c-94ca-6cc657c9c0b2@kili.mountain>
In-Reply-To: <1399021d-b06a-447c-94ca-6cc657c9c0b2@kili.mountain>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Mar 2023 21:19:36 -0800
Message-ID: <CAEf4BzYzUmoeNPGbb+up8jRa1Q_BsQr4Sh+pb-X-SnswNW8hGA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/8] bpf: add support for open-coded iterator loops
To:     Dan Carpenter <error27@gmail.com>
Cc:     oe-kbuild@lists.linux.dev, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>
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

On Wed, Mar 8, 2023 at 8:35=E2=80=AFPM Dan Carpenter <error27@gmail.com> wr=
ote:
>
> Hi Andrii,
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bp=
f-factor-out-fetching-basic-kfunc-metadata/20230308-115539
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
master
> patch link:    https://lore.kernel.org/r/20230308035416.2591326-4-andrii%=
40kernel.org
> patch subject: [PATCH v4 bpf-next 3/8] bpf: add support for open-coded it=
erator loops
> config: loongarch-randconfig-m041-20230305 (https://download.01.org/0day-=
ci/archive/20230309/202303090153.YeswNcW4-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 12.1.0
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Link: https://lore.kernel.org/r/202303090153.YeswNcW4-lkp@intel.com/
>
> smatch warnings:
> kernel/bpf/verifier.c:1244 is_iter_reg_valid_uninit() error: uninitialize=
d symbol 'j'.
>
> vim +/j +1244 kernel/bpf/verifier.c
>
> 8f263e1296a91f Andrii Nakryiko 2023-03-07  1225  static bool is_iter_reg_=
valid_uninit(struct bpf_verifier_env *env,
> 8f263e1296a91f Andrii Nakryiko 2023-03-07  1226                          =
            struct bpf_reg_state *reg, int nr_slots)
> 8f263e1296a91f Andrii Nakryiko 2023-03-07  1227  {
> 8f263e1296a91f Andrii Nakryiko 2023-03-07  1228         struct bpf_func_s=
tate *state =3D func(env, reg);
> 8f263e1296a91f Andrii Nakryiko 2023-03-07  1229         int spi, i, j;
> 8f263e1296a91f Andrii Nakryiko 2023-03-07  1230
> 8f263e1296a91f Andrii Nakryiko 2023-03-07  1231         /* For -ERANGE (i=
.e. spi not falling into allocated stack slots), we
> 8f263e1296a91f Andrii Nakryiko 2023-03-07  1232          * will do check_=
mem_access to check and update stack bounds later, so
> 8f263e1296a91f Andrii Nakryiko 2023-03-07  1233          * return true fo=
r that case.
> 8f263e1296a91f Andrii Nakryiko 2023-03-07  1234          */
> 8f263e1296a91f Andrii Nakryiko 2023-03-07  1235         spi =3D iter_get_=
spi(env, reg, nr_slots);
> 8f263e1296a91f Andrii Nakryiko 2023-03-07  1236         if (spi =3D=3D -E=
RANGE)
> 8f263e1296a91f Andrii Nakryiko 2023-03-07  1237                 return tr=
ue;
> 8f263e1296a91f Andrii Nakryiko 2023-03-07  1238         if (spi < 0)
> 8f263e1296a91f Andrii Nakryiko 2023-03-07  1239                 return sp=
i;
> 8f263e1296a91f Andrii Nakryiko 2023-03-07  1240
> 8f263e1296a91f Andrii Nakryiko 2023-03-07  1241         for (i =3D 0; i <=
 nr_slots; i++) {
> 8f263e1296a91f Andrii Nakryiko 2023-03-07  1242                 struct bp=
f_stack_state *slot =3D &state->stack[spi - i];
> 8f263e1296a91f Andrii Nakryiko 2023-03-07  1243
> 8f263e1296a91f Andrii Nakryiko 2023-03-07 @1244                 if (slot-=
>slot_type[j] =3D=3D STACK_ITER)
>                                                                          =
           ^
> s/j/i/?
>

nope, I accidentally removed the inner for loop. I fixed all that in
v5, which was applied today. But thanks for the notification!

> 8f263e1296a91f Andrii Nakryiko 2023-03-07  1245                         r=
eturn false;
> 8f263e1296a91f Andrii Nakryiko 2023-03-07  1246         }
> 8f263e1296a91f Andrii Nakryiko 2023-03-07  1247
> 8f263e1296a91f Andrii Nakryiko 2023-03-07  1248         return true;
> 8f263e1296a91f Andrii Nakryiko 2023-03-07  1249  }
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
>
