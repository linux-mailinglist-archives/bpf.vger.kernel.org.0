Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3E4489E66
	for <lists+bpf@lfdr.de>; Mon, 10 Jan 2022 18:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbiAJRae (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jan 2022 12:30:34 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28152 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237928AbiAJRae (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 10 Jan 2022 12:30:34 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20AGmm7U019555;
        Mon, 10 Jan 2022 09:30:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=rvpO9mqZWxxryhGA2WVHRNcJiCsxNAc1D6Wyw8jxBDA=;
 b=fyvt/MAym+tDGI55oKLEQ4pSw7niz+a/kT0l+eLpifoyrG/xkrOmfC0ViZhAeuzIGUXn
 cHjgTbn+lR+bk0/M5c+jocQjnPDVXjfVFLAz9hbduZsSpfdp9E+vbfI5uExtRAREZPbL
 7BuS5yv6pfoGcy2mF8s5UKOdazTwuumH54o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dgnuw1cmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 10 Jan 2022 09:30:15 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 09:30:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lD8l2fU2uIzuEuORZfcG1NaX2aw2sI9y7UalleSqQjzXvwC40QgX/R3LZz/iAxIpGOjlvCiQEebIcNah369s1e09YmBfAEiyiXGQr+zkQg/WquG+//ePUhF7qPAPWe/HbFJ1UIqMaTPgDhgrVQbyWS66Hyuv7hKCgjzffsLVwo7/O8WUrY6nMLMa++TbYBX3d2H7dd0fTCnYImGpFGkNKMLppV0MQ1ZKPRLwmTwYQQ7MiLYiTSlN34/Hm5Jzd+gew9e/eBu25mflWt9RtFXqWS4lTOtHxjWurTwjeY4+FuzCwXL71UaoF5C8UvlvNjiBiQ9p5S94jY9hfMtVl5qT6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvpO9mqZWxxryhGA2WVHRNcJiCsxNAc1D6Wyw8jxBDA=;
 b=N9k5jJvnJ2cYs6nr8qQ1UgaqSvWHB0fSvKgtMu+zlZJYRkp81MU4hLa+/53Me9+6o4GNdblHWLrXH0kd9BSep7DcFNyrANk+VRFs2vTN+KdeTixLAOtMOApuNlou0H1IDvsblEcaJ8exat2gKcGPy6mJd3EjTuWHtVwCjL+YRNC17DV+1vD2/wZJM4TZHAxxq7XA0wjHE07/BpOPFBZJrgJseUy1RbWlLxmCi4+WIj8y/SUtRJpslBhg4M11GAUbwpC3T1WWvrOu3U931A0qnTBqZF0JCz+fJ2Duxtjcez+EDHc5R/pZzBfrDeBmILHjf33EFkH35fOq67O41DC9YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB5029.namprd15.prod.outlook.com (2603:10b6:806:1d8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 17:30:13 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ede3:677f:b85c:ac29]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ede3:677f:b85c:ac29%4]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 17:30:13 +0000
Message-ID: <90f4f434-4be6-e2e0-ae91-b23fd58201fc@fb.com>
Date:   Mon, 10 Jan 2022 09:30:09 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH RFC bpf-next v1 0/8] Pinning bpf objects outside bpffs
Content-Language: en-US
To:     Hao Luo <haoluo@google.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, <bpf@vger.kernel.org>
References: <20220106215059.2308931-1-haoluo@google.com>
 <86203252-0c97-8085-f56f-ea8fe7f0b9dd@fb.com>
 <CA+khW7jiDgdFz3Wty0=ajkaiLpAyYu8-9jnZXqT2sF45Y4rb9Q@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CA+khW7jiDgdFz3Wty0=ajkaiLpAyYu8-9jnZXqT2sF45Y4rb9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:303:b9::7) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5adb5fe-1328-4bd8-0b0d-08d9d45edbb7
X-MS-TrafficTypeDiagnostic: SA1PR15MB5029:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB5029564069975583031E5B29D3509@SA1PR15MB5029.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dxZQsQw9ZMDhu8kgVkx8Nt7vzDZ6ZUyFSppQUP27OfU111ITD9R2yqR6BfgdT+kNDA3Wz9IAI8Q1do93Oeiekb+PNpX/LtqmkB0pF4xKKuobUO6FJ14QnY7E8kMCYBUYn9ZDPj3KJHbVThC29+M5m/pImjP2HOPlKefgY1AU6YY5UqlUPCjK6dYzvC6dTiGUdkot4nABKpJPgnXKxb6g6a0KfOf+jsZs+M1Am24vnr3Hj7M++OpKxgxkZp1zrM31AcS6Rc4Gvs69cJdB5HO1jq9eaQRM6YGpTLpBvcNPndH+BPfFLHmqK8+4+w9QjC664XD2dUgvKUqnZObJR8/TsWXp/U6/l6zyDHE4j3H8iq2BKKj4tztPCRk0mdzlgijEgTUWUyrFZsdiLUOgVqMVvsS5KeiuvaVjkAVHkHJTNE92atlvDs9e6ySi07ut6WQpzYOi+hINVJgVzx0TNT2zcXGDME/MR//7SU9z/cBz4JsaxygrUXpauAhIFpwZBXWD+3up+K8VP/eTJ+2HoqN9bOwyo5JGzn0Q3djtdKrQsnqR/S99cRCH0397dionawvm5l7oe0ea0h9+CDHuJqlZlwuHWQQZL4TwHBX9QxOq+3FJ0jxBn2KEQKKk6sEQpRpKWBSVo40iuKCvKgNzVXrpFVzXy69tcLcTkTR1Rl4QE0f7YQtH/0snNAFUDIHH0qYFrEgRR5YBh9JQVhzS+9QWzr6mQ1fzwMa/A33K30YozLY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(53546011)(4326008)(6486002)(2616005)(2906002)(31696002)(8676002)(86362001)(6512007)(186003)(6916009)(66556008)(66476007)(8936002)(6666004)(5660300002)(52116002)(38100700002)(36756003)(316002)(54906003)(31686004)(508600001)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUd1dHhsdm1NTGN4SnNFYmN2bUl1WUhYcUN6TWRIV0NqUEhVSmJETjF3VEJl?=
 =?utf-8?B?RnNJYnFvSWZRVmIrNS9oVUJrNkxFVVN1WEo5VkV2VElIZXQ3WUppRlFoaHdI?=
 =?utf-8?B?RXBDalJRR0lMa3B1Rm1aMzVkUDJqVGlGTUVEaW9aK1plS045NFQxbWVycDVO?=
 =?utf-8?B?MTcxWGl6UjNEUlJCOWN6cDVvd1lwdG5GejdOUWx6eGNReHJleVFWUWhnNzJl?=
 =?utf-8?B?QW5QcmJDd3E5UFBXbXNWWEVHVmdnNDdyQjdJNlNuTDJvQUdFbkJlUEhKZmhS?=
 =?utf-8?B?SXFXVGpxR1hJWnRTSTJhS09JQVRpTkFZKzYzTHo2S1hBaGU0RGpoQktXQ2Jp?=
 =?utf-8?B?L2puZzBLeml0VllkaGJ5RnZ3Z2V4a0RPdVA1UGJFaGRhVTB4U3lWYlhRUGVs?=
 =?utf-8?B?aUNSQmN3TnVaaXh5SDVaZ0JObm9lRm1GN2VYOERmcnp0OWQrSmxkSUI0NFRG?=
 =?utf-8?B?aGxNY0tYdllvTTNXVXFmUlRkV3Ftd2kzd053OFU1NlhNZW5GQk1mRE9MWmI3?=
 =?utf-8?B?cmR5YjAvbGFHaHdQR09xUXQ0UC9mSlR2TEhBbFNUWFJXdmNvS3F6Mk00TlQw?=
 =?utf-8?B?SWpVZEdNMnV5aEFNa1RXd1YxSGNtSVBQR0hZY1ZHUTVxV09vaGpkTnhBL0g1?=
 =?utf-8?B?d0pPL1M5S29lVXgxeitBZWhWZ1JtVVQ2VTZQcC90TTcxUW4xL1JlbWtIaDF5?=
 =?utf-8?B?SE00YjAyYm01VWN2cmVGN2o5L2lreXR4V0NiejJFc0YrWUVoTU9OZWtUeVE0?=
 =?utf-8?B?S3cySUlzWUkxd1VmRXZiN3RGNnQvQTRacVhMT0xiRFNFYlBWRDhZU1lEQWF5?=
 =?utf-8?B?eE9XQnl5SC95eEVmY3AvMytnT3VCelJKZEtGRThQVXJDQ2lITXMyN0d1S1Er?=
 =?utf-8?B?TzF1bm1CY3NJWEl2NW9mZzgzUXlHRXVvY1g3THl1UU5mWGs1YjhuVm5aUE40?=
 =?utf-8?B?Y1FPYzF6TVhiQk9TMmFMWFJnSHZRWDZ0RHBWWXozZUsvWmYvNEJsNmdseWw4?=
 =?utf-8?B?TDg4bndjYmNaczBPKytvZ1NHM0h5Ynk3TEttWXhRUzg3WDFlRnI2Ykw3LzRy?=
 =?utf-8?B?VTU3UWFSWUozejZqbTZkVklIa2tBOXZ6TkhKMytjRTZpaExMMmQxa1hTcFVR?=
 =?utf-8?B?c3ZicTF4bWRqN3hCdmFkTlgwT3dEb0NCYWszbVVDaTJlMkhhNXhnUkFhNlk0?=
 =?utf-8?B?eGtSQ0drWTlyaFc2QWErWWtmc1NwbGNFTXYwa1dYY1VnUXk3azM0ZlI0N2k4?=
 =?utf-8?B?anQrN252MEtRSWlXSGdkcHJiZXF6anY3ak9uZUJRSjFDMWVhUUF1TWNkT0Vu?=
 =?utf-8?B?Znc2bks4RXQrZEVKY2g4ZlFXRjlUNkJ1SmVVQkJOUVlYZGZBRTI5bzdaaUEw?=
 =?utf-8?B?UThLUWx0TWp2aTlVMHEzbHY0V0dZbTEyUm5Mb0FnUUhlcmppN0VJN0pGa0FO?=
 =?utf-8?B?bVpzMFhMTmtKT2VBM0JTenVzMlZpWlFZQjhUc3ZZNHpvRG5iT3BKUjVSSzRR?=
 =?utf-8?B?QzdPNithMHRBaFFMMWV0a2ZjQ2oyTzdVck9nQTZ3VGRnOGZUdG1UNHk3dnBI?=
 =?utf-8?B?bzlRdnkyS0RXUit1ZHNkVFkyNzRFU0FLcllwditvVStmYzQzeURHc3g3MTlG?=
 =?utf-8?B?TEIyZ2dodnZrZGtlNjFWSUxJOFU1K2tuVlN0QS9yS1AvSHNyeFBxSzAzK2U5?=
 =?utf-8?B?bkFkMDlBMDZ3elJHTGdMNHFlNGw0N3NaOTJicVRUM3ZvUGIrQ1hpY0ZjaEJo?=
 =?utf-8?B?WG8zMThGMmF5UElxYXFPWkZ3VkRyZ1Y5ZUE1LzZYWXFJWEZ5dFB4bWFjbGpZ?=
 =?utf-8?B?bXdkNW5BZDJMSStXeTM2TWd0c24zYjhUM3FQb3ROSjI2WlpzWGJNUVdiNDhZ?=
 =?utf-8?B?Um8vdWtmUVdoY3RrM0o2ZmJ6ZGEreXVsMVg2ZjFFcFYyWlZ2Z1Y2NGZGMmdS?=
 =?utf-8?B?ZUtBUXVsMVB5YnhpNGNDbjU5cFFkd0JWRTFvNTg0aWlNYzE4QXk4N3Y4Ykt1?=
 =?utf-8?B?MEhHT1VrTDhiWnFZYnZRK3cycVUrTnVkUGtyVnc1K2FFaGNsSkV4d2hsK213?=
 =?utf-8?B?TjhHRFJDUjA1Z2RONnJ4M09SZjFYblhpWHZaOG1uSlNWVXhwQmFWRnZFbHdl?=
 =?utf-8?Q?0QN+j11aExDu/olCjLOG0J+qy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5adb5fe-1328-4bd8-0b0d-08d9d45edbb7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 17:30:13.0356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdzvNUmaBdE74695VcTk2Ul/s852whR0a41AJEaKuBtIpyjLeeR8nFrUPj61taF/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5029
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: A8BFVHURiUHaEj5QB12dRSIX4M5g4QKU
X-Proofpoint-ORIG-GUID: A8BFVHURiUHaEj5QB12dRSIX4M5g4QKU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-10_07,2022-01-10_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201100119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/7/22 12:43 PM, Hao Luo wrote:
> On Thu, Jan 6, 2022 at 4:30 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 1/6/22 1:50 PM, Hao Luo wrote:
>>> Bpffs is a pseudo file system that persists bpf objects. Previously
>>> bpf objects can only be pinned in bpffs, this patchset extends pinning
>>> to allow bpf objects to be pinned (or exposed) to other file systems.
>>>
>>> In particular, this patchset allows pinning bpf objects in kernfs. This
>>> creates a new file entry in the kernfs file system and the created file
>>> is able to reference the bpf object. By doing so, bpf can be used to
>>> customize the file's operations, such as seq_show.
>>>
>>> As a concrete usecase of this feature, this patchset introduces a
>>> simple new program type called 'bpf_view', which can be used to format
>>> a seq file by a kernel object's state. By pinning a bpf_view program
>>> into a cgroup directory, userspace is able to read the cgroup's state
>>> from file in a format defined by the bpf program.
>>>
>>> Different from bpffs, kernfs doesn't have a callback when a kernfs node
>>> is freed, which is problem if we allow the kernfs node to hold an extra
>>> reference of the bpf object, because there is no chance to dec the
>>> object's refcnt. Therefore the kernfs node created by pinning doesn't
>>> hold reference of the bpf object. The lifetime of the kernfs node
>>> depends on the lifetime of the bpf object. Rather than "pinning in
>>> kernfs", it is "exposing to kernfs". We require the bpf object to be
>>> pinned in bpffs first before it can be pinned in kernfs. When the
>>> object is unpinned from bpffs, their kernfs nodes will be removed
>>> automatically. This somehow treats a pinned bpf object as a persistent
>>> "device".
> 
> Thanks Yonghong for the feedback.
> 
>>
>> During our initial discussion for bpf_iter, we even proposed to
>> put cat-able files under /proc/ system. But there are some concerns
>> that /proc/ system holds stable APIs so people can rely on its format
>> etc. Not sure kernfs here has such requirement or not.
>>
>> I understand directly put files in respective target directories
>> (e.g., cgroup) helps. But you can also create directory hierarchy
>> in bpffs. This can make a bunch of cgroup-stat-dumping bpf programs
>> better organized.
>>
> 
> I thought about this. I think the problem is that you need to
> simultaneously manage two hierarchies now. You may have
> synchronization problems in bpffs to deal with. For example, what if
> the target cgroup is being removed while there is an on-going 'cat' on
> the bpf program. I haven't given much thought in this direction. This
> patchset doesn't deal with this problem, because kernfs has already
> handled these synchronizations.

If the file is going to pinned inside /sys/fs/cgroup, which arguably is 
indeed a better place, maybe ask cgroup maintainer's opinion?

> 
>> Also regarding new program type bpf_view, I think we can reuse
>> bpf_iter infrastructure. E.g., we already can customize bpf_iter
>> for a particular map. We can certainly customize bpf_iter targeting
>> a particular cgroup.
>>
> 
> Right, that's what I was thinking. During the bpf office hour when I
> initially proposed the idea, Alexei suggested creating a new program
> type instead of reusing bpf_iter. The reason I remember was that iter
> is for iterating a set of objects. Even for dumping a particular map,
> it is iterating the entries in a map. While what I wanted to achieve
> here is printing for a particular cgroup, not iterating something.
> Maybe, we should reuse the infrastructure of bpf_iter (attach, target
> registration, etc) but having a different prog type? I do copy-pasted
> many code from bpf_iter for bpf_view. I haven't put too much thought
> there as I would like to get feedbacks on the idea in general in this
> first version of RFC.

Sorry I am not aware of this bpf_view discussion. It is okay for me.
But it would be great if we can avoid lots of code duplication.

> 
>>>
>>> We rely on fsnotify to monitor the inode events in bpffs. A new function
>>> bpf_watch_inode() is introduced. It allows registering a callback
>>> function at inode destruction. For the kernfs case, a callback that
>>> removes kernfs node is registered at the destruction of bpffs inodes.
>>> For other file systems such as sockfs, bpf_watch_inode() can monitor the
>>> destruction of sockfs inodes and the created file entry can hold the bpf
>>> object's reference. In this case, it is truly "pinning".
>>>
>>> File operations other than seq_show can also be implemented using bpf.
>>> For example, bpf may be of help for .poll and .mmap in kernfs.
>>>
[...]
