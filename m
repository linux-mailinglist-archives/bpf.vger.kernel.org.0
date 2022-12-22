Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E565A654653
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 20:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiLVTD7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 14:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLVTDy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 14:03:54 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A57E009
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 11:03:53 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id jn22so2832774plb.13
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 11:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wZuh56pq7ahWITyeAc8QVn3pfU1sykqjnr90paIdT6g=;
        b=bJuq36kQ0UymZ1bH2Zq/vrJeQrmuBPuIy/L2cgEkq+YwesDWdv1tEtWP2xshTWqEGy
         5f/lmDOq9t52OSstd0lQ9JylT7zbqXOu+hcvyXOjGlggOBChA3llnRS/SQc86kXsql1h
         YiedMrthsZOTH6JHJOJhEjhxX6eRqzPErSXL01K5sT778jCGIqACNcaAbeXqOj8Jk4M6
         g1Th7bYZoaOsvLmWHfoGj3/3FnQk/HgnLekNZGlPW8CTEyVtYLdh0XIiSfWVMbnvNX2O
         i26wODcba54YOFfS0BcAqusI4EIbNSYohtpPca22Eu1ZPcC8oa8evZosguYx+Wm3m07L
         sUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wZuh56pq7ahWITyeAc8QVn3pfU1sykqjnr90paIdT6g=;
        b=aq7jEkrEBYHEUFxxZmevAXtqasp4skxrAPYXDtoH3E7A+18JdP50dGIoaR3jfXKitY
         kSJ7upwZHkY8fuXLNmDg1BxUIK5tAhgLF5y9gFmIRvx6ro/jba4EPfroNo9+L/UNRn1U
         uKr9DbGtJ6ATHuRcKiDtReRH9k2v+e0LnLku7AA4jIHMh6hFyHhZRGOPasmYFvIOSOE7
         RcziSgjYAz0q8fyQ9LpPLL/8cp8bcmY52MsSeZGXNnAAtmKX/rRunxIjC71EBk18O9ZJ
         gLl3xLP214V8WLvvp849skBas5KRjTE7omAMv1IRX8xZQ5Qv/LfRQoBbj/QfeQVorLMt
         7Nqw==
X-Gm-Message-State: AFqh2kqzU0eNF9fjKVY7W9/PwyoLhYLd0SEEU2aOvHWMKbX3UkTjtpOq
        AlhmaZNXqrPCDj6lp+CZS4mqzNN7Tdg7+AoECkLP
X-Google-Smtp-Source: AMrXdXuLBW62rtr8n+WHMO5P8CrzkBC2Dj2uFe95m0QcMCsPRz+Cu811+8CpYEaLqMWhKXj5QH42vDYDpxMe1o0zLRc=
X-Received: by 2002:a17:902:e48a:b0:186:c3b2:56d1 with SMTP id
 i10-20020a170902e48a00b00186c3b256d1mr392070ple.15.1671735832520; Thu, 22 Dec
 2022 11:03:52 -0800 (PST)
MIME-Version: 1.0
References: <20221222001343.489117-1-paul@paul-moore.com> <Y6SRiv+FloijdETe@google.com>
In-Reply-To: <Y6SRiv+FloijdETe@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 22 Dec 2022 14:03:41 -0500
Message-ID: <CAHC9VhRFmrgXMYKxXqd1KpMzDGhT6gPX-=8Z072utZO_WefYWQ@mail.gmail.com>
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

On Thu, Dec 22, 2022 at 12:19 PM <sdf@google.com> wrote:
> On 12/21, Paul Moore wrote:
> > When changing the ebpf program put() routines to support being called
> > from within IRQ context the program ID was reset to zero prior to
> > generating the audit UNLOAD record, which obviously rendered the ID
> > field bogus (always zero).  This patch resolves this by adding a new
> > field, bpf_prog_aux::id_audit, which is set when the ebpf program is
> > allocated an ID and never reset, ensuring a valid ID field,
> > regardless of the state of the original ID field, bpf_prox_aud::id.
>
> > I also modified the bpf_audit_prog() logic used to associate the
> > AUDIT_BPF record with other associated records, e.g. @ctx != NULL.
> > Instead of keying off the operation, it now keys off the execution
> > context, e.g. '!in_irg && !irqs_disabled()', which is much more
> > appropriate and should help better connect the UNLOAD operations with
> > the associated audit state (other audit records).
>
> [..]
>
> > As an note to future bug hunters, I did briefly consider removing the
> > ID reset in bpf_prog_free_id(), as it would seem that once the
> > program is removed from the idr pool it can no longer be found by its
> > ID value, but commit ad8ad79f4f60 ("bpf: offload: free program id
> > when device disappears") seems to imply that it is beneficial to
> > reset the ID value.  Perhaps as a secondary indicator that the ebpf
> > program is unbound/orphaned.
>
> That seems like the way to go imho. Can we have some extra 'invalid_id'
> bitfield in the bpf_prog so we can set it in bpf_prog_free_id and
> check in bpf_prog_free_id (for this offloaded use-case)? Because
> having two ids and then keeping track about which one to use, depending
> on the context, seems more fragile?

I would definitely prefer to keep just a single ID value, and that was
the first approach I took when drafting this patch, but when looking
through the git log it looked like there was some desire to reset the
ID to zero on free.  Not being an expert on the ebpf kernel code I
figured I would just write the patch up this way and make a comment
about not zero'ing out the ID in the commit description so we could
have a discussion about it.

I'm not seeing any other comments, so I'll go ahead with putting
together a v2 that sets an invalid flag/bit and I'll post that for
further discussion/review.

> > Fixes: d809e134be7a ("bpf: Prepare bpf_prog_put() to be called from irq
> > context.")
> > Reported-by: Burn Alting <burn.alting@iinet.net.au>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >   include/linux/bpf.h  | 1 +
> >   kernel/bpf/syscall.c | 8 +++++---
> >   2 files changed, 6 insertions(+), 3 deletions(-)

-- 
paul-moore.com
