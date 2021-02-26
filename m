Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A184A325D46
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 06:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhBZFoM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 00:44:12 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19724 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229598AbhBZFoM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 00:44:12 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11Q5ZZVN008308;
        Thu, 25 Feb 2021 21:43:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=xYj/JXZgsNZjS1R0TAHynvBjOOlnmWrgtTwx1gUi3yM=;
 b=O3iqQs1nAN5G82MBYZ3BIGC2hQxXluXOqxST/KYQ6tqgs4uHDhGTEW4QxbUw5PVQKxX0
 ZrshGwOG2Kq2QtDCwsniLChy2ezVbmcMF/ho2SwvrYdixgi5ayKzCtGEhwycjFGspSjF
 fdrikv1CMOnnG1LpHT9BXvqQmSdY4CXJVDw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 36wncfv8fs-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 25 Feb 2021 21:43:12 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 25 Feb 2021 21:43:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZ59vHteArM8StqJXOUMJC8zbibmhQUfrx5CRKodljPn179oA6wSQVErKLMI8T0ggW6TC0Ow46OB5BgXzTAEx8H0VEjExHNWdOtG8zQdYP4OIGZODiyeV8x4K0xNBPIkuHAoK08pZFa7xz6NDNDSVXhbz5jQwwdF5wRJSDYbINRJR9JPx8JyueOHEvpkHm6d+6jqDSU++wRKDXjDGvJSKXxSeuPX2dhjSWFvfXTiWuLv7dba6sSvaA9qOM6nmXS8P+o6ggUNdt6fto9guResHETgs3gUDkFBEqxFm8YqQOMfZkaVnB9Yb+jngWiw8Ue3FjdTg7wS1/gKsURXidAgxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYj/JXZgsNZjS1R0TAHynvBjOOlnmWrgtTwx1gUi3yM=;
 b=Z7PUVFZkgqK354P/Tofa1HWSiaXCnlhEmpC/acxHXHE0cEFTx7p+U8vJF+0v69PDesxxzqWF/VCzuISELLBE69ht27YJVS4pT20sMNOcMYkhRWoeFbANMhKisyisiC/bWWJxkMOdcVRg5xrzznKKASzWOHlvCbh9uTFmmKHnh0cUOxsfiut1E2DtF3LSW/3kuODt/qUpWUJvtqcDqZlPE7XeBcoJ9OOJZhuZ+pg9CMWTQRjB7nPdJCcROctqNaB+CinvZ5ynn8teKwn8iOruWYcjWcgFMaatGbpj5ua9cv5eA7vFFh855tCPHoJXSke8q4qgOhmworh6iJO8+v97VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB4014.namprd15.prod.outlook.com (2603:10b6:806:8e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Fri, 26 Feb
 2021 05:43:10 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93%6]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 05:43:10 +0000
Subject: Re: [PATCH v6 bpf-next 6/9] bpf: Add BTF_KIND_FLOAT support
To:     John Fastabend <john.fastabend@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     <bpf@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210224234535.106970-1-iii@linux.ibm.com>
 <20210224234535.106970-7-iii@linux.ibm.com>
 <e7957fca-b938-e50d-74f5-ecc40145eb4d@fb.com>
 <6962feb05a62d718e5d430f782012d71d6c73eed.camel@linux.ibm.com>
 <fbd33830-2f16-23a4-0c31-91bb4bd95ee4@fb.com>
 <603854b45b4a7_5c312088a@john-XPS-13-9370.notmuch>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <2966c2fd-8b98-a89d-0e86-505b4cc9dd9b@fb.com>
Date:   Thu, 25 Feb 2021 21:43:05 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <603854b45b4a7_5c312088a@john-XPS-13-9370.notmuch>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c091:480::1:1f06]
X-ClientProxiedBy: MN2PR17CA0003.namprd17.prod.outlook.com
 (2603:10b6:208:15e::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c0a8:11d1::15dd] (2620:10d:c091:480::1:1f06) by MN2PR17CA0003.namprd17.prod.outlook.com (2603:10b6:208:15e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Fri, 26 Feb 2021 05:43:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8eeeafdf-8a3d-42ab-302e-08d8da196691
X-MS-TrafficTypeDiagnostic: SA0PR15MB4014:
X-Microsoft-Antispam-PRVS: <SA0PR15MB401461918C55E5F2D1078171D39D9@SA0PR15MB4014.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uppnBydEJjjljLcLDPz9HJKeA+k3sTbkCcFianSKgFrYRzJRvKPylCM5plaok6LnHrn4efRxyovQbmP/HE6TWiubV9TcWE185xyLXsHm3HnaJ+ajTAfDRJSdCR0LiTTrjiUx/R+0RDwCau6C6hr8AraqXawZhWahIcFecL+iTvAonomD51MG2UfR2TjE3q+SoiQoL7b0uxjv0K4SJH0qEy92dBFQ27RDQjTcRP1CB0IMfjrhSSv4uEvYSFdv9h9uYAVHh4eHVsF6XPxf3I+TrJBkmleWSAtgWcfiW3y6B46udbNDMfBqJirRgdTndGIHxc8H/VDc7bDV8bHfazkQIJkqiwGoRTt65TpGLaKRzX5gQPZog14FgETw4kElEOqVMfjQS3PgAFB5C4uJakcI65jv5eRhOvK9TZfL4aSwsOj/1+ySRn+ui8f0buuBNa/fPbxE1acYHp4vNJeNDPTeEjCQ0hlyvr/BtKOGw7ywlkxrnut4sMeRotSoZtSUVZZyvgQG8d/a1jw5UlZpQpz1F03NN+MNBGogCHzHMc/+iHOYJqnXhGpGOd+DOPKI4DajQjr+5hKCAMjpRRmkMbtAOimD2+OT7SLEe2hQOJKcVZA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(346002)(376002)(39860400002)(66556008)(31696002)(36756003)(52116002)(66946007)(6666004)(5660300002)(53546011)(8936002)(316002)(8676002)(478600001)(186003)(86362001)(4326008)(110136005)(6486002)(83380400001)(2616005)(16526019)(54906003)(2906002)(31686004)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V2RrWTBZb1V2aE9jMkNBZFZWdHI0WHZFL3M1d2NFczlBVzR6bXVTOTF4aElZ?=
 =?utf-8?B?dlBYeEpwV0duMjNtejNiTDZsbjBjUlpLU2ErOVllaGg0dE1CaEtwTkJZakxq?=
 =?utf-8?B?U216ZVhqNm0zc2dVVUkwMS9KS3NsUWFzWXlMeUFUSVdhMlZTcFZhQUw4UzBR?=
 =?utf-8?B?ZUdDSER1ajBDNUp6Y0xmM2NLc1BPcyt2aUU2S0lrdUk5d1pKZFVHS045STZp?=
 =?utf-8?B?YkdFbTFVQ2NNN2h0dW9Ra0czaWY2VjZBc2Z3ZWJyWkd2VUJmenA0MkVEVUs5?=
 =?utf-8?B?dmtrcXAzMUNWUnBFbmptcXlES292eEVVL2pPbFY1Z3ppSU5XUDdabXFQL24y?=
 =?utf-8?B?SjVUTHNIREhMZWN0UTNhYWwzV3YxUEtOdE4xcTlYd3Mwbk0zbFFVWjZnMk55?=
 =?utf-8?B?MGhZcm1OdWdoV2ZHeVVFZWl5Q2NUaXBFQ2VDMXJNSEluZ1ZpKzNUbEZ5bklN?=
 =?utf-8?B?NC8ra1RIZWxObmNvMjVtQmJoSldHWko2cUl3aTFaL1kyWHlkWC91TGQvWm5L?=
 =?utf-8?B?bmxoWU1ZeU52ZlZ5bTluK3pab1dDbExIeDJrY0U4WFh6QkhuSklVOGU3N2g1?=
 =?utf-8?B?QU81TTVrUWJiZUxVQmRyeXY0SFNZWXZacWIxbldyMjg3ak00RWo2RVlhcVZ3?=
 =?utf-8?B?NVJoWHBUUFBYem5DekxMQ2VaQnIyWXJoSmJ4TjlLbkFKRndMNDNaOVpSWklI?=
 =?utf-8?B?NFFqb2VjS3F1bGFNRFNwUytFa2FDSGY3MDA1a00xZnpaenQxdGRHWHF3b3Rz?=
 =?utf-8?B?N1lZSVBmQUZxQlduQ3pnUGRWeWkrblNtRDE1SnNwaEgwbm1icTRIMmJWVytz?=
 =?utf-8?B?TWdSQnhuNFQ5Z1VxWjVFTngwRHlROW93eHUrZldIeUhwRTI1ZktuUkgya3BQ?=
 =?utf-8?B?L0VTNDJmeVc5U2xxd2FSN2dJYitWcHBqc1QzbGNKY29nN05uRmZ0eTFYdWRP?=
 =?utf-8?B?Wk5EaWphWStkMUZZdlVzSHpObzRtUmsyb0luMmF4RnZmMnp1S0h4bi9DSDZW?=
 =?utf-8?B?TXBCMHBKYzBPQnFONkk1STdZVXNUY1FhQlZHcVlIbHZ2NG4wYkZ4TEZyS2Na?=
 =?utf-8?B?NTJWT0VBZG9QOUFDZlFRbEUraG5nTVpYZzQybVM4S2o3NSt1V0RWVkF5NXlR?=
 =?utf-8?B?UksyelQvVDdIdnpnMHZDR2FSbUkrWGNBVlVHc0Zpdk9OTnFVdWt0T2JSQ3c5?=
 =?utf-8?B?UkoxSUxjRnEvRTV4MmxxSzZJaEE1MVE5NUNuM2oremJrYlBsd3RsQ09UOTRn?=
 =?utf-8?B?V241RU4vSFVFRWdmMytNSk1oYmJjV08wWjBiYjFBTmJlcWVPOWx0TlovVnBC?=
 =?utf-8?B?R01RSU00Wlh6M0x1dDJIY1h1VGpJV2Fhb0REM1FPZ3FmZTFVMG5nb2VBemhT?=
 =?utf-8?B?UldWeUtEUEM1U1psbFJQTDlHSEt0eHFBQnUrZUg4QTlUSzJiNk5Jc25RTWlN?=
 =?utf-8?B?Z04rVmtha0p3Qjk0VEpxTnBsR3lxZkxrbklWeHpKZllGbDMyR2EwNmRMSlBn?=
 =?utf-8?B?RVZWNXZBSS9YckhHWE9PTFZZTHlqZ0VUWkNUQUZKRisxT0IyL1huQXhzTCto?=
 =?utf-8?B?czBZeUZiUXVVV2FGTUNiNEhsK2ZFMXc4RTZyaWxzUWlZMFpqdk9kbllpeFhv?=
 =?utf-8?B?TVFsVFoybS9aMzFnb1hBdHNobmVSbzJ1L2REbm5ESEZTZHBsYlVvcWYrL3BC?=
 =?utf-8?B?c3dqR21icGxxYlRoc2M4ckJGZlMyWFpyRWNhVy85UDEybzJDeDE0SWdrdkVW?=
 =?utf-8?B?akVVRXBsWlIwTTQyS1V2VWdjVXRVTmxaYVhPTXFrc25FWHMwVDRGNE51aGdo?=
 =?utf-8?Q?TCVeteoF2+u0Z9XVuB+4VbZY/IDPjBC2T5zx4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eeeafdf-8a3d-42ab-302e-08d8da196691
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 05:43:10.4602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYcWuTIgv3AeUnAVLg2AbAWWZlP+WdSSEKndIS/70CqFYHouYrRtq6c062dXITrT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4014
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_01:2021-02-24,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260043
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/25/21 5:53 PM, John Fastabend wrote:
> Yonghong Song wrote:
>>
>>
>> On 2/25/21 2:40 AM, Ilya Leoshkevich wrote:
>>> On Wed, 2021-02-24 at 23:10 -0800, Yonghong Song wrote:
>>>> On 2/24/21 3:45 PM, Ilya Leoshkevich wrote:
>>>>> On the kernel side, introduce a new btf_kind_operations. It is
>>>>> similar to that of BTF_KIND_INT, however, it does not need to
>>>>> handle encodings and bit offsets. Do not implement printing, since
>>>>> the kernel does not know how to format floating-point values.
>>>>>
>>>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>>>> ---
>>>>>     kernel/bpf/btf.c | 79
>>>>> ++++++++++++++++++++++++++++++++++++++++++++++--
>>>>>     1 file changed, 77 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>>>> index 2efeb5f4b343..c405edc8e615 100644
>>>>> --- a/kernel/bpf/btf.c
>>>>> +++ b/kernel/bpf/btf.c
>>>
>>> [...]
>>>
>>>>> @@ -1849,7 +1852,7 @@ static int btf_df_check_kflag_member(struct
>>>>> btf_verifier_env *env,
>>>>>           return -EINVAL;
>>>>>     }
>>>>>     
>>>>> -/* Used for ptr, array and struct/union type members.
>>>>> +/* Used for ptr, array struct/union and float type members.
>>>>>      * int, enum and modifier types have their specific callback
>>>>> functions.
>>>>>      */
>>>>>     static int btf_generic_check_kflag_member(struct btf_verifier_env
>>>>> *env,
>>>>> @@ -3675,6 +3678,77 @@ static const struct btf_kind_operations
>>>>> datasec_ops = {
>>>>>           .show                   = btf_datasec_show,
>>>>>     };
>>>>>     
>>>>> +static s32 btf_float_check_meta(struct btf_verifier_env *env,
>>>>> +                               const struct btf_type *t,
>>>>> +                               u32 meta_left)
>>>>> +{
>>>>> +       if (btf_type_vlen(t)) {
>>>>> +               btf_verifier_log_type(env, t, "vlen != 0");
>>>>> +               return -EINVAL;
>>>>> +       }
>>>>> +
>>>>> +       if (btf_type_kflag(t)) {
>>>>> +               btf_verifier_log_type(env, t, "Invalid btf_info
>>>>> kind_flag");
>>>>> +               return -EINVAL;
>>>>> +       }
>>>>> +
>>>>> +       if (t->size != 2 && t->size != 4 && t->size != 8 && t->size
>>>>> != 12 &&
>>>>> +           t->size != 16) {
>>>>> +               btf_verifier_log_type(env, t, "Invalid type_size");
>>>>> +               return -EINVAL;
>>>>> +       }
>>>>> +
>>>>> +       btf_verifier_log_type(env, t, NULL);
>>>>> +
>>>>> +       return 0;
>>>>> +}
>>>>> +
>>>>> +static int btf_float_check_member(struct btf_verifier_env *env,
>>>>> +                                 const struct btf_type
>>>>> *struct_type,
>>>>> +                                 const struct btf_member *member,
>>>>> +                                 const struct btf_type
>>>>> *member_type)
>>>>> +{
>>>>> +       u64 start_offset_bytes;
>>>>> +       u64 end_offset_bytes;
>>>>> +       u64 misalign_bits;
>>>>> +       u64 align_bytes;
>>>>> +       u64 align_bits;
>>>>> +
>>>>> +       align_bytes = min_t(u64, sizeof(void *), member_type-
>>>>>> size);
>>>>
>>>> I listed the following possible (size, align) pairs:
>>>>        size     x86_32 align_bytes   x86_64 align bytes
>>>>         2        2                    2
>>>>         4        4                    4
>>>>         8        4                    8
>>>>         12       4                    8
>>>>         16       4                    8
>>>>
>>>> A few observations.
>>>>      1. I don't know, just want to confirm, for double, the alignment
>>>> could be 4 (for a member) on 32bit system, is that right?
>>>>      2. for size 12, alignment will be 8 for x86_64 system, this is
>>>> strange, not sure whether it is true or not. Or size 12 cannot be
>>>> on x86_64 and we should error out if sizeof(void *) is 8.
>>>
>>> 1 - Yes.
>>>
>>> 2 - On x86_64 long double is 16 bytes and the required alignment is 16
>>> bytes too. However, on other architectures all this might be different.
>>> For example, for us long double is 16 bytes too, but the alignment can
>>> be 8. So can we be somewhat lax here and just allow smaller alignments,
>>> instead of trying to figure out what exactly each supported
>>> architecture does?
>>
>> Maybe this is fine. I think, "float" is also the first BTF type whose
>> validation may have a dependence on underlying architecture. For
>> example, member offset 4, type size 8, will be okay on x86_32,
>> but not okay on x84_64. That means BTF cannot be independently
>> validated without considering underlying architecture.
>>
>> I am not against this patch. Maybe float is special. Maybe it is
>> okay since float is rarely used. I would like to see other people's
>> opinion.
> 
> I can't think of any specific issue here. From the program/BTF side
> the actual offsets of any given field in a struct are going to vary
> wildly depending on arch and configuration anyways.

That is true.

> 
> I assume if a BPF program really needs the size then
> __builtin_preserve_field_info(var, BPF_FIELD_BYTE_SIZE) will do the
> right thing?

For __builtin_preserve_field_info(var, BPF_FIELD_BYTE_SIZE), libbpf
should be able to check vmlinux to find correct field size and use
it.

All my above opinion is for bpf program BTF. I agree that if libbpf
CO-RE kicks in, we should be able to get proper aligned size/offset.

for float, if I understand correctly, we don't print data yet, so
even print, maybe just bytes, so alignment requirement is not critical.

Ilya, maybe just add some comments like different arch has different
alignment requirements so here we just ensure minimum alignment 
requirement this way we ensure types after CO-RE can pass kernel
btf verifier?

> 
> Thanks!
> 
