Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE99F52591B
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 02:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359155AbiEMAt7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 20:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357287AbiEMAt6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 20:49:58 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E174E16D5E8
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 17:49:56 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id o132so3474839vko.11
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 17:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=83o0Ss6BYiqL/LGviGVKlsserapDdnkGPhUKj7Syid8=;
        b=ekrhGwp+g3KWs/6PKg6nW02iacM901VQLehO3L/7NyIjcq/Y0e9AHIJUYR+ZWSM27s
         /FIPP8nq+M8PdDJGHax+PdZgbB558N9RZq/BHEi+L0B4FZcKboJXAaiX8xCU1+inEqC2
         mbodinbH8iNOkzKXUIh84ieUi9Jg+YbIG+0X+NtFYa/hZoDp7QwcSDpa87JVWonLuJic
         zsplb+wTyztZ/JUjGJNag7wHob3WmGTOwOsgxmx+clGMqXMH0jAPFB79tK6hdgICa0/y
         yLt4CgMuO1aFFKuo2Y1EetE261zdM4ZyD5hOvtYYRyU2rtZH/wQ6ZK+7aAP7K0F+5o9s
         ntcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=83o0Ss6BYiqL/LGviGVKlsserapDdnkGPhUKj7Syid8=;
        b=GnXVk3nc9iN1atjaLrqp2jtimsfFistHwQNpFwQluz3X1eFoCPHODi2IMz5X/moMNC
         ba2bPjXK7N0HvbFDCd9O3phclZVoTevn/WEfhBRth1SnZaW4hgujnMc6JEAUSVKjauRi
         beovoUDwzuTetgvGaGJgkgb2t8gW+m+P0YSa+b7sGD48YKhfz5Mz3BhBswUt3F9NV+vv
         zyxNVrWBfKlfKurAxwp8tbVJIWBBpPRarboShGMjXvvq59r+zRCuTlgydnTHvA2oLoCx
         zrTb2t6lfC8oD4Z5ZIgpTdKy/IQYe4yYIE2CvNCh65Et9ps5vSjTkX4GS6Bj/X2xW0+f
         2WJA==
X-Gm-Message-State: AOAM533YU6yO/KaG5/n4AmPH1ij1igsFhywKYMXfF+n1WtZoRxSArq6h
        lCwuOxze9dpLG2zdfBsimMy+1JR9q5ACRl0Y6PVAk6h5FVM=
X-Google-Smtp-Source: ABdhPJxhIfYlaUMhD9cya7smCBM0UlAcsd2Yrn0iYMaeKCmEbGtOjw4dxHKetpqRCJPBiOsdg2AP+ttopR3a6MjfLtY=
X-Received: by 2002:a1f:6003:0:b0:34d:3d07:5827 with SMTP id
 u3-20020a1f6003000000b0034d3d075827mr1468561vkb.30.1652402995630; Thu, 12 May
 2022 17:49:55 -0700 (PDT)
MIME-Version: 1.0
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Thu, 12 May 2022 17:49:44 -0700
Message-ID: <CAK3+h2zMMMir6_ut=fb7gGj0Merzsc9vksG3fmt9JazCvk2=WA@mail.gmail.com>
Subject: bpf selftest compiling error
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I cloned the bpf-next and tried to compile the bpf selftest.

first I got error

"
CC      /usr/src/bpf
next/tools/testing/selftests/bpf/tools/build/bpftool/xlated_dumper.o

make[1]: *** No rule to make target
'/usr/src/bpf-next/tools/include/asm-generic/bitops/find.h', needed by
'/usr/src/bpf-next/tools/testing/selftests/bpf/tools/build/bpftool/btf_dumper.o'.
Stop.

I could not find find.h in
/usr/src/bpf-next/tools/include/asm-generic/bitops/find.h but I found
it in /usr/src/bpf-next/tools/include/linux/find.h, copied it to
/usr/src/bpf-next/tools/include/asm-generic/bitops, seems resolved the
problem,

then I got another error below,

  CLNG-BPF [test_maps] map_kptr.o

progs/map_kptr.c:7:29: error: unknown attribute 'btf_type_tag' ignored
[-Werror,-Wunknown-attributes]

        struct prog_test_ref_kfunc __kptr *unref_ptr;

                                   ^~~~~~

/usr/src/bpf-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:176:31:
note: expanded from macro '__kptr'

#define __kptr __attribute__((btf_type_tag("kptr")))

                              ^~~~~~~~~~~~~~~~~~~~

progs/map_kptr.c:8:29: error: unknown attribute 'btf_type_tag' ignored
[-Werror,-Wunknown-attributes]

        struct prog_test_ref_kfunc __kptr_ref *ref_ptr;

                                   ^~~~~~~~~~

/usr/src/bpf-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:177:35:
note: expanded from macro '__kptr_ref'

#define __kptr_ref __attribute__((btf_type_tag("kptr_ref")))
"

my clang is 12.0.1 and installed new clang from llvm github repository

clang version 15.0.0 (https://github.com/llvm/llvm-project.git
e91a73de24d60954700d7ac0293c050ab2cbe90b)

it resolved the problem, but now I got error

  GEN-SKEL [test_progs] test_bpf_nf.skel.h

libbpf: failed to find BTF info for global/extern symbol 'bpf_skb_ct_lookup'

Error: failed to link
'/usr/src/bpf-next/tools/testing/selftests/bpf/test_bpf_nf.o': Unknown
error -2 (-2)

make: *** [Makefile:508:
/usr/src/bpf-next/tools/testing/selftests/bpf/test_bpf_nf.skel.h]
Error 254

running out of ideas on how to fix the compiling error. I hope I am
not doing something wrong :)
