Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3864B9037
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 19:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiBPSab (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Feb 2022 13:30:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiBPSab (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 13:30:31 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F61E296900
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 10:30:18 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21GFjpJR019160;
        Wed, 16 Feb 2022 10:29:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=7znFLUWsapq0Pi+6g17FSI3UAbw01gmTS/UEPamLKkc=;
 b=emVDigLigt3B/KpqxkHgaLMKakL04fG1B89ULbID1fyh3PHXwBxaHWOV2U6m+BKkHkPH
 +Ws4bQvjlguHcQGxN/xShN1/xX1mMtBL9XgoCfEq1/WkgYkzEgaMdDpKvDOs2rRSoO59
 7EDM1jS91qJa8uTS7suWTVffl2C1QX/8z44= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e8n4beg2b-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Feb 2022 10:29:48 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 10:29:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQvBMTmoy0G/R7OAE1uH+8lUK2i46x+dvNz8Xf9wErgBx9oejnYaMne3zNICv1LuUV4ehncsZ22WEdNVclTBmaIedKs09+D/og+FmTQtCMSTjBvuVLBS1hHP4ccRknk1q2ScE4u3SmIl6v0tXic7WmJJ6vN2qIURbNpUqUBOf5scy2Pk+vl42RmeTcseqM1FytSyAutdqro6zNA5ykcywYhLDNfrygiTTuVSv0cU/XpgKAdBF0lWXhwblJ2gug0RpzXwBC9urjibSvyeWRcuvplv3DckfVE74ksBCITTM9zi9InhzY3capgnY3M7h3HfyH7+iG+WfMHpoAgMlpdcZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7znFLUWsapq0Pi+6g17FSI3UAbw01gmTS/UEPamLKkc=;
 b=HKSmOjjGSo9nG2bafRlvgJafJGCD2kjvFKEAR8LNU7UAo6vxOgUqxrGCo57lf0O9GM9W6WEDpYsfIwN7zTh/1RibzYBSAj/11LasYRk/oy9XMjDVx0VyY19+Ki0yX3TIKtjVJyYUzLeNO1DuAHYSILuH5UjnZXn2elOBPpd7OnLw0CKq3TjbGt/nAAkn5FGRJhxD8OSEzxhfYzSv4vL8izUXvRYSfFaBl1Clvh/2FvyaQlvmf8u7Nx+goenpsr6ykMMigL5wges8w1igk/mBCKhtC+yaB7IXftyFZAcC5/QYA3innAx3FpYcx4FBzbLdKK1zBH5QOfDpmJe9U/vHNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA1PR15MB4418.namprd15.prod.outlook.com (2603:10b6:806:195::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 18:29:46 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::1d2d:7a0f:fa57:cbdd]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::1d2d:7a0f:fa57:cbdd%6]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 18:29:46 +0000
Date:   Wed, 16 Feb 2022 10:29:42 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Hou Tao <houtao1@huawei.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH bpf-next v3 0/2] bpf, arm64: fix bpf line info
Message-ID: <20220216182942.jb7chah3uusjytou@kafai-mbp.dhcp.thefacebook.com>
References: <20220208012539.491753-1-houtao1@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220208012539.491753-1-houtao1@huawei.com>
X-ClientProxiedBy: MW4P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::27) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5416c884-d01e-42e1-5ecd-08d9f17a4ebf
X-MS-TrafficTypeDiagnostic: SA1PR15MB4418:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB44186EB964B329C7903BA377D5359@SA1PR15MB4418.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UoBGiQ4FKrdTbFGSu6GnjXFSdzQOX3ZtmPf86YmHzRYSsGQfX3v+ZtukzbWN4uxIfhtMDEwabgiNHzVDi9KhSn5O+tjFIAfTPX2Lf9L3IkmA692d75kaKBjnWgIBdZimiEsOpomVQ8kGwQjlAcH8Y43TZ1JNmKHb2Ex+lfp11s4hXjD8z/F0vgQHmFfQhfJNwpTCUar7wRWQ9GnmcSGUmWwppstwQELHZRs33IhBqXCa6yoH1UDbGqjZbsknh9SdtgtDzNT4SRVm3b7xjv+EQC1ngX0LMuaU9Ecwgf2qbvxmaY6Zw9v4T5+KVjmBCegLbzA2TbDf7iTzwmMMmFHBhl6SCpxUqQceqOK+VilISmUkekap45btQxicRRcvg+PGsrLC/yCH4wXGv9JzDh6AddgRjSYh/gTNCvLc/uydAUpM+H96ny3u2nIakk0hijHLEv9YP4lvdNHtbQ6AzTC6enfDvpnE0bGKWDaoHGoz1NDW8HFYq8N4TGLcNdaUiUr7H7efPgmVjqmzV39NzN4mFY9tl8l3A2dr1tg9YDG+9naOpatncrhT9iOD4qZoqxZuV3adqAoKt7Dpm1oiUGxQ6JyAQ6gGEHBPuaovR5EU/jeqwJ8ta7aOmsR1efRQQiocs8jVZ4x7HdpPRrKrJ7D4Sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(4744005)(316002)(508600001)(52116002)(6916009)(54906003)(6486002)(38100700002)(66946007)(8676002)(86362001)(83380400001)(4326008)(66476007)(66556008)(6506007)(8936002)(6666004)(7416002)(9686003)(6512007)(186003)(2906002)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1YDOrKQBAc3u5Z7SeRbYt/qnGDMF0m7hS+5Zl0PcbYMrROol4jeB5ksrIkAu?=
 =?us-ascii?Q?ycqwrRhQM14MtUQl/ltbODfjpZzi+asPpt0hcybx1y2jb8ada3xGV7j0Jtq6?=
 =?us-ascii?Q?6NOxO6zmVnPHP7C/li9gufZi9xU1LQ/UyVJ/3HCCNbfLTK+fstvDBVrNZJOg?=
 =?us-ascii?Q?O5BsbMuxWHKXivgwZ4WFzUq6rd204nso+4sXlbqA6dTVZAX5Tbeungm/XOKZ?=
 =?us-ascii?Q?zHRyDFjtVMO0+6ITP0o2M3eRJlxfyOplSKgCBrChX+xPFFznB+TxX8pOcmiw?=
 =?us-ascii?Q?sHMXMKJWXXu+QjplEk/Mf4HOXQGcG5LloeoHoK0Vx/hVkY+nPZuJ1nyZw4jr?=
 =?us-ascii?Q?bB3vWL/DDLyDScTSgeAs67n9TmSQd3icGPer46Z22dILYGJFpH0aPJwPtiu3?=
 =?us-ascii?Q?6oZ74roSaLYLtq3Z79/MdlkV8KLUdlSA2FSZcqmfF+jpx/3JLKu8RC3su+Oe?=
 =?us-ascii?Q?E3URy1G3bXr5O+dm/JLWM8k8clV7oNG/KTtsET60DNhd9apoEIzYPucicNCA?=
 =?us-ascii?Q?g2MXYB7DAGr/7Gudozlra/LU4leK49VwTt1eTyYyAw+AJtnRABlJP2g3maPE?=
 =?us-ascii?Q?BSgLV98LIBVjGuJ5FW5/LOp1AvUIZKGsqqgmoJXJS+ttneuG0dkG4WSUXY4d?=
 =?us-ascii?Q?v9QXJKqWbgoNqBVDpRx6v2jplnu9AbaaBVX4JxjJHV1zH21sZsHUjQCPp3V+?=
 =?us-ascii?Q?+8hABBvQ+zkSFzC9o9MPsDlZQopSFs38gySAupF8vpsbbvSSIwAfdaW48yUz?=
 =?us-ascii?Q?DuMTsB2WtXor0Q5p1DO5nccUIlCtKhA6pdJjRraw+RoKWFAB3whgXl6PP1Tv?=
 =?us-ascii?Q?I1dq11LCwQsQ0Mj5inae0cT+AqyBBSWnQDr98dAFYg2mSQ6aLJPNr7/fbGcn?=
 =?us-ascii?Q?MKd7CweA6VgSUtsxG3QD5Z6xldCo82oTuVqc5D0DNOdV2rVwBsQ0T1Azfbbb?=
 =?us-ascii?Q?9enBx/nbUGH6mFGm9lo2v8zRM4nmXy21J4UyOuHnsqZ2y9FuCZo/KtgF8Ky5?=
 =?us-ascii?Q?mAPd0RXHxex3QZ+PftEfRHn2WtE/iBs9pKKyJrSr8A84ten7tIp7O88T17T7?=
 =?us-ascii?Q?Iju1E3PQwKdfeswgXOy0FW6V1Nbf/fNT3KZBMxs6qAs7Mz2EYuPsyvjLt3c0?=
 =?us-ascii?Q?5iI/poOPBB5vbq+WtfXQzEOfonLkouORoSgFBimlG5l8LaTHrxfd8tIC7uO8?=
 =?us-ascii?Q?/Bz894EG8Na07zuzZa9K44H1HLrAWuY96oGoNNxf1dPZhg/+2SHtrc9fP3E7?=
 =?us-ascii?Q?GdYv/vyXCYu/cnLvghFj97V0TmCdwrfZ2hkxIetLwwKJ491s3SKqhqcwAPg1?=
 =?us-ascii?Q?eZD1sb0FXJO1n+1j45FSE+3RQMLSaz7aFSSOQ9k/rf8/KPLipqR1Cy91+qJB?=
 =?us-ascii?Q?w9RT4FiTAqyODU/OcNMMeNP8LSstTr9AnOD+I2j0tzQC4NvaazIlB1na+UpL?=
 =?us-ascii?Q?XS6icQCJIbw8OXumVc1u/B+y33StuYq3lSY2E7yF5AGqsdaoze128f3Bta74?=
 =?us-ascii?Q?Vmm/EbaWQzVJf3GI8U8wBovZc3EbeaqNEC4drasws85jxCvtuIK0INXUXrVW?=
 =?us-ascii?Q?WdMDg5900DG9cN9KzUBXpoeKDCLr2YHoRvpa3Bhr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5416c884-d01e-42e1-5ecd-08d9f17a4ebf
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 18:29:46.1620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6hUovAvg3gHposStPTeZctA/R2YIkPgUm+7ZPlUjhFvonNeTToSBpAvvi0hbCHCL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4418
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: FT__LUV3U-UVIfgLNkEud_i0ChXLUEU7
X-Proofpoint-ORIG-GUID: FT__LUV3U-UVIfgLNkEud_i0ChXLUEU7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_08,2022-02-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=758 suspectscore=0 impostorscore=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160104
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 08, 2022 at 09:25:37AM +0800, Hou Tao wrote:
> Hi,
> 
> The patchset addresses two issues in bpf line info for arm64:
> 
> (1) insn_to_jit_off only considers the body itself and ignores
>     prologue before the body. Fixed in patch #1.
> 
> (2) insn_to_jit_off passed to bpf_prog_fill_jited_linfo() is
>     calculated in instruction granularity instead of bytes
>     granularity. Fixed in patch #2.
> 
> Comments are always welcome.
> 
> Regards,
> Tao
> 
> Change Log:
> v3:
>  * patch #2: explain why bpf2a64_offset() needs update
>  * add Fixes tags in both patches
It makes sense to me on the bpf linfo expectation.  It will be
useful to also get some eyes from the arm experts.

Acked-by: Martin KaFai Lau <kafai@fb.com>
