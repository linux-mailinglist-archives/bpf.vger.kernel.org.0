Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DB853C0D8
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 00:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239705AbiFBWgK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Jun 2022 18:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239701AbiFBWgI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jun 2022 18:36:08 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A0037A28;
        Thu,  2 Jun 2022 15:36:06 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so5939282pjb.3;
        Thu, 02 Jun 2022 15:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jo2J8+ccPmmLsK98tmMIOCw7bUiOFRU2CRVDZrgo/XQ=;
        b=VkJWUTc9vAoRc2WyGAFvtGoiHVtuQnDXWvQjuY0tcuzhnmmpzXh3PNonyGzw9P2ZtI
         T9c06sZWImHSrV7P1FHwZ5VIkE1xSHrgXBE5EvzTHOMA61MWv6KDwM7GJfQgcPgSFkNi
         xoLDjDkTRyR08vJtaNSjC4aYExux47Q5SvMeW0aV+3D5bAdBfQw2Fz0/aeb1QUdRqOTM
         p0/D7x5wGQDa/z8LCWCOp4EH5jZUmu3WnMKXeIwEputPHc3P0A+mlHgbgaVY5lZ08bpA
         19DXhn0Fs+A1QCkS+jWsl+rSCeZIcAwvz49XmSD3qHhg2FKme3Uc70io8Qw458u+tpJH
         WrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jo2J8+ccPmmLsK98tmMIOCw7bUiOFRU2CRVDZrgo/XQ=;
        b=bzIeBe9rUOnvGhXgWuhuImob7u3CmprpHu10aPdbeFQWjAPFgHsGqwyKu2G9IYM7QN
         GzjcvqyV0Q36RPie0xpnOCdjH/EewaOs3nmK2Sdhb9DujfBDd+k7DUlxHwPBDf5hAnaP
         tdVkFCruqh9wnqNNoq78JMZUG61+awsatSSP7hmkHGQc14HO8YvzNHOE0Q4A4wlZ/Wk0
         MGwF1DONx2Tw8OqpFz2X23raAnIOsGVJwVL0KNXxkYUfztGOnFmngwadUCe2vTAIeyY8
         HryiM37plMukzK1N62QXzs8cHg3lfygGv7LbquEgjkCpV09JbkVKHtUyea+6O1ERgViv
         9uKw==
X-Gm-Message-State: AOAM5333tWmmrEd/fdyEaaeKbna7RZh/oLULeeniA1hPD6s3w4rm4MeN
        WuyY0XdXOQm4zLp5XsdY7WU=
X-Google-Smtp-Source: ABdhPJxe6WkXYFixrqeh0Jgn34I+s6pZkLGA6PhFTUXTTIrP2z1yYt4VKDNPFkieqKyjq/SIniZ7xA==
X-Received: by 2002:a17:902:f64f:b0:156:f1cc:b284 with SMTP id m15-20020a170902f64f00b00156f1ccb284mr6847756plg.147.1654209366094;
        Thu, 02 Jun 2022 15:36:06 -0700 (PDT)
Received: from google.com ([2620:15c:2c1:200:84f2:5eb8:b22d:654d])
        by smtp.gmail.com with ESMTPSA id j16-20020a17090a7e9000b001e32824c452sm6103895pjl.40.2022.06.02.15.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 15:36:05 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Thu, 2 Jun 2022 15:36:03 -0700
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Blake Jones <blakejones@google.com>
Subject: Re: [PATCH 2/6] perf record: Enable off-cpu analysis with BPF
Message-ID: <Ypk7U1Ce4Muq3l5U@google.com>
References: <20220518224725.742882-1-namhyung@kernel.org>
 <20220518224725.742882-3-namhyung@kernel.org>
 <CAP-5=fX=fiuZ31O2XTSsAwyGD=c5uf9P_BzX9L1QG-q8cUvQYQ@mail.gmail.com>
 <CAM9d7cjT2o3xVUQf402shzirD4K2XoyomN+AL_R2WENKg6pwoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM9d7cjT2o3xVUQf402shzirD4K2XoyomN+AL_R2WENKg6pwoQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 31, 2022 at 11:01:14PM -0700, Namhyung Kim wrote:
> On Tue, May 31, 2022 at 5:00 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, May 18, 2022 at 3:47 PM Namhyung Kim <namhyung@kernel.org> wrote:
> [SNIP]
> > > +
> > > +/*
> > > + * Old kernel used to call it task_struct->state and now it's '__state'.
> > > + * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
> > > + *
> > > + * https://nakryiko.com/posts/bpf-core-reference-guide/#handling-incompatible-field-and-type-changes
> > > + */
> > > +static inline int get_task_state(struct task_struct *t)
> > > +{
> > > +       if (bpf_core_field_exists(t->__state))
> > > +               return BPF_CORE_READ(t, __state);
> > > +
> >
> > When building against a pre-5.14 kernel I'm running into a build issue here:
> >
> > tools/perf/util/bpf_skel/off_cpu.bpf.c:96:31: error: no member named '__
> > state' in 'struct task_struct'; did you mean 'state'?
> >        if (bpf_core_field_exists(t->__state))
> >                                     ^~~~~~~
> >                                     state
> >
> > This isn't covered by Andrii's BPF CO-RE reference guide. I have an
> > #iffy workaround below,but this will be brittle if the 5.14+ kernel
> > code is backported. Suggestions welcomed :-)
> 
> Thanks for the fix.  I think we should not guess the field name
> in the current task struct and check both versions separately.
> I'm afraid the version check won't work with some backported
> kernels.  But do we care?


What about this instead?

----8<----
From a621f836f00e11942e5d39a735ec8f7a21962d6a Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 31 May 2022 14:25:05 -0700
Subject: [PATCH] perf tools: Fix a build failure in off-cpu BPF program on old kernels

Old kernels have task_struct which contains "state" field.  While the
get_task_state() in the BPF code handles that, it assumed the kernel
has the new definition and caused a build error on old kernels.

We should not assume anything and access them carefully.

Reported-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_skel/off_cpu.bpf.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index 792ae2847080..cc6d7fd55118 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -71,6 +71,11 @@ struct {
 	__uint(max_entries, 1);
 } cgroup_filter SEC(".maps");
 
+/* new kernel task_struct definition */
+struct task_struct___new {
+	long __state;
+} __attribute__((preserve_access_index));
+
 /* old kernel task_struct definition */
 struct task_struct___old {
 	long state;
@@ -93,14 +98,17 @@ const volatile bool uses_cgroup_v1 = false;
  */
 static inline int get_task_state(struct task_struct *t)
 {
-	if (bpf_core_field_exists(t->__state))
-		return BPF_CORE_READ(t, __state);
+	/* recast pointer to capture new type for compiler */
+	struct task_struct___new *t_new = (void *)t;
 
-	/* recast pointer to capture task_struct___old type for compiler */
-	struct task_struct___old *t_old = (void *)t;
+	if (bpf_core_field_exists(t_new->__state)) {
+		return BPF_CORE_READ(t_new, __state);
+	} else {
+		/* recast pointer to capture old type for compiler */
+		struct task_struct___old *t_old = (void *)t;
 
-	/* now use old "state" name of the field */
-	return BPF_CORE_READ(t_old, state);
+		return BPF_CORE_READ(t_old, state);
+	}
 }
 
 static inline __u64 get_cgroup_id(struct task_struct *t)
-- 
2.36.1.255.ge46751e96f-goog

