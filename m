Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC6658F0F4
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 19:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiHJRAl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 13:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiHJRAP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 13:00:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9963043E49
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 10:00:10 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27AGuSkE003225;
        Wed, 10 Aug 2022 09:59:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=RF/ove5+ZKqHeBS381iyeHxvnzkErCbTF0mkJnW5Qos=;
 b=cSRI5fHkGo+9kJCqUkrwCdLu3/wjh3CdlrGajEcJ9M4pWOe5OxqaX8lJTaTC3106Mxzb
 DQlzuqLqTJMRf4ZxcHgoQKCnTFDGWHeEFijkZrcqQTvoEERoe60sw5zH/XWE59QcyfLO
 d0q7oiWkvnOolVAEIFEMkgVf6B1KWdes2L8= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hvdb69y8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 09:59:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cg3wBGF/qc+1XykcGqrchvYmhJ55juYIrUI55+5anhNf10bGKJi8NlTBn+6tsCyRC590y/bDEhZuYfZetrLaZeafF2C6g1iMHEWg3OoqrVhmcdJpRHtiQqsW03RWoEkrDmDdbXnFxr8+2z32cqeXy0gdn0A9T9ViPDobGJ5Wg94G0bo/l8jkouLfLOUiAcS83PnviqIMMxZaFogHN4sH/H/2uZYjfDOEYC836Lelm4KrvlaIjwPgJZ1jUsZQuKyuEqAqz8a1Ij1mnjXmHLNAu1l0UtPDlupfkOIySVggJ2HoAUGUUVFfN6gqmyStqNdiFhcwFEvNl/6IyVN2zfabvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RF/ove5+ZKqHeBS381iyeHxvnzkErCbTF0mkJnW5Qos=;
 b=RG3FPTuNeIYPziGxU3MW5AZ/hcb/gTfzUvrahHMLfSCh1BTa3a8GqmilN6ScMDLAt2TETVcA3lQTI2WU6GzBxWhYHQgfRGFJUJAdoBXhcOyewoGpXIdCRg75ZlHfAUPc5B7OoOCSssefB6R0DcanEWSi7MHVDH+2RAJM1wVKJ1/yIzW14LE0DOsISvBt+yulVG/fgnRihB/FM5DwLnrA7pW44BcxqjiTRpiMcdyH4ON4xvdSResBuM4wbxARUO+IkT84cHEi7PQouPzM0puVnyRgxGLtXzaRdxb6sfwxUbxybkZE99kjENY+xRqPRc+wNT7b7FDZNB6FzNx/b2N/Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BYAPR15MB3126.namprd15.prod.outlook.com (2603:10b6:a03:f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 10 Aug
 2022 16:59:24 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%4]) with mapi id 15.20.5525.011; Wed, 10 Aug 2022
 16:59:24 +0000
Date:   Wed, 10 Aug 2022 09:59:22 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
Subject: Re: [PATCH bpf v2 5/9] bpf: Check the validity of max_rdwr_access
 for sock local storage map iterator
Message-ID: <20220810165922.gaojcbhn5vbwvrjo@kafai-mbp>
References: <20220810080538.1845898-1-houtao@huaweicloud.com>
 <20220810080538.1845898-6-houtao@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810080538.1845898-6-houtao@huaweicloud.com>
X-ClientProxiedBy: BY3PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:a03:255::8) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ffcef1c-dbb0-467e-886d-08da7af1ad28
X-MS-TrafficTypeDiagnostic: BYAPR15MB3126:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fgFu7A2Y/d+BbCwei6ZYqsElAZv+ckbW19CJhs8uWZwJM5wBZtoObklVd4J/ecBilq8E+XbAyaG2cWzItPU2E6b2mAQyBjmkvuEJftgqYt28CAny+d/YLVc+i4g9lOOLZ9QfZRIVQdTDwAo1OSFfZfWcqXV+GvsPOrioPAuC2c6a45ZNYmEx/V1Wqr0u4TKO0G8kiVIvstwzSxYnAIvH7TaXnubNYYp/oYFNB/YYQfXgLY8yFBVv/5CpZbjgyyEhmr/4owTM5JJs16NtOG5hylG1bIvLZ5JDY7v+27RXLCSXFBcFr+EAsStRbpt746q7DpEjQLmR9KAWmvQkXDkmuzCfbtNLx6bIBMji/FKySHDmRaG4E+Ip6/D0r0gdbGvIpWhoi6qdbbEIZc/Dcrkt/znaZJ9NSErocljGB6cmeRPBactxpH6rUywYn9oq/+EL24Vf3pF1gPdZOaQIZfkJNCtse9vUh/5TeJF1U5cxA86EYlVbhy3ti2qZjwjINSMcKZm0BzY/FATfB0VYSxLwFtrf3H6wCymX3c1HyyTvaR0kD9SFqSj9YAZl0CBiaxa55+84d8uC2dFv53YWfSELlw+j41l6W6C5ch6BSbRvbjLxOs4pSrJXSMCzdpsfmnprmTde3bYr8onsOKF52z2vDLnxtqfnvsUbUT5GvjEzy2dVsEEJi9nEee/K5mi/oayOCvTZMO10DvyPkEXqazYyGXHZz0Zhi44/49O0Uu6j00+a/YP9b51AWVKu6zIkOUMt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(5660300002)(7416002)(478600001)(8936002)(6486002)(558084003)(66946007)(4326008)(83380400001)(86362001)(66476007)(6506007)(1076003)(186003)(52116002)(6512007)(9686003)(41300700001)(66556008)(2906002)(33716001)(8676002)(38100700002)(6916009)(54906003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2hYJbIC79LcgnIRz2pMxRjxh6cOF5aZhCXT2kkEFkZxjxHMgDjwYMTVE4gfs?=
 =?us-ascii?Q?T/YUbtPM0Zzqlqc0hV7XNb8BPJUN2ChIV4BQiRRMCbYJRvFDkgcBTwVj5r4Z?=
 =?us-ascii?Q?6wvF6wAOc1cAm2H6o7IDbGTzTuSVo1A0cHSc/xGfK8N9Ovotg0SWp7j+qg7/?=
 =?us-ascii?Q?QuqOV7Jfmi91kkfQE0o+CNy3CPNkaRrX6pjDnf99Dm9BesgG8RLugcbWtqc0?=
 =?us-ascii?Q?SYfNqki1hH5ElU2efvmN1YlsrxalrDxvzV9gyUwpWEu3lRbtPsFuz5e1tCHg?=
 =?us-ascii?Q?rdDA10rUBr2BQC74WL4tHqpZtOaYqzHvejaUrd1TpwLB9TrjALe8KktTw+Ct?=
 =?us-ascii?Q?i0g23AaWZiEalaaaG82/f9VPnIgExIA5pdn2IjkxF7WFm0PDBNQnk5f8UauV?=
 =?us-ascii?Q?I/v53SSo71k/kUjwEDBOla2ObHcnKn9KAqFP1V0YwM7o2yGKDCJGEppAIDHy?=
 =?us-ascii?Q?XTem7TfVbN9HQ5UfOF/tVCznmEnyOn8lmAmRFoZVpej6Q6+UQERVPmBniRCD?=
 =?us-ascii?Q?tESMCgmG/fnMCMfMR4WYDP3aQFFk3iK6tyGK36aWwNXksb9MttyasukrqOjy?=
 =?us-ascii?Q?N5K98ixMKoi394baA+XI9uGZxiUZHRVLvXtw15VdzJBls5i2LOUMGoPEBL1h?=
 =?us-ascii?Q?GelQdtPciqUIMXD7cMMzqLdpwCqQ4x5HbxpkpXclwUnF1dc/K0SO4jwidHKN?=
 =?us-ascii?Q?ZtZSZGeKC2hraqIYAoGSMYQjFudezcWhbL6V73LR4gGF2z3EIOg5TH/n5/gZ?=
 =?us-ascii?Q?LTt9T+iu3+e5N9EPOjC6p9895NqbNs4OUQswcW0VZxVAVt/+xPhTF9yRx6Uy?=
 =?us-ascii?Q?FENpA+X6L4aw8EVC+E2auWmy7yOxb+UvKU8BvSU7LcqfYrMNaUJUAV9X9ngh?=
 =?us-ascii?Q?hYmTIuJMqeWvU8E8z38QGucbPjIro3QRXw6/YB/gpf0cC2mauQ+zNomZuIFL?=
 =?us-ascii?Q?RU58AD6+y4UKzZZvryloK9YGvZZQwP/G7JO+eh9jXoZkeMmvbPQF8UmYIPk5?=
 =?us-ascii?Q?snESukOQ5Q2Dpn0jWyB15GlQgLjhcarYmU8wukT17Vh4MZeFu+aDDVSxSJVl?=
 =?us-ascii?Q?ghFiv5/TlfBwd9mMxoPQiAygZaJIa+sdWEOTbN7jpRCeX0SbwiHuYKKHiBiY?=
 =?us-ascii?Q?JTHp7zx3EIaORt5tkrAxFkospV7oXffcYMdt+Ib8/wes5n/E/YYMivqnjfRv?=
 =?us-ascii?Q?7+OKOlb55MIMz5RUFwQmiR2az6Yx2uAKe3Ms7S8nh6FUniK1P1K8TrDrscA2?=
 =?us-ascii?Q?xFLPPsrIbVC9ya7iKuQCzL/pIQl0Df1F+MOE0jwkk/PE9USyv6MTno/3NZ6q?=
 =?us-ascii?Q?G7ZXdy80+wOXGU3BZZGfXqZFCTW/SjxjQ4xE1K/WPmQU8h//Lp2LiEVfWQ+7?=
 =?us-ascii?Q?6dvsCxz9CpcKdsDpwNIzRewtP+zDz5b3YCUuXlwYKFFenijgi1APlZxXG8iu?=
 =?us-ascii?Q?kw3qZpO97ghNswTXR6mU5r12zVtWR0iSLZcJ/AkXGWOPN1E419yXpx0J8IIc?=
 =?us-ascii?Q?i/oEa1WnBCeL5YLtUsdXB9guMjNOpbFozCHI1MmPscGkVMp0cKtemsjz3e3D?=
 =?us-ascii?Q?XKbdolgLTsoIds3ljih68fw/xaSqk/50t3xDPJRaOhUkS6Nz+tfdb0jGO2ft?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ffcef1c-dbb0-467e-886d-08da7af1ad28
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 16:59:23.9824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNlKit22pZ6qT3kD4uSWMgYbczoQhU6aIsHgm9+hWhhY+00ohY1WnDlXoyVrirfV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3126
X-Proofpoint-ORIG-GUID: 6hVu-vwhEUoaLbevVE5NaluRBpI-XF_B
X-Proofpoint-GUID: 6hVu-vwhEUoaLbevVE5NaluRBpI-XF_B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_10,2022-08-10_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 10, 2022 at 04:05:34PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> The value of sock local storage map is writable in map iterator, so check
> max_rdwr_access instead of max_rdonly_access.
Acked-by: Martin KaFai Lau <kafai@fb.com>
