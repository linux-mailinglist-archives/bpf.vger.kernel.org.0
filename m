Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D4532C140
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391494AbhCCWhk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:37:40 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37502 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1452304AbhCCHa0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Mar 2021 02:30:26 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 1237Spn9003130;
        Tue, 2 Mar 2021 23:29:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=WLIY9rx+B4bh2ect94Z07v+FwnYACAurMd7EM/SaI8c=;
 b=fhd3JgKZKPWdyvxb/objVVTuDr7VrpQL7sFPRR1vwZjjHjepqVb8RiRMYyjNh+FBguaT
 Cv2oU2F289KvOY+KDrku1V1pLUznKWWYSIMwgp3YCFhSOZaKn3knpRXU1yOy7MtBBjOf
 HqqcfPeSNDkpXl4APOnoZO4QphFgw8cKAcM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 371trmbhxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Mar 2021 23:29:14 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 2 Mar 2021 23:29:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDmsQO+HIQZYZy4Ptaq0YwZCokhybFatc0QG3h0mfRsThdtbeOj3+FCrC5clVJh9mtjeAzP4NiqcNY1Vv/AWYmt5q+ss2WVPOXJOE444dfiQVecW6JS6aq+/QxKe6+1qZsTI3UPbElRSh9WxZ0m3PntK+XzC+cndUcosz2flJv1uebfY9SB11yBKVtQYy6smPPLr+NDdMQYHV9GZxVc600yJh3w/JelWiJh06ZYkk0vgzWJ2aFwUQgL694ri0lBYRyvDwOZag1enIFyLPhBZB9LqZXrhcnQw3xCFMhoqM8eotp65a7G3syUp++4SlM1bnzb0E5OzFW9yBbzOvc1VsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLIY9rx+B4bh2ect94Z07v+FwnYACAurMd7EM/SaI8c=;
 b=gwR6h8CJ+XXwZ55p2pTV1KmEV04yscSo50luChPvHwoM14hewMgm4QM/MZVmA/rs9w0aN8cOnooBi9H1hhYnhDf9IUkvZx4Yb3E8YwMfPSFy0nvEG6a8GT5PIChWfUrhKnWTWMgKBvYA42ZxVb/naEOo8ZSxG1thqgSUTdK0Y6ocBPffCT2UKGFJsC+BsCWFgI/1dDOtDObU+aUY1BnzX3TgrVs6yf9cd2hYyi5f3ZIrnunK69T/TMlJ6Cm8Xu0GVm3JVhqX+kychQ6vJnVThK6O8N8PxpjI4odKfxstDYBHSjO8LDVb/puU8Z8t4PidpuJt89dcliLnp+nNE9zp2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4340.namprd15.prod.outlook.com (2603:10b6:806:1af::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 07:29:09 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 07:29:09 +0000
Subject: Re: [PATCH v5 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit
 cmpxchg
To:     Martin KaFai Lau <kafai@fb.com>,
        Brendan Jackman <jackmanb@google.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
References: <20210302105400.3112940-1-jackmanb@google.com>
 <20210302184306.ishsga6xkg2glnzj@kafai-mbp.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3b994f4c-2847-60be-834e-22c58c2b7470@fb.com>
Date:   Tue, 2 Mar 2021 23:29:06 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <20210302184306.ishsga6xkg2glnzj@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:e54b]
X-ClientProxiedBy: MWHPR15CA0028.namprd15.prod.outlook.com
 (2603:10b6:300:ad::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1a32] (2620:10d:c090:400::5:e54b) by MWHPR15CA0028.namprd15.prod.outlook.com (2603:10b6:300:ad::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 07:29:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3fe85d9-dd07-4cbc-d830-08d8de160901
X-MS-TrafficTypeDiagnostic: SA1PR15MB4340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB434040208FB3EE48A23EA67ED3989@SA1PR15MB4340.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qGgUVYk2rXSOMA/EfX6F2RW7d+GJ04/Nf7LU9UNmwzi1QIIWmAw/1ahMCpbfGm1m99CGf27SWSKHGQe9n2FSNMPQYw5bKe80cpgdXNV0fiLRq5MXQ51Yju33Ou5P8mDD3AQDvXYS5PAJJEJotEDW4iYt/AC0mDX3NTAsgGn3EGtv0ZT80tpG+Vw6xq3rWImtN6mIjGBIX8hDCJLbCjOtyUBMKYTaq2wz1Dd7X/gyCLMdOTKW8DT2mRQeggRATEZx7pM0axREOyJjPkCl/Tivc3Wmn+mEb9hww07KCnUG46AU1peZ/KklbBfYq+Cjn770n5IQ1z1A2mIAvlPsrDMIvtQSKm0/za7u2aZ0hED0WHBgUZ9MggR3bjD2xalxJU9Lw8b/0lxQ3OxIijgDA/4dZNNW+hvKL1uGYX9JhNhSwG3XDi3VCUF0eV0l7QQC3THtTjSSk6aB5A6MzgrUoXshypkSgTpFIcliW8zyJW5xpbyZTvOqZ0LrzMMefvgfK1/j6UlXzIQ472b75Xq8Dvk3QKgP70OuTChwj1gVC2eZjhp50doUYptZVzllNq9Nw/y+d/R1VKIXxJKIK8XEIBIk4MOEWIYeT7e/SZthB7Xdhu0l1PZ7STak/JFLL3EHvrb6+ixxDGUvayxNyYkkhzmcqBpxvSA+Q9xiyS6OlO1PmETI2vF0wLln1uWfOCmCLSJ+K0AMWcpwAaIaYIBEazy2oAidLHZPxOcsCejJokwCuxM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(136003)(376002)(396003)(8936002)(2906002)(8676002)(6486002)(316002)(86362001)(966005)(66476007)(31696002)(110136005)(54906003)(31686004)(66946007)(53546011)(66556008)(4326008)(478600001)(16526019)(83380400001)(186003)(5660300002)(52116002)(2616005)(36756003)(17423001)(156123004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WmF3ZWszOHRJakZHTFhHRy9hczVwQTNzUEw2WHF3cXB3ZUx3c3ZmaXlzdFJz?=
 =?utf-8?B?ZlBIaWV6a2phQTZSZ0lDKy81eU9tMlc4cDZVKzk2TGRKYWJSY0N0UmFwM0RX?=
 =?utf-8?B?K0JWSjltNDRUd2dwTVNTcXFRMW5FSHZRYTBOMjc1Z0V2bE9lUVRJMmdiaml3?=
 =?utf-8?B?NjljYnFjNGZYcjhjeTVTY1ZhVkpXV1l5eW9uUStlQkVmdE5zQzhsaHk3bjRt?=
 =?utf-8?B?SEFFeVZ5enFHYjdkSmgyT3hRd1REdG1lSmxqaStEQU1oOENuZlhLS1QyQTNF?=
 =?utf-8?B?WlFVamJJRHJnaVlaVzVXeks1RjRRQ3U0bDE3Z1hjTUt0Z1VUZEhDL093MmU3?=
 =?utf-8?B?OHdNSmpLMHpwNlkwNnhpYUJtMlJxemN5SXF3bWNXemFpQkhUNVk5OXVEUnIw?=
 =?utf-8?B?endPRDN4LzBOOXpTK2p2TFgwdHFTYkZQYU02bEtyQ3lMWGI5WnRBMkRLbVda?=
 =?utf-8?B?R1U1dmJVNncvTzM5VEVIU3crRkZUeldTR1dMUnkrejBQWTlJMTFacUIyUjZI?=
 =?utf-8?B?ZW1Nenp1OTE3S3Z2Mi9tTFM0UENhbnFDWTM0Q3EzZ2MzdDlWOHkvaFRMcEFr?=
 =?utf-8?B?TDYwbDQ2T2FwNzVvS1JhemozT3Z4dnNibjRSc3BlVXZsK1Q2U21pTUlvSXkx?=
 =?utf-8?B?enBXZ0NadVcvQzB5YTAwZkNpdjVNREtydWVkWk5FK0RuamI2dVRqeFhOMEJi?=
 =?utf-8?B?NURqVlNlUHYzSnVXY0xOODFxVHRlZDQ3MEZBWTZXSUFkbUxNS04yYmJMNWc0?=
 =?utf-8?B?a2JDd1Vzd2NyN0R2bkZTUFpnNlNGK0VVY3lGQWFUZVhab2YxRnF6Zk1ENW1s?=
 =?utf-8?B?eUV0YllycUVNWWxITEkrRU1GWFVNTEJnZEEydU9rTHFKMCtmYkdqa3l6TFZL?=
 =?utf-8?B?QzNDR1lQN3RHSFVlRlhselRIZDBGVXl4TmJsVFY4dmxFcW9heEd6KzMwR29S?=
 =?utf-8?B?RDFTVGNIUnlRQ0FLZHM2bHJ0eUR4dkZiazZWYlZPQUFaUlR5YnhZbDQ1QWxJ?=
 =?utf-8?B?dDJKUTcvR0J1a05LN21ibFZDbWNvYTF2TWt4TTdEZys3NjFOOVJpaTl1L09D?=
 =?utf-8?B?b1pzNHVqTjI2UlBTT25PWFovUUpPWUFiT2lVaStSOFVRU2l4cDVyYUwzN2Ry?=
 =?utf-8?B?M3UrMWRRR0EzZnVjM2NsOXFUY09XeWtoNmYzb0ljcWkxd3JybzkybGw5dmY1?=
 =?utf-8?B?Uk5mRnFmYzA0SVdTem1FLzBMeTExMW1nOEZ5YTZkWFFSSGl4M2NkWHd5ZzdE?=
 =?utf-8?B?U2pVVjlmMEhLTHBOZDNVRjlDdmhMSCtMU3ZHVWxGS1pMOWNjNTkwV2NySUQx?=
 =?utf-8?B?QXF4TmhCOVJKNlJSQndoZnVYOW9OSjliQmNGRk5YVzI3MGtkRTlRcUpBdWht?=
 =?utf-8?B?MEJvSUg2RGlPU1lXUnhnelBySGdsaWlmWWM5d09Pb2c3ZkU0RmpEZUtscW9U?=
 =?utf-8?B?c2orQ09sTkJVK24vRmxsY2pTNWhqQ0FrR29rRitDNGF0S1lHVVM0UjBsV2hU?=
 =?utf-8?B?YlM2T1N2VGd0UHQrWE5NeEc1NTNSNmxxOERudk9zNVFTS1B6S3ZDM0tDUmZ1?=
 =?utf-8?B?VlgxWHlsWXBEUnJkeVh5UTVwR0pqSXN0VGU3RkFFUmJuTzA5QXRNNjhPREFr?=
 =?utf-8?B?T3JKcTUydFNFTzI1N0RuUURQdENHQmNMM1BpOCtHQnhZbkZrWXYrVGVLUmF2?=
 =?utf-8?B?QS93RDA2eC91ZEcrYjFHV2FEUG9uN1hvN3BwNUJNaWlySHA0TlJXZTF3Rk5z?=
 =?utf-8?B?RnlsQk1keW5GRVdyaVVhZzhpSGx0djNrazNsbStobUtJdE5VQ2VnZFRQUXBW?=
 =?utf-8?Q?Aa25QestnwhdRxs/K1GrC4YyWQrOeqCgA50u0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fe85d9-dd07-4cbc-d830-08d8de160901
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 07:29:09.7246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTigKjbZA+oXmBsUjOiF5zW23FKAnxKpNI2hfl5EnFskezoCD1G7qT8r8bu4+uRO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4340
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_08:2021-03-01,2021-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 mlxscore=0 clxscore=1015 adultscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103030057
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/2/21 10:43 AM, Martin KaFai Lau wrote:
> On Tue, Mar 02, 2021 at 10:54:00AM +0000, Brendan Jackman wrote:
>> As pointed out by Ilya and explained in the new comment, there's a
>> discrepancy between x86 and BPF CMPXCHG semantics: BPF always loads
>> the value from memory into r0, while x86 only does so when r0 and the
>> value in memory are different. The same issue affects s390.
>>
>> At first this might sound like pure semantics, but it makes a real
>> difference when the comparison is 32-bit, since the load will
>> zero-extend r0/rax.
>>
>> The fix is to explicitly zero-extend rax after doing such a
>> CMPXCHG. Since this problem affects multiple archs, this is done in
>> the verifier by patching in a BPF_ZEXT_REG instruction after every
>> 32-bit cmpxchg. Any archs that don't need such manual zero-extension
>> can do a look-ahead with insn_is_zext to skip the unnecessary mov.
>>
>> Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>> ---
>>
>>
>> Differences v4->v5[1]:
>>   - Moved the logic entirely into opt_subreg_zext_lo32_rnd_hi32, thanks to Martin
>>     for suggesting this.
>>
>> Differences v3->v4[1]:
>>   - Moved the optimization against pointless zext into the correct place:
>>     opt_subreg_zext_lo32_rnd_hi32 is called _after_ fixup_bpf_calls.
>>
>> Differences v2->v3[1]:
>>   - Moved patching into fixup_bpf_calls (patch incoming to rename this function)
>>   - Added extra commentary on bpf_jit_needs_zext
>>   - Added check to avoid adding a pointless zext(r0) if there's already one there.
>>
>> Difference v1->v2[1]: Now solved centrally in the verifier instead of
>>    specifically for the x86 JIT. Thanks to Ilya and Daniel for the suggestions!
>>
>> [1] v4: https://lore.kernel.org/bpf/CA+i-1C3ytZz6FjcPmUg5s4L51pMQDxWcZNvM86w4RHZ_o2khwg@mail.gmail.com/T/#t
>>      v3: https://lore.kernel.org/bpf/08669818-c99d-0d30-e1db-53160c063611@iogearbox.net/T/#t
>>      v2: https://lore.kernel.org/bpf/08669818-c99d-0d30-e1db-53160c063611@iogearbox.net/T/#t
>>      v1: https://lore.kernel.org/bpf/d7ebaefb-bfd6-a441-3ff2-2fdfe699b1d2@iogearbox.net/T/#t
>>
>>
>>   kernel/bpf/core.c                             |  4 +++
>>   kernel/bpf/verifier.c                         | 17 +++++++++++-
>>   .../selftests/bpf/verifier/atomic_cmpxchg.c   | 25 ++++++++++++++++++
>>   .../selftests/bpf/verifier/atomic_or.c        | 26 +++++++++++++++++++
>>   4 files changed, 71 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 0ae015ad1e05..dcf18612841b 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -2342,6 +2342,10 @@ bool __weak bpf_helper_changes_pkt_data(void *func)
>>   /* Return TRUE if the JIT backend wants verifier to enable sub-register usage
>>    * analysis code and wants explicit zero extension inserted by verifier.
>>    * Otherwise, return FALSE.
>> + *
>> + * The verifier inserts an explicit zero extension after BPF_CMPXCHGs even if
>> + * you don't override this. JITs that don't want these extra insns can detect
>> + * them using insn_is_zext.
>>    */
>>   bool __weak bpf_jit_needs_zext(void)
>>   {
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 4c373589273b..37076e4c6175 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -11237,6 +11237,11 @@ static int opt_remove_nops(struct bpf_verifier_env *env)
>>   	return 0;
>>   }
>>
>> +static inline bool is_cmpxchg(struct bpf_insn *insn)
> nit. "const" struct bpf_insn *insn.
> 
>> +{
>> +	return (BPF_MODE(insn->code) == BPF_ATOMIC && insn->imm == BPF_CMPXCHG);
> I think it is better to check BPF_CLASS(insn->code) == BPF_STX also
> in case in the future this helper will be reused before do_check()
> has a chance to verify the instructions.

If this is the case, I would suggest to move is_cmpxchg() earlier
in verifier.c so later on for reuse we do not need to move this 
function. Also, in the return statement, there is no need
for outmost ().

> 
>> +}
>> +
>>   static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
>>   					 const union bpf_attr *attr)
>>   {
>> @@ -11296,7 +11301,17 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
>>   			goto apply_patch_buffer;
>>   		}
>>
>> -		if (!bpf_jit_needs_zext())
>> +		/* Add in an zero-extend instruction if a) the JIT has requested
>> +		 * it or b) it's a CMPXCHG.
>> +		 *
>> +		 * The latter is because: BPF_CMPXCHG always loads a value into
>> +		 * R0, therefore always zero-extends. However some archs'
>> +		 * equivalent instruction only does this load when the
>> +		 * comparison is successful. This detail of CMPXCHG is
>> +		 * orthogonal to the general zero-extension behaviour of the
>> +		 * CPU, so it's treated independently of bpf_jit_needs_zext.
>> +		 */
>> +		if (!bpf_jit_needs_zext() && !is_cmpxchg(&insn))
>>   			continue;
>>
>>   		if (WARN_ON_ONCE(load_reg == -1)) {
>> diff --git a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
>> index 2efd8bcf57a1..6e52dfc64415 100644
>> --- a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
>> +++ b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
>> @@ -94,3 +94,28 @@
>>   	.result = REJECT,
>>   	.errstr = "invalid read from stack",
>>   },
>> +{
>> +	"BPF_W cmpxchg should zero top 32 bits",
>> +	.insns = {
>> +		/* r0 = U64_MAX; */
>> +		BPF_MOV64_IMM(BPF_REG_0, 0),
>> +		BPF_ALU64_IMM(BPF_SUB, BPF_REG_0, 1),
>> +		/* u64 val = r0; */
>> +		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
>> +		/* r0 = (u32)atomic_cmpxchg((u32 *)&val, r0, 1); */
>> +		BPF_MOV32_IMM(BPF_REG_1, 1),
>> +		BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, BPF_REG_10, BPF_REG_1, -8),
>> +		/* r1 = 0x00000000FFFFFFFFull; */
>> +		BPF_MOV64_IMM(BPF_REG_1, 1),
>> +		BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 32),
>> +		BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 1),
>> +		/* if (r0 != r1) exit(1); */
>> +		BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_1, 2),
>> +		BPF_MOV32_IMM(BPF_REG_0, 1),
>> +		BPF_EXIT_INSN(),
>> +		/* exit(0); */
>> +		BPF_MOV32_IMM(BPF_REG_0, 0),
>> +		BPF_EXIT_INSN(),
>> +	},
>> +	.result = ACCEPT,
>> +},
>> diff --git a/tools/testing/selftests/bpf/verifier/atomic_or.c b/tools/testing/selftests/bpf/verifier/atomic_or.c
>> index 70f982e1f9f0..0a08b99e6ddd 100644
>> --- a/tools/testing/selftests/bpf/verifier/atomic_or.c
>> +++ b/tools/testing/selftests/bpf/verifier/atomic_or.c
>> @@ -75,3 +75,29 @@
>>   	},
>>   	.result = ACCEPT,
>>   },
>> +{
>> +	"BPF_W atomic_fetch_or should zero top 32 bits",
>> +	.insns = {
>> +		/* r1 = U64_MAX; */
>> +		BPF_MOV64_IMM(BPF_REG_1, 0),
>> +		BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 1),
>> +		/* u64 val = r0; */
> s/r0/r1/
> 
>> +		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
>> +		/* r1 = (u32)atomic_sub((u32 *)&val, 1); */
> 		   r1 = (u32)atomic_fetch_or((u32 *)&val, 2)
> 		
>> +		BPF_MOV32_IMM(BPF_REG_1, 2),
>> +		BPF_ATOMIC_OP(BPF_W, BPF_OR | BPF_FETCH, BPF_REG_10, BPF_REG_1, -8),
>> +		/* r2 = 0x00000000FFFFFFFF; */
>> +		BPF_MOV64_IMM(BPF_REG_2, 1),
>> +		BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 32),
>> +		BPF_ALU64_IMM(BPF_SUB, BPF_REG_2, 1),
>> +		/* if (r2 != r1) exit(1); */
>> +		BPF_JMP_REG(BPF_JEQ, BPF_REG_2, BPF_REG_1, 2),
>> +		/* BPF_MOV32_IMM(BPF_REG_0, 1), */
>> +		BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
>> +		BPF_EXIT_INSN(),
>> +		/* exit(0); */
>> +		BPF_MOV32_IMM(BPF_REG_0, 0),
>> +		BPF_EXIT_INSN(),
>> +	},
>> +	.result = ACCEPT,
>> +},
>>
>> base-commit: f2cfe32e8a965a86e512dcb2e6251371d4a60c63
>> --
>> 2.30.1.766.gb4fecdf3b7-goog
>>
