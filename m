Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF97450A965
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 21:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiDUToF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 15:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiDUToB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 15:44:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE984B87F;
        Thu, 21 Apr 2022 12:41:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66FA6B823F3;
        Thu, 21 Apr 2022 19:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A644C385A5;
        Thu, 21 Apr 2022 19:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650570068;
        bh=ntFE53p9Qvm/OfNU4+7MbHF6ffpndaoZRWXP15X8/44=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U6A8w2kIaR4rJ1fCtXKRialGvxNMKx7SOP2BThd7NjCisYDwRYtM/EmpLmDc5I1kE
         y83SO568wSzu51M5vYPxitcCX5rxQiT5ZkS+M8Ux0Dtb6gzy8ZMiOci0uD588JdopU
         VtcdMmpp9ML+B6fo268mIPOxuUBkiaLqr1u82TdS7ne/pP3grdIvSe+3lbefGZyV02
         AhhLePzwv0c+8gL6jFyC2/4XZHdpnN43ZlYjkXv0YFUo4kvpamX4/Ty0WYmHh0MyuW
         L/rXhPxovhlws+6aax+2fO7BG+r2iuY1NcLNHkiD9GpbdeP0RNR2EYBWnP+Y71js9F
         6CsOGmjxTVgDQ==
Received: by mail-yb1-f178.google.com with SMTP id b26so4950255ybj.13;
        Thu, 21 Apr 2022 12:41:08 -0700 (PDT)
X-Gm-Message-State: AOAM5334hw/e1llg32ZFu50OCuUXiYwc+QWDGJ08LReu21ySGXukIrpN
        uzYVvjkC4HLaxx9R1SF9kAPQ6n4i8xeamGADgdw=
X-Google-Smtp-Source: ABdhPJwiyImZimNqRZqXCUsmgQavJEPUZ7SAYyM2AhZ42Hk0FpySohvV8lD5LNrh+33hAbGhLLJsR3LnGiQAF6o0Ric=
X-Received: by 2002:a05:6902:114c:b0:641:87a7:da90 with SMTP id
 p12-20020a056902114c00b0064187a7da90mr1356895ybu.561.1650570067256; Thu, 21
 Apr 2022 12:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220421072212.608884-1-song@kernel.org> <CAHk-=wi3eu8mdKmXOCSPeTxABVbstbDg1q5Fkak+A9kVwF+fVw@mail.gmail.com>
 <CAADnVQKyDwXUMCfmdabbVE0vSGxdpqmWAwHRBqbPLW=LdCnHBQ@mail.gmail.com> <CAHk-=whFeBezdSrPy31iYv-UZNnNavymrhqrwCptE4uW8aeaHw@mail.gmail.com>
In-Reply-To: <CAHk-=whFeBezdSrPy31iYv-UZNnNavymrhqrwCptE4uW8aeaHw@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 21 Apr 2022 12:40:56 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7M6exGD3C1cPBGjhU0Y5efxtJ3=0BWNnbuH87TgQMzdg@mail.gmail.com>
Message-ID: <CAPhsuW7M6exGD3C1cPBGjhU0Y5efxtJ3=0BWNnbuH87TgQMzdg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: invalidate unused part of bpf_prog_pack
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Linus,

On Thu, Apr 21, 2022 at 11:59 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Apr 21, 2022 at 11:24 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > Let's not complicate the logic by dragging jit_fill_hole
> > further into generic allocation.
>
> I agree that just zeroing the page is probably perfectly fine in
> practice on x86, but I'm also not really seeing the "complication" of
> just doing things right.
>
> > The existing bpf_prog_pack code still does memset(0xcc)
> > a random range of bytes before and after jit-ed bpf code.
>
> That is actually wishful thinking, and not based on reality.
>
> From what I can tell, the end of the jit'ed bpf code is actually the
> exception table entries, so we have that data being marked executable.
>
> Honestly, what is wrong with this trivial patch?

This version would fill the memory with illegal instruction when we
allocate the bpf_prog_pack.

The extra logic I had in the original patch was to erase the memory
when a BPF program is freed. In this case, the memory will be
returned to the bpf_prog_pack, and stays as RO+X. Actually, I
am not quite sure whether we need this logic. If not, we only need
the much simpler version.

Thanks,
Song
