Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02136451CE
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 03:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiLGCOM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 21:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiLGCOL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 21:14:11 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF28B53EFA
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 18:14:10 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 140so16264407pfz.6
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 18:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U0PycYu4rQk5qW/WCNTfFm99rKJzRZBVekAsNql6swg=;
        b=WZDj3N17NznmzN1u7jDU0xo5FlScEVZXs1YGsbSwCSzHC8ZgdNsWWYNII5Lu51U7qg
         xbYHyWxF8d0+j/XpejQB8+vr/XxYf0ZnLX8n4553mDCIiaTpXnP0P7Hr0avDjIE6We55
         tduh2r73l5eSLYCaFIzEVaOVBZ3HI2KKEri3gWC8ASQLyOwM3T4VaSRcruQ82D5SdR6m
         BQBHT/5N20ePbCAOaxcPw5Jr53BAeTWDVd+bPogy7JwqOU8bXECi3Ao0pBSADEkWEUjk
         W7/meB93FqchsY2WHs7FZvyS1NtakBoZzJux4/4YH1e9O25jlPLJdkFBF4SP/6y60yw8
         pNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0PycYu4rQk5qW/WCNTfFm99rKJzRZBVekAsNql6swg=;
        b=SfLCVtjH4JbhlDWWe1zP7uC+4ASMpKiCeGnQTrTfZaQV8goyMB/qIgvEVLwZX02bw6
         GBE37ukqgtkCF1VMe5PSgps+qyWN9OChlgGB9U+zvrbIGoOK8eqwQm+mDet+bTUUZxTm
         pMoik+f9M4oha+ntzBnyNhnL5x1/yEMN0X/ryDmAIa0njtPZDBSV0AoorN+jR72qR3mC
         mproklA/qinXtnbcXK3S0TNx+xxx7FBE0Kc72cqe1CcGoyHjHvHlUYYxuVsnfDpOAsbo
         QCtYRlat9Yr3UqMBThSIZERW4uqFA2qASzHdKvGrV3tCgKXO5t6OFds/r4r/VZQAnEZK
         3YPg==
X-Gm-Message-State: ANoB5pkz/5tVoIH/bcIAb9tFOotQ/7yK0rd5MrefEO/9WCjrFY1IwGp0
        Tv3mFDgna8duZi6Byu/lEkY=
X-Google-Smtp-Source: AA0mqf5FiQTmy9ksJS9H7C/+74MGJu2QJm1jcxvTEfxgygU1+fERtKT4w6iZG7gojWUYcY/sgx8FZw==
X-Received: by 2002:a63:1812:0:b0:476:85ee:aee2 with SMTP id y18-20020a631812000000b0047685eeaee2mr62764643pgl.582.1670379250241;
        Tue, 06 Dec 2022 18:14:10 -0800 (PST)
Received: from google.com ([2620:15c:2d4:203:2130:8766:1cdb:c499])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903121000b0018157b415dbsm13387760plh.63.2022.12.06.18.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 18:14:09 -0800 (PST)
Date:   Tue, 6 Dec 2022 18:14:06 -0800
From:   Namhyung Kim <namhyung@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Sun <sunhao.th@gmail.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next] bpf: Restrict attachment of bpf program to some
 tracepoints
Message-ID: <Y4/27g8EHQ9F3bDr@google.com>
References: <20221121213123.1373229-1-jolsa@kernel.org>
 <bcdac077-3043-a648-449d-1b60037388de@iogearbox.net>
 <Y388m6wOktvZo1d4@krava>
 <CAADnVQJ5knvWaxVa=9_Ag3DU_qewGBbHGv_ZH=K+ETUWM1qAmA@mail.gmail.com>
 <Y4CMbTeVud0WfPtK@krava>
 <CAEf4BzZP9z3kdzn=04EvAprG-Ldrsegy5JkzvoBPvcdMG_vvGg@mail.gmail.com>
 <Y4uOSrXBxVwnxZkX@google.com>
 <Y43j3IGvLKgshuhR@krava>
 <CAADnVQLo1JBTg6iquCFj44AEuAhxj-V7a0T1gwejy1oDBDXcbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQLo1JBTg6iquCFj44AEuAhxj-V7a0T1gwejy1oDBDXcbA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 06, 2022 at 12:09:51PM -0800, Alexei Starovoitov wrote:
> On Mon, Dec 5, 2022 at 4:28 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 3bbd3f0c810c..d27b7dc77894 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2252,9 +2252,8 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
> >  }
> >
> >  static __always_inline
> > -void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
> > +void __bpf_trace_prog_run(struct bpf_prog *prog, u64 *args)
> >  {
> > -       cant_sleep();
> >         if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
> >                 bpf_prog_inc_misses_counter(prog);
> >                 goto out;
> > @@ -2266,6 +2265,22 @@ void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
> >         this_cpu_dec(*(prog->active));
> >  }
> >
> > +static __always_inline
> > +void __bpf_trace_run(struct bpf_raw_event_data *data, u64 *args)
> > +{
> > +       struct bpf_prog *prog = data->prog;
> > +
> > +       cant_sleep();
> > +       if (unlikely(!data->recursion))
> > +               return __bpf_trace_prog_run(prog, args);
> > +
> > +       if (unlikely(this_cpu_inc_return(*(data->recursion))))
> > +               goto out;
> > +       __bpf_trace_prog_run(prog, args);
> > +out:
> > +       this_cpu_dec(*(data->recursion));
> > +}
> 
> This is way too much run-time and memory overhead to address
> this corner case. Pls come up with some other approach.
> Sorry I don't have decent suggestions at the moment.
> For now we can simply disallow attaching to contention_begin.
> 

How about this?  It seems to work for me.

Thanks,
Namhyung

---
 include/linux/trace_events.h    | 14 +++++++
 include/linux/tracepoint-defs.h |  5 +++
 kernel/bpf/syscall.c            | 18 ++++++++-
 kernel/trace/bpf_trace.c        | 65 ++++++++++++++++++++++++++++++---
 4 files changed, 95 insertions(+), 7 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 20749bd9db71..461468210a77 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -742,6 +742,10 @@ void perf_event_detach_bpf_prog(struct perf_event *event);
 int perf_event_query_prog_array(struct perf_event *event, void __user *info);
 int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog);
 int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *prog);
+int bpf_probe_register_norecurse(struct bpf_raw_event_map *btp, struct bpf_prog *prog,
+				 struct bpf_raw_event_data *data);
+int bpf_probe_unregister_norecurse(struct bpf_raw_event_map *btp,
+				   struct bpf_raw_event_data *data);
 struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name);
 void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp);
 int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
@@ -775,6 +779,16 @@ static inline int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf
 {
 	return -EOPNOTSUPP;
 }
+static inline int bpf_probe_register_norecurse(struct bpf_raw_event_map *btp, struct bpf_prog *p,
+					       struct bpf_raw_event_data *data)
+{
+	return -EOPNOTSUPP;
+}
+static inline int bpf_probe_unregister_norecurse(struct bpf_raw_event_map *btp,
+						 struct bpf_raw_event_data *data)
+{
+	return -EOPNOTSUPP;
+}
 static inline struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name)
 {
 	return NULL;
diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
index e7c2276be33e..e5adfe606888 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -53,6 +53,11 @@ struct bpf_raw_event_map {
 	u32			writable_size;
 } __aligned(32);
 
+struct bpf_raw_event_data {
+	struct bpf_prog		*prog;
+	int __percpu		*active;
+};
+
 /*
  * If a tracepoint needs to be called from a header file, it is not
  * recommended to call it directly, as tracepoints in header files
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 35972afb6850..a8be9c443306 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3144,14 +3144,24 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 struct bpf_raw_tp_link {
 	struct bpf_link link;
 	struct bpf_raw_event_map *btp;
+	struct bpf_raw_event_data data;
 };
 
+static bool needs_recursion_check(struct bpf_raw_event_map *btp)
+{
+	return !strcmp(btp->tp->name, "contention_begin");
+}
+
 static void bpf_raw_tp_link_release(struct bpf_link *link)
 {
 	struct bpf_raw_tp_link *raw_tp =
 		container_of(link, struct bpf_raw_tp_link, link);
 
-	bpf_probe_unregister(raw_tp->btp, raw_tp->link.prog);
+	if (needs_recursion_check(raw_tp->btp))
+		bpf_probe_unregister_norecurse(raw_tp->btp, &raw_tp->data);
+	else
+		bpf_probe_unregister(raw_tp->btp, raw_tp->link.prog);
+
 	bpf_put_raw_tracepoint(raw_tp->btp);
 }
 
@@ -3348,7 +3358,11 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
 		goto out_put_btp;
 	}
 
-	err = bpf_probe_register(link->btp, prog);
+	if (needs_recursion_check(link->btp))
+		err = bpf_probe_register_norecurse(link->btp, prog, &link->data);
+	else
+		err = bpf_probe_register(link->btp, prog);
+
 	if (err) {
 		bpf_link_cleanup(&link_primer);
 		goto out_put_btp;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3bbd3f0c810c..edbfeff029aa 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2297,7 +2297,20 @@ void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
 		REPEAT(x, COPY, __DL_SEM, __SEQ_0_11);			\
 		__bpf_trace_run(prog, args);				\
 	}								\
-	EXPORT_SYMBOL_GPL(bpf_trace_run##x)
+	EXPORT_SYMBOL_GPL(bpf_trace_run##x);				\
+									\
+	static void bpf_trace_run_norecurse##x(struct bpf_raw_event_data *data,	\
+			      REPEAT(x, SARG, __DL_COM, __SEQ_0_11))	\
+	{								\
+		u64 args[x];						\
+		if (unlikely(this_cpu_inc_return(*(data->active)) != 1)) \
+			goto out;					\
+		REPEAT(x, COPY, __DL_SEM, __SEQ_0_11);			\
+		__bpf_trace_run(data->prog, args);			\
+	out:								\
+		this_cpu_dec(*(data->active));				\
+	}
+
 BPF_TRACE_DEFN_x(1);
 BPF_TRACE_DEFN_x(2);
 BPF_TRACE_DEFN_x(3);
@@ -2311,7 +2324,23 @@ BPF_TRACE_DEFN_x(10);
 BPF_TRACE_DEFN_x(11);
 BPF_TRACE_DEFN_x(12);
 
-static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
+static void *bpf_trace_norecurse_funcs[12] = {
+	(void *)bpf_trace_run_norecurse1,
+	(void *)bpf_trace_run_norecurse2,
+	(void *)bpf_trace_run_norecurse3,
+	(void *)bpf_trace_run_norecurse4,
+	(void *)bpf_trace_run_norecurse5,
+	(void *)bpf_trace_run_norecurse6,
+	(void *)bpf_trace_run_norecurse7,
+	(void *)bpf_trace_run_norecurse8,
+	(void *)bpf_trace_run_norecurse9,
+	(void *)bpf_trace_run_norecurse10,
+	(void *)bpf_trace_run_norecurse11,
+	(void *)bpf_trace_run_norecurse12,
+};
+
+static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog,
+				void *func, void *data)
 {
 	struct tracepoint *tp = btp->tp;
 
@@ -2325,13 +2354,12 @@ static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *
 	if (prog->aux->max_tp_access > btp->writable_size)
 		return -EINVAL;
 
-	return tracepoint_probe_register_may_exist(tp, (void *)btp->bpf_func,
-						   prog);
+	return tracepoint_probe_register_may_exist(tp, func, data);
 }
 
 int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
 {
-	return __bpf_probe_register(btp, prog);
+	return __bpf_probe_register(btp, prog, btp->bpf_func, prog);
 }
 
 int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
@@ -2339,6 +2367,33 @@ int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
 	return tracepoint_probe_unregister(btp->tp, (void *)btp->bpf_func, prog);
 }
 
+int bpf_probe_register_norecurse(struct bpf_raw_event_map *btp, struct bpf_prog *prog,
+				 struct bpf_raw_event_data *data)
+{
+	void *bpf_func;
+
+	data->active = alloc_percpu_gfp(int, GFP_KERNEL);
+	if (!data->active)
+		return -ENOMEM;
+
+	data->prog = prog;
+	bpf_func = bpf_trace_norecurse_funcs[btp->num_args];
+	return __bpf_probe_register(btp, prog, bpf_func, data);
+}
+
+int bpf_probe_unregister_norecurse(struct bpf_raw_event_map *btp,
+				   struct bpf_raw_event_data *data)
+{
+	int err;
+	void *bpf_func;
+
+	bpf_func = bpf_trace_norecurse_funcs[btp->num_args];
+	err = tracepoint_probe_unregister(btp->tp, bpf_func, data);
+	free_percpu(data->active);
+
+	return err;
+}
+
 int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 			    u32 *fd_type, const char **buf,
 			    u64 *probe_offset, u64 *probe_addr)
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

