Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC46592ACD
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 10:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbiHOIEn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 04:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiHOIEj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 04:04:39 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B111E3F1;
        Mon, 15 Aug 2022 01:04:38 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id tl27so12308118ejc.1;
        Mon, 15 Aug 2022 01:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc;
        bh=i7/FEeJ1ep7vxqJYsfleU8cFQnhTtW8cVArotC9/5kU=;
        b=IUPvRd52jdRzqabb1mD2aEqiIyAXCIIGuB6s+oOIF7NwpIKdVzKHJmtdM1rb8Mbuls
         eDL4RwlJfyfb/BGlFU1s7myWKQpecHeCu3LHGKmbvs5qJmXqoSncgswAP95ux7nIS46z
         Ae6Sqd3VCLpwod8MYK/84Hc+Ts6tV/8dF9R4c3fFH6Tj0sgyBcOh2Sb3JuApt0BHPucB
         Yf6VmLwphVosJpxLQiS7xhjbLtoo6junh22o0bPFjFaxrH1mLfe2EKRXu0ycRupLM6Y7
         7xvf8SI/SvGS9AM/asjfIyxCXf62jXLp4zxOkGWR75cmMYUUEfR8Qg6ftk0IIBJFTcdq
         JZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc;
        bh=i7/FEeJ1ep7vxqJYsfleU8cFQnhTtW8cVArotC9/5kU=;
        b=0c+F452sqUX+CyLhdtCNAblaobFGqdCl6BX9hlN4jcryIz/2uEXlI5wl2TyIl8Kw+P
         JqiOLa/M0WmNazMHeeU+u/tRB1rF3DZrQ1Bfj6sIc5drCuNoLp1tfLfz40XfRmOAlVvn
         iiO9lT/TQqAkdzmBFKQMwCub2lzd/p7hmZaj8mLARxjLC+MMIMiFa4LePPUw0UQptkQ2
         EakXEU8GhdHQyxEO1UV1piBB9ydgNxkqwLnB7k3Kdqq7hjmhcfn8p/BgTx7aqdcblD71
         0bgrbXNjbkLr6v+Urademlv/XtRAqk1G2PDeY0v1YunkeuGrCh/5Qnq4+4tDkS6C4e3Y
         7IhA==
X-Gm-Message-State: ACgBeo0QsuAom07VjnOWZppvASpkFw74WesTVweg+MA4z3PR61bdZtq8
        akD2GW1RusQ5U++uyGbBxvc=
X-Google-Smtp-Source: AA6agR5mU32X2SkA9LtnJD1vAvtNIPw1oZ8s5fPjCEjHngevQCEGu/pKps6hN23kgp9KDYKqjKzUgA==
X-Received: by 2002:a17:906:7304:b0:730:c3a8:cd7a with SMTP id di4-20020a170906730400b00730c3a8cd7amr9424539ejc.575.1660550676591;
        Mon, 15 Aug 2022 01:04:36 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id t14-20020aa7d4ce000000b004406f11ba7csm6175146edr.32.2022.08.15.01.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 01:04:36 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 15 Aug 2022 10:04:34 +0200
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
        Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
Message-ID: <Yvn+En35XDqKWptm@krava>
References: <CAADnVQ+hLnyztCi9aqpptjQk-P+ByAkyj2pjbdD45dsXwpZ0bw@mail.gmail.com>
 <20220722120854.3cc6ec4b@gandalf.local.home>
 <20220722122548.2db543ca@gandalf.local.home>
 <YtsRD1Po3qJy3w3t@krava>
 <20220722174120.688768a3@gandalf.local.home>
 <YtxqjxJVbw3RD4jt@krava>
 <YvbDlwJCTDWQ9uJj@krava>
 <20220813150252.5aa63650@rorschach.local.home>
 <YvkTLziHX4BINnla@krava>
 <77477710-c383-73b1-4f78-fe65a81c09b7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77477710-c383-73b1-4f78-fe65a81c09b7@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 10:07:54AM +0800, Chen Zhongjin wrote:
> 
> On 2022/8/14 23:22, Jiri Olsa wrote:
> > On Sat, Aug 13, 2022 at 03:02:52PM -0400, Steven Rostedt wrote:
> > > On Fri, 12 Aug 2022 23:18:15 +0200
> > > Jiri Olsa <olsajiri@gmail.com> wrote:
> > > 
> > > > the patch below moves the bpf function into sepatate object and switches
> > > > off the -mrecord-mcount for it.. so the function gets profile call
> > > > generated but it's not visible to ftrace
> > > > 
> > > > this seems to work, but it depends on -mrecord-mcount support in gcc and
> > > > it's x86 specific... other archs seems to use -fpatchable-function-entry,
> > > > which does not seem to have option to omit symbol from being collected
> > > > to the section
> > > As I stated. the __mcount_loc section was created by ftrace. It has
> > > nothing to do with -fpatchable-function-entry. It's just that the archs
> > > that use that, do not have a gcc that creates the __mcount_loc section.
> > > 
> > > > disabling specific ftrace symbol with FTRACE_FL_DISABLED flag seems to
> > > > be easir and generic solution.. I'll send RFC for that
> > > It's not easier.
> > > 
> > > Here, I have a POC for you and some more history.
> > > 
> > > The recordmcount.pl Perl script was the first to create the
> > > __mcount_loc section in all objects that ftrace needed to hook to. It
> > > did an objdump, found the locations of the calls to mcount, created
> > > another file that had a section __mcount_loc that referenced all those
> > > locations. Compiled and relinked that back into the original object.
> > > 
> > > This was performed on all object files during the build, and had an
> > > impact on build times. But this is when I also created and introduced
> > > "make localmodconfig", which shrunk the build times for many people, so
> > > nobody noticed the build time increase! :-)
> > > 
> > > Then John Reiser sent me a patch that created recordmcount.c that did
> > > the same work but directly modified the ELF object files without having
> > > to run scripts. This got rid of that horrible overhead from the scripts.
> > > 
> > > Then, the gcc folks decided to be helpful here as well and created the
> > > --mrecord-mcount option that would create the __mcount_loc section for
> > > us, where we no longer needed the recordmcount scripts/C program. But
> > > is not available across the board.
> > > 
> > > Today, objtool has also got involved, and added an "--mcount" option
> > > that will create the section too.
> > I overlooked that objtool is involved as well,
> > will check on that
> 
> objtool --mcount option only involves mcount_loc generation (see
> annotate_call_site) and other validation check call destination directly
> (see is_fentry_call).
> 
> Some simply removing --mcount option dose work for this.
> 
> 
> Another question, it seems we can export and use DEFINE_BPF_DISPATCHER out
> of kernel, does that means we should add NO_MCOUNT_FILES for these single
> uages as well?

yes, cc-ing Björn to make sure it's valid use case for dispatcher

jirka

> 
> I dont think it can be made automatically. If ignored, this can be a
> trouble.
> 
> 
> Best,
> 
> Chen
> 
> > > Below is a patch that extends yours by adding a NO_MCOUNT_FILES list,
> > > that you add the object file to and it will prevent the other methods
> > > from adding an mcount_loc location.
> > thanks,
> > jirka
> > 
> > > I'm adding the objtool folks to make sure this is fine with them.
> > > Again, this is a proof of concept, but works. It may need to be cleaned
> > > a bit before it is final.
> > > 
> > > -- Steve
> > > 
> > > Index: linux-trace.git/scripts/Makefile.build
> > > ===================================================================
> > > --- linux-trace.git.orig/scripts/Makefile.build
> > > +++ linux-trace.git/scripts/Makefile.build
> > > @@ -206,8 +206,10 @@ sub_cmd_record_mcount = perl $(srctree)/
> > >   	"$(if $(part-of-module),1,0)" "$(@)";
> > >   recordmcount_source := $(srctree)/scripts/recordmcount.pl
> > >   endif # BUILD_C_RECORDMCOUNT
> > > -cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),	\
> > > +chk_sub_cmd_record_mcount = $(if $(filter $(shell basename $@),$(NO_MCOUNT_FILES)),, \
> > >   	$(sub_cmd_record_mcount))
> > > +cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),	\
> > > +	$(chk_sub_cmd_record_mcount))
> > >   endif # CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
> > >   # 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
> > > Index: linux-trace.git/scripts/Makefile.lib
> > > ===================================================================
> > > --- linux-trace.git.orig/scripts/Makefile.lib
> > > +++ linux-trace.git/scripts/Makefile.lib
> > > @@ -233,7 +233,8 @@ objtool_args =								\
> > >   	$(if $(CONFIG_HAVE_JUMP_LABEL_HACK), --hacks=jump_label)	\
> > >   	$(if $(CONFIG_HAVE_NOINSTR_HACK), --hacks=noinstr)		\
> > >   	$(if $(CONFIG_X86_KERNEL_IBT), --ibt)				\
> > > -	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
> > > +	$(if $(filter $(shell basename $@),$(NO_MCOUNT_FILES)),,	\
> > > +		$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount))	\
> > >   	$(if $(CONFIG_UNWINDER_ORC), --orc)				\
> > >   	$(if $(CONFIG_RETPOLINE), --retpoline)				\
> > >   	$(if $(CONFIG_SLS), --sls)					\
> > > Index: linux-trace.git/net/core/Makefile
> > > ===================================================================
> > > --- linux-trace.git.orig/net/core/Makefile
> > > +++ linux-trace.git/net/core/Makefile
> > > @@ -11,10 +11,15 @@ obj-$(CONFIG_SYSCTL) += sysctl_net_core.
> > >   obj-y		     += dev.o dev_addr_lists.o dst.o netevent.o \
> > >   			neighbour.o rtnetlink.o utils.o link_watch.o filter.o \
> > >   			sock_diag.o dev_ioctl.o tso.o sock_reuseport.o \
> > > -			fib_notifier.o xdp.o flow_offload.o gro.o
> > > +			fib_notifier.o xdp.o flow_offload.o gro.o \
> > > +			dispatcher.o
> > >   obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
> > > +# remove dispatcher function from ftrace sight
> > > +CFLAGS_REMOVE_dispatcher.o = -mrecord-mcount
> > > +NO_MCOUNT_FILES += dispatcher.o
> > > +
> > >   obj-y += net-sysfs.o
> > >   obj-$(CONFIG_PAGE_POOL) += page_pool.o
> > >   obj-$(CONFIG_PROC_FS) += net-procfs.o
> > > Index: linux-trace.git/net/core/dispatcher.c
> > > ===================================================================
> > > --- /dev/null
> > > +++ linux-trace.git/net/core/dispatcher.c
> > > @@ -0,0 +1,3 @@
> > > +#include <linux/bpf.h>
> > > +
> > > +DEFINE_BPF_DISPATCHER(xdp)
> > > Index: linux-trace.git/net/core/filter.c
> > > ===================================================================
> > > --- linux-trace.git.orig/net/core/filter.c
> > > +++ linux-trace.git/net/core/filter.c
> > > @@ -11162,8 +11162,6 @@ const struct bpf_verifier_ops sk_lookup_
> > >   #endif /* CONFIG_INET */
> > > -DEFINE_BPF_DISPATCHER(xdp)
> > > -
> > >   void bpf_prog_change_xdp(struct bpf_prog *prev_prog, struct bpf_prog *prog)
> > >   {
> > >   	bpf_dispatcher_change_prog(BPF_DISPATCHER_PTR(xdp), prev_prog, prog);
> > > 
> 
