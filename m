Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600C46A45C2
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 16:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjB0PRb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 10:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjB0PRa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 10:17:30 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F92B227A8;
        Mon, 27 Feb 2023 07:17:29 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 3E8BB92009C; Mon, 27 Feb 2023 16:17:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 3BB0192009B;
        Mon, 27 Feb 2023 15:17:27 +0000 (GMT)
Date:   Mon, 27 Feb 2023 15:17:27 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Johan Almbladh <johan.almbladh@anyfinetworks.com>
cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 1/2] MIPS: ebpf jit: Implement DADDI workarounds
In-Reply-To: <CAM1=_QRVEG0Fw9U99V3ohMe60h0DwMzyWvV_gYdJ=SrQ1D11Fg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2302271513240.63909@angie.orcam.me.uk>
References: <20230222161222.11879-1-jiaxun.yang@flygoat.com> <20230222161222.11879-2-jiaxun.yang@flygoat.com> <CAM1=_QQRmTaAnn0w6wteQ_FKgoF=vGX_okfbiUHdyUB0ZzNghQ@mail.gmail.com> <7CAF04EF-FC1D-4BE1-A639-92D677525C63@flygoat.com>
 <CAM1=_QRVEG0Fw9U99V3ohMe60h0DwMzyWvV_gYdJ=SrQ1D11Fg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 27 Feb 2023, Johan Almbladh wrote:

> > > DADDI/DADDIU are only available on 64-bit CPUs, so the errata would
> > > only be applicable to that. No need for the CONFIG_64BIT conditional.
> >
> > It’s possible to compile a 32bit kernel for R4000 with CONFIG_CPU_DADDI_WORKAROUNDS
> > enabled.
> 
> Yes, but DADDI/DADDIU are 64-bit instructions so they would not be
> available when compiling the kernel in 32-bit mode for R4000, and
> hence the workaround would not be applicable, right? If this is
> correct, I would imagine CONFIG_CPU_DADDI_WORKAROUNDS itself to be
> conditional on CONFIG_64BIT. That way the this relationship is
> expressed once in the Kconfig file, instead of being spread out over
> multiple places in the code.

 It is:

	select CPU_DADDI_WORKAROUNDS if 64BIT

It only applies to 64-bit operations which are not used in 32-bit code.

  Maciej
