Return-Path: <bpf+bounces-74251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED262C4F6F3
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 19:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C4AC4E8A6A
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 18:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259D8369973;
	Tue, 11 Nov 2025 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FB0Euxso"
X-Original-To: bpf@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B865C2BE7C0;
	Tue, 11 Nov 2025 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762885566; cv=fail; b=qMzMgMf20M3jTXW94d4RLQ6NMvwzH8Ykw50DI8YNI9QNpyZQ8UEZ/JO6E+fuTZcFl3Aa3tgvG1TXdk2Xl/f/Tvxmhcw0PJPVPAEMCD7nmZO0F5y3VKyFlo2J9zZw7C+G2Ka/ZkWkTas2P+2+CDsotedVVL9/polDENKVncAgp6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762885566; c=relaxed/simple;
	bh=Gc0fNIrMQ8UM76OqonBtItSfYXSM6AZ8iOITNW64+PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VU1eSQtyQm8dLNskhcS31UxDN53CjqFcjkFSN7xY9C2br6C8he8QIW2FgLWSrh1fIv7+GAR4Cojz6tglkJ+hDBCO8BV4sfB3A97R74aWtlqz7wT6itxhUjkZLt1xDu2QWfM58gLzID9O+lcqXEUZfufTSu3ogE9LWfjdpzziTfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FB0Euxso; arc=fail smtp.client-ip=52.101.62.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gl06pvu8hV/7WBFDfo7deTeecJZZFD8p+EeCnsJLNZr9MmW3/lDsxLZB5tcrlvBXxCmHckm5R2iXii8cpCi/zag8znKKkwHmYp7TAjH/YJQ8p7vxelosjDyNH5VBgMJrGYjQCr33Xvkfr98M/qgZ5VPvAKjdOkX/sZurc1NqhFdTmeVABuaxC+bxkXXaX2zpzzyDayKKIMMrlVXhMuuXkzwJRgHT5mnccratTgAmuny3wZcEQUveG+NhUKe09WsAcbdq4jJtYi1E9ILU5mHW+j2Q7IiHOUGlQI7cfHLv3zHjixjYeHvXZbE5CD2RKMPo7gE1iGBv/xGWljg8xcwKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ut5rNM5wan1LMRuIIgt5fZgdZ6hjBMbco+QMDAzzUH8=;
 b=bS6VJ0Axzr3l9GNfi2afTg/QSfWRwww6y2skKU3T5FM4e8f+Wr3RNQnIxnC0okbvN4wMsBI6t4/Rn7G3ZqvMw8KNYliNm+Sh8DzJI8hmzIHLsHW1QwfqQvNlKN+nZ4b4S/dZUnm1XfiIqgCE/QIUyz2iv2UGvodbIKE+i0Qn6HdlkX7fpQGX6K8EIj1B+gGNvEyauMvw2qefnkIhc5ljLwKllaoXBqzRYGo3fSa4g1HBe4KnEnKb0RrmgR5CYRPvk2Ab05PcZJhNFpYmvNgSZBurbwKgBV5uzPZsqxHUfo9sleS0hslB0D48x1c0pgQvvn7bbi3ETGRZ38IYSgXbHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ut5rNM5wan1LMRuIIgt5fZgdZ6hjBMbco+QMDAzzUH8=;
 b=FB0EuxsoD5y+DQjK5hRgQOrnMKbKduYOgfz1+DMxxlTPliJi5bwiRd1PydKL50OZorvGHUAUTcJk8nUhps7ziSVnZYA7fqmq/hSPQ031HPfDyJIOjfqa9w2Igy+10IY49ShF9njh0F5bnW85B55ulFrtiWxp8LtbGZC6/3WoLpVmW27rzgj28do1wOkkDh9oFA88yMPVo2drk0uhKIdkgu2izjSFy51803AwFSFLklsRiYh9Isz+daNf6E9qG+h/GG589SVo7PLZYmbUwK/NfC2PjJ7GhaMsuvr9CAe7XNOs855fo1OuWs11LdMbq5uxfZDIe2J2sR/dSLsukOBcyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 18:25:55 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 18:25:55 +0000
Date: Tue, 11 Nov 2025 18:25:44 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Simon Horman <horms@kernel.org>, Toshiaki Makita <toshiaki.makita1@gmail.com>, 
	David Ahern <dsahern@kernel.org>, Toke Hoiland Jorgensen <toke@redhat.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	KP Singh <kpsingh@kernel.org>
Subject: Re: [RFC 2/2] xdp: Delegate fast path return decision to page_pool
Message-ID: <wrhhvaolxu275zw3fxgvykg7tndzp4pl4u3mnw3z4t5yfbkpix@i2abs45et7tr>
References: <20251107102853.1082118-2-dtatulea@nvidia.com>
 <20251107102853.1082118-5-dtatulea@nvidia.com>
 <d0fc4c6a-c4d7-4d62-9e6f-6c05c96a51de@kernel.org>
 <4eusyirzvomxwkzib5tqfyrcgjcxoplrsf7jctytvyvrfvi5fr@f3lvd5h2kb2p>
 <58b50903-7969-46bd-bd73-60629c00f057@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58b50903-7969-46bd-bd73-60629c00f057@kernel.org>
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c2f0b5-0317-4e89-bf28-08de214fc0ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iOKrcXC9NcfEjZ6pVk52Wtp15Hp/hzCBntSmqCevnLXGoVGTOvmexI6j46xm?=
 =?us-ascii?Q?hniYK+dDuOUsX35mhFMg3FH7mNv5h4oftWvy2TdFIRZh1p63Vd4AQ/JXOYSZ?=
 =?us-ascii?Q?fPdCj4a773pcEFphV5GxeSYgoRjjysasnl+08RvwlXYxHfXt0Jtaut3qBNO3?=
 =?us-ascii?Q?vhLVpHpf6BK2Qi5G7iBHrfhpyICvRTqSThaKHj0BGwZVzeNvBAjEOjcFF4bn?=
 =?us-ascii?Q?DyKH4KRpwbkavvC0hf4ywU+Id59F+HvukgFW6BAaxJSAw3QRo5wC6MjS+Qrs?=
 =?us-ascii?Q?h147JPukBl5nE3fsbWI8PXbKt23okhauu8/kfYSo1ZTT/xYKy/Lk5uLbRh0Q?=
 =?us-ascii?Q?FXjfCjr7YgM4Fzsk/2hzZp2d2EoEa1lYuu7co08yEQ2LqZGe2Wec6wWSABEi?=
 =?us-ascii?Q?tcdjjE+rDl6HS7XzK8fuHXU2h9u2EC9HXQYl57AlSpL4dEb2jsCy1fW63w+h?=
 =?us-ascii?Q?sLbwllH1mRFEaB9KmMAAFkhnd00lWSscfPlFCQOo/uNBGqoPcFc8nBCCc705?=
 =?us-ascii?Q?xQAGIwuXHCypwfFPF76EkC3/kKSxreiyjih48truY8I6iqZmkIGci+BLTl4a?=
 =?us-ascii?Q?eBDZi0AM9sv4ruFN2aOcZOvbP0mVlPRMahJOkLJxMFnDwvhA2asHLt2yF/IK?=
 =?us-ascii?Q?+smXOc0Oot5Jo13aYm/rRPAqDgssIw0zz1PZ7RBWash4e3aiAFW7oNEN8qQB?=
 =?us-ascii?Q?SaE6MT8iys3Q0lzmHTSTm87VlYN/qSYaBVRlRK/WY7XV7WbUDiHjtCBGo2uX?=
 =?us-ascii?Q?wAT7/gujpoMvIUubJxcyK/AtFTIWSQhdOl8LABcF70lNiQqJnrxaHPYau7f/?=
 =?us-ascii?Q?IEoxXjlj/RylcImBekn+TGKEY+CzCj32D14RuRqsvMyZXtJ9KQ41J559BxET?=
 =?us-ascii?Q?n4bbt7UpN8hBRgW5dq11P5dvwDe3hO1bayiwqtmKdbHd/zL5bD/B9qzShlln?=
 =?us-ascii?Q?wJf+fi5VfNgJxr7Zv/KNlbYvRPmtU88bjSCh+3/LqaKPecSneoYUbCsdNhss?=
 =?us-ascii?Q?QaI7wFMnm0iMfzW1GHS/RCkMW3qIJMx7Y530Wu7AOmstGrVfwmemoE5thsmT?=
 =?us-ascii?Q?SkwB1qyHhECQWd06a+FJctCpkwXZht1+fzDbWzlRc4muzLxBfRM+tyE2YKwO?=
 =?us-ascii?Q?tRdB7s7MqeE49ocbgBOj5eUGwWSyiQ5LC3ZmLk0Y3CURV2acLKmYIpnlCaLJ?=
 =?us-ascii?Q?ZPrq1GAMS+TUcvFm3ePF56wKpcFvADydo7KYt4rVEUUztoj3184PtmNySUl1?=
 =?us-ascii?Q?ooP6HuZKnAo3/tvlENtKM65KgbYHx0Oa03GuBO1vzsOuRVIYceTNdRkuSh65?=
 =?us-ascii?Q?VkueNPdZiu4dgsM6yb27DFgN/XWjrzHD/POWV48KatigPsmRvbZ+Hpc9Ilde?=
 =?us-ascii?Q?MOuWCIlcDHyZ3CIvLQARp5tiPvmKBB9zBrb/4aq0jVD1JdWTqrut3aHkUYDG?=
 =?us-ascii?Q?Pgn71qgGhb+ZNy8bnKSWGMIGPFQoHb7sns6fcEo3R5em4+sy4wQX0VATMosA?=
 =?us-ascii?Q?aw+rhrlvq5u32OJLIADp3dLBXuzonQBuFN1i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CX/Q3srnr8xD0XPKNfSLYMYELFSQjkRZ7lS0lgbVWytBpyotBqlDmDGNWsGL?=
 =?us-ascii?Q?Yrbj7IxAh+Lo2Z+ptYVQuWfCkZAeUnwpf6LwePwQthOO4jD4HnFqCbfIAfCu?=
 =?us-ascii?Q?AP0iJRDI8Pu/lP8QAb3ZOecgoHoxBpx/syiJrsACdhTn6pSLc/IPVPT6L2fJ?=
 =?us-ascii?Q?kiE/WFNHxRVqdaAZbZgfer9nTErKikErBe7qhng2fsg4OWHTdq5SuH0nwb4+?=
 =?us-ascii?Q?g5XxMp1XUhLFgS+seWkslDOFegs3TuxbSSEnghN+HtHidC6vKww4AN9Dmq2I?=
 =?us-ascii?Q?PxI6HX2cbJYQH1VpjS2vqohsoWiFEfzWUdb8x24HcKAraRTu1fZe/PwD7u4k?=
 =?us-ascii?Q?MWkhgWxtecNF5Na6DoR9a2dS9oWL2TETN/07QgrrkKbkQdZobEIMsJV6Dssa?=
 =?us-ascii?Q?zyWd0r3pKCZPU5Za6+igpBRoSJKJ6gmK2hT1yQFdInImGcHiBPavVfwQTH/g?=
 =?us-ascii?Q?G7GffSDejz0e3cEK5AuDdSAYMf3v5OhxLoA6GuFbmGiS0jqc1jNJg2oM/+F0?=
 =?us-ascii?Q?D3f+HyU1PSS/e5aBIs9UYMa9k4G7XmqMhvvAHBvqFHOfTaK4z0J5HAzGJkRy?=
 =?us-ascii?Q?Rz0BkdTdlViYKAMQjxaQ1eaiQZLmyRlwtj7GWyHm1GR1c064YRn9l2raXtyn?=
 =?us-ascii?Q?8L7atz5k1SJ++NKI2XgpNgTUzye2L7rDxVKcRA2XLjq1VIjoZfqz3Avvhb9k?=
 =?us-ascii?Q?SMXHvq53vhjDJopZu4RL9TXteHofxB52gthX+/yoSfTky6SPZS5HA2Jh1N4E?=
 =?us-ascii?Q?vByspx0TMkpk0PCczRxWQZ0hgZ/TYzn47WONENuKx0yXmNfMECS1PkyJLJdV?=
 =?us-ascii?Q?CEH+2eOPIfjbZkf+UkLwclh+knTOI8s9K1mVul6CHR16UGhWCOPctjJmLRdY?=
 =?us-ascii?Q?QWtBGKnKlvE27i8gKqbAfDJ6PRXwyU41eI07C/q3au/XyTWYiXcNEJ5jvsh7?=
 =?us-ascii?Q?x/mNRu+/9lwxyW7mgDtcAErZ1+qrE1i8SEdSx9ozFrHuAyh7RJoJMBrag9f3?=
 =?us-ascii?Q?WTA9ykD8EtCWT7MTwoYr2V3G1fmCUjOmDHIHUXVvSthRhXul6XLYiQi0sitg?=
 =?us-ascii?Q?5EhBNcuzSmm76/8FC72w72AoV+37FE59JGxOOHIt/YIuXEGlvYFS4DlphSEp?=
 =?us-ascii?Q?kck9y5AsKgvLDWwOmh1YjTh675Rn/RZLtcRGOIprd3K4aCWcvq9PhLku6YLD?=
 =?us-ascii?Q?71iFtGkCUXqb2l3Erzr42I+kTPfEIqK4cVCwQxzm7x6gOmNgVzuJ+xfDMIhr?=
 =?us-ascii?Q?4oyH7UFG79nq+7bmwDda3UHISS0F51Rb9Cy5uRvrXB+1FVdYnp9WVj0wi25g?=
 =?us-ascii?Q?23T0TFHnTZDftLcpHJOD001iSG53hGWbNRJCGIxP1GXNszhnCIWZd6kK3JgJ?=
 =?us-ascii?Q?LbTe5dCC+oEzCdw8txNZ63WVnfAah647iGjvInuU7kKjEhMrpy/Gb7umJgId?=
 =?us-ascii?Q?YqIOnOnImYzcqhaf1LI135U7smwM8S/Ucq/e1hqWw5z4d1YQtCp3zf4QCBLD?=
 =?us-ascii?Q?9aIxOaCCawNdJdH+e0CiYlaBr0SqEf40hkYpuzxznbWs7MIJXJ5k+NmCAuwP?=
 =?us-ascii?Q?6KNIu6/Nxkger9FxalIPK7+9ywS8GdjUFOx0bcfw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c2f0b5-0317-4e89-bf28-08de214fc0ce
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 18:25:55.5854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gX1EYJlgCvEJWe4nq2ACVVb4tXbS5/nQ39+orlzgGXPYidkM4dFcIQ4OZieXlnat2Si8QvsdbeOdBL5UUQ1UZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759

On Tue, Nov 11, 2025 at 08:54:37AM +0100, Jesper Dangaard Brouer wrote:
> 
> 
> On 10/11/2025 19.51, Dragos Tatulea wrote:
> > On Mon, Nov 10, 2025 at 12:06:08PM +0100, Jesper Dangaard Brouer wrote:
> > > 
> > > 
> > > On 07/11/2025 11.28, Dragos Tatulea wrote:
> > > > XDP uses the BPF_RI_F_RF_NO_DIRECT flag to mark contexts where it is not
> > > > allowed to do direct recycling, even though the direct flag was set by
> > > > the caller. This is confusing and can lead to races which are hard to
> > > > detect [1].
> > > > 
> > > > Furthermore, the page_pool already contains an internal
> > > > mechanism which checks if it is safe to switch the direct
> > > > flag from off to on.
> > > > 
> > > > This patch drops the use of the BPF_RI_F_RF_NO_DIRECT flag and always
> > > > calls the page_pool release with the direct flag set to false. The
> > > > page_pool will decide if it is safe to do direct recycling. This
> > > > is not free but it is worth it to make the XDP code safer. The
> > > > next paragrapsh are discussing the performance impact.
> > > > 
> > > > Performance wise, there are 3 cases to consider. Looking from
> > > > __xdp_return() for MEM_TYPE_PAGE_POOL case:
> > > > 
> > > > 1) napi_direct == false:
> > > >     - Before: 1 comparison in __xdp_return() + call of
> > > >       page_pool_napi_local() from page_pool_put_unrefed_netmem().
> > > >     - After: Only one call to page_pool_napi_local().
> > > > 
> > > > 2) napi_direct == true && BPF_RI_F_RF_NO_DIRECT
> > > >     - Before: 2 comparisons in __xdp_return() + call of
> > > >       page_pool_napi_local() from page_pool_put_unrefed_netmem().
> > > >     - After: Only one call to page_pool_napi_local().
> > > > 
> > > > 3) napi_direct == true && !BPF_RI_F_RF_NO_DIRECT
> > > >     - Before: 2 comparisons in __xdp_return().
> > > >     - After: One call to page_pool_napi_local()
> > > > 
> > > > Case 1 & 2 are the slower paths and they only have to gain.
> > > > But they are slow anyway so the gain is small.
> > > > 
> > > > Case 3 is the fast path and is the one that has to be considered more
> > > > closely. The 2 comparisons from __xdp_return() are swapped for the more
> > > > expensive page_pool_napi_local() call.
> > > > 
> > > > Using the page_pool benchmark between the fast-path and the
> > > > newly-added NAPI aware mode to measure [2] how expensive
> > > > page_pool_napi_local() is:
> > > > 
> > > >     bench_page_pool: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
> > > >     bench_page_pool: Type:tasklet_page_pool01_fast_path Per elem: 15 cycles(tsc) 7.537 ns (step:0)
> > > > 
> > > >     bench_page_pool: time_bench_page_pool04_napi_aware(): in_serving_softirq fast-path
> > > >     bench_page_pool: Type:tasklet_page_pool04_napi_aware Per elem: 20 cycles(tsc) 10.490 ns (step:0)
> > > > 
> > > 
> > > IMHO fast-path slowdown is significant.  This fast-path is used for the
> > > XDP_DROP use-case in drivers.  The fast-path is competing with the speed
> > > of updating an (per-cpu) array and a function-call overhead. The
> > > performance target for XDP_DROP is NIC *wirespeed* which at 100Gbit/s is
> > > 148Mpps (or 6.72ns between packets).
> > > 
> > > I still want to seriously entertain this idea, because (1) because the
> > > bug[1] was hard to find, and (2) this is mostly an XDP API optimization
> > > that isn't used by drivers (they call page_pool APIs directly for
> > > XDP_DROP case).
> > > Drivers can do this because they have access to the page_pool instance.
> > > 
> > > Thus, this isn't a XDP_DROP use-case.
> > >   - This is either XDP_REDIRECT or XDP_TX use-case.
> > > 
> > > The primary change in this patch is, changing the XDP API call
> > > xdp_return_frame_rx_napi() effectively to xdp_return_frame().
> > > 
> > > Looking at code users of this call:
> > >   (A) Seeing a number of drivers using this to speed up XDP_TX when
> > > *completing* packets from TX-ring.
> > >   (B) drivers/net/xen-netfront.c use looks incorrect.
> > >   (C) drivers/net/virtio_net.c use can easily be removed.
> > >   (D) cpumap.c and drivers/net/tun.c should not be using this call.
> > >   (E) devmap.c is the main user (with multiple calls)
> > > 
> > > The (A) user will see a performance drop for XDP_TX, but these driver
> > > should be able to instead call the page_pool APIs directly as they
> > > should have access to the page_pool instance.
> > > 
> > > Users (B)+(C)+(D) simply needs cleanup.
> > > 
> > > User (E): devmap is the most important+problematic user (IIRC this was
> > > the cause of bug[1]).  XDP redirecting into devmap and running a new
> > > XDP-prog (per target device) was a prime user of this call
> > > xdp_return_frame_rx_napi() as it gave us excellent (e.g. XDP_DROP)
> > > performance.
> > > 
> > Thanks for the analysis Jesper.
> 
> Thanks for working on this! It is long over due, that we clean this up.
> I think I spotted another bug in veth related to
> xdp_clear_return_frame_no_direct() and when NAPI exits.
>
What is the issue? Besides the fact that the code is using
xdp_return_frame() which doesn't require
xdp_clear_return_frame_no_direct() anyway.

> > > Perhaps we should simply measure the impact on devmap + 2nd XDP-prog
> > > doing XDP_DROP.  Then, we can see if overhead is acceptable... ?
> > > 
> > Will try. Just to make sure we are on the same page, AFAIU the setup
> > would be:
> > XDP_REDIRECT NIC1 -> veth ingress side and XDP_DROP veth egress side?
> 
> No, this isn't exactly what I meant. But the people that wrote this
> blogpost ([1] https://loopholelabs.io/blog/xdp-for-egress-traffic ) is
> dependent on the performance for that scenario with veth pairs.
> 
> When doing redirect-map, then you can attach a 2nd XDP-prog per map
> target "egress" device.  That 2nd XDP-prog should do a XDP_DROP as that
> will allow us to measure the code path we are talking about. I want test
> to hit this code line [2].
> [2] https://elixir.bootlin.com/linux/v6.17.7/source/kernel/bpf/
> devmap.c#L368.
> 
> The xdp-bench[3] tool unfortunately support program-mode for 2nd XDP-
> prog, so I did this code change:
> 
> diff --git a/xdp-bench/xdp_redirect_devmap.bpf.c
> b/xdp-bench/xdp_redirect_devmap.bpf.c
> index 0212e824e2fa..39a24f8834e8 100644
> --- a/xdp-bench/xdp_redirect_devmap.bpf.c
> +++ b/xdp-bench/xdp_redirect_devmap.bpf.c
> @@ -76,6 +76,8 @@ int xdp_redirect_devmap_egress(struct xdp_md *ctx)
>         struct ethhdr *eth = data;
>         __u64 nh_off;
> 
> +       return XDP_DROP;
> +
>         nh_off = sizeof(*eth);
>         if (data + nh_off > data_end)
>                 return XDP_DROP;
> 
> [3] https://github.com/xdp-project/xdp-tools/tree/main/xdp-bench
> 
> And then you can run thus command:
>  sudo ./xdp-bench redirect-map --load-egress mlx5p1 mlx5p1
>
Ah, yes! I was ignorant about the egress part of the program.
That did the trick. The drop happens before reaching the tx
queue of the second netdev and the mentioned code in devmem.c
is reached.

Sender is xdp-trafficgen with 3 threads pushing enough on one RX queue
to saturate the CPU.

Here's what I got:

* before:

eth2->eth3             16,153,328 rx/s         16,153,329 err,drop/s            0 xmit/s       
  xmit eth2->eth3               0 xmit/s       16,153,329 drop/s                0 drv_err/s         16.00 bulk-avg     
eth2->eth3             16,152,538 rx/s         16,152,546 err,drop/s            0 xmit/s       
  xmit eth2->eth3               0 xmit/s       16,152,546 drop/s                0 drv_err/s         16.00 bulk-avg     
eth2->eth3             16,156,331 rx/s         16,156,337 err,drop/s            0 xmit/s       
  xmit eth2->eth3               0 xmit/s       16,156,337 drop/s                0 drv_err/s         16.00 bulk-avg

* after:

eth2->eth3             16,105,461 rx/s         16,105,469 err,drop/s            0 xmit/s        
  xmit eth2->eth3               0 xmit/s       16,105,469 drop/s                0 drv_err/s         16.00 bulk-avg     
eth2->eth3             16,119,550 rx/s         16,119,541 err,drop/s            0 xmit/s        
  xmit eth2->eth3               0 xmit/s       16,119,541 drop/s                0 drv_err/s         16.00 bulk-avg     
eth2->eth3             16,092,145 rx/s         16,092,154 err,drop/s            0 xmit/s        
  xmit eth2->eth3               0 xmit/s       16,092,154 drop/s                0 drv_err/s         16.00 bulk-avg

So slightly worse... I don't fully trust the measurements though as I
saw the inverse situation in other tests as well: higher rate after the
patch.

Perf top:

* before:
  13.15%  [kernel]                                              [k] __xdp_return
  11.36%  bpf_prog_3f68498fa592198e_redir_devmap_native         [k] bpf_prog_3f68498fa592198e_redir_devmap_native
   9.60%  [mlx5_core]                                           [k] mlx5e_skb_from_cqe_mpwrq_linear
   8.19%  [mlx5_core]                                           [k] mlx5e_handle_rx_cqe_mpwrq
   7.54%  [mlx5_core]                                           [k] mlx5e_poll_rx_cq
   6.23%  [kernel]                                              [k] xdp_do_redirect
   5.10%  [kernel]                                              [k] page_pool_put_unrefed_netmem
   4.86%  [mlx5_core]                                           [k] mlx5e_post_rx_mpwqes
   4.78%  [mlx5_core]                                           [k] mlx5e_xdp_handle
   3.87%  [kernel]                                              [k] dev_map_bpf_prog_run
   2.74%  [mlx5_core]                                           [k] mlx5e_page_release_fragmented.isra.0
   2.51%  [kernel]                                              [k] dev_map_enqueue
   2.33%  [kernel]                                              [k] dev_map_redirect
   2.19%  [kernel]                                              [k] page_pool_alloc_netmems
   2.18%  [kernel]                                              [k] xdp_return_frame_rx_napi
   1.75%  [kernel]                                              [k] bq_enqueue
   1.64%  [kernel]                                              [k] bpf_dispatcher_xdp_func
   1.37%  [kernel]                                              [k] bq_xmit_all
   1.34%  [kernel]                                              [k] htab_map_update_elem_in_place
   1.20%  [mlx5_core]                                           [k] mlx5e_poll_ico_cq
   1.10%  [mlx5_core]                                           [k] mlx5e_free_rx_mpwqe
   0.66%  bpf_prog_07d302889c674206_tp_xdp_devmap_xmit_multi    [k] bpf_prog_07d302889c674206_tp_xdp_devmap_xmit_multi
   0.55%  bpf_prog_b30cf65b7e0fa9c7_xdp_redirect_devmap_egress  [k] bpf_prog_b30cf65b7e0fa9c7_xdp_redirect_devmap_egress
   0.40%  [kernel]                                              [k] htab_map_hash
   0.35%  [kernel]                                              [k] __dev_flush

* after:
  12.42%  [kernel]                                              [k] __xdp_return
  10.22%  bpf_prog_3f68498fa592198e_redir_devmap_native         [k] bpf_prog_3f68498fa592198e_redir_devmap_native
   9.04%  [mlx5_core]                                           [k] mlx5e_skb_from_cqe_mpwrq_linear
   8.34%  [mlx5_core]                                           [k] mlx5e_handle_rx_cqe_mpwrq
   7.93%  [mlx5_core]                                           [k] mlx5e_poll_rx_cq
   6.51%  [kernel]                                              [k] xdp_do_redirect
   5.24%  [mlx5_core]                                           [k] mlx5e_post_rx_mpwqes
   5.01%  [kernel]                                              [k] page_pool_put_unrefed_netmem
   5.01%  [mlx5_core]                                           [k] mlx5e_xdp_handle
   3.76%  [kernel]                                              [k] dev_map_bpf_prog_run
   2.92%  [mlx5_core]                                           [k] mlx5e_page_release_fragmented.isra.0
   2.56%  [kernel]                                              [k] dev_map_enqueue
   2.38%  [kernel]                                              [k] dev_map_redirect
   2.09%  [kernel]                                              [k] page_pool_alloc_netmems
   1.70%  [kernel]                                              [k] xdp_return_frame
   1.67%  [kernel]                                              [k] bq_xmit_all
   1.66%  [kernel]                                              [k] bq_enqueue
   1.63%  [kernel]                                              [k] bpf_dispatcher_xdp_func
   1.27%  [kernel]                                              [k] htab_map_update_elem_in_place
   1.20%  [mlx5_core]                                           [k] mlx5e_free_rx_mpwqe
   1.08%  [mlx5_core]                                           [k] mlx5e_poll_ico_cq
   0.67%  bpf_prog_07d302889c674206_tp_xdp_devmap_xmit_multi    [k] bpf_prog_07d302889c674206_tp_xdp_devmap_xmit_multi
   0.59%  [kernel]                                              [k] xdp_return_frame_rx_napi
   0.54%  bpf_prog_b30cf65b7e0fa9c7_xdp_redirect_devmap_egress  [k] bpf_prog_b30cf65b7e0fa9c7_xdp_redirect_devmap_egress
   0.46%  [kernel]                                              [k] htab_map_hash
   0.38%  [kernel]                                              [k] __dev_flush
   0.35%  [kernel]                                              [k] net_rx_action

I both cases pp_alloc_fast == pp_recycle_cached.

> Toke (and I) will appreciate if you added code for this to xdp-bench.
> Supporting a --program-mode like 'redirect-cpu' does.
> 
> 
Ok. I will add it.

Thanks,
Dragos


