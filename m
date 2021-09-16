Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3574340D152
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 03:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhIPBod (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Sep 2021 21:44:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46442 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229816AbhIPBoc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Sep 2021 21:44:32 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FM3xD7014938;
        Wed, 15 Sep 2021 18:42:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=aTCGjXNpAaaedPenisI0VcKFkKU1D+HHYt+Mkr32/Mg=;
 b=Qc3v56RXlhspaOk8vg2kTN6QQwAmqLjmrZWgX1gfx51Dn8c03WLfgFSVDWUAZSd8OF8b
 mswaTaxVhOqpGl3lgIRSHypyZL4dQowIM1kR4pLnUyB4pK5KaToHjfRU2cxH1jdO5p3/
 KgNxG76ZTF89CQCBs6PKMMIuQMXcu5TIhG4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b398af7mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 15 Sep 2021 18:42:39 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 15 Sep 2021 18:42:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUE4o8w3Z91q7F1msjOkpacEeHv/zfEho7TAYoy0igHV7rGrFSEfnm9cYEfL0AOE+Hhfi6Kz4Ij9CnZBrqrL8zQ/gh2RA4R2Z/yc9C+ScjmqbT6xHSvcyng1prr9Jt8TRlcO2F6/dT6a4cnGwW9K/ukMLiabV47rLyHkldNBEak/vlIrdqKsLXJKEFkHqDmwKrBUovpg09eAzTQ4QMFlvIGxy8v03bF7c0pOn7F30c7BpBTWhxk0GSnux4e0H3962/Jt9GIVuSPhfLlYgjPj1Xxa3twR2NnJs5EcR4jj4N4SRzCQKQEL3TcYx7meSPCSToQgRGutywnClR27LH6lTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=aTCGjXNpAaaedPenisI0VcKFkKU1D+HHYt+Mkr32/Mg=;
 b=V0ho5rMbFblkFI7vAd+CrIEj1FMGC7Idlvo+wmKgqj04ypQROj4OLl01RFkdA5gVY91jEh3O7G2AYLHW1fLrbqpxcAlm00LNWK2+yYdzSxbJ9YT+z9mmMot94iyZ9SAnonfUWkmcf25XHGy0EpWBi2e7Q89iEblUK2vcqcbCvoh4TvG1eHRvlSAHxCEmWFWYkZ2d/PMMUjubEXlUaBKu3aW6O+GgZCkQRcqLdmjUeC+e2R64Jed4s7Ikcvo3n5icU6WlvZw2lgutLE2sKXYfgnkLghGzzop04/leUDg4Ui1gIzuqlbjYir+WJr2AcJwzY+WoCC+IdxHdE0s/9bLmDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2871.namprd15.prod.outlook.com (2603:10b6:a03:b4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 01:42:35 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94%5]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 01:42:35 +0000
Date:   Wed, 15 Sep 2021 18:42:32 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Hao Luo <haoluo@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Will Deacon <will@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Barret Rhoden <brho@google.com>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rfc 0/6] Scheduler BPF
Message-ID: <YUKhCHarl+Ng1xxR@carbon.dhcp.thefacebook.com>
References: <20210915213550.3696532-1-guro@fb.com>
 <CA+khW7i460ey-UFzpMSJ8AP9QeD8ufa4FzLA4PQckNP00ShQSw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+khW7i460ey-UFzpMSJ8AP9QeD8ufa4FzLA4PQckNP00ShQSw@mail.gmail.com>
X-ClientProxiedBy: BYAPR06CA0042.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::19) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:aa1b) by BYAPR06CA0042.namprd06.prod.outlook.com (2603:10b6:a03:14b::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 01:42:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4d09dc7-e041-4380-52d3-08d978b3422c
X-MS-TrafficTypeDiagnostic: BYAPR15MB2871:
X-Microsoft-Antispam-PRVS: <BYAPR15MB287148659A75973991A621A7BEDC9@BYAPR15MB2871.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RMBGD3bG2KKCXIZQ/lp5BK+KzvJ20RBhAGPY5cPjmuExCOpFwvjRrlgxwVdUU0Pbpi+5UFOZpPA8f2/q/kyOnqEBeQtUoGEidsS2oqgGTGNSA+ihDvHFdUyOD1bSwb6mF5YY6YxB3/hFZmcFKO42mWhwyuqm8eRxVphz4U20kMmYX0kRJQsciRQi99IhCaFtIjS02om48vwb7Tj/w2snXhQGYQkfDrj3UDlEz2iwE7QbRf8uIWroRcSuGqhnQWFDYyVbI3nP/4qJHvGWwMpLrhGUct34O9+nWchK8JgnXVWbIcOX6Y88ffqaZHmbDHNF+4IOur1DQvh9BNra1l1b5JFp6EnQey7t5OePcOMPDM/K27N+63UNNLGO+2ToUbQ9tQgMwaQ0Tx4u4wfyzJIIWKRuEyd5/NRmCxzDeELSQiX0DMgcfTBSqfl0Vidyh9jP50aUfiVLVL9gHwzoKYJgUPzW+I8toNGNvdNIb241X5atcM2thlibbMQgdvr3twdECsm5d7HyUOrk7HGICf/mSYeUH5xsJ8WOvhSnbX94gx1Mp4edelm3wS6CTHuQ747oTPUWjB04kyt2jMJa6/jAl27MEPT01UPFZ6Gxwc8NyKYc1YeS5QN5Qlbdarc7F1UPhG7wgyra8Yk1QSqsKDTkH8jZ5VFQAYHclAkEm4AgCkfqKpqWflM+YO2LMd08YUMH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(55016002)(5660300002)(83380400001)(86362001)(8936002)(4326008)(6506007)(6666004)(8676002)(9686003)(7416002)(7696005)(54906003)(52116002)(316002)(66946007)(66556008)(66476007)(53546011)(478600001)(186003)(6916009)(38100700002)(2906002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Aoyw5nLzCPJnGD6evl6fBHv+vksSjYeS1c4tsBp/DWDA/DNCDJTkiytQhjD?=
 =?us-ascii?Q?QSw0nMQe/Rs/4GKzcTGpDO8yokjRoNdA7mI8ThkSAjlmMD/FwceWi5veFOmk?=
 =?us-ascii?Q?rdHgFmid6sJ/4BWVMV9qhm+ifwvpwjDj/QYEZqs7bz1Pf+w9mh6yDx1LSSBQ?=
 =?us-ascii?Q?dXIgNFphJGwPXeJs97VUUaRra6uhBOv1XlrYu2FxF5512cgzP7qsYHl6/3pb?=
 =?us-ascii?Q?y+LA/u80LhOJjEij0P54TzA5b6NlvIDXgpgx2PDiYTI9a1Xn92kwuGTTaqij?=
 =?us-ascii?Q?kFNpfA+o/5+IOepO0fzU21RuJ+WezNl93MxD1OFcfSQgIUeBIR53LK5Hq/I7?=
 =?us-ascii?Q?2lGKaxN2ACdwDJieIL+z0tseYOm+/Iuu2rTjRLxPiN4zvyAz1DcvnFDhSzeE?=
 =?us-ascii?Q?6PjfFAFYOpRJW+BbknHRQwb3O429t5iwgkVyz+/HasZEsJTc0+fC332sL2tc?=
 =?us-ascii?Q?IMPSbCRitm8+q0ioUN2MJlY8xduR73OCNyBkRuauFI4Q2BTy7dCAoJ/DRGg/?=
 =?us-ascii?Q?7eZC4uj/TVtiHfN2p8H4JjrpuOT6rQRKiB6afCw8plgPeyAUHylxQAkKI9YV?=
 =?us-ascii?Q?0KlFhNas2SNKFAlVXmlrm7zsbJiuB5oOKY0nMQXF5gjqU08+9bbmgmcxNTbF?=
 =?us-ascii?Q?iS984i1y/FgfCs003Fc8Ipo+6deOnYuiUM4odrGqBKJbPPSGd49Ph5RsD3oe?=
 =?us-ascii?Q?qjDvJUiUDAa1Hhtmcx3qsdiOuqQ4eBXwGSVUpwZ9nIkEKzUQttGKY0pmywO6?=
 =?us-ascii?Q?v/bCZUbkfZh67NPfEIs2Ttc4NDev1x3jpBLqAlqUnOP5kBmfMtr12bWR6jSW?=
 =?us-ascii?Q?7IHJ+PDOSkkVbsfszE7J/ql1Ha+jSfz2WnC5Sm1W1KaOqEMCWS3WJikVLKzo?=
 =?us-ascii?Q?pa2+ye4BGHMv0dejpfPkkXSDhPZCKEANUC9tNhXKkya1IkvSN1wovnppLk2k?=
 =?us-ascii?Q?x1ZR6/8tG6WuqM/y9l+HEB31en8xOU/9WCwOWeuYq87niKEGSaF8fujjggEg?=
 =?us-ascii?Q?bjh3m/6IxybZmx4OAI6KYwpTer742uKlHyrZJPlJUDTfHhq+OpAIUiNDKwA+?=
 =?us-ascii?Q?Tnh6dVXEc5/gXOU2C8nmDkZpEhowUP8zzgF6/o8nvNHGQqEu90U2sG23Ywd9?=
 =?us-ascii?Q?FZcCnvSqd13jlcnjB6wZH/54dVk8C70ewY6YzY0PC2SkBZCcVf+hU1DnzzBx?=
 =?us-ascii?Q?EplM7wE7XmcpUpk0mx49g27Fm1bCYfUEmykNBubeReRKNwJUJr03gRe7nOGL?=
 =?us-ascii?Q?3CEKdRxlGGVEVxUbvGlh8GFyN+OKWKOkmIrO4nean52e5GyVSDFpNTCvtytt?=
 =?us-ascii?Q?fHlTTYRYMDncospHFui4abrY0gzhbr2ZEEdJjJQy1OYtZw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d09dc7-e041-4380-52d3-08d978b3422c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 01:42:35.7014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXZR5GF/+hRx7vCFC31KyLWjcStOJAT62bUfIt3Zt35pwT8lZxNDf/HyMJd0a80e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2871
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: DwIPp9AvWvy5Ozw0dj9OnkPisvF-178M
X-Proofpoint-ORIG-GUID: DwIPp9AvWvy5Ozw0dj9OnkPisvF-178M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-15_07,2021-09-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1011 mlxlogscore=691
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160009
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 15, 2021 at 05:19:03PM -0700, Hao Luo wrote:
> Hi Roman,
> 
> On Wed, Sep 15, 2021 at 3:04 PM Roman Gushchin <guro@fb.com> wrote:
> >

Hi Hao!

> 
> Thanks for initiating the effort of bringing BPF to sched. I've been
> looking at the potential applications of BPF in sched for some time
> and I'm very excited about this work!
> 
> My current focus has been using BPF for profiling performance and
> exporting sched related stats. I think BPF can provide a great help
> there. We have many users in Google that want the kernel to export
> various scheduling metrics to userspace. I think BPF is a good fit for
> such a task. So one of my recent attempts is to use BPF to account for
> the forced idle time caused by core scheduling [1]. This is one of the
> topics I want to discuss in my upcoming LPC BPF talk [2].

I guess for profiling we don't necessarily need a dedicated program type
etc, but it might be convenient, and some helpers can be useful too.

Unfortunately I won't be able to attend your talk, but hopefully I can
see it in a record later. I'm very interested.

> 
> Looking forward, I agree that BPF has a great potential in customizing
> policies in the scheduler. It has the advantage of quick
> experimentation and deployment. One of the use cases I'm thinking of
> is to customize load balancing policies. For example, allow using BPF
> to influence whether a task can migrate (can_migrate_task). This is
> currently only an idea.
> 
> > Our very first experiments with using BPF in CFS look very promising. We're
> > at a very early stage, however already have seen a nice latency and ~1% RPS
> > wins for our (Facebook's) main web workload.
> >
> > As I know, Google is working on a more radical approach [2]: they aim to move
> > the scheduling code into userspace. It seems that their core motivation is
> > somewhat similar: to make the scheduler changes easier to develop, validate
> > and deploy. Even though their approach is different, they also use BPF for
> > speeding up some hot paths. I think the suggested infrastructure can serve
> > their purpose too.
> 
> Yes. Barret can talk more about this, but I think it summarized the
> work of ghOSt [3] and the use of BPF in ghOSt well.

I took a brief look over how you use BPF in ghOSt and I think what I suggest
will work for you as well. I'd appreciate any comments/feedback whether it's
definitely true.

Thank you!

Roman
