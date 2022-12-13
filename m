Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A8F64AFB7
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 07:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbiLMGQR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 01:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbiLMGQL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 01:16:11 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E2A1B9F4
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 22:16:06 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD3KFoK005576;
        Mon, 12 Dec 2022 22:16:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=k8vL+QN46YdyhK3z34yCg23K3jF3XHOAxm1wUB5edMU=;
 b=OUzTn8CQkCNCloQrK8a7v3662HIVCjkYIUF7EEVT8gM009q42tQ+GpNWG8RcF2RqInvg
 7VmXHJt05J8nf1YVD+FkPNXL4pKIg2ksrm/pkNy4Pa1zJVkS5XMmojCkeOW1XuoKZ+Ma
 ntO8OTsjDwkNrFnZIQR0zmluwh1oberfghlVYSTAJZtsC5N+B+bcdGyfaPCQpdPGCkon
 RsYrTcCFa/qzr4jiVIpHoc7fV9klNFLzrAxCZGO7wJvB62NJsfmepBNZ8Sd+/C0u79x1
 ndaWgNBIu9gnoZZDusJu4o3ALlp63WNDpjv6SCxrrs6NLQZcSGE8gcIZkjiP2O/ITn37 /Q== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3me4xsfjkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 22:16:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joBK9/5H8fjBlBQo+T2drvWb9Gfu4k/r587aTWtY9GE+k1VYpqhDPU1EYywRso+A3EZtn0EncAyXnFi3zp5YDKRLGbsFOl+MDVvDelidWQyeou2tYOaLvyI9u80Ury3lGbrahWNcby38sOyJpvhfq8JRH24LsHwlhnciNx2IwaV2ieh36UImplCOq0UPWmkdjiEGuDZDWi+phbt15M6SwJ1gPuKVD3ipqrMVB4BoiTFtWowO8rrTn4JhKJOBevenCDcfm/VRwZ3lW2aPjSq8BYdXuC8up7bQ5eDRXgouHNAAQWiQpvI0OysnftrgG5xMviiMkcXA9TY3zBkf79VrTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8vL+QN46YdyhK3z34yCg23K3jF3XHOAxm1wUB5edMU=;
 b=VwBm9eXu05riUOludZnXSuw3sSh5XHkC+7NTKgryXL4mbkmu578f28zJIdS+PVJQ1IVqqmm/YzF+WydqqLE5eDOO/LRitKzhplSYe3WZur8AHpROvL6+xkb3Dx2HXtXK1ky+4gXtiZDXXa2EscpiyQlSxhCh/WmXeyImswuP3nWzOKH19KjujNrtMIp7OMonxRwzuY2RloOvvVxgCix6G3/DbTfzyM9CeGL4k+mYQGr4MBCgOCtu2jq1lCewb2Ud5Zm4yHLdH4J5ll5LoBfqynDHLR7KUfsznGKjGdR7v7aPqRw7NnHTzHV20f+fvIeIhaVcwSOxZ7yLfPFsypnOag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB2575.namprd15.prod.outlook.com (2603:10b6:208:129::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 13 Dec
 2022 06:16:01 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 06:16:01 +0000
Message-ID: <e547311f-713b-0685-3fb5-80975c85d641@meta.com>
Date:   Mon, 12 Dec 2022 22:15:59 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next v2 3/9] bpf: Support access to sun_path from
 cgroup sockaddr programs
Content-Language: en-US
To:     Daan De Meyer <daan.j.demeyer@gmail.com>, bpf@vger.kernel.org
Cc:     martin.lau@linux.dev, kernel-team@meta.com
References: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
 <20221210193559.371515-4-daan.j.demeyer@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221210193559.371515-4-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN2PR15MB2575:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de6954e-0359-41c4-51b6-08dadcd1820b
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bseETuPTV8mgDKL4gW8CXiL5Nz72BzTS2Z344G24d5xHPqvWJvPVDS8r7nUqZ7RXcl8te53KaE1unC1Mqz147wLOs1RP9AxKq2MwLBUxjeth1rZjSHGMa9T2yrQcWs9qzOCnHhrc99RztyT7d9HT9Epgq89LEjsHExDKvVJuKmAkiBFpLjazKvudElEQbNaKdy2jF6kkQsyj+EHfhnLRMPO+fo0iB3N3Bbbo393+GaerUz99RsOKUFyLnppdl4fNI5+v8H9V8VOvu+OmKrxvjbavoz9DfIU6sAXlIImMqHwdmLnpL9H2IMMq0c2v2rj+wjSBqJ7Qhg4W/ba9zuqKBYXKMpMWBcB6L1xiHEyPBTJsd9Ryp1gRFYmBPNBGd7xebeSq4hL04iMh8tvQrMuAW7Rm49uX/pDmz2d7S9ctPAPHvzH7ZkJUg8QJmuV1LL9VcB1236lFhaa1Ib/VBTmKeIBtsnajrBVwk7NoSQt69q60M9kNTIUdplax3Y8/HXe+iJgMWBtPKkU27wsWyvY9MF0+1da2fSnWnQUgAc3YPpBosUYabEjKuhuPyzrHefPhdP3bEGwRdWm7mS7PshSJlSofRnWWIB+tbf/2rd4gg15lq2H4NhteSRTP7nEmjjr8Rtj0OoGgExj03TG6qiFGwYG81UwWo1tfBpFJ9vu+rv8+xTAfd3qZP6U2+UJJdfbmovO4d7ibupJeqS/rPSzc2jkTYw5AdmeKxMiosgroghU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199015)(31686004)(4326008)(8676002)(8936002)(5660300002)(66946007)(66476007)(66556008)(2906002)(316002)(66899015)(41300700001)(6486002)(107886003)(36756003)(6512007)(6506007)(53546011)(478600001)(186003)(83380400001)(2616005)(31696002)(86362001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2dzSmRYRUt5YXBlVEcyZXpyaVZ4dUoxTW8xZ2ZHcTBxYldjNkJnL2FZV3Vo?=
 =?utf-8?B?SHNGcFYyWjRibnRJdGZ3M25TWFMzSkxxNm5vUDIxeXpiSkdOK2Vla2VHNGEw?=
 =?utf-8?B?OXlrbWVyekhCdUdlamU1Mi91M2EzL0w0UWNweTh6TmdxRU9hVGtmbkZJa2t2?=
 =?utf-8?B?MURpbnEwOWpuRWx2QjN5Y1RCbDhWZ0JWSUdxczRZYzNsK3dRQmtMc1ZYMDFY?=
 =?utf-8?B?Q1pxK3F3YjRwTEtJeW14UUtOaFJ4WlpzL2RVVzZINGNtWXBseDU0ZDJsWEJv?=
 =?utf-8?B?aFhHcHE3Rkg2bGFPbW8vZEl6Y2h5azlzbXpSd0tWTjk5N201R01vV0ttcTRT?=
 =?utf-8?B?WmRsbHJ2NEpHV254aW53NGZVTHMzS2NYRG9mOWYxSHJPRUNUZng5dHFpZ3h4?=
 =?utf-8?B?eWZWRTVqRXVPRlUxOGhQUDZjL0hrbGRPeTFjK05wRlAzd3NReTdnZG85c0F1?=
 =?utf-8?B?NCtKbWk4bkt4SjhLeEVPMFU2YkhKZlE2UVNoNzJtTHRnUUFCQlZOQjF5R2VU?=
 =?utf-8?B?eS96L1NlQUVBMTR3MTBaMGkwM3didENZZUkxeEJrZTBaRnNDOXF2MUNFSzVH?=
 =?utf-8?B?R3pSL2cyNktLK2Z5bnBQZmc5bWJ3SkxGMEdRaksydHVTQWdpYTFUdmdVd1NL?=
 =?utf-8?B?K3J0RUxZcEV6R0Y2eUtMczF6a1IxTGtXeklvL3NHcmVaWHVjNzdTZnY5SnhW?=
 =?utf-8?B?OU0ySmRUbEhRL2ZPUmRxb2F1ckNKRU11NjdPMm4xclVLL0NvTXI1OUtBZjhB?=
 =?utf-8?B?WlYxR1ViRERibEFlOEZrbEtheWlUbTdZNzhURUczMytXUWo5NmttWXo3Vk9r?=
 =?utf-8?B?UEIxNGZLbysvclJjSFF4b3VIQ0dlT25YUVdpK3ZKZ2pCQXA2RVhMUnpLaktN?=
 =?utf-8?B?L2kwZ055emhrRWhQRGs0YWF4bW9tK01oeDBQcWVnVkw2SEtDM3RsRm5Qdzcy?=
 =?utf-8?B?TlVPWVRMemg0bWh0MUk3WlJocFRTT1dXTzR5NVZYblNjRCtsU2R1YU9NRHh4?=
 =?utf-8?B?WjBpYWdoU21VOWRjdS9IYVNUQjJtY3ZyQWZhNjllMFNLa3Vaa2xlbWlrWS91?=
 =?utf-8?B?NGJESlI3Y0JCbE9oTGZXR3dQVzhrNmxtQ1pLcW1PZjRGT2RJN3lsWThRelhW?=
 =?utf-8?B?MWcwYXpOdUhUWk9TTm12czgySXRvK05kbjk0azYvUHJoYlJ0VFFHNlBnTmtY?=
 =?utf-8?B?VmZVT3hlVDYvckZyZHJXd29UUi9RSHMrdGZhOWdsbS8zOGZJbWVPb0hoL1Jk?=
 =?utf-8?B?VHdIeGswZWt4VEYrV1o1UFRMVnNvTnd2QjZTSlBXQThjdjk0S2FDUWhoZGVY?=
 =?utf-8?B?Uys5NTE2NEhDYlFtdXQ0elhRNy9VTVROMHJ6RHF6MENua0JqNmFwcU9BKzBH?=
 =?utf-8?B?cnExNi9ubThBanpBUWNNd2hIa2NDUGZ5ZFpOTTFYVkZWcXNLYSsxc0hkc1hF?=
 =?utf-8?B?M29wd215U3FWcEI3S203TEhSUmJ6RjVQVFFwM2NobjFFZnRNbVJHRUEwcjN0?=
 =?utf-8?B?M0sxbzVmaVJyUTRrN0hGVHgxbWYycE90Wi9JZ1VjMUxPOHB0NGE5VU1XSDhy?=
 =?utf-8?B?ekFSNEd3c2EyMFMwWEUrTmUwVVRreWxtbmF1cEpNZjZVT0p0dnRvVXZKak05?=
 =?utf-8?B?bnlhTjFBdGdUcVFDWS80eXBIVVZEUU1yNFhybTVmMUx0MmdRWXNXZFo0c0VP?=
 =?utf-8?B?OWR2TSs3T1drVnFRKzJuMGdVOW43TnhDNUNrK1RQeHQwVmNkZm1ZUTd4UXZh?=
 =?utf-8?B?VXRQZFY2TFhzbGxnK1JmMmFJZXFEaXNBR051Vlk3NVBnVFFvZ3dubUs3ZStP?=
 =?utf-8?B?MGlBbUkvZjliTEZRNkZERGhRL1JtYTIwUUc5QzZyRlRsV2ZKbWVpc3d6R1Fp?=
 =?utf-8?B?a2szUkdkUk9BenBiSDI1ZUpIeUJCbE1pU3dRUlo1ZE1Ud1pBRDZUc0VtQzlC?=
 =?utf-8?B?TDg5UEl0SnlZd0gzWG5SMmlUS3ViWUVZZ2pldkFSTUt0ckZNTGszUk1aQk44?=
 =?utf-8?B?SzN3QTJSM3V0elFRSWw2U3hOMk5LeDRTRldnWFNUeWhScnVQVEI4b0M0V1FN?=
 =?utf-8?B?Mi9LWnJ1YXM0SElmemJoOFFQK1prRThDd1h3bkREdEx4cFNSbEdMdlRRTmdK?=
 =?utf-8?B?S1ZsaGJiWkJ0bFA0L2ZXWjg3Tzc2U0lpOG5LaFN0YnlDSjFKTkx2OGRlTFlt?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de6954e-0359-41c4-51b6-08dadcd1820b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 06:16:01.5964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lC09wjhqvI56kULkY4uEoxgsT+GVhUg+tFXXtDLXkleLDDkRYu2sFUMiqPhpXqJL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2575
X-Proofpoint-GUID: 7QLDT97_3hj2QfJ3RihM6gQ2CqYZO882
X-Proofpoint-ORIG-GUID: 7QLDT97_3hj2QfJ3RihM6gQ2CqYZO882
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_02,2022-12-12_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/10/22 11:35 AM, Daan De Meyer wrote:
> Preparation for adding unix support to cgroup sockaddr bpf programs.
> In this commit, no programs are allowed to access user_path. We'll
> open this up to the new unix program types in a later commit.
> ---
>   include/uapi/linux/bpf.h       |  1 +
>   net/core/filter.c              | 19 +++++++++++++++++++
>   tools/include/uapi/linux/bpf.h |  1 +
>   3 files changed, 21 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 7cafcfdbb9b2..9e3c33f83bba 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6366,6 +6366,7 @@ struct bpf_sock_addr {
>   				 * Stored in network byte order.
>   				 */
>   	__bpf_md_ptr(struct bpf_sock *, sk);
> +	char user_path[108];    /* Allows 1 byte read and write. */
>   	__u32 user_addrlen;	/* Allows 4 byte read and write. */
>   };

Ideally, for bisecting reason, it would be great to add user_path
first and then user_addrlen second. Otherwise, some tests utilizing
user_addrlen might not run correctly with Patch 2/9.

>   
> diff --git a/net/core/filter.c b/net/core/filter.c
> index d0620927dbca..cc86b38fc764 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -26,6 +26,7 @@
>   #include <linux/socket.h>
>   #include <linux/sock_diag.h>
>   #include <linux/in.h>
> +#include <linux/un.h>
>   #include <linux/inet.h>
>   #include <linux/netdevice.h>
>   #include <linux/if_packet.h>
[...]
