Return-Path: <bpf+bounces-53898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4058A5E0EB
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 16:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E9E1749A8
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 15:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7518E255E3D;
	Wed, 12 Mar 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nWFtKNck"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28281242935;
	Wed, 12 Mar 2025 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794477; cv=fail; b=N9vczHplzRTxXH6PmsYNjI4XqGCh7JQeps2ALrUEt/ErZ+oR3qrOChkOCVWiVO7D9q8etd+kidzt2KKndZYuWCfIs+qL+ZuuKKZnD+PBKJP5mGs9LK1YD6/kcXRuNVtEILWiTi21JqxIz/nm6tnpdvWGAZJSAt5MWQZBl+tPpWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794477; c=relaxed/simple;
	bh=LDXCfbzY7mfxWNRJVTpVM5/yTpfEffCYRRYWO16+wIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LRU3pIypu0Ixp0JJOUaaeRb2AYN11Peb7deVM0noNehmeBmjVmFI6FAaEzUNAhR/sJf9AvBDSE1aVXEE+cPz+4E5dbOGrIPTEBSmVbyk6LKrqddGt704AveHXhwbPGvWmVDLKnBevWVTpaUnIpS1/izoviq73inb/NbUobZXMnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nWFtKNck; arc=fail smtp.client-ip=40.107.20.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rgb+83vo1ncPAquFc1TPV3Ozb+aEbMyQdFdwjzm/qnz7pGcYiMQdAtvZq3+zDdKpV8P0s85WmYv83Lb/8MbNWNWoo+V9eoG1IqQNWM56/Ok2qtMCoOUuj2rgZL31tJ1C+DQ1VG3M4sI2Cfa9cVPvOjCFe6QUVeyW0dUl3R7Ja0ctXKxXOB4d2eCL1nS/IiKMl51B2abJUeM2NCrVvr3IMuAUkTQ9oUUXUGbggqpNhftmgdqv62qEQMZsP2fk+bPs/eeE2NNmGElGiYN2CeLo0iB7d5O6BpdCj3eTm2yPB72nhyuuEeUmuBEpcISeSw5Vldn8LcPCFXKt7XoF8sKxBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=im8N5r+WWAgyKmkK0jk3wDHs5GYx+GWcOc6WQp9CQrE=;
 b=VYvhC/LY5qfFlC/hv8t0PUe3kSgSGlbXtxMUVxin2EvEB+Qzb8Mx0lHZeAH2xzkk9YZXbLp09xrU+tNHRQuZzLd6GpE9idzML1tvFoekS+sUlobVBpGuMaKBeFhOivfzgUBE0aVUtKoEO5T2xOpUwXcp7qZzZ29/B5NCcHvMBnum3Qa2/hs5ETLyuKNCqA4WrfaSbPPpSHCMfLCTnH64wRK1pmHq5sao0kvY2JoOjqCrUzkN+WVblR1n1hxJ42W2eDfL0Z01F5FNtleogOHnWXvMVcbMgNSUAD24MYJH6AnijaUxt+lgEgffYXilM7qR0nxy50ZiOqY19Lp7rcVjPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=im8N5r+WWAgyKmkK0jk3wDHs5GYx+GWcOc6WQp9CQrE=;
 b=nWFtKNckHJW0b1F4DBW2OJQ670Jbb/UiHA6JesQyXbwc4yHSBMSDR7FQxW3+j+bVV13FIf4sw/BrZaosYjDeK5ryxdOwTK9KrgnMmR105zkxc490M+kONhmjMCSr3R5HuEPlwDCb5bpnudCrgXoeJ6oazUU87PwRTJXPEIjf8HCcEi4WqQnXaFE1BYl2aUbG2etqV+UUexn1axFS/9c1B28QXXInyk73Xc8CUD3V1qJwVhcEySfOeOAbucsO13xznlI8rBBZaJOkKwQ/4dT133xeN+2zatCv6sLTU9LGxJeH8pgziXBW203FvcZlEfHvdihLtM6D9M8iFd4ftxEZBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM7PR04MB7142.eurprd04.prod.outlook.com (2603:10a6:20b:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 15:47:49 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 15:47:49 +0000
Date: Wed, 12 Mar 2025 17:47:44 +0200
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
Subject: Re: [PATCH iwl-next v9 06/14] igc: use FIELD_PREP and GENMASK for
 existing TX packet buffer size
Message-ID: <20250312154744.rfcq4prjj5tyrflx@skbuf>
References: <20250309104648.3895551-1-faizal.abdul.rahim@linux.intel.com>
 <20250309104648.3895551-1-faizal.abdul.rahim@linux.intel.com>
 <20250309104648.3895551-7-faizal.abdul.rahim@linux.intel.com>
 <20250309104648.3895551-7-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309104648.3895551-7-faizal.abdul.rahim@linux.intel.com>
 <20250309104648.3895551-7-faizal.abdul.rahim@linux.intel.com>
X-ClientProxiedBy: VI1PR03CA0067.eurprd03.prod.outlook.com
 (2603:10a6:803:50::38) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM7PR04MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 657a9c20-9676-4971-3ef0-08dd617d3d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qKPV8KYcatuX7kFxk+eZEuuRocf0k/hKKtBh6OmzVWzB7Cs80COuZkt/HXdF?=
 =?us-ascii?Q?TK3CWRZW8B+z153TwNGqPZrlRkh0yrhD+DXgIkFrhYRVl7IBGvsGSS3GrO5D?=
 =?us-ascii?Q?mz1kX7VbEWBwJRExaL/C9oKA2Cz29a6Hs6p8o8j/FyJxqO2BjTUivkL2zVo7?=
 =?us-ascii?Q?1s4K8HDVNnwIG4GVMS9TIsMa9sF0sxkyG8mN5q0sBZ14uyjRAm7fwXIkAj4a?=
 =?us-ascii?Q?lPy8oJFxnfcwfL4Ti2EO8oX7eqM5Vj2lY++4CuzMbix0L/65V1o9LRQbLV12?=
 =?us-ascii?Q?PH2i1XGY6rdJRalnPwfD+voigFxVwTTkY1Q8Kxxo2Lwe+5uYetpUlilBs8Uh?=
 =?us-ascii?Q?l9xbr06M+0bwP9KVpUcEYDYIy1Qkrzkgq4mz955OGoNiVKqtRiNYPdFf7Ixu?=
 =?us-ascii?Q?xmStNWOihbN82dqlARzhwv1Fn28z221NV/+HPUDx8ovLJbkWkhJ2aZ/8vVjL?=
 =?us-ascii?Q?onSnukjZjbr6iOISrok4JEWlgeTtPp6fp7ibVH9PJv6qROqS8htjQGdp1rfd?=
 =?us-ascii?Q?KxXAOq/yXBCluQvNY4NLNb37+ZUDfmKvkCRsHcvcbcFiRKxdhUgPMHjtj9qm?=
 =?us-ascii?Q?0U4a06wSyx4nAAaB2MoxCfMwEgm27Yj5wAIixP1T9NaJrrMIL1c/X4OJGBIW?=
 =?us-ascii?Q?h6exv1Lj8FxirsXgcSooZG/USTcq9sb190g61WSP9z9VyXFUzMpgUeTIXT1p?=
 =?us-ascii?Q?08eAmvU8nkUVvVxxWh1yup3z/ZOOCRDSvlNbUUk2JfTY7/PTMm0kqg95xpmY?=
 =?us-ascii?Q?nyyok9T/wAtY7oraBmZ18LUGPNOTDBDe0oE0ppoCsNClg21ZgyfEIqpKm473?=
 =?us-ascii?Q?j3BmLj/k1+jI3DR+93BHEiF2iYbsR10pdVrIbglfcJnNUdfG5XYiiLjwViUJ?=
 =?us-ascii?Q?2Hdw7YlnTOSIU9M2OSeoDo0VTTewvTXOIkY/JZOE83hXRM6COLO4YkkbIIiG?=
 =?us-ascii?Q?iY3GeGCEj8gG73WQvW/EYFEG9fQKEMqoRmB2A3K6FWsQqZa+G4tNldRnlqlE?=
 =?us-ascii?Q?hekW5DOUdBUR2r/zI4AzLehbyGnSdlANz2kM2EL3rZ3pPZETOTZ9A9PyBsX6?=
 =?us-ascii?Q?KzOXHBzo099K2mTGODVboJi6Mxtenoqn/e4mAzp0YROhQ2w48a6LQX/98RRy?=
 =?us-ascii?Q?ogqrRALY4awaLSPhl0NAqy/q6hM6gZbn4P8YYu3WftnnNuCnnycV6kSAIyBV?=
 =?us-ascii?Q?iIL9vxEaJVzorG63SXKYF4VpqAorR2Oy0v1PUJ0MRCD1+CjBaS3Hp9BfFrJ1?=
 =?us-ascii?Q?bKJ9jGzwGKZG0+NEYNvUalGDdsOwRes8J/ZiXa1W+vwXEJwnlLjN1sZvNLeP?=
 =?us-ascii?Q?NV71lu+owa8OFNFZLQgWJZ4uzoIExKnFGfC+bXmNQ7kMjDuoJ7PrTGjto6YN?=
 =?us-ascii?Q?wMMZQ8UMkfM8/oyn4HjxE/ncHZ6z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fz+CUmWm8yPtk3/fn/6KrpKscjKOJH/LfP8SCbcnR8iQ+QGrmbR0pdOHwK2E?=
 =?us-ascii?Q?GbferG/iupbrAK61ZgHn9/BmIIQO/Izx2Xxm7rLlErmggA5GEWclhxPFl0hq?=
 =?us-ascii?Q?aErvr9EI4UYKOwi8sTSSNVLxuCHMlaj+Y2f/szKQlata9I0yyHZQQF+d98k7?=
 =?us-ascii?Q?iPqCQ+jptaoQQmh1fIfZDfxVYIUKN4jJ0TMEKXv27RGSsaa7wn0AyIzuOjDI?=
 =?us-ascii?Q?CKSc+CEMkv2VDKVuK60d9vOgyLxasTSZe8REdBI4wJWAefNLIiXT/7AvwjYC?=
 =?us-ascii?Q?0EpfDisY59B3QP2kswUGcn7ziCzkv+dbjy9kqvtgMny1B1SWGOa8hEB6OS8v?=
 =?us-ascii?Q?km+L97SWSY/5cg3E3nGdv8+lp/A91eyGDpdy+WLek0lQhfnOR+DX40yo7q+K?=
 =?us-ascii?Q?DIg5yfasHAGTZcnq+gDwNr9kuI9VyrKBqekkB/mZZNY9Eqzb4P0rPptX1/CH?=
 =?us-ascii?Q?pWwmuByWgIkzIhKGNnjNrETnLgpnazgSVnsYk9MiTIKzd2Z5zlMwFbIUmf/n?=
 =?us-ascii?Q?hegNdfW+mxjwG2q8K6jU0jWE8JS2nIFn1szxZRxYLtbfEDb6PYrmuoUtrTph?=
 =?us-ascii?Q?z6ePAw19XFtl25MhiuAq3hos1n8qQwEMWZmZESPc4QcUfipeKhCL6hWkC1my?=
 =?us-ascii?Q?RiUlw1g9z04WvkEHYpjo/j2qDnFxUpBYJ4lr5/jqpS8Hp8ocUYffQIDdc+yv?=
 =?us-ascii?Q?ZWh4bZ4xrErTGyRW1MGH8YtxXeubw/C8oqk25z+VhGHqo9AddbFANcK0WmaX?=
 =?us-ascii?Q?Azo2XdHTuWSjZe9jzrlysApodWSEeGMlH+t86gskWBKKmOVSFEwOv2q/IuxE?=
 =?us-ascii?Q?ef1Fpiack5c0/p3eGRJU94g+fmkTC4Vafxs+rE5VuNBuzRkqTDorL6SpUi7k?=
 =?us-ascii?Q?lveDC05Eb72fJthaB8loKdwODBzLEkKYNsjpDHP2JzVDyRh+UPsHwYEgs14V?=
 =?us-ascii?Q?mllbxg28F/m9zk+uHJC7DFISVHmsEmuxwAkSrszHL2A4sTZ3oVUxey0DNK7d?=
 =?us-ascii?Q?H4aWxV0Jw3e4jX9x8CLdZ16tVd/qzTIFra/6YLKULTSeF3bpX9w5qVdstuGc?=
 =?us-ascii?Q?TijZQBvgZgAoO38NDA24y25m4zMh9kk0yt/3iwMLwMu+uBHN+AcqeDdEu+A1?=
 =?us-ascii?Q?CzMtQhF1kcvZ0F0aKLaFAir804o1jIVlAtBMWKqlQ38f/mEUiHMvBNHDFC0m?=
 =?us-ascii?Q?tw9tTgasvWXDRoHoME5EVOz6sUaj3KB7DndcLtehJn6942SsOT+Cv54MvRHU?=
 =?us-ascii?Q?R3kYOxwaBs/ktRBno7MkU3niqnvvIip04hWZulvjGhjGj22/dENWcG2by5s4?=
 =?us-ascii?Q?cVNoIONvvXZIQ4aHWf/5ATXsH9UC1ckT5/OQSx5fVkqPELQ1JukHtKTZls7H?=
 =?us-ascii?Q?K39j+esrYH6+uNgUNMcqPjMjUX2jiItexzZcJ8PEPBxzkRXJywF/zz1Qkq3g?=
 =?us-ascii?Q?14V0OFdLHHuvtex9lUC1nLLXXN1OvJAPLUil/Pat1SvDhRE5zO/Yrjumjb3O?=
 =?us-ascii?Q?b5PthoLL5rQcssESHLMHaqPVdVA+eLvARAGZPl5PnAUmKTNzVeFVbW5ZEAS2?=
 =?us-ascii?Q?sLKmCYeO0owpzKpCLX3zA1kBa3TWNs1Vwz7tak3BlYfSd2eMqvK6npduoReX?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657a9c20-9676-4971-3ef0-08dd617d3d92
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 15:47:49.0369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GywpN2YQyD3suoI/DoPRYLJiUZ8abxFpE1BpF1EdqCV8aFT/cq542F6oUt8Ftbo7z+cmem2+FNK7eWnhBHQtjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7142

On Sun, Mar 09, 2025 at 06:46:40AM -0400, Faizal Rahim wrote:
> In preparation for an upcoming patch that will modify the TX buffer size
> in  TSN mode, replace IGC_TXPBSIZE_TSN and IGC_TXPBSIZE_DEFAULT
> implementation with new macros that utilizes FIELD_PREP and GENMASK for
> clarity.
> 
> The newly introduced macros follow the naming from the i226 SW User Manual
> for easy reference.
> 
> I've tested IGC_TXPBSIZE_TSN and IGC_TXPBSIZE_DEFAULT before and after the
> refactoring, and their values remain unchanged.
> 
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

