Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FAA403368
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 06:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhIHEku (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 00:40:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40396 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229616AbhIHEkt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Sep 2021 00:40:49 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1884U7cx006034;
        Tue, 7 Sep 2021 21:39:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=CiHSqBgnimKMylyiy+U6Bfi+FRAVApKuCL4LdaKKfHk=;
 b=pSSeN7kbA4AdlAUibclrTQ76XfjJqapIhi5OKnxSAeukh62mclKubA+Y0+hf2wtVtMkF
 RPYe3X5vLwLSLVoZ6zk2oBdFapUBavx651nBTeM6Yj6362bV2STdL8yt+Ao+ojZwftoB
 4NSRZc1/n/rNvmpPDizWzRuEyY5DHnvtHHE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3axcq4uw4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 Sep 2021 21:39:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 7 Sep 2021 21:39:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gp9Cq752NPeFSfveaxn4yAvd9qlLpdIgsbvV3HhvDNh1h2moBjHlZZb4W+UUIGW4N94bjrrCM8q7rzg62hQv3cizzfhilUnMtRWfrFHzQhou2PI+odsfoudkyYvD4Dgnb/wuxeygcrhCo3JXD2HX0eiL7KjT+H0lDqLNYLEmIhCuULG5RbbbMHarR3GvFdwcMNnRb0BrKZpL1d6qr+DI4SHTEPQKn2LsZ8PK3hP2prm3bhbJs2O6lmMGjepfqg6q4yRiae7he76YGk6ptmQKviI5YAYt++kuAy8C147/Vd0+zhTVwwvnSJS74+AvvGufn1r8yvmwtyL56WLPdxa27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CiHSqBgnimKMylyiy+U6Bfi+FRAVApKuCL4LdaKKfHk=;
 b=agbR4jkXgQ0AyqfDXQIGcOIvYhDrLCyC9gVrb9n9LkLEBJfhSaeAtSWaybc/38ROopCgpwxAUdr1EaFLdfLfNhLOlczjml8owyg8d00Kf5emEUEUNnO1WMlDEy+VNKt1m4NLr2sC7lkzfkk8AgWUzXGOsBek4r47gpf6Cv/LXUzA2IxrJeoteS8Y7KTAg9CM8qWypgnWlDwKgc5XLYO6QJbZ6JAYUvA1R8PHtyYl1fTJLlQAVJC7dEqe1Nu8FJHkt/Jdx3ZLn5Xa4XxETmSCewopbdzsovIbjCYZ/yOcDAgqxlRHQktx0BFKFl/AfdqcOnKdt0tlj/ffGWof5jOjfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2255.namprd15.prod.outlook.com (2603:10b6:805:19::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 04:39:19 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4478.025; Wed, 8 Sep 2021
 04:39:19 +0000
Subject: Re: [PATCH mm] mm/mmap: relax mmap_assert_locked() for find_vma()
To:     Liam Howlett <liam.howlett@oracle.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        Luigi Rizzo <lrizzo@google.com>
References: <20210907062650.1309736-1-yhs@fb.com>
 <20210908030941.rfew4t63fw4s4bpz@revolver>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <95576066-0750-2f0f-9886-de00f62abe0e@fb.com>
Date:   Tue, 7 Sep 2021 21:39:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <20210908030941.rfew4t63fw4s4bpz@revolver>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:40::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21e8::18c1] (2620:10d:c090:400::5:8117) by BYAPR04CA0018.namprd04.prod.outlook.com (2603:10b6:a03:40::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 04:39:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27430269-e73a-4d3d-198f-08d972829f62
X-MS-TrafficTypeDiagnostic: SN6PR15MB2255:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB2255DB37E6FAD41A225D6381D3D49@SN6PR15MB2255.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ocrILTdu0MUzfFhZG82b5vYSRz3A0AeUj9T5mIQ46pVExpFW/+dRcT6rFtG4HQO//MVhuIfMLPggFLbt3sGmLzGGrIxhNDnYkQmYQQentI6UfDEXIQFlm1kKQVmWsNC4XzaUZK+I0QciMELpXHWkn7MoUcx7SAdB86gVoOFlpzVb/UbCuIXIrAI0CCXLu0TsMx/qEuVwjD71vqjSrD9+njjZQAWI9IsxIZzf9LNxHIe+QJShbdDM4t0K9TddQfFdpqSJjh996WEMDlDAtIGCo+t9szMcPcViUGECHSNM6OTNVtuJFGJmxZIAnWHgmgk+l/0ESu/R5Qg1xkvTVUuEHhPfW02Ruup3IKNz3qyYyx9DA37JQydaYwFs1QbgDbkMQrbFsO3fqSH8gOcVHlv4/Y+staGWSC8sWOVRzmlxn8jgGw21WJk2wIsmt9iy2DP13dD6rXemie1x6yFzYPJmImNF8N722bsy6WcDn1iqKIi89wzTd+aHbfsGWBoNreGe9sl+UWGvjRIJpaZ8UzETuVO2VEk6h0Zo1kVZ8r0ococxIXXIPdONIBInVzalO8j6LcpzKw5XWHtMwfC1V4W/sIQtVIagEsGrNeuSJVyqsH/EddAT/5K3FD8QNGaPK7Am9nlLYdO5CNr4GP0YHn0wNHjxJ/C99aSTSrIMkjRVb2ZsmaNvj/ZN8qjf9lJwEz4bzCtOpowX3IHtJOYeHkQNruU4hjPzDjcYjmSjXDjZdlw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(478600001)(45080400002)(8676002)(2906002)(2616005)(5660300002)(31696002)(31686004)(66946007)(66476007)(8936002)(4326008)(66556008)(38100700002)(6916009)(316002)(6486002)(54906003)(86362001)(52116002)(36756003)(186003)(53546011)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnZidkxTcXM2cG91YVNMUjlFSDJYYk4vZ3NWK09Zc0FWcWlGeEovaUtxd0w1?=
 =?utf-8?B?Qmo2YzBCcGRmbDhyMXF6U0dXM254WXlnUjU5WGp3Nkg3RTdPWkZSL0ZRR20z?=
 =?utf-8?B?L3o2aUVNSFNXZDF5bWhDMUp1SmlvZTZsWmtWUlhCMnErZmZiVmovaXVna21x?=
 =?utf-8?B?MkRDV1VMeUpBQkoxY0hOZkpIMlNnQWZ4UWNWU3UxS2lSSWxybElxRDZnTlYz?=
 =?utf-8?B?ZFEwODI5clg1eFVXVkVjaTUwekRoN1ZTZ09zZGJkdGUxNHlyV2Q1c1dYQnhU?=
 =?utf-8?B?b210cGRQWUVaMHJrSm5BUVBqbkVWeXl1TitZUU15SVg5a0JLUmZPSHRjK2NK?=
 =?utf-8?B?SDFsUGM0ekt5UE1iUWkrejcwbnVWakludDNRRDJlN0doeEY0NFB6aTY1QUFD?=
 =?utf-8?B?QzE3b253S05DcjN5ZDJadXI0SnRzelh5TVQ2bnNtb0RQeUlhQ09sc0hZTmRN?=
 =?utf-8?B?WDJBamdramkxZWhGaWpDYVdMY1liR0NWaDhNOHMyUjFQUWVoK3lQQW9zR3FV?=
 =?utf-8?B?bkVIZFFVNG44NlBZWmdIQmhlVFdaSTFxNGwyNUo3UGp3MGpPSE9YNU9WY2NR?=
 =?utf-8?B?ZjJwSHFDa29UVzdsTnQxK0pzWFBCdzJ4Qk5SK09QZjI2cVpQakhPZ2YyWG83?=
 =?utf-8?B?Q3hwODQyQXZKUGFTVDV0Qmh2WTd0bnNTV3MxeFlDelBlUmw2UzRpSzFRc2FP?=
 =?utf-8?B?OWpIdkNZT3FocTBCUEM5RTdZWmxtWUppZWwvWlBiYy8zbVJ2QjhLMlJ6Vncy?=
 =?utf-8?B?YjU0Z3ZYWWQvenhTQzdmVlVZOUdXT0lCTlUrek1kT2x4UGFIUzBhM3Vubkh4?=
 =?utf-8?B?R0pqOVcxV1ovSUZ0ZW1YblQrM0dRRE93dzVwY1grRFpORXRiUkxoZFRONTIx?=
 =?utf-8?B?c0NyNFlUMXk3eThGbWdGMVhPMzlHWTYwZFBZQVJhaFNacnMrVnhGNDkvUDhJ?=
 =?utf-8?B?a0RObnpUR3JJQ08yUWJ6U1lON2VJTjFBdWx5bmVKcVAyeHlmL3VUZ1JEQm1a?=
 =?utf-8?B?aDl2bjhSakZ2NUIvLzNPNHJKVFRRaExXMXFoUlBqdTM2NUhYcnBlVkkxdlQv?=
 =?utf-8?B?VU1GOU9HZEZoZWQ3VGtOVDlpWG52aGt2aU9mcjcwb2VzZE8wbzJISHMxd213?=
 =?utf-8?B?bC8xeVJnK2hHTnFhRVdnYkdGRHJKcFMzSnhnRDd5M0owMU5ydGMrYnZSdHhJ?=
 =?utf-8?B?Nnd0ZEhFRWFLY25vVGxCN2lCR01JMmNSTjZvUUE4RWF1MnF4cHVQNUh2WDFm?=
 =?utf-8?B?cm41Q2Q5NjUvK3NvakdINllTMDV5bGQxNkE1S2dha0xMRkFkMkJ5Z2t1RGlq?=
 =?utf-8?B?Rit4Qnc2QzRQTGt5cC9XZDhHUThVZ2ZMdlZWbEdvNldmalV3ZW8wRHhQQk9D?=
 =?utf-8?B?UDJDVkhjaHFJUkFMd1ZDKzRpLzZ1VlljS0Y1WGZSdzFvOWh3cktNREVOM3hO?=
 =?utf-8?B?eS9TWWV6ZStWL1Q2LzdWMHZJOGhjb3E1OHNlYTFITzVIOTcxbnBpN3Y5cjlt?=
 =?utf-8?B?TzB2TlYvUzBmRUtCemdCRTU0RytrUVBmODFoT3hsTmVWa1ZIVUpnMWNVc0Jq?=
 =?utf-8?B?VGlUV3B3bk9wUEh3OWlpRHc4SmROZ1lldmdFNlE2VU0vT1NOUkNXSGRRck0y?=
 =?utf-8?B?U0Q0U1g2aDFsMzNRdktqVitHTWlMOUQxbHBGYWEzNWxPUGlJZENnQWlVM0Zi?=
 =?utf-8?B?ekVlQVNhNnluTGQxKzVVTERsUy9lanRnTk5kV2U5TnFPOWhYN1R6UFVFbmtn?=
 =?utf-8?B?UjFMS2lKU2VJMDRyaGVKbDlsNzNpcDhWY1BaZ09pcXZwSmxMSDlBVzdWeENv?=
 =?utf-8?B?N1JHVEJFWXp6elR1dzJhZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27430269-e73a-4d3d-198f-08d972829f62
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 04:39:19.6286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QUJCQMID6uqhwfuQsbChxtB87WC0p8QY0J3J2wq5nsqLX23yE2sQsO0l8068K1gZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2255
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: N3AaAPUWLxqnpQJ3WtlFP7nC5XWhCfiE
X-Proofpoint-ORIG-GUID: N3AaAPUWLxqnpQJ3WtlFP7nC5XWhCfiE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-08_01:2021-09-07,2021-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 impostorscore=0 clxscore=1011 mlxlogscore=999 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080027
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/7/21 8:09 PM, Liam Howlett wrote:
> * Yonghong Song <yhs@fb.com> [210907 02:27]:
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
>> The warning is due to commit 5b78ed24e8ec("mm/pagemap: add mmap_assert_locked() annotations to find_vma*()")
>> which added mmap_assert_locked() in find_vma() function. The mmap_assert_locked() function
>> asserts that mm->mmap_lock needs to be held. But this is not the case for
>> bpf_get_stack() or bpf_get_stackid() helper (kernel/bpf/stackmap.c), which
>> uses mmap_read_trylock_non_owner() instead. Since mm->mmap_lock is not held
>> in bpf_get_stack[id]() use case, the above warning is emitted during test run.
>>
>> This patch fixed the issue by replacing mmap_assert_locked() with rwsem_is_locked(&mm->mmap_lock)
>> in find_vma().
> 
> I'm not a fan of removing the lockdep check.  I'd rather see find_vma()
> do the lockdep and call another internal function which does exactly
> what you have below.  Then you could call the one and everyone else
> could keep the code they have.

Okay, will do that in the next revision.

> 
> More importantly, since this is the only user of the
> mmap_read_trylock_non_owner(), is there a build bot that could be used
> to catch errors introduced in this
> path?

We do have libbpf ci to test selftest against current *bpf_next* and 
some past old kernels. In this case, I think it is linux-next first 
introduced issue, and then the change went to net-next and then 
bpf-next. So to catch this earlier, we need to do libbpf ci on linux-next
and/or net-next. We will discuss how we could incorporate this.

> 
> Thanks,
> Liam
> 
>>
>> Cc: Luigi Rizzo <lrizzo@google.com>
>> Fixes: 5b78ed24e8ec("mm/pagemap: add mmap_assert_locked() annotations to find_vma*()")
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   mm/mmap.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Alternatively we could add a bool argument to find_vma to indicate whether
>> mm->mmap_lock has been held or not. But I would like to report and try the
>> simpler solution first.
>>
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 88dcc5c25225..8c78b85475b1 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -2275,7 +2275,7 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>>   	struct rb_node *rb_node;
>>   	struct vm_area_struct *vma;
>>   
>> -	mmap_assert_locked(mm);
>> +	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
>>   	/* Check the cache first. */
>>   	vma = vmacache_find(mm, addr);
>>   	if (likely(vma))
>> -- 
>> 2.30.2
>>
