Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA4764286D
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 13:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiLEM2U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 07:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiLEM2S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 07:28:18 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C729CBCAF
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 04:28:16 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l26so2367268wms.4
        for <bpf@vger.kernel.org>; Mon, 05 Dec 2022 04:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VMb29+S6iPvM3KSpvIVYE/PAGDqom3OduwevB8UT7rE=;
        b=VFbaLMz0W2+p0vCx/gg2tPVv7wgph2tYwnZYRUpP9OPmCxqRhsjbqFGmm+eTAkKobA
         WhO/gq/2nJYlvOanUoFz9LBOAPttypeLwSgpTyIem03NDy6nA91EFk18ruoIrXwcKO5I
         rRAFZErlRPQQtZwBz+Vq8HnUOWj7MBGxQp4BLox8wt+OUpr4vHEWaB5Onge/ELaWT/XP
         q/teouH40M8YkJl97qg7S618dg7c+DMM8jZGbBU7BcksGz8BhcjLgED44uaqSEUntZeH
         WiF+lMpg5xmvxHU+/z1hSZmjdwhc54J46CnDpg2YJaGw3dLDFTkPs/QTQQYdJYfvy3Ll
         8UNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMb29+S6iPvM3KSpvIVYE/PAGDqom3OduwevB8UT7rE=;
        b=EWDl9UsWkG/B27luO0pBhxzF7RKu/rUNpZAvncrca9Ad6hTpP3QzL3O8LPSVpHVeJt
         5+x7zAIYW7nqzeyj7WPv1oVmLyGXiWxZmyJmTih/nFXWBpknAi4GgPj4wlOJLuoIuYOm
         awqbXsHricdQiHp/Oa6pOIPOXHNN+pzYYdrR3T3HU62tlc05WtgINTayGVLpZEJ+RQVN
         B/u2WLuShsnuyQa6+3eqrwrt/Kb8CAHkx0Kh9VF24mCL7/8cRdFmI4eJ7wE7e4PqthBS
         Cu07EOJzyRjFvY9ltb90r8la767mfv8vcXDzaLwDEpznYniYm9x396dGOSGVXODlsWik
         C5QQ==
X-Gm-Message-State: ANoB5pn9I1dLvNYyi1FAQIlQQ3QSXGzRDfLGc7Uy4fnLfksEjsHvoX8l
        FQHzONv/jSqdncWcN9kHn6zFMGndPHX1yHfl
X-Google-Smtp-Source: AA0mqf6kTZbuoopu4qWiNpERHdbvPKYTsmo9MmNTZp3gtbaLQxph0nGwLggnB+1oVKtn6KU4lgCWkA==
X-Received: by 2002:a05:600c:538d:b0:3d0:47c:9fe9 with SMTP id hg13-20020a05600c538d00b003d0047c9fe9mr47083341wmb.40.1670243295071;
        Mon, 05 Dec 2022 04:28:15 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c0a0a00b003c70191f267sm24609682wmp.39.2022.12.05.04.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 04:28:14 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 5 Dec 2022 13:28:12 +0100
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Message-ID: <Y43j3IGvLKgshuhR@krava>
References: <20221121213123.1373229-1-jolsa@kernel.org>
 <bcdac077-3043-a648-449d-1b60037388de@iogearbox.net>
 <Y388m6wOktvZo1d4@krava>
 <CAADnVQJ5knvWaxVa=9_Ag3DU_qewGBbHGv_ZH=K+ETUWM1qAmA@mail.gmail.com>
 <Y4CMbTeVud0WfPtK@krava>
 <CAEf4BzZP9z3kdzn=04EvAprG-Ldrsegy5JkzvoBPvcdMG_vvGg@mail.gmail.com>
 <Y4uOSrXBxVwnxZkX@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4uOSrXBxVwnxZkX@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Dec 03, 2022 at 09:58:34AM -0800, Namhyung Kim wrote:
> On Wed, Nov 30, 2022 at 03:29:39PM -0800, Andrii Nakryiko wrote:
> > On Fri, Nov 25, 2022 at 1:35 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Thu, Nov 24, 2022 at 09:17:22AM -0800, Alexei Starovoitov wrote:
> > > > On Thu, Nov 24, 2022 at 1:42 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > >
> > > > > On Thu, Nov 24, 2022 at 01:41:23AM +0100, Daniel Borkmann wrote:
> > > > > > On 11/21/22 10:31 PM, Jiri Olsa wrote:
> > > > > > > We hit following issues [1] [2] when we attach bpf program that calls
> > > > > > > bpf_trace_printk helper to the contention_begin tracepoint.
> > > > > > >
> > > > > > > As described in [3] with multiple bpf programs that call bpf_trace_printk
> > > > > > > helper attached to the contention_begin might result in exhaustion of
> > > > > > > printk buffer or cause a deadlock [2].
> > > > > > >
> > > > > > > There's also another possible deadlock when multiple bpf programs attach
> > > > > > > to bpf_trace_printk tracepoint and call one of the printk bpf helpers.
> > > > > > >
> > > > > > > This change denies the attachment of bpf program to contention_begin
> > > > > > > and bpf_trace_printk tracepoints if the bpf program calls one of the
> > > > > > > printk bpf helpers.
> > > > > > >
> > > > > > > Adding also verifier check for tb_btf programs, so this can be cought
> > > > > > > in program loading time with error message like:
> > > > > > >
> > > > > > >    Can't attach program with bpf_trace_printk#6 helper to contention_begin tracepoint.
> > > > > > >
> > > > > > > [1] https://lore.kernel.org/bpf/CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com/
> > > > > > > [2] https://lore.kernel.org/bpf/CACkBjsaCsTovQHFfkqJKto6S4Z8d02ud1D7MPESrHa1cVNNTrw@mail.gmail.com/
> > > > > > > [3] https://lore.kernel.org/bpf/Y2j6ivTwFmA0FtvY@krava/
> > > > > > >
> > > > > > > Reported-by: Hao Sun <sunhao.th@gmail.com>
> > > > > > > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > > > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > > > ---
> > > > > > >   include/linux/bpf.h          |  1 +
> > > > > > >   include/linux/bpf_verifier.h |  2 ++
> > > > > > >   kernel/bpf/syscall.c         |  3 +++
> > > > > > >   kernel/bpf/verifier.c        | 46 ++++++++++++++++++++++++++++++++++++
> > > > > > >   4 files changed, 52 insertions(+)
> > > > > > >
> > > > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > > > index c9eafa67f2a2..3ccabede0f50 100644
> > > > > > > --- a/include/linux/bpf.h
> > > > > > > +++ b/include/linux/bpf.h
> > > > > > > @@ -1319,6 +1319,7 @@ struct bpf_prog {
> > > > > > >                             enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
> > > > > > >                             call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
> > > > > > >                             call_get_func_ip:1, /* Do we call get_func_ip() */
> > > > > > > +                           call_printk:1, /* Do we call trace_printk/trace_vprintk  */
> > > > > > >                             tstamp_type_access:1; /* Accessed __sk_buff->tstamp_type */
> > > > > > >     enum bpf_prog_type      type;           /* Type of BPF program */
> > > > > > >     enum bpf_attach_type    expected_attach_type; /* For some prog types */
> > > > > > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > > > > > > index 545152ac136c..7118c2fda59d 100644
> > > > > > > --- a/include/linux/bpf_verifier.h
> > > > > > > +++ b/include/linux/bpf_verifier.h
> > > > > > > @@ -618,6 +618,8 @@ bool is_dynptr_type_expected(struct bpf_verifier_env *env,
> > > > > > >                          struct bpf_reg_state *reg,
> > > > > > >                          enum bpf_arg_type arg_type);
> > > > > > > +int bpf_check_tp_printk_denylist(const char *name, struct bpf_prog *prog);
> > > > > > > +
> > > > > > >   /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
> > > > > > >   static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> > > > > > >                                          struct btf *btf, u32 btf_id)
> > > > > > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > > > > > index 35972afb6850..9a69bda7d62b 100644
> > > > > > > --- a/kernel/bpf/syscall.c
> > > > > > > +++ b/kernel/bpf/syscall.c
> > > > > > > @@ -3329,6 +3329,9 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
> > > > > > >             return -EINVAL;
> > > > > > >     }
> > > > > > > +   if (bpf_check_tp_printk_denylist(tp_name, prog))
> > > > > > > +           return -EACCES;
> > > > > > > +
> > > > > > >     btp = bpf_get_raw_tracepoint(tp_name);
> > > > > > >     if (!btp)
> > > > > > >             return -ENOENT;
> > > > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > > > index f07bec227fef..b662bc851e1c 100644
> > > > > > > --- a/kernel/bpf/verifier.c
> > > > > > > +++ b/kernel/bpf/verifier.c
> > > > > > > @@ -7472,6 +7472,47 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
> > > > > > >                              state->callback_subprogno == subprogno);
> > > > > > >   }
> > > > > > > +int bpf_check_tp_printk_denylist(const char *name, struct bpf_prog *prog)
> > > > > > > +{
> > > > > > > +   static const char * const denylist[] = {
> > > > > > > +           "contention_begin",
> > > > > > > +           "bpf_trace_printk",
> > > > > > > +   };
> > > > > > > +   int i;
> > > > > > > +
> > > > > > > +   /* Do not allow attachment to denylist[] tracepoints,
> > > > > > > +    * if the program calls some of the printk helpers,
> > > > > > > +    * because there's possibility of deadlock.
> > > > > > > +    */
> > > > > >
> > > > > > What if that prog doesn't but tail calls into another one which calls printk helpers?
> > > > >
> > > > > right, I'll deny that for all BPF_PROG_TYPE_RAW_TRACEPOINT* programs,
> > > > > because I don't see easy way to check on that
> > > > >
> > > > > we can leave printk check for tracing BPF_TRACE_RAW_TP programs,
> > > > > because verifier known the exact tracepoint already
> > > >
> > > > This is all fragile and merely a stop gap.
> > > > Doesn't sound that the issue is limited to bpf_trace_printk
> > >
> > > hm, I don't have a better idea how to fix that.. I can't deny
> > > contention_begin completely, because we use it in perf via
> > > tp_btf/contention_begin (perf lock contention) and I don't
> > > think there's another way for perf to do that
> > >
> > > fwiw the last version below denies BPF_PROG_TYPE_RAW_TRACEPOINT
> > > programs completely and tracing BPF_TRACE_RAW_TP with printks
> > >
> > 
> > I think disabling bpf_trace_printk() tracepoint for any BPF program is
> > totally fine. This tracepoint was never intended to be attached to.
> > 
> > But as for the general bpf_trace_printk() deadlocking. Should we
> > discuss how to make it not deadlock instead of starting to denylist
> > things left and right?
> > 
> > Do I understand that we take trace_printk_lock only to protect that
> > static char buf[]? Can we just make this buf per-CPU and do a trylock
> > instead? We'll only fail to bpf_trace_printk() something if we have
> > nested BPF programs (rare) or NMI (also rare).
> > 
> > And it's a printk(), it's never mission-critical, so if we drop some
> > message in rare case it's totally fine.
> 
> What about contention_begin?  I wonder if we can disallow recursions
> for those in the deny list like using bpf_prog_active..

I was testing change below which allows to check recursion just
for contention_begin tracepoint

for the reported issue we might be ok with the change that Andrii
suggested, but we could have the change below as extra precaution

jirka


---
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 20749bd9db71..1c89d4292374 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -740,8 +740,8 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx);
 int perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 bpf_cookie);
 void perf_event_detach_bpf_prog(struct perf_event *event);
 int perf_event_query_prog_array(struct perf_event *event, void __user *info);
-int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog);
-int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *prog);
+int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_raw_event_data *data);
+int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_raw_event_data *data);
 struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name);
 void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp);
 int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
@@ -873,31 +873,31 @@ void *perf_trace_buf_alloc(int size, struct pt_regs **regs, int *rctxp);
 int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 bpf_cookie);
 void perf_event_free_bpf_prog(struct perf_event *event);
 
-void bpf_trace_run1(struct bpf_prog *prog, u64 arg1);
-void bpf_trace_run2(struct bpf_prog *prog, u64 arg1, u64 arg2);
-void bpf_trace_run3(struct bpf_prog *prog, u64 arg1, u64 arg2,
+void bpf_trace_run1(struct bpf_raw_event_data *data, u64 arg1);
+void bpf_trace_run2(struct bpf_raw_event_data *data, u64 arg1, u64 arg2);
+void bpf_trace_run3(struct bpf_raw_event_data *data, u64 arg1, u64 arg2,
 		    u64 arg3);
-void bpf_trace_run4(struct bpf_prog *prog, u64 arg1, u64 arg2,
+void bpf_trace_run4(struct bpf_raw_event_data *data, u64 arg1, u64 arg2,
 		    u64 arg3, u64 arg4);
-void bpf_trace_run5(struct bpf_prog *prog, u64 arg1, u64 arg2,
+void bpf_trace_run5(struct bpf_raw_event_data *data, u64 arg1, u64 arg2,
 		    u64 arg3, u64 arg4, u64 arg5);
-void bpf_trace_run6(struct bpf_prog *prog, u64 arg1, u64 arg2,
+void bpf_trace_run6(struct bpf_raw_event_data *data, u64 arg1, u64 arg2,
 		    u64 arg3, u64 arg4, u64 arg5, u64 arg6);
-void bpf_trace_run7(struct bpf_prog *prog, u64 arg1, u64 arg2,
+void bpf_trace_run7(struct bpf_raw_event_data *data, u64 arg1, u64 arg2,
 		    u64 arg3, u64 arg4, u64 arg5, u64 arg6, u64 arg7);
-void bpf_trace_run8(struct bpf_prog *prog, u64 arg1, u64 arg2,
+void bpf_trace_run8(struct bpf_raw_event_data *data, u64 arg1, u64 arg2,
 		    u64 arg3, u64 arg4, u64 arg5, u64 arg6, u64 arg7,
 		    u64 arg8);
-void bpf_trace_run9(struct bpf_prog *prog, u64 arg1, u64 arg2,
+void bpf_trace_run9(struct bpf_raw_event_data *data, u64 arg1, u64 arg2,
 		    u64 arg3, u64 arg4, u64 arg5, u64 arg6, u64 arg7,
 		    u64 arg8, u64 arg9);
-void bpf_trace_run10(struct bpf_prog *prog, u64 arg1, u64 arg2,
+void bpf_trace_run10(struct bpf_raw_event_data *data, u64 arg1, u64 arg2,
 		     u64 arg3, u64 arg4, u64 arg5, u64 arg6, u64 arg7,
 		     u64 arg8, u64 arg9, u64 arg10);
-void bpf_trace_run11(struct bpf_prog *prog, u64 arg1, u64 arg2,
+void bpf_trace_run11(struct bpf_raw_event_data *data, u64 arg1, u64 arg2,
 		     u64 arg3, u64 arg4, u64 arg5, u64 arg6, u64 arg7,
 		     u64 arg8, u64 arg9, u64 arg10, u64 arg11);
-void bpf_trace_run12(struct bpf_prog *prog, u64 arg1, u64 arg2,
+void bpf_trace_run12(struct bpf_raw_event_data *data, u64 arg1, u64 arg2,
 		     u64 arg3, u64 arg4, u64 arg5, u64 arg6, u64 arg7,
 		     u64 arg8, u64 arg9, u64 arg10, u64 arg11, u64 arg12);
 void perf_trace_run_bpf_submit(void *raw_data, int size, int rctx,
diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
index e7c2276be33e..5312a8b149c0 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -46,6 +46,11 @@ typedef const int tracepoint_ptr_t;
 typedef struct tracepoint * const tracepoint_ptr_t;
 #endif
 
+struct bpf_raw_event_data {
+	struct bpf_prog *prog;
+	int __percpu *recursion;
+};
+
 struct bpf_raw_event_map {
 	struct tracepoint	*tp;
 	void			*bpf_func;
diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index 6a13220d2d27..a8f9c3c7c447 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -81,8 +81,8 @@
 static notrace void							\
 __bpf_trace_##call(void *__data, proto)					\
 {									\
-	struct bpf_prog *prog = __data;					\
-	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));	\
+	struct bpf_raw_event_data *____data = __data;			\
+	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(____data, CAST_TO_U64(args));	\
 }
 
 #undef DECLARE_EVENT_CLASS
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 35972afb6850..5dcb32cd24e6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3141,9 +3141,36 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	return err;
 }
 
+static bool needs_recursion_check(struct bpf_raw_event_map *btp)
+{
+	return !strcmp(btp->tp->name, "contention_begin");
+}
+
+static int bpf_raw_event_data_init(struct bpf_raw_event_data *data,
+				   struct bpf_raw_event_map *btp,
+				   struct bpf_prog *prog)
+{
+	int __percpu *recursion = NULL;
+
+	if (needs_recursion_check(btp)) {
+		recursion = alloc_percpu_gfp(int, GFP_KERNEL);
+		if (!recursion)
+			return -ENOMEM;
+	}
+	data->recursion = recursion;
+	data->prog = prog;
+	return 0;
+}
+
+static void bpf_raw_event_data_release(struct bpf_raw_event_data *data)
+{
+	free_percpu(data->recursion);
+}
+
 struct bpf_raw_tp_link {
 	struct bpf_link link;
 	struct bpf_raw_event_map *btp;
+	struct bpf_raw_event_data data;
 };
 
 static void bpf_raw_tp_link_release(struct bpf_link *link)
@@ -3151,7 +3178,8 @@ static void bpf_raw_tp_link_release(struct bpf_link *link)
 	struct bpf_raw_tp_link *raw_tp =
 		container_of(link, struct bpf_raw_tp_link, link);
 
-	bpf_probe_unregister(raw_tp->btp, raw_tp->link.prog);
+	bpf_probe_unregister(raw_tp->btp, &raw_tp->data);
+	bpf_raw_event_data_release(&raw_tp->data);
 	bpf_put_raw_tracepoint(raw_tp->btp);
 }
 
@@ -3338,17 +3366,23 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
 		err = -ENOMEM;
 		goto out_put_btp;
 	}
+	if (bpf_raw_event_data_init(&link->data, btp, prog)) {
+		err = -ENOMEM;
+		kfree(link);
+		goto out_put_btp;
+	}
 	bpf_link_init(&link->link, BPF_LINK_TYPE_RAW_TRACEPOINT,
 		      &bpf_raw_tp_link_lops, prog);
 	link->btp = btp;
 
 	err = bpf_link_prime(&link->link, &link_primer);
 	if (err) {
+		bpf_raw_event_data_release(&link->data);
 		kfree(link);
 		goto out_put_btp;
 	}
 
-	err = bpf_probe_register(link->btp, prog);
+	err = bpf_probe_register(link->btp, &link->data);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
 		goto out_put_btp;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3bbd3f0c810c..d27b7dc77894 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2252,9 +2252,8 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
 }
 
 static __always_inline
-void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
+void __bpf_trace_prog_run(struct bpf_prog *prog, u64 *args)
 {
-	cant_sleep();
 	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
 		bpf_prog_inc_misses_counter(prog);
 		goto out;
@@ -2266,6 +2265,22 @@ void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
 	this_cpu_dec(*(prog->active));
 }
 
+static __always_inline
+void __bpf_trace_run(struct bpf_raw_event_data *data, u64 *args)
+{
+	struct bpf_prog *prog = data->prog;
+
+	cant_sleep();
+	if (unlikely(!data->recursion))
+		return __bpf_trace_prog_run(prog, args);
+
+	if (unlikely(this_cpu_inc_return(*(data->recursion))))
+		goto out;
+	__bpf_trace_prog_run(prog, args);
+out:
+	this_cpu_dec(*(data->recursion));
+}
+
 #define UNPACK(...)			__VA_ARGS__
 #define REPEAT_1(FN, DL, X, ...)	FN(X)
 #define REPEAT_2(FN, DL, X, ...)	FN(X) UNPACK DL REPEAT_1(FN, DL, __VA_ARGS__)
@@ -2290,12 +2305,12 @@ void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
 #define __SEQ_0_11	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
 
 #define BPF_TRACE_DEFN_x(x)						\
-	void bpf_trace_run##x(struct bpf_prog *prog,			\
+	void bpf_trace_run##x(struct bpf_raw_event_data *data,		\
 			      REPEAT(x, SARG, __DL_COM, __SEQ_0_11))	\
 	{								\
 		u64 args[x];						\
 		REPEAT(x, COPY, __DL_SEM, __SEQ_0_11);			\
-		__bpf_trace_run(prog, args);				\
+		__bpf_trace_run(data, args);				\
 	}								\
 	EXPORT_SYMBOL_GPL(bpf_trace_run##x)
 BPF_TRACE_DEFN_x(1);
@@ -2311,8 +2326,9 @@ BPF_TRACE_DEFN_x(10);
 BPF_TRACE_DEFN_x(11);
 BPF_TRACE_DEFN_x(12);
 
-static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
+static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_raw_event_data *data)
 {
+	struct bpf_prog *prog = data->prog;
 	struct tracepoint *tp = btp->tp;
 
 	/*
@@ -2326,17 +2342,17 @@ static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *
 		return -EINVAL;
 
 	return tracepoint_probe_register_may_exist(tp, (void *)btp->bpf_func,
-						   prog);
+						   data);
 }
 
-int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
+int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_raw_event_data *data)
 {
-	return __bpf_probe_register(btp, prog);
+	return __bpf_probe_register(btp, data);
 }
 
-int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
+int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_raw_event_data *data)
 {
-	return tracepoint_probe_unregister(btp->tp, (void *)btp->bpf_func, prog);
+	return tracepoint_probe_unregister(btp->tp, (void *)btp->bpf_func, data);
 }
 
 int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
