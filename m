Return-Path: <bpf+bounces-7554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F86077926C
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 17:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4080C1C215D4
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 15:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACE229E1B;
	Fri, 11 Aug 2023 15:07:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540AF63B6;
	Fri, 11 Aug 2023 15:07:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87032D7D;
	Fri, 11 Aug 2023 08:07:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jamdCrKbgWhJG9hV4Nw89rl3NjZJCAw+ZvqZOMZK5ebYjB/Ym7KsoqobeYsunXHImkOnXcStiL8QckaZiVxO53yZ4vokWR9DWTj1T72k7l08+FNslL4aORdR+5uQjQWsrWKqXVloa6Xtdy5Vr28Zy+SC+kDBn1V2/ID+HtUYNRSZvvpv2SS9SsbOdK6e4Bt4X25VdBIpCjBJGtKWNty8VEcfGvrUIEdFPbq7zfvILR+OadVmIdszKgX808y1rC6CqiIR435Dh0foG5qkthFlKOlgOKSLXEhRKazf8NB4jcffZb1hZxuxASYEkdbi9aGccUWjCj5vm2TOeka8dK5PYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GASt/akSPszQ20KLLX0k0b7DlR3YgCIBonpPCW+FcKo=;
 b=EwHVqDMq4XU7rJA2g1B1rKNUUeNf7qepy50y5ckqYNVepbXH+XizSEPnxaTiQe1AM5up4ESP6pESb6quL8a8ivR6sqPjdX266dHBIm8dKVWmsL9EqJqgj2udgzFq6hFbwEaNI2HywX1XGJJYC/a7+XADKafPo5mys7qv3G37P3qHvEuiBDRXu+NPwH8+9doNsOSC6aNnOKOKV8O/NDcjZhZC3XGevR02seoKndvKNhzBShtnq2dxBLg++3ImAyrW0XS4fteOtGOrYGbGuVKrdoN+YgRyMfSabuGndm+Z2SXXABkBLjLMaqmtsoLNUo9RclSN6YgrXSocP3k7neJ+Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GASt/akSPszQ20KLLX0k0b7DlR3YgCIBonpPCW+FcKo=;
 b=PqObNcRGjpk/95gTvuC1e1uCXkHSi9GDKD7ydjV0AMxVDRazRbv82nWP9Jt79vJD/FzQIEKsA1+8Nax2Sv8Q3xIlzsCwwIeJ0zsqv4hUTgFQW9s1oc1piGWqM7D3Tfh+obIdeMgpjVp5kM9eLeqi5wtZUOTbi8HqlDYoxvIHhvQCBo6oeR8s+O2eSWwW5jVsxjMABCzAkoSSQLJBYMVir79vp5qhOWYB0pGsV+h2OwQlEKHx0vido3Cnc58DfQrHCU+qmWxrNcPCUMxJo6+5hR2cZm75rd0E4h6oXQ61AkWYJ8PcWNt5yP52FxCOCGGOgzqag/JPmJnwToGdDYM+ug==
Received: from SA1PR02CA0001.namprd02.prod.outlook.com (2603:10b6:806:2cf::7)
 by CY8PR12MB7218.namprd12.prod.outlook.com (2603:10b6:930:5a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 15:07:06 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::e4) by SA1PR02CA0001.outlook.office365.com
 (2603:10b6:806:2cf::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 15:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 15:07:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 11 Aug 2023
 08:06:55 -0700
Received: from fedora.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 11 Aug
 2023 08:06:50 -0700
References: <0000000000009f0f9c0602a616ce@google.com>
 <ZNZNs3I20BK7/kmp@shredder>
User-agent: mu4e 1.8.11; emacs 28.2
From: Vlad Buslov <vladbu@nvidia.com>
To: Ido Schimmel <idosch@idosch.org>
CC: syzbot <syzbot+d810d3cd45ed1848c3f7@syzkaller.appspotmail.com>,
	<ast@kernel.org>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
	<davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<hawk@kernel.org>, <idosch@nvidia.com>, <jasowang@redhat.com>,
	<john.fastabend@gmail.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [syzbot] [net?] WARNING in ip6_tnl_exit_batch_net
Date: Fri, 11 Aug 2023 18:06:17 +0300
In-Reply-To: <ZNZNs3I20BK7/kmp@shredder>
Message-ID: <877cq1sjnb.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|CY8PR12MB7218:EE_
X-MS-Office365-Filtering-Correlation-Id: ed54b701-8448-47ba-ddd4-08db9a7ca090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MN7li/kCvU5I6eWaD/GeyIXw2mLAPzulQFlrNVcTOzkOl9jgPEjRSGqj/RMJWR/kccj9FGM1CPjzx+QZhYu+Q+VKJOEb3FQx6+1I8/qemdrg+4a4kKClXmJ/W2dlaNKcZVM2UXK44GgtALFJvHvo3/6zIdebwhuu6fYf3Nr3kaTT4BpqJYGj0i1kgz6VPk0UrcmVsvRLxp79w4f/ddPk9oCBlbmw7Aq54yO1Sru48bKWGsahj8XHfdwOdwkTSFnl3iO5/IOK3Ltzq/wUUNXd7J3ThiKJwgY2ExlLWpcvosx1WEQTDVyvaYiD/D8WIcMrg4Ao7bNguZ/wchXduSBum0oSD8ueA6TtOFM1PhhvYtcdRghbTUPgZFEd/17vXyNsyVDmzldjO2rPFVXLhnpZPSo4CgLrYAHIqM+DJXTRHta4fx43n8DadcNXUXRJA5KLVXZ+gFu6QKnHtoS6BJ2MERWdlcBheV0WeQwbYIio5m5WRN7TTs0TtV9OpU9wx3LGcYMjjPIJo6ymb/Ra6pN42lAyGjcmH94AMzez1HNiPGa3R2YcvSN2KQjZlzD2NgIxwdBVkDCG9pZnYionDMU3sPUO2CV+fTBR1MMgMy7Jwbvu9m0RjBXc5kUaofcjKgOBu8RmEtaeF+JCYNkblS5VL9fjCZNI5RVGOKZkfPsEqzNrVDy8nrEQ6pQVL5dAhmD25BRdfR1IHgI5+tqh4id3gwoWDZx7aAADKVhrkbonUm/Yi3cfuRL7OZkWiq2wybc1oiPKdshAJzPyKXHAjH3sZxJCDheiR9IKkivy9bV1EKe4sucRZ5bRLEgBRtbWhkPo
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(1800799006)(186006)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(966005)(6666004)(70206006)(4326008)(6916009)(40480700001)(70586007)(54906003)(316002)(45080400002)(66899021)(478600001)(7696005)(40460700003)(8936002)(8676002)(356005)(26005)(5660300002)(41300700001)(86362001)(16526019)(82740400003)(7416002)(336012)(36756003)(47076005)(7636003)(36860700001)(426003)(2616005)(83380400001)(2906002)(99710200001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 15:07:06.2121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed54b701-8448-47ba-ddd4-08db9a7ca090
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7218
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri 11 Aug 2023 at 18:03, Ido Schimmel <idosch@idosch.org> wrote:
> On Fri, Aug 11, 2023 at 06:57:07AM -0700, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    048c796beb6e ipv6: adjust ndisc_is_useropt() to also retur..
>> git tree:       net
>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=103213a5a80000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
>> dashboard link: https://syzkaller.appspot.com/bug?extid=d810d3cd45ed1848c3f7
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1475a873a80000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153cc91ba80000
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/bf6b84b5998f/disk-048c796b.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/4000dee89ebe/vmlinux-048c796b.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/b700ee9bd306/bzImage-048c796b.xz
>> 
>> The issue was bisected to:
>> 
>> commit 718cb09aaa6fa78cc8124e9517efbc6c92665384
>> Author: Vlad Buslov <vladbu@nvidia.com>
>> Date:   Tue Aug 8 09:35:21 2023 +0000
>> 
>>     vlan: Fix VLAN 0 memory leak
>
> I wasn't able to reproduce using the C reproducer, but I'm pretty sure I
> know what is the problem. I wasn't aware that user space can create VLAN
> devices with VID 0, which can result in the VLAN driver wrongly deleting
> it upon NETDEV_DOWN. Reproduced using:
>
> ip link add name dummy1 up type dummy
> ip link add link dummy1 name dummy1.0 type vlan id 0
> ip link del dev dummy1
>
> Always adding VID 0 on NETDEV_UP "solves" the problem, but it will
> increase the memory consumption for each netdev, which is not ideal. A
> possible solution is trying to delete VID 0 upon NETDEV_UNREGISTER
> instead of only iterating over upper VLAN devices.
>
> Anyway, Vlad, it's probably best to send a revert while we figure it
> out.

Will do.

>
>> 
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12cbf169a80000
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=11cbf169a80000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=16cbf169a80000
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+d810d3cd45ed1848c3f7@syzkaller.appspotmail.com
>> Fixes: 718cb09aaa6f ("vlan: Fix VLAN 0 memory leak")
>> 
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 12 at net/core/dev.c:10876 unregister_netdevice_many_notify+0x14d8/0x19a0 net/core/dev.c:10876
>> Modules linked in:
>> CPU: 0 PID: 12 Comm: kworker/u4:1 Not tainted 6.5.0-rc4-syzkaller-00248-g048c796beb6e #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
>> Workqueue: netns cleanup_net
>> RIP: 0010:unregister_netdevice_many_notify+0x14d8/0x19a0 net/core/dev.c:10876
>> Code: b4 1a 00 00 48 c7 c6 e0 18 81 8b 48 c7 c7 20 19 81 8b c6 05 ab 19 6c 06 01 e8 b4 22 23 f9 0f 0b e9 64 f7 ff ff e8 68 60 5c f9 <0f> 0b e9 3b f7 ff ff e8 fc 68 b0 f9 e9 fc ec ff ff 4c 89 e7 e8 4f
>> RSP: 0018:ffffc90000117a30 EFLAGS: 00010293
>> RAX: 0000000000000000 RBX: 0000000070de5201 RCX: 0000000000000000
>> RDX: ffff88801526d940 RSI: ffffffff8829a7b8 RDI: 0000000000000001
>> RBP: ffff88807d7ee000 R08: 0000000000000001 R09: 0000000000000000
>> R10: 0000000000000001 R11: ffffffff81004e11 R12: ffff888018fb2a00
>> R13: 0000000000000000 R14: 0000000000000002 R15: ffff888018fb2a00
>> FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00005581d741a950 CR3: 000000007deef000 CR4: 00000000003506f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>  <TASK>
>>  ip6_tnl_exit_batch_net+0x57d/0x6f0 net/ipv6/ip6_tunnel.c:2278
>>  ops_exit_list+0x125/0x170 net/core/net_namespace.c:175
>>  cleanup_net+0x505/0xb20 net/core/net_namespace.c:614
>>  process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2597
>>  worker_thread+0x687/0x1110 kernel/workqueue.c:2748
>>  kthread+0x33a/0x430 kernel/kthread.c:389
>>  ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
>>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>>  </TASK>
>> 
>> 
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>> 
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>> 
>> If the bug is already fixed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>> 
>> If you want syzbot to run the reproducer, reply with:
>> #syz test: git://repo/address.git branch-or-commit-hash
>> If you attach or paste a git patch, syzbot will apply it before testing.
>> 
>> If you want to change bug's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>> 
>> If the bug is a duplicate of another bug, reply with:
>> #syz dup: exact-subject-of-another-report
>> 
>> If you want to undo deduplication, reply with:
>> #syz undup
>> 


