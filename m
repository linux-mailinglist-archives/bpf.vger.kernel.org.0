Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937CA47A3FE
	for <lists+bpf@lfdr.de>; Mon, 20 Dec 2021 04:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbhLTDvi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Dec 2021 22:51:38 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22208 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237307AbhLTDvi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 19 Dec 2021 22:51:38 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 1BJ13JM4016681;
        Sun, 19 Dec 2021 19:51:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=OmuryUUP1bStdBtSDDQSlSoMdnKGSxVeu2POiwdveU4=;
 b=S6bBoJXHy2oTEVBEjwaw8lkjWSXtBkvjpyu092wHWv5pwVK9rVcs4jk7SIZjyImWmXcs
 wJYbpMeNGPPvK0gtcqLv5c8Ygzmu2nD5Oz+SXfkf8nCxByUG1lTpHmI5zwR3XvvSITlY
 NvMR2So1V2fDmp99edHzwvhw1tV+U1uaAkY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3d1tqy5qvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 19 Dec 2021 19:51:21 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 19 Dec 2021 19:51:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LamKtka8bDrYDC0tZIDvNdkE84idCMhqsZqSJx5dMPU5V9nAoRzSy/cCe3Ua12WodluA1bb89dYVzDQCMSMGvBSsXaptyAbFxRO+7sHaaEvpcBLrDdSdAKLD2rPtYM4CGCeBPMK1bIASaz3E/szTozwkL+6uJav4lS6p5Vs81zbCqSRNSW6zb0X2aIZRifpguE2lXNwXD5O9eGR7AenjGVhxhUN0L2l5rW5Rl2q2gCSBnXffBhU/ILA/TnBJlb5FKwQT1Q5Ha38GKjfO7Wy50NQTnqym+YWSBRnRfaxyo9ix9/5Fc2ugv8pxqRPh8G3fdhZ+ivNDANBFvt2cNMs1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmuryUUP1bStdBtSDDQSlSoMdnKGSxVeu2POiwdveU4=;
 b=RPdtMVZnhMqAv9Z+xhhoi6ZYuQKixBf2JzUqB/qJXepTlr+2ElF6KVKvDvZOcL+M8lQumSc0Uldu3YoGeV6CtNuN20m+hnDWDXk4ci1hM1I37N8l5uy9j+Wrxd5a9mOxMOgX8eReq7x3UYsMaJenQVVKlZ3dnvJgJJZY/TM8VYDTEAVCjxup5/5Y+MGejc71sIe4qwXqA63KMOYaoVyaPDlt9V/SeUsNii6eceAIAiQVAxrQo0svKXIs/6a/0RYbJv6+lc7oHSxPuT6L/ZRC+hgbvOXr+NyTu4OAliP9Na8pKosKrDPIWey0tH0031ItTmrm8rkOEBhvmH3qyIF/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3966.namprd15.prod.outlook.com (2603:10b6:806:8e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Mon, 20 Dec
 2021 03:51:19 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26%5]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 03:51:19 +0000
Message-ID: <2094a015-89a5-8062-d795-4fbe621d6a2f@fb.com>
Date:   Sun, 19 Dec 2021 19:51:15 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH bpf-next 2/5] bpf: reject program if a __user tagged
 memory accessed in kernel way
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>, Masami Hiramatsu <mhiramat@kernel.org>
References: <20211209173537.1525283-1-yhs@fb.com>
 <20211209173548.1527870-1-yhs@fb.com>
 <20211220014505.oirge3vkyzm2t3st@ast-mbp.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211220014505.oirge3vkyzm2t3st@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:303:b7::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8acc5f68-b390-4841-e1fa-08d9c36bfb43
X-MS-TrafficTypeDiagnostic: SA0PR15MB3966:EE_
X-Microsoft-Antispam-PRVS: <SA0PR15MB3966B4839FE7EB19EB45AFBCD37B9@SA0PR15MB3966.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IR6fahFtX0siAE2PrcFYQrOWkdPRhRU0FSqLfWK+aFiglANl/wL1YPs+7oJRbk+552iVb4QFTEdh5gPWcvJXUiMgH9CT3ylnTrQqZZtv3g9AFkxAmOATWyuhyt0yxdY4QDq2aEGU+p30yliEPUzWycnAkveyQ0FHjaHb3soTZpQ11yghh5+tWBlZyyxnt0mEteQm9UP0qpdrUTQRkfH+LmXDX+f7hIZ8HJSRsDAxcIMAJGVkvMwmGdRt4m1KoSmENGKB6ISGBAbYUQWixe6slV3bFsuVoxPR7LPLhk8UKg5yvbOOAuV4NApmmLA71v7t6D+ewDV0W7lfoQZ/JFlH8z73ToMBGlnGu5KVuOsSar/ambLlOPuuK6CMVWJEJqsrKHyZ0eA6RhbDn4KOkxg+Rvi6Zpg+kIfNB3C+EQxmGaeZY8H4CQWRi+q8LaklfJh/kiGSv1bMNJQB0kb1Es2Yc0lWLFkA/GRG9M2CWfWmDC5f6CQAjGxQkR1b0ekaCQaF+JVgZwpyoq/d2YMBenzpg7wI2DWdx2EAU7s5P3R0NqdQMZyxveSrU1kk2QrjxB509we0X/iJ7ucddguTsNodQM8rq90SXPrKPKfSwsAG/L85w4RYJIGBb+lvLVafgLNIrZvoz87axGxP24fEMHOv7vSEXC3X4KMf6V4az/p+cwJjkbL2VtpZnmpd3c48TlK9nHCqXChvJ34pDLGJr8ryOdAuN5ueeOMAWfBsm2GqE5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(31686004)(86362001)(6666004)(6486002)(8676002)(54906003)(508600001)(8936002)(316002)(5660300002)(53546011)(6506007)(2616005)(186003)(36756003)(83380400001)(52116002)(6512007)(4326008)(6916009)(66556008)(66946007)(66476007)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnV6NmhERWFVcmJIOC9iV3RGcEtGZjJmYUR3YkNDZkw1dTZldXlwQno0VHow?=
 =?utf-8?B?TEczU0tWb0JXbU1pTitLOWRHZEZteEdJTUZ0RDVQclpoV09IQjk0MHROVU9S?=
 =?utf-8?B?U1JQNncvbUo3WGxKUHFVQWdRb2g3WFp5aHhhQ3Uxd0toaUl2QmE5T211SnVU?=
 =?utf-8?B?MGp3RWVHSVpuKzFqT2gweXZLMWIyb3c5aVBFem8wU2VBeFZhdUZYcFFFUi9U?=
 =?utf-8?B?MzJOcUhlaFBsMGtLZHQrVmNIWUc5SVJvTFpYUmxxbnJnUW45UjU1ZUhqaDVy?=
 =?utf-8?B?blU1N0tNY0JKVCsyZUpBMXlFb04vZVlJWUdmanlISVdZdW1XeWNjQ3hSRTRJ?=
 =?utf-8?B?MnlVbXBvR21QN3p3TjVjdk53MUt6TUFob3dmTDlwUmhkS3BtUmgvU0lzQUc1?=
 =?utf-8?B?RUVKVUdCd1VlQUlUK1FkNkpyN1hiUTU1a0gzeDFZbjY4Ui9MTFpYSWFrZVNL?=
 =?utf-8?B?bGVMSnYrWDZ5MHM5VUhIMXJxa3RrUU9nOElFekUvYzdmakNZRWNKenVPL1dq?=
 =?utf-8?B?YXN5N0pGOUJQdzljQW5LVTlhbXhBeTRqWlY4M3Q1b2lRaXp6Y1pFM1A2eWg0?=
 =?utf-8?B?eGpoSEpwYmg4Y0NmS1d2WlliZWhvc1BvZHJITXhiTlZ4Vm5NNU1wR2hublhD?=
 =?utf-8?B?MElnYWt6aVByWUdUejJUN09iQktMZTY1RVFyZ1MwTTZlL1RnV0Z2K3dtdys3?=
 =?utf-8?B?VW9VTHpHYjYwWHZSU1lKcUgySGZ3d1dQMytxVHZCOVZwWVBxMHQ1dGtEU1JM?=
 =?utf-8?B?TTBqMTQ5NWZXeUFESXpsN3NhQVo2RzgzQTVVT3lzVDJ3L2h0Nmh5UWc4OWRC?=
 =?utf-8?B?SGs1UEpMREJES2hsMUZIVGI5a0N2M0lIakxESHZOQUFOU0FpWHZnWTNobDlG?=
 =?utf-8?B?bkd1RUNaOTVCY2EzQzNBdmNRNGppZmxOd2o0alZja0s5c3hhUkY1UmxtWTA5?=
 =?utf-8?B?RFpzSHZST25iNktxc1VraERDalcyYWFHWGt5L1dIZkdpUm1oa29WVG9hT0h4?=
 =?utf-8?B?L1ZEa3VlaXE2WkR5ZXp0dWZWYjlGSkFSZW1nNi9uSUo0UGRLejkwMmdaaENt?=
 =?utf-8?B?eHU1dVFFcWFnaHE3cnZwSE0zc1RMS1JWM3RCeVdUSkhWZFM3dHM1OXZOckRU?=
 =?utf-8?B?UGplNDNnMnp3bTNiM2t6V3E0TkJBTEhGdTF0ZTJEbjJRZHIwM0VkMlFHSkM3?=
 =?utf-8?B?REFMc2VFd3owVFluVU54VXVQK2o0S2ZmcFl5NVl3MFBDVkJKZkFCUzZpczR0?=
 =?utf-8?B?UTNyc1JVUVZDNzRRRlNTQlRCY1htRmZseHFhYjZJNVhvWjBWTlBrSXJPNXpC?=
 =?utf-8?B?Vlp6dURrQ1VCZ3o4Q0d1a1NhSFRZWGFMS09ielpXZ3RuaWdpVTY5RU44cTRJ?=
 =?utf-8?B?THg2SVNlMDNLWnN3bU80TXNkeWFzbzNrTUFPVUh5YUp0ZDlNT29SRjVKbkg1?=
 =?utf-8?B?eEI4WnBwRzdhL0kreUk4T1BUU01ITGxEelhJVW9mVGU0SGFNamdYbitWZHUx?=
 =?utf-8?B?eThPc1ZWQVB6Tk1GcVJHT05TM1hXYW9kQklPbHZ2K0xEemgzWUYwM2c0Wlcy?=
 =?utf-8?B?SXJDa09FajBteDlMNlJPWDZ4OWYzTHpBcExENUVhejJtNjNDRVZwbXB5b0RI?=
 =?utf-8?B?TnEyUnlrS2kveGJPSlFFMEI1am1xWDFESFJUZXR3OXdhNk9pbFVaZ0ZxemxH?=
 =?utf-8?B?OE55Zmt1QU9iczNLTWpCVktlKzhZcDd1dGdweWplSnpHTytKNmo5WE01Y3Ny?=
 =?utf-8?B?WmloK3FiN25Pc1FvZWRmYTUyVjVGODYreEJRVEhQT2RoQU54WWtLaVR5Q1Za?=
 =?utf-8?B?b2N6VldDdXBBeHc2clZpRmNoVjJWbHhtNjVMS3RoUGx3bHRITkE1WFBpYTBz?=
 =?utf-8?B?bmxoWFhpOU5oMk5SQmRabDJLaHFVUGtrdWxTbHVWak1Pc05iUHhvSEdzQWla?=
 =?utf-8?B?LzBiNDEvRHp6S3ByUTlqMHZlQzAwTXI2dUZTUkM2WkxvNDhyV3BVd2FZRjBy?=
 =?utf-8?B?Uk1KajQ2Um5tQTZhelR0R1p5UzBjeW5MTnFRck1nTVQvc214NlNCdVd0enV5?=
 =?utf-8?B?Skg0UUlHMTlnWkZGQ3VCUGV6SVMvbXk1M2VKNFRPRGdIUlhWK3RwYm9DdGRU?=
 =?utf-8?Q?Y5R3qIYkBL5hcDAuI3sxJGw+A?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acc5f68-b390-4841-e1fa-08d9c36bfb43
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 03:51:19.4864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICatj2X/C3PAKP3tMP1nsdjtTQlsRY+Dznd1YKIflM093FxN4Mpc49WZbxUWEqZu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3966
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 86Og0Z5bkxhn-iXAv6kTGUsSenqzvnhN
X-Proofpoint-ORIG-GUID: 86Og0Z5bkxhn-iXAv6kTGUsSenqzvnhN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-20_01,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 phishscore=0 mlxlogscore=806 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112200021
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/19/21 5:45 PM, Alexei Starovoitov wrote:
> On Thu, Dec 09, 2021 at 09:35:48AM -0800, Yonghong Song wrote:
>> BPF verifier supports direct memory access for BPF_PROG_TYPE_TRACING type
>> of bpf programs, e.g., a->b. If "a" is a pointer
>> pointing to kernel memory, bpf verifier will allow user to write
>> code in C like a->b and the verifier will translate it to a kernel
>> load properly. If "a" is a pointer to user memory, it is expected
>> that bpf developer should be bpf_probe_read_user() helper to
>> get the value a->b. Without utilizing BTF __user tagging information,
>> current verifier will assume that a->b is a kernel memory access
>> and this may generate incorrect result.
> 
> The patch set looks great overall.
> 
>> +/* The pointee address space encoded in BTF. */
>> +enum btf_addr_space {
>> +	BTF_ADDRSPACE_UNSPEC	= 0,
>> +	BTF_ADDRSPACE_USER	= 1,
>> +};
>> +
>>   /* The information passed from prog-specific *_is_valid_access
>>    * back to the verifier.
>>    */
>> @@ -473,6 +479,7 @@ struct bpf_insn_access_aux {
>>   		struct {
>>   			struct btf *btf;
>>   			u32 btf_id;
>> +			enum btf_addr_space addr_space;
>>   		};
> ...
>> @@ -4998,7 +4999,15 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>>   
>>   	info->btf = btf;
>>   	info->btf_id = t->type;
>> +	info->addr_space = BTF_ADDRSPACE_UNSPEC;
>>   	t = btf_type_by_id(btf, t->type);
>> +
>> +	if (btf_type_is_type_tag(t)) {
>> +		tag_value = __btf_name_by_offset(btf, t->name_off);
>> +		if (strcmp(tag_value, "user") == 0)
>> +			info->addr_space = BTF_ADDRSPACE_USER;
>> +	}
>> +
>>   	/* skip modifiers */
>>   	while (btf_type_is_modifier(t)) {
> 
> bpf_insn_access_aux approach will work only for the first
> pointer deref, right?

That is true.

> Also addr_space will consume the last 4 free bytes in bpf_reg_state.
> Maybe encode user/kernel as a flag into bpf_reg_type?
> The verifier just got extended with PTR_MAYBE_NULL and MEM_RDONLY flags.
> MEM_RDONLY is roughly equivalent 'const' modifier.
> In that sense __user attribute is similar.
> wdyt?

I haven't carefully read Hao's patch set yet. But after roughly going 
through it I think your suggestion should work. Will give a try!
