Return-Path: <bpf+bounces-76358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC34CAF7C2
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 10:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A3DA307731A
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 09:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E4D2FB977;
	Tue,  9 Dec 2025 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BJtkLhlS"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010058.outbound.protection.outlook.com [52.101.69.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFE12F8BD0;
	Tue,  9 Dec 2025 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765273293; cv=fail; b=s++u3H1fPetEooxXv9jTj3D69LgImE+Sy1bERS5eLVEnLpyg6EL9HiJEz6kLvJBETR32SLFC1hWE2KnpJy+rZqS2sROyvJzVsl/CobmFKaYwEd/i1uHG6lrFRcHsQ39J4GDPdb/ZKXC68MblYs36SMB/qdo1z/032rFQoSn0LLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765273293; c=relaxed/simple;
	bh=FWoogTum9ccOHncMEGSxoIADlhslHnyBy2VlBXzxaOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tehx/zcIpj2QQ+yfrW8+S1pERQziLNENeIIcjuZ4eP4Ogq0uQYs2+AughuW2z9uG9F4qBrc/Da7Rib7j9w1x4fptT7Xqg1BV7UzaCeFU6cn/fwOG3aAZWv1eYfQN02ZU8NBsFyhBQgyT6TjJdftfCdw4BbXPH2Ni2IVJR75XebA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BJtkLhlS; arc=fail smtp.client-ip=52.101.69.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhENwOzMpnN99khckGdWhgAOyy50MieTXPXJ5Lffww8wKxOWFlq63LeyBCKqw9O6Dov6rh3pAH/eEkvGs0sfTgvnU13j4CONx9pIjRoyKP75Nl9MZYB8Ic+5OerF6liKSR/JXGWsOaEFguoAbU81Wyx2r4QP2LmqRP3/qUWZColJ+m52uv6QGibkVK2NJE/CvYBZ7B4ZcJeBNX8J3hP4TDFujdcffyo6q3mbyCzu5DURzyMAgTvFYCm0106bZGwhII9cFGTpkBKE76kc4vHPUqxL5jCVVIn4+Bi18N+YbvjhPA4ipGEpjANZulYS1K0XAmPBzhNRyrOioIG9Po3efg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOCawdY9GJ5Qbkctb+OWFOhzp+gKhYn/nOxOqlAZo4k=;
 b=w8KGVnwA2fMiiOnunEV8LiPpGA1/zUkDc0Im8v6LmNKmXUdoVMgbJ+GgVo7N5dnXkCPmiEJC2TFIl2RP1A4CyVOnCr4dcdcZqdft68zukL8xvS98dTg9Y7HpeIMuNDkJspRrkNi+8eEmg3zwJu1h9g8TW3AKwsr2HLL3/o6VqYD/5sfNy8qfi5U1l//99hdqhsqZkeTK3V3fMdDuwstwsdLaN+UdtSOO4jjKL1r1Mp7DF6YCoby6gZRzGmGfWAl3GDovczi3v3KyjOSkz7Arkve/QXNfFqv8INBM47rkXlMsHhBVBPItWPZWv1K7MCEq82jYN8z2BzolU69ZjMIAtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOCawdY9GJ5Qbkctb+OWFOhzp+gKhYn/nOxOqlAZo4k=;
 b=BJtkLhlSNDREGOF6q5uP/kXz8cvU2ISLdKKa6cIPlClE3rSEGKKzplZ5OR9WdaDM9wkSedViGY2kjDqSysoskMGL1EufZSNYz1tkPwtyH7MDe7ADDE+C0ZFMqDd7DUBklDkyqWq2S0vLzNyMax+yZVJLE8kHcbJMjeysTbu9u6hK5cwL1mVHI9mP70ORMN6gvQHQmypmzBxw4uN7pzY5K63ComWs36nVrbvfWGzSdlfABiGmq1IRLMSDqxRpRzhlNvv4OxxJ/7mjOaUhueROjbNrD9mQ/QS64IBeB4+kbqPtqNMVT6csncMmwv5iIMCyA0cfECfbWrLE/Hcd+Ac82A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by OSKPR04MB11391.eurprd04.prod.outlook.com (2603:10a6:e10:99::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 09:41:27 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 09:41:27 +0000
Date: Tue, 9 Dec 2025 11:41:19 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"hawk@kernel.org" <hawk@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH net] net: enetc: do not transmit redirected XDP frames
 when the link is down
Message-ID: <20251209094119.5rv4af4te6w237li@skbuf>
References: <20251205105307.2756994-1-wei.fang@nxp.com>
 <20251205105307.2756994-1-wei.fang@nxp.com>
 <20251209083531.2yk2lv2rahouytv2@skbuf>
 <PAXPR04MB85103577C97139DE324AAC3788A3A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85103577C97139DE324AAC3788A3A@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VIXP296CA0007.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::17) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|OSKPR04MB11391:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c3cda38-8be9-4b21-95c5-08de37071e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|19092799006|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?716H0bIM+yWb/61l4jyfjc+W4d/laiywUlQryog4dnN8Gu/2QIPCTXRcqIeF?=
 =?us-ascii?Q?9cnA9L3j5jGU8mfZBhInCqznnZ8+SsIM5vU6qMHZHuYNUScZs62HhdnhPbRb?=
 =?us-ascii?Q?ZLFtKe6FlvHNWsADFxYNkVnbt2MgAP8dslvQE/CViLCJPvIejY+m9h6j4/u7?=
 =?us-ascii?Q?hIc9tdFuRB7xr7z81fMCB+feR3ObVDP7JQ87jOBML3Zc5g8hf7TvfqWC1eR2?=
 =?us-ascii?Q?VWq+G06yu4J/ErxJuEAFYDTP6gLp/qptQDOLxFXkIHC+F0nYqPQnASyHMA3e?=
 =?us-ascii?Q?nh4uK4+Evlz6BVpJz2bYLBgW2MXIE09HJq6jKOrqGuJVIgcvLC52VbtiseEU?=
 =?us-ascii?Q?kvCPvUISZY6cfVZ45XOSwQ8v7uIp9rSe0uNjN+ljfGjMDsjth87z6vGKkH9o?=
 =?us-ascii?Q?SaFAjUuklIn2OPEc2NIPkM/54mt0V7ZuCxgKW+1Lg4kFcrNmni7bjUY7dq+0?=
 =?us-ascii?Q?787BvMvczcNOOpXWvL/3c7cF1M+p+YS0KcSEC25rBhiueqoJFFFMeTketlYb?=
 =?us-ascii?Q?pBPCz+AZ4t75IPJJ6TMwlmWomuyXJa/+ZRNAIUt7PPrDnR349Klp34QV9Ufk?=
 =?us-ascii?Q?HEcsldC9lqi5BlP+LmRUxodnp4qSc999Eroeh7QDKONVBK/tJJkz9MAD9KC7?=
 =?us-ascii?Q?M1m5RXD7VUMSfB0YJ+biOflOHkbqEGC3yHakHJkEsSDEc4o/d7iDxZ4gAo6Y?=
 =?us-ascii?Q?XDA9BOAka4FlV0TpuI0AMdHssoK7ifLYPoJahXZF7W/sSLDKVfKxi0tu2NMV?=
 =?us-ascii?Q?XSemxu/L9WRgOe8dlqWEUqxb9UKCRzLM/KbeYd2ognR0nj2bLt5KqFgO4zfb?=
 =?us-ascii?Q?Ms/xwSrlPCIcTAu34Ph9rZoH7tt4lmV+SvX8Oh9qybPRtPFnr4jOb6Md0XER?=
 =?us-ascii?Q?8y2e7c0OtNsltJGAVYKURBXwXhaINtc7p+VO+uZMhxLCo5CBB8zmRzHM9vMY?=
 =?us-ascii?Q?CykUwPkPN+19hoMyZ/C5nQ/ijYYiBAWnVkKwqz8iD1pyHGWoVS9DXLq477rY?=
 =?us-ascii?Q?OkTcjLwf3AnyxrQMkG4KvzwNejUoDhd6b5JcMS6WlD1703tNpwY2/Qm0qNut?=
 =?us-ascii?Q?oiq1nH7c+3JANvbL8MHVddwbh163kkzkxBvVOwdCK567/Tl6LTMPpoGrjMBf?=
 =?us-ascii?Q?CTUno1XF+BJVsYKLOcM3jds6LVrRRG53P8IeqAFEV861A097YkHO1jdBWYsN?=
 =?us-ascii?Q?o7l7Qs5tcxckA7GbEqiVYmxNkxVxCYZkTraFaWsQASS7VREbJeQ3GkjV3MkU?=
 =?us-ascii?Q?fAnSrjK4BInGnQOwijbek/Kmk6S2eyS/0cOOt4Iri3zyy7IohTwh+86eWPOF?=
 =?us-ascii?Q?pD3gJx+ilGUMZ/2gb0Z/p4kOhyQDlkifrwm5asDRX6MlTcRS3Cr+TDi7KKTx?=
 =?us-ascii?Q?1dJ3vRSLXCwdl31B+uFbFZTYjqSGslhUXdZ08VknXqha4zf26N1Evc/CM7jJ?=
 =?us-ascii?Q?0WbYu1AWZES4xe6pU3Wnpk1gXRJ6SF3g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n0hG8Q3SX2HDpcFpZ3Z3/VUPJ0UV/Frc3gTbo8QMxm1QvuuMej62Ny49JxZ8?=
 =?us-ascii?Q?tzWDSL4mYztaHHfFHW4XAXACRzmWSlPDxsb4rtREmx/s1Pr5585qLU6LRPEq?=
 =?us-ascii?Q?Phio2B26151aVsiyvkUeyg+UtBGLW6lJ02KRZbglV0+2a66PN/6MpJRSVqqv?=
 =?us-ascii?Q?USEZ8JE+4RSKwhu5EUXgb84CtmldRvIgzc9ng3bFJRt6wP/Hjv1ltXGC8ozK?=
 =?us-ascii?Q?MAvb7pgHHr4aEoB7zur2OoHbANYudUlOTWCxjiHGkSOXR/K3YRWn58tZ80vh?=
 =?us-ascii?Q?yjwav5avmVT/KQCHeSqaYrKFuMJHkwK08b1IsKAKyfBCopkeJS0+xYYQgY4C?=
 =?us-ascii?Q?cZHGoInyLXp4+NMD1S4dGobGyK+aRzRV4KSrl1wVHrd0BlWIxtfOUrr7ghk1?=
 =?us-ascii?Q?TRbK02Gnh0BNwTLDN/CIDpAMqao0tI82Ktp4smhnzs94ToPukTSWrKfW9AHV?=
 =?us-ascii?Q?xUWCcR7v52AKQZafuGvSBrM3oxZDT8+7w1n5e8Tf37G27zPVzNmochmWgDXt?=
 =?us-ascii?Q?TAuq60YmeQxyJEsUPfkFZZInpqLs49AjTiZ9tqUpDjzM39CIHLTFM0/2FLic?=
 =?us-ascii?Q?kf+VQCqcXR2q6Ev44B1dvOdJUFQ33M5N8BPZvi6TZpkgmKKUrdBnyqhLZwXm?=
 =?us-ascii?Q?ll+DaHw543VClWpEgk91swpIQ7W7kQs51lHzt80v7dYtNnmgUUJQNuxaS3sM?=
 =?us-ascii?Q?kSaXeEoeTP/gJCiBtbzhedR5nlpgbkKcBlT16xw/yILyxXvfZ4YOCX1/RBPj?=
 =?us-ascii?Q?ST9NcY3w1eERlo8VR/BF0UBtSVjKXUzFAdtAkgEuzplsUrW1gto2WyA2JcMa?=
 =?us-ascii?Q?0CC5SQQYWhVG9cZJF7nr1nVtjgeGN8bFFcyet0gBgdbUurVf9l8mh2Zn0uB8?=
 =?us-ascii?Q?KYIyxU5MHaJBTgSTS4ShIB5J/i6v5KL6nQTjmavdcRU1bVf100Lsvbn1XCqJ?=
 =?us-ascii?Q?M6tYfXHbsb6A2rRBUEIInSOP1qvOaFwnpKx9CNBjWplnuv7U2+RmuMjIBKmp?=
 =?us-ascii?Q?o/jhdQs56PEK0VGsk32beOFk09A2VNdNvzAgW9JdKASVcMjLJuj/sudQR1Tg?=
 =?us-ascii?Q?QsSV6VLVVt6sQ/pi0bMSHwlgSJlNd721LWSGphgQUTf/yoyMlYcyV9Kbr6EI?=
 =?us-ascii?Q?q7IhQL2UvwZNmJWJI8k3a/7Mwx21Q83hESwt9YLIamwgDJjmloMSYywy47J7?=
 =?us-ascii?Q?Iv1x1YauGd+/HKrb/VKtj8cfSH7/Qyqkms/M+bZzUuefDjW2yTdi0GogwtEI?=
 =?us-ascii?Q?fzu51KECiwSK7q5S5d0VsnPmFrU+idK5Lr+zZgj0BjtiRSmN7uMzu8nhXkil?=
 =?us-ascii?Q?LJya9LoiXxLQH00zRswA1195CLd1bnAtd/aZdEJFjftnMIEdvgC621uVkHVM?=
 =?us-ascii?Q?OX/yyYu3MH/uxILz0XlWHQoccgo/26J1WNDUT7kQeQGcCS+sRQhLIEJpd6eQ?=
 =?us-ascii?Q?G25SEEk07qg+xM8CoYTvyBblIrSnpBe/NssSGCmw79rU6+UL/8zoNLN6NG6j?=
 =?us-ascii?Q?m9YAttgiaVrYd489qScCKY9BOGoVlILR2EjkGkQnxLlCACQr2lVZ3PANW0k9?=
 =?us-ascii?Q?bj+JeTexCFA7JgH7Y/EwBM/Rkca0NDAAICgtCW9kz4d6jvidd0bAhyC8Dmxu?=
 =?us-ascii?Q?pE24fEgjihE9EMopdZWWyum1wWoNGzFGOpKq3dyTDqxwQb/uoVHVZISeSoB+?=
 =?us-ascii?Q?Hv829A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3cda38-8be9-4b21-95c5-08de37071e7b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 09:41:27.5384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLz2QQAMKXo0pritSjFtH0RSHAB+yLHTDdqi0t1aFqAuwVeAKzaEx/DZfTKvFZSMV6Iplg3Gq06ixyQS3apB4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11391

On Tue, Dec 09, 2025 at 11:08:08AM +0200, Wei Fang wrote:
> > On Fri, Dec 05, 2025 at 06:53:07PM +0800, Wei Fang wrote:
> > > In the current implementation, the enetc_xdp_xmit() always transmits
> > > redirected XDP frames even if the link is down, but the frames cannot
> > > be transmitted from TX BD rings when the link is down, so the frames
> > > are still kept in the TX BD rings. If the XDP program is uninstalled,
> > > users will see the following warning logs.
> > >
> > > fsl_enetc 0000:00:00.0 eno0: timeout for tx ring #6 clear
> > >
> > > More worse, the TX BD ring cannot work properly anymore, because the
> > > HW PIR and CIR are not the same after the re-initialization of the TX
> > > BD ring.
> > 
> > I understand and I don't disagree that the TX BD ring doesn't work
> > anymore if we disable it while it has pending frames (the TB0MR[EN]
> > documentation says that this is unsafe too), but:
> > - I don't understand why the hardware PIR and CIR are not the same after
> >   the TX ring reinitialization
> > - I don't understand how the effect and the claimed cause are connected
> > 
> > Could you please give more details what you mean here?
> 
> Currently, the hardware PIR and CIR are not initialized by the software
> when the TX BD is re-initialized. The driver just reads HW PIR and CIR and
> then initializes the SW PIR and CIR. See enetc_setup_txbdr():
> 
> /* clearing PI/CI registers for Tx not supported, adjust sw indexes */
> tx_ring->next_to_use = enetc_txbdr_rd(hw, idx, ENETC_TBPIR);
> tx_ring->next_to_clean = enetc_txbdr_rd(hw, idx, ENETC_TBCIR);
> 
> If there are unsent frames on the TX BD ring, the HW PIR and CIR are
> not equal when the TX BD ring is disabled. So if the TX BD ring is
> re-initialized at that time, the unsent frames will be freed and HW
> PIR and CIR are still not equal after the re-initialization. At this point, 
> the BDs between CIR and PIR are invalid, which will cause a hardware
> malfunction.

Ah, ok, I genuinely didn't understand what you meant by "they are not
the same after reinitialization". I thought you're saying that
enetc_reconfigure() runs, and the next_to_use and next_to_clean values
are not what they were before... which they are, according to the code
you pointed out. You meant "they are not the same" in the sense that
they are not equal to one another... I think this really isn't clear.

> 
> Another reason is that there is internal context in the ring prefetch
> logic that will retain the state from the first incarnation of the ring
> and continue prefetching from the stale location when we re-initialize
> the ring. The internal context is only reset by an FLR. That is to say,
> for LS1028A ENETC, software cannot set the HW CIR and PIR when
> initializing the TX BD ring.
> 
> The best solution is to either not initialize the TX BD ring or use FLR
> to initialize it when this situation (the TX BD ring still has unsent
> frames) occurs. Either approach involves complex modifications,
> especially the FLR method. I don't have enough time to fix this issue
> for the LS1028A. At least for now, this patch is what I can do, and it
> doesn't conflict with subsequent solutions.

I'm wondering if this situation can be completely avoided in the first place.
For i.MX9, I did see a "graceful stop" section in the NETC reference
manual, making use of POR[TXDIS]. Would this help? For LS1028A, I'm still
searching, but there's nothing conclusive... I'll experiment with putting
the MAC in loopback via COMMAND_CONFIG[XGLP] and then drop the received
frames somehow.

I think I agree we should try to avoid sending packets during link down
even if we later have to recover from those packets we couldn't avoid
sending. It is just to try and not make the problem worse, and to make
the recovery procedure deal with a bounded amount of packets rather than
a continuous flow.

Could you please resend with an improved commit message where you
integrate the clarifications made here?

