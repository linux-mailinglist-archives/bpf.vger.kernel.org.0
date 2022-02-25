Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB554C4D6F
	for <lists+bpf@lfdr.de>; Fri, 25 Feb 2022 19:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiBYSOz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Feb 2022 13:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiBYSOy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Feb 2022 13:14:54 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DF51F6347
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 10:14:21 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21P6APnd018859;
        Fri, 25 Feb 2022 10:14:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=F4jcS8qmBH0Heezkw3vSM2qMFOHEbnBndo/S6HHr+RE=;
 b=RlNi+D5ixaob+DDue7VM76SbYh5iUtmrXO+iAKSuF8NLjnBvqfEQotQ4TUWcvTD0UOsd
 gc4cNB+ycGGmC6qHXa0pA2xytk664Ptuoe/7KQT/bSAHTRagPYjR5cDGld5mRIUyFtxA
 HlXeTcXAL5IWYRgAGYzDXuC4YXdG7N47jqU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eeskukxqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Feb 2022 10:14:18 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 10:14:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byO84UbuLLRmpNl9qmxuh2a3zLaXwZqXoaAVaqUolzzsC5jsc8SnpOo7kisuJcAbii4HI92OAqicpNQVi6a/kYbP3UCQKE23hUy1CrM5gTHYKLxkQfdEJvrnjY2IUA104qyt4W3FreIx2o0EbYguG7/k++yY0NlD9KyqO9vpVsrNbETSpyurB0NbEu2JQoVk2irtAaJi+pzxxjvzPLH7TyRa+gInmap16tf2dVq8qRQv9MtezcvoucDqcLFGbAHavxpJdjNHNR216mOxXqrLwQCLr7qoDAPbLyz+mEB20WAovEtukvxoaD2a+aOTslzZqVTk1+32ke+o6R4RYvyX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4jcS8qmBH0Heezkw3vSM2qMFOHEbnBndo/S6HHr+RE=;
 b=F7EXJFcGn0heZ4YDqw6OxZZ2ZA9H/ali9t0NbfRJnbg3jymq9ozrAmEGWpERcza3uM4tQwzowxnILhrX4C7r1780z8jTVLkx3peKSWzXhZR311V/XnCz47iSjCtkcJs7l4m1Jt1aaGAOREhA7bYPL+tlZcpRuuM+Ys5L/RIkGQBTBJ3+um7UYtPP3ep0zjYHf5d3FcK5Ym7lIjfsEqTH59aYTvXpOHfzIw0xm8eittIXB/Av9M/WTylhHMiGBOTofE9eCcvhjG1wOAPbPEnIs5VAStFc+ph7U6cJHw3oaMCE/P7wpSJGDjltIiaD/ivwGUBAjZ60yVM3KgVxl9gu/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB2373.namprd15.prod.outlook.com (2603:10b6:a02:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Fri, 25 Feb
 2022 18:14:16 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.5017.026; Fri, 25 Feb 2022
 18:14:16 +0000
Message-ID: <268b3c7b-3d93-5b75-9f21-181078accb29@fb.com>
Date:   Fri, 25 Feb 2022 10:14:12 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH bpf-next v2] bpf: Fix issue with bpf preload module taking
 over stdout/stdin of kernel.
Content-Language: en-US
To:     Yucong Sun <fallentree@fb.com>, <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <sunyucong@gmail.com>,
        <kernel-team@fb.com>
References: <20220225175229.2206420-1-fallentree@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220225175229.2206420-1-fallentree@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:300:6c::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 214565a2-a3e0-43da-856e-08d9f88aa215
X-MS-TrafficTypeDiagnostic: BYAPR15MB2373:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB2373C418192B657FA0A44B09D33E9@BYAPR15MB2373.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wrv2eeUDPcyDOVseRWr/5YmVZhcjlr2VvbDV5hmmfRqnxVvdF9YSKERuiPR/q50+UWWRiMraLLAlztyjP/exPgbW2CGgONjJyZBoAz3OkfUYEU6v36GMeGR36+lLRJ/sqWHdnf+YhPKLVsea86A0r16fps9fjQ4khvQxOsNy/SGIuNTVxaGNy2Hra2BlXG2Aprnk62wcGF+DYTtYK2saePnjdTs9lSSbgNALSfzCHa8CDmJcpgd8FQ7erzXR7lDVqIBjKPzr+Achssh+/819ubgm3kL1TuKmTK937cpd5VXsxorKQcc4b3BFza76xgx6cpczoRXNgtHfPmo+4/W4CxdZJmOYWJK22BRPXfjnYIRFSIZae/lXJjCB/ufn9SdATvSE3vh0yW5GVsV4LfTVwk85EUCuyl/6iWsZABva3tqd9LocrYZIkV3eyTAraZmx5+okEy7cmNciVlHrUNrHL/VSRe+GROlV2hKEAb36SUIIgQT05UZSQGdicJVOXcQvE8mgC8YxIDJpGpM41tqj0D4YfGmLailtyF+eOsds8Y+qcX9AgX5qSYLtvGazxx4zGgIBRo3QiZ5yryWGhQYVIIKswhVnjiIp/QXpp1UaERCUGecEK8/ZXyE9BlmlkC0Au1kG7S94E8AcaZl6MHbP3JPOMNsWu1qGzQkNa8fnXEupN2hUxV0Os1QepX4jJL+nWDPuvF6y/AXuA1gJSqjI/bskrCBn+kq5dR4uF5xVIDq8bVY75CJuWhrzPfDzvhxD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(6486002)(8676002)(66556008)(6506007)(2616005)(66476007)(52116002)(508600001)(86362001)(66946007)(53546011)(316002)(6666004)(6512007)(31696002)(186003)(83380400001)(38100700002)(5660300002)(8936002)(36756003)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnFVTlZQS3diVllaR3E2WFRNOGV6M3JPTG04MERZRUM3TzJLVWpsS2pnNkda?=
 =?utf-8?B?aGZDdFA4cnBwS3JZeEY2L0RJb1RLand2N05hcEdOUHgxZ2g1SnZkVUVrUUV1?=
 =?utf-8?B?RFBZRC8vcUVoa2VIeVNoUWtlaTFVVVpla1BtV09SMCt6NjR3NHUwaFpjVkp4?=
 =?utf-8?B?SWRDT1JEVVhEZmdZbHQ0clFFRjE5WkpTUnVpdE8yeXNWeUg0OFkzeXhlcWRE?=
 =?utf-8?B?emZGbXA1bWxxYnlWNy9NZm8zbWh6MUlnemRxNlRFWDVrdXQva2p0SDRxZFJX?=
 =?utf-8?B?V2M0K0NtQ05kWHRNMVNPbWs3dk9XeElQbU4rS2VmZXEvVlVsLytMU0hYYjE2?=
 =?utf-8?B?bnl4YU94RUhONjl1QkR5QVg3Q1B3aTdpMEFwTHBycHVraUNuNWNob245b0JV?=
 =?utf-8?B?b244KzQzMk5NL0pudlFtOWpRK0ZhaU14SUJsWmtCQ0k2TC9Rem9LcHJmRS9z?=
 =?utf-8?B?bHRPWXg5bFNQRlJxQ2JrajhTKzRGL1kxaUgwd3ZwMjVZNEFqNzBTN1hrWTJl?=
 =?utf-8?B?UEg4WTRTMmU0SG5rMU1PcHVGR1FlNHVWWC9oT3gyZ0xpcXdaZDBuYUxmTWNO?=
 =?utf-8?B?WkdoY0R5TkZGZ3pZc2kvTlI5SHpGeS9RYnJ1QWxFRWpQRlluTllnTU9IV0Iz?=
 =?utf-8?B?aTg1REU0OTVVSzcxZjUxWnYxTllnTWsvRDlwMk5wZ3YxMVozdUZVL2lHOXM1?=
 =?utf-8?B?NDVPb2NhVm1mUU1KUEZSYk9DTkRFb0lYOFlIbVpIVmJKMElnU0lScE1ucjBo?=
 =?utf-8?B?b3JkY0V5SnJGMC9IVnJPeVpwTi9vQXVwYjJwRmQxaWFORlRkcVdFanpHUHFk?=
 =?utf-8?B?T0k3YVFxbGZ5Q3FpdG9wbUI5clJCWFVISHhBd1hUMFBtTVY0cFk0UHM3Umds?=
 =?utf-8?B?a2dIZVNoYk16SkN6NjE3UjY2RWE4VDFrMXBtbVlubjdheEptL2JYM2dwSTBs?=
 =?utf-8?B?eGVDWm9OSENxYkNBMHBvWmo1ZU9SNzRodlU1a2luU0JML1lSM0xWOE83V2dw?=
 =?utf-8?B?VUxPb1dMUVk4cFcwOXptVDUzTU9IV1RyRXhDaE1GUXBJbUZDR2dWZWx6bk1W?=
 =?utf-8?B?K2ZJNXRCQXdJK2FHMGNUN1psVGFjU1BFR3ovbURCS3J5MitQSm91Skw5V3Bm?=
 =?utf-8?B?bVRVdFozNHNYM0JSNXRYMFNkWGhoNUNkY2dsYVNvRUQ2azlsbmhVWUdMc2Nz?=
 =?utf-8?B?TUVydDNkOHc0b2o2YTlVQ2NvMm9lZVlwZUY0aFo1MG1HQk9IOHVpa2VLeC9X?=
 =?utf-8?B?UXlJUkZMRVZ4c0NmMzlhWlJZMEV6VXNtckZyb1lkSDd3ejcrQUU0SWtjTzZK?=
 =?utf-8?B?WU1CMmJmZ0dDdmJNaTBwTDFoRW1iT0dmVS9EaEphNkRnT3o5NU0wVWJDdFQ0?=
 =?utf-8?B?MHBqRmFQUWw4dFcrT2RmOCtqc01iM014Y3FObEdKeE1uTjVSNU94eUpjRGhO?=
 =?utf-8?B?N1laZ2dMa3g2MDQrYjZLYVRGWUZnOEpmcEhoczNqbEpoVG80UElXbDhSNytD?=
 =?utf-8?B?M0szemV2Vy9hU2lZQi8xLzh6QVhKcDdiVkRTc3BEMHRVYU02cm9UamhSWlIy?=
 =?utf-8?B?OGZnQXZubk1uZkhWaWpGR0ozMFhQVmxrcXVSK3h1WGR1bUlhMWxid0pKRHAw?=
 =?utf-8?B?UENicUZNNzNxNWtSSTdZMk81VHRydWwrRmlMMmZjbVhMTDAxYzJkbk9KMmdW?=
 =?utf-8?B?U3c1RnB5Q09uV0dhZkxVWVk1QmoyUWF2V0E3OEhhajFNdWwyc1FPU3JuaUFv?=
 =?utf-8?B?Nm1McmlzbEVTTS9ESXd0VTBDZWt6d09CREt1MkdWMlJhVndjamNMUllxdEp6?=
 =?utf-8?B?TDh1Q0FXR2RjVW9ibUZGS1VBSlpFZ0JBTVZtM1pnbERPM2Y5OER4YW83bUNx?=
 =?utf-8?B?TUEzTXo2RFRNdFB0eTFpVmtwSTkxSG1GSVNvV2xwdzEybjFXVy9IS0tLOW1l?=
 =?utf-8?B?aVExcHY1SUJXZjFDWXpINGFJUTJnLzZZa29lWDdkMlBHaE5EWmwxWUF1cUZY?=
 =?utf-8?B?TDlUbEhvRFlBTVBxMVdMK0wzanZnY3MrWW42Z2FaTlNsOG1tdGtQNTZwbDkw?=
 =?utf-8?B?UGJPZ2lkdzdjNjg3NHJoRHo2cHRqdURrU1hqVGN6Tmh2eFIyL2l1TDRLY21Y?=
 =?utf-8?B?MHNRNlZLTjNVZjF2R2dSZXlzREZZc1AwTTB4T0lJNVVQME1DRnhKUmNYYVZv?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 214565a2-a3e0-43da-856e-08d9f88aa215
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 18:14:15.9380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAoIypGivGlNhpN1D7361vF8YR9sPH5k76qSXaPKu9ld/+Xo7MWDr1SwainAQPNH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2373
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: gvKElbXhILFagD16YtpWDwpB4kk-Efsv
X-Proofpoint-GUID: gvKElbXhILFagD16YtpWDwpB4kk-Efsv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_09,2022-02-25_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 clxscore=1011 malwarescore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202250104
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/25/22 9:52 AM, Yucong Sun wrote:
> In a previous commit (1), BPF preload process was switched from user

For commit, you can just say in:
In commit cb80ddc67152 ("bpf: Convert bpf_preload.ko to use light 
skeleton."), BPF preload process ...

People uses reference ([1]) is for web links.

> mode process to use in-kernel light skeleton instead. However, in the
> kernel context the available fd starts from 0, instead of normally 3 for
> user mode process. and the preload process leaked two FDs, taking over
> FD 0 and 1. This  which later caused issues when kernel trys to setup
> stdin/stdout/stderr for init process, assuming fd 0,1,2 is available.
> 
> As seen here:
> 
> Before fix:
> ls -lah /proc/1/fd/*
> 
> lrwx------1 root root 64 Feb 23 17:20 /proc/1/fd/0 -> /dev/null
> lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/1 -> /dev/null
> lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/2 -> /dev/console
> lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/6 -> /dev/console
> lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/7 -> /dev/console
> 
> After Fix / Normal:
> 
> ls -lah /proc/1/fd/*
> 
> lrwx------ 1 root root 64 Feb 24 21:23 /proc/1/fd/0 -> /dev/console
> lrwx------ 1 root root 64 Feb 24 21:23 /proc/1/fd/1 -> /dev/console
> lrwx------ 1 root root 64 Feb 24 21:23 /proc/1/fd/2 -> /dev/console
> 
> In this patch:
>    - skel_closenz was changed to skel_closegez to correctly handle
>      FD=0 case.
>    - various places detecting FD > 0 was changed to FD >= 0.
>    - Call iterators_skel__detach() funciton to release FDs after links
>    are obtained.
> 
> 1: commit cb80ddc67152 ("bpf: Convert bpf_preload.ko to use light skeleton.")

You don't need the above line.

> 
> Fixes: commit cb80ddc67152 ("bpf: Convert bpf_preload.ko to use light skeleton.")
> Signed-off-by: Yucong Sun <fallentree@fb.com>

LGTM. One comment below.

Acked-by: Yonghong Song <yhs@fb.com>

> 
> V2 -> V1: rename skel_closenez to skel_closegez, added comment as
> requested.
> ---
>   kernel/bpf/preload/bpf_preload_kern.c          |  4 ++++
>   kernel/bpf/preload/iterators/iterators.lskel.h | 16 +++++++++-------
>   tools/bpf/bpftool/gen.c                        |  9 +++++----
>   tools/lib/bpf/skel_internal.h                  |  8 ++++----
>   4 files changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/bpf_preload_kern.c
> index 30207c048d36..3cc8bbfd15b1 100644
> --- a/kernel/bpf/preload/bpf_preload_kern.c
> +++ b/kernel/bpf/preload/bpf_preload_kern.c
> @@ -14,6 +14,8 @@ static void free_links_and_skel(void)
>   		bpf_link_put(maps_link);
>   	if (!IS_ERR_OR_NULL(progs_link))
>   		bpf_link_put(progs_link);
> +	/* __detach() was already called before this, __destory() will call it again, but
> +	  with no effect. */
>   	iterators_bpf__destroy(skel);

This is not the right place to put the comment as free_links_and_skel() 
is also called in load_skel() in failure path.

>   }
>   
> @@ -54,6 +56,8 @@ static int load_skel(void)
>   		err = PTR_ERR(progs_link);
>   		goto out;
>   	}
> +	/* Release all FDs */
> +	iterators_bpf__detach(skel);

How about we put the comments in free_links_and_skel() here. The 
comments can be something like:
	/* Release all FDs to avoid impacting stdin/stdout/stderr setup
	 * in init process. Later call of this function in 
iterators_bpf__destroy() will be a noop. */

>   	return 0;
>   out:
>   	free_links_and_skel();
> diff --git a/kernel/bpf/preload/iterators/iterators.lskel.h b/kernel/bpf/preload/iterators/iterators.lskel.h
> index 70f236a82fe1..6a93538fa69f 100644
> --- a/kernel/bpf/preload/iterators/iterators.lskel.h
> +++ b/kernel/bpf/preload/iterators/iterators.lskel.h
> @@ -28,7 +28,7 @@ iterators_bpf__dump_bpf_map__attach(struct iterators_bpf *skel)
>   	int prog_fd = skel->progs.dump_bpf_map.prog_fd;
>   	int fd = skel_link_create(prog_fd, 0, BPF_TRACE_ITER);
[...]
