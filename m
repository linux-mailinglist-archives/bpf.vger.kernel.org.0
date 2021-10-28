Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D85A43E45A
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 16:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhJ1O6x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 10:58:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45526 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231133AbhJ1O6u (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Oct 2021 10:58:50 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19SA96mi012390;
        Thu, 28 Oct 2021 07:56:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=VPMJ71GD4mkftRjl+egf+Jr9tE7FVPLu8bPfvG2jAuU=;
 b=VfHKikwXx0N9unjy3sLPEiE5zR7SsSclufvPL0yMjRlojPWzfq0m+Km70/9yk3sEhkeI
 TKifEy0OxZYZ35QzxBDCgPUzBrUZ//OYc8UctSf39livFI/73jbxQ3Cdas4drlW7bTiC
 a9WiDynMXhmzZ5wwjzV4Vn9ZcogHnsQ98vU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3by9w89axc-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 Oct 2021 07:56:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 28 Oct 2021 07:56:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHhR5+9FnL4RXyifhM3/05A8PEu3KS8z1OcQnBmHnufKTeADdVqprKSv7N4YXiMrKg66ClKS9GgeJDtTUmECmCVE3mzbsYwWShYHZWQeVSDiLiM0dGbdoxJy5uMle77GohccJQDtMiLOuQ4cBtc7WDTU190Ze4G78G8vAdnckiYted2TALwGWKslckl+SLLMHANZs/45fv2gDW8J486pp4gSF3rzmhEXB6PbADeh1lvHS7vBfsoEq6uUar66fzGOzIkb6e5s46MDoicjmFwpziGSRLQSdi9j32H6Jb2fCeWS3hsdOgfNR2wxYo9yTJfUvDPvqwPyx+Ix6BNJvy/45A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPMJ71GD4mkftRjl+egf+Jr9tE7FVPLu8bPfvG2jAuU=;
 b=hNFpRfhTKwaJalTZqmt6qGU1rGtU4J3P00xnkcuI/3+jOKdQdNcu6a8yF1hSTtiACvge1g0ZlZayHiLadUxnt7Sth04IqxxxNLSArEY5/rS44w+O0xZx2ZDDinG+YaMPCOO9IKjmPACfhimC9vxTaPtlm4Ts2GdwiDvY1WvZ2LaiFkbXA6HhLf9Q9fwPkip103yHjD2xPw7hesffb0jqBVtPQUejzDLAmO0Zr4wzipolZcWy7W7vIQMkPrx61xg09TKq6634g+QFOBewypjLMM9Ih1xMJQ4xZ72PMk+J2m8LXAfgUKLRDQ4iVMXm450yF5ps1rEdqa0nPNfJQT60jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4176.namprd15.prod.outlook.com (2603:10b6:806:10c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 28 Oct
 2021 14:56:13 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4628.023; Thu, 28 Oct 2021
 14:56:13 +0000
Message-ID: <73129388-21ba-5e39-3115-c4af1665edad@fb.com>
Date:   Thu, 28 Oct 2021 07:56:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: err: math between fp pointer and register with unbounded min
 value is not allowed
Content-Language: en-US
To:     Shuyi Cheng <chengshuyi@linux.alibaba.com>,
        bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: <be2520e1-527e-92ca-95fe-62e895519e02@linux.alibaba.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <be2520e1-527e-92ca-95fe-62e895519e02@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR1601CA0011.namprd16.prod.outlook.com
 (2603:10b6:300:da::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21c1::1205] (2620:10d:c090:400::5:1d84) by MWHPR1601CA0011.namprd16.prod.outlook.com (2603:10b6:300:da::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Thu, 28 Oct 2021 14:56:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70dace23-ffbe-4fae-c03e-08d99a231603
X-MS-TrafficTypeDiagnostic: SN7PR15MB4176:
X-Microsoft-Antispam-PRVS: <SN7PR15MB4176E23596E25514E629B47DD3869@SN7PR15MB4176.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0sN8lwFOI/KzrFOMpVuiz70zOU3KUWsvUiIX1XYzIFtmoyOnyrhb5IePpJAomj3DhJ4PBfvt37NnYgSy5sq2Nht1b3tVZsjFhE3XNRZSHvYbH0ZD9Y7H/pHX9C7gHs8FEkNg6NjhP4jETdWaKpz/HxbnRaMk3O8EeASTf3KfniGSmSf9ijF3F3BKghHEDyLV8VCitFbMWSFv3aHQn07sXUW5OmiMlwF+Lh60sAtb7T3yqXypLypjlmPVNyjUf/6LrjTODs4LEcSuNjDM2y8LY07u5wjVG11wPWYFSwF8nHgm/rn4oSmMkI7epLj7qorUlqve+5S9f+xzMFznTtICi3wlQ9gIdKJsvU+Cgx4vv7K+QQgUah2yEINl/D9vT1oP16+9SZkLRbUBGhFKyslb+o/4fRoAD/E1vDVGwJXOjNP/iCaacBnBA0JIjeOBeS0Uc4WGrwlhi/pIY+YpcyXiOfIoskD4EN0+HXg1iuRjRwflDLJsMuvII09dHW48B88pb7j+NlPApx1ZSw9prMDyiL0DqAns88pyECVzTgwlbO9mDaSHmhS+afwFDu/DPAr3/rlDb9on3oG5fpgQnKaj6gUUUsD40D4FzplLGnKrnTfTAjpyAyfwX170UcPWZ1PFr42ePrq+AEo1MlIaIbLJUCG1gYlTRrD1T4sk6zOJvtmDfof+eBAOyY5DYynkP+3QUATjWkLG9ef9fcZ/eEJEZVYFM5Ru3VkROTxozULRN1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66556008)(53546011)(8676002)(8936002)(52116002)(30864003)(110136005)(66946007)(83380400001)(38100700002)(5660300002)(316002)(2616005)(31696002)(508600001)(86362001)(2906002)(31686004)(6486002)(186003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFNzUW84ckJja2FnSys4Nlp6NkFjMlZvaUZFQ29nSEcvQkhtZnRGUkh1ekJB?=
 =?utf-8?B?M01yZDdKL0NLQURTNUo4KzFBSTloZXhmZGRrN1MwYjNGcVlvb1E5YXNUczlw?=
 =?utf-8?B?emV0MXloZzdDVnVJaDdBR2JYZ0c5a0MwOWNuMU1UNVhsVElhVy9KdlpvM1NN?=
 =?utf-8?B?UFdSV0s4S096cW9iZ0hmVTRTOHJmWjN0WENHUGJ5VEJiRmV1bHNtaUhzckdR?=
 =?utf-8?B?WDhiSFh3ZnNOcXZjQlVwV1JCaGhkWWwyQ1RNQjR0Unh5SW1ncGZ3VEs1MGxK?=
 =?utf-8?B?bG4ySlZ4TnBRaEtya0dxNW9aaDZYWVkwbEx3OURCOHgyTVl5Z3lyNlJybGxo?=
 =?utf-8?B?WTlyRHdsTWlCVDR0RjQ5dHpBdWNqa1BMQWRMK0hFbUsxeDYvU3ozUmpHbjBB?=
 =?utf-8?B?T0IzZFF2WnY5bFQ0ZVdDTEVocndvOEpQQ2FlNWJpY3pONUYvejExOG5pWjFv?=
 =?utf-8?B?U1Byck1nZ01aaEs2RkZlaHNyMFZUNFp1NGUxMmI0dHFyWE9UeGdjN3lleXR0?=
 =?utf-8?B?anFCYmt3S0EzWW0zWlg1d2dITTMyRzlpb01ISDdkM0JhWUpUU00wYzIyVkV5?=
 =?utf-8?B?YVpzcklzS091RHdybTZRaC84Y0kxZFZDemdUMndNUjRKclpkRE9tdmdMUDkv?=
 =?utf-8?B?Wmhwd2wzT3BzM3prSnZHTzNzNGhDZ2tOSC9CM2prZnpIQnV5eUdXNW5ZSjZB?=
 =?utf-8?B?RGFZMUt2Q0YrKzdjUGdieE9xeGVsYmFBRDN6M0IzaDJUSjRIYmhDS2JWVU5t?=
 =?utf-8?B?eHp3Rm1qMWI0MlNXMkNwRWYyUExWbWNuWnFXUEtKNGxpZlRPK0ZQOFhxNU4x?=
 =?utf-8?B?R1lWSU9rd3BXRU1oMlRUZ0tYVnhHWXNMYURVNzcxVUFvYUIyMzlySmZPb2V4?=
 =?utf-8?B?MDB1aHRIcGFIZWxRL2FBOG5JeThNa1ZpbDBFYnAvc0thRU93RHZLK1lqV3dt?=
 =?utf-8?B?WWNOWFV5M3NlOFhYWDkraXZxT2oyM3FRZitPNFJiWWQ5cjU0eHl2a3NMWnRi?=
 =?utf-8?B?OGdUVHl6RXcxT2xRTVBJZkRFZzNwU1RSSjZBbmdSdmw3SWZYS1FLY1RwL3N6?=
 =?utf-8?B?cGNmVURIdGFld3dDY0picjlFTnFGRitPZzQ0YzM3UldrVGg4ekNUZnFjQ0JU?=
 =?utf-8?B?MHhtNVR4bnNPdlVWVTdpVXEwTGFaN3NwekJmaVF0c3VsdktWak9pWWduaXhT?=
 =?utf-8?B?d3RtRnZBVnpUUE45Qk1OM1VkV2JmS3ovNjN3dVRyN1RHVk42YmFrdVVtWWdV?=
 =?utf-8?B?elZXVnhCZ0NIM3NHeDhDNVBBakx5eXNwQVhreDRvZlhaakdCdzhveWxteVZ5?=
 =?utf-8?B?c3YzU3ZwQkJ6Y081UTVYUW1qUGc4cjByWTJsemFieUlqeGpEKzFmbEJPaDFQ?=
 =?utf-8?B?NTdQcDl5QVRYc2RJRXh2Z0VGTG4waGozWENJSjcxRXdydzR3TE9LMHZucW1E?=
 =?utf-8?B?Y0hGMzhhTUZrUi9WOTVmOVNuR3l2M2RDdXFSZlJPRUVzM05qcHRkVkwzRndk?=
 =?utf-8?B?NTVLc1BqVDZ2bjBMYWhENFZFQVFmTU9sMHM4UW4vamdWa1RVVmxOOUpEY1d1?=
 =?utf-8?B?UjZMVWM2M29DWkJBMFJNSDVXTFU3VGNNSGhpZkloQzZTRjdGdUZvazcxY2pj?=
 =?utf-8?B?eW1xaGgvMHdaQjRWT01EOGorQUU1cTJGV3BRT2hua3BOazRjU3h2UXRQS25Z?=
 =?utf-8?B?Ui9TVGFiaDJDQnBGL25oR2NvNmtITWR1K0JJVk84UnR2OGdlY1hjbnpSbzVX?=
 =?utf-8?B?cVFndGxlZENrVjFPczhzLzl5cVhRKzN1UHAyN0ZQMHJwY2FpK1hEZDVKd0Ny?=
 =?utf-8?B?ejhQclZ4QWVtYkpDM3dIYUN0QS80MmNQelVUc053R3NkZEdSM1Q3cExhWGY0?=
 =?utf-8?B?VTZKcEx1cGptUFZtdksrQmtFRDZZRStuTjJOTHVzeXNCUG1CditKeVhYYWRj?=
 =?utf-8?B?Wkh0N2FEaXFub2E5TllHbXNLZ0hpMWR1VzBnd1ZxcHdIMjRSNmVDdTdWYVd5?=
 =?utf-8?B?NklRQmlOMnc5aEpyV0xxMExadmpCSFVJM3Y1c3ZHU2UwencrRjhONWxjaVNB?=
 =?utf-8?B?ZVIvSFA3UTVkVStGR1puY3ZPdFFKaEwyWXFndXdJeGlmUWRURERaQlljRE82?=
 =?utf-8?Q?dooEzi4CBANEvOT5pfD+cn0hk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70dace23-ffbe-4fae-c03e-08d99a231603
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 14:56:13.4652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZXRTbXfya/rqWtR5nmOT/5XOP28vpy5mxbVxJxh+ISzcmzy9U8o8mQMYnBhYWG3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4176
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: a6MA81c_r7ioVYud9C0Mh5XCGlwWfnFV
X-Proofpoint-ORIG-GUID: a6MA81c_r7ioVYud9C0Mh5XCGlwWfnFV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-28_01,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 mlxscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110280084
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/28/21 4:53 AM, Shuyi Cheng wrote:
> Hi everyone, I encountered a very strange problem. If my bpf program is 
> as follows, it can run normally.
> 
>      buff.in = sizeof(struct pid_info);
>      data = &buff.buff[buff.in];
>      set_pid_info((struct pid_info *)data);
>      buff.in = sizeof(struct pid_info);
>      data = &buff.buff[buff.in];
>      set_pid_info((struct pid_info *)data);
> 
> but if I add a plus sign, an error is reported. error message is 'math 
> between fp pointer and register with unbounded min value is not allowed'.
> 
>      buff.in = sizeof(struct pid_info);
>      data = &buff.buff[buff.in];
>      set_pid_info((struct pid_info *)data);
>      buff.in += sizeof(struct pid_info);
>      data = &buff.buff[buff.in];
>      set_pid_info((struct pid_info *)data);
> 
> 
> The error log printed by libbpf is as follows:
> 
> libbpf: -- BEGIN DUMP LOG ---
> libbpf:
> 0: (79) r3 = *(u64 *)(r1 +112)
> 1: (b7) r2 = 0
> 2: (85) call pc+2
> caller:
>   R10=fp0,call_-1
> callee:
>   frame1: R1=ctx(id=0,off=0,imm=0) R2=inv0 R3=inv(id=0) R10=fp0,call_2
> 5: (bf) r7 = r3
> 6: (bf) r6 = r1
> 7: (7b) *(u64 *)(r10 -72) = r2
> 8: (b7) r8 = 0
> 9: (7b) *(u64 *)(r10 -96) = r8
> 10: (7b) *(u64 *)(r10 -104) = r8
> 11: (7b) *(u64 *)(r10 -112) = r8
> 12: (7b) *(u64 *)(r10 -120) = r8
> 13: (7b) *(u64 *)(r10 -128) = r8
> 14: (7b) *(u64 *)(r10 -136) = r8
> 15: (7b) *(u64 *)(r10 -144) = r8
> 16: (7b) *(u64 *)(r10 -152) = r8
> 17: (7b) *(u64 *)(r10 -160) = r8
> 18: (7b) *(u64 *)(r10 -168) = r8
> 19: (7b) *(u64 *)(r10 -176) = r8
> 20: (7b) *(u64 *)(r10 -184) = r8
> 21: (7b) *(u64 *)(r10 -192) = r8
> 22: (7b) *(u64 *)(r10 -200) = r8
> 23: (7b) *(u64 *)(r10 -208) = r8
> 24: (7b) *(u64 *)(r10 -216) = r8
> 25: (7b) *(u64 *)(r10 -224) = r8
> 26: (7b) *(u64 *)(r10 -232) = r8
> 27: (7b) *(u64 *)(r10 -240) = r8
> 28: (7b) *(u64 *)(r10 -248) = r8
> 29: (7b) *(u64 *)(r10 -256) = r8
> 30: (7b) *(u64 *)(r10 -264) = r8
> 31: (7b) *(u64 *)(r10 -272) = r8
> 32: (7b) *(u64 *)(r10 -280) = r8
> 33: (7b) *(u64 *)(r10 -288) = r8
> 34: (7b) *(u64 *)(r10 -296) = r8
> 35: (7b) *(u64 *)(r10 -304) = r8
> 36: (7b) *(u64 *)(r10 -312) = r8
> 37: (7b) *(u64 *)(r10 -320) = r8
> 38: (7b) *(u64 *)(r10 -328) = r8
> 39: (7b) *(u64 *)(r10 -336) = r8
> 40: (7b) *(u64 *)(r10 -344) = r8
> 41: (63) *(u32 *)(r10 -352) = r8
> 42: (7b) *(u64 *)(r10 -360) = r8
> 43: (7b) *(u64 *)(r10 -88) = r8
> 44: (7b) *(u64 *)(r10 -80) = r8
> 45: (63) *(u32 *)(r10 -368) = r8
> 46: (7b) *(u64 *)(r10 -376) = r8
> 47: (55) if r2 != 0x0 goto pc+7
> 48: (b7) r1 = 24
> 49: (bf) r3 = r7
> 50: (0f) r3 += r1
> 51: (bf) r1 = r10
> 52: (07) r1 += -72
> 53: (b7) r2 = 8
> 54: (85) call bpf_probe_read#4
> 55: (63) *(u32 *)(r10 -8) = r8
> 56: (7b) *(u64 *)(r10 -16) = r8
> 57: (7b) *(u64 *)(r10 -24) = r8
> 58: (63) *(u32 *)(r10 -32) = r8
> 59: (7b) *(u64 *)(r10 -40) = r8
> 60: (7b) *(u64 *)(r10 -48) = r8
> 61: (b7) r1 = 194
> 62: (bf) r3 = r7
> 63: (0f) r3 += r1
> 64: (bf) r1 = r10
> 65: (07) r1 += -62
> 66: (b7) r2 = 2
> 67: (85) call bpf_probe_read#4
> 68: (b7) r1 = 232
> 69: (bf) r3 = r7
> 70: (0f) r3 += r1
> 71: (bf) r1 = r10
> 72: (07) r1 += -56
> 73: (b7) r2 = 8
> 74: (85) call bpf_probe_read#4
> 75: (69) r1 = *(u16 *)(r10 -62)
> 76: (55) if r1 != 0xffff goto pc+40
>   frame1: R0=inv(id=0) R1=inv65535 R6=ctx(id=0,off=0,imm=0) R7=inv(id=0) 
> R8=inv0 R10=fp0,call_2 fp-16=0 fp-24=0 fp-40=0 fp-48=0 fp-80=0 fp-88=0 
> fp-96=0 fp-104=0 fp-112=0 fp-120=0 fp-128=0 fp-136=0 fp-144=0 fp-152=0 
> fp-160=0 fp-168=0 fp-176=0 fp-184=0 fp-192=0 fp-200=0 fp-208=0 fp-216=0 
> fp-224=0 fp-232=0 fp-240=0 fp-248=0 fp-256=0 fp-264=0 fp-272=0 fp-280=0 
> fp-288=0 fp-296=0 fp-304=0 fp-312=0 fp-320=0 fp-328=0 fp-336=0 fp-344=0 
> fp-360=0 fp-376=0
> 77: (b7) r1 = 196
> 78: (bf) r3 = r7
> 79: (0f) r3 += r1
> 80: (bf) r1 = r10
> 81: (07) r1 += -60
> 82: (b7) r2 = 2
> 83: (85) call bpf_probe_read#4
> 84: (69) r1 = *(u16 *)(r10 -60)
> 85: (55) if r1 != 0x0 goto pc+10
>   frame1: R0=inv(id=0) R1=inv0 R6=ctx(id=0,off=0,imm=0) R7=inv(id=0) 
> R8=inv0 R10=fp0,call_2 fp-16=0 fp-24=0 fp-40=0 fp-48=0 fp-80=0 fp-88=0 
> fp-96=0 fp-104=0 fp-112=0 fp-120=0 fp-128=0 fp-136=0 fp-144=0 fp-152=0 
> fp-160=0 fp-168=0 fp-176=0 fp-184=0 fp-192=0 fp-200=0 fp-208=0 fp-216=0 
> fp-224=0 fp-232=0 fp-240=0 fp-248=0 fp-256=0 fp-264=0 fp-272=0 fp-280=0 
> fp-288=0 fp-296=0 fp-304=0 fp-312=0 fp-320=0 fp-328=0 fp-336=0 fp-344=0 
> fp-360=0 fp-376=0
> 86: (b7) r1 = 198
> 87: (0f) r7 += r1
> 88: (bf) r1 = r10
> 89: (07) r1 += -58
> 90: (b7) r2 = 2
> 91: (bf) r3 = r7
> 92: (85) call bpf_probe_read#4
> 93: (69) r1 = *(u16 *)(r10 -58)
> 94: (07) r1 += 14
> 95: (6b) *(u16 *)(r10 -60) = r1
> 96: (57) r1 &= 65535
> 97: (79) r7 = *(u64 *)(r10 -56)
> 98: (0f) r7 += r1
> 99: (bf) r8 = r10
> 100: (07) r8 += -24
> 101: (bf) r1 = r8
> 102: (b7) r2 = 20
> 103: (bf) r3 = r7
> 104: (85) call bpf_probe_read#4
> 105: (b7) r1 = 0
> 106: (71) r5 = *(u8 *)(r8 +9)
> 107: (b7) r3 = 0
> 108: (b7) r4 = 0
> 109: (b7) r2 = 0
> 110: (55) if r5 != 0x6 goto pc+26
>   frame1: R0=inv(id=0) R1=inv0 R2=inv0 R3=inv0 R4=inv0 R5=inv6 
> R6=ctx(id=0,off=0,imm=0) R7=inv(id=0) R8=fp-24,call_2 R10=fp0,call_2 
> fp-40=0 fp-48=0 fp-80=0 fp-88=0 fp-96=0 fp-104=0 fp-112=0 fp-120=0 
> fp-128=0 fp-136=0 fp-144=0 fp-152=0 fp-160=0 fp-168=0 fp-176=0 fp-184=0 
> fp-192=0 fp-200=0 fp-208=0 fp-216=0 fp-224=0 fp-232=0 fp-240=0 fp-248=0 
> fp-256=0 fp-264=0 fp-272=0 fp-280=0 fp-288=0 fp-296=0 fp-304=0 fp-312=0 
> fp-320=0 fp-328=0 fp-336=0 fp-344=0 fp-360=0 fp-376=0
> 111: (bf) r1 = r10
> 112: (07) r1 += -24
> 113: (71) r1 = *(u8 *)(r1 +0)
> 114: (67) r1 <<= 2
> 115: (57) r1 &= 60
> 116: (05) goto pc+1
> 118: (0f) r7 += r1
> 119: (b7) r1 = 0
> 120: (b7) r3 = 0
> 121: (b7) r4 = 0
> 122: (b7) r2 = 0
> 123: (15) if r7 == 0x0 goto pc+13
>   frame1: R0=inv(id=0) R1=inv0 R2=inv0 R3=inv0 R4=inv0 R5=inv6 
> R6=ctx(id=0,off=0,imm=0) R7=inv(id=0) R8=fp-24,call_2 R10=fp0,call_2 
> fp-40=0 fp-48=0 fp-80=0 fp-88=0 fp-96=0 fp-104=0 fp-112=0 fp-120=0 
> fp-128=0 fp-136=0 fp-144=0 fp-152=0 fp-160=0 fp-168=0 fp-176=0 fp-184=0 
> fp-192=0 fp-200=0 fp-208=0 fp-216=0 fp-224=0 fp-232=0 fp-240=0 fp-248=0 
> fp-256=0 fp-264=0 fp-272=0 fp-280=0 fp-288=0 fp-296=0 fp-304=0 fp-312=0 
> fp-320=0 fp-328=0 fp-336=0 fp-344=0 fp-360=0 fp-376=0
> 124: (bf) r8 = r10
> 125: (07) r8 += -48
> 126: (bf) r1 = r8
> 127: (b7) r2 = 20
> 128: (bf) r3 = r7
> 129: (85) call bpf_probe_read#4
> 130: (bf) r1 = r10
> 131: (07) r1 += -24
> 132: (69) r2 = *(u16 *)(r8 +2)
> 133: (61) r3 = *(u32 *)(r1 +16)
> 134: (61) r1 = *(u32 *)(r1 +12)
> 135: (69) r4 = *(u16 *)(r8 +0)
> 136: (dc) r4 = be16 r4
> 137: (63) *(u32 *)(r10 -372) = r1
> 138: (63) *(u32 *)(r10 -376) = r3
> 139: (dc) r4 = be16 r4
> 140: (6b) *(u16 *)(r10 -366) = r4
> 141: (dc) r2 = be16 r2
> 142: (6b) *(u16 *)(r10 -368) = r2
> 143: (79) r7 = *(u64 *)(r10 -72)
> 144: (55) if r7 != 0x0 goto pc+15
>   frame1: R0=inv(id=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 
> 0xffffffff)) R2=inv(id=0) 
> R3=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) 
> R4=inv(id=0) R6=ctx(id=0,off=0,imm=0) R7=inv0 R8=fp-48,call_2 
> R10=fp0,call_2 fp-80=0 fp-88=0 fp-96=0 fp-104=0 fp-112=0 fp-120=0 
> fp-128=0 fp-136=0 fp-144=0 fp-152=0 fp-160=0 fp-168=0 fp-176=0 fp-184=0 
> fp-192=0 fp-200=0 fp-208=0 fp-216=0 fp-224=0 fp-232=0 fp-240=0 fp-248=0 
> fp-256=0 fp-264=0 fp-272=0 fp-280=0 fp-288=0 fp-296=0 fp-304=0 fp-312=0 
> fp-320=0 fp-328=0 fp-336=0 fp-344=0 fp-360=0
> 145: (bf) r2 = r10
> 146: (07) r2 += -376
> 147: (18) r1 = 0xffff97062f35e000
> 149: (85) call bpf_map_lookup_elem#1
> 150: (15) if r0 == 0x0 goto pc+131
>   frame1: R0=map_value(id=0,off=0,ks=12,vs=8,imm=0) 
> R6=ctx(id=0,off=0,imm=0) R7=inv0 R8=fp-48,call_2 R10=fp0,call_2 fp-80=0 
> fp-88=0 fp-96=0 fp-104=0 fp-112=0 fp-120=0 fp-128=0 fp-136=0 fp-144=0 
> fp-152=0 fp-160=0 fp-168=0 fp-176=0 fp-184=0 fp-192=0 fp-200=0 fp-208=0 
> fp-216=0 fp-224=0 fp-232=0 fp-240=0 fp-248=0 fp-256=0 fp-264=0 fp-272=0 
> fp-280=0 fp-288=0 fp-296=0 fp-304=0 fp-312=0 fp-320=0 fp-328=0 fp-336=0 
> fp-344=0 fp-360=0
> 151: (79) r1 = *(u64 *)(r0 +0)
>   frame1: R0=map_value(id=0,off=0,ks=12,vs=8,imm=0) 
> R6=ctx(id=0,off=0,imm=0) R7=inv0 R8=fp-48,call_2 R10=fp0,call_2 fp-80=0 
> fp-88=0 fp-96=0 fp-104=0 fp-112=0 fp-120=0 fp-128=0 fp-136=0 fp-144=0 
> fp-152=0 fp-160=0 fp-168=0 fp-176=0 fp-184=0 fp-192=0 fp-200=0 fp-208=0 
> fp-216=0 fp-224=0 fp-232=0 fp-240=0 fp-248=0 fp-256=0 fp-264=0 fp-272=0 
> fp-280=0 fp-288=0 fp-296=0 fp-304=0 fp-312=0 fp-320=0 fp-328=0 fp-336=0 
> fp-344=0 fp-360=0
> 152: (79) r7 = *(u64 *)(r10 -72)
> 153: (55) if r7 != 0x0 goto pc+58
>   frame1: R0=map_value(id=0,off=0,ks=12,vs=8,imm=0) R1=inv(id=0) 
> R6=ctx(id=0,off=0,imm=0) R7=inv0 R8=fp-48,call_2 R10=fp0,call_2 fp-80=0 
> fp-88=0 fp-96=0 fp-104=0 fp-112=0 fp-120=0 fp-128=0 fp-136=0 fp-144=0 
> fp-152=0 fp-160=0 fp-168=0 fp-176=0 fp-184=0 fp-192=0 fp-200=0 fp-208=0 
> fp-216=0 fp-224=0 fp-232=0 fp-240=0 fp-248=0 fp-256=0 fp-264=0 fp-272=0 
> fp-280=0 fp-288=0 fp-296=0 fp-304=0 fp-312=0 fp-320=0 fp-328=0 fp-336=0 
> fp-344=0 fp-360=0
> 154: (18) r2 = 0x123456776543210
> 156: (1d) if r1 == r2 goto pc+125
>   frame1: R0=map_value(id=0,off=0,ks=12,vs=8,imm=0) R1=inv(id=0) 
> R2=inv81985528891978256 R6=ctx(id=0,off=0,imm=0) R7=inv0 R8=fp-48,call_2 
> R10=fp0,call_2 fp-80=0 fp-88=0 fp-96=0 fp-104=0 fp-112=0 fp-120=0 
> fp-128=0 fp-136=0 fp-144=0 fp-152=0 fp-160=0 fp-168=0 fp-176=0 fp-184=0 
> fp-192=0 fp-200=0 fp-208=0 fp-216=0 fp-224=0 fp-232=0 fp-240=0 fp-248=0 
> fp-256=0 fp-264=0 fp-272=0 fp-280=0 fp-288=0 fp-296=0 fp-304=0 fp-312=0 
> fp-320=0 fp-328=0 fp-336=0 fp-344=0 fp-360=0
> 157: (7b) *(u64 *)(r10 -72) = r1
> 158: (bf) r7 = r1
> 159: (05) goto pc+62
> 222: (b7) r1 = 0
> 223: (bf) r3 = r7
> 224: (0f) r3 += r1
> 225: (bf) r1 = r10
> 226: (07) r1 += -356
> 227: (b7) r2 = 4
> 228: (85) call bpf_probe_read#4
> 229: (b7) r1 = 12
> 230: (bf) r3 = r7
> 231: (0f) r3 += r1
> 232: (bf) r1 = r10
> 233: (07) r1 += -350
> 234: (b7) r2 = 2
> 235: (85) call bpf_probe_read#4
> 236: (b7) r1 = 4
> 237: (bf) r3 = r7
> 238: (0f) r3 += r1
> 239: (bf) r1 = r10
> 240: (07) r1 += -360
> 241: (b7) r2 = 4
> 242: (85) call bpf_probe_read#4
> 243: (b7) r1 = 14
> 244: (0f) r7 += r1
> 245: (bf) r1 = r10
> 246: (07) r1 += -352
> 247: (b7) r2 = 2
> 248: (bf) r3 = r7
> 249: (85) call bpf_probe_read#4
> 250: (b7) r1 = 20
> 251: (7b) *(u64 *)(r10 -80) = r1
> 252: (85) call bpf_get_current_pid_tgid#14
> 253: (77) r0 >>= 32
> 254: (63) *(u32 *)(r10 -324) = r0
> 255: (bf) r1 = r10
> 256: (07) r1 += -320
> 257: (b7) r2 = 16
> 258: (85) call bpf_get_current_comm#16
> 259: (79) r1 = *(u64 *)(r10 -80)
> 260: (07) r1 += 20
> 261: (7b) *(u64 *)(r10 -80) = r1
> 262: (bf) r7 = r10
> 263: (07) r7 += -344
> 264: (0f) r7 += r1
> math between fp pointer and register with unbounded min value is not 
> allowed

You probably used an old kernel.
The value "r1" is restored from stack location r10 - 80 which
stores a constant. The verifier needs to transfer the "const" state
from spill to register.

> 
> 
> Thank you very much!
