Return-Path: <bpf+bounces-7938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFA677ED81
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 00:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FCD1281CC1
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 22:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75091BEF2;
	Wed, 16 Aug 2023 22:58:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596FED2F1;
	Wed, 16 Aug 2023 22:58:10 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D2413E;
	Wed, 16 Aug 2023 15:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZn/JBv9pUBvF+B91IN1s0JKxLnDX7r2GDS73N2dcx+vrUVKGu7PKuD0t5lxcjqztZvvnOsd8iUOvMsdLY98iOLHwo10oOPHMZsTKFjGpnuk3u0VoApPqk7SNO3Mc+JhQIJ1HkMt5AC79PvrDNCd9Gm3gwZJnyYqI+x9I0tQR+xNa2HPCYyhNotGGOdLmguglijqCdcxTHmK9gd5/tT/2cL1/bT+8NnCevrS3xQCgncCDQUVlZEoPYVjWH5ksAfjs9N7AygeGrHxTcD9SdQKRQdlMNuP1+IrxfAgwv5N8Qa1xsvBJDAT9si6YJdKC2VFCF4YpDqDacRf7DrHX4j6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXV1+XsieAZW5aZOnbwm/tNUgqwdJx8J2e1GkewiuXs=;
 b=ItptYfRjefyS9suU1q+aPf8fO1NI3tIhMI2nzRimdtA4xy8R+hTvrjgE6p4e/a4uUyy7VZ1Y32PlSweCsD/UcUfFJKob7stFYj1ceg0FeHSPLvezD3/xvId8bFcYml7A9AVOJcC3AIjF4+owNo7LGjOoQvjoZWFmpwO8+HKUq2Ycm5SFZ4G++aFBAbAf98TnETMx5HNgUOM+Q2+n0Ju9X0GNPUGXHACgiCytbnLZJ4LwMqgwPv9egBb5Ayak0EPPMgY3zd89lRGOIoEgpUz2DWUagAW2yMk/BEuUZ0AIhPIv27+8EUIeGXGbsoSnBEsUVo8copdJAWWNEStHaStfeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXV1+XsieAZW5aZOnbwm/tNUgqwdJx8J2e1GkewiuXs=;
 b=PDT3OMcrzbLF2Lj9zTxwBmQdrrRTgVSt1Fpznu0cOR2p8LnArp43Iu1/wUHknhzh5utmdGxCV6UHrZ16pcca8lFNJlYjN9xWwrhZhSv3ENpahCzt2iYDg/YG+R0bAqH1K1oKGMIAZlfmL0JH+w60JC8+iFprN6En3D6CHacjpfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PA4PR04MB7822.eurprd04.prod.outlook.com (2603:10a6:102:b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Wed, 16 Aug
 2023 22:58:04 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%7]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 22:58:04 +0000
Date: Thu, 17 Aug 2023 01:57:59 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>
Cc: syzbot <syzbot+a3618a167af2021433cd@syzkaller.appspotmail.com>,
	bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
	edumazet@google.com, jiri@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in unix_release
Message-ID: <20230816225759.g25x76kmgzya2gei@skbuf>
References: <0000000000008a1fbb0602d4088a@google.com>
 <20230814160303.41b383b0@kernel.org>
 <20230815112821.vs7nvsgmncv6zfbw@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815112821.vs7nvsgmncv6zfbw@skbuf>
X-ClientProxiedBy: VI1P195CA0056.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::45) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PA4PR04MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: 11791bbe-0d38-4c24-f8c8-08db9eac3f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l1S0JmzuIsuPI2TU2fP7jIc6QWQeYdFDO4DbvSbjgB3r1IbUpbpVieAwXvU0wFsD1xHJok0QriGOfwbBFU5gqLSwPn7H8xOHUezA00gEpybLT/DNexcH36Ep1+0f4W7EhaM6FbrxYix7t9XG6popiQQFEAELfcALAgD2WtTFB99Mw96nVIgVDXZkAbLosPPU8TNXq2PvRcZFxXi+Yse6xrruPI9prm5K40LAKQieTVtvkv2qWjVbkshGqStw5sKDPOgV7IgNquzXECCKNPeLB8lhCGCC8oWExePSJJCcIyraEx8zHddITsLXN58rC5h03H3KMfq3C5QWdtJmTOeZ8lptDcnSnUssmI03qbWXJGrBpUvank9ga1K1ZBxVEsZrztIzPiQ4ethRFIzRYRXwnwlG01V2Kp/MpoOpPjmX6Jri+V65chOZJvobD9BpxB/TFQXK1yAhmzXuYMn22Q3V/VvdXuSpYHvzHCsgPNOzwPeREQLvx5ZqRtJ2JZHrGORFJvgxLI3pt5cL0562CoC0ri9aAqF0eRA5Ntctq3Mg/AvL0qBHKfsglVxn6Tgl+wKp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(366004)(396003)(136003)(39860400002)(186009)(451199024)(1800799009)(110136005)(66556008)(66476007)(54906003)(66946007)(5660300002)(44832011)(1076003)(41300700001)(2906002)(316002)(478600001)(7416002)(8936002)(8676002)(4326008)(6512007)(6666004)(6486002)(6506007)(9686003)(83380400001)(33716001)(38100700002)(86362001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zRKiyPGUOAX5reVkEWJ65O4pGrY1JuWT6WS5jccxqaKUON2RDBmKpuKgd77I?=
 =?us-ascii?Q?g6fwnx2GigKdzMpw6AXCg1y2sQTyNDFCBEwbl28aJ73Ua6FLYjenSOOKXfXw?=
 =?us-ascii?Q?ppGp0T9bcWrUVjnd3TnjuFsWiXbT+mi19d25ayLW+h51ri4bbAcgAHn127v5?=
 =?us-ascii?Q?6o84XFk0cBC+/1Igt/JpC4h95W33pAHsxvscnO7ANl5SKkJvoGJNluK3UXh6?=
 =?us-ascii?Q?Xgy9Ry+D3ggE83Vk4/qbFkSILMaUj7e0MElgm27j9trzLatqvJLEzscJWifN?=
 =?us-ascii?Q?WVchm+eJFLAcrBrosKmUTgj2BQlb4hUgjhg1QfNYOG/tn9XAHpwsELff0DxY?=
 =?us-ascii?Q?VoEdINmG5z10pqSVs/RNPf2YgvrS212NZl6N7FT54pLDe3Ahx4x/D4EagKSx?=
 =?us-ascii?Q?sMJYJN+ORu1sf6A12RC2AEfOOEQB1O7IiThJFiD9UKENUzG13LIEhHJDhlx1?=
 =?us-ascii?Q?Z6SlDhpOdeKtyHejGPD3RBqJASOmxPUPqGaZhp0Y4tO6WMQWZ2b9KCQGb6Wa?=
 =?us-ascii?Q?idTc4dz+R46ax6UauYDh/KdxjtlDn94Rk/UbH0zAJV+lnc31zd7oRO+pLsBf?=
 =?us-ascii?Q?YD6yDD1yuewJR5lLcGr8cPa1dK0LAhBu5s9CHtZgRLkIzVIrMGtYgXuhJfcE?=
 =?us-ascii?Q?ChU9nTQJiAWdZumGQFFbmcDMkJjQXinlMHkMe22h6XGvA89pxqV4DsYj//Ol?=
 =?us-ascii?Q?jiG6853rENnk7d5ZWBot36qOPqQcRmoJzRnV0ftTcK0rGrpimkCujpdXRiA3?=
 =?us-ascii?Q?B2Zjx/Qc5I53EXrlyxvbCh8y+NTXhU54524y42bN6UopE2FYxnyEQygyF00U?=
 =?us-ascii?Q?+lpR6bB01rULKzv3CGv+Brpb03Ru9g5Cx3vEMt5SHu39BbUNYnF9U1p5MZWe?=
 =?us-ascii?Q?RDeuxIVobJx6+IyCn03X6jCz9/OZUNnrmljMFw3QNC9WMwhEZb339ceyLFia?=
 =?us-ascii?Q?NEX7IlzZyNEuNe6rvAvHWmlPNTqOCG+qyclEpFE1Y3vLDmSFJInCgA05JhJm?=
 =?us-ascii?Q?HgXU4vT/cLjyknU5CJi6fGpycHOXSfbl55Y5AZnUaEHOGQ99a62bV/fzx8yQ?=
 =?us-ascii?Q?hUCA6Z9BcyfAac0GOvoVc1EThL4cbykQ4dSAaN1ivyuZAoQNuNQwHtSb54Bd?=
 =?us-ascii?Q?kVCsl2uwTFKzJoKV+clodFG4ri965wy3PmefVb1DrcYRU+ocAy3ygSgKCmLI?=
 =?us-ascii?Q?yH5iTqWE7TZ7vF/4G26qyUYvufTjtiYEd+UDE7gnwGiJGdXOO3qr9b67f5Bw?=
 =?us-ascii?Q?jgk7WlEJOk0xUNbO3l4/keHi8sW0YqWbYMK49oCgqL/TaxPFR8Neoqphz6pA?=
 =?us-ascii?Q?UH6jQfRp+rmUtaPKZDKois+Sz2umhA06X8SMoRAw/ROy8ceT9RReVNxDZFDz?=
 =?us-ascii?Q?LPfbuvGQ4R0cnguCBLI2k75LuajA5s8DN4pI9zbpwvaZTx34kHledx0GTIj+?=
 =?us-ascii?Q?JOWuvYvacJQAKKpbTA6Vm4/UzNmDpFhvRhW84G6sNKukA+DFjJUBehykZ0k1?=
 =?us-ascii?Q?ASmzGdFRVXJD43FYPISWMRVB23UnzdU4noN2LSPcIA0z872Gsih9DGNOpqG6?=
 =?us-ascii?Q?LzHYn2m2LT2FlwAwGOF8fyvVom+Qz/yZgu3vrk72IIkxR421boYAX3Agyxwa?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11791bbe-0d38-4c24-f8c8-08db9eac3f9f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 22:58:04.4003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOBe9RUW6pPd1Z2ymwt5geY7p8ier7g6Nt+9uqsZt39KZkGlJ1IV9qrNO5Lw/qDEIh6IiWbFK96T7ToekV/VtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7822
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jakub,

On Tue, Aug 15, 2023 at 02:28:21PM +0300, Vladimir Oltean wrote:
> On Mon, Aug 14, 2023 at 04:03:03PM -0700, Jakub Kicinski wrote:
> > Hi Vladimir, any ideas for this one?
> > The bisection looks pooped, FWIW, looks like a taprio inf loop.
> 
> I'm looking into it.

Here's what I've found out and what help I'll need going forward.

Indeed there is an infinite loop in taprio_dequeue() -> taprio_dequeue_tc_priority(),
leading to an RCU stall.

Short description of taprio_dequeue_tc_priority(): it cycles
q->cur_txq[tc] in the range between [ offset, offset + count ), where:

	int offset = dev->tc_to_txq[tc].offset;
	int count = dev->tc_to_txq[tc].count;

with the initial q->cur_txq[tc], aka the "first_txq" variable, being set
by the control path: taprio_change(), also called by taprio_init():

	if (mqprio) {
		(...)
		for (i = 0; i < mqprio->num_tc; i++) {
			(...)
			q->cur_txq[i] = mqprio->offset[i];
		}
	}

In the buggy case that leads to the RCU stall, the line in taprio_change()
which sets q->cur_txq[i] never gets executed. So first_txq will be 0
(pre-initialized memory), and if that's outside of the [ offset, offset + count )
range that taprio_dequeue_tc_priority() -> taprio_next_tc_txq() expects
to cycle through, the kernel is toast.

The nitty gritty of that is boring. What's not boring is how come the
control path skips the q->cur_txq[i] assignment. It's because "mqprio"
is NULL, and that's because taprio_change() (important: also tail-called
from taprio_init()) has this logic to detect a change in the traffic
class settings of the device, compared to the passed TCA_TAPRIO_ATTR_PRIOMAP
netlink attribute:

	/* no changes - no new mqprio settings */
	if (!taprio_mqprio_cmp(q, dev, mqprio))
		mqprio = NULL;

And what happens is that:
- we go through taprio_init()
- a TCA_TAPRIO_ATTR_PRIOMAP gets passed to us
- taprio_mqprio_cmp() sees that there's no change compared to the
  netdev's existing traffic class config
- taprio_change() sets "mqprio" to NULL, ignoring the given
  TCA_TAPRIO_ATTR_PRIOMAP
- we skip modifying q->cur_txq[i], as if it was a taprio_change() call
  that came straight from Qdisc_ops :: change(), rather than what it
  really is: one from Qdisc_ops :: init()

So the next question: why does taprio_mqprio_cmp() see that there's no
change? Because there is no change. When Qdisc_ops :: init() is called,
the netdev really has a non-zero dev->num_tc, prio_tc_map, tc_to_txq and
all that.

But why? A previous taprio, if that existed, will call taprio_destroy()
-> netdev_reset_tc(), so it won't leave state behind that will hinder
the current taprio. Checking for stuff in the netdev state is just so
that taprio_change() can distinguish between a direct Qdisc_ops :: change()
call vs one coming from init().

Finally, here's where the syzbot repro becomes relevant. It crafts the
RTM_NEWQDISC netlink message in such a way, that it makes tc_modify_qdisc()
in sch_api.c call a Qdisc_ops sequence with which taprio wasn't written
in mind.

With "tc qdisc replace && tc qdisc replace", tc_modify_qdisc() is
supposed to call init() the first time and replace() the second time.
What the repro does is make the above sequence call two init() methods
back to back.

To create an iproute2-based reproducer rather than the C one provided by
syzbot, we need this iproute2 change:

diff --git a/tc/tc_qdisc.c b/tc/tc_qdisc.c
index 56086c43b7fa..20d9622b6bf3 100644
--- a/tc/tc_qdisc.c
+++ b/tc/tc_qdisc.c
@@ -448,6 +448,8 @@ int do_qdisc(int argc, char **argv)
 		return tc_qdisc_modify(RTM_NEWQDISC, NLM_F_EXCL|NLM_F_CREATE, argc-1, argv+1);
 	if (matches(*argv, "change") == 0)
 		return tc_qdisc_modify(RTM_NEWQDISC, 0, argc-1, argv+1);
+	if (strcmp(*argv, "replace-exclusive") == 0)
+		return tc_qdisc_modify(RTM_NEWQDISC, NLM_F_CREATE|NLM_F_REPLACE|NLM_F_EXCL, argc-1, argv+1);
 	if (matches(*argv, "replace") == 0)
 		return tc_qdisc_modify(RTM_NEWQDISC, NLM_F_CREATE|NLM_F_REPLACE, argc-1, argv+1);
 	if (matches(*argv, "link") == 0)

which basically implements a crafted alternative of "tc qdisc replace"
which also sets the NLM_F_EXCL flag in n->nlmsg_flags.

Then, the minimal repro script can simply be expressed as:

#!/bin/bash

ip link add veth0 numtxqueues 16 numrxqueues 16 type veth peer name veth1
ip link set veth0 up && ip link set veth1 up

for ((i = 0; i < 2; i++)); do
	tc qdisc replace-exclusive dev veth0 root stab overhead 24 taprio \
		num_tc 2 map 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 \
		queues 8@0 4@8 \
		clockid REALTIME \
		base-time 0 \
		cycle-time 61679 \
		sched-entry S 0 54336 \
		sched-entry S 0x8a27 7343 \
		max-sdu 18343 18343 \
		flags 0
done

ip link del veth0

Here's how things go sideways if sch_api.c goes through the Qdisc_ops :: init()
code path instead of change() for the second Qdisc.

The first taprio_attach() (i=0) will attach the root taprio Qdisc (aka itself)
to all netdev TX queues, and qdisc_put() the existing pfifo default Qdiscs.

When the taprio_init() method executes for i=1, taprio_destroy() hasn't
been called yet. So neither has netdev_reset_tc() been called, and
that's part of the problem (the one that causes the infinite loop in
dequeue()).

But, taprio_destroy() will finally get called for the initial taprio
created at i=0. The call trace looks like this:

 rtnetlink_rcv_msg()
 -> tc_modify_qdisc()
    -> qdisc_graft()
       -> taprio_attach() for i=1
          -> qdisc_put() for the old Qdiscs attached to the TX queues, aka the taprio from i=0
             -> __qdisc_destroy()
                -> taprio_destroy()

What's more interesting is that the late taprio_destroy() for i=0
effectively destroys the netdev state - the netdev_reset_tc() call -
done by taprio_init() -> taprio_change() for i=1, and that can't be
too good, either. Even if there's no immediately observable hang, the
traffic classes are reset even though the Qdisc thinks they aren't.

Taprio isn't the only one affected by this. Mqprio also has the pattern
of calling netdev_set_num_tc() from Qdisc_ops :: init() and destroy().
But with the possibility of destroy(i=0) not being serialized with
init(i=1), that's buggy.

Sorry for the long message. This is where I'm at. For me, this is the
bottom of where things are intuitive. I don't understand what is
considered to be expected behavior from tc_modify_qdisc(), and what is
considered to be sane Qdisc-facing API, and I need help.

I've completely stopped debugging when I saw that the code enters
through this path at i=1, so I really can't tell you more:

				/* This magic test requires explanation.
				 *
				 *   We know, that some child q is already
				 *   attached to this parent and have choice:
				 *   either to change it or to create/graft new one.
				 *
				 *   1. We are allowed to create/graft only
				 *   if CREATE and REPLACE flags are set.
				 *
				 *   2. If EXCL is set, requestor wanted to say,
				 *   that qdisc tcm_handle is not expected
				 *   to exist, so that we choose create/graft too.
				 *
				 *   3. The last case is when no flags are set.
				 *   Alas, it is sort of hole in API, we
				 *   cannot decide what to do unambiguously.
				 *   For now we select create/graft, if
				 *   user gave KIND, which does not match existing.
				 */
				if ((n->nlmsg_flags & NLM_F_CREATE) &&
				    (n->nlmsg_flags & NLM_F_REPLACE) &&
				    ((n->nlmsg_flags & NLM_F_EXCL) ||
				     (tca[TCA_KIND] &&
				      nla_strcmp(tca[TCA_KIND], q->ops->id)))) {
					netdev_err(dev, "magic test\n");
					goto create_n_graft;
				}

I've added more Qdisc people to the discussion. The problem description
is pretty much self-contained in this email, and going to the original
syzbot report won't bring much else.

There are multiple workarounds that can be done in taprio (and mqprio)
depending on what is considered as being sane API. Though I don't want
to get ahead of myself. Maybe there is a way to fast-forward the
qdisc_destroy() of the previous taprio so it doesn't overlap with the
new one's qdisc_create().

