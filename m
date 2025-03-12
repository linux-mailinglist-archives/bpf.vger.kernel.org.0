Return-Path: <bpf+bounces-53899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FC6A5E0FB
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 16:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 474BB7A8B2A
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 15:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945B02566C5;
	Wed, 12 Mar 2025 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hfi6DUt3"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A38324E4B1;
	Wed, 12 Mar 2025 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794569; cv=fail; b=ex5JxFNl2y3lif07OIF3v2lJK20IQPFNCZV0wORutS07o31PJ3W9owObkzn+tU0XdbnH9DRSk00A7QYBgzupj+RMk2QqrUZuw8BnI6pqJIshLZDfRaqxEYFU/kRblvom50kqO6FhLoRt7F66DLCkgCz5imR1YDQLzS+dP7zK2G4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794569; c=relaxed/simple;
	bh=HZg324MoK1XnHqwVrEOrDi67xHqHouxcaImDInXJTCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s7XsVLlomVNnOhc0t4KQ1l668Ag7Kd0t+WgMSDZPOO42lIdV+5/ZvDETGKn9qIWjWUS0+n8y26p9VfFyYFrA59uy/VLUJDyacJ1GC7GYkoDXU6T74dLKQFWxWct4x1/kg3GypLf1RoJlaTN234Q8lOb5qsI06d0WgRBjqKhOyNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hfi6DUt3; arc=fail smtp.client-ip=40.107.21.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adJMYPjziwXcxeAmW4LOl/mGoTkneB/J6heacrq0LI5GH8bysGIDpRnCVCjC5RiIxRcRNP9L1BrguLLtl5bDohgleQF8QNWtEWc3Aoa3bqenqhHJKUUOs2dQl/e/l00fvxq2CtZAUG6RVGf4IffUh0hGVWHRWoJb8yfb/bf0BYtpduSZYnabLEXEO+6c5Lv2NRTu+Pf7Ar2rVe7o/E1Fc9s9ZgeOfX8fNV2yVQ8/ncv/bt03833NUL0UPd5cinGgResNa3kW+I/gUfusQcmDuOuUf0/+hMvL5E4lh8hwyrVR4SV9nuqWKvExpdO9yKMaoJA7UZGQni3OLGUYC5A5lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kx7TPLik98ewYghTKWN4yU+mVuzxhKa6E+soaF25yKo=;
 b=y2CiMfGs7jazoRNwOfYayX+d4XmdwI8BTy5wcPMwxEKdIOyg1i/wUjyJycKyCRRzYGnjytverSta6QRkskIZzXV1lSYqkJjxnrc3ID3rFknEq2Ym2pbrA1WXatOJaTMzsywNV5hzfx94Blm0Ft5J0zDf4lQzos/9VSmxSQKZsIqC8Y6FhU27vLun/q+4VYCIMkNNFxNEePsGAnbNQkJ8xLgEzZR0ShgD8ffyq83RP+DyFjAnzuPE6YBN8qoW04dmy3JuHrqA5H3irQBgkNdAYLFqfHRfounnBg751/uwFvhbCLwJ/DL4HemJxCkRju+WlSYdE8CI5qhnqjgZUkD4Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx7TPLik98ewYghTKWN4yU+mVuzxhKa6E+soaF25yKo=;
 b=Hfi6DUt3/bDv4Wof46d60l8aFXeOglouX3kuzlLpubEyK4K2Iw9iaQWw1jK8Go3aJj17B8FkZKz9Et6vlgTDqh8OQ8e6aeSQvebwJ5k3OIuo8ZG5GuZUxUFeMrOUzXLPUPsY3ue4c2KymLxJlPmZwvYcyL+afBAM3J56DX/gJwy3YK2CHzdEeP6pu5OQILqJQcveglk+y9PcaNUmRc3zOjMozG/wAGFvMCsfCEe+CJDLVnFbbhb4nHhHuXvZc59ffz5VB+cN48DD04JQ+5h0kdJjo7xtS7b+YX6WyrhKyK9bh8Qia6sDI+nBQHUhziYV3hujzTdcM59eaWQDdUN3Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM7PR04MB7142.eurprd04.prod.outlook.com (2603:10a6:20b:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 15:49:24 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 15:49:24 +0000
Date: Wed, 12 Mar 2025 17:49:20 +0200
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
Subject: Re: [PATCH iwl-next v9 08/14] igc: use FIELD_PREP and GENMASK for
 existing RX packet buffer size
Message-ID: <20250312154920.3tv45m5cv6jqplqp@skbuf>
References: <20250309104648.3895551-1-faizal.abdul.rahim@linux.intel.com>
 <20250309104648.3895551-1-faizal.abdul.rahim@linux.intel.com>
 <20250309104648.3895551-9-faizal.abdul.rahim@linux.intel.com>
 <20250309104648.3895551-9-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309104648.3895551-9-faizal.abdul.rahim@linux.intel.com>
 <20250309104648.3895551-9-faizal.abdul.rahim@linux.intel.com>
X-ClientProxiedBy: VI1PR07CA0283.eurprd07.prod.outlook.com
 (2603:10a6:800:130::11) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM7PR04MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c2fc356-2072-49a0-4e1a-08dd617d767a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nmQruh0OCbC86RqvO4vIHdPQ6AY290dszgVwcU6yh5wn25PUQ8SAMyqMFNBg?=
 =?us-ascii?Q?qk5PQxp0wCwELIL3iS/HTbUEja4+AGBSQemGB1jQLBloAbHSWxDGSDx/e+vD?=
 =?us-ascii?Q?3Rhgdevd7dhXLo3K+2lI6yHKQ1L9uiPNuEP92zCVMve07Pd+rganxrNVREYb?=
 =?us-ascii?Q?gQnpQxGnBut8WYLkhMyM7J7FkjZFen7TXFtpWRXBLjCtz6qJyPfhqaj2Jw81?=
 =?us-ascii?Q?Z4iJ9ePUjgDhsNzulKOLtj0vNYQAZLrycXf3nvwanK0+v2YneuyzznwmtGk7?=
 =?us-ascii?Q?7RtiB9DFx3jyR27B5LAOxOq+KWcekOCwcVyao4BRjSeTVFcCypeK1qalqq9Q?=
 =?us-ascii?Q?Xhw/0x0XXPPTETLU/oklnR8+fbrB0zg6RjAZhUfNPgqfK3HHVyBdlvf5kfBN?=
 =?us-ascii?Q?IKQraGXFV5uCJSjxqp+fui5tISzeDl9Kz7y+bFEU/o4GPV0On4h8tZ7u0tay?=
 =?us-ascii?Q?3AIFmeQFE4cw8MT1uNk65/knxEI3M2JRZkEDknBr+1GfCRomZtDgJnzMJKfr?=
 =?us-ascii?Q?sqLcK3Ehms7mdjBpV0afjIwNUbMitpiqQqPIjb5EFof+y6O3cBXVj5M/bZtO?=
 =?us-ascii?Q?3EU+l/9s21tnI6OQm9qKwb3IF4LID6U7w3dXIuFDKk0jz0gWCRXODKUwrEeF?=
 =?us-ascii?Q?woXf5pUhoTrgJjoBpgi1oLw/7G4bHAHxnxJ2+LGw5SlcPcu2bbOeTxM6hCMT?=
 =?us-ascii?Q?cS2DzrYdzCPH2CXFm4TNsrOvVx6QR7LNwJQhVHV0aZiAxABUoEXxcRHaHjQ1?=
 =?us-ascii?Q?KjwV3TcFy0GQomgGnvzRLRs1+UN4V3HXzceMfVLbahsO6IgcRC0ou/NQfRgT?=
 =?us-ascii?Q?MVui8quDT7+3noF+mQshRMhGumbFYU85MuVs9yIj0GB1cIUodxxzSlcEBcvJ?=
 =?us-ascii?Q?9Jcw4VihwhlX7qoawOX25PbO1bYsV4PUad4SuNPN+W1mXEObbyiLDuaViqK8?=
 =?us-ascii?Q?UA9l1BY88146MZ+xTLg2n4E+lwYP+lB5liIUrtcmsFU6sG8zU/p5CWep6MHV?=
 =?us-ascii?Q?wPnBl1bLHas/28+KavopSAGLkd9STvS46/qZeY5nD7lXNxnCocKND2AnBz4G?=
 =?us-ascii?Q?EL9JHMrjfZGXFkcjmRKrMVTcGud4pN6YFef4JvIt6IAGviYwvDdxKQwyUIS+?=
 =?us-ascii?Q?W8b3v08vLksdmLJnJj3Vmj26Q02DJkG30oj0iSStynV7RMmOB7Yt3FnQkzNV?=
 =?us-ascii?Q?T3UlHjsfqbUC+7wYljYKzIFJ8UU4oBxHtN7cHCyv9Np8o/MIxGRRNbeuFkWB?=
 =?us-ascii?Q?wqRlOVfCdGHR5EBtZN0WE+g4BuS5M/IH3ynYzkvK9x4Ep7RccGvaXLWUHMdD?=
 =?us-ascii?Q?kFWY7xjVszEYKRHFJXBkEtN2pVahc4914dJuVlIPzRBFTUbEi26NDJKygkVt?=
 =?us-ascii?Q?lK1LvHChGxYpq2/eFMpUj4i6/iMA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YwnUJ709T+B8Cm7OCH1vx94NWs704FjaR3+XIsI12Ah2tJ/stzbUl5eK0rUD?=
 =?us-ascii?Q?dzsCfpXYVYMCgmAsrPH+LjdV/S+NNpYSMZtyUtNw1AXqTxoCXpDNO3g00VpQ?=
 =?us-ascii?Q?sgg19JqxHGSBk9NGL0IyNRy5Gj4/3RM1lN6SBrSX6R7GPDSl611Rk/1eXZBk?=
 =?us-ascii?Q?q/byLJyKNB6/10M5Mr9MQcnKERaL2u3zIP0x1rUctrlefS6reTfP6mWOCql4?=
 =?us-ascii?Q?lIq8LJdNYmq/UqxUdqDOl5zAHH9jcqkwGJohDXlxc36InIyaD25RwlrShon4?=
 =?us-ascii?Q?XA7DXx+g/akNQr1QVnJq/HVNbkbDQocKJswG9DbKFZReK5FVzBZdkadrBMBF?=
 =?us-ascii?Q?/vfcXj9831jn+0TYXgoyzIetNKuZOpq9Btoyq+7WMkWwqcex5Kyi+cOxKlV1?=
 =?us-ascii?Q?1pYTx5Z4e3TorJqAtHABcQTG6k9k1QH7v3LFz+G7wuDdyci38YNjAAGm7rZF?=
 =?us-ascii?Q?Grg6QKlvU5aUgnFC/SO/tIFE8cLluDexxqG5e4wkzStO7jxXt4GGfpS9ffbD?=
 =?us-ascii?Q?VP4PfELwLZQFC9crhUMIwDDMPOZ0zvPIZePd10S2dsipVbVeCrORcp73bUoz?=
 =?us-ascii?Q?cWWRrP1yc7T09eo5IRE/dEc0y0FuqMOqXsgjoMpte2G0dKU7GnwVupdTYA4x?=
 =?us-ascii?Q?rFTwtxRIB3hT/ltyp5wFA5w14cwpS13Q290mTfxKsyNT8cHc2Wg2FUxo7/9G?=
 =?us-ascii?Q?BYXa7XLGTZ9knmXYC8+xgq+epsSC+oqy/+lZ3NuJrOtFBVcXxQyy06rTAS8K?=
 =?us-ascii?Q?RA/hW7pRLh14IAvXTgvmd3nRkzw9q4XxBuS8I2IbFPW4pwHkvm2ypqo0Mxuw?=
 =?us-ascii?Q?PrTqANiYLUTPgXU0Pk9TRYeSekNwg1y0wZUhItzYKLjSjMsLsjDsrlIcdfUY?=
 =?us-ascii?Q?s//mJdK/yiBzLwkr3Ddjaw4cOgj9vzrQqEpyaiwVkTV6b06UXiBbQItykGgW?=
 =?us-ascii?Q?UMWCRWI7GXOhaP6/72rWtNG/V4l8RA2bJvAjS9s917TCLX/5LAd3hUwJDsc+?=
 =?us-ascii?Q?6PbP8v9Z8xboGRvzb5K9102xfaInjBwhIzrDRdC4o1Rx1JFtmXSbybBXcgyE?=
 =?us-ascii?Q?YczE32msDaPcdCrTcDEt0Mn29r0UJPqwIY8ZLvBHryxzVdDiW6dREFo/ZrPw?=
 =?us-ascii?Q?XAvY9Qg8araUBefuFlaVXXT/40PSUeRIlAmgqmPEECZK6JbuOAtV7uK97hdS?=
 =?us-ascii?Q?/kwaMMlLc0njaBA51yIG/yskWPIc0CJOAT1KYgouZCEYnvL7wFl0lrXZNWBH?=
 =?us-ascii?Q?fYTZztuLxP8OpAZ48qmCS2ud5iqaZEINurfXEB9sbCYds/1mJAvjyFrlacS9?=
 =?us-ascii?Q?5apiazKD8DiGvGEwdMpb+vQ8UnU5TKdiS8tMyPd455Z56Tnc6BM2850FqPtg?=
 =?us-ascii?Q?pRUhdjGaCZ9RsoDMjr3xn78J9OHwpvWkQB7/+Pa7I6LM7CBwfSKbOD7cK8Sp?=
 =?us-ascii?Q?AJBZ7oMaujRIxiL9V0UsPQaFR7EMI4nlXSCYVKtdHasmqmrRx+Jol3fl/fun?=
 =?us-ascii?Q?jDPv9M2sSgwiH5DSIg4mHJChyJOGIfbDP3bbPQ2xVUQOeBXjFvo36isP+EEW?=
 =?us-ascii?Q?brisMyfkvn+iFY7wfSHFIrN6r4j2lmadq1RI2C7+q3bQFbI8RiwE9N03/ToY?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2fc356-2072-49a0-4e1a-08dd617d767a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 15:49:24.4405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5qdkU0xJtBJy8wXaULWkOInsdp7qZ8/v6gfLDI4vzCxazRUHGE3rotuosX50JfCMT+g7f/NE1Y9IxI2OCg7SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7142

On Sun, Mar 09, 2025 at 06:46:42AM -0400, Faizal Rahim wrote:
> Prepare for an upcoming patch that modifies the RX buffer size in TSN mode.
> Refactor IGC_RXPBSIZE_EXP_BMC_DEFAULT and IGC_RXPBS_CFG_TS_EN using
> FIELD_PREP and GENMASK to improve clarity and maintainability. Refactor
> both macros for consistency, even though the upcoming patch only use
> IGC_RXPBSIZE_EXP_BMC_DEFAULT.
> 
> The newly introduced macros follow the naming from the i226 SW User Manual
> for easy reference.
> 
> I've tested IGC_RXPBSIZE_EXP_BMC_DEFAULT and IGC_RXPBS_CFG_TS_EN before
> and after the refactoring, and their values remain unchanged.
> 
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

