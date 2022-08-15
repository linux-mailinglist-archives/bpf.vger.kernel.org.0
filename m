Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9955927B0
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 04:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiHOCIC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 14 Aug 2022 22:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiHOCIC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 14 Aug 2022 22:08:02 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0034F12AB3;
        Sun, 14 Aug 2022 19:07:59 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M5czW25BTzkWN3;
        Mon, 15 Aug 2022 10:04:39 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 10:07:57 +0800
Received: from [127.0.0.1] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 15 Aug
 2022 10:07:56 +0800
Message-ID: <77477710-c383-73b1-4f78-fe65a81c09b7@huawei.com>
Date:   Mon, 15 Aug 2022 10:07:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
To:     Jiri Olsa <olsajiri@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "Stanislav Fomichev" <sdf@google.com>, Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>
References: <20220722110811.124515-1-jolsa@kernel.org>
 <20220722072608.17ef543f@rorschach.local.home>
 <CAADnVQ+hLnyztCi9aqpptjQk-P+ByAkyj2pjbdD45dsXwpZ0bw@mail.gmail.com>
 <20220722120854.3cc6ec4b@gandalf.local.home>
 <20220722122548.2db543ca@gandalf.local.home> <YtsRD1Po3qJy3w3t@krava>
 <20220722174120.688768a3@gandalf.local.home> <YtxqjxJVbw3RD4jt@krava>
 <YvbDlwJCTDWQ9uJj@krava> <20220813150252.5aa63650@rorschach.local.home>
 <YvkTLziHX4BINnla@krava>
Content-Language: en-US
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <YvkTLziHX4BINnla@krava>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 2022/8/14 23:22, Jiri Olsa wrote:
> On Sat, Aug 13, 2022 at 03:02:52PM -0400, Steven Rostedt wrote:
>> On Fri, 12 Aug 2022 23:18:15 +0200
>> Jiri Olsa <olsajiri@gmail.com> wrote:
>>
>>> the patch below moves the bpf function into sepatate object and switches
>>> off the -mrecord-mcount for it.. so the function gets profile call
>>> generated but it's not visible to ftrace
>>>
>>> this seems to work, but it depends on -mrecord-mcount support in gcc and
>>> it's x86 specific... other archs seems to use -fpatchable-function-entry,
>>> which does not seem to have option to omit symbol from being collected
>>> to the section
>> As I stated. the __mcount_loc section was created by ftrace. It has
>> nothing to do with -fpatchable-function-entry. It's just that the archs
>> that use that, do not have a gcc that creates the __mcount_loc section.
>>
>>> disabling specific ftrace symbol with FTRACE_FL_DISABLED flag seems to
>>> be easir and generic solution.. I'll send RFC for that
>> It's not easier.
>>
>> Here, I have a POC for you and some more history.
>>
>> The recordmcount.pl Perl script was the first to create the
>> __mcount_loc section in all objects that ftrace needed to hook to. It
>> did an objdump, found the locations of the calls to mcount, created
>> another file that had a section __mcount_loc that referenced all those
>> locations. Compiled and relinked that back into the original object.
>>
>> This was performed on all object files during the build, and had an
>> impact on build times. But this is when I also created and introduced
>> "make localmodconfig", which shrunk the build times for many people, so
>> nobody noticed the build time increase! :-)
>>
>> Then John Reiser sent me a patch that created recordmcount.c that did
>> the same work but directly modified the ELF object files without having
>> to run scripts. This got rid of that horrible overhead from the scripts.
>>
>> Then, the gcc folks decided to be helpful here as well and created the
>> --mrecord-mcount option that would create the __mcount_loc section for
>> us, where we no longer needed the recordmcount scripts/C program. But
>> is not available across the board.
>>
>> Today, objtool has also got involved, and added an "--mcount" option
>> that will create the section too.
> I overlooked that objtool is involved as well,
> will check on that

objtool --mcount option only involves mcount_loc generation (see 
annotate_call_site) and other validation check call destination directly 
(see is_fentry_call).

Some simply removing --mcount option dose work for this.


Another question, it seems we can export and use DEFINE_BPF_DISPATCHER 
out of kernel, does that means we should add NO_MCOUNT_FILES for these 
single uages as well?

I dont think it can be made automatically. If ignored, this can be a 
trouble.


Best,

Chen

>> Below is a patch that extends yours by adding a NO_MCOUNT_FILES list,
>> that you add the object file to and it will prevent the other methods
>> from adding an mcount_loc location.
> thanks,
> jirka
>
>> I'm adding the objtool folks to make sure this is fine with them.
>> Again, this is a proof of concept, but works. It may need to be cleaned
>> a bit before it is final.
>>
>> -- Steve
>>
>> Index: linux-trace.git/scripts/Makefile.build
>> ===================================================================
>> --- linux-trace.git.orig/scripts/Makefile.build
>> +++ linux-trace.git/scripts/Makefile.build
>> @@ -206,8 +206,10 @@ sub_cmd_record_mcount = perl $(srctree)/
>>   	"$(if $(part-of-module),1,0)" "$(@)";
>>   recordmcount_source := $(srctree)/scripts/recordmcount.pl
>>   endif # BUILD_C_RECORDMCOUNT
>> -cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),	\
>> +chk_sub_cmd_record_mcount = $(if $(filter $(shell basename $@),$(NO_MCOUNT_FILES)),, \
>>   	$(sub_cmd_record_mcount))
>> +cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),	\
>> +	$(chk_sub_cmd_record_mcount))
>>   endif # CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
>>   
>>   # 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
>> Index: linux-trace.git/scripts/Makefile.lib
>> ===================================================================
>> --- linux-trace.git.orig/scripts/Makefile.lib
>> +++ linux-trace.git/scripts/Makefile.lib
>> @@ -233,7 +233,8 @@ objtool_args =								\
>>   	$(if $(CONFIG_HAVE_JUMP_LABEL_HACK), --hacks=jump_label)	\
>>   	$(if $(CONFIG_HAVE_NOINSTR_HACK), --hacks=noinstr)		\
>>   	$(if $(CONFIG_X86_KERNEL_IBT), --ibt)				\
>> -	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
>> +	$(if $(filter $(shell basename $@),$(NO_MCOUNT_FILES)),,	\
>> +		$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount))	\
>>   	$(if $(CONFIG_UNWINDER_ORC), --orc)				\
>>   	$(if $(CONFIG_RETPOLINE), --retpoline)				\
>>   	$(if $(CONFIG_SLS), --sls)					\
>> Index: linux-trace.git/net/core/Makefile
>> ===================================================================
>> --- linux-trace.git.orig/net/core/Makefile
>> +++ linux-trace.git/net/core/Makefile
>> @@ -11,10 +11,15 @@ obj-$(CONFIG_SYSCTL) += sysctl_net_core.
>>   obj-y		     += dev.o dev_addr_lists.o dst.o netevent.o \
>>   			neighbour.o rtnetlink.o utils.o link_watch.o filter.o \
>>   			sock_diag.o dev_ioctl.o tso.o sock_reuseport.o \
>> -			fib_notifier.o xdp.o flow_offload.o gro.o
>> +			fib_notifier.o xdp.o flow_offload.o gro.o \
>> +			dispatcher.o
>>   
>>   obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
>>   
>> +# remove dispatcher function from ftrace sight
>> +CFLAGS_REMOVE_dispatcher.o = -mrecord-mcount
>> +NO_MCOUNT_FILES += dispatcher.o
>> +
>>   obj-y += net-sysfs.o
>>   obj-$(CONFIG_PAGE_POOL) += page_pool.o
>>   obj-$(CONFIG_PROC_FS) += net-procfs.o
>> Index: linux-trace.git/net/core/dispatcher.c
>> ===================================================================
>> --- /dev/null
>> +++ linux-trace.git/net/core/dispatcher.c
>> @@ -0,0 +1,3 @@
>> +#include <linux/bpf.h>
>> +
>> +DEFINE_BPF_DISPATCHER(xdp)
>> Index: linux-trace.git/net/core/filter.c
>> ===================================================================
>> --- linux-trace.git.orig/net/core/filter.c
>> +++ linux-trace.git/net/core/filter.c
>> @@ -11162,8 +11162,6 @@ const struct bpf_verifier_ops sk_lookup_
>>   
>>   #endif /* CONFIG_INET */
>>   
>> -DEFINE_BPF_DISPATCHER(xdp)
>> -
>>   void bpf_prog_change_xdp(struct bpf_prog *prev_prog, struct bpf_prog *prog)
>>   {
>>   	bpf_dispatcher_change_prog(BPF_DISPATCHER_PTR(xdp), prev_prog, prog);
>>

