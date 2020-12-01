Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA612CA993
	for <lists+bpf@lfdr.de>; Tue,  1 Dec 2020 18:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbgLARZ1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Dec 2020 12:25:27 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52544 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726303AbgLARZ0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Dec 2020 12:25:26 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B1HJbG4001152;
        Tue, 1 Dec 2020 09:24:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=nbWlXMjOfEjYIyzDloeI5FfFtHxSrJtGQfRCbIpWhSs=;
 b=hAxQ9FQCL79Zxw7r2rjtyER5AOUuitfNZMNBC5mt+IRCfpAZazCCI084/Xh5h9lr3nhw
 kq+j8kozIxi/B+e7ruLzhLfPxGeuI7B257J7TQceo8osP7lcfKn5AxEt1f1l59sCGjHh
 cTLrQQcW5Cdr89kpxZeoAii5MLh9+zrUunQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 355agsn6wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 01 Dec 2020 09:24:28 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 1 Dec 2020 09:24:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flom3ZHAaoYHwD33mHSswJCV/56h+6+u/W1EtHDxsrcERxC5lLNCCWyPC/4AyMxkXiEKD8yvB0k04JwOCXtc7d/idM9GNia9mi4uZqnG1mqlvJqmdDKyavbnxeuCCodGa9Z60JbiARXH3Bid3MrF3EKja0hrvaGJS9hXlZylQPEcK7p0gTnFaEWq+zmSEYbDNudb1Lz+vONqq3BkBqDEA5nJIZtJ3xeNSG4260vtFLxYL80+bL/wS+vrO5Bl4nI0E4zM3SmtQHUoKafB14RNGrm7JnBmRWe/60vRiAIm+QIE3+fCZLiZG2kj8CyLJQxmrlDsADVwpgiyleSQ3tcjVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbWlXMjOfEjYIyzDloeI5FfFtHxSrJtGQfRCbIpWhSs=;
 b=bycjkFymABiAa77qi2+7KkHl3dq5W9Iw1lywaE23r26SC1HbU4GUChkl176Hvkhx4kRvLO7S4nH/NAjO2IleDHQQQvnxmB6zJWxEAFk5stoECdRmKqYA5h0XG+6t9Aivosv15bFYymKL7/5qECUHRBQaIml5qUq0zY/2A/vnJAzRK93SzZRnTWoo7iy6OKaGTs4gLT2XD+V1hJlfIu11ByLZ3uzy3y6Fa0MLcMG+G3fOd6vYjUXmVxCTy7Ye33YmsZ8HnVMlBcIgSnj04m1KFdp5TEZFU5uD90dHlNiy4ozZi9G5XCVOeU9DQ5SysYHe0uw9teYVr/a/dPU7vV4egQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbWlXMjOfEjYIyzDloeI5FfFtHxSrJtGQfRCbIpWhSs=;
 b=adw5f7TUeoCRBaKvmpZgOZza50C+A7W4mkES7/SIBUcC9odnIv+dq2Mpmv4pz2BVHVb/o8nokSSTPQAFz3fwI33W0Fo+X7LTe8xT5TEiDxhr0Agi6c2kqXgkv8XKuovgGg2oSunHM5rJL/EMlRTdBTdq36RNCfoytIuNYXRgNaQ=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2453.namprd15.prod.outlook.com (2603:10b6:a02:8d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Tue, 1 Dec
 2020 17:24:26 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3611.025; Tue, 1 Dec 2020
 17:24:26 +0000
Subject: Re: [PATCH v2 bpf-next 12/13] bpf: Add tests for new BPF atomic
 operations
To:     Brendan Jackman <jackmanb@google.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-13-jackmanb@google.com>
 <1e1656a9-6f0e-f17e-176c-37d996641e9a@fb.com>
 <20201201125642.GH2114905@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <745df1cd-d771-9eda-eb96-3731cb5da36b@fb.com>
Date:   Tue, 1 Dec 2020 09:24:23 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
In-Reply-To: <20201201125642.GH2114905@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:40d7]
X-ClientProxiedBy: CO2PR06CA0059.namprd06.prod.outlook.com
 (2603:10b6:104:3::17) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::1841] (2620:10d:c090:400::5:40d7) by CO2PR06CA0059.namprd06.prod.outlook.com (2603:10b6:104:3::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Tue, 1 Dec 2020 17:24:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09ef9f91-9978-49fe-400d-08d8961df3f8
X-MS-TrafficTypeDiagnostic: BYAPR15MB2453:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2453B2B523D9213524EFC00AD3F40@BYAPR15MB2453.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbGqcofdr2CzqDlldIu9fRkn2ndQdgt20/GSGAFtpPmmWL/HZc7FXID59funwFJ4FxsHUDnFtH1EBlGrIRZ/mJNKBc7TU13ZdY4/QImkCVoXtcYBAqM9rW1ZxuWV0QqxKdO1dAiVouB1KVJeu/DY5Gtn3vuGZmXhWtv1D2G7x7E+7q9POSlMxViMhk18fjeXfxmG+G09Fqb0QlJ1JZGS3Oa0oc7xcJaDLR4bhUMVG02aYOOtT3OefiduWs4nZPliLzPRE7VbbUnbfA7wwvFRNggZUFbRrDgbjBGLPJ/+wOQJBBZYPunzqsBhMs9jKrmCxC/2dNNPVDWz5Yhe8mfaRcie7oH43JGUAm7CctWfubyzbqXD78ONTn/EdfqGqr5S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(136003)(396003)(346002)(16526019)(52116002)(478600001)(36756003)(53546011)(86362001)(83380400001)(66556008)(66476007)(66946007)(316002)(31686004)(4326008)(6486002)(5660300002)(186003)(2906002)(6916009)(8676002)(31696002)(2616005)(8936002)(54906003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UjU0bHFzaHBIUVJxL3E3b0pVSVl5am9pWEZhZmM0N0RpVmc4VGhTTU5iS3pi?=
 =?utf-8?B?VkZuZ2dFV2FvMHVUT3ZGSmZXWTFDdFIwOWZOc0xvQWpkTG04K0JRZW5CQUV1?=
 =?utf-8?B?MGJpbmg5OVdia0lGZVNkcDhpZHQzNUU3eUVydkpCUGdPRWc2aTFTZkJTVHNq?=
 =?utf-8?B?ci9UU0hmcjhMekxwd0dYZEp3RzlRSVpub0tXMmFvSWt4ZUlzSklvSEUwZTVF?=
 =?utf-8?B?aC9GNTFDQW1YWmJya0V1WjZBalZ1eUs5Ri9ESUJpRnArVDEwNVBTaUZ4MVFB?=
 =?utf-8?B?S1plSll2MGNyMEQyckxPNlJpS2QxcFR0cnpkSHIxWjdnS0RNRUwrR2dMRGhq?=
 =?utf-8?B?UGJUVnpIeGovWEsrQVNlSHZwWVdXOEY3SXV1dEpWM3pmUzl3SGZ5NXF1Zlgx?=
 =?utf-8?B?Z1BnRHlhMUtPa0hvamJCVVNnVkRjWUF3aXFzbEJnYy9pVktLRmdTOFZTMkYr?=
 =?utf-8?B?SHp4V2ZhQ0VZbHBLbGRqblVLamt4M3JyVVU5bEVuZzVmM2tzTzJ4amJBUVE5?=
 =?utf-8?B?a21KdS9HRU1JSGpFSWpkc0g5dGJnOFdzMjV1TjA5L0hNL1ZscEtDcVR5RzBr?=
 =?utf-8?B?bFpzOVkyS2t3cjVUbWI3U1pXd1Nqb2hlWGx3dTFMZTJWNnhsR05zOE9wZXU3?=
 =?utf-8?B?RXRYdWJidStDSmVFemloYTZjRXE0bmViZlpsZEF6cDcvSUJPdCtaRmIydU5Z?=
 =?utf-8?B?ZEVTTFV2RWFCMWdJN3FlSG9pcU5ESXgxMFArUGFBMXY3dlNuWjQrcE9ETkt3?=
 =?utf-8?B?dHdSaWFnem9ZOEl5UTlybkdDc0V0Yk1KQUxlNy9ac1Nldmt2aFMzZ255Z0FM?=
 =?utf-8?B?ZUZUckFWbEp3SlRqdGFCLzNPTVFRSDlVMHduaXJkZno4MWVTWkxpYWRmckpG?=
 =?utf-8?B?MjhxNnZ5Z0IyKzV6M0UwUHlxdS9aTkdseDhYY2FveTRrcDFqbGdpZHhCekZo?=
 =?utf-8?B?UjQ1aGU0cVdWc0I0TzJBS3Vrc2Ivb01UYWxLTUhMbk1TZVJYRW51MUdpZHRo?=
 =?utf-8?B?Zzc5dDFXRm9GbXI0dStaT2I3a25KcmlLZ1M3QXluYXhtT2xPUXBIODBuVXBz?=
 =?utf-8?B?Q2I1bU9valFCTllIR05qTFJ0MUJnM2didCtiSFlJamNpMTZldjdTVi9jUjlP?=
 =?utf-8?B?NnQxVkFsWmI2bk1PcmhNd1BZQzRMVnhIc2FGay9uTEMwaFhsTUoyQXRseXYr?=
 =?utf-8?B?QTQvczVPb1huSkFLZVhOVHp2d0RCL1VXVDJjYVJkL2RmeS9NQWg1cUtLaWNh?=
 =?utf-8?B?cm1NTjBrMlRNTXJ0NWFwVjU5OHZJZ1JyTTY2TFNiUlVKRkxHQTFHbUkyNndF?=
 =?utf-8?B?UkVJK3lkZ29JK3o5VzNJVVBhYzBLeW1pbDJsOFFNcUMwUmJSamIrOGtYNFh2?=
 =?utf-8?B?S1ltOFBQN0FmU0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ef9f91-9978-49fe-400d-08d8961df3f8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2020 17:24:26.5925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oc771iaZ1wgMQeF71TbPmOPmcA0DT+sAhPxHBeF6EvuyO0eeGxjuV3kyelJbg+07
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2453
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_07:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010106
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/1/20 4:56 AM, Brendan Jackman wrote:
> On Mon, Nov 30, 2020 at 07:55:02PM -0800, Yonghong Song wrote:
>> On 11/27/20 9:57 AM, Brendan Jackman wrote:
> [...]
>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>>> index 3d5940cd110d..5eadfd09037d 100644
>>> --- a/tools/testing/selftests/bpf/Makefile
>>> +++ b/tools/testing/selftests/bpf/Makefile
>>> @@ -228,6 +228,12 @@ IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null | \
>>>    			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
>>>    MENDIAN=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
>>> +# Determine if Clang supports BPF arch v4, and therefore atomics.
>>> +CLANG_SUPPORTS_V4=$(if $(findstring v4,$(shell $(CLANG) --target=bpf -mcpu=? 2>&1)),true,)
>>> +ifeq ($(CLANG_SUPPORTS_V4),true)
>>> +	CFLAGS += -DENABLE_ATOMICS_TESTS
>>> +endif
>>> +
>>>    CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG))
>>>    BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN) 			\
>>>    	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)			\
>>> @@ -250,7 +256,9 @@ define CLANG_BPF_BUILD_RULE
>>>    	$(call msg,CLNG-LLC,$(TRUNNER_BINARY),$2)
>>>    	$(Q)($(CLANG) $3 -O2 -target bpf -emit-llvm			\
>>>    		-c $1 -o - || echo "BPF obj compilation failed") | 	\
>>> -	$(LLC) -mattr=dwarfris -march=bpf -mcpu=v3 $4 -filetype=obj -o $2
>>> +	$(LLC) -mattr=dwarfris -march=bpf				\
>>> +		-mcpu=$(if $(CLANG_SUPPORTS_V4),v4,v3)			\
>>> +		$4 -filetype=obj -o $2
>>>    endef
>>>    # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
>>>    define CLANG_NOALU32_BPF_BUILD_RULE
>>> @@ -391,7 +399,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c	\
>>>    TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
>>>    		       $(wildcard progs/btf_dump_test_case_*.c)
>>>    TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
>>> -TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
>>> +TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) $(if $(CLANG_SUPPORTS_V4),-DENABLE_ATOMICS_TESTS,)
>>
>> If the compiler indeed supports cpu v4 (i.e., atomic insns),
>> -DENABLE_ATOMICS_TESTS will be added to TRUNNER_BPF_FLAGS and
>> eventually -DENABLE_ATOMICS_TESTS is also available for
>> no-alu32 test and this will cause compilation error.
>>
>> I did the following hack to workaround the issue, i.e., only adds
>> the definition to default (alu32) test run.
>>
>> index 5eadfd09037d..3d1320fd93eb 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -230,9 +230,6 @@ MENDIAN=$(if
>> $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
>>
>>   # Determine if Clang supports BPF arch v4, and therefore atomics.
>>   CLANG_SUPPORTS_V4=$(if $(findstring v4,$(shell $(CLANG) --target=bpf
>> -mcpu=? 2>&1)),true,)
>> -ifeq ($(CLANG_SUPPORTS_V4),true)
>> -       CFLAGS += -DENABLE_ATOMICS_TESTS
>> -endif
>>
>>   CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG))
>>   BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)                  \
>> @@ -255,6 +252,7 @@ $(OUTPUT)/flow_dissector_load.o: flow_dissector_load.h
>>   define CLANG_BPF_BUILD_RULE
>>          $(call msg,CLNG-LLC,$(TRUNNER_BINARY),$2)
>>          $(Q)($(CLANG) $3 -O2 -target bpf -emit-llvm                     \
>> +               $(if $(CLANG_SUPPORTS_V4),-DENABLE_ATOMICS_TESTS,)      \
>>                  -c $1 -o - || echo "BPF obj compilation failed") |      \
>>          $(LLC) -mattr=dwarfris -march=bpf                               \
>>                  -mcpu=$(if $(CLANG_SUPPORTS_V4),v4,v3)                  \
>> @@ -399,7 +397,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c
>> trace_helpers.c      \
>>   TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read                          \
>>                         $(wildcard progs/btf_dump_test_case_*.c)
>>   TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
>> -TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) $(if
>> $(CLANG_SUPPORTS_V4),-DENABLE_ATOMICS_TESTS,)
>> +TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
>>   TRUNNER_BPF_LDFLAGS := -mattr=+alu32
>>   $(eval $(call DEFINE_TEST_RUNNER,test_progs))
> 
> Ah, good point. I think your "hack" actually improves the overall result
> anyway since it avoids the akward global mutation of CFLAGS. Thanks!
> 
> I wonder if we should actually have Clang define a built-in macro to say
> that the atomics are supported?

We are using gcc builtin's and they are all supported by clang, so
"#if __has_builtin(__sync_fetch_and_or)" is always true so it
won't work here.

We could add a macro like __BPF_ATOMICS_SUPPORTED__ in clang.
But you still need a checking to decide whether to use -mcpu=v4. If
you have that information, it will be trivial to add your
own macros if it is -mcpu=v4.

> 
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/atomics_test.c b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
>>> new file mode 100644
>>> index 000000000000..8ecc0392fdf9
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
>>> @@ -0,0 +1,329 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +#include <test_progs.h>
>>> +
>>> +#ifdef ENABLE_ATOMICS_TESTS
>>> +
>>> +#include "atomics_test.skel.h"
>>> +
>>> +static void test_add(void)
>> [...]
>>> +
>>> +#endif /* ENABLE_ATOMICS_TESTS */
>>> diff --git a/tools/testing/selftests/bpf/progs/atomics_test.c b/tools/testing/selftests/bpf/progs/atomics_test.c
> [...]
>>> +__u64 xor64_value = (0x110ull << 32);
>>> +__u64 xor64_result = 0;
>>> +__u32 xor32_value = 0x110;
>>> +__u32 xor32_result = 0;
>>> +SEC("fentry/bpf_fentry_test1")
>>> +int BPF_PROG(xor, int a)
>>> +{
>>> +	xor64_result = __sync_fetch_and_xor(&xor64_value, 0x011ull << 32);
>>> +	xor32_result = __sync_fetch_and_xor(&xor32_value, 0x011);
>>> +
>>> +	return 0;
>>> +}
>>
>> All above __sync_fetch_and_{add, sub, and, or, xor} produces a return
>> value used later. To test atomic_<op> instructions, it will be good if
>> you can add some tests which ignores the return value.
> 
> Good idea - adding an extra case to each prog. This won't assert that
> LLVM is generating "optimal" code (without BPF_FETCH) but we can at
> least get some confidence we aren't generating total garbage.
> 
