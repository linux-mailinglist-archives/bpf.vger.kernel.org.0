Return-Path: <bpf+bounces-47747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDEE9FFB0E
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 16:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153E31614CF
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 15:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B191B0F14;
	Thu,  2 Jan 2025 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T98LwY9l"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB53E189B8D
	for <bpf@vger.kernel.org>; Thu,  2 Jan 2025 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735832305; cv=none; b=p2uiE9UDzJ+X4MgbAqLhzPYpZWO64BkZoTgSR9WPkBvHyqfpc668Q5H4fMEkEGBDwM/Frij4sTYXd10l+o0pxFXPkfLUt8rqKYeJrpu/DcUmSa65Ha88ZxDg7SuIKvYT63YHahq/PtpAzlRkV0LwWi8w4ZmS1P8/nxAg6G4l+GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735832305; c=relaxed/simple;
	bh=yvjH7949LaAEyvIaQ77110qTLyO9X6fbB95HqVGAV9s=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RsEs8vFS6LntYWMleRy5iqeQKoUStijSvUcGu3R9OU530ICvFC8KCGdUh4hvUgwhrsSLLlaFvJQhT/t5FxzdRDj+zbgT7Y8UcPEInJWtj3JAclHh0bBN1oQ0jQ3WcdYbr64Cm97CQWaclHvca7EqYHleB3n6uDPOnwHBVVlKuvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T98LwY9l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735832302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tzu3c+PufhksktlwwL2rOytPumyykNC+KnQdtJRJP4c=;
	b=T98LwY9lmerDH3nOQ45rxzobwrtEhvgYRWX7JhQJ7HPUkixr9EuvGSufBXrIon50339mny
	vdQ7xrsuVpUuQ18vy+8J9+x0AIHMxSbJIZFcVXIPaAivdqbYLJQ+i7y7cxYsysZKICoC21
	UOGnfXF/KnRsWQdyjR0yi/F5wBeMgCE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-HoyNWachP2GblatxHclNlA-1; Thu, 02 Jan 2025 10:38:21 -0500
X-MC-Unique: HoyNWachP2GblatxHclNlA-1
X-Mimecast-MFC-AGG-ID: HoyNWachP2GblatxHclNlA
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6e1b036e9so1177781985a.1
        for <bpf@vger.kernel.org>; Thu, 02 Jan 2025 07:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735832301; x=1736437101;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzu3c+PufhksktlwwL2rOytPumyykNC+KnQdtJRJP4c=;
        b=OVHckHjO9m74FHc+2jVvNz7g+ANikVl//QDbnaofQv5gJ6xbHf02bAsSdNQvsPbAvc
         y0HWKbiHeprc3jQ4IXNhxTZdBKHXeMx2aw6GA+qQRpFmj9sMloDwDCQJOaoXAbLk7ve6
         IA3CUbpdSH56oizq2DcHmjbp5n6QNQwrs/1qcvHJEV8+mef2uJdkbiZuL2yVTplJWOWn
         8EpuX/mRP85tP2f40SMYKdOINAWpXpfTGmeCnH4JCfsvj7rrOfWuiIm5q644ELnCV01+
         KReyAm+QLbCYu+LT9LmoITFF1sHKcI34JwKxbDa1+kpphhdLso50l2qekP9Axv6gpJPD
         tGVA==
X-Forwarded-Encrypted: i=1; AJvYcCX1DCmJoyaTxPgkr+d1cSBd04+HNHkX9FmI4aC7/uxNmmBNrxzDy44kNkaeXcTScOmCNmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz84Mw1G8K/buTK/nzrwkaollcbZBtbkQ/IYloPLVwt1WEzdt0O
	vhChIrnIU+zrKGw/nmDbTStrnorqHPfT263KXcXoTUm1ljjgt4D18lgKTlPVsHRjvqg35+/oL8I
	ny78m/40a11oQztWhy7Sbq8pFQo5UsoB80wzkr3/nm/BSK5E0OQ==
X-Gm-Gg: ASbGnctHXowi97v1937nnDuAnNPrNBBQDKRrioBiASC7AwkL/cUtNU/yfFJrZSfaKLy
	hoeCLuWZKBw1L21QCpEHMBO3GSHqtinysMXrDUWmyTEejW8DjDeJ/x4caXnPxlQUqko3snxJknx
	/RqJFULcyHzzbURH6NDLT95KyEF23OYpRjhAaTn6Z2Fsqlecj8zm1MQt2VV1XuK3vt5dALNY7C6
	hmyTVf7TDaKeFyAQddCwmYmQ4Lthx7FFiur8SFzfN0CnSousLhcshehnWouI+vFed2q26FutOzd
	RI045tNXtEditotcrolE5sUk
X-Received: by 2002:a05:620a:2991:b0:7b6:773f:4bd5 with SMTP id af79cd13be357-7b9ba743a18mr7163228585a.20.1735832301023;
        Thu, 02 Jan 2025 07:38:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmwtbxtZupT/7iNXXpy4HA+O+TZIo5rbMBflA367FOuM4yjhsc22b6T/ySCGEC78vHvDFlhg==
X-Received: by 2002:a05:620a:2991:b0:7b6:773f:4bd5 with SMTP id af79cd13be357-7b9ba743a18mr7163223985a.20.1735832300560;
        Thu, 02 Jan 2025 07:38:20 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2bbb7dsm1195829985a.5.2025.01.02.07.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 07:38:19 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0ab514d5-6611-4a6f-82ff-e71eb8af5f5d@redhat.com>
Date: Thu, 2 Jan 2025 10:38:18 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cgroup/cpuset: remove kernfs active break
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 chenridong <chenridong@huawei.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, roman.gushchin@linux.dev
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, wangweiyang2@huawei.com
References: <20241220013106.3603227-1-chenridong@huaweicloud.com>
 <5c48f188-0059-46a2-9ccd-aad6721d96bb@redhat.com>
 <cafb38a5-0832-4af4-a3b2-cca32ce63d10@huawei.com>
 <61b5749b-3e75-4cf6-9acb-23b63f78d859@redhat.com>
 <d3ebff6a-9866-40e2-a1ff-07bd77d20187@huaweicloud.com>
 <5cb32477-7346-4417-a49e-de2b7dda7401@redhat.com>
 <ffa385b8-861f-4779-b3f0-462468193cf1@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <ffa385b8-861f-4779-b3f0-462468193cf1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/22/24 9:12 PM, Chen Ridong wrote:
>
> On 2024/12/20 23:13, Waiman Long wrote:
>> On 12/20/24 1:11 AM, Chen Ridong wrote:
>>> On 2024/12/20 12:16, Waiman Long wrote:
>>>> On 12/19/24 11:07 PM, chenridong wrote:
>>>>> On 2024/12/20 10:55, Waiman Long wrote:
>>>>>> On 12/19/24 8:31 PM, Chen Ridong wrote:
>>>>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>>>>
>>>>>>> A warning was found:
>>>>>>>
>>>>>>> WARNING: CPU: 10 PID: 3486953 at fs/kernfs/file.c:828
>>>>>>> CPU: 10 PID: 3486953 Comm: rmdir Kdump: loaded Tainted: G
>>>>>>> RIP: 0010:kernfs_should_drain_open_files+0x1a1/0x1b0
>>>>>>> RSP: 0018:ffff8881107ef9e0 EFLAGS: 00010202
>>>>>>> RAX: 0000000080000002 RBX: ffff888154738c00 RCX: dffffc0000000000
>>>>>>> RDX: 0000000000000007 RSI: 0000000000000004 RDI: ffff888154738c04
>>>>>>> RBP: ffff888154738c04 R08: ffffffffaf27fa15 R09: ffffed102a8e7180
>>>>>>> R10: ffff888154738c07 R11: 0000000000000000 R12: ffff888154738c08
>>>>>>> R13: ffff888750f8c000 R14: ffff888750f8c0e8 R15: ffff888154738ca0
>>>>>>> FS:  00007f84cd0be740(0000) GS:ffff8887ddc00000(0000)
>>>>>>> knlGS:0000000000000000
>>>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>> CR2: 0000555f9fbe00c8 CR3: 0000000153eec001 CR4: 0000000000370ee0
>>>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>>>> Call Trace:
>>>>>>>      kernfs_drain+0x15e/0x2f0
>>>>>>>      __kernfs_remove+0x165/0x300
>>>>>>>      kernfs_remove_by_name_ns+0x7b/0xc0
>>>>>>>      cgroup_rm_file+0x154/0x1c0
>>>>>>>      cgroup_addrm_files+0x1c2/0x1f0
>>>>>>>      css_clear_dir+0x77/0x110
>>>>>>>      kill_css+0x4c/0x1b0
>>>>>>>      cgroup_destroy_locked+0x194/0x380
>>>>>>>      cgroup_rmdir+0x2a/0x140
>>>>>> Were you using cgroup v1 or v2 when this warning happened?
>>>>> I was using cgroup v1.
>>>> Thanks for the confirmation.
>>>>>>> It can be explained by:
>>>>>>> rmdir                 echo 1 > cpuset.cpus
>>>>>>>                    kernfs_fop_write_iter // active=0
>>>>>>> cgroup_rm_file
>>>>>>> kernfs_remove_by_name_ns    kernfs_get_active // active=1
>>>>>>> __kernfs_remove                      // active=0x80000002
>>>>>>> kernfs_drain            cpuset_write_resmask
>>>>>>> wait_event
>>>>>>> //waiting (active == 0x80000001)
>>>>>>>                    kernfs_break_active_protection
>>>>>>>                    // active = 0x80000001
>>>>>>> // continue
>>>>>>>                    kernfs_unbreak_active_protection
>>>>>>>                    // active = 0x80000002
>>>>>>> ...
>>>>>>> kernfs_should_drain_open_files
>>>>>>> // warning occurs
>>>>>>>                    kernfs_put_active
>>>>>>>
>>>>>>> This warning is caused by 'kernfs_break_active_protection' when it is
>>>>>>> writing to cpuset.cpus, and the cgroup is removed concurrently.
>>>>>>>
>>>>>>> The commit 3a5a6d0c2b03 ("cpuset: don't nest cgroup_mutex inside
>>>>>>> get_online_cpus()") made cpuset_hotplug_workfn asynchronous, which
>>>>>>> grabs
>>>>>>> the cgroup_mutex. To avoid deadlock. the commit 76bb5ab8f6e3
>>>>>>> ("cpuset:
>>>>>>> break kernfs active protection in cpuset_write_resmask()") added
>>>>>>> 'kernfs_break_active_protection' in the cpuset_write_resmask. This
>>>>>>> could
>>>>>>> lead to this warning.
>>>>>>>
>>>>>>> After the commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug
>>>>>>> processing synchronous"), the cpuset_write_resmask no longer needs to
>>>>>>> wait the hotplug to finish, which means that cpuset_write_resmask
>>>>>>> won't
>>>>>>> grab the cgroup_mutex. So the deadlock doesn't exist anymore.
>>>>>>> Therefore,
>>>>>>> remove kernfs_break_active_protection operation in the
>>>>>>> 'cpuset_write_resmask'
>>>>>> The hotplug operation itself is now being done synchronously, but task
>>>>>> transfer (cgroup_transfer_tasks()) because of lacking online CPUs is
>>>>>> still being done asynchronously. So kernfs_break_active_protection()
>>>>>> will still be needed for cgroup v1.
>>>>>>
>>>>>> Cheers,
>>>>>> Longman
>>>>>>
>>>>>>
>>>>> Thank you, Longman.
>>>>> IIUC, The commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug
>>>>> processing synchronous") deleted the 'flush_work(&cpuset_hotplug_work)'
>>>>> in the cpuset_write_resmask. And I do not see any process within the
>>>>> cpuset_write_resmask that will grab cgroup_mutex, except for
>>>>> 'flush_work(&cpuset_hotplug_work)'.
>>>>>
>>>>> Although cgroup_transfer_tasks() is asynchronous, the
>>>>> cpuset_write_resmask will not wait any work that will grab
>>>>> cgroup_mutex.
>>>>> Consequently, the deadlock does not exist anymore.
>>>>>
>>>>> Did I miss something?
>>>> Right. The flush_work() call is still needed for a different work
>>>> function. cpuset_write_resmask() will not need to grab cgroup_mutex, but
>>>> the asynchronously executed cgroup_transfer_tasks() will. I will work on
>>>> a patch to fix that issue.
>>>>
>>>> Cheers,
>>>> Longman
>>> If flush_work() is added back, this warning still exists. Do you have a
>>> idea to fix this warning?
>> I was wrong. The flush_work() call isn't needed in this case and we
>> shouldn't need to break kernfs protection. However, your patch
>> description isn't quite right.
>>
>>> After the commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug
>>> processing synchronous"), the cpuset_write_resmask no longer needs to
>>> wait the hotplug to finish, which means that cpuset_write_resmask won't
>>> grab the cgroup_mutex. So the deadlock doesn't exist anymore.
>> cpuset_write_resmask() never needs to grab the cgroup_mutex. The act of
>> calling flush_work() can create a multiple processes circular locking
>> dependency that involve cgroup_mutex which can cause a deadlock. After
>> making cpuset hotplug synchronous, concurrent hotplug and cpuset
>> operations are no longer possible. However, concurrent task transfer out
>> of a previously empty CPU cpuset and adding CPU back to that cpuset is
>> possible. This will result in what the comment said "keep removing tasks
>> added
>> after execution capability is restored". That should be rare though and
>> we should probably add a check in cgroup_transfer_tasks() to detect such
>> a case and break out of it.
>>
>> Cheers,
>> Longman
> Hi, Longman, sorry the confused message. Do you mean this patch is
> acceptable if I update the message?
Sorry for the late reply. Yes, the patch is acceptable, but the patch 
description isn't quite right. Please sent out a v2.
>
> I don't think we need to add a check in the cgroup_transfer_tasks
> function. Because no process(except for writing cpuset.cpus, which has
> been reoved) will need 'kn->active' to involve cgroup_transfer_tasks now.

I agree that we don't need to add a check in cgroup_transfer_tasks().

Cheers,
Longman



