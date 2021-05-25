Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135BF390942
	for <lists+bpf@lfdr.de>; Tue, 25 May 2021 20:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhEYSyK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 May 2021 14:54:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35480 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230388AbhEYSyK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 May 2021 14:54:10 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PIn5wS013595;
        Tue, 25 May 2021 11:52:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=T+HDaVcViXi47qTSfkaYvqSbNnT9yiOGOjaGR9grCJA=;
 b=jhTRyF23g+5vRZRXMF3bTTtgWZ+B+kFc21HJ//BlqX9S1HHPPfnsNeFiaGlW24mddaS5
 3Rj1Btg1VJDXnphRYfooLcf9jmFKAviLMlZUwWeDstC5MdsBB15z549s3VehWP8WXJ7A
 4nLsB/eyFL/VDB57z6tXUNbuVLEW9JPV+w8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38rp70ndgq-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 May 2021 11:52:22 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 11:52:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfOi93t8uyx28sv+TM0wwhSdO38pOP8P94QLE9dQlE0cmFBHitPH1TxB+N3xgr2nD5zVJ3FCIfWhaWCTIloiqORgCm6k6fNrSTvozlrH7iRNIPMfgvWOq56J5H6jdDJW93k4KUOWKbKRwnmrZAFl4d5uDdyukb80ffUptOtvG9Ls/y35RusLIYDOm5kiG0sGdMvMqBrGuZheR77gjvkXuiRdbV4FWO8JmFzDIsr3jNfKRJuWOqLrxzzPR+sgcP3h9erhpbpEng3yhgPNvRFsiOHlfykhxnffOzxgsbDxB4FqMsk+JBy5n9qRavO3yNolhszG5IJG6zmftl2+IrP2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUcc2J7BM1urJxlihIrpCfEuz/zKhkJyKs5EgKMKRUU=;
 b=e4hNv2WVzf84dNxoMV2hsS42I6/JfEaxX4J/VFlyhX9CwI/1Twx8v6yDlNr4s4D7+nQYi8T8jrFLnTTThRwyjfvg++ieYiCbGP0KRWH5H9jhKIqjHE1ETr0Oj+VWf9Mx8RdNnRgPg2a/En7XWz7CS5n3Sl9zyZxIO9ZHp0npEGXk3RW0zyU+sXNPWsihX02KXqGCqv7rTIM1MdIIyNXv0jUKR/Jr0I3CfGfK2t1omPITCLS+JjTCK1o4cQjUlKQHKCPm4fFmO0ez8qGbO+W8QYGnUWntxPlsXTQtrPfMfebzyOlTMsYWCvh/PBMk5hl055olNSLEytj5zcTHT5UTTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2414.namprd15.prod.outlook.com (2603:10b6:805:24::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 18:52:19 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 18:52:19 +0000
Subject: Re: [PATCH bpf-next v2] docs/bpf: add llvm_reloc.rst to explain llvm
 bpf relocations
To:     Fangrui Song <maskray@google.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
References: <20210525033314.3008878-1-yhs@fb.com>
 <20210525182948.4wk3kd7vrvgdr2lu@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <dd95b896-3b37-a398-68cd-549fb249f2e0@fb.com>
Date:   Tue, 25 May 2021 11:52:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <20210525182948.4wk3kd7vrvgdr2lu@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:6524]
X-ClientProxiedBy: MW2PR16CA0045.namprd16.prod.outlook.com
 (2603:10b6:907:1::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1278] (2620:10d:c090:400::5:6524) by MW2PR16CA0045.namprd16.prod.outlook.com (2603:10b6:907:1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Tue, 25 May 2021 18:52:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a264077-dbdd-4ba6-d885-08d91fae38e8
X-MS-TrafficTypeDiagnostic: SN6PR15MB2414:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB24143440BE8598173054FD1BD3259@SN6PR15MB2414.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NSkVjysQKSGVU3MF+MIaWR4jHOWqJIJQFjLoFq5O7N1lEWWBslm6HVPwMX6+JGEhWl9g2GPvVwmIB6g+aGqAM98zPsvPVkC3eKwOVzyQdqZEYmLQookfbdICich0742eC5tC+uOnzr9E+fYgUw45TLiRwlIBxKX6tmhb8sX/B4S0RPuROj/I+93kfcN6wF7upONlvgc3SAGyyJVfzPT/SIRURYrrxDp/CseqQc0Ib23IlebZZ4mNsLCtx4wp0MAvpZeBLUWLAXMJrwueISX0DmN+dcsCzYfBPxDRkgZiJt7DA/Mc27jwgY9Y+GltN59zD/3O5ZtqLzkyBkEEPvekzu4+4m8wic/rtrVNYOTMpkg2U0oddvG0WrQ1iD34k5sMd9yWrgugG6uhBQ73DdVF+sid5mqWDIR28+CZTs2zNsy7IQVwtVzdPTdJzvit2vgPmsG6pbeTHIpEXU7Pg0MB1JGeenlFAkh/LPCE6T0qFyYXf+hrdXQH5UljT/2TjT0Wf6bLOX0lpyYIqihkMP9c++UXHsshybfv9u632URr5N4RH+z4o8e4FbZlk9SqgtfrPJcey9CpCXtuc/8F1X+HLquDJO3/TXh79HW8S2qZu4nm+xsDKjZTqC0LCEIkwBef9IVK3pQsKMFCy0CeZfuV8WS2eWXblpYYcSbzvUDtOptzRDHi8wi/OTFRm1oM95WPiNLHxzKxJcV6R8+YfqgJ3lQ1VKKIGOYag4qZWAwH+l2aTwdInEq4tgKqXnBD+ncp3bqUO4BMt+xGk0C9OHjdvhRUVTKv+6YHWLXKkGauvwiTSVwmuYPDk9WusnuMBLPC000N9wfuYz6Lj/JtzLzrrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(2616005)(53546011)(2906002)(31696002)(31686004)(8936002)(6486002)(36756003)(5660300002)(38100700002)(6916009)(52116002)(66556008)(16526019)(66946007)(30864003)(186003)(8676002)(66476007)(86362001)(6666004)(478600001)(966005)(54906003)(316002)(4326008)(43740500002)(45980500001)(505234006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bllpclZhSTJuK05QUnI5ZWNnajdNR1JmU1pNU2JtTlViOUJnaVZPNUt4KzNH?=
 =?utf-8?B?Qlo4WmU3N2JKVUp6MHNQQzVjckNHai9jdmU5akRlUGJnREx6S0xCK3Y2UzZi?=
 =?utf-8?B?d2pCSmlpTFJWVDZQendRMHRUSGVUUmhzazR5TkRvUVV1VUkxMWJ3NzBxT3Vm?=
 =?utf-8?B?dXRuT3Ywdm5Cbk5zUUZRYTdrZm9Tc1RIZkE2clc3dUs2YkNyQWgvZ3dOYVZk?=
 =?utf-8?B?eEdNOEVXemNjY1FOOUZuaXFwSUZ2c29tTDk1cDBJTTV2SXVVa1FYeVdNc2tz?=
 =?utf-8?B?ZmJIYlBWNlBxckNza3ptZ1plMjNXalp1ZkM4eWJoQ09sUDMyNUpORkpES3pu?=
 =?utf-8?B?SmdsTTA4K0wyQVVPQ0Y5cEpPSE4wdzUwUEVKNS9QVkM4RWtYQXVITnBkVEo3?=
 =?utf-8?B?aXR2Y0syc0JmS3dJam1XZ2Zqd1owS1RxME1wWGlsM3VySG5weWxRT0FxbWtU?=
 =?utf-8?B?bStaTlZyUzBGR0kycWFhMDNVSUV3Zk9hZnp1RnhIQkM4ekIvSFBJMk5pamxP?=
 =?utf-8?B?UEVYWjJJMm5HQU5XYzRmOStvSG5NSFNRRW9SSW5OWExhQ2Q3Y0h0dS9iRGtH?=
 =?utf-8?B?cEtXRHcycnJBcjlxdWR5SGx2MU9hSTV1YjBrRWtFZ0RiQ2s5alBMQk8xY2JE?=
 =?utf-8?B?cnUwN1pDNFF2WjJGSGRkdnl5NXFjQi9jN0gwbDdEdEQyc2pTUU5HS3lYVHNM?=
 =?utf-8?B?cWJ5YWNva1RhV0tibUFHNi96KzlZWW91bzdwWjFjS1l1ZG1LK1BEa3dGTFFk?=
 =?utf-8?B?NDQ4Umh0eGQycWJRWFJaQkFKL2VKRXhTaVcvMDFPMXpVWERoMmthYmkyV3pO?=
 =?utf-8?B?ajFDaWRvSUFZRyt6ZEsvQlJFSVlCUHlqTnpZdEtwNmRENHo5TWowSUc5eHdi?=
 =?utf-8?B?a2hiL0F0WUtENmVibldBU3dhS1pZYzAvbWt3RUxaTEcxeHJPQittQk9RUExu?=
 =?utf-8?B?VGlzTDJ6YkluZFVrb2F0RXhVSDZtLzVKQ24rVFJGYUxZcVQ5K3BzUEtReHAw?=
 =?utf-8?B?a2VHQi9lOEk4UjRsdG1OTUYzd0JVRFhtb1dsZ01ybUtLVjByemszYlVZbStk?=
 =?utf-8?B?QTd0SHk3VlEvTUZCTWk0VUVPaUhXNjZneFg2R3NnZ2FFaUJYbUVwYXBBejVm?=
 =?utf-8?B?RlA5M01nVEg3dUpmUjNPNW5UbGJOWm5qUW5FVlRHVzA3SFJmMHd2TWxydjNk?=
 =?utf-8?B?MC9ES09tQUF3eWx3L3NpazdKb0RZUnNPd2dya0gxOGtMUW51QWR4dGE3aG9M?=
 =?utf-8?B?cFhTR29sZHVxYlFNYlpxNlplNXJDV1RzWmI3RUJsclZtNTNwL3lGZHhIeEFG?=
 =?utf-8?B?dmkycENRL3J2UldMSjUyMk5FQ0ViWE5yOWgxSkZVWE9KMVQzSjVMclhyL0RX?=
 =?utf-8?B?VUMxNmNRSHU1RG54NkoxMlNhM2NOaENhUDMrUUZnUXhlc085MDRGeGxSNTkw?=
 =?utf-8?B?SFMyeFFGVFhiTXJqcmcrc25mRUQ2cDFsdmNwQlhqWG1IQXNKYjZvbzRYTkRF?=
 =?utf-8?B?UCtkZlgyY0QyeHlBcTFqa1N1RWFROXczVVNoMnVwWW9IV3F0dVQvUjg4amZ5?=
 =?utf-8?B?aW9YYTVNZ2ZTckRIR2RWQkhaUytLOEszbmhmMnZvc1J4VVBLa09JS0RCcC91?=
 =?utf-8?B?dzdGSXBpNlEzbUl5Vm1QSXJVcjRXZzRTZjRjelA5L1dZQ0ZJMFFSaHlTaENC?=
 =?utf-8?B?UkkvT25VeDM1c2xmT1NWQzV3Zi9qNmk0TE1GaVRxYzdvcVBlUEJuNVExNEww?=
 =?utf-8?B?dEtOOVdQYnJxcGltZnBqcDVDb0RUL0djenhiS0dpZE1LaGlhdXRMbWowMzV4?=
 =?utf-8?B?dTJyVjdqaGxFUHVsSkFHUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a264077-dbdd-4ba6-d885-08d91fae38e8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 18:52:19.1229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfUsiakJL/XGYrHEqx1ITutw+ykjXiwz0M7AFuuP4ksa4V6MdeIFUk1LFco5wenY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2414
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: iEa0pBl_aVgLocBRNzJ8xudcvFKJr_99
X-Proofpoint-GUID: iEa0pBl_aVgLocBRNzJ8xudcvFKJr_99
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_08:2021-05-25,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250115
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/25/21 11:29 AM, Fangrui Song wrote:
> I have a review queue with a huge pile of LLVM patches and have only
> skimmed through this.
> 
> First, if the size benefit of REL over RELA isn't deem that necessary,
> I will highly recommend RELA for simplicity and robustness.
> REL is error-prone.

The worry is backward compatibility. Because of BPF ELF format
is so intervened with bpf eco system (loading, bpf map, etc.),
a lot of tools in the wild already implemented to parse REL...
It will be difficult to change...

> 
> On 2021-05-24, Yonghong Song wrote:
>> LLVM upstream commit 
>> https://reviews.llvm.org/D102712 
>> made some changes to bpf relocations to make them
>> llvm linker lld friendly. The scope of
>> existing relocations R_BPF_64_{64,32} is narrowed
>> and new relocations R_BPF_64_{ABS32,ABS64,NODYLD32}
>> are introduced.
>>
>> Let us add some documentation about llvm bpf
>> relocations so people can understand how to resolve
>> them properly in their respective tools.
>>
>> Cc: John Fastabend <john.fastabend@gmail.com>
>> Cc: Lorenz Bauer <lmb@cloudflare.com>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>> Documentation/bpf/index.rst            |   1 +
>> Documentation/bpf/llvm_reloc.rst       | 240 +++++++++++++++++++++++++
>> tools/testing/selftests/bpf/README.rst |  19 ++
>> 3 files changed, 260 insertions(+)
>> create mode 100644 Documentation/bpf/llvm_reloc.rst
>>
>> Changelogs:
>>  v1 -> v2:
>>    - add an example to illustrate how relocations related to base
>>      section and symbol table and what is "Implicit Addend"
>>    - clarify why we use 32bit read/write for R_BPF_64_64 (ld_imm64)
>>      relocations.
>>
>> diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
>> index a702f67dd45f..93e8cf12a6d4 100644
>> --- a/Documentation/bpf/index.rst
>> +++ b/Documentation/bpf/index.rst
>> @@ -84,6 +84,7 @@ Other
>>    :maxdepth: 1
>>
>>    ringbuf
>> +   llvm_reloc
>>
>> .. Links:
>> .. _networking-filter: ../networking/filter.rst
>> diff --git a/Documentation/bpf/llvm_reloc.rst 
>> b/Documentation/bpf/llvm_reloc.rst
>> new file mode 100644
>> index 000000000000..5ade0244958f
>> --- /dev/null
>> +++ b/Documentation/bpf/llvm_reloc.rst
>> @@ -0,0 +1,240 @@
>> +.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>> +
>> +====================
>> +BPF LLVM Relocations
>> +====================
>> +
>> +This document describes LLVM BPF backend relocation types.
>> +
>> +Relocation Record
>> +=================
>> +
>> +LLVM BPF backend records each relocation with the following 16-byte
>> +ELF structure::
>> +
>> +  typedef struct
>> +  {
>> +    Elf64_Addr    r_offset;  // Offset from the beginning of section.
>> +    Elf64_Xword   r_info;    // Relocation type and symbol index.
>> +  } Elf64_Rel;
>> +
>> +For example, for the following code::
>> +
>> +  int g1 __attribute__((section("sec")));
>> +  int g2 __attribute__((section("sec")));
>> +  static volatile int l1 __attribute__((section("sec")));
>> +  static volatile int l2 __attribute__((section("sec")));
>> +  int test() {
>> +    return g1 + g2 + l1 + l2;
>> +  }
>> +
>> +Compiled with ``clang -target bpf -O2 -c test.c``, the following is
>> +the code with ``llvm-objdump -dr test.o``::
>> +
>> +       0:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 
>> 0 ll
>> +                0000000000000000:  R_BPF_64_64  g1
>> +       2:       61 11 00 00 00 00 00 00 r1 = *(u32 *)(r1 + 0)
>> +       3:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 = 
>> 0 ll
>> +                0000000000000018:  R_BPF_64_64  g2
>> +       5:       61 20 00 00 00 00 00 00 r0 = *(u32 *)(r2 + 0)
>> +       6:       0f 10 00 00 00 00 00 00 r0 += r1
>> +       7:       18 01 00 00 08 00 00 00 00 00 00 00 00 00 00 00 r1 = 
>> 8 ll
>> +                0000000000000038:  R_BPF_64_64  sec
>> +       9:       61 11 00 00 00 00 00 00 r1 = *(u32 *)(r1 + 0)
>> +      10:       0f 10 00 00 00 00 00 00 r0 += r1
>> +      11:       18 01 00 00 0c 00 00 00 00 00 00 00 00 00 00 00 r1 = 
>> 12 ll
>> +                0000000000000058:  R_BPF_64_64  sec
>> +      13:       61 11 00 00 00 00 00 00 r1 = *(u32 *)(r1 + 0)
>> +      14:       0f 10 00 00 00 00 00 00 r0 += r1
>> +      15:       95 00 00 00 00 00 00 00 exit
>> +
>> +There are four relations in the above for four ``LD_imm64`` 
>> instructions.
>> +The following ``llvm-readelf -r test.o`` shows the binary values of 
>> the four
>> +relocations::
>> +
>> +  Relocation section '.rel.text' at offset 0x190 contains 4 entries:
>> +      Offset             Info             Type               Symbol's 
>> Value  Symbol's Name
>> +  0000000000000000  0000000600000001 R_BPF_64_64            
>> 0000000000000000 g1
>> +  0000000000000018  0000000700000001 R_BPF_64_64            
>> 0000000000000004 g2
>> +  0000000000000038  0000000400000001 R_BPF_64_64            
>> 0000000000000000 sec
>> +  0000000000000058  0000000400000001 R_BPF_64_64            
>> 0000000000000000 sec
>> +
>> +Each relocation is represented by ``Offset`` (8 bytes) and ``Info`` 
>> (8 bytes).
>> +For example, the first relocation corresponds to the first instruction
>> +(Offset 0x0) and the corresponding ``Info`` indicates the relocation 
>> type
>> +of ``R_BPF_64_64`` (type 1) and the entry in the symbol table (entry 6).
>> +The following is the symbol table with ``llvm-readelf -s test.o``::
>> +
>> +  Symbol table '.symtab' contains 8 entries:
>> +     Num:    Value          Size Type    Bind   Vis       Ndx Name
>> +       0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT   UND
>> +       1: 0000000000000000     0 FILE    LOCAL  DEFAULT   ABS test.c
>> +       2: 0000000000000008     4 OBJECT  LOCAL  DEFAULT     4 l1
>> +       3: 000000000000000c     4 OBJECT  LOCAL  DEFAULT     4 l2
>> +       4: 0000000000000000     0 SECTION LOCAL  DEFAULT     4 sec
>> +       5: 0000000000000000   128 FUNC    GLOBAL DEFAULT     2 test
>> +       6: 0000000000000000     4 OBJECT  GLOBAL DEFAULT     4 g1
>> +       7: 0000000000000004     4 OBJECT  GLOBAL DEFAULT     4 g2
>> +
>> +The 6th entry is global variable ``g1`` with value 0.
>> +
>> +Similarly, the second relocation is at ``.text`` offset ``0x18``, 
>> instruction 3,
>> +for global variable ``g2`` which has a symbol value 4, the offset
>> +from the start of ``.data`` section.
>> +
>> +The third and fourth relocations refers to static variables ``l1``
>> +and ``l2``. From ``.rel.text`` section above, it is not clear
>> +which symbols they really refers to as they both refers to
>> +symbol table entry 4, symbol ``sec``, which has ``SECTION`` type
> 
> STT_SECTION. `SECTION` is just an abbreviated form used by some binary
> tools.

This is just to match llvm-readelf output. I can add a reference
to STT_SECTION for the right macro name.

> 
>> +and represents a section. So for static variable or function,
>> +the section offset is written to the original insn
>> +buffer, which is called ``IA`` (implicit addend). Looking at
>> +above insn ``7`` and ``11``, they have section offset ``8`` and ``12``.
>> +From symbol table, we can find that they correspond to entries ``2``
>> +and ``3`` for ``l1`` and ``l2``.
> 
> The other REL based psABIs all use `A` for addend.

I can use `A` as well. The reason I am using `IA` since it is not
shown in the relocation record and lld used API 'getImplicitAddend()`
get this value. But I can certainly use `A`.

> 
>> +In general, the ``IA`` is 0 for global variables and functions,
>> +and is the section offset or some computation result based on
>> +section offset for static variables/functions. The non-section-offset
>> +case refers to function calls. See below for more details.
>> +
>> +Different Relocation Types
>> +==========================
>> +
>> +Six relocation types are supported. The following is an overview and
>> +``S`` represents the value of the symbol in the symbol table::
>> +
>> +  Enum  ELF Reloc Type     Description      BitSize  Offset        
>> Calculation
>> +  0     R_BPF_NONE         None
>> +  1     R_BPF_64_64        ld_imm64 insn    32       r_offset + 4  S 
>> + IA
>> +  2     R_BPF_64_ABS64     normal data      64       r_offset      S 
>> + IA
>> +  3     R_BPF_64_ABS32     normal data      32       r_offset      S 
>> + IA
>> +  4     R_BPF_64_NODYLD32  .BTF[.ext] data  32       r_offset      S 
>> + IA
>> +  10    R_BPF_64_32        call insn        32       r_offset + 4  (S 
>> + IA) / 8 - 1
> 
> Shifting the offset by 4 looks weird. R_386_32 applies at r_offset.
> The call instruction  R_BPF_64_32 is strange. Such special calculation
> should not be named R_BPF_64_32.

Again, we have a backward compatibility issue here. I would like to
provide an alias for it in llvm relocation header file, but I don't
know how to do it.

> 
>> +For example, ``R_BPF_64_64`` relocation type is used for ``ld_imm64`` 
>> instruction.
>> +The actual to-be-relocated data (0 or section offset)
>> +is stored at ``r_offset + 4`` and the read/write
>> +data bitsize is 32 (4 bytes). The relocation can be resolved with
>> +the symbol value plus implicit addend. Note that the ``BitSize`` is 
>> 32 which
>> +means the section offset must be less than or equal to ``UINT32_MAX`` 
>> and this
>> +is enforced by LLVM BPF backend.
>> +
>> +In another case, ``R_BPF_64_ABS64`` relocation type is used for 
>> normal 64-bit data.
>> +The actual to-be-relocated data is stored at ``r_offset`` and the 
>> read/write data
>> +bitsize is 64 (8 bytes). The relocation can be resolved with
>> +the symbol value plus implicit addend.
>> +
>> +Both ``R_BPF_64_ABS32`` and ``R_BPF_64_NODYLD32`` types are for 
>> 32-bit data.
>> +But ``R_BPF_64_NODYLD32`` specifically refers to relocations in 
>> ``.BTF`` and
>> +``.BTF.ext`` sections. For cases like bcc where llvm 
>> ``ExecutionEngine RuntimeDyld``
>> +is involved, ``R_BPF_64_NODYLD32`` types of relocations should not be 
>> resolved
>> +to actual function/variable address. Otherwise, ``.BTF`` and 
>> ``.BTF.ext``
>> +become unusable by bcc and kernel.
> 
> Why cannot R_BPF_64_ABS32 cover the use cases of R_BPF_64_NODYLD32?
> I haven't seen any relocation type which hard coding knowledge on data
> sections.

This is due to how .BTF relocation is done. Relocation is against 
loadable symbols but it does not want dynamic linker to resolve them.
Instead it wants libbpf and kernel to resolve them in a different
way.

> 
>> +Type ``R_BPF_64_32`` is used for call instruction. The call target 
>> section
>> +offset is stored at ``r_offset + 4`` (32bit) and calculated as
>> +``(S + IA) / 8 - 1``.
> 
> In other ABIs, names like 32/ABS32/ABS64 refer to absolute relocation types
> without such complex operation.

Again, this is a historical artifact to handle call instruction. I am 
aware that this might be different from other architectures. But we have
to keep backward compatibility...

> 
>> +Examples
>> +========
>> +
>> +Types ``R_BPF_64_64`` and ``R_BPF_64_32`` are used to resolve 
>> ``ld_imm64``
>> +and ``call`` instructions. For example::
>> +
>> +  __attribute__((noinline)) __attribute__((section("sec1")))
>> +  int gfunc(int a, int b) {
>> +    return a * b;
>> +  }
>> +  static __attribute__((noinline)) __attribute__((section("sec1")))
>> +  int lfunc(int a, int b) {
>> +    return a + b;
>> +  }
>> +  int global __attribute__((section("sec2")));
>> +  int test(int a, int b) {
>> +    return gfunc(a, b) +  lfunc(a, b) + global;
>> +  }
>> +
[...]
