Return-Path: <bpf+bounces-4950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03DA751F39
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 12:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CAA728151E
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 10:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9FE100B5;
	Thu, 13 Jul 2023 10:47:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3315F611C;
	Thu, 13 Jul 2023 10:47:27 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2100.outbound.protection.outlook.com [40.107.22.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72F6212B;
	Thu, 13 Jul 2023 03:47:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5XcH0bCh+IlnBg/yWZWXFjOxgtjAeK9CVRoTSSZeLriAUkoi1Mu9brrSMTx1694b9ucS09XdtTpq4Gh9DrsvCfSP+YrThqzzw9i+jo0piBvlhw71Yzr58UX4prGSFVty7MlrEGgeo5c/bMInszKqZ5cwqbLEuZDSjJCLs4loRNXIlPNql3TIZ7JKWSm5vx6ULNff4Yjhkj60CKUYdgXiqtmbB8x+7mzX3bWwgdz26aS++8yWCrKtOt+nexvfR8lXn6aAgmi99PVL4XqmbgLE4iyeUWEZvIKJ9z4d9tq0jYIobwSccqkJpJLOFEUULryiKJDCCTSP9KCrxPLrQZPGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CihBvuD+7hlBQHQK1ZNt0WQPvDlcobYidD3EXpLi02c=;
 b=VlQpZagTd+oKmPD22FHX6s/IDW1445DsDpIJOGrNjihA59N+gN+2Y2mYc6/X2+NgCIHQ//do9MwDfWrxniTJwS+ev005crfe3W8n4kHOd5oy7A4sEsf6ahP0MaY7mPaLEPCIDTuyCuxPX2+1imutxeGrsKHMFQqTTHzvIDHGJ3QXesQouBMM/IQSpvPNsDk4moJ4fuM2ypUD5EWRJnZ3KmB2SfEEE4LBlP7+xNOauXiTCGEgy49FMOq2eVlzLan9g4zCtUax3aM+8l/aCRLPx59uts/9zsQ0t/dTHPJwqxH/3G67G2OQLuRfiOCZfhVKnAyUOWzfpIeaQfSLRho6iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CihBvuD+7hlBQHQK1ZNt0WQPvDlcobYidD3EXpLi02c=;
 b=AXmAw00SQGopr7zFQWPLFVtUtwAWGP0lok2zIZ//3oCjUjsi5GTihyTww24hYdK0Yrbil1LknaXIZfzUBMi+3Nyqf7ug6MUOMgtpg+y0xj4OJQkEnAmkqVIbpwdF95vYys2Bkf+gIb9wgXk+uZiOyajjg1uN1MHWJRMP1V5/d/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by AS4P189MB1917.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:4b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 10:47:22 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6%4]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 10:47:22 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
To:
Cc: intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Simon Horman <simon.horman@corigine.com>,
        Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Subject: [PATCH iwl-next v3 0/4] igb: Add support for AF_XDP zero-copy
Date: Thu, 13 Jul 2023 12:47:13 +0200
Message-Id: <20230713104717.29475-1-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF000000CF.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:2:0:8) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|AS4P189MB1917:EE_
X-MS-Office365-Filtering-Correlation-Id: 8acaebf3-68b2-4715-37f1-08db838e89e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lv/0FFt9JiIazc8n6QoQlwori/76EUrwl2CcNYE2y1iUkLgv/ySBRBsE81FnjQTPT9iZtDpkOxNqoo1tnpf+FkRetqstbMoqSiHnq/WODojamcrZs05ql9oeEGUHg1rN6niYGav6ZwP2lw9W1n9KxECczk/OTmGsga14fT1Mg0clBJNgXMSWJW7WLRUmq2RrwLycQXbLRkeF/GdBTjRDLoQIP31r8+nyZCoRuCL9+8AQiupwD9xnNBUzeuHXJbQNaVILNLJruJG4WznhfFHU/LTvi2H7AXi+zHrJdl6nRB3UARiz1i5BG2AJBA/BG6xkqjetCWK/R6l2/3htgbDajmsu39Y1HcPkw7lkMxcaumy5WHcJ5Wiy/GAoZBT4B+MLigAeQVJ99oWQlt1580ECbrwQWjvO72m35Zkp9/baNQCnvwWTnLWVd+OnIhFT5A0ZmBKlUoWEyVSqRKRai9Gs0c7kiFobqCJIiR7npsewR4Po09NFb32CiWPmSWXZcq5bb7KUL8e94q3C83360b4gMxeq3j48eWBva537viBVq9Tj+mnyqU7uipx3J+qXNTTEoN5eEWZMANBmJyQabM1pVkHTl4uAQe28n1R6UXNyi6sicsgytLsUTnXqo3PaPfY4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(376002)(396003)(136003)(346002)(451199021)(109986019)(2906002)(41300700001)(316002)(44832011)(7416002)(5660300002)(8676002)(8936002)(36756003)(86362001)(6512007)(966005)(478600001)(6486002)(6666004)(83380400001)(2616005)(26005)(1076003)(186003)(38100700002)(6506007)(54906003)(66556008)(66476007)(66946007)(4326008)(70586007)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hQOzuOl+DePL81G/HuyXSlYh37BEiz7mYwT09UictkAl5WVpyAtlO7QbsD4m?=
 =?us-ascii?Q?6BxhCTeOoJjasF7qisV5XIzkQVsJ5ZxlYBfIzE7/EVY9093njl/824NXRbRC?=
 =?us-ascii?Q?Ai0sI24JJYttzAeR2LeXCT5BkPD0paFuRQvqrcKaPasvm9Q5tEYz8cpL2ln7?=
 =?us-ascii?Q?8qz6aPonMXiXhoBnfAZeckU49ezaALIuO1k0X2knh5kIHmW1fHcesUiAO5o3?=
 =?us-ascii?Q?KUWT38PvItBQozL0K76nVlXwDszMwg0Etmdh9krjWS6aRNxafDMC0n5e0xKm?=
 =?us-ascii?Q?auf3aMqj9COKczy/K3jusTo0hgTE7E3bYSM0qKmIA38jBV2SYYcpG5dW3VSE?=
 =?us-ascii?Q?iiTFpVGXSjkWTiW1QHHNxWg+rxRH6SSnshicEkbXOFOYUGqOy8kIHmHT+5nb?=
 =?us-ascii?Q?WlComjvdb0hSVDUg0mNOr4R3gfYo6ZWZV+SeMicFpxvGUJU43oaqZ89+i/Fw?=
 =?us-ascii?Q?G2Znwb5kf5IPupz6LMRvjtvQcF4h5hFgo10d/y7NJceKVhA9gQQl9ycr06Af?=
 =?us-ascii?Q?fEzZLUljG3huJTV812lmARoYTzxfC4B2qKyB5aolr3k9CiNa6ILkaVIq+2z4?=
 =?us-ascii?Q?hsc2lxzq+LnW0n3joRcj9fGI5ehzcsz7nYg6iP1vlR/vjFY8JlCiTK6ah6P7?=
 =?us-ascii?Q?Jqn+zjOdg7EVaMJu8xYAmAW2OUya02RmmAf20tXdlLbkSeyhtSvjfHy04pVO?=
 =?us-ascii?Q?iNETTl1cNDwZVq3lLkIKBUaOjtIMZJuSAB/8kKjnqx9Athvbp8MMptxHBTfk?=
 =?us-ascii?Q?/lF+aOy+/gQIVY/Ubo7hw0qe/fdR1BfPKtYGFWekog2D5nqtsnOS7ImmibX2?=
 =?us-ascii?Q?vpqV93HM3XK9xpCfXvRVs+YNTuGChQ0my059gjBjPI633BzTq+0zhwYMksSD?=
 =?us-ascii?Q?l4TpL1bgPwSdUCyxD1dP+Mu+KLuRUJxb/ytGm1+TpPr0oUTu0oUf0kTwPYe/?=
 =?us-ascii?Q?RX8qoX3dIk1qVlOTNivw7CoNquMv3Ybtezg1tprRV500DoE9KL/K52z6cT8y?=
 =?us-ascii?Q?2DYCDf0vfuvEmr0Ekk8WKKWwYsof13wn+M8R3PeAQPwGF31liL2jD6klaosi?=
 =?us-ascii?Q?5LhjxK0hmHWopBP72LQyH07xD+IXm9jZKfGwmrmVCj+6y8k4e2TqrBt4xSEC?=
 =?us-ascii?Q?rP6Or71oRNcB3MYLXRWl2Xihzdj8w2j4w9+M6VVoDYILgQQc/gnAtSapC2iN?=
 =?us-ascii?Q?VqW0SEs+NHwGsa3Q3gNmwrZUUMtIFonX37KA8I/DJD2kbM8YbrDyZSvkbnUK?=
 =?us-ascii?Q?i2vGk3Uy6BKYNTHNhE9k6BjHFTFPILTCQ6ObuPuu8GnZtkLX0b/ZWQSI3As4?=
 =?us-ascii?Q?M2H2BYBjFBrnq6+m8NQdQyJbW5eCD541Rlg9TQ7903aZ4R/CHPG6pTtDZRv3?=
 =?us-ascii?Q?x9+EDevr8roHR8T85rFCEiDEaOq60KUDhNplB8JSH0NzLFhKsF4OtZEPXfqv?=
 =?us-ascii?Q?S1nCfr9Pbm6rWGAWxM67mjsbeFNNKPjzXYFLkEfveS/f+gqq/LQpPq9DD9my?=
 =?us-ascii?Q?0h/SgFAXKc8j7qBJUCspvfMICKYuVj+oznRb0U3VftkA9MF3XLauLE5P5/n8?=
 =?us-ascii?Q?jEUBt2yE97UNsizOPuF+os1zEuwxwbbWqPOH1kHS8EtGJMkEwigLh0J/Mvdn?=
 =?us-ascii?Q?lQ=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acaebf3-68b2-4715-37f1-08db838e89e5
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 10:47:22.6699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: losyBiG6AhAQUul1V0Ih+/bV7odP/Sh9yx3SPntwUA9QngSsTbvhYiMAqCVvYeYcJSA49EzNg8CL65iVr3g/ylPOUcNGfHBoOJE9J03xXrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB1917
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The first couple of patches adds helper funcctions to prepare for AF_XDP
zero-copy support which comes in the last couple of patches, one each
for Rx and TX paths.

As mentioned in v1 patchset [0], I don't have access to an actual IGB
device to provide correct performance numbers. I have used Intel 82576EB
emulator in QEMU [1] to test the changes to IGB driver.

The tests use one isolated vCPU for RX/TX and one isolated vCPU for the
xdp-sock application [2]. Hope these measurements provide at the least
some indication on the increase in performance when using ZC, especially
in the TX path. It would be awesome if someone with a real IGB NIC can
test the patch.
 
AF_XDP performance using 64 byte packets in Kpps.
Benchmark:	XDP-SKB		XDP-DRV		XDP-DRV(ZC)
rxdrop		220		235		350
txpush		1.000		1.000		410
l2fwd 		1.000		1.000		200

AF_XDP performance using 1500 byte packets in Kpps.
Benchmark:	XDP-SKB		XDP-DRV		XDP-DRV(ZC)
rxdrop		200		210		310
txpush		1.000		1.000		410
l2fwd 		0.900		1.000		160

[0]: https://lore.kernel.org/intel-wired-lan/20230704095915.9750-1-sriram.yagnaraman@est.tech/
[1]: https://www.qemu.org/docs/master/system/devices/igb.html
[2]: https://github.com/xdp-project/bpf-examples/tree/master/AF_XDP-example

v2->v3:
- Avoid TX unit hang when using AF_XDP zero-copy by setting time_stamp
  on the tx_buffer_info
- Fix uninitialized nb_buffs (Simon Horman)

v1->v2:
- Use batch XSK APIs (Maciej Fijalkowski)
- Follow reverse xmas tree convention and remove the ternary operator
  use (Simon Horman)


Sriram Yagnaraman (4):
  igb: prepare for AF_XDP zero-copy support
  igb: Introduce XSK data structures and helpers
  igb: add AF_XDP zero-copy Rx support
  igb: add AF_XDP zero-copy Tx support

 drivers/net/ethernet/intel/igb/Makefile   |   2 +-
 drivers/net/ethernet/intel/igb/igb.h      |  35 +-
 drivers/net/ethernet/intel/igb/igb_main.c | 181 ++++++--
 drivers/net/ethernet/intel/igb/igb_xsk.c  | 522 ++++++++++++++++++++++
 4 files changed, 694 insertions(+), 46 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/igb/igb_xsk.c

-- 
2.34.1


