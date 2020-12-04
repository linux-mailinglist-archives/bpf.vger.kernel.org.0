Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E672CF0A8
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 16:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbgLDPW2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 10:22:28 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21926 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730556AbgLDPW1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Dec 2020 10:22:27 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B4FB6Qq014831;
        Fri, 4 Dec 2020 07:21:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=TKuoFalUHG67aYFEGGZfZEbv4MVrWKHi2z1k8rQj+SI=;
 b=nUF9fUwXC0WcljtaaUfE7JrRTbHRBL3DrN6E+QdHxzRNDeY2fhoYoM3EGcQeXzXt4MDi
 jbUgdkusEGFWLInq8pnkXfx7BsGymkwwSCJnCbDhee9jNDZ1yOIQLrqhJ84Hj9GtYXv5
 GNgoYlk42XkuTArEucuI5lIsklLuV+d3Zm4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 356xfr1xh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Dec 2020 07:21:27 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 4 Dec 2020 07:21:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rb7fPUPOSOGnEFjYHXb2qMw7jzj3eLMmeBP21sSeTbTRJweOIjLMXMF4VzQnq1dk/PP/nyf3aSWjar58kquihx1Sgwh1zmCXvIjPmVeuHnLTJPbAG7HiWUdcNMES7QvLSEGGwcWpaGo8fmfMINaLvAmZMbtq+dvo9VCxYHKfJ6CUBCTm7EMqqsrgEHnbJ8HtWTEHueySYeezgZ3J/EWVVyOctmAsRRe2zrIDg8yUVEqrdtLC7mqhvuLt+lGb7TicCtYt4jMCzYCOdbiT36uVZ2zFyA7wgItYJUF9/kjRy1matAqu06DPc8dFepf3YLu+ub8je0fb4/iiisTHlx/skQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKuoFalUHG67aYFEGGZfZEbv4MVrWKHi2z1k8rQj+SI=;
 b=lIIVSR/1lLbSAaTqPCYL/5Oaxc47BTrQM6ZM8Nns9FHoMz5kg2c/ucGqa2yLIZTW4fV5lhgj4RClyteTCLTU53UQOf7dcb24ejQQ9FPDl4mjBG2HyiAr3TwmjvVrxpPP+4O5A1nwPIparJrHn/iKqoNwl9Sp/d/SvMcjYr//fzZcPhJRZY3eXL6Ie0SUYpkifQf2dBbhTVDPmcL3MnqQoHu1BTD8GQ2l+9Iw4OgY2A9298R8DRQ1o0qtyUvHxxIrnQUDkohEYjennEuC0bcOfp4P0nx6NiWsi6SSgz5Qmpkv/jncTcA4evyQgnK/ndl10EhyHMh8sri136dLdoEnrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKuoFalUHG67aYFEGGZfZEbv4MVrWKHi2z1k8rQj+SI=;
 b=SS2gJZcRNFSR8Mnl48WTtEi7vH9OXC9q92fuK0CADfGfg8s7ju7c7H6BTqn5Soov61Dip+YzA/SDzsr6nROiyQRWttNhHJbBFhzPZ1L0Cn/gxhB0Vo5QiprpQAj5FU5odjlzAaAc8ITSEckRMaJxxsWlAiz3DvD0xQmatH70I5Y=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2408.namprd15.prod.outlook.com (2603:10b6:a02:85::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Fri, 4 Dec
 2020 15:21:25 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3632.021; Fri, 4 Dec 2020
 15:21:24 +0000
Subject: Re: [PATCH bpf-next v3 10/14] bpf: Add bitwise atomic instructions
To:     Brendan Jackman <jackmanb@google.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201203160245.1014867-1-jackmanb@google.com>
 <20201203160245.1014867-11-jackmanb@google.com>
 <86a88eba-83a1-93c0-490d-ceba238e3aad@fb.com> <X8oDEsEjU059T7+k@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <534a6371-a5ed-2459-999b-90b8a8b773e8@fb.com>
Date:   Fri, 4 Dec 2020 07:21:22 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <X8oDEsEjU059T7+k@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:fab1]
X-ClientProxiedBy: MW3PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:303:2b::20) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::12b3] (2620:10d:c090:400::5:fab1) by MW3PR05CA0015.namprd05.prod.outlook.com (2603:10b6:303:2b::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.7 via Frontend Transport; Fri, 4 Dec 2020 15:21:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bedc9bfc-7d07-468f-3ab6-08d898684356
X-MS-TrafficTypeDiagnostic: BYAPR15MB2408:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2408199FEBD90AEAEEF38E0CD3F10@BYAPR15MB2408.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VUUBkDI+IT+dPjg4xHlYbbgOrM9MvxW86bfvEfmMR0BJM1LMsjhQwb3cLwee5D1ld22otzKWBxyhRjUitbaskav2YREVpFv2dx/U0cNoC0XshJSoixro/W8rKUWF8RHnrR1lL3Bt5aDh+lejwIN18onWgBQ615QHNV8dK7P1AL2TP+S6IWyH29umyasU5sLaLikxyzWtQW09xbX4kIN1j1GsPxA2/IcWpFErL5BIgmgQPaqTJc7AmtJqBKc9iRHtZ9JvWKOUKqK1J5d9SBmII+nDZBmPyVmIGModubr/vlZTuQ3kI7QAFh5F4A2+ZComVVCT0UH2/hcgKk9hpdobm4PdTq0s00QpHE+Mkkl9aeYURTEUGcZzUCBUXv8+OQRdwhPQfwHRjci7DTi36asCU0m18kEJx8YDQVRNm+ZL/C0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(396003)(366004)(346002)(52116002)(8936002)(8676002)(5660300002)(86362001)(316002)(2906002)(54906003)(6916009)(36756003)(31696002)(53546011)(16526019)(66946007)(66476007)(66556008)(83380400001)(186003)(478600001)(4326008)(6486002)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U0NBZ1VjRE1jNFpvRG56L3ZWNU9LVGR3UDJxS2J5MGlhVVN4SVNESVlnMkli?=
 =?utf-8?B?R1lnYmZ3dDh3ZFcrWjdKSHE1SnBnMyt3L25aWmtUb3Y1WjBOVnUvS0FEeGR6?=
 =?utf-8?B?RVdwNVJUaWxDN3lnQ29IK3VHZEpqb3BKM2RrT0hOSGRWeU9hWTdjVFlJUyti?=
 =?utf-8?B?eTFLc0Q5dndTRXdNV0w2V0FFNGxrazB1ZXV6ZHV5S0w5bmxVZkVOK0JTWWkw?=
 =?utf-8?B?UHFIdUQrbm9qQzVKMFhtNHpKWWhpbURUTzlBejhRNnF5eitVbmlNZGxaZ3Ex?=
 =?utf-8?B?ZUNqancxWWxockNxTGNzWjhhUHZxV0Y4MnFiTkFzSUdUd011NStMQmtYZk16?=
 =?utf-8?B?WkVXUGMvbHpRNURuVmV1aTFZdm93ZnNMMDEvTUNyTHdRNXpOSnRuWDJIMStq?=
 =?utf-8?B?b01TWllIb01yQitjVDA2SEhJQVpjZjIyTktOSmJ2T2l0UjBXOHFpcTdMVDJP?=
 =?utf-8?B?RGUrUll6YjNSREdnZ2dEdWVFY2J6K0toOEIxNDhEOC91TCtITmE1aTI3MVhz?=
 =?utf-8?B?S3ZqV2tCYmIxUmtJalloVkJ5ZWVSRy9CRC9xbGVYVmpNdFNRT3BBczBGUlJm?=
 =?utf-8?B?VElOdVVxOVlzMkdtRldSNVV5T2hxSFNJRmdaL2dHSW00aGVzT3RPcTBNQ3kv?=
 =?utf-8?B?OE1NOHlvWVR4TUwzQkhQZzVETlQ5Tk5KNnFUQ0swK29EaU5jdTY0dHpPR0R4?=
 =?utf-8?B?Q1Bmczh0aEg3ckZCa2VxSWU4SjY3eWx6MGY3cXI3b3JiRi9haTdndk92Rzc2?=
 =?utf-8?B?RTZ1U1ROQzA0ZkJMMENYUlg2eDBtT3VldTd0QlZuMWV5cXhIemhVbWtVd2g1?=
 =?utf-8?B?UHIySHpvS2tYTEdBVmNwOHk4akZzajRvZitqYXNHalNiekw4UFRKYzNJVDdp?=
 =?utf-8?B?R1pWRUxYa1U2ekkrV1VPK3E4TGZ6Y21GTmRXamt3ZXVzTC9YSENyM3NxT3V1?=
 =?utf-8?B?aHkwZzNnRUV3RFEwR2piVG01UE9TZ1lReGlFVkhQVFpGMEdrY3pZOXBVVzJG?=
 =?utf-8?B?aHNpYVh5bTcwdEc3Wm1mclNMb2JBdklBNURuQnJabG9OdGhKUFg5UTlHYUE5?=
 =?utf-8?B?WnJYLzlKOWNNM1FvYlBDbmpuSUNlV1NJV1Y1eFE1YkxuQk1tVUxDSml0Q1pz?=
 =?utf-8?B?Z0RrV0VVd25iQVpLN3E1eXJJRWlkL1RzMzdUNE9tekRaVDRIb3Q0dGZvc2I5?=
 =?utf-8?B?bkVUQjR0NnZDaWx1U1VucVJBaFBvRlZja1JQQzJycUNBVU9kcmZTOFEvNVA0?=
 =?utf-8?B?QjErd0xEUDBCeW56WDlFMTFLMitOYXpqN1ppajkyZ3FHY3BrN0pjTzhTb21T?=
 =?utf-8?B?c2U5NFhBd0J5OTFQSGR6TDJvMjFnSlZjdE95aTluZWs4MFVXMnZFQlA2aTlD?=
 =?utf-8?B?ZU9SaFMxRDdFZkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bedc9bfc-7d07-468f-3ab6-08d898684356
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 15:21:24.8549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YBHHx02lqiIJ199qTRKOO2B7HlY9U3OV2aZDf3MpDLvIywHV0PjuczcKEMGOtyV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2408
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_05:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040089
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/4/20 1:36 AM, Brendan Jackman wrote:
> On Thu, Dec 03, 2020 at 10:42:19PM -0800, Yonghong Song wrote:
>>
>>
>> On 12/3/20 8:02 AM, Brendan Jackman wrote:
>>> This adds instructions for
>>>
>>> atomic[64]_[fetch_]and
>>> atomic[64]_[fetch_]or
>>> atomic[64]_[fetch_]xor
>>>
>>> All these operations are isomorphic enough to implement with the same
>>> verifier, interpreter, and x86 JIT code, hence being a single commit.
>>>
>>> The main interesting thing here is that x86 doesn't directly support
>>> the fetch_ version these operations, so we need to generate a CMPXCHG
>>> loop in the JIT. This requires the use of two temporary registers,
>>> IIUC it's safe to use BPF_REG_AX and x86's AUX_REG for this purpose.
>>>
>>> Change-Id: I340b10cecebea8cb8a52e3606010cde547a10ed4
>>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>>> ---
>>>    arch/x86/net/bpf_jit_comp.c  | 50 +++++++++++++++++++++++++++++-
>>>    include/linux/filter.h       | 60 ++++++++++++++++++++++++++++++++++++
>>>    kernel/bpf/core.c            |  5 ++-
>>>    kernel/bpf/disasm.c          | 21 ++++++++++---
>>>    kernel/bpf/verifier.c        |  6 ++++
>>>    tools/include/linux/filter.h | 60 ++++++++++++++++++++++++++++++++++++
>>>    6 files changed, 196 insertions(+), 6 deletions(-)
>>>
> [...]
>>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>>> index 6186280715ed..698f82897b0d 100644
>>> --- a/include/linux/filter.h
>>> +++ b/include/linux/filter.h
>>> @@ -280,6 +280,66 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
> [...]
>>> +#define BPF_ATOMIC_FETCH_XOR(SIZE, DST, SRC, OFF)		\
>>> +	((struct bpf_insn) {					\
>>> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
>>> +		.dst_reg = DST,					\
>>> +		.src_reg = SRC,					\
>>> +		.off   = OFF,					\
>>> +		.imm   = BPF_XOR | BPF_FETCH })
>>> +
>>>    /* Atomic exchange, src_reg = atomic_xchg((dst_reg + off), src_reg) */
>>
>> Looks like BPF_ATOMIC_XOR/OR/AND/... all similar to each other.
>> The same is for BPF_ATOMIC_FETCH_XOR/OR/AND/...
>>
>> I am wondering whether it makes sence to have to
>> BPF_ATOMIC_BOP(BOP, SIZE, DST, SRC, OFF) and
>> BPF_ATOMIC_FETCH_BOP(BOP, SIZE, DST, SRC, OFF)
>> can have less number of macros?
> 
> Hmm yeah I think that's probably a good idea, it would be consistent
> with the macros for non-atomic ALU ops.
> 
> I don't think 'BOP' would be very clear though, 'ALU' might be more
> obvious.

BPF_ATOMIC_ALU and BPF_ATOMIC_FETCH_ALU indeed better.

> 
