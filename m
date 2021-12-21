Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCA147C35D
	for <lists+bpf@lfdr.de>; Tue, 21 Dec 2021 16:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhLUPvM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Dec 2021 10:51:12 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51128 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229449AbhLUPvM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Dec 2021 10:51:12 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BLAvBpC031185;
        Tue, 21 Dec 2021 07:50:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=srccA96trknGFW+zjeSX+HXvylGIuiNOLKTyt+qUW+w=;
 b=IX8UXhTiNPmF4uung/eGikoGzAq78qa653JkYR2KYm+Y022JY3zQj9sQGBw7YOLVQd5k
 V9Co4yZVOPktv3hPbKWqFS6MRrfbPFMCJmVQRgwr3qVGJZE2SnaHpu1/uMVJMoNVsDoj
 RrCwon0wjf+2LFIcf6n3xy9ssmXnKQgQFuo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d3dm820ft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Dec 2021 07:50:56 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 07:50:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgFGj0f4JtRT1N5s8d6Waf8oP86ab9KcIDJmR6IjI2FCnuDB1IZBL/hJz8stGYKpnOuZRL6Nof9MhNE5zGPKVC9qy4K3uPCXuUBWDijfYqqhC2kdhAmPuCcYCNQpurUXXJozotuMWaq01APlXUFKWpFh1/9i1i+F8HV7xVQrHOiyg7f4jNCuT1yC7gAkliniKIM/MovHWUEWb/WdlPLCiac9X1T9JW4N41q0AUmwxI2I/nFC0KI/JvKItS5IWf44TtOy4cq2e8NEx7uGXrtz1o0D6UzP7Z9pIMGLsf+q30Z6Ahq+CAh6eZjZLQBlo4z+hAuZOtSIJC2wCQdEtgKf1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srccA96trknGFW+zjeSX+HXvylGIuiNOLKTyt+qUW+w=;
 b=OmP+2EpNWbBbLk8FojUA+4ONbRVZmvRYgZKl/5VWK3KVHmgTeH7eIeZ/i9KmTY1EnOsYjvta46CM8Bsut6824FwHoRjFjdDqxpr+XN1iWHM+VBvhV3+DP8cBD3/nsv8g5Bae3Qp/rAo7jfZY9I2YrYIL/QPSxZY3ilJRPFQ6GXw5VdYCQn1Pgkgr/hQqAMR/asUDS5UFD3Pz/jiijHfM6bJHOkpkT4ZrwRoRLDj1pMwqn0ch3w0xLXyoxHB7wfkCxsFWAWZhVw7sy/dUUKVCMUzjx13yNTlSOoSXcHYATPynAR5BhL4DGDnnQNTvqn7sGNSr8GTzoYzR+A0Tbrj3wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB5031.namprd15.prod.outlook.com (2603:10b6:806:1da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Tue, 21 Dec
 2021 15:50:53 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26%5]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 15:50:53 +0000
Message-ID: <0d380bb2-13df-d934-a873-f2f10279dbb2@fb.com>
Date:   Tue, 21 Dec 2021 07:50:50 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH] libbpf: Fix the incorrect register read for syscalls on
 x86_64
Content-Language: en-US
To:     <Kenta.Tada@sony.com>, <andrii@kernel.org>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kafai@fb.com>,
        <songliubraving@fb.com>, <john.fastabend@gmail.com>,
        <kpsingh@kernel.org>
References: <TYCPR01MB59360988D96E23FBA97DAE0AF57C9@TYCPR01MB5936.jpnprd01.prod.outlook.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <TYCPR01MB59360988D96E23FBA97DAE0AF57C9@TYCPR01MB5936.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MW4PR04CA0152.namprd04.prod.outlook.com
 (2603:10b6:303:85::7) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ad764ad-385e-4d45-287f-08d9c499ab4f
X-MS-TrafficTypeDiagnostic: SA1PR15MB5031:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB50314617A99E068CD958BB8BD37C9@SA1PR15MB5031.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pHaq9mwWuSiNpAUAeCx7+0R/XmfY2seDBjEsnZF62tCJwJrqiCfesrDCkP7brc4yDwPRF72CzM7AezP04zFYkanbBfTaZ4ZBLEhDI55E04PuJZxmqwKS8jYxr86HO0deqJcX5Sy5ofFJCPYrg1hIploUHIbnJ9G3K6tBfxaoIO3obG3i9BHa6EcuTe0V2jVb5LNkX/OHp8Ghl3JPYgjZpgDZixbxnOBnBlTeIdk0kJALpNMfLdSrV89mAy0cOX7ubpYsETPI6az+WEqPSvEbYSWu4l3e1J40HUmgW/UKkEo6gDytghJ+0XVX3PuoTFcIrZWKBssMmMjUP6Y0rbKhU67Ze7IdFizPTFCkW5LbLgh6MAT6aPMvVNk0YUEygOAC7qNAxiXz7+YTzPA7JnEIPizJJzIkfl/FAyXyThX1iLTxonRISR2TdB8ODCEo8Dqfei59g49iOpY63a+ztRzyElWNKVk96qepv5VmZs+zunKfZ6NV8l8b98z4aCONEHLgO0nqffNz1u1xX+l6pmph8diihVW+2lAGJeJZNGPwVjXYwgpVyjfd6teaKfyBfGvLsX6UIL9PQeQMUeU0N2G30SHzNIik25Xpm1qWS8uQlC8sB4zVVgiw6o5DNUu9h6dFnB2vO5agdewwa9y49aeReuQdWzvZUTSrIXJ5RkpF4BiwauR/yF9zjqs+3/ASI+RSRwad3/QcqEAizmUEZvXJGSAdgwoxvbUfnz5bgZaPoIZzLwFFbIbeidCpZOLaWoiwKz06zYCOj1F/TttdUDH+9GuEMtsMYlen88njZYc05Eas5mgTBHvc2KWZS/X8Se4H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(6512007)(66556008)(5660300002)(52116002)(31696002)(66476007)(83380400001)(966005)(38100700002)(4326008)(2616005)(6486002)(2906002)(53546011)(31686004)(8676002)(6506007)(316002)(186003)(36756003)(8936002)(86362001)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlNtK09tajl5YVhMUllrbTR2cEE5VGRsWHVFa0N5Ym1xUm9hdEVLWTJsVjRa?=
 =?utf-8?B?UCthcFBWcWxRa3JBTlN1ZzJqM0h3bWI2ck5taEdXc25DcmlBcnVsbG8rUTl3?=
 =?utf-8?B?K2VBSjJpWHI4bmRXMnRSdzM3T01EWnN4Tk9aSmFsUmp0Q1Q2VjA4T2dVVkRy?=
 =?utf-8?B?MEVxVUFnN0FTb1dhalpCNXl2TmFjZmdRYXBwNmtkczF6YThzU3g2MGhualpS?=
 =?utf-8?B?MTg1YnU3N3BjMEhlOW5sZTQ5SmJ5ZXJCSFpSVVBjNWxJTUlVZ3VCcHZ2VlJP?=
 =?utf-8?B?cFhLeHZ6ekl5M1BzWXVIQU1kZUFXMVBDWU1IbzVxS1p4RWVvWXA0dU5jODF3?=
 =?utf-8?B?dXd2SVVtR2Qwcmw2eDNCK280YWNNcUl5MmVvNU91Y0U5NW9MSUpFaGhHb2p6?=
 =?utf-8?B?TE1zNjlETDJTWDhscVJCYy85SXRVakJEZXo5NDNOcXA3blE1bXlrSjFwVHN2?=
 =?utf-8?B?Sk1ad2JyU09iYUtGbFgzTmp4WHdPY3pVbmIveXp0WmNTUzMzT0FDMm11ZCtK?=
 =?utf-8?B?b1BHKzZ4eEtXdXp1WVBRQzBTcUo5YitYTFlIdmFCc2w1S3kvemp5SGdFc1J2?=
 =?utf-8?B?aExJNU9Jbnk5TGhwWTdBVXJSTFQ2MS85SEw0aVJjdG1DZXptWmhNYngySW1L?=
 =?utf-8?B?UDVuWmNuRjMrUFRsR2FTUjI2VEVWK0FTSDU2L285SkVoejUzL2xCcFRibGZp?=
 =?utf-8?B?VnRDSndka2pieENFRzVrbmxOeFluZ3JxR0FVOXVVOVhyMnd6QkhnRTZJSnhm?=
 =?utf-8?B?MDltOGcxVFdvZHllcXlsWFJvTUlicnN1L2tBQWdzUk04WlVkZjJnV3dIS1Rm?=
 =?utf-8?B?MjB1dTJjYUVRbVJxczVTQ2hsQkFTdmpTbit6RlJ6cXY5V24rUWVpTVJQQ3Fy?=
 =?utf-8?B?Q2VQMlpwaURuVk5SMytramxDcUREOFdzZTR4Q1VIdVVCV2NQc0l5eGRYOVM2?=
 =?utf-8?B?emRIbzRQZkVGT2Y3YjNQbFVBaCtuWE93TEpYQ01PR2g2SXZZTG9OMThZbVBI?=
 =?utf-8?B?bVVzSjFyTUtGSWFVMWxoSnVva0g4R1dqK09WNWthcWJEQXNGQVBtc2h6SlJC?=
 =?utf-8?B?c0dzSG1LdFhaNWxwRzNXRUtSL0JmZ3lHc2hzUlFRR1NYT2xneE90a1BvNm9s?=
 =?utf-8?B?TkhaWVloTG9xcnF5QTF5U1VxZWVmTHRpNWJNM0NPaWtNZzlIOEluVDhrR2w3?=
 =?utf-8?B?L2g3SnNyRWsrL1NMT1FTYXRMTmo0RWd2aFdhaFlSRDhPYnBycjhvaFgwRkJR?=
 =?utf-8?B?cTVBMEJzcm13dmtvQ2JISGIzbWIyRVJmZHZTQ2pEaWdOcmt1SzF5TjNsbEhr?=
 =?utf-8?B?N2ZNcmVTOHdEZlJIOSs1T1ZVd2RqaHJFejV5NGJ6ZWFMdTdWOUJhQzc3a2I0?=
 =?utf-8?B?WmhRbFJiTnp1d0Y3NE5abW1NYjlqUFlPN2wxNjczZ0FyT3NDbnFIY09oR1RR?=
 =?utf-8?B?WndIRnN6aXVqREtzRGU2Nnp1TnEybjdzbW1QSmUyeW5MK0dmMGpDdjF2RnVs?=
 =?utf-8?B?czJQNk9USG1pUG5idUFEQVVpSkNQRTFGSnFuWnRuOHhRa0tTK3g1d0N4YjJR?=
 =?utf-8?B?NzQzY1Z2cHhVdVF6SXFIaUphajIvUDlBOHVZakh6VGd2S2xHTGdxOUV3RTF6?=
 =?utf-8?B?RDd4akJpanBlWERGZ093eFl6ZklENVZnbDZZMDZOdko3NG5FQURzMnNVdkIw?=
 =?utf-8?B?VFRBVDFrOHFibldTSzRmU2FNWFlORXlXNXdsc3dwTGtObFRadFAzSG9OSlhp?=
 =?utf-8?B?VkR6a21aQjFqR1ZqbWk0dVR5Zm1MT05nU3BZYnUva0xmbGI1RHVybTAybWNx?=
 =?utf-8?B?TXVXSStCWmE2MVUrYlhkbzdMZ3g5NXJSbUhvK0JhVXJHc2YrWU1MSytjM25l?=
 =?utf-8?B?Y3pIT1lBZmNVSEVFMzBBZWl1Smd4UXNVclQ2VG9CN0xzTzVNeWhiRDFYelhG?=
 =?utf-8?B?MFJ4elQ3eWxjcG1PSXRqcXIrY2psbFZLV0ZaRHJrSTNPbHpHdHJSZ1hxR1hC?=
 =?utf-8?B?UmU1WUc1UHFoR2FCQ0MxSXVCOUp0WDhicm5naUdHVlE5ZkR3cDEwVDBoSm9X?=
 =?utf-8?B?bEh4dEthUzIveElTZ3RPckNkK0VCdjlGejQyWFFDWHVyZWtvT0pPS2Exa1hs?=
 =?utf-8?Q?TUghzAXGjBel+tMQskm3L5GBk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad764ad-385e-4d45-287f-08d9c499ab4f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 15:50:53.4330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3N/CVH7o3GGJrv6dO54cFa03PZMhrVS8D89JsdHEmRQPhLv3hlLCK6QhvlfDzNa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5031
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: WwVCmfNr27GhSrmQ-u4coPapBoR2BAJG
X-Proofpoint-ORIG-GUID: WwVCmfNr27GhSrmQ-u4coPapBoR2BAJG
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-21_04,2021-12-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxlogscore=963
 suspectscore=0 malwarescore=0 clxscore=1011 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210076
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/21/21 3:21 AM, Kenta.Tada@sony.com wrote:
> Currently, rcx is read as the fourth parameter of syscall on x86_64.
> But x86_64 Linux System Call convention uses r10 actually.
> This commit adds the wrapper for users who want to access to
> syscall params to analyze the user space.
> 
> Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
> ---
>   tools/lib/bpf/bpf_tracing.h | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index db05a5937105..f6fcccd9b10c 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -67,10 +67,15 @@
>   #if defined(__KERNEL__) || defined(__VMLINUX_H__)
>   
>   #define PT_REGS_PARM1(x) ((x)->di)
> +#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
>   #define PT_REGS_PARM2(x) ((x)->si)
> +#define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
>   #define PT_REGS_PARM3(x) ((x)->dx)
> +#define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
>   #define PT_REGS_PARM4(x) ((x)->cx)
> +#define PT_REGS_PARM4_SYSCALL(x) ((x)->r10) /* syscall uses r10 */

I think this is correct. We have a bcc commit doing similar thing.
https://github.com/iovisor/bcc/commit/c23448e34ecd3cc9bfc19f0b43f4325f77c2e4cc#diff-c78ffb58f59e85eaba9bf9977b7202f3e50f17e2a9ee556c36a311f9a9ab5d6e

>   #define PT_REGS_PARM5(x) ((x)->r8)
> +#define PT_REGS_PARM5_SYSCALL(x) PT_REGS_PARM5(x)
>   #define PT_REGS_RET(x) ((x)->sp)
>   #define PT_REGS_FP(x) ((x)->bp)
>   #define PT_REGS_RC(x) ((x)->ax)
> @@ -78,10 +83,15 @@
>   #define PT_REGS_IP(x) ((x)->ip)
>   
>   #define PT_REGS_PARM1_CORE(x) BPF_CORE_READ((x), di)
> +#define PT_REGS_PARM1_CORE_SYSCALL(x) PT_REGS_PARM1_CORE(x)
>   #define PT_REGS_PARM2_CORE(x) BPF_CORE_READ((x), si)
> +#define PT_REGS_PARM2_CORE_SYSCALL(x) PT_REGS_PARM2_CORE(x)
>   #define PT_REGS_PARM3_CORE(x) BPF_CORE_READ((x), dx)
> +#define PT_REGS_PARM3_CORE_SYSCALL(x) PT_REGS_PARM3_CORE(x)
>   #define PT_REGS_PARM4_CORE(x) BPF_CORE_READ((x), cx)
> +#define PT_REGS_PARM4_CORE_SYSCALL(x) BPF_CORE_READ((x), r10) /* syscall uses r10 */
>   #define PT_REGS_PARM5_CORE(x) BPF_CORE_READ((x), r8)
> +#define PT_REGS_PARM5_CORE_SYSCALL(x) PT_REGS_PARM5_CORE(x)
>   #define PT_REGS_RET_CORE(x) BPF_CORE_READ((x), sp)
>   #define PT_REGS_FP_CORE(x) BPF_CORE_READ((x), bp)
>   #define PT_REGS_RC_CORE(x) BPF_CORE_READ((x), ax)
> @@ -117,10 +127,15 @@
>   #else
>   
>   #define PT_REGS_PARM1(x) ((x)->rdi)
> +#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
>   #define PT_REGS_PARM2(x) ((x)->rsi)
> +#define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
>   #define PT_REGS_PARM3(x) ((x)->rdx)
> +#define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
>   #define PT_REGS_PARM4(x) ((x)->rcx)
> +#define PT_REGS_PARM4_SYSCALL(x) ((x)->r10) /* syscall uses r10 */
>   #define PT_REGS_PARM5(x) ((x)->r8)
> +#define PT_REGS_PARM5(x) PT_REGS_PARM5(x)
>   #define PT_REGS_RET(x) ((x)->rsp)
>   #define PT_REGS_FP(x) ((x)->rbp)
>   #define PT_REGS_RC(x) ((x)->rax)
> @@ -128,10 +143,15 @@
>   #define PT_REGS_IP(x) ((x)->rip)
>   
>   #define PT_REGS_PARM1_CORE(x) BPF_CORE_READ((x), rdi)
> +#define PT_REGS_PARM1_CORE_SYSCALL(x) PT_REGS_PARM1_CORE(x)
>   #define PT_REGS_PARM2_CORE(x) BPF_CORE_READ((x), rsi)
> +#define PT_REGS_PARM2_CORE_SYSCALL(x) PT_REGS_PARM2_CORE(x)
>   #define PT_REGS_PARM3_CORE(x) BPF_CORE_READ((x), rdx)
> +#define PT_REGS_PARM3_CORE_SYSCALL(x) PT_REGS_PARM3_CORE(x)
>   #define PT_REGS_PARM4_CORE(x) BPF_CORE_READ((x), rcx)
> +#define PT_REGS_PARM4_CORE_SYSCALL(x) BPF_CORE_READ((x), r10) /* syscall uses r10 */
>   #define PT_REGS_PARM5_CORE(x) BPF_CORE_READ((x), r8)
> +#define PT_REGS_PARM5_CORE_SYSCALL(x) PT_REGS_PARM5_CORE(x)
>   #define PT_REGS_RET_CORE(x) BPF_CORE_READ((x), rsp)
>   #define PT_REGS_FP_CORE(x) BPF_CORE_READ((x), rbp)
>   #define PT_REGS_RC_CORE(x) BPF_CORE_READ((x), rax)

Looks like macros only available for x86_64. Can we make it also
available for other architectures so we won't introduce arch specific
codes into bpf program?

Also, could you add a selftest to use this macro, esp. for parameter 4?
