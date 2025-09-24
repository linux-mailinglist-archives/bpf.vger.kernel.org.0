Return-Path: <bpf+bounces-69506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8A3B984D4
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 07:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C2D3A387B
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 05:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0455D23BF91;
	Wed, 24 Sep 2025 05:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENW3/D30"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C4421FF4C;
	Wed, 24 Sep 2025 05:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758693007; cv=fail; b=fGKl2sCtSb0awGbfAr4H1AyxvNhZWVKo/HcpJ7f19wk4bZVlqXlLDqENZJJKc+vMahkZ/4SVHGV2ji9r+oiWieR6Cw3ypQFV6jwUMUf0CMGISHEDMpwGJ0/exv/v1sdii9KwpYHneJuO1I/dmZaldHD8VPlaLUD8DPJmKi/LhRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758693007; c=relaxed/simple;
	bh=A37QmJaBvye4+3QSY/HTAoke1mblLgsQoSM4LWF/cmI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OTz2HV2VU34sS7pfpy9ERKM+eYNu56rxjSuHE0JUTUImu818+atYuUjSC+fJkWltW0bZyQWg5UP43C1QvCb+8qGrkLAidsW5fGcimThwina3Bu2O+UFXP1SVv2yqColTgdofd1mHmualzEfhdDC0xgDEAI8X1l59MM5x22/lmxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENW3/D30; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758693006; x=1790229006;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A37QmJaBvye4+3QSY/HTAoke1mblLgsQoSM4LWF/cmI=;
  b=ENW3/D30GNr3eXouapqRZcvLN/r713H1nUw25JWsGWYNPO6MOgKlDMS1
   XW0iS5t0Xww6YZ/1LdIfFBothxSRkBRLv1Vs4m83LWG1aef4cdMer4skd
   E5ezEXWddT5VBp74MXIeq6YOmB6CS+XMX7JwWrKenEj5Edi7arvWgZOMd
   mP8sGP0D5Ve1+rERfqpYQ6irv+I2YAfRvk8kIPON6NdJtQ4wpj9Tx0FmJ
   wLFruO4xG3J788gi//kpv3Dgx3vsMXf7MBBvFIxo1ge7m4vvR+/La3PdE
   aX65cquifvXA6ObysD7K3CjJQ3iYYRa2eeVvkJPp8uesRTES1lb6PmmgI
   w==;
X-CSE-ConnectionGUID: PhpBR7WITRSekf0FZkjc/w==
X-CSE-MsgGUID: JTGz9W1USI+0y4gYT5iUjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="48547375"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="48547375"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 22:50:05 -0700
X-CSE-ConnectionGUID: YrvMd8cKTImC8Z1gGcNSZw==
X-CSE-MsgGUID: mmw0unKaQkC7W/29pQMFUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="176779886"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 22:50:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 23 Sep 2025 22:50:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 23 Sep 2025 22:50:02 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 22:49:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XESjSNpd/R4VsfYkMVIzBoBHAuYb3cVFv1omqnFxLalHxYX3anDwf2wOoKGxItlPXTvdP2TYyJlBbZ/gDXHUeAy6wW9yREFOe5MLbyGpizkNmmnGyMqu/xECx9cGIIy4L5Al5lLTJghqHM/lTo9FT3xeoLmHwcI7dC5IMmndsxUEfvh8X8vgL5AzfHXplh6WDsoSkEhWrUCpFh4qsSPuuSgDSfQ7fb1AOeI9WCyZrO25E6Wv9eL45YxURMqLNVZ/zpfXqLSqph3eWlvPnRBbjfozU5ixHRCl1/DY0MT7LhgRZgDRvdVDonHoVLrrkELFEvsYxKctHYRWh2ONGVqv/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WdCvkvHMNZcKT2DCe1YYJYq9rIOuJTGTQAY3OeXKBc=;
 b=dgzq2c7jIH2HWGTSh2gTUKhQ5y7dP5Hhqwu7m2aYcFbYZAG/jNweLi45CT79pQj/IPqUVqrX3JC5H7fJ+SML5csagXyiXaJiSGM0s8hWV3QKFkYNvf4D5nNtQ4Br6Gvd/pIUT+LDAH415Lpbeo60Ztghm115vtVio/DH9kma8cDOJ4DNglSGAlSAR5WlI1Uo85oCYkvQr4gIYzKxRpIHz/zh3bE2CLE+uQWOHrm6nY39sGmtttxNHKhtEvBlzk7k61jkO0jhHvZp0jq5W4oJsIow3Tn0XTx/OS0EOdWsw0lRoI8k5og5Vxtia1nNip6Gcgd14jbjrnOI8MQ1QVJp8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) by
 DS0PR11MB9502.namprd11.prod.outlook.com (2603:10b6:8:295::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.20; Wed, 24 Sep 2025 05:49:52 +0000
Received: from DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425]) by DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425%7]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 05:49:52 +0000
From: "R, Ramu" <ramu.r@intel.com>
To: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Kubiak, Michal"
	<michal.kubiak@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Simon
 Horman" <horms@kernel.org>, NXNE CNSE OSDT ITP Upstreaming
	<nxne.cnse.osdt.itp.upstreaming@intel.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 3/5] idpf: implement XSk xmit
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 3/5] idpf: implement XSk xmit
Thread-Index: AQHcIzh6uvvI8RWxrU2WDautA93dCrSggQcAgAFmMHA=
Date: Wed, 24 Sep 2025 05:49:52 +0000
Message-ID: <DM4PR11MB645563F1FAA13275576E2420981CA@DM4PR11MB6455.namprd11.prod.outlook.com>
References: <20250911162233.1238034-1-aleksander.lobakin@intel.com>
 <20250911162233.1238034-4-aleksander.lobakin@intel.com>
 <PH0PR11MB501396D4B46250A8D3D88869961DA@PH0PR11MB5013.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB501396D4B46250A8D3D88869961DA@PH0PR11MB5013.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6455:EE_|DS0PR11MB9502:EE_
x-ms-office365-filtering-correlation-id: 2343f173-e359-4036-fe72-08ddfb2e2e79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?u8wnY3SFEKO9PGlRWz92dYVEX3wLoWQ6FrCuGXEd36PYTWItF/vZNzHBnHlZ?=
 =?us-ascii?Q?iB6h52vDF33PeWAgCl/hOeL9ryroQDFBvk09nFANlEs9oY+PRRlHDLR8QGFW?=
 =?us-ascii?Q?ENNGFNZW4D2GJbRhJUZ68sSXOoVq0rX9a36PxTuHhGHNb65KNvRZI4KE6Zys?=
 =?us-ascii?Q?6pHVjxvTVYHwb6Q6D0nRqPgWDhVgBW5GJSvaXw6fBs6yHPD+803kRyRUcpyK?=
 =?us-ascii?Q?oO5m/+9YyP/kHHLcAwrdXqxEToAlgkBBvVziIzv2U1ov0z3L+Gy7WBOK/1NW?=
 =?us-ascii?Q?vbmBDc9zKkl9eBtewrFhxjoRnlSIX8i5ZwfPXNMcacywyM1YiCmbApyCKFn5?=
 =?us-ascii?Q?kAaPn2FktQLDIlXvmlBTgJnEmrZX12WKLntb/FtPg4zcGLzeOq6xm4T2Ij7B?=
 =?us-ascii?Q?Bm4bOxtZxK+W3KIZxAbjxNIeX9p/6WmlFTvhLfyA7fr+ex8qwGsmIH0zTUYz?=
 =?us-ascii?Q?0kxX0PaDMQqJ0C5yxEN2ucfRH8WBW1H8BTqdBdTeKYyNeGyKXrWJF8s9TjIa?=
 =?us-ascii?Q?YYyWf3RcQK7NXlocxd2F9dVzb+Fq/PJ+DojiK7h1WP9NdCjOnhyis+qNg5pQ?=
 =?us-ascii?Q?jGSaSXN5rr/brG3RcJIPK4VYwD+4x8tLOav9dmv/cQQXEQQoWDzHejkfIoXy?=
 =?us-ascii?Q?7RTlbqL+/241gYUGVx0Jsg55UrTNThuDrtBQYov0WHqQ9ClWG4huEzk0z1cH?=
 =?us-ascii?Q?jLTpgFso5skno6Hnz5Ijucd/Emt9pBNCyBA4Ne9EGEzqCa/cf4TuO8jvhMSc?=
 =?us-ascii?Q?aWvtxFsiZ30iTQTe/ztmxPTcg7zX8SBOnhTYKyS+T2I8suxEUTWrCEmhZ0LZ?=
 =?us-ascii?Q?RroOkqKv7jTGDjvlQ3Oq9ZT7CdQVPhkFXICL4jrgLkUy8zuhgb4Y3eoWEk0i?=
 =?us-ascii?Q?YTy6e1ioyN7f2oT951XwvCsDB/zEya+1AYiWdBLTQ1Wqrg/RzfkPMhCoSoxc?=
 =?us-ascii?Q?/96jcm0B6+Qgqw/NB3FUprBe/T0xIvWl3HdXPD1A5y2yRxuXRl8BK/OMNFy0?=
 =?us-ascii?Q?Jt5G17IWRmjeRF7qYfMx+qS5Vp8CXbz4hXqjLDbtfjpTOK5Ay0HibOvp7D8u?=
 =?us-ascii?Q?gGKv6xd5K8C9LAlMNaeW8i44xLH7vPCb3FZORhX21WtSlWRFoI1rmGcmtpDZ?=
 =?us-ascii?Q?oVPscKL5oZ5qlr7OWSQ5OtuXajtVJcCt4WNyJxbdMHsBArX7eQZRlzui8mxv?=
 =?us-ascii?Q?mNVBnjzU1UVOb3nVFCDataKdZUY8N/eo4pVJPBq3Hz2AU2K+4vjUCkQfT2V9?=
 =?us-ascii?Q?ybI3dn/oS+iB25fAMAx4qPFeBCuaozjHwpmQfpD5BCFwGqdMSBLBR7z4+ciL?=
 =?us-ascii?Q?YnbGZnNgF4A8snkRWw24xj5vUiVbCvMlU5vDryfxPSKWqxSX/NUSUvJtG0nH?=
 =?us-ascii?Q?JKWQtQ/hNuHyOAJ7xmSrWHh183VWWcbQUkguVzuX/2g/AJpBBXLThtduXqbJ?=
 =?us-ascii?Q?8qsmYaEZERXgv9L+CbB6rnrLxvH6YgP83xhEkrTWOtbqWjZQH4er3pVZy95J?=
 =?us-ascii?Q?AHEYMedOGAyH73E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SBGA3MoHfymwnyXLrbTlaiLsCcuiaj2K3OHYn/aNhxiq2cHPi1ssNA9zHkE3?=
 =?us-ascii?Q?CO/OULMnVw2ykvYDogI6wE/AuMaQXkLjLtiOWT3TQBZjUymYw+vXGoObVSH5?=
 =?us-ascii?Q?73jhwN1hGTNWin+onGucXwCqJBZpOjZBC2zUNmUm4ZnVY4JHclKH5hafqStj?=
 =?us-ascii?Q?/oF7j0I6N2R/bZILgnisATYICMjG9c8I7YiTbNeCql637LzyNQsmsKKyV25y?=
 =?us-ascii?Q?VsvBbR2ygCRI3a2G/Va+toaNlcpjYjAxhG8PlqSrMlMW89nU1vqWJCrr89vL?=
 =?us-ascii?Q?ltOsgLGGGC61KocWjqv/+KroEFFFW1DseMbPFJ2W83uP0snpNM4LvvyYPgDU?=
 =?us-ascii?Q?YhF493wPTjxyLH2Wu2l8Q2qeu9CFJ2Pe2zFoxC+Tug3T96UhaMWn5GJNkMqo?=
 =?us-ascii?Q?6LvwG0Wk5VzXD3U1hGxiLzcg/ESEiawUpNG1CgTswrP/G2xZQ8pyWhfWGkos?=
 =?us-ascii?Q?6oYj/EuCDyoYsmFvV0VOfeGW6ZkcP2KgyaDWHBSYfAnpZlmdkXo0kqhmTHHg?=
 =?us-ascii?Q?GKiSDUUKAmLx4wOCSSGzP0V6cJ6ua8YlInVKzuQ/XSb43PkTBX1ckCeA1+iA?=
 =?us-ascii?Q?x86BMLv4WYZkEagOYsefqzA3BLDTbEvv9e7F8aIFBKPk4tcq9fRcTsdLywbW?=
 =?us-ascii?Q?UdjKtZ7sg2+st30zUc1KifQpEn0RPD7ZeG+mS9sbRjEdhe1qXDgTbv6rSjQu?=
 =?us-ascii?Q?45LeRGVIANoArYCBpz/+QXs+9nm9HuOauU1dZQ3QdMgbUKPeAv+fr8jvA1+e?=
 =?us-ascii?Q?5Loap8QY6EWW1olPrrUU4M1Q1K9BbNhPxlKRhv06Aq0MA7NBvgQ0o/GMhqUV?=
 =?us-ascii?Q?D6ubJYQmsiYIAhtKJLe9mEl63NyMCMhjxr8vk40GYUafStKhvt8TrwHugA5S?=
 =?us-ascii?Q?KAO9YPGKFUmD8hA9iAs+6arWPkLbhfDMlCNfKkmS1jyxwDuVoMk6GfqNr0Ja?=
 =?us-ascii?Q?m66tPzRtTMRpKBcX2OvGTf56BWHNBprfIHIFA0/Gq4Qs4EqnVwCCaOwjD1o3?=
 =?us-ascii?Q?+z1Gc59MmIQ4cJvbLOtLeOYpdLyNTJ/Et4F4q2mWlJqXPFJqcv9sCSYi00oW?=
 =?us-ascii?Q?dWkxVIJYJZpiQ2KHwL2iFfYVK9Itj2cy5cQsNBGWRE4jh8PRfiU6qmBYs2oR?=
 =?us-ascii?Q?Zt/ibax3U+yVtx8k5mZ04V+ADOAhENO2dC56IvdB4TRZ3iJhGEXSKJiiv5kF?=
 =?us-ascii?Q?oce8NV9DWL6AwH2iPDQasMLF4JraJRhRJbidCwC/QS46engXsbkzfNQOPQjW?=
 =?us-ascii?Q?PH+EHbdaGGTy2LMXYR4uFaSFK79UoxdTeelw+0V9SxdGMTtc1I/W3+0gSQZ0?=
 =?us-ascii?Q?KAafdX6uDpAzMZppPoBqx5H4xDXRUZeQYXXgFGHQRFmiFjfPRmT4g+Lwm+89?=
 =?us-ascii?Q?eaZXCqJaOhVx1z4tCpxChuZEwwh1vGggh6vHuR+nLWkjFSSLxKMFzkC8niSt?=
 =?us-ascii?Q?sa/URiU5DdG03J7Y0pArVlLxnlON2FjBTsTve9+x7uuzhztd9vL34Vc7pqCz?=
 =?us-ascii?Q?1+K2HZzmnmYovimmbPgx7PCn/0y27NNUYiIp+mnTkI8oe0EGkBeDfo7MpDX9?=
 =?us-ascii?Q?4ybMNh0hysL0ra55y9Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6455.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2343f173-e359-4036-fe72-08ddfb2e2e79
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 05:49:52.3051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fuhnJbwjph3NbOwYqX5KS9zKrGY8CSpcgF/rb2ECiz0dbfg+OSmL18+418CBiXE5IYKORyPMPTk8V7LGYoLRuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9502
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Alexander Lobakin
> Sent: Thursday, September 11, 2025 9:53 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Kubiak, Michal
> <michal.kubiak@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel
> Borkmann <daniel@iogearbox.net>; Simon Horman <horms@kernel.org>;
> NXNE CNSE OSDT ITP Upstreaming
> <nxne.cnse.osdt.itp.upstreaming@intel.com>; bpf@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next 3/5] idpf: implement XSk xmit
>=20
> Implement the XSk transmit path using the libeth (libeth_xdp) XSk infra.
> When the NAPI poll is called, XSk Tx queues are polled first, before regu=
lar Tx
> and Rx. They're generally faster to serve and have higher priority compar=
ing
> to regular traffic.
>=20
> Co-developed-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h |  14 +-
>  drivers/net/ethernet/intel/idpf/xdp.h       |   1 +
>  drivers/net/ethernet/intel/idpf/xsk.h       |   9 +
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 117 ++++++++--
>  drivers/net/ethernet/intel/idpf/xdp.c       |   2 +-
>  drivers/net/ethernet/intel/idpf/xsk.c       | 232 ++++++++++++++++++++
>  6 files changed, 354 insertions(+), 21 deletions(-)
>=20
Tested-by: Ramu R <ramu.r@intel.com>

