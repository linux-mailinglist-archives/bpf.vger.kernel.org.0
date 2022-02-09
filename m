Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5144AF630
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 17:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbiBIQLd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 11:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236646AbiBIQLc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 11:11:32 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A79C0612BE;
        Wed,  9 Feb 2022 08:11:35 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id z18so2119337iln.2;
        Wed, 09 Feb 2022 08:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YGPgmm0zpFysmniVk6vE8gWmAEuLsVxAfMCvjfUO8FA=;
        b=W0oHNPu8aTwFsmLNc2jqUvB6rdV1IvIiYA0AB0NTcZy2169EnG7EADDd1Jim8+jyXu
         wBAjpt7UjNfseFZ/7VXS4iRSfYHbqZznInXXp/av8940CZE3TNNEJDfF21ddZIlocoIL
         MOSGq6d1rtB94NKMYTuKUUtOYLCShfbqZ6Qz3MTg1pKgiBr74egicc+haLpY8XU/0qO9
         bLRFFrpG79boWiPBJoYBU30RCBv2G/0HHreheYq92zCUrGSmgesjHxpDLRahKUWc3cpw
         QBX8DspekawPWyK1xcCvEp/PBkBBfnZgr+/WcdCyM5zCrWBKFGniOHX9jgZtkEkhsQFh
         Q7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YGPgmm0zpFysmniVk6vE8gWmAEuLsVxAfMCvjfUO8FA=;
        b=amJG1nFgk5D+0i/esVNafV95W60aSCEkUwhfmPdj6/px2/+oK6h3xGlXtgnH2TKinH
         6kGgz2BesasGf0ZzvGkjR1ozkpa5lh01PWJS/msaPZaU/TdpTJzGPk2phdCZVlRzb8s1
         aJPSLh21jzX2paXYYKpsZf4LghJvH1ZAPQxHCo3DURpYVfyGi8tbAglBbU/W6U+oLayU
         v33JPNKyUQf8rRdq9wzkApESRpd1VzjYFKCtgJMnfqCGBDXZw2bUC5X1/Cd0IFLdQqrj
         vkbIR9peryFjY14nkpJ6VuUTFWVPpehq/GVOWelJwFzZzfE0ivs8ITVqy6NUTMbC7IKN
         kcNw==
X-Gm-Message-State: AOAM531C9SSUTBfBX6BJtMNI8m8Kre7LmKBjvOUKGzgwURQvyz1be7PC
        UNnELcS95FkXr9WNlvBZxGb2Zg/Tx28haPQMUoQ=
X-Google-Smtp-Source: ABdhPJxeiPAjeq/BjbjSbtUnzje1yjwtWKjDm0wgyLGxbpelssmuAU90aiAd20fkA7mdI+IgP2MQBBmh2q97ULqzg8E=
X-Received: by 2002:a05:6e02:2163:: with SMTP id s3mr1370054ilv.252.1644423094933;
 Wed, 09 Feb 2022 08:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20220119230636.1752684-1-christylee@fb.com> <20220119230636.1752684-3-christylee@fb.com>
 <Ye2LAEiXaBoj2n8Z@krava> <Yfq4o0Op4eYvFKIp@krava> <CAPqJDZpR0n2_VAPQNnpLoyAt_zO5b6XvSs0cO8X=kb3azOqg5w@mail.gmail.com>
In-Reply-To: <CAPqJDZpR0n2_VAPQNnpLoyAt_zO5b6XvSs0cO8X=kb3azOqg5w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 9 Feb 2022 08:11:23 -0800
Message-ID: <CAEf4BzbwcRJoa8ba5wm7C4=THK9resg9a9aWgaQOcL71ofMxeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] perf: stop using deprecated
 bpf_object__next() API
To:     Christy Lee <christyc.y.lee@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Wang Nan <wangnan0@huawei.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 2, 2022 at 9:24 AM Christy Lee <christyc.y.lee@gmail.com> wrote:
>
> Sorry, some other priorities came up. If it's urgent, please feel free
> to commandeer this commit. Otherwise, I can get to it this weekend.
>
> Christy

Hey Christy,

Do you still plan to send follow up patches or should I pick this up?

>
> On Wed, Feb 2, 2022 at 9:00 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > hi,
> > just checking, do you plan to send new version for this?
> >
> > thanks,
> > jirka
> >
> > On Sun, Jan 23, 2022 at 06:06:08PM +0100, Jiri Olsa wrote:
> > > On Wed, Jan 19, 2022 at 03:06:36PM -0800, Christy Lee wrote:
> > >
> > > SNIP
> > >
> > > > ---
> > > >  tools/perf/util/bpf-loader.c | 72 +++++++++++++++++++++++++++---------
> > > >  tools/perf/util/bpf-loader.h |  1 +
> > > >  2 files changed, 55 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> > > > index 4631cac3957f..b1822f8af2bb 100644
> > > > --- a/tools/perf/util/bpf-loader.c
> > > > +++ b/tools/perf/util/bpf-loader.c
> > > > @@ -29,9 +29,6 @@
> > > >
> > > >  #include <internal/xyarray.h>
> > > >
> > > > -/* temporarily disable libbpf deprecation warnings */
> > > > -#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > > > -
> > > >  static int libbpf_perf_print(enum libbpf_print_level level __attribute__((unused)),
> > > >                           const char *fmt, va_list args)
> > > >  {
> > > > @@ -49,6 +46,36 @@ struct bpf_prog_priv {
> > > >     int *type_mapping;
> > > >  };
> > > >
> > > > +struct bpf_perf_object {
> > > > +   struct bpf_object *obj;
> > > > +   struct list_head list;
> > > > +};
> > > > +
> > > > +static LIST_HEAD(bpf_objects_list);
> > >
> > > hum.. I still can't see any code adding/removing bpf_perf_object
> > > objects to this list, and that's why the code is failing to remove
> > > probes
> > >
> > > because there are no objects to iterate on, so added probes stay
> > > configured and screw following tests
> > >
> > > you need something like below to add and del objects from
> > > bpf_objects_list list
> > >
> > > it also simplifies for_each macros to work just over perf_obj,
> > > because I wasn't patient enough to make it work with the extra
> > > bpf_object ;-) I don't mind if you fix that, but this way looks
> > > simpler to me
> > >
> > > tests are working for me with this fix, please feel free to
> > > squash it into your change
> > >
> > > thanks,
> > > jirka
> > >
> > >
> > > ---
> > > diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
> > > index 57b9591f7cbb..d09d25707f1e 100644
> > > --- a/tools/perf/tests/bpf.c
> > > +++ b/tools/perf/tests/bpf.c
> > > @@ -210,6 +210,11 @@ prepare_bpf(void *obj_buf, size_t obj_buf_sz, const char *name)
> > >               pr_debug("Compile BPF program failed.\n");
> > >               return NULL;
> > >       }

[...]
