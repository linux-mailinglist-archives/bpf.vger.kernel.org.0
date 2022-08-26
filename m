Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F155A2BF1
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 18:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245006AbiHZQFa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 12:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344241AbiHZQF2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 12:05:28 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B9A7697E
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:05:25 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b5so2329796wrr.5
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Eve3FE7hOWsinCveAVX9btkiK/Cf9c1/3T/dGcwovAU=;
        b=oIRAeTZZXtyEI1qVYgsm+cggY3Mliak5OfKLrgEvg4J3HtAne/Ixhy4qpZ133xXkTJ
         XluRuBLn7hv8hPkqcKze/kDl/7ya7eh/LlXvhPCmLXW9kFiadRarEmHnjOoPx4KZWFsr
         TMSZnRIR9VmuC6NnvJG67u7vGhVkmuJ6YvfwH2P8iV79r9wMpIrpnzigtzjsGmPPnFzr
         CyLR5/v0RtXM+mOXxcMfIzBi1l37XxC6NmxbWgYowtAmd7a9uicTFeQdS9DrEK6adLTL
         YQpr8yz/qFSad5jhr0bPxzG0o2bIYS5wa2H4zeZenCS9B8O8BRwBypYy4kGVIb6x7D07
         D8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Eve3FE7hOWsinCveAVX9btkiK/Cf9c1/3T/dGcwovAU=;
        b=O1PjLERQsaAvDgS/JZLM9E8Mt2BGWTOCkEv4VE2FKbbp/PJMYYrq5AK98s+8XJuqfj
         0Ss15kwUPYDEMmQBpTCKu6gk1/C4SUwimqP2R9e9aVTFKH3AmpjLYp1rjnBWJQ51Xshk
         ECnCgTPFojyPljw0SNYWaGaBj+KXlzs3jQJxFeq0IG3sev7+ocd9tHF37+0L3ae4g9nr
         DrspTbxeuneX7tkBN8UJ8m8UEwvVoD8eqolpa0P0o99Xn2VeBrF3gGvyGIQSYX6a5S+C
         QTTGs65I1x56x7Wj3A9R15xeyNbF9WGgF9hGmJ4xdnwgtYg7FUyIQKaeIQCRG2ewy129
         A2hg==
X-Gm-Message-State: ACgBeo36eThPP0RSNb0SA9eK5EClOGsReWDlHN0ZxEZci9k7SteZENQS
        RyBfavfVE7v5GEY5y0QKHm+AagVbt0MJkwvNaeZw8w==
X-Google-Smtp-Source: AA6agR4WMcZViHYZpEd/SVtNnppVJwpOi1ucgCxNEiA6EzB60zAGxFEFit4aqH2BPsbjzmfKyLISll05O9Er9BqpMHY=
X-Received: by 2002:a05:6000:1008:b0:225:58e0:223f with SMTP id
 a8-20020a056000100800b0022558e0223fmr187277wrx.375.1661529923505; Fri, 26 Aug
 2022 09:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220824153901.488576-1-irogers@google.com> <20220824153901.488576-12-irogers@google.com>
 <12acbe02-bd73-07bb-d0e1-cb13dcd790c0@intel.com>
In-Reply-To: <12acbe02-bd73-07bb-d0e1-cb13dcd790c0@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 Aug 2022 09:05:11 -0700
Message-ID: <CAP-5=fWCpoqAhLzdMn1zHXfKpsYg0LQPMSz6Uy82+QL_MQpc8g@mail.gmail.com>
Subject: Re: [PATCH v3 11/18] perf dso: Update use of pthread mutex
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Weiguo Li <liwg06@foxmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
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

On Fri, Aug 26, 2022 at 3:37 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 24/08/22 18:38, Ian Rogers wrote:
> > Switch to the use of mutex wrappers that provide better error checking.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/dso.c    | 12 ++++++------
>
> Some not done yet
>
> $ grep -i pthread_mut tools/perf/util/dso.c
> static pthread_mutex_t dso__data_open_lock = PTHREAD_MUTEX_INITIALIZER;
>         pthread_mutex_lock(&dso__data_open_lock);
>         pthread_mutex_unlock(&dso__data_open_lock);
>         if (pthread_mutex_lock(&dso__data_open_lock) < 0)
>                 pthread_mutex_unlock(&dso__data_open_lock);
>         pthread_mutex_unlock(&dso__data_open_lock);
>         pthread_mutex_lock(&dso__data_open_lock);
>         pthread_mutex_unlock(&dso__data_open_lock);
>         pthread_mutex_lock(&dso__data_open_lock);
>         pthread_mutex_unlock(&dso__data_open_lock);

Yes, these are all solely dso__data_open_lock that lacks any clear
init/exit code to place the initialization/destruction hooks onto. I
don't plan to alter these in this patch set.

Thanks,
Ian

>
> >  tools/perf/util/dso.h    |  4 ++--
> >  tools/perf/util/symbol.c |  4 ++--
> >  3 files changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > index 5ac13958d1bd..a9789a955403 100644
> > --- a/tools/perf/util/dso.c
> > +++ b/tools/perf/util/dso.c
> > @@ -795,7 +795,7 @@ dso_cache__free(struct dso *dso)
> >       struct rb_root *root = &dso->data.cache;
> >       struct rb_node *next = rb_first(root);
> >
> > -     pthread_mutex_lock(&dso->lock);
> > +     mutex_lock(&dso->lock);
> >       while (next) {
> >               struct dso_cache *cache;
> >
> > @@ -804,7 +804,7 @@ dso_cache__free(struct dso *dso)
> >               rb_erase(&cache->rb_node, root);
> >               free(cache);
> >       }
> > -     pthread_mutex_unlock(&dso->lock);
> > +     mutex_unlock(&dso->lock);
> >  }
> >
> >  static struct dso_cache *__dso_cache__find(struct dso *dso, u64 offset)
> > @@ -841,7 +841,7 @@ dso_cache__insert(struct dso *dso, struct dso_cache *new)
> >       struct dso_cache *cache;
> >       u64 offset = new->offset;
> >
> > -     pthread_mutex_lock(&dso->lock);
> > +     mutex_lock(&dso->lock);
> >       while (*p != NULL) {
> >               u64 end;
> >
> > @@ -862,7 +862,7 @@ dso_cache__insert(struct dso *dso, struct dso_cache *new)
> >
> >       cache = NULL;
> >  out:
> > -     pthread_mutex_unlock(&dso->lock);
> > +     mutex_unlock(&dso->lock);
> >       return cache;
> >  }
> >
> > @@ -1297,7 +1297,7 @@ struct dso *dso__new_id(const char *name, struct dso_id *id)
> >               dso->root = NULL;
> >               INIT_LIST_HEAD(&dso->node);
> >               INIT_LIST_HEAD(&dso->data.open_entry);
> > -             pthread_mutex_init(&dso->lock, NULL);
> > +             mutex_init(&dso->lock);
> >               refcount_set(&dso->refcnt, 1);
> >       }
> >
> > @@ -1336,7 +1336,7 @@ void dso__delete(struct dso *dso)
> >       dso__free_a2l(dso);
> >       zfree(&dso->symsrc_filename);
> >       nsinfo__zput(dso->nsinfo);
> > -     pthread_mutex_destroy(&dso->lock);
> > +     mutex_destroy(&dso->lock);
> >       free(dso);
> >  }
> >
> > diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> > index 66981c7a9a18..58d94175e714 100644
> > --- a/tools/perf/util/dso.h
> > +++ b/tools/perf/util/dso.h
> > @@ -2,7 +2,6 @@
> >  #ifndef __PERF_DSO
> >  #define __PERF_DSO
> >
> > -#include <pthread.h>
> >  #include <linux/refcount.h>
> >  #include <linux/types.h>
> >  #include <linux/rbtree.h>
> > @@ -11,6 +10,7 @@
> >  #include <stdio.h>
> >  #include <linux/bitops.h>
> >  #include "build-id.h"
> > +#include "mutex.h"
> >
> >  struct machine;
> >  struct map;
> > @@ -145,7 +145,7 @@ struct dso_cache {
> >  struct auxtrace_cache;
> >
> >  struct dso {
> > -     pthread_mutex_t  lock;
> > +     struct mutex     lock;
> >       struct list_head node;
> >       struct rb_node   rb_node;       /* rbtree node sorted by long name */
> >       struct rb_root   *root;         /* root of rbtree that rb_node is in */
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index a4b22caa7c24..656d9b4dd456 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -1800,7 +1800,7 @@ int dso__load(struct dso *dso, struct map *map)
> >       }
> >
> >       nsinfo__mountns_enter(dso->nsinfo, &nsc);
> > -     pthread_mutex_lock(&dso->lock);
> > +     mutex_lock(&dso->lock);
> >
> >       /* check again under the dso->lock */
> >       if (dso__loaded(dso)) {
> > @@ -1964,7 +1964,7 @@ int dso__load(struct dso *dso, struct map *map)
> >               ret = 0;
> >  out:
> >       dso__set_loaded(dso);
> > -     pthread_mutex_unlock(&dso->lock);
> > +     mutex_unlock(&dso->lock);
> >       nsinfo__mountns_exit(&nsc);
> >
> >       return ret;
>
