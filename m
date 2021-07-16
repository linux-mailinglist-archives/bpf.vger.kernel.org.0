Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC883CB08A
	for <lists+bpf@lfdr.de>; Fri, 16 Jul 2021 03:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhGPBrZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 21:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhGPBrZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 21:47:25 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2514C06175F
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 18:44:29 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id e20so11773317ljn.8
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 18:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SbeLt1g8PnOQyihVzpInCmeQYo221ZAknhTTPVAXAU4=;
        b=aYKHAHEUM180UYAkxO6jUAgkTAoLoFSEQIpb2uoFAqWeKIbo+QPD0zqd40fDYTMaSa
         EA/xykK27xczml7ikfxp+HtfLCrFBzLu8Dvspubvz5ONJl2jnfFZ4zaj34oL88/ZsSRn
         I33RsSs6PS5A3gV0sDCCEeS7QyIi/pHw2D+rnfv/50WfOqcw66ysMJOYz8FqRlDph+Qt
         rM/Jz0XMGOj8MFjCrSu8ePLiTMVGY+jxeDxlO3ALYq7OZc6jlxsvPQ+ETs+V8t8fCKJ1
         BTAlcoN0rSX8BsJ0R1dy/dgFZfKGDwGiMk2HugTV7o9uumeut7ySa1UhYsYE5HnC969Q
         h/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SbeLt1g8PnOQyihVzpInCmeQYo221ZAknhTTPVAXAU4=;
        b=ks7/ItaQ5Y8mavZCfr7okM6gOUBh9G9HHbBK3kd9T7/aaYfHjjNwP/atkzknTuJmK/
         qNzDadbDQaRPpGAWaLlmS1uxMt9yh7c14Gj+AfnZGUIvE3P+ZE8UlZ808dSozpGLr1FN
         gLgkJmj1IHAhYqLk+c1lVK/pWDR/nz1YDLMOKxeJPoRrb1G/Q2pQJGOuW+HOvwmVN8wP
         JrK7MDAF4McTmsXopkzPucuNrK+s8HHYakqTvHHhBVYulDfatKNRLqvhF7tx/uae404W
         A+sRUDhCcteqmhxUWN9tQYipS1rhMsQOR1Tla+iM3sOQRmadiAxWuLa5avCYuUO8Efnb
         DdkA==
X-Gm-Message-State: AOAM530nUkLBl54cmcVui5xoK4WN+bDanFL68n2XP1mrfwCuVCF7105+
        InuWv3g+Tzqt0zULUHtIOD50WO1mgQ69cS49pro=
X-Google-Smtp-Source: ABdhPJwNgwyFvlb1gousH5AjH7potp0ZYmWzvcH1Z7puVwRQckujZJTJ3UxbUeGPRqQV7Y05IjmK0ALoWweqI0kFIsc=
X-Received: by 2002:a2e:3214:: with SMTP id y20mr6649518ljy.486.1626399868280;
 Thu, 15 Jul 2021 18:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210712162424.2034006-1-hengqi.chen@gmail.com>
 <60ec94013acd1_50e1d2081@john-XPS-13-9370.notmuch> <6f42985e-063e-205b-820e-6bad600caf54@fb.com>
In-Reply-To: <6f42985e-063e-205b-820e-6bad600caf54@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 15 Jul 2021 18:44:16 -0700
Message-ID: <CAADnVQL9X7xrLKa5_tfgzAnEjPckz0jaWozAH+oNKz3=tZ6r=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Expose bpf_d_path helper to vfs_read/vfs_write
To:     Yonghong Song <yhs@fb.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Hengqi Chen <hengqi.chen@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 14, 2021 at 5:55 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/12/21 12:12 PM, John Fastabend wrote:
> > Hengqi Chen wrote:
> >> Add vfs_read and vfs_write to bpf_d_path allowlist.
> >> This will help tools like IOVisor's filetop to get
> >> full file path.
> >>
> >> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> >> ---
> >
> > As I understand it dpath helper is allowed as long as we
> > are not in NMI/interrupt context, so these should be fine
> > to add.
> >
> > Acked-by: John Fastabend <john.fastabend@gmail.com>
>
> The corresponding bcc discussion thread is here:
>    https://github.com/iovisor/bcc/issues/3527
>
> Acked-by: Yonghong Song <yhs@fb.com>
>
> >
> >>   kernel/trace/bpf_trace.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> >> index 64bd2d84367f..6d3f951f38c5 100644
> >> --- a/kernel/trace/bpf_trace.c
> >> +++ b/kernel/trace/bpf_trace.c
> >> @@ -861,6 +861,8 @@ BTF_ID(func, vfs_fallocate)
> >>   BTF_ID(func, dentry_open)
> >>   BTF_ID(func, vfs_getattr)
> >>   BTF_ID(func, filp_close)
> >> +BTF_ID(func, vfs_read)
> >> +BTF_ID(func, vfs_write)
> >>   BTF_SET_END(btf_allowlist_d_path)

That feels incomplete.
I know we can add more later, but why these two and not vfs_readv ?
security_file_permission should probably be added as well ?
Along with all sys_* entry points ?
