Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC46A4C497A
	for <lists+bpf@lfdr.de>; Fri, 25 Feb 2022 16:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239370AbiBYPrM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Feb 2022 10:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237586AbiBYPrL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Feb 2022 10:47:11 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64461FCD5
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 07:46:39 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PEkRIl017395;
        Fri, 25 Feb 2022 15:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=8QpZVpfkMcz9EmCDPhU9OZrzpE/FeIzt83e6jv2y/yI=;
 b=aQejc4u+2kNZjf2IHOSDQLIBfI6QxesiHfejJFnC7UCgz7dZO/KvgqTgpMcsjMqsJ/EJ
 jZvn0x/QldhpXPFj4ZUujRp9i6b3bFT/gQ8GOW2yQCYYfSdDlXKBrvUD194O/NIzwNja
 mev7iFYiJg0yRFkh02mf5UkyIbfajkBsLMVvHKQE2chgcL63pnuVwb0fdQQN1GW79eem
 bP6rgIHF32JRL8FZH6f0n9i0S+ccfkuynDPzuEp1UeA9ryaMonTpiOdq2n9rFPibFOeD
 5VCQ4GfXLl6Udc2hDvC76gX2XsBBbspjpakBbohBucXtqxu10HaHt6ZBBi3CF5qXZx9c zA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eexar9g2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 15:46:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21PFj469047184;
        Fri, 25 Feb 2022 15:46:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3020.oracle.com with ESMTP id 3eat0s7qwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 15:46:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwPPuBIA+tibG6DGxaOEGB9hkDLnU1e4AAVGz+5WtUnLDetAcqaj9iikGZ8nEUhBliwSCrabO+rkHwrjqunkv++pmSSV9IaAmGFuptv7j+Ia3mvmxOpVq3m38K560JC2kXM79Q4tVfr9Zapf+qBhk7PlGcZWesitBF4U9z2IYxqp28nQAaUv4AaEFq3Mqw+OD6FgFYnh4Jf3mZvU2hlW2f1qOeiHrBGeCLIGTKvn4GGMpLGl2fChxzS/MTlu4aGn5T1TO9ZdSgNyYMYa8rYQ5hyGdGq8rcVm2VK04GkW1QtJVdpYNZ6HUx9OZOLTe2Q139Ut+VkdtyEeep0C/Ua7tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QpZVpfkMcz9EmCDPhU9OZrzpE/FeIzt83e6jv2y/yI=;
 b=edqf8efpBTmVHDefzPFxn7Gd5k4vI4SCpvOKtiZc4RyDUYsoJo1irDvWmr3/+vNiv4lQiSCZda1M2FjthSvygWomqAJzFl9OSpnFB8FQKu+pN/Qrb5zmG6ANqYLaIlk1n9K2wr6tmtBZmctp3h1fAXOPVKW2IclpqEe/fQQvvckmQlZnrXu1f0vNLr1Sm6//srfZYsRKyyYRWH/O4F/QbBP9gzqDZORICPM47mS1UOiRAeumn/oe1YbIObdPbMsqfYhE6i+tpix4ww0qObcdgfRQzJPmUNmxl5hn+GQKNCqAcc8D1UHcANU/BOe99I2YsR3P4IS61rhLvnOPTJDkLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QpZVpfkMcz9EmCDPhU9OZrzpE/FeIzt83e6jv2y/yI=;
 b=YTi7hSmXStFVEmf8rU400TddxgwXuPvv720ykc4ehAosI/D4RHvderzDyV4VGPOJZDNceO4djTIZa3kEmnBP8R/x9i/O4hNgF55MMhOOLCUCYpd2qtAf9AYLrDSZduUY5pgBE2GRQlQ2BuHmMXBkUNZoyuGrDnKEg1+m7sP7pEM=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BN6PR1001MB2049.namprd10.prod.outlook.com (2603:10b6:405:2b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Fri, 25 Feb
 2022 15:46:14 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::517b:68:908d:b931]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::517b:68:908d:b931%3]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 15:46:14 +0000
Date:   Fri, 25 Feb 2022 15:45:50 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@MyRouter.home
To:     Andrii Nakryiko <andrii@kernel.org>
cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH v4 bpf-next 2/3] libbpf: support custom SEC() handlers
In-Reply-To: <20220224002317.1089150-3-andrii@kernel.org>
Message-ID: <alpine.LRH.2.23.451.2202251544470.14550@MyRouter.home>
References: <20220224002317.1089150-1-andrii@kernel.org> <20220224002317.1089150-3-andrii@kernel.org>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: LO4P265CA0068.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::22) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af847f93-fea6-42d9-c095-08d9f875f429
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2049:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB204909472BA5B84728D91E7AEF3E9@BN6PR1001MB2049.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x3zKwNOtBRvH3qwfVUfE4/JRFitelMiYKd/mpmvuEhWGkiAQaB52KN7D9a8IUHKyUAisXCrEkBJA0vUYNfkVnasktFwikHKugHbupv1+qNXH33Jfv7zWN5OV3BESBfZ8B2Kc13dvTy5RadWkxrUP7WXFZ7Bx/HSaXWz47DzBiBBU+9EMhmsjAa/M69JiCU9rgYHiN5t/wVWamPY4UHRM/PZIdf2XAW4K/sUomKgJ7carWsM0ULJ5NaCaVAhHUKHkVcCQdPpZTUZOh/EhpnWecJZLFyLFbPUu/FFMRWNFOJhmegYeKL55gaOPj8N1o3zMxDRrvWdHDh+9FxZt3VFT5fej5i/5mv1mSFcwONy7w9f50/Gadye2/basfDuoyQRoQOy4V/rW5aOTq2XUXJUzF/6Gzsuc7qWZDYzM+BsdUyn8tf2nWfimylRco+5SaZme0daPO3v0OGAe/xJb+IEgZsFcvueXpBzw6564ZFxrYsDOFS15sg8Fie//9xsofrkSYW5/pfx7uWz4tVdC4eK5L+LpFqHOd+DNSO5m5988dSWnBxEijUCuoxKiWchaI4LLfF1SPhAsdm+yZeKVE2G393FQ+AlHWSyb2oaq5PXhkLg3YGT5LJFiteHvLirWORIgWcNXknmPJ8a81n2Pszt81g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6486002)(66476007)(8936002)(36756003)(6512007)(6506007)(5660300002)(9686003)(44832011)(107886003)(6666004)(52116002)(508600001)(38100700002)(186003)(66556008)(66946007)(86362001)(316002)(6916009)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bQvQ1ooK0KAOsJp/mJw0Ut6yKImTNtzHGe6xX5BGbvtybO9a2/niHPq2gUIs?=
 =?us-ascii?Q?6xu7Xfkt/w5WrEClFg3oHJ6F9gaQOesfQ2JwmWcmOBfND70VBAHDhZrTgkUw?=
 =?us-ascii?Q?aRyJ0bfuIPz/e+sMSBYIpAcUdapeS0dHbBVSICu0OnD0nZ1VrmP+kB4rQgMq?=
 =?us-ascii?Q?ysDxraIn9EofUWaFynLL84M6KYTUAgOZN9XgWdFIUb3OJCjz+2upsVNAtev8?=
 =?us-ascii?Q?bEun2ia4JVrFwdAMrI0ecZHo7yrHf6CJNJZyDMyoJhlmipWPK7iaUTEKzmcr?=
 =?us-ascii?Q?EGXhrHfNK4seZCGbY/nwCeszb3N3zJpzzvuUw3HpQDH2dWXRuKjcLWJ2i3Ra?=
 =?us-ascii?Q?iSPz4kFPZG5a6mZGHZ5+Tq848r+GBf0diASWIdu/PrtvBYKOlFoZ27tSwQfz?=
 =?us-ascii?Q?xgXb9IBJhmKIKWmaZFVwjEUjVIFf5eXjNw84wpapAqw/sAZurNp+3PvxX7Cq?=
 =?us-ascii?Q?9+MJy4Hn2U3oy5JnCl1F8uN1S5hposqwAz2nQz2ZymK4BIaI6R8GT3RyWcik?=
 =?us-ascii?Q?atDxkf92KEdOiLilYHKOflPnLT3saPrb81oXJBt8uiIOyLZwg8o3dzgQppPO?=
 =?us-ascii?Q?rly7LOW3iBuOgnhMeH7HDuxLdHxOQCLLMRbuEQ0LbdOBpvOVmTsmVI+Dh87H?=
 =?us-ascii?Q?+A5y13PdmwF5NxGRsA88RsOnhCnzDJBPX/Rgbomt/Onhk6vmICC0I+BumPzO?=
 =?us-ascii?Q?teB4+lbuqXZ7tvJGF37eoA/wTr1NT1MjignB/edphuEGBQGaidL1TsvA8TKH?=
 =?us-ascii?Q?Z2uZrubN9pKpwo5i5UNmzSEY42pe9l2lwY7uvO5GiPOKpMnWqDvdjfitEHoF?=
 =?us-ascii?Q?6lpxZlo+YKtWs9erHfYmCNBYizXJDq84q7odduxs2QfQye9Rl+5ETM0cr2nk?=
 =?us-ascii?Q?iSmiFNoWeMPe9ff7mk4qYSffApTBDjLAEtgYs04jHWZvXK67wSOhz2hjDII+?=
 =?us-ascii?Q?PAcQPf7BT7Oij1lqzqkaTxnVz5EB5woKBaMOQMLoLmQO5/kftqVhZx+Y43bE?=
 =?us-ascii?Q?pMYlIYW8u9ZpkzAp9noyrpUiQhrAFbheChXnQsC5os86iKtJIBx+Eosn3VE1?=
 =?us-ascii?Q?7lCOFPxUwDIl37+L5u7UqY2WSb8uyZNW/yWcB7djn9FklrNlRtzs588g56ii?=
 =?us-ascii?Q?VJlXvNdxYTEqtHnPOAQZxLrX/D5vtge/5cwEmTXIjs+lRIT8r/3Fx9HIi5D3?=
 =?us-ascii?Q?f+l1zWqj3m9qJaQTumtLzh0t4HlbXgEVDheha2ekHZbcRPZKbJuhU8MuT4g3?=
 =?us-ascii?Q?TbfsvRBjMOs5NW5XLBd2pQY26nXHW7GFhmtJcaMTBYUaluDouP7RhaUp6w3f?=
 =?us-ascii?Q?OhHSg5kb/QzxeLomwuzluRC/FA9WhDUTsGvVcOAIyw0N3fMhOK75own+QYEQ?=
 =?us-ascii?Q?mK9Ie9HOqrv5mQ067lqtp42YxTFga46heH6fHT8uypzxJUI/kloIbGUY5sBo?=
 =?us-ascii?Q?sOK1e0LiWtOBxFjyxjoVn+78MYEAWKZg1OKLYjxZfcZbTJFh6BPEM81XhduB?=
 =?us-ascii?Q?0kAExdOL12NLOyRgtUIgNUMKKawemcpR/lDP119mJt7wZsm6G3Ndd8yCGHWq?=
 =?us-ascii?Q?2qy95lWMeBW//fkg0dlKiP02xWwKIxO/L8InSY8BoGXqS5nEP6oEYU9PV5h3?=
 =?us-ascii?Q?flYMQO9ln6NfbikZcwser1iSstqpEz9EJGNrXIhWcqNXpsutKoR6veZhdwUv?=
 =?us-ascii?Q?uxrVurfSq3twAj8KDLsfYJKvLdE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af847f93-fea6-42d9-c095-08d9f875f429
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 15:46:14.4936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDzQFqKH2w4VHTks5FjnS+lCah0O8VTvd876Cvu8taIQdb/5yAjk1tIf/jlyUBE/q+dQ8EXyrzw7Akq5y742kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2049
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202250092
X-Proofpoint-ORIG-GUID: h_MACDB5HHpL_qHA4btRSsTXt2SI6aPp
X-Proofpoint-GUID: h_MACDB5HHpL_qHA4btRSsTXt2SI6aPp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 24 Feb 2022, Andrii Nakryiko wrote:

> Allow registering and unregistering custom handlers for BPF program.
> This allows user applications and libraries to plug into libbpf's
> declarative SEC() definition handling logic. This allows to offload
> complex and intricate custom logic into external libraries, but still
> provide a great user experience.
> 
> One such example is USDT handling library, which has a lot of code and
> complexity which doesn't make sense to put into libbpf directly, but it
> would be really great for users to be able to specify BPF programs with
> something like SEC("usdt/<path-to-binary>:<usdt_provider>:<usdt_name>")
> and have correct BPF program type set (BPF_PROGRAM_TYPE_KPROBE, as it is
> uprobe) and even support BPF skeleton's auto-attach logic.
> 
> In some cases, it might be even good idea to override libbpf's default
> handling, like for SEC("perf_event") programs. With custom library, it's
> possible to extend logic to support specifying perf event specification
> right there in SEC() definition without burdening libbpf with lots of
> custom logic or extra library dependecies (e.g., libpfm4). With current
> patch it's possible to override libbpf's SEC("perf_event") handling and
> specify a completely custom ones.
> 
> Further, it's possible to specify a generic fallback handling for any
> SEC() that doesn't match any other custom or standard libbpf handlers.
> This allows to accommodate whatever legacy use cases there might be, if
> necessary.
> 
> See doc comments for libbpf_register_prog_handler() and
> libbpf_unregister_prog_handler() for detailed semantics.
> 
> This patch also bumps libbpf development version to v0.8 and adds new
> APIs there.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

also if you need it, for the series

Tested-by: Alan Maguire <alan.maguire@oracle.com>

Thanks!
