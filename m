Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF2B594E78
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 04:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239994AbiHPCH0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 22:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240287AbiHPCHC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 22:07:02 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04B1E3991
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 14:58:21 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FIc4Ct018240;
        Mon, 15 Aug 2022 14:58:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=pwg5Zte/JTHm6Wc4CIc6RQPV4Lr2XuKkhWR7IUvtGgY=;
 b=HBLSDPmK1GNeHi5zMYWm+6w/3MY6As+2nrGEe6ZMN+cen2LHzxRW9K0ZwQV/sSomQFDy
 uHD2KDykKXsyRBgxSKu+WUH2qTVdt89ot1tQGj8RX59Xx3i4mMbc3MQ7xcKdgQoS4wzj
 yOHF1T2XEu1EBTipuaTTYisJ3u1ZjY2CQzk= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hx9fynr0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 14:58:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzwfoJYuKbvaA3XkdbCaAKLJF9UqsxThovXgtd9wCWE6DcTvo6iozWLkLpWzjTBfBZh3etw5VKEvp/JBtC7P5aVRBw5b9Y+4T1sQfzucI2A+DgTToW0ckB+OXFTohB9uKSuVw+k3i4s8XdeRzWjeCT1ZgYIW42bfLm4Tmu0DVVgkCiBaAGfAvmZGrPmMnURkbHllWTl3iFJqraArcPohWSjkQo3DwMH6wz2qBAfpoy1up77LHnVqKjLB9bVe//fuUvjlfIWSHZkVY/HuqsKeTmxUyvHOw52aWkfOVmH3jUlO5kf1oPRnUbnjTFMwRsW0L5Hfdet/K3Mw4jQFkT37Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwg5Zte/JTHm6Wc4CIc6RQPV4Lr2XuKkhWR7IUvtGgY=;
 b=VEWOjtQXQLuQco6tf01ftG/E6bnxK2RdOHG5bztpXfYTbNrQwbYrh7OdIQwlAa7ldksz8XKA/JK2to2mwIkYBhB6VhKABIGb7rCMH5wmogwk6CIDnVvWRjJyp2Z0LIiYxlvCkSPgfcjZ8zrQe6OjtJpqqokJh4XwyiX6SdkUrccT89cu4Ssn9IDb3NUd9D3Q7vI5ex1xcyANENl6DnhDKw2dOuFWuZkIzZlhCvRLRmLYCDTvJOOFzpBjGirTSc3OCvXN/ZL71Oq/eZA8APXyhZWCw7/5xRr6RiiTGYld62P7ckxjOtjYPbgjg8FG64+cfXU6KdTUT0EfzwvvF4SidQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by DM6PR15MB2651.namprd15.prod.outlook.com (2603:10b6:5:1a3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 21:57:57 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%4]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 21:57:56 +0000
Date:   Mon, 15 Aug 2022 14:57:55 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next 2/3] bpf: use cgroup_{common,current}_func_proto
 in more hooks
Message-ID: <20220815215755.mzf456mgv3tx4vfe@kafai-mbp>
References: <20220812190241.3544528-1-sdf@google.com>
 <20220812190241.3544528-3-sdf@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812190241.3544528-3-sdf@google.com>
X-ClientProxiedBy: BY5PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::29) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4961f178-87ff-438d-2afb-08da7f0935f0
X-MS-TrafficTypeDiagnostic: DM6PR15MB2651:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmzj4Fe0/j/mp4ARBePJzbqprq0rgY4L9rCilFgwv1GrLPcqDLzKgkWdU5v3ZF4W9pT1akiASiInH8TcM8wQL+bJSqlkU1I8pYikDovugJhejDBDelr9Y0e5iljsJpd+AdcvYGt3rh5E+esHDdosa1npcQNzrKYzJv3Je3HLScsD+lzEsna5ZJDdwpDkRlqlCtuVd1oh6LEGxeUKyoWnSmiy0M3VKFYcUCoe74eUkwml00yKDUhVoBrGSumq7ohWAzSDMQpSAkfp/xvJXwOk1vOCaN5giBRkCg4sfZYbDaGHLmaU/ebrP8vN7Idrt7gPFuMKtwBnSpgMTBElxnvqGA1zsr2jJ+/Q73yQiUJXrlOtKBzFNygWoZN/GRF9HLjegqbGhC24QQMsI146KgPl+WfwGW6MlvKRpIRq1dYAVV/Z21c5RhTvWE0KU8NBTfF9SgHHhwWwL3iX6yw7T0ToW9Wo157M149h/B4fHCRgATZOs7R7yf57fLGQh9n/4eq0SGxcrJYBRCc4C/wku+QMYY5q18XhM1G9aL20Z1PSHywwuk+v00eCQSbESCcA6IZbJ2mjomICZaQGbnCYmdw6lZxFC3DRMNl2YEMvXH+9LWCPsi2xwHVIDWVtKDX9cFpxAt4GXfTU71OctYee9ekt14wztufxJnFzp4imn0cWNGZN3lWS23MR6dIYhYWz/D1AeJyBOsH5m9jCvJVJk9oEPALyPu8kdAbiC3Cogu/nyjGMO3H2VqSeNjB3lpGfBZj0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(346002)(39860400002)(366004)(136003)(396003)(376002)(6506007)(86362001)(41300700001)(9686003)(6512007)(52116002)(478600001)(1076003)(186003)(6486002)(33716001)(316002)(66946007)(6916009)(66556008)(66476007)(8676002)(4326008)(5660300002)(38100700002)(8936002)(7416002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K0bmDZh3ZOIDmzkqWVdG7+6Bj83mq14XznLkHszEnyCqaOEByhOev8caDepX?=
 =?us-ascii?Q?4WtV/1xggHwxtKW4BGYT9ILVOMbdppC32+Ue4S4CZ/ZFrfw/5QFWNMncbwHQ?=
 =?us-ascii?Q?KjQF2mUCBkgoDO71OnZ2Ddt8e8rQpEubOxNzWjEEq5n6q+77J2WP5BOrWG8J?=
 =?us-ascii?Q?pUB6FiKA702pvmNh0+4E2ZtlgcJdiWatgFOE2WtNfuFCbla6A2vZGeBO8LPF?=
 =?us-ascii?Q?C1sU3RcGGFfmiRq0oznaojAqpN/KyCrZ8dcrCByHrw/iR/3gtvjWDpT25gZF?=
 =?us-ascii?Q?xLQyah9xzPyAeHhGozix8aZ1A7OfP9ncaueOcKmIZFm3D+QqeYX5j2Cb1t/g?=
 =?us-ascii?Q?Aq04y60nTq0nbObmCsxzSZdnrtPTnD2N+7W+GxFrDyLIxF8g9rDcvE1wc5/L?=
 =?us-ascii?Q?Iqf6AGmwghzN3oknEbzdu8ULIdujfbdE+7ZF8d3HiIxDhOJPhw+rJBp6GPCK?=
 =?us-ascii?Q?Jk9GGqXI15GNu3ewHcOQUGTXRWh/qgqOJlFswSaZmzo3lj6gzN6O499PEHv0?=
 =?us-ascii?Q?BaRC2JQDI+GrDc6QrdYBl+wQb4qtedAS3BKBu/KoFTpodK9b4U7Ahjc0Y9mm?=
 =?us-ascii?Q?8yvV097gyk0VaESGSkv/UhnwicwwYISxfCuzTW1D0VNImpkVk6Bful58yx5B?=
 =?us-ascii?Q?F9Mf9WhZ5ob+bU/ILR8Tx/w5qqaHJmlbJqzKLvggw/xY/u6cCpb9wGdsoieK?=
 =?us-ascii?Q?ty8VvA8jlZ4YYYH9h6qyG0XqQNfwyYcGlDBxiDy7jp8unJ0vf/o68EvWNmlc?=
 =?us-ascii?Q?bChe7yV2Vp0UdJyy87fxG60PWchFCRz10RtfMVNDwnDkoX8bRIS33pLGjWO3?=
 =?us-ascii?Q?kczCBKp2Ppah4B9rRVNDxNP780nPKzIdKCo3aCcK5+vQl7LAWwb6F1nxi+hK?=
 =?us-ascii?Q?0nQIxQc0s8xYhj6EsmY+zhDA3iX2rXNtBTV1//1pjhju+JKMggG+EK6yXXKw?=
 =?us-ascii?Q?MW1JUy7VpKxVzV2vdySI+0l2YsoWY/wMJDFmG8NsLdtsXA2gH/GiQqXWY4j1?=
 =?us-ascii?Q?LUcNd8ipGgJHoHlCiVIlBA2nTA8AMX7XrQ/LhUOqENq/KnkRmtUfwd8L25lZ?=
 =?us-ascii?Q?F5xVDbLpKksBJNMPs+y/0TT6xHPlr2xciAJIp2siHtGNINneiFbQ2xfvJUKT?=
 =?us-ascii?Q?PaNMfdybQxWznXJ62N3AXPBcRU2spzjElRhEZebwPAp4Qb7H5U7iMuyQ//7L?=
 =?us-ascii?Q?VBeNYYAU5wPLwSPCM8tapW6cqnLR29T3gtC4Vl30C0NAhXQE0wLX5JaENHF2?=
 =?us-ascii?Q?og8Pn8qbjLTVpWq1w0Fpy3/WUAr+cX//Isy+serGeBrHKSnSNBXJfJZr89PX?=
 =?us-ascii?Q?EqA/nlv+oIQFhdY2GgzNWD2GscVbs5xg86APSKH9ZjPRU9KeNHCIWoL2QKsL?=
 =?us-ascii?Q?ry1UAFNr9XTXxaqVIKWYOknjGdGR8ZtTRHnj6ntNSdW45LXi0zfSGrxwjpLB?=
 =?us-ascii?Q?lLYobUxR5pObm6V26nho0Nh2VEEgAc8sGNtybPSAaDQevbRCwM2SBTcGqrIk?=
 =?us-ascii?Q?8TvZNrFjPVLUc1uLxWQEc1wY/vwqHpOXYrlzqSHs+VX9GjN364CfCs1rspL1?=
 =?us-ascii?Q?Okk/utyqCvfw11fzc7jrJPQszU3PTx5umMUNEfGto5GRINKdb+lMEuqsmQ6g?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4961f178-87ff-438d-2afb-08da7f0935f0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 21:57:56.4742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9UsnxINnCTc+V0x9l16ZCQFHUW7jVrV0BdUoRSBxGuzTMHCdq7l8i/K0sX4EkRz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2651
X-Proofpoint-ORIG-GUID: NACKz5p6Ms7oj425Le7qnJecXwhk61eP
X-Proofpoint-GUID: NACKz5p6Ms7oj425Le7qnJecXwhk61eP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 12, 2022 at 12:02:40PM -0700, Stanislav Fomichev wrote:
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index de7d2fabb06d..87ce47b13b22 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1764,9 +1764,31 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  	case BPF_FUNC_get_local_storage:
>  		return &bpf_get_local_storage_proto;
>  	case BPF_FUNC_get_retval:
> -		return &bpf_get_retval_proto;
> +		switch (prog->expected_attach_type) {
> +		case BPF_CGROUP_SOCK_OPS:
> +		case BPF_CGROUP_UDP4_RECVMSG:
> +		case BPF_CGROUP_UDP6_RECVMSG:
> +		case BPF_CGROUP_INET4_GETPEERNAME:
> +		case BPF_CGROUP_INET6_GETPEERNAME:
> +		case BPF_CGROUP_INET4_GETSOCKNAME:
> +		case BPF_CGROUP_INET6_GETSOCKNAME:
> +			return NULL;
> +		default:
> +			return &bpf_get_retval_proto;
> +		}
>  	case BPF_FUNC_set_retval:
> -		return &bpf_set_retval_proto;
> +		switch (prog->expected_attach_type) {
> +		case BPF_CGROUP_SOCK_OPS:
> +		case BPF_CGROUP_UDP4_RECVMSG:
> +		case BPF_CGROUP_UDP6_RECVMSG:
> +		case BPF_CGROUP_INET4_GETPEERNAME:
> +		case BPF_CGROUP_INET6_GETPEERNAME:
> +		case BPF_CGROUP_INET4_GETSOCKNAME:
> +		case BPF_CGROUP_INET6_GETSOCKNAME:
> +			return NULL;
> +		default:
> +			return &bpf_set_retval_proto;
> +		}
Does it make sense to have bpf_lsm_func_proto() calling
cgroup_common_func_proto() also?
