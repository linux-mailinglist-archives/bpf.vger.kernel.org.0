Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8587A4A64A2
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 20:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239742AbiBATHW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 14:07:22 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53002 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242319AbiBATHT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Feb 2022 14:07:19 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 211HDePd013028;
        Tue, 1 Feb 2022 11:07:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=FY4zyKc5gWQ6viiG6fDB3yVvX45usSaHv45cSD1P3KY=;
 b=p4sZDASo2rSXnvP27awqF9przEB+JvkOEtyIzCJp/UAiYdRvWN4jCSNzoVVTTAmgfXSW
 g7Vx7Iukaoxk4J7uXNN7Vw2VAZZerjrkSR2peyfKZWORr5lJ2HZKlXlUjTLDrsf/CpnM
 JjaQg7K8wNAk6aALzvPec4iheYaQdEOKCKQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dxm2p86eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 01 Feb 2022 11:07:06 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 11:07:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hnu5OVzqP0AZd4hjRO1Jsi6fAF5dUSUP7/SkTrKaABXMGLgIYNdGeATe+09wzq6VoGByirOLvqjkZwZPT/LiKM5iBUouLEWeZ8nhEWKbIjE+4Ey6zNmOQyKJDk3FlzYRGs1FRa59hC5b3ZN5H4YPQg7ecLnTN+LrdlS2gLaqGRi0IPTtkeR379Uuj+SM0h8AjS3F2KMzyoUvSvKRccFyEtCvdxUspCAB/HM+Y44VQcGs7siByhQIB4zhUmWI/gk56z81AoUnSj4/W5fQYPY0YHbb70GpPDeBZShR2ajpf2lxqCCnW3UiZ/joeapJ+e13+cpzAIEUVqX+kGM/d5SaoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FY4zyKc5gWQ6viiG6fDB3yVvX45usSaHv45cSD1P3KY=;
 b=DwITMz+EvG7xy0JhB4FTUY4SzClk26xoWKn6DXewIgAUArgpW2rrf6eXrlvTMyGvTFKszEvC9iAU0KbALeRGL+0hJGPVm8ZxVhkoKUEb1IKcwgGB+m2882fs1HQgNb00UqGnvJdzSrFcZ+brTjQk13O3zV8x09AwK85FHs9LKPGMLPpotksltfHlx4s6GM+rSxtlpto3EmlNt8WR8upHmwV1m1yw6zvoJp25PFdz4W8Qi61+HrcZ1u2pJBBd1JEHefGZFOpklFzXWHWUIOguB23xSPf+FqjJqW2EPc+oQZBiRqT3IFVoMBKPUfJEoXb3FQ6YeyLOHc2jadQkYMBkgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by BN8PR15MB2817.namprd15.prod.outlook.com (2603:10b6:408:d1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22; Tue, 1 Feb
 2022 19:07:03 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::b0ca:a63e:fb69:6437]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::b0ca:a63e:fb69:6437%6]) with mapi id 15.20.4930.021; Tue, 1 Feb 2022
 19:07:03 +0000
Date:   Tue, 1 Feb 2022 11:07:00 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <davem@davemloft.net>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 3/7] libbpf: Open code raw_tp_open and
 link_create commands.
Message-ID: <20220201190700.4ovrrkx4f7blpzla@kafai-mbp.dhcp.thefacebook.com>
References: <20220131220528.98088-1-alexei.starovoitov@gmail.com>
 <20220131220528.98088-4-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220131220528.98088-4-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: MW4P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::9) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f870fcf-1f6b-4d9b-9a0c-08d9e5b60801
X-MS-TrafficTypeDiagnostic: BN8PR15MB2817:EE_
X-Microsoft-Antispam-PRVS: <BN8PR15MB2817A602F6A49393BDA6F198D5269@BN8PR15MB2817.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dk5Oa6rXLgvBcBjcdSIFOWcCzuXOac8QczBrASQ+fytLNLI3qazLbNiCd5mjrN0vEXQTx9kcDHmh5X4CXzc/cE0FaEh0CD7rzOfOGTZjop8kiMpKAleWY/j3mxr+edjZ4hO95sUBgNsqlAcSpvpQEZjNRke3TgzLf+QJBiRDqd6bWrw9dQnUpkJRuRtdw1lD4aenB0m8tOahZr2LCD6HZ471B3ds7sbNWbHqgwHjkOD9IfmtOWHJCVb4KqDF5fw0PQMmdxJfBrLTAfz5DB/w/lN/H31xX2eK17wmaKoM+Kw8oPkxkGcfG+OVUowe/CNHmL9C6ns4J8ylO9wvhyhrjPZE/GWwE8TyvKUROrSqcYgqnn8sXmhf/iCs5OaXAUNnluf1rJkD8XpPNJwmPeBzhuj7UPlhReOLW1EPVO/IlgeknsxIYAVt7QCkYNFnbeEQ24op9+qdG5jJCdxdepuxDG7InfAwV4Tpq7PMP+aoRO7uXvGJ3mRCdSgcW2GaWqlIFrqenJQhi5nwZvMzaizfM138dd72KSkQw73YR+Zxb7/LhNiTRptqrHYvkiCw897eiSTeHFUruJ8/9zy/QCXnZmAWbyx7ix5ed/9OqJCNxs2Iyf3H21RLumC7+kltaUkXvqYIo4Fgd14eSAsFrGxDNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(558084003)(52116002)(9686003)(8676002)(2906002)(6506007)(8936002)(508600001)(86362001)(5660300002)(4326008)(6486002)(6512007)(6916009)(186003)(1076003)(316002)(66946007)(66556008)(66476007)(38100700002)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WrIpAta5A5nw9UMlJoNOkIYdaA0ax+B2rxbGwIcdDYTi8uum18a3cQtlFvDX?=
 =?us-ascii?Q?8MgtzDSOGwrHwrRx7vSLb2eYwfGJ2fx7aSZVzQZ2Qhuss3E3B1nCHj5jp1Dk?=
 =?us-ascii?Q?lgkhJawV8M/R1Qn4se6DP/Ivcrsi3mMfLWDkMRZr3MS3749v0LhQvYRmkpFF?=
 =?us-ascii?Q?av83jcjJYX9eKhl8boRvUasPTYQzX7oE3SNJaCqpbm1ppueUZ0+3LQ0KLmx9?=
 =?us-ascii?Q?x1z7qIh/vTQCQWT9zaOd/18HMUynaHD0Rw878S6EQ3Va026RIC0LBL7AO/o5?=
 =?us-ascii?Q?GfFI7z8c5KOcZoNCy1iTW2hgWV/rsDdVPhZlPsLxz9ndtWEyFJZIvRG8dJ4I?=
 =?us-ascii?Q?alITgPR88qeoLSiXTb8a5RyAH9OZenWCFYoHf3xdhUXunrNmIsMA8Omyswoh?=
 =?us-ascii?Q?WbSC+m8muj0m6kgfpDQDoPPxSjc96yF28CQnnZA++zDrl8eYYRnN3hHkZgqv?=
 =?us-ascii?Q?y/EPEZDyG0sDey5r26XV9NwLnRgn/rOlM0a7KmBVZEX0j4BzvurlCJbEWOuY?=
 =?us-ascii?Q?vK+xjZOCEHaPb8bfExfA8HOgYWQlWVJ4uhpkXVCEhw0zwNz4jK7ulVrVjrRU?=
 =?us-ascii?Q?RtVFWG0H3Rxaye+K0Aw/T5zizVSZBL8wKccmMBZ7dWdSbI/XdGcu6xwQMmgd?=
 =?us-ascii?Q?MJ/ftC3VG9Aq1PMoMxp7+5A/W89hUN8WzSvPW6OMOBR8ofsoSs7ih/NbZsy6?=
 =?us-ascii?Q?tnEanU1Nf8osidgBCYOqzZElh8HCvWMR7CYtvJAcsFyROtDjNkJAa0Fvdw8Y?=
 =?us-ascii?Q?iz9c30IHDCrvAZX+1KpSTABMkXlU9qNQyAEth8RwycPofaH9eY7/GRVbNnp8?=
 =?us-ascii?Q?XJI8N8X5+EgZbhNxC0K0xg1HyvwYGoVEq9SXsT2XDngtnvB8vUrAdiUNRiMo?=
 =?us-ascii?Q?3e+NPw0/hNJlLKnDCslFGiqJQ2JTFqfFVEC9hfZY5PmLv1Yx/ZzBLhVAzK60?=
 =?us-ascii?Q?xbd3un+xe7TvtutEiPA9VFGgRObRgy7cZCWEdJFexLLa8bl6PD7P6kPZ77IU?=
 =?us-ascii?Q?42p5qH4IzDhyAGdnLf3MhU5+eKU/8tnZpZBJUfKeR9VV6j+OodPbGPq/z++Q?=
 =?us-ascii?Q?OJNtST/cjmizeGF9UaZt6gyGbYaYSbteLIBX8PhY/eNuZ6DAUVlLV/zv2WDj?=
 =?us-ascii?Q?jn2I4KehcxJNNO8cz1mKcHnvVDtXnFG9pcKQz4TPV5BlLNaanO00Rldx/z/1?=
 =?us-ascii?Q?jHqKDBAYclb3qog2vq8vasK36bjtMg/3vCKg9JnDi3jZzsD4jLTBMdQittrg?=
 =?us-ascii?Q?c1qhbKCf6YNQoXqK2MfxpYGrgaQ8UYRj0VehEh6AdmuYtFoCBMs6EAC+rnna?=
 =?us-ascii?Q?ab6K7UEeuKRQcchP04lkNsdRHidVGKe8uVXyLevs56xfH2A0aLU9gBgGOJMw?=
 =?us-ascii?Q?IhdVXSXkxWaZIGpYMvEe/wHBOLxVc9nfbR2GdqH46upaYOwkO3glZquvehWF?=
 =?us-ascii?Q?buzPnpPBsgolAHSjfqP5rtKptbA8gGIoUGdWfI6ZqaT7uIeCzK1rb6FLryaN?=
 =?us-ascii?Q?ZKxuXl+XL4Yq3v3clODCre6IbbQNpWNjQI8ZAq6cnwtSZ23lY6HJlM/F7M74?=
 =?us-ascii?Q?pT0DGmLGwpmnM6T73MwbzZ9kvqDuxnZwuuUhypPJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f870fcf-1f6b-4d9b-9a0c-08d9e5b60801
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 19:07:03.2788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMIl76UDNB7f6Duh18pRkwXx/mOP2k1FNzeqx1eTvooKlHlGv5QzLsmczfVnEwln
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2817
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: QNnUsJxN6AxrJn_NwzBdYw72gSX1XKs9
X-Proofpoint-ORIG-GUID: QNnUsJxN6AxrJn_NwzBdYw72gSX1XKs9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_09,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=636 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 31, 2022 at 02:05:24PM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Open code raw_tracepoint_open and link_create used by light skeleton
> to be able to avoid full libbpf eventually.
Acked-by: Martin KaFai Lau <kafai@fb.com>
