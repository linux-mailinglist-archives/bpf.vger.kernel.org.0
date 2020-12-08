Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A512D203E
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 02:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgLHBmN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 20:42:13 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19020 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726190AbgLHBmN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 7 Dec 2020 20:42:13 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B81ecm3001292;
        Mon, 7 Dec 2020 17:41:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=8+x+oAggFzUBluYOKKRRm+litent9Pw1KBZ76BNBQ6g=;
 b=qJ/VsHZDxVNMfxwARvu/uEj+Ej8AaTUGyT2w6FEK3yDH4Hsj1VzD9qimLARFgVgEeC6r
 6yq0pUxV4LUe3FTtYOGsBgMFJhtFxn++dNGspW1yUQD/AUt6CYWCaKOpIHiGsIWpkQHq
 W0bRt8/SsayCrzUErYGHJOLji8eUubgr+mk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3588ktwq7j-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Dec 2020 17:41:13 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 7 Dec 2020 17:41:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwfUvRZIKhA6ey8fTOAdOT+ItsxR0WeseNT1N1tEo/BE35MZO2ZD1e93YC/0bBS1DMlJ8zCZtKga+4vxN/IOEUjbDoplCs8EGaIpCvrASV72vMfTgFpVJ3IIvZWRH+VbqJvnMbKhM+rrGg1HGwSSkGPpzBHhDw1OaTFkQardZNcKuT7PBNWro0gxr7F2oxWHQ/c4EfEP5zQttZxqsR0feBfoKrG+gmLPpB9A3lPkFOAR9+n9Rg7pgNfSgQ+8hUGRm89wanZV1zWD3FjNhzKjIIseOnkz0j46kuICYCvWAxxm/EDVUm2xs3Ov9qZokQo1PREh8e5n7WFuPl9Kas33Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+x+oAggFzUBluYOKKRRm+litent9Pw1KBZ76BNBQ6g=;
 b=mkXXuB4+tHETTOVpaL7YRLSNBDCGcLRQx1MZfhkVC8AK8gIlBlDdm1fSD0M8psP4xdtTl8/21jfJsv+MMXkpU2JhrWzsAf2g7/LYCyHxWD7vw+Fr+wlK1dzkKf/4z3xpFsVDX3X+g6qUvB9iEBU+R0WVWgOOpYEUDQYrY6cynet8Njjpbc7Z6xUEJo8o6ZAxERw/qRMl75a/JlXh3PKtVERTswr6r/3wU0BIphuhqztEk0Z+04jOz3ljaaVxFCNiRq4SSlCt06a56OflaXBGFNgX1vIaE01QFP2M13I9PiHWe6pkIcAK5UeO8CILvQCNXVxpnOk47jY9xSz6F1HCqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+x+oAggFzUBluYOKKRRm+litent9Pw1KBZ76BNBQ6g=;
 b=O8VfsmWLBqtFiWFp9lgyzjc9a9uWW5a0NrztVv3pikzq2GBIYiO1YxUiwPGmlWnwa9bqjyhBHN46M9RuuXfaQustXhiMo0E0tyJvLnwCcj+x0nGcnIH/dhAdPOzSFFHmz9NXyFphh2sIFUwm7Zotfo5A0jqf61V1CMuCdUvLavs=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2646.namprd15.prod.outlook.com (2603:10b6:a03:155::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Tue, 8 Dec
 2020 01:41:07 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 01:41:07 +0000
Subject: Re: [PATCH bpf-next v4 06/11] bpf: Add BPF_FETCH field / create
 atomic_fetch_add instruction
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201207160734.2345502-1-jackmanb@google.com>
 <20201207160734.2345502-7-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <4163e34b-754a-5607-c28a-4c575a2cc6e5@fb.com>
Date:   Mon, 7 Dec 2020 17:41:05 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <20201207160734.2345502-7-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:ee04]
X-ClientProxiedBy: MW4PR04CA0335.namprd04.prod.outlook.com
 (2603:10b6:303:8a::10) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::113f] (2620:10d:c090:400::5:ee04) by MW4PR04CA0335.namprd04.prod.outlook.com (2603:10b6:303:8a::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21 via Frontend Transport; Tue, 8 Dec 2020 01:41:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bebde35b-4421-4a1e-eca3-08d89b1a5564
X-MS-TrafficTypeDiagnostic: BYAPR15MB2646:
X-Microsoft-Antispam-PRVS: <BYAPR15MB26468B6ABF867E4E169D6810D3CD0@BYAPR15MB2646.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bCJeayfaqIGa1vmMKwvubAr/jNoLn41AEM8onGLACc77JMC9tME1qEkWy0fromN3mKqbl6CxdR3AiRLcO9joEk6TdMOBfQ3mrb4TadJjZlyYti2zyYbMi2DS6sP8jF/XGT89+cWmLAUCj2Dnm8DbUDe1AwBcoImM+AiQC9SPnqCPIP9aYA26m/17MhnxotDltqju9+iT9Hmqqi91ZehsXzEjKf2AUQJ22ch30lhE/hkuZ9hBMj8Zcn3/3kFsA//xr/M0ZV/EhhFLtWJ5bkjgYbIT37e5Pxmi8W8o4NMa28WpdSd6oWNaeKNChqWdiQPjPhINKufDopi3gSXeNlcSJS7r9jYKEQ/GXh7z0qdYqzkzN31uDHH0q4vr0t8bwtm0Bl67/jWb5a14XMH8FmASGl0ZXNy3a6H1x/kcekuVnLY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(366004)(396003)(136003)(52116002)(66946007)(66476007)(8936002)(66556008)(5660300002)(2616005)(2906002)(8676002)(36756003)(53546011)(316002)(4326008)(186003)(86362001)(31696002)(6486002)(478600001)(16526019)(54906003)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bGJ2dGdsckVrVHZ4NnlieXcyc1NTSHNQUE5ueS9SQXo0YkN4eVY1QUt2UGIz?=
 =?utf-8?B?Ti9MM0VWNHFkZVJXd0EvQUJWWHpMWWlqRFBtOGZNbFEweE9TNHdvTlhSaWlV?=
 =?utf-8?B?a2E4TWYyczd3MVNrZHY1OGdxd3FLNS9hRFdocUF3dVN3QnFWdzhhVkJuVnl0?=
 =?utf-8?B?TWxLUkF2ZjNLc0o3d2Jna2lia1MySG1XZyt2bHJ3c01PaVZybDVWVlY3S2s0?=
 =?utf-8?B?UVd3WHlKbnBMRjJnTWNjSTVWR0VIZ3N0akVQK2hneHBmcTlmd24yWHVOTktY?=
 =?utf-8?B?RldRVk0yOEtqL040QklOa2cyR0lrTVd2KzZuZWhJYVozN0xqYXZ2b2RlaThT?=
 =?utf-8?B?dUYrZ3pTQ2x3VmloTmtFQVFzS0dFcHNrWnpSNUxXMzd1L09ET1o1cHd0R3E5?=
 =?utf-8?B?RzhPV3NSbmFXZDNNbGJBR2RiVU96Sm02dk55YUVKN0dYanplQy9qRGMrZWNw?=
 =?utf-8?B?ZS9GZ0QwV1d2K1Y0dXpsRDE4Q3F3YndDOFpoS2FNem4zN1NiODhoTDNkS3dr?=
 =?utf-8?B?SU5pT250ZUUydFgrRVNCU1hSQXZXcnc3WGRBUnQ3aGZDa0tLSW14WmliYzJX?=
 =?utf-8?B?dFJlbkxnTDBxYXJOaS92YVRXMTkwUFowc3l2cVJ5YnlBdlg1RHZ4SWFNNmxj?=
 =?utf-8?B?VkU1MFdKbitPNGFrSEI4dXpjVGk5QnljaTFrcmxLZm1EQmVjeGdERTIvNUk3?=
 =?utf-8?B?a2ZrN3ZqaFlFNlJnZ2NtMkYvYUNoVDd0Z2NjZlVXRmtjSm41SStMWkxpWUla?=
 =?utf-8?B?aVJqWm9OSTU2RHdNeGRneWtCcnpidDJSblRaSmhncEdFTFd1QmhFNS94RElM?=
 =?utf-8?B?U2paZDA2SGN4RzJtSTJ1L01zV3dwOGRkYm9pMUZWZ3lXemxUd1YrMEgrSnpw?=
 =?utf-8?B?ZnkrL1U4OVowL2NFS3lPZnRVWm9ibDVsMnpjOGs4djNQLzc1Q0FHd0xDN0Ix?=
 =?utf-8?B?VUl0OFg2UzdtMWhMa2I1OWhLK3hTUTZZb3RWekM1anR2WW9pUHpJVnBFVXpv?=
 =?utf-8?B?RXVLaXhOcDVCYkptakJnRXpubnpobXpzQkxIVFJuQTVXOVVXNm96WURXTVVk?=
 =?utf-8?B?YXhLdzhrS3ErUjBqai83M3NNMDJRUllCRWpaSDZsWVRHcFBUQlhpRVkrYWVB?=
 =?utf-8?B?bUlxRXhSemplNGw4cXN5NWdJUlEwNmsveDA5c3MvYUhDd1Izd3ZTN1VoR0gz?=
 =?utf-8?B?WUYzQ3FrRGxXb1pyN3JRNDI0NUVoZ3p2WnJld1I1TlVtUGZFckZiR1BIY2V0?=
 =?utf-8?B?OUdHRk5icnQ2djBTODhpOGVZR09OMU04dG5VSk9vaWNyZnJFVDZDSVlNcWVx?=
 =?utf-8?B?dW95WHhIWlRoRUVZdVZ6cmFjMG84bjlaM3NESytVa3JZVzZSQ2JSTWZiNThm?=
 =?utf-8?B?OUZPMm9OQmNRS2c9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 01:41:07.6258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: bebde35b-4421-4a1e-eca3-08d89b1a5564
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 673bicJAmkIDWVE0tMT//cj6rljghb4f5ijvuDcI49yzPhYUT61S43n/9jjzN5/V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2646
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-07_19:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080007
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/7/20 8:07 AM, Brendan Jackman wrote:
> The BPF_FETCH field can be set in bpf_insn.imm, for BPF_ATOMIC
> instructions, in order to have the previous value of the
> atomically-modified memory location loaded into the src register
> after an atomic op is carried out.
> 
> Suggested-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>   arch/x86/net/bpf_jit_comp.c    |  4 ++++
>   include/linux/filter.h         |  1 +
>   include/uapi/linux/bpf.h       |  3 +++
>   kernel/bpf/core.c              | 13 +++++++++++++
>   kernel/bpf/disasm.c            |  7 +++++++
>   kernel/bpf/verifier.c          | 33 ++++++++++++++++++++++++---------
>   tools/include/linux/filter.h   | 11 +++++++++++
>   tools/include/uapi/linux/bpf.h |  3 +++
>   8 files changed, 66 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
[...]

> index f345f12c1ff8..4e0100ba52c2 100644
> --- a/tools/include/linux/filter.h
> +++ b/tools/include/linux/filter.h
> @@ -173,6 +173,7 @@
>    * Atomic operations:
>    *
>    *   BPF_ADD                  *(uint *) (dst_reg + off16) += src_reg
> + *   BPF_ADD | BPF_FETCH      src_reg = atomic_fetch_add(dst_reg + off16, src_reg);
>    */
>   
>   #define BPF_ATOMIC64(OP, DST, SRC, OFF)				\
> @@ -201,6 +202,16 @@
>   		.off   = OFF,					\
>   		.imm   = BPF_ADD })
>   
> +/* Atomic memory add with fetch, src_reg = atomic_fetch_add(dst_reg + off, src_reg); */
> +
> +#define BPF_ATOMIC_FETCH_ADD(SIZE, DST, SRC, OFF)		\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_ADD | BPF_FETCH })

Not sure whether it is a good idea or not to fold this into BPF_ATOMIC 
macro. At least you can define BPF_ATOMIC macro and
#define BPF_ATOMIC_FETCH_ADD(SIZE, DST, SRC, OFF)		\
     BPF_ATOMIC(SIZE, DST, SRC, OFF, BPF_ADD | BPF_FETCH)

to avoid too many code duplications?

> +
>   /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
>   
>   #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 98161e2d389f..d5389119291e 100644
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
