Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F49C4ED6EB
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 11:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbiCaJbB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 05:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbiCaJaq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 05:30:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE501A489A
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 02:28:23 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22V8d2VK007021;
        Thu, 31 Mar 2022 09:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=S1ZN+NdNQdc1TVGrR3ey2hnzwdyHZpO+RmU9k1WLJaE=;
 b=QWXYSBg1nUwfbydeYR8EL/CzHAX7PEdI4Rakqc5VLutoeUXUHmkG6axNJWPFB565iNiy
 QwRxx4Ct+62NLUaNdDAXKXgksWDmpePqB+tnpbodFc7j2RnOiu5lgP0CDCXiwZshqhUx
 57WfZYixrlAuecmXC4tqLY3626i+NblRmsMoG+mutYk7LcL0Gwbhb21AYZezIzfagxx6
 fGW+pn+QLozIqrMzNzqxCcX+fiSMyp64BPpiTyZ3CY01aChhVCMR96KhziEwB2UNTlFl
 PWk7jUOnrhmlTCTQuKBRi9Lk2uSl+HMRxPbzQyLt2sGHh5uRj/7TD0vAi7hbaayehelX Kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tes3sjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 09:28:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22V9RJXR036694;
        Thu, 31 Mar 2022 09:28:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s94jfnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 09:28:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=biYlO73axB4OtJhaqF4kQChiJNUCZoVTelwZWbiCxTSGVXutpQ5hCcUtc1ca0inMLWNYES6i3AUBnyHrtjkZA3UiVN5d+sFi8SYu7c+k1Jv8mkmucY5rCWcUv029zWsjb2u9ttk78HE8Q53SgrfUX0sNruWzNdVLcEVwZ3V7BXBjp6+tP+AeIE+LWpTvUgrPyzjzQlZj/hFvVb5jIkpLchEq+fD5A9Bjryi30XXO0L2K3xtGGmkYckrb/B/aMyCCN0tdwgeRxlftgz9ai1kuX8K2eHq3jKWeNFBhU/qqGmRT9QNjnPPDuwbGt8cBuSKw0ekxDUGhA7b55/gi55vKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1ZN+NdNQdc1TVGrR3ey2hnzwdyHZpO+RmU9k1WLJaE=;
 b=FN3YSoAYD9eBayEkPOiGfni/wpoIWtWPbj6ZRhWDAyBqN+W5e/9lOiyEzwe4sGulhZQpDXc1QHnsaKXVXB3EpoPlBhOyTbziOm3JTeqPTA6irKjNXYiOdH0xZHxDo+91Og4UpwTQLIbADlWSUJ3JYZrnJiz47aBeMXU2j2khcbveJ+sai2qJdfzKM3wJZsmPfPkZ9CP9HLd7Vjg9vNgul+fWt9joE8PovcoOs1dOW2n4QMn+F7I+P4e0L+vl5MvoqB3dBxRM+nZhswK7cQBPW+8Kz7kWqhfCbTmK+93itElH+DibIjYym36NSY43eB6QBshTcEniBh4Nc3qlCZuVfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1ZN+NdNQdc1TVGrR3ey2hnzwdyHZpO+RmU9k1WLJaE=;
 b=HyZqLkHjobSiy5sBRALng7RYS3C5jul6jYqQ6T1ydtl7C1JT1fG+bZuXl/CGF06EKYqYZIoy7ap5K6/o58PBrjQGqDEdfuGdERa+ux3wYqYVJNHhz/vVnJwwYcALC8wLcZFbm4Rt1t40BUP56pbtcP76OSp31pUJLR64ahsLPd8=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MW4PR10MB5840.namprd10.prod.outlook.com (2603:10b6:303:18e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Thu, 31 Mar
 2022 09:28:13 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1483:5b00:1247:2386]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1483:5b00:1247:2386%4]) with mapi id 15.20.5123.020; Thu, 31 Mar 2022
 09:28:13 +0000
Date:   Thu, 31 Mar 2022 10:27:51 +0100 (IST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@MyRouter
To:     Hengqi Chen <hengqi.chen@gmail.com>
cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH bpf-next] libbpf: Allow kprobe attach using legacy debugfs
 interface
In-Reply-To: <9c3aece7-84d1-9fd6-76f0-acb2dd9597a9@gmail.com>
Message-ID: <alpine.LRH.2.23.451.2203311006110.28122@MyRouter>
References: <20220326144320.560939-1-hengqi.chen@gmail.com> <CAEf4BzZzLy2DjJ4pk_wx8KCsErfZE2-eG6pXO+5WnnRHxcfpiA@mail.gmail.com> <5d5a7f05-6c96-49db-6c3f-ae3ca713059a@gmail.com> <CAEf4BzYBzOEDgE+KH9jgUu89=GT7GeMNXx3Rwek4La5wKZZ-AQ@mail.gmail.com>
 <9c3aece7-84d1-9fd6-76f0-acb2dd9597a9@gmail.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: LO2P265CA0143.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::35) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f551d669-861d-42d6-2489-08da12f8c720
X-MS-TrafficTypeDiagnostic: MW4PR10MB5840:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB58403D2632D116DAC986FB59EFE19@MW4PR10MB5840.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cUJVB2AW1G2LrSEhOu55YscnYsMTrgg5HFxAErjdHJm9TnLiUXiBcfQp56s8UMkb0Atlq2xuTW49DH514EkUZCQ6yF1mMOMqWPiflmpD+hI1sV4MlAmQRFjbwn0be0/Is6mHeG8B4e/d6ipzONVQAIeqy0Dp2sEpnpu6RReVqZUJRskpOb3SWqj7nP86OWPfDZ0VMmWrG2KoTuC2H/LA6M2yE398eVmnXXwU5JW+R5Wohgh0bVBwDeRxZ9OOrmRmrYidvd0wTStpnW8ZNdXFZg8zlcBEFlqVK9o0BMJdRt5Gkkui+1xuOKYfY+Ak3BuoNp3rMZsdn6GaVyNvwMMFKDEEqwdyiN8q2wV7gaeD746BVF4LCtmZDtmRQo1YDbCzNHzCYkfEo2AHN/HyS6L4XhkYf7TsffjziCsAQfnO59Ei4wVdVa/oZFjSqsqj2PcZq3deFO8hefUmB16p9qRAGuvepZ8Zhn6j5eYOi8dUPbt+r1nAsEvySF7ltjbDyMsLnzVHA52DGYD7fhf+zzoNB3qY6/W8Ih1ckQNCg8jbVdkTyrccIwnoBWL6VBp4cIUfNJ/ab5dOyGYq78F7olqFSJ2yOXuzTimxODBL+tJ56fKCdjVc6XABWq0POPyNWqgrMur2ePDlhJZm4nEbOtk7XFGzh52Y8v3FkGTAiLbqlad0kD09Wt36FCVO37LYPLwmSiGxfvVvLz4ztO6xhaMG4yijntBJj2w6yrY234eZK4sDmCcgUErkiCwLFe+1uAozCyrRMQjgpBvinALKNhhA9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66476007)(83380400001)(4326008)(66946007)(8676002)(5660300002)(186003)(38100700002)(66556008)(86362001)(2906002)(6506007)(316002)(52116002)(8936002)(6486002)(9686003)(54906003)(6512007)(53546011)(44832011)(6666004)(966005)(6916009)(508600001)(33716001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ak5y85qGYVrFMP9crNhYZVk8r2h01xDKyCHD8NnB8WML2ZGNU6bwBrR7FQPE?=
 =?us-ascii?Q?5Knvdr/lUFzVaST9pVeCRZuI7wKlOC83yx9CLFGkGc9wQsVrlycYiod35yIZ?=
 =?us-ascii?Q?UzVpWq0cpp/r+HCLqb4FEuPfl3T3/esJUXin51bMVTb4CnPVzzrUUNbGsY89?=
 =?us-ascii?Q?M9DQ2RBXwOT9qp7NTWJdABLchaVZZwENqN4f9B8BzOG2l69JSS2uI5ME20Su?=
 =?us-ascii?Q?WHTOIPSxzUcKNEUfC2sUZmp7crusH5e8iCTpxKmyKoL6cN3BNdBQaGPtg30g?=
 =?us-ascii?Q?tvZKayoVINoYFaSpc+4dXdMBfZkwy3JfLE07YpgANQK793gReq7sDYdS06+8?=
 =?us-ascii?Q?n7oNSzHa2hqd/OQq26Wp58lzr4oHXmrUuzVTCsB86xRNNOo5dCUqlZdYIJV1?=
 =?us-ascii?Q?INNf+Kt8Izup/5O0PNxC8lTaw2cc7YY0/sKo5GMUHwL22rxS2Z8/FuVZfD/C?=
 =?us-ascii?Q?OUdBHLwOTx/X489hc/WVojBkAjkpcDo9Gp4cqNbpJBpG/6C+EAKt56WxHtgY?=
 =?us-ascii?Q?y/yv4hh9eYxc2CAQsweuzVKngtiCgb688i7FpXbBSGa1AH6XFOlRdxG8iXmg?=
 =?us-ascii?Q?NxE9ZkyVgdh5K7ywREsAu6FZK0e17zHpTYHeWxTC5WuTLOrT5vn/U3X7fWqY?=
 =?us-ascii?Q?vg+f3TXjzU+2e1fMDBA3yAOP5CBDbjpbZqd7WBkAPRBsoC5vC2J8L/mS4sAj?=
 =?us-ascii?Q?UHOZwhrjm4gJzhKbXeP6dBtr5nMKLRPjTxFmDqX3l+HO4aBVexmM716NuPnC?=
 =?us-ascii?Q?yfY7Syj3fH/kpZDcMpZaZVQOiwuYMAmd9hWIEmlyO8qflP4zSvoCFeyfthIY?=
 =?us-ascii?Q?priD2QIPRR4zpVG7zr3Vl4Jhf4Y22ZXd8RVqHogpyBJ49zxUGfYe9XhJkUAd?=
 =?us-ascii?Q?eeFn2HZoEnMEk1tApdJO1VF315t0WaFq+0pL0Z22NeXD0bi6WHYtuDEu4j5I?=
 =?us-ascii?Q?143+IyZ13OTiwJXTzI5S1LAU17JEoligj1cmoysuJxMzeivfBcguQNUVYJ6w?=
 =?us-ascii?Q?RcNs86HC81bwp1NySRS8rci2QhnWUEC5XFG4DYSUBJU4tStvqQ057zV/5BIP?=
 =?us-ascii?Q?GTDEh1kHR8m4HiwdMiTa63b8IPTHeXy6xeTh7qEpL9awHhruiNfE0Yxl0dt0?=
 =?us-ascii?Q?HLqqiYeX6jd89WL4BIhd6IJ6+qedjD7Wj9BXcZITr6HNbMeSjJZhqjYyXDuC?=
 =?us-ascii?Q?HhLIXd+D0g2IYQZF6bQGk+nBD1Ke2ETpOmEz+iM8oGNyH1wHG0c+9bs9tAfw?=
 =?us-ascii?Q?3uHlc7dj2oHmzX+HMtPWsFa7cSxlP10jEX4n41HN0OY0s5br2SkGl1A2Wula?=
 =?us-ascii?Q?OnYSfIZOIxRk6qSuRV36P3PLLSdWHRsHRb9fTL1vaOkOS8v/mdKAnXi+xrjN?=
 =?us-ascii?Q?JWUsPCXU1Uv7gKeCUJs3UI3gjikUoOy11mVBfgjiv2EFeYRbXttdKEBik9CH?=
 =?us-ascii?Q?ZghKgMmwzxYlWIsWRmHEMKbdA9wWrCUvJGLq6QPXJhLviJGVtueFJhz+1A3A?=
 =?us-ascii?Q?MaP2oZA2tB3fWLAUGjrONtuvbDe3OiD9eVjTjUAyT2EC9sWk8Y1LLLh/saZf?=
 =?us-ascii?Q?lFpmxzb2S/MTbMmg9/dMOcZbnPNMq2qkXMeD3LhR2yeUVNaiVn2K5hFiXjcA?=
 =?us-ascii?Q?GGQkXSlei4FJmRJiI8HgI+5XE4iuQ2H//RkVcLgbUCjLJivXH3icCam5Qaxr?=
 =?us-ascii?Q?5q/9vX4mFkD5czfXCFm4jCXJgnTnjHzz+U9am/TqdYQI644qZw+XR1GAcrqO?=
 =?us-ascii?Q?zX9BKGDFOt+towgMrfDZF1Zj5Gy4oK52P+lHAwT1wkm7dN9Nr2CS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f551d669-861d-42d6-2489-08da12f8c720
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 09:28:12.9557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xB6ebpKpXxAykfBfCTSRehLMzn9YcSSd8/SKRhdgW2fPX46kEnvbep4+IJZs8j7vcC9yWFQmN2095xdp9tLl0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5840
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_03:2022-03-29,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310052
X-Proofpoint-GUID: a4yyRukSmFRlHnKb8jb5P655uVZIP5Ht
X-Proofpoint-ORIG-GUID: a4yyRukSmFRlHnKb8jb5P655uVZIP5Ht
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 30 Mar 2022, Hengqi Chen wrote:

> 
> 
> On 2022/3/30 10:50 AM, Andrii Nakryiko wrote:
> > On Tue, Mar 29, 2022 at 7:30 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
> >>
> >> Hello, Andrii
> >>
> >> On 2022/3/30 7:18 AM, Andrii Nakryiko wrote:
> >>> On Sat, Mar 26, 2022 at 7:43 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
> >>>>
> >>>> On some old kernels, kprobe auto-attach may fail when attach to symbols
> >>>> like udp_send_skb.isra.52 . This is because the kernel has kprobe PMU
> >>>> but don't allow attach to a symbol with '.' ([0]). Add a new option to
> >>>> bpf_kprobe_opts to allow using the legacy kprobe attach directly.
> >>>> This way, users can use bpf_program__attach_kprobe_opts in a dedicated
> >>>> custom sec handler to handle such case.
> >>>>
> >>>>   [0]: https://github.com/torvalds/linux/blob/v4.18/kernel/trace/trace_kprobe.c#L340-L343
> >>>>
> >>>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> >>>> ---
> >>>
> >>> It's sad, but it makes sense. But, let's have a selftests that
> >>> validates uses legacy option explicitly (e.g., in
> >>> prog_tests/attach_probe.c). Also, let's fix this limitation in the
> >>
> >> OK, will add a selftest to exercise the new option.
> >>
> >>> kernel? It makes no sense to limit attaching to a proper kallsym
> >>> symbol.
> >>
> >> This limitation is lifted in newer kernel. Kernel v5.4 don't have this issue.
> > 
> > Oh, ok. So how about another plan of attack then: if kprobe target
> > function has '.' *and* we are on the kernel that doesn't support that,
> > switch to legacy kprobe automatically? No need for a new option,
> > libbpf handles this transparently.
> > 
> 
> That's better, and also eliminate the need for custom SEC() handler.
> 
> > Still need a test for kprobe with '.' in it, though not sure how
> > reliable that will be... We can use kallsyms cache to check if
> > expected xxx.isra.0 (or whatever) is present, and if not - skip
> > subtest?
> > 
> 
> Not sure how to do that. Even if such symbol exists, how to reliably
> trigger it is another problem.
>

could we add a function to bpf testmod that is easily triggered
and likely to be .isra-ed maybe?

Experimenting, the following function becomes .isra-ed at when 
compiled with -fipa-sra:

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c 
b/tools/testing/selftests/bpf/bpf
index e585e1c..bb51e21 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -88,6 +88,17 @@ __weak noinline struct file *bpf_testmod_return_ptr(int 
arg)
        }
 }
 
+struct testisra {
+       int val1;
+       int val2;
+       int val3;
+};
+
+static noinline void bpf_testmod_test_isra(struct testisra *t, int val1, 
int val2)
+{
+       t->val3 = val1 + val2;
+}
+
 noinline ssize_t
 bpf_testmod_test_read(struct file *file, struct kobject *kobj,
                      struct bin_attribute *bin_attr,
@@ -98,8 +109,14 @@ __weak noinline struct file 
*bpf_testmod_return_ptr(int arg)
                .off = off,
                .len = len,
        };
+       struct testisra t = {
+               .val1 = off,
+               .val2 = len
+       };
        int i = 1;
 
+       bpf_testmod_test_isra(&t, t.val1, t.val2);
+
        while (bpf_testmod_return_ptr(i))
                i++;


Tested on gcc 9; possibly different results on different versions..
 
Alan
