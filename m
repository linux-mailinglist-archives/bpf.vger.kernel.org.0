Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1C9410DD8
	for <lists+bpf@lfdr.de>; Mon, 20 Sep 2021 01:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhISXhd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Sep 2021 19:37:33 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5434 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229517AbhISXhc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 19 Sep 2021 19:37:32 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18JEM2sX024311;
        Sun, 19 Sep 2021 16:36:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=QV5xWZg11sIvn785bgKm0c/MFrlPLAvwtnOqlW/CTcY=;
 b=Loyn6Vxy2N5kkykwEB/cBFEqsqVZYZFQoxTx1rb/YZMp6Ba6XYXL4WMT4ZSRSTVzFn9Z
 Tapsnelnb73tLfOMeUWtbNsiTVxYKuiyRQTPi6jVXvp2IDpn8s0juGTXo35N59GISZEc
 fq3KQ9GX+dlToAyBgk6YeTX5Px1klIYS6h4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3b5bmcerhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 19 Sep 2021 16:36:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 19 Sep 2021 16:36:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fu3WFcVfG9+aHQ7TisSZg398NfOlVyfiOpNus0VPSbxo+kunJjAGDbS6rrFtL3hDH+eEHQ2MGvgylqesGpdyS6Vy7LjkVf7HxKgDx4vQKEyMxjWLPBM7eKQCiPQWCZI1uUF8RkJR0p3ssnh7ydxw0ijPQmysE0uzn4VMfOvzAvvyUQjv7F+bZCW8HtzyVLsJji7j5K9+b9xAqL2Ynow0xyyV+mUyBr88MEayer78gCwtBpIndy4/5h/nrUL8f+5xTXkQQ7MKCpnkDVuCIehOc+RjTg732zlAnB1LDpNjfIwAwk2QdlJKHqMuBASBJEGCYbwFLdvG4v44cOHQ8BSDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tpXjo0DLbYEYFytv4bwuRHpD930rRXLvshKIIvD9o4w=;
 b=hQxILHtOSeAx7GxYemfGMUX/QdBH21RF6lrp1tXzQTp71f09q4Tgvlyr4Vu4JPBJfMB8spNdOKKhSqdJl/b7dMrZcHIF6UPZBIX5G9s5sAQjMUUyHVaGc5Cf09wesB79af6fmVCv5skWrdTs8oyzYkdZia7UAOHL0y3CcCVxxYuFrKq8OKVlDDO5lNzg7PIKgDI3ZeqbbDYI+3W/2xUv7iGoPFWhXsqwVGSgj6HV61aovG78ggXVktVOIPfhRmoe6x+kKK5SzAi9xhb8AsgNfEKCAaVDqIUgJUlWx6Kbgvq3xU8ZBx5bKEBP6Z3YtjBoyYt4FFGclJOHN0BqyQgFJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3966.namprd15.prod.outlook.com (2603:10b6:806:8e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Sun, 19 Sep
 2021 23:36:03 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4523.018; Sun, 19 Sep 2021
 23:36:03 +0000
Subject: Re: llvm-objdump bpf coredump
To:     Vincent Li <vincent.mc.li@gmail.com>
CC:     bpf <bpf@vger.kernel.org>
References: <CAK3+h2wW-tWOT+VBOc8QjRcbhMX3dCpsvE9if4VOA8s7R2icjg@mail.gmail.com>
 <dbf6ca0a-2c06-c703-6852-760b321e7219@fb.com>
 <CAK3+h2zaFOAjf6LSLeTr0QzjRKKFhPAD17OZ6N7dgUe8kUCt6Q@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <91c00a68-be33-77ba-006d-244022d72105@fb.com>
Date:   Sun, 19 Sep 2021 16:36:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <CAK3+h2zaFOAjf6LSLeTr0QzjRKKFhPAD17OZ6N7dgUe8kUCt6Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: BYAPR11CA0076.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Received: from [IPv6:2620:10d:c085:21c8::110e] (2620:10d:c090:400::5:2e8b) by BYAPR11CA0076.namprd11.prod.outlook.com (2603:10b6:a03:f4::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Sun, 19 Sep 2021 23:36:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6c43720-096c-4c95-aafb-08d97bc63e44
X-MS-TrafficTypeDiagnostic: SA0PR15MB3966:
X-Microsoft-Antispam-PRVS: <SA0PR15MB396644FEB8B759B1FED87E95D3DF9@SA0PR15MB3966.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V13ksqRiXOCiIYmYGbZI7latz3pKmNb8/7GeS93eYS5/sxeertk5AfOdYEcwq+kahXfH0ZdOiLqyE5G8GOFvQ0hoTI0bsDgsjpV9UBsaieQORdw8dXF/MZqscm1UgHxH3jebsXcLP/Suta6+YdxTlzRA2FsW2xXXjqLKZGLxS89IZIBsJhlwVobr74Qtd5c109uOxBM8mHwuYl/lHWpzCaeKc4etoOv/YW8nmSS3fecBHJfpi0e+CHgO+lC+kvzHDh8U9mTWk5DBLoUx8eChaF6xDw8WxjyVMVO79DQ7u/Y3iHZCAy19I3jaOUICEsR4vfMWIYnLTh5DN3ZhcKdwExGh/T4BVRwv1t1j/MOHmto/4DF5GfGFvncv5NB/S6y4x+4sqrsxDdFNWraeTUU3WqciUHrCd69YAfQ746jNGmTdSrLuig5Y/57w+B/yG3HXhTr4EhodkmYEefc4yWfrCyaLNZDGg01v8mZcr0L5h7pfg3Hulkgsh3+/3aT7jq8yIwzbkD4n115r1TLPOB86CRHv2YvLBRcDLisdLhDZ5uNmZLoMovr8tTft6FZ1WGyLqJU+ops4nG1u4x2xaua5ZvTxqkXDdObfvo7IfRR/7pShYlxGf8ZgLyKDeEZ6Fai8Nk0PiDBvY1Yq/MwpGinmwXejb6+gZDpkcT3R+1RVHJz8M3XDg7sSl+r0XOFsZ5pco7JGUmc08QUt27iirRGQ+yJ14ZOWCAE7pbHqMHKtbqS1RtTkljnkBIYKRAWE4HhZZymi8MJtedFNBqBAJe9d2P01cebGSfbJbjA+FHjbixco8qV2FGZrdlISeTi9JPD9SgBaL/C+NgCeV9qi1NFEDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(31686004)(316002)(2906002)(186003)(5660300002)(478600001)(38100700002)(6486002)(66556008)(83380400001)(66946007)(53546011)(6916009)(31696002)(52116002)(3480700007)(4326008)(36756003)(8676002)(2616005)(66476007)(86362001)(8936002)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0ZFcElRM3JOK3lJR002M2k5WWtieXdHVXJUSVM5M3hjcXNqZUI4ZTVlZ1FR?=
 =?utf-8?B?Zm12UlRDc1BHa1pnZjRWQ0VsL2FheGVURDlRNlNaaWVJekdTVUlSWk0vS3hH?=
 =?utf-8?B?UmM1Qi93bGhCMkdKcFEvN3hGSEdnSjZvaTFHemlnK3g4NmpRSCs4M3BHYzJB?=
 =?utf-8?B?Y2JUNVZQSGhzaXpoajZWZDd4YTRmcWtrM0NXNmp3WDFDK2IxQUtReDhSNGNX?=
 =?utf-8?B?M2FIN2N5RUtjMTFISXNtc2oveEIvVEx3SlVscU1obVIwOHZIVEJMQW04K3Z2?=
 =?utf-8?B?V0hlT0VoOWJmZHozbkEzTXRWdFB0RlVFcDRpdzQwZmdJQlI0Z0F1K3hNVWpJ?=
 =?utf-8?B?em1ORllOZEowcFdZNCszeEVLU1B3QUNoZmhUV3Y4RzVNTHN5RlU1K3M5ZnVD?=
 =?utf-8?B?NGF6MjNCWUV3MGoxL3E5VHV3ZFIyN0JiOVd1NkdGRm5PalJROWNpeG03WW9m?=
 =?utf-8?B?TkZqbVQ0ZFdCNUpQMk8wZGVaV2NwbUt5T2lzTGN1OSt0Qy95VVI2Nm9PUGIw?=
 =?utf-8?B?RFliekV3QnFCUkZyZHZRKzJJOElueEFQWHQ3a1poa3VjN0Z5enZzMkFDWXZ1?=
 =?utf-8?B?RmFXWk1mUG5QVTZOOXdFampTWDUvVXdjclFaOEJnd3Fkd1VmcktzRDhQK0pq?=
 =?utf-8?B?UGhmeFAwYy9DemhZcHNtcWhaYk5JK1JRdXZFTy9aWks4dk5tY2QzQlBzekZt?=
 =?utf-8?B?cWNvbm15R1hVVlhGN0ZScUNNS294YXdHN3dUZlpWNHVsV1pmU01YNHkyWFpE?=
 =?utf-8?B?L1NneEw5Z3huTW5NY1ZOQ3RpWHZibERoYS9FOW1tdUtIKzMxaUhoMjBkK2xh?=
 =?utf-8?B?SUE3RzEwM0F5YlViUlRCTm5mZmdNMmF1TkxyREtiNGdTNDZodW8xZFpmQ3lC?=
 =?utf-8?B?SlZXSjRaQUpyN3ZxMmxlZUs5VU1SMW1jOGZPTVppdW1xMTljZnkxbnF2dWNP?=
 =?utf-8?B?SWRYQldNeXU4emRyY0NiVDdNQ3BoVysrdXJweWI0RlR2azJqL0R0UXBLV1JK?=
 =?utf-8?B?UmVrNXBQdFpyYm1RL2sxZXJkQ2NhVWhqSy9aSWpJWng5QVJjWmh3TjR3ZVJi?=
 =?utf-8?B?SWRWRDdkUGVlRFRXbU11emNhRTBtOFRSaTYyVGU4dFdBc2RlZyswNHlWL3Jl?=
 =?utf-8?B?OE9GSHN3UmNXV1hnVDN6SHlseWZWTHkzczVMdzYvMWRIYncrWG9yQ1E0MmF2?=
 =?utf-8?B?RGFzdHBrblBwTEZGLzFQUkFIeWhjQzdzZ2JvdEh1My9xS0JsNFl1ZmhxMlNU?=
 =?utf-8?B?L1pUbmhIalZYRDJVMFpybG9SNlRQblpISVNrT0dhNnY0Zitxb2hMcFora0g2?=
 =?utf-8?B?b1RXOWZsblUwYVJJZDI3NmV3OE1rWmZQRytZOGR1TFhFMW1RNUx5cXo1ekVE?=
 =?utf-8?B?aGo3RklzNkhnQWoyYWZoT0U3NEYvaC9LY0FDOVJKMkE2MFJXRXI1a0s3cm1i?=
 =?utf-8?B?RGtZMm1YcHozMWtvbFNYbHFJQUpXVVVUR1pNTVN6U2pUcERobEVqRTBOZmtT?=
 =?utf-8?B?bUw3a3RuTlJCMWdkcG1FNnFGZjhnYU9NcGlYWkk5TTNMNkw2cHdXbDVtd1lq?=
 =?utf-8?B?b1Q5a2NVWEsreThqV2xBTHB0QVNjaFJBNCtVemZ3Tkx6QnZyZCtYR3ZLWmNP?=
 =?utf-8?B?RGQzcWVTTm42aFhycGp6WTJ0a1R0cEFzVXJUSUFvQk5EODI1VFJjNVhESVgx?=
 =?utf-8?B?aGpUdE5wR1hNTDVxcFc0MFpac3ZvUllobWpVaVMyeXJUcldpU0ZrSnNmdHlu?=
 =?utf-8?B?OG52aC9sVThzWXYvWDlzVXk5dUptOWJHRFoySFFKYlBaTzdKUVlmd09NOXhR?=
 =?utf-8?Q?uz0zYSKDtcv7fAIP7r8Meu3AEHdX7fVGf3Ubc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c43720-096c-4c95-aafb-08d97bc63e44
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2021 23:36:02.9333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3q/Eix2agEyugkJyUR9h5XCwPaudgKH072QG4hOjZAhSS6JRzQOjwZlQVRhAdITa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3966
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: sIegwqfjsSlRSCQJinqtAsKihgMC4zo0
X-Proofpoint-GUID: sIegwqfjsSlRSCQJinqtAsKihgMC4zo0
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-19_07,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 impostorscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109190174
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/18/21 8:41 AM, Vincent Li wrote:
> On Fri, Sep 17, 2021 at 8:00 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 9/17/21 6:34 PM, Vincent Li wrote:
>>> Hi,
>>>
>>> I am supposed to file a bug report in https://bugs.llvm.org/   but the
>>> site requires account login, while waiting for my account setup, and
>>> since this is related to BPF, I will try my luck here :)
>>>
>>> This is cilium environment, when I use llvm-objdump to disassemble the
>>> bpf_lxc.o like below, it core dumps
>>>
>>> #llvm-objdump -S -D  /var/run/cilium/state/2799/bpf_lxc.o >
>>> /home/bpf_lxc-5.4.txt
>>
>> Any particular reason you are using '-D' here?
>>
>> "llvm-objdump --help" gives:
>>
>>     --disassemble-all       Display assembler mnemonics for the machine
>> instructions
>>
>>     --disassemble           Display assembler mnemonics for the machine
>> instructions
>>
>>
>>     -D                      Alias for --disassemble-all
>>
>>
>>     -d                      Alias for --disassemble
>>
>> It gives the same description about -D and -d but actually -D tries to
>> disassemble *all* sections and -d tries to disassemble *only* executable
>> sections.
>>
>> The following is an example to disassemble a selftest bpf program
>> bpf_iter_tcp4.o:
>>
>> [yhs@devbig003.ftw2 ~/work/bpf-next/tools/testing/selftests/bpf]
>> llvm-objdump -D bpf_iter_tcp4.o >& ~/log
>> [yhs@devbig003.ftw2 ~/work/bpf-next/tools/testing/selftests/bpf] grep
>> "Disassembly of section" ~/log
>> Disassembly of section .strtab:
>> Disassembly of section iter/tcp:
>> Disassembly of section .reliter/tcp:
>> Disassembly of section license:
>> Disassembly of section .rodata:
>> Disassembly of section .debug_loc:
>> Disassembly of section .debug_abbrev:
>> Disassembly of section .debug_info:
>> Disassembly of section .rel.debug_info:
>> Disassembly of section .debug_ranges:
>> Disassembly of section .debug_str:
>> Disassembly of section .BTF:
>> Disassembly of section .rel.BTF:
>> Disassembly of section .BTF.ext:
>> Disassembly of section .rel.BTF.ext:
>> Disassembly of section .debug_frame:
>> Disassembly of section .rel.debug_frame:
>> Disassembly of section .debug_line:
>> Disassembly of section .rel.debug_line:
>> Disassembly of section .llvm_addrsig:
>> Disassembly of section .symtab:
>> [yhs@devbig003.ftw2 ~/work/bpf-next/tools/testing/selftests/bpf]
>> llvm-objdump -d bpf_iter_tcp4.o >& ~/log
>> [yhs@devbig003.ftw2 ~/work/bpf-next/tools/testing/selftests/bpf] grep
>> "Disassembly of section" ~/log
>> Disassembly of section iter/tcp:
>> [yhs@devbig003.ftw2 ~/work/bpf-next/tools/testing/selftests/bpf]
>>
>> You can see, "-D" tries to disassemble *all* sections and "-d" only
>> tries to disassemble "iter/tcp" section which is the *text* section.
>>
>> I suspect llvm BPF backend may have some loose end which didn't handle
>> well for illegal insn, which I will put up a task so we can fix it.
>>
>> I guess you tries to disassemble for non-text sections because you want
>> to compare contents of sections with text file? If this is the case,
>> you may want to compare section data directly, because disassemble
>> illegal insn will result in "<unknown>" insn which may hide the
>> actual data difference. In any case, it would be good to know what you
>> try to do with "-D" result so we may discuss to find a proper solution.
>>
> 
> Yonghong, thank you for the detail explanation, it is me not clear
> about the usage of
> llvm-objdump, should have read the manual or try different argument
> before this post,
> thought better reporting the crash dump than doing nothing :)

No worry. Yes, crash is not good. We will need to fix it.

> 
> Vincent
> 
> 
>>>
>>> PLEASE submit a bug report to https://bugs.llvm.org/   and include the
>>> crash backtrace.
>>>
>>> Stack dump:
>>>
>>> 0. Program arguments: llvm-objdump -S -D /var/run/cilium/state/2799/bpf_lxc.o
>>>
>>>    #0 0x00000000006336bc llvm::sys::PrintStackTrace(llvm::raw_ostream&,
>>> int) (/usr/local/bin/llvm-objdump+0x6336bc)
>>>
>>>    #1 0x00000000006318a4 llvm::sys::RunSignalHandlers()
>>> (/usr/local/bin/llvm-objdump+0x6318a4)
>>>
>>>    #2 0x0000000000631efd SignalHandler(int) (/usr/local/bin/llvm-objdump+0x631efd)
>>>
>>>    #3 0x00007f9f39a7fb20 __restore_rt (/lib64/libpthread.so.0+0x12b20)
>>>
>>>    #4 0x0000000000492e8b
>>> llvm::BPFInstPrinter::printMemOperand(llvm::MCInst const*, int,
>>> llvm::raw_ostream&, char const*)
>>> (/usr/local/bin/llvm-objdump+0x492e8b)
>>>
>>>    #5 0x00000000004946c0 llvm::BPFInstPrinter::printInst(llvm::MCInst
>>> const*, unsigned long, llvm::StringRef, llvm::MCSubtargetInfo const&,
>>> llvm::raw_ostream&) (/usr/local/bin/llvm-objdump+0x4946c0)
>>>
>>>    #6 0x0000000000432351 (anonymous
>>> namespace)::BPFPrettyPrinter::printInst(llvm::MCInstPrinter&,
>>> llvm::MCInst const*, llvm::ArrayRef<unsigned char>,
>>> llvm::object::SectionedAddress, llvm::formatted_raw_ostream&,
>>> llvm::StringRef, llvm::MCSubtargetInfo const&, (anonymous
>>> namespace)::SourcePrinter*, llvm::StringRef,
>>> std::vector<llvm::object::RelocationRef,
>>> std::allocator<llvm::object::RelocationRef> >*, (anonymous
>>> namespace)::LiveVariablePrinter&)
>>> (/usr/local/bin/llvm-objdump+0x432351)
>>>
>>>    #7 0x00000000004400b8 disassembleObject(llvm::Target const*,
>>> llvm::object::ObjectFile const*, llvm::MCContext&,
>>> llvm::MCDisassembler*, llvm::MCDisassembler*, llvm::MCInstrAnalysis
>>> const*, llvm::MCInstPrinter*, llvm::MCSubtargetInfo const*,
>>> llvm::MCSubtargetInfo const*, (anonymous namespace)::PrettyPrinter&,
>>> (anonymous namespace)::SourcePrinter&, bool)
>>> (/usr/local/bin/llvm-objdump+0x4400b8)
>>>
>>>    #8 0x000000000044444e disassembleObject(llvm::object::ObjectFile
>>> const*, bool) (/usr/local/bin/llvm-objdump+0x44444e)
>>>
>>>    #9 0x00000000004454e2 dumpObject(llvm::object::ObjectFile*,
>>> llvm::object::Archive const*, llvm::object::Archive::Child const*)
>>> (/usr/local/bin/llvm-objdump+0x4454e2)
>>>
>>> #10 0x0000000000409910 main (/usr/local/bin/llvm-objdump+0x409910)
>>>
>>> #11 0x00007f9f3854c493 __libc_start_main (/lib64/libc.so.6+0x23493)
>>>
>>> #12 0x000000000042384e _start (/usr/local/bin/llvm-objdump+0x42384e)
>>>
>>> Segmentation fault (core dumped)
>>>
>>> I compiled and installed llvm and clang 12.0.1 myself
>>>
