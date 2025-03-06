Return-Path: <bpf+bounces-53434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ACAA53F46
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 01:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E761A17013C
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 00:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6162F1F60A;
	Thu,  6 Mar 2025 00:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mVw2WhsJ"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012059.outbound.protection.outlook.com [52.101.71.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963B6EEA9;
	Thu,  6 Mar 2025 00:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741221793; cv=fail; b=e/BqrgXX1Vf5RY1qc0n0NJtieyp794hT2XCJCkuZ0VrjUzmH3cWetsUX7TtN+EZtgcu1SuaPO4HgVWVEliDkVZ0KM5WZ5sB6gz9Nd9+UCBmn3Q3VvEpL23PRTzmZtt3Yr3TKN1YVKFEjwZ0z0UVvlqjXRTT8RMCtnMAI9XETTvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741221793; c=relaxed/simple;
	bh=IFeVD0QmvftZ1mDJxfI7nQyWGLynfhEm2+q/IcX5LEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c10ULVReJRzcA/azU4JIblW7u0RaY0EfaPL3VtUWwwwqJvC4qGFNT6rOiDDrQ7Y3kSBWexw7IFWqIcsB2fkaIYSWTlXXaIJS/QZcAL1FRFwepC9QntvU/qLTg0X98jzdZCh8GZIUdql3gAx6YzqFYLWAC7BBybtLVqh5hOdbO74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mVw2WhsJ; arc=fail smtp.client-ip=52.101.71.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iqq3zPi2Zh5GDWhgT77cxU7hnMWSFgZ9OE29ZXNerSr8k1mu3kU73VTUqjvNhdZj4zQLmFFwgpBVTUUJ/XhpbhBadrGe6rwS0hJgYXIvCLJ4BfU4WeWzyuPYDL152J2WvawnQ6V6Lv6ec1Ai1/GWE9+j5Oc64rDdsOmt/sAOh5GuL99kSBIAKn8JTFikSzQZf7ZPDG56ZZd+Gu5jf6+i414Ieq7K/1FrHtYMaTggkx3P2ZPgWkfZT3RMP4CFVD/Y5T/8dXcztAP0cDk2hACMgCS64cMIr0B+tLo+qVuRgJIDLel6oWI36Syv2tOreWHccUfeCpp9n8kRisbnKdSueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rt0F4uCjPAszHJEWm9ube4bUlBcoomKxFSCmspLyAyk=;
 b=PhJqWOIqSmVxLUxgl6+CSl7zVrBDRVtU4OzDDqHxfo5CjhWomvnSPNTMAIr3TmipLaewg0oNBTaNU/CBDpjChQHJ3igsCS4kspWMaBZymhMcuj4heV8TpfaGDDRIdIs10miN2Gn13VF2IeTRZUJbCQ5yGNv0Gifuwjlgaw3xnrIDY/libcRIIGHw5Ec0EtVW42nMRkK4jv0/hj7A9SbMHpyvbLT4pCstY0XXWP2uAiTVEmic85YETSU3dE70/30fHceOScE3bdR7Q4KNBnT2wpueHcLJ1ZX8nitQtWSLsg2pVNe9BlfNdsA+dOpFxdnfEmzlk2s5OsYsyZWmgexjXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rt0F4uCjPAszHJEWm9ube4bUlBcoomKxFSCmspLyAyk=;
 b=mVw2WhsJeTl+t5aBYi9iN6zn86pvddb6k9Qhr4LcbL5xB9F6CHbIORh17OqSOzEfHUj6ylD4NTh1Ma55MqOaPHOCNeHHTTo/d38UxWhODVKGZZRl6Kz9LTf4SjQPz7+9x9nY3/niSK2VYCmEjaUeRNOLi2wAOsezBjWl9YxO92Btc7DNl/MmRz5ZgXs6xvMN77Mz60DMBjCbIwwkDrV26iiDR13tBUbJ0YDy1LsuBcCy0Cb4Oz8764R7SetbA0gOBjY1eUOZ05BjA2MNe4rZc77Xh4JfQa/+sA3XD1pJHjnVfTFkF9L/lq9ENRvdmO7qAV92T0/qIOU/ayfWeDyc+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI0PR04MB11071.eurprd04.prod.outlook.com (2603:10a6:800:262::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Thu, 6 Mar
 2025 00:43:05 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 00:43:05 +0000
Date: Thu, 6 Mar 2025 02:43:01 +0200
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
Subject: Re: [PATCH iwl-next v8 08/11] igc: add support to set
 tx-min-frag-size
Message-ID: <20250306004301.evw34gqoyll36mso@skbuf>
References: <20250305130026.642219-1-faizal.abdul.rahim@linux.intel.com>
 <20250305130026.642219-1-faizal.abdul.rahim@linux.intel.com>
 <20250305130026.642219-9-faizal.abdul.rahim@linux.intel.com>
 <20250305130026.642219-9-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305130026.642219-9-faizal.abdul.rahim@linux.intel.com>
 <20250305130026.642219-9-faizal.abdul.rahim@linux.intel.com>
X-ClientProxiedBy: VI1P195CA0057.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::46) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI0PR04MB11071:EE_
X-MS-Office365-Filtering-Correlation-Id: 5240df97-70a7-4de8-1a9c-08dd5c47dba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?68tBHlDxL4s2y+3m5LpjYONubCrqmxVCqwqhcnCkzODOIjMjBISLZciRv8UV?=
 =?us-ascii?Q?HN2XrN4qaRX88EJFNSufQYmk9Mqe1SRIC52rU9Br9WvTsMHJy3AMTxhaH0Wr?=
 =?us-ascii?Q?DXFxuUnQYO7DGv/fUBrLUfSfO9Q0w1rwGBlQ5BNzHaZ9IZPKj0vykpNPsoNf?=
 =?us-ascii?Q?hpbY6gsTSKCv12/OXarPVgLHpDFsNzjnUPSr3f/3Qu0ujPpXykNMfyfdPQpV?=
 =?us-ascii?Q?AC+6weOhW8cJv0qaSMdjw90fuFIOOrYrayWZrYLbv0ASdWhnA/jhdGFm6pCa?=
 =?us-ascii?Q?qRHCS5Vo1HPNyhUsulW6Hkgec5WN87LEOcOn6nybsMQbhn/458gbSHeuXYxY?=
 =?us-ascii?Q?NRuxoc+dtHZB8m0MDdIbNFdayhSq7b/oReFop2jWsyYHCLUDGHeFY5qGZ8UC?=
 =?us-ascii?Q?Cq36yJOfyHz9LgHnDArNSfjnAYyawVZVwRE1ZqnJkxqWtYEBHJn6XjgI3Nt/?=
 =?us-ascii?Q?AUPZktivitVuZyCVaISeVggz/GpLL/Q37kfW3U4Ns96NtbSNwRVtwsSBUXQ3?=
 =?us-ascii?Q?hGNJWb/uisgyTyYY/b2aAz9QCeMnNjov7h2pD3eFM1J9doJKO9SeFkbkUcdq?=
 =?us-ascii?Q?gF9feSY/nQ6Tdz2hm9WWAgrB86ATIlbCWUu7fGrTlH1wAFT4J8hfu5lbQXS9?=
 =?us-ascii?Q?QyPW5mufeZJw+LYijjGn0+WOQxYs5QsYBsoSd6w1aaTd7a+pqCfohHYRWR1m?=
 =?us-ascii?Q?l3PR9j3bqRD9WH8omrpjjqAos03vG2EBsnkNzsyoAsarUFvcVOsMPmOuTDTn?=
 =?us-ascii?Q?zq/fV21P8NT5U3SBlut7dopfwKqpXD71qFG5c9bJB16pqZedJcVFU0iMX2u0?=
 =?us-ascii?Q?h8eu+4fhNcQ2IkVhLC4Z5xMJf0/7EKqGte/QE32wfwhMSOgjsfE++otwyhJZ?=
 =?us-ascii?Q?5wrVh0zxhPYki3ke1YPhy2q15OPgR6wgphzTLnyO0eBP8N0Uod1jckhgiH6c?=
 =?us-ascii?Q?HXVRB4okXH5bLcDWhH0Xsr529pEw61eSgBJkUcMYXisvykv2myxv/qLqPAuB?=
 =?us-ascii?Q?kAnrT2HgCaaDbed4exCkz2NPlNdQsmM8CH4Qj+UbhNQGhlFWGoUjTScdCGAp?=
 =?us-ascii?Q?3sffzwsz7JuH2xRKohFKbFu0f4RnfVNQqUJ5OE7VBpyc/32b63sKJNbGq66s?=
 =?us-ascii?Q?U2ZLnJqGKV1eCZDDfK6OiafhsoxjvHvQzBVVGWIqQq/43E0zirrXzMZXLgFR?=
 =?us-ascii?Q?hihy6htbiQFiYXg9Y9x46R+3QRy/YnXppNHX7CShx83j2TWXkhuS68o07N4b?=
 =?us-ascii?Q?A2aZQ0rn+JnaVEK1i0Ulp92He+mN/j7l6Si/Z3c7i9L/Qcs8kaAXFjD2d0fj?=
 =?us-ascii?Q?7dQLAHSRBU53lGM+/xLrpUlvPF/UkbcEOtz2FxwUxtwUtPT3Wwobw8ouILTI?=
 =?us-ascii?Q?eJ2PTRXBiCLysWllKYg01us+8yNI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Woytg/G2yfArt2O/I0nM0xXgqFARRLg1som9N3i7hFckZDBxs3V8zw5WHtFc?=
 =?us-ascii?Q?EeKwEYYJTt/arew79nmAZePYiQ4V3dzj9Nq40BD73No/8YUEgRH03NFnzRKK?=
 =?us-ascii?Q?l7dlyV8qwpVVsVLiFTZWKCp46g+2qXnOfrMIU+qk39QGq0o2BWxfb/9pC+Ca?=
 =?us-ascii?Q?uZuboIiU6y/ZGv23unChYvpFeZ/QC35NumaLMcBTIiW8bCfXEgmHQMm/sgck?=
 =?us-ascii?Q?zKOHv8Imp8638uBYZWrb6/F0J+FGdfbtMsmwk2W6i/MI59DrPfaj//1Dtasc?=
 =?us-ascii?Q?LIVTmmcIg7PIIgVfLnZnCLKzOAiATYbNZ+crDs45htMrtdvE1DjGUVXCxLbd?=
 =?us-ascii?Q?5Wf+lj30AKsJMWr3+TaMNSYTcR8FxBrHx3GzdAthDr05ghex6g0mco/UDqxB?=
 =?us-ascii?Q?KQMDcw7yKLSiTBz3oCG3uwJSBXcmJOy1K/uZmdfayqc+6SVx1BUZWB1EBEd6?=
 =?us-ascii?Q?zOY5KJpGMyINkbXG6Ljx+dzNtfsCtRQ3TzROzr2KdDCVUzmjl0YQ3WSi66Hi?=
 =?us-ascii?Q?afSThTX4vhLWeu/kbK+keaGGeRXBvxGGgBUuy54SH3PmsYWKyyGnAkTJt2Yn?=
 =?us-ascii?Q?8rmz1FmFFXVrvyUwBpl+e4CkGijBRotzhF5tQhPs4ak078sXv0w53MnZP4ax?=
 =?us-ascii?Q?gS5/jpH5k7FRiwhOu6A4l5BahLALek9CTewhMaYcwQC0ghg78D+L1XB6IEPb?=
 =?us-ascii?Q?ZGHBGufPfmrqZR/Pmd6mgI7WCikMIhERXlo6JEnHUk1ma7IMkZnUYx8yS8O6?=
 =?us-ascii?Q?ygLdMCoR2VWoIYajlOC2+Sm2OxI2nfZhvqUdNxlke8DmN9sYIMcWXjhs/Nvo?=
 =?us-ascii?Q?UfhmE6H2NF3m0N+7Bc/033e6HvzlespeQ7xNkHhd5DZoOEAM24TN52Vyp9Yu?=
 =?us-ascii?Q?eV3mYa6X3u+nsdruMhObaME/ozK7XtbtdTUgCWDuTL4zzwMHaLVPfogyUT74?=
 =?us-ascii?Q?n0elFz2QeKfzII4jJU1i8KnMgAWDIPscGqlZynrtbvvdPjCQeaaCwsEoh5UH?=
 =?us-ascii?Q?NlYoxSdAxk+TkBJU6ExXJE9zTqcAUrNEaMsIhaom2GBPylMl+EK8Gt8Hak0i?=
 =?us-ascii?Q?s2DRP6crLcN7vrxd4RBHZTkd9vbWrruG9/rB2QLPtth3Xmjr2MaPJrGe3Gu6?=
 =?us-ascii?Q?+vH49NkOSWI57LWMjgeFK6IGulOtfNZ7s8hg49CLrE1mxqSGBj745B3GHt/U?=
 =?us-ascii?Q?PU5HNbb2SPWWOhZS6ZVMvfNmej+iRSX14Emd342npoP7PSeOP1XAuTOzZlPD?=
 =?us-ascii?Q?8cNjPcxkFwOljh+ud19fUhvLfbm3cXgVKYQLEmzrXs7L8lxThdxbxBl/p36G?=
 =?us-ascii?Q?n+68JJuseIQyjkIntjqaO6Mpg4HIyJmNCh31R+WtLbL7DsvVxd40e8B0Clc7?=
 =?us-ascii?Q?bbEjvW+CCQzdeeVzEoESaIPuhEtyjUGHKU28mDBeG7D/xDUg1s+nJzJpTg5w?=
 =?us-ascii?Q?DCK9ZUrIZ9WQCJmFaWYR9Kb8BPxnZsjISfJgie0fQzrGSbI8K01gsW7ZWKa0?=
 =?us-ascii?Q?j/v3c4wy1Oi2TLPb8733rt1+y15LiFIstfwRzSN0Xnu7T22wKXq8NaM0jH/1?=
 =?us-ascii?Q?IC3ISF6zL6rb3LX+OqZffef8HaQpUsGzNVoxTKIXnmornAS2ubu14oGdm4EM?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5240df97-70a7-4de8-1a9c-08dd5c47dba6
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 00:43:05.5868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muHbIc6b13iLTx7zl2obcgKKJnwa41mgf6kTSE6lcaR9C8jYY6WcSLm5i2rzsqck5LniFt9PG45TmRx8lXD8uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11071

On Wed, Mar 05, 2025 at 08:00:23AM -0500, Faizal Rahim wrote:
> Add support to set tx-min-frag-size via set_mm callback in igc.
> Increase the max limit of tx-ming-frag-size in ethtool from 252 to 256
> since i225/6 value range is 64, 128, 192 and 256.
> 
> Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |  1 +
>  drivers/net/ethernet/intel/igc/igc_defines.h |  1 +
>  drivers/net/ethernet/intel/igc/igc_ethtool.c |  5 +++
>  drivers/net/ethernet/intel/igc/igc_tsn.c     | 37 ++++++++++++++++++--
>  drivers/net/ethernet/intel/igc/igc_tsn.h     |  2 +-
>  net/ethtool/mm.c                             |  2 +-
>  6 files changed, 43 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index d9ecb7cf80c9..4dfd133b4d6f 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -42,6 +42,7 @@ void igc_ethtool_set_ops(struct net_device *);
>  
>  struct igc_fpe_t {
>  	struct ethtool_mmsv mmsv;
> +	u32 tx_min_frag_size;
>  };
>  
>  enum igc_mac_filter_type {
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 22db1de02964..038ee89f1e08 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -551,6 +551,7 @@
>  #define IGC_TQAVCTRL_PREEMPT_ENA	0x00000002
>  #define IGC_TQAVCTRL_ENHANCED_QAV	0x00000008
>  #define IGC_TQAVCTRL_FUTSCDDIS		0x00000080
> +#define IGC_TQAVCTRL_MIN_FRAG_MASK	0x0000C000
>  
>  #define IGC_TXQCTL_QUEUE_MODE_LAUNCHT	0x00000001
>  #define IGC_TXQCTL_STRICT_CYCLE		0x00000002
> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index b64d5c6c1d20..529654ccd83f 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> @@ -1789,6 +1789,11 @@ static int igc_ethtool_set_mm(struct net_device *netdev,
>  	struct igc_adapter *adapter = netdev_priv(netdev);
>  	struct igc_fpe_t *fpe = &adapter->fpe;
>  
> +	fpe->tx_min_frag_size = igc_fpe_get_supported_frag_size(cmd->tx_min_frag_size);
> +	if (fpe->tx_min_frag_size != cmd->tx_min_frag_size)
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "tx-min-frag-size value set is unsupported. Rounded up to supported value (64, 128, 192, 256)");
> +
>  	if (fpe->mmsv.pmac_enabled != cmd->pmac_enabled) {
>  		if (cmd->pmac_enabled)
>  			static_branch_inc(&igc_fpe_enabled);
> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
> index 0a2c747fde2d..2ec5909bf8b0 100644
> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
> @@ -6,6 +6,12 @@
>  #include "igc_hw.h"
>  #include "igc_tsn.h"
>  
> +#define MIN_MULTPLIER_TX_MIN_FRAG	0
> +#define MAX_MULTPLIER_TX_MIN_FRAG	3
> +/* Frag size is based on the Section 8.12.2 of the SW User Manual */
> +#define TX_MIN_FRAG_SIZE		64
> +#define TX_MAX_FRAG_SIZE	(TX_MIN_FRAG_SIZE * (MAX_MULTPLIER_TX_MIN_FRAG + 1))
> +
>  DEFINE_STATIC_KEY_FALSE(igc_fpe_enabled);
>  
>  static int igc_fpe_init_smd_frame(struct igc_ring *ring,
> @@ -128,6 +134,7 @@ static const struct ethtool_mmsv_ops igc_mmsv_ops = {
>  
>  void igc_fpe_init(struct igc_adapter *adapter)
>  {
> +	adapter->fpe.tx_min_frag_size = TX_MIN_FRAG_SIZE;
>  	ethtool_mmsv_init(&adapter->fpe.mmsv, adapter->netdev, &igc_mmsv_ops);
>  }
>  
> @@ -278,7 +285,7 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
>  	tqavctrl = rd32(IGC_TQAVCTRL);
>  	tqavctrl &= ~(IGC_TQAVCTRL_TRANSMIT_MODE_TSN |
>  		      IGC_TQAVCTRL_ENHANCED_QAV | IGC_TQAVCTRL_FUTSCDDIS |
> -		      IGC_TQAVCTRL_PREEMPT_ENA);
> +		      IGC_TQAVCTRL_PREEMPT_ENA | IGC_TQAVCTRL_MIN_FRAG_MASK);
>  
>  	wr32(IGC_TQAVCTRL, tqavctrl);
>  
> @@ -324,12 +331,34 @@ static void igc_tsn_set_retx_qbvfullthreshold(struct igc_adapter *adapter)
>  	wr32(IGC_RETX_CTL, retxctl);
>  }
>  
> +static u8 igc_fpe_get_frag_size_mult(const struct igc_fpe_t *fpe)
> +{
> +	u8 mult = (fpe->tx_min_frag_size / TX_MIN_FRAG_SIZE) - 1;
> +
> +	return clamp_t(u8, mult, MIN_MULTPLIER_TX_MIN_FRAG,
> +		       MAX_MULTPLIER_TX_MIN_FRAG);
> +}
> +
> +u32 igc_fpe_get_supported_frag_size(u32 frag_size)
> +{
> +	const u32 supported_sizes[] = {64, 128, 192, 256};
> +
> +	/* Find the smallest supported size that is >= frag_size */
> +	for (int i = 0; i < ARRAY_SIZE(supported_sizes); i++) {
> +		if (frag_size <= supported_sizes[i])
> +			return supported_sizes[i];
> +	}
> +
> +	return TX_MAX_FRAG_SIZE; /* Should not happen, value > 256 is blocked by ethtool */

Try to place comments on separate lines from code.

> +}
> +
>  static int igc_tsn_enable_offload(struct igc_adapter *adapter)
>  {
>  	struct igc_hw *hw = &adapter->hw;
>  	u32 tqavctrl, baset_l, baset_h;
>  	u32 sec, nsec, cycle, rxpbs;
>  	ktime_t base_time, systim;
> +	u32 frag_size_mult;
>  	int i;
>  
>  	wr32(IGC_TSAUXC, 0);
> @@ -501,13 +530,15 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
>  	}
>  
>  	tqavctrl = rd32(IGC_TQAVCTRL) & ~(IGC_TQAVCTRL_FUTSCDDIS |
> -		   IGC_TQAVCTRL_PREEMPT_ENA);
> -
> +		   IGC_TQAVCTRL_PREEMPT_ENA | IGC_TQAVCTRL_MIN_FRAG_MASK);
>  	tqavctrl |= IGC_TQAVCTRL_TRANSMIT_MODE_TSN | IGC_TQAVCTRL_ENHANCED_QAV;
>  
>  	if (adapter->fpe.mmsv.pmac_enabled)
>  		tqavctrl |= IGC_TQAVCTRL_PREEMPT_ENA;
>  
> +	frag_size_mult = igc_fpe_get_frag_size_mult(&adapter->fpe);
> +	tqavctrl |= FIELD_PREP(IGC_TQAVCTRL_MIN_FRAG_MASK, frag_size_mult);
> +
>  	adapter->qbv_count++;
>  
>  	cycle = adapter->cycle_time;
> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.h b/drivers/net/ethernet/intel/igc/igc_tsn.h
> index a2534228cc0e..975f4e38836e 100644
> --- a/drivers/net/ethernet/intel/igc/igc_tsn.h
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.h
> @@ -14,7 +14,7 @@ enum igc_txd_popts_type {
>  DECLARE_STATIC_KEY_FALSE(igc_fpe_enabled);
>  
>  void igc_fpe_init(struct igc_adapter *adapter);
> -u32 igc_fpe_get_supported_frag_size(u32 user_frag_size);
> +u32 igc_fpe_get_supported_frag_size(u32 frag_size);

The "-" piece shouldn't exist. You are renaming a function argument for
a function declaration that shouldn't have existed in the code prior to
the introduction of its definition. Please delete it from the original
patch that added it.

>  int igc_tsn_offload_apply(struct igc_adapter *adapter);
>  int igc_tsn_reset(struct igc_adapter *adapter);
>  void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter);
> diff --git a/net/ethtool/mm.c b/net/ethtool/mm.c
> index ad9b40034003..4c395cd949ab 100644
> --- a/net/ethtool/mm.c
> +++ b/net/ethtool/mm.c
> @@ -153,7 +153,7 @@ const struct nla_policy ethnl_mm_set_policy[ETHTOOL_A_MM_MAX + 1] = {
>  	[ETHTOOL_A_MM_VERIFY_TIME]	= NLA_POLICY_RANGE(NLA_U32, 1, 128),
>  	[ETHTOOL_A_MM_TX_ENABLED]	= NLA_POLICY_MAX(NLA_U8, 1),
>  	[ETHTOOL_A_MM_PMAC_ENABLED]	= NLA_POLICY_MAX(NLA_U8, 1),
> -	[ETHTOOL_A_MM_TX_MIN_FRAG_SIZE]	= NLA_POLICY_RANGE(NLA_U32, 60, 252),
> +	[ETHTOOL_A_MM_TX_MIN_FRAG_SIZE]	= NLA_POLICY_RANGE(NLA_U32, 60, 256),

Please make this a separate patch with a reasonably convincing
justification for any reader, and also state why it is a change that
will not introduce regressions to the other drivers. It shows that
you've done the due dilligence of checking that they all use
ethtool_mm_frag_size_min_to_add(), which errors out on non-standard
values.

To be clear, extending the policy from 252 to 256 is just to suppress
the netlink warning which states that the driver rounds up the minimum
fragment size, correct? Because even if you pass 252 (the current
netlink maximum), the driver will still use 256.

>  };
>  
>  static void mm_state_to_cfg(const struct ethtool_mm_state *state,
> -- 
> 2.34.1
>

