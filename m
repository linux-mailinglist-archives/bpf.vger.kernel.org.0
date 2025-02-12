Return-Path: <bpf+bounces-51226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52010A3217C
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 09:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2166163FDC
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 08:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB1A2066E2;
	Wed, 12 Feb 2025 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="NJJNo/Pz"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D795E204C0C;
	Wed, 12 Feb 2025 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350314; cv=fail; b=YM34xI9leNHq5MbbQYt7FMG5emJ9rEffXy7LffzWCw9nfCxZuhMgJ5xMzTYYOqIIqn5y6JC6B2YFa8DZXX3j/xl6cPrSFSBDOoRR9Y7osPKLmZMMNky3tvBfmpWnRmcd0il/bNKauuvTp3hlAgYlWmUP005RsBnG3IW1OjUVR6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350314; c=relaxed/simple;
	bh=BSaYjc73z2MZuqNsl3RK9I009Y2qEG4NtclX6EgL428=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F59WfzKO1uqURFLXuuCK/8Da48+h2z5AoqwJYizzilSQCavLRqui8vSPNFn8thYHT+Hvb5iBzPTvBWeTL+PyGlYtiQH8/N1gOb5Bk7UiOYPXWlPulpkSfBr0dCkkKukrgQhuOXtIcfrRmO8HDfWJEwYsurgW1SX2D8PP6z5kiQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=NJJNo/Pz; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C59KlN014233;
	Wed, 12 Feb 2025 00:51:18 -0800
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44rn8c8bs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 00:51:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCkB151FDv0WCBf4UWt6Qn5FKBxb36gpn6kpvG5Xb4nXghJlNiq25hsP1URcHoxP4EqVPH8X8L1ueRkji14iWaxnXSsHwkqdHvij93oWsPWBjnfyC+WQgzR0p3XrVJ/mYnn/YNiS5gBI5lB3fi0qV0teAst0jifQCJMZPNo3MI8nYbU3jKGRu9aEbyAxI2uJfc5xHdA94ROxvgQmBpH5IdyIuoobfv4uqroNUxg7teNSJx494eOufIqKnsBeO9Zcs3oLm1HfCcAFoIgFnOS7YZn5VTnrduBTarzb4qLE1ojzQlV9gXiURaqlr4WiE90GabyJltJtqb7PHP4uwFBqTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSaYjc73z2MZuqNsl3RK9I009Y2qEG4NtclX6EgL428=;
 b=t0YIgcqFKX2AuCD4WDO+qrR/JkwPmMe4a7ITeXO2By2pveSdSt8xG8RB+OGNqX1H7/sdeiweP5nB1Kx5nNgucQ+DCOyjoaKrvgm9kNn2q88YJPM2lSecKjm++HU+xBRwPPfaLtaiDtbDBxeFk+37crNyql2zHPC4F7BXD4TC4INjkEHUtPA/O/GtHsl9vCBrd4xUXdSFg8UyQVAgmHe1/WmWN9E/EGsocxytACKYKwqFPy+JK57od+XyCJvJfJtqTG33oY2/0KsLUzDTBn1zkLaqZXaubbJRQ1mPIfHxpgPTuTMcsb/RbAte/PCQ+jpc2ojw79CvBbcSBclbi28zKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSaYjc73z2MZuqNsl3RK9I009Y2qEG4NtclX6EgL428=;
 b=NJJNo/PzBaQIazhr7O2SYycOiiDr6EAZYAdS6VPkrl7bm2aYwWWRucvuYGDpQ4DtCQqJKcIWrewnIG2ytPDMnudBQDLxGRY5AGmkM6KzFwc+MpA0YGYTYIDHziL+hhJWftJ5zXz4rsmKDWhJiAS0QptOUEBgBIYGZMN9GH0TCDQ=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by SN7PR18MB4032.namprd18.prod.outlook.com (2603:10b6:806:102::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 08:51:14 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1%4]) with mapi id 15.20.8422.012; Wed, 12 Feb 2025
 08:51:14 +0000
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
Subject: RE: [EXTERNAL] Re: [net-next PATCH v5 5/6] octeontx2-pf: Prepare for
 AF_XDP
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v5 5/6] octeontx2-pf: Prepare for
 AF_XDP
Thread-Index: AQHbeHRZfDJYbtF3akeEr0+5Frwfo7NA2YMAgAKKTFA=
Date: Wed, 12 Feb 2025 08:51:14 +0000
Message-ID:
 <SJ0PR18MB5216463921AF689670D461BBDBFC2@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20250206085034.1978172-1-sumang@marvell.com>
 <20250206085034.1978172-6-sumang@marvell.com>
 <20250210175712.GK554665@kernel.org>
In-Reply-To: <20250210175712.GK554665@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|SN7PR18MB4032:EE_
x-ms-office365-filtering-correlation-id: d17ef34d-f824-422f-d491-08dd4b426855
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L3REYTJNQkVZMlhLK1pyV3huaXJHM3ZZQlhFZlBSbUQ5aVVxM1NhUDBmd3g5?=
 =?utf-8?B?QnVBKzRxK3o0cUpJSnFEdEt6Z1B6R3FvRHpwTFB5NE44M0FxMmZWeEF1d2Uy?=
 =?utf-8?B?Yk5YVHpzZVlQRlV6cElSMUZEUW5rY0RIY1FXNUhNaE94UVdZTEJldDI5M3lP?=
 =?utf-8?B?a1hXTXlIb09ib2tjdHIvZ3JHM0pGZVVuRFdONlQyWlNCa3RkN3JEZ0tzQ3Y2?=
 =?utf-8?B?Ym4vUzBJVnh2dkRrL1dOVE94QW5kWTlBdnVzQXNVcnBvTUM2ZUhNR290TWdp?=
 =?utf-8?B?M2NKd2NjVG5oKzFRK0taRkhMdjExMnBGZDhIU3kyYTRSd2NRZEN2TjY0TG1q?=
 =?utf-8?B?RHN3dHI2dnF3MDFzcEVEdlo2UXBybVZOZUpDM3ZPdlpkeFJXaUxtTU95V0hz?=
 =?utf-8?B?TVh4cll1MEdmeWtHOVQ1TDd1aW5EaFBaQW1ydzRabnY2ZHpYQ292QTcrRk9n?=
 =?utf-8?B?b1A5amJhYjhZWUpybmpUcThVSnRua1RWTnhQRWhyb0o4cFBCMzRhSEVpbnRy?=
 =?utf-8?B?dWFLYTd0MTlVZzJGRjEya0RoUzZkWXllT2llamxlY3F6L2xwUlQwaWsrSDZS?=
 =?utf-8?B?Y1d6UXhNL0Zpc3pTYUl3S0p3WE9tQnBXNm9kem9vY01DeXpqWm03cUhtd2xi?=
 =?utf-8?B?K3IzWGxWTUE3TWpSUGZaMm9IM2owSGx5RXBUQU14SnNqOFFpV2ZJSXZMZElx?=
 =?utf-8?B?bzlQRUg0ZmltUzlROWdnb2Z4QmlTdHAyTHdiRVlBS3NtNENUS1JZOHZrWlVX?=
 =?utf-8?B?OHpaa2dqeTRvOEc4ODJmcGwrN2lrMlhxb0JCcEYvYmNkY3RDNzZ4UFJGaDYz?=
 =?utf-8?B?eHZhNkxKdDVIK0pnTUFDMmtKWVVYVXRNQ1lhNmRFd3VnNDZaaUdIOFlKRVV3?=
 =?utf-8?B?TjNLNFY0U0dXMGZ1N2I0SW5mRU54bUR5L3M2ZlE4RFdlaU96UGJxNFFSUjhw?=
 =?utf-8?B?N0RYUmwzdFRMU250MzhjUWtXQk5IWlp0MkVqeTlnV2owYnczaS9BbVlUbHJQ?=
 =?utf-8?B?elJvVkdLdnZ3MFBEd2oxODNtd21rQldCUGdJQTJLcjZFRFBhTlJhaHdIYWF0?=
 =?utf-8?B?MlY2Nkk0T3BzTkF0UmJqNlF1ZXFGN3BlenlJMnFJQ214NXlSZjNYMklHUXE4?=
 =?utf-8?B?alZyMHBVRi9Pb0tPajBkeWV1ZXRSalI5QkRPWmxzRTl3T3pjZ2pBOUo5S1I5?=
 =?utf-8?B?d1htVWRoWnAvQlVESUxEZzdreUJHUDBnTlNSSW1xQS80NFRkMDVUUHdJTVcy?=
 =?utf-8?B?Tm1JRWl2Z0lrd2YrS3lvcG9NK3h3K3pHR2dIRWlqS01BS3dURVpUb3Z4eG1I?=
 =?utf-8?B?ck5neVpPQnVBdE1hMkt5SktWeGNOa2pYc1d2QlFLQ0ZIdWJwaDVrMXJPSGhh?=
 =?utf-8?B?Y25JWXNCdzRGUUd0ZXMyZzdrTXZMaTBsSzBGSUcvNTFXR1o1WnpUVmhBbmFF?=
 =?utf-8?B?Qkl6SWk1OUxVamNTOS8rYlp5eXdlWVZxWm1RZFRIMzZaTXZoMGZ4dit5Qzkz?=
 =?utf-8?B?L05KTndJTDMzVDF2QkhxNGxBN3RMWEUvalpabjFhNXFUcE5TWnBlOHlZbXl2?=
 =?utf-8?B?c3V0alcvSVg4U00weVRsS0N6ZGRZekpTd0dRMEY2MzZ2Q0FoVXE3dHFYUjc3?=
 =?utf-8?B?ckU1N2F6MWY1V0hrK2wyRU80TXdNTEF5VGtIeWJ2bTRva1MzSDBoOVRicm5l?=
 =?utf-8?B?UVpyMWVQamdSaHV1U2s0VWlpdWYwQU9IMU51UUN3YTcvWWgrZnFMSU03RWVK?=
 =?utf-8?B?eDNKNE4vd1JlWklvT1F3UG5hMW0yVjI0dFdiVW42czBaclBZWVcyZHYvVjYw?=
 =?utf-8?B?WjRuNU9TOHJRc2xuQjBsMUg3b1RrYm5GSHBWemhvK1ZmSE9GK1hHM2RrWFhW?=
 =?utf-8?B?T0U1YU40enVWa3gxUmRvd2RxMUhOdG9peG5oZkE3NVRKZGRnYStXTlJLTU8v?=
 =?utf-8?Q?ZMn6gn0CxGkJX2I6szWZe0GLe20c6oaO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cDh1cmpCZEtHaWo1a0dBT1hraHFpcU42T1dBWm5aMlRITVhScmFJWHg2OTBT?=
 =?utf-8?B?Qm5TQVBKN21wbzhYNlVJRG1yZGQyT3NVb3N5dzBuQ09SQ1pyVHlXVk1tcC9K?=
 =?utf-8?B?S09CUGVwbjVkeTZtTTAyRzVnVmtaMTc2K1lxWVFGL0FsUUVKTmFKYXZvMnBL?=
 =?utf-8?B?L2dYb1FRamIybGJ4RTU1anR4MFdidmhHQVk0OXlnbzNQYUZGYWtFOTg0UWxV?=
 =?utf-8?B?TTlnNFNBM3NtMHQxOXZLSWpRV2JvVWNPYVpZc3czMytiZG9rZ015aXg4MGY1?=
 =?utf-8?B?THAvYnNBMEVuaEFnb1AvVFRmSGw2aVNXWWJQMzBlellrU1p5S3lqK1E4aEhX?=
 =?utf-8?B?am56MzliME5JaUNPK1N4QjlHOE51SDlFOUZXbUNvdkgvZUh2U0xXVXh0dTZO?=
 =?utf-8?B?aXI5ckhjRkpFTHJGM2VDQzBrYk1xVUZLcC94TnhOVmU4elJ0bkFNY1BuaXp3?=
 =?utf-8?B?cEJ5RHBRRnpqa2NyNmpZMU9POXM4M1gvZEVxeGZ5OHV2VWo3RldFa3hDdHFo?=
 =?utf-8?B?bmpxZ3hYcGVxbElRUGFLWUY0U3FGb0ZkbTNxTFlEVTRYVmpjd2VDck5PL0F6?=
 =?utf-8?B?ZGtXUkFzR2U5dFRBZ1ZPcEcwODh4MVBQRmVyRGxJTmwwVlppOWVickM4SEd4?=
 =?utf-8?B?VUp0NUdUS0wxbVh5K0pTWExvejRrME1yOVlkdWZVVVhJL1RNNjVCT3owUDB2?=
 =?utf-8?B?L0VadStaSnJGWXJtWGxIdFZYZFZ5NHdBckdOVmZlMDdrMGpRVkczdXV2THNa?=
 =?utf-8?B?cW9ZR2IxckZ4TlJKZE95WVQrd1VveDlvV0pyeXBtbjBZOG9pdHU4WENSQXRY?=
 =?utf-8?B?UXlBRzdJb0V3dWpHOE02OVJsaytsSU5ETy9OUnpMOVE4OGU0YnR5Zi9LZnU1?=
 =?utf-8?B?SjV3U0dPaGdyUUhjK1FiL21QZXhhWEtKWjh3VWwyMzFzVDhqMll1aE1GeXVw?=
 =?utf-8?B?T0VNOStoRXUxaHViM1RtQ1ZnR3FKalh3UEJlV0F2Sm5hQlpUOGU2YXF4VUdN?=
 =?utf-8?B?d1pMazRZbjVOb0hmRmo5ZU01YU1Bd2FLbVRJaGZDN1FUamV2cWRsK1V6eEly?=
 =?utf-8?B?SjA2aWZYRjA1VnFqbFBYcS9hUUxCek1OZzM2TndybVFuRUFuZWk2djMzNzZS?=
 =?utf-8?B?Qzl3SFFzakEvNFlWbFZaZDUvUG81anB6NEVIc0VmRkM0dkRTWTQvU2JsL2k0?=
 =?utf-8?B?Q0s1RlRZR29nNEhXTzVIeEN0UzZsUW02TnQ3RDBZUkJ1ZWZSS0xaSzl2ZERr?=
 =?utf-8?B?S0RFR1czaC9xaEZXUFBkbGNsZ2R4SitqQ3ZxTzlndVhoM0JIS3krdmE0dlpn?=
 =?utf-8?B?R0FRYkxHOUcwNDlRWWVjTGRBMTY4VXBqZ2JiZGJ4S2haaDZPd0ZlK3R4YXVF?=
 =?utf-8?B?ODVKL2Nyc3ZxZ1RBc2pzbE05TWI3RnM5T29sZGM0d2JPa1dwTFJFcXBSZFgx?=
 =?utf-8?B?NmNxSU1hcFE4YUNKNGVzNlJXMGExMDY3bENMaDA1U0xPMjYvTWxiZzBuR2kw?=
 =?utf-8?B?STNBTjFYNGpuTXM2NjV2ZjEvemdqdXo1b2hGcFV0SjZvMFRtbFpaYzNWalZm?=
 =?utf-8?B?SUlyVkREaGMrVWo0RFhnSkMzdktTNTdCbzN2aHNSMkQ3Y3dGd2lXMjROMVM5?=
 =?utf-8?B?ZGkwYmkxTWg3T3pmdUwzM3BORlh5NlphZWtNcFFjcHA1YjJ0Y0t1QkVwSm92?=
 =?utf-8?B?M0hQQjB2TldqN3BuMkZTVW1rY1pZWEhjU29HWUNrM3RMQVNLK0p0eHNVTUdw?=
 =?utf-8?B?d2dHMGFhejkzK1UwbjR0UHdWeWtETS9vM0Q3U3hMQnlyZ1lvbGM2MUw5aTFT?=
 =?utf-8?B?cGlhV1YvemhVZmpBaEo0N0JVVjJKb3JISEVFcVZLQkFucEsyK2ErOUZHa2wv?=
 =?utf-8?B?RFl2WUxEb3dQYVRsSHk4L3FxdlhxaDlMcGFHRmR6bExTU0lHTzI0YXhDZVZy?=
 =?utf-8?B?clFzYW5mTHg5dXJZR0ZtMWFId3RhMTNaeHJoMW5OTzhZRDZ4RjBEU0RiWjV5?=
 =?utf-8?B?MURCOUMyUDJtdjA4eG81UWR3MWZsa01OTi9zTHRldTB4UmJWMlNwZnBQd2U3?=
 =?utf-8?B?OG5iZEF0SUVZbE1TYTRQbHkrZEhPWUQxZjNGeERyVzdPVUlxRWk3RWpYZ0N3?=
 =?utf-8?Q?saug=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d17ef34d-f824-422f-d491-08dd4b426855
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 08:51:14.6782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F3HBT8GgKSDPbv8wcSz/qJ/mpKFSoCteLNzFPYeUYo6OhVOsidg1lOaiedYNy5kkRRn9dLGyW0F6OR60rs/d8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB4032
X-Proofpoint-ORIG-GUID: vEnMjFPGnB-UCkLAfQNbJJ5gvGdwK8mK
X-Proofpoint-GUID: vEnMjFPGnB-UCkLAfQNbJJ5gvGdwK8mK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_03,2025-02-11_01,2024-11-22_01

Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25p
Yy9vdHgyX3R4cnguYw0KPj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4
Mi9uaWMvb3R4Ml90eHJ4LmMNCj4+IGluZGV4IDQ0MTM3MTYwYmRmNi4uYjAxMmQ4Nzk0ZjE4IDEw
MDY0NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmlj
L290eDJfdHhyeC5jDQo+PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVv
bnR4Mi9uaWMvb3R4Ml90eHJ4LmMNCj4+IEBAIC0yMiw2ICsyMiwxMiBAQA0KPj4gICNpbmNsdWRl
ICJjbjEway5oIg0KPj4NCj4+ICAjZGVmaW5lIENRRV9BRERSKENRLCBpZHgpICgoQ1EpLT5jcWVf
YmFzZSArICgoQ1EpLT5jcWVfc2l6ZSAqIChpZHgpKSkNCj4+ICsjZGVmaW5lIFJFQURfRlJFRV9T
UUUoU1EsIGZyZWVfc3FlKQkJCQkJCSAgIFwNCj4+ICsJZG8gewkJCQkJCQkgICAgICAgICAgICAg
ICAgICAgXA0KPj4gKwkJdHlwZW9mKFNRKSBfU1EgPSAoU1EpOwkJCQkJCSAgIFwNCj4+ICsJCWZy
ZWVfc3FlID0gKCgoX1NRKS0+Y29uc19oZWFkIC0gKF9TUSktPmhlYWQgLSAxICsgKF9TUSktDQo+
PnNxZV9jbnQpICBcDQo+PiArCQkJICAgJiAoKF9TUSktPnNxZV9jbnQgLSAxKSk7DQo+XA0KPj4g
Kwl9IHdoaWxlICgwKQ0KPg0KPkl0IGxvb2tzIGxpa2UgUkVBRF9GUkVFX1NRRSgpIGNvdWxkIGJl
IGEgZnVuY3Rpb24gcmF0aGVyIHRoYW4gYSBtYWNyby4NCj5BbmQsIGFzIGFuIGFzaWRlLCBDUUVf
QUREUiBjb3VsZCBiZSB0b28uDQpbU3VtYW5dIEkgd2lsbCBhZGRyZXNzIHRoZSBSRUFEX0ZSRUVf
U1FFLCBidXQgQ1FFX0FERFIgd2lsbCBwdXNoIGEgc2VwYXJhdGUgcGF0Y2ggaW4gbmV0IHRyZWUu
DQo+DQo+PiAgI2RlZmluZSBQVFBfUE9SVAkgICAgICAgIDB4MTNGDQo+PiAgLyogUFRQdjIgaGVh
ZGVyIE9yaWdpbmFsIFRpbWVzdGFtcCBzdGFydHMgYXQgYnl0ZSBvZmZzZXQgMzQgYW5kDQo+PiAg
ICogY29udGFpbnMgNiBieXRlIHNlY29uZHMgZmllbGQgYW5kIDQgYnl0ZSBuYW5vIHNlY29uZHMg
ZmllbGQuDQo+DQo+Li4uDQo=

