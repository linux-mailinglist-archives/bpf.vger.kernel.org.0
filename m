Return-Path: <bpf+bounces-40617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A063298AF9C
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 00:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610F528172D
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 22:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8991885B3;
	Mon, 30 Sep 2024 22:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rrwea0qp"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF2C183CCA;
	Mon, 30 Sep 2024 22:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727733777; cv=fail; b=OfdLWmGyfOn0w5Re2TVOY0xhSsBc+dNGWtyQBhYX5DsqYlrJmbUU7YmifmUgaC/n32S1+a7Jo23kYtfsEYLXAGR+Qpr1dIT0WmfJfFAhpZPs4kGIj1T9lyqcDtA7haz5ubw4kCmPaNmGukd1mJEUYhHIK4MrCQfoOjcawQuC72w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727733777; c=relaxed/simple;
	bh=a8DVMBAXZ3OLUQNifntCi2WrQeNcUmhNS0WM2Y/HH/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Acclzpaq1tEmgQNBrYyNZaIrJmLg/lNKGXQi4lbY0Ic4z3U10L0od7SDJX+u8ns5S5QLVRX6y+PxQ1txKTjWfYAjK/itz7n6d6gJnuLI7XIYnt7he5tZ3ueuVldcHCV49jgczhu5nhnmIEkTSrRDkY4msmpHpY0ZTGGrhhwmpcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rrwea0qp; arc=fail smtp.client-ip=40.107.22.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5i6r4dQytUzwDDGo3AgRA+oVzFD0CWbGfvJNyyObz2Bb4xkrF8gMffIrclprUMByao2amCxcdbQIZLaevagL8gcYkQHdpwmvPi3fXMBpOJJFR9R/wHtSlVwC9eyMaYv/YdlOzg0uhCIIpjCIKibgDjMe95UJqtXjR61u/4pfgzbiwj6uznAKClm5/PSaQtvlVI+oeu8lTT0xIcAdQVTihy7+f5k2Cbz4VrBtpMjTiPmsMTqVTkkRSnsxDO05tTy2MOKILFHPIpDfeGb58soW0FOS9VdQkee05IC+MbJY+fMthbDK/9/cG+u2XcMRCFMkb5sEO9bfy2/+EY8wb1AjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7s+VyxhggzgkLzsPGWCpiqTbSJ+Ug7FKeY4haW+IWfs=;
 b=hG/+swJPGthCwDxt7AvNvJ8ku28OER0V4MHoonz9Wf6Lk30s3DO4Jvw5USJy/gKP4pqbr+08E6IdOmQzOyJOPlfxEK0U+Sr7NLbC1s0U/tSy2Pbr9RTHtM7Cdr/nUh25QlPjiaqFi9mLPTyy0mf98eQ5Dz4J2npXzjDTNt3y2W/XZqmsrOAViDzgdSkdH+kQ9Z2bbfq/mk8l+ROqpwM39VxdyzoFoxOQSS8fiTQY5l3UOTgaroXb0HIFVYAUQO22n8T5D4WfV5qkhSIdFxjc7cUmxXsB/GNd+uemCSWBof7TFiF0V73fxTsqo2Cc1FbiOLRBS8ttCEb/i/h5E9FjQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7s+VyxhggzgkLzsPGWCpiqTbSJ+Ug7FKeY4haW+IWfs=;
 b=Rrwea0qpodtPZfEUmJA6uJqS2MpT8VCOC9+La9A6SBQ5RWDoZKaWP0uwQ7aiFmnDT7Wgwiu3XwRf0Y+kziROyGZS3rGYpiepaYu6H2rttzFxT+viLL7k7GKRYbOXzu9mTcd4Fvxv2gI8GxZXqSWnQm/star7Sqy4jAgXAxCfw2mCl3qjWOBSg2VUHZPK1PoJcJ8hxlqz1d0azBp8uhsLVKy9hqv2fT6BoLd0hr9ztsRQ8OL4QaC1Qishn7n5F/nY+oZ+qlZbycJX2Au5jQOc4vlDRjriw0CYVAgwYRdXY2Y9TwNwb+FXwAmgrTCgfGyqeRMLgllg3gi49Hk+3CUzrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB7523.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 22:02:53 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.033; Mon, 30 Sep 2024
 22:02:52 +0000
Date: Tue, 1 Oct 2024 01:02:49 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, claudiu.manoil@nxp.com, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org, imx@lists.linux.dev,
	rkannoth@marvell.com, maciej.fijalkowski@intel.com,
	sbhatta@marvell.com
Subject: Re: [PATCH v2 net 3/3] net: enetc: disable IRQ after Rx and Tx BD
 rings are disabled
Message-ID: <20240930220249.dio23fh7mqw4pojn@skbuf>
References: <20240929024506.1527828-1-wei.fang@nxp.com>
 <20240929024506.1527828-4-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929024506.1527828-4-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR07CA0155.eurprd07.prod.outlook.com
 (2603:10a6:802:16::42) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: 4823c819-b0b0-444c-8e9a-08dce19ba151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CV7SjNzUbZeMSV+0inxkNWCozBQulIcawv5yvcrhuqvpPSKHT7IddOHypaXH?=
 =?us-ascii?Q?ncfxLR4lel0dq9t8O2KXS91DQrlCm5DN8ywdszVaCXQT0+sjhHzJ/oxQwSVT?=
 =?us-ascii?Q?XbBF1SPR2wRLgxpfa+pKxNn2Ly+ZnjLeUQazeFgSn2bE70rRNlMlav/9gOLi?=
 =?us-ascii?Q?0FXFCSsGnBXEE9WUmpm2ul7tKTLa73ofi616V5QHIZqWlDs5kCLsid7MdgRe?=
 =?us-ascii?Q?OGtRC33lqzk4aTvrlSMvuPhFx2l5opZTLwI9soPtjqJJMhCpJbiFsFLpN7jc?=
 =?us-ascii?Q?tndF4dIHwLn4qkL6vApy3tZNNnxTKDKg5lkgK25d7O1YY2Pqrpsw1eFpnIWL?=
 =?us-ascii?Q?KEHZ4UGjy2S0jTuEzyZpR2pJB3iG0ldkp945e7weKFKBkOS9Zhwhzoz5vk3p?=
 =?us-ascii?Q?XQcYbM8szDSNRuA1Inwmazv4pA9fmgA0sDCldSrZPZ1a81pnIGJBcxyNu5/v?=
 =?us-ascii?Q?NCMptD+ZVEdAiRYpZJu3JxhIG2ejDJOJRfOari/6DU8DtftSpChqcd46pHPq?=
 =?us-ascii?Q?89mZmRF+M5YcfN12jP/3eQ0zBA4nGAaYc/xVK+lWlaAuQA48yZJMJ60u8iNB?=
 =?us-ascii?Q?4dL/TUdWurRh5jIlbkzaqe/Gia5Jk0Y2cY5uw6ulaJDhnfTIUERnXAKkfvIo?=
 =?us-ascii?Q?2kErkvAt/v2Jpk1KBnnrWN8S4P6+udS4Bu6Anp/IVCNHFPLwERiJV8/jR0AC?=
 =?us-ascii?Q?C/tSbeJ7o5OjrFzLnHAbjczXQO0k5NTPOeR71b8x3zOFN7Yvd7ATi7cIUTrQ?=
 =?us-ascii?Q?O8xm4TnE3y6/19goZvWAeabohmkUvgiW0H7rKa8kw977MUFhKBJXRkExTKYp?=
 =?us-ascii?Q?KBJtOxjcw5cAtFlxBvO89JUYPg+X5/YpGB8xb3dYqONHHVf3WS7xnvP5B1La?=
 =?us-ascii?Q?Y8MA3/7gIJncieaPw5eOPrdXooEljlQrIm5ey0fzeCvD0g3xeYVI1H6Umwkr?=
 =?us-ascii?Q?kdtvKd40k4Gah2ZRBcGTCOUO+wcWKob/ke1HcMt9diUJxCzn1rr+ufChtQce?=
 =?us-ascii?Q?r79xpbfjKW2MCEbBu8ddzy1eVK35fWU1m2Q+S4ynhR1SfcJ89DWh7hTAbv+l?=
 =?us-ascii?Q?lByCTa/oVNUK4c2lrihHb1fyr4Q6UcZ3Mrox0KRTkmz4IKiirMCLjOxXLfd8?=
 =?us-ascii?Q?qcRE30FNOjPDxMzNQmp28jUE4+C+ZIxvnY/EEtOn80HUdYET0h9r8/1tLhoQ?=
 =?us-ascii?Q?mhc2Ok7TflUzusUOv9gTuVaHw1HegVq7u3lWOyzHJFZgDEnW4c4GuylylqMs?=
 =?us-ascii?Q?jBYVdciaMZ4arjtCSCGlqmu3erertyU8pI+ZrrhA5T2CuUQlMiJw44meempG?=
 =?us-ascii?Q?ij4ClHjUSpmb8VYW1SnTFWjxdpXLbqp3Xcjm7LeNLTm+Jw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kjMAp1Cvvm3TG6lTmbNIp5uiF/m5EFeJ3gzja07O5toov9Nud7XbXQzeNuU4?=
 =?us-ascii?Q?MMnxOSRbLOt7IIcBa0b2QDv8Fi9mIry+bIPxI4h2SQfrHNR43mCRzb6F+sfj?=
 =?us-ascii?Q?m4Xvgtzfr/yU2rFP1NEI+YVK+ZLKH4ya8VOrQaRRDU3rR8KwaJrqZuqnBEOx?=
 =?us-ascii?Q?b7/uYtC3uaqjPZ4mGzVlxLLFKUhDh0NJlboFDGzkkBesx3Ev3tVcIGPH/oBr?=
 =?us-ascii?Q?cMF5aYFpnfS/O7ptYpZ8T0SNxLJb7PqPCr29DSn1siEl0gujKiQixMP79bLR?=
 =?us-ascii?Q?TQDvV+j9VmMwR4kO8r/m0o79xRfcWm/0WQf5BHqZtRZnFcZSN4n6zPvgwpvr?=
 =?us-ascii?Q?Y2bYiFYBPuC+lNbHBre2sLzjwDFs/OGlucwBKQnokZxJKtsivlc8CfgRrxxR?=
 =?us-ascii?Q?iqK0K7CRQgzAQP1BPjRPmbPSHBBGnZBNR3TS8oikAr+cDzkbC1P5J9schSCj?=
 =?us-ascii?Q?NRmS4p5YK38QNztTL1heW6qrPxSMidz943yADEXil+WjguTaUkmFe3/KvuaS?=
 =?us-ascii?Q?Lo9mMs+d8yPOcbVa5/0lxAV5n/WZFoIVtKEO0rFf8DeWRw8057t6r9UkiMbv?=
 =?us-ascii?Q?KTtny8Xwrcac2JDbIb0IFrBbFIW6tyxK2zQy+LtxrjJHM+SP2ojt6yws0otF?=
 =?us-ascii?Q?Dz50cbi5vX06pKUWoOq+YZLp9yXY1/bxod7Nccs0M18BrnfgFND6LNX7OJTU?=
 =?us-ascii?Q?xS3kpxYjbZkBZ5GcD847cARYfEd5hEgSkqCQzC2xL3fIeoqQusWt1xLh+sE3?=
 =?us-ascii?Q?E56cOiTaiiPxaW6Bjip6Rt337uXuPVMbOMGAn3awA/o5M1nvyl0QKt5g1fLe?=
 =?us-ascii?Q?YFdND3koStpYGmVwAG12kdOYhRs4iIS8aLvtKN5ObK29di7POE2FgNM7cL7l?=
 =?us-ascii?Q?UD3uCeUY+s7BSEEyNKHP3EI7PrWpmiq0jhgBfTcdPUytVVIbEi5nJK8mvL0f?=
 =?us-ascii?Q?Unlt0ZXuWSfazoJXWWZVck/86s748FSbqRasUhu4H/h/NnWH9/KhCkELJzzo?=
 =?us-ascii?Q?v3yQeuAk9bZxN0V+BGHSBp5h1k6zLLLoRJKsgRMfOREKUDpAGNzS6P3qGgSs?=
 =?us-ascii?Q?H43RJzEhh7qqy/bbxlYdhAF+IoMTL3UbTH9jw3sdw8wMkPGo7CL/G0NsIeqA?=
 =?us-ascii?Q?vsF5ym+sx8K/rzz8b+Pr7sqhVXtsr3MjLd8PSPkvuhI0ygx1q6wJOq/M3P0E?=
 =?us-ascii?Q?TEjQ9uH1TE5RtMtgEJLtBTQG08g7jNEEnWVo2N5tewwqDrNPonyoKpJ6rmQt?=
 =?us-ascii?Q?XIVLaceCwVCke9qgpibpbkS60EB1vufjfFVNT0ddder/1oRKjhoNPAIhXHUA?=
 =?us-ascii?Q?zHmUB05AcKMgTVxUTCChisALgSPHXzkUSCHs+0ElSgZgoOuVTzGHQgf72XqC?=
 =?us-ascii?Q?dv4lG7hGFFRFys2v18Ky/iQVUguwOR89/ZXcwH9ZukkBUHoFI5soIBg8fhvI?=
 =?us-ascii?Q?yjZdZhAnqC8eTVKhz6LsBdhjsYF4G5CRNO9F5TEF3zSiIc/sxzReZivjyfb4?=
 =?us-ascii?Q?+BQQ9bDzK9RVEpPep+6KDU+ZNO+DXT8InjJ6OWHWqwyGvlcp7kYML5XWvVMH?=
 =?us-ascii?Q?3nd0oU/upBWd3pW/VAQ3ZG1JdyFXFePlQA8EB2odNQXUm8ZxfDLqslTNKYTU?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4823c819-b0b0-444c-8e9a-08dce19ba151
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 22:02:52.8887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlKgf9OXeJfMPlelUzgkmuv7Nj+KkOcCViCbV2IBzXxz2TDopgQeFnFQJBDndRG2cvruSyXsLXtYyw/5UBOJ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7523

On Sun, Sep 29, 2024 at 10:45:06AM +0800, Wei Fang wrote:
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
> and it was not reset when the bfp program was installed again. The
> root cause is that the IRQ is disabled too early in enetc_stop(),
> resulting in enetc_recycle_xdp_tx_buff() not being called, therefore,
> xdp_tx_in_flight is not cleared.
> 
> Fixes: ff58fda09096 ("net: enetc: prioritize ability to go down over packet processing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2 changes:
> 1. Modify the titile and rephrase the commit meesage.
> 2. Use the new solution as described in the title
> ---

I gave this another test under a bit different set of circumstances this time,
and I'm confident that there are still problems, which I haven't identified
though (yet).

With 64 byte frames at 2.5 Gbps, I see this going on:

$ xdp-bench tx eno0 &
$ while :; do taskset $((1 << 0)) hwstamp_ctl -i eno0 -r 1 && sleep 1 && taskset $((1 << 0)) hwstamp_ctl -i eno0 -r 0 && sleep 1; done
current settings:
tx_type 0
rx_filter 0
new settings:
tx_type 0
rx_filter 1
Summary                 1,556,952 rx/s                  0 err,drop/s
Summary                         0 rx/s                  0 err,drop/s
Summary                         0 rx/s                  0 err,drop/s
current settings:
tx_type 0
rx_filter 1
Summary                         0 rx/s                  0 err,drop/s
[  883.780346] fsl_enetc 0000:00:00.0 eno0: timeout for tx ring #6 clear (its RX ring has 2072 XDP_TX frames in flight)
new settings:
tx_type 0
rx_filter 0
Summary                     1,027 rx/s                  0 err,drop/s
current settings:
tx_type 0
rx_filter 0
Summary                         0 rx/s                  0 err,drop/s

which looks like the symptoms that the patch tries to solve.

My previous testing was with 390 byte frames, and this did not happen.

Please do not merge this.

