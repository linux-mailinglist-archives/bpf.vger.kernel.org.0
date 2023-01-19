Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E076A67434B
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 21:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjASUI2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 15:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjASUI1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 15:08:27 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E0E9373F
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 12:08:23 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id w2so2350757pfc.11
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 12:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2nPSPjasSbRKPEvUyFhW+3po11/ywzEIRzQJOy3VUm0=;
        b=a6GwWh17J0vjrAnW02hJ0KaOnd1qbgODKkH8xeOGsCt38dhPdbN1uJhINBJt3xM/Xn
         CQNuwGpEiTw23Bons+WlUfUdu61smx/8Xw+qPb3uX/h+uIP1R9Mzkxfw/sBk1K7IaOsU
         rxkGbTOuLVxqvnpMk1TH4XlQ8Nk8txPCKru0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nPSPjasSbRKPEvUyFhW+3po11/ywzEIRzQJOy3VUm0=;
        b=ZmheDwVq+jRZ9wAXTohkys+awNqd/Yg+HWOn5xqfYS7ERBSu7aveU8OHxN96b9Hliy
         ttNFYfliCmNUxsLMQ8Dr55iT16o2R4XWVXCDa2T0VA9UzR+gtblcMAPlnStKHaMWbVXu
         C902qUBpAfgHKFjjiKhaDqyzTe1qZNq3ZX3fWRK+G3TARwuEI+PSp6o03+21Wq8+l9r3
         EdSbWf9yE6W0j1WmyHEGwMahLntbjnA3SwDIkEjq/cUIu5Edgd2HO3oVGo721MSRnI+w
         aArrhqt3gf2msy4/sUEp5r9CZHb2jvI2Z1f7o9EtM9bQpZwr4qTcr4oBT+5wlDxGAryl
         9dNw==
X-Gm-Message-State: AFqh2kq0X9hM6+ZMKgx6kDLBJNhEmW/YqXxo62jQCf6PPjjDXTZQw7Fs
        EFOtjibYhGwD3SCdtgQeLtuA6A==
X-Google-Smtp-Source: AMrXdXvKMNKMixgP6A8XzxYN+WO6lMuUInJ28WHTkOcrIAMI7PTfWjrhuWaZcEiEqgS2469GlRB07g==
X-Received: by 2002:aa7:9705:0:b0:58d:c617:8e9d with SMTP id a5-20020aa79705000000b0058dc6178e9dmr14330765pfg.3.1674158903085;
        Thu, 19 Jan 2023 12:08:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k197-20020a6284ce000000b00574b86040a4sm24519630pfd.3.2023.01.19.12.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 12:08:22 -0800 (PST)
Date:   Thu, 19 Jan 2023 12:08:21 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        X86 ML <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hsin-Wei Hung <hsinweih@uci.edu>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>, dylany@meta.com,
        Rik van Riel <riel@surriel.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf 1/2] mm: Fix copy_from_user_nofault().
Message-ID: <202301191204.F54F66093@keescook>
References: <20230118051443.78988-1-alexei.starovoitov@gmail.com>
 <202301190848.D0543F7CE@keescook>
 <CAADnVQK44J7AOy7vBm-uQ11phehYxieJBNM9X1N_q8ZABLqLjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQK44J7AOy7vBm-uQ11phehYxieJBNM9X1N_q8ZABLqLjw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 19, 2023 at 11:21:33AM -0800, Alexei Starovoitov wrote:
> On Thu, Jan 19, 2023 at 8:52 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Jan 17, 2023 at 09:14:42PM -0800, Alexei Starovoitov wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > There are several issues with copy_from_user_nofault():
> > >
> > > - access_ok() is designed for user context only and for that reason
> > > it has WARN_ON_IN_IRQ() which triggers when bpf, kprobe, eprobe
> > > and perf on ppc are calling it from irq.
> > >
> > > - it's missing nmi_uaccess_okay() which is a nop on all architectures
> > > except x86 where it's required.
> > > The comment in arch/x86/mm/tlb.c explains the details why it's necessary.
> > > Calling copy_from_user_nofault() from bpf, [ke]probe without this check is not safe.
> > >
> > > - __copy_from_user_inatomic() under CONFIG_HARDENED_USERCOPY is calling
> > > check_object_size()->__check_object_size()->check_heap_object()->find_vmap_area()->spin_lock()
> > > which is not safe to do from bpf, [ke]probe and perf due to potential deadlock.
> >
> > Er, this drops check_object_size() -- that needs to stay. The vmap area
> > test in check_object_size is likely what needs fixing. It was discussed
> > before:
> > https://lore.kernel.org/lkml/YySML2HfqaE%2FwXBU@casper.infradead.org/
> 
> Thanks for the link.
> Unfortunately all options discussed in that link won't work,
> since all of them rely on in_interrupt() which will not catch the condition.
> [ke]probe, bpf, perf can run after spin_lock is taken.
> Like via trace_lock_release tracepoint.
> It's only with lockdep=on, but still.
> Or via trace_contention_begin tracepoint with lockdep=off.
> check_object_size() will not execute in_interrupt().
> 
> > The only reason it was ultimately tolerable to remove the check from
> > the x86-only _nmi function was because it was being used on compile-time
> > sized copies.
> 
> It doesn't look to be the case.
> copy_from_user_nmi() is called via __output_copy_user by perf
> with run-time 'size'.

Perhaps this changed recently? It was only called in copy_code() before
when I looked last. Regardless, it still needs solving.

> > We need to fix the vmap lookup so the checking doesn't regress --
> > especially for trace, bpf, etc, where we could have much more interested
> > dest/source/size combinations. :)
> 
> Well, for bpf the 'dst' is never a vmalloc area, so
> is_vmalloc_addr() and later spin_lock() in check_heap_object()
> won't trigger.
> Also for bpf the 'dst' area is statically checked by the verifier
> at program load time, so at run-time the dst pointer is
> guaranteed to be valid and of correct dimensions.
> So doing check_object_size() is pointless unless there is a bug
> in the verifier, but if there is a bug kasan and friends
> will find it sooner. The 'dst' checks are generic and
> not copy_from_user_nofault() specific.
> 
> For trace, kprobe and perf would be nice to keep check_object_size()
> working, of course.
> 
> What do you suggest?
> I frankly don't see other options other than done in this patch,
> though it's not great.
> Happy to be proven otherwise.

Matthew, do you have any thoughts on dealing with this? Can we use a
counter instead of a spin lock?

-Kees

-- 
Kees Cook
