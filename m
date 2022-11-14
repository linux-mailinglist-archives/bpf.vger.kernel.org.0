Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4867D62887A
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 19:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbiKNSmc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 13:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236409AbiKNSmb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 13:42:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B280286E0
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 10:42:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE9E761362
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 18:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D9DC43144
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 18:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668451349;
        bh=hdCdzNqeE7/Mp6RDz2a95J8Nb5PbYxZehJNEuAi/uFs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fBwX69v8CLMLnumo8YNPR/Rh6HyHlyyhFofeumIrUu6uWnjM3rKoPLZynQGQb7rlC
         OnvNJmuAcPLn71U0Ek3k5U+DJ7I6dLKmWpuNcXHiPSrvzAlxd1IGH3Rg0sK2rqhy6N
         iXxrLd562vCSjUReJyATIuq/xKkQX1pm8KEuu9SJqCubVmAzZKFBANJ+2RrhgMO3Bc
         Dy2e6+XkxkWoYfrXMuYUU8FbxESNHsQj4MQGvjmCOxszLsrfW4PPfO8OoX1unLs9li
         4tFUfYgNeIa21TDXGB42V7aa7VRIu2cWGuVnmPvNtr2HFG9GTEmkRjphot6MdQUGJh
         9oxTj3xwT800A==
Received: by mail-ed1-f44.google.com with SMTP id s5so2409514edc.12
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 10:42:29 -0800 (PST)
X-Gm-Message-State: ANoB5pn9GOv7J+rwu3TSrtQk30a5ouV8wGOFVkHIGuXjtqBYg1FAFNz/
        i0zUL//z8wthet74wP+P8hlt/f1xhh4PdtTFlqo=
X-Google-Smtp-Source: AA0mqf7iWD5wYPC2x8jF8Bs5dQdmhPh8491CNVOWem3cCzWJVj4R05CxeQBlTE5LSmqzIhQfIVEkzCiL7Xrd39xb06M=
X-Received: by 2002:aa7:d697:0:b0:461:dbcc:5176 with SMTP id
 d23-20020aa7d697000000b00461dbcc5176mr12150458edr.53.1668451347455; Mon, 14
 Nov 2022 10:42:27 -0800 (PST)
MIME-Version: 1.0
References: <20221111143341.508022-1-jolsa@kernel.org> <20221111143341.508022-2-jolsa@kernel.org>
 <CAADnVQ+TFa=LSpJoCkosu-a4g89Ve90zgcAJ=ij2YV3x1Zq_ig@mail.gmail.com>
In-Reply-To: <CAADnVQ+TFa=LSpJoCkosu-a4g89Ve90zgcAJ=ij2YV3x1Zq_ig@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 14 Nov 2022 10:42:15 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7VKWJ-pSCyWrammhNtN6dHbJRp7j2px2=3vtPq7Uz5QQ@mail.gmail.com>
Message-ID: <CAPhsuW7VKWJ-pSCyWrammhNtN6dHbJRp7j2px2=3vtPq7Uz5QQ@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 1/2] bpf: Add bpf_vma_build_id_parse function
 and kfunc
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 14, 2022 at 9:41 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 11, 2022 at 6:33 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding bpf_vma_build_id_parse function to retrieve build id from
> > passed vma object and making it available as bpf kfunc.
> >
> > We can't use build_id_parse directly as kfunc, because we would
> > not have control over the build id buffer size provided by user.
> >
> > Instead we are adding new bpf_vma_build_id_parse function with
> > 'build_id__sz' argument that instructs verifier to check for the
> > available space in build_id buffer.
> >
> > This way  we check that there's  always available memory space
> > behind build_id pointer. We also check that the build_id__sz is
> > at least BUILD_ID_SIZE_MAX so we can place any buildid in.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/bpf.h  |  5 +++++
> >  kernel/bpf/helpers.c | 16 ++++++++++++++++
> >  2 files changed, 21 insertions(+)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 798aec816970..5e7c4c50da8e 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2779,4 +2779,9 @@ struct bpf_key {
> >         bool has_ref;
> >  };
> >  #endif /* CONFIG_KEYS */
> > +
> > +extern int bpf_vma_build_id_parse(struct vm_area_struct *vma,
> > +                                 unsigned char *build_id,
> > +                                 size_t build_id__sz);
> > +
> >  #endif /* _LINUX_BPF_H */
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 283f55bbeb70..af7a30dafff3 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/proc_ns.h>
> >  #include <linux/security.h>
> >  #include <linux/btf_ids.h>
> > +#include <linux/buildid.h>
> >
> >  #include "../../lib/kstrtox.h"
> >
> > @@ -1706,10 +1707,25 @@ bpf_base_func_proto(enum bpf_func_id func_id)
> >         }
> >  }
> >
> > +int bpf_vma_build_id_parse(struct vm_area_struct *vma,
> > +                          unsigned char *build_id,
> > +                          size_t build_id__sz)
> > +{
> > +       __u32 size;
> > +       int err;
> > +
> > +       if (build_id__sz < BUILD_ID_SIZE_MAX)
> > +               return -EINVAL;
> > +
> > +       err = build_id_parse(vma, build_id, &size);
> > +       return err ?: (int) size;
> > +}
>
> And you'll allow any tracing prog to call it like this?
> Feels obviously unsafe unless I'm missing something big here.
> See the amount of safety checks that
> stack_map_get_build_id_offset() does.
> Why can we get away without them here?
>
> The use case is not clear to me as well.
> Do you alwasy expect to call this kfunc from bpf_find_vma callback ?

It is also safe to call it from iter/task_vma programs. Some allow list
seems necessary here.

Thanks,
Song
