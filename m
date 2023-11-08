Return-Path: <bpf+bounces-14458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32BF7E501B
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 06:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFB9CB20E28
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 05:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F180CA53;
	Wed,  8 Nov 2023 05:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="k46/9qEo"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA193C8C4
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 05:46:26 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2055.outbound.protection.outlook.com [40.107.14.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D6110E
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 21:46:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2+W6kdip1rRY8RHwc/21j2aTDQRKdK2+ETvZqk3kTJFRwTQJlVLHc3edKstD2waGcIOAWLVIlR7CDuPzNlbAK+IWDwzvQ+O75REGGsdcFy1QZRXrB1yf+wSnCMMHJJzB+NIinVQPeQXEmsJYuGh1KxbKTPn9epDdPGTH28PYeop0kcGAdW9sprZIcPYztCha/78IyefkFVK0EDbxOHibALei4msIrn5D9Mpl/haFS2JTvpVdUC3ubwPci04j7xq7Is/YRx+iTm15njZIPSjPdtloOHYhPTiM2rKmaSEFHAPZbpm1M3T0FpkBkBlHk6lEb63Ta6YQOBY79Qvwl6Rpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7FgR6llU7AjQpBKL7Kt0btcwpLa5OIX2XnfF2LstsE=;
 b=XzlIQQdGr+pgnpOqm2zj6NHwZQQ2CweVkUqUn846XLEVrLN/yNjogMKlTrdDoYUg7AmiJoK5gS6ZmRvOFK4RQDKIOQoPbV3yCGOG8H+w3X7Y0+Qic/t06cZejFna6XrNqU5vWBBM12YFDPmNeURKpaVWFgVLfOFW1izP3nEAw+h46G5tr6u/w5LQc0zJPep8Y2HcUEPWotEnA7TcqVFbo9JtPrzZhZKuPH7y98cBk65VpQzElNsD6m2vXbnkz0vIiebLoB//hSMguhgsU67k0IWnROefak4pzF+we0nyrfbWP48p8WpvrEL9JMJmCFgOV2VwDxEIbLkVX5ulYWBzdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7FgR6llU7AjQpBKL7Kt0btcwpLa5OIX2XnfF2LstsE=;
 b=k46/9qEoYmeKmDOgfvtZMp6p5ckwCslNelA224UP13ex29lbBCeH4F8jrqUsDStAHHkUv4WxPA/jd2F0SK7lYKKyyH/HTmhFAavhRKt1KnGXZ0KxGig3mWhXgqCHNyk/DarHWp+MfTvnmXA2mhkHwHgIlriE99VHJoBBYpnxyxRTiZ7KyqIkkk1MLNVYgf976wWAlz3DK4EAMYMkCEugceBQ7+S+jg+kkjfnQiq5LlJdJHmTHl6CtGs9M4XPm3szN4hA/fQH2k9Bv5EAJvfzh1GKwYTAs6ZKLzJlJnBcgmilHXd1q12gHm0FSM6w6WqApClM3H4KUsqPSZCekajDyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by PA4PR04MB9568.eurprd04.prod.outlook.com (2603:10a6:102:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 05:46:23 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1%6]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 05:46:23 +0000
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Paul Chaignon <paul@isovalent.com>
Subject: [RFC bpf-next v0 0/7] Unifying signed and unsigned min/max tracking
Date: Wed,  8 Nov 2023 13:46:04 +0800
Message-ID: <20231108054611.19531-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0284.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::15) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|PA4PR04MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: 40698454-7d48-40db-2edb-08dbe01e0a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ra5+62iD5LFOwf9/yJFdSGNVZWPRjKcy4y3X3uF/oaYwIcRWzTyDtqwiclGZua8g/Jd6qRlocseJHNBWa7m1jvcRSsDVPVmzc8fQy6O7JHzlaQUExkJIKMulEALLr9MZ9DvKcFis9G/PpxVZ6Ho+30XZ5lDACRHO9E3ZQqHLyzxp+GuKeNFWx2dMnuD0dhy04Oq2fZWWOJXv9x/dfhxXvV0YfHWjWtQY5j14IvK/Rt3JcLdUPDcesmkmI6GZW8LMRSc6ZoqktUIYCdSd9r3MJn03dtc2kXUr802+YIaykabrpl8rYNx3MSfQpsvRtGPHcPBXXs9hQYZAwwAqYXIc1cQe/k609RPqhnOB4WOC23Lx5JWaKPrSFn5ZLk63xrxjw45Jmv/sFGMZr+wIMVWtoYe0kbhYbBFiYv0KMOSVDMQUnQYL5S6+YmASS2JL1DyUBZObb50JF4rm7nV/gYff8gn0cRA/JP25YgICni3X0Me7m+1/uudIc7nGOCEcNbw0g5RG1+l7JKw6cBsVVQY0vBpAQNLR9Kn5IhL0h7n9vcqakuE2lDldw/4Cf8jRKSllIeWJBBertK+TFiy8MUsclA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(66899024)(6916009)(316002)(54906003)(66476007)(66946007)(66556008)(478600001)(6486002)(966005)(6666004)(86362001)(5660300002)(41300700001)(36756003)(2906002)(8936002)(4326008)(8676002)(2616005)(83380400001)(1076003)(6506007)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xUcWFwnOS6xFwaxdH/KvEm6OxqmDXZdQAFUA1ZrkZUzx01KLYV1k/bWN8VcW?=
 =?us-ascii?Q?IqLpOg3iVRQfn9rJdBgEirMgZn0F17zQoeLAMAb3ez4ED14Ov0pkn8LwgxCI?=
 =?us-ascii?Q?dt6hudi4ptSCs71E0AOzcNEur7+S2/n2GJJILoGY3QskbM4snM+n5dGHj/4N?=
 =?us-ascii?Q?umx8gEfL9ePFhU7UkvIR8uBTp+OVAnurtIjLPpbpMOA3/trcpGODUEiY50n2?=
 =?us-ascii?Q?Hk/qWaT6oqHG2dbzXlBqimvmsSOfEugvYlllV+w2n5cJdXx0nsjuJRsoCLjb?=
 =?us-ascii?Q?aKkZjzpExLtmTu6MZBoOShgqNVKmgoPEDrjUWy7fIVEGq1g3VkrUQ0TV8QgY?=
 =?us-ascii?Q?/jdCrxj+aJdfSR+2J+YxTjeS+b/YALbZx0srUSekR54CFokLkVAPr1418B0U?=
 =?us-ascii?Q?Y+CcSeFhEnIqXkHMNBWLDemI2IYUBQmOIxcFwlnJ0mdYjcO14vxBgf8I+2w1?=
 =?us-ascii?Q?VwrQoDGIEBoUNwfBTgN/TUoNNvYvC5/Y8gJbzQBlRNhLdZXcUtzuKWnbIaxD?=
 =?us-ascii?Q?LWFjiyi+javaoSAOtpwWeLZ6t0PK3fSWLHhY78S2rpQ8qpmp+EokmYx7Lc4Q?=
 =?us-ascii?Q?kKYYBpulAGRwrHS0x/wYczDRAnB4143dA3NLdaYdfwpR9J79RJMS66JO6sxw?=
 =?us-ascii?Q?EFjUdhWjoj2/RAvqtRWgAAbARgoAwpppVD+msdeSX5rl33CshVNk2uxb1GF+?=
 =?us-ascii?Q?Q3PbaffyrqT4WF8yG2aa6ZNVy4lha9B4Vo76G4pa4syXGMjea6kZngAwdT0D?=
 =?us-ascii?Q?plXq/zvk9bjdwIBJiisOI4BM5DIrwNkWv2C+7cT8gmN1JSCynRR7OVNkEgK8?=
 =?us-ascii?Q?FdKvXH5jOK9VePKdPR7s714Fl0z1OGVvV4kz1ZElL4jSnawZCp3In/A/DELm?=
 =?us-ascii?Q?LU8pMwQjxFyt7HbnbtmClesTkuhBWKdcxM+u9EScsPXmiydN+3DjlVLiqjbU?=
 =?us-ascii?Q?0hL2cayYqEbJ1rXU03LYd6T2fXNhUF7XjgyjJlVIaAmMBD4tcpihFoFToHjZ?=
 =?us-ascii?Q?X7LftJnJ/K7S748laZPQb6+nWrPXW56SKCq+icZO+p2DmjqonCDpEl6wYlks?=
 =?us-ascii?Q?UjFoZNjguImKfxH9rp7wwV6XvWOukV7ywJZDVSZnyI+nJTIWxm8XOX4GGBhq?=
 =?us-ascii?Q?DnjWGTM5pVN3cFdxZ51sN2z73HQsKG5LrkscG4cDiJ0Cx6oXDAYtAuvaRZ9P?=
 =?us-ascii?Q?dSrrTBBz3ph6Y0GFhsp0ULzeNZMGu+RFz8Ifx0UHPqtCW/4yCufo0DJdGh0V?=
 =?us-ascii?Q?pvF+sfXbJy29MJ6XRk3raXMuQ5Xsv7u8ppnZv3/QlzGkP4KV+QqdNYk8pI9T?=
 =?us-ascii?Q?Z3smmlzaF5kVIwdaWCt8K7Z9iKy1VSo2UGzjjI9kn1t5MSnvMuDU3HNGO6l7?=
 =?us-ascii?Q?Y6cmiS4tyNoM14QbRwdjgayTkfXjIW51CIbDUDNb4fdfJqxs7/IjGA7jp0pG?=
 =?us-ascii?Q?xZBfUCpghpgcaHvqL/YXbZ7bqBB8eU0zvWqzqg9j2dSEQrdO96bsErHD7m0G?=
 =?us-ascii?Q?jjs2oNjTEm4CR7oTqjAA649BCJIJeNqQAdAMHvVDd3S7t5+6q1z+bw/3glJ/?=
 =?us-ascii?Q?+35TXN++eEGf+JO4MEy+UKmaapzzwMzaG+uz7GXTmtAK+P8XP/qbohTdGeR8?=
 =?us-ascii?Q?b8W+Ym5emO7zI/8THxGhDrGzPST30rK5ym/CDHHFkNci2+RD18Kd0Jhk7PMd?=
 =?us-ascii?Q?vH+ASQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40698454-7d48-40db-2edb-08dbe01e0a1e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 05:46:23.1329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYzEzQkgp+TbThdqNB15tsaOkNZgHy8c+u1scavmIfgwAPwRxpMXLRNTtCSm/Vk6LSwvMaspEvAUk4i0YZjsXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9568

This patchset is a proof of concept for previously discussed concept[1]
of unifying smin/smax with umin/uax for both the 32-bit and 64-bit
range[2] within bpf_reg_state. This will allow the verifier to track
both signed and unsiged ranges using just two u32 (for 32-bit range) or
u64 (for 64-bit range), instead four as we currently do.

The size reduction we gain from this probably isn't very significant.
The main benefit is in lowering of code _complexity_. The verifier
currently employs 5 value tracking mechanisms, two for 64-bit range, two
for 32-bit range, and one tnum that tracks individual bits. Exchanging
knowledge between all the bound tracking mechanisms requires a
(theoretical) 20-way synchronization[3]; with signed and unsigned
unification the verifier will only need 3 value tracking mechanism,
cutting this down to a 6-way synchronization.

The unification is possible from a theoretical standpoint[4] and there
exists implementation[5]. The challenge lies in implementing it inside
the verifier and making sure it fits well with all the logic we have in
place.

To lower the difficulty, the unified min/max tracking is implemented in
isolation, and have it correctness checked using model checking. The
model checking code can be found in this patchset as well, but is not
meant to be merged since a better method already exists[6].

So far I've managed to implement add/sub/mul operations for unified
min/max tracking, the next steps are:
- implement operation that can be used gain knowledge from conditional
  jump, e.g wrange32_intersect, wrange32_diff
- implement wrange32_from_min_max and wrange32_to_min_max so we can
  check whether this PoC works using current selftests
- implement operations for wrange64, the 64-bit counterpart of wrange32
- come up with how to exchange knowledge between wrange64 and wrange32
  (this is likely the most difficult part)
- think about how to integrate this work in a manageable manner

Feedbacks for either the code, the naming, and/or the commit messages
are all welcome.


1: https://lore.kernel.org/bpf/ZTZxoDJJbX9mrQ9w@u94a/
2: To make model checking faster I'm only working with the 32-bit ranges
   for now
3: Synchronization can goes both ways, e.g. exchanging knowledge in
   umin/umax from/to tnum count as 2-way. But
4: https://dl.acm.org/doi/10.1145/2651360
5: https://github.com/caballa/wrapped-intervals/blob/master/lib/RangeAnalysis/WrappedRange.cpp
6: https://lore.kernel.org/r/1DA1AC52-6E2D-4CDA-8216-D1DD4648AD55@cs.rutgers.edu

Shung-Hsi Yu (7):
  Add inital wrange32 definition along with checks for umin/umax
  Lift the contrain requiring start <= end
  Support tracking signed min/max
  Implement wrange32_add()
  Implement wrange32_sub()
  Implement wrange32_mul()
  (WIP) Add helper functions that transform wrange32 to and from
    smin/smax/umin/umax

 include/linux/wrange.h                        |  61 ++++
 kernel/bpf/Makefile                           |   3 +-
 kernel/bpf/wrange.c                           |  61 ++++
 tools/testing/selftests/bpf/formal/wrange.py  | 274 ++++++++++++++++++
 .../selftests/bpf/formal/wrange_add.py        |  73 +++++
 .../selftests/bpf/formal/wrange_mul.py        |  87 ++++++
 .../selftests/bpf/formal/wrange_sub.py        |  72 +++++
 7 files changed, 630 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/wrange.h
 create mode 100644 kernel/bpf/wrange.c
 create mode 100755 tools/testing/selftests/bpf/formal/wrange.py
 create mode 100755 tools/testing/selftests/bpf/formal/wrange_add.py
 create mode 100755 tools/testing/selftests/bpf/formal/wrange_mul.py
 create mode 100755 tools/testing/selftests/bpf/formal/wrange_sub.py


base-commit: 856624f12b04a3f51094fa277a31a333ee81cb3f
-- 
2.42.0


