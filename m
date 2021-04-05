Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FB8353AF8
	for <lists+bpf@lfdr.de>; Mon,  5 Apr 2021 04:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhDECZG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Apr 2021 22:25:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:65530 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231656AbhDECZD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 4 Apr 2021 22:25:03 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1352MOah022404;
        Sun, 4 Apr 2021 19:24:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Ng3NDia9kc8eRUkldxcNLpEbznG7R9hpaWlP8ZmxgDc=;
 b=KB6394aZ+FtIaevPCHJqLTx9UKg0p3QQ0Cky3uFclMT5NJQW/8K+gLKLOKMBw22Y4Dok
 I0lVSOVSTMot3vQL/5mzPtPF1c9OJfq3XzudEagN7o9YOHJ3iLSi/O5WgPvuCNdjb44J
 LLKtujkkM4QmPwGbf9D3EQIQ/ov3U2ncTys= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37qnq68msp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 04 Apr 2021 19:24:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 4 Apr 2021 19:24:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imPrF80TVfR1GCPEPKF2I5g6D8mqCCSdbbopsW+cNyspRsiizO3l1dbLTonEZd66LdThZo/vMahTcjZwE9X4fHqogIPxhiBBKzEKiBzpqj5jfZnUewylE7zsLDEdN6tROGPjWPZqjnBZPHB8kivAS7T26Xc858YQl2WMiWx20pOmUO3sNFz85F5ys+d0iOxVkPf+HwcVdCz08hGXm3BzEW1Szp8nLKoFfLe63zp5lAELOrYx7Z+FqbMFi5oI01gaaOG3pw7SQ8AQ3PToZTvUmSclGgiNtL/QsSYLZh4Rz1qTTUotxhnwyr3ZvpEPHo36c9N8UF1NPwWec4NLv7S47A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ng3NDia9kc8eRUkldxcNLpEbznG7R9hpaWlP8ZmxgDc=;
 b=fqqWT4Zh5uFj5NmvKyM2ZVxmdC2PEc8cWx444mfrNWM7NpwkecS7m8ngf2vbBHatYbPJD9Zpc+t6C03eHBey5aO6ipkmTEVPgnm0Uh7EjQH0D3p+PYKc+V3rI4M9ij0Ufys5mDwBf4N35TcvJ54SlU2HNguWEYJnRGyrdYOBmxyHOsDuDNQxJuduBONtC6v2S100dHk59EVp3HJPHzecuK4O2/R9EmC3IuwzT7tT1argBzunGgncTpXmhRpDpJ0ha1d10vexyxlwUa049+RDNiuZiiKCZU2fSfgjEluLFYj+5P7G/o4dUzQoemPwJWR2zm719q/fiI9tF/F2MwOm5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2208.namprd15.prod.outlook.com (2603:10b6:805:1b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Mon, 5 Apr
 2021 02:24:49 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 02:24:49 +0000
Subject: Re: [PATCH dwarves] dwarf_loader: handle DWARF5 DW_OP_addrx properly
To:     <sedat.dilek@gmail.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>, <kernel-team@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20210403184158.2834387-1-yhs@fb.com>
 <CA+icZUWLf4W_1u_p4-Rx1OD7h_ydP4Xzv12tMA2HZqj9CCOH0Q@mail.gmail.com>
 <6c67f02a-3bc2-625a-3b05-7eb3533044bb@fb.com>
 <CA+icZUV4fw5GNXFnyOjvajkVFdPhkOrhr3rn5OrAKGujpSrmgQ@mail.gmail.com>
 <CA+icZUWh6YOkCKG72SndqUbQNwG+iottO4=cPyRRVjaHD2=0qw@mail.gmail.com>
 <f706e8b9-77ca-6341-db13-e2a74549576b@fb.com>
 <CA+icZUVb_J95Gk2Kf0i8waL6TDfJ2n9JrGbNK_dsN1n8HdcoXQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <458faf4c-7681-13eb-023d-c51f582bfec6@fb.com>
Date:   Sun, 4 Apr 2021 19:24:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <CA+icZUVb_J95Gk2Kf0i8waL6TDfJ2n9JrGbNK_dsN1n8HdcoXQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:ed0c]
X-ClientProxiedBy: MWHPR22CA0017.namprd22.prod.outlook.com
 (2603:10b6:300:ef::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1149] (2620:10d:c090:400::5:ed0c) by MWHPR22CA0017.namprd22.prod.outlook.com (2603:10b6:300:ef::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Mon, 5 Apr 2021 02:24:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21ec48fd-0b3a-457b-3637-08d8f7d9fce8
X-MS-TrafficTypeDiagnostic: SN6PR15MB2208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB2208E0023527BC4D4145A629D3779@SN6PR15MB2208.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3YvCMammu+hBnogOcMjcgyt5Vz5rW+/63gY/bix4p7CJzRZ/aW3AbScZGIx/Oi12tqapwUnfZlsXIZmm0Z05SCIBS2Dq6TA41IOGBJrGNaddBdj7Qc8gI9lBGbYFLngohh+KmzSjWpw6Xvql/at45bxQnKsIpn48r/5eXia2DE8Yhs/BC149Xf0vvqTkBjZWbHaEXr6I5b6WbEQIFA8kITsVndPv/Z9un1Vn7ff2ySyI5aZHC9UG+59j0ii8xbNP0pKbkTxvt05Sr3BG6Qt3OH0j3ZqhXX64mGjmAaneorbRd2EsGshvyIzXhtRoRTrirsJF8kp9pff8x+xIAf3B6lvf0h8RMdG2PYf7rgwTRv46lqWRliea0PSoAnYUK39yD0utFTqfFV6Jt6HOm0I3je9j49FkQ6bR/lGkHOM5NoZutG6Fqw10qHMsTl0w+o/7tvKoianyZjXHjougKrIHGM2ibBi/4+fcla8EAIwCWWcFUV+A2GEqAvmWLr6ZkS1S3Ekx84mHAxn71XHQfVRkwMDvvttM7VfKS4ZxIk4Au/4jMtEjTkm+gNYqxM69Kxon3IauozcxDK3XUd+HB9bxba+k6qY0EfqhesAxizEgg5jgQSvZD7rRH8hJA2vsOppi6/koV2PfTdKDp3M3jVYt+1UH76VMj8SNFAW7xNmOKV420yiY9MI1rCzZlAL0jBnt5eklFKqDCK8HtzeElZ1Bq8N3AKgCUgmggBdu3qPLg7J7gZg790rxiMFhYI3Bqs73wPkNwbCnVQ08LnMkUjGf+/CgOGAsU8gEWbRif8QM3ZY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(39860400002)(396003)(6486002)(83380400001)(86362001)(478600001)(6666004)(316002)(31686004)(5660300002)(186003)(6916009)(2906002)(52116002)(31696002)(38100700001)(966005)(66946007)(54906003)(66556008)(66476007)(53546011)(2616005)(4326008)(8936002)(36756003)(16526019)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WndFcU9TR1VNVmx5cFdiSVlwWWVDRWF4Zjd0ek15NldDM2JqbmVMSG9saG8y?=
 =?utf-8?B?T055aXE2VjFySWpZeUZrdlRrZXB5NUkvZ2hxaWhxNU4vOGcyWUtUK3Nha1hC?=
 =?utf-8?B?OEdmVmtZYVdBSWk2b2w1c3MrZWpvMmlYZnJBdHpJcS9US0JaQU1EREVVUTZK?=
 =?utf-8?B?c0NGQSsvM1Z6eDVWdXh4eWtEUFZ3OVZLc3B2ZVU4VHM3anJoKytDQ1plK04y?=
 =?utf-8?B?cGRaNHFpclZwOEFVdnUvNXdzcldrVzRaWVE5N0pTelNHeE95SUU0b2pkMkJY?=
 =?utf-8?B?bTZRZkNHV2ZocTlWZFpGeXMrbzV5T0ttSVp1Q3JKbFVhclZEY1psT0w5UkZC?=
 =?utf-8?B?ZHVTUnl4bHpYYkg3ODhDWENnd0hTOHVTUkhGZlpBUWlBTjRTZUdFRTd6M3hN?=
 =?utf-8?B?L3UvRmQzclBJbm1EV2h0b3BFQUM2WElaU3hySnhIWW5ZN0lWQUNQc2IzU0x1?=
 =?utf-8?B?bUMwaERaL2l6WXFlWDgzeXNGb1NnR3pvVndpOHJHem1DTzFzNEczellZeGc2?=
 =?utf-8?B?MnNuZFVXYUtTK3BPSWd1NWFnZUVWYTJyWGhZcmZ3alU0TFo1M3p1NUdzd0Q2?=
 =?utf-8?B?dU1ITXBjQkdDSG5BakUvWjZ5Zk9nZ0twZ2hMNVh4VnpyTE1hN0h1K01QeTA5?=
 =?utf-8?B?T0MzWXNRekt0WkhFTVFuZHFpQk5GZ1BXeTRLYmJOTndIYXE5d1YzUWJ1VlFa?=
 =?utf-8?B?QU81eGsxQW5FU2d0RnY2SkFHeFN4d0lsdnhaRkpVQnBXaVRnaTc1U0FyR1FM?=
 =?utf-8?B?UEJxQzN1L01QLzZWb1p3VnRTd3F3Q2R4Mm1kRmV1SnA0NWJkbDNkaWRlNEo0?=
 =?utf-8?B?M0ViaDZCbUNSbHhGdTNrVlR3YTdEZUMycGs4b3ZxRDI2ZDBoWkZFenJNUzJl?=
 =?utf-8?B?MG0vSjFoV0N6a2s0QlA2MldxRGRaUVZaSDhjczQ5Y05Iam5Yc0M3SEVHSGtG?=
 =?utf-8?B?SUUvUHF2QVM3S1FVeVpraklzdWF3NVdOVDBGZitPbkpXdDk0bVMxZVFrSEcv?=
 =?utf-8?B?UkhZa2tKTG8vRml5bk9SNkQ1LzZpbk5FdmREbDQ0N09NTU5iaUpKVEcvZXdi?=
 =?utf-8?B?bWdMb3c2ZnB6ZHhPV0gvZjNVZlhwYUFQZnN0bklJNS9LcEo5SW83SHRFVU8v?=
 =?utf-8?B?L3N4M2hLa2JHVGNJYjRwK0NJN2o2QjROd0lNUmViaytwckUvbnZRRFMwQllU?=
 =?utf-8?B?eHZIczFsU2thdDJsZXhSWDV5bmFRNkJqRmcxZlF1S1ZkQkVNZVo3YXZ6SS9p?=
 =?utf-8?B?aUNDMTZTN2FndHd1ZWhweFRHVWJkMjFaSERMeVlSbVdjbGdQVTRybE8rWEc2?=
 =?utf-8?B?c1A0RmQvL1RhNjgxSWJ3emxHbkgrbFc1UkRCN1RzSWVVV0t3Z2ZHR0UwSFJs?=
 =?utf-8?B?U080eDBiTTdENnhJbmNqWFZMZkVJR21YaURzQ0Y1MWZ2Z25tYy90MzEvazI2?=
 =?utf-8?B?QWV5em5FNmhZTmRFWnVidjQxa3VadXNNREZqcHVld2JzaXZEOVlhWjduNTEx?=
 =?utf-8?B?QUlMUStIRDhWeFVRMHBsdExXSWsra0hXMGNkS2dDVStDWm5QajJ4NCtiTjM4?=
 =?utf-8?B?NUtDU1Q2aGU2eTdsMUVyT2ladERPTG5xdGZlMWd3SjFnNURSVmZHVm1GVE1D?=
 =?utf-8?B?SDd4Z2VkMmd2dlhrTzdNNWxkYktkQi9taUViV3lDcnhieEQycG1Sc2dwYnY0?=
 =?utf-8?B?R1Y0TjY4dzRtQUlkckRuWnI0cmU3MXBtRDBHUHJDMWZkV3lJU0ZXRDBlQkE2?=
 =?utf-8?B?TFdENDZMZUtkMVFHM2wzcVlncE8yeTFlWTN2cVk4MmxESmRtTURPaEFQNkZz?=
 =?utf-8?B?T25hSGlUYkdlaVFVOW54dz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ec48fd-0b3a-457b-3637-08d8f7d9fce8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 02:24:49.8044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2bZ+EymEtJhvgxWDYZZqvEInXgEB7rIavwjhRXbznp/cT8mAFt5MahPxfCxCe1FU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2208
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: _kUiwxg4nqbSWJY6JVS7iKM8Y6BLyhkQ
X-Proofpoint-GUID: _kUiwxg4nqbSWJY6JVS7iKM8Y6BLyhkQ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-05_02:2021-04-01,2021-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104050014
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/4/21 10:25 AM, Sedat Dilek wrote:
> On Sun, Apr 4, 2021 at 6:40 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 4/4/21 5:46 AM, Sedat Dilek wrote:
[...]
>>> Next build-error:
>>>
>>> g++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
>>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
>>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/b
>>> pf/tools/include -I/home/dileks/src/linux-kernel/git/include/generated
>>> -I/home/dileks/src/linux-kernel/git/tools/lib
>>> -I/home/dileks/src/linux-kernel/git/tools/include
>>> -I/home/dileks/src/linux-kernel/git/tools/include/uapi
>>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
>>> -Dbpf_prog_load=bpf_prog_test_load
>>> -Dbpf_load_program=bpf_test_load_program test_cpp.cpp
>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_core_extern.skel.h
>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_stub.o
>>> -lcap -lelf -lz -lrt -lpthread -o
>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp
>>> /usr/bin/ld: /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a(libbpf-in.o):
>>> relocation R_X86_64_32 against `.rodata.str1.1' ca
>>> n not be used when making a PIE object; recompile with -fPIE
>>> collect2: error: ld returned 1 exit status
>>> make: *** [Makefile:455:
>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp]
>>> Error 1
>>> make: Leaving directory
>>> '/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf'
>>>
>>> LOL, I was not aware that there is usage of *** CXX*** in tools
>>> directory (see g++ line and /usr/bin/ld ?).
>>>
>>> So, I changed my $MAKE_OPTS to use "CXX=clang++".
>>
>> In kernel, if LLVM=1 is set, we have:
>>
>> ifneq ($(LLVM),)
>> HOSTCC  = clang
>> HOSTCXX = clang++
>> else
>> HOSTCC  = gcc
>> HOSTCXX = g++
>> endif
>>
>> ifneq ($(LLVM),)
>> CC              = clang
>> LD              = ld.lld
>> AR              = llvm-ar
>> NM              = llvm-nm
>> OBJCOPY         = llvm-objcopy
>> OBJDUMP         = llvm-objdump
>> READELF         = llvm-readelf
>> STRIP           = llvm-strip
>> else
>> CC              = $(CROSS_COMPILE)gcc
>> LD              = $(CROSS_COMPILE)ld
>> AR              = $(CROSS_COMPILE)ar
>> NM              = $(CROSS_COMPILE)nm
>> OBJCOPY         = $(CROSS_COMPILE)objcopy
>> OBJDUMP         = $(CROSS_COMPILE)objdump
>> READELF         = $(CROSS_COMPILE)readelf
>> STRIP           = $(CROSS_COMPILE)strip
>> endif
>>
>> So if you have right path, you don't need to set HOSTCC and HOSTCXX
>> explicitly.
>>
> 
> That is all correct with HOSTCXX but there is no CXX=... assignment
> otherwise test_cpp will use g++ as demonstrated.

This is not a kernel Makefile issue.

We have:
testing/selftests/bpf/Makefile:CXX ?= $(CROSS_COMPILE)g++

So you need to explicit add CXX=clang++ when compiling
bpf selftests with LLVM=1 LLVM_IAS=1. 


> 
>>>
>>> $ echo $PATH
>>> /opt/llvm-toolchain/bin:/opt/proxychains-ng/bin:/home/dileks/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
>>>
>>> $ echo $MAKE $MAKE_OPTS
>>> make V=1 HOSTCC=clang HOSTCXX=clang++ HOSTLD=ld.lld CC=clang
>>> CXX=clang++ LD=ld.lld LLVM=1 LLVM_IAS=1 PAHOLE=/opt/pahole/bin/pahole
>>>
>>> $ clang --version
>>> dileks clang version 12.0.0 (https://github.com/llvm/llvm-project.git
>>> 04ba60cfe598e41084fb848daae47e0ed910fa7d)
>>> Target: x86_64-unknown-linux-gnu
>>> Thread model: posix
>>> InstalledDir: /opt/llvm-toolchain/bin
>>> $ ld.lld --version
>>> LLD 12.0.0 (https://github.com/llvm/llvm-project.git
>>> 04ba60cfe598e41084fb848daae47e0ed910fa7d) (compatible with GNU
>>> linkers)
>>>
>>> $ LC_ALL=C $MAKE $MAKE_OPTS -C tools/testing/selftests/bpf/
>>>
>>> This breaks like this:
>>>
>>> clang++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
>>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
>>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftes
>>> ts/bpf/tools/include
>>> -I/home/dileks/src/linux-kernel/git/include/generated
>>> -I/home/dileks/src/linux-kernel/git/tools/lib
>>> -I/home/dileks/src/linux-kernel/git/tools/incl
>>> ude -I/home/dileks/src/linux-kernel/git/tools/include/uapi
>>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
>>> -Dbpf_prog_load=bpf_prog_test_load -Dbpf_loa
>>> d_program=bpf_test_load_program test_cpp.cpp
>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_core_extern.skel.h
>>> /home/dileks/src/linux-kernel/git/to
>>> ols/testing/selftests/bpf/tools/build/libbpf/libbpf.a
>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_stub.o
>>> -lcap -lelf -lz -lrt -lpthread -o /home
>>> /dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp
>>> clang-12: warning: treating 'c-header' input as 'c++-header' when in
>>> C++ mode, this behavior is deprecated [-Wdeprecated]
>>> clang-12: error: cannot specify -o when generating multiple output files
>>> make: *** [Makefile:455:
>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp]
>>> Error 1
>>>
>>> OK, I see in bpf-next includes several fixes like:
>>>
>>> commit a0964f526df6facd4e12a4c416185013026eecf9
>>> "selftests/bpf: Add multi-file statically linked BPF object file test"
>>>
>>> ...and to "selftests: xsk".
>>>
>>> Finally, I was able to build by suppressing the build of "test_cpp"
>>> and "xdpxceiver":
>>>
[...]
> 
> OK, I started a fresh build with LLVM/Clang v13-git from <apt.llvm.org>...
> 
> $ /usr/lib/llvm-13/bin/clang --version
> Debian clang version
> 13.0.0-++20210404092853+c4c511337247-1~exp1~20210404073605.3891
> Target: x86_64-pc-linux-gnu
> Thread model: posix
> InstalledDir: /usr/lib/llvm-13/bin
> 
> ...with latest bpf-next as new base.
> 
> I applied your/this pahole patch "[PATCH dwarves] dwarf_loader: handle
> DWARF5 DW_OP_addrx properly".
> 
> Will report later...
> 
> - Sedat -
> 
>>>
>>> [1] https://git.kernel.org/bpf/bpf-next/c/2ba4badca9977b64c966b0177920daadbd5501fe
>>> [2] https://git.kernel.org/bpf/bpf-next/c/a0964f526df6facd4e12a4c416185013026eecf9
>>>
