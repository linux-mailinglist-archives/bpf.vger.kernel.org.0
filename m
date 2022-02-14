Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9C34B5BF9
	for <lists+bpf@lfdr.de>; Mon, 14 Feb 2022 22:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiBNVCQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 16:02:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiBNVCP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 16:02:15 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A4FB65E9
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 13:02:06 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id d3so13319204ilr.10
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 13:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zKcVbYLr+GJVx6S1OPG7dRvmmCK9RoNeQY1hUT+RKlM=;
        b=YI/kFMdUUawb2GkTR9uLAjG2Z1jZZTr7aFIiXtwIW52SqEGTGvBrZOSVBAB6WS8+39
         BU28Q4ayJYP8Mc1FKvoizvkOXALWB2QEEb1l0fkvmtn2bw5KGwSOD3oBZGfI2XhOqxCM
         Z2fn1g52nYNgrXMzUd2CUEgIgN0IeUugPiTD+ECrj6F4eIgSBxSvusTAESG2nvOEyvNY
         Ls62EkgYfmEL0KjwF4iVuIoFl6EgckcVgS45wbrEMHtlk5kH023xpc6+IYqVWznRyunt
         WZjgM611k3KYowbGGi2WPM0/OyGW1Lkj3LmCJowYOs8F6bYfqv3m6T5j9x9sA56ROM2n
         wnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zKcVbYLr+GJVx6S1OPG7dRvmmCK9RoNeQY1hUT+RKlM=;
        b=FAMJJFvCu+WpASjnKijdNtA4cDkndBPCRfgnILfHhXjyS4Fp0lkw3IPNWHLRjSETBK
         qv7JyqjZDWeBBi4DGvSl39G4ZzH7vENaVavG6Ph3Wd9QSjvvr2cVc20jf7pE6T6Hd5A8
         ngX+q0puwJS307lOib/4Cs4PhQXHr3k0cyAmf+eJ0aJ3gNUOGRjkT/bLuexScn0B/igx
         ERceDFzWHwttZFdVefWb7gCCCO5TMk70cV8stOyTGihisc3yWAzAzmUQ5jpMf0Zj9ecf
         JWor17v22y9PvX2RkvPDamZf7WvLVsE6ES/midds5Nd4gna8QaosJCE1Nx26IMMRmaKK
         sipw==
X-Gm-Message-State: AOAM531Zz6G7YNxP44cbTuEmwQaStxzYJJq91C5S47rjrFWzRtr3ToXh
        euQ8CduMkT0LCKa3mUET8h9qqmqWNlJUtO2HDCSK/SPN
X-Google-Smtp-Source: ABdhPJzJQB4+vUSR0Ez6YzhapxGC23/LIzhIc+qJS4syu18vU9OKMylusKt+7HTmDTRvTQNMa+khy7qcsVj9n7D6+uU=
X-Received: by 2002:a5e:8406:: with SMTP id h6mr286841ioj.144.1644868567638;
 Mon, 14 Feb 2022 11:56:07 -0800 (PST)
MIME-Version: 1.0
References: <20220211211450.2224877-1-andrii@kernel.org> <20220211211450.2224877-4-andrii@kernel.org>
 <20220211231316.iqhn3jqnxangv5jc@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzbrdJMX0P=P84D40oYH3BNrL-16xqFNFH48BtYc9DaJHw@mail.gmail.com>
 <20220212001832.2dajubav5tqwaimn@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzY_tQQ3sTmTwx_uFAg3Z50ckWf1MWgCy-ZR==gV65e3Mw@mail.gmail.com> <20220214172747.o6xr3pfvvt7545wk@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220214172747.o6xr3pfvvt7545wk@ast-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 14 Feb 2022 11:55:56 -0800
Message-ID: <CAEf4BzZv2z-h_Gub=qqOCQqrj6NuhXiSaG4Xn8KariP96iR5zQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/3] selftests/bpf: add custom SEC() handling selftest
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>
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

On Mon, Feb 14, 2022 at 9:27 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Feb 11, 2022 at 05:16:25PM -0800, Andrii Nakryiko wrote:
> > >
> > > Calling the callback 'preload' when it cannot affect the load is odd too.
> >
> > It's what happening before loading, I never had intention to prevent
> > load... Would "prepare_load_fn" be a better name?
>
> prepare_load_fn would be more accurate name for sure.

SGTM, I'll rename

>
> If we're not planning to change place where init_fn is called too
> then can we rename it to something that would accurately describe it?
> It seems it's called after ELF is fully parsed except relos and progs
> are ready to be tweaked.
> Should 'prog' be in the name? Like prog_setup_fn ? or prog_init_fn ?
> Then ability to set prog autoload would flow naturally from such name.
> What else can be done there? Or what is a recommended use of this cb?

I like prog_setup_fn name, it matches semantics very closely. It is
supposed to be able to do everything that user can do though all the
bpf_program getters/setters before bpf_object__load() step. If some of
those setters doesn't work from prog_setup_fn(), we'll fix that, but
otherwise I think it will always be a "post-bpf_object__open()"
callback to adjust whatever libbpf does by default.

>
> > might what to be able to do with this. Alan's uprobe attach by
> > function name would be implementable through these APIs outside of
> > libbpf as well (except then we won't be able to add func_name into
> > bpf_uprobe_opts, which would be a pity).
>
> Alan,
> can you demo your "okprobe" feature based on this api?
> Any rough patches would do.
> The "o" handling will be done in which callback?
