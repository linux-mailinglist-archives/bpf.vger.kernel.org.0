Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C06205753
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 18:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732551AbgFWQgE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 12:36:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51862 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729481AbgFWQgE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Jun 2020 12:36:04 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NGOdsJ026791;
        Tue, 23 Jun 2020 09:36:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=jo9UUkz+wXK5tc85Re9Dpp6Pgp49YYWVqDXIKpufOVU=;
 b=eAle5Kv35tzvXW612h/mbY1NKDlLyjePkYAwF7zIkKu04zjofChZsDh/NklN6+38kVrq
 eR1Nczllq8umpVuApuf40AE6YcnUmLIoSBnUInUIo7uvp3dcrE2veegIpfSSgdlAbl+e
 ycjtMLj6UYqA6hylLMbAfQ3b/1WWUCn3Bwk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31uk21gt3s-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Jun 2020 09:36:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 09:35:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jc1TcAUd9NQU8E+3PeOvJOsNS+BIlOmyKSs1WhA3LicRqcFc88vttEju/B1age3n+Xz9lq/J78xEFaUe+JAQkJ7rEKRrZOOe7trGdu5gKcaaAC++UxVihS+6ltf0NLfqHtALkQ91ft6TW+8aota0lCqbmTeXwotvSepiNytGQXcDkZQCSYibfBQWB5SAwPtIrunA7ivDmHYejy3MuQCJOW2oeFdodHwzbbXkNfiOLc9jjaaxyjTXwPo9Ols8qcCa5J1XsKQC1TZTRaNRKP4LyHdf+qUtU4peWG73YDS7QxpsZ2M2UPq6zZlmqLrJeOjkq4poPA47Rwf87an+LRpcQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jo9UUkz+wXK5tc85Re9Dpp6Pgp49YYWVqDXIKpufOVU=;
 b=jqvMOxYV8855EiiZrXBYLW7Wh1k5mXbez8kcpoEwyY1hNp4MIEmXngCRqp7H/VKKflMh8U+aUGe8tJMLTAH2QKyeLE8twVa44mt7fdj9/J/jQuCIp5trvTkNSBwOtYM1vUXJivxrAAnCH/zvxtqQHS5N6slp6OLtLdsr7Jy9YdApCEmP5gvHO4MSPrSc2yLTamVyYkGAA7Ls3jm5I8YHRkUu0g1o58eSro0BLdi4J/bQPTskPmcViq+6wXssciU5TbffsueWq3MSw/36z+4xcFmtoVtA8AwCQdaKUASaVHiJjuMYTCqy2LEJGnCgy7Sg3aUn0P58X/LlRh9yIaq9SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jo9UUkz+wXK5tc85Re9Dpp6Pgp49YYWVqDXIKpufOVU=;
 b=amEgHqw2iHLxFkfiWv5SRpGgakV2MZyNI3G8ZZLWKCYmBhotr4gxMxcilpAelP41Xb3DpuG0a5LAmtU5usKB9qBehGxj5DEs53yjow3o6L4G164gh70G6aHeGHt6UUbbTvp0c10pgqhydmOEgsKDNEchlIPZvvdisAlu110hOjI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BY5PR15MB3617.namprd15.prod.outlook.com (2603:10b6:a03:1fc::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 16:35:56 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 16:35:56 +0000
Subject: Re: Accessing mm_rss_stat fields with btf/BPF_CORE_READ_INTO
To:     Matt Pallissard <matt@pallissard.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>
References: <20200620162216.2ioyj6uzlpc45jzx@matt-gen-desktop-p01.matt.pallissard.net>
 <4889d766-578e-1e20-119f-9f97621e766f@fb.com>
 <20200620200602.ax7tjx5jrtgyj6vs@matt-gen-laptop-p01>
 <CAEf4Bzb1x5iGbb+mX0mz-mjLWvRvr9tn2SeQ3yVgd5eBagBc5w@mail.gmail.com>
 <20200621154428.pf6foowywrq3wxt2@matt-gen-laptop-p01>
 <20200622150128.hjwe3uak2sy7po22@matt-gen-desktop-p01.matt.pallissard.net>
 <CAEf4BzZt-aAo-t-eV=r3SNfgJh3rfqS8EFufz32VYKX9zOfXMQ@mail.gmail.com>
 <20200622171902.4q3pypddgyyp5p5r@matt-gen-desktop-p01.matt.pallissard.net>
 <CAEf4Bzb8U3SRQbxzLtTZihG3X=-OtQcYQApmJUhmuwqtXZaucg@mail.gmail.com>
 <20200623145429.zusbbebj52scumcr@matt-gen-desktop-p01.matt.pallissard.net>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <8ffec8ff-664d-fd3e-12eb-49eac339b612@fb.com>
Date:   Tue, 23 Jun 2020 09:35:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200623145429.zusbbebj52scumcr@matt-gen-desktop-p01.matt.pallissard.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0007.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::20) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1377] (2620:10d:c090:400::5:7789) by BY5PR17CA0007.namprd17.prod.outlook.com (2603:10b6:a03:1b8::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Tue, 23 Jun 2020 16:35:55 +0000
X-Originating-IP: [2620:10d:c090:400::5:7789]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 442b51e4-0784-4c75-9770-08d8179380ad
X-MS-TrafficTypeDiagnostic: BY5PR15MB3617:
X-Microsoft-Antispam-PRVS: <BY5PR15MB36172F8C955E7CE1680AAA9DD3940@BY5PR15MB3617.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yGBGHQx94eaQatp3YsZLJkiXOb2/Eb3bwASmCYhzK1EpdSJt2pePPkBp9yX7TDQQ+Zk3qjcE0hcxAzZcN7wC3LjRi7cUFUNqF2HI+1ciPu6u7pqiAFEXuURovKLNJs7H59DRJZG+lLFoQguKXbN0U5dQ6lsve49u8No60CvhwFhF6qCO/k8OY+ZyVmbRwIq/K3g8Y0Fmv2zChaD0Usw3lFDZQ6rR4UFxFhnq06r0wQ59JdxU1LaIGTgdY4+mfswmAafDjTN0yi3xopTl0eOnN3LkLfPKDPeWiVJfsKgXUS95wTm/BgU2OeJO7+TyA0uf/Vi5HNzHpXbOyVNo1ASZPJrUr3U5eX5Xpm7W6vVNNLZk1UScs6XqKzGp2JLaD014mjD8dPPB9iP6V7m7gTidEqnPw27/0wv1MA8yoDLIUPLTlKVqV+mfDTlUGp/E9LtlQszB822JqE9i15Tej+likw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(136003)(346002)(366004)(376002)(8936002)(31686004)(53546011)(83380400001)(966005)(478600001)(66476007)(52116002)(66556008)(66946007)(316002)(2616005)(110136005)(4326008)(2906002)(186003)(16526019)(8676002)(86362001)(36756003)(6486002)(31696002)(5660300002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: CGhlpuMtift0Q++wmzMcJuE4EVm1emGJN2L4PXyf5FMgZJym1gGZ+VF5tp62MWYWeDLyx79rQqXVRwy0mPaFEey+CUe/vf6fOYo4CmANMwWOwsdkA9d5MxYNgYLMr9p6Yd8QN+sSphnjMg1649teSIatbhH42bi7vPZt2Cue3dapUdjpD9T/K4d/IL3RlB/iaxDHV30kgYY6l4tGbsfOJu2MTvYB+BsKLGfw87ylE9ZGRN74EIccDBOB5jii3bTCdupla2qrW8kwRzwNOWyEXNv6E4zQeBhDRle4axCgfM3O7syzPbFlmMszKblACIqLqysuXZSQVQGL/iI1uuMLlwYtAi+/gTJZDS9XD4XBY3EfYjYoWpCytpPZameZPc8RiEsy+FXdE3MWB6QpPxXASFIvtjYHxWcHpqPM4feA+c0jhFePpngeEFPHThnYTkbkTRO6uGO/Vq4LAW1f8Z5eujCGU7yXGZyhfHSq94V12HCt4pv2mHklgzn+mimFvdD+9fVPlgkN792jeB3qeIVOPg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 442b51e4-0784-4c75-9770-08d8179380ad
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 16:35:56.0895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CEWanGnQlCH1sj0R8F/FpH+QsOZd5a3/FtNRY+5SHgQ2/xnKi6q/ywVFbzeAkSuE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3617
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_10:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230121
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/23/20 7:54 AM, Matt Pallissard wrote:
> 
> On 2020-06-22T15:09:57 -0700, Andrii Nakryiko wrote:
>> On Mon, Jun 22, 2020 at 10:19 AM Matt Pallissard <matt@pallissard.net> wrote:
>>>
>>> On 2020-06-22T09:20:03 -0700, Andrii Nakryiko wrote:
>>>> On Mon, Jun 22, 2020 at 8:01 AM Matt Pallissard <matt@pallissard.net> wrote:
>>>>> On 2020-06-21T08:44:28 -0700, Matt Pallissard wrote:
>>>>>> On 2020-06-20T20:29:43 -0700, Andrii Nakryiko wrote:
>>>>>>> On Sat, Jun 20, 2020 at 1:07 PM Matt Pallissard <matt@pallissard.net> wrote:
>>>>>>>> On 2020-06-20T11:11:55 -0700, Yonghong Song wrote:
>>>>>>>>> On 6/20/20 9:22 AM, Matt Pallissard wrote:
>>>>>>>>>> New to bpf here.
>>>>>>>>>>
>>>>>>>>>> I'm trying to read values out of of mm_struct.  I have code like this;
>>>>>>>>>>
>>>>>>>>>> unsigned long i[10] = {};
>>>>>>>>>> struct task_struct *t;
>>>>>>>>>> struct mm_rss_stat *rss;
>>>>>>>>>>
>>>>>>>>>> t = (struct task_struct *)bpf_get_current_task();
>>>>>>>>>> BPF_CORE_READ_INTO(&rss, t, mm, rss_stat);
>>>>>>>>>> BPF_CORE_READ_INTO(i, rss, count);
>>>>>>>>>>
>>>>>>>>>> However, all values in `i` appear to be 0 (i[MM_FILEPAGES], etc), as if no data gets copied.  I'm about 100% confident that this is caused by a glaring oversight on my part.
>>>>>>>>>
>>>>>>>>> Maybe you want to check the return value of BPF_CORE_READ_INTO.
>>>>>>>>> Underlying it is using bpf_probe_read and bpf_probe_read may fail e.g., due
>>>>>>>>> to major fault.
>>>>>>>>
>>>>>>>> Doh, I should have known to check the return codes!  Yes, it was failing.  I knew I was overlooking something trivial.
>>>>>>>>
>>>>>>>
>>>>>>> I wrote exactly such piece of code a while ago. Here's part of it for
>>>>>>> reference, I think it will be helpful:
>>>>>>>
>>>>>>>    struct task_struct *task = (struct task_struct *)bpf_get_current_task();
>>>>>>>    const struct mm_struct *mm = BPF_CORE_READ(task, mm);
>>>>>>>
>>>>>>>    if (mm) {
>>>>>>>        u64 hiwater_rss = BPF_CORE_READ(mm, hiwater_rss);
>>>>>>>        u64 file_pages = BPF_CORE_READ(mm, rss_stat.count[MM_FILEPAGES].counter);
>>>>>>>        u64 anon_pages = BPF_CORE_READ(mm, rss_stat.count[MM_ANONPAGES].counter);
>>>>>>>        u64 shmem_pages = BPF_CORE_READ(mm,
>>>>>>> rss_stat.count[MM_SHMEMPAGES].counter);
>>>>>>>        u64 active_rss = file_pages + anon_pages + shmem_pages;
>>>>>>>        /* ... */
>>>>>>
>>>>>> Thank you,
>>>>>>
>>>>>> After realizing that I was referencing the struct incorrectly, I wound up with a similar block of code.  However, as I started testing it against /proc/pid/smaps[,_rollup] I noticed that my numbers didn't match up.  Always smaller.
>>>>>>
>>>>>> I took a quick glance at fs/proc/task_mmu.c.  I think I'll have to walk some sort of accounting structure.
>>>>>
>>>>>
>>>>> I started to take a hard look at fs/proc/task_mmu.c.  With all the locking, globals, and compile-time constants, I'm not sure that it's even possible to correctly walk `vm_area_struct` in bpf.
>>>>
>>>> Yes, you can't take all those locks from BPF. But reading atomic
>>>> counters from BPF should be no problem. You might get a slightly out
>>>> of sync readings, but whatever you are doing shouldn't expect to have
>>>> 100% correct values anyways, because they might change so fast after
>>>> you read them.
>>>
>>> That was my initial thought.  I didn't care to much about stale data, my only real concern was walking vm_area_struct and having memory freed.  I wasn't sure if that could break the list underneath me.  Although, that shouldn't be too difficult to get to the bottom of.
>>>
>>
>> Not sure about vm_area_struct (where is it in the example above?), but
>> mm_struct won't go away, because current task won't go away, because
>> BPF program is running in the context of current. Similarly for
>> bpf_iter, bpf_iter will actually take a refcnt on tast_struct. So I
>> think you don't have to worry about that.
> 
> I didn't mention it explicitly in the example above.  But when I originally mentioned walking an accounting structure, as procfs does, it winds up being `mm_struct->mmap,vm_[next,prev]`, with mmap being a `vm_area_struct`.  But, it sounds like I should be abandoning that path and iterating over all the tasks.
> 
> 
>>>>> If anyone has suggestions for getting memory numbers from an entire process, not just a task/thread, I'd love to hear them.  If not, I'll pursue this on my own.
>>>>
>>>> For this, you'd need to iterate across many tasks and aggregate their
>>>> results based on tasks's tgid. Check iter/task programs in selftests
>>>> (progs/bpf_iter_task.c, I think).
> 
> 
> When I try to replicate some of the selftest task logic. I run into some errors when I call bpf_object__load.  `libbpf: task is not found in vmlinux BTF.`  I'll try matching the selftest code more closely and digging into that further.

Somehow libbpf did not prepend `task` with `bpf_iter_` prefix. Not sure 
what is the exact issue. Yes, please mimic what selftests did.

> 
> As an aside; is there any documentation for bpf_iter outside of the selftests?

Unfortunately, no. The commit messages of the original patch set might help.
https://lore.kernel.org/bpf/20200507053916.1542319-1-yhs@fb.com/T/#mf973843af65fc51ac9b3e3673962cd3e87f705e8

> 
> Matt Pallissard
> 
