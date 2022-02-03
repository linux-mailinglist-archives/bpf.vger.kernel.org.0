Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7474A4A8F67
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 21:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiBCUwH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 15:52:07 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:4240 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229473AbiBCUwG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Feb 2022 15:52:06 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 213I6XFl007450;
        Thu, 3 Feb 2022 12:51:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=3sZ5Dp882EPvlT1g3Eksbz524PBpqSiQ69kg8XfZXtU=;
 b=gtaeQUI/uS+2w4h6iw+RfWX8asNKrR9OVSIwFJ6cuVJYsafFiZjjq5k9vhrp+R9s//EJ
 9sDch8Wx2SZxixzSElVGXwUzQk3JsJ5bn2lwUun/TBGS6oJgsp+XDNdCe7dhgxjcgXdE
 oz1XTiu6uCLhbjCgj+bqnynLFAkgCQLKGeg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e058jx5p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Feb 2022 12:51:47 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Feb 2022 12:51:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpxBgObXcgqWUpuJayXE+UbhObt4xTqAX1L1jQS9lypXQfsoqIM+nxVraRaXLvR5ZMKPWUfyG4MkBrT5UbvHx4uA0ij+dsjHC1QEhtItSaiAzjYgpsNycRRwjpuf+7LGEqan2W77CXa2hULXyAf2E79OHJRwCnZ/milw7tUVzGoF8XN/pZFCXvKMy4WoElHBp+iDgmwrrIC67+r8qmPosiG3zGb/WGD/kq08bLgf1fpDkJTIrCj6JDafWPeb338HLEtz/EIihRTUVqO+5zXOkXypLzIxqWuf2Vf6pGDfJMJMGI+/zKB0GGn0VdW95YdRRuXb6x+jgkIH/8z25Glhuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sZ5Dp882EPvlT1g3Eksbz524PBpqSiQ69kg8XfZXtU=;
 b=WCLnBux0YDVav4T0KBKi4yj5Dn1E8juQDCR1JOaSsqVy3uygN/kcOUN12GmbJYWOHtJ3GEHRiOBsWPNg1aRFEg5XDJ2OFC2znDuTu1MBDoL8lmXgbYibPwZ12i33CCdeMr1GeRs7kM8BYz8GUKrlvWE6B2lc9v99qlJqDGRyN9G1GaFETdj5sA7hm8INMfNOHVHrzaj29zkTvsbP6U68LNwdV23imZTpoUGmpIL/3UC4Ag1IcrZQNtmREd6wLCf0fO2BuDDBFlclsODtogN0fLO9ggyeRL0wcXwxiqP8lNonpnJ/OKsCtbVD1LGc+W4P5arfa/1IdLPXt1JCnNFkGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by BN8PR15MB3091.namprd15.prod.outlook.com (2603:10b6:408:85::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Thu, 3 Feb
 2022 20:51:45 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::b0ca:a63e:fb69:6437]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::b0ca:a63e:fb69:6437%6]) with mapi id 15.20.4930.021; Thu, 3 Feb 2022
 20:51:45 +0000
Date:   Thu, 3 Feb 2022 12:51:41 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <syzbot+53619be9444215e785ed@syzkaller.appspotmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: fix a btf decl_tag bug when tagging a
 function
Message-ID: <20220203205141.5t7eaoeotpa7ensh@kafai-mbp.dhcp.thefacebook.com>
References: <20220203191727.741862-1-yhs@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220203191727.741862-1-yhs@fb.com>
X-ClientProxiedBy: MW4PR03CA0320.namprd03.prod.outlook.com
 (2603:10b6:303:dd::25) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e17c88f-6fee-4eb2-1f9a-08d9e756fd01
X-MS-TrafficTypeDiagnostic: BN8PR15MB3091:EE_
X-Microsoft-Antispam-PRVS: <BN8PR15MB30917722C6B86A6B1E953EBDD5289@BN8PR15MB3091.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brSh5n/qQV3DWqgm04KLCE1gFadCpz42XQv4Bu8t/CcMsLRhROig2cg2rsEpT0Aa6eKjWQigSrHKRpVun+a4y+ryc5tFtRaf8+WjD4KNXuhZWhl16aRkGRXrzQgoK4pUmisE2XjJx8apwjaGFuELyQMujb02M5KPH7wRHfYaYvdhRZSBGqTrmGrosLKrCEdtHW837tFLUbzJT6x65tVBXzmb8VmQndbEMiwrbdG8vrtJoReGbcNLQRmid0YTKKfz/BeRRiepD9l4Btx5yXyNpXpDr09JdSHmc4u0o2lVdkudPI5cisrSfa7CGyhS0w7jmSSKgvnTiOZIZPZFqeEZvha80LURQO71AJiFCL8Q+QR5gI+tAa4s2i8U/44LiCNoUy504p4K425WsvXXVRS6tRsYwLCWiisfE5hOptyiki2Hp6iGXxiX/B9npoLxqARowQCyXv/wpVqLR2I+BFXfEiQNSVbVPG3I0HYePrVfkEo9z0/EUNtBq0zrCz6xXFqz6sBI53Vh+MzPhQQU2hh5shjSHi1OQkCqGk7vvWULUWdZbm31Mn+oRuiwA2VT+Zqg4OuJQuw6w5PHIsedoYkqW6S7Evu93kHBYGGimxQVPofuOWzvYWiM4I+f7BtKbfF6v6zpn3su4p2Bygpt4CcmMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(66556008)(316002)(6636002)(5660300002)(83380400001)(86362001)(38100700002)(508600001)(2906002)(8676002)(6486002)(52116002)(9686003)(66946007)(6862004)(6506007)(66476007)(8936002)(4326008)(1076003)(186003)(6512007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l0X4IyWZSAD7PQg7C65J0Su6mcl9skvhwfMA8v+UwOMGzF1kS5unckfGpGi/?=
 =?us-ascii?Q?Q0PtXccWTzO9eHubyoF/OJsVaPCv0c4cJS6fi35iwAo5zBkqrMzw9BNjz+G/?=
 =?us-ascii?Q?CZyr/ODMuZ4TECriNHdkrXEhcoTGBv7fxIvZl5MKTe4nYodgN/8uR2g2X9XS?=
 =?us-ascii?Q?39bEIXtzO+YHus7XVVHTCcgPYHGHzmoN1I5eAzaqBwIY1xMuqcS5cGdSgRwR?=
 =?us-ascii?Q?8nDGgtKskJnhXiapXjvLG9LR+16HAQW/zyDQtOlYTWWat2Pk35KOkSJbPqT+?=
 =?us-ascii?Q?Ia+PcAmhOAEikOMyYG4UWosF45FT+gkoEGjSZGf4nvLjTQKRlSLskzYWlYc7?=
 =?us-ascii?Q?X+8NyoMuRXryVRXOX8ffXgqZ7I6eBSWB3NIW1Hj4daDWfz1Qvul7rNCawJE7?=
 =?us-ascii?Q?Z9Cch79W/JWoDPOH03S4dq6xQ2k7ZinmTrVO11okdZ7OsgdifDr8ZAGImZ3G?=
 =?us-ascii?Q?D8+eDM8Kh4zltq65owymROncv6ylQDKGIZ/dUhTFf21GYPITTKWLfv4UbUzO?=
 =?us-ascii?Q?oCmnHbTtdfV/b3nSWmQpNha1o6cAprpI0PU9uuKlapOstaJdgliYlcLCjBSK?=
 =?us-ascii?Q?qPkptA5iRWIp2Dw59TzePyk0KERwWboGQg6/QUga6ZkB1orWke/tFWsnpJOs?=
 =?us-ascii?Q?HQHyPn4huoSz5Zw/5wi+FW9wp2XTsLxsuqpi9iY5/8U62e1ksTWCaLl2VXsH?=
 =?us-ascii?Q?FqXGhlLlPoZ+rvLEyjDq7PStlQ7SR/pULlKaJXZei47vsRB0z6dHt3NyvhfA?=
 =?us-ascii?Q?zscbMON3yASP/nB6UMSGUeYuTPUiu9QGAzhKlccLmPIYvUUtvWktAg13cU0G?=
 =?us-ascii?Q?jfCeJVRc0oD1aXEa8vxrJoarNbnGnWdOPi+Er+Hq1WjWH5FOlnPcEueo/TT0?=
 =?us-ascii?Q?te1Ng/gBnL7NGCPG19FKBeF3Q2+dVD7a5BexraWTA17A9Zq2vvblc7a0wdMQ?=
 =?us-ascii?Q?H4sb39cQ1TsAHgxGw1oyS2gdwUP0zppGIWlMskJbd25VeW/CBk3P3h3qsh54?=
 =?us-ascii?Q?zWCRFp553juGUz2J0CProTP1qp7PNofBzT6nbjqLzctEcI1modDxEnFogs0n?=
 =?us-ascii?Q?xQ5SDPkLjaZNMgKjH+yGnn19hjTz1ZRA+1So+M7ZqAhtQjlwmYnGQEs4ldBc?=
 =?us-ascii?Q?TM8zMdS3BlpMTc/JLHJbJyFEQUr59q/19OfT60OoohHXN5SuhuTeEXlQQuvm?=
 =?us-ascii?Q?RNtEKq3NVgAr9mhI3lxFUnTZhNsM8cbBh1FJMXY+1k7TqqY5Oh25Png6NCTh?=
 =?us-ascii?Q?xEY5KaM80rxcg/mc9Mu+JIYbmeV8cThBJHMEk9VB/z1sSq+BvKddjtzs5i5X?=
 =?us-ascii?Q?6s7mQQ+lyswUlTIYVcuWIR2pskT1sWDzYtIYJK3+fmzupAeB5s+9JzucnCYI?=
 =?us-ascii?Q?graZ2Lhw6kDyyaFBHcmhYzaJIsGI1ArQHI9uR9khpTU3q9P35mCOdYaxY0gS?=
 =?us-ascii?Q?w6QtYhy2nG/CX2gPvSk5Rfzg/D63sarygAmcqpgkI5bFSxadx0lOYwzMxOAV?=
 =?us-ascii?Q?meiuxDjilDLnVHtP5PpQRIe2m43iEg97F7JVUcp9z5zDi7vc36PAueS10ERM?=
 =?us-ascii?Q?oXTGmtcNwDGVU8OAZ2+n8ZaKO7jOje4xN/oDVo/1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e17c88f-6fee-4eb2-1f9a-08d9e756fd01
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 20:51:45.0360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgZC3nY+Tw+ckH8jpafXekzBGNPRMsApvDw2QNC2jxKm4K9dXW+zZSMbHlDAZWUG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3091
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: YILGka13y6GasP80vVVHSSL5Gp9_mkfD
X-Proofpoint-ORIG-GUID: YILGka13y6GasP80vVVHSSL5Gp9_mkfD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_06,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=672 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 03, 2022 at 11:17:27AM -0800, Yonghong Song wrote:
> syzbot reported a btf decl_tag bug with stack trace below:
> 
>   general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
>   KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>   CPU: 0 PID: 3592 Comm: syz-executor914 Not tainted 5.16.0-syzkaller-11424-gb7892f7d5cb2 #0
>   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>   RIP: 0010:btf_type_vlen include/linux/btf.h:231 [inline]
>   RIP: 0010:btf_decl_tag_resolve+0x83e/0xaa0 kernel/bpf/btf.c:3910
>   ...
>   Call Trace:
>    <TASK>
>    btf_resolve+0x251/0x1020 kernel/bpf/btf.c:4198
>    btf_check_all_types kernel/bpf/btf.c:4239 [inline]
>    btf_parse_type_sec kernel/bpf/btf.c:4280 [inline]
>    btf_parse kernel/bpf/btf.c:4513 [inline]
>    btf_new_fd+0x19fe/0x2370 kernel/bpf/btf.c:6047
>    bpf_btf_load kernel/bpf/syscall.c:4039 [inline]
>    __sys_bpf+0x1cbb/0x5970 kernel/bpf/syscall.c:4679
>    __do_sys_bpf kernel/bpf/syscall.c:4738 [inline]
>    __se_sys_bpf kernel/bpf/syscall.c:4736 [inline]
>    __x64_sys_bpf+0x75/0xb0 kernel/bpf/syscall.c:4736
>    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>    do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>    entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> The kasan error is triggered with an illegal BTF like below:
>    type 0: void
>    type 1: int
>    type 2: decl_tag to func type 3
>    type 3: func to func_proto type 8
> The total number of types is 4 and the type 3 is illegal
> since its func_proto type is out of range.
> 
> Currently, the target type of decl_tag can be struct/union, var or func.
> Both struct/union and var implemented their own 'resolve' callback functions
> and hence handled properly in kernel.
> But func type doesn't have 'resolve' callback function. When
> btf_decl_tag_resolve() tries to check func type, it tries to get
> vlen of its func_proto type, which triggered the above kasan error.
> 
> To fix the issue, btf_decl_tag_resolve() needs to do btf_func_check()
> before trying to accessing func_proto type.
> In the current implementation, func type is checked with
> btf_func_check() in the main checking function btf_check_all_types().
> To fix the above kasan issue, let us implement 'resolve' callback
> func type properly. The 'resolve' callback will be also called
> in btf_check_all_types() for func types.
Acked-by: Martin KaFai Lau <kafai@fb.com>
