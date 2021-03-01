Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F6E3276AD
	for <lists+bpf@lfdr.de>; Mon,  1 Mar 2021 05:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhCAE2K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Feb 2021 23:28:10 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:64786 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231549AbhCAE2F (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 28 Feb 2021 23:28:05 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 1214R0Ep018219;
        Sun, 28 Feb 2021 20:27:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=PHskhB8mMTNNUI2TT/TWVuTgQUySaHULo9f5LIF7gfE=;
 b=K3RJD8q5NUihe2pyn9vduA5nJvmYKyT41zA76Ktg4JkhwxkAKxC+LNbV395baihBJ+0j
 cjQMk6wziZB6zOUa8y/wYPTzDhI9EoPwnlDYEZluPu6zC2s2iLFmI7K5nyv6siOMb1e0
 4CuolefutoXK5W8F7tqTQhFLfeOYo9Ygvok= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 36yjmu61t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 28 Feb 2021 20:27:20 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 28 Feb 2021 20:27:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWAzUp4Yyg5aPgsShfpvWsclEm789Nh2GapM9mT13z+KjG3O4pUX6/M8DGD3MrC6Z06eiVuirT43qex+4SgV8bzqea6O17sybrcVPqwreyIMoOY+H8Gs8QfkEKTi2TGAVDRzV0skz2DcL8C8mo3xjxQYRP/lq1rp+rgu6XjMHwDn8XKIM2vUsyofCk0xj7SxcjsWUub2Lx9MhqhIY5+U4xWd3BCdK8rDvs2JdL/XSMq44++05B5XyMk0FM21p2MNc7xVhPRtQdTa4X6NHD0tzEhpoekCS+f3rhtoDRkX+65thk/leA1RAsQ94d2oOuhVEEYHPIVV2rk/XK3wnZgT1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ab6k0Q60X/sEC4NHX0rmsk8OdTZX7wyQk2yw4O02jpE=;
 b=MbqMq35S46V2QAvERaIExfl2avqOAgCgNd4hWeXY3SuPgAoqE5wQOUEvbyRg8gPgpsWcXQgOFkTp7RrNClVk9JRussKTZSYTfM5JIJvcqXyVqYg6+blqEP/c6wYikrYIA5+SUXrarEW9BqPfve8jaL5A7cXPEzaM3xsJFsRv1gcUz1Eoa7WRzWO8Lyc+pC7jqUA1hRkIOUWl1bVgK10z204JaBb8quCZXJif4KMMzXJXn51DjQowQcrohObEJy7blESjgzYQCECQkYH9nx1vQ5cXre5hGwvnbMqGWPrg3IoUbh+AIGJ3HQ3SW/UNc36niQ2MQe7/AQwK3ioYzjXadQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3933.namprd15.prod.outlook.com (2603:10b6:806:83::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 1 Mar
 2021 04:27:17 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 04:27:17 +0000
Subject: Re: clang crash for target BPF
To:     Andrei Matei <andreimatei1@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
References: <CABWLset0aqju=tkCVQJ3p8QyVwFUi21HkfxBS3rK7qC5oScyWw@mail.gmail.com>
 <747ea282-d158-f65f-65ac-c13dac694974@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <cc9defee-dcd8-5b06-7396-213599651752@fb.com>
Date:   Sun, 28 Feb 2021 20:27:15 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <747ea282-d158-f65f-65ac-c13dac694974@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:34a0]
X-ClientProxiedBy: MWHPR20CA0043.namprd20.prod.outlook.com
 (2603:10b6:300:ed::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::1008] (2620:10d:c090:400::5:34a0) by MWHPR20CA0043.namprd20.prod.outlook.com (2603:10b6:300:ed::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Mon, 1 Mar 2021 04:27:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e2a1606-fd83-49a4-cfe2-08d8dc6a4c2d
X-MS-TrafficTypeDiagnostic: SA0PR15MB3933:
X-MS-Exchange-MinimumUrlDomainAge: llvm.org#6197
X-Microsoft-Antispam-PRVS: <SA0PR15MB39336E56141CC14AAFE9966FD39A9@SA0PR15MB3933.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZM3NkPoCJv+Xk0Bos89sj/tEFRQ1uU2ANWt81Bk7kUvt1XjL/ic7BuEogldr5iN7oMjARhgXMfpq/JhYGTez976EDNojeqWhvskrUkdCpRtUd7smpNhvOWFyp8b3yuXlnCtDjx1eyd1wUnqGEr4+g1D3XyyTnjhH+SZRsJW58VLIbJho5Ugmyli4xXwIarHVBIc0oiMt+zsTcgZHRCDVDQ6qm8eM1kkoCLq63GdE8vJCiYzFFFNS+e/yUsd5UvY2pzGTgB3ce7LgO9n5gLgAzRvwe8hAirDuRFFZM6lqNlqXi1gob10Qxx/Jm+aFkAu1s6eFF/FW5JVKniKp9k5h8yzo/YVyoqGu7gIyDwqQauWnEI9eEn+Ml3KG1CACI38xEfl8stIsxIp8hCgVrzV0myJjl6Ob0djcRg4adGt/pZZeCi8cw7isBDE9qjK6zL0VY1v/FtjiDbAniCye0+zoqzwEmMEqYQtvSFbZ9rs+y52vXL06jQQ+1D4431lB4BcjP8Pz5eJ42nxSUlmjUEXe/sy4XeJIwIm9zx2p15e4htb66PilQqQ5xOLgayzVokN9Mo8mPdSFfpAzdT/J5RxZbtSBUETOvWm5EE8PmBco9r53jktxgFgULuasZo4V9JT65Keie/LADAIFXUXaJO/fI+kXjYoPqYFX7mk5SYL0nCg3f3i/uIXRP7RKP54AGbt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(396003)(366004)(39860400002)(16526019)(2616005)(86362001)(53546011)(186003)(478600001)(966005)(6486002)(31696002)(31686004)(36756003)(83380400001)(5660300002)(8936002)(2906002)(8676002)(316002)(66476007)(66556008)(110136005)(52116002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MVgwNzhFZ2xMc09uQUo0WW1DRlhEVTk4cUNNQS84NTNtdWhxWVVjZElDMTZw?=
 =?utf-8?B?R21lWkhxWGc5SDJFV2hEbFcvYzJoaTVjOExSbENoMFdqZHJkQWhReU4vdG5T?=
 =?utf-8?B?MzZhM3hhMHR4YmtBWWhDYVpXZmMxOXNiOWFtWUpTU0sraW5WbVBXQTdvTmdu?=
 =?utf-8?B?Q0tIaE0wdU9nZFVNQkhvd0krbWRRbm5VZ3hONEpZTkh1N1pVbFp1d1JWQmlv?=
 =?utf-8?B?Q0hqZEM0SGZNWFd3bUp2OFpHVG1Eenh1TEtCZ3JHa3ZkakxnSHFPSk5HYzM1?=
 =?utf-8?B?K1RSbVA5aUVHUVVuSTF1bWRxRGJvYkxFQnBoeFRMQWV2SEVDaUZyazFFRjZv?=
 =?utf-8?B?eU9NTFI2NGpMVENGN1RidXY2aXZxVnphelYzeVpxa0ordkw5dTNxZ3phek5j?=
 =?utf-8?B?N1h2NzdFUWh5SS9UZ0I5VEhvTVBvcG43MzF0cG5hZklVMjY0ZUg4aDArVmJI?=
 =?utf-8?B?WWx6WWgzaWdZcWlzeDgzOEF2ZU92Wk0xb2FKbHdHZm4vcUlFT0VOUkJ6NDdD?=
 =?utf-8?B?TGt2SGlpOGpKNElnRXNXZVBkL0hFOVBnaUVWbVY5K2xVMjh3a3FJa2JzSGZH?=
 =?utf-8?B?UXBnZlh1d3lXMEM4OUdzQVM3b2VZTUJFSU92bXo1YzRpUkVUQzM1S3FDOTNN?=
 =?utf-8?B?Nm9BcEQ4dU1HbndaLzBuNmpScitGQ3dPRSt4aEI2bVRxY251a3V2T0hUY3FF?=
 =?utf-8?B?bXJJQzFnQ2hxZTlER2dyVGhvalNWMWNMMHlRaHN5ZmZHQUFIQVFOamxySUJz?=
 =?utf-8?B?Z0tKOGp2bnZLVTI1Ukl1UGFjeDlndERUMDhqQjNnbVUvNUJzYXV1QXE3dlN3?=
 =?utf-8?B?bDRhbDRqYzRUV3IxODhzRlJUOUhFSnpZS3RDSmhhZzFDS0NiMCtSeVBSaWQ5?=
 =?utf-8?B?N1Q0U3NIL0kzMlRwU2VCdDdKTzIxWCtDVGFMNXZZU2NuQ2dQVzJqalRMTlBK?=
 =?utf-8?B?UG9MRW4wb1N1L3VRQUo0QVE1Nm4ydHZDZzBzUENiWDhtOUFmMm84Z0twZS8v?=
 =?utf-8?B?UGp6L0RmMytPNkFvQnRYM0ROL1JhREpHaTNYcHhuVHkxRkNOQk50b29mVnFo?=
 =?utf-8?B?RzFOZ1RIbXpLMUl6ZkNEbHJBbXZnRlZqRUFmQkVMcjZpQ2JsWU85VzBGVlc0?=
 =?utf-8?B?STdkZCtzalFoZUpjeDNwRUVlZDJJSFlkRktMNGdOSDc0Zi81T2d2aThsWml6?=
 =?utf-8?B?UFI0YlBieXh4TmpkaFN1Y0Z2ZmlsbXVmdjFRTUFnU29PdGJjYWR1ZG1NaXhV?=
 =?utf-8?B?T0syMzM3N1JYUnlUVUw5bWUwWDhiOXdtTUNWaXpaUVk5cVoxUUVtUEpZRHhP?=
 =?utf-8?B?Z1hDL3k3TlZiekJNZVkvaTRWbWxLSVhDNE16N3J1M2t4d2FzcG1aRzZzTzdM?=
 =?utf-8?B?ODNXRWF1MW9Cc2U3SFU3NFlLVG9OSjBxY3NmcWJXOEt5bERWZ1hCZ1dVTnN3?=
 =?utf-8?B?UFVBRmV3Um9HcVlQNzlCZTgrSXdaNkI5RmVKZUVnT0ovbXRJY2ZtaDQ0bWNz?=
 =?utf-8?B?WUJ6Q2dCdmlWRmVGMzNZTVNQa2dOOFI3NzNqR2l6UmVrMjZYYVV5b25aa0Ns?=
 =?utf-8?B?SnZaT3FxM1NUV3RVVFhqMkRyNjJXZlNpdThkc1hoTFpibTZpNFFTQ3IzSHFY?=
 =?utf-8?B?V2RqWFdvc25kNVJoR0oxTm5tNmREb3FoMldySkJxcklqNmZkdE16VWtaQ1BP?=
 =?utf-8?B?UmpJM0RLVHlhK3NZR3o3L1Z2SGNOdUE2VzBlY1BOVEhLKzE2aUdjYmVUU0M0?=
 =?utf-8?B?dGMyaUZHeE13VTRTM1YzNkpnbHR0MXplblZMeGtCNURnQVYrd2lkMFl4RGh3?=
 =?utf-8?B?RlVabVNTbGZrMi9tUHBIQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2a1606-fd83-49a4-cfe2-08d8dc6a4c2d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 04:27:17.6909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sL2Gy7LJ/EVoyRfirCqwwKwnANYzVz56GTlc3umjIgSJS/LPUpNAfHUZHzwAznyB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3933
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-01_01:2021-02-26,2021-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010035
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/28/21 2:14 PM, Andrei Matei wrote:
> Hello,
> 
> I've encountered an assertion failure / crash on clang master 
> (5de09ef02e24) as well as the older version 11. Happens for "-target 
> bpf", not otherwise.
> I've reported it to clang but there's been no response so far. Alexei, I 
> believe you've invited me to raise the issue here.
> clang bugzilla: 
> https://bugs.llvm.org/show_bug.cgi?id=48578 
> 
> 
> The repro program and instructions are in the bug report above.
> The assertion failure reads:
> 
> clang: 
> /home/andrei/src/llvm-project/llvm/lib/CodeGen/LiveVariables.cpp:130: 
> void llvm::LiveVariables::HandleVirtRegUse(llvm::Register, 
> llvm::MachineBasicBlock*, llvm::MachineInstr&): Assertion 
> `MRI->getVRegDef(Reg) && "Register use before def!"' failed.
> PLEASE submit a bug report to 
> https://bugs.llvm.org/  
> and include the crash backtrace, preprocessed source, and associated run 
> script.
> Stack dump:
> 0.      Program arguments: bin/clang -O2 -target bpf -c -o probe.bpf.o 
> /home/andrei/Downloads/probe.bpf.preprocessed.c
> 1.      <eof> parser at end of file
> 2.      Code generation
> 3.      Running pass 'Function Pass Manager' on module 
> '/home/andrei/Downloads/probe.bpf.preprocessed.c'.
> 4.      Running pass 'Live Variable Analysis' on function '@probe'

Andrei, Thanks for reporting. I can reproduce with latest llvm trunk.
Will take a look and comment in the above bugzilla report whenever
I find anything. Thanks again!

> 
> 
> Thanks!
> 
