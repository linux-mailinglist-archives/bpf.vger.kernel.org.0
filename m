Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9144E68C8
	for <lists+bpf@lfdr.de>; Thu, 24 Mar 2022 19:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239200AbiCXSjl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Mar 2022 14:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242760AbiCXSjk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Mar 2022 14:39:40 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD9F11A1B
        for <bpf@vger.kernel.org>; Thu, 24 Mar 2022 11:38:05 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 22OCIbOJ020169;
        Thu, 24 Mar 2022 11:37:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=kFfqyOIScqJiDLGQvKm6y99oHNc2t5239lVZhfVIDkE=;
 b=kQe32SlimtfrYhtC2OPAJN9AoBR3dFVKkD11OxPoN4PbTwBKqv5FqEO455TmBzdkuCw+
 6flojZwuzZxsxOHh49BbvmQlG8iBfdw5lVYOzasNnE367iIc/ypoAWn2bcXLXqbImpNe
 H+hQ65XHCD6OAdz5gHyORVwNOfwvwsk7EHk= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by m0089730.ppops.net (PPS) with ESMTPS id 3f0rh9aqnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Mar 2022 11:37:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nP4bp2lcWhYjXIqDE75OwtIoz8ezZfOoYA3ImLiU2U6vzUVfcpwGD/HM7KKZJPqmeEFEpQ3wDxTE4DAdQsdedCo4yv40hhh7UJ7KLKwNcGKfNWqAtrbgOk2G1nV2TmDQMWDGQlCkL6mvxOkDe1lFoYDaAbngZcmEHgGSTLyH3IjgKCAue+JFv5PK++4MdxYQF1kfB8OPLs9E7sgD5eoDLfE5AH9QlWUVbztof36IZARiPmRwLsGwhSh/mpK3urGC9wY4BGXRi0B7YoTHgc56lfTMCfSrQNDgMyx5cNXLPA1Zc+Z89/WvSN50+1j27DsRGSTKDhofisjVFS6yoGhlQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFfqyOIScqJiDLGQvKm6y99oHNc2t5239lVZhfVIDkE=;
 b=jHarbk93+MDay966fRo+OnfDVCyDt+NJsA6D0twTz67NY3Cm4DsNn0EcNmh0mXyDt9X/40w7z+a19bP8ba0BO2NLaOL1PceizStEJHkVzuudiAA1eOiJE0LxctSs1Rh/evXB4XxW7hktZLBUmRA/PY2vKv0UK+9CT8Jeq8fguERUUrYFWzn++GXLzOZmS5bLHwHwfZQp5AK5noE7r21Xf5hBsJZJebmo8U/yGMF+Qt9Z9raK4Qb2AzJIdNo9XJHkOKT+N+onwLtOVgUcm4XlmBdIn+NVbjycO+csmbbnpkvBZnbqLN+dC04QRgZPAvfYp6l6v9oSky1jPtrBsrtoDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by BN6PR15MB1825.namprd15.prod.outlook.com (2603:10b6:405:53::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Thu, 24 Mar
 2022 18:37:47 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca%3]) with mapi id 15.20.5102.019; Thu, 24 Mar 2022
 18:37:46 +0000
Date:   Thu, 24 Mar 2022 11:37:42 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Geliang Tang <geliang.tang@suse.com>
Cc:     mptcp@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Sync comments for bpf_get_stack
Message-ID: <20220324183742.hq6wuijnrgevj2a2@kafai-mbp>
References: <ce54617746b7ed5e9ba3b844e55e74cb8a60e0b5.1648110794.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce54617746b7ed5e9ba3b844e55e74cb8a60e0b5.1648110794.git.geliang.tang@suse.com>
X-ClientProxiedBy: MWHPR10CA0050.namprd10.prod.outlook.com
 (2603:10b6:300:2c::12) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a410f43-faf5-4a09-33f4-08da0dc56426
X-MS-TrafficTypeDiagnostic: BN6PR15MB1825:EE_
X-Microsoft-Antispam-PRVS: <BN6PR15MB182554E07378C10EF6A21791D5199@BN6PR15MB1825.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mlf7SC46cP0EYk+axIzqMoWB1+khee9Zfu+NJkRJ6fZFv1Ko6cTx3v0rgtHwSiI5kSWblSZ9iAN9TTochDaQoVj4xgwNMTa5WS+w7ZpdAf1GLamVTXC7D4iN6Qii4TeujdrUMeBgPFQjpA6jydGIu/UV7DwowJEKG6FSmwNarFAWS3MQNo7KQ2cREadCXwdBk0JT6HXrmujlqxSNUgJRHsWS9CiepQNuXXvEielALWBGZNw8D9nteTZTqbK6trc25CbSIM9e5edzmfLdYWvqSHYq93GCwSke1MNp/mQYM/7ibup47IUhWjYNlnTvUhbrqr+IMo56DFNjn2SfM1wCCbfEWr9kAKZ/ZMN+mus173MJaYWKpQsw/7FLwH716fGl4+slZBdYRCy5oNcEHMC8s1PWyC8G8MfjYFIZKpmMHVJKkFoX7JvE7d4MlPcMG+01xqNV8MSdgpqG4z5B7OOEiA8Py/BqBGZjNQwgwUS+xpE8Bt9USBLlQsFz3NHTuLJwbZ9F8AhoVBr4Xv4/JsuHdHeTyeYkfkgBcajY2wBqOx4j7kJS1xpJJX9YNPX/+0P1sVHck6OGH+G0zs/qtIwAAqNCEYNofNFPhXm1tb90pqmJLz1axfuWEkQCdkQZ7Pc4J0WFc/CfFiCtEsI0vZbG+FKNgwtB1lxz+tqL6yJjzfLBkbl55vwBHpYsUIIPPnRrEYlOB+OJ+f/RyEmewOMGEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(508600001)(2906002)(6486002)(86362001)(66946007)(8936002)(5660300002)(66476007)(4326008)(8676002)(66556008)(54906003)(6916009)(38100700002)(558084003)(33716001)(186003)(1076003)(316002)(6506007)(9686003)(6666004)(6512007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yOI58QLtjqIU9cfSSMF8kOqbzE1MvnEBHGqLPedfoueeh6AKPGQnLzZnuBlO?=
 =?us-ascii?Q?cuazm6YdyLtsI0JDUKzcNxwHmkDtleQiMLzBnfp/MzisLeZhcfZj+U1oK9Uq?=
 =?us-ascii?Q?VcEMoGAXwgAKvPfY7NuSUH2IuSQgm1QXdBod0QSwdqmIpzKjOon6ZEgLAXSo?=
 =?us-ascii?Q?XeDi/wIzF5JgXJB8hFLaiSHRkXpsyDNyHstOdS36RcLkpoALWMKbpmgvuYxY?=
 =?us-ascii?Q?WlsSDhglQpW23OcuOvLx3JbGE2vUVaPZABFEJIbIuKD/hQ8Tkt4ouyWOvW0t?=
 =?us-ascii?Q?2dC552Pnk/3sPZsLhxD1nz1mCi7CoDJGPDhq8hnLu5mBNREZFrbel88UOayt?=
 =?us-ascii?Q?jV5oKWVzLhSjH51xf73wAgC1ui0zjnOJrFu6ayXN72j8OrxnijNzKFE6C2iv?=
 =?us-ascii?Q?97CwZRX7WEyxh1GSybBF/OgYMJ/at9iUyi2fbFQeEi5HJa+S/JvkEuASfTOs?=
 =?us-ascii?Q?qg8ueG0YQHQ0Dm5NpPYVSgxaRLNYR7LBSP8ftb+ozo9ZJRIDXGe55Ddi/59x?=
 =?us-ascii?Q?is7tMR/Uw74SucdWKP00m0gEEASczvRygyIdWVEDzN0o1aAjDuPMhtGeBLTA?=
 =?us-ascii?Q?oWEV8r3Fd0XEZ+n/28qYIfuSvoTF4Jw8N0BpzmquC/HELQhVsDQqk/578UiN?=
 =?us-ascii?Q?1tdyGFkA4t4CrXr+jKQCzxADMPfoglszGNGS5NnafpfB5k4cjEtkGco+joZH?=
 =?us-ascii?Q?OfQdl2kvkxhBzj6kQk7RHijzMU3EY1ttjHES7mb1B/luQj3KC6OAr8XhAh6I?=
 =?us-ascii?Q?wM0mSJkMj2q3oydUuG745opP3Z+ISnIQyvnq7VNbFoa6wyNcJf3STUsp1WO3?=
 =?us-ascii?Q?wEJeYzubddV5wkyVO7xFfkXImlwD088kkp5DoBSv3g0e1mtaeyXu4sfvbNdU?=
 =?us-ascii?Q?3jMM2qetHcl00z6rvWZO6SMzhrNmo2eL47xyxy3xo1ieAmeKLDRGAJtfWCmQ?=
 =?us-ascii?Q?iEv1R6k1emzohQ3dhBg4jw5K6T3Pw3WeKoa2djtytEr+DQoUPupoJBbb4dn8?=
 =?us-ascii?Q?G3RHbDUNMMKew931akpOCjuZcABJinmSpCye++T4soywV8hTO/d6l9zq0yCL?=
 =?us-ascii?Q?mKUCSph6ScOCSyXkpiQFmCRmbXI4iA5XEuZP4TDx3WQ3NWEdUjrk4KsBBTx9?=
 =?us-ascii?Q?fz/uPybgNU/Rb2umu21tFrjB52lssCj9F4HvAbWmIrBeg8VK2wo5jHTUl1It?=
 =?us-ascii?Q?HuyEMRTn8WQis7mz+aDtzQk4Q8d0Qu5vgWYNWmjMbwOEAjkUEcKPX0ZZf8b1?=
 =?us-ascii?Q?1M2LNPdJieWKI/OcUhXuRCiTOIubMVEjg9bHB1rMXsetBI4jr1lab8YlQfUJ?=
 =?us-ascii?Q?T4zT5N77bqON8Yr15e1wccqkxXdDubWi+6ztUv6Wl3qi0Y+oaLPE1q8TIDqa?=
 =?us-ascii?Q?2Qeq16nFhicqt/WUIji4b7X5NHanxGjMVSGP+S1tG8k+vfN4QDox9vDmbkGu?=
 =?us-ascii?Q?YFDOWmmrVSQ6upj6wG6h6JhatyK7oT8Sp2gnc9rnrZONRAdpeXBPgnsvDwJf?=
 =?us-ascii?Q?X290gwRK0EWPFkfg3/zxW8RzUI7CgkzR30NUn/rPij6LZKkQ8QQ2NJtqfrc7?=
 =?us-ascii?Q?OeWYomVVg43enC/3VEgjDAqtHtggH45KNhaRVnEvQ0LEdDILVSr96wBiMoeC?=
 =?us-ascii?Q?HawuD/zOJCxqM6/YAAxbes8jn+lp7l9VSrZuHK8N0A8/9PttkiQ/IT5gd3XJ?=
 =?us-ascii?Q?MZ6rpehavL1XEh4Pq5zpZ37TSI77LglyTrEfQe5P4XocncCIKYQH0qVmy0Nf?=
 =?us-ascii?Q?iMFl9diZCYCPgS6jkwrzYmul1TzcxO0=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a410f43-faf5-4a09-33f4-08da0dc56426
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 18:37:46.9102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qoccc71U5vrE9JuH6H1uBuJwjaqH/15E3qH4ehWWJgX88T9N7CTrquzv4+4DqKH7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1825
X-Proofpoint-ORIG-GUID: VFpBZ1I-2IDldlYPVQ0Nid9E-yH5IyRa
X-Proofpoint-GUID: VFpBZ1I-2IDldlYPVQ0Nid9E-yH5IyRa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-24_06,2022-03-24_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 24, 2022 at 04:37:32PM +0800, Geliang Tang wrote:
> Commit ee2a098851bf missed updating the comments for helper bpf_get_stack
> in tools/include/uapi/linux/bpf.h. Sync it.
Acked-by: Martin KaFai Lau <kafai@fb.com>
