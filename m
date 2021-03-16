Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B5E33CA4E
	for <lists+bpf@lfdr.de>; Tue, 16 Mar 2021 01:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhCPAYQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Mar 2021 20:24:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47806 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229588AbhCPAXi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Mar 2021 20:23:38 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12G0EDXS010014;
        Mon, 15 Mar 2021 17:23:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : from : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=wpEDm33MV46Bathv/pJve7gBTmNVPmIQiLRk06jVhic=;
 b=Gmjpx6olzpKD7J3XBMC6VYPqgX6xc332vqeOvCWhdgaL4QrMAD5PqKf5rLs/6/QNMTyA
 qIiZIL/Io1xPu1+MefSUNXpHIbnMAcYP4q0IamxUX094Cjp5YA7Pnj/qfdNdDrhPe/RE
 7pqcW5PNoV29ldju1ENPdm7AB4Gg2d2M2tk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 37ah40r9b2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 15 Mar 2021 17:23:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 15 Mar 2021 17:23:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEsw/xovkLa8Zp7fszLwwqYfaQHN4qzZmgvfZvGUBvM1/CE5EoG5lWqebnWT0r88G0kuSZY/zz9tNQH35nv0awSC9RDrfWDag3dAY2l1av/sob1y9lmiQI+7+aJwPkzaEVN7hUQR5Lgg84j1/kSSyGZFweO3kuYosIm//pR4cECyqXaHJlbCSH97DXZz0N5wM9eWal8X4Izu0wxNQGE0jSauC/67z8FWEePY60YEwow+1rSubd20d58sit/EVBkEzo89fcJYjPCkdyhi0WHsU7TsA9Q3bmo3WCtVvaX9Dw3XQjrxiymu0WziZRvw26E6/5e/yiFkNMlqLgMQd37AEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpEDm33MV46Bathv/pJve7gBTmNVPmIQiLRk06jVhic=;
 b=SIg1sZYGysRJwbw5Dw7a/B1IrBR0QYIz+4DDvr3g5czBiID649RkUVTTTmr+WEgKJ+uvOGzxD2KtDHoM1VT9+EKMV/Wp/0IO7+KiLQUQsVxrsLYmb879+b5/DVEhMczyMSArhL6HM44HcxjbtmsG/pq1Reub+iZiM3bJPyqx8pIs5qf2k4awB1ufv6zsrpY5yRLFj3kl7Cgg5tBeevmYSXFCUvh8z9b5Shyq5pqhccGAY7r0It1M01K8/35WIWbmC1Q1dtVrKnZQcugEkOBbSYGTr89KH4gZm4hRYDkkpxBSntKoS/90iVK2zLk82p6035GLdWywCMAChCZDRgMxiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB4014.namprd15.prod.outlook.com (2603:10b6:806:8e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 00:23:21 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 00:23:21 +0000
Subject: Re: [PATCH bpf-next] bpf: net: emit anonymous enum with BPF_TCP_CLOSE
 value explicitly
From:   Yonghong Song <yhs@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>, <kernel-team@fb.com>
References: <20210314035812.1958641-1-yhs@fb.com>
 <2b98276d-62d4-721d-a956-80ed1d71987a@iogearbox.net>
 <e29255cf-89aa-0a7a-e19e-3175463bf784@fb.com>
Message-ID: <af511a4e-bdae-e8c2-4455-afb1fec0bedd@fb.com>
Date:   Mon, 15 Mar 2021 17:23:18 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <e29255cf-89aa-0a7a-e19e-3175463bf784@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:6e1f]
X-ClientProxiedBy: MWHPR14CA0021.namprd14.prod.outlook.com
 (2603:10b6:300:ae::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::104e] (2620:10d:c090:400::5:6e1f) by MWHPR14CA0021.namprd14.prod.outlook.com (2603:10b6:300:ae::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Tue, 16 Mar 2021 00:23:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85e05429-3cfa-4d3b-0157-08d8e811b48d
X-MS-TrafficTypeDiagnostic: SA0PR15MB4014:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB401492403B66620BF7ED9B6ED36B9@SA0PR15MB4014.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58taettWpTzR/VeYSB4hFQ7IhJDNBf0Uvfp8kQyPTgj1lTpQekrYY01KgilM+EWYDr1Ea+EQ7Roa4PIE5/wcn7FmIcSo4WRX3fABcwFvivmsRlRx/lcKni3Ebyrq8h7KKgP11DYzS1OkjMDAVhdm2Lx1RewppGunfTo2sf1AQXJJ7jALsPJfsGqyUWzjGocpSKTJ1IJ9ibzUWutMQEkBIHkdQvVtwMGu3x71ShhG7YoBblR6WMuR7hMkMmZBdZ95m50+bqyKtt0EYRV9VgGiKJglHPxJras+JV+gMBGRpKpz6qHNP4MaGapxV4qgwsuZn7/Ko5kolJtfLe+vjx8YnGGLLAxBr8iW34OEgZ7+b3ZgbewAx/+8ro+wSZXipLw7ZCZ8k1CKuGH5Tp0KAGu5FaXLdMndeIBslWerYLtB1W2RWrhrQRqtFHEKrOq+MJtEBthHNHeuo+9c4hDdnHJB6Pvwj7foUDklQzOeZJJWOXZ9+efozY+0x0hqMFxA7rbw2HyspQgD0jVNsLPfqIcBaQQu4yjTrlkmACzYtHZqdeODZTLfKoV2Nz3tqx6gFNjRjYNzttFCFCoS7sgIU/8mfdVLLeUshSNMNU20tyqOjvVRQCDhunP89OHkPeTzECn8h2WZ+pwZOiQtXBheCR6t5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(366004)(39860400002)(316002)(6486002)(86362001)(8676002)(36756003)(4326008)(31696002)(66556008)(66946007)(53546011)(31686004)(83380400001)(2906002)(8936002)(478600001)(52116002)(16526019)(186003)(2616005)(66476007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dnVNbWkxTzhBNDY0Nmt6eitsOXNWTkN5OW9pOWVhWDJreThNbjVGZDJOUS9O?=
 =?utf-8?B?SnZpZTVvSjlvd2o3QkNHc0o4NnMwckZJd3gvTVo4WXd6TWF0ZVlxbDRmdU1n?=
 =?utf-8?B?SlRMMDhoekJIS3Vkakl2SkhtWmV6YVJBdjExYTBYOGtHN1NGVDR6VXpHOTZD?=
 =?utf-8?B?UXJBOWJlMVVoMlZKYmRrMjJ1MGUrSFVOOFh2K25QalJxTUhSNWJzdmkzNHhq?=
 =?utf-8?B?TlVSQzAzWS9pNUFoaG9meStkTHRpQlE1b09YZG9QVzU5UlZsZUY4aWJMb2hs?=
 =?utf-8?B?ck1sdnZXTjB5T1pDNDl2aHdZMFpPbndrSWFKWHR4dHBlVzQ0NXZ6MjdJMFJl?=
 =?utf-8?B?dHd6dTVzWHZpWXNYSldMcjIzdkZjRTgyY2lOeWtnNkNuSkFPS0pNUW8xL3p6?=
 =?utf-8?B?MUhIK1VZOFZIRlZWN1l4MVJ0Q2g1bEhTT09FeWMzV2twREZyWmhLMFI2ZnZz?=
 =?utf-8?B?cjhJV3JWMnVoaDIzZmxXTk9wY0tzRzZrTlFjUVFSbDBpNnc5T1J0bklsenRl?=
 =?utf-8?B?MEFLUFpMaGMrWXNPb0NpUVdjdFhGb1N4ZzJDRXVGcm92Z2pLYnNpd1VldUtX?=
 =?utf-8?B?eHltZm93YWxtZFdGMjZwc2NkTUVLUmpXUkdCMEJ5c1FrVTI3QW5MTmpEckwr?=
 =?utf-8?B?cEpTR1VEaHpqOW8rZUU0L0JQOVNKanJWTk5YQi9SQUNsVFo5N01pcGU4UUZr?=
 =?utf-8?B?amQwam5PRW1wSDF6ci9uVHhZMUJ2ZXBuelVEdml5cVFQZWJOUm1DcXhKRDFP?=
 =?utf-8?B?anZkb1JGT053Sk50QzRnOG5Sa3N2Nm8rbGlJU3NmYlc5WE5ZU0VlbU9UN3Jk?=
 =?utf-8?B?cWozOXZDZEhGd3BDUmx1dFRTd3BBZFFzRWhxWDlvYyswdTVMRnlXMTRCbDI5?=
 =?utf-8?B?Y1hpZXBoNE9vNDQzeFA1VmFENjdLYkdWK1FqYnhYdmdzYVIyNFlLYWdNL0NF?=
 =?utf-8?B?Ym44QjBWdERFei9yYzNCak5pR2FKR3Myb0VUODJreDAveDdHcDQwTFNJWFN4?=
 =?utf-8?B?Witqb3kxcndRWldRWDlqQXVXOHNUemlQUWJJSGRRRnZLcUwxbHZxRWZRSVMy?=
 =?utf-8?B?SWNNeVE0T2RaYXZGWDllRWxzUm1YN25XL0FmSFRMNk1oNVQ0a3ppZEFsSnpU?=
 =?utf-8?B?SkFndjQyRjhIclExMHkyU1BDVWl4aDREVVNrWURiRndCWG1LS0RsdFBoZGgy?=
 =?utf-8?B?OW1KUW5VYmlPcWtLMFNwdTdkZEJ6TGFDNS9rYWtkWjZuRk9CL2tmYkNVb00y?=
 =?utf-8?B?YXRxL3lRbXJOelQ5VHF6QS95aXRORFpxamJLWnJsem56cENmQUs2TmxoUWRl?=
 =?utf-8?B?Z1IrcjlsQndsK09HdlpVNlFPSTFaS0xjWUVRZXJQc29Pc3RkMVhUSlRyY1dC?=
 =?utf-8?B?T01NUVRQNlViZGcxcnIrdDFBWTE4OTdqVEpuTXlqeE54RWlqWWx5TVByVkdi?=
 =?utf-8?B?WWhvMGpoYnBOc3JDYTJOTXVHZG1MRG4wMVVPQ2hja3VYbDkrVnRhelEzUnBP?=
 =?utf-8?B?OXhYOWFiVDZEcm03QzUvZGRrV2Y4Q09nSGN3b1Awdjk0RHE4MVVCdFFNYTFi?=
 =?utf-8?B?SEdGZytyQXVucjZCeWJsVW5YRlVtdllsbUhsUm02OVpOYmNJaEFaZ0xyVmI3?=
 =?utf-8?B?RnFkNnRiKzR3UFA1bzRZczhWNVh2dDNjN1AzMmg4WERSRXBRc0VVTUhkeU5B?=
 =?utf-8?B?VnppNUVTSS80R3I3TGt5NmxzYVdoREJKbXFtSnFQbzdCcmk1UVVzeGQ5RkRW?=
 =?utf-8?B?d0diR0llbUJ4Q1JrMmpvNjMwWDIzTVR5Z2dmZ2VUaGxNL2ZGcEZLQjM4b2Rk?=
 =?utf-8?Q?GneZkE5F2tfVB7Obk7jtshXxbQWcFEnxn/3cM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e05429-3cfa-4d3b-0157-08d8e811b48d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 00:23:21.5332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENDKipwg62wfmOUL8RV4RNm6YLanSiVunTW3KYCaT1UgdLjzjoZS5k8knJ5qKfgT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4014
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_15:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103160000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/15/21 5:18 PM, Yonghong Song wrote:
> 
> 
> On 3/15/21 4:33 PM, Daniel Borkmann wrote:
>> On 3/14/21 4:58 AM, Yonghong Song wrote:
>> [...]
>>> This patch explicited add an expression like
>>>    (void)BPF_TCP_ESTABLISHED
>>> to enable generation of debuginfo for the anonymous
>>> enum which also includes BPF_TCP_CLOSE. I put
>>> this explicit type generation in kernel/bpf/core.c
>>> to (1) avoid polute net/ipv4/tcp.c and more importantly
>>> (2) provide a central place to add other types (e.g. in
>>> bpf/btf uapi header) if they are not referenced in the kernel
>>> or generated in vmlinux dwarf.
>>>
>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>> ---
>>>   include/linux/btf.h |  1 +
>>>   kernel/bpf/core.c   | 19 +++++++++++++++++++
>>>   2 files changed, 20 insertions(+)
>>>
>>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>>> index 7fabf1428093..9c1b52738bbe 100644
>>> --- a/include/linux/btf.h
>>> +++ b/include/linux/btf.h
>>> @@ -9,6 +9,7 @@
>>>   #include <uapi/linux/bpf.h>
>>>   #define BTF_TYPE_EMIT(type) ((void)(type *)0)
>>> +#define BTF_TYPE_EMIT_ENUM(enum_val) ((void)enum_val)
>>>   struct btf;
>>>   struct btf_member;
>>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>>> index 3a283bf97f2f..60551bf68ece 100644
>>> --- a/kernel/bpf/core.c
>>> +++ b/kernel/bpf/core.c
>>> @@ -2378,3 +2378,22 @@ EXPORT_SYMBOL(bpf_stats_enabled_key);
>>>   EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_exception);
>>>   EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
>>> +
>>> +static int __init bpf_emit_btf_type(void)
>>> +{
>>> +    /* bpf uapi header bpf.h defines an anonymous enum with values
>>> +     * BPF_TCP_* used by bpf programs. Currently gcc built vmlinux
>>> +     * is able to emit this enum in dwarf due to the following
>>> +     * BUILD_BUG_ON test in net/ipv4/tcp.c:
>>> +     *   BUILD_BUG_ON((int)BPF_TCP_ESTABLISHED != 
>>> (int)TCP_ESTABLISHED);
>>> +     * clang built vmlinux does not have this enum in dwarf
>>> +     * since clang removes the above code before generating 
>>> IR/debuginfo.
>>> +     * Let us explicitly emit the type debuginfo to ensure the
>>> +     * above-mentioned anonymous enum in the vmlinux dwarf and hence 
>>> BTF
>>> +     * regardless of which compiler is used.
>>> +     */
>>> +    BTF_TYPE_EMIT_ENUM(BPF_TCP_ESTABLISHED);
>>> +
>>> +    return 0;
>>> +}
>>> +late_initcall(bpf_emit_btf_type);
>>
>> Does this have to be late_initcall() given this adds minor init call
>> overhead, what if this would be exported as symbol for modules instead?

You mean EXPORT_SYMBOL, right? I think it should work, just one extra
unused empty global function, but a little bit misleading since the 
function is not intended to use by anybody. I am using init call and
wants to remove this function after init...

> 
> If issuing types in module, if I understand correctly, it will not be in
> main vmlinux btf, so programs will not be able to use unless module
> is loaded. I would prefer such types always available in vmlinux btf.
> 
> I am using a separate late_initcall just to cleaner codes. But
> this BTF_TYPE_EMIT_ENUM can be in any init call.
> 
> $ grep _initcall *.c
> btf.c:fs_initcall(btf_module_init);
> core.c:pure_initcall(bpf_jit_charge_init);
> cpumap.c:subsys_initcall(cpu_map_init);
> devmap.c:subsys_initcall(dev_map_init);
> inode.c:fs_initcall(bpf_init);
> map_iter.c:late_initcall(bpf_map_iter_init);
> net_namespace.c:subsys_initcall(netns_bpf_init);
> prog_iter.c:late_initcall(bpf_prog_iter_init);
> stackmap.c:subsys_initcall(stack_map_init);
> sysfs_btf.c:subsys_initcall(btf_vmlinux_init);
> task_iter.c:late_initcall(task_iter_init);
> trampoline.c:late_initcall(init_trampolines);
> $
> 
> I think we can use any above in kernel/bpf directory. This way,
> we will have 0 runtime overhead as the code will be optimized away.
> Any preference?
> 
>>
>> Thanks,
>> Daniel
