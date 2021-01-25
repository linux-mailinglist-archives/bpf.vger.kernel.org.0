Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A9C3021A1
	for <lists+bpf@lfdr.de>; Mon, 25 Jan 2021 06:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbhAYFWy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jan 2021 00:22:54 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63682 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbhAYFWu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Jan 2021 00:22:50 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10P5E1NQ029269;
        Sun, 24 Jan 2021 21:21:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : from : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=0OYG9fzcNBQ4F44IDXZFKNhocOGAZr4Hjin6voDCx7Q=;
 b=G2JzPRxTP6QVRonx82vI7e9R6d5SnVE077wyA8ZLKOcD+bBu6IKb1IoyCHvq/fD0oTeD
 QTT75BJWXq4KvJnnyDxzoQy24dUVP7EK5LrTssGfDI0XM/8amoqcJWR197pgIAVUpNUQ
 W4i2nm+oaWguxaXrmTgmMkVqXyvVpis4H60= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3694qck99m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 24 Jan 2021 21:21:54 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 24 Jan 2021 21:21:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlWHHZ98s3DrHpdx2gke40Bwc1FTvqFMdnnwArE+x/v5+rAcEpmPXVwoI7VZhEVV1kRxd4eumYsa6eKfeQ2ccFx1/Ttl1b4PxG59Vm7ndEtlGh/OB8LoGdc5++3KzcqvntcbCDrzoP2zy7BLrW7NVrAmV57KLAkgUdEqUOCS0IMQw3Mu6FOa4DgoTo+lUhs+5gZJBC5E/VdyH2TUnB9ByGYrFHgLUqRspD83/bVKGtO5avbdiHp/z/5T2uuglXi0KGPBRbfICo2QbuafWzYXCaOaR7GQqfMZOLTHSJjFL6jn50bfS/6ZyEZ/Ky0Kch+QEKWGSvEMc9IsXj1P10daCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7RnNaFjTV7nptztdzpwvRIMdDkpL5VyxySAiyBUrIY=;
 b=J2u8da/gGkOojU/ZNRkhOTeg3Wxg4k2/ysjQU/FQOyXp7LZGQ4mKY58Bng9jh+2OgZruhPRgmAnax8ZBNU3IfMgr2XR7jaBmIYZQY9qksHo1T9KPCrdp1WzCS16FxK2n34oTJKf5SoUau0TSu9po0gVEfUVPIvmNqY7Sq08F0FlTD2XSfT8uRm3JHPhhgVI9BBSNszhzcxLIfksyVrL8bNEFXlmCqLPeqaM0triBHpRvsOUQLWPQKxrQ8ITBsf93Ivz4FFGNcmlvmoRb+LXMmAtzg55n5beliCqWQc+kc+lFiEyQ1umY2UM6JMyUeSAo317pCUkYP0A2rAv/lHTYBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7RnNaFjTV7nptztdzpwvRIMdDkpL5VyxySAiyBUrIY=;
 b=DpOSEz+BzQqRS5wANLIoYGPVKRokBWWXOBXeB8ar9O1J+VkC6YjzKFOlK8ylQUc1DAM9m0N6Y/5O+sWldZkU6mntlltYEb98BefHDoUIUPCR1Vm2WfXwv/dpQCThjkYLM/vNJjVLmfJkPdT4buQcmzK/Gu1+B7Fb+xP3m7z+hrw=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BY5PR15MB3668.namprd15.prod.outlook.com (2603:10b6:a03:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Mon, 25 Jan
 2021 05:21:51 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 05:21:51 +0000
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Helper script for running BPF
 presubmit tests
From:   Yonghong Song <yhs@fb.com>
To:     KP Singh <kpsingh@kernel.org>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
References: <20210123004445.299149-1-kpsingh@kernel.org>
 <20210123004445.299149-2-kpsingh@kernel.org>
 <0d436bbc-7409-2947-7322-f21241df6025@fb.com>
Message-ID: <e539bbeb-a667-6ae1-fe40-ddb30bd7c13d@fb.com>
Date:   Sun, 24 Jan 2021 21:21:48 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <0d436bbc-7409-2947-7322-f21241df6025@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:c1c3]
X-ClientProxiedBy: CO2PR04CA0130.namprd04.prod.outlook.com
 (2603:10b6:104:7::32) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1946] (2620:10d:c090:400::5:c1c3) by CO2PR04CA0130.namprd04.prod.outlook.com (2603:10b6:104:7::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15 via Frontend Transport; Mon, 25 Jan 2021 05:21:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d552a126-7cef-40b7-1d18-08d8c0f11f3d
X-MS-TrafficTypeDiagnostic: BY5PR15MB3668:
X-Microsoft-Antispam-PRVS: <BY5PR15MB3668CAB04B28441BEBCDD9D4D3BD9@BY5PR15MB3668.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:416;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJ03kS8KdSIwwkTv5oGlMRAgHAIC3hxn2hpBaPdcrZIK+0CYknnWuLbFtYMkwutllwlqNm0uNiS8GOKvy+LvomlC/PKOgTOVt35IFucXv1AZ0NldcwScW0cPOAuZhhgQfftD+q00SsABxeqaeZHKttnk8cvcF0R+3DXuw8fsJx6b43Wh5oPzCwUH4w6ZvgjauHPoXR9nvtEJLMR87WW1Juroqtndk/mLAZNbxWHgxugPTkjSOo2Nc6FjtADV1b3HNuHqbvTGpQUjiVtXBB7B6d5x+/51kCbalAeHbKaGcQ4FldFJUAM726eaLZN0iOvbN24+D4dNWJ5JwH5zXeKsXQFdLEp7HDyqqZhLrVhCUpf11ikud4dyuBBjcL8hkCDdl5iCDgFJS0W+Riz4hSwRnFjs30wnyr7MRh7U1McNNJozuI76+5l4IETkK3DNYjA4syCgCu58ZsuEY+sEDqKRUgOGz/N7QcrsDt7vwzBYnEFiUrQ8y1LYWO9hqwGww5kan6Q/Ud3LbemTuqs9NeeToqwisvdh2lAtI3xOq7zBObGp8DQxPIB2aGYtLCNYHVup
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39860400002)(136003)(396003)(346002)(31686004)(6486002)(66476007)(6666004)(5660300002)(36756003)(8676002)(478600001)(2906002)(66946007)(4326008)(31696002)(86362001)(66556008)(83380400001)(16526019)(53546011)(2616005)(54906003)(52116002)(186003)(8936002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UEdWTlB6MkhuQ29IeVl3UkJiOCtqWHM5eHRmbVgwVDF6UEZaSkh3NkpQYUVw?=
 =?utf-8?B?V0ttRUx4R0hwWTJaRmxBeUg0OWYvZmFvbFF1Mm9TdXFFMVFQd050NWp4dTIw?=
 =?utf-8?B?TzExS1psMTJpTWlwcmlRNk9ZNFFrdG42VjVmU21JUnhLTCtmT0NFY09ocUVt?=
 =?utf-8?B?b1l0L1dOVVArZHNEL0Ezb2R6V0NHc0liYURyWnA2d1FxQ0tNd0NWaTh3enVx?=
 =?utf-8?B?M0R1cWhPMGNFTXVCNFNibFJ3Z2tlRUVIVytoUndKR0dzUmdCeVl1eTZGYzY3?=
 =?utf-8?B?NFg0OHpmK3dONnNFd25DY0d3L3BNRjRRMFVKL3pHTFJsZEdvcjJ1VHNaOTl1?=
 =?utf-8?B?WmFJbUVXeWVRSEdvWGFDZk14TTlVeE5Xd21TeWpxRWE2L1JWUzgwV1ZPd05P?=
 =?utf-8?B?d1FHM1IwN0Y2OXFkdVlqbGRFUDNQQTNaOGNSUk9FNkdTNEwyRkhjZ0RtRVNj?=
 =?utf-8?B?bFJBVlZnRHcvRGcwWGo5L0FvbFRSWnFKY0ptTkprU2t2NitDdHBmOUNIRGFt?=
 =?utf-8?B?V0daUnBOYzNLc0h2eEgva1JjVGlvV1ZPN2xpcEx2NkJ2eEtEU213QWl2MEEy?=
 =?utf-8?B?VmNub2ovanpQUlpUVkIxbmZBVzZ2RCtlbFAycmZiMjFmaG13NWdHcUExaUE2?=
 =?utf-8?B?TVlGYkdIOEplRVE3M09QTklkalZRSDQ3U1g2Ly82eCszaE92TjFndHNUWjJS?=
 =?utf-8?B?QXUzN21KYk8xNjc2eC9NbnBocGVjRXY5aGpqNGVGUlhvT0FvamVwTmE5WEN2?=
 =?utf-8?B?d282Tmk4YTFnckFibURnblBlaURlaWtzbCtVNjVmekthcjFoeGhrOVBGOW92?=
 =?utf-8?B?TjhtS09reUNNeVBlSU1IZmtoWHZEMWpzMzY2bDAxdE41UGdjQ3cySVhCcWV4?=
 =?utf-8?B?UVJUMnlFRndqQVQyVC9BTDJBNHE2ZzJscVRiL2VVUEx1ZDBnajBqaXo2dkZm?=
 =?utf-8?B?S3Y5ZnUrV3gwWWZHUnhRSjFtS1NVbEhyWUJvRUFadlVPSXhwSldidDI5aTI1?=
 =?utf-8?B?Sk12MTFGZmZkM3Z0bVZTaXNHVVh0RXRVUjJBTmJlVitBYnVUa2RaSkpEQ3Vp?=
 =?utf-8?B?TUZreVZBYzVXTEJDMlJ0ZHVINHBIK285by9EcXdhTWRRZlpoVnVNNU9qWmkw?=
 =?utf-8?B?TDl6TU5jcGJLYVZnckRuNENUcFArK2pGR3Znd2FiWS8wcGhxMGZXallPM2U0?=
 =?utf-8?B?MWZINHhMcTgraWhZd3BpV1VVSzFxU21ldklXY3NiMjFEbEhYdEV0TnBnS09G?=
 =?utf-8?B?UmY0OXVnUXNEeE5NTXlMd0tHTWJVWFdyUjR2ZVhIOW1BU2tFT3RzOHJhbWVl?=
 =?utf-8?B?bjVRMVlGMnpOUkM0aUFOYlVKSE9Vc2RKTTZ0bVQ2YmJyRFNlMXZZOU1OcjNH?=
 =?utf-8?B?Tm50QlQ2NHY3cVhxZ0tQMG1hdzFqY0JUWTVVa2xma2hvR20vQzRybHBYL1RD?=
 =?utf-8?B?T2s2KzlNcjZXU2haL1d3QjNrdzFieEhMUWN2S2hUY2hVdFNpa0F5TjRhMWE2?=
 =?utf-8?Q?ly6GBg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d552a126-7cef-40b7-1d18-08d8c0f11f3d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 05:21:51.8954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CA9NZu3YzR62Pl4m4iQ5zaWv91bnXHQ/zPg3glJgqN0lzuMRVKLd+I+6Ndx2SMb9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3668
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-25_01:2021-01-22,2021-01-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101250029
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/24/21 11:06 AM, Yonghong Song wrote:
> 
> 
> On 1/22/21 4:44 PM, KP Singh wrote:
>> The script runs the BPF selftests locally on the same kernel image
>> as they would run post submit in the BPF continuous integration
>> framework.
>>
>> The goal of the script is to allow contributors to run selftests locally
>> in the same environment to check if their changes would end up breaking
>> the BPF CI and reduce the back-and-forth between the maintainers and the
>> developers.
>>
>> Signed-off-by: KP Singh <kpsingh@kernel.org>
> 
> Thanks! I tried the script, and it works great.
> 
> Tested-by: Yonghong Song <yhs@fb.com>
> 
> When I tried to apply the patch locally, I see the following warnings:
> -bash-4.4$ git apply ~/p1.txt
> /home/yhs/p1.txt:306: space before tab in indent.
>                  : )
> /home/yhs/p1.txt:307: space before tab in indent.
>                          echo "Invalid Option: -$OPTARG requires an 
> argument"
> warning: 2 lines add whitespace errors.
> 
> Maybe you want to fix them.
> 
> One issue I found with the following script,
> KBUILD_OUTPUT=/home/yhs/work/linux-bld/ 
> tools/testing/selftests/bpf/run_in_vm.sh -- cat /sys/fs/bpf/progs.debug
> I see the following warning:
> 
> [    1.081000] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 
> 101, name: cat
> [    1.081684] 3 locks held by cat/101:
> [    1.082032]  #0: ffff8880047770a0 (&p->lock){+.+.}-{3:3}, at: 
> bpf_seq_read+0x3a/0x3d0
> [    1.082734]  #1: ffffffff82d69800 (rcu_read_lock){....}-{1:2}, at: 
> bpf_iter_run_prog+0x5/0x160
> [    1.083521]  #2: ffff88800618c148 (&mm->mmap_lock#2){++++}-{3:3}, at: 
> exc_page_fault+0x1a1/0x640
> [    1.084344] Preemption disabled at:
> [    1.084346] [<ffffffff8108f913>] migrate_disable+0x33/0x80
> [    1.085207] CPU: 2 PID: 101 Comm: cat Not tainted 
> 5.11.0-rc4-00524-g6e66fbb10597-dirty #1257
> [    1.085933] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
> BIOS 1.9.3-1.el7.centos 04/01
> /2014
> [    1.086747] Call Trace:
> [    1.086961]  dump_stack+0x77/0x97
> [    1.087294]  ___might_sleep.cold.119+0xf2/0x106
> [    1.087702]  exc_page_fault+0x1c1/0x640
> [    1.088056]  asm_exc_page_fault+0x1e/0x30
> [    1.088413] RIP: 0010:bpf_prog_0a182df2d34af188_dump_bpf_prog+0xf5/0xbc8
> [    1.089009] Code: 00 00 8b 7d f4 41 8b 76 44 48 39 f7 73 06 48 01 fb 
> 49 89 df 4c 89 7d d8 49 8b
> bd 20 01 00 00 48 89 7d e0 49 8b bd e0 00 00 00 <48> 8b 7f 20 48 01 d7 
> 48 89 7d e8 48 89 e9 48 83 c
> 1 d0 48 8b 7d c8
> [    1.090635] RSP: 0018:ffffc90000197dc8 EFLAGS: 00010282
> [    1.091100] RAX: 0000000000000000 RBX: ffff888005a60458 RCX: 
> 0000000000000024
> [    1.091727] RDX: 00000000000002f0 RSI: 0000000000000509 RDI: 
> 0000000000000000
> [    1.092384] RBP: ffffc90000197e20 R08: 0000000000000001 R09: 
> 0000000000000000
> [    1.093014] R10: 0000000000000002 R11: 0000000000000000 R12: 
> 0000000000020000
> [    1.093660] R13: ffff888006199800 R14: ffff88800474c480 R15: 
> ffff888005a60458
> [    1.094314]  ? bpf_prog_0a182df2d34af188_dump_bpf_prog+0xc8/0xbc8
> [    1.094871]  bpf_iter_run_prog+0x75/0x160
> [    1.095231]  __bpf_prog_seq_show+0x39/0x40
> [    1.095602]  bpf_seq_read+0xf6/0x3d0
> [    1.095915]  vfs_read+0xa3/0x1b0
> [    1.096226]  ksys_read+0x4f/0xc0
> [    1.096527]  do_syscall_64+0x2d/0x40
> [    1.096831]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [    1.097287] RIP: 0033:0x7f13a43e3ec2
> [    1.097625] Code: c0 e9 b2 fe ff ff 50 48 8d 3d aa 36 0a 00 e8 65 eb 
> 01 00 0f 1f 44 00 00 f3 0f
> 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 
> 56 c3 0f 1f 44 00 00 48 83 e
> c 28 48 89 54 24
> [    1.099232] RSP: 002b:00007fffed256bb8 EFLAGS: 00000246 ORIG_RAX: 
> 0000000000000000
> [    1.099922] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 
> 00007f13a43e3ec2
> [    1.100576] RDX: 0000000000020000 RSI: 00007f13a42d0000 RDI: 
> 0000000000000003
> [    1.101197] RBP: 00007f13a42d0000 R08: 00007f13a42cf010 R09: 
> 0000000000000000
> [    1.101868] R10: 0000000000000022 R11: 0000000000000246 R12: 
> 0000561599794c00
> [    1.102486] R13: 0000000000000003 R14: 0000000000020000 R15: 
> 0000000000020000
> 
> Note that above `cat` is called during /sbin/init init process.
> ......
> [    0.964879] Run /sbin/init as init process
> starting pid 84, tty '': '/etc/init.d/rcS'
> ......
> 
> I checked the assembly code and the above error info and the reason
> is due to an exception (address 0) happens in bpf_prog iterator.
> 
> SEC("iter/bpf_prog")
> int dump_bpf_prog(struct bpf_iter__bpf_prog *ctx)
> {
>          struct seq_file *seq = ctx->meta->seq;
>          __u64 seq_num = ctx->meta->seq_num;
>          struct bpf_prog *prog = ctx->prog;
>          struct bpf_prog_aux *aux;
> 
>          if (!prog)
>                  return 0;
> 
>          aux = prog->aux;
>          if (seq_num == 0)
>                  BPF_SEQ_PRINTF(seq, "  id name             attached\n");
> 
>          BPF_SEQ_PRINTF(seq, "%4u %-16s %s %s\n", aux->id,
>                         get_name(aux->btf, aux->func_info[0].type_id, 
> aux->name),
>                         aux->attach_func_name, aux->dst_prog->aux->name);
>          return 0;
> }
> 
> In the above, aux->dst_prog == 0 and exception does not get caught 
> properly and kernel complains. This might be due to
> ths `cat /sys/fs/bpf/progs.debug` is called too early (in init process)
> and something is not set up properly yet.
> 
> In a different rootfs, I called `cat /sys/fs/bpf/progs.debug` after
> login prompt, and I did not see the error.
> 
> If somebody knows what is the possible reason, that will be great.
> Otherwise, I will continue to debug this later.

I did some investigation and found the root cause.

In arch/x86/mm/fault.c, function do_user_addr_fault(),

The following if condition is false when /sys/fs/bpf/progs.debug is
run during init time and is true when it is run after login prompt.

         if (unlikely(cpu_feature_enabled(X86_FEATURE_SMAP) &&
                      !(hw_error_code & X86_PF_USER) &&
                      !(regs->flags & X86_EFLAGS_AC)))
         {
                 bad_area_nosemaphore(regs, hw_error_code, address);
                 return;
         }

Specifically, cpu_feature_enabled(X86_FEATURE_SMAP) is false when bpf 
program is run at /sbin/init time and is true after login prompt.

The false condition eventually leads the control to the following
code in do_user_addr_fault().

         if (unlikely(!mmap_read_trylock(mm))) {
                 if (!user_mode(regs) && 
!search_exception_tables(regs->ip)) {
                         /*
                          * Fault from code in kernel from
                          * which we do not expect faults.
                          */
                         bad_area_nosemaphore(regs, hw_error_code, address);
                         return;
                 }
retry:
                 mmap_read_lock(mm);
         } else {
                 /*
                  * The above down_read_trylock() might have succeeded in
                  * which case we'll have missed the might_sleep() from
                  * down_read():
                  */
                 might_sleep();
         }

and since mmap_read_trylock(mm) is successful with return value 1,
might_sleep() is called and hence the warning.

> 
>> ---
>>   tools/testing/selftests/bpf/run_in_vm.sh | 353 +++++++++++++++++++++++
>>   1 file changed, 353 insertions(+)
>>   create mode 100755 tools/testing/selftests/bpf/run_in_vm.sh
>>
>> diff --git a/tools/testing/selftests/bpf/run_in_vm.sh 
>> b/tools/testing/selftests/bpf/run_in_vm.sh
>> new file mode 100755
>> index 000000000000..09bb9705acb3
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/run_in_vm.sh
>> @@ -0,0 +1,353 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +set -u
>> +set -e
>> +
>> +QEMU_BINARY="${QEMU_BINARY:="qemu-system-x86_64"}"
>> +X86_BZIMAGE="arch/x86/boot/bzImage"
>> +DEFAULT_COMMAND="./test_progs"
>> +MOUNT_DIR="mnt"
>> +ROOTFS_IMAGE="root.img"
>> +OUTPUT_DIR="$HOME/.bpf_selftests"
>> +KCONFIG_URL="https://raw.githubusercontent.com/libbpf/libbpf/master/travis-ci/vmtest/configs/latest.config  
>> "
>> +INDEX_URL="https://raw.githubusercontent.com/libbpf/libbpf/master/travis-ci/vmtest/configs/INDEX  
>> "
>> +NUM_COMPILE_JOBS="$(nproc)"
>> +
>> +usage()
>> +{
>> +    cat <<EOF
>> +Usage: $0 [-k] [-i] [-d <output_dir>] -- [<command>]
>> +
>> +<command> is the command you would normally run when you are in
>> +tools/testing/selftests/bpf. e.g:
>> +
>> +    $0 -- ./test_progs -t test_lsm
>> +
>> +If no command is specified, "${DEFAULT_COMMAND}" will be run by
>> +default.
>> +
>> +If you build your kernel using KBUILD_OUTPUT= or O= options, these
>> +can be passed as environment variables to the script:
>> +
>> +  O=<path_relative_to_cwd> $0 -- ./test_progs -t test_lsm
>> +
>> +or
>> +
>> +  KBUILD_OUTPUT=<path_relative_to_cwd> $0 -- ./test_progs -t test_lsm
>> +
>> +Options:
>> +
>> +    -k)        "Keep the kernel", i.e. don't recompile the kernel if 
>> it exists.
>> +    -i)        Update the rootfs image with a newer version.
>> +    -d)        Update the output directory (default: ${OUTPUT_DIR})
>> +    -j)        Number of jobs for compilation, similar to -j in make
>> +            (default: ${NUM_COMPILE_JOBS})
>> +EOF
>> +}
>> +
> [...]
