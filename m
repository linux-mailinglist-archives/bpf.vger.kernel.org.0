Return-Path: <bpf+bounces-41396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D25A09969A1
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 14:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11B01C221DC
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 12:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451BE193063;
	Wed,  9 Oct 2024 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ff5pFKVq"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928A9192B8A;
	Wed,  9 Oct 2024 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475807; cv=fail; b=qNBhJ0DKfvgsEq3xOsQ+zddFp/aS9Q8ZSlpKTHluwFMBKwzt0kBgVstP3OFudPccOJUZbnMyU1fGvL7/DaKLkeEWJCR/huc9PIvDkJb8NMyjaToecNEZkedHuKMhR1ikU8KO6x8x89XbtyNVtBULngxgmfCj+35EzHteGCvM6CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475807; c=relaxed/simple;
	bh=1hrQSxkfB2OsFU0xoTIWM1idIQPAk5KCVmqzUgW0Tz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=drKEO9TXowwGQ2MiAjDv4mgI7fgy9m9l0UTCzK/5M56KHOSaQi7BDZ0JjstWlqR6f5+NT2WG7SIsMb0zN2slnOpYgFYi1SWQiWf0Rv4zuVbx1gAsjjzsKEovM115Put5U+GV2EB3u6i+V2mHFQBDwTbvt/HpGBKIhPL3naO6mlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ff5pFKVq; arc=fail smtp.client-ip=52.101.70.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrVRhETejd96joHjuCAHj5YYjBwyxkCQjvFSyEtOdmbbwBuiAhmT9Bxjg1VD0+jfEYD/vvodvA/BQVj1nhuI5razXSkTwe87PXwQ+L7Phv4ygTc4wkJJEsBdGtJ8AXziq747HE1DyX6Fyu/SCQBk6VA9bG1XLYjyJGtElCwTmiQ9NoxfDE0GsBsctzfVn384zS3LiW/tvDm3LC1wxKRJWoJiegMe4VE3TRiGacALvGs4uAI1pLtb3dU42eetylM0C8BHKMWnXfw78XxYvBjzZxP5AwrJLN7BvQ57tmWLSQRR3gnMBrqo3Rr/KlbQDn5xBZn0nqiVVadHBZfbA+kwIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMDISqC6HwtLoMT2Z6kApzA6lne8lMzN0uwcKMnMR4U=;
 b=p6CB80U8CNz+09HV4xoEZLnZgBjXTT0ptuD0eevprNb8+XpYV3mTHk6PTkWW4+sj05Thh2GmLCKZTj4rePrqcdPCKFuLk2QDzXVZlEn8UewO3lSiOR1ho2SlhcJW0xJ6QSbab3b1uB3KdIaWvlM5FsBgpUTCcKBShc4HJyqALtW9qbXAj479w4F7cTtUwxu/t69eGOcjF2rb0DKloBNOGrCbplvUP0INFwC6P5ReosG5TYKMle+V+78+erYAzkHmkZjZ7EOKStdHe5bJsP+Wr7aUqoWAWTgoPyGkkW/y77vLPoVxEQ2G6YfKe5/FcBkKrbMPQy+5g2hJDX83F1ju7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMDISqC6HwtLoMT2Z6kApzA6lne8lMzN0uwcKMnMR4U=;
 b=Ff5pFKVqc11Yl232UZzt2SPVLoWKZ/N4YibKeKtystGAsZYMaMWrCMkmbgcqsmxKCEBlWfd1+0IjDDaIpPoL4F97mDmxM3AfPOxQImAfyuTFGmSTQ1VSNf7xZStSRbqGzHU0ptFCUWLIgplr0iS/J20xeXvdNJdjoB9fJOQ5s4Jp0XI7lFF3MdnGiXYVZi7mwFYd/AUjOGRxVGZerG2AhPa79b9x1IPz0+NzS2WYnuuqoUAw0Apoac/fVcWG959oXEhSxL4mKiL93clEWunjlw3+Ey9o1ucI2TwkC5Sakmoqk96Y24C10Y4FRWRjhA6notn3KegdU+hrzfuzAdToRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8945.eurprd04.prod.outlook.com (2603:10a6:20b:42c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Wed, 9 Oct
 2024 12:09:56 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 12:09:56 +0000
Date: Wed, 9 Oct 2024 15:09:52 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, claudiu.manoil@nxp.com, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org, imx@lists.linux.dev,
	rkannoth@marvell.com, maciej.fijalkowski@intel.com,
	sbhatta@marvell.com
Subject: Re: [PATCH v3 net 3/3] net: enetc: disable IRQ after Rx and Tx BD
 rings are disabled
Message-ID: <20241009120952.whmd6jemqagkwkoq@skbuf>
References: <20241009090327.146461-1-wei.fang@nxp.com>
 <20241009090327.146461-1-wei.fang@nxp.com>
 <20241009090327.146461-4-wei.fang@nxp.com>
 <20241009090327.146461-4-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009090327.146461-4-wei.fang@nxp.com>
 <20241009090327.146461-4-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR09CA0140.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::24) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8945:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f4b9a39-08ae-4d1c-c91e-08dce85b4a13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?572sm2Z2Ce+Rwab8s6+HI+NZdr+FXeMTP4BWKUsG1Hur7fxo+p9ZwKZ/c+s0?=
 =?us-ascii?Q?tZ4CbCeMy0/KqA7b+C3PQHUGo0o1qeUfMbThD6C1KHh3Z7pDfwX8dlADuUaE?=
 =?us-ascii?Q?rtr2nZRnct9GWJ6jehXJASsFB3tRiTUpgRvIplKeCJr0QWe2MvN6QEk+r/UR?=
 =?us-ascii?Q?7333u3STWfJb/90v/VwwTbWvIAbejx+H0ou6lBrrbeMUgxnHoQO7DHil6J5Z?=
 =?us-ascii?Q?tdAAjEHh8xNPjD1sf1+8h45uboJFK081HNT5mg2TU+qmR2sAVDTej5KiOutC?=
 =?us-ascii?Q?Z8Rpf8DyCb9F2Gteo90rqC3TLa+MvRtHttKSY4Uo6dADVBFwdX68Efz1cKD8?=
 =?us-ascii?Q?2xAVDDkH4kHUlKsfvbcuhGWhhR/Wi2TkAJy9hG1mlpPXmYO+z1JpQWUYrTF0?=
 =?us-ascii?Q?U2E+2OfJV7Q7YhbNwXZ7OpGVRyD/PCuCm4pSrKnOVPwNnTICLP/MNKxF+AQM?=
 =?us-ascii?Q?ZZXgx2AXH58Ll7S8NNCT/93jhYc2Qo1VH7fjTOG/sMYlK1b2NdPlI2jENwRL?=
 =?us-ascii?Q?Q6nP0q7li1To1V2kzpn6ueeWjYghaolmnlXkJ2qABNcUNK3dHAr41YjdnpBD?=
 =?us-ascii?Q?C+E0Dokys1oQjvpavUG5PQuFXB5apigGdwWXdz6+By9P+7T78E5aR5qDGs6+?=
 =?us-ascii?Q?StnijgGQX4/XBp9ZMKcyaX1UDbHgyzRotphGgrHQJpg0BZbsff3gqNuUJNvW?=
 =?us-ascii?Q?K8uwANS9z/023SJnG7sSD3yXMoLWGW26Vm1LHaDdCwRtcANXCEZONA5s4yJZ?=
 =?us-ascii?Q?Zm0zPqs01WzYlINzHeJVwApa4ejBZI4QkUBOkQSdNYWTMvx+kGuE2DWq6lDm?=
 =?us-ascii?Q?aoRypBqsOz8bvK3ev3GjrC3mt7neWt7ywtr5PJPEaE+pVM118ayBtfS6qOnK?=
 =?us-ascii?Q?HeBuTHt8S4yyt4pOuJ8rVPzQa2ByJ3M5dv5Ri3i6Jf0W9VLseYrBOgfOcwxW?=
 =?us-ascii?Q?0RSOwd8OFBlWMzWKqe7px6q5/QrlsCi5rJuvKUrA6/9Bdu9DdpJQMjrKGQJl?=
 =?us-ascii?Q?zPFRkTpg2BYrUwCrJKsO1yegKwkozyfKcDudF3Izcy8+3HavXyveLkTPoTRO?=
 =?us-ascii?Q?R+SLbkwYqOArfBQEZsxWXOUNRtI9nZ2Ul2p/6ivtK/zua5lul2KOoHO/ik5g?=
 =?us-ascii?Q?C8cxCvwwWaV5KXSTbYZdJY7NWfjyQR3XEBfllh2o5MUzL0D5FuvWRQQa8w2h?=
 =?us-ascii?Q?pMdUnK0dChS6chSeeNefmFHHQMuqh5Ab7BPg4uzngpdJhAiVkaH34DB5xH13?=
 =?us-ascii?Q?KGnqp0sP8RiZyuOP+ufRk9r3+eBYRl9k4RkkNj2fbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XhJ+4ednVqKhQMy33HHlFHuKzGaulmOHVFYqM50pzJdomRXeO/MEDnDdpRRE?=
 =?us-ascii?Q?hF0/tQFjbFEnGF3R9keT64TFYs4StJMQcZbGgWeG10S5XSEvVTj75zeIZZVb?=
 =?us-ascii?Q?C1zEv33j8vB4AYr4ijyiIIRyllB5uBn/GmYda0XK/yu7IFlOo+AgJvDdNUf4?=
 =?us-ascii?Q?Tp879QVSKjN6L4HjSUyUki3kx+8y2+LyaeO7yYyCulMNhC2LSyJ/lqa//jff?=
 =?us-ascii?Q?VP8h+qqDeZzo3MLgLA/uko2fg9roISh17ThtOJgnGk3AVAHdbL/kD+DMqOYz?=
 =?us-ascii?Q?F8004REW3uDom1tCXh2YtCOD4MXlzelIx27nuvKxanFaNqNPuerErwKzGm1f?=
 =?us-ascii?Q?1i447wmNKCmEu3CzSSDNFfLzNh/eJY7JF6dJ1FNc1iGDnVWX1ArsKWz8Sabx?=
 =?us-ascii?Q?/cnvn/4SD+oDBNfgd5gBSXEd2OUXqeN7VSjFMx4agZQWlVcRJj6QZ7OjpIIP?=
 =?us-ascii?Q?yl2g7SFDwV2Pq3Resv43YWk5nEqPgVy+wuf3P83vuIIAjclD6F5pJayDg7kt?=
 =?us-ascii?Q?PM4OMZjqA6ZSCqRP4cAdgaH+UGcDJe3Dpuf0me1Fjxyxep7jl/1pwnc2my6K?=
 =?us-ascii?Q?2CUvXxaM/gcm+H6R9d2/EYvX7gEnWwGdA/cSf7TCbEunJQiyrnGet71K/IT8?=
 =?us-ascii?Q?WLTzYOAMxBYwRCGPcFkcq+UiyaehcOgFd8ID3wp4Yx5WacyHPmdTDX/AEo5t?=
 =?us-ascii?Q?61Z3fkbJKrBuCcEX0bcXAaNpLJ8I6OorWtbWf5NnCig9n2n2yFN+yXX8auXl?=
 =?us-ascii?Q?gndMU6rZgfVoZV/UUftl/eTSDhKRJvxxS+6kIl7+/DEfXP8h12CU/Gad6iRU?=
 =?us-ascii?Q?qwYS6CXjHjg62laQIMS9QKheAOoWNMqY1KDb9Jg7gP8J8pq8WPxypMyXfp7Z?=
 =?us-ascii?Q?x7+0P7BExhR7Gf8nfk7+WTpSIi28xoyz0+z4Xkv3t8kntFmu+wTn+qsbdnMk?=
 =?us-ascii?Q?0menn+ePVzmjOaKDxsaBYi2vAK/uKiNNH626BZr0VcRSvtJh4QDMl3DEIK+3?=
 =?us-ascii?Q?B+nypDx3ItQqC+fqRFLBObNcDTulfnErQElOq3UH0f3XN0PK2OsDDT/VuPI+?=
 =?us-ascii?Q?8tj4C3ncbnU3qHmMQEa/b3J7AIEFoCHLsABUt6pt9zkqUqQnf8rEphNJI+A6?=
 =?us-ascii?Q?YYDmgsayj5HpjGcaT56yQpIR2+fZjyyBF8QfbMMSSDq4h3trxrnCFax7wbFR?=
 =?us-ascii?Q?4Qansynh1veOwxzkRgpER5s5eQnz+2oarhqLXFiuqkrAahFEIIZ7hakchoXJ?=
 =?us-ascii?Q?hkU9M2dVoL7/OzcNpcsn54ldUFr5pheq6bPI0TmrNriMVt/3cujpXsEJCB1R?=
 =?us-ascii?Q?hyHCyQVdYiRfVg2bsu/M7y2Xv24Re+PNW1h1PVV76AF8FefHNNzIWlnUZ+UF?=
 =?us-ascii?Q?f937zG1dD5kPAZW4ubOiuIJkhHwJlvsVA1F0dSd6dDz/EVZdv0X6RF9tbsUt?=
 =?us-ascii?Q?vUFsctSlwhLQtR9rNwNKOAlY1XkbKjTVNUgjLwgzxiBhD0O7p7/GpS0vHJl/?=
 =?us-ascii?Q?gJmVyZymteWim6FC3Jo9cOcwc/+G8hvgPlj6zg9vYOIE7P6RFyBg1x6XbNO8?=
 =?us-ascii?Q?w100CH7JDGbDPrbnKWhaKd/sBoZzuAYhjBqVqlsb++f/XPZ1KZlhcE9bdyog?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4b9a39-08ae-4d1c-c91e-08dce85b4a13
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 12:09:56.3351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wx6i2GF8uKclRQMyQnw8iWGoWYGpZANJLZBIZdzhyaHOtp9cLzACQYWvui1VtKMJ5uZD356R2ijIWznKMo6FNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8945

On Wed, Oct 09, 2024 at 05:03:27PM +0800, Wei Fang wrote:
> When running "xdp-bench tx eno0" to test the XDP_TX feature of ENETC
> on LS1028A, it was found that if the command was re-run multiple times,
> Rx could not receive the frames, and the result of xdo-bench showed

xdp-bench

> that the rx rate was 0.
> 
> root@ls1028ardb:~# ./xdp-bench tx eno0
> Hairpinning (XDP_TX) packets on eno0 (ifindex 3; driver fsl_enetc)
> Summary                      2046 rx/s                  0 err,drop/s
> Summary                         0 rx/s                  0 err,drop/s
> Summary                         0 rx/s                  0 err,drop/s
> Summary                         0 rx/s                  0 err,drop/s
> 
> By observing the Rx PIR and CIR registers, we found that CIR is always
> equal to 0x7FF and PIR is always 0x7FE, which means that the Rx ring
> is full and can no longer accommodate other Rx frames. Therefore, we
> can conclude that the problem is caused by the Rx BD ring not being
> cleaned up.
> 
> Further analysis of the code revealed that the Rx BD ring will only
> be cleaned if the "cleaned_cnt > xdp_tx_in_flight" condition is met.
> Therefore, some debug logs were added to the driver and the current
> values of cleaned_cnt and xdp_tx_in_flight were printed when the Rx
> BD ring was full. The logs are as follows.
> 
> [  178.762419] [XDP TX] >> cleaned_cnt:1728, xdp_tx_in_flight:2140
> [  178.771387] [XDP TX] >> cleaned_cnt:1941, xdp_tx_in_flight:2110
> [  178.776058] [XDP TX] >> cleaned_cnt:1792, xdp_tx_in_flight:2110
> 
> From the results, we can see that the max value of xdp_tx_in_flight
> has reached 2140. However, the size of the Rx BD ring is only 2048.
> This is incredible, so we checked the code again and found that
> xdp_tx_in_flight did not drop to 0 when the bpf program was uninstalled
> and it was not reset when the bfp program was installed again.

Please make it clear that this is more general and it happens whenever
enetc_stop() is called.

> The root cause is that the IRQ is disabled too early in enetc_stop(),
> resulting in enetc_recycle_xdp_tx_buff() not being called, therefore,
> xdp_tx_in_flight is not cleared.

I feel that the problem is not so much the IRQ, as the NAPI (softirq),
really. Under heavy traffic we don't even get that many hardirqs (if any),
but NAPI just reschedules itself because of the budget which constantly
gets exceeded. Please make this also clear in the commit title,
something like "net: enetc: disable NAPI only after TX rings are empty".

I would restate the problem as: "The root cause is that we disable NAPI
too aggressively, without having waited for the pending XDP_TX frames to
be transmitted, and their buffers recycled, so that the xdp_tx_in_flight
counter can naturally drop to zero. Later, enetc_free_tx_ring() does
free those stale, untransmitted XDP_TX packets, but it is not coded up
to also reset the xdp_tx_in_flight counter, hence the manifestation of
the bug."

And then we should have a paragraph that describes the solution as well.
"One option would be to cover this extra condition in enetc_free_tx_ring(),
but now that the ENETC_TX_DOWN exists, we have created a window at the
beginning of enetc_stop() where NAPI can still be scheduled, but any
concurrent enqueue will be blocked. Therefore, we can call enetc_wait_bdrs()
and enetc_disable_tx_bdrs() with NAPI still scheduled, and it is
guaranteed that this will not wait indefinitely, but instead give us an
indication that the pending TX frames have orderly dropped to zero.
Only then should we call napi_disable().

This way, enetc_free_tx_ring() becomes entirely redundant and can be
dropped as part of subsequent cleanup.

The change also refactors enetc_start() so that it looks like the mirror
opposite procedure of enetc_stop()."

I think describing the problem and solution in these terms gives the
reviewers more versed in NAPI a better chance of understanding what is
going on and what we are trying to achieve.

