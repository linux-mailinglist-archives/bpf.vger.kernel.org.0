Return-Path: <bpf+bounces-58464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C18FAABB0D1
	for <lists+bpf@lfdr.de>; Sun, 18 May 2025 18:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32EDE1895064
	for <lists+bpf@lfdr.de>; Sun, 18 May 2025 16:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D9121CC64;
	Sun, 18 May 2025 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YlyAqY9M"
X-Original-To: bpf@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021089.outbound.protection.outlook.com [52.101.57.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED81E4B1E5E;
	Sun, 18 May 2025 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747585424; cv=fail; b=bNHwg5I7IRh5ekcVWc9vayQx+cUaa+//Ya/qeOfoFgr4HDBGY/1Ymfwb4gt88MK1CL2DRb7Ry5SLX8MudeM92A/OXbb/tEIBMCowjSHjzxyqL6Xeofa538ZOCz/LguM5fGJ9F4oG1/llTNZ/TERWRkICRjXDznaPS1D2nod96ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747585424; c=relaxed/simple;
	bh=tTyXkn3MNmHPcXroRCM7Qs387wId6mKzsc/gFKq9CQU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kSc/bnjezouAaR+eecGMUZfi5UNg0xotsaKzi+5GR5HpuvkEk4OrVmoWfDlXwyU0a7jfBKiUvKistCfG1vs9B8CIRuhua5y/k95gq8/l2QFIw9JCMbkPjjxaA3KnpcVLBgCbWAwF06naa8+xGSZTyLHwzkFALoKm68quahGqy8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=YlyAqY9M; arc=fail smtp.client-ip=52.101.57.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIzAAahVJWJy0FkNx7R24KaJg15vRkibhL7BKg+5E6LQWPxlU07AaPjczBbg1p9iLXRgC2wf/RacDPv3uDkYWX5gTqzFeZWdobjE2OuLl04/MAY0Z5EGq2xtd3e5MGf9hG1MLY/hs3IRcdXpLhj2CwbI0639uxdHzbXIFSldiFJt3+uKFsmFoaYIE8VnqBVoBYP+Fiv2wjDqC7+dKq3qVXhOr/fiDXSQ9mG/2XFqjuTV60167iTGRGsuxoIGOy91Cfeq4otA8xRXRriM5K8sT57IcM5lPOYIL9gSDuirW30R4KGCTbSXcWegUaw5j1Pt2nYOLOD4Qdso2Iiw50KCXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2pp7dDVPVEVJ3QKmrq05WEe9QQhkUVoH6sJt4Rt2Bc=;
 b=TQpteV5+IUFguuXbwyH2dban2ZYDq0LDbGwVm3wBhrMvLaAOUeXGO5KzFA0w1FCsZj6dcw+uDMg/KejpjK+hTfgL07h2Q37m+mPTATE35siThpWjArOxTsPwG2dUeAyrWTGANpCUwFJanGNyCzJy2sycQdIiSXn60uTG5FIhlBDIJaSnImkEvTNS+eHoI1S9UG3Bh/6idXKd+Y+zJJkO/Ko74fbSjevnMhfo+gROIQ5VGpSbXKCuUpMTXZwCOK6/tEaWObn29nz+HFJV1yTZJ2XhuDaZlHpL/OJTHRN8mRtYmE+UZKnyjGbR/Z9sQ7d9mv5VljW0L8SPAqQ7UKYhKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2pp7dDVPVEVJ3QKmrq05WEe9QQhkUVoH6sJt4Rt2Bc=;
 b=YlyAqY9MQvVRg8wsFcVddg8kcUJ82QTKbRDE8fwqaO6upyFChkyGypvFpeA3finI2SWTYMkzVbrcBMA2aR/v2LyHwl8wazbbwXma/T/TE2zBAV6Xe79xm9ypokUD9LoeW7uD9csQ1F3SncGj+GA6+bOygM6jhlcgb+1p+z8E/4o=
Received: from MN0PR21MB3437.namprd21.prod.outlook.com (2603:10b6:208:3d2::17)
 by MN0PR21MB3168.namprd21.prod.outlook.com (2603:10b6:208:378::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.4; Sun, 18 May
 2025 16:23:39 +0000
Received: from MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97]) by MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97%4]) with mapi id 15.20.8769.001; Sun, 18 May 2025
 16:23:39 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
	<hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "kuniyu@amazon.com" <kuniyu@amazon.com>,
	"ahmed.zaki@intel.com" <ahmed.zaki@intel.com>, "aleksander.lobakin@intel.com"
	<aleksander.lobakin@intel.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC: Saurabh Singh Sengar <ssengar@microsoft.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net] hv_netvsc: fix potential deadlock in
 netvsc_vf_setxdp()
Thread-Topic: [PATCH net] hv_netvsc: fix potential deadlock in
 netvsc_vf_setxdp()
Thread-Index: AQHbx6eoP016nJk2S0CcGjqDqYBs+7PYkp4Q
Date: Sun, 18 May 2025 16:23:38 +0000
Message-ID:
 <MN0PR21MB34371EBD052E958A8D50105BCA9DA@MN0PR21MB3437.namprd21.prod.outlook.com>
References: <1747540070-11086-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1747540070-11086-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fd63344a-899d-4c2c-a9cc-0bc02c89c62c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-05-18T16:21:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3437:EE_|MN0PR21MB3168:EE_
x-ms-office365-filtering-correlation-id: 560a7029-1c4f-4399-97ec-08dd962858da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Dj4g48ETXxcqLOBMNvQWZHq36+ILQt5kn+Kz7/RZXtkrP0uj66rxOCSFxtY0?=
 =?us-ascii?Q?WRaGAtq3papQEky0eNJBP4NtQHfdon42IpivwQ8V6eDGvtAgVCvkP44V7CbX?=
 =?us-ascii?Q?qgvEIxquGG5QQoC3bA8b3GcmBL/do2XHOiPjo2bjNvm2NKaY5HYE3jtQ9bv6?=
 =?us-ascii?Q?WMBOT6P/yPa9dZXLeA/qj9lh5leDIWz1SLa3nILS8YUYP/6yLiJfMADui7Rh?=
 =?us-ascii?Q?J4zOmZtKrxWY1NEPfpIUFe1kRMXsTpsuNtfBlJIVtTQaKGxnb0Jt/ArUOVi/?=
 =?us-ascii?Q?jDPG2d0r3FmbLW4G436iYZcpSXOCkzw5XgFTdWQx3GpMXvMp1UIfeAJhdgCw?=
 =?us-ascii?Q?qnl1gntg7lEYgxXrTx/qCU553eHbLhuhHzVjX3woMYpXKbbN1TZbCt+GIKgo?=
 =?us-ascii?Q?U9PHRzBXxPlx6lyqUTLcAiQ0zewvbm5/E0BTivKLktWvs0mYRuXNjgcVttiY?=
 =?us-ascii?Q?7fCt9OsLf3GbaEbrks4ay5kGZmoeQOBYfp1qvv0hwXQors1imEtnrsFaHhhS?=
 =?us-ascii?Q?mQjw18fZbWwQnhK0SMeaBY4SVJgMMS2tQEY+Ycx/uUC1OBebxicGPGhP2pJJ?=
 =?us-ascii?Q?D5Cql7t1/vwh8brwOpMArjX+mGk9qSMHv7/kl04RiisH0W9ZbpzXJqUYWHPC?=
 =?us-ascii?Q?wo2ExxgDBwGrmNAybRFK1OnPpc+tJwAXWMyy5d/1R1NG6WCRFw3OS0+A7HUH?=
 =?us-ascii?Q?AFevppHl+Rov4WS51yzT4lWZHguLZW+WG6ubpWIPj8iRGuZMSo1+EiI3UWMD?=
 =?us-ascii?Q?HV/spkIJW+02rxbJ+SwizmnNyzuTksHCfUzU1IVkkHdsy6ZxLpRQlvPxOsgv?=
 =?us-ascii?Q?T+rI/IfsR/ggsFbYdbjijutJEIrgLenOmrAH9YsdgjkCtoNGqvKutZlouLJT?=
 =?us-ascii?Q?LoYfC9Mk/IUJiZrN3tSzz9iQsQe3DFr6Zz19jOUbO2rDNJxeafsXGAZqKSng?=
 =?us-ascii?Q?qCdjU5U5kZGDrcZY4LscE/Tfv2XPxYiw2CxnII6PsvfEjWnR3f+Avh/k3pKy?=
 =?us-ascii?Q?rN2Psmp741dhqw2wo7s2Ft680rha4uQCB7QTWlh+XZmBmFM+3A1Xil+TuKVT?=
 =?us-ascii?Q?nRtuz8Vg/zHb3FnYWdsnkJuio1/OqOLgVRhDb3f9tD5wrbREQGyfuHPijLNR?=
 =?us-ascii?Q?CBcVzzhk7elHdYEkn4STUQWZrvR+LumnU7ebnyWZqlKCEoniI0GpXlTCIRmO?=
 =?us-ascii?Q?Lud9DoPnW/FChpu2RM/Vd28PBUpcxcB9anL6+XZk4QzIG62/fFqQkZSdgPnR?=
 =?us-ascii?Q?+C/a7kUDyuH3eDDeC7Sqki/hfH6qNp7bw+qt53aV1PGulY4EMmICexaw7+No?=
 =?us-ascii?Q?xkL8q8HSFHh93xN3+nV7P1UfJ3gTq+4nbKOyI4LSgsgWCK7RMpCFHZC1E0IG?=
 =?us-ascii?Q?5Qmh8CgguIJlQp5cEpKR1bknXaRu3C0EIBBEBh4eqWIL32M7o/gMnDeQseAj?=
 =?us-ascii?Q?vgEtwG/VSSp2266zs1BeWlyF86voLvgmNbU/GtV+M3o6vIFrZKYulmgrdFye?=
 =?us-ascii?Q?+0DPvYSUfZ+Tps8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3437.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020)(38070700018)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wHuM7gaV1rMVrmyxfUPe5JVPIwvSllu639W2ldi5f+BPAEQXe8JTI38MRwcc?=
 =?us-ascii?Q?bI9pKnQjiwThoIZaMUzLMvM/IE6vsDtObX+yq5sSl8/4xue2PwYT89YDaHGU?=
 =?us-ascii?Q?HkETpzhz7mI5zRLCxEMqW4eB/sZ0R6lm0JtrT22eCABLFcYQ/2UFTk4u3ncz?=
 =?us-ascii?Q?eUz6wpHO74fsmqrZo83T/88uzEMI94oGm8fCXCPK8RKTUZEsP/aupatr70mu?=
 =?us-ascii?Q?WzeER4Q9aw1p9b2Og+K3Xsr+lA5fzJz/l+WzyHM03sogpWrSy0mlC2FhmzUB?=
 =?us-ascii?Q?iT4rQZ2xkBEYj/++aXOVAvH9GHgFCwEUFSvd7XXFrqret8UHoW4i68kAIRfa?=
 =?us-ascii?Q?CoAgM+DXnZs5mbQ5nrAnyXLqGTE3GNqkHZ16ZrS4g6bH5At0PYL/bsukz84+?=
 =?us-ascii?Q?QwPs7zdyYPZdn8lJpfnRfl+Zwb5ohj9s1groJwbsk7Qm/TrRKREaWyNFcHPz?=
 =?us-ascii?Q?/T6Jz0CaSrY2BntDKfMxbWnIs0/bd5E8/hB30X+392BMQD8CWAYx2YprvB1Y?=
 =?us-ascii?Q?aJNZ2XrtuxKxjVg0kmhN2LrC5k4Afm5w7Gdu5Sn4hfx7Fkvlw7pHG2vMLFMW?=
 =?us-ascii?Q?E4kLM+OjMNXHUT4VhNT3QqJSzsM9nt0G9JyXGsMiO8bV7LLVkc5MH2uWX0cp?=
 =?us-ascii?Q?g7xr0K4gEpualWbPfOpTtPi1nWy0YnJbf4bBFt9s7Uk+q8e5KMMZ9WtwvlaB?=
 =?us-ascii?Q?pBShEW5dUlXW+OmN4a6aQRyJC2J4lnS/m8PIsTQnDZXnGJldI9YaAwLeLrpJ?=
 =?us-ascii?Q?tDzGfyrdKIrhCl2PVqE4SNvJLeWTOaJvduXiZEi2JMggMhreOQ6F57iLrNH+?=
 =?us-ascii?Q?u4AO7cORiFgOH4I/1OymQklNHvzobtghXxxB8GA/EOaRP0Mk0UaEkixXUzFo?=
 =?us-ascii?Q?upeiNmy+NTNOYCfWAWsWqDC5J+/yUrgjpV2eGnnwmj6VSxADURS/zk3TYP/P?=
 =?us-ascii?Q?D4nl7/CU44b0gY3gKMiOEWEq0+nkw3GSiGcwI/cC3/MOY10QRSiEE67E0p5p?=
 =?us-ascii?Q?KS3sjLxTx6M5TwTex7nZ5lbuhMta+twMlSyseJq2XP7Ok78btLeVC1AEwKPO?=
 =?us-ascii?Q?TbEZmb5D4oqXMw+2Y/e55zFQXWbkeEmpNI9AWERHv18Wn25u0ynfMLXQf3iA?=
 =?us-ascii?Q?wptNhcCC+TbykmKpSOdzkeoiE34dGeR4Mz+ID6vFl41dMnuEDisnBkv8M/nK?=
 =?us-ascii?Q?fA9l4tQpInsnT+cMXtjP2tXdfuNrRJ1MX/WstONh40F8jBhiJ243AoGF0a/K?=
 =?us-ascii?Q?HqoaI3PjgwWeDLl1yHxNt/T2hzKOro41QHiS74N3SmXEvtf/LwitwJ67Ka8v?=
 =?us-ascii?Q?vIMPubQLHG8UEaFyZElDr3kDkd5YBCZyeTP7HwLmvu3C+IBjiBs76ZSA23Fn?=
 =?us-ascii?Q?XB7MIGuqG76nCGhq73oDvN6GhlusHSsFN5404D3Vpin6A0DwpOASZ1LgnUmW?=
 =?us-ascii?Q?w0SYCzD216BO5dSVjuQaEZQpQPeqMjM1e7P0IskyML9WBfVdUzarXLR3xnEF?=
 =?us-ascii?Q?p9H2cXdv+G2zeAeiDp5MYGkoR3DfdpqyyISFG+j9DBLjuN5OlsXpznKT8F/Q?=
 =?us-ascii?Q?jFUor+d0hEGpmfA8V/FYytUkzlP6oub3bPMn7VfF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3437.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560a7029-1c4f-4399-97ec-08dd962858da
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2025 16:23:38.9842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BdFkWttaF5P1Sgx+Va7VXgNRhHuNR2VNQoHFee14UTwMy3gParl79oAlmuGArffuKTTgRQIsXZdfQXTZqcZFOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3168



> -----Original Message-----
> From: Saurabh Sengar <ssengar@linux.microsoft.com>
> Sent: Saturday, May 17, 2025 11:48 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; pabeni@redhat.com; horms@kernel.org; ast@kernel.org;
> daniel@iogearbox.net; hawk@kernel.org; john.fastabend@gmail.com;
> sdf@fomichev.me; kuniyu@amazon.com; ahmed.zaki@intel.com;
> aleksander.lobakin@intel.com; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; bpf@vger.kernel.org
> Cc: Saurabh Singh Sengar <ssengar@microsoft.com>; stable@vger.kernel.org;
> Saurabh Sengar <ssengar@linux.microsoft.com>
> Subject: [PATCH net] hv_netvsc: fix potential deadlock in
> netvsc_vf_setxdp()
>=20
> The MANA driver's probe registers netdevice via the following call chain:
>=20
> mana_probe()
>   register_netdev()
>     register_netdevice()
>=20
> register_netdevice() calls notifier callback for netvsc driver,
> holding the netdev mutex via netdev_lock_ops().
>=20
> Further this netvsc notifier callback end up attempting to acquire the
> same lock again in dev_xdp_propagate() leading to deadlock.
>=20
> netvsc_netdev_event()
>   netvsc_vf_setxdp()
>     dev_xdp_propagate()
>=20
> This deadlock was not observed so far because net_shaper_ops was never
> set and this lock in noop in this case. Fix this by using
> netif_xdp_propagate instead of dev_xdp_propagate to avoid recursive
> locking in this path.
>=20
> This issue has not observed so far because net_shaper_ops was unset,
> making the lock path effectively a no-op. To prevent recursive locking
> and avoid this deadlock, replace dev_xdp_propagate() with
> netif_xdp_propagate(), which does not acquire the lock again.
>=20
> Also, clean up the unregistration path by removing unnecessary call to
> netvsc_vf_setxdp(), since unregister_netdevice_many_notify() already
> performs this cleanup via dev_xdp_uninstall.
>=20
> Fixes: 97246d6d21c2 ("net: hold netdev instance lock during ndo_bpf")
> Cc: stable@vger.kernel.org
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>




