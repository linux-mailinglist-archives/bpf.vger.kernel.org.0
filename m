Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1903F2B007E
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 08:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbgKLHpV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 02:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgKLHpT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 02:45:19 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6347CC0613D1;
        Wed, 11 Nov 2020 23:45:18 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id k7so2361631plk.3;
        Wed, 11 Nov 2020 23:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=geTkkLYkNmham7L8WOSL9oUt7IUhwr3Ml72iGwW862I=;
        b=mikqjdLfhtLjRmLiBKDPWoaUsu6D574KKtiGoErbQ+31qIaxQAM5B2+ghSvUZuOHoa
         qUfiwpIJ6tWoqhEmUoRVo3U6qjMK4kh/LRW50zPKxiMc9nosGgLqEvBvX9IwoAX2oAYL
         0wewL+PCnot4CwESBHWYM6gB+QqtcBcxQtFRltqpd7t+/HiaMiXSTMLqXBFWGkID7yky
         sSKQfy6lhiQO65gPR+mR9oKyTc+qkurJtybeEIgMR3K7loP0peSeiZBnr/aeP/DDh9af
         xV4ABN48tAcCEMoHT6AWTInQTnY2WEaxBfu7ClCLMUePGM1lWXKOp4riaOGb1MBzA709
         Vfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=geTkkLYkNmham7L8WOSL9oUt7IUhwr3Ml72iGwW862I=;
        b=YCh2c9vdJPh+G7beBCQtUV3TIGdq9MpTpW2Wk+1gTFKof5Ru03c9nGY7t0B/PwNnsT
         sNbg9gmxwI/JlWMUfTOYV9tiKUEsqM/BY57Fw9ghXOJan5BLaxVqgW8rQpL/+hYz1cXk
         uUqJOEzODeWwD4GtbVH3ycAy4htTemtaCLcUJjH1hk105zTNGz5h2loLwbJK7K/HjSfb
         OM1gcnmv0vSXo/sy1Y04npz5P4QQzC2SVQ7TyHqfN05ZfgRKXL3tfU5no7Iahhdjbqr/
         cSdcv3ldyrmZZmgR8TM4ELqQ3LSY4/4dfBUeFK8OspqAo6PhPFtLA2pGIRT+PaAilxmb
         2GkQ==
X-Gm-Message-State: AOAM533jyViTOFAUfS7O55FGATosZyYAI7S3pbeuk1tVr2a31K+kZ0vL
        vU3aohRN0V6BYvOPgnqRmw712r5LTX3sJkKcObUDIkjVylie5jZqk4w=
X-Google-Smtp-Source: ABdhPJxYFtoP/QNAzFUFI8w6Wtq6gwXRueaKZmX0iGBcJUVwhNadNUwxxnG+1CmhmiOnRi/QxemcO8b3/wIkRAqeQ+Q=
X-Received: by 2002:a17:902:8d97:b029:d8:94dd:43ea with SMTP id
 v23-20020a1709028d97b02900d894dd43eamr12515950plo.43.1605167117901; Wed, 11
 Nov 2020 23:45:17 -0800 (PST)
MIME-Version: 1.0
References: <1605006094-31097-6-git-send-email-magnus.karlsson@gmail.com>
 <202011110934.GFwFDfqe-lkp@intel.com> <CAJ8uoz2aDjLPtcTgZ_pO-=S9TgXm3c57rN8TTPXdqT7HOOKrhA@mail.gmail.com>
 <CAKwvOd=Pws8npXdRuOVz+cgUYJ+nnztZCgMnZvP+Jr-dJ4z_Aw@mail.gmail.com>
In-Reply-To: <CAKwvOd=Pws8npXdRuOVz+cgUYJ+nnztZCgMnZvP+Jr-dJ4z_Aw@mail.gmail.com>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Thu, 12 Nov 2020 08:45:06 +0100
Message-ID: <CAJ8uoz2PxgZybUKDpe0Y4OJOHmK3gAxU7diTc1raPJoanze4sA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/5] i40e: use batched xsk Tx interfaces to
 increase performance
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     kernel test robot <lkp@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        bpf <bpf@vger.kernel.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 11, 2020 at 8:16 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Nov 11, 2020 at 3:57 AM Magnus Karlsson
> <magnus.karlsson@gmail.com> wrote:
> >
> > On Wed, Nov 11, 2020 at 2:38 AM kernel test robot <lkp@intel.com> wrote:
> > >
> > > Hi Magnus,
> > >
> > > I love your patch! Perhaps something to improve:
> > >
> > > [auto build test WARNING on bpf-next/master]
> > >
> > > url:    https://github.com/0day-ci/linux/commits/Magnus-Karlsson/xsk-i40e-Tx-performance-improvements/20201110-190310
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> > > config: powerpc64-randconfig-r025-20201110 (attached as .config)
> > > compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 4d81c8adb6ed9840257f6cb6b93f60856d422a15)
>
> ^ Note: clang
>
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # install powerpc64 cross compiling tool for clang build
> > >         # apt-get install binutils-powerpc64-linux-gnu
> > >         # https://github.com/0day-ci/linux/commit/b016bbeac6692a93e61b28efa430d64645032b5e
> > >         git remote add linux-review https://github.com/0day-ci/linux
> > >         git fetch --no-tags linux-review Magnus-Karlsson/xsk-i40e-Tx-performance-improvements/20201110-190310
> > >         git checkout b016bbeac6692a93e61b28efa430d64645032b5e
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc64
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > > >> drivers/net/ethernet/intel/i40e/i40e_xsk.c:417:13: warning: unknown pragma ignored [-Wunknown-pragmas]
> > >    #pragma GCC unroll 4
> > >                ^
> > >    1 warning generated.
> >
> > And I was hoping that unknown pragmas would be ignored, but that will
> > obviously not be the case with -Wunknown-pragmas added. The unrolling
> > of this inner loop where the code spends most of its time gives me
> > nearly 1 Mpps extra in performance which is substantial, so I would
> > like to get this unrolled in some way, but without the warning. Need
> > some advice please. Here are some options that comes in mind:
> >
> > #1: Suppress unknown pragma warnings in this file only by adding
> > CFLAGS_i40e_xsk.o += -Wno-unknown-pragmas (or whatever that option
> > might be) in the Makefile
> >
> > #2: Force the compiler to loop-unroll the loop with for example a
> > switch statement with four cases that all fall through. This will make
> > the code less readable.
> >
> > #3: Manually loop-unroll the loop. This will make the code even less
> > readable than #2.
>
> #4 support both compilers.  Note Clang's syntax is slightly different
> here; it doesn't accept GCC specific pragmas, and uses a slightly
> different form:
> https://clang.llvm.org/docs/LanguageExtensions.html#loop-unrolling .
> If you wrap that in a macro based on `#ifdef __clang__`, that should
> do the trick.

Yes, that did the trick. Tried it out with the compiler explorer at
https://godbolt.org/ and it compiles nicely even for clang-powerpc64.
Will spin a v3.

Thank you: Magnus

> >
> > I prefer #1 as I like to keep the code readable, but you might have
> > other better suggestions on how to tackle this.
> >
> > Thanks: Magnus
> >
> > > vim +417 drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > >
> > >    408
> > >    409  static void i40e_xmit_pkt_batch(struct i40e_ring *xdp_ring, struct xdp_desc *desc,
> > >    410                                  unsigned int *total_bytes)
> > >    411  {
> > >    412          u16 ntu = xdp_ring->next_to_use;
> > >    413          struct i40e_tx_desc *tx_desc;
> > >    414          dma_addr_t dma;
> > >    415          u32 i;
> > >    416
> > >  > 417  #pragma GCC unroll 4
> > >    418          for (i = 0; i < PKTS_PER_BATCH; i++) {
> > >    419                  dma = xsk_buff_raw_get_dma(xdp_ring->xsk_pool, desc[i].addr);
> > >    420                  xsk_buff_raw_dma_sync_for_device(xdp_ring->xsk_pool, dma, desc[i].len);
> > >    421
> > >    422                  tx_desc = I40E_TX_DESC(xdp_ring, ntu++);
> > >    423                  tx_desc->buffer_addr = cpu_to_le64(dma);
> > >    424                  tx_desc->cmd_type_offset_bsz = build_ctob(I40E_TX_DESC_CMD_ICRC |
> > >    425                                                            I40E_TX_DESC_CMD_EOP,
> > >    426                                                            0, desc[i].len, 0);
> > >    427
> > >    428                  *total_bytes += desc[i].len;
> > >    429          }
> > >    430
> > >    431          xdp_ring->next_to_use = ntu;
> > >    432  }
> > >    433
> > >
> > > ---
> > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> >
> > --
> > You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/CAJ8uoz2aDjLPtcTgZ_pO-%3DS9TgXm3c57rN8TTPXdqT7HOOKrhA%40mail.gmail.com.
>
>
>
> --
> Thanks,
> ~Nick Desaulniers
