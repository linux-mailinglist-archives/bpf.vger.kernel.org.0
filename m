Return-Path: <bpf+bounces-50547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0802CA296FF
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 18:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D601884BCC
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 17:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406811DE8AF;
	Wed,  5 Feb 2025 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KvNlrLy8"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2072.outbound.protection.outlook.com [40.107.247.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F134C76;
	Wed,  5 Feb 2025 17:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738775563; cv=fail; b=fV7Keyrfetujm15pQFAyOx8YNeqwJAywkTV+C7MKO7OoCmOIOrwc2+jlf1sK6QJE71N9Y6PCtd+AKQVPI/ccOYVl6wSf7ig/S72vYUSZlGtf/Kp5z9TMuKjFgwZWGItrcQMVoIOLgmgQ34BouDgzpIf+fFqQPM4pJUK2SMuvXnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738775563; c=relaxed/simple;
	bh=EsbK+RJPIW/AA0zFxYmalne83Hy8AkS0MwaTtoPc2jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZuxQBHbm284HnjkmR6366bXznTxaQ4v52U+lf99xxThEQcbu204hWRDecfg7RDpmvwOMRnc9QKI5+zBBt3J+rmtXeHcqcEAdth19CaHcROUZ01Vv6ii2FTYijt0CdadnZSlx7izud+mebj78PMl1+4pv5WEWdEZolNNCYnbXoso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KvNlrLy8; arc=fail smtp.client-ip=40.107.247.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVd03/ABm4TLUievTHPmdUWqL3hJ8GE4tpuKHYlVcU7/6hyAvc1/7dTlFb5hJ61EDHvC8DHqciVOv1fN85NaiueeYipbKz/X+A+8+uE5ALKE2vYlf0g5br6QETdccwr+TAR71YzJBA7GrvTW66/lpdjLcdZKFGbnhlGJHd/lw58DsfcJZjlLre1RRx7X1QU894HSWWvghoJUxfb1ZYXpSQqj+RH1hT6i+N4dPPjdqUxtAYttu9li8McM8ngl+BiZGYu7i6wyHp7uNhqox9VfkfQuoBqCbdw1QSUEGqWFVcLklQCbHCU1dHIQaAUQAwtF+/N/GppXtV/iVOZsg0L61g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sWMx+n+tlGpcSc3slDBfYGXnZktevEI5TWh98q2XLw=;
 b=oaQwsqDJ+7hmbfxHoiVmQ8C/8KC98/ETiVMM/phLEs1SPoE1Qd7VjzHnmDnQ/9B310rzLPGBxMoOtvuxCg3rdb/bsk/2up0Dtl53gdjOVXNkIgW5X0xbP05XXwLhCNUPZJU56tW36nC0/eMKDK1bIXwAZ+RdMzYPyi3VwJVZ0W2AzAyB20VH8/kgN0pLIyhnQ8bHS2Z59vBfor9jBMliu1o2DAT8uYCJG057CnofnHyg3WAO6VI5gGJxoR0DiuKNHXwCZesEtu4pPxUsE/jtrDuqNct/YWA1FcDZBBV2p410Ta9y/pwIW7NXsR2en0V7zFzBbfJHHimQeN0KcwM5Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sWMx+n+tlGpcSc3slDBfYGXnZktevEI5TWh98q2XLw=;
 b=KvNlrLy8RwwxN1uKT7U4K6BZuoNC7gPBCXfplbKeIuxZROQC5cUwRQZ+ziPuR5WPw1hlRjPsJMk6uMmeRJ/SBP2lWKQk1KAU9vJ/I5KruIe95tPsvM44928uAFr/wlSw79swpjSHJrgu5bHKnqZhjSRUXCg+mSO5g+ioK+IhTdRd5eRkqDAepD2xeHbOlSRK6SoObzy/RGynkk1cVEIV8Bfgs1MojRJy0Yv6bO1B2yiWH8RKOMCQD+TKH0sgqroypXoA50/EKVkmfHKalUjYdpaU/DYm6KzJpMaRAIVVqtk8Ezm6+a27MASPjkyZgSvNNZSYhbmTL27AxdIYBgZO1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU7PR04MB11164.eurprd04.prod.outlook.com (2603:10a6:10:5b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Wed, 5 Feb
 2025 17:12:38 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 17:12:38 +0000
Date: Wed, 5 Feb 2025 19:12:34 +0200
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
	Russell King <rmk+kernel@armlinux.org.uk>,
	Furong Xu <0x1207@gmail.com>, Serge Semin <fancer.lancer@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Petr Tesarik <petr@tesarici.cz>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 5/9] igc: Add support for frame preemption
 verification
Message-ID: <20250205171234.cuscjpzdyc34ofbn@skbuf>
References: <20250205100524.1138523-1-faizal.abdul.rahim@linux.intel.com>
 <20250205100524.1138523-6-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250205100524.1138523-6-faizal.abdul.rahim@linux.intel.com>
X-ClientProxiedBy: VI1P194CA0058.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::47) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU7PR04MB11164:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f68d4a-ea2b-4605-17a2-08dd46084a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amhBNk1OZnRlRUNrSzlsdHBKS2tocTdRaUxvb21tdnNzT3Z0elhUVjlUSjA5?=
 =?utf-8?B?UUQxWjdESGZTTElsMndwQzlQYjdpSWFTa0hEbzdyZ0hIVzlwTzV5MjVXb3V3?=
 =?utf-8?B?K3pUTnZLNVdrMFNaSEpMc2wraWFjSHNUODhiMmdoaEtRRW04SENuNEtaU1Zv?=
 =?utf-8?B?eTlLK05kcFFiVkJ4bnN6T0hEQjhuclJWZDdndHFSNXJweUxhTGtrbFQ4Znpk?=
 =?utf-8?B?Q2hkaDhqNEtrdWVpRndCejlJeFNwd2pWR3dVcWdtc3E0WVhnTThCdWk3ZCtu?=
 =?utf-8?B?UWlYVlh3NVBYNVYxM25OVE1qeklpSVdpbmdncFdhVTRoWFhTaXVUblUrWE9U?=
 =?utf-8?B?TjhGcS9MNnJYQmRZYTZmaWhaeDR1TGpRV0lkUjZab1ZhdHdpUVJaM2pFTWZY?=
 =?utf-8?B?czEzMW9DWjJWT05lRWpRemQzaVNGVThQaWZpajlLRG1CdGoxYnpZNXp0Y29w?=
 =?utf-8?B?MGE1Q1BsRlk2b0FxL2d5MkpPeW5yNHN1cVRQZjlCTlNWaUNVRmNueGZxbW9Q?=
 =?utf-8?B?aUFlUGZINFhnNE1TRDJYcHliTkk5dzJTU1o4VC9PNUFTeG1YcmNzcFhheHla?=
 =?utf-8?B?aVRsaFRsa2toK2lzcmVvYk9jYjZNQmlCdlM2ZlkzcGNvZ0NQZjR5VXdrK0Rn?=
 =?utf-8?B?UTJERkhKVFNldmNscUs3aHhLcWp1K3ZRcFFsT1YwUEErL3pzd05OR09NUHpP?=
 =?utf-8?B?QlpFVVZsVjFBS3VqOUZpbm01RVd2d0ZUTExjUmJyNnlMZHFRUWlmWDVSSU45?=
 =?utf-8?B?TDVEZzhFUGwrT3dKOWJsdWttWFJjK1NrdTVYL3IyYkRQV3VzQStTQk5ObEND?=
 =?utf-8?B?OTVucUkyVFF5MVNHRzZVUnhHa1JsQmlac0dPYU5yQk1nQ3BXYWtBVGV3ZmJ5?=
 =?utf-8?B?RVUwR3BKdVBOYkxmdStjYUVPMzgrN0cybm5WYkVEU0o5T0loWUlWa240dG5S?=
 =?utf-8?B?L3FJKzhpcE1UNjFPWE0wRzViSzFSQkJDWGl4WkwwclBCSFQ2bi9JOEZ0Umx1?=
 =?utf-8?B?MC9BaXFGcXZvTTYwQnJ4Snh4L2w5eWwvSTdPSzRCZW1SQ25LWWtRVkY3anVK?=
 =?utf-8?B?dmY4SHNxVW1CeGxrd2VqMVZpaUZ6MWh1dzhlVklrTzBzelZYUm54M2JVNTg3?=
 =?utf-8?B?eHpRRlVzNDlLWEI5bXhkZk9OZURUREg2U3ZJYmZYbjBzTW9jRGVtQzQ5QUlL?=
 =?utf-8?B?S05KeHhKc1poc2lYeW91allnR1ZZa2x6RVNqODhKWmNVbmk0dEU3b0FSQlgx?=
 =?utf-8?B?YndpeWM2TXZGQXdKM09xdUg1N0xrNnRvYyt6ZzFMR0VhN0pVc1JoUjYrSUJP?=
 =?utf-8?B?YUtRT3lHM2pTbEZWL2k3VmdVOHc4OVFkcmhQcUdISGRoY3gxd2NBb29yeDRE?=
 =?utf-8?B?U3NFMEx0emlBNndaZ1RWZVd2NmZJdGdTeFpqZ0w2NExOYWZtd2lBVldYbjVI?=
 =?utf-8?B?VkpEZ2ZrZVkwTVFWOXp4WkpXNkxaNDF3QVVHUXFtMTlZanZ0UDdKRmRkdmh3?=
 =?utf-8?B?MUg0YkZNWGZCUDJ1ZW1SZFpuY20rMkV2MWlvNm9sSU9aR3dKRmRvU0dreVBR?=
 =?utf-8?B?STJmTWpBWkdNQWptYUdXaktPa2pXbXQvMjcyQVpvc2Rnb2g4cHZBOXpEeWFu?=
 =?utf-8?B?R1dibzVjUXJXYnBsVnZaT0s2Vk5KZUhQeWxrSEIrSDFQQittVnk2cS9CQVVu?=
 =?utf-8?B?aGtCOU4zdndKdzBIRjJLWEZGTkl6NFdTNFI3TXFveGxRV2ZyWG5sQUVwbXVh?=
 =?utf-8?B?U0tDaVR2SUxuZkRrdkErM2xmeDZrTlI0a3dnTEJNQkZVbVZublN2Wm9nSE1G?=
 =?utf-8?B?Y1ROc2ltRlE0TGJ3b2FYQjVrRG11NnFqZXV6a2Q3bHJGUE5PbjJjUnYwMm93?=
 =?utf-8?Q?B0lhBKFYsF5C/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkpOVGw1Ry9VdEtOOHlaUC9Xd1lDQmlQcUpDa0JvU0J4N0d6SHRVY045Rmdz?=
 =?utf-8?B?UGVMV0cvQ24yY0NpczZrWnY5SzV4ekRpdHNxTWx5Q3kwN2pxSWFkRDV2NWk3?=
 =?utf-8?B?RCsxNmoxRG5Vc1RVUWhWbW1CMTNqNUxZVWkwUkJVK1U1V2pWbnZuSXo3T0V3?=
 =?utf-8?B?aWlYOVkzQnZzM0lNNS9udzZST0N2OTdkdGRQbnJoM2RqdlpFWm1ZNENKdzNn?=
 =?utf-8?B?ZFltdnRTbWx3ZVltSlRqbDdjdzFEbDF6VkZqeVJCbjV5Tk5QUjZla21zOTBn?=
 =?utf-8?B?UzNkR1FQVUJEVWgwcGU5bEY5ZWJ1UWlNUDVCSmdrT254UzNkLzN2R3g2Skpo?=
 =?utf-8?B?RWVqTTJUNlNmclU0S0V1TjJPSjdJcVVEV0llTnhMdEFSektmb1JGb1ZwdHAy?=
 =?utf-8?B?cklTR2pUbWdiaXFyYWpLQzU3c0tTYkNwbUNYaGVDS0phUFFMZzBQN2JaT2J6?=
 =?utf-8?B?ZnNHSE9rSmpMc0wxeVVoemIvOFEwMllXa3hHZVR5ZWlxUzFYN1VXUHViRlFS?=
 =?utf-8?B?SEQ4YnNQYnNpc0dqOHNZVlBoYkFrVzF2ZHRaOFdPWkY0U3hCbVVndWRKNkhC?=
 =?utf-8?B?TjFLYlc2MjY5QU01ZnFDZHIwLzRaVmpObC9PejFoU0xMSnBhcUpTOE85MDA2?=
 =?utf-8?B?WWsrNWRpdjNEbkgxcnFhK3dNUTZJRUFzOVFmTURaQTJFNGkyVXhGZklhRWRR?=
 =?utf-8?B?UnF1RHdkTEpFaWdzSVFSeTdHUzJNajRaR2tkcDY4cVJZOW1EUkNYUUlIZjhC?=
 =?utf-8?B?S3kxaFN0ZWJCUjVHd2NWbTFmTmpqVEVoRUJPL3IyVzBuRXk0VXFnQ1FiK2hM?=
 =?utf-8?B?S0p0Nlc1cG42L0lKcHRlV3NpdkZDSUQ0TWNJdVBaNFNFa3dranQyelVNMTNa?=
 =?utf-8?B?TGVaMWY0RnNrczVaRm5lVlVQSkpyd0ZJZ1phUHY3UnBxcUQ2dU14S3IzOUo2?=
 =?utf-8?B?VWJCMC9oMERING9ad05lTkdhc0Z5MlFKSE5IODlqN0VCazQvd01GK3RiTjIx?=
 =?utf-8?B?MUo4c0xhRVhVck9QSnYweENOS0JFYjlzVkZ5cmNyVUhkL2ZGMHByQXc0ci9k?=
 =?utf-8?B?a2pZRGhHODhaSVZqSDJUUHVvNmkwU3g5VjMvcFZGaThicE1iSFhic0RyZlNn?=
 =?utf-8?B?ZnJzenl6VW5sZStsbmJoU29RTU1lYm4rN2hwcVpYMDNheHlPL0ZHRksxOTFs?=
 =?utf-8?B?a1VVWDlxM2dISG9yVXRRZEVWT2kvQmI0T1k5b3JOekczRmhSNzJTV1NxeU1p?=
 =?utf-8?B?MWNOK1RHYm5NakxlaTVBUEhXRUphcTFhclc2bWJoaUN5eVo1Ty9nWDhBazU3?=
 =?utf-8?B?SmMzbzJmVWpxWU00ZFJKK3k4ck9TSkcvdFFncERZZU1iblZWS0xnbXVkbmVw?=
 =?utf-8?B?eWlTcjAxM0FHcG8rQldMcFN3c0p6UlF4SDBxLzdybkNjM3JQS3JCTHQ5UHlQ?=
 =?utf-8?B?VWg4SkdvTUtEbHVqVnIxaEZrOHF4NW45MHlaaEs1N1RlSGhLL2s2aFFXOHdH?=
 =?utf-8?B?TmtFeFVpeW1lanBBSklZUEJWR1A1M09LcVErdS9SWGtYN1FjenVvY05IZXdO?=
 =?utf-8?B?UjhTUjVRamF6bnQveHRpVlBhKzU4TGl3TnFwL3NDWXhLQ2o2R2syY1dEMHRh?=
 =?utf-8?B?T29QTmR3Y1NjQWF1eU1pVkpzd05EVHpJQ2N4WEF0eFFSYnBycnd2TzlZOXRC?=
 =?utf-8?B?NUQ0YjhUL3kxdEFwRFlKK1ZwUkk0MVV4RUZWcXpTRmJ5TysyM2Era2QyQjJJ?=
 =?utf-8?B?OGVORlRnR3B6c1lLbU9QeDYvL2Y4Y095N3ZSakhtQXdGL3JrSjZYNy9kY3R3?=
 =?utf-8?B?RXl1ZkswTm9STlVnYkZwM1Y1VmdoVlFDVFdKbDNsZ0hJbytKL2RMS1VhK0hi?=
 =?utf-8?B?bzZIclVMVGFHNno0N01rbFE3czNscmRGUzdjeUhjdS9HT3JZVmMzenJyN2pX?=
 =?utf-8?B?OG96Z1FpOEV4U1FYS0lhaEMvRm0zNCtiaUxNUUZvR0RMYkh0UHZLVFBYNjBL?=
 =?utf-8?B?blhHMzdYOTBWQmFBWUg5eTJQOEZEUDRTY1dISmxkcTBxOExTeVF6UzJ4Uk5v?=
 =?utf-8?B?TUJqUGdmdnZ5N1NaSkR4clB0cDhVcXpITWEzTzFqTHhKMWgrUDdMRXdXcm8v?=
 =?utf-8?B?bXk4U1ZzOTlIL3FqcjVHNnhFNStBc3NEV0dzalZub2QwZGw3dVFEZktCQzk1?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f68d4a-ea2b-4605-17a2-08dd46084a5a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 17:12:38.0207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLC1MoZjEZmJGaATVBamBgjRzKcvZFni0uEkfjSkA7RpdfHG7dmvIVtts47DPAh/7gOdneqhNSzpZbZZSE9Sow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11164

On Wed, Feb 05, 2025 at 05:05:20AM -0500, Faizal Rahim wrote:
> This patch implements the "ethtool --set-mm" callback to trigger the
> frame preemption verification handshake.
> 
> Uses the MAC Merge Software Verification (mmsv) mechanism in ethtool
> to perform the verification handshake for igc.
> The structure fpe.mmsv is set by mmsv in ethtool and should remain
> read-only for the driver.
> 
> igc does not use two mmsv callbacks:
> a) configure_tx()
>    - igc lacks registers to configure FPE in the transmit direction.

Yes, maybe, but it's still important to handle this. It tells you when
the preemptible traffic classes should be sent as preemptible on the wire
(i.e. when the verification is either disabled, or it succeeded).

There is a selftest called manual_failed_verification() which supposedly
tests this exact condition: if verification fails, then packets sent to
TC0 are supposed to bump the eMAC's TX counters, even though TC0 is
configured as preemptible. Otherwise stated: even if the tc program says
that a certain traffic class is preemptible, you don't want to actually
send preemptible packets if you haven't verified the link partner can
handle them, since it will likely drop them on RX otherwise.

The problem with that selftest is that it relies on the driver's ability
to report split ethtool counters for eMAC/pMAC, rather than just aggregate.
In lack of that, you need to know through some other mechanism whether
the link partner received those packets as preemptible or express, and
that's kind of hard to add to a selftest.

> b) configure_pmac()
>    - this callback dynamically controls pmac_enabled at runtime. For
>      example, mmsv calls configure_pmac() and disables pmac_enabled when
>      the link partner goes down, even if the user previously enabled it.
>      The intention is to save power but it is not feasible in igc
>      because it causes an endless adapter reset loop:
> 
> 	 1) Board A and Board B complete the verification handshake.
>             Tx mode register for both boards are in TSN mode.
> 	 2) Board B link goes down.
> 
>          On Board A:
> 	 3) mmsv calls configure_pmac() with pmac_enabled = false.
> 	 4) configure_pmac() in igc updates a new field based on
>             pmac_enabled. Driver uses this field in igc_tsn_new_flags()
>             to indicate that the user enabled/disabled FPE.
> 	 5) configure_pmac() in igc calls igc_tsn_offload_apply() to check
>             whether an adapter reset is needed. Calls existing logic in
>             igc_tsn_will_tx_mode_change() and igc_tsn_new_flags().
> 	 6) Since pmac_enabled is now disabled and no other TSN feature
>             is active, igc_tsn_will_tx_mode_change() evaluates to true
>             because Tx mode will switch from TSN to Legacy.
> 	 7) Driver resets the adapter.
> 	 8) Registers are set, and Tx mode switches to Legacy.
> 	 9) When link partner is up, steps 3–8 repeat, but this time
>             with pmac_enabled = true, reactivating TSN.
>             igc_tsn_will_tx_mode_change() evaluates to true again,
>             since Tx mode will switch from Legacy to TSN.
> 	10) Driver resets the adapter.
> 	11) Rest adapter completes, registers are set, and Tx mode
> 	    switches to TSN.
> 
>         On Board B:
> 	12) Adapter reset on Board A at step 10 causes it to detect its
>             link partner as down.

Is this using fiber/DAC, or twisted pair (RJ45 PHY)?

> 	13) Repeats steps 3–8.
> 	14) Once reset adapter on Board A is completed at step 11, it
>             detects its link partner as up.
> 	15) Repeats steps 9–11.
> 
>    - this cycle repeats indefinitely. To avoid this issue, IGC only uses
>      mmsv.pmac_enabled to track whether FPE is enabled or disabled.

Not that I couldn't eventually tolerate this workaround, but I figure
it's worth asking anyway. Isn't there a way to do an adapter reset
without losing link in the PHY (assuming it's the PHY that loses link)?
Is that a consequence of software design that's not careful enough, or
of hardware design? I assume the PHY is a discrete component. Avoiding
the need to retrigger auto-negotiation saves a few seconds of waiting,
so it's worth pursuing if it's possible at all.

> Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Co-developed-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index 817838677817..41cb03816f92 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> @@ -1781,6 +1782,23 @@ static int igc_ethtool_set_eee(struct net_device *netdev,
>  	return 0;
>  }
>  
> +static int igc_ethtool_set_mm(struct net_device *netdev,
> +			      struct ethtool_mm_cfg *cmd,
> +			      struct netlink_ext_ack *extack)
> +{
> +	struct igc_adapter *adapter = netdev_priv(netdev);
> +	struct fpe_t *fpe = &adapter->fpe;
> +
> +	ethtool_mmsv_set_mm(&fpe->mmsv, cmd);
> +
> +	if (fpe->mmsv.pmac_enabled)
> +		static_branch_enable(&igc_fpe_enabled);
> +	else
> +		static_branch_disable(&igc_fpe_enabled);

I don't think the API is correctly used here. If there are 2 igc cards
in the system and one gets an ethtool call with pmac_enabled=false, it
will break the static branch for the other card. You need to use
static_branch_inc() and static_branch_dec(), and react only on changes
(old fpe->mmsv.pmac_enabled ^ cmd->pmac_enabled).

> +
> +	return igc_tsn_offload_apply(adapter);
> +}
> +
>  static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
>  					  struct ethtool_link_ksettings *cmd)
>  {
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 44e4f925491f..396410522e01 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2618,6 +2618,15 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>  			size -= IGC_TS_HDR_LEN;
>  		}
>  
> +		if (static_branch_unlikely(&igc_fpe_enabled) &&
> +		    igc_fpe_is_verify_or_response(rx_desc, size)) {

FWIW, the igc_fpe_enabled static branch is kernel-wide and does not
necessarily mean that FPE is enabled on _this_ NIC (that would still be
adapter->fpe.mmsv.pmac_enabled).

I don't think it's very safe to call ethtool_mmsv events when it doesn't
expect them (pmac_enabled = false), at least from a maintainance perspective
it would be easier not to do that.

I'm just ballparking this, but I think igc_fpe_is_verify_or_response() is
also just a bit more computationally expensive than just checking
adapter->fpe.mmsv.pmac_enabled for the "normal" case where FPE isn't
enabled, so it might make sense to add this as an extra check anyway.

> +			igc_fpe_lp_event_status(rx_desc, &adapter->fpe.mmsv);
> +			/* Advance the ring next-to-clean */
> +			igc_is_non_eop(rx_ring, rx_desc);
> +			cleaned_count++;
> +			continue;
> +		}
> +
>  		if (!skb) {
>  			xdp_init_buff(&ctx.xdp, truesize, &rx_ring->xdp_rxq);
>  			xdp_prepare_buff(&ctx.xdp, pktbuf - igc_rx_offset(rx_ring),
> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
> index f0213cfce07d..52ff6f324d79 100644
> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
> @@ -1,10 +1,153 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c)  2019 Intel Corporation */
>  
> +#include <linux/kernel.h>
>  #include "igc.h"
> +#include "igc_base.h"
>  #include "igc_hw.h"
>  #include "igc_tsn.h"
>  
> +DEFINE_STATIC_KEY_FALSE(igc_fpe_enabled);
> +
> +static int igc_fpe_init_smd_frame(struct igc_ring *ring,
> +				  struct igc_tx_buffer *buffer,
> +				  struct sk_buff *skb)
> +{
> +	dma_addr_t dma = dma_map_single(ring->dev, skb->data, skb->len,
> +					DMA_TO_DEVICE);
> +
> +	if (dma_mapping_error(ring->dev, dma)) {
> +		netdev_err_once(ring->netdev, "Failed to map DMA for TX\n");
> +		return -ENOMEM;
> +	}
> +
> +	buffer->skb = skb;
> +	buffer->protocol = 0;
> +	buffer->bytecount = skb->len;
> +	buffer->gso_segs = 1;
> +	buffer->time_stamp = jiffies;
> +	dma_unmap_len_set(buffer, len, skb->len);
> +	dma_unmap_addr_set(buffer, dma, dma);
> +
> +	return 0;
> +}
> +
> +static int igc_fpe_init_tx_descriptor(struct igc_ring *ring,
> +				      struct sk_buff *skb, int type)
> +{
> +	struct igc_tx_buffer *buffer;
> +	union igc_adv_tx_desc *desc;
> +	u32 cmd_type, olinfo_status;
> +	int err;
> +
> +	if (!igc_desc_unused(ring))
> +		return -EBUSY;
> +
> +	if (type != IGC_TXD_POPTS_SMD_V && type != IGC_TXD_POPTS_SMD_R)
> +		return -EINVAL;

It should really be sufficient to guarantee at compile time that the argument
is valid (it never comes from user input, so it's not hard). Error handling
for a condition that can't be triggered shouldn't exist, except for the
very specific case of future proofing loosely coupled software components
(what one would call "API", not the case here).

I guess a concern is what happens when, for any reason, you add a new
type of packet that you can transmit, and igc_fpe_init_tx_descriptor()
isn't updated to handle it yet. If you make "int type" a proper enum
type, the compiler will automatically warn when an enum value isn't
handled in the "switch (type)" block, because there's no "default" case.
I think that's actually better than finding this out at runtime, so I
would recommend using an enum for stronger typing.

Warning: it's still only a hint and thus not perfect, in that you
could pass an out-of-range constant literal like "42" and the compiler
wouldn't warn.

> +
> +	buffer = &ring->tx_buffer_info[ring->next_to_use];
> +	err = igc_fpe_init_smd_frame(ring, buffer, skb);
> +	if (err)
> +		return err;
> +
> +	cmd_type = IGC_ADVTXD_DTYP_DATA | IGC_ADVTXD_DCMD_DEXT |
> +		   IGC_ADVTXD_DCMD_IFCS | IGC_TXD_DCMD |
> +		   buffer->bytecount;
> +	olinfo_status = buffer->bytecount << IGC_ADVTXD_PAYLEN_SHIFT;

Still some FIELD_PREP() conversions to do here?

> +
> +	switch (type) {
> +	case IGC_TXD_POPTS_SMD_V:
> +		olinfo_status |= (IGC_TXD_POPTS_SMD_V << IGC_TXD_POPTS_SMD_SHIFT);
> +		break;
> +	case IGC_TXD_POPTS_SMD_R:
> +		olinfo_status |= (IGC_TXD_POPTS_SMD_R << IGC_TXD_POPTS_SMD_SHIFT);
> +		break;
> +	}

What I just said above is a bit diluted by the fact that this doesn't
have to be a switch/case block. It's just "olinfo_status |= type << IGC_TXD_POPTS_SMD_SHIFT"
(also, parentheses are not necessary).

As a mere suggestion, I would write this as:

	switch (type) { // "type" being an enum
	case IGC_TXD_POPTS_SMD_V:
	case IGC_TXD_POPTS_SMD_R:
		olinfo_status |= FIELD_PREP(IGC_TXD_POPTS_SMD_MASK, type);
		break;
	}

> +
> +	desc = IGC_TX_DESC(ring, ring->next_to_use);
> +	desc->read.cmd_type_len = cpu_to_le32(cmd_type);
> +	desc->read.olinfo_status = cpu_to_le32(olinfo_status);
> +	desc->read.buffer_addr = cpu_to_le64(dma_unmap_addr(buffer, dma));
> +
> +	netdev_tx_sent_queue(txring_txq(ring), skb->len);
> +
> +	buffer->next_to_watch = desc;
> +	ring->next_to_use = (ring->next_to_use + 1) % ring->count;
> +
> +	return 0;
> +}
> +
> +bool igc_fpe_transmitted_smd_v(union igc_adv_tx_desc *tx_desc)
> +{
> +	u8 smd = FIELD_GET(IGC_TXD_POPTS_SMD_MASK, tx_desc->read.olinfo_status);
> +
> +	return smd == IGC_TXD_POPTS_SMD_V;
> +}
> +
> +static int igc_fpe_xmit_smd_frame(struct igc_adapter *adapter, int type)
> +{
> +	int cpu = smp_processor_id();
> +	struct netdev_queue *nq;
> +	struct igc_ring *ring;
> +	struct sk_buff *skb;
> +	void *data;
> +	int err;
> +
> +	if (!netif_running(adapter->netdev))
> +		return -ENOTCONN;

Have you seen a code path that would require protecting the transmission
using this conditional?

I get the feeling that this is defensive programming when we could give
guarantees in other ways. But maybe there are some race conditions I'm
not seeing.

ethtool_mmsv_send_mpacket() is called from ethtool_mmsv_verify_timer()
and from ethtool_mmsv_event_handle(event == ETHTOOL_MMSV_LP_SENT_VERIFY_MPACKET).

When called from ethtool_mmsv_verify_timer(), it means the verify timer
has been armed, which only happens if (netif_running(mmsv->dev)). After
netif_running() becomes false (aka __LINK_STATE_START is cleared, aka in
ndo_stop()), you have a chance to call ethtool_mmsv_stop(), which stops
the verification timer. I see you're not doing that. Is there a reason?

> +
> +	ring = igc_get_tx_ring(adapter, cpu);
> +	nq = txring_txq(ring);
> +
> +	skb = alloc_skb(SMD_FRAME_SIZE, GFP_KERNEL);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	data = skb_put(skb, SMD_FRAME_SIZE);
> +	memset(data, 0, SMD_FRAME_SIZE);

skb_put_zero()

> +
> +	__netif_tx_lock(nq, cpu);
> +
> +	err = igc_fpe_init_tx_descriptor(ring, skb, type);
> +	igc_flush_tx_descriptors(ring);
> +
> +	__netif_tx_unlock(nq);
> +
> +	return err;
> +}
> +
> +static void igc_fpe_send_mpacket(struct ethtool_mmsv *mmsv,
> +				 enum ethtool_mpacket type)
> +{
> +	struct fpe_t *fpe = container_of(mmsv, struct fpe_t, mmsv);
> +	struct igc_adapter *adapter;
> +	int err;
> +
> +	adapter = container_of(fpe, struct igc_adapter, fpe);
> +
> +	if (type == ETHTOOL_MPACKET_VERIFY) {
> +		err = igc_fpe_xmit_smd_frame(adapter, IGC_TXD_POPTS_SMD_V);
> +		if (err)
> +			netdev_err(adapter->netdev, "Error sending SMD-V\n");
> +	} else if (type == ETHTOOL_MPACKET_RESPONSE) {
> +		err = igc_fpe_xmit_smd_frame(adapter, IGC_TXD_POPTS_SMD_R);
> +		if (err)
> +			netdev_err(adapter->netdev, "Error sending SMD-R frame\n");

Can you please rate limit these prints?

> +	}
> +}

