Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC535063FC
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 07:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348695AbiDSFr5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 01:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344796AbiDSFr4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 01:47:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EF91FA77
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 22:45:15 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 23J0G7dX019217;
        Mon, 18 Apr 2022 22:45:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Ug4zVfpNZeqK9S8yC1MySgownEA2vPas8ZDbZBcCdGs=;
 b=kmEhgPGcltHJ5/B8On+iwYP/6qiiKvCOEYgFift0C6rp060raJvxGlV8ozhperfGwJYI
 qakxP5gBucmKzyFPi2Tv8hi2EJl2h00n0im1Q6yCJ+A07Js76TNIDWIqZNWwBQoQEHyE
 N0FZSOsKWdS28m5V19T3IxCQzSR1jHukYUY= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by m0001303.ppops.net (PPS) with ESMTPS id 3ffsfw5hmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Apr 2022 22:45:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K83ZpBxZnUqz9YM6zLzXMOb3AcQuiG2Yigj6l2d87RXN9rVsHsbhtLOMNJsgOEkv9xnkyvsrN3Ax8ut5sLkAccRE8LoviNUWsNcFIermlr9uZXRKf/45VRowcmmDpZfM5WROQpreAh3n2zRlA82B8rV9G+4XPhTBk7mIxJMb9EO9dcH+JfvHzbAF6JWo2AcC6EHnPN2LL7zM5jCVm42bh2FViK8XFULdj8qjqccihhjUpeXYs4wjwyA00dWMl5nQOpF/QHuFHuOFmaNzpjKfXrXXpIQ7UP81bu0xuIQVh/FTl1rLjcXRg6bPdA7CuN9P2xX6NbbD30roB/2df1v2UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ug4zVfpNZeqK9S8yC1MySgownEA2vPas8ZDbZBcCdGs=;
 b=fP0kQXeZYOJ7BJducTt5W3ts7yzo8lbF6C1avcom8CiSAT3OOnq8v5zuHfysjQH4+nMsRauc7lMuMW9y7lzYBNH6anAnWShLrdfmjSw11MnaB7KnbkFVNM2vMG+uEOihtc9FpZv29ZjdIX1JbXOIAlm6Qe7ItIlN29Orxd35Wo7sgOgno3PvWTD0H5OXA/CyruNJeuiv19IhbLdm3MOeMTxv5bb5/LvQVU5pWfhUgWRbRllTwuT0EPrc+jlZV/FwcYBe+2F/1cufrMjsQM8SzGAhrNxhRSdwwlyVUSwmPhiMhe+MzuIBG3xX1fly0d1N7eLbgR3zswxRuYD62RTuQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB2933.namprd15.prod.outlook.com (2603:10b6:a03:f6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 05:45:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::24de:30b1:5d2:b901]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::24de:30b1:5d2:b901%7]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 05:45:00 +0000
Message-ID: <30bd55ec-2eed-5546-635a-e8c8bd66e571@fb.com>
Date:   Mon, 18 Apr 2022 22:44:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for type tag
 order validation
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20220418224719.1604889-1-memxor@gmail.com>
 <20220418224719.1604889-3-memxor@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220418224719.1604889-3-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0066.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::43) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6775cd27-5359-44ef-5e74-08da21c7be3c
X-MS-TrafficTypeDiagnostic: BYAPR15MB2933:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB29331F1BE2FD05EDA324BD0AD3F29@BYAPR15MB2933.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F+xUkvJqea+GKGdj6LemTBnAZB5v/P97v6FAC4xLlmaBEvZPRRYBDnJqWNwWq4VtGjQWzICJbZAJ1aiQ+WCjdR/XilkU0spRXoMGEOlUEvsS4ReXSvl2TFJ3ejzKWxLWXXBEJXFl4cakru5NF93C5Ms2Ug9IxO7kF/odsTpLZf2ghIHmYTtc3tl1KQnBLkGqSJs/VgfpPvz2SVMM2778cNIeZ1bIP4utWuPKmXSB+m21IRqtJ0WFT1QkDM+DcNNYSqkRKOS02QcAsr4zM4Qq0/jCqaDVlpFvNJQSol4CIpz01zYW81zeE0n09VjBXejASVaebdusssX03GNLlBsQEByhkttIha7AFGIBylAX1VVX7fH7gDAFHoDbDncfHPcUWguDCGzVpRRO2rK8B1a3AfAm21TZz+/InemRbMkSRv6LbsJPcwrga54F8BCi3GgeTpDBd5UbcKxmY1zzFZfdpljIT1fDlaofG2Za3j6M1fZQFrFIJXdUtxmS4P7DJlO5pMAbY+c74LUJuaWF0bhPkIkiY7LpRQ0oYrH1QCvEuguf+smq0YUmbKK7HfhhHoJIS5R6sDsxVTa9wtvak6FUP+bS8Pbvzwu/axWPWa2rHgXB035u668ow8oKXdkQXVe3leOMgykaikMJ+lfAERqEkBs/wPeNV3Tg3hmkLNYYFOhEQHoTOxQ/oMIVYC2MhV9Z07DkwR04gI9utVU8ZBATgbdftgTQv5V0e54Al7msweSxa8cedPtjjlTJMmSmooVt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(53546011)(66946007)(31696002)(5660300002)(2906002)(186003)(2616005)(36756003)(31686004)(86362001)(6512007)(66556008)(8676002)(66476007)(6506007)(52116002)(83380400001)(54906003)(316002)(6666004)(6486002)(8936002)(508600001)(558084003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3ZpVlhrZ3Q5MDVaSnJwV3BSdlU3eWRsNjFRS3lPTVB2T0dFbXVSOUhoSkFK?=
 =?utf-8?B?WFJlUGRLdXZiRmRPU3ZIZHNWRTdtK2xuTXp6ZENYWk1lSDJTd0Z2Yysrdi82?=
 =?utf-8?B?bElKMFU0VjhDSng1WXloNVN4UGxFYUlheWwzcmZ0bFEzWHczS0xydGo5VGpa?=
 =?utf-8?B?SWtmZGpaWVpZODhoNjdQc1kzS1BKeVlYbDZPbENnSFk0ZVdEd3FMREJCM0lu?=
 =?utf-8?B?MDVVSkJzU3dQelhOTFpsa2t5RkFoamJBSlh2bUhsdDBRd3V2Snp4VEsxVmlz?=
 =?utf-8?B?bVkyTXpFRldvQVpueUFoNXNlSGlrZytCM005RjRZQkhIRnJQd3RGZk9aSHIr?=
 =?utf-8?B?RFQ2SzRuMnBUbzJYZHFoWVFaQTZDVVVDWWEzUEM5YVRaQlFZM0hRVzNTalV5?=
 =?utf-8?B?dCt0MVIxVXc5bXRIS2dkWmllR3BvQmV6akhDU3lldHN1OTBUUFU4R21yVHJ4?=
 =?utf-8?B?VXUwbjA4Z2cwM2FXOUZweUxIOVN0S0RDUXB3VFVEbVNtM0UyZUFPN3J2c0FI?=
 =?utf-8?B?ZUhZeDBqd1hsdG80UGhqMlB4S1BsS3JCOEowd2tWUUdneGlxK2p6TzAxYU83?=
 =?utf-8?B?WGVKVk1rK0p5WWtpTEo0dkVsNzdPYlJkeGxJbEVBaFk4OVNSNTAyd3dlTy9F?=
 =?utf-8?B?RmV6d3djaE0xa0taa0FkYS8rTGc1R2Flc05IYmgwUmcvcXRIL1ZvcFJESldO?=
 =?utf-8?B?VmNSa2YwYktEMmVCUlRFQ1pzcGtzTzkvOGVvcWxwV1Q2UlpjZE9jejlERytp?=
 =?utf-8?B?bnVkZEZ2cjNqRnFRc0RHVlU1dThZR3g3YjBpSUZ4a3hmYjdEcjZKUE05VDVv?=
 =?utf-8?B?M3lWVWRjRVdTWm93cnVBOXNhbkhSbjkxaWVDdW5LNDJPcUZNL1hjNFhNZEt2?=
 =?utf-8?B?SUFPODR0UGNKcGgvSnhibkQ2WElyU1E5V0VNaUF2SGU5VUk4czVuWnhiRWVh?=
 =?utf-8?B?Ukdjdk5FRERXL3N2MVNiTElIbXpSRVhnYmcxcFFRM01MTEo4d0RKbDlwVTlr?=
 =?utf-8?B?ZlBSM2lBVm5PYStqZHA0Qks0aDcrTXdBQmQ4TWhwUDhOakdYcm5XNlZ4VGlj?=
 =?utf-8?B?MlcyWlRQalZETTM5Z0diMEhsS0dSK0lSVjJrWnZlS0g0U3V6cWVGZGd6Yy9V?=
 =?utf-8?B?TUp0Qy82dXFWTG1JQlR5M05kWlV5TXYxN25IZXJVbENFd3NxR1NDc214cUI5?=
 =?utf-8?B?Ly9OYnNwUFJPL1dmUTlVakVGaGJPT0Y2b2NTaEFJNDNXNkVRbVd0S2g0dVNR?=
 =?utf-8?B?L3BOUVlORGdJOWtxTytsMFpOTnNHRkRVZm1LSlZKaUlQL25iTUlEMDI5anM1?=
 =?utf-8?B?U1I4Y0VHaHV6bzhWZW1JSGhKV1ZwNjUwTXFBcTNSL205UVI3L3R0UDdaYW1r?=
 =?utf-8?B?OWNKK29sTC90bUJmSmREUUNKeklmejZhSi9LbUw2dWdlN2h4MTJ5VDRUZjM2?=
 =?utf-8?B?ZnY5VHVYRTVjWmM3aTVlNURuRFYvaGxnZHI3Z1VNYkNZbkEybHlkaHZGSStD?=
 =?utf-8?B?eVFjV2NHeVZKbU5Oc0pCejdOTHNscVZONEVGTS9FbStrVURobGVSZk45alRm?=
 =?utf-8?B?ZkRkWDdKR1oyUjhTK3diSEE3VW42bnJZazdBNVAybnhQL2FsckdqNzZDU2lo?=
 =?utf-8?B?TFAyamRFOWsvbTN2bkdnZE84K3Q2a2R2bTk3V2NZNkFzZXVVZU9YTkF0blpH?=
 =?utf-8?B?ZERQbGJDcThnU3ozZXdXQ2UzWVVYbU9tdXhBZXJST1c1ZS80Wlc0N0Q4MEFi?=
 =?utf-8?B?MFJPZ2d6aXliZjQyT1FxWU9IOUZuZUFwU3lyRzBYTzZFN1VXVEpvSlAvTDZC?=
 =?utf-8?B?ck5zam1mR29OMmYrUmVDaFByL1hieDY0VGhzN0Y2M0swQUFiS0JZY0x4MEtF?=
 =?utf-8?B?aS9EZ0NnZExYdGs4OGhqZUhiV2J3Y21NanFEanZJT1RDYURQb2lnSEppSGZm?=
 =?utf-8?B?YUhFNlY5MU8xaXAwdGRhSmk4NFlsR3VvNTZWWUxyNHBzKzJzbzVTNWdJa3hY?=
 =?utf-8?B?bzlBeEl0V1Zhc0xMWm4rbndnTTlhcEw4TlZtREoxK1hZUkVQRVQ0VmpTYVBI?=
 =?utf-8?B?MWZtbFhJQmsxaldzN092aHlLVnJVMG5oTVU3S3FRVHAwT1NxR1NJYjF5bEE4?=
 =?utf-8?B?aGljTFJVM0lHYTZ0TkVxT2s2UnovWjQ4YUdxK3c0anAxK2VXK1haRW8vVTlQ?=
 =?utf-8?B?QzRuRGtYa25BQi9BQ0ErQ0plT3hhVHFNU0FNVkdrUFd4Ukd3a2U5WjRkZko5?=
 =?utf-8?B?K2ZicThZNEVmcE1VcHliVG03OVhBUVJBa2dPUThTV01XM1VsbkRDeE1JUy9Q?=
 =?utf-8?B?VG1jVzUxVXozTElEMndCR21yVUkrc3BYS2pwUEJYZkZPQnFBNjFsMERxRERj?=
 =?utf-8?Q?pIeIR7aFvDcsmIZ0=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6775cd27-5359-44ef-5e74-08da21c7be3c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 05:45:00.2057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drpoDqigy0yhR7ymZncuxvhdpfx7Ep2nWAki0S+xeWPMSxKLs/GHcG7LO8P2lxD3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2933
X-Proofpoint-ORIG-GUID: 1vYCkIxYvBcqSvJraXU99Qf8OTBKwDD8
X-Proofpoint-GUID: 1vYCkIxYvBcqSvJraXU99Qf8OTBKwDD8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-19_01,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/18/22 3:47 PM, Kumar Kartikeya Dwivedi wrote:
> Add a few test cases that ensure we catch cases of badly ordered type
> tags in modifier chains.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Yonghong Song <yhs@fb.com>
