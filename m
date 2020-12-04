Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056772CF368
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 18:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgLDR4C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 12:56:02 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:23306 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726021AbgLDR4C (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Dec 2020 12:56:02 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B4HtGKD022134;
        Fri, 4 Dec 2020 09:55:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=EQlmr17VCkk9C5ACrxOR40wHQC7aicKqpo8GFGyINLc=;
 b=nqlV7YDqWqAzbAuVdmciVvF8JV/bc/LUxuoPdPTrx5OgwuzLqFd02Rpwm+Y80rs15iVQ
 ZthOxerVmo8PHkkAohyCJrr7e0xyg9S2XdixEi5PDWWTr/Q4TC9gmKJAuOmIs4dugaji
 kqK+RPUVhhhOqF8GI8/pat4CxFue5IHD+Cg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 356xfr2xnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Dec 2020 09:55:18 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 4 Dec 2020 09:54:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPEFPi8ermjxoyjjg6vYwAq1ak+di9e7UtAYnMVGlJCu3D0zWOu0Dvcz5jGwl/0HKIT44oJIWJyDjMzHkIuJL8SapeQLQdgj4qQijZAuVbFDq4oo8LM04t3grzZM7zqImWZ5JAs9pkkmihqWTwc/NSvNbJtCYgeTTRBkS5l9zpFr1HAntJHSiU7Um3OinnrDUv2nT3Uig8OXxlxt7OeKvd2na1dJ9mwE5chPdaC83iP8dWkwz94080a+2qv7eH6aw08Wx2rMYU8W7vuNtF5YJ1pQzKx+Ti59y4vJTbqwqNT4Qp60I2PMx7efHARcWNGQ8VMSYj4lKuMw44kCOHShZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQlmr17VCkk9C5ACrxOR40wHQC7aicKqpo8GFGyINLc=;
 b=BkbcpKWoc2Ggo9h4X4o8yweT3bOz6az53XLN78PcH293NUopSlIeDRlxP2ezAB5AjOrkLNVvUCkQEyQlFV6/62BOlpa69iEfXAUlyB22LSL/9yCb9mUEKARaAz0BWbnhm+kbZpE21PQ8JPxcWtvL/7JiDuh8uJckkgR605BvTeiVHh2RPvDfrQNByXAK+ZW7P1N7YTQ6IEz68rG+xwgbRiwWwkMu4s/o1AqLj4OG6MG3irHV3k+0Dx8hmV4WLJDqlIt66/xTIXv3Elcn0zPHulGirpqOf5cWSNx9BZjzgdJwOw6CqDgqGiGcyJpcjfPpGZit7uuoNz0IGnJjE3MWiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQlmr17VCkk9C5ACrxOR40wHQC7aicKqpo8GFGyINLc=;
 b=eoOaxI0eV7Sbi6JR1l3fzC1eG3pCIXHcG9WkEhxBtxvmLcO304ZsEf/qFXq30yw9KoHQYS1OlbPIEKwKmbkJx0eUKT4jv7+JSOtc28ekXybVyNYagf3vvmx1JUvNkwN4uwHwzCU4lbtKnitm96awkRRy9cg2hY3gSf5pwVMBoK4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2325.namprd15.prod.outlook.com (2603:10b6:a02:85::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Fri, 4 Dec
 2020 17:54:35 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3632.021; Fri, 4 Dec 2020
 17:54:35 +0000
Subject: Re: Latest libbpf fails to load programs compiled with old LLVM
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     <bpf@vger.kernel.org>
References: <87lfeebwpu.fsf@toke.dk>
 <10679e62-50a2-4c01-31d2-cb79c01e4cbf@fb.com> <87r1o59aoc.fsf@toke.dk>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <6801fcdb-932e-c185-22db-89987099b553@fb.com>
Date:   Fri, 4 Dec 2020 09:54:33 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <87r1o59aoc.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:fab1]
X-ClientProxiedBy: MWHPR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:300:117::25) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::12b3] (2620:10d:c090:400::5:fab1) by MWHPR03CA0015.namprd03.prod.outlook.com (2603:10b6:300:117::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 17:54:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f09fea9e-cd64-4fcf-992e-08d8987da98d
X-MS-TrafficTypeDiagnostic: BYAPR15MB2325:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2325223974DDF70B059E3C11D3F10@BYAPR15MB2325.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mB9b3fqi/ZRU19RsX/iw+6/gW35wP11hyuz0tZnouQ5bDRZpiOBBrsadPqPLs85EJSKZIRdzICUYV3Pjm8F9SINycfoePcaeAiS7XYXtfllB7ExuxFUEhZaFF4otgWFLie+XfnsOoYcOpi/pwyNicoKmU5EpUY3wsvPAj8I6duUY8HY9UPLdKPPZ5oUHq6wH6PRHzSWSJcMfc8NBlY4FgRAtGVNYnhjVCRkmk3xP4ObP8ptz+xNLAAeo24CONqx3+yej68MpHiYVcJASpf9c3TP3EaU6wsr4BhvW9fVfeG1Ljn6TPY8tALVro2jHRfaNparw0SJqR0dzxmqAJxca63H7rmuiYgncVT7Pi87uT8g3bFpd9PzJxt1GlDiHWNp4Xv8QFI+cHgvAdzBEYn/HXZz2R73yoGFTSTEDfW283oXutFC9GNThTvI8q6emxfWP0YpeSzDvAOS/clJIfd+XMkin88z1+CHpnvSjnm4xvnI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(39860400002)(396003)(346002)(478600001)(5660300002)(966005)(4326008)(316002)(2616005)(83380400001)(66574015)(110136005)(53546011)(16526019)(66946007)(186003)(66556008)(6486002)(52116002)(8936002)(36756003)(8676002)(31696002)(31686004)(2906002)(66476007)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VTF1YkN6VUxydEd1c0pxZ1JoOXI0VURtR1hEVG5QQTBQemwvdlFFSkVkUWt0?=
 =?utf-8?B?bXZzNUZXUTBLb1hEcGx2dkJCaTlUM3dUMnY5L0pRTzRCQzZRNHB6L2pTSUF1?=
 =?utf-8?B?VjQzNG5RNDkyTlNoa2szZW1rY28rSk5IejhRL2JUbUZpNWd3ck13NVROM0lN?=
 =?utf-8?B?UGRadkpVSWN5RXBiSS9yWVd1WjRYd0l4bU05YW01YjNONzBEWG1nWjM5ZTVP?=
 =?utf-8?B?bWpVbEU3UHdMVmZtOHVteEhJUHhhMFh0MTZJc0xxWm5CSTVjK0R3emRsakQx?=
 =?utf-8?B?U1RMR3NndWFobjZiY1A5SFUzWU8vVVEvSEVTSUttQzhFZTRUSnhpbTdDV3NV?=
 =?utf-8?B?SXMrZXBuTGlEeHhYcnRuUURQWWx4K09zbE1UNGlnQ2QrUkw1dm41TmFUZUV5?=
 =?utf-8?B?TEFEUTF3SGNjM1Izak1HbnhIaWdoNTRJMzJFNVVmZnNRTit6dk5iQmZWTitJ?=
 =?utf-8?B?cHcyeWFmREtpWnlyZG9wSmhCVC9yeVd2b2hHbkFTTGpkYktGYmsxaGNIRzZn?=
 =?utf-8?B?c29pcUJBMSs3TXBOdWZIOGJZYXIzUHFocGxtc0tJTzNWZFBNTEhTL0lqTUtZ?=
 =?utf-8?B?bnVIQUUwWmVVU2pHNnB2czJZd2NQRzg4aWxDL0M2cUsrSUpLelRoVDdCSjVP?=
 =?utf-8?B?bklxU0lQNTc3M0E5TlhNcGxaZ05MTkdvc1B5dXFZMW1yVld0Mlc2UFU4Ylpi?=
 =?utf-8?B?M0t3QzJyOVptSTVJL1BRaGdNcE1nSk1kYlVNYmF1SnNrZi9Pc3VyYm5hTEFE?=
 =?utf-8?B?bldzUThRWnc1OHpzYkZzTmtlZmx0VU01Und3Y1JPQmpnWWcyQ0FURmFOWGpk?=
 =?utf-8?B?STVNK3FYbFJZQXl1ZWEzdjdQYlg3aDNJNGlTRjd1Uk5qWW1RdVN6NXZkMHBR?=
 =?utf-8?B?T3dXRFZzblBYQnpoZ2VyVHhyMjJ1Qlg0anYxVVArRElBY3ZaaHRqSlltYmVK?=
 =?utf-8?B?VVFxMndTRWFRcloxeXRlWENRaTBITU9GeGNrbjg0UHRNamJZL1R6dEJ2M3cy?=
 =?utf-8?B?MFZXaktyVXQyd0dFQWdWQTI1b0R0OFFRRXJ2Mm5mb3Bwcms1aGJzN0s2SEYy?=
 =?utf-8?B?emxNalNzVXVOWTN4ODk1TjdIaGgzcmpYUGUyN2ZhQ01YRXI3dTF1d05lclJr?=
 =?utf-8?B?anRMWGxPd210MjQ2Zks2dElQNXlLVS9oNFl0OFFGeDVpcEZJZEpiL0hsb29X?=
 =?utf-8?B?Vzl5WFlyMjhDWnlySkhxWDdqRnM3dmhmMHRlaE1WVzA2RitHa0tYV2pjUmtS?=
 =?utf-8?B?S0ZFajV1bmlaWWlGSWhiUFliaVhTcWJCRjdwaGowR2pyRjdWbW9hQ0pKQmZT?=
 =?utf-8?B?V0ZzWFJNWGFva0oyMHpzZklpVDY2Vy9uSkIrUS9UcVVWSmlocnhnMVMvQ0NX?=
 =?utf-8?B?WlZMcGJ4WU4wV1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f09fea9e-cd64-4fcf-992e-08d8987da98d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 17:54:35.7247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vV2tgH7voNkexRZj1VtmKqJrVLXNgmP8yC4doQyazyucmm4eIDSD4wYY+25g+FgA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2325
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_07:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040103
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/4/20 1:34 AM, Toke Høiland-Jørgensen wrote:
> Yonghong Song <yhs@fb.com> writes:
> 
>> On 12/3/20 9:55 AM, Toke Høiland-Jørgensen wrote:
>>> Hi Andrii
>>>
>>> I noticed that recent libbpf versions fail to load BPF files compiled
>>> with old versions of LLVM. E.g., if I compile xdp-tools with LLVM 7 I
>>> get:
>>>
>>> $ sudo ./xdp-loader load testns ../lib/testing/xdp_drop.o -vv
>>> Loading 1 files on interface 'testns'.
>>> libbpf: loading ../lib/testing/xdp_drop.o
>>> libbpf: elf: section(3) prog, size 16, link 0, flags 6, type=1
>>> libbpf: sec 'prog': failed to find program symbol at offset 0
>>> Couldn't open file '../lib/testing/xdp_drop.o': BPF object format invalid
>>>
>>> The 'failed to find program symbol' error seems to have been introduced
>>> with commit c112239272c6 ("libbpf: Parse multi-function sections into
>>> multiple BPF programs").
>>>
>>> Looking at the object file in question, indeed it seems to not have any
>>> function symbols defined:
>>>
>>> $  llvm-objdump --syms ../lib/testing/xdp_drop.o
>>>
>>> ../lib/testing/xdp_drop.o:	file format elf64-bpf
>>>
>>> SYMBOL TABLE:
>>> 0000000000000000 l       .debug_str	0000000000000000
>>> 0000000000000037 l       .debug_str	0000000000000000
>>> 0000000000000042 l       .debug_str	0000000000000000
>>> 0000000000000068 l       .debug_str	0000000000000000
>>> 0000000000000071 l       .debug_str	0000000000000000
>>> 0000000000000076 l       .debug_str	0000000000000000
>>> 000000000000008a l       .debug_str	0000000000000000
>>> 0000000000000097 l       .debug_str	0000000000000000
>>> 00000000000000a3 l       .debug_str	0000000000000000
>>> 00000000000000ac l       .debug_str	0000000000000000
>>> 00000000000000b5 l       .debug_str	0000000000000000
>>> 00000000000000bc l       .debug_str	0000000000000000
>>> 00000000000000c9 l       .debug_str	0000000000000000
>>> 00000000000000d4 l       .debug_str	0000000000000000
>>> 00000000000000dd l       .debug_str	0000000000000000
>>> 00000000000000e1 l       .debug_str	0000000000000000
>>> 00000000000000e5 l       .debug_str	0000000000000000
>>> 00000000000000ea l       .debug_str	0000000000000000
>>> 00000000000000f0 l       .debug_str	0000000000000000
>>> 00000000000000f9 l       .debug_str	0000000000000000
>>> 0000000000000103 l       .debug_str	0000000000000000
>>> 0000000000000113 l       .debug_str	0000000000000000
>>> 0000000000000122 l       .debug_str	0000000000000000
>>> 0000000000000131 l       .debug_str	0000000000000000
>>> 0000000000000000 l    d  prog	0000000000000000 prog
>>> 0000000000000000 l    d  .debug_abbrev	0000000000000000 .debug_abbrev
>>> 0000000000000000 l    d  .debug_info	0000000000000000 .debug_info
>>> 0000000000000000 l    d  .debug_frame	0000000000000000 .debug_frame
>>> 0000000000000000 l    d  .debug_line	0000000000000000 .debug_line
>>> 0000000000000000 g       license	0000000000000000 _license
>>> 0000000000000000 g       prog	0000000000000000 xdp_drop
>>>
>>>
>>> I assume this is because old LLVM versions simply don't emit that symbol
>>> information?

Thanks for the below instruction and xdp_drop.c file. I can reproduce 
the issue now.

I added another function 'xdp_drop1' in the same thing. Below is the
symbol table with llvm7 vs. llvm12.

-bash-4.4$ llvm-readelf -symbols xdp-7.o | grep xdp_drop
     32: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT     3 xdp_drop
     33: 0000000000000010     0 NOTYPE  GLOBAL DEFAULT     3 xdp_drop1

   [ 3] prog              PROGBITS        0000000000000000 000040 000020 
00  AX  0   0  8

-bash-4.4$ llvm-readelf -symbols xdp-12.o | grep xdp_drop
     32: 0000000000000000    16 FUNC    GLOBAL DEFAULT     3 xdp_drop
     33: 0000000000000010    16 FUNC    GLOBAL DEFAULT     3 xdp_drop1
-bash-4.4$

   [ 3] prog              PROGBITS        0000000000000000 000040 000020 
00  AX  0   0  8


Yes, llvm7 does not encode type and size for FUNC's. I guess libbpf can
change to recognize NOTYPE and use the symbol value (representing the 
offset from the start of the section) and section size to
calculate the individual function size. This is more complicated than
elf file providing FUNC type and symbol size directly.

Maybe in this case, libbpf can do some sanity check. If there are more
than one functions in the 'prog' section and they are not marked at FUNC
type, simply recommend newer compiler and bail out saying this feature
not available with old llvm?

>>
>> Could you share xdp_drop.c or other test which I can compile and check
>> to understand the issue?
> 
> It's just an empty program returning XDP_DROP:
> 
> https://github.com/xdp-project/xdp-tools/blob/master/lib/testing/xdp_drop.c
> 
> I basically just did this on Debian buster:
> 
> $ sudo apt install gcc-multilib build-essential libpcap-dev libelf-dev git llc lld clang gcc-multilib pkt-config m4
> $ git clone --recurse-submodules https://github.com/xdp-project/xdp-tools
> $ cd xdp-tools
> $ LLC=llc-7 ./configure
> $ make -k
> $ cd xdp-loader
> $ sudo ip link add dev testns type veth
> $ sudo ./xdp-loader load testns ../lib/testing/xdp_drop.o -vv
> 
> (xdpdump will fail to build with llvm7, but the rest should work)
> 
> -Toke
> 
