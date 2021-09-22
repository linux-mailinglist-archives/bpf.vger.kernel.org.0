Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C231A413ED1
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 03:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhIVBCP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 21:02:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7568 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231143AbhIVBCO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Sep 2021 21:02:14 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LLFgev005669;
        Tue, 21 Sep 2021 18:00:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=vg/AvGOTa43CZAqaVRSHHyLVrp4mPEahPaLrVC765a4=;
 b=Z4NmKxqKPCgYH4iliR8ORLsDKFQ3eJtI+gBzD8e+v0e+kAdVw/jSnkiJOU2lpcQa1tyd
 K5qeAa9PTG/o+fwvz+ulAhUQl2eq8afC22aa97q+7J+q4I8vjlb2PFz2yFgfWkC90Z1/
 gGfRUQEk00IKHbKaT4KQvTRHSL0AMe/1v38= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b7q5816qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Sep 2021 18:00:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 21 Sep 2021 18:00:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pe6hB1AIrNUBXsl4Xj8zkD0muDM8ot8Shs9IpMatyB5U3oZw3+tdpmoXowkII+9sTWMrtuyjfV7Mj22RZ5sBPfh7hTdRiLwVADagyogvtGmd4JPpIPgWwn1vJHl7Wa21Ru1iSn6BtJRtATNL7SK6xvtfwSoGLvZSZsA+PEJ5yT35rLXpadnS5vDgZ0Pkjl7MpjRdK5g40NruEqhRtRooTlAQ4Bou2h0ien9/mqxBErWXyrsLxe+nQjNol/r2tDAzOnhEtD6QRA5lTsIl9hkFlRfn6NBrHi3vlpRisAkQntno/tsIXTEVdZSISANnMyGdfNg0VVEXSePrQjPqUrpNPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vg/AvGOTa43CZAqaVRSHHyLVrp4mPEahPaLrVC765a4=;
 b=HHQSrP8lqH5lB1lsaAEWCiFpOZbwuGsHVnKXCZrhWWenPPQEhFHmeWInfMIoZUjf1XOLzCUGMG4Fk683UbRGpXIiir+K5TtLZAfNuDU36Fy+MqqrzL/stFmf5Matok0t/qpFpjydxw7SFdDBA81HaLIaC6exK4Eed8VYpiI7+Y4pwUCnrKftn98ojzAODJAD8uptNxL1mKWaO7946Uug4TVYy9nZWRDL0SGDpi9imTVoRjOV57Cr9T3Q52Zqi2+nUdvb71C/UK1hAKrOiC7Uh7gt8dhpy+EMgKWT3fZiALvP2s9hddaDKNC2f9ZIdode9B0M2LJ9tC0dCPnNtTWK7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM6PR15MB3546.namprd15.prod.outlook.com (2603:10b6:5:1f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Wed, 22 Sep
 2021 01:00:31 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6%9]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 01:00:31 +0000
Message-ID: <630a3e62-c91f-d862-684c-619bb703d6d2@fb.com>
Date:   Tue, 21 Sep 2021 21:00:29 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH v2 bpf-next 5/9] libbpf: reduce reliance of attach_fns on
 sec_def internals
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20210920234320.3312820-1-andrii@kernel.org>
 <20210920234320.3312820-6-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20210920234320.3312820-6-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:208:32a::22) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11c1::12b6] (2620:10d:c091:480::1:d228) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 22 Sep 2021 01:00:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecbe932e-1027-405d-69f4-08d97d645fe3
X-MS-TrafficTypeDiagnostic: DM6PR15MB3546:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB3546F7D883794EB8F8E54D79A0A29@DM6PR15MB3546.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 626n797cfGwdTyUp9wsdaziWKk4RCo+2PP7euD/i5kYLIytSkUEJorNjbAxEF9sv82+mwSupCRe5+wSe3eDR1UNZlTFxRyyF9RKKEiaDb6zmJmYL9d2lof4qrebf8Z1ybYH1lIIye5Fimjt50SPURz09D/b2wIK/dE2QBjbQVbMbfWVrzeckC3/lc+IB/BEM6JQRUuEkTYSii4f9BWBbw6MUOQ0wkYzlTKKmaKV/yf/26RpLo+xuR7GGdow3J2I2JRYohE5Jr2/cK8GIorbMCvVafiQHTIO/VBemnFG4/f7iX6+LGHmS1R4dA0lYWGEXrOqTeIsayqo0G0g6j1Za3tf89h/9MDDBc9KGICRSdrT6J7x5UtTLNwgQ13aHIGnhV4YLuV0d562a+GMGRMalgFqEodximRSaTqx3fnThOJVZgCorZLMryfB3csWAnecdUyjHfuwEAtDoETRsTy4SdSZ4jxhv7zEwTmiGwPRlA1XywggnHbWVuxk8Ja8tPn8d2e4IW7n+S9Y+nmjKCTmnrGkYfG+/NlguOEvaaa32GD0zyckNrpCgy2AZxmA++dguAmPmR3qkBaGZQRQtVCWWQauPO3Xv6BNh0pikr+e3TENqzJEqDOaY5GuLY1sFduBY2RurROZ1CTx1a/zA6SeRxv7BzmVv4iePiBJeWH2Ysp3XilTg34NLwS4R/NyfQmOzRFjU7BDluPmQUCWLZ/2mEhbYq7BJhk/0ki0bCvFkvhs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(186003)(66476007)(508600001)(4326008)(316002)(83380400001)(5660300002)(2906002)(66946007)(66556008)(31696002)(8936002)(86362001)(38100700002)(6486002)(2616005)(8676002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlNURFJNMXhTcFg3TXR4L0dTZ0NQNFFLYk9HeEhkMEY3Z0x1TnpENTRrYzBM?=
 =?utf-8?B?aVoxVkpWSXp3by8vSUs1eXZRUWhhcVlydk5LbXZPdzJpUFV1YjVuNGVQUkxX?=
 =?utf-8?B?RkZjdEJMYVRNWmtOZUNuUldxc1A0VTZ6aWNvR2NrVTVTbFV0QWdHYjdCZGcx?=
 =?utf-8?B?VnpzSFRsbjcxN3BRUlp2cExaU2J4eGYyL2ltYzZoSUNOeGJteWFrVW1ZWWRz?=
 =?utf-8?B?ZFJxUmRaaWFycjRtRDZxb2dnbDYyanVJWkdMYjNQcHdlSEdJOXlxbERRRmZq?=
 =?utf-8?B?WmlXelQ3VTlXREhLTzFvSnlwSDl3RzYzQVJac2lTTmZ5T3lHZXFSY2IvTDBR?=
 =?utf-8?B?ZjRSVFlISWdtQlFjY0Jkc3ltTExTdlYvQWN4TFJSZHdrcjJIcloweUxVeEta?=
 =?utf-8?B?SjYrdWp4VktiNnhmbEYxUGNJRVlPSks2UVJaVkN0UUt3OEM2ZXFNdDdhOWRY?=
 =?utf-8?B?bWFsUDZlUXE3aUYxSzVBM3d1cDFLaDJTY1g4aEo1V2lSZ1hkWkw3MmJFeHg3?=
 =?utf-8?B?YndWMmVLdlhDT3VRVVlHSEhkeU1wL3lBdWM3QktFZnIrUGN6T0tVa2JROUUz?=
 =?utf-8?B?eVBaZjlXblhHNVFGWUMzc0NxVFlxLy90d0hjbXl6eGJ0RU1VcGdSSUtxdGNa?=
 =?utf-8?B?M0I4VmlJc2tQM0xQNzM0SktzTmx3a2g4bE9EenhQMjFyYVJUbmp4UUNBMmtC?=
 =?utf-8?B?cDVRbXNRNWdITEZYRnJ5ZUhWdDU1OERCaWZOa3RqU2ZiSHdMcTVhZzJla29v?=
 =?utf-8?B?OFJPNk1Eb3hWK1ZrNENFanVreTRIMjB5Q3VSY1ZIdzZ1MlZweHhia1R5S3RV?=
 =?utf-8?B?VldzdHBmLzRIVjdMTlVkZ0tKRStKYmJDQWszaHdZOFNQeW5ERDZ0cWpqaURp?=
 =?utf-8?B?VEhpVGpTcENQMC9xSkpJSDZyR2RoOWxlZ1h6bU1DZkFKS2ZDbEYyaGpydmFq?=
 =?utf-8?B?SmNWOTQ5WmkzSXlrNnhkdnVtdXJObytVSHJkcVYxL0FIVVJkN1JtMWFnazcx?=
 =?utf-8?B?NjgwSGJzRWpEOXVUL1l4S0dUaWVMTC9OVm9URmUvWVpwYnNCWTlvY3QvelFm?=
 =?utf-8?B?OThINVlmWGpNVnZ1LzVDbTk5TEJTandUYTNZNHFpaVExc2lBa25VWW16cXJK?=
 =?utf-8?B?U1RtV0JOSWNKL1djczFCVy9TMWo5d0tTeU5IZi9MbmRmRkt6cUwzTXNOcXhu?=
 =?utf-8?B?MWY0N1pYUmJyTGtlam5TMU44WjJZdG5MRGtnc3cydGtIektCVVJmdmM3S2Jz?=
 =?utf-8?B?ZGdkMFgrZm1MbFRTb2xyWjlMQUdQWlViN0lGWnpaS2VqcFlMQmdSS2ZBQm1i?=
 =?utf-8?B?UFpPVGFZV2M0QkVuUnVwTUorSGRudU54Nk5idGRJbjlGRG0zS1pMYUZjMG8v?=
 =?utf-8?B?OS9FTUVJbU8rbzZvM0FSRUw5NnJjZHhGRVFvNVA2THNNUXR4REJQQU0xOW1n?=
 =?utf-8?B?UnJSMUloUlNDVUNydmM2eUlnMmdMUVIxTWYxUUVqNWp2STFTRkJvY0x2UVhC?=
 =?utf-8?B?VTJvM1grWjdxMHpjeDhNNTRpQWlaa1NXRm14OUJiWmMySElKYUNncUFmcEV3?=
 =?utf-8?B?RjllVnJjbGl3RlBuTk4yWjlyMjcyaWFZcEcyMUxiUzNqTjFIWDVBUkU0S1Jh?=
 =?utf-8?B?anRXalZjdjU2QVRra3FGTHFnTzc4UlBNekJINFlBUU1ZcXdIZzBBdzhsLzBZ?=
 =?utf-8?B?andGRXZIVmhNQk5TU3NwNlAybFVuV1B6by9Rcmw1YUMrdStDT2MyMUpuY1Q5?=
 =?utf-8?B?UENsaUlnN0Y3eEgvam01RnVDeGRBS2o3OWx6K04vQnZ6NlhkWUFkQzhHWVpi?=
 =?utf-8?B?OG8rWmpVT0dYNkFHenVJdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbe932e-1027-405d-69f4-08d97d645fe3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 01:00:31.0478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ws3un/2dW2FWE6Z6cDDOwuIYS+kEtnqgY4+mTyO4G5ozo6Sg64XAoNbvzPmjNVm5xkTZhuK/i6i4a8mji9Y36g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3546
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: RZvG7xHpAFTBVY4clzqpwSx3Dn--YXPG
X-Proofpoint-GUID: RZvG7xHpAFTBVY4clzqpwSx3Dn--YXPG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220005
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/20/21 7:43 PM, Andrii Nakryiko wrote:   
> Move closer to not relying on bpf_sec_def internals that won't be part
> of public API, when pluggable SEC() handlers will be allowed. Drop
> pre-calculated prefix length, and in various helpers don't rely on this
> prefix length availability. Also minimize reliance on knowing
> bpf_sec_def's prefix for few places where section prefix shortcuts are
> supported (e.g., tp vs tracepoint, raw_tp vs raw_tracepoint).
> 
> Given checking some string for having a given string-constant prefix is
> such a common operation and so annoying to be done with pure C code, add
> a small macro helper, str_has_pfx(), and reuse it throughout libbpf.c
> where prefix comparison is performed. With __builtin_constant_p() it's
> possible to have a convenient helper that checks some string for having
> a given prefix, where prefix is either string literal (or compile-time
> known string due to compiler optimization) or just a runtime string
> pointer, which is quite convenient and saves a lot of typing and string
> literal duplication.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>

>  tools/lib/bpf/libbpf.c          | 41 ++++++++++++++++++---------------
>  tools/lib/bpf/libbpf_internal.h |  7 ++++++
>  2 files changed, 30 insertions(+), 18 deletions(-)
> 

[...]
