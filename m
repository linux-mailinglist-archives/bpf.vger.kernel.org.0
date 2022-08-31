Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4475A7ACA
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 12:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiHaKBY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 06:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiHaKA4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 06:00:56 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDD5B81F1
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 03:00:53 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w2so2171586edc.0
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 03:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date;
        bh=OkgkNsV83y5Hwh3TY/7BY4JJyYSbClGBlYquGtiapgs=;
        b=PyXBKTxa9Z5FkA4cnoK0cIwv3/F+BCXSdIiGHNd5Q1HgOTGc2ft5gsJKle56/5EHUK
         HxJ7jRh0yuS5M1mAPB0Hr+yHgX91mdY6SoOgoiL2yWraFhpswcdT7AeQIJU6aKmjUHCo
         56wbiBsrldWrvpkl+VCgJmjKG6QKxrHXhFBNeYMtLeaXZKVlO6qBKKz+VtCuKIyXZTTy
         H16V6xWp5V9AtqplZL3n2IdjAqWbQZeLHmj3d2dWjuZLMZGdAoaWuqw2zQGwebq5zgfx
         5DzsLQgKC+JrBScWC46D/Kn2aFmG1jumFM33i5PnFs4v/eSSl1xT892b+18ba0ooe4CM
         g10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=OkgkNsV83y5Hwh3TY/7BY4JJyYSbClGBlYquGtiapgs=;
        b=k2VDWYnVjJZ1dVVVqRLjuQypQ0ysbiXpy5LIHOCRLAiiUtKElvY15dd80r3aNtwGNf
         tjuy4QCnTA+cPABrQzXAhWLtaKFsLEdqGURvRxJlj0iHBnbrdv2YGQtaA6AUAi1b8yoK
         l7vS073j8HtUVHbEXZ66oOT9M4PgX00u3IsrwSjsLlR+WjNBoyL728Pdwj5QI0ksuRs/
         Tj3wVmIy03cBzl53594VEJnAgGqXdh1jnmJOpdnmRQHQe6PNff07jETCISIMT4EkGg8R
         MtNzRuxnvJdHDRRo/vOIHTIFnS4Nq8Qylg7Q4jx/ePNXvuDsJ99qqg74SW4WbtVhN1C/
         xt+Q==
X-Gm-Message-State: ACgBeo1O01AOZSxiir5iGBhcA+q98FpcSaZEV7RCrGbFGdz2GlDKmi3t
        EG5xC7NCljddiHQb9GdpdR8=
X-Google-Smtp-Source: AA6agR7J179QpUzqLFpD/TQbxVJq9EaB3R6EpljuNeZKnG5GHU9Q8BVyoOQoCWQYv+voCxmS2wo7jg==
X-Received: by 2002:aa7:d78b:0:b0:447:d501:14c8 with SMTP id s11-20020aa7d78b000000b00447d50114c8mr19894731edq.82.1661940051409;
        Wed, 31 Aug 2022 03:00:51 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id v18-20020a170906293200b007417c5dbfeesm4326365ejd.70.2022.08.31.03.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 03:00:50 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 31 Aug 2022 12:00:49 +0200
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Subject: Re: [PATCH bpf-next 0/2] bpf,ftrace: bpf dispatcher function fix
Message-ID: <Yw8xUf23aBXoYCRc@krava>
References: <20220826184608.141475-1-jolsa@kernel.org>
 <9099057e-124c-8f30-c29d-54be85eeebfd@iogearbox.net>
 <Yw4VSr7X8hacimrB@krava>
 <480244bd73be4fca57da47801b9135c2b4ad9457.camel@linux.ibm.com>
 <969a14281a7791c334d476825863ee449964dd0c.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <969a14281a7791c334d476825863ee449964dd0c.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 31, 2022 at 01:46:09AM +0200, Ilya Leoshkevich wrote:
> On Tue, 2022-08-30 at 18:46 +0200, Ilya Leoshkevich wrote:
> > On Tue, 2022-08-30 at 15:48 +0200, Jiri Olsa wrote:
> > > On Tue, Aug 30, 2022 at 12:25:25AM +0200, Daniel Borkmann wrote:
> > > > On 8/26/22 8:46 PM, Jiri Olsa wrote:
> > > > > hi,
> > > > > as discussed [1] sending fix that moves bpf dispatcher function
> > > > > of out
> > > > > ftrace locations together with Peter's
> > > > > HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
> > > > > dependency change.
> > > > 
> > > > Looks like the series breaks s390x builds; BPF CI link:
> > > > 
> > > > https://github.com/kernel-patches/bpf/runs/8079411784?check_suite_focus=true
> > > > 
> > > >   [...]
> > > >     CC      net/xfrm/xfrm_state.o
> > > >     CC      net/packet/af_packet.o
> > > >   {standard input}: Assembler messages:
> > > >   {standard input}:16055: Error: bad expression
> > > >   {standard input}:16056: Error: bad expression
> > > >   {standard input}:16057: Error: bad expression
> > > >   {standard input}:16058: Error: bad expression
> > > >   {standard input}:16059: Error: bad expression
> > > >     CC      drivers/s390/char/raw3270.o
> > > >     CC      net/ipv6/ip6_output.o
> > > >   [...]
> > > >     CC      net/xfrm/xfrm_output.o
> > > >     CC      net/ipv6/ip6_input.o
> > > >   {standard input}:16055: Error: invalid operands (*ABS* and
> > > > *UND*
> > > > sections) for `%'
> > > >   {standard input}:16056: Error: invalid operands (*ABS* and
> > > > *UND*
> > > > sections) for `%'
> > > >   {standard input}:16057: Error: invalid operands (*ABS* and
> > > > *UND*
> > > > sections) for `%'
> > > >   {standard input}:16058: Error: invalid operands (*ABS* and
> > > > *UND*
> > > > sections) for `%'
> > > >   {standard input}:16059: Error: invalid operands (*ABS* and
> > > > *UND*
> > > > sections) for `%'
> > > >   make[3]: *** [scripts/Makefile.build:249: net/core/filter.o]
> > > > Error 1
> > > >   make[2]: *** [scripts/Makefile.build:465: net/core] Error 2
> > > >   make[2]: *** Waiting for unfinished jobs....
> > > >     CC      net/ipv4/tcp_fastopen.o
> > > >   [...]
> > > >     CC      lib/percpu-refcount.o
> > > >   make[1]: *** [Makefile:1855: net] Error 2
> > > >     CC      lib/rhashtable.o
> > > >   make[1]: *** Waiting for unfinished jobs....
> > > >     CC      lib/base64.o
> > > >   [...]
> > > >     AR      lib/built-in.a
> > > >     CC      kernel/kheaders.o
> > > >     AR      kernel/built-in.a
> > > >   make: *** [Makefile:353: __build_one_by_one] Error 2
> > > >   Error: Process completed with exit code 2.
> > > 
> > > 
> > > it does not break on my cross build with gcc 12, but I can
> > > reproduce with gcc 8 (CI seems to be on gcc 9)
> > > 
> > > the problem seems to be wrong assembler code with extra '%'
> > > that's generated for patchable_function_entry(5)
> > > 
> > > gcc 8 generates:
> > > 
> > > .LPFE1:
> > >         nopr    %%r0
> > >         nopr    %%r0
> > >         nopr    %%r0
> > >         nopr    %%r0
> > >         nopr    %%r0
> > > 
> > > and gcc 12 generates:
> > > 
> > > .LPFE1:
> > >         nopr    %r0
> > >         nopr    %r0
> > >         nopr    %r0
> > >         nopr    %r0
> > >         nopr    %r0
> > > 
> > > perhaps we need to upgrade gcc in CI? cc-ing Ilya, any idea?
> > > 
> > > thanks,
> > > jirka
> > 
> > It's not obvious to me which gcc commit fixed this; I will bisect and
> > find out. This will take some time.
> > 
> > However, officially, the kernel must be buildable by gcc 5.1+.
> > Whatever I find, it's unlikely that we'll be able to backport it
> > that far.
> > 
> > Therefore I think we need to find a way to conditionally
> > do something else when using broken gccs. Or maybe just keep this
> > x86-only after all.
> > 
> > Best regards,
> > Ilya
> 
> FWIW, bisect points to
> 
> https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=45d06a4045bebc3dbaaf0b1c676f4e22b7c6aca1

great, thanks for doing that

> 
> which makes perfect sense. Still, as I mentioned above, it's probably
> worth tolerating brokens gccs instead of spending time backporting this
> everywhere. And upgrading the CI machine will only paper over the
> issue.
> 
> At a closer look, it looks weird to me that we have
> patchable_function_entry(5) in a common header. If this optimization
> is ever implemented for another architecture, a different number will
> be required.
> 
> For simplicity, would it make sense to hide this under an #ifdef?
> Something like this (untested):
> 
> #ifdef CONFIG_X86
> #define BPF_DISPATCHER_ATTRIBUTES
> __attribute__((patchable_function_entry(5)))
> #else
> #define BPF_DISPATCHER_ATTRIBUTES
> #endif

right, I think we can limit it directly to x86_64 like below

jirka


---
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f9920f1341c8..089c20cefd2b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -284,6 +284,7 @@ config X86
 	select PROC_PID_ARCH_STATUS		if PROC_FS
 	select HAVE_ARCH_NODE_DEV_GROUP		if X86_SGX
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
+	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9c1674973e03..4ab4b0a1beb8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -924,7 +924,15 @@ int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
 	},							\
 }
 
+#ifdef CONFIG_X86_64
+#define BPF_DISPATCHER_ATTRIBUTES __attribute__((__no_instrument_function__)) \
+				   __attribute__((patchable_function_entry(5)))
+#else
+#define BPF_DISPATCHER_ATTRIBUTES
+#endif
+
 #define DEFINE_BPF_DISPATCHER(name)					\
+	BPF_DISPATCHER_ATTRIBUTES					\
 	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\
 		const void *ctx,					\
 		const struct bpf_insn *insnsi,				\
