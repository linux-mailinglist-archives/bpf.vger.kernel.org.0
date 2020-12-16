Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402A82DBB5C
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 07:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgLPGsZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Dec 2020 01:48:25 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18408 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725274AbgLPGsZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Dec 2020 01:48:25 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BG6VWYF024375;
        Tue, 15 Dec 2020 22:47:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=hWFLEAL2vtG9xJnNDTaRS9SnmFrvCFFnf+7aLDXBhGE=;
 b=g3vzW8w5LkBKKcWHt1VpEOkmqhmvQ0gvpggGC49JhrXCC9feOjDRhcf6Jx1SldI9wXQE
 w+k5Hzik7JztYb7Te2zq7ksLQYl8posSBG5kbPvOof6BU9HBcgoldVPHwoGEMQ+nelHT
 pBuPdG0BvcDF3nQFQAPnDQWKFjercTwjNqQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35ewhdn217-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 15 Dec 2020 22:47:26 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 15 Dec 2020 22:47:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Anyk9QeWAJxauyPjavZ6cKxpkXS0L6wtkqHWKl6nBQAKM4cluUZB+KQ0a92Fl73+RPOtKvt5JzA+wh6q1+eThLRcTSTsZN49XXxcfcceG6mwDSU28mgr/4BYjwldxrmWTQAgkSXKWZ52Wh4+kCsXsfYJAnPwPi8edlVYDPr+Kov/mBXX+Zhf5W3Z4VWL59nSVEUwtP2Pa6HVNSHpRo+c7R05vJJixjQHJEFgj03txRYnAGog9QbQYuhFK6DwdSMiXyLBq2Psq/1MZRFqYSfS2D20Hnwebhqv1UZsnZkypFamrlAS+4A83Oc9QN54QoA4wzoJp2nRXzschge//FJe9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWFLEAL2vtG9xJnNDTaRS9SnmFrvCFFnf+7aLDXBhGE=;
 b=REVBmj4XZ7XbVZdnItglF8+yx5dFErrUEMJB7BOQbNn0wfcJJmeR5IQbyv+V49fnx/RS6CzPL93x6CldZ6qhYgkx2NCm3LMhGBp/n2VhBOY4iRMb4Y5Hdc72qWfYeD6Whj7XW7GbaNoT4/TVXQ+vzcV/rcnlW14UAzt50U67RYxjqjM+Lgj3kNbg0vGMOPxYbBiyPZe5+DeGGwGGxxHhhj6QIHzKERTxZrxvAiG8QpN43iBHMcPOXsxy/UGg40Nb0n+LIDz9fl5k4f0MKuXJFZUWXTdu1iUubuEtOalddUBF9XChxqbvfAIXIcAEHWQ6Jjw6DvgDkQ3RsW7vu/bukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWFLEAL2vtG9xJnNDTaRS9SnmFrvCFFnf+7aLDXBhGE=;
 b=SSecFgj7jLh05Y8d961Ezn6MPK6HvhG6RjUAmeAAF1b8iKb+OWB+Mg8eqp49EfiNsMoD2cQYAH+Xl8c6bDuTa55LLJsyfzVJlEqVfnvYRlCDFEIEG/yi0SLP5RcZqCRcoMzXM2nlHdfWLAAe70n8HvWJhqoqpB20le2KEepP9pk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2822.namprd15.prod.outlook.com (2603:10b6:a03:15b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Wed, 16 Dec
 2020 06:47:22 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 06:47:21 +0000
Subject: Re: [PATCH bpf-next v5 07/11] bpf: Add instructions for
 atomic_[cmp]xchg
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>
References: <20201215121816.1048557-1-jackmanb@google.com>
 <20201215121816.1048557-9-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <eac87f05-708b-0ac7-4c76-6babd9ab5f56@fb.com>
Date:   Tue, 15 Dec 2020 22:47:14 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <20201215121816.1048557-9-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:9412]
X-ClientProxiedBy: MWHPR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:300:4b::24) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::12e6] (2620:10d:c090:400::5:9412) by MWHPR02CA0014.namprd02.prod.outlook.com (2603:10b6:300:4b::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Wed, 16 Dec 2020 06:47:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7df9bec6-02cc-4ce9-d726-08d8a18e709d
X-MS-TrafficTypeDiagnostic: BYAPR15MB2822:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2822A1046016A218FE5EC33FD3C50@BYAPR15MB2822.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z5tVcH5d4YKqZ0tqE82quYe1/YLhrxpwVb4NnfLVzC6rjJLZ/axAv3OWn/ZeLSFp9hzzLB/D5hlcxlrZs914IJgJFFTKutIraaIOnyLLvoga9lSTU0q/0lHdu2qQPDzWKcfgDDvYJD2xAm0Y3oY5CN2KHPI8E7V9ceUMcR9Uf6qXUdzcQvFzrcSSHpspDCEyaPnzFhm6yXn+OjUTIgoHgC/5SXEGZXZICkA1mUkr7NWQ+yLv+l7rmuXkPC3FaO9DA9BAanOHGqVngS884tTcs8I/WO7tNZRT3H+YeYV/60JLamN6XrKwvupcY2tR5wPjtUcC5n1RYTNN/TusoYRBl8wZZXAaahcgQw0XveEGfFFkzx9F2DCnNaCBsj9sQLWEDmT64YGT8C5MiVoiqA8G8o3hMFSmJPlNAvmbs6X19Ok=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(136003)(366004)(346002)(31686004)(54906003)(36756003)(8676002)(5660300002)(2906002)(16526019)(316002)(86362001)(31696002)(2616005)(6666004)(83380400001)(8936002)(66946007)(478600001)(4326008)(52116002)(186003)(53546011)(66476007)(6486002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZHdzb1JHZ0picDgzTzV2Wi9sNk9RV3ovbDVpYkM0MlQrY2c4NDNwbWE0c1N2?=
 =?utf-8?B?L1o5R1NCb3FzR0tSUmYyMWpDQm5vbFN3dnZrOVF6TVU1VjlsTU5rZXRGczdY?=
 =?utf-8?B?d2YrcjI0RXhnbFFFTzFuNGhFM2tZVWdLR293dUNUUVZCWjR4d1lJWDBuMFk4?=
 =?utf-8?B?YWNnZDBOOFVQbzBacnJ4WUVwOEJ0MnpsUkdiREFqcmQ4NUl1Qm13NnhSMWFu?=
 =?utf-8?B?RC9kMkxDSEVueXE1T3h0S2grM21HTmdYSEhhT1lMLzZHLytjSk1KYjM5OXEz?=
 =?utf-8?B?SGFuZW9GZkJsWEZCYnova3VYc2hUYjJCQStzOUcwaS9JWStGNUpGWW1zZXho?=
 =?utf-8?B?ODhqcGlaVDQybVl1UE5XZlJtV1N0NVJKWjJEdEhoVEpSZXl5a0VvSnE5OERE?=
 =?utf-8?B?dVllbUJvY1IwR2JtRVpxUmR0cnZIM1pKRTYxU3ljczI0dFRhM3BXbkIxNUZW?=
 =?utf-8?B?Y1pmQlU0a1k2Y3VyQzN3cG10ZzUzVm1SdXh2bnp3TS9MTFNndVRVWUw3bzlV?=
 =?utf-8?B?UTAwOVFINWZWZWpwQ2ZzTVpmaGtkMHZOSzlmTnRPR0FCb2NTUUlzMFdpRlBq?=
 =?utf-8?B?b3RTeGJ6Sk5WZ0JGT3REUkRtYi9CVTVaTTJBUnBnQ0RKVks2YzR5THdaQ1Vr?=
 =?utf-8?B?OWNOcElFdmVzTU9SSWRxekRNSGNJWXZaT3o2SXVHWEhOcHd1RExBNEwrS3U0?=
 =?utf-8?B?Um0wNFB2bHc1WU8vK0FDdEVZek5tdnJSNXpGN3V1Z3lQN1VVb0tFRTdTdk9X?=
 =?utf-8?B?aDU0OEJrSVVOWW5QazFwTGpUeTZ0aWtQSkRFZWJiNG9Sb0RQT1l6YXpOUy9O?=
 =?utf-8?B?Y004NlpoZnc3ZCtTL3ViMk1ZVmJzNDM3ZVZNNE1tVDlKNmFvWjRpL0FUWmFC?=
 =?utf-8?B?bHJuSjBCVnRNbGoxb3ZPSERCRExpdDRSTnZ2b1VXelV0ZURhVXpUQnBjRTRJ?=
 =?utf-8?B?dUd0djU5MHdSL1dVakcrSVZFMDhFbjBHRHVXdERSa0V1Z2UwYkp4dVUwb2ly?=
 =?utf-8?B?NlZPbFFnWGJtWUZKeWNtejZKcXphM2w3RGJCa1dVSmFOdGs1MXp0ZUxwUGJs?=
 =?utf-8?B?T3lmNWlQQm5nNlVFOHZxdjlHb2RJb0swUG9hbHRkc2o1UUo5dHgyVWpaYnpX?=
 =?utf-8?B?NDNnc3hTNkdnWUVwcTUxWnNFSVlra3VMOVJWZXdnbWlIVXpLV2tJWUQweEEw?=
 =?utf-8?B?TlpIWGhKZllKWEFSSnowQitKOCtKZU1hNWFvUFF5cGpDWUNKY0VLeUhQQ3lJ?=
 =?utf-8?B?b3ZraDkxKy84R0NVeEYxK0ZMZysrMjVacE1zeTlCVFFwcGgzSTk5U2xPWFll?=
 =?utf-8?B?NEtBTWpmQmxVUzU5cWxIWmFVdVdhaUozT1ZJN0ZTNGtwNk5MVThrVHYrd3di?=
 =?utf-8?B?VTkzSWhXL1JKTUE9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2020 06:47:21.8466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df9bec6-02cc-4ce9-d726-08d8a18e709d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZpAUO9Tx+gCivZK7OhHPuqi4DRm4Kbhk0JM0dbTVo8hrOOlYn1KzBPAu8B0Vi09
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2822
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-16_02:2020-12-15,2020-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160040
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/15/20 4:18 AM, Brendan Jackman wrote:
> This adds two atomic opcodes, both of which include the BPF_FETCH
> flag. XCHG without the BPF_FETCH flag would naturally encode
> atomic_set. This is not supported because it would be of limited
> value to userspace (it doesn't imply any barriers). CMPXCHG without
> BPF_FETCH woulud be an atomic compare-and-write. We don't have such
> an operation in the kernel so it isn't provided to BPF either.
> 
> There are two significant design decisions made for the CMPXCHG
> instruction:
> 
>   - To solve the issue that this operation fundamentally has 3
>     operands, but we only have two register fields. Therefore the
>     operand we compare against (the kernel's API calls it 'old') is
>     hard-coded to be R0. x86 has similar design (and A64 doesn't
>     have this problem).
> 
>     A potential alternative might be to encode the other operand's
>     register number in the immediate field.
> 
>   - The kernel's atomic_cmpxchg returns the old value, while the C11
>     userspace APIs return a boolean indicating the comparison
>     result. Which should BPF do? A64 returns the old value. x86 returns
>     the old value in the hard-coded register (and also sets a
>     flag). That means return-old-value is easier to JIT, so that's
>     what we use.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Ack with a minor comment below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   arch/x86/net/bpf_jit_comp.c    |  8 ++++++++
>   include/linux/filter.h         |  2 ++
>   include/uapi/linux/bpf.h       |  4 +++-
>   kernel/bpf/core.c              | 20 ++++++++++++++++++++
>   kernel/bpf/disasm.c            | 15 +++++++++++++++
>   kernel/bpf/verifier.c          | 19 +++++++++++++++++--
>   tools/include/linux/filter.h   |  2 ++
>   tools/include/uapi/linux/bpf.h |  4 +++-
>   8 files changed, 70 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index eea7d8b0bb12..308241187582 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -815,6 +815,14 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
>   		/* src_reg = atomic_fetch_add(dst_reg + off, src_reg); */
>   		EMIT2(0x0F, 0xC1);
>   		break;
> +	case BPF_XCHG:
> +		/* src_reg = atomic_xchg(dst_reg + off, src_reg); */
> +		EMIT1(0x87);
> +		break;
> +	case BPF_CMPXCHG:
> +		/* r0 = atomic_cmpxchg(dst_reg + off, r0, src_reg); */
> +		EMIT2(0x0F, 0xB1);
> +		break;
>   	default:
>   		pr_err("bpf_jit: unknown atomic opcode %02x\n", atomic_op);
>   		return -EFAULT;
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index c3e87a63e0b8..16e0ba5e8937 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -265,6 +265,8 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
>    *
>    *   BPF_ADD                  *(uint *) (dst_reg + off16) += src_reg
>    *   BPF_ADD | BPF_FETCH      src_reg = atomic_fetch_add(dst_reg + off16, src_reg);
> + *   BPF_XCHG                 src_reg = atomic_xchg(dst_reg + off16, src_reg)
> + *   BPF_CMPXCHG              r0 = atomic_cmpxchg(dst_reg + off16, r0, src_reg)
>    */
>   
>   #define BPF_ATOMIC_OP(SIZE, OP, DST, SRC, OFF)			\
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 760ae333a5ed..538b95472c8f 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -45,7 +45,9 @@
>   #define BPF_EXIT	0x90	/* function return */
>   
>   /* atomic op type fields (stored in immediate) */
> -#define BPF_FETCH	0x01	/* fetch previous value into src reg */
> +#define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
> +#define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
> +#define BPF_FETCH	0x01	/* not an opcode on its own, used to build others */

Although the above code works fine, I would suggest to put
BPF_FETCH definition before BPF_XCHG and BPF_CMPXCHG, which
makes more sense intuitively.

>   
>   /* Register numbers */
>   enum {
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
[...]		\
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 760ae333a5ed..538b95472c8f 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -45,7 +45,9 @@
>   #define BPF_EXIT	0x90	/* function return */
>   
>   /* atomic op type fields (stored in immediate) */
> -#define BPF_FETCH	0x01	/* fetch previous value into src reg */
> +#define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
> +#define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
> +#define BPF_FETCH	0x01	/* not an opcode on its own, used to build others */

same here.

>   
>   /* Register numbers */
>   enum {
> 
