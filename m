Return-Path: <bpf+bounces-5081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E35755E89
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 10:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB291C20B11
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 08:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E458BFC;
	Mon, 17 Jul 2023 08:33:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FC44414;
	Mon, 17 Jul 2023 08:33:14 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2043.outbound.protection.outlook.com [40.107.6.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7E8134;
	Mon, 17 Jul 2023 01:33:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKIeY2KChVdV8H3bcgijn0TSNz4z/izsE/FchKarIiOAx2kgN3V3ty7jrwRN9sQ2KisWC6OmuHiiVI6W96vbI0mlamJI8JFYuOoPUFCzI5DXIUZVV4Tt+5ALOUkQDL4xJZjJEEBxEHj8MB9mTvmFaU43Gwl5tUhriZrQnBqxifQHzjhQBECyNX9XAh7PYUsM4ZAd+TZttTdJ0gLc5D3Cx1PhhVihg3e2CgfRQYzCZd4QNE9iK1DN2qCXKBD997SSC4Pj6PBwqz1KdeXhCBl9dXtiIIDEmbblVmzid3odsqWG6XthWJ8hUp2m2K1F/7QgJnyglXvwqFIlmmdU+DUkXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpxT/8pSPp9xM4knPvThMeK/sUoT3W0Tz/Tx91BJbvg=;
 b=RxYZ6Pcx8Ug/fmHxzkBbFineZKmo55CQ8a0muHNl6FbHyHZESnVYkpZZMFdd15MgI9ip6lOytZXGQKQg2SUdy0/rJfLdX64makJ+XN5JCcBdUTJYedD1YPx1YX0WBOQ73bNmhDObTGZouTGjXy40BWl+UHRN14/5SyTVYiQzu6gbGhINzffpw2i5jQzXu/3Blz15pkgtRNOscX10y+F+CSqv6HWr4iGlW9GKikIVdM86MbQ9MuokIU/Vc/22i9NjqMdqWRpnbLQuNIXLjLh8EnpgNGiNxxwsQ91YPgDMLxuL/2uLolpNI6o0KIdyIKEm/VC2XilmOAD2REhUd5rvlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpxT/8pSPp9xM4knPvThMeK/sUoT3W0Tz/Tx91BJbvg=;
 b=AR4K9E0tnxIhvrqzg3drDeQuZFS5HZTq7SS3ZDmUSMO6+XR7259vSEuCYQHtjouH2wvTMSJY3Md+m2737XxwPCULrCFyXRMUdhVbhp9zk0nANKClQ26ApgX40UisojC3j0cVNTw0R9TFEi686bVpDTpp8prDdaN67v/Ue0vXG6Jvi++iTK8JGYrYz8TG2ThV6kJIcmwO0mXKz3zu4lAYcWsH9CW7+qzIfXa8Z/UBRwzHAb0ThXumjKTt82j43gdTpvZJAfDJStY0gYDzZcdvnufUgBfs3Nw8dgcdZ5WTBRNAW2gRsghQw3uFJTvR0yw2mMICokojFiVDr0SIjX3LRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB9945.eurprd04.prod.outlook.com (2603:10a6:10:4d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 08:33:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266%4]) with mapi id 15.20.6588.028; Mon, 17 Jul 2023
 08:33:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang.tang@suse.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next] bpf: Drop useless btf_vmlinux in bpf_tcp_ca
Date: Mon, 17 Jul 2023 16:32:52 +0800
Message-Id: <4d38da4eadaba476bd92ffcd7a5a03a5e28745c0.1689582557.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0294.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB9945:EE_
X-MS-Office365-Filtering-Correlation-Id: 54991530-de7e-43db-a7b1-08db86a073a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9MGrwSESNHuNR5HevtZWKM8o5mXAiFqGS8uRxdNhYD7oHbLSTV0eyNZsU+MqIC+uNX54GvQyRZm/Bes6eZ72rz0mlt+tqxdcHJrONClo37LL9uTaPNoduBSKJNH+XRQd0hah6lKEsLDcJHN6Qy5NW3KY3CUNbqVD25KymyTavnIbVSZ/HGlA8TeOk9C47XwXTYTV/bZSLWLFb+Vvm4125Ns6b6keXSK6mR1uX5MGrL/Ojudo4x+YRGeJMDMGa5wFjRWVAK8OpRegCY6rmuvtjcnpWG9DhMMUtENg6TY5xxvvgRFaBaB+6Wg6F9uGhmOqPiy3sihE1v7mCPSumMQBBL/ADNBWdOsYwtYJkxAmnQ1qcC/ZmNLIUqkQ51EtrCsbGgOx/C3xJ8uuRl4LWLZE4ukfA9PV1i8Zla/rCbZ+216PjOJtf9TRmrS8znr9RpMp6N/dUfkIvsyA88dCZjfo+KgGwoY1kbCNQqks7v0vbYIM9HGs0xx8tHIA+r1n+Fva2z2ahxzCuBdV+9OeBPjSYtW9BtK3AkcwBV2aeBP2TUwcxGU314pKRm1sr6vxdfsK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199021)(6486002)(6666004)(110136005)(478600001)(83380400001)(86362001)(2616005)(2906002)(4744005)(36756003)(186003)(6506007)(26005)(6512007)(316002)(38100700002)(44832011)(66556008)(4326008)(66476007)(66946007)(41300700001)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sYwQTnHjM5gThPNKFflyk5DQRjrMjuMgVl/Aus8GfmewmEZ/O+NDChvUpRB3?=
 =?us-ascii?Q?LV0crdTkkD8YlSh7CxVzR3Noo+3heLVHBlFwGO86kX/7P/rV4NsF0VBWnlJY?=
 =?us-ascii?Q?sUPC91ifU+TmgPB126U0MKVKpd07ZzmlgwHIQjIxk0BWU7a6OCf9Mjh1DhOp?=
 =?us-ascii?Q?VkUYB4J2X1WYBq5udfySL2Z0jXtbD5QDm/h1g6u7CjGTchgA7xlurOggWnEs?=
 =?us-ascii?Q?nUHPPBcd0+OrlL5woslPTOEzg5MmM0q3HWGFdvfD0pBzob0SXK9yQzZ57fm3?=
 =?us-ascii?Q?+Cul/dzYbJ3K6OcZDKJ5ZVJ99yBDd4kaZ2lBX3wrmMAHUhOhXALNLM/2RGt+?=
 =?us-ascii?Q?vF3Gvvtl8hxfVf9kHXj14bk4cxoLtmi6PS1vpckD5DisoKrgI6BLBEEBcsTj?=
 =?us-ascii?Q?gTd2PB2zobU1jsjQkYryDyGTIUOkVMzJS4rtB+XZKiTBj42cMaAVUkZinq0r?=
 =?us-ascii?Q?3yDiqf7k4lkgJSZTXulX6LoMx4zKbAef1B5W27QYRWvj4idOzA3L+/qf0/jQ?=
 =?us-ascii?Q?AiArXfx2d0JmMvKASqYLBgdPcQhoDKfP4LUZZgC0RjO9YbhWA2wMTzj5NFPW?=
 =?us-ascii?Q?hlCDKDszda9QWuKz2SkL3C2dEoMfesS95Zkqg8MzzLRuI0Dh7G+rllvN6L+1?=
 =?us-ascii?Q?v07FVl5sXL/evQ5YSOmsbR41zI5sM3wX45ixBnHv1gaJTvd0nT7dNT+IIsMG?=
 =?us-ascii?Q?j6uR6slkSnV/vDV+ZTzwEUCSSCzLz9HpJpmXdEylVrvKHWbes/Lc4zLm9Qin?=
 =?us-ascii?Q?Vxo2WHpbAVEKeOPX1t1qwxkpB+hxo7v0t7/T7XBeI1tSg69v3947alYjaLoA?=
 =?us-ascii?Q?zG49+6W9wTKY/EU8v37nrc/eMlJESJ7lWNUUdFJud6fvvuIwXTpdKLcxBWFR?=
 =?us-ascii?Q?jsgOaH6lGePzCo/TBuHEupYrzSjQuACMURVwA931ivbWlZDSCFuQe187xhw/?=
 =?us-ascii?Q?3NIhCw5JAKBHfhcECq/QbqO+Ijk4nZTKadu229zK5wTpx5NnH/347eOCdcwF?=
 =?us-ascii?Q?7H47nu018H+buNh1qToOyq1IcH4S9NriVKVjotjZN5W9DWbN4FQk3eVgNnCH?=
 =?us-ascii?Q?p+SKG07VuZI9JCK6eMghAYypmdtzftBP1kBx8+VzjtKFYvLvfm1+kXGZuHpO?=
 =?us-ascii?Q?klXAIdmg3O+7r9qJelDRxou4CxF37vGUDR6N/EWNzJ0i49nY7hzYN10YihSu?=
 =?us-ascii?Q?R46lsdnWQWRVHl7cVteYEdxTQnpCNmbeHjf3n4Z7O/xdTqb4vlajh6D+4th2?=
 =?us-ascii?Q?2TJKi1qyKjzUUnt1JV5HXpeSIT2XzTAxm5f+xhQdme0BJoiX7O7NpMTmlbyA?=
 =?us-ascii?Q?gB4pF9BkGPwqt3tLXiWMNxjmIeyvohJ4Ji/GDxjtFvg86XJsQKfVtJeKi6S2?=
 =?us-ascii?Q?lPvlIFr2j8klMXFypD9WuyFrnZM7Dy0NCRxy/kj+V6rDhM9CBDgUzaPNdkyP?=
 =?us-ascii?Q?Vpj+olbCFsZHwtEs6iOOVx75ZorMFlRLVz7DPa5V/C0/yklw+eaKROeVUlGV?=
 =?us-ascii?Q?0YduJ3rAM0keVIR1a+BGbLdGWzi5ipT1ELPy7I/ACkfilx1I7+gD8dRoN41b?=
 =?us-ascii?Q?ZXrgH/D4vjklK+MzjpI4ttLfouWrsQToXq5TuAgR?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54991530-de7e-43db-a7b1-08db86a073a8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 08:33:09.7942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hG7e6g9uupCjWRdhZQ9aMZYLfuMkzzJIiMFvnH4eacuI8KnCf9Ws7Z7Iroz8y76lAw08lMQ8ugJmbhNSivXRnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9945
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The code using btf_vmlinux in bpf_tcp_ca is removed by the commit
'9f0265e921de ("bpf: Require only one of cong_avoid() and cong_control()
from a TCP CC")', so drop this useless btf_vmlinux declaration.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/ipv4/bpf_tcp_ca.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 4406d796cc2f..39dcccf0f174 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -51,8 +51,6 @@ static bool is_unsupported(u32 member_offset)
 	return false;
 }
 
-extern struct btf *btf_vmlinux;
-
 static bool bpf_tcp_ca_is_valid_access(int off, int size,
 				       enum bpf_access_type type,
 				       const struct bpf_prog *prog,
-- 
2.35.3


