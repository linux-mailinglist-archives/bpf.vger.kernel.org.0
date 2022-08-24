Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE9359FD55
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 16:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbiHXOdG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 10:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbiHXOdF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 10:33:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2628E3C8FD;
        Wed, 24 Aug 2022 07:33:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC524B82543;
        Wed, 24 Aug 2022 14:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65891C433D6;
        Wed, 24 Aug 2022 14:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661351579;
        bh=cn4rzl2bL2LroQO1moqWO0d1Nx/QYQ08ecAD4L1+OKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=io0hOEygoeBsYl/hzJ+13wtlQ/uk6Vvd14AkR/HlZxUe+UrsLJTgIFilHkkMDsjw+
         9lAsr0A2fOJQpPbDPQ7YOw8oft1GRF5E4PYRWDYq6A0iLfL/0LoPfbj2JlwyxQ+ZZH
         yO2nW5ogE2l/X1WLO9lkQ3wYYoo+z9pPsRy8HmlvsX6ucBckA66tBGxWCbcZR1D/Jq
         5L2IXpW//mhqX7e1gQkIGUVuzeWiXg//AT7juC2hhZVP6C4n3nJ3JBnQzr6OotrCZQ
         IGYr2dFXHmqfR9RYyleKrcqydULViBRj1jMj6OhhAfvqa3qt5NfXpuzAR6o9NK5xbU
         YJxhRxdbjUZUg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BC1CD404A1; Wed, 24 Aug 2022 11:32:56 -0300 (-03)
Date:   Wed, 24 Aug 2022 11:32:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Luna Jernberg <droidbittin@gmail.com>
Cc:     dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alibek Omarov <a1ba.omarov@gmail.com>,
        Kornilios Kourtis <kornilios@isovalent.com>,
        Kui-Feng Lee <kuifeng@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: ANNOUNCE: pahole v1.24 (Faster BTF encoding, 64-bit BTF enum
 entries)
Message-ID: <YwY2mFuJP10dehRx@kernel.org>
References: <YwQRKkmWqsf/Du6A@kernel.org>
 <CADo9pHhW9w+ciNbQr+7u4mezuQ1USyh0k2Wshy=wkdEcxRiDLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADo9pHhW9w+ciNbQr+7u4mezuQ1USyh0k2Wshy=wkdEcxRiDLA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Aug 24, 2022 at 03:23:29PM +0200, Luna Jernberg escreveu:
> This package breaks on Arch Linux at the moment and if you are using Arch
> its recommended that you downgrade to 1.23

Breaks in what sense? Can you please provide details?

- Arnaldo
 
> On Tue, Aug 23, 2022 at 1:59 AM Arnaldo Carvalho de Melo <acme@kernel.org>
> wrote:
> 
> > Hi,
> >
> >         The v1.24 release of pahole and its friends is out, with faster
> > BTF generation by parallelizing the encoding part in addition to the
> > previoulsy parallelized DWARF loading, support for 64-bit BTF enumeration
> > entries, signed BTF encoding of 'char', exclude/select DWARF loading
> > based on the language that generated the objects, etc.
> >
> > Main git repo:
> >
> >    git://git.kernel.org/pub/scm/devel/pahole/pahole.git
> >
> > Mirror git repo:
> >
> >    https://github.com/acmel/dwarves.git
> >
> > tarball + gpg signature:
> >
> >    https://fedorapeople.org/~acme/dwarves/dwarves-1.24.tar.xz
> >    https://fedorapeople.org/~acme/dwarves/dwarves-1.24.tar.bz2
> >    https://fedorapeople.org/~acme/dwarves/dwarves-1.24.tar.sign
> >
> >         Thanks a lot to all the contributors and distro packagers, you're
> > on the
> > CC list, I appreciate a lot the work you put into these tools,
> >
> > Best Regards,
> >
> > BTF encoder:
> >
> > - Add support to BTF_KIND_ENUM64 to represent enumeration entries with
> >   more than 32 bits.
> >
> > - Support multithreaded encoding, in addition to DWARF multithreaded
> >   loading, speeding up the process.
> >
> >   Selected just like DWARF multithreaded loading, using the 'pahole -j'
> >   option.
> >
> > - Encode 'char' type as signed.
> >
> > BTF Loader:
> >
> > - Add support to BTF_KIND_ENUM64.
> >
> > pahole:
> >
> > - Introduce --lang and --lang_exclude to specify the language the
> >   DWARF compile units were originated from to use or filter.
> >
> >   Use case is to exclude Rust compile units while aspects of the
> >   DWARF generated for it get sorted out in a way that the kernel
> >   BPF verifier don't refuse loading the BTF generated from them.
> >
> > - Introduce --compile to generate compilable code in a similar fashion to:
> >
> >    bpftool btf dump file vmlinux format c > vmlinux.h
> >
> >   As with 'bpftool', this will notice type shadowing, i.e. multiple types
> >   with the same name and will disambiguate by adding a suffix.
> >
> > - Don't segfault when processing bogus files.
> >

-- 

- Arnaldo
