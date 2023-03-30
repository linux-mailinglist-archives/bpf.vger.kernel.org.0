Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484AC6D04A3
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 14:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjC3M0s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 08:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC3M0q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 08:26:46 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE695FB
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 05:26:44 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PnMyj5WWJz17QW7;
        Thu, 30 Mar 2023 20:23:25 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 20:26:42 +0800
Subject: Re: [PATCH bpf-next v6 1/2] bpf: Fix attaching
 fentry/fexit/fmod_ret/lsm to modules
To:     Jiri Olsa <olsajiri@gmail.com>, Petr Mladek <pmladek@suse.com>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
References: <cover.1676542796.git.vmalik@redhat.com>
 <e627742ab86ed28632bc9b6c56ef65d7f98eadbc.1676542796.git.vmalik@redhat.com>
 <Y+40os27pQ8det/o@krava> <1992d09a-0ef8-66e3-1da0-5d13c2fecc3d@redhat.com>
 <Y+5Q0UK09HsxM4ht@krava> <ZBrPMkv8YVRiWwCR@samus.usersys.redhat.com>
 <ZBrxMWfmE/1RG/u0@krava>
 <CAADnVQLwvZyQXyRNn_oaBKx-EH_NauZHTg8+-MOMXo91MibX=A@mail.gmail.com>
 <ZBxbeYZ/+tOtEiNB@krava> <ZCU6dPDXZ0h7hT4w@krava>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <98077109-02be-a708-cde7-5dc827e1f3ea@huawei.com>
Date:   Thu, 30 Mar 2023 20:26:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZCU6dPDXZ0h7hT4w@krava>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2023/3/30 15:29, Jiri Olsa wrote:
> ping,
> 
> Petr, Zhen, any comment on discussion below?
> 
> thanks,
> jirka
> 
> On Thu, Mar 23, 2023 at 03:00:25PM +0100, Jiri Olsa wrote:
>> On Wed, Mar 22, 2023 at 09:03:46AM -0700, Alexei Starovoitov wrote:
>>> On Wed, Mar 22, 2023 at 5:14 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>>>>
>>>> On Wed, Mar 22, 2023 at 10:49:38AM +0100, Artem Savkov wrote:
>>>>
>>>> SNIP
>>>>
>>>>>>> Hm, do we even need to preempt_disable? IIUC, preempt_disable is used
>>>>>>> in module kallsyms to prevent taking the module lock b/c kallsyms are
>>>>>>> used in the oops path. That shouldn't be an issue here, is that correct?
>>>>>>
>>>>>> btf_try_get_module calls try_module_get which disables the preemption,
>>>>>> so no need to call it in here
>>>>>
>>>>> It does, but it reenables preemption right away so it is enabled by the
>>>>> time we call find_kallsyms_symbol_value(). I am getting the following
>>>>> lockdep splat while running module_fentry_shadow test from test_progs.
>>>>>
>>>>> [   12.017973][  T488] =============================
>>>>> [   12.018529][  T488] WARNING: suspicious RCU usage
>>>>> [   12.018987][  T488] 6.2.0.bpf-test-13063-g6a9f5cdba3c5 #804 Tainted: G           OE
>>>>> [   12.019898][  T488] -----------------------------
>>>>> [   12.020391][  T488] kernel/module/kallsyms.c:448 suspicious rcu_dereference_check() usage!
>>>>> [   12.021335][  T488]
>>>>> [   12.021335][  T488] other info that might help us debug this:
>>>>> [   12.021335][  T488]
>>>>> [   12.022416][  T488]
>>>>> [   12.022416][  T488] rcu_scheduler_active = 2, debug_locks = 1
>>>>> [   12.023297][  T488] no locks held by test_progs/488.
>>>>> [   12.023854][  T488]
>>>>> [   12.023854][  T488] stack backtrace:
>>>>> [   12.024336][  T488] CPU: 0 PID: 488 Comm: test_progs Tainted: G           OE      6.2.0.bpf-test-13063-g6a9f5cdba3c5 #804
>>>>> [   12.025290][  T488] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.1-2.fc37 04/01/2014
>>>>> [   12.026108][  T488] Call Trace:
>>>>> [   12.026381][  T488]  <TASK>
>>>>> [   12.026649][  T488]  dump_stack_lvl+0xb4/0x110
>>>>> [   12.027060][  T488]  lockdep_rcu_suspicious+0x158/0x1f0
>>>>> [   12.027541][  T488]  find_kallsyms_symbol_value+0xe8/0x110
>>>>> [   12.028028][  T488]  bpf_check_attach_target+0x838/0xa20
>>>>> [   12.028511][  T488]  check_attach_btf_id+0x144/0x3f0
>>>>> [   12.028957][  T488]  ? __pfx_cmp_subprogs+0x10/0x10
>>>>> [   12.029408][  T488]  bpf_check+0xeec/0x1850
>>>>> [   12.029799][  T488]  ? ktime_get_with_offset+0x124/0x1d0
>>>>> [   12.030247][  T488]  bpf_prog_load+0x87a/0xed0
>>>>> [   12.030627][  T488]  ? __lock_release+0x5f/0x160
>>>>> [   12.031010][  T488]  ? __might_fault+0x53/0xb0
>>>>> [   12.031394][  T488]  ? selinux_bpf+0x6c/0xa0
>>>>> [   12.031756][  T488]  __sys_bpf+0x53c/0x1240
>>>>> [   12.032115][  T488]  __x64_sys_bpf+0x27/0x40
>>>>> [   12.032476][  T488]  do_syscall_64+0x3e/0x90
>>>>> [   12.032835][  T488]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>>>>
>>>>
>>>> hum, for some reason I can't reproduce, but looks like we need to disable
>>>> preemption for find_kallsyms_symbol_value.. could you please check with
>>>> patch below?
>>>>
>>>> also could you please share your .config? not sure why I can't reproduce
>>>>
>>>> thanks,
>>>> jirka
>>>>
>>>>
>>>> ---
>>>> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
>>>> index ab2376a1be88..bdc911dbcde5 100644
>>>> --- a/kernel/module/kallsyms.c
>>>> +++ b/kernel/module/kallsyms.c
>>>> @@ -442,7 +442,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
>>>>  }
>>>>
>>>>  /* Given a module and name of symbol, find and return the symbol's value */
>>>> -unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name)
>>>> +static unsigned long __find_kallsyms_symbol_value(struct module *mod, const char *name)
>>>>  {
>>>>         unsigned int i;
>>>>         struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
>>>> @@ -466,7 +466,7 @@ static unsigned long __module_kallsyms_lookup_name(const char *name)
>>>>         if (colon) {
>>>>                 mod = find_module_all(name, colon - name, false);
>>>>                 if (mod)
>>>> -                       return find_kallsyms_symbol_value(mod, colon + 1);
>>>> +                       return __find_kallsyms_symbol_value(mod, colon + 1);
>>>>                 return 0;
>>>>         }
>>>>
>>>> @@ -475,7 +475,7 @@ static unsigned long __module_kallsyms_lookup_name(const char *name)
>>>>
>>>>                 if (mod->state == MODULE_STATE_UNFORMED)
>>>>                         continue;
>>>> -               ret = find_kallsyms_symbol_value(mod, name);
>>>> +               ret = __find_kallsyms_symbol_value(mod, name);
>>>>                 if (ret)
>>>>                         return ret;
>>>>         }
>>>> @@ -494,6 +494,16 @@ unsigned long module_kallsyms_lookup_name(const char *name)
>>>>         return ret;
>>>>  }
>>>>
>>>> +unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name)
>>>> +{
>>>> +       unsigned long ret;
>>>> +
>>>> +       preempt_disable();
>>>> +       ret = __find_kallsyms_symbol_value(mod, name);
>>>> +       preempt_enable();
>>>> +       return ret;
>>>> +}
>>>
>>> That doesn't look right.
>>> I think the issue is misuse of rcu_dereference_sched in
>>> find_kallsyms_symbol_value.
>>
>> it seems to be using rcu pointer to keep symbols for module init time and
>> then core symbols for after init.. and switch between them when module is
>> loaded, hence the strange rcu usage I think
>>
>> Petr, Zhen, any idea/insight?

Commit 91fb02f31505 ("module: Move kallsyms support into a separate file") hides
the answer. find_kallsyms_symbol_value() was originally a static function, and it
is only called by module_kallsyms_lookup_name() and is preemptive-protected.

Now that we've added a call to function find_kallsyms_symbol_value(), it seems like
we should do the same thing as function module_kallsyms_lookup_name().

Like this?
+				mod = btf_try_get_module(btf);
+				if (mod) {
+					preempt_disable();
+					addr = find_kallsyms_symbol_value(mod, tname);
+					preempt_enable();
+				} else
+					addr = 0;


>>
>> thanks,
>> jirka
> .
> 

-- 
Regards,
  Zhen Lei
