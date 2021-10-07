Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06136425F98
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 23:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241529AbhJGWBQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 18:01:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:4504 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241597AbhJGWBP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 Oct 2021 18:01:15 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197KC6nn004237;
        Thu, 7 Oct 2021 14:59:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GrvWJi6z9LCBZTKta4FFM5FbXXLLEv9RSpsVSulBl20=;
 b=aJQdpWXtPmrrsZfbkuUrT1gL6+TLzUpZgm4CWK59UuGEVP/odXlwlzQBReznbnNkIjFt
 L6MGGSyx3Jp2+AKWockyGWiAP44vdZUg8/saVzMqUCDmUE2p2Ngf4mXxbkb7bJ36u6na
 czYpr4xX0N8Kk/QYnQEvMU8FS78ZEPXoFVA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bj7q9grx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 07 Oct 2021 14:59:14 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 7 Oct 2021 14:59:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X64hUk+OiVHPbm8j4zYKMa6QJmL6ysOlcLD2gg5JdpejEpQH4dnUcQ6LLSo1s5GpE/geuoy1eYd/JTxYt14KJCU4YygdS+T/wadFHlCvktAxUU1WKYuKGUW36LJfmeXkAJ3zFQ1vSgzbHIeijUFwo4kQ8SYede8x5PA9Q9zz9r5G/ypiI3ZxaDd5e1U2lf5vOHsu039bLc7roDuXOtGlVlgohNHLv25nHh/lTQ2dwuEzWMUpH9yVZjEjBesPAtzEFIhn96YuLWnUDqns5lyJyaKcotUeEGYZgDHOiBAYfJzeOMuyl8LJ3pNze8V7c/YIPR52iBIx1Rgu8sSG1C5obg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrvWJi6z9LCBZTKta4FFM5FbXXLLEv9RSpsVSulBl20=;
 b=fx/WUyxJw1ozm5z8Jnoa5aWw91r6R5aK9IxcZpl6bcVC8WbPy3HqpqUL+9aQn43Sd7/rC1/vdoBq+er5c3Mbefc0chXGIfR4vciMhNoFLmDnoHGMEh6PgHECGqwpS7sHwepTMoe56dFyC72shxymz49CgxLv9Zh4qWGj5l+bPhUzrrIfZ0YXe6O+Oud4wfMmhVO8s9TOPCKrQANg1W51zXUC6gmHRBnMBlWqhtronGhMQNwLsROWEEvftKoU6SrwGDpCQ+8Xe7X77ABr6UXmcJGAmWly/qFly5imOkb8Sl3x6dDC0kQSoVzZaK//DN9KGt4zpyEr9v5KyeJCCyzlwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SN6PR15MB2352.namprd15.prod.outlook.com (2603:10b6:805:1c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Thu, 7 Oct
 2021 21:59:12 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::85c6:f939:61cf:a55c]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::85c6:f939:61cf:a55c%9]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 21:59:12 +0000
Message-ID: <4536decc-5366-dc07-4923-32f2db948d85@fb.com>
Date:   Thu, 7 Oct 2021 14:59:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Add bitset map with bloom filter
 capabilities
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        <bpf@vger.kernel.org>
CC:     <Kernel-team@fb.com>
References: <20211006222103.3631981-1-joannekoong@fb.com>
 <20211006222103.3631981-2-joannekoong@fb.com> <87k0ioncgz.fsf@toke.dk>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <87k0ioncgz.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::27) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21cf::15eb] (2620:10d:c090:400::5:5b25) by MW4P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 21:59:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fb7fdf7-22ff-424f-2f68-08d989ddb281
X-MS-TrafficTypeDiagnostic: SN6PR15MB2352:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB235226C767EC9AA85A923CF2D2B19@SN6PR15MB2352.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BmAg0jBQkApTKMBvzPqM3KAFv74ufIG6yef05uvHTk72VsBT38UhzfvdJFj9R1v+qcXasUo90dbrAWrbVe0eOomNRfsedyCWIxHN+swESCqUY4ItQR0DYpmJqi5kQxMAaWLCWNOD7UGM/2NrBNa4lkjoGy4VebX3iG9k26K9hesYrdDgcQ21Ljv+KLJ6BJK475QnEEg8SoD3FYT62AIWp3DaUi1De59UgU05RDHHN2N1jBigwVN1Nuk4qneArH8qtxRGdBhME4il0xXRJh1DNPPAp/pVj71cv+PsPu19dK1BFUNiM3PbEMjw+R/TlAyUw2XcdqUOKbDrXV1xGkfdGXDRTstswNvX6Z/EadP+Cho+4lOLEZhBuXbvsbtR0/MSPBsCR2JtU9HV3cmCfTf36H9ss31akjmYhNPtOk6U982FBuLDsLSkqjMmfoippFQYy6zLDjQAKDwtVHMioM5hqiWEtawru3hI3wiXIHYz4+vYKUpAd7Lg3u4mCXw+UJrx32TEg22PcRusjpyDlYIZpCFAd7UIV1p6KslDQK76H7GjT1M1jZK2qsNm7flpSAtECGbLpnd17mlNtGPNoNCOyhgUcq8e740UApj93M4QigifcdlrxguT1uCGuD5jKdT4HRPqaQ9gmc0Mo+y5iXeZyh2Fxx3oJjWk2OQb/HXYAYXHlF+MdawXZOnb7cFVCQMvSTF0G0P01G1yxOQ0ZaKWRu38DE1It2w1nIcieLbPdN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(8676002)(316002)(6486002)(38100700002)(6666004)(8936002)(31696002)(36756003)(83380400001)(4326008)(186003)(5660300002)(86362001)(53546011)(66574015)(31686004)(66476007)(66556008)(2906002)(66946007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFZoZklEMDRyeG5UalZVejZPZWIyMTh6eC9uWlBQeENEQUc2TzRoTFJGbitZ?=
 =?utf-8?B?N2dHYk9rV2FSUUhRcFI2aWY1ZDVDM1l5OE41eWlyNC9ZVGNnZmk1UFZHSDQ3?=
 =?utf-8?B?NWVzL0N3YXd4ZzJnTkVYalJWR0xhQkc4YzE5b29aWm1kdGs2MEJkLzladTRU?=
 =?utf-8?B?Z1dYWDBwM3NWclRVclhTQVhoQ1NUWlk2bVBrOGpXTmVVdWIzSmJ5bFpmRXVu?=
 =?utf-8?B?bThmU2ZXRFpCNTkrYlR3VStXQ0RpcVVUY2E3aXhXS3lmZ2pEOFRPR1hWdS93?=
 =?utf-8?B?NVJzeEJaVXoyeVpNL2RlRWFuSlliVGZWQlh2YzhhWE9abjk1ZEFSR0h3Lys4?=
 =?utf-8?B?OGxWTXU4Z05peGpkRFJzaWVVTE8veHE2Y0Q4cGJFTzRmZjZFTlRabXZONnRr?=
 =?utf-8?B?WGJQVS9iSnJQc3JlMXNUdmVJOHoycFU4NktaelRnMGtZN1FZenVDbzhucXhL?=
 =?utf-8?B?dHd2bEtDRlpZTG12bGJFQUlaRm5QVGV6ZmQzRjdrV1BCZ3FweWhvWk5JQkFL?=
 =?utf-8?B?SmlsTUtiZENLYk0xeUNtTVJOSnJ5SGorZU5MbFNlVS9FR0Rzb05Cblo3aGFj?=
 =?utf-8?B?ODRFcHprc0JtcW5iRFowTERJNzlCcUFiNnJmQmZHMWdDcExwY0NPVjFkQnBQ?=
 =?utf-8?B?SzA2YmJCWkZGOXFtaGoxS2NHVnpLeExPbW9BcGtkM0JzL2NQZkoxOSs5M1lF?=
 =?utf-8?B?Y0xadzVVOEJocjFXY0FJK0JJMkN2TkNKUmI3UncxaFdTUHRUWFNzRmE2N21x?=
 =?utf-8?B?Tk9kRGk0Q3d2QWRQUE1DczcyWTlialJXb2I4eGxoc0RzR3V0UllCc01HMFhD?=
 =?utf-8?B?bFBiWjd2V09zWW1KQ0dWTVpleFVTNktZbFFSclZ2WXNVVHB4Yk1RRkZ0Mk1N?=
 =?utf-8?B?YTJUaFY3bTN0RnVXRDNidkJvZk85NG9QVjV4S1dpRzA0K1ZyWGtYakV6dG0v?=
 =?utf-8?B?bEhvcVd5aVVoNEZ1Smx3VmMxdkNDZkg0eXNhbGE5Zmd4OWNaYitLMHVHNSs3?=
 =?utf-8?B?T0JJSmJtZzFjdTJZczdwSVMxaFBDSGdCZUVVYUNHS3pZczZOWkwrejdUeCtl?=
 =?utf-8?B?S25lVHBrMlJzS2RLRmlDWHU5MTJSVE1UcHFyeTI2SlNONldSWUw5ak10ekhs?=
 =?utf-8?B?OG9ZK05LOERNSEZhcmw5OUZURUdicWtzWGs1OUR1a0kyVEdpazRrNXdBU1Q0?=
 =?utf-8?B?QytDMzJSaWxzNjU1Wkc0TXJKeEw5bWN1ajBZWE1mbnRkQzR3cjB5dUxJOWFM?=
 =?utf-8?B?Mk9WY2g5YlRQa1V4akg0bm1SUmhVaU5HQWZTYXJQVWp2VDhKSU02Yjl3d3l1?=
 =?utf-8?B?TUx0YU1WaHk4Y2xNV2lZaGJHSTJFQlVQU2IrSldJYUlnS0ZEUTlXN2x1R3FT?=
 =?utf-8?B?K2ZqNFlPNFoyTFh2alcrZXo3WVlPN1lIWGJvU2NPK2NXUkNYL2tyNEFHN2pv?=
 =?utf-8?B?UlVHdFM1aUgzYWdzT2M5K1RJWmlLUWRiSWVaU1djYzF6V3Brd20xclBnT3Jq?=
 =?utf-8?B?SGZXMkQrR216VFFreXhMc1cvNmxsMWR1b1czMVlGaDMwZUlQek5ITXRzTmp4?=
 =?utf-8?B?VCtCYW9VVElGRXpyUDVVdVJkb2JsZVZPZmRJNitHaHpFVzR4cmxySHpyL2xK?=
 =?utf-8?B?OEtoWGxCRWl1by92VEkyb3Z4azBESDA3L2dkcUoxZDMxRDBHUDBsbWpFRFYw?=
 =?utf-8?B?ZEVJS1V3ZmFYYXBvTUQ4YloybGR4bHJHcFJrcjU3UEFacnlPa1A0c3ppTE5k?=
 =?utf-8?B?ZkZ4SGJIaDlQOE15Mm1GZXZLdEpXUW9MR2ZQR2F0bnViZ2phc0MvRFlYbmFI?=
 =?utf-8?Q?P+k9YirVXivgmMeHCQdfuueGXKM0qgzC9JYjI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb7fdf7-22ff-424f-2f68-08d989ddb281
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 21:59:12.6209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5El+VSaGmGv2dljL7ZpCMRD6wbHu+0y+dE9W+KjmnP/Ymyn1o9flTR19fgMiC8vLAta0vUPWOt58SUAN5QXTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2352
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: crpchKUoMDWkIQCEuZ9-wHnxqZCVYkiu
X-Proofpoint-GUID: crpchKUoMDWkIQCEuZ9-wHnxqZCVYkiu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-07_05,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 clxscore=1015 malwarescore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110070139
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/7/21 7:20 AM, Toke Høiland-Jørgensen wrote:

> Joanne Koong <joannekoong@fb.com> writes:
>
>> This patch adds the kernel-side changes for the implementation of
>> a bitset map with bloom filter capabilities.
>>
>> The bitset map does not have keys, only values since it is a
>> non-associative data type. When the bitset map is created, it must
>> be created with a key_size of 0, and the max_entries value should be the
>> desired size of the bitset, in number of bits.
>>
>> The bitset map supports peek (determining whether a bit is set in the
>> map), push (setting a bit in the map), and pop (clearing a bit in the
>> map) operations. These operations are exposed to userspace applications
>> through the already existing syscalls in the following way:
>>
>> BPF_MAP_UPDATE_ELEM -> bpf_map_push_elem
>> BPF_MAP_LOOKUP_ELEM -> bpf_map_peek_elem
>> BPF_MAP_LOOKUP_AND_DELETE_ELEM -> bpf_map_pop_elem
>>
>> For updates, the user will pass in a NULL key and the index of the
>> bit to set in the bitmap as the value. For lookups, the user will pass
>> in the index of the bit to check as the value. If the bit is set, 0
>> will be returned, else -ENOENT. For clearing the bit, the user will pass
>> in the index of the bit to clear as the value.
> This is interesting, and I can see other uses of such a data structure.
> However, a couple of questions (talking mostly about the 'raw' bitmap
> without the bloom filter enabled):
>
> - How are you envisioning synchronisation to work? The code is using the
>    atomic set_bit() operation, but there's no test_and_{set,clear}_bit().
>    Any thoughts on how users would do this?
I was thinking for users who are doing concurrent lookups + updates,
they are responsible for synchronizing the operations through mutexes.
Do you think this makes sense / is reasonable?
>
> - It would be useful to expose the "find first set (ffs)" operation of
>    the bitmap as well. This can be added later, but thinking about the
>    API from the start would be good to avoid having to add a whole
>    separate helper for this. My immediate thought is to reserve peek(-1)
>    for this use - WDYT?
I think using peek(-1) for "find first set" sounds like a great idea!
> - Any thoughts on inlining the lookups? This should at least be feasible
>    for the non-bloom-filter type, but I'm not quite sure if the use of
>    map_extra allows the verifier to distinguish between the map types
>    (I'm a little fuzzy on how the inlining actually works)? And can
>    peek()/push()/pop() be inlined at all?

I am not too familiar with how bpf instructions and inlining works, but
from a first glance, this looks doable for both the non-bloom filter
and bloom filter cases. From my cursory understanding of how it works,
it seems like we could have something like "bitset_map_gen_lookup" where
we parse the bpf_map->map_extra to see if the bloom filter is enabled;
if it is, we could call the hash function directly to compute which bit 
to look up,
and then use the same insn logic for looking up the bit in both cases
(the bitmap w/ and w/out the bloom filter).

I don't think there is support yet in the verifier for inlining
peek()/push()/pop(), but it seems like this should be doable as well.

I think these changes would maybe warrant a separate patchset
on top of this one. What are your thoughts?

> -Toke
>
