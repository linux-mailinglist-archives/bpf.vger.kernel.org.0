Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8559A689C54
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 15:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbjBCO45 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 09:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbjBCO4q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 09:56:46 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE41AA0030;
        Fri,  3 Feb 2023 06:56:37 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id h24so5645243qta.12;
        Fri, 03 Feb 2023 06:56:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylXOWkGcAO7RMXbscWu9tfQhDOTwvWqF/Ni/iG4xFzM=;
        b=atv9pF+Sxc49qSHerXZ6ac8gQEoUPbXbgUPHmOLkEeWUHboxm+r+4hwekjZAeTQ1LD
         i6+uLOtQW66IIvVS8s7QlX0Stv2mwoPlvqpeCNYZz3YObAtEjZrAw3uKqrHIhC5KZuZe
         esegXSpCx2viaHA428WlabRQPaqzN0SvH0TDcIN2YFdaYN2L2jVj9loT9r85Run7Yjm7
         TdSnezR536K5oynuRiJhiE2tOZ4NrmB77IjF5bvdF0IZu81yRkFZu+k8vsEe/6Bf2DLC
         byQqzRmZ+03N12oxuOlplWQXz6zU6V5AB5SR+I9IDq6wPg0N4XtL36e3zbvlxTK+NVBZ
         Kg4A==
X-Gm-Message-State: AO0yUKVeEMR2QD5fNwCRlUDljE31PbUAOU4MmBkAm10kf0IFu+xVO3lU
        6iSJI9lpXcgIYy1ARao75qs=
X-Google-Smtp-Source: AK7set8+0Wevv5R9DB/9UEXJTMhZnNTu39v5HyBFWdm+RojDtbne94MHLQJdrr55cBX/G9xDEdfBnw==
X-Received: by 2002:ac8:7fd5:0:b0:3b9:b817:e9ae with SMTP id b21-20020ac87fd5000000b003b9b817e9aemr19346773qtk.5.1675436196579;
        Fri, 03 Feb 2023 06:56:36 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:dd5a])
        by smtp.gmail.com with ESMTPSA id p17-20020a05622a00d100b003b64f1b1f40sm1716576qtw.40.2023.02.03.06.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 06:56:36 -0800 (PST)
Date:   Fri, 3 Feb 2023 08:56:33 -0600
From:   David Vernet <void@manifault.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        brouer@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf/docs: Document kfunc lifecycle /
 stability expectations
Message-ID: <Y90goYWyA6d7DWTK@maniforge>
References: <20230202223557.744110-1-void@manifault.com>
 <20230202223557.744110-2-void@manifault.com>
 <87cz6qew8l.fsf@toke.dk>
 <Y90eeaT1W2cPYzMB@maniforge>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y90eeaT1W2cPYzMB@maniforge>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 03, 2023 at 08:47:21AM -0600, David Vernet wrote:
> On Fri, Feb 03, 2023 at 02:04:10PM +0100, Toke Høiland-Jørgensen wrote:
> > David Vernet <void@manifault.com> writes:
> > 
> > > BPF kernel <-> kernel API stability has been discussed at length over
> > > the last several weeks and months. Now that we've largely aligned over
> > > kfuncs being the way forward, and BPF helpers being considered frozen,
> > > it's time to document the expectations for kfunc lifecycles and
> > > stability so that everyone (BPF users, kfunc developers, and
> > > maintainers) are all aligned, and have a crystal-clear understanding of
> > > the expectations surrounding kfuncs.
> > >
> > > To do that, this patch adds that documentation to the main kfuncs
> > > documentation page via a new 'kfunc lifecycle expectations' section. The
> > > patch describes how decisions are made in the kernel regarding whether
> > > to include, keep, deprecate, or change / remove a kfunc. As described
> > > very overtly in the patch itself, but likely worth highlighting here:
> > >
> > > "kfunc stability" does not mean, nor ever will mean, "BPF APIs may block
> > > development elsewhere in the kernel".
> > >
> > > Rather, the intention and expectation is for kfuncs to be treated like
> > > EXPORT_SYMBOL_GPL symbols in the kernel. The goal is for kfuncs to be a
> > > safe and valuable option for maintainers and kfunc developers to extend
> > > the kernel, without tying anyone's hands, or imposing any kind of
> > > restrictions on maintainers in the same way that UAPI changes do.
> > >
> > > In addition to the 'kfunc lifecycle expectations' section, this patch
> > > also adds documentation for a new KF_DEPRECATED kfunc flag which kfunc
> > > authors or maintainers can choose to add to kfuncs if and when they
> > > decide to deprecate them. Note that as described in the patch itself, a
> > > kfunc need not be deprecated before being changed or removed -- this
> > > flag is simply provided as an available deprecation mechanism for those
> > > that want to provide a deprecation story / timeline to their users.
> > > When necessary, kfuncs may be changed or removed to accommodate changes
> > > elsewhere in the kernel without any deprecation at all.
> > >
> > > Signed-off-by: David Vernet <void@manifault.com>
> > 
> > Some comments below, but otherwise please add my:
> > 
> > Co-developed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> > 
> > should we Cc the next version to linux-api@vger as well just to get a
> > bit more visibility in case others have comments?
> 
> Yes, good idea, will do.
> 
> > 
> > > ---
> > >  Documentation/bpf/kfuncs.rst | 138 +++++++++++++++++++++++++++++++++--
> > >  1 file changed, 133 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> > > index 0bd07b39c2a4..4135f3111b67 100644
> > > --- a/Documentation/bpf/kfuncs.rst
> > > +++ b/Documentation/bpf/kfuncs.rst
> > > @@ -13,7 +13,7 @@ BPF Kernel Functions or more commonly known as kfuncs are functions in the Linux
> > >  kernel which are exposed for use by BPF programs. Unlike normal BPF helpers,
> > >  kfuncs do not have a stable interface and can change from one kernel release to
> > >  another. Hence, BPF programs need to be updated in response to changes in the
> > > -kernel.
> > > +kernel. See :ref:`BPF_kfunc_lifecycle_expectations` for more information.
> > >  
> > >  2. Defining a kfunc
> > >  ===================
> > > @@ -238,6 +238,32 @@ single argument which must be a trusted argument or a MEM_RCU pointer.
> > >  The argument may have reference count of 0 and the kfunc must take this
> > >  into consideration.
> > >  
> > > +.. _KF_deprecated_flag:
> > > +
> > > +2.4.9 KF_DEPRECATED flag
> > > +------------------------
> > > +
> > > +The KF_DEPRECATED flag is used for kfuncs which are expected to be changed or
> > > +removed in a subsequent kernel release. Deprecated kfuncs may be removed at any
> > > +time, though if possible (and when applicable), developers are encouraged to
> > > +provide users with a deprecation window to ease the burden of migrating off of
> > > +the kfunc.
> > 
> > 
> > 
> > I think the "may be removed at any time" is a bit odd here. If someone
> > wants to just remove a kfunc, why bother with the deprecation flag at
> > all? Besides, that whole "deprecation is optional" bit is explained
> 
> I definitely agree that the phrasing could be improved, but my intention
> with that phrase was actually to answer the exact nuanced question you
> posed. I think we need to clarify that KF_DEPRECATED is an optional tool
> that developers can use to provide a softer deprecation story to their
> users, rather than a flag that exists as part of a larger, strict
> deprecation policy. Otherwise, I think it would be unclear to someone
> reading this when and why they would need to use the flag. I liked your
> suggestion below, and proposed a bit of extra text to try and capture
> this point. Lmk what you think.
> 
> > below, in this section we're just explaining the flag. So I'd just drop
> > this bit and combine the first two paragraphs as:
> > 
> > "The KF_DEPRECATED flag is used for kfuncs which are scheduled to be
> > changed or removed in a subsequent kernel release. A kfunc that is
> > marked with KF_DEPRECATED should also have any relevant information
> > captured in its kernel doc. Such information typically includes the
> > kfunc's expected remaining lifespan, a recommendation for new
> > functionality that can replace it if any is available, and possibly a
> > rationale for why it is being removed."
> 
> I like this -- are you OK with adding this in a small subsequent
> paragraph to address the point I made above?
> 
> Note that KF_DEPRECATED is simply a tool that developers can choose to
> use to ease their users' burden of migrating off of a kfunc. While
> developers are encouraged to use KF_DEPRECATED to provide a
> transitionary deprecation period to users of their kfunc, doing so is
> not strictly required, and the flag does not exist as part of any larger
> kfunc deprecation policy.

Nevermind, after reading this a few more times, I think what you
proposed above is sufficient. Will not be including this extra paragraph
in v3.

[...]
