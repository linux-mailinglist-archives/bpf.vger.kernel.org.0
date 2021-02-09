Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455E5315A3F
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 00:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhBIXrt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 18:47:49 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42540 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234187AbhBIXbu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 18:31:50 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119NAGpe000772;
        Tue, 9 Feb 2021 15:11:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=xCOtx1yzihtNCHfQhC+0P25qoxB+LcRkOsOgPNCd4k0=;
 b=MnSoczopqLbkVXEnvlB911kJQg9kJIkpBZIUNia0sPk6Iv+e8mjobMsUUBWU+uyLoHjW
 n5EIF60OF0RJFzeozXaKdcUpsjG5r4oIO2qQFxI/ZzoOHMdRqBvbQFkZRdaSjVdNh2jD
 7TwhOliZDYHP62mIKYIJqcvnZ5/xWzVFBbg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36hsgtruy5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 15:11:41 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 15:11:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foXfpzV2k/aAXB0Wk3JEB/Beiei8V+IrCH6lG+wBD4yYBmHnbd119GNHa86sRUPQ3qu05g8D8WZ+DE8GyHxqCGJIQmVe30jRjsKMGklhtyjhgGB1pY4cbv9lRP6kCTjnRSRdQJ6+Ph22Eoe9DcCghtg9lPBWEpKmbt1aaI6gZdKGP5fmHaaMafdnUsiXmhz/YI+Om1RqJZZ7VRf5STvSWdapUd4c6Bu5WyJR2u709maP9ebvDUJPph7f1vYIbhFG5Yt54WfUyuN1ZSAmay4+fpQSG/hJENS6JnOl9d/DIjn25neisHdTomNiDq52GHJtugrP9KRRNV7uFUK83c5cSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCOtx1yzihtNCHfQhC+0P25qoxB+LcRkOsOgPNCd4k0=;
 b=XmMMcARx9CSi42lLz9dj8KGGfkUVGhXdVFzBfaP7//n6vPkNaF3+HLLjggwLuyLKkb9R1czddlVOOZiX6ywkeDJSVsZjy4pqRrAslM8+R5kZCVQ3ezQ8lmPtU+J3IFZzkOuYsFfuA4O0v0O4CT8CDDq21F2CB459oEmuRgwR0R2IH/5ezxYHDSexSl0vy/uqSdTpBrpt/r+pE9hGtiZ9DyYA0In6+5dPBBSvFGSBoT/kZjX3NuKPqeqYSWSlZwfWwo2I2rwkU5jhfrUAZRKrP/21VpaeusqAWgJXoR4qsBw3EYgo2X8wxXGZFZknkrB74uTWtT5OEIPm38WZtR4m/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCOtx1yzihtNCHfQhC+0P25qoxB+LcRkOsOgPNCd4k0=;
 b=Wg3MGM0E+qHnl1lMiRK9F1fAw4RYUe/fhMMp+4OhM4BJSWtmhmBfNpENZ3Q6Co/Pf91vmksDRh1uWxGChlKBg3UmmjNS173An80GkG0K0/HeXbe+9SfGUOnG6XuApyqcmRK0BaLPl27f0dAIxre/dQmS5Ngi3bO/LWXpHizedsk=
Received: from BN8PR15MB3282.namprd15.prod.outlook.com (2603:10b6:408:a8::32)
 by BN8PR15MB2673.namprd15.prod.outlook.com (2603:10b6:408:d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Tue, 9 Feb
 2021 23:11:35 +0000
Received: from BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::81bf:9924:c4f1:75cd]) by BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::81bf:9924:c4f1:75cd%6]) with mapi id 15.20.3763.019; Tue, 9 Feb 2021
 23:11:35 +0000
Subject: Re: [PATCH v3 bpf-next 2/8] bpf: Compute program stats for sleepable
 programs
To:     KP Singh <kpsingh@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20210209194856.24269-1-alexei.starovoitov@gmail.com>
 <20210209194856.24269-3-alexei.starovoitov@gmail.com>
 <CACYkzJ4skw5x=i-bqWXmo9sH-k=5jQXZ1Jir7hvY_se9fFxOSg@mail.gmail.com>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <b7a0125c-79e7-4d3b-12a3-86fe910bd01e@fb.com>
Date:   Tue, 9 Feb 2021 15:11:30 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <CACYkzJ4skw5x=i-bqWXmo9sH-k=5jQXZ1Jir7hvY_se9fFxOSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:c01f]
X-ClientProxiedBy: MWHPR14CA0055.namprd14.prod.outlook.com
 (2603:10b6:300:81::17) To BN8PR15MB3282.namprd15.prod.outlook.com
 (2603:10b6:408:a8::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:2103:c99:e09d:8a8f:94f0] (2620:10d:c090:400::5:c01f) by MWHPR14CA0055.namprd14.prod.outlook.com (2603:10b6:300:81::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Tue, 9 Feb 2021 23:11:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64b0f748-c8e7-45f9-3c65-08d8cd500bd0
X-MS-TrafficTypeDiagnostic: BN8PR15MB2673:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR15MB267394F1820687DE655DE1ECD78E9@BN8PR15MB2673.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R6umMvfsRkTA6l5sYKE4xPB2gIQ/a1g+kMD9/f1xsmm936InwNCGv4ScF/0JViWPIMGyCpEC/KncW6wyXXEySec6lOaLkRAjcuMoPJxi9sldLFIzwoZkDxlnV5K3n58m0qN+mDGt8YLNp2845k6VdycyNNOTglfvob+I8mu4YpudeTwok0FbR4hE9c2tm0/JCmIPHHgRKSTbiwuFQ1BKH5LY/9I4CAcCk1XtqKoQ3+YyD796l+cC5u7FxcNOSj5pOJd3KGq6augC6zLO3PeGIq1kFJ3hxH0SKt0ar5aZCruv/YMGdaQ1SM+MUJcAg9Pxb9UBuH/r4sWGYYthReA2+gmmYXEzHHsxjlbBXP7QM3Qf3k8D7OLNpi9hL/771ZgJgh8Zdbk9/VGOF5mgGMJf4Aon0G5T5j3xxKc5m28Gzvmj7m9ikNfjMkS9hmFCrRqmv0nSqBeXWm1zSgpQi4aWwixDObdRr9FUbQdWCbN2xFOJDc2AUS9AeT9YvoKplNk9+H63tSH6PU3iheM6uv1aN26FsrsvuOkHTL3gevz17ije6gTS45E5bDUFOYHJJdCezmRbKjnUju/iFMlK28yTPZZk20dPDX9q44cVZ+LVS1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB3282.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(39860400002)(376002)(36756003)(54906003)(2906002)(52116002)(8676002)(110136005)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(8936002)(6486002)(31696002)(316002)(31686004)(6666004)(53546011)(186003)(16526019)(2616005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S2NLaEp2Zml1bUdJTDNIOVZVekdoemZLSVlzRndmQ0xMejJtTW1DYTkyTXB1?=
 =?utf-8?B?RTRyQUFidEZjanVkcEhYMjliSEMwU29KcVBPdzBtdTU2V2MvbHplOWhuVzJP?=
 =?utf-8?B?cS90d0JydDhqVjlmOUxmbkhXQWhtOFJXSzZ1cGpLZXgySDMrcGRISENCanV5?=
 =?utf-8?B?QTQvWG9hMVJ5ZzBqbEYyVkl6cjhrN1dFM3l0MFF1MU4xUVA5SFM3Q1VveDRL?=
 =?utf-8?B?TzFjZVNrZG1MeHhsR2RZVm5pdDRiQjA1VWR0alNud3QyMWh4YWx4cjJzZ0ZV?=
 =?utf-8?B?WlJNcG9Id09IRi9zZW9jaFo2NVE2aDNycmxUV1B1bHoyS1RxNUxHanJmMU5H?=
 =?utf-8?B?SmN0bldMT1U4L1RyamlIRE1tQTNBNVd0eHZRS0J1S2NOd2tFU1pTMEJvWkJ0?=
 =?utf-8?B?eTFKblRjUzlqR0k2cnUzd1h1L0o5OWpDMHpSbEJIQldVSFV3WUp0QXI5cDNn?=
 =?utf-8?B?M2lTTGYxVEZ5bmdUOGoxRlh0d1owZnc5WlhWK0tMWS9qYm1BR3EydWswR0o1?=
 =?utf-8?B?UTlDVjdWM1l6Z0luSW9oeURpQ1VDZGNaUTd6ckQ1VUQwbWZTbmdDUXNZZk9Z?=
 =?utf-8?B?eW44b2IwOHQzdkFTQW5RNEpvZXFzWGd1OUdYRlNiZ3B5T0NiTmVoQld0NEhB?=
 =?utf-8?B?QXNzaXU0aEJaaXM2NVpDVVFsRVk5NDlLSmpSVTIrNkdkQi9ZMUtKaVd4UG9O?=
 =?utf-8?B?U0lvWDk0cTJqUDROVjJudjhMc29oRm8ySWkrR2IvMWtPWFJLSE1RaW5BbFpo?=
 =?utf-8?B?OUg4eVExeFlFRVNqMDV5ano3SVNiMUxxZFlYWHZ0YVVzd25NemJ5MjV0S3pO?=
 =?utf-8?B?VExLM3JFanUreVhpMGJlK2I2eWRSZ1FMY2dJM1ZIVnlSZnBPaDFZUXJ4TmUv?=
 =?utf-8?B?dDZ4aDdXa2VTbnJ3cmRVNFNSQllSV3JiN0l3QWFLcnAvbVcrb3I5bitJNEk5?=
 =?utf-8?B?d2Z6R3hrNU1JQVozK1FITlM2UzVXN2Y1UVErNmo1ZHRBTElsRjByclFlclh2?=
 =?utf-8?B?c3J6Y2hLaUFyZjlaeXZaV09uV0hjYlFXTzY2WFY2bFlWWHhBdjkwVEUwUnMx?=
 =?utf-8?B?SzhZYytvOUFVUWdoSk0xYVdLVEhNelFQQ3c1N09VbEpJeTd1VnY5Rnl6WlI2?=
 =?utf-8?B?RzQwWVVvSktDeFZrTS9vOXcrVG9QeG1peHk5SElXcFlROHM2MTFNeUtxMTNs?=
 =?utf-8?B?S1czelhiU0oxZ285RzNBVWxScVJaalpRSEdsQ2hLQTFBN09teHlXQTlsWWdn?=
 =?utf-8?B?Wjh0MUNWbmJUZUgzTXBoeHlsK01pZThRTitKWERvVmgyclBvS0VCZFNlOHds?=
 =?utf-8?B?RHFSK1J2UFc1NnhVaFR2N2FmenI1ODlCUmJWUXl1bTNLNkNqdngxQ2VjZ1dt?=
 =?utf-8?B?bTA1MDE0cHVYZFFjejcvVSs0Qko3d3RtQ1RRWXA0SWFJeWs4Q2h4QllTZ2tN?=
 =?utf-8?B?UytKbnJsVzNjb1loZ2wyU3hwUkEzQVFEMExzb3ZsdlpwQzg5bEZGYnBiY1Er?=
 =?utf-8?B?QTB5Rys1QjR3Z2hlc3VsRlNIVlVNY0JDSXdROGlHbXhnWVFodHdFbUdHREJ4?=
 =?utf-8?B?NzRRdlRDT2NscG5LZWFZWmZFUVV0bFlZV3FXWk1sQVp1RWtlWEZJV1R5SU1E?=
 =?utf-8?B?cTROVy91L2tKOHZUaEc1emtxc2pyM0lmSmpqQ2ZRUnJha1BWZG5DQnRDVWxj?=
 =?utf-8?B?ZFY2T0c5bGorOERYT29LR0ZJRjhKUWFDQkx4cklyMllSRjBReWYyTFdSVDJU?=
 =?utf-8?B?VlFOWkkzSFZ4T2s4Vlh3WTF3YXk5L3NzbjRaSXdRbnNpOUpqNzFWY1NLcGcv?=
 =?utf-8?Q?OpzVI/8Bi7lJb2HeowvUGljk3+N15D5F+gNuQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b0f748-c8e7-45f9-3c65-08d8cd500bd0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB3282.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 23:11:35.3988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dp0Dn5g9m9zmX6GgUiS2+u0cZVtkDpRTHMC5i9f/6BIy8wbXW3mAx1utZBIdz+l6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2673
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_08:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 spamscore=0 mlxscore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090120
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/9/21 2:47 PM, KP Singh wrote:
> On Tue, Feb 9, 2021 at 10:01 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> From: Alexei Starovoitov <ast@kernel.org>
>>
>> In older non-RT kernels migrate_disable() was the same as preempt_disable().
>> Since commit 74d862b682f5 ("sched: Make migrate_disable/enable() independent of RT")
> 
> nit: It would be nice to split out the bit that adds
> migrate_disbale/enable into a separate patch
> just to make it more explicit.

Not following. What is the point of splitting it?
Just adding it without using it for anything?
That's a bit weird.
How would it help anything?

>> migrate_disable() is real and doesn't prevent sleeping.
>> Use it to efficiently compute execution stats for sleepable bpf programs.
>> migrate_disable() will also be used to enable per-cpu maps in sleepable programs
>> in the future patches.
>>
>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> Just the optional comment about splitting the migrate_enable / disable bit.
> 
> Acked-by: KP Singh <kpsingh@kernel.org>
> 

