Return-Path: <bpf+bounces-5644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD8F75D050
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 19:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2C928238F
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 17:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C278F200B1;
	Fri, 21 Jul 2023 17:05:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FC427F00;
	Fri, 21 Jul 2023 17:05:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD4110CB;
	Fri, 21 Jul 2023 10:05:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Up9pNHXWT94sQC16fBFFKSN1EckbgxrISCIKUgV6wGHxfzihFLVRFhgz1KmjK8LHy91dESiWTSaGdVPDhhbbyBiPJaDmvgqlJH8+Xu3M9co1PYYF89U5lPoDcjrFXmidq/g6lwHmEFvK4BRGtsslzGmlcZRz9HctSK4ImyGOFkGoogp+Q4lJiVk4oD156P8QdJ8BaiDMzUYMC9J1F8weewj2MyyTbQ7KgmJZ7jL2x/23dP0/8N+cHhAbuqkld8j9lgzSqAbwPQxjuze3Z5Gwi6f1/U7659dCYj/kvGz7GWuJZ9ayoiPfP/NwSeEASLmliLBtRdYVQEn9xWyFVV9Img==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ev4POKeRC6KuoGYrwVyeENbsqOdD0OHM+JE/vdBlTck=;
 b=Q3RLoZr79H8bFSsMxhWbTUytIKDCySEhsYJjidVl7huepRx2BP8MuG1+22+/sOZxyr0rVRjlaMG/emw3aqBXycQ4ld/ZxtlX0D1J3hb5Z6JH9nnw72Pr9XdOMKxmRcVSuMHbWxJEbWNJOIDHaAzW7hYsShBPlUEkml99BWa+6wHLFgXIkKibSzusWfgHf0To4h1H61XWVgmezL2k3hj9XdJtP3z/ilbPalffde2t/5LSwaDSvYkFRMglbb0lHdFv9BRysm52jxjQxZPpkXszdT2UGxK72lboLK3uNw2mSNMASOrRlYaqf1MOPMZaPt/Dfmz3nYdvjBorFeQoumL2Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ev4POKeRC6KuoGYrwVyeENbsqOdD0OHM+JE/vdBlTck=;
 b=VQrhAaLnJ4mK6kXg2SJpYqufULDzFLDXyDgyCfigc3BjoehEAMcI20iK2mEcgbDr9UprjoQYwyBxOsklOxMkSpkl+ezzvuO0PelPmlAC2pe/P+AGKc4Xl7QY77wwA5cTIZnqLKK0WTGqY0o3Qc30GXxsR0Fu+C0QZRSQlkWbcWOauo/YaWXBHQ0FpuWWcm25Pse113HFSqaLULk0ubKlJlbrAxJUHR8d0YrCTHpOhbmg/1jxxvWxpw3TsEy1jo10rLvv0BOK/RwUBs/l+xvvYI1C5lNg+Zylq03tKeoIYyWAhXt877oPrZbVkdGJNMH6a/4c6IRafM0bjGLHpP+wXw==
Received: from DS7PR03CA0208.namprd03.prod.outlook.com (2603:10b6:5:3b6::33)
 by CY8PR12MB8066.namprd12.prod.outlook.com (2603:10b6:930:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 17:05:02 +0000
Received: from DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::df) by DS7PR03CA0208.outlook.office365.com
 (2603:10b6:5:3b6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Fri, 21 Jul 2023 17:05:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT093.mail.protection.outlook.com (10.13.172.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.28 via Frontend Transport; Fri, 21 Jul 2023 17:05:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 21 Jul 2023
 10:04:42 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 21 Jul
 2023 10:04:38 -0700
References: <20230719140858.13224-1-daniel@iogearbox.net>
 <20230719140858.13224-3-daniel@iogearbox.net>
User-agent: mu4e 1.8.11; emacs 28.2
From: Petr Machata <petrm@nvidia.com>
To: Daniel Borkmann <daniel@iogearbox.net>
CC: <ast@kernel.org>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<razor@blackwall.org>, <sdf@google.com>, <john.fastabend@gmail.com>,
	<kuba@kernel.org>, <dxu@dxuuu.xyz>, <joe@cilium.io>, <toke@kernel.org>,
	<davem@davemloft.net>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v6 2/8] bpf: Add fd-based tcx multi-prog infra
 with link support
Date: Fri, 21 Jul 2023 16:57:02 +0200
In-Reply-To: <20230719140858.13224-3-daniel@iogearbox.net>
Message-ID: <87a5vp6vrv.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT093:EE_|CY8PR12MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: a3efbd7e-d7cb-465b-3cb2-08db8a0c9f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y36aU1JAbDfFvGkX9JHxolsmQkgCP6Kh1KiNZqbmjNQkhwJFvpMigaxuKydIBxrEFr1EAZpOKxkY/Ax43nDBMrd7+WARVCNrXqnb4zR3DoIYMLoX9RdKyVfVrZvEiAt0ubGt6UPVnBB9EX81JpRsPz6wEXVV2PVAsSlhnmbJYB70S/R8n9NxLIZWnUZpHYVniPqEaxBcl2BCLxjBWftfLdTiMVFjjuJwEdig2dSGYbeLklsmRyxzNLrnj7jmd+OZzuoW3sIo8v+vJTcdeLQL5E6r1bJM7OhEtG1T1eQVCeDJucy0canuk+y4VWK6A44nROA/bTqG6e04X50U6O+Buc1lB7b0q99kT2JXXDQXVwqAIW0pKfaPTQNmKxBSXeKkYmfzYTDC9X0+jAJ2tljlhOq2ukJaVnJAtmI5XiFKJ2x7zNULy0PP2NKQEdLHlNfOHox+FWbk1FrZwFwMmFeEi6Cv0kOhhVxtM1KfIjMQdyzx1sNr670BopxIxzDyabEYw+oULZmd518vfQhe3uhW5LpTWcD43ewgie1SIY8x6ThglxpYKhlHa7QpWj77IQK921c1iQ6rYHJxl5NKz42AdvE/Gzt62zXLCrbb1rRtFTq7xRjU2A0jKr/zRcC+RrcqPNuQNTdwIY2K9htUiCv5QpotHVhzaaHOp7Fgs68CRUs+K4ykGkhEwqetyfMFCZrMpH0AUOPih2jxoeF1FIm7Yc6UpnjMnkJW60JLVzWHsPWj/fH94rGd+RQy3uJL2yoC
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(316002)(40460700003)(70206006)(70586007)(6916009)(4326008)(7636003)(356005)(6666004)(40480700001)(86362001)(30864003)(54906003)(478600001)(2906002)(82740400003)(36756003)(45080400002)(426003)(41300700001)(47076005)(2616005)(21480400003)(5660300002)(8936002)(8676002)(7416002)(186003)(336012)(16526019)(26005)(83380400001)(36860700001)(579004)(559001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 17:05:02.1716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3efbd7e-d7cb-465b-3cb2-08db8a0c9f80
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8066
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--=-=-=
Content-Type: text/plain

As of this patch (commit e420bed02507), TC qdisc installation and/or
removal cause memory access issues in the system.

A semi-minimal reproducer is:

    bash-5.2# ip l a name v1 type veth peer name v2
    bash-5.2# ip l s dev v1 up
    bash-5.2# ip l s dev v2 up
    bash-5.2# tc q a dev v1 ingress
    bash-5.2# tc q d dev v1 ingress
    bash-5.2# tc q a dev v1 ingress
    bash-5.2# tc q d dev v1 ingress

It's a bit finnicky, but only a little. For me, the first two "tc q"
operations never triggered a splat. Then it could take a few "tc q a"
"tc q d" iterations to get it to splat. So it looks like maybe the first
"tc q d" is the problematic bit? And then there's some likelihood of
failing on any following "tc q" operation. The above in particular
produced three warning splats for me (attached as decoded.txt,
decoded2.txt and decoded3.txt). Probing further:

    bash-5.2# tc q a dev v1 ingress

Produced two more splats from KASAN (decoded4.txt and decoded5.txt),
which look more serious.

Further attempts to prod the system deadlock it, I guess because RTNL
was left locked.

Reverting e420bed02507, and fe20ce3a5126 + 55cc3768473e that fail to
build without it, makes net-next/main work again.


--=-=-=
Content-Type: text/plain; name="decoded.txt"
Content-Disposition: inline; filename="decoded.txt"
Content-Description: decoded.txt

[  337.885866] ------------[ cut here ]------------
[  337.886351] ODEBUG: activate active (active state 1) object: ffff888008a7a000 object type: rcu_head hint: 0x0
[  337.887126] WARNING: CPU: 0 PID: 171 at lib/debugobjects.c:514 debug_print_object (/home/petr/src/linux_mlxsw/lib/debugobjects.c:514 (discriminator 2)) 
[  337.887813] Modules linked in: sch_ingress veth
[  337.888504] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
[  337.888996] RIP: 0010:debug_print_object (/home/petr/src/linux_mlxsw/lib/debugobjects.c:514 (discriminator 2)) 
[ 337.889324] Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 49 41 56 48 8b 14 dd 80 e3 61 83 4c 89 e6 48 c7 c7 e0 d6 61 83 e8 52 8b 2e ff <0f> 0b 58 83 05 9c b1 58 02 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e
All code
========
   0:	00 fc                	add    %bh,%ah
   2:	ff                   	(bad)
   3:	df 48 89             	fisttps -0x77(%rax)
   6:	fa                   	cli
   7:	48 c1 ea 03          	shr    $0x3,%rdx
   b:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   f:	75 49                	jne    0x5a
  11:	41 56                	push   %r14
  13:	48 8b 14 dd 80 e3 61 	mov    -0x7c9e1c80(,%rbx,8),%rdx
  1a:	83 
  1b:	4c 89 e6             	mov    %r12,%rsi
  1e:	48 c7 c7 e0 d6 61 83 	mov    $0xffffffff8361d6e0,%rdi
  25:	e8 52 8b 2e ff       	call   0xffffffffff2e8b7c
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	58                   	pop    %rax
  2d:	83 05 9c b1 58 02 01 	addl   $0x1,0x258b19c(%rip)        # 0x258b1d0
  34:	48 83 c4 18          	add    $0x18,%rsp
  38:	5b                   	pop    %rbx
  39:	5d                   	pop    %rbp
  3a:	41 5c                	pop    %r12
  3c:	41 5d                	pop    %r13
  3e:	41 5e                	pop    %r14

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	58                   	pop    %rax
   3:	83 05 9c b1 58 02 01 	addl   $0x1,0x258b19c(%rip)        # 0x258b1a6
   a:	48 83 c4 18          	add    $0x18,%rsp
   e:	5b                   	pop    %rbx
   f:	5d                   	pop    %rbp
  10:	41 5c                	pop    %r12
  12:	41 5d                	pop    %r13
  14:	41 5e                	pop    %r14
[  337.890435] RSP: 0018:ffffc9000009f1c8 EFLAGS: 00010286
[  337.890798] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
[  337.891213] RDX: ffff88800c8c9fc0 RSI: ffffffff813f13cb RDI: 0000000000000001
[  337.891639] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
[  337.892038] R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8361dd40
[  337.892460] R13: ffffffff834daf80 R14: 0000000000000000 R15: ffff8880093eee90
[  337.892865] FS:  00007f0089130740(0000) GS:ffff888036000000(0000) knlGS:0000000000000000
[  337.893339] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  337.893673] CR2: 000055958cefedc0 CR3: 000000000c0af001 CR4: 0000000000370ef0
[  337.894071] Call Trace:
[  337.894244]  <TASK>
[  337.894380] ? __warn (/home/petr/src/linux_mlxsw/kernel/panic.c:673) 
[  337.894585] ? debug_print_object (/home/petr/src/linux_mlxsw/lib/debugobjects.c:514 (discriminator 2)) 
[  337.894865] ? report_bug (/home/petr/src/linux_mlxsw/lib/bug.c:180 /home/petr/src/linux_mlxsw/lib/bug.c:219) 
[  337.895154] ? handle_bug (/home/petr/src/linux_mlxsw/arch/x86/kernel/traps.c:324 (discriminator 1)) 
[  337.895390] ? exc_invalid_op (/home/petr/src/linux_mlxsw/arch/x86/kernel/traps.c:345 (discriminator 1)) 
[  337.895628] ? asm_exc_invalid_op (/home/petr/src/linux_mlxsw/./arch/x86/include/asm/idtentry.h:568) 
[  337.895890] ? __warn_printk (/home/petr/src/linux_mlxsw/kernel/panic.c:712) 
[  337.896124] ? debug_print_object (/home/petr/src/linux_mlxsw/lib/debugobjects.c:514 (discriminator 2)) 
[  337.896414] ? debug_print_object (/home/petr/src/linux_mlxsw/lib/debugobjects.c:514 (discriminator 2)) 
[  337.896680] ? _raw_spin_unlock_irqrestore (/home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:42 /home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:77 /home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:135 /home/petr/src/linux_mlxsw/./include/linux/spinlock_api_smp.h:151 /home/petr/src/linux_mlxsw/kernel/locking/spinlock.c:194) 
[  337.896981] debug_object_activate (/home/petr/src/linux_mlxsw/lib/debugobjects.c:734) 
[  337.897274] ? debug_object_destroy (/home/petr/src/linux_mlxsw/lib/debugobjects.c:702) 
[  337.897559] ? mark_held_locks (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:4281 (discriminator 1)) 
[  337.897811] ? kvfree_call_rcu (/home/petr/src/linux_mlxsw/kernel/rcu/rcu.h:227 /home/petr/src/linux_mlxsw/kernel/rcu/tree.c:3359) 
[  337.898049] kvfree_call_rcu (/home/petr/src/linux_mlxsw/kernel/rcu/rcu.h:227 /home/petr/src/linux_mlxsw/kernel/rcu/tree.c:3359) 
[  337.898300] ? __tcf_block_put (/home/petr/src/linux_mlxsw/net/sched/cls_api.c:535 /home/petr/src/linux_mlxsw/net/sched/cls_api.c:530 /home/petr/src/linux_mlxsw/net/sched/cls_api.c:1301) 
[  337.898569] ingress_destroy (/home/petr/src/linux_mlxsw/net/sched/sch_ingress.c:131) sch_ingress
[  337.898877] ? clsact_init (/home/petr/src/linux_mlxsw/net/sched/sch_ingress.c:113) sch_ingress
[  337.899192] __qdisc_destroy (/home/petr/src/linux_mlxsw/net/sched/sch_generic.c:1065) 
[  337.899443] qdisc_destroy (/home/petr/src/linux_mlxsw/net/sched/sch_generic.c:1079) 
[  337.899669] qdisc_graft (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1134) 
[  337.899939] ? tc_dump_tclass (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1076) 
[  337.900248] tc_get_qdisc (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1541) 
[  337.900479] ? tc_ctl_tclass (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1475) 
[  337.900713] ? rtnetlink_rcv_msg (/home/petr/src/linux_mlxsw/net/core/rtnetlink.c:6421) 
[  337.901034] ? cap_capable (/home/petr/src/linux_mlxsw/security/commoncap.c:102) 
[  337.901384] ? lock_is_held_type (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:467 (discriminator 4) /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5833 (discriminator 4)) 
[  337.901641] ? tc_ctl_tclass (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1475) 
[  337.901902] rtnetlink_rcv_msg (/home/petr/src/linux_mlxsw/net/core/rtnetlink.c:6423) 
[  337.902196] ? rtnl_dump_ifinfo (/home/petr/src/linux_mlxsw/net/core/rtnetlink.c:6319) 
[  337.902478] ? lockdep_hardirqs_on_prepare (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5000) 
[  337.902797] ? lockdep_hardirqs_on_prepare (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5000) 
[  337.903101] ? find_held_lock (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5251 (discriminator 1)) 
[  337.903378] netlink_rcv_skb (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:2547) 
[  337.903626] ? rtnl_dump_ifinfo (/home/petr/src/linux_mlxsw/net/core/rtnetlink.c:6319) 
[  337.903902] ? netlink_ack (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:2523) 
[  337.904139] ? lock_sync (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5729) 
[  337.904409] ? netlink_deliver_tap (/home/petr/src/linux_mlxsw/./include/linux/rcupdate.h:308 /home/petr/src/linux_mlxsw/./include/linux/rcupdate.h:782 /home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:340) 
[  337.904679] ? is_vmalloc_addr (/home/petr/src/linux_mlxsw/mm/vmalloc.c:83) 
[  337.904933] netlink_unicast (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1340 /home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1365) 
[  337.905183] ? netlink_attachskb (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1350) 
[  337.905462] ? __sanitizer_cov_trace_switch (/home/petr/src/linux_mlxsw/kernel/kcov.c:340 (discriminator 1)) 
[  337.905778] ? __check_object_size (/home/petr/src/linux_mlxsw/mm/usercopy.c:113 /home/petr/src/linux_mlxsw/mm/usercopy.c:145 /home/petr/src/linux_mlxsw/mm/usercopy.c:254 /home/petr/src/linux_mlxsw/mm/usercopy.c:213) 
[  337.906050] netlink_sendmsg (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1911) 
[  337.906319] ? netlink_unicast (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1830) 
[  337.906615] ? netlink_unicast (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1830) 
[  337.906916] ____sys_sendmsg (/home/petr/src/linux_mlxsw/net/socket.c:728 (discriminator 1) /home/petr/src/linux_mlxsw/net/socket.c:748 (discriminator 1) /home/petr/src/linux_mlxsw/net/socket.c:2494 (discriminator 1)) 
[  337.907170] ? copy_msghdr_from_user (/home/petr/src/linux_mlxsw/net/socket.c:2420) 
[  337.907481] ? sock_read_iter (/home/petr/src/linux_mlxsw/net/socket.c:2440) 
[  337.907739] ? __lock_acquire (/home/petr/src/linux_mlxsw/./arch/x86/include/asm/bitops.h:228 /home/petr/src/linux_mlxsw/./arch/x86/include/asm/bitops.h:240 /home/petr/src/linux_mlxsw/./include/asm-generic/bitops/instrumented-non-atomic.h:142 /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:228 /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:3788 /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:3844 /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5144) 
[  337.908007] ___sys_sendmsg (/home/petr/src/linux_mlxsw/net/socket.c:2550) 
[  337.908275] ? do_recvmmsg (/home/petr/src/linux_mlxsw/net/socket.c:2537) 
[  337.908547] ? local_clock_noinstr (/home/petr/src/linux_mlxsw/kernel/sched/clock.c:301 (discriminator 1)) 
[  337.908810] ? __fget_light (/home/petr/src/linux_mlxsw/fs/file.c:1027) 
[  337.909080] __sys_sendmsg (/home/petr/src/linux_mlxsw/net/socket.c:2579) 
[  337.909343] ? __sys_sendmsg_sock (/home/petr/src/linux_mlxsw/net/socket.c:2565) 
[  337.909607] ? xfd_validate_state (/home/petr/src/linux_mlxsw/arch/x86/kernel/fpu/xstate.c:1411 /home/petr/src/linux_mlxsw/arch/x86/kernel/fpu/xstate.c:1455) 
[  337.909899] ? syscall_enter_from_user_mode (/home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:42 /home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:77 /home/petr/src/linux_mlxsw/kernel/entry/common.c:111) 
[  337.910245] do_syscall_64 (/home/petr/src/linux_mlxsw/arch/x86/entry/common.c:50 (discriminator 1) /home/petr/src/linux_mlxsw/arch/x86/entry/common.c:80 (discriminator 1)) 
[  337.910480] entry_SYSCALL_64_after_hwframe (/home/petr/src/linux_mlxsw/arch/x86/entry/entry_64.S:120) 
[  337.910813] RIP: 0033:0x7f008946a8b4
[ 337.911091] Code: 15 59 f5 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b5 0f 1f 00 f3 0f 1e fa 80 3d 2d 7d 0c 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
All code
========
   0:	15 59 f5 0b 00       	adc    $0xbf559,%eax
   5:	f7 d8                	neg    %eax
   7:	64 89 02             	mov    %eax,%fs:(%rdx)
   a:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  11:	eb b5                	jmp    0xffffffffffffffc8
  13:	0f 1f 00             	nopl   (%rax)
  16:	f3 0f 1e fa          	endbr64
  1a:	80 3d 2d 7d 0c 00 00 	cmpb   $0x0,0xc7d2d(%rip)        # 0xc7d4e
  21:	74 13                	je     0x36
  23:	b8 2e 00 00 00       	mov    $0x2e,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 4c                	ja     0x7e
  32:	c3                   	ret
  33:	0f 1f 00             	nopl   (%rax)
  36:	55                   	push   %rbp
  37:	48 89 e5             	mov    %rsp,%rbp
  3a:	48 83 ec 20          	sub    $0x20,%rsp
  3e:	89                   	.byte 0x89
  3f:	55                   	push   %rbp

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 4c                	ja     0x54
   8:	c3                   	ret
   9:	0f 1f 00             	nopl   (%rax)
   c:	55                   	push   %rbp
   d:	48 89 e5             	mov    %rsp,%rbp
  10:	48 83 ec 20          	sub    $0x20,%rsp
  14:	89                   	.byte 0x89
  15:	55                   	push   %rbp
[  337.912135] RSP: 002b:00007ffd615b18c8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  337.912598] RAX: ffffffffffffffda RBX: 000055958cf26f80 RCX: 00007f008946a8b4
[  337.913006] RDX: 0000000000000000 RSI: 00007ffd615b1940 RDI: 0000000000000003
[  337.913435] RBP: 00007ffd615b19b0 R08: 0000000064bab34a R09: 0000000000000001
[  337.913846] R10: 0000000000000001 R11: 0000000000000202 R12: 00007ffd615b1a30
[  337.914302] R13: 0000000064bab34b R14: 000055958cf26f80 R15: 0000000000000000
[  337.914793]  </TASK>
[  337.914929] irq event stamp: 167013
[  337.915150] hardirqs last enabled at (167021): __up_console_sem (/home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:42 /home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:77 /home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:135 /home/petr/src/linux_mlxsw/kernel/printk/printk.c:347 /home/petr/src/linux_mlxsw/kernel/printk/printk.c:339) 
[  337.915684] hardirqs last disabled at (167030): __up_console_sem (/home/petr/src/linux_mlxsw/kernel/printk/printk.c:345 (discriminator 3)) 
[  337.916182] softirqs last enabled at (166282): irq_exit_rcu (/home/petr/src/linux_mlxsw/kernel/softirq.c:427 /home/petr/src/linux_mlxsw/kernel/softirq.c:632 /home/petr/src/linux_mlxsw/kernel/softirq.c:644) 
[  337.916803] softirqs last disabled at (166245): irq_exit_rcu (/home/petr/src/linux_mlxsw/kernel/softirq.c:427 /home/petr/src/linux_mlxsw/kernel/softirq.c:632 /home/petr/src/linux_mlxsw/kernel/softirq.c:644) 
[  337.917302] ---[ end trace 0000000000000000 ]---

--=-=-=
Content-Type: text/plain; name="decoded2.txt"
Content-Disposition: inline; filename="decoded2.txt"
Content-Description: decoded2.txt

[  337.918159] ------------[ cut here ]------------
[  337.918626] ODEBUG: active_state active (active state 1) object: ffff888008a7a000 object type: rcu_head hint: 0x0
[  337.920604] WARNING: CPU: 0 PID: 171 at lib/debugobjects.c:514 debug_print_object (/home/petr/src/linux_mlxsw/lib/debugobjects.c:514 (discriminator 2)) 
[  337.921684] Modules linked in: sch_ingress veth
[  337.923119] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
[  337.924543] RIP: 0010:debug_print_object (/home/petr/src/linux_mlxsw/lib/debugobjects.c:514 (discriminator 2)) 
[ 337.925136] Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 49 41 56 48 8b 14 dd 80 e3 61 83 4c 89 e6 48 c7 c7 e0 d6 61 83 e8 52 8b 2e ff <0f> 0b 58 83 05 9c b1 58 02 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e
All code
========
   0:	00 fc                	add    %bh,%ah
   2:	ff                   	(bad)
   3:	df 48 89             	fisttps -0x77(%rax)
   6:	fa                   	cli
   7:	48 c1 ea 03          	shr    $0x3,%rdx
   b:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   f:	75 49                	jne    0x5a
  11:	41 56                	push   %r14
  13:	48 8b 14 dd 80 e3 61 	mov    -0x7c9e1c80(,%rbx,8),%rdx
  1a:	83 
  1b:	4c 89 e6             	mov    %r12,%rsi
  1e:	48 c7 c7 e0 d6 61 83 	mov    $0xffffffff8361d6e0,%rdi
  25:	e8 52 8b 2e ff       	call   0xffffffffff2e8b7c
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	58                   	pop    %rax
  2d:	83 05 9c b1 58 02 01 	addl   $0x1,0x258b19c(%rip)        # 0x258b1d0
  34:	48 83 c4 18          	add    $0x18,%rsp
  38:	5b                   	pop    %rbx
  39:	5d                   	pop    %rbp
  3a:	41 5c                	pop    %r12
  3c:	41 5d                	pop    %r13
  3e:	41 5e                	pop    %r14

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	58                   	pop    %rax
   3:	83 05 9c b1 58 02 01 	addl   $0x1,0x258b19c(%rip)        # 0x258b1a6
   a:	48 83 c4 18          	add    $0x18,%rsp
   e:	5b                   	pop    %rbx
   f:	5d                   	pop    %rbp
  10:	41 5c                	pop    %r12
  12:	41 5d                	pop    %r13
  14:	41 5e                	pop    %r14
[  337.926728] RSP: 0000:ffffc9000009f1c8 EFLAGS: 00010286
[  337.927123] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
[  337.927704] RDX: ffff88800c8c9fc0 RSI: ffffffff813f13cb RDI: 0000000000000001
[  337.928362] RBP: 0000000000000002 R08: 0000000000000001 R09: 0000000000000000
[  337.928930] R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8361db20
[  337.929541] R13: ffffffff834daf80 R14: 0000000000000000 R15: ffff8880093eee90
[  337.929977] FS:  00007f0089130740(0000) GS:ffff888036000000(0000) knlGS:0000000000000000
[  337.930495] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  337.930842] CR2: 00007fd15cc3d000 CR3: 000000000c0af001 CR4: 0000000000370ef0
[  337.931284] Call Trace:
[  337.931443]  <TASK>
[  337.931579] ? __warn (/home/petr/src/linux_mlxsw/kernel/panic.c:673) 
[  337.931801] ? debug_print_object (/home/petr/src/linux_mlxsw/lib/debugobjects.c:514 (discriminator 2)) 
[  337.932083] ? report_bug (/home/petr/src/linux_mlxsw/lib/bug.c:180 /home/petr/src/linux_mlxsw/lib/bug.c:219) 
[  337.932349] ? handle_bug (/home/petr/src/linux_mlxsw/arch/x86/kernel/traps.c:324 (discriminator 1)) 
[  337.932576] ? exc_invalid_op (/home/petr/src/linux_mlxsw/arch/x86/kernel/traps.c:345 (discriminator 1)) 
[  337.932816] ? asm_exc_invalid_op (/home/petr/src/linux_mlxsw/./arch/x86/include/asm/idtentry.h:568) 
[  337.933086] ? __warn_printk (/home/petr/src/linux_mlxsw/kernel/panic.c:712) 
[  337.933347] ? debug_print_object (/home/petr/src/linux_mlxsw/lib/debugobjects.c:514 (discriminator 2)) 
[  337.933616] ? debug_print_object (/home/petr/src/linux_mlxsw/lib/debugobjects.c:514 (discriminator 2)) 
[  337.933878] ? _raw_spin_unlock_irqrestore (/home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:42 /home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:77 /home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:135 /home/petr/src/linux_mlxsw/./include/linux/spinlock_api_smp.h:151 /home/petr/src/linux_mlxsw/kernel/locking/spinlock.c:194) 
[  337.934192] debug_object_active_state (/home/petr/src/linux_mlxsw/lib/debugobjects.c:993 /home/petr/src/linux_mlxsw/lib/debugobjects.c:954) 
[  337.934500] ? debug_stats_show (/home/petr/src/linux_mlxsw/lib/debugobjects.c:956) 
[  337.934763] ? mark_held_locks (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:4281 (discriminator 1)) 
[  337.935017] kvfree_call_rcu (/home/petr/src/linux_mlxsw/kernel/rcu/tree.c:3359 (discriminator 1)) 
[  337.935271] ? __tcf_block_put (/home/petr/src/linux_mlxsw/net/sched/cls_api.c:535 /home/petr/src/linux_mlxsw/net/sched/cls_api.c:530 /home/petr/src/linux_mlxsw/net/sched/cls_api.c:1301) 
[  337.935537] ingress_destroy (/home/petr/src/linux_mlxsw/net/sched/sch_ingress.c:131) sch_ingress
[  337.935852] ? clsact_init (/home/petr/src/linux_mlxsw/net/sched/sch_ingress.c:113) sch_ingress
[  337.936188] __qdisc_destroy (/home/petr/src/linux_mlxsw/net/sched/sch_generic.c:1065) 
[  337.936461] qdisc_destroy (/home/petr/src/linux_mlxsw/net/sched/sch_generic.c:1079) 
[  337.936694] qdisc_graft (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1134) 
[  337.936939] ? tc_dump_tclass (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1076) 
[  337.937287] tc_get_qdisc (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1541) 
[  337.937545] ? tc_ctl_tclass (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1475) 
[  337.937809] ? rtnetlink_rcv_msg (/home/petr/src/linux_mlxsw/net/core/rtnetlink.c:6421) 
[  337.938095] ? cap_capable (/home/petr/src/linux_mlxsw/security/commoncap.c:102) 
[  337.938360] ? lock_is_held_type (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:467 (discriminator 4) /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5833 (discriminator 4)) 
[  337.938620] ? tc_ctl_tclass (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1475) 
[  337.938883] rtnetlink_rcv_msg (/home/petr/src/linux_mlxsw/net/core/rtnetlink.c:6423) 
[  337.939320] ? rtnl_dump_ifinfo (/home/petr/src/linux_mlxsw/net/core/rtnetlink.c:6319) 
[  337.939726] ? lockdep_hardirqs_on_prepare (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5000) 
[  337.940217] ? lockdep_hardirqs_on_prepare (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5000) 
[  337.940749] ? find_held_lock (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5251 (discriminator 1)) 
[  337.941119] netlink_rcv_skb (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:2547) 
[  337.941659] ? rtnl_dump_ifinfo (/home/petr/src/linux_mlxsw/net/core/rtnetlink.c:6319) 
[  337.942060] ? netlink_ack (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:2523) 
[  337.942478] ? lock_sync (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5729) 
[  337.942825] ? netlink_deliver_tap (/home/petr/src/linux_mlxsw/./include/linux/rcupdate.h:308 /home/petr/src/linux_mlxsw/./include/linux/rcupdate.h:782 /home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:340) 
[  337.943338] ? is_vmalloc_addr (/home/petr/src/linux_mlxsw/mm/vmalloc.c:83) 
[  337.943667] netlink_unicast (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1340 /home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1365) 
[  337.943947] ? netlink_attachskb (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1350) 
[  337.944312] ? __sanitizer_cov_trace_switch (/home/petr/src/linux_mlxsw/kernel/kcov.c:340 (discriminator 1)) 
[  337.944706] ? __check_object_size (/home/petr/src/linux_mlxsw/mm/usercopy.c:113 /home/petr/src/linux_mlxsw/mm/usercopy.c:145 /home/petr/src/linux_mlxsw/mm/usercopy.c:254 /home/petr/src/linux_mlxsw/mm/usercopy.c:213) 
[  337.945042] netlink_sendmsg (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1911) 
[  337.945468] ? netlink_unicast (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1830) 
[  337.945748] ? netlink_unicast (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1830) 
[  337.945997] ____sys_sendmsg (/home/petr/src/linux_mlxsw/net/socket.c:728 (discriminator 1) /home/petr/src/linux_mlxsw/net/socket.c:748 (discriminator 1) /home/petr/src/linux_mlxsw/net/socket.c:2494 (discriminator 1)) 
[  337.946273] ? copy_msghdr_from_user (/home/petr/src/linux_mlxsw/net/socket.c:2420) 
[  337.946560] ? sock_read_iter (/home/petr/src/linux_mlxsw/net/socket.c:2440) 
[  337.946819] ? __lock_acquire (/home/petr/src/linux_mlxsw/./arch/x86/include/asm/bitops.h:228 /home/petr/src/linux_mlxsw/./arch/x86/include/asm/bitops.h:240 /home/petr/src/linux_mlxsw/./include/asm-generic/bitops/instrumented-non-atomic.h:142 /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:228 /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:3788 /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:3844 /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5144) 
[  337.947097] ___sys_sendmsg (/home/petr/src/linux_mlxsw/net/socket.c:2550) 
[  337.947372] ? do_recvmmsg (/home/petr/src/linux_mlxsw/net/socket.c:2537) 
[  337.947653] ? local_clock_noinstr (/home/petr/src/linux_mlxsw/kernel/sched/clock.c:301 (discriminator 1)) 
[  337.947909] ? __fget_light (/home/petr/src/linux_mlxsw/fs/file.c:1027) 
[  337.948164] __sys_sendmsg (/home/petr/src/linux_mlxsw/net/socket.c:2579) 
[  337.948417] ? __sys_sendmsg_sock (/home/petr/src/linux_mlxsw/net/socket.c:2565) 
[  337.948689] ? xfd_validate_state (/home/petr/src/linux_mlxsw/arch/x86/kernel/fpu/xstate.c:1411 /home/petr/src/linux_mlxsw/arch/x86/kernel/fpu/xstate.c:1455) 
[  337.948970] ? syscall_enter_from_user_mode (/home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:42 /home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:77 /home/petr/src/linux_mlxsw/kernel/entry/common.c:111) 
[  337.949300] do_syscall_64 (/home/petr/src/linux_mlxsw/arch/x86/entry/common.c:50 (discriminator 1) /home/petr/src/linux_mlxsw/arch/x86/entry/common.c:80 (discriminator 1)) 
[  337.949530] entry_SYSCALL_64_after_hwframe (/home/petr/src/linux_mlxsw/arch/x86/entry/entry_64.S:120) 
[  337.949836] RIP: 0033:0x7f008946a8b4
[ 337.950059] Code: 15 59 f5 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b5 0f 1f 00 f3 0f 1e fa 80 3d 2d 7d 0c 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
All code
========
   0:	15 59 f5 0b 00       	adc    $0xbf559,%eax
   5:	f7 d8                	neg    %eax
   7:	64 89 02             	mov    %eax,%fs:(%rdx)
   a:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  11:	eb b5                	jmp    0xffffffffffffffc8
  13:	0f 1f 00             	nopl   (%rax)
  16:	f3 0f 1e fa          	endbr64
  1a:	80 3d 2d 7d 0c 00 00 	cmpb   $0x0,0xc7d2d(%rip)        # 0xc7d4e
  21:	74 13                	je     0x36
  23:	b8 2e 00 00 00       	mov    $0x2e,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 4c                	ja     0x7e
  32:	c3                   	ret
  33:	0f 1f 00             	nopl   (%rax)
  36:	55                   	push   %rbp
  37:	48 89 e5             	mov    %rsp,%rbp
  3a:	48 83 ec 20          	sub    $0x20,%rsp
  3e:	89                   	.byte 0x89
  3f:	55                   	push   %rbp

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 4c                	ja     0x54
   8:	c3                   	ret
   9:	0f 1f 00             	nopl   (%rax)
   c:	55                   	push   %rbp
   d:	48 89 e5             	mov    %rsp,%rbp
  10:	48 83 ec 20          	sub    $0x20,%rsp
  14:	89                   	.byte 0x89
  15:	55                   	push   %rbp
[  337.951115] RSP: 002b:00007ffd615b18c8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  337.951576] RAX: ffffffffffffffda RBX: 000055958cf26f80 RCX: 00007f008946a8b4
[  337.951983] RDX: 0000000000000000 RSI: 00007ffd615b1940 RDI: 0000000000000003
[  337.952415] RBP: 00007ffd615b19b0 R08: 0000000064bab34a R09: 0000000000000001
[  337.952825] R10: 0000000000000001 R11: 0000000000000202 R12: 00007ffd615b1a30
[  337.953247] R13: 0000000064bab34b R14: 000055958cf26f80 R15: 0000000000000000
[  337.953670]  </TASK>
[  337.953809] irq event stamp: 167935
[  337.954012] hardirqs last enabled at (167943): __up_console_sem (/home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:42 /home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:77 /home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:135 /home/petr/src/linux_mlxsw/kernel/printk/printk.c:347 /home/petr/src/linux_mlxsw/kernel/printk/printk.c:339) 
[  337.954517] hardirqs last disabled at (167952): __up_console_sem (/home/petr/src/linux_mlxsw/kernel/printk/printk.c:345 (discriminator 3)) 
[  337.955007] softirqs last enabled at (167216): irq_exit_rcu (/home/petr/src/linux_mlxsw/kernel/softirq.c:427 /home/petr/src/linux_mlxsw/kernel/softirq.c:632 /home/petr/src/linux_mlxsw/kernel/softirq.c:644) 
[  337.955509] softirqs last disabled at (167199): irq_exit_rcu (/home/petr/src/linux_mlxsw/kernel/softirq.c:427 /home/petr/src/linux_mlxsw/kernel/softirq.c:632 /home/petr/src/linux_mlxsw/kernel/softirq.c:644) 
[  337.955999] ---[ end trace 0000000000000000 ]---

--=-=-=
Content-Type: text/plain; name="decoded3.txt"
Content-Disposition: inline; filename="decoded3.txt"
Content-Description: decoded3.txt

[  337.957029] ------------[ cut here ]------------
[  337.957696] kvfree_call_rcu(): Double-freed call. rcu_head ffff888008a7a638
[  337.961920] WARNING: CPU: 0 PID: 171 at kernel/rcu/tree.c:3361 kvfree_call_rcu (/home/petr/src/linux_mlxsw/kernel/rcu/tree.c:3361 (discriminator 1)) 
[  337.963725] Modules linked in: sch_ingress veth
[  337.964797] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
[  337.965437] RIP: 0010:kvfree_call_rcu (/home/petr/src/linux_mlxsw/kernel/rcu/tree.c:3361 (discriminator 1)) 
[ 337.965764] Code: 00 00 00 e8 2a 4c e8 ff e9 35 01 00 00 4c 89 e2 48 c7 c6 a0 07 4e 83 48 c7 c7 40 df 4d 83 c6 05 29 35 07 03 01 e8 28 7c e0 ff <0f> 0b e9 db fa ff ff 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 08
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e8                	add    %ch,%al
   4:	2a 4c e8 ff          	sub    -0x1(%rax,%rbp,8),%cl
   8:	e9 35 01 00 00       	jmp    0x142
   d:	4c 89 e2             	mov    %r12,%rdx
  10:	48 c7 c6 a0 07 4e 83 	mov    $0xffffffff834e07a0,%rsi
  17:	48 c7 c7 40 df 4d 83 	mov    $0xffffffff834ddf40,%rdi
  1e:	c6 05 29 35 07 03 01 	movb   $0x1,0x3073529(%rip)        # 0x307354e
  25:	e8 28 7c e0 ff       	call   0xffffffffffe07c52
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 db fa ff ff       	jmp    0xfffffffffffffb0c
  31:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  38:	fc ff df 
  3b:	49 8d 7c 24 08       	lea    0x8(%r12),%rdi

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 db fa ff ff       	jmp    0xfffffffffffffae2
   7:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
   e:	fc ff df 
  11:	49 8d 7c 24 08       	lea    0x8(%r12),%rdi
[  337.966903] RSP: 0000:ffffc9000009f328 EFLAGS: 00010286
[  337.967220] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  337.967645] RDX: ffff88800c8c9fc0 RSI: ffffffff813f13cb RDI: 0000000000000001
[  337.968049] RBP: ffff888008a7a000 R08: 0000000000000001 R09: 0000000000000000
[  337.968474] R10: 0000000000000001 R11: 0000000000000001 R12: ffff888008a7a638
[  337.968879] R13: ffff888008a7a208 R14: ffff888008a7a008 R15: 0000000000000002
[  337.969302] FS:  00007f0089130740(0000) GS:ffff888036000000(0000) knlGS:0000000000000000
[  337.969759] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  337.970091] CR2: 00007fd15cc3d000 CR3: 000000000c0af001 CR4: 0000000000370ef0
[  337.970515] Call Trace:
[  337.970670]  <TASK>
[  337.970806] ? __warn (/home/petr/src/linux_mlxsw/kernel/panic.c:673) 
[  337.971008] ? kvfree_call_rcu (/home/petr/src/linux_mlxsw/kernel/rcu/tree.c:3361 (discriminator 1)) 
[  337.971279] ? report_bug (/home/petr/src/linux_mlxsw/lib/bug.c:180 /home/petr/src/linux_mlxsw/lib/bug.c:219) 
[  337.971519] ? handle_bug (/home/petr/src/linux_mlxsw/arch/x86/kernel/traps.c:324 (discriminator 1)) 
[  337.971738] ? exc_invalid_op (/home/petr/src/linux_mlxsw/arch/x86/kernel/traps.c:345 (discriminator 1)) 
[  337.971973] ? asm_exc_invalid_op (/home/petr/src/linux_mlxsw/./arch/x86/include/asm/idtentry.h:568) 
[  337.972261] ? __warn_printk (/home/petr/src/linux_mlxsw/kernel/panic.c:712) 
[  337.972501] ? kvfree_call_rcu (/home/petr/src/linux_mlxsw/kernel/rcu/tree.c:3361 (discriminator 1)) 
[  337.972750] ? kvfree_call_rcu (/home/petr/src/linux_mlxsw/kernel/rcu/tree.c:3361 (discriminator 1)) 
[  337.972997] ? __tcf_block_put (/home/petr/src/linux_mlxsw/net/sched/cls_api.c:535 /home/petr/src/linux_mlxsw/net/sched/cls_api.c:530 /home/petr/src/linux_mlxsw/net/sched/cls_api.c:1301) 
[  337.973276] ingress_destroy (/home/petr/src/linux_mlxsw/net/sched/sch_ingress.c:131) sch_ingress
[  337.973591] ? clsact_init (/home/petr/src/linux_mlxsw/net/sched/sch_ingress.c:113) sch_ingress
[  337.973892] __qdisc_destroy (/home/petr/src/linux_mlxsw/net/sched/sch_generic.c:1065) 
[  337.974128] qdisc_destroy (/home/petr/src/linux_mlxsw/net/sched/sch_generic.c:1079) 
[  337.974371] qdisc_graft (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1134) 
[  337.974612] ? tc_dump_tclass (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1076) 
[  337.974873] tc_get_qdisc (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1541) 
[  337.975106] ? tc_ctl_tclass (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1475) 
[  337.975363] ? rtnetlink_rcv_msg (/home/petr/src/linux_mlxsw/net/core/rtnetlink.c:6421) 
[  337.975645] ? cap_capable (/home/petr/src/linux_mlxsw/security/commoncap.c:102) 
[  337.975883] ? lock_is_held_type (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:467 (discriminator 4) /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5833 (discriminator 4)) 
[  337.976137] ? tc_ctl_tclass (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1475) 
[  337.976398] rtnetlink_rcv_msg (/home/petr/src/linux_mlxsw/net/core/rtnetlink.c:6423) 
[  337.976653] ? rtnl_dump_ifinfo (/home/petr/src/linux_mlxsw/net/core/rtnetlink.c:6319) 
[  337.976915] ? lockdep_hardirqs_on_prepare (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5000) 
[  337.977243] ? lockdep_hardirqs_on_prepare (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5000) 
[  337.977548] ? find_held_lock (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5251 (discriminator 1)) 
[  337.977799] netlink_rcv_skb (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:2547) 
[  337.978041] ? rtnl_dump_ifinfo (/home/petr/src/linux_mlxsw/net/core/rtnetlink.c:6319) 
[  337.978331] ? netlink_ack (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:2523) 
[  337.978583] ? lock_sync (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5729) 
[  337.978833] ? netlink_deliver_tap (/home/petr/src/linux_mlxsw/./include/linux/rcupdate.h:308 /home/petr/src/linux_mlxsw/./include/linux/rcupdate.h:782 /home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:340) 
[  337.979103] ? is_vmalloc_addr (/home/petr/src/linux_mlxsw/mm/vmalloc.c:83) 
[  337.979376] netlink_unicast (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1340 /home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1365) 
[  337.979668] ? netlink_attachskb (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1350) 
[  337.979933] ? __sanitizer_cov_trace_switch (/home/petr/src/linux_mlxsw/kernel/kcov.c:340 (discriminator 1)) 
[  337.980307] ? __check_object_size (/home/petr/src/linux_mlxsw/mm/usercopy.c:113 /home/petr/src/linux_mlxsw/mm/usercopy.c:145 /home/petr/src/linux_mlxsw/mm/usercopy.c:254 /home/petr/src/linux_mlxsw/mm/usercopy.c:213) 
[  337.980608] netlink_sendmsg (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1911) 
[  337.980861] ? netlink_unicast (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1830) 
[  337.981124] ? netlink_unicast (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1830) 
[  337.981406] ____sys_sendmsg (/home/petr/src/linux_mlxsw/net/socket.c:728 (discriminator 1) /home/petr/src/linux_mlxsw/net/socket.c:748 (discriminator 1) /home/petr/src/linux_mlxsw/net/socket.c:2494 (discriminator 1)) 
[  337.981654] ? copy_msghdr_from_user (/home/petr/src/linux_mlxsw/net/socket.c:2420) 
[  337.981944] ? sock_read_iter (/home/petr/src/linux_mlxsw/net/socket.c:2440) 
[  337.982202] ? __lock_acquire (/home/petr/src/linux_mlxsw/./arch/x86/include/asm/bitops.h:228 /home/petr/src/linux_mlxsw/./arch/x86/include/asm/bitops.h:240 /home/petr/src/linux_mlxsw/./include/asm-generic/bitops/instrumented-non-atomic.h:142 /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:228 /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:3788 /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:3844 /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5144) 
[  337.982486] ___sys_sendmsg (/home/petr/src/linux_mlxsw/net/socket.c:2550) 
[  337.982734] ? do_recvmmsg (/home/petr/src/linux_mlxsw/net/socket.c:2537) 
[  337.983010] ? local_clock_noinstr (/home/petr/src/linux_mlxsw/kernel/sched/clock.c:301 (discriminator 1)) 
[  337.983299] ? __fget_light (/home/petr/src/linux_mlxsw/fs/file.c:1027) 
[  337.983549] __sys_sendmsg (/home/petr/src/linux_mlxsw/net/socket.c:2579) 
[  337.983782] ? __sys_sendmsg_sock (/home/petr/src/linux_mlxsw/net/socket.c:2565) 
[  337.984043] ? xfd_validate_state (/home/petr/src/linux_mlxsw/arch/x86/kernel/fpu/xstate.c:1411 /home/petr/src/linux_mlxsw/arch/x86/kernel/fpu/xstate.c:1455) 
[  337.984352] ? syscall_enter_from_user_mode (/home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:42 /home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:77 /home/petr/src/linux_mlxsw/kernel/entry/common.c:111) 
[  337.984667] do_syscall_64 (/home/petr/src/linux_mlxsw/arch/x86/entry/common.c:50 (discriminator 1) /home/petr/src/linux_mlxsw/arch/x86/entry/common.c:80 (discriminator 1)) 
[  337.984894] entry_SYSCALL_64_after_hwframe (/home/petr/src/linux_mlxsw/arch/x86/entry/entry_64.S:120) 
[  337.985202] RIP: 0033:0x7f008946a8b4
[ 337.985437] Code: 15 59 f5 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b5 0f 1f 00 f3 0f 1e fa 80 3d 2d 7d 0c 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
All code
========
   0:	15 59 f5 0b 00       	adc    $0xbf559,%eax
   5:	f7 d8                	neg    %eax
   7:	64 89 02             	mov    %eax,%fs:(%rdx)
   a:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  11:	eb b5                	jmp    0xffffffffffffffc8
  13:	0f 1f 00             	nopl   (%rax)
  16:	f3 0f 1e fa          	endbr64
  1a:	80 3d 2d 7d 0c 00 00 	cmpb   $0x0,0xc7d2d(%rip)        # 0xc7d4e
  21:	74 13                	je     0x36
  23:	b8 2e 00 00 00       	mov    $0x2e,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 4c                	ja     0x7e
  32:	c3                   	ret
  33:	0f 1f 00             	nopl   (%rax)
  36:	55                   	push   %rbp
  37:	48 89 e5             	mov    %rsp,%rbp
  3a:	48 83 ec 20          	sub    $0x20,%rsp
  3e:	89                   	.byte 0x89
  3f:	55                   	push   %rbp

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 4c                	ja     0x54
   8:	c3                   	ret
   9:	0f 1f 00             	nopl   (%rax)
   c:	55                   	push   %rbp
   d:	48 89 e5             	mov    %rsp,%rbp
  10:	48 83 ec 20          	sub    $0x20,%rsp
  14:	89                   	.byte 0x89
  15:	55                   	push   %rbp
[  337.986472] RSP: 002b:00007ffd615b18c8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  337.986905] RAX: ffffffffffffffda RBX: 000055958cf26f80 RCX: 00007f008946a8b4
[  337.987324] RDX: 0000000000000000 RSI: 00007ffd615b1940 RDI: 0000000000000003
[  337.987730] RBP: 00007ffd615b19b0 R08: 0000000064bab34a R09: 0000000000000001
[  337.988146] R10: 0000000000000001 R11: 0000000000000202 R12: 00007ffd615b1a30
[  337.988585] R13: 0000000064bab34b R14: 000055958cf26f80 R15: 0000000000000000
[  337.989023]  </TASK>
[  337.989171] irq event stamp: 168885
[  337.989399] hardirqs last enabled at (168895): __up_console_sem (/home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:42 /home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:77 /home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:135 /home/petr/src/linux_mlxsw/kernel/printk/printk.c:347 /home/petr/src/linux_mlxsw/kernel/printk/printk.c:339) 
[  337.989908] hardirqs last disabled at (168902): __up_console_sem (/home/petr/src/linux_mlxsw/kernel/printk/printk.c:345 (discriminator 3)) 
[  337.990424] softirqs last enabled at (168216): irq_exit_rcu (/home/petr/src/linux_mlxsw/kernel/softirq.c:427 /home/petr/src/linux_mlxsw/kernel/softirq.c:632 /home/petr/src/linux_mlxsw/kernel/softirq.c:644) 
[  337.990951] softirqs last disabled at (168207): irq_exit_rcu (/home/petr/src/linux_mlxsw/kernel/softirq.c:427 /home/petr/src/linux_mlxsw/kernel/softirq.c:632 /home/petr/src/linux_mlxsw/kernel/softirq.c:644) 
[  337.991830] ---[ end trace 0000000000000000 ]---

--=-=-=
Content-Type: text/plain; name="decoded4.txt"
Content-Disposition: inline; filename="decoded4.txt"
Content-Description: decoded4.txt

[  835.734697] ==================================================================
[  835.735303] BUG: KASAN: slab-use-after-free in ingress_init (/home/petr/src/linux_mlxsw/./include/net/tcx.h:36 /home/petr/src/linux_mlxsw/./include/net/tcx.h:136 /home/petr/src/linux_mlxsw/net/sched/sch_ingress.c:94) sch_ingress
[  835.735840] Read of size 8 at addr ffff888008a7a208 by task tc/303
[  835.736187]
[  835.736761] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
[  835.737244] Call Trace:
[  835.737394]  <TASK>
[  835.737524] dump_stack_lvl (/home/petr/src/linux_mlxsw/lib/dump_stack.c:107) 
[  835.737749] print_report (/home/petr/src/linux_mlxsw/mm/kasan/report.c:365 /home/petr/src/linux_mlxsw/mm/kasan/report.c:475) 
[  835.738015] ? __virt_addr_valid (/home/petr/src/linux_mlxsw/arch/x86/mm/physaddr.c:66) 
[  835.738265] kasan_report (/home/petr/src/linux_mlxsw/mm/kasan/report.c:590) 
[  835.738485] ? ingress_init (/home/petr/src/linux_mlxsw/./include/net/tcx.h:36 /home/petr/src/linux_mlxsw/./include/net/tcx.h:136 /home/petr/src/linux_mlxsw/net/sched/sch_ingress.c:94) sch_ingress
[  835.738783] ? ingress_init (/home/petr/src/linux_mlxsw/./include/net/tcx.h:36 /home/petr/src/linux_mlxsw/./include/net/tcx.h:136 /home/petr/src/linux_mlxsw/net/sched/sch_ingress.c:94) sch_ingress
[  835.739086] ingress_init (/home/petr/src/linux_mlxsw/./include/net/tcx.h:36 /home/petr/src/linux_mlxsw/./include/net/tcx.h:136 /home/petr/src/linux_mlxsw/net/sched/sch_ingress.c:94) sch_ingress
[  835.739393] ? ingress_dump (/home/petr/src/linux_mlxsw/net/sched/sch_ingress.c:79) sch_ingress
[  835.739703] qdisc_create (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1327) 
[  835.739929] ? tc_get_qdisc (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1228) 
[  835.740158] ? lock_is_held_type (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:467 (discriminator 4) /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5833 (discriminator 4)) 
[  835.740409] tc_modify_qdisc (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1703 (discriminator 1)) 
[  835.740651] ? qdisc_create (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1556) 
[  835.740886] ? rtnetlink_rcv_msg (/home/petr/src/linux_mlxsw/net/core/rtnetlink.c:6421) 
[  835.741144] ? cap_capable (/home/petr/src/linux_mlxsw/security/commoncap.c:102) 
[  835.741372] ? lock_is_held_type (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:467 (discriminator 4) /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5833 (discriminator 4)) 
[  835.741664] ? qdisc_create (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1556) 
[  835.741900] rtnetlink_rcv_msg (/home/petr/src/linux_mlxsw/net/core/rtnetlink.c:6423) 
[  835.742142] ? rtnl_dump_ifinfo (/home/petr/src/linux_mlxsw/net/core/rtnetlink.c:6319) 
[  835.742402] ? lockdep_hardirqs_on_prepare (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5000) 
[  835.742702] ? lockdep_hardirqs_on_prepare (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5000) 
[  835.742998] ? find_held_lock (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5251 (discriminator 1)) 
[  835.743233] netlink_rcv_skb (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:2547) 
[  835.743481] ? rtnl_dump_ifinfo (/home/petr/src/linux_mlxsw/net/core/rtnetlink.c:6319) 
[  835.743732] ? netlink_ack (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:2523) 
[  835.743955] ? lock_sync (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5729) 
[  835.744170] ? netlink_deliver_tap (/home/petr/src/linux_mlxsw/./include/linux/rcupdate.h:308 /home/petr/src/linux_mlxsw/./include/linux/rcupdate.h:782 /home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:340) 
[  835.744463] ? is_vmalloc_addr (/home/petr/src/linux_mlxsw/mm/vmalloc.c:83) 
[  835.744686] netlink_unicast (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1340 /home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1365) 
[  835.744912] ? netlink_attachskb (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1350) 
[  835.745156] ? __sanitizer_cov_trace_switch (/home/petr/src/linux_mlxsw/kernel/kcov.c:340 (discriminator 1)) 
[  835.745482] ? __check_object_size (/home/petr/src/linux_mlxsw/mm/usercopy.c:113 /home/petr/src/linux_mlxsw/mm/usercopy.c:145 /home/petr/src/linux_mlxsw/mm/usercopy.c:254 /home/petr/src/linux_mlxsw/mm/usercopy.c:213) 
[  835.745736] netlink_sendmsg (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1911) 
[  835.745967] ? netlink_unicast (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1830) 
[  835.746204] ? netlink_unicast (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1830) 
[  835.746481] ____sys_sendmsg (/home/petr/src/linux_mlxsw/net/socket.c:728 (discriminator 1) /home/petr/src/linux_mlxsw/net/socket.c:748 (discriminator 1) /home/petr/src/linux_mlxsw/net/socket.c:2494 (discriminator 1)) 
[  835.746705] ? copy_msghdr_from_user (/home/petr/src/linux_mlxsw/net/socket.c:2420) 
[  835.746987] ? sock_read_iter (/home/petr/src/linux_mlxsw/net/socket.c:2440) 
[  835.747225] ? __lock_acquire (/home/petr/src/linux_mlxsw/./arch/x86/include/asm/bitops.h:228 /home/petr/src/linux_mlxsw/./arch/x86/include/asm/bitops.h:240 /home/petr/src/linux_mlxsw/./include/asm-generic/bitops/instrumented-non-atomic.h:142 /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:228 /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:3788 /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:3844 /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5144) 
[  835.747495] ___sys_sendmsg (/home/petr/src/linux_mlxsw/net/socket.c:2550) 
[  835.747718] ? do_recvmmsg (/home/petr/src/linux_mlxsw/net/socket.c:2537) 
[  835.747958] ? local_clock_noinstr (/home/petr/src/linux_mlxsw/kernel/sched/clock.c:301 (discriminator 1)) 
[  835.748235] ? __fget_light (/home/petr/src/linux_mlxsw/fs/file.c:1027) 
[  835.748523] __sys_sendmsg (/home/petr/src/linux_mlxsw/net/socket.c:2579) 
[  835.748756] ? __sys_sendmsg_sock (/home/petr/src/linux_mlxsw/net/socket.c:2565) 
[  835.749004] ? __up_read (/home/petr/src/linux_mlxsw/./arch/x86/include/asm/preempt.h:104 (discriminator 1) /home/petr/src/linux_mlxsw/kernel/locking/rwsem.c:1354 (discriminator 1)) 
[  835.749229] ? syscall_enter_from_user_mode (/home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:42 /home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:77 /home/petr/src/linux_mlxsw/kernel/entry/common.c:111) 
[  835.749531] do_syscall_64 (/home/petr/src/linux_mlxsw/arch/x86/entry/common.c:50 (discriminator 1) /home/petr/src/linux_mlxsw/arch/x86/entry/common.c:80 (discriminator 1)) 
[  835.749755] entry_SYSCALL_64_after_hwframe (/home/petr/src/linux_mlxsw/arch/x86/entry/entry_64.S:120) 
[  835.750059] RIP: 0033:0x7f4a861c38b4
[ 835.750279] Code: 15 59 f5 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b5 0f 1f 00 f3 0f 1e fa 80 3d 2d 7d 0c 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
All code
========
   0:	15 59 f5 0b 00       	adc    $0xbf559,%eax
   5:	f7 d8                	neg    %eax
   7:	64 89 02             	mov    %eax,%fs:(%rdx)
   a:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  11:	eb b5                	jmp    0xffffffffffffffc8
  13:	0f 1f 00             	nopl   (%rax)
  16:	f3 0f 1e fa          	endbr64
  1a:	80 3d 2d 7d 0c 00 00 	cmpb   $0x0,0xc7d2d(%rip)        # 0xc7d4e
  21:	74 13                	je     0x36
  23:	b8 2e 00 00 00       	mov    $0x2e,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 4c                	ja     0x7e
  32:	c3                   	ret
  33:	0f 1f 00             	nopl   (%rax)
  36:	55                   	push   %rbp
  37:	48 89 e5             	mov    %rsp,%rbp
  3a:	48 83 ec 20          	sub    $0x20,%rsp
  3e:	89                   	.byte 0x89
  3f:	55                   	push   %rbp

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 4c                	ja     0x54
   8:	c3                   	ret
   9:	0f 1f 00             	nopl   (%rax)
   c:	55                   	push   %rbp
   d:	48 89 e5             	mov    %rsp,%rbp
  10:	48 83 ec 20          	sub    $0x20,%rsp
  14:	89                   	.byte 0x89
  15:	55                   	push   %rbp
[  835.751300] RSP: 002b:00007fff3b43db58 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  835.751739] RAX: ffffffffffffffda RBX: 000055dc998edf80 RCX: 00007f4a861c38b4
[  835.752143] RDX: 0000000000000000 RSI: 00007fff3b43dbd0 RDI: 0000000000000003
[  835.752553] RBP: 00007fff3b43dc40 R08: 0000000064bab53c R09: 0000000000000001
[  835.752962] R10: 0000000000000001 R11: 0000000000000202 R12: 00007fff3b43dcc0
[  835.753367] R13: 0000000064bab53d R14: 000055dc998edf80 R15: 0000000000000000
[  835.753784]  </TASK>
[  835.753923]
[  835.754017] Allocated by task 165:
[  835.754220] kasan_save_stack (/home/petr/src/linux_mlxsw/mm/kasan/common.c:46) 
[  835.754466] kasan_set_track (/home/petr/src/linux_mlxsw/mm/kasan/common.c:52 (discriminator 1)) 
[  835.754705] __kasan_kmalloc (/home/petr/src/linux_mlxsw/mm/kasan/common.c:374 /home/petr/src/linux_mlxsw/mm/kasan/common.c:383) 
[  835.754937] ingress_init (/home/petr/src/linux_mlxsw/./include/linux/slab.h:582 /home/petr/src/linux_mlxsw/./include/linux/slab.h:703 /home/petr/src/linux_mlxsw/./include/net/tcx.h:85 /home/petr/src/linux_mlxsw/./include/net/tcx.h:106 /home/petr/src/linux_mlxsw/./include/net/tcx.h:100 /home/petr/src/linux_mlxsw/net/sched/sch_ingress.c:91) sch_ingress
[  835.755240] qdisc_create (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1327) 
[  835.755481] tc_modify_qdisc (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1703 (discriminator 1)) 
[  835.755721] rtnetlink_rcv_msg (/home/petr/src/linux_mlxsw/net/core/rtnetlink.c:6423) 
[  835.755964] netlink_rcv_skb (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:2547) 
[  835.756197] netlink_unicast (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1340 /home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1365) 
[  835.756445] netlink_sendmsg (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1911) 
[  835.756675] ____sys_sendmsg (/home/petr/src/linux_mlxsw/net/socket.c:728 (discriminator 1) /home/petr/src/linux_mlxsw/net/socket.c:748 (discriminator 1) /home/petr/src/linux_mlxsw/net/socket.c:2494 (discriminator 1)) 
[  835.756906] ___sys_sendmsg (/home/petr/src/linux_mlxsw/net/socket.c:2550) 
[  835.757133] __sys_sendmsg (/home/petr/src/linux_mlxsw/net/socket.c:2579) 
[  835.757360] do_syscall_64 (/home/petr/src/linux_mlxsw/arch/x86/entry/common.c:50 (discriminator 1) /home/petr/src/linux_mlxsw/arch/x86/entry/common.c:80 (discriminator 1)) 
[  835.757574] entry_SYSCALL_64_after_hwframe (/home/petr/src/linux_mlxsw/arch/x86/entry/entry_64.S:120) 
[  835.757866]
[  835.757964] Last potentially related work creation:
[  835.758236] kasan_save_stack (/home/petr/src/linux_mlxsw/mm/kasan/common.c:46) 
[  835.758473] __kasan_record_aux_stack (/home/petr/src/linux_mlxsw/mm/kasan/generic.c:492 (discriminator 1)) 
[  835.758752] kvfree_call_rcu (/home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:26 /home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:67 /home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:103 /home/petr/src/linux_mlxsw/kernel/rcu/tree.c:2883 /home/petr/src/linux_mlxsw/kernel/rcu/tree.c:3284 /home/petr/src/linux_mlxsw/kernel/rcu/tree.c:3369) 
[  835.758994] ingress_destroy (/home/petr/src/linux_mlxsw/net/sched/sch_ingress.c:131) sch_ingress
[  835.759321] __qdisc_destroy (/home/petr/src/linux_mlxsw/net/sched/sch_generic.c:1065) 
[  835.759551] qdisc_destroy (/home/petr/src/linux_mlxsw/net/sched/sch_generic.c:1079) 
[  835.759769] qdisc_graft (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1134) 
[  835.759994] tc_get_qdisc (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1541) 
[  835.760219] rtnetlink_rcv_msg (/home/petr/src/linux_mlxsw/net/core/rtnetlink.c:6423) 
[  835.760477] netlink_rcv_skb (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:2547) 
[  835.760710] netlink_unicast (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1340 /home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1365) 
[  835.760941] netlink_sendmsg (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1911) 
[  835.761170] ____sys_sendmsg (/home/petr/src/linux_mlxsw/net/socket.c:728 (discriminator 1) /home/petr/src/linux_mlxsw/net/socket.c:748 (discriminator 1) /home/petr/src/linux_mlxsw/net/socket.c:2494 (discriminator 1)) 
[  835.761423] ___sys_sendmsg (/home/petr/src/linux_mlxsw/net/socket.c:2550) 
[  835.761646] __sys_sendmsg (/home/petr/src/linux_mlxsw/net/socket.c:2579) 
[  835.761864] do_syscall_64 (/home/petr/src/linux_mlxsw/arch/x86/entry/common.c:50 (discriminator 1) /home/petr/src/linux_mlxsw/arch/x86/entry/common.c:80 (discriminator 1)) 
[  835.762072] entry_SYSCALL_64_after_hwframe (/home/petr/src/linux_mlxsw/arch/x86/entry/entry_64.S:120) 
[  835.762398]
[  835.762490] Second to last potentially related work creation:
[  835.762802] kasan_save_stack (/home/petr/src/linux_mlxsw/mm/kasan/common.c:46) 
[  835.763067] __kasan_record_aux_stack (/home/petr/src/linux_mlxsw/mm/kasan/generic.c:492 (discriminator 1)) 
[  835.763340] __call_rcu_common.constprop.0 (/home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:26 /home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:67 /home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:103 /home/petr/src/linux_mlxsw/kernel/rcu/tree.c:2650) 
[  835.763631] netlink_release (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:829) 
[  835.763865] __sock_release (/home/petr/src/linux_mlxsw/net/socket.c:655) 
[  835.764085] sock_close (/home/petr/src/linux_mlxsw/net/socket.c:1388) 
[  835.764282] __fput (/home/petr/src/linux_mlxsw/fs/file_table.c:385) 
[  835.764493] task_work_run (/home/petr/src/linux_mlxsw/kernel/task_work.c:181) 
[  835.764715] do_exit (/home/petr/src/linux_mlxsw/kernel/exit.c:875) 
[  835.764915] do_group_exit (/home/petr/src/linux_mlxsw/kernel/exit.c:1005) 
[  835.765132] __x64_sys_exit_group (/home/petr/src/linux_mlxsw/kernel/exit.c:1033) 
[  835.765382] do_syscall_64 (/home/petr/src/linux_mlxsw/arch/x86/entry/common.c:50 (discriminator 1) /home/petr/src/linux_mlxsw/arch/x86/entry/common.c:80 (discriminator 1)) 
[  835.765596] entry_SYSCALL_64_after_hwframe (/home/petr/src/linux_mlxsw/arch/x86/entry/entry_64.S:120) 
[  835.765891]
[  835.765988] The buggy address belongs to the object at ffff888008a7a000
[  835.765988]  which belongs to the cache kmalloc-2k of size 2048
[  835.766668] The buggy address is located 520 bytes inside of
[  835.766668]  freed 2048-byte region [ffff888008a7a000, ffff888008a7a800)
[  835.767340]
[  835.767438] The buggy address belongs to the physical page:
[  835.767750] page:ffffea0000229e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888008a7a000 pfn:0x8a78
[  835.768391] head:ffffea0000229e00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  835.768837] flags: 0x100000000010200(slab|head|node=0|zone=1)
[  835.769170] page_type: 0xffffffff()
[  835.769385] raw: 0100000000010200 ffff888006842340 ffffea0000241a10 ffffea000022a010
[  835.769861] raw: ffff888008a7a000 0000000000050001 00000001ffffffff 0000000000000000
[  835.770622] page dumped because: kasan: bad access detected
[  835.771278]
[  835.771540] Memory state around the buggy address:
[  835.772029]  ffff888008a7a100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  835.772980]  ffff888008a7a180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  835.773813] >ffff888008a7a200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  835.774506]                       ^
[  835.774844]  ffff888008a7a280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  835.775524]  ffff888008a7a300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  835.776185] ==================================================================

--=-=-=
Content-Type: text/plain; name="decoded5.txt"
Content-Disposition: inline; filename="decoded5.txt"
Content-Description: decoded5.txt

[  835.780645] general protection fault, probably for non-canonical address 0xed6d696d6d6d6e32: 0000 [#1] PREEMPT SMP KASAN
[  835.781337] KASAN: maybe wild-memory-access in range [0x6b6b6b6b6b6b7190-0x6b6b6b6b6b6b7197]
[  835.782241] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
[  835.782741] RIP: 0010:ingress_init (/home/petr/src/linux_mlxsw/./include/net/tcx.h:136 (discriminator 1) /home/petr/src/linux_mlxsw/net/sched/sch_ingress.c:94 (discriminator 1)) sch_ingress
[ 835.783089] Code: 03 80 3c 02 00 0f 85 91 04 00 00 4c 8b ad 00 02 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d bd 28 06 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 06 0f 8e 75 03 00 00 41 c6 85 28 06 00 00 01
All code
========
   0:	03 80 3c 02 00 0f    	add    0xf00023c(%rax),%eax
   6:	85 91 04 00 00 4c    	test   %edx,0x4c000004(%rcx)
   c:	8b ad 00 02 00 00    	mov    0x200(%rbp),%ebp
  12:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  19:	fc ff df 
  1c:	49 8d bd 28 06 00 00 	lea    0x628(%r13),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax		<-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	74 06                	je     0x38
  32:	0f 8e 75 03 00 00    	jle    0x3ad
  38:	41 c6 85 28 06 00 00 	movb   $0x1,0x628(%r13)
  3f:	01 

Code starting with the faulting instruction
===========================================
   0:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4:	84 c0                	test   %al,%al
   6:	74 06                	je     0xe
   8:	0f 8e 75 03 00 00    	jle    0x383
   e:	41 c6 85 28 06 00 00 	movb   $0x1,0x628(%r13)
  15:	01 
[  835.784122] RSP: 0018:ffffc90000d17400 EFLAGS: 00010202
[  835.784429] RAX: dffffc0000000000 RBX: ffff88800c841000 RCX: 0000000000000001
[  835.784824] RDX: 0d6d6d6d6d6d6e32 RSI: ffffffff81c2398e RDI: 6b6b6b6b6b6b7193
[  835.785218] RBP: ffff888008a7a008 R08: 0000000000000007 R09: 0000000000000000
[  835.785620] R10: 0000000000000000 R11: 0000000000000001 R12: ffffc90000d17818
[  835.786017] R13: 6b6b6b6b6b6b6b6b R14: 0000000000000000 R15: ffff88800d731000
[  835.786437] FS:  00007f4a85e89740(0000) GS:ffff888036000000(0000) knlGS:0000000000000000
[  835.786907] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  835.787245] CR2: 000055dc998c5dc0 CR3: 000000000bbc8005 CR4: 0000000000370ef0
[  835.787664] Call Trace:
[  835.787818]  <TASK>
[  835.787958] ? die_addr (/home/petr/src/linux_mlxsw/arch/x86/kernel/dumpstack.c:421 /home/petr/src/linux_mlxsw/arch/x86/kernel/dumpstack.c:460) 
[  835.788173] ? exc_general_protection (/home/petr/src/linux_mlxsw/arch/x86/kernel/traps.c:786 /home/petr/src/linux_mlxsw/arch/x86/kernel/traps.c:728) 
[  835.788468] ? asm_exc_general_protection (/home/petr/src/linux_mlxsw/./arch/x86/include/asm/idtentry.h:564) 
[  835.788760] ? end_report (/home/petr/src/linux_mlxsw/./arch/x86/include/asm/current.h:41 (discriminator 1) /home/petr/src/linux_mlxsw/mm/kasan/report.c:239 (discriminator 1)) 
[  835.788984] ? ingress_init (/home/petr/src/linux_mlxsw/./include/net/tcx.h:136 (discriminator 1) /home/petr/src/linux_mlxsw/net/sched/sch_ingress.c:94 (discriminator 1)) sch_ingress
[  835.789431] ? ingress_dump (/home/petr/src/linux_mlxsw/net/sched/sch_ingress.c:79) sch_ingress
[  835.789870] qdisc_create (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1327) 
[  835.790234] ? tc_get_qdisc (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1228) 
[  835.790636] ? lock_is_held_type (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:467 (discriminator 4) /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5833 (discriminator 4)) 
[  835.791033] tc_modify_qdisc (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1703 (discriminator 1)) 
[  835.791530] ? qdisc_create (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1556) 
[  835.792092] ? rtnetlink_rcv_msg (/home/petr/src/linux_mlxsw/net/core/rtnetlink.c:6421) 
[  835.792543] ? cap_capable (/home/petr/src/linux_mlxsw/security/commoncap.c:102) 
[  835.792906] ? lock_is_held_type (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:467 (discriminator 4) /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5833 (discriminator 4)) 
[  835.793269] ? qdisc_create (/home/petr/src/linux_mlxsw/net/sched/sch_api.c:1556) 
[  835.793723] rtnetlink_rcv_msg (/home/petr/src/linux_mlxsw/net/core/rtnetlink.c:6423) 
[  835.794040] ? rtnl_dump_ifinfo (/home/petr/src/linux_mlxsw/net/core/rtnetlink.c:6319) 
[  835.794412] ? lockdep_hardirqs_on_prepare (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5000) 
[  835.794892] ? lockdep_hardirqs_on_prepare (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5000) 
[  835.795404] ? find_held_lock (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5251 (discriminator 1)) 
[  835.795774] netlink_rcv_skb (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:2547) 
[  835.796011] ? rtnl_dump_ifinfo (/home/petr/src/linux_mlxsw/net/core/rtnetlink.c:6319) 
[  835.796272] ? netlink_ack (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:2523) 
[  835.796517] ? lock_sync (/home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5729) 
[  835.796758] ? netlink_deliver_tap (/home/petr/src/linux_mlxsw/./include/linux/rcupdate.h:308 /home/petr/src/linux_mlxsw/./include/linux/rcupdate.h:782 /home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:340) 
[  835.797034] ? is_vmalloc_addr (/home/petr/src/linux_mlxsw/mm/vmalloc.c:83) 
[  835.797286] netlink_unicast (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1340 /home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1365) 
[  835.797547] ? netlink_attachskb (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1350) 
[  835.797809] ? __sanitizer_cov_trace_switch (/home/petr/src/linux_mlxsw/kernel/kcov.c:340 (discriminator 1)) 
[  835.798141] ? __check_object_size (/home/petr/src/linux_mlxsw/mm/usercopy.c:113 /home/petr/src/linux_mlxsw/mm/usercopy.c:145 /home/petr/src/linux_mlxsw/mm/usercopy.c:254 /home/petr/src/linux_mlxsw/mm/usercopy.c:213) 
[  835.798429] netlink_sendmsg (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1911) 
[  835.798670] ? netlink_unicast (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1830) 
[  835.798927] ? netlink_unicast (/home/petr/src/linux_mlxsw/net/netlink/af_netlink.c:1830) 
[  835.799186] ____sys_sendmsg (/home/petr/src/linux_mlxsw/net/socket.c:728 (discriminator 1) /home/petr/src/linux_mlxsw/net/socket.c:748 (discriminator 1) /home/petr/src/linux_mlxsw/net/socket.c:2494 (discriminator 1)) 
[  835.799440] ? copy_msghdr_from_user (/home/petr/src/linux_mlxsw/net/socket.c:2420) 
[  835.799723] ? sock_read_iter (/home/petr/src/linux_mlxsw/net/socket.c:2440) 
[  835.799968] ? __lock_acquire (/home/petr/src/linux_mlxsw/./arch/x86/include/asm/bitops.h:228 /home/petr/src/linux_mlxsw/./arch/x86/include/asm/bitops.h:240 /home/petr/src/linux_mlxsw/./include/asm-generic/bitops/instrumented-non-atomic.h:142 /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:228 /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:3788 /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:3844 /home/petr/src/linux_mlxsw/kernel/locking/lockdep.c:5144) 
[  835.800227] ___sys_sendmsg (/home/petr/src/linux_mlxsw/net/socket.c:2550) 
[  835.800480] ? do_recvmmsg (/home/petr/src/linux_mlxsw/net/socket.c:2537) 
[  835.800723] ? local_clock_noinstr (/home/petr/src/linux_mlxsw/kernel/sched/clock.c:301 (discriminator 1)) 
[  835.800971] ? __fget_light (/home/petr/src/linux_mlxsw/fs/file.c:1027) 
[  835.801222] __sys_sendmsg (/home/petr/src/linux_mlxsw/net/socket.c:2579) 
[  835.801460] ? __sys_sendmsg_sock (/home/petr/src/linux_mlxsw/net/socket.c:2565) 
[  835.801708] ? __up_read (/home/petr/src/linux_mlxsw/./arch/x86/include/asm/preempt.h:104 (discriminator 1) /home/petr/src/linux_mlxsw/kernel/locking/rwsem.c:1354 (discriminator 1)) 
[  835.801933] ? syscall_enter_from_user_mode (/home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:42 /home/petr/src/linux_mlxsw/./arch/x86/include/asm/irqflags.h:77 /home/petr/src/linux_mlxsw/kernel/entry/common.c:111) 
[  835.802228] do_syscall_64 (/home/petr/src/linux_mlxsw/arch/x86/entry/common.c:50 (discriminator 1) /home/petr/src/linux_mlxsw/arch/x86/entry/common.c:80 (discriminator 1)) 
[  835.802455] entry_SYSCALL_64_after_hwframe (/home/petr/src/linux_mlxsw/arch/x86/entry/entry_64.S:120) 
[  835.802758] RIP: 0033:0x7f4a861c38b4
[ 835.802983] Code: 15 59 f5 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b5 0f 1f 00 f3 0f 1e fa 80 3d 2d 7d 0c 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
All code
========
   0:	15 59 f5 0b 00       	adc    $0xbf559,%eax
   5:	f7 d8                	neg    %eax
   7:	64 89 02             	mov    %eax,%fs:(%rdx)
   a:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  11:	eb b5                	jmp    0xffffffffffffffc8
  13:	0f 1f 00             	nopl   (%rax)
  16:	f3 0f 1e fa          	endbr64
  1a:	80 3d 2d 7d 0c 00 00 	cmpb   $0x0,0xc7d2d(%rip)        # 0xc7d4e
  21:	74 13                	je     0x36
  23:	b8 2e 00 00 00       	mov    $0x2e,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 4c                	ja     0x7e
  32:	c3                   	ret
  33:	0f 1f 00             	nopl   (%rax)
  36:	55                   	push   %rbp
  37:	48 89 e5             	mov    %rsp,%rbp
  3a:	48 83 ec 20          	sub    $0x20,%rsp
  3e:	89                   	.byte 0x89
  3f:	55                   	push   %rbp

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 4c                	ja     0x54
   8:	c3                   	ret
   9:	0f 1f 00             	nopl   (%rax)
   c:	55                   	push   %rbp
   d:	48 89 e5             	mov    %rsp,%rbp
  10:	48 83 ec 20          	sub    $0x20,%rsp
  14:	89                   	.byte 0x89
  15:	55                   	push   %rbp
[  835.803998] RSP: 002b:00007fff3b43db58 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  835.804428] RAX: ffffffffffffffda RBX: 000055dc998edf80 RCX: 00007f4a861c38b4
[  835.804824] RDX: 0000000000000000 RSI: 00007fff3b43dbd0 RDI: 0000000000000003
[  835.805222] RBP: 00007fff3b43dc40 R08: 0000000064bab53c R09: 0000000000000001
[  835.805622] R10: 0000000000000001 R11: 0000000000000202 R12: 00007fff3b43dcc0
[  835.806035] R13: 0000000064bab53d R14: 000055dc998edf80 R15: 0000000000000000
[  835.806466]  </TASK>
[  835.806606] Modules linked in: sch_ingress veth
[  835.807662] ---[ end trace 0000000000000000 ]---
[  835.808497] RIP: 0010:ingress_init (/home/petr/src/linux_mlxsw/./include/net/tcx.h:136 (discriminator 1) /home/petr/src/linux_mlxsw/net/sched/sch_ingress.c:94 (discriminator 1)) sch_ingress
[ 835.812394] Code: 03 80 3c 02 00 0f 85 91 04 00 00 4c 8b ad 00 02 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d bd 28 06 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 06 0f 8e 75 03 00 00 41 c6 85 28 06 00 00 01
All code
========
   0:	03 80 3c 02 00 0f    	add    0xf00023c(%rax),%eax
   6:	85 91 04 00 00 4c    	test   %edx,0x4c000004(%rcx)
   c:	8b ad 00 02 00 00    	mov    0x200(%rbp),%ebp
  12:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  19:	fc ff df 
  1c:	49 8d bd 28 06 00 00 	lea    0x628(%r13),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax		<-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	74 06                	je     0x38
  32:	0f 8e 75 03 00 00    	jle    0x3ad
  38:	41 c6 85 28 06 00 00 	movb   $0x1,0x628(%r13)
  3f:	01 

Code starting with the faulting instruction
===========================================
   0:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4:	84 c0                	test   %al,%al
   6:	74 06                	je     0xe
   8:	0f 8e 75 03 00 00    	jle    0x383
   e:	41 c6 85 28 06 00 00 	movb   $0x1,0x628(%r13)
  15:	01 
[  835.814250] RSP: 0018:ffffc90000d17400 EFLAGS: 00010202
[  835.814569] RAX: dffffc0000000000 RBX: ffff88800c841000 RCX: 0000000000000001
[  835.815017] RDX: 0d6d6d6d6d6d6e32 RSI: ffffffff81c2398e RDI: 6b6b6b6b6b6b7193
[  835.815451] RBP: ffff888008a7a008 R08: 0000000000000007 R09: 0000000000000000
[  835.815857] R10: 0000000000000000 R11: 0000000000000001 R12: ffffc90000d17818
[  835.816270] R13: 6b6b6b6b6b6b6b6b R14: 0000000000000000 R15: ffff88800d731000
[  835.816683] FS:  00007f4a85e89740(0000) GS:ffff888036000000(0000) knlGS:0000000000000000
[  835.817133] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  835.820478] CR2: 000055dc998c5dc0 CR3: 000000000bbc8005 CR4: 0000000000370ef0


--=-=-=--

