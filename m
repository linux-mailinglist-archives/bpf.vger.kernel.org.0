Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E1335D7CC
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 08:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344884AbhDMGNA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 02:13:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20528 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229748AbhDMGM7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 13 Apr 2021 02:12:59 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13D69GO7005970;
        Mon, 12 Apr 2021 23:12:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=BfWuaezEglzZycC0clKIvLN8mLgqbtDzY9/2v3rf1jA=;
 b=Z99fEE4EkiPIQuAIjudM4Ctq8Bv+3HSoxuiqd4Lsyl7Cmyeq5hwzNg2m46TBp/F+rq1u
 Mv2s1CPlN9gFundn8XL5bgULd5Ms/b2T1FpV+WfmT0dkU7NZY/F2hSn0HygIE1/tQiYB
 F0XY+vMhA8HIQRlt9zzKqITs7DyUvIDjNOc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37vrp3v2km-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Apr 2021 23:12:36 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Apr 2021 23:12:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaG7vzrT+8F6bjPt7qNoQeCy2AfZp+bZnjXniv56d9Ix9YNWbFoiDZQ5Nt0aKpxFZ29+jVkgohFkxQ2PkTSGdscanJ5vaWS5PSHgr8G2lCX9N8jEKwHEgUtm4DKZP1r7RjCDUcwtHPJAklSIoRrY5TWuFhmLP375pXqfUmzBI8Uc7vQpPC+SoKJFgijiCSOfUgCGhSWHNLILr+wmcBJ8gFuiNBWoyEebpGjhLpDOw23l4dcacGBM/eEISfjy3uwTahGabC2JuILzsf00AIitiJ2dmMmAi744iXnwDNNl9bsTalPV1b93k9uaizUY49TwH94sB2UJuOZp6P4hYgEncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfWuaezEglzZycC0clKIvLN8mLgqbtDzY9/2v3rf1jA=;
 b=nYRzCp+2iMJWUfQC/sOJFIBks73Vrefw7YF5HetpZUhEoVPO+aWAGVs6as4PEhQXYip8z+Si9BV18FwL1s9PfvoiyYy/n5cZWlkOZegGWheYn4GUZ8mPDGIAdi+XHnqR4u74Ou6/In+rNKhxvZessLtkTmNNBkiyRaVmcCJ7dHOVivW64BlxHPzC5dITHECcPW+2lXxZaGhwPdnR11wXuTSYf0oxr/6GDdEzkPk3j++tA4CKm2nooXUiNCNunaX9TOt2bpKvFkNuP4cdorRdO3qArEv23o1FvSI1G0Ul0HuxplrEL7/ElkRj4HRgGJEgwYPpKKEpKa4OdDonJc0Siw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2157.namprd15.prod.outlook.com (2603:10b6:805:8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Tue, 13 Apr
 2021 06:12:30 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.033; Tue, 13 Apr 2021
 06:12:30 +0000
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: fix test_cpp compilation
 failure with clang
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
References: <20210410164925.768741-1-yhs@fb.com>
 <20210410164940.770304-1-yhs@fb.com>
 <CAEf4BzbhbAhRqfkqrzXODVr=ETm7MmwpTDZ5jKd=bGmFvU9G7A@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <0d97da89-4e29-7274-4970-ce6f79a43242@fb.com>
Date:   Mon, 12 Apr 2021 23:12:26 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <CAEf4BzbhbAhRqfkqrzXODVr=ETm7MmwpTDZ5jKd=bGmFvU9G7A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:5ac8]
X-ClientProxiedBy: CO2PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:102:1::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::1a0e] (2620:10d:c090:400::5:5ac8) by CO2PR04CA0006.namprd04.prod.outlook.com (2603:10b6:102:1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 06:12:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c05d03c-87cb-4cad-833d-08d8fe431e8a
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2157:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2157985F2FB2D0A76F65A894D34F9@SN6PR1501MB2157.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xVzRHkGfAdqqcayymA9jEpnqjm5AOWc+Bp7oGH1q6WVNOgLfTX3AthDWWh5Ulu7mspovxGcp9bTvzgwVd83uinyRIMIrwufIhfskFW1FPdDIsJnbWbR23lMzxPku28h++jts7Q1Bdy3xazQBBQio199fvfhxLHttVHM8r4nqQEu1RTzUqJPBEKblqZnfagSDENYh6EVTTEke9sUS1PY5tpcQdIjDHnLBrMqLmdXgZu+LrKA8c1/3uly1HWtW3iy7zfVfdJNORZsYWEtI8Vmck1fxiVu62O+4Al9D6AqNPUAF110XKfil7rEAPFg1T0ZHl/sHY8Jv3H01Y46Z4zZ2q4+oK6vW8TiqGaj8a7XWV9A5jaEVGNy29Dp1nAWkEqRaS4rvDaRb7hfhmNv/FAWdJdm/YJu8Ovnoeu8qtzSUrRe3KtRu99UCFY4t0t+k7Z9dYC5SQ5zfcPecNWceueRzxghtWPEqJmrClZBQEXvQKYchj2u8n6vKQg/Nrzxu7OqA8RAElwvTwJSQ1scIiOx+rJlNEx/lqJYzZ5ht2nEzMUKh07wN0HZLVaGsnx4SxMp/HyFYRKn3AJaLnxKgz7hmL6OC8pZ2IRzREyKaVASAZ6ffZXS9PmGyDysXmgVD+y3uiCrjwBULjD+1uLBoGafl/8CqaKMhfDPykkGlOgAdeJGPRHaRqId/nLfx9p2DvXij
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(366004)(376002)(136003)(66476007)(6486002)(31696002)(66556008)(66946007)(2616005)(16526019)(52116002)(36756003)(186003)(316002)(2906002)(38100700002)(478600001)(86362001)(6666004)(8936002)(83380400001)(31686004)(4326008)(8676002)(5660300002)(6916009)(53546011)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SktLMkFuSkhCREUvcURQSGtOUnZtanBNNkVJdzlqbVdadElQa3RXYWU1OEFq?=
 =?utf-8?B?U1RyUHpQWVlZS2JJUDFjajVTV096U25MdXNtcm90OVk1S1RkanBNeGtRMThU?=
 =?utf-8?B?OExodi9NNjN5OTQ2eVl2K2NEQnYzbWN1ck0xQ0k4UXBrcUNmYVdjMHd2Z2JF?=
 =?utf-8?B?MnErdHZtMmFqdEx2cVJzT2hiY2lqWGpaVG02cWF5dzI0Qi9JaG9RendCTzYy?=
 =?utf-8?B?R0Y0eW9wRkRhNWlpZFdNZ2hkWFB2bHJIZVNHYUVSZVR2QjV1aFV4Y2lmWlg0?=
 =?utf-8?B?Q0JiRW51VldJcnhaTVVuOEU4S0RnYXZzdGpobUR0VDNmUk52ZE95TDZQeW9p?=
 =?utf-8?B?VU8rLzBCVWVSTklUZnJZamFPUmZaNS96b01KeGg1NFJHQzdscUxHVTZuUzVS?=
 =?utf-8?B?YUJLME1vaDhQRG9vZFdqN1BOYlV0Y0crQXh3WkU3Tm80WUlTSVZKVFNsQ0h1?=
 =?utf-8?B?SDJrWTBaSVhCa2gvRXpvdXRDTGdJN0R4S1FiOU9qL3N2VTRPN0dYZ2RsdUVG?=
 =?utf-8?B?YVFiclBOTVVveG80U1JHbmwvWktZZUtqdDJIZXh5RXZLN0lYVnFlOExEaUp2?=
 =?utf-8?B?dGh3SzlKNmprM0pobzBBTGwvSDd4eXN4aVk1WWh5blZqczBMd2pMSCt4bTFV?=
 =?utf-8?B?Wmo1WSszUmlpazJ4U1pJRmdvZTFVWGJqWnJlRDNLNmYvQkZ1dHdUNEtZUURw?=
 =?utf-8?B?L2VlS0RwM2dKWGxXc0VxbnFvaStQVmdPYUR1NjhwNEpMMTlLYkhrdzhpQ3Zz?=
 =?utf-8?B?Z2JpRXV4NUI5bFVVMXU1d1FuWXlYL0d4cVgzMzhFUWhRQTZXZmFrYktzVDJU?=
 =?utf-8?B?SWp3Ui9sNnJnRkluaFRDZ2UvOTJaZEQwdkY1eUJqMGNrM3BBMFU5a0JmWmIr?=
 =?utf-8?B?MHFBb1psMml0OGdrc1llWWZsMTIxSGc0M3hYcVhuKzFiTWVJTVdHd0p3UDhQ?=
 =?utf-8?B?OUhKVFo1UEZxRHVWcnJ3Z0QwTVNEak1OOURYNE1MV3JvZFE2aEdsU1YwTU9u?=
 =?utf-8?B?WU1TU212M2VzUjNsRWJNWDNJa2hHUTFOdkpQNFJTSFFZdEp6TDZuMndyRU5h?=
 =?utf-8?B?VEgrc0lNdTl6T0p5YWNmclRJLzBqK3pDalp4UjZ2ZFVxeXpyaUdoalVvYnVX?=
 =?utf-8?B?cFRtdGdiVmtib0hMdmlkSEQxRXFyaDdpNEh4K0R2aVpLRVNsaFQ2ZWZNQ0hB?=
 =?utf-8?B?SFdaSFE4cmxoektPUllTL2hkSGI0NUlKcU5xK0U2bFE4RHd2WU9rWHhYSGVC?=
 =?utf-8?B?YzhvTDdyV2twQWYvd0ZveEUyc0hDT1VjZFM0bm5oOGFYVkRDMG9WeTljN0Y2?=
 =?utf-8?B?YlBDRWJSZVViNWdPYXVVcmtqV1E2RGs4eTlUZHFqNDFyRG1UaFk2L01QTGRx?=
 =?utf-8?B?REJiZlFiQ2Z2OStMTHJvdExFc3RRTTkrczhlMDU3ZGxBWGtzbUMzMjQxajVL?=
 =?utf-8?B?OTRNTzZFN0hYZ05HZHIvTmJ4OXZZRjg0SUp1bjRRMkFvT1JJWkhnTUxRNmpi?=
 =?utf-8?B?T2N1RmRuSWd5VmNrUEd4VmQyUmw4Lzk1amZZRE9XblJPYkVjT3Z0QVoyYUVw?=
 =?utf-8?B?MTg5S3BvRTdlYTJKS0JhMC9pNW5DdDdNSlhuM3V5QWtYbExSNGh6cWdzOHND?=
 =?utf-8?B?UVJtVHMyQk5jVmw4R08wTmhIb3NNZkFCMlh6TTc0S3BQZDBZc1UxYmc4Ylc5?=
 =?utf-8?B?MDJIRGVJZm9OYklBc2JSblJVbGpKaEMxUlRlUEFZVURLOHlUM1Y4OTZRVHVw?=
 =?utf-8?B?eGQwT3pvTUxvSWZ6anVDM3VuVVllcWtkL2RONEtDcVNtWC8yN3J6MzRUTkQw?=
 =?utf-8?B?My9iaXZMdHBwUkcvdkJxQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c05d03c-87cb-4cad-833d-08d8fe431e8a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 06:12:30.3172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7d1bveWEmXyWKJjoKL2t10tX935dvEKn1rPeXNjguZONJo5rm03WInj1qQxoIMN/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2157
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: rJJhX2BBGCW7-_ribPy0SWvOHyXEAi0m
X-Proofpoint-GUID: rJJhX2BBGCW7-_ribPy0SWvOHyXEAi0m
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_01:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130043
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/12/21 9:32 PM, Andrii Nakryiko wrote:
> On Sat, Apr 10, 2021 at 9:49 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> With clang compiler:
>>    make -j60 LLVM=1 LLVM_IAS=1  <=== compile kernel
>>    make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
>> the test_cpp build failed due to the failure:
>>    warning: treating 'c-header' input as 'c++-header' when in C++ mode, this behavior is deprecated [-Wdeprecated]
>>    clang-13: warning: cannot specify -o when generating multiple output files
>>
>> test_cpp compilation flag looks like:
>>    clang++ -g -Og -rdynamic -Wall -I<...> ... \
>>    -Dbpf_prog_load=bpf_prog_test_load -Dbpf_load_program=bpf_test_load_program \
>>    test_cpp.cpp <...>/test_core_extern.skel.h <...>/libbpf.a <...>/test_stub.o \
>>    -lcap -lelf -lz -lrt -lpthread -o <...>/test_cpp
>>
>> The clang++ compiler complains the header file in the command line.
>> Let us remove the header file from the command line which is not intended
>> any way, and this fixed the problem.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/testing/selftests/bpf/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index 6448c626498f..bbd61cc3889b 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -481,7 +481,7 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
>>   # Make sure we are able to include and link libbpf against c++.
>>   $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
>>          $(call msg,CXX,,$@)
>> -       $(Q)$(CXX) $(CFLAGS) $^ $(LDLIBS) -o $@
>> +       $(Q)$(CXX) $(CFLAGS) test_cpp.cpp $(BPFOBJ) $(LDLIBS) -o $@
> 
> see what we do for other binaries:
> 
> $(filter %.a %.o %.c,$^)
> 
> It's more generic. Add %.cpp, of course.

Okay, although I will remove %.c.

[yhs@devbig003.ftw2 ~/tmp/tmp2]$ clang++ -c t.c
clang-13: warning: treating 'c' input as 'c++' when in C++ mode, this 
behavior is deprecated [-Wdeprecated]
[yhs@devbig003.ftw2 ~/tmp/tmp2]$

clang++ will warn if trying to compile .c file.
g++ 8.4.1 doesn't warn. Not sure about latest g++. But it is not
a good practice to compile .c files with c++ compiler any way.

> 
>>
>>   # Benchmark runner
>>   $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h
>> --
>> 2.30.2
>>
