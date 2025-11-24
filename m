Return-Path: <bpf+bounces-75332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D850EC803B5
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 12:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 38BFB34458C
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 11:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DD82FD69E;
	Mon, 24 Nov 2025 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IX4FDkqV"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9082FB99F;
	Mon, 24 Nov 2025 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763984241; cv=fail; b=BxVo3GA7JcdnhrcZU8Z/e7rbVN2YnH64K8KczK0b1fsowNfBf/CsdBFR8VJXqZcg5Uo1WuxioiUn0mPqFE+zj8+/QuSlRkTKd0QZ3sV90bauDwZb7/qyQNeaALoc0ScI/DFZGn4iCFMxY0sfZhKaYC2chK8us8dRl6sTIP99X2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763984241; c=relaxed/simple;
	bh=fkrXYh+S5b6SRXRUhxGKyLsJY+B5oWIwsZ1QCr2MMUA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oMsqsHb+Q0jdXaeXOResyc4pLfJ5BQ4po9IktcXOL3Iw420FmpJxT5NL5lMGseALQYz+W2xxW82bS6Rb8dRTed19ZVUv+rEhlhz1BAZuYcqTgX19kzuW9tq15XM/zE0FpF/GMQQMpkwEnWqtBGT6pKYJN2sdUcray+w7i+aEEBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IX4FDkqV; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763984240; x=1795520240;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fkrXYh+S5b6SRXRUhxGKyLsJY+B5oWIwsZ1QCr2MMUA=;
  b=IX4FDkqVUtgbsagm8s81jLBpVVZv/sPOSKUt35/BJcJVJxSrVzSgY6WG
   3tfMrm25CHpupESPfXnrU2tW5ERARiA5RA2TWmJv8jx2x4l84Y/etw5oO
   TIDtXpjIOjnmtT8g9cAAVd3sq79xGsUQBu18RasbVUYwCuWkAqnEppzXW
   bQsVlRXcQuGxFVB/4JJI8LBaBu+49msHOiwHv+vd1bJdJ6uvuM+4AF6ac
   Y6RoVPVtlt0WtUFn4jMQAcD+7xVqU7ZpZORj43n87M1EuKLkAG7FaHd23
   GF1YEFt1OHBbEpqBACxlSGSqSD2lPrFisjhgtH3QXz7qEma/VK+LB4UbH
   A==;
X-CSE-ConnectionGUID: OLByKNMXSP+Ty2mttu5HEQ==
X-CSE-MsgGUID: YM68CqZWQwyexRGrF0vtYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="83369090"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="83369090"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 03:37:19 -0800
X-CSE-ConnectionGUID: qjrw/phiQlKdKbIqseWAuQ==
X-CSE-MsgGUID: QjYtuT7ISDW4437cSqC3dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="197435323"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 03:37:19 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 24 Nov 2025 03:37:18 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 24 Nov 2025 03:37:18 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.3) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 24 Nov 2025 03:37:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PesCdH+Sc4RqcUK4dnNC2RkBQuMb700891Rf5ExUw4IHMMtYu1jqmqZ/ozaM1hZlmZ/hyjZsAel5DzHsQAiswGaXNbWqLHFzVGmr3pYteE0TZA5vaAtcvBJ5a7RhNv2tC89y4OEhsy+T7Mud8azaEJ+xo31HYK3SvRePAT8P57mf/S8+4uAMPw9Dv3gEqG8DxjrFrtbbxbnlzr/KBOkAPcyKzSsOnHQOTMhxTz7MXYOo37Nugq+PL7uIm+4nSRjMirjhmLfJTbfiZmalhdHAjUirahQGqOVKVino0l42ggLJNKJVhIN1STkOGN+2SCpkNWnJHgxpdlS+3YGE+ez5Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkrXYh+S5b6SRXRUhxGKyLsJY+B5oWIwsZ1QCr2MMUA=;
 b=gykg5F+5McicliFCE7muX3Y2CL3AjMhslNp/U3Fd7ezt+gQvcJFXBJ9KsmPMhBKQcW1izJA36+QZCWF91Le3aFeVmPOuF0XHwcf3Qqwpc/H1Ey6+KVmXsGZyte0IDyzRH5PnMe7onOSypK2wDH1qwabYlcipuQodLWZrekpEg/ToU4g/VlcEgaykxbfk2fl2F/hX8Ae++4RAAO6l+P23+9La0+z2c81HiAEjt0Yr9xv8qxjbM/oeB7nU+VmI+Ax/nIu/jq2N+jylQ0PBWrjeAmvO7bprdLn2lk66ZsY/ncFN2OKzS582KEtq4vDaReKw4gU2rN5hgss3gG0PSRsWfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ2PR11MB8538.namprd11.prod.outlook.com (2603:10b6:a03:578::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Mon, 24 Nov
 2025 11:37:15 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 11:37:15 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: YiFei Zhu <zhuyifei@google.com>
CC: Mina Almasry <almasrymina@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Richard Cochran
	<richardcochran@gmail.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v1] idpf: export RX hardware
 timestamping information to XDP
Thread-Topic: [Intel-wired-lan] [PATCH net-next v1] idpf: export RX hardware
 timestamping information to XDP
Thread-Index: AQHcW7mOEioV57xnd0yuKi6/nWj2urUBgcBAgAAneQCAAAx5IA==
Date: Mon, 24 Nov 2025 11:37:15 +0000
Message-ID: <IA3PR11MB89864658386102E62BCF1DCBE5D0A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251122140839.3922015-1-almasrymina@google.com>
 <DS4PPF7551E6552ECCF95AE9C177DEF07F8E5D0A@DS4PPF7551E6552.namprd11.prod.outlook.com>
 <CAA-VZP=mvGBOhkc-hmCsmP=uN_qb5ZG1dwhbO2cOyrAYS0wPDw@mail.gmail.com>
In-Reply-To: <CAA-VZP=mvGBOhkc-hmCsmP=uN_qb5ZG1dwhbO2cOyrAYS0wPDw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ2PR11MB8538:EE_
x-ms-office365-filtering-correlation-id: b6cf0caa-d9fe-4e43-5bc9-08de2b4dd157
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?d2ZqZjVKdWV2QjI5N3JkT25tekJVN1FlV096TGRYUFh5RVU4dTFuQlJNQnEr?=
 =?utf-8?B?Tmp4dmVFN3NzdWhYN1dDVUFVekZDeitkVnRtdE4yWUxJaTBLOUdxc0g4QUM0?=
 =?utf-8?B?VWROR2pKd1UzaWhzdVU1ODZvTXIxUWZJVzZZSEtOejdrMXRDU0RwYWtmN1gy?=
 =?utf-8?B?cHpINUNjWEgxNW5idUFzbDdaV1NUZ3lrKzhjTHZqK3FhbTY5SHphRkRsVnRs?=
 =?utf-8?B?VU5MdHQ1a1N2MFdSQnN4NWc4WGQ2N1Y2SlJGekk0N3Q3cWQ0NG1DeUQ3d3Bt?=
 =?utf-8?B?clNZMWVjVnVjblFTWjdsMkxJNEl0VzF2VlNheTlqc3ZvL3ZrYkVKeXQwQWN2?=
 =?utf-8?B?aTdMV09NajFhcHhtSEg4a0hHN1J1MHZLS2ZVWmFwVFQxV3pWNUpLTUhsV3Bi?=
 =?utf-8?B?V3BEaHRnbDNDc0phYUdKOUFsT3FPaGlOK2NRVVZyL0hZYnYxVGVEL2J4Tm04?=
 =?utf-8?B?Yy9GKzBNUU9vMjJ6VmJsNWlVUUhDM2JqVU84UG14U3dvWStWYjFRdjBrR0tq?=
 =?utf-8?B?ckNCRldHU2dZMDhoSnRMOTlpdU5xdkxEdXpHU204RlVwaTNBMTY4Y09OYmtV?=
 =?utf-8?B?d3lQMk16aUVzbnc1L0hVRHFqbHJ0Z2I0NnpkN0ZSZElzNlE1Y2pONHNteExW?=
 =?utf-8?B?N3lYdVZJN0VoblNCUVVNVHlhbmF4RU90R0lJVkVqeThteEVqQ0FQRFpFYmVT?=
 =?utf-8?B?dHY1d1Vka01WL2hqdDZ3cjhWb1NaaE1HVHMwYUxyL2lueHpodXc1OXA3YWNq?=
 =?utf-8?B?MjBrUEJ4SG9YaG5NVVY3NUZuVU9LYk9JRXoyRllLUkpHMHU0YmdoTjJJakVN?=
 =?utf-8?B?Z2NiajlXdnd2WXk1dDNtaVcvN2ZvV29kQnhTVTdIaTFGT3RRdlhYVHA1c2wy?=
 =?utf-8?B?SmxWSkJSdEMwWWxaV2RSWkovY0c3eW1kUDAzNk1VRUljeWJ4bGlnVXErNktn?=
 =?utf-8?B?cXhER1JEaUpIU1FOTDh4UEx2S3JQUURyaWUyb0dtemxXa2xDcTVXcjlhSXF0?=
 =?utf-8?B?TTlrYXA0K3BqY0VMbTZkL2ZqeVQ5UUowWGlFNUdPL293NVZ1SDFKcDEwaWh4?=
 =?utf-8?B?SlRueDA0b2MwaDJITGozbUJyZHY3eVNKK3VhT3A1TGU1cWpUWlJGSWdEN0w2?=
 =?utf-8?B?cXNtSjVTclZsY0s5UTF0ZE01amJPUkVtK0FJMGJaSGVUUW16K3g1UTU5empB?=
 =?utf-8?B?TzJJSFlyRVdiK1N6b0w2anJEMVg0MUZGWVR0SlNYa09zR1B1WDRmUXY3SVM5?=
 =?utf-8?B?bUFtWlRTbUdDV0Q1R0x1UkpHc3BjWVpsTWQ3dFdldWNaZXZKZ29JNVBmZHlF?=
 =?utf-8?B?ZVZOeUxHZ0NBSnpHbFU0RGZqWkpTcW5nNGhyOUFJdmZjU1FxdUFnRm5CdHNC?=
 =?utf-8?B?VWxqeG9CT1hJY2tpMUlzTGZhcksrU1NkaGtMSUNORjdHemQwajZWNnlPK1dD?=
 =?utf-8?B?aG05by9uSkU0U0hxOGhvMnlPeDJtUFZJdmJqNXJqcWdmK3dTNlNjV2FzQUJr?=
 =?utf-8?B?dWNlMkNOM001Q1kzRW4zNnJRbVNYY2hsL0RMMkxrS1BQTkRlZEFENGZ4cmxv?=
 =?utf-8?B?VGZ3SHRYczZXZm93cFpDV2lYbGRNNGNLR3JzRUl2ZnVQTEhsa1Iwa0tBOTNl?=
 =?utf-8?B?K2l1VFNKTmRMTzVYWU53VG5pT0g2ZlFkZm10REhtY05ZQU1WNEI4bGhRb2Zu?=
 =?utf-8?B?SXovK1NkTyszZ0gxZmxuYzdiY2IxeUFMWi9nTnc4Ykp3cncvOVl1M1gyZ2NH?=
 =?utf-8?B?MXVHSWtuZnIvalVRaERLbHVjelQ4T2RVdjFudUpiWlFQakxxcnplWmh5TVVL?=
 =?utf-8?B?S1pKZE84Y0VQVGNQeURCSXAxSXlMZ0JmeHhOWEpFby83SjNtaW12b29hbGIv?=
 =?utf-8?B?c3V2ZVlmMkNLd1FCSC9nQk82cUlqMXF0ODNsb2JlSEJMaGovcmVCdW9MM3B5?=
 =?utf-8?B?d2VkL0Zjb0xZYVRFNW5Ec0sweGVuaFNhUWxvb2djWGova3pQaWxFYkNtUUJo?=
 =?utf-8?B?UlJmQmdPL3FBbTdxZ203U2dxMTVPOXNGUHZ2bU1ja3loN090U3o2dTRMWTJU?=
 =?utf-8?Q?kY+mSp?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWNIRnZOd0RML1hhT0dBU25SSmloYlhYNDY5eWE1NWRwVTZGbjdLSGk3dm10?=
 =?utf-8?B?UEVNa3IybEJ2YTl3QnJocUVFZWlEYW5yZkFPeWFMMkVKNVgyUUxFRFBwNTA0?=
 =?utf-8?B?Nk1iTEd4RHR6U25xUXltbEV2TEtINE96aWhaK1hHUXlmSWxTTUpzY21UUVR4?=
 =?utf-8?B?K3FoOU8vdHdnd2JLdE9URXE4UkkvVU5SZjdDcjN6QXovSDU2Q0Z1NlJyWUlV?=
 =?utf-8?B?Q2FoeE5SUUVaSG9TeXprd0daTFF0aTI2SjQwdm0yckE2N1FJbmVsbHJiK3Ns?=
 =?utf-8?B?QlJXclpDT1Q1WVRaT2JaLzBBbjN4Nk1iZzdma1RvVDVVN3BwVERIWWtBeWJG?=
 =?utf-8?B?Z29naFFqL3FnU1drNndhOVY2SXlBQmFUZERaSERLZzJTMDUwOWFVTHpaWFls?=
 =?utf-8?B?L1R2Ym5YdVVVU0xjdDRBSGFISlVHWVlXV0Jld1hEQjg3UTFiYlQxY1ZpM29D?=
 =?utf-8?B?YWR3cjNCdTRjV2lDRXRtaG0vYzIxd1c4MFR4R0NnR3R1YlBsUFZHcy93ajdM?=
 =?utf-8?B?OW5sTE44TUhXc01qdGxRUUdsU2Z2VzdlL1ljMkZ1MHdZNytDOGNTUW9VUXlr?=
 =?utf-8?B?NXBtdjNwSForeE9KMDdGSE82UUVvV0VBVXpFQlcxemJhLzBNdi82TVRFSk9U?=
 =?utf-8?B?UnBXR0hhSEhIbnp3S2tDMlN2Z3BwdzRHeW1MdVNYV2tqMDhYT3hienpjUjlM?=
 =?utf-8?B?dlBsV2FZOExIbFFYbmViMWduQTdCOG1XZVZMWjhaS3lPNTdaa3lXaEpyTHpH?=
 =?utf-8?B?amJiaTlCWU00a1lOckV0c3dNQWF4VDNYRGI2VnZqTjRnYkIxeFhJSEhOTjdD?=
 =?utf-8?B?blZXWXB2dnN5V1RTaGM5bDl4WjgyL1lzNmtJUEhkNVgzeHRYRmsyK0dlR29z?=
 =?utf-8?B?d3FPVWVkU3lhNm4vUis1WHZJMUowY0ViQTRtZ3Z1RnU5eDhOWTRvdGFNOHYy?=
 =?utf-8?B?K05OaFRkQVZITS84RWRERkM2MXBvS3ZWQXpIbmFWTGY3OXJPenI3NWQ4WE5F?=
 =?utf-8?B?WWZUNHdha3M3bVFEZ1NCdjNSckNGOSsrUGhQWkplVmNLSVNBc3doRFc3R0Q0?=
 =?utf-8?B?MlMzeFJRb0NDbFdqUS9NQzNmL1JKKzJNSDkvb3NYWll1a291SFVIYTdpM2Q3?=
 =?utf-8?B?alpXbW5td21uWnc4cDJqellVakswUmlMZitLamlCOFRaZHE3Q2ROTEg3TFQ0?=
 =?utf-8?B?RXZOaXlYNjdwQ25MMEFNSlRjRXZMTUl0R2RlWXdUNEpDUEtxQTdKRkZyNS9k?=
 =?utf-8?B?a0FlTENrTHp0RTh2UWVIY0VUclJkNmJNWVVPbS9XbTZ4MXc2aitoZUhVSGNn?=
 =?utf-8?B?aHdNMXZid00rTzVkdldZWXE1Ny8vVEN1N0xYY3c3aDRURFZwanFFQ3l2R0lO?=
 =?utf-8?B?VjZvN2pjVzBLUzkvYVYxUFppT1BnRUw2Umdxc3NUU1BiY3pVZVZPMUZqcmVU?=
 =?utf-8?B?MmRnUFJhb2ZqaW9EUm5GUTJEMWpUV2xIT1N5UW5TWExTVWFXV2tjaEppMU5r?=
 =?utf-8?B?UEZ0cE4zNEZqeDBnSFlJRndnNUpNNzhDWUY2QWJkQ2FvNGliM0NHS0h1NU9C?=
 =?utf-8?B?bVRMbnRyaFB4KzVvS2h1ejZvczVXVVJJR285QnBiUXJJKzNjSEgzcnExd0tQ?=
 =?utf-8?B?cW9iMG4rbEt1OVc5QmE0S2V4Vkw5aldsK2tEMjd3Z3ZLUFJaeVplSzM1TTBF?=
 =?utf-8?B?N1BEWW5SdmdEbm9PeFRXNU1VaGRsd3pHN0kzWXlPUFpObXpTTkJFV1V3Qml3?=
 =?utf-8?B?RE1MOXBHOVZMZlR1bmx6dkRkL1ErNkFqeVczdVlLWVJKb3R4K1Y5bGtYdTZl?=
 =?utf-8?B?LzJNL1Jqck9KZVJYR2dReTJSVjhmMkhvRUVhdGVGa3ZBWmR4YTh3TDF1ZDVC?=
 =?utf-8?B?blhyTVdSZmlyQWx2b0RHdE81MnNiZHVNMEFISjJtbFhDYm9tdU5vekJhaWV2?=
 =?utf-8?B?MXZpenZFUkMrMDdDbkQzZ2svYWE2emFsN21vaTNTM1U3VzI1a3RSTWhPa1do?=
 =?utf-8?B?c1ZTUWhHdHJ1QzBEc1k4NkdOZGpBMGZRakRMaUpJQzV5UXJEbWhEYVlzenRD?=
 =?utf-8?B?cVhXMDgzV1hMQU5Yckk3MGdRMENTNFI1SU9NMW5XRnZtQ0hJaDFreXM1elk4?=
 =?utf-8?B?bUl6bm1VaFJ0ckpBUnMralVTQmVyc3BSckUwblF3TXROS3VDU3dBNEV3U3I0?=
 =?utf-8?B?eEE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cf0caa-d9fe-4e43-5bc9-08de2b4dd157
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 11:37:15.7502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eKnrW2z+A5h0jCKcTdNsylYJWtLzYGnKBvfyDNWpZywCTZClLBVg4wFuLPz0uuQfGpzuA37TXKnI6SvRhqcIMnc3lHljAWB2AjRKYhjE2C4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8538
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWWlGZWkgWmh1IDx6aHV5
aWZlaUBnb29nbGUuY29tPg0KPiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDI0LCAyMDI1IDExOjUy
IEFNDQo+IFRvOiBMb2t0aW9ub3YsIEFsZWtzYW5kciA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRl
bC5jb20+DQo+IENjOiBNaW5hIEFsbWFzcnkgPGFsbWFzcnltaW5hQGdvb2dsZS5jb20+OyBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnOw0KPiBicGZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBBbGV4ZWkgU3Rhcm92b2l0b3YNCj4gPGFzdEBrZXJuZWwub3JnPjsg
RGFuaWVsIEJvcmttYW5uIDxkYW5pZWxAaW9nZWFyYm94Lm5ldD47IERhdmlkIFMuDQo+IE1pbGxl
ciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+
OyBKZXNwZXINCj4gRGFuZ2FhcmQgQnJvdWVyIDxoYXdrQGtlcm5lbC5vcmc+OyBKb2huIEZhc3Rh
YmVuZA0KPiA8am9obi5mYXN0YWJlbmRAZ21haWwuY29tPjsgU3RhbmlzbGF2IEZvbWljaGV2IDxz
ZGZAZm9taWNoZXYubWU+Ow0KPiBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5sLm5ndXllbkBp
bnRlbC5jb20+OyBLaXRzemVsLCBQcnplbXlzbGF3DQo+IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50
ZWwuY29tPjsgQW5kcmV3IEx1bm4gPGFuZHJldytuZXRkZXZAbHVubi5jaD47DQo+IEVyaWMgRHVt
YXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNv
bT47DQo+IExvYmFraW4sIEFsZWtzYW5kZXIgPGFsZWtzYW5kZXIubG9iYWtpbkBpbnRlbC5jb20+
OyBSaWNoYXJkIENvY2hyYW4NCj4gPHJpY2hhcmRjb2NocmFuQGdtYWlsLmNvbT47IGludGVsLXdp
cmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+IFN1YmplY3Q6IFJlOiBbSW50ZWwtd2lyZWQtbGFu
XSBbUEFUQ0ggbmV0LW5leHQgdjFdIGlkcGY6IGV4cG9ydCBSWA0KPiBoYXJkd2FyZSB0aW1lc3Rh
bXBpbmcgaW5mb3JtYXRpb24gdG8gWERQDQo+IA0KPiBPbiBNb24sIE5vdiAyNCwgMjAyNSBhdCAx
MjozM+KAr0FNIExva3Rpb25vdiwgQWxla3NhbmRyDQo+IDxhbGVrc2FuZHIubG9rdGlvbm92QGlu
dGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+ID4gRnJvbTogSW50ZWwtd2lyZWQtbGFuIDxpbnRlbC13aXJlZC1sYW4tYm91
bmNlc0Bvc3Vvc2wub3JnPiBPbg0KPiBCZWhhbGYNCj4gPiA+IE9mIE1pbmEgQWxtYXNyeQ0KPiA+
ID4gU2VudDogU2F0dXJkYXksIE5vdmVtYmVyIDIyLCAyMDI1IDM6MDkgUE0NCj4gPiA+IFRvOiBu
ZXRkZXZAdmdlci5rZXJuZWwub3JnOyBicGZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gPiA+
IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IENjOiBZaUZlaSBaaHUgPHpodXlpZmVpQGdv
b2dsZS5jb20+OyBBbGV4ZWkgU3Rhcm92b2l0b3YNCj4gPiA+IDxhc3RAa2VybmVsLm9yZz47IERh
bmllbCBCb3JrbWFubiA8ZGFuaWVsQGlvZ2VhcmJveC5uZXQ+OyBEYXZpZCBTLg0KPiA+ID4gTWls
bGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9y
Zz47DQo+ID4gPiBKZXNwZXIgRGFuZ2FhcmQgQnJvdWVyIDxoYXdrQGtlcm5lbC5vcmc+OyBKb2hu
IEZhc3RhYmVuZA0KPiA+ID4gPGpvaG4uZmFzdGFiZW5kQGdtYWlsLmNvbT47IFN0YW5pc2xhdiBG
b21pY2hldiA8c2RmQGZvbWljaGV2Lm1lPjsNCj4gPiA+IE5ndXllbiwgQW50aG9ueSBMIDxhbnRo
b255Lmwubmd1eWVuQGludGVsLmNvbT47IEtpdHN6ZWwsDQo+IFByemVteXNsYXcNCj4gPiA+IDxw
cnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPjsgQW5kcmV3IEx1bm4NCj4gPGFuZHJldytuZXRk
ZXZAbHVubi5jaD47DQo+ID4gPiBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBQ
YW9sbyBBYmVuaQ0KPiA8cGFiZW5pQHJlZGhhdC5jb20+Ow0KPiA+ID4gTG9iYWtpbiwgQWxla3Nh
bmRlciA8YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNvbT47IFJpY2hhcmQNCj4gQ29jaHJhbg0K
PiA+ID4gPHJpY2hhcmRjb2NocmFuQGdtYWlsLmNvbT47IGludGVsLXdpcmVkLWxhbkBsaXN0cy5v
c3Vvc2wub3JnOyBNaW5hDQo+ID4gPiBBbG1hc3J5IDxhbG1hc3J5bWluYUBnb29nbGUuY29tPg0K
PiA+ID4gU3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIG5ldC1uZXh0IHYxXSBpZHBm
OiBleHBvcnQgUlgNCj4gPiA+IGhhcmR3YXJlIHRpbWVzdGFtcGluZyBpbmZvcm1hdGlvbiB0byBY
RFANCj4gPiA+DQo+ID4gPiBGcm9tOiBZaUZlaSBaaHUgPHpodXlpZmVpQGdvb2dsZS5jb20+DQo+
ID4gPg0KPiA+ID4gVGhlIGxvZ2ljIGlzIHNpbWlsYXIgdG8gaWRwZl9yeF9od3RzdGFtcCwgYnV0
IHRoZSBkYXRhIGlzIGV4cG9ydGVkDQo+ID4gPiBhcyBhIEJQRiBrZnVuYyBpbnN0ZWFkIG9mIGFw
cGVuZGVkIHRvIGFuIHNrYi4NCj4gPiA+DQo+ID4gPiBBIGlkcGZfcXVldWVfaGFzKFBUUCwgcnhx
KSBjb25kaXRpb24gaXMgYWRkZWQgdG8gY2hlY2sgdGhlIHF1ZXVlDQo+ID4gPiBzdXBwb3J0cyBQ
VFAgc2ltaWxhciB0byBpZHBmX3J4X3Byb2Nlc3Nfc2tiX2ZpZWxkcy4NCj4gPiA+DQo+ID4gPiBD
YzogaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmcNCj4gPiA+DQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBZaUZlaSBaaHUgPHpodXlpZmVpQGdvb2dsZS5jb20+DQo+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBNaW5hIEFsbWFzcnkgPGFsbWFzcnltaW5hQGdvb2dsZS5jb20+DQo+ID4gPiAtLS0NCj4g
PiA+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL3hkcC5jIHwgMjcNCj4gPiA+ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNl
cnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2lkcGYveGRwLmMNCj4gPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRw
Zi94ZHAuYw0KPiA+ID4gaW5kZXggMjFjZTI1YjA1NjdmLi44NTAzODljYTY2YjYgMTAwNjQ0DQo+
ID4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL3hkcC5jDQo+ID4gPiAr
KysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL3hkcC5jDQo+ID4gPiBAQCAtMiw2
ICsyLDcgQEANCj4gPiA+ICAvKiBDb3B5cmlnaHQgKEMpIDIwMjUgSW50ZWwgQ29ycG9yYXRpb24g
Ki8NCj4gPiA+DQo+ID4gPiAgI2luY2x1ZGUgImlkcGYuaCINCj4gPiA+ICsjaW5jbHVkZSAiaWRw
Zl9wdHAuaCINCj4gPiA+ICAjaW5jbHVkZSAiaWRwZl92aXJ0Y2hubC5oIg0KPiA+ID4gICNpbmNs
dWRlICJ4ZHAuaCINCj4gPiA+ICAjaW5jbHVkZSAieHNrLmgiDQo+ID4gPiBAQCAtMzY5LDYgKzM3
MCwzMSBAQCBpbnQgaWRwZl94ZHBfeG1pdChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCBpbnQNCj4g
PiA+IG4sIHN0cnVjdCB4ZHBfZnJhbWUgKipmcmFtZXMsDQo+ID4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaWRwZl94ZHBfdHhfZmluYWxpemUpOyAgfQ0KPiA+ID4NCj4g
PiA+ICtzdGF0aWMgaW50IGlkcGZfeGRwbW9fcnhfdGltZXN0YW1wKGNvbnN0IHN0cnVjdCB4ZHBf
bWQgKmN0eCwgdTY0DQo+ID4gPiArKnRpbWVzdGFtcCkgew0KPiA+ID4gKyAgICAgY29uc3Qgc3Ry
dWN0IHZpcnRjaG5sMl9yeF9mbGV4X2Rlc2NfYWR2X25pY18zICpyeF9kZXNjOw0KPiA+ID4gKyAg
ICAgY29uc3Qgc3RydWN0IGxpYmV0aF94ZHBfYnVmZiAqeGRwID0gKHR5cGVvZih4ZHApKWN0eDsN
Cj4gPiA+ICsgICAgIGNvbnN0IHN0cnVjdCBpZHBmX3J4X3F1ZXVlICpyeHE7DQo+ID4gPiArICAg
ICB1NjQgY2FjaGVkX3RpbWUsIHRzX25zOw0KPiA+ID4gKyAgICAgdTMyIHRzX2hpZ2g7DQo+ID4g
PiArDQo+ID4gPiArICAgICByeF9kZXNjID0geGRwLT5kZXNjOw0KPiA+ID4gKyAgICAgcnhxID0g
bGliZXRoX3hkcF9idWZmX3RvX3JxKHhkcCwgdHlwZW9mKCpyeHEpLCB4ZHBfcnhxKTsNCj4gPiA+
ICsNCj4gPiA+ICsgICAgIGlmICghaWRwZl9xdWV1ZV9oYXMoUFRQLCByeHEpKQ0KPiA+ID4gKyAg
ICAgICAgICAgICByZXR1cm4gLUVOT0RBVEE7DQo+ID4gPiArICAgICBpZiAoIShyeF9kZXNjLT50
c19sb3cgJiBWSVJUQ0hOTDJfUlhfRkxFWF9UU1RBTVBfVkFMSUQpKQ0KPiA+ID4gKyAgICAgICAg
ICAgICByZXR1cm4gLUVOT0RBVEE7DQo+ID4gUlggZmxleCBkZXNjIGZpZWxkcyBhcmUgbGl0dGxl
4oCRZW5kaWFuLg0KPiA+IFlvdSBhbHJlYWR5IGNvbnZlcnQgdHNfaGlnaCB3aXRoIGxlMzJfdG9f
Y3B1KCksIGJ1dCB0ZXN0IHRzX2xvdw0KPiBkaXJlY3RseSBhZ2FpbnN0IHRoZSBtYXNrLg0KPiA+
IE9uIGJpZ+KAkWVuZGlhbiB0aGlzIGNhbiBtaXNkZXRlY3QgdGhlIGJpdCBhbmQgc3B1cmlvdXNs
eSByZXR1cm4gLQ0KPiBFTk9EQVRBLg0KPiA+IFBsZWFzZSBjb252ZXJ0IHRzX2xvdyB0byBob3N0
IG9yZGVyIGJlZm9yZSB0aGUgYml0IHRlc3QuDQo+ID4gU2VlIGV4aXN0aW5nIElEUEYvSUNFIHBh
dHRlcm5zIHdoZXJlIGRlc2NyaXB0b3Igd29yZHMgYXJlDQo+IGxlWFhfdG9fY3B1KCnigJFjb252
ZXJ0ZWQgcHJpb3IgdG8gRklFTERfR0VUKCkgLyBiaXQgY2hlY2tzLg0KPiA+IEFsc28sIHBlciB0
aGUgWERQIFJYIG1ldGFkYXRhIGtmdW5jIGRvY3MsIC1FTk9EQVRBIG11c3QgcmVmbGVjdCB0cnVl
DQo+IGFic2VuY2Ugb2YgcGVy4oCRcGFja2V0IG1ldGFkYXRhOyBlbmRpYW5uZXNz4oCRY29ycmVj
dCB0ZXN0aW5nIGlzIHJlcXVpcmVkDQo+IHRvIHVwaG9sZCB0aGUgc2VtYW50aWMuDQo+IA0KPiBU
aGUgbG9naWMgaXMgY29waWVkIGFzIHZlcmJhdGltIGZyb20gaWRwZl9yeF9od3RzdGFtcDoNCj4g
DQo+IHN0YXRpYyB2b2lkDQo+IGlkcGZfcnhfaHd0c3RhbXAoY29uc3Qgc3RydWN0IGlkcGZfcnhf
cXVldWUgKnJ4cSwNCj4gICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgdmlydGNobmwyX3J4
X2ZsZXhfZGVzY19hZHZfbmljXzMNCj4gKnJ4X2Rlc2MsDQo+ICAgICAgICAgICAgICAgICAgc3Ry
dWN0IHNrX2J1ZmYgKnNrYikNCj4gew0KPiAgICAgICAgIHU2NCBjYWNoZWRfdGltZSwgdHNfbnM7
DQo+ICAgICAgICAgdTMyIHRzX2hpZ2g7DQo+IA0KPiAgICAgICAgIGlmICghKHJ4X2Rlc2MtPnRz
X2xvdyAmIFZJUlRDSE5MMl9SWF9GTEVYX1RTVEFNUF9WQUxJRCkpDQo+ICAgICAgICAgICAgICAg
ICByZXR1cm47DQo+IA0KPiAgICAgICAgIGNhY2hlZF90aW1lID0gUkVBRF9PTkNFKHJ4cS0+Y2Fj
aGVkX3BoY190aW1lKTsNCj4gDQo+ICAgICAgICAgdHNfaGlnaCA9IGxlMzJfdG9fY3B1KHJ4X2Rl
c2MtPnRzX2hpZ2gpOw0KPiAgICAgICAgIHRzX25zID0gaWRwZl9wdHBfdHN0YW1wX2V4dGVuZF8z
MmJfdG9fNjRiKGNhY2hlZF90aW1lLA0KPiB0c19oaWdoKTsgWy4uLl0NCj4gDQo+IEkgYXNzdW1l
IHRoYXQgaXMgaW5jb3JyZWN0IGFuZCB3b3VsZCBuZWVkIHRvIGJlIGZpeGVkIHRvbz8NCj4gDQpJ
IHRoaW5rIG11c3QgYmUgZml4ZWQuDQoNCldpdGggdGhlIGJlc3QgcmVnYXJkcw0KQWxleA0KDQo+
IFlpRmVpIFpodQ0KDQoNCi4uLg0K

