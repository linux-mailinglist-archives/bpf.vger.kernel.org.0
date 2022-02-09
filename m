Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2AE94AFCE1
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 20:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbiBITHI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 14:07:08 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiBITHI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 14:07:08 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93250C050CE5
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 11:06:59 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 219HJ8gG020310;
        Wed, 9 Feb 2022 11:06:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=3ScKyrDix52+BaR8PmrxoV4ZLt7sT5QHuNlouhtiLzA=;
 b=bMbAKwjF6UPyEVIKNO5AWQxGsjLuBQp0gqjQ22nFcQJEKIx2zHC1SvHOwajqydnFiyib
 3LQbftm7w2CzHyaAbrrD6b+24ZNbReaSYaW8nY81W7P0GwU7KYT2R/t8Pfzt+tSs7kPq
 MlsuOvE5BdQrwOjdLMrvbh6GpWUGb3aJtcc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e4fyk1uv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Feb 2022 11:06:14 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Feb 2022 11:06:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejpca2gcRRQ64B8DjTrm75zikHbM4Tr5ZeEz26QeivhElArCHyMNmtq386bhOk9jFM2jgZrAQgOwR7394lvIvAkDYKs0993Fjkp5DbF3QFeBS90UgE+9nC9tbNXZtgQI7N59vhNUq2VxSqSiF7fY2zresYV8CSzj44ZAuuwW1VTJk2YcRDn/VaKgLYQ2I+Xj5Ea374kS7Dw0L4xVdzCpYVrRYh56ZRF/veFjlEcimx1mcNVNMmehgA7gGY8ESYYPO0oIqjITTDWtc3nS/f6JHtCDfSCswfx2cwuDJHIoj5UoCHDcvya41gNPcvjWb5TZiB3QX2euqJca4C5oOO/32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ScKyrDix52+BaR8PmrxoV4ZLt7sT5QHuNlouhtiLzA=;
 b=U4Fo2sXYVF8Z+7lpXpFyMPRNgNUix4j8BvGJjS3IOtxT36Jk/MeuFJfUkIZbyDQjep7JdTKB28waiKF3GpcBFN9yBdYupJA7NwizTWiddsSCssup7SKI366u6BxeLuQ4Gpp/IlhycYvRMGQPiCBwQ3EzpqU1Gk5za7mruyQku8aSjsTsILQUIx/8w4Tt+WAefOeHCPYpUcrzYD4+Jncjv5AADh0PV4yUNMzERDo3HgBKY51Rk5YMfGIxCK0vwA7wDkej/iAXn1rb38+qWfiv7sLi64yq1SqN/GeytUiL/eydIVY4vkovGHBQGARjG/ldED5YLj6ztGAsJvQAeTzjfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB3565.namprd15.prod.outlook.com (2603:10b6:208:184::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 19:06:12 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 19:06:12 +0000
Message-ID: <57359c7b-7c6b-cfc9-22e8-5288a6ce0517@fb.com>
Date:   Wed, 9 Feb 2022 11:06:08 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix crash due to incorrect copy_map_value
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20220209070324.1093182-1-memxor@gmail.com>
 <20220209070324.1093182-2-memxor@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220209070324.1093182-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR07CA0057.namprd07.prod.outlook.com (2603:10b6:100::25)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94e5c410-6165-45ad-dd6d-08d9ebff3cc8
X-MS-TrafficTypeDiagnostic: MN2PR15MB3565:EE_
X-Microsoft-Antispam-PRVS: <MN2PR15MB3565A0EE1DB524E4FCE81AEAD32E9@MN2PR15MB3565.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LAusis2Y3tjZpv+Rp5A0m/pwdPRIF6vVZ5RV/Vvrdl4ZbRB5FjZyzpgk4pCXxqgXokL8JvbJh+nTTkjdJX+WLdBK4cLVnKyd2xJ30BHvv4aTblDylfyJ+ddXrIZbIlFG3zsGXs6dJgXd5ZHGDbUrOzssTDEW7Kah8S+RwiUjRAvmytmTXwRM7ll76y570mv2uvKljBX9yuuiplHmNul0QvizepgaxaqMqjh+n8jU4icbsO5bGin35ux8WXhldOgBCYxUE1tRKONXoz8WBqPX+QBV1RemXvTl7AwUxnpo4YAbqKvWVexTMEs1cdD+GsNlyVvfaHGHDjNHoboLnWZ80FYwtaIQNClys6oB06i5FbTDhaC6wcz3eve4cMB/vEwVM0cHblJ9Kgcw2dinVtEvYYda5hAtfMX8buNF+xgLdnu4+kr4ApkuSpBC/Q3sXyOZYnJwgLKJdPEa21h7fICATEqTXRUsLwpHisnGbjiRsgQY4pYOmc54DEqEbFwlgtzM3ycNgmx3bej3M1nhqLk+mMTCZxb+Mqelk0/wAtUCmrIICjIZAlJsE83tgHc7ylNnhptUwHM4JziFiYmyahBZlvQ9aV0bMmdLi7mmDuQBIQm0YXgMxsDJyzHy+vx6e4VLs9pcOVYY0wx8xDZuXqADxrjPGj6stfl6th/miiYj9/8KH6JYVzOgHjG3w5by4Ti8bB1DjEjWXUKdW2ywiHgkIXSei9GaMPBMH7LPP9nazG+xR1SnI606Lddw+umFRv6N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(66476007)(8936002)(66556008)(36756003)(66946007)(316002)(8676002)(2616005)(5660300002)(110136005)(186003)(38100700002)(31686004)(6666004)(86362001)(6512007)(2906002)(31696002)(53546011)(508600001)(52116002)(6506007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekFFbFJVQ1g0a3RKUmpJbVBCUysyYU5uNllyUE1odytpSUIyRjNUUmI2YzJ5?=
 =?utf-8?B?dGhwdTl6UXFTNkl4dGYxTCtiS0pLeTZQYW41SWRFaklKbGNuLytrUnczQWJy?=
 =?utf-8?B?Q2pOL0FEWURidjlMK2VGY0QrNndQa2ZEU2E4UzIreEkwZm1JN0JlcUE5b25O?=
 =?utf-8?B?TEkyWUtOSHlyRmlxdWJla2NiVjBYLzlnOTgvTEVWc21jNU01Y3lWdE9NRnRl?=
 =?utf-8?B?cks2M3pEZlZ3WDFmTFFIeHdlaHdYVE4zeGZnd3AzaE5DTFJ5VjQ0YjF3UnVk?=
 =?utf-8?B?bmgzYW8yUzlzV2d5UTdib0Iya0Vzc2plS3NjSWtEMGlNUW9jakRIaDN2QzZE?=
 =?utf-8?B?cldMY3Bvb2J6aGFjQ3AyQ3FXUGFiSFg1WmxKV1crSEpPcVh6Q0FxblZyZEli?=
 =?utf-8?B?emdCM0dMeFdQejhvbHdvWElMOHc4bERNY0luTG1xVUxZRTNtbGVTd2RaTU5r?=
 =?utf-8?B?UGFJemdjenhTVjBkRWNhMWZ4OHY5TzhPVTViUWRwU2d1cXgwWmpFKzQ4cUF1?=
 =?utf-8?B?cjdzSlJIU1VlN1Z4MEtwcXdsK0VRNWVLbHlWTjVCbytOVHpkN3RtTFQwRUc1?=
 =?utf-8?B?TG1nN21sYzBYUnM2ZlNUaFhHWEt4cWNqWGJRZU84L2U3WSs1TFlidXNCWHdy?=
 =?utf-8?B?Z3NrbjhRSDJBUWpPcjBWaDRhUlJMWHFLbDgzTkJqNE4zRjdqcTFlMXVQTDZ6?=
 =?utf-8?B?VjdPdWFmSHE2UzJibGNhQ2VIU1pDcndCVmVMbnFyMjd6NURnWW5GK3M3dm9R?=
 =?utf-8?B?dmVhYWZOaWw2U3h4ZFF5MkVMeDF0OU1JSDl0YlhINkdRNlAraEEwcGxEYlVJ?=
 =?utf-8?B?WHptMUNqdkJDek9pSDdLT0k2MERoWC8yc2ZqSGt1U3FZdGVJcWJXNElTRnMx?=
 =?utf-8?B?UUM5MXNNQ0U0US9OMExIWG9NV3owYXRPODBPdlhSM1EybVYvb2pjRGZ1dmVx?=
 =?utf-8?B?d1B6MlM2ckxRc041ZTFHZ055emV3aTIvMDhyNnNvUVhCdUllcFk2ZC9VUmxo?=
 =?utf-8?B?eGMvV0hVa011NkFXdDgwYjBzb2ZramJhVk1Cc1JXTVlOOVp5N0pHd1NxU1JV?=
 =?utf-8?B?YURzem5YWnRrTWlpYkljRXFHYkZqdmxJbUt3Yk9hdzdQOUVVLy9TdllzN0xG?=
 =?utf-8?B?MjZkS3Z1ZWIzeFNKWjZUbHp6eVRUU21vZjExeDJZZ1FxcTVicEtYZmkxUTBa?=
 =?utf-8?B?WGZSWFV2N0ovS2NJemg2aUk4dHR3ZTdTN2RIMGIyWjMvT3NYZUZ6NVR1b3J5?=
 =?utf-8?B?NkNwZXMyeFp6OUl0VzJPc21Lc1hZNWlVRndBdGRDdzJ1REN5Nis0NDBWaDBE?=
 =?utf-8?B?UC8wN09LdmdUbGE5OHJMczQ2b1p4RGh0MTc2K3B0blZQb2pMVVplRTgxZ3hM?=
 =?utf-8?B?NTZiUVZDaEhLc3hUMHJ0aFdsZnJWZWU5S3pHY0ZaSFpYZTRpMnZ1MmREaXVm?=
 =?utf-8?B?bzZ2UlBEQ1d2NzlnK00rS2g1NTFHa2czUDU5Y2U0L3REMUNLcjF6eTEwNmlp?=
 =?utf-8?B?bGVGa1FwQ0FVQVhtSDJhVlI0dXRteU5UYVNiT1BkTllmaWY1ajJLUmhzbVBB?=
 =?utf-8?B?ZWIwVUEvT3ZHamVyOEdocld1RmtGNzhLWld3OUQrQnhIdlpHMm1mUHk4TllG?=
 =?utf-8?B?T0pJQnpqQTQ3MVVpMHNKaEE5NFJtOHhHbFk0a0VuUUZoVmVmcDdROVRWTXZj?=
 =?utf-8?B?UTFWZ2FMM3p3OUdJWDNwYmJBWGRnYytjcExMeDhoM1BCdloyY2hXRVhtbnpr?=
 =?utf-8?B?QmFpT1RaL0pvMVI0cmt0b0lReEtKRWc0YTd2STdKMnZ3cmxMVGdOL0VxdlE1?=
 =?utf-8?B?MEJqMHkyelFrOHZQT0I4dStiWmtxOU5VdC9GbWxaWjI1eDkzOExQd08zckMv?=
 =?utf-8?B?SHZiTTFIdjBHek13NzUrOWIyK25CUndvYWlocDdBYjVZd05oNisyK3Qvai9x?=
 =?utf-8?B?dlUzYWNjL29BY21pTFpSMmtnWmpCbmJqMnlCTWZBaVM2endmZWNqS1BUbHVM?=
 =?utf-8?B?OFRaQ0FwVWQzalZiL05oYUg3c0NlWFNjdmQxZTJTSnd6R0ZYaThvQmgwRGdp?=
 =?utf-8?B?MHZFYW5FLy90Qm5oQnB2TnByMHlkVmtlTG96RWdmaE10SmFBdUdraVJWZGJY?=
 =?utf-8?B?MXIwbUcrN0tzMUpzbUIrSTZRQndkVHBEbHhHeEtIaEZvcEFiNHV1a3A4dXp5?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e5c410-6165-45ad-dd6d-08d9ebff3cc8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 19:06:12.0651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oe/S94+LsjPVTd6DnNZ5YCRzINPM6jlQJM+s1ESPue9eLBYpCKOidpfVfKE0CBw0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3565
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: KA6Zu5nvxzn0hygFYQgGhPeoB1DkH5xY
X-Proofpoint-ORIG-GUID: KA6Zu5nvxzn0hygFYQgGhPeoB1DkH5xY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_10,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=864 bulkscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202090101
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/8/22 11:03 PM, Kumar Kartikeya Dwivedi wrote:
> When both bpf_spin_lock and bpf_timer are present in a BPF map value,
> copy_map_value needs to skirt both objects when copying a value into and
> out of the map. However, the current code does not set both s_off and
> t_off in copy_map_value, which leads to a crash when e.g. bpf_spin_lock
> is placed in map value with bpf_timer, as bpf_map_update_elem call will
> be able to overwrite the other timer object.
> 
> When the issue is not fixed, an overwriting can produce the following
> splat:
> 
> [root@(none) bpf]# ./test_progs -t timer_crash
> [   15.930339] bpf_testmod: loading out-of-tree module taints kernel.
> [   16.037849] ==================================================================
> [   16.038458] BUG: KASAN: user-memory-access in __pv_queued_spin_lock_slowpath+0x32b/0x520
> [   16.038944] Write of size 8 at addr 0000000000043ec0 by task test_progs/325
> [   16.039399]
> [   16.039514] CPU: 0 PID: 325 Comm: test_progs Tainted: G           OE     5.16.0+ #278
> [   16.039983] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ArchLinux 1.15.0-1 04/01/2014
> [   16.040485] Call Trace:
> [   16.040645]  <TASK>
> [   16.040805]  dump_stack_lvl+0x59/0x73
> [   16.041069]  ? __pv_queued_spin_lock_slowpath+0x32b/0x520
> [   16.041427]  kasan_report.cold+0x116/0x11b
> [   16.041673]  ? __pv_queued_spin_lock_slowpath+0x32b/0x520
> [   16.042040]  __pv_queued_spin_lock_slowpath+0x32b/0x520
> [   16.042328]  ? memcpy+0x39/0x60
> [   16.042552]  ? pv_hash+0xd0/0xd0
> [   16.042785]  ? lockdep_hardirqs_off+0x95/0xd0
> [   16.043079]  __bpf_spin_lock_irqsave+0xdf/0xf0
> [   16.043366]  ? bpf_get_current_comm+0x50/0x50
> [   16.043608]  ? jhash+0x11a/0x270
> [   16.043848]  bpf_timer_cancel+0x34/0xe0
> [   16.044119]  bpf_prog_c4ea1c0f7449940d_sys_enter+0x7c/0x81
> [   16.044500]  bpf_trampoline_6442477838_0+0x36/0x1000
> [   16.044836]  __x64_sys_nanosleep+0x5/0x140
> [   16.045119]  do_syscall_64+0x59/0x80
> [   16.045377]  ? lock_is_held_type+0xe4/0x140
> [   16.045670]  ? irqentry_exit_to_user_mode+0xa/0x40
> [   16.046001]  ? mark_held_locks+0x24/0x90
> [   16.046287]  ? asm_exc_page_fault+0x1e/0x30
> [   16.046569]  ? asm_exc_page_fault+0x8/0x30
> [   16.046851]  ? lockdep_hardirqs_on+0x7e/0x100
> [   16.047137]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   16.047405] RIP: 0033:0x7f9e4831718d
> [   16.047602] Code: b4 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b3 6c 0c 00 f7 d8 64 89 01 48
> [   16.048764] RSP: 002b:00007fff488086b8 EFLAGS: 00000206 ORIG_RAX: 0000000000000023
> [   16.049275] RAX: ffffffffffffffda RBX: 00007f9e48683740 RCX: 00007f9e4831718d
> [   16.049747] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fff488086d0
> [   16.050225] RBP: 00007fff488086f0 R08: 00007fff488085d7 R09: 00007f9e4cb594a0
> [   16.050648] R10: 0000000000000000 R11: 0000000000000206 R12: 00007f9e484cde30
> [   16.051124] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [   16.051608]  </TASK>
> [   16.051762] ==================================================================
> 
> Fixes: 68134668c17f ("bpf: Add map side support for bpf timers.")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>   include/linux/bpf.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index fa517ae604ad..31a83449808b 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -224,7 +224,8 @@ static inline void copy_map_value(struct bpf_map *map, void *dst, void *src)
>   	if (unlikely(map_value_has_spin_lock(map))) {
>   		s_off = map->spin_lock_off;
>   		s_sz = sizeof(struct bpf_spin_lock);
> -	} else if (unlikely(map_value_has_timer(map))) {
> +	}
> +	if (unlikely(map_value_has_timer(map))) {
>   		t_off = map->timer_off;
>   		t_sz = sizeof(struct bpf_timer);
>   	}

Thanks for the patch. I think we have a bigger problem here with the 
patch. It actually exposed a few kernel bugs. If you run current 
selftests, esp. ./test_progs -j which is what I tried, you will observe
various testing failures. The reason is due to we preserved the timer or
spin lock information incorrectly for a map value.

For example, the selftest #179 (timer) will fail with this patch and
the following change can fix it.

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index d29af9988f37..3336d76cc5a6 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -961,10 +961,11 @@ static struct htab_elem *alloc_htab_elem(struct 
bpf_htab *htab, void *key,
                         l_new = ERR_PTR(-ENOMEM);
                         goto dec_count;
                 }
-               check_and_init_map_value(&htab->map,
-                                        l_new->key + round_up(key_size, 
8));
         }

+       check_and_init_map_value(&htab->map,
+                                l_new->key + round_up(key_size, 8));
+
         memcpy(l_new->key, key, key_size);
         if (percpu) {
                 size = round_up(size, 8);

Basically, the above clears new map value timer/spin_lock fields for 
*all* new items.

There are still some selftest failures due to this patch.
Could you run selftest, with necessary additional fixes, to ensure
all selftests passed?
