Return-Path: <bpf+bounces-78546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEA7D12522
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 12:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E01403003FBD
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 11:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CA9356A05;
	Mon, 12 Jan 2026 11:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AqAGbZ5f"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45622C21EF;
	Mon, 12 Jan 2026 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768217596; cv=fail; b=fxp2EUW+sTXTMQZnwyaFB4Qmwyz6gpTcxGxnvoKyGAHsTqhzzd4TTgyUcrqW8vya3TvD4eg1il0F313b7Aexe3uskWdkahRt2pE0gKSi0v72F4qd/EI0r42oMHOqUL2MKjkJo2dpchjYwQaNXn+zFAlyl3qcyIr2tAjKHKNM3D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768217596; c=relaxed/simple;
	bh=cibFEq1PLjbubcAMC55SmFOy5+LD7SaBRWkCkrCzrC0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MutGFG9LfssAOkGgrosEtmEznaAv/S7agharl2krGTbOqcbmP9cO4eIMtUJTCyOn9FIZTuJNZh+wOIdSjEIA3tOEFZfHXqMEVCa/tB6iH8zfit1xQH104I1IiVb9A3OYN56CbPaSqAp/AzNHmfDY3NdFMXA4PyR+m/UerSDmUZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AqAGbZ5f; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768217594; x=1799753594;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cibFEq1PLjbubcAMC55SmFOy5+LD7SaBRWkCkrCzrC0=;
  b=AqAGbZ5ffI+z2lzz5KVn4lwyABWVP3goTGxmbCbljU2xKSK2LqUDHICF
   wQVroQP12vidpO/9qiFK/2bkydyTgknRu4xHyRFI5ifFhLGtuzq0OWvuT
   BmkiSC4imTxBwGByyVBaRaqjb/wY++ZwZcr7l5B1Re1sGIhEjZkhybLwj
   ykKSwjGHUK5tsG8dIi+u6WbXh4ZEatQiP1+lckdi5+mXJDJ9GUMl3XVQS
   vBA4FUeYAwL+siuNbnaI1uLaCbfXHC33jKFxvZIGeleEzMYwNPod7C2rw
   7zMXI7dDoy6TPdHKNrVXU7eUdTRhY/A6DQA+Qe86GZTYZByvmW7yGDwQ4
   g==;
X-CSE-ConnectionGUID: QIrQyM2XT/WmqO9jY2E02w==
X-CSE-MsgGUID: 0KH9kpRiR4GwVfQe810+bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="68694109"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="68694109"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 03:33:14 -0800
X-CSE-ConnectionGUID: ec5azrgHQ9Kph9kTdD1FPg==
X-CSE-MsgGUID: mQ7QSoAgTM2j+8FkKIY6AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="204085379"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 03:33:14 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 03:33:13 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 03:33:13 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.31) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 03:33:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8lk1wMokVtGJW15c7c/suaEZAROzcfw3TIPJP8YL3hE75JXfYDP2UZZHoWA3cLDuCHvCTjS2PJ9TCJrEQWU4fantStTDZdP9UOYWplBMoMkC+8A4/e5t+8FxX+NXfqSt3jVwvHBqd3SgTb7ylnwykUjhwhdBBHN9eEdeczkvUiDL6sWDunYJgbCtXn2PGegUjkdvWNBE9PbWeFYtpYadkXUYyBD52uh0pdXvld6auvasf6hBOFuMkfYCuf01osu8D08YJNj16Pi/gyczfnw0pI3DMicoZZ2c7LmOipl3woZNz57tSYGyCEJ6y96cWiAj5oI3Izyg7mt1AHjP4pk0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cibFEq1PLjbubcAMC55SmFOy5+LD7SaBRWkCkrCzrC0=;
 b=K8sVTIQUbF0f3+BqkDwSNOYyesSPGJQbnLk1cGk4pWmB8fZy7S9/u8jtJDzGxRKsUQ95ZkFZmMQFkgFb9MI0UwLy7MoPsXn391nG47ByAF33O4SgIvbbtezffpqeYvOduqxZL513XbQlCZTzFIGV6JT+tpe1nsDEYaXD1BNWP7CBKMOqujv4GPilVA4RFVoaT5ZUArKtqldAb1w6inB4R1BY5JXMaGaB8becxMjWRlTMZ24ixtuG8QQVMsDsDVZiXmS1jkX7YVHnAqmxeeyKlyBcwe/Cgq35SpB38vqWbTzXZnaxJPSmno3h1DZVvNxYhaVrKZgI8L5J1RjU8yLjIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH3PPFD6B8A798D.namprd11.prod.outlook.com (2603:10b6:518:1::d51) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 11:33:11 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 11:33:11 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Michael Chan
	<michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "kernel-team@cloudflare.com"
	<kernel-team@cloudflare.com>
Subject: RE: [Intel-wired-lan] [PATCH net-next 08/10] veth: Call
 skb_metadata_set when skb->data points past metadata
Thread-Topic: [Intel-wired-lan] [PATCH net-next 08/10] veth: Call
 skb_metadata_set when skb->data points past metadata
Thread-Index: AQHcgnToGzZnOfgn3EmIxrVW1W7DprVOaYIg
Date: Mon, 12 Jan 2026 11:33:10 +0000
Message-ID: <IA3PR11MB89864D82F9F845871E9D12ADE581A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
 <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-8-1047878ed1b0@cloudflare.com>
In-Reply-To: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-8-1047878ed1b0@cloudflare.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH3PPFD6B8A798D:EE_
x-ms-office365-filtering-correlation-id: 95affec9-a3ec-4203-5030-08de51ce5da8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?N0NzVHJmTW00dUdiZlBLRGpqWFdON1pEbjEvcHpWaXQ0aUMvQ2drS3NCNlpv?=
 =?utf-8?B?ejN1TkZiSVlPZW1jZFg1bHhXaERsYllHVW9TTVFqZnFFMnJ3VzhrOXFneWtx?=
 =?utf-8?B?bTV2OEh2Vk5nYkFDRXNJNW1qMEY1bE8zZXhHWHhXZDF4WW9UUUd3Tm16U0Rp?=
 =?utf-8?B?WTFoZG5KL3dmWURRYnl3dDBjb0FwUFdUOFZaLzRzYnpDb0RlU2hJeU5kdGRZ?=
 =?utf-8?B?bmxnWnd0bG52UTJzNGtDOEdRajc1QXlNRHNrQU5MUkJmYm9ZYUdhdENBNzRl?=
 =?utf-8?B?YzBtNDF6NVFieHJRSWw4QzFsWDdHUlFOZEsvOTFibDRYbXFEc0dZbXZhZkNE?=
 =?utf-8?B?N0dRUHdCZENTM2U4MEVIWlE1UjdJckM4R0Fickk4cXRlMmV4VWF6d05EUG9G?=
 =?utf-8?B?RXlDQ2c2N2VncTUrdWJuaDdBUWFPa3RNZjJoeDcyYUF1VlRudHY1dkdoeU94?=
 =?utf-8?B?UUErTTA4MjEwYTJzV3FJQ3FTUmQ2Rys4WWg0aGZmTi82d09VU0UweGJzbnc3?=
 =?utf-8?B?SHJYMjczSlhlcHBhdWJQNEdnY0toZVJFVEtJc2k0YktEaHRINkZhTHBTQURX?=
 =?utf-8?B?dXo4WFd4OUN3NU50TC9kd1BwWmlVUVBxREs0anhwem9JZ2ZlTXdPOUFabWha?=
 =?utf-8?B?cnl1SVFsZnBxYXRmcGh2WmRIQmJFZFZKVjMrM1hxYmhXeitaeUwyVWFHNXRT?=
 =?utf-8?B?SFR5ZXFRamQyaGlOajFkdVYyc3A5WjhvSzMzNDhrRWIvU3NYNElUaFNQRERK?=
 =?utf-8?B?aVNjSEtFb1hNOUVZMFRGUkhSVG01cks3bHA4MFNVdXNES1hVS3lqU2xpYmZa?=
 =?utf-8?B?bm1IUEorVGN2K0RaQUJpVUtYbVpXWnZXcFN4TlVPbDRkVUZFazkxN3BsZkd5?=
 =?utf-8?B?bDVYY1dHbkxMeWV2YTlDQjFpMzI3TkNCdWZPUC91TDhqZXVXa1NGSHRERVQ2?=
 =?utf-8?B?NGNUMkF6ZFVyNGlmRzVqVFc2cTFGOVdhSXNGY0JSeldwOHI5Y3ZmQllxQjBM?=
 =?utf-8?B?MmI4NU1KWG80REdjNEhTUUk1N0xMRWRFMUhXQTY3ZXRMWGE3ZXQ4VnhpeDdh?=
 =?utf-8?B?UWw4TCtVMlBrYUpsT0JVYjd6dlpad3lkL1U1UFhqM0JQbytjeFpkS3B2U1hr?=
 =?utf-8?B?cTRPcHc3aDlrMTJOOFJwajFhblV4MGpxZ052UzY0Qlp4VWpNUjNqSmtXVm1L?=
 =?utf-8?B?eGtRQWxXNGtZZXNOQTJrakRtUVZ5SFZIZDVmTTlwNmV4N2VQZE9JRC9ra3l6?=
 =?utf-8?B?RTBlUnRTUjRza1FJTENpdmpNaHVXcGE2NXQvWENvZ0dOeWZPNzhvMU13UTk1?=
 =?utf-8?B?Rkt5TG5yVi9GRmdsTWlnWjJSU3cxNWF3M0o5dnVMNlZPR3pveHZUcnJMOTJv?=
 =?utf-8?B?MjJVQThQb1V5UlVtZVR6Q0t5bURCdGp1cFdsbWZEY1E1KzZkQnkzSnhMSEph?=
 =?utf-8?B?eE0wWjA0djVtcVVJQjlOcks2Tk4wUk9sN0QrSlUwOEN2djd2TURYUDRUT2Zr?=
 =?utf-8?B?YVVTYUt6c2Mwcld3WWdaejREeThDWDhPa2tINnZ2NzE1ZDdtQlV6b0dFSnc1?=
 =?utf-8?B?ZVVNQ0JYd3VCeHkxK2wvbmZCb1VCUlJjakVuUHI1bVk4QXZXZ0hQSFYvY1VV?=
 =?utf-8?B?UFUwOUpudkQ5Y29iaEVaamVQSmdCTVpZbU1hYXQ5ZXhNRjlOUDg5dFo4Q0lH?=
 =?utf-8?B?ZUl2QVlnSVc2MXN0WVJxK3dybDJzSkNRM1hRRzdTYkV1c3FMQm8rR2t1eG5U?=
 =?utf-8?B?eXlwTmtUSThLZlpBZmZyQUFYaGUxb0JWcnFBK1Z1ZnJGWm1YZ3Y5NkhZWlBL?=
 =?utf-8?B?OTNzQzJDV1R4eFlBUmJTb0I1aStNdjdhY3pONEhPV1NKVkh4SUZDME43MWpu?=
 =?utf-8?B?YS93MWpCUUovUlRSakZ2cGp3MXUzOXlLL0pDOGprTUwxR0x6YmgzYzRlZXUy?=
 =?utf-8?B?c05XVnB6RjFwaDZpYWU4dW1kSWpFVE9jcGVmcjBMRDJNS0FRREhwRGI4K0w1?=
 =?utf-8?B?akJMWnFrc3Ftbnl5RFdoTTVwZHJGRmhYYW95RlRyTndXZ0NWUEJlZ3phRnZP?=
 =?utf-8?Q?ypDIKh?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ty9kOUVPZUh5clFJSGFVQm4vUU1RWGFvclVBa1RGZ2k3MUtDWkVaVEhKdkQ0?=
 =?utf-8?B?a2twbXY3OW1HTkxLRm5YK00zOExlSkhCcjdnQ3lhQ0s1UlNYYVlxRDhlQ3h4?=
 =?utf-8?B?OU9JMmpYbDNTN1dWTE9YSDNUdHNwMjJIUDcvMDhKSDhVM0RMdUxaMXUwL1ZH?=
 =?utf-8?B?aHJHZS9LaGNTNXlGMlRhbldORWtjWUw5Zzg5QTZzRXpId0RjREJ3QXRjR2px?=
 =?utf-8?B?dDAwM3VvWG5uMVAxWFIwMzJGQ2RhWVk3bEdQSXdzYXFaVzllYkRjSDBMWmhE?=
 =?utf-8?B?N1hqM0dWSW1GQUxTSlRDVXlpY1lXRmMzSXN2RzdTTElvdWdNaGo1V1VGWTl4?=
 =?utf-8?B?enZlUEZtbXlrN3EvYjF0bVlFNkFSSUZIOVNHbEEvWDdOUEhNY1g0Um53Y0xy?=
 =?utf-8?B?dFE4RjJaVUhwWDcvbjJPYmF0TFkrOUtDT2Mzb2dtMlZWTXJNQit0aFUzWlM0?=
 =?utf-8?B?OG9XVEI1NGhTc01Fd0VtaXZJVUVmeFVpZkR6RmN3RkpBNU55WTJIT0NxQnBL?=
 =?utf-8?B?bklUeU55VGJEZ2Q3Rmw3QTRYSVNmaDExMTkzSUg0dXdEOTNFTkxpZlJ3aHo4?=
 =?utf-8?B?M0RpSkdYVFVjdmpjb3JKS2NxbUFNTmZIalBDQVFxWWZGOVJ0YisrdnNFaU94?=
 =?utf-8?B?U0hGT2FwNmdxWWtPRC9EU1JFcEFYcG1PK0g1ZVpUNW1UdW16OUxHRnRIU1Ix?=
 =?utf-8?B?UkFwV2pjM2orbHVzMjZ4b3JIU2xMdEhhVXdqcnpHRFZ2VHNtWTVDVTRsSVor?=
 =?utf-8?B?Vm0rSTlTZHdwdGsyY3hsRlZBZ29OVkNUUlcxZ2FndG9TTUJPU3FOcDNBekxH?=
 =?utf-8?B?UytWencrMUJiSXA3N1VINDE5OGpzK3htdmdJa3hZeWdhc051bkg2RUd5OFhX?=
 =?utf-8?B?WGxsd0ZYUVlPVXpJYWtFUGE1cStBUjBVZGJJZllYSFRMVEFUZ2pQN29RZjJM?=
 =?utf-8?B?RG5mNXI1bHhOUk9Xejhsbm9MWncyWjVadUxaaHo2VE9jZWo3NTUvdDE2TXB3?=
 =?utf-8?B?K3kwbDA5KzdCSTZJZEJ5R2ZuTit4NTJRM2RLaUJOdkk4STFKMGVnVzdVSTJy?=
 =?utf-8?B?WHVxTXh1QUJLQWRwcUlqOEhTWHEydy9mbW95ZVluSFpVSlNhYmtXQTVtWEZH?=
 =?utf-8?B?YlpOZGhqQVJ3ckwxdXB5UGQyOTBVa3lCeVBwNlBCMjg5UjFnUWRCVjF1UTZa?=
 =?utf-8?B?QmsrcTdmRDZDT3BkREI5TXVNcXlkeGhaRG5hbHNRSWozY0NHU3Z6T1VKRUhN?=
 =?utf-8?B?dmdMT1lKNkdENjF5NU5nRFp3K1M0azcyeVk3T1JrZ3Z5MzVGMGcvRDh6cmEz?=
 =?utf-8?B?Wm1DcDkvQllzZ0N0dlpvTkhaWC9WOFN4MG10cWhzdmRtOWEwU0dLUmh3c1BB?=
 =?utf-8?B?aGIwYUI2VXlMRjlRcEFxRWxGUnA5Y2s4bHp6VDRzdEF4SDM2Y1A4MVV6c3Ju?=
 =?utf-8?B?ZitHbmpnbG9rTDJPd1FWcnQ2TW1LZTNYK3ZIN3dmbktrL05meEorSzNsTnRy?=
 =?utf-8?B?V2tEQjl3anliVjhWdEVoMGV4ZzNpY1ZlYUhrSUt3ZXRab1BMN1JOd0owdWs1?=
 =?utf-8?B?c2lQSnBsY2ZGU1VQa0NidjhhbHBJdU1oTlpCYnpyTmI2ZGpuNmlqQ1d6d1BL?=
 =?utf-8?B?Q3Iza0JuRml4MEFCMzlpMFlrTUZ4NzZ2aE5La3lFUFRES2w4b0htZloyV0o2?=
 =?utf-8?B?aVpyNlovOGM1UEdiekVtZnJoUTBGeUVSMVlpMGFjVExiWC93QWxFZXozSjk0?=
 =?utf-8?B?VFEvMnVOTXBZWGVPVHMwemlxSjY0WDBDd01UVmhhY2NrZUtvMktkODZxc2Y0?=
 =?utf-8?B?NnZ1R0hCRDdiR3VPRGFGRTVkQlI4YVU3aUdQTjlPWW9oUlVGdDI0dUVueE11?=
 =?utf-8?B?WmhMaUdhRVh6L1NWSTNKeGs0OVFrYk1wOUxqQTQ3OXg5c2EwRFhheXROL2tT?=
 =?utf-8?B?R3pJajdFcSszWTdUTHNXcktkeWtrdmtBWDFjaUNCdWpSdERteUs0ODQvamRY?=
 =?utf-8?B?SHBmWnBDNmZxM0tSbHhFdTZHeFpMbGR1cVJBSlFmMHVxNmp4b0ZZblJjMW0z?=
 =?utf-8?B?QWErVXRHaDdSQndYczJwOXFVbXBoUDFwUXB1OVZYa0tURDVPU0RneUErZFJ1?=
 =?utf-8?B?OTdEbG9kQzRUYW16UzlOY1VibnhRV005cWtvZmRVK3ZwQklPZWZONnhSNkVz?=
 =?utf-8?B?SE9BbmMxd2xMaklWWUk1ai9qK1NneCt6OEt0MEFUaUtkZFpEMWlha3RSUTRF?=
 =?utf-8?B?amVaVm5ibkovMEs1YW10TUV6a25xUnJ2R0N4MUoxZHFsQm1lbjhnT0txWmtm?=
 =?utf-8?B?NjgrTXp0Qit2WVNJbGQ1OXRJWHhLQVlOelBkeC8zNmtVY3JZTklqUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95affec9-a3ec-4203-5030-08de51ce5da8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 11:33:10.9084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WQhFKENxXzPpb9wI9nZt/can8wFLSrFiKG5HZgEQBjTPp8zxeQUCmR8zZq/Eq2C5hlc+9uYMR4lam8BJyE0CY3mVBoruKTb904RXbPueVAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD6B8A798D
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgSmFr
dWIgU2l0bmlja2kgdmlhIEludGVsLXdpcmVkLWxhbg0KPiBTZW50OiBTYXR1cmRheSwgSmFudWFy
eSAxMCwgMjAyNiAxMDowNSBQTQ0KPiBUbzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBDYzog
RGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0DQo+IDxl
ZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBh
b2xvIEFiZW5pDQo+IDxwYWJlbmlAcmVkaGF0LmNvbT47IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2Vy
bmVsLm9yZz47IE1pY2hhZWwgQ2hhbg0KPiA8bWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbT47IFBh
dmFuIENoZWJiaSA8cGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbT47DQo+IEFuZHJldyBMdW5uIDxh
bmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBOZ3V5ZW4sIEFudGhvbnkgTA0KPiA8YW50aG9ueS5sLm5n
dXllbkBpbnRlbC5jb20+OyBLaXRzemVsLCBQcnplbXlzbGF3DQo+IDxwcnplbXlzbGF3LmtpdHN6
ZWxAaW50ZWwuY29tPjsgU2FlZWQgTWFoYW1lZWQgPHNhZWVkbUBudmlkaWEuY29tPjsNCj4gTGVv
biBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+OyBUYXJpcSBUb3VrYW4gPHRhcmlxdEBudmlk
aWEuY29tPjsNCj4gTWFyayBCbG9jaCA8bWJsb2NoQG52aWRpYS5jb20+OyBBbGV4ZWkgU3Rhcm92
b2l0b3YgPGFzdEBrZXJuZWwub3JnPjsNCj4gRGFuaWVsIEJvcmttYW5uIDxkYW5pZWxAaW9nZWFy
Ym94Lm5ldD47IEplc3BlciBEYW5nYWFyZCBCcm91ZXINCj4gPGhhd2tAa2VybmVsLm9yZz47IEpv
aG4gRmFzdGFiZW5kIDxqb2huLmZhc3RhYmVuZEBnbWFpbC5jb20+Ow0KPiBTdGFuaXNsYXYgRm9t
aWNoZXYgPHNkZkBmb21pY2hldi5tZT47IGludGVsLXdpcmVkLQ0KPiBsYW5AbGlzdHMub3N1b3Ns
Lm9yZzsgYnBmQHZnZXIua2VybmVsLm9yZzsga2VybmVsLXRlYW1AY2xvdWRmbGFyZS5jb20NCj4g
U3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIG5ldC1uZXh0IDA4LzEwXSB2ZXRoOiBD
YWxsDQo+IHNrYl9tZXRhZGF0YV9zZXQgd2hlbiBza2ItPmRhdGEgcG9pbnRzIHBhc3QgbWV0YWRh
dGENCj4gDQo+IFByZXBhcmUgdG8gY29weSB0aGUgWERQIG1ldGFkYXRhIGludG8gYW4gc2tiIGV4
dGVuc2lvbiBpbg0KPiBza2JfbWV0YWRhdGFfc2V0Lg0KPiANCj4gVW5saWtlIG90aGVyIGRyaXZl
cnMsIHZldGggY2FsbHMgc2tiX21ldGFkYXRhX3NldCBhZnRlcg0KPiBldGhfdHlwZV90cmFucywg
d2hpY2ggcHVsbHMgdGhlIEV0aGVybmV0IGhlYWRlciBhbmQgbW92ZXMgc2tiLT5kYXRhLg0KPiBU
aGlzIHZpb2xhdGVzIHRoZSBuZXcgY29udHJhY3Qgd2l0aCBza2JfbWV0YWRhdGEuDQo+IA0KPiBB
ZGp1c3QgdGhlIGRyaXZlciB0byBwdWxsIHRoZSBNQUMgaGVhZGVyIGFmdGVyIGNhbGxpbmcNCj4g
c2tiX21ldGFkYXRhX3NldC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpha3ViIFNpdG5pY2tpIDxq
YWt1YkBjbG91ZGZsYXJlLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC92ZXRoLmMgfCA0ICsr
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmV0aC5jIGIvZHJpdmVycy9uZXQvdmV0aC5j
IGluZGV4DQo+IDE0ZTZmMmEyZmI3Ny4uMWQxZGJmYTJlNWVmIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL25ldC92ZXRoLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvdmV0aC5jDQo+IEBAIC04NzQsMTEg
Kzg3NCwxMSBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnZldGhfeGRwX3Jjdl9za2Ioc3RydWN0
DQo+IHZldGhfcnEgKnJxLA0KPiAgCWVsc2UNCj4gIAkJc2tiLT5kYXRhX2xlbiA9IDA7DQo+IA0K
PiAtCXNrYi0+cHJvdG9jb2wgPSBldGhfdHlwZV90cmFucyhza2IsIHJxLT5kZXYpOw0KPiAtDQo+
ICAJbWV0YWxlbiA9IHhkcC0+ZGF0YSAtIHhkcC0+ZGF0YV9tZXRhOw0KPiAgCWlmIChtZXRhbGVu
KQ0KPiAgCQlza2JfbWV0YWRhdGFfc2V0KHNrYiwgbWV0YWxlbik7DQo+ICsNCj4gKwlza2ItPnBy
b3RvY29sID0gZXRoX3R5cGVfdHJhbnMoc2tiLCBycS0+ZGV2KTsNCj4gIG91dDoNCj4gIAlyZXR1
cm4gc2tiOw0KPiAgZHJvcDoNCj4gDQo+IC0tDQo+IDIuNDMuMA0KUmV2aWV3ZWQtYnk6IEFsZWtz
YW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0K

