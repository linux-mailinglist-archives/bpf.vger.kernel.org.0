Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7E95E68F8
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 19:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiIVRAo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 13:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiIVRAn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 13:00:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55B730F6F
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 10:00:39 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MH0IYk032062;
        Thu, 22 Sep 2022 10:00:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=oe2cXpICruVv5giRUEt9Lzgk/bIjXExcl5bShNaaC7M=;
 b=nBqsk0vNAFq2JLGCn7EjJg5UPEs0boEMZp7zRwEwedJOrJiC1fgQqsMseFhRggpqb2qw
 OOjvy6DF3btubXyHBsN6bNv6zQYxTTzjCpejRx/Yk1UCkIX6VNdqdcPpVop9zPkCXzxO
 I0u8dLIpP5NIHUVvRvAmJWPajMKTGnfE+HY= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jrenwcwj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 10:00:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SObnB2EwnMb0bHHuVqL/HI1LQUgHcGb3B3dxgjJtJGH4CD1o92zd18HL7LDA/J2D3dKYlTa0j3LPJpeapI+Eu8c5+7bH8EyiJsk2lP/GPXmGFbhvER0aLJD4lNp378bJJ33mQDoT/nUFShGiZ9O1ydH2+A/gyD5v56+0+W9DJqQyl1sS3AE8mC+fE75nbOi2XK5TqTtrVwRQjHRz2HZ8qA31p5DeSlu+oBNVnWSqovRcyUSk+RgLJ2vjz1bDbUcCR/Ga1GqrZ347svH/oDA3Pn5LknQhrdsF1PH4HS73iZ7icUNuq+iwC7K03JHHekaoQOTIjX41NpFBnUT8Obj+yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oe2cXpICruVv5giRUEt9Lzgk/bIjXExcl5bShNaaC7M=;
 b=eD/kZkukblqhHzMrM0i/P77uJBNnl3oLV/e/jhK+3e7UuFuMBtMotUYBztB8iEuF8Xme0fEiEiUgxXuP0vKAHgaQOA6mZ7bEWhn8zjRx5EtWxZ1PO8WkHFnODhfGcRL+jXBbnnJsN/IZy1wmZfQ++DA5DLcL0RarzqRlULnfG2e97INphqhVAyRqkD8UOSJeIQGRRnnVgdIezi2taoFTqXZP5GZ+FBAqpgxFmT6c9f34oXpb0k0BNMgQD3fAH5bDiWdpViKy+cJyAANPYJuTP82lCgp5B3Q+l7odoinVGZoxyFo8EAtykCP7tuXpU54M4EjryuuV/I9XcZjOcqGKTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CO1PR15MB4955.namprd15.prod.outlook.com (2603:10b6:303:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Thu, 22 Sep
 2022 16:59:34 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5654.014; Thu, 22 Sep 2022
 16:59:33 +0000
Message-ID: <d77de53f-3dfa-b150-55e4-e03a97b193f7@fb.com>
Date:   Thu, 22 Sep 2022 09:59:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add test verifying
 bpf_ringbuf_reserve retval use in map ops
To:     Dave Marchevsky <davemarchevsky@meta.com>,
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
 <c6d6a452-0ee9-ee90-6415-1066bbfcfc82@meta.com>
Content-Language: en-US
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <c6d6a452-0ee9-ee90-6415-1066bbfcfc82@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR06CA0017.namprd06.prod.outlook.com
 (2603:10b6:303:2a::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CO1PR15MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd51d22-14d3-4211-8e2a-08da9cbbd299
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3gyVtu/o6RWPJAhuVqA9YMpIOd/cERhZA7Z/VH8CgmXnUfJXLjx0bnfCuvAL1gbUp5ZsLza/hNMesOfJhQsbkZqL8iTOpflO7V2fN09L2Uziye2T5q3RNW6EJaP5BPfC7b0JAv2eiyDZn+UtbnxNscxr6V3JSb7TYoojrb/VmHMPaskLopuqQatve71gYqjMVdKpt3puNnhL/1Y78pRL+3Y2Ol/XDqAJZ7mLh4PFeFb/RxjhNPRKR0R3XToE/TCqCoBnMUsY1ldZ9NMKvcgsViR5X/CXOl6lR0Ye6MY5gugjkjzbWXv2SKETG0xgfILX5YLkQDx+G8ZZe3IOficHf31QTlsJkwez27yjIrG76zKdT3Qg/t+PWtwgc6hOflIxXywYpTAJYubi/iGsD9eS52hTwsmHgjpgjTZUa3LmzuFmFcHQpgKTpqre6nOgKOXD9TQQc73wp1S/Y2KljrITEF9g5RLW3um+Jr7RJHRRPoCuAzKfB0zswDFyc0tXQ+XYZ2N+eZIfArsM27nTVIT7oTo2MrX28V3JN/t1bN/r852zSDc7C8Ae2lUZO1kBeGo7imvsXLxySeLfoFBoM4+F20oqTGacJOpnwfMYu0PIvDa42fZOCW41D9bIMWY7ZTfqibOIdhv0THzEWh+clnS6nkuXMmwJz/3ZHb91aygV3DlNC2v0WdesIztMAOSSaSaLIAMRMtXD9jP0OTeZZqsMgvdHwshyvjMe8OfnBiRwlBFzH0JNPTSEzBnGp1gg9fwz6dD8qfttFg3huSsc3cusuCS0LeyfC0uK3lk3D0dBVCSp8x77BXbP+Nh/6qzJTt8c2EVkd02dedGT5A37u1l5QQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199015)(54906003)(38100700002)(110136005)(84970400001)(66556008)(41300700001)(66476007)(66946007)(316002)(186003)(15650500001)(83380400001)(8676002)(8936002)(36756003)(6506007)(31696002)(4326008)(86362001)(6512007)(2616005)(5660300002)(2906002)(53546011)(478600001)(31686004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXlmelVQbGpFTUlDQTNiTHhBYk11RTV0MDBCWHprRTRlMDgxZVY2bDdNN0JR?=
 =?utf-8?B?RjVsTEtWSjB4c3pLeXFkaHIyaEY5RXYyZm5QL1VHRjhDeENmemhlSnZWa0NU?=
 =?utf-8?B?cGpLTVVUQkljNk1JU0VRWnZuVGIzbHBzTkI3TnRwMW1QMHM3bHBDM1Z0NGhk?=
 =?utf-8?B?UitoYmU0Z2FoLzNKZWRZNE1vSGF6VnM2NEltMXRzbEx6VWFEZVZiWHliL2VN?=
 =?utf-8?B?NFlhMStYb1JRMUNRamhacjg1ZFJCU0dOS1BlTDZ3c1NXTjFNbmJ5bWpGaUk1?=
 =?utf-8?B?YkpjUkpvd2JSeHdiRE1RV05LK1BJRFNvZ0FCYmJsYUQ5bUUyMUR4eEFBWlV2?=
 =?utf-8?B?WXR1SHc1MU5kWGhVMjRkdjJoOWUvdzdEZENEUEw2K0xROXgyaWNjd0RvNXhN?=
 =?utf-8?B?RWJzcVo2WVFtMFEwaWFPV3hUZXlLWkdIWFJCS293dFB5TFlQblZIL2YrNDh1?=
 =?utf-8?B?dEJiNytDbWtTRDZQTHpjcDdHQnpna1pmcjByVlh0ZHVkR0VwWHZLeUJnMzh2?=
 =?utf-8?B?UDd5ekg3Y1VWS0RtMTA4eWNaRGdKbUsxR29MdDJjWTBsODBBdTE5OUVFZlpW?=
 =?utf-8?B?ME5lL2hMbmlzTlJZQ3NWajdUOHdPSVVJNzBHS3oyc1ZjR1BHU2FvbzdDK0Zx?=
 =?utf-8?B?SSswUEc5OUZYWU9BUDUrRDl3K3ZyUTl4ZDFtOUU2Y2NzY2g3R0QralEraWVP?=
 =?utf-8?B?SWgraVRiY0tRUFlkN0V3aVVLMHg0c2xDME5oMmE2dGhFczB6eGFqVmxhS2ox?=
 =?utf-8?B?Ym03ZmVQTG9DdDVYYXpnUlhCdzhMMUg2cGl6NTBYMUtyaUZPdVM0cU5jTkNp?=
 =?utf-8?B?KythNkRybWtwM1Vmc2I2aWNTV29zZm1QRm9Za05wNFVhNTVwNWtFWmxBTkJy?=
 =?utf-8?B?cjFydHJxeFZxc1dtcmNnWFNJamdLOGRwQ3pPTEwvZ1hiM2xvRy9LSmF1ZFlh?=
 =?utf-8?B?L0kvUHZCNFdNT0ppR0l5bUE0L0RsSHpQaXkrd2FsOUlYV2FzYXVraDJYRHBo?=
 =?utf-8?B?OW1UUi80SnlCS2x5VkdpSWFNUDdCK2VHNWM0b2JxWkIycG9zUnRHUHQvd1Y3?=
 =?utf-8?B?MVhPdjIzOTFkdFZORy9KNC95cUUwaytrV0ZMRnh0VkRCTklsWGV0cjM3NHJq?=
 =?utf-8?B?ZVAvRm9MUG9BSE9JN0JsLzhBbSt2eUFaTHFPV1RFdjVaVDFKRmY4cVhxYVY4?=
 =?utf-8?B?K3h6eGoyeDl0SnpYRWlJakNia01NSmNQUy9TMGdWN1V1VXVRb0Zjc2M5cnB4?=
 =?utf-8?B?OUg3cHo4cXB3a3gvSEFRSmNEa1N6VmZXekJ3cGZoNmlYOUxMdGR1OXVacUdX?=
 =?utf-8?B?MFdlN0lTK3cwdmliWWtFMDIwWGp6L016end2OHVvYU9Cd1hhLzBVNmZSejR2?=
 =?utf-8?B?MmYybCtvS25leFMraHdKOXpjZW5jbG90M1BERGVQb3RnL0dnZlE0UG1aYk1j?=
 =?utf-8?B?bnAvZkVvWEd4QkFhVDBZMlFDU05JMzdud082SHpkS3lTQ2VwVW03N3VBSlJB?=
 =?utf-8?B?cVRyYnEzblZQS2dxWGEveXkrck1tSWJScjlVVEwxcVkxaWFTbmp4NURxdkRD?=
 =?utf-8?B?VmRvQ0NXS0RLQUhQTHVEdjhKYlprZU9XbkNsVEVSWFE0QzVZMnRjRjlkczE1?=
 =?utf-8?B?UTV0YUcvRHZaQWhydDNWUnF1ZnNaUHFWd3dWaTV4RVZrL21MN1phWUJ5WEIy?=
 =?utf-8?B?MUJXNUM0WWJKQkhWS05YZzNxTFRTK2JlaGpGMXhwMVdTTE9MdXVwZCtORGFM?=
 =?utf-8?B?anM2a1FoZzErWDczZlU0YkZ3dFFrVGRqRno1Rml3L3ZkQWNsTFdlSmxVNStS?=
 =?utf-8?B?Y1JUblhhd0NnNm8vUVgzN0x3YjFRaEIrVjk3aDcwcFZkOHFpOHU5c05PeWhB?=
 =?utf-8?B?UytrYWw1a1luV0FJM1ZBdW95YkhJKzcrWUZvRmxVSlFIRHBWZEVXY1RSYWtW?=
 =?utf-8?B?TUlOdFlNU25FREEycWpUUGNVSVQrNWlQUzRSWkxxa2tha2twUy9TekRhYkdv?=
 =?utf-8?B?MTk0VGh4cmtQbzlBK0NtRWh0THpQK1ptaHZSaG1GRHNLWkNiaFlZU1JIQzNR?=
 =?utf-8?B?Umh1UkpldW1zamNtckpOL0s5bitMYXlTZmRxWGYvS3ZYeWxJTEV0WlBrRFR0?=
 =?utf-8?Q?b0d2xn/GSI6NuXzDyCppxWCW6?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd51d22-14d3-4211-8e2a-08da9cbbd299
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 16:59:33.4005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZvpC1xLh8TC3zI0d/yp0z/Ja62b6xQqHSX6Uj+648YlPRrgCDo6VXvagq3Ibv6d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4955
X-Proofpoint-GUID: 5UDC9wpMZOczki5EnU38PPK8gWXwKkKb
X-Proofpoint-ORIG-GUID: 5UDC9wpMZOczki5EnU38PPK8gWXwKkKb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_12,2022-09-22_01,2022-06-22_01
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/22/22 7:27 AM, Dave Marchevsky wrote:
> On 9/20/22 1:50 AM, Yonghong Song wrote:
>>
>>
>> On 9/19/22 4:22 PM, Kumar Kartikeya Dwivedi wrote:
>>> On Tue, 20 Sept 2022 at 00:53, Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>>
>>>>
>>>> On 9/14/22 5:36 AM, Dave Marchevsky wrote:
>>>>> Add a test_ringbuf_map_key test prog, borrowing heavily from extant
>>>>> test_ringbuf.c. The program tries to use the result of
>>>>> bpf_ringbuf_reserve as map_key, which was not possible before previouis
>>>>> commits in this series. The test runner added to prog_tests/ringbuf.c
>>>>> verifies that the program loads and does basic sanity checks to confirm
>>>>> that it runs as expected.
>>>>>
>>>>> Also, refactor test_ringbuf such that runners for existing test_ringbuf
>>>>> and newly-added test_ringbuf_map_key are subtests of 'ringbuf' top-level
>>>>> test.
>>>>>
>>>>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>>>>> ---
>>>>> v1->v2: lore.kernel.org/bpf/20220912101106.2765921-1-davemarchevsky@fb.com
>>>>>
>>>>> * Actually run the program instead of just loading (Yonghong)
>>>>> * Add a bpf_map_update_elem call to the test (Yonghong)
>>>>> * Refactor runner such that existing test and newly-added test are
>>>>>      subtests of 'ringbuf' top-level test (Yonghong)
>>>>> * Remove unused globals in test prog (Yonghong)
>>>>>
>>>>>     tools/testing/selftests/bpf/Makefile          |  8 ++-
>>>>>     .../selftests/bpf/prog_tests/ringbuf.c        | 63 ++++++++++++++++-
>>>>>     .../bpf/progs/test_ringbuf_map_key.c          | 70 +++++++++++++++++++
>>>>>     3 files changed, 137 insertions(+), 4 deletions(-)
>>>>>     create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
>>>>>
>>>> [...]
>>>>> diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c b/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
>>>>> new file mode 100644
>>>>> index 000000000000..495f85c6e120
>>>>> --- /dev/null
>>>>> +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
>>>>> @@ -0,0 +1,70 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
>>>>> +
>>>>> +#include <linux/bpf.h>
>>>>> +#include <bpf/bpf_helpers.h>
>>>>> +#include "bpf_misc.h"
>>>>> +
>>>>> +char _license[] SEC("license") = "GPL";
>>>>> +
>>>>> +struct sample {
>>>>> +     int pid;
>>>>> +     int seq;
>>>>> +     long value;
>>>>> +     char comm[16];
>>>>> +};
>>>>> +
>>>>> +struct {
>>>>> +     __uint(type, BPF_MAP_TYPE_RINGBUF);
>>>>> +     __uint(max_entries, 4096);
>>>>> +} ringbuf SEC(".maps");
>>>>> +
>>>>> +struct {
>>>>> +     __uint(type, BPF_MAP_TYPE_HASH);
>>>>> +     __uint(max_entries, 1000);
>>>>> +     __type(key, struct sample);
>>>>> +     __type(value, int);
>>>>> +} hash_map SEC(".maps");
>>>>> +
>>>>> +/* inputs */
>>>>> +int pid = 0;
>>>>> +
>>>>> +/* inner state */
>>>>> +long seq = 0;
>>>>> +
>>>>> +SEC("fentry/" SYS_PREFIX "sys_getpgid")
>>>>> +int test_ringbuf_mem_map_key(void *ctx)
>>>>> +{
>>>>> +     int cur_pid = bpf_get_current_pid_tgid() >> 32;
>>>>> +     struct sample *sample, sample_copy;
>>>>> +     int *lookup_val;
>>>>> +
>>>>> +     if (cur_pid != pid)
>>>>> +             return 0;
>>>>> +
>>>>> +     sample = bpf_ringbuf_reserve(&ringbuf, sizeof(*sample), 0);
>>>>> +     if (!sample)
>>>>> +             return 0;
>>>>> +
>>>>> +     sample->pid = pid;
>>>>> +     bpf_get_current_comm(sample->comm, sizeof(sample->comm));
>>>>> +     sample->seq = ++seq;
>>>>> +     sample->value = 42;
>>>>> +
>>>>> +     /* test using 'sample' (PTR_TO_MEM | MEM_ALLOC) as map key arg
>>>>> +      */
>>>>> +     lookup_val = (int *)bpf_map_lookup_elem(&hash_map, sample);
>>>>> +
>>>>> +     /* memcpy is necessary so that verifier doesn't complain with:
>>>>> +      *   verifier internal error: more than one arg with ref_obj_id R3
>>>>> +      * when trying to do bpf_map_update_elem(&hash_map, sample, &sample->seq, BPF_ANY);
>>>>> +      *
>>>>> +      * Since bpf_map_lookup_elem above uses 'sample' as key, test using
>>>>> +      * sample field as value below
>>>>> +      */
>>>>
>>>> If I understand correctly, the above error is due to the following
>>>> verifier code:
>>>>
>>>>            if (reg->ref_obj_id) {
>>>>                    if (meta->ref_obj_id) {
>>>>                            verbose(env, "verifier internal error: more
>>>> than one arg with ref_obj_id R%d %u %u\n",
>>>>                                    regno, reg->ref_obj_id,
>>>>                                    meta->ref_obj_id);
>>>>                            return -EFAULT;
>>>>                    }
>>>>                    meta->ref_obj_id = reg->ref_obj_id;
>>>>            }
>>>>
>>>> So this is an internal error. So normally this should not happen.
>>>> Could you investigate and fix the issue?
>>>>
>>>
>>> Technically it's not an "internal" error, it's totally possible to
>>> pass two referenced registers from a program (which the verifier
>>> rejects). So a bad log message I guess.
>>>
>>> We probably need to update the verifier to properly recognize the
>>> ref_obj_id for certain functions. For release arguments we already
>>> have meta.release_regno/OBJ_RELEASE for. It can already find the
>>> ref_obj_id from release_regno instead of meta.ref_obj_id.
>>>
>>> For dynptr_ref or ptr_cast, simply store meta.ref_obj_id by capturing
>>> the regno and then setting it before r1-r5 is cleared.
>>> Since that is passed to r0 it will be done later after clearing of
>>> caller saved regs.
>>> ptr_cast and dynptr_ref functions are already exclusive (due to
>>> helper_multiple_ref_obj_use) so they can share the same regno field in
>>> meta.
>>>
>>> Then remove this check on seeing more than one reg->ref_obj_id, so it
>>> isn't a problem to allow more than one refcounted registers for all
>>> other arguments, as long as we correctly remember the ones for the
>>> cases we care about.
>>
>> Thanks for the explanation!
>>
>>>
>>> But it can probably be a separate change from this.
>>
>> if the use case this patch set tried to address is using
>> bpf_map_update_elem(), we should fix the double
>> ref_obj_id in the current patch set. If only
>> bpf_map_lookup_elem() is needed. Then we can delay
>> the verifier change for the followup patch.
>>
> 
> The bpf_map_lookup_elem() usecase is the only one critical for me, so I've
> submitted v3 without ref_obj_id fix. I agree that it should be fixed, but feels
> orthogonal to this change, and is probably best addressed as a verifier-wide
> fix affecting all functions as per Kumar's suggestion.

Okay. This works for me. The ref_obj_id fix can be a followup.
