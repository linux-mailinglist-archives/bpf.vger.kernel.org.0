Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8124A6A0BAF
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 15:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbjBWOQv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 09:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbjBWOQh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 09:16:37 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591A656519
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 06:16:27 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id r5so1043505qtp.4
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 06:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b1rirqzv6+jkiytNAJBJfI5b/manJnRtuau19xhjFvM=;
        b=m0mZwszFlYyWcXoM3SRzvJpVt+UH8GvFj1Hah9Zys3A5+ibTJqdnt0o+zRravukmHq
         RFbO/IVEgY/ls0zKd9KQBOcRBhyez5W7zvZbBd0hGn0toYbTOYQlMXNySMixTqyGWzrX
         iXdylLjoMkwEjkSaQ1BKKohTniGGMoGG8WMi+Fd0i+ybyhlA/CxF9viCDkZrad3naV0r
         z1wiOdijUAC4YcBZKA0Q/T5c3ZrPJppQLsedKvONt4FZjz0zA5YCte5gDSTyWnXH4bLN
         PQwFLjljmwNQt9H2/EgxYfue7DCLTYKZfTC4vZ3qC6bCeGyeIIKyWMc3S4ErFa5R0run
         9LXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1rirqzv6+jkiytNAJBJfI5b/manJnRtuau19xhjFvM=;
        b=OJWvHmS1d5sxbT6lVqAKR9sGPx96A3EPEHvx/UEa7yzwXGR4HvgmBmckyoRDMsaC8X
         I74UpIl0h98QcYjhMLYyJ7v6i3nkE5/ey+07bhup06y+cERoNqzZ+oVTOgJ9xB5X6bs9
         aj9QqGv/aztV+FreHIGGQ0F5R75gyw8x6dvVnDWloBim9HJpLnMqiLeWhg+at1nUA1A3
         kk/QFfQ/icHscmLawl9iDFZI+8yvf7UsKWlRiYAih9TrYis/i712Bf06x0CbEuvUH4NP
         z+4HsWI/GujKI+o623bA7PbwnVvsNnRF6Cp/pJSPfSLToZoQszmRuOj94KlIXUs0YOn8
         2yzQ==
X-Gm-Message-State: AO0yUKWfDqcfK62APoUnaIY7couOQcpogZoMYme/b5wI6Hqs9HIIFHDo
        PS8s8KhqUsNMXq/Ogci8ijqi7V1ivsDT752e6371uXxoEmg=
X-Google-Smtp-Source: AK7set/2rNSShiyUHaq15ZedI6cYHGFXlkFLW8+XV9Hg2lni3Tv+7M6l+3qT8wo/pQCHPCSBqQaEi7tc1+hDL4bcwCI=
X-Received: by 2002:a05:622a:4114:b0:3b9:bc89:f8cd with SMTP id
 cc20-20020a05622a411400b003b9bc89f8cdmr2777199qtb.5.1677161786450; Thu, 23
 Feb 2023 06:16:26 -0800 (PST)
MIME-Version: 1.0
References: <20230222014553.47744-1-laoar.shao@gmail.com> <20230222014553.47744-19-laoar.shao@gmail.com>
 <CAADnVQ+09SYGH3Kz13wVSSu9k2Er55KA8FZLxC0j6ZpY4EbDKA@mail.gmail.com>
In-Reply-To: <CAADnVQ+09SYGH3Kz13wVSSu9k2Er55KA8FZLxC0j6ZpY4EbDKA@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 23 Feb 2023 22:15:50 +0800
Message-ID: <CALOAHbDRe=hMYwCAywYwtSFECbshUG+NBptR6Pbfqqn1DjTzXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 18/18] bpf: enforce all maps having memory
 usage callback
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Ho-Ren Chuang <horenc@vt.edu>,
        Cong Wang <xiyou.wangcong@gmail.com>, bpf <bpf@vger.kernel.org>
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

On Thu, Feb 23, 2023 at 3:20 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 21, 2023 at 5:47 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > We have implemented memory usage callback for all maps, and we enforce
> > any newly added map having a callback as well. Show a warning if it
> > doesn't have.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/bpf/syscall.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index e12b03e..d814d4e 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -775,13 +775,9 @@ static fmode_t map_get_sys_perms(struct bpf_map *map, struct fd f)
> >  /* Show the memory usage of a bpf map */
> >  static u64 bpf_map_memory_usage(const struct bpf_map *map)
> >  {
> > -       unsigned long size;
> > -
> > -       if (map->ops->map_mem_usage)
> > -               return map->ops->map_mem_usage(map);
> > -
> > -       size = round_up(map->key_size + bpf_map_value_size(map), 8);
> > -       return round_up(map->max_entries * size, PAGE_SIZE);
> > +       if (WARN_ON_ONCE(!map->ops->map_mem_usage))
> > +               return 0;
>
> Since all maps are converted, let's do this check earlier.
> Like during find_and_alloc_map.
> And without WARN.

Good suggestion. I will do it.

-- 
Regards
Yafang
