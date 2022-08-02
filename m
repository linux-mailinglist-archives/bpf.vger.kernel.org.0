Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1791E587529
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 03:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiHBBt7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 21:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiHBBt6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 21:49:58 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8890D2CC93
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 18:49:57 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a7so10498116ejp.2
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 18:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YeIHltiQ4CAdYEKQqsp8vmXqN6N8NFkZ1cwoPLJ/hx4=;
        b=Q7BkqyXKqwrf7VBATdm3kVXowDFXJ72JFWhXDEfMtYV8QZOqguyk/d/FCZn8MdwgCg
         pnQyRc3gkgaiQiuyK0aMxG4oDEKYb7otSkwJG1MPya3R5ZIRCnMpNKNCUtD7r12t/8gd
         ypehLFz6IjReZMDYQ3JiPOKMMNGMsJjjk1zCLf8oQ7RO9O+6cNXmRf9ElKKiMlyJBeoD
         UN0R7F0+X/yzv48wFKzoJfjaJj8y2zbJvHnL7hl6k5L5COZDl5XWWaVvwETqG1FMRYdu
         xGoD/gQj+mL9XuVz9OFnGm+Ujr36SEQ6CYr/SPQoY0ixfDRf1WktePH7NILWLpelfsyD
         5Ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YeIHltiQ4CAdYEKQqsp8vmXqN6N8NFkZ1cwoPLJ/hx4=;
        b=7cRZ90JDPQzBuA6G8c0meqy/lJk+34FgA6dMsHGANhw9lJekg3yZPjuigvBkF8xyg0
         N2vuc2mx8Ao6lF0vtibKZ4XGW4FLEOJv81sc747CnOwTMGtKXrSc3K1DN9PzYFGebaRo
         52GwhApFrb6DBu3KD/aqgVyDwWOPjemaqmWNyZTgISTdJnqP2NZv6s6fraK8vlCwfZNS
         0soHkVPLkyu325ceHzrsYdItAnZMSF+8olFGiWuhxtlbxraCTIZMb87/Z43u9mHulK3g
         3arZEkZvdiSJnqP5ELtYzR0RU4e1G1IMoLRCOjx1O6rDIKsjD/HTeCSCV7yO4gO/TMsO
         EB1Q==
X-Gm-Message-State: AJIora9MPL3FmovDPfg69i0HgwsXNHEWm7K1g0R0sO0I5LGbsuri1w/f
        k+t/emO4LnZoM7KD8jQ4G/qHQTGc/Tm/Z3VVyvUcqqF/q8k=
X-Google-Smtp-Source: AGRyM1tga6dFaZ1YbOKEvrRGv3VXudmxG9f/dWw6fbJIwc/Qz8aLDVkxTSqkfUEzFwLBMmMuB6SvZpSRi55oS4w0AZg=
X-Received: by 2002:a17:907:6e02:b0:72b:9f16:1bc5 with SMTP id
 sd2-20020a1709076e0200b0072b9f161bc5mr15156382ejc.676.1659404995988; Mon, 01
 Aug 2022 18:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220801232649.2306614-1-kuifeng@fb.com> <20220801232649.2306614-2-kuifeng@fb.com>
In-Reply-To: <20220801232649.2306614-2-kuifeng@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 1 Aug 2022 18:49:44 -0700
Message-ID: <CAADnVQJp3GDjFw9H8nez4z8zSYME3h_fL3cuhiVSOrMc11T5KA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Parameterize task iterators.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
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

On Mon, Aug 1, 2022 at 4:27 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Allow creating an iterator that loops through resources of one task/thread.
>
> People could only create iterators to loop through all resources of
> files, vma, and tasks in the system, even though they were interested
> in only the resources of a specific task or process.  Passing the
> additional parameters, people can now create an iterator to go
> through all resources or only the resources of a task.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  include/linux/bpf.h            |  4 ++
>  include/uapi/linux/bpf.h       | 23 +++++++++
>  kernel/bpf/task_iter.c         | 93 ++++++++++++++++++++++++++--------
>  tools/include/uapi/linux/bpf.h | 23 +++++++++
>  4 files changed, 121 insertions(+), 22 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 11950029284f..3c26dbfc9cef 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1718,6 +1718,10 @@ int bpf_obj_get_user(const char __user *pathname, int flags);
>
>  struct bpf_iter_aux_info {
>         struct bpf_map *map;
> +       struct {
> +               u32     tid;
> +               u8      type;
> +       } task;
>  };
>
>  typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index ffcbf79a556b..ed5ba501609f 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -87,10 +87,33 @@ struct bpf_cgroup_storage_key {
>         __u32   attach_type;            /* program attach type (enum bpf_attach_type) */
>  };
>
> +enum bpf_task_iter_type {
> +       BPF_TASK_ITER_ALL = 0,
> +       BPF_TASK_ITER_TID,
> +};
> +
>  union bpf_iter_link_info {
>         struct {
>                 __u32   map_fd;
>         } map;
> +       /*
> +        * Parameters of task iterators.
> +        */
> +       struct {
> +               __u32   pid_fd;
> +               /*
> +                * The type of the iterator.
> +                *
> +                * It can be one of enum bpf_task_iter_type.
> +                *
> +                * BPF_TASK_ITER_ALL (default)
> +                *      The iterator iterates over resources of everyprocess.
> +                *
> +                * BPF_TASK_ITER_TID
> +                *      You should also set *pid_fd* to iterate over one task.
> +                */
> +               __u8    type;   /* BPF_TASK_ITER_* */

__u8 might be a pain for future extensibility.
big vs little endian will be another potential issue.

Maybe use enum bpf_task_iter_type type; here and
move the comment to enum def ?
Or rename it to '__u32 flags;' ?
