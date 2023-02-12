Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF70693A5F
	for <lists+bpf@lfdr.de>; Sun, 12 Feb 2023 23:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjBLWAj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Feb 2023 17:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjBLWAi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Feb 2023 17:00:38 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D0BDBE4
        for <bpf@vger.kernel.org>; Sun, 12 Feb 2023 14:00:36 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id m2so11688784plg.4
        for <bpf@vger.kernel.org>; Sun, 12 Feb 2023 14:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=66Qj76jDtLqMKQ1ONBOOUWaAju4+iVhgaW6iZJJpGeI=;
        b=GI1qAntTuk3fnNN77umUgFisba+NJvlyh/e0bPmzAv/DnZliruV0m8iu6UD23shTCs
         0398ZN2XKGl4V03203RX/E2i0nX0l1iPYAopHL2aJgHxLjOdqRZkfwcfuflM4tWl5cpI
         Weprd4AAdiy4TFt459usO3mn4YpT7+U/MUlnDrj2/7EWuwLIqoq68+GKhMY/m19gEhXz
         peSYI5XeObqH0n/uWb0oYttxEUD/hHqrKGYPSIPv6EiGp81JSWNUX1us0lxH8wmPbi9S
         FpL/4cu+ghau+TsUDBtXmO1ZIOOP4qpOkn3UnOaZ+fXQdR1CFv0LDKCGNyzKqpv1KSTU
         PD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66Qj76jDtLqMKQ1ONBOOUWaAju4+iVhgaW6iZJJpGeI=;
        b=0aSKxhJrtzAmFK0zkynqpExgWoeUPV6LM6rDomsL8dMxUmLISPyAtE1tXfua4cZfwl
         hLSlns4/C0cdbvyMuBx/vvrFX+xG1m66gbxjL5YT2WXgXlfn98DAls7ufh70Qlwt9+UY
         +8ovCTqa994LJEosd8N3ie+cDvViBFZmxCzvOzY8D5ho0C7LtF92jgJaBMwtQUMB3LML
         F/EEKNLsrG1WGiqk4rF+WlJDroKAfuB6delgJTtsim6K0hzBPL1cdKSzBirTz8msjDLC
         0DQi7f+ObMaTeq+7WHeW/Fi2hvoJz48cTRTmtUfaHJ9V28ggPdDH1VWHz5sqyOqTFGY7
         ojtQ==
X-Gm-Message-State: AO0yUKWI5HuUSXQLA2Y/EHxgI1UaUP5fGdAmfgKXZ1Dl2gxDQanaSusW
        qAlCyPijukfWJAcQ2GGo2TaRqTIxdl5sGJpDaFOT
X-Google-Smtp-Source: AK7set/hNH8kF86n5/5FzMu5RNAjME7KLuHBESyzfUOoDICk6MkHS+QwhaDATiqEVX08S8kKI+0Vo/dntv+YeTsHAu4=
X-Received: by 2002:a17:90a:4f85:b0:22c:41c7:c7ed with SMTP id
 q5-20020a17090a4f8500b0022c41c7c7edmr4034565pjh.61.1676239236187; Sun, 12 Feb
 2023 14:00:36 -0800 (PST)
MIME-Version: 1.0
References: <20230119231033.1307221-1-kpsingh@kernel.org> <CAHC9VhRpsXME9Wht_RuSACuU97k359dihye4hW15nWwSQpxtng@mail.gmail.com>
 <63e525a8.170a0220.e8217.2fdb@mx.google.com> <CAHC9VhTCiCNjfQBZOq2DM7QteeiE1eRBxW77eVguj4=y7kS+eQ@mail.gmail.com>
 <98799a20-1025-3677-d215-69b13ac73ee5@schaufler-ca.com>
In-Reply-To: <98799a20-1025-3677-d215-69b13ac73ee5@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 12 Feb 2023 17:00:25 -0500
Message-ID: <CAHC9VhTo=VDuFFfX7o__CRwbHTT-OTDBQ090-ZwbTRQYdO-_Gg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] Reduce overhead of LSMs with static calls
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Kees Cook <keescook@chromium.org>, KP Singh <kpsingh@kernel.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, song@kernel.org, revest@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 10, 2023 at 9:32 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 2/10/2023 12:03 PM, Paul Moore wrote:
> > On Thu, Feb 9, 2023 at 11:56 AM Kees Cook <keescook@chromium.org> wrote:
> >> On Fri, Jan 27, 2023 at 03:16:38PM -0500, Paul Moore wrote:
> >>> On Thu, Jan 19, 2023 at 6:10 PM KP Singh <kpsingh@kernel.org> wrote:
> >>>> # Background
> >>>>
> >>>> LSM hooks (callbacks) are currently invoked as indirect function calls. These
> >>>> callbacks are registered into a linked list at boot time as the order of the
> >>>> LSMs can be configured on the kernel command line with the "lsm=" command line
> >>>> parameter.
> >>> Thanks for sending this KP.  I had hoped to make a proper pass through
> >>> this patchset this week but I ended up getting stuck trying to wrap my
> >>> head around some network segmentation offload issues and didn't quite
> >>> make it here.  Rest assured it is still in my review queue.
> >>>
> >>> However, I did manage to take a quick look at the patches and one of
> >>> the first things that jumped out at me is it *looks* like this
> >>> patchset is attempting two things: fix a problem where one LSM could
> >>> trample another (especially problematic with the BPF LSM due to its
> >>> nature), and reduce the overhead of making LSM calls.  I realize that
> >>> in this patchset the fix and the optimization are heavily
> >>> intermingled, but I wonder what it would take to develop a standalone
> >>> fix using the existing indirect call approach?  I'm guessing that is
> >>> going to potentially be a pretty significant patch, but if we could
> >>> add a little standardization to the LSM hooks without adding too much
> >>> in the way of code complexity or execution overhead I think that might
> >>> be a win independent of any changes to how we call the hooks.
> >>>
> >>> Of course this could be crazy too, but I'm the guy who has to ask
> >>> these questions :)
> >> Hm, I am expecting this patch series to _not_ change any semantics of
> >> the LSM "stack". I would agree: nothing should change in this series, as
> >> it should be strictly a mechanical change from "iterate a list of
> >> indirect calls" to "make a series of direct calls". Perhaps I missed
> >> a logical change?
> > I might be missing something too, but I'm thinking of patch 4/4 in
> > this series that starts with this sentence:
> >
> >  "BPF LSM hooks have side-effects (even when a default value is
> >   returned), as some hooks end up behaving differently due to
> >   the very presence of the hook."
>
> My understanding of the current "agreement" is that we keep BPF
> hooks at the end for this very reason.

It would be nice to not have these conventions.  I get that it's the
only knob we have at the moment to tweak, but I would hope that we
could do better in the future.

> > Ignoring the static call changes for a moment, I'm curious what it
> > would look like to have a better mechanism for handling things like
> > this.  What would it look like if we expanded the individual LSM error
> > reporting back to the LSM layer to have a bit more information, e.g.
> > "this LSM erred, but it is safe to continue evaluating other LSMs" and
> > "this LSM erred, and it was too severe to continue evaluating other
> > LSMs"?  Similarly, would we want to expand the hook registration to
> > have more info, e.g. "run this hook even when other LSMs have failed"
> > and "if other LSMs have failed, do not run this hook"?
>
> I really don't want another LSM to have sway over Smack enforcement.

I think we can all agree that the one LSM should not have the ability
to affect the operation of another, especially when it would cause the
violation of a different LSM's security policy.

> I would hate to see, for example, an LSM decide that because it has
> initialized an inode no other LSM should be allowed to, even in an
> error situation. There are really only two options Call all the hooks
> every time and either succeed on all or report the most important
> error. Or, "bail on fail", and acknowledge that following hooks may
> not be called. Really, does "I failed, but it's not that important"
> make sense as a return value?

Of the two things I tossed out, richer return values and richer hook
registration, perhaps it's really only the latter, richer hook
registration that is important here.  It would allow a LSM to indicate
to the LSM hook layer how the individual hook implementation should be
called: always, or only if previously called implementations have not
failed.  I believe that should eliminate any worry of a BPF LSM, or
any LSM for that matter, from impacting the security policy of
another.  However, I will admit that I haven't spent the necessary
amount of time chasing down all the hooks to verify if that is 100%
correct.

> > I realize that loading a BPF LSM is a privileged operation so we've
> > largely mitigated the risk there, but with stacking on it's way to
> > being more full featured, and IMA slowly working its way to proper LSM
> > status, it seems to me like having a richer, and proper way to handle
> > individual LSM failures would be a good thing.  I feel like patch 4/4
> > definitely hints at this, but I could be mistaken.
>
> We have bigger issues with BPF. There's nothing to prevent BPF from
> implementing a secid_to_secctx() hook and making a system with SELinux
> go cattywampus. BPF is stacked as if it isn't a "major" LSM, while
> allowing it to do "major" LSM things. One reason we need full stacking
> is to address this.

That's a different issue, and one of the reasons why I suggested
taking an all-or-nothing approach to stacking many years ago, but ...
well, you know how that worked out.  I promise to not keep saying "I
told you so" if you promise to not keep bringing up LSM stacking as
the answer to all that ails you ;)

-- 
paul-moore.com
