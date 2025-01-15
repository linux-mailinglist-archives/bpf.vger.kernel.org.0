Return-Path: <bpf+bounces-48970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC341A12ADD
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 19:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E997166964
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 18:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE6C1D63C7;
	Wed, 15 Jan 2025 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="E4umG3kS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEAA161321;
	Wed, 15 Jan 2025 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736965836; cv=fail; b=PVnKKi0mzffy95n+4lwNHnOAkC/sNIOfeON5bJwHOh0lQnCCgUfpSNjG1RMKNKvsglOgrABSPk++vQS2u6GtJMeDEVmMvRXGh+8MEWxAJU6Afe0lLw+7Gk5PNCrb1XJr44kLCudsKMSGMC+6QPt5csS+EeGU35JhBDQvhzkAdQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736965836; c=relaxed/simple;
	bh=mlcbDWINKx/lqza2h0w7XkQuHRP+98XsVrALTrfifqY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YI9jlFxqeRBeiv/B5cWtVH2U0XxkG4iiW9gCYMFGAUPADmwNixN1Psa542sWXZrW1P1K6ue7sjwwVw4p6Xtk2tLGTqrz994dC8n9t6A9wbTSpsfKDC+rpUIk9t02uIJxD4Z/cNIUc58n3absXGL/LWaauA9PeOyx3IwLybBg9HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=E4umG3kS; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FETjMW016209;
	Wed, 15 Jan 2025 10:29:58 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 446eu30hgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:29:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TeP4itNo6GjvwB07YBNA5OFXaC+LMYWRA49Q9YNkITzC1y6aAa5c2b41xjgjh61nrmZ1CHEO5RtQAwjB3BFrGmcnWsOKwVo13+WDjI9IGiftH2ip0mfwErgXoNqDw6Os0ujQiaJ6L/c9c3UgjSqU++dcA/XThUHD7MOyXbBBSw2OwjJf8C/9Ou73CdZD84UyrEsbD/PMgQG4fAl4TN3f044YrgtJU+6nG56WXN6FCgboFn7USprGfSuy3bx+98Kh9QNdGuyULk7XeDeYjm9SBSPbhsgNmOz8npUg/67JhOtUd+8tbYjtv0Fuwdkx+qEFtuFnHUSg122TUTyGrXOl5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlcbDWINKx/lqza2h0w7XkQuHRP+98XsVrALTrfifqY=;
 b=iuwK0XIpApBxX5Q24k1HqZj7nVsOalAwOh1G4yMu2tLE24vpHoT0SPKaFVQmlFHOtC60CYG+gFX9asxtvEqN58dRhG8Q/K7GO6VwZqtQ1vjGwfQW9jOHFpdoZPUWym716qj4VUyko1/PGKdXLO7dLYCGe2HG7vzVgoF2yzy4rBhBtoYk5pUNxGGsG+E6D01Vgr7i4K8rk4i2R5FhhDmPjkgIjF7UwrCsncEokKsW08FKVznQ2e9Y9lgQ+IqHRckQEJJkLMGm1dXzpQP5mgKiD9rgymMoRJyxvRsebtKuQev97wdS3FzOXJoklpUBI8ULxaKk14UWW0gs3+FflVfUDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlcbDWINKx/lqza2h0w7XkQuHRP+98XsVrALTrfifqY=;
 b=E4umG3kSNy3fXQjtIK2O3LvOC7GDCAooeqsemtwo+3Q4G917UKzzLq8vgSitxIuABpSBJeHy1oyCdwLqV2EJ3nv94TW/mACyVRx2mPZ/K/+o0BlQ730NBHkrNq9mNn1tW+XGPfWPcj8+3AXIeyMmfqFti0vs/UWgoYaqqW9iqgg=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by DM6PR18MB3537.namprd18.prod.outlook.com (2603:10b6:5:2a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Wed, 15 Jan
 2025 18:29:56 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1%5]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 18:29:56 +0000
From: Suman Ghosh <sumang@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula
	<gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Linu Cherian <lcherian@marvell.com>, Jerin
 Jacob <jerinj@marvell.com>,
        "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v3 1/6] octeontx2-pf: Don't unmap
 page pool buffer used by XDP
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v3 1/6] octeontx2-pf: Don't unmap
 page pool buffer used by XDP
Thread-Index: AQHbY0NnHfJTxy17wEiKNckkwt3GVbMWPXMAgAHyazA=
Date: Wed, 15 Jan 2025 18:29:56 +0000
Message-ID:
 <SJ0PR18MB5216127E87F0B3DDAB5ACD7FDB192@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20250110093807.2451954-1-sumang@marvell.com>
 <20250110093807.2451954-2-sumang@marvell.com>
 <2e4d11f6-843b-4e25-b4d1-727dc4edbefe@redhat.com>
In-Reply-To: <2e4d11f6-843b-4e25-b4d1-727dc4edbefe@redhat.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|DM6PR18MB3537:EE_
x-ms-office365-filtering-correlation-id: 5dcd7231-e02c-49b1-d982-08dd35929c66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ODZYalZndUphdGN5QlFkcXMxVEhMN1BQK01KNTFGUWxPSUFnTEhXc1lIMVRh?=
 =?utf-8?B?a1BNdld6c2pOOFdLWXNuczQyT29UVnUzR3ZyMGVEZnVFeGxzM0dwMTgzOXRq?=
 =?utf-8?B?bEpmNXQweG5wYlpRbyt4S0p3US9ON0liRVpMajJDRmlaNVlkVUpLR2RFRnRs?=
 =?utf-8?B?QXNpSG8zSWViVHhPdUI2eWFiODRMbVdPVnJ1aFpXTXBPTG1JQWhpWExDSzh1?=
 =?utf-8?B?WVp3Wk1WS2dyQkk1NCt2QUNKeWFqV05yaVAvTTlRd042M2ZibXcrNnZqWWxw?=
 =?utf-8?B?cmJhRStRMldjVS9yRzBmajdDeGU2RkJPY2Y2SFlzdFNsODRvR2Mya2VXQjdJ?=
 =?utf-8?B?OXR2VHNwT2Z2bVNHR1RoSGlRYkR2OTlEU0ZaMHYrVHU5d0NnU1g2cGxGcmMv?=
 =?utf-8?B?RnkwK21GZzQxckRRK0RETURxUVcxK2ZFZFNTR0xSQXVGc2tsK1FZb2h6YkFN?=
 =?utf-8?B?dDdDcnFvS0JITnFPcVM0RjhUdkQ0bVdFb294SCt1THNQc1MxOXVzWmZqbGw3?=
 =?utf-8?B?OTk0VzRHTS9BSGswVG1NWUY1cmk5WTE3dm9tZEREZ0hMbmcxVE00cDAvQ3Bt?=
 =?utf-8?B?eWltNjdZQndaZGt4b2VaaWxqT3duTHBIeWdvMGQ2Wk50OFcrVlU4ZHIwVEtu?=
 =?utf-8?B?NHBUTFl4MW1FRzVJeFJmTEdKbTdsUGJsVUh3NjZzb1Y1dmRwRkdoSDhtS3lx?=
 =?utf-8?B?RGF6aXQ3VFZWWGpQa3RKNk5EczZQb2R2RmJtaGVSdVRzSUFaOWkxYnArVXJh?=
 =?utf-8?B?N3h1OTQxU2RGRFR6QTlPc01XZURCTTVCNm5zUjVYc3NJV3pQb3F0dWNaR3pV?=
 =?utf-8?B?MHJQMWJHZWNXTUFINGx4TTRuRjVuc3llWWl5WWtnRUp6dkdsd0RKVEFJR1VP?=
 =?utf-8?B?ZC9vQjBpTFNOUDY4Y09TSGx1aWhQWmUrTG9JMVR3SkJPM1pPN0RuSHlLOVpp?=
 =?utf-8?B?RlVnbSs5SXphcUQrNytBWkcwMTRWUTFrZC9wWm5jUVo5T0FyNFQ4Rk96N2Jz?=
 =?utf-8?B?TVlhNXIyd3hNOHh3OC9HUTVqdUh5N2NXVWE4eFh4N0FrdjYvUzdwTW5JUTBy?=
 =?utf-8?B?ZVhveEhPckMvcFlaLzdsNXdNQjVHelpqS01WQVVPMUJOWlZFTERvMGNpc1d5?=
 =?utf-8?B?Yk9yaGFIRmx0NnY2RGkvTnFLeW5QamwwK1dJYURtYWFaa2VYZVJTb0grS3NW?=
 =?utf-8?B?ZkNQN2RvRjZpQTE5dXlwbTVGMkRZVXdyeDRpNlp5NWc2TWhHdm1pbjdtbkdL?=
 =?utf-8?B?M0tDNzBnNDMxbFpid2NoS1VTNUFwNjY2SWROd0pjQU82anNkdHE1ZWxiSCt3?=
 =?utf-8?B?aG1EdVAvSmY4YW0xcVhnUWRrQnQyWjVzL0owbGRJNzNOOU51Mjdvdk9mdmU2?=
 =?utf-8?B?WjNEWE5ReFZPM2p4amFCYTJBRmRFVCtwOFdGZ3BQZWdEVVpaT3pJa3BNWGlw?=
 =?utf-8?B?VkNscTNFekxSWXUrRFI3MnFseWwyRVNFL0E1Tnc5T1lISkNUeDJOSE9tb2U0?=
 =?utf-8?B?LzBZRXFYQU1mSS9xZjBpQVRiYmRvVmN4Y0Y0N05SejBIdnQ3ZXNoUHZ1RzhM?=
 =?utf-8?B?aTBlQ0dwbmpFbEErQlMyMWdpKy9yZFRaRmZpaUZDZ2FUaXhwYlRadUZXZk1v?=
 =?utf-8?B?WlFTZkZkSHlOdU15U1dxSCtYa2MwSVpGSnFwS3EybGJQb0ovekZ1VWxWWkNp?=
 =?utf-8?B?eW9UV3hZeG11aUg2ZU45Nmd1UzViN2ZzOThhYmZUSXFoeHpxOUo5cGhVbVVD?=
 =?utf-8?B?eXY1NDBYNDg4SkwrU1RWMVlWUGRGSjNJVFNWaFRxSGtKZmxGVW1zWkthR0w1?=
 =?utf-8?B?cUtjWDhYanNLSEM2YXc0R0c3UmVXeDk2ai9jU0tRUzNFUG9UaFMzT2l5Z1Jh?=
 =?utf-8?B?RlVWaWtYRlhRRXJNLzlIb1pwVGdYNTFNQ2FXQU01SE1aSnBjTUhoSmVvbmtw?=
 =?utf-8?B?QWRCYmpUeThOV1ZIYXRIdStqY1JVL253Q2FTNjJObWdRckdUeE9JMExFdjdZ?=
 =?utf-8?B?WTFhMy8wK3dBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTFaKzZrNTVnVVBKdWxIZk9HSm13OUdYQ081TGFxTUU4ZmhEMlowNEV0Z1Js?=
 =?utf-8?B?TzZ3NnJmMUQ3T2dhbk9LV0ZtQ1FzNXhGditvM3o4YVhKYTI3QkJ0NG5KWGFm?=
 =?utf-8?B?OTltYXJrY1Z4NnhDSVpxRUFidENDN1dzNEFVaGoxVjBsMmtNVGhhd0oxcE44?=
 =?utf-8?B?OEQyM1cwWTIxZmdEdVYvczUzMnJBdllNK3ZhUEE1OTRpa0xpWjFpeHJwZ3Nu?=
 =?utf-8?B?dmQvSG9GQ1dxR1NuZ3lxdjZIZHVOZjNLcG1RMDFONlIvY2VJaTJKMGVXSGVU?=
 =?utf-8?B?OCt4SEF2ZFk0OWN6TEsyY1k5RzlHaGZJR1BhYVVvUy9lWUpDeERQazhhVks5?=
 =?utf-8?B?cGRTMU1CSjNXVnB0U21zQjZXdWg4QURtREJaZWVlZVN4WUZBbW54Rng4Z2Fw?=
 =?utf-8?B?Y3pWcFc0dVBxMkhsZGg2TWxYMnZMYnhYMlJvU1pyVkhMVXpySmtXaTJCSHJS?=
 =?utf-8?B?WjRhUStVYWJXNUhTUFZkMlZ5SWl1ZGpINnlFcjB5YUkyM3FtRi9KN1loZEhR?=
 =?utf-8?B?RzlQUUNVdHh4ZXNEZWdlUU9heHlTVk1yUzNSSkdieStzUW5wT1lNb09ETEVD?=
 =?utf-8?B?Z05TTHlOZWduSWlSNUJ1QjdVaXo1ZWI2QjFTQUdpNTd2UW9QMFQzbFdmUVVr?=
 =?utf-8?B?dXBKUnBFSlFwekl2YW5ZV3dsZlF2KzdMWmZkVU94UTZrNkhVSENISjJwaFIx?=
 =?utf-8?B?ZzNGTmtEYVExaVMzU2MvcTB6a2hseTZ3S3BFSTJJVElOZ3BPQ3p6Nm5OOGdp?=
 =?utf-8?B?YUg4Q3NOeE9OekpVRTRsR1FqZFY3TzJKMXVVVTRpVEczWC94d244Q242YmlJ?=
 =?utf-8?B?S056a0pJSFVDd2h3VnVzVHhqZGlpU0VXU1p5bTVqeGJaWVdnVmg3ZkhRUUIw?=
 =?utf-8?B?b3R5cDFydm5ic201OHJMVWdDM25xME5EdUQrSFROMFhkbXdRVHpzM2x6akRW?=
 =?utf-8?B?N3hKSktwZmU2RVdDdnVkWWJabmRhVmk3M3UyQi9nWktNVHZhTzBoQk5MakpI?=
 =?utf-8?B?VWd3NjNFNjBzcTVJNUQ0QTNrTkQrYkNRaDNnVVBoRHg5dU5vbEtsUWhwdFZX?=
 =?utf-8?B?dEZKL3hBS2dxTHVyTHpXWFdRenZEWkJtVXFIVGhNODJVRGRmYVhkbVhqTzEy?=
 =?utf-8?B?U2NtejNWMDhoVDJ1K1FjckpXVnU1NUtveS9wMy9WaEZHNGpsWFM1anJmZG8r?=
 =?utf-8?B?VmRBU0VaRU1IRE1BbmhQSlVhbDFqOEQwWFh6V2FxaHFDNnBqaC8xQjJqdXNm?=
 =?utf-8?B?MTEwYXZFcng1Q1FoeXZBbDBEaXJVTkZ6b1ZyZkhmcXlTTzVBcThTWFVicGVt?=
 =?utf-8?B?SUxEN0RQeC9XOFo0bmNiNmZnTkV4ajZVazlnb1RSdWtIanBDTEt6bDRpUnhi?=
 =?utf-8?B?RUdJdFhEMW41TG83NWtSNTdPbHd0akhRUVJpWXRBUk80OTBDTFRpanZkdVUv?=
 =?utf-8?B?MW53Mnh0aXlaMEtzT25NZGlSRmpmdlhyUGlJUzJRSEo3dnMzcXR0d3hmSkZm?=
 =?utf-8?B?QTF6S2ZWREZTRXNIUWo4eDhjMFZrWmpNam9yYVZUVzZTUTgzUEVZekxzVmk0?=
 =?utf-8?B?R0xTTTdBNU1hckpSUFBrSVMxQWhpb2VEdmo1NVNLTk5TTldNZ0xBWXYwWlRO?=
 =?utf-8?B?T1F4UGRRS2UxdTNNTTBQRjBJRisvMWQzZ0pwT0JsSDZFNUZxMjMrc09wMGhW?=
 =?utf-8?B?TDFxcU1CUW00UUtZWHN0aitZbnIrcXkxUmdTVkFzTHpsRlI4QlRtU0NJWWJv?=
 =?utf-8?B?ckNtdFlRZ2tOeXg4YkdzOWVSN3EvcVpESVk3OXRDVXJ4K3BTWnM4enZtK056?=
 =?utf-8?B?TUdWS3llMW1IRWNVa0cybzJKVnd5SGIrczlyQWdYK2IvajlRWmxoYStUUlZ5?=
 =?utf-8?B?NjZZM1lDVUZ6Zm1TbVU3VHRHRDF3WHpJcS9RWk0zMlFCK1BsbFdxbUJZK3Ew?=
 =?utf-8?B?R3grY1I5ejlxRzdsOEd2OXl0S1p3bFZRRW1xNndZcVkzbmp5Q0VHTk5aaEtC?=
 =?utf-8?B?OTVRbnBnMVVCRWMvaGxEdFhiMi9KL01ObWNnd0hLdDMzL2FRdlRUOWxGTnJ4?=
 =?utf-8?B?WElLR0JsNHVZZWUxMUtTdkw3U1Z3K2dRRUJaT0Vtck9INFU4VEdHaFhYbDJE?=
 =?utf-8?Q?qXkNAioOhTG3cwDDatwGjvK65?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dcd7231-e02c-49b1-d982-08dd35929c66
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 18:29:56.1481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a65qv/ba8Xr9dTCjfLcs6BplQlMdhscPTl0/68C+YQcjWY6ZbCL6ECQeXhfQzr09yVXeSXnuoMinw8d6lI+NAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3537
X-Proofpoint-GUID: _kO1fEQRXuFaTscYs0jUHTpiiy4Hz7nY
X-Proofpoint-ORIG-GUID: _kO1fEQRXuFaTscYs0jUHTpiiy4Hz7nY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_08,2025-01-15_02,2024-11-22_01

Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25p
Yy9vdHgyX3BmLmMNCj4+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIv
bmljL290eDJfcGYuYw0KPj4gaW5kZXggZTFkZGU5M2U4YWY4Li44YmE0NDE2NDczNmEgMTAwNjQ0
DQo+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4
Ml9wZi5jDQo+PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9u
aWMvb3R4Ml9wZi5jDQo+PiBAQCAtMjcwMSwxMSArMjcwMSwxNSBAQCBzdGF0aWMgaW50IG90eDJf
eGRwX3htaXRfdHgoc3RydWN0IG90eDJfbmljDQo+KnBmLCBzdHJ1Y3QgeGRwX2ZyYW1lICp4ZHBm
LA0KPj4gIAlpZiAoZG1hX21hcHBpbmdfZXJyb3IocGYtPmRldiwgZG1hX2FkZHIpKQ0KPj4gIAkJ
cmV0dXJuIC1FTk9NRU07DQo+Pg0KPj4gLQllcnIgPSBvdHgyX3hkcF9zcV9hcHBlbmRfcGt0KHBm
LCBkbWFfYWRkciwgeGRwZi0+bGVuLCBxaWR4KTsNCj4+ICsJZXJyID0gb3R4Ml94ZHBfc3FfYXBw
ZW5kX3BrdChwZiwgZG1hX2FkZHIsIHhkcGYtPmxlbiwNCj4+ICsJCQkJICAgICBxaWR4LCBYRFBf
UkVESVJFQ1QpOw0KPj4gIAlpZiAoIWVycikgew0KPj4gIAkJb3R4Ml9kbWFfdW5tYXBfcGFnZShw
ZiwgZG1hX2FkZHIsIHhkcGYtPmxlbiwgRE1BX1RPX0RFVklDRSk7DQo+PiAgCQlwYWdlID0gdmly
dF90b19wYWdlKHhkcGYtPmRhdGEpOw0KPj4gLQkJcHV0X3BhZ2UocGFnZSk7DQo+PiArCQlpZiAo
cGFnZS0+cHApDQo+PiArCQkJcGFnZV9wb29sX3JlY3ljbGVfZGlyZWN0KHBhZ2UtPnBwLCBwYWdl
KTsNCj4+ICsJCWVsc2UNCj4+ICsJCQlwdXRfcGFnZShwYWdlKTsNCj4NCj5TaWRlIG5vdGUgZm9y
IGEgcG9zc2libGUgZm9sbG93LXVwOiBJIGd1ZXNzIHRoYXQgaWYgeW91IGVuYWJsZSB0aGUgcGFn
ZQ0KPnBvb2wgdXNhZ2UgZm9yIGFsbCB0aGUgUlggcmluZywgcmVnYXJkbGVzcyBvZiBYRFAgcHJl
c2VuY2UgeW91IGNvdWxkDQo+YXZvaWQgYSBidW5jaCBvZiBjb25kaXRpb25hbHMgaW4gdGhlIGZh
c3QtcGF0aCBhbmQgc2ltcGxpZnkgdGhlIGNvZGUgYQ0KPmJpdC4NCj4NCltTdW1hbl0gWWVzLCB3
ZSBhcmUgdGhpbmtpbmcgYWJvdXQgdGhhdCB0b28sIHdpbGwgdXBkYXRlIGluIHNvbWUgZnV0dXJl
IHBhdGNoZXMuDQo+L1ANCg0K

