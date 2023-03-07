Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA9D6AFA9C
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 00:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjCGXjS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 18:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCGXjC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 18:39:02 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7271AABB30
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 15:38:44 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g3so59184578eda.1
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 15:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678232323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsjKpk5Xp/eDGweOvjrgV/4B1gupExWnHgnL/97NTFA=;
        b=J/dHIop6AscTHTN1ibeEPYzc2UGFHsFEw4lw8eW9l6HfelpgPoP44iuaQCYPJDtWA5
         50bO3kSeO0b1b6eCXeHHiFLYo+bGD3ijHInV7tNl1ebD1LX8W3i0j9m2Fs73oKthso7/
         goOe2kHMVjEOUNHPxH66fb054dDL341ZIM9ZKvmvgekAbD6PIB6bvpT9F5FwcScLwBXa
         Op1+PtBGHCIv7rbFSyr9BXGDA4AYOgdi2i6KMRUB5o4/WAMLvoClIvBzfYatb3uZqwTT
         R2cvGugjF5urBtQBz9k+cyS6iC0ME07jOjA8/knHllojSPujm9UrL6qR4WIhXsoKcoeq
         jjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678232323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsjKpk5Xp/eDGweOvjrgV/4B1gupExWnHgnL/97NTFA=;
        b=MkYZcM4xN7kGLi+ZJs+XfNdM/JneG0YqEvT/rX9ZvDx6Us549qi2amzUNju+Q61Ah6
         AXDTrZb3ZQ6xTuYC+kwP/sFASna6vHMuLKkv1Dzob+mP9Uyx6j1bSuDIgPunn8CkkDfO
         iL3JVe34E2sQ1StGl6wb4IRU9xjpCcZ6260cP5u20RfKsLUy3qtGHPrTs7GKnQAl2yia
         5P91U81/I0awZFMhtIC1Jv8XnMYWuNPH0ApL6CacymSreVSMRuJQDvsA/WYXgekuLYbN
         oJfcp1JWaZWgdT3WLZQSzYUILg0PyQBne4dK/KtLV1SfVY/bDG7gaEdq7dzLdtiojlhj
         Lmfg==
X-Gm-Message-State: AO0yUKW+ilXdhVldYWMXfmDpNscLNBvDR2c45wJDgjH2SAPZCGOjc4Av
        Dy1M6vIB2+wW3cOUXOh1EAWMKfBBdzTviZ1Uj7A=
X-Google-Smtp-Source: AK7set/phfMctxOrcMqR9vhMN1i2+OrLdTUQdqxNXTtwG9WVbprWdNgH3sU/zPvWs34KP3PM6Pnt+UReg28fT8V/Fhc=
X-Received: by 2002:a50:cd94:0:b0:4c2:1a44:642e with SMTP id
 p20-20020a50cd94000000b004c21a44642emr9208296edi.5.1678232322815; Tue, 07 Mar
 2023 15:38:42 -0800 (PST)
MIME-Version: 1.0
References: <20230307215329.3895377-4-andrii@kernel.org> <202303080733.7uzHxIB0-lkp@intel.com>
In-Reply-To: <202303080733.7uzHxIB0-lkp@intel.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Mar 2023 15:38:30 -0800
Message-ID: <CAEf4BzYPu5ABeEcwoGTKnjEb5=jYj772KQ0nW9Ub21-8SVqvVQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/8] bpf: add support for open-coded iterator loops
To:     kernel test robot <lkp@intel.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net,
        oe-kbuild-all@lists.linux.dev, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 7, 2023 at 3:27=E2=80=AFPM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Andrii,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bp=
f-factor-out-fetching-basic-kfunc-metadata/20230308-055530
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
master
> patch link:    https://lore.kernel.org/r/20230307215329.3895377-4-andrii%=
40kernel.org
> patch subject: [PATCH v2 bpf-next 3/8] bpf: add support for open-coded it=
erator loops
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/202303=
08/202303080733.7uzHxIB0-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/9eada50b93c4fc3f4=
1032699fda73bc125b37d0e
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review Andrii-Nakryiko/bpf-factor-out-f=
etching-basic-kfunc-metadata/20230308-055530
>         git checkout 9eada50b93c4fc3f41032699fda73bc125b37d0e
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Dm68k olddefconfig
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Dm68k SHELL=3D/bin/bash kernel/bpf/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303080733.7uzHxIB0-lkp@i=
ntel.com/
>
> All warnings (new ones prefixed by >>):
>
>    kernel/bpf/verifier.c: In function 'is_iter_reg_valid_init':
> >> kernel/bpf/verifier.c:1255:32: warning: variable 't' set but not used =
[-Wunused-but-set-variable]
>     1255 |         const struct btf_type *t;
>          |                                ^
>
>
> vim +/t +1255 kernel/bpf/verifier.c
>
>   1250
>   1251  static bool is_iter_reg_valid_init(struct bpf_verifier_env *env, =
struct bpf_reg_state *reg,
>   1252                                     struct btf *btf, u32 btf_id, i=
nt nr_slots)
>   1253  {
>   1254          struct bpf_func_state *state =3D func(env, reg);
> > 1255          const struct btf_type *t;
>   1256          int spi, i, j;
>   1257
>   1258          spi =3D iter_get_spi(env, reg, nr_slots);
>   1259          if (spi < 0)
>   1260                  return false;
>   1261
>   1262          t =3D btf_type_by_id(btf, btf_id);

some leftover from early v2 attempts, doh

I'll wait an hour or two for some other feedback before spamming with v4

>   1263
>   1264          for (i =3D 0; i < nr_slots; i++) {
>   1265                  struct bpf_stack_state *slot =3D &state->stack[sp=
i - i];
>   1266                  struct bpf_reg_state *st =3D &slot->spilled_ptr;
>   1267
>   1268                  /* only main (first) slot has ref_obj_id set */
>   1269                  if (i =3D=3D 0 && !st->ref_obj_id)
>   1270                          return false;
>   1271                  if (i !=3D 0 && st->ref_obj_id)
>   1272                          return false;
>   1273                  if (st->iter.btf !=3D btf || st->iter.btf_id !=3D=
 btf_id)
>   1274                          return false;
>   1275
>   1276                  for (j =3D 0; j < BPF_REG_SIZE; j++)
>   1277                          if (slot->slot_type[j] !=3D STACK_ITER)
>   1278                                  return false;
>   1279          }
>   1280
>   1281          return true;
>   1282  }
>   1283
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
