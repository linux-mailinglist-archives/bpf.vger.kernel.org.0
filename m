Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC65605741
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 08:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJTGT2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 02:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJTGT1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 02:19:27 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D5E1BE429;
        Wed, 19 Oct 2022 23:19:17 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id c24so19386625pls.9;
        Wed, 19 Oct 2022 23:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2hzZh0KIW213TJCUMM9hLQphu7sjbz5vU04J6ZTEIuU=;
        b=m6XiZPKmBsmbvAdKgLNL9du1Mf+9nfq78jpBYkBUSsAaesEmk2G3yf57nnUxaYGseS
         wLY/464BZJCXvTCaTIEi+gGSUzN7FOCVXVp20b3aUg2jSWM5qA8jtqmZ1kjh/qIVamr6
         RRdzVyvZT6IWy6fluKn8zPVlbd4kTSA00rYXx9/HedEdunztYLshS2XlmLJ45lek4JAR
         afv+sYI6HyPHa5CO5cvp1aE2EIADiiTeeQxA4/BhFfuzac8/dlV1locPJEN2EIgCf5VP
         oDaly+5Q0UBgws6YDhAU9ijQWWpkXFHQPP6U11kCYbpH4+jm4E57lYRMWwZFy0QJ9ciq
         sl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hzZh0KIW213TJCUMM9hLQphu7sjbz5vU04J6ZTEIuU=;
        b=Voxrrdgf6p/ujMAx6gDPFszVlQtmi3HVIJ20Jh8UcuWbvrduwlTf+LYHBzL9JjM/yx
         N7GUNgFX4Atb8DgjRZrV2kFNxVIGrpOI85AJLtzqDhcZbCDu8K/KDfWm1gN3DqBK5pWN
         v8+klHm1j/Ot65a6q4ubrx0Ds7zo2TVEAufiwW6oPaP4kT7/P/AGE7GBkwmZm6sDF0N7
         Y7MJClNaPhpL8HMTFFArX2X8gGsW3f0DiX8DfSlLlXTFeGrFM3dLlviGwTdgnheG1xuc
         ulelJpsTkE1K3g+t2MwIhpmjdc12h9LvJqh2Pt26OB0py9+3QP098FTvZ6r+7NQ/D095
         3lkw==
X-Gm-Message-State: ACrzQf2tGrjxz1PmJP3/xa+M/ITzF7TRMJCZURF2Lti2XDvQZngghKW2
        ATZE6PmaD99e3dQ0O8aYYDs=
X-Google-Smtp-Source: AMsMyM7Y6c+w9bl+UoquXSuSlt3NDX8t/VhChOwr5q5DY3H1JL+0jJwgfnARrA0rjZGkTyJ8b+yTxw==
X-Received: by 2002:a17:90b:1c8e:b0:205:783b:fe32 with SMTP id oo14-20020a17090b1c8e00b00205783bfe32mr51136314pjb.39.1666246756286;
        Wed, 19 Oct 2022 23:19:16 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id 6-20020a620406000000b0054ee4b632dasm12362340pfe.169.2022.10.19.23.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 23:19:15 -0700 (PDT)
Date:   Thu, 20 Oct 2022 11:49:03 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, tj@kernel.org
Subject: Re: [PATCH v5 3/3] bpf/selftests: Add selftests for new task kfuncs
Message-ID: <20221020061903.brfxt7ktxfajreer@apollo>
References: <20221014212133.2520531-1-void@manifault.com>
 <20221014212133.2520531-4-void@manifault.com>
 <Y1A2OUuUn4z/Du+j@maniforge.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1A2OUuUn4z/Du+j@maniforge.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 19, 2022 at 11:09:05PM IST, David Vernet wrote:
> > On Sat, 15 Oct 2022 at 01:45, David Vernet <void@manifault.com> wrote:
> > >
> > > A previous change added a series of kfuncs for storing struct
> > > task_struct objects as referenced kptrs. This patch adds a new
> > > task_kfunc test suite for validating their expected behavior.
> > >
> > > Signed-off-by: David Vernet <void@manifault.com>
> > > ---
> > > [...]
> > > +
> > > +SEC("tp_btf/task_newtask")
> > > +int BPF_PROG(task_kfunc_acquire_trusted_nested, struct task_struct *task, u64 clone_flags)
> > > +{
> > > +       struct task_struct *acquired;
> > > +
> > > +       if (!is_test_kfunc_task())
> > > +               return 0;
> > > +
> > > +       /* Can't invoke bpf_task_acquire() on a trusted pointer at a nonzero offset. */
> > > +       acquired = bpf_task_acquire(task->last_wakee);
> >
> > The comment is incorrect, that would be &task->last_wakee instead,
> > this is PTR_TO_BTF_ID | PTR_NESTED.
>
> Well, it's a nonzero offset from task. But yes, to your point, it's a
> misleading comment because the offset is 0 in the verifier. I'll

The load insn has a non-zero offset, but not the destination reg.

What you did was:
r1 = rX + offsetof(task_struct, last_wakee); // r1 == rX + off
r1 = *(r1); // r1 == PTR_TO_BTF_ID of task_struct, off = 0

Embedded structs are different,
&file->f_path means non-zero offset into PTR_TO_BTF_ID of struct file

> rephrase this to reflect that it's a nested pointer (or a walked
> pointer, whatever nomenclature we end up going with).
>
> > > +       if (!acquired)
> > > +               return 0;
> > > +       bpf_task_release(acquired);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > [...]
> > > +
> > > +static int test_acquire_release(struct task_struct *task)
> > > +{
> > > +       struct task_struct *acquired;
> > > +
> > > +       acquired = bpf_task_acquire(task);
> >
> > Unfortunately a side effect of this change is that now since
> > PTR_TO_BTF_ID without ref_obj_id is considered trusted, the bpf_ct_*
> > functions would begin working with tp_btf args. That probably needs
> > be fixed so that they reject them (ideally with a failing test case to
> > make sure it doesn't resurface), probably with a new suffix __ref/or
> > __owned as added here [0].
> >
> > Alexei, since you've suggested avoiding adding that suffix, do you see
> > any other way out here?
> > It's questionable whether bpf_ct_set_timeout/status should work for CT
> > not owned by the BPF program.
> >
> >   [0]: https://lore.kernel.org/bpf/dfb859a6b76a9234baa194e795ae89cb7ca5694b.1662383493.git.lorenzo@kerne
>
> Ah, yeah, it makes sense that some kfuncs really should only ever be
> passed an object if the program owns a reference on it. Specifically for
> e.g. bpf_ct_set_timeout/status() as you point out, which should only be
> passed a struct nf_conn__init that was allocated by bpf_skb_ct_alloc().
>
> It'd be nice if we could just add another flag like KF_REFERENCED_ARGS
> or KF_OWNED_ARGS, which would allow a subset of arguments affored by
> KF_TRUSTED_ARGS, only those with ref_obj_id > 0. That approach wouldn't
> allow the flexibility of having per-argument specifications as your
> proposal to use __ref or __owned suffixes on the names, but that already
> applies to KF_TRUSTED_ARGS as well.
>
> Personally I'm in agreement with Alexei that it's not a user friendly
> API to use suffixes in the name like this. If we want to allow kfunc
> authors to have per-argument specifiers, using compiler attributes
> and/or some kind of tagging is probably the way to do it?

Sadly GCC doesn't support BTF tags. So this is the next best tagging approach.

There was also another horrendous proposal from me to add flags to each argument:
https://gist.github.com/kkdwivedi/7839cc9e4f002acc3e15350b1b86c88c#file-kfunc-arg-patch-L137

>
> My proposal for now is to add a new KF_OWNED_ARGS flag, and to very
> clearly document exactly what that and KF_TRUSTED_ARGS implies for
> kfuncs. Later on, we could explore solutions for having per-arg
> specifiers. What do you and Alexei think?

Based on your proposal above:

For KF_OWNED_ARGS, any PTR_TO_BTF_ID should have non-zero ref_obj_id, for
KF_TRUSTED_ARGS there will be no such condition. Otherwise they will be the
same. Then switch all CT helpers to KF_OWNED_ARGS.

This should work fine.
