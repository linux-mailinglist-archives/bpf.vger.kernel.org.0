Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A88F306A00
	for <lists+bpf@lfdr.de>; Thu, 28 Jan 2021 02:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhA1BMM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jan 2021 20:12:12 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1752 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231720AbhA1BHF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 Jan 2021 20:07:05 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10S15Zrr024611;
        Wed, 27 Jan 2021 17:06:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=b/Vt7uH1r+9DCLDkO5IRwG2/oigqCcSVXOYRWLiASC0=;
 b=f/FsIJOG0RlL+hhB/IURDTktbmVIAwg9zxK6GarFl49YrePx17xw3WAy6lSwNXcN3Flh
 JiZaWEvYMhs8naoAtfWk9lcr9VNfp19cleK46K68QtIUx8sODlIDxoSZJR5HLWIyXj+h
 Lul1fVVYmM4LKe+Q5vEyjvI54G4O1UYa+oQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36b7vwkw8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Jan 2021 17:06:00 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 27 Jan 2021 17:05:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqAwaZzhpO5F6b+5wT/wPDjXSD/wH5Pa0ma1M2U2+6/qQAud3zAFJPUf1LyvVyEdQyVx1Q3cW9IudMNQRhCEqR+o1XEVu5KYUjUroJbnJVCtboTuy/Z9vjFAxcRR/4AuOWAbFX/PNl/0/UdoV9FvX7fz45jwmCd4K7QQHtStveQ+epg0DpFKm6V4g+MkwGXHoQ5qD5ke6ClqFjlybT2/O8rlf7f9ZvNYifJPiu4VrjGoOdbEWZPyRb/YOwunhyOMBoecFWGKcCrnzl77ElQyDm5AhCbOmGi3OcCRKOjcxLl2xzN9vuE6bHJZPAfeeRdjTvn18o7VLsNiDdFttptlWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/Vt7uH1r+9DCLDkO5IRwG2/oigqCcSVXOYRWLiASC0=;
 b=hGK+zApcbBspvuYXvhsxafzxEEBAvC8Lad/gYj5yThLxIz5ufUn2t6SzfkUFJMdpH8wZj71P/zft3geOLEIkVJ4OCaqGR6w5bqGLzE7IWs2Hv5Vge9TNp5EAo+bCVifwegQkg23yrBQkbvgQBo77s4OGbndPdPNddA8yFo45tS8QGkMDYt/Rp7YEiIhDtYAA/Sj8FB5LH1+02Pr/YrEWNqIEjdu8RtkMNtJXxL0UE6MDYjLrFQBHbDY5YQkZjLzZLBD9xkSsgng1o4CVI4dcb1ESltHiWnGJviPNg8cbJciNhFZPLRC3ROoLmIQIMUKbMcYUIoIUVBpZTbd5DAN9gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/Vt7uH1r+9DCLDkO5IRwG2/oigqCcSVXOYRWLiASC0=;
 b=UbdInPca7xSdiWl4t3GF7Q8WznOrHv4fXU64FhF+YrKDWT48vSil+TIg6j2Z0zdf2tBTn6UKaTSiqN0QIVDMPlE1VDWfDE3MSmytEmlut7sRzqP8yQ1J6plx9qJAS1fMuBK1SJV80rPwnWgXjCXAtmxGu2t8Seab4XUHE0xFvpE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2837.namprd15.prod.outlook.com (2603:10b6:a03:f9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Thu, 28 Jan
 2021 01:05:58 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3805.017; Thu, 28 Jan 2021
 01:05:58 +0000
Subject: Re: [PATCH bpf] x86/bpf: handle bpf-program-triggered exceptions
 properly
To:     Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        KP Singh <kpsingh@kernel.org>
References: <20210126001219.845816-1-yhs@fb.com>
 <CALCETrX157htkCF81zb+5BBo9C_V39YNdt7yXRcFGGw_SRs02Q@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <92a66173-6512-f1bc-0f9a-530c6c9a1ef0@fb.com>
Date:   Wed, 27 Jan 2021 17:05:54 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <CALCETrX157htkCF81zb+5BBo9C_V39YNdt7yXRcFGGw_SRs02Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:ff08]
X-ClientProxiedBy: CO1PR15CA0082.namprd15.prod.outlook.com
 (2603:10b6:101:20::26) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1965] (2620:10d:c090:400::5:ff08) by CO1PR15CA0082.namprd15.prod.outlook.com (2603:10b6:101:20::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Thu, 28 Jan 2021 01:05:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 634c3893-76a0-4e61-ae93-08d8c328defa
X-MS-TrafficTypeDiagnostic: BYAPR15MB2837:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB28375E201FA80831C4299690D3BA9@BYAPR15MB2837.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 47mNKfQ6PCjbzfoI4Dtvx98t5xR7xEUE9iphjlNZ7PAxVoWcGxDw3E9mHQR3spi/iBnqVme0w21eCzM04ie2PCGU+04byBf+e5AMhI4PfypX9p6ThwukCiixKgxau4KOdFuUvkLusvTQRPrr3eN3ozv47UqJFEcWhjiWJFHLPLdJzQ05GbiIFIfFoHaeJ/I0UblfBxu9/YOR/JYcI1LGow9//FI/lzPqPMl/U96aSE1HDb2SsNIijRQyvc+zm51t1ciYlpll7SsdWTJebduWXjHIt0QbLA/VA1H1ZQUXK0B30uAIej2OdJUkfH6e1QtqzryFW8B737wo5RPlNk/fZXKoGdQEzW63GiUfS1OweNmqsD0Fe3mZMIOfum1n+fxzLb268Eim1OMQXf33c3LsAF7YRQQvRJGkYdmGJHcXEegeTH/EfOqIrdGPnWVtNTS75V2tAmX0cI0cUMVtzxxbAcI94lRnATnL4VxnoozRWwria93ZuQAg2ri1kgxYagsMOnX7lOonjO31Jw6tK3W+lK8LvvP4gpNoINB7tWvT/epX7GQVl+DTclCEpK/YloayOL+umtiVIP1P2gXFKWXblvgg1HPohdr9rf4rbSC4+2wciiQ42OwOxrzCCpXQ9mkSrY7Yac1p42HWHTPaCaL3wrTUyb5oLGqdIJLoZqbx7otfpIbuQw8nlj226rYCJg70
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(366004)(346002)(136003)(66946007)(5660300002)(4326008)(110136005)(2906002)(52116002)(6636002)(6486002)(54906003)(66556008)(86362001)(6666004)(8936002)(186003)(8676002)(16526019)(53546011)(66476007)(36756003)(2616005)(31686004)(478600001)(83380400001)(31696002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VCtQclZEVTVYUEVqV0F3Vk02MjRvMjc1bks0eDNxMzRHazc5OGRnTVBGRGdW?=
 =?utf-8?B?YkxsRWhoZEdNZVZnQkNGZUNwVWV1QVFXbTJGV1M1S1k2SWhoUTh5OGFmWU1k?=
 =?utf-8?B?SUppOVRDRkl2Q3pnV2hMaVhJRFQ3WjZBdldlbytwNkJpU3hWdXRMSGgxZ2hz?=
 =?utf-8?B?Y2RqdEN0cUtKdkxNc1pjNGsrU1BJOWNNZjltRjdsYlJhMXVNLzlWVndZT0Fu?=
 =?utf-8?B?Nm5YL2JZVjdLSWpmbnRjNjhWd0t3TG9WenlkMG1yZkxqV0FJU0hPd3haWnRr?=
 =?utf-8?B?ZFZzVnI3cENVOUkzMUpEQkJ1R1pld0NiN29DQU1GREI0cUNqUGFOYmpvbVdx?=
 =?utf-8?B?Rm50OXdJSkdRWTdVR05kb0VwNWo5UDBiNnJsVFVSV3lLeVZoYTU4ZzJVckhF?=
 =?utf-8?B?ZGNERGNodnVEUUd4TlBuaHVEdGd4MGlPZk5DaGdHaWRsNUx3QXdNM1p2TnRL?=
 =?utf-8?B?TU82ZDhMRG9FUEVCZyt4MXhlOWtSMlRzRmtJbERtcGZRUGhqSm5KanRCREcv?=
 =?utf-8?B?N2NidElsbENJSEpzUnBmREZIWU1ucEY2THFzUk1wVW1FQW93RnNkZlVlYXBp?=
 =?utf-8?B?QWxNNmJhMXJCcndtT2s3Y1hHTmVOVitlWVI0MWUwRGowK3VoSmVLbzVlS3k4?=
 =?utf-8?B?YnA3dEZQcENrZ1d0UGJ5ZXBUZkRYWFFXMWsxVjcxdGh4azV0QlBYcVBHUXo5?=
 =?utf-8?B?dXJ5NUcxZy9QTE1GNVhOejJRVWduNWgzZHJkZGxOUkhVRWNQMEc2MU9sZStO?=
 =?utf-8?B?OUc1eExtWitURUw5RW9GbHpkdlhOaG80N2VRQ1VPd0FxcWNYVitrdmJGSlUy?=
 =?utf-8?B?RXZ3aW1YQk5haDJVQThUTlRNNEFyWkVJSVVzZjdPQkdHTFhWZC9hRGtTdTFj?=
 =?utf-8?B?TnlEUERnWHdwTTZzMlYwNmZHTkduUDhyZURqVW1GRkZ6Vmxpc1NEYS8vRlI2?=
 =?utf-8?B?akErbjFVeU9uVmo1amtGMGlsK2U4RGhLQy9kYWVaaEQ2bkF3N0hTblo0THFv?=
 =?utf-8?B?VmRpS3J4OTVMMng1dEphZUN5eTVINEY2bjRUUjhlNFpPL01udGFoV3V4M29Y?=
 =?utf-8?B?OG8wYnlCbWlEc3ZYa2Z1Z2YwV1N3TWlHVzB4Y3dqS0g3TjJIZlRVcDREZEZC?=
 =?utf-8?B?MzF6M1cxTmtrb0E3REI0ZnhhV0tTdmw1bWJOU0dMb1pwWllGeFh1VlJ5MGFn?=
 =?utf-8?B?RnhsbzUwZ0l1RlV5NVcxckRNMkF3OHpSVi8rajEwYS84cEIwRjhseWhvSkM5?=
 =?utf-8?B?Q0tjZko2T09NdnRjMWlFYnhETjNHOUpGa0x2RzJnVHI0MzAxTUtWeDA4MGY3?=
 =?utf-8?B?NnM0b1B3ckhzTU8ybjE4TmhwRm9GSkg4czB0RGFJUXNCMFB2VEdRbDArdUhB?=
 =?utf-8?B?dmxLN1J0bWpDcW41SkprMkZHbzdIenN5Rk95MjA5UkFvRGV0ejFEZUR0SHFv?=
 =?utf-8?B?Z3E0cExOclozcTVkc0M3dTg5SnlTamFrekRFUDc5MEZ1QVNPR1NxSHI4RVVN?=
 =?utf-8?Q?phj1wc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 634c3893-76a0-4e61-ae93-08d8c328defa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 01:05:58.2382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6YkFyNXJw6oMucs5Qkac8bHUFzzFbsiEcSTlZrIYiT7q4arISSxnIpVDkBPmfrR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2837
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-27_10:2021-01-27,2021-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1011
 mlxlogscore=999 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280003
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/27/21 1:47 PM, Andy Lutomirski wrote:
> On Mon, Jan 25, 2021 at 4:12 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> When reviewing patch ([1]), which adds a script to run bpf selftest
>> through qemu at /sbin/init stage, I found the following kernel bug
>> warning:
>>
>> [  112.118892] BUG: sleeping function called from invalid context at arch/x86/mm/fault.c:1351
>> [  112.119805] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 354, name: new_name
>> [  112.120512] 3 locks held by new_name/354:
>> [  112.120868]  #0: ffff88800476e0a0 (&p->lock){+.+.}-{3:3}, at: bpf_seq_read+0x3a/0x3d0
>> [  112.121573]  #1: ffffffff82d69800 (rcu_read_lock){....}-{1:2}, at: bpf_iter_run_prog+0x5/0x160
>> [  112.122348]  #2: ffff8880061c2088 (&mm->mmap_lock#2){++++}-{3:3}, at: exc_page_fault+0x1a1/0x640
>> [  112.123128] Preemption disabled at:
>> [  112.123130] [<ffffffff8108f913>] migrate_disable+0x33/0x80
>> [  112.123942] CPU: 0 PID: 354 Comm: new_name Tainted: G           O      5.11.0-rc4-00524-g6e66fbb
>> 10597-dirty #1249
>> [  112.124822] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-1.el7.centos 04/01
>> /2014
>> [  112.125614] Call Trace:
>> [  112.125835]  dump_stack+0x77/0x97
>> [  112.126137]  ___might_sleep.cold.119+0xf2/0x106
>> [  112.126537]  exc_page_fault+0x1c1/0x640
>> [  112.126888]  asm_exc_page_fault+0x1e/0x30
>> [  112.127241] RIP: 0010:bpf_prog_0a182df2d34af188_dump_bpf_prog+0xf5/0xb3c
>> [  112.127825] Code: 00 00 8b 7d f4 41 8b 76 44 48 39 f7 73 06 48 01 fb 49 89 df 4c 89 7d d8 49 8b
>> bd 20 01 00 00 48 89 7d e0 49 8b bd e0 00 00 00 <48> 8b 7f 20 48 01 d7 48 89 7d e8 48 89 e9 48 83 c
>> 1 d0 48 8b 7d c8
>> [  112.129433] RSP: 0018:ffffc9000035fdc8 EFLAGS: 00010282
>> [  112.129895] RAX: 0000000000000000 RBX: ffff888005a49458 RCX: 0000000000000024
>> [  112.130509] RDX: 00000000000002f0 RSI: 0000000000000509 RDI: 0000000000000000
>> [  112.131126] RBP: ffffc9000035fe20 R08: 0000000000000001 R09: 0000000000000000
>> [  112.131737] R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000400
>> [  112.132355] R13: ffff888006085800 R14: ffff888004718540 R15: ffff888005a49458
>> [  112.132990]  ? bpf_prog_0a182df2d34af188_dump_bpf_prog+0xc8/0xb3c
>> [  112.133526]  bpf_iter_run_prog+0x75/0x160
>> [  112.133880]  __bpf_prog_seq_show+0x39/0x40
>> [  112.134258]  bpf_seq_read+0xf6/0x3d0
>> [  112.134582]  vfs_read+0xa3/0x1b0
>> [  112.134873]  ksys_read+0x4f/0xc0
>> [  112.135166]  do_syscall_64+0x2d/0x40
>> [  112.135482]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> To reproduce the issue, with patch [1] and use the following script:
>>    tools/testing/selftests/bpf/run_in_vm.sh -- cat /sys/fs/bpf/progs.debug
>>
>> The reason of the above kernel warning is due to bpf program
>> tries to dereference an address of 0 and which is not caught
>> by bpf exception handling logic.
>>
>> ...
>> SEC("iter/bpf_prog")
>> int dump_bpf_prog(struct bpf_iter__bpf_prog *ctx)
>> {
>>          struct bpf_prog *prog = ctx->prog;
>>          struct bpf_prog_aux *aux;
>>          ...
>>          if (!prog)
>>                  return 0;
>>          aux = prog->aux;
>>          ...
>>          ... aux->dst_prog->aux->name ...
>>          return 0;
>> }
>>
>> If the aux->dst_prog is NULL pointer, a fault will happen when trying
>> to access aux->dst_prog->aux.
>>
> 
> Which would be a bug in the bpf verifier, no?  This is a bpf program
> that apparently passed verification, and it somehow dereferenced a
> NULL pointer.
> 
> Let's enumerate some cases.
> 
> 1. x86-like architecture, SMAP enabled.  The CPU determines that this
> is bogus, and bpf gets lucky, because the x86 code runs the exception
> handler instead of summarily OOPSing.  IMO it would be entirely
> reasonable to OOPS.
> 
> 2 x86-like architecture, SMAP disabled.  This looks like a valid user
> access, and for all bpf knows, 0 might be an actual mapped address,
> and it might have userfaultfd attached, etc.  And it's called from a
> non-sleepable context.  The warning is entirely correct.
> 
> 3. s390x-like architecture.  This is a dereference of a bad kernel
> pointer.  OOPS, unless you get lucky.
> 
> 
> This patch is totally bogus.  You can't work around this by some magic
> exception handling.  Unless I'm missing something big, this is a bpf
> bug.  The following is not a valid kernel code pattern:
> 
> label:
>    dereference might-be-NULL kernel pointer
> _EXHANDLER_...(label, ...); /* try to recover */
> 
> This appears to have been introduced by:
> 
> commit 3dec541b2e632d630fe7142ed44f0b3702ef1f8c
> Author: Alexei Starovoitov <ast@kernel.org>
> Date:   Tue Oct 15 20:25:03 2019 -0700
> 
>      bpf: Add support for BTF pointers to x86 JIT
> 
> Alexei, this looks like a very long-winded and ultimately incorrect
> way to remove the branch from:
> 
> if (ptr)
>    val = *ptr;
> 
> Wouldn't it be better to either just emit the branch directly or to
> make sure that the pointer is valid in the first place?

Let me explain the motivation for this patch.

Previously, for any kernel data structure access,
people has to use bpf_probe_read() or bpf_probe_read_kernel()
helper even most of these accesses are okay and will not
fault. For example, for
    int t = a->b->c->d
three bpf_probe_read() will be needed, e.g.,
    bpf_probe_read_kernel(&t1, sizeof(t1), &a->b);
    bpf_probe_read_kernel(&t2, sizeof(t2), &t1->c);
    bpf_probe_read_kernel(&t, sizeof(t), &t2->d);

if there is a fault, bpf_probe_read_kernel() helper will
suppress the exception and clears the dest buffer and
return.

The above usage of bpf_probe_read_kernel()
is complicated and not C like and bpf developers
does not like it.

bcc (https://github.com/iovisor/bcc/) permits
users to write "a->b->c->d" styles and then through
clang rewriter to convert it to a series of
bpf_probe_read_kernel()'s. But most users are
directly using clang to compile their programs so
they have to write bpf_probe_read_kernel()'s
by themselves.

The motivation here is to improve user experience so
user can just write
    int t = a->b->c->d
some kernel will automatically take care of exceptions
and maintain bpf_probe_read_kernel() semantics.
So what the above patch essentially did is to check if the "regs->ip"
is one of ips which try to a "bpf_probe_read_kernel()" (actually
a direct access), it will fix up exception (clear the dest register)
and returns.

For a->b->c->d, some users may add "if (ptr) check"
for some of them and if that is the
case, compiler/verifier will honor that. Some users
may not add if they are certain from code that in most
or all cases, pointer will not be null. From verifier
perspective, it will be hard to decide whether
a->b, a->b->c is null or not, adding null checks
to every kernel de-references might be excessive. Also,
not 100% sure whether with null check, the pointer
dereference will absolutely not produce fault or not.
If there is no such guarantee then bpf_probe_read_kernel()
will be still needed.

I see page fault handler specially processed page fault for
kprobe and vsyscall. maybe page faults generated by special
bpf insns (simulating bpf_probe_read_kernel()) can also
be specially processed here.

> 
> --Andy
> 
