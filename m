Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70924589FE2
	for <lists+bpf@lfdr.de>; Thu,  4 Aug 2022 19:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbiHDRaJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Aug 2022 13:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbiHDRaH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Aug 2022 13:30:07 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFB9186F9
        for <bpf@vger.kernel.org>; Thu,  4 Aug 2022 10:30:06 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k26so542145ejx.5
        for <bpf@vger.kernel.org>; Thu, 04 Aug 2022 10:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XyL5SVUmTOUbTKdARYMTlRfQUF3PC0E2gSVrWnr+WdE=;
        b=kcLJbQdaklWdwjMZUhftTOAGQye7SInvfaQLRMnEhrBmmnFow5LaI+GaO+uKIVeuiT
         g7QLqr3nlI97kRdujiX6DudIEeF330Px+vEm1URdh2MO0wQt7LNx6mAB8+L8Pc/MbSmw
         g3wpdgM9SJcNaoayFqVWfA6jPyFzWAjGN9AD7UtUKvWwpw4lpG5m9PLL+BO1jYjPA/90
         FkFFwwV7djSNSEIgYCeDD8WqdFnU2iNOBN5tpW8fURaQZDcl10JoWyFp9uyEvnB2Z7lD
         dQmYfZ6IqCoCePkpnIsO47SSnSobImXE842An9qkMWIwNGVubzoDLX4lJUhZLhQDkI9b
         LILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XyL5SVUmTOUbTKdARYMTlRfQUF3PC0E2gSVrWnr+WdE=;
        b=Pd60FawP4ydUBONJ+BGPG/uUmiEev8B0dyWGkE27gVb+8i/Tu+wFaSlshfFrpHjjBv
         SBax9+cBspthu4pXcnUIrrprUUnSzJv9Zm/RtewUbMMuo7CYP6ngbWOXzZqnrjHR/B84
         JGu3Ezjg+UxzhnA9YbRVWm+0ODP7J0N2EbfbL7+tGgkyrHGnW8Zwt60Rs8que7akU4IU
         dDCUpvK1+CCKKrAGUzuW707kdw5V4XZ7a2sktj2wmk7CJtZ9Faqf51ybvD3F/bdXobhT
         LsuNmrIUh+RNxG/utyE48gCW9Pilb9nW0/+wuU7Leb+/746PuIohAlDZVAFLrwdafSwk
         C8AQ==
X-Gm-Message-State: ACgBeo1136VDjI+oCH4FRwqBIFOIWu4lrTuZNPc08aGY34P8ti5SBjsg
        F0jvr6F74xMFvY+mh0N2UF6wx9lqwTQdq/MkdL4=
X-Google-Smtp-Source: AA6agR5I3atavoG0YC1Ar6Ia2qJOen2XLuBIiTGL3FWnDx5oQ6eYKNp7vUiLcGi4xWBuP5rMi1d2+hmO1zP7tY5gLw4=
X-Received: by 2002:a17:906:9b86:b0:6fe:d37f:b29d with SMTP id
 dd6-20020a1709069b8600b006fed37fb29dmr2207333ejc.327.1659634204457; Thu, 04
 Aug 2022 10:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <CADvTj4rytB_RDemr4CXO08waaEJGXRC6kt2y_SO0SKN3FgWg0g@mail.gmail.com>
 <CAEf4BzZVq2VZg=S2xZinfth2-f50zxhMm-fPVQGUoeYPC5J4XA@mail.gmail.com>
 <87wncnd5dd.fsf@oracle.com> <8735fbcv3x.fsf@oracle.com> <CADvTj4rBCEC_AFgszcMrgKMXfrBKzktABYy=dTH1F1Z7MxmcTw@mail.gmail.com>
 <87v8s65hdc.fsf@oracle.com> <CADvTj4qniQWNFw4aYpsxV5chdj5v+cLfajRXYOHiK_GOn9OLWQ@mail.gmail.com>
 <8735fa3unq.fsf@oracle.com> <CADvTj4r+1QB2Cg7L9R-fzqs_HA3kdiiQ_4WHvj+h_DvuxoM5kw@mail.gmail.com>
 <CADvTj4pFQmS6XHpHCVO8jt-8ZRdTd--uny-n9vA0+vm4xUoLzQ@mail.gmail.com>
 <87tu7p3o4k.fsf@oracle.com> <CADvTj4r_WnaC-nb-wQwqrzfJsERaX-TnR0tRXZF8fE5UPBThHQ@mail.gmail.com>
 <87h73p1f5s.fsf@oracle.com> <CADvTj4qiz0xHnN+s32tiYm_WA8ai4cHUVPkKm7w6xTkZXUBCag@mail.gmail.com>
 <87k08lunga.fsf@oracle.com> <87fsj8vjcy.fsf@oracle.com> <87bktwvhu5.fsf@oracle.com>
 <CADvTj4o-36iuru665BW0XnEauXBeszW438QTtpt4_VUEjf5nXg@mail.gmail.com>
 <CAEf4BzbN99WbEDS9r7nyO-7+SOYTU=-kXhD+A1L3dzrwrcHdBQ@mail.gmail.com>
 <CADvTj4qi_ZZhdXRPd0X_tgQ8-jgrRgxF+4+kYVA92ZMO8KqESA@mail.gmail.com>
 <CAEf4BzamhADJv+K1e6bLKV7Pob0VC95rgUtEJbVhXWqLgHLTyg@mail.gmail.com>
 <CADvTj4oSc646ebcWzXB65gSy144D+GikbT5eF38OHu+T5tbn-w@mail.gmail.com>
 <CAEf4BzYGXj4otX0pFSTcxKrQAuv7L_rqLyb5Hsp_ueZOZdJorA@mail.gmail.com>
 <CADvTj4pJwnCFB8LipENEPGAB2-+jBcvmOSJSezyTRr4xiozPNg@mail.gmail.com> <CAEf4Bza0-dx=X01ZqzLR_SF6-6r9YZFQa=VLyD6H=0DnLCU1AQ@mail.gmail.com>
In-Reply-To: <CAEf4Bza0-dx=X01ZqzLR_SF6-6r9YZFQa=VLyD6H=0DnLCU1AQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 4 Aug 2022 10:29:52 -0700
Message-ID: <CAADnVQK1A-Y0jzXO2KdxjpHF4DUxcgh-Jy5MubLa4wsyHc0scQ@mail.gmail.com>
Subject: Re: bpftool gen object doesn't handle GCC built BPF ELF files
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        bpf <bpf@vger.kernel.org>, david.faust@oracle.com,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 3, 2022 at 9:59 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> Please also start with learning how to build selftests/bpf with Clang
> and looking at various examples so that you can at least look at all
> the different features we rely on in the BPF world, instead of trying
> to tune one small piece (systemd's BPF programs) to your liking. If
> you are serious about making GCC BPF backend viable, you'll have to
> understand BPF a bit better.
>
> That would be a better use of everyone's time, instead of you going
> behind our backs and requesting Clang to break the entire BPF
> ecosystem just because GCC is doing something differently, like you
> and Jose E. Marchesi did with [0] and [1].
>
>   [0] https://github.com/llvm/llvm-project/issues/56468
>   [1] https://reviews.llvm.org/D131012

+1
