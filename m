Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756642D2042
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 02:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgLHBpR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 20:45:17 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10662 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726184AbgLHBpR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 7 Dec 2020 20:45:17 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 0B81iJmu012807;
        Mon, 7 Dec 2020 17:44:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=u25ckjK+2bysXzkVetK1sfnZt128DKd84j7HA6/IkpM=;
 b=Z/Tj4SEkyYj+LqAHZYbXa76wcHDAnX4nvdT4/Tb44ItAlNa2v9MkgwgnLMdcwizrf5Zz
 rT83iM6FNy2pDR4quKKq4h3AfSMCYA7aId7cRNd3OW7HWlUaDPWwB2UfThekj7SRUvoR
 8W16Q5W0DmdC8hxhUis3yLWTx2K/4QMW/Nk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3588025s1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Dec 2020 17:44:19 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 7 Dec 2020 17:44:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehp4G/VImXpyNyArKzX20vgEpanc1j8db8d0C+m4X+c2D1odbRKawYKMrTDXy/J84IZUIWGBOi9tvI1Hwgh37gSfzkZxF7Sw73lslG3A2CCIIR9a8F9AndK8kB6YQG/gzoEiHRR9KKBTyBFl0OzazkWrYDJu/K6gImzn/4hm4Ky3Ej4IyE/sMenSmEqiyWVniP8WQciM+SCRZtUB/xoavJ9fmTj8HbIxeyb6xI5cBxBhqsccM3fpW6NAXlzL1WGH8g5TKHRwePYNwg8Q61EW+8Ck2rO/oQNAyacKpZjPq4hd5m/dg/aVWZwBZUNCcZuiIUui8NsT/K295Vj6QtMK0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u25ckjK+2bysXzkVetK1sfnZt128DKd84j7HA6/IkpM=;
 b=BMb1VihOPcFjLNRDtl4VuCrqKozVer52H5HUmYCXi1hVXQntdqwT88XerJSuTjMyqVIgxPUd+MrDFEK3MKIpqHDtVgJXF23hH10CKGEx9r+4yezeDRnnXRkbW6xN8Eq90kE2o5ZEcSDuA59cAqEJIaxfnGe3eo366jY30fQm0+/SAMan3mqAiifJ6oBQB1VXLjwWKPbhAu5lkKCXKHbdlhnGdttp4WGoHsxPHzxlL5vkPY7ts8CFMMzdYVrTlcGAB+VxH4yOdMl/336eo0h07guovwIPRDG8NNx2OIHiRNYFVvqVaWmsb8OM403uPJALz4p8ZSHjLShTIArIaK4GTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u25ckjK+2bysXzkVetK1sfnZt128DKd84j7HA6/IkpM=;
 b=C3UqwPfM8zEcVcZrYaTDbWMB+fnRZWrR7pbCn/Xj+CNHrYpiqGNfmTml/fuugmUmwnj66hmMUZN1F0lC+3by4Cw0LYTq1qoAq5Ttbvs7gvRYaLGE9vB2R1jzXmsNKoWHKmKtSoWgqr2JccJSS/+hK8pAbF+MRHbUe5Pujz4merY=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2646.namprd15.prod.outlook.com (2603:10b6:a03:155::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Tue, 8 Dec
 2020 01:44:16 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 01:44:16 +0000
Subject: Re: [PATCH bpf-next v4 07/11] bpf: Add instructions for
 atomic_[cmp]xchg
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201207160734.2345502-1-jackmanb@google.com>
 <20201207160734.2345502-8-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <4b5812e9-9fd9-7f5b-e0a0-9404341285c5@fb.com>
Date:   Mon, 7 Dec 2020 17:44:12 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <20201207160734.2345502-8-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:ee04]
X-ClientProxiedBy: CO2PR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:104:1::19) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::113f] (2620:10d:c090:400::5:ee04) by CO2PR05CA0093.namprd05.prod.outlook.com (2603:10b6:104:1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.7 via Frontend Transport; Tue, 8 Dec 2020 01:44:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 907165f9-7905-413a-f2c2-08d89b1ac5c4
X-MS-TrafficTypeDiagnostic: BYAPR15MB2646:
X-Microsoft-Antispam-PRVS: <BYAPR15MB264648121FB076E65F2CCC6AD3CD0@BYAPR15MB2646.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YyQLlY7MszkbZiEJKZ37x6ubsMQXHt0EaK26igC6da/fR67PyCArgGJkPgDfto4+8ZweCq1wEzu7Puh8/0msUkDOhGxuB3OliQK/d7V0QZ36AOnejgSI+H/SjoBPyFVfBA6yAiB4ilxFcV8yIo+7r0T+L+U6EgnHjZeC9kVQS5EO87CQSFel4ENz1cqsS2dBp5TtUox4+2+Ybb40bXIOUf+QR46nMuXrvAidHC96IdmTspnFIoL8oh1Z1L99Upgzb8JZ+SNvXby+1wDYsy5w/zieMTyvfcJ6cYf2T/WpqO0CW4JT2goqFEPWpmH1VKH28yr537qDDeYJLEbLBq4+dJ7PgGJMdQClxScjkZnLuDN0pkz27zKp/g4qvMI213W4iaIExyNFHWj6B/oLkeCmQLZy85JbNRQHWctxcDMYynA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(366004)(396003)(136003)(52116002)(66946007)(66476007)(8936002)(66556008)(5660300002)(2616005)(2906002)(8676002)(36756003)(53546011)(316002)(4326008)(186003)(86362001)(31696002)(6486002)(478600001)(16526019)(54906003)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NXdrM3R1aEd6WWw4Rmo4R3lzY2RsQ2NlV015VFRvT0wveFpqMjROcXdWNU9z?=
 =?utf-8?B?NiswTDVkbjZ1TFkveTV0MmdDOUlZSFJkVG9INTkvR3RsQmZFN3ZLNWJoVjNW?=
 =?utf-8?B?ZDU0VGhDNDRUN2hVbWRrOGx6eTdMenkxQ1MrbkRLNnArdHZzOWJYakI5WXpw?=
 =?utf-8?B?a2dnYWJhM3ZNYWFiYnI3VEY0YXNYL2tNTjY5WWR1M1FXUnNGeVJsM2RON3Fs?=
 =?utf-8?B?QThhazJnT0tBZVBuTTdOSC9QalJBTFppQml0UzgzdlJNM0VuTnpyalA0eWpU?=
 =?utf-8?B?TC9zRWtVQ0pGNVFFUzhlQXpIUFJ0N1Vra1FlQlo4UlZNdDNwR3ZkSUFheDVh?=
 =?utf-8?B?QVRKZmFHeGx6bW9LMzJKRFNtL2d1Q1BTdzN5aDN3cm4yYXEyTGw5N2RaSCtO?=
 =?utf-8?B?OTcwcWY0Q1NyTzFQVzRnbGJyRVEwZjUxWXVJWFZhQWM2L1dBa3J2ZWF5S01u?=
 =?utf-8?B?WFJyN2FEWXBBMjlkTzE5WWlEYWdaekJaRGFpd1FoY3pub21iYWRtZlV2SmZ6?=
 =?utf-8?B?VmhWSkpWOThpYXZ2a05xUWJxbGY3WFNGcEFzN3dIZUNESzVzdzZ1TjE2WmIw?=
 =?utf-8?B?UTF4aUJ0R1FtN0lya1BkdWorZmQxR1R2eEltQVlHOUdlOGg5K3JHM1V4endk?=
 =?utf-8?B?VjdmYTZhMjR4K01YUVBMOXdReS9uVnArR09GRzNZSEhJemxUa2VhWUsxRnVY?=
 =?utf-8?B?amhEOUtocklaUVZPYWt0YVkzem82eXR2c2tUS1NuODA4OTlLQ2JEeXJZUlVo?=
 =?utf-8?B?NHk5R3I5djlQbThFUTJrVlEzcWlESks5c0ZVTFpicGlIUU14RCtMTHpmajRi?=
 =?utf-8?B?S2V3VEMraFdCWER6SnRPVHRMelBQdmJlc3l2YVgxT1UxY1V4ckJLbzZJc0M1?=
 =?utf-8?B?QVkxVWdCbkp4MGZqT0Y4VThrU1Z6cU1vdy8wVEFnWWN6WFNLWmV1cTdtc1pY?=
 =?utf-8?B?akxUaUE4a2lQNWwrKzRYV1NGcHJLNTVkdnVXSjg4UTV2VWhidEFGNW01OFNa?=
 =?utf-8?B?cU9CdFZLU3BKc2xjazZZYzRreHR2WkQ4L0JDTUl1Z3JHUVdkZ081ZTIyMkF1?=
 =?utf-8?B?eHU2aHBIS05Lc2RXSGRPZjBtaXA2NjhVM3FnSnBRL3BCU0RYbUx0TXVtY2dR?=
 =?utf-8?B?SlNaekc2a1pVT08rTFJTQ3kxWEk0SnhMSW1PMkZPMUFWTXNlM0ZZWFJWMndv?=
 =?utf-8?B?c1NFR01MbllXSVoyTmE2YmErYVhZdnl0RisvVHh1YUdPQm5wSGRIRmdIZW0v?=
 =?utf-8?B?VVlsamhJb0JyVXcyVDZWdUtodGVBZWVIMzhJc0YvWGQxcG90L29IakJBLzVG?=
 =?utf-8?B?V2VhL0FFUzVhandONHJraDVqTVNhNEZ0RW1ETkZEcGt0SGc2VEhucEZPb3Nj?=
 =?utf-8?B?NDNGR0d3dWIwTHc9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 01:44:16.0789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 907165f9-7905-413a-f2c2-08d89b1ac5c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyN1dR3tkJUIcadwogwNSPc+bu1Cm73xEf8NfTLN0flu965cV7dIuXq1qh4ikQfA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2646
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-07_19:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 impostorscore=0 spamscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080008
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/7/20 8:07 AM, Brendan Jackman wrote:
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
>     flag). That means return-old-value is easier to JIT.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>   arch/x86/net/bpf_jit_comp.c    |  8 ++++++++
>   include/linux/filter.h         | 22 ++++++++++++++++++++++
>   include/uapi/linux/bpf.h       |  4 +++-
>   kernel/bpf/core.c              | 20 ++++++++++++++++++++
>   kernel/bpf/disasm.c            | 15 +++++++++++++++
>   kernel/bpf/verifier.c          | 19 +++++++++++++++++--
>   tools/include/linux/filter.h   | 22 ++++++++++++++++++++++
>   tools/include/uapi/linux/bpf.h |  4 +++-
>   8 files changed, 110 insertions(+), 4 deletions(-)
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
> index b5258bca10d2..e1e1fc946a7c 100644
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
>   #define BPF_ATOMIC64(OP, DST, SRC, OFF)				\
> @@ -293,6 +295,26 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
>   		.off   = OFF,					\
>   		.imm   = BPF_ADD })
>   
> +/* Atomic exchange, src_reg = atomic_xchg(dst_reg + off, src_reg) */
> +
> +#define BPF_ATOMIC_XCHG(SIZE, DST, SRC, OFF)			\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_XCHG  })
> +
> +/* Atomic compare-exchange, r0 = atomic_cmpxchg(dst_reg + off, r0, src_reg) */
> +
> +#define BPF_ATOMIC_CMPXCHG(SIZE, DST, SRC, OFF)			\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_CMPXCHG })

Define BPF_ATOMIC_{XCHG, CMPXCHG} based on BPF_ATOMIC macro?

> +
>   /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
>   
>   #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index d5389119291e..b733af50a5b9 100644
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
>   
>   /* Register numbers */
>   enum {
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 61e93eb7d363..28f960bc2e30 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1630,6 +1630,16 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
>   				(u32) SRC,
>   				(atomic_t *)(unsigned long) (DST + insn->off));
>   			break;
> +		case BPF_XCHG:
> +			SRC = (u32) atomic_xchg(
> +				(atomic_t *)(unsigned long) (DST + insn->off),
> +				(u32) SRC);
> +			break;
> +		case BPF_CMPXCHG:
> +			BPF_R0 = (u32) atomic_cmpxchg(
> +				(atomic_t *)(unsigned long) (DST + insn->off),
> +				(u32) BPF_R0, (u32) SRC);
> +			break;
>   		default:
>   			goto default_label;
>   		}
[...]
