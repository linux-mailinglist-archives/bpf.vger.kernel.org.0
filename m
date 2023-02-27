Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F586A45D3
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 16:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjB0PSt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 10:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjB0PSq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 10:18:46 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A978900B;
        Mon, 27 Feb 2023 07:18:45 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id A33F592009C; Mon, 27 Feb 2023 16:18:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 9BF7B92009B;
        Mon, 27 Feb 2023 15:18:43 +0000 (GMT)
Date:   Mon, 27 Feb 2023 15:18:43 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Johan Almbladh <johan.almbladh@anyfinetworks.com>
cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 2/2] MIPS: ebpf jit: Implement R4000 workarounds
In-Reply-To: <CAM1=_QS_ewcFdrZ1ypV15wOkK_SKkb0UUe5_Ozi_CDBdxF5JmA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2302271515100.63909@angie.orcam.me.uk>
References: <20230222161222.11879-1-jiaxun.yang@flygoat.com> <20230222161222.11879-3-jiaxun.yang@flygoat.com> <CAM1=_QTDkYJANgxYwkgPZB+hUX6Rr_Pvnn7cFwSJFHQtLrpQMA@mail.gmail.com> <70C80F6D-A727-48FD-A767-A2CA54AA7C1E@flygoat.com>
 <CAM1=_QS_ewcFdrZ1ypV15wOkK_SKkb0UUe5_Ozi_CDBdxF5JmA@mail.gmail.com>
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

> > > R4000 is a 64-bit CPU, so the 32-bit JIT implementation will not be
> > > used. From the Makefile:
> > >
> > > ifeq ($(CONFIG_32BIT),y)
> > >        obj-$(CONFIG_BPF_JIT) += bpf_jit_comp32.o
> > > else
> > >        obj-$(CONFIG_BPF_JIT) += bpf_jit_comp64.o
> > > endif
> >
> > It’s common practice to run 32-bit kernel on R4000 based systems to save some memory :-)
> 
> Ok, I understand.

 Likewise:

	select CPU_R4000_WORKAROUNDS if 64BIT
	select CPU_R4400_WORKAROUNDS if 64BIT

This only applies to 64-bit operations, which are not used in 32-bit code 
(one reason why these early silicon revisions were originally used with 
32-bit software only).

  Maciej
