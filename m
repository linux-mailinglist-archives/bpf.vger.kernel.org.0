Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B022C7271
	for <lists+bpf@lfdr.de>; Sat, 28 Nov 2020 23:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389829AbgK1VuI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Nov 2020 16:50:08 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57304 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726314AbgK1SUU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 28 Nov 2020 13:20:20 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AS5crdY013476;
        Fri, 27 Nov 2020 21:39:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=kI9U4sQ13PXtaHpNKI16fURLzpUfgjMR1GsiJ89irq4=;
 b=W8YtbkkMMWIOb/+RTJuxbbWCrbhMVXV5W38Bgt8YgOUNicISOqPg0OefSPa2ZbbAe4tc
 rzmWJTURxD4cL2apgwXGe1Zk71OU/Y1nLQPm2XGWBYK7+5A/PjKXbyf4EREcdWBC23N2
 //bAd4EMHRDrImas/c1fayBUfzqG3usRp8U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35397ah7ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 27 Nov 2020 21:39:14 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 27 Nov 2020 21:39:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvGyb10rl12aaiZ33lWO2RQ2DxVBkXtNg6Ukio/g+4zyiBVR77WjZZawcUWudXUXbiT61fyEvg1Rhabe3zAsNE/TzeYsk1azCNiBZe/QInZ+olB6N3m2jMzfuthHRGzO202/e5i+JwSExVhpU9OdZZj8zTP73/dIBGwca28gEPhIq5PXTkawilZ31+/5Co+c63iWTFQBUQiNCB0yfJq+AuM7uOGLBPBR1FhxnuwLfSDmpfs/z01Y+oGEqdXkpzlpXAbCyjngJFCRwYTb8UBS3pP3pDAu3ZpBifzL8yZWL8cLJrwF5LcYjmZ+CZZr+XORQRVnC6zquuEGOqchwtOruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kI9U4sQ13PXtaHpNKI16fURLzpUfgjMR1GsiJ89irq4=;
 b=e3aFoIHmGyBXxisjPns7VJaWNOS4d43m7d40ZGMynBHaykyfiIAebAwE06zYvCc82edV+IW9h9FGjwoIaQEdi9QbMHjYuqEKH5Xl/eV5f8kWxXDDQSGrx4NniAYWYMat/ckYiio1xQZmOW++3G2B+KQsxl3p7LZawNxn7mPfUgM9I/SIMJ3+dTsC8hLtXa4oj/wy1O1abWb9VUXOHFNAvarVgi2669HEetlEE1RfcGU6TJ5iTpU9VXzOXWZJ0kiZay5s7+H+MKxcrtyiIi9ul5nMy1sD/D3mVivtnf8yGRPy9OeEk6CofV8XrGvqjJUZXd4/53CvXi8WMUwh0sBaKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kI9U4sQ13PXtaHpNKI16fURLzpUfgjMR1GsiJ89irq4=;
 b=Axa28WgwTrm+vkd8/3qIS2b7dNgnAM2qdjzMNa9OsSERyyPKofvAdARoLd+RBg3c9w7R6k8BwSehdgYhdxkBo3aM1VUr0fnQnwEEMBRbIqGdi/7llEUawGUUtw1gdCC5ciR/MNgC4yvWpNQVg0o5Y+xhg09Ues6UUQ1939xzQ98=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2566.namprd15.prod.outlook.com (2603:10b6:a03:150::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Sat, 28 Nov
 2020 05:39:12 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3611.025; Sat, 28 Nov 2020
 05:39:12 +0000
Subject: Re: [PATCH v2 bpf-next 11/13] bpf: Add bitwise atomic instructions
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-12-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <d2e093c3-79bc-0a6b-8919-c5a07667926a@fb.com>
Date:   Fri, 27 Nov 2020 21:39:10 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
In-Reply-To: <20201127175738.1085417-12-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:fca2]
X-ClientProxiedBy: MW4PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:303:b6::16) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::102b] (2620:10d:c090:400::5:fca2) by MW4PR03CA0071.namprd03.prod.outlook.com (2603:10b6:303:b6::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22 via Frontend Transport; Sat, 28 Nov 2020 05:39:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e9a6bba-ea6c-489d-7f09-08d8935fefab
X-MS-TrafficTypeDiagnostic: BYAPR15MB2566:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2566080194FC06EF8E21FEFFD3F70@BYAPR15MB2566.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dD1jY4x2QgWaigGVJJ7lDX/g8Fdapcc9aRbV3O0QEukBtJymUC2tWQM5sAkZq9itK/6ZLoX0AlCRlK4idhvr+vOXEFkT3uoRrXzSg8lKQ1w2CFXDqVuBDcxwa4SXb8vNQG51WxUNLNq76pxuPt45DvtTzFuE7x8yxmim5xy8JTPiJibLl9Ooq/5uJ5MifrCjBYsIgQj4Y6eupiHrJC9vlvZ6v/XoSa1L+VFgN9Yct12VvHFWfoOKZF13/eBmVT4YuSoB9gBtIFYR3nsD6W1YXCCY2y9ZRnnaTBnyRLNN6btvJzkpfVbMhYQnhWuN8sDXToQ+j8nrRhMXnWDGc/oQ54BFvR5N3frdWLBx30qTFVrYpk4+iQvjL0+lepA06vtb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(366004)(346002)(39860400002)(52116002)(54906003)(86362001)(6486002)(5660300002)(83380400001)(316002)(66556008)(66476007)(66946007)(53546011)(4326008)(2906002)(8676002)(16526019)(31696002)(186003)(8936002)(36756003)(2616005)(31686004)(478600001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UExaZHNjQThCSDB4UjZPaWdyMHpRS1RLTHFYVkZyUWxPdjhJWjBMazZiQ1Fj?=
 =?utf-8?B?U1RhWTVGNFErYzh5ZUF1VlhYLzdEd0pHVTNaUjYyVUpBVjZ6eW94clN5aWpp?=
 =?utf-8?B?SWprOEFXMmxKdUZ2YVphbDMrQzhXMGROdHFiRm8xUE5LSzR0MENPUDZ1cHVj?=
 =?utf-8?B?YWkrdWw3dUdMdzdydW15eGRIL1BSWDdpSzZUUXo5MGt1K0FhVVdtc0ZqeDND?=
 =?utf-8?B?RnJnNjdFOWFmdEtHY2tkeWJxWVhiZEVNc0FJK1hYeEpQY2JHdWpPYy91ZzEx?=
 =?utf-8?B?WDg3ODJPbDJsL2RGdXBuVkJjZzRUcXVIUVVkN1lDN2R0ZkRrbTlzek9zcTVu?=
 =?utf-8?B?QVA2UjMwSXBJWlRaa2hSTEIvZ3hJN1c3WjY0ODgxVWJPb0t4aDNHaG04RXNq?=
 =?utf-8?B?S1VOZGcrbytLVXA5SzBDNlh2MVU1SzJsQW1oWU4xazFTSE1ES2J0NytOcUlM?=
 =?utf-8?B?cFRtMWJnSlRCTlFYWmp4WEg4TUlYeEVyY1Z2MjNuT281M2FEYkZtT1gxV1Bm?=
 =?utf-8?B?MnhqL3NjWFhZbFBXeVU5RVFTN0N0ZXNvTWcyMGVyemlnRU85Q2lZQ25pVU9x?=
 =?utf-8?B?N0ptNk9KWkJkOXN1Y3FaK1Y2NEdobTBzVnNzeEhFRU9VSHNIYUg4eXdLdmxH?=
 =?utf-8?B?amZqRStzMklVVTJRUFdHNHpuWFlyZmlNUnhUY2lqd21sd0U0eitpczJEZURp?=
 =?utf-8?B?NTRvZXZCR1pBdkd5QzgzQS9JeS9UVkpsVkwrSmZqUVYwN2pKVldaZnlLaGs5?=
 =?utf-8?B?V2RmSDhqNW9nTUlJbXFuaHQ3VE5BNHgxMWtpaGhHbXpSNjJybVFMZitOemZC?=
 =?utf-8?B?dWNEVXZYUHNvTUJzOWJqMTZWU0FZTmIwOGQzWVpZQm84UWVrWHB0Y1A2TXJk?=
 =?utf-8?B?ZmN2cDZWN29odEdGcmp2eElXbzg3ZUV6cFlHOXovdjg0WXUxRSsxYklsd0hL?=
 =?utf-8?B?TEJhckpZblk2UWRRRHdITVh1dDgxL3EvMEhzN2VPRzRVUEVUN3I4YTFtTnRJ?=
 =?utf-8?B?UUExTEJTd01lV1FlVGJkcUdKblgvbG5uNEduTnplREI0dnRiTWZsNlRqcFZM?=
 =?utf-8?B?aGVreDhkQnRzRzVWUWNPdXY3eFNSMDNZZG9rOVlrRTc3a29jK0JkNTZyRWt6?=
 =?utf-8?B?ZDNCTm42SjZ1c2dISCtlMGNDL3BQZnFyTVozMjNPMmVTVE85aW4vTy94N0VD?=
 =?utf-8?B?Uk5KVG13T0RpNDNoS2RBQi9DQlRIdWtlZ3ZPMkdJczNYSkRzTi8wUUVYd1Fh?=
 =?utf-8?B?dVFwSjlDY3RlaVYyaFdkWmZRdFRlNWExQUVMWEVxTXI4SGkwUzV3NllIVVBk?=
 =?utf-8?B?N21wUG5HeVVBOEMrNk9TZFEvbEJkWjBvSVVLSEVOVklmblRoZFFnamRvNVd1?=
 =?utf-8?B?bHBSZnp2bnhxdGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9a6bba-ea6c-489d-7f09-08d8935fefab
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2020 05:39:12.8073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8brLm1mlznMqsrFY0ctGx3+erXilzFim1+kSt7NVp3HFMusDt01sSrSihJ0OeGu/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2566
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-28_02:2020-11-26,2020-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxscore=0 impostorscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011280040
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/27/20 9:57 AM, Brendan Jackman wrote:
> This adds instructions for
> 
> atomic[64]_[fetch_]and
> atomic[64]_[fetch_]or
> atomic[64]_[fetch_]xor
> 
> All these operations are isomorphic enough to implement with the same
> verifier, interpreter, and x86 JIT code, hence being a single commit.
> 
> The main interesting thing here is that x86 doesn't directly support
> the fetch_ version these operations, so we need to generate a CMPXCHG
> loop in the JIT. This requires the use of two temporary registers,
> IIUC it's safe to use BPF_REG_AX and x86's AUX_REG for this purpose.

similar to previous xsub (atomic[64]_sub), should we implement
xand, xor, xxor in llvm?

> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>   arch/x86/net/bpf_jit_comp.c  | 49 ++++++++++++++++++++++++++++-
>   include/linux/filter.h       | 60 ++++++++++++++++++++++++++++++++++++
>   kernel/bpf/core.c            |  5 ++-
>   kernel/bpf/disasm.c          |  7 +++--
>   kernel/bpf/verifier.c        |  6 ++++
>   tools/include/linux/filter.h | 60 ++++++++++++++++++++++++++++++++++++
>   6 files changed, 183 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index a8a9fab13fcf..46b977ee21c4 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -823,8 +823,11 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
>   
>   	/* emit opcode */
>   	switch (atomic_op) {
> -	case BPF_SUB:
>   	case BPF_ADD:
> +	case BPF_SUB:
> +	case BPF_AND:
> +	case BPF_OR:
> +	case BPF_XOR:
>   		/* lock *(u32/u64*)(dst_reg + off) <op>= src_reg */
>   		EMIT1(simple_alu_opcodes[atomic_op]);
>   		break;
> @@ -1307,6 +1310,50 @@ st:			if (is_imm8(insn->off))
>   
>   		case BPF_STX | BPF_ATOMIC | BPF_W:
>   		case BPF_STX | BPF_ATOMIC | BPF_DW:
> +			if (insn->imm == (BPF_AND | BPF_FETCH) ||
> +			    insn->imm == (BPF_OR | BPF_FETCH) ||
> +			    insn->imm == (BPF_XOR | BPF_FETCH)) {
> +				u8 *branch_target;
> +				bool is64 = BPF_SIZE(insn->code) == BPF_DW;
> +
> +				/*
> +				 * Can't be implemented with a single x86 insn.
> +				 * Need to do a CMPXCHG loop.
> +				 */
> +
> +				/* Will need RAX as a CMPXCHG operand so save R0 */
> +				emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
> +				branch_target = prog;
> +				/* Load old value */
> +				emit_ldx(&prog, BPF_SIZE(insn->code),
> +					 BPF_REG_0, dst_reg, insn->off);
> +				/*
> +				 * Perform the (commutative) operation locally,
> +				 * put the result in the AUX_REG.
> +				 */
> +				emit_mov_reg(&prog, is64, AUX_REG, BPF_REG_0);
> +				maybe_emit_rex(&prog, AUX_REG, src_reg, is64);
> +				EMIT2(simple_alu_opcodes[BPF_OP(insn->imm)],
> +				      add_2reg(0xC0, AUX_REG, src_reg));
> +				/* Attempt to swap in new value */
> +				err = emit_atomic(&prog, BPF_CMPXCHG,
> +						  dst_reg, AUX_REG, insn->off,
> +						  BPF_SIZE(insn->code));
> +				if (WARN_ON(err))
> +					return err;
> +				/*
> +				 * ZF tells us whether we won the race. If it's
> +				 * cleared we need to try again.
> +				 */
> +				EMIT2(X86_JNE, -(prog - branch_target) - 2);
> +				/* Return the pre-modification value */
> +				emit_mov_reg(&prog, is64, src_reg, BPF_REG_0);
> +				/* Restore R0 after clobbering RAX */
> +				emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
> +				break;
> +
> +			}
> +
>   			if (insn->imm == (BPF_SUB | BPF_FETCH)) {
>   				/*
>   				 * x86 doesn't have an XSUB insn, so we negate
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index a20a3a536bf5..cb5d865cce3c 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -300,6 +300,66 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
>   		.off   = OFF,					\
>   		.imm   = BPF_SUB | BPF_FETCH })
>   
> +/* Atomic memory and, *(uint *)(dst_reg + off16) -= src_reg */
> +
> +#define BPF_ATOMIC_AND(SIZE, DST, SRC, OFF)			\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_AND })
> +
> +/* Atomic memory and with fetch, src_reg = atomic_fetch_and(*(dst_reg + off), src_reg); */
> +
> +#define BPF_ATOMIC_FETCH_AND(SIZE, DST, SRC, OFF)		\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_AND | BPF_FETCH })
> +
[...]
