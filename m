Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED755A01C6
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 21:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239921AbiHXTF4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 15:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240074AbiHXTFm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 15:05:42 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B59DF27
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 12:05:20 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OIsr4V021686;
        Wed, 24 Aug 2022 12:05:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=rjBdFQkKazxNhI3UIB6pQ2AOZMvYx1BdJwyPXiUyjsM=;
 b=a57nWsTqNLMRC2c9Vw5i1wY7pZvu4S4vrJkk1seZprPZK/8vln/xxWrgrJXme1j16B3o
 1/tVqk11ptTf/Wnv+oFIuitEdwAD1K1Z4blUwRHqhIPQXjvDgS9PTqwcGv6tbCgbHiH4
 sg0HM1L5BBJvKsvaI7/weDOBn5X9oMLAEas= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j5nfca962-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 12:05:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfMgpfHy6Cv0R8G6+1gtnB0dNt4nI99E1q5pyYUpNJFXw9XebskbgJcQx73ZMLfjCVXZ3Ufm3fUM2QzXd3HP13fq3/HE8zRSpVplOJ6QJrckdDwZ1ZRItWPdXK2yEdMMlqmyqXSwEEfzx/5Dt4R0eEQqmFRcg55nVa4dlvnz8FTycgtiduJFVnNgLYw7g0nsYEJnhVheC+qBnlRLFic8Y53U5T8xDF8qvs0DMrZVPPZjeq3lFCy+MCLpoLPzsY1Wl1txukLtnaM9huzcJUxeL304LfdrsDLoDNk2wYveFuzkf8EehynmNVBZmtWZzQXZYVfjCx4o3LP6jkzpbxmodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjBdFQkKazxNhI3UIB6pQ2AOZMvYx1BdJwyPXiUyjsM=;
 b=AsLmYKdHgb+YJxew1FnexjdG2n9lGp6b2BJvGep4ldlsgbolsRlOcBt7+vR05nBEN/4wFgwlhLF2iEMNYTrImiCBNiLcm7iKX8uvXvJJ0yj0W827LOYSo7CGmLOQ35cvGFC1DyK5TIn8UCPrJ7KDf/FLMZZSCORAhgfavrw+kzbZ5TMffmwPxjy7nQ+DkSHKOS25aOB0PvGDMxtsRpelTFYhnXOGyI+Dpmif1thM5A0fPstcH0HQ0xyQPnFy0HkiLyhU9MG6+/rGS86tpxsoZKE4OKzmKeZUyLzpCNzZxWJ8hkkPxXdDg03nRrDnvAJdai6uWxV5NftRHR37vOa0sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4347.namprd15.prod.outlook.com (2603:10b6:303:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 19:04:59 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 19:04:59 +0000
Message-ID: <18c8145c-f6fb-865e-ebd7-2c0c694fdb13@fb.com>
Date:   Wed, 24 Aug 2022 12:04:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v2 3/6] bpf: x86: Support in-register struct
 arguments
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220812052419.520522-1-yhs@fb.com>
 <20220812052435.523068-1-yhs@fb.com>
 <CAADnVQKvtxdSo3chBeGtv8KsoQ8drrpa7x=1sOem1kwYKr5iRw@mail.gmail.com>
 <bdb4feae-47c3-80f6-cc10-741f90c28eeb@fb.com>
 <20220818204428.whsirz2m6prikg7n@MacBook-Pro-3.local>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220818204428.whsirz2m6prikg7n@MacBook-Pro-3.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0101.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::42) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cdba69f-99dc-4942-b27b-08da86038a3e
X-MS-TrafficTypeDiagnostic: MW4PR15MB4347:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 131LRxO3vJ4qk06eN3oZfRmzaCpwtFoikL4nQ2JgBoU+i231TpyKSmRcpwDVmXAm7mUkAH2HeHlC/wGk5cy8e40+zCh8r2KLTNJKzz8aIDnO7bM/D2+M7yA2pDqnS9669AxvMVPFxFHIKmh4sxozhTd32zYfsGsFmM3NoMEbRavmbbApmIDjAfSzuguEGRoU+a+2Obnb5jwesuMVbJEikwaHa8JdzdA1VH9244IMiSigylN2cmRrlGrZprmnZNJ5IrHafjT11YCO6RwwG85GOxSn2tPsiSZL04WoCfUcz9jS7mt+vFFNA1oXvSFmmMsxI+V5ejrzJfcb5BaozSwoAEg8rHCXSmCGJS66VLTN6uV+cl/0MKzMjsGypf6k1Hya5PBnuJfnAt3G/k8digzRoc85v6NP/xvrEy57bXIfk7mNJ/Z2o7vCzpka86PucUm4QWX6fQQ0sh50N9eauOHqZocePP3S3nj9s+eIF+RHXn1/ZoX4jnuuv5c3nqSfVJWWfJuF5wuj2XXP+NRFNSd4XztXSQxZCyMmxBCwgBND/NkGeKYu9RYnMCWNhi5OF5U2thiz2mSXTHlQ8ZGY0npIPLu0GoxfHBbwkP+I+zXKQn4aYs8cLj4AUeB9Mdmv/qlswHf29Oqx/LQ5aBWpMp9x4oNbQbtuiPU1ZfAHLuD2JRJg4O5YeMBVSJaYoI7GRVUzjXVX4Gxm4WHi18pdRaCK3foc8tD19nfnuWVJtl5Rw4qdfGxQD3+LzQT+KO3FXMMk4x/HDbob9UB6Q+QrbQr1Q1b0zlqud6DY3NCmxofb4N8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(86362001)(5660300002)(36756003)(6666004)(31686004)(31696002)(6512007)(41300700001)(30864003)(4326008)(66476007)(66556008)(2616005)(8676002)(186003)(8936002)(6506007)(2906002)(66946007)(53546011)(6486002)(83380400001)(6916009)(316002)(478600001)(54906003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ky9PWkJlZmgrMi95aHcwaUtCR2xtZ09vWGErVDA4QklwWWtLTzhJSldnSDdi?=
 =?utf-8?B?SitUeFJjcmxBNEVUMmgxbXhveVB2RGdhYmRSVDJraUkzK0dabzNqVTlCZlkv?=
 =?utf-8?B?cGZBQ0FrNWVaQ0tjc1V6NjNEWUVteElIVjlPQlE5d2JmbTM4Ymt0a0VxL25P?=
 =?utf-8?B?QWkwNzBZSy9tSTFtMFhDY1pEYzZjTVlidFdlRVc1RnFRQkZqeEpzUWwwSkpx?=
 =?utf-8?B?YkgrL2FRL2tzNW10dmdQVytqcWFhVkxjVmpDMFFJTW5kMDI0MDJZU2JMdVVh?=
 =?utf-8?B?RTJYRklkTFRoaXdFT2habURzUWNRd2FPY1BzcjJETEN6bDVOUmdFb2dzRk1Y?=
 =?utf-8?B?cHlxZ0xEVURKWWdvYkJrd01YMW13SFQwSEc5VEdubTVuWWR1eGRIVHY4NU9u?=
 =?utf-8?B?QnFXUjMwVyt0YnMzaVFUYjAyZnBDVitsTDQ4Ni9Nd2FvamVzZ3lyRUQ1SjdN?=
 =?utf-8?B?a2tWZ1JRZmR6a2RQanVMaWN1MjdjUDdHb3VXMU5KTldoSkZDeGFGWEMzYytC?=
 =?utf-8?B?VHFrRWg1WHdua3orbEVmWitSdDMzQUUvTXlJOG5vYXNCbzB5V3JuYnhRYjBi?=
 =?utf-8?B?ZXgycTd1d1NDcktsblVIMUwwVU16aXE4T1ZlWDBUTEhzSUw2UURFK3lyVjB0?=
 =?utf-8?B?ZFBMbDR5Qlh4U1hwZitwY252NWN2NVN0WkdyeVZiN1VlcUJVMEcvcWtHa08x?=
 =?utf-8?B?aDRNNUdjNUNLSkFrRHYzZVk3ck1BT2dJdE9YVVJCTndFaHpsakNiMHhRZzkz?=
 =?utf-8?B?Wk9HbEluM1FrVXhXcitxc09KWUNJR2w4YUlQL2NkSk1PM2psQUF0QlhWei9N?=
 =?utf-8?B?eWpURVFFbVd4QnVKWFNoamx4cElKZk5sV0xSQkZSRTVtczAxL2x4THpRVllO?=
 =?utf-8?B?UVU4TUZGTmZLUVlyY1RBcUVINGhwZXFLU1dxOEFNbGxIUEp3SWhWcWM3VVU4?=
 =?utf-8?B?bUsyR1hkZzd6Vko0SW1Ddk5ZSDNEeUYrZWRkMWRkYnd2dXI2bXdaWW1wMC9w?=
 =?utf-8?B?TDdaWEpUOHNiM2MyY3BISmc1dzNIVDZiamlPekQ5Q1hpZDBSaTR3dVFkR2d6?=
 =?utf-8?B?WnJPZGNoaG9ES3RQMG5XcTlUOGVGcEtsSDROOHV4YzU5SnVsUXJkdXhGeE9C?=
 =?utf-8?B?UFRjRmZGdWFxNysza3Y2MFFSZjNIL1Ntc2t1UGluUzh4WkdOZXhKYTNQT3Yr?=
 =?utf-8?B?elZJZ3dCYkF6TTNuWUliSHl2YTlobTZYNGIxR1dSTFliM25INEEzcmtXcXVH?=
 =?utf-8?B?dC9TM1o1Z1dWWTY4MndoQlNzaUp4N2EzZG5admJ6MDU0MEo2V0VFRGMxY2Qz?=
 =?utf-8?B?S09mN1lVWGErblg1TlNGbDZiRkZla2ZkOU1LY3BjUXEvMkhxSkJSczNsTGpm?=
 =?utf-8?B?UDNHa0VQNUlCQ3ZtMGxBd2psbVlwbmlEUHh3YVVGMW9pQkoySmVyQURYZzdh?=
 =?utf-8?B?dVBCdWxDUHlXdHl3RlZ2cTRMajB1UUpOeTJNd05YK3g3QzlZdFZYWmpYa3g2?=
 =?utf-8?B?TDY3QkpVWGJGb1JKYmdLWi83WUZoSE1rRnovZjN5bHc4UGlGczhNUjVMeXAr?=
 =?utf-8?B?S1NnVGR4S2lFVjltM0tka3hJbC82c01jckt1QlUrcXJ5WGF1RXBDYkZubG5t?=
 =?utf-8?B?OS9CZUJVT2NETXhIU2JrbzB2YjgvRG1QR2diKzZLNWdRZkwwajIwV3dWWUJY?=
 =?utf-8?B?ZGcxc0J2KzlEMTBmNmZXOGROOHgrS1BQakVjNVVyamZjOHpDWVVieE1PT015?=
 =?utf-8?B?OW5PTjUrU25wN1VvYUVXZ3dEdGhJUkdiaWcxWUdIajhyYURCUnVQeFJLcTRU?=
 =?utf-8?B?MW1PeTE4OXJqSGdFMXhBbnVYQldzZC81Wlg0RFNTVHdFcjdTMWRFS3ZRZW96?=
 =?utf-8?B?OEtQY3Jycnhsb1d0K2JoUVIydll4bWNmYzhCTXpCWDBQUkpoK2kyRWpmSlEx?=
 =?utf-8?B?ckppcW1FQlVZNDBHRXBKYVdnU0RPRUxJSnRzdE0xc3hTK3BKZ1lrNEtvRGU2?=
 =?utf-8?B?aXF2Mmp5SXo2MUgydFN0WkoxeStwR2kyTVYxNjdudDdVYnY0NG9uNHljQmpH?=
 =?utf-8?B?cnZmVlNQQVJ1V1pKa0cyUkl3REUySmRkTVFybDJUYnVPams4ZWZSMkUvWmdS?=
 =?utf-8?Q?lRepSw3mNvvzaNUBTaQpp0AZV?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdba69f-99dc-4942-b27b-08da86038a3e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 19:04:59.0141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZHxjO10RUnMAxkQAAkpXG0vKF2leoZbzOzjYQcKnXafJkxD+yUYgR9N+02Al2i1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4347
X-Proofpoint-GUID: Np5yJerLZzr6nVo_7oxKHdC11HDklNUy
X-Proofpoint-ORIG-GUID: Np5yJerLZzr6nVo_7oxKHdC11HDklNUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_11,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/18/22 1:44 PM, Alexei Starovoitov wrote:
> On Wed, Aug 17, 2022 at 09:56:23PM -0700, Yonghong Song wrote:
>>
>>
>> On 8/15/22 3:44 PM, Alexei Starovoitov wrote:
>>> On Thu, Aug 11, 2022 at 10:24 PM Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>> In C, struct value can be passed as a function argument.
>>>> For small structs, struct value may be passed in
>>>> one or more registers. For trampoline based bpf programs,
>>>> This would cause complication since one-to-one mapping between
>>>> function argument and arch argument register is not valid
>>>> any more.
>>>>
>>>> To support struct value argument and make bpf programs
>>>> easy to write, the bpf program function parameter is
>>>> changed from struct type to a pointer to struct type.
>>>> The following is a simplified example.
>>>>
>>>> In one of later selftests, we have a bpf_testmod function:
>>>>       struct bpf_testmod_struct_arg_2 {
>>>>           long a;
>>>>           long b;
>>>>       };
>>>>       noinline int
>>>>       bpf_testmod_test_struct_arg_2(int a, struct bpf_testmod_struct_arg_2 b, int c) {
>>>>           bpf_testmod_test_struct_arg_result = a + b.a + b.b + c;
>>>>           return bpf_testmod_test_struct_arg_result;
>>>>       }
>>>>
>>>> When a bpf program is attached to the bpf_testmod function
>>>> bpf_testmod_test_struct_arg_2(), the bpf program may look like
>>>>       SEC("fentry/bpf_testmod_test_struct_arg_2")
>>>>       int BPF_PROG(test_struct_arg_3, int a, struct bpf_testmod_struct_arg_2 *b, int c)
>>>>       {
>>>>           t2_a = a;
>>>>           t2_b_a = b->a;
>>>>           t2_b_b = b->b;
>>>>           t2_c = c;
>>>>           return 0;
>>>>       }
>>>>
>>>> Basically struct value becomes a pointer to the struct.
>>>> The trampoline stack will be increased to store the stack values and
>>>> the pointer to these values will be saved in the stack slot corresponding
>>>> to that argument. For x86_64, the struct size is limited up to 16 bytes
>>>> so the struct can fit in one or two registers. The struct size of more
>>>> than 16 bytes is not supported now as our current use case is
>>>> for sockptr_t in the argument. We could handle such large struct's
>>>> in the future if we have concrete use cases.
>>>>
>>>> The main changes are in save_regs() and restore_regs(). The following
>>>> illustrated the trampoline asm codes for save_regs() and restore_regs().
>>>> save_regs():
>>>>       /* first argument */
>>>>       mov    DWORD PTR [rbp-0x18],edi
>>>>       /* second argument: struct, save actual values and put the pointer to the slot */
>>>>       lea    rax,[rbp-0x40]
>>>>       mov    QWORD PTR [rbp-0x10],rax
>>>>       mov    QWORD PTR [rbp-0x40],rsi
>>>>       mov    QWORD PTR [rbp-0x38],rdx
>>>>       /* third argument */
>>>>       mov    DWORD PTR [rbp-0x8],esi
>>>> restore_regs():
>>>>       mov    edi,DWORD PTR [rbp-0x18]
>>>>       mov    rsi,QWORD PTR [rbp-0x40]
>>>>       mov    rdx,QWORD PTR [rbp-0x38]
>>>>       mov    esi,DWORD PTR [rbp-0x8]
>>>
>>> Not sure whether it was discussed before, but
>>> why cannot we adjust the bpf side instead?
>>> Technically struct passing between bpf progs was never
>>> officially supported. llvm generates something.
>>> Probably always passes by reference, but we can adjust
>>> that behavior without breaking any programs because
>>> we don't have bpf libraries. Programs are fully contained
>>> in one or few files. libbpf can do static linking, but
>>> without any actual libraries the chance of breaking
>>> backward compat is close to zero.
>>
>> Agree. At this point, we don't need to worry about
>> compatibility between bpf program and bpf program libraries.
>>
>>> Can we teach llvm to pass sizeof(struct) <= 16 in
>>> two bpf registers?
>>
>> Yes, we can. I just hacked llvm and was able to
>> do that.
>>
>>> Then we wouldn't need to have a discrepancy between
>>> kernel function prototype and bpf fentry prog proto.
>>> Both will have struct by value in the same spot.
>>> The trampoline generation will be simpler for x86 and
>>> its runtime faster too.
>>
>> I tested x86 and arm64 both supports two registers
>> for a 16 byte struct.
>>
>>> The other architectures that pass small structs by reference
>>> can do a bit more work in the trampoline: copy up to 16 byte
>>> and bpf prog side will see it as they were passed in 'registers'.
>>> wdyt?
>>
>> I know systemz and Hexagon will pass by reference for any
>> struct size >= 8 bytes. Didn't complete check others.
>>
>> But since x86 and arm64 supports direct value passing
>> with two registers, we should be okay. As you mentioned,
>> we could support systemz/hexagon style of struct passing
>> by copying the values to the stack.
>>
>>
>> But I have a problem how to define a user friendly
>> macro like BPF_PROG for user to use.
>>
>> Let us say, we have a program like below:
>> SEC("fentry/bpf_testmod_test_struct_arg_1")
>> int BPF_PROG(test_struct_arg_1, struct bpf_testmod_struct_arg_2 *a, int b,
>> int c) {
>> ...
>> }
>>
>> We have BPF_PROG macro definition here:
>>
>> #define BPF_PROG(name, args...)     \
>> name(unsigned long long *ctx);     \
>> static __always_inline typeof(name(0))     \
>> ____##name(unsigned long long *ctx, ##args);     \
>> typeof(name(0)) name(unsigned long long *ctx)     \
>> {     \
>>          _Pragma("GCC diagnostic push")      \
>>          _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")      \
>>          return ____##name(___bpf_ctx_cast(args));      \
>>          _Pragma("GCC diagnostic pop")      \
>> }     \
>> static __always_inline typeof(name(0))     \
>> ____##name(unsigned long long *ctx, ##args)
>>
>> Some we have static function definition
>>
>> int ____test_struct_arg_1(unsigned long long *ctx, struct
>> bpf_testmod_struct_arg_2 *a, int b, int c);
>>
>> But the function call inside the function test_struct_arg_1()
>> is
>>    ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2]);
>>
>> We have two problems here:
>>    ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2])
>> does not match the static function declaration.
>> This is not problem if everything is int/ptr type.
>> If one of argument is structure type, we will have
>> type conversion problem. Let us this can be resolved
>> somehow through some hack.
>>
>> More importantly, because some structure may take two
>> registers,
>>     ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2])
>> may not be correct. In my above example, if the
>> structure size is 16 bytes,
>> then the actual call should be
>>     ____test_struct_arg_1(ctx, ctx[0], ctx[1], ctx[2], ctx[3])
>> So we need to provide how many extra registers are needed
>> beyond ##args in the macro. I have not tried how to
>> resolve this but this extra information in the macro
>> definite is not user friendly.
>>
>> Not sure what is the best way to handle this issue (##args is not precise
>> and needs addition registers for >8 struct arguments).
> 
> The kernel is using this trick to cast 8 byte structs to u64:
> /* cast any integer, pointer, or small struct to u64 */
> #define UINTTYPE(size) \
>          __typeof__(__builtin_choose_expr(size == 1,  (u8)1, \
>                     __builtin_choose_expr(size == 2, (u16)2, \
>                     __builtin_choose_expr(size == 4, (u32)3, \
>                     __builtin_choose_expr(size == 8, (u64)4, \
>                                           (void)5)))))
> #define __CAST_TO_U64(x) ({ \
>          typeof(x) __src = (x); \
>          UINTTYPE(sizeof(x)) __dst; \
>          memcpy(&__dst, &__src, sizeof(__dst)); \
>          (u64)__dst; })
> 
> casting 16 byte struct to two u64 can be similar.
> Ideally we would declare bpf prog as:
> SEC("fentry/bpf_testmod_test_struct_arg_1")
> int BPF_PROG(test_struct_arg_1, struct bpf_testmod_struct_arg_2 a, int b, int c) {
> note there is no '*'. It's struct by value.
> The main challenge is how to do the math in the BPF_PROG macros.
> Currently it's doing:
> #define ___bpf_ctx_cast1(x)           ___bpf_ctx_cast0(), (void *)ctx[0]
> #define ___bpf_ctx_cast2(x, args...)  ___bpf_ctx_cast1(args), (void *)ctx[1]
> #define ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), (void *)ctx[2]
> #define ___bpf_ctx_cast4(x, args...)  ___bpf_ctx_cast3(args), (void *)ctx[3]
> 
> The ctx[index] is one-to-one with argument position.
> That 'index' needs to be calculated.
> Maybe something like UINTTYPE() that applies to previous arguments?
> #define REG_CNT(arg) \
>          __builtin_choose_expr(sizeof(arg) == 1,  1, \
>          __builtin_choose_expr(sizeof(arg) == 2,  1, \
>          __builtin_choose_expr(sizeof(arg) == 4,  1, \
>          __builtin_choose_expr(sizeof(arg) == 8,  1, \
>          __builtin_choose_expr(sizeof(arg) == 16,  2, \
>                                           (void)0)))))
> 
> #define ___bpf_reg_cnt0()            0
> #define ___bpf_reg_cnt1(x)          ___bpf_reg_cnt0() + REG_CNT(x)
> #define ___bpf_reg_cnt2(x, args...) ___bpf_reg_cnt1(args) + REG_CNT(x)
> #define ___bpf_reg_cnt(args...)    ___bpf_apply(___bpf_reg_cnt, ___bpf_narg(args))(args)
> 
> This way the macro will calculate the index inside ctx[] array.
> 
> and then inside ___bpf_ctx_castN macro use ___bpf_reg_cnt.
> Instead of:
> ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), (void *)ctx[2]
> it will be
> ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), \
>    __builtin_choose_expr(sizeof(x) <= 8, (void *)ctx[___bpf_reg_cnt(args)],
>                          *(typeof(x) *) &ctx[___bpf_reg_cnt(args)])

I tried this approach. The only problem is sizeof(x) <= 8 may also be
a structure. Since essentially we will have a type conversion like
    (struct <name))(void *)ctx[...]
and this won't work.

So ideally we want something like
__builtin_choose_expr(is_struct_type(x), *(typeof(x) *) 
&ctx[___bpf_reg_cnt(args)]
     (void *)ctx[___bpf_reg_cnt(args)])
here is_struct_type(x) tells whether the type is a struct type
or typedef of a struct. Currently we don't have a such a macro/builtin yet.

Note that in order to make sizeof(x) or is_struct_type(x) work, we
need to separate type and argument name like

int BPF_PROG(test_struct_arg_1, struct bpf_testmod_struct_arg_2, a, int, 
b, int, c)

Which will make the macro incompatible with existing BPF_PROG macro.

> 
> x - is one of the arguments.
> args - all args before 'x'. Doing __bpf_reg_cnt on them should calculate the index.
> *(typeof(x) *)& should type cast to struct of 16 bytes.
> 
> Rough idea, of course.
> 
> Another alternative is instead of:
> #define BPF_PROG(name, args...)
> name(unsigned long long *ctx);
> do:
> #define BPF_PROG(name, args...)
> struct XX {
>    macro inserts all 'args' here separated by ; so it becomes a proper struct
> };
> name(struct XX *ctx);
> 
> and then instead of doing ___bpf_ctx_castN for each argument
> do single cast of all of 'u64 ctx[N]' passed from fentry into 'struct XX *'.
> The problem with this approach that small args like char, short, int needs to
> be declared in struct XX with __align__(8).

This should work. But since we will change context type from
"unsigned long long *" to "struct XX *", the code pattern will look like

BPF_PROG2_DECL(test_struct_arg_1);
SEC("fentry/bpf_testmod_test_struct_arg_1")
int BPF_PROG2(test_struct_arg_1, struct bpf_testmod_struct_arg_2, a, 
int, b, int, c)

Where BPF_PROG2_DECL will provide a forward declaration like
#define BPF_PROG2_DECL(name) struct _____##name;

and BPF_PROG2 will look like (not handling zero argument yere)

#define BPF_PROG2(name, args...)                                      \
name(struct _____##name *ctx);                                        \
struct _____##name {                                                  \
        ___bpf_ctx_field(args)                                         \
};                                                                    \
static __always_inline typeof(name(0))                                \
____##name(struct _____##name *ctx, ___bpf_ctx_decl(args));           \
typeof(name(0)) name(struct _____##name *ctx)                         \
{                                                                     \
        return ____##name(ctx, ___bpf_ctx_arg(args));                  \
}                                                                     \
static __always_inline typeof(name(0))                                \
____##name(struct _____##name *ctx, ___bpf_ctx_decl(args))

where __bpf_ctx_field(args) will generate
    struct bpf_testmod_struct_arg_2 a;
    int b;
    int c;

___bpf_ctx_arg(args) will generate
    ctx->a, ctx->b, ctx->c

and ___bpf_ctx_decl(args) will generate proper argument prototypes
the same way as in BPF_PROG macro.

> 
> Both approaches may be workable?
