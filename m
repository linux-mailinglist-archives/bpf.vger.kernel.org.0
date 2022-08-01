Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA742586F13
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 18:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiHAQ52 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 12:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiHAQ51 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 12:57:27 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1972D6385
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 09:57:27 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271G9Ixr032177;
        Mon, 1 Aug 2022 09:57:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=7RqP2+V69WYn3s8LBDi0+709bVSNNsx7N0x05vxTT6k=;
 b=qlEtz2JYr/gEFeyJJfoZg25OpYeWCljigVr+dpooZ+ZVj7w6eKyqBOzkEdSmH0P0Rk+M
 bS0BNYcIhrb1RLf/WKmDYhIW5b1haJntMnhJV/SDYA8lBheGRirx/3vP+F9e6EFK+k9Z
 nGgG8j7YRlhD60+G6C9G6QBOjpeuyKct4YU= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hn3y3cbxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 09:57:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwDkQqDwbuzkMjmPvB8Y1/ZnMxuvyIj8MDb1ey7mK+hK/N2/xyqbeAyPhkjIeYGOQD9fcUyTfhbVxNmv55z0nd1rwHPGc/3SyqLbMc6TOOL9qFCRIv7E22TOyg1YpRs4XgvCRCj3VReKgstNdqKYHAeeqNnAxz+B2PTzAQk43b+1NcysiuI+dKg8Hwnrv2oGGW8K7wXn+8dfzd5UFXw62jCafTVPxSFrCXlDKWNdfl04gwIZnrT8bHPlN0Pmba86NsFK5TswUZrMbtgyKA8nF0oRLXrl7Y0p2oBbveqgmFkbDSTo3yFYWImqZZfpLcLMqV1Sj5NHErVo58Je6dxdEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RqP2+V69WYn3s8LBDi0+709bVSNNsx7N0x05vxTT6k=;
 b=AWJsnCFt21kJDHWgZKn/Wkvcll9k3sLLVeE2AZqlOgZLywjIt714srQAX5Gj3puWAbaYCSMeoOkSpljfmSbYqi592xBQDOvg5S8kEjgXa72vwt75Iutj7075pEQRAE8kViumOJtp1Jo+6b5k9U9K+4KtkGFxmm/2uqXLy207svUk8gTePw1Hi2kT+dzF20Yt8QHzhJp/6FXszElNUrKsEXUVQ3ImeCoiHa/Yeskpri9Ec8uYHRrlOjbVr/yFptOpRl+00a9UDgjisQiIW202alkOuR1iSeohrfL3Y07Akp7FexFHmDNh0BmLETg6IM1zVo11X4wZ9MpBLX0DBmSrag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by SA1PR15MB4625.namprd15.prod.outlook.com (2603:10b6:806:19c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Mon, 1 Aug
 2022 16:57:06 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%4]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 16:57:06 +0000
Date:   Mon, 1 Aug 2022 09:57:03 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: use proper target btf when exporting
 attach_btf_obj_id
Message-ID: <20220801165703.hdi2es75g5ymzbm7@kafai-mbp.dhcp.thefacebook.com>
References: <20220730000809.312891-1-sdf@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220730000809.312891-1-sdf@google.com>
X-ClientProxiedBy: SJ0PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:a03:338::26) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6f015ed-6388-400c-e369-08da73dedd33
X-MS-TrafficTypeDiagnostic: SA1PR15MB4625:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0hJIEUz/E0+A8GjtGBpAJ9YhGDBchyn6P7tydJiAZzXtbr5s4ymLlnaAzfO3/VcXJEmF6aoI8H8uLPnCqTGJLzIyZcrJ13s2nLYND+OyRTCAlO862ILiqqlLGxf1Jrh4rUXRkehw3sigMx58K8u++4YfrMPZPIBEP1Ym2MezQbR34ec7p3BaZdM0rdRZWY+IGfnYsPhSw+uiJLjI+aKhLNTbB0jgT12pOiXQclufIv3HqF7MnWTXFVCK4ToiNfJkFJAh3bNxarTub1Kd0sCx3++lDH7c5btPZEmr3xLhOHKZ1hxVklEtQhno0XOYsgVBdJOObe3iimEhWvnoka/tzaytMt17ULiYA6sNDGUDHVA/Xfh8R/XL2nJ+5eCGLjHT/GORkh+NiLrz/mjMnc7RzliL0MKNYKnWG60eZ+Lq8spxU8q/eBvzaDSLjVhRoUYoX4DQyIS1ixN4XoWptJ5UUNnilOf7hmnQdE/iSqbL4LA1J/2T9o61F5nNYHXm42aaCZPeu2aXqU4ZUSXAGhkY75JJLf2lfvMnRLAMi2LTYI/Wa8dcvXNiKm95Tb+oS5wZoKn9ToYkfYukQ5tfYzUNn7J1OTjYuP53fNqHQPIYR2wbBSpPolklwD9C77DWolQooMUiwnhuizfxnj1vxhfS36MXgKfMoBBCsqy0QYqhIUaxd6iAzAz96ZsNBJJO/K7sB0lj9PMuYek9L+TR53w8JNoGlXfqzxpFy81c7lXsSwS65Gst3DSy4c5vFODN77fv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(2906002)(6666004)(6512007)(52116002)(6506007)(41300700001)(9686003)(186003)(1076003)(38100700002)(86362001)(83380400001)(5660300002)(7416002)(6486002)(8676002)(4326008)(478600001)(66946007)(66556008)(66476007)(6916009)(8936002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dk62azUjan8YJaF2ssVU8xI2e9nlIFXhTrrBEtcg4KRAVTfWvEkWfbOnCo0x?=
 =?us-ascii?Q?grkyI5wPkJ8Qy2ElJ5jT3bGNXGt0TQTdnkztooTK7Oi9OxQU8Nln9gH9ZAW4?=
 =?us-ascii?Q?7kTz3HI0xo89ISz7uzDVJx4smU4Su0M9LvU+A71sjVR/yusdXmkDMWWg0kcZ?=
 =?us-ascii?Q?xxTvefoZ1ZS40gfum0HDb4lNQi5RNV8oNow/j3fzjFU1vDiSlh0KrWzkAJqd?=
 =?us-ascii?Q?YfUry/vWfSAc7DxfCCd1uuJCAthwv7jYHewF8lHne8cgWsLU1TeUrkZ8EyqM?=
 =?us-ascii?Q?qtgA/ungoHto/XeC7dzlq4ZFX7phRyrH5H+dyrwPzBBWdqENpQhvDy3TkZiG?=
 =?us-ascii?Q?2nhJfvY8bnfyFh/MJSBa6hllzoVNZ7cW7Mv15Yy+n6W63565VIfwwKe+MNom?=
 =?us-ascii?Q?mvLpEsrFIjZYyDgptRAqsYcfHzXRq1NgTk48vYy1BD7AWJRn85bUeZHnWYSr?=
 =?us-ascii?Q?YA9p0cB68S1Ou6Ti666qgPyPbg9zy4QqTBrGTPIvT+rWfzxmv9l2zAMQjbFf?=
 =?us-ascii?Q?hCfVrt3G33qKeieGE6cC78+p9jhElyFKwTkw2oRxY+ZPAOf9TDKBTtfX3jbp?=
 =?us-ascii?Q?vVa6C/G2VXNQBiEDUh3K+oeQryaoVPy2LEzG9pWwDptA+yUPKWv6TQBACT5M?=
 =?us-ascii?Q?IzS8KHz2SvaxjOokPfb22v+kkwbhz6fBN6ZhnA3XJNBylDtnz19etd7CCTu2?=
 =?us-ascii?Q?sEJH2SD/1t74iFi5KlANwD9NvPQuoQXTNoMHOBOIHzNfCPkaN4oh+tB4I4Fb?=
 =?us-ascii?Q?ERT20D63FVbs2LWmqNEsy1RSOaXZEIL5daH1epBwhWtMe8LAeVEFfILaf6HF?=
 =?us-ascii?Q?ukk4WaikYimBPiizQ1rdzdHH2l5zbvo4kRtGEqBWmXm6cuCBHo0WmThsQABR?=
 =?us-ascii?Q?I+R4NdMIO9+x+swT36UA9KXh9jxgWcggGb/HXKzEbQmHFGrK4pPAHP3qLA+A?=
 =?us-ascii?Q?ILFhgr0tCCrEREtDSLeZhuCCBlPmOWo0ybKLpQGR2f/kJD5DURvY00DQVGba?=
 =?us-ascii?Q?tG5wA2USerWNhfXfacEECbMMFrXcf2sFfoUVS7RuXZFSlmWRpLOlhT7cNlX6?=
 =?us-ascii?Q?cK+yGkJj5HW5qVY8DnqqOu9ozp+Wqtak/sFx1WbGWJ6EW7NCOzVAFtyrRW2W?=
 =?us-ascii?Q?23g5ygeF6C1QVaIyuOZFAhBPSFxqMYc5FsE2rHZEiFQQyS+ScNYzw02fZdVg?=
 =?us-ascii?Q?PtQwPlaPI5Ac/rLTKPwfmdbXTzMe3sTzwN04tcqSzRlEl8C+FMqxHOcWHvh/?=
 =?us-ascii?Q?fMstoMLu6PzJITm4Mz82t/UfNZGTeslqFPfNO5St31LMCPVqSW4PKoVB3npx?=
 =?us-ascii?Q?JnN3Qcop2+cv6Gf7LDEwR2WnFMRGSBokndtnhbGlEp3Bl4GxMJ1C22QWJl+p?=
 =?us-ascii?Q?h/24p4MlS6PiCGt2oLCU1/F6+Jf+KdWZ4rWi4JZaxE3Sy2Hgtr3+cte4Hvbi?=
 =?us-ascii?Q?4DWbkXsgDxV2iyxM56Vf8+tUU/E2JwhBMLM3MX7qrjXgAOehnDSYrXmrM+PJ?=
 =?us-ascii?Q?nTdOJf5SxhscchdTIjcjUeOsYa+TqxHecHKVAagT4l030TcS90bsyEOJynb/?=
 =?us-ascii?Q?7LAZ1QxX0nS7av/Us+vVgMutYvMGPU0njgQo/8/Ic8zeUKKc9Aym+28LpxS0?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f015ed-6388-400c-e369-08da73dedd33
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 16:57:05.9789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swuJ7VxuWMqNrMJEmKrx/+weIOZ6cdF9hNEMEZ7QzKVBtFEbXTYaSWjuKwmTlAZB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4625
X-Proofpoint-ORIG-GUID: zWS2GZt84vEyYa-WNPOhPNyECkDYgecZ
X-Proofpoint-GUID: zWS2GZt84vEyYa-WNPOhPNyECkDYgecZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_07,2022-08-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 29, 2022 at 05:08:08PM -0700, Stanislav Fomichev wrote:
> When attaching to program, the program itself might not be attached
> to anything (and, hence, might not have attach_btf), so we can't
> unconditionally use 'prog->aux->dst_prog->aux->attach_btf'.
> Instead, use bpf_prog_get_target_btf to pick proper target btf:
> 
> * when attached to dst_prog, use dst_prog->aux->btf
> * when attached to kernel btf, use prog->aux->attach_btf
> 
> Fixes: b79c9fc9551b ("bpf: implement BPF_PROG_QUERY for BPF_LSM_CGROUP")
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  kernel/bpf/syscall.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 83c7136c5788..7dc3f8003631 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3886,6 +3886,7 @@ static int bpf_prog_get_info_by_fd(struct file *file,
>  				   union bpf_attr __user *uattr)
>  {
>  	struct bpf_prog_info __user *uinfo = u64_to_user_ptr(attr->info.info);
> +	struct btf *attach_btf = bpf_prog_get_target_btf(prog);
>  	struct bpf_prog_info info;
>  	u32 info_len = attr->info.info_len;
>  	struct bpf_prog_kstats stats;
> @@ -4088,10 +4089,8 @@ static int bpf_prog_get_info_by_fd(struct file *file,
>  	if (prog->aux->btf)
>  		info.btf_id = btf_obj_id(prog->aux->btf);
>  	info.attach_btf_id = prog->aux->attach_btf_id;
> -	if (prog->aux->attach_btf)
> -		info.attach_btf_obj_id = btf_obj_id(prog->aux->attach_btf);
> -	else if (prog->aux->dst_prog)
> -		info.attach_btf_obj_id = btf_obj_id(prog->aux->dst_prog->aux->attach_btf);
> +	if (attach_btf)
> +		info.attach_btf_obj_id = btf_obj_id(attach_btf);
Nice.

Acked-by: Martin KaFai Lau <kafai@fb.com>
