Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336E9294202
	for <lists+bpf@lfdr.de>; Tue, 20 Oct 2020 20:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437309AbgJTSPE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Oct 2020 14:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437306AbgJTSPD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Oct 2020 14:15:03 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71C752098B;
        Tue, 20 Oct 2020 18:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603217702;
        bh=ATM9YDiM0sfiA1zQ3/mGre1Rk3rzW7SWzPouzYHlM78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=to+3jR8iGDo3+ysj5KO1PtNhTAmQNcVvJSKliTIfhbaiyKHGnx84gHB6AXD7FuXLF
         jhAkIXo3VyPBX1+4F/LO+nKQh5NVgv0CGeO2yOLGCp1mYaHQYWzygLUz6WgZjxRgjD
         IrR/LMzdbJtaSXJE0J29dOiiasGfLufpA8gnRd24=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 095AC403C2; Tue, 20 Oct 2020 15:14:59 -0300 (-03)
Date:   Tue, 20 Oct 2020 15:14:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Hao Luo <haoluo@google.com>, Jiri Slaby <jirislaby@kernel.org>,
        =?iso-8859-1?Q?=C9rico?= Rolim <erico.erc@gmail.com>,
        dwarves@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: Segfault in pahole 1.18 when building kernel 5.9.1 for arm64
Message-ID: <20201020181458.GA2342001@kernel.org>
References: <CAFDeuWM7D-Upi84-JovKa3g8Y_4fjv65jND3--e9u-tER3WmVA@mail.gmail.com>
 <82b757bb-1f49-ab02-2f4b-89577d56fec9@kernel.org>
 <20201020122015.GH2294271@kernel.org>
 <CA+khW7gcDPAw4h=0U9mMxTJoaCyOXCMwyw34dcBp1xBKJG6xkg@mail.gmail.com>
 <CAEf4BzYDvvthK_S7EecsTO3HAVXiAf6AqHaiEWbf9+K7sjMiLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYDvvthK_S7EecsTO3HAVXiAf6AqHaiEWbf9+K7sjMiLA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Oct 20, 2020 at 10:10:19AM -0700, Andrii Nakryiko escreveu:
> On Tue, Oct 20, 2020 at 10:05 AM Hao Luo <haoluo@google.com> wrote:
> > Thanks for reporting this and cc'ing me. I forgot to update the error
> > messages when renaming the flags. I will send a patch to fix the error
> > message.

> > The commit

> > commit f3d9054ba8ff1df0fc44e507e3a01c0964cabd42
> > Author:     Hao Luo <haoluo@google.com>
> > AuthorDate: Wed Jul 8 13:44:10 2020 -0700

> >      btf_encoder: Teach pahole to store percpu variables in vmlinux BTF.

> > encodes kernel global variables into BTF so that bpf programs can
> > directly access them. If there is no need to access kernel global
> > variables, it's perfectly fine to use '--btf_encode_force' to skip
> > encoding bad symbols into BTF, or '--skip_encoding_btf_vars' to skip
> > encoding all global vars all together. I will add these info into the
> > updated error message.

> > Also cc bpf folks for attention of this bug.

> I've already fixed the message as part of
> 2e719cca6672 ("btf_encoder: revamp how per-CPU variables are encoded")

> It's currently still in the tmp.libbtf_encoder branch in pahole repo.

I'm now running:

  $ grep BTF=y ../build/s390x-v5.9.0+/.config
  CONFIG_DEBUG_INFO_BTF=y
  $ make -j24 CROSS_COMPILE=s390x-linux-gnu- ARCH=s390 O=../build/s390x-v5.9.0+/

To do the last test I wanted before moving it to master.

- Arnaldo
