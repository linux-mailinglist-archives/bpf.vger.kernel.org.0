Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03092407191
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 21:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbhIJTB0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 15:01:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35516 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230513AbhIJTBW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Sep 2021 15:01:22 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18AIwEPj014036;
        Fri, 10 Sep 2021 12:00:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=P9BhS20MQ5YEBx0OcmmChZLCRp+fuPXGfewf/dbAw9M=;
 b=OrRKJD8ECeWTIAGFSx6bUSPZGwROVVKZtGNm3M3jrwrzm4xdY69x+bzFAbzeAZO9pS2x
 mMxIEmj2dBYFPWZS0sZltUFYYJlhydm+vVqz9IIsgXPEHG4TL1qrHIoRDAJ4+qg+IfeR
 FZUf5JQ6mv2nu1jSje6zJWunNOUcXXu83sA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3aytffxvs9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 12:00:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 10 Sep 2021 12:00:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJeoFC1zPZ6tQQYou24UvttmS90CTpQLo+r++3k1Obh83xldnRrgebZ5cqghpNGI0K8moO7TzWhbe06HDmw4nWADxDqCrcuWzDQuHGkaX9m7iFNghWJSp4b9+gu/26judAgg9qA9hSwLy9zShWCh2rJBBoYCnrxAZvwSRKCHhHPfFF0itH+YIhugYK2fewA9wIx9qCk21ynT1JYAB7YpQ/QtFlLzpSgRZ0qwEsg3Fp82TbtkVNQvj0KCb5GyGpsIXDrKBzpKeorf8mBiw6OLWimGC8ECQ1zFOXA5qkfCrg2QERp3n83LtI4kWt0AdqdM74wPZE8w0S0jYlv6ZDkL1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=P9BhS20MQ5YEBx0OcmmChZLCRp+fuPXGfewf/dbAw9M=;
 b=Tcc+KPtVSK6u7V9Fu/rQgKKYPOvSDhEhVG8sPyaA8oiLAnRn818q56YT3Sj8oDbvPtIjhDW/gmDx04v+OmyC3hXg623j/LbMDsUH+J068mzvJw+KZdW87iKZfpCVgRjVANQxx69I1GX/3m1UhxV8U2hLoy4QcgAE0RgtpbPLvS8CX8kxnhYDHyS9/iGdb064u792DT6XPHH5CxqCtXEKZEKde1bi2m3aNfIz+BqIisNMIVyQcrPfYKz8MVKq1ey2m5NyLZE0vc9kiTBaK+btM/OnAcARwt9HAAycPCLi6M8y3JT4W537Zwr/W0djP+AG+kIwemragNOOaqnOzv3yrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5094.namprd15.prod.outlook.com (2603:10b6:806:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 19:00:08 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%8]) with mapi id 15.20.4500.018; Fri, 10 Sep 2021
 19:00:08 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "Andrii Nakryiko" <andrii@kernel.org>
Subject: Re: [PATCH v6 bpf-next 1/3] perf: enable branch record for software
 events
Thread-Topic: [PATCH v6 bpf-next 1/3] perf: enable branch record for software
 events
Thread-Index: AQHXpCby8uzfjDX52kWXwjwsop4wLqudGFYAgAA1/ICAAExtgIAAA5iAgAACr4CAAALQgA==
Date:   Fri, 10 Sep 2021 19:00:08 +0000
Message-ID: <6830FC62-995A-4282-BD30-76E2506ED993@fb.com>
References: <20210907202802.3675104-1-songliubraving@fb.com>
 <20210907202802.3675104-2-songliubraving@fb.com>
 <YTs2MpaI7iofckJI@hirez.programming.kicks-ass.net>
 <YTtjeyfJXXiDielu@hirez.programming.kicks-ass.net>
 <96445733-055E-41E3-986B-5E1DC04ADEFA@fb.com>
 <20210910184027.GQ4323@worktop.programming.kicks-ass.net>
 <20210910185003.GC5106@worktop.programming.kicks-ass.net>
In-Reply-To: <20210910185003.GC5106@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83e7217b-5fd3-47ae-1dd4-08d9748d3552
x-ms-traffictypediagnostic: SA1PR15MB5094:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB50949B283661D660008BBA29B3D69@SA1PR15MB5094.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eZNDTFpmbKDQB7ss6syeO3YasLEtViSfBEenhdujH0IQCf/DlnE9e2+lBzjdrxqbpsjcqNJQvqRRxttq6m6Dl1TCinq6xBJMjgo5Y4E6Dea+tbrPzE2r8nikww+9p4Hr3gXpf690OuJmE+9BdMPWoTSOtL5tBOFv+lWueJsi48MFrwSE2XN6varl5ko5oK0zRgcIC0yZnktbQR+/92/Aik4Ov7Kdd5q4M43ujBhyjw8M4181sTMZeglDt343Age+rZhTvGrCi3/lr3T47G/MW7UDIzhLRjEp4iQVGn/CY87qngdTbRuTdnhFYmnfiZGB33JO9EHW/m6hEk7ICyFXv12z1K5KA5n+a2j+wzVsTAXnjTt0Fd9q5BD6AnrLW06umOzxIiqjNkRGZjPnMKgv3Jt1H/hpf+I/gMToMmcECTyWkbfpWbVaKJXBZRvgne2IL3dfaVBecU5839FVH/zeIdr00vZzqYwFWt5g4yFjKy13X/u+kVJ1/pcnhqA/yAbcwdbEw+PilfFU9wAyqNfjvCFzJs6UYNUqNH7Eafs/lv0E0BXmhTli8gyszoM8IiRSCVK9dgShNGaJKa0rc0yohk9h6aheQK3UBUPeZ/X1IyjKJmnPUhvmV0cZnO8ZNkribmwBuOD7ITOZEsHjhEbPvj1FJK5m1oLxKlZOMGA6P0MPCQiirNM5XuzhIt4ONLHGJj6V1GDx0hBS7FJflAV7ZOTf/BpNz5yBm2qsosREM3aTAiPyMBqH2QmRfe7FIFQR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(4326008)(38100700002)(6916009)(2616005)(86362001)(122000001)(8936002)(38070700005)(6486002)(8676002)(36756003)(83380400001)(6506007)(91956017)(76116006)(508600001)(64756008)(66476007)(66446008)(66556008)(66946007)(54906003)(53546011)(5660300002)(2906002)(316002)(33656002)(186003)(71200400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LR6hr1U5gHJciPhCVJ7GKXRP6T1xJLVW5aGyMLnLpFCKZ9QGhcM9oMKIshth?=
 =?us-ascii?Q?/TDIM1IJNHgo5W88GczzHczPpIH2fxTQsYOhTTSG5OJtcAI/Jx5CPfwsjp1f?=
 =?us-ascii?Q?YNtSS1EznEG3rQd1XYbVOqdzvSM7cfNRhWZ41Q0VBvkUHsi3bfLC0/7f10jA?=
 =?us-ascii?Q?giamKIrZA9lgWNFKryhjCdjdkmPBVFM/14jVJl+fTnFa6EE1DSHZ0KtQNxaX?=
 =?us-ascii?Q?uqYS9K+YHve2Hd1F4IStlNSU0KyMuHAGKzmY0myWY7S0PFETLu0tyHKYeHQK?=
 =?us-ascii?Q?OKr2sYfcOz1ys1kVQee6onouLxC6jR9ppBxqGGcehd5RcDB7g82WI2sgijkc?=
 =?us-ascii?Q?5xbyVh+CWhP8CbcgFsqXSfEbgfG2aiFT2bZWXNk1ukieoh+2uRU8YDN/6HNG?=
 =?us-ascii?Q?j+afVYlfyXZM10b+lMQNjcRIGA7/zQH0c3yl07IW+oxYlr8a5xL8B0AoNEqH?=
 =?us-ascii?Q?wb8lNJW/NygEVMAV2/qUMH91kj/HenHKoowVjAVxzCktrRxwL6KRsOObYGYz?=
 =?us-ascii?Q?71gGa+YE1UHJvTtYSpgJPAEqvX1vyiGc9QF9QT7OSairEub4EhP4vVJp9Bxp?=
 =?us-ascii?Q?r0hmAzPdlFYpYeHtfKeQN14lHrGzMXbS92aW2nzcGsnVYvq6H8OlRX0kixBI?=
 =?us-ascii?Q?Vpeh5b8PEw6iuq+CWL01fCIqJX3J1uO4qpREay/3m39luRRTL0LB1O5c7cGF?=
 =?us-ascii?Q?koFkS1Jl/cU9eW2i5krVV8fhnWGhPiVDD9bgqEKLHVXZik1oFIME1ogPJavC?=
 =?us-ascii?Q?hNj4SyluehkuD8YVrSJ+yV3RnDR9shwRtqI8EO7z4JrDZbn3q2yHQWqFM0IT?=
 =?us-ascii?Q?kCbzWyH5I40pT1N2FiLAjidfb1/p9tjCFNJXmH93DIteBR28f96DrgsghiCt?=
 =?us-ascii?Q?msLHJv5lrhLqoz49ytmrdWGzJb2lYr9/Pp7vR1rBD0qVY+Zbkpi8BSumE16p?=
 =?us-ascii?Q?7vg881L5NqxGlzO+WCCoSbFZnJ+BfeQ5tTwZfQwyRkzJyMxw1GcBydBKtY84?=
 =?us-ascii?Q?eb3cqIr2uRunrxetP9VPp5calRmX7gcTWpKvYHjKbujkNu+PobZM9GYnY7V7?=
 =?us-ascii?Q?mNQlB1jipZn36AY0fStVoRpvUodu9lJbRC9ql7BwkA9u8IalPOGgJbExmdOq?=
 =?us-ascii?Q?2QkDmHMaO6VY1lXOAQScM/PnO84mBX2t04tsvtjhWIygzbsOIKxDpEh/lI2X?=
 =?us-ascii?Q?InKtAxqvXOXkrli6L5azRUnPFcLUflPo+Jd6pRduyJKGYIm9lXBB/0qP9uiS?=
 =?us-ascii?Q?ftiVnb70ZLeF4l9Xk5937k/X1d1N5q24yPM7NyjmWfFucf2dVHNLuskF+BQc?=
 =?us-ascii?Q?3f8Tusvq4lWY9ls4sk+WWsnAziPlQqLtQ3K28OJv/2esO27v58NaK5iifzLI?=
 =?us-ascii?Q?QyzgFqk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C7A405EE9611ED4393BA497A00359561@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e7217b-5fd3-47ae-1dd4-08d9748d3552
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2021 19:00:08.2509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlGNuRht8XBbzjHS2Yrgf2y49BHXPcoVUG0/ai1xSYpx8hVKwaO/bt8dC3hGgWape+eaKxOTVNFgQqxvIMeU3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5094
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: XjPg5QZMxurXopPWZJXehCp97jPDRB4q
X-Proofpoint-ORIG-GUID: XjPg5QZMxurXopPWZJXehCp97jPDRB4q
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-10_07:2021-09-09,2021-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 spamscore=0
 mlxlogscore=736 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109100110
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Sep 10, 2021, at 11:50 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Fri, Sep 10, 2021 at 08:40:27PM +0200, Peter Zijlstra wrote:
>> On Fri, Sep 10, 2021 at 06:27:36PM +0000, Song Liu wrote:
>> 
>>> This works great and saves 3 entries! We have the following now:
>> 
>> Yay!
>> 
>>> ID: 0 from bpf_get_branch_snapshot+18 to intel_pmu_snapshot_branch_stack+0
>> 
>> is unavoidable, we need to end up in intel_pmu_snapshot_branch_stack()
>> eventually.
>> 
>>> ID: 1 from __brk_limit+477143934 to bpf_get_branch_snapshot+0
>> 
>> could be elided by having the JIT emit the call to
>> intel_pmu_snapshot_branch_stack directly, instead of laundering it
>> through that helper I suppose.
>> 
>>> ID: 2 from __brk_limit+477192263 to __brk_limit+477143880  # trampoline 
>>> ID: 3 from __bpf_prog_enter+34 to __brk_limit+477192251
>> 
>> -ENOCLUE
>> 
>>> ID: 4 from migrate_disable+60 to __bpf_prog_enter+9
>>> ID: 5 from __bpf_prog_enter+4 to migrate_disable+0
>> 
>> I suppose we can reduce that to a single branch if we inline
>> migrate_disable() here, that thing unfortunately needs one branch
>> itself.
> 
> Oooh, since we put local_irq_save/restore() in
> intel_pmu_snapshot_branch_stack(), we no longer need to be after
> migrate_disable(). You could go back to placing it earlier!

Hmm.. not really. We call migrate_disable() before entering the BPF program. 
And the helper calls snapshot_branch_stack() inside the BPF program. To move
it to before migrate_disable(), we will have to add a "whether to snapshot
branch stack" check before entering the BPF program. This check, while is
cheap, is added to all BPF programs on this hook, even when the program does 
not use snapshot at all. So we would rather keep all logic inside the helper, 
and not touch the common path. 

Thanks,
Song





