Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4F26831C2
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 16:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjAaPoy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 10:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjAaPox (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 10:44:53 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2581538038;
        Tue, 31 Jan 2023 07:44:52 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id c2so375558qtw.5;
        Tue, 31 Jan 2023 07:44:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C783Nh9J6CgxhYis78NdX7Hgktg+0aGPcVJ8i8fBtOY=;
        b=u31MZO3J7nkwKjnL2EE0ljDpRptiVQ0DZ0KS2lfaXAx5olQXd5+JYIa3W1CmN1Gw64
         R36Cf08MF/MmwsejIdEmhAxxSGXvGbocUK+06HTCXkAoZ/Ag9NC3E/M6X4kJlv+7eW+o
         U+rPXi29QjHhdgsfS1L0C0UCHVvvG4znDGhH3sGcb6qT0F0rSIP0ToRSZlhTsg0gj8XU
         Vz5sM9BnoBBdp8vMg6f7i6SMWiO1SoMkKKO4DJRLLSE1b7vM3SJFb5YIDRnw0V1ufVeu
         +XYFlg2pAt72qbMPqnS5M9RH4CGV04ppoj+U5RhT3FcNnQQnDXzPvJv/eGCNQGLMUUrE
         3G1w==
X-Gm-Message-State: AO0yUKUK2J2/eDBE5IHVkXfOolMTScQboa8UKzyOlSENnrz9Dqk4I/Ru
        bHj5GFN/pcp1IP3f2VeH1uc=
X-Google-Smtp-Source: AK7set/hVDIuevnnukfaPDhDgIEOH77pK/WmdvlIDAN+QAMppFENc6jo9ubQYEHfMDEO6Fd/Mt5viQ==
X-Received: by 2002:ac8:5b89:0:b0:3a4:fddd:f8ef with SMTP id a9-20020ac85b89000000b003a4fdddf8efmr19618152qta.53.1675179891034;
        Tue, 31 Jan 2023 07:44:51 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:62fc])
        by smtp.gmail.com with ESMTPSA id pi48-20020a05620a37b000b006e16dcf99c8sm10297801qkn.71.2023.01.31.07.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 07:44:50 -0800 (PST)
Date:   Tue, 31 Jan 2023 09:44:47 -0600
From:   David Vernet <void@manifault.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, memxor@gmail.com, hch@infradead.org
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Use BPF_KFUNC macro at all kfunc
 definitions
Message-ID: <Y9k3bz5h8VDqDoZw@maniforge>
References: <20230123171506.71995-4-void@manifault.com>
 <20230123183305.2mgoxgw4ca3sfk24@macbook-pro-6.dhcp.thefacebook.com>
 <Y87We/92xiv5/+g+@maniforge.lan>
 <20230123185434.ybfhrmbootcnjuoj@macbook-pro-6.dhcp.thefacebook.com>
 <ebff2166-8a70-af62-b859-6b5c6b008b36@iogearbox.net>
 <87o7qphspq.fsf@meer.lwn.net>
 <Y88sMlmrq0wCFSRP@maniforge.lan>
 <87lelsgf60.fsf@meer.lwn.net>
 <Y9AFT4pTydKh+PD3@maniforge.lan>
 <7cecda8c-9499-4fc1-784c-4e6174122a1f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cecda8c-9499-4fc1-784c-4e6174122a1f@oracle.com>
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

On Tue, Jan 31, 2023 at 03:15:25PM +0000, Alan Maguire wrote:
> On 24/01/2023 16:20, David Vernet wrote:
> > On Tue, Jan 24, 2023 at 07:50:31AM -0700, Jonathan Corbet wrote:
> >> David Vernet <void@manifault.com> writes:
> >>
> >>> I was perhaps a bit naive to think we could just throw a __bpf_kfunc
> >>> macro onto the function signatures and call it a day :-) I think it's
> >>> probably best to table this for now, and either I or someone else can
> >>> come back to it when we have bandwidth to solve the problem more
> >>> appropriately.
> >>
> >> Now I feel bad ... I was just tossing out a thought, not wanting to
> >> bikeshed this work into oblivion.  If what you have solves a real
> > 
> > No apologies necessary. I don't think this qualifies as bikeshedding.
> > IMO folks are raising legitimate UX concerns, which is important and
> > worth getting right.
> > 
> >> problem and is the best that can be done now, perhaps it should just go
> >> in and a "more appropriate" solution can be adopted later, should
> >> somebody manage to come up with it?
> > 
> > That would be my preference, but I also understand folks' sentiment of
> > wanting to keep out what they feel like is odd syntax, as Christoph said
> > in [0], and Daniel alluded to earlier in this thread.
> > 
> > [0]: https://lore.kernel.org/all/Y8+FeH7rz8jDTubt@infradead.org/
> > 
> > I tested on an LTO build and wrapper kfuncs (with external linkage) were
> > not being stripped despite not being called from anywhere else in the
> > kernel, so for now I _think_ it's safe to call this patch set more of a
> > cleanup / future-proofing than solving an immediate and pressing problem
> > (as long as anyone adding kfuncs carefully follows the directions in
> > [1]). In other words, I think we have some time to do this the right way
> > without paying too much of a cost later. If we set up the UX correctly,
> > just adding an EXPORT_SYMBOL_KFUNC call (or something to that effect,
> > including just using BTF_ID_FLAGS) should be minimal effort even if
> > there are a lot more kfuncs by then.
> > 
> > [1]: https://docs.kernel.org/bpf/kfuncs.html
> > 
> > If it turns out that we start to observe problems in LTO builds without
> > specifying __used and/or noinline, or if folks are repeatedly making
> > mistakes when adding kfuncs (by e.g. not giving wrapper kfuncs external
> > linkage) then I think it would be a stronger case to get this in now and
> > fix it up later.
> >
> 
> hi David,
> 
> I think I may have stumbled upon such a case. We're working on improving
> the relationship between the generated BPF Type Format (BTF) info
> for the kernel and the actual function signatures, doing things like
> spotting optimized-out parameters and not including such functions
> in the final BTF since tracing such functions violates user expectations.
> The changes also remove functions with inconsistent prototypes (same
> name, different function prototype).
> 
> As part of that work [1], I ran into an issue with kfuncs. Because some of these
> functions have minimal definitions, the compiler tries to be clever and as
> a result parameters are not represented in DWARF. As a consequence of this,
> we do not generate a BTF representation for the kfunc (since DWARF is telling
> us the function has optimized-out parameters), and so then don't have BTF ids 
> for the associated kfunc, which is then not usable. The issue of trace accuracy
> is important for users, so we're hoping to land those changes in dwarves soon.

Hi Alan,

I see. Thanks for explaining. So it seems that maybe the issue is
slightly more urgent than we first thought. Given that folks aren't keen
on the BPF_KFUNC macro approach that wraps the function definition,
maybe we can go back to the __bpf_kfunc proposal from [0] as a stopgap
solution until we can properly support something like
EXPORT_SYMBOL_KFUNC. Alexei -- what do you think?

[0]: https://lore.kernel.org/bpf/Y7kCsjBZ%2FFrsWW%2Fe@maniforge.lan/T/

>  
> As described in [2] adding a prefixed
> 
> __attribute__ ((optimize("O0"))) 
> 
> ...to the kfunc sorts this out, so having that attribute rolled into a prefix
> definition like the one you've proposed would solve this in the short term.

Does just using __attribute__((__used__)) work? Many of these kfuncs are
called on hotpaths in BPF programs, so compiling them with no
optimization is not an ideal or likely even realistic option. Not to
mention the fact that not all kfuncs are BPF-exclusive (meaning you can
export a normal kernel function that's called by the main kernel as a
kfunc).

> There may be a better way to solve the problem I've run into, but I can't
> see an easy solution right now.
> 
> Would the above be feasible do you think? Thanks!
> 
> Alan
> 
> [1] https://lore.kernel.org/bpf/1675088985-20300-1-git-send-email-alan.maguire@oracle.com/
> [2] https://lore.kernel.org/bpf/fe5d42d1-faad-d05e-99ad-1c2c04776950@oracle.com/
> 
>  

Thanks,
David
