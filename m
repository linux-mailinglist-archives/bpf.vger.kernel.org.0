Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A67F36827F
	for <lists+bpf@lfdr.de>; Thu, 22 Apr 2021 16:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbhDVOgH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Apr 2021 10:36:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41040 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236254AbhDVOgH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 22 Apr 2021 10:36:07 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MEOPAl014261;
        Thu, 22 Apr 2021 07:35:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=0Er/RRGK0Kof+CH4uJCRqBHXvboXah8nvBueJf43pic=;
 b=cnbAI7jMIxdL81RJaZbNZkQbvyRU/a9aHwNUbzy4j+0QW3X1omjvd6EISg0A/snk+QKz
 goAkqKU0rtqh/eBY8XWLn+guRHFAchdMLQ0Z+/7ullauCi7okZIQKu8Jw1XCgxGJPO0b
 cG6II51/z2UOx6a/88HvROVuLh/r0VufKPw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 382kqp00h8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 22 Apr 2021 07:35:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Apr 2021 07:35:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDN1jZNSYTar2EO1XoCvlimWhEkuyhINlspfMG4+TmtbCUpbOEO4kbfMWkN7pozj6pjxA+7Bv9usPxIpAOhOeBHNeLRqu6chbrjj6q9AmXLcj9U+tOV+RR6g1d+DeDUN3wA1PKeigxV+9F3F64sOLuXLeKUNOXFYpwz6+r/6/GT4FzxEK1OF06lxGJWiEuizOayh8BGQ650YNNAWS8T48QHO66jXoPZJd6/rVdBeR6gXM/r21bsCZ8pq7/vENS0KvSj1yXpp7ld1rn8x/iefX8GF2k7+n/heUnFdRcwib+DUnXqOdBnrYaC9iNb5nM4j1Cu+bN01jaaXWY15l9R/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Er/RRGK0Kof+CH4uJCRqBHXvboXah8nvBueJf43pic=;
 b=h0jPgxmxpegJ5V9392PzgNa8fQCjWd+MjADfjRBBGyP4rJMkYx8u7+BvyqgkzSMt9jLLxbzYWd5OitcuiWcNgw0J+Na6k8WghDZDoFAuTdv4kl1BsWIfG97JgLGMicWlVUzZpwTc3ENXKADiG+I8Dm55Be/y4CUs4b7ZR6KwHNNHMsuna2548bm70FN8G3wLfPvtzkqqEiHdrcR+A0+6B4+Tk9aDJpLLKVf+qRiqJiqwymH2jG4MnVVgm+aYFlIKrJ+ODzvLKSYOO3IMuToPxYmjJerJPZenOSxtDMTBtizwBmq8/MuomPsYZaPU58SyfkMGMo464Hz29rGWpD222w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3886.namprd15.prod.outlook.com (2603:10b6:806:8f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 22 Apr
 2021 14:35:11 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.4065.021; Thu, 22 Apr 2021
 14:35:11 +0000
Subject: Re: Help with verifier failure
To:     Brendan Jackman <jackmanb@google.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210421122348.547922-1-jackmanb@google.com>
 <94c4f7b0-c64e-e580-7d9b-a0a65e2fe33d@fb.com>
 <3933ce3c-6161-2309-88bb-72707997ed76@fb.com>
 <CA+i-1C0tV0m+HY1WwivrYE-iouF9b8NGVSXhL_ZmRz6JL36TzA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <0da3a605-198f-cd1b-f6f2-7ca95082fd94@fb.com>
Date:   Thu, 22 Apr 2021 07:35:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <CA+i-1C0tV0m+HY1WwivrYE-iouF9b8NGVSXhL_ZmRz6JL36TzA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:427c]
X-ClientProxiedBy: MW4PR04CA0169.namprd04.prod.outlook.com
 (2603:10b6:303:85::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::16ea] (2620:10d:c090:400::5:427c) by MW4PR04CA0169.namprd04.prod.outlook.com (2603:10b6:303:85::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Thu, 22 Apr 2021 14:35:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 361b7b21-3912-4bb3-56a0-08d9059bd5a9
X-MS-TrafficTypeDiagnostic: SA0PR15MB3886:
X-Microsoft-Antispam-PRVS: <SA0PR15MB3886A50E6949006321097ED6D3469@SA0PR15MB3886.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ip0WrBVfcPElJRd0oy51HoQQSyMtfcOwhsjcpJpXJqICVZhSNs7k+Idm6ZlVANjPVISXn3caUm939ABEAAuRgO/97k7c9QZeDvRN4ww485Ns6d7VC3TE6dab0ht1NR3gmxrcbirpWbjGJiSYZOBkGZS3u7mPEkHt1euMb7RRNwUEKJf6DWozdmSN4Wklq9r4RNceCHx06x4M9SgfOqkUpXZM0J32UkZwvt8bele4XQb+ljGLGJnCwVRthXqd78E2f5pDkr1nxhesWcN0pVB6q5pu7VrU6OFp/cVbD5zxZ7m7iuMFJXgS1iqEotRsUpFdbngQ++LgNkwnfvFil/XCVlIV1mmiQz38OJ/KBnkPBqEu4B+3N+yHLQoe2CREoXZjUv+6TO11z/8ccb9CnSnhKudT6W9g8QubOXCxhAo6/ppuPlgdIr1vu1i6pPjC9sQqYAJ/mosVsb+tXluUfEgtCTcipDIKSAviTpYkSvMCXpIRif4Gk7fKsiqJ3G1j7aWlzHSCkgFCIIKS3qdVq/S17XuqxoIFfdnWjDYCVajx27HFEL744bW7csJaf2Jaq5VWiJ+nwMckBMluOWH7gLUDNuWAvtVumLwO8EO7hgNpP5j+9+r8j+NkHDkQwmwtNOa5uMmkPmjX2eMTW/nvctqpi3LB3BwyFnPLMtq7O7vjyNLLRqtQE/RpwOPt9BdEzZYj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(376002)(136003)(39860400002)(5660300002)(31686004)(83380400001)(6916009)(316002)(86362001)(31696002)(54906003)(66476007)(4326008)(16526019)(66946007)(36756003)(3480700007)(186003)(8676002)(66556008)(6486002)(38100700002)(478600001)(53546011)(52116002)(8936002)(2906002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aVhkWVR2TU42cWtaL2NhZ285OHk1cDNKMjdFc2pzblBPcFRMWmxMUmlYYWt1?=
 =?utf-8?B?MlMvUkVtMVptdWJnd3d1elhtaXh1VFB6dFROK2M0MlQyYzBkanFYVDZnQW9Y?=
 =?utf-8?B?WnVNa0Z0aUFSQ1l0dEx0ZGF4blNyVkhkOS9iMmU5SXFtR09wSDJXczNFZkhq?=
 =?utf-8?B?MDJHaVRwTEdjT244ZkpxRSsxdnFpeitqVlRrWnBsVmpZaFNYajFHT3lhY0dG?=
 =?utf-8?B?cGxEM3NNdjd3d1ExZ2dodDIvZTNUWHRhRFBmenZiN1llY1RnVWhsZU5VQ0RK?=
 =?utf-8?B?Mk5TdTB6bXYrOHJRZjN5U2ZmZ21kZzdXWW9VY1huZDNBZnNicGQrZjBSZ2FS?=
 =?utf-8?B?TmFBTUp6VjNSdFBYSXV5QnJSdFlHa282eWRVb0hMemhEQkV4YXBpcy9Ta0Uv?=
 =?utf-8?B?RytwalpBWEhhVk94dkpuMFcxZm8rQy8xK3NEdm5mQlZQanE5VGR1dHk0c3dR?=
 =?utf-8?B?M1dBeENITDdRV0xpZlBYY1lISjROK0JZVHprYy84bnl3eFYzMDNXTFV0QlY4?=
 =?utf-8?B?bjZ3cnVtTVByMHlrSEJlNlFnbGhRQ0pNdG9zbnpRMEZJbkNQZzZBZkZrSk81?=
 =?utf-8?B?ME1kQncyZUdwQlB5d3F2MWsweEtmeW02aWJiNG1sa1JrL1dlaVNhTmVsQjBB?=
 =?utf-8?B?aGpJdlVDcHI0WEErRStRLzFwSXN6QjQvbysyM1Z1NXIxVVNuYnEzaEQzSTJw?=
 =?utf-8?B?NHkzRE5GQUxPNDRvZDQ1ZUhwQ210MDZ1TUlFb1NPQXp6ZVJFeWFuSHZObU5k?=
 =?utf-8?B?NytVcDlER1pEdE9yQzlIb1N2R3lLRUlvNEhMdHJwQk9IUjFMOUtGOUduR2tk?=
 =?utf-8?B?ZzNhNTQ2anc5cnd3T1JpUzl2Ry9vTFYyZDVuRUNPbkFmL1F0QXZGajFwRHVv?=
 =?utf-8?B?aUhYZ0ZHWEpmZDBMMHFrbHhKQVRxeWh6Y3VtamR0cEVyK21GcGtPbHM5bTQ1?=
 =?utf-8?B?SlhDcTZaaVkzZDdJVFZyTkhMc0ZJQTNhdWIwajVhR1I2S1l2YlgvRnNOZlpT?=
 =?utf-8?B?OWN1YSs4blpoY0lyNC96ZzAzV1pHM3ZHdEFvMFpUekVqLzVQS0QvS0FrSTND?=
 =?utf-8?B?dWw2WHl3bUF4S3VmZUdSMEw3S080cFJuMVNyWkd4R2YzU1JKNHVPSU80d3BB?=
 =?utf-8?B?V0ViV1Z2SE93eHRwb0Z0M1B6bmVFKytyUUl3RTFIcjZRNStuUmh3dDhXanQ0?=
 =?utf-8?B?eVQ1UjJLTDE1VlVPNVVEajFLR1NFQm5wR1hoeXZZc09CdG9CbXZ1NEFPbGN0?=
 =?utf-8?B?NGtzSllmcVlLbGVSSzNjNnBuc3pzZS9hZ0txbW5XNXpoY1hMRlk5MG5IQ1BD?=
 =?utf-8?B?enliOXFBZzJ1eDRHbWhzWFVJQWJwMWcvQUZHbDdVb2E2V3FVTXdKNWpnYzZh?=
 =?utf-8?B?RlJ3SVI3dDIza2J0WjhUWGVneVlTODZGdjZ4WU5xN2VCeHZhYloyLzdXNlAw?=
 =?utf-8?B?YWpPVVMzb2RhNVV5TGk4Vm1ZeDVETlNyTzdFaDlaRHM2S3pwWTNwcXdJRUVt?=
 =?utf-8?B?NnBDRXpPMGdyeEowNjFyMTd6eVk5c2lCYmtSaXMrdnAyd3BDWTlkemdHWFFC?=
 =?utf-8?B?OGhPNDl0MTBzUmtYeENBazN1dWpQeFVUT2hudWUxamdkdHFXTlEzaUY5UFFs?=
 =?utf-8?B?YVJ3WTlQblNCUmlqUWkxZXpkK08wblArdGpXRVZNcEpWUWFpaFlvSUlWMWd6?=
 =?utf-8?B?NGh6OFFGODJMOXRBSFR5N1hUQ0Y1bjlVZVJXN0lLYW5UUHpTYSsrc2RJblQ5?=
 =?utf-8?B?eklyenl5UEIyTzhqaHJaMFppNVZ2QXJ5OXowTDF0Vm5ZZFk2a3QvbFpmL2Ix?=
 =?utf-8?Q?Hv/d1qC+gz6O891kkVbZw3FiOtZE446yJq/qU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 361b7b21-3912-4bb3-56a0-08d9059bd5a9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 14:35:11.4729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HW0unxNY9Zv7B4i9CZgf/x/p2aGfFbIePFZXsQOoed/FS0jjaQT4cpMijkOwv14s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3886
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: cpBWmlgK8nNkuVjfDbT8NfvV6RZi5Wx2
X-Proofpoint-ORIG-GUID: cpBWmlgK8nNkuVjfDbT8NfvV6RZi5Wx2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_06:2021-04-22,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104220118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/22/21 6:55 AM, Brendan Jackman wrote:
> On Wed, 21 Apr 2021 at 18:59, Yonghong Song <yhs@fb.com> wrote:
>> On 4/21/21 8:06 AM, Yonghong Song wrote:
>>> On 4/21/21 5:23 AM, Brendan Jackman wrote:
>>> Thanks, Brendan. Looks at least the verifier failure is triggered
>>> by recent clang changes. I will take a look whether we could
>>> improve verifier for such a case and whether we could improve
>>> clang to avoid generate such codes the verifier doesn't like.
>>> Will get back to you once I had concrete analysis.
>>>
>>>>
>>>> This seems like it must be a common pitfall, any idea what we can do
>>>> to fix it
>>>> and avoid it in future? Am I misunderstanding the issue?
>>
>> First, for the example code you provided, I checked with llvm11, llvm12
>> and latest trunk llvm (llvm13-dev) and they all generated similar codes,
>> which may trigger verifier failure. Somehow you original code could be
>> different may only show up with a recent llvm, I guess.
>>
>> Checking llvm IR, the divergence between "w2 = w8" and "if r8 < 0x1000"
>> appears in insn scheduling phase related handling PHIs. Need to further
>> check whether it is possible to prevent the compiler from generating
>> such codes.
>>
>> The latest kernel already had the ability to track register equivalence.
>> However, the tracking is conservative for 32bit mov like "w2 = w8" as
>> you described in the above. if we have code like "r2 = r8; if r8 <
>> 0x1000 ...", we will be all good.
>>
>> The following hack fixed the issue,
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 58730872f7e5..54f418fd6a4a 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -7728,12 +7728,20 @@ static int check_alu_op(struct bpf_verifier_env
>> *env, struct bpf_insn *insn)
>>                                                   insn->src_reg);
>>                                           return -EACCES;
>>                                   } else if (src_reg->type == SCALAR_VALUE) {
>> +                                       /* If src_reg is in 32bit range,
>> there is
>> +                                        * no need to reset the ID.
>> +                                        */
>> +                                       bool is_32bit_src =
>> src_reg->umax_value <= 0x7fffffff;
>> +
>> +                                       if (is_32bit_src && !src_reg->id)
>> +                                               src_reg->id = ++env->id_gen;
>>                                           *dst_reg = *src_reg;
>>                                           /* Make sure ID is cleared
>> otherwise
>>                                            * dst_reg min/max could be
>> incorrectly
>>                                            * propagated into src_reg by
>> find_equal_scalars()
>>                                            */
>> -                                       dst_reg->id = 0;
>> +                                       if (!is_32bit_src)
>> +                                               dst_reg->id = 0;
>>                                           dst_reg->live |= REG_LIVE_WRITTEN;
>>                                           dst_reg->subreg_def =
>> env->insn_idx + 1;
>>                                   } else {
>>
>> Basically, for a 32bit mov insn like "w2 = w8", if we can ensure
>> that "w8" is 32bit and has no possibility that upper 32bit is set
>> for r8, we can declare them equivalent. This fixed your issue.
>>
>> Will try to submit a formal patch later.
> 
> Ah.. I did not realise this equivalence tracking with reg.id was there
> for scalar values! I also didn't take any notice of the use of 32-bit
> operations in the assembly, thanks for pointing that out.
> 
> Yes it sounds like this is certainly worth fixing in the kernel - even
> if Clang stops generating the code today it will probably start doing
> so again in the future. I can also help with the verifier work if
> needed.

I won't have time for this in the next few days.
Considering the current upstream merge window is close, yes, please
go head to work on this. Thanks!
