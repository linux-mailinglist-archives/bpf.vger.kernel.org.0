Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFF7604F00
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 19:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJSRj0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 13:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiJSRjM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 13:39:12 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5CF18DA81;
        Wed, 19 Oct 2022 10:39:07 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id c23so12157475qtw.8;
        Wed, 19 Oct 2022 10:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5pvAQgJ96dxeHj5+uJpoX/J6WK/eduY3+8IqtGRW+c=;
        b=065YCMGvoTQheRPeakGi2YFd3Uk0V45xjn+RBqG3xky2b3OJSB8BA8/CKEz/1a5kGy
         G5BzAjsHx5+tDom8+AGqf77M4LUzW+5GDuNooWURoGJ8SkB+98WVAnMGq9Pxkj78k7Ka
         6eMXtMJvbUJu6JKzBxiwUiPjxqTw1W2UCKx0bFvV6mbpEtNalxQqNjunxM7xzNgdzJkj
         EhrnL/DdSkjqJNFc9Md2K/GB48k/wHlxXKQvJzkuW40eCXJGrqd3ia4Crz4ojaT/pmHH
         Qpll/tjAs8lg2rM9aT7XFHPnLtl9VSH6PZxMeLwW7/awwjyhQ8/4jUxqMk05VYRqk0bL
         aR+Q==
X-Gm-Message-State: ACrzQf2rESmsEVsyMCsr45bxTZ4hW1bGtrL05RQeKd+FYJs0M1jA6T53
        UCEG34+bDYrzO4sbzNcpNkkYhst7lKvDgw==
X-Google-Smtp-Source: AMsMyM72bIsgp1R/MWzE/YWqOF0QDPL2BhXM0DCVPQqk5z1Pj4WOdsohuvyenu1mnQ3Ju3wKLOTv0Q==
X-Received: by 2002:ac8:7f83:0:b0:39c:ee3e:c6d3 with SMTP id z3-20020ac87f83000000b0039cee3ec6d3mr7314062qtj.444.1666201144826;
        Wed, 19 Oct 2022 10:39:04 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::e12b])
        by smtp.gmail.com with ESMTPSA id h10-20020ac8744a000000b0039953dcc480sm4303094qtr.88.2022.10.19.10.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 10:39:03 -0700 (PDT)
Date:   Wed, 19 Oct 2022 12:39:05 -0500
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, tj@kernel.org, memxor@gmail.com
Subject: Re: [PATCH v5 3/3] bpf/selftests: Add selftests for new task kfuncs
Message-ID: <Y1A2OUuUn4z/Du+j@maniforge.dhcp.thefacebook.com>
References: <20221014212133.2520531-1-void@manifault.com>
 <20221014212133.2520531-4-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014212133.2520531-4-void@manifault.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 18, 2022 at 07:23:23AM +0530, Kumar Kartikeya Dwivedi wrote:

Note: I'm responding to Kumar's email from v3 [0] here on v5 instead,
per his request on [1].

[0]: https://lore.kernel.org/all/CAP01T77PTK+bD2mBrxJShKNPhEypT2+nSHcr3=uuJbrghv_wFg@mail.gmail.com/
[1]: https://lore.kernel.org/all/CAP01T747PKC2jySOZCWu_gauHbBfaj4JE=hbtm4Z4C-Y8b3ZHg@mail.gmail.com/

My apologies again for the silly mistakes and having to send multiple
versions of the patch set.

> On Sat, 15 Oct 2022 at 01:45, David Vernet <void@manifault.com> wrote:
> >
> > A previous change added a series of kfuncs for storing struct
> > task_struct objects as referenced kptrs. This patch adds a new
> > task_kfunc test suite for validating their expected behavior.
> >
> > Signed-off-by: David Vernet <void@manifault.com>
> > ---
> > [...]
> > +
> > +SEC("tp_btf/task_newtask")
> > +int BPF_PROG(task_kfunc_acquire_trusted_nested, struct task_struct *task, u64 clone_flags)
> > +{
> > +       struct task_struct *acquired;
> > +
> > +       if (!is_test_kfunc_task())
> > +               return 0;
> > +
> > +       /* Can't invoke bpf_task_acquire() on a trusted pointer at a nonzero offset. */
> > +       acquired = bpf_task_acquire(task->last_wakee);
>
> The comment is incorrect, that would be &task->last_wakee instead,
> this is PTR_TO_BTF_ID | PTR_NESTED.

Well, it's a nonzero offset from task. But yes, to your point, it's a
misleading comment because the offset is 0 in the verifier. I'll
rephrase this to reflect that it's a nested pointer (or a walked
pointer, whatever nomenclature we end up going with).

> > +       if (!acquired)
> > +               return 0;
> > +       bpf_task_release(acquired);
> > +
> > +       return 0;
> > +}
> > +
> > [...]
> > +
> > +static int test_acquire_release(struct task_struct *task)
> > +{
> > +       struct task_struct *acquired;
> > +
> > +       acquired = bpf_task_acquire(task);
>
> Unfortunately a side effect of this change is that now since
> PTR_TO_BTF_ID without ref_obj_id is considered trusted, the bpf_ct_*
> functions would begin working with tp_btf args. That probably needs 
> be fixed so that they reject them (ideally with a failing test case to
> make sure it doesn't resurface), probably with a new suffix __ref/or
> __owned as added here [0].
>
> Alexei, since you've suggested avoiding adding that suffix, do you see
> any other way out here?
> It's questionable whether bpf_ct_set_timeout/status should work for CT
> not owned by the BPF program.
>
>   [0]: https://lore.kernel.org/bpf/dfb859a6b76a9234baa194e795ae89cb7ca5694b.1662383493.git.lorenzo@kerne

Ah, yeah, it makes sense that some kfuncs really should only ever be
passed an object if the program owns a reference on it. Specifically for
e.g. bpf_ct_set_timeout/status() as you point out, which should only be
passed a struct nf_conn__init that was allocated by bpf_skb_ct_alloc().

It'd be nice if we could just add another flag like KF_REFERENCED_ARGS
or KF_OWNED_ARGS, which would allow a subset of arguments affored by
KF_TRUSTED_ARGS, only those with ref_obj_id > 0. That approach wouldn't
allow the flexibility of having per-argument specifications as your
proposal to use __ref or __owned suffixes on the names, but that already
applies to KF_TRUSTED_ARGS as well.

Personally I'm in agreement with Alexei that it's not a user friendly
API to use suffixes in the name like this. If we want to allow kfunc
authors to have per-argument specifiers, using compiler attributes
and/or some kind of tagging is probably the way to do it?

My proposal for now is to add a new KF_OWNED_ARGS flag, and to very
clearly document exactly what that and KF_TRUSTED_ARGS implies for
kfuncs. Later on, we could explore solutions for having per-arg
specifiers. What do you and Alexei think?
