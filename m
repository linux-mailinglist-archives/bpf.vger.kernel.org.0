Return-Path: <bpf+bounces-40420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F261988742
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 16:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3220B21057
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 14:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1861115443B;
	Fri, 27 Sep 2024 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GKRGOVlc"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011052.outbound.protection.outlook.com [52.101.70.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFEC1865E8;
	Fri, 27 Sep 2024 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727447890; cv=fail; b=PyLTGlVHA2MlvdcGUMWalI0OAdbMt3PbqJ0GHAmG7fYVhGGG5Tiysf8Cz05ABLCnWTzv5QD+TPIRnhcwLnQC3ND7StPvLm+2EE+4GtRCYaMICZTazfNwRkphSoKUVeu21x1XYMJe9C1OmjOy/BbxTquZaL/seTAiyxMSdCXhj+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727447890; c=relaxed/simple;
	bh=gFzHzZz//jFle7gUEcktlFMa90UyQIb7usFyU3uI7TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TlKdfRh+GU2aNy09xfSgMbzgNkCvyhYyUVzR/FN2mMQIc9QuVNG8quzXcJbjgh+iBUsNhDGUw+iNr8VNCWAtmfzm+BlqcWl97GlJoSvyWNrabWSaJMZ/bBPcxwoFGedVpHCx5QXt4kc+Lv5THrqknVjtaOjY0R4qE0jnrPY4EDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GKRGOVlc; arc=fail smtp.client-ip=52.101.70.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1FDoatlNynhKUr776StuUKVsaSGDIWdNtKPpA/v33B1oSTBUt4hE9moPyl2QfrqLiGfz9rDq84rVvja+puherT2nRZfbgaq4YTBuxLPYs8RxzjxIgHqpeepKmfusS1Y0Sq7rjLuvJwF4jMTqv/m8l5NPhI4UiS+oO/802BI6DXiutF/tnNAyzfiG0dgxhrpydsmqF0YgcW7lqTYfVZGq42ZXiiYS0bu4Y0Q2GW/TDFuhooHLvHZ46h04JjHMkoQZ4yy4Um+GV2WeIGLYPihbB+/u8IwuD4bcnOAPgmg0Jw82FZzxa3EtJpIKtADt1i3dStlqIeocsh7YVz9CyPZzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlROcESkZxBaFmG3CgsXlyKtdNMhKlo/UqMYU+cADDI=;
 b=sbK7vAe0XT4VwlR2lzqpKceP7vv9K7EAmL1UKH699B6Ob9Ok7zatiPXXl1AC4kBSpNthH0ORofjYeQmJDSOC7LM2NFmV0BLfEsJ+onPQMrZiSwynI+dEVnUMVhii82jetD9sCLDVhkGMcc0WCf3hCKwyLPlPlLEY9CuimsfH0QHOID7GVmyvS4UYmJOr0Cs8PSFBwn5haix/lQb5BwAwmLpXT+zm3BNI5FHpskOHJPbT3o1YQi9JevF8yQuyTnmsuGKfc/7e+WwIE1RVOKNlcjoe116FlgeWWxJ4lVLjGD3ol+O8tFCA8RUJpwbDbjfFFSWIBoBJXdiFMHnuhqMW+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlROcESkZxBaFmG3CgsXlyKtdNMhKlo/UqMYU+cADDI=;
 b=GKRGOVlcl7v7fI1IZt2Qrur9V9zsBey9jMYQ/4bWdQY/SOE85ZJgQMyrFSZC2QYzoUg83vLeuXdP26dNN3laDjDcV+DWqeHprBuEGlWY9Mo6F4y5X9zHFbPhfyv13n+D/aJVGWy1+6R42/TKc2/tNi3LHZBJr6AmJlAx54Go1/IbwSWJucQW4jB/usi9QVO0aSYcCCxyQPLS2k/dEiV9tKLZoPy6gXSJQmVybScm5tSU8KKkhpGEBUucrJWo7+xypWpa1Thhtlam4j2yjeo5ynQh1cUREtSaGesYtvwQt+i3fkY0qG3xaozWaj3aoa4UVFkplQyn60jFD07cRKe1xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAXPR04MB9137.eurprd04.prod.outlook.com (2603:10a6:102:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 27 Sep
 2024 14:38:06 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 14:38:06 +0000
Date: Fri, 27 Sep 2024 17:38:02 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, claudiu.manoil@nxp.com, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net 3/3] net: enetc: reset xdp_tx_in_flight when updating
 bpf program
Message-ID: <20240927143802.5a3amagpwczq5l7u@skbuf>
References: <20240919084104.661180-1-wei.fang@nxp.com>
 <20240919084104.661180-4-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919084104.661180-4-wei.fang@nxp.com>
X-ClientProxiedBy: BE1P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:89::16) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAXPR04MB9137:EE_
X-MS-Office365-Filtering-Correlation-Id: 4680e870-c083-4fd2-3c8f-08dcdf01ffd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JdIk8MCyrJkGP/3LGHtKUBkyDT09v/PRFp+2w5FY0Ud9QzfYb+e/ZLwsPmrf?=
 =?us-ascii?Q?z6CG+C0a9RXmj3BjQ+fagyFgw2Zod/uuBZwuAnas9ghtrC5VBJY2QiQs3ArQ?=
 =?us-ascii?Q?Z7OyTQoVcj+tywA9LqMCDOZqg428OeupkZt7ove1ybgvV08+k7K36N/AUU8f?=
 =?us-ascii?Q?xlNs0CMfz9XJN79wktM1wxFfZ19Mstg8XHsg14MlmSLXY4XrrKLzh2ilcn35?=
 =?us-ascii?Q?jmhpBMlKKT1qcbU2q/LeEbEOELo2b/GG0lzRFIwaNbRScviQsDWvAlHSPoIU?=
 =?us-ascii?Q?NF2gPD+kTd6kAtpskNZhGQCcpe0cxniNowxhn4Z62eQSTHNJ+epgrJO2hqOV?=
 =?us-ascii?Q?uZazFkPNTe2/1ICeQzGmIqYvBnqD75hLWzuvIoO9OoV4yVD6SBEnzNK6BQMY?=
 =?us-ascii?Q?E06sDEh3i+4PTTOuuuxt15gMLvxdciv6EIvgeUAkLVX41VssMSyc2Dwq0Moo?=
 =?us-ascii?Q?HkqXdR/+SVxnxGURVoynb7IkfF1QJLqsmCsZwrWxkdKtRlSrU1DZuERmfzZ0?=
 =?us-ascii?Q?jyKZg4i5bqF1Mp/UD8/Q4q5N4f4ak7hziw7ldcOKrD1SmaODQ3A5rxPxcaG4?=
 =?us-ascii?Q?GpGpuZMudTvrfU02sxZUwjVM6d98z79SeCLNw15l28FDormF+ftn0XoxlYiG?=
 =?us-ascii?Q?KVMt69wyl2g8/WlQahbpenSdlKs37QN7OsxspldGLFHxks4Q1Tr0TebQOu4H?=
 =?us-ascii?Q?e53aUW4EG5WU2feRF5m+3TnnMqh1jzeNm5NBhKMWfD8ca2mB1rBFulFtOShi?=
 =?us-ascii?Q?kAYwWJUG7RwMEu1MktOJI/s6ebbPzyX2U/rJavChJ/AcqTWV2zmQJpDm9Yr0?=
 =?us-ascii?Q?UXg9+z7ht1GFIy0GM/DCKdR5ihOdWM/a7/53fNc/Z2R9LYaPRFgP1g/UGV8z?=
 =?us-ascii?Q?RdY0U/lpxMk2/Za9hVXFpWHCv3tY4k7n/iYPxnlWL6TJfZ+UZm458rDi+7aY?=
 =?us-ascii?Q?z4YxRl/GTowcyRyX7ofbFufq577RnecfOjs40BhiB3PeAVwLg0TjmS/4va/f?=
 =?us-ascii?Q?L/oMeSbEeTvimh6z3w+SJhLrPhbEWqoG0Mnv363KaQfcFFXo7ZN7qcCyuICT?=
 =?us-ascii?Q?qsivSwCVU5X2YrvfYtzw338PSUfAlDQabvNO8Tey5JLsXRcEEh1CMQ5ZNwTb?=
 =?us-ascii?Q?YpMFWzh+R7yzLofBaEH5Vq+hdw9lkdDbmFxfTVF+91lQk6PY21m1gOKjScLW?=
 =?us-ascii?Q?2cdxLUx/c5c25F0dDlu8mloBdwexFAnd5N7mF4l/WV0GYmZDL9n3DAPl2ZYk?=
 =?us-ascii?Q?KtnVqYkhCNZuPVsfi5DjYEByNoDDWLm8duue3hQzxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T2AKuNmA2M6qkAz3QrL6f8zUVpmcXrFUqrSlZ0/eJbd8LKli3PxyPh0bpOGj?=
 =?us-ascii?Q?5ZPZXO9Lxp/FFFsibgF1sLuv+/eMcbvYrdqyss/JVbmO3qqVjMvPAE9GAjXb?=
 =?us-ascii?Q?k923V+Sunmq97huH3hcgimDSgJ6ZFYbkro/rqLT2BrLTc0ptwTQDx4Mde7uq?=
 =?us-ascii?Q?5IZSAZ+z07VXvC/89ILu2b3U+qyE4uZDgq7GXy+gCVoxxTwHsg0DjPWhdOdT?=
 =?us-ascii?Q?YgPWBTCkm/+XxvVtq22n+8gVdGJKKtfwTMolqtMwEK4qe/CipnDpHHLPfbwL?=
 =?us-ascii?Q?wNNAyn7ioK/h7O5UVnRfeZBj4xEXriOdicW9duGh0ublw2jCFFCe4zgp4KAf?=
 =?us-ascii?Q?Dddm/DnaOKbZtAgfOUGTS9sTu1FK9UcGuKm7bLryI4ayXZwz8jQApub76y2z?=
 =?us-ascii?Q?0Qxon6Cl1c2/cPxKWJYNmaFqIQqs9s5dHFIgGG60AXv4d1MxkprrM0A8xVUs?=
 =?us-ascii?Q?AvKgMuGuzN3LswZrTm0wiShMve0lP24dLyPjB9wWUJQoY8B+3qqAbwxP6n0V?=
 =?us-ascii?Q?lFh54PGJUCvWDqXQJt7tb73Mt3JJRXlT1RtY+1SH7bpAOknZtaq6t1jCUM+g?=
 =?us-ascii?Q?wypXWGEFHuuxujN0mcvvxRkSHVMVZWPT1Xt5OH9APlOMpDdDsPHFUFMCn6KP?=
 =?us-ascii?Q?QeUpbeeUdC45/4krNwOmob+AhhAmlkxn6pO9P/q06fY4Fm2SO+yvwFFxT6tJ?=
 =?us-ascii?Q?1Q5UlCTA7FSrhdwFpmOPIiWP9YN0Qf9YAHDAlD3QzwNPxyKoJ8QxxsaGwtRd?=
 =?us-ascii?Q?X3Q3kmMed4D2esVt2cYVTwWI0t6NdaE8KHkDbZYFLjRQlTm4757fmlKKu9cC?=
 =?us-ascii?Q?Cs0b3WEmr1cLUgaN3Xmb6IVfZ4hpXr+nlUv5Y7ZUS/eXZq97OuZZfYkpHERD?=
 =?us-ascii?Q?uplUh8XrkfrfdmE4eNs7HJr8p2yxLSNO3TTifsW6LsEf3eaztCxfaI8bRDwK?=
 =?us-ascii?Q?yDAtp35+rXHkBz53/NiHDUqqtomIE+IjYplpNluSvOPKb9Z0PTrM34dFEPWD?=
 =?us-ascii?Q?bRBHDxu1oQ4J385lDUpxa/D7DH5ZTr+vMCsAjaB0FR1gI++/jUbYVQqdJDD9?=
 =?us-ascii?Q?EPVG2Q9I4TZjyuurmlulf4lfAwkAVeijCAjYlXL4thAeIWxw0O+KoeKaayG4?=
 =?us-ascii?Q?63Ty2ginxxjo4Qnqqu1nqdZVouALhYzoWIq2S8q6xyN31w6a7+HuSEiUpyvN?=
 =?us-ascii?Q?tntTx6MSgDxmrcthp4wpw2wEoiHaINoRXrQQ3kt5oBPZBFLv7S02e/HexR9z?=
 =?us-ascii?Q?SBk+NDLbU/dPGwh/+jxij79aenD/axtebX5LPUTBcH3CtDHKvBJo9ZOVifPB?=
 =?us-ascii?Q?aGphCmpaQP4xDlDgMGsITgc2dScMa5lRJHrtGneAHoR/ILQO5SbmBQTaqHAT?=
 =?us-ascii?Q?4deDXw6gNpHoAsf8AUd6LmgJ54leqzYg1QjEbuxr7Aod03VMXJbTqy241d8p?=
 =?us-ascii?Q?VCEG95g8RhpUvCC6P5bSCTuWQ65ZMbLB0Dxk7mX8YZrv5D3mwQmUTwN/sZNz?=
 =?us-ascii?Q?y4yTUhcjdkk2p8UbiE1SBrwMiqv4uhuVNlaENbdTJIrhsx7mOmWZDxhMdB/C?=
 =?us-ascii?Q?2JsZGmy4E3eFieSgDL20OdhGorrOdql3Tp47Gs0hZCm90SNaYRSkQqo3q4KT?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4680e870-c083-4fd2-3c8f-08dcdf01ffd6
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 14:38:06.1559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEmiSZxx68D9BcNMhTCNFiC2RzdzSaMBMNIFQdNhNeaOzJK7kHWIB4TfVISseAYVUmgO4ArxN2sSemZHApS/IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9137

On Thu, Sep 19, 2024 at 04:41:04PM +0800, Wei Fang wrote:
> When running "xdp-bench tx eno0" to test the XDP_TX feature of ENETC
> on LS1028A, it was found that if the command was re-run multiple times,
> Rx could not receive the frames, and the result of xdo-bench showed
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
> is full and can no longer accommodate other Rx frames. Therefore, it
> is obvious that the RX BD ring has not been cleaned up.

I wouldn't call "obvious" something that you had to go and put debug
prints for. There's nothing obvious about the manifestation of the issue.

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
> From the results, we can see that the maximum value of xdp_tx_in_flight
> has reached 2140. However, the size of the Rx BD ring is only 2048. This
> is incredible, so checked the code again and found that the driver did
> not reset xdp_tx_in_flight when installing or uninstalling bpf program,
> resulting in xdp_tx_in_flight still retaining the value after the last
> command was run.

When you resubmit, please be careful to readjust the commit message to
the new patch. Especially this paragraph, but also the title.

> 
> Fixes: c33bfaf91c4c ("net: enetc: set up XDP program under enetc_reconfigure()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

