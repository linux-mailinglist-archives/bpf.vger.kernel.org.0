Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41412C6EDE
	for <lists+bpf@lfdr.de>; Sat, 28 Nov 2020 05:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732683AbgK1E6b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Nov 2020 23:58:31 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18400 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732634AbgK1E5o (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Nov 2020 23:57:44 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AS3eGNR005339;
        Fri, 27 Nov 2020 19:43:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=48IY9Oq799nSzapdGhUf4lLj7ufluZDoAjD5lj0Y/cg=;
 b=nUfBRVH9uEYrj+keQa3O/VWBuIQkWg63lIGpTd30cGhywqINgi1Yk4jsvZNh0zyE8Acc
 qpeSQi4cMCiX6//9pYLNOTl2vvKFYilDbA45uOQfd7d+IISD57mAel409sBN5S6O9Was
 TCx8hyFIMFN2VxFCGD7oZiVc7p4bAdqCfnU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 353dm105m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 27 Nov 2020 19:43:56 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 27 Nov 2020 19:43:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTwz8gK81+/vcrs7wedlc7QInbxtcPk7aAEXjFYo/JBI2ZIITPPCRaEFdGuAiWeEhSqBdF0l30CakqPoc5swPLUm1K91VoYuI1+iM5RC7lyDnNZ07NT6w8NJb9MrPr8w/vZ1x3vAQpRxKbdY+DOQDgm9BZ2gtGJD2P7c7BaPfyYRvgPR6sEGfLUSa9G+sMCUgsq1NfYHuj024TywmThdlvoEBMKfLUP0Qes5WSsk+wJnDlS1kylsxQs+bPEHGB4nCcXujhvNseqFt87Oy6LeFEsRXW5FE45DAlVqhq6QEdHYs9FSNcoAr0om+OmfAIc9WCEQHv+/MdSwBUxHVUD8sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48IY9Oq799nSzapdGhUf4lLj7ufluZDoAjD5lj0Y/cg=;
 b=FnNaIeFcWTFXCzOcpmgAQ3MPvQqOJ+sw9TanaT7vJORVvqWF3WZEuNMO68nhVX2HyjSfceEL+qIEneIGAj6VZIjlNXBniTK7TXjk+V99a65WCM7GtxGI0GZZHbijrm7NT7MrVAjoIsqOjBVdEv0hOEk0dwnECh/Li0MJZEZYGQeueE4E5gpkrMqbVSDF3A1LIcMlCQ652kdp3QBf9YxDH7HITwrDCfvRbupYqLjv01aOURjWrrFTqiod8F5xNqd2F6oXhCy7nBARsQWrp6HiY+wWRnkkXyzvjaOork4DjJ42AmPXbkar0KlRde0Fwp+qgyoJVJB4m56KbfYWv6Ek8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48IY9Oq799nSzapdGhUf4lLj7ufluZDoAjD5lj0Y/cg=;
 b=NwBMZ0XUqnbYsc9KZbPWRLtqQal2C0N7fT0NeAxb8NO8yXor6UwV59E+12Zxu2A6QXymZgCqFLlmEQMKGQWY4+/knnOLmDho0vaWZd2qnOpMyCgNGAKzAoZyJp0cmJNcHCYkIEZpM9feHuXO1YlVg8RdODj732EK4rZjAxIA6Pc=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2998.namprd15.prod.outlook.com (2603:10b6:a03:fc::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Sat, 28 Nov
 2020 03:43:50 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3611.025; Sat, 28 Nov 2020
 03:43:49 +0000
Subject: Re: [PATCH v2 bpf-next 05/13] bpf: Rename BPF_XADD and prepare to
 encode other atomics in .imm
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-6-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <bdc90ccd-e017-b7b1-7ba8-f5e261ad7296@fb.com>
Date:   Fri, 27 Nov 2020 19:43:46 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
In-Reply-To: <20201127175738.1085417-6-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:b678]
X-ClientProxiedBy: MWHPR20CA0027.namprd20.prod.outlook.com
 (2603:10b6:300:ed::13) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::102b] (2620:10d:c090:400::5:b678) by MWHPR20CA0027.namprd20.prod.outlook.com (2603:10b6:300:ed::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Sat, 28 Nov 2020 03:43:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7144aadd-5e74-4925-c918-08d8934fd102
X-MS-TrafficTypeDiagnostic: BYAPR15MB2998:
X-Microsoft-Antispam-PRVS: <BYAPR15MB299831D7F1E86F97634EEF14D3F70@BYAPR15MB2998.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 56iZuta2jLxymggfegHZSkHJruCXqyhLIEQMzvs41oa/EKvjkDlRafs1SRGACsBS7KcDdTYlzfy23Wog0eHHjX+AP9JyIAdim/4CyYqZElyca/2fH+q7NTfR/62vHavtWo9pybHKVXHnSDxnW7c5PKKwSS4sWo+N4Mfw9zzQLISSrPjKG4uVfyqJtFjqFL3Qj5/wNU6OHxpZzMOhxQr0LfdUt/ki+aLWpnlbbyGNEum3D8dDagOpyPlXqtkWLgpWj6ncVYY9eBZZShbgO8PXNQEsOtqeeO/Tm/y8NixqFlpaNdoUFuPPjKXeac0P7ZitaA8YwM35rM6clk92g5//U4do7mt+qL9eqO93ALEcoSmfqHV4soaPsKgrWOIezDZeiToR8o75TkURJN7MGXTXuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(136003)(376002)(366004)(2616005)(2906002)(36756003)(66556008)(66476007)(8676002)(316002)(54906003)(478600001)(186003)(83380400001)(66946007)(31696002)(86362001)(5660300002)(16526019)(52116002)(53546011)(8936002)(31686004)(4326008)(6486002)(142923001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SmN2Y3RJOFNVUVhicXJ6RlQ5akFpUEJJWkIvUGc5YTBsbEJ0S0tZTnpLQ3Yw?=
 =?utf-8?B?ejBXWGQ1OHBZNlFwamdnWjJPYk1zWXRtY1B1TUE1eCtSM3J3NjVqU2d0Wklp?=
 =?utf-8?B?cnNGU0RJcnZMdjNUUk1lMEVsM28yQ2tuSkxBUzRFUWoxK1BwTklmZitpWEdj?=
 =?utf-8?B?OHVPQUdlK0lYU1BIbGlIL29xcjdNMjAxMVUyYkREMHNYTFA2R2VvcjlNenRl?=
 =?utf-8?B?WjE0dkxtMy9SUmRHaG4rMzREeUdQV3BvWVppMjNqNTdSMmlVVE9iTWdpR1Jz?=
 =?utf-8?B?c2hsak1MamE4ZEVvU0RsOW9tczFGODhHK0Q3a3lBK1RkNGVtdXlER1A3UVFX?=
 =?utf-8?B?b0dpMnV6dHBmQUN6U1NSYkIzN1lhNjRTOUxFMEVmWkUySWJsdHFTOGVlcVJI?=
 =?utf-8?B?bTlwT1dVeG4xK09MQkpwcXBYY1hjcDgrZEhQTFZjL3RRSlBGWnJKeVNFanYy?=
 =?utf-8?B?aTJndC9HVkp2SW1PWHV6bHJNTzdKemxQRWl1SkZ4cjRxSzk2K2phOERYY25r?=
 =?utf-8?B?WkpNbFNGaUQ5dkFnT1ZSN0hMR2tiY1d4KzhGNncrQklLRE5nZ3hIUTUzVGty?=
 =?utf-8?B?QmcrZllabzlkSXVQUEhrNVBvS3RKVW9EMVBMZTJwbXVqSjZ6T1lQVGlLZE45?=
 =?utf-8?B?aUQ1Sk1oNlBCYWxYbzBNK09iNlUxNDJjUHg2NzNBRUNMNzBCSU1tVkZTakQx?=
 =?utf-8?B?MkFPMVF5Qlc4MmludHFNbFV3SHZiRTFKdzNUdnphVEo3TjE4eXlxUU9nRk1N?=
 =?utf-8?B?U2pVSklqOFVCTDdSeGczbXRsOHFsK3JYUlRwVEpEc1EyMENYdzc4Yk9uckxM?=
 =?utf-8?B?U01yZFFucWJ5UGUrZFBKMUltRUlMZEhveWJWdWxsRlFweHhJWVR1N2JDcStp?=
 =?utf-8?B?VTVXWlZUT1JsRUl3YzkxdE1rY2l2dDFFWkhSWjdBcDE5cCtZV2Z4SEd5ZFIz?=
 =?utf-8?B?b3h5WEVqc1hDdFIvY0pXcm5aUjJRckJCRHg4U1dxYUJGRnJaRzVsdkhqblU5?=
 =?utf-8?B?V3hqZkdYZ3ViRklRRDUxZWwwY0dZNkIwWVczcGdXSGRJYmxYOHIyQVBZRmRo?=
 =?utf-8?B?a3J3UEhNT1Y3N2t2ZUkzcTZ0K0htR1lDbm51MHhLWUFYcnpYR2xoTnd3d3dG?=
 =?utf-8?B?Rk9GR2NmamU3ekZ5Ui9kVngwdWZCMzVyNm5HeWR3WlVkcU56YkErUjVxdXpZ?=
 =?utf-8?B?SGdtR0hkbnQvcEtBN3ZOMTBuY0hQNzlWUmtNYnB0Zm1Tb2dKVkVtNXFTSzZJ?=
 =?utf-8?B?Rm8vOVJzVE9rb3J4anZIcDl2ZFVIbUNYZndpUWZRWngvV0s4YUFyQ0tnUEF4?=
 =?utf-8?B?d1FuT1gwM3pIRER6WWJvYTYwdDczTkdobTI0amVsenVKVTdwWTZMSkF2OFox?=
 =?utf-8?B?dGxpTXBnK3ZVaUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7144aadd-5e74-4925-c918-08d8934fd102
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2020 03:43:49.5243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaaRrgTLYdymPuGOfF6nJ7Ievv2ZaCEY5GSWR9yrcYAEF/oXeWU2QhsezifBzFyI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2998
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-28_02:2020-11-26,2020-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011280026
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/27/20 9:57 AM, Brendan Jackman wrote:
> A subsequent patch will add additional atomic operations. These new
> operations will use the same opcode field as the existing XADD, with
> the immediate discriminating different operations.
> 
> In preparation, rename the instruction mode BPF_ATOMIC and start
> calling the zero immediate BPF_ADD.
> 
> This is possible (doesn't break existing valid BPF progs) because the
> immediate field is currently reserved MBZ and BPF_ADD is zero.
> 
> All uses are removed from the tree but the BPF_XADD definition is
> kept around to avoid breaking builds for people including kernel
> headers.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>   Documentation/networking/filter.rst           | 30 +++++++-----
>   arch/arm/net/bpf_jit_32.c                     |  7 ++-
>   arch/arm64/net/bpf_jit_comp.c                 | 16 +++++--
>   arch/mips/net/ebpf_jit.c                      | 11 +++--
>   arch/powerpc/net/bpf_jit_comp64.c             | 25 ++++++++--
>   arch/riscv/net/bpf_jit_comp32.c               | 20 ++++++--
>   arch/riscv/net/bpf_jit_comp64.c               | 16 +++++--
>   arch/s390/net/bpf_jit_comp.c                  | 27 ++++++-----
>   arch/sparc/net/bpf_jit_comp_64.c              | 17 +++++--
>   arch/x86/net/bpf_jit_comp.c                   | 46 ++++++++++++++-----
>   arch/x86/net/bpf_jit_comp32.c                 |  6 +--
>   drivers/net/ethernet/netronome/nfp/bpf/jit.c  | 14 ++++--
>   drivers/net/ethernet/netronome/nfp/bpf/main.h |  4 +-
>   .../net/ethernet/netronome/nfp/bpf/verifier.c | 15 ++++--
>   include/linux/filter.h                        |  8 ++--
>   include/uapi/linux/bpf.h                      |  3 +-
>   kernel/bpf/core.c                             | 31 +++++++++----
>   kernel/bpf/disasm.c                           |  6 ++-
>   kernel/bpf/verifier.c                         | 24 ++++++----
>   lib/test_bpf.c                                |  2 +-
>   samples/bpf/bpf_insn.h                        |  4 +-
>   samples/bpf/sock_example.c                    |  2 +-
>   samples/bpf/test_cgrp2_attach.c               |  4 +-
>   tools/include/linux/filter.h                  |  7 +--
>   tools/include/uapi/linux/bpf.h                |  3 +-
>   .../bpf/prog_tests/cgroup_attach_multi.c      |  4 +-
>   tools/testing/selftests/bpf/verifier/ctx.c    |  7 ++-
>   .../testing/selftests/bpf/verifier/leak_ptr.c |  4 +-
>   tools/testing/selftests/bpf/verifier/unpriv.c |  3 +-
>   tools/testing/selftests/bpf/verifier/xadd.c   |  2 +-
>   30 files changed, 248 insertions(+), 120 deletions(-)
> 
> diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
[...]
> diff --git a/drivers/net/ethernet/netronome/nfp/bpf/jit.c b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
> index 0a721f6e8676..1c9efc74edfc 100644
> --- a/drivers/net/ethernet/netronome/nfp/bpf/jit.c
> +++ b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
> @@ -3109,13 +3109,19 @@ mem_xadd(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta, bool is64)
>   	return 0;
>   }
>   
> -static int mem_xadd4(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
> +static int mem_atomic4(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
>   {
> +	if (meta->insn.off != BPF_ADD)
> +		return -EOPNOTSUPP;

You probably missed this change. it should be meta->insn.imm != BPF_ADD.

> +
>   	return mem_xadd(nfp_prog, meta, false);
>   }
>   
> -static int mem_xadd8(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
> +static int mem_atomic8(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
>   {
> +	if (meta->insn.off != BPF_ADD)

same as above.

> +		return -EOPNOTSUPP;
> +
>   	return mem_xadd(nfp_prog, meta, true);
>   }
>   
> @@ -3475,8 +3481,8 @@ static const instr_cb_t instr_cb[256] = {
>   	[BPF_STX | BPF_MEM | BPF_H] =	mem_stx2,
>   	[BPF_STX | BPF_MEM | BPF_W] =	mem_stx4,
>   	[BPF_STX | BPF_MEM | BPF_DW] =	mem_stx8,
> -	[BPF_STX | BPF_XADD | BPF_W] =	mem_xadd4,
> -	[BPF_STX | BPF_XADD | BPF_DW] =	mem_xadd8,
> +	[BPF_STX | BPF_ATOMIC | BPF_W] =	mem_atomic4,
> +	[BPF_STX | BPF_ATOMIC | BPF_DW] =	mem_atomic8,
>   	[BPF_ST | BPF_MEM | BPF_B] =	mem_st1,
>   	[BPF_ST | BPF_MEM | BPF_H] =	mem_st2,
>   	[BPF_ST | BPF_MEM | BPF_W] =	mem_st4,
[...]
