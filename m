Return-Path: <bpf+bounces-51220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BC3A31F52
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 07:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A4C188C520
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 06:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E921FF1C5;
	Wed, 12 Feb 2025 06:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="HGDNcowZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951901FE46B;
	Wed, 12 Feb 2025 06:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739342704; cv=fail; b=akT5uyP7yuKdB8SnPzQhzwZHV4AG1FXjqLALfmszdhMeddHWXVYM4vVFiYeeKJ/4BTfKRj3yyGPjTpjxMnMsLSzYlvVp8/ivkBS9Bu8Rhktbi++pbUagHVi+D9+Y7yEDKsF9KmOH0StqPSw+QuQkvUwA3CcEZTOymvF+kx8LV80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739342704; c=relaxed/simple;
	bh=WtXrsNcGNofPITSVOlJuEkdF8aaLi/GBUNuOFzCJVSc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YQsYO7mXlB7sAPuyK1LSa9ZwKPOYcx/tGC1llLkp27XBYeWwgyJRfBDGXwPriChNpPRtMzMfPjblEcbMv3CV+9ZQwYGGunl57oRuDa+xSSrcaGsXuSp4lpbf/K+Gg+Pt0FHoOWaa5YbD6SW/d5nIxrSBWvUAySD8jn+sOJGeG6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=HGDNcowZ; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C41KO6002226;
	Tue, 11 Feb 2025 22:44:28 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44rm8789ab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 22:44:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjS0B4wCbp6g9PjLR3pAnNUc7C8/limvqRvF3hIzm3yedZeBNmZwcWGufRszS28TS2pFmSpoVouMVKX0A7Qa27cj5Fadss6Vh4VRr9l3rGXGIexsYbG4GAN0zfjOONYA6NnvG9J8Ix+8vO085NZqFDQMJF6AwzlAkxdI9tb6IWkiwgAm4PRf6bTtU9i7Y9NvjOoSgGcp/JlgUMJlY6EnU+9WEydFCFgjCxSm2Gu2z5Qo1vaCryF6Jm6kiV6ZmMYvWzllJW6TXQFN7xt5DLn1jJEG9ZaPxTyUBuHVAv967sclroBQopRjg/ZaaFi0USwcNZ+TOEcADm/WuRvEayZRnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtXrsNcGNofPITSVOlJuEkdF8aaLi/GBUNuOFzCJVSc=;
 b=ClucK2jLHDYmolZMdvymMloWUNzQgEdRciS3bTrx7+x928TlS/AedF8uo/kEQmOOFPLoO0O4pZK11MY16OyCtXWndf3z3bZOYNriJ1Muv/ZJyAaw7VmGDjszQBk5snHjkbgcfc6ctHpJjYvT4/OOZnmMGIvLTDH4pP77wj05+JS+8O4Xium+mC5DX9G4xzBUqsjEPbXJNuii3mfN9moCy7Dmf5BELcagWKBht/PBPmdpPi9BhEVaycuhPuVWX35Jr0pp8AvLunUOS3JQJDo6CDpwKSV543YsFaQwKpbVsHXbPYhgrdVA6iE1q3Ye2WOTEMQLXWZXsaP14xoEEj4cuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtXrsNcGNofPITSVOlJuEkdF8aaLi/GBUNuOFzCJVSc=;
 b=HGDNcowZ0ZvKIkvEcnVXHa0H1+h2CdSKOUvytwuvCsyXUkhz66/kXwOKqTU6E6TVqerSb+xeAT25J/TexeRYZua15Ha4BGrfiuhGRgRVEcVldowCHVg8kIr2aenK92QmmnpXrUtHxrYn9HF1tu5+6N71vzKAxe34gJoZxUbAKH4=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by LV8PR18MB5654.namprd18.prod.outlook.com (2603:10b6:408:186::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 06:44:26 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1%4]) with mapi id 15.20.8422.012; Wed, 12 Feb 2025
 06:44:26 +0000
From: Suman Ghosh <sumang@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula
	<gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linu Cherian
	<lcherian@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        Bharat Bhushan
	<bbhushan2@marvell.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "ast@kernel.org"
	<ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "larysa.zaremba@intel.com"
	<larysa.zaremba@intel.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v5 1/6] octeontx2-pf: use
 xdp_return_frame() to free xdp buffers
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v5 1/6] octeontx2-pf: use
 xdp_return_frame() to free xdp buffers
Thread-Index: AQHbeHRMkvDltmfsOk27Y2q9umEI8rNAv/OAgAKCGtA=
Date: Wed, 12 Feb 2025 06:44:26 +0000
Message-ID:
 <SJ0PR18MB5216D06F41966F59F06E6A0BDBFC2@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20250206085034.1978172-1-sumang@marvell.com>
 <20250206085034.1978172-2-sumang@marvell.com>
 <20250210162543.GF554665@kernel.org>
In-Reply-To: <20250210162543.GF554665@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|LV8PR18MB5654:EE_
x-ms-office365-filtering-correlation-id: ffd7b326-ee9a-4a94-04c8-08dd4b30b14d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RVc1cVFMcEcxZ1RCKzA2ZjN3blNtMCtKWTRnbTJ0UHl3UDVDcEJ0NVhJSHNs?=
 =?utf-8?B?TDhpZElhMElsTjQxU09ZSW51cWpJWVRMTUtZaE5sYmt6QUtTcEQ3VEFNUmpm?=
 =?utf-8?B?eE5zbm15K0Q5RmUrdmozZ1packRmQlpZS2xjaVhtZW5hczhqSjZJSlU4WkRQ?=
 =?utf-8?B?b3kxaU11L3FYRmVvd1JOcllOcHZvaTRiMWZReVZQc1c3SjBEN2FoQTNsRGpF?=
 =?utf-8?B?czc2d1VscSs1M2l3R3dDMHV5Yi9vZWdUOU5yRURWN2VHU0VsMVVmL2FMY3I0?=
 =?utf-8?B?b2daWVFPdVd5NDVYeUlJY2NXaWk1aGY2eFh4R2V2NDNUbDFJNXl6UFdYOW4z?=
 =?utf-8?B?VWZ1MnZVRGNOZG5XTENab1JwZzdNZ2FQU3R4SUxoZG1QdkFPS3lyUGx4Z3dv?=
 =?utf-8?B?VTNxWWMvQ3NoT2ZpNFo2UmVnUE5kOXVKN3g3aHNuTVBuKzJMUVlnb1ZJcU1y?=
 =?utf-8?B?eVpGWjUvSDE2WDZGZkp3Q3FrRjZyOFRRLzNMMW9LaGFMbEViMzdxY05GSUEv?=
 =?utf-8?B?Q1d2bVpkZ3BUcE9mMmJNNXFzVzB2QVhwcXJWTFVvUkRkMU5RS3JUSTNYV3Fj?=
 =?utf-8?B?ZXByKzVWQ3FOMzdLYVJKSkVLbWt1ZFhpNnNiOGo3dDJJbWxaUlJSVDBNbkdu?=
 =?utf-8?B?VG9PTGxsbzNlZlJ3TXgvSUc3bGxzaXljVkh3azYybUFxK3JwS2JjbjFLU0l2?=
 =?utf-8?B?SWlCWStIRlhxSDhIRUJ0ZEdHK2d0RDR3ZjdwempPMUJaSFl4VDVLcTZkYVRL?=
 =?utf-8?B?QnFkdTFVWVJVRVVJMkd6eEd5QkFnV1graWFYVmVtaUpSOW9kVFVTcktnTCtw?=
 =?utf-8?B?N1pOMThzSVZ1T0l6dDVFNTdpbUJzNjloWkRXRDR2L2d3NFN3bnJuc1pXOHF6?=
 =?utf-8?B?U0lFbzhjNUQzVEFYYkNaYnZQK1BJZ3NCM2JjS1p3eGNwWDdEdEw2bHIwbElO?=
 =?utf-8?B?ZEdkL1o1Zkp1eDBKV0lnbEV2NXVUbVg1Vlg1YkwveWp4K1RJZkZRclRaT1NG?=
 =?utf-8?B?eG82UTBkWE5lWHZwcno4eUgwcmJHcm9IOUI5N005NnM3SFlLT3NzSGZPZGpu?=
 =?utf-8?B?bVhrekNFeW5QTENzRitBYUlkWHdiUUZhT2VvOHBWRkh6Um1tcWl5SUFEb2p5?=
 =?utf-8?B?K29pK0E4Y2k3V0JVVFJnZ1hwV1VGeXlhemFFOTc1REFBWnErWS84YXFqTXcv?=
 =?utf-8?B?cE41Q0p5VUo5QzRkdEd5WFBlV3h6cGZYMUU2VVYvT3oxVUpSNjdIdFBQVUhB?=
 =?utf-8?B?bU5CUWw4c05sUEFZVWlxbnlRU2J1VVFEN3ExUk1NTCtaTk1VVXNzSk92SzBF?=
 =?utf-8?B?TVJaSjRwc1pDUm1tZ2tYOGo0akRXYXUxTmVubk1VK0tOUjJKQVBYeHpDU3Vp?=
 =?utf-8?B?dlI0Sm9ZbUdxbEpESEs0TnYrTWR5KzJTNHl2bjJ4ZEJqMjF0QU9peURzaXJ2?=
 =?utf-8?B?eFJORHkrU0lMUW80QnVuWXpCbmF1ekd0b0FScElKYVRlMXZ3dUtyRnZhSzJq?=
 =?utf-8?B?RHVYVXpOeHUzUUFyck9oZTdYaXU3aUtXU1ZJNy83dWNjTzRTV2ZyWG5rVTNi?=
 =?utf-8?B?ZVpzRGlYM0F2RXA4eU0wNU5xYTBwWDZ2RCtUK0tkZFFCbHkrNVlTTExOK21Q?=
 =?utf-8?B?VlA3aHdHaE1NbytUR2RLREZQVG4rWnY0Rko3ajJJcXR2WSsyNm1tTkh2Mkxj?=
 =?utf-8?B?QXpMRkhwT01UK25VSXoxaG0ydHpHSytGeWhZMld3bkN4ajhNTXV5UndEWjlK?=
 =?utf-8?B?ZUdIemZSL2R1RmxyQ0VSbXJaK2d1ZzFCMnZGRno2QTBHZXh3Qk8wcDlHN291?=
 =?utf-8?B?b0luaEVzUGp4dFpSM3doVkVYR3lNT0tyejYwS2lXTVEwZmNLYkM4dENodW5y?=
 =?utf-8?B?RjRmQU9NTXJYeGhUTHVkYVZYSzc5NU5EMDhUNW1MRGhBQUlaay9UZkdOaVo4?=
 =?utf-8?Q?G7PdtY9obhF3t9+DHHJDA5bca0hAbxbS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?STNDRmx6VmsxRTJWdDhMVlRaQlhMQmlBM3IxMzZQdlBJZlNEaUFYdHRHWm9v?=
 =?utf-8?B?SkdvOFJXNjROUGx2bGFOM0xhdEtsOW10Z2VkTEV6bFpyMXdud1BaQnZCNTNu?=
 =?utf-8?B?ck1nemFBUGs0djRPNEhPanM2NHhoa3A3VXVnMktKc3MyNUxJNFhVcUVqdDFE?=
 =?utf-8?B?VlVmRi9oU3QwNWEydURraEl6NXBoQXhZeVJXd1Q3MnN2dE5QZWswS1hHY1I5?=
 =?utf-8?B?WC9NUzlGd3VJdlgxa00rNWNjcDhGTTV3WmxNQ1VrTGEzRldxRlBpTnJOZFhQ?=
 =?utf-8?B?SDNhWWdnNmp2NmNpTmtmWitHb1FOTEErTHprNVhtUVdjc1FTRFpZQU1hajJn?=
 =?utf-8?B?UFYvL0dHbU41NkJ6VzdqSmk4RGNpcDZOODlJQlNLbmxKQS9RWWdDV0ZKZ3c3?=
 =?utf-8?B?emJxZlBkeFFqV1dsSWlYZ3pFYWtab0V1VlphWXMzUysyRndHSTM5TlhuYjk3?=
 =?utf-8?B?YzkzR21wWm1FaUpOMTRORDI2MWxSa0JSQnBFVkRIWVJmR2NoMDlRaUM3RElw?=
 =?utf-8?B?a3VtTzVuTTh3aXJ6eXlhdHRPT0VzaFdjTXVWTzY3aG13K3RZNm40QUtVcnJD?=
 =?utf-8?B?TExVbWtWUXVQMU5QZld1dFBMNWRRZ2QxUUlvN2JyMlh2VFg4dUw3SWFwTXZa?=
 =?utf-8?B?eXpGTENqWmRCVC84MVJ6SURPUDR1VmExNW5ibkRNajQ3UFAyc01BQ2tiaURS?=
 =?utf-8?B?djkxemp0MHBJaS94dWJ2Zm1Zc0srS2g3V0ttL3gwQjJNaEtFb1dCeWtnd0FV?=
 =?utf-8?B?V2NPZzdmdkZqOXo4d2x6amM4bCs4ZVljZ0t6YWdDY1lTamgxMVJuRGpsMENo?=
 =?utf-8?B?U0UyOGNVTkZOOXg0QVc3Y1M4MklRbFFxK1FxVmVKVHJOcUhFT2lpV045bTlS?=
 =?utf-8?B?d0hHcUZ4djY5S0x1VXBHSHZzN21ycWFxUkFkeXI1dlVrMTBvSkRUelJCRmhY?=
 =?utf-8?B?U3FNRFRNWlh4Tm4zYXZjUlJTRlhxVkJrbFlQWkppYitXWmM0NVU2YUg3d0NB?=
 =?utf-8?B?NXVUZ2hhQkJnZ2hQOG9nekZNb1k4VWZ3TFFYUGh1Ymk2SE8xaWhkd0paWEZq?=
 =?utf-8?B?NlVmblRHazAydW04dzA2R0R2RzUwT3ZGdmVYZ080Y2xGd05PRkZSNUtxMlU4?=
 =?utf-8?B?ZGFNVFFCbS9va2JsRXpHSkl0YkRjN1U3ck5oNDdiQW5VY3VxV3cvRm9LSDdx?=
 =?utf-8?B?TEphcEY5MDdKUkNKRlRZVGxqUnY0RDFVOHlmV2NBNjdYdmw3Sm9kNTFBa2Vr?=
 =?utf-8?B?WVdlcXVKYm9Db3Z4M3FoMWMxY1gxKzZGR3FTaEtuUUJkZ20veDVYNktoZHhi?=
 =?utf-8?B?L2hpd0x1STk2Q2hRMlQwQUtWTVFDZjR6WmY0UEl6MUE0b2E2ZmlBZ2lnWUh4?=
 =?utf-8?B?WWxzSXdISVhqLzUzRTRxWldxcVdDamdZNU9TWWthbmQ3OTh5RzNuTlNiK0lT?=
 =?utf-8?B?OEsxMnFPNjVkL0piMWk1NnM1Q0dReGI5QXRpaWJkWXc0Y2JOWVY5dFlhb1lB?=
 =?utf-8?B?VlN1UHEyNS9ycnZNMmlEbEtnSm1PSWxhOUFSQTY0OGw2OGhyWCtuRkgzWThW?=
 =?utf-8?B?VFlPNkZ4K3o3T0djaEExcFU0emdGaVBqdTZyVGJRZTEvcmw5dVdLM29qbzcx?=
 =?utf-8?B?Tmo4bkhzT1hhOXpJQkkxbE56UXpSZ09tNnlkb2Y4TEhrZG8wOVNxeGZCaDVX?=
 =?utf-8?B?aDN5U2ZkMi9TK3Q0TVFvVnAyS2RRWTZYWWJqdjN2SzZaQ1dsUTlCcUZKeENG?=
 =?utf-8?B?ZjRLN3B3YkMxZnlNaHNWbllBSGxHemd5OVFrWTA1b2lheWoyL0hIb3J3QUZZ?=
 =?utf-8?B?VFdMWnNOR1RaZ1hqUzVLR09YenhiYmZSUEdBaWhwNWIrVGZISHNPODBOT3FV?=
 =?utf-8?B?UUd3RGF1bGhNbUdWbytXS2dBczRRSHBLUk4zTlF5Qk05UlJYdDZXcndJWmpV?=
 =?utf-8?B?YzZCeldWRFZiemRlQ3lDYkRXbjV6QjhyeFpLSEJCdzBZTVdPTHRaNFdLRjc3?=
 =?utf-8?B?UFkrMUZtZXlMaXJ6OXJtVmxTRHNWa2VYVEd1TVptMGxWU2xoVnBCUyt0eENQ?=
 =?utf-8?B?cmtNM21JZGk2VWFSVk9ldWFhdkZhU0d1RmR5QjM0blYrSXZmVXJrYTdmckt1?=
 =?utf-8?Q?tvzY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd7b326-ee9a-4a94-04c8-08dd4b30b14d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 06:44:26.1163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6uZFnkhDKGsdfbG3gpmKct+gzbX00WsQwSadOOrSFRRnWQGeAETC+Dqwtv+IR+KZAm7yafMjfzjbCaVOMezAtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5654
X-Proofpoint-GUID: mOqwfK9z3ctl3ZRUEap2aU9Q68IdluZi
X-Proofpoint-ORIG-GUID: mOqwfK9z3ctl3ZRUEap2aU9Q68IdluZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_02,2025-02-11_01,2024-11-22_01

Pj4gIHN0YXRpYyB2b2lkIG90eDJfeGRwX3NuZF9wa3RfaGFuZGxlcihzdHJ1Y3Qgb3R4Ml9uaWMg
KnBmdmYsDQo+PiAgCQkJCSAgICAgc3RydWN0IG90eDJfc25kX3F1ZXVlICpzcSwNCj4+IC0JCQkJ
IHN0cnVjdCBuaXhfY3FlX3R4X3MgKmNxZSkNCj4+ICsJCQkJICAgICBzdHJ1Y3Qgbml4X2NxZV90
eF9zICpjcWUpDQo+PiAgew0KPj4gIAlzdHJ1Y3Qgbml4X3NlbmRfY29tcF9zICpzbmRfY29tcCA9
ICZjcWUtPmNvbXA7DQo+PiAgCXN0cnVjdCBzZ19saXN0ICpzZzsNCj4+ICAJc3RydWN0IHBhZ2Ug
KnBhZ2U7DQo+PiAtCXU2NCBwYTsNCj4+ICsJdTY0IHBhLCBpb3ZhOw0KPj4NCj4+ICAJc2cgPSAm
c3EtPnNnW3NuZF9jb21wLT5zcWVfaWRdOw0KPj4NCj4+IC0JcGEgPSBvdHgyX2lvdmFfdG9fcGh5
cyhwZnZmLT5pb21tdV9kb21haW4sIHNnLT5kbWFfYWRkclswXSk7DQo+PiAtCW90eDJfZG1hX3Vu
bWFwX3BhZ2UocGZ2Ziwgc2ctPmRtYV9hZGRyWzBdLA0KPj4gLQkJCSAgICBzZy0+c2l6ZVswXSwg
RE1BX1RPX0RFVklDRSk7DQo+PiArCWlvdmEgPSBzZy0+ZG1hX2FkZHJbMF07DQo+PiArCXBhID0g
b3R4Ml9pb3ZhX3RvX3BoeXMocGZ2Zi0+aW9tbXVfZG9tYWluLCBpb3ZhKTsNCj4+ICAJcGFnZSA9
IHZpcnRfdG9fcGFnZShwaHlzX3RvX3ZpcnQocGEpKTsNCj4+IC0JcHV0X3BhZ2UocGFnZSk7DQo+
DQo+SGkgU3VtYW4sDQo+DQo+V2l0aCB0aGlzIHBhdGNoIGFwcGxpZWQgcGFnZSBpcyBhc3NpZ25l
ZCBidXQgb3RoZXJ3aXNlIHVudXNlZCBpbiB0aGlzDQo+ZnVuY3Rpb24uIFNvIHVubGVzcyB0aGVy
ZSBhcmUgc29tZSBzaWRlIGVmZmVjdHMgb2YgdGhlIGFib3ZlLCBJIHRoaW5rDQo+cGFnZSBhbmQg
aW4gdHVybiBwYSBhbmQgaW92YSBjYW4gYmUgcmVtb3ZlZC4NCltTdW1hbl0gYWNrLCB3aWxsIHVw
ZGF0ZSBpbiB2Ng0KPg0KPj4gKwlpZiAoc2ctPmZsYWdzICYgWERQX1JFRElSRUNUKQ0KPj4gKwkJ
b3R4Ml9kbWFfdW5tYXBfcGFnZShwZnZmLCBzZy0+ZG1hX2FkZHJbMF0sIHNnLT5zaXplWzBdLA0K
PkRNQV9UT19ERVZJQ0UpOw0KPj4gKwl4ZHBfcmV0dXJuX2ZyYW1lKChzdHJ1Y3QgeGRwX2ZyYW1l
ICopc2ctPnNrYik7DQo+PiArCXNnLT5za2IgPSAodTY0KU5VTEw7DQo+PiAgfQ0KPj4NCj4+ICBz
dGF0aWMgdm9pZCBvdHgyX3NuZF9wa3RfaGFuZGxlcihzdHJ1Y3Qgb3R4Ml9uaWMgKnBmdmYsDQo+
DQo+Li4uDQo=

