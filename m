Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3E233CA4D
	for <lists+bpf@lfdr.de>; Tue, 16 Mar 2021 01:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhCPATU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Mar 2021 20:19:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33882 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230045AbhCPATN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Mar 2021 20:19:13 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12G0DExf002798;
        Mon, 15 Mar 2021 17:19:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=RPinfpSltmv2CnT8lr2YmIG15N7D8iwVesx7GafX4LU=;
 b=iIpBVBKzkG2njWCmQf0USIbkg8P6pZCfYjp2Jg88T+68zn4HoGS3dW92g9fkkl54jkl2
 r/V4sR5hm7dvFnHUu3XvgrYdjtomf+CN4E9LQKiFJZgapD3PmUN+ywTRjLvMqS6neosg
 WW1WcSve2NEdhVjcX5YcNnRP9Drx6GpZSaY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 378v3q3fta-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 15 Mar 2021 17:19:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 15 Mar 2021 17:18:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iunJWSkxIhxHsDrqfh7gT9ijkC/x3i07ysQOif5Tg3qmMfH0rU/AJ+IF7nRtVS7vpnzri/8YKIWYOGdNR0CNejkB7QLBTalb6iK4qupS0dTCf0I6nxj+FcU2rqi4BGfxTATxIW1O4BMwzy1RTclv6f5Eq7VMzMsna+UKHaRL3upJpp209OpM5faJ9Z2qzgDTKNHFpFDgk6iUU2fUBjPVp9Msq3HlvHitMFRYTWHFkC8N79RNcohdRyCsa/ItTBTGtBAFCyLlqbfDaYYmpuzWrUZnFX/0D24XqNJ2WZgIch949ye4TMQqTu2y7MjAtobeqwml3RgjH/JVS7wtyZEfkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPinfpSltmv2CnT8lr2YmIG15N7D8iwVesx7GafX4LU=;
 b=G1W1TG0dMDJ3Asp5He6h+RnpM1qHLfGo9KvOaYtPkpfPWmZNr8OBiDIzQRkwXvGvgOXVaECVeDTdMTYr8tFUFF6HNzmb8R0klF09bz18krEzht9ZXLfn0RXQE1Af0WLCYS47tW8Aek6VFjN5psaUxTW4hevbDM8fFgsQ+hzQBj62LaZl2gJAYH1k1sbWxfpdfPVzlfTVrpRWv/RZyPmHyCnAmvIyz7ZmjPs646mZ9UHueBXAFupYdlWVY0hxPmJgbV9+Kd4RnzQJVsvFpuNDhO7jvzMs/LxFw/tk7vQJGLyyhm3DPVicB4APY72t4fLIKNmO+KWacKLSM61fWL8MrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2063.namprd15.prod.outlook.com (2603:10b6:805:f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 00:18:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 00:18:57 +0000
Subject: Re: [PATCH bpf-next] bpf: net: emit anonymous enum with BPF_TCP_CLOSE
 value explicitly
To:     Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>, <kernel-team@fb.com>
References: <20210314035812.1958641-1-yhs@fb.com>
 <2b98276d-62d4-721d-a956-80ed1d71987a@iogearbox.net>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <e29255cf-89aa-0a7a-e19e-3175463bf784@fb.com>
Date:   Mon, 15 Mar 2021 17:18:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <2b98276d-62d4-721d-a956-80ed1d71987a@iogearbox.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:6e1f]
X-ClientProxiedBy: MW2PR2101CA0012.namprd21.prod.outlook.com
 (2603:10b6:302:1::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::104e] (2620:10d:c090:400::5:6e1f) by MW2PR2101CA0012.namprd21.prod.outlook.com (2603:10b6:302:1::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.2 via Frontend Transport; Tue, 16 Mar 2021 00:18:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5bcff84-fd47-4f5e-0f85-08d8e8111738
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB20637C39E6DA76757972EA6DD36B9@SN6PR1501MB2063.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YYeGOtxCUQ7wQBSdg1Pp40z4EqnCBreqaq/wPq17vPcdCxtAITBtZejGgUGjAlq43EiR2dIiByHUQO2AB0eGtEob4e4iyEw7InUTmEg9cdG0RS6X6boYBP05BUz+3FOGpTSih1HlhLgTWlgvOUqQtzCx3rYmvq+2D2ae2hU6fqFTS9Eng2zuGvAVwb24YvR3X77LH/ock2ecH/5d60C2GKBeW5GbQPkwDhmcB46XMYWzv1mCUWu49yhsQepKu6ALgLcm7zDF6tilIL39OcarZ1j3XT7OHswtENuUvRN0RWDq5tajls+sKphogD0Oa0PFwxZy1PBQ9ljbpEn/fw/vgaftRaDuaxFY+fQe+XOgr5NYf5z2XVwlJioDUX7xF45pHQExhn/NiFk38JS1DfwT8vfhV0FCnf4K6AThs0An8odmOzIrl+lHtfhPVXd/mWuco1Vz1JHZsxPwMt5oiA7BmfzpOac+Dvy7CLDGS64kmzH5cIhS7UHdoRfnCiDxTj2586RGYJbyQMRw3Y0xbp5Rx3ZhDuebXNroKuF17uP8B57ctb1kO/gpU5SVfC/KrGEGDVdahBT1RsbaSuS9Az70Rsmnblfq/ztPZWN29z72xv8aS+5fLPHv+u7/L0dzx9uvhpcOUVkRPKDiKCxIfQfmbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(39860400002)(136003)(396003)(6486002)(2906002)(2616005)(53546011)(86362001)(66556008)(31686004)(52116002)(66476007)(316002)(83380400001)(16526019)(8676002)(36756003)(31696002)(5660300002)(478600001)(4326008)(186003)(8936002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SldiSy9DOCtzOEpyNk5IcTFKZVo4dTFKcDFIeVJHcDcxMlhwT085WGlPSUw1?=
 =?utf-8?B?LzBMRzFUNDJocUd1WEtqNWd1clBQWFNjWTNsUnA1QmY3UmdSaDNuT0thMmM4?=
 =?utf-8?B?dEUzcVAySmVpQUFzTmRYeEozZy85c0ZjN3EveU00UUsrQ3doVFNUWldrbXVW?=
 =?utf-8?B?YjB3RHluYk9FUkJ6QkNnV0NmcUpEeHhRRjRnN1Y3bitmZ08rZ0lsOEU3M0hr?=
 =?utf-8?B?b3NJOS9RcG1lUFdJbnJxclkrYUI0aGxDc3NqY20xbmNORWZ3QnB5NW5vNi80?=
 =?utf-8?B?Y3dDUmJsZkNYcW84bE1wWnVES0ZUZnh4VnVpSW9KMlROemo4cm8yZElSTVhq?=
 =?utf-8?B?SEFNc2NYNkYrZ2RBVW82disyT240d2FES3AvRW1RZW1mMTJzd3ZXc3NyakFV?=
 =?utf-8?B?MjUrdVp4U2ZKWWpuYzl4dzMzeFVCZitkUWVycEwzL1R4RWlaNEt3M0dPWmlh?=
 =?utf-8?B?NGNSTkVxN0ZERmNkUGNMOE9KQVVYdTN1cXlvRi9VNHFNL2tvcDhhT1gzNWlG?=
 =?utf-8?B?RGV0bmNOVEVSeUFVWDFGMjVwSTg1NVFZWEhKRm91b0pPL21RL3Yzb2lkLzI1?=
 =?utf-8?B?TXE1UDRmUnVZd2xXSm5remxBRnhOWTgvZVplWlZJcEpaaEhrZFlGVEoyNXBM?=
 =?utf-8?B?OS9IRnZZWXdCVVJjbTEvVXdIV1dCb3p1QzcvNTlVRG41MUIvRndXR0l1RTVh?=
 =?utf-8?B?QXQrT2FqQk9rK3Z5MXV4WEw5UUcwZmdDYnVuNUV4ZXhxZTFyRGg1MHpJOVN1?=
 =?utf-8?B?SFJiUzdVNkQ0cjArRDJFblBOaVB4eFh6blFvUUlOTkJodkN0clNzOXByTE1N?=
 =?utf-8?B?Q1E1Ym5XUWpwY2V5ako5WnN2N04wVEJxRzhISW8xQXZsakkxbHZoNW92NDhU?=
 =?utf-8?B?UFVLRm9CeWltSkNIRkQ3N0IzZmJZaGk0ZGxQczErL25PUmlJbm1yZHJTekZ6?=
 =?utf-8?B?ZEVjd3hqNS9FdFNxM0QwVDNKTnRaSURGZWtnU012UTlabURRV0d2SjZUZC9G?=
 =?utf-8?B?b2p3WmV6WEwvQkw0UHpKVGxYNUdBTUsvN2REcWFWdVlmYjlXMFpiT2l0U1oz?=
 =?utf-8?B?eHVoUVVLZzlvVk1MTWZCZkJuSXB0SGxtcUZxaFpVb1grNjRwZnhhQUI2VGph?=
 =?utf-8?B?alFCUUlXOGtJWXJselVzUGNtbnV6NkZvSEltWEF5S0ppb3NuOFVYeGVWWFlM?=
 =?utf-8?B?OUVOZzVLMlE1QURXUnBmMXBnZTFodXhRb1lGNzY4NHdmTEE1U0llSkdMa3NH?=
 =?utf-8?B?MEl6U0l1TFl1V1RUcWl5dm51WHFkOEpZaHF5bktDZFl3K0dDUWp3UVhOQkJP?=
 =?utf-8?B?eHlvSUJyK0J6bE1JNkpUS1RIVzY5U1JLa1haNFhGRUJNTTVCcGxIU1VvazRU?=
 =?utf-8?B?dnJLYktldFFXRElsTE8yelpUNFp5RlBNZTYxREcxWDZuT01DMThTS1ZVem1q?=
 =?utf-8?B?QVZUMHk5dlo5MTczQ1JnZG02TStSOENIN2xkSmJFY0thbFp4TmtFTVRGRVA0?=
 =?utf-8?B?eFo2eGwza3FxWENBNEc5NktrU1BHRnhkZC93U3EyYkowM3FDbFNUR3lYR1pl?=
 =?utf-8?B?RjM1K2x6ZStUS3VkOVJwMzFBZkFWZFpFdDUrL2FJcmxhZ1ozYTl3K0FiMDdq?=
 =?utf-8?B?SVBWdDZWK3dTZTFkWTVjQ1dsUEkwZjVXMGFQL0U1bDhKNjBmRUl4TTdkaHAv?=
 =?utf-8?B?ZDJoL1VPUEZLbDM0Qy9pbkZUTXRETkErU3p1OHBFVDNQa3ZkNys1MG1kb05r?=
 =?utf-8?B?ZG1ScnRHdnZtaXZlNnJNRmlMVjVRRWdpajRjL2dqRHB1bWxDNElaU3dva0NX?=
 =?utf-8?B?MjZ2Qmk0VnlnMzNobXN3dz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5bcff84-fd47-4f5e-0f85-08d8e8111738
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 00:18:57.6212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3UHXRwo1aKe2FYGl2UKa9E8t2Aqifno/6MWba95ouypVPTFncu2UbYLSYJ7l1mJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2063
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_15:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103160000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/15/21 4:33 PM, Daniel Borkmann wrote:
> On 3/14/21 4:58 AM, Yonghong Song wrote:
> [...]
>> This patch explicited add an expression like
>>    (void)BPF_TCP_ESTABLISHED
>> to enable generation of debuginfo for the anonymous
>> enum which also includes BPF_TCP_CLOSE. I put
>> this explicit type generation in kernel/bpf/core.c
>> to (1) avoid polute net/ipv4/tcp.c and more importantly
>> (2) provide a central place to add other types (e.g. in
>> bpf/btf uapi header) if they are not referenced in the kernel
>> or generated in vmlinux dwarf.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   include/linux/btf.h |  1 +
>>   kernel/bpf/core.c   | 19 +++++++++++++++++++
>>   2 files changed, 20 insertions(+)
>>
>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>> index 7fabf1428093..9c1b52738bbe 100644
>> --- a/include/linux/btf.h
>> +++ b/include/linux/btf.h
>> @@ -9,6 +9,7 @@
>>   #include <uapi/linux/bpf.h>
>>   #define BTF_TYPE_EMIT(type) ((void)(type *)0)
>> +#define BTF_TYPE_EMIT_ENUM(enum_val) ((void)enum_val)
>>   struct btf;
>>   struct btf_member;
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 3a283bf97f2f..60551bf68ece 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -2378,3 +2378,22 @@ EXPORT_SYMBOL(bpf_stats_enabled_key);
>>   EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_exception);
>>   EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
>> +
>> +static int __init bpf_emit_btf_type(void)
>> +{
>> +    /* bpf uapi header bpf.h defines an anonymous enum with values
>> +     * BPF_TCP_* used by bpf programs. Currently gcc built vmlinux
>> +     * is able to emit this enum in dwarf due to the following
>> +     * BUILD_BUG_ON test in net/ipv4/tcp.c:
>> +     *   BUILD_BUG_ON((int)BPF_TCP_ESTABLISHED != (int)TCP_ESTABLISHED);
>> +     * clang built vmlinux does not have this enum in dwarf
>> +     * since clang removes the above code before generating 
>> IR/debuginfo.
>> +     * Let us explicitly emit the type debuginfo to ensure the
>> +     * above-mentioned anonymous enum in the vmlinux dwarf and hence BTF
>> +     * regardless of which compiler is used.
>> +     */
>> +    BTF_TYPE_EMIT_ENUM(BPF_TCP_ESTABLISHED);
>> +
>> +    return 0;
>> +}
>> +late_initcall(bpf_emit_btf_type);
> 
> Does this have to be late_initcall() given this adds minor init call
> overhead, what if this would be exported as symbol for modules instead?

If issuing types in module, if I understand correctly, it will not be in
main vmlinux btf, so programs will not be able to use unless module
is loaded. I would prefer such types always available in vmlinux btf.

I am using a separate late_initcall just to cleaner codes. But
this BTF_TYPE_EMIT_ENUM can be in any init call.

$ grep _initcall *.c
btf.c:fs_initcall(btf_module_init);
core.c:pure_initcall(bpf_jit_charge_init);
cpumap.c:subsys_initcall(cpu_map_init);
devmap.c:subsys_initcall(dev_map_init);
inode.c:fs_initcall(bpf_init);
map_iter.c:late_initcall(bpf_map_iter_init);
net_namespace.c:subsys_initcall(netns_bpf_init);
prog_iter.c:late_initcall(bpf_prog_iter_init);
stackmap.c:subsys_initcall(stack_map_init);
sysfs_btf.c:subsys_initcall(btf_vmlinux_init);
task_iter.c:late_initcall(task_iter_init);
trampoline.c:late_initcall(init_trampolines);
$

I think we can use any above in kernel/bpf directory. This way,
we will have 0 runtime overhead as the code will be optimized away.
Any preference?

> 
> Thanks,
> Daniel
