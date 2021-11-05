Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1647445FE0
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 07:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhKEGyq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 02:54:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12932 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232365AbhKEGyq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Nov 2021 02:54:46 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A56JIoe003245;
        Thu, 4 Nov 2021 23:51:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=JWelB9+jUt0ftMJdLGfB9i7oiVFUcgtpTsx3AFpz0Lg=;
 b=muQM1H6TTZjUr6d1glC03svp3wYo6vugtxC5jIzyXdrRr8QUckIjdUMGlJxjzO29R/In
 z/MFa3CMgspwBI4Aoyt3KDg6+s6i9ezr+FNPWApHifaF4zW7rhDU+VWTrV/WQj5dWaAa
 rK91dGR+z08+xF7vvjw2hn3Lx6k/dgYhOdA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3c4t7q1reu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 04 Nov 2021 23:51:54 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 4 Nov 2021 23:51:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IogLt4O5Hm4lgNrFMZef/XMxgROqzUaxwRZ2sHB2K4OZ1fhWTd51o9AK4QJuBPyylC3h3TFlr8pNLrPmlZhbfvlPKpztK50Wc/GiXLVagLCfaMbtfIzGCViwG2v9DGYHr+nkAoTihzFWn7SCsu+aYz44MZFUt1t+0xuY2lL46qUyh3sagrN43bIqZnSWxHeC1SYD1nNovM0XlkKze124fLMR2/eJbAjEO/+6qVw+gMHzwWRqQOq5e8xZoCmfxThqNZFldRr6QDCYa0FMs2s1D2/HFlkA417DYFp7I8yn9Ih10Hxl35L31usV+TB3bBOn7P8cj/lMYkfWFiv5D2Iy7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWelB9+jUt0ftMJdLGfB9i7oiVFUcgtpTsx3AFpz0Lg=;
 b=GhdXzWBG0HWnL/QrEWU+q2gnCAXHvAOp66/W7Mrn8Ni/bNSe5CpvoJAHntTYMJbZovFWNuaM4OF10RM/GXo7kJyKch2RlEaMXEIXCwchJERfDOvKJ2lR5jSUe2UwlpJhSL8/JDo+8Amze1VmleaQldlNGHT/3H8LIGn35tgbMhrr0gT44HmI/y5vCUBFpIIfSwG2K7qvP7ddTBUHBKtWU755GLPuNZXBGyoHaXBQIQxjjzqztq8CR5HGNkVMvnE/0Wl+7IOBl6+Pag+bMvBPGEaTYi1ZmV8d3RXLCOVbBPcvTMFKtxJD3VxYfn7hJqSt2/s5d7opADWDMT6i7dxk5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM5PR15MB1515.namprd15.prod.outlook.com (2603:10b6:3:cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Fri, 5 Nov
 2021 06:51:51 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953%5]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 06:51:50 +0000
Message-ID: <b045fe96-0903-6c4b-1509-c43b0c772fac@fb.com>
Date:   Fri, 5 Nov 2021 02:51:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v2 bpf-next 07/12] libbpf: remove deprecation attribute
 from struct bpf_prog_prep_result
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Hengqi Chen <hengqi.chen@gmail.com>
References: <20211103220845.2676888-1-andrii@kernel.org>
 <20211103220845.2676888-8-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20211103220845.2676888-8-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:208:23b::14) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11c1::102f] (2620:10d:c091:480::1:7c65) by MN2PR11CA0009.namprd11.prod.outlook.com (2603:10b6:208:23b::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Fri, 5 Nov 2021 06:51:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b37798d-ce9b-4d38-c1e8-08d9a028be66
X-MS-TrafficTypeDiagnostic: DM5PR15MB1515:
X-Microsoft-Antispam-PRVS: <DM5PR15MB1515A66BA1CFF9AA8C159055A08E9@DM5PR15MB1515.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E6paQlxNSqfl1dayh7Uar4lvqGIW4vrdxhOezJtq2ksUne92Wi6eo7wb+mpTCTD69UTEQYxFVdGoWg8vSsTX/B+UAJWzk0+g1yuA+GrISKdFrtNq8dp7rithhv3YT126aOKiNmjsZuM1demHss/XzMOzzc4oTJx+jFsKP49oMFUF1R8QZLonk1mQq24sKEOplnq8DC3wcPwE3Xexa0CXRtY8Zix0GFK+R79PiorESCmb7Kfb6mQgtslp+B3bS/6hLRqHzskn8tbYxdhz0JMJ+rzh/LZxNdaqgQP3vWmOG5s4azXJN4fmLd7mYbniCSfAix3w1nthwYZLH/2D/XsdHogGr5rMdhGf0hEq8I9c371ipW2C5hsFIfuz7b+sd1/EQG2wLq1wKg5Bz7YrTlhJ+WyucRZPSvpFIZQgT/BK2uIDwwsPRBPQFDIGC2WgiEoowQiT9+0OjZSyOFKY3sopXjd69xca1fI7EeFrlNuuQ3T8OUvfPpnhSCG6VceV/pl6gxwEbtl1yLMs4lrH+zmGI9EA5GFWn2t7HZmHWoEJQrEsiXNSt1pcCNY8xKrWvp5pwUnKnq908CynMP+CkixruHxWq8TQvtCFy0pF0EK0QEK7+aHN+S18E+FWnD2HCx+GjcJ2gtX8krs+jkRSU23I4sqgF7P4UQKNEU4UcwbOYCCG734NgNtdTxY2U5iRGM9X9fHz0OqtA3DiGIJO1krOAASxWqDKlaIPRmRov749JUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(8936002)(53546011)(2906002)(31696002)(508600001)(86362001)(83380400001)(6486002)(4326008)(36756003)(8676002)(186003)(316002)(66946007)(5660300002)(31686004)(38100700002)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXZLMzZhU05OTU8yWjU0ZndETDEwZDV5WEhmb3NVWkdMMkhWRDN6MU0wQmN5?=
 =?utf-8?B?MkxZSSsyRXlkVG1Rd2pHT0lzTWYwTFBSL1dsS0JUWVhQM0c1NEY0NDFBSGV5?=
 =?utf-8?B?K3dKZlFEWEtlVW1JZW5tNzdmMEpmeUx3RzdmVGppa1FYZ2VsRnlzaE1CMTgx?=
 =?utf-8?B?Uk1NYmhsSkFwa2NZaUI3YWZNWGZKSDI1NkNIdmp6RVRxZi9CRjZrZitLTnJS?=
 =?utf-8?B?RkJTZ1huSjI0L2lvOHlaWS9aeDllWHNlOWpvRlByanRMTW0xYWQzdkNYemF0?=
 =?utf-8?B?U3JwTVJPT0E1cFh3ZVZLclh6VUlrcUpteDJFT2dnR2JlMnZTQnhKT2VWUWxJ?=
 =?utf-8?B?VzFTZFlFM0RFQVlJdEtOOXFwZGFmMnBOM2NpNHpnRlpldThXay9xV1BkcExB?=
 =?utf-8?B?WVRhRzhnL2h3QUNhcW42UElJa3c1M0NIK1RZZ1MyMVpPTVpBY0R0SVI2d2F2?=
 =?utf-8?B?akQ5ZmJOMGthZWJHTEtJeDYvcmVuOEM4UEY3c2NJUGQ3bHhUcXYvMmFJUmlZ?=
 =?utf-8?B?WklRUk5UaFhmM29ETFVRVXA4cGpkS1ppTmc5T00ybXkxT2EyUDQ5WEIrRVdF?=
 =?utf-8?B?ZGRoSkNHeXVVOWdnNS9YOGNrWkxCbGFCODVGVVBoU1ozbGc1NndMQ2pET3ZT?=
 =?utf-8?B?TThadXlXMEhPaVF0VTBnVnRTY3BVUGZpdTNOcTF3TmwxYmQvS3FSdGJlL01q?=
 =?utf-8?B?SThpTnhDMjVwbytzb0hPUk5LWHozMFRzNlllYUFNdkxydlBNVno0OUUyekpZ?=
 =?utf-8?B?N3dUak9GN25Pc3o5WHdhUjZIUkJpRkthRDBnRG9zOHFsYkNjdnJZMG12QlBX?=
 =?utf-8?B?clFsYnBqdENhUFFJcFNwZzhvVHcvVWRZMkNZaWZCT01NV2NzdXAvamIzS2pE?=
 =?utf-8?B?VlY1SGNDME5rM1JrTTEzdUtKVzhLMU83VUlHWFRXaHFUUWhjdzNsQnFrNHE0?=
 =?utf-8?B?UTA2S21DUU9SQ0ZuT01pMG10UStKeUlEcDhxTFJ1dlhLVUl6T2JZejRvMHdD?=
 =?utf-8?B?Q3FMSlhtYitibzdGSXhEaEFRd2lIaW5hYU9KY2lCbXBCWGxaSVBHdFJ3QWZy?=
 =?utf-8?B?em5QSWhJaXoweUg4VDZBb0EvUFNlbnB5cDNQMG1SdkhIMDlXRmp2Rnl0OW10?=
 =?utf-8?B?Zk0yU3d6U1BydHhZNXZEbEQrWUh0NGtxdzhYeXJsNWpPVHFXdHNKbmNmTkNM?=
 =?utf-8?B?WTRYMmY2VGF3RkVEQTloSWYydGJVYVZFL1JJc25RSVFRQXA1VXp3VjR2N3V6?=
 =?utf-8?B?RDZhczM4SjV2Vk1nUVp6SWVtN1NBdTNYeU9sVllPTElHekdmaHp2alQyQ3RO?=
 =?utf-8?B?cHlKc296bFZ1Q0p0ZmhndVNlbU82aVZYd2ovWC9pWlAyd3RORHVRYkpLRS9O?=
 =?utf-8?B?aWZ2ZUUwRTFVd1NDMjl4SksxUWNacDh4WXMwbGNJNkFvSFR1UmRRblhYWnI1?=
 =?utf-8?B?QTQxMzRoRlArZm8wTG5RZUNmNmtkSmJnUVFnaTdxMENkUDFwaTYvRENwR0dP?=
 =?utf-8?B?TytJMGsvaHB5V1hyRDN6ajhBSWhnV0gzM0VuSHhWbHFqVHkvUXJxOTJDRDFN?=
 =?utf-8?B?SkFIUUVHei8wYlFQQzV4UElsWCtySUZGbUVaME9Pek5ZN040T0N3V2RRQW81?=
 =?utf-8?B?d20vcGpWRjU3MXl0N0Vaa0w1RHFmd0tibjZYZ2lmMlczYi84KzNIekdRczVO?=
 =?utf-8?B?NnNRWm9qR0ZFdWNFYUk3S1pxYTRvbERleWRXTnA1VEMvQ1pHNkRVNFRuVm40?=
 =?utf-8?B?UmhJK3IyRFFKS3VOWmZJUDNkNUF3NExLOEN2QWtYYklrQS9WL2RzbXluYnhW?=
 =?utf-8?B?THJOMFVoNmVJdjFqeVVDYjlXWjBVbXVHbTBxMk5YaWJBZUZnWGcyRFBXUjIz?=
 =?utf-8?B?V3UzM0JvbFMrZ2wyRmFSWURsVUx3akZlaDFXa012bzRQMlkzcEQzRnlFaXpE?=
 =?utf-8?B?NGJMajJvWFFmYTY2VUlBM0FVTmxYWVJwWUFZTEdBU1Q4OFk5RXNyQVRjU3dX?=
 =?utf-8?B?cXpnd3FJaUh0dGJHaWh6eHRoUC91ZG5aVTU3RzQxOVI2L01ka0ZJckhOSk9K?=
 =?utf-8?B?eG1oYzErYnRCQ2RadFFVeUtOQ1RFa2g4ZDJtbDhMYkZhK3pQL3lSZjYzQUJK?=
 =?utf-8?B?bU5kc0dVUU1USHFFV2RHMlN4Y0FUeVZLM3QreTY1KzBINi9odU5tOUlzdU1R?=
 =?utf-8?Q?7ftqU2pGBjYwp+9YRC1RhUhUwfYW53upBjDfcb17/bpi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b37798d-ce9b-4d38-c1e8-08d9a028be66
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 06:51:50.5447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0YO3bV73/pKybo91A9YTcW6LMPATd1Gc7eSq9IUfMaVmvfsCWsLIB2/QQ5TT0IdHnFiYnf9WB4cT2do07oliw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1515
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: wB1Z_Qj0EHSd5mHqN3WrrItAJC_IAsbl
X-Proofpoint-GUID: wB1Z_Qj0EHSd5mHqN3WrrItAJC_IAsbl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-05_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 suspectscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111050037
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/3/21 6:08 PM, Andrii Nakryiko wrote:   
> This deprecation annotation has no effect because for struct deprecation
> attribute has to be declared after struct definition. But instead of
> moving it to the end of struct definition, remove it. When deprecation
> will go in effect at libbpf v0.7, this deprecation attribute will cause
> libbpf's own source code compilation to trigger deprecation warnings,
> which is unavoidable because libbpf still has to support that API.
> 
> So keep deprecation of APIs, but don't mark structs used in API as
> deprecated.
> 
> Fixes: e21d585cb3db ("libbpf: Deprecate multi-instance bpf_program APIs")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>

>  tools/lib/bpf/libbpf.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index bbc828667b22..039058763173 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -431,7 +431,6 @@ bpf_program__attach_iter(const struct bpf_program *prog,
>   * one instance. In this case bpf_program__fd(prog) is equal to
>   * bpf_program__nth_fd(prog, 0).
>   */
> -LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_program__insns() for getting bpf_program instructions")
>  struct bpf_prog_prep_result {
>  	/*
>  	 * If not NULL, load new instruction array.
> 

