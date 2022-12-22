Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEC7654933
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 00:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiLVXUW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 18:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLVXUV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 18:20:21 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BA921E3F
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 15:20:19 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id d20so5044227edn.0
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 15:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iJgMFVOrb9Ce/17yeODdS1CKT2hqIh/Wcl38sjrwoW0=;
        b=BEfpWSBtRhdTQl3I6MpGZqVYpUdqzyWJ1oUZ1sXP6WNSAqcnRONz4mNaqYQQdmj2xY
         lgFxzrsir9zv5ynFuIasZ4H0mZHaJhMR90nGy9Sy8le+wipidXaFzkcbkzDeNaB0LQ6J
         qUosmbcKcqkrYnRNQyS7MF9XhMSj92CwkAoZfTyEKnvLDEtZj2XEpzZMZzqGPLnQLbW5
         fUFXFlELhmXTAeaqLTRuri585LmO73sYeLZNGLt87GHWAfT4rj6lHc6r0CKBkiwb2eCI
         EzpWSzXgN15dw9su7VKLD1zVCJ2Zhs2rcl02Ms8OlKssyXbcqCwP/jBq6VLcIsL92w+u
         aDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJgMFVOrb9Ce/17yeODdS1CKT2hqIh/Wcl38sjrwoW0=;
        b=RnQMVxE3Zvqe0xzs5GYfoUvuWokkq1MP+xNXtb+83o6dnC6kf48aehzzf0GCd5O1Wt
         cT0zX9TxnQ8Ksk1Gf0QLTtlnLagBa4gcn0uTPFGNvtDhTr9/xJO/EgA6cnf9j1VMMoTy
         Ay8PR+/YeuyvSXmqhIy52AnmEWBK3rGhITn0mVxpQDqfJiVdjIaIUidCqbs84fLZQjGt
         MYIvBVCvDVRTOTujf79vJYoAwVBbmcx5+VV/jJAVi9ajyglZ4TATMl1muklgn1kJG2tV
         a9rPBXzHis793IqxsOxbqTLns9QWEalA8YE7BpZIqezbY/ZHpcOvVOxPvjyO7mh/qGRb
         Ex5Q==
X-Gm-Message-State: AFqh2krkNlam6Gu7mm1x3yZr3eK0fOo2PSBB9AWZweZlW/NwvoETnb/J
        7ZuCmurBu8tiaGuIIbk6TZQ=
X-Google-Smtp-Source: AMrXdXsFC+hmKq79PeW+KUm2ca/pltb9zbhnABL2aMPJOE1HMdCr+a/qBrze/JnBXo5BFJiptXRh3w==
X-Received: by 2002:a05:6402:3706:b0:472:9af1:163f with SMTP id ek6-20020a056402370600b004729af1163fmr6129935edb.37.1671751218317;
        Thu, 22 Dec 2022 15:20:18 -0800 (PST)
Received: from krava ([83.240.60.17])
        by smtp.gmail.com with ESMTPSA id s8-20020a170906354800b007ad2da5668csm705785eja.112.2022.12.22.15.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 15:20:17 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 23 Dec 2022 00:20:15 +0100
To:     Paul Moore <paul@paul-moore.com>
Cc:     sdf@google.com, linux-audit@redhat.com, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Burn Alting <burn.alting@iinet.net.au>
Subject: Re: [PATCH] bpf: restore the ebpf audit UNLOAD id field
Message-ID: <Y6TmLyDTY/a20Zq4@krava>
References: <20221222001343.489117-1-paul@paul-moore.com>
 <Y6SRiv+FloijdETe@google.com>
 <CAHC9VhRFmrgXMYKxXqd1KpMzDGhT6gPX-=8Z072utZO_WefYWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRFmrgXMYKxXqd1KpMzDGhT6gPX-=8Z072utZO_WefYWQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 22, 2022 at 02:03:41PM -0500, Paul Moore wrote:
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
> 
> I would definitely prefer to keep just a single ID value, and that was
> the first approach I took when drafting this patch, but when looking
> through the git log it looked like there was some desire to reset the
> ID to zero on free.  Not being an expert on the ebpf kernel code I
> figured I would just write the patch up this way and make a comment
> about not zero'ing out the ID in the commit description so we could
> have a discussion about it.
> 
> I'm not seeing any other comments, so I'll go ahead with putting
> together a v2 that sets an invalid flag/bit and I'll post that for
> further discussion/review.

great, perf suffers the same issue:
  https://lore.kernel.org/bpf/Y3SRWVoycV290S16@krava/

any chance you could include it as well? I can send a patch
later if needed

thanks,
jirka

> 
> > > Fixes: d809e134be7a ("bpf: Prepare bpf_prog_put() to be called from irq
> > > context.")
> > > Reported-by: Burn Alting <burn.alting@iinet.net.au>
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >   include/linux/bpf.h  | 1 +
> > >   kernel/bpf/syscall.c | 8 +++++---
> > >   2 files changed, 6 insertions(+), 3 deletions(-)
> 
> -- 
> paul-moore.com
