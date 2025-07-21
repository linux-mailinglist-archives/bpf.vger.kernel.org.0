Return-Path: <bpf+bounces-63919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D771BB0C66B
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 16:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B5F160C1A
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 14:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7268F40;
	Mon, 21 Jul 2025 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TxRA00b5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BLL8E5um"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC25718DB0D;
	Mon, 21 Jul 2025 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108393; cv=fail; b=jtev0pJ+Vgx34uc/WHWvIr0Qwk/VpEROgheqm4ze9PJObKpcbIW3+37HMKgPx2rY608PceyauBD+qUlr+maE72rb5y6HuyXUZrq8CmekZ0zvGz+cJC/c2P75UDDft4wKRbqxxe25HE1O9SFnxagBYMkw/Hvl1019+Go947C1okg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108393; c=relaxed/simple;
	bh=gTHkhPh3+K3Wkzgm0w7cdv+4pfmTezhiAcNu/9CBvB4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 Content-Type:MIME-Version; b=PfJbB9yVWm5lzuSpZD3YGfg8LYSqUNPpcbrrlLAjrJbDzUthHvmv+vMwnR0lWCRtKXCoQR9N+tLFHPlBisOlKNRHm7nW9RYniKBrrl3t9PjQFF8DIMnshHMlkAcf2rmByXB1hXfPe8y5ugqN1TPyB9odho+Ib7DWKyhzSqxoAFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TxRA00b5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BLL8E5um; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LCMlN6025680;
	Mon, 21 Jul 2025 14:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=N7k4KM5BbRL+uYEuNR
	4MT8qMifkHcDfsbfmhXci1Lbs=; b=TxRA00b5FkVOKbQkRoijgDUn8pTldhdmNY
	JKSeL0aIaFHduOVJjux40g0HdeX46/IJd3FwXCrlpIGWkejWf0LzNF8vrm9Lyxul
	E55Jw70VMy9t6vH66wh4Pb9N/g47e3FCFrL5WE+lFlCa25NcxcLtU6sq99Ao5IGS
	dyoe1Gmkd2BSbG+rHXc/G66ydFly7p8p24Sc1Kesdf+E8+usAgMvKK4YYiSV1k20
	MOk9aoiGrbHAWNfplL8uoD/Uf1RzmuJyQON3lU9//2BibWS3P+Ch31FgJHC52hAA
	oiM+uQ5LLbq5V/D4BFUsXjYLp8V+OP/7vsU15hyFlBpfxxQ8kBFg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805tx2twg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 14:33:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56LDsI9P011304;
	Mon, 21 Jul 2025 14:33:03 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012064.outbound.protection.outlook.com [52.101.43.64])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801t83v9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 14:33:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfXf+mO7yXEVG5POygtHNFdC8cz024lVz9lLOr5gVXJCXy61TUh+hYLJkE9Do8WJL8IVy64zz9QZdfz0uF72A2EqeguiLj7UoOh3eNH94WDFjkjndhl20mguC2k58iuJeh+q/E1HlNigH4p0+/TXKt+NFdV1i6kPdCBhJ1wmST/nJeS3Z7EgMl33aeSbjwwNDhC5usZ9w5U7y46b5LGN/WzwdjMSExNm0qfrIWA1bLWvi9TUIx/EAhGYMw+q2nUZjou3FXQtz1s21Zt0trwy/MQ7n2NlNkyuV8DKF6uJy6gOymdbxF60PCOZWzxnfvh5Ih2VSP/ajwqxhaDOhtQtJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7k4KM5BbRL+uYEuNR4MT8qMifkHcDfsbfmhXci1Lbs=;
 b=TdUI3dtfKJCaHI9dwoAw18ism9RABNUZ58yyiSUMWrdsEw2j3MqH7Yof6pk5Iim/k6Uyc+F5ZrX055inRyyG/nO7YKwly4fI/VXOJWmqredMqa1NN/mvJDoSO66sslC7IRC4tysTbiENkVGFjBEn8loqGQeaF1LAdbb/In2LxX04dvGcntuzm8lghQjGmyc38Fc9GJiXPt34S2HnF8Qn4xQvgeY7JunKBrWtGChdjRDrTd6YZDT/l6pNREUqmgAEiCMl/OlX0mfayowVXQkg+yuKDrhyMtxDZ3u3FeURuwuzXIy53ghAdMMiCgn1/thVdyZUOxss9RC6FQPIftQsDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7k4KM5BbRL+uYEuNR4MT8qMifkHcDfsbfmhXci1Lbs=;
 b=BLL8E5umMibaOQtf0EiQ4DYJS1eOak8Ejp3BnsUjyz5B254kqLDMoIsAKJO7o+OATr4upwA2NL9Tbanb4cR+zez3yZAugTn1p0XAWjaeRLH0L/0d37fIkOUNTvbXyH9O8oH1sZxsYEmmzdfj482vtPJFPy47B/9pzxGJrUK728U=
Received: from DS7PR10MB5037.namprd10.prod.outlook.com (2603:10b6:5:3a9::23)
 by SJ0PR10MB5582.namprd10.prod.outlook.com (2603:10b6:a03:3db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Mon, 21 Jul
 2025 14:33:01 +0000
Received: from DS7PR10MB5037.namprd10.prod.outlook.com
 ([fe80::824a:572e:d9d7:e9f1]) by DS7PR10MB5037.namprd10.prod.outlook.com
 ([fe80::824a:572e:d9d7:e9f1%6]) with mapi id 15.20.8901.021; Mon, 21 Jul 2025
 14:33:01 +0000
From: Nick Alcock <nick.alcock@oracle.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
        Arnaldo Carvalho de Melo
 <acme@kernel.org>,
        Menglong Dong <menglong8.dong@gmail.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov
 <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song
 <yhs@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Eduard Zingerman
 <eddyz87@gmail.com>,
        Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: Re: [RFC dwarves] btf_encoder: Remove duplicates from functions
 entries
References: <20250717152512.488022-1-jolsa@kernel.org>
	<e4fece83-8267-4929-b1aa-65a9e2882dd8@oracle.com>
	<aH5OW0rtSuMn1st1@krava>
Emacs: the road to Hell is paved with extensibility.
Date: Mon, 21 Jul 2025 15:32:52 +0100
In-Reply-To: <aH5OW0rtSuMn1st1@krava> (Jiri Olsa's message of "Mon, 21 Jul
	2025 16:27:39 +0200")
Message-ID: <87tt357gx7.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0154.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::15) To DS7PR10MB5037.namprd10.prod.outlook.com
 (2603:10b6:5:3a9::23)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5037:EE_|SJ0PR10MB5582:EE_
X-MS-Office365-Filtering-Correlation-Id: 66597e6a-c5fd-4119-e18c-08ddc8637e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SJsVDYLTM5H0F8X5SorL9wLon3JHO7rGo0iOWZRcJ/Ln/qnV/zm5PJOHvqxa?=
 =?us-ascii?Q?Wzk/2SorXtpP1nQbnVgbiMre6jqaVPP1TACSlo2InZwB8kY9+zj3kWsoEC/K?=
 =?us-ascii?Q?JTowmoBtLx9MTX8F5RlEaCYdhjnTKV/EJyjvSa/coypJhqgjVi8c6+/QFUoE?=
 =?us-ascii?Q?C+/dzrR5OSe+rOmZZGdnqoUhSMeVwmb4kdmAwJC2emXJcDojAmZez0TLR0uO?=
 =?us-ascii?Q?AGQpDd2JGkNB/BwAWZkP1mt5GXGRdEmEM4ddA2oJ+shN8QcMTa9YuNSw5+QT?=
 =?us-ascii?Q?j1Z5acikuSKuMk+Ps1lIMRHaE7Kigc4E5fopthvrFeuSRCYlIySHHkK2HjEr?=
 =?us-ascii?Q?j/hV5gzPYnV0KqXVFxr8jGcP7LK1ExlOnaqw+CR4j6mkpLDqhX3pMB37IVe7?=
 =?us-ascii?Q?SJw+l02qk+D7miIFWxmhhqF/iDx5Zqr/QTbS/M5XtzFW8ENnfYtZNt5F9QDh?=
 =?us-ascii?Q?AYY6T2SMe4MU8wtZjntVS1GAvAEC3sZmCaneRsEwkAzmvCLXiFNHW/xHvVg/?=
 =?us-ascii?Q?rMBxGgMNxUKeGpxBpy/mNCuXuZaz7Ltsk9/4P2lR0MljaPEJYBMfYcydJ05O?=
 =?us-ascii?Q?QPK/Myk4Lc4PvKM8Br6f29XqJ2yV6s8O4BvgYGm7vDSKoG5ZDr+qAwg0AOuu?=
 =?us-ascii?Q?18TnvNZPpf6G87aktPvL5m/htPnwYb/hsn/c+w/OIYakL3bfKLIFAXLnWb1y?=
 =?us-ascii?Q?5Zhbu6SPBQP7vwJvnErKgaINA2S6mFye+V6torDIB4C1JVpzMvpS0n6qyqda?=
 =?us-ascii?Q?WVtPZfmosu3eiO/vZgSizIx1+AeP8wCVBlN8MrAywhBVkfCvRPw5QgQxd8aa?=
 =?us-ascii?Q?GNym874tS0GsX5tiSnDCOKkH2V+Hcpan5hZwZnLIPrCQIWXjHyChPDgH3mx3?=
 =?us-ascii?Q?vwNcYzD1MOKL1SpwVWEKxq8F82l4ygH5ANBwTbEKuYdzOqgIceN13tRAqlCY?=
 =?us-ascii?Q?HXiLRetKlf479XIRPDsBWNcm+UN4hbjdIKr2D/MdV7sefV/mbYcS9/5PhnPW?=
 =?us-ascii?Q?Tfc+yA+zza8Hbb5X6hQZAll4owUZMzSo+m1xKk5RdEZ7tkFjGO9WO1/qixsT?=
 =?us-ascii?Q?Aybx1zsekMXUkJG+xaTP7ZEI6tSu3DSUFSAiAnVtoiZVa0Bfr1pA3GOZ7gpt?=
 =?us-ascii?Q?ZQUNQ4mYmSJvQSn/Zj68lDb7nMV7PQl4gLHKtJZoLJn/vlfqZT37vDUdHpoT?=
 =?us-ascii?Q?zQBXpzYLGt9CIW0+z+83VZFheQw1xDWScYT4d9QrEYrPkfSNRW26hY19dt/Q?=
 =?us-ascii?Q?UZxL5Fsl5pcthEDwytT6v/3/52ixqpsXyje8uaBRrB7WgKlvMgtFy8E9o1k7?=
 =?us-ascii?Q?Um3hHs6gtNRWAaB2+bdumpyX+G9PuRzCUFoIu8QZe4GhxHOr7s1eSPFlboJp?=
 =?us-ascii?Q?72fur226jvBlyn/d+hIdOabHsLF3ajTRdNGOmBIZZF41KvK+RnhQ7u9lTnM2?=
 =?us-ascii?Q?4ZaSKZVqer4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5037.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FhhzM9zDxOwgG5kKh5fEslhcMZmrolXM6kfFtJyKyIjtKfSmCPHaUszanNot?=
 =?us-ascii?Q?goKbUCKgcRTnOBFaOZx6eueqFFPxEtVjlaGWpeoCgAmRyUxSgbFiBemznL9b?=
 =?us-ascii?Q?uZ62GW5PSUu50V2JZJnREEmOAeyQcYVSpeBm4iZeANEq9GfkOygRhveu7ERW?=
 =?us-ascii?Q?d/42AUTbE0bCp8xPoUKPcH/C+KRIj96NOlVlXBGPsA2yfiQ+NnFpOxYu1szh?=
 =?us-ascii?Q?AGZxBMqGtLsgC3dTq6mJrjk86PW3g98z6n8ecpKB4tT3CVYONdzOGAg6XwaH?=
 =?us-ascii?Q?foFpPy5FSgYCrR4mZmzU53Z1H4XBO3E3c8pqs8/sG5XG5RK/7FWCtLIf/xrN?=
 =?us-ascii?Q?bGpp+Tmfgna0WmBp6LrjiNORL37YQPcC5AGmFVB+prn/GQCMqFTGBFYfPhOV?=
 =?us-ascii?Q?B3fU9Wp2dKNxnJyOEqHoYug38GTEflJIHzuzlwWZdeS+ed9IQcyBBchbYkb9?=
 =?us-ascii?Q?aYFNUjAeDAaxhG3jf6kEnKC7DO+00WbKdt5fD9AAjJtF3jqvC4E4aFKNflx9?=
 =?us-ascii?Q?fmURDk8/je/3N5PmR5RZHUCyocvkVeU2Gc2unlFdeORbtauB+LqeQ17Zjpzz?=
 =?us-ascii?Q?WrlfgByPzc4J1jC8WDICNEyLkjJngg37DVU7U9JcM0LzU1eMuwzVyw+Ovfv/?=
 =?us-ascii?Q?mjMq1fAgcTkDqV1zfRUlH8Cl8WaVbPdNAKU2q+lMyloo6UoY3edVSInJpjb9?=
 =?us-ascii?Q?96sH1pf9/VwjJ15A7E/yJYpTjSKxBuSGw5Mc6OpVw8hXpbM3vJk7ocxBJZCS?=
 =?us-ascii?Q?4TUztL1SDtgxOYhn53nm3opBShwLM0UgwiFNaCrMMd37rl4YslEKiVxKKU1H?=
 =?us-ascii?Q?IyWoouZldBekmcVeavT5Uu/hJQITX2uEZZ42dScp5xnlq9IC75bfMRi6owUU?=
 =?us-ascii?Q?+8midYlmn3VB+Rl5ByCUEe2NbB3OYyetlrcRVnVSqhzJfWc9WacmZ945yzla?=
 =?us-ascii?Q?CgMu3fzYr4Bu3+UMj+YJPd5zUAKGOdyLQe+f1WTWIB95Q9PoL9IyT1Xy2+JH?=
 =?us-ascii?Q?j6e8JB2Rmz2J8T7mc1BPvJc6JrgFfY09V9qeBB4vIsPyBvq14pKDCuAfidgi?=
 =?us-ascii?Q?uZfplzane4lsXf4J9jEyZtLQ5eaXLbTU4Zvw/Dg9ypVl6/yNZHhiVIIeaMc4?=
 =?us-ascii?Q?xRzOzVjsBC/ivOm9n3y+K9MyHMBvS9FqZeP5fdix9in+6Wncfc3Aj5YEQk47?=
 =?us-ascii?Q?gy1Y6PRmbDU3b7eEhx3Eqro48Nk1ayuhW76j0dsO7UVIPQ1CQgddtZaRnXj7?=
 =?us-ascii?Q?xdmy04PVHKxhVarsLGGOR+p47oFFR/sDRXDQBE3LsR7G/dHpIpJcYYe/cI2u?=
 =?us-ascii?Q?TXisHp+cmuvqoge5WS9LSPLVGP4vrbpYgPlsEg/GigrpciXcDxPWNyoyiL3n?=
 =?us-ascii?Q?a3+HGftM1Wf1gxxgx4bfDbA52rqirJzD5BfvDeWqAAtCGu00eIw94/wu9LI+?=
 =?us-ascii?Q?w9aOcdR+kanigjr3Ld1BQDU2BK9kDvx5qkhcQem1bZai7VFZ8g7idqtBawXc?=
 =?us-ascii?Q?4p14TmCsLtK/VCAAfe4cAo5d+2IHwHI4fHYdPU82VbO2FINDOqiZh6wd9zCK?=
 =?us-ascii?Q?LpnUKaoJk4K5bewfPyBWB5ordfOUa1kXSXoCcJw5SYtvBkNTYw3FMj5mz/Xw?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Vy7hhTAhW+R9ABJvInZexqd9kxHIZ5m1rqIg5yYg9DwX6MFqL8uNhPmYunMr3txBB7UTWUa6F3zgI8cWqwhG0mp+blTNi6v9sUfeZsITao9biaZ3+CKUxiNt3yW7CZgiMyZLsmA6u6fs6tD6pHfz2h601o0Sw6M1SKt/740i8JZ9ygo3/V+ztps0zOLzrjbgpDz8vg6pDiQ8Rj2PeL7wZqE+cm7Qn2bWqKndtvbBDqHsYbuyy+d6FlNkOCE16JPCV/8+TlWbCCSvTK7zKHXdTJRRi6gpxu7tpbh2iPZRBNrCCq5oTuQsCAooT0IEDw1st4ze13oPGGZoyVfBGhrzfCF4qwELo5QfWfnPqWS1gqd0w7+zTp7Q9Ro0aWhp0iIJXTEnsh2cqRL9rA7ACMz9LTg1mPTgYa2fbGjPSMi+pL9bIEgQ8AEzEAGyFj+KKjZUmgMDN506newrSLG59rm1Xrr6ZZLJTVYUfuD599pYPmzkGVBWVfSl/MVa661TONWYvDTqXs7D17FE+MoTJa7LKr/nt8cckIGBECAhEpr0WQAff04LSLj26aX8I678rotxaiX9zAO9iRoOPYlyb5+dzmiUUstkyDFI+89ocZTKqXI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66597e6a-c5fd-4119-e18c-08ddc8637e3f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5037.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 14:33:00.9750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZnME7YBjD3P24EMlF6sqgvoKs0PgEMKEn2QMwf4FE9+6a8lBhiB/Q4dqiHT5J7o3SFFA9a1Zv5SRzAidlC8bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=738 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507210128
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEyOSBTYWx0ZWRfX2vis/JUZNzl6
 ZVg4yHPKSvbLCb+ibXB8eeF+cMr4KyKsBOP8ZZr4yHJFIqlH/4+wr43kD9C3oRx8PChiGNNL8xw
 k//gJ5oNQc8TT878gwMXzRDoguaFa3OnVoZf/FmxVTBljMir7jnZcJZ3ZG2n+XO3xisQrhCrjro
 ECN4J2FxMiwsFvMeLZzF4+K/VtwxXCySLWH79BDvVbQ8CcwNdRSTVZOOde9CPPFKoDGUHjpLNLp
 tzeY3csdacSZu9voWR2CRCQSd7k4+8cy4evYlCNmfMLA4Cq5heQ8Dupkyk1yYKStlQotRtpd82m
 ftu50O8LSqhFQ32xvStwvtmUmVFDXqXNSTJ3twOlI/gTWFWt00MpCTXG0k5D/7cjfmoEv2JE2s3
 m62e5wU5ooqM0DBQg0y5EC10YQD9osjAOUSqr2p2CzfYscZOJFCFl38D2zx69niZOBlYzqjH
X-Proofpoint-GUID: 5D3l7Jbzlu65IpeEtcOYViU3glE4DVwi
X-Authority-Analysis: v=2.4 cv=IsYecK/g c=1 sm=1 tr=0 ts=687e4fa0 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=1jOC_TAtMhZs1W1ZQeMA:9
X-Proofpoint-ORIG-GUID: 5D3l7Jbzlu65IpeEtcOYViU3glE4DVwi

On 21 Jul 2025, Jiri Olsa verbalised:
> On Mon, Jul 21, 2025 at 12:41:00PM +0100, Alan Maguire wrote:
>> On 17/07/2025 16:25, Jiri Olsa wrote:
>> > Menglong reported issue where we can have function in BTF which has
>> > multiple addresses in kallsysm [1].
>> > 
>> > Rather than filtering this in runtime, let's teach pahole to remove
>> > such functions.
>> > 
>> > Removing duplicate records from functions entries that have more
>> > at least one different address. This way btf_encoder__find_function
>> > won't find such functions and they won't be added in BTF.
>> > 
>> > In my setup it removed 428 functions out of 77141.
>> >
>> 
>> Is such removal necessary? If the presence of an mcount annotation is
>> the requirement, couldn't we just utilize
>> 
>> /sys/kernel/tracing/available_filter_functions_addrs
>> 
>> to map name to address safely? It identifies mcount-containing functions
>> and some of these appear to be duplicates, for example there I see
>> 
>> ffffffff8376e8b4 acpi_attr_is_visible
>> ffffffff8379b7d4 acpi_attr_is_visible
>
> for that we'd need new interface for loading fentry/fexit.. programs, right?
>
> the current interface to get fentry/fexit.. attach address is:
>   - user specifies function name, that translates to btf_id
>   - in kernel that btf id translates back to function name
>   - kernel uses kallsyms_lookup_name or find_kallsyms_symbol_value
>     to get the address
>
> so we don't really know which address user wanted in the first place
>
> I think we discussed this issue some time ago, but I'm not sure what
> the proposal was at the end (function address stored in BTF?)

Function address, translation unit name, *some* disambiguator. Really
both seem like they might be useful in different situations.

-- 
NULL && (void)

