Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68713F0B65
	for <lists+bpf@lfdr.de>; Wed, 18 Aug 2021 21:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhHRTEj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Aug 2021 15:04:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:26776 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229965AbhHRTEi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Aug 2021 15:04:38 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17IItwUO013970;
        Wed, 18 Aug 2021 12:04:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=32kvPgyaBBQx0jvhfibiORIa7zC7aR0357nrMvPuB98=;
 b=mqv1y27ys4FT0JjQKiPk8VizoNXuC2xgKcQVKGf7QcFURcZ92zUIunlbNwB3vpCVk3Bo
 LMqf1TtiJ4dJj9M1KjNiWIb6/meed3oeLTF3YFUmCIk9vM6x/L1maFQ4y7qQ6Wqh0qeO
 qItSpN9sSotfrsCfTOhS7Fzn4DWuNVbaVw8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3agnh166r5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 18 Aug 2021 12:04:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 18 Aug 2021 12:04:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJFoSJ4ona6NDre+AuWVoLANw7V6ihNupoPXnuG29cctOrSGuoLVUtxsfQAFt6QVh5kh8QUNCja8vzTo1Ek+jsqYZv1GXG5DnDnORBj//vofmm72QkZgP27NjWizDM5r6BihafKz/X4kyLGeoKUPG1Ftx9dXz9qeIVsKxb1aVoqwAkuJR2Pw0OwYQs1r9jA23sIlLeM/a1w3qbCPN+hGNB9nSRJeSe/8ccPyv90cXcG2fRBeWsqvgYDkpNyUJwmcuRO4vdWSlhuGJuMUeHjrP3cSzPWVk6IJtvIbtCmGKmxxxYDit4y9pf2y1Taic/ySaEcybJMPBYjk0hapyuv8Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32kvPgyaBBQx0jvhfibiORIa7zC7aR0357nrMvPuB98=;
 b=RVNxAEswIDCCybuxuEFFMd1BaeTvXLYtXSn/rg2ej1wDQhV/hWukNDVPmfHkQt96wfWbEpLEqjWa7uxuXlgLvEij1szEQqJdHmGTotQtxDWDmZKeln9NpbKd7aJqlSIAVj6uYyRvgHSRHlxdyAEFpQ/yRqLBjKojhl9Nq3/XiycJEQ8+uU9e4Xw6IgWY+n4XDML2iexVI4HTlCZgKwTxiwu/wHDJoHCgKYeMGO175CSWhJ26C0Ioo7rR6bE3xmCdBfDIyPPGJz9kAOvHxMQxW2mcxU4NaVm5Gk+0xjUle4oRZfWoHTSZ4nPhP5UGFORXccWu7lCErmmwx1Zci0MA9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=fb.com;
Received: from SJ0PR15MB4679.namprd15.prod.outlook.com (2603:10b6:a03:37c::6)
 by BY3PR15MB4835.namprd15.prod.outlook.com (2603:10b6:a03:3b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Wed, 18 Aug
 2021 19:03:54 +0000
Received: from SJ0PR15MB4679.namprd15.prod.outlook.com
 ([fe80::2dad:e68a:6d99:e95]) by SJ0PR15MB4679.namprd15.prod.outlook.com
 ([fe80::2dad:e68a:6d99:e95%7]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 19:03:54 +0000
Date:   Wed, 18 Aug 2021 12:03:52 -0700
From:   Andrey Ignatov <rdna@fb.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <bpf@vger.kernel.org>
Subject: Re: [bug report] bpf: Allow narrow loads with offset > 0
Message-ID: <YR1ZmOIJgGKM3iF4@rdna-mbp.dhcp.thefacebook.com>
References: <20210817050843.GA21456@kili>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20210817050843.GA21456@kili>
X-ClientProxiedBy: BYAPR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:a03:100::28) To SJ0PR15MB4679.namprd15.prod.outlook.com
 (2603:10b6:a03:37c::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2620:10d:c090:400::5:f982) by BYAPR08CA0015.namprd08.prod.outlook.com (2603:10b6:a03:100::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 19:03:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 458806bb-0ec1-40a6-912c-08d9627aec58
X-MS-TrafficTypeDiagnostic: BY3PR15MB4835:
X-Microsoft-Antispam-PRVS: <BY3PR15MB4835A31EC0B9A4F894FDBCD9A8FF9@BY3PR15MB4835.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: enia0Ic8uVzC+vyl55HFX0GXCFg5//5ccl1h10MDm4+L9GLI4ZtTY2R71h6uuk0wdg89IjSif5xLjkn2RFPChrvClvZb6aF3p4p1UYIGZp1K+1SYTPJ9XL7xkd4NwbGabKTiWieAVMFvNktwKbOn5QHnNpMrBRWtXl7sRSyklRNzlS6+JmHFihKS4RGZ6tFcDIHt+2qlgmKj5EQ3nxjtPUllz97tuNJdXRhsOMlWDm29g8FqBNA34XBjK43D3YiRKC23gGlC24zoAR5osXXiS272+AaBv6sYPoXgoFO7I7xPd3i6K8seFc0opvKWVzc80734ebt/2s83IWaa0fHUM91LFhHU229D9rSoOsaHLp3sCBTFvowVo/evYJPxAutNPODZWjk0xxhqAdLLvB1J5j2aTaWQKIxHKrwAedV33ylzxX309cvy/oOO0Nb/Nb21gkj/+BITNgRKuv3nfFgzAWz8j/WsXAAH3W4rv4DFzbH+AkFJBlOZsxE0mfbwZVL+S5U7xqwqg/5KL4FLgqVwGfSC4vl6ckF8FwN8+DCS3v6KWi/LC0YEeZBVXb6TNYxuE3JNwEmFbmKYrgvdGZE+9CG7nAIsIYuyviuhSYULh0oGCGQaB5AuLlfdpBb1gbb9pDHJzOjg/fD7c8zv3Giqfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4679.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(4326008)(8936002)(316002)(66476007)(186003)(66946007)(66556008)(478600001)(52116002)(8676002)(38100700002)(2906002)(83380400001)(6916009)(6496006)(9686003)(5660300002)(86362001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFJjaDZOYXlVZmluaGo1RUtYYUpSZU9LcXlZQ1pSY1ZjQkJIREpHaXVBV25z?=
 =?utf-8?B?eng3a244UXhoVVFOWUdYTHc3aVJ6VzlnU0J2QkZQUjhpYVJDa1hza2E3Nmt6?=
 =?utf-8?B?TGNyQ2hBVklWWVYyc3VTbVVnZStkL2dhcG9xVjVrUVkrcTFTdjZVUXZQUC9H?=
 =?utf-8?B?U1FzSzZSUVQrUjNjb00wMENndlcxR1FVN2JrQ3FlQmQ1R0FveDV6bXBSelRw?=
 =?utf-8?B?QVlaVGRaZnhSdEVKaStVWXBDY05YeHRya0pBcEVoRGsrUTAyUWNXSDNFK3Zp?=
 =?utf-8?B?UU1VYXFIZ0hnR3d6ZkdNZ1hpbXdzNThRZklrU2JCakFhUHV5WVNjMHJrRVhx?=
 =?utf-8?B?cDJiOEFiaTNxQ2QyT0FEUGoxSDRZTTBvNXM5OVRqNUZOYWhYMGFVdm9Mbmdt?=
 =?utf-8?B?d1Y5NXNYTHRONlp5cVRqNWVFbzl6YzAvZEVHaUNacEJvLzIwTU9XMHIvL2Zj?=
 =?utf-8?B?SUF1cU1DaUt2T3R5ZjF5dzRLWHQ0aEtMcnc0RzRDQXhObXJnV21LQmJoVXRW?=
 =?utf-8?B?bUtTVU5SUjdzUi8vNTF0c1RmbThpd0h2SGtzZ2ZOZUV3Y1gzVkthckJkczhs?=
 =?utf-8?B?cE8zS2NiS3JRUm1qRHdwMXYvWW5ZazF3bnRXZ2QvT1lTWHZ4SjV5VVdVUjBw?=
 =?utf-8?B?aFdLT2lIdWZJOHZoRytQZ2Z3VGJmNkpNK1NGSWttMUo1WlRVQ0JoVlhHQ21H?=
 =?utf-8?B?L2JYSFROdW9KeFkwS29aYnJWRURHRlZzVXBkcVRmRHd4UUVHL0M3Zk5QbkpF?=
 =?utf-8?B?OFIxdGd3RC9NUU1HTktXcCtzR2lWem5qellESmJOOU9CYTJuc0N0T2lFblc3?=
 =?utf-8?B?Tk0zQ0ZOTEVMT1l5VHlKWHpOa1VwUEM2SnVJNWdYb0Y2Qi9haHg2UlZsTzUy?=
 =?utf-8?B?VVBjeGdoM1U2SEVCekR6dElacy9iTFRJSHBmUHRjNjlPK0xEV0p3ZjdRTmJD?=
 =?utf-8?B?R1E0NkYxQzFOM3lHNklCd2Q4RE1LSkxMVVVrckp1ME1LV2U0REFkUEFpNG1p?=
 =?utf-8?B?Mk1zVUpGY0d4aDM5TEdmNmozUVdBUFdXaHRLWEZxQnUwYnEzV1JmK3NOYlV2?=
 =?utf-8?B?QmhnWVRER2lwL3hoWXBNbWxqM3dZNmRrb2duMWhtbWJaRitYbHFzRkpicFZo?=
 =?utf-8?B?MHpkSmJLSEd6bnJENHE1cmlCNm5iaUNTVFoyOUdrZnFPVE9EdTVDeml0MXI4?=
 =?utf-8?B?QzJ0K2NwZ0svdWlPSjFvWWVnQTV2MVFuTWJZeFc5QjFoTERMKzExOW5tZHRs?=
 =?utf-8?B?SEZQb25SVlhqSVZMc2EvWk9Fa2loR250cWpxTHg1Y0FjUWNYR1M0akdYOWdn?=
 =?utf-8?B?eGtaL3VSa3U3aVRiUFM2UE1rWEJ5WlBFWVZoWVpUZFZZT2I4UmFNNUJxZW40?=
 =?utf-8?B?NnlWSDNubERVejZrdkhaSUlOUWN6d2dCTnNIZklkMmJVK20weDdsSTMvbUQ0?=
 =?utf-8?B?cFlvaW1hcWhESFlreEhlbFdmWEpRMlhLY0JVMDkvTm1GbWQ3eWhOVXJYNDhr?=
 =?utf-8?B?bGFyOHVpK1laUkQ0aXEyZlFNSG83Uk9lb2JWbjlISWl1OCtpajJSWjUwR3g0?=
 =?utf-8?B?bHpuQ1V5NnQ4QXBCbHhLNDFzSnZWd0IxaXFGbHQreGFhK2FDK0tFQnJsKy8z?=
 =?utf-8?B?MkJTLzY3cVQwSDRlL3orL3ZOcTlxcUppKzM5cjNoakZRNHhZWXJOUXZsL3Zw?=
 =?utf-8?B?cTZsNnd3ZWJlMVBnQmpkRWY2b1JkZWVvVkp2U0o3VXQ1ZEgzNWVhWGdrWGFY?=
 =?utf-8?B?amdHbVIwVUt4amF2Qm1tNGtZcDRTZzZzUlI1eEVGWmwvWDVrWlRoNGxBZUc0?=
 =?utf-8?B?cjEzc3FxY1EwR2FrbHYydz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 458806bb-0ec1-40a6-912c-08d9627aec58
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4679.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 19:03:54.3516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z28VQRoViWcVYJ+QYchnHu4nizcYAte0aZlrONN09jnDT46aLariBQ0As6Di26ZL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4835
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: jMUu7t8nHUxNaYIzlM75-9d3LC3wSKDj
X-Proofpoint-ORIG-GUID: jMUu7t8nHUxNaYIzlM75-9d3LC3wSKDj
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-18_07:2021-08-17,2021-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1011 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108180117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> [Mon, 2021-08-16 22:09 -0700]:
> Hello Andrey Ignatov,
> 
> The patch 46f53a65d2de: "bpf: Allow narrow loads with offset > 0"
> from Nov 10, 2018, leads to the following
> Smatch static checker warning:
> 
> kernel/bpf/verifier.c:12304 convert_ctx_accesses() warn: offset 'cnt' incremented past end of array
> kernel/bpf/verifier.c:12311 convert_ctx_accesses() warn: offset 'cnt' incremented past end of array
> 
> kernel/bpf/verifier.c
>     12282 
>     12283 			insn->off = off & ~(size_default - 1);
>     12284 			insn->code = BPF_LDX | BPF_MEM | size_code;
>     12285 		}
>     12286 
>     12287 		target_size = 0;
>     12288 		cnt = convert_ctx_access(type, insn, insn_buf, env->prog,
>     12289 					 &target_size);
>     12290 		if (cnt == 0 || cnt >= ARRAY_SIZE(insn_buf) ||
>                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Bounds check.
> 
>     12291 		    (ctx_field_size && !target_size)) {
>     12292 			verbose(env, "bpf verifier is misconfigured\n");
>     12293 			return -EINVAL;
>     12294 		}
>     12295 
>     12296 		if (is_narrower_load && size < target_size) {
>     12297 			u8 shift = bpf_ctx_narrow_access_offset(
>     12298 				off, size, size_default) * 8;
>     12299 			if (ctx_field_size <= 4) {
>     12300 				if (shift)
>     12301 					insn_buf[cnt++] = BPF_ALU32_IMM(BPF_RSH,
>                                                          ^^^^^
> increment beyond end of array
> 
>     12302 									insn->dst_reg,
>     12303 									shift);
> --> 12304 				insn_buf[cnt++] = BPF_ALU32_IMM(BPF_AND, insn->dst_reg,
>                                                  ^^^^^
> out of bounds write

Makes sense. I'll send the fix this week. Thanks for report.

-- 
Andrey Ignatov
