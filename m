Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3146546C4
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 20:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiLVTkh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 14:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiLVTkg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 14:40:36 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ED3298
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 11:40:35 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-45a51c37009so29761997b3.17
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 11:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fHSmwjvju/4GUeqDOzDADxPBU5RRlf6/zWyKUJBarhM=;
        b=EsDiVC77ogZmtg6CmDtPOw9yNC/buDHG+1avQ7d9P7vnS92xUcSc3T0wCX6ck5yugS
         4AP1dV/LCdXaxSetENmVXrNuMHZev9ypu4efiWmvmh5+w8euW7XQ7XnmdCeT8YpKnqfB
         H6wCjspNNDymIudKeW/5fW7HJSTItQfkpiYUFOvUSy5q4xBMnAzvJ8oLi832jymaQEgE
         eGAC4A2etszOXGRMmlL/ZcOy93JJs/YF+irov3fA09YRCrtiuTORxE4LBj8C2aCfRtPa
         ShY8zZnFcdSiUKpUrEfkWEcaC+qx5+BxR5hxf3hAJM/cgo2Li7j53wHQFs7vJdSK0ri3
         sYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHSmwjvju/4GUeqDOzDADxPBU5RRlf6/zWyKUJBarhM=;
        b=QRpU0PwJh5gwqDsBjwOp3reAvprHkMbdXGkWZbrriJhk0J7jySnR7Dunas6NVfQBO0
         yorXE0FFO1xQ8pTkYymh7IX9rqYvsOZ9bUSThiPdVRNtMolCsSiccoIEyzYBS6oKZaQA
         gL/kl9y7HZfRXuyLTt6h0rsbtjEtcUpzfewJruxPIpBeiHakvW/3e2uuKPZdS4Af0jPS
         MPN0/c3UZ8Z3kTmC5UAF8QGj5JqYjomeSDUlf/24hKsHq2lkoZBcLzKcsr8N+mPI3TII
         bbrLKmvqQAn+rSWgQaOxCLbeQs2TDQ/sMeSF3JnUyFX2diS7rErhm/hDNtxjOxzpJK9J
         uxKQ==
X-Gm-Message-State: AFqh2kroggat9x/vMlRCmwCM9jt5H1VI9EQMZF03CsKRUPk7r1bLCeoG
        qNhmB4JTPg9OTgxOY8OHBVcuM6w=
X-Google-Smtp-Source: AMrXdXu9Tez411NcfE1WtwXpi7xRznJqaiud2K3iv/6Dzc90tKJKg1NxqeOT3uUpqr+26ZedmC21cck=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:5587:0:b0:705:28c6:73f9 with SMTP id
 j129-20020a255587000000b0070528c673f9mr723568ybb.406.1671738035087; Thu, 22
 Dec 2022 11:40:35 -0800 (PST)
Date:   Thu, 22 Dec 2022 11:40:33 -0800
In-Reply-To: <CAHC9VhRFmrgXMYKxXqd1KpMzDGhT6gPX-=8Z072utZO_WefYWQ@mail.gmail.com>
Mime-Version: 1.0
References: <20221222001343.489117-1-paul@paul-moore.com> <Y6SRiv+FloijdETe@google.com>
 <CAHC9VhRFmrgXMYKxXqd1KpMzDGhT6gPX-=8Z072utZO_WefYWQ@mail.gmail.com>
Message-ID: <Y6SysZgKKEPL5ZE5@google.com>
Subject: Re: [PATCH] bpf: restore the ebpf audit UNLOAD id field
From:   sdf@google.com
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Burn Alting <burn.alting@iinet.net.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/22, Paul Moore wrote:
> On Thu, Dec 22, 2022 at 12:19 PM <sdf@google.com> wrote:
> > On 12/21, Paul Moore wrote:
> > > When changing the ebpf program put() routines to support being called
> > > from within IRQ context the program ID was reset to zero prior to
> > > generating the audit UNLOAD record, which obviously rendered the ID
> > > field bogus (always zero).  This patch resolves this by adding a new
> > > field, bpf_prog_aux::id_audit, which is set when the ebpf program is
> > > allocated an ID and never reset, ensuring a valid ID field,
> > > regardless of the state of the original ID field, bpf_prox_aud::id.
> >
> > > I also modified the bpf_audit_prog() logic used to associate the
> > > AUDIT_BPF record with other associated records, e.g. @ctx != NULL.
> > > Instead of keying off the operation, it now keys off the execution
> > > context, e.g. '!in_irg && !irqs_disabled()', which is much more
> > > appropriate and should help better connect the UNLOAD operations with
> > > the associated audit state (other audit records).
> >
> > [..]
> >
> > > As an note to future bug hunters, I did briefly consider removing the
> > > ID reset in bpf_prog_free_id(), as it would seem that once the
> > > program is removed from the idr pool it can no longer be found by its
> > > ID value, but commit ad8ad79f4f60 ("bpf: offload: free program id
> > > when device disappears") seems to imply that it is beneficial to
> > > reset the ID value.  Perhaps as a secondary indicator that the ebpf
> > > program is unbound/orphaned.
> >
> > That seems like the way to go imho. Can we have some extra 'invalid_id'
> > bitfield in the bpf_prog so we can set it in bpf_prog_free_id and
> > check in bpf_prog_free_id (for this offloaded use-case)? Because
> > having two ids and then keeping track about which one to use, depending
> > on the context, seems more fragile?

> I would definitely prefer to keep just a single ID value, and that was
> the first approach I took when drafting this patch, but when looking
> through the git log it looked like there was some desire to reset the
> ID to zero on free.  Not being an expert on the ebpf kernel code I
> figured I would just write the patch up this way and make a comment
> about not zero'ing out the ID in the commit description so we could
> have a discussion about it.

Yeah, the commit you reference is resetting the id for the offloaded
progs. But it also mentions that even though we reset the id,
it won't leak into the userspace:

   Note that orphaned offload programs will return -ENODEV on
   BPF_OBJ_GET_INFO_BY_FD so user will never see ID 0.

It talks about the "if (!aux->offload)" check in bpf_prog_offload_info_fill.
So I'm assuming that having some extra "this id is already free" signal
in the bpf_prog shouldn't be a problem here.

> I'm not seeing any other comments, so I'll go ahead with putting
> together a v2 that sets an invalid flag/bit and I'll post that for
> further discussion/review.

> > > Fixes: d809e134be7a ("bpf: Prepare bpf_prog_put() to be called from  
> irq
> > > context.")
> > > Reported-by: Burn Alting <burn.alting@iinet.net.au>
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >   include/linux/bpf.h  | 1 +
> > >   kernel/bpf/syscall.c | 8 +++++---
> > >   2 files changed, 6 insertions(+), 3 deletions(-)

> --
> paul-moore.com
