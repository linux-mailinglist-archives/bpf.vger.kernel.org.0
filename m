Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E11486110
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 08:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbiAFHhP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 02:37:15 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45664 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234484AbiAFHhO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 02:37:14 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 205N6JK8030865;
        Wed, 5 Jan 2022 23:37:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=XhKeCq9G6D9dLIteZLA3L9uDnIiTsZKbg7TWwy8dcko=;
 b=KDInNiwLi6c6m1TXNTepXmMt1dNO8bJg8UydTSj9FZsiQPIx9XJTm35jRTzF3qcFnh5m
 ysSsB7qH0ncBoVCwpNkve0nWwH8VoaOvOB46s6RTQlqXov1SYqKFAyRTiQ4Kt8TZcCbz
 PQeX85qB5KrEOzN/azFvtnBqV8YvoIAx67E= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ddmq3hwjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 Jan 2022 23:37:13 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 23:37:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTppNF7lI3iiqE5EFx4lk1hyHV8YlrUdOSPMGOFKSZhVAsTiGnV/+WG5XiMD/MRkBtamGyLriAigN4SFgE77FC1GlPST52mOe1J9glX5fPv0GIH+SnJzliURomfee2/LZiF4fHCH3Bk22f3WCWjLLshQ9Gh1KE3kORYYI8pF3psRlal8bRqKOflshRsq/HXu6AmyK2aadE3k6Cq6QqdxibB7lmxFpQUryZgseQlrriyRYhtLLDJHTf6mL4F9Do7X0ecWHcTCaEWSz6VdEN2Q3v+hW683Pn9U+B/ImcnJSaGTm3fMP8HK+SN4AZpDyjSbrnGcD7q3uGGQ3RV06xFNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5RKkcGHrYmUCdTY/6sQNMq8PiQkmKwrdGaBgdlj7xk=;
 b=Ps+7RsCzHM2PDV77P1jzzGsqZB+LOSZ9Qe/dfCz3UOg0TOg/LI1QqUs6CfaL2htT/1HgszZHq+Iea50FzIvTgjZVINFlA4cisS7JWFm6e6wKT8VW+52h9RFWuCnLutqsGRBQr1TvHTWJn0D9bfXlY0zpUVFp3vWri4saG0SeoWkDhSRDbm+NMh9U/JJPVZdvFLZar6fwgwFoW4Gs1vtZIIdlXKCVAf/F75WsoXfrCxL0a2Sv28sTSHoYU/As1azqmUizUqJI+4xBDO+LFWbSMJlSDATvW+YomYo9nG7sHc224E2uPztkLK4r9NAo4pvcQBfhEW5U/LpLdPyIGoj9tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4641.namprd15.prod.outlook.com (2603:10b6:806:19c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 07:37:11 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ede3:677f:b85c:ac29]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ede3:677f:b85c:ac29%4]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 07:37:11 +0000
Message-ID: <7199e14f-da44-bdbb-4cab-db802ce4f488@fb.com>
Date:   Wed, 5 Jan 2022 23:37:09 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: Verification error on bpf_map_lookup_elem with BPF_CORE_READ
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Tal Lossos <tallossos@gmail.com>, bpf <bpf@vger.kernel.org>
References: <CAO15rPnCtpSgH_Nucb=Zkp04iMS1w8uYiFGgbP4LG1rujmd9HA@mail.gmail.com>
 <5fa06774-2480-ee73-a7a6-f0e6eb760545@fb.com>
 <CAEf4BzYHTLRarRrGK22JUsA6SO3HuvMfSgQVGGWmZdYeNE3RDA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzYHTLRarRrGK22JUsA6SO3HuvMfSgQVGGWmZdYeNE3RDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MWHPR1401CA0008.namprd14.prod.outlook.com
 (2603:10b6:301:4b::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e64cc2ab-b480-439b-cd8f-08d9d0e759fc
X-MS-TrafficTypeDiagnostic: SA1PR15MB4641:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB464139177893889885DB4745D34C9@SA1PR15MB4641.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NUia3k2hE8VMRN7FFNwkiYV8iZe1BAjxfqGHEUh70zYFmKh2ZgG9VozSdyXrrE4dT4ftD4EInQRd5/Lk3dAhp108AYGrVvBFOogUiAy6YqF1R4PTwXLPzSgEpJoNFRyq/ZuLtsqIztGfeQ7mUVSlv96/1SHWlNzqe0WnCyj+7bK8Qwl9g4j71JB6CkCkNtJXZ/V+55RgMFxLb42j7doUhXgAWw9sgYEusOeQ4WAhohQhd9bd07r/qrLl0b6HmL42rAd0+05S4WsgR8R9j+9aTwXD/leLSKvb2It/T6Go2u642Z/uJZOa7qSwOWmPwTDQQlmP4uEJChS834cdh6ifZkbMNdLUiSo6PXnTF0I399C2nP6CmC0mfcpWPig1e9R7xo33Vr2+WQk78ynRiWk7P9WsvLHiD99mOgWCwPqIEfsu84R01ZXDLY66xwHYi+IUUa91qenpsfaR4ESSt0+IWIMXzNoEwz+B4yltBv8jhcm2nkfQ8X180gJ1bHIyDd5hzPqD8645D0rq2mai7bpC+wVPmBkx1NMNN+IJUXKAZ/ZdbW0vTS+LIAUQtEp45grnsSaDXGP0pDFavPX6+lkV9H/uWThW/UECosBqTtL2/eC0Q/6zMpsKl75451A7Czp4i3j7efg4LmUm+oYQ7q9NMnJq+fu+TMBzzun5ABcvAtSgOEvNQEuZCrWAw4K5iRAlkfWIxGcbRPgFCRW9uP31cUz8phEYSLF7ZRpBUF9Kyi/1akAKtAHajLONIiER8SCYL3v5V7gqJ3ad4K6PZWd8Q4ROtLGD1d+eViRKkLaonVgiYC9oEkUQw1gix4rKPOol
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(186003)(6506007)(66476007)(66556008)(316002)(66946007)(2616005)(5660300002)(38100700002)(966005)(6512007)(15650500001)(54906003)(31696002)(8936002)(36756003)(86362001)(508600001)(52116002)(31686004)(8676002)(6486002)(2906002)(83380400001)(53546011)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTNtTU94a2IxSTlUcTI3NTF6YU5paUVTZEtsQSt1TFZlTnR5QU5lZXAyRFZr?=
 =?utf-8?B?TDlVUG1MdHpIVnc2Tzh0a0xCM0U0Vm92eFFGUzR0MloxMGxWajc1cXlnQWFJ?=
 =?utf-8?B?RkRDenhSZVp0T3BsOE1HcHV0V2xqdnFZcEp2T3pNd2RHeVAydlNmLytiLzhm?=
 =?utf-8?B?TTYvOE5ScFJLT1NBNExLTjVpaTNyaGk3NytMY2ptVzUzNGEwbkdsWENqcFVG?=
 =?utf-8?B?TjlxNHhmSjZXdm1SdUNBQWNEMDM0bVhKa0lCYnZGWklFQ3hGQXpsRVZmYnZM?=
 =?utf-8?B?NFZHZGl3dkErL0tBZ0tyMU9pY0hxQUR1czRoS2kybXFJL1B6UWkrV0FMaG1E?=
 =?utf-8?B?NjRqZzdMQWxIdkErSzRQK0l1TnVnUFNMLzlNRFVvZ2ZQODVNQXFKUXRrR2Np?=
 =?utf-8?B?aEV1VXllRVpYb0t0bHhWakMwRnJZSVoyZ1JPWTlHQXovUTJjVWJCVUZqVDZZ?=
 =?utf-8?B?TjBmOTVWWkdDRFRZSU9MUFlIcjhjZTNYanhGNlIzNmlMTEg0VTVWVm1mSzlZ?=
 =?utf-8?B?eXBGNXZYR1AvTEhHZ1B4Y05JR0ZxdVlaN2dyNFB3dGkxSEY1R05MRmhpbm16?=
 =?utf-8?B?R1BGc3M2c1JRRGpwMC9qZkRSa2tFRDQ0KzNsdUROL3NQdklyU2wzSGVkNXZy?=
 =?utf-8?B?b2wvWElaZmNXWWZBQnozMS9KQ3lqNllSUUVWbXlFZHhSTHZmaTQweHU0UjIr?=
 =?utf-8?B?ZGdTSWJ5ZDVvS3NjT2hBS0ZKYlpMRkVNNGMxYXdVM3pNVkhCOFlaclBBVVpi?=
 =?utf-8?B?Wmx3S3ozbU5JQmE2MWVvUXVYSURlRUJLQitZU3NIRWlqTlQrZ0VvZnYxWHkz?=
 =?utf-8?B?L1RRc3NzUmhHaUVBcGkwZ3FiRFZoRnVrN2FBT0FmVWJHSmVrbHk5R0M0MUZG?=
 =?utf-8?B?M2p0UW8rcWJaMWVBbjdFL3VGTDFaTFQ4dmlUQmNwRmF0N1BRcElWNEFhNjVE?=
 =?utf-8?B?OEx3WWwrelMzeTNudVZEV0hKZzJqeUxDNG9Hd1ZSZWZ5M0J2N1RaTkE0V3Zl?=
 =?utf-8?B?bkVVeTdWbDdndGtlZEEyM0JwODVLcHhDWWY1clR1amNPb09XV0IwU0dmYWYz?=
 =?utf-8?B?dzNsNnlWaFZWWk9tZ1E2d3BKYXhKbjAyMmtMTTVQV3Z1ZFF5OGRFb2wrMHQ4?=
 =?utf-8?B?T2dmUWxwTFFZK2kzdENBR2lGK1VEWFVRb1JEL0F2ODVJNUNlOHB1K3VETjFD?=
 =?utf-8?B?Zi92b2k0OG9sZGFqM2wwYWJRVkFqNk0xQ3NUeWVXQklNY3NlcUtOcFNoYlVT?=
 =?utf-8?B?YW1zVFBSdm1lQjdNaFdwZjhjVDV5YTU1eVNHUXJOaVdwS0lON2NsQThueFpr?=
 =?utf-8?B?UWFjMjZlaUp2WGxEYkgxS2dSS0lYRnZvVnVpZlZzbXBjS2U5eGpFWVE5Qkwy?=
 =?utf-8?B?cWxTdmY2Q1Vab2Q0bU55QmhMdk8wbk9WTCtWeU5TK0FLWVJWQURKeXhYRjVC?=
 =?utf-8?B?bG9EaGZmejhzUlAveDBRWmtsNGtCQy9UL3NlRjU4OGxQeVlyVk9RWWNIZDN6?=
 =?utf-8?B?OU82L055WVl3ZFo4bTI0LzZVakw3KzU2LzB4NGVaUmJOcVVqcUNxRmFaeTdB?=
 =?utf-8?B?bTBXWHB3VHVuM3N0eEh6NjlrZklpM1RCczhpc2E4bXpmS3RwS0NwenM4Uk1E?=
 =?utf-8?B?d25BenBPZDd0bXlJbHMydFlib2hMdEdxK2lzUUlxb3pFc2ppNFhxcGYrblpl?=
 =?utf-8?B?VG5lWUp4OEVBVTJNdnkxWkMydG5WOGJzeUdEVXkwY0o4TlROZ2phK0FyVnJK?=
 =?utf-8?B?aGp3bWhESU5IMXovWk84aFlvbFplOGtjdE82NDhCOFVOZCtGdmh6SHVWT21P?=
 =?utf-8?B?RmpOMmdRbVdrcTZ6a3RERU1DbWMrWTY0b0h3SkkwNlpwNktUOGl3cjg4c0JO?=
 =?utf-8?B?MnZOamxqRktwMlcvSHpLdVo0eE5aeXZHQlRKNHhkN2FBN3cvaGxQeE9wb0No?=
 =?utf-8?B?MHRIOUttSkdkcGhmNG1mN3BtWWJ4Y1R3enA3cWdQUTJJeUlZam1oWS9Rb2Nx?=
 =?utf-8?B?VzRDbjQxRnBlOEppRFphZjF4VUltTzZVZnh0SG5KTTRYa04vajA3YTBhSjEv?=
 =?utf-8?B?c0t5RXk0YkVUUmZkU2NPTVFBd2grenBWQlpsYzBCMkdodEZMdXZJdURpa3c2?=
 =?utf-8?Q?xtwYJDTZnO1vVdChneD9LCT0U?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e64cc2ab-b480-439b-cd8f-08d9d0e759fc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 07:37:11.6335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DzsJuMBicjP+mM94tTgBGBprLx8guRH9ICYsWdF/zReE95kFgeZiVwaD3oxkmWcy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4641
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: bX-xb67Icy1VUYbX9gwx0CThis3RGWD-
X-Proofpoint-ORIG-GUID: bX-xb67Icy1VUYbX9gwx0CThis3RGWD-
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_02,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2112160000 definitions=main-2201060051
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/5/22 8:36 PM, Andrii Nakryiko wrote:
> On Tue, Jan 4, 2022 at 9:18 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 1/4/22 3:35 AM, Tal Lossos wrote:
>>> Hello!
>>> I’ve encountered a weird behaviour of verification error regarding
>>> using bpf_map_lookup_elem (specifically bpf_inode_storage_get in my
>>> use case) and BPF_CORE_READ as a key.
>>> For example, if I’m using an inode_storage map, and let’s say that I’m
>>> using a hook that has a dentry named “dentry” in the context, If I
>>> will try to use bpf_inode_storage_get, the only way I could do it is
>>> by passing dentry->d_inode as the key arg, and if I will try to do it
>>> in the CO-RE way by using BPF_CORE_READ(dentry, d_inode) as the key I
>>> will fail (because the key is a “inv” (scalar) and not “ptr_” -
>>> https://elixir.bootlin.com/linux/v5.11/source/kernel/bpf/bpf_inode_storage.c#L266  ):
>>> struct
>>> {
>>>       __uint(type, BPF_MAP_TYPE_INODE_STORAGE);
>>>       __uint(map_flags, BPF_F_NO_PREALLOC);
>>>       __type(key, int);
>>>       __type(value, value_t);
>>> } inode_storage_map SEC(".maps");
>>>
>>> SEC("lsm/inode_rename")
>>> int BPF_PROG(inode_rename, struct inode *old_dir, struct dentry *old_dentry,
>>>        struct inode *new_dir, struct dentry *new_dentry,
>>>        unsigned int flags)
>>> {
>>> struct value_t *storage;
>>>
>>> storage = bpf_inode_storage_get(&inode_storage_map,
>>> old_dentry->d_inode, 0, 0); // this will work
>>>     storage = bpf_inode_storage_get(&inode_storage_map,
>>> BPF_CORE_READ(old_dentry, d_inode), 0, 0); // this won't work
>>>       ...
>>> }
>>>   From a quick glimpse into the verifier sources I can assume that the
>>> BPF_CORE_READ macro (which calls bpf_core_read), returns a “scalar”
>>> (is it because ebpf helpers counts as “global functions”?) thus
>>> failing the verification.
>>> This behaviour is kind of weird because I would expect to be allowed
> 
> As Yonghong explained, BPF_CORE_READ() always returns unknown scalar
> that verifier cannot trust. All due to the underlying
> probe_read_kernel(). BPF_CORE_READ() was never supposed to work for
> such cases, it's not weird once you realize that BPF_CORE_READ() is
> able to probe read an arbitrary memory location.
> 
>>> to call bpf_inode_storage_get with the BPF_CORE_READ (’s output) as
>>> the key arg.
>>> May I have some clarification on this please?
>>
>> The reason is BPF_CORE_READ macro eventually used
>>     bpf_probe_read_kernel()
>> to read the the old_dentry->d_inode (adjusted after relocation).
>> The BTF_ID type information with read-result of bpf_probe_read_kernel()
>> is lost in verifier and that is why you hit the above verification
>> failure. CORE predates fentry/fexit so bpf_probe_read_kernel() is
>> used to relocatable kernel memory accesses.
>>
>> But now we have direct memory access.
>> To resolve the above issue, I think we might need libbpf to
>> directly modify the offset in the instruction based on
>> relocation records. For example, the original old_dentry->dinode
>> code looks like
>>       r1 = *(u64 *)(r2 + 32)
>> there will be a relocation against offset "32".
>> libbpf could directly adjust "32" based on relocation information.
> 
> I think libbpf supports that already. So if you use direct memory
> reads on dentry type marked with
> __attribute__((preserve_access_index)) it should work.

Oh, I missed this. If you use vmlinux.h, then CORE for 
old_dentry->d_inode is automatically covered since types in
vmlinux.h already have __attribute__((preserve_access_index)).
Otherwise, you need to define your own struct dentry with
added preserve_access_index attribute.

> 
>>
>>>
>>> Thanks.
