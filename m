Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BF252CE37
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 10:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiESIVi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 May 2022 04:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbiESIVa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 04:21:30 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB24D5C864
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 01:21:28 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id t144so2367429oie.7
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 01:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4tLKMgEJGLvZmPArAan29FYAeEMaYXSc4ZSFwCgmBT4=;
        b=o6WiBmPUy6vK4XpMrjo7Op9fppIF4JTUTgUTkAKrGJ/YlCi22k0AnjmxfR+lz4EHl1
         5A/6wB9k1AQ51kNI/LWeFRIh7EvZqAybKrToKh5I5bQLLCRe3xb0GVC3zCpWsjpYEWuY
         jtxB1m+4Lz6ScQ0CUK7/ofxA5OrUUvWLu5jsRCusYt7ZCZTWv/2zY36ZEWC7ATGQ3dsw
         bsE2NpXlCi4npuPOk4GE92hJBx1lcjj6aM4yoTpELERJ7WMuUJDCgQdKQ/uET8C+B0pF
         Q/UTQb5fVrXuVvtZKWYbBVidbXhOVIQQTFFO3tFSxbiLiMgFaAX7/CGgh+/EGXBDHAtL
         93Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4tLKMgEJGLvZmPArAan29FYAeEMaYXSc4ZSFwCgmBT4=;
        b=ndvZNHMAjxSqi6iP8h+qgXetnJmqZzQB8kxz1hEi+d6UvBAD5SuUAJuEGFZyLF2KbI
         xEa3jkwPXYGCleTPfhMm12bA6x7uMiyk1S4bQywsfLgR/Lz6xNDOuKEp6tHGyVPN+jfQ
         RAIzETby+aCOdGgfzPwjR3ukPyIdSbVsz8Gxyk5f5+HBHr2kGn86XBQn9DnZcVV1Dk0o
         3Lb8V+0xiN5aIDmngLCKXBw85OohPO/rKxbcjGo5elHtzWGFkOaVwBm7ZHny6oOmtz5W
         jZtq/0nVJZi+CAFfjwi6PxVWF1tG0LmQhlGlweufQ+s6BuSUmeNSpfq5x+9kvKp1sqDy
         9QNw==
X-Gm-Message-State: AOAM533A09nmOUarWERN6p1cfTu2LCDo9np1k0tNPo3dtJtzGQgYpOzO
        ECiRGU89quRy94nEhJiy02Zb3LSYOPv+0Q==
X-Google-Smtp-Source: ABdhPJyfh+zaTerl2wts5RZoK7cTvK8W3ddW/dGuTNW6cXlQNgYBIiRfSAjUrQCxtPGYMFjBgpHKjQ==
X-Received: by 2002:a05:6808:2208:b0:326:9989:5d8 with SMTP id bd8-20020a056808220800b00326998905d8mr2128772oib.23.1652948487757;
        Thu, 19 May 2022 01:21:27 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id o19-20020a056870969300b000e932746d33sm2024134oaq.28.2022.05.19.01.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 01:21:27 -0700 (PDT)
Date:   Thu, 19 May 2022 09:21:01 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc:     Vincent Li <vincent.mc.li@gmail.com>, bpf <bpf@vger.kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: bpf selftest compiling error
Message-ID: <YoX97QJ976GelRw6@myrica>
References: <CAK3+h2zMMMir6_ut=fb7gGj0Merzsc9vksG3fmt9JazCvk2=WA@mail.gmail.com>
 <CAK3+h2z74LZ5OFQxNDktex8WYxpYhycQxaWt=KqqW3ZsTu1nwg@mail.gmail.com>
 <YoUIAFPYea86JvDx@syu-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoUIAFPYea86JvDx@syu-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On Wed, May 18, 2022 at 10:51:44PM +0800, Shung-Hsi Yu wrote:
> On Thu, May 12, 2022 at 06:12:36PM -0700, Vincent Li wrote:
> > On Thu, May 12, 2022 at 5:49 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > I cloned the bpf-next and tried to compile the bpf selftest.
> > >
> > > first I got error
> > >
> > > "
> > > CC      /usr/src/bpf
> > > next/tools/testing/selftests/bpf/tools/build/bpftool/xlated_dumper.o
> > >
> > > make[1]: *** No rule to make target
> > > '/usr/src/bpf-next/tools/include/asm-generic/bitops/find.h', needed by
> > > '/usr/src/bpf-next/tools/testing/selftests/bpf/tools/build/bpftool/btf_dumper.o'.
> > > Stop.
> 
> I also ran into the same issue on bpf-next, and the error seems rather
> absurd as
> 
>   1. asm-generic/bitops/find.h was removed back in 47d8c15615c0a "include:
>      move find.h from asm_generic to linux", so perhaps this error has
>      something to do with Makefile.asm-generic
>   2. normal way of building bpftool with `make tools/bpf/bpftool` still
>      works fine
> 
> Anyway removing ARCH= CROSS_COMPILE= in the bpf selftests Makefile
> (reverting change added in ea79020a2d9e "selftests/bpf: Enable
> cross-building with clang") can be used as a workaround to get the build
> working again. Adding the commit author to the thread to see if there is
> better approach available.

Could you share the commands that lead to this error?  And did you make
sure to clean the build tree?  I often get errors when building tools
because my toolchains changed and some dependencies in generated .*.d
files do not exist anymore.

I can't reproduce this specific error on today's linux-next (but found
another issue with out-of-tree build that I'll investigate). This is what
I run, on an x86 host for an x86 target:

 $ make defconfig
 $ cat tools/testing/selftests/bpf/config >> .config
   # and enable CONFIG_DEBUG_INFO_BTF
 $ make
 $ make -C tools/testing/selftests TARGETS=bpf SKIP_TARGETS=

Thanks,
Jean

> 
> 
> Best,
> Shung-Hsi
> 
> > > I could not find find.h in
> > > /usr/src/bpf-next/tools/include/asm-generic/bitops/find.h but I found
> > > it in /usr/src/bpf-next/tools/include/linux/find.h, copied it to
> > > /usr/src/bpf-next/tools/include/asm-generic/bitops, seems resolved the
> > > problem,
> > >
> > > then I got another error below,
> > >
> > >   CLNG-BPF [test_maps] map_kptr.o
> > >
> > > progs/map_kptr.c:7:29: error: unknown attribute 'btf_type_tag' ignored
> > > [-Werror,-Wunknown-attributes]
> > >
> > >         struct prog_test_ref_kfunc __kptr *unref_ptr;
> > >
> > >                                    ^~~~~~
> > >
> > > /usr/src/bpf-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:176:31:
> > > note: expanded from macro '__kptr'
> > >
> > > #define __kptr __attribute__((btf_type_tag("kptr")))
> > >
> > >                               ^~~~~~~~~~~~~~~~~~~~
> > >
> > > progs/map_kptr.c:8:29: error: unknown attribute 'btf_type_tag' ignored
> > > [-Werror,-Wunknown-attributes]
> > >
> > >         struct prog_test_ref_kfunc __kptr_ref *ref_ptr;
> > >
> > >                                    ^~~~~~~~~~
> > >
> > > /usr/src/bpf-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:177:35:
> > > note: expanded from macro '__kptr_ref'
> > >
> > > #define __kptr_ref __attribute__((btf_type_tag("kptr_ref")))
> > > "
> > >
> > > my clang is 12.0.1 and installed new clang from llvm github repository
> > >
> > > clang version 15.0.0 (https://github.com/llvm/llvm-project.git
> > > e91a73de24d60954700d7ac0293c050ab2cbe90b)
> > >
> > > it resolved the problem, but now I got error
> > >
> > >   GEN-SKEL [test_progs] test_bpf_nf.skel.h
> > >
> > > libbpf: failed to find BTF info for global/extern symbol 'bpf_skb_ct_lookup'
> > >
> > > Error: failed to link
> > > '/usr/src/bpf-next/tools/testing/selftests/bpf/test_bpf_nf.o': Unknown
> > > error -2 (-2)
> > >
> > > make: *** [Makefile:508:
> > > /usr/src/bpf-next/tools/testing/selftests/bpf/test_bpf_nf.skel.h]
> > > Error 254
> > >
> > > running out of ideas on how to fix the compiling error. I hope I am
> > > not doing something wrong :)
> > 
> > I recompiled the bpf-next kernel tree after clang 15 installation with
> > make bzImage; make modules; make and then recompiled bpf selftest, all
> > compiling errors are gone, sorry for the noise.
> 
