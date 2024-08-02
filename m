Return-Path: <bpf+bounces-36287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A80945EA9
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 15:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28672282873
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 13:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0A61E4853;
	Fri,  2 Aug 2024 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e21xuI6I"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A101DAC4F;
	Fri,  2 Aug 2024 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722605280; cv=fail; b=mrJUnfBe0GkSresz2MCSzEe7HLcwPzryUtlCwjXo0pO40DqB8iwBMP9D1N2uwc9ADJ9IQ+bzbAKAV4ZMbqxu2m1kJwXNKx0P/+299ASl7Y0LDZRPApeAVRvvkIlqiJySBB/Il1jqmmJ7W3GS/rQeR7D4sI4fzewdEWLrqDnljpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722605280; c=relaxed/simple;
	bh=53Ps6xOzxefiRHI5nXz3aDhHMklouwvN3z3c/pryYnU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D96Mt5p2nBR/f1ZTTEn5z4rCEZhQvvG8gO0Bqc+w6Lzemqg6RQXNsd2mGKsNSItvg/xWd49NmN6rP7J28O9hrIyKBj1XaQbqbAdq41C8sWnosl72utJhXvySD8dbVZ8M+kJYf3OShEEd9WcG4uiahOljaFueAMiv54qeUnGed58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e21xuI6I; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722605279; x=1754141279;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=53Ps6xOzxefiRHI5nXz3aDhHMklouwvN3z3c/pryYnU=;
  b=e21xuI6I+sIDCjw9InM48hu3jvEK20/S0WbmdpgfVsfpioHNOgCmObwm
   iaDZsfMzzfHMFW4+mkGQNInU3vo3EXw8Z+6rM3547wC9uY+gaJxR5hl7E
   bs8R+HOT1COf/F6u4GLnRvU+lRmhL1jqipsDZK3VaKDTrzTv0da7J56YH
   SD7l+bdoZlv5P93wOY/APtXHZ0pyPuzsmDM5rQAOl8D4bBydI0piLbyLW
   bW8P+e86lgrNRIxGMw+EiWdI4iLI57lOFmNtIxrVe/6z897qQkJ9LjoPz
   tRJgW0pnVwE5Hjmckop3f2X+NwMyWOaxjuNTJkljNBnih4W2/ShNP+XUs
   Q==;
X-CSE-ConnectionGUID: oPJSFf9gS0SbvweX1ie7CQ==
X-CSE-MsgGUID: U6ixQ5F+QISM6dQ6sGKwgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="32023340"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="32023340"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 06:27:58 -0700
X-CSE-ConnectionGUID: QSylu0oxSb++z5mfs7tg1g==
X-CSE-MsgGUID: LHdtHdcAQji3SZkHQHTHtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="86327255"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Aug 2024 06:27:57 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 2 Aug 2024 06:27:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 2 Aug 2024 06:27:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 2 Aug 2024 06:27:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 2 Aug 2024 06:27:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWCmMOVbkeE6M8IA6SizM7H5qnnrPFqQ3Szt7hD3IGTEDoGO1iiHJCPWYyH7EhnvenTLI1z2RZXNK94dx41ryub4Gyo8Ux64+M8w+T8AvsuGwGyqc7egsVToYfYweIuVZkOpyxpHn9P4X3gRaBxGosTB1s+0LYT9e8y1N3AR9VH/1LEMyjxgjudjMdRnJH2CjYz2KdsxIehuYtwD7JZ8AF41SvYA98e94Dz3Fm+tHyBZtQ+2pOthlkeKRhaBG91Aafd8MuuNErrdqmmMR43Wv2kJdr1Ldb4eY4bcgcsVmaTWdSJyQQxGtpHSaLkyBu4vqANl3vq4+qkCJ8P1ZoNbxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53Ps6xOzxefiRHI5nXz3aDhHMklouwvN3z3c/pryYnU=;
 b=YdrLbl0men1insGAMUk70dbo1r/KbIcXRDPJVE0ji8N+fSy419bv9NMjKYehCoi1jk8L9f47ad1Gth9NIUfbdYkuJwSodzcRBADylfIP+uNEtncLmus8BZhz6x/zrgFrq7PewarZz5VHBtlMuqOeVTAeJC3hWbNduxMQ4OlWWOVYcEPYrX+HpfqvSZ2bNVmsgsYbyn6Q8maqKQbYReNMK3sfCp4q6TRysU8tieG9s2cCH7BAArTga3ELgp8yEwqDFp3xaW1MyoCSMIogm9RSF8VBaKQ8D0Jfeh3P38Yfwu97w//xZAVG9l+T6ks8/k4quKHVIiCB7PHzD6vvgzOgiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8313.namprd11.prod.outlook.com (2603:10b6:610:17c::15)
 by IA1PR11MB7295.namprd11.prod.outlook.com (2603:10b6:208:428::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 2 Aug
 2024 13:27:51 +0000
Received: from CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::3251:fc84:d223:79a3]) by CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::3251:fc84:d223:79a3%5]) with mapi id 15.20.7807.026; Fri, 2 Aug 2024
 13:27:51 +0000
From: "Rout, ChandanX" <chandanx.rout@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: Jesper Dangaard Brouer <hawk@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
	Richard Cochran <richardcochran@gmail.com>, John Fastabend
	<john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	"Kuruvinakunnel, George" <george.kuruvinakunnel@intel.com>, Benjamin Steinke
	<benjamin.steinke@woks-audio.com>, Eric Dumazet <edumazet@google.com>,
	"Sriram Yagnaraman" <sriram.yagnaraman@est.tech>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, "Nagraj, Shravan"
	<shravan.nagraj@intel.com>, "Pandey, Atul" <atul.pandey@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 3/4] igb: add AF_XDP
 zero-copy Rx support
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 3/4] igb: add AF_XDP
 zero-copy Rx support
Thread-Index: AQHa1Dlmm/wubqW8ske19drXaws1fLIUFqtA
Date: Fri, 2 Aug 2024 13:27:50 +0000
Message-ID: <CH3PR11MB83138A8B5F94316C7DDCB55FEAB32@CH3PR11MB8313.namprd11.prod.outlook.com>
References: <20240711-b4-igb_zero_copy-v5-0-f3f455113b11@linutronix.de>
 <20240711-b4-igb_zero_copy-v5-3-f3f455113b11@linutronix.de>
In-Reply-To: <20240711-b4-igb_zero_copy-v5-3-f3f455113b11@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8313:EE_|IA1PR11MB7295:EE_
x-ms-office365-filtering-correlation-id: cd159489-b319-410b-565f-08dcb2f6e861
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VTd5VzAzSEJIMU1KUzlKeE5QWTljcVo5aEpLaERVWTN2cmc2djRxZlo4OXRT?=
 =?utf-8?B?b0ZYbHJrdWVnbWgxMmJWNytya3c0S1lxOGluTHAvNXJxNS9IY3F2UkFTUEdH?=
 =?utf-8?B?aGpwQ2hzWFVNTzJuNHN6ZjYwNS9QWG01NnRwVXZsNnhKWGM4cGJzRnhvVkJN?=
 =?utf-8?B?RGtoOWZjb2IxekQ2cm0xRmhIUm11KzdEMk1PR0NOS212Y0tRNU11YTBFdFdo?=
 =?utf-8?B?MUFJTzBmd09jNUsxbnd1WlVjRGhFaWhhbTZHZCtoTHBBMlBRcWVnMUE1dWZJ?=
 =?utf-8?B?MEpuR3VQa0VRYnk4RnY1WFN2SFdkNnQrSjJjUGwwMm9tQWpQejVqM0hSSmpk?=
 =?utf-8?B?Ym1XWGVSNlU3TGNCelZUTXBKdW01VUR5K0lvam9oMi8zaDNzVjNVcXZIelZC?=
 =?utf-8?B?T1psWmExTmxjQklUS0c5K1ovTUFsSWtxMUFkMUtWek1ZaW9TeWcyOTZ4aGxs?=
 =?utf-8?B?d1BMQ3JlY2lEVkhYMUJOZjVXajFoSjNLdkdxdmMyU1A0L1o1MSsvbzlKdEp3?=
 =?utf-8?B?clB3WkFWbkRTVFBkNzhnMmhFYWQvNWt2MGUwWUM5bE1EQXBUN3ovakpYL3NL?=
 =?utf-8?B?VjV3MzdRQVJWOFNyalp6dGFYMWVFYmlMd3l5U1ZldkhYYXVLNDBrOVRDRnpq?=
 =?utf-8?B?ZmRPV2hDcDB5eFY4ZFR0anQrcUZuMVBxOEF6T0tGR3dkd3pHYW16NGFmZGRn?=
 =?utf-8?B?SzRnWTR4ZXp1S0RJN05YNHQrd2k2aU9MWktFSi9hTUU3WmpDekFWN3lkVUd1?=
 =?utf-8?B?dFc3VW1CNm91N3FoY0pYQmRKOHFpWldIck5YNi9pK3dsa1B3R3NLdXRnZ0xm?=
 =?utf-8?B?SmtFWWVxUExMNk1MUzZuMkZwUk5NdGZiS09qZ0htaEMxV2JWT2ZWRVZUclNM?=
 =?utf-8?B?Yk5uR2Zvdks4NlZ4T2JYeVdRM3RrQ1FYK2xpSUtaemlPbjhFZ1VYaUVXU0pw?=
 =?utf-8?B?aVR0a2VGZGMxUXlXNDFNMHd1eFVpL3QzNEJXaXhxU3lnZFpCWWw5Y3daYk40?=
 =?utf-8?B?MzF2Q3pBRmJ0Wmh1enUvNC9oZncyeWlQT25qZ3BjaG5uNXlPR3paQXZMY1lx?=
 =?utf-8?B?aXZaOEhjOFhtSnpTaDJ6aGZLdjBiL1NMSWNwRjU4RVM0QjY1ck5VMllNTVZ5?=
 =?utf-8?B?TXpBL2lCQzNvTUE2NzAySzljaHozNVY3MEt1S25mTFFHWVZPbGRHY25kN0Ro?=
 =?utf-8?B?Y2tpbUZRMjYvMTlndUtmcHNnRWNUMUhKYzlRdk8zTmF4MW4yZGFJd0JjRjVs?=
 =?utf-8?B?bUNmNzE1V3lTRTVhdlNFU1E3QkUwUnArbS9BR2RMRjIwNWlaVm11YUs4bEJ3?=
 =?utf-8?B?WTNkSkhOQXF0YlBPc2NEclBuUGVjK3BUYlM0dEtpVjRTVEY4LzRnRkFldHFZ?=
 =?utf-8?B?RmlTSTZvUTRpVThlNk9vWGFyenJUZFEwdUdUenFJTVVEUXAyeFV1MW9GeklZ?=
 =?utf-8?B?T3VpS09VQTlQTVEyWW9CVXZTdmNpLzIwaFp5MVcyS1l6Z29VenBvZ20raDMr?=
 =?utf-8?B?WXN2aG1GVGw2R2cxUndINGRoSVB1MVpSWnh2cHhFNWV1N3NadlZ2QWV2d3gv?=
 =?utf-8?B?WmhzTXFMQzViVFdPZHN6dndCZU83bzVkNUhWZkZzSFVhYWpqeHFCNHJFa00y?=
 =?utf-8?B?ejFWNUtOS20xOTEvRysxNWlLdVBpUXk3b05NN25iZ094Mk4vQmZkOWRVUGRs?=
 =?utf-8?B?cWhYb0gyazB5UjFLYTYyYWVxcUhuamV0ajhCUitlNDVTcEdIbVNoZU5WMHNC?=
 =?utf-8?B?TStKQXQzWmwzZGpOVWlFV1FBSUtDd1RSeXdLWW5nYis5L3dVNHdJRm1PdEha?=
 =?utf-8?B?TDFkZGVnOG9qeUw1ZXlrSVJHYXRmY0ZYb21tdUZDOVl1ZitxVWhkbUFmL04y?=
 =?utf-8?B?NWlrMWs3R2t2UFRlU1dNRi9yVTR3dHJjSm9NRm83ZlM0b1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8313.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmtoMi82MitLUlhmSlBUaFJIclRkckFCeDRuTjIvV2VZalkwbi93YXVtNFpX?=
 =?utf-8?B?cW0vbTEvN25KemRVVTMzZkJjMDllRnFQQkxud0xDN2tWNjl0aFVrWUY3UDZJ?=
 =?utf-8?B?bFpubHlHQTc2ZU5UajBjOXJ2em1LUnR0Q1BWTXVrZ2QvUnNuTWRwZG9Oa3d6?=
 =?utf-8?B?c2p4cFZKRk1sdDRUMTBLR2JOSXJDTmFwYTBYc29OSnl6andnWUU0dmdiQ1Jx?=
 =?utf-8?B?ZHBSRW1VbjZCWmFFRDhsMG1Ua2tCZkFsNkJ1Mzk4Qjh6OWNyWFQ0Y0N1Wnlk?=
 =?utf-8?B?TVBwMTlwMjJjRVlKYlh0Y0x1VVRIaVF4RXJEY2JPSVdWdFFUVzlqd3RNbEhy?=
 =?utf-8?B?aUVkNjFkQTh6VHlRV2NhejEraTFLU0NrVDNMcU90NXRvOGNSNXk4Wld5YVFj?=
 =?utf-8?B?cWQvd011QkZ4OEltVjRjM01yZWNiK04rWWxPRGJGc3hBQWw4R29hZkRaQ29n?=
 =?utf-8?B?MU84QXRjckZ4WE00azZkaGRxQ3NodjhaQmVhbHlnZEwwUFVPb3VGTHRMOWtu?=
 =?utf-8?B?Y3I5Q0NUMWFOeTNmYzdnRmJFbWwvdmFxeENxa2J4VDJyWnFnbk1oOHNlZ3Vz?=
 =?utf-8?B?RjRSTkErSGpUa1BvZFUrbm5kZGNsbUJOZXhTSkVhaUtiaFEzWTRieFdEV2R0?=
 =?utf-8?B?TXJNVGVxa1RuVk55c0E2VWxQNVNPMlZsNVJoWVZ4azhuZkU1Nlp1ZkpjODBY?=
 =?utf-8?B?TDlVSG5MVlgzMmZHZmcvS0J5YjhmVGJTcWlzQnY4Vmt2UUZsOERxbkxBVmZO?=
 =?utf-8?B?ZmxiWG5CR1p4YWt6NStZdDF4bU1ER1VlVW9BTHZobVJicEVZSUZoeE1xd09J?=
 =?utf-8?B?UEdXZ0pLZUlxeHB2eUpSSWpnV1M0c3RhdjZ1aFBKdnEwRnNnMCtvUm5tRkxu?=
 =?utf-8?B?OWN0dHJvbnBaejJNZGt0VlZPcWpFRGd4K21mcXNYNjQ2OW5xRnZKNTdCaHdT?=
 =?utf-8?B?TTcxQUdlbnkyd0JLaE9keUpPcnMyQVYvYmtSNG53cytyWEtXMGFhMW95WjVm?=
 =?utf-8?B?V3poNS9uRVl6T3N3QjVXWGIwSzlUSElNZGp6ZVRhbnVhalExMTlUbjZPaGUx?=
 =?utf-8?B?S1MzY253TVUrTlA3TWZNTCsxOGx2WDhtYVBFS2JFU3FpS0tJUEdtYys3UUc4?=
 =?utf-8?B?RFdHS0UxZ0VIQmJJMk94WkdtTTdTTDZ5Z0N3RjkrOUdad0lJMXgwWFg2dVVU?=
 =?utf-8?B?RlIrK2xMQ2p1dU5aeG15b3o4MUlGT2Y3L3Njd1Ztc01yRlY1LytjMjVMT3VL?=
 =?utf-8?B?SkUrZkl4S3g5U0drZmdGdXBxazROQmRQeGE0MjA4VDY4cHNnL2JRSkdBK0dJ?=
 =?utf-8?B?Vk5kdVlQT3hBRUNLVFRqM1BpSDdwaklmeENmWlFDd25saDl2VGtiWm5LTkJQ?=
 =?utf-8?B?ZTBPbHhRZWFjdkZZcTl6ZFdvMXprWk5KdXJIdTdJUlFRQm9HQzIrZnhURXVk?=
 =?utf-8?B?NHVlNHhQWkhqUEV4VkdydmxhREs4eG1laWVtYnRHdnJpbFoyQVRxUkgvdDR5?=
 =?utf-8?B?RUpyc3Fzd1NpaUlGaGZuYytOblFxdWU2UllKeW5xRC9hUWhsejMwTGtPWmpW?=
 =?utf-8?B?cWFlT2tYd1hYSnRTTWtqaVBjNldWWU04c01KRGpLTGZHZ1pPcE5KdFpsd2VN?=
 =?utf-8?B?ZE9HWDg1c2lJNjlDNmxiRDdaNFQvemFuaTV6QTZON2F6WTJBRnZJQnVlNHRm?=
 =?utf-8?B?OUk0UzViT2QvWlpHdmNnNUU1bHd3ampXb3UrV05lSkVqMjZLaGlZS1JEZVBv?=
 =?utf-8?B?VjI2bWNibmMrd2NrRmQ2am14UWNKV1lJcnNjdXNkWTljZEhHOXQvWmkrcFBE?=
 =?utf-8?B?TGttKzJkTlJNZk1SY21HUzAyUWFDb0N2U3ZqRmZTbWowaXVIZFRQbDRpVmxs?=
 =?utf-8?B?V01tMWppZmMwR045aTVwNTd2S0pGOWIwTXBBUXFMR3Rad3cyRjdqNFZoai80?=
 =?utf-8?B?WHpaNU1HR1lMNE5xcXhLN0JkK0xlNWw1YTR2QjRvUy94VWVXM096SE1xNmZs?=
 =?utf-8?B?YWV2VVRDOSt1QzVxS3NqY2RoSzFIWFpsdVcwVFc2dHJnT1ErUTl0NWRIY2tU?=
 =?utf-8?B?VmFZSTNvVlZIRnBZWHRXOTBEUkVuYUg1MkN0NVRMRWF2dDIyRzRua2lDNlVF?=
 =?utf-8?Q?yWxkLuwpbHNlxf2XbZNevBb3i?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8313.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd159489-b319-410b-565f-08dcb2f6e861
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2024 13:27:50.9787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +WqSb7FtR602KFv/+hrNAjLNdOf1q4ddNnPabvMupLMrzhjitVzqmyqALGYOC6TmmKWv79kvETKdBMlTAZ9k6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7295
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEludGVsLXdpcmVkLWxhbiA8
aW50ZWwtd2lyZWQtbGFuLWJvdW5jZXNAb3N1b3NsLm9yZz4gT24gQmVoYWxmIE9mIEt1cnQNCj5L
YW56ZW5iYWNoDQo+U2VudDogRnJpZGF5LCBKdWx5IDEyLCAyMDI0IDI6MjYgUE0NCj5UbzogTmd1
eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS2l0c3plbCwgUHJ6
ZW15c2xhdw0KPjxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0KPkNjOiBKZXNwZXIgRGFu
Z2FhcmQgQnJvdWVyIDxoYXdrQGtlcm5lbC5vcmc+OyBEYW5pZWwgQm9ya21hbm4NCj48ZGFuaWVs
QGlvZ2VhcmJveC5uZXQ+OyBTcmlyYW0gWWFnbmFyYW1hbg0KPjxzcmlyYW0ueWFnbmFyYW1hbkBl
cmljc3Nvbi5jb20+OyBSaWNoYXJkIENvY2hyYW4NCj48cmljaGFyZGNvY2hyYW5AZ21haWwuY29t
PjsgS3VydCBLYW56ZW5iYWNoIDxrdXJ0QGxpbnV0cm9uaXguZGU+OyBKb2huDQo+RmFzdGFiZW5k
IDxqb2huLmZhc3RhYmVuZEBnbWFpbC5jb20+OyBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBrZXJu
ZWwub3JnPjsNCj5CZW5qYW1pbiBTdGVpbmtlIDxiZW5qYW1pbi5zdGVpbmtlQHdva3MtYXVkaW8u
Y29tPjsgRXJpYyBEdW1hemV0DQo+PGVkdW1hemV0QGdvb2dsZS5jb20+OyBTcmlyYW0gWWFnbmFy
YW1hbg0KPjxzcmlyYW0ueWFnbmFyYW1hbkBlc3QudGVjaD47IGludGVsLXdpcmVkLWxhbkBsaXN0
cy5vc3Vvc2wub3JnOw0KPm5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IEpha3ViIEtpY2luc2tpIDxr
dWJhQGtlcm5lbC5vcmc+Ow0KPmJwZkB2Z2VyLmtlcm5lbC5vcmc7IFBhb2xvIEFiZW5pIDxwYWJl
bmlAcmVkaGF0LmNvbT47IERhdmlkIFMuIE1pbGxlcg0KPjxkYXZlbUBkYXZlbWxvZnQubmV0Pjsg
U2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPg0KPlN1Ympl
Y3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBpd2wtbmV4dCB2NSAzLzRdIGlnYjogYWRkIEFG
X1hEUCB6ZXJvLWNvcHkNCj5SeCBzdXBwb3J0DQo+DQo+RnJvbTogU3JpcmFtIFlhZ25hcmFtYW4g
PHNyaXJhbS55YWduYXJhbWFuQGVzdC50ZWNoPg0KPg0KPkFkZCBzdXBwb3J0IGZvciBBRl9YRFAg
emVyby1jb3B5IHJlY2VpdmUgcGF0aC4NCj4NCj5XaGVuIEFGX1hEUCB6ZXJvLWNvcHkgaXMgZW5h
YmxlZCwgdGhlIHJ4IGJ1ZmZlcnMgYXJlIGFsbG9jYXRlZCBmcm9tIHRoZSB4c2sNCj5idWZmIHBv
b2wgdXNpbmcgaWdiX2FsbG9jX3J4X2J1ZmZlcnNfemMuDQo+DQo+VXNlIHhza19wb29sX2dldF9y
eF9mcmFtZV9zaXplIHRvIHNldCBTUlJDVEwgcnggYnVmIHNpemUgd2hlbiB6ZXJvLWNvcHkgaXMN
Cj5lbmFibGVkLg0KPg0KPlNpZ25lZC1vZmYtYnk6IFNyaXJhbSBZYWduYXJhbWFuIDxzcmlyYW0u
eWFnbmFyYW1hbkBlc3QudGVjaD4NCj5bS3VydDogUG9ydCB0byB2Ni4xMCBhbmQgcHJvdmlkZSBu
YXBpX2lkIGZvciB4ZHBfcnhxX2luZm9fcmVnKCldDQo+U2lnbmVkLW9mZi1ieTogS3VydCBLYW56
ZW5iYWNoIDxrdXJ0QGxpbnV0cm9uaXguZGU+DQo+LS0tDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2lnYi9pZ2IuaCAgICAgIHwgICA0ICsNCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50
ZWwvaWdiL2lnYl9tYWluLmMgfCAgOTUgKysrKysrKystLS0NCj5kcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pZ2IvaWdiX3hzay5jICB8IDI2MQ0KPisrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLQ0KPiAzIGZpbGVzIGNoYW5nZWQsIDMzNyBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMo
LSkNCj4NCg0KVGVzdGVkLWJ5OiBDaGFuZGFuIEt1bWFyIFJvdXQgPGNoYW5kYW54LnJvdXRAaW50
ZWwuY29tPiAoQSBDb250aW5nZW50IFdvcmtlciBhdCBJbnRlbCkNCg==

