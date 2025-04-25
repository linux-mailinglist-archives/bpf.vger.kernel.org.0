Return-Path: <bpf+bounces-56667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E276FA9BF35
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 09:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66D7164E2A
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 07:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C60722F17A;
	Fri, 25 Apr 2025 07:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="T7GQHOIi"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B3320C46A;
	Fri, 25 Apr 2025 07:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564920; cv=fail; b=RqCLUfN5II8DfhonaZjEPBOxUWfmjDLnXDnHTZ/IrVIGhHRFz/1Z4+fOCfa0NLuBpH7jPH6bP4IWiIdQnrT3aLmeeKMdrPy45iOtcZPU0Und6TrVtvpUsv2zMCR28cZwGGCDsg4TlvgdFNCi+ZBmiDPSabj/zP2Bis+ZEUIHoA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564920; c=relaxed/simple;
	bh=qsUJYXqAFPHfUesTWltNwVm1jC0U3OOVdgGfyOONtO8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xku4bRIMdOKyhm9ImRP3Cvtm27JPe6OTX759uWGxHZ+KRuAy3/xrIztz6DX/Ks2TzJ503SqljZOmHeFag1vWEqaP7RJUN4RQtdNFH6Q4+sEyepihj/e7SPjeN3zMRmGH3rj3/dUgfperBSLvTFR1xhBDlA5e0c/xi02U25nHAeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=T7GQHOIi; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrvZZQtTCb4FepagptORDn/3XGIZO0gWH2ZattXoYyjZyXCM4s8yF0z+qLuWCq+zZA9i8ZfJj0xkIywiREX8f/xbYMO0uMKEyJc6LSDfnL+PwPMmdOKr+mkQWvqKWy0+PzY9Q/8WM5MxxSl5RvELcpZP8Cntb/Wx11S35kqKUXQh9ycE558UcJT4Y6CilmoqQunEbV7s3n687o4CjAiZivY+mj2L6Y710sEWHkflKf8iC455C8WJgKjq+v1bFnbihQ4Wx2s/teFZaYnpDhwNRxuN02tBPyEaBcFHNj+PYuwBbsUqrMpKQCiMkojLpbF5ekDu/gocc1TwQMMyCQY8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsUJYXqAFPHfUesTWltNwVm1jC0U3OOVdgGfyOONtO8=;
 b=KGj65LeaRPNv+QM8ZxlbZWjCKw3Owa4p7CjLHvYu9CQy3RyiR9LCzk4F3VzWOyQrVA2ACesc2tFgpY74mCoPxEqrlGezGfCQyiXVK4desE81Ur28nus6QWHYvACD8szeRWPlW2uZsEMAP+CdJEsS+L9wWUcZId5hE3yX4sELT3kKJhgaRe3n2KJ7EYMl8sczpInVLzmgQnq0OOE2OEHxYBPIbXkAMI9uUbLeYl9zzDcnXXB/BzOd4dS3lEk/iGYRodY5s4sKzaJQ5MwqVkdjecFgpP6Dhn84O7C7Ry4TO1sZeTC/IrOfD6NKeRP6bK1wQXYzwLiyOffVmX59YS6lxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsUJYXqAFPHfUesTWltNwVm1jC0U3OOVdgGfyOONtO8=;
 b=T7GQHOIiF8csDq/EJm1ieeluHBJ/ANsOc69iS+x+h6XgoCjv5r3uqoSxl0a8hboQ6k6T78ShzWwtqwCFNY3WuACNNbsbY6l8qj+2Nsc3XAcXN9G/Yj3nVGIxKl4ylINlntkbYY7UhZGbvGug5oBDEqTc5R0CDhIMQk8QCU3d18MZMr3ncvP2JmyqNCqgOg0eEOHMQ+gVxQwGWvUG5+N5Tjyz05DYuWiXFmEy/Joer1LnI+br89FqpnW5lX3qf4mIM+ZffrCqHESPs45u+k40EK4pgUO1FJCDJfJ5zIW9ehBOrTrCLS99tVahcJXh8zz4HAugN/zRGLZD5UvP1pvgaw==
Received: from BN8PR03MB5073.namprd03.prod.outlook.com (2603:10b6:408:dc::21)
 by BN9PR03MB6011.namprd03.prod.outlook.com (2603:10b6:408:134::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 07:08:36 +0000
Received: from BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a]) by BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a%3]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 07:08:36 +0000
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
To: Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Furong Xu <0x1207@gmail.com>, "Gerlach, Matthew"
	<matthew.gerlach@altera.com>, "Ang, Tien Sung" <tien.sung.ang@altera.com>,
	"Tham, Mun Yew" <mun.yew.tham@altera.com>, "G Thomas, Rohan"
	<rohan.g.thomas@altera.com>
Subject: RE: [PATCH net-next v4 1/2] net: stmmac: Refactor VLAN implementation
Thread-Topic: [PATCH net-next v4 1/2] net: stmmac: Refactor VLAN
 implementation
Thread-Index: AQHbstqfHgt1ZgfId0y44506iJ/Lf7OyvDwAgAE9WMA=
Date: Fri, 25 Apr 2025 07:08:36 +0000
Message-ID:
 <BN8PR03MB5073A348B4FFD53E11604E74B4842@BN8PR03MB5073.namprd03.prod.outlook.com>
References: <20250421162930.10237-1-boon.khai.ng@altera.com>
 <20250421162930.10237-2-boon.khai.ng@altera.com>
 <43ef6713-9ae1-468c-bc43-2c7e463e04f4@redhat.com>
In-Reply-To: <43ef6713-9ae1-468c-bc43-2c7e463e04f4@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR03MB5073:EE_|BN9PR03MB6011:EE_
x-ms-office365-filtering-correlation-id: 82ad8b25-4a45-4635-9271-08dd83c7ff6f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aTJEUDY3VEdSTVVUSjJ4bjRiLzd3SFR5YUMzYlpFRUI3ZHBoU3REZStsMGRa?=
 =?utf-8?B?cHZyRHVEdEhpNjUxNEhaWElGMzJESjJhNzFyZ0k0aFhmbnR1OGI4V0dzVVYr?=
 =?utf-8?B?RzhQQVlRR3hjclZFYkZWdUNyT2RzYTFpOXBuY2lPSFdrblpSZ3VIUzY5S0RY?=
 =?utf-8?B?TnNmbnNVRWdXUW83a2d2eXJmcmxuZnlNdUVqZjA3Vk1JOU9aOXpFUXJ3RGxm?=
 =?utf-8?B?MjkweHNtcjVlQzd5WEZaNFV4b09jTE5SQ09qMVJCeEVreWkzSXEzUjVvWlBx?=
 =?utf-8?B?bExLNzlTZllUUmR0bmFJZ2c0dGprSlYzMzZHbWZrZERuK2VIUDBTM3ZTVHlC?=
 =?utf-8?B?N3pRNjJBUWJnTmZjQVZyZlpabDRKMm1VSW5wZVJ4eUlvbzd6b2l2b3lVdWhV?=
 =?utf-8?B?Q0lqNnlTUU1KVnlMMEJDVFBzT3p1WnZaby9kSjFudTNXaFN3YjVZWXZpYTBp?=
 =?utf-8?B?NXE3dzJOd1NhRTBvdEhsMlRabUZvVmc3THNvSkxmNURnQjU3azcxZFp6U3Zm?=
 =?utf-8?B?QkE3aFRtcWtQdU1pWFpGeEx6dFpIc050ZXY2VVZnUXVxSzAvVEU0bGNYa0cx?=
 =?utf-8?B?bDZZN2Y1a1g2REltSzA1azI4NW5US2NtbjBna3JsM0NSL1Z0NGJGYXpIWklV?=
 =?utf-8?B?UnB2bnpaM2I4Y05xK3h5Vllha1A5MHNiOG1rakpINm5uRG9mQlE2N0tUMTVF?=
 =?utf-8?B?N1hDNHVJRGFEWStqU2pUTHpybGNuL3FYQXh6VkNYY2pTL2RsYUxpbFEwYkhN?=
 =?utf-8?B?UEZXY25GZWhRem90T2JkdlJoanorVDhRMnBqcUFlamQ3eWxyenNXN2VWYVpB?=
 =?utf-8?B?RUY2VmdXamZmVGNEbHhtb2QvWVAzZFdsaUh5aGp6QlJSc1g5cDBZbUVMeTlO?=
 =?utf-8?B?dm1lRjBPUEVVK1kwT2JDSm5MSmdEV0JIUE4wWWZYRUM5WlhMNnZtQy8vNVc2?=
 =?utf-8?B?b3VJdnBtY2x2eU1CYjEweHhMOGhmTWN3QmViMGYwMlJGckhxdTlPUFMyUHI4?=
 =?utf-8?B?RTN0RjlJSVdsOE1lc0NsVzFHTitEN1RVeDJqMjdJN0k0ZE9hdkdpRmpZM3VG?=
 =?utf-8?B?Kzk3N0tZdVkrL0V6eXVnT1NoditUMnY0NU5hRGloS1R2Q3FlWExFNFhWN2pX?=
 =?utf-8?B?QVlwT2NyUkt6Yk9OMHAyTDdjWnVnTVZoMTB3TWVOOXA5RnNkZ2dmbTZlVUh1?=
 =?utf-8?B?cEVuNncrQ0I1QXI4YVZYNStQTzlMN25OTEVBWkw3QTVoQTBXM3pHZWFzL25j?=
 =?utf-8?B?SUN6U2Y3aGlRdWc1dHFpMG92bEVuSldic1pMbWs3eUVnSm9PaGMyL2hQYUly?=
 =?utf-8?B?MWNJODB6Q1pJODNFK1BJUkR5SnVGYlIwTnhXYlhKM1JHTkFPMDFOTHRMTW8r?=
 =?utf-8?B?N0grYlR6aEI0NkNqclJBemlrTVZoTGZONXlZZUlTOEZGUjZweE1DNVQxMUor?=
 =?utf-8?B?NUc1bHBsdXl2QzFnVFJ1RzFxRGZlc0lKL1dITmx6Z2tuR3BEWmthTUVESTUz?=
 =?utf-8?B?WTRZcE14aUVmamRJSUlWUklJcGRiUVZackcrZzdNNU50TmVoTXlQNjhIVlg5?=
 =?utf-8?B?MHJFZlh6VWYxNFk4cDlHYWJDdm9ZVVFUZVBiclVkaWgrcFRKOVZ0R0tvcm8v?=
 =?utf-8?B?b1pKcHdVTnRDcjJVVlQ4REpDYnFtRDQzTXVDV3h6Q3RpRTdIZkV5V0t3aEJB?=
 =?utf-8?B?T1B3LzRnNVhEREhIZkRlVCt4cDdEdk92SXhILzZHNVlzYlFkVitHVlR1MmpT?=
 =?utf-8?B?cW5tUXFMSXR5MzBMdS9aL3hNeGs2Q1Y4WVdmY0xFdllIdHc2ZW8wS3VobjJM?=
 =?utf-8?B?UUtMa2djQzFuSTdUWnFMMVpUYUZUdUpBUDhYT3owdFFKM0gwR2tnUGVya3Zn?=
 =?utf-8?B?L0xERldqK1I5QlBmaGJyR2gzNzBzdEVjeVdxNHZVdkZaV0VjK1Q0MUpjdHBF?=
 =?utf-8?B?Q1N4ZGUzOU9Ma2YyWVdKOFFOTnB3MlRFeDVtTnlMcDB1bUZaZUlOd0oxUlR6?=
 =?utf-8?B?ai9CcjRnM0lnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB5073.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDVVNGpMY0Z1aEhsUmRQZFdnOGFJZEpOakJGUGtMSExHNVZQLzVjdjBDbFFQ?=
 =?utf-8?B?UGNYY0Ftc3pFdWppZXpIWWdNdWpDQmZJRVRKc0hGL0Q4enN6SThSajlqYkJO?=
 =?utf-8?B?bUZpSXRNQ21jb0EzeEx5cytqUHh3d0ZSeDlac25oSkpZeEhOWWZMSzgweFdG?=
 =?utf-8?B?V3JyTVZlOU8rV0Fzd2k3MEhPVXVGaVc4WXNyTWlKak9KQStJWTl5aWhaelI0?=
 =?utf-8?B?Sk5MOTlRcTMzTFkxV1AxUzlZWERWenY2R1RLdUd3MzRXTGlzNGFockpUeDht?=
 =?utf-8?B?WWY3Q2pEOFFLRVByUnhzQndySmNlYTY2S1daVCtlSUJkRTVxaGVIMjZuWElw?=
 =?utf-8?B?R0N3VVFnV0hnYVZRc2JGdXFqdml6M2NpMlVoVnBPNEpYVXUrMVAxdHBxb0lY?=
 =?utf-8?B?a3RTWHQ0TXh3NE1jQlNjc0NZUWFuMWdVanp3R0EvaVYxYTR6VXVZTUhrbmV3?=
 =?utf-8?B?S1VpbndmZk1VYzVmS1I1ZzRNOUcwd000dlVWMms3ckdTbVFaZUl2MTRHTW5m?=
 =?utf-8?B?VFlucEhUMmlPL2pGMUZMOEo4YnhkbG56MkV3Z1VLWFlWVW1uWG03emVVaTRP?=
 =?utf-8?B?elBVZmI4Y3o3ekRQVjM0eGkrZXJDWXZ2SnNlQTNnYTFjUHdTb2FmSXhZaFZJ?=
 =?utf-8?B?M3dKUXc0RGdDZDFBN3pLNlkvOFltOS8vRFdZUmFycEw0dURRWjkweGZlaUtl?=
 =?utf-8?B?ZHNXTWtsenY4eUEycm0xU09QTmZ1QUtCTkFXMitFeTdsNElaOExzcnlNTDU3?=
 =?utf-8?B?S2xUWjVHVFZweVUrNXNXa2EvNkZ1MGMzVjZjSW04Zmp2WkNNd2VTaDVPV1Vy?=
 =?utf-8?B?RmFGcXRObm9GUGhMMUJSSGRwV1FnajM4WXozS3BLNzdGNS9TYTNtZ1VERkNa?=
 =?utf-8?B?UlJTYXB0YUNvTjYvTTMzTlE1T1Q5SitDamJ5eklRejEvNkFiU3V3OWozSFNy?=
 =?utf-8?B?OENJam1iY2Z4THpRTG95ZE92aDRlNm1naUN4TnJlT1UvYjl2a1h1ejlYamZ3?=
 =?utf-8?B?UHR3VDI2aVpyd1NtTVozRDBuWmpyL3B1dXdXY2tWUDdEMW5mNVZCMEZ3NG04?=
 =?utf-8?B?TUNjYm5lZEs1MTkrS00rQjlnUjJZQTRLVmJUcTQxMk9NT1ozS213ZFZJQ0FP?=
 =?utf-8?B?d2pqbEhpaGtROVFRbU91a3ZSN2NjYmVzdnJ4MTZSREZSRDRPaHgxMUwxWktD?=
 =?utf-8?B?UmJKNlIzVHdaN1lPMVdMZnBML0MvS2NmNnBqRzd3S0RPZWJBVHBmdEJIUUx6?=
 =?utf-8?B?aDlmQlRlVEtKZG5PbGtLYStkQ0RLclhNZFhvUVd3eTVOMEpOK2s3VHFMM3dE?=
 =?utf-8?B?cXVwNFlYTVF0TXZTRjVTVTNoczV3UXV5Zk1LS2JnejBjcDRaRXluWEI0TE9M?=
 =?utf-8?B?Q3BqVTNDK3VheEptZ0h6ZXRMSW5qTTNIcFhrb2oxNkVnMmlTcUVKVHRDUDdQ?=
 =?utf-8?B?a2ZOY2hMdW9vMzRlRVhVM3Vpc05pN0hwSktEbk5HbThNUUJoZllZdUI5WllE?=
 =?utf-8?B?TXNpMk52aG44eERwZElRS0M1ZmZlMjNGcVlPb2FtVXJjcE5wQUtVblo4bmJ2?=
 =?utf-8?B?eFdQKzRlLzIxaldEbWxZWStjODNsTjdsZjhaZlZwaEp0Y2Z3S2x1bGxHV2d0?=
 =?utf-8?B?UllMRzhjbHFGUGxmOTdqL0N6Tnc2Y1dZSExUb05JcVhRRFhtM1A0cmNCZkRF?=
 =?utf-8?B?SVFIbEk4Uk9YOHJ5S2l5azZnRTlER1hDM3JrNVZZMmh6TzhhbXJLVGFkV0pB?=
 =?utf-8?B?bjVyajdNYlVhRnJGUVJNL1NrWG5yNExWYkJOYkcydEVGSDBxN2ZsRlZWRFE3?=
 =?utf-8?B?WkRjYld0M1JhdDlNZ25IZFhTUFQyU3hiTHlpb2VCeE05UVBHS2FYcXlCdExv?=
 =?utf-8?B?OGxNaVNPU0ttL1F1ZmFmSFM4dFlRSi9KK003amZPZ290NVhLTjEwTWlVTEwv?=
 =?utf-8?B?NEhnZ01ORldWdjg3MW05VlFZVXdIY25saXhGRDZvTXlndjRjMVlwLzJGQjRl?=
 =?utf-8?B?NUU3cjB4b0pzdzM4RUlMVnpHdjlLUWNWcmd5ZER6d3NpOENxSW94T1czVWt4?=
 =?utf-8?B?MWJabkwzTVRRYmt3eWo0VkpzbTNmWDMzUVY4enlCWkY5a0hWc1Rqb1c2UWRk?=
 =?utf-8?B?ZXJRd2Z5ZzdvNVVmaDVEdkFTTWl2eUlRVkd2QkRaQ2huN0RYZGtDM2RKYzBJ?=
 =?utf-8?Q?LM8kSbtBQCBktEWO8SmgXwWByAbjzct1sYa1tiUxXjU0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB5073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ad8b25-4a45-4635-9271-08dd83c7ff6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 07:08:36.3163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yjGBTuQ2m5AnRWCot0NofGDPayMeB4ZJTTwevmhfgPw1YRuQh13uzjTv6NHDf/49AxT8mnnPcGAsPfaPkC6W1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6011

PiANCj4gVGhpcyBwYXRjaCBkb2VzIElNSE8gdG9vIG1hbnkgdGhpbmdzIHRvZ2V0aGVyLCBhbmQg
c2hvdWxkIGJlIHNwbGl0IGluIHNldmVyYWwNCj4gb25lcywgaS5lLjoNCj4gLSBqdXN0IG1vdmlu
ZyB0aGUgY29kZSBpbiBhIHNlcGFyYXRlIGZpbGUNCj4gLSByZW5hbWUgZnVuY3Rpb25zIGFuZCBz
aW1ib2xzLg0KPiAtIG90aGVyIHJhbmRvbSBjaGFuZ2VzLi4uDQo+IA0KDQpIaSBQYW9sbywNCg0K
VGhhbmtzIGZvciB0aGUgY29tbWVudCwgDQpzdXJlLCB3aWxsIGRpdmlkZSB0aGlzIHJld29yayBp
bnRvIHR3byBwYXRjaGVzIHdpdGgNCjEpIGp1c3QgbW92aW5nIHRoZSBjb2RlIGluIGEgc2VwYXJh
dGUgZmlsZQ0KMikgcmVuYW1lIGZ1bmN0aW9ucyBhbmQgc3ltYm9scw0KDQotIHdpbGwgbm90IGlu
Y2x1ZGUgcmFuZG9tIGNoYW5nZXMsIHdpbGwgZXhwbGFpbiBvbiB0aGF0IGJlbG93Lg0KDQo+ID4g
Kw0KPiA+ICsgICAgIG5ldGRldl9lcnIoZGV2LCAiVGltZW91dCBhY2Nlc3NpbmcgTUFDX1ZMQU5f
VGFnX0ZpbHRlclxuIik7DQo+ID4gKw0KPiA+ICsgICAgIHJldHVybiAtRUJVU1k7DQo+IA0KPiAu
Li4gbGlrZSB0aGUgYWJvdmUgb24gKHdoaWNoIGxvb2tzIHVubmVjZXNzYXJ5PyE/KQ0KPiANCg0K
VGhlc2UgY2hhbmdlcyB3ZXJlIG5vdCBpbnRlbmRlZC4gTGFzdCB5ZWFyIHdoZW4gSSB3YXMgcG9y
dGluZw0KZnJvbSBkd21hYzQgdG8gc3RtbWFjX3ZsYW4uYywgSSB3YXMgdW5hd2FyZSBvZiBuZXcg
Y2hhbmdlcyBpbiB0aGUgDQpWTEFOIGZ1bmN0aW9uLiBJIHJlbGllZCB0b28gaGVhdmlseSBvbiBH
aXQgdG8gYWxlcnQgbWUgdG8gY29uZmxpY3RpbmcNCkNoYW5nZXMgb24gdGhlIHVwZGF0ZWQgZnVu
Y3Rpb24uIExpdHRsZSBkaWQgSSBrbm93IHRoYXQgd2hlbiANCkkgcmVtb3ZlZCBjb2RlIGZyb20g
ZHdtYWM0LCBJIHdpbGwgY3Jvc3MtY2hlY2sgdGhlIGxhdGVzdCBjaGFuZ2VzDQphbmQgc3VibWl0
IHRoZW0gYWdhaW4gaW4gdjUsIHRvZ2V0aGVyIHdpdGggdGhlIHNlcGFyYXRlZCBjb21taXQuDQoN
ClJlZ2FyZHMsDQpCb29uIEtoYWkuDQo=

