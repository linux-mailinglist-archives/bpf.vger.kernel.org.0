Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3314B42FC3B
	for <lists+bpf@lfdr.de>; Fri, 15 Oct 2021 21:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbhJOTh1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Oct 2021 15:37:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48786 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235221AbhJOTh1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 Oct 2021 15:37:27 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19FJXevL013791;
        Fri, 15 Oct 2021 12:35:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=BI3oB2L8w4Cux7jwApgq9PcEj8A0EAo00+d+5n421OA=;
 b=c+psBq0G0xJUCkrC/vc6w1SBPYhyCYqiW8DVQSSF/XyJfRd4u2miH+wsX0P2N21jGtFL
 15GPsNwU/fLkutnTVhfNpx8A04f0QuceWyT9E/+ae3OpvJY56jqFLA3PTQ5jratnlaAj
 DqTQFQ/s/BrK7W1zq7LLFMOzpX+YEgjOEuc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bqf2prdpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Oct 2021 12:35:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 15 Oct 2021 12:30:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbALPnfRfhELO0QVYSG0kLo6BXV+NTEkizCKh61R/oPKIIpVFpIHIdwXGv0lOncGZNZKXCIPiCrjocS78thzdHum6PZeUh0tLRp+X9HgI6UXVgQzotJLR9kKNqRizhA0BSjUt1W3MFncIeL15Ffk+z0nO7po7YW4sE3/Q2gDUy657fInyocAJKLJWKtEhPAGtg9jDBXRc7arB7bC0GZD7kmIz4fMpXreKXRS/FQ3zfGdCyBtlRB8/M8rbjy7mKr4Qk0MZw9RsK+NRfN0LAkVYdVg2gE3QUKQ2qoZ5UQZZUEHGP1b9RiJz0j57mtFDtz4V4QGkVDzfwlDA4+u5SSI7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BI3oB2L8w4Cux7jwApgq9PcEj8A0EAo00+d+5n421OA=;
 b=jGfXnlpXDR0Gn1fO2YdoxuT7rdvoIDq+Ag2v4yOAyvzqo72xXYpUGGblIZ8kCptXtaTda8Ejyts7B+pspmWWMQmmQfSIoRPuuTvINQ19tE24vqVOmBixans7PvocUu8cry9q/tKqkgGCgpl8rfCJepKyPcgCBzPosdvRDQlgXCtwnSgQItzK7MORgr1NnZImQAK0V0lruO7NyUb9/9YgxEJzYjftOjjv0dtdnNnJ41HF952kt7SK3jBfm3j3KiXj0kpjpD0LOwobL7PtsPrihutQ0HTQXMH7/GW7kN2/Qd5QNvcVlT6bU9NZfgY1jqwZyxvhNXbvQZc3o05ji1SWrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA1PR15MB4822.namprd15.prod.outlook.com (2603:10b6:806:1e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 15 Oct
 2021 19:30:13 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160%8]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 19:30:13 +0000
Date:   Fri, 15 Oct 2021 12:30:10 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Hengqi Chen <hengqi.chen@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, <alan.maguire@oracle.com>
Subject: Re: BUG: Ksnoop tool failed to pass the BPF verifier with recent
 kernel changes
Message-ID: <20211015193010.22frp6eat3wz54hq@kafai-mbp.dhcp.thefacebook.com>
References: <800ce502-8f63-8712-7ed4-d3124a5fd6fb@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <800ce502-8f63-8712-7ed4-d3124a5fd6fb@gmail.com>
X-ClientProxiedBy: MW4P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::32) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:3f3b) by MW4P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 19:30:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4b63dd2-215a-4f52-460d-08d9901235d0
X-MS-TrafficTypeDiagnostic: SA1PR15MB4822:
X-Microsoft-Antispam-PRVS: <SA1PR15MB48220422B3B34B95BE421394D5B99@SA1PR15MB4822.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:288;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EiTdyGR3Wtndt1jBI3E0Oc5HmXpTfiB3SShxlH9Nl5WsQVJ+iq5RcQFcltsx8CJGhxm+kmmGTVZ8q+ES4x9GnfiDjAeswxI6QqaFJylZ5NA7r3MkrFA0lqzH0hu5ArwkCfwD1+VUZ44to8UMeSm4CRZxYmeMF9Oqo6Yz4S5SZu205wAZl6KbcZIjOgIbizIf8XCdJG811PJdd4nwyTXw7L5Ifylu/jSSotCrZ0haZ/XpF7v72DPvqfvbD3vAHb6uevxAmuPHpTJdAZ6xdwcZ3XzP7mGlxBoicR9cJtBwdUT3zoQGGrjDNkq3mScraQZPWUXvYvJmYvHySLNVa5VRYzq6EgSvqrLyNcyrMRcWQ+UKUmGBFvIZ1zZbWYfRy18lkktFukJf9g/xUYAlaR756N4IQI5QdNZ/FH/31pVaOKsMJkD9w98kMFHJUO61ayfyQmEhUiLWJ8snGk94l1ih0FD1L4/8wQsNxaeribFzz2o0nTS8GWw9RaY1ZRy3VrzlOGORlEbTHo3A0HchdiOxpfdI8++zlsUDI1AFzZGwMmH7BFnfAQo82QtR+vHvXDsHEZ/HxeeukTS81evay1+3YyrUyPue5PjuQRtW5VdplKREmGtiQWryIxvV76xa5QQBz7XlmgzQztgAu/+W3YqZGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(8936002)(38100700002)(6916009)(86362001)(66556008)(8676002)(66476007)(4326008)(6506007)(186003)(52116002)(7696005)(4744005)(9686003)(55016002)(2906002)(316002)(83380400001)(5660300002)(508600001)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9w9juLOJlAyfYmZ8oRfGxEFONISRUhPZ2LHb/mru4KHyN48dRAGMYNWbKtwR?=
 =?us-ascii?Q?0u2st5Ln1czGkAa5Bqh9MdLdQQa/fXGzI2bx9Msddtgiz+ncNQ9lLsvwLYXi?=
 =?us-ascii?Q?nz9/B0sHEQ+Nfj6cXJBOiYXPUYz2KkJLhsO+ffP7vkrVwui52F3PRLBHJBxc?=
 =?us-ascii?Q?c9ixkwrE+QGQKohQ8DaAk/Z4Okkt/n1lsyl7Ba0S3tU+wN19vJ5GNyXbcWeX?=
 =?us-ascii?Q?MVXEktb73t3o/Tkdg8+erwqohlgYZVgPHB3NyE7p3lIUW1d0Ec4boOezZ6IL?=
 =?us-ascii?Q?zg28tRw4ac62ng7Vk5kbZiBtKDeZBbneDVz8i8ST70e5dPlChe0lAuHXNiV7?=
 =?us-ascii?Q?wgGCtKTtKNXTzsCTIig1sQSV5P9bSm9YFSdvGFzgDrRAJtx/GGsOkW6kIUzR?=
 =?us-ascii?Q?xDzM103VJiLJezeP8uJUpSvCxmA66n+eJA5tut82kXxUhYdvBrpgBozvaT4i?=
 =?us-ascii?Q?2T+Ty4BOxRq3ZKpgJHyAhjPx91orO8RTChmGwAOajBTB2mOW2MauRtXDHaQy?=
 =?us-ascii?Q?GheJoZcg6ygsoWpjpwovdDYhkS5aT0DcYhey6Bs9L5RXvGJbPoicSEX2k7bC?=
 =?us-ascii?Q?1OYlWM+9A5lGupHwVCQOroO24yYjterg3UvQHbyr+vLbCTQ/KJo/NweV7b1R?=
 =?us-ascii?Q?dkWWFhnKdlsrwT5CplwcS+DgR69s2KmwnJBd0gIHEBG23U+/NBQPrJau4f0A?=
 =?us-ascii?Q?RQpudjurACfxwA7O83T3pWRw2CfqDSXF5IPqGW6KiT8GS3YSzS4CMK49KAor?=
 =?us-ascii?Q?5XoSGclZ6tPjuu6SOpkG6Wa/B/WD4FbT8tWqJ17SfPOydU2SJ8+lxPVLa6t4?=
 =?us-ascii?Q?Ao6cUErn4AW+KhbzkmD5grPKI0CSvu9TEKsYTSOZhu3h7KuZit23GLOlgSUE?=
 =?us-ascii?Q?XEuhyeO4OOnMfbWdkiBXSeS8KkAb6t/gfDDvWC2BVpvBj6UxsXZqqpmlw0v8?=
 =?us-ascii?Q?A3MOprXRd99V83Z6QKLmFicNxsbrl+vdW4HTjSMUGpkO59LUQYz5ZkYpvLT/?=
 =?us-ascii?Q?r5ml99um9qyQXIoGfPQE0w5e/mlpUi0xbh393CiaVoTF2pSdW5hg1VulMndr?=
 =?us-ascii?Q?QIG0prKoiEWFkXxanDFK8YFA2mM1wrQwR5ndi8OpjKK4DOXlZFGqcRAGHGUU?=
 =?us-ascii?Q?xLHLJKQVdMhewMezu79oKJOI1wVaYTJkSpc+3JSwMh+jOmDGElSpavrcCM07?=
 =?us-ascii?Q?Nwikpv4sZGPUcb3HCqg0PnD27w/ULvro4Faga96So79hIXP44h9jjJyL/0PR?=
 =?us-ascii?Q?Ja4JAMrqPw7tpyPf5xIb8iqmjOFagBUFpubqEILOxyHAHvq2WNJN7Q7Wk+Yh?=
 =?us-ascii?Q?Wzd3ycKDWjlGKnWbcxEl+HPqJ+wNAd7TWOiXFEq8z75TQA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b63dd2-215a-4f52-460d-08d9901235d0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 19:30:13.7403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/G+BlCNGPyoOp9QTJ0JRzaiVNeDkhwvIVG27jnsSyP9gPYK1IKAgFOi37kfudlr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4822
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: ezyNhyM3_vKOhPB475GP8-xS2e3-U7Hk
X-Proofpoint-GUID: ezyNhyM3_vKOhPB475GP8-xS2e3-U7Hk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-15_06,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 mlxlogscore=960 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110150119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 14, 2021 at 12:35:42AM +0800, Hengqi Chen wrote:
> Hi, BPF community,
> 
> 
> I would like to report a possible bug in bpf-next,
> hope I don't make any stupid mistake. Here is the details:
> 
> I have two VMs:
> 
> One has the kernel built against the following commit:
> 
> 0693b27644f04852e46f7f034e3143992b658869 (bpf-next)
> 
> The ksnoop tool (from BCC repo) works well on this VM.
> 
> 
> Another has the kernel built against the following commit:
> 
> 5319255b8df9271474bc9027cabf82253934f28d (bpf-next)
> 
> On this VM, the ksnoop tool failed with the following message:
I see the error in both mentioned bpf-next commits above.
I use the latest llvm and bcc from github.

Can you confirm which llvm version (or llvm git commit) you are using
in both the good and the bad case?
