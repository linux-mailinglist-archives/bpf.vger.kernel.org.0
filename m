Return-Path: <bpf+bounces-37866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F30095B868
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 16:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC96E1C22C53
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 14:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61E71CC16B;
	Thu, 22 Aug 2024 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XqZjmsas"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2120.outbound.protection.outlook.com [40.107.95.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ECD1CC149;
	Thu, 22 Aug 2024 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337029; cv=fail; b=jTv3UODnvMTAAzpEGFlLdr9U9YY7uRnJr9nbH3aak7JjQ3tEmC0yY1HVN20v3qJORfHjmlTzMUVWuU15sso7ChuWW/CPfGnp0T8zSJwFzW+zj7pH8CQTBejpXpQgCW6BX8B4OWxocS155Ib4gGB35fV4u3xCazZc6Xk9M5CMItQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337029; c=relaxed/simple;
	bh=fhb3iZBlED1VR/XxV3rdki6noXYfzotVmunzkkBTwD4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z6hRog/T6kRM7Eoz7DDA2SJrup6poyLeBxnXg7/EHCJ26KxlNSG+TD0E/e3pc8V8iG0agOJsgWZuX1N0YSqARf4UAHHt2T20I7qMn/HMz1+4/4+j5NfioKJmEyk7IS9GXClVgACPhsc+ezaxzSFuDn3H9ERp31boYhsMK/oL24g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=XqZjmsas; arc=fail smtp.client-ip=40.107.95.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/J3f4cVKAG5NYKSS0dQnCrFPc24OKbTgCbCuEpT693LaSiaAYFEAXm4cShaRnM/+WysWoWg72hnPCvKHoPZHyQ6kCTJnDEKeyC/dU18mqghuwxKA7YtSrWpKw5UI2/kIltpDfZ4zFroaLeceMPZ+ijT6g5AtAbDIiX6NXW+nyhjN8JRRli1NOsi9KqEHGV0iB3rddjcFVmrN+w9QqEzmokbASflGJTSSHLhsj6z4L6lxdJfu4qoomz5iEfi3ZWZS0PhYjNv3Rq5PCtfa9Mh2vVKYG0lso4FZullhBP5KTtSRo48MUakfjMC+znIr+li2Je57QXcmtkgHcunSXxvCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhb3iZBlED1VR/XxV3rdki6noXYfzotVmunzkkBTwD4=;
 b=Hp4yV8outHQ5pQaLiRQR4RF/wkcOxqHSTShSuLFFTIrobWDGu2Xza7MBaLdv5/hh1UVh8q3DEMsb+DHSHTCS366MnvU5Cxdm1DCqXueYojTE1GtPNkU6mmk0sBqLHHYrOXHU4uEhSRDcU4TqPhnS95tsyhy7Y/89k8/OJz1DTydvrMyM+r65NrWy4BJrAJfqObYgUNTX+ktLAhAm1Wks30r+Wzc4tnfttRzTwvZ+8Fx7l/gfRxcO6APBjQO0VA9EMCy0RJ/aYHbI6amhSxOPdtTdnEQABXd8dOL0orEfZ5vVnvaKQZQbkAx8A2p9wQvP4kl3WDuJELFr38A3mOEQOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhb3iZBlED1VR/XxV3rdki6noXYfzotVmunzkkBTwD4=;
 b=XqZjmsas5RYtP8c5u4nC3YLBvbf7uqmt+op1eLfS4HEBvs79d60SIdoL3ULsD4QKQg1e0fI+RP0ane6IGW7lwcwVl4oy9fT28UMJnlEXEG1Z1NHPfXechiRMsjXKamUBZsul3E/Ky2DRQnCghqpZmwzutkVy3aM/bEQCvEwRSOc=
Received: from CH2PPF910B3338D.namprd21.prod.outlook.com
 (2603:10b6:61f:fc00::14e) by IA1PR21MB3736.namprd21.prod.outlook.com
 (2603:10b6:208:3e3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10; Thu, 22 Aug
 2024 14:30:24 +0000
Received: from CH2PPF910B3338D.namprd21.prod.outlook.com
 ([fe80::96f:119a:a52d:9f87]) by CH2PPF910B3338D.namprd21.prod.outlook.com
 ([fe80::96f:119a:a52d:9f87%8]) with mapi id 15.20.7918.006; Thu, 22 Aug 2024
 14:30:24 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: "ast@kernel.org" <ast@kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<decui@microsoft.com>, "edumazet@google.com" <edumazet@google.com>,
	"hawk@kernel.org" <hawk@kernel.org>, "jesse.brandeburg@intel.com"
	<jesse.brandeburg@intel.com>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "kuba@kernel.org" <kuba@kernel.org>, KY
 Srinivasan <kys@microsoft.com>, "leon@kernel.org" <leon@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Long Li
	<longli@microsoft.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Paul Rosswurm <paulros@microsoft.com>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>
Subject: RE: [PATCH net] net: mana: Fix race of mana_hwc_post_rx_wqe and new
 hwc response
Thread-Topic: [PATCH net] net: mana: Fix race of mana_hwc_post_rx_wqe and new
 hwc response
Thread-Index: AQHa9Aq4j+lmYFXqTE+quFEsvpVvsLIywcUAgACUgpA=
Date: Thu, 22 Aug 2024 14:30:24 +0000
Message-ID:
 <CH2PPF910B3338DACDB788F3574AFADCFE4CA8F2@CH2PPF910B3338D.namprd21.prod.outlook.com>
References: <1724272949-2044-1-git-send-email-haiyangz@microsoft.com>
 <1fe20e5e-1c90-4029-9d40-625ec3bb3248@wanadoo.fr>
In-Reply-To: <1fe20e5e-1c90-4029-9d40-625ec3bb3248@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f833d1c6-562a-4e55-a8ec-a0d7467e0b58;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-22T14:25:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF910B3338D:EE_|IA1PR21MB3736:EE_
x-ms-office365-filtering-correlation-id: f5cde595-af99-4075-fd00-08dcc2b6f5aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c29XWjJCT2FSek1iMjdQQWtNVW1DY2ZHWTZOSFNjTUxDdHd4MFpGN0NBWkp5?=
 =?utf-8?B?dXAvM2VFRTJaVnVPUk9NT2xyUVhHZm5NQ2xucTBaL01OblhIV3lxL29FRkha?=
 =?utf-8?B?SE9RUmQ5QXEvcHFZdEpMa1RxcUtCbm8wZ3I0Qlk3bEJ2SWRWNjcxaGp1aElD?=
 =?utf-8?B?aG5Fb3hnbWxBVzlSaHJTVGF2Y2dBY0xvZEJGMzJRMTJCWlVDbWp5U3BQZ3Ar?=
 =?utf-8?B?K1RnTVc4NFJtREp3ZjNibEhTdWM1R1dOVFJrb2t2SmV1RnNWNCtYZC8xWXc0?=
 =?utf-8?B?SUI2KzZJMnNrUFhKNWJSdzNySFhBNDkzZWJZSTN1NXdxc1NrWDE4azBVZ0R2?=
 =?utf-8?B?QjBpaUlQb1pkb3hTdjMzMGtTT0xISEJLYncrK0ljejRHUTBKVHl6VzM1UC9D?=
 =?utf-8?B?VVJuVDRTVW9XNEZPTExJR2VFZlJFaUtmUGpSd1ZtSzNPVE42RHdiRWJ3Wkt6?=
 =?utf-8?B?NjU5SHY0SUZOVWY3L01xN0tNY3FsM2FhbnRHZzZucTNPVFg4OUl3N1BTcHpj?=
 =?utf-8?B?L25lcWxyRXkrRHN1Y1BEQTh5NVZPcm83dTJYcGF5L1B2ek1PWmJNQVNGSVVF?=
 =?utf-8?B?L2tJT0FCUVNLYmtLMS9wRXBzZE5KWnpraXlySElBZGZWOTB4UzgzZjZ2cEE3?=
 =?utf-8?B?RTExeUVMdmhsTDdLMzlXM3pITkxQekh0UzlUN3F2TVRjS2ltUWc1MUJOSlRM?=
 =?utf-8?B?TFRiSVZ5UUl4d0pOaUNoMHdraHNZSXR3blE4N2ZnS1RwMnFZQS9FMmJJWElE?=
 =?utf-8?B?akV6djFWa2lXam9vNm92aC9zU2dSREwrWjNYZktlN2IyN3cyamVLUmdod1Bu?=
 =?utf-8?B?cDJ6Um5aalBUWXFQS2l6djZ1RXM0eHpOcWlicVpjaWxCWERIZzBOQ2o4bGlE?=
 =?utf-8?B?V1BCUzBKNDk4S05jNkMrYXpJZVc0aVBQQmpOM1ZjOWd5REhvOUhoT3JwSU5t?=
 =?utf-8?B?RUlyS2FqTlc3V3R3bXFjdTVybU4zTFB0YW1wQWlMMm9OMEZZU0lUcmVwVlJt?=
 =?utf-8?B?bFRxMnZVRDVYQzBuYXR5VzhJQXg3L1lyNGJxakFTVHM2cGZwaE5teDlKeTlJ?=
 =?utf-8?B?TlBIeDJVWXNhekVCM1FqZzNSU010UzFtM0RZS09oUGk1cU9sYW9CR2ZCVmRH?=
 =?utf-8?B?Mm9FYWJtbXhBQUxZdzEvVGxvejloeGY1c3BJMHJFRGpmOURJVmFCVUJIY2Vs?=
 =?utf-8?B?ekVjZzNaa0R0VXl5MFJ2STJCMmthNzNFK29lRnpkKzlWVkdGck5XU3BjZXpT?=
 =?utf-8?B?RHAvUUE0aXBwVzB3U2R1S2wrenM5RGo1b0t6RGUyNG5EUGZWVklFS3NDOXJU?=
 =?utf-8?B?WGlYWnZGdU9kRkxmT0pzT01Bb1BvR014UjRpNkdsUi9zUlh0Vm96eUt2cHFN?=
 =?utf-8?B?QzR0NW1lcHZLTjBmNVlzOU9LSW1NNGVRTjdPcXYxcjIySkdEZXpkY1FCeDd1?=
 =?utf-8?B?OS9mbUdnSnBLOGZQNWVhQzdpb1hBUWRxVWt3VnJSNURveWpJY0swUGcrYm5E?=
 =?utf-8?B?Y1ZBMVBZOTVFZjJ3TENzS0JzSE9hZlc5dm1COU5xNC94c1h1YmFoNlJwR3NK?=
 =?utf-8?B?Szk0OG1OeHFaMThMTW4vb0xmck9ma3FJZHY0NENVQ21hMEQzU2dXOUFYR1Qx?=
 =?utf-8?B?NjA4RDBYRFpJWTFkTHpVWHVhbnYwZU44dVVTaGNHN0lhRDlGTXhBWDV6ci9D?=
 =?utf-8?B?aUJRY1o5b0Z0ajdyOFZNZE96K1ViNVJvU3FJOENuUHJZYnVGTFpWUE14QkpW?=
 =?utf-8?B?aG1hM0g3WHVZRjlLVFpUbTJtTnNmd2tXUmxiRXZGL0tIR3pwSlhDcUE1UW9i?=
 =?utf-8?B?ZkhhcHo2eEJzanpnRHhvWEpNYThoNm5FS1d0aGZqWTJ6bGdPSTJSN2t2NzU5?=
 =?utf-8?B?N3pBQTFkOW1OeHo1Z3ZNZTkxRFZYZ0wvbGlRL2tCOHluVnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF910B3338D.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N01hRU5FRFJOT2xVUGs0cHlZRWR2d3dmbEZYUUFHdGJzZHd0a1BhK1pyU0s2?=
 =?utf-8?B?Q3JxL3hzak5oTyttSW5Qc2xCbFdQQ2VXQ1ZVVm5SNDN3bHlwUGFrVzBEZlJj?=
 =?utf-8?B?S2NJbzh6SzZlSVJOVS9oS0ZsQU41YVhGRGhwbkdtN0dyWjAvQ1p0TU5Ycnk5?=
 =?utf-8?B?UVk2NndabS9DMkc4YjBFQk5lVEJrV0ZGdjhUT2E3MERKcnlhdlZ1T05BMWJx?=
 =?utf-8?B?WUJaNW5PTU1zTnp2ejNZQ1VsNkN1VjViT3lIUyszL3dLcCt3dkxXYStIMnBl?=
 =?utf-8?B?a3pUdUdSNG15VEJ5dGh3bGFBd1B5Y1ZmRjVvL0FtbzdZQjR5S0Z5R05iTk53?=
 =?utf-8?B?cFNFZUJYeGN6c3FLN2tmL1ROZWs5WThtQWJ5cklTajNFaElhdTJOVDg0STBV?=
 =?utf-8?B?U20xWUlBeURJQUc0YVdpMWpySmVud1dLeHRqWXRRcUwrbUpCblIyNlpnbnJn?=
 =?utf-8?B?WERodGV4bXVIbnh0WWtRR1hwNktsdkpteVRoVTdXeE8rUVJjMEkxak9XaUZi?=
 =?utf-8?B?aWNaSnhxbnVVamhqWmRxOTNrRUtCM3Z4ZDV4UWpsTEhUQU9QZXZUZS9GQjVD?=
 =?utf-8?B?UXpBREoySTRSeUE5OGdvakhOZ20wSWJGcXJEUHRJNEUxUFRvUUVkTFRRN2Fp?=
 =?utf-8?B?MGlWZzhZMzhUMXFOM1pGQ3ViYjdzREVpUVpDUWhoTnViM3F6aVZpVHZkUU1p?=
 =?utf-8?B?VjJUMDhYR0RFU3pNVTZ0RUlCZVhSdTVlRUZ3L1dFRi9NTnhzZXNDVXJ4T2lX?=
 =?utf-8?B?S1dHMjFZY244ZHlLY1BYOFAxSXg5TVBoaG1zV25yWk0ycVpuc0lJaVJ1ZXVB?=
 =?utf-8?B?WklUYzJUVkZGeUlqQ3hGR3ZpVVYxK0ZSRzIyblBkYzN0UkQvODNuVkptaGhX?=
 =?utf-8?B?YUc2WVFWZGpmbzlaUVdldVk5TXBqdUhRY3VEOURZSVB1cmptVGtGditpZmt2?=
 =?utf-8?B?dEhyL3F3V0Y5TmtPSWdxRkh1OEJCcFdpWlp1VXFWMlZma3pmMjNSbEhoNjVx?=
 =?utf-8?B?amZzQVBHNnVJV1JZSStsMVBQeUxFQXJZQXVsZnZUUFBmR3FRWjBBQlJFcGd2?=
 =?utf-8?B?VTJQWnYyMU93VFBhZHBYbWdWd1VzMmxWNGxSRENKdGhHTWFvMkVoUjNrdGla?=
 =?utf-8?B?cGJQR2NBMGVKTmpDUWNpVzV0b0ticXlSTnlpNkJDSTRSamtuendteVh6SlFH?=
 =?utf-8?B?WTFROGhmOGRMbHNpbldlOEsyWTBNeVhPbmtsZlUzNzROOXZuaytyVWNWbXFZ?=
 =?utf-8?B?Q0lNd0wydzlVK3ZubFMzMU9JaFlndXV1RlhEMlFOeXV3aDQ0cStpVXZiazgv?=
 =?utf-8?B?SnFGcHJCeGxrZmpCcDJPWFJhTU9hOU9rOUdpQk1hTFZrMVNXQmxaWGpOUElB?=
 =?utf-8?B?RHBBSHhnMm5ucmVhNmthK0VnYWlGTGFmekJWdC9vTngwVGZvVHNudG1jc1ky?=
 =?utf-8?B?bkhsTEFqWnphaHloUUpPT1RhcWxOVklMNVFaaFJaOTl4NmY2bkVTUWdFaS9r?=
 =?utf-8?B?cWtrQkFweWhTV2dxRE9lQlhMU1doSGtwcnV1L2NaRnRwNGJUTnlwY3Y2WjdD?=
 =?utf-8?B?emp1VWNnVjM1bGxRRWM1QnBzSFltVTdZdkNvcTN1QTZTWXhFTnhHeTNJWmRU?=
 =?utf-8?B?QldlSjhzV0ZFZGYzNG9xYithKytycUNBWUFJSktGTUw4VEN1dld1aHU5T3FV?=
 =?utf-8?B?cXhBT0JMMGdlYzBPR2ZCRFdzYXdaSDk2MTFKeFovaWtqM0QrUGZGMVA2YmRr?=
 =?utf-8?B?bjlwZjA0ZzF2M0pyTGRTbjdTSTB2Y0RSZGZlblJkb0Fnd3ljYW4zbzJrOWNI?=
 =?utf-8?B?Nm4rN2lGL1lzLy9KYlJSb2FacFdqTmF6QUxoNitPMlByOVNNYnJaRWtwem5E?=
 =?utf-8?B?QjFYL0dVK3FHM0d1SjFzdGtCbHFHZWdPZjFoaDV4Y09UZjdlTXBURXlISTA2?=
 =?utf-8?B?Y3BMckZCRVZEYjlkbDg2MUFDc0xCb2pYaEtOSWcvckcwYTJlbEY3TitEVHJa?=
 =?utf-8?B?UEpzbWJrRzNjSHE4bnZJM3ZmQUpTUCtPS3Z4Zy95S0VKblBVakYyYzczelFF?=
 =?utf-8?B?c2hvM3A3Y01xN0FRWTlnTGlxNWlmL0ptR2RGNERvQjNsVjhLYTJZU2J4N3Bq?=
 =?utf-8?Q?Gl5Tuea63oTGH3gvdJpfSocLd?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH2PPF910B3338D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5cde595-af99-4075-fd00-08dcc2b6f5aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 14:30:24.1181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PsZLzM8/eaAXaTwTWGK/0RpH58PfjIRfJJx/QhdgdALfFZ9uk/Lr2tFz6S0BzYrpICe4I6J8sotQ7IqC2bVtmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3736

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXN0b3BoZSBKQUlM
TEVUIDxjaHJpc3RvcGhlLmphaWxsZXRAd2FuYWRvby5mcj4NCj4gU2VudDogVGh1cnNkYXksIEF1
Z3VzdCAyMiwgMjAyNCAxOjM0IEFNDQo+IFRvOiBIYWl5YW5nIFpoYW5nIDxoYWl5YW5nekBtaWNy
b3NvZnQuY29tPg0KPiBDYzogYXN0QGtlcm5lbC5vcmc7IGJwZkB2Z2VyLmtlcm5lbC5vcmc7IGRh
bmllbEBpb2dlYXJib3gubmV0Ow0KPiBkYXZlbUBkYXZlbWxvZnQubmV0OyBEZXh1YW4gQ3VpIDxk
ZWN1aUBtaWNyb3NvZnQuY29tPjsNCj4gZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgaGF3a0BrZXJuZWwu
b3JnOyBqZXNzZS5icmFuZGVidXJnQGludGVsLmNvbTsNCj4gam9obi5mYXN0YWJlbmRAZ21haWwu
Y29tOyBrdWJhQGtlcm5lbC5vcmc7IEtZIFNyaW5pdmFzYW4NCj4gPGt5c0BtaWNyb3NvZnQuY29t
PjsgbGVvbkBrZXJuZWwub3JnOyBsaW51eC1oeXBlcnZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0N
Cj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IExv
bmcgTGkNCj4gPGxvbmdsaUBtaWNyb3NvZnQuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsg
b2xhZkBhZXBmbGUuZGU7DQo+IHBhYmVuaUByZWRoYXQuY29tOyBQYXVsIFJvc3N3dXJtIDxwYXVs
cm9zQG1pY3Jvc29mdC5jb20+Ow0KPiBzaHJhZGhhZ3VwdGFAbGludXgubWljcm9zb2Z0LmNvbTsg
c3NlbmdhckBsaW51eC5taWNyb3NvZnQuY29tOw0KPiBzdGFibGVAdmdlci5rZXJuZWwub3JnOyBz
dGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZzsgdGdseEBsaW51dHJvbml4LmRlOw0KPiB2a3V6bmV0
c0ByZWRoYXQuY29tOyB3ZWkubGl1QGtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBu
ZXRdIG5ldDogbWFuYTogRml4IHJhY2Ugb2YgbWFuYV9od2NfcG9zdF9yeF93cWUgYW5kDQo+IG5l
dyBod2MgcmVzcG9uc2UNCj4gDQo+IExlIDIxLzA4LzIwMjQgw6AgMjI6NDIsIEhhaXlhbmcgWmhh
bmcgYSDDqWNyaXTCoDoNCj4gPiBUaGUgbWFuYV9od2NfcnhfZXZlbnRfaGFuZGxlcigpIC8gbWFu
YV9od2NfaGFuZGxlX3Jlc3AoKSBjYWxscw0KPiA+IGNvbXBsZXRlKCZjdHgtPmNvbXBfZXZlbnQp
IGJlZm9yZSBwb3N0aW5nIHRoZSB3cWUgYmFjay4gSXQncw0KPiA+IHBvc3NpYmxlIHRoYXQgb3Ro
ZXIgY2FsbGVycywgbGlrZSBtYW5hX2NyZWF0ZV90eHEoKSwgc3RhcnQgdGhlDQo+ID4gbmV4dCBy
b3VuZCBvZiBtYW5hX2h3Y19zZW5kX3JlcXVlc3QoKSBiZWZvcmUgdGhlIHBvc3Rpbmcgb2Ygd3Fl
Lg0KPiA+IEFuZCBpZiB0aGUgSFcgaXMgZmFzdCBlbm91Z2ggdG8gcmVzcG9uZCwgaXQgY2FuIGhp
dCBub193cWUgZXJyb3INCj4gPiBvbiB0aGUgSFcgY2hhbm5lbCwgdGhlbiB0aGUgcmVzcG9uc2Ug
bWVzc2FnZSBpcyBsb3N0LiBUaGUgbWFuYQ0KPiA+IGRyaXZlciBtYXkgZmFpbCB0byBjcmVhdGUg
cXVldWVzIGFuZCBvcGVuLCBiZWNhdXNlIG9mIHdhaXRpbmcgZm9yDQo+ID4gdGhlIEhXIHJlc3Bv
bnNlIGFuZCB0aW1lZCBvdXQuDQo+ID4gU2FtcGxlIGRtZXNnOg0KPiA+IFsgIDUyOC42MTA4NDBd
IG1hbmEgMzlkNDowMDowMi4wOiBIV0M6IFJlcXVlc3QgdGltZWQgb3V0IQ0KPiA+IFsgIDUyOC42
MTQ0NTJdIG1hbmEgMzlkNDowMDowMi4wOiBGYWlsZWQgdG8gc2VuZCBtYW5hIG1lc3NhZ2U6IC0x
MTAsIDB4MA0KPiA+IFsgIDUyOC42MTgzMjZdIG1hbmEgMzlkNDowMDowMi4wIGVuUDE0ODA0czI6
IEZhaWxlZCB0byBjcmVhdGUgV1Egb2JqZWN0Og0KPiAtMTEwDQo+ID4NCj4gPiBUbyBmaXggaXQs
IG1vdmUgcG9zdGluZyBvZiByeCB3cWUgYmVmb3JlIGNvbXBsZXRlKCZjdHgtPmNvbXBfZXZlbnQp
Lg0KPiA+DQo+ID4gQ2M6IHN0YWJsZS11Nzl1d1hMMjlUWTc2WjJyTTVtSFhBQHB1YmxpYy5nbWFu
ZS5vcmcNCj4gPiBGaXhlczogY2E5YzU0ZDJkNmE1ICgibmV0OiBtYW5hOiBBZGQgYSBkcml2ZXIg
Zm9yIE1pY3Jvc29mdCBBenVyZQ0KPiBOZXR3b3JrIEFkYXB0ZXIgKE1BTkEpIikNCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBIYWl5YW5nIFpoYW5nIDxoYWl5YW5nei0NCj4gMGxpNk90Y3hCRkhieTNpVnJr
WnEyQUBwdWJsaWMuZ21hbmUub3JnPg0KPiA+IC0tLQ0KPiA+ICAgLi4uL25ldC9ldGhlcm5ldC9t
aWNyb3NvZnQvbWFuYS9od19jaGFubmVsLmMgIHwgNjIgKysrKysrKysrKy0tLS0tLS0tLQ0KPiA+
ICAgMSBmaWxlIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21pY3Jvc29mdC9tYW5hL2h3
X2NoYW5uZWwuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21pY3Jvc29mdC9tYW5hL2h3X2No
YW5uZWwuYw0KPiA+IGluZGV4IGNhZmRlZDJmOTM4Mi4uYTAwZjkxNWM1MTg4IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21pY3Jvc29mdC9tYW5hL2h3X2NoYW5uZWwuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21pY3Jvc29mdC9tYW5hL2h3X2NoYW5uZWwu
Yw0KPiA+IEBAIC01Miw5ICs1MiwzMyBAQCBzdGF0aWMgaW50IG1hbmFfaHdjX3ZlcmlmeV9yZXNw
X21zZyhjb25zdCBzdHJ1Y3QNCj4gaHdjX2NhbGxlcl9jdHggKmNhbGxlcl9jdHgsDQo+ID4gICAJ
cmV0dXJuIDA7DQo+ID4gICB9DQo+ID4NCj4gPiArc3RhdGljIGludCBtYW5hX2h3Y19wb3N0X3J4
X3dxZShjb25zdCBzdHJ1Y3QgaHdjX3dxICpod2NfcnhxLA0KPiA+ICsJCQkJc3RydWN0IGh3Y193
b3JrX3JlcXVlc3QgKnJlcSkNCj4gPiArew0KPiA+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gaHdj
X3J4cS0+aHdjLT5kZXY7DQo+ID4gKwlzdHJ1Y3QgZ2RtYV9zZ2UgKnNnZTsNCj4gPiArCWludCBl
cnI7DQo+ID4gKw0KPiA+ICsJc2dlID0gJnJlcS0+c2dlOw0KPiA+ICsJc2dlLT5hZGRyZXNzID0g
KHU2NClyZXEtPmJ1Zl9zZ2VfYWRkcjsNCj4gPiArCXNnZS0+bWVtX2tleSA9IGh3Y19yeHEtPm1z
Z19idWYtPmdwYV9ta2V5Ow0KPiA+ICsJc2dlLT5zaXplID0gcmVxLT5idWZfbGVuOw0KPiA+ICsN
Cj4gPiArCW1lbXNldCgmcmVxLT53cWVfcmVxLCAwLCBzaXplb2Yoc3RydWN0IGdkbWFfd3FlX3Jl
cXVlc3QpKTsNCj4gPiArCXJlcS0+d3FlX3JlcS5zZ2wgPSBzZ2U7DQo+ID4gKwlyZXEtPndxZV9y
ZXEubnVtX3NnZSA9IDE7DQo+ID4gKwlyZXEtPndxZV9yZXEuY2xpZW50X2RhdGFfdW5pdCA9IDA7
DQo+IA0KPiBIaSwNCj4gDQo+IHVucmVsYXRlZCB0byB5b3VyIHBhdGNoLCBidXQgdGhpcyBpbml0
aWFsaXphdGlvbiBpcyB1c2VsZXNzLCBpdCBpcw0KPiBhbHJlYWR5IG1lbXNldCgwKSdlZCBhIGZl
dyBsaW5lcyBhYm92ZS4NCj4gU28gd2h5IGNsaWVudF9kYXRhX3VuaXQgYW5kIG5vdCBzb21lIG90
aGVyIGZpZWxkcz8NCg0KQWdyZWVkLiBUaGlzIHBhdGNoIGp1c3QgbW92ZXMgdGhlIGZ1bmN0aW9u
IGZvciB0aGUgYnVnIGZpeC4NCldlIHdpbGwgZG8gY29kZSBjbGVhbnVwcyBpbiBvdGhlciBwYXRj
aGVzLg0KDQpUaGFua3MsDQotIEhhaXlhbmcNCg==

