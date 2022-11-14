Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037D0628B94
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 22:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbiKNVru (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 16:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237477AbiKNVrt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 16:47:49 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F01193EB
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 13:47:48 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id n12so31579599eja.11
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 13:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2pEh42yObqYuecAVuDLTKjxJvCxRuZFxxc+mBpUUsKU=;
        b=jihhpS75JVhCVenU8W0juh98Jz2+r8aSTdUBMO1qvxssjBQazJuL+m9sAWbnXppMln
         Errt3J5JTz2BVa2I11XukShVZ1bK71nven6PAQAZgTUSDaXiqt3YZf2r2nxLIGnizcN3
         iud2/TmOFJhOoSLqZLJCUNKO6twzTHT7XCXkf0RmONhXjZEBYg4vZTxC3yPjYyNxVmvA
         aqcb6nxN7gYs0yVoCRTW6jmLWHfYrRlg+LXD6SvJ0b0uIVAdUaKOWQlJAhBZlhwz1/cs
         IHWfPhD3ydUmxef8e/H0iyJPtuy7DlhD0ONUpGzqZ3h3P7ajWeEVAb4EuTVFDdybjqEs
         Ljhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pEh42yObqYuecAVuDLTKjxJvCxRuZFxxc+mBpUUsKU=;
        b=Yt0CVDzTVAnMLyU9QflpKwg5BdtCNGfX4pqBpFYAwObnpWJWEzLAmz+q8HAE5ldqjk
         4AYl5VUVo0SV9uf+jPx6pG7Fl/peYMWmnkB6yeaWr6I49z1s49S1tNv9zUJKKxbNF01Q
         YY1Oojx69oICgvFfIg7aQ/5hMl5uIRnzUZDdqg7LzOVWzOzj6eFU2LWgDvwGDQZKnuY2
         NvTiBXEa+M7TPwmRUI8vxZ5u0zFV9JL+4SCiBPCRJp8g/Bw5nJLVFlIpd1hLcGFPZe5i
         gBjtej/AoMkffPgxfsCvox5y8QIXt3b6jVcBVGYSBesICEnwl+AG9/zVGXmuF++f9W4u
         h0gg==
X-Gm-Message-State: ANoB5pnvxATmzbqIzYHAVCj2U9urZGHpK638UHNQVkT9dFEMN3HHar4c
        Ji88juQducDAGcrwXuUthF4=
X-Google-Smtp-Source: AA0mqf4Jkqdf1Cnu93KF6oLCgeUHk02qiAGuhZDrQcf6bk4s07qFEecncPsHlaeuaUu9TblAK/Zghg==
X-Received: by 2002:a17:906:61b:b0:7ae:3684:84b0 with SMTP id s27-20020a170906061b00b007ae368484b0mr11411285ejb.622.1668462466682;
        Mon, 14 Nov 2022 13:47:46 -0800 (PST)
Received: from krava ([83.240.62.198])
        by smtp.gmail.com with ESMTPSA id n23-20020a170906701700b0078db18d7972sm4638438ejj.117.2022.11.14.13.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 13:47:46 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 14 Nov 2022 22:47:44 +0100
To:     Song Liu <song@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv2 bpf-next 1/2] bpf: Add bpf_vma_build_id_parse function
 and kfunc
Message-ID: <Y3K3gK1zq/a5O1u1@krava>
References: <20221111143341.508022-1-jolsa@kernel.org>
 <20221111143341.508022-2-jolsa@kernel.org>
 <CAADnVQ+TFa=LSpJoCkosu-a4g89Ve90zgcAJ=ij2YV3x1Zq_ig@mail.gmail.com>
 <CAPhsuW7VKWJ-pSCyWrammhNtN6dHbJRp7j2px2=3vtPq7Uz5QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW7VKWJ-pSCyWrammhNtN6dHbJRp7j2px2=3vtPq7Uz5QQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 14, 2022 at 10:42:15AM -0800, Song Liu wrote:
> On Mon, Nov 14, 2022 at 9:41 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Nov 11, 2022 at 6:33 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Adding bpf_vma_build_id_parse function to retrieve build id from
> > > passed vma object and making it available as bpf kfunc.
> > >
> > > We can't use build_id_parse directly as kfunc, because we would
> > > not have control over the build id buffer size provided by user.
> > >
> > > Instead we are adding new bpf_vma_build_id_parse function with
> > > 'build_id__sz' argument that instructs verifier to check for the
> > > available space in build_id buffer.
> > >
> > > This way  we check that there's  always available memory space
> > > behind build_id pointer. We also check that the build_id__sz is
> > > at least BUILD_ID_SIZE_MAX so we can place any buildid in.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  include/linux/bpf.h  |  5 +++++
> > >  kernel/bpf/helpers.c | 16 ++++++++++++++++
> > >  2 files changed, 21 insertions(+)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 798aec816970..5e7c4c50da8e 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -2779,4 +2779,9 @@ struct bpf_key {
> > >         bool has_ref;
> > >  };
> > >  #endif /* CONFIG_KEYS */
> > > +
> > > +extern int bpf_vma_build_id_parse(struct vm_area_struct *vma,
> > > +                                 unsigned char *build_id,
> > > +                                 size_t build_id__sz);
> > > +
> > >  #endif /* _LINUX_BPF_H */
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index 283f55bbeb70..af7a30dafff3 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -19,6 +19,7 @@
> > >  #include <linux/proc_ns.h>
> > >  #include <linux/security.h>
> > >  #include <linux/btf_ids.h>
> > > +#include <linux/buildid.h>
> > >
> > >  #include "../../lib/kstrtox.h"
> > >
> > > @@ -1706,10 +1707,25 @@ bpf_base_func_proto(enum bpf_func_id func_id)
> > >         }
> > >  }
> > >
> > > +int bpf_vma_build_id_parse(struct vm_area_struct *vma,
> > > +                          unsigned char *build_id,
> > > +                          size_t build_id__sz)
> > > +{
> > > +       __u32 size;
> > > +       int err;
> > > +
> > > +       if (build_id__sz < BUILD_ID_SIZE_MAX)
> > > +               return -EINVAL;
> > > +
> > > +       err = build_id_parse(vma, build_id, &size);
> > > +       return err ?: (int) size;
> > > +}
> >
> > And you'll allow any tracing prog to call it like this?
> > Feels obviously unsafe unless I'm missing something big here.
> > See the amount of safety checks that
> > stack_map_get_build_id_offset() does.
> > Why can we get away without them here?
> >

ugh right.. I use it always from bpf_find_vma callback, that's probably
why I did not realize that, because it's already locked there

> > The use case is not clear to me as well.
> > Do you alwasy expect to call this kfunc from bpf_find_vma callback ?
> 
> It is also safe to call it from iter/task_vma programs. Some allow list
> seems necessary here.

I have 2 places I call it from: sched_process_exec tp_btf and process iterator
both through bpf_find_vma callback.. so I think we can allow it only from
bpf_find_vma callback.. that should keep it simple for start

thanks,
jirka
