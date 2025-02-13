Return-Path: <bpf+bounces-51408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6A1A33FB4
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 14:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1555B169898
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 13:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEED221714;
	Thu, 13 Feb 2025 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dMMw9Tzh"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com [40.107.20.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D722135BC;
	Thu, 13 Feb 2025 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739451613; cv=fail; b=Vd795aFjD0qFVa4WgAs8fm7qopWjGStwYnMofCgvzx4J1ypj6NkWa88DlpClZG64e0dcnyh7g8d5Pw4zlX4slzA1s/CyS6BXexGZnn1ZpoY9OPmhj3UPAFnOXXKbnnW3SMiOG/D0uQM0WqyAxfs6X60L5r3eeXwm87Ei8C1XwBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739451613; c=relaxed/simple;
	bh=5p/FEEorIetIxpaXeqAHyBOj6opb5XynNL/ZudSKp6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kLqE8oihFE/KRdTkgqdx0p1BnbCgvvwQAfn9O2Z4xQJJ0SKQNl9XA17MRSWOzwhXsX3t+zGQ75jPWgV5w8Jr0Q1LHbvoPEiV8TVphJ2IR5J4/eRjfh/9wo89z05bxMfYIgeH0X+KV6nbBp7ihvxDJ+j4vUAgN6EUZ2O2kU2VEkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dMMw9Tzh; arc=fail smtp.client-ip=40.107.20.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awwrS311NJLbqMzlCpeOWo8XCbl/N7e8reyBj+orctjNHzK/+tJ/qayKOSHdIlerpvRr3KWcCZRJiJiJ9vXThoZjn1uCiIiLq4RHn+T2AUjsSczcI8w/diWq91dSyZKWcXNC4pmVbrzm9Wj0Kny2VsiLRDE0d2dclWz5TaGF51rERCjiZ9qCLkDh8uyqxeiQ8IjKdiMPcwqiXcHIybH7iysmPW4147mCXDdXL+2YSjnNKBUc+mP4mp3Ta4VTZyOk8vfMNLJz2fpJeZJNa0by/jI1YY1hDnJ+dHhCVCFLiEN45NfcnvgHQ4klfAHvmWCdTYk5cTrIMNdtvTxxroDb/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrKxg1XQ4fCyN2OVZOnmTYc/fM09F2tvH4+LyizwIFk=;
 b=B4b25u1iey+ASjQT/RUJbYvr0JF99WYxXqKRW1vbOCoR8frZddCKGoZpy76WYhIYrbCDZ7WuEOKD8Otm4xk8NIZAd3ykrx4IurOsguVTZyyWKhzhpSN8HPxRCDQkcb99sy1yDK/t/5hwtO/0QWNZ+8i95Jyo/kikXuoGcVv/ltRPX0nuYUfJ7wxjED5awlP8oXrL2G39/XEVcriwbCxvsWptMS6vf8pdLXBgE7W6CM72sDHFp4ERjWJ4MBgptkfB3NM5+VUZjrQytzbuDXquze1osdovm1oGtN+qv/uhMxhmc+5IeNiDSIJaHfeMQjL/Ps2nQr4EfrR/ipbrunEDWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrKxg1XQ4fCyN2OVZOnmTYc/fM09F2tvH4+LyizwIFk=;
 b=dMMw9TzhoB+DXL6GXITnUwBHZGHHtU1RA0hQfKjIbBOf+hNJ+g/ogsrRycQYJritmDi/77D6LGaru18eO5lgTgslX4FaCapspYdwMB/XB9PIuC+lKlYKPoNrmkG88wuiXSFQftDNeue1xcYAEWitOYFsWkoBUQVkaKGQBtCKv/E2VT8uQzyOF1edFHjZUE2z7HCjAj0ucNalPqqscS5O9jVOR4Rtmd8SRMKcxg4+IllZA2Fj3/BGMyDQqWGkAE/uRKT7sKSJ2T+w4VRZ4q4ZQTtug9boYe9AE/Buo/nvqc3m9TZl1yo8XQ1Ki4Srk6nIrB8vxFXXY5XQVFgaoaB+ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB11059.eurprd04.prod.outlook.com (2603:10a6:102:485::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Thu, 13 Feb
 2025 13:00:08 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 13:00:07 +0000
Date: Thu, 13 Feb 2025 15:00:03 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
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
	Andrew Halaney <ahalaney@redhat.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next v4 0/9] igc: Add support for Frame Preemption
 feature in IGC
Message-ID: <20250213130003.nxt2ev47a6ppqzrq@skbuf>
References: <20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com>
 <20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com>
 <20250212220121.ici3qll66pfoov62@skbuf>
 <b19357dc-590d-458c-9646-ee5993916044@linux.intel.com>
 <87cyfmnjdh.fsf@kurt.kurt.home>
 <5902cc28-a649-4ae9-a5ba-83aa265abaf8@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5902cc28-a649-4ae9-a5ba-83aa265abaf8@linux.intel.com>
X-ClientProxiedBy: VI1PR02CA0063.eurprd02.prod.outlook.com
 (2603:10a6:802:14::34) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB11059:EE_
X-MS-Office365-Filtering-Correlation-Id: e6346f7e-1d01-463c-5c14-08dd4c2e5783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0c4RW5RYTBRNVlMWWdSME9mNGV3Q01wZk5ucHQvc3BVYy90dVd6Z20rYldr?=
 =?utf-8?B?SDROaVl2UmNWcFY1K3hxemxvdWwzbEhIYTI0OFlocllLTi9JYWFleUZzT21Y?=
 =?utf-8?B?dy8zZlJGNWUrV29YRTRNamFkNW5CUFo4aFZtb0swNFZla3BmT21JVEp4aDZT?=
 =?utf-8?B?cVRZVXFCYzJlWFJZZ2VaWnhMV1h1N1Vac0lhMzdPNXRTZnpFQlVMQUgzbnhy?=
 =?utf-8?B?cy9BYUNpV084TkE5eWx3SHQ0clpONTBZU3dnaXJQYW9EY04vOEtIZkZtTk5M?=
 =?utf-8?B?M3NrSlZOTVRxNUJPTFZubUxlVlNtM3MxYWJVYTljU2c4enE2MDJDUmE2WDl2?=
 =?utf-8?B?bzEyVTBYa3RaR2xGWVh3VHRKY2drRlpPNGZ0aWFFS3N3Q1Z3SGwySDVsYmlC?=
 =?utf-8?B?Qm1RaDc5T3M4V3lWL3h6Um84aEtlV0g5ZWRHR3FZWEl1OUdqNW5kUGIwdWg2?=
 =?utf-8?B?V2I3T09PRVNMbzNrbTZqOHhxYlRaVGNMc1hORk5zaWRaZlMyWFpwbzI4ckFT?=
 =?utf-8?B?c2RXdE9UWVFKUU1menNyMDNjN2wzT3BiazJFSnltM3dFMlZlWEprR0psS3VR?=
 =?utf-8?B?S3V3b1BRZUV3K1ZqU0x4NzFzalQwRmZkc0NWNHpTVHlBL2Nkb2hJbW56cmlO?=
 =?utf-8?B?ZUQwRXkxbUdmZ2I0K1ArQ1AyVGlUS002L2kvalM0K2FmZ21NVGhIRno2Zzd0?=
 =?utf-8?B?aE12OEFJTmMwRTZIcU1wdVhZa2RyTXRYKzlnVWFqdDlBenpkdFB0eFZHOEZS?=
 =?utf-8?B?TE1wZ3MvYkNha2xBQlpLUXZUMS9ncVp2RkJ4ZS9FVXBjaGh2WW55L0ZjSXBV?=
 =?utf-8?B?bzExQ05rUDE0Skl2WWU0ZkE2WXRpcnI3ZmFncWprV0IrSWtyQ05WakQ1V1Fv?=
 =?utf-8?B?eG5DckxwYWFJRThjalBnYkVCWjNoVHdyaVdOMjJDYXgvNW85UlNZcFRZMkFo?=
 =?utf-8?B?azcxZ0ZuOWxhZERFN0VhYS9jRWhVOU50dVZtek1rWlA0RUJZVzlIZlI3eTk2?=
 =?utf-8?B?R2h4dHZDOHF6K1lmVDMzZVdqU1ludTcxT0xuVUhGdWlrN1RSaXNVeGYrTndr?=
 =?utf-8?B?MGt5NHk4dEFLQ3Q4bDZ3cVhHeFQvK2JvYWxzbEVWMm52WURwSGd5QzJNZGF6?=
 =?utf-8?B?aG8rc0h1QUhzd1ZtdE1QNjVkaGhWcTRYdkFvNkdWSG5tNERNdTJ1STJJTmpo?=
 =?utf-8?B?SGl1QzBsaEkyMjg2Y3BOZjFLV0JPRGpOS3VJdTVnenVWME5rVHhoaGJBR0ZE?=
 =?utf-8?B?aGNvcVhiSndkNkdUUEcxU0NMWjJHVTFYb3RqZ1dQbGxhUFNuMHZLQ2lFeVdH?=
 =?utf-8?B?QVM2SEN3NjFYZWpyUm11Qmo0aVB4YXhWblIzNVRQdStsbmE0ck0wSkc2WEQx?=
 =?utf-8?B?bnB3VDhSRWxoMjY3WXF2YlRGbGtFSHZISSsvZitycE5IUHY4c1ppWEVlYWZa?=
 =?utf-8?B?WkxoRTVXNGVtQmRRT1NZb3FqVC9vejRQRExQeU80L0d1bk1GNWdHdGlVUHVv?=
 =?utf-8?B?ckE4SUF1eFZuYnlJTGpWUFhGS0pQS05zTENBY29EVU1NdXR1VWY1YmpKb3pW?=
 =?utf-8?B?eTZjV1AwZDFFVzFHeVhLMlVzdk0zT2hoRytsTGUwcCtWdFZGdmVLMFpEeE5F?=
 =?utf-8?B?bWJCVnF6MTVJbDUwRHJCT0Y2bUxtSHVlSG5LcFRtY3RIS2dJTTA2OTBBU01C?=
 =?utf-8?B?M1NtRVBMd0ljSW5TOFlYaWozSTY5NDh4UUp0VDFyT21RL0JsS1h6ZUpDS2h5?=
 =?utf-8?B?ZjRBRzJ0dlYrbk0xRU45TVd2bVdWYXlyUnBvdlZQZS9QS3E0eEtvMnY2SlhT?=
 =?utf-8?B?MkNZdHpWYStlTDUweWg0VWhzY1R0WXRwZnpJTFg3TUxxTnJKbEpWU3doU2ds?=
 =?utf-8?Q?TsnqLqO1hEwjZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2x1QmNhS1g5MFZhVUQ2a05KQlN0dlUyVDdjUHBUaFFhbGZ3SlBaUmFwY0xt?=
 =?utf-8?B?dmllTm11QTZ4UzZZNlVRWkt6VmJEaDU5N3ZhY3ZEY2FUcFlvVEdCM1hGaEUy?=
 =?utf-8?B?MnBrTkFJRmhxSVpkRmtZUTNqSTdyY0tPVUtxZVIzdUpLVVdxQ1lEajk2K1Ba?=
 =?utf-8?B?RlBZZERPNUlOVDBNMDFhS2RWaUppaURLemkxM1czSVFseGVWZGsrL2pCb1FM?=
 =?utf-8?B?eFlkVERwRG82Y3pLUDFxUFhFK2owZlRrOVVnZEF3YXJPdkM1MFIvZWQzRy9Q?=
 =?utf-8?B?ekV1M2xOU1ZvVXE1R3NMM2hOT0ZzdXZqZk1OTnpGNnVZWE5PcCszMnRxNTZ6?=
 =?utf-8?B?WThxVVM0RXFRejRJREtHUktwUXJ3OXhYVVEyNW10SVdnWGp4UGVvSzdkZThY?=
 =?utf-8?B?Z3dScEtXTUFDK1l4YndiL3FmdFpZd2J4YXh1WE5hUWN2M2FmTXdHU2E2T0Zm?=
 =?utf-8?B?QmdraVVoaUFrd2ZERjJCM1Jnam1TaDZ6QWNIWXN2c1UwRFZ3ZDBubXJDWXhU?=
 =?utf-8?B?d1dDMm5RRWdTSGQyQzhWdmRZeEplaDdGRVBxWW56cllwd3JJcGZaUkRwa243?=
 =?utf-8?B?Ti81aks0R1FQeDZKOTJ0WDJUdHIzVi9UcW03Vll6bUIwQys2eVVZN1pybmRx?=
 =?utf-8?B?ZnREZzRKOEhJOFQ3aHlhWnZPa21yU2EvWDkzdDhTb3lVdUpZQkxKVVIzenRv?=
 =?utf-8?B?bElRdVRYRnoxeGZzUDBtSFZQWlBBeG9qMDFGck9yQU14cjhmaHBuNnhUWkIz?=
 =?utf-8?B?QkovNUFZSVhhNzNFZEQ5NmJhN3VoQjg1WWljQ2lHd1dlbVZzSVFFY3lobUFy?=
 =?utf-8?B?aVhudUp2dGJYQXpwa29udlJuazF0eUlxckZKWjVMRnJaYnZSWmoyWGVSOTdr?=
 =?utf-8?B?VXUrQjJMYUgrM0ZCY1lyYTJWbmNpZGlUR1FyRjRtV1dyRTNzTjFyNXF2b3Fn?=
 =?utf-8?B?a2ZOeXhyV2lZaU1JYVArd2xobVNZQUVhYWFna1NYZGhLeVpwQ244NWpPc1JV?=
 =?utf-8?B?QkcvYnllYTZYZUtVdWNJRUhhVXU4TUlOL001MllGMnZsZmRieGR5UXlNVUlO?=
 =?utf-8?B?VEhZUmtCTVBObGJYWUJiNTl1TVNaMUVWWUFiWFNvMWlxKzFuMlp1dDVhdStC?=
 =?utf-8?B?Y2VSWWUxQjFyTVVEMXhrVTdyKzN5M2FJa2tmUVBRd3JPT2xZOG1qNldFNTZ2?=
 =?utf-8?B?Y0luVFdqbUJIOFp4Qnd4aGJPY0d4M2NUOHMvNkthMmRoZ1NrbWpHRTYvU0pz?=
 =?utf-8?B?NTgrdmN4cng5UHk0d20rcFlZd1BGSFdnd3ROUmU3c0JNREYvcjZiQW1GNDRr?=
 =?utf-8?B?ZFV0WHQ2UjBwNTBRYkRjQ1R5S0pvbzBBZno0KzdDWFNIUEdQMEVnbGJlK2lr?=
 =?utf-8?B?bGhwOVVzb1dnVzd5aUxCMnJtczN3Y2hWNGcxNUdJbERYWlR1TzRJeHh6S1Vj?=
 =?utf-8?B?ZEY5RlpsUU5kcVB2cVB5MERIa3RSM1luaDhMR21iZlFrOTNJRi85SDRJd1VE?=
 =?utf-8?B?ODlxZG1UcHdCeERYcHMyT0QrMFVvSkJhVThabDNTR1I0czZWYkhDWEVlUzNS?=
 =?utf-8?B?elNTWmFlcEovc0lOQm9RSGllWGRBN2VmUjJTc1ZjUVhiejRTanNsRUM1RmJ1?=
 =?utf-8?B?d0dUMFBVSEYxRkxaaUJRbUVnczhzRjNSZEtHUHA3dSthK0k5MlFIRFJzcHAy?=
 =?utf-8?B?cXE4R1BWQk4ydEozWStIaGcvZ3FHdGlldFRWRUFtekdTRHVTak0wZzV0SVZW?=
 =?utf-8?B?YWhaM0Y3MVJrNW1yeXdyZUdPVWs1bTZXeWZmd0JnemxhVzFNN0F1WThqcWdD?=
 =?utf-8?B?ajMyUkpqbmdTckNvVytGL29vMVFzSUZGZmVLQ1d6ZVNDaG5rNlMwajRZdkVZ?=
 =?utf-8?B?ayt1Zyt6b3VueHh3ZWJvcnlUcXM4MGorTkNzOWZLZWJkbDJPUkNUQnJyMnA5?=
 =?utf-8?B?NzNoSFhGazVnaG52TUdNRFVSVnhGRVQyTTVJeWpITVhpb21HMjc3Sk5YSjBT?=
 =?utf-8?B?QWRVOFdWaHBLam9rOS81UTFXVkQ1TVVmTnFWSFBnaXh4M1VaMnF0R2xYTjZp?=
 =?utf-8?B?cHJBc3R0ZFBPYWdndytlN2N2MDRERit2amNnMmMybFNOZHhOZDNVam0rYzRu?=
 =?utf-8?B?Mi95NlgySXk5Z242Z25nb3JsVzAzeVVjeEs1cnNHRXFjdWhwYjJZODN2RUNG?=
 =?utf-8?B?dmc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6346f7e-1d01-463c-5c14-08dd4c2e5783
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 13:00:07.8481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: go/mHM3RkXWlsfhJ6VrwwrI9AWczo30LRMk0PSLVTzL5IYNjb5EbpW9gzBmY9cUpKKOkXA7oeMOFpYDPnGtLDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11059

On Thu, Feb 13, 2025 at 08:54:18PM +0800, Abdul Rahim, Faizal wrote:
> > Well, my idea was to move the current mqprio offload implementation from
> > legacy TSN Tx mode to the normal TSN Tx mode. Then, taprio and mqprio
> > can share the same code (with or without fpe). I have a draft patch
> > ready for that. What do you think about it?
> 
> Hi Kurt,
> 
> I’m okay with including it in this series and testing fpe + mqprio, but I’m
> not sure if others might be concerned about adding different functional
> changes in this fpe series.
> 
> Hi Vladimir,
> Any thoughts on this ?

Well, what do you think of my split proposal from here, essentially
drawing the line for the first patch set at just ethtool mm?
https://lore.kernel.org/netdev/20250213110653.iqy5magn27jyfnwh@skbuf/

