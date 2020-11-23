Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D560B2C19A3
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 00:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgKWXzO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 18:55:14 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:17128 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727437AbgKWXzN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Nov 2020 18:55:13 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ANNspdJ014719;
        Mon, 23 Nov 2020 15:54:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=DQL9qE5kVIqNej2DRvGgQyIJkJ2fkqVEW6LsTT8onZo=;
 b=cFBXXC+anTFegMJP4MV1uWT9oE3/irArM9s6zHQnTw/6rCjZZ1G0JJP9/5npsZ2/dn8o
 zi/DKWNs2jc8Kre8KebknW1e/k1VsVFlaaA5OXHnqNd6dCy81l9MPH3Xpz6dqhxyPKZd
 MTTqkVeolWbGIo7S8NSFER1aJNJD/RIBeng= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34y19ssrh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 23 Nov 2020 15:54:50 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 23 Nov 2020 15:54:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+vAGiTgf8zEwV0mbOrqDTvDbL2xSM3gmMQ0xvDvvIBTi3TlXrnjk5GEcYiXqf57RIkh72GBcHUAn3XL71as20+zV12RrSnW5Br2cZhWuz+RoMHt9xNKZZs9TU3e9m0eyiWXNcWmTQtFPITClEkIn8z1r6PqdvILB20lDBtQDMv30QGTPl/Mv1/alW0GElWSOqx37FrDcmDBOrPF+qowhTjzxAebDr/HuO6B35ecGMWf7WywoycNcNGaU/QaZkf4y5+WQs6eu5sL35Qb4Vu3dWujzmg/vddGXsj4xqF2eRuvHtoinoYVu3rWC+OvaFfvciP1toYnYYvxhRnVo7NRDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQL9qE5kVIqNej2DRvGgQyIJkJ2fkqVEW6LsTT8onZo=;
 b=UdoUFzVFevRMTOjzhYPWFeUQ5U6/v/fp/Bs8U8pCcY7jXEh+Zsdod8M/U2SVO9Hug962LaBpaPTnpCqPpllih4KDix9y64vFcmesa7z6cSG1Y5UQQ6OpDMnVXY8w5l1eB642EL9GQr2uL44oL++h0I45ITo/P+eHSqDm3jXozIxXBPLpRBL61jmJEZa/68KO7gSbKj/HsuMnwhmVwEORp1ZbGPUj8gXtUeMVOfq9s1o6MmIkOGYV6AvRgLKIoOlXijJ1r5/xsbxBqd3aPu7baOA2lhy68U5If3vdU+Dm3RRoz58vTaaJCbalH5mSW0BqHOsCRLjNqnP280IQxhGLUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQL9qE5kVIqNej2DRvGgQyIJkJ2fkqVEW6LsTT8onZo=;
 b=adwHlKnhmjbDxCW5lwj7EQ9w2q+vMcutcB53jqS9l8j8CWIaU7Bpc5GyYN3F7QqzbGtgpyZRh75CvSNg2VFpkACkFo31CbqE6mlN/ahD372VNJ/gEMdHgrxtS6+ZJZ7/HIIFseMVlt4LrYkyvTBkEClrqrVnGq7/HVM8nyUiipA=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by SJ0PR15MB4235.namprd15.prod.outlook.com (2603:10b6:a03:2e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Mon, 23 Nov
 2020 23:54:40 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3589.029; Mon, 23 Nov 2020
 23:54:40 +0000
Subject: Re: [PATCH 3/7] bpf: Rename BPF_XADD and prepare to encode other
 atomics in .imm
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>
References: <20201123173202.1335708-1-jackmanb@google.com>
 <20201123173202.1335708-4-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <e7d336ab-524f-9d60-e9ec-8c8426cae0d7@fb.com>
Date:   Mon, 23 Nov 2020 15:54:38 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
In-Reply-To: <20201123173202.1335708-4-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:1b2e]
X-ClientProxiedBy: CO1PR15CA0059.namprd15.prod.outlook.com
 (2603:10b6:101:1f::27) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::1039] (2620:10d:c090:400::5:1b2e) by CO1PR15CA0059.namprd15.prod.outlook.com (2603:10b6:101:1f::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Mon, 23 Nov 2020 23:54:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3fc89f9-0f17-436f-f866-08d8900b2470
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4235:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4235971619533F0CABF58DE6D3FC0@SJ0PR15MB4235.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWRU4gdOMYm2eMlpri69ET8hiYUr4xDtCrsK41YAUtml9dazJyPZ/E7rpYVEBYjIEyC1GLCznrEHStOyNivc1XQ/pVCcgYwX2qK1tymSnEDAGuW8U1eyYM3tDScqffR6aH43+3uGTFDeD0fsKvhLC9AUkSW2WdXPHrECmj6fKiFHSF74PM22vHLsIacsj/t5beZdZ0JVi0de1/0vxseQQFnn/xBqjbcuPe4WOGS6YgyaSkhppV5A9FIHv7LR1FAHTOm+oeZHvP92rpI9Srrz3x9C2FNvCigwaDwgWedv1l4lO4v1O9xEScaei6hlX5Ge2b/iRPfIb7iXapzJ+RcDriSGNqeNeq/Aevf1UbuoFAaGLWY/hpn7h3dY/u38p1XZUuHsngzxBZQLc/IQnjh2DA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(39860400002)(366004)(396003)(53546011)(31696002)(478600001)(186003)(16526019)(8936002)(8676002)(2906002)(6486002)(5660300002)(66476007)(52116002)(66556008)(316002)(4326008)(54906003)(86362001)(36756003)(2616005)(31686004)(66946007)(83380400001)(142923001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Lx97dRs0iIq88G4cMEowVsrdSvcBBoyKiJ8CwRz0BpoKgZ193kAEo207+T59OSqsoDV4N6ZMTiIJr74jNI3DdM3wS+DB5CZb0h1IrfvwoxQBbTSebpH4Vj1UfEAGYRxwmd0q8y7mz09s3wsYsJaRf+cglazpSbcc1oQbxLMKcadHNCvQdtzm4XjW12+8vE0/q7pUA09W/nH4C7taiAshwMSxJ5SXAbhud6uw99UX6/GfxYJcxbDaHhzG7Esx1sTgXBB1wxAz63j+vP+4ZENXlmREH+p3wqjDkuKtPwoM7U+NXywBTngD93JTfShjG99jgCMskKOi/cn6Uiis5tyyMOETbWPQFUsqnDRP23ZbhQJ6D1KBk6hrcy6OA3xgn1Zvg3T3cqt530pCGeWPCg1c3zp1sHA17Ku+cKAPY2ZrGo13tu30yn1h5LLpOLgCbdltO8PmO3NDfwVd+CXXPpXLB678cIxKnPdeUNv76mbaFIZ5H0BZDZ3bCuLMQRq6t+/Ort91mZnWn2R5IxP3K+EhPD/lykBWzKq81O6BNwAKxb5lHdYGY2WzdQiQsP+8WTQBvKW2zBiuzGOmNIw4IhhQbHmppEUduyWmdfhzBV9av8gFqOmU5isQaW9yZJnGmpX0EblpPUjNnmlhPYUV9Ix0Vg18lD5c8NlT7mb/IRHgxZoxCfPUhypmlkwJQ/jgcC8KqZUJhLJhcl1VUwN7D8rVcFpOPRBW+qnFlPIkMU0cdD2Foaf7y5Pg5XNUfbWDXPkj1AzNhYivGfcY8ZvmmRvgQUG5VLMnFa/atdbprDYP5ykyKw8Yiw/EPZ6kKU2D2Q83zKZ55f2+IBrlshNh6yfsrzFe8r+bX4ee8KsUh3MnGEDOA0PKhJrISW707o2Ve+u9CyHQ3zPo1DJGtm3pfCLzQqI95ORb20h8XAizvQ/qbLk=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3fc89f9-0f17-436f-f866-08d8900b2470
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2020 23:54:40.7546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0gJR/qgcC8T8g/DehUt0vK1r6x3irNNypbd6QxK1LKK08Xu9OmgiZY2G3GTImE/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4235
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_19:2020-11-23,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011230154
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/23/20 9:31 AM, Brendan Jackman wrote:
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
>   Documentation/networking/filter.rst           | 27 +++++++++-------
>   arch/arm/net/bpf_jit_32.c                     |  7 ++---
>   arch/arm64/net/bpf_jit_comp.c                 | 16 +++++++---
>   arch/mips/net/ebpf_jit.c                      | 11 +++++--
>   arch/powerpc/net/bpf_jit_comp64.c             | 25 ++++++++++++---
>   arch/riscv/net/bpf_jit_comp32.c               | 20 +++++++++---
>   arch/riscv/net/bpf_jit_comp64.c               | 16 +++++++---
>   arch/s390/net/bpf_jit_comp.c                  | 26 +++++++++-------
>   arch/sparc/net/bpf_jit_comp_64.c              | 14 +++++++--
>   arch/x86/net/bpf_jit_comp.c                   | 30 +++++++++++-------
>   arch/x86/net/bpf_jit_comp32.c                 |  6 ++--
>   drivers/net/ethernet/netronome/nfp/bpf/jit.c  | 14 ++++++---
>   drivers/net/ethernet/netronome/nfp/bpf/main.h |  4 +--
>   .../net/ethernet/netronome/nfp/bpf/verifier.c | 13 +++++---
>   include/linux/filter.h                        |  8 +++--
>   include/uapi/linux/bpf.h                      |  3 +-
>   kernel/bpf/core.c                             | 31 +++++++++++++------
>   kernel/bpf/disasm.c                           |  6 ++--
>   kernel/bpf/verifier.c                         | 24 ++++++++------
>   lib/test_bpf.c                                |  2 +-
>   samples/bpf/bpf_insn.h                        |  4 +--
>   samples/bpf/sock_example.c                    |  3 +-
>   samples/bpf/test_cgrp2_attach.c               |  6 ++--
>   tools/include/linux/filter.h                  |  7 +++--
>   tools/include/uapi/linux/bpf.h                |  3 +-
>   .../bpf/prog_tests/cgroup_attach_multi.c      |  6 ++--
>   tools/testing/selftests/bpf/verifier/ctx.c    |  6 ++--
>   .../testing/selftests/bpf/verifier/leak_ptr.c |  4 +--
>   tools/testing/selftests/bpf/verifier/unpriv.c |  3 +-
>   tools/testing/selftests/bpf/verifier/xadd.c   |  2 +-
>   30 files changed, 230 insertions(+), 117 deletions(-)
> 
> diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
> index debb59e374de..a9847662bbab 100644
> --- a/Documentation/networking/filter.rst
> +++ b/Documentation/networking/filter.rst
> @@ -1006,13 +1006,13 @@ Size modifier is one of ...
>   
>   Mode modifier is one of::
>   
> -  BPF_IMM  0x00  /* used for 32-bit mov in classic BPF and 64-bit in eBPF */
> -  BPF_ABS  0x20
> -  BPF_IND  0x40
> -  BPF_MEM  0x60
> -  BPF_LEN  0x80  /* classic BPF only, reserved in eBPF */
> -  BPF_MSH  0xa0  /* classic BPF only, reserved in eBPF */
> -  BPF_XADD 0xc0  /* eBPF only, exclusive add */
> +  BPF_IMM     0x00  /* used for 32-bit mov in classic BPF and 64-bit in eBPF */
> +  BPF_ABS     0x20
> +  BPF_IND     0x40
> +  BPF_MEM     0x60
> +  BPF_LEN     0x80  /* classic BPF only, reserved in eBPF */
> +  BPF_MSH     0xa0  /* classic BPF only, reserved in eBPF */
> +  BPF_ATOMIC  0xc0  /* eBPF only, atomic operations */
>   
>   eBPF has two non-generic instructions: (BPF_ABS | <size> | BPF_LD) and
>   (BPF_IND | <size> | BPF_LD) which are used to access packet data.
> @@ -1044,11 +1044,16 @@ Unlike classic BPF instruction set, eBPF has generic load/store operations::
>       BPF_MEM | <size> | BPF_STX:  *(size *) (dst_reg + off) = src_reg
>       BPF_MEM | <size> | BPF_ST:   *(size *) (dst_reg + off) = imm32
>       BPF_MEM | <size> | BPF_LDX:  dst_reg = *(size *) (src_reg + off)
> -    BPF_XADD | BPF_W  | BPF_STX: lock xadd *(u32 *)(dst_reg + off16) += src_reg
> -    BPF_XADD | BPF_DW | BPF_STX: lock xadd *(u64 *)(dst_reg + off16) += src_reg
>   
> -Where size is one of: BPF_B or BPF_H or BPF_W or BPF_DW. Note that 1 and
> -2 byte atomic increments are not supported.
> +Where size is one of: BPF_B or BPF_H or BPF_W or BPF_DW.
> +
> +It also includes atomic operations, which use the immediate field for extra
> +encoding.
> +
> +   BPF_ADD, BPF_ATOMIC | BPF_W  | BPF_STX: lock xadd *(u32 *)(dst_reg + off16) += src_reg
> +   BPF_ADD, BPF_ATOMIC | BPF_DW | BPF_STX: lock xadd *(u64 *)(dst_reg + off16) += src_reg
> +
> +Note that 1 and 2 byte atomic operations are not supported.
>   
>   eBPF has one 16-byte instruction: BPF_LD | BPF_DW | BPF_IMM which consists
>   of two consecutive ``struct bpf_insn`` 8-byte blocks and interpreted as single
> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
> index 0207b6ea6e8a..897634d0a67c 100644
> --- a/arch/arm/net/bpf_jit_32.c
> +++ b/arch/arm/net/bpf_jit_32.c
> @@ -1620,10 +1620,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
>   		}
>   		emit_str_r(dst_lo, tmp2, off, ctx, BPF_SIZE(code));
>   		break;
> -	/* STX XADD: lock *(u32 *)(dst + off) += src */
> -	case BPF_STX | BPF_XADD | BPF_W:
> -	/* STX XADD: lock *(u64 *)(dst + off) += src */
> -	case BPF_STX | BPF_XADD | BPF_DW:
> +	/* Atomic ops */
> +	case BPF_STX | BPF_ATOMIC | BPF_W:
> +	case BPF_STX | BPF_ATOMIC | BPF_DW:
>   		goto notyet;
>   	/* STX: *(size *)(dst + off) = src */
>   	case BPF_STX | BPF_MEM | BPF_W:
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index ef9f1d5e989d..f7b194878a99 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -875,10 +875,18 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>   		}
>   		break;
>   
> -	/* STX XADD: lock *(u32 *)(dst + off) += src */
> -	case BPF_STX | BPF_XADD | BPF_W:
> -	/* STX XADD: lock *(u64 *)(dst + off) += src */
> -	case BPF_STX | BPF_XADD | BPF_DW:
> +	case BPF_STX | BPF_ATOMIC | BPF_W:
> +	case BPF_STX | BPF_ATOMIC | BPF_DW:
> +		if (insn->imm != BPF_ADD) {

Currently BPF_ADD (although it is 0) is encoded at bit 4-7 of imm.
Do you think we should encode it in 0-3 to make such a comparision
and subsequent insn->imm = BPF_ADD making more sense?


> +			pr_err_once("unknown atomic op code %02x\n", insn->imm);
> +			return -EINVAL;
> +		}
> +
> +		/* STX XADD: lock *(u32 *)(dst + off) += src
> +		 * and
> +		 * STX XADD: lock *(u64 *)(dst + off) += src
> +		 */
> +
>   		if (!off) {
>   			reg = dst;
>   		} else {
[...]
> diff --git a/drivers/net/ethernet/netronome/nfp/bpf/jit.c b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
> index 0a721f6e8676..0767d7b579e9 100644
> --- a/drivers/net/ethernet/netronome/nfp/bpf/jit.c
> +++ b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
> @@ -3109,13 +3109,19 @@ mem_xadd(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta, bool is64)
>   	return 0;
>   }
>   
> -static int mem_xadd4(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
> +static int mem_atm4(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
>   {
> +	if (meta->insn.off != BPF_ADD)
> +		return -EOPNOTSUPP;

meta->insn.imm?

> +
>   	return mem_xadd(nfp_prog, meta, false);
>   }
>   
> -static int mem_xadd8(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
> +static int mem_atm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
>   {
> +	if (meta->insn.off != BPF_ADD)

meta->insn.imm?

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
> +	[BPF_STX | BPF_ATOMIC | BPF_W] =	mem_atm4,
> +	[BPF_STX | BPF_ATOMIC | BPF_DW] =	mem_atm8,
>   	[BPF_ST | BPF_MEM | BPF_B] =	mem_st1,
>   	[BPF_ST | BPF_MEM | BPF_H] =	mem_st2,
>   	[BPF_ST | BPF_MEM | BPF_W] =	mem_st4,
[...]
