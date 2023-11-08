Return-Path: <bpf+bounces-14465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 403CB7E5026
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 06:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639421C20DC0
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 05:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E5BCA58;
	Wed,  8 Nov 2023 05:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IAy8GGxI"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64320C8FD
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 05:47:20 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D551709
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 21:47:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3/ys56EfBg/0GmRHCpsLin0uzvcOHDf7utF8N+In4D4TudFCHVWwtoVjYWeTJFdgACLbD5gtMHTnHY0Z53ZAb5FQOltNox99AY1/qS4TF214GDqj97ZPh9FCZeUmmnPe/coY7czxTXSx4bMuSRa1qNK6ICHEuDT2t4Nxm7uuSJVrI1obLvzBy2GO2j88GtJVUUPEstndGRAvxSGoLc4hkwSVk3Tk6h7pRgZcIKvH6pK2vyPhlvCg/WKI+w07IJ4TYs/J2VwG6PkKnP4vSDNZNNIP9MDroKduLbEB6ht24cicAfOWLdreogKBYmwwdvZrFKVPYdCtKSUPJRu/FzwWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jKmUCG8VbuXO7u32x/KWAKrtykMsgwTAgsIJtzwysY=;
 b=P0cpI75fwNRdPMcd8xnw0zPoRc3oHR2SbTYfuArN58QCYEr9wGvuWnK4g7fXcbdbqbIfZetd5EkWW3m9gmF6ob6vNYltE1N+M13qhga4D13AxXhulxEJAF/1uyg9/81PdTiuwclfKCUaPf1gpMYfU//8wSNWe5miGxvR65FaxGenHNKDSA1uQTQeiCO3S5UC8cOeVBxsCTkAkfQpcY/2FfaaboutXLs2WlxxIsBitxhoafkCa3oB1lO31einfqIt9S9WJz5cBwpe91eURkz2HQch4b68lR/q6+Goo4YjEz4n1wGpbD8RaO/xM4tK2VgP9WX2H22HBvZ8Hg736fxwOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jKmUCG8VbuXO7u32x/KWAKrtykMsgwTAgsIJtzwysY=;
 b=IAy8GGxIrh/rolKBuoNmI6mx4wGPvoRX4zvwgAjp7afOj9TZO+k7++k4e5nnqQE8D5SlKOmV3jLqLPCt/3qI5URi9E/BFMTDEnktp4NCUWLmL6jGq0jTBiSHvi9FuBxmdTHCWbAEA1K4aMhufVpFl8Ghmy3MasLZObMOUWtYKRVpQ+xWaueYtiUA6SsSoIal2N/hrRdoDmR5cIe1AfJQoTEY5ek/9nbh+3zwjCDAiTASoW/0A7+okzbw7NI3kYSfLMzYctVE1z/Vqj+XaVMZP0X5Brq/SAdM6/aLkTzGGHR4g7/xyLrF4z6OdaTfxcsyoYVcUxqOwt8GABr0ZZxQrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AS8PR04MB7816.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Wed, 8 Nov
 2023 05:47:17 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1%6]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 05:47:17 +0000
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
Subject: [RFC bpf-next v0 7/7] (WIP) Add helper functions that transform wrange32 to and from smin/smax/umin/umax
Date: Wed,  8 Nov 2023 13:46:11 +0800
Message-ID: <20231108054611.19531-8-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108054611.19531-1-shung-hsi.yu@suse.com>
References: <20231108054611.19531-1-shung-hsi.yu@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0329.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::13) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AS8PR04MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a8bd74-878b-4f74-db11-08dbe01e2ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7hkFf3kRD6WlIeX9IIjffSkw+d3D8xnnMEfrudh8l2L0Su+1T5pYI1TmKGroYq5t/iKJ+dVFSUdlf88lahixIrWG12Q7y7xce4tkjEEhmQQORJIHfcJ2g66lP48eyg+9xZmh8O7JH7kCjGfcUTXsAwQ8o7rRzdso50w9iIF93oFfL7qFqduDN4xXb3jd8QiRovNdMNh/EL5xWeTsJy4OulqgdeJXPxhXGeQuE225h5IyO6gjKPKLDMp921bwKj7LOTE1QuXG1mgI3vJ9WCotSDaDbwtUdqZrrJnNZxNpxWIZ1sSnbpvmuriLX1rN+HWXTHQg9FfYt8yvwTdU1MZISG4xTVi6bF4EntCAoNSLnYfFXYPg7dzNn6uQ7ZgRg88yz2LilGz7fW/lOqJaRaj3tQMPhW8yyvzhd4gXgEgHVRHQ9kGdxsOGrwazMQL1SBSJkO67pMGZjq6NzonJNRhfnsWlsf17BfAVJfxIva9yTCK9m+jLNWKRqK4kdDZKhFoieDeMwv7LqjVBWT6AnyIJof2Z1BuJJ+dYVMv4OAJHnV11GV1zTa85jf7GuVo/vxxF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(396003)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(5660300002)(8936002)(6916009)(4326008)(8676002)(6486002)(6506007)(316002)(54906003)(83380400001)(66556008)(66476007)(36756003)(38100700002)(41300700001)(2906002)(86362001)(66946007)(2616005)(1076003)(6666004)(6512007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2CgkDNIfbYczwZacKxy3+bQ3/IDNm2mC2Vcaufh9/Csv2y9hqJd04wvsWj7t?=
 =?us-ascii?Q?m86IWGF9B90dLl/rPKlOaMEUCu/9lXdHW9iyRrcUC0yvPZoBtCvw2TFq1tsl?=
 =?us-ascii?Q?BLdqxTodtZ8CDgww9SGBPSHJv0G2++NqvzCmetuXL9ENBvEkWbf5YNc7iV9c?=
 =?us-ascii?Q?FjXtL5AeTWF4LMlivso5NCwEYwCjYtecFliDY+g1SGwNxF2nxojdL9fCZr/c?=
 =?us-ascii?Q?Yu0FZfd2cPDxw9bJxJ+Sn6Fa0DPpG+fyO0xc0/ks+i0XuNySJPwOimhWlrgA?=
 =?us-ascii?Q?I3B4BQCyEcYtW+ePhY+oMu9220Lh4GwaSkPTdUrQJeYcQVhuq3YF2iN6vNiu?=
 =?us-ascii?Q?hAkZ/y6Y5n2BH4RxjBX3wGjbNyiOY6Zv1OlSdAT+spMOV+QTD0d8vLMmtqXq?=
 =?us-ascii?Q?2RoCphrzilb5I6Vo60Ey1LjbbE9l1281be43xOQxHiIlx/E+aSEZwd2wQ5KM?=
 =?us-ascii?Q?HphwXoxZmJvP8NiSOJANIXjEFwuLsZAJ5g03aXXAxAPNcEleJIo0VMoEBB2J?=
 =?us-ascii?Q?xQF53OTFJN9kA5xLF3+X7gMFDPGkVOmKJ4tPgYXL6kODcofu4TBNnbkewZA6?=
 =?us-ascii?Q?4loAdAJJBNFXb3THEG5zJ7qDK8cSRk0dQFoZLhWTQizkLG3VmpM8l2IK/0O5?=
 =?us-ascii?Q?sJRqFBqFMHa82hx5SMfZHt76cNRpMIZfkkVwlKhJcN+0p5u5R2M+8xI/2SnA?=
 =?us-ascii?Q?7GL0kVd6PDrV/v8gtfVyiHkIku/wVsz9fUgIyzFGtdCn19Ihas8ExTkHaCe6?=
 =?us-ascii?Q?SfDTRSP30OD+6qSmJYU02M1r1iOcvaaPjS0D8oSlSpHO95uSw0z8FuiHaDpX?=
 =?us-ascii?Q?9dZexnNnRd9gA/iIRYNd3Bk6AjDhB3Alyh3FSz2y71wbeAXcyCDr/lCwtM7d?=
 =?us-ascii?Q?E/4mJmS+Y3PDOwYUr9WIvnzorlwPliZ4l0lqeK6IiFZZFmXFPd74XEkRane8?=
 =?us-ascii?Q?wwB5tPr8bd/CUd5AgK4Ns1S5sn1LqEGhNgiM7ZAgxSOv1pmHcYzyks2+EjqI?=
 =?us-ascii?Q?/irgT5czYkxCtxWEM1WbMHLWhOHA4fkqt2EcTgrNkafxK53zGYEyM3h7mdcU?=
 =?us-ascii?Q?uFUODW3ikGYZyQP0y2S1Ax17dN8fDcDM0fURf89jiUlUzj4nZg25XJX3+KTW?=
 =?us-ascii?Q?mGwGN5igzRhdncNxGxf2WjZWNHKLR6qtQ1RWTG7dBOWzzF2Vb+B6jSs7sxwT?=
 =?us-ascii?Q?Q0WpneUFU1onJoNvbt9D83ipQNnqtFQ1AgtalvyCzMBGEmIEZqRNgQ60C9vj?=
 =?us-ascii?Q?p+ezpSHD1HN382T4Fpoe5AD7Em5nZCIk/I8e0ePTWmy0zQizOa0NqE5p3C7b?=
 =?us-ascii?Q?aMvU0g5N4dULFGZDba/Az5SEFr3N4LetpzAVgiLBRofcZlHsLQOzEmx6rfmN?=
 =?us-ascii?Q?reXO2XVcY4ivu1hBhTKOA8sDSvIOmfMh+JrjJxCA0WtzCK7eVqU64n+J4IGg?=
 =?us-ascii?Q?+4OEwZyrjfXDXmQmM61rZsmkeRWmM1mHIiJbuWWtErAaXgBuVgxd6DAkW+xO?=
 =?us-ascii?Q?J3EUA1D5mnPqw+kptHTvwxI9xk6GHrR/wYvIru7TLUpJqM3VQDXG1sXPrwSE?=
 =?us-ascii?Q?OjMPPkrO3owbh4OMATUtOI/bKvODeC9m8vhC6EjYvjCeQEpHC3Kyp/0w5/Iv?=
 =?us-ascii?Q?kHlN1jTD6iXOXo5ZsN0gG0C3VbxZ76YVmZmxsykIVCfmtpTLD1KyTJ6pr/W8?=
 =?us-ascii?Q?axmkrw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a8bd74-878b-4f74-db11-08dbe01e2ac2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 05:47:17.5557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rulMWPYkQ1N/c91RVwfDo3PMZgjTM4JFNNyFmLJg/eNpvvJ99TTsNPw4uZKWlciaIrBTL005XKze+gHQe50W7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7816

To check how wrange32 logic interacts with current verifier codebase, it
is necessary to try integrating it as soon as possible in order to take
advantange of the selftests we have. One way for this to be done is by
adding a helper function that takes smin/smax/umin/umax from
bpf_reg_state and turn them into wrange32, then do calculation in
wrange32_{add,sub,mul} instead of scalar32_min_max_{add,sub,mul}, and
turn the resulting wrange32 back into smin/smax/umin/umax with another
helper function.

wrange32_to_min_max() is easy and readily available, however I'm still
working on wrange32_from_min_max(), which is trickier.

Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 include/linux/wrange.h |  6 ++++++
 kernel/bpf/wrange.c    | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/wrange.h b/include/linux/wrange.h
index 45d3db3f518b..cecdecefab53 100644
--- a/include/linux/wrange.h
+++ b/include/linux/wrange.h
@@ -11,6 +11,12 @@ struct wrange32 {
 	u32 end;
 };
 
+/* Create wrange32 from bpf_reg_state's s32_min/s32_max/u32_min/u32_max */
+struct wrange32 wrange32_from_min_max(s32 s32_min, s32 s32_max,
+		                      u32 u32_min, u32 u32_max);
+/* Turn wrange32 back into s32_min/s32_max/u32_min/u32_max */
+void wrange32_to_min_max(struct wrange32 w, s32 *s32_min, s32 *s32_max,
+			 u32 *u32_min, u32 *u32_max);
 struct wrange32 wrange32_add(struct wrange32 a, struct wrange32 b);
 struct wrange32 wrange32_sub(struct wrange32 a, struct wrange32 b);
 struct wrange32 wrange32_mul(struct wrange32 a, struct wrange32 b);
diff --git a/kernel/bpf/wrange.c b/kernel/bpf/wrange.c
index 4ca253e55743..c150efb42cd2 100644
--- a/kernel/bpf/wrange.c
+++ b/kernel/bpf/wrange.c
@@ -3,6 +3,22 @@
 
 #define WRANGE32(_s, _e) ((struct wrange32) {.start = _s, .end = _e})
 
+struct wrange32 wrange32_from_min_max(s32 s32_min, s32 s32_max,
+				      u32 u32_min, u32 u32_max)
+{
+	/* To be implemented */
+	return WRANGE32(U32_MIN, U32_MAX);
+}
+
+void wrange32_to_min_max(struct wrange32 w, s32 *s32_min, s32 *s32_max,
+			 u32 *u32_min, u32 *u32_max)
+{
+	*s32_min = wrange32_smin(w);
+	*s32_max = wrange32_smax(w);
+	*u32_min = wrange32_umin(w);
+	*u32_max = wrange32_umax(w);
+}
+
 struct wrange32 wrange32_add(struct wrange32 a, struct wrange32 b)
 {
 	u32 a_len = a.end - a.start;
-- 
2.42.0


