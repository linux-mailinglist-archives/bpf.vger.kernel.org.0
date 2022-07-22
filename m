Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACB057DA20
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 08:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiGVGP6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 02:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGVGP5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 02:15:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D2D193F0
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 23:15:57 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LJkcaY024534;
        Thu, 21 Jul 2022 23:15:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=HL7D3Mrafzjop68OBOENpPcFcbiVMN9Fe4e765yEUf0=;
 b=ro/r7Bh574pyQwKVlTgoDbhad3zSgyNyPbYnx+1+pKkBFtF+3jUP4OrQFGd8UbiqcYGZ
 unsZDTFZTMxfjq3JHkGoIFxiIzjOuIfOeWIoVTmVvZuzyEgyFbN9SPqlcYIYPbWA7DA3
 TqDQIZTmliPB96L+f28qG0Ah4N4xOrSUcOQ= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hf7745hhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 23:15:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAn1/THIszCIaOZ6J8NkIi+FXKgps8lJwk2+/4+mBDRoHw3dD1C4XRGWHr5HdK+2Zs88J3NIhMzaiUVpibGetvKJBgoS/o3uF8JyjoD3n7piNFNISLxw01KTKA2SAij6hdW3V1tuQmeFYE0pzfHYcI9axncEg4yrBytgfIHHewmotzIwfHwYS1m4yLxz02T8KLRVlXk+1T3PK5/BnMVVOzqy2c6zDS+warvsOUpFRiZK8NRsaKTN4Om/cv/cuPBj126BX9ZKxIzyRyBK32yBEDhTb7tM5X5gkdiojYKuvAzeIfTn7h4jNONLFxyWKS5qx6d3iRYMCfxUH0JdCgCe+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5hPgF/mi4kBo1C4v6RLJZ6RH3r2WkHy2XVmS/kAk0k=;
 b=MtHdvnL3fWjJOjVxtt5RnjSD4t2yDfgEbSAf9jQfODcc855GghIwJlCchZcTquk7AIBB0zLsb9qX/7SnMIOwTXLr36eFQ1ypvAAIQfLokvq9BGXzM42w4/tLK4pwnZWlkPoY9e8oWn/slReRt5FTKAq5JvYaZnYzYABmH27MccIaAteX71Mg3C0x5Wx6Mf+0WeUBGUX8+zN4GIhCt/Ik5nBzhAIW9CPDHTdncDitw6srQjwvEsFLcKE4j65yJ/RA/2C2+BTOcJWBbWMmXCKWl/LlgYzz4ysvs8wefoMqnjwP7GTDiMQ6vkss6g3H7rJrFvkhVlTOyZpOpLRTFzMD5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by SJ0PR15MB4328.namprd15.prod.outlook.com (2603:10b6:a03:359::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Fri, 22 Jul
 2022 06:15:34 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2%9]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 06:15:34 +0000
Date:   Thu, 21 Jul 2022 23:15:33 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, mykolal@fb.com
Subject: Re: [PATCH bpf-next v2 0/3] Maintain selftest configuration in-tree
Message-ID: <20220722061533.g3dku2yoihhqdcal@kafai-mbp.dhcp.thefacebook.com>
References: <20220719180251.836588-1-deso@posteo.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220719180251.836588-1-deso@posteo.net>
X-ClientProxiedBy: BY5PR17CA0053.namprd17.prod.outlook.com
 (2603:10b6:a03:167::30) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ac61a9f-3e9b-4e87-5a3d-08da6ba99681
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4328:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ui9PnyhKmngYQCphSvFnZmVM6EPBq+jKThgFGJQt86CrSVi4ehKxL8JdBK1zyRYEWR7470m5jyFYo8UPhkHltCuKIBPVATO+h6fz5pn6jdpfj5ejqNtHdCtdxQgxE/DjRUGG/2M/EcdzcooK2eCyqldWLPS8Fp+l+t5CrWqUqC1rPGXv+F/UY8JUUU/aK/KbJOSXHie32xUzQiUFqbtgZgCP0xE4V6ulF2+ziwcEXYJOqhwidt8eyCwH1eYMZnwKy+jF6jWStF0jaZkklrRVmx01kbRnCdYARW1nKTR8hSxyx4LqIsBT1QAZGPuuJs4UO27gkANRx2zmYOkCvoHQDaTEahj7ZCuux/QavlA8ktFiQYn/kyG+oj+2fORg35dFGVUqAnkrATttQZBhBY0azVN8NicQfto7p+sOPGVo9nesEyeEV3EWubjPrD9mSsNH0TfETGmValMpmooe1JEy1P9ZXbY9ptjrMlztgS6fVrcU8MYKPNTjLOqZoItXOk5wmJmSvw+HBbBIWkD2UXMCthbsDqie0Vl8VTaUOJRBZC8OAwwIQv3/8x5QXFGIuiJ/w908lSOVzIbDbHzGtTmR7DOpL2Hdf+FGjlSIprRt5RicimXP6vC2qDa5bzbLznyGVNkt7AJt3i0CdfVEZSJTG+shuQSSBCES6ZSQ0jxFB37YecVcs/FBgHmG0YR4wBXHeCSU5IhqnPu0iI9C2acxTsh2nfLf/SFQ0Fi1NE4uLHt57Q+YVtqEb3WVmnft15IM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(316002)(6916009)(86362001)(8936002)(5660300002)(4326008)(8676002)(66946007)(66476007)(66556008)(1076003)(186003)(66574015)(83380400001)(38100700002)(41300700001)(6486002)(478600001)(6512007)(9686003)(52116002)(6506007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?HMB1LQIk0kRdBYzFIFrGon99PSDbZsZoATSbkJ3WYd0Pue5PjFpvT1g3TZ?=
 =?iso-8859-1?Q?s2KfmvUbGYaU/UjHVVoQ7PN7nn81w2tIYZ0FeIl7K/OD34v9NsFiMQvqnc?=
 =?iso-8859-1?Q?43kZm145weSE6uU6gFbBRB/T1YIcsK8cNV+NhgGeZ1Bx7xeHpDf/xCXNLu?=
 =?iso-8859-1?Q?t25XyEs39hHKxnBRQnUG3/laKZ0WOBWxU3HEVlNGSlYsYgBGyJeETM1MvO?=
 =?iso-8859-1?Q?5EgaYhjWR7Yp2bdNvzkHHlwungkcaNf2+WlLp3YwHfFZPToYXdpGhIbAwR?=
 =?iso-8859-1?Q?bnqOw+F92JcRuYfGQ27BiQ6C6kAU9XK6bTOxmld8aJ4YzzDU3i1HoG0IyY?=
 =?iso-8859-1?Q?73j8qEbDxLkjLsi6n8oNGKuGBdu2+viHeDcNxDizKPHVKXGs+5DV2da9dY?=
 =?iso-8859-1?Q?6dRXyDxApqd8xTdgaiU7wCGCsFPsjiO6L+otLVAVYveo8zBPCyEhXFQiHN?=
 =?iso-8859-1?Q?S6Co7dkkrenj9H1KwF6mxHluPmWg8YAPIS61CfkwuXJh2kL044+c4It5NN?=
 =?iso-8859-1?Q?1mRKZQFPuzFTbOgxLavFDVS5efnRHEDjsulrnybbuAuJOTUrYzEF+0oinh?=
 =?iso-8859-1?Q?QOdC0fMJwz8NTdiSoH2Kk04QYGBJUmLJP04bg45DXryvEYgw4nAtRBvJ2n?=
 =?iso-8859-1?Q?gUfLkVk9z9+nys1hEgRhkvUB6IvxIAxqQXda41/06ZgJkz9LnfRYl2R+ow?=
 =?iso-8859-1?Q?Lc5BIYpzTQYe6F53mqhHvtj+9AH482JxUell7C4fpMy9vWT/FpOn5mdmvg?=
 =?iso-8859-1?Q?Jmh4w3o56oT8lPyhTTKEFeNSuwEk3WgJ8XRx1bhgPF9dnlkOj2NKco6thy?=
 =?iso-8859-1?Q?SVXN/LCglLZa/22x2gYLtAAr/WcJ8PUJJ/r0EAm1SLynv//d1nRVMtHb2B?=
 =?iso-8859-1?Q?f8pY8oszWfos5IAhEYotOqLGodNHGNp+/fBJyBUBnHvLBeTFhwx2o+dXgl?=
 =?iso-8859-1?Q?dYH39rMkDxH63jxONP8jdOokqf+IbL447u4aOP1TVTBFPhgSPvKOAsFAyA?=
 =?iso-8859-1?Q?ItJXAIbE1GIp7XYqoiAyTx91bTmI6HDHvxmBqzu5NJoQSC2UaCHwwl2A77?=
 =?iso-8859-1?Q?HdrpnOATlLQqfA30u9gcK3NVtXpFdQzEK/Cx84g6+0Pm1jC4nVWcgmku6O?=
 =?iso-8859-1?Q?Hm62MNMi0xtnF/7QDKchAHfxr2dCblIY2iq2sEn4bJHZJpb6I3wkmP4PIo?=
 =?iso-8859-1?Q?dlwP/YZBWjjMYpBIDiF3EmR/TT87bS/vhAwq62CPGmRF05ZO+uk7XqZ+zO?=
 =?iso-8859-1?Q?KmsChDENJoKenSK72zuD+840HdypAhQBTbOZXZgZxw1rl97a+zu4ZZ8D7P?=
 =?iso-8859-1?Q?nN4VB7bL+/9piJtJGiDABymg4OKrYfkw1Lqk8yzqj2zN/isFFQIKGJXS91?=
 =?iso-8859-1?Q?M63DF2iWUldMzwgXC+iaNPD8wDl1xU/MDbusU/SS/Jpx87iVkCKkbaZYgD?=
 =?iso-8859-1?Q?uzud8A7rSBFj47M2Qyfg+IFOLcqTJCApxPXgwSACcbN+VyUe0HifKaIB3C?=
 =?iso-8859-1?Q?t6yUCNoAQj1zu+HPandBGf2u8FvZvhqFqu/VxP73BEyTuKriOKquiHchE1?=
 =?iso-8859-1?Q?v45PNzAgwWYZ7JZf/B+Hz+JFqA0AokcuVTD2oBP2f9n2ZZ3/wKzNQCwkmm?=
 =?iso-8859-1?Q?wf+3ktgO5yVs2aqkqOYxfUbfUtg7U8/tPbzc8vsIMBI4sfQNazJ1O2Ug?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac61a9f-3e9b-4e87-5a3d-08da6ba99681
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 06:15:34.6668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DREu6WPBKOCQZVgHus/Goc0p+z9Qwv1P4P6fNx5Cfs3J4F78WoHY67PMhs5ld2p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4328
X-Proofpoint-GUID: hc-KrdCGeuVggm9Ke46h9VQ9BjXJnEWf
X-Proofpoint-ORIG-GUID: hc-KrdCGeuVggm9Ke46h9VQ9BjXJnEWf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_28,2022-07-21_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 19, 2022 at 06:02:48PM +0000, Daniel Müller wrote:
> BPF selftests mandate certain kernel configuration options to be present in
> order to pass. Currently the "reference" config files containing these options
> are hosted in a separate repository [0]. From there they are picked up by the
> BPF continuous integration system as well as the in-tree vmtest.sh helper
> script, which allows for running tests in a VM-based setup locally.
> 
> But it gets worse, as "BPF CI" is really two CI systems: one for libbpf
> (mentioned above) and one for the bpf-next kernel repository (or more precisely:
> family of repositories, as bpf-rc is using the system). As such, we have an
> additional -- and slightly divergent -- copy of these configurations.
> 
> This patch set proposes the merging of said configurations into this repository.
> Doing so provides several benefits:
> 1) the vmtest.sh script is now self-contained, no longer requiring to pull
>    configurations over the network
> 2) we can have a single copy of these configurations, eliminating the
>    maintenance burden of keeping two versions in-sync
> 3) the kernel tree is the place where most development happens, so it is the
>    most natural to adjust configurations as changes are proposed there, as
>    opposed to out-of-tree, where they would always remain an afterthought
> 
> The patch set is structed in such a way that we first integrate the external
> configuration [0] and then adjust the vmtest.sh script to pick up the local
> configuration instead of reaching out to GitHub.
Acked-by: Martin KaFai Lau <kafai@fb.com>
