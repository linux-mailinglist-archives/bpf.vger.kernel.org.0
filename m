Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90D559A535
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 20:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349475AbiHSSFx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 14:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350063AbiHSSFO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 14:05:14 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF756FDF
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 10:51:58 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e19so4105837pju.1
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 10:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=otYHjdyLGePy1LBSwR9uatiwpWnd5ib8hRhTZupav48=;
        b=AYs8t7/R7/dAhhvd+GzU+Kon0SLCXYyudpMyF7JpCNtlF3PuHgV9B0uBrP76517EOr
         P23xLRfyMrXO9B4a2f214pKFKc7BAtXB7h4XTtu5h2uCbe42879Qq7eiKCb8H7Du1xVx
         MdR+gWtQixDl9VRZCZDjzvmwZiAzJxjRq8pUvTrpuHyav4pnCj4qNN8U66gHv/a575kI
         /a9QvUVTaeOXrrNVNXbnA+C+V5uk5GuuNBZ7FRLj1vptF1iP/WVW8l6zU68sDaf3sYzf
         QgSYxEqajhP0ra4fyCTKL+4415AVMGu+Uurq5BtK8BD9lt5W4gzdDeaVPKFHs7T6huC6
         jEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=otYHjdyLGePy1LBSwR9uatiwpWnd5ib8hRhTZupav48=;
        b=8QkMpIUHhX+u7/2v1xgCMZzDwDq9LSLYUauLkGbTHKAbnY9z0lXmpaMRtp9ssNdIz9
         IOiFgBuX8NXw2bgPDEsu3guFyQ62YvUQrIxnmkVMgMYHUbYN18gAj1sqjIBsLY3h1qjW
         jvPEYo0fdSVlcBLqYiBRDjcrOFXPaqztBhRB0lyLpwjFTG/MYYOXlz/fKZvh1ciqx28N
         ZHkn8XE2cA09OmPXCGW21dbstzpjZ9O/cK3S7AKw2Z5tp3KycUGjRpw8rs0NZfRU+BEU
         pKQ4MILiOc1mslHd0KXkLmwwvNWH3A39m+EHYi83i+PD760muGRJYZyQKrDHsvZ/Pb6G
         J1Jg==
X-Gm-Message-State: ACgBeo3QthW6nxMPivZ+5M0QEAjmEQiQmcGoqhZGzTAg/IxFnhl+CF0M
        X4PuF4ToW/Yp385KnMzM6f8=
X-Google-Smtp-Source: AA6agR7iKXkA2VMG3EddXBSHxfaNNU1TvL5TgtuZ7Q1VKvv8zel1NaeVlcwF+z7QnDIvGvhuoeh+vQ==
X-Received: by 2002:a17:90b:1194:b0:1fa:c41a:59c0 with SMTP id gk20-20020a17090b119400b001fac41a59c0mr11360126pjb.165.1660931518296;
        Fri, 19 Aug 2022 10:51:58 -0700 (PDT)
Received: from MacBook-Pro-3.local ([2620:10d:c090:500::1:c4b1])
        by smtp.gmail.com with ESMTPSA id x24-20020aa79418000000b0052d50e14f1dsm3715137pfo.78.2022.08.19.10.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 10:51:57 -0700 (PDT)
Date:   Fri, 19 Aug 2022 10:51:55 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        tj@kernel.org, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 01/12] bpf: Introduce any context BPF
 specific memory allocator.
Message-ID: <20220819175155.deyd62m6tscv63td@MacBook-Pro-3.local>
References: <20220817210419.95560-1-alexei.starovoitov@gmail.com>
 <20220817210419.95560-2-alexei.starovoitov@gmail.com>
 <CAP01T77L6e=B6OtLcM4bToM5n4+j3S6+p+ieTPtDGUgQUZ3o1Q@mail.gmail.com>
 <20220818003957.t5lcp636n7we37hk@MacBook-Pro-3.local>
 <CAP01T74gcYpXXoafBAEaL5a_7FaDdfAwzmoE86pOctzmeeVhmw@mail.gmail.com>
 <20220818223051.ti3gt7po72c5bqjh@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <CAP01T76rn=FrSC9VA=mbEK7QKMu-88uZiiekpn6TqQ_Ea0-u5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T76rn=FrSC9VA=mbEK7QKMu-88uZiiekpn6TqQ_Ea0-u5Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 19, 2022 at 04:31:11PM +0200, Kumar Kartikeya Dwivedi wrote:
> On Fri, 19 Aug 2022 at 00:30, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > Right. We cannot fail in unit_free().
> > With per-cpu counter both unit_alloc() and free_bulk_nmi() would
> > potentially fail in such unlikely scenario.
> > Not a big deal for free_bulk_nmi(). It would pick the element later.
> > For unit_alloc() return NULL is normal.
> > Especially since it's so unlikely for nmi to hit right in the middle
> > of llist_del_first().
> >
> > Since we'll add this per-cpu counter to solve interrupted llist_del_first()
> > it feels that the same counter can be used to protect unit_alloc/free/irq_work.
> > Then we don't need free_llist_nmi. Single free_llist would be fine,
> > but unit_free() should not fail. If free_list cannot be accessed
> > due to per-cpu counter being busy we have to push somewhere.
> > So it seems two lists are necessary. Maybe it's still better ?
> > Roughly I'm thinking of the following:
> > unit_alloc()
> > {
> >   llnode = NULL;
> >   local_irq_save();
> >   if (__this_cpu_inc_return(c->alloc_active) != 1))
> >      goto out;
> >   llnode = __llist_del_first(&c->free_llist);
> >   if (llnode)
> >       cnt = --c->free_cnt;
> > out:
> >   __this_cpu_dec(c->alloc_active);
> >   local_irq_restore();
> >   return ret;
> > }
> > unit_free()
> > {
> >   local_irq_save();
> >   if (__this_cpu_inc_return(c->alloc_active) != 1)) {
> >      llist_add(llnode, &c->free_llist_nmi);
> >      goto out;
> >   }
> >   __llist_add(llnode, &c->free_llist);
> >   cnt = ++c->free_cnt;
> > out:
> >   __this_cpu_dec(c->alloc_active);
> >   local_irq_restore();
> >   return ret;
> > }
> > alloc_bulk, free_bulk would be protected by alloc_active as well.
> > alloc_bulk_nmi is gone.
> > free_bulk_nmi is still there to drain unlucky unit_free,
> > but it's now alone to do llist_del_first() and it just frees anything
> > that is in the free_llist_nmi.
> > The main advantage is that free_llist_nmi doesn't need to prefilled.
> > It will be empty most of the time.
> > wdyt?
> 
> Looks great! The other option would be to not have the overflow
> free_llist_nmi list and just allowing llist_add to free_llist from the
> NMI case even if we interrupt llist_del_first, but then the non-NMI
> user needs to use the atomic llist_add version as well (since we may
> interrupt it), 

not only llist_add, but unit_alloc would have to use atomic llist_del_first too.
So any operation on the list would have to be with cmpxchg.

> which won't be great for performance.

exactly.

> So having the
> extra list is much better.

yep. same thinking.
I'll refactor the patches and send v3 with this approach.
