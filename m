Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA2B3F0E72
	for <lists+bpf@lfdr.de>; Thu, 19 Aug 2021 01:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhHRXBs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Aug 2021 19:01:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6038 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229478AbhHRXBr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Aug 2021 19:01:47 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17IMtZg1030233;
        Wed, 18 Aug 2021 16:00:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=OhAWsZsghF35Q+VXCPliTbP2JOLvD9IexyCeZHQXpm8=;
 b=Aix8Oyf4SvEoP1vOqYGvfRjXNovKnhCY1FpPrNdGInt9BCFwRc1Ua2B/l/l2pbLlJZWu
 wXSixzvaT/438oJ7uOVaF+JgwBEW8Dfz6vxp5BdwCiuQNYOHSg3n97JmBovP+DXsIKpM
 6zQLs8gaqsrzKWokYo6qlOpmDn3lFt7Li00= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3agrfeeehe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 18 Aug 2021 16:00:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 18 Aug 2021 16:00:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5V/pGw8oHG54hgrq1ioT9zGI7rxWHqGj+1uVB0VJk/OWj0jKrTumhIXHmxW8f1Wm4nzbbdaAMHzTg0+oO4hW5/JCAb7mxAQtldYvEQ9EGkLnms8sxwNVccQFUm8r143NSm2exIC0MuyJz2xMVzI4Gl2cFKV+SMHqtVXGoVQtXPpyQx33SeW9fEqxgkgozJYJzFxu4LQRclI2URxoggadqCRhJPI3KKGV7umEfxQxpq+R4BB9d5MOd9NrmJuBjQqUmLjOTv6uV9gUQc0gG3IIcu2eJpheQv3L52IIROxYrPmMIrbFoTqmtnFAx0++OvTfwB+YTHXciWSny0Gr3zrLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhAWsZsghF35Q+VXCPliTbP2JOLvD9IexyCeZHQXpm8=;
 b=ePq6Q+H6VduWf0RM9zQSqgBQgcyFhygYU4C7N9ljCaf1r1GBSYLgBDhG57TOszB00gjkJ3cUx/MQ5dgws+bmzT0IKYEyL5g7GBiiqdq5GhX2Y2WftUov9lRQbAynYmwMPvs1XJUNbokIORN1TyiuE8mnLx6HbzC7+BnDTzs3LXr3SXyl4zu7vuKmC8m8kaF9uWVNoojKMTFRYBcpm9MpPVZmEYgcoZvfv9d9QalNra6SY4hlxg+qHrxtLupiVHYTH4JGsbqdDdDmR/TA6WL/9xQPsxk3RXXI/nmyXQHQ6R41Nld7RswswWjxBW8l0Tw5bvLE3ogwHv+mOVvAFeYefw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: iogearbox.net; dkim=none (message not signed)
 header.d=none;iogearbox.net; dmarc=none action=none header.from=fb.com;
Received: from SJ0PR15MB4679.namprd15.prod.outlook.com (2603:10b6:a03:37c::6)
 by BY3PR15MB4804.namprd15.prod.outlook.com (2603:10b6:a03:3b7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Wed, 18 Aug
 2021 23:00:56 +0000
Received: from SJ0PR15MB4679.namprd15.prod.outlook.com
 ([fe80::2dad:e68a:6d99:e95]) by SJ0PR15MB4679.namprd15.prod.outlook.com
 ([fe80::2dad:e68a:6d99:e95%7]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 23:00:56 +0000
Date:   Wed, 18 Aug 2021 16:00:54 -0700
From:   Andrey Ignatov <rdna@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andriin@fb.com>,
        <dan.carpenter@oracle.com>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf] bpf: Fix possible out of bound write in narrow load
 handling
Message-ID: <YR2RJmVWTnpBFkm/@rdna-mbp.dhcp.thefacebook.com>
References: <20210818221143.1004463-1-rdna@fb.com>
 <4589201d-48ea-d3ef-d0cf-7dc8cc23d108@iogearbox.net>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <4589201d-48ea-d3ef-d0cf-7dc8cc23d108@iogearbox.net>
X-ClientProxiedBy: BYAPR07CA0074.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::15) To SJ0PR15MB4679.namprd15.prod.outlook.com
 (2603:10b6:a03:37c::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2620:10d:c090:400::5:f982) by BYAPR07CA0074.namprd07.prod.outlook.com (2603:10b6:a03:12b::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 23:00:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93f449d4-c37a-4cce-9b2b-08d9629c0914
X-MS-TrafficTypeDiagnostic: BY3PR15MB4804:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY3PR15MB48040A71CACFBBF7085413C7A8FF9@BY3PR15MB4804.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XE7FNzTqbJLWA2rzt+yZWHCznV2SNbw5Ph3FrLu2+9UEwmNtj9/XpeyBc6Acb853IdlTKNoRa3DjAcjrremS2RDiskkundMMa2yKI0hTXt7g0LCOIQDZqpAyK0O/TJWb1e0bajpw/4OB3o7uzM2JMUKRvgrQEx+6MsKgbn/O0WpV6E4eb/wG1doL7pOwU0rdp/9AC0w1B5FDUpibVlDgczEPVrA2d9UyLn3DTJSWMItlnHoVCfWrh9x/nkKY3kIOS3puTOiWEOZdeQnhDcVXWIsOsFpCpNkwwou73RnCMm4QLSum173Bcy69w76YHDxZsvKHAMaUKAP6M+M4/X62te9I1X8Eeb0eFATbaJtV181ocTbMyFnZacwKRckCK+v/qDnw6ZoICvc7CitBviQ+3CORUWeMroshHIgtOrTDWaqRokAmhoP8ysJFzHxYL5AWGiQVJJ8DCh7vLAnb49Klw9AKFqehXxUjnhR4vwm/sc6SXDP49FTO6O9ZLNGTzUO/xBjxlWzv7QSbdMfOQFNS4PlDM4PnO3HFsjkW3IYsoW/OgiqBNz2rtpFFFNmpGIn0Km9XesJAeiyk9+j6KiQSyrwCCCDvNjzlWW4w7J3zl1q5QIrZr4DOG+H3TZ/up5bgaDgM+KAhsCGxMsSPkiAxGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4679.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(316002)(5660300002)(186003)(53546011)(9686003)(38100700002)(66476007)(66946007)(2906002)(83380400001)(86362001)(66556008)(8676002)(508600001)(52116002)(8936002)(6496006)(6486002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGRHQllib1VEZWJwbXlaaEVmclhiaFdDL0J1WExhU25pZi9NU2V5RUhnMlF0?=
 =?utf-8?B?RlRSMmdCclc3N1ZxcDc2KzJTWHdTYWJzVVg1d2E2OHI5dVJnVkFia040TDhH?=
 =?utf-8?B?Sk9Pb1VSTS9MTHRIdytwMG5WaHo2TWU0M2pPVTAzQVpNSDkzQWVlOUtsTXJ0?=
 =?utf-8?B?SUVUZHJYQWZUMVlYdFYzNnRic2lVQmd1M0l4V2tkWWlCQzgvK3N6bThSWlky?=
 =?utf-8?B?cVR2TUMzWXhpOTVEUloxS3JpbHJSZjNUMzZjVmVMdlRuak5sT3NxekhZT0Vm?=
 =?utf-8?B?ZStwUkRwVDZ1cXRTeHhjWE9WdTV4bXlxSTNtdTFOT2c3cEdEcEV0MkkwbEN6?=
 =?utf-8?B?b0NzV0N6RkFVUzBJU29vbUxjMWoxUUQyOHpWY2xCdUxubHgvTFBoNldxdEtQ?=
 =?utf-8?B?bGVQVHRHTnNGTHRncW9Xc3paNi9kZ2NzNlluY0dnQmd0Q1BRTU5IbFRxbWo0?=
 =?utf-8?B?MW1VMGVSMzBQQmdFKzQ0VTlod29yNWx2Y0xvOG52djVzYzFHM0tsVUdRS2NK?=
 =?utf-8?B?OW0ycXQvTEY5WGJoNFlscTJ3S20xMFhBZDBwQVgrSmF5bHNCME5vbFZseXBG?=
 =?utf-8?B?NEN5OGFZLzFrWUZ0MXVlM2NJM2w3UHh2NTVKcDNZZTRIV1Nhck14TkZCL1g0?=
 =?utf-8?B?R2xlK1JPaVJrVDFhNTRlRENQODlCNWRxaUxJZnkzdjFZMFpkMzhMZHdEbDV4?=
 =?utf-8?B?b3lCQitUWHBYT3QxRHp3OGg4WEttanRMamE5eCtRNzBUV2hXYlBWN2Q4Vm4x?=
 =?utf-8?B?MVdlTlZxUEl3NVBkRlExOGZ1T0ZNdWlsNXZYeTFVb0Q2YWQ0bXNWaVg0UENY?=
 =?utf-8?B?b2ttbDc0OHFZdTQ0UHdGcG1ubktOK01TdUduNGd4cGNrZTROYmdGSUEzK2xx?=
 =?utf-8?B?MGlubnNzalo1TW04d3dTVnkyaDc0NkpyUUEvYXBWUTkyMGdSdng3VE5iRVB0?=
 =?utf-8?B?SE9DSkZhVUlxN1VjWTJYb1dRQmg5VFR1dEtCR3lTd2FIdTVRUWN5MEF3OUs2?=
 =?utf-8?B?WkNRck1PeWdCR3Roemo2WnhXVHJlMzFGSEs5Tks3Y1VPaUZIWDcrZ3VxdHN5?=
 =?utf-8?B?Z0VsVU5BSERHL2Vma1hZSWJjajduTWRORzQ5V0VzQUYwRFFmMDRQa050ZzBx?=
 =?utf-8?B?RmM1VjNuRjJXMjVnMzcxbGd4dnlzYlc1UmhMbHRhcGVQSmhzMmNBbUJiUm5T?=
 =?utf-8?B?OGZrRXM2Wm8rWlg3dVh0cUh6aEFxdGE4Q2xBdk84YVk5OUxucTZFbTE1dnhp?=
 =?utf-8?B?Y09VNUt4OTlOTWtYa1ZCc0M4eGNqTzZOTGJ3VXhTbG5XaFJNSXgxUmlrYWxM?=
 =?utf-8?B?bkRuZXFSUFZlaHFSWS9TQUdZMThwQlB6bGRTMzRKd1dicnBHQ2w3WFFZc1E4?=
 =?utf-8?B?dUFsR200YWNnNUdsR0Y4TFdTc1BORnVKQmtXOFZoSndTUnl0cWI5SmVEb0Jq?=
 =?utf-8?B?ZlExY1VEMDJXdmFWai80VHlrNEh5RHFkZFBLeERlbTdQaFJ4NHJ0MlQ3YnpI?=
 =?utf-8?B?S1NFT1dwcitUUGRnREV4TGdYRXBad241U0QxZmFEZDd5T0N6RjBnYndlUGVP?=
 =?utf-8?B?SkMrYjhLN2JzdjcyK2c3c0RJVlF0R2Vzc1ZmOHRMeFdUNjl1K045Y2hVUG5U?=
 =?utf-8?B?UUxBb2NOZVA5L0pMMXJiSHlYUjd6T29BbjBxMUltVE12bXN2a0QxMFJBRFRu?=
 =?utf-8?B?bWJNblh0K2xVQzFXS1F5UzhiYnVQSXljaStVeDh0cml1djY5K0lqS3ZtRVNT?=
 =?utf-8?B?ZmhqeGtVelR4UHhIVFVrNkNsVmk3RlBGRjB4bWtRdlcvc3Z1RWx5ajRDRWNw?=
 =?utf-8?B?ZTN3ck9yTTNFNk50MWRhQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f449d4-c37a-4cce-9b2b-08d9629c0914
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4679.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 23:00:55.8830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FYd9k8GgI3MKs/ZkN5MDif+DhgGzwTO25ZcuMjjBVHndsh74AorPoLxiAeOYoqJq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4804
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: qH0cMlVFr2z2e0jNe_CzNdmNTD4G_HHE
X-Proofpoint-ORIG-GUID: qH0cMlVFr2z2e0jNe_CzNdmNTD4G_HHE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-18_08:2021-08-17,2021-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108180137
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> [Wed, 2021-08-18 15:48 -0700]:
> On 8/19/21 12:11 AM, Andrey Ignatov wrote:
> > Fix a verifier bug found by smatch static checker in [0].
> > 
> > When narrow load is handled, one or two new instructions are added to
> > insn_buf array, but before it was only checked that
> > 
> > 	cnt >= ARRAY_SIZE(insn_buf)
> > 
> > And it's safe to add a new instruction to insn_buf[cnt++] only once. The
> > second try will lead to out of bound write. And this is what can happen
> > if `shift` is set.
> 
> Afaik, the insn_buf[] should always be large enough, could you add something to
> the commit message of this fix whether this created an actual issue in practice
> where we do oob overrun insn_buf[] (or whether it's 'only' the static checker
> report ... from above paragraph I read you saw the former in practice)?

It's 'only' the static checker report. I've never seen this problem in
practice.

I also have an impression that convert_ctx_accesses should not in
general (or should never?) return too many insn to hit insn_buf[] limit,
but it may not be trivial to check all scenarios so I can't say for
sure. That's why it makes sense to me to address the report.

Sure, I can add this info to the commit message in v2.

-- 
Andrey Ignatov
