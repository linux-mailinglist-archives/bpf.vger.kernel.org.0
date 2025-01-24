Return-Path: <bpf+bounces-49683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89DBA1BB58
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 18:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1853A6DCB
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 17:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6C71C5D5F;
	Fri, 24 Jan 2025 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="MbZlPDu/"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50B029A5;
	Fri, 24 Jan 2025 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737739350; cv=fail; b=JXdi7a8YG5hcjSXPnYouGyGtsjQlgZAYuyPDPblWJhAwybGoaod7AWuuxC5uyQLRMwEVJ+pcFc8W6EPQ5wMKzzlJLjnemS2JZU+5NsjAxukM6gXSKee0uo5DIgnNaFdoG5JJWgEEuiTgaBtmNwJyLxKKFpZlgeccbI3H0G3EEIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737739350; c=relaxed/simple;
	bh=M1rKHEhDFMzxrVa/Awm1uAFYRPHEfdrFINatRYcH8dM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Aef+h6te9JGiE+PdIjn4uzkWMdo/XzrfgBH2TbCz8lP2TpK9UZLGnwJgarcYTxB18RxHUDFIcJ3kRoarG472osGyX4LBHhLyp9C4nkriHT03YpwPuJWqpEWX4ESdQlrtgqH8H/lh2BRexAyuHwR/8oL8d1kTWK16+I+Le01KmY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=MbZlPDu/; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 50OEJs6L028514;
	Fri, 24 Jan 2025 09:22:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=M1rKHEhDFMzxrVa/Awm1uAFYRPHEfdrFINatRYcH8dM=; b=
	MbZlPDu/0QSdMOCazpSB3gC0RAacfRpejjest8iDbxOclBoOPi4BRSkLVzbO9xo5
	AWfKkAi7jldcZlQTSNP6g6r06m5wSMf3e6ue6L/DTnC+vexzdpKfjfWak82GDz5X
	ZgMKZCW/N2DNesjZlUv+aoDRXnd5b9SB4HhXGltQjjcKaFTi0s6HCb51DZEJ/yaj
	Y5lxIuuqcCyevH1HA25V9hlxUSihtIWWJg5FiK2YlcvNbM5ys5lypeNyxPgPfRiU
	53xwkKWLoSjw++/76q5Y1gZiQoN8SwQTFlhIZFlXHj20E9VBSm0oswUh5FXQye3r
	xOQoAuk07bs0pbZftDPDrA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by m0089730.ppops.net (PPS) with ESMTPS id 44cch7haph-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 09:22:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cw6ZlAbaQHHnCfIYoAImu30hZlOctFXttXtDIOm2dCR1ZZAnagdVcmtk+oCM00xhUOhvEXYVKfTDIoweFxD4rWoe/+Y3Oih5nOtviA4FD/SQ1o/Y1rYcpqTM7wUeZdRIh1dg821xEQQy7Dg6gIdqIybykT/WK11pYRol7j09M+0TABy/BUoB94loBiLFpQZyWRxUmKhI7xmH2xq4jIdL5v8AZw1zw2YSNLT05sOXKEqhckoFyk2gYXVoLnPjNYqi2YIWFDe2uzMr77K3gVh2eDd3LyilDbmc68G0G6JXSeUG1j5Z04VT8RvbAWTlhtuSnEXsUlEz9aa+mO88s735AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1rKHEhDFMzxrVa/Awm1uAFYRPHEfdrFINatRYcH8dM=;
 b=ygq8RP4BTKBJ4sZtJF3YmTk5cZsaYCQfd0Ar/1uzL94qF39DTZwH/5vhNtX1BM6l7SW5jLDbbKMdL1NmR/aGUtXFoi/4INYgAJFdmv6uLpAzZwOOcnvuMfynmiyAEsNZoKqfmctc0jf3SjomUAFIEPzUSP9VMqxM68z4tbb8S96tbqVznVIiieMjj4MbN4vKKQektPx7KHWiBCFVEjCJNsK/J5noTBOHyHrdYqMTIE64lqDZO6v5sJvMHqWCPdrIlgIfeFUU6oFWJm0OG8bowcM2sgkWL+m21BwLjQEriFrjXgcQGjWQwkJz8BP9Vu3TwzI/KPcJAYfv5MDgoE5VTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5117.namprd15.prod.outlook.com (2603:10b6:510:c4::8)
 by IA1PR15MB5444.namprd15.prod.outlook.com (2603:10b6:208:3ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Fri, 24 Jan
 2025 17:22:23 +0000
Received: from PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::90bf:29eb:b07e:94d9]) by PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::90bf:29eb:b07e:94d9%6]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 17:22:23 +0000
From: Song Liu <songliubraving@meta.com>
To: Christian Brauner <brauner@kernel.org>
CC: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        "paul@paul-moore.com"
	<paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "memxor@gmail.com" <memxor@gmail.com>
Subject: Re: [PATCH v9 bpf-next 6/7] bpf: fs/xattr: Add BPF kfuncs to set and
 remove xattrs
Thread-Topic: [PATCH v9 bpf-next 6/7] bpf: fs/xattr: Add BPF kfuncs to set and
 remove xattrs
Thread-Index: AQHbYv0ESW7blZQ2qE+D1Rk62TCJnbMluC+AgACK2QA=
Date: Fri, 24 Jan 2025 17:22:23 +0000
Message-ID: <79B1F200-403F-427A-8FAF-01D1DC485452@fb.com>
References: <20250110011342.2965136-1-song@kernel.org>
 <20250110011342.2965136-7-song@kernel.org>
 <20250124-luxus-vorsah-5a7a827680ab@brauner>
In-Reply-To: <20250124-luxus-vorsah-5a7a827680ab@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.300.87.4.3)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5117:EE_|IA1PR15MB5444:EE_
x-ms-office365-filtering-correlation-id: 94daac8d-f3b5-4761-6535-08dd3c9baa50
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b0dNSjJsS1NNcEUvUGxxZ3FTM3FZdm8rWVF0RmFuUFZEWGExNFRpaysrZTFV?=
 =?utf-8?B?eDhXN0hFSjRGMkJkWnFkZzNybVdCbm05bU84Sjdub2YzR05JYWpmNHhUTXhP?=
 =?utf-8?B?SVBUUkc0Ym9nRVhGQzh3djdYZjFVbzB5Q0xLZTBody9ZVUUxSFRSV2J2UEVi?=
 =?utf-8?B?OVpyZnY0bmdDZ0tTeGZlcHV3VDI2bjVjdmNXaGpwQkFUYWZqTzFHM2tVVTYr?=
 =?utf-8?B?dmJQc3VmUXRLTzNCcTRpVE1YMjVpWHBLRzA1UWdxVkJkOHowdzFRYjBHTXZh?=
 =?utf-8?B?UHd1RWUxZExVSVZUa0xKOFRZOVNwc24ybm5aWEs2ZjJSamVUTG9uRGhiZXF0?=
 =?utf-8?B?T01EZWxqUmNpVUpQTHNEdlpNa0g5RmN4QUZqcGx0dlVJUk4yVzgyN0syU3c1?=
 =?utf-8?B?bVFmT2c2UnFwKzVHZjl1clV4RFJFSnJWZFRPaE1vMS9MOXdoWk5Wb3Z3eWRa?=
 =?utf-8?B?S0hQaHE4SzN4K21kS3RZSDhhU1hzUytCeXNGdDU3ek9PWlNXTWtrcXVHRVlR?=
 =?utf-8?B?cnozQVo5Q0lQUno2ODN6Z1lyckh0U3F6MUoxdWEwZHhZRzJhWm84dkd5M2VK?=
 =?utf-8?B?eHFFeXhTVUJKdGtkeWM4MmJHY3dRZkhKeEFISC9UOVFPWDdCMkhpaXVhWXZJ?=
 =?utf-8?B?ZWxvVHhrRVc5Uzk2Tk53eWtobU1rdXBZU0FZZ3o1TCtmekdHUjZIdUx1eGE3?=
 =?utf-8?B?QXU1VTZQSmxZVnZlbnhnb2J4UDRweU52emtpVkxMc04vVHJYUjBlNy9Wcmx2?=
 =?utf-8?B?WGhSWGZGU3gvcmJIZXpkbjIvL0lnN25kWUZadWlMZSs1bDdCRDdEa3JRMjdi?=
 =?utf-8?B?Q1prU3l6YmtHUFYwNmRMSjA3ZTdCb2xxZjRyRUJCeTdJV0JYenZvRUpRWWdQ?=
 =?utf-8?B?eExEOVh2M2ZFemRRV2lMMXRBY3h4dTcweFlYODNOWVcvMjBWOTNMQXFxdHlU?=
 =?utf-8?B?Y0FtN09XY3Nsek9CRnZoWTJDbDFHbklNOXN4YzF4SC9xVHJXbGEwYXRWRWt6?=
 =?utf-8?B?ek9ZRStPUHAvVHRSRUpHT00xVmxTL0xrUTVublRFdnlIZ1NHN044ZWQ5cEJa?=
 =?utf-8?B?N05mZkxsWXZhTEVONS9jYVdFMU9LeDd2SXV6dWQ0ODhPWFBTZjB0dGRVbmdv?=
 =?utf-8?B?TUw4cHVROU1GNytTYXBvZ3Z4MjB5TFoxcVhVYmx4MVBZbHNSNU1FL3ZDbWJj?=
 =?utf-8?B?Szl2OHhvbVV2Kyt4ZjJYVGtNQkpRVjhuN2NIR2ZHNHVFT01GWUNFUmhEQks0?=
 =?utf-8?B?RU9xaE83a0hraldmeHlydUZPcTBzTm9HeDRoRTFibWxQTHdudDJ6Sk9Wc1V0?=
 =?utf-8?B?VlQ5UXBQYmVDZDlyS0E1a0xrNnFtay9ORzBmaEIyYzE0VWV2UDU1TjJaVkth?=
 =?utf-8?B?RHdiVktmOFNNOW1HRXE2eksrOXUyNUlwUXhvbWlBSGd4TmZCNVAxa1BZSHEx?=
 =?utf-8?B?bXB0RHZ0YTJ5NGltczh2RVhRT3I4eXc3dVpQZlVQUERLTGdxdDlHaVBPUXAv?=
 =?utf-8?B?NmI0eW5BalZOcTZ4M2l5NVg0YlJreXlaU0RyVURkUy9MVVBxQkgralZ0OXdn?=
 =?utf-8?B?cmkvZWpOTGxqcE1qV2pCK3loeEw1TEYwcWpNdmxpK1c2czJzeTRmUjJINFgr?=
 =?utf-8?B?WjlETUs2WW1sSHFwNlYvdEZYVjBRR1JURFlCNk16WHN4N3hTTFRTb2VVVUY0?=
 =?utf-8?B?YnlsZDFCYndNSmZlSlRUTEJzOVNPa3RBb1ZGMU9ySDlEM2NpNGtBak1TL3p2?=
 =?utf-8?B?VzVnSWdCeDBtckhzditieG9jaUtLcWxzKzh0UEMwU3oyK08ya0V4MTNqQkI4?=
 =?utf-8?B?K3A0NGs5a1FNUUtmWWllUVdlVGo3b01Jc0s3bTZXRjFiTkxwajR2eVp2UXJ5?=
 =?utf-8?B?UVZNU1Mvb01BUjZxM0xtTmFpdE5FZGNSZHZzV2JrWUhYdXJSV29KUk5WNmJO?=
 =?utf-8?Q?g9FYjZ9fxR8gmx5eKqbwKkkYyI2PeZ96?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5117.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MjVRdUFZb0Rubk9MTFEyM2MwRk1hUGJRaGNxNnJYUStZRDBQaUFYTkU2NDB2?=
 =?utf-8?B?bVhqd1VESzdsYjJFK21tTk1sM0tKUk9LS2xra0VSZHUrRFRXUllJNnhVeFVG?=
 =?utf-8?B?MmNLQ3U0UUFMc25maDZoMWRJdGIzTXhzTUlaVzdtWmVHUGRha1ROSVVzdXVK?=
 =?utf-8?B?NTFIQ1pYT0wzUDVRYkVSNGZucndqZExIeTdZVnp3a0N3ZmRpaFFaUFdrbUlz?=
 =?utf-8?B?bERYUHlWcWNyaC8yZ1hPQ1YxcXFmTkpFUmJDam1ZQXg4WEMzTDRYOVo5ei9T?=
 =?utf-8?B?OWJEbmdqQ2EvbEY0aVhtdlpDeEdvcWNpbnFtRGs4aXdBQVNodTZVbFpmTjRD?=
 =?utf-8?B?VHJ2YnVTV1UwejdmL1pRRm9KaGgrNk1CUXR0d3Z0RnBMWDU3aU9ERERZSU1v?=
 =?utf-8?B?SkloRmJsdlUzU3dHZnhadWRWOGtMSGlrSVpHQzZJTlQzY2hiajlLT3V2NW5G?=
 =?utf-8?B?QThhWWhLd3hQNEIya09QM1FwUnFGMzZETFhpZlNlSDZheDBaTTVLdGJ0anhC?=
 =?utf-8?B?UzdEUS8zeWdIdjJyZHZGeTVLVWFJWVdMSTVNYlJPN2M0bzlTVHZoZmNwRHIv?=
 =?utf-8?B?L212TENqSzVXTHZ1elJtelpmVmgvSzUrNUxiZCtiUkV2Yy94Y1MvOWtzZml0?=
 =?utf-8?B?Sm9OMGlkUk1EYlZTUXVrWndITklCYzNGR2xwSUV3bjE5b2R5SUEraW01eUVY?=
 =?utf-8?B?N0dKR29HY2tQc2srVnd2VFZaaUVnOEkxSERzWUJnTCtSelJaRmNCZ1AwR25G?=
 =?utf-8?B?OThDT0hFN2lZdnRacGJEem1NU1FjOGxQdjAxUXpkSDdNaUFtNW5hU0Fnd0Nn?=
 =?utf-8?B?TXBsVDJCZnA2ZGNUTERRS1NrNW16cStJUVdmN1VsQ3JGOEpkRUMzYTJZZWZF?=
 =?utf-8?B?VGFZQXJBZXUyL05wbCtFcXJoamM4WStyNXFyYk1EelBUZGRBbmZXdmRkZi9K?=
 =?utf-8?B?ZzJzWExaVTFnVVg5eVMzN1NqUVlYU25NT1g3YzF2ZzIrdjBtR0U5aHpRNFNi?=
 =?utf-8?B?UVA3UnBaeHRZc3pJWVNJazVDZCtUOUp0c2UvZ2tDSGtoaG5PSUZnWHlvcjNa?=
 =?utf-8?B?ZXRGU1dNN1FmODhVeUZLbGc2bVVHZ28zVmwyTjNpTm0vWU9WY203bm4yY0Zs?=
 =?utf-8?B?dUwvTU5oUFNPU2gyY1ZHVEk4L0ZScmowVUxNWmhpRGJWSXQwaStCRXM2eWtz?=
 =?utf-8?B?Qi9KUTF4SE5tTXd0aHA4dTd6RjhCejJDUXZZdmZwVmpGc1J4eDZuSWIvSlJj?=
 =?utf-8?B?RkdRUXlZdUkya2hEa01zTW9aNVdMSGY4Q041bC8ybUs4UldtWXNIcXFBQ3hS?=
 =?utf-8?B?RUpoZlVhVVM2c2xNdlhtaHVvVXdEb2Zod1g1eGhmbTRTYlZySFc5TTZtaTBm?=
 =?utf-8?B?Q0x2U0ZXekk3TU93VGh4OVBpTHEwOEs0S1RwU0tjOVRnQTJtWk1iZkxzeFEy?=
 =?utf-8?B?M1Nkbng0bjREWjMrOFRUVkxEMHRZVFBzanVmVEJFMmgxMGFmMDBYNXBNVEtv?=
 =?utf-8?B?VVFBQVVXbzdmRXZISXRMdW1NaE9BbHRQRkJJdDBHai9iL2VyWEVZTjZnbzdN?=
 =?utf-8?B?Q2JXaUdsRC9Uc0dMc1dtTjR1dU5WQWFDZWN0WHBmR0VjRUxXb1kxRW1nVFBP?=
 =?utf-8?B?M3hpNlJrQjBuTlo2TEpDYjFJdmpFRFJvT01yM0pldlpvVllsTnc0RGVqcitk?=
 =?utf-8?B?aFJHWEFMSExWeDcxMzNPaElBV3NLNENTV2pQeEE1L29wWkRQMWtES2o4MUE4?=
 =?utf-8?B?cExVQXJQY09UeWJmamlEWmEvZVJmZVdBVFphc3NJengya25uYVVMNHNDbDNa?=
 =?utf-8?B?V2MxSzFlZlFYbWdXS25PSDVKd3B0UGdKTDY5c1dsYXdyZitFYkl6MFMzbHlU?=
 =?utf-8?B?QTVtRTE0SUcxa2kvbGlWSXY3V1RnbWFOdWZaeFhObEFLYktrck1ncXV3SUFm?=
 =?utf-8?B?eFhBLzhqOFFHNURVdmV1V0lXZmNQQlFSVi9MV0tMdDFNV2JKbHprYVJLMG1C?=
 =?utf-8?B?bXZwbkZKWDltcXNkcHBqL1Yvd29jTGwyd2xsNVJQellvU2NqNWtCWjRSVnNp?=
 =?utf-8?B?a2dTTEhZL2grSFN1aE5ueFBabXliTTVmMDczVUN0WmRqamdENkRYRllwSmN4?=
 =?utf-8?B?d3hEdlJ3R3crMVpYRS9IZUZ6QXFtN3BsSS92NHFzRGZUdmJpdlpDcGdJbnVE?=
 =?utf-8?Q?bUy319HXFAvCcVlcFBB6qZM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4983400999C0AB46A66696A0E60E6AB5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5117.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94daac8d-f3b5-4761-6535-08dd3c9baa50
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 17:22:23.1454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fxdfDg0hZzykWRemoCYzPAcBp4mvt8PM3VhGeu+by5IlkjiP22cK+bcoPAa7fBilaW6cuD2eW1/gvBlKzITFKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5444
X-Proofpoint-GUID: jTbmpp6__PYrsut3PlIwgXuWNoQ0_f5A
X-Proofpoint-ORIG-GUID: jTbmpp6__PYrsut3PlIwgXuWNoQ0_f5A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_07,2025-01-23_01,2024-11-22_01

SGkgQ2hyaXN0aWFuLCANCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3IQ0KDQo+IE9uIEphbiAyNCwg
MjAyNSwgYXQgMTowNeKAr0FNLCBDaHJpc3RpYW4gQnJhdW5lciA8YnJhdW5lckBrZXJuZWwub3Jn
PiB3cm90ZToNCj4gDQo+IE9uIFRodSwgSmFuIDA5LCAyMDI1IGF0IDA1OjEzOjQxUE0gLTA4MDAs
IFNvbmcgTGl1IHdyb3RlOg0KPj4gQWRkIHRoZSBmb2xsb3dpbmcga2Z1bmNzIHRvIHNldCBhbmQg
cmVtb3ZlIHhhdHRycyBmcm9tIEJQRiBwcm9ncmFtczoNCj4+IA0KPj4gIGJwZl9zZXRfZGVudHJ5
X3hhdHRyDQo+PiAgYnBmX3JlbW92ZV9kZW50cnlfeGF0dHINCj4+ICBicGZfc2V0X2RlbnRyeV94
YXR0cl9sb2NrZWQNCj4+ICBicGZfcmVtb3ZlX2RlbnRyeV94YXR0cl9sb2NrZWQNCj4+IA0KPj4g
VGhlIF9sb2NrZWQgdmVyc2lvbiBvZiB0aGVzZSBrZnVuY3MgYXJlIGNhbGxlZCBmcm9tIGhvb2tz
IHdoZXJlDQo+PiBkZW50cnktPmRfaW5vZGUgaXMgYWxyZWFkeSBsb2NrZWQuIEluc3RlYWQgb2Yg
cmVxdWlyaW5nIHRoZSB1c2VyDQo+PiB0byBrbm93IHdoaWNoIHZlcnNpb24gb2YgdGhlIGtmdW5j
cyB0byB1c2UsIHRoZSB2ZXJpZmllciB3aWxsIHBpY2sNCj4+IHRoZSBwcm9wZXIga2Z1bmMgYmFz
ZWQgb24gdGhlIGNhbGxpbmcgaG9vay4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogU29uZyBMaXUg
PHNvbmdAa2VybmVsLm9yZz4NCg0KWy4uLl0NCg0KPj4gKw0KPj4gKyByZXQgPSBfX3Zmc19zZXR4
YXR0cigmbm9wX21udF9pZG1hcCwgZGVudHJ5LCBpbm9kZSwgbmFtZSwNCj4+ICsgICAgICB2YWx1
ZSwgdmFsdWVfbGVuLCBmbGFncyk7DQo+PiArIGlmICghcmV0KSB7DQo+PiArIGZzbm90aWZ5X3hh
dHRyKGRlbnRyeSk7DQo+PiArDQo+PiArIC8qIFRoaXMgeGF0dHIgaXMgc2V0IGJ5IEJQRiBMU00s
IHNvIHdlIGRvIG5vdCBjYWxsDQo+PiArICAqIHNlY3VyaXR5X2lub2RlX3Bvc3Rfc2V0eGF0dHIu
IFRoaXMgaXMgdGhlIHNhbWUgYXMNCj4+ICsgICogc2VjdXJpdHlfaW5vZGVfc2V0c2VjdXJpdHko
KS4NCj4+ICsgICovDQo+IA0KPiBJZiB5b3UgZGlkIHlvdSB3b3VsZCByaXNrIGRlYWRsb2NrcyBh
cyB5b3UgY291bGQgZW5kIHVwIGNhbGxpbmcgeW91cnNlbGYNCj4gYWdhaW4gYWZhaWN0Lg0KDQpF
eGFjdGx5LiBMZXQgc3RhdGUgaXQgbW9yZSBjbGVhcmx5IGluIHRoZSBjb21tZW50LiANCg0KPiAN
Cj4+ICsgfQ0KPj4gK291dDoNCj4+ICsgaWYgKGxvY2tfaW5vZGUpDQo+PiArIGlub2RlX3VubG9j
ayhpbm9kZSk7DQo+PiArIHJldHVybiByZXQ7DQo+PiArfQ0KPj4gKw0KPj4gKy8qKg0KPj4gKyAq
IGJwZl9zZXRfZGVudHJ5X3hhdHRyIC0gc2V0IGEgeGF0dHIgb2YgYSBkZW50cnkNCj4+ICsgKiBA
ZGVudHJ5OiBkZW50cnkgdG8gZ2V0IHhhdHRyIGZyb20NCj4+ICsgKiBAbmFtZV9fc3RyOiBuYW1l
IG9mIHRoZSB4YXR0cg0KPj4gKyAqIEB2YWx1ZV9wOiB4YXR0ciB2YWx1ZQ0KPj4gKyAqIEBmbGFn
czogZmxhZ3MgdG8gcGFzcyBpbnRvIGZpbGVzeXN0ZW0gb3BlcmF0aW9ucw0KPj4gKyAqDQo+PiAr
ICogU2V0IHhhdHRyICpuYW1lX19zdHIqIG9mICpkZW50cnkqIHRvIHRoZSB2YWx1ZSBpbiAqdmFs
dWVfcHRyKi4NCj4+ICsgKg0KPj4gKyAqIEZvciBzZWN1cml0eSByZWFzb25zLCBvbmx5ICpuYW1l
X19zdHIqIHdpdGggcHJlZml4ICJzZWN1cml0eS5icGYuIg0KPj4gKyAqIGlzIGFsbG93ZWQuDQo+
PiArICoNCj4+ICsgKiBUaGUgY2FsbGVyIGhhcyBub3QgbG9ja2VkIGRlbnRyeS0+ZF9pbm9kZS4N
Cj4+ICsgKg0KPj4gKyAqIFJldHVybjogMCBvbiBzdWNjZXNzLCBhIG5lZ2F0aXZlIHZhbHVlIG9u
IGVycm9yLg0KPj4gKyAqLw0KPj4gK19fYnBmX2tmdW5jIGludCBicGZfc2V0X2RlbnRyeV94YXR0
cihzdHJ1Y3QgZGVudHJ5ICpkZW50cnksIGNvbnN0IGNoYXIgKm5hbWVfX3N0ciwNCj4+ICsgICAg
ICBjb25zdCBzdHJ1Y3QgYnBmX2R5bnB0ciAqdmFsdWVfcCwgaW50IGZsYWdzKQ0KPj4gK3sNCj4+
ICsgcmV0dXJuIF9fYnBmX3NldF9kZW50cnlfeGF0dHIoZGVudHJ5LCBuYW1lX19zdHIsIHZhbHVl
X3AsIGZsYWdzLCB0cnVlKTsNCj4+ICt9DQo+PiArDQo+PiArLyoqDQo+PiArICogYnBmX3NldF9k
ZW50cnlfeGF0dHJfbG9ja2VkIC0gc2V0IGEgeGF0dHIgb2YgYSBkZW50cnkNCj4+ICsgKiBAZGVu
dHJ5OiBkZW50cnkgdG8gZ2V0IHhhdHRyIGZyb20NCj4+ICsgKiBAbmFtZV9fc3RyOiBuYW1lIG9m
IHRoZSB4YXR0cg0KPj4gKyAqIEB2YWx1ZV9wOiB4YXR0ciB2YWx1ZQ0KPj4gKyAqIEBmbGFnczog
ZmxhZ3MgdG8gcGFzcyBpbnRvIGZpbGVzeXN0ZW0gb3BlcmF0aW9ucw0KPj4gKyAqDQo+PiArICog
U2V0IHhhdHRyICpuYW1lX19zdHIqIG9mICpkZW50cnkqIHRvIHRoZSB2YWx1ZSBpbiAqdmFsdWVf
cHRyKi4NCj4+ICsgKg0KPj4gKyAqIEZvciBzZWN1cml0eSByZWFzb25zLCBvbmx5ICpuYW1lX19z
dHIqIHdpdGggcHJlZml4ICJzZWN1cml0eS5icGYuIg0KPj4gKyAqIGlzIGFsbG93ZWQuDQo+PiAr
ICoNCj4+ICsgKiBUaGUgY2FsbGVyIGFscmVhZHkgbG9ja2VkIGRlbnRyeS0+ZF9pbm9kZS4NCj4+
ICsgKg0KPj4gKyAqIFJldHVybjogMCBvbiBzdWNjZXNzLCBhIG5lZ2F0aXZlIHZhbHVlIG9uIGVy
cm9yLg0KPj4gKyAqLw0KPj4gK19fYnBmX2tmdW5jIGludCBicGZfc2V0X2RlbnRyeV94YXR0cl9s
b2NrZWQoc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBjb25zdCBjaGFyICpuYW1lX19zdHIsDQo+PiAr
ICAgICBjb25zdCBzdHJ1Y3QgYnBmX2R5bnB0ciAqdmFsdWVfcCwgaW50IGZsYWdzKQ0KPj4gK3sN
Cj4+ICsgcmV0dXJuIF9fYnBmX3NldF9kZW50cnlfeGF0dHIoZGVudHJ5LCBuYW1lX19zdHIsIHZh
bHVlX3AsIGZsYWdzLCBmYWxzZSk7DQo+IA0KPiBUaGF0IGJvb2xlYW4gYXJndW1lbnQgaXMgbm90
IG5lZWRlZCBpZiB5b3UgcHVsbA0KPiANCj4gdmFsdWVfbGVuID0gX19icGZfZHlucHRyX3NpemUo
dmFsdWVfcHRyKTsNCj4gdmFsdWUgPSBfX2JwZl9keW5wdHJfZGF0YSh2YWx1ZV9wdHIsIHZhbHVl
X2xlbik7DQo+IGlmICghdmFsdWUpDQo+IHJldHVybiAtRUlOVkFMOw0KPiANCj4gaW50byB0aGUg
dHdvIGZ1bmN0aW9ucyBhbmQgdGhlbiBwdXQ6DQo+IA0KPiBpbm9kZV9sb2NrKCkNCj4gYnBmX3Nl
dF9kZW50cnlfeGF0dHJfdW5sb2NrZWQoKTsNCj4gaW5vZGVfdW5sb2NrKCkNCj4gDQo+IGZvciB0
aGUgbG9ja2VkIHZhcmlhbnQuIFNpbWlsYXIgY29tbWVudCBhcHBsaWVkIHRvIHRoZSByZW1vdmUg
ZnVuY3Rpb25zLg0KDQpTb3VuZHMgZ29vZC4gTGV0IG1lIHVwZGF0ZSB0aGVtIGluIHRoZSBuZXh0
IHZlcnNpb24uIA0KDQpTb25nDQoNCg0KWy4uLl0NCg0KDQo=

