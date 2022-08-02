Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F63587DC2
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 16:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbiHBOAd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 10:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbiHBOAc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 10:00:32 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7249B60D9
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 07:00:30 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id o2so10672240iof.8
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 07:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zd4r9SeXffk+87diLuKADA2NdLWh63QnM3k5QDeZ2WE=;
        b=nlrUnT3M66CfUhk+TWTEBsQnPQLZfvQ21zDLcBo/Eldc57L1m+HM6KyXy4aIOxtCTS
         IERecIHMhl7L/P6SFePv2qlOPWFP7QvhiPYNvIvuhVNbTFWQl/6DxGz0BZE0zYA4EBXF
         QHh0xnDrHGftuqV30quR1TH4WSIeAp0XrFDQwO7jk4/0mA9qJwN4MMCaA/5DODjbTSAj
         B5qYZXkNrsBHcuN6eoSNClOw7YB54qKDAxKHN1VXhNf5P7HwUE66MYyr8qdG84s54VrX
         syREGu2vYNcIJCrsKTxa6AJgeTOIx64XEc9ntf1uBywjJfxaPNwIdSt21SAFD5OF0xhI
         Ktjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zd4r9SeXffk+87diLuKADA2NdLWh63QnM3k5QDeZ2WE=;
        b=VBC6FcRUbMwU+L3hnYCQyWkrngwEcvgVKYK83rPWc1xbJruAGz0ST9a33gqzDEi64I
         TFLK8+d0Z3hztbOQI4we5/B4npIZARY0QWmLP2nHml6O7Bywg/udV9Z0a9n0ndpTUM5o
         ACoD/zm1AHFH8QFGbwfh4VLHpmnf968jLFHnHRDgdffWdGGkFBURNCFODnIuUSs1BhqM
         kuNI8uMDEMGzGLm5Yam3CIu3j7XAkrpkdDJNTjZQ7aEI2KXSePbmuV/+pyXT2L+zCMfn
         wvT2zXemEj7FWpXS8CBYFtrDCJudoo+vML1jxFGqVNdb+VNv4RVtp3qokhTYzG/LAzxg
         BNTQ==
X-Gm-Message-State: AJIora9hpX/eI5fKWHk38KgptvH+dz5L0sEnODvBtm8A8gEcW4xxcZNr
        nGzeZpW0YPB9fl2ZWiEqwW9+TzysbWZuXOpypxXtIGer
X-Google-Smtp-Source: AGRyM1tgrz872UvjXNQkdimxGTAigFa0/3tZW5j7pLPl/8XprC0bs8YkD3c09NEOZZouJwvgdiQmjH0l+LnNOe/cNUk=
X-Received: by 2002:a05:6638:238d:b0:341:4c3d:a923 with SMTP id
 q13-20020a056638238d00b003414c3da923mr8204816jat.124.1659448829715; Tue, 02
 Aug 2022 07:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
 <20220722183438.3319790-6-davemarchevsky@fb.com> <61209d3a-bc15-e4f2-9079-7bdcfdd13cd0@fb.com>
In-Reply-To: <61209d3a-bc15-e4f2-9079-7bdcfdd13cd0@fb.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 2 Aug 2022 15:59:53 +0200
Message-ID: <CAP01T74O+CS0VCXq9U7wyPvxTDdBr7ev0Oo-79ZcnkH6hagMcA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 05/11] bpf: Add bpf_spin_lock member to rbtree
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        "toke@redhat.com" <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2 Aug 2022 at 00:23, Alexei Starovoitov <ast@fb.com> wrote:
>
> On 7/22/22 11:34 AM, Dave Marchevsky wrote:
> > This patch adds a struct bpf_spin_lock *lock member to bpf_rbtree, as
> > well as a bpf_rbtree_get_lock helper which allows bpf programs to access
> > the lock.
> >
> > Ideally the bpf_spin_lock would be created independently oustide of the
> > tree and associated with it before the tree is used, either as part of
> > map definition or via some call like rbtree_init(&rbtree, &lock). Doing
> > this in an ergonomic way is proving harder than expected, so for now use
> > this workaround.
> >
> > Why is creating the bpf_spin_lock independently and associating it with
> > the tree preferable? Because we want to be able to transfer nodes
> > between trees atomically, and for this to work need same lock associated
> > with 2 trees.
>
> Right. We need one lock to protect multiple rbtrees.
> Since add/find/remove helpers will look into rbtree->lock
> the two different rbtree (== map) have to point to the same lock.
> Other than rbtree_init(&rbtree, &lock) what would be an alternative ?
>

Instead of dynamically associating locks with the rbtree map, why not
have lock embedded with the rbtree map, and construct a global locking
order among rbtree maps during prog load time that the verifier
maintains globally.

Prog A always takes rb_mapA.lock, then rb_mapB.lock,
If we see Prog B being loaded and it takes them in opposite order, we
reject the load because it can lead to ABBA deadlock. We also know the
map pointer statically so we ensure rb_mapA.lock cannot be called
recursively.

Everytime a prog is loaded, it validates against this single list of
lock orders amongst maps. Some of them may not have interdependencies
at all. There is a single total order, and any cycles lead to
verification failure. This might also work out for normal
bpf_spin_locks allowing us to take more than 1 at a time.

Then you can do moves atomically across two maps, by acquiring the
locks for both. Maybe we limit this to two locks for now only. There
could also be a C++ style std::lock{lock1, lock2} helper that takes
multiple locks to acquire in order, if you want to prevent anything
from happening between those two calls; just an idea.

Probably need to make rb_node add/find helpers notrace so that the bpf
program does not invoke lock again recursively when invoked from the
helper.

Then you can embed locked state statically in map pointer reg, and you
don't need to dynamically check whether map is locked. It will be
passed into the helpers, and from there a member offset can be fixed
which indicates whether the map is 'locked'.

If you have already explored this, then please share what the
problems/limitations were that you ran into, or if this is impossible.
It does sound too good to be true, so maybe I missed something
important here.

I was prototyping something similar for the pifomap in the XDP
queueing series, where we were exploring exposing the underlying
locking of the map to the user (to be able to batch insertions to the
map). The major concern was leaking too many implementation details to
the UAPI and locking (pun intended) ourselves out of improvements to
the map implementation later, so we held off on that for now (and also
wanted to evaluate other alternatives before doubling down on it).
