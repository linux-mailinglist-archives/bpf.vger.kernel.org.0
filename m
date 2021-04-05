Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A53354509
	for <lists+bpf@lfdr.de>; Mon,  5 Apr 2021 18:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242333AbhDEQRw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Apr 2021 12:17:52 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47148 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238609AbhDEQRv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 5 Apr 2021 12:17:51 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 135G3QgQ015481;
        Mon, 5 Apr 2021 09:17:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=rg0nNktTPsplg/GZsIz/M99KDUM1r4nfFszRgSR2V9E=;
 b=I6arUfeo5eeVMp0TFsU0NjWt6rpYrzToiLJ8hSAEQMEZyUnN8Eq6Umgf1Ma0H579t4Nk
 FhMv5wh5JHdR8Or5hTik24I0UZnhfwhIclej3l1QYFYh2ITtuyWKVfclFTF39rkUJpor
 PxZo4l8y1Zf/8NSMqDufvQk09zFah9YwXQU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37r5300ak5-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 05 Apr 2021 09:17:41 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Apr 2021 09:17:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEjcSogAFrhJzop6+MQ9N8zGOhmMmRlx8uXUIiczVxT5fQUgQ+STx8Ec5C3ewK1PTK6GlriqlQUb+TYHsrLbLINYcKKRv/tMm6u9UUSTnZEYyP/4EKjRcezCanKEYHLdGIRmgwvVgdXrCC4SG4crdcOaeOxsYPm38khgfgylZ0qxz4xDt+UOeejK0Vzq2GJhqgbdI0uC5ttzmvRzvuW+l6CdTqpWMhADRejuuXEs4BRD3qjf7SboiGBS/vtxPCGRl+B0Sh27UWSlikvUfGzZk3Ga2wMchjxPi8nBM/e7/jEJ0o8GsGax+Jukgt+3qwpAkkjPmzN7wZZeKOcMUy2YCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rg0nNktTPsplg/GZsIz/M99KDUM1r4nfFszRgSR2V9E=;
 b=hpHE25nbWnpg71zPjNs7KJmzB5fBtZcvLqF9cs1NWPKZmchjJ5b2ddj0fMQWgjWHgjBt0WVZwvkPK2y3Li+nMRnI+Ki8XA3AbV21oKMgPzb2CjFszIEL6v2Wu9v9ACbayJs5cLuxu7xfoDaNUlPode7Xp70lygspU0ViWXscqIO4YupUO8uALlpHQ5N6VXABdTPtA8yrspSmDcugJXtU4UVArA3rUluqkYQW0WmpoalyNQsiVzZ8AevHVY7pdBaR2UI+YADLsUkK3Nfausn/eubxo2XXuFn5tyGLHZ4XZQXUeftkpCmmyEbNBhPoSxLKDdDgFf4xaPNVbUppbLr8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB4095.namprd15.prod.outlook.com (2603:10b6:805:56::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Mon, 5 Apr
 2021 16:17:36 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 16:17:36 +0000
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
 <458faf4c-7681-13eb-023d-c51f582bfec6@fb.com>
 <CA+icZUVcQ+vQjc0VavetA3s6jzNhC20dU4Sa9ApBLNXbY=w5wA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <b4963c83-df8a-630a-cc78-c72f6a388823@fb.com>
Date:   Mon, 5 Apr 2021 09:17:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <CA+icZUVcQ+vQjc0VavetA3s6jzNhC20dU4Sa9ApBLNXbY=w5wA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:7583]
X-ClientProxiedBy: CO2PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:102:2::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1149] (2620:10d:c090:400::5:7583) by CO2PR05CA0008.namprd05.prod.outlook.com (2603:10b6:102:2::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Mon, 5 Apr 2021 16:17:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 480cc575-8f43-4521-b0f4-08d8f84e534a
X-MS-TrafficTypeDiagnostic: SN6PR1501MB4095:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB4095E5DB89E51202B3A2953ED3779@SN6PR1501MB4095.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y/gDLbCbTOZ6/Rx+1bXGj4f1cFgXrBkJ4xEuZvNQG9hI8UBjnomkqWJPhuQ/b+ohstvUjoXe9McWcsL1mOu1L/h8NL0hvB+xXA+/xSEDiMIcfNVUkOZM7FNTbeJDxITxWV0fzix24OGqLsY/uOXiA4xf7lB9HSGBXUd087cXeV6vPkIlSgTOx0hr7263vfjm+gR89UXwerYVKljfvQ36js/QLZkuXcwJj2wQB3maGHBYMKX7h1tdwiQ0LUdu8Egir0+CBvqvQ9sf7YUDhanc9MCtTPx9EcTV68FTjgiRkVWkI9fPwkxea2GJDt7ItqVu4mnGDSnWURnK+yJBDyaB/TBxRd5GzPp6dWgqL6asOcxpJTFF4J+oeVAyi/1Vs6yslm3LOsYiTSYRNYt927YFD8yRHEfH/ENFVj21pSt4c4xPwVxnLY4w88DZOfsPsvAB+SF5kTbYucWHzsmP0TYqC2zMHBiBxb2CT+1v7W1voPshAFLAd1HKG+SFbv/gRbR54GQIiwXf9IBJNa04MiruOXH+zdE87a6IpkdH/iAHi/isFdWQUklotjuwHkk6OpiILcIDWK2d39Jjp+YUNuZXO3MgeXNrvuCvLQ9CJAUxr3LBqyDUq39/ztHvtFMrDaBHqX1rA9tMo6cYbO+xbmvCB3Yx/2jes1IASyqT9VJ1GkENt77S0a3Hv9M5n7kxFOkzQbvLqYB5T0Xtrbl3DV+tkuuqX9EhwKqdcuUchQLmv50=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(376002)(136003)(346002)(66946007)(31686004)(186003)(52116002)(16526019)(316002)(53546011)(86362001)(6916009)(8676002)(2906002)(36756003)(478600001)(4326008)(31696002)(8936002)(66476007)(38100700001)(6666004)(54906003)(5660300002)(66556008)(2616005)(83380400001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cFpMRVdiRk95TGlmbmxQeFZudWVTNDREank2NE1rT2xXc1FWOHlZZmFFRGFC?=
 =?utf-8?B?eVpla2ltY1pFVlFzQTF2aUZsbnBSOGNkSjJkRE9OTFMyT1dHMmsxeXI4Y1ZW?=
 =?utf-8?B?TnpvNnkvN25OOWM1MFk0anc1WisrOUxCQ1ZBWFMwckRTWGlQNDFiaVBucWxQ?=
 =?utf-8?B?SStmZENhbXhCdnhBcTQxZlNFWUlONXJsOVhFWlh0VG1jcXlDOHFWVTRyTU5K?=
 =?utf-8?B?SHFZUEVLT2tjMXVRT3IrWlR1Z0laK3ZxZHZrZkNMZFB4YXY4dGdqL1dmcU04?=
 =?utf-8?B?amI0bDRaRnRJUXRSL3JXbk1RWE9rb0twUGJxN0tFYzBtejI0d1FJV2xTakNM?=
 =?utf-8?B?MG1XaVJETm1tZEJKZGljOFNONEZZbWJGQUkzSGlQSVhMN1I2SDhNYnl3a3Jk?=
 =?utf-8?B?R3UraXBQT1FQRTZLVWczWWt4dDROVzRtaU8zZkp5dnBJZmdNR3hESWh4ampk?=
 =?utf-8?B?dUdVNTRNUUpVMTlwZlI1REFMMlp3RmNvQjNwd1JqTnRDN0JXRGNZeHJCaWUr?=
 =?utf-8?B?ZFVwdXZDVzNaTWVrV2ZWZlk1Y29hdkkyT1pFN0FkQTFXZVBjK2ZMbndlLzZq?=
 =?utf-8?B?R0llVkdIUlQrZTNhVlBiU0NxY25LcjZ3L1JrTC80VWFQY1RBemlwSlBGOWFw?=
 =?utf-8?B?WTB3YWI2OHh5Z0Z6MTd1cEg0dmF3bEQ4YWxWcXltZjFKZ1VEMU96Vkg2R04r?=
 =?utf-8?B?bkhvWUlxZy9jQkptUUFGeHo4ZlB2RWxVWTFLKzdkM0ZkSklwdC81bEV2My8r?=
 =?utf-8?B?bmFIVE1xbEMxUWV6Z0xsbE51T1VHenZaa0QrMCt2L0JVMmtCZGs2c1NDWXRD?=
 =?utf-8?B?M2VuZDBwZE9Ja3BDdmNjOStwdkdia0JXS29iQWR6VTlwVk1kenI1UFk0M0F0?=
 =?utf-8?B?dUxMN3RyYUhtSDY0WkFXMktuWm4yV1IxM1J5TkI3NXN3d25HdXZkSWk3b1VK?=
 =?utf-8?B?ekZtcG43U1ZVR2FOTDQwclgxZnR3SmdaRW1GODFGZHRxOFdLdnplSnJac2dL?=
 =?utf-8?B?QTNKTjgvZ0xYdTMyY1dwWklwdjNZMzJjYzQvUkxPSGppRFB1ZTJ1SWdlMCtC?=
 =?utf-8?B?eXVxdHVjZExOdTJ4cXN6aC92WVIvTGp0M0VNVVVFZ2Q3b3BLbVZoMFBMMzZ6?=
 =?utf-8?B?c2VWUGEySzUxZzdUQlhTdWYvbW81WjlUbDRaOC85aWNCVVBmaHJKWXh1bUFG?=
 =?utf-8?B?c1grQTlhenoyZkNZVHM3NEZCcFBJQnRzcG81dWxnVktaQnEveHRHRkdvSTNw?=
 =?utf-8?B?aU11aEVFOWxNRmJEd0NSUTlHRy9SeHZON1ZJb01BMHZlVXlUc05nTFF3L3BF?=
 =?utf-8?B?Y3R2bnZVQ21GSXdJT05TcmhsZ3V5RnI0K1I1ZWNOc1Bjb1hqaFRNRFJiOUxP?=
 =?utf-8?B?QkcxaXY1Y3RQMkFxalhXM3pSWFhXT2FkdTJwaXpsdExHd29NNjBFak9QVVlK?=
 =?utf-8?B?MlZ5QTlHZzlFdVl1SmlRc3JvaGIxOCtMQ3J3ZTEwMGpjRllsT1N2MzVHOVpL?=
 =?utf-8?B?SVNYRHF0RTZPdFRsaDYyN21Db25uWmhZb0R0cTZmWDcxUjlGN1NSR05XMlJn?=
 =?utf-8?B?VVJhQysyQWNmM1kwcVBXZVE5U2Q2YlYrcFpFOHZTVVhXSXFIb1JGdFNaaWYw?=
 =?utf-8?B?WitlQWM5WEV6R3BsbXVHRDZlVS9JRGkwcnVHQWZKaGZFYng4WkZPTVA1Z2Rm?=
 =?utf-8?B?MllaMXlGKzdBSHI1RVMzUWhCZjFnZGdVVkVwMFloaWd1WkxWSE4reUVjSmVY?=
 =?utf-8?B?OTcvZzFKemFiK05ROUlKWFZYSVFndG11TE5oMHVjdnlOL3NjS0xNbzVoRGFM?=
 =?utf-8?Q?117L7DUAFg3o1tyCDer/BefBstrg/kYwYNF14=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 480cc575-8f43-4521-b0f4-08d8f84e534a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 16:17:36.3355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +McH5hr5Vp18SGA4D1T7WkjXawtm/VQ2Qd5Osw3PVFDGktUWPnLaPuQkDbXYKulc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4095
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: RXoouRv1_dReYS77mfNBuA8KKG6Rei1J
X-Proofpoint-GUID: RXoouRv1_dReYS77mfNBuA8KKG6Rei1J
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-05_13:2021-04-01,2021-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/4/21 11:55 PM, Sedat Dilek wrote:
> On Mon, Apr 5, 2021 at 4:24 AM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 4/4/21 10:25 AM, Sedat Dilek wrote:
>>> On Sun, Apr 4, 2021 at 6:40 PM Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>>
>>>>
>>>> On 4/4/21 5:46 AM, Sedat Dilek wrote:
>> [...]
>>>>> Next build-error:
>>>>>
>>>>> g++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
>>>>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
>>>>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/b
>>>>> pf/tools/include -I/home/dileks/src/linux-kernel/git/include/generated
>>>>> -I/home/dileks/src/linux-kernel/git/tools/lib
>>>>> -I/home/dileks/src/linux-kernel/git/tools/include
>>>>> -I/home/dileks/src/linux-kernel/git/tools/include/uapi
>>>>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
>>>>> -Dbpf_prog_load=bpf_prog_test_load
>>>>> -Dbpf_load_program=bpf_test_load_program test_cpp.cpp
>>>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_core_extern.skel.h
>>>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
>>>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_stub.o
>>>>> -lcap -lelf -lz -lrt -lpthread -o
>>>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp
>>>>> /usr/bin/ld: /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a(libbpf-in.o):
>>>>> relocation R_X86_64_32 against `.rodata.str1.1' ca
>>>>> n not be used when making a PIE object; recompile with -fPIE
>>>>> collect2: error: ld returned 1 exit status
>>>>> make: *** [Makefile:455:
>>>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp]
>>>>> Error 1
>>>>> make: Leaving directory
>>>>> '/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf'
>>>>>
>>>>> LOL, I was not aware that there is usage of *** CXX*** in tools
>>>>> directory (see g++ line and /usr/bin/ld ?).
>>>>>
>>>>> So, I changed my $MAKE_OPTS to use "CXX=clang++".
>>>>
>>>> In kernel, if LLVM=1 is set, we have:
>>>>
>>>> ifneq ($(LLVM),)
>>>> HOSTCC  = clang
>>>> HOSTCXX = clang++
>>>> else
>>>> HOSTCC  = gcc
>>>> HOSTCXX = g++
>>>> endif
>>>>
>>>> ifneq ($(LLVM),)
>>>> CC              = clang
>>>> LD              = ld.lld
>>>> AR              = llvm-ar
>>>> NM              = llvm-nm
>>>> OBJCOPY         = llvm-objcopy
>>>> OBJDUMP         = llvm-objdump
>>>> READELF         = llvm-readelf
>>>> STRIP           = llvm-strip
>>>> else
>>>> CC              = $(CROSS_COMPILE)gcc
>>>> LD              = $(CROSS_COMPILE)ld
>>>> AR              = $(CROSS_COMPILE)ar
>>>> NM              = $(CROSS_COMPILE)nm
>>>> OBJCOPY         = $(CROSS_COMPILE)objcopy
>>>> OBJDUMP         = $(CROSS_COMPILE)objdump
>>>> READELF         = $(CROSS_COMPILE)readelf
>>>> STRIP           = $(CROSS_COMPILE)strip
>>>> endif
>>>>
>>>> So if you have right path, you don't need to set HOSTCC and HOSTCXX
>>>> explicitly.
>>>>
>>>
>>> That is all correct with HOSTCXX but there is no CXX=... assignment
>>> otherwise test_cpp will use g++ as demonstrated.
>>
>> This is not a kernel Makefile issue.
>>
>> We have:
>> testing/selftests/bpf/Makefile:CXX ?= $(CROSS_COMPILE)g++
>>
>> So you need to explicit add CXX=clang++ when compiling
>> bpf selftests with LLVM=1 LLVM_IAS=1.
>>
> 
> NOPE.
> 
> $ echo $MAKE $MAKE_OPTS
> make V=1 LLVM=1 LLVM_IAS=1 CXX=clang++ PAHOLE=/opt/pahole/bin/pahole
> 
> $ LC_ALL=C $MAKE $MAKE_OPTS -C tools/testing/selftests/bpf/ 2>&1 | tee
> ../make-log_tools-testing-selftests-bpf_llvm-1-llvm_ias-1_cxx-clang.txt
> 
> This breaks again like reported before:
> 
> clang++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/include
> -I/home/dileks/src/linux-kernel/git/include/generated
> -I/home/dileks/src/linux-kernel/git/tools/lib
> -I/home/dileks/src/linux-kernel/git/tools/include
> -I/home/dileks/src/linux-kernel/git/tools/include/uapi
> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
> -Dbpf_prog_load=bpf_prog_test_load
> -Dbpf_load_program=bpf_test_load_program test_cpp.cpp
> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_core_extern.skel.h
> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_stub.o
> -lcap -lelf -lz -lrt -lpthread -o
> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp
> 
> clang-12: warning: treating 'c-header' input as 'c++-header' when in
> C++ mode, this behavior is deprecated [-Wdeprecated]
> clang-12: error: cannot specify -o when generating multiple output files
> make: *** [Makefile:455:
> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp]
> Error 1
> make: Leaving directory
> '/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf'
> 
> Do you know some magic CXX flags to be passed?

I tested in my environment. The reason is LC_ALL=C.
Without LC_ALL=C, make succeeded and with it, test_cpp
compilation failed. Is it possible for you to drop
LC_ALL=C for bpf selftests?

The following command succeeded for me:
    make -C tools/testing/selftests/bpf -j60 LLVM=1 V=1 CXX=clang++ CC=clang


> 
> The only solution is to suppress the build of test_cpp (see
> TEST_GEN_PROGS_EXTENDED):
> 
> $ git diff tools/testing/selftests/bpf/Makefile
> diff --git a/tools/testing/selftests/bpf/Makefile
> b/tools/testing/selftests/bpf/Makefile
> index 044bfdcf5b74..cf7c7c8f72cf 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -77,8 +77,8 @@ TEST_PROGS_EXTENDED := with_addr.sh \
> # Compile but not part of 'make run_tests'
> TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
>         flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
> -       test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
> -       xdpxceiver
> +       test_lirc_mode2_user xdping runqslower bench bpf_testmod.ko xdpxceiver
> +       # test_cpp # Suppress the build when CXX=clang++ is used
> 
> TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
> 
> I have attached both make-logs with and without suppressing the build
> of test_cpp and the diff.
> 
> - Sedat -
> 
>>
>>>
[...]
