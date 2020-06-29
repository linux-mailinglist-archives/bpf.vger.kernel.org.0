Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4816B20E09E
	for <lists+bpf@lfdr.de>; Mon, 29 Jun 2020 23:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732965AbgF2UsA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Jun 2020 16:48:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56184 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389827AbgF2Ur6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 29 Jun 2020 16:47:58 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05TKkal4016227;
        Mon, 29 Jun 2020 13:47:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=YleJ/KEVEj4GD71k2itn4/1hi0qVGOfWZsbFp+TqtfQ=;
 b=DdXto1MiLKY6Ft8oWAi621BHeLV3UU+i2qTGgsXHk/s3vKy+ar+/2aikSs/A6EjHYsLD
 sqpvAwMA/vfz94781hRf3wRID8PNd9b+rAtnHPHP/harULjVKZELcgg//comM8n/hNE5
 M2RWtzRLMfW2/zpWjNfri1DhUQBF+sn/9yk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31xpcnpdpn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Jun 2020 13:47:55 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 29 Jun 2020 13:47:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCTCH1FOgNh8Mg93vJUT9s+RKk7Y8gt8/uO62ZyOrfrkRd8HzHKxXP0n9voghQEpG6xftlSxjInTixbEy227oTCpdh4j+tl8IM3mu1Mn4ztWAMpUACrHO3DesYR3shUgahv5MeyHaMvCZZwXkQ/jL59zGK/PeP676w+Q1r2NmGzZP9PLjoUJHYsaQop3u3K4TqNRb1efLd4dEyfg+RWR7eH0h4xBMBFDO44JNirt1JQWIcX9UwiqoTF9ncwGmLXmxsW5qmll+Df3EWLaZ3J/BaAf6nXGoKLW4R911bB63G9SBuRipCWHlG167wCBCv8ALDKYwpaphj+vVBHafVHGIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YleJ/KEVEj4GD71k2itn4/1hi0qVGOfWZsbFp+TqtfQ=;
 b=nQFYc28oyDkZJzadVZRjvpaZ7Qq7ISDBUQ0Dw6OZCln5hRmCDdds2IPIezqWkaVcAvsxmvUmSEDYcWTcEtTEFf5mQu2RnsrM+zq99aF2qGnmkWAiPaVhj6UDHIuwWnPSJ/O6r0fap/MagXIYvo6ySZ0GOAyl+6+W8oZ4yn0hyMuzDocFUUjTXeKCqWk6R9jsqCJKO8F61bnSyMXi5YQE3U/9Mdqx+S6WwNlsGM8lgViwLC76lDtnNXM/FOyr1l5NRft2X2kNxwZv3z4mnGEHs+uzlxCSLIHYwayJNq62PO7ePqO2vy4SmMRV1PqTdZglrNkVpzsJEh/h9HPJjvvdDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YleJ/KEVEj4GD71k2itn4/1hi0qVGOfWZsbFp+TqtfQ=;
 b=AagIX580qP++BC+M0xVOh91KcdfH0pBXiov4ifiQA7uGGBX8wfwjJ833P7WiEXXiaxpZc+5dpFwOn1YmNN726m2DDfwuOQKlIbtww8xw+CC4kSeh2vbvlIz8UjZd4nl05eiC4gENRzMxkMeNJu4slDSaCgLR40JrVvERerST2r4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3365.namprd15.prod.outlook.com (2603:10b6:a03:111::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Mon, 29 Jun
 2020 20:47:39 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 20:47:39 +0000
Subject: Re: tp_btf: if (!struct->pointer_member) always actually false
 although pointer_member == NULL
To:     Wenbo Zhang <ethercflow@gmail.com>, bpf <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: <CABtjQmYObfTxZ_mZdhDBw_mmShJMofR3VeCH+GgATLrWD1x9+g@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <79dbb7c0-449d-83eb-5f4f-7af0cc269168@fb.com>
Date:   Mon, 29 Jun 2020 13:47:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <CABtjQmYObfTxZ_mZdhDBw_mmShJMofR3VeCH+GgATLrWD1x9+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:a03:100::15) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::17d3] (2620:10d:c090:400::5:40c) by BYAPR08CA0002.namprd08.prod.outlook.com (2603:10b6:a03:100::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Mon, 29 Jun 2020 20:47:38 +0000
X-Originating-IP: [2620:10d:c090:400::5:40c]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45b2a13b-6cf1-46e6-9f6f-08d81c6da941
X-MS-TrafficTypeDiagnostic: BYAPR15MB3365:
X-Microsoft-Antispam-PRVS: <BYAPR15MB336545FA84AB5917D7658E7BD36E0@BYAPR15MB3365.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FWctzPHj/TtnC2w4A1mzf5W/yTHGmD37IQjfyJIKQ0puGIgXe11txcgHUXiNS51OwQJouk/tJ7ac099f+SR/DBr0hVrtARapczo3y5I9HcOZf9ArbJ+6zhjtsV34CgQRsxsBI9IoGo+LFau2O7aE5lkwalxDIBwgeGJVdAuOFb6cLqZ6SBNUZ3ZJzSNa+7ErjhZRWKGGnCel5FfrC6hR4rGqNOaOT2cNFEXxYGCeHw+usR83sMcY9+wPwFp28g8l37ceiUrQ4kF0B96+YsLPeU6kT1wNIxDflTPdTGOWnvx/SbYdbDOsiU9bUgLpyZTh3PcUojEJU3G1PmYueiDoh4eFkpkla95HcTM1cm+2ehw7MjoANV6XhI5RDBuPhv5aFBtOYOdMroYqD532NfUIbBMOizYjJAHfACHZw4V7Gy0hwWSNm2Foh3ytOfTP7d/gXTP7n9n4ch77I1VTDlqTuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(376002)(366004)(136003)(396003)(31686004)(4326008)(16526019)(186003)(52116002)(31696002)(86362001)(5660300002)(8676002)(110136005)(66946007)(66556008)(66476007)(8936002)(53546011)(478600001)(2616005)(36756003)(83380400001)(2906002)(316002)(6486002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: AbH1qcmYnBFLGXjh0/Sv2ycLqhFxPgWdbW/L8c582m2a46hgcKsNv/8fx7HUcZqtSFrS+NFdGPpEh/14rGFvPyej8S4Mz01f2kCvooWCD/wlsEJl7/V8bnTWRpIYDSZfBD9sbZWPUQ3ghH0XSxu4j/vv0LO37jYWL+Aj/THsBJHGdRsuKP6NNoV+JPg17FkwpMebR88ZBdFMzii/Uxlzv2QNQbRR2sKCwp+spZTekMBAS7kumE4SpDva7ePt7Aq2AYPklgotqjMsNCV0WJPtDkh0aHISMjlgMPn7ubpvsaT2h5b54/e/xf63qCOAZRtB2oWIUF0A/3tNqhhi78EN+bFL/oJsu9rxhA3F13Q5usK1PXoeofX/0pgxLguLpcKkH8GkKEtMBRO+NPHsbjoz6cCK8K3Y1k/hmcr/7LV188UwbZrmDOKejQ64pr86aYSOzNOBzvKYg9r7dsAOoYjSShsFT4GmnHVvwXJqLOA8k3tFKBNBkJHcfG5xUuDP4P5xrObP2A97V5lwZzKBeWnq6w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b2a13b-6cf1-46e6-9f6f-08d81c6da941
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 20:47:39.0417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrT4PKTkf4fiEa4eKaWhqmE/cBPzB6w9AkzvTo5xdfZp/zerHAovHBL9PbWQ3SCN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3365
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-29_21:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0
 impostorscore=0 bulkscore=0 cotscore=-2147483648 suspectscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006290132
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/28/20 10:25 PM, Wenbo Zhang wrote:
> I found in tp_btf program, direct access struct's pointer member's
> behaviour isn't consistent with
> BPF_CORE_READ. for example:
> 
> SEC("tp_btf/block_rq_issue")
> int BPF_PROG(tp_btf__block_rq_issue, struct request_queue *q,
>      struct request *rq)
> {
>          /* After echo none > /sys/block/$dev/queue/scheduler,
>           * the $dev's q->elevator will be set to NULL.
>           */
>          if (!q->elevator)
>                  bpf_printk("direct access: noop\n");
>          if (!BPF_CORE_READ(q, elevator))
>                  bpf_printk("FROM CORE READ: noop\n");
>          return 0;
> }
> 
> Although its value is NULL, from trace_pipe I can only see
> 
>> FROM CORE READ: noop
> 
> So it seems  `if (!q->elevator)` always return false.

Thanks for reporting.
The assembly code looks correct. So this mostly related to kernel.
Will take a further look.

For the llvm crash below, it should have been fixed in last llvm trunk.
Please give a try. Thanks!

> 
> I tested it with kernel 5.7.0-rc7+ and 5.8.0-rc1+, both have this problem.
> clang version: clang version 10.0.0-4ubuntu1~18.04.1
> 
> Reproduce step:
> 1. Run this bpf prog;
> 2. Run `cat /sys/kernel/debug/tracing/trace_pipe` in other window;
> 3. Run `echo none > /sys/block/sdc/queue/scheduler`;  # please replace
> sdc to your device;
> 4. Run `dd if=/dev/zero of=/dev/sdc  bs=1MiB count=200 oflag=direct`;
> 
> 
> The output of  `llvm-objdump-10 -D bio.bpf.o` is:
> 
> 
> bio.bpf.o:      file format ELF64-BPF
> 
> 
> Disassembly of section tp_btf/block_rq_issue:
> 
> 0000000000000000 tp_btf__block_rq_issue:
>         0:       b7 02 00 00 08 00 00 00 r2 = 8
>         1:       79 11 00 00 00 00 00 00 r1 = *(u64 *)(r1 + 0)
>         2:       bf 16 00 00 00 00 00 00 r6 = r1
>         3:       0f 26 00 00 00 00 00 00 r6 += r2
>         4:       79 11 08 00 00 00 00 00 r1 = *(u64 *)(r1 + 8)
>         5:       55 01 0e 00 00 00 00 00 if r1 != 0 goto +14 <LBB0_2>
>         6:       b7 01 00 00 00 00 00 00 r1 = 0
>         7:       73 1a fc ff 00 00 00 00 *(u8 *)(r10 - 4) = r1
>         8:       b7 01 00 00 6f 6f 70 0a r1 = 175140719
>         9:       63 1a f8 ff 00 00 00 00 *(u32 *)(r10 - 8) = r1
>        10:       18 01 00 00 63 63 65 73 00 00 00 00 73 3a 20 6e r1 =
> 7935406810958488419 ll
>        12:       7b 1a f0 ff 00 00 00 00 *(u64 *)(r10 - 16) = r1
>        13:       18 01 00 00 64 69 72 65 00 00 00 00 63 74 20 61 r1 =
> 6998721791186332004 ll
>        15:       7b 1a e8 ff 00 00 00 00 *(u64 *)(r10 - 24) = r1
>        16:       bf a1 00 00 00 00 00 00 r1 = r10
>        17:       07 01 00 00 e8 ff ff ff r1 += -24
>        18:       b7 02 00 00 15 00 00 00 r2 = 21
>        19:       85 00 00 00 06 00 00 00 call 6
> 
> 00000000000000a0 LBB0_2:
>        20:       bf a1 00 00 00 00 00 00 r1 = r10
>        21:       07 01 00 00 e8 ff ff ff r1 += -24
>        22:       b7 02 00 00 08 00 00 00 r2 = 8
>        23:       bf 63 00 00 00 00 00 00 r3 = r6
>        24:       85 00 00 00 04 00 00 00 call 4
>        25:       79 a1 e8 ff 00 00 00 00 r1 = *(u64 *)(r10 - 24)
>        26:       55 01 0e 00 00 00 00 00 if r1 != 0 goto +14 <LBB0_4>
>        27:       b7 01 00 00 0a 00 00 00 r1 = 10
>        28:       6b 1a fc ff 00 00 00 00 *(u16 *)(r10 - 4) = r1
>        29:       b7 01 00 00 6e 6f 6f 70 r1 = 1886351214
>        30:       63 1a f8 ff 00 00 00 00 *(u32 *)(r10 - 8) = r1
>        31:       18 01 00 00 45 20 52 45 00 00 00 00 41 44 3a 20 r1 =
> 2322243604989485125 ll
>        33:       7b 1a f0 ff 00 00 00 00 *(u64 *)(r10 - 16) = r1
>        34:       18 01 00 00 46 52 4f 4d 00 00 00 00 20 43 4f 52 r1 =
> 5931033040285291078 ll
>        36:       7b 1a e8 ff 00 00 00 00 *(u64 *)(r10 - 24) = r1
>        37:       bf a1 00 00 00 00 00 00 r1 = r10
>        38:       07 01 00 00 e8 ff ff ff r1 += -24
>        39:       b7 02 00 00 16 00 00 00 r2 = 22
>        40:       85 00 00 00 06 00 00 00 call 6
> 
> 0000000000000148 LBB0_4:
>        41:       b7 00 00 00 00 00 00 00 r0 = 0
>        42:       95 00 00 00 00 00 00 00 exit
> 
> Disassembly of section license:
> 
> 0000000000000000 LICENSE:
>         0:       47      <unknown>
>         0:       50      <unknown>
>         0:       4c      <unknown>
>         0:       00      <unknown>
> 
> Disassembly of section .rodata.str1.1:
> 
> 0000000000000000 .rodata.str1.1:
>         0:       64 69 72 65 63 74 20 61 w9 <<= 1629516899
>         1:       63 63 65 73 73 3a 20 6e *(u32 *)(r3 + 29541) = r6
>         2:       6f 6f 70 0a 00 46 52 4f <unknown>
>         3:       4d 20 43 4f 52 45 20 52 <unknown>
>         4:       45 41 44 3a 20 6e 6f 6f <unknown>
>         5:       70      <unknown>
>         5:       0a      <unknown>
>         5:       00      <unknown>
> 
[...]
>       709:       69 5f 72 65 6d 61 69 6e <unknown>
>       710:       69 6e 67 00 62 69 5f 69 <unknown>
>       711:       74 65 72 00 62 69 5f 65 w5 >>= 1700751714
>       712:       6e 64 5f 69 6f 00 62 69 if
> 
> 
> BTW, the llvm-objdump will core dump after output the above info:
> 
> Stack dump:
> 0. Program arguments: llvm-objdump-10 -D bio.bpf.o
> /usr/lib/x86_64-linux-gnu/libLLVM-10.so.1(_ZN4llvm3sys15PrintStackTraceERNS_11raw_ostreamE+0x1f)[0x7f7636d5dc3f]
> /usr/lib/x86_64-linux-gnu/libLLVM-10.so.1(_ZN4llvm3sys17RunSignalHandlersEv+0x50)[0x7f7636d5bf00]
> /usr/lib/x86_64-linux-gnu/libLLVM-10.so.1(+0x978205)[0x7f7636d5e205]
> /lib/x86_64-linux-gnu/libpthread.so.0(+0x12890)[0x7f76361d9890]
> /usr/lib/x86_64-linux-gnu/libLLVM-10.so.1(+0x21bbed3)[0x7f76385a1ed3]
> /usr/lib/x86_64-linux-gnu/libLLVM-10.so.1(+0x21baefb)[0x7f76385a0efb]
> /usr/lib/x86_64-linux-gnu/libLLVM-10.so.1(+0x21bc0ce)[0x7f76385a20ce]
> llvm-objdump-10[0x41b78c]
> llvm-objdump-10[0x425278]
> llvm-objdump-10[0x41f502]
> llvm-objdump-10[0x41a473]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe7)[0x7f763546db97]
> llvm-objdump-10[0x41542a]
> [1]    21636 segmentation fault (core dumped)
> 
> llvm-objdump-10 --version
> LLVM (https://urldefense.proofpoint.com/v2/url?u=http-3A__llvm.org_&d=DwIBaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=DA8e1B5r073vIqRrFz7MRA&m=zs4_mz-CGExwverPej7QEcaeDzsjcZfkD_GiyMQDJbE&s=1inYTci4noQ6dJN-mUYTlvU7OrTX3C7h-0Kn39reX-Y&e= ):
>    LLVM version 10.0.0
> 
>    Optimized build.
>    Default target: x86_64-pc-linux-gnu
>    Host CPU: broadwell
> 
>    Registered Targets:
>      aarch64    - AArch64 (little endian)
>      aarch64_32 - AArch64 (little endian ILP32)
[...]
