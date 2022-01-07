Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA12487A27
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 17:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiAGQMS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 11:12:18 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22184 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231302AbiAGQMS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 7 Jan 2022 11:12:18 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 207CScpG017396;
        Fri, 7 Jan 2022 08:12:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=aVAYQddTx5VSqd9jqqu3k/IwVDG5GPDfQCk6u0OLH8s=;
 b=NXgGzaQlLXCAk6GHeM4aVyWTC7Se2qUMESEgRry36NJEJzQbM4icOde/bf5a3N8SoqzM
 iXXpAUacGHHiaf+T536BnL99ppxe88Gtiu6SKrt1KWWJfj8c23EdZWxWq2DM+4qQT80B
 abCo66tXUK+zkH/mGak8eSBUudXrbpiNS/w= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3denj31bsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 07 Jan 2022 08:11:59 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 08:11:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iq9TqXSkTRk3FnzCnodXF5jgiDsEtw5UlFj1pLys73Vm64mLcGhYcvvCB4gVZFyWa81zUvHUsXZmPYNIBX+qD1vup/+pMbO3fuOHavMLFeEXXPh7dhuAL64tArxpNpmdatZWSVGPB0AvF9bJ8v54cOXtUNhm+u7XwVXUB4YOG3aTeKaE++6KwUk7/iDOHC3Z03oDcdJPv/QfIHrfLvnfVPjzZlbEdVL6SguYuLp4IjZyltGZOv0ZpZIilD5sxJBWev4VAx48bK2jSbmfGBWzYesFehFDxocoWGfUXmw31iF1fzomNdWDlHdcb5DsV2RxBSYuNEtNL7LvKbEn5zAo1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVAYQddTx5VSqd9jqqu3k/IwVDG5GPDfQCk6u0OLH8s=;
 b=e2oWDoLz/NMHroufpAnhzIn9qeEHvsnmLm0Q+oqLmBjgCqQ2mc3LWSvl+fqv1wvjMPw9wDozgB38/BxUivVpBBYvmD33s/MP9nQUN/wSuNpf4h0F9P39xoiItgR1vEO6h8P7LlXgT34WutVxO8eVPhhhdRRRpAo7V5Tp4VQ4lgmxfu0pRYvBCtoCccymfqKgx0uu6Zh86xmdaMC+FXieS0PSUzSpoVTTgiaNHaAlqTMe6z0OOorhQwVLCm4X5L0L0Iry7iJ057UPu4VaCTtsM6P6hFED80kEtk2B4wqFS4+0sxh/6Wr/UiGSfeUrzIkBIyrPiIeSD6c1JaECuasXZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4919.namprd15.prod.outlook.com (2603:10b6:806:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Fri, 7 Jan
 2022 16:11:58 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ede3:677f:b85c:ac29]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ede3:677f:b85c:ac29%4]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 16:11:58 +0000
Message-ID: <32fc5f03-9249-f243-f6cf-9fbe8ccd5fee@fb.com>
Date:   Fri, 7 Jan 2022 08:11:55 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v2] libbpf: Fix the incorrect register read for syscalls
 on x86_64
Content-Language: en-US
To:     <Kenta.Tada@sony.com>, <andrii@kernel.org>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kafai@fb.com>,
        <songliubraving@fb.com>, <john.fastabend@gmail.com>,
        <kpsingh@kernel.org>
References: <TYCPR01MB593665A2C1E6C39169D10377F54D9@TYCPR01MB5936.jpnprd01.prod.outlook.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <TYCPR01MB593665A2C1E6C39169D10377F54D9@TYCPR01MB5936.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MW4PR04CA0367.namprd04.prod.outlook.com
 (2603:10b6:303:81::12) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c01bfccd-360f-4389-e2b3-08d9d1f86e57
X-MS-TrafficTypeDiagnostic: SA1PR15MB4919:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB49195D761609077B1C929006D34D9@SA1PR15MB4919.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vEwDbViOoT+LsSpX4I27K8PRjco4BT+GzVA8S/zkdpSGZbfRZv0h73e4KHezKMdrpulQOOMRqyR/zlT/OoyrhCgPipcwQXvrP2pMfHGJNkocNILsTNIWAVhAsYWOOrllu8667gUqEnFmh+O/imj7qBUA5Z6gsxkoFKrAa8JEQyJzs5oi3TSfWs3jJnihuuLX3PIM/ZAAdJ4WkbznkON91WFeM+4zLDXZkhjCI4IHgOiEV5RlumpXnAIaKuAvEKc+YPhd7uQN/KADLpHl3OJhDXo6L07sr2SKIdPmLgKriTGML1pv1uqes0OH8iUYejtmPmUsDNZfkVnjk5WuWTydJEqTkgCoZU7JX3402RRf8Zwbnq1rz3mtGjFQ4HsoP2GEOv67RX/IkayMe3DFr1bBveKQVNgp0hkT7SoT7LvR6/IER1aJXazjHP07l7NFx4t8Fr4UAWy6S0QhjqrdIPmDDu/UmnchsZpRLgt8LsWmV4GT+AWg+Mn6Ftm/rcpmscxyVGKMcexScu4hmf/IbF/GVH/YyViw7oMWuFAvGwwrXUn9BMbPQVHsnevF+5FpFZfsPJ0NvclHdL8bmZyS3QlCPIE8sBEqWrghiSm2vuL7+ExIjWwxxSlA0i8EvTL73SXRpU8IEZwPljEWVs11L9DbUF/FgF1ALBo+lOQGPQrQmw+BqLr6T8kGCXUEleukJDzJm1eWVJRZWcyH0PzyKOS+DURHIarBHPXAkRThF014SkMXXa4BDlLelfLuELCWkVhMGhVxStIaVWj9XeungOI4lIvuSFBr88yLccPaeJLOn9ZCUHSePD67Kq/Cji6lq5mG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(86362001)(6486002)(31696002)(83380400001)(8676002)(6512007)(31686004)(316002)(4326008)(66946007)(66476007)(2616005)(66556008)(38100700002)(6506007)(53546011)(966005)(5660300002)(52116002)(2906002)(6666004)(508600001)(8936002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2xYTTVvMzU3bm5yTFlhL3hUcUJ5VWxiUU41M1M2MGY5WHdTdS9iT1VRemx2?=
 =?utf-8?B?Vkp0OFFMVDViL2tXeE90TzVXMmo2M253S2pURUR0alNSUWp4bkhlL3p1WkZE?=
 =?utf-8?B?SjRYWlRuem1kUS82YWxSK3RWUFNJTFZ3YTNVa1crTlVTaTArbVNBQjRJZ0Na?=
 =?utf-8?B?dTJZMlZDS0hkeUFReHpwU2JBc3lBOUQram5tL1J2NS9YaHlKNC82YXpnbGJr?=
 =?utf-8?B?OU5QM2srNzNpTTBUalZ3S3laT3BxWkRKMXcyVG11dHB4L2xzaVNPeG5MRGN5?=
 =?utf-8?B?elRCaE9PMS9lRzBkcytBWlMxRm5vZ1A3NnNjdkhjZGc1ejltbm1GYytGMklM?=
 =?utf-8?B?aC9QY2plUHVpUHQweXB3blFSMENPV1lCZUx0M0RtUFlObUorV3I2ZG1qbk5o?=
 =?utf-8?B?ZmJnWXZVcmN2YUZ1dHpxSzlkaHJwNFlhOUtva2NYY3kyM0hObUN4UEJVc3dp?=
 =?utf-8?B?aFFER1Z2QytqRHFlN2R0TDk4SHRaK0pOejRmUW8zdlQzSXhNeWpYVUx6ZGJI?=
 =?utf-8?B?VjB6ajc4WllHNjNycDgyOWZxNURraUJUZ294U0tYSnpoaEtyY1VSSi9VUlp5?=
 =?utf-8?B?ckJ4dkw1NjJCVm5hMmV2UjVxc3MwK3NaTlMyWWFWMFFyTmx0U3p4WTNoazZT?=
 =?utf-8?B?TXBSS0VXT3NOenpjK2JTejU1dUJMK1c5MTNoY3A0WmRmak9DSFVZcFJ0MmlL?=
 =?utf-8?B?dHlWeks4MmhQN1pUdEVFdzRVTzk2WkpUVWxsWFA5M0l6OXF4M3BzTFZ4aWVR?=
 =?utf-8?B?aEN0RXg4NlQ3MDM2U0MrdEJoY0J4UGdsbFJhUU1rRkF0dGk1OUFtYUF2ZjFF?=
 =?utf-8?B?aWtha2hVME9hamRqRlRVRDZOZTViUVNKdHRFOXNhSnY0RFozUUovbTVwU0lL?=
 =?utf-8?B?dnlPYndiNWhJVmNKY0ZVeE50QllpSnBPdkkrZU5LTjNnMWRlSWE1NzhaMUhn?=
 =?utf-8?B?OEdQRGVLcHZDenBNZ1hTdXltY0pucTVVUnFjcG85N3VpUVpzUUIyY2lkMjdh?=
 =?utf-8?B?RnFoNjZ5MmJxYzB0WlJabDB3SGttSlZMVWNxcXpFdVVMb1ROQ0tBdDRRY29p?=
 =?utf-8?B?a3pqMXZYckVUdEpRbGxTNHlvamFRRmxZQy93a0MvWFRRMmlNQk42QWVQQkxW?=
 =?utf-8?B?eUp6RGMyT0tWRXVvdWtDMVlvdFhKU0FndVdqNE9CRGR3NVg3Q1F2ZVFCN1k3?=
 =?utf-8?B?NXZ4d2wzMnNoYnBLeHJIR1k5R2FYaDZTK0RnZ3VGQ2gvUjgveFByOUVZclNu?=
 =?utf-8?B?Qk81T3p1Y2w3YVhGMkRXdFBUR0RRU2Y0WUZSWVZiYUdRUHJOVDhzK2txSnNC?=
 =?utf-8?B?Vkc5enVhQ295YU5VSDJZYkF6US8reE5DMnU2SE93THpvVFFIcEJzbE1SNXpU?=
 =?utf-8?B?bldzdVRRajZBeXlCUDFCY2tEVGJENGloL2tiRWNtMTlGaFRoMEhXS3Mwclhi?=
 =?utf-8?B?TTkyZWs1eTVHZ3BkZzBZME1LdVlxL1AxZHlURktaRWFuaHJ3amRWY2o3REUr?=
 =?utf-8?B?b3dVandLSlpHZnJRY3NYUkFNUlhiU1FEcnRjM05Jd25sbnIzT3JFZm9YMHpV?=
 =?utf-8?B?YWVsVFllZFJidzI1ZldPcDVnaTN3SGhEV2R6VXJ6SHVDbjFveWE5S0VzRzho?=
 =?utf-8?B?VEN6YXFTVmxwbXVTRWFRM25CWjFZUGk2SWllTSt5RHZEcVM1d2JSSDkwekI3?=
 =?utf-8?B?azExekRVb00wTjNEMXBiZjdTWVBBODdzZ2gxYzBEc0dQNVdkRUVnV085YWpw?=
 =?utf-8?B?MnZKaVNFNFc0SDVVYjVYTkFHWlNTNmMvVmp0NnV0US9WTTlaRVdSK0NIOUpv?=
 =?utf-8?B?K3FsU0RraldxcTVUeXpPcnNzNkZzb2twRnoxU21HRXkxTXpMbW5zTUZIYnhw?=
 =?utf-8?B?OXh4dGMvR2hGZnRJTVJHZ3FsSFlQMFExQVJTQlJaaWNiclB6bnBkdVBDeXpV?=
 =?utf-8?B?YTZiUjd0cE9uMk8zL2xHRzI3eE13UFBiZlJrcFV5RkNNekFNdnc3SWlwSVJO?=
 =?utf-8?B?RXNCMFo2eDRkeThjNllkYWx6YVJXR0h1bzFFSXlYWGdHR21oUzFWSjR3Z0Qy?=
 =?utf-8?B?bnNSeWpxZGI2dnFBaW83bndlaXFUdmh3V1llblpjZzV4U0R1QTZ3U3RnY0xt?=
 =?utf-8?Q?1ywN0rnRgaxT5MbsSDIhWTXyv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c01bfccd-360f-4389-e2b3-08d9d1f86e57
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 16:11:58.4546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uBfLIACvmWBbwl3tt7f055Ea11WcX29QZdW9BFOcGjBRcvD1F9ZGy07zgxB844G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4919
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: atVctygtBkW2T2aft6GWSKwYKMHej1Gx
X-Proofpoint-ORIG-GUID: atVctygtBkW2T2aft6GWSKwYKMHej1Gx
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-07_06,2022-01-07_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201070110
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/6/22 6:38 PM, Kenta.Tada@sony.com wrote:
> Currently, rcx is read as the fourth parameter of syscall on x86_64.
> But x86_64 Linux System Call convention uses r10 actually.
> This commit adds the wrapper for users who want to access to
> syscall params to analyze the user space.
> 
> Changelog:
> ----------
> v1 -> v2:
> - Rebase to current bpf-next
> https://lore.kernel.org/bpf/20211222213924.1869758-1-andrii@kernel.org/
> 
> Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
> ---
>   tools/lib/bpf/bpf_tracing.h | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index 90f56b0f585f..4c3df8c122a4 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -70,6 +70,7 @@
>   #define __PT_PARM2_REG si
>   #define __PT_PARM3_REG dx
>   #define __PT_PARM4_REG cx
> +#define __PT_PARM4_REG_SYSCALL r10 /* syscall uses r10 */
>   #define __PT_PARM5_REG r8
>   #define __PT_RET_REG sp
>   #define __PT_FP_REG bp
> @@ -99,6 +100,7 @@
>   #define __PT_PARM2_REG rsi
>   #define __PT_PARM3_REG rdx
>   #define __PT_PARM4_REG rcx
> +#define __PT_PARM4_REG_SYSCALL r10 /* syscall uses r10 */
>   #define __PT_PARM5_REG r8
>   #define __PT_RET_REG rsp
>   #define __PT_FP_REG rbp
> @@ -226,6 +228,7 @@ struct pt_regs;
>   #define PT_REGS_PARM2(x) (__PT_REGS_CAST(x)->__PT_PARM2_REG)
>   #define PT_REGS_PARM3(x) (__PT_REGS_CAST(x)->__PT_PARM3_REG)
>   #define PT_REGS_PARM4(x) (__PT_REGS_CAST(x)->__PT_PARM4_REG)
> +#define PT_REGS_PARM4_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM4_REG_SYSCALL)
>   #define PT_REGS_PARM5(x) (__PT_REGS_CAST(x)->__PT_PARM5_REG)
>   #define PT_REGS_RET(x) (__PT_REGS_CAST(x)->__PT_RET_REG)
>   #define PT_REGS_FP(x) (__PT_REGS_CAST(x)->__PT_FP_REG)
> @@ -237,6 +240,7 @@ struct pt_regs;
>   #define PT_REGS_PARM2_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM2_REG)
>   #define PT_REGS_PARM3_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM3_REG)
>   #define PT_REGS_PARM4_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM4_REG)
> +#define PT_REGS_PARM4_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM4_REG_SYSCALL)
>   #define PT_REGS_PARM5_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM5_REG)
>   #define PT_REGS_RET_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_RET_REG)
>   #define PT_REGS_FP_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_FP_REG)
> @@ -292,6 +296,22 @@ struct pt_regs;
>   
>   #endif /* defined(bpf_target_defined) */
>   
> +#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
> +#define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
> +#define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
> +#ifndef PT_REGS_PARM4_SYSCALL
> +#define PT_REGS_PARM4_SYSCALL(x) PT_REGS_PARM4(x)
> +#endif
> +#define PT_REGS_PARM5_SYSCALL(x) PT_REGS_PARM5(x)
> +
> +#define PT_REGS_PARM1_CORE_SYSCALL(x) PT_REGS_PARM1_CORE(x)
> +#define PT_REGS_PARM2_CORE_SYSCALL(x) PT_REGS_PARM2_CORE(x)
> +#define PT_REGS_PARM3_CORE_SYSCALL(x) PT_REGS_PARM3_CORE(x)
> +#ifndef PT_REGS_PARM4_CORE_SYSCALL
> +#define PT_REGS_PARM4_CORE_SYSCALL(x) PT_REGS_PARM4_CORE(x)
> +#endif
> +#define PT_REGS_PARM5_CORE_SYSCALL(x) PT_REGS_PARM5_CORE(x)

Since you proposed the patch, you probably hit the issue. Please
add a selftest so the macro esp. PT_REGS_PARM4_SYSCALL or
PT_REGS_PARM4_CORE_SYSCALL is exercised. Thanks.

> +
>   #ifndef ___bpf_concat
>   #define ___bpf_concat(a, b) a ## b
>   #endif
