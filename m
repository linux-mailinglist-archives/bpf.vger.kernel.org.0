Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1F148F38B
	for <lists+bpf@lfdr.de>; Sat, 15 Jan 2022 01:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiAOAtJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Jan 2022 19:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiAOAtJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Jan 2022 19:49:09 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27352C061574
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 16:49:09 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id x15so9757544ilc.5
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 16:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ogHqmC/MjjInDpnyrL4IKuFxfqueZNGJbUR+S8gbPco=;
        b=XpEKZKrDBtbCWhq14gRQSQGaoQune28Fr3YM36uqg3vChvNRR6rgPtUJCa40NLBXjV
         QSlrsoZbWtUtWbAfceTvYqaKqwkJPXnlEUdyXc0IR9gqIHRG6Ks4k7Rit0XmvudT9aui
         T98AFfO4iwB4HrIp5RL7lQ7wXbgvkebgxsDnvkNGXeatCTgDAVbnWadr7sKREC0srqzZ
         mv4hG/17m83Yovvk36xrk5irTQqbAZTEk9q8cV+6fWbwKOXDaZLbK5NcadgYBSAYjCu1
         x2v81OYMQLriMOYDmmM+I9voVUiXVK7nFgqXddSS/q5vTsxC5919tL0RC6wn7hvQjD9D
         9vAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ogHqmC/MjjInDpnyrL4IKuFxfqueZNGJbUR+S8gbPco=;
        b=qLOptp9mBugtvIWOVQVkGUIxzr5f8tJXV87Buy8w+QFoOvLFhxNNdAJgKglpqfihnG
         fm9kp2cYGDWr+VTc7ZggnsI13+lre3j0hsp/a8JNPN1pTkdOl10TXsxCu6rijKQ7tOpT
         Sr58ht/i63rJDtg32vG9/B0SoU+5Hg2Xy8xzB5GbX2Ctgil2I61kPAkQ8qLY/QHxBvhp
         xDYatIYpnI1TB6Ltqgm5PXwQhTuvF/gzMrz15DzsQP5+MrmzxVaja6N9ifzlqaPSVMay
         1WENA58PEnHtr6QaCSdyV8/AtgcM3jdb7We0/A9ALWMq/+cl1VHJBmL5ogtg1PJrv2eg
         p4yw==
X-Gm-Message-State: AOAM5320/52eWpTuLozVclHUNWvFDLctT3tnEQRBxLvpdlq4nUDnWEOl
        1uh/JsFvvdEOwbjHNtGdGywrksonKixz2qflR2hOo1gM
X-Google-Smtp-Source: ABdhPJw79V9xrifF1qG17ArCnoDbnq5PJ2cxaSukLmHgk3nXT8FBRlzv7+weVuRuYj/ucUWUIwIXm80IuPf/Fntlsy4=
X-Received: by 2002:a05:6e02:1a24:: with SMTP id g4mr5833585ile.71.1642207747383;
 Fri, 14 Jan 2022 16:49:07 -0800 (PST)
MIME-Version: 1.0
References: <20220112114953.722380-1-usama.arif@bytedance.com>
 <6586be41-1ceb-c9d3-f9ea-567f51dbab49@isovalent.com> <CAPhsuW73qDOOrp2tSEZav_i2ySarUH91RRBhZjFwOtrwEGzREw@mail.gmail.com>
In-Reply-To: <CAPhsuW73qDOOrp2tSEZav_i2ySarUH91RRBhZjFwOtrwEGzREw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 14 Jan 2022 16:48:56 -0800
Message-ID: <CAEf4BzaFfsQXGEVC9LbMS12u9B5nsud=Ep+f+EpUGqEgYwOFvg@mail.gmail.com>
Subject: Re: [PATCH v6] bpf/scripts: raise an exception if the correct number
 of helpers are not generated
To:     Song Liu <song@kernel.org>
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Usama Arif <usama.arif@bytedance.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joe Stringer <joe@cilium.io>, fam.zheng@bytedance.com,
        Cong Wang <cong.wang@bytedance.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 12, 2022 at 3:51 PM Song Liu <song@kernel.org> wrote:
>
> On Wed, Jan 12, 2022 at 4:15 AM Quentin Monnet <quentin@isovalent.com> wrote:
> >
> > 2022-01-12 11:49 UTC+0000 ~ Usama Arif <usama.arif@bytedance.com>
> > > Currently bpf_helper_defs.h and the bpf helpers man page are auto-generated
> > > using function documentation present in bpf.h. If the documentation for the
> > > helper is missing or doesn't follow a specific format for e.g. if a function
> > > is documented as:
> > >  * long bpf_kallsyms_lookup_name( const char *name, int name_sz, int flags, u64 *res )
> > > instead of
> > >  * long bpf_kallsyms_lookup_name(const char *name, int name_sz, int flags, u64 *res)
> > > (notice the extra space at the start and end of function arguments)
> > > then that helper is not dumped in the auto-generated header and results in
> > > an invalid call during eBPF runtime, even if all the code specific to the
> > > helper is correct.
> > >
> > > This patch checks the number of functions documented within the header file
> > > with those present as part of #define __BPF_FUNC_MAPPER and raises an
> > > Exception if they don't match. It is not needed with the currently documented
> > > upstream functions, but can help in debugging when developing new helpers
> > > when there might be missing or misformatted documentation.
> > >
> > > Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> >
> > Reviewed-by: Quentin Monnet <quentin@isovalent.com>
>
> Acked-by: Song Liu <songliubraving@fb.com>
>
> Thanks!

Would be great if we could also enforce minimal formatting consistency
(i.e., that Description and Return sections are present and that empty
line before the next function definition is present), but it's an
improvement anyway. Fixed up don't -> doesn't and applied to bpf-next.
