Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F29610747
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 03:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbiJ1Bdh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 21:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbiJ1Bdg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 21:33:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA44BA98EF
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 18:33:35 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RMnAh6023083;
        Thu, 27 Oct 2022 18:33:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=UWt8F89peCwf3XjWLgrX3BCY/CHtfFp0aLIpgg91z1k=;
 b=JkO5nO3PCetxTnaU8EHdqcZCTW3pagmn7wN29cHtpcztAEwa5zlHJoYmR2hViln9aIYx
 jwKfpQlHE5tQQWOZuAL6ab/lJiryh96Ed2ZB2shj6dBeaqyf98tVPdJ2/ANZ6JADVc82
 8D8NM4RX5eKV4JrvfqJfkTi9rQ3uct4V4/X25sciXM5YICnfRfD18V0SClu81fvcvvk+
 9I9cyhr8OL/4phEP2fzDbh/ZlApwIOjwr8G5zA84TrL9mfoqhx9p8jFf1n1/92d8yumc
 yBaqHVsrEIpyXTRkTUS7lUTu5bzskZA0Vqj3HCs51haKwidjvEs0EbwIDInVKXKuWD2r Hw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kg23yhxf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 18:33:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TS6i3Ec6crF4ODZJ8AjRDRjjSRDq60v4CCkUWNELRA7423SjVBZGvlIflkQen3jF/CKXGN/dnuOhkTCdquJy4F5IOoN45Sf9LLeWxYCdTXj7yOruA6nFyk7NNmo/R3/Yufy+NdqAmVTUBkELeyL58TlHiKfyEqa3htKIBiIyqoaf7HX+WpCe9efC5uazsVT+etapKnKMfh4NEgQOx7elQMBBapb1yFDQgTtlCtc0l3HRmajh7zzgJuqlyYt0Tm2yXYjxLdYgUHGDstwp6weygNPveslaAOewmthmOxZt0fA+xfr8+0HlbO7gBwtSXwuVS7ypWrCll4XQay3SBoRYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWt8F89peCwf3XjWLgrX3BCY/CHtfFp0aLIpgg91z1k=;
 b=YREK8PwqUjfbG9fNzWZlre757wtLbRc1P9B1bF6nKS6aV4R/OPYEOslldPjYB+llV4efF6R4H2lO6eCpO835o6eazlzsUJM3ls66RZAgwcFIlfAdvECBkc/HqGoQfYj/uby4xO79c3nOZM0wGfUdq73Hnjn158bRCodVR2/1NTC6nPpQzUOnoTcwWs1GKYRGF2FedGTzgwcOvUoyVIvvWlbf4plKQGPS4fw228bZ2hwuEoODnXZgMHoRHLBGlXu5dXwli4a+fyes1WDDr7gdBZGUFvF0ZUf5ymfeyZKF9sRm3Lu8rZnIaRglwnQnk5lXSHlPrpquQvq9jPmfXlLi4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN6PR15MB1874.namprd15.prod.outlook.com (2603:10b6:405:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27; Fri, 28 Oct
 2022 01:33:18 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26%5]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 01:33:18 +0000
Message-ID: <f62834eb-fd3f-ba55-2cec-c256c328926e@meta.com>
Date:   Thu, 27 Oct 2022 18:33:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [RFC bpf-next 00/12] Use uapi kernel headers with vmlinux.h
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        arnaldo.melo@gmail.com
References: <20221025222802.2295103-1-eddyz87@gmail.com>
 <CAEf4BzbScntAd4Yh5AWw+7bZhooYYaomwLYiuM0+iBtx_7LKoQ@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAEf4BzbScntAd4Yh5AWw+7bZhooYYaomwLYiuM0+iBtx_7LKoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0190.namprd13.prod.outlook.com
 (2603:10b6:208:2be::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BN6PR15MB1874:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec64d23-03cf-4560-9610-08dab8846419
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJruCy268zPsM1Scl8vqnA6+iHh86Rtygf+cJGmYLcuwDQ9yICtSIxgu9GM4PJHtEw26C+EPRf+DT/0pbpEDk9yqJyC6gyoP1QeDBGUG3ZRIsHbVvSOZ9pH0w27wOlsaGJZYukPtXnBxmg/O67+8bhuSYGHfijpX4ZiIOBxDt4ZBRBvrd4O+T80gEWmx0up3DjN5kVgk7cGMCkK6+pNobTI0RPYO5BAZGb1pZsxbWsABXrOBQZ+UMIyHIn8Q4KEIMoaWKt8i0kn25Adb4r4Z1FgQA+60Wcj7N54b/MfqZ4FeusorazDUs6itttgB3tr/Tc84ZiEnK4AN0ZR+hhVluXt4jIWVoT7mrlijIvPOWHvlh6aNAcqhfkOM9xEGk7Xq6YliqeUayNhMQ63sDYiKny1g7jzfkKEKW8mS06G9i5At1CLWF8D4sAvvo8Nv1p7bcDu1FrP1FT835QTrBX/n2FWjW9B05IpwoXhL9rATdhrMZedBuWnKaeHWrqbSOA6d4kOSgPlFAZpAY506eNblKJCSa9ewFk6eLR+aZm5VJ8miuC47R3VtQsXN1xx0u8HzJtA+cjbeM3XJ2DJyJBuLTj4ksugUY6mZyfF+FFqQYjsPJR8LbXQmhwPvDz57KoBG0rMxM9l48pQ5i4JZ2IriqABuY4TR+Y/83V6Ot4DcBB9ATk9OdGC4ZTVFhBHb8BuhJkc1jZ935LxANq3uPNMyrCuWRryLPBIsrNL+K66nLXjWZWGxN3UcaWd80SS1Sy244Do1HMvYD5NWG+RZirq45c1fku29GdB3UEQ5MQ3LCz0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199015)(478600001)(6486002)(5660300002)(6666004)(31686004)(2616005)(6512007)(53546011)(31696002)(4326008)(38100700002)(86362001)(36756003)(6506007)(110136005)(186003)(83380400001)(316002)(8936002)(41300700001)(8676002)(66556008)(66476007)(2906002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0JDL29kaFRuTno1R2RzT0Z3UmtnVVYrOWxMUTN1ckV6Yi9mM2VlaTZuR3px?=
 =?utf-8?B?UzRNNDBBY2JhV04xZEhFckhIWkVFY0hjdTFmcGJ2eFJ3UG55b0dIUnFlWVE4?=
 =?utf-8?B?QzRWZjhFeS9YMmdIaUx2aXRLNlV2R1p0akZ6OWhQREVwYzZsUlZFbkFEWkZD?=
 =?utf-8?B?Yjc5N3QvTlh2a3dXbHRIYlNzSkVPalpPQitaUjdRNlNRVFdybnhuWXFhczVw?=
 =?utf-8?B?UGdKTEgwMkUvd1k3SXdOMWhBUUJGRkVWRzRsVGNoREg5d3U0cCs2QlFvU2Uy?=
 =?utf-8?B?dXNzMk8zVGNFaW9XTWRYSVR1S2h6MFZRVzIxVWNnc1RYU0RvaVJNYXBaRUFz?=
 =?utf-8?B?d1dBbE4vSWlET2NrMEkraXNMQ0pzOGluK1Rud0lWaEMrZExvVGhEdmxUM2Zu?=
 =?utf-8?B?VWY0ak8xSnRNaEw3SmZCNjlSSnNUSjA3ejBxZlRUZjM1MWdGRUJKNUZYSVlM?=
 =?utf-8?B?T200eDM1Rjc4cUxTSlFGRmdsUExaY1paU1lJVEdYWXQ4RThxV1hzczEvbnF3?=
 =?utf-8?B?eU9QY3J6NGZYMytvNGdYdXJJdGtJSURmS3ZQV1YzQ1o0ZXBrUU1jTlg0SEpX?=
 =?utf-8?B?WW1INGVpRGFDZmtTUVlHRWxqcUFvT2kyUm5sVTF4TithOEsySzd0Y2x4bGNZ?=
 =?utf-8?B?SFgwc3ZOMDlrbU1ySXdCOE1UU3FSTThkSmgwSERzUmdUeEpIbDRHaTZHL1Ew?=
 =?utf-8?B?TEhseG1xZlNoQUFMRUlIaGdJakpsQ0IvbzdUdEZrWDJhRDd1TUVDa2dXNExT?=
 =?utf-8?B?bDl3ektPR1plVG9oQzNCOWowdVFUbU95elk1eG80TkZYcCt2VWdwbWI5dzlv?=
 =?utf-8?B?Z2VpQmJ4SlJIK09wOE90YmlpcnBPdEZhSjMvc3Bha2dUTjliQTV4Mkx2M2F1?=
 =?utf-8?B?MlhFVHVWWjFtOFpJTTBmUExZbXRrcTFqd2ZES2hKYmkvZTNVZ21pNmljV01V?=
 =?utf-8?B?eG5ITXZ5cnR2NVFlak9TeWlXV2p6bk5aNTVIMjQzRW1ocFhLSkRvTytTb0sx?=
 =?utf-8?B?TUl4TTlvZ2xJdHhzUllpeXZHYkgwaFRvZ2lJdlgzSTJYRWkzOWJlUVJmeTgw?=
 =?utf-8?B?OERFZVlFS0NtUTU0ZUFGTXlnYU5Sd1kzUFVJT3hNcHNqeWFBZkFqc2hSY2RZ?=
 =?utf-8?B?TldLQkRvblM2UmpBd0dpN3k2dm1zd05IaFJ6T1N5Y1YxZk85dDVnTkNQay9z?=
 =?utf-8?B?L3pLNVY5b3dPblFBR010Rk8xampSamdVdUVMLzdtTC9tbEp4ZXY5VHhoZ2R3?=
 =?utf-8?B?cm4vUHRrc2NPd29GRU9JYk1GM21rWmswVEtmU25iUjdaNTg0RWdBM2RrS3Yz?=
 =?utf-8?B?UkNabkRwWWROT2plZko0dlhJa0QrVStUaHFXMElKRCtJVW5SK1BXODR5Y2k2?=
 =?utf-8?B?Um5NclpwaXFJaVVnOGF2M3RvLzZBVVpPTmtVOWNsd1ZRYlNqNEZGdTVhSjFI?=
 =?utf-8?B?MXp1MXJHNzNiM0JLenZIZi9UU3JXRGg3bjd0d2wxRlgwS0V4K2RMbmFJZ2xz?=
 =?utf-8?B?dTI3bis5d2RNMnFYc3ZkWC9LZVRWZzV1c2FDZmNSTjdud3pxdW8xWWVTejlv?=
 =?utf-8?B?N1Y4WTJoU0JaeUJ6V1B6TTFJb2M1a0EwTlkrdWRWVGRmN3R0ckViMkdUbmtq?=
 =?utf-8?B?bmEwMW5waFFOWWp0Z1BqSlhRY3J6eHYvYUtuVVFPWkx5Njl4TzNnSm4xb0VU?=
 =?utf-8?B?elhKb0ZhNjUzY21ES2Vjc0EwYzBpMlJyMWNPdU44YUNQcXh1YnIvdEQ4UXVD?=
 =?utf-8?B?a1VCdStDejJuK3hoUTJSVHR0YkdFbkwzbzhpb1JHTjJiS3ovWVlmeUd5L01V?=
 =?utf-8?B?c0ZPWEtXSStjeHhZSG9PTGhSelJLUFdpYWRqRHdNRzdnOWhocE1Xbzd6bzlC?=
 =?utf-8?B?ZDNIRUU5M3hjcjhiZTQ5TVB3cDRjMXVyKzF4SzJwSmp0RXFyUUlmNEZaY3Mx?=
 =?utf-8?B?bHJwR0h4TlBlc0x1eFIzMzQ0RjlDQ0dWMG50THdmdUJOVEpkU2YyQndVKytQ?=
 =?utf-8?B?Z1NQRHdIT3NqVFR3MjRSTXhtTlc0ejUvcGpSTDBYRk1URGh4YUdvMDZLdlNs?=
 =?utf-8?B?Qm1qRnEyV0Nua0xLUG9MWFNFY0pVNGdhbEErT0Z4OEZrSHIwMkwyaHZoNTNO?=
 =?utf-8?B?T3JkcDRDR0h6MENQK3FFNTNQWW1TYjBtV2JxVFk3TXVHcGVDc2tWQm5Pcllw?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec64d23-03cf-4560-9610-08dab8846419
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 01:33:18.2032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9f9CzRpmu9LZlACJn30KHp/7Kh/QXZ+nrMd/tcFHioe9sy1xILqAIeOkL9WJSoLx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1874
X-Proofpoint-GUID: 33zUBRT4TdisLoSPB-yQgLY2DCMbopun
X-Proofpoint-ORIG-GUID: 33zUBRT4TdisLoSPB-yQgLY2DCMbopun
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/27/22 4:14 PM, Andrii Nakryiko wrote:
> On Tue, Oct 25, 2022 at 3:28 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>
>> Hi BPF community,
>>
>> AFAIK there is a long standing feature request to use kernel headers
>> alongside `vmlinux.h` generated by `bpftool`. For example significant
>> effort was put to add an attribute `bpf_dominating_decl` (see [1]) to
>> clang, unfortunately this effort was stuck due to concerns regarding C
>> language semantics.
>>
> 
> Maybe we should make another attempt to implement bpf_dominating_decl?
> That seems like a more elegant solution than any other implemented or
> discussed alternative. Yonghong, WDYT?

I would say it would be very difficult for upstream to agree with
bpf_dominating_decl. We already have lots of discussions and we
likely won't be able to satisfy Aaron who wants us to emit
adequate diagnostics which will involve lots of other work
and he also thinks this is too far away from C standard and he
wants us to implement in a llvm/clang tool which is not what
we want.

> 
> BTW, I suggest splitting libbpf btf_dedup and btf_dump changes into a
> separate series and sending them as non-RFC sooner. Those improvements
> are independent of all the header guards stuff, let's get them landed
> sooner.
> 
>> After some discussion with Alexei and Yonghong I'd like to request
>> your comments regarding a somewhat brittle and partial solution to
>> this issue that relies on adding `#ifndef FOO_H ... #endif` guards in
>> the generated `vmlinux.h`.
>>
> 
> [...]
> 
>> Eduard Zingerman (12):
>>    libbpf: Deduplicate unambigous standalone forward declarations
>>    selftests/bpf: Tests for standalone forward BTF declarations
>>      deduplication
>>    libbpf: Support for BTF_DECL_TAG dump in C format
>>    selftests/bpf: Tests for BTF_DECL_TAG dump in C format
>>    libbpf: Header guards for selected data structures in vmlinux.h
>>    selftests/bpf: Tests for header guards printing in BTF dump
>>    bpftool: Enable header guards generation
>>    kbuild: Script to infer header guard values for uapi headers
>>    kbuild: Header guards for types from include/uapi/*.h in kernel BTF
>>    selftests/bpf: Script to verify uapi headers usage with vmlinux.h
>>    selftests/bpf: Known good uapi headers for test_uapi_headers.py
>>    selftests/bpf: script for infer_header_guards.pl testing
>>
>>   scripts/infer_header_guards.pl                | 191 +++++
>>   scripts/link-vmlinux.sh                       |  13 +-
>>   tools/bpf/bpftool/btf.c                       |   4 +-
>>   tools/lib/bpf/btf.c                           | 178 ++++-
>>   tools/lib/bpf/btf.h                           |   7 +-
>>   tools/lib/bpf/btf_dump.c                      | 232 +++++-
>>   .../selftests/bpf/good_uapi_headers.txt       | 677 ++++++++++++++++++
>>   tools/testing/selftests/bpf/prog_tests/btf.c  | 152 ++++
>>   .../selftests/bpf/prog_tests/btf_dump.c       |  11 +-
>>   .../bpf/progs/btf_dump_test_case_decl_tag.c   |  39 +
>>   .../progs/btf_dump_test_case_header_guards.c  |  94 +++
>>   .../bpf/test_uapi_header_guards_infer.sh      |  33 +
>>   .../selftests/bpf/test_uapi_headers.py        | 197 +++++
>>   13 files changed, 1816 insertions(+), 12 deletions(-)
>>   create mode 100755 scripts/infer_header_guards.pl
>>   create mode 100644 tools/testing/selftests/bpf/good_uapi_headers.txt
>>   create mode 100644 tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/btf_dump_test_case_header_guards.c
>>   create mode 100755 tools/testing/selftests/bpf/test_uapi_header_guards_infer.sh
>>   create mode 100755 tools/testing/selftests/bpf/test_uapi_headers.py
>>
>> --
>> 2.34.1
>>
