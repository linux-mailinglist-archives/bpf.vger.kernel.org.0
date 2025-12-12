Return-Path: <bpf+bounces-76544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F29CBA123
	for <lists+bpf@lfdr.de>; Sat, 13 Dec 2025 00:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 456E430A42DD
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 23:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8384830AACB;
	Fri, 12 Dec 2025 23:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I3PRmnwc"
X-Original-To: bpf@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010012.outbound.protection.outlook.com [52.101.61.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554C4254AE1;
	Fri, 12 Dec 2025 23:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765583677; cv=fail; b=IW8Wf+zxfNvXN727lSIxj7gSU/ogEKTKm+NneyC3nQKGgTWR7e6U6xID22fhrsYsgEx1EFta1vj4MB6HnJzyPnLnUN0Ve4S2wJvzDe9A/sKmCUASHuov/5JngfJ/OrPQreKqxoYCfUCYDQWAn8e7bxXSbubpbUfOmV8Q02qktAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765583677; c=relaxed/simple;
	bh=PNKEBzj4OLmDDyVwqhY97AXGBUkHzOWs2M3eVCPIY30=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qcYzYzABOHfYOkWyJQM2na8edDw35mNb4bCLNrmkpI0Z1eXWPSTxIDNQPABoWI6NqPWDdpt91Pmf1CQsMXDJJn+M7U5c1VsF272ukDumTB+2RwCJQgZC3WzpQXEgUawa3BgB68aOsMTRMaEAPsZ0nKEDUmnn3A2Y65gPkWT08AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I3PRmnwc; arc=fail smtp.client-ip=52.101.61.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBU3uqVAUuEXefs98cTBl/7JGKmvozlMImQvaVfftMMCxdvwPhP5IjpZ2hIwkK02zQIHQY/JcTvTjRaSeXXeQnrp3+SbSSH+J2R6ToYylRPsviuyIct72KbjwcqWOhm0QBjd/pNlY5Xn+XMUilVkEv9K/RfLuE2LFJbXj9igUqqdLec9Lt8s4pG+hc+suhiRqmfrE9ZVeqqW3VmNvCd+Ss4/bmGpm25bFKshZtT0d8PsEBU8sbiIhkSb38S4fA4megj1IONJqiyxII7HFcr07sfkPOmKIebhF9dH1NkqJHZiP/p2bgG2dXL9UJ+bc5cGkC9MWDOS4ApmXrqat1QNpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNKEBzj4OLmDDyVwqhY97AXGBUkHzOWs2M3eVCPIY30=;
 b=Vxw9udBoDH6P3wNCBe8j8e5TBLp1kjo7E1Z7o8c3XtdM1F9H0Yu56CMj399QHScQQndFbw2nU0JuJgXWudmlE4Tc72r1xbSOpbQl7oc63CZNnhcTi8uWiHahcoVcY4U2RA3aHwDfpBpUNfD06nsvWfHH4WxSFCymryVR/eUU5dDU4jVWKKFYjtcxXJUGF9ZBVP+X0N1ZIiXpI/3LwqoNc/1zkPUPY3NlEX/Iix+6nT0XGW5XxutDAvteNwpKS0vZxBsLhEAbgs9QP/Mx+5dqD7PyxP4EeK4aEhe4YlM/wPIeT5TMe4gE31ZQ4Mo1kXcd03T2ysCRUMTwfHw4npRscA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNKEBzj4OLmDDyVwqhY97AXGBUkHzOWs2M3eVCPIY30=;
 b=I3PRmnwcY+6NQydFrhQeztj5Ha7/zyi4V27P8Wn/ErmW23XzzE8WfF8r3eVFj+IrxsQJOZ2q/H7ACYp7Q+pHzdLSbY0NPHcKR7emXVt+8sftfOQB4JJkuqMhqKZMh55Df1VRVqAx9+WYZecrBUHPo5fSaPe0wh6ddIITrSULgwS1x3bKnlSRE61ynnLZp5a1VI5HmLDLvn7Tzas46SnqqEqMtW8e1sEqh4Kny1segdb20Xkk1IuOMptJfx/2PZqPap/KAMrB0OqYJE5oc4ftbQbW9aYMhj2e3IfgLV1huV6ZVT1DtkiCUmH40/pWCxPdvR+i6m2p0s9NvHOT4BkWMQ==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MN0PR12MB6320.namprd12.prod.outlook.com (2603:10b6:208:3d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Fri, 12 Dec
 2025 23:54:29 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 23:54:28 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Steve
 Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v3] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Thread-Topic: [PATCH v3] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Thread-Index:
 AQHcaWEJWse2oN3QYE+DLsuXp8aBkrUc31XkgAAF7oCAAD/igIAACeaAgAAxDkyAAEUiAIAAG2Y3gADlnACAAAxPfw==
Date: Fri, 12 Dec 2025 23:54:28 +0000
Message-ID: <C9254103-18E1-480F-8009-003EB44F6F2F@nvidia.com>
References: <e2fe3162-4b7b-44d6-91ff-f439b3dce706@paulmck-laptop>
 <B5D08899-9C23-4FA3-B988-3BB3E8E6D908@nvidia.com>
 <febd477b-c111-4d5e-be89-cae3685853f5@paulmck-laptop>
 <bce9a781-3cc3-45d7-8c95-9f747e08a3cd@nvidia.com>
 <0ec97a2d-5aee-4214-b387-229e9822b468@paulmck-laptop>
 <C0D26D77-316D-467F-81C9-030D4E0EBCD8@nvidia.com>
 <83cd4b4d-1eec-47d0-be91-57c915775612@paulmck-laptop>
 <7683319A-AB3D-4DF4-8720-9C39E3C683BA@nvidia.com>
 <d863f1ad-477d-4e3f-a0b5-fa9f282a164a@paulmck-laptop>
In-Reply-To: <d863f1ad-477d-4e3f-a0b5-fa9f282a164a@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|MN0PR12MB6320:EE_
x-ms-office365-filtering-correlation-id: 18e254e4-f7ee-4723-08a2-08de39d9c9b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bVR4WlQyUkgxM1B0WlJOTXQ4dDRiUlNwbnp3NE8xcHozckYrdU1yY3YxVUx0?=
 =?utf-8?B?N3ZLam9RSnJtU2szRFUrVExuMnhRRnBJV0hxQWJxY2d2TjlxVFdUR25NeFdk?=
 =?utf-8?B?UlQ2elFwWW9oa2RBUlNZL1pKK09ldlJ2QVhvOHZWTXlLOTRFRUNUR2JWSmxt?=
 =?utf-8?B?TjNNejBwNGZRaVhTNWNrNmdzY0YvdzNWZW02a3NiZFRuMStiQkRGdTVtNE8r?=
 =?utf-8?B?Sy9ITm4xYml0Z3h1TmdiVXRyKzRsWXp0Ymlkd1ZqMEk3UXpTUVM2THpZdGRC?=
 =?utf-8?B?bWtMZzlacGsxcG5GQjNOYkw1WXNsTldZdVhvYVdiVGdVTWpndmt1bE1wRS8z?=
 =?utf-8?B?Wm5FV1ZGeUVpZHZGVWE3QmdHeFRPMjQ1bnpWME9VUmFPM3kydzNUemtWUEt3?=
 =?utf-8?B?ZVF4SlZaVDRUUkpRNGJXYWkvRzJiRGEydGZlRklZZm12ZG54N1BkUEJHVnA4?=
 =?utf-8?B?cFdocVNUMVVLVXYyekxUWWJVUldIL1U1ZWVGREhtOS9wWTFHMkZWMWRzQm41?=
 =?utf-8?B?eTdtRTRnbjcyTE0wZmFSUVd4NUhERElKY2J4dEpES245Q1hzNjJMUFh5NHRF?=
 =?utf-8?B?eUpKOGFUR21xWVY1NXdpbm4rMTltdTFhTDB2cDR2RkxKdTFJV2JxQWlhZXVx?=
 =?utf-8?B?d24zc3l4VjZrekpDVkZreitDVkVQaEdTKy9YUVZIa3lMVnAzcEx5T1lmb1FZ?=
 =?utf-8?B?RVR4ejBqaG94NmRkTEJFcVJvcUE3eW5zVFRBMGx6RExoT2wydXpUejAyTGdx?=
 =?utf-8?B?SU9Ec2RpNmR1UUdHZUpkQ2R0RlI2T3Q0cVdxVitoZ2x0bGd2VzZ2N0doTGVa?=
 =?utf-8?B?TVVqOWYyWVJ1a0xuNTFjd255bmhJVXlod1ByMnpFYVV2VVR3WHMrME80RGds?=
 =?utf-8?B?SENoV3hCMWFQbVdmSXZpLzN6U0V5V01uejVmS0JmL1krZUFrRlJzRk9ZTExB?=
 =?utf-8?B?eCtFckdaRmtlbG9PNXYra2wxallzMmdDdzFuVnpCZ3dKaG9seVgxNUx3WFFw?=
 =?utf-8?B?MnRmOEZPT2wzVDA0OW05MDRiWVBGOURtcE0zb0ZiQy9Ea29TZWZuM3dUK2E3?=
 =?utf-8?B?VFk1Syt3aU1OeVVTZ2grL0pEaks4K3Z3aUlzYzVWd0dBa2NwSnY0WnZVUXg5?=
 =?utf-8?B?WFhsTFE4ZFBmOFV3Z0xia0lacDZjTXRFTXdTa0NtQUFxU0Q1Mzd2YXhBV1Vk?=
 =?utf-8?B?SThaaWR4WVNCZkEvbHdWYklLSGJ4MVlXZFlvSmlJYmM5NTJ4ZkQ4VTRtNmt3?=
 =?utf-8?B?OXVRdnRCU3BneTNBdlVOdlV3a2tZbjdOS2FuWFkwNDJ5eExOV1hob09QQ09F?=
 =?utf-8?B?OHZyT0l3UENQSXk1TnZIUVRqRzhJMnhURkJWc09MUnJUdm4yZHIrcE1SWDFU?=
 =?utf-8?B?ZUNmdS8rcjk4VDBqNE03cWF6a0RSRm9CS1lSWUhwZnlRM043dzhaZDFkeUl0?=
 =?utf-8?B?VldpMUhBUmY5VlJmYjI0MzN6NUNGZG1nYnp2YWRDMXBVek10djE4bmhiYTh1?=
 =?utf-8?B?V0haSkpPVXV6b1hPZHk5UTg4d2xXOVhEN3J3V2xpWHdSVVlEQTBmNFlUMml4?=
 =?utf-8?B?ZVFQeHROK1pya2o2TnpOa2tsKy90MVBST3g3S0RVeTBWTzkxdWhTUm5sajAx?=
 =?utf-8?B?ajVyaTJjNTZONkQ4VHNXTFV5QkcyRFlWYWlONFQ0eXdIZmhOaG1DWW9teTM4?=
 =?utf-8?B?S1dwemYrbHJqaXBHMFU3Z00vTHZWemNjUnpGYm5IcGF0dnRKL2luR01acHJq?=
 =?utf-8?B?bEhZdzBad2ZhaG8vbW5wN0JvdVcxYXdiUEVQN09zZGNYNFdpSHVOcmo5bEtQ?=
 =?utf-8?B?cnF4WXlRVkJURzJ2ZDN1bUU5QzlZNEM2M05xM0NKVTI2MGJGVTI5OVB6aHRh?=
 =?utf-8?B?NHpkQmVYdEQza1o5Y3JYUUZrZzdGMnViQUxaZnFQTktYM1B6cVRhSURtbTYr?=
 =?utf-8?B?OTNBeGFodHBNSXQzSzc3SzAvK1UrNmRQR3MvSUZFUkU3UE11RSszTmcwTG93?=
 =?utf-8?B?dzlRUFFNVWpmSjdpSVBpUjRONlZ3WU5QajY0eFJlZUd1UDFoY2dacHV6TE05?=
 =?utf-8?Q?vGOvcl?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VldMY0dxRGxRMXRxanN5VE5TZGJCOFVUcWlhTEZCRjlwaER3V0JUMHNVWk5O?=
 =?utf-8?B?Sjk0UG5CUFlRMlVVNm9ZOGJlL1JEZGxnU0VJLzRuanFpd2h4ZlZ2SkZQaXpp?=
 =?utf-8?B?NXI4K0xPSk5UUWxpNVM0VWlaQ1EvMWFOdHBtUTlrenltbnZsYmQ0REgyZ0VL?=
 =?utf-8?B?TzJ5OW1HOXAxYWFXT2RSZzdIYXNJUnh3bkN1Qy9nRGQ4b0FDK0JpRTVFRmRZ?=
 =?utf-8?B?bFRsNWdYeW1mRy82bUc4b0dNbElsQ21JUFoxMmF6ZGdVVGtHZEU2Mk90UFZD?=
 =?utf-8?B?SkNGbUdBUWJ3UXpCNGU5MlhUZFZnRXdLRFNYZUlsR01CcW9YTVZGbHNRSFNh?=
 =?utf-8?B?YXN1TVlVckVjMjh0aXp3K3NXbS81RzRGYTdZZGd0Mmg3OEVHNkhueURVYVVW?=
 =?utf-8?B?SlVwNVhVNGFYNmJaVG5PQm5WeXRNWTdBaWFGbDY0WDBzRm9TcmdOSCtOMzVq?=
 =?utf-8?B?NEFhOUNKL3hZejJhdWdXVUpwNUpuc2IxVCt0U0U5bWRNWGN2NTJJYlF2SXYy?=
 =?utf-8?B?WUNHRTVwQWY0cksrQTkyK0pxTzgzY0VzMDRhT2VuWUxlYk9GeENFbWszb0hh?=
 =?utf-8?B?KzJyeVFrYWQxZUFON3lraEpPV3FPU0FWTXZaVUppamZhc055amlQdSsyMnA4?=
 =?utf-8?B?WThOeXMyR1lITVNyUGhYMWkwZHRMMyt3ZE5acXBCT1RUcHhXVU1hZm1xZ1Qx?=
 =?utf-8?B?cmFuTjBsb0lxL1ZjYWNBVnNQRWdrRzdXb002K1QvOXdvRXNCL0Z1dmNGNFJI?=
 =?utf-8?B?aFdxSVRXTStvb1ZkdGtoanBqakFYQ2NQWEhwWC9HOVMvbENHOUZDMGZsRmxX?=
 =?utf-8?B?R2YrdkxkTU9HQnZUUmJ3aDJhdzlOcE8xaFBYdHNaZlZFY3UwTGEzejBSZ2RU?=
 =?utf-8?B?dzBBbUVpUTZLbXhFR1d4ZDVoNjFvWThqQkNQdnc5WHFHQXlvYnIxZzZGdnVT?=
 =?utf-8?B?WjB0RE85WkErMXlaV0J3T1VCeG1uN2ZWRE5LRGNaWWdPVEdTTFNrTUJkVEFU?=
 =?utf-8?B?bVhmTzZUVnJHUkRwblVscCt1L013VWRWUUFad2Y4dkZNcHV5cUx0RnNMZ3hs?=
 =?utf-8?B?L3BwRS9FSEd3VzRXbjRPVDVuYXd0MEE3RXJwck1KaHp0MmRzMkpLY2NLd1c4?=
 =?utf-8?B?N0luSzM3RUJqZkU4N3JXUzhuZ1Y3L1N5NUYwc0cvZnpqTWQ4VFYrWGR5TlBU?=
 =?utf-8?B?KzBacWQ4OUJSSTI4cUhBQ1orN1ljOUpXMmZpVnhDMnpGNzk2OFAzNGFySytG?=
 =?utf-8?B?NFNsWTZid2k3N2oycStwTktnbVVOWG5ZZG8xaG5XV2tSNVc0c2E3TmVwMnIx?=
 =?utf-8?B?WDlxampnak5oU21kTGkxV2l5WmJiSHd6UVZiZlE4akNxekdsdEZCVkZzUzlG?=
 =?utf-8?B?TW50aUVLVStsc0FzcGFBZUQrU3YvQ3h4OXRaMytHN0hHWjdLTFFUb0lEQWow?=
 =?utf-8?B?VENWSnl6bGVoN2dqWnFiWm41U25TVlN0Z0hYMzNhS1ZXcmFidC9lb3dNRVRU?=
 =?utf-8?B?eGlTNXJVdWNoYzIxNXRrSFZZQjEyVDAvSWNBT2ZNWXNKRjBCdUlLRVdDUmU2?=
 =?utf-8?B?UDFVK0k0dWp4OU9kVllacmZ6LzBuVExWUDFQVVlHd1B2cUw4Rk10SlE0M1Vx?=
 =?utf-8?B?QXU5NFk1SHI3cnpyeXNUMlNkYWVqckV3SExyT2IvaWkxaDNVZmpBdkpiWWI1?=
 =?utf-8?B?T2FkeCtQS1B5dzZqTUFKSEx3VCtUdmRDemxraW5FYlVyYUZlSWprTGcxUVRk?=
 =?utf-8?B?cGhlaTNBTU1wY0F2UlZWbmdiQnVmSndReG8yY3owbEJFMm80YnR5aGg1UU9s?=
 =?utf-8?B?RFl4N2hFcFVSRStqLzZYTnBrMXVGL1BiaGw4eVhXVkhwQ2ErclIvUnVpQ25n?=
 =?utf-8?B?ZHpPN3FuQkN1Ni90NCtDWkFjb3FiL3hqckJzS3IzZWZMdk44TmhrMVd5M1Zt?=
 =?utf-8?B?RURkZVd3SWZpZzB6Q3ladm9kSG0rVmdxUkJXZVlqVmtrcm1uVFVkRWkwcHNS?=
 =?utf-8?B?VnR2bWJZYXFnR1lKQ1U5ajdHQVNoTlQ4THZFTWEwSmsraEVUTG9oUFZ4MUtQ?=
 =?utf-8?B?ZHIyTC9ra0ZHTVJDT2ZaMXRjdGRNb0ljaGRPVDUxWjZjZWx4bUFYbHZaakRS?=
 =?utf-8?Q?Idjeci6lHditrEpcDwfyAr6D0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e254e4-f7ee-4723-08a2-08de39d9c9b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 23:54:28.7556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0V0Nq+K9r0GQ+F+pbkcpxqvTJOFuZ0fMrQ1M91Lvh/6fLN7sMADqFuUUEAsQDSGDyMLGf5AW0YKBgGxo4VADGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6320

DQoNCj4gT24gRGVjIDEzLCAyMDI1LCBhdCA4OjEw4oCvQU0sIFBhdWwgRS4gTWNLZW5uZXkgPHBh
dWxtY2tAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79PbiBGcmksIERlYyAxMiwgMjAyNSBh
dCAwOToyODozN0FNICswMDAwLCBKb2VsIEZlcm5hbmRlcyB3cm90ZToNCj4+IA0KPj4gDQo+Pj4+
IE9uIERlYyAxMiwgMjAyNSwgYXQgNDo1MOKAr1BNLCBQYXVsIEUuIE1jS2VubmV5IDxwYXVsbWNr
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+IA0KPj4+IO+7v09uIEZyaSwgRGVjIDEyLCAyMDI1IGF0
IDAzOjQzOjA3QU0gKzAwMDAsIEpvZWwgRmVybmFuZGVzIHdyb3RlOg0KPj4+PiANCj4+Pj4gDQo+
Pj4+Pj4gT24gRGVjIDEyLCAyMDI1LCBhdCA5OjQ34oCvQU0sIFBhdWwgRS4gTWNLZW5uZXkgPHBh
dWxtY2tAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4+PiANCj4+Pj4+IO+7v09uIEZyaSwgRGVjIDEy
LCAyMDI1IGF0IDA5OjEyOjA3QU0gKzA5MDAsIEpvZWwgRmVybmFuZGVzIHdyb3RlOg0KPj4+Pj4+
IA0KPj4+Pj4+IA0KPj4+Pj4+PiBPbiAxMi8xMS8yMDI1IDM6MjMgUE0sIFBhdWwgRS4gTWNLZW5u
ZXkgd3JvdGU6DQo+Pj4+Pj4+IE9uIFRodSwgRGVjIDExLCAyMDI1IGF0IDA4OjAyOjE1UE0gKzAw
MDAsIEpvZWwgRmVybmFuZGVzIHdyb3RlOg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+
PiBPbiBEZWMgOCwgMjAyNSwgYXQgMToyMOKAr1BNLCBQYXVsIEUuIE1jS2VubmV5IDxwYXVsbWNr
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+IO+7v1RoZSBjdXJyZW50
IHVzZSBvZiBndWFyZChwcmVlbXB0X25vdHJhY2UpKCkgd2l0aGluIF9fREVDTEFSRV9UUkFDRSgp
DQo+Pj4+Pj4+Pj4gdG8gcHJvdGVjdCBpbnZvY2F0aW9uIG9mIF9fRE9fVFJBQ0VfQ0FMTCgpIG1l
YW5zIHRoYXQgQlBGIHByb2dyYW1zDQo+Pj4+Pj4+Pj4gYXR0YWNoZWQgdG8gdHJhY2Vwb2ludHMg
YXJlIG5vbi1wcmVlbXB0aWJsZS4gIFRoaXMgaXMgdW5oZWxwZnVsIGluDQo+Pj4+Pj4+Pj4gcmVh
bC10aW1lIHN5c3RlbXMsIHdob3NlIHVzZXJzIGFwcGFyZW50bHkgd2lzaCB0byB1c2UgQlBGIHdo
aWxlIGFsc28NCj4+Pj4+Pj4+PiBhY2hpZXZpbmcgbG93IGxhdGVuY2llcy4gIChXaG8ga25ldz8p
DQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gT25lIG9wdGlvbiB3b3VsZCBiZSB0byB1c2UgcHJlZW1w
dGlibGUgUkNVLCBidXQgdGhpcyBpbnRyb2R1Y2VzDQo+Pj4+Pj4+Pj4gbWFueSBvcHBvcnR1bml0
aWVzIGZvciBpbmZpbml0ZSByZWN1cnNpb24sIHdoaWNoIG1hbnkgY29uc2lkZXIgdG8NCj4+Pj4+
Pj4+PiBiZSBjb3VudGVycHJvZHVjdGl2ZSwgZXNwZWNpYWxseSBnaXZlbiB0aGUgcmVsYXRpdmVs
eSBzbWFsbCBzdGFja3MNCj4+Pj4+Pj4+PiBwcm92aWRlZCBieSB0aGUgTGludXgga2VybmVsLiAg
VGhlc2Ugb3Bwb3J0dW5pdGllcyBjb3VsZCBiZSBzaHV0IGRvd24NCj4+Pj4+Pj4+PiBieSBzdWZm
aWNpZW50bHkgZW5lcmdldGljIGR1cGxpY2F0aW9uIG9mIGNvZGUsIGJ1dCB0aGlzIHNvcnQgb2Yg
dGhpbmcNCj4+Pj4+Pj4+PiBpcyBjb25zaWRlcmVkIGltcG9saXRlIGluIHNvbWUgY2lyY2xlcy4N
Cj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBUaGVyZWZvcmUsIHVzZSB0aGUgc2hpbnkgbmV3IFNSQ1Ut
ZmFzdCBBUEksIHdoaWNoIHByb3ZpZGVzIHNvbWV3aGF0IGZhc3Rlcg0KPj4+Pj4+Pj4+IHJlYWRl
cnMgdGhhbiB0aG9zZSBvZiBwcmVlbXB0aWJsZSBSQ1UsIGF0IGxlYXN0IG9uIFBhdWwgRS4gTWNL
ZW5uZXkncw0KPj4+Pj4+Pj4+IGxhcHRvcCwgd2hlcmUgdGFza19zdHJ1Y3QgYWNjZXNzIGlzIG1v
cmUgZXhwZW5zaXZlIHRoYW4gYWNjZXNzIHRvIHBlci1DUFUNCj4+Pj4+Pj4+PiB2YXJpYWJsZXMu
ICBBbmQgU1JDVS1mYXN0IHByb3ZpZGVzIHdheSBmYXN0ZXIgcmVhZGVycyB0aGFuIGRvZXMgU1JD
VSwNCj4+Pj4+Pj4+PiBjb3VydGVzeSBvZiBiZWluZyBhYmxlIHRvIGF2b2lkIHRoZSByZWFkLXNp
ZGUgdXNlIG9mIHNtcF9tYigpLiAgQWxzbywNCj4+Pj4+Pj4+PiBpdCBpcyBxdWl0ZSBzdHJhaWdo
dGZvcndhcmQgdG8gY3JlYXRlIHNyY3VfcmVhZF97LHVufWxvY2tfZmFzdF9ub3RyYWNlKCkNCj4+
Pj4+Pj4+PiBmdW5jdGlvbnMuDQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gV2hpbGUgaW4gdGhlIGFy
ZWEsIFNSQ1Ugbm93IHN1cHBvcnRzIGVhcmx5IGJvb3QgY2FsbF9zcmN1KCkuICBUaGVyZWZvcmUs
DQo+Pj4+Pj4+Pj4gcmVtb3ZlIHRoZSBjaGVja3MgdGhhdCB1c2VkIHRvIGF2b2lkIHN1Y2ggdXNl
IGZyb20gcmN1X2ZyZWVfb2xkX3Byb2JlcygpDQo+Pj4+Pj4+Pj4gYmVmb3JlIHRoaXMgY29tbWl0
IHdhcyBhcHBsaWVkOg0KPj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+IGU1MzI0NGUyYzg5MyAoInRyYWNl
cG9pbnQ6IFJlbW92ZSBTUkNVIHByb3RlY3Rpb24iKQ0KPj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+IFRo
ZSBjdXJyZW50IGNvbW1pdCBjYW4gYmUgdGhvdWdodCBvZiBhcyBhbiBhcHByb3hpbWF0ZSByZXZl
cnQgb2YgdGhhdA0KPj4+Pj4+Pj4+IGNvbW1pdCwgd2l0aCBzb21lIGNvbXBlbnNhdGluZyBhZGRp
dGlvbnMgb2YgcHJlZW1wdGlvbiBkaXNhYmxpbmcuDQo+Pj4+Pj4+Pj4gVGhpcyBwcmVlbXB0aW9u
IGRpc2FibGluZyB1c2VzIGd1YXJkKHByZWVtcHRfbm90cmFjZSkoKS4NCj4+Pj4+Pj4+PiANCj4+
Pj4+Pj4+PiBIb3dldmVyLCBZb25naG9uZyBTb25nIHBvaW50cyBvdXQgdGhhdCBCUEYgYXNzdW1l
cyB0aGF0IG5vbi1zbGVlcGFibGUNCj4+Pj4+Pj4+PiBCUEYgcHJvZ3JhbXMgd2lsbCByZW1haW4g
b24gdGhlIHNhbWUgQ1BVLCB3aGljaCBtZWFucyB0aGF0IG1pZ3JhdGlvbg0KPj4+Pj4+Pj4+IG11
c3QgYmUgZGlzYWJsZWQgd2hlbmV2ZXIgcHJlZW1wdGlvbiByZW1haW5zIGVuYWJsZWQuICBJbiBh
ZGRpdGlvbiwNCj4+Pj4+Pj4+PiBub24tUlQga2VybmVscyBoYXZlIHBlcmZvcm1hbmNlIGV4cGVj
dGF0aW9ucyB0aGF0IHdvdWxkIGJlIHZpb2xhdGVkIGJ5DQo+Pj4+Pj4+Pj4gYWxsb3dpbmcgdGhl
IEJQRiBwcm9ncmFtcyB0byBiZSBwcmVlbXB0ZWQuDQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gVGhl
cmVmb3JlLCBjb250aW51ZSB0byBkaXNhYmxlIHByZWVtcHRpb24gaW4gbm9uLVJUIGtlcm5lbHMs
IGFuZCBwcm90ZWN0DQo+Pj4+Pj4+Pj4gdGhlIEJQRiBwcm9ncmFtIHdpdGggYm90aCBTUkNVIGFu
ZCBtaWdyYXRpb24gZGlzYWJsaW5nIGZvciBSVCBrZXJuZWxzLA0KPj4+Pj4+Pj4+IGFuZCBldmVu
IHRoZW4gb25seSBpZiBwcmVlbXB0aW9uIGlzIG5vdCBhbHJlYWR5IGRpc2FibGVkLg0KPj4+Pj4+
Pj4gDQo+Pj4+Pj4+PiBIaSBQYXVsLA0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBJcyB0aGVyZSBhIHJl
YXNvbiB0byBub3QgbWFrZSBub24tUlQgYWxzbyBiZW5lZml0IGZyb20gU1JDVSBmYXN0IGFuZCB0
cmFjZSBwb2ludHMgZm9yIEJQRj8gQ2FuIGJlIGEgZm9sbG93IHVwIHBhdGNoIHRob3VnaCBpZiBu
ZWVkZWQuDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBCZWNhdXNlIGluIHNvbWUgY2FzZXMgdGhlIG5vbi1S
VCBiZW5lZml0IGlzIHN1c3BlY3RlZCB0byBiZSBuZWdhdGl2ZQ0KPj4+Pj4+PiBkdWUgdG8gaW5j
cmVhc2luZyB0aGUgcHJvYmFiaWxpdHkgb2YgcHJlZW1wdGlvbiBpbiBhd2t3YXJkIHBsYWNlcy4N
Cj4+Pj4+PiANCj4+Pj4+PiBTaW5jZSB5b3UgbWVudGlvbmVkIHN1c3BlY3RlZCwgSSBhbSBndWVz
c2luZyB0aGVyZSBpcyBubyBjb25jcmV0ZSBkYXRhIGNvbGxlY3RlZA0KPj4+Pj4+IHRvIHN1YnN0
YW50aWF0ZSB0aGF0IHNwZWNpZmljYWxseSBmb3IgQlBGIHByb2dyYW1zLCBidXQgY29ycmVjdCBt
ZSBpZiBJIG1pc3NlZA0KPj4+Pj4+IHNvbWV0aGluZy4gQXNzdW1pbmcgeW91J3JlIHJlZmVycmlu
ZyB0byBsYXRlbmN5IHZlcnN1cyB0cmFkZW9mZnMgaXNzdWVzLCBkdWUgdG8NCj4+Pj4+PiBwcmVl
bXB0aW9uLCBBbmRyb2lkIGlzIG5vdCBQUkVFTVBUX1JUIGJ1dCBpcyBleHBlY3RlZCB0byBiZSBs
b3cgbGF0ZW5jeSBpbg0KPj4+Pj4+IGdlbmVyYWwgYXMgd2VsbC4gU28gaXMgdGhpcyBkZWNpc2lv
biB0aGUgcmlnaHQgb25lIGZvciBBbmRyb2lkIGFzIHdlbGwsDQo+Pj4+Pj4gY29uc2lkZXJpbmcg
dGhhdCAoSSBoZWFyZCkgaXQgdXNlcyBCUEY/IEp1c3QgYW4gb3Blbi1lbmRlZCBxdWVzdGlvbi4N
Cj4+Pj4+PiANCj4+Pj4+PiBUaGVyZSBpcyBhbHNvIGlzc3VlIG9mIDIgZGlmZmVyZW50IHBhdGhz
IGZvciBQUkVFTVBUX1JUIHZlcnN1cyBvdGhlcndpc2UsDQo+Pj4+Pj4gY29tcGxpY2F0aW5nIHRo
ZSB0cmFjaW5nIHNpZGUgc28gdGhlcmUgYmV0dGVyIGJlIGEgcmVhc29uIGZvciB0aGF0IEkgZ3Vl
c3MuDQo+Pj4+PiANCj4+Pj4+IFlvdSBhcmUgYWR2b2NhdGluZyBhIGNoYW5nZSBpbiBiZWhhdmlv
ciBmb3Igbm9uLVJUIHdvcmtsb2Fkcy4gIFdoeSBkbw0KPj4+Pj4geW91IGJlbGlldmUgdGhhdCB0
aGlzIGNoYW5nZSB3b3VsZCBiZSBPSyBmb3IgdGhvc2Ugd29ya2xvYWRzPw0KPj4+PiANCj4+Pj4g
U2FtZSByZWFzb25zIEkgcHJvdmlkZWQgaW4gbXkgbGFzdCBlbWFpbC4gSWYgd2UgYXJlIHNheWlu
ZyBTUkNVLWZhc3QgaXMgcmVxdWlyZWQgZm9yIGxvd2VyIGxhdGVuY3ksIEkgZmluZCBpdCBzdHJh
bmdlIHRoYXQgd2UgYXJlIGxlYXZpbmcgb3V0IEFuZHJvaWQgd2hpY2ggaGFzIGxvdyBsYXRlbmN5
IGF1ZGlvIHVzZWNhc2VzLCBmb3IgaW5zdGFuY2UuDQo+Pj4gDQo+Pj4gSWYgQW5kcm9pZCBwcm92
aWRlcyBudW1iZXJzIHNob3dpbmcgdGhhdCBpdCBoZWxwcyB0aGVtLCB0aGVuIGl0IGlzIGVhc3kN
Cj4+PiB0byBwcm92aWRlIGEgS2NvbmZpZyBvcHRpb24gdGhhdCBkZWZhdWx0cyB0byBQUkVFTVBU
X1JULCBidXQgdGhhdCBBbmRyb2lkDQo+Pj4gY2FuIG92ZXJyaWRlLiAgUmlnaHQ/DQo+PiANCj4+
IFN1cmUsIGJ1dCBteSBzdXNwaWNpb24gaXMgQW5kcm9pZCBvciBvdGhlcnMgYXJlIG5vdCBnb2lu
ZyB0byBsb29rIGludG8gZXZlcnkgUFJFRU1QVF9SVCBzcGVjaWZpYyBvcHRpbWl6YXRpb24gKG5v
dCBqdXN0IHRoaXMgb25lKSBhbmQgc2VlIGlmIGl0IGJlbmVmaXRzIHRoZWlyIGludGVyYWN0aXZp
dHkgdXNlY2FzZXMuIFRoZXkgd2lsbCBzaW1wbHkgbWlzcyBvdXQgb24gaXQgd2l0aG91dCBrbm93
aW5nIHRoZXkgYXJlLg0KPj4gDQo+PiBJdCBtaWdodCBiZSBhIGdvb2QgaWRlYSAoZm9yIG1lKSB0
byBleHBsb3JlIGhvdyBtYW55IHN1Y2ggb3B0aW1pemF0aW9ucyBleGlzdCB0aG91Z2gsIHRoYXQg
d2UgdGFrZSBmb3IgZ3JhbnRlZC4gSSB3aWxsIGxvb2sgaW50byBleHBsb3JpbmcgdGhpcyBvbiBt
eSBzaWRlLiA6KQ0KPiANCj4gT25lIHdvcmtsb2FkJ3Mgb3B0aW1pemF0aW9uIGlzIGFub3RoZXIg
d29ya2xvYWQncyBwZXNzaW1pemF0aW9uLCBpbg0KPiBwYXJ0IGJlY2F1c2UgdGhlcmUgYXJlIGEg
bG90IG9mIGRpZmZlcmVudCBtZWFzdXJlcyBvZiBwZXJmb3JtYW5jZSB0aGF0DQo+IGRpZmZlcmVu
dCB3b3JrbG9hZHMgY2FyZSBhYm91dC4uDQo+IA0KPiBCdXQgYXMgYSBwcmFjdGljYWwgbWF0dGVy
LCB0aGlzIGlzIFN0ZXZlbidzIGRlY2lzaW9uLg0KPiANCj4gVGhvdWdoIGlmIGhlIGRvZXMgY2hh
bmdlIHRoZSBiZWhhdmlvciBvbiBub24tUlQgc2V0dXBzLCBJIHdvdWxkIHRoYW5rDQo+IGhpbSB0
byByZW1vdmUgbXkgbmFtZSBmcm9tIHRoZSBjb21taXQsIG9yIGF0IGxlYXN0IHJlY29yZCBpbiB0
aGUgY29tbWl0DQo+IGxvZyB0aGF0IEkgb2JqZWN0IHRvIGNoYW5naW5nIG90aGVyIHdvcmtsb2Fk
cycgYmVoYXZpb3JzLg0KDQpZb3UgaGF2ZSBhIHBvaW50LiBJIGFtIG5vdCBzYXlpbmcgd2Ugc2hv
dWxkIGRvIHRoaXMgZm9yIHN1cmUgYnV0IHNob3VsZCBhdCBsZWFzdCBjb25zaWRlciAvIGV4cGxv
cmUgaXQuDQoNClRoYW5rcy4NCg0KDQoNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFRoYW54LCBQYXVsDQo+IA0KPj4gdGhhbmtzLA0KPj4gDQo+PiAtIEpvZWwNCj4+IA0KPj4+IA0K
Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgVGhhbngsIFBhdWwNCj4+PiANCj4+Pj4gVGhh
bmtzLA0KPj4+PiANCj4+Pj4gLSBKb2VsDQo+Pj4+IA0KPj4+PiANCj4+Pj4+IA0KPj4+Pj4gICAg
ICAgICAgICAgICAgICAgICAgICAgIFRoYW54LCBQYXVsDQo=

