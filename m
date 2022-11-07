Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7E061F354
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 13:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiKGMbz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 07:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbiKGMbM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 07:31:12 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6641B9C5;
        Mon,  7 Nov 2022 04:31:11 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id g12so15927129wrs.10;
        Mon, 07 Nov 2022 04:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yC8xgVazfP+f7YY+MmwlBVPU23N1YUdB4Go1JaLvyaM=;
        b=DdzJxJAgNMs9+fhBDxWJ9SLu0wpVHnn58T0rAqTG+lkYqt2r0ipW4Ej5kxraxDeMEV
         Q1Rtbc5vc/72qgZg4d7uha2Q2GzDkk+BJ7q9yuFQ1FE3+8qyTR3f/+q+ZLXup0VdBzhi
         NJGs55U4lxOwfUrHaA5QJRZ4WMy6lLhbYAkyDQhB4ZSt00qaDhKopvhqFAhYB39sJKMx
         KaZ5XMUQvCpLC9vEKSh/6o7aCiG4KB6rQfFcvmGLZlKW9SgmfjBVil4JyV5LfEOmyAVg
         M1G5VZ9xp9uBifAGetbjmEiWJVGKaqN2YmM89COENECKqjWRqRllm9ysyF+mEyA9XcKQ
         4crQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yC8xgVazfP+f7YY+MmwlBVPU23N1YUdB4Go1JaLvyaM=;
        b=ZfsHr4PMC5882gZu70WL/xtO/jmYek9fRWDG5g3kbLZeD4YU9yOuC2Zii2pbNsyJZg
         etw+AArVkLdzrtEjWtHqkUbAiJsAzEmAN0EhcdiQVmY6Jjp9ojsGjf0Al7TbVt7L3gtg
         noSJg69V4LypgPbZmeWzBg3NumNkgM+lq3sNz5CaysK4NfcNKDw096tTOdUd18aB74/2
         dv8LBK2cjwbJCtOxLkpiwm1HEjrpkfsA9SBhb91NHSUlfuMLsPewEk0GVLhqDy37/3ai
         Ejm5ZU7vJ5cXevmmpP3Qqtazm2xPKk97ElSUsUdRa4pColIkweDCC1JFTwaUnMWGtSsT
         PmnQ==
X-Gm-Message-State: ACrzQf3gVeaYKyUozEwuEvSsg1EBW9FG+cPDS50UQjayTPJra3dAyaTG
        v6sZj8qmcnd/JaGc89rZqy8=
X-Google-Smtp-Source: AMsMyM4rZ0g9bl931hSQC+RmUdmDMLLUpzU1HkY+7SRwliWbZgmg36+xnF7W52a3SaHaNgeKvLiImQ==
X-Received: by 2002:adf:e94b:0:b0:236:64a5:4038 with SMTP id m11-20020adfe94b000000b0023664a54038mr33063834wrn.321.1667824269727;
        Mon, 07 Nov 2022 04:31:09 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id w2-20020a5d6802000000b0023662245d3csm7171950wru.95.2022.11.07.04.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:31:09 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 7 Nov 2022 13:31:06 +0100
To:     Hao Sun <sunhao.th@gmail.com>, ast@kernel.org
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andrii@kernel.org, bpf <bpf@vger.kernel.org>, daniel@iogearbox.net,
        haoluo@google.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        martin.lau@linux.dev, sdf@google.com, song@kernel.org, yhs@fb.com
Subject: Re: WARNING in bpf_bprintf_prepare
Message-ID: <Y2j6ivTwFmA0FtvY@krava>
References: <CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com>
 <Y1pqWPRmP0M+hcXf@krava>
 <CACkBjsbP-iw-gpnYN=Ormcu2zXAeOgjeptjGAFXNNJRRVhRAag@mail.gmail.com>
 <Y2J+n7SqmtfyA7ZM@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2J+n7SqmtfyA7ZM@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 02, 2022 at 03:28:47PM +0100, Jiri Olsa wrote:
> On Thu, Oct 27, 2022 at 07:45:16PM +0800, Hao Sun wrote:
> > Jiri Olsa <olsajiri@gmail.com> 于2022年10月27日周四 19:24写道：
> > >
> > > On Thu, Oct 27, 2022 at 10:27:28AM +0800, Hao Sun wrote:
> > > > Hi,
> > > >
> > > > The following warning can be triggered with the C reproducer in the link.
> > > > Syzbot also reported this several days ago, Jiri posted a patch that
> > > > uses bpf prog `active` field to fix this by 05b24ff9b2cfab (bpf:
> > > > Prevent bpf program recursion...) according to syzbot dashboard
> > > > (https://syzkaller.appspot.com/bug?id=179313fb375161d50a98311a28b8e2fc5f7350f9).
> > > > But this warning can still be triggered on 247f34f7b803
> > > > (Linux-v6.1-rc2) that already merged the patch, so it seems that this
> > > > still is an issue.
> > > >
> > > > HEAD commit: 247f34f7b803 Linux 6.1-rc2
> > > > git tree: upstream
> > > > console output: https://pastebin.com/raw/kNw8JCu5
> > > > kernel config: https://pastebin.com/raw/sE5QK5HL
> > > > C reproducer: https://pastebin.com/raw/X96ASi27
> > >
> > > hi,
> > > right, that fix addressed that issue for single bpf program,
> > > and it won't prevent if there are multiple programs hook on
> > > contention_begin tracepoint and calling bpf_trace_printk,
> > >
> > > I'm not sure we can do something there.. will check
> > >
> > > do you run just the reproducer, or you load the server somehow?
> > > I cannot hit the issue so far
> > >
> > 
> > Hi,
> > 
> > Last email has format issues, resend it here.
> > 
> > I built the kernel with the config in the link, which contains
> > “CONFIG_CMDLINE="earlyprintk=serial net.ifnames=0
> > sysctl.kernel.hung_task_all_cpu_backtrace=1 panic_on_warn=1 …”, and
> > boot the kernel with normal qemu setup and then the warning can be
> > triggered by executing the reproducer.
> > 
> > Also, I’m willing to test the proposed patch if any.
> 
> fyi I reproduced that.. will check if we can do anything about that

I reproduced this with set of 8 programs all hooked to contention_begin
tracepoint and here's what I think is happening:

all programs (prog1 .. prog8) call just bpf_trace_printk helper and I'm
running 'perf bench sched messaging' to load the machine

at some point some contended lock triggers trace_contention_begin:

  trace_contention_begin
    __traceiter_contention_begin                                <-- iterates all functions attached to tracepoint
      __bpf_trace_run(prog1)
        prog1->active = 1
        bpf_prog_run(prog1)
          bpf_trace_printk
            bpf_bprintf_prepare                                 <-- takes buffer 1 out of 3
            raw_spin_lock_irqsave(trace_printk_lock)

              # we have global single trace_printk_lock, so we will trigger
              # its trace_contention_begin at some point

              trace_contention_begin
                __traceiter_contention_begin
                  __bpf_trace_run(prog1)
                    prog1->active block                         <-- prog1 is already 'running', skipping the execution
                  __bpf_trace_run(prog2)
                    prog2->active = 1
                    bpf_prog_run(prog2)
                      bpf_trace_printk
                        bpf_bprintf_prepare                     <-- takes buffer 2 out of 3
                        raw_spin_lock_irqsave(trace_printk_lock)
                          trace_contention_begin
                            __traceiter_contention_begin
                              __bpf_trace_run(prog1)
                                prog1->active block             <-- prog1 is already 'running', skipping the execution
                              __bpf_trace_run(prog2)
                                prog2->active block             <-- prog2 is already 'running', skipping the execution
                              __bpf_trace_run(prog3)
                                 prog3->active = 1
                                 bpf_prog_run(prog3)
                                   bpf_trace_printk
                                     bpf_bprintf_prepare        <-- takes buffer 3 out of 3
                                     raw_spin_lock_irqsave(trace_printk_lock)
                                       trace_contention_begin
                                         __traceiter_contention_begin
                                           __bpf_trace_run(prog1)
                                             prog1->active block      <-- prog1 is already 'running', skipping the execution
                                           __bpf_trace_run(prog2)
                                             prog2->active block      <-- prog2 is already 'running', skipping the execution
                                           __bpf_trace_run(prog3)
                                             prog3->active block      <-- prog3 is already 'running', skipping the execution
                                           __bpf_trace_run(prog4)
                                             prog4->active = 1
                                             bpf_prog_run(prog4)
                                               bpf_trace_printk
                                                 bpf_bprintf_prepare  <-- tries to take buffer 4 out of 3 -> WARNING


the code path may vary based on the contention of the trace_printk_lock,
so I saw different nesting within 8 programs, but all eventually ended up
at 4 levels of nesting and hit the warning

I think we could perhaps move the 'active' flag protection from program
to the tracepoint level (in the patch below), to prevent nesting execution
of the same tracepoint, so it'd look like:

  trace_contention_begin
    __traceiter_contention_begin
      __bpf_trace_run(prog1) {
        contention_begin.active = 1
        bpf_prog_run(prog1)
          bpf_trace_printk
            bpf_bprintf_prepare
            raw_spin_lock_irqsave(trace_printk_lock)
              trace_contention_begin
                __traceiter_contention_begin
                  __bpf_trace_run(prog1)
                    blocked because contention_begin.active == 1
                  __bpf_trace_run(prog2)
                    blocked because contention_begin.active == 1
                  __bpf_trace_run(prog3)
                  ...
                  __bpf_trace_run(prog8)
                    blocked because contention_begin.active == 1

            raw_spin_unlock_irqrestore
            bpf_bprintf_cleanup

        contention_begin.active = 0
      }

      __bpf_trace_run(prog2) {
        contention_begin.active = 1
        bpf_prog_run(prog2)
          ...
        contention_begin.active = 0
      }

do we need bpf program execution in nested tracepoints?
we could actually allow 3 nesting levels for this case.. thoughts?

thanks,
jirka


---
diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index 6a13220d2d27..5a354ae096e5 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -78,11 +78,15 @@
 #define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
 
 #define __BPF_DECLARE_TRACE(call, proto, args)				\
+static DEFINE_PER_CPU(int, __bpf_trace_tp_active_##call);		\
 static notrace void							\
 __bpf_trace_##call(void *__data, proto)					\
 {									\
 	struct bpf_prog *prog = __data;					\
-	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));	\
+									\
+	if (likely(this_cpu_inc_return(__bpf_trace_tp_active_##call) == 1))		\
+		CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));	\
+	this_cpu_dec(__bpf_trace_tp_active_##call);					\
 }
 
 #undef DECLARE_EVENT_CLASS
