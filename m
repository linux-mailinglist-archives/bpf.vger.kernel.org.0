Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C966B6152
	for <lists+bpf@lfdr.de>; Sat, 11 Mar 2023 23:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjCKWHg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Mar 2023 17:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCKWHf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Mar 2023 17:07:35 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536676A423
        for <bpf@vger.kernel.org>; Sat, 11 Mar 2023 14:07:34 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id y3so5984000qvn.4
        for <bpf@vger.kernel.org>; Sat, 11 Mar 2023 14:07:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678572453;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=my0t82e70uqfEM1oxxBzriQQxvrn0/X6aj2a5LDW8WM=;
        b=K6CINUfhRtoZgk7DyXZ8oLpe/lK//0HJZU0SDEE9JaZ78SX1uRTzOXJF7KpFI0TtbO
         B++DGZgkeTfsi/2XiucKBw3QTVEe0pDImT6eAHyCl2Pz9EGLoNw6gfWcosr/Z+QFK7k6
         +kpG3yybAgLEqE+6i7thtmCZo6aDET6YDRL/dNK6Ic2O2ItbQO7/NpORHE36EpMeiNlO
         Mh4zR8qMYTWfRnPQl39SksEa3hpt7YNMQwXsrQ98irIzPq1OMwnaJ/A6tnanjkW6/pBP
         XLLNXltNCLHOLFhfXzxH98gAYNTkZFyRzoxNLzehURQhtEXMN1R8jfRaN3YUv9wbtfQz
         0r0w==
X-Gm-Message-State: AO0yUKUhfV/aCxxuz8tsX4faPG+nQzSKs7ZYwcqAJW8LKVo9dDTFZd3T
        bDLm/ZO4A4zmRn7a0nPvahQ=
X-Google-Smtp-Source: AK7set8mYX5NbP+RiWLvUaR+MwJ7eWCYJNfYXwRnAUiYbCUJFl0b0lpxjoDYoc6Jz7L8MWJtkFNHlQ==
X-Received: by 2002:ad4:5c4a:0:b0:572:80ea:5fc7 with SMTP id a10-20020ad45c4a000000b0057280ea5fc7mr5768105qva.41.1678572453215;
        Sat, 11 Mar 2023 14:07:33 -0800 (PST)
Received: from maniforge ([2620:10d:c091:400::5:8f9c])
        by smtp.gmail.com with ESMTPSA id t202-20020a3746d3000000b0073b81e888bfsm2434027qka.56.2023.03.11.14.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 14:07:32 -0800 (PST)
Date:   Sat, 11 Mar 2023 16:07:30 -0600
From:   David Vernet <void@manifault.com>
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "bpf@ietf.org" <bpf@ietf.org>, ast@kernel.org
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Add extended call instructions
Message-ID: <20230311220730.GA449611@maniforge>
References: <20230310232144.4077-1-dthaler1968@googlemail.com>
 <20230311192115.GA332677@maniforge>
 <PH7PR21MB3878BD98FB4A65E5DF3E0906A3BB9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230311215347.GA436457@maniforge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311215347.GA436457@maniforge>
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

On Sat, Mar 11, 2023 at 03:53:47PM -0600, David Vernet wrote:
> On Sat, Mar 11, 2023 at 09:00:19PM +0000, Dave Thaler wrote:
> > David Vernet <void@manifault.com> wrote:
> > [...]
> > > > +BPF_CALL  0x8    0x0  call helper function imm    see `Helper functions`_
> > > > +BPF_CALL  0x8    0x1  call PC += offset           see `eBPF functions`_
> > > > +BPF_CALL  0x8    0x2  call runtime function imm   see `Runtime functions`_
> > > 
> > > The names "Helper functions", "eBPF functions", and "Runtime functions"
> > > feel, for lack of a better term, insufficiently distinct. I realize that it's very tricky
> > > to get the naming right here given that some of these terms (helpers +
> > > runtime functions) are conceptually the same thing, but as a reader with no
> > > background I expect I'd be confused by what the distinctions are as they all
> > > kind of sound like the same thing. What do you think of this as an alternative:
> > > 
> > > 1. Standard helper functions
> > > 2. BPF-local functions
> > > 3. Platform-specific helper functions
> > 
> > I like where you're going with this.  However, the fact is that some of the existing
> > Helper functions are actually very platform-specific and won't apply to other
> > platforms. So retroactively labeling all of them "standard" is somewhat problematic
> > in my view.
> 
> That makes sense. For what it's worth, I was envisioning us specifying
> both the helper number (and likely the semantics of those helpers) in
> the standard, and just skipping over any which are Linux-specific.
> That's of course assuming we do decide to include functions in the
> standard, which to my understanding is not yet finalized.
> 
> Regardless, I'll certainly defer to your expertise on when it's
> appropriate to use the word "standard", and I could see why it would be
> problematic to do so here.
> 
> > 
> > I do like the idea of using "<some adjective> helper functions" for both 1 and 3
> > though.  Since we might not choose to standardize all the existing type 1 functions,
> > maybe "Platform-agnostic helper functions" is synonymous and pairs nicely
> > With "Platform-specific helper functions" as a term.  And then we could just have
> > a note in the linux-notes.rst saying Linux has some platform-specific helper functions that for historical reasons are used with the platform-agnostic helper function
> > Instruction.
> 
> That's a reasonable option as well. The only thing that gives me pause
> is that, as you know, the plan of record for now in Linux is to have all
> new BPF -> main kernel functions added as kfuncs. That includes features
> which are "platform agnostic", such as BPF iterators. I know you've
> previously raised the idea of having the traditional helpers be used as
> standard / platform-agnostic helpers in BPF office hours, so this isn't
> out of the blue. It seems that the time has come to discuss it more
> concretely.

One thing to clarify -- I'm _not_ saying we should revisit the kfunc vs.
BPF helper discussion. Rather, just that we should decide exactly what
the older BPF helper instruction encoding means in terms of a generic
BPF instruction set.

> > 
> > > The idea with the latter is of course that the platform can choose to
> > > implement whatever helper functions (kfuncs for Linux) apply exclusively to
> > > that platform. I think we'd need some formal encoding for this in the
> > > standard, so it seems appropriate to apply it here. What do you think?
> > 
> > Agree with that.
> > 
> > > > +BPF_EXIT  0x9    0x0  return                      BPF_JMP only
> > > > +BPF_JLT   0xa    any  PC += offset if dst < src   unsigned
> > > > +BPF_JLE   0xb    any  PC += offset if dst <= src  unsigned
> > > > +BPF_JSLT  0xc    any  PC += offset if dst < src   signed
> > > > +BPF_JSLE  0xd    any  PC += offset if dst <= src  signed
> > > > +========  =====  ===  ==========================
> > > > +========================
> > > >
> > > >  The eBPF program needs to store the return value into register R0
> > > > before doing a  BPF_EXIT.
> > > > @@ -272,6 +274,18 @@ set of function calls exposed by the runtime.
> > > > Each helper  function is identified by an integer used in a ``BPF_CALL``
> > > instruction.
> > > >  The available helper functions may differ for each program type.
> > > >
> > > > +Runtime functions
> > > > +~~~~~~~~~~~~~~~~~
> > > > +Runtime functions are like helper functions except that they are not
> > > > +specific to eBPF programs.  They use a different numbering space from
> > > > +helper functions,
> > > 
> > > Per my suggestion above, should we rephrase this as "platform-specific"
> > > helper functions? E.g. something like:
> > > 
> > > Platform-specific helper functions are helper functions that may be unique to
> > > a particular platform. An encoding for a platform-specific function on one
> > > platform may or may not correspond to the same function on another
> > > platform. Platforms are not required to implement any platform-specific
> > > function.
> > 
> > That looks good to me, will incorporate.
> > 
> > > 
> > > As alluded to above, the fact that they're not specific to BPF seems like an
> > > implementation detail from the perspective of the encoding / standard.
> > > Thoughts?
> > > 
> > > > +but otherwise the same considerations apply.
> > > > +
> > > > +eBPF functions
> > > > +~~~~~~~~~~~~~~
> > > > +eBPF functions are functions exposed by the same eBPF program as the
> > > > +caller, and are referenced by offset from the call instruction, similar to
> > > ``BPF_JA``.
> > > > +A ``BPF_EXIT`` within the eBPF function will return to the caller.
> > > 
> > > Suggestion: Can we simply say BPF instead of eBPF? At this point I'm not sure
> > > what the 'e' distinction really buys us, though I'm sure I'm missing context
> > > from (many) prior discussions. I also don't want to bikeshed too much on this
> > > point for your patch, so if it becomes a "thing" then feel free to ignore.
> > 
> > Will remove for consistency with the other patches I submitted that already
> > omitted the "e".   I think Alexei had the same comment a while back and
> > I missed updating this proposed section at the time.  Thanks.
> > 
> > Dave
> > 
> > > 
> > > Thanks,
> > > David
