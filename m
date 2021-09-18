Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C22410321
	for <lists+bpf@lfdr.de>; Sat, 18 Sep 2021 05:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240530AbhIRDBk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 23:01:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34328 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238949AbhIRDBg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Sep 2021 23:01:36 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18HLWm1M012902;
        Fri, 17 Sep 2021 20:00:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=NME9Q224ChrMxbocKp1jnhnSto7pc6njVZbCKGtpvoc=;
 b=H3tLpqoPK+NLE4+LEyv6PxhPDw8Vmggb2IULjj3Vm554/YQMlTF5CVle9wRnoBvMXup2
 M6KIeRE59RxvYC+rNir5rEIvt/sHBx6gLQAW/LPDqQL7PMaDdhpyqGt5lx3btPahoo41
 yj+VhgXFpQ7WAmOdQ9nZiZH7y1uX8YOkPRo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3b531ah9th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Sep 2021 20:00:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 17 Sep 2021 20:00:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiSYErhzrAZffL5G17o+JNmGIaOlXpMr/qD85iskSM0xZnx+Z/v3wyHcotIi9AxI7t/5/bLlhBPt1IplqjcpNU8Y0omhZBSeVuWTAuJgj9ck+0dDOK/sgB9TDCvXs6GC98M2RxjgdziT3M/NaBSNEph8F8M8Fmxc1rItenmUN8Mj8jGFqNqIa7fWyHPRYZtqtaDF5utzZdwf/1+7hJGn8Ognd4SNgcyTbcU/tsNlghbvu8ix57pMrbDmq7OvLWGz/QeGoFRFFBkCRRJtzuQuh8+0SIEoQu8fRRczRBEVl5xI7xraQ6FoINXolRbUefE+8fJkwxpaGHGSYadqH+vDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=NkZSylD4DWqKGJBeRXSEZz4kqIpm/Lh2+jNgCjHwykU=;
 b=dejWigGeK7fGAmsTDKiga72RZ4abUBBImr+5ex0KTZjPxwgtgM1c225EFqvj1Q4eKYXZJuj6RdVydExkUS+q37IBh979jCT0qip62i00nfrsuPEtgIZPIMOorNmwUKoRnvBBMcN/il7Tw1FcGXjAgNCv5WOR6iiNu1URZ3BEOyuJR4T9xcnyTmVlC5QuDhMttoaFL+eBMqMQk+5aaUFwSUoQD2liUINjx9C9To1xN2EvMaS5lTgFbIr5THRVqygqRfAwPHuXUPfPDcHodZvFgH7k1A4fXMATY92RVU9Y035o/qBz4cUUcnPkiPeUweZGo+2SQ6I0lqtD7A+S5ecYQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB4016.namprd15.prod.outlook.com (2603:10b6:806:84::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Sat, 18 Sep
 2021 03:00:10 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4523.017; Sat, 18 Sep 2021
 03:00:10 +0000
Subject: Re: llvm-objdump bpf coredump
To:     Vincent Li <vincent.mc.li@gmail.com>, bpf <bpf@vger.kernel.org>
References: <CAK3+h2wW-tWOT+VBOc8QjRcbhMX3dCpsvE9if4VOA8s7R2icjg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <dbf6ca0a-2c06-c703-6852-760b321e7219@fb.com>
Date:   Fri, 17 Sep 2021 20:00:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <CAK3+h2wW-tWOT+VBOc8QjRcbhMX3dCpsvE9if4VOA8s7R2icjg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: CO2PR04CA0115.namprd04.prod.outlook.com
 (2603:10b6:104:7::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Received: from [IPv6:2620:10d:c085:21e8::1426] (2620:10d:c090:400::5:3149) by CO2PR04CA0115.namprd04.prod.outlook.com (2603:10b6:104:7::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Sat, 18 Sep 2021 03:00:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bda6852c-36ff-4731-da7e-08d97a506d42
X-MS-TrafficTypeDiagnostic: SA0PR15MB4016:
X-Microsoft-Antispam-PRVS: <SA0PR15MB4016ABD35E0956D4C05F8AABD3DE9@SA0PR15MB4016.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bzXIbZC4LIKONJjeFkg8qahytl4aC624oQu0Cvuw8lTrFLx4/xbceBZhXFSc8JpJf7LJt8qg39Ai8Xg66CAN9JPu9wYGWS7EvKFJdWGDPaD0vrYz82Deg7thwDarqI92uvcUh2QwqlSRRQxC/UQ4h1uKi0j6oj1S37a/FVPzNozJfAzwlOuQrNhOojvHjPqVEZEoyMUa0gigW7aVhsOOJCU7f73mA0WPohhkpE2B+3RTAL87C/NNTgvq4SBbT/A4dkZ8fEWE7idrlhSkzll9MpyI9k2t8c5kBZeCFLEccC/XlYdQJTJV1ZQNFoOv2dRI8j7Y9U8v4RQXNyKx3sqmCbodAOhy5qMXx2kDtrASvNyYZ6HPc+/b5zU6d46xyyvFJYF6BWV9ui81QM55GY/oHxKxiGGQwnPjPVrI3cpNNrwnZ/x4uWN3VoWI4RhbrqLC0vOdLR6XOTTUlMLHejeDDwEszkb3PlzJC/Yla6AlzueVlGdn247EtH0/trLzOTpseuukYOSpJwor8xhDEMBBep9HXLDenM3pthg+MM9IOe1TaRxIarPr4CDBPNEgZdCydPyStBHojxx3MxSHRvjyGuT8BXsm9fDMP0t+zW5Az9RSXvpFuChTTmzRsPZKISg78ts3v3aHEnwaHyXIdIEQJ34+MoWijZFZSjDiXySQF/yD6WMQRarvdDOSag38xoAxlHbVkJYTNFhVhWq7DD13imLF/GGOWMmRJHBu4tyLn0fD4V/9VAkT+3ajwIxjLKszOzIjKWGyNFj3DCGcBbdON1pg+HRt9MB/VU+0S9NyaW78NhukW3ju6vkAc9EkuZ3MSuxCRZS64Pd/tUHx/U/x2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(508600001)(6486002)(110136005)(2906002)(36756003)(31696002)(38100700002)(3480700007)(316002)(966005)(86362001)(2616005)(8676002)(186003)(53546011)(66556008)(66946007)(5660300002)(66476007)(83380400001)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFNZSnZMTjFSZWVnOFRXWUVSY1VKQ3IrVmhFOGNpSldlRXpZT04zRFNpbGlJ?=
 =?utf-8?B?WEtGbFdXYm50OWYwQ1ovTExzWU5mY0ljcVV1L3F1Sk5lMDkxMjVYaXMzTVZp?=
 =?utf-8?B?SkdvTW5jUjdJSktkWUxXTXB1ViswWTJZMEJZaXNBTXpVaEtVNWpWMjJtcHlx?=
 =?utf-8?B?empBQWFBK2dSZ05HVzVnODZIdURDZjRCTWdhYjlVQ3JCampzLzBZY2NqY2cr?=
 =?utf-8?B?VThvVWU1aU0wNG1IZUtxOXNibGZ0RFE2cVVFcnJYVFdsUmRwZnBtWG1tK2Iv?=
 =?utf-8?B?bkYvb0NhTElSemk5cmpnMm9oU2N0M0NtcHVoeTdWL1ovMVpVV0s0MmV0UExN?=
 =?utf-8?B?eWNSQ1Fzazd6N1N4blhCdFVEVkd0NFJhTC9qUVFUNWVtUHlvYmVaSHh6dU4z?=
 =?utf-8?B?Skg5RkdISFVmb1VEcjJQM0dQdldFM2dDeXZ6NkZQeisrZTRQOXMzdGRwTm9F?=
 =?utf-8?B?TGpRN0ZuTkhMNVRlVHIyYmllTk1DdWVwV3lSZlNuVlNUeklJYlhPc3o4V1F3?=
 =?utf-8?B?bHdmUUVFR3dFbHlJYVhFejkyajQ2MDZEWWd3VDJNNC91WFNmVVJvbmRvYU5n?=
 =?utf-8?B?OHRhSmsra2xyVWpWSkozaFExN0xmaEhsSmpQT3Y3ZkVzR1JjeWRKRWZnZUhk?=
 =?utf-8?B?d3VjUnJER0lMOHBjMnpyVmJMNVNBMmFkaTVOSEJHa2ZRMGpPTjZJcnUxZkJH?=
 =?utf-8?B?aHJuM3lWcGhXNzRVMWNmelZjUk1JR01nZURiUVMxU2J0VTA4UTBOUURsWnU2?=
 =?utf-8?B?bGtBem9Xd0JIbUVQaUxwM2F2ZU5BYTVxeEcyVC80aVFVaFFPbGgwclowZHdY?=
 =?utf-8?B?cUdQKzRRa1dsSHFSRWhSZWR2L3VtbnZReWdMbWVlczI1MW1QSmIrenA0STE4?=
 =?utf-8?B?NmcxakdON3ZldjloSzl5V1pSeFBORWgzdU9keXYyS2hGM1p6eGgza2YzVFZ0?=
 =?utf-8?B?QnlFMUJGZU1ETGlERzZ3T2UxZjFubW1zTGIwNmpGb0greXZoMlJCN2xxL3Fo?=
 =?utf-8?B?cEtNMzJnSmJ4THoxMytMck16cmdFVitrajRQQWRJaHdBMUxuNjNzV293M2tt?=
 =?utf-8?B?NWNoVXJrd1hkRDVvN2UxdzE5amRHeWxVNEpZQW04NytRbmdJR2p4aW0wTDVt?=
 =?utf-8?B?M2FnV0hTNW84eXlFdE5GT3ZuSEVocHh0cWI4czdEaFFKYldVaXozbkJnMXQx?=
 =?utf-8?B?RllaZ2hLMlN2VkZ0U3ZrWGIwNHBodDExKzhXem1QYWVDZkIrZTlqQjlSQS9l?=
 =?utf-8?B?YUFQb1RQV2FVdld5ZU0zbmhHa3dtMmtPUjJKbCthWi9NUXVtZnhwNTgvWncr?=
 =?utf-8?B?MFJycWRRd01WWVd6bmRKc3JWWlNFcW1ENHlKVS9IbW95VzBld3daK0VUYVpE?=
 =?utf-8?B?dWRSNTlydWtWSFloMFcycDVDKzZJTWVjZFNsWXhjTGJEVWlUdTVqa2lIYmlh?=
 =?utf-8?B?MzN0WWRTRWFUUWxFdUJwN0RXcUhrL01UUmQ5ZVZhc3BsTG56OUNhWU1BR2Vl?=
 =?utf-8?B?Z2FNQnR3SE0zZy9vYk93SHNOWkpxdE9Jc1VHZ1Y5azNyc3pXcW94ZmM4V25K?=
 =?utf-8?B?eUpTTWVQODhyY0Q1WG5VcG1DbVZLeGN1ai9JbUxJLzViY0xQbFg4Tk42N3BQ?=
 =?utf-8?B?ZWVhVGwwWXV0V0RTWElaYUJGaGMxL3FpckJFN0ZZTTNuVDVGZG85UDhoYndp?=
 =?utf-8?B?NmRnbEgzeCtuay9PYW04Y2RwVzJmS0V6Z0poOFdhQWF1ZnU1Q2RYV01xcXJo?=
 =?utf-8?B?SzFhUTZibUx2RnhjcmhPa3lWUDBLRFFTbVkwWXNQMU1ValdTaEpwZ25GN3RF?=
 =?utf-8?Q?ll8+wsW3OO2PqnhsshjM/aEuAdZZePe0kx4ws=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bda6852c-36ff-4731-da7e-08d97a506d42
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2021 03:00:09.9645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6GQnXIv6NLLzwtxLdzmQkEHUMagKUJJr3fAVBa4svfmKdpj1nW4APD+xC0pSOYJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4016
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: ctsy2yazB6s4z51r1naYoZdGA3LIwHwx
X-Proofpoint-GUID: ctsy2yazB6s4z51r1naYoZdGA3LIwHwx
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-18_01,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109180018
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/17/21 6:34 PM, Vincent Li wrote:
> Hi,
> 
> I am supposed to file a bug report in https://bugs.llvm.org/  but the
> site requires account login, while waiting for my account setup, and
> since this is related to BPF, I will try my luck here :)
> 
> This is cilium environment, when I use llvm-objdump to disassemble the
> bpf_lxc.o like below, it core dumps
> 
> #llvm-objdump -S -D  /var/run/cilium/state/2799/bpf_lxc.o >
> /home/bpf_lxc-5.4.txt

Any particular reason you are using '-D' here?

"llvm-objdump --help" gives:

   --disassemble-all       Display assembler mnemonics for the machine 
instructions 

   --disassemble           Display assembler mnemonics for the machine 
instructions 


   -D                      Alias for --disassemble-all 
 

   -d                      Alias for --disassemble

It gives the same description about -D and -d but actually -D tries to 
disassemble *all* sections and -d tries to disassemble *only* executable 
sections.

The following is an example to disassemble a selftest bpf program 
bpf_iter_tcp4.o:

[yhs@devbig003.ftw2 ~/work/bpf-next/tools/testing/selftests/bpf] 
llvm-objdump -D bpf_iter_tcp4.o >& ~/log
[yhs@devbig003.ftw2 ~/work/bpf-next/tools/testing/selftests/bpf] grep 
"Disassembly of section" ~/log
Disassembly of section .strtab:
Disassembly of section iter/tcp:
Disassembly of section .reliter/tcp:
Disassembly of section license:
Disassembly of section .rodata:
Disassembly of section .debug_loc:
Disassembly of section .debug_abbrev:
Disassembly of section .debug_info:
Disassembly of section .rel.debug_info:
Disassembly of section .debug_ranges:
Disassembly of section .debug_str:
Disassembly of section .BTF:
Disassembly of section .rel.BTF:
Disassembly of section .BTF.ext:
Disassembly of section .rel.BTF.ext:
Disassembly of section .debug_frame:
Disassembly of section .rel.debug_frame:
Disassembly of section .debug_line:
Disassembly of section .rel.debug_line:
Disassembly of section .llvm_addrsig:
Disassembly of section .symtab:
[yhs@devbig003.ftw2 ~/work/bpf-next/tools/testing/selftests/bpf] 
llvm-objdump -d bpf_iter_tcp4.o >& ~/log
[yhs@devbig003.ftw2 ~/work/bpf-next/tools/testing/selftests/bpf] grep 
"Disassembly of section" ~/log
Disassembly of section iter/tcp:
[yhs@devbig003.ftw2 ~/work/bpf-next/tools/testing/selftests/bpf]

You can see, "-D" tries to disassemble *all* sections and "-d" only 
tries to disassemble "iter/tcp" section which is the *text* section.

I suspect llvm BPF backend may have some loose end which didn't handle
well for illegal insn, which I will put up a task so we can fix it.

I guess you tries to disassemble for non-text sections because you want
to compare contents of sections with text file? If this is the case,
you may want to compare section data directly, because disassemble
illegal insn will result in "<unknown>" insn which may hide the
actual data difference. In any case, it would be good to know what you
try to do with "-D" result so we may discuss to find a proper solution.

> 
> PLEASE submit a bug report to https://bugs.llvm.org/  and include the
> crash backtrace.
> 
> Stack dump:
> 
> 0. Program arguments: llvm-objdump -S -D /var/run/cilium/state/2799/bpf_lxc.o
> 
>   #0 0x00000000006336bc llvm::sys::PrintStackTrace(llvm::raw_ostream&,
> int) (/usr/local/bin/llvm-objdump+0x6336bc)
> 
>   #1 0x00000000006318a4 llvm::sys::RunSignalHandlers()
> (/usr/local/bin/llvm-objdump+0x6318a4)
> 
>   #2 0x0000000000631efd SignalHandler(int) (/usr/local/bin/llvm-objdump+0x631efd)
> 
>   #3 0x00007f9f39a7fb20 __restore_rt (/lib64/libpthread.so.0+0x12b20)
> 
>   #4 0x0000000000492e8b
> llvm::BPFInstPrinter::printMemOperand(llvm::MCInst const*, int,
> llvm::raw_ostream&, char const*)
> (/usr/local/bin/llvm-objdump+0x492e8b)
> 
>   #5 0x00000000004946c0 llvm::BPFInstPrinter::printInst(llvm::MCInst
> const*, unsigned long, llvm::StringRef, llvm::MCSubtargetInfo const&,
> llvm::raw_ostream&) (/usr/local/bin/llvm-objdump+0x4946c0)
> 
>   #6 0x0000000000432351 (anonymous
> namespace)::BPFPrettyPrinter::printInst(llvm::MCInstPrinter&,
> llvm::MCInst const*, llvm::ArrayRef<unsigned char>,
> llvm::object::SectionedAddress, llvm::formatted_raw_ostream&,
> llvm::StringRef, llvm::MCSubtargetInfo const&, (anonymous
> namespace)::SourcePrinter*, llvm::StringRef,
> std::vector<llvm::object::RelocationRef,
> std::allocator<llvm::object::RelocationRef> >*, (anonymous
> namespace)::LiveVariablePrinter&)
> (/usr/local/bin/llvm-objdump+0x432351)
> 
>   #7 0x00000000004400b8 disassembleObject(llvm::Target const*,
> llvm::object::ObjectFile const*, llvm::MCContext&,
> llvm::MCDisassembler*, llvm::MCDisassembler*, llvm::MCInstrAnalysis
> const*, llvm::MCInstPrinter*, llvm::MCSubtargetInfo const*,
> llvm::MCSubtargetInfo const*, (anonymous namespace)::PrettyPrinter&,
> (anonymous namespace)::SourcePrinter&, bool)
> (/usr/local/bin/llvm-objdump+0x4400b8)
> 
>   #8 0x000000000044444e disassembleObject(llvm::object::ObjectFile
> const*, bool) (/usr/local/bin/llvm-objdump+0x44444e)
> 
>   #9 0x00000000004454e2 dumpObject(llvm::object::ObjectFile*,
> llvm::object::Archive const*, llvm::object::Archive::Child const*)
> (/usr/local/bin/llvm-objdump+0x4454e2)
> 
> #10 0x0000000000409910 main (/usr/local/bin/llvm-objdump+0x409910)
> 
> #11 0x00007f9f3854c493 __libc_start_main (/lib64/libc.so.6+0x23493)
> 
> #12 0x000000000042384e _start (/usr/local/bin/llvm-objdump+0x42384e)
> 
> Segmentation fault (core dumped)
> 
> I compiled and installed llvm and clang 12.0.1 myself
> 
