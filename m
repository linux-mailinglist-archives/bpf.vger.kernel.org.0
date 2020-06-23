Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F2B206715
	for <lists+bpf@lfdr.de>; Wed, 24 Jun 2020 00:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387690AbgFWWQN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 18:16:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14996 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387618AbgFWWQM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Jun 2020 18:16:12 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NM17E8021450;
        Tue, 23 Jun 2020 15:16:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=8XQlONpxXyZfrIgVhFOLOZYTU2iLP13/ML9SHF6GkcU=;
 b=FQ4XvgUJYdALUFG+tisUzXCp/L2OeR4tNRZUm7q12BbT4TixLu8Oj4A3TJ82Tr++EoN8
 HsV1NOIMt4i6XpxPV12n1x7q6T1gU+daAiYfiz6+aU+djV6jkS+lfMlkCTH43jLYztIR
 4D9UgRmTZWN0LqznaiYJQPiQZRfppCjy2sU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31uk3cjgh9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Jun 2020 15:16:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 15:16:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGk4B90omXHLNClF+l01qG4lK/BkCSQ1IMvDc6GHqHShpt+xD4WAWo4uLvn0u+YtdSVcdAjaK2nKsZ0GE+KxM2uSN9j5kxUU1fxkZr4mq9JYOZFRkgDpO5kew2Bf3J3ilVrRhCj0pAgHl+BeRQVoLZ6D4okmC9n/9CoL+XOWLcFlXxxKn8BxPmYfTCmtDxzYyxjJavWi1TXd6QiNxm1IWAhqHCh87YSK6SvTC+fSHVoDYiLLz+BaEGOHhSTT3RNlRuXdDFdmlubMq/iEmJ2Guu4yVBU7cD6hofKy8KHZeX+9+xWhS9EAtGe/Ke6TCerKuZO3mQLXCIrNF7Gy8AtKtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XQlONpxXyZfrIgVhFOLOZYTU2iLP13/ML9SHF6GkcU=;
 b=JoVJTtpbVmYdp0vml74DBfJFsOTZox8tf3LEZyBNUdFehM/rwRA+Hw2K5CJUPEIfCmh1JzQFLzjvYk073qC6IHXyu/WHdNKdSAuLwzWfn935ZHIw3swIolDl5aduP4iVVn/RAaxZI2ZYEBnnppkimdDGCtdImsOTfxgSTSR/BJXu2xjnrSyVYNKTS61+s20cROPnZJy/pPq43qAh8ZwcKPXP51GMOowx2RrrJ/PgHVzdDkIIVzgcZWkt0p3RHkwXfg+PSwa6vKTk9lCj/MBzsZ4uTTv6vtt1X03mD36ulfDSmHmaJJuzy0WB7O/09CrWLcdPsvumjrpmn+mPNChnjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XQlONpxXyZfrIgVhFOLOZYTU2iLP13/ML9SHF6GkcU=;
 b=eQgaWt0PHGO8pEpzxCzXoBvq+tI7uDkQ3JFps4s4ZS3T92uuy/KBgjqFJWYmA4q3Ti5CWA/cI0yZl3HFqDTcnw7i42N1rLb2neJWnTCVRCiPDU11gTvMKmRdoaUNEOhrEw1y3LTyt5JjJGJWQA+2gOmTUwjlXM+WUut4kv3ETnQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2885.namprd15.prod.outlook.com (2603:10b6:a03:f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Tue, 23 Jun
 2020 22:16:05 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 22:16:05 +0000
Subject: Re: Accessing mm_rss_stat fields with btf/BPF_CORE_READ_INTO
To:     Matt Pallissard <matt@pallissard.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>
References: <20200621154428.pf6foowywrq3wxt2@matt-gen-laptop-p01>
 <20200622150128.hjwe3uak2sy7po22@matt-gen-desktop-p01.matt.pallissard.net>
 <CAEf4BzZt-aAo-t-eV=r3SNfgJh3rfqS8EFufz32VYKX9zOfXMQ@mail.gmail.com>
 <20200622171902.4q3pypddgyyp5p5r@matt-gen-desktop-p01.matt.pallissard.net>
 <CAEf4Bzb8U3SRQbxzLtTZihG3X=-OtQcYQApmJUhmuwqtXZaucg@mail.gmail.com>
 <20200623145429.zusbbebj52scumcr@matt-gen-desktop-p01.matt.pallissard.net>
 <8ffec8ff-664d-fd3e-12eb-49eac339b612@fb.com>
 <CAEf4BzbgQoi=NC6hM0j=49iGeexUEeuJFciMfipV+VDt+Luadg@mail.gmail.com>
 <20200623181105.luijy2q4vdzonlxk@matt-gen-desktop-p01.matt.pallissard.net>
 <CAEf4Bza4OFEeW59HGPtHcE2_2+KoT9h8B=Qzah58FtBf3EFoQg@mail.gmail.com>
 <20200623220538.37epdt36y5yyihph@matt-gen-desktop-p01.matt.pallissard.net>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3382a449-77ee-ab79-509e-b67c93df8949@fb.com>
Date:   Tue, 23 Jun 2020 15:16:03 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200623220538.37epdt36y5yyihph@matt-gen-desktop-p01.matt.pallissard.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1926] (2620:10d:c090:400::5:d956) by BY5PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:1e0::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Tue, 23 Jun 2020 22:16:04 +0000
X-Originating-IP: [2620:10d:c090:400::5:d956]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d076383-7d4b-4859-3e3a-08d817c305c6
X-MS-TrafficTypeDiagnostic: BYAPR15MB2885:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2885AC03C5AA3E7EA71849A5D3940@BYAPR15MB2885.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eXpjJKUd7MTOAW0JksYu2w+r7zwcw3x8G87z0V+fkFvRMk83Goz+pM07XbNXLTP9lsCHSTUTUelrSJbA0JUDKfz+Osg5AtV+uZOV6THs5fRIGNarLnzXNyvOnDufxWWVFjFfahrjaq1pBJ/2II6tLTQrwR65EWVuv4Gx7JCTb0KsNy+2RMa+OGlCe+5U8PlBwxJMicSfePOclisf9YqV3q7X9tTCqEbw++kJpXenK0p5gKxhqLhIxQuZfM+p87Fj2erM5pchglOzf79ZCcodaVB9DeRv9MR+6OKs6ki7Seq/5HVkg6L5aezyN9T4fxiEVWIbcHknCjMgDRC2ayNnGPgdKAoOb377uPnsbGinUlmSUoSRDHAJL1IuSultTWLg4PVbAdz7yYfVJTBAxdKpwbQe+dCLj5Xpp5nMEvUsQEz+fODYFubGWxIUnx20AvVbYNHe/yodpV1BJQLxYxYdOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(39860400002)(346002)(366004)(376002)(30864003)(66556008)(31686004)(66476007)(36756003)(66946007)(316002)(5660300002)(53546011)(110136005)(966005)(8936002)(86362001)(31696002)(16526019)(4326008)(186003)(83380400001)(52116002)(2616005)(2906002)(478600001)(8676002)(6486002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 9EXbF3Tw6AL6WGp4c3P+dgdXD+zRHzC+bfVjEGk5L02xynRXseiiMoHuoCaa5r7CAWgG9tv7l4tBipadpdT5OPvbvjT7SddergNbBfpg1ubS+uJofDWOpz6zvyNuUFj2drhN6dTBp7gwqmHurCETLdbaUk9rTiTOJO9qK3BOiZo9KplyHkrSXJg2aM4emKWst7z002umJ59tJyJx3B/Bg9K+UHdjSiIEPkWv6tvKOJl9GN2AjykZ/JzMr3U4+9d1/EUjtZ0UQdyRlVEFp7tACfrmpzNQpK9/t5NFJ4buUbnpeOkPQtMcFDQk8J4q+3kkEo6VIPzXMRrcJDToQ/RR43a/y1PvlK/h+UFF7XHXJ1RIQRxqFNWdASHXSJN50TfGRjScaWZfHJAdmbf4JwrMOBOFygErbKRC8Q6E7foRI7kHush72it6jss8pKEDxh6jdJnCgabJNbf0YlUX09XfVJpMDG8rTH/egvw/8alWG3Y6Vo+FjBGH/xvwBx5zxuwLhVTJxGAb0mEKlAKwAlsL8Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d076383-7d4b-4859-3e3a-08d817c305c6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 22:16:05.7084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VoYszh7W2wCncMc+mn6oiGX9CSBPVYhKH02lKY1ujJRVw9Zd0i8FR75RTGRrbG1f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2885
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_14:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 impostorscore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230147
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/23/20 3:05 PM, Matt Pallissard wrote:
> 
> 
> On 2020-06-23T11:36:06 -0700, Andrii Nakryiko wrote:
>> On Tue, Jun 23, 2020 at 11:11 AM Matt Pallissard <matt@pallissard.net> wrote:
>>>
>>>
>>> On 2020-06-23T10:58:20 -0700, Andrii Nakryiko wrote:
>>>> On Tue, Jun 23, 2020 at 9:36 AM Yonghong Song <yhs@fb.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 6/23/20 7:54 AM, Matt Pallissard wrote:
>>>>>>
>>>>>> On 2020-06-22T15:09:57 -0700, Andrii Nakryiko wrote:
>>>>>>> On Mon, Jun 22, 2020 at 10:19 AM Matt Pallissard <matt@pallissard.net> wrote:
>>>>>>>>
>>>>>>>> On 2020-06-22T09:20:03 -0700, Andrii Nakryiko wrote:
>>>>>>>>> On Mon, Jun 22, 2020 at 8:01 AM Matt Pallissard <matt@pallissard.net> wrote:
>>>>>>>>>> On 2020-06-21T08:44:28 -0700, Matt Pallissard wrote:
>>>>>>>>>>> On 2020-06-20T20:29:43 -0700, Andrii Nakryiko wrote:
>>>>>>>>>>>> On Sat, Jun 20, 2020 at 1:07 PM Matt Pallissard <matt@pallissard.net> wrote:
>>>>>>>>>>>>> On 2020-06-20T11:11:55 -0700, Yonghong Song wrote:
>>>>>>>>>>>>>> On 6/20/20 9:22 AM, Matt Pallissard wrote:
>>>>>>>>>>>>>>> New to bpf here.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I'm trying to read values out of of mm_struct.  I have code like this;
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> unsigned long i[10] = {};
>>>>>>>>>>>>>>> struct task_struct *t;
>>>>>>>>>>>>>>> struct mm_rss_stat *rss;
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> t = (struct task_struct *)bpf_get_current_task();
>>>>>>>>>>>>>>> BPF_CORE_READ_INTO(&rss, t, mm, rss_stat);
>>>>>>>>>>>>>>> BPF_CORE_READ_INTO(i, rss, count);
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> However, all values in `i` appear to be 0 (i[MM_FILEPAGES], etc), as if no data gets copied.  I'm about 100% confident that this is caused by a glaring oversight on my part.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Maybe you want to check the return value of BPF_CORE_READ_INTO.
>>>>>>>>>>>>>> Underlying it is using bpf_probe_read and bpf_probe_read may fail e.g., due
>>>>>>>>>>>>>> to major fault.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Doh, I should have known to check the return codes!  Yes, it was failing.  I knew I was overlooking something trivial.
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> I wrote exactly such piece of code a while ago. Here's part of it for
>>>>>>>>>>>> reference, I think it will be helpful:
>>>>>>>>>>>>
>>>>>>>>>>>>     struct task_struct *task = (struct task_struct *)bpf_get_current_task();
>>>>>>>>>>>>     const struct mm_struct *mm = BPF_CORE_READ(task, mm);
>>>>>>>>>>>>
>>>>>>>>>>>>     if (mm) {
>>>>>>>>>>>>         u64 hiwater_rss = BPF_CORE_READ(mm, hiwater_rss);
>>>>>>>>>>>>         u64 file_pages = BPF_CORE_READ(mm, rss_stat.count[MM_FILEPAGES].counter);
>>>>>>>>>>>>         u64 anon_pages = BPF_CORE_READ(mm, rss_stat.count[MM_ANONPAGES].counter);
>>>>>>>>>>>>         u64 shmem_pages = BPF_CORE_READ(mm,
>>>>>>>>>>>> rss_stat.count[MM_SHMEMPAGES].counter);
>>>>>>>>>>>>         u64 active_rss = file_pages + anon_pages + shmem_pages;
>>>>>>>>>>>>         /* ... */
>>>>>>>>>>>
>>>>>>>>>>> Thank you,
>>>>>>>>>>>
>>>>>>>>>>> After realizing that I was referencing the struct incorrectly, I wound up with a similar block of code.  However, as I started testing it against /proc/pid/smaps[,_rollup] I noticed that my numbers didn't match up.  Always smaller.
>>>>>>>>>>>
>>>>>>>>>>> I took a quick glance at fs/proc/task_mmu.c.  I think I'll have to walk some sort of accounting structure.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I started to take a hard look at fs/proc/task_mmu.c.  With all the locking, globals, and compile-time constants, I'm not sure that it's even possible to correctly walk `vm_area_struct` in bpf.
>>>>>>>>>
>>>>>>>>> Yes, you can't take all those locks from BPF. But reading atomic
>>>>>>>>> counters from BPF should be no problem. You might get a slightly out
>>>>>>>>> of sync readings, but whatever you are doing shouldn't expect to have
>>>>>>>>> 100% correct values anyways, because they might change so fast after
>>>>>>>>> you read them.
>>>>>>>>
>>>>>>>> That was my initial thought.  I didn't care to much about stale data, my only real concern was walking vm_area_struct and having memory freed.  I wasn't sure if that could break the list underneath me.  Although, that shouldn't be too difficult to get to the bottom of.
>>>>>>>>
>>>>>>>
>>>>>>> Not sure about vm_area_struct (where is it in the example above?), but
>>>>>>> mm_struct won't go away, because current task won't go away, because
>>>>>>> BPF program is running in the context of current. Similarly for
>>>>>>> bpf_iter, bpf_iter will actually take a refcnt on tast_struct. So I
>>>>>>> think you don't have to worry about that.
>>>>>>
>>>>>> I didn't mention it explicitly in the example above.  But when I originally mentioned walking an accounting structure, as procfs does, it winds up being `mm_struct->mmap,vm_[next,prev]`, with mmap being a `vm_area_struct`.  But, it sounds like I should be abandoning that path and iterating over all the tasks.
>>>>>>
>>>>>>
>>>>>>>>>> If anyone has suggestions for getting memory numbers from an entire process, not just a task/thread, I'd love to hear them.  If not, I'll pursue this on my own.
>>>>>>>>>
>>>>>>>>> For this, you'd need to iterate across many tasks and aggregate their
>>>>>>>>> results based on tasks's tgid. Check iter/task programs in selftests
>>>>>>>>> (progs/bpf_iter_task.c, I think).
>>>>>>
>>>>>>
>>>>>> When I try to replicate some of the selftest task logic. I run into some errors when I call bpf_object__load.  `libbpf: task is not found in vmlinux BTF.`  I'll try matching the selftest code more closely and digging into that further.
>>>>>
>>>>> Somehow libbpf did not prepend `task` with `bpf_iter_` prefix. Not sure
>>>>> what is the exact issue. Yes, please mimic what selftests did.
>>>>>
>>>>
>>>> It's just an artifact of how libbpf logs error in such case. It did
>>>> search for "bpf_iter_task" type, though. But Matt probably doesn't
>>>> have a recent enough kernel or didn't build it with
>>>> CONFIG_DEBUG_INFO_BTF=y and pahole 1.16+?
>>>
>>> That shouldn't be the case, I generated vmlinux.h from my currently running machine.
>>>
>>>
>>> I'm using an upstream kernel.
>>>> ~ uname -r
>>>> 5.7.2-arch1-1
>>>
>>> Which has the BTF debug info enabled.
>>>> ~ zgrep BTF= /proc/config.gz
>>>> CONFIG_DEBUG_INFO_BTF=y
>>>
>>>
>>> I assume that it was built with the version of pahole that's in the upstream repos.
>>>> ~ pacman -Ss pahole
>>>> extra/pahole 1.17-1 [installed]
>>>
>>>
>>> Unless I've came across some odd bug, I assume that I've implemented something incorrectly.
>>>
>>
>> Ok, can you show your code (BPF and user-space side) and libbpf debug logs then?
> 
> 
> Sure.  The userspace section in question is below.  I don't make it past `bpf_object__load`.  Same userspace code works fine for tracepoints.
> 
> 	struct bpf_program *prog;
> 	struct bpf_object *obj;
> 	char path[] = PT_BPF_OBJECT_DIR;
> 	strcat(&path[strlen(path)], "/test.o");
> 
> 	libbpf_set_print(print_libbpf_log);
> 
> 	obj = bpf_object__open_file(path, NULL);
> 	if (libbpf_get_error(obj))
> 		return 1;
> 
> 	if(!(prog = bpf_object__find_program_by_name(obj, "dump_task")))
> 		goto cleanup;
> 
> 	if (bpf_object__load(obj))
> 		goto cleanup;
> 
> 
> I copied the kernel code, only slightly modifying the include statements
> 
> 	#define bpf_iter_meta bpf_iter_meta___not_used
> 	#define bpf_iter__task bpf_iter__task___not_used
> 	#include <vmlinux.h>
> 	#undef bpf_iter_meta
> 	#undef bpf_iter__task
> 	#include <bpf_helpers.h>
> 	#include <bpf_tracing.h>
> 
> 	struct bpf_iter_meta {
> 		struct seq_file *seq;
> 		__u64 session_id;
> 		__u64 seq_num;
> 	} __attribute__((preserve_access_index));
> 
> 	struct bpf_iter__task {
> 		struct bpf_iter_meta *meta;
> 		struct task_struct *task;
> 	} __attribute__((preserve_access_index));
> 
> 	SEC("iter/task")
> 	int dump_task(struct bpf_iter__task *ctx)
> 	{
> 		struct seq_file *seq = ctx->meta->seq;
> 		struct task_struct *task = ctx->task;
> 
> 		if (task == (void *)0) {
> 			BPF_SEQ_PRINTF(seq, "    === END ===\n");
> 			return 0;
> 		}
> 
> 		if (ctx->meta->seq_num == 0)
> 			BPF_SEQ_PRINTF(seq, "    tgid      gid\n");
> 
> 		BPF_SEQ_PRINTF(seq, "%8d %8d\n", task->tgid, task->pid);
> 		return 0;
> 	}
> 
> 
> And here is the debug output
> 
> 
> libbpf: loading /tmp//usr/lib/pt/bpf/test.o
> libbpf: section(1) .strtab, size 277, link 0, flags 0, type=3
> libbpf: skip section(1) .strtab
> libbpf: section(2) .text, size 0, link 0, flags 6, type=1
> libbpf: skip section(2) .text
> libbpf: section(3) iter/task, size 320, link 0, flags 6, type=1
> libbpf: found program iter/task
> libbpf: section(4) .reliter/task, size 48, link 22, flags 0, type=9
> libbpf: section(5) .rodata, size 45, link 0, flags 2, type=1
> libbpf: section(6) license, size 4, link 0, flags 3, type=1
> libbpf: license of /tmp//usr/lib/pt/bpf/test.o is GPL
> libbpf: section(7) version, size 4, link 0, flags 3, type=1
> libbpf: kernel version of /tmp//usr/lib/pt/bpf/test.o is 5060b
> libbpf: section(8) .debug_str, size 135270, link 0, flags 30, type=1
> libbpf: skip section(8) .debug_str
> libbpf: section(9) .debug_loc, size 124, link 0, flags 0, type=1
> libbpf: skip section(9) .debug_loc
> libbpf: section(10) .debug_abbrev, size 857, link 0, flags 0, type=1
> libbpf: skip section(10) .debug_abbrev
> libbpf: section(11) .debug_info, size 224491, link 0, flags 0, type=1
> libbpf: skip section(11) .debug_info
> libbpf: section(12) .rel.debug_info, size 160, link 22, flags 0, type=9
> libbpf: skip relo .rel.debug_info(12) for section(11)
> libbpf: section(13) .BTF, size 25711, link 0, flags 0, type=1
> libbpf: section(14) .rel.BTF, size 80, link 22, flags 0, type=9
> libbpf: skip relo .rel.BTF(14) for section(13)
> libbpf: section(15) .BTF.ext, size 348, link 0, flags 0, type=1
> libbpf: section(16) .rel.BTF.ext, size 288, link 22, flags 0, type=9
> libbpf: skip relo .rel.BTF.ext(16) for section(15)
> libbpf: section(17) .debug_frame, size 40, link 0, flags 0, type=1
> libbpf: skip section(17) .debug_frame
> libbpf: section(18) .rel.debug_frame, size 16, link 22, flags 0, type=9
> libbpf: skip relo .rel.debug_frame(18) for section(17)
> libbpf: section(19) .debug_line, size 216, link 0, flags 0, type=1
> libbpf: skip section(19) .debug_line
> libbpf: section(20) .rel.debug_line, size 16, link 22, flags 0, type=9
> libbpf: skip relo .rel.debug_line(20) for section(19)
> libbpf: section(21) .llvm_addrsig, size 6, link 22, flags 80000000, type=1879002115
> libbpf: skip section(21) .llvm_addrsig
> libbpf: section(22) .symtab, size 312, link 1, flags 0, type=2
> libbpf: looking for externs among 13 symbols...
> libbpf: collected 0 externs total
> libbpf: map 'test.rodata' (global data): at sec_idx 5, offset 0, flags 480.
> libbpf: map 0 is "test.rodata"
> libbpf: collecting relocating info for: 'iter/task'
> libbpf: relo for shdr 5, symb 9, value 0, type 3, bind 0, name 0 (''), insn 7
> libbpf: found data map 0 (test.rodata, sec 5, off 0) for insn 7
> libbpf: relo for shdr 5, symb 9, value 0, type 3, bind 0, name 0 (''), insn 17
> libbpf: found data map 0 (test.rodata, sec 5, off 0) for insn 17
> libbpf: relo for shdr 5, symb 9, value 0, type 3, bind 0, name 0 (''), insn 33
> libbpf: found data map 0 (test.rodata, sec 5, off 0) for insn 33
> libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
> libbpf: map 'test.rodata': created successfully, fd=4
> libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
> libbpf: prog 'iter/task': performing 6 CO-RE offset relocs
> libbpf: prog 'iter/task': relo #0: kind 0, spec is [2] bpf_iter__task + 0:0 => 0.0 @ &x[0].meta
> libbpf: prog 'iter/task': relo #0: no matching targets found for [2] bpf_iter__task + 0:0
> libbpf: prog 'iter/task': relo #0: substituting insn #0 w/ invalid insn

libbpf didn't find bpf_iter__task type in the vmlinux BTF.

The following are possible locations libbpf tries to find vmlinux:

                 /* try canonical vmlinux BTF through sysfs first */
                 { "/sys/kernel/btf/vmlinux", true /* raw BTF */ },
                 /* fall back to trying to find vmlinux ELF on disk 
otherwise */
                 { "/boot/vmlinux-%1$s" },
                 { "/lib/modules/%1$s/vmlinux-%1$s" },
                 { "/lib/modules/%1$s/build/vmlinux" },
                 { "/usr/lib/modules/%1$s/kernel/vmlinux" },
                 { "/usr/lib/debug/boot/vmlinux-%1$s" },
                 { "/usr/lib/debug/boot/vmlinux-%1$s.debug" },
                 { "/usr/lib/debug/lib/modules/%1$s/vmlinux" },

Could you check based on the order of the above matching whether you
vmlinux btf does have type bpf_iter__task?

You can use
   bpftool btf dump file /.../vmlinux
to see whether your vmlinux has bpf_iter__task type or not.

> libbpf: prog 'iter/task': relo #1: kind 0, spec is [8] bpf_iter_meta + 0:0 => 0.0 @ &x[0].seq
> libbpf: prog 'iter/task': relo #1: no matching targets found for [8] bpf_iter_meta + 0:0
> libbpf: prog 'iter/task': relo #1: substituting insn #1 w/ invalid insn
> libbpf: prog 'iter/task': relo #2: kind 0, spec is [2] bpf_iter__task + 0:1 => 8.0 @ &x[0].task
> libbpf: prog 'iter/task': relo #2: no matching targets found for [2] bpf_iter__task + 0:1
> libbpf: prog 'iter/task': relo #2: substituting insn #2 w/ invalid insn
> libbpf: prog 'iter/task': relo #3: kind 0, spec is [8] bpf_iter_meta + 0:2 => 16.0 @ &x[0].seq_num
> libbpf: prog 'iter/task': relo #3: no matching targets found for [8] bpf_iter_meta + 0:2
> libbpf: prog 'iter/task': relo #3: substituting insn #12 w/ invalid insn
> libbpf: prog 'iter/task': relo #4: kind 0, spec is [12] task_struct + 0:71 => 1292.0 @ &x[0].tgid
> libbpf: [12] task_struct: found candidate [115] task_struct
> libbpf: prog 'iter/task': relo #4: matching candidate #0 task_struct against spec [115] task_struct + 0:71 => 1292.0 @ &x[0].tgid: 1
> libbpf: prog 'iter/task': relo #4: patched insn #22 (LDX/ST/STX) off 1292 -> 1292
> libbpf: prog 'iter/task': relo #5: kind 0, spec is [12] task_struct + 0:70 => 1288.0 @ &x[0].pid
> libbpf: prog 'iter/task': relo #5: matching candidate #0 task_struct against spec [115] task_struct + 0:70 => 1288.0 @ &x[0].pid: 1
> libbpf: prog 'iter/task': relo #5: patched insn #26 (LDX/ST/STX) off 1288 -> 1288
> libbpf: task is not found in vmlinux BTF
> libbpf: failed to load object '/tmp//usr/lib/pt/bpf/test.o'
> *** stack smashing detected ***: terminated  <-- I assume this is because I'm not handling my errors and cleaning up properly
> Aborted (core dumped)
> 
>>>>>> As an aside; is there any documentation for bpf_iter outside of the selftests?
>>>>>
>>>>> Unfortunately, no. The commit messages of the original patch set might help.
>>>>> https://lore.kernel.org/bpf/20200507053916.1542319-1-yhs@fb.com/T/#mf973843af65fc51ac9b3e3673962cd3e87f705e8
