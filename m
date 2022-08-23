Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A0759EAA2
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 20:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiHWSMY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 14:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiHWSLn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 14:11:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384A0F1B5F
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 09:23:46 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27NGKMrD029364;
        Tue, 23 Aug 2022 09:23:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=HZPnmvZ54KwTKK6KyGoE3RUNT/tYK7XKqicnvj2okcQ=;
 b=hvDaa6Ba82ranUyMjxSdQC24IRGt0wxtUH2Y8Wi99QY+54Du9qPkIpaMmoNiehUHc+Jh
 PzyX8g4pwggWhZENmNxIQ1qHcVYLX0dnci5tMlBOeHkmcFxzsBYaASxcojRgqjEUp85s
 bJcK5RRBMKVPmHsEsiYVYFTKyMu0UoT4TQI= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by m0001303.ppops.net (PPS) with ESMTPS id 3j4x6vhwdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 09:23:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dwokajpf6jMOk9ldSoyBszgdQWmMjfUOFjyUpWVv6tf7fi58OBAzANuIZvgIRvaYw+oXbNe+bBZ/tGr9GdBoDT5MKtvzh13zZh6dLGbws+R62B6ysecgZsaSZXlBx6k96yrvylYO5t4sTvAGiD6sEOWVytwPZjsJFMBuI9H3Yfa71YEk1aScIJ4U/UY0+ssh0zSg16qdVpHd3w+o5hrMcG3GIO8y5dJ/mqoreQbXBFlP/mlHW0DH1lPk/GRqYPQ/VnyuouTmIXMgmk9PccWPDdinNc4Qmk/mzrPDxkKFoXo1qSAyAmM7Z8hMPDAB5M83v9suavh8NQ4T4Nx+/zjP6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZPnmvZ54KwTKK6KyGoE3RUNT/tYK7XKqicnvj2okcQ=;
 b=avnJbb6zqpU3LAqGmW1+UW72thihnpyjUMm2s/blal/hs+VQHHssFDcE5YwNIFG7Y9sKJIeSIKXFZgen6U8OHsamc+WpUoKnRzElzFX9Wiq7gTKu6+un76wFLKIpzMU7sAxPi8brqy74eL6t/NE0v8kaJ/MF1vy1LwVKRXnJOO0beddUXkHbe2btKFjDLGMpg0GgVizlECWHRAidDl4KozHeBVXtIjDhuXwS0m2wJ6Puw3XScFYjSpaWD+NMjqsDhP55uZYV+zQE97YYsKBATAKRwMU30JUPvE2RanpFc69ywEVks717ftV+WkIXyeHxZr7DTFj3KcLnyt0vvpSQ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by CY4PR15MB1478.namprd15.prod.outlook.com (2603:10b6:903:fe::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.23; Tue, 23 Aug
 2022 16:23:27 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e%3]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 16:23:27 +0000
Date:   Tue, 23 Aug 2022 09:23:25 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next v4 2/5] bpf: Use
 cgroup_{common,current}_func_proto in more hooks
Message-ID: <20220823162325.l2qezzntob27coym@kafai-mbp>
References: <20220822194513.2655481-1-sdf@google.com>
 <20220822194513.2655481-3-sdf@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822194513.2655481-3-sdf@google.com>
X-ClientProxiedBy: SJ0PR13CA0040.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::15) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 179018d0-0d69-403a-fd16-08da8523cef5
X-MS-TrafficTypeDiagnostic: CY4PR15MB1478:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WOTKDq1Qj+eIKvjIOdxh635veneER6pvPq5HZO2zsdmVq8Fb2nCgYRny8fhwi9pbMoFIqmohxZR/TUPG1ABdrZ3/LZdsj0KgjGMsEzoh8cej6TuzHbRD6mrT4TJ1kFPXUlW8lV1cNYpw2AQ3n7dl+j3DvCAIYVcwFtfbKpzVmOrAZI2QsFdfpH/g1wmBMFr81hnL+BAPRdB2XcE1TxjU5WBgwbQ2wrsPkdTCnEqscJG6NNL2N841f59DXJ4b+fdl8Yonge2zInmo9FsR+/EzF9wFg6pg5Vy1gFAZNrZ3PcMRtutrPKUBgJXQrmtDLrLN3OVoWr5rFDyIVB7ADZIEfgcd2HiB5SQwAdtOCO4iW13v0xZIQlIn7gK+LbY6d+TJHA3CKDtg0G0/dh2GfiTVcphT2XvoWcEHaKWK/Oz7rZOOrPX8Vc8ZW0sAJ3eU+W7lxBcJv+zZsEmzgRcYZgw9Yc25B/WkldzoJa68JIe/NKa2FDLVYrBpr1Z3JZXqgU8AqNyGGP8Rfbaoz8kzGYAV07juJ5R9spk1A+GQgxTNnHdClX/3UKLjFaCeQG5ElrHJbBopDaxDSsyLp7pBg1NCjoGIn3n5G6LkPjihS7b2BiENJOzyEau1hv3w9I+knks34n7TXauyiadtpJ87/fZ7UEQadPdFZNOoecztIDc4xqZQjWpZWGShobjM8LKPI1W4l+3xQU5LNTrwM5YHGJoSJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(136003)(376002)(39860400002)(396003)(346002)(33716001)(2906002)(52116002)(478600001)(6486002)(5660300002)(4326008)(7416002)(6512007)(9686003)(66476007)(66556008)(8676002)(66946007)(6916009)(316002)(86362001)(6506007)(1076003)(186003)(8936002)(38100700002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1G4eVCkD9rHT63goyFUWkH/p1dHv4EOiEQIQ78W30aHBz5JF9eh8kqY+zCWo?=
 =?us-ascii?Q?sDp8621zd8QhTxVCmEiImV93REPB35WLoY8D3e9xK4ixCiNLg7hVF6m/qg7l?=
 =?us-ascii?Q?kIQde4WqCgeqLJzYeroOVN9Zsw3yJI3WV+pSt5lfNbGPSUxhotjYa1YZmQHX?=
 =?us-ascii?Q?bzNr8fYLvV/mlGeCZdfd/7m7CgHcMFMxLZbyqSj549+UgFB5ORoK64BMDOB8?=
 =?us-ascii?Q?wDnGCabPtqwaKjfMuRho5rSbtBWUTZ/QJifWQ+lq/TjQN5DQD2Dj12nEqf+w?=
 =?us-ascii?Q?VN+Q/+WXUVv2eCUbYeR/bcaeaYexi0+GuLX1jNNrovtVyQOEJXCESTUAovy7?=
 =?us-ascii?Q?bFPzM9c0mx7Y9mj5M/8fvpM6nLUH6pbbD3xbD07ghkNpPTQj+2jRW6HlbvKp?=
 =?us-ascii?Q?C3sGUy0MRmilsogUqdGKxpx7ZKWB+ECzfZxmLxk44g8XSha/KUqYOr9XwLQ/?=
 =?us-ascii?Q?jrgf7Bjlo5sTm0BHZDGja9O9+i4ur0F2pV5VUddaa9cusFNDKA0yTl6Mmnjp?=
 =?us-ascii?Q?UunpXofxmvWhd5tlyAX9PFX6Y3tRttUCtN4rICNzos726VSn03euSJddT87h?=
 =?us-ascii?Q?mzlBT6XrhBuY3VjMsBAnx37TUDQ06HnTLmuOc/qARZCha+ZRDgDTo2SLMo5+?=
 =?us-ascii?Q?Dt55DrhVYXMKHpCGtJB6P+lp9xg9bGDrXYGCz/fK4jzVzAzwp6GJ1adlUs/l?=
 =?us-ascii?Q?JiLbIDHwBWHkEDF0RbHhiHu9EJrT27TyHTqVGI666oNjMTPo/IaZe/W0EU4y?=
 =?us-ascii?Q?WHj+mwtrKR0i+xFmimHfAj/EsO/a38zEFYHH2r2k9N3+Q1tUJGmI3AYqfZzU?=
 =?us-ascii?Q?Oqr2rg0t1cF64PlCFiHZErWd6egerK4o8IVOQL33jx5OUE6kVPXW/9oAZqiA?=
 =?us-ascii?Q?Tp+51zLVL9xDA1phQ/o15KkSSkyiUMkyjpW+5rEp8mqX+dHdt3TuBfRhNqAa?=
 =?us-ascii?Q?7yuYeyU984F5wQyZQzKOYCJG2ov3Hfbq+ppMnFu8ceKDVtHMQJUDzkGRRWx6?=
 =?us-ascii?Q?zVz2z22u/gvO3JB566aXSaDf2ffC3NSabJDQiVyTleHu9hLbsXJ0Iy2zYF/W?=
 =?us-ascii?Q?IVHw8oCl8eH4klcV4IgghmdyhExGB/dYRAKa7B8lLmdA63ERHTvHmfjj3VoN?=
 =?us-ascii?Q?f7lvcS9WQnirG2XaOzttGlOX6aU+yHEmiaVvfjBhLFDqVU0Ln3n5MklVIjWq?=
 =?us-ascii?Q?zNQJPS0Bp5l4EhyBEZ3S+OqFwUEDUR2aUh73/qEbiraWsBC+ztcPuVTUR1z8?=
 =?us-ascii?Q?j9MwYzxYg5WU04rGH6HDJYMDSebykFwtFk1NUwNEICUqBYIB/m9w7ucuLElG?=
 =?us-ascii?Q?7sHkq4CbtrhxoWa3bg6h38H6LrZX55KyNxW6NcyMyeul4L3AEEdy220vtRcY?=
 =?us-ascii?Q?B+s5L5r6m8xuJMb7uXLFlthAFIGb7AyLAGMXVBWrk4Aq6YZYFMpDcME5d+6X?=
 =?us-ascii?Q?uPLfcWZmSezBOyDinI9Wi/FiEY3IY8hintluJTwk513aMuL1HV3hC/AbZy00?=
 =?us-ascii?Q?sDAkGdT44/67R5HSkg33HbnPVsdiZpYR2Qr6Tk+7gmpo4ioBz0tzIgkrm3Xg?=
 =?us-ascii?Q?ORGG9XR3GO1eaJIlyEDzknbmn+K/aPQ9dRPTn+ueAQwVymtsND72pjaACvMP?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179018d0-0d69-403a-fd16-08da8523cef5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 16:23:27.0642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bG1BkxUKZoO3atpeNMNzcqJNeDVY63GnTv629JKoocOdpSI3KCVnIYa7QuFIFe0b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1478
X-Proofpoint-ORIG-GUID: -VJN_XzQ1IBE5JB4BTUN5T4tPi4uhbxL
X-Proofpoint-GUID: -VJN_XzQ1IBE5JB4BTUN5T4tPi4uhbxL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_07,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 22, 2022 at 12:45:10PM -0700, Stanislav Fomichev wrote:
> +const struct bpf_func_proto bpf_get_cgroup_classid_curr_proto __weak;
There is a 'ifdef CONFIG_CGROUP_NET_CLASSID' before using this proto.
This should be not needed also.  Please check.

However, a declaration is probably needed in include/linux/bpf.h.

>  const struct bpf_func_proto bpf_get_current_cgroup_id_proto __weak;
> +const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_proto __weak;
This one should be unnecessary also.

Others lgtm.

Acked-by: Martin KaFai Lau <kafai@fb.com>

>  
>  /* Common helpers for cgroup hooks with valid process context. */
>  const struct bpf_func_proto *
> @@ -2496,8 +2524,18 @@ cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  	switch (func_id) {
>  	case BPF_FUNC_get_current_uid_gid:
>  		return &bpf_get_current_uid_gid_proto;
> +	case BPF_FUNC_get_current_pid_tgid:
> +		return &bpf_get_current_pid_tgid_proto;
> +	case BPF_FUNC_get_current_comm:
> +		return &bpf_get_current_comm_proto;
>  	case BPF_FUNC_get_current_cgroup_id:
>  		return &bpf_get_current_cgroup_id_proto;
> +	case BPF_FUNC_get_current_ancestor_cgroup_id:
> +		return &bpf_get_current_ancestor_cgroup_id_proto;
> +#ifdef CONFIG_CGROUP_NET_CLASSID
> +	case BPF_FUNC_get_cgroup_classid:
> +		return &bpf_get_cgroup_classid_curr_proto;
> +#endif
>  	default:
>  		return NULL;
>  	}
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 1acfaffeaf32..63e25d8ce501 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3009,7 +3009,7 @@ BPF_CALL_0(bpf_get_cgroup_classid_curr)
>  	return __task_get_classid(current);
>  }
>  
> -static const struct bpf_func_proto bpf_get_cgroup_classid_curr_proto = {
> +const struct bpf_func_proto bpf_get_cgroup_classid_curr_proto = {
>  	.func		= bpf_get_cgroup_classid_curr,
>  	.gpl_only	= false,
>  	.ret_type	= RET_INTEGER,
