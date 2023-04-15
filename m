Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBAE6E3384
	for <lists+bpf@lfdr.de>; Sat, 15 Apr 2023 22:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjDOUYu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Apr 2023 16:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjDOUYt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Apr 2023 16:24:49 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9BA358C
        for <bpf@vger.kernel.org>; Sat, 15 Apr 2023 13:24:48 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33FJxZQT006831;
        Sat, 15 Apr 2023 13:24:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=1bOC1KuB6rgsPXmwD1o80VBi3THyj1Sqi7QI5eelIhA=;
 b=kBszmBOtYFRpXaACxh1Njg7b0UKyJtj7kCQcH2uunjc9ng0zW5FtQgjRz6PPHF+Q2A5k
 7BsM3Ic/S+GyBovy8KxJcIAioWEDwpSsTDFq8mN100foW28fgPt5YjURsWLlku6R16lx
 bL13o3YYvyemy7S1x1TGcNfup9xhHR/8C3wG+Oikg2nybN936X/CjcI93Mv4EYobLuiw
 +5PGtAbRXoesVFqbpXWA7Fd4JEVvlr/tDh6iL4koT64PXt5fv7cfYASeK+mR4CcIJrDh
 pi3DpjQRrZcLWP4e3wX2MkyY+wSIsQGuZiVlU94YWvfcLRkUvk9mf/TZaGU8VI96hoqI Vw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pysp2sqcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Apr 2023 13:24:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XT8STT/GfA5hUJjZ4Q0tYhqWIv6xvZBPbFK9C4FUftMyOXdgJZmEQ7g5A+IkN7jiWBYmLSLHgjU7wZXHhtSeSs7EaBgAhS9jDmz0hIEc728qxquXSOTAWfgfTN9NLp7qC1Vq/Xx+d5NInIVH4PPrr1u+Ap9edMH6in7IXucameie7sA7Ltjr4AZ891NYR/+Z6xPb1CDri+icQmn8pUDZQSmslnE9XJExWU81jXaDyso9FdM4e3FBa7k8fGJ2BAdJBD0yzdSouSe8M1cHAxvmnWkI4wk/Gplsv1ec7PcfuGy0fxANUrZXzfbIRgHDMv5ijAIRlHHiEupPqALndqsMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bOC1KuB6rgsPXmwD1o80VBi3THyj1Sqi7QI5eelIhA=;
 b=gvEkAzwvTva4iKLL31CALirzDEV/wZ7bRnfMxUlu6GdQOSdCJygoip+vFOlsX2ZQUFpoeNUD3LLk88Y8rF99+t1LR+WOu99oeUF2RQdQahU9Hbrlp6UUSMcO5UuLLu2ojtHNQ3R1T1jN7TPjSXBzO3BCTAOZQu2Z4KbjBZFFE6zMqQeqLyQjesO1phR1bsQTcyHozpii2K+64ML4Tcdm2xADECUX4L175O0OTiwEu5su1E0/MKLkeUQZaUDmXlIovbQ3fcocQs1PyYKUPoOSpNeoPyG5ssuBC5Gw/FIB7VuXVk8j1fnyXqOUr4/F0P4COsTvVYHpJWPg86cJBH52Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20)
 by CY5PR15MB5438.namprd15.prod.outlook.com (2603:10b6:930:3a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Sat, 15 Apr
 2023 20:24:30 +0000
Received: from SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::b26d:c096:654:edd3]) by SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::b26d:c096:654:edd3%7]) with mapi id 15.20.6298.030; Sat, 15 Apr 2023
 20:24:30 +0000
Message-ID: <b9360db2-c59b-e065-ea9d-0bff83288e3f@meta.com>
Date:   Sat, 15 Apr 2023 16:24:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH v1 bpf-next 9/9] selftests/bpf: Add refcounted_kptr tests
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20230410190753.2012798-1-davemarchevsky@fb.com>
 <20230410190753.2012798-10-davemarchevsky@fb.com>
 <20230413230805.kpjefr76emo7pc43@dhcp-172-26-102-232.dhcp.thefacebook.com>
Content-Language: en-US
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20230413230805.kpjefr76emo7pc43@dhcp-172-26-102-232.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0053.namprd19.prod.outlook.com
 (2603:10b6:208:19b::30) To SA1PR15MB4433.namprd15.prod.outlook.com
 (2603:10b6:806:194::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:EE_|CY5PR15MB5438:EE_
X-MS-Office365-Filtering-Correlation-Id: 331637e0-29b6-4e5c-912a-08db3def6b0d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A6e1KaqAOMI4kGH2F5vYqwt0pofJcAOSZRa6rAI7Vci4WUcz0jlAX0dtwSwwwgNNlgqv07YT72xCcpzB3ljGGuvv3BZk1ptj85YobIIvIPoOU6tFmgniYFcL9f98tTowo8aEHCRbR2QkEdUljiwf+P7NWAxU45VmhqSz6YRbsQCtDDK2CWJZlmIU+L2Kzi1OjL/4Jeu+sAdjDeuR+lcHC5UiMsowo3UrXS4FjhKYfYZ/HpziFCs154B4UfwBSHxEwsUnOzgAkqUbWKhdTu0uS5KEL6XdiEALUBiyVM9flInhspvRPAIPXnOxkCE1prRW5ZQQ7YDjngWgIQROWEL3qOr7tcYCGRr50TFWRvSqGTU9sm99RNZYcVv3t4RiCxCirobqTDa7j1gfyKFakpIP6uw/kZiKN6YrN0Gd0NTggO8J00YX9NfBQ+e6XFFtublCtaIcR2aRmZngVoHruB9c8yZI5dyD0M453+vOdybdiq9s6M1xu8R4VWBW6uGSKOmCkVWUEazxzv0PzGnhkEqC6+XQFoK07Jrgrbf7qWzfTpEpEJfPFCsRPZgPk/1+EsrPpEMYqbFfyTUxQBblecCo6xZwvXCjfo5XgVQcMifUibkna4b+kDFVf5lW+b10skcScFmUohTbOo242ZRGyydH+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4433.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199021)(2906002)(31686004)(8936002)(478600001)(8676002)(5660300002)(41300700001)(316002)(66946007)(66476007)(83380400001)(36756003)(66556008)(54906003)(4326008)(110136005)(6506007)(86362001)(38100700002)(186003)(53546011)(6512007)(6486002)(6666004)(2616005)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU1qUkJ0WFBudS8rTStIQWRxcGh1VkpWV3EvSHpsSXNmakhuWEFsMVQyOUxP?=
 =?utf-8?B?Rkh0ZVNndHM3bk9VNzRnRlRjeWJEdUZMZzkrM3hteVp1d1RHSzZHT3JyRWxx?=
 =?utf-8?B?Q0VmZkJEd3RXb05rYzU1WGFPMFhzNnQvWjRkWWhhaWJvQU0vdmpnMjRtWVp6?=
 =?utf-8?B?MUMxdVc3K21jR0hqWU5xTkpsczNHOUhwZmkrcFhBUitOcWZjOUlvTS9qSkJt?=
 =?utf-8?B?bWZZa2NTeXU2QXhMVnhTdG52Z1YvYmx4aWxtQW4rRmpwRmlIWlI5VDhpNmFZ?=
 =?utf-8?B?Qk54QVc4SWtHOEFnY1FtekV2a3pYZW1RREV4ZDhLdVYyaTZpajNMTEhNT05X?=
 =?utf-8?B?R0NieVFxazlGTnEyR3dmSThkM1U0bHpjNDFBUW96MFBlYzVpU05yQkJsMzhW?=
 =?utf-8?B?Yi93OHBucmFrQ25vSDNEbC9pWTRRWTRyRWhGTUlMZW1sYWxGbC9WUzM3Nkg2?=
 =?utf-8?B?YkRBT0hKSUpVWGt6UWd2U1VPa1NjSk9qUnVNUFY4LzNqQUJITWpvL3RVNDU1?=
 =?utf-8?B?UUZlRE4zeWU4OUllUjJzMG4zcm14TUhQWUR2eVlzZ25IbnRhUUtGZWd3OWVK?=
 =?utf-8?B?cURJUUFpS2pFNnAyNDJtTmVkSGNlVnN0MHZyVWF6OHNyZkQ0Tmw0Z1I3eUp6?=
 =?utf-8?B?U09rRzRvcTgyaHQ3THV2dEFQTDFBUzU4SVI2eGxsRGg3K1QyUFh6aTZTSjh4?=
 =?utf-8?B?eTNzV0E1V3FhZkZjTlYvT20wNFlLVWJpUjBDeCtkNXBVajNmam1pSFlSb3lv?=
 =?utf-8?B?SEVvTjVNTHVCa3o4VTJsOERVU2RWdFdySmZFa0FPZ2J4M2NMYXJDMVozZjBi?=
 =?utf-8?B?b0RRc1d1cDk5bFpyem5ZSFE4cWxvUlRMQ3BzMThOYitJZkE5TE43ZUJ4RjMz?=
 =?utf-8?B?dlIwU1g0WFlFM1pvelNtOFllbXI1TytsZExwZmdIVHZ6RWdUS1k2WkxIY3hy?=
 =?utf-8?B?aEthNW5GSDBrak90NXNjRVFjZjEzSTR2WUpyOVlKWnpLb283OElwNzJ6NU40?=
 =?utf-8?B?ZDVjZU9PU3cxcUhPNEhPeDk2SktZbzR1Vk9yZ0thdmtRWXZLT2tBdmk0SjNt?=
 =?utf-8?B?UDR2R2pKb0poS1ZSVGNJOVBJK0g1NW9KenBWSXhyMUpHK0xoZmZNamVXbGxU?=
 =?utf-8?B?UjFmTDR1VG5KbjhuTFVveng2VGJOSWlYOWs5Z0g1WllkVmJYQUVFZUV6QnZa?=
 =?utf-8?B?WmFLRmRreXhrS2I2d0gvZ08raExNUVJVTGx5UVZ3OHVNUXVOTnhEV3J0aXlu?=
 =?utf-8?B?N2puQmVQV2pWaGlUS3NiVzFtU2tyRS9Zd21Vb1VvUVR5SUhxeHZvL3VPV0Vv?=
 =?utf-8?B?Y0tveFlBbGQ5dVFHRHhoTnYwbkphT3pJUC9BL2tUcU5WUjhIQm9yZDJubTcv?=
 =?utf-8?B?aVJtTkxqR2ZHcm42dk5sY1dJWFFpZGlOY2RVV0h1bEhHdGlNOHo2dXJaVFEw?=
 =?utf-8?B?MVN0b3d4S2RuQTB0L05rdXJnM2NWNjlVRVRyTTNwRVlqRWM4dGZMOUREWFBZ?=
 =?utf-8?B?NGtGZkF0bGJ6dSthcGdia095cUkydFNnOW1kY0QvcnYwQ0tuR0J0cjdlSmtt?=
 =?utf-8?B?Z3pLbUQxTU9LZ1VhSDA0NDV3NEx0Z0JleTgvMi8wNlUxVDVpODd6bFVIN3dm?=
 =?utf-8?B?TWZ4SVVPUndhc0hIY3dWeEpHb2xhbXlxNmErOC8xY1ROWFBrV2t2RHJ0Lzg4?=
 =?utf-8?B?MkJXYk1XL2RudDJpb3hCclRpcWZ1V0JqcjdFallDdnRPakFIbmJMdmUvdTJ0?=
 =?utf-8?B?RUN4dXNnZGMwVnUrZzhyTGFIOCtsOGpLYk44MWt5NndVWDArVzVVa29MR0pj?=
 =?utf-8?B?SnlsekI3VnllR2hzdmw5UVVDVHpFejdsbENrQVpLYkJCUEhLNHk3VHp4eGNv?=
 =?utf-8?B?YU5KVmQvdTRvZTdUOS8ycVNYTnIySjJQcjN1eFZRZ2FjN0E3U2lZVGRYejk2?=
 =?utf-8?B?b1ZQR1BVUVBMSU16WGQwS0NOcnFGZGg2RVB5V29nSFFVUnZQT0Fyb2NaejlL?=
 =?utf-8?B?Z2wyT1dqWm1DUkJqKzJZVnhCaUdpRm1QR1ZmUXY3cWxlR1dveUpVdkozVEtR?=
 =?utf-8?B?TlloZTZLRUJONFBtaEFxdDRPQS9YM3BvNUcweXNpN2hLZjUwWVZEZjNFZkhx?=
 =?utf-8?B?TXZLWlRyNTlVdlBSa3ltUDg1ZXp3b0tKd29FSmNyUzlQSVhwTGJQcjFWcktj?=
 =?utf-8?Q?zXdJW6WFjFMhr86kEUTiyE4=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 331637e0-29b6-4e5c-912a-08db3def6b0d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4433.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2023 20:24:30.7917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gbHbDbZqv4bn9TiP3XzqSDt4NcrNimqEIrN9TeZhQHWbBWbgJ4ibiH1Em4RX9rMd903Qx+x7IjxW7LrdnNqxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR15MB5438
X-Proofpoint-ORIG-GUID: vfoiq7D0nB3Baf13Y6fqtyngf_iVNG-U
X-Proofpoint-GUID: vfoiq7D0nB3Baf13Y6fqtyngf_iVNG-U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-15_10,2023-04-14_01,2023-02-09_01
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/13/23 7:08 PM, Alexei Starovoitov wrote:
> On Mon, Apr 10, 2023 at 12:07:53PM -0700, Dave Marchevsky wrote:
>> Test refcounted local kptr functionality added in previous patches in
>> the series.
>>
>> Usecases which pass verification:
>>
>> * Add refcounted local kptr to both tree and list. Then, read and -
>>   possibly, depending on test variant - delete from tree, then list.
>>   * Also test doing read-and-maybe-delete in opposite order
>> * Stash a refcounted local kptr in a map_value, then add it to a
>>   rbtree. Read from both, possibly deleting after tree read.
>> * Add refcounted local kptr to both tree and list. Then, try reading and
>>   deleting twice from one of the collections.
>> * bpf_refcount_acquire of just-added non-owning ref should work, as
>>   should bpf_refcount_acquire of owning ref just out of bpf_obj_new
>>
>> Usecases which fail verification:
>>
>> * The simple successful bpf_refcount_acquire cases from above should
>>   both fail to verify if the newly-acquired owning ref is not dropped
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> ---
>>  .../bpf/prog_tests/refcounted_kptr.c          |  18 +
>>  .../selftests/bpf/progs/refcounted_kptr.c     | 410 ++++++++++++++++++
>>  .../bpf/progs/refcounted_kptr_fail.c          |  72 +++
>>  3 files changed, 500 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/refcounted_kptr.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
>> new file mode 100644
>> index 000000000000..2ab23832062d
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
>> @@ -0,0 +1,18 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
>> +
>> +#include <test_progs.h>
>> +#include <network_helpers.h>
>> +
>> +#include "refcounted_kptr.skel.h"
>> +#include "refcounted_kptr_fail.skel.h"
>> +
>> +void test_refcounted_kptr(void)
>> +{
>> +	RUN_TESTS(refcounted_kptr);
>> +}
>> +
>> +void test_refcounted_kptr_fail(void)
>> +{
>> +	RUN_TESTS(refcounted_kptr_fail);
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
>> new file mode 100644
>> index 000000000000..b444e4cb07fb
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
>> @@ -0,0 +1,410 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
>> +
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_tracing.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_core_read.h>
>> +#include "bpf_misc.h"
>> +#include "bpf_experimental.h"
>> +
>> +struct node_data {
>> +	long key;
>> +	long list_data;
>> +	struct bpf_rb_node r;
>> +	struct bpf_list_node l;
>> +	struct bpf_refcount ref;
>> +};
>> +
>> +struct map_value {
>> +	struct node_data __kptr *node;
>> +};
>> +
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_ARRAY);
>> +	__type(key, int);
>> +	__type(value, struct map_value);
>> +	__uint(max_entries, 1);
>> +} stashed_nodes SEC(".maps");
>> +
>> +struct node_acquire {
>> +	long key;
>> +	long data;
>> +	struct bpf_rb_node node;
>> +	struct bpf_refcount refcount;
>> +};
>> +
>> +#define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
>> +private(A) struct bpf_spin_lock lock;
>> +private(A) struct bpf_rb_root root __contains(node_data, r);
>> +private(A) struct bpf_list_head head __contains(node_data, l);
>> +
>> +private(B) struct bpf_spin_lock alock;
>> +private(B) struct bpf_rb_root aroot __contains(node_acquire, node);
>> +
>> +static bool less(struct bpf_rb_node *node_a, const struct bpf_rb_node *node_b)
>> +{
>> +	struct node_data *a;
>> +	struct node_data *b;
>> +
>> +	a = container_of(node_a, struct node_data, r);
>> +	b = container_of(node_b, struct node_data, r);
>> +
>> +	return a->key < b->key;
>> +}
>> +
>> +static bool less_a(struct bpf_rb_node *a, const struct bpf_rb_node *b)
>> +{
>> +	struct node_acquire *node_a;
>> +	struct node_acquire *node_b;
>> +
>> +	node_a = container_of(a, struct node_acquire, node);
>> +	node_b = container_of(b, struct node_acquire, node);
>> +
>> +	return node_a->key < node_b->key;
>> +}
>> +
>> +static __always_inline
>> +long __insert_in_tree_and_list(struct bpf_list_head *head,
>> +			       struct bpf_rb_root *root,
>> +			       struct bpf_spin_lock *lock)
>> +{
>> +	struct node_data *n, *m;
>> +
>> +	n = bpf_obj_new(typeof(*n));
>> +	if (!n)
>> +		return -1;
>> +
>> +	m = bpf_refcount_acquire(n);
>> +	m->key = 123;
>> +	m->list_data = 456;
>> +
>> +	bpf_spin_lock(lock);
>> +	if (bpf_rbtree_add(root, &n->r, less)) {
>> +		/* Failure to insert - unexpected */
>> +		bpf_spin_unlock(lock);
>> +		bpf_obj_drop(m);
>> +		return -2;
>> +	}
>> +	bpf_spin_unlock(lock);
>> +
>> +	bpf_spin_lock(lock);
>> +	if (bpf_list_push_front(head, &m->l)) {
>> +		/* Failure to insert - unexpected */
>> +		bpf_spin_unlock(lock);
>> +		return -3;
>> +	}
>> +	bpf_spin_unlock(lock);
>> +	return 0;
>> +}
>> +
>> +static __always_inline
>> +long __stash_map_insert_tree(int idx, int val, struct bpf_rb_root *root,
>> +			     struct bpf_spin_lock *lock)
>> +{
>> +	struct map_value *mapval;
>> +	struct node_data *n, *m;
>> +
>> +	mapval = bpf_map_lookup_elem(&stashed_nodes, &idx);
>> +	if (!mapval)
>> +		return -1;
>> +
>> +	n = bpf_obj_new(typeof(*n));
>> +	if (!n)
>> +		return -2;
>> +
>> +	n->key = val;
>> +	m = bpf_refcount_acquire(n);
>> +
>> +	n = bpf_kptr_xchg(&mapval->node, n);
>> +	if (n) {
>> +		bpf_obj_drop(n);
>> +		bpf_obj_drop(m);
>> +		return -3;
>> +	}
>> +
>> +	bpf_spin_lock(lock);
>> +	if (bpf_rbtree_add(root, &m->r, less)) {
>> +		/* Failure to insert - unexpected */
>> +		bpf_spin_unlock(lock);
>> +		return -4;
>> +	}
>> +	bpf_spin_unlock(lock);
>> +	return 0;
>> +}
>> +
>> +static __always_inline
>> +long __read_from_tree(struct bpf_rb_root *root, struct bpf_spin_lock *lock,
>> +		      bool remove_from_tree)
>> +{
>> +	struct bpf_rb_node *rb;
>> +	struct node_data *n;
>> +	long res = -99;
>> +
>> +	bpf_spin_lock(lock);
>> +
>> +	rb = bpf_rbtree_first(root);
>> +	if (!rb) {
>> +		bpf_spin_unlock(lock);
>> +		return -1;
>> +	}
>> +
>> +	n = container_of(rb, struct node_data, r);
>> +	res = n->key;
>> +
>> +	if (!remove_from_tree) {
>> +		bpf_spin_unlock(lock);
>> +		return res;
>> +	}
>> +
>> +	rb = bpf_rbtree_remove(root, rb);
>> +	bpf_spin_unlock(lock);
>> +	if (!rb) {
>> +		return -2;
>> +	}
>> +	n = container_of(rb, struct node_data, r);
>> +	bpf_obj_drop(n);
>> +	return res;
>> +}
>> +
>> +static __always_inline
>> +long __read_from_list(struct bpf_list_head *head, struct bpf_spin_lock *lock,
>> +		      bool remove_from_list)
>> +{
>> +	struct bpf_list_node *l;
>> +	struct node_data *n;
>> +	long res = -99;
>> +
>> +	bpf_spin_lock(lock);
>> +
>> +	l = bpf_list_pop_front(head);
>> +	if (!l) {
>> +		bpf_spin_unlock(lock);
>> +		return -1;
>> +	}
>> +
>> +	n = container_of(l, struct node_data, l);
>> +	res = n->list_data;
>> +
>> +	if (!remove_from_list) {
>> +		if (bpf_list_push_back(head, &n->l)) {
>> +			bpf_spin_unlock(lock);
>> +			return -2;
>> +		}
>> +	}
>> +
>> +	bpf_spin_unlock(lock);
>> +
>> +	if (remove_from_list)
>> +		bpf_obj_drop(n);
>> +	return res;
>> +}
>> +
>> +static __always_inline
> 
> Why __always_inline in this 5 helpers?
> Will it pass the verifier if __always_inline is replaced with noinline?
> 

There's no good reason for __always_inline, I cargo-culted it from linked_list
test. Both replacing w/ __attribute__((noinline)) and having neither results in
passing tests, so I sent v2 with the latter.

>> +long __read_from_unstash(int idx)
