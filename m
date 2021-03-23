Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAA6345452
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 01:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhCWA6Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 20:58:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63610 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230186AbhCWA6M (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Mar 2021 20:58:12 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12N0gvWv029223;
        Mon, 22 Mar 2021 17:57:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=dQqcimOop9oxBYtNu6N/yjKsUl8FUu+mAyZVoG6GhGg=;
 b=q3JnH0Ll7yMZMEJsGcBBdfQG0uuu609a8qoV0NDG/MEYrA2ewW44ns2jehnY4ZU8+jvD
 riX/z7I6WEUSeB/BtfZGTri00hmaqi74oNSIaGv6RCTyv4YTQZTW+KIauitTWwnODw88
 Pi0Eio8T11HlGrkN5H8INKNnBNQpIA6/Ahg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37e0rhgthq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Mar 2021 17:57:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 22 Mar 2021 17:57:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXK0f6AJsv54JOenBIAvqMtGuYXviNnwV3Wwhu1EnyAv8cNC7V4EceIzn4sx/Vum8HomyUbMwo4keHHEKpfRrLk4jwxUa81XhX80baMArMIkvqCDyZjaIG4ircKiG4QAnqnJaTmtg6/dQftqALg4xFLVbGV20cevWQEQcrERD4gAsnVHKDge0+17jybwGaqOGtKj04uTFLxJWiw7RgCUOq3WwO9OpI4MHUurV3BqbIvjjYrciyGtVls7TbELxtIZ/FrNinp9Uw5aSaJ5LAb+CouVXu+5XPyfTo0p2ouM82pQTFrRyGKKiEQsDoB6kOsemeGji+BAO29u7NSR5KgSOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQqcimOop9oxBYtNu6N/yjKsUl8FUu+mAyZVoG6GhGg=;
 b=XujuysPNezeVp8DHzHavOal/j5iEJmmddS1L+ZwM8fZv/hFCW+m9OF2lG1nDuxKzPSwcotz0df0nVY2zDBxNLJrvkBDpBWB71aM7CzfZhtl71htVg60AzdTvQsm9mA3FZgDDnrL5DpS/NtB2Ssf+qxNlpp4R7foMJPZQQw7gzJpqTktRpktvlaJ6B1LewVXlAfwACAaHNjzr1eUREr7g4w272oo2KFHERWOh6rczmohb7zvxpZRxcNxLWpflQD0MHxNMVIW78XigKPj0pfcFAzNMDEzfesAZ6e0Tq77mPNfasFuna9x6n8Gc7FlRbPMcXg5h9e34/Oxw1jSBlBR76g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB1968.namprd15.prod.outlook.com (2603:10b6:805:e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Tue, 23 Mar
 2021 00:57:55 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 00:57:55 +0000
Subject: Re: [PATCH bpf-next v3] bpf: fix NULL pointer dereference in
 bpf_get_local_storage() helper
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Jiri Olsa <jolsa@kernel.org>, Roman Gushchin <guro@fb.com>
References: <20210320170201.698472-1-yhs@fb.com> <YFkCRY+HBvOYj1Y0@krava>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <f2d2b206-07aa-7043-9a0c-ef0a3c3d945f@fb.com>
Date:   Mon, 22 Mar 2021 17:57:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <YFkCRY+HBvOYj1Y0@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c091:480::1:fbbb]
X-ClientProxiedBy: BL1PR13CA0241.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::6) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c0a8:11d9::11e9] (2620:10d:c091:480::1:fbbb) by BL1PR13CA0241.namprd13.prod.outlook.com (2603:10b6:208:2ba::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.10 via Frontend Transport; Tue, 23 Mar 2021 00:57:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97a96440-e0be-4375-6bdf-08d8ed96b1c7
X-MS-TrafficTypeDiagnostic: SN6PR1501MB1968:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB19682812CEACDFA9FF9764ADD3649@SN6PR1501MB1968.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VsarcemtfYx4HIw+jcJFq+fB5PNnbHppR3QDsJVpu8k8wuHDNZplSdWdXV5UzYZEkspbNbeF/4WPpiKq7TRWR65hUwqR77wESYLnRjuz6+dXgDUgtDDYjA1xEBupQ0At8pak45AcwqRlI9pY4xA1G2TWSs0Dne/ZXuWIZwXmx2aw5w1TuO5HU6MITl3uYZO7AWdQ3/N9GI2ajrhhLuiA89Oayq7SaCPDuCclrcqCaZNuYN0ywQhfb+fpLWLkMDaElp+4vh0erVmeH7yGi/leXAu204vrPy30cDr9wulCoiiANnXVJhnZUbJXs6qOe1lql8y6O9xTn/svMRBGgvt6iSWk4DckUAY82zu29ps8zyOMVvYucoMcUDHNehfgx7HIghCS3VPSJuIeKI7uXSgm6Nhd5gYVg6zRSFd7btq8P2fbM/mRyHBSiMy5ZoGaiZwD0muLSFfu3mO0yORbPMvqqhMRtJux90NOXsm2Q+zDBm3qhGKF3VhC4kUzqsPE78XjMNYS/t6eL+9qjr9ApskVslRMfdjr1xf2u/urbhW/o5KA8oXRmgmwaeVjYmb0Gmbe0dnDjLxBDI/ZRoUU2aHbefqwEeTmbTvl07vSps2qkt9Hs4daiqYIjRwt38xeiGaA20PxBHq0t++jrep/u8uqjKVHgcaX+D6JxWLZX2CvCZv55UhvYZilgDc6/XwmoMs9GAzOW4pAhB9nOxtfvWnMBbZTU6fw3vTvcKK+2hUFeBym3K/DSHCnlVHvgoe/D/7dTa3OQnr1znwFabKs1CPzya76F01XpgEoOs1R/bi4W4bI/plRE6BwpdB9HHTE1Bx9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(376002)(396003)(8676002)(2616005)(86362001)(316002)(52116002)(6666004)(5660300002)(16526019)(8936002)(186003)(66476007)(6486002)(66946007)(54906003)(38100700001)(66556008)(4326008)(31696002)(83380400001)(36756003)(31686004)(6916009)(478600001)(2906002)(53546011)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eWx1LytQK1hVOWhSaS9qWWhtcW1BK05jeVI2L0VpWjY1L2pyTG55alRGVHJK?=
 =?utf-8?B?WWdlVDZWNktGcGhUMnpLUE9oa2JhcDh2NkdvaTVEK0VWZXpoQzhpY0ljUGZs?=
 =?utf-8?B?WTJLT0hQb1ZCYTdOWHdhWUhITVRtMFgrZjRQRGxYWGpVZk85NHRZbkYzOWJW?=
 =?utf-8?B?bnJzWHIyY09tbTQ0NmpyQjNjdThsYStFUFFPVTNQMnNrWnJWdzN0OEZwdFFR?=
 =?utf-8?B?dDdYVytqVXNHNHJPVk1xVzRJV1lnNWgyV1RTODVaZyt5d3dUZTc0Rm9JYS9m?=
 =?utf-8?B?M293N1habUxNK0JYNUl4RC9kajNoUjJkM1VzUzJ5ZUdCOVlnZkRlaW11OFJh?=
 =?utf-8?B?YnBodGQ2WkYwQnpBMHBKRWd5Y3B1UXRMUU1uc21ITWlMTEJ1dER2elM5RHVa?=
 =?utf-8?B?M0h6RU5neTF2RnFna2t5RDQ5aC9LNW1XeEVYbEhseTNxckRvNFBJWjRodm5r?=
 =?utf-8?B?NWZWVGg2ZDNvUElsaWplL3V5b083V3hkOEdIOFdySjg3aVN4SUJBdzVzUWVj?=
 =?utf-8?B?Rkdjay9RemdwUzliY2N2OWZKakVIUzhxMnBlTjFpajJUT0NRRGxFcDhndjFW?=
 =?utf-8?B?SEJJeXZXYUg3Uzk4Z1Z3ZmdwdXQ3bU4vSGxaYTNWb3Fqbno0TUpCL1RSQlFY?=
 =?utf-8?B?QnRqQTdLbHJIUkQyNGxZZzJrS1FGUWN2a1c1RDNmenp6bUNHaDhHblo5eGwx?=
 =?utf-8?B?a3FGdktZd3ZxT2hhMVhTRDNMUXh3d0VRZENUWFVsMXRJeFk0WWpTZXZmenVs?=
 =?utf-8?B?SW56MDV3dk14UEtSd2hzRHJSYzdZUVdUK2h0d21BSmFPTW5tUlRjU0MxQmt6?=
 =?utf-8?B?SDRnNXk1dHdjTTIybEZ1RUVlQUxManBwdWx0ZG43QncrV3RLbVlJdG1CeVBY?=
 =?utf-8?B?VGVjY01qaVp3VGFLYzI5YVlXVGNzbkh0WEQyQXB5UmNsZldNR2NXamNDN3FK?=
 =?utf-8?B?S1ZvTWV2b045Wi8vbHAxSUE3VUtTM1BvTmdlUDB1Z3pCblpWVGdRQy8yWkps?=
 =?utf-8?B?TTgxRGlDa2dNUGJvTk90Q3c4Z2NtbHdLeWJ3ODl0WVZCSElrVWRmYUNMNzgx?=
 =?utf-8?B?RXBmUUdYUEYyY0Q0b2lGV29nUUF6dXBqbGpjeGI1d0hFNm1WQVdkN1A3WkNH?=
 =?utf-8?B?STVwSldPMmp5YUZPUWthUC8yc1FLUmkrVTBiUUg2cFlUUFFEVGpQNWg5T1ZG?=
 =?utf-8?B?RHBPS2p0MGg2RkpMZnFMQzhVcit1MlJ6Zko5aFhlblYvaVdMM1Nyc3A1VE5P?=
 =?utf-8?B?eUEvdFptaXhTZGovWklQZ2c4K0VBcG0zNm1SWFU4M056Rlo0UDBtQzZSVlV2?=
 =?utf-8?B?STh4MlVCWlF4LzlDaFpQUHpyVnlha1U0UUNKdHVLZ1VCcy9nZ01zTDAwdFEw?=
 =?utf-8?B?K3YvRTM2V3hrQlc1U05RVkRGU0lrL2s3b1NVUFd6S1Z5dmRuRUU2eHpvMmJt?=
 =?utf-8?B?a3JBYzBFZFUyS3crc0h2U1NPWkorVnY5M0lXczc1b2dCSkNjSDNFTUFJczBN?=
 =?utf-8?B?WCtTTUZvazhVTDRGd2Zid2VtQ3Z3MUxhazJMMFVNWmllc2U5NEZpZzBPNEgz?=
 =?utf-8?B?c0hQNmMvaUVoMmxhUkpvUlI1d3M3bGxaRHJWQldMNml1d0pMb29FMGhtQWFx?=
 =?utf-8?B?djZRTlhGalQvSFNOdVlRYis0R3VUUkpwNmx3Q0pqSXJUVVFJbmVNZXFMZkRV?=
 =?utf-8?B?bWpjRXI2eXRaQ2Z1TjE2a3RmaHNrNy9IdkJQZkRyMVJTVVl2VTF1RjluRFlJ?=
 =?utf-8?B?dWROaUFpRnEzWlhEeWlCU05kWDMxbUcvR1BQSTN5VmRxUDc0RFJZTUY2YzNP?=
 =?utf-8?Q?63SwtqaU569A+kTEUDeEStEgBmaxOEVWlsm2M=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a96440-e0be-4375-6bdf-08d8ed96b1c7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 00:57:55.7588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITqagl5eT7jYDxRRpYCRvzbt+/0VYfj7cW6r1f9ADPJV5LIHDG9TOKi6vHwahC/y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB1968
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_12:2021-03-22,2021-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/22/21 1:47 PM, Jiri Olsa wrote:
> On Sat, Mar 20, 2021 at 10:02:01AM -0700, Yonghong Song wrote:
>> Jiri Olsa reported a bug ([1]) in kernel where cgroup local
>> storage pointer may be NULL in bpf_get_local_storage() helper.
>> There are two issues uncovered by this bug:
>>    (1). kprobe or tracepoint prog incorrectly sets cgroup local storage
>>         before prog run,
>>    (2). due to change from preempt_disable to migrate_disable,
>>         preemption is possible and percpu storage might be overwritten
>>         by other tasks.
>>
>> This issue (1) is fixed in [2]. This patch tried to address issue (2).
>> The following shows how things can go wrong:
>>    task 1:   bpf_cgroup_storage_set() for percpu local storage
>>           preemption happens
>>    task 2:   bpf_cgroup_storage_set() for percpu local storage
>>           preemption happens
>>    task 1:   run bpf program
>>
>> task 1 will effectively use the percpu local storage setting by task 2
>> which will be either NULL or incorrect ones.
>>
>> Instead of just one common local storage per cpu, this patch fixed
>> the issue by permitting 8 local storages per cpu and each local
>> storage is identified by a task_struct pointer. This way, we
>> allow at most 8 nested preemption between bpf_cgroup_storage_set()
>> and bpf_cgroup_storage_unset(). The percpu local storage slot
>> is released (calling bpf_cgroup_storage_unset()) by the same task
>> after bpf program finished running.
>> bpf_test_run() is also fixed to use the new bpf_cgroup_storage_set()
>> interface.
>>
>> The patch is tested on top of [2] with reproducer in [1].
>> Without this patch, kernel will emit error in 2-3 minutes.
>> With this patch, after one hour, still no error.
>>
>>   [1] https://lore.kernel.org/bpf/CAKH8qBuXCfUz=w8L+Fj74OaUpbosO29niYwTki7e3Ag044_aww@mail.gmail.com/T
>>   [2] https://lore.kernel.org/bpf/CAKH8qBuXCfUz=w8L+Fj74OaUpbosO29niYwTki7e3Ag044_aww@mail.gmail.com/T
> 
> [1] and [2] are same link, you mean this one, right?
>     05a68ce5fa51 bpf: Don't do bpf_cgroup_storage_set() for kuprobe/tp programs

Thanks for spotting this! Will fix it and submit v4.

> 
> I have troubles to apply this on bpf-next probably because
> of dependencies, I'll wait for bpf-next is in sync with bpf
> fixes.. or would you have a branch pushed out with this?

I do not have a public branch for this. You can do:
   - with latest bpf-next
   - cherry-pick 05a68ce5fa51 bpf: Don't do bpf_cgroup_storage_set() for 
kuprobe/tp programs
   - apply this patch
Then you should be good to go to do a testing. Thanks!

> 
> thanks for the fix,
> jirka
> 
>>
>> Cc: Jiri Olsa <jolsa@kernel.org>
>> Cc: Roman Gushchin <guro@fb.com>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   include/linux/bpf-cgroup.h | 57 ++++++++++++++++++++++++++++++++------
>>   include/linux/bpf.h        | 22 ++++++++++++---
>>   kernel/bpf/helpers.c       | 15 +++++++---
>>   kernel/bpf/local_storage.c |  5 ++--
>>   net/bpf/test_run.c         |  6 +++-
>>   5 files changed, 86 insertions(+), 19 deletions(-)
>>
[...]
