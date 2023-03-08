Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757FC6B0FC8
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 18:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjCHRGU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 12:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjCHRGM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 12:06:12 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C31C78D8
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 09:05:58 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id j11so48949877edq.4
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 09:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678295157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dSIBHZShgDNyZL1npO1Q8csh+EoPik7yFTi46Ldsdk=;
        b=Uo9E9VDh/xbP8rRjf097dL5laxKmBy2kRlhQIM3m3TcHfPOneGkRCZPhaeLrJuiMF4
         c/rC0RHgABq2GuIPsj4hTSjdct9vjHOjzgXUZIViBzGMCSrLEWXGEcSL849EsQJd+pvG
         NTiOlZNpSdzNG+O1hPQGxBrE2nmu6HW3xBUubdThBxzXhDMluOy1UDJfw75Cz7qFhhgf
         /ji5RlsZn9rokIzbekEtxhQWcn3ys7y9miBV3xhHXgd5EP5ec1yKeavd83ozFOx+iwmu
         MxI0OqcY2NvBh17xZ0fJFIqm0yZrXM0+YBzKTTnnnbv4zaIAdvgqLbVtZsFjGdhqRysE
         sWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678295157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dSIBHZShgDNyZL1npO1Q8csh+EoPik7yFTi46Ldsdk=;
        b=OuoKTWbZvmUUEg97ihc8iE08DcVagvQFWCmTbaTlPzlkpz3ANbU/I3KbnbKh6QyGHD
         xaj+eVeIcFLyjDGiJY+n9Ntgsjr+sa6GNsmvLKpAiESX4PiKplqdKfD+z7GyVwZYl7Qq
         kNQ/MX40rjgGM7+A3qXJzdxDkmgbs5J/Dr+H1okfMOT3zRKNhE20OpXr9pdIdgI4Qx4c
         DWfCYoo3a7XgG72hgxyTykZHqIFO7+6k24gjp0ur+WOjjnz9bpxQcMpmvod1OpdOFnW8
         ttyz35GMEDC8L3wjPROLUvm7QrhvotWQKk+uzjmgr++3a6vN7GXkDKheWBHdBC+a+P5F
         f3bQ==
X-Gm-Message-State: AO0yUKVMZAtgsoPWpVb4aAmm56SGu+XERrmONArT4/G533pewbPNKiYd
        mlJutbDNyANTw/00UDSqIk7u6mvJvqDegIkIM5c=
X-Google-Smtp-Source: AK7set9MAA6a6ynFO+gDtutmyGvlPyt/4OzXqctsuhavf3gBNuMQnyPFgL6n6k0UoXXuy5mpHU9/Ab0EqCnH9V4GS08=
X-Received: by 2002:a17:906:4bcb:b0:8b1:28f6:8ab3 with SMTP id
 x11-20020a1709064bcb00b008b128f68ab3mr9586577ejv.15.1678295156815; Wed, 08
 Mar 2023 09:05:56 -0800 (PST)
MIME-Version: 1.0
References: <20230308035416.2591326-4-andrii@kernel.org> <202303082209.VIxMyiGz-lkp@intel.com>
In-Reply-To: <202303082209.VIxMyiGz-lkp@intel.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Mar 2023 09:05:44 -0800
Message-ID: <CAEf4BzbTsiFOQdCanh5DWwOg7dUZTtNBkUJDwg4jztw5dEWSdA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/8] bpf: add support for open-coded iterator loops
To:     kernel test robot <lkp@intel.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, kernel-team@meta.com,
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

On Wed, Mar 8, 2023 at 7:02=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Andrii,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bp=
f-factor-out-fetching-basic-kfunc-metadata/20230308-115539
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
master
> patch link:    https://lore.kernel.org/r/20230308035416.2591326-4-andrii%=
40kernel.org
> patch subject: [PATCH v4 bpf-next 3/8] bpf: add support for open-coded it=
erator loops
> config: hexagon-randconfig-r015-20230305 (https://download.01.org/0day-ci=
/archive/20230308/202303082209.VIxMyiGz-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 6740=
9911353323ca5edf2049ef0df54132fa1ca7)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/8f263e1296a91ff15=
4a033d7cffbac3ee0ebf2ae
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review Andrii-Nakryiko/bpf-factor-out-f=
etching-basic-kfunc-metadata/20230308-115539
>         git checkout 8f263e1296a91ff154a033d7cffbac3ee0ebf2ae
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=
=3D1 O=3Dbuild_dir ARCH=3Dhexagon olddefconfig
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=
=3D1 O=3Dbuild_dir ARCH=3Dhexagon SHELL=3D/bin/bash kernel/bpf/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303082209.VIxMyiGz-lkp@i=
ntel.com/
>
> All warnings (new ones prefixed by >>):
>
>    In file included from kernel/bpf/verifier.c:7:
>    In file included from include/linux/bpf-cgroup.h:5:
>    In file included from include/linux/bpf.h:31:
>    In file included from include/linux/memcontrol.h:13:
>    In file included from include/linux/cgroup.h:26:
>    In file included from include/linux/kernel_stat.h:9:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:11:
>    In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1=
:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/hexagon/include/asm/io.h:334:
>    include/asm-generic/io.h:547:31: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val =3D __raw_readb(PCI_IOBASE + addr);
>                              ~~~~~~~~~~ ^
>    include/asm-generic/io.h:560:61: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val =3D __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE +=
 addr));
>                                                            ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded fro=
m macro '__le16_to_cpu'
>    #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>                                                      ^
>    In file included from kernel/bpf/verifier.c:7:
>    In file included from include/linux/bpf-cgroup.h:5:
>    In file included from include/linux/bpf.h:31:
>    In file included from include/linux/memcontrol.h:13:
>    In file included from include/linux/cgroup.h:26:
>    In file included from include/linux/kernel_stat.h:9:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:11:
>    In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1=
:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/hexagon/include/asm/io.h:334:
>    include/asm-generic/io.h:573:61: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val =3D __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE +=
 addr));
>                                                            ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded fro=
m macro '__le32_to_cpu'
>    #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>                                                      ^
>    In file included from kernel/bpf/verifier.c:7:
>    In file included from include/linux/bpf-cgroup.h:5:
>    In file included from include/linux/bpf.h:31:
>    In file included from include/linux/memcontrol.h:13:
>    In file included from include/linux/cgroup.h:26:
>    In file included from include/linux/kernel_stat.h:9:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:11:
>    In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1=
:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/hexagon/include/asm/io.h:334:
>    include/asm-generic/io.h:584:33: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writeb(value, PCI_IOBASE + addr);
>                                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:594:59: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + add=
r);
>                                                          ~~~~~~~~~~ ^
>    include/asm-generic/io.h:604:59: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + add=
r);
>                                                          ~~~~~~~~~~ ^
> >> kernel/bpf/verifier.c:1244:23: warning: variable 'j' is uninitialized =
when used here [-Wuninitialized]
>                    if (slot->slot_type[j] =3D=3D STACK_ITER)
>                                        ^
>    kernel/bpf/verifier.c:1229:15: note: initialize the variable 'j' to si=
lence this warning
>            int spi, i, j;
>                         ^
>                          =3D 0
>    7 warnings generated.
>
>
> vim +/j +1244 kernel/bpf/verifier.c
>
>   1224
>   1225  static bool is_iter_reg_valid_uninit(struct bpf_verifier_env *env=
,
>   1226                                       struct bpf_reg_state *reg, i=
nt nr_slots)
>   1227  {
>   1228          struct bpf_func_state *state =3D func(env, reg);
>   1229          int spi, i, j;
>   1230
>   1231          /* For -ERANGE (i.e. spi not falling into allocated stack=
 slots), we
>   1232           * will do check_mem_access to check and update stack bou=
nds later, so
>   1233           * return true for that case.
>   1234           */
>   1235          spi =3D iter_get_spi(env, reg, nr_slots);
>   1236          if (spi =3D=3D -ERANGE)
>   1237                  return true;
>   1238          if (spi < 0)
>   1239                  return spi;

also, this should be return false

>   1240
>   1241          for (i =3D 0; i < nr_slots; i++) {
>   1242                  struct bpf_stack_state *slot =3D &state->stack[sp=
i - i];
>   1243

for (j =3D 0; j < BPF_REG_SIZE; j++) got lost during rebasing, sigh. I
have a test that's testing this exact condition to be checked
properly, and it is passing (that is proper return false is returned
here) consistently with the garbage value of j :(

Anyways, restored for loop here.

> > 1244                  if (slot->slot_type[j] =3D=3D STACK_ITER)
>   1245                          return false;
>   1246          }
>   1247
>   1248          return true;
>   1249  }
>   1250
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
