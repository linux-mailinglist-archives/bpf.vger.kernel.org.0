Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C036E542D
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 23:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDQVzb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 17:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjDQVza (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 17:55:30 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522EB3580
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 14:55:29 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HLIsXS013091;
        Mon, 17 Apr 2023 14:54:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=sv2j5DIZBjrB6cDq7lJEg7LRujUv2l8zBBkGneiNQD0=;
 b=WhjxWfFM457ad9eJ1hG4Jl7Yol2YizK2t7lPUg8Bz0qyE5qTZCLwfwbm5TjyZWclJw+Z
 ofEuywx8TgLXGDiDntntiCNHqRlFbkFnIi64hj/no7wPHpCvulxzod6t1X4IFvuqtKTi
 qu0QzPuw67L+r44wt2QFHKrxAhVIqqCthurHsnXPF/nMQD9Fo7IFOUuHbKoLXHlW/6a6
 xlCorglg7h2JetRP21NQe/0YcGhjIdr7k2PWkrl3woxCWW6rz1sUmQSundSMPol+HBL2
 i+rp0NMQ+MXX4MwZfvdvLDca7JdvkVEnqOHPdWAXmsNWPJT5lrmDrRyn8O0bcGb9D+I2 BQ== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pys22c6pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 14:54:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M67lMBH91FLcmbnZNp4rCiwlr6fCKMwc4K6TP2SpbzrGcO1MAyfod+YyPvaktr5nQul2W6mLCIF/y1nNcK65EKi/jTqB49hHDrH+6+ft62n2GRn+X26tGNfv8A3mAQtAU50nTvdPgLLAlqQreUThSEcBjNJy/3B9y7qZBqtCbwHKdYLqletUcKw9aFODXPF3rU2G0VmabnFrMsmCApahoIxlE7R5Wb6y5wL6+Hx8NKMaaH832T1Y07livDJIpP/C3adQWgFHK9/tIxP85CUIme0iCcHR7lco8vVZXUK3K63Ik6XiENmdP+a9mlQ79jn365QLECkaP9k2k3iyscaXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sv2j5DIZBjrB6cDq7lJEg7LRujUv2l8zBBkGneiNQD0=;
 b=AcN+/Di6sGbflweRxqGerfx5MCU0KVyogPFIzBmu/DQRqHx0YSMXSYzKhnEDBtxJiVKEGnt5cgXuWtnDH7pAV+PLwYj5D1clr5B8qpmT4F+UkjtFU5yRCZbGdJNic1GZMm6bfW7Psh4cA6BwWs2V7yf/3DQpnOcHzyEtfBpgbiW09Qi8lxVqZde/DlvibNxJfWGFrhoBNslXYKuPP1CbfZkS41C8ITTXxZtCPvxS+t1ExX/ceT3SVYNPBf2FpGz1UKmMnz2FY8YyAoyrM7rgD2tuca0vYEtxusuFCJWeHv3q8VwTvz37Jgvz659a5fZBLxRdqxOX1cNs+gI7BHZj/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DS0PR15MB5549.namprd15.prod.outlook.com (2603:10b6:8:132::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 21:54:49 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 21:54:46 +0000
Message-ID: <3bb62b4b-9913-6f86-43fa-205921ecb1ab@meta.com>
Date:   Mon, 17 Apr 2023 14:54:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add a selftest for checking
 subreg equality
Content-Language: en-US
To:     Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20230416232808.2387432-1-yhs@fb.com>
 <20230416232813.2389072-1-yhs@fb.com>
 <f5fadb2274b4e7ddf09a6e6e65a92fed05be4169.camel@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <f5fadb2274b4e7ddf09a6e6e65a92fed05be4169.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DS0PR15MB5549:EE_
X-MS-Office365-Filtering-Correlation-Id: 12952988-f7a3-4d58-7b27-08db3f8e5bbb
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2QDYuDZ5GwFOIx/IL+dzXdCiw2XWuTizsIKJ8mKznGhb9NrcDFx6GW+PYCfnkyPWaLtLq3NLjejahG6qlbBa8T+2EnqqPNmFghOXGzikghAMdGEcVkbzDZ85agNfdeB+jukChkYNf5a9+1JtdKBRy+j0UTbAZq7B7mBNU/kF19TJ5+uNNmJCY6O1qHjAWAT60T7N7uwK/Pj8jAFlLVnkyHUclXGPuckf4l/H2rluDcqaAWWhNq48Nji01lvC/EXUlTgebZHR5Oq/p8H8xCgWHgLqcbG6C7HB5eZ5mbiuqpIoe4giyzF9TJhG1MhU401CKWQd0pZWuoCDx/LwyWlglH0GiNZ3nugR2WtUNxXNf5QHJn1SYB2XI1U81pybZBGa3tLVmnRoab1b88d+lrxWp3uEIDxQLt42bughtuolScoa6oVeHNxR1oerGYoXVDMUxFaOkrIdzHt37rllAXTz91WbmzWoezfLoDsg4Y4a9ElVhnNmig1LWpNySBRVGKhBgeCprv8AZfOmHJbvP2r40/GhqXl02K591WAuI1XBxk2C0t3ygpA2A1kLuSOeO9iHMWoKCbFSnrfhT9M7WqmhXidGa4laiMXPF60892vZGzgSAnSXBZiidjZazpeN0bT9LOnHUwGLbpTRjDgE/1T4Yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(316002)(110136005)(38100700002)(54906003)(36756003)(186003)(2616005)(83380400001)(478600001)(6506007)(53546011)(6512007)(6666004)(6486002)(8676002)(8936002)(66476007)(66556008)(4326008)(66946007)(41300700001)(86362001)(31696002)(2906002)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlpUdmhzRVVhUjUzYzRnc2NXQmdyM0VqWmU2cWdoSFoxaFd0WkdBcDYxWFRC?=
 =?utf-8?B?dzJHSWdMZVBVTUc4ZHdkQWlIQzR5WmNUMjVKWFNISXA1NkJyWDdRUS9LV1Ri?=
 =?utf-8?B?NTRFWVpLOXJyQkxLUWVqcXluU2E2a0ZIdCtqUWxnUjR6akhzS3dUQWljZktO?=
 =?utf-8?B?NkZFMjVhOU9qUjNjSmVwck5iYmcwRDhpQmEvN2xlU0lYeEd3SmVkUkQwM0pY?=
 =?utf-8?B?UDlrb0RLeTYzSGhnU0xMSXVoRWNLUFdBdENnK0VWYktJaUFrQkJOeFhZUTJM?=
 =?utf-8?B?UjhkNGRUZnk0WGpiVzJkMDU1b3N5bDh6KzBqR0dpaTNhS0d1T0NDd0M0UjJT?=
 =?utf-8?B?MG1zZVJQNUk5dHdWanR3WXQ1dXRranlrc1NjOUNReHhvaHVsVDZJTVZSVXI4?=
 =?utf-8?B?Z0pQc012TkJ3aFAyUEtkWnBSVjY5N2NUWG9aOGMzS3JkTXFVbVJnekttZlFS?=
 =?utf-8?B?THEwOENUTWhQZkx3WDY1T3lKR2RxejZ2d09va3pyUnl2Q2R5Y3I4eHhwTU1X?=
 =?utf-8?B?M0wzc3hwaUVKemtVQjRNTlVteW5hS2hNSGZwenVDVXpyNEdYTHJlanJzSWRz?=
 =?utf-8?B?NE1aTHFzZTlidDlzT2treDF0ZExKa0FXOXNZNUh5RHllMjV4eGkrOFN6L090?=
 =?utf-8?B?SEN5QWFwMDlIVEsyUXp3TXdrSUVoMG5qZno3UEdqcG1nemxxNlF5Ly9NeUpo?=
 =?utf-8?B?N21oZDNFMkNpUENRcEJMM0FsN29Tc0lOd3N2OURrTEdxR3RJQTZKM2licXV6?=
 =?utf-8?B?c2U3cVBlRXY3R2JpZkdzZzJjam04WHRzUFp1NjgwSnJ2UEx6bm5zTHZMQmRM?=
 =?utf-8?B?UVJJZndqOHQrL3l4cGhaeFhhRkEzZDhEM0E0ZTZmU0w1RnhiWjliZXlSMmU1?=
 =?utf-8?B?ZEdaT3JJVFQ1d0hmWXpvbWhDWlBLR21WWTBtb2FYZGRwU2t6eVZ1eHFLdnV5?=
 =?utf-8?B?aGg5cUZuOEpWeDhlbDY4Wm9tUlMzWUYvWXVndlRSNmtjaU5mUEI4VDNFT2VP?=
 =?utf-8?B?UTRybXplaitXZHR1SUM4SURSSWRaaFhTK25oZmp1K2ZLZUdQckE5L1VjQW9x?=
 =?utf-8?B?dFYxamNJR1R1VnFndTdUVksrb3JxZU80b2xQYVJ6Y1gvWmlUWWEwYVdQN3BE?=
 =?utf-8?B?QlZOZHFPZDFueVZqeXZ1N0xFUHJSZmR4Mlg0MEdjZDRJc2ZEbyt5M3lGVk1n?=
 =?utf-8?B?UzZYa3FVazU0NEFNVzJialNINHN2RlIwUWtCLzVBOCtueW9DR0R4VkFVMHhz?=
 =?utf-8?B?ZWFBVzg3ckZEQ1Y4bE1HSFk4azNBWDZCL01IRGI2dm1nckV3V1J3MkpTbC9x?=
 =?utf-8?B?UDRPeVRWbVU5aW5LdXJoamJNdnlJWnhtM1I2cW5OamFQbVMrY3ViNTdrMnVP?=
 =?utf-8?B?U1JPRTJLblFsSlRUczJHcW85bWRkQ0F4VldNMVNMaGlLMDJtaFl2L1Y4WDl0?=
 =?utf-8?B?ejQ4cW1BWVMydkJScEFkTnBoLyt6dDN4TWNJRm1FZVV1MmhGajRYSEdtV25i?=
 =?utf-8?B?V1Nqb25ESzVXMndkckZSS0hwMk01Mld4eEFDbGVjcGZtTzhGZlJPdHBwU1VO?=
 =?utf-8?B?cnZ2OHdqQ084a0oyU3d5Rmk0RXU5QmlORzBTWWwzcHdVSVVhMTJVa1VXbmU1?=
 =?utf-8?B?TXRoZlo2RzhINjM1b0orNklYb3hxNEtibTRoc1JDNHROdTVRSDd5NTltZ1hQ?=
 =?utf-8?B?N1VQTDhiNmtiVy9aVFArd0IrNUdDMnhOaEEvTDFpaEthNjJBTTlweXVGenV0?=
 =?utf-8?B?N2p5R0xkaUdsS0sxbjZzaFFlQlZ3TnRjQnZDQVJ0elpwanpJM0U5SlZrUjVk?=
 =?utf-8?B?TUhNaGZrZVBnb050TTl3ZEc4ZExrVTg5V09qb1AyRURaUk1aWGtEV0F5Q0Jq?=
 =?utf-8?B?L004RXdXMExPUUFnVVJFVXpqR1h1NGlORGhKU29MNlprY0pWbmlhci9VVFpv?=
 =?utf-8?B?dEdZck9JVXZqZlZkc25SUm9yRnJyMFk3NGxudlh0VlRwM2dYVjBKWlNmbzBD?=
 =?utf-8?B?VWxId2RFRlpYYkdFRXd5aGczVjFMWVErSm1iK1ZZb2ttN2EyRVJHSmx3SUFS?=
 =?utf-8?B?bjNOcWxCc0ZXT1VSYzVUelg3RkVITXdxcVlraXBTcVUzM2hjSmF0YjZTcnFC?=
 =?utf-8?B?Mzd0bHpnMytaTWpVRTY4UGZIbEZQVzNKeXlodHlodHRXQmo5Y3ZUVlE5NTVj?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12952988-f7a3-4d58-7b27-08db3f8e5bbb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 21:54:46.2817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAXpNPXTzFrijKOat1gmAecrMPxMYs7YamFzioiNUgPtUc3gZZwJYuT4MJC6Klch
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5549
X-Proofpoint-GUID: _RZcl-6tvAuFQ7XhVlw32qECeEPjybM_
X-Proofpoint-ORIG-GUID: _RZcl-6tvAuFQ7XhVlw32qECeEPjybM_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/17/23 10:52 AM, Eduard Zingerman wrote:
> On Sun, 2023-04-16 at 16:28 -0700, Yonghong Song wrote:
>> Add a selftest to ensure subreg equality if source register
>> upper 32bit is 0. Without previous patch, the new test will
>> fail verification.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   .../selftests/bpf/prog_tests/verifier.c       |  2 ++
>>   .../selftests/bpf/progs/verifier_reg_equal.c  | 27 +++++++++++++++++++
>>   2 files changed, 29 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/progs/verifier_reg_equal.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
>> index 73dff693d411..25bc8958dbfe 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
>> @@ -31,6 +31,7 @@
>>   #include "verifier_meta_access.skel.h"
>>   #include "verifier_raw_stack.skel.h"
>>   #include "verifier_raw_tp_writable.skel.h"
>> +#include "verifier_reg_equal.skel.h"
>>   #include "verifier_ringbuf.skel.h"
>>   #include "verifier_spill_fill.skel.h"
>>   #include "verifier_stack_ptr.skel.h"
>> @@ -95,6 +96,7 @@ void test_verifier_masking(void)              { RUN(verifier_masking); }
>>   void test_verifier_meta_access(void)          { RUN(verifier_meta_access); }
>>   void test_verifier_raw_stack(void)            { RUN(verifier_raw_stack); }
>>   void test_verifier_raw_tp_writable(void)      { RUN(verifier_raw_tp_writable); }
>> +void test_verifier_reg_equal(void)            { RUN(verifier_reg_equal); }
>>   void test_verifier_ringbuf(void)              { RUN(verifier_ringbuf); }
>>   void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill); }
>>   void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_reg_equal.c b/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
>> new file mode 100644
>> index 000000000000..91e42dec89ad
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
>> @@ -0,0 +1,27 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/bpf.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include "bpf_misc.h"
>> +
>> +SEC("socket")
>> +__description("check w reg equal if r reg upper32 bits 0")
>> +__success
>> +__naked void subreg_equality(void)
>> +{
>> +	asm volatile ("					\
>> +	call %[bpf_ktime_get_ns];			\
>> +	*(u64 *)(r10 - 8) = r0;				\
>> +	r2 = *(u32 *)(r10 - 8);				\
>> +	w3 = w2;					\
>> +	if w2 < 9 goto l0_%=;				\
>> +	exit;						\
>> +l0_%=:	if r3 < 9 goto l1_%=;				\
>> +	r0 -= r1;					\
>> +l1_%=:	exit;						\
>> +"	:
>> +	: __imm(bpf_ktime_get_ns)
>> +	: __clobber_all);
>> +}
>> +
>> +char _license[] SEC("license") = "GPL";
> 
> Maybe add a few comments in the test case?
> E.g.:
> 
> --- a/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
> @@ -13,10 +13,16 @@ __naked void subreg_equality(void)
>          call %[bpf_ktime_get_ns];                       \
>          *(u64 *)(r10 - 8) = r0;                         \
>          r2 = *(u32 *)(r10 - 8);                         \
> +       /* At this point upper 4-bytes of r2 are 0,     \
> +        * thus the w3 = w2 should propagate register id, \
> +        * so that w2 < 9 comparison would also propagate \
> +        * range for r3.                                \
> +        */                                             \
>          w3 = w2;                                        \
>          if w2 < 9 goto l0_%=;                           \
>          exit;                                           \
>   l0_%=: if r3 < 9 goto l1_%=;                           \
> +       /* r1 read is illegal at this point */          \
>          r0 -= r1;                                       \
>   l1_%=: exit;                                           \
>   "      :
> 
> Also, do we need a negative test?
> (E.g. like this one but with r2 = r0 w/o u32 read from stack).

Thanks for the suggestion. Will add comments for some
explanation and also add a negative test.

> 
