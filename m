Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019146D1EBF
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 13:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjCaLJa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 07:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjCaLJP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 07:09:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFE5CC17
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 04:08:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CCD5821A44;
        Fri, 31 Mar 2023 11:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680260925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vx28B+MBqx8hz8Vl0H5mUq2bRFq+wd/0gcUHWbsXg5s=;
        b=V/B2UH7vxV5frrLkNAFIUvhu7xJ8DFnfJpGaHrwxNghENKX1NVVegZk5hdJyxaQuCSyVVb
        /hqmooDGVQP1N0N+nmz7rzlEYZ5vTcWCBhiZxx7t4i5agOOYs/8eBGzFh3DL/bzl8xfB04
        EktEXZ+PNSUXUW/+haQiBH/HyARCJfE=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4A3D02C141;
        Fri, 31 Mar 2023 11:08:45 +0000 (UTC)
Date:   Fri, 31 Mar 2023 13:08:42 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Viktor Malik <vmalik@redhat.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH bpf-next v6 1/2] bpf: Fix attaching
 fentry/fexit/fmod_ret/lsm to modules
Message-ID: <ZCa/OgipCAqQmHhF@alley>
References: <Y+5Q0UK09HsxM4ht@krava>
 <ZBrPMkv8YVRiWwCR@samus.usersys.redhat.com>
 <ZBrxMWfmE/1RG/u0@krava>
 <CAADnVQLwvZyQXyRNn_oaBKx-EH_NauZHTg8+-MOMXo91MibX=A@mail.gmail.com>
 <ZBxbeYZ/+tOtEiNB@krava>
 <ZCU6dPDXZ0h7hT4w@krava>
 <98077109-02be-a708-cde7-5dc827e1f3ea@huawei.com>
 <ZCX4IMGp/aalXHSL@krava>
 <ZCaaWgmooVh2M/EC@alley>
 <7b396cbb-f977-0fa0-f5a9-0b16cef418b9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b396cbb-f977-0fa0-f5a9-0b16cef418b9@huawei.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri 2023-03-31 17:15:56, Leizhen (ThunderTown) wrote:
> 
> 
> On 2023/3/31 16:31, Petr Mladek wrote:
> > On Thu 2023-03-30 22:59:12, Jiri Olsa wrote:
> >> On Thu, Mar 30, 2023 at 08:26:41PM +0800, Leizhen (ThunderTown) wrote:
> >>>
> >>>
> >>> On 2023/3/30 15:29, Jiri Olsa wrote:
> >>>> ping,
> >>>>
> >>>> Petr, Zhen, any comment on discussion below?
> >>>>
> >>>> thanks,
> >>>> jirka
> >>>>
> >>>> On Thu, Mar 23, 2023 at 03:00:25PM +0100, Jiri Olsa wrote:
> >>>>> On Wed, Mar 22, 2023 at 09:03:46AM -0700, Alexei Starovoitov wrote:
> >>>>>> On Wed, Mar 22, 2023 at 5:14 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >>>>>>>
> >>>>>>> On Wed, Mar 22, 2023 at 10:49:38AM +0100, Artem Savkov wrote:
> >>>>>>>
> >>>>>>> SNIP
> >>>>>>>
> >>>>>>>>>> Hm, do we even need to preempt_disable? IIUC, preempt_disable is used
> >>>>>>>>>> in module kallsyms to prevent taking the module lock b/c kallsyms are
> >>>>>>>>>> used in the oops path. That shouldn't be an issue here, is that correct?
> >>>>>>>>>
> >>>>>>>>> btf_try_get_module calls try_module_get which disables the preemption,
> >>>>>>>>> so no need to call it in here
> >>>>>>>>
> >>>>>>>> It does, but it reenables preemption right away so it is enabled by the
> >>>>>>>> time we call find_kallsyms_symbol_value(). I am getting the following
> >>>>>>>> lockdep splat while running module_fentry_shadow test from test_progs.
> >>>>>>>>
> >>>>>>>> [   12.017973][  T488] =============================
> >>>>>>>> [   12.018529][  T488] WARNING: suspicious RCU usage
> >>>>>>>> [   12.018987][  T488] 6.2.0.bpf-test-13063-g6a9f5cdba3c5 #804 Tainted: G           OE
> >>>>>>>> [   12.019898][  T488] -----------------------------
> >>>>>>>> [   12.020391][  T488] kernel/module/kallsyms.c:448 suspicious rcu_dereference_check() usage!
> >>>>>>>> [   12.021335][  T488]
> >>>>>>>> [   12.021335][  T488] other info that might help us debug this:
> >>>>>>>> [   12.021335][  T488]
> >>>>>>>> [   12.022416][  T488]
> >>>>>>>> [   12.022416][  T488] rcu_scheduler_active = 2, debug_locks = 1
> >>>>>>>> [   12.023297][  T488] no locks held by test_progs/488.
> >>>>>>>> [   12.023854][  T488]
> >>>>>>>> [   12.023854][  T488] stack backtrace:
> >>>>>>>> [   12.024336][  T488] CPU: 0 PID: 488 Comm: test_progs Tainted: G           OE      6.2.0.bpf-test-13063-g6a9f5cdba3c5 #804
> >>>>>>>> [   12.025290][  T488] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.1-2.fc37 04/01/2014
> >>>>>>>> [   12.026108][  T488] Call Trace:
> >>>>>>>> [   12.026381][  T488]  <TASK>
> >>>>>>>> [   12.026649][  T488]  dump_stack_lvl+0xb4/0x110
> >>>>>>>> [   12.027060][  T488]  lockdep_rcu_suspicious+0x158/0x1f0
> >>>>>>>> [   12.027541][  T488]  find_kallsyms_symbol_value+0xe8/0x110
> >>>>>>>> [   12.028028][  T488]  bpf_check_attach_target+0x838/0xa20
> >>>>>>>> [   12.028511][  T488]  check_attach_btf_id+0x144/0x3f0
> >>>>>>>> [   12.028957][  T488]  ? __pfx_cmp_subprogs+0x10/0x10
> >>>>>>>> [   12.029408][  T488]  bpf_check+0xeec/0x1850
> >>>>>>>> [   12.029799][  T488]  ? ktime_get_with_offset+0x124/0x1d0
> >>>>>>>> [   12.030247][  T488]  bpf_prog_load+0x87a/0xed0
> >>>>>>>> [   12.030627][  T488]  ? __lock_release+0x5f/0x160
> >>>>>>>> [   12.031010][  T488]  ? __might_fault+0x53/0xb0
> >>>>>>>> [   12.031394][  T488]  ? selinux_bpf+0x6c/0xa0
> >>>>>>>> [   12.031756][  T488]  __sys_bpf+0x53c/0x1240
> >>>>>>>> [   12.032115][  T488]  __x64_sys_bpf+0x27/0x40
> >>>>>>>> [   12.032476][  T488]  do_syscall_64+0x3e/0x90
> >>>>>>>> [   12.032835][  T488]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> >>>>>>>
> >>>>>>> --- a/kernel/module/kallsyms.c
> >>>>>>> +++ b/kernel/module/kallsyms.c
> >>> Commit 91fb02f31505 ("module: Move kallsyms support into a separate file") hides
> >>> the answer. find_kallsyms_symbol_value() was originally a static function, and it
> >>> is only called by module_kallsyms_lookup_name() and is preemptive-protected.
> >>>
> >>> Now that we've added a call to function find_kallsyms_symbol_value(), it seems like
> >>> we should do the same thing as function module_kallsyms_lookup_name().
> >>>
> >>> Like this?
> >>> +				mod = btf_try_get_module(btf);
> >>> +				if (mod) {
> >>> +					preempt_disable();
> >>> +					addr = find_kallsyms_symbol_value(mod, tname);
> >>> +					preempt_enable();
> >>> +				} else
> >>> +					addr = 0;
> >>
> >> yes, that's what I did above, but I was just curious about the strange
> >> RCU usage Alexei commented on earlier:
> >>
> >> 	>>> +unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name)
> >> 	>>> +{
> >> 	>>> +       unsigned long ret;
> >> 	>>> +
> >> 	>>> +       preempt_disable();
> >> 	>>> +       ret = __find_kallsyms_symbol_value(mod, name);
> >> 	>>> +       preempt_enable();
> >> 	>>> +       return ret;
> >> 	>>> +}
> >> 	>>
> >> 	>> That doesn't look right.
> >> 	>> I think the issue is misuse of rcu_dereference_sched in
> >> 	>> find_kallsyms_symbol_value.
> >> 	>
> >> 	> it seems to be using rcu pointer to keep symbols for module init time and
> >> 	> then core symbols for after init.. and switch between them when module is
> >> 	> loaded, hence the strange rcu usage I think
> 
> load_module
> 	post_relocation
> 		add_kallsyms
> 			mod->kallsyms = (void __rcu *)mod->init_layout.base + info->mod_kallsyms_init_off;   (1)
> 	do_init_module
> 		freeinit->module_init = mod->init_layout.base;
> 		rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);                                      (2)
> 		if (llist_add(&freeinit->node, &init_free_list))
> 			schedule_work(&init_free_wq);
> 
> do_free_init
> 	synchronize_rcu();
> 	module_memfree(initfree->module_init);
> 
> IIUC, the RCU can help synchronize_rcu() in do_free_init() to make sure that no one
> is still using the first mod->kallsyms (1). If find_kallsyms_symbol_value() is executed
> between (1) and (2).

Yes, this seems to be another scenario where the RCU synchronization/access
is needed.

Best Regards,
Petr
