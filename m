Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42034CB87F
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 09:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiCCION (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 03:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiCCION (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 03:14:13 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E852E6A1;
        Thu,  3 Mar 2022 00:13:24 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id k5-20020a17090a3cc500b001befa0d3102so2748946pjd.1;
        Thu, 03 Mar 2022 00:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r13f3juVAa8nntAmFcD2gMBbLHfjAWBHECad4kLeLH0=;
        b=oJk0N1RbPWr1Sa3K6LAZdHlImz5tY5+7B9pZMypfAjHzhM+/vpyd9Ix51p4c2HisrB
         cVHo5w0jTabLTZsbkXg7wK2+Yn8mbrcyS5/DqTyLLhzZdcuStc0Wv1aabOJmPKoDfghj
         rd2KramqQsIJldx+V8yH27lx+dXeeIpW2ysOI/hsfz7E2V0LG3JLboEPF4LjEqqexBxo
         D5FZPZA7b3qnqdiJjdl/q/y3gadrFH0JxCIhb3dc5c1M7As0MnvfursbYgXqjBiMGDg2
         r9aXJPoN5XtRt58+i3drmhNNIFfYA10pEDJUlHtyAzda1h0vRIU5Kn5rHDa0SL1zkjaR
         Bhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r13f3juVAa8nntAmFcD2gMBbLHfjAWBHECad4kLeLH0=;
        b=penopgxjZCCpP97e4R9Q8++KwenPxBrENd8FLxEQwN6hLjemPKbbl/mkaCgugDr4Nm
         PJufumKeCEDvkUmh1PlA1VAK25rRDb99QfSF4Br5WnD2WldgugqKBReYHLi62OdCC29X
         1WoVxQWx4v0TcRwm7eBYbbPJbSfvYp3BVssA/hnChAf54CpiEmGsqLoEyCr/SlyJ/APM
         +0pmlYu668v/G1tdL7uXaP/mw9OE3SwHjNmbPwtsYDjUI8xyeQHzERrJcwTP7q0sttyK
         AjKij0VtK++ZGDsQFjFrR7aE7Wg1tEAHQK5Swl43vxdcEOrYhfIjttx5DbcX8V92hov7
         qFVQ==
X-Gm-Message-State: AOAM532fcW1bfWU/OcDu6uSz7y36rwopsKbxutNrXzmuip1g3Gi9te8H
        CAGdpB748DDexm6uyHJzi5C40XGwmuA=
X-Google-Smtp-Source: ABdhPJxQRf0mWvp8jsW5kPF8rU5V+qZSjnqLQ6zulQzHUB+Xjxr/9TcLbvfF7q4Mi8PvWiXsMtximA==
X-Received: by 2002:a17:902:d2ca:b0:14f:cf98:54f6 with SMTP id n10-20020a170902d2ca00b0014fcf9854f6mr33728486plc.34.1646295204421;
        Thu, 03 Mar 2022 00:13:24 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id k13-20020a056a00134d00b004f35ee59a9dsm1657093pfu.106.2022.03.03.00.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 00:13:24 -0800 (PST)
Date:   Thu, 3 Mar 2022 13:43:21 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 8/9] bpf: Introduce cgroup iter
Message-ID: <20220303081321.hoxhygtgjzi2q6xs@apollo.legion>
References: <20220225234339.2386398-1-haoluo@google.com>
 <20220225234339.2386398-9-haoluo@google.com>
 <20220302224506.jc7jwkdaatukicik@apollo.legion>
 <f780fc3a-dbc2-986c-d5a0-6b0ef1c4311f@fb.com>
 <20220303030349.drd7mmwtufl45p3u@apollo.legion>
 <ee991731-0e85-23be-2720-2d641704dcf9@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee991731-0e85-23be-2720-2d641704dcf9@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 03, 2022 at 01:03:57PM IST, Yonghong Song wrote:
> [...]
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
> >
> > > For cgroup_iter, the following is the current workflow:
> > >     start -> not NULL -> show -> next -> NULL -> stop
> > > or
> > >     start -> NULL -> stop
> > >
> > > So for cgroup_iter_seq_stop, the input parameter 'v' will be NULL, so
> > > the cgroup_put() is not actually called, i.e., corresponding cgroup is
> > > not freed.
> > >
> > > There are two ways to fix the issue:
> > >    . call cgroup_put() in next() before return NULL. This way,
> > >      stop() will be a noop.
> > >    . put cgroup_get_from_id() and cgroup_put() in
> > >      bpf_iter_attach_cgroup() and bpf_iter_detach_cgroup().
> > >
> > > I prefer the second approach as it is cleaner.
> > >
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

I see, even on 32-bit systems the actual id is 64-bit.
As for cgroup fd vs id, existing cgroup BPF programs seem to take fd, map iter
also takes map fd, so it might make sense to use cgroup fd here as well.

> [...]

--
Kartikeya
