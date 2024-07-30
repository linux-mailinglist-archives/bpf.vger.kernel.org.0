Return-Path: <bpf+bounces-36067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D0F941496
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 16:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6BFE1F2329F
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 14:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D3E1A2540;
	Tue, 30 Jul 2024 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="isDXl85G"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1487919DF41
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350667; cv=none; b=AI/VnnRYEiLI/bBGp17R1inTO42kNZcsWG16q0qKInlKdbDCcDHU5r2Bmu+KT0XJ6TkTTwaZk4IfU5U/XJKhl1U4oPB689+54huGaYmYQdzdnSheOTAJ//BppljOKu32Pfyw2ZrYOGk6CFpUGISb4m82oF0E0/YHrUA60974Ibs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350667; c=relaxed/simple;
	bh=vr0kksOUcj3mfV6SfSf/dZgFdtyCWxxaOfaP1ycpwiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0lIORoW5ucy0LvHZ2mU+WM5jEaFrYF+xF7hSVpm0T9XYWi6siIRPkKoxYnKkIBVupEZEPBwL7uivpxq0MBQe1K0F2r4ctY3y+DuvMi3ify284d6dNgPv5IQVXNCG1Nd9D7omzan9x7NLP5AyCLhv0d39UkIx4kNSjoZteKUHPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=isDXl85G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722350664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4dFUhbgczkCNUTYetCJudpoYgcsorCyECGT9LXifu4k=;
	b=isDXl85GhJUNpZsZuTtL+mt3VDJUUeZj4O31pbkIjWqAY+jCdOrdTu/LnlYxK4km9RNL1Y
	+I/NgVeSgsZ8O6hfWbS1rOAQcLvJ2B5t3SL36w9cfKQsL95l1QyrTztQZbZRTJpYcC6J3a
	UJwJkoYSeMX7z1YeB7AQLRyI3Vt1Buo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-7Xpm7sQ8MWWVspv2DQ2OKA-1; Tue,
 30 Jul 2024 10:44:23 -0400
X-MC-Unique: 7Xpm7sQ8MWWVspv2DQ2OKA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 960B61944AB5;
	Tue, 30 Jul 2024 14:44:21 +0000 (UTC)
Received: from [10.2.16.107] (unknown [10.2.16.107])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C5CAF1955D47;
	Tue, 30 Jul 2024 14:44:19 +0000 (UTC)
Message-ID: <5e6273f6-8aa3-4bd7-9433-c26379b04b4d@redhat.com>
Date: Tue, 30 Jul 2024 10:44:19 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/cpuset: fix panic caused by partcmd_update
To: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, adityakali@google.com,
 sergeh@kernel.org
Cc: bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240730095126.2328303-1-chenridong@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240730095126.2328303-1-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 7/30/24 05:51, Chen Ridong wrote:
> We find a bug as below:
> BUG: unable to handle page fault for address: 00000003
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 3 PID: 358 Comm: bash Tainted: G        W I        6.6.0-10893-g60d6
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/4
> RIP: 0010:partition_sched_domains_locked+0x483/0x600
> Code: 01 48 85 d2 74 0d 48 83 05 29 3f f8 03 01 f3 48 0f bc c2 89 c0 48 9
> RSP: 0018:ffffc90000fdbc58 EFLAGS: 00000202
> RAX: 0000000100000003 RBX: ffff888100b3dfa0 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000002fe80
> RBP: ffff888100b3dfb0 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffc90000fdbcb0 R11: 0000000000000004 R12: 0000000000000002
> R13: ffff888100a92b48 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f44a5425740(0000) GS:ffff888237d80000(0000) knlGS:0000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000100030973 CR3: 000000010722c000 CR4: 00000000000006e0
> Call Trace:
>   <TASK>
>   ? show_regs+0x8c/0xa0
>   ? __die_body+0x23/0xa0
>   ? __die+0x3a/0x50
>   ? page_fault_oops+0x1d2/0x5c0
>   ? partition_sched_domains_locked+0x483/0x600
>   ? search_module_extables+0x2a/0xb0
>   ? search_exception_tables+0x67/0x90
>   ? kernelmode_fixup_or_oops+0x144/0x1b0
>   ? __bad_area_nosemaphore+0x211/0x360
>   ? up_read+0x3b/0x50
>   ? bad_area_nosemaphore+0x1a/0x30
>   ? exc_page_fault+0x890/0xd90
>   ? __lock_acquire.constprop.0+0x24f/0x8d0
>   ? __lock_acquire.constprop.0+0x24f/0x8d0
>   ? asm_exc_page_fault+0x26/0x30
>   ? partition_sched_domains_locked+0x483/0x600
>   ? partition_sched_domains_locked+0xf0/0x600
>   rebuild_sched_domains_locked+0x806/0xdc0
>   update_partition_sd_lb+0x118/0x130
>   cpuset_write_resmask+0xffc/0x1420
>   cgroup_file_write+0xb2/0x290
>   kernfs_fop_write_iter+0x194/0x290
>   new_sync_write+0xeb/0x160
>   vfs_write+0x16f/0x1d0
>   ksys_write+0x81/0x180
>   __x64_sys_write+0x21/0x30
>   x64_sys_call+0x2f25/0x4630
>   do_syscall_64+0x44/0xb0
>   entry_SYSCALL_64_after_hwframe+0x78/0xe2
> RIP: 0033:0x7f44a553c887
>
> It can be reproduced with cammands:
> cd /sys/fs/cgroup/
> mkdir test
> cd test/
> echo +cpuset > ../cgroup.subtree_control
> echo root > cpuset.cpus.partition
> cat /sys/fs/cgroup/cpuset.cpus.effective
> 0-3
> echo 0-3 > cpuset.cpus // taking away all cpus from root
>
> This issue is caused by the incorrect rebuilding of scheduling domains.
> In this scenario, test/cpuset.cpus.partition should be an invalid root
> and should not trigger the rebuilding of scheduling domains. When calling
> update_parent_effective_cpumask with partcmd_update, if newmask is not
> null, it should recheck newmask whether there are cpus is available
> for parect/cs that has tasks.
>
> Fixes: 0c7f293efc87 ("cgroup/cpuset: Add cpuset.cpus.exclusive.effective for v2")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 40ec4abaf440..a9b6d56eeffa 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1991,6 +1991,8 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   			part_error = PERR_CPUSEMPTY;
>   			goto write_error;
>   		}
> +		/* Check newmask again, whether cpus are available for parent/cs */
> +		nocpu |= tasks_nocpu_error(parent, cs, newmask);
>   
>   		/*
>   		 * partcmd_update with newmask:
Reviewed-by: Waiman Long <longman@redhat.com>


