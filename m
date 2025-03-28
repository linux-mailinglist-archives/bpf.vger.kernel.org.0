Return-Path: <bpf+bounces-54869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CB7A75002
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 19:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CCC5179FAA
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 18:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7350F1E1E0F;
	Fri, 28 Mar 2025 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Xx4YEWT8"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F9B1F099A;
	Fri, 28 Mar 2025 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184611; cv=fail; b=FiSeqtgbzsws3YhKzQEn0BTegFPrIcM786bUr4AJbnUd0D+kEOC+42I+ODaIpDe689ijfu2frL/unXebURgT53pZhBRgIQ9dELuYxkPAyGkFtn+Ef4W2ETEJJc1VlN69M/86RifDUlSQ/WZA0+pMIWtym2k4GvmbEVlmHnN5E1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184611; c=relaxed/simple;
	bh=44rOTs8bzGRuA6ojpt/xSh/pb4JJ1HD9WM2y4Et7QgI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C64M1uQ7r8hqMmmiMgwrFePmu4rqeaR9WroS60Y3RAbk/5rpu6Xbo9cvxh25IhyXjHTgcqT9EdjiomLmTRWfpu2kwMCGykoKESHJmdwxDLzy+6CqRc6o6BpDtKlKYIE/5UbFK0EWCjqx8iUqypNanQ+1KGV6hj3FlMdi1qF2fbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Xx4YEWT8; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 52SHkj2j018225;
	Fri, 28 Mar 2025 10:56:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=44rOTs8bzGRuA6ojpt/xSh/pb4JJ1HD9WM2y4Et7QgI=; b=
	Xx4YEWT8xBOb+8mzpriCvOVKHyQry0uTAjI1HK5uYX5AfSMEyOLVU09Cd0ArVFor
	O8s7RAKv+dXdz78a8SscYZBWag5frqzTrSQcan+TEbS2oPPoZXtSMkcydvJg4NOU
	aAqfT7ZQ2XtXxRKT3X7pi5gWJG1JqecTlQFyggTExG0h0UXa5gnp54PbzWIQ83v/
	AnreWhm9X9gPl1TUU2YvfS/krGgKrf3aRZxi6YNdKkmqeq2V6bQS0Jha9S6tYHJa
	HHcxPwj3U3Me+W1m9BSwvah7OM/eL1rN0+x0VhZOFsBdILcL6x57nQuHSc4uJREN
	JVaVmbeINOIGAXCyVUM9Xg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by m0089730.ppops.net (PPS) with ESMTPS id 45nx6ghadc-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 10:56:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCpWrDllvx3t39Vp9PVL3yXKodld8VurEFFt15Fl3frxHo865nmunhU8wYnGUDOuJnotdv/bKHukOlQ9vP+sZSL3Ytqi+fe0ZvJfwLylAHcAjL3nGEMDcHCjvkb8W0/aQ4+hvyjGkUJX8ldkyhAjcgA7vpqxAgGHC+ZxYmXMGCYkkVzcKbi4/LSeE8h0UR4YkQJ9XyvumnoVyqWAsr1R3lGLphUzRswZdzMc4jdRpSElIJnkTJ99hn2i2vQ7vqtTOwfpmGg/vhvHdAssUJE2+oGGqvR2AhZeRn4j6NtUqJPznsW2gyVP3GFLO2T1GqOsNuyx5znGEu+p+RpMmuOxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44rOTs8bzGRuA6ojpt/xSh/pb4JJ1HD9WM2y4Et7QgI=;
 b=UKKPCeqf0F0pAN84ZwXPoqZArOJYFekS1RLIgTHdti1b2XbVDtwN0cuEsUlPZg6JrOZgPz6XcgGTtUd5+rjOjrPnG1ExbsocmkaEfRp7vAxy8zHr7DhPhI3a2wJ2h0FH+15aSrRU5QGkuxzi5+IZL6WKSqmwjzTtrLpx45ry3sPiN/9QVpfETWswswGFOVK6ak9MgoEmNcWljGnicUx47lcdRnka2d9YMUIEVVpV1EKT+qv9BvFaYjTPYxj0RzVjGeamQtSqypOn6gw8ItoAAbusgLWFtxbZGzuHd9AU0RiEKx7+2a9UPOaNfeviWyNq0Z0DckGPM+DYSbjcFiqpeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5117.namprd15.prod.outlook.com (2603:10b6:510:c4::8)
 by DS0PR15MB6207.namprd15.prod.outlook.com (2603:10b6:8:161::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 17:56:45 +0000
Received: from PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::90bf:29eb:b07e:94d9]) by PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::90bf:29eb:b07e:94d9%6]) with mapi id 15.20.8583.026; Fri, 28 Mar 2025
 17:56:45 +0000
From: Song Liu <songliubraving@meta.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "ast@kernel.org"
	<ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix tests after change in struct
 file
Thread-Topic: [PATCH bpf-next] selftests/bpf: Fix tests after change in struct
 file
Thread-Index: AQHbn0nbtgKt4aOwa028+sRFp69SjbOIz4YAgAAHYgA=
Date: Fri, 28 Mar 2025 17:56:45 +0000
Message-ID: <8536CB49-0091-4019-839A-B460847995C2@fb.com>
References: <20250327185528.1740787-1-song@kernel.org>
 <CAEf4BzagkTArcqnvqgu7kNq31QFsATM36OGPLs4-GFOo0TDxsg@mail.gmail.com>
In-Reply-To:
 <CAEf4BzagkTArcqnvqgu7kNq31QFsATM36OGPLs4-GFOo0TDxsg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.400.131.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5117:EE_|DS0PR15MB6207:EE_
x-ms-office365-filtering-correlation-id: 4deb0c1d-c10d-42d8-0f73-08dd6e21e76f
x-ld-processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?amQxaFpxbVY3YjNEMUxCREFTbkFiR0l4NFhTckxpamh6MjNpVkJJckxJclpm?=
 =?utf-8?B?a01VR200WGUreHhFYTMzWTRFRGlRbmhHWmlWbWJjY0lUcTVJSHlMa3pMUkY0?=
 =?utf-8?B?MXA1TVJLVVRxOWVJRXVhbG1VN2R0WTJMbkxYZ2tOdkJad3kzNG5XWlRhUkRO?=
 =?utf-8?B?TlUwQzBOdkE1bENudStpTXFQZWdia2wrV2FjMUd1bEtJZ05PN0hrTHNqeTJG?=
 =?utf-8?B?QmZaRFlFTXIvaUhtblg0YU5Dck1JRWlVRnZmZnZKajhZcW1CYXdGZG5sU2dv?=
 =?utf-8?B?KzkxSzhTWTdKcmU2UTdFa3NmSmtHQWFWcldGVkxZS0xsM21OSkxsNWNGa1Ur?=
 =?utf-8?B?VWdxQkQzWm96SXlMN0NrSFpiWm43OVpENUV0Ujl4TWdYR2JsWjF4TEl2U2dv?=
 =?utf-8?B?T3Njc2ZVTGI3dXVCNitsd3ZvamJoSkFWeVJpd1k4bW5FOHVZVHJ1cndBY0hQ?=
 =?utf-8?B?d013aVJQenNQMjVSWnI1UUFFeVVoVTByOXE3N2hhQWVlRzQ4aHd1UFA0ZzZi?=
 =?utf-8?B?UUdRcTZSdnFmR3UwdWJ0aFp3T2hPREtHUGZSWDJMcllhQmdNcjJ4MDNrVHZo?=
 =?utf-8?B?MnV3eUlsRTdzS2RCZ29Ubyt3a284SnRrUkg4OXhKOGNySDBkMVdRODFLaE1U?=
 =?utf-8?B?UmN1NmRMZm53ZTIxUEw3NzBtV2RRblRnbU5ad3NYL1Q1SmlJK3lxUDFXSU9I?=
 =?utf-8?B?N280UlBEZWhGUTQ1bmJRS0VqSXE4WkVRcVgvUFo2K21tWHZOTVM3WW9YRGxm?=
 =?utf-8?B?ZDBSR29ic1V2ZDFZZTFXRlI1aHlnM1gyT0RjUHNmOENTRmlYeStJTm1ialV6?=
 =?utf-8?B?dmNjN25BSjVyMDRBSTdiNGt1TDk4RStobHoyVFp0UjFSSVRMd0pOc09kWmlx?=
 =?utf-8?B?UEFBRi9xd1VCMng3SmxjZkhVZ2dnTi9QRjVvdjRsMHE2NDByenc2elE2dkIv?=
 =?utf-8?B?Q3NUdlZmNHV6UVNoSzRTUTRuS2ZXWTNISWdudGd1citPZVZWcm15ZlhZaDc1?=
 =?utf-8?B?ODVkVWxjdTg0dEJnUDdscjNSUnJGa3JmdDlMVnc5S2YvcTZ4OTdlejRVMzBM?=
 =?utf-8?B?NFFPUVNwbnkyeEtYQnpEdHY2RWRFUnkxVG85bGd2S2ErZzNGaDhFd1VKRXJn?=
 =?utf-8?B?cnJJTXo0SUJva2g2WTcycU8xM0dkTk1FVTFxY0FYcnp5NDJmTnpOdXJ3SFBF?=
 =?utf-8?B?RFRpUVFrbjUrQlk3QndLZEt5cEl1N0hrcXA0V3JqMnJwZGhDaEQxZENWRkVS?=
 =?utf-8?B?UjI0czlVQmlJQ0RrL0dmY3ltZTVjWktkeEh5TVZaRjFmWmw0Z1dGMTRFWVht?=
 =?utf-8?B?UnFWZ3FPSnpUeDJReHJudDdTUURGWnBYZk5Ma1A1My9rV2REQkZOTVhaUGxE?=
 =?utf-8?B?U0wxVWQrRUJYNlQzY3MwZzNSTU1FaWdoaEhVOHFEZGJ2QW1kcmZTK3pCNmhu?=
 =?utf-8?B?UENWT0N1YXNjNUsvZ0lmVGZuWThIUEUzSGRhRitQUldnSFNvbitHMGpmOS9x?=
 =?utf-8?B?ZVVoNmUvSzlqbm1US0lLWTUwRHhidGhnRjVPMTlkNEttR3NBMVR0K2NmblFi?=
 =?utf-8?B?a1M3bjh6bjRxcDcvM2QyeDRxR3crOFV4V05OVlp4NitoTENicE1tOXlwV1pY?=
 =?utf-8?B?anhyckUreDF5SVdaRURYSlZ0M0I0aHlxdU14N0lpMXQ0a0FWV1lFNjNpdGN1?=
 =?utf-8?B?RkdlOFZaUlVqTmlKNlo2Z1JzQnc0cm9OQ0FVdXJBbURqY3Y1dy9hTlR3YTBP?=
 =?utf-8?B?R2NReFRWbjllbzBoc0RFU0ZrRDE2TEJoVHFOcXdEZkFMRitJQmFBMXRob3Ru?=
 =?utf-8?B?R2xvRVFSOTBHT2Y1TktpTUVvbnYxSjRhUUF1T2lHWmtKT2hPaTJIUVN2S0Np?=
 =?utf-8?B?TTJFaEwwUHp3dnAwSTl4NkRaM1h0RFN5UXVsMmFITzZwNjU1ODZtbHRFL3Fi?=
 =?utf-8?Q?UxKlFoJEfiCKw63CAsrU3MQOmbey2EfL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5117.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2dHOSt2YzlXNXVPUGlvWFU3SXd6b0FjTFdSWnZ1R1hGRHlmSTVsdGcrTmFZ?=
 =?utf-8?B?STVPRHFaQk5RYk5YTjl3UWtxYkJOb2VXMlpFa2xaSk1sazRpeVU1V1U4Znpy?=
 =?utf-8?B?bm9GYnBEdmVrc1VCSzlzaFBOdU5PTzFMRGtScEs4OEljZ1NySklGejhmVU1q?=
 =?utf-8?B?QVJLbTY0ekxOS1dFSDVORmNxRStnajlleVR4RlAwMTZZREozVDBXMzFTNks2?=
 =?utf-8?B?cXBueFdrQTE2ZGhPa29mdVBpTUV3QVY2REdJaU1nQUxTbTcvbGdlTC9xWDBt?=
 =?utf-8?B?STlpNFhMdlE0NHJkbUpXQ21pZ3lDWFkwN2pNVk8vTG45eWR0a3hISjV2cXJM?=
 =?utf-8?B?VDBaanFuQktKOXF4RDdaZ0ZraUlMN0RrOGpXS0hPM3hRbkhVcEk5RDJRSkl2?=
 =?utf-8?B?aTBpUDRmd1ZRYjNTdG1paXFDMzJicVZvZWMvc2ZaN2pRaW9uMnJwUmQyVnRO?=
 =?utf-8?B?NjRTTUI3TGlFbGNSZWJOMFBnYlVDYUM4Z3hoMTVTWEtiNjR3cjBneUFVYjBt?=
 =?utf-8?B?Tmp6dUZScDZCWDhZTy9ZOG5PR3dEOEVmbW5RMmY0ejQyTXVsL2dNQU50RFlE?=
 =?utf-8?B?TlFYNnVuWTFkTTZNQlVCQ3VtOXRiaEJITlN6R20xOXAza0U0aGxIbWwxNUpE?=
 =?utf-8?B?bnl1czhhempaaVlpT1BMb0FRM254bDlFbVljYjBaQmM5Z0VRNlNIdmdYYnRh?=
 =?utf-8?B?UzlzaEVEcFV6bFNvMlNGWnVlK1F3bUQzK3V3bmpPOXEvM3lyK3Y1NWc4Q2tF?=
 =?utf-8?B?VjNVRUJvZ0lxbG9Tb0RFNGR1ZDhXSDlwMkNWaC9sWU91ZlFlb0FWOFcwbXli?=
 =?utf-8?B?bDBpYXJoUTZGUXUvU3kzNitueGRETy9jdWc0TURQYSs0Y3hQV1g1dEQwbzI1?=
 =?utf-8?B?T0hBSkRIU0t5YlFGQ1RHREwvc24yajhNb2xpbXAxak9iV01RZlEwZk1aTGNZ?=
 =?utf-8?B?OFBsTUgwZVVWSnJyTDA0NWtpRVUvbUVJUU0rTGZ6TTVUdytRbTZaLzY2OHBZ?=
 =?utf-8?B?OGJraElvRy9mcWwvN1VWbjQwT0ZrenBLaTM5dTlYQ3RLYjFOckNuNEY4dHc3?=
 =?utf-8?B?a3BpY2N4SktMQ253aXFqTi96S1lBbHRZamY1R3Fnc0NpNzgyVEdDckR0OXRs?=
 =?utf-8?B?bmdqRTEwYlRLelp4dy9aYy9ZejBmOStHKzcxSXJJdjdMVHl5THc5SFI2Ykpv?=
 =?utf-8?B?a1lYbHZPKys0UzRwVGFzV1FwT3l2aXFBcE94QjlZT1FxTFErZXZYQi9teE5D?=
 =?utf-8?B?VGdGRUFDSHJod1IwSE45TUVqY05sdGo1aWxoZEN0UnRBNlVaRjRxdnc3TlJu?=
 =?utf-8?B?VU5wcXNoK0R3V3FJRjRYZ3ZNVHpxN3ZqOVJoMVlMTUVwZ3VnVlRoQ3kxWFpP?=
 =?utf-8?B?MEt3eHppcVh2dVI3Z1FxL3B3bUR2SEthTVBlZ1RKV1JTdU9IaHRXRDY0UmFS?=
 =?utf-8?B?WnFwMmtTMlQ5T0pkVXdmcEhDVjNFRzc4SUc4S1lPditaSzV1S1kxYThHWE1k?=
 =?utf-8?B?bXVOdlpJUnJCd01QRHZRRWZ6Ukk1R2lFS0hHQzQ0S0xlQmJJdm5MdUU4UzZV?=
 =?utf-8?B?L2oxWkVqNThzVmNxa2FEVjQ5dDVOVW1vVlQrOHFvSERmcEhLRVA5T1Ryb2VP?=
 =?utf-8?B?QmhucWdGUitxOXROYzZ4Yzg2a2R6NUducEpHZjM3OHZSYkZxRnVMSEkrNWZQ?=
 =?utf-8?B?dkJGcFZ4REQwNGJIeWQ5Nk9rTGR3VDF4TGRoYzVPTSsxTENtUWtyd2NrTm11?=
 =?utf-8?B?dEtrMHZLT3p3REoxVnFISm5wUUhWRXJCdnF0WjhLOVloUm4rZjh2Y2lRNnll?=
 =?utf-8?B?dVU3SHBIaGpTOHVJRWN6Nkx1aXRIcmkxbHAxV0ZIeElQT3ZHME9YcVUrRWZl?=
 =?utf-8?B?dGVmZGt1ZC9YZ3ZRTVJQem4rai9CT3BndzJjOWFjN043Wk83RHFINWp6NFk4?=
 =?utf-8?B?RVNGSUYxTzBDM1N3UTJ1WjhYcldEOGJGVlREem94Q3NrMG8wbnFlLzFtdkZ5?=
 =?utf-8?B?Um9qaXQ0WDh6a0RCUXg2UHY4VVRQcWxmMnEwRStmSnlsYURoc3Q5NVp1MVBK?=
 =?utf-8?B?TGhDZEhicml6MjcyVVN5aEhaN1hUcnBrVnpPTk9HV1JPSHg3QWJjcWlFVkV2?=
 =?utf-8?B?LzdrTDNFWkpRbEZQNHBTODNhRDRlbkFBMmxGcW9iQmpHVXpTbUdEeHBVbXFI?=
 =?utf-8?Q?ZCdY2jp04VdSoEpV4b8ccwg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54152B3A8FBF3B4B8D3B2E3F8750644E@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4deb0c1d-c10d-42d8-0f73-08dd6e21e76f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 17:56:45.2254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6y44ZdO+2iw3M3/JKYzdXBd3TGgStN6NkVuXgFsUp7QU1yfzoHPXlo5lYxt+3eVMJo13OuslI0W2WxMVGc0Giw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6207
X-Proofpoint-ORIG-GUID: uWoG1GwPQkBhWmbLaun1K6zWYQ3mUsaO
X-Proofpoint-GUID: uWoG1GwPQkBhWmbLaun1K6zWYQ3mUsaO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_09,2025-03-27_02,2024-11-22_01

DQoNCj4gT24gTWFyIDI4LCAyMDI1LCBhdCAxMDozMOKAr0FNLCBBbmRyaWkgTmFrcnlpa28gPGFu
ZHJpaS5uYWtyeWlrb0BnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBNYXIgMjcsIDIw
MjUgYXQgMTE6NTXigK9BTSBTb25nIExpdSA8c29uZ0BrZXJuZWwub3JnPiB3cm90ZToNCj4+IA0K
Pj4gQ2hhbmdlIGluIHN0cnVjdCBmaWxlIFsxXSBtb3ZlcyBmX3JlZiB0byB0aGUgM3JkIGNhY2hl
IGxpbmUuIFRoaXMgbWFrZXMNCj4+IGRlZmVyZW5jaW5nIGZpbGUgcG9pbnRlciBhcyBhIDgtYnl0
ZSB2YXJpYWJsZSBpbnZhbGlkLCBiZWNhdXNlDQo+PiBidGZfc3RydWN0X3dhbGsoKSB3aWxsIHdh
bGsgaW50byBmX2xvY2ssIHdoaWNoIGlzIDQtYnl0ZSBsb25nLg0KPj4gDQo+PiBGaXggdGhlIHNl
bGZ0ZXN0cyB0byBkZWZlcmVuY2UgdGhlIGZpbGUgcG9pbnRlciBhcyBhIDQtYnl0ZSB2YXJpYWJs
ZS4NCj4+IA0KPj4gWzFdIGNvbW1pdCBlMjQ5MDU2YzkxYTIgKCJmczogcGxhY2UgZl9yZWYgdG8g
M3JkIGNhY2hlIGxpbmUgaW4gc3RydWN0DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgZmls
ZSB0byByZXNvbHZlIGZhbHNlIHNoYXJpbmciKQ0KPj4gUmVwb3J0ZWQtYnk6IEpha3ViIEtpY2lu
c2tpIDxrdWJhQGtlcm5lbC5vcmc+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTb25nIExpdSA8c29uZ0Br
ZXJuZWwub3JnPg0KPj4gLS0tDQo+PiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3Mv
dGVzdF9tb2R1bGVfYXR0YWNoLmMgICAgfCAyICstDQo+PiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9icGYvcHJvZ3MvdGVzdF9zdWJwcm9nc19leHRhYmxlLmMgfCA2ICsrKy0tLQ0KPj4gMiBmaWxl
cyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRpZmYg
LS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdGVzdF9tb2R1bGVfYXR0
YWNoLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdGVzdF9tb2R1bGVfYXR0
YWNoLmMNCj4+IGluZGV4IGZiMDdmNTc3Mzg4OC4uN2YzYzIzMzk0M2IzIDEwMDY0NA0KPj4gLS0t
IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3Rlc3RfbW9kdWxlX2F0dGFjaC5j
DQo+PiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdGVzdF9tb2R1bGVf
YXR0YWNoLmMNCj4+IEBAIC0xMTcsNyArMTE3LDcgQEAgaW50IEJQRl9QUk9HKGhhbmRsZV9mZXhp
dF9yZXQsIGludCBhcmcsIHN0cnVjdCBmaWxlICpyZXQpDQo+PiANCj4+ICAgICAgICBicGZfcHJv
YmVfcmVhZF9rZXJuZWwoJmJ1ZiwgOCwgcmV0KTsNCj4+ICAgICAgICBicGZfcHJvYmVfcmVhZF9r
ZXJuZWwoJmJ1ZiwgOCwgKGNoYXIgKilyZXQgKyAyNTYpOw0KPj4gLSAgICAgICAqKHZvbGF0aWxl
IGxvbmcgbG9uZyAqKXJldDsNCj4+ICsgICAgICAgKih2b2xhdGlsZSBpbnQgKilyZXQ7DQo+IA0K
PiB3ZSBhbHJlYWR5IGhhdmUgYCoodm9sYXRpbGUgaW50ICopJnJldC0+Zl9tb2RlO2AgYmVsb3cs
IGRvIHdlIHJlYWxseQ0KPiBuZWVkIHRoaXMgaW50IGNhc3RpbmcgY2FzZT8uLiBNYXliZSBpbnN0
ZWFkIG9mIGd1ZXNzaW5nIHRoZSBzaXplIG9mDQo+IGZpbGUncyBmaXJzdCBmaWVsZCwgbGV0J3Mg
anVzdCByZW1vdmUgYCoodm9sYXRpbGUgbG9uZyBsb25nICopcmV0O2ANCj4gYWx0b2dldGhlcj8N
Cg0KSSB3YXMgYXNzdW1pbmcgdGhlIG9yaWdpbmFsIHRlc3QgY292ZXJzIHR3byBjYXNlczoNCiAg
MSkgZGVyZWYgcmV0IGl0c2VsZjsNCiAgMikgZGVyZWYgYSBtZW1iZXIgb2YgcmV0IChyZXQtPmZf
bW9kZSk7DQoNClRoZXJlZm9yZSwgaW5zdGVhZCBvZiBkb2luZyBzb21ldGhpbmcgbGlrZQ0KDQog
ICAqKHZvbGF0aWxlIGxvbmcgbG9uZyAqKSZyZXQtPmZfcmVmOyAgLyogZmlyc3QgbWVtYmVyIG9m
IGZpbGUgKi8NCg0KSSBnb3QgY3VycmVudCB2ZXJzaW9uLiANCg0KSWYgd2UgZG9uJ3QgbmVlZCB0
aGUgZmlyc3QgY2FzZSwgd2Ugc3VyZSBjYW4gcmVtb3ZlIGl0LiANCg0KVGhhbmtzLA0KU29uZw0K
DQo+IA0KPj4gICAgICAgICoodm9sYXRpbGUgaW50ICopJnJldC0+Zl9tb2RlOw0KPj4gICAgICAg
IHJldHVybiAwOw0KDQoNCg==

