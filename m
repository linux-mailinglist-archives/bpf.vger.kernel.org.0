Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C774D4B339A
	for <lists+bpf@lfdr.de>; Sat, 12 Feb 2022 08:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbiBLHbf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 12 Feb 2022 02:31:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiBLHbe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Feb 2022 02:31:34 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA3426AD6;
        Fri, 11 Feb 2022 23:31:31 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id r144so14015028iod.9;
        Fri, 11 Feb 2022 23:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0BgoEgiy7hfn/RGAXkV+qeUxKZZ6P1obCegXSdFIv/4=;
        b=WMt3ORljz+QF3Hy4u9lGY97K1KNiRshLPgCD3vyDh3KhPOtGeOi2kzmvp3eleBKgpE
         Ihl450CNgsRT1z/CLFCh00rrLVMsLlGF/2uGGbXMkmuEYMvatOl4XTGIIfX4RzP2PgyV
         bP2+fAqxTrdZ446vVZkiL5j/5P53oOsJIUdLMNEWW6HiR3pQ2AVoSelPfoJfaN9XyoEg
         NoHU1UVAldf5M0zaVMaLnDwQoNHPbwFssl5A5VGunV8f8agZsYESqZ/3Q3LrC76NwgmJ
         T2dvmLddLsd6f+WCv52abMNFT7tHvsq7iNAAXnBBeMFLK1ijPI9pR0FIxj9W9lKmLkvJ
         3I5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0BgoEgiy7hfn/RGAXkV+qeUxKZZ6P1obCegXSdFIv/4=;
        b=GLCxxFfDQ/BYzILBFmBfyHH727ePHEDcAynsFwA4QFZyoKxbFZ+tDKUiKEl0Yluk7i
         0lMM11j5ilO/Bct7mUZHPc5Sclfc7//q4p6qXxYl0G6j35UCpNZMgbvEKNOAMN0lzsJE
         xlLMFJq14tDc6YD72ZDBSC8RserEf/TvkydaumbHSzmko7ACb6Z2pxkL+Vn8AcyQ3yLF
         mfgNgx5gMyFQtOHeIMMamEfsTWXgQzKfsPXDif49T6uLV7VEuaKibAicvfbQeAjBYLvR
         4OnZ2nR0mL6L3d5lsoEwlyBH0bwrzc0Z9iG0AWY/P+DM563/oVYwj1AhTrwRX4Imufzz
         P9rw==
X-Gm-Message-State: AOAM533DpKcDSwZAWm5l8ftC1SdJdDS8oUSxpMPrZCNLV9iAKOR6uTpi
        GNmU6WP3UTTZILEFHcOF+cXCMesqDvb06xC41/U=
X-Google-Smtp-Source: ABdhPJwAaIKrIaL881w2B5pfltMgAXbH/NLypoMQ7X7zSxEvAFlUwF9tB/KLLXofE1wyXQQVXyMJqDpkUYVhdnxrFpI=
X-Received: by 2002:a02:7417:: with SMTP id o23mr2951818jac.145.1644651091141;
 Fri, 11 Feb 2022 23:31:31 -0800 (PST)
MIME-Version: 1.0
References: <20220119230636.1752684-1-christylee@fb.com> <20220119230636.1752684-3-christylee@fb.com>
 <Ye2LAEiXaBoj2n8Z@krava>
In-Reply-To: <Ye2LAEiXaBoj2n8Z@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Feb 2022 23:31:20 -0800
Message-ID: <CAEf4BzaDN7H45cHny6upY+0HNLmsA9oQdTrx3yA3WD=fjWJ4fw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] perf: stop using deprecated
 bpf_object__next() API
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Christy Lee <christyc.y.lee@gmail.com>,
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

On Sun, Jan 23, 2022 at 9:06 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Jan 19, 2022 at 03:06:36PM -0800, Christy Lee wrote:
>
> SNIP
>
> > ---
> >  tools/perf/util/bpf-loader.c | 72 +++++++++++++++++++++++++++---------
> >  tools/perf/util/bpf-loader.h |  1 +
> >  2 files changed, 55 insertions(+), 18 deletions(-)
> >
> > diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> > index 4631cac3957f..b1822f8af2bb 100644
> > --- a/tools/perf/util/bpf-loader.c
> > +++ b/tools/perf/util/bpf-loader.c
> > @@ -29,9 +29,6 @@
> >
> >  #include <internal/xyarray.h>
> >
> > -/* temporarily disable libbpf deprecation warnings */
> > -#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > -
> >  static int libbpf_perf_print(enum libbpf_print_level level __attribute__((unused)),
> >                             const char *fmt, va_list args)
> >  {
> > @@ -49,6 +46,36 @@ struct bpf_prog_priv {
> >       int *type_mapping;
> >  };
> >
> > +struct bpf_perf_object {
> > +     struct bpf_object *obj;
> > +     struct list_head list;
> > +};
> > +
> > +static LIST_HEAD(bpf_objects_list);
>
> hum.. I still can't see any code adding/removing bpf_perf_object
> objects to this list, and that's why the code is failing to remove
> probes
>
> because there are no objects to iterate on, so added probes stay
> configured and screw following tests
>
> you need something like below to add and del objects from
> bpf_objects_list list
>
> it also simplifies for_each macros to work just over perf_obj,
> because I wasn't patient enough to make it work with the extra
> bpf_object ;-) I don't mind if you fix that, but this way looks
> simpler to me

yep, I agree

>
> tests are working for me with this fix, please feel free to
> squash it into your change
>

I've just sent v5, I would really appreciate it if you could give the
changes another testing round. Thanks a lot, Jiri!

> thanks,
> jirka
>
>
> ---
> diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
> index 57b9591f7cbb..d09d25707f1e 100644
> --- a/tools/perf/tests/bpf.c
> +++ b/tools/perf/tests/bpf.c
> @@ -210,6 +210,11 @@ prepare_bpf(void *obj_buf, size_t obj_buf_sz, const char *name)
>                 pr_debug("Compile BPF program failed.\n");
>                 return NULL;
>         }
> +
> +       if (bpf_perf_object__add(obj)) {
> +               bpf_object__close(obj);
> +               return NULL;
> +       }

I actually moved this into bpf__prepare_load_buffer(), it felt better
to contain this logic within it. It follows what you did for
bpf__prepare_load() and allowed to keep bpf_perf_object__add() static.

In the end I got a patch which doesn't expose any new function outside
of bpf-loader.c, which I think is the best solution.

>         return obj;
>  }
>

[...]
