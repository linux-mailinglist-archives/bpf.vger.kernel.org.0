Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B604843F2F1
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 00:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhJ1Wtl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 18:49:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:61192 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231162AbhJ1Wtl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Oct 2021 18:49:41 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19SLA8AK019958;
        Thu, 28 Oct 2021 15:46:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=v6Dk2a+7QnJoeQ2Ymx7ZQTcjLg26NbnhHdVl+vxui64=;
 b=MICMJ63jYzqQ4/6v0SuPh2BJamy2ChJIJENssPVBBmkuqpYpY02K2iK3TC+qmbVruU3i
 rQIQQWfT2SgvjVQnY+ubHal3aDhTtrp3h11UFNGUtI5acejvObUlIt3IfNEu78vF6zvE
 A28bPNLhAumF6sHKs5158VWb3OT63EsbNNM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c03hk0k67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 Oct 2021 15:46:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 28 Oct 2021 15:46:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNAT4KBPMFkAbk4hraZyzMVcMULxC36akcUQ4X7cEeTgxnb1sLVdulKM1b29J63zarK5CGyyr5S2JOP0Ei9u6LSCoL6iQ8MPArYtlGgKgKwIG6YtODF2jGftAUtJlFDGWdVPlE3fp5ec4HLPygMQTX+ktfqvtFWJ2Emn3L/FlGLlD4ZSlKli867TFZ+6WcsRAkO0KwE3OPY+nQcMRDKOBawS7ouN0iwlwDwTbAC+qbLs8I/6brSnJLafeyAxHKVB7Lcl1KRj8jVmuLrLbhV90uIvisL7At/6S1kn/MTAfZZjANIHR6J6EszzY+SyJF7PZnv80+ESDx+A07llyd/VNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6Dk2a+7QnJoeQ2Ymx7ZQTcjLg26NbnhHdVl+vxui64=;
 b=hbDBVj8Mn7hpUj9Mrpt0bM4qSMbaaiwpKz3IygVHzdbqTTGesLTFOqNLZs/GpnzJ8wGo3bCpwU9G1YVMrFuy/PusfvkJBw/gf6MlTkLCb2W/AGNA4PdYA8AV+dxDyFstIHFgC73re+A53q00rza5fANAdFTNn8buJ1t4B4SM/NmzkufMzbhHUXFudN+HvVX7AoHLyGP4Lm5yFVzDgys/loKvTiSGdyMLN8t2WPwXb0Hme/v7n8aTwuCcNTBj47H03b/RjxRMsQltIQh+1pYut35HqhlDDLP2gYyFlLnPYa9zL9HjxyO5mNAPOu6FSxE+poOFMH+cB6u0x7/eNuhl8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SN7PR15MB4174.namprd15.prod.outlook.com (2603:10b6:806:101::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 28 Oct
 2021 22:46:57 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160%7]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 22:46:57 +0000
Date:   Thu, 28 Oct 2021 15:46:53 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Florent Revest <revest@chromium.org>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kpsingh@kernel.org>, <jackmanb@google.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Allow bpf_d_path in perf_event_mmap
Message-ID: <20211028224653.qhuwkp75fridkzpw@kafai-mbp.dhcp.thefacebook.com>
References: <20211028164357.1439102-1-revest@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211028164357.1439102-1-revest@chromium.org>
X-ClientProxiedBy: CO2PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:102:2::17) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:e99c) by CO2PR05CA0007.namprd05.prod.outlook.com (2603:10b6:102:2::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend Transport; Thu, 28 Oct 2021 22:46:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dab10b6-1183-4721-122f-08d99a64d87b
X-MS-TrafficTypeDiagnostic: SN7PR15MB4174:
X-Microsoft-Antispam-PRVS: <SN7PR15MB417439721C774A71495A980AD5869@SN7PR15MB4174.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wANHHn/VQwm+FiSmdtdqzqhLUdM51VP62PTVdG/hYxrvh39axy7uID5rOTpu1uWcqVu9jJf0VHtGuavrhVfInPYkKPix64syrpzW/FDuleBXrV/iqd0uiNErfXNA7GWakvL4FdytxbTlGDXoDqTsm/IGRUBaZsEsOMTfbV1p2BbST7XnF3cFcEJ980DNffKlUnlnsnlARvRxQC+FbzKxrOAq8gJ9K85GX5/jL7/xRHyD+dJ2MXV+a/57uN9gKv7Ghu4Ef0cICfpwxuOoLVtfVNukqpx934hkj2eoP7nhAepPMSNL3b/3S+K83Bw3IZ0dPmJ3dcQ5yIQ8sUSXMBvBgb6J9m5BHR7ELy86RedYpEJYnTdKrMzxOAPcSLFyfNihMsLWdyZhYoBegFsCqS2HsnaD5vuPU1cv+3mJje2CafvoWLTuIQIAVboHLY1dqhKBf3tvXdeNSCLsHem2YxzC/kb/mwkwXsqmh2W0zRKDZ18V0laElOIYvDyLjbrcJih0ccSXW3LWtTBt6Olf2YE/AUELqEhab5Q02eRjZXDeCFeDXaN/4mSoYypz9hQoC7pWWT6eFz0gOTspUNV7fLN1ig+dh+KVV/cbUkHp8PGSbesBQZBTzJn8EDd8EKVOkhdtz/WWY/DqS9Po724RzhyXgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(38100700002)(1076003)(66946007)(5660300002)(66476007)(66556008)(52116002)(508600001)(2906002)(8676002)(7696005)(83380400001)(6666004)(8936002)(6916009)(186003)(4326008)(55016002)(316002)(9686003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IAzhlQfSj9vsv2HiehA8BAFHeL/7QfSlbpfHSgWgrEjb5ciZckCgSh17R9JV?=
 =?us-ascii?Q?982QJEcllx8B5iZOEOzOUO8zqfZhEnIhgQJ86irPvWZ/f/xkvqSAe7G20Ikh?=
 =?us-ascii?Q?EYDcsU9OMwG8jUbMb35o8amOmQcnRQxcMa8UJ8g9+g7QzKuKubcz+UFSEsoT?=
 =?us-ascii?Q?C44wFC/UxNJXIzz9DZa9MThBvXuOxqZb7x+6pbwxUGfgjGub9dwTaZ0f3y5T?=
 =?us-ascii?Q?HOQQOkUAB3DDSkqAvG5n0pNgiwBicllYDH9khUXZIo8+poveUTwwQ6j8x+1X?=
 =?us-ascii?Q?7niHDdcuxNj5sAhbby4uo+4r2bsY3Qn4uUCd1Z9GcPqd+L7B1DqhbUH8cevl?=
 =?us-ascii?Q?n2QWgd1YuuAXNbZMAvTQ8Ds2ZZzr0lEGXRx/nddOP14Y+R9BN/vh9ErX5z7J?=
 =?us-ascii?Q?g4OXhmSH537k3V8Vto8+yNhOk40RWLTJ0oqCjKKCQ+mkh/UwtbNZLZ0hHjHh?=
 =?us-ascii?Q?yYM10G+hR08bSN9q8ilgV1gBs98ZgRj8eEpxzViHlP5SfedMT8gif5drAKzs?=
 =?us-ascii?Q?iOq34A1b6ezLsohquxHLlGtvT+szO7O6sn1+HcGC6DDN+z9Wt4inMDGWpy7W?=
 =?us-ascii?Q?xW+doqGFWW1TDfQvMJyG8Lrjj4mkcarLWPB18PYYc5l151OIozPUFvvYsrqv?=
 =?us-ascii?Q?KPet36tBc+mlrGdiVE+uI75/VUjrFOpNrHT07RVmJ7thYgr2F8KY4uUFK+ZG?=
 =?us-ascii?Q?3RI5AsZbOs/u+5POtywie/wAg67+jnamKI4lGH8+Mpk78whcdihh03VqSYca?=
 =?us-ascii?Q?M+E/r0ABmXzGaED9RPbTMtMRky1GNsuN1H0zHVHTY8e6REEUD5hPds+bwqVN?=
 =?us-ascii?Q?tyr5SiJIhwPZnX2f/38O1LM2ph3WV2F4vk2Lj1wkYgODoI8Y+lW4+ZBVB3hn?=
 =?us-ascii?Q?abPHRV1HJwhD7SuUsBZ/ZhzIzKQwP0HQ5Pkk+gxh0pRGe1ZUrzj64hoEPeHy?=
 =?us-ascii?Q?Sk6vKQBJpT8jylAkowV9Yzuwf8D1Wyas/k77yBGDDJ2y+MwZhbS9yGcKfUg9?=
 =?us-ascii?Q?qcU3m2bDfPM9T7V3sFfn5xdp90X2bnUiVZFFt6WIc6Rj+lgXWxlaed+aTE1s?=
 =?us-ascii?Q?mFfXqdgHKq7DhGJJ9R6zajA9W/ZEpthh/WKbNQQ2TMWZ1TT2LkbZVi71VZ19?=
 =?us-ascii?Q?DpWM26i8DAtpP6JmVqC1Gef1gdS4pbqayenrsdNvDF0HS8PV41x8ZeIXdVnA?=
 =?us-ascii?Q?mdI7W+b26nNWqkp/hE5xOmvqhM3lyttYUuXuF6ZHg+AfffixuExuJOxH2PBR?=
 =?us-ascii?Q?xVexHs6riV7YTvMhaJmheQsGwADM3MWAtsgi9hE2bR2nMTyTDvuF9TW8h1iS?=
 =?us-ascii?Q?jcc1xjhuYq6ca9E3tYvSre1G0Zd2hWVAJdcu6HP1E1URQ0xkFOzj9o1Kobrp?=
 =?us-ascii?Q?J0xAGIN/hPs4G4TLRY95gdZWChiljqQiZqvJx8OmrKgfPb3sfvs01h0+y+ye?=
 =?us-ascii?Q?diHHP0r9RVV4mg7u4qVBaAR0bLfgc+YCF9AwenWVU4bxdEBAxUZdhVnkuUEZ?=
 =?us-ascii?Q?l5EV+x2//hIqm4P2IpI5GAaJzlqjQuc2GvyYOQ26IFf3AddsQrQVPpx0DTMp?=
 =?us-ascii?Q?4PSRbfATRnfZSkFnVtYlmZ73h0cbpwGP+nz6AyvmoZ0n/xadhCdrhxS3hdrq?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dab10b6-1183-4721-122f-08d99a64d87b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 22:46:57.0281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8nOlyGuOpxe8YemfOuBONYt/4vOnkdsINdwreweaP+cvtUXAxUncrewmtbEviuZS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4174
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: ln47yWow61BVtn8zRf_rsOBpGUgDQ89V
X-Proofpoint-GUID: ln47yWow61BVtn8zRf_rsOBpGUgDQ89V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-28_06,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 clxscore=1011
 impostorscore=0 mlxlogscore=983 mlxscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110280120
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 28, 2021 at 06:43:57PM +0200, Florent Revest wrote:
> Allow the helper to be called from the perf_event_mmap hook. This is
> convenient to lookup vma->vm_file and implement a similar logic as
> perf_event_mmap_event in BPF.
From struct vm_area_struct:
	struct file * vm_file;          /* File we map to (can be NULL). */

Under perf_event_mmap, vm_file won't be NULL or bpf_d_path can handle it?

> 
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  kernel/trace/bpf_trace.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index cbcd0d6fca7c..f6e301c775a5 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -922,6 +922,9 @@ BTF_ID(func, vfs_fallocate)
>  BTF_ID(func, dentry_open)
>  BTF_ID(func, vfs_getattr)
>  BTF_ID(func, filp_close)
> +#ifdef CONFIG_PERF_EVENTS
> +BTF_ID(func, perf_event_mmap)
> +#endif
>  BTF_SET_END(btf_allowlist_d_path)
>  
>  static bool bpf_d_path_allowed(const struct bpf_prog *prog)
> -- 
> 2.33.0.1079.g6e70778dc9-goog
> 
