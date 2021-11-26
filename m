Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00A545F570
	for <lists+bpf@lfdr.de>; Fri, 26 Nov 2021 20:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbhKZTwT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Nov 2021 14:52:19 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42462 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236255AbhKZTuR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Nov 2021 14:50:17 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AQExvWL007983;
        Fri, 26 Nov 2021 11:46:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=YItVb6CmCpIcKX21zmogBLkvp4MDMPVQBKGtWccx1Cs=;
 b=Rc87QCF78ZRRZ48PbTCTOtqLzl40cuwP/RlmNsUXUkQa/VN1TMraYk7j3r1m8wpx26ZG
 q6ALEBOdn3UhuilJBK6TRMHTrmaDx0nzadCWo5uVxyYt/Ssv9f53qqX2WrLjMQdBoQjI
 Jb9jMSxBJiY68wDILMn3Uq7wwiWJxooXeYE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3ck1ts9c9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Nov 2021 11:46:51 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 26 Nov 2021 11:46:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9GzXQBF+kkLTquiJuVLfBYKcGGpHodRHJsYbosXsr7LUaNWr43XVu2AVA5yyr7oA6qMf4qP8n+M5xM1zdYnC3FAXaCfdddLZZEz8PbD5cvSnjFar7KbGk5gjxlZ9xNfWD3ld2+Ff1YLCMHDutnsgsadQL0ebT3TcddFwnSO7mBkOp8aYJT+ZPncz9cAa7Ix8o27J9pWlYEaAOtAk9kp136HeAzlpish0i0Rsm1U/SODfgzN7TgUHMH/YlqGHIuaYBUsLjwjcmqxzbh0Lrh4IrK1Ov7cfPMmduMyrDJ2h3tGnUVS0cc9A/LVVU9rk/adEcI9MfwkxmHYiA29wFqC2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YItVb6CmCpIcKX21zmogBLkvp4MDMPVQBKGtWccx1Cs=;
 b=C+r4UMYagd22TgRpmfqhqYy8gxM/0WcPNpaYhg4gjzL70jfVC9vdjqiF7W4OO07G5nGgjUc4Nx8wpo0QoncxTlr/6RylRnvxIRgNa8ZGNfLesNAVd8TRdtSd0Kn2KNKkMO+pi0bYihdSbTR9KeEwCkDRQPE5JpmgyUrn6tvUhx+tzH1Ycxa+BSe8R7c1VIAT+ER2P0qtEUpbbEGooux2jjKRSoBdz+oTqj2ziBDDfc8HoB1NwFTutJGRYwWOYdTWw8W9qIgRTGardluM/xPZ0oZZVNmNgYyBLbXwu1lFvkghkkaZoHN5y4gn/nBKNvndNRP8WtqtYtz0Ya+b+qgFFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4376.namprd15.prod.outlook.com (2603:10b6:a03:371::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Fri, 26 Nov
 2021 19:46:48 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::849b:56cf:6ec:633b]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::849b:56cf:6ec:633b%2]) with mapi id 15.20.4734.022; Fri, 26 Nov 2021
 19:46:48 +0000
Date:   Fri, 26 Nov 2021 11:46:44 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yafang Shao <laoar.shao@gmail.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rfc 0/6] Scheduler BPF
Message-ID: <YaE5pDv5OhkAC+a4@carbon.dhcp.thefacebook.com>
References: <20210915213550.3696532-1-guro@fb.com>
 <20210916162451.709260-1-guro@fb.com>
 <52EC1E80-4C89-43AD-8A59-8ACA184EAE53@gmail.com>
 <CALOAHbC0xNnqWt=og+g=DT0yRqST6cTAUvZkQ-7o8Nw8O-2J9w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbC0xNnqWt=og+g=DT0yRqST6cTAUvZkQ-7o8Nw8O-2J9w@mail.gmail.com>
X-ClientProxiedBy: MWHPR1701CA0012.namprd17.prod.outlook.com
 (2603:10b6:301:14::22) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:230d) by MWHPR1701CA0012.namprd17.prod.outlook.com (2603:10b6:301:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Fri, 26 Nov 2021 19:46:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 246dce05-a7fe-4292-e34c-08d9b1157bb2
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4376:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4376D330C9C03D3A368C6538BE639@SJ0PR15MB4376.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xWhta5TCMY+shgz5/1xsgGDlGrqDhB/TAS1eK4AxGz8ebPilVmsl2w3vNSQ96RqkA8vRW6JM2nj5XmNDSmTrlDPGcQLjX4LTY+aA6EgVU5MO5OLM5VJ1JxizKI2GFHWcXKPfJY2anaSmaCzGR31NH3xjZ2980dcsmi+DJkNwu8sHtyj2EGxm6lph21k2DlZ5nbqQ2Lva0Blf2smemNI/V9uhIWrb68dNeAuH56fnzIwRb2bnholerFbITtUJDP2Qwr+bryo5wunTNcceB+4lRZPbjpYg00ySSc/1FGD7njEc9gQoB7t8gXIyPYJIUCyVqQDolR7uC8pLW/2kgbUrOenw6h574YMqLEtI0LLUl1h1utKHANCAb1QrVDWtNgbppolsud7NO/de0uLbjO76FNVi8+5DbpnGGHfdlunUDtWtaHcfZ6WqpFYlIYyd53J/xS/vIbYePulgoTXp2Nka0mCVXcTlUVAw9VUy7QBh4NIHeZwPDlYzXJbhBeWEKMXdjQyNZAPYBZIb4RLDfAXY8y1cplbzdulimmVdNcXmobeJsK04OAO/Chs3K+jmx0ycuWxb/hBn83xveEbVnnaQNr71IxyJxmNFpiJ6x3dwC448K0QHe7X0C/H1DCDXTrRj0Bq8HBsgtREI5+0M8AxrAdGVco6XWQ8fD5OUySsTCrzZDE74u/pVRUX6pGiyBR/Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(8676002)(8936002)(66556008)(55016003)(66476007)(6666004)(9686003)(83380400001)(186003)(54906003)(86362001)(6506007)(38100700002)(508600001)(316002)(6916009)(5660300002)(2906002)(4326008)(7696005)(52116002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUpoeVI2TE9hQkVNN0k0ZFBBZEdKSFdWUCtZajREMmhwV2oyWjB0bGdZZDFY?=
 =?utf-8?B?WVFiMm9reGZ0VUVaRkFxNXdYWG9Vb1p5djZTV05teGV6d2grRVp6eXh6b1Nt?=
 =?utf-8?B?M2kxN1g5V1M4V1hNSCs3YzJGb2VobDZrenlSTS9QVHpaMktGdEUzeFdSRklN?=
 =?utf-8?B?WGpnbHAvNmxlOGRLWFVBMDF6UDh1NC9paFpPelNtbjY5OGN5WEJMMEptaXVZ?=
 =?utf-8?B?SWRjWk0zUHQ5b0xOV08wVGtKd3A2dGdUQ3UzaUwzajlrU2tXWHNjVGdUeFdO?=
 =?utf-8?B?cDR3Q3FvNkJudnhlUHM2bUx2VHUzbnFBbTlycTllcUxpWkJHUmFSUHpqa3JM?=
 =?utf-8?B?VG15SGVPVkRyS3RLbjBPNWhCS2U5NVZpQVJGcVpPMFJhcDVGVzVldVk3ZmZZ?=
 =?utf-8?B?UjBwd25vaWoxclBlcUFzVVVHY2lpVFFGWEtHN0x3ZHRObzlyemZUTldWVGZO?=
 =?utf-8?B?ME9saTdzRkhrM0dzN1NDY2E5K201cTZXN1dnYWVDOURvN3BJTVZDenZWMWVU?=
 =?utf-8?B?R3F5ZmEvZkphay90YWorQ0Fjckh0TGFaeVE4cTRKZnB4ZTZtN0dyTHFnSDdG?=
 =?utf-8?B?MXFmc21OS3BYUnJHMktGWSs2YWtlSy9Fd1NOb3l4TDU2ZlBqRCtWMmVBOE1x?=
 =?utf-8?B?NldwSmlyWEI1TlJ2YXdaVi9ILytxb1Y5MGlVK2hNcTJ0YTM3dUExaTVhOE45?=
 =?utf-8?B?RTRuKzVWeW9ubkRNT0FRNWVWaHIrb3I1MXFzRUM4YmpoTXV6QVkxUHhUNXpN?=
 =?utf-8?B?S2o0OU5ja0FyZFZHaEFUWTVPSXRpSkdOdmNmYWQ4eFJLcFhOYTZ6N08yRzdH?=
 =?utf-8?B?djVIVXBuakdjd09Ud3RpZUFHcnZSaFo4ZVpOell5RE5wT3U1QjdySHNhTGJT?=
 =?utf-8?B?V0F1WkNtM0dDbUpCSmNQQ3BWdDZ1WEZDczhPckwrSENsTnJJOTRxR0E0b01J?=
 =?utf-8?B?RzNWWUdUci9NNWRUWEFqSnBoMU5kR29QZ1lNaDhSQ0tZUndmNU1TK2poblpZ?=
 =?utf-8?B?eTZWTVZJSUFBUTBxWDZqdUZhaDJodGFlQzI1bnljQkZ2RmgrdDZybHppQnBw?=
 =?utf-8?B?Q3RpRG91cjBwT0d6cllFUWRTK0pTMlpVUTIrS0p5R21WWVoyVmVPMjBiUUYz?=
 =?utf-8?B?RGtvWmljRVp4SVZocUUyTU1IZHpvWUptZ3ZNWjVNc2l4NlRHQzkwdlFGaEJq?=
 =?utf-8?B?dmExMUNsTFFtLzRLWHMwL0tUWjIzeWdFcHZaMWJPTWQrL0RDWXlScG8rdEIw?=
 =?utf-8?B?Q0xCK0VLc0xGZFJ6eEFUS0svcU1pTTRyL1h0cmRWNVdWb1M3MHdNb2hDUHBx?=
 =?utf-8?B?cExUT0g0WkNYVzdBczM4K3Rna3FxeVlzdUtuTVZSU2NKeUoxU1dEenFjd0lC?=
 =?utf-8?B?QTZnaTYyMjc4MEd3QmxlTllycEgzSVJOWjZJZUVjcEdRbVpTcE1xdTJvM3ox?=
 =?utf-8?B?cHhJV05PQ1pSMU1ldXRLdmxtSlY0TDdVWlRLMzZIL2tTT09hOStrT3JaWXFa?=
 =?utf-8?B?b3FIS1NzUTZEOUlJdngraWJuOS8yRTdXZjBuU3FyT01ORUFsUWFsK1pRYmIv?=
 =?utf-8?B?Q0RyaEhqSDB3Nk9pWFJ1N3liNU8ySEdXMHF5RUl3MStKOUU0NjJJM3FsUnNQ?=
 =?utf-8?B?YXI3SUQ0ODdPYklObW84QTQ4L2lSQWdKUHFPUjRyenFyU3pZVTJIZk51K0pH?=
 =?utf-8?B?ZXFsS2xkSkhoeXYwTmgzUExhQnJsNjZrN2d3WGY5VXd5TmFraW85NTNkRzdt?=
 =?utf-8?B?bURMZGttbnQ1V3JobGQwWjVQbFp2MU5Lenh4c3QwTVVock5hQzRxbVhHRkJB?=
 =?utf-8?B?SnlQcXliaVNocWhFQkt4dmRITkE4SDRLcWVxNTNEeWx5ay9WYk1Ld1RmTlc4?=
 =?utf-8?B?djhoS3BTOEFuZFo2bGZBUm50Sm53ZGVxZWE0cUNldk1HL2FUMi9sTDUxOENw?=
 =?utf-8?B?VENzMmRpM1RvUEYwd3JEM1BKNm96VmJaVVBuZkZDT2ZJVXBuM3Q2aGlOZUw0?=
 =?utf-8?B?TW9ST1lXQmNXbm5RUm5URVhRc0krUmJ3R3ZHclZwTy9rWndFRFM1V3dGUkFV?=
 =?utf-8?B?anhtdjB5dmhCK3JNMytzMEdYQU1acmxUa0xuMTQ2OTlkSHQ5d3ZScE1TdWMr?=
 =?utf-8?Q?sr9MvN6bArQYoqELtLdxphpUr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 246dce05-a7fe-4292-e34c-08d9b1157bb2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 19:46:47.9565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ud9YfEQ40LlT2R7w8aW+d8iClnXZCXEo82YdKnnmIK3Sf+u4eIJ5zwUpD2Xb45Un
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4376
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: Hq0bApjBp9EHVXIiRfzrPkXg6eoc6QWx
X-Proofpoint-ORIG-GUID: Hq0bApjBp9EHVXIiRfzrPkXg6eoc6QWx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-26_06,2021-11-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111260114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 25, 2021 at 02:00:04PM +0800, Yafang Shao wrote:
> Hi Roman,

Hi Yafang!

> 
> Scheduler BPF is a great idea.
> Thanks for the work.

Thanks!

> 
> Scheduler BPF won’t be a small feature,  I think we’d better give a
> summary of possible hooks it may add first.
> We must have a *basic rule* to control what it will tend to be to
> avoid adding BPF hooks here and there.
> I haven’t found a clear rule yet, but maybe we can learn it from
> netfilter, which has 5 basic hooks.
> Regarding the scheduler BPF hooks, some possible basic hooks may be:
>   - Hook for Enqueue
>   - Hook for Dequeue
>   - Hook for Put Prev Task
>    - Hook for Set Next Task

I think it depends on what we want to achieve. There are several options:
we might aim to implement the whole scheduler logic in bpf, we might aim
to do some adjustments to the existing scheduler behavior or a mix of those
approaches.

Bpf as now is now is not capable enough to implement a new scheduler class
without a substantial amount of new c code (in form of helpers, maybe custom
maps, some verifier changes etc). In particular, it's a challenging to
provide strong safety guarantees: any scheduler bpf program loaded shouldn't
crash or deadlock the system (otherwise bpf isn't any better than a kernel
module). Also performance margins are quite tight.

I'm not saying that providing such generic hooks is impossible or useless,
but it requires a lot of changes and support code and I'm not sure that we have
a good justification for them right now.

I think instead we might want to see bpf hooks as a better form of (sysctl)
tunables, which are more flexible (e.g. can be used for specific processes,
cgroups, cpus, being enabled depending on load, weather, etc) and do not create
an ABI (so are easier to maintain).

> 
> 
> > An example of an userspace part, which loads some simple hooks is available
> > here [3]. It's very simple, provided only to simplify playing with the provided
> > kernel patches.
> >
> 
> You’d better add this userspace code into samples/bpf/.

I thought samples/bpf was considered deprecated (in favor to selftests/bpf/),
but I'm gonna check with bpf maintainers. Thanks for the idea!
