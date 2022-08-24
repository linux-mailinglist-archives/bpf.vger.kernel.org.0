Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB5959FDBD
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 17:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbiHXPBn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 11:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239356AbiHXPBh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 11:01:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB24986731
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 08:01:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bq11so14542036wrb.12
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 08:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9MwRKo7p5mGuEOorxe18ICwvOojGU+Msts5Hm6mDUmM=;
        b=DHIFxLxTXAgmKsbJjZGy1lXpuYDVR2jq+dJVAIM0rh6V3yuD8QQfAom1LDARfKzsl+
         XPbDIDgDCWkUDgXOm8bmsdVC+BN4+x5CxVuRd51g0EdKzB0v31sXINtSdNwYi2Z/KAFT
         x+X+cL5bKKpYSzXOkRt2+VEdw3+GdCgMU4FZvP7lg4la1rFMzIknWizCD1JjLUV2QUqX
         VYMOQdMSGlq7WsX2UyUSEXw4kyK0nIjqFdBzsV7uYhBJ5w/XDJhqZPgnIyAlP/IOup9q
         w8k3tPvZ2X1ztqdWGHG3EaguNJG7GSJ/0W4ssLRBEzzcFjuVbROv7zXYwfDmkxT+3ZNk
         lotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9MwRKo7p5mGuEOorxe18ICwvOojGU+Msts5Hm6mDUmM=;
        b=l2PRlePkGuggxtDfEMkgjfPOy5Y9WSDLHS0WYD/Qkqr4it+zg8eE7lQ4VgNrtBC9NK
         tDuoIVNDB2FF9vpE2o5jnBKAKjN8QvEPohE3BQ9y68WMjgayN+Ko7yqMEtZfQjVDkCio
         to5mE5iPvId8CAeLoZZN8sEezNouahaN1b+wmBAXzOsERLdFU5yqQNKhyGoLAacv0fuU
         VOJnamepr52ENkBXn7FF07L28zKCSnCn8sIkmi9crbeEeRSJPtGmrKPBp4yyLEK9qlfb
         3qtT6jBMUUV6CMf8eO7s2r78HVqH0iGgUDFQ7Dz62IQA0X+HmyYjozAvCF6IxNltZCgm
         LKuQ==
X-Gm-Message-State: ACgBeo2w8Kw32QTi7e/dOSOzXYO+sVmhm1VlKeXVIjfUvcJAfZpWxRFG
        h98Rf4Y7a/AESSk+A0tJczYCGw5/TAhMxEld4sKwHA==
X-Google-Smtp-Source: AA6agR7HpNIT/fnUb42DSSIVVlV1mMl/8w4k0TKNasA3YcVRAe/dW1zFnuIFWQttSxtmk0z2PuivVtxuyY0WXQe9Dw0=
X-Received: by 2002:a05:6000:1008:b0:225:58e0:223f with SMTP id
 a8-20020a056000100800b0022558e0223fmr8713911wrx.375.1661353293134; Wed, 24
 Aug 2022 08:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220823220922.256001-1-irogers@google.com> <20220823220922.256001-2-irogers@google.com>
 <4e68941f-1370-0c23-6f42-44f3e19e65f7@intel.com>
In-Reply-To: <4e68941f-1370-0c23-6f42-44f3e19e65f7@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 24 Aug 2022 08:01:21 -0700
Message-ID: <CAP-5=fVLiY2J2P8p9GY=sn-kxHYp8iVdmpRcgTkLi9YJCT5QHQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] perf mutex: Wrapped usage of mutex and cond
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 24, 2022 at 2:45 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 24/08/22 01:09, Ian Rogers wrote:
> > From: Pavithra Gurushankar <gpavithrasha@gmail.com>
> >
> > Added a new header file mutex.h that wraps the usage of
> > pthread_mutex_t and pthread_cond_t. By abstracting these it is
> > possible to introduce error checking.
> >
> > Signed-off-by: Pavithra Gurushankar <gpavithrasha@gmail.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/Build   |  1 +
> >  tools/perf/util/mutex.c | 97 +++++++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/mutex.h | 43 ++++++++++++++++++
> >  3 files changed, 141 insertions(+)
> >  create mode 100644 tools/perf/util/mutex.c
> >  create mode 100644 tools/perf/util/mutex.h
> >
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 9dfae1bda9cc..8fd6dc8de521 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -143,6 +143,7 @@ perf-y += branch.o
> >  perf-y += mem2node.o
> >  perf-y += clockid.o
> >  perf-y += list_sort.o
> > +perf-y += mutex.o
> >
> >  perf-$(CONFIG_LIBBPF) += bpf-loader.o
> >  perf-$(CONFIG_LIBBPF) += bpf_map.o
> > diff --git a/tools/perf/util/mutex.c b/tools/perf/util/mutex.c
> > new file mode 100644
> > index 000000000000..d12cf0714268
> > --- /dev/null
> > +++ b/tools/perf/util/mutex.c
> > @@ -0,0 +1,97 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "mutex.h"
> > +
> > +#include "debug.h"
> > +#include <linux/string.h>
> > +#include <errno.h>
> > +
> > +static void check_err(const char *fn, int err)
> > +{
> > +     char sbuf[STRERR_BUFSIZE];
> > +
> > +     if (err == 0)
> > +             return;
> > +
> > +     pr_err("%s error: '%s'", fn, str_error_r(err, sbuf, sizeof(sbuf)));
>
> pr_err() does not add '\n' so it needs to be in the format string.

Thanks, will add in v3.

> > +}
> > +
> > +#define CHECK_ERR(err) check_err(__func__, err)
> > +
> > +void mutex_init(struct mutex *mtx, bool pshared)
> > +{
> > +     pthread_mutexattr_t attr;
> > +
> > +     CHECK_ERR(pthread_mutexattr_init(&attr));
> > +
> > +#ifndef NDEBUG
> > +     /* In normal builds enable error checking, such as recursive usage. */
> > +     CHECK_ERR(pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_ERRORCHECK));
> > +#endif
> > +     if (pshared)
> > +             pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
> > +
> > +     CHECK_ERR(pthread_mutex_init(&mtx->lock, &attr));
> > +     CHECK_ERR(pthread_mutexattr_destroy(&attr));
> > +}
> > +
> > +void mutex_destroy(struct mutex *mtx)
> > +{
> > +     CHECK_ERR(pthread_mutex_destroy(&mtx->lock));
> > +}
> > +
> > +void mutex_lock(struct mutex *mtx)
> > +{
> > +     CHECK_ERR(pthread_mutex_lock(&mtx->lock));
> > +}
> > +
> > +void mutex_unlock(struct mutex *mtx)
> > +{
> > +     CHECK_ERR(pthread_mutex_unlock(&mtx->lock));
> > +}
> > +
> > +bool mutex_trylock(struct mutex *mtx)
> > +{
> > +     int ret = pthread_mutex_trylock(&mtx->lock);
> > +
> > +     if (ret == 0)
> > +             return true; /* Lock acquired. */
> > +
> > +     if (ret == EBUSY)
> > +             return false; /* Lock busy. */
> > +
> > +     /* Print error. */
> > +     CHECK_ERR(ret);
> > +     return false;
> > +}
> > +
> > +void cond_init(struct cond *cnd, bool pshared)
> > +{
> > +     pthread_condattr_t attr;
> > +
> > +     CHECK_ERR(pthread_condattr_init(&attr));
> > +     if (pshared)
> > +             CHECK_ERR(pthread_condattr_setpshared(&attr, PTHREAD_PROCESS_SHARED));
> > +
> > +     CHECK_ERR(pthread_cond_init(&cnd->cond, &attr));
> > +     CHECK_ERR(pthread_condattr_destroy(&attr));
> > +}
> > +
> > +void cond_destroy(struct cond *cnd)
> > +{
> > +     CHECK_ERR(pthread_cond_destroy(&cnd->cond));
> > +}
> > +
> > +void cond_wait(struct cond *cnd, struct mutex *mtx)
> > +{
> > +     CHECK_ERR(pthread_cond_wait(&cnd->cond, &mtx->lock));
> > +}
> > +
> > +void cond_signal(struct cond *cnd)
> > +{
> > +     CHECK_ERR(pthread_cond_signal(&cnd->cond));
> > +}
> > +
> > +void cond_broadcast(struct cond *cnd)
> > +{
> > +     CHECK_ERR(pthread_cond_broadcast(&cnd->cond));
> > +}
> > diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
> > new file mode 100644
> > index 000000000000..952276ad83bd
> > --- /dev/null
> > +++ b/tools/perf/util/mutex.h
> > @@ -0,0 +1,43 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __PERF_MUTEX_H
> > +#define __PERF_MUTEX_H
> > +
> > +#include <pthread.h>
> > +#include <stdbool.h>
> > +
> > +/*
> > + * A wrapper around the mutex implementation that allows perf to error check
> > + * usage, etc.
> > + */
> > +struct mutex {
> > +     pthread_mutex_t lock;
> > +};
> > +
> > +/* A wrapper around the condition variable implementation. */
> > +struct cond {
> > +     pthread_cond_t cond;
> > +};
>
> Do these definitions need to be in the header?
> What about just:
>
> struct mutex;
> struct cond;
>
> and put the defintions in mutex.c.

Agreed, unfortunately struct mutex is a variable in a bunch of structs
and without the definition in the header file the size is missing.

Thanks,
Ian

> > +
> > +/*
> > + * Initialize the mtx struct, if pshared is set then specify the process-shared
> > + * rather than default process-private attribute.
> > + */
> > +void mutex_init(struct mutex *mtx, bool pshared);
> > +void mutex_destroy(struct mutex *mtx);
> > +
> > +void mutex_lock(struct mutex *mtx);
> > +void mutex_unlock(struct mutex *mtx);
> > +bool mutex_trylock(struct mutex *mtx);
> > +
> > +/*
> > + * Initialize the cond struct, if pshared is set then specify the process-shared
> > + * rather than default process-private attribute.
> > + */
> > +void cond_init(struct cond *cnd, bool pshared);
> > +void cond_destroy(struct cond *cnd);
> > +
> > +void cond_wait(struct cond *cnd, struct mutex *mtx);
> > +void cond_signal(struct cond *cnd);
> > +void cond_broadcast(struct cond *cnd);
> > +
> > +#endif /* __PERF_MUTEX_H */
>
