Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3546522432
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 20:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348991AbiEJSg6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 14:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348981AbiEJSg5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 14:36:57 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FB25534F
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 11:36:55 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d5so25013399wrb.6
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 11:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o3DuZ6qMz/zwur/XREOAPzrxtrhGwT4mYkZCOIIgE34=;
        b=WuHN5uHfYZAEE44qYg/3gHrDYCuYzwfu4xNG6V/Zli6CdrZFKQs64WVQEKWSplNQWr
         n8LTONmYEdFhQr80eHUqicHY0F7KIyV9I6eytS4eIB2kbllV3FoHgnqv2JZ3QUbo9pqM
         +yM5oaOfkvFmkC+Qdp4sevWhPH5KsMkvW4Bjd4X7ksx4LwclFy19gupcY7cFHeKQWOlk
         XoyN5NTwbGfFVXSP1eGuJCbsfhL1nWx7LP2IxcKd3XCGVdDM2Z80UDhq/qt9sZuFwyKo
         8BdnKJbzrJGC7LMInRLmjjoK5jNWC1i47zYKCcrZdPpq30LOSlVGfxVYgElsBoVJVAdZ
         7OYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o3DuZ6qMz/zwur/XREOAPzrxtrhGwT4mYkZCOIIgE34=;
        b=Es/axBQTpvIiRySZDRBJKBjHDk9aUomXh04bfFwHoy0RLQM4TmD6eRhLLht4nEI8/D
         IYrwGXPaME4hA3X5C5znnukjp0okataF986nmJkak6heVknBGQAnlaULS4Rar7xz171+
         jtl9iKyxS9F/2DFj2T7GoGPkYBXuAoLok5uiAFysgUDrcEb5hKUNXL7+DQ9ISm0gAQn3
         Wtz358DZyaqk2RatMxtoLiz6/nnHIPepCZVEzEPq4IPlNhKtPeKlp5oSFPFGC5P/ud3b
         UfB0mB2Niv7nIKDbwmwjLC+dkdZAtBwb2v8NPh1Xc0OgSdqZnM4hYQWGLJZ2OaL0aoo4
         ZD3A==
X-Gm-Message-State: AOAM5322AIEL1X9xNmbXoAW1fyhwQ+2rgoQPYPwDAzhBoAsfOz36wpuR
        PphgG41lfOS8DDMEltKBVEhfqa3nL1tx5NEWzNl4BQ==
X-Google-Smtp-Source: ABdhPJxI7a1Dw+ppNRDkdyvyzx0PfB9kRBRoWn3TqRmzZ+lYFRCytup5d/cNBSwLstiihoyHtEis/fPtivJkPuNCUYA=
X-Received: by 2002:adf:fb05:0:b0:20a:e113:8f3f with SMTP id
 c5-20020adffb05000000b0020ae1138f3fmr20156028wrr.534.1652207813729; Tue, 10
 May 2022 11:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220510001807.4132027-1-yosryahmed@google.com>
 <20220510001807.4132027-7-yosryahmed@google.com> <YnqwFuhncWiR3rjq@slm.duckdns.org>
In-Reply-To: <YnqwFuhncWiR3rjq@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 10 May 2022 11:36:17 -0700
Message-ID: <CAJD7tkb_fP=qTQRR7Os1UXSqFQvCEX+GYA9QHvbcoXyW1Kq48Q@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 6/9] cgroup: add v1 support to cgroup_get_from_id()
To:     Tejun Heo <tj@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 10, 2022 at 11:34 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Tue, May 10, 2022 at 12:18:04AM +0000, Yosry Ahmed wrote:
> > The current implementation of cgroup_get_from_id() only searches the
> > default hierarchy for the given id. Make it compatible with cgroup v1 by
> > looking through all the roots instead.
> >
> > cgrp_dfl_root should be the first element in the list so there shouldn't
> > be a performance impact for cgroup v2 users (in the case of a valid id).
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  kernel/cgroup/cgroup.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > index af703cfcb9d2..12700cd21973 100644
> > --- a/kernel/cgroup/cgroup.c
> > +++ b/kernel/cgroup/cgroup.c
> > @@ -5970,10 +5970,16 @@ void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
> >   */
> >  struct cgroup *cgroup_get_from_id(u64 id)
> >  {
> > -     struct kernfs_node *kn;
> > +     struct kernfs_node *kn = NULL;
> >       struct cgroup *cgrp = NULL;
> > +     struct cgroup_root *root;
> > +
> > +     for_each_root(root) {
> > +             kn = kernfs_find_and_get_node_by_id(root->kf_root, id);
> > +             if (kn)
> > +                     break;
> > +     }
>
> I can't see how this can work. You're smashing together separate namespaces
> and the same IDs can exist across multiple of these hierarchies. You'd need
> a bigger surgery to make this work for cgroup1 which would prolly involve
> complications around 32bit ino's and file handle support too, which I'm not
> likely to ack, so please give it up on adding these things to cgroup1.
>
> Nacked-by: Tejun Heo <tj@kernel.org>
>
> Thanks.

Completely understandable. I sent this patch knowing that it likely
will not be accepted, with hopes of hearing feedback on whether this
can be done in a simple way or not. Looks like I got my answer, so
thanks for the info!

Will drop this patch in the incoming versions.

>
> --
> tejun
