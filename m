Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525713D50D2
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 03:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhGZAVL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Jul 2021 20:21:11 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22920 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230075AbhGZAVK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 25 Jul 2021 20:21:10 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16Q0u4u7010802;
        Sun, 25 Jul 2021 18:01:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=SnSmreY8FlUltzZFz6spjl0isMXLsq496i5M6m1iGt4=;
 b=L55nt/JaQ/Nl8jBLHFPrh2heoTyd3wQroybQKrQm7L47jUCOzuDGhMtu67xjjVJIXQOv
 zvo+3tVpq+FXtVxRD4c+Op2VbCd0BgTA2Tm51qQUhPnaW2QaXu4iRruijVQzrtJHgrUh
 qqoyUe+dttwb+odWLCtpsYTXFa5mrKmVcAo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3a0e6rq1gn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 25 Jul 2021 18:01:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 25 Jul 2021 18:01:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiNBlIkzGG6vpa1/C2FjqOLEwbOFl02eW3+Ym40ttp7yU7SIp7IrKVu8JH4R8fJYOJ4tHLES97tt3Iie1XXBlWv/JowfQa3+DRNXgzIsUbRd/cMZBiw4mgaK5MyTJoi6j7ozOMVQgslVxKaBe3D8Z3THABwoUgyJHWHRSYieCsr/06eaPx0BJk2dqKZ87Rk8DhSiVpMTL9D2efXqmM9hIHrfXB9vdritNVp2vEgb8UXiKCs6JgBVM2gzwP8iScwae8YMkWEE8kETSo0bel5GTfafoAQTukwyk+qyUDb2XGBYmU+g8DyoDbzacP6BugtKRLGca+Qw0U1Rnhd/Rx61Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnSmreY8FlUltzZFz6spjl0isMXLsq496i5M6m1iGt4=;
 b=Nh4nyHDgnBdF3x8auzDqtlGmDKOQLdb23Ef3qPrkUkLmDWlXOPX1U19A2xv12Vdd/O085MlbXMWxWES7ZQRy9YyN89Bthyv69omOd6jEk5UpArRtMvurNO9m4S3ZQegU1tUGt/Jayi2Q0NLhsGBYT95MTNINxookJTX3UGwdq7N3F/0AKkh9Kz4xxhSlpGjOwRWvKnsoxoSNQBd2vpbCFbtKTI4PI1EUBHLS6vh4AdbMLNt5hrXXvRo7xJjCg2z5PER6heQjPWHigSmGDexRz/K/s0GF9CPqWpNnpO7uH3Q8Cy9hUTYWQ6unuY+TPSSoR+fLbPwfJ4laTOxZho/SeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4451.namprd15.prod.outlook.com (2603:10b6:806:196::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 01:01:35 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 01:01:35 +0000
Subject: Re: Prog section rejected: Argument list too long (7)!
To:     Vincent Li <vincent.mc.li@gmail.com>
CC:     <bpf@vger.kernel.org>
References: <a1ae15c8-f43c-c382-a7e0-10d3fedb6a@gmail.com>
 <CAK3+h2z+V1VNiGsNPHsyLZqdTwEsWMF9QnXZT2mi30dkb2xBXA@mail.gmail.com>
 <8af534e8-c327-a76-c4b5-ba2ae882b3ae@gmail.com>
 <7ba1fa1f-be6-1fa2-1877-12f7b707b65@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <441e955a-0e2a-5956-2e91-e1fcaa4622aa@fb.com>
Date:   Sun, 25 Jul 2021 18:01:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <7ba1fa1f-be6-1fa2-1877-12f7b707b65@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: BY5PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::10b9] (2620:10d:c090:400::5:cf4) by BY5PR03CA0004.namprd03.prod.outlook.com (2603:10b6:a03:1e0::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Mon, 26 Jul 2021 01:01:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a462a37f-341e-4e9d-d57d-08d94fd0ea7c
X-MS-TrafficTypeDiagnostic: SA1PR15MB4451:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4451323A62A69556EE372E04D3E89@SA1PR15MB4451.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:321;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CoC7aZOmSOwFeavxyrADrXEkJ4XrYQi3frdhRtOoHg+wMxXLO9ufWapkiaPAd/5rbU4KKhSONJbiRtrnCCvImC0ClACuKYqEaV+yyn6eG3Ai/YeoxFNJORLbXihMXATFCtiljMUEJw0GUmH6mQzdGOWtsyfSCiteRhekfmIGSQvQ8Gss/3UkpHeLpLSqGFUBd540h9F+i6Cmd48pEvx78nHv2OBZSL5/ETJBkD9H8pWQYzxUpHbRMPtOwb1RonNIxS7NjuPbTNRDT880qX/C4QfD9c5I68MCx2fKPawzhwPBS1oVqy/YFWA97mVHtL0sReI35yCzF0UBO0PRlmJD/sw5i/vHiW6fLR65bjYreMH15yT/+bZXVZqdoudz5PBsDlJe6CziIol8OUeUEvFqgJ2i/fxrZWfcUjw9tciamA1FA383ubcGwTcF70CC3KQkmv5qTwvzt3mYpHgCUOH8C99req2YSzmCcLKvQ6WWm+DagOGLMWxhESOCqVDiJf/EhA8hMUUc3CnJ3S2ny67zJi7eiHTPvhTtCWgUmN0a232XGUDUVHA+BZcQjn2OfVXdJxPLHraYO1dC60QHl+nWTUUOpKh8WrHhIpOnvqOICherSQ5lCZUrMUYGpAQjhF9N1nRt4wY1ZED2fOZRtl2CnQtkZq3uyzyf15yIpF2wepVKpA5DePy7sr7QKZuUJdASW74m7s4Bc1VGJtHQRhWTP1fq31UIlHOlGkI1w5+DDwPt7cKTk4KcaK0GUJ3Q9LKcrUvucrfp2PeOPjqXNxzPgZeiHtX5P8rUDP9eXN6AHGKeqqXb8eJ0qHKXYJvLe2xE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(4326008)(53546011)(5660300002)(8936002)(66556008)(66946007)(86362001)(478600001)(31696002)(38100700002)(2906002)(52116002)(2616005)(66476007)(186003)(6486002)(966005)(31686004)(36756003)(316002)(8676002)(83380400001)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0x2WUIyK04ra0FJeXZGK2Zqd0wxT3RhVG9LWlBQK0pyZlR1aW0wR3VCcjJ4?=
 =?utf-8?B?MkxWamhzNlpxQmFEbzg5enBuT1J1Y2RNQlM3eUJaeUt0VEVQNFc5R0NaQWU1?=
 =?utf-8?B?ZkZ5c050RVNCSUZqNXNld1czd2tqbzZaaDd1WGlUV09mbUEyWTlQem9vY2RZ?=
 =?utf-8?B?bmZBZ0xuUis4N0hONWI0UkdvWXNhNmh5Zm5QeWFQRmJmKzc3UFIzZHU4QXZY?=
 =?utf-8?B?N2M5dXArTlQvTUFUL3BuR2cwR1JhZXIvdkdubHM0aWUycE9JaDFVaHlkVGgr?=
 =?utf-8?B?bUJsZFhYMGZheUkxcW1GOVdGWkQ5LzFIdGlVQ09rZTAybG82NGI5MndXTmFW?=
 =?utf-8?B?bitib2c3QkZDc1RqVG1JOThFei9ySkZqWm1Uak8zNERRb2dGZ3ZkUFpTVmI1?=
 =?utf-8?B?bWNZN3dBVEJNSkpUeUNGeWRMUnIvTUdZNFZGaXVjZmhyRFBJeWNwWWxQSUow?=
 =?utf-8?B?MDUyZ0tvNWpxLzg5NTRGeEdLeWxjSEQwQStQNmszTXQ4a0ZYNnV0eW5aN2l6?=
 =?utf-8?B?UlRXek53TFl1MDRvcEwwSExyUlQ3NVBaUUwxMy9PME9xamUxS2k2SWEwcGpP?=
 =?utf-8?B?akFHcmZEckc0ZnlZVnZNbGZCcGhjWEQzSlA1V0FPSFpEY1dPU01ieVlGOXhh?=
 =?utf-8?B?WkIwWlMxTlZldTlBUzVucGhWa0dzb0IzUjNoWTRtZENrZFZPd2M1QWVCVEw3?=
 =?utf-8?B?R2Q4TEhvSHFuSDFBWHVUN1BFTjViYnFWQ0F6bDMzTGc3WS9hWWtmTnJLUW8x?=
 =?utf-8?B?ay9LK0dzcFg5bm85TUtTV0EwOVowKzBBVFJhSWs2cmJKbWV6VHU4UWJLaENT?=
 =?utf-8?B?OFhUczJyTW9FckhrRkZBbEdpZmRWOVNidUVHaTUxK0hRNDQxdWloZml6NWRP?=
 =?utf-8?B?YVVIczUzbGtnUWZiUk9wVmg2SkxqMkhPTm51R1FIQUNPTGZramhzQkFoRThH?=
 =?utf-8?B?L0RzdHN6V2hxSGtjQW9nV2dxTzJldFlCNFdXdS93TFhnQVRJVTk0S0lWUDAz?=
 =?utf-8?B?cU0zK3ZqWDRMSlpZYUtZVE1NZUhsc1FEL05JaWIveUJlOE96eGI2QklqdnM0?=
 =?utf-8?B?VG9NOG9PdllDcjNuU29xcVFNRUh3dllVV2RBYnZyWTZkalRiallPcnJwWTJm?=
 =?utf-8?B?Y2VuU2ZxR0Y1bVFJclBjWXhZeUV0MkM3KzlWdU5mL1FRbWpVcXRpTE5yZUVQ?=
 =?utf-8?B?OUFtMlhyQ1JpbXgrVW9xL0pTL1hDdFZnK3UwWGVQbm5DZ0lNdEduNFZ0Z0Yz?=
 =?utf-8?B?cUJjc2Ywc1FVbEFQS3l5d0V3cmZEdVlXUDRmZGZpU2xPcXhSbHNVTktSb1hX?=
 =?utf-8?B?c3BLUlVab2FrMmhxa09IVTBvM2JmREFnR0FTcXhENitMYitqVjRLeHFDZjN1?=
 =?utf-8?B?akJFMXUyNXI2V25tQnU5aXBsdzA5OHR0dFRMeUFxSUgwZ2ZoWlFpYzBXTS9S?=
 =?utf-8?B?VngrQ25CdXNNSkZ5YWhUaGlCUVgzd3RHNXlJNmFmdHJoNlhUZU5FVE50RVBQ?=
 =?utf-8?B?OEFUdWhVbFZDZndUOVRzWUR2VU5CRVJFb2FoaVAxR29pTVhjdWhGMnVBcW1I?=
 =?utf-8?B?cWhzZ3FlVWF1Z1dCNXNMOUo5c1FqY3NxZnMwNDQ5ZVBoT2FFKzZFSEcxTVAr?=
 =?utf-8?B?cUN2TlMxUXVucGxNT2FTZ1ZwWm9WMUVDalFKMUJjRXdud2RMVDN5OEN0VDMz?=
 =?utf-8?B?b3dNT1NKTmM4WDZRQldqbVo0UEFGM0NDSWlQTGM5WnNhRnhtQktUckQ4blNj?=
 =?utf-8?B?VndyakIxMUpuN0F6cHF5Y3pNdzFoekpnbUg3S3NpSXJhdkxqVUQwQlVSNk9B?=
 =?utf-8?B?MUxGQzVZNmtTSGk0bWFnQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a462a37f-341e-4e9d-d57d-08d94fd0ea7c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 01:01:35.6506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sE/NVJ1YX8zcmkFtDJKDIbxsLVO57F0sBIaLAAbOpUics6VPAIcDTVNbmz+KoYz0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4451
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 7HCLV-6l6FbHqcHPyChJoh1jzpWr4izl
X-Proofpoint-GUID: 7HCLV-6l6FbHqcHPyChJoh1jzpWr4izl
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-25_08:2021-07-23,2021-07-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107260004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/25/21 8:22 AM, Vincent Li wrote:
> 
> 
> 
> On Sat, 24 Jul 2021, Vincent Li wrote:
> 
>>
>>
>> On Sat, 24 Jul 2021, Vincent Li wrote:
>>
>>> On Fri, Jul 23, 2021 at 7:17 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>>>
>>>>
>>>> Hi BPF experts,
>>>>
>>>> I have a cilium PR https://github.com/cilium/cilium/pull/16916 that
>>>> failed to pass verifier in kernel 4.19, the error is like:
>>>>
>>>> level=warning msg="Prog section '2/7' rejected: Argument list too long
>>>> (7)!" subsys=datapath-loader
>>>> level=warning msg=" - Type:         3" subsys=datapath-loader
>>>> level=warning msg=" - Attach Type:  0" subsys=datapath-loader
>>>> level=warning msg=" - Instructions: 4578 (482 over limit)"
>>>> subsys=datapath-loader
>>>> level=warning msg=" - License:      GPL" subsys=datapath-loader
>>>> level=warning subsys=datapath-loader
>>>> level=warning msg="Verifier analysis:" subsys=datapath-loader
>>>> level=warning subsys=datapath-loader
>>>> level=warning msg="Error filling program arrays!" subsys=datapath-loader
>>>> level=warning msg="Unable to load program" subsys=datapath-loader
>>>>
>>>> then I tried to run the PR locally in my dev machine with custom upstream
>>>> kernel version, I narrowed the issue down to between upstream kernel
>>>> version 5.7 and 5.8, in 5.7, it failed with:
>>>
>>> I further narrow it down to between 5.7 and 5.8-rc1 release, but still
>>> no clue which commits in 5.8-rc1 resolved the issue
>>>
>>>>
>>>> level=warning msg="processed 50 insns (limit 1000000) max_states_per_insn
>>>> 0 total_states 1 peak_states 1 mark_read 1" subsys=datapath-loader
>>>> level=warning subsys=datapath-loader
>>>> level=warning msg="Log buffer too small to dump verifier log 16777215
>>>> bytes (9 tries)!" subsys=datapath-loader

The error message is "Log buffer too small to dump verifier log 16777215
bytes (9 tries)!".

Commit 6f8a57ccf8511724e6f48d732cb2940889789ab2 made the default log
much shorter. So it fixed the above log buffer too small issue.

>>>> level=warning msg="Error filling program arrays!" subsys=datapath-loader
>>>> level=warning msg="Unable to load program" subsys=datapath-loader
>>>>
>>>> 5.8 works fine.
>>>>
>>>> What difference between 5.7 and 5.8 to cause this verifier problem, I
>>>> tried to git log v5.7..v5.8 kernel/bpf/verifier, I could not see commits
>>>> that would make the difference with my limited BPF knowledge. Any clue
>>>> would be appreciated!
>>
>> I have git bisected to this commit:
>>
>> # first fixed commit: [6f8a57ccf8511724e6f48d732cb2940889789ab2] bpf: Make
>> verifier log more relevant by default
> 
> both the cilium github PR test and my local dev machine PR test has the
> verbose set, for example, my local test has:
> 
> diff --git a/pkg/datapath/loader/netlink.go
> b/pkg/datapath/loader/netlink.go
> index 381e1fbc8..00015eabc 100644
> --- a/pkg/datapath/loader/netlink.go
> +++ b/pkg/datapath/loader/netlink.go
> @@ -106,7 +106,7 @@ func replaceDatapath(ctx context.Context, ifName,
> objPath, progSec, progDirectio
>                  loaderProg = "tc"
>                  args = []string{"filter", "replace", "dev", ifName,
> progDirection,
>                          "prio", "1", "handle", "1", "bpf", "da", "obj",
> objPath,
> -                       "sec", progSec,
> +                       "sec", progSec, "verbose",
>                  }
>          }
>          cmd = exec.CommandContext(ctx, loaderProg,
> args...).WithFilters(libbpfFixupMsg)
> 
> if I remove the "verbose" change, and run the Cilium agent without
> kernel commit 6f8a57ccf8, the problem is gone, it seems commit 6f8a57ccf8
> is related

Remove "verbose" should work since the kernel won't do logging any more.

> 
>>
>> this commit looks only dealing with log, accidently fixed the PR issue I
>> have? my PR use __bpf_memcpy_builtin() to rewrite the tunnel inner packet
>> destination MAC address, somehow related?
>>

[...]
