Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790AC2F6B93
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 20:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbhANTzJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 14:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbhANTzH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 14:55:07 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84093C0613C1
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 11:54:27 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id m4so7025388wrx.9
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 11:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Jco6OKkBzH2W5YMgKN8CdIkvv1c2tCGRqtwwKgOzoTU=;
        b=j/heu2munUhWuITG04w2E1rUlnHuKEPX2QcskO7PII2HtxbjLoBk0vUIcYEDq+Wzro
         YLJmhogwgK7dlTRE23UGZqyCSoOgK1BzwC0fWeASrYRSGQazGVMHHmXW9K9wa+vH4eTp
         7hJXY4pc3DRmorYpfjoKJWoFz8Uvtjw+DBeVr5OjnyRmzsb+lM9WLIg/+YMqhXwLk5qd
         RNXYmJFSZxYTOJYA90oJcZWqt6vrrA3MHDsaWY5r8+hnBBr2/7nsrV2TFzYqtCwHCchP
         4WXaxG6eUxVUnT80m6hPSIQ9Qd9QUYa1vNxPvRIelB9mmyGw38k8IiFKHNclOgN9xw/C
         ayag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Jco6OKkBzH2W5YMgKN8CdIkvv1c2tCGRqtwwKgOzoTU=;
        b=FvXCGL4xPVNFREk9ckJq6wZ9EkIy7b7nCl2qmFo3VAtAbxUO1+/b/oYJ6TMHj+OLXT
         wykHaKGNMfpk21cxhYTRljRJyXogeadZNrJ3O7XCiW5Y8iyiaYsfl1Eom+D9EnGQMJns
         GdoZIQzIqBjBPH6csD5FMInmwEr7ufYCJdBfypTemaqm1gWErwH6iQpqPBQ4cv0r/RyU
         IBvoB26WbJYjIOpWJT39LKC2+lKeel1fRmY5nl7WyeW/LrDzWsgHvGsUPQGjTDb9LEkC
         dF6iwLXF0rWBUl9VRj2w620o+amRnfJpHeiIjhjR4tL1CJPPNgKo/aFl4J26csp4VlWY
         SMeA==
X-Gm-Message-State: AOAM532g4rhBpMtmMYjwyMaLNK6VeW4Be8HL0uR0pzIDfpc4XEUsDQia
        jXdkQXlCTJpRYG8JHwP2XZszUQ==
X-Google-Smtp-Source: ABdhPJwTAnSC8i9erqyaC2T3bmWeIfWfGjCjtI2qx+TyOz9rMatI0AIgHFfUQq4dPzhL98mW7iEdYA==
X-Received: by 2002:adf:9d42:: with SMTP id o2mr9465225wre.135.1610654066061;
        Thu, 14 Jan 2021 11:54:26 -0800 (PST)
Received: from dell ([91.110.221.178])
        by smtp.gmail.com with ESMTPSA id b3sm5050877wme.32.2021.01.14.11.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 11:54:25 -0800 (PST)
Date:   Thu, 14 Jan 2021 19:54:22 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Dany Madden <drt@linux.ibm.com>,
        Daris A Nevil <dnevil@snmc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Erik Stahlman <erik@vt.edu>,
        Geoff Levand <geoff@infradead.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ishizaki Kou <kou.ishizaki@toshiba.co.jp>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Jens Osterkamp <Jens.Osterkamp@de.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Allen <jallen@linux.vnet.ibm.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Lijun Pan <ljp@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>, netdev@vger.kernel.org,
        Nicolas Pitre <nico@fluxnic.net>, Paul Durrant <paul@xen.org>,
        Paul Mackerras <paulus@samba.org>,
        Peter Cammaert <pc@denkart.be>,
        Russell King <rmk@arm.linux.org.uk>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Santiago Leon <santi_leon@yahoo.com>,
        Sukadev Bhattiprolu <sukadev@linux.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Utz Bacher <utz.bacher@de.ibm.com>,
        Wei Liu <wei.liu@kernel.org>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 0/7] Rid W=1 warnings in Ethernet
Message-ID: <20210114195422.GB3975472@dell>
References: <20210113164123.1334116-1-lee.jones@linaro.org>
 <20210113183551.6551a6a2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210114083349.GI3975472@dell>
 <20210114091453.30177d20@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210114091453.30177d20@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 14 Jan 2021, Jakub Kicinski wrote:

> On Thu, 14 Jan 2021 08:33:49 +0000 Lee Jones wrote:
> > On Wed, 13 Jan 2021, Jakub Kicinski wrote:
> > 
> > > On Wed, 13 Jan 2021 16:41:16 +0000 Lee Jones wrote:  
> > > > Resending the stragglers again.                                                                                  
> > > > 
> > > > This set is part of a larger effort attempting to clean-up W=1                                                   
> > > > kernel builds, which are currently overwhelmingly riddled with                                                   
> > > > niggly little warnings.                                                                                          
> > > >                                                                                                                  
> > > > v2:                                                                                                              
> > > >  - Squashed IBM patches                                                                                      
> > > >  - Fixed real issue in SMSC
> > > >  - Added Andrew's Reviewed-by tags on remainder  
> > > 
> > > Does not apply, please rebase on net-next/master.  
> > 
> > These are based on Tuesday's next/master.
> 
> What's next/master?

I'm not sure if this is a joke, or not? :)

next/master == Linux Next.  The daily merged repo where all of the
*-next branches end up to ensure interoperability.  It's also the
branch that is most heavily tested by the auto-builders to ensure the
vast majority of issues are ironed out before hitting Mainline.

> This is net-next:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/

Looks like net-next gets merged into next/master:

commit 452958f1f3d1c8980a8414f9c37c8c6de24c7d32
Merge: 1eabba209a17a f50e2f9f79164
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Thu Jan 14 10:35:40 2021 +1100

    Merge remote-tracking branch 'net-next/master'

So I'm not sure what it's conflicting with.

Do you have patches in net-next that didn't make it into next/master
for some reason?

I'll try to rebase again tomorrow.

Hopefully I am able to reproduce your issue by then.

> > I just rebased them now with no issue.
> > 
> > What conflict are you seeing?
> 
> Applying: net: ethernet: smsc: smc91x: Fix function name in kernel-doc header
> error: patch failed: drivers/net/ethernet/smsc/smc91x.c:2192
> error: drivers/net/ethernet/smsc/smc91x.c: patch does not apply
> Patch failed at 0001 net: ethernet: smsc: smc91x: Fix function name in kernel-doc header
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
