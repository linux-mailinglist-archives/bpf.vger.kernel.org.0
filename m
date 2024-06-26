Return-Path: <bpf+bounces-33124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 703489176B5
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 05:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA131F22C50
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 03:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECD66FE07;
	Wed, 26 Jun 2024 03:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQ+PvRvl"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A18282FD
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 03:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719371836; cv=none; b=Cx5IMZLLkzxZxcYuZtV2J3QXex7mCknMKMMqTKf+Z/e3mThL03818QgMxSIto7iGckYAAFV3p6k1dl53e7iSfsOmR0Q+NAeHvATjc3U0sebk+24PX5Z+8jz93Mciki3JtcRW/6ZQ7LK247TEhn9HyBJWaa0bXyBm4EmmReJXeAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719371836; c=relaxed/simple;
	bh=9Hkq76X6FR5owdV5TMxF4xB0lDQkeuqE9LyiTtQcX7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mnkc3oVBxgJbJU08CeskGhl2dfl1K5uxLKeTxvjE8RSYqcsBF/guySEtVpNGP4G74i/XsYI3DXApF7FQM5hd17Ijb1i4hO9Do9biMhfro8tcC0jB1KpONuQNMxGNb4T1sjzo7250zFrOa8fEUoOKN7xxVJuk6RaOhC5VR8twBAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LQ+PvRvl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719371832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WtbKP8qBjyp+rTAYYW6k+Y4FwkskGh9tpkCTDr9SfMM=;
	b=LQ+PvRvl8iOq3jO6Lg3j5NYK69qyFsAOFYiyIpN5jNEx0mmBiaEvqAsHDh8yKQaKBO2jla
	KS1mEG2ER2Jh29MKCF4a73lW1cxUc13aIkJQtAzBJjQxM3eFcPqYSoVgLeJF2UWg3B3w98
	3hoqPC23OZeEc/sssrQQan12Ah1Vq/4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-DRZN2X6EPIWNny3g2_W_7A-1; Tue,
 25 Jun 2024 23:17:08 -0400
X-MC-Unique: DRZN2X6EPIWNny3g2_W_7A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC6321956089;
	Wed, 26 Jun 2024 03:17:06 +0000 (UTC)
Received: from [10.22.10.23] (unknown [10.22.10.23])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA1A91956050;
	Wed, 26 Jun 2024 03:17:04 +0000 (UTC)
Message-ID: <29cfa20e-291f-4ad0-9493-04c581d080b0@redhat.com>
Date: Tue, 25 Jun 2024 23:17:03 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] cgroup/cpuset: Prevent UAF in proc_cpuset_show()
To: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, adityakali@google.com,
 sergeh@kernel.org
Cc: bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240626030500.460628-1-chenridong@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240626030500.460628-1-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


On 6/25/24 23:05, Chen Ridong wrote:
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

The function prototype for cgroup_path_ns_locked() is available in 
"kernel/cgroup/cgroup-internal.h". You just need to include 
"cgroup-internal.h" in cpuset.c instead of exposed this internal API to 
the world.

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

Could you properly align the wrapped cgroup_ns argument?

Cheers,
Longman

> +
> +	spin_unlock_irq(&css_set_lock);
> +	rcu_read_unlock();
>   	css_put(css);
>   	if (retval == -E2BIG)
>   		retval = -ENAMETOOLONG;


