Return-Path: <bpf+bounces-52169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68B5A3F25E
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 11:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBBD3BF3B6
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 10:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3120C20767D;
	Fri, 21 Feb 2025 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UYd/P8+k"
X-Original-To: bpf@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013038.outbound.protection.outlook.com [40.107.162.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857202066F4;
	Fri, 21 Feb 2025 10:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740134625; cv=fail; b=e0Jgw9Y/d17V/Q5nR4OOmB+uVQcwn55m3y3rQrD2zPLh2B0Tq3FddBSV26U3a4OrIyn8uHhvHJjBh9blMbAlexH/k03sOKs2kmJNJb2BR/5qFTncOPD2VrHr00MvnW5huHJ+qqjNEBrwk2MZ4qsK9ui1Jh8IiGZ0NHWLhFMHaCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740134625; c=relaxed/simple;
	bh=gKjNfKS0KhgVXyfQrMEGUF23hCvQeyYamqV097dmqnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t8YkLXY8+8jGMrWPmUA1Suaw/s37B8+GwpDwz9H5GrHv5S0ii5bYkdg96GbNWx4yjD9N5U0DGSPcqjB9Vzbe6YWXpVMbzKjJBpJNNI3sa72gq6HNXsU8abJ8T/plWZzt+NZllyFVE5EfBkcTAckFAoci5/HU8wY5dzFiAB7zwEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UYd/P8+k; arc=fail smtp.client-ip=40.107.162.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbFzuF0KvZVsDyrvSduMqoLwuLWWwXVRMQi3+btQhqI7dcU6oBm/rcx5kt0WwL7woDygOkNtrss7xHsGkfenqX/OUKyXl2tRaJ5Pg1aFFuVzcbTgQGOZvX3bncsy1HveQZFieQu/yDnOc8dLt/NbfKl7C6ADeic+SG/cnp6+oAEkRUy+4+KADwoykeaH2+WqoTSJY6MVBkFeMqQngU2Xln0RbYp5YmJvrycJwQBLRa1OMkVm5feY2mK8GwO6CeBTU1AoJwTicRcRiY71+J+ZIhtmN6KVzmYn7ytoBfafuvLewlPRRSeCnHiyAvau8ZMDLi+4P/+mwxB6ZnzP2bNgTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CFWJf09zmzYGYfYYeZY10EiUYQURk8uX2RNg888TK0=;
 b=dV4mDYHeVkfM8Dcc9t8SV812oBtSWACqTSjGFXPOOy7hO2XBPI+aWbIl/ruR9Lad/2wX2TLz0dXdXQ+gEuo/iRucOOtNpBqfTrW/GCg+g+YY5oaI77cztU7WBX2Ugam3NjCt12VeWP2+OMT9vzkaiYBetDE3rJvb2f1DRBTiwSEbkQk0lHS9BvzHp35sSrGge0Bo3aaFc6xbg2us3mH9c8S0zGAhkldSpIv7Jf824Ld02FXnT0x0CsKemtDhMy43fm3E0RvTKHNPd+vQqzveyQov5mR/PjryL3xxne6ffnqXAo/TA9LDScF3vuxpPygEF+Tyi52fMPXu2AxJZan5wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CFWJf09zmzYGYfYYeZY10EiUYQURk8uX2RNg888TK0=;
 b=UYd/P8+kFBSyXz8XniBCPLNEo0PskZE44xfeJlbZuTmcuP46TYBVwGgfdWgkV+eNo8hvjOloeqRIJyXB13eIecWNdnQksC/XjEBO8DQHKhZrtUPm5vpPSJH6Eq5wdvwauDlT91dXbwQmJ3iqTrXFF6ynj2VKIpe08zH14A/yxH/fYZgNnTtmamHOw4+UBXfK//OleTeziRXOIjLtlIyJcOpZAJZJ0wcxssVvgr0sLkSRIWh2rWfEAwNJ94iNC3XJKfAZjF/IFaR5I4/fmOtNeMD2IaZAnoljTUoho2jTI0uSpSd0d3ndk6lqtc+oqbjrY+f57EH+xjBEcGEncNmEdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GVXPR04MB10971.eurprd04.prod.outlook.com (2603:10a6:150:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 10:43:38 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 10:43:38 +0000
Date: Fri, 21 Feb 2025 12:43:33 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Furong Xu <0x1207@gmail.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
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
Subject: Re: [PATCH iwl-next v5 1/9] net: ethtool: mm: extract stmmac
 verification logic into common library
Message-ID: <20250221104333.6s7nvn2wwco3axr3@skbuf>
References: <20250220025349.3007793-1-faizal.abdul.rahim@linux.intel.com>
 <20250220025349.3007793-2-faizal.abdul.rahim@linux.intel.com>
 <20250221174249.000000cc@gmail.com>
 <20250221095651.npjpkoy2y6nehusy@skbuf>
 <20250221182409.00006fd1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221182409.00006fd1@gmail.com>
X-ClientProxiedBy: VI1PR04CA0086.eurprd04.prod.outlook.com
 (2603:10a6:803:64::21) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GVXPR04MB10971:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a922cca-d036-488e-6166-08dd52649954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?31Rh0BkkoMP8r77dR4FxSzZ+w5+pYiPVqOhsgcflkyE2BWkBz9AsS2Y28Zdz?=
 =?us-ascii?Q?vrryMF8bUSIG69ARPivmadO0FlO2T2wm/k9qidMou7N6tI1E60fFkhhhRcBi?=
 =?us-ascii?Q?/mFOvuircl2QGHE4QLrn8015czA8g7ldjhYKnwNF88y1YFgCipPTulcBr5Vb?=
 =?us-ascii?Q?8Z4scdgJXY3412ca5y1P26Npc42zlN6f0qis80KbIuEN89xXSXnzgBRYYkDw?=
 =?us-ascii?Q?FPJI/3M0qWBWNzFoCrfxW2bJkhpyRhBfOX0FDqxXTujJ4JqGCsn9iwwwT7Gr?=
 =?us-ascii?Q?Y+aMvZLN4AhjKm3N3nSZECh2sledL8N5FHBhUjGk4H7m2AeaprKqxl9tS6dK?=
 =?us-ascii?Q?F7jW6ExS/H2o1EWiZe0V8PV2xO5SLhaoEeasnlhW+UOgkUsQHiijnB9qu0iJ?=
 =?us-ascii?Q?EnBifIDSXl1aoZjK98VA/BdSfAxMIh/DdnCbLGObyDG7zS1NEof1AjdW5ojG?=
 =?us-ascii?Q?QRV36N2rL+ntk2KgPnzy1bba53AR+ufPc/oY2my9/uPY1CbuOh8i3BNd6nLy?=
 =?us-ascii?Q?YIMMdfckFEhozub7v8aXzWey19MUyKxY3PoOq7vuGIzmBI40PZ/4SVnAJRhb?=
 =?us-ascii?Q?RPTsJ3j4ZDgyTWJfTGxLQaLsFNMa3a003WzgHbNOIF8eQ9Ntor/+9iZgJvSQ?=
 =?us-ascii?Q?5oxMXbl3vODLwnKFurvNwF9MWNA7zg0uVu4rBDC3LcIYhIcrnYzhgCC+KdCK?=
 =?us-ascii?Q?La9umIDHqpUu6QHbgK6oh2Y3Rdm2fX+WcbasoVkp0wnyw6mhO4lvibeVJhyk?=
 =?us-ascii?Q?bVAtyt+NPJO7Cy9z8n2T0XnCvC0meKAMJTIJVnUNqJBBcR1Ch6+cs8jXEMfG?=
 =?us-ascii?Q?pV4LQw0vjbD+05EPgdb2KtdkqGxmT1337NasQQWZVmA0ISJT0W8NHYQwuNzY?=
 =?us-ascii?Q?nUWjD4WvXYtT/zhALqQelThtwUL6jBA1vAa8GS7lQljFtAe/a5A4U5zJiN/8?=
 =?us-ascii?Q?XG+Ab6dgLjW8EW+xoIeeudneTaMQRGFMBXcxwYUWruHiQOOvKlU+Q3g98HeQ?=
 =?us-ascii?Q?nz+RP0x4HNQPkEUTusAu4ezE5yNtbmmyf5WTy7DKYYQB1so3ncMjNKVef9sl?=
 =?us-ascii?Q?8GzHUS/GmT1usJdKR0LxZ9qnxbVQcSGEe3fFO6ZYQlIVSD7IXuMBqTNQv+he?=
 =?us-ascii?Q?GeR3nJXn+ZCONXWwx1LEn3ffsT+m/7+2YrowLWoEh0dpaJGUsSrh5kSBJi4M?=
 =?us-ascii?Q?5WXCQ1E87mS9t51F0JojlOj6FT6wSxn8tE8+aE58flQbh3yrOV02FikU2npQ?=
 =?us-ascii?Q?31mUT5JWIH5HvSGcb+1WRJ1A+Sk4rRtHsVzLi8V18ioG1Z4SaxENh1y3Bljq?=
 =?us-ascii?Q?Gb3Hg5kfRRd8r+4CgXcLLT9qQ+BL0s9HxoMB1LwcUCKl7I/vF/UXu1TgnWJW?=
 =?us-ascii?Q?kEjJYMRXJcpxtECGQJBtXGUp94Ol?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AWOUjLdubmL0ilXUtpfOczPYSUTgwz7O616BCPyHLxMW3JgOsebP7IQ6TXgR?=
 =?us-ascii?Q?lpB+mN/p3eMBmDt+ZLUb/rabr8Av2PmGMroEgVgLv8lx7k6pXar3fBzDx9/s?=
 =?us-ascii?Q?ui95lQfhGFYinxh43t8G8/Xnh0MgNPkaFGKvdi1oH5W2VYFREEj6h2KHsxFv?=
 =?us-ascii?Q?1vFKfWXMGhRsU1+L7muto40+oFpr8rukFj50TVlyg2mQ7YtCzDTc16uFOexD?=
 =?us-ascii?Q?gYQHNNmlHU7y2W8jM5jQH6pvz2GzOhUp7miZWdTADPlszGnoQfxYqaRVL2wA?=
 =?us-ascii?Q?I/BvhhsznA0fovJkkeByr7xO8EC3FAU3uCTCMZHhY8E33GcM5PlmPH0nM0Dm?=
 =?us-ascii?Q?V0iAnKliu8ZBSWqacUxnwZP+8OWPiaUrCIdosFFLfOhqORxkpRralVO/uW5g?=
 =?us-ascii?Q?F4kydcfQuXT0fodLTsZv3JcmnhWdRTk6BxkM7uu2XctkWyAuvErDH4ei6/6i?=
 =?us-ascii?Q?X0EG4BUGrSwOxIHoTtYRP4zEdl8VtzVsb5XDV9KHfTRVBn7DxBkRfHMuF0QS?=
 =?us-ascii?Q?S2Do6q2IqPCgDQui/8KuuivmRwYbGZdrX5YYiAEyxQsXGUeAc6qfcfLkjTmy?=
 =?us-ascii?Q?kKyJpkvsp7WYI/WmBdhFQ52JiNcUQyHLVznkyCxsdXcPrxDNBS3Hk6Cyexwg?=
 =?us-ascii?Q?qYH3ueY0EholAOV5+jQP11NENJaa9P1aLb/1gtsASeYKZX2rJVCJ8oTY5g5r?=
 =?us-ascii?Q?5UzfpLC8VVQnzeVUJv7VdaEh03hnwS8hjZE1kMNQ3fVAFER3Ou6I4RhnSEs3?=
 =?us-ascii?Q?8rU295M7W7K7Z5Lc66nsmt1LJWb3dunAinLYX2OqQNd1PxtuZ3z8G4pnDNXG?=
 =?us-ascii?Q?EAiDlHtcQKw0M/0etWga8gUnw4+vQw938ykcMLmXLeZ4I0xLJkA8t2oklF5C?=
 =?us-ascii?Q?S+QXgRzUrCoe4hNFmRxyVeiWDFo1BM/WgiBoEWN/7Rjy/gssH9scaPZXfiZy?=
 =?us-ascii?Q?ERLv0Mbq+KGdXq/xLnqFXzlqmoCbdEZCM7Yf0CWOpRnxd1CPBzcB3zLBARO1?=
 =?us-ascii?Q?x6/iEJyAMhmEF8kiSjeHQWDLXo/EHthf6bcPRWz7LCmF9FMxx0p2XTu9dca/?=
 =?us-ascii?Q?i2gQqIGSjr32dQdhraTihBGSORdBfubyvWBadKg3BblF9LFtgwsQqmDpyvVx?=
 =?us-ascii?Q?qXqChAt3GbrnYg58H4PMlP5CHdlJuzgcQveQFjGQa8HFxoBWazUtOx+Z0V5E?=
 =?us-ascii?Q?HwkQoj08UbV0sZLdJo1Xms+zeUbht2YL+J+lY8P+3NrXrJPCq2HmLbMl7hta?=
 =?us-ascii?Q?SoRTguJH+2hXYJ3Y28HKm9IAY2c5XRHGjYXPaNr1gbAaVTq+DycPZBF6zVQd?=
 =?us-ascii?Q?khGMXQZ0091qpmRBD1rFMjZTSKPWaxoahq5QB3VvT3n9vT/ov+U9Etr760hu?=
 =?us-ascii?Q?5sZ2JuOObHivq27eyk4CTEtjs7DOodisGy6Hk7D0KCs/jAXNpHNRZIyFXAJ3?=
 =?us-ascii?Q?f93d0d3P/YjSm3AVTZEv0KS47gUkvlaeQ95e4MCW3yoWTAq5ioGc+Va6wJAI?=
 =?us-ascii?Q?DqJaV5RaPmfqipynNPwRrZiVZpu/kgM2bbTNQ1O9rRZAXhbzbzo7n1a5+yCK?=
 =?us-ascii?Q?dku6ZPrkNy5DylV1Ud8hrYDUUILkL6zViJIAr0XrkVegyBlugtfn9s7x7/TV?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a922cca-d036-488e-6166-08dd52649954
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 10:43:38.0583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74geiKKLS2ECvYseyT3d5zg2aCkfEOYTgbLyDxBrhOC8j9ShWWU3wvcCIltJfSef34IoY8bDhNK8zG4qOB2k8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10971

On Fri, Feb 21, 2025 at 06:24:09PM +0800, Furong Xu wrote:
> Your fix is better when link is up/down, so I vote verify_enabled.

Hmmm... I thought this was a bug in stmmac that was carried over to
ethtool_mmsv, but it looks like it isn't.

In fact, looking at the original refactoring patch I had attached in
this email:
https://lore.kernel.org/netdev/20241217002254.lyakuia32jbnva46@skbuf/

these 2 lines in ethtool_mmsv_link_state_handle() didn't exist at all.

	} else {
>>>>		mmsv->status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
>>>>		mmsv->verify_retries = ETHTOOL_MM_MAX_VERIFY_RETRIES;

		/* No link or pMAC not enabled */
		ethtool_mmsv_configure_pmac(mmsv, false);
		ethtool_mmsv_configure_tx(mmsv, false);
	}

Faizal, could you remind me why they were added? I don't see this
explained in change logs.

