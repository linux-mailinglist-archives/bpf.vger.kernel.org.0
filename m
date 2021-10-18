Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E344431E1B
	for <lists+bpf@lfdr.de>; Mon, 18 Oct 2021 15:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbhJRN5w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Oct 2021 09:57:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7700 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234352AbhJRNzx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 18 Oct 2021 09:55:53 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19IDG2qb018039;
        Mon, 18 Oct 2021 13:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=I4/xxUWICjrMMOITjPkTWfYAhqQziTJ+F8v7noR0rZA=;
 b=yivY4R8eqrekSf9+mULSnZznbOA3e6So0J6CXjD1iDMrY3zUJnd+xsWDGZ3cga1VQy8Q
 +cLxx3seBJKuYJXvhcJGdBA/qP/PNmmrlQmJARwCNYs/26Zt3pCSTk6VLfcBdhuwg8U2
 04Oa9q1i3X7IHXr/91qLgi6ECJvGqWRJLQ6TpzhwuGeiO1jxQAXCkSZdwXThoz3OGj/G
 T9hVeWPCsU3ci82Ejgp8bXzc7Us9b8lahDBoJsX6xAELgPd82w9tmWRA8WsBtq1o9j2u
 XxJGZdVBS/LppGM9/4YUQxHLFBJ0ZqcuABanxscUM7mwUt/GCFL3pVcvM0HWFsdJMOrm jQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3brjxn3wh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Oct 2021 13:53:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19IDpTu6163609;
        Mon, 18 Oct 2021 13:53:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by userp3030.oracle.com with ESMTP id 3bqkuvfey6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Oct 2021 13:53:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cphV0oIQ8ZRZsltBpOXgeG18a3ddM6NN7IWKvU5Xa1zuR8sdas5TSZ9HkbpVXV+5HY2yAPuLSRyPEVhF+Jl9fnaONVIZYjzveLQWCeXBaoUPdWYm963osjf0RDQmTZKkSX4Q344NhtzvRIJh4kjdNXBA/1yuRRQezy/oQgfIK1GUpC4eHIgfrE3Zh3EhGtq1m6RHm7umXDG/Z9zKvFFVNgKal0oMPYHOVuC2v55DQ2YZ6pdhUyhTuK+h0x7cnBVwOeGbfSb/xMx5j49kdNtA52jXiw5QfI0q5mYLnC2d+vudZMmUbf6N4MqF5xsaDQ8PcLi9MT6wGMdVzfuNZ8rzug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4/xxUWICjrMMOITjPkTWfYAhqQziTJ+F8v7noR0rZA=;
 b=G5WZLkhbGOTnVddaJNtsAG7PPRnsr+i574mGOfi5uzelfJT05fOPehgMjdbfiSnPxVq7CVirDxZ6/7wIXtTEkx8OeqoXz6WbFuSG85hNJJg2YIvuRPMdVsB6whSW5lfw/jsl+odkv2SBRmvtrEV/Odvc1viXZw42ojHFue2jN4svh3J3ND48oUW9SSemL2F5yu3VZnwZEjo3xWnb4T+E+wIDaO/j15U+gN1i6GzrjCJZ+VcOYb1H/a6wBlv6vYxFBtmB91roahPs6EnOAKpZ8wQ/FyJ6cZSIqcHNTbbGI/eMf2NE2+0JjelbkDiBQMCHHSlFiQ1krcDwPChz8q4TBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4/xxUWICjrMMOITjPkTWfYAhqQziTJ+F8v7noR0rZA=;
 b=OZJRMfJGJ5T3VSFcmzX7QUq5KDPj5L9V3agJX0gTkrhug66qTbrECjrNKg7pYJ9o+gAXxkpPOUUH6Jhe0k0H48mcxLz1L+8suSw0jOL4fe4a+UeorPN0HPJ3WJdLGig6Uz4fe9n7PX6p2mp8vVveCxuvBE8rKE1oEUJ6QTbOIQc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN2PR10MB3582.namprd10.prod.outlook.com (2603:10b6:208:114::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Mon, 18 Oct
 2021 13:53:32 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::7c5f:ddbe:81b3:38e2]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::7c5f:ddbe:81b3:38e2%7]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 13:53:31 +0000
Date:   Mon, 18 Oct 2021 14:53:18 +0100 (IST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     Hengqi Chen <hengqi.chen@gmail.com>
cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        alan.maguire@oracle.com, Yonghong Song <yhs@fb.com>
Subject: Re: BUG: Ksnoop tool failed to pass the BPF verifier with recent
 kernel changes
In-Reply-To: <da0a8a77-eb71-57c3-35b9-f1dcaeaa560d@gmail.com>
Message-ID: <alpine.LRH.2.23.451.2110181442220.15730@localhost>
References: <800ce502-8f63-8712-7ed4-d3124a5fd6fb@gmail.com> <20211015193010.22frp6eat3wz54hq@kafai-mbp.dhcp.thefacebook.com> <da0a8a77-eb71-57c3-35b9-f1dcaeaa560d@gmail.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: LO2P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::23) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
Received: from localhost.localdomain (2a02:6900:8208:1848::16ae) by LO2P123CA0011.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:a6::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17 via Frontend Transport; Mon, 18 Oct 2021 13:53:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc39ccf4-37d8-46be-3dc5-08d9923eab56
X-MS-TrafficTypeDiagnostic: MN2PR10MB3582:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3582794A6288135ECF1E4046EFBC9@MN2PR10MB3582.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EjYrEttaYy5iw0/rIyva2hWeBFU/vakL8IkHH+StyfGTnE8iRRQtFvUj9dyN9KZ0pG9z9viUrrMJLBRin0r2mI59qjzuW8a9AIT1rJjuZOhdbqdYJncJl3FU1R7NwQ/geSjSMdEOqm8S89sJSaHd+07yuyMkQZkWBqQXosu+C1ln42kfMGy9jcnn6Ow3OCIGoJFE1W/ThwJ14YaE+EPLBOo0MVrvQlEI79btaauMhHSJzPV6tcFq0ZkhFxxCW3xbBQQoqXG8U8q4fd84erKok4QwMryEYZYxnskplxfQ6nzB9lF8m+JrL9aOSkYvWoqU0TAORHOSeJwqwgLbPuo+nKSr5sy7XzlIBKCgC0xY7c29ag8XhZMXSsMVm5ZpXYw/1vKK9dMqdUBVe46TLJ5P821wJQq5uSJCMFC5arOmzm25K+ix87pfZ5GpkF3s/S9cYGORpjGWWaF09+7b21gKjvwJDunjWnvHA8DiwteWooLMp5HcIEL0u+YljgCOqJJ6B33wo3yOcCJaJkEZ+X78oanfPOUuJrYvqCQBLHtjw/xvsDehE0WfTKazPBneb3B2d0STFBZ22VWHsao2zBNyKAgEAsCPo8EpE0NeAIoGnywM1FqdtipGrnUUvYCb1AGxsija4Mwje8UA05wiOQcFpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(86362001)(9686003)(316002)(8676002)(38100700002)(83380400001)(186003)(6512007)(44832011)(54906003)(8936002)(6666004)(4326008)(66476007)(9576002)(66556008)(5660300002)(33716001)(66946007)(2906002)(508600001)(6486002)(6916009)(53546011)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZB/Sc4gi17w8Mhnbj0hWrKi4UBumjou6e5LRkIjY8tYEn11ah5S3XNw2qda2?=
 =?us-ascii?Q?6yOS0uwYDYaMcLbhpGuLTbmgWY1V3KetNxS9J/cfnlgaPcXQjL7co6mYTmKG?=
 =?us-ascii?Q?kQIz8oaC96u8mt3RVcjMw4/zMJPzyxzdkdCmFlFLN5zbG/w8wS2+ujxSnRK/?=
 =?us-ascii?Q?8PZ9ZtYuODftHAi/XFRfEyN+VEDUwRZzE5wwpFH4smW9Dbx6izbDGSzx8i98?=
 =?us-ascii?Q?DEJtnyDKtuwzqzII9zSYbEpbbtlPaINMG6IJQuxUwyH2vWLV6nFgytV/UX4V?=
 =?us-ascii?Q?SpgibfGgztoboGSBZFvbJ1rWnOg/zILr7jvSD85H6+Q9qDnS1P/q6na3gv5c?=
 =?us-ascii?Q?u9kQuZeFyngwZqYcYTQBO+Yia8zL+nXrPwcVQbi7qgZQ8RwHVzoeYXx2C0bn?=
 =?us-ascii?Q?BfQhfQdqn8C+ikgC3z2e5dD3ErhSNmC1nkrDsFvbWe6TowtxBdZ+csYekazm?=
 =?us-ascii?Q?ZS1enAWSTjIF211f6bOva3ws+5NEESewpsaWGq9P0CYRY0FnpC+oqZePDr0i?=
 =?us-ascii?Q?ehaENr/gfRxcAWLRTTdkcKNQEg70bxR+2MNZycq3QejLfZwBEck7hvm7zeOX?=
 =?us-ascii?Q?6CRlYbzlIDM9pYihHmgrilkSI0rFIfNg9syGFHWDBd8kYr2aTyWqe6i7qOqb?=
 =?us-ascii?Q?9BO2PR+SZ+pIF9VjxDgONDK3AqFP93fV+0DueCPgcg6ndNblvfqV/Hyg8M+a?=
 =?us-ascii?Q?ubNIcqZIn+Q41MaVsarU3wnTVFiPxrBBYNl0BiYgRaZWeKDtnliXQbcaTqsM?=
 =?us-ascii?Q?XfbXwyDcFRJ4UI4bZ6r7c3+VPRqBqWF2lceRdPim5B6M/3TNmFygYO3bDOPt?=
 =?us-ascii?Q?4wya9u7mJlte36Bfn+TWcM1QN3vLnZPhLxaLKk2hu0y+XKZApKGqRg/lAA9S?=
 =?us-ascii?Q?DY3+QLLz8d6qjDDwRXhnkB1g3kWh/xJy5s8K8G1lhPP+cdEZcoSE6QfAjrTA?=
 =?us-ascii?Q?8z1lWhS7JUA7BxdtLxLUye406UJiCra30RX6o49ntIECKLB5Rn2X0jHFA4PY?=
 =?us-ascii?Q?08Yz9Q4lvZlPr7aeeTKcNty03YbKTxgA0qGl5m4KFjP55hPoRhwdFIEj5OE/?=
 =?us-ascii?Q?dXvKzmJbGplXQQ3ebeALRF/cuYgr+Fi6e1fn7784MaHNumdD+znh+B7jFNW9?=
 =?us-ascii?Q?r55Ay1/vww1SppVVVlJj6afgwMMah7+Q8t+hju4r5ZGN4yvWBHMZrRmuUcts?=
 =?us-ascii?Q?gGrlPgBKuGTrB4SvTZytLU7RXBNqBjUCchvfyd0rd0bAyB0hZ8KgL5UPZeAA?=
 =?us-ascii?Q?XcBMIMdy+3Nlfq09OUB4S5h5BuYeGKQulxEISoOv9Vo2kToUJbM6nqHtIaMw?=
 =?us-ascii?Q?eh/YNB0Fg+0ovUdULo0JDvAg/VDFiQQmQa+OJMxP/5b/dQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc39ccf4-37d8-46be-3dc5-08d9923eab56
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 13:53:31.7157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /f8uTMO6U6JR961krnje8LIfzL/1fOJntfarLN6ZPm1liTNAdsJFqkyL3r9UW4KLJ64qTxORVEUyWq5+fec9GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3582
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10140 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110180086
X-Proofpoint-GUID: fLmSaPNmGsvydCjaxi0rHGE5xWG7MQoI
X-Proofpoint-ORIG-GUID: fLmSaPNmGsvydCjaxi0rHGE5xWG7MQoI
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 16 Oct 2021, Hengqi Chen wrote:

> 
> 
> On 2021/10/16 3:30 AM, Martin KaFai Lau wrote:
> > On Thu, Oct 14, 2021 at 12:35:42AM +0800, Hengqi Chen wrote:
> >> Hi, BPF community,
> >>
> >>
> >> I would like to report a possible bug in bpf-next,
> >> hope I don't make any stupid mistake. Here is the details:
> >>
> >> I have two VMs:
> >>
> >> One has the kernel built against the following commit:
> >>
> >> 0693b27644f04852e46f7f034e3143992b658869 (bpf-next)
> >>
> >> The ksnoop tool (from BCC repo) works well on this VM.
> >>
> >>
> >> Another has the kernel built against the following commit:
> >>
> >> 5319255b8df9271474bc9027cabf82253934f28d (bpf-next)
> >>
> >> On this VM, the ksnoop tool failed with the following message:
> > I see the error in both mentioned bpf-next commits above.
> > I use the latest llvm and bcc from github.
> > 
> > Can you confirm which llvm version (or llvm git commit) you are using
> > in both the good and the bad case?
> > 
> 
> Indeed, this could be the problem of LLVM, not the kernel.
> 
> The following is the version info of my environment:
> 
> The good one:
> 
> 	llvm-config-14 --version
> 	14.0.0
> 
> 	clang -v     
> 	Ubuntu clang version 14.0.0-++20210915052613+c78ed20784ee-1~exp1~20210915153417.547
> 	Target: x86_64-pc-linux-gnu
> 	Thread model: posix
> 	InstalledDir: /usr/bin
> 	Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/9
> 	Selected GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/9
> 	Candidate multilib: .;@m64
> 	Selected multilib: .;@m64
> 
> The bad one:
> 
> 	llvm-config-14 --version
> 	14.0.0
> 
> 	clang -v         
> 	Ubuntu clang version 14.0.0-++20211008104411+f4145c074cb8-1~exp1~20211008085218.709
> 	Target: x86_64-pc-linux-gnu
> 	Thread model: posix
> 	InstalledDir: /usr/bin
> 	Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/10
> 	Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/11
> 	Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/9
> 	Selected GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/11
> 	Candidate multilib: .;@m64
> 	Selected multilib: .;@m64
> 

Thanks for reporting! I've reproduced this and have a potential ksnoop
fix (below) which works at my end, but it would be good to confirm
it resolves the issue for you too.  The root cause of the verification
failure is the access of the ips[] array associated with the per-task map 
retained to track function call history; it uses a __u8 index to represent
stack depth, and the decrement operation seems to convince the
verifier that the value will wrap from 0 to 0xff, and thus lead to an
out-of-bounds map access as a result.  Adding a mask value to ensure the 
indexing does not fall out of range resolves the verification problems.

As to why we see this now, I'm not sure.  The accesses of the ips[]
values were all guarded by bounds checks, though looking at BPF code
around the verification error it looks like LLVM optimized those out.
If LLVM is doing more optimizations like that these days, that could
be a potential reason we see this now.

From 2133464fe9b92be51ec80e4db7fb23ff9e77c40e Mon Sep 17 00:00:00 2001
From: Alan Maguire <alan.maguire@oracle.com>
Date: Mon, 18 Oct 2021 14:20:40 +0100
Subject: [PATCH] ksnoop: fix verification failures on 5.15 kernel

hengqi.chen@gmail.com reported:

I have two VMs:

One has the kernel built against the following commit:

0693b27644f04852e46f7f034e3143992b658869 (bpf-next)

The ksnoop tool (from BCC repo) works well on this VM.

Another has the kernel built against the following commit:

5319255b8df9271474bc9027cabf82253934f28d (bpf-next)

On this VM, the ksnoop tool failed with the following message:

[snip]

; last_ip = func_stack->ips[last_stack_depth];

141: (67) r6 <<= 3

142: (0f) r3 += r6

; ip = func_stack->ips[stack_depth];

143: (79) r2 = *(u64 *)(r4 +0)

 frame1: R0=map_value(id=0,off=0,ks=8,vs=144,imm=0) R1_w=invP(id=4,smin_value=-1,smax_value=14) R2_w=invP(id=0,umax_value=2040,var_off=(0x0; 0x7f8)) R3_w=map_value(id=0,off=8,ks=8,vs=144,umax_value=120,var_off=(0x0; 0x78)) R4_w=map_value(id=0,off=8,ks=8,vs=144,umax_value=2040,var_off=(0x0; 0x7f8)) R6_w=invP(id=0,umax_value=120,var_off=(0x0; 0x78)) R7=map_value(id=0,off=0,ks=8,vs=144,imm=0) R9=ctx(id=0,off=0,imm=0) R10=fp0 fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=mmmmmmmm fp-64=mmmmmmmm fp-72=mmmmmmmm fp-80=mmmmmmmm fp-88=mmmmmmmm fp-96=mmmmmmmm fp-104=mmmmmmmm fp-112=mmmmmmmm fp-120=mmmmmmmm fp-128=mmmmmmmm fp-136=mmmmmmmm fp-144=mmmmmmmm fp-152=mmmmmmmm fp-160=mmmmmmmm fp-168=00000000

invalid access to map value, value_size=144 off=2048 size=8

R4 max value is outside of the allowed memory range

processed 65 insns (limit 1000000) max_states_per_insn 0 total_states 3 peak_states 3 mark_read 2

libbpf: -- END LOG --

libbpf: failed to load program 'kprobe_return'

libbpf: failed to load object 'ksnoop_bpf'

libbpf: failed to load BPF skeleton 'ksnoop_bpf': -4007

Error: Could not load ksnoop BPF: Unknown error 4007

The above invalid map access appears to stem from the fact the
"stack_depth" variable (used to retrieve the instruction pointer
from the recorded call stack) is decremented.  The off=2048
value is a clue; this suggests an index resulting from an underflow
of the __u8 index value.  Adding a bitmask to the decrement operation
solves the problem.  It appears that the guards on stack_depth size
around the array dereference were optimized out.

Reported-by: Hengqi Chen <hengqi.chen@gmail.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 libbpf-tools/ksnoop.bpf.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/libbpf-tools/ksnoop.bpf.c b/libbpf-tools/ksnoop.bpf.c
index f20b138..51dfe57 100644
--- a/libbpf-tools/ksnoop.bpf.c
+++ b/libbpf-tools/ksnoop.bpf.c
@@ -19,6 +19,8 @@
  * data should be collected.
  */
 #define FUNC_MAX_STACK_DEPTH	16
+/* used to convince verifier we do not stray outside of array bounds */
+#define FUNC_STACK_DEPTH_MASK	(FUNC_MAX_STACK_DEPTH - 1)
 
 #ifndef ENOSPC
 #define ENOSPC			28
@@ -99,7 +101,9 @@ static struct trace *get_trace(struct pt_regs *ctx, bool entry)
 		    last_stack_depth < FUNC_MAX_STACK_DEPTH)
 			last_ip = func_stack->ips[last_stack_depth];
 		/* push ip onto stack. return will pop it. */
-		func_stack->ips[stack_depth++] = ip;
+		func_stack->ips[stack_depth] = ip;
+		/* mask used in case bounds checks are optimized out */
+		stack_depth = (stack_depth + 1) & FUNC_STACK_DEPTH_MASK;
 		func_stack->stack_depth = stack_depth;
 		/* rather than zero stack entries on popping, we zero the
 		 * (stack_depth + 1)'th entry when pushing the current
@@ -118,8 +122,13 @@ static struct trace *get_trace(struct pt_regs *ctx, bool entry)
 		if (last_stack_depth >= 0 &&
 		    last_stack_depth < FUNC_MAX_STACK_DEPTH)
 			last_ip = func_stack->ips[last_stack_depth];
-		if (stack_depth > 0)
-			stack_depth = stack_depth - 1;
+		if (stack_depth > 0) {
+			/* logical OR convinces verifier that we don't
+			 * end up with a < 0 value, translating to 0xff
+			 * and an outside of map element access.
+			 */
+			stack_depth = (stack_depth - 1) & FUNC_STACK_DEPTH_MASK;
+		}
 		/* retrieve ip from stack as IP in pt_regs is
 		 * bpf kretprobe trampoline address.
 		 */
-- 
1.8.3.1

