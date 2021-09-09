Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC0D4059BC
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 16:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhIIO4F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 10:56:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53930 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229709AbhIIO4F (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Sep 2021 10:56:05 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 189Ek8qZ029234;
        Thu, 9 Sep 2021 07:54:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=clpASYOPSxbSAwp+z8V176ynMoEd47+X8KyxBiJOTns=;
 b=VcREsEfdw0s010Y940mJZzEazP0LHvVwFd/qHuGJr5QiM1PmK05MhuRhD5y7KnPUmeN5
 Sk7/ZDjWrDAzbAM3EZhnesdltOO1o7j7YdUNwGQnWGZybm9qqH5K+yLVoBTstZntRN2w
 kvGn7ohIphJSEaPsb3ogHLCAQteBxa5LIrU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aya9h3j2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 09 Sep 2021 07:54:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 9 Sep 2021 07:54:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ka2T0o8PTWde/hMKpVriDawKBzQTWCE5BdnLLpnvSyrDhum7Z2yotRU9r1LRipAoXZc2YaymLDSioHKnmZTbkDnt/aUOBolQ1nJyq1GM0+ZDzxx86dA0duDxJFaYDYc3sToHyvVCt79+RmfUOK7ufhuqYa8nhAsl32hDHjQ6vhLDYrwfTHq9EsjvPYIz6leHk6mkqE7eLirA28TxamCCFn2xA0IaFK95U5L61+D1/jARUcMHrcH8v9lesENDq/dScCxTqPa8feqFkEywfzgGgWguUchD8wkvmbFZTvsyadhbaBdEaCloqIS+hOE/qUvaAc3jV0CTIgc3SjlWBNOZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=clpASYOPSxbSAwp+z8V176ynMoEd47+X8KyxBiJOTns=;
 b=GvCweTbbuuhTwih+0WvBMs7glW1HiVN4iuPjUwHg92GAeDFL8jJeswr9rqd7SrB+KKsgJHJ4IckwLcmjjTGkQ0q09r5KxTgWxpMKDyoyvBNspGgajUiK2M1PM27ROoVJzMgJii9I+iHNEpJhedhpc8W/6s02OI8xye8QG3Lw/r3EMfn2oKPmUwTBsCzT1b1/Vgb7KnEgmhzViU0JuaCqtWOmA2EVrajXWGmuwtAfrTA9OO2vci6E2fd6jfgOv+1e2qCWRd6aOod08FQp8NBclkfWPHdzRV+RIqRvLchO5Ylizyf2uZOdc4NGcJpHjvkQq9/M81EfhKq508eVOWjEdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4497.namprd15.prod.outlook.com (2603:10b6:806:198::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Thu, 9 Sep
 2021 14:54:35 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 14:54:35 +0000
Subject: Re: [PATCH bpf-next v4] bpf: fix lockdep warning triggered by
 stack_map_get_build_id_offset()
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <bpf@vger.kernel.org>, <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Luigi Rizzo <lrizzo@google.com>
References: <20210909060245.2966358-1-yhs@fb.com>
 <20210909123459.GC3544071@ziepe.ca>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <80d979fa-7845-608e-c2fb-4b8003291fd7@fb.com>
Date:   Thu, 9 Sep 2021 07:54:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <20210909123459.GC3544071@ziepe.ca>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0185.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::10) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21d6::108f] (2620:10d:c090:400::5:59e2) by SJ0PR03CA0185.namprd03.prod.outlook.com (2603:10b6:a03:2ef::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 14:54:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ebcdc03-f61d-4844-9da0-08d973a1bd78
X-MS-TrafficTypeDiagnostic: SA1PR15MB4497:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4497297964F7D8207CCEF620D3D59@SA1PR15MB4497.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s1lqgeTwoGRwRirpMmDHv+vL8bEG8lw++PPNhgww9mnD8BRovK3OfHQwXY14Klhq15ObwWMPc3ur8WpAr8rQQNW2oKTDGFI2zfzsCid6Md8UVqeU9K4JzbbshCuPo9pfv4RiaUftri60zBm5dwQ0YiJmTcDUhdzZSqBJVL6MDlsc80CH8XZAQpygLuErC7XVTeIx2aqVR1V9sDf0Tz6kdebx34OowgarR0oZBGXmq8wtfN/cdsJYTkuCneIqRlkkYVJcJkPs5wMCUfGLvC2U/TCgdNf3OfhpzdQBfofJICHQ6OjcWfK3rp1CyQBhPYvqRL+v1DLJ34XIylkIkiXKxiPAwvT/z6DG9tkJLwF/orJ7OFVdJkqoyKq44hbSWjFphXbrZixSiXbaWCpWR7g5ZAo530B4kAMDGHrTKPiKxysyZT+mwzBX+awJCrCO4RPG6KKuJWhysKHbQEIh1vuX0p7c1USFl9uAjTRI4XGDD8a1u4aNxtCpTTJbyS+Hxxyf9NM6P5OvnX547LoWed7u71fBdXZ60s7TKkXIafdLnDViqBHjJFICASzpmGpPvBHpC/i63zdQaGwptGw2wdsN319hzZb5m9qU/FfW0pLh3IbSJ4ygGEEAG6TNFqpx0nrlSw4EYkmMi3Lr8bMZZ2kn7M7yvET7WL+gpkEXmWePDo9V4Pc7AHQLZNr6Rq4hBEApyBBXVMU9hAUvnVbImmZ3B4cVvW7YP13UVPooxORW4oY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(31696002)(6916009)(86362001)(31686004)(66946007)(6486002)(478600001)(66556008)(66476007)(8936002)(38100700002)(83380400001)(316002)(53546011)(36756003)(2906002)(52116002)(2616005)(186003)(5660300002)(45080400002)(8676002)(4326008)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXJGZEtyUFpuYjRJQUl5R2p0bzJvVUdKZjFYUlZHM1hPMTlqenJsaXpQUDFI?=
 =?utf-8?B?akhVT1FwSVIvQXN4dm9xTXNmTXNtRHkrbDNyS3NQaWdVYTBzZlV3bE1GckU2?=
 =?utf-8?B?UTFYc3ZFVytSaklOelc4VGxoZmpqWnhVVjFoTHNGZ2lOTnIyVnRiK0Rjbm5B?=
 =?utf-8?B?aEovSkNFbXRqeWdmK0JKanF4MWlRaW41OEk0aW1hZjIvQ1diR1M5cm1IK0Qr?=
 =?utf-8?B?a2N6MUhCM2J6N0x2VnlaZCsrVktGVmtNRlUwdXNKZDNENXZ1TEhkeWNMNUps?=
 =?utf-8?B?OWZ4VHdUeStvaVVpcnNpRnRGZXFTeFJpNENLZmVHdXJQYkdIUjhRWUU4UVhh?=
 =?utf-8?B?aDhuV0x2T0Z2dC9IR3oyUFdmMW10ekVLWCs1cmtnZi9LT2VGYnNHK3dnZm5z?=
 =?utf-8?B?dHFvd05rQW5qSlIxdm1jVzNJaXlLS2tOSm1uaFBBS2NTcUhIdGhCZkt6SjUy?=
 =?utf-8?B?SWsrRjFqbjRONTI2UHplM3FEQnJHd0dGWmNnVTk0Zkp2SUU0eUdyTmdpTVQ3?=
 =?utf-8?B?Uks4NXFzOHhlOU44cXBBMENpMU1MWFNvWE5Yekg0VHprNU9RK2ZLdFFpTkFi?=
 =?utf-8?B?a29YS3ZsazAyWDIrbDlrNmEzc1R6K2oya1BwS29ndWJ4SW1mek9GL2VWTlVZ?=
 =?utf-8?B?ZzUwM0xUS0tFcGZiWEYxVnp6Q1E4eXNkS0pFa1NGSVE3S2tyQVVsSVRiQ2JX?=
 =?utf-8?B?SDdxdm1LSzJaZlhMNUlzZkErbnkwSGxidEx1WjdQZGNrdEovc3JLOVAzRWVX?=
 =?utf-8?B?a1lLZjRGazFLTHNPWXp6dTBDdUNrVTQxUHk0alhLM0R5RXJDSXZIS0pvRlBj?=
 =?utf-8?B?UnBwWVhhU3J3d0hFNC91R1pRamlpME00M091QWJkUWhuU3lQSlhvV01iblda?=
 =?utf-8?B?VkhWeVVWRTRYdjI3Q2lPWkdBTXBFTHg2N0Jib2h5dWc1Y2E3bkFFUnpZNFVZ?=
 =?utf-8?B?MFFBMUYrY01veDdHUHZncm1Mb3hrOG9GcTJLZkM4SHE1U2NCQkJqS0JPeDI3?=
 =?utf-8?B?a01yZmpINzRUMEs4RHZ2U3QzcUpDcFdYeUxYQ3JaWml4Mi9pdDRNWUNJTFVB?=
 =?utf-8?B?eDhvNmtWbGlYd015dUduZ05MV0x4R0g0Qm0zUjVzcCtoakRkblNOQzQyRGRX?=
 =?utf-8?B?ZHVaNlpkV0d5VWsvN2xMamNrQ1dLNDJKZm5kVHJjR0tZVmttalY4b0h5KzIw?=
 =?utf-8?B?YThCdUg0Sk5uemxVTEV4OU9FeUlRN0RtOTdPTktnNC9kMFdLZTZ2NXoyeXhl?=
 =?utf-8?B?dXpabUQzLzBvZUxycEcwOVdadnVXcUNpaWwvNXNFY2Jaa3RpYUtwa0JnRURh?=
 =?utf-8?B?SmNuQWFPd0l1dmJMelh5YURSek9PcVVSM3FBZGN1RGlNNWZHQWExWVF6N1Yr?=
 =?utf-8?B?T2hPRHhLNllld2J1Z1hiYlNqSjdTekUvdEdQOUhkT1ZIcHlud1QrY3E4bitJ?=
 =?utf-8?B?L2h1eExHYUlyaG9HTWQzenZGVVFzM3laNVk0VVJCeUFVcy9odTB2Z1AwZTRJ?=
 =?utf-8?B?aGtqSVczbkRjaksxL083NmIrSVN3RXAyRU9JWnd3S3dnNjJxS09Dc2taaU9n?=
 =?utf-8?B?ZGM3SUR6eHMvTTJEdzc3S3RDY0s4WkFrdXp5eEZSZHM5TTk3eG1SVDJhY2xP?=
 =?utf-8?B?cWhCL001ZjR4Z1R6WVYwUTFncVV0NGNzR25rRER1UHhRZ0NZQmgvT3ltTmhr?=
 =?utf-8?B?WjgycDdnMjVnWHBBakpaZjBYeklZRUFtaUlhaDdlU21STTcwR3oyMDJkd2Ra?=
 =?utf-8?B?LzduNGlYeUNna3R5S2pCWW5CYk44R0NGYlo2TEZmNVpnMnF2SGhldlF3R0pX?=
 =?utf-8?Q?FQOpm3BpvSkSqxqUsui+RGO43Su3rT5OMh7+Q=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ebcdc03-f61d-4844-9da0-08d973a1bd78
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 14:54:35.7082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0uGIBCCtyEOwbQOgbhaKwji4xo6G9RgvtFuMie6xCzr0jgyDYlK6EuV3RW6DbCiK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4497
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: QaQ2RePhzs4uQoOCHbQAeMAlfuDknmLe
X-Proofpoint-ORIG-GUID: QaQ2RePhzs4uQoOCHbQAeMAlfuDknmLe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-09_05:2021-09-09,2021-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109090091
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/9/21 5:34 AM, Jason Gunthorpe wrote:
> On Wed, Sep 08, 2021 at 11:02:45PM -0700, Yonghong Song wrote:
>> Current bpf-next bpf selftest "get_stack_raw_tp" triggered the warning:
>>
>>    [ 1411.304463] WARNING: CPU: 3 PID: 140 at include/linux/mmap_lock.h:164 find_vma+0x47/0xa0
>>    [ 1411.304469] Modules linked in: bpf_testmod(O) [last unloaded: bpf_testmod]
>>    [ 1411.304476] CPU: 3 PID: 140 Comm: systemd-journal Tainted: G        W  O      5.14.0+ #53
>>    [ 1411.304479] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>>    [ 1411.304481] RIP: 0010:find_vma+0x47/0xa0
>>    [ 1411.304484] Code: de 48 89 ef e8 ba f5 fe ff 48 85 c0 74 2e 48 83 c4 08 5b 5d c3 48 8d bf 28 01 00 00 be ff ff ff ff e8 2d 9f d8 00 85 c0 75 d4 <0f> 0b 48 89 de 48 8
>>    [ 1411.304487] RSP: 0018:ffffabd440403db8 EFLAGS: 00010246
>>    [ 1411.304490] RAX: 0000000000000000 RBX: 00007f00ad80a0e0 RCX: 0000000000000000
>>    [ 1411.304492] RDX: 0000000000000001 RSI: ffffffff9776b144 RDI: ffffffff977e1b0e
>>    [ 1411.304494] RBP: ffff9cf5c2f50000 R08: ffff9cf5c3eb25d8 R09: 00000000fffffffe
>>    [ 1411.304496] R10: 0000000000000001 R11: 00000000ef974e19 R12: ffff9cf5c39ae0e0
>>    [ 1411.304498] R13: 0000000000000000 R14: 0000000000000000 R15: ffff9cf5c39ae0e0
>>    [ 1411.304501] FS:  00007f00ae754780(0000) GS:ffff9cf5fba00000(0000) knlGS:0000000000000000
>>    [ 1411.304504] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>    [ 1411.304506] CR2: 000000003e34343c CR3: 0000000103a98005 CR4: 0000000000370ee0
>>    [ 1411.304508] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>    [ 1411.304510] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>    [ 1411.304512] Call Trace:
>>    [ 1411.304517]  stack_map_get_build_id_offset+0x17c/0x260
>>    [ 1411.304528]  __bpf_get_stack+0x18f/0x230
>>    [ 1411.304541]  bpf_get_stack_raw_tp+0x5a/0x70
>>    [ 1411.305752] RAX: 0000000000000000 RBX: 5541f689495641d7 RCX: 0000000000000000
>>    [ 1411.305756] RDX: 0000000000000001 RSI: ffffffff9776b144 RDI: ffffffff977e1b0e
>>    [ 1411.305758] RBP: ffff9cf5c02b2f40 R08: ffff9cf5ca7606c0 R09: ffffcbd43ee02c04
>>    [ 1411.306978]  bpf_prog_32007c34f7726d29_bpf_prog1+0xaf/0xd9c
>>    [ 1411.307861] R10: 0000000000000001 R11: 0000000000000044 R12: ffff9cf5c2ef60e0
>>    [ 1411.307865] R13: 0000000000000005 R14: 0000000000000000 R15: ffff9cf5c2ef6108
>>    [ 1411.309074]  bpf_trace_run2+0x8f/0x1a0
>>    [ 1411.309891] FS:  00007ff485141700(0000) GS:ffff9cf5fae00000(0000) knlGS:0000000000000000
>>    [ 1411.309896] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>    [ 1411.311221]  syscall_trace_enter.isra.20+0x161/0x1f0
>>    [ 1411.311600] CR2: 00007ff48514d90e CR3: 0000000107114001 CR4: 0000000000370ef0
>>    [ 1411.312291]  do_syscall_64+0x15/0x80
>>    [ 1411.312941] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>    [ 1411.313803]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>    [ 1411.314223] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>    [ 1411.315082] RIP: 0033:0x7f00ad80a0e0
>>    [ 1411.315626] Call Trace:
>>    [ 1411.315632]  stack_map_get_build_id_offset+0x17c/0x260
>>
>> To reproduce, first build `test_progs` binary:
>>    make -C tools/testing/selftests/bpf -j60
>> and then run the binary at tools/testing/selftests/bpf directory:
>>    ./test_progs -t get_stack_raw_tp
>>
>> The warning is due to commit 5b78ed24e8ec("mm/pagemap: add mmap_assert_locked()
>> annotations to find_vma*()") which added mmap_assert_locked() in find_vma() function.
>> The mmap_assert_locked() function asserts that mm->mmap_lock needs to be held. But this
>> is not the case for bpf_get_stack() or bpf_get_stackid() helper (kernel/bpf/stackmap.c),
>> which uses mmap_read_trylock_non_owner() instead. Since mm->mmap_lock is not held
>> in bpf_get_stack[id]() use case, the above warning is emitted during test run.
>>
>> This patch fixed the issue by (1). using mmap_read_trylock() instead of
>> mmap_read_trylock_non_owner() to satisfy lockdep checking in find_vma(),
>> and (2). droping lockdep for mmap_lock right before the irq_work_queue().
>>
>> Cc: Luigi Rizzo <lrizzo@google.com>
>> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
>> Fixes: 5b78ed24e8ec("mm/pagemap: add mmap_assert_locked() annotations to find_vma*()")
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>   kernel/bpf/stackmap.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index e8eefdf8cf3e..7b7500a3724b 100644
>> +++ b/kernel/bpf/stackmap.c
>> @@ -179,7 +179,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>>   	 * with build_id.
>>   	 */
>>   	if (!user || !current || !current->mm || irq_work_busy ||
>> -	    !mmap_read_trylock_non_owner(current->mm)) {
>> +	    !mmap_read_trylock(current->mm)) {
> 
> This was the only caller of mmap_read_trylock_non_owner(), so please
> delete it too

Thanks. Will do.

> 
> Jason
> 
