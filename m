Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7CF5A588E
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 02:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiH3Ax1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 20:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH3Ax0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 20:53:26 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F370A80EAF
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 17:53:22 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27TMpODS015667;
        Mon, 29 Aug 2022 17:52:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=8Tn5YCK6tTRH2khxYNd9qS1SO+vVu7kNHtD1PpRNc4k=;
 b=F7+JWoTeU0he1gEfrMa2a7/0O7yQ+oq2hnqwMk96uAPK3ZGH3tVJmBdXVcA8xyn2qolm
 fhoowo5R1VJG5J3shjIC4JVGrGJhDnVUK7qwZWG1gBd6w6jzGAYLZsDmZEmaQsIEq4K3
 apEltARActXYX2Q+yXIvrx1b6w40RvMHXnY= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by m0001303.ppops.net (PPS) with ESMTPS id 3j7exydss7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 17:52:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmfnzbAnVEN9C00UfqmCSsl6SyS/7nTqGCGTwcIu+cBKZOiYOJY+kbXnrCcRpNBgtG6qnOQBK7qM4NVfSjMh0AzqJ2+OWLI0T+oM/8IrZrghEZuEVYSop9TWvmdWUQ+0mqS93ihB5OtGkptlMtjSJacrudEIXPoQJRgFQcJX6kJiCfG6lSmy8TpMwRZtYFxDs+2Qo2T8arOAMikuU8TskzL6u5RaP50mz71lFD5jxtj/vmpfEctyN/J6hfvgCC0NCQCiCF+bgUENj+RRPDgPeJlv5faJ3rE0CfgAuRKkNLecwjmwD38WG58+6gOandHbH1jC9XJ2jev4eedtScEMaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Tn5YCK6tTRH2khxYNd9qS1SO+vVu7kNHtD1PpRNc4k=;
 b=KUmHe4IHr+JjsnMfV+un/N+L3nL0pqJ4Mj0HCdlWh/Pke8gHr7x/aBiSKcPxYw0KlAqEnDN1P/GXAtllInObXGbTVWJoo3N3ptzz3eIu0Awd5jVuoJ2UFUxrwgh2d1jkEzd5vdllkNzU2Qgg0y694kIDxAlYmm/2uO8Ur/TBwquNkjlH0qvSf7avgGns0GCwo5g4ryRgoLCQQhAFCo0HM59EyGmOV2LuWjw88mhIZhfDgNqQuhpZn14RbmgMAVaH+Ho5bXXs/rlzGE8ioGRFD9RY0nzb1ghEvZzaky+yll75xGm1pc60f/T45NVkBHIsJYUCm7VZ7iSmz5gtBHYujA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BN6PR15MB1252.namprd15.prod.outlook.com (2603:10b6:404:ef::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 00:52:30 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e%4]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 00:52:30 +0000
Date:   Mon, 29 Aug 2022 17:52:28 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hao Sun <sunhao.th@gmail.com>, Hao Luo <haoluo@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
Subject: Re: [PATCH bpf-next 1/3] bpf: Use this_cpu_{inc|dec|inc_return} for
 bpf_task_storage_busy
Message-ID: <20220830005228.xc7nhufvx4oetel3@kafai-mbp.dhcp.thefacebook.com>
References: <20220829142752.330094-1-houtao@huaweicloud.com>
 <20220829142752.330094-2-houtao@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829142752.330094-2-houtao@huaweicloud.com>
X-ClientProxiedBy: BY5PR20CA0011.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::24) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1bab146-33b4-41d5-7ef2-08da8a21ea7b
X-MS-TrafficTypeDiagnostic: BN6PR15MB1252:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zu+t1oit/RnSXx+28qZ+zGgGPa4N4xpsLBxZsUj2KfE0yjB4ErnaWxzfzltQEm3piU5d8Px2Ryd4S/n1y7zZPQBuNGSeWfr+jTX6PC1v2WiOBsGif0+R3u++UDH4KVrJTLJxx8Oz2FX9L49j5kdyDIenmonTDAgzmdzSGOtegJkruDqqESt/++sfNaBbb8qSV9aJH5VKNJEZ8H3V9kmVc9+TAB7xgYJp4asRQBMcgTj04PzF/9oVuqgcOVwidwhga7gXvBhJP10S37oPidzqgP3xALCpJWi5wETmYYJ+wN8qcPiGGEblLW85FVyixIUDdUM+h8upp/pGNOty8WgZd+i6w5iqdBtYqv5yBpAvU0BL4+aAZ/4IwAxaBFBYa7bMHfhbA9Eohtq2t92Oq/JuHgEF5By7cPbjzUaUSqq5CXsvnFgP993/ms2YT04RXJ5Fw1sU4/h3cBNHSEm6ydb4Lz0L6C7sB4LZtOLhHfcvg/9gcd9OGV2MlQMKacQHkJCmbA4GDCUBMGZbigtCTI7ZpTXjOJVOecNx5m2R6etvpmV9t87dEPbVHI3jeLha01RXqzr0b6bLn6XOMLX353lWaQPgxxVgY7qVBsOK9JFjD5+je32tLJmfxp18a/XGXVvZNf9jOdW1ISmLiRVheVhso7U67Y7fR3QJ8KwZql6D60gAYfQahTm7RmqDjhYabqYrkRsgmHW3nt0HyPzQExyZ195KQ8CswqJ1wXv7dI3IX+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(66476007)(8936002)(4326008)(66556008)(66946007)(8676002)(5660300002)(1076003)(54906003)(316002)(6916009)(2906002)(966005)(478600001)(6506007)(41300700001)(6512007)(52116002)(6486002)(7416002)(86362001)(9686003)(186003)(83380400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I4JX6/aJWClCStiWyJdaCJt6nl7MkmxzrvsC3d1wOul4ZvmNAEq5NUl5k98Y?=
 =?us-ascii?Q?SgRk18bY0McuHya4opezUG/zQBe6yyW+VPrSJ2KL1F2f5IHh4SVNJUIMExPu?=
 =?us-ascii?Q?SXmQABYNaC9gDtgy1/PbbD3MmKGQcWd+P7oB/zlXJvxdfnDxnl2Z5FgzsfUo?=
 =?us-ascii?Q?pMtymzbjpFIgW58+S8phn3SmE6l5W1I+CYy8mjpd84e/A2rO3T8flHxxQvQI?=
 =?us-ascii?Q?uk0b6nakIEym+5wPYoomlnjWlJyV/a2WipW4ubMEtYn/G/HwROi40LwOWEWo?=
 =?us-ascii?Q?FAFrFPlV6JGlz60BJpZTC5AWS4Rf8q8o3emh0NEyeEBhtSolsGZhetU88pvx?=
 =?us-ascii?Q?y3HuhI0vDDKLpnm7oQstWoWBqZuHiLCYPFSLv4fCJV8SILhNaFkCoUARNOze?=
 =?us-ascii?Q?XVO7Jqmk2CNYQLLOc6Zn0QGMTNFt91ZBqEGfFw/S6m+O/K8SXQhF9uOpABkI?=
 =?us-ascii?Q?kYTeTTkPQr1hDBtuHRRQk+L3SCsVR1Ar4bf3eCw40tqMt+mBrsWZpvfqDGUM?=
 =?us-ascii?Q?8nmrfF4PtGWFSxO/ocU+QqOpnlUXWJlYphpqJfpgNhVS7/4cIkFN/2tbqh9D?=
 =?us-ascii?Q?Mb/O2W782kZU2azyxK3zei2o2+5j/di8esv+HXMRWwhm40Dv/jAUi9uvuHEJ?=
 =?us-ascii?Q?sp+tSrfM1wEfsyB/+J69JwB2GVW275O7FnpFs4Bb88egs8eFOZ8DwyEsS9ru?=
 =?us-ascii?Q?weW9vseG4HvKPg0CkpiY86kdLsGNbnKZ8m7IDflFVgLx0QZpTlUBYB0Y6RLO?=
 =?us-ascii?Q?thgG/q1ZUhUv5uLtwM4MiYyTDCa0f8564bfZZPskHYdg+5D0sX/feWh/9LD5?=
 =?us-ascii?Q?3HIA63/MHLMeRIQPAcoVH5Wm1gnI7QuhQf8tk1k/lS4bynKjqGfv4mpHezyt?=
 =?us-ascii?Q?B/yBo51y4QXQiU8O3321KWunyYQosLLCsWp4FVO/iymRKmOtVS1LTr2AjOQm?=
 =?us-ascii?Q?lghKPfx8r9G6Hn+8OOdy+vCvjaPW0Fbc7255FbaB12sE8CRx4k6Ttf7cZcm1?=
 =?us-ascii?Q?cHOhdZIMysCQWguFH41kVoEHZ8n90kdTngoJenGrZs8t+TgbK6wjIPm+U/N6?=
 =?us-ascii?Q?SVWJE88aS95OhxtgXVaKX9I3Msh6kabs+4lgoshsW2tHbXFawWueHxyyxyIo?=
 =?us-ascii?Q?vS8PqgWoyQZmh9D0xXGPMMoGapNYWIqQrK8QXo1Leupgmbv2SdYns8G10hO0?=
 =?us-ascii?Q?YCQY1hIJsSBz7aE23EfaEyzzEpm2PUTg86fJv6/PQ7fa4a5TIdjq8Y54LSdn?=
 =?us-ascii?Q?ppAEzQCRmtKcJtsVtyMxTFOChPd0DmzccNYXxEIQE1W3iSrVdTACeWlTzDeV?=
 =?us-ascii?Q?ym5a4Gr/t814ZkO5podkMS2gDlP1ArafHlLZDeNze6f6hC3kaqbem2XeFZu8?=
 =?us-ascii?Q?jc0/aaUJmy8QXQ5m/+ZxclsojVmkPZwGyF45QA3K1SqfQN3j9czk4ro7rA++?=
 =?us-ascii?Q?ju99LBoAjUB5Y+LkDgc0L2wyzU2L1ESDyxgMeithnH9tus9Hq+ifNJxVf/Fj?=
 =?us-ascii?Q?HPaVSzz4t9OBuU1OoRA0sTgcHtrmnGMEOgxSlfIa/IMYo3biKwDTKA6E34ef?=
 =?us-ascii?Q?J1uaXdJQM2NG86xxCMJWfyuPH3DvjpdLrgrIkEJh+b0V5H3SS0drNJic8+RT?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bab146-33b4-41d5-7ef2-08da8a21ea7b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 00:52:30.1352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iaEMcswFH6batDHYltOXtYiFOIISw0T9U5tJz17llTDDs2yGxRF9RH30XVKAAZHp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1252
X-Proofpoint-GUID: l1iT3AZg-BXKPbqbWVE6iqdCO5qlOyb8
X-Proofpoint-ORIG-GUID: l1iT3AZg-BXKPbqbWVE6iqdCO5qlOyb8
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_13,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 29, 2022 at 10:27:50PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Now migrate_disable() does not disable preemption and under some
> architecture (e.g. arm64) __this_cpu_{inc|dec|inc_return} are neither
> preemption-safe nor IRQ-safe, so the concurrent lookups or updates on
> the same task local storage and the same CPU may make
> bpf_task_storage_busy be imbalanced, and bpf_task_storage_trylock()
> will always fail.
> 
> Fixing it by using this_cpu_{inc|dec|inc_return} when manipulating
> bpf_task_storage_busy.
> 
> Fixes: bc235cdb423a ("bpf: Prevent deadlock from recursive bpf_task_storage_[get|delete]")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/bpf_local_storage.c | 4 ++--
>  kernel/bpf/bpf_task_storage.c  | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 4ee2e7286c23..802fc15b0d73 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -555,11 +555,11 @@ void bpf_local_storage_map_free(struct bpf_local_storage_map *smap,
>  				struct bpf_local_storage_elem, map_node))) {
>  			if (busy_counter) {
>  				migrate_disable();
> -				__this_cpu_inc(*busy_counter);
> +				this_cpu_inc(*busy_counter);
>  			}
>  			bpf_selem_unlink(selem, false);
>  			if (busy_counter) {
> -				__this_cpu_dec(*busy_counter);
> +				this_cpu_dec(*busy_counter);
>  				migrate_enable();
>  			}
>  			cond_resched_rcu();
> diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
> index e9014dc62682..6f290623347e 100644
> --- a/kernel/bpf/bpf_task_storage.c
> +++ b/kernel/bpf/bpf_task_storage.c
> @@ -26,20 +26,20 @@ static DEFINE_PER_CPU(int, bpf_task_storage_busy);
>  static void bpf_task_storage_lock(void)
>  {
>  	migrate_disable();
> -	__this_cpu_inc(bpf_task_storage_busy);
> +	this_cpu_inc(bpf_task_storage_busy);
>  }
>  
>  static void bpf_task_storage_unlock(void)
>  {
> -	__this_cpu_dec(bpf_task_storage_busy);
> +	this_cpu_dec(bpf_task_storage_busy);
>  	migrate_enable();
>  }
>  
>  static bool bpf_task_storage_trylock(void)
>  {
>  	migrate_disable();
> -	if (unlikely(__this_cpu_inc_return(bpf_task_storage_busy) != 1)) {
> -		__this_cpu_dec(bpf_task_storage_busy);
> +	if (unlikely(this_cpu_inc_return(bpf_task_storage_busy) != 1)) {
> +		this_cpu_dec(bpf_task_storage_busy);
This change is only needed here but not in the htab fix [0]
or you are planning to address it separately ?

[0]: https://lore.kernel.org/bpf/20220829023709.1958204-2-houtao@huaweicloud.com/
