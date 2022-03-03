Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7664CC869
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 22:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiCCVxM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 16:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbiCCVxL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 16:53:11 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E44B75E60
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 13:52:25 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id jr3so5210551qvb.11
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 13:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1gQFOw2v5w6RQvzg/9d3ch6fsGJuXS0mE7iiujRgGMs=;
        b=UTHTLApf8U1Q5liu+aMqL2YQ1hD7ngEAPhc1jjOmWdIzBvNnASnAjlH3Sgx5jxUFwI
         /IYQ4sK9YBt0hqBHJRD77C61KNSp+Mkr9EYIa6DmnL8ePwcRS6Q1Lwk8dMZ/y0EYJSjo
         lpcKL5PR1PygrzHV4xqH4bbZ8GC5vBaSgrgU/2CqrC1+xW4TiAx2JxDqr3CW+fNqNC6O
         mcTCk6MWB1ikOCxgYYZOIyy/Cw33u54KCSs1bU3fRUlnCck5L/ZXDl1GQjzroIHuSW7l
         tjKr7lAqOERcGLqjAdZtZNtMaiCpw9AB8NnACX8XNsJnoBfzb7jQYFwssJbPqMfs5rV4
         Fvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1gQFOw2v5w6RQvzg/9d3ch6fsGJuXS0mE7iiujRgGMs=;
        b=chpsyYVEFJwAu249mGbdfb2nUVVhqF0Zr3hdNesQoognsWOvtzqg9nj2vLuCX5hzqs
         aPu/j1jiXmaiC0mcA+nHvjCZXGBkoSV3WnRKjhKSPWi+uLOmjuBeRU7tJ1faelAbGZ9P
         nOPpNSikuZNM6c2H1teUqbJFQ2AH1OfO2E+bGPLcWymJqXmYj24cBou0ybDDG8hazrOv
         QNnZZkReCBbGVozfn/THevUa5pBnndgzmdrQ2sgAOWimJX8sMES1JgFAt2SelesMnIdR
         9Ljyf2VNRmOp5OlcTJ3CGHnWJ4nwLKVyOifrrnT6vKaKykW0OToLoW/vcL1+I9Nl4oJo
         lTtA==
X-Gm-Message-State: AOAM532M8em1TSNMC6oKq3PLk+DgFvAz4VHFsD3XRJLwgwjreg1OxASR
        ZcW+CWkDxllUcgTouq9tdKeyrz7sVx3eVPHVr2maNA==
X-Google-Smtp-Source: ABdhPJwrQqZzUcoHi/wGP1Rk6z4Y//Ln4C6/4fFgYJ+c6veDUb9AznEgJuFuj6FgpuVvChiswcTXktvUzsOcPJvSeQA=
X-Received: by 2002:a05:6214:202f:b0:432:4810:1b34 with SMTP id
 15-20020a056214202f00b0043248101b34mr25772922qvf.35.1646344344193; Thu, 03
 Mar 2022 13:52:24 -0800 (PST)
MIME-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com> <20220225234339.2386398-9-haoluo@google.com>
 <20220302224506.jc7jwkdaatukicik@apollo.legion> <f780fc3a-dbc2-986c-d5a0-6b0ef1c4311f@fb.com>
 <20220303030349.drd7mmwtufl45p3u@apollo.legion> <ee991731-0e85-23be-2720-2d641704dcf9@fb.com>
In-Reply-To: <ee991731-0e85-23be-2720-2d641704dcf9@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 3 Mar 2022 13:52:12 -0800
Message-ID: <CA+khW7iDHeVW+gMk16mSKu=wSVMPR5ovgxKFDA+XqKCr8cYKeg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 8/9] bpf: Introduce cgroup iter
To:     Yonghong Song <yhs@fb.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 2, 2022 at 11:34 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 3/2/22 7:03 PM, Kumar Kartikeya Dwivedi wrote:
> > On Thu, Mar 03, 2022 at 07:33:16AM IST, Yonghong Song wrote:
> >>
> >>
> >> On 3/2/22 2:45 PM, Kumar Kartikeya Dwivedi wrote:
> >>> On Sat, Feb 26, 2022 at 05:13:38AM IST, Hao Luo wrote:
> >>>> Introduce a new type of iter prog: cgroup. Unlike other bpf_iter, this
> >>>> iter doesn't iterate a set of kernel objects. Instead, it is supposed to
> >>>> be parameterized by a cgroup id and prints only that cgroup. So one
> >>>> needs to specify a target cgroup id when attaching this iter.
> >>>>
> >>>> The target cgroup's state can be read out via a link of this iter.
> >>>> Typically, we can monitor cgroup creation and deletion using sleepable
> >>>> tracing and use it to create corresponding directories in bpffs and pin
> >>>> a cgroup id parameterized link in the directory. Then we can read the
> >>>> auto-pinned iter link to get cgroup's state. The output of the iter link
> >>>> is determined by the program. See the selftest test_cgroup_stats.c for
> >>>> an example.
> >>>>
> >>>> Signed-off-by: Hao Luo <haoluo@google.com>
> >>>> ---
> >>>>    include/linux/bpf.h            |   1 +
> >>>>    include/uapi/linux/bpf.h       |   6 ++
> >>>>    kernel/bpf/Makefile            |   2 +-
> >>>>    kernel/bpf/cgroup_iter.c       | 141 +++++++++++++++++++++++++++++++++
> >>>>    tools/include/uapi/linux/bpf.h |   6 ++
> >>>>    5 files changed, 155 insertions(+), 1 deletion(-)
> >>>>    create mode 100644 kernel/bpf/cgroup_iter.c
[...]
> >>>
> >>> I think in existing iterators, we make a final call to seq_show, with v as NULL,
> >>> is there a specific reason to do it differently for this? There is logic in
> >>> bpf_iter.c to trigger ->stop() callback again when ->start() or ->next() returns
> >>> NULL, to execute BPF program with NULL p, see the comment above stop label.
> >>>
> >>> If you do add the seq_show call with NULL, you'd also need to change the
> >>> ctx_arg_info PTR_TO_BTF_ID to PTR_TO_BTF_ID_OR_NULL.
> >>
> >> Kumar, PTR_TO_BTF_ID should be okay since the show() never takes a non-NULL
> >> cgroup. But we do have issues for cgroup_iter_seq_stop() which I missed
> >> earlier.
> >>
> >
> > Right, I was thinking whether it should call seq_show for v == NULL case. All
> > other iterators seem to do so, it's a bit different here since it is only
> > iterating over a single cgroup, I guess, but it would be nice to have some
> > consistency.
>
> You are correct that I think it is okay since it only iterates with one
> cgroup. This is different from other cases so far where more than one
> objects may be traversed. We may have future other use cases, e.g.,
> one task. I think we can abstract out start()/next()/stop() callbacks
> for such use cases. So it is okay it is different from other existing
> iterators since they are indeed different.
>

Right. This iter is special. It has a single element. So we don't
really need preamble and epilogue, which can directly be coded up in
the iter program. And we can also guarantee the cgroup passed is
always valid, otherwise we wouldn't invoke show(). So passing
PTR_TO_BTF_ID is fine. I did so mainly in order to save a null check
inside the prog.

> >
> >> For cgroup_iter, the following is the current workflow:
> >>     start -> not NULL -> show -> next -> NULL -> stop
> >> or
> >>     start -> NULL -> stop
> >>
> >> So for cgroup_iter_seq_stop, the input parameter 'v' will be NULL, so
> >> the cgroup_put() is not actually called, i.e., corresponding cgroup is
> >> not freed.
> >>
> >> There are two ways to fix the issue:
> >>    . call cgroup_put() in next() before return NULL. This way,
> >>      stop() will be a noop.
> >>    . put cgroup_get_from_id() and cgroup_put() in
> >>      bpf_iter_attach_cgroup() and bpf_iter_detach_cgroup().
> >>
> >> I prefer the second approach as it is cleaner.
> >>

Yeah, the second approach should be fine. I was thinking of holding
the cgroup's reference only when we actually start reading, so that a
cgroup can go at any time and this iter gets a reference only in best
effort. Now a reference is held from attach to detach, but I think it
should be fine. Let me test.

> >
> > I think current approach is also not safe if cgroup_id gets reused, right? I.e.
> > it only does cgroup_get_from_id in seq_start, not at attach time, so it may not
> > be the same cgroup when calling read(2). kernfs is using idr_alloc_cyclic, so it
> > is less likely to occur, but since it wraps around to find a free ID it might
> > not be theoretical.
>
> As Alexei mentioned, cgroup id is 64-bit, the collision should
> be nearly impossible. Another option is to get a fd from
> the cgroup path, and send the fd to the kernel. This probably
> works.
>

64bit cgroup id should be fine. Using cgroup path and fd is more
complicated, unnecessarily IMHO.

> [...]
