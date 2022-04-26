Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8066650F845
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 11:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346142AbiDZJGt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Apr 2022 05:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347826AbiDZJGO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Apr 2022 05:06:14 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B181632C0;
        Tue, 26 Apr 2022 01:46:05 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 055C41EC0426;
        Tue, 26 Apr 2022 10:46:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650962760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ytJ8gqI6iL6hkQ4cMkAqnHDUUazMUuvlLkFKabJ8Vj8=;
        b=WTOQOMUpowORo4Pf9B+Tvvwl+QopiWxJjwOoMc71wqQkg60NwYuRA9QHk03Y1Y8fhAnYE1
        mNVaBgrJPPvn0dZOlq9FHBi/pb91TDPht54XBIvWhpEsrB+3GsDE37suRWXOFGNZG8RZmY
        pBPDmRPRF2/4XnXIn7U022uQcbDxYjs=
Date:   Tue, 26 Apr 2022 10:46:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>, bpf@vger.kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] x86/speculation: Add missing prototype for
 unpriv_ebpf_notify()
Message-ID: <YmexSIL5pqNK63iH@zn.tnic>
References: <5689d065f739602ececaee1e05e68b8644009608.1650930000.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5689d065f739602ececaee1e05e68b8644009608.1650930000.git.jpoimboe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

+ bpf@vger.kernel.org

Let's sync with bpf folks on who takes this. I could route it through tip ...

On Mon, Apr 25, 2022 at 04:40:02PM -0700, Josh Poimboeuf wrote:
> Fix the following warnings seen with "make W=1":
> 
>   kernel/sysctl.c:183:13: warning: no previous prototype for ‘unpriv_ebpf_notify’ [-Wmissing-prototypes]
>     183 | void __weak unpriv_ebpf_notify(int new_state)
>         |             ^~~~~~~~~~~~~~~~~~
> 
>   arch/x86/kernel/cpu/bugs.c:659:6: warning: no previous prototype for ‘unpriv_ebpf_notify’ [-Wmissing-prototypes]
>     659 | void unpriv_ebpf_notify(int new_state)
>         |      ^~~~~~~~~~~~~~~~~~
> 
> Fixes: 44a3918c8245 ("x86/speculation: Include unprivileged eBPF status in Spectre v2 mitigation reporting")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  include/linux/bpf.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index bdb5298735ce..ecc3d3ec41cf 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2085,6 +2085,8 @@ void bpf_offload_dev_netdev_unregister(struct bpf_offload_dev *offdev,
>  				       struct net_device *netdev);
>  bool bpf_offload_dev_match(struct bpf_prog *prog, struct net_device *netdev);
>  
> +void unpriv_ebpf_notify(int new_state);
> +
>  #if defined(CONFIG_NET) && defined(CONFIG_BPF_SYSCALL)
>  int bpf_prog_offload_init(struct bpf_prog *prog, union bpf_attr *attr);
>  
> -- 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
