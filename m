Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B31D8DB898
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2019 22:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388866AbfJQUoe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Oct 2019 16:44:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41680 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbfJQUod (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Oct 2019 16:44:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id t3so2015775pga.8
        for <bpf@vger.kernel.org>; Thu, 17 Oct 2019 13:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QrdtgiqdwbTjqAtS7fLbpHezQoDUp9ICG7q/Cv0tpqc=;
        b=lA1M+W653UVf5S5m6KkG5VGuChZNkH6rPFKXNa0TmYwddxDp5wDgn7NYZKffCeO06b
         b0QgEAVrTtPPkXLxErCrx70pHixBI8nLbcwTZGQKvyl7i0W0m1fAGvkDFNKDOMadpTzS
         nmba1FLIf6H4T/Ud+6BtUp2/+Zj8Ru+5o7krJOWtDg4H4JQVezNFDscHjvxqn6fYTC7A
         k3YpShN5ZkskQlsAe0VOy220skPK+FPSkMd1n9DZSZQ/BS1W0Q6J3vvik05HmQ6h69m4
         PDjP5VmZOJe2cGxZe7H03xjJKfOFNUTssOj6pOPkP4MIuHLLCFR5ViVhhpLDprp+hoYR
         u33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QrdtgiqdwbTjqAtS7fLbpHezQoDUp9ICG7q/Cv0tpqc=;
        b=hOmQ8zA1C+VOyn92dW4yMmrZycCyGK0iZnyWN8qbad/IcGOFZoaCd4IUQm0y5ooILa
         0dFGeYZbZsM9Pz2c0VdMEBGKUP5LXHtZdRRaHYRCQpW6I4xwpjG7kyJu+fucnw70qxPj
         ZyjALlo8MNId3dpjXa5dwscEXwMeyJ42lYV+MnQFBXIoEsfWz4o0EcyXbuAFqBsZO8+Z
         USOR4V8g85eo51MHADEJvIor18Nl9xgO9eRDq2xsvk5a69FUP+vBJXeO/mDlPwcSNnKq
         LjnPTt2WF2Lu6dIokf8oiqj9AJI+iQM/vDkxyUSLu62vefpKhHjplC6WY/TIuGo4Zhs7
         uRtQ==
X-Gm-Message-State: APjAAAXiMvLXv3MvNpTQIjWFKF05XQuYgxybeI8NjeIr5v37GToFJs1h
        oZt+TYXd5rlSIGRnfr8JGs1D9A==
X-Google-Smtp-Source: APXvYqzuG7vsfBpftNaMhJ5ZjNi57Wnxees9+OYetXg9d1/IXofqPZ5aNiMojYt5XlWqv+w1XdIssg==
X-Received: by 2002:a62:ac02:: with SMTP id v2mr2271719pfe.97.1571345072041;
        Thu, 17 Oct 2019 13:44:32 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id n2sm3415811pgg.77.2019.10.17.13.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 13:44:31 -0700 (PDT)
Date:   Thu, 17 Oct 2019 13:44:30 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v4 bpf-next 5/7] selftests/bpf: replace test_progs and
 test_maps w/ general rule
Message-ID: <20191017204430.GC2090@mini-arch>
References: <20191016060051.2024182-1-andriin@fb.com>
 <20191016060051.2024182-6-andriin@fb.com>
 <20191016163249.GD1897241@mini-arch>
 <CAEf4BzYVWc8RWNSthN8whROYJUEijR1Uh3Lyt6bkuhM2tRsq2Q@mail.gmail.com>
 <20191017160716.GA2090@mini-arch>
 <CAEf4BzYSUoN2Boy-iveFAFGiiAMta5S9SK8aGO1BMnd+q2FzbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYSUoN2Boy-iveFAFGiiAMta5S9SK8aGO1BMnd+q2FzbA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/17, Andrii Nakryiko wrote:
> On Thu, Oct 17, 2019 at 9:07 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > On 10/16, Andrii Nakryiko wrote:
> > > On Wed, Oct 16, 2019 at 9:32 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> > > >
> > > > On 10/15, Andrii Nakryiko wrote:
> > > > > Define test runner generation meta-rule that codifies dependencies
> > > > > between test runner, its tests, and its dependent BPF programs. Use that
> > > > > for defining test_progs and test_maps test-runners. Also additionally define
> > > > > 2 flavors of test_progs:
> > > > > - alu32, which builds BPF programs with 32-bit registers codegen;
> > > > > - bpf_gcc, which build BPF programs using GCC, if it supports BPF target.
> > > > Question:
> > > >
> > > > Why not merge test_maps tests into test_progs framework and have a
> > > > single binary instead of doing all this makefile-related work?
> > > > We can independently address the story with alu32/gcc progs (presumably
> > > > in the same manner, with make defines).
> > >
> > > test_maps wasn't a reason for doing this, alue2/bpf_gcc was. test_maps
> > > is a simple sub-case that was just easy to convert to. I dare you to
> > > try solve alu32/bpf_gcc with make defines (whatever you mean by that)
> > > and in a simpler manner ;)
> > I think my concern comes from the fact that I don't really understand why
> > we need all that complexity (and the problem you're solving for alu/gcc;
> > part of that is that you're replacing everything, so it's hard to
> > understand what's the real diff).
> >
> > In particular, why do we need to compile test_progs 3 times for
> > normal/alu32/gcc? Isn't it the same test_progs? Can we just teach test_progs
> > to run the tests for 3 output dirs with different versions of BPF programs?
> > (kind of like you do in your first patch with -<flavor>, but just in a loop).
> 
> So that's a good question and the answer is "no, we can't". And that's
> why I consider alu32/bpf_gcc broken. Check progs/test_attach_probe.c,
> it does BPF_OBJECT_EMBED, which links BPF object into test object
> file. This means that if we want to compile BPF objects differently
> between default/alu32/gcc flavors, we need to compile test_progs
> independently. Embedding objects is going to be prevalent way to
> consume them (and it is already the only way we consume them in
> production at FB), so we need to accommodate it. With some more
> usability improvements that's on my TODO list, it will become also
> much more convenient and easy to consume such BPF objects.
Thanks for the explanation, I missed that EMBED_FILE in attach_probe.c

I was going to suggest to move it out of test_progs (or use open() instead
of embedding?) if you want to test bpf_object__open_mem (to avoid all that
complexity and make test_progs work with any bpf alu32/gcc/clang subdir),
but it seems like you have pretty much settled on the embedding.

It's interesting that we try to do it a bit different here, maybe
even going as far as rolling out individual BPF .o files without
updating the control plane :-)

> > > > I can hardly follow the existing makefile and now with the evals it's
> > > > 10x more complicated for no good reason.
> > >
> > > I agree that existing Makefile logic is hard to follow, especially
> > > given it's broken. But I think 10x more complexity is gross
> > > exaggeration and just means you haven't tried to follow rules' logic.
> > Not 10x, but it does raise a complexity bar. I tried to follow the
> > rules, but I admit that I didn't try too hard :-)
> 
> So see my explanation above about why we need to compile flavors
> independently. Rules have to be like they are here. I'd like to make
> dependencies between test objects and BPF objects a bit more granular,
> but only after we land this, it's already quite a lot of changes at
> once.
> 
> Beyond fixing the rules, $(eval)/$(call) is a new stuff for
> selftests/bpf's Makefile, but it's semantics is well described in
> documentation and you can gloss over it for now, it shouldn't break
> with Makefile changes.
> 
> >
> > > The rules inside DEFINE_TEST_RUNNER_RULES are exactly (minus one or
> > > two ifs to prevent re-definition of target) the rules that should have
> > > been written for test_progs, test_progs-alu32, test_progs-bpf_gcc.
> > > They define a chain of BPF .c -> BPF .o -> tests .c -> tests .o ->
> > > final binary + test.h generation. Previously we were getting away with
> > > this for, e.g., test_progs-alu32, because we always also built
> > > test_progs in parallel, which generated necessary stuff. Now with
> > > recent changes to test_attach_probe.c which now embeds BPF .o file,
> > > this doesn't work anymore. And it's going to be more and more
> > > prevalent form, so we need to fix it.
> > >
> > > Surely $(eval) and $(call) are not common for simple Makefiles, but
> > > just ignore it, we need that to only dynamically generate
> > > per-test-runner rules. DEFINE_TEST_RUNNER_RULES can be almost read
> > > like a normal Makefile definitions, module $$(VAR) which is turned
> > > into a normal $(VAR) upon $(call) evaluation.
> > >
> > > But really, I'd like to be wrong and if there is simpler way to
> > > achieve the same - go for it, I'll gladly review and ack.
> > Again, it probably comes from the fact that I don't see the problem
> > you're solving. Can we start by removing 3 test_progs variations
> > (somthing like patch below)? If we can do it, then the leftover parts
> > that generate alu32/gcc bpf program don't look too bad and can probably
> > be tweaked without makefile codegen.
> 
> Yes, it probably is. See above, I tried to give more context.
Again, thanks for the explanation, I did indeed miss that EMBED_FILE
case. But I'd still vote for moving that test into a dedicated binary,
have single test_progs that works with a flavored BPF subdir and simplify
the makefile instead of adding more stuff into it.

These are my 2c, feel free to ignore :-) We have our own simplified
reimplementation anyway to fit into our testing system, so I don't
have a horse in this race.

> I've fixed some other inconveniences with current Makefile set up
> (e.g., on-demand bpf_helper_defs.h re-generation, etc), but those are
> minor changes and it was hard to de-couple from the main change.
> 
> >
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -157,26 +157,10 @@ TEST_VERIFIER_CFLAGS := -I. -I$(OUTPUT) -Iverifier
> >
> 
> [...]
> 
> >  endif
> >
> > > Please truncate irrelevant parts, easier to review.
> > Sure, will do, but I always forget because I don't have this problem.
> > In mutt I can press shift+s to jump to the next unquoted section.
> 
> no worries, but with a bit of recurring reminder it becomes easier, I
> know from my own experience :)
