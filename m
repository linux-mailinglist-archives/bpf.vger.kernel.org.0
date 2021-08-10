Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957703E538F
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 08:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhHJGcS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Aug 2021 02:32:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11306 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230095AbhHJGcS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 10 Aug 2021 02:32:18 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17A6SoOs030610;
        Mon, 9 Aug 2021 23:31:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : from : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=T2RwdJnfYPC0GINaa9e5TnfiUXApS7nHQUC3O5K0Vj4=;
 b=gD7TyX7af73hsu8OJK9xHfTYjdVaorF23Oxz0+aVTtVtKcwwRW0EB4OFXWPHXnZRRPVW
 ODQ6LpA3HNsjIxDKYf3KMrARvGSRh4vz5PtcFIPP2dYWu0iwL8ipt0Jb08JpkHKWz3tU
 up3IWX3mWnPmkXw/tMaYvzoYNAmzSaNNm7g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3ab7exc0ux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 Aug 2021 23:31:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 23:31:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzN2pQkg8NgirmTGZBN/0jYrnZyVSpClzGruI+2nCKRitE1tbjlSu9ly9FmOXP+PuAFE5mCWLBVexPuOdxAtHIYUm4WvGSyir6Bjfmc3SivRBbfVfPGRyJJcniJ0olJGZmLyYGPrEq7EdKF3ByDgXE54tyCBhGfjclpqmOCseea9O2tZ+6aBtLeBbf6hYv82SrA6p+GhaR+1Tw14R7TqT5TvKSmwo1s4vRDHGg1Lp3ojouaCC9u8gWVSOhjEMlSBzN3pSo/k9HgN8EvK1+kKlj2gW0sh6iuk03BvO1IERCbgQMr/XMzzVoxhoKYbPbAoBUy05zInswtxSxTEYztp+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2RwdJnfYPC0GINaa9e5TnfiUXApS7nHQUC3O5K0Vj4=;
 b=O6qQ8Nu+fM/OTbGJZl30pU3EoNgycsxZ2yAcPoT9Ya7IVMIsJYGIdOYiYoQFenAIL5CaO61idK/vF4gbBWkbuHVTudlnWwO6E7i2tHF+718C3SxnSTGfAhLs+RWUrk7c5arDFa8XLq7RmEm+kNtlpgKXRfviLnTYtRw/cQJYgiPoNWPgI5DIQ8EPk3fpuuufdzj+8pbaVzX91us7ldzVjxDHxgZc4lSZthfMGgsUBnUwVS354qM8KoebAYFH1ST8jYrgPK+w0VKr/xvLgzi8LtD1vA0mvhSPKzHVJE7A7BfdsHCIOcZwgxT4c3ThUd/tkrOdVM9U0dnVz+Ufby5lzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: lambda.lt; dkim=none (message not signed)
 header.d=none;lambda.lt; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4659.namprd15.prod.outlook.com (2603:10b6:806:19e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Tue, 10 Aug
 2021 06:31:51 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 06:31:51 +0000
Subject: Re: R11 is invalid with LLVM 12 and later
From:   Yonghong Song <yhs@fb.com>
To:     Paul Chaignon <paul@cilium.io>, <bpf@vger.kernel.org>
CC:     Martynas Pumputis <m@lambda.lt>
References: <20210809151202.GB1012999@Mem>
 <a40405b0-3856-9d15-f973-ffae2e853384@fb.com>
Message-ID: <d1054971-0cd5-5698-c895-f412d1b47bb2@fb.com>
Date:   Mon, 9 Aug 2021 23:31:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <a40405b0-3856-9d15-f973-ffae2e853384@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR08CA0050.namprd08.prod.outlook.com
 (2603:10b6:300:c0::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1ad4] (2620:10d:c090:400::5:2983) by MWHPR08CA0050.namprd08.prod.outlook.com (2603:10b6:300:c0::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Tue, 10 Aug 2021 06:31:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51267dd7-3321-41d2-f9a2-08d95bc889e9
X-MS-TrafficTypeDiagnostic: SA1PR15MB4659:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4659F5FBD5378F48D59163D5D3F79@SA1PR15MB4659.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iANFgG3j2M07uBfkciicaIb5/I1UkXDay935cX0+8LZR9Ns8wR4HmuBgaFHjqv5xlYTvWOd4lq+ZdTM5WCGwwtdf1kZC/V+7Nhu4f4mgPPP0MEeedlw7pUacNvzPZ1721blSfBnWSxghEoNsGk27atZKnLp8/1pLSSFXJJYXOfbHfYpkVM8bcHAcn67zR9VJuacovVRQxIfKUYnjsRf5GcDdJ4bLUmBqSzJSh3ZDHB3mi7s/32xOB3pgSaxCqJnTmgeVPl4TsgqrMS3A8SstNx81Cgnp/tNH7ugLmIq9IzEdMAVVfhqMuPf4mnAMs72LyOLbeE7kKA6LTRef7PA7Alwcu9UZoF5+ExIqA6hwxj4dn7Ea/s8ShXEXKo7ZEpMoHAei/HjnedNBLCLdKgDBuwgrGhAW5H/47TxPPqDHpwjJmmNdef8+6HyeGMVMPbAboPGlc4h3jk8vnIqWG4QVLgZs0IFrR+IXIdVAaTRgB1ILVTlOBir5FJ/zoDOA4g2JWzU7pncMfEr1JGZ70bDdTMhCfNmTgL1I7IuWE4tbqNx546xOSuC5fQ70wT5pgraadRUHENqR1Eh4Z255o9HOYFm7BEOq9DbDJHPeMOHXnujwresP8vMVWUqp3jw1ZEIQqJ2NDM7pUvQxco41G5Cc7zQXcl4DiSRuPfFNFNO+vhjECAHDUz/Oer5uHLerD2gPo/nfpEdxTDJKszhpU1ZGE3wRigFIUL1rNoNns7LNFmQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(316002)(31696002)(86362001)(52116002)(508600001)(4326008)(2906002)(31686004)(8936002)(6666004)(83380400001)(53546011)(66556008)(186003)(8676002)(6486002)(36756003)(2616005)(66946007)(66476007)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEcxVXRhQy9saVVSZzJveEtaeXJZTDNQTkQ1a1hBSVlPSVRLcW1kNWsvOGw4?=
 =?utf-8?B?SmZIdDZVcXlleHM1ZlRuNFNINHV1NTZUQlJlNnRrczM4OHBuM2VXVk9GOENv?=
 =?utf-8?B?TjFiMFdTeFc3c1FUcVZTdDJRRVZGZkdabWt1anQzSm1PQTFuQVNCa25Hckpr?=
 =?utf-8?B?QVRIbmxYQXRQcGNRM1ZsUGloclRPTHMyVVhQZGdQSGprYVIzWE1aTUQ0Nnox?=
 =?utf-8?B?QkdFMU1kdk9USzhiajFrbk8zeStKNlRWaTlVd2V4SXJuc2Z3dXRCZE14ZFB1?=
 =?utf-8?B?UW1lTlJhZ255OHh6R2V4WlY0bmdqaGMxYXNEelhrQUVUMWZsNDdIMDZ1cjhY?=
 =?utf-8?B?czhUamRhdEZycmtHbnpQZEhScDIySFFqaXBQRWhvTTYvK1BvS3dyVmtyZE1C?=
 =?utf-8?B?SEZscjRPNW1ielJkcXU4eXVYZXphdk1Jd3JubnloUDJnemgzY1FIem5aQ2x3?=
 =?utf-8?B?SktSZy9sUUxLdnIrOHpqakNrMVY2REJoY1pGeFozK2p6Y1R6ckQxQlBFT29B?=
 =?utf-8?B?WUs5enRFT3VYaWJ5cFh6UmprM25jQUNTLyt1Q3N5VnJHaXhhTGUvMGNPaHFu?=
 =?utf-8?B?OVIyMFFhTXp1MCtjRVlieUs0b0lzKzlQYmVROXMvTUhNV1I5ajFVek5Ib3Ri?=
 =?utf-8?B?bmJKcERiUFpnVmR6cmpxN2Q2ZUNyYlhyMG5abDlYaDQzMXh1ZFZ2V2xPM2VM?=
 =?utf-8?B?b2ZoL284ZVlhUjQrdGxVdkprZFVyMjBqYjRtSFVCNDU1bkc3TDRQTm5scy9r?=
 =?utf-8?B?OHRYNVBvNnNNOGpoUUNoVkFWREJaUFZhTDY1VGtwcVlHL2kzencwR2JqQlJF?=
 =?utf-8?B?QURDQTlLbDdkb3BQZEVLeEtMZDN5ZzRjNVFzZzhOU1liTzVHZ1M4Smp0K2Jp?=
 =?utf-8?B?aE1DYWJkU3ppSEErRWJpeTVza0NYRzlmOVNURzJ5bTkra3pXNnh3bXdPNGZH?=
 =?utf-8?B?TWZYRDc1UFBlaDB0RzU2SjRaajdUdHFhbFh0aVdXRDY1UlAzT1AxOHAvYUNO?=
 =?utf-8?B?dXFHMm0xdzJFNzZXNkZpOU50RzRaY1pIUCtLMTNWREJiR3lLNnc3TkhBS2M0?=
 =?utf-8?B?YlR1U2pvK0pHc1I5Z1VDOXBpRUVLUEgxeDIxbDlDUHdVbFdKVk9PTllyQ09m?=
 =?utf-8?B?Z1hKMERLQ3kraVhEUkRtNTA5REVSNFZ0YkdKYnYvUitDWis0d3FmVHFBQ0Rm?=
 =?utf-8?B?SEtYdzBqdDRmMmFrTG5WOHZtN2hLWVpzUVNhOXltYjZSS2V0SVh2YXpvK2lr?=
 =?utf-8?B?MzMwMW8yUGdPRnhDc0o4UjJmV1FqVjFXZzdHSEltdmdISVFoWFdEaXBlUmI3?=
 =?utf-8?B?TDh6dVBtclZoYlQyNWNIN21tYTQ3elpxeGo1NHFmYW1sR1czcmtjZ3Y1L0I2?=
 =?utf-8?B?dmVVUy9TWnlZcHJnSVFCdHJ3TTVSSm5aREZYM2JKdzZ1TE44Zld1ZXVRNlN5?=
 =?utf-8?B?YTQxL3B2cHhaS2ZrSkcxanh5cGU0QWR6WDZPTkRzTG9ndTloLzBjVi9oYzhu?=
 =?utf-8?B?N1l2dTNXVzVNOHl1RlFwaE1ZcXBNU3R5REJtdGo1dVB1Ny9uZkxtMWRSNDNz?=
 =?utf-8?B?QXZFM2x3OG9YRCtIRUQwVFdhS2FDdUpjeDB4aU1kM3VyVG1WOGpLaHpxbHJp?=
 =?utf-8?B?WFBnRWhHc29LU2R1cHAvT2F1YmFjc2Y3V2dPRWRBWmxQaHRBL0s1V3Z2NE9G?=
 =?utf-8?B?d0NWRDAzNnEzZy8yTlUrblBOam1wSDF0aVpYYzI1VkZjRThxU1BsTVRvNGxn?=
 =?utf-8?B?U3hOdEFXVVIyZU1pb29XQjJ6WHJYMEczZ2J3OFAwMGhJaHhKOUs3bituaXNE?=
 =?utf-8?B?dC8zT2Y2alFmR2N6ekRadz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51267dd7-3321-41d2-f9a2-08d95bc889e9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 06:31:51.6684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3HBw3p8MupikXpg5KlUmNMOwUUWWbY61Nlwphp54HvFDtJmeBDObGfnuSZXrO0pu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4659
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: nd8yR0Vgjy821teW3JFzyrfENEXGagFt
X-Proofpoint-ORIG-GUID: nd8yR0Vgjy821teW3JFzyrfENEXGagFt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_02:2021-08-06,2021-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100041
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/9/21 3:53 PM, Yonghong Song wrote:
> 
> 
> On 8/9/21 8:12 AM, Paul Chaignon wrote:
>> Hello,
>>
>> While trying to use LLVM 12.0.0 in Cilium, we've noticed that it can
>> generate invalid BPF bytecode:
>>
>>      $ clang --version
>>      Ubuntu clang version 
>> 12.0.0-++20210409092622+fa0971b87fb2-1~exp1~20210409193326.73
>>      Target: x86_64-pc-linux-gnu
>>      Thread model: posix
>>      InstalledDir: /usr/bin
>>      $ make -C bpf -j6 KERNEL=419
>>      $ llvm-objdump -D -section=2/20 bpf/bpf_lxc.o | grep -i r11
>>           171:   7b ba 18 ff 00 00 00 00 *(u64 *)(r10 - 232) = r11
>>           436:   79 ab 18 ff 00 00 00 00 r11 = *(u64 *)(r10 - 232)
>>           484:   bf 8b 00 00 00 00 00 00 r11 = r8
>>
>> That bytecode is of course rejected by the verifier:
>>
>>      171: (7b) *(u64 *)(r10 -232) = r11
>>      R11 is invalid
> 
> Thanks for reporting. I can reproduce the problem and will take a look 
> soon.
> 
>>
>> LLVM 12.0.1 and latest LLVM sources (e.g., commit 2b4a1d4b from today)
>> have the same issue. We've bisected it to LLVM commit 552c6c23
>> ("PR44406: Follow behavior of array bound constant folding in more
>> recent versions of GCC."), but that could just be the commit where
>> the regression was exposed in Cilium's case.

The above commit is indeed responsible. With the above commit,
the variable length array compile time evaluation becomes conservative.
For cilium function dsr_reply_icmp4 in nodeport.h
   const __u32 l3_max = MAX_IPOPTLEN + sizeof(*ip4) + orig_dgram;
   __u8 tmp[l3_max];

I didn't try to compile with/without the above commit, the following
is the thesis.

Before the above commit, llvm evaluates the expression
   MAX_IPOPTLEN + sizeof(*ip4) + orig_dgram
and concludes that l3_max is a constant so tmp can be allocated
on stack with fixed size.

With the above commit, llvm becomes conservative to evaluate
the expression at compile time. So above l3_max becomes a
non-constant variable and tmp becomes a variable length
array. Since it becomes a variable length array, the
hidden stack pointer "r11" is used and this caused a problem
in verifier.

To workaround the issue, simply define "tmp" with
    __u8 tmp[68];
But that is not for from user experience. I guess we can do:
   1. for BPF target, let us still do aggressive constant folding
      in compile time in clang, basically restores to pre-commit-552c6c23
      level for BPF programs.
   2. provide an error message if r11 is generated in final code.

Will come back to this thread once I got concrete patches. Thanks!

>>
>> -- 
>> Paul
>>
