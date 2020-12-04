Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734DB2CE78E
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 06:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgLDF2M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 00:28:12 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55896 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727038AbgLDF2L (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Dec 2020 00:28:11 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B4592Dj013515;
        Thu, 3 Dec 2020 21:27:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=hXisyTH6gO4XG6RJ89e6QdZROHqDOZh/cDUMsbz8DAY=;
 b=YiaGblkaYlIP15CP4tiULJPiphtCFnjRt9+ubHUqF1V90VP/VAur4RmDRKxr9FSlieC6
 wIqjGWlL9QAXVz4KzZz3BZFkbm1a8N3znNM/lXGhDXsNOF7kz53GSBlhFACcgubdF8Ex
 /IyxwVflI+5TN8exYplPfuRxTS3Vn1TG64Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35615fsnbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Dec 2020 21:27:13 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Dec 2020 21:27:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnJO+KdkdUYmiDhU83cwwF+D/jPhBTQmzT36OngwUSA3nt6xTHEH9UgYPWVxhTZ9vrLe0nhyzxTOkD4Q+wPLFO0nmo+cPwnwV7i5cgg8jvIkZbOBp1w/BR4nOy7U+MUIM8ysIDSnFjLFr1v+k7abuuRVxXKwbYd6cp87tXzmZ44dKy5hWs8oT6HO10SwyHPRiLOal2Mb07RPxu4lrQDBErLtMeqOmu3a3RTUE5Xh8+eXsHY5tRUQHrZEFTx0lMKSM+9OrFKYCdImRZho+6fiRMA7Y5+4uq4lbFoSuiKOTJaP155RHduIRIXnIG8/SH0yPjjajJH4q9Fc8CFYV6Kr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXisyTH6gO4XG6RJ89e6QdZROHqDOZh/cDUMsbz8DAY=;
 b=Ebz3bKdg68+5ShNthG48JzgMQK0BMkeMIqgHI/qb/rX00uMwUgExdVimIifSZqNpZhPter+RQ78SYzRBtn3CyWH/ywIrOjgxmBjasEDutXLDo3UJSh/wHsNv0osUv4U+/iiVvO7EusnOgBkJ0ramWKR4A5N64A7TieIwUd/EHrqAM23s2XeNFnVF8ypGrC0syxK+W64JVgN8Hps2zsfO6ObBWo9SHJTpQyWTXYckByhze1MyTjCG6va8PGjXn55A8JB1iVKLG6ztolPWmrZqyFDb7LgKHwKVu/aDdBgVz4/zucOtYb4rGblb/pgU4IC2zEsRGj92vgRn9hhdr0nDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXisyTH6gO4XG6RJ89e6QdZROHqDOZh/cDUMsbz8DAY=;
 b=BsN/ctlIH8CiCkTgnjIlbp4cIgCyIdRwU/X3IBpp5GxbGFw0mS+Fx6JZrYKcX3VJfJpOSJ8rJ/g8LEorvefrLSPfXnUF9+vipRqUaaeL7nEiJEirLjPVvvxRRUAacFQcq4Tkq7rrDXPTdCMtACi1mppkaX80vVLqz0hbxc49Q8Q=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2263.namprd15.prod.outlook.com (2603:10b6:a02:87::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Fri, 4 Dec
 2020 05:27:07 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3632.021; Fri, 4 Dec 2020
 05:27:07 +0000
Subject: Re: [PATCH bpf-next v3 07/14] bpf: Add BPF_FETCH field / create
 atomic_fetch_add instruction
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201203160245.1014867-1-jackmanb@google.com>
 <20201203160245.1014867-8-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <45b3d69d-7356-2c28-e507-897889be564c@fb.com>
Date:   Thu, 3 Dec 2020 21:27:04 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <20201203160245.1014867-8-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:86b1]
X-ClientProxiedBy: MWHPR21CA0029.namprd21.prod.outlook.com
 (2603:10b6:300:129::15) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::12b3] (2620:10d:c090:400::5:86b1) by MWHPR21CA0029.namprd21.prod.outlook.com (2603:10b6:300:129::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.2 via Frontend Transport; Fri, 4 Dec 2020 05:27:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58a9750f-baaf-4477-c722-08d898153dc4
X-MS-TrafficTypeDiagnostic: BYAPR15MB2263:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2263067EDE81C14F3B8CA615D3F10@BYAPR15MB2263.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:128;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y6tFKjbkpUdAuSGy9jULD55ZmhHYLskMk3uTUjJbRCTeSXSQicELAs8BrI54n5Dn3WKLeWWqzmuTkw/pfmnfUdEXUY2/NI19Y5J3D/3VIkMTxAceZ0cZz/lmV1tZLfx7bAq5szo7W/Fs2R1ak2bm8j56AwJzSSGdBMfY8Z8cjyafXGD3Ilvc2HbHhqatCf1BXIok+LBUIz02lFqnL6GwGFxiuVAOEr1u8Uop3QdV98y/2osjRMpG21F/By3Bae4sy2qve1djZhP1KLrDfEZfSWUGouulPdjf/eUQl34Dhi6Yqd+wbk3GU6kSdIYtFVHSVAV+0Jpq4F/OoQ7ZvUfQs6REo2RS4xnQRFZW0o/oMguUdtOeWERRxvUVAlEuKlvVHHrEBwvistAeJ4m3nAuMRZcV2sy3aGIlgIBKi8tiLJc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(346002)(376002)(396003)(54906003)(31686004)(6486002)(2616005)(2906002)(16526019)(53546011)(186003)(4326008)(52116002)(316002)(5660300002)(478600001)(8676002)(8936002)(86362001)(36756003)(66556008)(66476007)(66946007)(83380400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OXNvR0lIeVIxN2ZrazI1Q0hFdjE2WEpneUFLdWYwL1R1R3VOVXdyc3pLUkE4?=
 =?utf-8?B?NGIzSGh2WFRFS3FPQURRdWhnRFRlM3MwRXRGeEx2L2NPQmh4cy8wL0U3N3JQ?=
 =?utf-8?B?U3hCRUF6bjRONjhyQjVCQTlkRktPNkZHb1gxdXF4QkdDWjRyQVF5dTFHTTQ1?=
 =?utf-8?B?Tm9yR0hGam15bHp2VW01Y1RxTCtFcW95TEZLQzBjS25nc3pvUWI3bWMrTlY0?=
 =?utf-8?B?Um9BUjVZckhHWmhxbEZBK09zZHRUeWozWnFzQjVHZUlLS3paRDlSelJsbTcw?=
 =?utf-8?B?ZElSa3M4aGpFMVRrSmtJbXBzem9FTGtqeWtZOG1FTGdyVGRId3RvUDYxRjZW?=
 =?utf-8?B?V3NNeGJ6VWcyb1R2d1J5Q3JMVXlIMlR0ZDQ1RFZpK1YrRHVKcUppeFNHbU91?=
 =?utf-8?B?TTVOVmV6a004eEdaNzV6U2RwWVVRZWQ1TUo0OUQyVHRnTEVPLzJHUEFpbnVP?=
 =?utf-8?B?b0VGZ2tiNzRmL21VaVlVVGpQTDQyVmZDdzI3VzZSd2ZsZVZ1MkJEc3hQMVVC?=
 =?utf-8?B?VVFUYXdVNVhlVlhUYkNZQ1JNRDJuajJsalI2akZmbGRjUVFPRWszczBNZEdy?=
 =?utf-8?B?QmVDdVAzTElPclNYcFRvemlOMFluRUxZc1o1VjA5MXlkdTJuRmgweE1XTDJW?=
 =?utf-8?B?bE9BWkpqUVBDZXlNLzBpeDNFeW1KK2JaL3J5N1liWE5lbFFHbUhtSzJqVlBZ?=
 =?utf-8?B?SHo2MjhWaGNCZWRHU2pRejdHVU5tUmhvTS9QbWlqZU5hbGRveVIyc0JzOEMx?=
 =?utf-8?B?U2pmV0ZTRm12d0RkalBVU2htRzVIc3lsTVlDVHdka2JHRTJhVnJsSU0zQmNv?=
 =?utf-8?B?RFphckViNWZJOFBpcGZsVUx1MlAvUFNlOGJXcmFIN1B0R2MxNXNBTkpmVElZ?=
 =?utf-8?B?MUkxUTd0eHdhS2RlYjd0Y0UrNkxqaTgyRm1EVVk4aGJaR2UyVGx6SDdCeTZU?=
 =?utf-8?B?MmhJeWF6R0NsV1VqOUhlUWhTcEpoTDdWSFBHRXZUSVNONU5nV0FKUnFtQmRU?=
 =?utf-8?B?QmdTZS95cWlGTmxuUXNKWUFPWVI0SGU1WDk1U0N0UG1iL1JuaXZTM2tINEtj?=
 =?utf-8?B?VXcwR3hLTEsxb0s4S204Qk5RSDlnaGlNSkRPdk5JbE1IL2x1ajFXZTFycTV6?=
 =?utf-8?B?alBEc0dtMTIvenFTejRWRERQUWRvSjA0YURhQUMwWStnNm1GZmpmd3FkVUw0?=
 =?utf-8?B?Y0NqNnFDeGxaSldIRzhmOE1TTG9tc0hUcEZ5VUs4d3JLcnIzckRQT21PekxO?=
 =?utf-8?B?QUUrazhVY3BBOFZHMWxZWXEwejRXa1pkQnB3L0hoMFMvdng5aFBibmF6QklE?=
 =?utf-8?B?MGtGa004MlpUZTFrYk1Ya2ZMNVV5ME42TkdYL0Fkcm5jV0lTdk4zRHY5ajVq?=
 =?utf-8?B?VGw5VHB2bkxyNmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a9750f-baaf-4477-c722-08d898153dc4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 05:27:07.2315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +uiunbFPngO2YTZh2NPXbEO8caSC9bQKD/1DeL8NmWVRoALTgX27rUYF/RFQFN1q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2263
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_01:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012040029
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/3/20 8:02 AM, Brendan Jackman wrote:
> This value can be set in bpf_insn.imm, for BPF_ATOMIC instructions,
> in order to have the previous value of the atomically-modified memory
> location loaded into the src register after an atomic op is carried
> out.
> 
> Suggested-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> Change-Id: I649ad48edb565a32ccdf72924ffe96a8c8da57ad
> ---
>   arch/x86/net/bpf_jit_comp.c    |  4 ++++
>   include/linux/filter.h         |  9 +++++++++
>   include/uapi/linux/bpf.h       |  3 +++
>   kernel/bpf/core.c              | 13 +++++++++++++
>   kernel/bpf/disasm.c            |  7 +++++++
>   kernel/bpf/verifier.c          | 35 ++++++++++++++++++++++++----------
>   tools/include/linux/filter.h   | 10 ++++++++++
>   tools/include/uapi/linux/bpf.h |  3 +++
>   8 files changed, 74 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 5e5a132b3d52..88cb09fa3bfb 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -827,6 +827,10 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
>   		/* lock *(u32/u64*)(dst_reg + off) <op>= src_reg */
>   		EMIT1(simple_alu_opcodes[atomic_op]);
>   		break;
> +	case BPF_ADD | BPF_FETCH:
> +		/* src_reg = atomic_fetch_add(*(dst_reg + off), src_reg); */
> +		EMIT2(0x0F, 0xC1);
> +		break;
>   	default:
>   		pr_err("bpf_jit: unknown atomic opcode %02x\n", atomic_op);
>   		return -EFAULT;
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index ce19988fb312..4e04d0fc454f 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -270,6 +270,15 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
>   		.imm   = BPF_ADD })
>   #define BPF_STX_XADD BPF_ATOMIC_ADD /* alias */
>   
> +/* Atomic memory add with fetch, src_reg = atomic_fetch_add(*(dst_reg + off), src_reg); */
> +
> +#define BPF_ATOMIC_FETCH_ADD(SIZE, DST, SRC, OFF)		\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_ADD | BPF_FETCH })
>   
>   /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
>   
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index d0adc48db43c..025e377e7229 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -44,6 +44,9 @@
>   #define BPF_CALL	0x80	/* function call */
>   #define BPF_EXIT	0x90	/* function return */
>   
> +/* atomic op type fields (stored in immediate) */
> +#define BPF_FETCH	0x01	/* fetch previous value into src reg */
> +
>   /* Register numbers */
>   enum {
>   	BPF_REG_0 = 0,
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 3abc6b250b18..61e93eb7d363 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1624,16 +1624,29 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
>   			/* lock xadd *(u32 *)(dst_reg + off16) += src_reg */
>   			atomic_add((u32) SRC, (atomic_t *)(unsigned long)
>   				   (DST + insn->off));
> +			break;
> +		case BPF_ADD | BPF_FETCH:
> +			SRC = (u32) atomic_fetch_add(
> +				(u32) SRC,
> +				(atomic_t *)(unsigned long) (DST + insn->off));
> +			break;
>   		default:
>   			goto default_label;
>   		}
>   		CONT;
> +
>   	STX_ATOMIC_DW:
>   		switch (IMM) {
>   		case BPF_ADD:
>   			/* lock xadd *(u64 *)(dst_reg + off16) += src_reg */
>   			atomic64_add((u64) SRC, (atomic64_t *)(unsigned long)
>   				     (DST + insn->off));
> +			break;
> +		case BPF_ADD | BPF_FETCH:
> +			SRC = (u64) atomic64_fetch_add(
> +				(u64) SRC,
> +				(atomic64_t *)(s64) (DST + insn->off));
> +			break;
>   		default:
>   			goto default_label;
>   		}
> diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
> index 37c8d6e9b4cc..3ee2246a52ef 100644
> --- a/kernel/bpf/disasm.c
> +++ b/kernel/bpf/disasm.c
> @@ -160,6 +160,13 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
>   				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
>   				insn->dst_reg, insn->off,
>   				insn->src_reg);
> +		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
> +			   insn->imm == (BPF_ADD | BPF_FETCH)) {
> +			verbose(cbs->private_data, "(%02x) r%d = atomic%s_fetch_add(*(%s *)(r%d %+d), r%d)\n",

We should not do dereference here (withough first *), right? since the 
input is actually an address. something like below?
    r2 = atomic[64]_fetch_add((u64/u32 *)(r3 +40), r2)

> +				insn->code, insn->src_reg,
> +				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
> +				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
> +				insn->dst_reg, insn->off, insn->src_reg);
>   		} else {
>   			verbose(cbs->private_data, "BUG_%02x\n", insn->code);
>   		}
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e8b41ccdfb90..a68adbcee370 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3602,7 +3602,11 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
>   {
>   	int err;
>   
> -	if (insn->imm != BPF_ADD) {
> +	switch (insn->imm) {
> +	case BPF_ADD:
> +	case BPF_ADD | BPF_FETCH:
> +		break;
> +	default:
>   		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
>   		return -EINVAL;
>   	}
> @@ -3631,7 +3635,7 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
>   	    is_pkt_reg(env, insn->dst_reg) ||
>   	    is_flow_key_reg(env, insn->dst_reg) ||
>   	    is_sk_reg(env, insn->dst_reg)) {
> -		verbose(env, "atomic stores into R%d %s is not allowed\n",
> +		verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
>   			insn->dst_reg,
>   			reg_type_str[reg_state(env, insn->dst_reg)->type]);
>   		return -EACCES;
> @@ -3644,8 +3648,20 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
>   		return err;
>   
>   	/* check whether we can write into the same memory */
> -	return check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
> -				BPF_SIZE(insn->code), BPF_WRITE, -1, true);
> +	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
> +			       BPF_SIZE(insn->code), BPF_WRITE, -1, true);
> +	if (err)
> +		return err;
> +
> +	if (!(insn->imm & BPF_FETCH))
> +		return 0;
> +
> +	/* check and record load of old value into src reg  */
> +	err = check_reg_arg(env, insn->src_reg, DST_OP);
> +	if (err)
> +		return err;
> +
> +	return 0;
>   }
>   
>   static int __check_stack_boundary(struct bpf_verifier_env *env, u32 regno,
> @@ -9501,12 +9517,6 @@ static int do_check(struct bpf_verifier_env *env)
>   		} else if (class == BPF_STX) {
>   			enum bpf_reg_type *prev_dst_type, dst_reg_type;
>   
> -			if (((BPF_MODE(insn->code) != BPF_MEM &&
> -			      BPF_MODE(insn->code) != BPF_ATOMIC) || insn->imm != 0)) {
> -				verbose(env, "BPF_STX uses reserved fields\n");
> -				return -EINVAL;
> -			}
> -
>   			if (BPF_MODE(insn->code) == BPF_ATOMIC) {
>   				err = check_atomic(env, env->insn_idx, insn);
>   				if (err)
> @@ -9515,6 +9525,11 @@ static int do_check(struct bpf_verifier_env *env)
>   				continue;
>   			}
>   
> +			if (BPF_MODE(insn->code) != BPF_MEM || insn->imm != 0) {
> +				verbose(env, "BPF_STX uses reserved fields\n");
> +				return -EINVAL;
> +			}
> +
>   			/* check src1 operand */
>   			err = check_reg_arg(env, insn->src_reg, SRC_OP);
>   			if (err)
> diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
> index 95ff51d97f25..ac7701678e1a 100644
> --- a/tools/include/linux/filter.h
> +++ b/tools/include/linux/filter.h
> @@ -180,6 +180,16 @@
>   		.imm   = BPF_ADD })
>   #define BPF_STX_XADD BPF_ATOMIC_ADD /* alias */
>   
> +/* Atomic memory add with fetch, src_reg = atomic_fetch_add(*(dst_reg + off), src_reg); */

Maybe src_reg = atomic_fetch_add(dst_reg + off, src_reg)?

> +
> +#define BPF_ATOMIC_FETCH_ADD(SIZE, DST, SRC, OFF)		\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_ADD | BPF_FETCH })
> +
>   /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
>   
>   #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index d0adc48db43c..025e377e7229 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -44,6 +44,9 @@
>   #define BPF_CALL	0x80	/* function call */
>   #define BPF_EXIT	0x90	/* function return */
>   
> +/* atomic op type fields (stored in immediate) */
> +#define BPF_FETCH	0x01	/* fetch previous value into src reg */
> +
>   /* Register numbers */
>   enum {
>   	BPF_REG_0 = 0,
> 
