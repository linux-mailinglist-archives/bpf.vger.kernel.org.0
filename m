Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80DB6AB392
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 00:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCEXtd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Mar 2023 18:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCEXtc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Mar 2023 18:49:32 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956339760
        for <bpf@vger.kernel.org>; Sun,  5 Mar 2023 15:49:31 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so7295909pja.5
        for <bpf@vger.kernel.org>; Sun, 05 Mar 2023 15:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M99G1o1JwzDJuCIhUmtJy0l/gbf/M4d85C50C2Y1aVA=;
        b=FM9uwPX5ZwYhSJREeVM1dBmO+z/KsFQPvCkO2smMpN5bTkTTbyZvRRtkKwQD035cA+
         tYE97n+tgoLiAAVHYhGBH93ma3rX/GvXKZSfF+kO7CzDVE+zDl4akQcOsY9B6jaCBZmw
         e2eZnHxTWqxkpz1LOjFoiPILCq0cx8xYEnEEZnBJIqQzPLJHz8HdWuK8sarrBQJuzOwB
         SdDICa2Q348+kOJGYJKkZxnav58ERiHzbDHVyvhrUIbx6QKeuEAuhWy1TqsFBVojmNZL
         JW4Pnyr8VxotAOO18qMzhKjFFltNyrqpYi/mCQk/3WKL+dr3WODAn4dPArkShHI/YyrO
         Lb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M99G1o1JwzDJuCIhUmtJy0l/gbf/M4d85C50C2Y1aVA=;
        b=iiVaCD+9Z/UW1DloIBrVEDygA65tVlv2rbe044xOwIheBleOUFDXRU+xr/Jhbm+kca
         UCBMC4fUsEVN7eYQn60V5jRKIlB+UoaVeKYSEFF9ukFk4VHt3BjCR6AiiirclZC6iO2R
         TaZWDNx+pPbgVGWc3lkra/1JvHyiA4uhClR1HG91Zz0G2q672VztTH28gP+hwvZY8eVf
         WrQD6bDVcybeMsLZs7UcOKzIVxU5op5vQS6+94WlvjlrAjQ/VyWrZF60utVYgglIzzSc
         aIT3u2kusa75yeCp2sPfu47jClB4CBHuIOLKy4UZQzkilOZZNaNgRZ8EFEzk3LajWN0X
         3o+g==
X-Gm-Message-State: AO0yUKUKfUFgwkEdwkQV3ZlSBM70cowSL4Bz01VvtW7adkGlZU4Q6IKB
        hDeQFoL0sz2HklJcS37i24E=
X-Google-Smtp-Source: AK7set/xMMJDTNsWUwPhCP5NFsjhslRWmKKrWlW6Q9nKnfYMhWxgMNyKBDCyzr2Rqd+JsfecOUD8vw==
X-Received: by 2002:a17:90b:314a:b0:237:85fd:e0b0 with SMTP id ip10-20020a17090b314a00b0023785fde0b0mr9639935pjb.29.1678060170939;
        Sun, 05 Mar 2023 15:49:30 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:400::5:59fc])
        by smtp.gmail.com with ESMTPSA id y20-20020a17090aca9400b0023317104415sm6587275pjt.17.2023.03.05.15.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 15:49:30 -0800 (PST)
Date:   Sun, 5 Mar 2023 15:49:28 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 14/17] bpf: implement number iterator
Message-ID: <20230305234928.pjamx2zrssdmeq64@MacBook-Pro-6.local>
References: <20230302235015.2044271-1-andrii@kernel.org>
 <20230302235015.2044271-15-andrii@kernel.org>
 <20230304202143.6d7dif64nhybxf6h@MacBook-Pro-6.local>
 <CAEf4BzbNc24jVa5LG8Qag7wDWf-MCa+x4Gu6ecJw4tfRu-tyNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbNc24jVa5LG8Qag7wDWf-MCa+x4Gu6ecJw4tfRu-tyNA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 04, 2023 at 03:27:57PM -0800, Andrii Nakryiko wrote:
> On Sat, Mar 4, 2023 at 12:21 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Mar 02, 2023 at 03:50:12PM -0800, Andrii Nakryiko wrote:
> > >
> > >  static enum kfunc_ptr_arg_type
> > > @@ -10278,7 +10288,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
> > >                       if (is_kfunc_arg_uninit(btf, &args[i]))
> > >                               iter_arg_type |= MEM_UNINIT;
> > >
> > > -                     ret = process_iter_arg(env, regno, insn_idx, iter_arg_type,  meta);
> > > +                     if (meta->func_id == special_kfunc_list[KF_bpf_iter_num_new] ||
> > > +                         meta->func_id == special_kfunc_list[KF_bpf_iter_num_next]) {
> > > +                             iter_arg_type |= ITER_TYPE_NUM;
> > > +                     } else if (meta->func_id == special_kfunc_list[KF_bpf_iter_num_destroy]) {
> > > +                             iter_arg_type |= ITER_TYPE_NUM | OBJ_RELEASE;
> >
> > Since OBJ_RELEASE is set pretty late here and kfuncs are not marked with KF_RELEASE,
> > the arg_type_is_release() in check_func_arg_reg_off() won't trigger.
> 
> yeah, I had troubles with doing this release using existing scheme.
> KF_RELEASE doesn't work, as it makes some extra assumptions about what
> was acquired, it didn't fit iters. And I didn't have a precedent in
> dynptr to learn from, as RINGBUF dynptr is "acquired" and "released"
> using helper. Basically, we don't have dynptr release kfunc yet.
> 
> So I set the OBJ_RELEASE flag for process_iter_arg to do an explicit release.
> 
> I'd appreciate guidance on how to do this cleaner. Naive attempt to
> set KF_ACQUIRE for bpf_iter_num_new() and KF_RELEASE for
> bpf_iter_num_destroy() didn't work.

yep. KF_ACQUIRE and KF_RELEASE don't fit here, since they need the register
to be ref_obj_id-ed while here it's in the stack.

The current patch is fine. We can generalize iter and dynptr later in the follow up.

> 
> > So I'm confused why there is:
> > +               if (arg_type_is_iter(arg_type))
> > +                       return 0;
> > in the previous patch.
> > Will it ever trigger?
> 
> maybe not, just followed what dynptr is doing
> 
> >
> > Separate question: What happens when the user does:
> > bpf_iter_destroy(&it);
> > bpf_iter_destroy(&it);
> 
> After the first destroy stack slots are marked STACK_INVALID, so next
> bpf_iter_destroy(&it) will complain about not seeing the initialized
> iterator.
> 
> >
> > +               if (!is_iter_reg_valid_init(env, reg)) {
> > +                       verbose(env, "expected an initialized iter as arg #%d\n", regno);
> > will trigger, right?
> > I didn't find such selftest.
> 
> yep, that's the idea, I just checked, I do have such test, it's in
> iters_state_safety.c:
> 
> __failure __msg("expected an initialized iter as arg #1")
> int double_destroy_fail(void *ctx)

See it now. Thanks for checking.

> There is also next_after_destroy_fail, next_without_new_fail, and
> other obvious error conditions. But it would be good for few people to
> check that with a fresh eye. I added them a long time ago, and might
> have missed something.
