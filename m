Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0E9655227
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 16:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiLWPiH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Dec 2022 10:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiLWPiG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Dec 2022 10:38:06 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC161379C7
        for <bpf@vger.kernel.org>; Fri, 23 Dec 2022 07:38:04 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id v3so3531080pgh.4
        for <bpf@vger.kernel.org>; Fri, 23 Dec 2022 07:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cwr3WJAl1hrE0J615eHKg41VfEAiCJKmxmlGfLHaFD4=;
        b=dveJyVrYNlqjFf+AsDq46Wu6zEuCYagj9fvxZTKcMhZr1eD+qhb62nIzIw9zY/s3Fv
         Eu1K6cp2cGlkBLxNMyx6TsWqEZogHmUJ7bd1Pmnn4UCu4GnjFlefoOw/Go3u/fzh/NKp
         jTBE9a+EGnI8/jYHPtuC+qrCfY/R/SRDK08JqiaiJc0QU6aOjXhbB3JI7+P2YJCFLTso
         nDhUa6Yl0hTdWn4AD5jBxHqx1sIvaPckdu8jm1cLM3VTEWQoBuD+V4IU/VBbWjK5MiKh
         BavkaQqNjs4Ychphr790R/bKc+Kmsth2Pg8NZ/y1KYKkIQcUF27uqiTSoflgtEQOQTSG
         BP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwr3WJAl1hrE0J615eHKg41VfEAiCJKmxmlGfLHaFD4=;
        b=HXNfgPr2235hPF3AYqxVkHIeRNzBZV3imoAMMJNjJ2ISmSdfrg76y0TM3ELpQ7JosW
         wwegrR4QgGPVbKRA0irR/O5P4LbDDTpHll+frTO21PIzRkv3bfzteXvItdqNZd7bVTxq
         3o2TpQY6ONTkoIlKigruvs+yCVDS1RVA121DmNinXgUxOZecOb/ifV9VlB2WIqCT8aPd
         r4uj61Yr681C8Mx/X09D1/wlkmcnqa2kPAyy5k+B3Z4AL2Lhmh58mxc6CQr1ILmstXwc
         66FgYn03sPYinkrW64pAuzIiw9hQgZNiLM4+DV9jamwQZ6j3UZ4MIfEJFs5Br0rWOUG1
         9+wQ==
X-Gm-Message-State: AFqh2koTZnhFp7JIlViXTjN1GhJ8JyUBQwKrVBEEJFB90xPDZGz6JIyr
        M4o7/+6MjkMYtPISeKNSiUHT335XqqyDbCQVYmSe
X-Google-Smtp-Source: AMrXdXvsbCISQ6sfWB9Cm3C5Nyjfd+JWDETRw9Wwgd5yx0f+RYwGljMFbOaeOCGMv3dlFzmwtgO9VsubX4EOyokrB54=
X-Received: by 2002:a05:6a00:1f1a:b0:576:af2d:4c5f with SMTP id
 be26-20020a056a001f1a00b00576af2d4c5fmr632594pfb.23.1671809884330; Fri, 23
 Dec 2022 07:38:04 -0800 (PST)
MIME-Version: 1.0
References: <20221222001343.489117-1-paul@paul-moore.com> <Y6SRiv+FloijdETe@google.com>
 <CAHC9VhRFmrgXMYKxXqd1KpMzDGhT6gPX-=8Z072utZO_WefYWQ@mail.gmail.com> <Y6TmLyDTY/a20Zq4@krava>
In-Reply-To: <Y6TmLyDTY/a20Zq4@krava>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 23 Dec 2022 10:37:53 -0500
Message-ID: <CAHC9VhSMn5Zunh7JzUmjtBqDhytC0ZCG-7xKEFiMjQyP7YMacw@mail.gmail.com>
Subject: Re: [PATCH] bpf: restore the ebpf audit UNLOAD id field
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     sdf@google.com, linux-audit@redhat.com, bpf@vger.kernel.org,
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

On Thu, Dec 22, 2022 at 6:20 PM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Dec 22, 2022 at 02:03:41PM -0500, Paul Moore wrote:
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
> >
> > I would definitely prefer to keep just a single ID value, and that was
> > the first approach I took when drafting this patch, but when looking
> > through the git log it looked like there was some desire to reset the
> > ID to zero on free.  Not being an expert on the ebpf kernel code I
> > figured I would just write the patch up this way and make a comment
> > about not zero'ing out the ID in the commit description so we could
> > have a discussion about it.
> >
> > I'm not seeing any other comments, so I'll go ahead with putting
> > together a v2 that sets an invalid flag/bit and I'll post that for
> > further discussion/review.
>
> great, perf suffers the same issue:
>   https://lore.kernel.org/bpf/Y3SRWVoycV290S16@krava/
>
> any chance you could include it as well? I can send a patch
> later if needed

Hi Jiri,

I'm pretty sure the current approach recommended by Stanislav, to
never reset/zero the ID and instead mark it as invalid via a flag in
the bpf_prog struct, should resolve the perf problem as well.  My time
is a little short at the moment due to the holidays, but perhaps with
a little luck I'll get a new revision of the patch posted soon
(today?) and you can take a look and give it a test.  Are you
subscribed to the linux-audit and/or bpf mailing lists?  If not I can
CC you directly on the next revision.

-- 
paul-moore.com
