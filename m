Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A864B178F
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 22:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344599AbiBJVbD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 16:31:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiBJVbC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 16:31:02 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F292AF;
        Thu, 10 Feb 2022 13:31:02 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so4914482wml.5;
        Thu, 10 Feb 2022 13:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4BeLswz4uwXnLkdP1gSLpYTk50eigZmqyj9QjlpSSbk=;
        b=OZj6A7aK9kX72LVeFa5Yn+xLK1S1kErGcMbK8UZ9YBQdlOJegvbVIlm36L2Mt7KPIz
         GkAukXynv1VG9AskcAKqDCX1FPqTS2OiEipF7R1FK85o6w434zUnE3ObPUB5VWCn+bpN
         EHKyEMma7sr6lDiEjKZm4jeH4wQ+QzFOoQ+dvoQbX+RXcQ1CxDZoXAbFchZ/68fcTZUW
         kQFRqlhbkahQn9aw7MO7cvQzm1i9nDtk6vGBpm4BWzjkBYe47vMyn0XAbTvB4cD6evSj
         a4OuPvn3c9BFXHboPn3lK04QKer7isOO45+thq81kPZ1c1ZWwHgm3SCobCzrEDOk5vg+
         9tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4BeLswz4uwXnLkdP1gSLpYTk50eigZmqyj9QjlpSSbk=;
        b=HBfrqGCUSWO9zYZ6ayyzd3t1gnVkIa0wLTDij3ltBGBobK/buc5Ne4ti2sth1nXaVu
         5xmoNUqZU+rE/IB5n/uGCR0b6x71srhMGsZhCPRx1uhbXnTF2DyaJ+e+9PMvOAOGRSpS
         7B6X+lmU8k2t5bY8ClhUrncgLkDEnORkWHSGbK8GC/rkkkQDit+vhrF8WLOeK5UOI2xf
         Pao8XF1Cs8qik2tFoxfnUiFhovBEoYhThBtSDcQCuHK5q4PJ4rJjY54wVSzuKZ6B//bE
         JbdCT49n55tooZxxYe24ogcaQpFi2dbshjSu8QadNEGBGIVKDZmYiiqY7o7DO8DTS8KM
         C9/g==
X-Gm-Message-State: AOAM5337YBSsEstMLf8kHTby/p17mctCamazIyppqd+h/1IFrBEaszLM
        NLvo6SLOXC3nQepHCYkGCk8=
X-Google-Smtp-Source: ABdhPJykJcevLS741XZEm/Nvw5LSJkMHCbv7yL4ZZoVH8Qp90q9ZdDWqmi8khL4q9MiMFJfioRMBSg==
X-Received: by 2002:a1c:7716:: with SMTP id t22mr3734723wmi.89.1644528660465;
        Thu, 10 Feb 2022 13:31:00 -0800 (PST)
Received: from krava ([2a00:102a:5012:38c8:44ed:acb8:46d1:b6d4])
        by smtp.gmail.com with ESMTPSA id az7sm2870637wmb.14.2022.02.10.13.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 13:31:00 -0800 (PST)
Date:   Thu, 10 Feb 2022 22:30:56 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH 1/3] perf/bpf: Remove prologue generation
Message-ID: <YgWEEHFV4U0jhrX8@krava>
References: <20220123221932.537060-1-jolsa@kernel.org>
 <YgVk8t6COJhDJyzj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgVk8t6COJhDJyzj@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 10, 2022 at 04:18:10PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, Jan 23, 2022 at 11:19:30PM +0100, Jiri Olsa escreveu:
> > Removing code for ebpf program prologue generation.
> > 
> > The prologue code was used to get data for extra arguments specified
> > in program section name, like:
> > 
> >   SEC("lock_page=__lock_page page->flags")
> >   int lock_page(struct pt_regs *ctx, int err, unsigned long flags)
> >   {
> >          return 1;
> >   }
> > 
> > This code is using deprecated libbpf API and blocks its removal.
> > 
> > This feature was not documented and broken for some time without
> > anyone complaining, also original authors are not responding,
> > so I'm removing it.
> 
> So, the example below breaks, how hard would be to move the deprecated
> APIs to perf like was done in some other cases?
> 
> - Arnaldo
> 
> Before:
> 
> [root@quaco perf]# cat tools/perf/examples/bpf/5sec.c 
> // SPDX-License-Identifier: GPL-2.0
> /*
>     Description:
> 
>     . Disable strace like syscall tracing (--no-syscalls), or try tracing
>       just some (-e *sleep).
> 
>     . Attach a filter function to a kernel function, returning when it should
>       be considered, i.e. appear on the output.
> 
>     . Run it system wide, so that any sleep of >= 5 seconds and < than 6
>       seconds gets caught.
> 
>     . Ask for callgraphs using DWARF info, so that userspace can be unwound
> 
>     . While this is running, run something like "sleep 5s".
> 
>     . If we decide to add tv_nsec as well, then it becomes:
> 
>       int probe(hrtimer_nanosleep, rqtp->tv_sec rqtp->tv_nsec)(void *ctx, int err, long sec, long nsec)
> 
>       I.e. add where it comes from (rqtp->tv_nsec) and where it will be
>       accessible in the function body (nsec)
> 
>     # perf trace --no-syscalls -e tools/perf/examples/bpf/5sec.c/call-graph=dwarf/
>          0.000 perf_bpf_probe:func:(ffffffff9811b5f0) tv_sec=5
>                                            hrtimer_nanosleep ([kernel.kallsyms])
>                                            __x64_sys_nanosleep ([kernel.kallsyms])
>                                            do_syscall_64 ([kernel.kallsyms])
>                                            entry_SYSCALL_64 ([kernel.kallsyms])
>                                            __GI___nanosleep (/usr/lib64/libc-2.26.so)
>                                            rpl_nanosleep (/usr/bin/sleep)
>                                            xnanosleep (/usr/bin/sleep)
>                                            main (/usr/bin/sleep)
>                                            __libc_start_main (/usr/lib64/libc-2.26.so)
>                                            _start (/usr/bin/sleep)
>     ^C#
> 
>    Copyright (C) 2018 Red Hat, Inc., Arnaldo Carvalho de Melo <acme@redhat.com>
> */
> 
> #include <bpf.h>
> 
> #define NSEC_PER_SEC	1000000000L
> 
> int probe(hrtimer_nanosleep, rqtp)(void *ctx, int err, long long sec)
> {
> 	return sec / NSEC_PER_SEC == 5ULL;
> }

that sucks ;-) I'll check if we can re-implement as we discussed earlier,
however below is workaround how to do it without the prologue support

jirka


---
diff --git a/tools/perf/examples/bpf/5sec.c b/tools/perf/examples/bpf/5sec.c
index e6b6181c6dc6..734d39debdb8 100644
--- a/tools/perf/examples/bpf/5sec.c
+++ b/tools/perf/examples/bpf/5sec.c
@@ -43,9 +43,17 @@
 
 #define NSEC_PER_SEC	1000000000L
 
-int probe(hrtimer_nanosleep, rqtp)(void *ctx, int err, long long sec)
+struct pt_regs {
+        long di;
+};
+
+SEC("function=hrtimer_nanosleep")
+int krava(struct pt_regs *ctx)
 {
-	return sec / NSEC_PER_SEC == 5ULL;
+	unsigned long arg;
+
+	probe_read_kernel(&arg, sizeof(arg), __builtin_preserve_access_index(&ctx->di));
+	return arg / NSEC_PER_SEC == 5ULL;
 }
 
 license(GPL);
diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index b422aeef5339..b7d6d2fc8342 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -64,6 +64,7 @@ int _version SEC("version") = LINUX_VERSION_CODE;
 
 static int (*probe_read)(void *dst, int size, const void *unsafe_addr) = (void *)BPF_FUNC_probe_read;
 static int (*probe_read_str)(void *dst, int size, const void *unsafe_addr) = (void *)BPF_FUNC_probe_read_str;
+static long (*probe_read_kernel)(void *dst, __u32 size, const void *unsafe_ptr) = (void *) BPF_FUNC_probe_read_kernel;
 
 static int (*perf_event_output)(void *, struct bpf_map *, int, void *, unsigned long) = (void *)BPF_FUNC_perf_event_output;
 
diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 96c8ef60f4f8..9274a3373847 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -25,7 +25,7 @@
 		"$CLANG_OPTIONS $PERF_BPF_INC_OPTIONS $KERNEL_INC_OPTIONS " \
 		"-Wno-unused-value -Wno-pointer-sign "		\
 		"-working-directory $WORKING_DIR "		\
-		"-c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE"
+		"-g -c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE"
 
 struct llvm_param llvm_param = {
 	.clang_path = "clang",
