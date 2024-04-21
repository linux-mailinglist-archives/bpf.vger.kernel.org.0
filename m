Return-Path: <bpf+bounces-27346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD4F8AC1F1
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 00:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96091C20A02
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 22:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D02A46439;
	Sun, 21 Apr 2024 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Fmq6jO7r"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2107.outbound.protection.outlook.com [40.107.100.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32A52D600;
	Sun, 21 Apr 2024 22:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738783; cv=fail; b=I3rMTDbl3hIuFKH9WfK3iSZuFSlU+soGInhRX2x3X8ua+QGuzAxDRXtydtEkn4JA7XKHY0oec6EkWiu87Cuaz/kLu17YiQRXQoNMMhLplN1d6n5tbXszRtLUPsJ5QnBnzemCtWR0MHlRZFugqq33GLC+MudGyfwNbq53P9ZW/lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738783; c=relaxed/simple;
	bh=0SEfy2l/N5hQxqNCWQnn5WkR1CgMW0jjlLuiaO294s0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fxkhBjUA46hCmVxhiCXDZsvAuwJMEKoB+5G5fiqJOZdboWYK6pqm3haC1sfvvbqb12ZqyF4+BUIhm8emb4yieQGXvmA8Mi6NPAPLq3MHRB9XegoZ80X1IjUnCt7AV2/C2f7zPU7jMRRHjSGhehfpiL3u75cGI+yC6TOuIZ1DDtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Fmq6jO7r; arc=fail smtp.client-ip=40.107.100.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEPHeQxsCA6Aq4nX4oi7+jdOelPCTLJzxZRr16EZnYu/ClOlIV88Q0qipPDHrIEvJbIuXR5VSvm0oWjcuyVo8YX/dWFT84ejht1+X8zRZpAAbLfjlhi1sIDt7VgRSz/fZog2i7e1xpuuyCWYiE87W9TR1AKboqRSZKDNtHwfJHfG8gQxSTX8GhzOj/S5jurjVHaHPqNifpQOwWoAegxN95gBlYssi3oM3P8TNvgqyJ2OsAdBxSYs5IGUxTaOYvQh0AejRrUuAdf38ZIA3hpWC989zNT/HTOSlE6aGAS7Bc1AeTcLiSW5+A86gZE3Rkj9o34oyNnXhL9jb67XXmC3jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SEfy2l/N5hQxqNCWQnn5WkR1CgMW0jjlLuiaO294s0=;
 b=iUMXLwMSL8x5dxd+nsNR7lOhSrCoBuVkbOQO9hATQHn13Q15uL8Q4jR+G3R56cyKX2ezZnkMrdMJ4eY78aJT94j0bqJtHuOyylnZcuIuE4ZVlBKdEYpLk/feM0jSV0G3UVYBGcfipMDjXvSyTTF9i+YEJxT6pntUqvpdd7AAF+y/ljlKJ74Yr12xTIUuF37TeEMn85xS6yMIJ9cSGC/8e8kuCAoadtLoBSYop/luFyn1djaOs51sNmtvfO/sRq1+OtiiRXOoniS9VHxh95HFuDiDzr56e2pyJJxe8KnhbXwyhPyrXbDqeFlFzcw2TyAoJev6ISmdj9LHjhDvYZkK4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SEfy2l/N5hQxqNCWQnn5WkR1CgMW0jjlLuiaO294s0=;
 b=Fmq6jO7roaib7nwcBvg6zHPn6sVjcjF7wrfasEDqPUfFIIm+w/D2TYzXVg9yaBiIR33bOWKEoqMffNlIUPtX5pwwLwbDPaFaYPQ4G//7d6D6xOGf4JyO6d2i96JSSHbz/xicC8zZGYSDybANIhrIj4sSCkyrLuvn37GKVMf/5Gs=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BLAPR13MB4722.namprd13.prod.outlook.com (2603:10b6:208:333::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Sun, 21 Apr
 2024 22:32:57 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057%6]) with mapi id 15.20.7472.044; Sun, 21 Apr 2024
 22:32:57 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "usiegl00@gmail.com" <usiegl00@gmail.com>, "neilb@suse.de"
	<neilb@suse.de>, "davem@davemloft.net" <davem@davemloft.net>,
	"Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>, "jlayton@kernel.org"
	<jlayton@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "anna@kernel.org"
	<anna@kernel.org>, "tom@talpey.com" <tom@talpey.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kolga@netapp.com"
	<kolga@netapp.com>
Subject: Re: [PATCH] xprtsock: Fix a loop in xs_tcp_setup_socket()
Thread-Topic: [PATCH] xprtsock: Fix a loop in xs_tcp_setup_socket()
Thread-Index: AQHakxBA6fb+xS1Pe0KsP+Babmad47FzUZUA
Date: Sun, 21 Apr 2024 22:32:57 +0000
Message-ID: <a1739c36a59617ebd01a7d3fe8f5a9f8ada771e5.camel@hammerspace.com>
References: <20240420104801.94701-1-usiegl00@gmail.com>
In-Reply-To: <20240420104801.94701-1-usiegl00@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BLAPR13MB4722:EE_
x-ms-office365-filtering-correlation-id: 070354c8-8ac3-4867-ac42-08dc6252fe99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?TVJ4MDBjZmc4MVdjZnZpbUNTaXBHM2k2eHZHWGZ0U0FHOHg5Y0NwZnlRZ2oz?=
 =?utf-8?B?OExQNGFZZmFSN2tKSEgzMzVLSmRjdnJ6aVhlRVpCeDF6UUV0TkZDNzBSNUk4?=
 =?utf-8?B?R3FpYStLUXdTMzBNSW40TXRrU1Z0QlcrdnJsWEhLL3d6Ly9JTUdOUHZqZ01l?=
 =?utf-8?B?OUY2SERtVDhERG9iNVB2ZURsRXBtNUgveHV1cjdkVXZnOGJtcmNuZ1NHd0lm?=
 =?utf-8?B?RG9IWDV6aC9ZS0lvaXprUlhuVFlja1R3NmhZa05EVXoxanViTnJxTExLaC9T?=
 =?utf-8?B?NnFVOVlhMDBNbi9mZzg3Q3hvcS9ubzR0eVB3dW81Tlh0S2haVisrS3ZuVUg1?=
 =?utf-8?B?ekdIQlhuUHM0aGZ0aFhGd01HcGN1RlNLUHJpUHo2d3lxcVJPQzU0WGwrQjc0?=
 =?utf-8?B?UmhvZER2ejEzNnBiVS9NQ3QyR3pYTUZwSUt1Nk9uN1BJQVh3b2wrOTNzeEND?=
 =?utf-8?B?blNzbnRkWEJpeTlTV1d1dWRuVG0rM3dWTTVVay9vai9xZ1JyNEpaYk01VlpQ?=
 =?utf-8?B?VzRPZlRaaUwvdjVPQ3JyejY1ZmZQQWVTTEp0d25kcUcycy9jbElXNFpHSTcx?=
 =?utf-8?B?dmFQcGRtcStLSFNBOE5IT01xaUUzZnlBakhYQ09QR1g4elJRbERiZEhMRCs5?=
 =?utf-8?B?WHFpUnluaDlTWTg1TFZFcDhIbkJNZmJnTmw5NExudFNDZ3JTK0NPODgvYmxm?=
 =?utf-8?B?bXVsS0ZBOGd3azJ5Y0M2VmZkbENtYkpTbXNaSGFqZVdSOUovREZWUTdNTWgx?=
 =?utf-8?B?ZnRkQi9zcG90Slhra3hqWGZYQWFpSlVJMEdUQU1LbjJRV1NhTUlsVnRLek90?=
 =?utf-8?B?RlQ2amxnQXN6T29GRGVXNysxZXlkMEEwVXZsUjBDSTIxOVBhb25MUWpTcS9Y?=
 =?utf-8?B?aWt4bDBkcjlDbXhxL2sxVDgvbkd4ZFB3WWwrM1FlZm1tSVFhaFArMzU4dGVP?=
 =?utf-8?B?WCtNVTZlNlR2V0pvby85cEE0UndTYjZFaWxyNjZydENPT25SSmZwTmdBWW10?=
 =?utf-8?B?U3JzZ3JjaTJMT0pXMm9tMEl3ZnpXeitvWEFpRTVnTko0L2wzOTJQN25SWktl?=
 =?utf-8?B?ZjlMWW5sZmhBWGJ3d0JGSEZBdXgrUDVOblVtN2tqWnQvRGY2VmJ2WVg5Q2wz?=
 =?utf-8?B?ckZiaGJLQzI0cWFQZGhiemRMUW02RWZJREtWOVhoVzl1VDN6TXpjb0ZCSXAz?=
 =?utf-8?B?eXEycFpRQWp6eFgrelUraGpra0loR1hSQnYvcXU5S3BjMk9KQUZKamhRT2Zq?=
 =?utf-8?B?N2lLcEV0Q3lYM01Wa3JxNmd1b09ZMVRWNGdDZlloK3owZWRzcGpYVVdVRjdD?=
 =?utf-8?B?RGUzbXhNSmFCMHNodWFOemZYbnNDU0FqRzBtWTByVE10cHE0RkxIS1pIa2NB?=
 =?utf-8?B?MUlhSTgvVG9BdUUzZW5VUnNCMGtnMlVUZ2pTZTdEdURNb0kyQWlEYzk5VGV4?=
 =?utf-8?B?OU9qWEdla1JxMG1WZWM5ajlFYVhsZmFiWDZCMFJwTThSemxrbW9ZMms5cVQ5?=
 =?utf-8?B?NUNMRzY1SFkrT3lSTFcyUkRTWW5NNnRlbHdaNmV5emE0QktUeElwOTNnS0Rj?=
 =?utf-8?B?eEZrd0JqNUh4OUN1YlAvUGxkOVlKNCtzcWN2aGVXdlphZWE2TTM3aW84bzBV?=
 =?utf-8?B?R1REbXdLRkxYbzh0MlZpN3d3Y0xOOU1OOTlGMmJHNk1NVnN2ZTZ5YVV2SlNL?=
 =?utf-8?B?UG1BUXBla0pMZGdqb2d3UmcyNEhySDJBMGtzR2h6R3lTb3kzcVpaazZUOVRK?=
 =?utf-8?B?c0UyWWFZVmJ1OS8zQU55SThab0xWWjJkY2VJa0IyTjFGeWJ4R3Bkc1ZWaTJl?=
 =?utf-8?Q?mV8illDnH20lIbUDx+fNY1zFCPoPEjfDPdqhs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bm95aERtVndPS2YxeW5UZXpxdnNRaEJQbnpJNEdaWkZsVEpEQVlaWXlWMjBE?=
 =?utf-8?B?dnAzY1BOdlorVG0yVTllZ1djM0lrV2MySXVnaGJ1b1NwaGo0T09QY3dnRHpk?=
 =?utf-8?B?bjMxQ25rdVVWMG45OHU2SDhaOUxpWVBrck05OWtvK0ZFdkVNU3dNcEpwZ1di?=
 =?utf-8?B?YWJCamtLOFEvY2szQndERDAxUTNUQ0pyYnhna2ZJZHZ2RTNWVWtCNTZmaUFl?=
 =?utf-8?B?VGlrSDB4VG53ZnFiZTQwSFhKSW4wTTFKNEFMcy9BbHZTVFJXT1VucnpNdlR1?=
 =?utf-8?B?WWlQZHJwcnRNTksxSzY0aUtkdTFMMHlzZ3dOTW5FR0NsQXZFVHIxOUt5VXQv?=
 =?utf-8?B?YXZ2Qk5lMXovZEwxeHhhRnNyak9OS2lGcHBTK0tvMW9YT3JFNGdtMUhZKzN0?=
 =?utf-8?B?Rk5vUC9HUHBneGdDZ0FQKzNHRDQwRGVMalNDZGh2QmdzejA5dzdlQlR4czY0?=
 =?utf-8?B?UER1RS9EMytad2F2R2E5cmlmTDlhZnJvNksvZFcwQVczMnpKRGcrVldrUkgz?=
 =?utf-8?B?T203dnRjS3pNbXpiZCtLeG5KMU9YWXVlOXFCNk1YMHNpUUEveHVNdjRxSjFN?=
 =?utf-8?B?bG1TWDF2bXRtS2drWmFaa0xmWkNVRG1nME0yWnRSUVFsTWdYd2dZQ1REcUZm?=
 =?utf-8?B?RHUvTTduWEhITmxCTkRERzZCcmlUT0dvSGs0Z1R2YS91OHQwUW5YWFp4Qy9s?=
 =?utf-8?B?dTR4eW1vOW9ETTV6WXJPSVE4b2lBUXJhVU5WZVM3ZnNlOHZ0ajlBT3A3TkVZ?=
 =?utf-8?B?Z3IzNmUwOUVkTUxBS2p6aWlRZzJpR1cwQ2UrcVduQ1prNENQR3BKOHdweFZ2?=
 =?utf-8?B?dERwTmp3RUhROWNoR1hkYVQxS1NlV0lLZ3poL3U3bldJVmRiZEFBVmdDa1Nx?=
 =?utf-8?B?MlQ0YkJpV0NCV1JxbFFyWmY2Z3lmUmUzQzVkYnBhR3NScHVTU0FNMXVickpz?=
 =?utf-8?B?MThVb3l2aFErWkFwN21ZV2xJRnIxQjhIdUwzZGZKY3NMUEc5eUxQQTQ4MHJC?=
 =?utf-8?B?OEk3Ti9IVE5na0VRV0JJbmo5TUVOcnBrUk1JWnluMXpYM0EvWUVZcnowUDc1?=
 =?utf-8?B?amhVVGNKTU1rQ1hZNDVrZlNHV2hTaWFuT0ZwRC94UC9mdWhmWlJPRnZobzY0?=
 =?utf-8?B?SEdETHE5OWg4WHptcWVaUjE2c2tocXVjb2tNS3dmS3NmWjdmQ2I5WmpZUFFU?=
 =?utf-8?B?WU1PNDIvMndsaDdIUjdPL3JxY09UMCs4c2srbDlSZ1JONGNDSmVjdzBIdUp3?=
 =?utf-8?B?YUNFZVYzaWIvNnpybHRvdEw5ZUdyUUUvSTk3QVJJZUxsbUI1U1Y2WmpKWElP?=
 =?utf-8?B?cWJrcG1uZGxwanNJVDZJRHJIM0xIanJoS2hWU3BoSHliZjBsL3dJZHFaQ2Vj?=
 =?utf-8?B?RU5UaWp1L1hNVWZaUjZMUUt0ZzBIc25uWk00NjlrbDhpSkpBb1NlbzVNVjN1?=
 =?utf-8?B?WGxQQmFBbXdtNHRtV0t5OHBNV0l6bjgwR2Z4M2p6Q1NjNUlvMWt1UE1DaEJr?=
 =?utf-8?B?aEozOVFVV2J3SGRlRVJvbXZVT3cxMFIvc0ZKMTl3SHFKVFZvQ0FBdG13VHFW?=
 =?utf-8?B?bE9RVEFCblE0eW04amdtbkpFcEZBTmxjdFpWeXV1M0QxMFg4elg2SHMwc0F3?=
 =?utf-8?B?MlBscVhRQnVrOWlzdEtPa3p6WmRWYjdhb0pKZnBLWDVJTzJkZDF0OVRRd1ZW?=
 =?utf-8?B?OFkrM0RsTmNKNTdpekRyd3FEa0doUy9udFdFY1BQWlYwbTNMa0tZRnkwdVNW?=
 =?utf-8?B?WithM3V6Uk56N05mSFpTTW5CbVhyS3lRMEg5VWRYRHJoNy8yeWJnbDNrTFh0?=
 =?utf-8?B?dUNjTkpBMXNXRXdGNVpGNithN3lFdXQyZW5rQ2Zlb1lWU2IyTWU2bVp2Q3VF?=
 =?utf-8?B?MlhpYXF1Snk4QWRsWVQxeUNldHgyd2M3a1BGdFdUcUtXYVRUd2ZYWHhDc3RB?=
 =?utf-8?B?MTk1S01TSHpmMERFbFcwbmRnS3B3TXhjZys5c0g5ZGU2V3pEVFFHaUYxQTB6?=
 =?utf-8?B?Uko5eFlrOXJtZ0FlekpkY09jSnJnOENHbVpNZW03R0l0c3ZhQ2IxV3J0aW0r?=
 =?utf-8?B?RnZXdWErRzFmNVJmbmVYNi90V3p6dFprVDdaM3ViRExJNXNPWExPbnNXZ0d5?=
 =?utf-8?B?eFZqcmtJZ25kK2I0UmczalVyZndaMVVkdXJCRlJHUE8wYXpNS1NnS0c3MDVK?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29DA6EB67D0D2B43B3BDE698D6B49845@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 070354c8-8ac3-4867-ac42-08dc6252fe99
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2024 22:32:57.7817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZAxuqltI1ZyIf5UKwp4+DVDonsviXu1TwTnrT4AxdS2MQ340RPRiJHh0XUNIGTUCE/xjRrGvxrQwRQZLNgDg/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR13MB4722

T24gU2F0LCAyMDI0LTA0LTIwIGF0IDE5OjQ4ICswOTAwLCBMZXggU2llZ2VsIHdyb3RlOg0KPiBb
WW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIHVzaWVnbDAwQGdtYWlsLmNvbS4gTGVhcm4g
d2h5IHRoaXMgaXMNCj4gaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5k
ZXJJZGVudGlmaWNhdGlvbsKgXQ0KPiANCj4gV2hlbiB1c2luZyBhIGJwZiBvbiBrZXJuZWxfY29u
bmVjdCgpLCB0aGUgY2FsbCBjYW4gcmV0dXJuIC1FUEVSTS4NCj4gVGhpcyBjYXVzZXMgeHNfdGNw
X3NldHVwX3NvY2tldCgpIHRvIGxvb3AgZm9yZXZlciwgZmlsbGluZyB1cCB0aGUNCj4gc3lzbG9n
IGFuZCBjYXVzaW5nIHRoZSBrZXJuZWwgdG8gZnJlZXplIHVwLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogTGV4IFNpZWdlbCA8dXNpZWdsMDBAZ21haWwuY29tPg0KPiAtLS0NCj4gwqBuZXQvc3VucnBj
L3hwcnRzb2NrLmMgfCAyICsrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMveHBydHNvY2suYyBiL25ldC9zdW5ycGMveHBy
dHNvY2suYw0KPiBpbmRleCBiYjliNzQ3ZDU4YTEuLjQ3YjI1NDgwNmEwOCAxMDA2NDQNCj4gLS0t
IGEvbmV0L3N1bnJwYy94cHJ0c29jay5jDQo+ICsrKyBiL25ldC9zdW5ycGMveHBydHNvY2suYw0K
PiBAQCAtMjQ0Niw2ICsyNDQ2LDggQEAgc3RhdGljIHZvaWQgeHNfdGNwX3NldHVwX3NvY2tldChz
dHJ1Y3QNCj4gd29ya19zdHJ1Y3QgKndvcmspDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAvKiBIYXBwZW5zLCBmb3IgaW5zdGFuY2UsIGlmIHRoZSB1c2VyIHNwZWNpZmllZCBhDQo+
IGxpbmsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBsb2NhbCBJUHY2IGFk
ZHJlc3Mgd2l0aG91dCBhIHNjb3BlLWlkLg0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAqLw0KPiArwqDCoMKgwqDCoMKgIGNhc2UgLUVQRVJNOg0KPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAvKiBIYXBwZW5zLCBmb3IgaW5zdGFuY2UsIGlmIGEgYnBmIGlzIHByZXZl
bnRpbmcgdGhlDQo+IGNvbm5lY3QgKi8NCj4gwqDCoMKgwqDCoMKgwqAgY2FzZSAtRUNPTk5SRUZV
U0VEOg0KPiDCoMKgwqDCoMKgwqDCoCBjYXNlIC1FQ09OTlJFU0VUOg0KPiDCoMKgwqDCoMKgwqDC
oCBjYXNlIC1FTkVURE9XTjoNCj4gLS0NCj4gMi4zOS4zDQo+IA0KDQpUaGlzIGxvb2tzIGFzIGlm
IGl0IHdpbGwgaGF2ZSBzb21lIHJhdGhlciBzdWJ0bGUgaW50ZXJhY3Rpb25zIGlmIHRoZQ0KUlBD
X1RBU0tfU09GVENPTk4gZmxhZyBpcyBzZXQuIEhhdmUgeW91IHRlc3RlZCB0aGlzIGtpbmQgb2Yg
c2NlbmFyaW8/DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50
YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

