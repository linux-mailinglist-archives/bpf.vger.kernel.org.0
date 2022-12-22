Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE23B6546F1
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 20:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiLVT7c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 14:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLVT7b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 14:59:31 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23511CFFD
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 11:59:29 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id d10so1981248pgm.13
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 11:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OYOcnppnjv8swtEgO4QQRDHFBz+p7juA0/BK+cLYUj0=;
        b=1YZStI7EYsKHWCyEdstem64dziYPLEbVbDJuEBbJyC8C03vwfD/CEFMJuAA1qwoVEy
         +I0WeJ+AAPDmnT54gatr2f6SlXNO21nsUVffDQ46j+Yfapn9M3maf0PYFgJ/UZ05/eSn
         JfBNIVIfz73DmJ3d+e2jRI2JqQ+lnqIpeoqon5p/DSfniL+LIbt1hBSG0uwdr1Jw2f98
         gSwOUe5s0YsMaSbPWUcXUx+FRDtd6rJPtuFEtnPpuZe91IQzkkQCu5UE6q3C16QezOYt
         +KXaVW5CXqEavs9VRr5drR8NIHfIDo4eTOV0g2G2qwIwOsnbT4rQ6SLKTz8quXljiXqL
         WSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYOcnppnjv8swtEgO4QQRDHFBz+p7juA0/BK+cLYUj0=;
        b=SFBtFcqXYE/6h8d10u8Vqr9+iQuLZVwHAZYSF3BuenfRA9jUfBA8AkvBIMjy/GMVHe
         m2z+4B5BaaN++K2uqg+aZ2AFRgYU2ApYiqWsMrBUgzQCVtDQbMYs+ok6cF1IKKUeIy9M
         zBXhOwJAbBKzfDXLicg1Mrp3hpKC310vFaDVgs+255EoHD6yZWujxQ16ph9jD6SViZqI
         Mz1bBbH1y9bTL/4x0TOtJCrZDU5s5/RAeSuK1ykHPvGfg4kBx3D2iSwk8QL3Yaa3IG1n
         5FksRiRIvS4dTVDw65l+O8whYYVFCqtL59IOWSiHwrKZZB+R2fjvqi2WobisslqzG+Xy
         FcEA==
X-Gm-Message-State: AFqh2kqQf5FP+4dWAdwVAmPIRm4Ib0CLPNi6bHySZMu3I8ezWvd884y1
        fgmDByZMYGPiXxcca2uiJnNZqN7m5WHM6+or8palB+lirEBisA4=
X-Google-Smtp-Source: AMrXdXtcIUhwVSi7GhU7APuAnO+KcyB139p4XC2XcKeQKC5pNjoCIagdi9V+EIhy8mZ+xJ0pAMbNtQTxt1zIr6QHC4g=
X-Received: by 2002:a05:6a00:1f1a:b0:576:af2d:4c5f with SMTP id
 be26-20020a056a001f1a00b00576af2d4c5fmr449104pfb.23.1671739169344; Thu, 22
 Dec 2022 11:59:29 -0800 (PST)
MIME-Version: 1.0
References: <20221222001343.489117-1-paul@paul-moore.com> <Y6SRiv+FloijdETe@google.com>
 <CAHC9VhRFmrgXMYKxXqd1KpMzDGhT6gPX-=8Z072utZO_WefYWQ@mail.gmail.com> <Y6SysZgKKEPL5ZE5@google.com>
In-Reply-To: <Y6SysZgKKEPL5ZE5@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 22 Dec 2022 14:59:17 -0500
Message-ID: <CAHC9VhQ4EPzQ56ix9he4ZTo7eYpMdLBPpb+3vNsng_9vD2t=RQ@mail.gmail.com>
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

On Thu, Dec 22, 2022 at 2:40 PM <sdf@google.com> wrote:
> On 12/22, Paul Moore wrote:
> > On Thu, Dec 22, 2022 at 12:19 PM <sdf@google.com> wrote:
> > > On 12/21, Paul Moore wrote:
> > > > When changing the ebpf program put() routines to support being called
> > > > from within IRQ context the program ID was reset to zero prior to
> > > > generating the audit UNLOAD record, which obviously rendered the ID
> > > > field bogus (always zero).  This patch resolves this by adding a new
> > > > field, bpf_prog_aux::id_audit, which is set when the ebpf program is
> > > > allocated an ID and never reset, ensuring a valid ID field,
> > > > regardless of the state of the original ID field, bpf_prox_aud::id.
> > >
> > > > I also modified the bpf_audit_prog() logic used to associate the
> > > > AUDIT_BPF record with other associated records, e.g. @ctx != NULL.
> > > > Instead of keying off the operation, it now keys off the execution
> > > > context, e.g. '!in_irg && !irqs_disabled()', which is much more
> > > > appropriate and should help better connect the UNLOAD operations with
> > > > the associated audit state (other audit records).
> > >
> > > [..]
> > >
> > > > As an note to future bug hunters, I did briefly consider removing the
> > > > ID reset in bpf_prog_free_id(), as it would seem that once the
> > > > program is removed from the idr pool it can no longer be found by its
> > > > ID value, but commit ad8ad79f4f60 ("bpf: offload: free program id
> > > > when device disappears") seems to imply that it is beneficial to
> > > > reset the ID value.  Perhaps as a secondary indicator that the ebpf
> > > > program is unbound/orphaned.
> > >
> > > That seems like the way to go imho. Can we have some extra 'invalid_id'
> > > bitfield in the bpf_prog so we can set it in bpf_prog_free_id and
> > > check in bpf_prog_free_id (for this offloaded use-case)? Because
> > > having two ids and then keeping track about which one to use, depending
> > > on the context, seems more fragile?
>
> > I would definitely prefer to keep just a single ID value, and that was
> > the first approach I took when drafting this patch, but when looking
> > through the git log it looked like there was some desire to reset the
> > ID to zero on free.  Not being an expert on the ebpf kernel code I
> > figured I would just write the patch up this way and make a comment
> > about not zero'ing out the ID in the commit description so we could
> > have a discussion about it.
>
> Yeah, the commit you reference is resetting the id for the offloaded
> progs. But it also mentions that even though we reset the id,
> it won't leak into the userspace:
>
>    Note that orphaned offload programs will return -ENODEV on
>    BPF_OBJ_GET_INFO_BY_FD so user will never see ID 0.
>
> It talks about the "if (!aux->offload)" check in bpf_prog_offload_info_fill.
> So I'm assuming that having some extra "this id is already free" signal
> in the bpf_prog shouldn't be a problem here.

FWIW, the currently-work-in-progress v2 patch adds a getter for the ID
with a WARN() check to flag callers who are trying to access a
bad/free'd bpf_prog.  Unfortunately it touches a decent chunk of code,
but I think it might be a nice additional check at runtime.

+u32 bpf_prog_get_id(const struct bpf_prog *prog)
+{
+       if (WARN(!prog->valid_id, "Attempting to use invalid eBPF program"))
+               return 0;
+       return prog->aux->__id;
+}

> > I'm not seeing any other comments, so I'll go ahead with putting
> > together a v2 that sets an invalid flag/bit and I'll post that for
> > further discussion/review.

-- 
paul-moore.com
