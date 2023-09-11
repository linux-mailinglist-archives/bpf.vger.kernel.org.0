Return-Path: <bpf+bounces-9647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA22679A993
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 17:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8019728114F
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 15:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB1E11710;
	Mon, 11 Sep 2023 15:24:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DAC1172F
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 15:24:28 +0000 (UTC)
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11013013.outbound.protection.outlook.com [52.101.54.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D5CDB;
	Mon, 11 Sep 2023 08:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PG2ClOyLslR0YB/x10KVS5yt+ATOhWLDRCBMagrIZQ5zdEnVfcOIVJvGghWwgX1NKtP/BaZR5IP+J0WP/1uTSXAmcrli0kwdlNlbPFxSmRsfVts5l0qJTSwQODB1K/YvANdzQGOYN94yv4bP62fvIibIeq8H/Cj1ABCbI33IJmFXF/Q5eyjhwktrr3zAgS6Gh/y/rhfijnhbIXgYdlx9xMvEqYV1o9T0rRrPUCPX6nwiVMjGLJ9EgxnWUxPMbpsli3uqsDv1WPiTa9mdU+jIb0+4KPgf69/Iw1GYVOPSPmxQXZTybEaxqjutICd74WU8RPtam90BRKD6Qg2io+K0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=508VqeKw0d3cXoSx6QdUk6l9KVeXr5M4PoUFURqX9Ew=;
 b=Fab2MBGyNscljjcrJ6/B+wj1PZAOIjUCWkuzcEsyCd8eyqocblxgplPSjb2aHhek1jL4WSJ2bhteQbCtWFa8vvzdZpf8NMpgZAg55SbcApDj9grtK73EfGSsQ7xrg4N7sQkblPSefT4PGvna2BJPo74x88GR3ziwvesA4gwdQJKBHZ+J/D7hRcwu1GfsDlOlQX5GdYMLk638XBmRMHl7JuG9MaE0pFwI5f0d3MMtS0V/ed+Z4k+CsbE7Y/EOJH7FB38r3xvFNpnc2GzLR6YBQ1By8q3xiOtuF6Mmc7rX7vGOTNwLUMsJi25P5DumJO1WvDeLGicham9aEJ962+OrOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=508VqeKw0d3cXoSx6QdUk6l9KVeXr5M4PoUFURqX9Ew=;
 b=ymvWfeaDCP6sxph1LC606TFbkQcKKQgAFtAGpp5VoOZMyz5cFtHuSbtBoqavVpvUPP8w63AxK6ndb1SOQJsjaWxH/4M80iNH9i5cu1kBvRagn9oTuVvrYFF/phP/nh9RdZnW+jom9A0hzQABZMmZBBmyD4UTHNfIjjtQori9xAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BYAPR05MB4982.namprd05.prod.outlook.com (2603:10b6:a03:a3::31)
 by IA1PR05MB9406.namprd05.prod.outlook.com (2603:10b6:208:41a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Mon, 11 Sep
 2023 15:24:23 +0000
Received: from BYAPR05MB4982.namprd05.prod.outlook.com
 ([fe80::c1f7:4ed:2680:f088]) by BYAPR05MB4982.namprd05.prod.outlook.com
 ([fe80::c1f7:4ed:2680:f088%4]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 15:24:23 +0000
From: Quan Tian <qtian@vmware.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	Quan Tian <qtian@vmware.com>
Subject: [PATCH bpf] docs/bpf: update out-of-date doc in BPF flow dissector
Date: Mon, 11 Sep 2023 15:23:53 +0000
Message-ID: <20230911152353.8280-1-qtian@vmware.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0076.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::17) To BYAPR05MB4982.namprd05.prod.outlook.com
 (2603:10b6:a03:a3::31)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR05MB4982:EE_|IA1PR05MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: 246c7c58-dc7e-4ce1-fd09-08dbb2db2d56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i3pixWk5FTwCTmttd79TULQqc9Fw5Y6tTY7t3UMdKAe9GWJOS8ZujTfQqGSySm3Z0WWxw7CigFdz5ErEJPSmDLznuIHerSiKnV1SoMKTQSTO+fVxkZWgZO2raqoWjes2GVoIKdTBL7Tbu52q6hnW7glgXEOFrjPDmwnE/GYX8UHafnpN6N2r647CFV5MsEQRumycAUZ8AXTlaEA2+0zBLHJ9bqP34mfXHXniJdl8eJMTUnMghMjxOFARBHyeQs2NMSKjGmfGBjXOR3qDZGCyWEKqQ/6EdhG7A9Ro/TcL431YhNqIIdbNvB+2z2ZOiGrXE5MBUcx6DayPxnxW4wqbNFa33Vfb+rnEi21xjjIHOjeNleKAUHiTvUS8F6zqJ8vGNWCX014hdJfGHFbz01e1Wa+aEHDn1C8JYt3ZXr6xKdAx7FICS/4QfD247Avz1GGsNh4IZ3w9tR2DYwXzpwmdkuo9DnhbQHCces4CZKhXX8u42pQ5W7Kycf2yRU7Kzokc7YyRPPiDip1sRbtNa27iKGlKxJh8xfUtP5RSa0H1bY0BokJF5eLiav2lC73Gqwkott5B6B4xcYPPxr6n/Xa6wCTl5ZffOqQ3yx5MR+PINXm5yR+g6cv//Tf0y42tbzDyBdColIWAMreSzNw3YzyB+4emH9mKHR3XLr8PnV17tng=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4982.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199024)(186009)(1800799009)(8936002)(4326008)(66946007)(478600001)(66476007)(66556008)(83380400001)(7416002)(5660300002)(41300700001)(2906002)(6916009)(6666004)(8676002)(316002)(86362001)(6486002)(6506007)(52116002)(6512007)(2616005)(36756003)(38100700002)(1076003)(107886003)(26005)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u98vrr5DMtyy+lmGmvw7kU0HWhuxcAjSX0rgBtdSVe/bno0GESqtooOKc7fm?=
 =?us-ascii?Q?hkx55ffr6XJcQX6gOQTrhcdzs3WQp8BtIQxgYY75UZ5HR3leoL6WaSWAHAGM?=
 =?us-ascii?Q?Rsguh3DNJmHH1dt7+Il5K3NFYvC7kFr6lA4Oa02n7oITNnRa2m1yWT7fkOj1?=
 =?us-ascii?Q?DlP+/pHfj3IWpLnaNAh5DwJkVq9/1m12E9dAvcDIITNKFZQqXuFtKcZSMrwZ?=
 =?us-ascii?Q?2EVbUDuy5qlnJAXw4sLRBv/85TnR7ZBECevQYBlnQG8hIJwVZX1jYRXvoAwp?=
 =?us-ascii?Q?LE13fz/SpRz+4slPDhJlo3oMXbFg1vtm4Qi/I7GeE4e3WclXun5YPk3UpgIf?=
 =?us-ascii?Q?raM3U7Tit6EcG0j05JUAjS+AFJpSa8y9MhbFdE+eYMlICXTIrnrcRnJ7rHnm?=
 =?us-ascii?Q?mmU72l43OzMv905wp3/678i1cY83RTCNn0t4yvg4vFv6huHiMhj9dZAQUGbR?=
 =?us-ascii?Q?FnJdi3YtBRUEHaFsvdOWEZjSBSE9Va+NIbYnLF/mylXIEDlRi1uT86AhCcqx?=
 =?us-ascii?Q?z0WaHZODiYeXyMJO5EeuItYOjk+qrO7NZTv1YCkLhwkUK78JxyNzV13id5CU?=
 =?us-ascii?Q?Dc2s9TDfTVQk3ZKwL8yDkqZk1mWrDB/xIq4bpkToa523TWbISd8TL3A5lt5B?=
 =?us-ascii?Q?tT+V2WegvqAcldUrsFtBAzbtqS8ps/Fg8p+fgaR7nRfbT9f6ju96XPJ6mfEn?=
 =?us-ascii?Q?5bVKbpnY8Wn5mRiCWacjbDvxJRtzKmPQXoA8hhakw1NomWtn51x8iZx6ZQLl?=
 =?us-ascii?Q?SOi21OZ9i7B2YdMFkZWf9hRkNn5chi0QbsyJVNjvTnLujKmIioBqDenIpva6?=
 =?us-ascii?Q?n5G4xl1RMxcWHZ030SAFMivEqVgGayXMBRNOKqHjSHbdwdVpTXqTWagp+aG2?=
 =?us-ascii?Q?W/Vr3Kwwrfw+JBmUvz0ip04jFgrv1h3ZbZX7RCWYEaGfFGzZVEcf7QlM+ORi?=
 =?us-ascii?Q?kMS8Gl4Bx9gzzA/CI0NmTKdQcFQlY2WtotIT6Hmo7VdBscxR8yYsodO7CknT?=
 =?us-ascii?Q?DrY9T0PtyZ1SGueuNdRPSkZnEPUSnozo+5NQucDirj8kijdbVTEAubZXaEgD?=
 =?us-ascii?Q?Hwv3Za+6X+1SbxyvM5748vdSJ5v0CMEHXwCGVhc+TmuKmJnAAuc9S0vh+NdA?=
 =?us-ascii?Q?WDjsSyV/Ll4sOZuVnTlPHgzWJdbw7iWVTS6V/eDYIp/noF6OTWlvdqRQhjV0?=
 =?us-ascii?Q?CQB0saRaZ25lZBoj340bPWRnI1yZR4bQ6SPJOrj7eBa7v2mbJZWOX5764rhv?=
 =?us-ascii?Q?4KOyHXDXKBYiqrQswmrs5K43hpqcev08Dux+Y5oNbu37rmrwadfaVN1IFVxr?=
 =?us-ascii?Q?ckp/yxG5A5ycHA3nmHiiUIr4s8/KzOLjGGhmD4PR3jlhddmAneOvHZ9VZfTD?=
 =?us-ascii?Q?0bGFPxMFdaW1lgViq99HHtcU4Z1P1bPoaOARXk1ZMw88RP0MuPyGS+Kl2KiH?=
 =?us-ascii?Q?CG/zSioRC5EmeSb1MiOquHIqFr0m/GK9IqNl7otiC3KG1+xIsX1Isj2P0y1E?=
 =?us-ascii?Q?LHX52nSN29NjmrHO3Tq9Vid0d5y0GBMq5bcLPtebAD1o6D4/+pzWIB5OAuka?=
 =?us-ascii?Q?xH67G6/faVUS+MyrbfMzxvWSWoLeN6MG/ceolpPB?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 246c7c58-dc7e-4ce1-fd09-08dbb2db2d56
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4982.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 15:24:23.2903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v27Hnxc5ow571XHwKiQmkvOtRLl0XyeW0Q0bXmjr9IsVCngMUlnwTEE8zd7e/mWuZRASQI1jzqhBi4rVFYs4hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR05MB9406
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit a5e2151ff9d5 ("net/ipv6: SKB symmetric hash should incorporate
transport ports") removed the use of FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL
in __skb_get_hash_symmetric(), making the doc out-of-date.

Signed-off-by: Quan Tian <qtian@vmware.com>
---
 Documentation/bpf/prog_flow_dissector.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/bpf/prog_flow_dissector.rst b/Documentation/bpf/prog_flow_dissector.rst
index 4d86780ab0f1..f24270b8b034 100644
--- a/Documentation/bpf/prog_flow_dissector.rst
+++ b/Documentation/bpf/prog_flow_dissector.rst
@@ -113,7 +113,7 @@ Flags
   used by ``eth_get_headlen`` to estimate length of all headers for GRO.
 * ``BPF_FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL`` - tells BPF flow dissector to
   stop parsing as soon as it reaches IPv6 flow label; used by
-  ``___skb_get_hash`` and ``__skb_get_hash_symmetric`` to get flow hash.
+  ``___skb_get_hash`` to get flow hash.
 * ``BPF_FLOW_DISSECTOR_F_STOP_AT_ENCAP`` - tells BPF flow dissector to stop
   parsing as soon as it reaches encapsulated headers; used by routing
   infrastructure.
-- 
2.42.0


