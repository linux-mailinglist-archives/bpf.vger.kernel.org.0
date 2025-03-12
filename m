Return-Path: <bpf+bounces-53895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 937E2A5E08A
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 16:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86CC3AF6CB
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 15:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B468C253F31;
	Wed, 12 Mar 2025 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WdntoeN6"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012053.outbound.protection.outlook.com [52.101.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CA115539A;
	Wed, 12 Mar 2025 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793802; cv=fail; b=anP3rzHOzzsDzHmTpf65zkcSz+9LrinlOgRdYOT1RCtJdtPVdSAi4eHkUhSi95Ya6cegmfIYDC191UBGFU+CAv8e/MwY73TXYV9cfYn3EMoF5yAxlrKfiUVjcDDxi8fzDuYFmto0BfXSbEnuLiIXPf65fr1PlVoMe2mgaCN8dB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793802; c=relaxed/simple;
	bh=dR6bqjLHgc+gDYd+b6TLzQRwVG9PrbeLON5cssifSwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m5SfDASWovGC/EvP3Dp8yY15ZfH0C4mgYTBqPQCIUpv7Lrpn1JT/Idcb/WR8r8t6YIr5TYEc3kHIaQh5CbLC9w/tTjRlz1/wIQREBUvjJ5PBTfr0c95FJaJMOjYasIAAeqZGePH5i04RE5L7raBhB/3Lji4IAorW/D++kRgE4NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WdntoeN6; arc=fail smtp.client-ip=52.101.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkI3hIXJ3WiBNlwMMR+17bpiU3tFCugYLFNDzSTndpebEe20+6gUlmQ+urxuIyigHaMUCvowoYUDGUVrEgXR3thlV8cx0/+hEwNtVO75e6IvezfTF3H650li/N7c0xiyFDK9cNs+u7JmTu+FqPN3bqJUex8PNbodV68MQsF4l9t59hCIqMVun4r7UQWLgBixE2GILReNuEI0f0fJH7G+fKGKeNjFYYQahPF+dqJWne/8t0J6WsIrdRUOTUO0QJSxXKNklkCXfHlO0b/vH/98fqQhl5PdYWRBKSpxT/78OvUCrqge6KD01YirsdoxP5pjgmNrIGtZcqxqeiq5EI4/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMteELg+dXMMFeDqf50n4c7xlclrqT9cgjT4atq3+Xo=;
 b=jZZkP3UQ4lw5mglq1mGiY//vSjfLQ3gy3EPUnK0qwKcrlp2xxlELysksbzwOJw33TNkxwkQnZr9wqChekhV/Vvl7urDmcUsiKI7OrBdtr/VfnI6MZGpLMF00IxNQO7BzMWJksJsGMmuffz05NUENojB+AZ9Jj9t+xMOtAhXvZtWyup9MXKwmrU9HKolyFe38mBxkUBMiRFPQ0dLjRMMNf0lrZpLwKm7nroOM03ywaV1UDUX86VY6OE2w4FDlHsm168KLyKn201bK+xCWM7g0J7mDcKePRQ6ioByfTk5Y1H08tRm7Pyl80nI7jpV2On2JOS5MA9yPft/Gk+JU99RiIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMteELg+dXMMFeDqf50n4c7xlclrqT9cgjT4atq3+Xo=;
 b=WdntoeN6t8aOpURcWF+SjpYWIOINYfdz7I9cXTxrhcOYtgeHwWNJrur3SeA+YYFvtqvZpWCWci0HNq8l4Y4Xls8QsaV428lqzLKNKTlPCWB2Y9tovMTPsl7HXv627l2vpsXim40ytDQaDHkz079ZiYJQ4mcpyUMQ8hJ8goJmk64rnN98d50AOZTA57nd3/OE9WnRfUrMLH2tSQUTUb/nsXud1QzkhqvOXt+PxIfmvyDVqNgJesrM/eXPohv20e9WeEnu3b/ROXUMRMm8UcultszI/zivwtv+ia2uPb2cisN3TGiwT8bngLsGnpjOaLTTf1tMFAMUnFl2U3HNM45dPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM7PR04MB6902.eurprd04.prod.outlook.com (2603:10a6:20b:107::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 15:36:36 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 15:36:36 +0000
Date: Wed, 12 Mar 2025 17:36:32 +0200
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
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next v9 02/14] net: ethtool: mm: extract stmmac
 verification logic into common library
Message-ID: <20250312153632.evkqnjcsuspvzp5g@skbuf>
References: <20250309104648.3895551-1-faizal.abdul.rahim@linux.intel.com>
 <20250309104648.3895551-3-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309104648.3895551-3-faizal.abdul.rahim@linux.intel.com>
X-ClientProxiedBy: VI1P195CA0055.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::44) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM7PR04MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8cfcdf-3071-4e5a-6763-08dd617bacd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lO/C3wXLlBX790ghRcvSUwc0QFb60phCtW1Wzd23I/31+v6Ev0NZeuxWyPwC?=
 =?us-ascii?Q?EtcWeSeVZX+/X7sjtL8LnqomCP/8cZJDTtDY1MYEJV/KabqWKXxRZ9nZzJJ+?=
 =?us-ascii?Q?5SAYDw146JGE2W1qCyh48P1+39T3fI5j6Jmp9BxoY/Rm8SQS8IsrXTLNLdPZ?=
 =?us-ascii?Q?jkux7L1V6ItXOSwlotJrQ+Zfnylj4px041PHpPyzcwv4hIFxzTkHsYFyChLA?=
 =?us-ascii?Q?glUa7g3vAIWhzv7eAH51SP8Z6P2xfPB3X0xES+sWdLQenpOBc5iCNtYg15Co?=
 =?us-ascii?Q?C47156mZeGdbeZlbQ4HvTlZWeujM3oqyKyfsNyVeFKCfqVAHz+C6x4+/l9IH?=
 =?us-ascii?Q?4CETctf+fw8gyZNkuHDH2gN7nu5hWEva39Y4CpFdMCM378Vo0sC8g+a85P2e?=
 =?us-ascii?Q?6rsgcz61i/6P0jfK1plg1e8BLlY1altkHeHMw65IzxlTCrHi0APOMMZgtmDc?=
 =?us-ascii?Q?FjpSpTv9FkPsSbIq/44a1gIqG7aRCtGOmdGlWimDAqkxTxPaFBxHvQgfx/NU?=
 =?us-ascii?Q?9zJKPxNHGbmyDS2FmGF5ClE7YCyp5quMWEZBUgUg8jA+3izJhoqYu3r3fXoS?=
 =?us-ascii?Q?FbjEv2eim+g4qio4dsKC7Og/UUBCwW4XAGRHqCxYuDgDe65AlMb/sRubIp2y?=
 =?us-ascii?Q?LtIrfCYIivb9UygtrwXeJbNHjZXLm0FPgvJPPxXQzJm9NADf50B41W545oVO?=
 =?us-ascii?Q?v3hZo2RtpO/LIcqa2rd9x5gUTuKK5fOGxadNCTJKZlM3GZfKUrAhxBodi3Qw?=
 =?us-ascii?Q?nqwD8uqkW6Y36/1vKZGQP/ZrY92aJqqLp89K0QN8HsUXlUOk7a8usfcc0zkY?=
 =?us-ascii?Q?iZJKSaA2Vg7TqgGhNARmosfFrXNeobvQMGtvl6cgSagN0dOFjYeT3aXudW4Q?=
 =?us-ascii?Q?bRg1Zjmy4f3KIfZ7c5kGPfOiQI+pPKd52exis8YlHskvd4l632gKmsSnBO5i?=
 =?us-ascii?Q?qghZRFmv3kd++/UieNqIrfJXAh+FPKrTmleLvqMbq421RYVAHUww1AO03YCQ?=
 =?us-ascii?Q?Lcj8tZmLvKNjtN/j1HZV4hENv08VtyjiZGw249pkJ4l+hkFltfAZsRRTuqmw?=
 =?us-ascii?Q?kv7A+akM+M7khY9Sk18UUaB3COYHAI0uCnnwkfVrCg9P0vXGjohRkBK+R1gD?=
 =?us-ascii?Q?InG4P8Knr1yxfAAZ9nh4fV6VOtFstUuK0cEy6kjSNXXKbr38++Yjq++a4J7Z?=
 =?us-ascii?Q?lk1XC0rEKu53/oD7WK+bs2DB0U78JFvbARlyuqV4Wc5SAqWJ7MLGaThUzBal?=
 =?us-ascii?Q?o92GEkrkT7EiyT9OD3xEJxYwaUTRDODfoBKwVkWDazSa3/psdcXynsoTAC07?=
 =?us-ascii?Q?Ixjs8mgqFq3RkIL37NdV36tEr8nKflwNknIVj9ktr2qga0IyyXODP+lVsJdn?=
 =?us-ascii?Q?MZ2i7KJZM0xVxQt5pLaU2XtZ6CQs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZmqwO4BW8c9rkE3ubNkY15mfsJaOql0C9WQnp+jVY+O3Mse30J+2DlzLQUyg?=
 =?us-ascii?Q?sl7vAj8uK6qE0wuSXP06HN/sYI46qPSztT1TcdAzUoZk9Q/fA6BolZ0P5BCY?=
 =?us-ascii?Q?GnHWesQPTqcoiMYurPv9o+deoD+GsmepBQWeyz8PwMo0YnN0/DWcSxnoTU4b?=
 =?us-ascii?Q?O6TA60zh4R8KmJOqEID5Enb1JJJnx5dQpuN0P2lDg08mQMDzzbdVSM60paBl?=
 =?us-ascii?Q?z4zOxYrPrPkOOyDxXP7a0kJ6PwZUOOWT4AUlct67RwUqJ0iSEr53JNfiKBep?=
 =?us-ascii?Q?dn+Db7l5yx1VXPut0KdSaf644yV0TIAQZGOmmIR8BzdyuFpY6+UFyFk+Xg6h?=
 =?us-ascii?Q?+ufIwvdPyoSqRNomqRkLjhh9Ybyf+AwG/WhJKL/Cjrh82oovM54d+yLbexsV?=
 =?us-ascii?Q?UyGUjD1RQRmZeb/zoMHtBy75CSJiojjwjkM3VsAonDPoTl65tcBCRhuIjlND?=
 =?us-ascii?Q?BfgnzZswsVBFQP6A2f3R8uAvJ10eA3IhpXK7zyRKEnSgDVW1JVYtPc4uJpFH?=
 =?us-ascii?Q?Uv4QobxlwqGDSnDTca7ypu1kAdfvSc4uItXXON0LwKTC7a8B/WrxBFVXXBn1?=
 =?us-ascii?Q?4E3i3cMucVNMebtYVK24WF4oOWOtFLZrB5Ss25+/liumHFsbTuY/PYWUIOIi?=
 =?us-ascii?Q?Ye3sSacpa5/P1Gkf4WXXsZMA+IDRabvpjzfUaawQnIZYtlp4q750GnNWKliz?=
 =?us-ascii?Q?/jBoltMy6TKToYpRBU9K0rZBZGWPnEWIiGXO1x3WuNy9J+7eCvSYBNnGB2n+?=
 =?us-ascii?Q?XCUy2KDqmdQN7r75S6a/sRv3a6zNF9xI1zlpWw8MfWtRKRPCVvHzvbYE/zKP?=
 =?us-ascii?Q?wT/Pdwgubz8Z5ylAhukAGV9XFYm/fFOV0TIVWag12NZaB75bX5/En/qPZ+fR?=
 =?us-ascii?Q?0zy8ytHXI5n31H0WgLar4zE9s4SOqR/cY8vpjcd1FRW3d846/14SLzjkPntO?=
 =?us-ascii?Q?6XLjvV4BSEOCc9yqzNXaYsKyU42wNU4SUU9E5DKv1hJ25lOvyHVwcOAvdj2V?=
 =?us-ascii?Q?eciQyvcS4acaAHF0l8VaSaR08O8mA1CE9TJ8rA6SDR/xhcKsMfYH0Sgyq+0U?=
 =?us-ascii?Q?ZiRfKihyWjWUXOcQd5r1XqSW4ySqf9LKqkk5HgvdRbbSQ+M/W66X2uV2hCYQ?=
 =?us-ascii?Q?J7C6vxr//icaMvyiwsSQ3FCFeMablUeh9qTmh3ZH0iKcuZfOCAjiYzLrggoA?=
 =?us-ascii?Q?olbX/kNypz9lJ5NzYBxobxQ1i0KDpYKkX96Pct0xQIOwEscuUY6fTkTRyYN+?=
 =?us-ascii?Q?M5t8KLOC5QOkwdpx8T+fcy6xaMPzmQf6eQpikWXTOYm5cwRuLEXmfv941xJ3?=
 =?us-ascii?Q?fv8R3cYkz3kjroTxf34nWnc/T2ejxmz6VWnJCkcwgspZxIrQYfwmamwWALWN?=
 =?us-ascii?Q?kJW2q33ZoSLSknoBCuu6ZON8zlRIBrKqap4LTwUfJjLibXAGr+IIhUBGMLxi?=
 =?us-ascii?Q?K/Up5hNi1aztas5mAG4hop/DNLjfsrxqNgiNwfk/P1rB7Z9UT4IcqLdIPK3Q?=
 =?us-ascii?Q?iBZZWzpzRzosQBqsqJpJAN7V0oPKHJMbM3RURnmgJWY+RhGAfPhNBY1aT5rT?=
 =?us-ascii?Q?5vE4vkiQ4ddj+dvlk2vhrmCoe1xhb2jkEj3ZdIr3K/nnfStwW3tP+Kw8anHU?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8cfcdf-3071-4e5a-6763-08dd617bacd1
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 15:36:36.6107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9QYdy9vLXufkRKY8OP1fxg2HbH6eExphWgOuOTMsH2sONzR1ZhqeA5TVQF2DvGswCR3Xe0sCd2I2/a+KOqs9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6902

On Sun, Mar 09, 2025 at 06:46:36AM -0400, Faizal Rahim wrote:
> @@ -7850,7 +7850,7 @@ int stmmac_suspend(struct device *dev)
>  	rtnl_unlock();
>  
>  	if (stmmac_fpe_supported(priv))
> -		timer_shutdown_sync(&priv->fpe_cfg.verify_timer);
> +		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
>  
>  	priv->speed = SPEED_UNKNOWN;
>  	return 0;

FWIW, this trivially conflicts with net-next commit 64fdb808660d ("net:
stmmac: remove write-only priv->speed").

