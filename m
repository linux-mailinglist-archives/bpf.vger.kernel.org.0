Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CFB59FD5C
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 16:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbiHXOgX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 10:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237870AbiHXOgW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 10:36:22 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF655659E3;
        Wed, 24 Aug 2022 07:36:20 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id m2so15856073pls.4;
        Wed, 24 Aug 2022 07:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc;
        bh=yOGscZMB2IfEE9GO6ehfTL0vfy1GrfbiQf3a0wwTjh8=;
        b=E4C6bjT6F28zYfIx9m6O13cGGtMwfdmtNUZiOpsX640b9zAUnOzE4RoIgGx/iAZDCm
         dvXeuCtLg3IZ/hio5VAFOIQ9EwKWiCGPg07ou8t6hgNxS6ihRQO8CpKmJ53dW+LUvDQn
         0Zy2yRSvxJ34seAtgSMF5lsLEpKGVA8R8hPx1IaR7Twff8/Sph6YRlU/n15jEn9smqJn
         nNBY8E8jxRsHmgEC//tr7SU3twO7O13hUyyMojAZTtCxeLMvIrdql1E30uzVzbR0poxB
         zoxqpRcurxRea5sHc44HUwFAZGV8vNBu7VmMzrV8MuiYQgxDsnMlLsxVQmgidMJri0Dc
         c3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=yOGscZMB2IfEE9GO6ehfTL0vfy1GrfbiQf3a0wwTjh8=;
        b=hk0ZRQHuRHYNvyOSRyjfUYRR32kbWq9zZ4zc60L3YrbpSCPb2JorK5jmkzFscU0O49
         PnYs/GWUhw1TYwUvYBQiO4Y08/Uo8ucaGBF4yX9CrSEIPGu6X7T/nO8k9rHHVNMGaQ3s
         EuHnXVgGw+9NZiXe7YTB6FmKkmf1whOxpAumdbgib6CsmSN7/XuLuTppNGr6Q8BpzNGn
         nWxSyPLzBR33X7rOf28tfYuWqeaELYZLQUcJ9pLhsylnVpaO+cr/sevwBQVJGVMPVOLH
         d57VeXn3CnN9PL4e6ReOHJ9pkoxccWVJWZ8/s2Om6EGcFw1NHDoBYqiyKzFYUETr0xdF
         dsog==
X-Gm-Message-State: ACgBeo31DUMOt46Pp/pIFVAkHImkjyA0Mv7y8e61XDVOj9ZS63gQACra
        vZtJW6y04lH3pmo+2Q9s2sv9Z7b+SP1Jchjt3ujNjppv3GI=
X-Google-Smtp-Source: AA6agR6f5K9+s41rtISLCpcnTpxv/3C/l/IOlLmZ9DfGEwSStFpqbZmtwDptqrFxv1g+lxXPpCJPACTvOJ45JyYoirk=
X-Received: by 2002:a17:90b:4a88:b0:1fb:36b7:7f8e with SMTP id
 lp8-20020a17090b4a8800b001fb36b77f8emr8441974pjb.22.1661351780353; Wed, 24
 Aug 2022 07:36:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:612:b0:43:c853:4cf0 with HTTP; Wed, 24 Aug 2022
 07:36:18 -0700 (PDT)
In-Reply-To: <YwY2mFuJP10dehRx@kernel.org>
References: <YwQRKkmWqsf/Du6A@kernel.org> <CADo9pHhW9w+ciNbQr+7u4mezuQ1USyh0k2Wshy=wkdEcxRiDLA@mail.gmail.com>
 <YwY2mFuJP10dehRx@kernel.org>
From:   Luna Jernberg <droidbittin@gmail.com>
Date:   Wed, 24 Aug 2022 16:36:18 +0200
Message-ID: <CADo9pHheRprMRAZkcxcALRv7gi8r+_CpNBP+LB4rt0n-_ZMQ4Q@mail.gmail.com>
Subject: Re: ANNOUNCE: pahole v1.24 (Faster BTF encoding, 64-bit BTF enum entries)
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        droidbittin@gmail.com
Cc:     dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alibek Omarov <a1ba.omarov@gmail.com>,
        Kornilios Kourtis <kornilios@isovalent.com>,
        Kui-Feng Lee <kuifeng@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The Nvidia driver breaks

On 8/24/22, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> Em Wed, Aug 24, 2022 at 03:23:29PM +0200, Luna Jernberg escreveu:
>> This package breaks on Arch Linux at the moment and if you are using Arch
>> its recommended that you downgrade to 1.23
>
> Breaks in what sense? Can you please provide details?
>
> - Arnaldo
>
>> On Tue, Aug 23, 2022 at 1:59 AM Arnaldo Carvalho de Melo
>> <acme@kernel.org>
>> wrote:
>>
>> > Hi,
>> >
>> >         The v1.24 release of pahole and its friends is out, with faster
>> > BTF generation by parallelizing the encoding part in addition to the
>> > previoulsy parallelized DWARF loading, support for 64-bit BTF
>> > enumeration
>> > entries, signed BTF encoding of 'char', exclude/select DWARF loading
>> > based on the language that generated the objects, etc.
>> >
>> > Main git repo:
>> >
>> >    git://git.kernel.org/pub/scm/devel/pahole/pahole.git
>> >
>> > Mirror git repo:
>> >
>> >    https://github.com/acmel/dwarves.git
>> >
>> > tarball + gpg signature:
>> >
>> >    https://fedorapeople.org/~acme/dwarves/dwarves-1.24.tar.xz
>> >    https://fedorapeople.org/~acme/dwarves/dwarves-1.24.tar.bz2
>> >    https://fedorapeople.org/~acme/dwarves/dwarves-1.24.tar.sign
>> >
>> >         Thanks a lot to all the contributors and distro packagers,
>> > you're
>> > on the
>> > CC list, I appreciate a lot the work you put into these tools,
>> >
>> > Best Regards,
>> >
>> > BTF encoder:
>> >
>> > - Add support to BTF_KIND_ENUM64 to represent enumeration entries with
>> >   more than 32 bits.
>> >
>> > - Support multithreaded encoding, in addition to DWARF multithreaded
>> >   loading, speeding up the process.
>> >
>> >   Selected just like DWARF multithreaded loading, using the 'pahole -j'
>> >   option.
>> >
>> > - Encode 'char' type as signed.
>> >
>> > BTF Loader:
>> >
>> > - Add support to BTF_KIND_ENUM64.
>> >
>> > pahole:
>> >
>> > - Introduce --lang and --lang_exclude to specify the language the
>> >   DWARF compile units were originated from to use or filter.
>> >
>> >   Use case is to exclude Rust compile units while aspects of the
>> >   DWARF generated for it get sorted out in a way that the kernel
>> >   BPF verifier don't refuse loading the BTF generated from them.
>> >
>> > - Introduce --compile to generate compilable code in a similar fashion
>> > to:
>> >
>> >    bpftool btf dump file vmlinux format c > vmlinux.h
>> >
>> >   As with 'bpftool', this will notice type shadowing, i.e. multiple
>> > types
>> >   with the same name and will disambiguate by adding a suffix.
>> >
>> > - Don't segfault when processing bogus files.
>> >
>
> --
>
> - Arnaldo
>
