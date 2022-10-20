Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C84605756
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 08:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiJTGdR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 02:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJTGdQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 02:33:16 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40AF159971;
        Wed, 19 Oct 2022 23:33:15 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id u7so1036060qvn.13;
        Wed, 19 Oct 2022 23:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ID6ULUicIzzzJTDZRhlwX73uCvo0CI37TULGJDLP9tc=;
        b=lldxepna6TuHKW+MeT/x7Cu1bhRlPlamg1i0dGpZp6jfUcRGbfEG6sVUy9jPcp+rUs
         8NquQME6f40pjkzlzdj7IfSTM6elwVrus/upTuYZIrHHxDL3YTBgkyDKWrc35D9oX6Ps
         KAOQwQw9z89d6P+naSLx71tjGpHapT4ExEKJfw0Knp5VdPMzkpvzCysmaGqKizAWxUbL
         +p7KwC8dh5xWsBTfEcyr4hVFGJXoNvWo9rMlQ3GRd7kyaMEYd7sLwT4rKchSlBsKNrSu
         cUhfOPu3VDo0gtXbHms3cAkUqz50CFwixyFnwH+6sgHmWz15xqEt1QGEIeftLo7kT1mf
         1/mg==
X-Gm-Message-State: ACrzQf14so3HFahBMuYTwtla4jfO/8/kNF6zEfn1VBIT5tkNEfwp3blL
        ITXZJjP9qgcGocp92unF7Hk=
X-Google-Smtp-Source: AMsMyM6XeZTaDTUWvPvBJ1A9Y5y5bir5mrP2uJspsvQaw+k+qWLKswa9elhwRaZgYy55wfEDQOWiRw==
X-Received: by 2002:a05:6214:4101:b0:4af:8cdc:20c4 with SMTP id kc1-20020a056214410100b004af8cdc20c4mr9856806qvb.6.1666247594645;
        Wed, 19 Oct 2022 23:33:14 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::9f20])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a445600b006bbc09af9f5sm628988qkp.101.2022.10.19.23.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 23:33:13 -0700 (PDT)
Date:   Thu, 20 Oct 2022 01:33:16 -0500
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, tj@kernel.org
Subject: Re: [PATCH v5 3/3] bpf/selftests: Add selftests for new task kfuncs
Message-ID: <Y1DrrAfXA3rTq5us@maniforge.dhcp.thefacebook.com>
References: <20221014212133.2520531-1-void@manifault.com>
 <20221014212133.2520531-4-void@manifault.com>
 <Y1A2OUuUn4z/Du+j@maniforge.dhcp.thefacebook.com>
 <20221020061903.brfxt7ktxfajreer@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020061903.brfxt7ktxfajreer@apollo>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 20, 2022 at 11:49:03AM +0530, Kumar Kartikeya Dwivedi wrote:
> On Wed, Oct 19, 2022 at 11:09:05PM IST, David Vernet wrote:
> > > On Sat, 15 Oct 2022 at 01:45, David Vernet <void@manifault.com> wrote:
> > > >
> > > > A previous change added a series of kfuncs for storing struct
> > > > task_struct objects as referenced kptrs. This patch adds a new
> > > > task_kfunc test suite for validating their expected behavior.
> > > >
> > > > Signed-off-by: David Vernet <void@manifault.com>
> > > > ---
> > > > [...]
> > > > +
> > > > +SEC("tp_btf/task_newtask")
> > > > +int BPF_PROG(task_kfunc_acquire_trusted_nested, struct task_struct *task, u64 clone_flags)
> > > > +{
> > > > +       struct task_struct *acquired;
> > > > +
> > > > +       if (!is_test_kfunc_task())
> > > > +               return 0;
> > > > +
> > > > +       /* Can't invoke bpf_task_acquire() on a trusted pointer at a nonzero offset. */
> > > > +       acquired = bpf_task_acquire(task->last_wakee);
> > >
> > > The comment is incorrect, that would be &task->last_wakee instead,
> > > this is PTR_TO_BTF_ID | PTR_NESTED.
> >
> > Well, it's a nonzero offset from task. But yes, to your point, it's a
> > misleading comment because the offset is 0 in the verifier. I'll
> 
> The load insn has a non-zero offset, but not the destination reg.

Yeah, this is what I meant by hand-wavily saying "0 in the verifier". I
agree that the comment is incorrect as stated, I'll fix it in the next
revision per your suggestion.

> What you did was:
> r1 = rX + offsetof(task_struct, last_wakee); // r1 == rX + off
> r1 = *(r1); // r1 == PTR_TO_BTF_ID of task_struct, off = 0
> 
> Embedded structs are different,
> &file->f_path means non-zero offset into PTR_TO_BTF_ID of struct file
> 
> > rephrase this to reflect that it's a nested pointer (or a walked
> > pointer, whatever nomenclature we end up going with).
> >
> > > > +       if (!acquired)
> > > > +               return 0;
> > > > +       bpf_task_release(acquired);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > [...]
> > > > +
> > > > +static int test_acquire_release(struct task_struct *task)
> > > > +{
> > > > +       struct task_struct *acquired;
> > > > +
> > > > +       acquired = bpf_task_acquire(task);
> > >
> > > Unfortunately a side effect of this change is that now since
> > > PTR_TO_BTF_ID without ref_obj_id is considered trusted, the bpf_ct_*
> > > functions would begin working with tp_btf args. That probably needs
> > > be fixed so that they reject them (ideally with a failing test case to
> > > make sure it doesn't resurface), probably with a new suffix __ref/or
> > > __owned as added here [0].
> > >
> > > Alexei, since you've suggested avoiding adding that suffix, do you see
> > > any other way out here?
> > > It's questionable whether bpf_ct_set_timeout/status should work for CT
> > > not owned by the BPF program.
> > >
> > >   [0]: https://lore.kernel.org/bpf/dfb859a6b76a9234baa194e795ae89cb7ca5694b.1662383493.git.lorenzo@kerne
> >
> > Ah, yeah, it makes sense that some kfuncs really should only ever be
> > passed an object if the program owns a reference on it. Specifically for
> > e.g. bpf_ct_set_timeout/status() as you point out, which should only be
> > passed a struct nf_conn__init that was allocated by bpf_skb_ct_alloc().
> >
> > It'd be nice if we could just add another flag like KF_REFERENCED_ARGS
> > or KF_OWNED_ARGS, which would allow a subset of arguments affored by
> > KF_TRUSTED_ARGS, only those with ref_obj_id > 0. That approach wouldn't
> > allow the flexibility of having per-argument specifications as your
> > proposal to use __ref or __owned suffixes on the names, but that already
> > applies to KF_TRUSTED_ARGS as well.
> >
> > Personally I'm in agreement with Alexei that it's not a user friendly
> > API to use suffixes in the name like this. If we want to allow kfunc
> > authors to have per-argument specifiers, using compiler attributes
> > and/or some kind of tagging is probably the way to do it?
> 
> Sadly GCC doesn't support BTF tags. So this is the next best tagging approach.
> 
> There was also another horrendous proposal from me to add flags to each argument:
> https://gist.github.com/kkdwivedi/7839cc9e4f002acc3e15350b1b86c88c#file-kfunc-arg-patch-L137

I feel like I must be missing something given that you said this was
horrendous, but I actually don't hate this. This is pretty similar to
what we do for helpers anyways, no? I certainly prefer it over the
suffix naming approach. IMO the problem with that is it kind of requires
users to dive into the verifier to understand how to implement kfuncs.
That also reminds me that in the next revision, I'll also update the
documentation for KF_TRUSTED_ARGS (and KF_OWNED_ARGS) to reflect the new
state of things.

> > My proposal for now is to add a new KF_OWNED_ARGS flag, and to very
> > clearly document exactly what that and KF_TRUSTED_ARGS implies for
> > kfuncs. Later on, we could explore solutions for having per-arg
> > specifiers. What do you and Alexei think?
> 
> Based on your proposal above:
> 
> For KF_OWNED_ARGS, any PTR_TO_BTF_ID should have non-zero ref_obj_id, for
> KF_TRUSTED_ARGS there will be no such condition. Otherwise they will be the
> same. Then switch all CT helpers to KF_OWNED_ARGS.

Exactly

> This should work fine.

Great, I'll get to work on this. Unless Alexei or anyone else objects?
