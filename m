Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387B257D025
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 17:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiGUPrF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 11:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbiGUPqy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 11:46:54 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BBC8AED6;
        Thu, 21 Jul 2022 08:43:16 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LCsALU017692;
        Thu, 21 Jul 2022 08:41:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=4ocVO5ur3EUFuUg/3NEJrYxFD/K59ocCF64tpx1SNGA=;
 b=M+DlHjrCYSSb6faq9BvXYxo2hrP9mFHGOrFosad0SjldOBJZ6PZHBPxfJFLt03muFppC
 Sm1HGNWPnlzG+UemCNH8kbCLNR6RdHUblW5zP+7o5aHHp5TmpJ/3SCNjXfJpSWsYio5R
 Vd+5FFaSb7WZLazp1AgCoi8Zp8HPYyg8mhc= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hf77415y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 08:41:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Md37ZHiR6ahbdmUemY60/+udhHQrcJr+atAr1MvTuIbNvJyY1xmjd7IYKE4pXOl+0BZZev4NtD3fXv29REsLrZTeZEvaUsAIRxdLI7ckcjEaR9cItmXLxnGXgS+I/Y79jshHicvqpMJ0m+FVf1okK6AQMttOLDHh0ioEBUL6aaBNLeljyP0yS3i7ZNNKuoc14gwrlxM9DqhyIRXqlLIEtLnkOyDT11fxZ67XC0L7SoeNN7unLPv782SJJCVLO66mU0e9ZaIgxw/yIR9WZa6xTuL2JRL/lPjeCBt0DWEM7xv10Si4ijU8WNiHpAOzqhUG+45UkbcJe/DB8V15c+6mUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ocVO5ur3EUFuUg/3NEJrYxFD/K59ocCF64tpx1SNGA=;
 b=F5VFhgV7cYrJakbMr/+yZa4f1fIqr82R/QIIT1xFX6CH+mp8GYwaXjJPdUYTs0kq9e3TooRHyTxVoIYAibJyjeKpypB3MeWqahTuJbw/NG9neZLh2SEMmU5N9USwk1gADVQ5p93thd7qN2t0SO4Hh3I4u2/gtZqFoRTmwXBW0ne6mjoEjckREglDzjB07RtZUaF2u9qy5xP84fLxnq9JvMG0j2BiR2KTRrzNi3xv43Yqi0ekiwBBXLBoBnK/VKPsjkn878UUpBUrY8x4z7zoImoNBo+nfXmdPXCGCdMhEQJN1yNav9KKAcBgpHivj6CXlF2GvSYw1OhgdfXY7iGDNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by SJ0PR15MB4171.namprd15.prod.outlook.com (2603:10b6:a03:2ed::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 15:41:14 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2%9]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 15:41:13 +0000
Date:   Thu, 21 Jul 2022 08:41:10 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     corbet@lwn.net, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        william.gray@linaro.org, dhowells@redhat.com, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, tglx@linutronix.de, bigeasy@linutronix.de,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-cachefs@redhat.com
Subject: Re: [PATCH v2] docs: Fix typo in comment
Message-ID: <20220721154110.fqp7n6f7ij22vayp@kafai-mbp.dhcp.thefacebook.com>
References: <20220721015605.20651-1-slark_xiao@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721015605.20651-1-slark_xiao@163.com>
X-ClientProxiedBy: SJ0PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::22) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64a307c0-99a7-4206-f7c8-08da6b2f714f
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4171:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v6da6v6fqHTGTxNkZvzqkdIAn74F3NqYZ5QWtIiSaGTJxfTEtvNuj78nhXDCUpxDe7VXpl2mVvej53ZCQg9QGFMyhngW+hMSj/9MkZUWBUbkoT+WDEjolOYpWfO+Ub8QjYiNALCezBA7W67lQyOj+o2lFGCMnIfNNp6VN+Yg7QGBSym30BpPZADPu5FVWR15rAZ09FKNTve55bzF9EYsk71PjEMcjAEedB4pAZnZezBZgAC+VhHcVe6Hm33VJqR7ycMpVKXw10yjGeXmB4EEssrR0NNAXYKlrsebXtyffj9r7qZEw0df0Bb9e89CNbu1FhA/SrU7y+7I+xSNyQuaZsZiRAq2FzN/oTx13Tjku2EgC4tJJWauIIcliC0ux8StwuUFAwil57NZzM1YIhiI4h8UAQrvNEjrHNHD8VZHWcPbICVBu8Se7DhVx15PducuJ+VN/rdyYriXoPHTa5qMP9+okbf5CCeTyaqh9ArQ51Mo5mJWyLKHqkTVsGMOFNtL4XzybjlAhz/1z9eu6RX4F8KVYTgNNHOyqrho3mzyZndcgmiVM9vBi1LjzBpDSn5B6SD7+ZaQFypVFDJ8fldmYBOG9Ai1knBWbdzhGuMhqt8umXVQApoyo1XX8j3g4NT41qiEN9sLF6U6djzkxMMioYEg/OXxfSEN3OTecKGkL59d0s5f0G1QSomFGzQR0JMYbqHhl4crIb9ad3v/SXLc/mrRmnjpnhya5St1d1bIHFXFQH0Mg/CKkY6Ng+gI/nWD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(6486002)(4326008)(316002)(66556008)(66946007)(8676002)(66476007)(1076003)(6916009)(186003)(83380400001)(6506007)(41300700001)(9686003)(86362001)(6512007)(52116002)(478600001)(2906002)(7416002)(5660300002)(8936002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y50bti7IYrS6TXknATzz2o5HnK7uvWEw4nQWZNQflXsJyW4Qgwr+NWNiSIrn?=
 =?us-ascii?Q?QVGH4eXQIGB5dgB9wjQ/NmNnfrOBmSK286/wJFCcGlITKc51xM98pmelzd/Y?=
 =?us-ascii?Q?zLxBgZFiC1ilpCfh33LJAqGDvzYAsjeXx3TQJq+aOD0lB3AJYRQ03eAzL1dW?=
 =?us-ascii?Q?Gbeqgtx4rDXSf9DoZ33z1drnWubTuqgZJkuI3HThhz+CXviAzFjAAggapdPO?=
 =?us-ascii?Q?bxelLViWoWHGFVS90riswoYUnI2Rb4YEI2zldctfSQKEdVsxKgmX78aZG52G?=
 =?us-ascii?Q?ZoSxrq8+pheXzvu/+uhxvHXn6ivrnN6aH/c1wHiKQhIwPPK66u3iWv7Ffpa8?=
 =?us-ascii?Q?In+C9r6YKM9+nYE2n9V/cuCnd+7wlvtzfGi4aJgKZ2csKbKaMpP4aeYfJhiH?=
 =?us-ascii?Q?asIRp4RoQRUziJScD5CO2siAMqjNI9x7UC5Q5vOartyFR5kjcJjx5VYhdFgB?=
 =?us-ascii?Q?NaDyt/iE89G371MpP7OtPkVtFTZvqmRXRCUcBbV2Vf5Mv1AdjjCXP6ETGCco?=
 =?us-ascii?Q?6ZwerdPS/PJiHT6aLP6vQ5YlSgWlmeXuQ+6VlE5EdwVE5lPYeH/q3dG/XU35?=
 =?us-ascii?Q?1ZS8A6d7gqikvb/Bh6HcBpOcZ99ct7ZE1rTE819p30Xu7H9rhcEMFzV/I/tw?=
 =?us-ascii?Q?W7UMP5D36lO3F2Xt4MfxWFeKCU6fSeckHJAT61TXOR/7pC7GDhWPQbTYiI2T?=
 =?us-ascii?Q?Y2AQDeaXcE/WwpRvh6j5xYdppFgyEKE6qiM+gmfgi97BQfgkYaRqdvvvKLg6?=
 =?us-ascii?Q?S+19QJWypsYGCoqRLCivppYI4BW5uQHsFwGpokRksm3M3V+iuwX6QS1aPsJq?=
 =?us-ascii?Q?u8CNRLDlM4a4Tu5n4cspT2tl8oyaj7VYPBBVqfK4uqS5anbmBdDFtWv9o0Gi?=
 =?us-ascii?Q?TEPiJN13Qq/ZLA5cxn7jGLCCtLeU4sxvZqrwrgvk+cU2cOAo1DDKLhFQg8G0?=
 =?us-ascii?Q?c+zb/+Lpcr8VHYG+y6NdZdLuteygtrjN26TjyC7nzVFlBvvrdXcOwSpAWifY?=
 =?us-ascii?Q?bDXYrk1tQdOeFebrG7kqw+UEEhMEDwYKLt0rAiXIagcThUsQX0AfpPYa14RR?=
 =?us-ascii?Q?JLVxB5LsQZBmLfNONleTTb/teIviM4QY5CDJM11Kh9f9MB7qJuFpb3TjCNFJ?=
 =?us-ascii?Q?IDuj3+it2dPI/tXMD8LHhQDVmFjziofpycEhu7lcMR3td3uljXrPbsZN09KV?=
 =?us-ascii?Q?MxS8Xxkva+LK7jW3pxXaCxqu7swE21dYlOov2eMfmvtAA8vCWwAlJgvknmgN?=
 =?us-ascii?Q?rSFXBlHp/x2pzEb+/agizrIqG7xBUZhviJMJwAJCu16qzILKKxD2972qyHC9?=
 =?us-ascii?Q?9vtRlPKOFsb6EvviIxr3Rgg4a5dQPirduc6cx6B20qXfhs6GJgTZKsXwE3KW?=
 =?us-ascii?Q?Tqco6l8Rn7wPocJtfAkwZef97sEoEJP0w5KIr8yfuGcu7CBndo3pzMGLAzy6?=
 =?us-ascii?Q?53NFvY8hdBH28r8JVVwNY3mxI/1kqsYCCX5pTQqE3gWZuFKKSFu+WWNprQvN?=
 =?us-ascii?Q?kIG3T9p0ELkSUAzLKlEbEvqJhb4KWaIaJbT+QwbzbAzeynf1kiQsIYQR40nW?=
 =?us-ascii?Q?71iFuftSc26YrZBfoEkKIExRnVeb6zN37x9xzWs1pGf0OQyZmG55QRSB9aXL?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a307c0-99a7-4206-f7c8-08da6b2f714f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 15:41:13.8328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4c6jqoGS6MtFsesIccWYXcaM5yTb/ZdpKcykwgEZeh24H4Jhrb87KsuxVf22HhH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4171
X-Proofpoint-GUID: D50t2j6ItDEkUXXW0HIQlceq6v22raip
X-Proofpoint-ORIG-GUID: D50t2j6ItDEkUXXW0HIQlceq6v22raip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_18,2022-07-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 21, 2022 at 09:56:05AM +0800, Slark Xiao wrote:
> diff --git a/Documentation/bpf/map_cgroup_storage.rst b/Documentation/bpf/map_cgroup_storage.rst
> index cab9543017bf..8e5fe532c07e 100644
> --- a/Documentation/bpf/map_cgroup_storage.rst
> +++ b/Documentation/bpf/map_cgroup_storage.rst
> @@ -31,7 +31,7 @@ The map uses key of type of either ``__u64 cgroup_inode_id`` or
>      };
>  
>  ``cgroup_inode_id`` is the inode id of the cgroup directory.
> -``attach_type`` is the the program's attach type.
> +``attach_type`` is the program's attach type.
>  
>  Linux 5.9 added support for type ``__u64 cgroup_inode_id`` as the key type.
>  When this key type is used, then all attach types of the particular cgroup and
> @@ -155,7 +155,7 @@ However, the BPF program can still only associate with one map of each type
>  ``BPF_MAP_TYPE_CGROUP_STORAGE`` or more than one
>  ``BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE``.
>  
> -In all versions, userspace may use the the attach parameters of cgroup and
> +In all versions, userspace may use the attach parameters of cgroup and
>  attach type pair in ``struct bpf_cgroup_storage_key`` as the key to the BPF map
>  APIs to read or update the storage for a given attachment. For Linux 5.9
>  attach type shared storages, only the first value in the struct, cgroup inode
For the bpf changes,

Acked-by: Martin KaFai Lau <kafai@fb.com>
