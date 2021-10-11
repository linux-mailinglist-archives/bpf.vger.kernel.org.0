Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8774291FF
	for <lists+bpf@lfdr.de>; Mon, 11 Oct 2021 16:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbhJKOif (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Oct 2021 10:38:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30010 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237679AbhJKOie (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 Oct 2021 10:38:34 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19B9us8a006120;
        Mon, 11 Oct 2021 07:36:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=+F/i//Xu+HBNDjBiDluGbjXZeMwVEfEe5h6rFq5ExPA=;
 b=iXkXyMH1g0T3FizjuKUorXSyCLbYCLF0SiNxWs0JaO5T+QKchMmNTqDD9AXhoy6B7nmt
 XYRuKXP5Idh58K+8+qo6xd6MAms5rvz3CjW/bg8zQXUGXoAGgJYBbhAT29BdoN6dItNH
 SLGaDlmKN0Ks6T7NhRXuuUDYCOegSfDeh3M= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bmk331shh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 11 Oct 2021 07:36:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 11 Oct 2021 07:36:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tuu5ScZiTvMIR55AQ3STYd1edxmR+gMC9O0DQh61PogKhLMF5lesRluw9gDupar/bPV982pktQOCCi2IJEH8zhqrBfUbtW1+azKSa0UqgXT+NUScV3L7pVaJ8PkGvqAlNheXB2uuEva86q/0qlYqr/jBScEk5/Uz/6eRi8AHeTihmrB80tAtwxOmR+YkEC6KLdxfngZ58ukJ0IYnzCFm63wnARhlNX18acFP8shINpClo04bYFWzWW6JBbdnSqfp/loXWyh3bVRAOWlitOV+KAKWxONBjzh5q4fR0HOYgnIzv5my2vF262BWPi8+5Mzsp14Fib8sMuxmyg3kCQ4HjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URyxxsmvQQcW2150En5G8DoYTcTc5aVj3V6oOxAO87w=;
 b=VZKSh9MDp2G4FSpBBO72vTPaL+NjUee6fXYfEP8zSFLU8TDyp4LIiyxNH3ueXkly35/z/i8sW6VKszd4MTPZUPJuLUezhmjYAWpNkCumWsTLa6rTFBTnZfcGxuPP0GUnuqgciP+SJ97SLiKWD84p5r+JEf74IOW+PT+DewgPfJ/AMjwhokPRC11qpPKfsoMUvwJUv3n0QBPDRoYrOVFHRLm3lrUwffuzuwCgtGzLWX36Jy6d1HiwyYuokm7D5jZNuhaNrqcTRkH8scxErKPj0JdcqovnfGQWWIv+zKYiTvvrA67b8uKcAyPt9DAqIhofJ0+gAZ0ZX3T0Bx6XbPzGEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4872.namprd15.prod.outlook.com (2603:10b6:806:1d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Mon, 11 Oct
 2021 14:36:19 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 14:36:19 +0000
Subject: Re: [PATCH bpf-next] bpf: rename BTF_KIND_TAG to BTF_KIND_DECL_TAG
To:     Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <kernel-team@fb.com>
References: <20211011040608.3031468-1-yhs@fb.com>
 <c91ece3f-ec7e-bd3c-9b3d-19952b2d21e7@iogearbox.net>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <000833c6-a7e6-3f45-9895-cf3fb5865807@fb.com>
Date:   Mon, 11 Oct 2021 07:36:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <c91ece3f-ec7e-bd3c-9b3d-19952b2d21e7@iogearbox.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: MWHPR15CA0060.namprd15.prod.outlook.com
 (2603:10b6:301:4c::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Received: from [IPv6:2620:10d:c085:21c8::1051] (2620:10d:c090:400::5:7f41) by MWHPR15CA0060.namprd15.prod.outlook.com (2603:10b6:301:4c::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 14:36:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e843183-e118-4284-604e-08d98cc47d18
X-MS-TrafficTypeDiagnostic: SA1PR15MB4872:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB48726685067AE6B349772A03D3B59@SA1PR15MB4872.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hMKHa8Q9s/UViHrY3pAd/WLPi4InASXogajAq2kibzubrAhm6kE9y9EHzhlH9txNSWTameurnUxOhuE6FBFEK/Q5uu4E5XAdMiI3d1et7xQLVOTOwHmGrtIADeE6zVO/7PLZBmizQUcGNr9NOhG9qlenXD7PXRVc0d8t3CrLsE5HX94c/QiZnwQKYUv3jkgae9siRs/crjq7ChD1BANCUnLYyJnrGqCCam5ISkmaQz5fKJ/BfaXsiOF4C4T2YRk2gaHMyk7YtWnMkSyEvtl97fsJFRgoWaAKGi/YUygIe/QgbJgShp4buuOJnvvo7u2fTkLkSE7MuI6QvUiYqIMZvZOd0Icwi1KmgH70qpb3YQEohhiYtgD0YxpaI197dO2yWww/fVwF2vNSo8aD3asDags4jBSAUt7EG9qaKx2vgVAO1lU29DVVRq+u4HF3UMps9TeWtCNU2OzDQ4lVF7i3PpGxAiCYI/e0ax8oI4Cs80vaVdF05ljw1tOUjq7s6vVKRLTEe4VX3zX/rFfvzXnEF4jC1rnncHL9oE2KzxtaahzQLFeTggykrGQFGBXlNYP3Trt+T0NzJGWUZLAhOG07sdPxiSGlnh5fsfUPNV6cTH6M9IvqkIqPRRKs7knRbvNiVN+n9pPVZIuksMOW/ZAeBkfVrF4yxY+7uEUimPT3NgvJxjgJYaol7IwQKmYElvuN49GeFvJ0Ao8lPPK8MdHm0iam50QLKcptYPl9J5zCfDAWfvXNlwXu9qb84Q13fjhJAmT+jO2EsS1jce9ITNfoKGkWIDs1Cjq1VV9iAN6GRqzPZpKUf90nNyZSaRMg9KaUgJq+RXk3bKjgHJmJQG95fp5iYmOrQ34rKWi+G+cYcUE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(5660300002)(54906003)(316002)(31696002)(31686004)(2906002)(38100700002)(6486002)(52116002)(53546011)(36756003)(8676002)(8936002)(66946007)(4326008)(66476007)(2616005)(66556008)(966005)(508600001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akpsK0U0ODU1dzk4WlF4OW1lZStwanlWckxZRjUvUnlUYWFnb2k0SGhPUnZq?=
 =?utf-8?B?elo2c1I1QVR4UlZGZWc3T3orOEtBOWM0dkRFL1hteUg5Y1RCVVl1bU5taGF1?=
 =?utf-8?B?WmhnbmdhbVpHNjlNM25iNW1veCtsR3lMTG8wVjlab2lVcEpFTSsydVRZQjF4?=
 =?utf-8?B?M2tpVDRVNU92MWJqcFlLTmg3U2dlZnJHelZxZGF4a0tkSWN4TWZ3WWdGeXRL?=
 =?utf-8?B?d3hIcEQwQ2toYlpaTmRubTZZOXNTMEw3Q2JlOEtnL2k1QVUvYktxeFRESFVW?=
 =?utf-8?B?WktuREhCVU4rTDFTVU1yK2E3UFk4eFFKeC9xdFFBNWpyVnRJMDZ0SU5pWEh1?=
 =?utf-8?B?ektsVWRqWi9VaW10MEQwZUlJTjM4blZTR3RTb2RFVk4xWU9UT1kwL0lmWVdK?=
 =?utf-8?B?UEg0L3hRMWIzeEE3YkJaR2JSY3ZqOHNwNG5PaFJ4TTVwbWtwcXAxckZ5eHZB?=
 =?utf-8?B?R3dLaXJJNndqUDhrWnpVUnl4TUp0ZHN6UGR2TFZmaUNVcmpya1RYbnJVT1Mv?=
 =?utf-8?B?MllrTUdKQjdxS3FROTlqKzZOVCtQNnhKNGtYOEowTWVLK2xJU2NnVklQQ1pE?=
 =?utf-8?B?a2hQbjRRNXl2WlNDLzJ2a3JhcVQrSmZNZGVCSGNnUklXNlRxczVMWnFYaWxW?=
 =?utf-8?B?MStzQ2lNYklKUCs0YXc2MTA2SWQ3eTlRM29JWVcya29LcDFEcnByRjdNbHht?=
 =?utf-8?B?dGJGdU5qOWVOTkVHdzRRbkFEbVA1M0d5M1Jkc3o4TzBoSHMrRWp2VmFzV0hw?=
 =?utf-8?B?TXZOZDh4THhJQWNEbUlqR2tkNFNsNDVwOWRqdGhZNDM2RDErNEU2TUFqcVdM?=
 =?utf-8?B?cTVkNE1JckFNTXpkWTZYdEtjUVo0cGEyd3RTT2ZVY2t5dHFGOG9wVFdkdUx4?=
 =?utf-8?B?QUFFaVNoWEJVbzFoTi9LNXVYRHk0U0xST3pXUk9EUkR6c1d4SjRQNDNJWXpK?=
 =?utf-8?B?cWMzaTBPN3VucnF4VDEyM0RobkJadEZaeVkxR3laYURXOWpIS2FvYkljQUVP?=
 =?utf-8?B?ODNlWm03QXplYnJ4ZUhtUG9zUmxBdXNVUldxckU4SEc1T3lDZUM1anIvSlNp?=
 =?utf-8?B?WEIxd1pZL2ZmaUNKNDZTWjlMcGlEcVVxTHVtWFM0bkI1U0NVR2IvSjNtSFV4?=
 =?utf-8?B?VExrSFd0TVJJVnNMODRxZ2NvcWJNdkhtYnlWa2l5ak51R01ZV0NtZVlxMVBv?=
 =?utf-8?B?bEJPVUx1aTZJTUNxZytOemFmZFBpUFJNdGQ5ZDhCQW5DSzFVVm9KYTVCekxL?=
 =?utf-8?B?cXE1QVk3dkgvejJ5SUZxSnVXdDI0aDBIYndUdG43V0JsRUVsWjhvUXRGeG11?=
 =?utf-8?B?eXkwNHIvcjdDZ2dYS0RQL0tsZ1lMWDY2RjRUeTYrTXQveWo0dFdFNkxVZlE2?=
 =?utf-8?B?STliMzJWSnRVM3BReXp1OHhpU0hwQ1ljTTljaHRacmVzRnNrNWhmcVp3N2NW?=
 =?utf-8?B?MlVBVDFHTnMvVFR5R0hVb2lKWkVON0hJbmJlcUo5ZUZlNXJFMVJjQThJYzFD?=
 =?utf-8?B?blUvb0cxNFMyTGlqS1duK2h2SjR6R1V2UzVkSDFvaGVFZXZNTmVTQ3ZuanJP?=
 =?utf-8?B?bWkrVUlVTzVUd0tVelRWbENQcDRvWUJjWlp4SEhyY3dna0RmVXRndWVEV2tu?=
 =?utf-8?B?MmxXZklJY0txbUVMTWczWkIzdXVpQjRXVFpIWVR0VkZpNnp3RHd1UGV5OFlT?=
 =?utf-8?B?TERzU1FKTlcrd245amFCcFF4M2Q1NGZxdE9LS3NLWEhGSHFIQ201QUZLNHdz?=
 =?utf-8?B?NjhRMjJGOEJjYytGYUJSbHRLSDU0SDFYV3pSR2JRbFlWTUl6TE51T0hwOWtE?=
 =?utf-8?B?M1NuYjVyMndEVWpBTGROdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e843183-e118-4284-604e-08d98cc47d18
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 14:36:19.1133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGjpfaIC9Ez6AifSPJXQOWDar2HdrrdTgxnhBTwA8qIVEonQSCLrST2UR3uK46wW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4872
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 3YQgjc4qWHIvRz2bCQ6U0865qMv_rNSh
X-Proofpoint-GUID: 3YQgjc4qWHIvRz2bCQ6U0865qMv_rNSh
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-11_05,2021-10-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=853 spamscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110110085
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/11/21 7:25 AM, Daniel Borkmann wrote:
> On 10/11/21 6:06 AM, Yonghong Song wrote:
>> Patch set [1] introduced BTF_KIND_TAG to allow tagging
>> declarations for struct/union, struct/union field, var, func
>> and func arguments and these tags will be encoded into
>> dwarf. They are also encoded to btf by llvm for the bpf target.
>>
>> After BTF_KIND_TAG is introduced, we intended to use it
>> for kernel __user attributes. But kernel __user is actually
>> a type attribute. Upstream and internal discussion showed
>> it is not a good idea to mix declaration attribute and
>> type attribute. So we proposed to introduce btf_type_tag
>> as a type attribute and existing btf_tag renamed to
>> btf_decl_tag ([2]).
>>
>> This patch renamed BTF_KIND_TAG to BTF_KIND_DECL_TAG and some
>> other declarations with *_tag to *_decl_tag to make it clear
>> the tag is for declaration. In the future, BTF_KIND_TYPE_TAG
>> might be introduced per [2].
>>
>>   [1] https://lore.kernel.org/bpf/20210914223004.244411-1-yhs@fb.com/
>>   [2] 
>> https://reviews.llvm.org/D111199 
>>
> 
> Just a small nit: no objections to the rename as its only in bpf-next, but
> lets add proper Fixes tags to the three main commits from the series in [1]
> (which adds it to core, libbpf, bpftool). Given these are in bpf-next, the
> commit shas are more useful for searching in the git log compared to links
> to lore in this case. Thanks!

Thanks for suggestion. Make sense to add fix tags. Will send v2.

> 
>> Signed-off-by: Yonghong Song <yhs@fb.com>
