Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E813635B63D
	for <lists+bpf@lfdr.de>; Sun, 11 Apr 2021 18:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbhDKQxW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Apr 2021 12:53:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63578 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233514AbhDKQxV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 11 Apr 2021 12:53:21 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13BGoPXD019744;
        Sun, 11 Apr 2021 09:53:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=rPDM+kyQob86sZZah0M+Eb/sOr7zfcg8qGGiwjVDJmc=;
 b=No9AYL5RS4vFj1/1xsNB9KKKdSRYkig5wBZ/PNcTYkff0Xg+lxX/OYxdziYzNlyMJ7DH
 qIKVqiyanPAN8q2DQlPo04p0bZ2V3tDDZbyNHdgC+Y0Mbsl8e/gLt7kYRU3rJ8EwmC1D
 nmOJzNR+DsNq6/ukD4iR9C4ZkcuGZHsr4m8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 37uh0935f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 11 Apr 2021 09:53:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 11 Apr 2021 09:53:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZgDC/KtzROIGB7KVviJ8GA63hrGL2dJbPOJfrY8y4XwzRWY6I8MBfqyTFJs4Aj6udF7+CeBVd3g07xdn+EjR04cFo8NSqy5QEJ2d6iVhflS9CZSMMrvN11WGZVqVfAII4l88RsbpqE3mqm2VKUalscX1HIq+C3jlJc10Gtw2NVDUADWEYl1tRO3s6yEUMDEId/u6wXWvvfBYm2BdGzWzWldF9PZk6dOGiKM1RvsYANnEq3ujgEcvwoLg21+YkCBMvyVg6g/XvnLVpc7kClSPm8abSVTu/VGofTHpDFpROiZz5NdpNEo+hK8nwVN0a4i5I3P8Mii6oihv2fVu7CuUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPDM+kyQob86sZZah0M+Eb/sOr7zfcg8qGGiwjVDJmc=;
 b=M5MDXNkrR/XXGKw4ALPDe+bqDtLzsbWpsfMqqiA9oI/5y2RNgu/rOah5wirKjWeHqm9fWyFl6P7G0F+m/AG9h48kheAaDaWjsWhHkPfI8ptKWPq497kYy4vOQE1aFIZewL6IGRxvQqfoyNekKf/okZabPyneP0eaO5SrdaYxDvhi+vJaWInsOiGsLvUQlckQBqxSkcxa4++tW/4abSy1IvAtq68rNxuaTlZpn8o/u6zg5c2ZtDoNGNHqCSQBWVfMVIeHhvkmy6R1suSgL1MTZG1Rs+f/TgKPx3meomNBB/vrEfSfPHSICfPxUP0tO6E2tfWRmcDGMwcVEMhoNqn+Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2334.namprd15.prod.outlook.com (2603:10b6:805:23::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Sun, 11 Apr
 2021 16:53:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.033; Sun, 11 Apr 2021
 16:52:59 +0000
Subject: Re: [PATCH bpf-next 2/5] tools: allow proper CC/CXX/... override with
 LLVM=1 in Makefile.include
To:     <sedat.dilek@gmail.com>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>
References: <20210410164925.768741-1-yhs@fb.com>
 <20210410164935.769789-1-yhs@fb.com>
 <CA+icZUVztyjfRrN1HweGPz6ASjVAEs7cSf72-Fbjm2H4FQBZ0Q@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <922c4f8f-915e-69c6-c552-dc829668a526@fb.com>
Date:   Sun, 11 Apr 2021 09:52:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <CA+icZUVztyjfRrN1HweGPz6ASjVAEs7cSf72-Fbjm2H4FQBZ0Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:ec9]
X-ClientProxiedBy: MW4PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:303:b9::13) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::110f] (2620:10d:c090:400::5:ec9) by MW4PR03CA0218.namprd03.prod.outlook.com (2603:10b6:303:b9::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Sun, 11 Apr 2021 16:52:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c499f0c1-353b-4741-adc2-08d8fd0a438e
X-MS-TrafficTypeDiagnostic: SN6PR15MB2334:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB233462B48CD67E98D1A7FDE8D3719@SN6PR15MB2334.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SiqtKVo0qbF+4Gtw0Mo1Dr4ClzRmJWwQ4K1pfLMrVvTCv5Utoi7HbFLRVjv7pf8c2FeUw9zGqyv5I07LRBuqlqAu7B3Q8Rqvh+g8VZF5sTlJ6wxE58eE3Y3vu31WrGBZX9QMFpQ5PyqMJpJPwLcKChqrNOpxn8QKyFND0ue/IvJRYWeYdPpM3IaJCNBI2+yhPLdqc5hF+gijws70i8yoWYB5oc55FP0YU+q91yncZUVTvUvrnkeJ3AyITYeEQ3LGZO1hDmqFZmXWmhT/+cZcUv2XR7ViW87L0xo/1UxRnKQy3BwQvUOUFPhTyFL1xZ2Tvwqd1bdlc3Gx0oY7kO/Ho0lnFq8qrp/elnoPG0e8d/4BBALNO71tH1vND3/hqIZTp5FBJSCB8GYjbhGgm9wcIUnAhFnGI4Ha4hCh7YvT6Zni6HWNKLrgVIOLsNK306wCKFfqJLuQfzOyuXBFxRbznjnkh2HRWt+U8zBYqca+nyu5wxDyii6IfOA+xLPaUUVxciag4YKtFAFhYj7tiVOyd0Z0GP+2qNwOLVAXZfUgtyLzE6k+3hnb+1okHt+KZeF3ALltCz4LD0oLB1TolAd0sxDq55B8eb+jvPPT8LwUWnvRByiNrdW/K/7qDbBlG129xe4tKPyPHAFEXaK7qKdYuCLyLD+s35UVa8K38//Linlidb1MFhl0AcS1qNbchc1e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(396003)(366004)(136003)(86362001)(478600001)(2906002)(8936002)(66946007)(31696002)(2616005)(6666004)(6486002)(36756003)(66476007)(4326008)(66556008)(316002)(8676002)(16526019)(186003)(53546011)(52116002)(83380400001)(5660300002)(54906003)(31686004)(38100700002)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dGtYaFpmeTVFWkIwNUdORVovTnYwQzFRZkc2eXRnTzRjSnVLRk5YcWhHOVRm?=
 =?utf-8?B?dy83aFRnSldYVTArbHpNMVdXOWhtNkJZN3hQd1lTYTkzb2dVWnNQZW1DcnlN?=
 =?utf-8?B?Nlg3M3JKN3MwaVFrNXQ4QURvZWc2SUYreGFiNTlxQU9KNURFL3NGbmFtVFAr?=
 =?utf-8?B?REl5aHg3QmhwT2EwVmRSOFZ2MnFLMU5MNzZJSmJ1Y25nb0phaWthSWRLUzhv?=
 =?utf-8?B?SnJKNkhIWVZLZmN2MXRrMmttWjlPV3ZIOGZhUWdYMzR1czBEUXR2eFkwOTBW?=
 =?utf-8?B?ODFDbWFPdU9GdXBGTkpMZTBIcWthZXEvU2Y5TXVORytENVRDVVRhVFY3Qm9O?=
 =?utf-8?B?T05xVjRiYjlUZ1NlU1RPYlZkK1FhdkcydVl2V0I2ZTRJK0RLUEpTNWhFK2Nv?=
 =?utf-8?B?STZxUUVETGNuN3Y3VnIyeFNBbkwvdjIyc0ZtL2lJd3lCZGdLSXJCQ1NTckNh?=
 =?utf-8?B?SDA3ZktJOEZLbUx3VDVxN1JMRm1qTGdmTmtiY1JMS3hZaHF3UEJLeVB4eXF6?=
 =?utf-8?B?TzJqWUJGNlVDYlg4UEtkckhVRW1GbWJud3N5ajZ4Ym5STVRvVWJDOWU1N0RR?=
 =?utf-8?B?Q3NVdW1UOENOM0ZSZVhMelYxQlQrMGJ0d1Z5K1pMelBFOTZsQXZxQXozY2xm?=
 =?utf-8?B?OXgwcG8wenVtRWcwS2dQenpvMEovTFZMaHRNL3Zpd0hMY25wSFZFY3dFd1gw?=
 =?utf-8?B?ajhvbE55bWVqMU1xRHMxWVg3TFhnNUhVUTcxK09JK2FpVkl2ZnFCazJDRVBv?=
 =?utf-8?B?ak16bzAvbU52SDMrR0FNWmRaandYdWl2cVBlRWdESHVZR3VidHEzaTFQaVRp?=
 =?utf-8?B?WnNwcTQvN1hteHBWRCs5VEI0aVdobW9FSG9wNzJxVGxtQmc2M3owZ1c1aHpl?=
 =?utf-8?B?WVJaSlhCODFUbFNGcW9RN0FSVW0zRTNwQ09kNHdNNXhtY0pwUXRJcUEzTEcz?=
 =?utf-8?B?QTVDRlN5aEt0bk1jamM1RkNralFLUUxROVA0ejg0dUk2T1VBSkVFWlNIT3NW?=
 =?utf-8?B?eUxTempldlU2eE84aFlvcEFEVGJ0MkZ0aHRNclhnZFBHTE5mc2UwQlZ5eWJ3?=
 =?utf-8?B?WkdXZE5wbXgyM0RlUEdiYVkzUjhYY2hKeFM1bUpsV3ZJNkg0Q2ZubXhDQXZ2?=
 =?utf-8?B?RXBGb2xYcHQwcVFKbGxjUVNYcGxKSVpXV1VLREJXbkRRTzd1ZHlkeXVmM0V4?=
 =?utf-8?B?RnRRZXBpVm56WGN6aXd0R1ZFWVRkWTVEOHlic3VSRHhIbUdOUitScGt2OUpr?=
 =?utf-8?B?Vk1jbUVCTGE1c3JCcEFDSm5QdFNZODd6WDVNbVlqa2dtZVJtRmVuNmFQSElG?=
 =?utf-8?B?NFZtbHE5bTNBOTdsR3ZlQ1NnQWRsMUg0UXVZbElDRmQvZDVkemRDYUoyblZw?=
 =?utf-8?B?cmdsTmlMTFpoblgyN0xmWFhtV0R2MkRKNjk3YjB6Wk83Vlgyay83UVFlVzYz?=
 =?utf-8?B?TUFGbnc1WkNXY2FsTWx0aTBEQUZLcG1obnE5WlpyZiszMmFtVzJFV1UxVnhR?=
 =?utf-8?B?MTBUSVRsV3JvcjlwV1hRQmNCaG5FNUEzMkx4aG92ZEQvRThQV1VxN09FR1lQ?=
 =?utf-8?B?Uzl2MjZZdjlEQ0cvRFBTMVNjUS9IZFNHZ1BCbTRoZTZqY3ArZVlFTGZLVlFX?=
 =?utf-8?B?WEh5dmxxL1d1a2NYNFUzREhqdC9vOWhWdFByMW16eGd1TUdwNnVEWFVmeVc0?=
 =?utf-8?B?eGhINEloR1hjOGIwdDN1RzJSTHpKVXZyL1ZxUWx0ckdaZnB6S1hzYkdJOEF5?=
 =?utf-8?B?eUNCM2NUelZnWWNBczY0OGQyNmVIQUdxN2RoNjhOZFJBeXB6QndWNGsvUXRL?=
 =?utf-8?Q?jofeSTejdwOHXh/wtsolWT9k5EpmS8Wdk4wo0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c499f0c1-353b-4741-adc2-08d8fd0a438e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2021 16:52:59.8589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0YBOBE9KAfvcsVRjLr3FUEK2VL4DXN+6A7ZKq6fzg3UA2MY7pB9R+J60cJxn1A/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2334
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: MI18kaBjf_SYe2KL1fMhExyl7zpi9kW3
X-Proofpoint-ORIG-GUID: MI18kaBjf_SYe2KL1fMhExyl7zpi9kW3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-11_09:2021-04-09,2021-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104110132
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/11/21 3:24 AM, Sedat Dilek wrote:
> On Sat, Apr 10, 2021 at 6:49 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> selftests/bpf/Makefile includes tools/scripts/Makefile.include.
>> With the following command
>>    make -j60 LLVM=1 LLVM_IAS=1  <=== compile kernel
>>    make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1 V=1
>> some files are still compiled with gcc. This patch
>> fixed the case if CC/AR/LD/CXX/STRIP is allowed to be
>> overridden, it will be written to clang/llvm-ar/..., instead of
>> gcc binaries. The definition of CC_NO_CLANG is also relocated
>> to the place after the above CC is defined.
>>
>> Cc: Sedat Dilek <sedat.dilek@gmail.com>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/scripts/Makefile.include | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
>> index a402f32a145c..91130648d8e6 100644
>> --- a/tools/scripts/Makefile.include
>> +++ b/tools/scripts/Makefile.include
>> @@ -39,8 +39,6 @@ EXTRA_WARNINGS += -Wundef
>>   EXTRA_WARNINGS += -Wwrite-strings
>>   EXTRA_WARNINGS += -Wformat
>>
>> -CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)
>> -
>>   # Makefiles suck: This macro sets a default value of $(2) for the
>>   # variable named by $(1), unless the variable has been set by
>>   # environment or command line. This is necessary for CC and AR
>> @@ -52,12 +50,22 @@ define allow-override
>>       $(eval $(1) = $(2)))
>>   endef
>>
>> +ifneq ($(LLVM),)
>> +$(call allow-override,CC,clang)
>> +$(call allow-override,AR,llvm-ar)
>> +$(call allow-override,LD,ld.lld)
>> +$(call allow-override,CXX,clang++)
>> +$(call allow-override,STRIP,llvm-strip)
> 
> Use here $(CROSS_COMPILE) prefix like below for people using an LLVM
> cross-toolchain?

The same reason as my comment in previous patch.
There is no need to have $(CROSS_COMPILE) prefix for clang compiler.

> 
> - Sedat -
> 
>> +else
>>   # Allow setting various cross-compile vars or setting CROSS_COMPILE as a prefix.
>>   $(call allow-override,CC,$(CROSS_COMPILE)gcc)
>>   $(call allow-override,AR,$(CROSS_COMPILE)ar)
>>   $(call allow-override,LD,$(CROSS_COMPILE)ld)
>>   $(call allow-override,CXX,$(CROSS_COMPILE)g++)
>>   $(call allow-override,STRIP,$(CROSS_COMPILE)strip)
>> +endif
>> +
>> +CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)
>>
>>   ifneq ($(LLVM),)
>>   HOSTAR  ?= llvm-ar
>> --
>> 2.30.2
>>
