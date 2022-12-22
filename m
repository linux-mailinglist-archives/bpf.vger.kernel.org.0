Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561756547DC
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 22:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiLVV2G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 16:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLVV2F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 16:28:05 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF08101D7
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 13:28:04 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id m4so3203202pls.4
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 13:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6mc7OW9rt3wbWYcaANytniKa3C0AqTKlhbi86XCpads=;
        b=D96kLoxsooqoHz2/EL7dgh47VaIbuJPwQS/OqDX32n07Cz4+G+4HNxpQ73QSk3VDWc
         f/xt/dGOmMnQso3UrMY9tlkmQ/aET1iIP6d7TxzK78W5ILXPaUhBRHFnlXrMyq86bHGq
         uBvRll4q+yniM+d/qZG496z3ShznkqhSBIri4JpbhPONntMKa+AEa/Zm8Y/Nx6rbKFeg
         SbMtUOmLw2Iin2F01vlYLiuX5gjRT2YYsfCB67fnVSIKGX56n1vIDtyPHjZ8jLFs6e06
         4GidjDoiUOB0aMdpzMc9AaLihS3XrmYc30GI7XW7uZccoxtVDrLZvmLUiLP1Stu2LqoQ
         IULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6mc7OW9rt3wbWYcaANytniKa3C0AqTKlhbi86XCpads=;
        b=m3X8p5w9B4VY9LB0tdfubrL4BkjAFmUIT+yciFaMj78uHzEIXRW2b/Xmj3UBam9nQe
         2jdvFGlXgZyhI36JuPxYw0v4bLiL0X+L4FyIdAPbyijBdSFUKSKdCw14qHd1hVLGh6y8
         koEYCVUZEwkG7iq9XxgKThNeSzULVTmBWCjEsqzI9lhhC7U+f6R6CeHvNxCzxO91HSFR
         qH+0Rf/YawPMQmhAl8fnj4MwnzrdLMgRRL+0jgCkRyJxBvgMgGk3cVSn9E2QXXJnKWLa
         RezOIPdMx+EGnJLNzcYMAexGYd1ivG9WNB7DQiAawYU3ua453fttn2ch0raUfkfVO5fO
         ceNQ==
X-Gm-Message-State: AFqh2krw3Kc7HxL0hd4H8JKp8Hs/UmgBEBJdAuZg2Efpw+FPTznmp7To
        yW9ROnzkJycxnL1L9q+VlnsuszqTg/E/A+YhioV4nA==
X-Google-Smtp-Source: AMrXdXsGCju1a3R3dWivrZiwZSdNNnZUZdk9b6dQt4C/RUfPlrT2bw9v8ZYM72ke9bPcAu7kDlm5ESILR5rlqczLmEg=
X-Received: by 2002:a17:90a:a02:b0:21e:df53:9183 with SMTP id
 o2-20020a17090a0a0200b0021edf539183mr631620pjo.66.1671744483681; Thu, 22 Dec
 2022 13:28:03 -0800 (PST)
MIME-Version: 1.0
References: <20221222001343.489117-1-paul@paul-moore.com> <Y6SRiv+FloijdETe@google.com>
 <CAHC9VhRFmrgXMYKxXqd1KpMzDGhT6gPX-=8Z072utZO_WefYWQ@mail.gmail.com>
 <Y6SysZgKKEPL5ZE5@google.com> <CAHC9VhQ4EPzQ56ix9he4ZTo7eYpMdLBPpb+3vNsng_9vD2t=RQ@mail.gmail.com>
 <CAHC9VhSwpV80pPjzc2w9r--16LXuG7vYxE1eg5MCz2ytn2TH7g@mail.gmail.com>
In-Reply-To: <CAHC9VhSwpV80pPjzc2w9r--16LXuG7vYxE1eg5MCz2ytn2TH7g@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 22 Dec 2022 13:27:52 -0800
Message-ID: <CAKH8qBszD=PYO_nVjYUTnj7UXVcBvA95meULQGs53eyo9xfD+A@mail.gmail.com>
Subject: Re: [PATCH] bpf: restore the ebpf audit UNLOAD id field
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Burn Alting <burn.alting@iinet.net.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 22, 2022 at 12:07 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Dec 22, 2022 at 2:59 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Thu, Dec 22, 2022 at 2:40 PM <sdf@google.com> wrote:
> > > On 12/22, Paul Moore wrote:
> > > > On Thu, Dec 22, 2022 at 12:19 PM <sdf@google.com> wrote:
> > > > > On 12/21, Paul Moore wrote:
> > > > > > When changing the ebpf program put() routines to support being called
> > > > > > from within IRQ context the program ID was reset to zero prior to
> > > > > > generating the audit UNLOAD record, which obviously rendered the ID
> > > > > > field bogus (always zero).  This patch resolves this by adding a new
> > > > > > field, bpf_prog_aux::id_audit, which is set when the ebpf program is
> > > > > > allocated an ID and never reset, ensuring a valid ID field,
> > > > > > regardless of the state of the original ID field, bpf_prox_aud::id.
> > > > >
> > > > > > I also modified the bpf_audit_prog() logic used to associate the
> > > > > > AUDIT_BPF record with other associated records, e.g. @ctx != NULL.
> > > > > > Instead of keying off the operation, it now keys off the execution
> > > > > > context, e.g. '!in_irg && !irqs_disabled()', which is much more
> > > > > > appropriate and should help better connect the UNLOAD operations with
> > > > > > the associated audit state (other audit records).
> > > > >
> > > > > [..]
> > > > >
> > > > > > As an note to future bug hunters, I did briefly consider removing the
> > > > > > ID reset in bpf_prog_free_id(), as it would seem that once the
> > > > > > program is removed from the idr pool it can no longer be found by its
> > > > > > ID value, but commit ad8ad79f4f60 ("bpf: offload: free program id
> > > > > > when device disappears") seems to imply that it is beneficial to
> > > > > > reset the ID value.  Perhaps as a secondary indicator that the ebpf
> > > > > > program is unbound/orphaned.
> > > > >
> > > > > That seems like the way to go imho. Can we have some extra 'invalid_id'
> > > > > bitfield in the bpf_prog so we can set it in bpf_prog_free_id and
> > > > > check in bpf_prog_free_id (for this offloaded use-case)? Because
> > > > > having two ids and then keeping track about which one to use, depending
> > > > > on the context, seems more fragile?
> > >
> > > > I would definitely prefer to keep just a single ID value, and that was
> > > > the first approach I took when drafting this patch, but when looking
> > > > through the git log it looked like there was some desire to reset the
> > > > ID to zero on free.  Not being an expert on the ebpf kernel code I
> > > > figured I would just write the patch up this way and make a comment
> > > > about not zero'ing out the ID in the commit description so we could
> > > > have a discussion about it.
> > >
> > > Yeah, the commit you reference is resetting the id for the offloaded
> > > progs. But it also mentions that even though we reset the id,
> > > it won't leak into the userspace:
> > >
> > >    Note that orphaned offload programs will return -ENODEV on
> > >    BPF_OBJ_GET_INFO_BY_FD so user will never see ID 0.
> > >
> > > It talks about the "if (!aux->offload)" check in bpf_prog_offload_info_fill.
> > > So I'm assuming that having some extra "this id is already free" signal
> > > in the bpf_prog shouldn't be a problem here.
> >
> > FWIW, the currently-work-in-progress v2 patch adds a getter for the ID
> > with a WARN() check to flag callers who are trying to access a
> > bad/free'd bpf_prog.  Unfortunately it touches a decent chunk of code,
> > but I think it might be a nice additional check at runtime.
> >
> > +u32 bpf_prog_get_id(const struct bpf_prog *prog)
> > +{
> > +       if (WARN(!prog->valid_id, "Attempting to use invalid eBPF program"))
> > +               return 0;
> > +       return prog->aux->__id;
> > +}
>
> I should add that the getter is currently a static inline in bpf.h.

I don't see why we need to WARN on !valid_id, but I might be missing something.
There are no places currently where we report 'id == 0' to the
userspace, so we only need to take care of the offloaded case that
resets id to zero early (instead of resetting it during regular
__bpf_prog_put path).

> > > > I'm not seeing any other comments, so I'll go ahead with putting
> > > > together a v2 that sets an invalid flag/bit and I'll post that for
> > > > further discussion/review.
>
> --
> paul-moore.com
