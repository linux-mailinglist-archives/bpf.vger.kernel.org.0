Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBC46452CE
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 05:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiLGECN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 23:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiLGECA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 23:02:00 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6B0275CD;
        Tue,  6 Dec 2022 20:01:51 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so323251pjo.3;
        Tue, 06 Dec 2022 20:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8MfYzCBUds8jzYYfrEKFAuA4rbHmq+dDwHtDEGDzwOo=;
        b=KGEwpNyuL4U+ZMiJQ1VqHVxZ/GfAQ1Vz20QjHjIu6v+8jcro8QKyF96tKCQiVYW+F0
         7cqQyeWwM5Q5YSpBHdABXuush9cpJ4nE+4yQX/pi80CP8krov52kWCiBpzsIoPEsbmSN
         znPr02XS7tk4YU5nn3Co4LAvry4GTd3mJvHZGV9k6isOfr4aeL/PiGzWRRT6z2DhzrBp
         9Onf/1OQ+PAmAvC5hzgs4fDOkbYABSi+77l4JEDnESQdWI+/2ceM1qGwYhJrNvoPlsAW
         HSzpkDpWsJqLyBScfX0qKeSdDy2D9qSARVfw6bxTAYBhELWsDyzubsxRUxoqVPxalpy9
         kEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MfYzCBUds8jzYYfrEKFAuA4rbHmq+dDwHtDEGDzwOo=;
        b=RuHQtCoirtYCfMAEBHC/PRUgwmk0MgFsb3a5U8kCMZXpF5uOgX33TKv4QjCqLT/xl9
         1tfJn7B1nhU0hPVc05jVilfviGpSnFjgEDigA6pQ4iZGo3Njcb8UI4+41sEPIyJ/1ksn
         sBJIdkcLnng1IHw3Cn1jXDzpTJ7YEZZ5kzR5l12D2pIfaY7nlPLGwAaMJ8Gx8VqqZkHy
         mkJuLOv37QT3LWK1lvTr5DV9qXT3KXDzAnPS22KDuaei/aQdxk6EvueGINU5nRQWASz/
         0XTaUA4dvrDhYmJ+jY6MpEtlDY9tI7uUFpbyR27vHLfcYefRTvPotxpN1cJR98AMdrVo
         XGiw==
X-Gm-Message-State: ANoB5pl/s3W/DlmOtO1ELkvRSql77qAMX1Qvu490yHvHhAHqpI5xVbMS
        cH+FGfJLF1w+S33SQWorJxE=
X-Google-Smtp-Source: AA0mqf5mKGQtReF+BaOHf5hDBemi0qcZYjA6luAXpDKjnyvytp9+8MDo+rM+VQfO0y2QWDDiz34c2Q==
X-Received: by 2002:a17:903:264b:b0:189:ec62:3b2d with SMTP id je11-20020a170903264b00b00189ec623b2dmr501900plb.4.1670385710328;
        Tue, 06 Dec 2022 20:01:50 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902ce8600b001743ba85d39sm13439017plg.110.2022.12.06.20.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 20:01:49 -0800 (PST)
Date:   Tue, 6 Dec 2022 20:01:46 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chris Mason <clm@meta.com>
Subject: Re: [PATCH v2] panic: Taint kernel if fault injection has been used
Message-ID: <20221207040146.zhm3kyduqp7kosqa@macbook-pro-6.dhcp.thefacebook.com>
References: <167019256481.3792653.4369637751468386073.stgit@devnote3>
 <20221204223001.6wea7cgkofjsiy2z@macbook-pro-6.dhcp.thefacebook.com>
 <20221205075921.02edfe6b54abc5c2f9831875@kernel.org>
 <20221206021700.oryt26otos7vpxjh@macbook-pro-6.dhcp.thefacebook.com>
 <20221206162035.97ae19674d6d17108bed1910@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206162035.97ae19674d6d17108bed1910@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 06, 2022 at 04:20:35PM +0900, Masami Hiramatsu wrote:
> On Mon, 5 Dec 2022 18:17:00 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > On Mon, Dec 05, 2022 at 07:59:21AM +0900, Masami Hiramatsu wrote:
> > > On Sun, 4 Dec 2022 14:30:01 -0800
> > > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > > 
> > > > On Mon, Dec 05, 2022 at 07:22:44AM +0900, Masami Hiramatsu (Google) wrote:
> > > > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > > 
> > > > > Since the function error injection framework in the fault injection
> > > > > subsystem can change the function code flow forcibly, it may cause
> > > > > unexpected behavior (and that is the purpose of this feature) even
> > > > > if it is applied to the ALLOW_ERROR_INJECTION functions.
> > > > > So this feature must be used only for debugging or testing purpose.
> > > > 
> > > > The whole idea of tainting for kernel debugging is questionable.
> > > > There are many other *inject* kconfigs and other debug flags
> > > > for link lists, RCU, sleeping, etc.
> > > > None of them taint the kernel.
> > > > 
> > > > > To identify this in the kernel oops message, add a new taint flag
> > > > 
> > > > Have you ever seen a single oops message because of this particular
> > > > error injection?
> > > 
> > > No, but there is no guarantee that the FEI doesn't cause any issue
> > > in the future too. If it happens, we need to know the precise
> > > information about what FEI/bpf does.
> > > FEI is a kind of temporal Livepatch for testing. If Livepatch taints
> > > the kernel, why doesn't the FEI taint it too?
> > 
> > Live patching can replace an arbitrary function and the kernel has
> > no visibility into what KLP module is doing.
> > While 'bpf error injection' is predictable.
> 
> No, not much predictable because the kernel code can be changed.
> 
> > The functions marked with [BPF_]ALLOW_ERROR_INJECTION can return errors
> > in the normal execution. So the callers of these functions have to deal with errors.
> 
> Right, but it might change something before checking the input, and
> if it rejects the sane input, the caller may go into unexpected
> status (e.g. the caller already checked input value, and does not
> expect the call is fail). Such behaviors are buggy, yes. And the
> FEI is designed for finding such buggy behavior.
> (e.g. injecting error, but the caller passed successfully, it
> means the caller code has some issue.)
> 
> > If kernel panics on such injected error it potentially would have paniced
> > on it anyway.
> 
> Yes, but that doesn't cover all cases. If the function doesn't have
> any internal state but returns an error according to the input,
> FEI can make it return an error even if the input is correct.
> And if it cause a kernel panic, that is a panic that must not
> happen without FEI.
> 
> Thus, the ALLOW_ERROR_INJECTION should only be applied to the
> function which has so-called 'side-effect', e.g. memory allocation,
> external data (except for input data) read, etc. that could cause
> an error regardless of the input value. Then the caller must
> handle such errors.

Not quite. I think you're confusing functions with 'side effect'
with 'pure' functions.
Your point about 'checking args before the call' applies to pure functions.
We have some too: git grep __pure.
Most of the time the compiler can identify the functions that return
the same value with the same args, but sometimes it needs help
and we mark such functions.
Clearly such functions should never be marked as 'error inject'
because changing return value of such function might lead to
wrong code and _it will not be a kernel bug_.
The compiler optimizations rely on the function being pure.
Live kernel patching should be very careful with __pure functions too.
No idea whether they do this now or not.

Of course, there is a category of functions (with or without side effects)
which return values should not be changed by error injecton mechanism.
That's a given. Applying ALLOW_ERROR_INJECTION should not to be taken lightly.

> 
> > At this point crash dump might be necessary to debug.
> 
> Yes. So the TAINT flag can help. Please consider that the TAINT flag
> doesn't mean you are guilty, but this is just a hint for debugging.
> (good for the first triage)

I think you misunderstand the reason behind 'tainted' flags.
It's 'hint for debugging' only on the surface.
See Documentation/admin-guide/tainted-kernels.rst
"... That's why bug reports
from tainted kernels will often be ignored by developers, hence try to reproduce
problems with an untainted kernel."

When 'error injection' finds a kernel bug the kernel developers need to
look into it regardless whether it's syzbot error injection
or whatever other mechanism.

To change the topic to something ... else...

We've just hit this panic using rethook.
[   49.235708] ==================================================================
[   49.236243] BUG: KASAN: use-after-free in rethook_try_get+0x7e/0x380
[   49.236693] Read of size 8 at addr ffff888102e62c88 by task test_progs/1688
[   49.240398]  kasan_report+0x90/0x190
[   49.240934]  rethook_try_get+0x7e/0x380
[   49.244885]  fprobe_handler.part.1+0x119/0x1f0
[   49.245505]  arch_ftrace_ops_list_func+0x17d/0x1d0
[   49.246544]  ftrace_regs_call+0x5/0x52
[   49.247411]  bpf_fentry_test1+0x5/0x10

[   49.262578] Allocated by task 1692:
[   49.262804]  kasan_save_stack+0x1c/0x40
[   49.263059]  kasan_set_track+0x21/0x30
[   49.263335]  __kasan_kmalloc+0x7a/0x90
[   49.263624]  rethook_alloc+0x2c/0xa0
[   49.263879]  fprobe_init_rethook+0x6d/0x170
[   49.264154]  register_fprobe_ips+0xae/0x130

[   49.265938] Freed by task 0:
[   49.266153]  kasan_save_stack+0x1c/0x40
[   49.266440]  kasan_set_track+0x21/0x30
[   49.266705]  kasan_save_free_info+0x26/0x40
[   49.266995]  __kasan_slab_free+0x103/0x190
[   49.267282]  __kmem_cache_free+0x1b7/0x3a0
[   49.267559]  rcu_core+0x4d8/0xd50

[   49.268181] Last potentially related work creation:
[   49.268565]  kasan_save_stack+0x1c/0x40
[   49.268898]  __kasan_record_aux_stack+0xa1/0xb0
[   49.269260]  call_rcu+0x47/0x360
[   49.269526]  unregister_fprobe+0x47/0x80

[   49.281382] general protection fault, probably for non-canonical address 0x57e006e00000000: 0000 [#1] PREEMPT SMP KASAN
[   49.282226] CPU: 6 PID: 1688 Comm: test_progs Tainted: G    B      O       6.1.0-rc7-01508-gf0c5a2d9f234 #4343
[   49.283751] RIP: 0010:rethook_trampoline_handler+0xff/0x1d0
[   49.289900] Call Trace:
[   49.290083]  <TASK>
[   49.290248]  arch_rethook_trampoline_callback+0x6c/0xa0
[   49.290631]  arch_rethook_trampoline+0x2c/0x50
[   49.290964]  ? lock_release+0xad/0x3f0
[   49.291245]  ? bpf_prog_test_run_tracing+0x235/0x380
[   49.291609]  trace_clock_x86_tsc+0x10/0x10

This is just running bpf selftests in parallel mode on 16-cpu VM on bpf-next.
Notice 'Tained' flags.
Please take a look.

Thanks!
