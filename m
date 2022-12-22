Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4E96546FB
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 21:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiLVUHu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 15:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiLVUHs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 15:07:48 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1C9659A
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 12:07:48 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso6856865pjt.0
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 12:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Okvp41I+wX+voP3C0w/v4exnNJYnShEom/tOMIuEEmc=;
        b=05anTL2xj2qBz6WxpvNMTcjXp8JiGcznxQPptLIUMUcSYjXoXDyolefdmqWe7A5Xi1
         u9sl8yci/bgWDm7ozuZoypmvcqbucxEA7OwIjKhAi6TqCaIMQiVyFA4PooQ2LI51vh6x
         PwpqTfO2EvGD4oDbO1+tXVtgoaR2geembVp77mSRyYOXHgU084O2lCF+zXN5FqIcsOW7
         wBISka1TSpfBqqIQ87lnviNTkpe0Ch73rxg+ZTFUc8KgzBoT36jZgc71Ko7S82UVk9Wc
         07KlYqbu8N8WEvOd7C4k95NnqxzRySRBVpesNLjMYptzL+B4TIjZes6GfrCoDYMLGAIN
         rw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Okvp41I+wX+voP3C0w/v4exnNJYnShEom/tOMIuEEmc=;
        b=5ktccoXh38hm0oEt5su6C0L3SWHJROfeVn50t67R4W9xa4Gszol2Ov5ICRftBcWeZB
         EuFBzTWSFIVA5sX/SK60UiNPlbKGBKOps+JfheN0w95TBoejFAdivmIfKYz7QWfeYVZv
         U2MYG7G6uznS5YdCwHeOXQeVtFRq5VWprCMSjeRGWy0jxZlwtOvXSNzRISppH3CsHKsY
         mbJbnyqK3aaEZUaLt3NmGR0kK9I72ftfJpK4UqkSYrROAm3lI/kT0rHBPfJa6ENT3wfN
         XAxRphqD/luU3moE8o12jK+ccUS3+1RbCVlFF9eaJu15qD+p2poC9Z1V0ZtTfGXjqjda
         PmWw==
X-Gm-Message-State: AFqh2kpGtGwX24UaDzOBk2Sl8MuhoAErUTlZMwJOwChk9xAH3GYP91zF
        eWgBT/oQs0vhCCAJNG0OR4DG7wtyj5u8E0B5Lc1/
X-Google-Smtp-Source: AMrXdXv3T+wIlc4Rgw8O/jSaNRs9ucvsd9qarSnqHI2c/4SUqPz+XIqDHsYRZvV6XK2AxTqqIapJF2EoaZAiYINzIbM=
X-Received: by 2002:a17:90a:8a82:b0:219:b79d:c308 with SMTP id
 x2-20020a17090a8a8200b00219b79dc308mr828965pjn.69.1671739667430; Thu, 22 Dec
 2022 12:07:47 -0800 (PST)
MIME-Version: 1.0
References: <20221222001343.489117-1-paul@paul-moore.com> <Y6SRiv+FloijdETe@google.com>
 <CAHC9VhRFmrgXMYKxXqd1KpMzDGhT6gPX-=8Z072utZO_WefYWQ@mail.gmail.com>
 <Y6SysZgKKEPL5ZE5@google.com> <CAHC9VhQ4EPzQ56ix9he4ZTo7eYpMdLBPpb+3vNsng_9vD2t=RQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQ4EPzQ56ix9he4ZTo7eYpMdLBPpb+3vNsng_9vD2t=RQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 22 Dec 2022 15:07:35 -0500
Message-ID: <CAHC9VhSwpV80pPjzc2w9r--16LXuG7vYxE1eg5MCz2ytn2TH7g@mail.gmail.com>
Subject: Re: [PATCH] bpf: restore the ebpf audit UNLOAD id field
To:     sdf@google.com
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Burn Alting <burn.alting@iinet.net.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 22, 2022 at 2:59 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Dec 22, 2022 at 2:40 PM <sdf@google.com> wrote:
> > On 12/22, Paul Moore wrote:
> > > On Thu, Dec 22, 2022 at 12:19 PM <sdf@google.com> wrote:
> > > > On 12/21, Paul Moore wrote:
> > > > > When changing the ebpf program put() routines to support being called
> > > > > from within IRQ context the program ID was reset to zero prior to
> > > > > generating the audit UNLOAD record, which obviously rendered the ID
> > > > > field bogus (always zero).  This patch resolves this by adding a new
> > > > > field, bpf_prog_aux::id_audit, which is set when the ebpf program is
> > > > > allocated an ID and never reset, ensuring a valid ID field,
> > > > > regardless of the state of the original ID field, bpf_prox_aud::id.
> > > >
> > > > > I also modified the bpf_audit_prog() logic used to associate the
> > > > > AUDIT_BPF record with other associated records, e.g. @ctx != NULL.
> > > > > Instead of keying off the operation, it now keys off the execution
> > > > > context, e.g. '!in_irg && !irqs_disabled()', which is much more
> > > > > appropriate and should help better connect the UNLOAD operations with
> > > > > the associated audit state (other audit records).
> > > >
> > > > [..]
> > > >
> > > > > As an note to future bug hunters, I did briefly consider removing the
> > > > > ID reset in bpf_prog_free_id(), as it would seem that once the
> > > > > program is removed from the idr pool it can no longer be found by its
> > > > > ID value, but commit ad8ad79f4f60 ("bpf: offload: free program id
> > > > > when device disappears") seems to imply that it is beneficial to
> > > > > reset the ID value.  Perhaps as a secondary indicator that the ebpf
> > > > > program is unbound/orphaned.
> > > >
> > > > That seems like the way to go imho. Can we have some extra 'invalid_id'
> > > > bitfield in the bpf_prog so we can set it in bpf_prog_free_id and
> > > > check in bpf_prog_free_id (for this offloaded use-case)? Because
> > > > having two ids and then keeping track about which one to use, depending
> > > > on the context, seems more fragile?
> >
> > > I would definitely prefer to keep just a single ID value, and that was
> > > the first approach I took when drafting this patch, but when looking
> > > through the git log it looked like there was some desire to reset the
> > > ID to zero on free.  Not being an expert on the ebpf kernel code I
> > > figured I would just write the patch up this way and make a comment
> > > about not zero'ing out the ID in the commit description so we could
> > > have a discussion about it.
> >
> > Yeah, the commit you reference is resetting the id for the offloaded
> > progs. But it also mentions that even though we reset the id,
> > it won't leak into the userspace:
> >
> >    Note that orphaned offload programs will return -ENODEV on
> >    BPF_OBJ_GET_INFO_BY_FD so user will never see ID 0.
> >
> > It talks about the "if (!aux->offload)" check in bpf_prog_offload_info_fill.
> > So I'm assuming that having some extra "this id is already free" signal
> > in the bpf_prog shouldn't be a problem here.
>
> FWIW, the currently-work-in-progress v2 patch adds a getter for the ID
> with a WARN() check to flag callers who are trying to access a
> bad/free'd bpf_prog.  Unfortunately it touches a decent chunk of code,
> but I think it might be a nice additional check at runtime.
>
> +u32 bpf_prog_get_id(const struct bpf_prog *prog)
> +{
> +       if (WARN(!prog->valid_id, "Attempting to use invalid eBPF program"))
> +               return 0;
> +       return prog->aux->__id;
> +}

I should add that the getter is currently a static inline in bpf.h.

> > > I'm not seeing any other comments, so I'll go ahead with putting
> > > together a v2 that sets an invalid flag/bit and I'll post that for
> > > further discussion/review.

-- 
paul-moore.com
