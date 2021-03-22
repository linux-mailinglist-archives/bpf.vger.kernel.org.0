Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538663437F9
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 05:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhCVErI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 00:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhCVEq7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 00:46:59 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B803C061756;
        Sun, 21 Mar 2021 21:46:59 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id DE2F992009C; Mon, 22 Mar 2021 05:46:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id D0FA392009B;
        Mon, 22 Mar 2021 05:46:56 +0100 (CET)
Date:   Mon, 22 Mar 2021 05:46:56 +0100 (CET)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] MIPS/bpf: Enable bpf_probe_read{, str}() on MIPS
 again
In-Reply-To: <1616034557-5844-1-git-send-email-yangtiezhu@loongson.cn>
Message-ID: <alpine.DEB.2.21.2103220540591.21463@angie.orcam.me.uk>
References: <1616034557-5844-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 18 Mar 2021, Tiezhu Yang wrote:

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 160b3a8..4b94ec7 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -6,6 +6,7 @@ config MIPS
>  	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
>  	select ARCH_HAS_FORTIFY_SOURCE
>  	select ARCH_HAS_KCOV
> +	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE

 Hmm, documentation on ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE seems rather 
scarce, but based on my guess shouldn't this be "if !EVA"?

  Maciej
