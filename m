Return-Path: <bpf+bounces-58021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CDFAB3B8A
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 17:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4147460B5E
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 15:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5470C235066;
	Mon, 12 May 2025 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="chpG0gni"
X-Original-To: bpf@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022133.outbound.protection.outlook.com [52.101.43.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D55C23184F;
	Mon, 12 May 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747062019; cv=fail; b=o8gxudttNglZQoeH/WOftzmWFSqY3uHxh9uIft97NzUTp/DeS9SuIgS5TPDJRd0P/DdDt1msfxNlAoMydgNmcCsG23bzhSomnh1dyFq1bGuIby83wRxVAPjj9r6mRPcu4qZulYBTPNbFXCwdgVROL41o8KkQwufwzdRSP5ybC+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747062019; c=relaxed/simple;
	bh=eyM/O6yf+wWVlwC0sWwJwk+oaDLNz+8tM4bmhLLWzjY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GISdozarxLF+Rtq0L8TMz5ee7N/TGMuLQmhDiNwPYKQzJ+h5MujAYmktwEa4KHQxy2zz/yQSUwu/8DrijtX4DPYkKBIGG1BAeqX9zZXRvKunJ6e05XQPdulmDoAVYcSDtPZIxafI3VqWy/5O/06mp0NsmiwvtFay8LYdZ2ghWxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=chpG0gni; arc=fail smtp.client-ip=52.101.43.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oG3haRYM6Dk2rcq6XNKZbCpgB+cMoJOo5EmPjdLkXOAG+fUxAWRHr1BMU/Whf639jxYaYfmPavsmSn3iFBk8QWFyVSi0O3/lEmVEWogOE8TtkPBdEGIfw8VkV4m4P/H3z0itVzexJrQSfx8u3iCYGxcD/HQukGVROlSlAiR+LOofM2rArsmeMuN4ahgSlLFwNVqYeXPGpzYX4YEZlbo/K2VNIek1/lKpisP02z8EvlDPwk+vfZu4bwM0rQhu9XV+LTVRg6ppz3aH9LLnxcWzN6oplmgTloRb7s3K6cnGb6Nj0oEXTDNiZxrT0Fb5rHUIgb8wc4IgrscmK37rF/lPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nH4C9PxeKhGUpaSgSDpUHEcavZg+QfFo66TkqS9BSoc=;
 b=mIco7YL9PSoF038jonTdKscB3X3H1uJ5tYFH3MhoiuDpnSdYQ05/QFXlG5b2Wl+QBef17qtCaDQ+xJA3uYvagvaNv/tGkV5Kmq99loKK1d+3K2GQtmsKeXI+IryyzpQFpZ+pm/P4xyunqBk7qJ7wo8VoUIDno83f7OsJAtEPzqvR1N5Ent3irlVr4t6uWzwRvnJBsuOdtqkj6PzY6nzFPfShCoZzYd9GbB5Q3Lo8HnHG3CWQ6ymJ9aGLpFwghe8vpJpVq+njSs5OdDdHLGErv7ZNZbJGUuWgoZ+5Bg6SrhjNCJueS2qQOXXvk6WvDFNtHbS1wsFykx+WRE7ReNeprA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nH4C9PxeKhGUpaSgSDpUHEcavZg+QfFo66TkqS9BSoc=;
 b=chpG0gnir6S+G8QCx81Be7aA8Xf5+r6U8EFxZ1CxaNi65UbaRjxqYAU1W6CNAa0Whw2WUaYOZ7WEXniP81sL8RbiCD3rERM66YLieHgcOMOa2jWy2l7DJkVbkImLyg2oYsZzUWXVDL+fWTY57+RwTLmQE+QAbWKZxz9qsdXP04U=
Received: from MN0PR21MB3437.namprd21.prod.outlook.com (2603:10b6:208:3d2::17)
 by MN0PR21MB3558.namprd21.prod.outlook.com (2603:10b6:208:3d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.5; Mon, 12 May
 2025 15:00:11 +0000
Received: from MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97]) by MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97%4]) with mapi id 15.20.8769.001; Mon, 12 May 2025
 15:00:11 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Simon Horman <horms@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "stephen@networkplumber.org"
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
	<andrew+netdev@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next,v2] net: mana: Add handler for
 hardware servicing events
Thread-Topic: [EXTERNAL] Re: [PATCH net-next,v2] net: mana: Add handler for
 hardware servicing events
Thread-Index: AQHbwTh1sYjMv8wJekuklPmFrwKS+7PPDkMAgAAMBSA=
Date: Mon, 12 May 2025 15:00:11 +0000
Message-ID:
 <MN0PR21MB343719B3C6DBD46E5F5B343FCA97A@MN0PR21MB3437.namprd21.prod.outlook.com>
References: <1746832603-4340-1-git-send-email-haiyangz@microsoft.com>
 <20250512141546.GI3339421@horms.kernel.org>
In-Reply-To: <20250512141546.GI3339421@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d1b7df23-6472-42f7-a0ac-ff02aaf9a3af;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-05-12T14:58:46Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3437:EE_|MN0PR21MB3558:EE_
x-ms-office365-filtering-correlation-id: 36caf2cb-3f55-4aba-4fe0-08dd9165b187
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SfOSMOuAzj3w5GKuM6cC/3N6OzvgImhPSXdEKDqfJsvONj6J7rsX6R3acmDx?=
 =?us-ascii?Q?Xxg6L1DS6rBBMCFXqu4YQnS/FjdWpdMobDA4M9Rg0kupdEyzCvceZ4h723kv?=
 =?us-ascii?Q?a7oqFxUT+dTLdTrtFMMelR91GYI07ONKLBeCE9tDlAYD+FXp34OC9LItU5Ay?=
 =?us-ascii?Q?thFudPPJEBDYK9OG5kP4dg4IHooOLEZ9Pm/rhHrLX39XS7mAN1MlLQU1Mye1?=
 =?us-ascii?Q?gDwh0yS84BD3UnP8UcdXBuHGKM/HAk+o6erYIu6sgVCFGszOXnKFaOKKAhyt?=
 =?us-ascii?Q?CzNnZ1aYSUDLKWYY32AYNFiBh8a8emAcExmE/QTsFClib5bjQnSrrh7B+PRb?=
 =?us-ascii?Q?k40HlUFEIRDvMORX0MwCUyfvnUN3LoY3XYA4YPCWT0GXzWJ/xkX251Xe4rn6?=
 =?us-ascii?Q?yRU+ke+Mn1/SavO41JKK3UHhSiJnxERYvGOkB2lj1/hK1nx+FAWExiOPjax+?=
 =?us-ascii?Q?ZQo+n7s4j95P0D97YxLnxb3k6+btTV55hh2B5oXGDdg5xKgX0wEwZIlzcpd+?=
 =?us-ascii?Q?eRULhfFIZbQPg8FxP/1eq3TtSK0I90viJ3TP1WjE1Z3VYlhWzSDxr/DdOsKx?=
 =?us-ascii?Q?qvMSee42DvSxvYS3+GulGjjwxYAqOxr1b+38535FkA4I6bLJgcMQBHtVAARm?=
 =?us-ascii?Q?D9LHWk+vodFdTad16QFwazcGxnpqrgye3HMv/uwVdayvjwJpVPIDRqlJkUVE?=
 =?us-ascii?Q?9VZ5fNbT9UPmAuY3jBq6Lu1gAk3oFnfWa1EIS7lSgJru+vONQfOhCOX/bu8C?=
 =?us-ascii?Q?46R/VKSvcKCTHT2JVKvMLEECY0bGbbAYBUk4xlpGeMsoXkxaWVLHwpi4ZURb?=
 =?us-ascii?Q?XUtPTlaci8aDNrac9yk+4MjLwl0JybvyJBSK7x6DnmLsx3JoK3Ym4GAom90g?=
 =?us-ascii?Q?RQ8P3g8dQtWn7Mi30oL6rFDWvh3mnlO73htPHiXZ3dpzjyY9Yd8LySPPLZoN?=
 =?us-ascii?Q?OKHM4/D06M2XYbotZOUpD1yvyTb15DNOwBtbiVBc3yuZ62hh1horVvLwpfQr?=
 =?us-ascii?Q?mwdxEnkg3FPkEznGIHOL5rsnqi93ncktnIdmKbXJlryjla4zGcuwBus9r/tL?=
 =?us-ascii?Q?o/g+HLqS2GIq787SAfpJyivixyRyzkFse9jldXgnlGFqXT5l10kBSNC/iZxa?=
 =?us-ascii?Q?R9MP3V+vESW2lDEM+Dhhg/QgL8JZ4Htxjxlum+9g9pXWsNyzXRcVVPiPsUTe?=
 =?us-ascii?Q?PirEX6bSJnPGY7qK/Mi9OoCsSl36DTy8RGNpD/c9UQK3jVN3At9HBTn+GCI7?=
 =?us-ascii?Q?68+QmeTb+fS37NboWt0MxQcZosr2QSBPt7fBw17H2PwnISnpdkz+wvLAh0uk?=
 =?us-ascii?Q?LAIJD/m7bb+/9cCKJxscCIFttkar0iipxyrZ4kiofP1Jt7CWjgfPWW7tnRJp?=
 =?us-ascii?Q?PvzbgU2iOYSdKFj7Flr8uBhNmHk80Hhx9g1Hf18wCr2r/K6Fkf/fkvz/2DCw?=
 =?us-ascii?Q?i+qID+5C01leaScGvz4H0v0iHI6ayoSfL72GdNncbZKOkQS1jPgCzg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3437.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?G5DvOK0cof1srp9wbkLWPuBFQxQgmVjQ/HRXMr2VF6FGH9SxzZxJDHqpgQKj?=
 =?us-ascii?Q?1cFlbvvWNWJBdoo9S1GQdNx7IWtUiTi7pY8o8yCI8PfYahDwJ08T4IpMIcKj?=
 =?us-ascii?Q?Su097FmKuAeXs+11LfODFVIP2Xx94j2/s1a+Srq7BYPHYAOlmGoT5fCeD5+s?=
 =?us-ascii?Q?kw7J2Y7gdZKdPjbsIWFn6/B2Tv11n7slxRSRywHhPUCKhmW9hqlgKCkOG6La?=
 =?us-ascii?Q?5aSvw/71rwwQfHf41B3fJI8MSnh+U4KySPOM50CZv8nHmfQ+v9ctWm7e1PKa?=
 =?us-ascii?Q?vKrM7cIJLqByaHpfniKI7Acx5DJpaoxr8WGb1iQjmBy35R3vWFUe2NaT23wX?=
 =?us-ascii?Q?B+9CkET7hQ+DmdXM54izbGftCRsYqEkG6+fUGg6AbmtGMlW/KOSiV80+0+uq?=
 =?us-ascii?Q?jRf6+rCIxg4dcoVBEwF+EunxOLcvWKwdAJdi+OkC3VpeApK8hSzey57dYbSB?=
 =?us-ascii?Q?pQZnQkx1tl5sYfC3830WWih10lMSO9u7friGU4SOE1SbfMvR0aKZOUXqnA9u?=
 =?us-ascii?Q?5KKCXym0HOsrCPpYBCkzivpsv89naPDlrBsBT8ZFxRSFAdS07/hGQFm5KgKP?=
 =?us-ascii?Q?vCboCpzAun4nnWGPXA+S2s5Qsxrm94GwCQCFPlvqh/O1jeoIAeZW7z4mOd6/?=
 =?us-ascii?Q?i86g2ZLfIUbnmUePuFYGpZ7GCED/q8SpdW9cZ2DXd/vjxB4PcUVsURZDmkQx?=
 =?us-ascii?Q?cDbBvfp9IBoxSgGUx0n66YGfx/NowcdgS0JlEqFtNi+Wubzg6xgEsjMSpGvf?=
 =?us-ascii?Q?/xOSfFQ+yUXH9oU+LwXPTxH9Ja5EAZnY06Lh0yQwS84LBQsfZ4uc1QLi6W0G?=
 =?us-ascii?Q?5LQ/CG/IOLnkhnljOo9OMhAYlrQRStuwA3eg185aY238cHTBbwt9KNSK2JYn?=
 =?us-ascii?Q?PdepCI357hn0Y0kRclCvbMockKxrQr+fl/v6zquHODx9wlrnXuyd0V7pm/VD?=
 =?us-ascii?Q?a2VghncFpErPpZHV6eFGbUsB5HENbeatq8PoaxgyzUkCLy3TvwQ/lT3QkWy/?=
 =?us-ascii?Q?PRefvaPiCXXUVZykomONAJ5Y1Jl4xmO4S/HbPeyiudb97H9ZAFqOopmQlHcG?=
 =?us-ascii?Q?b1cHmS50q7x6ofgdh9gym9xm8kOCTIxExsHfcG+Iipq8/4ixrjDR9menZlWQ?=
 =?us-ascii?Q?zRcyAucAV6Cy3QM9n9oovwRJY6+NmisA2JBss4PMMSfmj2DGegiiRb6EJHxn?=
 =?us-ascii?Q?2TyN4mXaUbcwQ4HjNxzPLpCCmbbMGjWzxcKlKKftM5kvUXLPTaL0IGO1jLwJ?=
 =?us-ascii?Q?3e1vP69nIjHgIAlqvGNLY8srWVySy9BnhW2HjWA2n0PVS9/leILedaKh66sH?=
 =?us-ascii?Q?CbQQpitif/rN/r/kQKgF7ZACzk3YbuyCsMDgErlD9AlCNHzZVDELHBfYEFVN?=
 =?us-ascii?Q?ovyr1ATcTeX+4TuAouNCuNbcICgHejeyRH95rSTuDcm69lM4pP186sO0SHGa?=
 =?us-ascii?Q?gjM5+WhWET7HbguoFNPy2halk794vA+HPL1MCXabXx72dCcLNTxZgzwx0wdI?=
 =?us-ascii?Q?QO8FtRMC60mbvwQwldQ+DoLN5yh9q1Rfij8s61FWK+588pOWIAnhZYWOlaag?=
 =?us-ascii?Q?ypXM4719BfC8Sa/SZCfe/w/QrQdbe+BaO8OX/wKy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 36caf2cb-3f55-4aba-4fe0-08dd9165b187
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 15:00:11.2338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rP5LzazGxLR9gCagTJfRbfur/ToJTSKmnCOmmYKTCb4Ein+ycXSEBC/eMz7YKtcdtAKWrVyq7qxWQOS4aa/Vig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3558



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Monday, May 12, 2025 10:16 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; Dexuan Cui
> <decui@microsoft.com>; stephen@networkplumber.org; KY Srinivasan
> <kys@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>;
> olaf@aepfle.de; vkuznets@redhat.com; davem@davemloft.net;
> wei.liu@kernel.org; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; leon@kernel.org; Long Li <longli@microsoft.com>;
> ssengar@linux.microsoft.com; linux-rdma@vger.kernel.org;
> daniel@iogearbox.net; john.fastabend@gmail.com; bpf@vger.kernel.org;
> ast@kernel.org; hawk@kernel.org; tglx@linutronix.de;
> shradhagupta@linux.microsoft.com; andrew+netdev@lunn.ch; linux-
> kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH net-next,v2] net: mana: Add handler for
> hardware servicing events
>=20
> On Fri, May 09, 2025 at 04:16:43PM -0700, Haiyang Zhang wrote:
> > To collaborate with hardware servicing events, upon receiving the
> special
> > EQE notification from the HW channel, remove the devices on this bus.
> > Then, after a waiting period based on the device specs, rescan the
> parent
> > bus to recover the devices.
> >
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> > v2:
> > Added dev_dbg for service type as suggested by Shradha Gupta.
> > Added driver cap bit.
> >
> > ---
> >  .../net/ethernet/microsoft/mana/gdma_main.c   | 63 +++++++++++++++++++
> >  include/net/mana/gdma.h                       | 11 +++-
> >  2 files changed, 72 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
>=20
> ...
>=20
> > +static void mana_serv_func(struct work_struct *w)
> > +{
> > +	struct mana_serv_work *mns_wk =3D container_of(w, struct
> mana_serv_work, serv_work);
> > +	struct pci_dev *pdev =3D mns_wk->pdev;
> > +	struct pci_bus *bus, *parent;
>=20
> Please avoid lines wider than 80 columns in Networking code.  In this cas=
e
> I would suggest separating the declaration and initialisation of mns_wk
> and
> pdev.  Something like this (completely untested!):
>=20
> 	struct mana_serv_work *mns_wk;
> 	struct pci_bus *bus, *parent;
> 	struct pci_dev *pdev;
>=20
> 	mns_wk =3D container_of(w, struct mana_serv_work, serv_work);
> 	pdev =3D mns_wk->pdev;
Will update.

>=20
>=20
> ...
>=20
> > @@ -400,6 +441,28 @@ static void mana_gd_process_eqe(struct gdma_queue
> *eq)
> >  		eq->eq.callback(eq->eq.context, eq, &event);
> >  		break;
> >
> > +	case GDMA_EQE_HWC_FPGA_RECONFIG:
> > +	case GDMA_EQE_HWC_SOCMANA_CRASH:
> > +		dev_dbg(gc->dev, "Recv MANA service type:%d\n", type);
> > +
> > +		if (gc->in_service) {
> > +			dev_info(gc->dev, "Already in service\n");
> > +			break;
> > +		}
> > +
> > +		mns_wk =3D kzalloc(sizeof(*mns_wk), GFP_ATOMIC);
> > +		if (!mns_wk) {
> > +			dev_err(gc->dev, "Fail to alloc mana_serv_work\n");
>=20
> The memory allocator will log a message on error.
> So please don't also do so here.

Will remove this.

Thanks,
- Haiyang

