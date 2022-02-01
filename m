Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6824A64FE
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 20:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242362AbiBAT0a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 14:26:30 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7632 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242406AbiBAT02 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Feb 2022 14:26:28 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 211HDjLt003844;
        Tue, 1 Feb 2022 11:26:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=AWxqabREtIffmZy4hs+4hAClF9vTaDwaj4dHNVbq0X0=;
 b=C/uByoOPng+VjUX9FWyUqbgGUJExstpPzqJzRRVH7css7vDuo+mxUZH3ZdUaysuSG7jn
 eRQ4liSQzNh3csfAjrN0R4Rl1YZaHEuqsihldAR2alRdTP7rPPV21fHCS1p/Vl/5bZPi
 qpeWU538NHSrSjlygXbVxXzwJd4jpmeCzmY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dy6n9t3qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 01 Feb 2022 11:26:14 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 11:26:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wu97pyMgVLg0dlsBiTyeFgW2Y9DVHT2rfNomEsijhfeVWsVEYN8A71OzP9iFGdiNyjYD4J36JN78umDLIvfdo++fRTggk8uV/CcPNaizH7UJmpybylS/Ab74iRCGhtWi0WOHV5IhvsfZ0cr7MvHQ+VF1ScMc2XD2Nq0Sana0TgehV8SL9LR1fidZ1Un0+a4xy2LxspSUac3Tl5TEB8HhkY5cvN0vcTB8mkz4a/Lwy+9uGu/8xUa5MEfQ/wBDvHVdMmileL8AiT7HLqWFL+DZuEFrRk1Q2l2b+J2/Ab29r8czX5g931n/eYTH83IYepf6DR25WkYR7JkjkymZbaz1eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWxqabREtIffmZy4hs+4hAClF9vTaDwaj4dHNVbq0X0=;
 b=e9MnVx73RY6+Z2IFoZh3sb8igFhJQKNbccDAyDoaFolJydm8aZQcyMW0JfMv9L25AHj2XXz16i9Tkah7RiOQCsXZEYyoSjbIe1xv6Q1lUSKUTB8Fel74J/2ct9r0s3O7zyY2bNqu4xD9qZO4XSEyCOBmUHOL1HAQJADGCO7DJRmDcFMNVXCibJsCuFCf5T+SxYO1y49yqHxtOnO9UTkxP8huwJJCizT8K8Rk2QEqBOKBBZ6nwkriBR6W9e0GFPo93Cfehl1U9w9Sa+8/L+YwrnRGAimWIJlfwG3tKqXXZtoIBjo3Rj7wFInJH5MdQURMG/Uje+9x1gRjKIbuIm2y2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA1PR15MB4452.namprd15.prod.outlook.com (2603:10b6:806:197::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Tue, 1 Feb
 2022 19:26:12 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::b0ca:a63e:fb69:6437]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::b0ca:a63e:fb69:6437%6]) with mapi id 15.20.4930.021; Tue, 1 Feb 2022
 19:26:12 +0000
Date:   Tue, 1 Feb 2022 11:26:09 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <davem@davemloft.net>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 6/7] bpf: Open code obj_get_info_by_fd in bpf
 preload.
Message-ID: <20220201192609.7bnnrnz4fklxu5eg@kafai-mbp.dhcp.thefacebook.com>
References: <20220131220528.98088-1-alexei.starovoitov@gmail.com>
 <20220131220528.98088-7-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220131220528.98088-7-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: MW4PR04CA0320.namprd04.prod.outlook.com
 (2603:10b6:303:82::25) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53fb57f7-c9e7-4dd9-e6f3-08d9e5b8b53b
X-MS-TrafficTypeDiagnostic: SA1PR15MB4452:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB44528B6FDEDEF9489262371BD5269@SA1PR15MB4452.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pkwDShdBKwmqCc7u8I8nENf78lB7DMPI+jcw8bVZ6GJ3AVdWcuTc01H1K88H1jJNxkNVAGK+KR3Dv0dfBbyQck6jR+sy2Ytm23kbHqrlEAHxLXmJAmp3j9h1SBUffbdTsnRUTNcPnNmbRiiWnpcT70hrAyvtU/2p9womFI1gQ5AwYiwOZFGlwwyNpe2gtoexvU1TvifLZ2IdC0Bg+FhN2NGV3GAvC4hC2X4X7xxdt95uGasEbQlYZEg4ZBbWkD+rYzBvO4efaL5vcK6LOu3cYUr21/YQa88srNk7dCCiZB0sSsLLBVg4elqOQCUE0oBg2sSQpx7nrswKs5D8c3C8U8tt1fesUU6Jtx7N3HXwk5UurvGi3Lju0PwQIMtd1iGyz2YSYnRZY4cnr/5XC5vgzTE80Y0KwMSgyU5fvPVgY56Uzlpz+VQDnU5xNe67XxPFt/EAq6p7ds0Ya4tSlzwv6ye1OtI7tG++HeZJLbFeZcrSbNbZde880YE23Ls6NRW36GVWRC0/5FIuk79r0vQMEw8g27fHrerUO8m4d05Iyd1vTpOgoWzi3M3OG+/a7YQ2Etno/3rLqFaxd4/r8a0ixcgOYV2xUmS8uGwmx2lqIiZMYNOUL24Qd0Fgxkxq36Lorm8/K0k9ZCBPgZ9uin2W7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(8676002)(6916009)(4326008)(316002)(66476007)(66556008)(86362001)(5660300002)(38100700002)(508600001)(52116002)(9686003)(1076003)(186003)(6506007)(6512007)(6666004)(558084003)(2906002)(6486002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SuSUii5AN5qgMD5mCB6An5b6MQt5kCYSsw/dl0iCIiYfzUucRuqp52SsBsDo?=
 =?us-ascii?Q?P9M/BSdE07fOoZ2GFPnTtWs8A4lPxrIaZQSGmAJbmprYvDPoHD1mwL1GbWbh?=
 =?us-ascii?Q?S1GMTBay0muTaSIVy8Rgm24vxEtu7tKFRZGorJlTqwEuEY+i47dacC2u53R1?=
 =?us-ascii?Q?yHyE8JfouOnFg++pLB2RRjSysl3p24gGvYnmGghBKzPGMZuQPIb54V/9avSF?=
 =?us-ascii?Q?ULzC5kjn6WnZsMgjlR1fAiFW+WUb43U8gQvJI/rv0nFjw7BuFv5BXnYH/qyP?=
 =?us-ascii?Q?mANw2fSBNpU6iwKbJxnPh8WiD9/0gdI9SQOfJQ1zjwJSvoQ8cUVnB2Rj3XTd?=
 =?us-ascii?Q?u2boVB/KU/KNRJbbokqxuKd/YHTW62N5nuUYROqaQ1Uss0RFf7W9EfPgkXbm?=
 =?us-ascii?Q?a/RykASadkKU6prcM7MwA+8ygIQwkxNK66Zx/vg1D/Nr/pnJjGrZb+mUg2Cu?=
 =?us-ascii?Q?STMTEYEJwWR3pR0XeDVxeas1AbR5wxtQhYnb0WRNrMgOT7RNddQVbUakzYVh?=
 =?us-ascii?Q?Pn2VmfUQQeqIUtYcf073wRkEES1aGYBdtGu+vWrwFgFBSjQTb22Et6A9xIzF?=
 =?us-ascii?Q?0G+wmcfJcZ1pC/Gr3fd/5Inv155wKWd5mGGO2QteWUyT/UlrVagtsU/Hw1RH?=
 =?us-ascii?Q?ZHd8Whf6PtQKmfWh17Ebn32JIYEpsVs1JS22rkZLvAtvwgxHRFOX2SiQ5FDr?=
 =?us-ascii?Q?CzDM7x/MqVjaOwiBUcBnssNCZ/wW7L/9xHTrJ4SX0OMhAh8oY2GSfcElTIWU?=
 =?us-ascii?Q?1MPqS2fYKcuIWXwYSrlKbpoGaCQVTMkkrqE16aPKtBc7D/ZOgaXPZ/9eypT4?=
 =?us-ascii?Q?2CovQ6PgW0IZ4pkRykUmqAugGrGlpJ5lQxoyimSw2rp77AVd5LaiB7xsFt2A?=
 =?us-ascii?Q?HsecqgsdJBb/j5i5yMlrIc16OoKMOJ7FVoQYhH+O75x6MepKPyAbYFJ1doTI?=
 =?us-ascii?Q?Y2yWx5hHxABjMpG3BxCf16vWwkXGDlJMxqVClaXMO6OcAaHkUY0EawM9nJWU?=
 =?us-ascii?Q?tzouxZx6+H/VncpUaKd84JKAWywOLWXy3y7MlP0XpyQyhW7pc6guO9b2EOke?=
 =?us-ascii?Q?1L3gUOy449iHFqbENwHOYCnOAulwWEnK6cBnffgJsk9XCHE6Af5nZ5dR4dwV?=
 =?us-ascii?Q?mrpbeoKEpelWv/+Zp439sotVT7wQFiS0RrRBHxdqQIV2qaoa0lIPczSsEOUN?=
 =?us-ascii?Q?QogUfYP2xbXbhYzRHsgbCwz8sOKsSooa9V9ir5Ua7vjyCz4CSgaojul3FLJb?=
 =?us-ascii?Q?zVaOOisfu075fzINsAJUc7CDVbRsGjvu14YXqBFjfAzaOG51mp2IV6CfL1l/?=
 =?us-ascii?Q?IUtqMH1nK+Xj5wWggr0DvNNLRoQsX6cmDFswYK88ev3KNXH73sH3UbkSSpwq?=
 =?us-ascii?Q?mfC/BEqmOIzM+NGe+cyWeCHUHpzBsEE1RV7Z0RX2/mRCjyGocELEPRsw/ak/?=
 =?us-ascii?Q?uNu0uqCi3ROJBoaxz6uEw1GSGTdWEoZrZ/xrYXx+6O6Pbb5NU/D+FDIzldzq?=
 =?us-ascii?Q?A3d1HwVhc8w5dOVEPKfiBhwXdhXFRF7r8gVOiFbt5rOYoseEL+N+Xdez1eTw?=
 =?us-ascii?Q?KyhOiAh4pUwBjAl8HtRZpsgjQpMUK33vH+ipOmN4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fb57f7-c9e7-4dd9-e6f3-08d9e5b8b53b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 19:26:12.8386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IP/ibBLirVudL6wvoJkpvNgB94XjyaQMpdNjYHibJYMV1kyfyNh3J3Xc9dv+xVNZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4452
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: LtPBD-MPMTxweruJWdgiI89AI4FvnpRJ
X-Proofpoint-GUID: LtPBD-MPMTxweruJWdgiI89AI4FvnpRJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_09,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 mlxlogscore=554 mlxscore=0 adultscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 31, 2022 at 02:05:27PM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Open code obj_get_info_by_fd in bpf preload.
> It's the last part of libbpf that preload/iterators were using.
Acked-by: Martin KaFai Lau <kafai@fb.com>
