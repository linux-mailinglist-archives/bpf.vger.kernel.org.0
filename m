Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E887138F2B4
	for <lists+bpf@lfdr.de>; Mon, 24 May 2021 20:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbhEXSDi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 14:03:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59976 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233673AbhEXSDi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 May 2021 14:03:38 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14OHx0ls019146;
        Mon, 24 May 2021 11:01:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=csOtbXkQ/1YJlymERnPyJ1Ycx2/N0aymc6QukUBYfdo=;
 b=aNAUbCCm17e4NhpcYCjW2QxG88VcWF34YwibtAOrQOPec7MrSbZ4HU1nnPRw9UOZ7F/N
 qV2iBWVVnZg7NUGGXU8bfPogv3fskdZhZtueVDdQp99QfW2QqA21m/dxC/4fkJPeBsIL
 sxar1L7LCmVMGsRpVVM/wz+15mD1Dq9BLBA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38qj49q4uu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 24 May 2021 11:01:55 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 11:01:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHcaWGdOVvMKKdE2rSSmiHfBia1HEvQFeVzgcIQyhZ2sg38RaRMORz4x3k/kCfDpgNUcA5ZKLBeRfIwjzCMZcZMR5OMn7i+39vm38Q8md51eBlhtHWumVQ+C716ZVYbwnGr0u9FbZcUTbZUPs/uJNJZBgW6T8JIKFavSBR91s3mFNL4uX13lxYYj2XsULk+dTY7UGvZcXugUru5xTJfTt3zXXBVbshXfOZL6krT1PiZVqjpQ69i4GspdcCHxhwOo6+13enahYF9NLeU7vT4bmbITXymSyurtxH7vJpT+weBd2R41FJIth8HPHJXjY72SvVI0CjG4Pbl/eNZxQSlZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3PBzclTVSCQz/P9f1fsapuf9LV1tkGUJ46wOksChyE=;
 b=YATJIY7p28vakXQ2dscozt+yQdUCGwDGxDLkppf4B+t1xcVAS9o6aleP6GulwTGISc/YPWNOd8bLJxu/Kq/6NWkYaTjf6eWvN8aMdOM99kWjv39yf6YolZzhV0IyL5FNzl0syi2WtINMAjnFMpe7THGI4dJC5EMdMQU0bMYZrF0aM9zpC46iOA9RgHbJ9OQRI9AVTVZ9sJXIfr409qhM/uTBZC0SOBXnHVm8R0tZRhihC0MhkgPytAniw6nt3lIXeoqWft3fKMv/jzLBKdppsCY/FcnyN0ndJEkSuDvma+D4q5SCeBV3KINCqyTdwGJupAMXhamM7rsCG74kRccngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB5031.namprd15.prod.outlook.com (2603:10b6:806:1da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Mon, 24 May
 2021 18:01:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 18:01:52 +0000
Subject: Re: [PATCH bpf-next] docs/bpf: add llvm_reloc.rst to explain llvm bpf
 relocations
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
References: <20210522163925.3757287-1-yhs@fb.com>
 <CAEf4Bzb+gqH6aB72y+vCaHrq7HNNAROPV+2X0976CzCAmY8Jrw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <22162d9d-7e89-53b2-015f-5e88a953c4dd@fb.com>
Date:   Mon, 24 May 2021 11:01:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <CAEf4Bzb+gqH6aB72y+vCaHrq7HNNAROPV+2X0976CzCAmY8Jrw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:ac27]
X-ClientProxiedBy: MWHPR22CA0047.namprd22.prod.outlook.com
 (2603:10b6:300:69::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1160] (2620:10d:c090:400::5:ac27) by MWHPR22CA0047.namprd22.prod.outlook.com (2603:10b6:300:69::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Mon, 24 May 2021 18:01:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb5b01ff-3f40-401d-2a4f-08d91ede0236
X-MS-TrafficTypeDiagnostic: SA1PR15MB5031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB5031C0142DFDBE799B6A8098D3269@SA1PR15MB5031.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: neTZNMYABPmnrGP/KvdEccBd7vtt83KCkexJoIWLb4vncF+O7krLMFCaCXlYXwu75OzHA3KaY5Hv2WLQe3i79UXxeV5k+jUyxhZbSod7et3qnNbep4Zb2qPRB/SerYv393G9qFSUOmnD2WOh9jxueO3Xvs5j5zZjlEkxGf5swGyins+BOxJldRMeyyJET2ceSPfmFb39AYapjNNc9FtLQHIXRkfFrZN0eJM8rc8k7eKjUjCm6cg64FF1p1h70CEU+r0eQFIGnzEfTh7wgR2FrsDbQagkxtzpnr6XYgewh3ZTO4ZZTrpSLlEWEhpXnR8iFHIZtKcc3+HyUKCoTuyq6sOnXrvxAtwsZlsyUjLhPpUYpLFaWRjfw9QroO5u8WOMCQPeaG2wAhDD4rMUv5QO/1i9JH7OCqleG71I3sLBU8HzouSXFMU7wyn2pmfuJc5H/KsuU/TWyC5JZuqf1ImkjwazmxrKx88RC2jgPj4SAEDKVpl8hbfNr693q/sFXl3LeIEJBnU4XWOOcgsjCyvQ/K+gFij99qI9uwapy46OQ7EefVjbzz63otArIBkk+QO384epl6UByGQSmfaesFwbSRYUgKpASjmov/G4amuld4hpVbQkZgqjyqek4GV3iTHyXtwppIoI17e/SFxSIgN2BtsZY9lci9P+DSsL2Oucm5A503gM9LizzT/hVLZ1k3Tr5hEx6Eht5N4ss1XxPn5scUhscqtU9Ljs8yEe5wqmE/vevppJJVOD3RiejahHZmkDPf3a4p7fCUtc6FcNjsQQkCyQl3/wKJbfNrdWzqmSMFMHvAydCDC/kQjsQPAUV0cfTEmInKJu6fUhNo+Md35r7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(478600001)(83380400001)(2906002)(86362001)(66476007)(186003)(31686004)(38100700002)(2616005)(66556008)(16526019)(19627235002)(66946007)(6486002)(54906003)(52116002)(36756003)(316002)(6916009)(31696002)(8936002)(8676002)(53546011)(5660300002)(4326008)(30864003)(966005)(43740500002)(45980500001)(505234006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eU54RjZ4Nkt0bXZoWlE5YlBwSnM4aGdWSEhMcURwV3R5aHdrMjMvREVKenEy?=
 =?utf-8?B?d1prcFJ6MDZBQ3JLc0FuZUFXT0p4cUlVaDlaZGdBUWZTUVc2WUc4a3dxNXZv?=
 =?utf-8?B?bCtoaUVtL0swMklFbkIzWDFhWTNUSE5IY2hvVkNNNXZiMnFHcFhsMHFqS3Bu?=
 =?utf-8?B?akI3cEVvaXg0NDJVM1lWYjBJS1M0UGdzWDJ4VHVJMVpXQWNtTk43S25LRk4z?=
 =?utf-8?B?UE9VbUVYNGVPcTZUemZSWDFLendrakZDZkFYTFBnS2pCOTZZRTBGdnpRV090?=
 =?utf-8?B?bVFyWmorbTZLb21kZWVRSit5Q1VHblk4L1VFaVJHQlhYOHkzRFlvaW8xRGlv?=
 =?utf-8?B?b29rMDJJaWR1TUdiNTZpR2VYWWI4cUZxTi9DZXNnaVB0WUpiRWlVZHh5WFBL?=
 =?utf-8?B?NFBPd3hiVVRDbUtEN0p5eVZEMDI3N285amFVbURNcFRxZy9MMStlaDJPbmNJ?=
 =?utf-8?B?TnBDWDlnL2gxQzQvTVduVE45ZzRNeXY4VzdkTWgvaG1qSFN3NU11eXNKeStp?=
 =?utf-8?B?cW1lRmkxcndKQktkcWIzeTlGdDI5bmY0RmQ1a0JaUnF2MnV4NFF3RW11Y29I?=
 =?utf-8?B?YXMyZmp0Zyt3ZndpeGZoYk0wc0kvTktVT1ZPQU1XeTJBTVBJNnFxZ0l5NHcz?=
 =?utf-8?B?YkNCT25kY0R5WVhqR2FJc3RCV0NiSUhmVTZpU3JYM3kyWm16MTlCWWxHMU5Y?=
 =?utf-8?B?RU5GMm9pTkJUVGZBSDJEQ2VRSHZ3cFlCa3lXZ2xodDNKWEc3UEhueElxakFz?=
 =?utf-8?B?Y1cvTlFjVHhEaDFhZGtnZ3B3V2tnbkFHbkxSUzRVNStyTUo2VkFxMTlDZXVo?=
 =?utf-8?B?MzVPRmx1Z2haeWNwVXhRbHo1KzBjU2c3M2JHa1VXbkR6L0pFRU5zeTZZdEtZ?=
 =?utf-8?B?NlFYeFhxSU9od1VKcDJ1RGd1Z1IrbmIyQUJjS1ZTNndlaVNmQ0RSOFlId0Zi?=
 =?utf-8?B?T0szK00ySVNTSUxrZys3c3lQWHUrUlFEaUNHWjlQWVRYSzhGNlhjaU9mOEJL?=
 =?utf-8?B?Sk1raTFBOVI0NTREeCs1Ykh5ZEhSZGxzZkZjeXpxME1Rbnppc0VyeG5ZOGYw?=
 =?utf-8?B?SlFJMXV4Nm5KbWdIQWF3aHRKTHJQQUtlNlNKMXBVRkdhS3kwYmhxdnBxQi9q?=
 =?utf-8?B?TEpxY0RIM2FzeWc4aG5qY2h5SzY3Tjk1K2JsR0M0dDVLNWF3a0ozekZnTUtR?=
 =?utf-8?B?QVUwWHhJWnFkUkwraHltbUlsUzNlTEd1Rmwvb3R1anM2MTZRTHA2YTBIN3VX?=
 =?utf-8?B?YmpSNzVWVUpxZTZxcTVzZWFXalI3UmxqMVVGZGd6eUZ6emhOY3VKT0QwNE1m?=
 =?utf-8?B?TWwrSElxdG1nODRHSHBLMEhGdm81aTlXTWQxUWdlUnNGeDdmZHk1MmpZaW9w?=
 =?utf-8?B?c1dNTVVlcVg1YWhGZHE1emxyRzdZb25qKy9VWWFSb0dkNVo0MHFJRmpRdlRu?=
 =?utf-8?B?WFNyTkhJTDlMQlhwQ3J4Qm1ZbHF5NEQ3UkJiZjdIV1VjZ05UVHJqN05ya1lm?=
 =?utf-8?B?UXhpM0ozaTZ3b2lMajMzY0xBUlNSWDVSQnZKWDBxeGo2QmVCRy9oRWQ0cGlC?=
 =?utf-8?B?c2oxZlRjMGhyeDA5bk5BL2lrZUtMbGtpeGdVM3o0SG5LaDhwN1B0RjhtTSs5?=
 =?utf-8?B?c2ljYjBsYVg2VEdCaGlzZm5peDVkUE1kc3MyVjhhYVFremFiUjVubk1oVkdk?=
 =?utf-8?B?NWtGMlN0Wk1xamNHZUpOSFl3eHJPalJ3VFN1SHVham1OZ0N0aDY4UDdlZ1hC?=
 =?utf-8?B?Q25MRkh5eVpONFo2ZW4xcnB4VTBBS21qdy9KNy9jRzVhYk1PRW8zRzhEOFY1?=
 =?utf-8?B?ZTFMdDhRdDlOdEdpL21OQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5b01ff-3f40-401d-2a4f-08d91ede0236
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 18:01:52.0161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/M6sHmVl+HVrYgcHqet3Nr25KEKOi7JINf2stYVsPwwL81z6XDCq1i6HcQpnHMR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5031
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: Kx8yf1RMu1Z7Iam_ZwbY2NT7PJhrvFLo
X-Proofpoint-GUID: Kx8yf1RMu1Z7Iam_ZwbY2NT7PJhrvFLo
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-24_08:2021-05-24,2021-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1011 suspectscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105240103
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/24/21 10:23 AM, Andrii Nakryiko wrote:
> On Sat, May 22, 2021 at 9:39 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> LLVM upstream commit https://reviews.llvm.org/D102712
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
>>   Documentation/bpf/index.rst      |   1 +
>>   Documentation/bpf/llvm_reloc.rst | 168 +++++++++++++++++++++++++++++++
>>   2 files changed, 169 insertions(+)
>>   create mode 100644 Documentation/bpf/llvm_reloc.rst
>>
>> diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
>> index a702f67dd45f..93e8cf12a6d4 100644
>> --- a/Documentation/bpf/index.rst
>> +++ b/Documentation/bpf/index.rst
>> @@ -84,6 +84,7 @@ Other
>>      :maxdepth: 1
>>
>>      ringbuf
>> +   llvm_reloc
>>
>>   .. Links:
>>   .. _networking-filter: ../networking/filter.rst
>> diff --git a/Documentation/bpf/llvm_reloc.rst b/Documentation/bpf/llvm_reloc.rst
>> new file mode 100644
>> index 000000000000..bc62bce591b1
>> --- /dev/null
>> +++ b/Documentation/bpf/llvm_reloc.rst
>> @@ -0,0 +1,168 @@
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
>> +  typedef struct
>> +  {
>> +    Elf64_Addr    r_offset;  // Offset from the beginning of section.
>> +    Elf64_Xword   r_info;    // Relocation type and symbol index.
>> +  } Elf64_Rel;
>> +
>> +For static function/variable references, the symbol often refers to
>> +the section itself which has a value of 0. To identify actual static
>> +function/variable, its section offset or some computation result
>> +based on section offset is written to the original insn/data buffer,
>> +which is called ``IA`` (implicit addend) below.  For global
>> +function/variables, the symbol refers to actual global and the implicit
>> +addend is 0.
>> +
>> +Different Relocation Types
>> +==========================
>> +
>> +Six relocation types are supported. The following is an overview and
>> +``S`` represents the value of the symbol in the symbol table::
>> +
>> +  Enum  ELF Reloc Type     Description      BitSize  Offset        Calculation
>> +  0     R_BPF_NONE         None
>> +  1     R_BPF_64_64        ld_imm64 insn    32       r_offset + 4  S + IA
> 
> There are cases where we set all 64-bits of ld_imm64 (e.g., extern
> ksym, global variables). Or those will be a different relocation now
> (R_BPF_64_ABS64?). If not, I think BitSize 64 is more correct here.

It is still R_BPF_64_64. In llvm, we have restriction that section
offset must be <= UINT32_MAX, and that is why only 32bit is used
to find the actual symbol in symbol table. 32bit permits 4GB section
which should enough in practice for a bpf program.

libbpf or tools can write to full 64bits of imm values of ld_imm64 insn.

The name is a little bit misleading, but it has become part of ABI
and lives in /usr/include/elf.h and we are not able to change it
any more.

> 
> Looking at LLVM diff I haven't found a test for global variables (at
> least I didn't realize it was there), so double-checking here (and it
> might be a good idea to have an explicit test for global variables?)

We have llvm/test/CodeGen/BPF/reloc.ll and 
llvm/test/CodeGen/BPF/reloc-btf.ll covering R_BPF_64_ABS64. But I think 
I can enhance
llvm/test/CodeGen/BPF/reloc-2.ll to cover an explicit global variable case.

> 
>> +  2     R_BPF_64_ABS64     normal data      64       r_offset      S + IA
>> +  3     R_BPF_64_ABS32     normal data      32       r_offset      S + IA
>> +  4     R_BPF_64_NODYLD32  .BTF[.ext] data  32       r_offset      S + IA
>> +  10    R_BPF_64_32        call insn        32       r_offset + 4  (S + IA) / 8 - 1
>> +
>> +For example, ``R_BPF_64_64`` relocation type is used for ``ld_imm64`` instruction.
>> +The actual to-be-relocated data is stored at ``r_offset + 4`` and the read/write
>> +data bitsize is 32 (4 bytes). The relocation can be resolved with
>> +the symbol value plus implicit addend.
>> +
>> +In another case, ``R_BPF_64_ABS64`` relocation type is used for normal 64-bit data.
>> +The actual to-be-relocated data is stored at ``r_offset`` and the read/write data
>> +bitsize is 64 (8 bytes). The relocation can be resolved with
>> +the symbol value plus implicit addend.
>> +
>> +Both ``R_BPF_64_ABS32`` and ``R_BPF_64_NODYLD32`` types are for 32-bit data.
>> +But ``R_BPF_64_NODYLD32`` specifically refers to relocations in ``.BTF`` and
>> +``.BTF.ext`` sections. For cases like bcc where llvm ``ExecutionEngine RuntimeDyld``
>> +is involved, ``R_BPF_64_NODYLD32`` types of relocations should not be resolved
>> +to actual function/variable address. Otherwise, ``.BTF`` and ``.BTF.ext``
>> +become unusable by bcc and kernel.
>> +
>> +Type ``R_BPF_64_32`` is used for call instruction. The call target section
>> +offset is stored at ``r_offset + 4`` (32bit) and calculated as
>> +``(S + IA) / 8 - 1``.
>> +
>> +Examples
>> +========
>> +
>> +Types ``R_BPF_64_64`` and ``R_BPF_64_32`` are used to resolve ``ld_imm64``
>> +and ``call`` instructions. For example::
>> +
>> +  __attribute__((noinline)) __attribute__((section("sec1")))
>> +  int gfunc(int a, int b) {
>> +    return a * b;
>> +  }
>> +  static __attribute__((noinline)) __attribute__((section("sec1")))
>> +  int lfunc(int a, int b) {
>> +    return a + b;
>> +  }
>> +  int global __attribute__((section("sec2")));
>> +  int test(int a, int b) {
>> +    return gfunc(a, b) +  lfunc(a, b) + global;
>> +  }
>> +
>> +Compiled with ``clang -target bpf -O2 -c test.c``, we will have
>> +following code with `llvm-objdump -d test.o``::
> 
> I recently learned about `llvm-objdump -dr test.o`, which shows
> relocations inline, it would be nice to use that output here.

Yes, will do.

> 
>> +
>> +  Disassembly of section .text:
>> +
>> +  0000000000000000 <test>:
>> +         0:       bf 26 00 00 00 00 00 00 r6 = r2
>> +         1:       bf 17 00 00 00 00 00 00 r7 = r1
>> +         2:       85 10 00 00 ff ff ff ff call -1
>> +         3:       bf 08 00 00 00 00 00 00 r8 = r0
>> +         4:       bf 71 00 00 00 00 00 00 r1 = r7
>> +         5:       bf 62 00 00 00 00 00 00 r2 = r6
>> +         6:       85 10 00 00 02 00 00 00 call 2
>> +         7:       0f 80 00 00 00 00 00 00 r0 += r8
>> +         8:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>> +        10:       61 11 00 00 00 00 00 00 r1 = *(u32 *)(r1 + 0)
>> +        11:       0f 10 00 00 00 00 00 00 r0 += r1
>> +        12:       95 00 00 00 00 00 00 00 exit
>> +
>> +  Disassembly of section sec1:
>> +
>> +  0000000000000000 <gfunc>:
>> +         0:       bf 20 00 00 00 00 00 00 r0 = r2
>> +         1:       2f 10 00 00 00 00 00 00 r0 *= r1
>> +         2:       95 00 00 00 00 00 00 00 exit
>> +
>> +  0000000000000018 <lfunc>:
>> +         3:       bf 20 00 00 00 00 00 00 r0 = r2
>> +         4:       0f 10 00 00 00 00 00 00 r0 += r1
>> +         5:       95 00 00 00 00 00 00 00 exit
>> +
>> +Three relocations are generated with ``llvm-readelf -r test.o``::
>> +
>> +  Relocation section '.rel.text' at offset 0x188 contains 3 entries:
>> +      Offset             Info             Type               Symbol's Value  Symbol's Name
>> +  0000000000000010  000000040000000a R_BPF_64_32            0000000000000000 gfunc
>> +  0000000000000030  000000020000000a R_BPF_64_32            0000000000000000 sec1
>> +  0000000000000040  0000000600000001 R_BPF_64_64            0000000000000000 global
>> +
>> +The first relocation corresponds to ``gfunc(a, b)`` where ``gfunc`` has a value of 0,
>> +so the ``call`` instruction offset is ``(0 + 0)/8 - 1 = -1``.
>> +The second relocation corresponds to ``lfunc(a, b)`` where ``lfunc`` has a section
>> +offset ``0x18``, so the ``call`` instruction offset is ``(0 + 0x18)/8 - 1 = 2``.
>> +
>> +The following is an example to show how R_BPF_64_ABS64 could be generated::
>> +
>> +  int global() { return 0; }
>> +  struct t { void *g; } gbl = { global };
>> +
>> +Compiled with ``clang -target bpf -O2 -g -c test.c``, we will see a
>> +relocation below in ``.data`` section with command
>> +``llvm-readelf -r test.o``::
>> +
>> +  Relocation section '.rel.data' at offset 0x458 contains 1 entries:
>> +      Offset             Info             Type               Symbol's Value  Symbol's Name
>> +  0000000000000000  0000000700000002 R_BPF_64_ABS64         0000000000000000 global
>> +
>> +The relocation says the first 8-byte of ``.data`` section should be
>> +filled with address of ``global`` variable.
>> +
>> +With ``llvm-readelf`` output, we can see that dwarf sections have a bunch of
>> +``R_BPF_64_ABS32`` and ``R_BPF_64_ABS64`` relocations::
>> +
>> +  Relocation section '.rel.debug_info' at offset 0x468 contains 13 entries:
>> +      Offset             Info             Type               Symbol's Value  Symbol's Name
>> +  0000000000000006  0000000300000003 R_BPF_64_ABS32         0000000000000000 .debug_abbrev
>> +  000000000000000c  0000000400000003 R_BPF_64_ABS32         0000000000000000 .debug_str
>> +  0000000000000012  0000000400000003 R_BPF_64_ABS32         0000000000000000 .debug_str
>> +  0000000000000016  0000000600000003 R_BPF_64_ABS32         0000000000000000 .debug_line
>> +  000000000000001a  0000000400000003 R_BPF_64_ABS32         0000000000000000 .debug_str
>> +  000000000000001e  0000000200000002 R_BPF_64_ABS64         0000000000000000 .text
>> +  000000000000002b  0000000400000003 R_BPF_64_ABS32         0000000000000000 .debug_str
>> +  0000000000000037  0000000800000002 R_BPF_64_ABS64         0000000000000000 gbl
>> +  0000000000000040  0000000400000003 R_BPF_64_ABS32         0000000000000000 .debug_str
>> +  ......
>> +
>> +The .BTF/.BTF.ext sections has R_BPF_64_NODYLD32 relocations::
>> +
>> +  Relocation section '.rel.BTF' at offset 0x538 contains 1 entries:
>> +      Offset             Info             Type               Symbol's Value  Symbol's Name
>> +  0000000000000084  0000000800000004 R_BPF_64_NODYLD32      0000000000000000 gbl
>> +
>> +  Relocation section '.rel.BTF.ext' at offset 0x548 contains 2 entries:
>> +      Offset             Info             Type               Symbol's Value  Symbol's Name
>> +  000000000000002c  0000000200000004 R_BPF_64_NODYLD32      0000000000000000 .text
>> +  0000000000000040  0000000200000004 R_BPF_64_NODYLD32      0000000000000000 .text
>> --
>> 2.30.2
>>
