Return-Path: <bpf+bounces-58429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A90ABA57A
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 23:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801F21C0216A
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 21:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0949E28003A;
	Fri, 16 May 2025 21:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EQAbUoAp"
X-Original-To: bpf@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022140.outbound.protection.outlook.com [40.93.195.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17FA46BF;
	Fri, 16 May 2025 21:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747431956; cv=fail; b=U57IwzmlXdm012AVoNFeuL8nPenouFa/UrDQsKYfmaJkiW/EsOfebGHAORUCfImHmvt9s1wL86Hw5AQNog8Z+h55DU6EUNQkt4FHXr2/Mw2gKFADTFvVaTKdM51/BecsImQPmdxk8pO0X+zheHfl2a9KUvo8wVXSsCByLX1dEBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747431956; c=relaxed/simple;
	bh=vjal3NRaR+Ba87fqOUq1k27aLlrfozgFKVu7LcrTnJk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TcBwPV+HfKLqVWhOxbBD8DNY/Jipd93wTQHtIS4cLZefzZwxokmmszPS1HWklTR7qwqn3lO6hN7LMQcye4dpcopKMkQ4r8An4DbqZ/mDosn7+oeT5b21X4DKDaQCgHprCAMebNjnLdIArPAbqd72lOragnBZbOaDYYKau/E+PW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=EQAbUoAp; arc=fail smtp.client-ip=40.93.195.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReilxSfvZOWHKNOtbTeaXrH4ZflE5RI3y/XAHaUds0uZqU+U+HyyDN71GtFSoFryKJGF4IQIk2Vm8qa2LfhgYyFjZZKX3d7hcNEeYC1t/oHIVdUlnRXPkXPVZ3xHM/ZdKNPOA+gA8Y3U5+Ntp/jbcjP5l+vzlcy5M7p2TXD9GWeP/CXFhnXLA1icAcZxPw0rRZ7ilgXnk2xBKnQOZ2SPFbE4HCztrWJjZay83rQYYtHkOjkaYEXOmR4USAOyrx5HGAMjkwKMK65Bt1A4HOaOvGu2hFMjfjqpfrL7MTRLrwoyIEBjN5+8p30BsMfqq0CoeLBvsTIb4eQ4D+z7iwitug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjal3NRaR+Ba87fqOUq1k27aLlrfozgFKVu7LcrTnJk=;
 b=pbok18Oikw7cAvsH6iwyQ0yFG9R0Qz5eFypZAH5pFgEOJ7bHyV07VK2mnKvSSnWTZFzRkWtD8Cs2AjlvaWa4Dr/NQUD+bPRj/SRKkL4epyw3oxdoOW9gNwI9FqbeKuEtREu3SA7gLyWvW6RcbJyGI0AWpUv3EBcFCiTfIFbU9aYI4GsY+OzrAUlHrxI5nBwQrVCEKt6srMEL//h3w5MHRelkpcnvnD1n6LzqCb4wZal8YfsIhJIC03nX7pxtExFfL0DVbknJwGpPVoINmM53EpRi43e2aVpIgyuQd988gH3GCOqcNiG7kcqKe4OXzXj5GqUPGe/vRvprKtaUXMQogA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjal3NRaR+Ba87fqOUq1k27aLlrfozgFKVu7LcrTnJk=;
 b=EQAbUoApoFshT17yO7sjVQD6MbntApTjLyldOvXf4BgyY8NtwpNDOhycUib/jSbzlGaUM9zGRH1PDJXhn3xT0jgA8eG2A3a8cAO0/5P95Bc6XHmaIGeiamCmRdvEJ1FpfqWHy65suLfjVIlWZYjQcMaQ3MSFJOUEYc2voBAY8pg=
Received: from MN0PR21MB3437.namprd21.prod.outlook.com (2603:10b6:208:3d2::17)
 by MN0PR21MB3123.namprd21.prod.outlook.com (2603:10b6:208:377::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.12; Fri, 16 May
 2025 21:45:51 +0000
Received: from MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97]) by MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97%4]) with mapi id 15.20.8769.001; Fri, 16 May 2025
 21:45:51 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Dexuan Cui <decui@microsoft.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org"
	<leon@kernel.org>, Long Li <longli@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>, "hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, Konstantin Taranov <kotaranov@microsoft.com>,
	"horms@kernel.org" <horms@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next] net: mana: Add support for Multi
 Vports on Bare metal
Thread-Topic: [EXTERNAL] Re: [PATCH net-next] net: mana: Add support for Multi
 Vports on Bare metal
Thread-Index: AQHbxpv3KSWHYi6n+kCJVM9rW+SgabPVvPeAgAAL4WA=
Date: Fri, 16 May 2025 21:45:51 +0000
Message-ID:
 <MN0PR21MB3437ED3FC34206052262C43ECA93A@MN0PR21MB3437.namprd21.prod.outlook.com>
References: <1747425099-25830-1-git-send-email-haiyangz@microsoft.com>
 <71e89f06-872f-470c-86bc-c1429c1b8666@oracle.com>
In-Reply-To: <71e89f06-872f-470c-86bc-c1429c1b8666@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=82fab43a-53d3-49a4-82d5-546c67f2d171;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-05-16T21:39:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3437:EE_|MN0PR21MB3123:EE_
x-ms-office365-filtering-correlation-id: b5588b7b-ee44-48b6-dce7-08dd94c30702
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VitlV05QREVPN1pSdTN2Qm1Od3N4QWdqNWlVRGI4MmZwMUVZMjJvbzQ5T213?=
 =?utf-8?B?QnNLRnV3bjhacnIxL21td0s5T2h0ZXVubEtoWUkraDhoNTdseUxjOUZ4NGsv?=
 =?utf-8?B?aHlhUkh5ZW01NWlURVZ1MkdQMDg5M2k5QXJBSVhZVWZ5a3JBU3lGL2dMYSt5?=
 =?utf-8?B?YmFGUnVwbFcxL2FyK0l2aDJNSGdXVktqeXd1eUdpSkpYMjBXYUtRSktnZFM5?=
 =?utf-8?B?TkdSYWg1Z21IenFzWG95S1NWU3R5QXZOZ1Rmd3FINlc1MTRKU2Z1Zm9lQmJ1?=
 =?utf-8?B?a3kzY1BjUDJFTzcwTXhnUERCa2ZJU1M4NStucExzTDZWdHFhRE5wZDE4QVF6?=
 =?utf-8?B?cEJZZ0l1VU5rQVR0SEQ1Q1dQY2tWZXZqNU1UdjBPYlpNcnVnc2Q1aVYrMWpP?=
 =?utf-8?B?TU1iTzZCV2VIblZQRmZLU1B1NitXYktkRGFSK0VLa1RFWmpLbVpHQ3NQblBJ?=
 =?utf-8?B?NXJiWWlrZXdyRlpDcGFaNjVXTnVhVXJmUzZpV2Jna3IvWDd0bXpnZTVVdUZJ?=
 =?utf-8?B?eWZucUhkazdCeS90eFl1RUlTbXBQdHNZUDJoRmYxY2ZYMEU3L0dhWWcvbjVj?=
 =?utf-8?B?SGttWmZsL0ljYnV2cStjWmRwOGFlS0I0RC9qZVRZOTBvc2lhYVRDcmZkczZo?=
 =?utf-8?B?bG94MkppQmpEVkZ2bnV3VWNtQjFod09wZjlYS2pIRVY1QkR1SXp6KzBGenFL?=
 =?utf-8?B?UUhSbk1seGhIMUdvRGo0MUpWY1RTdjFsWUJ4c0FPRzZ1cWJMdVdsekJDZW5M?=
 =?utf-8?B?S3dvMzNWR1RHY0tDYWJtTDNwaVFnMmtPTDJTd0VmZzRvQmFEVjFVelViWjZO?=
 =?utf-8?B?THFmeFR5Q1UyTGJwb2N6d1QwT3QzUW8vTTVOWHlWL1pvOUhDaXI5Q1p3VVMv?=
 =?utf-8?B?M3hnc0NQVmZvbjRKM1JXSTZpV3JuZ2JBT0V5ekMwVXRWRnVSVXFiUEZGRDF4?=
 =?utf-8?B?bzhJSHR6Vyt5cHI1ZWpMVXJPaTUvd2tyQUhVVFRReExyMk42V3UwMFVpQVMy?=
 =?utf-8?B?UmFKS1UramZQQm9XNUdubWxNREVVWFN4NURlZE1jTXVaRXRRM2tORzFId21H?=
 =?utf-8?B?Vi9lRU1DMFJSWEpxcWhWb3FuQmhITWdOMnZOVVMzSTM4VEppbjNLd2NXZlRM?=
 =?utf-8?B?WHpxdWlSS0drQ2lXY21iY2xET3krU2VBdSswZ0t5OUMzUjdUOWVZcTh0VmFo?=
 =?utf-8?B?S1pFcmozbzdFKzQ5M01MK0tZbDRoekZqZ1VsYlNOUGp2L3owakczMHdOV0F3?=
 =?utf-8?B?blRSejN2ejVJK3BIS3JqWkROQ3B2ck1yaElTbjJYckhZWXhiM3draDczMmVX?=
 =?utf-8?B?dTRheW0wLzQ3clMxYTlSaVB3cWR0V0dJQ2tvQUYrUVMvRHNOS0gwalp0S0Fa?=
 =?utf-8?B?aUNMTEsxNHBkRW5iMmFYUWxENFIyUmNDVFNUYnBON0NnUEZna1VSVmUwdm5z?=
 =?utf-8?B?L0VpTmRoV2Y4eXdvNlVhdWNpWVhtSUk0dFJ0d1ByelRJcVhqTk4xY2xncHFo?=
 =?utf-8?B?M3NnNk94RHdrN0JFR1R3UVpya2ZTZ2ZpWEFZbG9vZ1pld3pRY1JTaDJXWjBq?=
 =?utf-8?B?dzVxNk8wSVg3MnhuK0d6V25KRjd3QXp1LzZVZXluNXExRW13UUhOZy94Y05W?=
 =?utf-8?B?YkV1SHk3RTIwRGhsb2JUOXhOcHN3RmJoRUozelVUYllzWVdCT3lKa2RGdnFH?=
 =?utf-8?B?MVFnUk5UVlRzcTFTWjVhVHlnYnI4Z0RmWDFYdjBrdGFiM2lDRHVEOFVlOE0x?=
 =?utf-8?B?NUU5VVJWZCtab1Z3ZUxOUUhMUHZLdFkvTUErMnVjSVhCby9JWEpTVkxzaTBy?=
 =?utf-8?B?T2J6S3VhQWowSGN1ZmNBVEVCUVdhcTJLTDZmVHBuUWJKM0d6K2ZYQUh0WlUx?=
 =?utf-8?B?T3hBRFJwd2R6eWJCNzkvbld4aXd0MFhrOU9sQWpsTUUvT0x0RHlHeHcySzFY?=
 =?utf-8?B?VTFRbFlkS0wwWTN1eXpNbjlTWE93alA3OXgraGN0czVuTkh6NjFXZjA1cnUr?=
 =?utf-8?Q?8QWurz9/X8AHH1+TJeC31Gzx3SIZZc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3437.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eS9UN1pDbzJSbUNUSDJvQTlNZkZUYWcycURXUW14MTNrN0Z0akg3RzAybTBi?=
 =?utf-8?B?OEVKV1lROGY1V1A4dFphRGRXL3V3OHNkNXUrQmpCWHduRklkSC9LSU1Fd3NL?=
 =?utf-8?B?VG1ndnN1bHBhZU01Unc5QkJjNThTRFlWU1hBWUFTbjQ0RmpTc2NMZFJpbmw5?=
 =?utf-8?B?WkFvWGJFV1dQYUE4Q0F6T0dLUWhqeVRPdklpbGZ0TlVITkxjRmxidG85YVJ3?=
 =?utf-8?B?TlZ3Z0lRSlljdWMyb3RtNE0wbFBrRkcxa1orZnN0TzNkSEZ0b3RtR2t3d28x?=
 =?utf-8?B?N20zemRQSGRWdDdxdEphTVk0QnE5YWJIckUxcnozcFR1MjcvYUxrY0xUc0t5?=
 =?utf-8?B?bmdQd0t2UXBHM2Jza0VXQm5hV1RWQ2l0TjU3RmJBd3EwMTN4MGpMYTFxU2wz?=
 =?utf-8?B?UXV6SGFsTm5vSVNDZjRVSE12VnUxOXZaL2RuZ08vYjRGNDg2Rml4NXVPWm9J?=
 =?utf-8?B?S3JQaEhFYVVhempxQWlQNXZjdDZRUVBudXJwcFBMb2w5M3E1OFJkWXBHN2w4?=
 =?utf-8?B?VFg5WmsxMVhsL2NtdXorSHBUMG05ZlBTckdQL25LZkpVS0JCaCtudEg5NWZo?=
 =?utf-8?B?M0VqUTJtZEI5MTQwckIvSWpyc3V4SFFHWnNIR1NITnV6L1VSNkxQU3NON2NM?=
 =?utf-8?B?Wk90aVNVeE9sZSswNkJEMEVUczRlam1mU2JlU2dJdzU1NC9XU3RORUxNcS9V?=
 =?utf-8?B?ekJ5bE5LQlFla0hBMDRaS1ViNGxGMTlldEp2THFnVlVlY0dBK0hTNklhcjFH?=
 =?utf-8?B?aXUvdUJPcTNxenQxNlFIZVhjd0J1NWtHSXRYU1hYQ1RTc2tGWFZOSzVlU0tX?=
 =?utf-8?B?VndOMHhtSDVMNDR1OFB2NTBac1dFaGhRbzEwVG9Hd01RKy8xejRXN3dNbVU4?=
 =?utf-8?B?RzY1M1loQ2FhQUdCUHFpVm1qQnhodlRsNnVmc3dmR0FWSHpJcEhCOStyQzV4?=
 =?utf-8?B?eXVVRSs4K1JETHArOXVkRU96SGtMUXhFbTMrSGhIU3J6R2Ywbnd3NzRpSm9C?=
 =?utf-8?B?Y3U3Ni9VSDZSMmNId0ZJU29xR2xRM1dGMkhOWXRJTUNoamZKR1lmTytaWWZl?=
 =?utf-8?B?N2RwMVNmeTNWc1I1cmxhVkZaMGJjcDhXbFJldThzRk5iYUdsRGRUM2hTK0pJ?=
 =?utf-8?B?UUNvWGtSMkYvWkpweE9vLzBLcDJNcnMrS04rOHdoSmFEM3N0Yk8vdW5OKzdk?=
 =?utf-8?B?c0llZXI1T0U1TVhzeHhOdVNlQkl5TVJwTnJROGZPc2I3WmE5dDRkN3BFUk5v?=
 =?utf-8?B?T2c0amRoRDlBaVAzSFZnV2M0MDFKV0hDTTN2QStuM0hLTDlyeVllczhGMW9Q?=
 =?utf-8?B?eDB6aGlSeFF6QUZHSFl3S2xPSGkxWUFJYVVjQTlXY2p6bEpHbytLZ0xTRmpS?=
 =?utf-8?B?L3VuTVpsaVF1elUzeERzL0RpSG9MSi9aTEt6cG5OdnhHQnA4UjVOZldLRzlU?=
 =?utf-8?B?dTVRQkZIQlJqdGF5TVV2Q09mKytIRUtLeWxrTlVYWnlNY1kzTldhT0l6aHFC?=
 =?utf-8?B?WXFVWkN3T21JY0Ztbi9ZUklDNSt6RXlTRVB4WUY4TlVBZkJkbDc3ZzV6YXF0?=
 =?utf-8?B?WTd2VHZoR2VjRFk3ZGdWWTRXK2YrZUtJSXhYbG1hQkFjK09COW5zYlEzaWtD?=
 =?utf-8?B?UEJXOHBGNFNkRGlIdElLK3I2R0xKVlV5RC8xNDBPM1dCaWVyK3R5a2N0WDNi?=
 =?utf-8?B?TGpWMTNDQzEvUStaMDdUNXdkMTg3WHBtOFRCdThGQWJtY3g2NFFJUTlyaWdP?=
 =?utf-8?B?Z09uVVZGVzl5a0hjVnQ3eWJaZjZzeHJaQ2w1WldqY3RvSEJPQnZZNGM5blJt?=
 =?utf-8?B?bUNqc2s1M0FnNkh3NGQzd2JnMWxIYnpSVk9lT3ZnTzZQTXpyV2VnZEpGUnMx?=
 =?utf-8?B?VmxSV2VTZTI1WGprczJXcmNyeC9TTFJRVGVXb1doWXAvY0ZGdmZvRFlLOFNH?=
 =?utf-8?B?bmpVWmlucnEyNHBwemVwdmZ6cFIrWW1VTGNQa3A5Y0RsUGhEZUxTbEpGWHRM?=
 =?utf-8?B?Njl6amovK3dLNWhqak1MOVJtVEhaVkIxbmJCSlRlUGhFYkVqdk9yVFBWbFBB?=
 =?utf-8?B?Q0VURVFuSkVIK29rUS83anJvZklPU0hJcDVlcnA1MzJMVWl5Z0U3dWtMVXpS?=
 =?utf-8?Q?u4kyuGFRHvUTPJ/7GhHEfwJCK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3437.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5588b7b-ee44-48b6-dce7-08dd94c30702
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 21:45:51.3332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: saxQfDF57AovqWYC9m8aZpHEzYLwZT0ykTcQ64IZGxnaPZug+IjI9HFmENq0wI5vMW4KmWOUGyyHkl16KwxXpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3123

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQUxPSyBUSVdBUkkgPGFs
b2suYS50aXdhcmlAb3JhY2xlLmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXkgMTYsIDIwMjUgNDo1
NyBQTQ0KPiBUbzogSGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT47IGxpbnV4
LWh5cGVydkB2Z2VyLmtlcm5lbC5vcmc7DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6
IERleHVhbiBDdWkgPGRlY3VpQG1pY3Jvc29mdC5jb20+OyBzdGVwaGVuQG5ldHdvcmtwbHVtYmVy
Lm9yZzsgS1kNCj4gU3Jpbml2YXNhbiA8a3lzQG1pY3Jvc29mdC5jb20+OyBQYXVsIFJvc3N3dXJt
IDxwYXVscm9zQG1pY3Jvc29mdC5jb20+Ow0KPiBvbGFmQGFlcGZsZS5kZTsgdmt1em5ldHNAcmVk
aGF0LmNvbTsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsNCj4gd2VpLmxpdUBrZXJuZWwub3JnOyBlZHVt
YXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyBs
ZW9uQGtlcm5lbC5vcmc7IExvbmcgTGkgPGxvbmdsaUBtaWNyb3NvZnQuY29tPjsNCj4gc3Nlbmdh
ckBsaW51eC5taWNyb3NvZnQuY29tOyBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsNCj4gZGFu
aWVsQGlvZ2VhcmJveC5uZXQ7IGpvaG4uZmFzdGFiZW5kQGdtYWlsLmNvbTsgYnBmQHZnZXIua2Vy
bmVsLm9yZzsNCj4gYXN0QGtlcm5lbC5vcmc7IGhhd2tAa2VybmVsLm9yZzsgdGdseEBsaW51dHJv
bml4LmRlOw0KPiBzaHJhZGhhZ3VwdGFAbGludXgubWljcm9zb2Z0LmNvbTsgYW5kcmV3K25ldGRl
dkBsdW5uLmNoOyBLb25zdGFudGluDQo+IFRhcmFub3YgPGtvdGFyYW5vdkBtaWNyb3NvZnQuY29t
PjsgaG9ybXNAa2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g
U3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BBVENIIG5ldC1uZXh0XSBuZXQ6IG1hbmE6IEFkZCBz
dXBwb3J0IGZvciBNdWx0aQ0KPiBWcG9ydHMgb24gQmFyZSBtZXRhbA0KPiANCj4gDQo+IA0KPiBP
biAxNy0wNS0yMDI1IDAxOjIxLCBIYWl5YW5nIFpoYW5nIHdyb3RlOg0KPiA+IFRvIHN1cHBvcnQg
TXVsdGkgVnBvcnRzIG9uIEJhcmUgbWV0YWwsIGluY3JlYXNlIHRoZSBkZXZpY2UgY29uZmlnDQo+
IHJlc3BvbnNlDQo+ID4gdmVyc2lvbi4gQW5kLCBza2lwIHRoZSByZWdpc3RlciBIVyB2cG9ydCwg
YW5kIHJlZ2lzdGVyIGZpbHRlciBzdGVwcywNCj4gd2hlbg0KPiA+IHRoZSBCYXJlIG1ldGFsIGhv
c3Rtb2RlIGlzIHNldC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhhaXlhbmcgWmhhbmcgPGhh
aXlhbmd6QG1pY3Jvc29mdC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL25ldC9ldGhlcm5l
dC9taWNyb3NvZnQvbWFuYS9tYW5hX2VuLmMgfCAyMiArKysrKysrKysrKysrLS0tLS0tDQo+ID4g
ICBpbmNsdWRlL25ldC9tYW5hL21hbmEuaCAgICAgICAgICAgICAgICAgICAgICAgfCAgNCArKyst
DQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9zb2Z0L21h
bmEvbWFuYV9lbi5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9zb2Z0L21hbmEvbWFu
YV9lbi5jDQo+ID4gaW5kZXggMmJhYzZiZThmNmEwLi4wMjczNjk2ZDI1NGIgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9zb2Z0L21hbmEvbWFuYV9lbi5jDQo+ID4g
KysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9zb2Z0L21hbmEvbWFuYV9lbi5jDQo+ID4g
QEAgLTkyMSw3ICs5MjEsNyBAQCBzdGF0aWMgdm9pZCBtYW5hX3BmX2RlcmVnaXN0ZXJfZmlsdGVy
KHN0cnVjdA0KPiBtYW5hX3BvcnRfY29udGV4dCAqYXBjKQ0KPiA+DQo+IFtzbmlwXQ0KPiA+ICsJ
dTggYm1faG9zdG1vZGUgPSAwOw0KPiA+ICAgCXUxNiBudW1fcG9ydHMgPSAwOw0KPiA+ICAgCWlu
dCBlcnI7DQo+ID4gICAJaW50IGk7DQo+ID4gQEAgLTMwMjYsMTAgKzMwMzIsMTIgQEAgaW50IG1h
bmFfcHJvYmUoc3RydWN0IGdkbWFfZGV2ICpnZCwgYm9vbA0KPiByZXN1bWluZykNCj4gPiAgIAl9
DQo+ID4NCj4gPiAgIAllcnIgPSBtYW5hX3F1ZXJ5X2RldmljZV9jZmcoYWMsIE1BTkFfTUFKT1Jf
VkVSU0lPTiwNCj4gTUFOQV9NSU5PUl9WRVJTSU9OLA0KPiA+IC0JCQkJICAgIE1BTkFfTUlDUk9f
VkVSU0lPTiwgJm51bV9wb3J0cyk7DQo+ID4gKwkJCQkgICAgTUFOQV9NSUNST19WRVJTSU9OLCAm
bnVtX3BvcnRzLCAmYm1faG9zdG1vZGUpOw0KPiA+ICAgCWlmIChlcnIpDQo+ID4gICAJCWdvdG8g
b3V0Ow0KPiA+DQo+ID4gKwlhYy0+Ym1faG9zdG1vZGUgPSBibV9ob3N0bW9kZTsNCj4gPiArDQo+
ID4gICAJaWYgKCFyZXN1bWluZykgew0KPiA+ICAgCQlhYy0+bnVtX3BvcnRzID0gbnVtX3BvcnRz
Ow0KPiA+ICAgCX0gZWxzZSB7DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L21hbmEvbWFu
YS5oIGIvaW5jbHVkZS9uZXQvbWFuYS9tYW5hLmgNCj4gPiBpbmRleCAwZjc4MDY1ZGU4ZmUuLmIz
NTJkMmE3MTE4ZSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL25ldC9tYW5hL21hbmEuaA0KPiA+
ICsrKyBiL2luY2x1ZGUvbmV0L21hbmEvbWFuYS5oDQo+ID4gQEAgLTQwOCw2ICs0MDgsNyBAQCBz
dHJ1Y3QgbWFuYV9jb250ZXh0IHsNCj4gPiAgIAlzdHJ1Y3QgZ2RtYV9kZXYgKmdkbWFfZGV2Ow0K
PiA+DQo+ID4gICAJdTE2IG51bV9wb3J0czsNCj4gPiArCXU4IGJtX2hvc3Rtb2RlOyAvKiBCYXJl
IE1ldGFsIEhvc3QgTW9kZSBFbmFibGVkICovDQo+IA0KPiB3aGF0IGFib3V0IG1haW50YWluaW5n
IG5hdHVyYWwgYWxpZ25tZW50LCArdTggcmVzZXJ2ZWQwID8NCg0KVGhpcyBpcyBub3Qgc3RydWN0
dXJlIGdvaW5nIGFjcm9zcyB0aGUgIndpcmUiLiBDb21waWxlciB3aWxsDQphZGQgaG9sZXMgd2hl
biBuZWNlc3NhcnkuIFNvIHdlIGRvbid0IG5vcm1hbGx5IGFkZCAicmVzZXJ2ZWQiDQpmb3IgYWxp
Z25tZW50IGluIHRoZXNlIHN0cnVjdHMsIHJpZ2h0Pw0KDQo+IC8qICtyZXNwb25zZSB2MzogQmFy
ZSBNZXRhbCBIb3N0IE1vZGUgRW5hYmxlZCAqLyBmb3IgY29uc2lzdGVuY3kuDQo+IEV2ZW4gdGhv
dWdoIHRoaXMgY29tbWVudCBpcyBvcHRpb25hbCBoZXJlLg0KDQpJIHdpbGwganVzdCByZW1vdmUg
dGhpcyBvcHRpb25hbCBjb21tZW50Lg0KDQpUaGFua3MsDQotIEhhaXlhbmcNCg0KDQo=

