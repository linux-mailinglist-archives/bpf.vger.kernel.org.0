Return-Path: <bpf+bounces-14272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49F17E1883
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 03:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB8E28130C
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 02:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5374C656;
	Mon,  6 Nov 2023 02:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ybbHZBtV"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BDB630
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 02:11:39 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2054.outbound.protection.outlook.com [40.107.241.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512B1E1
	for <bpf@vger.kernel.org>; Sun,  5 Nov 2023 18:11:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hofazJqlYpcPMhwY/iL1oU6ChBux5hCAIpUJmyfBqq+4SX8uRFhUdS5yW3AypQHfsgLxKKXt5i1pr/PyDkiLDQXq6+ByDf/0bKpcK1wC38TUO4lzS/rcODTdwpizLwmiHI8ia0q3aduzGL97aQTm0j9llbIMljTkhTdv94XEEEx0TXb42dHIDcah/OhLGMCHcg+LBPyZG3b33rqOec8vV9HeaTCkMDs42bybKpH5mdgUWlBn44YePoldXXhMDYEr1vGBj9wLjwbDuSLckjVi6bV5r5yhkW0I3/xrEfOwSNlnvu6cHaJiht/4YCWBT6VQDy2skEk27ZOBzrDErQWIuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYBGvq8MiC7o0yOM+EFkm793MkQiUtALD00DJRwZWKk=;
 b=d6YumR9blJQFeDlca588CamtWfmPFwqjAzr0JbKZCGEuYydJoi5EaghWOq5wnnGY5fkr3N6LthIRmemMDKBcjJj7C8Itebrw750WNZ6Z8+wNtBBKd7Dh/P3YD7C0P6JnuIBpvGvS+umAxS+oBgJKvwgNt+Ve6mNAa7rFIo3bIBUo3D9HmtIOAyWFk4oGwQq2yvw/3lwqTHLUEB0+KGtghblAR6fuPa0mbj6wL1bvwljpFACASBqjEB9XbUGlqez6GFOSjzKrTLr/rjIc3a+oEUVt1/WJBZ2mwY1cFx+jMxiqdGW8si1F4BKqRWcloyivAkmKJoX6Xu8KeIeMl3z3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYBGvq8MiC7o0yOM+EFkm793MkQiUtALD00DJRwZWKk=;
 b=ybbHZBtVIXv04PqR0E2Th/syv2SSPrkzsXL3d9g5xP7XdFyI8nFtRcL/Ppv+NMBG9WRVRj+nwG0SW2Jrc8M0dIKGJD+VXk/XjiDICrmA1a2b1ZZCp16knQq+FVkycc0JJsYVebLNiRhEYyggcK4IfOKFaSgOhRROUph050l0O5QOVt7yCrc+6odvHDVSsObvTvgfBalnWK2t9k/fhz70jirkrjE0mF3lbtyFaOtrcfJ3lK6R6yq5p0e8X9VCZPAUHaZ8/LHbBY+0MlyE6nAvnChP8YiKvGbI0MjiluX6wpzECYKfl3Go14konswJHUC1D4p+hQ9p7x6alThuzinNJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AS8PR04MB7718.eurprd04.prod.outlook.com (2603:10a6:20b:29b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.15; Mon, 6 Nov
 2023 02:11:34 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1%6]) with mapi id 15.20.6977.013; Mon, 6 Nov 2023
 02:11:34 +0000
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [RFC PATCH bpf-next] bpf, tnums: add bitwise-not helper
Date: Mon,  6 Nov 2023 10:11:19 +0800
Message-ID: <20231106021119.10455-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::8) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AS8PR04MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: c809301a-8944-4495-c7a6-08dbde6db2e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AhEMFpt0Xra5AJIiW+IOFSnEqlYJ3J+jV5UoEvtw7AuA6hjPgrvjDEc4swZSHN+MqfHtQjBpo7Dm1ZOntscuEdIHmu62WIuNj4bUkESGc7hn9U47uo00tTCiRc1RdVA6JpCQU/A/2zIEOQW7HFgoTTEIPNp/gFyYoaLIzUif+KYJX9towQ/w8GU2+7IIDdOZHRiACrfAmX4dpeNPtCd0aG01xz9zozPkEM0YyIuTRkGZOb/Ke9U47QH3MrXhg9FFXjE/cRPQeH7utaJS8nLPcJn8lBg95yNp9nom7KDnBH8KLjuj/awX8YlI2igWnCkgOWMUliJ4vQBXpdDoOjeVQ9Tg20Un3zcMxsAd1umIziIhAwADBl03h1cGQPdC0bdinKdFV+N6l6cT+JDlZ4gZKTqRHd5REJCJ91orzthDW3Uh6DM6pL7A7m0yORwQT3DcMr0eEDXDTteJQrrwvxvrbonpE3IZslGwHwwN1CpVsV45P2qg7hARCMqWBEGGjh8swUpQ/qN0Sel70c/aYTH3z3vZHpi95Wcnli0oIp3JcaI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(478600001)(6506007)(6666004)(66946007)(6486002)(966005)(6512007)(83380400001)(41300700001)(2616005)(1076003)(66476007)(2906002)(66556008)(4326008)(316002)(54906003)(8676002)(6916009)(8936002)(5660300002)(7416002)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BNbfzo9BFHdeUowBsGyfA1omhS4tF8rBaEwtiN7NX6qz00nI0taJECPbNaI4?=
 =?us-ascii?Q?mewn5+uBBKB7Y71wxxVy4J+DmKZ+2tBZsTN8D5w9h+JTuGtwyxkE26Srcimv?=
 =?us-ascii?Q?HhF3lwglCPjUXbLDCoGZTGbN7XWuZYXtWtsNY94c8rJu6Inr7WztqyTkRKur?=
 =?us-ascii?Q?ZDMS5DSuvUfDK3pvOFGFbIg677Ho8HjpuoBhSgGkxnCQvwwOM5rLf8H3sjJB?=
 =?us-ascii?Q?+qO4cVJmHnyv68Af3ucT1MnGhuUjJzKqS79kNpZrgViPgvCGcWEHn5ylOT2B?=
 =?us-ascii?Q?210zgW6qkmgMTxmExdENSpwImT26dlqhYQOyHLTl34QfPqa2eIBJaYq3fYvD?=
 =?us-ascii?Q?lgpK8tonF8Gfxrdn+7h8deUildAF6k3GWVU6ooWfty2J3Abtf76vpwjar3mQ?=
 =?us-ascii?Q?wpF3dckt8LijwS4GhMlqWCg/4dmvjygObzlF+n60z7eBHasoCbwlM5ezZKyl?=
 =?us-ascii?Q?/k9TLaWp1e9gyz+PyHONT2bUKw+FE9jRfiHWLSzNeHW9kqlHcwZ75irVVL7+?=
 =?us-ascii?Q?VI53yg8CI0+r18fdbSPiyzKcvd9AmJWPyUYDhAeWkEsqd0+qSg8LRuioGZJ8?=
 =?us-ascii?Q?OFcDLbTPIe8amO5tWNDf9n7QeeENJfVUjnnACYgf9wEjQjfI7FkoKG5jaO4a?=
 =?us-ascii?Q?xIr5lCYnqyRh/aLIHpugKpn8qUYp0F07zq95HL2/y8eDZ4us5RfCW2RT5kfH?=
 =?us-ascii?Q?Vl61KBjluTdH4YodMFfFn1ToJhJudf2bE6GcFY155OwJAjVZnOXJJk+0G5ld?=
 =?us-ascii?Q?Oz//cLdbIqSSKjkueQv1LMQ7ZCyXgIFgmcFucMt3nz5/40RZPNkZHAeqUYw2?=
 =?us-ascii?Q?kt+OgBkR9HRFAN7RyzKzj6Y4kIEYwNIsCf+xb+aESDDpiDHp6O8Ki1gGyrZO?=
 =?us-ascii?Q?VRIRzU/AxTmZIdPgw2qzaYJGHNlAbQL1VbL1gslPJBZrFM9fg6Qd7QGY4R0c?=
 =?us-ascii?Q?/fsvCeIaEagaf0JVnWY5DIQBlkA9LtvW1nbqO5ZtjKgzcJ1WetYYlwPK+iZA?=
 =?us-ascii?Q?NjeGnp19wJLPiWmxVnylm3Nb5HXNGzzkLW+5xccV9o7kTEAv0oYF4OKmq3bz?=
 =?us-ascii?Q?IhFH3Ra4WA/d8ezNzKnsAx6dnSkrLUq4zXphxT4Gccq6FJCFrxK73/XovcJ+?=
 =?us-ascii?Q?98KU+d1H9zrptxvXFA6+xYGGbpStXjaXDbLFqzb3f4kVTg2GKFafj5PZQys4?=
 =?us-ascii?Q?Va9NV1iY0n+COMKE3x3M3eKOIYtjVXyBqnZYzslzj8Rg9/4mzxdsP1DMkgLb?=
 =?us-ascii?Q?NTR90T4UD2gaQBrwy5xR0CE+iuQIErqfmF4tCRrAM3aFjk1tOkENxepwXRKP?=
 =?us-ascii?Q?xdT+L+G2Rnyskl8hdkfzMmX0M3w4cdFnr10qwjNnSkBTbDA1Ew4Bbphx7UK7?=
 =?us-ascii?Q?mnThvbPcw/lvGe9lZslFMQzP4gHT5RADj5appspb5WBHnzPyRaiPBBFacdxg?=
 =?us-ascii?Q?fot3sTWevcDnFlWDZFq+1tP9RegF35YQF0xz94ncQMdMmL9l+fNSaOdudmSI?=
 =?us-ascii?Q?tjr0dcjWrhtlB1kof+6jDeIRTc+UxMp2TgXn6mUImc7piDBY+KIn8hFtfNeG?=
 =?us-ascii?Q?oXUs0bKv/j5gbkj+auCogQHgR2cZaRPyVUEj7ArnTY+Ly8GzfSLUIMGfOB/x?=
 =?us-ascii?Q?08yNI1ThyWhW88YACAIaPQ968Ef8OQQ/ODnuGJEZqgxVUlrFE05stT2WWnPr?=
 =?us-ascii?Q?pCxn9A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c809301a-8944-4495-c7a6-08dbde6db2e0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 02:11:33.9218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7wlVGQ942YoRI8sDWjgG6umKoWCBr6Ymw6Lf9DhcBjfeJat0l2fSWEPniT+aFSXzCvE+1lSI9aM9a56GKBzjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7718

Note: Andrii' patch mentioned in the Link tag isn't merge yet, I'll
      resend this along with the proposed refactoring once it is merged.
      For now, sending the patch as RFC for feedback and review.

While the BPF instruction set does not contain a bitwise-NOT
instruction, the verifier may still need to compute the bitwise-NOT
result for the value tracked in the register. One such case reference in
the link below is

	u64 val;
	val = reg_const_value(reg2, is_jmp32);
	tnum_ops(..., tnum_const(~val);

Where the value is extract of out tnum, operated with bitwise-NOT, then
simply turned back into tnum again; plus it has the limitation of only
working on constant. This commit adds the tnum_not() helper that compute
the bitwise-NOT result for all the values tracked within the tnum, that
allow us to simplify the above code to

	tnum_ops(..., tnum_not(reg2->var_off));

without being limited to constant, and is general enough to be reused
and composed with other tnum operations.

Link: https://lore.kernel.org/bpf/ZUSwQtfjCsKpbWcL@u94a/
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---

 include/linux/tnum.h | 2 ++
 kernel/bpf/tnum.c    | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/tnum.h b/include/linux/tnum.h
index 1c3948a1d6ad..817065df1297 100644
--- a/include/linux/tnum.h
+++ b/include/linux/tnum.h
@@ -46,6 +46,8 @@ struct tnum tnum_and(struct tnum a, struct tnum b);
 struct tnum tnum_or(struct tnum a, struct tnum b);
 /* Bitwise-XOR, return @a ^ @b */
 struct tnum tnum_xor(struct tnum a, struct tnum b);
+/* Bitwise-NOT, return ~@a */
+struct tnum tnum_not(struct tnum a);
 /* Multiply two tnums, return @a * @b */
 struct tnum tnum_mul(struct tnum a, struct tnum b);
 
diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index 3d7127f439a1..b4f4a4beb0c9 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -111,6 +111,11 @@ struct tnum tnum_xor(struct tnum a, struct tnum b)
 	return TNUM(v & ~mu, mu);
 }
 
+struct tnum tnum_not(struct tnum a)
+{
+	return TNUM(~a.value & ~a.mask, a.mask);
+}
+
 /* Generate partial products by multiplying each bit in the multiplier (tnum a)
  * with the multiplicand (tnum b), and add the partial products after
  * appropriately bit-shifting them. Instead of directly performing tnum addition

base-commit: 1a119e269dc69e82217525d92a93e082c4424fc8
-- 
2.42.0


