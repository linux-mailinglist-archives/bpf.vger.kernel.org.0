Return-Path: <bpf+bounces-36288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422C6945EB5
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 15:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACB8AB216F8
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 13:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F901E4865;
	Fri,  2 Aug 2024 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eYCl6liT"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B31C1E4841;
	Fri,  2 Aug 2024 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722605413; cv=fail; b=f7B91xfieEyAVHBAqOQ2rSozuX0ba+tmCWQnv9faRAa/Zxm2fWU0e3XIt4wt20JVLB8376tZSKqy+pP9lcbNtJH2uf3igqcd0QCUMZFT2gbHhApfiX0eamy9RzTvZs5jN3gS3e332jZFKHX186ROzH0dEUvVMrifJsseLl7cRAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722605413; c=relaxed/simple;
	bh=f5QyBXZpgkuFFIm3dNKwRWRMz37fWB9/hUZP/0sQWCQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RY2ejS4jV+3MgJRYHa7xvR7XtEknu9jAdte7ZfFR0mbRWIASv6xWROgMIoxB5dv//Ng+lSefBw7wjkx9BmXS2ZTreBVNi2IjsMNNKztotW8gTGSEArqgye6EEFRwkKmTI4R/VItOs1VsP3VfW/kATy6BPddXZrDi+VDXs3hsw6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eYCl6liT; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722605411; x=1754141411;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f5QyBXZpgkuFFIm3dNKwRWRMz37fWB9/hUZP/0sQWCQ=;
  b=eYCl6liTmqsMZHG/0nbA+WDIEffN/Y5R7uA8vJE6f3pZXKQ85E+bLeer
   ZDeWcffShtowiOz+u8TWaeemIku0atGyzO0ZMR+zXqqN+CVSOD0Dr9PCC
   eKHkCNC9MZ5CrNhkTdjGphbmUvC7b6SZ7QAPKKUYihXRUI+P/v1rPEhxs
   olYQYKxolbgT6npFrjovLTHD/qfBLV+lYOTaHf7vuwlV6sR3SrpT+pAiq
   Kn8EUDmUgE3qDuL2V61dqQw85duwOO9fD5gpRKkYeJ/9S3D3iiMy3KpDi
   QSCAv7X5J6Ti7DyFTuK6zHyeIDvhj/9pyjGfeZkJ/bATtzZeuW3qPRTTn
   Q==;
X-CSE-ConnectionGUID: 8ZRJomVbREm8AFM8dHg0fw==
X-CSE-MsgGUID: fmFW5NE9T8ezmShGkoEFFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="20741821"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="20741821"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 06:30:10 -0700
X-CSE-ConnectionGUID: 1CGd3YkVQtaVaCRwcg5P9w==
X-CSE-MsgGUID: YZdSz//QT8mJ6myzTqsH8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="55340441"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Aug 2024 06:30:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 2 Aug 2024 06:30:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 2 Aug 2024 06:30:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 2 Aug 2024 06:30:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXuKJtPeo5BQn+yKHW8qK1J4lCcH8bg2J00JePAPTwFVrvq6G87Q/7G5TGXD4PPaUVxROej/zwxXBrXxal+QTHV6LZpIc9kOLw5uzCXWTKchT0zUlfYtmGbYDTQ26UEsDdJvyS//ooxDT8wxWph+5ZazWvAjUVqTC9XQ/hYrgbZq2VI6wj2l+FwQb4uM41AAoafM4oC6LXK3neHYXwZZkoWjTvH/6w5KQ5gk5xARaoSVhyO62Jr1ZwL9ZkvTfiBuDDhvVnLLRWeJCJlh/pVwstC7Oq/259uSkAaW31ocm3oW1iF2GEeL3pz6J8NBQnG9WRpfXWoYhfuo/YGWfb+IHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5QyBXZpgkuFFIm3dNKwRWRMz37fWB9/hUZP/0sQWCQ=;
 b=FqKc55TNjAYLT3f4Y1FsoeZr53f53iJGswmVVbprFk1d7lWc7t1XY/dsYshUh2+CAGaaFC2BBQDP5EDdh6s4WrI7HtbMK+DWZT10KPoLnO+9oUt1YbBI7q2kHZupeyZJpD6h2RNs0zY1Jh+WuNnd8UmLbD0ayzT3LeeHljEnwkV+e50gD54fzbsEDopPmFpx8H+fQBPl1J4Td7GgF7LWAyzE9sTNFawLvSzkhRrZjPXEmqQdLpcob6cbA+oBp/JKiJsj36iGB0/t5SVsNYCEy+WqQGvtutSvhZK7xs0rt451vcaUDNu1bKbW9o1YcAuOo5kViHHIWyS1Mq15mnSI6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8313.namprd11.prod.outlook.com (2603:10b6:610:17c::15)
 by IA1PR11MB7295.namprd11.prod.outlook.com (2603:10b6:208:428::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 2 Aug
 2024 13:30:05 +0000
Received: from CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::3251:fc84:d223:79a3]) by CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::3251:fc84:d223:79a3%5]) with mapi id 15.20.7807.026; Fri, 2 Aug 2024
 13:30:05 +0000
From: "Rout, ChandanX" <chandanx.rout@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: Jesper Dangaard Brouer <hawk@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
	Richard Cochran <richardcochran@gmail.com>, John Fastabend
	<john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, "Benjamin
 Steinke" <benjamin.steinke@woks-audio.com>, Eric Dumazet
	<edumazet@google.com>, Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, "Kuruvinakunnel, George"
	<george.kuruvinakunnel@intel.com>, "Pandey, Atul" <atul.pandey@intel.com>,
	"Nagraj, Shravan" <shravan.nagraj@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 4/4] igb: add AF_XDP
 zero-copy Tx support
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 4/4] igb: add AF_XDP
 zero-copy Tx support
Thread-Index: AQHa1DlkGSddFzTNZU+4iEPR2gkn8bIUF1XQ
Date: Fri, 2 Aug 2024 13:30:04 +0000
Message-ID: <CH3PR11MB8313EED88D00D6B0F5FAC662EAB32@CH3PR11MB8313.namprd11.prod.outlook.com>
References: <20240711-b4-igb_zero_copy-v5-0-f3f455113b11@linutronix.de>
 <20240711-b4-igb_zero_copy-v5-4-f3f455113b11@linutronix.de>
In-Reply-To: <20240711-b4-igb_zero_copy-v5-4-f3f455113b11@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8313:EE_|IA1PR11MB7295:EE_
x-ms-office365-filtering-correlation-id: 518b5a2e-3e0c-40c4-c641-08dcb2f7383c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NndXbi9vZ3I2ODFvWUtHVmVYaWZPQ1AweEhzS1JMM1o1UUpJVGRFckZ4QTMy?=
 =?utf-8?B?SGFIWThrQnpTK2s4alViNHMwbSt5SlY4VGk2NWtKcjgrNVF6eUYwNnJXWWxU?=
 =?utf-8?B?b240QTRaaDlWK0p6SDd5d1BvT0k0emM2eVlxSGYwRldXYitjcGliVllVZStm?=
 =?utf-8?B?WGVEUldIMUswY05vZUplTGNFeHY5Vk8yMCtNWTlaamR0aHlOVnVIZnd5ZHNE?=
 =?utf-8?B?c0N0VHJ0MVBGbDM4N0ZTM2c2VFVQdGRlcXVpRmlOb2ljRFJGMHd1ZFVaRWs4?=
 =?utf-8?B?TWJjdkdJcW5ORkN0QllITWN5RDVXTUpMdlM4VXZSWm9RUEgrd1FRWEd0WFlQ?=
 =?utf-8?B?Tys1NnAyMjZBT0JtamE1NGV2b2JnamJtbXlJVFFVYjJCMGp6OVVPU2xiT0JJ?=
 =?utf-8?B?Sk4xcWFvaElPTXREd0pEWmwyVGkyTXdpenozeUZXQXgwQkVzd3NmUjA4cGpq?=
 =?utf-8?B?L3BJbEg3dHJXRnFKSmFtL0daK3JWN0M2Rlk2QWxsbGtnZHFjQ1hBRS9VbU1F?=
 =?utf-8?B?aE00VlM3N2c5ckIwVXQwcWs3WXFJT013bTFOdFExeEdiTFNySEV0d1JIREdq?=
 =?utf-8?B?dDErY0NWQ3JjOVhQd0QrMTB4MU1Ba1Y4Z2t3UkVZeENPRFpJM2RHamY2S1J5?=
 =?utf-8?B?SDJobFprSENCNVhrVDVPdEhuMXZnNVV0clY4RW5HWEsva2FoN2R3SExDdU12?=
 =?utf-8?B?c2RMTkRkWWxadGFCNkZLQkx6SlQ0UlFmYUdUTDVGQ1QwRnBHZDFTaGdMNmJz?=
 =?utf-8?B?RXFNRVhmK2gxS1BVZnFzK0w3WjJPS2RYdHQybkxJbnBmUnBKbndKU1BTMG1l?=
 =?utf-8?B?NlJqY1Z1ZXpHNHkwNGl5VVQzcXJ2SW14ZE0rY1N4U0xSVDVzcnhURTBKSVZj?=
 =?utf-8?B?US9hMGk1U1Bjc09WL1k3dGZnTG81Z20rZzYvdkc2RWVjWFpDMGM0L1lLdEV6?=
 =?utf-8?B?Z2hSclViNEhXaUdGWHMyZHRXTkh6RG5ZOEJBcU5OeW5iUURXREp6L0FYclVJ?=
 =?utf-8?B?dnFDTzZ4R0xoM1FyWndEVlFIN055cTJ6d1Y3bDVvOGVidDgvUUxma0ppRFVh?=
 =?utf-8?B?MDZhL1hSUTZLY1FiQ3hvRUZZMmFxNjQ1RVdxK3Z2ME1Wb1IrT0NSMlZjdUp0?=
 =?utf-8?B?Qk5nbEFxZnphV3k2U1E0OXVVOEVLcm9ISDlISkd5NnJ2dGVzUFMvZ3VXaHFl?=
 =?utf-8?B?WGY3bmhDNEx0SElBZk16aFQyQmtEWEQ5dWlyYVhkSlNvd1NEcXFRdmVSSVU4?=
 =?utf-8?B?eFhhU294REJyRFBSMFo0d0Nlb0EwM2FnYS9Hc3hrUEt6SEdVbUtBdEJBT1hP?=
 =?utf-8?B?elF5bE03WTRXUVp3ZkRTWnpXald4Zk9QQ0p0Zjg0SEFsSWtDUGFsTVMvbWY2?=
 =?utf-8?B?Wm95aTNQNVpEbjdYb2VKeGUvNUJXS1V5d2U1Tnd0S2lyZXIrRXh1L0FtQWFt?=
 =?utf-8?B?bUpoSVdkbGhEN3pnam91SDBhWFVJR0xlTUkzSTRMOWMrc3ppUjBxQTFBd3FB?=
 =?utf-8?B?dVp0Y2dhcTJqdkJkT2oxdkQzVU5idDEvQ2g5TGF4QjRCR0daSXA2WjIwZEk1?=
 =?utf-8?B?US9RMUJ1Q2I3UzNGWk1sVERGajlHTkR1YU5VZnlib2M3elNQL3ZhNzYxL1dP?=
 =?utf-8?B?R05tN3dNK2YxVGUvVWZJaElsd0o5MFdLRlg1S2YxWGU1cW0yMEtKQ2pERlNu?=
 =?utf-8?B?aE1WeTZuY04wNnNNNnJtbHNrV2dWQndFUmh1Smh2ay81OVNVRHNtYjdWWnRH?=
 =?utf-8?B?cDV1cy9WTmlDdzhEd2Z5T0NBcDloUCtHVEh0REZzT1FSL3AxYW1CT2lqY2s4?=
 =?utf-8?B?ZVdEQ1pTUW9aakMrNWl3T3lWRUIxUU4rdmlVMHlTMmwyak5NL0RnWXV1WFA5?=
 =?utf-8?B?VFlKV3MxcTZNQzgxY0poK0NOQzJla0prdVRxYmNwN21pUnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8313.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3RnQSt3WkRnMGxpZG9seCtFV2N6TVJTZEN5RDhqMEtGN09OUDE5V3JmTnVZ?=
 =?utf-8?B?ajV6TUQzUWlrQUR3d0t4NmkvZG9WVWRPMWVnYnhjYm1LMktLUUdFenhtUGdw?=
 =?utf-8?B?TDlnSFFnRFpEY1FvQ3FORWo5SEdDemRnZWE4aEkxQVB0TUNwdFBQUlhORzhP?=
 =?utf-8?B?RkhkRFJ2T2x1SXAvZ092N3BnZW1DQkxhQVVmNTNhcjRNRlN6M0JLdzFYNmtu?=
 =?utf-8?B?alBnQ04zZ2dqRlNGV2syWmMxLzAwdWhkZzh4c0lJZzhIQXZqdjRLSUYvUFR5?=
 =?utf-8?B?K1hKOHhZQjliUWVFOGhtUzRqQkxZaURmVTJ3TzU2OW1pcG1HZXpGN3NaQmxa?=
 =?utf-8?B?QVd1REtwZUkyWjAyNGFKaWdqSlJuRlVZMFdKc01FUUdwSHdJM2g2NFMvVm1M?=
 =?utf-8?B?T1A5MUtXbGlSM2NpSGpCQmcvZVYvQ1IrbDdwanZWZUJsQzZkQ3pVcFN0cEFl?=
 =?utf-8?B?QWlaWVQwb1dpVWJrWXlhVTFoRVdqNWdGTEUzTCtxcnlNR0dzWkdKNld6cWlG?=
 =?utf-8?B?amk1cFQ0VEhXckE5OHJWTGMxbUNlcFRCaTJWbzlzZ3NPdXg4K1JTcHVMVDQw?=
 =?utf-8?B?bkJLM1dzZWROSUUySzJWWUFQNSt0Vk1aakZUYk1vcjM1TjdjVGJtV0wwYU5B?=
 =?utf-8?B?TDFRNjU1OGdiTVpRZkEvUnlnQkpTVUFOM1FMdTlySXZGV0owdlZ3SXFOY3pD?=
 =?utf-8?B?ZTQ5NmhFdWR4bU5OZjVoSHJFcGtaZXBiV3RQUStIV29QUXR5c28zWEhjSXQy?=
 =?utf-8?B?b2xrdDMyNUNOS3pLdm1hazAyQkRNRHlWOVhnck01T000VGE3T1lFVWZsd1dJ?=
 =?utf-8?B?QmJIQmQwRDJmSDZiei9LbUNvQm1seTFHZ0dJeFd1ZURXYjA0MUZiRXJiQkFv?=
 =?utf-8?B?VnNtTDJMOUQvQ1JsVzNxU3djSGFLWmJYcWhiRWRscTlVRkJGZjl0MTNIL1d2?=
 =?utf-8?B?K09TVWhQQXJFeUVtTU5lejNwWVVNd0ZtT2J6OGdRM3RBSkZTcEtIOW9yUWVJ?=
 =?utf-8?B?cjVycHR2eC9GNnVsaVEzRVBPMTBtTWVGSm9ZenJLSzVCSnh2NHduQW9hMlhm?=
 =?utf-8?B?bitrbEc5WENkY3Y0OUlhNHJLa05icFFVYld1bklkSGVKUkVBK0xNQ0h0dUJz?=
 =?utf-8?B?WTRCNWdXMzN5MlFNb3hsbzA3N1pURjZpeklISC9qVVZWaXVoSWxrdVN4Zndo?=
 =?utf-8?B?WjJFMW5JdU5WL3Z5SGNncmp5Y0tWaHJoUDNaUFJsZzR6ZU53eG1pd0phOEM0?=
 =?utf-8?B?ZjNSY2kyM1hhdEJ2bHl6amNFS1dKMUVacUtVSGhoOUx0b1JkYVJSa3hFZktq?=
 =?utf-8?B?RWNUVjZBWXBINHd5djRJcFlkcFJ2RTh5RXFFQWpiODY5azV1dEx3QWdEVm9V?=
 =?utf-8?B?L2xsSE1kelFPSEVUN29rU2RDQ0pUZFIyQTNibTE3UEk0M1dIVXlTN2JJaFRu?=
 =?utf-8?B?NG1UaW9RMGFKZ0Z4djk3aGVMY2FDa2NxR2JCaVJMNTI5bi91YUlBKzl2N2pL?=
 =?utf-8?B?OU1vdEZiemx6UEU2UXVNWWdROUVWODdoaXNaQUd1ak4yMGozTzdUajBRS1dv?=
 =?utf-8?B?b1RNZEtvKzM2SisrbVp5bjJ0Y2s4a3VlSEJ0WUtlSi9ibzUwSFBsOForWkk3?=
 =?utf-8?B?S3ZXdmxaSE94ZjV5c0o3dUZNRUJXZm1BZ0VaallIeFpGREtGcUhvTFJjTjRD?=
 =?utf-8?B?QnUyejVBbXd3eWJXZnI4eHE3SThMRWF6ZzRkdjlXbFQ3aEs3U1VheFR6RVVt?=
 =?utf-8?B?eEdSUHEzcUNuZWEzd2Q4RFA4dzFsOHVXbjYrQmpMdk9hbTRGdGhsdUx0REpw?=
 =?utf-8?B?bUlnZFo0ZzFpdXUxYXJ2dG1DN2hGWlFLMzVvRDFUWkFJUW9pQVhlM3FUMUJ1?=
 =?utf-8?B?TlFNR1pYWG42R1BzT1JEejkzYkpIc2xGYTFMM1FHT2tiaFFlaG9renlWK2c4?=
 =?utf-8?B?VnlWZmtqVEJucDIzZEw5MkN1QzhYNmdnN3pPd2orZzl2WTlxUlUyN0QzQjBS?=
 =?utf-8?B?dzZreWZVS1pJVEpoQjZNaGI3eUlNT0ZqQm1kU1hTdHNMRWdKd0h1emV5NUJJ?=
 =?utf-8?B?MGVnUFN6MFB2Vkp3TWJMMC9DNGxMQUc4VjBVVWxYK1JGVGtaQm9jY1RUQ2pi?=
 =?utf-8?Q?gispN52P+ZrgjNStRtrRNSw8Q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 518b5a2e-3e0c-40c4-c641-08dcb2f7383c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2024 13:30:04.9347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 55suw70PlWZf2oD3/hvn5pGMuhe+lavy+CsFOjFKU9ktNLbQdGGbSaiypylgxi5wdehwskJ9Xbo5/5phgrVwtA==
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
Y3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBpd2wtbmV4dCB2NSA0LzRdIGlnYjogYWRkIEFG
X1hEUCB6ZXJvLWNvcHkNCj5UeCBzdXBwb3J0DQo+DQo+RnJvbTogU3JpcmFtIFlhZ25hcmFtYW4g
PHNyaXJhbS55YWduYXJhbWFuQGVzdC50ZWNoPg0KPg0KPkFkZCBzdXBwb3J0IGZvciBBRl9YRFAg
emVyby1jb3B5IHRyYW5zbWl0IHBhdGguDQo+DQo+QSBuZXcgVFggYnVmZmVyIHR5cGUgSUdCX1RZ
UEVfWFNLIGlzIGludHJvZHVjZWQgdG8gaW5kaWNhdGUgdGhhdCB0aGUgVHggZnJhbWUNCj53YXMg
YWxsb2NhdGVkIGZyb20gdGhlIHhzayBidWZmIHBvb2wsIHNvIGlnYl9jbGVhbl90eF9yaW5nIGFu
ZCBpZ2JfY2xlYW5fdHhfaXJxDQo+Y2FuIGNsZWFuIHRoZSBidWZmZXJzIGNvcnJlY3RseSBiYXNl
ZCBvbiB0eXBlLg0KPg0KPmlnYl94bWl0X3pjIHBlcmZvcm1zIHRoZSBhY3R1YWwgcGFja2V0IHRy
YW5zbWl0IHdoZW4gQUZfWERQIHplcm8tY29weSBpcw0KPmVuYWJsZWQuIFdlIHNoYXJlIHRoZSBU
WCByaW5nIGJldHdlZW4gc2xvdyBwYXRoLCBYRFAgYW5kIEFGX1hEUCB6ZXJvLWNvcHksDQo+c28g
d2UgdXNlIHRoZSBuZXRkZXYgcXVldWUgbG9jayB0byBlbnN1cmUgbXV0dWFsIGV4Y2x1c2lvbi4N
Cj4NCj5TaWduZWQtb2ZmLWJ5OiBTcmlyYW0gWWFnbmFyYW1hbiA8c3JpcmFtLnlhZ25hcmFtYW5A
ZXN0LnRlY2g+DQo+W0t1cnQ6IFNldCBvbGluZm9fc3RhdHVzIGluIGlnYl94bWl0X3pjKCkgc28g
dGhhdCBmcmFtZXMgYXJlIHRyYW5zbWl0dGVkXQ0KPlNpZ25lZC1vZmYtYnk6IEt1cnQgS2FuemVu
YmFjaCA8a3VydEBsaW51dHJvbml4LmRlPg0KPi0tLQ0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pZ2IvaWdiLmggICAgICB8ICAyICsrDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVs
L2lnYi9pZ2JfbWFpbi5jIHwgNTYNCj4rKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tDQo+
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdiL2lnYl94c2suYyAgfCA1Mw0KPisrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+IDMgZmlsZXMgY2hhbmdlZCwgMTAyIGluc2VydGlvbnMo
KyksIDkgZGVsZXRpb25zKC0pDQo+DQoNClRlc3RlZC1ieTogQ2hhbmRhbiBLdW1hciBSb3V0IDxj
aGFuZGFueC5yb3V0QGludGVsLmNvbT4gKEEgQ29udGluZ2VudCBXb3JrZXIgYXQgSW50ZWwpDQoN
Cg==

