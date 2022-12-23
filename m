Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3A265536D
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 19:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiLWSEF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Dec 2022 13:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiLWSEE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Dec 2022 13:04:04 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651D51E3C9
        for <bpf@vger.kernel.org>; Fri, 23 Dec 2022 10:04:00 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id l29so968206edj.7
        for <bpf@vger.kernel.org>; Fri, 23 Dec 2022 10:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NX1tt41u8tKT001HVadYNycV8ZIECcTltktEVY9NK3k=;
        b=L+ofFL6X4EW4GWf4OOJM5nqcPpQdNz44zWpwosSgIPpOKOEd3IkpELep6kbRTpreuS
         ySiLbFrV7tHtJ67tUi8je00O0IJ+yZZyl97TucJ5xnqFfbsBOcqyZLYlP+67VX5v5qXk
         +W9Xkr9dHIFkn3TK81+IEZGaRWgE6Dnazm0jBGpW/ESP9jTwyBUGaTgXq4A90hEFgSWA
         hnjiZiFDtIz9PwWt3gkjjclV76EEkkSkljOw0jBNsQ7WSRrklWtpFwHBrw2WaGnyUZNO
         GVMyjs0kfZw8/C+kibfSYPf79/6SH4P1zbUIBHdmcNfSTZltv8jlQ9B+YBhsXQUK4P86
         6tmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NX1tt41u8tKT001HVadYNycV8ZIECcTltktEVY9NK3k=;
        b=Ebo/cO/1nRDigqUggzJTO/rIYs/9iogWh9ryKQt7Z1WwzqfCWiFBXdJIT3A6jvANt7
         If1m3/iSApG0cewaXCGVve4b7QWUV+RJcVnLv9ZnsANWH1BxR/I24vdAiVcnDIwUy+zW
         dPgNk7vqwOviP9ovxRaU6dwd9hGqfINrqh+mMgwnXs3HuelcOATL2Oqpc2VYwDXX+XP2
         B7hjWcPRm6ksMtwEfxiAz+mk6dNtxN0XNAJkqY/UOo74KpiFc4FIqk9MPqFqzPyi8064
         OLVIwdvXB34RFuV6BQuCl8kHvLiNzdnWcw5KrJ94QSmToCMSKvpLSFM4Qd11+HxyZIxe
         aRKA==
X-Gm-Message-State: AFqh2ko9+kz9bz4xCyOCM3VSIBDx1S5TEqPFIXmCT2ZxtCFmTfPHvWK4
        tT4KfZ9BzH1Yprk5IT/alC8=
X-Google-Smtp-Source: AMrXdXscWnIduGHXvwcUdb9MidO1Ga0DjUbBqlx19ArLlmx9wRX3Xi2rcPOlugpGkagZhonFRbdybQ==
X-Received: by 2002:a05:6402:501f:b0:461:5e1b:85b5 with SMTP id p31-20020a056402501f00b004615e1b85b5mr13649882eda.2.1671818638718;
        Fri, 23 Dec 2022 10:03:58 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id eg4-20020a056402288400b004714b6cce2dsm1719244edb.20.2022.12.23.10.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 10:03:58 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 23 Dec 2022 19:03:56 +0100
To:     Paul Moore <paul@paul-moore.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, sdf@google.com,
        linux-audit@redhat.com, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Burn Alting <burn.alting@iinet.net.au>
Subject: Re: [PATCH] bpf: restore the ebpf audit UNLOAD id field
Message-ID: <Y6XtjK49rM44YI/Q@krava>
References: <20221222001343.489117-1-paul@paul-moore.com>
 <Y6SRiv+FloijdETe@google.com>
 <CAHC9VhRFmrgXMYKxXqd1KpMzDGhT6gPX-=8Z072utZO_WefYWQ@mail.gmail.com>
 <Y6TmLyDTY/a20Zq4@krava>
 <CAHC9VhSMn5Zunh7JzUmjtBqDhytC0ZCG-7xKEFiMjQyP7YMacw@mail.gmail.com>
 <CAHC9VhR2Q1SiCFoJnqr--W-cuTwpreio0knYkRcHw2MEd06rHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhR2Q1SiCFoJnqr--W-cuTwpreio0knYkRcHw2MEd06rHA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 23, 2022 at 10:58:37AM -0500, Paul Moore wrote:
> On Fri, Dec 23, 2022 at 10:37 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Dec 22, 2022 at 6:20 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > On Thu, Dec 22, 2022 at 02:03:41PM -0500, Paul Moore wrote:
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
> > > >
> > > > I would definitely prefer to keep just a single ID value, and that was
> > > > the first approach I took when drafting this patch, but when looking
> > > > through the git log it looked like there was some desire to reset the
> > > > ID to zero on free.  Not being an expert on the ebpf kernel code I
> > > > figured I would just write the patch up this way and make a comment
> > > > about not zero'ing out the ID in the commit description so we could
> > > > have a discussion about it.
> > > >
> > > > I'm not seeing any other comments, so I'll go ahead with putting
> > > > together a v2 that sets an invalid flag/bit and I'll post that for
> > > > further discussion/review.
> > >
> > > great, perf suffers the same issue:
> > >   https://lore.kernel.org/bpf/Y3SRWVoycV290S16@krava/
> > >
> > > any chance you could include it as well? I can send a patch
> > > later if needed
> >
> > Hi Jiri,
> >
> > I'm pretty sure the current approach recommended by Stanislav, to
> > never reset/zero the ID and instead mark it as invalid via a flag in
> > the bpf_prog struct, should resolve the perf problem as well.

ok, I misunderstood

> 
> I probably should elaborate on this a bit more, in the case of
> perf_event_bpf_event() the getter which checks the valid_id flag isn't
> used, rather a direct access of bpf_prog_aux::__id is done so that the
> ID can be retrieved even after it is free'd/marked-invalid.  Here is
> the relevant code snippet for the patch:
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index aefc1e08e015..c24e897d27f1 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9001,7 +9001,11 @@ void perf_event_bpf_event(struct bpf_prog *prog,
>                        },
>                        .type = type,
>                        .flags = flags,
> -                       .id = prog->aux->id,
> +                       /*
> +                        * don't use bpf_prog_get_id() as the id may be marked
> +                        * invalid on PERF_BPF_EVENT_PROG_UNLOAD events
> +                        */
> +                       .id = prog->aux->__id,

looks good

>                },
>        };
> 
> > My time
> > is a little short at the moment due to the holidays, but perhaps with
> > a little luck I'll get a new revision of the patch posted soon
> > (today?) and you can take a look and give it a test.  Are you
> > subscribed to the linux-audit and/or bpf mailing lists?  If not I can
> > CC you directly on the next revision.

bpf list is fine

thanks,
jirka
