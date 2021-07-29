Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306A93DA9A4
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 19:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhG2RFG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 13:05:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59860 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229556AbhG2RFG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 29 Jul 2021 13:05:06 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TH3MnR020275;
        Thu, 29 Jul 2021 10:04:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=hYHB4ofhLyRr+hX9PM3seUtQzSUwwCPf1VuDAm21FxA=;
 b=YUksqu1Yy8sLiP45BKKNh5H3rD4mGTWjdxIW/nnnjRbI4RFKMZdkQ1pa1ur/teaod0Bh
 8UJh015pueb3MEqqqt/e1qjOAIalMuMQt28repnaGTBeY17NKgWBlOQcNShaHOHPd4t4
 3Cb031W1XVgJwtqu+Xahv53CjppmZIoc324= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3a3ecnp922-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Jul 2021 10:04:49 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 10:04:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvqzRZxaEbQaoJUjfGQoBY0T4lEZj5RA9OKpYJz4MwPLxA6AwXLrXN8wkkqAH3yGkVYMGGgf0DVWJHHMnFFnmDhdfEM6AwvG8aAr0SQYGLIaM/l6WiQqAZK3kfqCFVRaqaCuyv14XEFMHW9HIWj29dhJW/bhwPK+2QOSJYUKhGbOylAN5HmNjo2NFFYyZxx6FnVZdUKpn41QnjLLs8BHDxn1xsiiep0OmR2l0yU0nAEc3EQia/RxDTKS9yxGxymj6fhPXSTIqWM5uN1MAJ+vKjUqL2K9s7gKSe616e3EqGcLqSrTCR9qFugnhf1dPkaXPfpa2ODy7qDx9PWcFLwoQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYHB4ofhLyRr+hX9PM3seUtQzSUwwCPf1VuDAm21FxA=;
 b=AJ+P2mPhz87Id6bJo28LcbrsEFtBogEfzjXurOw2E6iRCszGndMls6uOzC0/AfTtFwSNUPMtohyocrmu7RK9Uc/xrPxcJp6lYJDrm3UmDMPjTy1nX9mmFTK+9dnRxAvDN4KCPXuY3tL6Irq3avR2L8VXP8sZbKf8Rp+sUiB1wPTOkjs2pXsaPZXaaA85SeDMrhXYqW8UV0anzIXDKbeS9LGmP437rvQH30VP29scTEIQbstogEI+Ck/dGR6jZx96AoRvDIBYiFUWi7JqDdFAXVUpN61UHK7E/e2JiyZQohpfzB2Z8w7kuoiz0QV8DfoOHP/fNvZpsHw454cG97GPXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4642.namprd15.prod.outlook.com (2603:10b6:806:19d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Thu, 29 Jul
 2021 17:04:47 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 17:04:47 +0000
Subject: Re: [PATCH v2 bpf-next 02/14] bpf: refactor BPF_PROG_RUN_ARRAY family
 of macros into functions
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Peter Zijlstra <peterz@infradead.org>
References: <20210726161211.925206-1-andrii@kernel.org>
 <20210726161211.925206-3-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <75d48e52-7f3d-d657-db91-1e291b9fa493@fb.com>
Date:   Thu, 29 Jul 2021 10:04:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <20210726161211.925206-3-andrii@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:a03:338::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::11d1] (2620:10d:c090:400::5:81b5) by SJ0PR03CA0174.namprd03.prod.outlook.com (2603:10b6:a03:338::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend Transport; Thu, 29 Jul 2021 17:04:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 904fc33f-00eb-44fd-c33c-08d952b2f82a
X-MS-TrafficTypeDiagnostic: SA1PR15MB4642:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4642BF33048D893D82D1FFB7D3EB9@SA1PR15MB4642.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F8ItLtfaZajs1SRKMOzyPPEEuULEdK3/S0Y0j2helCTxtDwjXttiqlL1sr12NcsPdzOnrh1YP0YcvxiGNA76CzIaHLTTNPyfvB29WNeGPGTQPKXO5VeCcp9rHGTagkJUP45XbLv6Seip8nnX/3f9uJaf/ycEVaSLBwE82OpDekTYP3Y9EmyJ7TwB86XCuFfmLgR7Fd+SeavAPeEQw1LSmysO8bAc3MiRbyRDVlN7gagQEV+Wz+YATB1uVS9k6Lg/l68NgexdGu/0/eMFH45SYEI0xI+PKJJW8yzR7KQuEwfZQk7B8bawjhc/6gvCgQLQ9xfOMMJDBEesh5RXAQFVo+GHnsnMMuYUP6uIn9/IacGHNHD/S0FvpxbhaTsXawEaibIPho0wKD6QusKbKJRFGqkcAuA3faTW96hCu/fuPdzjmH31Vuhkl7UyLCE/B157gfu1F4JmspBE1IXfdDSuTTWU4+Zw/V8lP5Q09kYH3OPl9SzKg9HnFB/7Yy3dRGFfKg3MwkwNixY7u8C4dFkAlzRn3PjGoso2rJ5B2+Z+Lz24iMAW/OFRou7MQh8df8ecDaU9kejXTWltiSpv6xGILa8tyxemXQZhTxWTmTYC2K+phHKesmLRyqNDvmY9gVntLn0ist8nELTScgDETZ75a4pePnUL4O5q5I4eeoqV1rRGVS5aMKb76PQ8rQ1ycOFuIVMs06eZwnUsyBWd/te++BZsN5OJ1buJgAuBato08ZKHxHyKjYHtzka5pwzr4qSx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(66556008)(36756003)(316002)(86362001)(66946007)(186003)(66476007)(4326008)(2616005)(31696002)(31686004)(2906002)(8676002)(52116002)(53546011)(8936002)(478600001)(6486002)(38100700002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3ZJclZSdGNBSTloZGYzT2tLN2dyTGt4NjgvQ21aTGNaOFhsdFJ1RWNVM2ZO?=
 =?utf-8?B?VGtXQmQrcmV1RGZGSldKM3VEZzZUTDJrbEVPVnZTd01vbkNiNW9zYmpVYXh1?=
 =?utf-8?B?MmZrdzUrVURYLzh2cHZPUlRaRzMrekk5RHZqRDNDT09ZMFV5K0p3RTJVaTdC?=
 =?utf-8?B?aHR4ckhTbTQ1dlBYL1gvN3dXRmMrc0hNN0FiQWNLeHA1b1JzSS9yWmhwTVRE?=
 =?utf-8?B?SWdRbGQweU5kOVVqY0xaNWZ1VERJVEFQU3BuVTNxdUdTcmxGbm5zTGl5WC93?=
 =?utf-8?B?MVZva0NGL2crWjQ2amduQlJNTUFPR0hQa3l1WGQyNTlHK0FDemcwTnh3NGJE?=
 =?utf-8?B?aE9MQnJGUUQ2TVVXRDNFSk5rOFRNRnpYWXpOQ1JjaDlsNVh4VkJhNWN1QVM3?=
 =?utf-8?B?SUlWaWpwVGxHK3RKTTk2YlpRaXJpRzNHbXBCTll2aTlBYUhwVUlJVTlWdWk4?=
 =?utf-8?B?Y294aG1rUmh6bXZrNm83WWg5dHlVK28xMFZ4ZDQ4VS9NeGp0LzFWL0ppRUpa?=
 =?utf-8?B?WENqK1VWRk5ob2czaDlzNDlXQnNkV2VwbCs1dGpPYzRIR0M2NkRsSU53Rk11?=
 =?utf-8?B?UHdGY1BGOUU0cmswMlVLUy9kUXJ3ekkwUm0zc0Z2bnBwZm1Pa3lDNmlJZ3FF?=
 =?utf-8?B?d0lBZjVGMlhwQ05VTVhXaTVtUkduRGJMOGIwcTZTbU5VdEV0L3BRUGdDT1Fj?=
 =?utf-8?B?OGFZbkdGdkVpZmJ2cUVrR2ZvU0lTT0g1WnpmN1E4WFk4UlM2OWM3VWp0VWtC?=
 =?utf-8?B?dEg0MDFjbHZ4OG5vejZ6MnMxR1NodXFyZWFvM0dIWG5XMkRDS3lydm1FVzd0?=
 =?utf-8?B?ZHFPNXZnbXB2QVNrdnlBNUhCZ1lySm05MDJqazkxS0tQVkR4czVSb1EvZFcw?=
 =?utf-8?B?OFM0Wk00VVRpOVNtS2x0Q05rWlAvR1JsU1gwdk0zUDNPYlN5UXpOb2VPeFpE?=
 =?utf-8?B?Y2ZDM0VTcmFpTEtNNGVNaXllQk5oVm1lb1NxTWJxT1dhOGlnRDhGSnY1Yy9O?=
 =?utf-8?B?Q2s3TndPVWZieXcvb0VEUUhIcHJBU1ZWeGdENVMreFo0M1RuR0tJTmRxb1dF?=
 =?utf-8?B?VExBQjQ1OHQ0TGcvR1Y5ZFFpSkJRRWFKK0VvT25JWG1NdGhaNU5HYnBNWFR2?=
 =?utf-8?B?aXBTNnFlN0FCSXo4MlBuYU9HNlZhTTc0cVB5clVXQVZiME1WaXR1VWpXZEJU?=
 =?utf-8?B?OHJYdER4SFhvVUxCWlA0Q1Jpa21zWmpNOGV4cVZRajh4Y1d3NTFKVzQxZkFY?=
 =?utf-8?B?eUNZcWtoekJwem53UG8zK1k2RTZpSnE5dWFGaFcyelFtNE5XVnB5bmFGeTNa?=
 =?utf-8?B?REZCeDl2ODE0SjdvVjlGN2FHNFFnWUxjQjErYU1VTUs5VEtHMCtzN1phTVdU?=
 =?utf-8?B?NjBkZzI5RlNWamJvdjl0aGxwL1hvUk8yUHpSU2E2djZ6TmtnWU9SSDVXNDhG?=
 =?utf-8?B?U0FHb0M1Y2N6UjZWMm4wVmovb2FMempqSGVZbW4xUmwrZ2hjckNvaWtjQlpR?=
 =?utf-8?B?dm5jY3Zrb0g2ZGdqb3AvTTYwR2RpdHdodnFZc1JJNm9CbThNTzZLaTlVaWJs?=
 =?utf-8?B?VFZscUJsT0lOdHpNMkZhbWJuUGszRXlKa3plTm9yR3lyKzRwa2VKUVVvS25y?=
 =?utf-8?B?aTdpajZHZkM1d1QxblpXZ0x6cVEvYVVYVGozTjZFV3NvZ0NZRjUrN0UrYUpX?=
 =?utf-8?B?QVpOSEhFSVpDU2lkWFMyYytBTkRpc2xGVjlRbzdBVzJhU2cvMU5NMW5DM1Fs?=
 =?utf-8?B?eFZOcVpOUU5GZjFjTFdRK1JtM090c2U3dWxYVktCRnk1R0JTRlV2L1BVWmFQ?=
 =?utf-8?Q?K50/Ahgb2URvl7in12sUa9scmpBQ38x667Eeg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 904fc33f-00eb-44fd-c33c-08d952b2f82a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 17:04:47.2163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lniDXe8pZx1mIys0PQQ+AvM/7Rz+liakKKpvZkr3xIvs93M1MG9qtJ9rfjTt4fvK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4642
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: Fw75s-w4nE73FRMF9b_DLikKLLTQRI0_
X-Proofpoint-ORIG-GUID: Fw75s-w4nE73FRMF9b_DLikKLLTQRI0_
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_14:2021-07-29,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 mlxlogscore=945 bulkscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107290107
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/26/21 9:11 AM, Andrii Nakryiko wrote:
> Similar to BPF_PROG_RUN, turn BPF_PROG_RUN_ARRAY macros into proper functions
> with all the same readability and maintainability benefits. Making them into
> functions required shuffling around bpf_set_run_ctx/bpf_reset_run_ctx
> functions. Also, explicitly specifying the type of the BPF prog run callback
> required adjusting __bpf_prog_run_save_cb() to accept const void *, casted
> internally to const struct sk_buff.
> 
> Further, split out a cgroup-specific BPF_PROG_RUN_ARRAY_CG and
> BPF_PROG_RUN_ARRAY_CG_FLAGS from the more generic BPF_PROG_RUN_ARRAY due to
> the differences in bpf_run_ctx used for those two different use cases.
> 
> I think BPF_PROG_RUN_ARRAY_CG would benefit from further refactoring to accept
> struct cgroup and enum bpf_attach_type instead of bpf_prog_array, fetching
> cgrp->bpf.effective[type] and RCU-dereferencing it internally. But that
> required including include/linux/cgroup-defs.h, which I wasn't sure is ok with
> everyone.
> 
> The remaining generic BPF_PROG_RUN_ARRAY function will be extended to
> pass-through user-provided context value in the next patch.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
