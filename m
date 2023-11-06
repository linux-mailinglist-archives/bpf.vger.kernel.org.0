Return-Path: <bpf+bounces-14337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B61647E3090
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 00:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17498B20B68
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 23:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078EF2EB08;
	Mon,  6 Nov 2023 23:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H8d4xDq7"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988FD14F9B;
	Mon,  6 Nov 2023 23:03:38 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B27D75;
	Mon,  6 Nov 2023 15:03:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fn+jK1M+Bcf0NcIeMv6nFhtZ31En/NrHWLcocQLv2k6d7wqFmoo7YbdAU4ZgyWOmz7Kut0JYYn8ZUmrsK1AVAUz2dXI1i6Ib/or6OEXSfI0CRrbzM2MptBxNIQES5dwhvvsk3iAxuQ/W/mbJ8SYpWtfXxohTFUhPsxLDTLT1t0u7aBaml36ZvUpFR7At5hq4XonfPMdLGrxKagj+9Svnjc4VCLqw00VUMidF+fsKERFK5RooSEwSvnxKL0L/NxYSC+GjxxVJQe1xuAIXf/oM8WeBrMURyrPupV1JDjyfb2TQ66ZqaEf/l4DtFWZfNw7OiFrkQaKVtjcWaigzUwChRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58eSutMnVXSn4DZ2Sj1tkPQnTL/2jcKf6sH7D/SPVIM=;
 b=kwg9B1ZmUD+DQ5VTV4EeaSWUTrjEGyJlDjM/wW8EhsvykfowbQ9NJ0XbUbXbtaV43EdBiBg3FRVyG55BsU5jE6KiCX2bkAJQK+TkD6qbJXZJvvq0SEDJdmsxEeSzXfnzM5A+L+98B+mbMBCeC/meR4nTVow93RngAdmr6rIiTwhxyqX+oHSqaxrOls+jkwoSAr986hBHiRggPgSvdy2mfb3/URgi8C0puCO/tZrouHUqgn0LUdIIbeCTCN6bZlUbA7HbT288yzhJh/sDJA8SQOzGwpSHxin0hpXZxqqlHYxsnWHar84yEJScVejtUVE74Hp/57k9w1Xtdl15TCdqag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58eSutMnVXSn4DZ2Sj1tkPQnTL/2jcKf6sH7D/SPVIM=;
 b=H8d4xDq7tn+1AQ7vyw3WbbIvhUeCwLcOjks23hV7g4jG5h7vfOb6yHyK8et6ey8wPs/WEb/kqN56sBs4fpT6RTXUIFAZTQFD/2h6ZdVExdP9AsDfkG1IN236mAy4V08P5pdnIa1lbpk/WL8wzDKdBIljO+mriFX9gH+lztVCXRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 23:03:34 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c%2]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 23:03:34 +0000
Message-ID: <e3085c47-7452-4302-8401-1bda052a3714@amd.com>
Date: Mon, 6 Nov 2023 15:03:31 -0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
Subject: BPF/XDP: kernel panic when removing an interface that is an
 xdp_redirect target
To: Jesper Dangaard Brouer <hawk@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:a03:255::29) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MN2PR12MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba9daf8-1b79-4726-5a94-08dbdf1c9a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jT4dGAHor2UGZq94ZSXLgoepx6DtqlGM7pXGnctKJvpwPlmfK2iv644zTJLl5OYMG45DrxTKiHgIqYUiZK4MTGWqW6d95m8s4Ak72yrSM/PWxRFKbbTLoStuWslUDd/tA7AhNwRi4Myv+h5FP33mEOx3PQwMAwKIBVqEO4iw1osek0dDfsOG1dTEbESJBzbuUwy0Bhg4mEhvH18xBw4UfIr3brG02LjrFqSpnrTuMLx8995gS3Jul9FyTiwE3WYrstKFAH3LUIBJXv7SfMSFncP01mNFf3ayjSPr2B/xGKGxFAFWKaSUkfTQAbw0l2WLVuZ8huEQoK40cGxS70MtfJ36WMjB3wzMHySZ3pKE/tuRStivuGyn2SyyQSSMnruxlPuzCjwE+qbjBUAFQolffytog/p6VfxO6E1zl235se488nXAHCBpRmaxdLlfW62PDwV25gxWvonmRZDR59hkc9YUTtZu/3x0QTJyEptQamiwDVXkUEDX+5QKvofE/ePNtqLyNiizqc7uRj+7WbkYgSyaSzGg0vkvLKjIzjMP5fH5J+hSCLNCTKDLcYIP024ie1M+tbwwCmeG+xxZGlJ3sDHty6eKKrQkovT63ECWgoeuZuc70D3NnEJjNb5mgVnXOrmmTqUxz5HZz8jC9aA4COPB7AxcnmX7ehh+uR3neNFA/X6gUo/SxzE+mayRSQ0G
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(39860400002)(346002)(230273577357003)(230173577357003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(316002)(8936002)(8676002)(36756003)(41300700001)(2906002)(38100700002)(5660300002)(31696002)(6486002)(66556008)(6512007)(66476007)(31686004)(86362001)(110136005)(66946007)(83380400001)(26005)(2616005)(45080400002)(6666004)(6506007)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WE9ibWNwdmFGQnZNV2hOMTBMS29iTkdKemt2clVIeVNac3pyVDJiSWdYQ2VR?=
 =?utf-8?B?Q3VoNEpCWGpuejdlUVhkYXhPRHFSL2tSc29salpQclBveWtBMHZsN2JxVnQ1?=
 =?utf-8?B?RnpYazVVSmVTTlVicWMyc21nQ2YxaHVpWk82eVgxRWtoWVVkSE1RWi96ZFN1?=
 =?utf-8?B?ZDdHWW5PZEVSOEE3cHVweWNPZFl0ZHpacVBWMWFrdUNaMjBLNG5DbDl6SXBk?=
 =?utf-8?B?eXdaSmtKUkJqNlhWMWVvbWdBTEhKZXRCYStkVDErK2VPUTFzWit1T3AyQTFU?=
 =?utf-8?B?VHQ4UU96VjRpYy9GcTdPVUZ0dTRuNW1MMGd2U0dEa2hCeDJFRG1CY04yQzlJ?=
 =?utf-8?B?d0tvODlNTHNQOXpYRTJkTzFjdnJOK2c2Kzk3QmpyU01DUkg1Y0dQKzVQQm8v?=
 =?utf-8?B?NEF4NnVuRE1GREFNT0xoL09xVGRjWmVRWGlwZDJLTnZudVNWYVB4cnZoUXc1?=
 =?utf-8?B?cENEOGNqWU9LYzYrSVlqTDlGQ3ZHUUc2ZzFDMG5GelhRUDZ3eW9YTElkTmkv?=
 =?utf-8?B?eWVXeFMyaCthL2l0b2d6SURKaUZPQ0JXZDlUSWY1TnZleERPNk56R2sxNGFn?=
 =?utf-8?B?TFRrN29jK0I2c1V3WkFwbXdsalVFaUt6eXdGMXFJSm9LN0h5clByN1NBWmZM?=
 =?utf-8?B?Vjc5bU1lMDVUTmhielR3bHNsdXM2VDBnWjlSdTJ3NlFtQUFUMGZwaFpmaEYw?=
 =?utf-8?B?Nm4vZVh0K3N0U3BGR2huUFpKS2dzd1ZVWWJtOHBuY0FtRzVibmhUeDNxbG02?=
 =?utf-8?B?UmJNVDlpOVA5WG9ZVGk1c1ZUcUJnR2t1TkcxaGRtNFpLUlFENTByb2ZwVWxk?=
 =?utf-8?B?eDUvNjdtNnRJbjFGeUJIa3hxVnNWV1dxOUZJdVNOVUxJY083ekV2TnFWYzMx?=
 =?utf-8?B?RTBRcFRtdGUxYjlPYm5nT0RVSC9vUFlvdDJaRytIZ0FJeDVmMGR4ek9xZkQ3?=
 =?utf-8?B?OThRc1EwdHBpOUFTVGd3LzNFZ3ZjemhBODE3dFlJZkh2VlVXaVN5RkpxVHhi?=
 =?utf-8?B?c1Nmdkx6RnYyaXo5OUowWnQ3YjkxRUo2d0tseVZJM2JrME1VZi80ajZiSS9J?=
 =?utf-8?B?emx0TDlxUTJIRnZWT2Zxc2NyeTlEcWZXVFllalB2b2QyYi8zckh3b3JId2x4?=
 =?utf-8?B?WFo4NVl0aHczY3NGbk1TWEFuRWllUG1JUW1vT3UyQ3haV3JRRlZJSW1NazZO?=
 =?utf-8?B?ZVptMU01WUtTallvblhQK2xFS0VFYVVWZ1RPUHpNaHQ5bFFqOE5wU0NSdzM5?=
 =?utf-8?B?dDU1VTdnLzA3bk9HbG1lejV1aDVJRWN1UU1QMld6eDl5R1BLSTY0Y0VEbzJz?=
 =?utf-8?B?SGdxN1BZMkl5dzJkd3FZUkxvMkMxNnlkeGhXWlhTV0ZhQlZLcjN6c3Q2a0Qv?=
 =?utf-8?B?SEZEQk5iZ1FrQ24zVXBVTVBsM01vVVJleG91amJNZjVtNVdsTm51TEdwMllR?=
 =?utf-8?B?QnJ6ZGhud1prWmxIWmZEYlc5V2I0UGRkSzNpWUZjT0dDK1RaTWd4UXpBenRY?=
 =?utf-8?B?MCtOYnNHSWFic0Y1UWdka0cyR1d5Rm1WMTNqeDJQSFlvSkhqdE5idWp3NWZ3?=
 =?utf-8?B?U0JxbmgwbjF2eHBnTTgrc2pxZ2JGMzhwdU1oK3NJRlRpd3NKS1JlajAybzU4?=
 =?utf-8?B?cHdFS0RNVkJiMmt5elExNVRBeDF0cGZsbFpOKzc3QWJXeDZJa3cwSnh6KzB1?=
 =?utf-8?B?VU0wMUdKQ21mQ1ZMMlR5MlNTelBhRFZrWnE5RURMbWhRMG5ObW1XeEpyMnJj?=
 =?utf-8?B?ZUpINDFsMnkyczczV1U5elhCZHlUT1UvTlI0STdFRlhUY3ZnUGRHUkdvbGgz?=
 =?utf-8?B?N2t5TmdnNFQ0RC9oN0laVGFQTktzY0M3QzZGeXFId2RkSUdKRFZjcStVK0o0?=
 =?utf-8?B?Rk1lZFI1dXRTNksvajRWWFplNnJzMHo0UnBRQlBUUFlyN2R2WWZMVGZxZWlE?=
 =?utf-8?B?UFljMmJIc0gzVDd2dVU3NUxqU0ZYbVdwZDQ2QzMxbmg4NU93YWJhN3oyUm1O?=
 =?utf-8?B?N1EzdHNxK3FEMkF2WkZhTlJCMk1Ic0dGOCtQb1lqeHVkSnRqWVJ6UW5IRGwx?=
 =?utf-8?B?ZER2TnlkaHlnd21NQWZqOGRmbDE1emJCSDd3aHdCL1pWb1lUT0RzY0JZQzIx?=
 =?utf-8?Q?IgKhLYbkmAmTf+0XZlv07CDvd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba9daf8-1b79-4726-5a94-08dbdf1c9a04
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 23:03:34.0542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Atvh9t1llpJuHJZ/3UTvdkCICk3M8AKeYjNYury+Fk48riu5dDteT7dOu4WZ/Dh4KfrBvFblq+RBHr0QOL/Hpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359

While testing new code to support XDP in the ionic driver we found that 
we could panic the kernel by running a bind/unbind loop on the target 
interface of an xdp_redirect action.  Obviously this is a stress test 
that is abusing the system, but it does point to a window of opportunity 
in bq_enqueue() and bq_xmit_all().  I believe that while the validity of 
the target interface has been checked in __xdp_enqueue(), the interface 
can be unbound by the time either bq_enqueue() or bq_xmit_all() tries to 
use the interface.  There is no locking or reference taken on the 
interface to hold it in place before the target’s ndo_xdp_xmit() is called.

Below is a stack trace that our tester captured while running our test 
code on a RHEL 9.2 kernel – yes, I know, unpublished driver code on a 
non-upstream kernel.  But if you look at the current upstream code in 
kernel/bpf/devmap.c I think you can see what we ran into.

Other than telling users to not abuse the system with a bind/unbind 
loop, is there something we can do to limit the potential pain here? 
Without knowing what interfaces might be targeted by the users’ XDP 
programs, is there a step the originating driver can do to take 
precautions?  Did we simply miss a step in the driver, or is this an 
actual problem in the devmap code?

Thanks,
sln

[ 6118.862868] general protection fault, probably for non-canonical 
address 0x696867666564659a: 0000 [#1] PREEMPT SMP NOPTI
[ 6118.863026] CPU: 2 PID: 0 Comm: swapper/2 Kdump: loaded Tainted: G 
   OE  -------- --- 5.14.0-284.11.1.el9_2.x86_64 #1
[ 6118.863335] Hardware name: HPE ProLiant DL320 Gen11/ProLiant DL320 
Gen11, BIOS 1.30 03/01/1023
[ 6118.863515] RIP: 0010:bq_xmit_all+0x8a/0x160
[ 6118.863704] Code: de 4c 89 f1 44 89 ea e8 b4 fc ff ff 89 c6 85 c0 0f 
84 af 00 00 00 49 8b 86 d0 00 00 00 44 89 f9 48 89 da 4c 89 f7 89 74 24 
04 <48> 8b 80 38 02 00 00 ff d0 0f 1f 00 31 c9 8b 74 24 04 85 c0 41 89
[ 6118.864137] RSP: 0018:ff733629002d8e50 EFLAGS: 00010246
[ 6118.864366] RAX: 6968676665646362 RBX: ffa53628f9ea47e8 RCX: 
0000000000000001
[ 6118.864608] RDX: ffa53628f9ea47e8 RSI: 0000000000000010 RDI: 
ff1fa0f2a46c8000
[ 6118.864859] RBP: ffa53628f9ea47f0 R08: ffffffffc082e700 R09: 
ffffffffffffffff
[ 6118.865114] R10: 0000000000000040 R11: 0000000000000003 R12: 
0000000000000010
[ 6118.865380] R13: 0000000000000010 R14: ff1fa0f2a46c8000 R15: 
0000000000000001
[ 6118.865648] FS: 0000000000000000(0000) GS:ff1fa0f5af280000(0000) 
knlGS:0000000000000000
[ 6118.865928] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6118.866213] CR2: 0000557586bae5e6 CR3: 000000001d410004 CR4: 
0000000000771ee0
[ 6118.866509] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 6118.866811] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 
0000000000000400
[ 6118.867117] PKRU: 55555554
[ 6118.867423] Call Trace:
[ 6118.867731] <IRQ>
[ 6118.868040] __dev_flush+0x39/0xa0
[ 6118.868358] xdp_do_flush+0xa/0x20
[ 6118.868681] ionic_txrx_napi+0x1ba/0x1f0 [ionic]
[ 6118.869024] __napi_poll+0x27/0x170
[ 6118.869357] net_rx_action+0x233/0x2f0
[ 6118.869693] __do_softirq+0xc7/0x2ac
[ 6118.870037] __irq_exit_rcu+0xb5/0xe0
[ 6118.870383] common_interrupt+0x80/0xa0
[ 6118.870735] </IRQ>
[ 6118.871082] <TASK>
[ 6118.871431] asm_common_interrupt+0x22/0x40
[ 6118.871790] RIP: 0010:cpuidle_enter_state+0xd2/0x400
[ 6118.872162] Code: 49 89 c5 0f 1f 44 00 00 31 ff e8 f9 a9 8e ff 45 84 
ff 74 12 9c 58 f6 c4 02 0f 85 12 03 00 00 31 ff e8 72 b7 94 ff fb 45 85 
f6 <0f> 88 15 01 00 00 49 63 d6 4c 2b 2c 24 48 8d 04 52 48 8d 04 82 49
[ 6118.872962] RSP: 0018:ff7336290010fe80 EFLAGS: 00000206
[ 6118.873377] RAX: ff1fa0f5af2aabc0 RBX: 0000000000000003 RCX: 
000000000000001f
[ 6118.873804] RDX: 0000000000000000 RSI: 0000000055555555 RDI: 
0000000000000000
[ 6118.874236] RBP: ffa53628faaa4400 R08: 00000590a8a55399 R09: 
0000000000000001
[ 6118.874752] R10: 0000000000000400 R11: 0000000000000730 R12: 
ffffffffbacace60
[ 6118.875282] R13: 00000590a8a55399 R14: 0000000000000003 R15: 
0000000000000000
[ 6118.875737] cpuidle_enter+0x29/0x40
[ 6118.876198] cpuidle_idle_call+0x12c/0x1c0
[ 6118.876664] do_idle+0x7b/0xe0
[ 6118.877132] cpu_startup_entry+0x19/0x20
[ 6118.877604] start_secondary+0x116/0x140
[ 6118.878081] secondary_startup_64_no_verify+0xe5/0xeb
[ 6118.878562] </TASK>
[ 6118.879104] Modules linked in: ionic(OE) ib_core tls 8021q garp mrp 
stp llc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet 
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat 
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables 
nfnetlink vfat fat ipmi_ssif intel_rapl_msr intel_rapl_common nfit 
libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel 
pmt_crashlog pmt_telemetry pmt_class kvm irqbypass rapl intel_cstate 
cdc_eem intel_uncore idxd usbnet acpi_ipmi mei_me isst_if_mbox_pci 
isst_if_mmio pcspkr isst_if_common intel_vsec mii idxd_bus mei hpilo 
ipmi_si ipmi_devintf ipmi_msghandler acpi_tad acpi_power_meter xfs 
libcrc32c sd_mod t10_pi sg mgag200 i2c_algo_bit drm_shmem_helper 
drm_kms_helper ahci syscopyarea sysfillrect sysimgblt libahci 
fb_sys_fops qat_4xxx drm libata crct10dif_pclmul crc32_pclmul intel_qat 
crc32c_intel tg3 ghash_clmulni_intel crc8 hpwdt wmi dm_mirror 
dm_region_hash dm_log dm_mod fuse [last unloaded: ionic]

