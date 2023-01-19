Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319CE674362
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 21:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjASUPO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 15:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjASUPN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 15:15:13 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDA99DCBD
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 12:15:02 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id tz11so8809921ejc.0
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 12:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3kOLjzHumXMNyvCInGPv8iSQytc10zROb2jC3GMDI0A=;
        b=Z6jHgCnEYOYTNGDwkimYSSs/PRsmCormLQ2+xMGeIBRDkFyyRBFjj81IG1qywDCVPb
         GmDwhc6VKrjo6K4fk7bcmv8zY9SfyFwwPuYE5Sw3wsnSL0PrR1BSxRQ4i2C4uW7ehbJE
         4835FOUOT/aRARuWZ0HmeXR/wkb8QTcE+v9gfvuoSUgfcPEZ5Cf09f2h79vK8iQuSHTR
         /9Km/SS3IN2ZU76IT2onpyyy3QOeNtERAooVhrmwttdOmvJRvKoFEbCXCVV16FIhBcNg
         +7WCya2UP+HHQcIpseA1NeBCzHPHaE534vRwk5Fg19lwEsYXOjlXeCW3FRDVdIHggY8t
         Qtqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kOLjzHumXMNyvCInGPv8iSQytc10zROb2jC3GMDI0A=;
        b=69ZbWYjG1+yZltfBDfJeDqqmI91qxe5mYXnBiox09P1EPzH+kRwcLw7h553M2ViL9e
         MLY4uBZXxgBLFy334EzTRdxsMwZjlQy8tpDKgmyQYF4GYkcG9zX+lQxGxgkAloLERMhR
         8EssjLsJO9o9h+eQPp+RRpZl1TqxTZaQs0mlC2f+mYNbkdBucnqmlzrazf2IDAXncwX0
         JZe4Aq816OB5zTMsHh2ffXM0kd9BDgqMMS3JsQCqmug0WRtlc32OCmA7kiM8EIekXeUm
         Zi4VfHZQKQdO6Vp56Xx0VkcVVlK9rTYS1rdh7vNDp8yrzBdzLjv20VxqaN1TGNKMMH2E
         5Ngw==
X-Gm-Message-State: AFqh2kppJrGOnRdV+Yo+e+Yj7txnrtVKAJXRvY926B2jS0vq7xCPN/uo
        dDqQemNVwdo/wmt0E+VWiFoorRZVLPOZE5H0EYI=
X-Google-Smtp-Source: AMrXdXscSLt0ijHx/3rOGGEK9Bjr7Kaxz0Hd7/JJ5NRtiwGbVqsejLIaRT3Cu3+fTtztVwUYecgxR77miJESCQsGMSM=
X-Received: by 2002:a17:906:4a8f:b0:86c:e07a:3ce2 with SMTP id
 x15-20020a1709064a8f00b0086ce07a3ce2mr856645eju.58.1674159301190; Thu, 19 Jan
 2023 12:15:01 -0800 (PST)
MIME-Version: 1.0
References: <20230118051443.78988-1-alexei.starovoitov@gmail.com>
 <202301190848.D0543F7CE@keescook> <CAADnVQK44J7AOy7vBm-uQ11phehYxieJBNM9X1N_q8ZABLqLjw@mail.gmail.com>
 <202301191204.F54F66093@keescook>
In-Reply-To: <202301191204.F54F66093@keescook>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 19 Jan 2023 12:14:49 -0800
Message-ID: <CAADnVQKwhoqBVX+bN4LNHoArbswbMV2hDoe43H3TYQDWnjnhKA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] mm: Fix copy_from_user_nofault().
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 19, 2023 at 12:08 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Jan 19, 2023 at 11:21:33AM -0800, Alexei Starovoitov wrote:
> > On Thu, Jan 19, 2023 at 8:52 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Tue, Jan 17, 2023 at 09:14:42PM -0800, Alexei Starovoitov wrote:
> > > > From: Alexei Starovoitov <ast@kernel.org>
> > > >
> > > > There are several issues with copy_from_user_nofault():
> > > >
> > > > - access_ok() is designed for user context only and for that reason
> > > > it has WARN_ON_IN_IRQ() which triggers when bpf, kprobe, eprobe
> > > > and perf on ppc are calling it from irq.
> > > >
> > > > - it's missing nmi_uaccess_okay() which is a nop on all architectures
> > > > except x86 where it's required.
> > > > The comment in arch/x86/mm/tlb.c explains the details why it's necessary.
> > > > Calling copy_from_user_nofault() from bpf, [ke]probe without this check is not safe.
> > > >
> > > > - __copy_from_user_inatomic() under CONFIG_HARDENED_USERCOPY is calling
> > > > check_object_size()->__check_object_size()->check_heap_object()->find_vmap_area()->spin_lock()
> > > > which is not safe to do from bpf, [ke]probe and perf due to potential deadlock.
> > >
> > > Er, this drops check_object_size() -- that needs to stay. The vmap area
> > > test in check_object_size is likely what needs fixing. It was discussed
> > > before:
> > > https://lore.kernel.org/lkml/YySML2HfqaE%2FwXBU@casper.infradead.org/
> >
> > Thanks for the link.
> > Unfortunately all options discussed in that link won't work,
> > since all of them rely on in_interrupt() which will not catch the condition.
> > [ke]probe, bpf, perf can run after spin_lock is taken.
> > Like via trace_lock_release tracepoint.
> > It's only with lockdep=on, but still.
> > Or via trace_contention_begin tracepoint with lockdep=off.
> > check_object_size() will not execute in_interrupt().
> >
> > > The only reason it was ultimately tolerable to remove the check from
> > > the x86-only _nmi function was because it was being used on compile-time
> > > sized copies.
> >
> > It doesn't look to be the case.
> > copy_from_user_nmi() is called via __output_copy_user by perf
> > with run-time 'size'.
>
> Perhaps this changed recently? It was only called in copy_code() before
> when I looked last. Regardless, it still needs solving.

I think it was this way forever:
perf_output_sample_ustack(handle,
                          data->stack_user_size,
                          data->regs_user.regs);
__output_copy_user(handle, (void *) sp, dump_size);

kernel/events/internal.h:#define arch_perf_out_copy_user copy_from_user_nmi
kernel/events/internal.h:DEFINE_OUTPUT_COPY(__output_copy_user,
arch_perf_out_copy_user)


> > > We need to fix the vmap lookup so the checking doesn't regress --
> > > especially for trace, bpf, etc, where we could have much more interested
> > > dest/source/size combinations. :)
> >
> > Well, for bpf the 'dst' is never a vmalloc area, so
> > is_vmalloc_addr() and later spin_lock() in check_heap_object()
> > won't trigger.
> > Also for bpf the 'dst' area is statically checked by the verifier
> > at program load time, so at run-time the dst pointer is
> > guaranteed to be valid and of correct dimensions.
> > So doing check_object_size() is pointless unless there is a bug
> > in the verifier, but if there is a bug kasan and friends
> > will find it sooner. The 'dst' checks are generic and
> > not copy_from_user_nofault() specific.
> >
> > For trace, kprobe and perf would be nice to keep check_object_size()
> > working, of course.
> >
> > What do you suggest?
> > I frankly don't see other options other than done in this patch,
> > though it's not great.
> > Happy to be proven otherwise.
>
> Matthew, do you have any thoughts on dealing with this? Can we use a
> counter instead of a spin lock?
>
> -Kees
>
> --
> Kees Cook
