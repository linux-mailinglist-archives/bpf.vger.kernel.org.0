Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1815A1A64
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 22:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiHYUfQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 16:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242755AbiHYUfO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 16:35:14 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7BF81694
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 13:35:12 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id c20so16171492qtw.8
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 13:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=W38//0BN+Mpi0ment/DsNSBH0AG+YpTWl5XPod3ELr0=;
        b=dGjDuNJ77b0qiF7A7XJwWcfiPoVvBgARtQyqNLS8IOmEjPKNCo+Y6HtxCvKY+Ybt9d
         NQX5ik4AKTRY2tR63EXfYAvOIY/tq+aG7/TE2kPhRsXRw9fYhpy9/0bUSsQ/5mjMU8dU
         Gb43y1FYS9WQXZeJSFo9pt1A9Rf2Ho/fK3R61GbJ9sB2+hIaAY8GIig01Rfh6+sEGLIE
         SD747ay13SeKdEJgvPwoRilBilWpdK4MRdDikVgu8HtSBq78DDXkUsrg1JyGujpPZYpI
         FheTBoQejDtki6MVt3z6RV3X0pn5U1SQ3BWgyDLLmkirlx0AYA7czdk5nKNnhh3NOsKz
         A6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=W38//0BN+Mpi0ment/DsNSBH0AG+YpTWl5XPod3ELr0=;
        b=wLk+ljs0X9TOs4pluQN3/125YhiTREU7sgW/iEjMjLc/LFeCP3o6Fc1vO5L+VlrLc5
         XUwzPGaOF7R90Z2KmrWEcGxBHGb9xifmnKEVsypNK2qLGccnYQVPvPcfe0nGgXIwiG/V
         l3YjGLcK8YJeedDHFT23FB4UTKOkYV4r4bP0LB7iVyoejTf4jsubUetwnk7q+4RiM2Pj
         +mgLfIiQNAelRNFhwx0CBTa0BngtPPsOOv/3sdCJI+Zv2NqxYYp7XU+YLx8MOjK642dy
         AAZ9cpACeGORMQeZodNHaAUS3p8Csuf01afVouqmflxu0ZzL1Ij/LqDXezUX/JloI+Qb
         lxtA==
X-Gm-Message-State: ACgBeo0NMzoiggS95mWcC7EJpfq0SJgHc3V/WLvVi95fje1quSWfmlUd
        jzhEv2XWiVXw9WbvJ6QHVvrbdMTm7mtlM3uMQJKEuQ==
X-Google-Smtp-Source: AA6agR4Hs5T238NpECmNZXKSZ/N2q9+IQQdN3rjH+KX3J52d9R1NUUbxYt4bJMUf6oj+LM14J6BhhZHuswOZygRYZJg=
X-Received: by 2002:ac8:7f04:0:b0:343:36d:9a1f with SMTP id
 f4-20020ac87f04000000b00343036d9a1fmr5195675qtk.566.1661459711891; Thu, 25
 Aug 2022 13:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220824030031.1013441-1-haoluo@google.com> <20220824030031.1013441-2-haoluo@google.com>
 <CAEf4BzYfA5uzSVsRXJXKnUQFSD1Wmk29VPge-iEO+Los3e2VOg@mail.gmail.com>
In-Reply-To: <CAEf4BzYfA5uzSVsRXJXKnUQFSD1Wmk29VPge-iEO+Los3e2VOg@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 25 Aug 2022 13:35:01 -0700
Message-ID: <CA+khW7hHA2gjv_UhbyhU8HkFwemt4pARVw+e1SHHOteO60PF1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 1/5] bpf: Introduce cgroup iter
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        KP Singh <kpsingh@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Michal Koutny <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yosry Ahmed <yosryahmed@google.com>
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

On Thu, Aug 25, 2022 at 1:18 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Aug 23, 2022 at 8:01 PM Hao Luo <haoluo@google.com> wrote:
> >
[...]
> >  typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 934a2a8beb87..1c4e1c583880 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -87,10 +87,29 @@ struct bpf_cgroup_storage_key {
> >         __u32   attach_type;            /* program attach type (enum bpf_attach_type) */
> >  };
> >
> > +enum bpf_cgroup_iter_order {
> > +       BPF_ITER_ORDER_UNSPEC = 0,
> > +       BPF_ITER_SELF_ONLY,             /* process only a single object. */
> > +       BPF_ITER_DESCENDANTS_PRE,       /* walk descendants in pre-order. */
> > +       BPF_ITER_DESCENDANTS_POST,      /* walk descendants in post-order. */
> > +       BPF_ITER_ANCESTORS_UP,          /* walk ancestors upward. */
> > +};
>
> just skimming through this, I noticed that we have "enum
> bpf_cgroup_iter_order" (good, I like) but BPF_ITER_xxx with no CGROUP
> part in it (not good, don't like :). All the enumerator names have
> global visibility, so it would probably be best for them to be
> CGROUP-specific and roughly match the enum name itself:
> BPF_CGROUP_ITER_SELF_ONLY, etc?
>

Ack. I will send a patch to fix this right now.
