Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AB3692796
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 21:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjBJUDn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 15:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbjBJUDm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 15:03:42 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB927D3F6
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 12:03:40 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id n2so4208211pfo.3
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 12:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c94oebdQAYOnWa5OBenvbbTJl3HSCIzlCdwEo0rrVKw=;
        b=Zyg2AmPPYBtXlDQvmAKLDQiv0KkS8B/AUP6rAoDns1XWizHDTHVPtASr6ynZ5TfP9+
         TEq9Y8aF6TovKgR+yZoTnlldOnVLa3StdjhOSQK//wWPSF7BRbWDDVIpNtEXN96tCOaA
         Lfmqg71s1eP9oTn8EKVt1SdbC1yGeYIvgKsV4MfilMle6BkDXthUNKIxf5HTIwocjNC1
         /j34iAeGtUxVlG0HeDL1GUm0doCkQ/qqXMY0+Zhw5gen+EdPjuARuD0JPyeQ0NF7MnZ+
         /r3CbjlPuYqV179Rvpe1fYUI+mFMcEDiD8VEhZ8/+zeRTIGUzoy06eUpL536TE5Jy0mk
         Pj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c94oebdQAYOnWa5OBenvbbTJl3HSCIzlCdwEo0rrVKw=;
        b=YGNwSoa3N5Mg71jbqEzya+tzGknRZniJyzPoJvqOaI7eIuGMFSFcY98FaxZnIuw+bg
         snR6mDZc0nLuiMbtuISBkVSAZkJqkjrDdsXymcOL0CeksfI32S0Nj/aHu7a550tfGQTK
         MOFfo24uVkwkpYBP2+aZn0CIET5nrUws3kTluDrnLsW1/gLMBoeJgHIK+yaxh+SxTUaW
         /2lloXysGs+/jI6uvkAhPPZYoH3NnkHNg4i73L9IwvnlVrdLGnH3ZIymSkLNrG3g8up6
         hzHeE1MW4+nQMjhqay5Hu5X2tInHhaO479TnRvtKprGijihbgZ2X/0EFoJzziB6Dfw5j
         yqFw==
X-Gm-Message-State: AO0yUKWy54uLGeudgRgqeHUQ7i0L3nF6ySmJL1lAobWWaq87Am1b+8oM
        6UlPDKZ7OZGHnRj5RgXsr2AX0ZSp6OSTIufTt7YD
X-Google-Smtp-Source: AK7set+h0C24/7+kDGsz6RtMYZdf+WcUCXAre7w6Ea1rII5G24VEGhCPdhwkzif9KZRxq00tMHYHXOI9ycnSkWzjsg0=
X-Received: by 2002:aa7:9af1:0:b0:592:7c9a:1236 with SMTP id
 y17-20020aa79af1000000b005927c9a1236mr3299055pfp.26.1676059419391; Fri, 10
 Feb 2023 12:03:39 -0800 (PST)
MIME-Version: 1.0
References: <20230119231033.1307221-1-kpsingh@kernel.org> <CAHC9VhRpsXME9Wht_RuSACuU97k359dihye4hW15nWwSQpxtng@mail.gmail.com>
 <63e525a8.170a0220.e8217.2fdb@mx.google.com>
In-Reply-To: <63e525a8.170a0220.e8217.2fdb@mx.google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Feb 2023 15:03:28 -0500
Message-ID: <CAHC9VhTCiCNjfQBZOq2DM7QteeiE1eRBxW77eVguj4=y7kS+eQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] Reduce overhead of LSMs with static calls
To:     Kees Cook <keescook@chromium.org>
Cc:     KP Singh <kpsingh@kernel.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, casey@schaufler-ca.com, song@kernel.org,
        revest@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 9, 2023 at 11:56 AM Kees Cook <keescook@chromium.org> wrote:
> On Fri, Jan 27, 2023 at 03:16:38PM -0500, Paul Moore wrote:
> > On Thu, Jan 19, 2023 at 6:10 PM KP Singh <kpsingh@kernel.org> wrote:
> > >
> > > # Background
> > >
> > > LSM hooks (callbacks) are currently invoked as indirect function calls. These
> > > callbacks are registered into a linked list at boot time as the order of the
> > > LSMs can be configured on the kernel command line with the "lsm=" command line
> > > parameter.
> >
> > Thanks for sending this KP.  I had hoped to make a proper pass through
> > this patchset this week but I ended up getting stuck trying to wrap my
> > head around some network segmentation offload issues and didn't quite
> > make it here.  Rest assured it is still in my review queue.
> >
> > However, I did manage to take a quick look at the patches and one of
> > the first things that jumped out at me is it *looks* like this
> > patchset is attempting two things: fix a problem where one LSM could
> > trample another (especially problematic with the BPF LSM due to its
> > nature), and reduce the overhead of making LSM calls.  I realize that
> > in this patchset the fix and the optimization are heavily
> > intermingled, but I wonder what it would take to develop a standalone
> > fix using the existing indirect call approach?  I'm guessing that is
> > going to potentially be a pretty significant patch, but if we could
> > add a little standardization to the LSM hooks without adding too much
> > in the way of code complexity or execution overhead I think that might
> > be a win independent of any changes to how we call the hooks.
> >
> > Of course this could be crazy too, but I'm the guy who has to ask
> > these questions :)
>
> Hm, I am expecting this patch series to _not_ change any semantics of
> the LSM "stack". I would agree: nothing should change in this series, as
> it should be strictly a mechanical change from "iterate a list of
> indirect calls" to "make a series of direct calls". Perhaps I missed
> a logical change?

I might be missing something too, but I'm thinking of patch 4/4 in
this series that starts with this sentence:

 "BPF LSM hooks have side-effects (even when a default value is
  returned), as some hooks end up behaving differently due to
  the very presence of the hook."

Ignoring the static call changes for a moment, I'm curious what it
would look like to have a better mechanism for handling things like
this.  What would it look like if we expanded the individual LSM error
reporting back to the LSM layer to have a bit more information, e.g.
"this LSM erred, but it is safe to continue evaluating other LSMs" and
"this LSM erred, and it was too severe to continue evaluating other
LSMs"?  Similarly, would we want to expand the hook registration to
have more info, e.g. "run this hook even when other LSMs have failed"
and "if other LSMs have failed, do not run this hook"?

I realize that loading a BPF LSM is a privileged operation so we've
largely mitigated the risk there, but with stacking on it's way to
being more full featured, and IMA slowly working its way to proper LSM
status, it seems to me like having a richer, and proper way to handle
individual LSM failures would be a good thing.  I feel like patch 4/4
definitely hints at this, but I could be mistaken.

--
paul-moore.com
