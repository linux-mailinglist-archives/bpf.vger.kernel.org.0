Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD67E6468F5
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 07:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiLHGPS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 01:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLHGPR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 01:15:17 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380EF9AE0D
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 22:15:16 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so3624769pjr.3
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 22:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sdSg3/5eCxsSQjTWVDS6V5oA2FFrD8UE+qMi388FuEI=;
        b=PLS4Qvp68e/O9Snizz9fiAgN8sVYwQ4rjcOXtVUrST1xW3W2bNHNkY+5Q6Fzvrqr1D
         Se67bMvMwxv3g3yXelST/Sg1Z7RyOV/IPFY5vmwmn+WJ2YACpvfgH6obbn2SdgzP5TNW
         xFw1l6IgIzWu0dKRdiJGoH266Tp0Lp/mpzWCrAI6ZwEt7S8QDoilIpMCFaBYIv06fKhD
         CO9SHXgyAIeMz+bo6VYlq7DlRd5velc0JdJOB9DxD2hcHMlwgzGJ3RnQSUq0fh4tS0tG
         9vw+vIfiLe2CJTvugmasDP5mpXmZSXR99L3G0O3M/ksZyhX3hNmN7UFxX1HwslcBrKr/
         Y77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdSg3/5eCxsSQjTWVDS6V5oA2FFrD8UE+qMi388FuEI=;
        b=hxxIoIshrRr3r/VC+C6oOH1Z7ltbIrxXgbA85LoMUWCuAGpBLhnFzpKGFyKhVgSsAA
         dvPDYSaHQuOAen6/4FoungMcASkWmwINTq0hC74HS+bnyLKnEynL9o//uY30dnzAoETY
         ZsDY6sBaWqUkqQO8I2h5eWlEofdQTu9xKRDhhWXDgHHHTTtHP+JVkVmAnVDnahUnJRCF
         avXOAXXoy+Hp3RJfBQL32WBbCxZg3DxrV2dEdH+whKFKoGgj1s+oalR9Gx4YhgTkU4Wt
         AFD6Wc03PRK/oLZzkPBA+T8DaDGi+ScXifWilqlxzBZu4feuAqpkrfLgLiVVbkUVOzc7
         UcBw==
X-Gm-Message-State: ANoB5plTd6wSMF3JLnjTPIheswDk8Df7kribwV/0vRnSDreRoqg0DA8s
        vTnHYmXQ1AlUphxa5FaKum+gqjX4M2Y=
X-Google-Smtp-Source: AA0mqf421SS2GFw8AgyzlERoRxLCafQ+++JxEe4SSAiRZvR2zFT8DCHFYbepMDY51eSmmNWZPy1fhw==
X-Received: by 2002:a17:90b:264a:b0:213:7030:f69a with SMTP id pa10-20020a17090b264a00b002137030f69amr102328704pjb.231.1670480115568;
        Wed, 07 Dec 2022 22:15:15 -0800 (PST)
Received: from google.com ([2620:15c:2d4:203:695e:eb31:8a06:b0a4])
        by smtp.gmail.com with ESMTPSA id l18-20020a656812000000b0047681fa88d1sm12448253pgt.53.2022.12.07.22.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 22:15:15 -0800 (PST)
Date:   Wed, 7 Dec 2022 22:15:12 -0800
From:   Namhyung Kim <namhyung@gmail.com>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Message-ID: <Y5GA8LjlB1BDQ/TO@google.com>
References: <Y388m6wOktvZo1d4@krava>
 <CAADnVQJ5knvWaxVa=9_Ag3DU_qewGBbHGv_ZH=K+ETUWM1qAmA@mail.gmail.com>
 <Y4CMbTeVud0WfPtK@krava>
 <CAEf4BzZP9z3kdzn=04EvAprG-Ldrsegy5JkzvoBPvcdMG_vvGg@mail.gmail.com>
 <Y4uOSrXBxVwnxZkX@google.com>
 <Y43j3IGvLKgshuhR@krava>
 <CAADnVQLo1JBTg6iquCFj44AEuAhxj-V7a0T1gwejy1oDBDXcbA@mail.gmail.com>
 <Y4/27g8EHQ9F3bDr@google.com>
 <Y5BMRvsVMQtKvuhu@krava>
 <CAM9d7cgrgXPdUdL4WJ_MtBrrdJtSVsXF6REPJ9rSNVLms5k6LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM9d7cgrgXPdUdL4WJ_MtBrrdJtSVsXF6REPJ9rSNVLms5k6LQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 07, 2022 at 11:08:40AM -0800, Namhyung Kim wrote:
> On Wed, Dec 7, 2022 at 12:18 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Tue, Dec 06, 2022 at 06:14:06PM -0800, Namhyung Kim wrote:
> >
> > SNIP
> >
> > > -static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
> > > +static void *bpf_trace_norecurse_funcs[12] = {
> > > +     (void *)bpf_trace_run_norecurse1,
> > > +     (void *)bpf_trace_run_norecurse2,
> > > +     (void *)bpf_trace_run_norecurse3,
> > > +     (void *)bpf_trace_run_norecurse4,
> > > +     (void *)bpf_trace_run_norecurse5,
> > > +     (void *)bpf_trace_run_norecurse6,
> > > +     (void *)bpf_trace_run_norecurse7,
> > > +     (void *)bpf_trace_run_norecurse8,
> > > +     (void *)bpf_trace_run_norecurse9,
> > > +     (void *)bpf_trace_run_norecurse10,
> > > +     (void *)bpf_trace_run_norecurse11,
> > > +     (void *)bpf_trace_run_norecurse12,
> > > +};
> > > +
> > > +static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog,
> > > +                             void *func, void *data)
> > >  {
> > >       struct tracepoint *tp = btp->tp;
> > >
> > > @@ -2325,13 +2354,12 @@ static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *
> > >       if (prog->aux->max_tp_access > btp->writable_size)
> > >               return -EINVAL;
> > >
> > > -     return tracepoint_probe_register_may_exist(tp, (void *)btp->bpf_func,
> > > -                                                prog);
> > > +     return tracepoint_probe_register_may_exist(tp, func, data);
> > >  }
> > >
> > >  int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
> > >  {
> > > -     return __bpf_probe_register(btp, prog);
> > > +     return __bpf_probe_register(btp, prog, btp->bpf_func, prog);
> > >  }
> > >
> > >  int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
> > > @@ -2339,6 +2367,33 @@ int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
> > >       return tracepoint_probe_unregister(btp->tp, (void *)btp->bpf_func, prog);
> > >  }
> > >
> > > +int bpf_probe_register_norecurse(struct bpf_raw_event_map *btp, struct bpf_prog *prog,
> > > +                              struct bpf_raw_event_data *data)
> > > +{
> > > +     void *bpf_func;
> > > +
> > > +     data->active = alloc_percpu_gfp(int, GFP_KERNEL);
> > > +     if (!data->active)
> > > +             return -ENOMEM;
> > > +
> > > +     data->prog = prog;
> > > +     bpf_func = bpf_trace_norecurse_funcs[btp->num_args];
> > > +     return __bpf_probe_register(btp, prog, bpf_func, data);
> >
> > I don't think we can do that, because it won't do the arg -> u64 conversion
> > that __bpf_trace_##call functions are doing:
> >
> >         __bpf_trace_##call(void *__data, proto)                                 \
> >         {                                                                       \
> >                 struct bpf_prog *prog = __data;                                 \
> >                 CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));  \
> >         }
> >
> > like for 'old_pid' arg in sched_process_exec tracepoint:
> >
> >         ffffffff811959e0 <__bpf_trace_sched_process_exec>:
> >         ffffffff811959e0:       89 d2                   mov    %edx,%edx
> >         ffffffff811959e2:       e9 a9 07 14 00          jmp    ffffffff812d6190 <bpf_trace_run3>
> >         ffffffff811959e7:       66 0f 1f 84 00 00 00    nopw   0x0(%rax,%rax,1)
> >         ffffffff811959ee:       00 00
> >
> > bpf program could see some trash in args < u64
> >
> > we'd need to add 'recursion' variant for all __bpf_trace_##call functions
> 
> Ah, ok.  So 'contention_begin' tracepoint has unsigned int flags.
> perf lock contention BPF program properly uses the lower 4 bytes of flags,
> but others might access the whole 8 bytes then they will see the garbage.
> Is that your concern?
> 
> Hmm.. I think we can use BTF to get the size of each argument then do
> the conversion.  Let me see..

Maybe something like this?  But I'm not sure if I did cast_to_u64() right.

Thanks,
Namhyung

---
 include/linux/trace_events.h    |  14 ++++
 include/linux/tracepoint-defs.h |   6 ++
 kernel/bpf/syscall.c            |  18 ++++-
 kernel/trace/bpf_trace.c        | 119 ++++++++++++++++++++++++++++++--
 4 files changed, 150 insertions(+), 7 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index f14d41bc7342..73bcc0378719 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -481,6 +481,10 @@ void perf_event_detach_bpf_prog(struct perf_event *event);
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
@@ -514,6 +518,16 @@ static inline int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf
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
index 0279bf79f113..a8f93cf9c471 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -42,6 +42,12 @@ struct bpf_raw_event_map {
 	u32			writable_size;
 } __aligned(32);
 
+struct bpf_raw_event_data {
+	struct bpf_prog		*prog;
+	int __percpu		*active;
+	u8			arg_sizes[12];
+};
+
 /*
  * If a tracepoint needs to be called from a header file, it is not
  * recommended to call it directly, as tracepoints in header files
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 71aa93697afa..1a4483e33ff3 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3156,14 +3156,24 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
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
 
@@ -3360,7 +3370,11 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
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
index fc956d7bdff7..10048955c982 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2069,6 +2069,13 @@ void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
 	this_cpu_dec(*(prog->active));
 }
 
+/* Actual *arg* is not in u64, copy arg to dst with a proper size */
+static void cast_to_u64(u64 *dst, u64 arg, u8 size)
+{
+	*dst = 0;
+	memcpy(dst, &arg, size);
+}
+
 #define UNPACK(...)			__VA_ARGS__
 #define REPEAT_1(FN, DL, X, ...)	FN(X)
 #define REPEAT_2(FN, DL, X, ...)	FN(X) UNPACK DL REPEAT_1(FN, DL, __VA_ARGS__)
@@ -2086,6 +2093,7 @@ void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
 
 #define SARG(X)		u64 arg##X
 #define COPY(X)		args[X] = arg##X
+#define CAST(X)		cast_to_u64(&args[X], arg##X, data->arg_sizes[X])
 
 #define __DL_COM	(,)
 #define __DL_SEM	(;)
@@ -2100,7 +2108,20 @@ void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
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
+		REPEAT(x, CAST, __DL_SEM, __SEQ_0_11);			\
+		__bpf_trace_run(data->prog, args);			\
+	out:								\
+		this_cpu_dec(*(data->active));				\
+	}
+
 BPF_TRACE_DEFN_x(1);
 BPF_TRACE_DEFN_x(2);
 BPF_TRACE_DEFN_x(3);
@@ -2114,7 +2135,23 @@ BPF_TRACE_DEFN_x(10);
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
 
@@ -2128,13 +2165,12 @@ static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *
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
@@ -2142,6 +2178,79 @@ int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
 	return tracepoint_probe_unregister(btp->tp, (void *)btp->bpf_func, prog);
 }
 
+int bpf_probe_register_norecurse(struct bpf_raw_event_map *btp, struct bpf_prog *prog,
+				 struct bpf_raw_event_data *data)
+{
+	const struct btf *btf;
+	const struct btf_type *t;
+	struct btf_param *p;
+	char *tp_typedef_name;
+	void *bpf_func;
+	s32 type_id;
+	u32 i, size;
+
+	btf = bpf_get_btf_vmlinux();
+	if (IS_ERR_OR_NULL(btf))
+		return btf ? PTR_ERR(btf) : -EINVAL;
+
+	tp_typedef_name = kasprintf(GFP_KERNEL, "btf_trace_%s", btp->tp->name);
+	if (tp_typedef_name == NULL)
+		return -ENOMEM;
+
+	type_id = btf_find_by_name_kind(btf, tp_typedef_name, BTF_KIND_TYPEDEF);
+	kfree(tp_typedef_name);
+
+	if (type_id == -ENOENT)
+		return -EINVAL;
+
+	t = btf_type_by_id(btf, type_id);
+	if (t == NULL)
+		return -EINVAL;
+
+	t = btf_type_by_id(btf, t->type);
+	if (t == NULL || !btf_is_ptr(t))
+		return -EINVAL;
+
+	t = btf_type_by_id(btf, t->type);
+	if (t == NULL || !btf_type_is_func_proto(t))
+		return -EINVAL;
+
+	WARN_ON_ONCE(btp->num_args != btf_vlen(t));
+
+	for (i = 0, p = btf_params(t); i < btp->num_args; i++, p++) {
+		t = btf_type_by_id(btf, p->type);
+		if (t == NULL)
+			return -EINVAL;
+
+		btf_resolve_size(btf, t, &size);
+		if (size > 8)
+			return -EINVAL;
+
+		data->arg_sizes[i] = size;
+	}
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
2.39.0.rc1.256.g54fd8350bd-goog

