Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FF05916AE
	for <lists+bpf@lfdr.de>; Fri, 12 Aug 2022 23:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbiHLVSW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Aug 2022 17:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbiHLVSV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Aug 2022 17:18:21 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303A47434A
        for <bpf@vger.kernel.org>; Fri, 12 Aug 2022 14:18:20 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l4so2367353wrm.13
        for <bpf@vger.kernel.org>; Fri, 12 Aug 2022 14:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=GLX3vdI9yRWeOE5xUvzkSCoOc4PyvTv7yrLldEJz3BA=;
        b=B7CqyMWAlii+zwhT7OTBdLhaoxMRmn+jIMvX1DH5CQCoODM9ZuUkTc1FLoXdqcheaI
         60R4tEFhptSxd1HXRAwi2F/G0FzW7chGJFF7xBZd4OhY7uWdakndhWySUj0sKaphoVZn
         KXt3QJ2QWBHLs4DPKp6SM2EDbbJk68mcgLJZ3aC7vA1T6LGcVItWJLj1NxCEcxb+z93y
         BAwKPDVipeNHPMolQGKfcyTSwyjuUWBxL2IRAgUxPm1LZJdPkIgql5lf4L9r2mPOOX3n
         YseLuTyHqVu7pXA+1XdHxll1BM6Ri8kXiVVYVpDqMgMpfesXA8vlss87hkYl1mBSCC5n
         corA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=GLX3vdI9yRWeOE5xUvzkSCoOc4PyvTv7yrLldEJz3BA=;
        b=Y5/WDw22pfe5vbuqK2Hk2g5+3fq9ufuggIVaXp3DAAt0N3+GLD2ODVzcT+JlM8qlH9
         RVYynZZ0wHgX1vQ0LkojSYltM/LSRhiI85eSdmySBgO4tgSv4VJyWHRhI6WOtz83tVU/
         gG2l2+2vXXXq86IK9ZjxeeYnrg87YSI000c1FHrLHR1MMxJomQ6nMMe1yoXqzOmbAbga
         vafVqPUiMj2IILmkFCaSCNnEVvI0SZl/fsDZhs4uok+t3wuNBBM6Fuq1Nq1R5pXiDGr7
         svMU/xLaQ4X3Nw3e6v2cI0nrreYB1b31ZZpGZl13fw6quHpebUKYtgfdJWZXtoQ0wn9y
         8l6Q==
X-Gm-Message-State: ACgBeo0caZT+wgUODG4w7/ALJbfLqESMOoxTAT0q4IfljDTQDejafN+t
        9qUNfzIBQ71kFgbELScTKsc=
X-Google-Smtp-Source: AA6agR7zitgqz6b4Cv6enl7puyGiaE+/4eJc5vN9gVS2KTTb6U3qHxMBb6g3HDrt6in/LKfH3eQQkg==
X-Received: by 2002:a5d:640f:0:b0:220:e5a7:f5e7 with SMTP id z15-20020a5d640f000000b00220e5a7f5e7mr3015429wru.314.1660339098597;
        Fri, 12 Aug 2022 14:18:18 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id bi9-20020a05600c3d8900b003a4efb794d7sm626824wmb.36.2022.08.12.14.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 14:18:18 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 12 Aug 2022 23:18:15 +0200
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
Message-ID: <YvbDlwJCTDWQ9uJj@krava>
References: <20220722110811.124515-1-jolsa@kernel.org>
 <20220722072608.17ef543f@rorschach.local.home>
 <CAADnVQ+hLnyztCi9aqpptjQk-P+ByAkyj2pjbdD45dsXwpZ0bw@mail.gmail.com>
 <20220722120854.3cc6ec4b@gandalf.local.home>
 <20220722122548.2db543ca@gandalf.local.home>
 <YtsRD1Po3qJy3w3t@krava>
 <20220722174120.688768a3@gandalf.local.home>
 <YtxqjxJVbw3RD4jt@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtxqjxJVbw3RD4jt@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jul 23, 2022 at 11:39:27PM +0200, Jiri Olsa wrote:
> On Fri, Jul 22, 2022 at 05:41:20PM -0400, Steven Rostedt wrote:
> > On Fri, 22 Jul 2022 23:05:19 +0200
> > Jiri Olsa <olsajiri@gmail.com> wrote:
> > 
> > > ok, I think we could use that, I'll check
> > > 
> > > > 
> > > > But other than that, we don't need infrastructure to hide any mcount/fentry
> > > > locations from ftrace. Those were add *for* ftrace.  
> > > 
> > > I think I understand the fentry/ftrace equivalence you see, I remember
> > > the perl mcount script ;-)
> > 
> > It's even more than that. We worked with the compiler folks to get fentry
> > for ftrace purposes (namely to speed it up, and not rely on frame
> > pointers, which mcount did). fentry never existed until then. Like I said.
> > fentry was created *for* ftrace. And currently it's x86 specific, as it
> > relies on the calling convention that a call does both, push the return
> > address onto the  stack, and jump to a function. The blr
> > (branch-link-register) method is more complex, which is where the
> > "patchable" work comes from.
> > 
> > > 
> > > still I think we should be able to define function that has fentry
> > > profile call and be able to manage it without ftrace
> > > 
> > > one other thought.. how about adding function that would allow to disable
> > > function in ftrace, with existing FTRACE_FL_DISABLED or some new flag
> > > 
> > > that way ftrace still keeps track of it, but won't allow to use it in
> > > ftrace infra
> > 
> > Another way is to remove it at compile time from the mcount_loc table, and
> > add it to your own table. I take it, this is for bpf infrastructure code
> 
> hm, perhaps we could move it to separate object and switch off
> -mrecord-mcount for it, I'll check

the patch below moves the bpf function into sepatate object and switches
off the -mrecord-mcount for it.. so the function gets profile call
generated but it's not visible to ftrace

this seems to work, but it depends on -mrecord-mcount support in gcc and
it's x86 specific... other archs seems to use -fpatchable-function-entry,
which does not seem to have option to omit symbol from being collected
to the section

disabling specific ftrace symbol with FTRACE_FL_DISABLED flag seems to
be easir and generic solution.. I'll send RFC for that

jirka


---
diff --git a/net/core/Makefile b/net/core/Makefile
index e8ce3bd283a6..7d7ba2038879 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -12,10 +12,14 @@ obj-$(CONFIG_SYSCTL) += sysctl_net_core.o
 obj-y		     += dev.o dev_addr_lists.o dst.o netevent.o \
 			neighbour.o rtnetlink.o utils.o link_watch.o filter.o \
 			sock_diag.o dev_ioctl.o tso.o sock_reuseport.o \
-			fib_notifier.o xdp.o flow_offload.o gro.o
+			fib_notifier.o xdp.o flow_offload.o gro.o \
+			dispatcher.o
 
 obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 
+# remove dispatcher function from ftrace sight
+CFLAGS_REMOVE_dispatcher.o = -mrecord-mcount
+
 obj-y += net-sysfs.o
 obj-$(CONFIG_PAGE_POOL) += page_pool.o
 obj-$(CONFIG_PROC_FS) += net-procfs.o
diff --git a/net/core/dispatcher.c b/net/core/dispatcher.c
new file mode 100644
index 000000000000..7d2730b15de0
--- /dev/null
+++ b/net/core/dispatcher.c
@@ -0,0 +1,3 @@
+#include <linux/bpf.h>
+
+DEFINE_BPF_DISPATCHER(xdp)
diff --git a/net/core/filter.c b/net/core/filter.c
index 5669248aff25..23fe2c5dfe9d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11333,8 +11333,6 @@ const struct bpf_verifier_ops sk_lookup_verifier_ops = {
 
 #endif /* CONFIG_INET */
 
-DEFINE_BPF_DISPATCHER(xdp)
-
 void bpf_prog_change_xdp(struct bpf_prog *prev_prog, struct bpf_prog *prog)
 {
 	bpf_dispatcher_change_prog(BPF_DISPATCHER_PTR(xdp), prev_prog, prog);
