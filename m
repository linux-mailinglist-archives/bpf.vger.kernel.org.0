Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560D94DA374
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 20:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349881AbiCOTtT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 15:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343607AbiCOTtS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 15:49:18 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573BADEA8
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 12:48:06 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id n11so148106qtk.4
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 12:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jzTzwH5r+B8zHWp2dL9bIRp+jnDQp4u6qStPolr36JI=;
        b=SVFOtodruKnk3NeRKIG5/VG4myOANEFzk02YEJ0NuwwHWsE4VW6a5bvyR4IHJYh6tI
         qLGRCkAWEu1W3EUTBUpHvk3+xcmTBepwVGz8/ujzD59oWiwx8m1A3KGiIeIyn7PJbr3n
         cjI5Tq52DG0wgeJnFutkLs0F3maHVsyVr/X5u9lk521S/opk+v81JmdUxwNgLKf2tpAl
         OPY6ngods97/J3fjOT8eK1o8F2/Rgkgh5P5e94VScnMUVWoPV8/FsuijXoBvUUqKJnYc
         MTyeXlAe8IEPYmqhRiBfvUoce+l+/IIOq2B35ZPzKtYGeXOCBAjAL1+suZcEXA+xd7+P
         bq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jzTzwH5r+B8zHWp2dL9bIRp+jnDQp4u6qStPolr36JI=;
        b=m1hKvfxRPjwwskr+4fz3IgWNY0RIISym+NIce5axFxDcx2SiXt32pE95sZmL0uTD1a
         e7aiVJ51mrWOXVqkI4xLJROkPbflLeqyqfh4UX/79LB34MutCWLIDGHdCfBo7DjxMDAu
         u2fGlbyjv1/AQzjvo41YRdkZG3G7K7jWiN0IZpp80LileKyfvFiyevMYoUImbobX5Tks
         +rI8shK3fEsSsVZxU6lKb4CiCcUk5FY1Y8dWXbRr0q7D4/ViflCcMFs7JCaEV0888BuA
         CY2PAN+i8z6enQdiGU80auDwDJNFGAvU4dKdYLUiWUr3FxQ6oBNqVmx9CNR8V+Prlwbg
         xLsg==
X-Gm-Message-State: AOAM53076N6X7G43WXZpccqV/t3BVwSjb+dKGYnC/4yl1e81+YjsnTCR
        XC8O8eNAbxYsONQOZXgKy0bUOFf8xhirSxJdJHyQxg==
X-Google-Smtp-Source: ABdhPJyXelC5s4w2x3SOsGNEaEWzPS5GKbL0dBxyHDUfFy3ZT9Bs9ZtipguBQMOUHwLyYFwcDvQ5ZAKqn0tSEJj2osQ=
X-Received: by 2002:a05:622a:170a:b0:2e1:cdae:28df with SMTP id
 h10-20020a05622a170a00b002e1cdae28dfmr10979314qtk.299.1647373685297; Tue, 15
 Mar 2022 12:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com> <20220225234339.2386398-2-haoluo@google.com>
 <YiwXnSGf9Nb79wnm@zeniv-ca.linux.org.uk> <CA+khW7g+T2sAkP1aycmts_82JKWgYk5Y0ZJp+EvjFUyNY8W_5w@mail.gmail.com>
 <Yi/LaZ5id4ZjqFmL@zeniv-ca.linux.org.uk> <CA+khW7jhD0+s9kivrd6PsNEaxmDCewhk_egrsxwdHPZNkubJYA@mail.gmail.com>
 <YjDiQbam/P+KkgKE@zeniv-ca.linux.org.uk>
In-Reply-To: <YjDiQbam/P+KkgKE@zeniv-ca.linux.org.uk>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 15 Mar 2022 12:47:54 -0700
Message-ID: <CA+khW7h=Ykav0c=vZQTMeVumxgNwq-pRgko1VTk4wjzCVnxHFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/9] bpf: Add mkdir, rmdir, unlink syscalls
 for prog_bpf_syscall
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Mar 15, 2022 at 12:02 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Mar 15, 2022 at 10:27:39AM -0700, Hao Luo wrote:
>
> > Option 1: We can put restrictions on the pathname passed into this
> > helper. We can explicitly require the parameter dirfd to be in bpffs
> > (we can verify). In addition, we check pathname to be not containing
> > any dot or dotdot, so the resolved path will end up inside bpffs,
> > therefore won't take ->i_rwsem that is in the callchain of
> > cgroup_mkdir().
>
> Won't be enough - mount --bind the parent under itself and there you go...
> Sure, you could prohibit mountpoint crossing, etc., but at that point
> I'd question the usefulness of pathname resolution in the first place.

[Apologies for resend, my response did not get delivered to mail list]

I don't see a use case where we need to bind mount the directories in
bpffs, right now. So in option 1, we can also prohibit mountpoint
crossing.

Pathname resolution is still useful in this case. Imagine we want to
put all the created dirs under a base dir, we can open the base dir
and reuse its fd for multiple mkdirs, for example:

Userspace:
  fd = openat(..., "/sys/fs/bpf", ...);
  pass fd to the bpf prog

bpf prog:
  bpf_mkdirat(fd, "common1", ...);
  bpf_mkdirat(fd, "common1/a", ...);
  bpf_mkdirat(fd, "common1/b", ...);
  bpf_mkdirat(fd, "common2", ...);
  ...

It would be very inconvenient if we can't resolve multi-level paths.

As Alexei said, another option is to delegate syscall to a worker
thread. IMHO, we could do that in future if we find there is a need
for the full feature of pathname resolution.

Al, does that sound good?
