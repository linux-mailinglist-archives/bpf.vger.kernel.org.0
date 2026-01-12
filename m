Return-Path: <bpf+bounces-78547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0A5D12546
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 12:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67533308CDD0
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 11:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6F9356A1A;
	Mon, 12 Jan 2026 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AN+lRCUj"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570AB3563E8;
	Mon, 12 Jan 2026 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768217614; cv=fail; b=pNfo7F8av9a3CH5O+fxuoqmS39vY+0A+rTf5ArTBgpql/cE6tPcY3pJgwLNF2zwSmSI46UxfXOnlr34rL1KC+F7Iep3BrDC/0jggHmAn2Tbuiaj3ul75djKdCSJT1Ejfvz2l6GGPHYqvzBfxwKShRpuHmG9cYta1KSd0NCHvW1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768217614; c=relaxed/simple;
	bh=8BCQsB5//Du39op70TqVbTrl1w3RzJkpPH2BYeCdXj8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V1XQGclz3gPre40JbCXQrVUMVPVIFfneQd8eAFPXsOa1i2S5bmK9IQyNUylyjwrtCUhVnHbX24iSuGQxDriNCuoOycNkGK7fTXrPhj+T8wu1VBtl8ho3CFeZ3KfBjEzA3mLh4A/Wl8mc6LAcayFB0iUF0H9L6dEeX3GqFgGUnP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AN+lRCUj; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768217612; x=1799753612;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8BCQsB5//Du39op70TqVbTrl1w3RzJkpPH2BYeCdXj8=;
  b=AN+lRCUjDBavSoxr4WgdZQwPWRoVcUhG1MLzr2T3aUpOdlf02m11h6vR
   o4uyx1ZTMHpmDwH0d1hoZ6OMGtUksaK406D47RIazzyyPR98eA4/AVhtg
   PJgm8STm8HGs75FUH0kgGZf9tLlBJ8wnoyORVOkRefrrGWGgS5PwyA88t
   vBOxqFItbgXwxyaS91gwIfdiy+D1enqZp7uVxSv4/5nckFlfHJKCcVm61
   +zrcMkSHGdWlM7K7HyNH0oBOkUMeLFUX4PPoVYHvRcoZK3+mo4z3Q3N2V
   4mNtiLB5vYpzshfYZMGre1lAL4R16bq2NcpFlHK94yX9kmG4pdtP3YM58
   A==;
X-CSE-ConnectionGUID: u32wXpj1TKOx8/qt12NSCA==
X-CSE-MsgGUID: sNp9qO66RTWCP6yMk2Zo0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69565444"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69565444"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 03:33:31 -0800
X-CSE-ConnectionGUID: 3VSIsZS1RUu3757coChYDw==
X-CSE-MsgGUID: Ie00mu1KRDSDIZdu/ihpZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="204482224"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 03:33:31 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 03:33:31 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 03:33:31 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.39) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 03:33:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=reznSrw4qkjvSr1icC66o130kPeDiNJ+azZmsEJgNKQ6z0n3K3E5T2ixjXNFl18J/GJumKk3L8ivtblq44MgNqNBcUYASdPaQvZavk61zV3BOfCZYcOD7WCny5WbuisdQTr9+F5nQuQotavtxOu1iUvMraFjwZ0Suu4R7eQOg3zdyyEWPQB5jv+s4uzI+/AibntHe+g40rOX8cY2+35dyi9ayb9vZDkcnOw76nhXBTpkPH1Y7l2kJVKRfNXtzAX81wCGS8hkMKqgbytiGztjoxkO2bn1Ek8cdfZji4YKUNxH/CjWx2PoyV85qbCyHTC2Ms2ZMV2lnWZCE2Ky8Wh5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BCQsB5//Du39op70TqVbTrl1w3RzJkpPH2BYeCdXj8=;
 b=qgMOTO9Eyc5HyQr0Z30PfIZrT8yncB4PRI4KeszAlNTFyZSZRSudsyBJIH3wxCmuQDymOTxF8SExpVYfOnMc4D+d18CnQwbadzmrYrZ1fw0KSxAwc9ELKxVkgvtw6MZq5C/5apxscaNYSYyFBPy6NGwunotyChKf/s/ajfa6EyuW4oGSXWm26vS/elZSaIaTVczedqNDD2sP8b2qMdHpq2WjDTmJDykMJrWBWswFzM2QuRoxLCGOuKiPqMLKilmCTUuvh/euzUaGq8yUft86AwWngVI4kv+sGaa15GNvKch/TVhRrz+GRtg0GWcjx2c/n7khsU6t2fnHtVm2gLbh3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH3PPFD6B8A798D.namprd11.prod.outlook.com (2603:10b6:518:1::d51) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 11:33:24 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 11:33:24 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH net-next 09/10] xsk: Call
 skb_metadata_set when skb->data points past metadata
Thread-Topic: [Intel-wired-lan] [PATCH net-next 09/10] xsk: Call
 skb_metadata_set when skb->data points past metadata
Thread-Index: AQHcgnTqYDcbe7LOSEuGZcdyaFgzHrVOaZMg
Date: Mon, 12 Jan 2026 11:33:23 +0000
Message-ID: <IA3PR11MB8986F2EEBE83E4EB21FFCFDAE581A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
 <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-9-1047878ed1b0@cloudflare.com>
In-Reply-To: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-9-1047878ed1b0@cloudflare.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH3PPFD6B8A798D:EE_
x-ms-office365-filtering-correlation-id: a0054796-7bb3-4981-e131-08de51ce656c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dUdJN2ZhUFVzb3orZ1ArREgyYjFzdjJCUCtTY2daTUFFR1FZVTVIM2hKbE9r?=
 =?utf-8?B?aVAwODRKNmk0NTlPeUhpelR4WUtDZm9TWUdBWVNjMG5BNHVjdG9LL3NURmJU?=
 =?utf-8?B?Tk94OS9QOUxqUE1mRnB3dDVMU0V6anBBSFp2Wm9ZdkRkZU9TZ3hCUVFuTHhx?=
 =?utf-8?B?L0xicjJaQTlQRDVyRTRoZDkvZVhHb09uNjVjampzN2Y2U3MwdlZTMUN1Sk5X?=
 =?utf-8?B?Vm5Hb1h1VE9MVTQ4SjhEVDVza1B1anR6YlI3cVhseEpiUVlMN1lVN25kKzRC?=
 =?utf-8?B?Ykcrc3BFT0RCNloxREdnSG9VR2pyMERBYk9KbERmSGNpTk8zc1RvNVQ3QXVJ?=
 =?utf-8?B?VFVFMkxHYTZ5bWowSTRRa3dvYWV1ZHdiTm5BUys3N2ZTYmd0QUkwTjJzUnJk?=
 =?utf-8?B?Z0QwdExLRlNUd0JBbzNENXpaM3ZacmpxTDFnY1lKdmtIaVVxcjd0cVV2b2Zx?=
 =?utf-8?B?dG5ZdzM0ZXhYUEN2Qys0YjRTNmhHZGJ0V3k1WFhtaU9nU25nTENIaEd1WS8z?=
 =?utf-8?B?QXBLa2puaEx2NlNlUCsrdmR4WDhpYkcrYWY3NzdoeE5wZ2NkeG4wZmJpZGFC?=
 =?utf-8?B?eGJ6Q2VTWjhpNHc3SVU0MkpOOHIwaGxxejRkOUhHeFFjZHRRWHpNa1g2dTdW?=
 =?utf-8?B?a3R3b1FRNGxPaGJaOFpiS0pFSml2VStpVFFScXp5NGJYcGMzRGxJZkRqMHdW?=
 =?utf-8?B?T2ZuNUtGZjFtNHNiQlk3anIvUmVHMnRPZDltUUwzbFh6OWJXMG8wcDNhTVVK?=
 =?utf-8?B?V3ljMWRtSlNxNXBadEJobXhaR3ZGdmk2YkNYRXZQSDFubllwR3ZUTXZFbStX?=
 =?utf-8?B?eEhKWXpET2NkQWQyWEF3VjUxYlROM0duY29kU0hHaUFzemRiRWUvTXNXWTFa?=
 =?utf-8?B?L3Jyano0RnYzZ1R1ejBFVzdzVWdUL1JmMGduODVBcWtJZ2l1YTB6OXVqMkVH?=
 =?utf-8?B?cElmclgzL1lzdXVoRVFESmE4L3ZrMEZEcHYwWis2dU5HZ3RYWnQxN3E1UGFJ?=
 =?utf-8?B?T1FobnVIOW1KbEhMd1o1NDl3M0tYdExZQ29XSXozWnJGZXNpekYzSHdTUmI0?=
 =?utf-8?B?Tlp3M21ac1ZXQXZMUlM1d1BkWDZiZlpnZ2I3ZGJlRzZWWEVCWEkyeVdld0Vx?=
 =?utf-8?B?TXhSZXEwYzl6dlZHUXhKZzJ6Vm9qNll6Z3pnaUZldWdqZlZBNXFmRGgxUGtB?=
 =?utf-8?B?NVp2U0RpeHd3LytES1l6K28rZU90eHZnUy9vWHZ4S1BtT1M3ZUhIa1MxRWpt?=
 =?utf-8?B?bjkrVmsvaXl6YTR5cTFrQVBaVkJsU1RINVZicHRUL2dMWmZzVTBFalQzdm5N?=
 =?utf-8?B?UVdQeTNTL2NHcDNoblJyby9wUnQvYUdXVytyUWEwNWFFc0F4SzRadkJYV3hX?=
 =?utf-8?B?K2Z1bXI3cmdCdFRUSDRCamtUY1YraHFIMXFjV0dZMkdNbG9hN2FtTTNGams4?=
 =?utf-8?B?RWYxeXoyNlZzOHArMXpXV0tkLzBxQlMzVFdqdmNLSEhUS0lubU83WmhRcUFB?=
 =?utf-8?B?cVdCZ3hDRXJJMGNOTGJiZzNwNHhXRElNN1g5a2oxTTlWR2xDSW1ZTkxFRGJh?=
 =?utf-8?B?ck5EUDFNdlNiSXF2RnB3MFU1MFQydE5SYzJ5bkxKVVFBK3NJV1kzejVQTzVu?=
 =?utf-8?B?QmlhRGtyTUI5WGtWU3htYzlEVXR2T2p3SkJmM0xvSTVudERsZVZSZ3puLzdr?=
 =?utf-8?B?c1oxajdpTkdURWh1b1dIUTVJK2VLeDJhRUdySzNnalVXNngvWGFhZGJuS1F4?=
 =?utf-8?B?ZlpOYW9DS0xoOUE4Y2lSYWVxNXp1UnpWUGFQT0dkVGtzSGVreTExRVd4QjFw?=
 =?utf-8?B?SUxaVjVzVTlPeEdDQU1GYUlrMm9pU2haSzZIWmw4NE5xRDNzV3I2eitqRVUz?=
 =?utf-8?B?MVp5elhZV1NaSWxiUjB6NG5JNzZJOFlJOXY5ZG1weGJ6Vi94anB1akRIZ0FS?=
 =?utf-8?B?eWRBQ0FQRGcvVjY4UEE1bTJxZnpkUFJSc1VDS014MkxOaGljOFJNRTIyVVFl?=
 =?utf-8?B?R29ESXFCekpJeWdYQzhYTERhbGdRNlk3SHpTZW9oeGwybE9tckdHQmxwU2k2?=
 =?utf-8?Q?rEFIM7?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTZoRWgvdjN2RCtQRFJOZ1ord1dzNWl3N0NWVkc2cTdrazlLbGNUbWgyem02?=
 =?utf-8?B?T0hnbnpOMVVWR0UycXdHRGkxV3ZiQ0k0ZmwycVF2d0FXK2I3eHlmdHR3WnFk?=
 =?utf-8?B?aGJITDFmY1RkTGlkT0pud1pqbkczREdPZ2hIcXp4MERlMWViZ2RidmZmVDNN?=
 =?utf-8?B?a1NNbkYxWjNwVHkzeXZOMmJYb2tGRmNoZnNQR2Jnc21ZeUltUURvVFEvL2JY?=
 =?utf-8?B?cVFLM2x5VnVBUkdnRHp5TmV5VTE1dDJ0a2FyaUowUjFqd1NEZ0F5UWJhK0hX?=
 =?utf-8?B?WW1RK3h2cnlGQW5VTzljZjFjRXdGVG9jdUp1MStOeTFCb0FOd2NVT1pnTnRQ?=
 =?utf-8?B?dGp3RlE3ZEZxelkwNUE4dk5LdmFndDFWdHZoeEpnejNqb3gvZWtzTjNJRUxT?=
 =?utf-8?B?bTRldStnZXAycXNrYUhpVDNyTUZERDNJZU9VOElKMWY4aTRaV1QwQ2lQN1I5?=
 =?utf-8?B?UHF4MjY3RE1VM2dac3B6ZURDUVpBSkxLT3ZTYnNmbi9pREt6T0ptZ0lxYmhr?=
 =?utf-8?B?Um53RGJjSytwQ0lMRWdNRG5SVFdTWklRZ1AyVnVCMHd1ZmkrVllqNys5dFhR?=
 =?utf-8?B?OE5jOXBaN1k1aWN2d3VmMkh3KzdEdk40WE1GYVZCaE1IcUpLRGJITWpteXBP?=
 =?utf-8?B?MXZSUk5ENUU2RjFseVVsTzZ4N1hOc0pqeU0wR2phemhBaWJlZ01LTVUzYkJo?=
 =?utf-8?B?N2FvRFJMSU1qS0U2Qmk2MGV2QnJHMU5zOFhwaG1zclVKV3RTa0FxSVFWaWNh?=
 =?utf-8?B?akRCTDlEU3F2dDJ6NklTZWdXbjBlbW1MakhrYmNJcHVPS2g4QkJWWnlFaVZp?=
 =?utf-8?B?d3BzbWdTdGJycEpBSEdWS0lhbzBXV0txMytQWnFqZkJVcW03ejB3ZGxuaHA0?=
 =?utf-8?B?VTJpMTZKOUZoaWVTU0ptR2NMa1ZTc00vVnNpcTNhQVJmNGRDKzRSblpLZHVt?=
 =?utf-8?B?YWpFTzVaUGptdEhkeVdqWkd1dVd3QUdEa3R6VXJwRmN1bkZDZ0dJemVhZGRt?=
 =?utf-8?B?TDZQKzgxNjN1bnozbEZGcElxZmNjS1JpaS85MGwxNVZMVlBMc1g2ZlZGazBu?=
 =?utf-8?B?RUJ1RXhTSkVwRlZpRmNNMzZnWnZLRmxKWUJMQUtBTC9PTFd6ZkR1WXBNbUZr?=
 =?utf-8?B?Z1RJWkd5RkNOZ3pKZ3JLdGZHYmliRkw0Z05CdXhwdk9oVXZaUG4yb2F6UUt5?=
 =?utf-8?B?cXVKT1JnNGwwcTRJUDNKcE1Lam1vYWhFaXhYc29NTytrS09yTTZCUXdnNFlv?=
 =?utf-8?B?TEZYRmhLeVJKQXNOdkR2Z2FNWHQrWHZZdUJ0WHprck5iZlRtbE1yZXVlQ3JJ?=
 =?utf-8?B?MVVVa3R6VHJhS1JFN3ZXc2lQQ3NTSk5iUlpXcWoycE9EUGZPS053ejlrTXhP?=
 =?utf-8?B?NWxIbHVreHZUT0kzZU1rcUdhenFiYTNnZUN1SVN4VnB1K3QxZFlMU1owaDk1?=
 =?utf-8?B?d0gxRlN2SXVFR05tcUM5RURET2Y2L29VQWhIa095TzdlcjZCNjR6MHpKT2M4?=
 =?utf-8?B?cHIvS1Rob1NHbkxPV2d4aFRWSDFOeXhqamlqcVhaTGlHR1BjU2pQdnkyc1hS?=
 =?utf-8?B?QnZhbnRjYVlZRzJiWkoxTU1vWm56TTlIUUxDUnR2QjlNeVlZTnI4MkxhVDB6?=
 =?utf-8?B?NHdoSjdxcXZuWitXa1dKU0Z5OWhBdUM2RStBNlhUbTNkeU8wODk5K0xvL2cx?=
 =?utf-8?B?L0I5QTNBclpGd0ZFM2xMM0F3b0o1ZG5mcWFoSFlzK2xycWVJNW5RYTN1bFk0?=
 =?utf-8?B?R0ZVOGY1VTNBai8zYWpFVXhuck9DNC9nYS9nVVlDM2FhTkZJaHllQnZUdnJs?=
 =?utf-8?B?UWFkWkwzVXUvOStqdnU1dHNwYnlZRGZIZUpQRTEzUmJtMUhoUW4wOEMrR3lH?=
 =?utf-8?B?ZXQvZEhDWGFJRkZCZTBWMGJXYVNhYWZwNlgrbllsQTBIZDA3SzNVdURoVnZ2?=
 =?utf-8?B?RmoreFp0NWFPRW12T3cvL29VdVhvaWhUdUlPNjBacUpITUU4Q2NBd29KUTRO?=
 =?utf-8?B?VkxQOVp4YWdBY0Y0RG8xZ1Mxb3V0M2wrZ0RhUDJNMHF3S0FFNTFxYWZ4cEdY?=
 =?utf-8?B?emlqMHZvd0RVbjljNzQ1Z0Y0eWQ3cm5CR1VWbTNmck1MR09OdTcxUzBDMUhZ?=
 =?utf-8?B?U3BZazBWUDJVN0VCeU42SjRxWjl5RHhmNEtvcUtUK0ozQmxOWWlKbW5Ec0hU?=
 =?utf-8?B?eWVjTXNhdmZwMjlDVy81eEltcnFnRUpLRk80M0Q5QmQybWQ1emZScTl4Y2tQ?=
 =?utf-8?B?UnlPZG5wSHNFaUtxYVNQUkQvVVRmZ2tBOERId0lzWU40VjVaa09scHZzMGJU?=
 =?utf-8?B?bVNBU0ttMWFBYjFOMzFhdER4Z0RlVzU0QUFRTTBiTVFTK0JIT2NIdz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a0054796-7bb3-4981-e131-08de51ce656c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 11:33:23.9441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V8fijrM2ywjUffUBhHQCbBjjwZobhrDvZcJZ4FPxIyvis4/Qp3lGjF+K6DyVKFR1Gj5KqRAEqnUpkC9nBR+Y+n5lCoE0at3/blONAvINUnU=
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
U3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIG5ldC1uZXh0IDA5LzEwXSB4c2s6IENh
bGwNCj4gc2tiX21ldGFkYXRhX3NldCB3aGVuIHNrYi0+ZGF0YSBwb2ludHMgcGFzdCBtZXRhZGF0
YQ0KPiANCj4gUHJlcGFyZSB0byBjb3B5IHRoZSBYRFAgbWV0YWRhdGEgaW50byBhbiBza2IgZXh0
ZW5zaW9uIGluDQo+IHNrYl9tZXRhZGF0YV9zZXQuDQo+IA0KPiBBZGp1c3QgQUZfWERQIHRvIHB1
bGwgZnJvbSBza2ItPmRhdGEgYmVmb3JlIGNhbGxpbmcgc2tiX21ldGFkYXRhX3NldC4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEpha3ViIFNpdG5pY2tpIDxqYWt1YkBjbG91ZGZsYXJlLmNvbT4NCj4g
LS0tDQo+ICBuZXQvY29yZS94ZHAuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9jb3JlL3hkcC5j
IGIvbmV0L2NvcmUveGRwLmMgaW5kZXgNCj4gOTEwMGUxNjAxMTNhLi5lODZhYzFkNmFkNmQgMTAw
NjQ0DQo+IC0tLSBhL25ldC9jb3JlL3hkcC5jDQo+ICsrKyBiL25ldC9jb3JlL3hkcC5jDQo+IEBA
IC03NjgsOCArNzY4LDggQEAgc3RydWN0IHNrX2J1ZmYgKnhkcF9idWlsZF9za2JfZnJvbV96Yyhz
dHJ1Y3QNCj4geGRwX2J1ZmYgKnhkcCkNCj4gDQo+ICAJbWV0YWxlbiA9IHhkcC0+ZGF0YSAtIHhk
cC0+ZGF0YV9tZXRhOw0KPiAgCWlmIChtZXRhbGVuID4gMCkgew0KPiAtCQlza2JfbWV0YWRhdGFf
c2V0KHNrYiwgbWV0YWxlbik7DQo+ICAJCV9fc2tiX3B1bGwoc2tiLCBtZXRhbGVuKTsNCj4gKwkJ
c2tiX21ldGFkYXRhX3NldChza2IsIG1ldGFsZW4pOw0KPiAgCX0NCj4gDQo+ICAJc2tiX3JlY29y
ZF9yeF9xdWV1ZShza2IsIHJ4cS0+cXVldWVfaW5kZXgpOw0KPiANCj4gLS0NCj4gMi40My4wDQpS
ZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRl
bC5jb20+DQo=

