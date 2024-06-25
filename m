Return-Path: <bpf+bounces-33006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDEE915D29
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 05:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364E128307D
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 03:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51970481DD;
	Tue, 25 Jun 2024 03:12:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4803D6B;
	Tue, 25 Jun 2024 03:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719285177; cv=none; b=rFouKr+VHAidqmbWFW865WXRgq1xHlO+E4NBtbzED1M1SaiWwhSkG6OmBOHDjREUqw2mIzr8w7J2suBuPoBDvVJ4AFUPgTu5aJvSBXOpQvSqeOhMbo4rZSd9JXUg9xbkQ+yiIF/xESuFOlVUD6rCrX6MopP+/i3SzPs44jh5Ulc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719285177; c=relaxed/simple;
	bh=5GSxJ2fhHvwJOerdIQO0/q/cWtl2sjH55RB3enR5lbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MBnVQ1Rq9rf2xl6w9x8YR/A+xO3DDZLn/l73a7Ij1jLeuQfgFirXF23FoCt2rE8Wk8/aWXS3BDFAloNh6PPLjL7wRcRNdwPCOLZ4JM/D/yjrIWRsJGG5yJuksxGACa3yu7WAoKdjvQDsS6gfB9K+MuLgAHO6gT29PxSIj2TTnH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4W7VCC224dz1SDlT;
	Tue, 25 Jun 2024 11:08:23 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F791180085;
	Tue, 25 Jun 2024 11:12:30 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 25 Jun
 2024 11:12:21 +0800
Message-ID: <3322ce46-78a1-45c5-ad07-a982dec21c8e@huawei.com>
Date: Tue, 25 Jun 2024 11:12:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup: fix uaf when proc_cpuset_show
To: Waiman Long <longman@redhat.com>, <tj@kernel.org>,
	<lizefan.x@bytedance.com>, <hannes@cmpxchg.org>
CC: <bpf@vger.kernel.org>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240622113814.120907-1-chenridong@huawei.com>
 <19648b9c-6df7-45cd-a5ae-624a3e4d860f@redhat.com>
 <52f72d1d-602e-4dca-85a3-adade925b056@huawei.com>
 <71a9cc3a-1b58-4051-984b-dd4f18dabf84@redhat.com>
 <8f83ecb3-4afa-4e0b-be37-35b168eb3c7c@huawei.com>
 <ee30843f-2579-4dcf-9688-6541fd892678@redhat.com>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <ee30843f-2579-4dcf-9688-6541fd892678@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100013.china.huawei.com (7.221.188.163)


On 2024/6/25 10:40, Waiman Long wrote:
> On 6/24/24 21:46, chenridong wrote:
>>
>> On 2024/6/25 7:59, Waiman Long wrote:
>>> On 6/23/24 22:59, chenridong wrote:
>>>>
>>>> On 2024/6/22 23:05, Waiman Long wrote:
>>>>>
>>>>> On 6/22/24 07:38, Chen Ridong wrote:
>>>>>> We found a refcount UAF bug as follows:
>>>>>>
>>>>>> BUG: KASAN: use-after-free in cgroup_path_ns+0x112/0x150
>>>>>> Read of size 8 at addr ffff8882a4b242b8 by task atop/19903
>>>>>>
>>>>>> CPU: 27 PID: 19903 Comm: atop Kdump: loaded Tainted: GF
>>>>>> Call Trace:
>>>>>>   dump_stack+0x7d/0xa7
>>>>>>   print_address_description.constprop.0+0x19/0x170
>>>>>>   ? cgroup_path_ns+0x112/0x150
>>>>>>   __kasan_report.cold+0x6c/0x84
>>>>>>   ? print_unreferenced+0x390/0x3b0
>>>>>>   ? cgroup_path_ns+0x112/0x150
>>>>>>   kasan_report+0x3a/0x50
>>>>>>   cgroup_path_ns+0x112/0x150
>>>>>>   proc_cpuset_show+0x164/0x530
>>>>>>   proc_single_show+0x10f/0x1c0
>>>>>>   seq_read_iter+0x405/0x1020
>>>>>>   ? aa_path_link+0x2e0/0x2e0
>>>>>>   seq_read+0x324/0x500
>>>>>>   ? seq_read_iter+0x1020/0x1020
>>>>>>   ? common_file_perm+0x2a1/0x4a0
>>>>>>   ? fsnotify_unmount_inodes+0x380/0x380
>>>>>>   ? bpf_lsm_file_permission_wrapper+0xa/0x30
>>>>>>   ? security_file_permission+0x53/0x460
>>>>>>   vfs_read+0x122/0x420
>>>>>>   ksys_read+0xed/0x1c0
>>>>>>   ? __ia32_sys_pwrite64+0x1e0/0x1e0
>>>>>>   ? __audit_syscall_exit+0x741/0xa70
>>>>>>   do_syscall_64+0x33/0x40
>>>>>>   entry_SYSCALL_64_after_hwframe+0x67/0xcc
>>>>>>
>>>>>> This is also reported by: 
>>>>>> https://syzkaller.appspot.com/bug?extid=9b1ff7be974a403aa4cd
>>>>>>
>>>>>> This can be reproduced by the following methods:
>>>>>> 1.add an mdelay(1000) before acquiring the cgroup_lock In the
>>>>>>   cgroup_path_ns function.
>>>>>> 2.$cat /proc/<pid>/cpuset   repeatly.
>>>>>> 3.$mount -t cgroup -o cpuset cpuset /sys/fs/cgroup/cpuset/
>>>>>> $umount /sys/fs/cgroup/cpuset/   repeatly.
>>>>>>
>>>>>> The race that cause this bug can be shown as below:
>>>>>>
>>>>>> (umount)        |    (cat /proc/<pid>/cpuset)
>>>>>> css_release        |    proc_cpuset_show
>>>>>> css_release_work_fn    |    css = task_get_css(tsk, cpuset_cgrp_id);
>>>>>> css_free_rwork_fn    |    cgroup_path_ns(css->cgroup, ...);
>>>>>> cgroup_destroy_root    | mutex_lock(&cgroup_mutex);
>>>>>> rebind_subsystems    |
>>>>>> cgroup_free_root     |
>>>>>>             |    // cgrp was freed, UAF
>>>>>>             |    cgroup_path_ns_locked(cgrp,..);
>>>>>>
>>>>>> When the cpuset is initialized, the root node top_cpuset.css.cgrp
>>>>>> will point to &cgrp_dfl_root.cgrp. In cgroup v1, the mount 
>>>>>> operation will
>>>>>> allocate cgroup_root, and top_cpuset.css.cgrp will point to the 
>>>>>> allocated
>>>>>> &cgroup_root.cgrp. When the umount operation is executed,
>>>>>> top_cpuset.css.cgrp will be rebound to &cgrp_dfl_root.cgrp.
>>>>>>
>>>>>> The problem is that when rebinding to cgrp_dfl_root, there are cases
>>>>>> where the cgroup_root allocated by setting up the root for cgroup v1
>>>>>> is cached. This could lead to a Use-After-Free (UAF) if it is
>>>>>> subsequently freed. The descendant cgroups of cgroup v1 can only be
>>>>>> freed after the css is released. However, the css of the root 
>>>>>> will never
>>>>>> be released, yet the cgroup_root should be freed when it is 
>>>>>> unmounted.
>>>>>> This means that obtaining a reference to the css of the root does
>>>>>> not guarantee that css.cgrp->root will not be freed.
>>>>>>
>>>>>> To solve this issue, we have added a cgroup reference count in
>>>>>> the proc_cpuset_show function to ensure that css.cgrp->root will not
>>>>>> be freed prematurely. This is a temporary solution. Let's see if 
>>>>>> anyone
>>>>>> has a better solution.
>>>>>>
>>>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>>>> ---
>>>>>>   kernel/cgroup/cpuset.c | 20 ++++++++++++++++++++
>>>>>>   1 file changed, 20 insertions(+)
>>>>>>
>>>>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>>>>> index c12b9fdb22a4..782eaf807173 100644
>>>>>> --- a/kernel/cgroup/cpuset.c
>>>>>> +++ b/kernel/cgroup/cpuset.c
>>>>>> @@ -5045,6 +5045,7 @@ int proc_cpuset_show(struct seq_file *m, 
>>>>>> struct pid_namespace *ns,
>>>>>>       char *buf;
>>>>>>       struct cgroup_subsys_state *css;
>>>>>>       int retval;
>>>>>> +    struct cgroup *root_cgroup = NULL;
>>>>>>         retval = -ENOMEM;
>>>>>>       buf = kmalloc(PATH_MAX, GFP_KERNEL);
>>>>>> @@ -5052,9 +5053,28 @@ int proc_cpuset_show(struct seq_file *m, 
>>>>>> struct pid_namespace *ns,
>>>>>>           goto out;
>>>>>>         css = task_get_css(tsk, cpuset_cgrp_id);
>>>>>> +    rcu_read_lock();
>>>>>> +    /*
>>>>>> +     * When the cpuset subsystem is mounted on the legacy 
>>>>>> hierarchy,
>>>>>> +     * the top_cpuset.css->cgroup does not hold a reference 
>>>>>> count of
>>>>>> +     * cgroup_root.cgroup. This makes accessing css->cgroup very
>>>>>> +     * dangerous because when the cpuset subsystem is remounted 
>>>>>> to the
>>>>>> +     * default hierarchy, the cgroup_root.cgroup that 
>>>>>> css->cgroup points
>>>>>> +     * to will be released, leading to a UAF issue. To avoid 
>>>>>> this problem,
>>>>>> +     * get the reference count of top_cpuset.css->cgroup first.
>>>>>> +     *
>>>>>> +     * This is ugly!!
>>>>>> +     */
>>>>>> +    if (css == &top_cpuset.css) {
>>>>>> +        cgroup_get(css->cgroup);
>>>>>> +        root_cgroup = css->cgroup;
>>>>>> +    }
>>>>>> +    rcu_read_unlock();
>>>>>>       retval = cgroup_path_ns(css->cgroup, buf, PATH_MAX,
>>>>>>                   current->nsproxy->cgroup_ns);
>>>>>>       css_put(css);
>>>>>> +    if (root_cgroup)
>>>>>> +        cgroup_put(root_cgroup);
>>>>>>       if (retval == -E2BIG)
>>>>>>           retval = -ENAMETOOLONG;
>>>>>>       if (retval < 0)
>>>>>
>>>>> Thanks for reporting this UAF bug. Could you try the attached 
>>>>> patch to see if it can fix the issue?
>>>>>
>>>>
>>>> +/*
>>>> + * With a cgroup v1 mount, root_css.cgroup can be freed. We need 
>>>> to take a
>>>> + * reference to it to avoid UAF as proc_cpuset_show() may access 
>>>> the content
>>>> + * of this cgroup.
>>>> + */
>>>>  static void cpuset_bind(struct cgroup_subsys_state *root_css)
>>>>  {
>>>> +    static struct cgroup *v1_cgroup_root;
>>>> +
>>>>      mutex_lock(&cpuset_mutex);
>>>> +    if (v1_cgroup_root) {
>>>> +        cgroup_put(v1_cgroup_root);
>>>> +        v1_cgroup_root = NULL;
>>>> +    }
>>>>      spin_lock_irq(&callback_lock);
>>>>
>>>>      if (is_in_v2_mode()) {
>>>> @@ -4159,6 +4170,10 @@ static void cpuset_bind(struct 
>>>> cgroup_subsys_state *root_css)
>>>>      }
>>>>
>>>>      spin_unlock_irq(&callback_lock);
>>>> +    if (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys)) {
>>>> +        v1_cgroup_root = root_css->cgroup;
>>>> +        cgroup_get(v1_cgroup_root);
>>>> +    }
>>>>      mutex_unlock(&cpuset_mutex);
>>>>  }
>>>>
>>>> Thanks for your suggestion. If we take a reference at rebind(call 
>>>> ->bind()) function, cgroup_root allocated when setting up root for 
>>>> cgroup v1 can never be released, because the reference count will 
>>>> never be reduced to zero.
>>>>
>>>> We have already tried similar methods to fix this issue, however 
>>>> doing so causes another issue as mentioned previously.
>>>
>>> You are right. Taking the reference in cpuset_bind() will prevent 
>>> cgroup_destroy_root() from being called. I had overlooked that.
>>>
>>> Now I have an even simpler fix. Could you try the attached v2 patch 
>>> to verify if that can fix the problem?
>>>
>>> Thanks,
>>> Longman
>>
>> Thanks you for your reply, v2 patch will lead to  ABBA deadlock.
>>
>> (cat /proc/<pid>/cpuset)                  | (rebind_subsystems)
>>                                                           | 
>> lockdep_assert_held(&cgroup_mutex);
>> mutex_lock(&cpuset_mutex);            |
>> cgroup_path_ns                                 |    ->bind()
>>                                                           | 
>> mutex_lock(&cpuset_mutex);
>> mutex_lock(&cgroup_mutex);           |
>
> Bummer.
>
> Another alternative is to create a cgroup_path_ns() variant that 
> accepts a "struct cgroup **pcgrp" and retrieve the actual cgroup 
> pointer inside its critical section. That should also fix the UAF.
>
> Cheers,
> Longman
>
>
I am considering whether the cgroup framework has a method to fix this 
issue, as other subsystems may also have the same underlying problem. 
Since the root css will not be released, but the css->cgrp will be released.

Regards,
Ridong


