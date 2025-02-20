Return-Path: <bpf+bounces-52073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1A5A3D8B5
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 12:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C618700078
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 11:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05EF1F3B92;
	Thu, 20 Feb 2025 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TNkPws/k"
X-Original-To: bpf@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013040.outbound.protection.outlook.com [40.107.159.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A921F12F6;
	Thu, 20 Feb 2025 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050938; cv=fail; b=HCMAQdpNqhKYe2m/4VzGmrcuKntekczMcD8siLGUZwxLUclVDY8FrrY2TJcV6BiU2scaEZaiQlNlfEA2waLTEzW+cZAvtlptZJGaS68yZMyO4VM9h9JHE2+I0VAtUz7/CTzUX+gCkgnKOR4PIH7W5fLq5p0vbtBRtpBz6kbJL3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050938; c=relaxed/simple;
	bh=O49CtQrCP1e8wJ/7oenB8MaGCWKzLUsz10CzidQKf2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PJXipDgy7UcVPasMBYHtPnmL2ULP0hiBmqK51bIUcKFPOlXvxHCOOsoOt/KNaUCIEY2sCDqrYRdTplpySqATcIgfuwQnyx63OgoWeER/5lmCr4/l7KhG5G3ECaiQn1csquzA4jUiD90E8+iXq/CsqOnhBA+JZ0beSdHAle2NYNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TNkPws/k; arc=fail smtp.client-ip=40.107.159.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KG0E7MXSTXcMpWaygS0RL1234fkrpwXf+NP1cnV5onV+7MX4ALHmziTjob4TKWG0tQ7Rnk4tdwBdAsAwWbz9hDtVu+H8mWLRpsNskIOffoGbDYslMZUzJLdw/yxZS6gZpE3gXHF89Bri0pRyQ15XfguI4OQUiPTTZ5T22MlwYO8rPVrqRf03Z2ijnPxFpxh3423CwbAqY21nya8gxMQX/FK9+seMvy6TSUSCSZh+NVPy77we95WQjwvOQFzj4VTqMzFFMzbCkyOnpLV/2wp9KwF9hENd8mgp0meEdSzUrKzKlcoaFcd+K2ubusYaEbY3IDG0m9Qtw/ukvvV8MD9nNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCl1V7FHlwI89Tz88V462vnUiFw8XziSIICPk+68cKE=;
 b=Du62QqX3uxE1hgW/9xn+TPao2woyZWw87BWhxQBuc5T69QEbj3WXNTgm6P16UuuVxATIuk4brbIr6sFaa6M77ToO9J6ch9k9AK1pxjlzCFVPpB0fsAWYzepUk3kM4BStj0hGqPodSiej851M3ycjs5KXJkhphEhJVemk9YWwIuZlh7pFpUpiYz3Z7OVfiTcw06onOADgduPV3eP6sb2Etw6lC49I9OBQVsVfdIMKHkpyAgAZ70x1FqZqSk5VKVWPUqvltW+eTiAivcqRzQpukmxkuUgexs1t869S2PGa3jY9KTQ7LzrNEaQ17zpqiRZiYz4qf7yzqPCutnU09sbSnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCl1V7FHlwI89Tz88V462vnUiFw8XziSIICPk+68cKE=;
 b=TNkPws/klFMhzz/AUQ7RUAHqNeQTxTK5BIlZJ9eYkHG8LsJE2Fl2slcLnBvKKpraOAOQgvPjhqQJLvC/vWRqQllkgKXWjI8GnOqPqYdckvTdi+0zzFmZTYlGZ+v+3IzqWqA1Pq4fqDHvax9Vhz3Kjs/gHJkOSVC39QEtXajMpAQEvaImni1QiFAFTtU9cqpMvzAuoWfsg8Wf3yJugzvZ5c82N/8UPnrB+tcYNRW2nc6Xw8wUztHwyYRr4V+Rip7gqaTMRJLVrvMu46+qiIqBzCzfqjpDs9H+VyffZRXkjk/+zo01/M5H0tLwX4mHQg9Gk9NBDHa3+KVVZJIYgxBz3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB11076.eurprd04.prod.outlook.com (2603:10a6:800:279::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 11:28:53 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 11:28:53 +0000
Date: Thu, 20 Feb 2025 13:28:48 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Serge Semin <fancer.lancer@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next v5 9/9] igc: Block setting preemptible traffic
 class in taprio
Message-ID: <20250220112848.wpoeqp5bplgkyg73@skbuf>
References: <20250220025349.3007793-1-faizal.abdul.rahim@linux.intel.com>
 <20250220025349.3007793-10-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220025349.3007793-10-faizal.abdul.rahim@linux.intel.com>
X-ClientProxiedBy: VI1PR07CA0298.eurprd07.prod.outlook.com
 (2603:10a6:800:130::26) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB11076:EE_
X-MS-Office365-Filtering-Correlation-Id: d504b53c-0ecb-4d74-76de-08dd51a1c117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T5VDvMJOBulePjHi8p0vuZYhgepB3M+YzLFbbdMpDkRNvblDyZFQN5f73omW?=
 =?us-ascii?Q?ULb73Ic7+yCBES/8j62gNVtLoNTTrN1Lf9SIgsSydS+gQuSWEv13kMlbIRLN?=
 =?us-ascii?Q?26MBRbmGCNHGjwksQTlzN1TWl7HRSgSe6DcEonRBCef8Fl8/MXVTgr8TelAs?=
 =?us-ascii?Q?KfvyNW4HXk44+BhQZ+Sywr9//hiBzUzwZw+JU2XVT4lLI1KBdPQm/c7mVmnE?=
 =?us-ascii?Q?w2HgEoz5AmAPoGSiqps1G4Mqtw+k10I2LCL9TSxtLD1GpjEwznX6LWBI6jm/?=
 =?us-ascii?Q?TYryoFEao1VZIGzm1xyGZVeU/sHj9ZRONEiZjqAxe6JBLtwW/L6LbhfJl+t2?=
 =?us-ascii?Q?7xycS0XUkArZVvI3Ww85XSETfEVnmlYX5hhMxITo40hwMPmdrtZcdEo4YYSS?=
 =?us-ascii?Q?suXjgOaZvcP+T3evvruFpk9LYSEt2oJ8ucSVUSOoJ0SOx9aprp1y2YXOZvx5?=
 =?us-ascii?Q?ubDKYiip9en+EmaScgGTFvG5H2eer39cwQX9a6+ZTvMLEryuGzlhQ6dEaI6r?=
 =?us-ascii?Q?v0cDkcM2z/YiDjG2VYuCdkC8ML9+O0JxJIrtWpPWlwtoHr54S5Lf2tCyw+Wg?=
 =?us-ascii?Q?00sFy+gcDUuo9Hd0WJl63NYlLHjFlZce9OtF3a67I7hUQXxySOZS3A7y7fhL?=
 =?us-ascii?Q?qi+Ufoo26YAY+HyXt5pKRV1ZBvDjuLDv7LSigjQuTZlhEY+i9P5yTkB5cacS?=
 =?us-ascii?Q?J6tSPIMO4jNfkqR6/R3dqytXvghfUSG8/zWRo8rQXNupoQBcojYwGdlKN68m?=
 =?us-ascii?Q?ZCldnAnYX4/DlgwlS/3kY0Qtg6w+Z4LdX/6DZrAmAevQ4D2T96Gtq2cfxK45?=
 =?us-ascii?Q?X0GnPp+DKhf60L6gmbSc1BEv6l4qCjlZhGqn2Q3IRDXkFLl734YzVKaQvzwt?=
 =?us-ascii?Q?oEs9HLjqma+jEhag9SO6Q8xgSCYq/Sb6ahhPzAfiWqrEgmj6clvoQ0tC4UU2?=
 =?us-ascii?Q?sXMVf91UgQmZy3IJAmEIAq1I4LtRP/cQ9+Q/T4r7IrbEyey173NsaSDhzkrv?=
 =?us-ascii?Q?tWD8y+ISXon7W2j3DZ9jS744UmEWSSFG6G4f+JgxksGUHSyL9P7jIupuWO4S?=
 =?us-ascii?Q?Suhzx2fyTQWEFdu9CwchoP7pG9ucsBrvTAC6mcJVZwjCw1N5n4Xza43whGNy?=
 =?us-ascii?Q?iQqqQFmnE0XcStlKVVJsDS1gSw1N2Hmseys0lTp/sgzVYwXpFgr6Sv+fsiVO?=
 =?us-ascii?Q?4gzLZYuknLja9A3Dl3KNJASIxX5VVZvPha7jnGnIY+oMqtKxzvjoLsqwEJmY?=
 =?us-ascii?Q?jolR1Edgzdjw0JudeSeH8YUQs7LUqDg1j7vaUdbYBEzFKUnj3Rrt2O5GmD2V?=
 =?us-ascii?Q?snB6NsKWkYBeqHqjbI7aydoU0i4DPaMiQcy6kAdPX9IAzPOV19OA7lbpIUPQ?=
 =?us-ascii?Q?w1EEPGKoKA7ATZ8UtyRBMTwfX7UE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8bx1aAyO5aBnzRUDnJnNvyjkhhSEnShnA5Qqw3+tphx8/4+jofN+styK6f0K?=
 =?us-ascii?Q?HJJX2uw+Pux56j+/ZRiHSDdlqJAaCx4bsSF9JgV+DQushRAd02+Gg+PsWkjv?=
 =?us-ascii?Q?j8tjaZ24oDfnKoqOXQxHKK1mNfcgpPQaidUvwb24BUN0XUONMuGShlKWWxMz?=
 =?us-ascii?Q?d9JC3NxcOajscVLU/lLhe3+QOYZVpkDaODRxEN/bKiFdgTj8qiYOja7yWyWK?=
 =?us-ascii?Q?cYC3F+qx/wUt6d9SWGe8CEU8K9w1clWoHVo57NykGRcyfbRnKHEavbDRXLQ+?=
 =?us-ascii?Q?S4sD9PDoUp74j62SEsIDGE7k6CJH/sCYAK0HwDdFM5mxGO0SpOZ8BRYwgJgJ?=
 =?us-ascii?Q?3U5n9mIdLrjy+GfKg5itTrthz3tyYdOLnMD4lnU2wR1ZuJ9LYp1BkwYrEJ+k?=
 =?us-ascii?Q?8VDuNDR14nbcWHz0QWwetz/d4SrTqXMlAZpaTcSh8+oWelY/ox4eDoO+jlR1?=
 =?us-ascii?Q?QiSeaj0Qg5AQbjq96WfjkrmGrplE9Kl+Sxs34fYVxKU2QOyXLxriPfvXSX0i?=
 =?us-ascii?Q?w99GVowYQMzo8a7DM+q8Iog1IiALfoReeERJwy/G+Z+Ki33zoVUuevSyPBgT?=
 =?us-ascii?Q?6qzqC4ZScrjSIaeFkKZUQcJQySZf7/CA8mAa0d515/Ae78I4Lc8TZsi80P5K?=
 =?us-ascii?Q?mi8b5huDrgq7gKoZKkmMwJk2ob/VuKVVpaf2R8RWTcbZHZN5hvnLFrXFqg7v?=
 =?us-ascii?Q?4GElynBt0iopo4HBh9axR16bY9kyd04AFkYr2ZSmScMtFUyztn9QNWYsI2Ol?=
 =?us-ascii?Q?aT+WM4fIzOKf/MQ8yHdRsgX776ELG0GRAnxyz0josF0vwvffTldiNOZyViVU?=
 =?us-ascii?Q?IJtSdPEJp1Y5VtrseXeqz84DLevH/wyjuwBge9fEgSqKkY21ZCE4uMPUOCyX?=
 =?us-ascii?Q?RZA+1awf1BwfbhKoQ7T3sqkStrAZTX8WbCW42918jjALsNyQRv+ctwQ0C930?=
 =?us-ascii?Q?HNuiQ2sHWVIyEtXgBSBEcIT2+Le/By4tm2RpSRKUhVR2IRMZDELRq20nQvho?=
 =?us-ascii?Q?X0W5YWRoUsUVtzXjk5/5i8Gc6qYuO321hAI/wnvKxKyhYblhd1ophjJtBwMj?=
 =?us-ascii?Q?0p2ryR9wdpyyGwyQjeRBBgqCuZI38/e5G/eIiXDcga0R8QBNblR7+ofOmJK8?=
 =?us-ascii?Q?VDjmyXWAxl+iZoc3In/xEmQOJpFMxiyKUVYQAvCc5lSmg5jVOqgwBRXcIsJJ?=
 =?us-ascii?Q?LmnImUIwzQXcOpmyVKaRRYcs5swLaM7h672n1RbeeMj+FTeRoSGExL36k11u?=
 =?us-ascii?Q?OP7PV6qqoaVM4ZuZkeltaSLZBz9mof11PVihr1ZqQYfP8RKe3ep5zG2lg+hv?=
 =?us-ascii?Q?Xidb4z87xPpdavHhG59VEXmLipWdFVTQxLM7EOtSLxUtHZeZopvMtEe9U2n/?=
 =?us-ascii?Q?nonJhAhwtPNfBVp+jVcGrJNHSJt6NB7rl+Vj86Af8ZVG9GDaNFddI5fdA3Lx?=
 =?us-ascii?Q?LH5ST2YPKYIEmo+d9w1X0ch7EwjOCmxhgHqbJ3pT8NFCHiWbpt8OanTyfqZP?=
 =?us-ascii?Q?1FIwmiOTtXcyFn9uhwR6/lfSOdO9qoWXHzmUakvKX7HO2/0t/c3ON5FrDRS4?=
 =?us-ascii?Q?MeTFOFbhJmwUE1rn67gsMiApIjyZpJiqgHd5tDmu2W57n0Wgip5zpNWqk2je?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d504b53c-0ecb-4d74-76de-08dd51a1c117
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 11:28:53.0547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pyzi/z8y/YJK4dhoRwhbliA484u75v5tgkPGy2v+JBtoiKQE2FPOvayYUo+QOmV34JYoZTmmJYIXu8J2CfuiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11076

On Wed, Feb 19, 2025 at 09:53:49PM -0500, Faizal Rahim wrote:
> Since preemptible tc implementation is not ready yet, block it from being
> set in taprio. The existing code already blocks it in mqprio.
> 
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 5a6648a12a53..e6a398dbf09b 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -6408,6 +6408,10 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
>  	if (!validate_schedule(adapter, qopt))
>  		return -EINVAL;
>  
> +	/* preemptible isn't supported yet */
> +	if (qopt->mqprio.preemptible_tcs)
> +		return -EOPNOTSUPP;
> +
>  	igc_ptp_read(adapter, &now);
>  
>  	if (igc_tsn_is_taprio_activated_by_user(adapter) &&
> -- 
> 2.34.1
>

This patch should be before the patch that makes ethtool_dev_mm_supported()
return true for igc, i.e. 7/9 "igc: Add support to get MAC Merge data via ethtool".
You don't want the kernel to be in a state at all where it accepts a
configuration it doesn't support, even if it's temporary and you're
fixing it up within the same patch set, because it may be visible during
e.g. a git bisect.

