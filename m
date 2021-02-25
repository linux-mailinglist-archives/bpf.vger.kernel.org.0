Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352353251E3
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 16:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhBYPAv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 10:00:51 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1878 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232103AbhBYPAc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Feb 2021 10:00:32 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11PEvrBW009175;
        Thu, 25 Feb 2021 06:59:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=h1qBKgOXJEbfRqxM58SCOpnqkIJ/l+dmZEvvYp3im8A=;
 b=qtzhwDIkQOgacLVVvVHYXUy2q21QTy5mZx4Dte9GDFs9kDPTE2XkV9HFLUMGdbjwFysG
 cF2HUpTkEyEji4SPKFgF9Y/FBIQixrpm0kYzkhH8ruQ8UpjyH4XAuirAUtp1a2q9Q1fE
 NpBmWwAPkMclaC3d3bRmMhCBAYH/8rmDeNw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36vx7axqvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 25 Feb 2021 06:59:29 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 25 Feb 2021 06:59:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqsXwtRl+9zKcBWhYeN62HSA7bHsAZsHEuc5UkSiySE9vFPtyjvd0NOvHRqEYJcMBcX5aBkhqq3XMxBBuz2kQ43epg4TlCKW9xrQGbT8hKwcynvKINP3MAjVn/BMkeU9bi/4qySVGgX3FiubaA9Bc/0LLdYGWs5Upv5acWTktdwznd2qhqgIO5E02oZCPmb4niK2FMU+AG7Eanym/uZPExmXPhgWVku7L8yCftdRfCRQH7H7qdmpBw7O0QJpc9xKlJv3bVqwMn5mHPOwxyB3+5nqdtUMFETOVIgmYjLxnXGIuWWUu9XUFkHF7NDFh4l0dTZHhRYtSeNayXgotJ7tHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1qBKgOXJEbfRqxM58SCOpnqkIJ/l+dmZEvvYp3im8A=;
 b=gfD72BZwIk9HYzKpX6kXVl3irNzJCPhznSJ342PSTy77hJdrCDqSdgiXwz6ser/DXrH43jEPS59alYElfq0jLZi0ajGRUbw/C5BT6LcnSO6wSsyFhkElwQO5MsBoxRMmavjpP+WBv9RukrUF6K2BBG3ubd23NVXZro9W15US8ovm0b5jPqvpCHNcJyvZ/Pg+NwwM2xgr6Q1CrMvRldGIIzem6koifoVG5GYfmFWr3mBSAKYW0171vmjQY/dnqjAJJDQ+xkFjMdQmwvm6NDKySw5dZFx+Qani7wigPnFzRO5eUojN9kbK3vOaNj/pZfVxCBU9pnugVPVqBgw8t7VLxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3903.namprd15.prod.outlook.com (2603:10b6:806:8a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Thu, 25 Feb
 2021 14:59:27 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93%6]) with mapi id 15.20.3868.033; Thu, 25 Feb 2021
 14:59:27 +0000
Subject: Re: [PATCH v6 bpf-next 6/9] bpf: Add BTF_KIND_FLOAT support
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
CC:     <bpf@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210224234535.106970-1-iii@linux.ibm.com>
 <20210224234535.106970-7-iii@linux.ibm.com>
 <e7957fca-b938-e50d-74f5-ecc40145eb4d@fb.com>
 <6962feb05a62d718e5d430f782012d71d6c73eed.camel@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <fbd33830-2f16-23a4-0c31-91bb4bd95ee4@fb.com>
Date:   Thu, 25 Feb 2021 06:59:22 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <6962feb05a62d718e5d430f782012d71d6c73eed.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c091:480::1:a9ee]
X-ClientProxiedBy: MN2PR16CA0016.namprd16.prod.outlook.com
 (2603:10b6:208:134::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c0a8:11d1::15dd] (2620:10d:c091:480::1:a9ee) by MN2PR16CA0016.namprd16.prod.outlook.com (2603:10b6:208:134::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 14:59:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09c29636-0ac2-4816-6b70-08d8d99df247
X-MS-TrafficTypeDiagnostic: SA0PR15MB3903:
X-Microsoft-Antispam-PRVS: <SA0PR15MB3903D52ADFD6EC9AC41895DED39E9@SA0PR15MB3903.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i7sSctQs2GBs+mf7dmsLaOzDXZZZVPXLARrY6w3xle+CuSURiNaY00UfnLAqw83bGm4RfMwaqmAVzIAaVQDR1Lv2pLMnaWY5vT76PqCwqdzZ5quZMbcjuHduemy6b4D6tHdiOA2aQT9IwKJG7lH0cvj4anMmBvxo5RPgIlKgtocMWBTLJNvYbmTxQvPmeZXDBH+s21tDMqIoR7gjHq817AD7UBdmcl3NyFlFJtY0qDyTXUUZTvS2FqwjWqtEJRSNn3expVhCbzldi8cSA2NJhQQEfwNaxrtReF4zKXGvbezREf7aI7jImIeVS7A5X5xIJS4RI859sVUw+9qXNCg9dCUfKK+Ew570ozZbi5dTssfiON1Noysm75PMX4QiiJAyEJqhdygpb/lyy1FIqadDorLEn9upgqefqIch2XpF2fYQfuWzBHwhB4Ecta00h0L1TWPc5X1zWK0eDOuq5iSSbPCp31KX5St4UzFDcgYYUzvDEdWYJFoNqfV6PDc5Paa8h53+mw758kinRJTaUXMypW9x6vt8zE0db2SVeXaMEDsFZ6QFNwdVfQ6QbJI+1Jq9smLjU25pQAaKv3g/0JwNJM1oV7AZyddtBtHkDOPtbmI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(346002)(376002)(136003)(31686004)(6486002)(6666004)(5660300002)(2906002)(110136005)(86362001)(316002)(8676002)(16526019)(2616005)(52116002)(66556008)(186003)(83380400001)(31696002)(66946007)(54906003)(53546011)(4326008)(8936002)(478600001)(36756003)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S2lpRkZlNDQ0cDVDS0p3K0R2cTc4MnIwYm1ZZ2RnQ0UwS2FVUi8xb3Axa1Jl?=
 =?utf-8?B?Tm1lMytIeE41cXpKRGt2R0g4YnE4eTd5aFdOWkl6T3I2VHVkcEVHSkt1YUZU?=
 =?utf-8?B?b0Q4aThPS0xRU3dhNUlMMVd6dVVaZHpFY2NJclF3WnpuMEREZklHK29OcDJY?=
 =?utf-8?B?T0NXQnpMakN1RUJWNCtubSswQTZXZEZpL2V3akZXMk05Y3d0ZlU3WEgxaG5V?=
 =?utf-8?B?S2piejJOVWNQNVhHL0hPTG1YTlBkT2dEcUdtUGpMcU5HNGQ0M0pWY08rSHB3?=
 =?utf-8?B?ZnFEK25pTWJGbUVZQ1BJR212R0FoNk9uWC8zYURZUFFZdWVRRis5ei9tWjcv?=
 =?utf-8?B?NHFPUS9kQjRaNy9OYzVZMEVmTTEwOHMzU3NZZjdZdjNJUFVMYXF6KzJkUW1F?=
 =?utf-8?B?NlQyWWhMcmgrUzJEektud2lUOE0wTGdpZTU2YjlzMFlsV0IrTVFMWU1Ta0g2?=
 =?utf-8?B?UDV2Nk55Yk1ZcGpJeXlqWUFpakFNbk1uTXV5c2o3dzJ0aGRWdHM3VFFMaW1N?=
 =?utf-8?B?UXJSNHFuQm10RDYrUmJWN2xWRGMrT3U1OXlHaXVrQ0taSHk3elBwb3kzT3Vq?=
 =?utf-8?B?SHl1bGhzNk4rTEZBa2xoMXRqMWRoYWRZT3Y5WUNrUkYzaHg3cEpGVFBzZWNX?=
 =?utf-8?B?NTVMZVB3UVRTNjl0WDhZd2ZHR3Y3U1lyMENNMnd1QWdhdlNaMTNDNWJLcVo0?=
 =?utf-8?B?NHcrdkx6UDhaZFZwMGxjM3dRMkdmU3lDTFdXdzQvV1lFcDlKdTZ2S3NHdFNQ?=
 =?utf-8?B?ejlPVXY0KzFWSCtrcVBzTlpOaVBJb3VxUzdlaDNsQjlqdGw4NldBTE9mbnFP?=
 =?utf-8?B?a0Y3b0JXWWQ1a280TSt3MDlMSi9weC9VRS9xTERFWHFCeHVGZWFMb3hsV25a?=
 =?utf-8?B?Ri9Sc2tGRk02K2VBUFNwM2E3Qm53anBlM3JrSDBzUE1IeC9jdm4xc0N6NkZP?=
 =?utf-8?B?eXJVQ0xnYktSd0x1U1ZMYVhwQ3JnVXdtcitCTWhFemp2OWpRWERwaThrVzJ2?=
 =?utf-8?B?TWt4WWE2Mm1rMzk4aThWckJQSjRjN1J3emJkaUEzOEwwdXIrRCs2RG5WTXEx?=
 =?utf-8?B?YUNVSWxVdC9oMTE4RjZnNTVubGM5LzJtT2pwTW4vMmdBdlJWSGQyUTczeG9X?=
 =?utf-8?B?RG1zK3AyVUxLREYzTkZiSlZWK2c5ZGdKRE0za0QycUFwbUVUaHJIL0tqdlpG?=
 =?utf-8?B?WjR3TisyOGk1ZW01U3FuaG1oUk1CY1M2Q3RNQ1g3YlR5ajRlakN1c2lJbTl4?=
 =?utf-8?B?V2N3dVFhaUVpbzJXVnRtdCtFR1NkSzlpUjI5ZkF0N2p4UE9GL0RMQVZydWJn?=
 =?utf-8?B?V2ZVUWVBZFpCTDNmMG9rSEZLYWFaRk1Uai96aFpRenVBc21UQU9vRzRBNjlC?=
 =?utf-8?B?cTNrVlVFYjB4VmVVWDBIcVhXczVQWFhTMkFOa0NPdDB2VE52azFKUWZ4bm5i?=
 =?utf-8?B?ZnBoUGd4UE5zNHlVVEt6NnFEYVNtcmtqYlpYY0FOa3lzdkxQcndBZUQyd3oy?=
 =?utf-8?B?SkNIWFFacndndkE4U0JnZTNOdmRyZEV6aElrSFI3S1c5VE13a245d3R0M0la?=
 =?utf-8?B?OFc0aGsycVhjaEdrTjJ0bHBia1NYdzRHdmU0aXJkd0Y0YlF0ZU1jZDhjOVBH?=
 =?utf-8?B?bWgrdnRaTjhXb3V5V1RjRnBqQjkzYzc2UzBPNEdTbE9lVWZnWjFRR0ZXSlli?=
 =?utf-8?B?TU5QUkRBSHZRMGpjeEZYNmtJcnlVZHFWV3Z5c3VHendWNHh0bUw3TTdHeG1x?=
 =?utf-8?B?VFR2OCs2VnJDVnNLTVVRNFUwUFEvMG81Q0pQSmlZdFk4TGg5aVlqMXFGSHdy?=
 =?utf-8?B?Q2xFbW1oV1EyQkwwckVCZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c29636-0ac2-4816-6b70-08d8d99df247
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 14:59:27.2563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhKROQv0PYIZ0OV2Kzk3afnLTDDpfgLdbmwAlNOh7H1NDGrlFKhi+GBfKWuUK5nF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3903
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_09:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250123
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/25/21 2:40 AM, Ilya Leoshkevich wrote:
> On Wed, 2021-02-24 at 23:10 -0800, Yonghong Song wrote:
>> On 2/24/21 3:45 PM, Ilya Leoshkevich wrote:
>>> On the kernel side, introduce a new btf_kind_operations. It is
>>> similar to that of BTF_KIND_INT, however, it does not need to
>>> handle encodings and bit offsets. Do not implement printing, since
>>> the kernel does not know how to format floating-point values.
>>>
>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> ---
>>>    kernel/bpf/btf.c | 79
>>> ++++++++++++++++++++++++++++++++++++++++++++++--
>>>    1 file changed, 77 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>> index 2efeb5f4b343..c405edc8e615 100644
>>> --- a/kernel/bpf/btf.c
>>> +++ b/kernel/bpf/btf.c
> 
> [...]
> 
>>> @@ -1849,7 +1852,7 @@ static int btf_df_check_kflag_member(struct
>>> btf_verifier_env *env,
>>>          return -EINVAL;
>>>    }
>>>    
>>> -/* Used for ptr, array and struct/union type members.
>>> +/* Used for ptr, array struct/union and float type members.
>>>     * int, enum and modifier types have their specific callback
>>> functions.
>>>     */
>>>    static int btf_generic_check_kflag_member(struct btf_verifier_env
>>> *env,
>>> @@ -3675,6 +3678,77 @@ static const struct btf_kind_operations
>>> datasec_ops = {
>>>          .show                   = btf_datasec_show,
>>>    };
>>>    
>>> +static s32 btf_float_check_meta(struct btf_verifier_env *env,
>>> +                               const struct btf_type *t,
>>> +                               u32 meta_left)
>>> +{
>>> +       if (btf_type_vlen(t)) {
>>> +               btf_verifier_log_type(env, t, "vlen != 0");
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       if (btf_type_kflag(t)) {
>>> +               btf_verifier_log_type(env, t, "Invalid btf_info
>>> kind_flag");
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       if (t->size != 2 && t->size != 4 && t->size != 8 && t->size
>>> != 12 &&
>>> +           t->size != 16) {
>>> +               btf_verifier_log_type(env, t, "Invalid type_size");
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       btf_verifier_log_type(env, t, NULL);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int btf_float_check_member(struct btf_verifier_env *env,
>>> +                                 const struct btf_type
>>> *struct_type,
>>> +                                 const struct btf_member *member,
>>> +                                 const struct btf_type
>>> *member_type)
>>> +{
>>> +       u64 start_offset_bytes;
>>> +       u64 end_offset_bytes;
>>> +       u64 misalign_bits;
>>> +       u64 align_bytes;
>>> +       u64 align_bits;
>>> +
>>> +       align_bytes = min_t(u64, sizeof(void *), member_type-
>>>> size);
>>
>> I listed the following possible (size, align) pairs:
>>       size     x86_32 align_bytes   x86_64 align bytes
>>        2        2                    2
>>        4        4                    4
>>        8        4                    8
>>        12       4                    8
>>        16       4                    8
>>
>> A few observations.
>>     1. I don't know, just want to confirm, for double, the alignment
>> could be 4 (for a member) on 32bit system, is that right?
>>     2. for size 12, alignment will be 8 for x86_64 system, this is
>> strange, not sure whether it is true or not. Or size 12 cannot be
>> on x86_64 and we should error out if sizeof(void *) is 8.
> 
> 1 - Yes.
> 
> 2 - On x86_64 long double is 16 bytes and the required alignment is 16
> bytes too. However, on other architectures all this might be different.
> For example, for us long double is 16 bytes too, but the alignment can
> be 8. So can we be somewhat lax here and just allow smaller alignments,
> instead of trying to figure out what exactly each supported
> architecture does?

Maybe this is fine. I think, "float" is also the first BTF type whose
validation may have a dependence on underlying architecture. For 
example, member offset 4, type size 8, will be okay on x86_32,
but not okay on x84_64. That means BTF cannot be independently
validated without considering underlying architecture.

I am not against this patch. Maybe float is special. Maybe it is
okay since float is rarely used. I would like to see other people's
opinion.

> 
> [...]
>>
> 
