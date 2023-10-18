Return-Path: <bpf+bounces-12619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F91F7CEBDE
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 01:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64B0CB2114E
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 23:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28B036B03;
	Wed, 18 Oct 2023 23:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7BB1EB24;
	Wed, 18 Oct 2023 23:20:49 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B03D51;
	Wed, 18 Oct 2023 16:20:42 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-27d23f1e3b8so5619406a91.1;
        Wed, 18 Oct 2023 16:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697671242; x=1698276042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UufSU0DJZN7WnStqbSdFLZOGonoM+uqnsYlL8bCP5z8=;
        b=FogSghdWNbnqLh0STBS4o+Tc5LukwGDkIxTKzAAfcLjWXc7K/jghnRCKlEWXAsmxHn
         0zr0VwbGjw7BgZmiK8GJI85JB7IRoprUimdiN5/4LduZ/TTdkIbJxj4+TEysqqw0JzVS
         AC1kKsGx6HIuAx4JN033ok89NyaswmhggyLnQci0ve4c09GkkKsQIGy4ENWtvUg8m+Ms
         IKHf6Ml0nPLyOZb2aCgxxWX6i6LYeW3jvOB/fOk/2YDGDeEibUVxqtu0vmvpuNkTl1b6
         K9icgTwcdwucRHjE/eNcM/cPi/K4yVk0nLQ30YUdcV0ELFupV5l/Vb3lO1k6tkTYWCp7
         Ut8A==
X-Gm-Message-State: AOJu0Yzfzl4l/sN67MDXdaym6T+PEZpEinfXyw5kyawrzmUpalPwmCPg
	ZfjkQEE9oabNIsUYr8piK6Hzt5kBx8jRu4ZNfL8=
X-Google-Smtp-Source: AGHT+IGdjwGljjSza0sZKxQY8YEKvPn0ojx/+eccPOPHfSAMDF/EH5hh0ixHltoELua5mfzjbUW8bboJ3eLW7UbEgSk=
X-Received: by 2002:a17:90b:4b49:b0:27d:8d0:713e with SMTP id
 mi9-20020a17090b4b4900b0027d08d0713emr655906pjb.10.1697671241931; Wed, 18 Oct
 2023 16:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com> <20231012062359.1616786-10-irogers@google.com>
In-Reply-To: <20231012062359.1616786-10-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 18 Oct 2023 16:20:30 -0700
Message-ID: <CAM9d7cih9+DCKzVXBFTMUfjjY6ZX-yrj3CEM+Q3tjTNRYmQ=Yw@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] perf mem_info: Add and use map_symbol__exit and addr_map_symbol__exit
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	James Clark <james.clark@arm.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>, 
	German Gomez <german.gomez@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 11:24=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Fix leak where mem_info__put wouldn't release the maps/map as used by
> perf mem. Add exit functions and use elsewhere that the maps and map
> are released.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/Build        |  1 +
>  tools/perf/util/callchain.c  | 15 +++++----------
>  tools/perf/util/hist.c       |  6 ++----
>  tools/perf/util/machine.c    |  6 ++----
>  tools/perf/util/map_symbol.c | 15 +++++++++++++++
>  tools/perf/util/map_symbol.h |  4 ++++
>  tools/perf/util/symbol.c     |  5 ++++-
>  7 files changed, 33 insertions(+), 19 deletions(-)
>  create mode 100644 tools/perf/util/map_symbol.c
>
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 0ea5a9d368d4..96058f949ec9 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -49,6 +49,7 @@ perf-y +=3D dso.o
>  perf-y +=3D dsos.o
>  perf-y +=3D symbol.o
>  perf-y +=3D symbol_fprintf.o
> +perf-y +=3D map_symbol.o
>  perf-y +=3D color.o
>  perf-y +=3D color_config.o
>  perf-y +=3D metricgroup.o
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 0a7919c2af91..02881d5b822c 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -1496,16 +1496,14 @@ static void free_callchain_node(struct callchain_=
node *node)
>
>         list_for_each_entry_safe(list, tmp, &node->parent_val, list) {
>                 list_del_init(&list->list);
> -               map__zput(list->ms.map);
> -               maps__zput(list->ms.maps);
> +               map_symbol__exit(&list->ms);
>                 zfree(&list->brtype_stat);
>                 free(list);
>         }
>
>         list_for_each_entry_safe(list, tmp, &node->val, list) {
>                 list_del_init(&list->list);
> -               map__zput(list->ms.map);
> -               maps__zput(list->ms.maps);
> +               map_symbol__exit(&list->ms);
>                 zfree(&list->brtype_stat);
>                 free(list);
>         }
> @@ -1591,8 +1589,7 @@ int callchain_node__make_parent_list(struct callcha=
in_node *node)
>  out:
>         list_for_each_entry_safe(chain, new, &head, list) {
>                 list_del_init(&chain->list);
> -               map__zput(chain->ms.map);
> -               maps__zput(chain->ms.maps);
> +               map_symbol__exit(&chain->ms);
>                 zfree(&chain->brtype_stat);
>                 free(chain);
>         }
> @@ -1676,10 +1673,8 @@ void callchain_cursor_reset(struct callchain_curso=
r *cursor)
>         cursor->nr =3D 0;
>         cursor->last =3D &cursor->first;
>
> -       for (node =3D cursor->first; node !=3D NULL; node =3D node->next)=
 {
> -               map__zput(node->ms.map);
> -               maps__zput(node->ms.maps);
> -       }
> +       for (node =3D cursor->first; node !=3D NULL; node =3D node->next)
> +               map_symbol__exit(&node->ms);
>  }
>
>  void callchain_param_setup(u64 sample_type, const char *arch)
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index ac8c0ef48a7f..d62693b8fad8 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -524,8 +524,7 @@ static int hist_entry__init(struct hist_entry *he,
>                 map__put(he->mem_info->daddr.ms.map);
>         }
>  err:
> -       maps__zput(he->ms.maps);
> -       map__zput(he->ms.map);
> +       map_symbol__exit(&he->ms);
>         zfree(&he->stat_acc);
>         return -ENOMEM;
>  }
> @@ -1317,8 +1316,7 @@ void hist_entry__delete(struct hist_entry *he)
>         struct hist_entry_ops *ops =3D he->ops;
>
>         thread__zput(he->thread);
> -       maps__zput(he->ms.maps);
> -       map__zput(he->ms.map);
> +       map_symbol__exit(&he->ms);
>
>         if (he->branch_info) {
>                 map__zput(he->branch_info->from.ms.map);

What about he->branch_info and he->mem_info ?

Also I think we can use it in hists__account_cycles() too.

Thanks,
Namhyung


> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 8e5085b77c7b..6ca7500e2cf4 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2389,8 +2389,7 @@ static int add_callchain_ip(struct thread *thread,
>                                       iter_cycles, branch_from, srcline);
>  out:
>         addr_location__exit(&al);
> -       maps__put(ms.maps);
> -       map__put(ms.map);
> +       map_symbol__exit(&ms);
>         return err;
>  }
>
> @@ -3116,8 +3115,7 @@ static int append_inlines(struct callchain_cursor *=
cursor, struct map_symbol *ms
>                 if (ret !=3D 0)
>                         return ret;
>         }
> -       map__put(ilist_ms.map);
> -       maps__put(ilist_ms.maps);
> +       map_symbol__exit(&ilist_ms);
>
>         return ret;
>  }
> diff --git a/tools/perf/util/map_symbol.c b/tools/perf/util/map_symbol.c
> new file mode 100644
> index 000000000000..bef5079f2403
> --- /dev/null
> +++ b/tools/perf/util/map_symbol.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "map_symbol.h"
> +#include "maps.h"
> +#include "map.h"
> +
> +void map_symbol__exit(struct map_symbol *ms)
> +{
> +       maps__zput(ms->maps);
> +       map__zput(ms->map);
> +}
> +
> +void addr_map_symbol__exit(struct addr_map_symbol *ams)
> +{
> +       map_symbol__exit(&ams->ms);
> +}
> diff --git a/tools/perf/util/map_symbol.h b/tools/perf/util/map_symbol.h
> index e08817b0c30f..72d5ed938ed6 100644
> --- a/tools/perf/util/map_symbol.h
> +++ b/tools/perf/util/map_symbol.h
> @@ -22,4 +22,8 @@ struct addr_map_symbol {
>         u64           phys_addr;
>         u64           data_page_size;
>  };
> +
> +void map_symbol__exit(struct map_symbol *ms);
> +void addr_map_symbol__exit(struct addr_map_symbol *ams);
> +
>  #endif // __PERF_MAP_SYMBOL
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 2740d4457c13..d67a87072eec 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -2790,8 +2790,11 @@ struct mem_info *mem_info__get(struct mem_info *mi=
)
>
>  void mem_info__put(struct mem_info *mi)
>  {
> -       if (mi && refcount_dec_and_test(&mi->refcnt))
> +       if (mi && refcount_dec_and_test(&mi->refcnt)) {
> +               addr_map_symbol__exit(&mi->iaddr);
> +               addr_map_symbol__exit(&mi->daddr);
>                 free(mi);
> +       }
>  }
>
>  struct mem_info *mem_info__new(void)
> --
> 2.42.0.609.gbb76f46606-goog
>

