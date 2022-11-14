Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC516628C4C
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 23:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiKNWrg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 17:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiKNWre (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 17:47:34 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A7BB01;
        Mon, 14 Nov 2022 14:47:33 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 21so19495099edv.3;
        Mon, 14 Nov 2022 14:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YRpXjigSA6S9AC3Lngm4CS5iIc21JFxrd9jxpbKiyFo=;
        b=qQlu/50q2eaLTmF5Xae0/byivtFLNJU6Brcyr6ABbMSgmxtRvhvUSl43qJXDQJIC2y
         pZcw5AIooIu+KpFdIzdiVFOPUZy/SGttwPUSu7Y+UV0RE7huOq3KoPue2Xh/iI0eX5Xl
         bmTpLlKZZg4keJL09mYxlH2IZXYBLy3GQpOhfcDoruLDrmKn7szuv/tNqMCQoPNxutjU
         3YhbzFmbO683Ag4c1KYmG0G9VCzEeJiAk2xHKr5brPlf4MTqK1L6/0h0paVhKs9ifFxE
         2AJvU18ZWUsPW1oGvwAIMHNARxJ8Z1XhFebwBuxZgdgSDLDJ1wdXP7tVYjoJbqWKC9lz
         CUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRpXjigSA6S9AC3Lngm4CS5iIc21JFxrd9jxpbKiyFo=;
        b=Yq6wox3FKXHbNmI/KOsTXO6sURbVFc3yzauro397lrm17Mu9wYezBpzaEWxbkkbdo6
         kylvCNGFREV+7ZalYTUInIEW4MKElfr/zIw/VrWpjuXgAVdIvMOFvMGVrBh2A6SC7SeO
         6eM1uNh4EeLpMH9N7MYSfeuuyul0HQ7ddsDcP4MHAi0fxEz0c/goC5yf0HdY+X7X5XLF
         tfaRmZxiRPQYwuX7nuxjOMydq60q5KUCoZJxnIY2b2oA78lFP5+c0ZEC5bkl0z2Ygu1b
         86cpUikjqvmXb0wJKJIgVqgYRA2O7fRmsfcIKmK1lJIlBcTAYNpveFfg25LwuDIEhii8
         bSEg==
X-Gm-Message-State: ANoB5pl17VMRli2JOEr0I4+GO4JVvKbWL/hJ0mQ7aNPY1T6qg4OWlzzz
        u1eHp+mMB/BeYLrYF+FJq6w=
X-Google-Smtp-Source: AA0mqf6mJV9B6VlF/2SKTHDgmgh4C7Nb0abdAo4vgieewXfCZ6S7IAYj9h+FpIZf5EMog7zrKS8qkQ==
X-Received: by 2002:a05:6402:883:b0:467:b8c9:a7fa with SMTP id e3-20020a056402088300b00467b8c9a7famr6899087edy.25.1668466052017;
        Mon, 14 Nov 2022 14:47:32 -0800 (PST)
Received: from krava ([83.240.62.198])
        by smtp.gmail.com with ESMTPSA id et19-20020a170907295300b007ad2da5668csm4691858ejc.112.2022.11.14.14.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 14:47:31 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 14 Nov 2022 23:47:28 +0100
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Hao Sun <sunhao.th@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>
Subject: Re: WARNING in bpf_bprintf_prepare
Message-ID: <Y3LFgI6mmC0SKiFw@krava>
References: <CACkBjsbP-iw-gpnYN=Ormcu2zXAeOgjeptjGAFXNNJRRVhRAag@mail.gmail.com>
 <Y2J+n7SqmtfyA7ZM@krava>
 <Y2j6ivTwFmA0FtvY@krava>
 <CAADnVQKXcdVa-gDj2_QTrBuVea+KMuFUdabR--HCf7x6Vo6uXg@mail.gmail.com>
 <Y2uv/GjnSdr/ujOj@krava>
 <CAADnVQJp0ZrodRu8ZtvvtXk6KAbjxmwqD-nXgFAxNpNxN6JM=g@mail.gmail.com>
 <Y2w9bNhVlAs/PcNV@krava>
 <Y25gFdliV7XqdUnN@krava>
 <CACkBjsaCsTovQHFfkqJKto6S4Z8d02ud1D7MPESrHa1cVNNTrw@mail.gmail.com>
 <Y3H2qayW0hKlzBkK@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3H2qayW0hKlzBkK@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 14, 2022 at 09:04:57AM +0100, Jiri Olsa wrote:
> On Sat, Nov 12, 2022 at 12:02:50AM +0800, Hao Sun wrote:
> > Jiri Olsa <olsajiri@gmail.com> 于2022年11月11日周五 22:45写道：
> > >
> > > On Thu, Nov 10, 2022 at 12:53:16AM +0100, Jiri Olsa wrote:
> > >
> > > SNIP
> > >
> > > > > > > > ---
> > > > > > > > diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> > > > > > > > index 6a13220d2d27..5a354ae096e5 100644
> > > > > > > > --- a/include/trace/bpf_probe.h
> > > > > > > > +++ b/include/trace/bpf_probe.h
> > > > > > > > @@ -78,11 +78,15 @@
> > > > > > > >  #define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
> > > > > > > >
> > > > > > > >  #define __BPF_DECLARE_TRACE(call, proto, args)                         \
> > > > > > > > +static DEFINE_PER_CPU(int, __bpf_trace_tp_active_##call);              \
> > > > > > > >  static notrace void                                                    \
> > > > > > > >  __bpf_trace_##call(void *__data, proto)                                        \
> > > > > > > >  {                                                                      \
> > > > > > > >         struct bpf_prog *prog = __data;                                 \
> > > > > > > > -       CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));  \
> > > > > > > > +                                                                       \
> > > > > > > > +       if (likely(this_cpu_inc_return(__bpf_trace_tp_active_##call) == 1))             \
> > > > > > > > +               CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));  \
> > > > > > > > +       this_cpu_dec(__bpf_trace_tp_active_##call);                                     \
> > > > > > > >  }
> > > > > > >
> > > > > > > This approach will hurt real use cases where
> > > > > > > multiple and different raw_tp progs run on the same cpu.
> > > > > >
> > > > > > would the 2 levels of nesting help in here?
> > > > > >
> > > > > > I can imagine the change above would break use case where we want to
> > > > > > trigger tracepoints in irq context that interrupted task that's already
> > > > > > in the same tracepoint
> > > > > >
> > > > > > with 2 levels of nesting we would trigger that tracepoint from irq and
> > > > > > would still be safe with bpf_bprintf_prepare buffer
> > > > >
> > > > > How would these 2 levels work?
> > > >
> > > > just using the active counter like below, but I haven't tested it yet
> > > >
> > > > jirka
> > >
> > > seems to be working
> > > Hao Sun, could you please test this patch?
> > >
> > 
> > Hi Jirka,
> > 
> > I've tested the proposed patch, the warning from bpf_bprintf_prepare will not
> > be triggered with the patch, but the reproducer can still trigger the following
> > warning. My test was conducted on:
> > 
> > commit:  f67dd6ce0723 Merge tag 'slab-for-6.1-rc4-fixes'
> > git tree:   upstream
> > kernel config: https://pastebin.com/raw/sE5QK5HL
> > C reproducer: https://pastebin.com/raw/X96ASi27
> > console log *before* the patch: https://pastebin.com/raw/eSCUNFrd
> > console log *after* the patch: https://pastebin.com/raw/tzcmdWZt
> 
> thanks for testing.. I can't reproduce this for some reason
> 
> I'll check some more and perhaps go with denying bpf attachment
> for this tracepoint as Alexei suggeste

the change below won't allow to attach bpf program with any printk
helper in contention_begin and bpf_trace_printk tracepoints

I still need to test it on the machine that reproduced the issue
for me.. meanwhile any feedback is appreciated

thanks,
jirka

---
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 798aec816970..d88e0741b381 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1257,7 +1257,8 @@ struct bpf_prog {
 				enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
 				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
 				call_get_func_ip:1, /* Do we call get_func_ip() */
-				tstamp_type_access:1; /* Accessed __sk_buff->tstamp_type */
+				tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
+				call_printk:1; /* Do we call trace_printk/trace_vprintk  */
 	enum bpf_prog_type	type;		/* Type of BPF program */
 	enum bpf_attach_type	expected_attach_type; /* For some prog types */
 	u32			len;		/* Number of filter blocks */
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 20749bd9db71..fd2725624fed 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -742,7 +742,7 @@ void perf_event_detach_bpf_prog(struct perf_event *event);
 int perf_event_query_prog_array(struct perf_event *event, void __user *info);
 int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog);
 int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *prog);
-struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name);
+struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name, struct bpf_prog *prog);
 void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp);
 int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 			    u32 *fd_type, const char **buf,
@@ -775,7 +775,8 @@ static inline int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf
 {
 	return -EOPNOTSUPP;
 }
-static inline struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name)
+static inline struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name,
+							       struct bpf_prog *prog)
 {
 	return NULL;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 85532d301124..d6081e8336c6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3281,7 +3281,7 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
 		return -EINVAL;
 	}
 
-	btp = bpf_get_raw_tracepoint(tp_name);
+	btp = bpf_get_raw_tracepoint(tp_name, prog);
 	if (!btp)
 		return -ENOENT;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 07c0259dfc1a..9862345d9249 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7572,6 +7572,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
 					set_user_ringbuf_callback_state);
 		break;
+	case BPF_FUNC_trace_printk:
+	case BPF_FUNC_trace_vprintk:
+		env->prog->call_printk = 1;
+		break;
 	}
 
 	if (err)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f2d8d070d024..9a4652a05690 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2229,10 +2229,32 @@ int perf_event_query_prog_array(struct perf_event *event, void __user *info)
 extern struct bpf_raw_event_map __start__bpf_raw_tp[];
 extern struct bpf_raw_event_map __stop__bpf_raw_tp[];
 
-struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name)
+static int check_printk_denylist(const char *name, struct bpf_prog *prog)
+{
+	static const char *denylist[] = {
+		"contention_begin",
+		"bpf_trace_printk",
+	};
+	int i;
+
+	if (!prog->call_printk)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(denylist); i++) {
+		if (!strcmp(denylist[i], name))
+			return 1;
+	}
+	return 0;
+}
+
+struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name,
+						 struct bpf_prog *prog)
 {
 	struct bpf_raw_event_map *btp = __start__bpf_raw_tp;
 
+	if (check_printk_denylist(name, prog))
+		return NULL;
+
 	for (; btp < __stop__bpf_raw_tp; btp++) {
 		if (!strcmp(btp->tp->name, name))
 			return btp;
