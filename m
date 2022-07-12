Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF37570F04
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 02:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiGLAma (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 20:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiGLAm3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 20:42:29 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A410B3C8D6
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 17:42:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v14so9056456wra.5
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 17:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=68mkDNBCkeJpX+q116C9yWsW5XjBLSxGi+xt71TSQ28=;
        b=pXcUEGlIhOHDWFHvDN9rRDLyJeDZML22bbC8eiEGLCy/l4q3ub47IwesxJKljkqfb8
         nHo/r/cp9kyG8mZVZTNOAx4hzS3GaEjcvicCDoe02fE9FolqPAKFuY8Yz4hOx4lEEI+B
         vs5VuZWfB+WFXaL8jLSq4cjzTVtlNJI1bco7XI+5d7o+6Nrc35e3zlx/La0iy33o4aQB
         s4CD0WymQMmITSwJOIiWAIaFjB08hdaj5K8yBVWYxR1oYSeGBMLeY66fr2CPeR5SUtQz
         FqjKBS1ff2f/3D3pFF/1j0RLdvML2qQgm8bFuhL1eit5NdIkvBO5vNiChDWEJL0ialM5
         ooNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=68mkDNBCkeJpX+q116C9yWsW5XjBLSxGi+xt71TSQ28=;
        b=C5jRdUoTlPx/ftmtBCiwJRGmXKK43OByC7v6nkFbWnH41TIZ4WsCJ2Jd+pEIU9XcoR
         bLks7h5/3e8pVSjS4IlnltdRcjxAIanoCs170QJBnlcsmNoPJQkr7oxpWqSKVnHWkZcu
         zL1HqGMMPAx73D5bPYyb90cI7sGhPjwRzRMNY4GkLSre7h+IxxrbclfXNnG+yjyUf+jl
         rFjwYRaWf7pJN5M1XuDDcI1eth/7hP5zNQ6fQDvzeLRfk4F9EG+pIVkHpDjYM3cNMDtt
         PgjNOgfPOMgwnbLP7EDaY7MCQw5wvNeB7yHUuLAudi5VWZxx+de+SffFLCUYyDsvdPVt
         OJBg==
X-Gm-Message-State: AJIora9y6ts45YZ+//O3xOlM5hUTN/PPvouj0ZOsqSr+5oYdx3VQqAgQ
        00WkBpsPZX10bruKgim55rFhdl6Q92R1ILI+OVl2WQ==
X-Google-Smtp-Source: AGRyM1vG+ARZBV1wm38rCAdOILOvGSx+zc1YknhjkS5MwV6FG/E/u1kTVqKLbrKORItVEO9bU5e9GK6Ocet1qyOUDBs=
X-Received: by 2002:a5d:59a8:0:b0:21d:8a9d:732b with SMTP id
 p8-20020a5d59a8000000b0021d8a9d732bmr19203014wrr.28.1657586546036; Mon, 11
 Jul 2022 17:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220709000439.243271-1-yosryahmed@google.com>
 <20220709000439.243271-5-yosryahmed@google.com> <370cb480-a427-4d93-37d9-3c6acd73b967@fb.com>
 <a6d048b8-d017-ea7e-36f0-1c4f88fc4399@fb.com>
In-Reply-To: <a6d048b8-d017-ea7e-36f0-1c4f88fc4399@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 11 Jul 2022 17:42:14 -0700
Message-ID: <CA+khW7gmVmXMg4YP4fxTtgqNyAr4mQqnXbP=z0nUeQ8=hfGC3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/8] bpf: Introduce cgroup iter
To:     Yonghong Song <yhs@fb.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org
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

On Mon, Jul 11, 2022 at 4:20 PM Yonghong Song <yhs@fb.com> wrote:
>
> On 7/10/22 5:19 PM, Yonghong Song wrote:
> >
> >
[...]
> >> +
> >>   union bpf_iter_link_info {
> >>       struct {
> >>           __u32    map_fd;
> >>       } map;
> >> +
> >> +    /* cgroup_iter walks either the live descendants of a cgroup
> >> subtree, or the ancestors
> >> +     * of a given cgroup.
> >> +     */
> >> +    struct {
> >> +        /* Cgroup file descriptor. This is root of the subtree if for
> >> walking the
> >> +         * descendants; this is the starting cgroup if for walking
> >> the ancestors.
> >
> > Adding comment that cgroup_fd 0 means starting from root cgroup?

Sure.

> > Also, if I understand correctly, cgroup v1 is also supported here,
> > right? If this is the case, for cgroup v1 which root cgroup will be
> > used for cgroup_fd? It would be good to clarify here too.
> >

IMO, the case of cgroup_fd = 0 combined with cgroup v1 should return
errors. It's an invalid case. If anyone wants to use cgroup_iter on
cgroup v1 hierarchy, they could explicitly open the subsystems' root
directory and pass the fd. With that said, Yosry and I will test and
confirm the behavior in this situation and clarify in the comment.
Thanks for pointing this out.

> >> +         */
> >> +        __u32    cgroup_fd;
> >> +        __u32    traversal_order;
> >> +    } cgroup;
> >>   };
> >>   /* BPF syscall commands, see bpf(2) man-page for more details. */
> >> @@ -6134,6 +6151,10 @@ struct bpf_link_info {
> >>                   struct {
> >>                       __u32 map_id;
> >>                   } map;
> >> +                struct {
> >> +                    __u32 traversal_order;
> >> +                    __aligned_u64 cgroup_id;
> >> +                } cgroup;
> >
> > We actually has a problem here although I don't have a solution yet.
> >
[...]
> >
> > There is a 4 byte hole after member 'target_name_len'. So map_id will
> > have a offset 16 from the start of structure 'iter'.
> >
> >
> > This will break uapi. We probably won't be able to change the existing
> > uapi with adding a ':32' after member 'target_name_len'. I don't have
> > a good solution yet, but any suggestion is welcome.
> >
> > Also, for '__aligned_u64 cgroup_id', '__u64 cgroup_id' is enough.
> > '__aligned_u64' mostly used for pointers.
>
> Briefly discussed with Alexei, the following structure iter definition
> should work. Later on, if we need to addition fields for other iter's,
> for a single __u32, the field can be added to either the first or the
> second union. If fields are more than __u32, they can be placed
> in the second union.
>
>                  struct {
>                          __aligned_u64 target_name; /* in/out:
> target_name buffer ptr */
>                          __u32 target_name_len;     /* in/out:
> target_name buffer len */
>                          union {
>                                  struct {
>                                          __u32 map_id;
>                                  } map;
>                          };
>                          union {
>                                  struct {
>                                          __u64 cgroup_id;
>                                          __u32 traversal_order;
>                                  } cgroup;
>                          };
>                  } iter;
>

Thanks Yonghong for seeking the solution here. The solution looks
good. I'm going to put your heads-up as comments there. One thing I'd
like to confirm, when we query bpf_link_info for cgroup iter, do we
also need to zero those fields for map_elem?

>
> >
> >
> >>               };
> >>           } iter;
> >>           struct  {
[...]
> >> +
> >> +static void *cgroup_iter_seq_start(struct seq_file *seq, loff_t *pos)
> >> +{
> >> +    struct cgroup_iter_priv *p = seq->private;
> >> +
> >> +    mutex_lock(&cgroup_mutex);
> >> +
> >> +    /* support only one session */
> >> +    if (*pos > 0)
> >> +        return NULL;
> >
> > This might be okay. But want to check what is
> > the practical upper limit for cgroups in a system
> > and whether we may miss some cgroups. If this
> > happens, it will be a surprise to the user.
> >

Ok. What's the max number of items supported in a single session?

> >> +
> >> +    ++*pos;
> >> +    p->terminate = false;
> >> +    if (p->order == BPF_ITER_CGROUP_PRE)
> >> +        return css_next_descendant_pre(NULL, p->start_css);
> >> +    else if (p->order == BPF_ITER_CGROUP_POST)
> >> +        return css_next_descendant_post(NULL, p->start_css);
> >> +    else /* BPF_ITER_CGROUP_PARENT_UP */
> >> +        return p->start_css;
> >> +}
> >> +
> >> +static int __cgroup_iter_seq_show(struct seq_file *seq,
> >> +                  struct cgroup_subsys_state *css, int in_stop);
> >> +
> >> +static void cgroup_iter_seq_stop(struct seq_file *seq, void *v)
> >> +{
> >> +    /* pass NULL to the prog for post-processing */
> >> +    if (!v)
> >> +        __cgroup_iter_seq_show(seq, NULL, true);
> >> +    mutex_unlock(&cgroup_mutex);
> >> +}
> >> +
> > [...]
