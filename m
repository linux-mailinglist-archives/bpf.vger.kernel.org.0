Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCEB64F641
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 01:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiLQA0Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 19:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiLQA0M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 19:26:12 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AC9FF
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 16:26:10 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGNLQ2V032044;
        Fri, 16 Dec 2022 16:25:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Y4+aTVwgRuHy0Xcc1+vbkkE89mtVVEzTTBZIo+l3wjs=;
 b=CMSIDR1oVJyJC1540H5r6qnm9lwqb4H1NeNDZ7Fd6sF0zpQChkPU3cTm232w1RSkOwj8
 OI8UVgpfstqzLRkCrIv2ZNk5uNRnxu1Srfe96Q7HM1n8XIruvbSxP90aXctEO5F/AnEz
 bAW8e2TJNoM7/d4y9xXtKsAietBg5/EgZiFc3OULNWP0xaSo//pqNAR5S+vGfMvNVGsR
 Ax/0Pv3KAr7w1EqoycNuo0QSR1dmWMeDX+LgTDYbiGXHIXsJIdpgPsIkBF1fDoKIgvLm
 3bZ3eKrdVuJ1QsJN6C6PbkNy71Q4tYdKbff97k5idGU3VNM81vTUB6DvcUDyooK4IvFY yQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mg3hj3tjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 16:25:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLYLQBuftADdVIKrT6yWe8V+8Ynj6763qDjH3gVqOuctW6wvclMqZs+/GxDjFpJlpR6q9xDSnf1wCoiGKzGzPKVk2j9jD6DMrfXR/cpYOgtC31KnIw6hp/5OU/2fAeW1OO4A27eo7/Qg3lMEdNMLvyWGOGPsn+1kF99p6c9vNuwBi7lA5nOcjfurisCcfRzd29Y/FwjUMmRRUY1j09qQu9Yudg1xwpAqoJnkucPtUJtDf0BvKM6lieOcYhW7HHhS3iacFx7lgq17RlH0DQFhggD3x4Xz0e1ePv+wXXr41h0BYWaQ3+jdPDGDttSjF72rTcV5ZotbD5/9HOnWl+A/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4+aTVwgRuHy0Xcc1+vbkkE89mtVVEzTTBZIo+l3wjs=;
 b=XMwmv71CSwAbOH3Bun9g0rfJ4SkwgE4iM6tC+BctHQJVVCJCVzAVvXJ/GBIBVh0Bk+85EHPhFVviJFLLE/n3NVCf3TIN8ndhq9XUUWLWlWHyJ1N4H1fh+/7V633t9FmrrDfN2YanEmNTx1mthAV6ggINhAL51c36khN3N+ynURDgCFRPH9X//zxASlEIwgU2feuJ7bjLxAPEW6apO4QduO2yv9ZYcW1PPV441uUDMOdpULTEmos+YbSE+Hm2tWIKrEoZZxYAM6M8DPQ8+cjxsq/rTJnJ3Zj/YlMYSQPHwPl+UxL1JK1JipltG3ML+VA4F/YUADSc8nJ4s1Q16+W2Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ2PR15MB5720.namprd15.prod.outlook.com (2603:10b6:a03:4ca::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Sat, 17 Dec
 2022 00:25:49 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5924.015; Sat, 17 Dec 2022
 00:25:49 +0000
Message-ID: <e87a43b3-3b8c-cd23-6563-9525f51982c2@meta.com>
Date:   Fri, 16 Dec 2022 16:25:47 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCHv3 bpf-next 2/3] bpf: Do cleanup in bpf_bprintf_cleanup
 only when needed
Content-Language: en-US
To:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Florent Revest <revest@chromium.org>
References: <20221215214430.1336195-1-jolsa@kernel.org>
 <20221215214430.1336195-3-jolsa@kernel.org>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221215214430.1336195-3-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0045.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ2PR15MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 5980e406-8eda-4bb8-fc5b-08dadfc53f56
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CNxXw8lZwnAnAbI7kjZNpj+5Zxdk3CJuVceVg8nd89FwkFe/wskLf5Y5YJPxA1veRZuqaUoNcjMtw0w5avBnp3TsjV0+jjWbvxbcH55i0GYPENTiPzy5WmnJBBjiNzGd8Epd+l2V6jcxRb+TQhJG+VwHFWWTulINs2w3+i0wvdikZXEzrKQ2hzk6gIh1MKqcrpMBW53LNOnl9zXucjjfi93UOqnRGIY2WeYGjzrrN6RzaYppEqT1R/VW08T8M9UoEGxGXmkMZ2cO9W3so+mX0Gih/wT1YGF7nLrQHOnH2ewnWJLejtaU18uimKAsxRhcz3MSC3ERxHXfvxEdoBCJhAd1YeQTJ3qNtT695oonHWqCWIBjd3n3lh4DqWCkGlWbQxmYMeh56wE9CDde5MXEPWajJztRSnoigsb/0EnGIOLLrrwW2m0iTcJLu6hQGtGWCjLyPQtpWytJL7noQauz2ju8oQF3o2cNp8vpTHrzyXQIFaxH3M00wE1vy4KvVPLdySHnaGQzncD6bN9EZ1Ve0PLwEZApdTdrah17f0am1oitDTMESmJ6uRPb8TOdnh6d9IpOn0uczpefOZ3azS06p6dy+ZeDNKlrQTFuUBmnctkV/uSWJNwM9Yq3b0BBgGpAkIAm8PIJ5uPCGjOjCOlrR2PSKS5hhhvA2eDg2MAMDeRcL975n+Y27QcLUtYQcr0fk9zdB4FP47jN8UFPQTqWeyA5B8BIo3U56a0d0PZ0VJA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(2616005)(31696002)(86362001)(5660300002)(2906002)(7416002)(4744005)(8936002)(66556008)(41300700001)(6486002)(6512007)(4326008)(66946007)(478600001)(66476007)(8676002)(53546011)(6506007)(38100700002)(110136005)(186003)(54906003)(316002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkJwR2QwVzJGZDM1Nkt3Rmcvc2hwUHRmZmlQOGdUb2NvbDA4V2RzZXB2QzJQ?=
 =?utf-8?B?Qm5HZHBobko1VzJBT3BpUjhZQ1BmNitya1EzbEh3Sm1KV0dPQ050Q0gwOWw1?=
 =?utf-8?B?WWVZNjBXbmxUN050RlFJOUMvc2lQVi9TMDUrTnJYYkVqMzJKK0dUQzBBaUg0?=
 =?utf-8?B?Y3pHNmRwSVVZWTM1UUhzdGhSc1dEWG5QWkFMbmhxRlk1S0JhMXFYN21LMTZv?=
 =?utf-8?B?U2x6MTBDUG1lUFlDeElEdVo0M01LelhHZWovYThSZGNSZXBzczY3N2pDbEtw?=
 =?utf-8?B?bWFDZXdiSVNHc0s4MmJVbXAra2tIQUlsRWVYVFczOHl2dWJQT2FMcmNHbnhR?=
 =?utf-8?B?KzNBY09FajcwNllqL2Jjb05xK2UxN0RnZ2EySG9EY3JOcmo2MjFQNTFEbWR5?=
 =?utf-8?B?UDRyMlNldU44V2dNRU8ycjRpMTFHMDBMeHlCUDBVTE0vUVpKOUxVNzlNTjlx?=
 =?utf-8?B?aStHYmZnd2djZ21JTzNiZGxpY0RWUHVvVFd6eDFSU3JpSTFRUkhJeUJvdTdE?=
 =?utf-8?B?dnVVcGNyWHlkeXFUcXhnU1lmNitUYzlpdjJuZ1lhTkV3U0FQeFBPWUh5b1hX?=
 =?utf-8?B?R3hpM1pFeXE1am9QM21TKzAxcW9TcnpIRTBKaVRqQWFTM1ZGR2wxZWtwNUo1?=
 =?utf-8?B?Z1JacWp0VGI0OGN6bVpORWV1VGhkclBnd1hKYlVtMTRybDNjb29zTjBPVHZG?=
 =?utf-8?B?SHpIVWphSUE3SksxRjNYL29CSHRWZ2pXcEt1TGFDekVSamZrNWw1SjRxUURQ?=
 =?utf-8?B?eE5EendKUk5kc3p2cjJmUUh5U05UOXp0Tnl4MzcxSmU0V2Zoc2d0eUZWODBU?=
 =?utf-8?B?UG5Uc3VxcGY1YWl3VU95MDZpQWhBVTdobU5EWWs2RFFVekhPd2VCKysrWGxD?=
 =?utf-8?B?ZnU4U3dCeFMzRVYvM00rU2sxVUZEK1gwWUtMVktJbDlGaWFNc1dLSkZtMU9p?=
 =?utf-8?B?UFZ3MU9oR0drVWkzWDJvWGdld1FmRDgrTm5LeTFoa2RKdFJqQWxnY3pYZDUz?=
 =?utf-8?B?Qkp6M2hZcEs1SzV2VXdxSlJVc01jeVovcmZZM2VDSGMwQmE1UDdONkk0RW1v?=
 =?utf-8?B?cWxsRDJBSGtEb3AvWER4djB5WExjdGlMTmVPRmVCRk5NSjUvbGhHTXNKeG5P?=
 =?utf-8?B?NWVFYkttelhUWVl1RmQzU2Myc0pyazlxVFlOTjZQUlRDeXhRZExONTBwaTBj?=
 =?utf-8?B?bXp5YVRXV3FmaHZGdlZMakVmK2p3Sk0yUVFZcjY4OXVsTUFIc01YZ3pTV2VK?=
 =?utf-8?B?elpnaTNWVzAxczlCQUpOdHgwY2tVeWtFalZCS0FSZ2FYZDNaN1prZXBPVUpq?=
 =?utf-8?B?eGtiT2RZTXoxclNId0x1bmgwZU90b0p1Z2o3MGRMcU5yUkFSSWlhbWQ3TTNZ?=
 =?utf-8?B?UWFualMzY3JETktNTzZjUTBRWElDNTE2Z0NZUjkzTTNXSndKL1BlOFQzUkxo?=
 =?utf-8?B?c0VId0tMOExISWJEN3lLak5JQVoraVpHQU5nb28ydTZrcVptaG1MU1crL1FP?=
 =?utf-8?B?aU1PNG5peElIR3BLN05nd1lIcGlGZjVUUFQrTW50KzNMZFlLM2gyZGxTcHN5?=
 =?utf-8?B?N2R4ai9TaHdJTnNzTkJwdnc4VE56QUlxWTlMcmlOMFJQc2dOUkNWZDZnOWZi?=
 =?utf-8?B?Wk95Q2NQbWZEN3d6NzRMZ2lReDZPSWpHSWJhYkk1WXhNRUhWM1FuNTJDdmlx?=
 =?utf-8?B?cEt0OXZicTYreC9ySlF1NWYyOU83bXJkOHBlMGo5VDVkQ0lEeTJkR2ltbGl4?=
 =?utf-8?B?WVB6dExaRDdFTWhQeGF6YjJKQUo4dkg5TlpTeTNyWjkzOXFOck5nTllDUGRP?=
 =?utf-8?B?ZFJRNThlN2xyc3VBSGE2TEgvVFY5eDhQNUNESW5MOGVUaWwvZE5BZlhZTHJE?=
 =?utf-8?B?YTBobmRGV3NzR1RnTnd1OXpJd2paSVJSM29LSjQ4QXFuWlp6WjkxK3hEbER6?=
 =?utf-8?B?SmZETGFkZVdOdHRVQnFnUVBlK2VtOTZua0FITENSZW9rNFFVTkVicXgyYk5t?=
 =?utf-8?B?WnpRdnRCYTJQcmVxOG5LRHVhV3lrbThvV01RMytOM1pwdlc0RWVhdURJc0pV?=
 =?utf-8?B?bXVTbjZVOHM0L3BUdGwrVy9UYTRmZkpPQkphVlJONWtBWXlyaDRuVFYxenZD?=
 =?utf-8?B?L2JYL0NVbzFNcG1RNWdFZG1OV21iTHE4NW1IQ0hYMGwxaDNUY20xQmdKSDU4?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5980e406-8eda-4bb8-fc5b-08dadfc53f56
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 00:25:49.1969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: To/hSQHgVWw33Vf8VFzrDA6WaL8QvA2XHWFncSwz+oTmrThlQ1EKaTXioNLoJAGK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB5720
X-Proofpoint-GUID: PahJSPrAayRFBlSy5OKCIhC782OWE89A
X-Proofpoint-ORIG-GUID: PahJSPrAayRFBlSy5OKCIhC782OWE89A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_15,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/15/22 1:44 PM, Jiri Olsa wrote:
> Currently we always cleanup/decrement bpf_bprintf_nest_level
> variable in bpf_bprintf_cleanup if it's > 0.
> 
> There's possible scenario where this could cause a problem,
> when bpf_bprintf_prepare does not get bin_args buffer (because
> num_args is 0) and following bpf_bprintf_cleanup call decrements
> bpf_bprintf_nest_level variable, like:
> 
>    in task context:
>      bpf_bprintf_prepare(num_args != 0) increments 'bpf_bprintf_nest_level = 1'
>      -> first irq :
>         bpf_bprintf_prepare(num_args == 0)
>         bpf_bprintf_cleanup decrements 'bpf_bprintf_nest_level = 0'
>      -> second irq:
>         bpf_bprintf_prepare(num_args != 0) bpf_bprintf_nest_level = 1
>         gets same buffer as task context above
> 
> Adding check to bpf_bprintf_cleanup and doing the real cleanup
> only if we got bin_args data in the first place.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
