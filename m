Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A7959FD66
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 16:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239254AbiHXOix (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 10:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239249AbiHXOiv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 10:38:51 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F76772699;
        Wed, 24 Aug 2022 07:38:49 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id w138so14060920pfc.10;
        Wed, 24 Aug 2022 07:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc;
        bh=O8Eg36Ffx6Gil1pdHSRdBpAEmvA3QInop4zEY4nz4iM=;
        b=Qxv7kPu6yG7d4JQ4Oh6I76Q65K7QXy6NYL+blakdPKPRw0ECWhhpCciskSDjLWSjVp
         k3bxNLQnFqfZ7WK9lLE+C7/6vEv2f2JRdQOh2Za+0uHv0C5lkEvYjkjFE/N4imon0qFC
         VxY2e456bRGEOXqFI+Dny7/2pALQQujHdqoAFuGsy8iGlqmaNJ1epWQvL3f1zaH+f0Dr
         8PvyA/MzlF02x1AdJs1JdfI0R1PzeBudsGr5PIEcB7u57IaWpmpVKVZPJ1GjMCV9TeTg
         MG+CGc+68Bcyz2w78JA3sQ8SNDwxdoHY+4BhlSbtYVeuJAr4H6tm0O9CszsSbS81LxCi
         vAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=O8Eg36Ffx6Gil1pdHSRdBpAEmvA3QInop4zEY4nz4iM=;
        b=XrqJNfcsbHOZ0wWraxhe3KTGIEkHh0nQMj6K6IqfaXpnlPhNVlH+K3kzbHyJmf6ZpK
         Gx02iHPdD8YqI8Vqw8y3mb3s1TY6OM7WQIY5j953nk32Dec9qVeY4BVDJ6c3150L/4Rs
         wM3pu7DT2f6xstOcx2eHyYt7TO9L0xNNm78k+t7+IL3mMlQjeh4qyABktCg3j6ztGk+y
         jC9xfqO1eZop9rkYVEuQ68Egod+Lex+ex5XqeWiXikFBkjs9mW0TJ7SKkpj4NeJU2ZaH
         eB03bLiTgIyrGnlb3EykeV8Zfj4/snuhzihIaVcpCMyoRnEF7UUJuc887Dznb5Dz28//
         QJiA==
X-Gm-Message-State: ACgBeo3TVLjIKi4qNMUfJNCUMtyIrjVcGH8GepYccxLEzmdjR7LUvY2H
        8RLuZeDc0+NRpVy/BZdiMzV8ppXfQ4MFYaCPYo0=
X-Google-Smtp-Source: AA6agR5BAc2SeJyJwrKJZ6kP+LP3uItRqmuai2L5uc7Nl4q90IVDmyZsi09dxhaPTNPBLu/iVrs0eV4yIaR6cZqFudI=
X-Received: by 2002:a05:6a00:1501:b0:52e:67e9:56d7 with SMTP id
 q1-20020a056a00150100b0052e67e956d7mr30372771pfu.48.1661351928211; Wed, 24
 Aug 2022 07:38:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:612:b0:43:c853:4cf0 with HTTP; Wed, 24 Aug 2022
 07:38:47 -0700 (PDT)
In-Reply-To: <YwY3qEa2gFsPg2jz@kernel.org>
References: <YwQRKkmWqsf/Du6A@kernel.org> <CADo9pHhW9w+ciNbQr+7u4mezuQ1USyh0k2Wshy=wkdEcxRiDLA@mail.gmail.com>
 <YwY2mFuJP10dehRx@kernel.org> <CADo9pHheRprMRAZkcxcALRv7gi8r+_CpNBP+LB4rt0n-_ZMQ4Q@mail.gmail.com>
 <YwY3qEa2gFsPg2jz@kernel.org>
From:   Luna Jernberg <droidbittin@gmail.com>
Date:   Wed, 24 Aug 2022 16:38:47 +0200
Message-ID: <CADo9pHhcw2+WEYfD=hJ-o67fw9Uf+ERS8xo2SHApNQgPwGCmBA@mail.gmail.com>
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

https://forum.endeavouros.com/t/failed-to-start-load-kernel-modules-on-boot-after-system-update-nvidia/30584/17?u=sradjoker

On 8/24/22, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> Em Wed, Aug 24, 2022 at 04:36:18PM +0200, Luna Jernberg escreveu:
>> The Nvidia driver breaks
>
> How? What are the messages?
>
> Here is a test on an Archlinux container:
>
> [perfbuilder@758097c04011 dwarves-1.24]$ pahole --version
> v1.24
> [perfbuilder@758097c04011 dwarves-1.24]$ cat /etc/os-release
> NAME="Arch Linux"
> PRETTY_NAME="Arch Linux"
> ID=arch
> BUILD_ID=rolling
> VERSION_ID=TEMPLATE_VERSION_ID
> ANSI_COLOR="38;2;23;147;209"
> HOME_URL="https://archlinux.org/"
> DOCUMENTATION_URL="https://wiki.archlinux.org/"
> SUPPORT_URL="https://bbs.archlinux.org/"
> BUG_REPORT_URL="https://bugs.archlinux.org/"
> LOGO=archlinux-logo
> [perfbuilder@758097c04011 dwarves-1.24]$ pahole list_head
> struct list_head {
> 	struct list_head *         next;                 /*     0     8 */
> 	struct list_head *         prev;                 /*     8     8 */
>
> 	/* size: 16, cachelines: 1, members: 2 */
> 	/* last cacheline: 16 bytes */
> };
> [perfbuilder@758097c04011 dwarves-1.24]$ pahole --sizes | sort -k2 -nr |
> head
> rcu_state	300608	7
> cmp_data	290904	1
> dec_data	274520	1
> cpu_entry_area	241664	0
> kvm	190016	6
> pglist_data	173440	6
> ZSTD_DCtx_s	161480	6
> saved_cmdlines_buffer	131104	1
> debug_store_buffers	131072	0
> hid_parser	110848	1
> [perfbuilder@758097c04011 dwarves-1.24]$
>
>> On 8/24/22, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
>> > Em Wed, Aug 24, 2022 at 03:23:29PM +0200, Luna Jernberg escreveu:
>> >> This package breaks on Arch Linux at the moment and if you are using
>> >> Arch
>> >> its recommended that you downgrade to 1.23
>> >
>> > Breaks in what sense? Can you please provide details?
>> >
>> > - Arnaldo
>> >
>> >> On Tue, Aug 23, 2022 at 1:59 AM Arnaldo Carvalho de Melo
>> >> <acme@kernel.org>
>> >> wrote:
>> >>
>> >> > Hi,
>> >> >
>> >> >         The v1.24 release of pahole and its friends is out, with
>> >> > faster
>> >> > BTF generation by parallelizing the encoding part in addition to the
>> >> > previoulsy parallelized DWARF loading, support for 64-bit BTF
>> >> > enumeration
>> >> > entries, signed BTF encoding of 'char', exclude/select DWARF loading
>> >> > based on the language that generated the objects, etc.
>> >> >
>> >> > Main git repo:
>> >> >
>> >> >    git://git.kernel.org/pub/scm/devel/pahole/pahole.git
>> >> >
>> >> > Mirror git repo:
>> >> >
>> >> >    https://github.com/acmel/dwarves.git
>> >> >
>> >> > tarball + gpg signature:
>> >> >
>> >> >    https://fedorapeople.org/~acme/dwarves/dwarves-1.24.tar.xz
>> >> >    https://fedorapeople.org/~acme/dwarves/dwarves-1.24.tar.bz2
>> >> >    https://fedorapeople.org/~acme/dwarves/dwarves-1.24.tar.sign
>> >> >
>> >> >         Thanks a lot to all the contributors and distro packagers,
>> >> > you're
>> >> > on the
>> >> > CC list, I appreciate a lot the work you put into these tools,
>> >> >
>> >> > Best Regards,
>> >> >
>> >> > BTF encoder:
>> >> >
>> >> > - Add support to BTF_KIND_ENUM64 to represent enumeration entries
>> >> > with
>> >> >   more than 32 bits.
>> >> >
>> >> > - Support multithreaded encoding, in addition to DWARF multithreaded
>> >> >   loading, speeding up the process.
>> >> >
>> >> >   Selected just like DWARF multithreaded loading, using the 'pahole
>> >> > -j'
>> >> >   option.
>> >> >
>> >> > - Encode 'char' type as signed.
>> >> >
>> >> > BTF Loader:
>> >> >
>> >> > - Add support to BTF_KIND_ENUM64.
>> >> >
>> >> > pahole:
>> >> >
>> >> > - Introduce --lang and --lang_exclude to specify the language the
>> >> >   DWARF compile units were originated from to use or filter.
>> >> >
>> >> >   Use case is to exclude Rust compile units while aspects of the
>> >> >   DWARF generated for it get sorted out in a way that the kernel
>> >> >   BPF verifier don't refuse loading the BTF generated from them.
>> >> >
>> >> > - Introduce --compile to generate compilable code in a similar
>> >> > fashion
>> >> > to:
>> >> >
>> >> >    bpftool btf dump file vmlinux format c > vmlinux.h
>> >> >
>> >> >   As with 'bpftool', this will notice type shadowing, i.e. multiple
>> >> > types
>> >> >   with the same name and will disambiguate by adding a suffix.
>> >> >
>> >> > - Don't segfault when processing bogus files.
>> >> >
>> >
>> > --
>> >
>> > - Arnaldo
>> >
>
> --
>
> - Arnaldo
>
