Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B674035C887
	for <lists+bpf@lfdr.de>; Mon, 12 Apr 2021 16:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241888AbhDLOUO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 10:20:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34918 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241047AbhDLOUN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 12 Apr 2021 10:20:13 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CE8167011975;
        Mon, 12 Apr 2021 07:19:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=CpcCSkJqOJUam1qXBESrKYohBHh9ajouo/MX9tZe2SA=;
 b=eoch0643EDNIg17Y4zs38XGwlIuP/y6GhD9dnZzhTMUV+ClC4W4ctUaHhWLKJEpEOfO/
 zfFvr4Hca/pSId8JndaFTuvwbt8mlNjZCrh+hmWcKbBCKqBJA+WGevvc2Oxf8qbLVUKG
 DAJVgJc1xB6pRiQEfYAeee6RkdMNs0FLiSs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37vhtkhnpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Apr 2021 07:19:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Apr 2021 07:19:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HG755uMDdbckAWTplIOhXKepcwRt7nzzLIV5REs++kaxfeV1BoV/alb37gr0qR17qcmq0IL9Efg421U2A/bOqNvoN38R6ULORxvy24JBPUjyxy2xrX9WpWyKKYvqRr+sGf/HUnAHlKtXzH0UhgnMi44ldvyP/kNKd4PtqQ2FtN3DoXjfchlomRg67OhqnJxdr3AKiVjv0YQGHkVnRkBaSAe5cnVnkcNaOGT/E/erY5SDr3JFn07XVCagV5BBJ96EoNIRNzQAJHrabA28nXyElJXgVJW++jv2BLcgB3cBcXqERfWWQbZ7hhAIVx6aIxHQ0zJ+TMnrSAYPAtaA2W8y7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpcCSkJqOJUam1qXBESrKYohBHh9ajouo/MX9tZe2SA=;
 b=KGpipKUdfENHTyu+tVMeBHAoN6dtSdORWAJZ4q0SCfMYq8LvZMNmvkYqMHzyhVemWZQF8r7JT7E+ldMXL3FPUKepkFX+WqnOAwn6090HPZ5u1bCRhdf5n/k//Mn4iY+4GF3GY8scvIFjpGqxIfw2WDmAYfa7FI5C/biEDy9CEQlVlTtfiK30UWimT+8lFymiZq2am9oAsKOVZ899agec8qZO5lvRZCNP0NtLQwep9t4lBFTOPFXxe7bAftALOZNkfm9Tl/RkM4pMifgdkDE3dThu+Jmdrcx6+Dj57SNKaT/N6qCL6oITXrbIl92FOYwioHgNExeWvZX/HvDUQEpfoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Mon, 12 Apr
 2021 14:19:40 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.033; Mon, 12 Apr 2021
 14:19:40 +0000
Subject: Re: [PATCH v4 bpf-next] bpf: add lookup_and_delete_elem support to
 hashtab
To:     Denis Salopek <denis.salopek@sartura.hr>
CC:     <bpf@vger.kernel.org>, <juraj.vijtiuk@sartura.hr>,
        <luka.oreskovic@sartura.hr>, <luka.perkov@sartura.hr>,
        <daniel@iogearbox.net>, <andrii.nakryiko@gmail.com>
References: <YGHOxEIA/k5vG/s5@gmail.com>
 <ce69af50-3667-c52d-1f1a-b924bbe0fc58@fb.com> <YHPtBett3HLzhHNc@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <34014e95-57c3-dbc4-6899-8765f4145cfa@fb.com>
Date:   Mon, 12 Apr 2021 07:19:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <YHPtBett3HLzhHNc@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:42e2]
X-ClientProxiedBy: MW4PR04CA0103.namprd04.prod.outlook.com
 (2603:10b6:303:83::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::110f] (2620:10d:c090:400::5:42e2) by MW4PR04CA0103.namprd04.prod.outlook.com (2603:10b6:303:83::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Mon, 12 Apr 2021 14:19:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c315b830-6d21-4545-6d7c-08d8fdbe029f
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:
X-Microsoft-Antispam-PRVS: <SA1PR15MB44335957DC7C6D0DDBFE2BB5D3709@SA1PR15MB4433.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zzn4bUY12Lc6QKnS2zcplLHGkGjT1vhMEtIgRRNQj6Z4QUNqZGM4KZteBveHwr0H471k/RnhvRvAozz7Mg59wvjEWYfsQSHnZmz0aSLvtxnfc1l3ujT1A/XnnmLXHbpKrqCenm+AqNCoGj8uTlcIrj0w186AFvYEM1NTsxhXw9+rHrQ34V35MjunYY/0LOWdnJfFjWb0dpV7Lwcu4gZr0HEwfBgs5V16wA7AiI32bN7NxFBD/y+3bl0M+hVsScAlp70q2FWOzrQ4KG4YeDKV/XRk2pBfOYWrKpGpYftE72H9u8ptUjjbX6/K7t46Bc6SUFUKuIiV3eDYP1aOtHdFCHhhtmMVzbTB/yraRvupXE8iZreUIHPTPD9eAg2DRNpBL/2T76io5UaeSi2uKlK1Ep66nzM2N4PoO4Xrdzsm8HJScoyV0E/cu0pQcSYjW/Zi/3x/toikwbHZsj041x+ak80QQl+adK29BOjTrtrtB3+gDJDlD6D8Qd4TrOkXifZssfSDrko2GjTHz4ISORct7plADkkdgAORnWhwZxKhogHI7aBqEEGmQjnxgfdCMeyLdUTUkWZ2IFun+3ijsx73oZTQiW1qj82cExdpsl+X0UfI+vhxpxse2KGtH3tor6Udv1tTHVU0Fh7GNWUxVXRz8gnGyXDLwcA127LLyk075nVs/FYeCrG40Yw/CWNZqVtG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(366004)(376002)(396003)(31696002)(36756003)(2906002)(8936002)(8676002)(53546011)(186003)(478600001)(6916009)(31686004)(52116002)(16526019)(5660300002)(66476007)(316002)(4326008)(38100700002)(66946007)(83380400001)(66556008)(86362001)(2616005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N2xnSWF6Y05WbVN2VnR3TFBuL3V6ZGlOT3hnQWlTNlRvS09VRmx4LzFMczc5?=
 =?utf-8?B?c2lCOHZYekZDbHpPTFBoNXFDbjZXRklLRG1Ub1d5N0YrMUdNZThyVlBQUkVl?=
 =?utf-8?B?bHpJSyt1MEdVNCtQbGtHMndNWUswZU1qRXFYaUkwQnplS0ZSZXNrQTVBZExu?=
 =?utf-8?B?OUhYUVI2czdlL2IzbWxWLy9QMDZxRUxLNjhUSHpEZUx4U0pIMmhGRHM1U0Ri?=
 =?utf-8?B?akl3cHlzK085a0kvQnJ6TXZIWnhsS1J0OEFnRHRGVlVyZ1orMWZXL0JOU0FQ?=
 =?utf-8?B?aGhpTlRRMUlvY24vZWJRYW42RHo4QTF0NE9STytENWNEazRvd2JtVkRYMkJh?=
 =?utf-8?B?WWVUSGJxVDYvMlNZVENYdGlJbVhZS3Rycm8rMGpXVXN0U3UvbC9rQ1ExemVv?=
 =?utf-8?B?OFRVSVRTSCs4Z3MwUXZ2UXM1dWlRTWJJWjZWTjhkK2M4YTVDd25tVEV5Wm81?=
 =?utf-8?B?MG5tZkZ4Um9YQTZjdUtCR1M3ekhUSHFjUW1Zazl6NGlyOGliaUtIOHdZZmNX?=
 =?utf-8?B?VWNsSVI3eFBQdzYzT2hVQllTUWtkdEsvUWE3VDFWRU5za0hKQW1HK0diaFJT?=
 =?utf-8?B?UlMzZ1lrSlJNbmp2UlhadUNYQ0dWMTBUVUJKUUlGaGZCbjg5U1dHOUVqaDh3?=
 =?utf-8?B?K3B1bXpmMWNlTVBqRDlzUjVqVStIRGs4bThpdkozSXRHVmhkNG9ZL2VRWjBR?=
 =?utf-8?B?Y2xIcm5CeXVEcnppSUFiTVN4OVF2b3BwNHJYWGVXUlVIbnVva3N6MFRTd0Rw?=
 =?utf-8?B?RDh2N3pKZVNFNE9XT2YzWXRndnRPUmxNUHVHLy9qdE9HWU1YeUZ2RDFwZlNJ?=
 =?utf-8?B?cEZPQTltU1BhZVJhdmJHQmRybTFBZ1JFRkJseFhOTDVWa3dZK21MSEZWd29W?=
 =?utf-8?B?UDZNbncwd3dsS2tjRUwzdHlwdDN0bHlGMWdXcXVXUmVGZDhMcDNEb3dEaG5O?=
 =?utf-8?B?T3BUbUkxMU9UK0JjNDNFd3lCUW1QaEZNeWsrUUpKWGl5ZDF3T2Mrc1JoVG5k?=
 =?utf-8?B?bUlvZlQyWkd2YkdqNzdrM3N5S0RWbTR3cHBqcWtkN2pHQzBBckwwMFBuMytO?=
 =?utf-8?B?di8zN0V2TGNPZ0lkcS9ReVFlQzVSVmcyUENaTC92RlNMeVdkeHVrNnpYNEFC?=
 =?utf-8?B?WDJ3US8xQ2ZKT1ZKRUg2MnQrdGNTMlBoTUFiTTZOaTZidFJjN2JNU0ZPVG9w?=
 =?utf-8?B?WCtXRmh0VStHa0lyUmh3VFNDOEdyVFJMYkIzQnU1THM0UnF4WE9EOGQwS0h0?=
 =?utf-8?B?TlM4U09DWisyRFJ1cGlNVFRla3hGZjBBNmZSOXl4WXE2N3pEY0lwM0p4Qi9i?=
 =?utf-8?B?WGNoeXFzQ3R3OFFIbG1jd3NHUVQ0UEc4TEtsN3FQcVAzSEVFeDBCTzM0TlNK?=
 =?utf-8?B?Yk9UT3p5UHUrbzZQYkNXekJZbFVwNGdaajFuTGxpQzFjbkFFRXBxdEFob2U2?=
 =?utf-8?B?U3NmRW15aG5CWXVrN0N4c0VnalhXNHBJRGUyRjZudGY0MG5sakRpRlpaTUlw?=
 =?utf-8?B?bkVFRnlYT2RWbkFZY3BTMGx1MEtHeE9QR0pEdFB1T1lpN1BRZzdXNEQ5RlpX?=
 =?utf-8?B?U2F2VlRNYjlzRXBlSEFvTTJnTFdmQWRqY2FFZmQraWRVay9mMHRQbXFqY3lN?=
 =?utf-8?B?ZmZTOFB6TithNFpDOUsvSDRGek5zVGxiS29vOFppTW9TNjZxNlVUeUhIOE5S?=
 =?utf-8?B?UGJXWUNDZ1ljaWQ1NHJQWThCbEFjQzl4UWwyMG1YUFhrNnY1TGtuVEY0VnlH?=
 =?utf-8?B?M281NElKbmd4dURiczdKSzFsQ256VTl6bW5JUVNQMTN5dnhMWGpsOFgwNFdz?=
 =?utf-8?Q?0jcvriQMuLTAHmLkU+Wo53OT8/uLlB7U6sYOU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c315b830-6d21-4545-6d7c-08d8fdbe029f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 14:19:40.4400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4cHOEg6Siehfj7ihs0KBtTWwFqFORjClrsSaSqGWlSRVbsEJitDYuur17jOWl6k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4433
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: NzQy53qMilqIIJEyJXts5Hg0t471fbfr
X-Proofpoint-ORIG-GUID: NzQy53qMilqIIJEyJXts5Hg0t471fbfr
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_10:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120097
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/11/21 11:47 PM, Denis Salopek wrote:
> On Sun, Apr 04, 2021 at 09:47:30PM -0700, Yonghong Song wrote:
>>
>>
>> On 3/29/21 5:57 AM, Denis Salopek wrote:
>>> Extend the existing bpf_map_lookup_and_delete_elem() functionality to
>>> hashtab maps, in addition to stacks and queues.
>>> Add bpf_map_lookup_and_delete_elem_flags() libbpf API in order to use
>>> the BPF_F_LOCK flag.
>>> Create a new hashtab bpf_map_ops function that does lookup and deletion
>>> of the element under the same bucket lock and add the created map_ops to
>>> bpf.h.
>>> Add the appropriate test cases to 'maps' and 'lru_map' selftests
>>> accompanied with new test_progs.
>>>
>>> Cc: Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
>>> Cc: Luka Oreskovic <luka.oreskovic@sartura.hr>
>>> Cc: Luka Perkov <luka.perkov@sartura.hr>
>>> Signed-off-by: Denis Salopek <denis.salopek@sartura.hr>
>>> ---
>>> v2: Add functionality for LRU/per-CPU, add test_progs tests.
>>> v3: Add bpf_map_lookup_and_delete_elem_flags() and enable BPF_F_LOCK
>>> flag, change CHECKs to ASSERT_OKs, initialize variables to 0.
>>> v4: Fix the return value for unsupported map types.
>>> ---
>>>    include/linux/bpf.h                           |   2 +
>>>    kernel/bpf/hashtab.c                          |  97 ++++++
>>>    kernel/bpf/syscall.c                          |  27 +-
>>>    tools/lib/bpf/bpf.c                           |  13 +
>>>    tools/lib/bpf/bpf.h                           |   2 +
>>>    tools/lib/bpf/libbpf.map                      |   1 +
>>>    .../bpf/prog_tests/lookup_and_delete.c        | 279 ++++++++++++++++++
>>>    .../bpf/progs/test_lookup_and_delete.c        |  26 ++
>>>    tools/testing/selftests/bpf/test_lru_map.c    |   8 +
>>>    tools/testing/selftests/bpf/test_maps.c       |  19 +-
>>>    10 files changed, 469 insertions(+), 5 deletions(-)
>>>    create mode 100644 tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
>>>    create mode 100644 tools/testing/selftests/bpf/progs/test_lookup_and_delete.c
>>
>> Since another revision is needed, could you break the patch to several
>> commits which will make it easy to review?
>> Patch 1: kernel + uapi header:
>>     include/linux/bpf.h
>>     kernel/bpf/hashtab.c
>>     kernel/bpf/syscall.c
>>     include/uapi/linux/bpf.h and tools/include/uapi/linux/bpf.h (see below)
>> Patch 2: libbpf change
>>     tools/lib/bpf/bpf.{c,h}, libbpf.map
>> Patch 3: selftests/bpf change
>>     tools/testing/selftests/bpf/...
>>
> 
> Sure, I'll do that.
> 
[...]
>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>> index 9603de81811a..e3851bafb603 100644
>>> --- a/kernel/bpf/syscall.c
>>> +++ b/kernel/bpf/syscall.c
>>> @@ -1468,7 +1468,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
>>>    	return err;
>>>    }
>>> -#define BPF_MAP_LOOKUP_AND_DELETE_ELEM_LAST_FIELD value
>>> +#define BPF_MAP_LOOKUP_AND_DELETE_ELEM_LAST_FIELD flags
>>>    static int map_lookup_and_delete_elem(union bpf_attr *attr)
>>>    {
>>> @@ -1484,6 +1484,9 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
>>>    	if (CHECK_ATTR(BPF_MAP_LOOKUP_AND_DELETE_ELEM))
>>>    		return -EINVAL;
>>> +	if (attr->flags & ~BPF_F_LOCK)
>>> +		return -EINVAL; > +
>>>    	f = fdget(ufd);
>>>    	map = __bpf_map_get(f);
>>>    	if (IS_ERR(map))
>>> @@ -1494,24 +1497,40 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
>>>    		goto err_put;
>>>    	}
>>
>> Previously, for QUEUE and STACK map, flags are not allowed, and libbpf
>> sets it as 0. Let us enforce attr->flags with 0 here for QUEUE and STACK.
>>
> 
> Ok, so just to make this clear: if map_type is QUEUE or STACK, and if
> attr->flags != 0, return -EINVAL?

Yes.

> 
>>> +	if ((attr->flags & BPF_F_LOCK) &&
>>> +	    !map_value_has_spin_lock(map)) {
>>> +		err = -EINVAL;
>>> +		goto err_put;
>>> +	}
>>> +
>>>    	key = __bpf_copy_key(ukey, map->key_size);
>>>    	if (IS_ERR(key)) {
>>>    		err = PTR_ERR(key);
>>>    		goto err_put;
>>>    	}
>>> -	value_size = map->value_size;
>>> +	value_size = bpf_map_value_size(map);
>>>    	err = -ENOMEM;
>>>    	value = kmalloc(value_size, GFP_USER | __GFP_NOWARN);
>>>    	if (!value)
>>>    		goto free_key;
>>> +	err = -ENOTSUPP;
>>>    	if (map->map_type == BPF_MAP_TYPE_QUEUE ||
>>>    	    map->map_type == BPF_MAP_TYPE_STACK) {
>>>    		err = map->ops->map_pop_elem(map, value);
>>> -	} else {
>>> -		err = -ENOTSUPP;
>>> +	} else if (map->map_type == BPF_MAP_TYPE_HASH ||
>>> +		   map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
>>> +		   map->map_type == BPF_MAP_TYPE_LRU_HASH ||
>>> +		   map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
>>
>> Since we added four new map support for lookup_and_delete, we should
>> update documentation in uapi bpf.h.
>>
>> Currently, it is:
>>
>>   * BPF_MAP_LOOKUP_AND_DELETE_ELEM
>>   *      Description
>>   *              Look up an element with the given *key* in the map referred
>> to
>>   *              by the file descriptor *fd*, and if found, delete the
>> element.
>>   *
>>   *              The **BPF_MAP_TYPE_QUEUE** and **BPF_MAP_TYPE_STACK** map
>> types
>>   *              implement this command as a "pop" operation, deleting the
>> top
>>   *              element rather than one corresponding to *key*.
>>   *              The *key* and *key_len* parameters should be zeroed when
>>   *              issuing this operation for these map types.
>>   *
>>   *              This command is only valid for the following map types:
>>   *              * **BPF_MAP_TYPE_QUEUE**
>>   *              * **BPF_MAP_TYPE_STACK**
>>   *
>>   *      Return
>>   *              Returns zero on success. On error, -1 is returned and
>> *errno*
>>   *              is set appropriately.
>>
>> Please remember to sync updated linux/include/uapi/linux/bpf.h to
>> linux/tools/include/uapi/linux/bpf.h.
>>
> 
> The description looks ok to me as it is, I should just extend the list
> of valid map types and add the description for the flags argument (needs
> to be 0 for QUEUE and STACK, can be BPF_F_LOCK for rest)?

Yes.

> 
>>> +		if (!bpf_map_is_dev_bound(map)) {
>>> +			bpf_disable_instrumentation();
>>> +			rcu_read_lock();
>>> +			err = map->ops->map_lookup_and_delete_elem(map, key, value, attr->flags);
>>> +			rcu_read_unlock();
>>> +			bpf_enable_instrumentation();
>>> +		}
>>>    	}
>>>    	if (err)
[...]
