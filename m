Return-Path: <bpf+bounces-48723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D890A0FDC6
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 02:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ED587A069E
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 01:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7038335963;
	Tue, 14 Jan 2025 01:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kS85auso"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5983F1C01;
	Tue, 14 Jan 2025 01:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736816753; cv=fail; b=eliT//9HhmfYKfujLPB51s1cutr6x3Su36DvhMSUgZUTqHhoouzmC+VGW5w3EZh/N/7rodgTHv/wF5Jfqcm4//MNtWu9TiaFFLPdJP0v50Pm571Q/1bHo5fbHV1jIap1vL0TmHHFXVrdx+V+duwf/Lj74xLdSQZb5LN5RnlUlJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736816753; c=relaxed/simple;
	bh=fjRWBcRC3aQbicShXcnLgiYzYEysS5WA06syJ1rcGKQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WmXelaGF3gTR19hoL4aj+P6D4Jnw5HpYahbF/lgT3LXAW5vL7J25Xh6TZtg6VmW+O5CjvTvNir5BMUg7d5ddk1I4WJNyBGSNnh+2B5ZnWAHAANCl4sYi6OuGVAPjNe9IXWbo197+bfOpRP+uWY9Rhl7WHwKKokq6ijz2MDKR3sY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kS85auso; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736816752; x=1768352752;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=fjRWBcRC3aQbicShXcnLgiYzYEysS5WA06syJ1rcGKQ=;
  b=kS85ausoEBHRrtsL7Uy0KMOdfTY+Bue3dorxq5aPZhghkHDUO47wxc6a
   2FTmeBWtp91YKfP/6jnHVUyJkdP///bWZNfXaw/Rgpt7GOgZ2U4VY1WbY
   9WRFaY8UrmFR9t9aVsn4G1RcOpclsNofQ10jywcRVZZf35KB9BqUyOZkL
   X8I8/IUgt2Pc0W+x9wkEQzCys+3M46DP8n/MiGOMEXgfhrh0CchmjJ7EZ
   RUwM4a5staJvJ6C/2Y95i3kLmZzZBg36qVqAuxMO/NErCYfiW4kGWIfFs
   cL5KmetRxrdSMX/iPpvHfuw/S3x7mnzDwXhdgprPsNa2AFP4wGfBIoBDl
   A==;
X-CSE-ConnectionGUID: Vh6F9suVTLm815qvE3Ev+g==
X-CSE-MsgGUID: iE64lG43QBWOVUOtYKQikA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37262188"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="37262188"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 17:05:51 -0800
X-CSE-ConnectionGUID: /cyHWqR1RP6cB/8l9C6aVA==
X-CSE-MsgGUID: EeGp+VfURLezvEcK+d0leg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="105214787"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 17:05:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 17:05:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 17:05:49 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 17:05:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUnuE+H1wnBWN1J6Pd9lT+sGuyg3iSl9S8cV0n5rP4mCw/WHbKwOCGGj9TBhgCd75HRfY72gbdQ1QvE8pxbN//07tatIq/Jfn1ZxyOj7bRbmqsMqvWSF8r5H+uVwqhmiIeGh29ZpWTkdJpnFtJoc+sHJJdKp6IkEhO4fBcGmcJoGokiATDu3+eCyxISdtXtlXyK6wvai9SeH+juvNXaPBxk2FVJyDMTrTA3oQTKU5SlJMHFfoHsF78Xh+YxaxRpopti9yQBSJMTg79yvcM4xo2cDk1+79I0qOFLT13W23YC1lHzoJ7QdFpx8etCOIbzSxbnFQkjZMMD/tZUJhkRffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSBlqUq++die+IH+HsT1odp55OHDchERJyOipCH/YmM=;
 b=Iu4DTCEv/HKLEVoAiDliZjIEdh29Bo0gB9SxFhU7kMtEZLiHfZSo73evzhNybXyaNIiUy6Pw8VYQR26gByb3rBmUu9Vbf0N3w4YHHHhmg5pZpP/i6lg5ztAPgw2vfG7SKmvzkNXrtxU/6oBsw/pULhgc0ukR8i7lY6qfkpxBqeO0dyu8bxC3tQwIlbbDk/nMIG/Ws5xzKCIHS6VDcWnFtS5bCHdSdiNn62IaCuRjbCwAoFHQkIlLNjclPCXou3kLFIPBzmaSLGqvpBkyczDdoRk2TLlw+fjtUns3KSnxMAGUejnaAmnmAQxUaMAeEVmcX5PLJMDzJ+GN4OfoDUfjtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by PH7PR11MB5794.namprd11.prod.outlook.com (2603:10b6:510:131::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Tue, 14 Jan
 2025 01:05:06 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%7]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 01:05:06 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"sdf@google.com" <sdf@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"ast@kernel.org" <ast@kernel.org>
Subject: RE: [RFC] Fix mismatch in if_xdp.h between tools and kernel UAPI
Thread-Topic: [RFC] Fix mismatch in if_xdp.h between tools and kernel UAPI
Thread-Index: AQHbZaHZyIUwRsTzXUyMqTrHTHlmw7MVcWtQ
Date: Tue, 14 Jan 2025 01:05:06 +0000
Message-ID: <PH0PR11MB5830E291DCB6B52EA651B076D8182@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <Z4TjzzB8NSnTy_Wa@linux.ibm.com>
In-Reply-To: <Z4TjzzB8NSnTy_Wa@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|PH7PR11MB5794:EE_
x-ms-office365-filtering-correlation-id: 7a929ae8-1aa3-46ca-a692-08dd34377c1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?m12KD2qt85guyxHhw19hzLSEFosXOXGeQDvEKw+0H5PYQKzSB8LlLMhrf0MI?=
 =?us-ascii?Q?qT1BjZgCu6cpdwpeLdPjODfbb1mFRiQJoeSX9OqCY/Y+dgXph8TSVSZcIznO?=
 =?us-ascii?Q?zdMOiC8/smajfXVoujLwUOzuWtnLcXtI1GmG8Hl6LXDzBlw2KZOwQmNUta/t?=
 =?us-ascii?Q?OAZ1JQIAm87aX5ukdZtMm5TWjs39KN4WdRzQaHz/pdctkugmmyvcLQxsJkSm?=
 =?us-ascii?Q?gZugky0aN/0bjVPVF7zU2mS6era0y/7Yia0yZW3vocP/armYNHdR5RrlOoRt?=
 =?us-ascii?Q?JYYpWDtkX3YQeZPn6fjLyC1WCmrMPZZpDRmsWhgcMDPNc+EupdM55CNjZ1Li?=
 =?us-ascii?Q?HUXrk04OaqSL420YivQbPh83645XJxKwCxs42AMPNxF/vafvWaW+ff4IVpT0?=
 =?us-ascii?Q?yIelkNtqEdbpb/RQur0IsIo21eH9/OK/zVv9wLYUUCzaSBrCxCgBhT4kdzn0?=
 =?us-ascii?Q?Eg6ATCvRHKDvnMan43v9IGvZLOxW6h2bYhNlvRVEyaOV84WuIrY8WlimtOJD?=
 =?us-ascii?Q?XkaucYp1nlq/8mUOco+bzbEcWNRf1kmWWrlqH0EHLWGnP1NZDGEwP7lsUZFd?=
 =?us-ascii?Q?6gaPmsMGzMhRCEVJNts4mhzP7a4Uv8DHMQecC6ijljdpCexS5MSOOUCA9DeM?=
 =?us-ascii?Q?9/ylz7jJhTjo/GB0oPhFo3En8AlXdOxTzKod3aZD10DXBIxg5J3NgJ8cHHJn?=
 =?us-ascii?Q?ZZp8CnRNREaMmQ566If4c+2mrcUxRLFb51FqjV9JiSE/054fkoyuovYu6W4g?=
 =?us-ascii?Q?lPe6kind7YumBWe63hqCqTjTgVd2Dgv2aJfaTAnQ1v4b81SmgGizcAKgKq4s?=
 =?us-ascii?Q?eHF7Vzam4mwnp5PmyTW1vGmgmdOKJS5wvI7OGklReC0JYmiPkbMnJgW3UjUo?=
 =?us-ascii?Q?5tJKtdQYDMm3VP7jzOrIEIjOm4BHSDW6kmGvbJ5/mQ4hgVon8HcUwU6cExRK?=
 =?us-ascii?Q?wm43k+ib8qcWHzCozd+wD3Q3iRVSm+ulR+E2BEXkte5Fc9kAk62A9pwes9qV?=
 =?us-ascii?Q?FNUYxaxe6OyB2UwPC7G5pgIlVt8o0HY2mtTQE24fuToS7725MHdDY/PyzZuz?=
 =?us-ascii?Q?oq9tkBkGCYidAsXEr8p/r8ZN3sT8pFix4VzvjArCHJN2OM6LVhA0dFKBnZn8?=
 =?us-ascii?Q?Xz7kgZNIFiRbLu3mIjHV9A40YGOzrUckbKpxoV5gQ28p6imBds8gss97XZn8?=
 =?us-ascii?Q?5ws/PeyGYiMDWuWJCIR1GXGsD0NtvtX9mCi915ttypW2aAw5gGQBURJ9kFBo?=
 =?us-ascii?Q?QvvUrudW7L7YuByS7uWyxFhRGkviOe/biA4g6mF/V1LickEFiFVx7cCl0qGA?=
 =?us-ascii?Q?pwcWJ1jd/W0O9u2IIZtgQXhvLAYE3AkkmC/qWLyC2B55z+p/YEHntdJ8p99p?=
 =?us-ascii?Q?wWy0IXuYvJWx7Aauc1T/uUitnabXdR2p9N9DMlKdnGRJh5rry3vGNbCis2El?=
 =?us-ascii?Q?6EivEcMhCsXMI8clbszCNyy/7WaIMgfi?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xz0JtMnpuQGEfx74LK35OnQddfsxOhjbHSwPyDDRU8Qgso8h17Clbnv8mf1y?=
 =?us-ascii?Q?8AI1/ooaF5S1C1WejAY4G1ydyajlVTZbKNt1lQ/MFI8x2jI1/fxQWB2DxENw?=
 =?us-ascii?Q?FS1xibYPgSezcrdhrCVZuHSAlcxG4J0MkhD+oKR4/IwHlBtKGeh9ByoAbWeH?=
 =?us-ascii?Q?1hPG4Bk953FVTQZYX1SgK2SJv8Zpv4d6mZe7JCZZMDkNFhPyfiDu8oDS1fGa?=
 =?us-ascii?Q?VrRsEBFVL7TWJlWZpwWlhRXBur18A6/YVP0E2HkHn+rKJQGARbi9veQyLAqH?=
 =?us-ascii?Q?BCgoM4EZOBUhB77cgxUzP9w/Cv0pZOXmme55hTO1zJ7BX8xtN+qfAP6woH6I?=
 =?us-ascii?Q?JNNSJFYvPypZWICS+MlDula/E373VZ548J5AZ1HevnRBPdTX23c5XCQa1cOQ?=
 =?us-ascii?Q?nAKB4B5BSRBpE2p73k/xlgE/7v22b4aWXiJbuLCahRIrwuMzGDReP0nw8FEM?=
 =?us-ascii?Q?42afnbqveoaz3bg43PCEqkLiL+lVZjZdaKC9pUo4jmGUN7+iEqLCcpNtJebo?=
 =?us-ascii?Q?zG9nHvGLeI5m6NotXPFIo1M9cwdK55M15BN7y+pVQJLuHamXE9s+AzuruOor?=
 =?us-ascii?Q?EnNo5MLO35I6tIcxTfjcs+0UkFsoYLeXfpOWY8zlrxhAPHAIiFEzDtUl1Skw?=
 =?us-ascii?Q?kfXgcCD2hl2xWeL8m8bR9gh3P3hRdu9aWO0D6H5rXF+GMZLoq1xfvao+/990?=
 =?us-ascii?Q?KudRYqhP/a+CoitBssz/nFnBFMaAq3oqnfuBhqt+BkfhmXhWY27U31eT2FFj?=
 =?us-ascii?Q?KTVgzSkbTynG9E3pUhZZ0inCfStL06my/NDNXxYG2fZZoBkBRr8vlpOf2vNR?=
 =?us-ascii?Q?C4CKNNBX6yhdLF692r95P4nZyzSJQL4O69NmdeyrIcYrToRVCXhz1K8TjTR8?=
 =?us-ascii?Q?ASe5Ms2Vemayv6bFnMfnLvcQDa+DCWlDka7i7kG2ZK5Iui+zln8tQiYH15FV?=
 =?us-ascii?Q?Kkmj0I0iY98WKhymVWaO52ATwkxi6VkSpa/4IVppcICjNh1n9d4NUAcHk/M9?=
 =?us-ascii?Q?EBO69yOAL2XCjeQEipopZVfM5ZajgrmUaPkiGM56kbcvRlpMbiGbIH4dph3M?=
 =?us-ascii?Q?pH3AxOnNAs6+2T9ChouWy+TNU6mz5mbotw8LOyRP4EgWzYnqTws8Z5Wkosil?=
 =?us-ascii?Q?B4tBLs+/qfw6e51uhKXrsCoc0OUeD4cpxoMgPYQMwAlZM4TMFhOf3zw98nNO?=
 =?us-ascii?Q?LXq4n0xieuYEHwQEJb+QQx6eo0uwAJSx7OJGerK8euOWAYK8tsRxMETZ3ZtB?=
 =?us-ascii?Q?T/ibKcf0zFyIBnPL3Sjl9cvpNtI5WDosfUf8upyFlEGffipv+DS3fi+Lo/BD?=
 =?us-ascii?Q?KyUqqHvmcHl9q3aZEqSaUghJRl8ha/BZTvgGfRzck/I4k2YngZZGE4ZZx43P?=
 =?us-ascii?Q?rD65N2MzfdumvEyArdLZvN/lIJn0+2RoqSyPRKqFoSwi8v83ZtBtPBYXnkqF?=
 =?us-ascii?Q?eU668W3JpOnvhg3696eQk9bF3rqbDcVbjUFV+qR2L7/AfUehNhCyfgCESuiQ?=
 =?us-ascii?Q?wEk3AsAJOWbzO6EzMSzvA1PnausVOdLReWjnhMi4SSS8YThEq2DwU4czF2KX?=
 =?us-ascii?Q?C4T5cPqhFRuqfentqAEOp+fLau/ZUX0LCeM9QMHS/JQoRwdFNrd0GqYWeW6g?=
 =?us-ascii?Q?Gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a929ae8-1aa3-46ca-a692-08dd34377c1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 01:05:06.6440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJ8Em93yTfxXb9BepdwbeBqfIDVMetkWeaONLSQlrOl+/fhMNKdBetH3wdJ4Uf7SWIXZnMbx+EMybSiA+2MWw8RewdH4WRvjmqvvEkbZIUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5794
X-OriginatorOrg: intel.com

On Monday, January 13, 2025 5:59 PM, Vishal Chourasia <vishalc@linux.ibm.co=
m> wrote:
>Hello all,
>
>While building libbpf, I encountered the following warning:
>
>Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs =
from
>latest version at 'include/uapi/linux/if_xdp.h'
>
>A brief diff shows discrepancies in the doc comments regarding `union
>xsk_tx_metadata` vs. `struct xsk_tx_metadata` references. Below is the
>relevant snippet:
>$ diff tools/include/uapi/linux/if_xdp.h include/uapi/linux/if_xdp.h
>120c120
><  * field of union xsk_tx_metadata.
>---
>>  * field of struct xsk_tx_metadata.
>125c125
><  * are communicated via csum_start and csum_offset fields of union
>---
>>  * are communicated via csum_start and csum_offset fields of struct
>
>This patch aligns the documentation in
>`tools/include/uapi/linux/if_xdp.h` with the kernel UAPI header in
>`include/uapi/linux/if_xdp.h` to remove the mismatch and associated
>warning.
>
>Please consider applying this fix. Let me know if there are any
>questions or if additional changes are needed.
>
>vishal.c

Hi Vishal. C,

Thank you for bringing this to our attention. The changes look good to me.
Could you please confirm if you will be submitting this patch formally,
or do you need assistance to submit it?

Thanks & Regards,
Siang

>
>diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/=
if_xdp.h
>index 2f082b01ff228..42ec5ddaab8dc 100644
>--- a/tools/include/uapi/linux/if_xdp.h
>+++ b/tools/include/uapi/linux/if_xdp.h
>@@ -117,12 +117,12 @@ struct xdp_options {
>        ((1ULL << XSK_UNALIGNED_BUF_OFFSET_SHIFT) - 1)
>
> /* Request transmit timestamp. Upon completion, put it into tx_timestamp
>- * field of union xsk_tx_metadata.
>+ * field of struct xsk_tx_metadata.
>  */
> #define XDP_TXMD_FLAGS_TIMESTAMP               (1 << 0)
>
> /* Request transmit checksum offload. Checksum start position and offset
>- * are communicated via csum_start and csum_offset fields of union
>+ * are communicated via csum_start and csum_offset fields of struct
>  * xsk_tx_metadata.
>  */
> #define XDP_TXMD_FLAGS_CHECKSUM                        (1 << 1)


