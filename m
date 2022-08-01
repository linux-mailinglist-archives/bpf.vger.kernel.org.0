Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F078B586CA9
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 16:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbiHAOO0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 10:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbiHAOOZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 10:14:25 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D27A1F2EA
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 07:14:24 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x21so1190481edd.3
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 07:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=ssHqI4uAgQhAhW8W5RvsWSPbAH9Q7hFg94D7sw4yRTI=;
        b=U1eS1DVyMfkvIS3bFH2CbozE94yoZg/DJGud31oX+RvUZbt7f0SOTmJH4qi4nUmDCa
         +hTOI8AXJ0OR25ZtbNUaylARQTw332vVZejCZJ70lvX8NORj5ZDhYB7AA4fCtSe7/kSd
         LfMJHJ5I2oip2GZKEGzn5vQZyh9k+0hfvGlyFgHzpVfDfXm0PbeaZ+/PcviOECuQitpK
         C0JE5uhfTFE7c+fL0CpojdD6Vy0nUZoGPVkxRQE9R4EROCOndGwSVIPyyzbtTby2OQUJ
         t8REVJ/od4zMiyk0OZcsBXuH2ZC/FdRSGPbOwKh10q9bVc9d6NP8vl4WPGtFD6brDRg0
         rutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=ssHqI4uAgQhAhW8W5RvsWSPbAH9Q7hFg94D7sw4yRTI=;
        b=btD/WDA/swZqODAZGSPLHRHrPHCODBn0sDfIPx4M8ff7opSrU3E5Ktf/sPf/Ij5/Z6
         xg4blssq/FKIm3va5gzTVRwulc0Y3Oj0QYQkf8yEuzXV+kzxk0+gaG/NEugcqkhnceCb
         nlXroBxkfjuftlbQhliWSX5ZNnn4Vdn9xmt5+fRWtPb/DCJ87n4SsE99Efsf1xXPfLUb
         UBn2dWzRbZo+pWlUBzKIcQe5TJ9jfaIHa69yN1kzddRqH9YchcUf/4/Urte4nmoZKPeQ
         ePTaZL2AG6Viy1lYI9JaW6rkygiOwO5rVdDjTnfjU8kweFuDB82RogxY39NoiQf4BOPW
         +cOg==
X-Gm-Message-State: AJIora9RfvTA6LJpvO2uWRzpfOMaAuhVfMm5fQULtMqisd+uq+og0nLH
        xX4Ea36XFwOSvkh+y1DzWc8=
X-Google-Smtp-Source: AGRyM1s7QWtpnFzeN19Lk5NK2EgWkWRaDQVFl9BxU39JeG4ljrcTvwn6o0Kkhiw1EXs4FpCC7FzPqg==
X-Received: by 2002:a05:6402:15a:b0:431:71b9:86f3 with SMTP id s26-20020a056402015a00b0043171b986f3mr16017485edu.249.1659363262732;
        Mon, 01 Aug 2022 07:14:22 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906218a00b006fe8b456672sm5210451eju.3.2022.08.01.07.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 07:14:22 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 1 Aug 2022 16:14:20 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH bpf-next 0/5] bpf: Fixes for CONFIG_X86_KERNEL_IBT
Message-ID: <YuffvLBtY9tXALK/@krava>
References: <20220724212146.383680-1-jolsa@kernel.org>
 <CAEf4Bzbrqrg-wuNNWNJ1GSQQzLOF7azzM8B17ti1TBz_D7irKg@mail.gmail.com>
 <YubvPcHwPrcc1CD0@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YubvPcHwPrcc1CD0@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jul 31, 2022 at 11:08:16PM +0200, Jiri Olsa wrote:
> On Fri, Jul 29, 2022 at 03:18:54PM -0700, Andrii Nakryiko wrote:
> > On Sun, Jul 24, 2022 at 2:21 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > hi,
> > > Martynas reported bpf_get_func_ip returning +4 address when
> > > CONFIG_X86_KERNEL_IBT option is enabled and I found there are
> > > some failing bpf tests when this option is enabled.
> > >
> > > The CONFIG_X86_KERNEL_IBT option adds endbr instruction at the
> > > function entry, so the idea is to 'fix' entry ip for kprobe_multi
> > > and trampoline probes, because they are placed on the function
> > > entry.
> > >
> > > For kprobes I only fixed the bpf test program to adjust ip based
> > > on CONFIG_X86_KERNEL_IBT option. I'm not sure what the right fix
> > > should be in here, because I think user should be aware where the
> > 
> > user can't be aware of this when using multi-kprobe attach by symbolic
> > name of the function. So I think bpf_get_func_ip() at least in that
> > case should be compensating for KERNEL_IBT.
> 
> sorry I said kprobes, but that does not include kprobe multi link,
> I meant what you call general kprobe below
> 
> I do the adjustment for kprobe multi version of bpf_get_func_ip,
> so that should be fine
> 
> > 
> > BTW, given in general kprobe can be placed in them middle of the
> > function, should bpf_get_func_ip() return zero or something for such
> > cases instead of wrong value somewhere in the middle of kprobe? If
> > user cares about current IP, they can get it with PT_REGS_IP(ctx),
> > right?
> 
> true.. we could add flag to 'struct kprobe' to indicate it's placed
> on function's entry and check on endbr instruction for IBT config,
> and return 0 for anything else

Masami,
we'd like to be able to tell if the kprobe is placed on the function
entry, so we could return its address in the get_func_ip helper in
such case

would a new flag for this be acceptable for struct kprobe?

I squashed the kprobe change together with our usage, because it's
shows the usage nicely and it's small diff ;-)

thanks,
jirka


---
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 55041d2f884d..a0b92be98984 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -103,6 +103,7 @@ struct kprobe {
 				   * this flag is only for optimized_kprobe.
 				   */
 #define KPROBE_FLAG_FTRACE	8 /* probe is using ftrace */
+#define KPROBE_FLAG_ON_FUNC_ENTRY	16 /* probe is on the function entry */
 
 /* Has this kprobe gone ? */
 static inline bool kprobe_gone(struct kprobe *p)
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f214f8c088ed..a6b1b5c49d92 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1605,9 +1605,10 @@ int register_kprobe(struct kprobe *p)
 	struct kprobe *old_p;
 	struct module *probed_mod;
 	kprobe_opcode_t *addr;
+	bool on_func_entry;
 
 	/* Adjust probe address from symbol */
-	addr = kprobe_addr(p);
+	addr = _kprobe_addr(p->addr, p->symbol_name, p->offset, &on_func_entry);
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
 	p->addr = addr;
@@ -1627,6 +1628,9 @@ int register_kprobe(struct kprobe *p)
 
 	mutex_lock(&kprobe_mutex);
 
+	if (on_func_entry)
+		p->flags |= KPROBE_FLAG_ON_FUNC_ENTRY;
+
 	old_p = get_kprobe(p->addr);
 	if (old_p) {
 		/* Since this may unoptimize 'old_p', locking 'text_mutex'. */
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index bcada91b0b3b..f80c642d7491 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1029,8 +1029,17 @@ static const struct bpf_func_proto bpf_get_func_ip_proto_tracing = {
 BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
 {
 	struct kprobe *kp = kprobe_running();
+	uintptr_t addr;
 
-	return kp ? (uintptr_t)kp->addr : 0;
+	if (!kp || !(kp->flags & KPROBE_FLAG_ON_FUNC_ENTRY))
+		return 0;
+
+	addr = (uintptr_t)kp->addr;
+#ifdef CONFIG_X86_KERNEL_IBT
+	if (is_endbr(*((u32 *) entry_ip - 1)))
+		addr -= ENDBR_INSN_SIZE;
+#endif
+	return addr;
 }
 
 static const struct bpf_func_proto bpf_get_func_ip_proto_kprobe = {
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index a587aeca5ae0..6db70757bc8b 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -69,7 +69,7 @@ int test6(struct pt_regs *ctx)
 {
 	__u64 addr = bpf_get_func_ip(ctx);
 
-	test6_result = (const void *) addr == &bpf_fentry_test6 + 5;
+	test6_result = (const void *) addr == 0;
 	return 0;
 }
 
@@ -79,6 +79,6 @@ int test7(struct pt_regs *ctx)
 {
 	__u64 addr = bpf_get_func_ip(ctx);
 
-	test7_result = (const void *) addr == &bpf_fentry_test7 + 5;
+	test7_result = (const void *) addr == 0;
 	return 0;
 }
