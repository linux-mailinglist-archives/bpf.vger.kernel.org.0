Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0834A64A9
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 20:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242297AbiBATJo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 14:09:44 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31078 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236232AbiBATJn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Feb 2022 14:09:43 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 211HDgX3013104;
        Tue, 1 Feb 2022 11:09:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=v+2o1Gpmt2GTG8MkUJEUBB9q3h9xEpoxbhrc1WwLhAU=;
 b=FINu805aoVgAvDG6xl6jpTtJQEwme5yWxro4J6GZOrauuAN1l0UrXHG3v/cImYBXMomg
 RzE5DgDLDchYxnnaRgWbwLsV1+V28u8aadxvA/iFn3XU+PUxTTNQnZOk7aPRWhSQYcZm
 R6UDITUQTZurnjrtOQxtxAwBehfI+y4PSrg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dxm2p871y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 01 Feb 2022 11:09:29 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 11:09:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZdSaeQjOD9fMwXgHniSP/IF5Jb1+0ojqYO/WrS7BkSqQidyTuwpR1TrZH5Yl/sRVKl93zQBloopYSxBruGWVd9WtRVId2Zz3bKplDAVN4i2ixfi6SFD1uup2kbTs2Hx46upcXMc4xnDdccVB2X6Z9ZOsd/+uViZGOfa6qBsDb43Y7V+SE9vVtG6l6UzqHwCqR265sFNmeccNrkFkGddTS73bbKNV88Q3ZgBF6qFMbtNNmFoZRYSaRmg0vSYYGXa2iaatQBQlxFzkJLr5bzzv47GKRDTLXCCjJiSCeDdZg+eZ/KhYIj3V8/NAkKbeVP7GJzoVKxQ1LJ2YILylZlNNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+2o1Gpmt2GTG8MkUJEUBB9q3h9xEpoxbhrc1WwLhAU=;
 b=MuqFd8iW6i5MxTavYQXiTHrTXk34fpYQDab5fsQMUIrJdIYM2B2t7eAbksA6831e7zldXaTVjrvYdJ0yez3I7pIeZ6NAQzGBD12ETUHcGGw+f/EY6TKVfIlzKG0m6g0bC9j/RxIF4zRlCY86ikt8hPdaIdFu64V+L28PgJ7R+kbvEwjDvw6Ej4JOmhKmz3DaEp+Ec0M7kerJosEYoLW+ZcBoJEFS+ZW2C1YJ/KyyygwQtd/Da9xBL2IMzerksg2D9SXl0duBvXv0KsCOuT4PJDW7qsbID02v9Fyc1HdxZCk0lvkHwbfK25wWw/+NazUQT10G53h/uKYAGr1CWBgl5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by BLAPR15MB3937.namprd15.prod.outlook.com (2603:10b6:208:270::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22; Tue, 1 Feb
 2022 19:09:27 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::b0ca:a63e:fb69:6437]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::b0ca:a63e:fb69:6437%6]) with mapi id 15.20.4930.021; Tue, 1 Feb 2022
 19:09:27 +0000
Date:   Tue, 1 Feb 2022 11:09:24 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <davem@davemloft.net>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 4/7] bpf: Remove unnecessary setrlimit from bpf
 preload.
Message-ID: <20220201190924.qlavwq2lfncuhdvp@kafai-mbp.dhcp.thefacebook.com>
References: <20220131220528.98088-1-alexei.starovoitov@gmail.com>
 <20220131220528.98088-5-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220131220528.98088-5-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: CO2PR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:104:1::20) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a0c48bd-cec6-47a1-c48f-08d9e5b65e1c
X-MS-TrafficTypeDiagnostic: BLAPR15MB3937:EE_
X-Microsoft-Antispam-PRVS: <BLAPR15MB3937C93FB80360068117AB28D5269@BLAPR15MB3937.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A57dg1jaYFizUC0o1yuMHMhPZrX/5yKOmTeNttfdVt+UJsc3EsbyWd5Xu9Fa9ac51WHfBzP/h4uF/7+Fb8LghgPlRaI0IchPjx97BmYoms5PpS3jQ2VdwVp9+Vr+fs3AWqvnuxS1he1s2FETqa+2oNjRTWIGIG973C98lSM8CdMAqBAbp8VKHw76LVHW2ba05VFK5iMP4es6mCKfKu/EiQ7hAsbzeT3hTD1K4rv3hGhN/7BFnb5iXi+zo0uRZayyH1/7P1odx24se+69VsGYX0o+BrtjJxAYuTaysS0Kyl8x7WMIvPvhnZQ35ZZkzaGbimSrXhqEzBBqK1E8H+eZl10YZQvu6KPTW2AOI4SXEj0uos+z+Ic2AlBem8EDZ3bbPAoOmBqcmcFbgLPREz98C0b2QgL/j0Zdw6qJ16PpJiRTMsEkprFCjm+Wm6rPY5cpEb/RMMNNkWzizwQkQlI5+OcFEu0FUPosxX8wy6usaOKvhGm2PybhvO+/b7DHR899f2mCv5fQ00tWY9CrRCMhfFquPsIgM/SU5b0Ip4ZQ0PF98nhlbwXwt9J6sdbw1wRQEdedcqsyDDT2LSqGpDq4913GtKMZoHnuPw1hxnV8rXyZ5s0th3xmDVZdDmckVTM0eBm8y1sd6EiVdJx04rQ/rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(86362001)(8676002)(2906002)(66556008)(4326008)(66946007)(38100700002)(66476007)(83380400001)(9686003)(6506007)(6916009)(6666004)(6512007)(1076003)(508600001)(6486002)(52116002)(186003)(558084003)(5660300002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nd20g3PIWBMdJFMPSesZC7cX5XD4WCEXiFUVVVrC/3i4cxQSMr7dQgv2qg/c?=
 =?us-ascii?Q?LLSsoWt1IeQdOezU4DnhtcP7kGiH1g2piZylvQxQNVW7qy4FTDLJYuuDVSOL?=
 =?us-ascii?Q?FvuM17CeszjHz7/ExwVxPJVuHQHV7gVlNO3HxmvJ9ctvUr46YZY7LaKB9wq7?=
 =?us-ascii?Q?5g1GnF5SvfmYdAUQXqxN14sWfZ2sFUMPivHHNK7ADZSE3upxC+c9XMTf4P3M?=
 =?us-ascii?Q?FRLh8pI+Q3OWEe57hQzPUiYyhCeWYQUJRURH+axmHgs69Ir+tbrG2H1mYAPm?=
 =?us-ascii?Q?ho2k2vF7uG39amqSfw6pBHBP8zIus2SsGy+eaLC0ysBVT0VI59VYNNdZW6IW?=
 =?us-ascii?Q?J4TV2anzf3Bf8vhd5clIsXeahgim2duuPOcRX55OQqNXPL1CkyBvu+gy1oMO?=
 =?us-ascii?Q?rjoGcf0UEXc0wzhfxSbIBU976NumGK6bHBP4q0tI4ZfP+VjUQt25WMwvuZSw?=
 =?us-ascii?Q?o4x9TeYxnuN0f+h3ykkIBp3mLWV7QOb+SlGP2ryovzIKe1zBQH4rw88u9RBX?=
 =?us-ascii?Q?AOU6SK+yh8UyC7o3fEW3d1QAk12cFKlQmCrcR7/OYkv4fiF1SuS52EGMWC7O?=
 =?us-ascii?Q?VPJZxoKtZ7+vCAwaMK9XMN7iRh4u7JpsXsoZhHEoiM4s+BBDQOZEOoUZcjKJ?=
 =?us-ascii?Q?fsNZplOSVNRTjL5396a1eaKIcOVwZn2hwOxoFxja/ZMndnE8tgjTxzNENa1D?=
 =?us-ascii?Q?U9M7y3e+rvarkorHEYQX3U9r7ZtbB2vHYsQwsQMpkJNFBOhiHxlZYYwRo5yY?=
 =?us-ascii?Q?FcBTTyD+4LHtBPxJK1h2WoJ7yg/LILeqKVu3Qm0JsgKhTAKco+8Eh0izPIei?=
 =?us-ascii?Q?XtKXmMEdX27Xo6+xZpglQUt0u/3gPxwUogKsMXGlwPzui6vannqyznR770d+?=
 =?us-ascii?Q?sS7PWzBrbVlgL2nQOUDIP6r1Lxt5pj2d+ww7AK6Uzi844O5KyG64IjBFtH+u?=
 =?us-ascii?Q?YubSZzf6eo41kUMvnMEA0dmWhgr/MmnkXtgR6aEPuGvCPwSZuUzdOhEWBTwl?=
 =?us-ascii?Q?Lqftsg0br7j9ABaupwOPNJHa/CzxwgP3kdhr2O+BjqNClTOURgXHKSkFkDee?=
 =?us-ascii?Q?IkzRvgcCESjoPfwZMJOtZvNYnsrKopLVwxzRKO8VvNfD5EtGQzdiD+RWWg+G?=
 =?us-ascii?Q?c1RrVTmkiIjjIQGrYeFXMSU4dpJQma4mGckr4ec0ql1uaxoCZzMPSlHdgFZr?=
 =?us-ascii?Q?fVMpNhhoaF4HHU801Wc06s7IZigfB07WHxKPfXsnD3O9OoYXg8pCOuuyqF8R?=
 =?us-ascii?Q?iIqmFRdfwxKvW9MKWss9Y4iqCDkqwtKYYVVN81YRLGfDlE0t19wbwO48jTY5?=
 =?us-ascii?Q?n1xY9QJz9rGJZUoDTl0W9VKmc0TjQpiU7Eoka5iOsyct5Ab5cnu29mWXK234?=
 =?us-ascii?Q?+Ky26aEfGYwnBmKmMYxMDpKzvhS7k7nE9g3/hN+rdBvdZ6mOwCLVydzrLw+l?=
 =?us-ascii?Q?kcjI83P2bno9+9wwqI4iy597PwFdLPoj38zaYjfg2tPHZYELL7aUBC/IRSkt?=
 =?us-ascii?Q?oXYECNe3Ehy6/KujyGfa/vMtIhwkpOvA0qx0zr2Hw+j6o0BYv+FPF2DMbRPN?=
 =?us-ascii?Q?PuR2poVgSEOAyCg7qGkXuDmvSbX735s/LLkLZkrrpSBxyVeMSglNHcOlZnB4?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0c48bd-cec6-47a1-c48f-08d9e5b65e1c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 19:09:27.6794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6oy5Z9t+4T2j/L+A3H/tnyuSs5hZBDUCJOBmGMq1KNkOLGLqlcQ5gI5yMCPi+gzU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3937
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: Pzfg0HGRl9NYNQro6XUb1bAHvR0-jyiG
X-Proofpoint-ORIG-GUID: Pzfg0HGRl9NYNQro6XUb1bAHvR0-jyiG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_09,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=694 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 31, 2022 at 02:05:25PM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> BPF programs and maps are memcg accounted. setrlimit is obsolete.
> Remove its use from bpf preload.
Acked-by: Martin KaFai Lau <kafai@fb.com>
