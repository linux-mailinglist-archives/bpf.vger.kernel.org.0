Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1A95A5732
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 00:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiH2WkJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 18:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiH2WkH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 18:40:07 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD9147BB2
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 15:40:06 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TKdwnx021803;
        Mon, 29 Aug 2022 15:39:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=3A4wahQLTG9HJa1ia96N9boZeRunJCiYoqV+F6EX++I=;
 b=ngdrd+IB9eDGIb8z/RiVCjYC1x6XI6H93CPP73/wi4hjwADrqnD84Tts0vCSGVs4Nhe9
 9B7xxQwYA6n5KNWKjuggh3ikYSqXHIe+oZZwQupltIetx/2pyeI3AXK828+XPuZ+CQIV
 NMADqi4y5VW2seRMZ/81bn0brLXzXNMiUQ0= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j7ekn5cbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 15:39:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R69L5cLhedgKdXL0ERnX3TxFW83X0y7+5HJr8imMVcpXu6TZjpBGjHdyFE24+lHdOeZhBoTdCICOElmHlQUedK2R4GBMDH0Ph5hnRNO7+RwOdMcc02LqGkBkCMUeZs+/14x5dVchrUVfMmYXu7szr/cMlboDcwJUrRe5ZvQuV8sjH2tAqKgsqfiXa5isG0oWtAI0MMMnFDSr+ZZnaK2Tq7Hd2oMiVWfunrrE8CfWREsv8Z8XcBN/+Y8PlW3RAVvJ/7453h9klqcbZ8ZipD7IQOiuFZjXerX6u/v8mP1eaZ/4BmuGr6PO+IJ5iD9K15efQ5QDr3ZPGmkSlshBjruAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3A4wahQLTG9HJa1ia96N9boZeRunJCiYoqV+F6EX++I=;
 b=AMt1jbiNUSRuyaBdXLU7GYhMT7+DIOsXUDOUuGVk0KwQOLo4ZRLaCMjgnSfAF6Swn26vvm13gINuK9I6IrBkzdtCLXsMrc2eX3gumbFHI2mJkmHjgZMCxjIOnvNUnV0s+4+jShWnVaRMQolVAw+R/1Pqam/GkpNJ9YBpIEQc+3G1u/JGHvGN63HhZLOOSZb0fZpdxMXiNhvPuRNc/82HMe6vXQETAxMPxTgUQWQosI3OPaUzZhgubonscmGtSVHmf+3JJxOmVQVJDxb7bfdo+ZUSNYquS7dtReHzoV39LRSmLGB5IcJNKu/1A3NcOdRG3o2tXJfiZdv3YjKTn712lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by SA1PR15MB4434.namprd15.prod.outlook.com (2603:10b6:806:195::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 22:39:48 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 22:39:48 +0000
Date:   Mon, 29 Aug 2022 15:39:46 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        tj@kernel.org, memxor@gmail.com, delyank@fb.com,
        linux-mm@kvack.org, bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4 bpf-next 01/15] bpf: Introduce any context BPF
 specific memory allocator.
Message-ID: <20220829223946.vfu4hi64ybitvt27@kafai-mbp.dhcp.thefacebook.com>
References: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
 <20220826024430.84565-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826024430.84565-2-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:a03:333::18) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da9f7ca2-f336-4c82-cf30-08da8a0f60a8
X-MS-TrafficTypeDiagnostic: SA1PR15MB4434:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A1HB+cGezKtjUHZiElj9k7wJDc0QTYtN3VuJkXLdWLvtCxAOkuMOWNqr1d5muIHL81p0JTp2SylBC9QCRGzAl92jGvytOgj1FZttzZttJUwy9jbWwLQTYf5s5b0KaFeDclMHXaFGbSmTP3t0XeveLKjj0DQPG+MiV/bqjj0Eq9qZ1Y8BTmbJn+oOQ2/xPAR5WAKcdjbpsUlpr7mEq7ljVhFTlzm8awwsKL6f8XrQlP9GiNs9z9hhmzvwOL0H+y5y9iAR4/big3uLUq4XRMH4WyDksBApKjZ+tCUflGbONuJkyc01qG0+yaD+NgVDS1TBgMCErCTmXA/JDlS9txFYHRExhGQplrz7B7NLc6PhzkYHq9TyquhD318JLaaFyQoNFZcE4cvp7RML7Btx5DuKtUi4k5+EdQYicC85FOKkukk99X/OOO1rL0bHeBOOVgRZQ+57/JdzL44G654XMbzJ0A2r9sI81AgWHisEAcFAd9XUXvjvtLK240IRRDYA746dv/mF4dZWwEI5Xx6W569YxqCqYHQ99OSGaFKF8aeVD57KZ6E/7xP9Gdf4rH6MDGJ2aG2k5dtanO8Dqq57Ns9VaF2QScn00P4P7irkmaVcIH1xw90mFCM4C5VVNqLiGr0OEDkv5RSDWwiCrVNLgVYmFOKX1nW74iz7rohOClWaawZHxIQIuM2NMDGD3Zg4MMxA+EvRitEpy6NGCvvSPMRW6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(316002)(1076003)(186003)(38100700002)(86362001)(5660300002)(6916009)(52116002)(83380400001)(2906002)(41300700001)(66946007)(66556008)(8676002)(4326008)(478600001)(6486002)(66476007)(9686003)(6506007)(6512007)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hqt57JrUVRa7apvdViU47nJARBEqFoQlAv04GdKwD6JT7RAJS4+gEtmXUw14?=
 =?us-ascii?Q?BjA0CiW2Wi0v1PDlZ94pTm806e6gmqQvWKgSt0dC5yiMxeUjuJkafmpjTt6b?=
 =?us-ascii?Q?aHjez+CmiETgBDwGrgu+STj8XQxJd1GF16vLUz5kL21xEC0vJeOAWOZJCmJ1?=
 =?us-ascii?Q?rT18ReVHSH82D699Pcq6hs8/ioYZ/1FKuaXg6NsK3ZLMJgm8anBYPXTi1Bhe?=
 =?us-ascii?Q?vMYYhmXrBCW8B+lW/NXYI7OY83f3o71qOxGJdvSDWGIgNgIXUIjcN+FMEJF7?=
 =?us-ascii?Q?PbmlVeooO/J4y2UOxPD1NoZjIdl6MRrrIW7/ZErVAQ6We0lCM2NCmSoWzmEG?=
 =?us-ascii?Q?q8i7N4MBYXNOWaCg7f3ZibypU2J/giw90sRoCqMJoSNJ7ydx+Y4hOgckomRe?=
 =?us-ascii?Q?YD0UEX7XlB+5C/fuQDKxLNUfTA+QNkp05fKS9NYQH2QwOrsumuDP6izumESJ?=
 =?us-ascii?Q?AYs/Vz73KOuyvBkBi/vMRhgq7qk/MNrfwx1r7NTb75Y11GzUCalEl6ziHzNf?=
 =?us-ascii?Q?2WXXLKcteJH3IUAWJ1qYTHGUbDmvZe2DOlwFsCT0x9U0kSrxX7OU2rw6z+bV?=
 =?us-ascii?Q?T/ech1926LX0fcC05OKSYNHKJx9YU+JxxOXY+BGqiuGkxTvnfQmEz/iaOvrj?=
 =?us-ascii?Q?NBgs+9v+c7k5q2TuIumJQp6hQ/7/EDEqFDp4rEWDRIpfb6HYfXlwlJXVuo2P?=
 =?us-ascii?Q?HxRbmwZR2UbEt+b2y1HnTdNwTOeGyKdV8IVi0bfuyqqkTB7al65gZcfzoFwB?=
 =?us-ascii?Q?9BVja+8vUZJY+lIDMMQgvJ+UV/+UiHZKBXMoDoZdS78r8FYun0iCdVkXQPNS?=
 =?us-ascii?Q?aKfKNEobHWpXUG3OjFYn0RaggcuuvZAHWQqLT1riKBhPP0mq1/zIo7h0Xlev?=
 =?us-ascii?Q?8kmLNVVcituGDsEowH7wzw0zFJW0Pzt3CrLL3lZwOFdV4to9U841AYPl7eMm?=
 =?us-ascii?Q?a1tXihPQyGB2ilhi43i3qyD11sK9UwBigGWrTl0mcvGoKB9Km1jvpJ5u7OHM?=
 =?us-ascii?Q?Y95h5dV8GxVts8DatxAFM42bXUe4M+a3IvxRTWbRu0MYSCT68us4CmA64llo?=
 =?us-ascii?Q?PcyU1bUTKjkXfUNiLoX69cqoftKMVAdbj6y56jd7bG2YvjM28fIQcNfSV0gi?=
 =?us-ascii?Q?Xj9DMTFTTbt7Er2nrmWIQmME2KqstsX2TH+0dWfcatolcETRNfyVKHU958Pa?=
 =?us-ascii?Q?kU66aWVJ3BXxlp4qmgnx3TyVIAJESF2SkMkZswbTNYlRV3++m4NcE1iGRPJV?=
 =?us-ascii?Q?V7mQ7znB8m4w6aq/bt0+Yp2ZvV31aZcW0DtibmLmesTMovc/Lf6/N5aMeeiU?=
 =?us-ascii?Q?hw7k04zDcZtTd71d0IJ2DN2CZdiMqRJ3K8kkGtPZdS47gp/LX5OgLxQx95Ok?=
 =?us-ascii?Q?KSqxdNUkbJZMhoRaEyJLrGO8KRGI8Jsvink3u/mRbOL1DSEuJtuAP/9C/N8u?=
 =?us-ascii?Q?qw0GARRPnpJp4EX/kAzAJitKcGGd5tQf1o1Rwgqf4IllZLi65Hne2CVyhWwN?=
 =?us-ascii?Q?bnTQyB5/h0yS5VNWfy2bLps4FKovVNVX/y1BtEfpnDYVXtZzEM4vaKuL/g+R?=
 =?us-ascii?Q?4mLWvDqnyoFhMSP4rrc9vkohNUMGSzGx+oBbEwiLv3Yr5f6feKTWaPz4tdBx?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9f7ca2-f336-4c82-cf30-08da8a0f60a8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 22:39:48.6225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3jFwGEvQOQ8+spIpIcGSVu4fg3VlAOhRQpGFQK6ymW6vT4KBnPEEKWRjT5x4inl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4434
X-Proofpoint-ORIG-GUID: sxKVqRm1VB0Pq1rswCRi6J_avmOND5YK
X-Proofpoint-GUID: sxKVqRm1VB0Pq1rswCRi6J_avmOND5YK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_11,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 25, 2022 at 07:44:16PM -0700, Alexei Starovoitov wrote:
> +/* Mostly runs from irq_work except __init phase. */
> +static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
> +{
> +	struct mem_cgroup *memcg = NULL, *old_memcg;
> +	unsigned long flags;
> +	void *obj;
> +	int i;
> +
> +	memcg = get_memcg(c);
> +	old_memcg = set_active_memcg(memcg);
> +	for (i = 0; i < cnt; i++) {
> +		obj = __alloc(c, node);
> +		if (!obj)
> +			break;
> +		if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +			/* In RT irq_work runs in per-cpu kthread, so disable
> +			 * interrupts to avoid preemption and interrupts and
> +			 * reduce the chance of bpf prog executing on this cpu
> +			 * when active counter is busy.
> +			 */
> +			local_irq_save(flags);
> +		if (local_inc_return(&c->active) == 1) {
Is it because it is always '== 1' here so that there is
no need to free the obj when it is '!= 1' ?

> +			__llist_add(obj, &c->free_llist);
> +			c->free_cnt++;
> +		}
> +		local_dec(&c->active);
> +		if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +			local_irq_restore(flags);
> +	}
> +	set_active_memcg(old_memcg);
> +	mem_cgroup_put(memcg);
> +}
