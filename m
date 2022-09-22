Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BC85E6561
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 16:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiIVO2F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 10:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIVO2E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 10:28:04 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF7AF313E
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 07:28:03 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28M5QSf5013094;
        Thu, 22 Sep 2022 07:27:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=zuJvmNzLz+KvX7OAndrtN4Av0JV3AcMXB9m6hg+CI6g=;
 b=iokdXldxzQezho51PEqMf6eOzgT745tj173uAD145+XpW/y4E1Ju37AR5vKWCCR79nfr
 8dTusga2GplDgDAzBJMMQCDFP48hcfoSHjp1c+nabLxOqpMYPoWkCWUeZ47KoQyzlOwn
 mNWJRS0B8pcnPAQXwQJQFBbKZ8oCn+C+YDhJRavjYpNoDISk4FiZuJvyHNaTiQHgtHp4
 CsZfWb5TvXH+4NHXu7jyo0GQs/V3+JO9lCFLEIctoTzY+mVqB6IFTk9lptqpeUmAzjho
 uaTJFq3cBd71wRs16U8eHLW+TiBaSqT+mIdEpoZc5R8EkNBbxXYib+qWNQVlRbHOqHvH zA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jrhjgju6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 07:27:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ityYojRuyxntDTbcCOZflobt9OXR19olYkkGrPnBn8h3qUC2U3nIH/T7CvdUwrDcea4as/xdnPmc+btMGsTWY0GzJ8k6e54bY2EcVmpP+2xNzsmmNA4DI7HTlHqBXp49OYutkMX+Qo7X/JjeGcJmHiFoTT8vBt2klRKtWZPTKVYKwCaPYuM9SmAGmPQEn/ONMDja8SDhxt3b3RN6ATlIFpyGDOxTJKqiATsaIBVlUGNR6zhzgd/YMEYn3zu3qVig1+bwbYwvjSVMXNLGwItKhddX6Fmkc1Zf7jna7lx4UUn/R2HlaVwiDt4HZeLiEIW+ks/2I+jjyCzU31pz7V75Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuJvmNzLz+KvX7OAndrtN4Av0JV3AcMXB9m6hg+CI6g=;
 b=Racgje3jrKr9fnyTSpR+WQgIDJpusrqqWJ0N5bhkRUaYSa9IxQ34o+pL1t6l/U58kMjS5/sGrCVKbFLpxNPr6DCY10AeN1QZnRRMCZRDW1rTQhaZw3J4wFVfiCBuL9xR6s2ReK57ZPdt2VCQIA3jrqF7DjJNircf5gEjVhs7BCFIEuE+3GAOyY43anacchIeSlVm3wnh8pbgWAN+tfMwTV50PoX0UknKWpDSIAfPMM27aeHbGykFGyHlEDJBWfrgj1jhWgWHql1+JUwFuztbIBPsZz/FAHYXeU4qOtstg3bCwy57swVOKlWPLI4nG24vF+5FpwQkLP6NQOPoUSMI6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by SJ0PR15MB5290.namprd15.prod.outlook.com (2603:10b6:a03:426::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Thu, 22 Sep
 2022 14:27:23 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::192a:3127:20ff:4d71]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::192a:3127:20ff:4d71%6]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 14:27:23 +0000
Message-ID: <c6d6a452-0ee9-ee90-6415-1066bbfcfc82@meta.com>
Date:   Thu, 22 Sep 2022 10:27:21 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add test verifying
 bpf_ringbuf_reserve retval use in map ops
To:     Yonghong Song <yhs@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20220914123600.927632-1-davemarchevsky@fb.com>
 <20220914123600.927632-2-davemarchevsky@fb.com>
 <26e3f391-076e-49ce-89d6-21aa16f3c054@fb.com>
 <CAP01T75E9sp5Aq159Zjmrpmaue+gYkN66qjA06opDhLhbuUzAw@mail.gmail.com>
 <55e96fb0-6a3a-8162-5c3e-41b10dd6a292@fb.com>
Content-Language: en-US
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <55e96fb0-6a3a-8162-5c3e-41b10dd6a292@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0449.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::34) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB4039:EE_|SJ0PR15MB5290:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a916bef-b1a9-40e0-4a19-08da9ca690ee
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SRmTz479yS0kESoKXSHBTAP+0o5Bmo4CrB8Bn6jpD/fHsPtKm/MSBEbTCY4+ib6YOA7PBOWftJ0SYt9D0NYnJFneTB3PvKtuU4Y5/0v2GmMJUBU3V7jj3xHEH3LGEW3k7cLyToBdvklrvyyY8u14mZsnLYumMGODIurRgeqTzAvu4mlanyTMYzL+cHYAqZrbxi2Vw7jAuGwyvzP3+mMf1GQN1gnyOgOZ6ZaRtTLdxkiP/Hgo6SQw53lUdrex7HnXaEqXVjdl72hS8Bik/acPJ8dntFmuQYuZn1izjvsli9MSJ1Bymd65cxAZhu+rV9s1CvZPDYblYEMlQwBuvvqosXHEwCl97/SSrRmWlShk+hrMJKNHbfzCWIDf47wNMzMx1hIkjzqC+MWL8YMRE88mlfhvhZNzHOmtOajx6LVwwKTQ03281QyKZJ+KYd85w09DfV6oxoU/2N29V4ExqrpvSn/BMi1j2muSFrj+GlzFFsFZVATkpRnHstYq3+mXJxrN/gbnhKMATtrv7ARqpiRC2VRboEkp0NZq4Of6sVqqVvhZtk+eBqbiLaq2L/4/lgn3lgZepWRMc3RKmBLultp3f6r9B2VdG5pMaMnxYxftL4gG2vaG3ERFrrn+feDGdQM8rODjOadsnR9tmxlze9zhGbYnFY6iXT12QPjgriZ5CnCqiLsK1hXwT0AHo3YfnCLWUHmGDb0qk7wmbb+U2acE3mechkaU9E9u8YOBQO8RhCq1qMpK8t5vL8gBwtnmgTBpWltifRRDXN6Kx6fJUSDr0dccM6PaG8Qbp+W6GoPMl9GwIaSO1qj6//Csu9rI1VdW4csB9HoiVO1YruPI1yH0iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199015)(316002)(478600001)(31686004)(36756003)(83380400001)(84970400001)(6486002)(31696002)(86362001)(186003)(2616005)(38100700002)(41300700001)(8676002)(53546011)(6506007)(66946007)(6512007)(54906003)(66556008)(110136005)(15650500001)(8936002)(5660300002)(66476007)(4326008)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjByNjJoQ3MyRnNBankwZlRtS1Y2VkNBWmtGSkJuNjFoUWZWV1ZLWFBNQjl6?=
 =?utf-8?B?YmJXdndjR3ZTbjhkU0RzZzVBNTYvYXlUN3Jiai9iWHJFL0xoNkRmbjdhT1R0?=
 =?utf-8?B?amhPWGF5cWxXT0tXV0FOcHRtOFR0eXo4WklRQVp2a09oOFhHUHNqOG14Sk56?=
 =?utf-8?B?YTlIb1lrZndGTmt0dWxpVXRGMUY3ODdkOUFlWEsxQWw2SHZ0ejhycXovWHpz?=
 =?utf-8?B?bTRSMVBTdUR5SFRLS0phZXJwWVl5dWxFOUVkUDBUUTYwVlNtVXNaWGc4eE8y?=
 =?utf-8?B?VTBNUXU2d1pEUnNFdHFtSDVsdVBlTDlDUjNmN2VGRDVFSVJpdjRUdTJ0T29F?=
 =?utf-8?B?anJCYjVDd2ZBUjdQMTV1NnRST2lsN01icEVZS2NXYU4zb0c5dGpBajJTVVNI?=
 =?utf-8?B?VGk2ZjBTVmxoUDZ0SWJjbnBOT0Q0QnFmZkRRTGordTdHNTYvMWpvbVhNTXVu?=
 =?utf-8?B?OUxHaTB0WnNteCtoM24ra3EzMkczL1NBVGVPK1Z2SHZJZVJhQ3dhd1dQdG9I?=
 =?utf-8?B?Y25hemh4V01VQXhPU3h6UXNzSlpBR09YVm5xMEFmQnhvTVpZdDkwZEhZUFF6?=
 =?utf-8?B?RGtKNU8rM2VJYUowWktwT2xNTXlwazZLNnloV0NVd3N4VVd3TmtmM1B2T1Ro?=
 =?utf-8?B?VWxzMlFEZnNFR3NaVkVkZHlCYjRTWnFIbGc1RDdqQTNla2JVcGFndTV3VXlo?=
 =?utf-8?B?ZE42a21XRTVseGQ0dG9TcnFGdXAvckNOTkNrcjJyM3BHQjY2NnpsTVZFbis2?=
 =?utf-8?B?Z1E3OW52QnQ2VlBySTc0T3dmRzIrd1A2Z0J0elh5MzZ5V0dnSU1ZcUVxV01E?=
 =?utf-8?B?M1RqZ3FNOFlaNnBxYWRRWDZ6V3VId2o0RndqQy9wL2dtdnF3M0JoNndueGN0?=
 =?utf-8?B?YTBzUTlUdk5vWGFOUjkrVytqSTNBRXEzYktLUlJrU1FuYWVlWWNkOFZaY2ZF?=
 =?utf-8?B?V2RsWFdOQW1qQlZ4UFBnejJTd1lSc0NoZDhBT3FYbEQ2N2ltV1JtRHVSY056?=
 =?utf-8?B?Skd5MDlOMDRLY21ONUk0TlR1Z1QxRENwNWdmSWJBU0xtTGdMUklWUGY3V2ZZ?=
 =?utf-8?B?T010SGJ0QkNHbzQ5cnpORzFad012NkJHeWNqc2F3S1JSMjdrSHV1TTJRbVds?=
 =?utf-8?B?dzhTc1dsNEFOc09OWjYwNnE2LzYzZXFTNkNDS0tiaUptV2xnaWJ3L0lrWGZ6?=
 =?utf-8?B?dkdDa0JlbjVGVUFDTkpYTDdYVXVyZXo1U2s5NFp1TVdaZGhtamRvRjlUMmtX?=
 =?utf-8?B?Z3ltVlZSdnZmbklUSElFZHo2QkdRWkVaMjVxV2Q1Y0IzNlpEOXJPLzVnL3pM?=
 =?utf-8?B?Uy93dzRkM0dCM2FjVnVaT2ZndUZUMS8vNWNTSzNGSjg0Z00wSTc5RExwQXZv?=
 =?utf-8?B?N01mOC8vVnAzZS83TDlROWJ5dU05b28vMUVoN3JMWFc4Y05ENTRhdmhSUU1Y?=
 =?utf-8?B?UTVacWx1eTk1SXk5bHZTOWdsWGZxQXBEbXFZZnVNZUVHOXYxUHI3SkxYblVS?=
 =?utf-8?B?MFFwRnhyWlExYWk0Mk9GMTdtd1Y5ajYvYXhTU25tdHk3ckNRM1hoRmZrQTZY?=
 =?utf-8?B?MTFxL3VHWW5aUE0rR3FuTXRQbXRHOGtwNXpTWjNGMlptUzZhUkVJOHJ6Z0RY?=
 =?utf-8?B?Vkd1SVJzb1lEWVJWNEdVL2M1ZHI3Yi9QeDVMMWdyR1ZJSzFzOVBIcnEzbGxy?=
 =?utf-8?B?YnZnWm56SGhoSU1UTEd4QjY3cGhjek9pd1F6dUF2c2lHWTJwak5Da0dxa2Zz?=
 =?utf-8?B?K1FWT0FkS0JlTlFPZlBxdWtrUmppTHZudFg3bHhiSmZPWmU1Y0FkMWJ0SE9y?=
 =?utf-8?B?WlYxSldnclBub0FsSWNKa1NJWDFTWlRJWEc3RXhIQU9KM1NkNG1JYys3OVdu?=
 =?utf-8?B?dzhJYStxNUZPK2hMdHFKVFYvR0xIWWc4bEhDcmRnejJWODlTK3ZId2FpeTB6?=
 =?utf-8?B?dGJacWd1bUhtaXMxWHJzOUtEeWI2ZnV3Nm5QZURrTmdsTWNxK2FESXlMdDN3?=
 =?utf-8?B?VE1TeTZvYzFTRDhzQWZLS0NKUVFDdmFkU2kxUUhPSUNVZ2hlelJCQkg2UGZH?=
 =?utf-8?B?TURtNG16MUhEdmhwRFJlS2QrSTEzUW1MeW80ZzFXMTZPcDBDV1prMnFScUJi?=
 =?utf-8?B?N2RIVnlwQXdIR1pXSlBtRmlhTHRuWGVRVldYRk5QUFAwbUJ0Mm1VQmtuZUtl?=
 =?utf-8?Q?Qol3gXIZgVnHthmOh6lWy9I=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a916bef-b1a9-40e0-4a19-08da9ca690ee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 14:27:23.7636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tpr450GOVAVrNpWGUL2itOZeL8J8Uj6+Gus6EEz9T/vtYfzDvD3UHo5UtHCK3Y73MuaZ5csTH3sYTQH0pMtn5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5290
X-Proofpoint-GUID: SKoJmYcr2UBZQb9-dUvn5HWBZTDb31tM
X-Proofpoint-ORIG-GUID: SKoJmYcr2UBZQb9-dUvn5HWBZTDb31tM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_08,2022-09-22_01,2022-06-22_01
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/20/22 1:50 AM, Yonghong Song wrote:
> 
> 
> On 9/19/22 4:22 PM, Kumar Kartikeya Dwivedi wrote:
>> On Tue, 20 Sept 2022 at 00:53, Yonghong Song <yhs@fb.com> wrote:
>>>
>>>
>>>
>>> On 9/14/22 5:36 AM, Dave Marchevsky wrote:
>>>> Add a test_ringbuf_map_key test prog, borrowing heavily from extant
>>>> test_ringbuf.c. The program tries to use the result of
>>>> bpf_ringbuf_reserve as map_key, which was not possible before previouis
>>>> commits in this series. The test runner added to prog_tests/ringbuf.c
>>>> verifies that the program loads and does basic sanity checks to confirm
>>>> that it runs as expected.
>>>>
>>>> Also, refactor test_ringbuf such that runners for existing test_ringbuf
>>>> and newly-added test_ringbuf_map_key are subtests of 'ringbuf' top-level
>>>> test.
>>>>
>>>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>>>> ---
>>>> v1->v2: lore.kernel.org/bpf/20220912101106.2765921-1-davemarchevsky@fb.com
>>>>
>>>> * Actually run the program instead of just loading (Yonghong)
>>>> * Add a bpf_map_update_elem call to the test (Yonghong)
>>>> * Refactor runner such that existing test and newly-added test are
>>>>     subtests of 'ringbuf' top-level test (Yonghong)
>>>> * Remove unused globals in test prog (Yonghong)
>>>>
>>>>    tools/testing/selftests/bpf/Makefile          |  8 ++-
>>>>    .../selftests/bpf/prog_tests/ringbuf.c        | 63 ++++++++++++++++-
>>>>    .../bpf/progs/test_ringbuf_map_key.c          | 70 +++++++++++++++++++
>>>>    3 files changed, 137 insertions(+), 4 deletions(-)
>>>>    create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
>>>>
>>> [...]
>>>> diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c b/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
>>>> new file mode 100644
>>>> index 000000000000..495f85c6e120
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
>>>> @@ -0,0 +1,70 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
>>>> +
>>>> +#include <linux/bpf.h>
>>>> +#include <bpf/bpf_helpers.h>
>>>> +#include "bpf_misc.h"
>>>> +
>>>> +char _license[] SEC("license") = "GPL";
>>>> +
>>>> +struct sample {
>>>> +     int pid;
>>>> +     int seq;
>>>> +     long value;
>>>> +     char comm[16];
>>>> +};
>>>> +
>>>> +struct {
>>>> +     __uint(type, BPF_MAP_TYPE_RINGBUF);
>>>> +     __uint(max_entries, 4096);
>>>> +} ringbuf SEC(".maps");
>>>> +
>>>> +struct {
>>>> +     __uint(type, BPF_MAP_TYPE_HASH);
>>>> +     __uint(max_entries, 1000);
>>>> +     __type(key, struct sample);
>>>> +     __type(value, int);
>>>> +} hash_map SEC(".maps");
>>>> +
>>>> +/* inputs */
>>>> +int pid = 0;
>>>> +
>>>> +/* inner state */
>>>> +long seq = 0;
>>>> +
>>>> +SEC("fentry/" SYS_PREFIX "sys_getpgid")
>>>> +int test_ringbuf_mem_map_key(void *ctx)
>>>> +{
>>>> +     int cur_pid = bpf_get_current_pid_tgid() >> 32;
>>>> +     struct sample *sample, sample_copy;
>>>> +     int *lookup_val;
>>>> +
>>>> +     if (cur_pid != pid)
>>>> +             return 0;
>>>> +
>>>> +     sample = bpf_ringbuf_reserve(&ringbuf, sizeof(*sample), 0);
>>>> +     if (!sample)
>>>> +             return 0;
>>>> +
>>>> +     sample->pid = pid;
>>>> +     bpf_get_current_comm(sample->comm, sizeof(sample->comm));
>>>> +     sample->seq = ++seq;
>>>> +     sample->value = 42;
>>>> +
>>>> +     /* test using 'sample' (PTR_TO_MEM | MEM_ALLOC) as map key arg
>>>> +      */
>>>> +     lookup_val = (int *)bpf_map_lookup_elem(&hash_map, sample);
>>>> +
>>>> +     /* memcpy is necessary so that verifier doesn't complain with:
>>>> +      *   verifier internal error: more than one arg with ref_obj_id R3
>>>> +      * when trying to do bpf_map_update_elem(&hash_map, sample, &sample->seq, BPF_ANY);
>>>> +      *
>>>> +      * Since bpf_map_lookup_elem above uses 'sample' as key, test using
>>>> +      * sample field as value below
>>>> +      */
>>>
>>> If I understand correctly, the above error is due to the following
>>> verifier code:
>>>
>>>           if (reg->ref_obj_id) {
>>>                   if (meta->ref_obj_id) {
>>>                           verbose(env, "verifier internal error: more
>>> than one arg with ref_obj_id R%d %u %u\n",
>>>                                   regno, reg->ref_obj_id,
>>>                                   meta->ref_obj_id);
>>>                           return -EFAULT;
>>>                   }
>>>                   meta->ref_obj_id = reg->ref_obj_id;
>>>           }
>>>
>>> So this is an internal error. So normally this should not happen.
>>> Could you investigate and fix the issue?
>>>
>>
>> Technically it's not an "internal" error, it's totally possible to
>> pass two referenced registers from a program (which the verifier
>> rejects). So a bad log message I guess.
>>
>> We probably need to update the verifier to properly recognize the
>> ref_obj_id for certain functions. For release arguments we already
>> have meta.release_regno/OBJ_RELEASE for. It can already find the
>> ref_obj_id from release_regno instead of meta.ref_obj_id.
>>
>> For dynptr_ref or ptr_cast, simply store meta.ref_obj_id by capturing
>> the regno and then setting it before r1-r5 is cleared.
>> Since that is passed to r0 it will be done later after clearing of
>> caller saved regs.
>> ptr_cast and dynptr_ref functions are already exclusive (due to
>> helper_multiple_ref_obj_use) so they can share the same regno field in
>> meta.
>>
>> Then remove this check on seeing more than one reg->ref_obj_id, so it
>> isn't a problem to allow more than one refcounted registers for all
>> other arguments, as long as we correctly remember the ones for the
>> cases we care about.
> 
> Thanks for the explanation!
> 
>>
>> But it can probably be a separate change from this.
> 
> if the use case this patch set tried to address is using
> bpf_map_update_elem(), we should fix the double
> ref_obj_id in the current patch set. If only
> bpf_map_lookup_elem() is needed. Then we can delay
> the verifier change for the followup patch.
> 

The bpf_map_lookup_elem() usecase is the only one critical for me, so I've
submitted v3 without ref_obj_id fix. I agree that it should be fixed, but feels
orthogonal to this change, and is probably best addressed as a verifier-wide
fix affecting all functions as per Kumar's suggestion.
