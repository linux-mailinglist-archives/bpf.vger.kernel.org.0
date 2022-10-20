Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCCD60570F
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 07:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJTF6G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 01:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJTF6E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 01:58:04 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912C05755E;
        Wed, 19 Oct 2022 22:58:02 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h185so18287719pgc.10;
        Wed, 19 Oct 2022 22:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=09vKTRnIQaw8/sHmELeReqMFWmzDaItF+VGRYaKT20w=;
        b=Ccn+GD2iWtjOgyuDvCzR+sq57yEJJAPy3rRA9bT1CbeN/chxKFx5lgM9L5DkCvumf2
         RnEVA5Qt7bL2S01wwBuF6VzBgWqLA7srUaF7W8jvyIQCoV9/FTF/9ZAdwjHlxAydXu6c
         NRDURNf17OtO056+7PQkP3QcLt6MVmJMQKzC31H12bldUt/b/CuffPTfRL/RkZny8jK5
         xRentK62TprwuyR/+BxEKmPUdsHloxP5UemZRivlCpxkVCXu0m+CcSf4tCW/MQhoFshV
         qvlJdGPDCD7Dzyz1vXc3cR4EGy7ek5N4UPxx83MYchCWqjKQyKAckS+/l6sEXVfkemk5
         zp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09vKTRnIQaw8/sHmELeReqMFWmzDaItF+VGRYaKT20w=;
        b=gtngMfEhMJjkNph9yfc1JkE7WpxfBh31JhfBK4VLKap/cowEX97LFMpmsAlheGYQVG
         erJv5WAValfpDETR/9LIpVjmRTiB4mYDC8xVFOGeJDVguGbW9eI6B4vAtmPcLTZXokAO
         rujCIbk17dzP4sBEs6KaKnOKqF/6lb4PMWJKLpkztWs7hqfm7Jqu28uee8upb0nkYW12
         DU4Ye45UOyet2Rii6ftoZy54HbrpVrmNOrD4ZIwByrjxY8X9IvQeHIshpFAA/uUHsiY7
         fnIn31HZ/8hzooaqjDe02+a8xk0SjpN9YElBEQInU+1KV+h66VqRJSuGblZt1ISDxjl2
         6xtA==
X-Gm-Message-State: ACrzQf0nPEu2LIByAc0zv+GiSV9amRUiWY9iXOfgC+4ddB3Zv6/1yGOi
        s9KhU84uKAcCNG7hTAFeCgk=
X-Google-Smtp-Source: AMsMyM5WQ/ssBKM+2ov8XqL4/P6ReCNGUqcXYwDHTfL/7KSDkH9zq4VElC1Hw4keDjyFUNiVfR6NPA==
X-Received: by 2002:aa7:8dd5:0:b0:565:d35c:4a5d with SMTP id j21-20020aa78dd5000000b00565d35c4a5dmr12634373pfr.7.1666245481582;
        Wed, 19 Oct 2022 22:58:01 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id w206-20020a627bd7000000b00553d5920a29sm12231786pfc.101.2022.10.19.22.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 22:58:00 -0700 (PDT)
Date:   Thu, 20 Oct 2022 11:27:49 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, tj@kernel.org
Subject: Re: [PATCH v5 1/3] bpf: Allow trusted pointers to be passed to
 KF_TRUSTED_ARGS kfuncs
Message-ID: <20221020055749.33lfipxtaubhnqbv@apollo>
References: <20221014212133.2520531-1-void@manifault.com>
 <20221014212133.2520531-2-void@manifault.com>
 <CAP01T75FGW7F=Ho+oqoC6WgxK5uUir2=CUgiW_HwqNxmzmthBg@mail.gmail.com>
 <Y1BR5c6W4tgljA8q@maniforge.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1BR5c6W4tgljA8q@maniforge.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 20, 2022 at 01:07:09AM IST, David Vernet wrote:
> On Tue, Oct 18, 2022 at 07:02:15AM +0530, Kumar Kartikeya Dwivedi wrote:
> > Please tag the patches with [ PATCH bpf-next ... ] subject prefix.
>
> Sure, will do.
>
> > >  include/linux/bpf.h                          |  6 ++++++
> > >  kernel/bpf/btf.c                             | 11 ++++++++++-
> > >  kernel/bpf/verifier.c                        | 12 +++++++++++-
> > >  tools/testing/selftests/bpf/verifier/calls.c |  4 ++--
> > >  4 files changed, 29 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 9e7d46d16032..b624024edb4e 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -457,6 +457,12 @@ enum bpf_type_flag {
> > >         /* Size is known at compile time. */
> > >         MEM_FIXED_SIZE          = BIT(10 + BPF_BASE_TYPE_BITS),
> > >
> > > +       /* PTR was obtained from walking a struct. This is used with
> > > +        * PTR_TO_BTF_ID to determine whether the pointer is safe to pass to a
> > > +        * kfunc with KF_TRUSTED_ARGS.
> > > +        */
> > > +       PTR_NESTED              = BIT(11 + BPF_BASE_TYPE_BITS),
> > > +
> > >         __BPF_TYPE_FLAG_MAX,
> > >         __BPF_TYPE_LAST_FLAG    = __BPF_TYPE_FLAG_MAX - 1,
> > >  };
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index eba603cec2c5..3d7bad11b10b 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -6333,8 +6333,17 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > >                 /* Check if argument must be a referenced pointer, args + i has
> > >                  * been verified to be a pointer (after skipping modifiers).
> > >                  * PTR_TO_CTX is ok without having non-zero ref_obj_id.
> > > +                *
> > > +                * All object pointers must be refcounted, other than:
> > > +                * - PTR_TO_CTX
> > > +                * - Trusted pointers (i.e. pointers with no type modifiers)
> > >                  */
> > > -               if (is_kfunc && trusted_args && (obj_ptr && reg->type != PTR_TO_CTX) && !reg->ref_obj_id) {
> > > +               if (is_kfunc &&
> > > +                   trusted_args &&
> > > +                   obj_ptr &&
> > > +                   base_type(reg->type) != PTR_TO_CTX &&
> > > +                   type_flag(reg->type) &&
> > > +                   !reg->ref_obj_id) {
> > >                         bpf_log(log, "R%d must be referenced\n", regno);
> > >                         return -EINVAL;
> > >                 }
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 6f6d2d511c06..d16a08ca507b 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -581,6 +581,8 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
> > >                 strncpy(prefix, "user_", 32);
> > >         if (type & MEM_PERCPU)
> > >                 strncpy(prefix, "percpu_", 32);
> > > +       if (type & PTR_NESTED)
> > > +               strncpy(prefix, "nested_", 32);
> > >         if (type & PTR_UNTRUSTED)
> > >                 strncpy(prefix, "untrusted_", 32);
> > >
> >
> > Since these are no longer exclusive, the code needs to be updated to
> > append strings to the prefix buffer.
> > Maybe just using snprintf with %s%s%s.. would be better, passing ""
> > when !(type & flag).
>
> Sure, I can make that change. We'll have to increase the size of the
> prefix string on the stack, but that's hardly problematic as these
> strings are not terribly large.
>
> > > @@ -4558,6 +4560,9 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
> > >         if (type_flag(reg->type) & PTR_UNTRUSTED)
> > >                 flag |= PTR_UNTRUSTED;
> > >
> > > +       /* All pointers obtained by walking a struct are nested. */
> > > +       flag |= PTR_NESTED;
> > > +
> >
> > Instead of PTR_NESTED, how about PTR_WALK?
>
> I don't have a strong preference between either, though I would prefer
> PTR_WALKED if we go with the latter. Does that work for you?
>

Yes, I just think PTR_NESTED is a bit misleading, it's not nested within the old
object, we loaded a pointer from it, it should just indicate that the pointer
came from a walk of a trusted PTR_TO_BTF_ID.

> > > [...]
> > > @@ -5694,7 +5699,12 @@ static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
> > >  static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
> > >  static const struct bpf_reg_types alloc_mem_types = { .types = { PTR_TO_MEM | MEM_ALLOC } };
> > >  static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_TO_MAP } };
> > > -static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
> > > +static const struct bpf_reg_types btf_ptr_types = {
> > > +       .types = {
> > > +               PTR_TO_BTF_ID,
> > > +               PTR_TO_BTF_ID | PTR_NESTED
> > > +       },
> > > +};
> >
> > CI fails, two of those failures are from not updating
> > check_func_arg_reg_off for PTR_TO_BTF_ID | PTR_WALK, and the other one
>
> Gah, I didn't think it was necessary for this case as it's not required
> for btf_check_func_arg_match(), which will eventually just fail in the
> following check:
>
> 	if (!btf_type_is_struct(ref_t)) {
> 		bpf_log(log, "kernel function %s args#%d pointer type %s %s is not support
> 			func_name, i, btf_type_str(ref_t),
> 			ref_tname);
> 		return -EINVAL;
> 	}

Why would it fail there? It will still be a struct type.
I think you misunderstand this a bit.

When you have task from tracing ctx arg:
r1 = ctx;
r1 = *(r1 + ...); // PTR_TO_BTF_ID, task_struct, off=0
// r1 = task->next
r1 = *(r1 + offsetof(task_struct, next)); // PTR_TO_BTF_ID | PTR_WALKED, task_struct, off = 0

We loaded a pointer from task_struct into r1.
Now r1 still points to a task_struct, so that check above won't fail for r1.

>
> Note that we also don't include PTR_TO_BTF_ID | PTR_UNTRUSTED here. The
> difference for PTR_TO_BTF_ID | PTR_WALK(ED) is of course that we also need to
> allow it to work properly for normal helper calls, so I'll make that change.
> Thanks for pointing it out. In general, the whole dance between register base
> types + modifiers sometimes feels like a mine field...
>

Yes, I don't like how it's growing and being mixed either. Eventually I think we
should document what combinations are allowed and reject everything else when
initializing reg->type to prevent bugs, but IDK whether something like this
would be accepted.
