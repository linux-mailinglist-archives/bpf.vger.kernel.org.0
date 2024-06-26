Return-Path: <bpf+bounces-33125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402319176EA
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 05:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F045C2830F6
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 03:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093C08003B;
	Wed, 26 Jun 2024 03:42:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CBF61FE8;
	Wed, 26 Jun 2024 03:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719373361; cv=none; b=bQvQukxUYcbWC2oZlSE6V0GpNeU78i7sJAlhUmw/xy7jsidBtqP0JauMC0NEBOarYIUUrSShmMJoLxu+cxe2bioR9+5LdNlk/0JGbO+ravHZ++wohkUYY1WszMG0v8VdIPtHU+JxmG282IobCX2b7+BNcSNE71ScvmYBqgTl8Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719373361; c=relaxed/simple;
	bh=+FIaDjWmQ96JE+HXz/QXYu8q64HDKNLZ9XuSCyIHnaE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=PeU21AsXQCWfoNJ9/KO4CTs61adu1N6QSWsdXTuELvKh5Bfmx37k7+GHYZQtoaMNTGrybCjYTmIP1E7PVyzKl5sYiTYNr5IJfom44yV99z1GUir6Y9Q+oOh231oY5yXi2Iu4Z6ScTUmAdLXnhFLkOGc3xnLvMchvEUN0N8swHeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W86tH4xtDzdcg5;
	Wed, 26 Jun 2024 11:40:55 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 6DEB814022E;
	Wed, 26 Jun 2024 11:42:29 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Wed, 26 Jun
 2024 11:42:28 +0800
Message-ID: <09f292b6-f251-412b-a79f-e242f3dced59@huawei.com>
Date: Wed, 26 Jun 2024 11:42:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] cgroup/cpuset: Prevent UAF in proc_cpuset_show()
From: chenridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>
CC: <bpf@vger.kernel.org>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
	<mkoutny@suse.com>
References: <20240626030500.460628-1-chenridong@huawei.com>
Content-Language: en-US
In-Reply-To: <20240626030500.460628-1-chenridong@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100013.china.huawei.com (7.221.188.163)

cc Michal Koutný

On 2024/6/26 11:05, Chen Ridong wrote:
> An UAF can happen when /proc/cpuset is read as reported in [1].
>
> This can be reproduced by the following methods:
> 1.add an mdelay(1000) before acquiring the cgroup_lock In the
>   cgroup_path_ns function.
> 2.$cat /proc/<pid>/cpuset   repeatly.
> 3.$mount -t cgroup -o cpuset cpuset /sys/fs/cgroup/cpuset/
> $umount /sys/fs/cgroup/cpuset/   repeatly.
>
> The race that cause this bug can be shown as below:
>
> (umount)		|	(cat /proc/<pid>/cpuset)
> css_release		|	proc_cpuset_show
> css_release_work_fn	|	css = task_get_css(tsk, cpuset_cgrp_id);
> css_free_rwork_fn	|	cgroup_path_ns(css->cgroup, ...);
> cgroup_destroy_root	|	mutex_lock(&cgroup_mutex);
> rebind_subsystems	|
> cgroup_free_root 	|
> 			|	// cgrp was freed, UAF
> 			|	cgroup_path_ns_locked(cgrp,..);
>
> When the cpuset is initialized, the root node top_cpuset.css.cgrp
> will point to &cgrp_dfl_root.cgrp. In cgroup v1, the mount operation will
> allocate cgroup_root, and top_cpuset.css.cgrp will point to the allocated
> &cgroup_root.cgrp. When the umount operation is executed,
> top_cpuset.css.cgrp will be rebound to &cgrp_dfl_root.cgrp.
>
> The problem is that when rebinding to cgrp_dfl_root, there are cases
> where the cgroup_root allocated by setting up the root for cgroup v1
> is cached. This could lead to a Use-After-Free (UAF) if it is
> subsequently freed. The descendant cgroups of cgroup v1 can only be
> freed after the css is released. However, the css of the root will never
> be released, yet the cgroup_root should be freed when it is unmounted.
> This means that obtaining a reference to the css of the root does
> not guarantee that css.cgrp->root will not be freed.
>
> Fix this problem by using rcu_read_lock in proc_cpuset_show().
> As cgroup root_list is already RCU-safe, css->cgroup is safe.
> This is similar to commit 9067d90006df ("cgroup: Eliminate the
> need for cgroup_mutex in proc_cgroup_show()")
>
> [1] https://syzkaller.appspot.com/bug?extid=9b1ff7be974a403aa4cd
>
> Fixes: a79a908fd2b0 ("cgroup: introduce cgroup namespaces")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   include/linux/cgroup.h |  3 +++
>   kernel/cgroup/cpuset.c | 11 +++++++++--
>   2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 2150ca60394b..bae7b54957fc 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -786,6 +786,9 @@ struct cgroup_namespace *copy_cgroup_ns(unsigned long flags,
>   int cgroup_path_ns(struct cgroup *cgrp, char *buf, size_t buflen,
>   		   struct cgroup_namespace *ns);
>   
> +int cgroup_path_ns_locked(struct cgroup *cgrp, char *buf, size_t buflen,
> +			  struct cgroup_namespace *ns);
> +
>   #else /* !CONFIG_CGROUPS */
>   
>   static inline void free_cgroup_ns(struct cgroup_namespace *ns) { }
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index c12b9fdb22a4..e57762f613d6 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -5052,8 +5052,15 @@ int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
>   		goto out;
>   
>   	css = task_get_css(tsk, cpuset_cgrp_id);
> -	retval = cgroup_path_ns(css->cgroup, buf, PATH_MAX,
> -				current->nsproxy->cgroup_ns);
> +	rcu_read_lock();
> +	spin_lock_irq(&css_set_lock);
> +	/* In case the root has already been unmounted. */
> +	if (css->cgroup)
> +		retval = cgroup_path_ns_locked(css->cgroup, buf, PATH_MAX,
> +			current->nsproxy->cgroup_ns);
> +
> +	spin_unlock_irq(&css_set_lock);
> +	rcu_read_unlock();
>   	css_put(css);
>   	if (retval == -E2BIG)
>   		retval = -ENAMETOOLONG;

