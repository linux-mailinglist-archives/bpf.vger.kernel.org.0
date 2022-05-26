Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B66535176
	for <lists+bpf@lfdr.de>; Thu, 26 May 2022 17:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347167AbiEZPbh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 May 2022 11:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbiEZPbg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 May 2022 11:31:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418AF103D;
        Thu, 26 May 2022 08:31:34 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24QEGcvL029091;
        Thu, 26 May 2022 08:31:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=lucUAwZ6pY/m/Ot7Z6cq9CKD+20TBs6unbAK8JDkxPk=;
 b=T8nDmCEnJo2fQM6ox6eTU/84NUpYqzI29z6m2CG0yv0U/JIZZWgkBKgRjbeA3cSGITXy
 zCPtVjkr/vY5v87quD6ge0UI6cf6zLma5h91t85ocCJry747M44d9qoOHAce6LEUtdWE
 Os6XFdgH2bCzvZQdMIyo65XAyPi17H+mO/4= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g9puaqm77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 May 2022 08:31:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZ9/EcN+BShG6b15fgyvcvDKFy05Gs2YuYAtqgMDwsieOunvuNjRAMPSLrMxjvtMG6R7SlwHnp+uti2qojbKg0aI7Yo9UG9v6al8fTVWqEOIdkck0buEKJnywcN8GlUZLMoND9BLLRxEcB9qkiaJNzUq0GPph1+kNw/jcxW34tpf84Bm0lygCvKpUGnwsNjRHknUr8nY/xb2cLGOLsC4lG1IKpjpwDRbjtKC7aBT6VGR+7/ZYwyInAQig/6jcyMk+ctAeDw5w60vtcMUwJ5DB2r4Fq9qaHmuwyl0nDmu4PWT4R6jJwK3/FUdIjkchRMUaMIZ7tNiG5T7CY3GvaJreg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lucUAwZ6pY/m/Ot7Z6cq9CKD+20TBs6unbAK8JDkxPk=;
 b=kA/5YF1lNxtuc6bq3pBY98G+WYhlOm4te7/FZTi7Knnn/QBrSiTMoIMLYubvpLKoZnlf1P8k/vxPJ5Bfvx2XE8++TPsOcmZV0xGU78zGmMJrXxu0CqsnE3Nwnq3CJv6Nj2T7IEbm3dvogLQpwctWp4iQAESvbEXG5c48IJnpk13ZqxhBNPEZKKrFlufcDzf200vaZyT7HlmgJZZZaejGow4XUqQhkv8vqzcPw65a7l8JL6cN8RiDlUM3x2yy8O1w1jEzsQKRo9SezxfXSQslGJN8w15O/BUIkohmsc4t7bL9l5wXSfRJtUtcocCKD4T2y2FGpd50Kxv6WxWahPdTaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BY3PR15MB5012.namprd15.prod.outlook.com (2603:10b6:a03:3cb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 15:31:13 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::fde9:4:70a9:48c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::fde9:4:70a9:48c2%7]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 15:31:13 +0000
Message-ID: <67e7906e-3f93-a979-f534-bfe7199f843f@fb.com>
Date:   Thu, 26 May 2022 08:31:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH] bpf: Use safer kvmalloc_array() where possible
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <Yo9VRVMeHbALyjUH@kili>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <Yo9VRVMeHbALyjUH@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd9ad1ea-5f6e-4996-a510-08da3f2cc45d
X-MS-TrafficTypeDiagnostic: BY3PR15MB5012:EE_
X-Microsoft-Antispam-PRVS: <BY3PR15MB501271F43C1ED8F305913E3FD3D99@BY3PR15MB5012.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z/Aw6u1g0vRySPVp9U1AgrX7RzWq0PHXF6+onW1uy66Dfdz+C+FAJ4zmkY9TxRDbDerkDajRyR75WwfcwHFEVrY1uk8VPY9mLAI+syNb1mqeJoJPzXespSRwsKoFl4Wwb/O7i+38PlFjEHz6UUlZTRiq1uzaFyZlWx+4XKbzrctaPCK0XzcvU1vDQScRs7Kra0or6cwwfDjLp1lN5N4VSWksvfjLVr2XaBZTvupuBIpriJbv3xBvWHifZWQq6xkn7bDJ7dZnLjx0RPbNfS3FCWhEzrWSrCf2SUodDbsGepCv9KWxp71QV3TT3j/XmH44qJ5DARE6HlkFmBgs97YXE94RH8bdIvfC3NlCSEq+qcUY4rdftHbpN/FXEojezJUsQFd1Vb1wKPeLPeIEAihXv1nCOFcoOWOdHJ0/l9JKR0BOW3Ntom0x2kae5m37ZPAU73bu91u1atx3JU4iAx8Zl+nyLpUB+Yqt/6kMIsZuDMnvpoQUeQ/YLm0jDd+Z2jCok1MZrXXVNKirWvbq+dlKUHhPPX3pTaSfGEYWsP92W9d+zU1/Zy2180JXeulaUHPwG5T7SxuhwwH+UI7bK5ceKAx5BcxeBPXyAV1sgcuS7la1T/nrLOAAlwEkE9N3YZFAHEPhJ0hyJNEJ1INbFjQPNKNzNM9i6un6KE88jmfW9G2X2Ufz2nlJCCl4eMLLefmSYbvpz3EAEO4CQzHFEl1R8kCQ0WMVjpN74P6Oc8Z8qQe6kw6TizJH/NQD/1OIcyjqy0HrkZcXwiTAt4oBLchMcDAjCIU1S9iyp0/U30fL+wElmdoE2QAxV0S4El4r/YMM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(83380400001)(54906003)(52116002)(7416002)(86362001)(36756003)(6486002)(186003)(508600001)(31686004)(966005)(31696002)(2616005)(8676002)(6512007)(316002)(2906002)(8936002)(66556008)(5660300002)(66476007)(53546011)(6506007)(66946007)(38100700002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3p6NWlUbjFYSlI1TkFVeFFFeldlT0NhNGw2WDJLYXZaNzZxd3pCbHZDQVNq?=
 =?utf-8?B?OHJ2d2dTd0hRejFiOXdxc2F6OERoRjRMeWcxMnNPQmQveEJoZmszTjZycmR0?=
 =?utf-8?B?elhxZC8xYWFZV0k5QmJqL2swM1hYU3RIdG42aWZUVDVmNW1WSlFxMldkU3VR?=
 =?utf-8?B?Z25OeFI5eit4N0hxZWNyVlJTNzVERFdZd3J0dE0zemh1d1J0eVpTc0YrQmJ5?=
 =?utf-8?B?Wko3Y0laZWxWb28xSGJPYWFkYzhWdjFneWNiWnNkTSsxS1JxYzVNRW9teW45?=
 =?utf-8?B?M3h3Vmp2bmRiMDBXcFUyT0tLQ1d0dkp1UVh5WVZ5eWwyK2JNN2dDdEhLYzla?=
 =?utf-8?B?ZW04cTBLczAybEcxaDJkNXE3L0dVYXFVakJ6MHErQUQra3ZaWW8zeitNaW5G?=
 =?utf-8?B?dWFlcmdXRTlHczVyNTkwWnM1NXF4TTliMkMxNUhLOXJTVU5Ub0l3K0FsMXNF?=
 =?utf-8?B?bkNVUStlK0tIY3FsV2ZGN09DQkpuM1F1RUlySG5VK3dvajJRTHJtcmYyd2JH?=
 =?utf-8?B?RmpOZ0NMbEZlcTFpRmNoQTE0UklrdGFoRDdyT1ZoWGFmbmk5VWt1WHp6dERj?=
 =?utf-8?B?ZUV6NWpKdDcvanpNbitHWnAyOGNwbFBTT1hlMDZQeDgyMG41eW91NHBLWmRq?=
 =?utf-8?B?cXpXZWo0aWh2NFl1S1E1MDZocExKWi9KcDBhRG5SSERhM3dyWSswZy8zWGIw?=
 =?utf-8?B?OUthN2hWL1JIQ0c4L2J2aVBXLzM0TXhSQ3FIckp0cWxGV09FcGREdzBWdEFq?=
 =?utf-8?B?eGdwZ0NTWUx3UWlxeHZsZmNranZVNStLQnZMc0x4UFVOTG9OTU1OQkRxTDAy?=
 =?utf-8?B?MHlkSHk2NlhCS2Z0bkgvcFBzQUtoVzZwaG0ra3Frc21YUTdlYXpKZUlNTHI2?=
 =?utf-8?B?Z2pOVDRzL3drUTN1WWI2SDd4azZTU28vdmtQMlE0TkJRNnNDZnpacjd1dUlB?=
 =?utf-8?B?N29UZ2VRMzhVY2pYTjdKZUhlNm01VVQ2WkVnaVQwb2NVams4SWQxekJTWXlP?=
 =?utf-8?B?dGVLV0o0Tko5cHQ5U3ZoVVoyQnExREV4d3poSDJsbDFVQ25LUTd3UU9lRzZM?=
 =?utf-8?B?MXh4QUI3dHZKWDFrOG1tSTV5SnM2UXh5cUl5K3BBckloc2RpR250MExJVXVP?=
 =?utf-8?B?UHFmMEJLNHVrUEszSzV2YTNnY3NWSWhNa0J0MWNxa0xvaGNRRmNMNnlQdFRt?=
 =?utf-8?B?NkVEQ3hvM1dyVVlXVmNvbWFXQUI4MHJvNXpFRmg4QmJZaGI3bUR6VzRQcFZI?=
 =?utf-8?B?YnlCdVZ0a2lqZG5hS0E1Mnk3R2F4YmdqWWJORnBmWUhaTk4vU0Z6cGVjTnEw?=
 =?utf-8?B?c0d1dmRzUGNKYVB2aEJHaDkwR215Q0JsNE5GWTdyR1VGTmR0dW5BSDM4T0xS?=
 =?utf-8?B?M1lPUDBib2FSQWowNEtSU2dtTXNsVTlnNFdyOHZsUTJ6bEhvdDVqUWdHWHhD?=
 =?utf-8?B?TXJGTzRsT2tuSHgyNXFKNHlVWHFaMmtzb0VsU2dya2ZXTjVMWDQxem1peTI4?=
 =?utf-8?B?RVBnNGt5Ym5YOEdnYnJSa3BFV2ZwVVExaWk5d3hTbS9uWkcvMXA5MnFKakRi?=
 =?utf-8?B?a1lNR2w2ZTk0WWJtNXA1UW1EUW83N21QcFNsOWdNeGRyTitFeURoVXh0MVJz?=
 =?utf-8?B?SWpSUSt5bWUya0lJb1Z0MldHSFFzQ0RDRjhHSFRHS3VpZHVxY29oZC9NWXNX?=
 =?utf-8?B?eUk4UmRoRkRQc0lHOWEyR01GVEhFNG9FS01BUEpOanVTVHBHelNKSXpCQjc2?=
 =?utf-8?B?UnhpZ0t5Nk00b0pEbnVWWGRhaTArMkh1S0NRZlBMTjR3S3BhcmpVbjM4ZDFx?=
 =?utf-8?B?SUszMlZnSjZ5Y0t4ajdYOEJPV2JwVkRuYW9iNHdhYlVjOCtVZ0NKc00zU08y?=
 =?utf-8?B?VVNsOWRpWlR6UkVQcjBSSlBRcVJnWXI2SlNtSlp6SWVOcmpVenppeW9KNVEz?=
 =?utf-8?B?amlqdDloeHQ4UjZIV0NETmZOV2MvZVYzM3pyQzR3SGNlME1YTEViT3dLb3h1?=
 =?utf-8?B?N3ZrOEh1ZTR2SlJicEtHK2NVWFdTUURDZ2pJd2dLTE5zci9iYVc3ZHZCZFgz?=
 =?utf-8?B?WmJvMUZlLzl1emtJazdab1lGcnN3UmQwT2NMRzh5SUFvMlAvNjlpRlhuRUVT?=
 =?utf-8?B?QjE5Y1ZYUEpCR2Z1OFpKdWQrVi9jaEVwYWR3LzUwUUlFQWh1Z2VBckZYT05O?=
 =?utf-8?B?ckNjV3Bncncrck5MMDBGZjFsVGJiRlFtSHVJdnd1R0Yvc2MrUGNZUXl2RGZ1?=
 =?utf-8?B?cGhUbjYvZEExZ1hJZEI2V21RUW5ZTlN1bUlTN3did1I4MFRmaW14Vkl0M1BT?=
 =?utf-8?B?ZXhSODhDcldOWlNhdWhkSWJ6cUUvbVBTNkJqcit1clJxRmNlOUhPd0l4Z0xZ?=
 =?utf-8?Q?WqC5aG6kor4zcIbo=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9ad1ea-5f6e-4996-a510-08da3f2cc45d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 15:31:13.3803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Yr2nqOO00F0pm3hZnFP/8VKlFnJdw8d0Um2x+DFiShUOvmjei4aVcmV4XCRfs1y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB5012
X-Proofpoint-GUID: mE_YPb-seQ9PtAv-aanwNINEzs2kEy1C
X-Proofpoint-ORIG-GUID: mE_YPb-seQ9PtAv-aanwNINEzs2kEy1C
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-26_08,2022-05-25_02,2022-02-23_01
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/26/22 3:24 AM, Dan Carpenter wrote:
> The kvmalloc_array() function is safer because it has a check for
> integer overflows.  These sizes come from the user and I was not
> able to see any bounds checking so an integer overflow seems like a
> realistic concern.
> 
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>   kernel/trace/bpf_trace.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 10b157a6d73e..7a13e6ac6327 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2263,11 +2263,11 @@ static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32
>   	int err = -ENOMEM;
>   	unsigned int i;
>   
> -	syms = kvmalloc(cnt * sizeof(*syms), GFP_KERNEL);
> +	syms = kvmalloc_array(cnt, sizeof(*syms), GFP_KERNEL);
>   	if (!syms)
>   		goto error;
>   
> -	buf = kvmalloc(cnt * KSYM_NAME_LEN, GFP_KERNEL);
> +	buf = kvmalloc_array(cnt, KSYM_NAME_LEN, GFP_KERNEL);
>   	if (!buf)
>   		goto error;
>   
> @@ -2464,7 +2464,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr

For this part of change, there is a similar pending patch here:
https://lore.kernel.org/bpf/399e634781822329e856103cddba975f58f0498c.1652982525.git.esyr@redhat.com/
which waits for further review. That patch tries to detect the overflow
explicitly to avoid possible kernel dmesg warnings. (See function 
kvmalloc_node()).

>   		return -EINVAL;
>   
>   	size = cnt * sizeof(*addrs);
> -	addrs = kvmalloc(size, GFP_KERNEL);
> +	addrs = kvmalloc_array(cnt, sizeof(*addrs), GFP_KERNEL);
>   	if (!addrs)
>   		return -ENOMEM;
>   
> @@ -2489,7 +2489,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>   
>   	ucookies = u64_to_user_ptr(attr->link_create.kprobe_multi.cookies);
>   	if (ucookies) {
> -		cookies = kvmalloc(size, GFP_KERNEL);
> +		cookies = kvmalloc_array(cnt, sizeof(*addrs), GFP_KERNEL);
>   		if (!cookies) {
>   			err = -ENOMEM;
>   			goto error;
