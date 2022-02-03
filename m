Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CA74A8F64
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 21:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbiBCUwv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 15:52:51 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33814 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229473AbiBCUwu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Feb 2022 15:52:50 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 213I6WBM027699;
        Thu, 3 Feb 2022 12:52:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=GWTEfcqaBOGuJGl7PkpED6o3+LtGAlmINpPXJl9GvQ0=;
 b=hCffeaRLHrUg55wJh/r39jyaPI/f4cLlQpHyLLuyNiw8kzmNSU7ytFWKVlo8UmXEnMRB
 HmOo1dOfCsXzqh4zVp5Rc02LvZ+q5doRynT7sE+0A7f7rX/+jXho+I8/IKieEcxQyd2E
 mZaL12fDf43iLxm356h79lrl33kIB0ULvmI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3e0703nnce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Feb 2022 12:52:38 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Feb 2022 12:52:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gI7PyUUpiHTkzbRZNEOYpBtEPkDyhyopDQGFaT6mwGDWYU0A4uEejP6g0nYVC7jy+thqUN5GJGy54ztFddUgyCOjOStOrCqO8cfA1kjX1CJ/9P7BokbjQYo/3o0J2qMR1p3xSRneVUZ1hNieuzUW8lQKNfCilIoDy10BH0RxTn2maaH6ei6jWTBpoI5ttS0HkW3+xGqD302mpj+iERkkn7WgJs0v6hyWeEX8X9w2GPRYAnkm8KXJuCGovKZqdLrSugjH2H3sj6d8ZB5cWBq03p5kQ0mT3KUUmWQBegIC1IB4RvIbG56uw2opFHGXhcH0P1JcOB73qbvYFOS1GNqVDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWTEfcqaBOGuJGl7PkpED6o3+LtGAlmINpPXJl9GvQ0=;
 b=P/RNYrTp1XgzQ8ecU88cwaKldZAWk5Eo9xJuS8Q+rRZafQQd/DwxiiJP7vkyRBM1onhQUbh3NQSa/J/WNEhIJQ7YN9/YU53tpUygJcDLMIpuqHwy5SBgP0AyJTgXjsliGm17KSBQyNJXizVuZ8BjxtZu0XjUiAvtJTJEnnh0C20BOhBJfMDd5xP4Bh9SoywX7KaUjx2L4fHfvPriieBvZahyt9v9Wrl+oBhCdvtOOFdCBj0QG2DQbQpjqRKArKiO6PWgHTpr5WzVUBm/ptmZNXCb3vqEiF+DKGDN/0npV73yBpuycAg2OSO7m4Tx7BalUn3/AUzYvKst4duBweK6nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by BN8PR15MB3091.namprd15.prod.outlook.com (2603:10b6:408:85::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Thu, 3 Feb
 2022 20:52:34 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::b0ca:a63e:fb69:6437]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::b0ca:a63e:fb69:6437%6]) with mapi id 15.20.4930.021; Thu, 3 Feb 2022
 20:52:34 +0000
Date:   Thu, 3 Feb 2022 12:52:30 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: add a selftest for invalid func
 btf with btf decl_tag
Message-ID: <20220203205230.kw4xwghklhoqhena@kafai-mbp.dhcp.thefacebook.com>
References: <20220203191727.741862-1-yhs@fb.com>
 <20220203191732.742285-1-yhs@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220203191732.742285-1-yhs@fb.com>
X-ClientProxiedBy: MWHPR1701CA0014.namprd17.prod.outlook.com
 (2603:10b6:301:14::24) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dceae1b1-d7ad-48f7-27c0-08d9e7571a4f
X-MS-TrafficTypeDiagnostic: BN8PR15MB3091:EE_
X-Microsoft-Antispam-PRVS: <BN8PR15MB30911C008E133D144708D4B6D5289@BN8PR15MB3091.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AOJB6JiyOgpnOO/tWLjRQwsG7XFbimh4mSKu/e9tsXYPjg8Awy6INRVmylGVECfJPfUf6IgRihvGq/yEO4L2VmmrH8o6WaCgj4uQAZe1L7xDVLRar60IFLTN8/QcYnCzYTUc6dobpv5elB6mREFw5nI3FzbfXaZ8rn0cAjqEDen2a3nEWHrIaLOVyMCzicEeKcHfgNhQdOmuo7RGMB84rtJFs6mOPNkkhJ1X3ImZGNla5czChYnp3nOYK/6REqO2w/6Z3WcFdzr6ytVjLasrcdUO2JQWOWVYUirOzxB1mVHa8QdF1QLbmmr/ysQg/ycKBpBWyr7uc8k2psUqYhi6T6QVvMm1+2zH11Q80LAo/CJXidhn8fZqs0YiDhfRKjnTmUcTphsybCdtFNALrVRIYU8gLTBRHPU1rPzS6QsCryo2LCnZm2bQdykmy9KiiX40T0s4YwRaG0dwHBa+49B6EVQ3be29DacEovIU0zXJRLn5Aa/QcsaleeW078PhpN3bmYPz9jXy+LlWCgAwEWvhmWkc3kHzaFGgAlC3W0iKVPtgxXxEa4CrPupyOpUNjgyUvBCOdsv0eDD9Cp5tpKsR6WQ70UgbemlHgvz2AW2soM3de7CUA2AEUJEV5nOHxUfgyfNVmPALCjfct0hPxzm7oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(66556008)(316002)(6636002)(5660300002)(86362001)(38100700002)(508600001)(2906002)(8676002)(6486002)(52116002)(9686003)(558084003)(66946007)(6862004)(6506007)(66476007)(8936002)(4326008)(1076003)(186003)(6512007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pRzjeSovMKQhrcWTOFvwwDKLWWnSKw58cbfJHAF6PozJugsLvxdNmPDE9LiP?=
 =?us-ascii?Q?wcmoeJEVUMHRrOe2qF+FhhcvgN4TmJfulE20KmBCGpcWweuob/pEwGqTLkxl?=
 =?us-ascii?Q?GAYD2Ml0iLBr+p32zlNwZV7EVQJIEcQFuDyj7NOASLO9ADJY9kGxP00HX1Lg?=
 =?us-ascii?Q?y3UFD1aJbjLRzZQkJ6+M4WsjaLb0x6eMWrg1DKTLGkCeo8hQDHEZCEJgD03u?=
 =?us-ascii?Q?Z4Lwt1x98kNqp0Ist3GIdqObBGgolr6skOZZ3hl+LD+ldhJtYCvLgDwkl9Al?=
 =?us-ascii?Q?5IJYdG+Pzi8K/i5EueDmCQj3hqj7jJ5UgrIIavopFOdcSlmUr7qkP3llZtcX?=
 =?us-ascii?Q?YczxgvJwXbGK3TZf2RjB/BVYtGuVlALEXZzedNVKKzyNalvTLi+0v7pQY3su?=
 =?us-ascii?Q?U3Dgta+u6T21Q/flWoo/5zPWLB0B+iUHpsOC2f3DVZIkPkkNTf4HbrQofauY?=
 =?us-ascii?Q?EUPD7RwfmXCMsXgPEX/ihPjOZKFEsH5yuvuCZjbGF2TRDgbpWN+Lf1OVLpTO?=
 =?us-ascii?Q?9PE1qKg17nzDOnctpNfDXANPu+OhLAk+gwVYeFXBl+4IFKqKgAs2YvI+oILg?=
 =?us-ascii?Q?syCkQwcZ4BryF80tZvdOVe7aLRT78M5gxXFQC3QK4uMSEmO7MrpL3Rx2sg7T?=
 =?us-ascii?Q?3JtxZkwjWv9Pw2i+Z9dcH00Yqt+SMlOsY6tMQBWQkHzDe0KtAnuYuvd94Rmx?=
 =?us-ascii?Q?/mnWTvifEv9Xt9RVCEvzI6xJLDUMBePaPTNFTKkTgzuQjGT1uRd4puALtYSm?=
 =?us-ascii?Q?legw/cLGb6NIqv0sHm/BOQw5LE3h0t6f1GK0QoDb4LpX/V6XUmufvTwAo0SO?=
 =?us-ascii?Q?TueG/xjhfTWsL8x//a1HzVefocsAovw64Zryq33QszK/Kf8pngMDbmxhWBgW?=
 =?us-ascii?Q?RdJJB2WbCoxrf0QgsSUHiDex99K/W5+oMrKPvWIsApQ8Wbd2DaNxTvg+DjOz?=
 =?us-ascii?Q?dLFc0x310SB05QSCMVWIlaPFlGY083f/fxaNPtmLVCd5oIHyAGUP7xK2kdnL?=
 =?us-ascii?Q?om05OkH+fl7j8sbTLwv9G4cfePFt6l3KkZhSevMFXJ+TLkEmh0P3Kuy2DI6+?=
 =?us-ascii?Q?3xM+o89ktsLMo4kjapuuxawh25Culq5OqHPQm4w3uoIVtyLdi3EBPb7YDiqq?=
 =?us-ascii?Q?yDYw6zjq/eAC68aZqD6iqa9asKyRUADugoGL/NyjrcyBPekH6v0fOgu0tATY?=
 =?us-ascii?Q?U8Duxqpn5YY4WkRh9CXnjlBTJK8yXr8RF4DejH9FwpoIGEjhiUKq2Fg9qw7d?=
 =?us-ascii?Q?H7CHTivRWrF1QTtc5mMrzwbuLYIVLl56rfdDPbFHNqwALsC4K096LGuLLJmA?=
 =?us-ascii?Q?0QoDDsOIe6/nmIrf5pVdMb4FLRkupkL5k6q/x5Lu8T3MvCrQDt8Wz/wlSZD/?=
 =?us-ascii?Q?XKalwbhIbhPMAJGJpPDKQdWeaYBR2Oa1EPxZGPrr2PEJ5sXGr2hzs8xPiGQW?=
 =?us-ascii?Q?9VUTDBgGS67nC+W6Wzf6DJ2XdKICHdU1dwTVhTwjlaoqnSb1yAn2IBJEOq9w?=
 =?us-ascii?Q?WKE4h6zrVwNGwERiXYF4sukOHdAclzWS0ssSbpGXnN5mmEf9ZcBX5BnqAD9E?=
 =?us-ascii?Q?j50uNsCMbeeXZgy+Gg7dI40MyDsS/1ShkarkMXD8lxXkxPoxlLuUMR7XxnKz?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dceae1b1-d7ad-48f7-27c0-08d9e7571a4f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 20:52:34.0607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPiQMog+PMXmYZEinRBL0ypRYeRst//WAQkXYG/P7pNJTO6QcpIoLa7S/eqE+w8S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3091
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: GfYqHduZKDasH4U7CX5lsc7--HzRgm7Z
X-Proofpoint-GUID: GfYqHduZKDasH4U7CX5lsc7--HzRgm7Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_06,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=522 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 03, 2022 at 11:17:32AM -0800, Yonghong Song wrote:
> Added a selftest similar to [1] which exposed a kernel bug.
> Without the fix in the previous patch, the similar kasan error will appear.
Acked-by: Martin KaFai Lau <kafai@fb.com>
