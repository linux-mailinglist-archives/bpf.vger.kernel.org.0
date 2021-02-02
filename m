Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BED30B40B
	for <lists+bpf@lfdr.de>; Tue,  2 Feb 2021 01:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhBBAXc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Feb 2021 19:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhBBAX2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Feb 2021 19:23:28 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1A2C061573
        for <bpf@vger.kernel.org>; Mon,  1 Feb 2021 16:22:48 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id l18so1137392pji.3
        for <bpf@vger.kernel.org>; Mon, 01 Feb 2021 16:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DXSi7YWGTfwDzL22AV7NuYK80KSq9+AiYcTm0VYQDiU=;
        b=oaNYtJO6cEsy9HEC72AJyOXVoQHHzcpjF9CaOjuDpEXEBbIGhbgcBTkrCiCScMIWc+
         XCIMbwu+WQXh8gfDOWWk4feGBZL48q3qPoWs4JNksokyCBGkJJgjz/3uIBM+O57cDVkA
         gizFdvFH1niu0Uw4JsBvby8kAgaAt0YTFPO3YNtyKP+A2BGAL0wlJWRUj7d/mVMiczsX
         jbsIilZqd5ufSK1GyR4S7Zp9AMTW7HzBQ10m45CpbygeOHJjjSODCLAqnQ0AI+hwCria
         sOPFKcTng9FHKb6FInRAAE/2O1KV9zK5acZd1oveqKykIJ4lycoHSRwJrXVCGGCiTC6D
         sH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DXSi7YWGTfwDzL22AV7NuYK80KSq9+AiYcTm0VYQDiU=;
        b=q+pnq54FPicE1jeXrwiVZCG4Kot0L37vhW1/kolymtzF0ujPWOU3Jt69UZZSw0X1sR
         +hq+RZ3jscvCPlA5tZRpc0BmM/6aVtcxU+BUQYxmNTDW1TJ+l+E0YbReAqS3Oi7ASEIM
         2TNW25ghhwscwNOYCLzqO8ZQGiQc8NoNC/nrNO7tlm4eGNvSbutJ3fZzHgp6dDbp/IKU
         9SH2T3L5wJUwmjVo9G76XcSlEZNCZ53hMMovXaw+NGrgZyrnXVh4Z4Pj7IQezb5+lKBp
         ErA938IJcqVypTs2ZQz9c3MsogJdFYJhocO+lAhG00o4b/kgOCR16OHl3t5Y2HwKWQqw
         12TQ==
X-Gm-Message-State: AOAM532MxCpT5RWA4a3f/Dyqrw+PlrHm4LgKCHrnf3eiKJPJgEG09yOl
        o8XSphQREkNOISwL3ROiSLk=
X-Google-Smtp-Source: ABdhPJz3yfNE2ZRCKCWTQYJYwJJ55aZ776GP5rdO+c9NKfQ0PIlkwk87TGsUSiwrjLXUX4dMHgkUig==
X-Received: by 2002:a17:902:8f97:b029:e1:230f:5575 with SMTP id z23-20020a1709028f97b02900e1230f5575mr17358965plo.68.1612225368225;
        Mon, 01 Feb 2021 16:22:48 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:1720])
        by smtp.gmail.com with ESMTPSA id gz6sm569988pjb.40.2021.02.01.16.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 16:22:47 -0800 (PST)
Date:   Mon, 1 Feb 2021 16:22:43 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrei Matei <andreimatei1@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org
Subject: Re: [PATCH bpf-next v2 1/5] bpf: allow variable-offset stack access
Message-ID: <20210202002243.k3d2jeczf6ggiipf@ast-mbp.dhcp.thefacebook.com>
References: <20210124194909.453844-1-andreimatei1@gmail.com>
 <20210124194909.453844-2-andreimatei1@gmail.com>
 <20210127225818.3uzw3tehbu3qlyd6@ast-mbp.dhcp.thefacebook.com>
 <CABWLsetKoJ033hbaOxGKmv6jsWEvXebr3fpXxj9itW7yP7XqOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABWLsetKoJ033hbaOxGKmv6jsWEvXebr3fpXxj9itW7yP7XqOQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jan 30, 2021 at 05:55:36PM -0500, Andrei Matei wrote:
> Thanks for reviewing this!
> 
> On Wed, Jan 27, 2021 at 5:58 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sun, Jan 24, 2021 at 02:49:05PM -0500, Andrei Matei wrote:
> > > + *
> > > + * If some stack slots in range are uninitialized (i.e. STACK_INVALID), the
> > > + * write is not automatically rejected. However, they are left as
> > > + * STACK_INVALID, which means that reads with the same variable offset will be
> > > + * rejected.
> > ...
> > > +             /* If the slot is STACK_INVALID, we leave it as such. We can't
> > > +              * mark the slot as initialized, as the slot might not actually
> > > +              * be written to (and so marking it as initialized opens the
> > > +              * door to leaks of uninitialized stack memory.
> > > +              */
> > > +             if (*stype != STACK_INVALID)
> > > +                     *stype = new_type;
> >
> > 'leaks of uninitialized stack memory'...
> > well that's true, but the way the user would have to deal with this
> > is to use __builtin_memset(&buf, 0, 16); for the whole buffer
> > before doing var_off write into it.
> > In the test in patch 5 would be good to add a read after this write:
> > buf[len] = buf[idx];
> > // need to do another read of buf[len] here.
> >
> > Without memset() it would fail and the user would flame us:
> > "I just wrote into this stack slot!! Why cannot the verifier figure out
> > that the read from the same location is safe?... stupid verifier..."
> >
> > I think for your use case where you read the whole thing into a stack and
> > then parse it all locations potentially touched by reads/writes would
> > be already written via helper, but imo this error is too unpleasant to
> > explain to users.
> > Especially since it happens later at a different instruction there is
> > no good verifier hint we can print.
> > It would just hit 'invalid read from stack'.
> >
> > Currently we don't allow uninit read from stack even for root.
> > I think we have to sacrifice the perfection of the verification here.
> > We can either allow reading uninit for _fixed and _var_off
> > or better yet do unconditional '*stype = new_type' here.
> > Yes it would mean that following _fixed or _var_off read could be
> > reading uninited stack. I think we have to do it for the sake
> > of user friendliness.
> > The completely buggy uninited reads from stack will still be disallowed.
> > Only the [min,max] of var_off range in stack will be considered
> > init, so imo it's a reasonable trade-off between user friendliness
> > and verifier's perfection.
> > Wdyt?
> 
> I'm happy to do whatever you tell me. But, I dunno, the verifier
> currently seems to be paranoid in ways I don't even understand (around
> speculative execution). In comparison, preventing trivial leaks of
> uninitialized memory seems relatively important. We're only talking
> about root here (as you've noted), and other various checks are less
> paranoid for root, so maybe it's no big deal. Where does the stack
> memory come from? Can it be *any* previously used kernel memory?
> A few possible alternatives (without necessarily knowing what I'm
> talking about):
> 1) Perhaps it wouldn't be a big deal to zero-initialize all the stack
> memory (up to 512 bytes) for a program. Is that out of the question?
> In many cases it'd be less than 512 bytes; the verifier knows the max
> stack needed. If the stack was always initialized, various verifier
> checks could go away.

Even if stack usage is small, like 64 byte, bzero of it has noticeable
perf penalty.

> 2) We could leave this patch as is, and work on improving the error
> you get on rejected stack reads after var-offset stack writes. I think
> the verifier could track what stack slots might have or might have not
> been written to, and when a read to such an uncertain slot is
> rejected, it could point to the previous var-off write (or one of the
> possibly many such writes) and suggest a memset. Sounds potentially
> complicated though.

too complicated imo.

> 3) Perhaps we could augment helper metadata with information about
> whether each helper promises to overwrite every byte in the buffer
> it's being passed in. This wouldn't solve the general usability
> problem we're discussing, but it would make common cases just work.
> Namely, bpf_probe_read_user() can make the required promise.
> bpf_probe_read_user_str(), however, could not.

eventually yes. That's orthogonal to this patch set.

> 
> But, again, if you think relaxing the verification is OK, I'm very
> happy to do that.

The tracing progs can read stack with bpf_probe_read_kernel anyway, so
I would prefer to relax it to improve ease of use.
Unconditional *stype = new_type; here would do the trick.
Not for unpriv, of course.
Probably another 'bool' flag (instead of jumbo allow_ptr_leaks)
like 'allow_uninit_stack' that is set with perfmon_capable().

> > >
> > >               tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> > > -             verbose(env, "variable stack access var_off=%s off=%d size=%d\n",
> > > +             verbose(env, "var-offset stack reads only permitted to register; var_off=%s off=%d size=%d\n",
> >
> > The message is confusing. "read to register"? what is "read to not register" ?
> > Users won't be able to figure out that it means helpers access.
> > Also nowadays it means that atomic ops won't be able to use var_off into stack.
> > I think both limitations are ok for now. Only the message needs to be clear.
> 
> What message would you suggest? Would you plumb information about what
> the read type is (helper vs atomic op)?

Something like: "variable offset stack pointer cannot be passed into helper functions" ?
