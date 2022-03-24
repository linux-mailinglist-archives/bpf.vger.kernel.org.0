Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3548B4E6077
	for <lists+bpf@lfdr.de>; Thu, 24 Mar 2022 09:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348980AbiCXIjN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Mar 2022 04:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344175AbiCXIjM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Mar 2022 04:39:12 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1B19BBA4
        for <bpf@vger.kernel.org>; Thu, 24 Mar 2022 01:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1648111058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=h5jl1HT5cp/7Y4J6W73FvwzeLgdh4Mse17jgpLIYUmw=;
        b=mqN12qikRL4Xe2nsd/NELRpxlBHi9t179sTuqcpnwTDLMrAWpPwEMpPMbm9ia49Z2v/Kar
        3i2d6pIk5kWNJnaeVvFFlGfqfNu4NkTU0NTGkRalv1xDmQu5WGNLaMNu0ZYgnRuq96OswL
        RNh4VdZbn5lV6mpAX/a056yQmOZ5oaA=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-14-MPujLmuGM_yA8O98LpbBSg-1; Thu, 24 Mar 2022 09:37:37 +0100
X-MC-Unique: MPujLmuGM_yA8O98LpbBSg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsWAyJQQPDFqkT303tApd1C4HpkRF4rU13z6MHRToU+f5Lf919dxfoA4aRBe0wjLxtKA4YYGW/4QRYaC8lBe/ZbeKke/I+UKBueIzjogBid2nS+D3dAlkFDLzBaIlZXk6l/pWdH/61RrsecfBSlTgXHtZj5//iPK1r8h2tBNIJmSbWw+HgITWZ13mwfWok2YlVj95uC3mrcMsxKtkFT1X88NM330OwBurt4p6ZTyAjB/th6yGPkuteg5n9vL6qNLN8aAGlLHnMK+n+1VeJ5JVHuwn2h7S6x1l/cQYDlL+LIjIJbCR+U5uChckVe12iIfcyOYiEQDh4x1pjxdrLPLCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REBPZIYTkPl80CFMoCs8tEglbGGP04PrpLEwcOQXb+E=;
 b=YEEQ4IKRHvFkUuJknpPiCp0koNjrrPphGys8aP+kZfKjWwTDY9myQ41e6kRSNfU2HL8acQah9RlWyZWXYlQALIlm/6NtJVZW3k/0CjmgvVmSb1qi03PpDu3H09jZWJI6NOvvzJz8jcuq/+dGKMr+NmuygmsOKGwJhHNE+/LgMxCZzLFoX/nQpALgUUsA4AbPTVRO6+A4S/INmmdeXk+dXQd7+eslQESR2TDW6yOyXv80ItyEToIP1TrbJrfscfwZrVC+54G3qGPzR6+Mw3plIVOBxWdJYqyrQYHpMxY8hBt/jsmIJFzkEz/LodgJ1O+xvK5LhbpFB712lOIbbtej2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4946.eurprd04.prod.outlook.com (2603:10a6:208:c0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 08:37:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 08:37:34 +0000
From:   Geliang Tang <geliang.tang@suse.com>
To:     mptcp@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
CC:     Geliang Tang <geliang.tang@suse.com>, bpf@vger.kernel.org
Subject: [PATCH bpf-next] bpf: Sync comments for bpf_get_stack
Date:   Thu, 24 Mar 2022 16:37:32 +0800
Message-ID: <ce54617746b7ed5e9ba3b844e55e74cb8a60e0b5.1648110794.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0008.apcprd04.prod.outlook.com
 (2603:1096:202:2::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67036944-c49e-4e05-8f89-08da0d718ae3
X-MS-TrafficTypeDiagnostic: AM0PR04MB4946:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB4946DB60F9D14899F7291108F8199@AM0PR04MB4946.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PxuyfrQPElaUAEnj5DNTIMEyiw9GSxO6GYGC6ftp2cx9s7W+fURZA4VwfPzz6yBXi7MkP6VPuTETiZ2j4pBX9HCGenK+cBQEhUMJcU13qKSPe1Je+1yTTVj+cQQ8UghmCsJCVHH3wCi3QBJpBN2772UNxweiXroPxGLq59shzSO4+L3V3GkuPgwmdiFmhp1OJl6nwzVJ+WlYXH1pyJgdAypRMEocZnEE76bdpuGIACbr8AaqxUy459c3xPsOo6FublgkcaFgSftObKdC+o0cjVz8/p/EVC4a9YAGQ9njw5l02S/B2nXRbWzRUXIT2LTOjDTJx7dVjmciT4T0eOwLDrEeFqBhkjqw5CBxZKc/HUjf3rL7PEBccUqBJh75t+Kp2Q8hpOUls6hoKokEPPRPZ8oOHKLerRXcahcnI8g6Nfc68z2s3fE/5NnzlTSIi8ex5HsUPGup0KR56qRYFS4+QATmqZRC7pCiZgQPejED6JjKs0CuO4rAHmGkM+mskb0popD+WVAdC+XNAdHkYnFdZS02uzPWIjK27v4t4frqSj+FN/zwePauuerpmDe6SSvwrATaXPn0NbR6sZjdIf6TghfWzjcKShQ5vPrLqwB3PJKImA+bEi8IUOuLAYu69Nk+qXcnQmXNHA0LLd2ufeHZuWeB+/g7uh0bMv9fsiRTtiN6p3EHAlnig1QPSCSqQkbEkVU5yZ/MLtTFdOO+KY+hwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6486002)(86362001)(2906002)(110136005)(8936002)(5660300002)(2616005)(186003)(6506007)(26005)(316002)(508600001)(8676002)(36756003)(4326008)(66946007)(66476007)(66556008)(6512007)(83380400001)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wKAdI2iuAENo//se+IuASkufuBEXByxa8yOEXJowzeiCBL354QtP+EneQeT3?=
 =?us-ascii?Q?x3D+IFD2+cvsTVo4sSiG+uqqUyKIWfzwDQgSiBthx4IxELoMfMSYLarFk74B?=
 =?us-ascii?Q?3+yN3SmvwmlLu8y6Onylq0e44cQ/9JChKaVifkpCvKNYyvvbeQbxUD1dgZZ/?=
 =?us-ascii?Q?oHJiPm6klag0LyAI7OsopPAYAHhPWg33mgsgny27oeo/usYZC2ToRoVMicJx?=
 =?us-ascii?Q?lvzu/nN/N5l2k4U9uCQDCPeLTDqdP5EtCvwhW786RnFs4cnUIvXFLI5/STGo?=
 =?us-ascii?Q?G2KiGRrd4OXiORmYTXFofHjZxH+6+zWgOJE2oplq1DwVM50nNLY5TOZ/siX2?=
 =?us-ascii?Q?BI11f/VfmPdghblln5K9WgFIOVa+Qz6Nowovv7d9/3ym3qYHsjhWyjlLhrj+?=
 =?us-ascii?Q?/RxkYNQlkmhk3HjISIZYEMR1t8Cv96UlCrw/dYdz9SqZ6JzZuzHPUCulf70A?=
 =?us-ascii?Q?6I7LPJjzPA9xN5PawTgEF9RMImIRI3VOyF0k+dQDxlbsQCNghr88qgsrlunO?=
 =?us-ascii?Q?MptkORPRviZhZg0ptZ7Enp9IhGEykHvFOTefBv9r6h8K5rfZ5rF4z/GFi/P7?=
 =?us-ascii?Q?bFIK1r+XL/1RN2+lEtR7Ne8CaG487n5CWrCkQDH1J1lLWJZc46mt4aOUXY7b?=
 =?us-ascii?Q?0JLRPQJflAN07F/OX/q2HmdnOv/rT3MjIw8a4qklx4FQueCwUEuNYq6+7JqY?=
 =?us-ascii?Q?jDS6y0Sj/zaHCDv74TpbYKjPZT1H5UECcz9+EGDzT2ee0yyTVfeOTuHrZgkW?=
 =?us-ascii?Q?586URjhtPXBPlAVgOPTRmJpy8w3QGkpvBid55bMdvhGXLzGNjOipqCbz8bZ2?=
 =?us-ascii?Q?LDu94TtQ9qMGmXrbZGo/ccIcQ2ZJjsay0gXjNsjOQdFKFA2TlwqIkfvpo1vn?=
 =?us-ascii?Q?RZP1Znxc5Tlaa3YozVJY7gh1sUTrGBeiF13Kl1ZPDRsV0ZeIsiIljqt69OAq?=
 =?us-ascii?Q?3HbSutQlaimUY7ulXbk+jODhosKEmcGyYm8mULRaoQ22IGUaohW2bXO7t51h?=
 =?us-ascii?Q?0HwfeQxcEFbPseINB7aReYNQUb3TERcvVKPIAd+lbqHXIX9vHiYOw38iTNsW?=
 =?us-ascii?Q?SYfZnO88TvyuBgaDQpJ6VRh3+qJoZHmqfyb7v5cLFbfbtMt3SfbggDcCUUiL?=
 =?us-ascii?Q?EyLByuIEYHh09OO89O6ObtvHPvFgsV7xeR5j2eHh+L87fBRCuaKSyGFV1k4X?=
 =?us-ascii?Q?cDL4x8eFyuJoO3DUj9WyK1DwN3ICAoiPhb0+uc8P2sacIAKUYM4zrhKP+RX4?=
 =?us-ascii?Q?zqmCVR8OMQYSLptnI44DIiRqiMEEdrbahviKJmM6bnizuwDFx2vmb/Cozpi8?=
 =?us-ascii?Q?Ck0C1358zqUci3Xd2KWiHyv4w85oqxVmeGh2Vntta+DhEPl5DwMsG0/8Vddf?=
 =?us-ascii?Q?V3WoHivU0r0L4rpWjB27d43jc3+dS/jnZONpk62vS4Lf9/zpZwEkYnQI1R8s?=
 =?us-ascii?Q?vlE4GNBWtKUOjcV0djNONzuWAWioCtJ0XkOqg4qD285pygeN77V6Bw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67036944-c49e-4e05-8f89-08da0d718ae3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 08:37:34.5387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgaitFdPIMBFq3N7KTVPoq5zwFZ2Xb9EgTd2k8VeekjOUJXq1n+em0XMSjZUyryHOFHV6kK7F2YcZfaBJGdP7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4946
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit ee2a098851bf missed updating the comments for helper bpf_get_stack
in tools/include/uapi/linux/bpf.h. Sync it.

Fixes: ee2a098851bf ("bpf: Adjust BPF stack helper functions to accommodate=
 skip > 0")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/include/uapi/linux/bpf.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.=
h
index 9284dc1a1bba..9ef1f3e1c22f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3009,8 +3009,8 @@ union bpf_attr {
  *
  * 			# sysctl kernel.perf_event_max_stack=3D<new value>
  * 	Return
- * 		A non-negative value equal to or less than *size* on success,
- * 		or a negative error in case of failure.
+ * 		The non-negative copied *buf* length equal to or less than
+ * 		*size* on success, or a negative error in case of failure.
  *
  * long bpf_skb_load_bytes_relative(const void *skb, u32 offset, void *to,=
 u32 len, u32 start_header)
  * 	Description
@@ -4316,8 +4316,8 @@ union bpf_attr {
  *
  *			# sysctl kernel.perf_event_max_stack=3D<new value>
  *	Return
- *		A non-negative value equal to or less than *size* on success,
- *		or a negative error in case of failure.
+ * 		The non-negative copied *buf* length equal to or less than
+ * 		*size* on success, or a negative error in case of failure.
  *
  * long bpf_load_hdr_opt(struct bpf_sock_ops *skops, void *searchby_res, u=
32 len, u64 flags)
  *	Description
--=20
2.34.1

