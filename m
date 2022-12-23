Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD2C655281
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 16:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiLWP6u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Dec 2022 10:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiLWP6t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Dec 2022 10:58:49 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224E5379E1
        for <bpf@vger.kernel.org>; Fri, 23 Dec 2022 07:58:49 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id m4so5319808pls.4
        for <bpf@vger.kernel.org>; Fri, 23 Dec 2022 07:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wPVkp+Z29MATUSLmhohqjB/7ebrMIpotfQI0xJpIQGE=;
        b=BynSvPBnn3QOGuS1gH4tb2Z6D4bAB06JojVur1Av/UdE/4dxw4d18K0SXrg3pOvk9f
         R02C3LDxH4faQR8wIZWbAGBgzoCc+WmitiyjwYyIDQ8tjwCkT7OfE/MraIuPT9Q+L089
         Fdx30JaQv3lxDlNSq39FLgCxwnH5lDRqAAsjVE9W1DRgf8icNsaSqtXOBT0Ri2FoVsYC
         Qrd/1xE4m2yIQRmiOaEaaOx1tjOEXRtUzeTbHKZbYeaXJ8AEXXJ0GqsTghC2sRqNZzDk
         O/Zp/5q4/oaVkRkroFRoE986nLmcwLv87TemBXd0NfhIo147sC6C4Ds5RJHlKJsEhEv5
         lWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wPVkp+Z29MATUSLmhohqjB/7ebrMIpotfQI0xJpIQGE=;
        b=1QtCZTipZ4ElXtA9E3Ek1CiNt2EFFsURY8YJLp/xnBYkzbYfQxU25xC8Pt3CHn+7P1
         Dp6HRN5Ji0v9YMlB47g5kWEngG85Zai+xc4vu/GusPlT5/x0R90ftcntYc6BqpfW32Z+
         ffHnvZ0rGT6N3JIGX+PKhivmPKAbPkxeSU+VSYavvpQaT5RESwQ/GzGLpTnlpPdp5SAS
         N4R4uYYamPEIaGGq+FMEzqm03YpHgKOb7FiNATGOg/2ulUHXeMLOfT8thY9AoEmDkpnq
         2pGxx4ji20wnMM0fvY+MeR8/6GhaJlGJ/KnFhFahGKfcnmHRnqg4RLL6pmJ3AebW0M97
         mVow==
X-Gm-Message-State: AFqh2kriMmBj1C2eeCn4EZO9d3u6ReWIv4/+iIJleovdK9HjYZL6TLOk
        lCehJV5TRTEQ8CQjThZIN/We63LjNeNqGzhZnSbo
X-Google-Smtp-Source: AMrXdXsnXYXRO5lmDd8aNy4SOyM1nPMpAYhuD5AVg6UjLKvhVVOkyLij4x6GX4RUubsKM8oDpdArIt6+8eXag0+eSrY=
X-Received: by 2002:a17:902:cec8:b0:192:6675:8636 with SMTP id
 d8-20020a170902cec800b0019266758636mr21928plg.15.1671811128534; Fri, 23 Dec
 2022 07:58:48 -0800 (PST)
MIME-Version: 1.0
References: <20221222001343.489117-1-paul@paul-moore.com> <Y6SRiv+FloijdETe@google.com>
 <CAHC9VhRFmrgXMYKxXqd1KpMzDGhT6gPX-=8Z072utZO_WefYWQ@mail.gmail.com>
 <Y6TmLyDTY/a20Zq4@krava> <CAHC9VhSMn5Zunh7JzUmjtBqDhytC0ZCG-7xKEFiMjQyP7YMacw@mail.gmail.com>
In-Reply-To: <CAHC9VhSMn5Zunh7JzUmjtBqDhytC0ZCG-7xKEFiMjQyP7YMacw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 23 Dec 2022 10:58:37 -0500
Message-ID: <CAHC9VhR2Q1SiCFoJnqr--W-cuTwpreio0knYkRcHw2MEd06rHA@mail.gmail.com>
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

On Fri, Dec 23, 2022 at 10:37 AM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Dec 22, 2022 at 6:20 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> > On Thu, Dec 22, 2022 at 02:03:41PM -0500, Paul Moore wrote:
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
> > >
> > > I would definitely prefer to keep just a single ID value, and that was
> > > the first approach I took when drafting this patch, but when looking
> > > through the git log it looked like there was some desire to reset the
> > > ID to zero on free.  Not being an expert on the ebpf kernel code I
> > > figured I would just write the patch up this way and make a comment
> > > about not zero'ing out the ID in the commit description so we could
> > > have a discussion about it.
> > >
> > > I'm not seeing any other comments, so I'll go ahead with putting
> > > together a v2 that sets an invalid flag/bit and I'll post that for
> > > further discussion/review.
> >
> > great, perf suffers the same issue:
> >   https://lore.kernel.org/bpf/Y3SRWVoycV290S16@krava/
> >
> > any chance you could include it as well? I can send a patch
> > later if needed
>
> Hi Jiri,
>
> I'm pretty sure the current approach recommended by Stanislav, to
> never reset/zero the ID and instead mark it as invalid via a flag in
> the bpf_prog struct, should resolve the perf problem as well.

I probably should elaborate on this a bit more, in the case of
perf_event_bpf_event() the getter which checks the valid_id flag isn't
used, rather a direct access of bpf_prog_aux::__id is done so that the
ID can be retrieved even after it is free'd/marked-invalid.  Here is
the relevant code snippet for the patch:

diff --git a/kernel/events/core.c b/kernel/events/core.c
index aefc1e08e015..c24e897d27f1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9001,7 +9001,11 @@ void perf_event_bpf_event(struct bpf_prog *prog,
                       },
                       .type = type,
                       .flags = flags,
-                       .id = prog->aux->id,
+                       /*
+                        * don't use bpf_prog_get_id() as the id may be marked
+                        * invalid on PERF_BPF_EVENT_PROG_UNLOAD events
+                        */
+                       .id = prog->aux->__id,
               },
       };

> My time
> is a little short at the moment due to the holidays, but perhaps with
> a little luck I'll get a new revision of the patch posted soon
> (today?) and you can take a look and give it a test.  Are you
> subscribed to the linux-audit and/or bpf mailing lists?  If not I can
> CC you directly on the next revision.

-- 
paul-moore.com
