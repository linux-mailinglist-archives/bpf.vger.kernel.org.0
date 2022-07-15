Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF4657654C
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 18:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbiGOQ3y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 12:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiGOQ3r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 12:29:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9D93AB24
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 09:29:38 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FGHR5x023442;
        Fri, 15 Jul 2022 09:29:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=f4ziqKA3JKc+FV11el1ENma9BprREWFvKHcMwC0ZLpU=;
 b=UO1trSnjsXrZ6sf/5SMX9PIXlZevEYtT96giRYA11N7DpbSPYbCVsHFAXTlRs8Zpfbkm
 X6hSh0f+efkh1bqUi5PMF3aFBwM2NzteZNV6zAkY1P6gFdIU7vE0qZOydD2tSdomeC4x
 KELKfMm13JiP5E67AG20VwBiMvJF/RkzwX4= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3haktc8a7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 09:29:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHDQjuDD4X3drMyKWU2Tvk07sQMAT5pV9fUcS8IY/o9ah7bIGKjG9Ggm+5/YOmwNX5Kkn6NkKCARccsKdBZ3SZ2uxVKtxK5XYIktOJZjxnXonWGd6w3n5S5oJf0tBSr5cVdE6J4lk9/Pb+cPvYoArWjwr4L6JH0WxoK7fx96LNTRJlUAPNnEXmtDcy6yjOAg2FbAT52cL2fZ1xw8GpmUbGhreJEOmpFAIzN7EYkCKt6xafUHK2FHoDGpM7jSH1cG/2GUp/kKdyjUhTmYtvG6wiWYno2q5W8InBB41yd5e5qakpwgTVkTvkLez2fiStngW1EA2jGlGUcgjOtjY7Jq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4ziqKA3JKc+FV11el1ENma9BprREWFvKHcMwC0ZLpU=;
 b=jm41j7DoOwzE33umyw4+Dj1TTzbZa7hgJoVy3Ios/qOZ9HU/PntjJs540WT8KMEPHgNQGqCiWyT5N3pEBkHFGIxA4biISXyetN8PECthBdSgBFGt7BO6qp4dnM+i8GuZuyXyqSW824wL6qX3gKhcDDB8e+xixE+7sMTDnjkPYo6HZZO/zJf6UWpROIqwfoju0t3hSGURhcAVrvBVyd0sTut/51zTqUl54pvwRjQlgd8EPV8S0GvtqoThIhjxCyEPctzJeRGFO1lGElWoZA82p46dwgNPTqxVJZqLjIYxdfRwPiUUlg0ueGk3WpDLWsUZrluw+AvcGViipCYqvdQE9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY5PR15MB5414.namprd15.prod.outlook.com (2603:10b6:930:3d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Fri, 15 Jul
 2022 16:29:19 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 16:29:19 +0000
Message-ID: <3e4bbe32-c516-8391-0ee2-7b2d1c5207ca@fb.com>
Date:   Fri, 15 Jul 2022 09:29:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 bpf-next 0/4] BPF array map fixes and improvements
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com
References: <20220715053146.1291891-1-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220715053146.1291891-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0178.namprd05.prod.outlook.com
 (2603:10b6:a03:339::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5000cd8-2f79-4a32-7ba5-08da667f2af6
X-MS-TrafficTypeDiagnostic: CY5PR15MB5414:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nj4wjYFVZj1mQDGudMyXtjS35zg7O2qSowlJViqEtUmui2eCcQjHk74osol0Tm70xYLkkBLvxmBhijaWxs2CwpecQ7iLdn24Hex1MJXPMICGuBFAZQzBb/UGQL9y7T8pBCwSHastmfL/m3YLTZy2E9Wts/nBu7XtlqA9xEJz16EDraB31N7glyr/xzUgJN/dK0PkaKcDZvYSskITxx/cK526hkw61/NsG1gP/ONLieqdF2ZPKk/KWODcrfpJZmCWtplOCENWLhZ63kUB7us/QHAH0R7AFB1lStwk59SMbt2Dr6Snr0I9EYnzDgMNAw272tF6aeYKm6oilntpn7MWrSbEqiWijGWunnbi4BaifQkz7SFmdI4KvLdU7qFWCmWNiZm4gQA9Iv2fMhtlQGyRBFtCP5foFIvwSwiuSLaWM2XFjXrlgDTLGtUy3hx92Fk1jRAd4Uo/a2/8zRFVE9lsks9uUXKR/+S/VBOy5sXq+4JdivepSQXjUTa+MyBEdWMw62eiAJEcdQN81tZ4luzx2e1NPciTsFkQgkIKbR160FDBBzJ6AvtRTkiHTA4z2kUQmOaHOTugSETCDE8KF3BAMb3RA3xssaQ7N07/kG/CjRC4FKyKAY6hKM0mnb16EhiJpZLiVmd0KS0SNTBEysqrex5CwWBsYWG0rgdL7otlEHBw8Sc+yYciJekij1R5BcmGyS0DUrH+KpKBbWpmbMR+VMYmkCHoQnbXt+P3NiPIPw7pyfXZ3G2I19azmwPpzmYq37UFPqiBC2V07+T3i3PHaRmmmp+JLZ0CEb340N0XNH67+NApZ6H1dvE+wNEKZhbqZKXPPStwGYXqUYXMn3iCAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(53546011)(6506007)(6512007)(316002)(41300700001)(6486002)(86362001)(31696002)(38100700002)(478600001)(186003)(4326008)(83380400001)(5660300002)(4744005)(8936002)(36756003)(2906002)(31686004)(2616005)(66556008)(8676002)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXhTa2g0Q0xvSHNWRlcrNzdyQzg2aUxZditYazIvdWg4QnJZelNQcTVNWTFY?=
 =?utf-8?B?WEdxUkZFNENROUhrQ3VIT1VVcE5sTExYbjhtWDdHRC81R29zL1RnaE10QWky?=
 =?utf-8?B?QjZDRGpIMlhhZW9VZzBHYWlaTi8wMjVwRGZ0bjkzVTBRcHNHczh5dUZHVXE4?=
 =?utf-8?B?TTlLY25TemdVSnMzb0pubXdkdG9WVmN5ZjNRb3IyK0dxZTZ0ZUtiVXh2bzVl?=
 =?utf-8?B?d3d0R3hML1dhZVdOeDl5RlRSSElTb1l5elJ3QmZLaUlzUWhyTFlCTXRZSHBC?=
 =?utf-8?B?Z2c1VHJESnh3cnhqSU1LVXl3RWRsTFRyYWZYTHF3VWN5ejBmbHNBZHpic3hm?=
 =?utf-8?B?VUJqMjBaOUtvYmJMdEkvZG01ZVk0Z05RbWo3d1N2R1ZuQVlBQi9GVVlWUzBQ?=
 =?utf-8?B?Y0R2c0JJWXpBQXlKK1REdWZvb1RpRHEvR3diY0RobGZCL1dkRE9jcU1GVGJt?=
 =?utf-8?B?ZDZMSVpxTkgyVTNLd0RPRDRJOXJ2TWtDby9JRUU2ZWovSVpqb05MWXNqZEN3?=
 =?utf-8?B?OU1YTEdrQVlPbjdMRHhNLzY3OW1OVGczWmR6QUhBcXB3c2g4UEVqdXdkaS9x?=
 =?utf-8?B?ZDFoU05IYmJMeFZLUzJ3YkNjTFFwTm1oSUcvQUkzS1lNK2g3dXJZYW1JZ1Zi?=
 =?utf-8?B?WEx3Q1ZNSFJ3dUZZdUVWYy9kaGhDWjhyMVRLa3h6dVNHNk5tMDNZY1I5ckRa?=
 =?utf-8?B?Rnh0RFpXSTJYa3M3SFhxQmY1VitvbUJMUnQ2bHVWN1NWUldiaDVxZndrZUNp?=
 =?utf-8?B?TTVILy9xVlVoT1ZiT2E2bmVHT0VqbTRoVTAvUjFQZWR3c2x0VmNwZHh3MzJQ?=
 =?utf-8?B?a3E0NWJUN0p2RFpvMGF5TGhZclJiSTRodWw2dDZKN084OVJwNXl6V0VkTUYr?=
 =?utf-8?B?akRVN2c2RlV2eSsySnhISGVyY2s1OXBxeUlMN1YwV0pzRllwUjNRalNXbi9P?=
 =?utf-8?B?NjNNdnlmcUNjdEZqNk1IWmpDSzlncTY5b2FzTjVJWXZEQm83UnNhNkZjQU5E?=
 =?utf-8?B?UlV6SmM5akZDaXRPazFFWDlvcExrVEY0MlRiVm5jbTZQNkt2QWN3M005UElj?=
 =?utf-8?B?UUZ1WE53bUdtOU52NVZOajQvN2dod0xUbnN0MzFnY1pkalkvNGFaTkNGK3B1?=
 =?utf-8?B?di90aHMxaGxqMzIxSllPYWVvN2lJR0FFOTdqNnM0N21EK0dwWGc0b3ZVRDU4?=
 =?utf-8?B?UHlySUZ3SHlCeWp6QUVIUjJkUVZKQTFiWldzaG1OZVF5ekovemJMbW9la3Qw?=
 =?utf-8?B?VXlnM016MHNkRllrQm0vRUhIZVphSDdISndYcmx1T1cvZ0JIRlJQTjZseTZh?=
 =?utf-8?B?ZG03K3Q5djFLYW9wcnJWVkVKUHJXOEc0SVlRK3NkYW1renp3RkkvSU9uUGxi?=
 =?utf-8?B?ZWNLWUpGM1pENUkzaXBUcVBQSTVJSUY4Vnc5bUJjSHBFOW5MekJ4ckZGZitI?=
 =?utf-8?B?TGxKSmdqNit5aEh5TEZpOVRCKzZvbUNuRmh5SWkwRXdQNmhDbFF1WlJ2aWlY?=
 =?utf-8?B?UXQ4bUhUcDdHTXl4bU9JRTVZcEJrb0dIdlpMZGFNVTJQWHV5ZHZxZFdDR2lJ?=
 =?utf-8?B?cmdwZHMzSDJSTWxDVnBNUWoyYjZpeGVjcEhQaHkyaFNrOUxLakxveEw0MGt0?=
 =?utf-8?B?RGh2anY0aDh0cTZ3aFFDYldsOE1UakkxSE5JbDBVakhlT1d5amZsekVEbUJ4?=
 =?utf-8?B?VEw0ZlR6b2NrNHl4aTU3QzF2RENIVkpxU3p4MlAyZGRwTnNFL1V5YnhWNTBu?=
 =?utf-8?B?dFhXay8wS3RUam1lNFJnTlU5MzdVdTcyYUFWOWp0UXFsemRVRytJSXRHR0JM?=
 =?utf-8?B?djJadWU2OEtZbkxoWiswYmhoUVJzMkRmclVhaXZCZlI3ZjFtdHpvK2M5c1Jw?=
 =?utf-8?B?VHhET2EvTXVPTE42eTdMSWFwL2NhZWNaYUNmdmRvQm84cVYwanZUNDBDZlIr?=
 =?utf-8?B?c0dVOWk2ai8zUlBtNFE3V2x4SEFMV2lYYmphT1NLaHFxWjRVZC9uNTR1dlBQ?=
 =?utf-8?B?MFpOL0lyazFlemczdjFJN1lpWnhzWko2SHVhNWkwejd3U2xEcmFXSUYyWlFM?=
 =?utf-8?B?RDFEQnN6eW43T0doTWR0a3BWd0JyTlg3dlRJdnJDcCtwTXEwZlJHNldTMFZx?=
 =?utf-8?Q?c7vgjRJ/j8llUNmBMCbH78VA0?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5000cd8-2f79-4a32-7ba5-08da667f2af6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 16:29:19.6210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ktyR12H5XAuyHNbqtVcgqiuJGTf8pNQLxqw2UmHDgNLfWjUMUYVEWjytL5DMSjPx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR15MB5414
X-Proofpoint-GUID: u2cWRaxxX__BOi2pWGJqI1db6wZ7PL1X
X-Proofpoint-ORIG-GUID: u2cWRaxxX__BOi2pWGJqI1db6wZ7PL1X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_09,2022-07-15_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/14/22 10:31 PM, Andrii Nakryiko wrote:
> Fix 32-bit overflow in value pointer calculations in BPF array map. And then
> raise obsolete limit on array map value size. Add selftest making sure this is
> working as intended.
> 
> v1->v2:
>    - fix broken patch #1 (no mask_index use in helper, as stated in commit
>      message; and add missing semicolon).
> 
> Andrii Nakryiko (4):
>    bpf: fix potential 32-bit overflow when accessing ARRAY map element
>    bpf: make uniform use of array->elem_size everywhere in arraymap.c
>    bpf: remove obsolete KMALLOC_MAX_SIZE restriction on array map value
>      size
>    selftests/bpf: validate .bss section bigger than 8MB is possible now
> 
>   kernel/bpf/arraymap.c                         | 40 ++++++++++---------
>   .../selftests/bpf/prog_tests/skeleton.c       |  2 +
>   .../selftests/bpf/progs/test_skeleton.c       |  4 ++
>   3 files changed, 28 insertions(+), 18 deletions(-)
> 
Ack for the whole series.

Acked-by: Yonghong Song <yhs@fb.com>
