Return-Path: <bpf+bounces-69533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A82DDB9977C
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 12:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C10F325B84
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 10:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9222E0413;
	Wed, 24 Sep 2025 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E7C/iIV1"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6609A2D948E;
	Wed, 24 Sep 2025 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710605; cv=fail; b=AkValLvqgdMWjw9eQnXxuA3TdFPQ2GYdUekS4H6LdbmVbVIxIWp1JXC25ZNWNRuunz9z+qecmczTwn9t0hNDd51FFHwyyHHZ5HnOtMZ0HbYAfhK4Bwl1YdJt/e4JBaVxMzfAM/g48Cqnm9E5sj8ENhdUZjaRxucZ3JFP8uKG5mI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710605; c=relaxed/simple;
	bh=J3ew8oz5LnxenwEGJMdKATOcJluT5/q3pckP1D738+4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eLOIYuAm+8e0kfcKK/29EV0kfB0F6JrmdGRVojaz1JpHk2eygPLFdE4nWp2v/qRzWCVGAMUZ3qvW6iRiICVf1v0kX/jRXwh4rkfuItqOPDR9YPbKwyj9Jec1DZoLUZY8Rx6aymug2HVg8StVsTdBgtRg7ou5bpn2wWCU/tj3SGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E7C/iIV1; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758710600; x=1790246600;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J3ew8oz5LnxenwEGJMdKATOcJluT5/q3pckP1D738+4=;
  b=E7C/iIV17NZ36w7xB8TKCwIlCyTJze48G4/xe9Gf/DBgVin3js2aAvy6
   3lqJXEQ22Vcn+qefiVW3M/fy784ozl8vJKNMOR6W8vzfSdIqdZFfwN3j2
   jUdRgjh/oaJ2JsuGnVFFD/ro7wIoPdCJo7aUDkHZ8LTT5wfuuENw0H2/O
   qNIJ8zZlyUd2OEOaeV5Tn6As/geKS/mJF7LbjSMEAM5QV8qAomnJ5VdB/
   s2jEqysv7smn9gWT8ryX5Wr4cgHdh/LlkHxh8IC9UbhCSueE608W+pZJH
   sd1rsP+CRjbbMn3AKfItla8kRRR6mt31aRSjomlU0fg96iTtaSEry5BEd
   w==;
X-CSE-ConnectionGUID: B3mpA6I9TNGIvvdjn1euEA==
X-CSE-MsgGUID: IqYrgXz9QReeL18pmNPl/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="60220751"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="60220751"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 03:43:20 -0700
X-CSE-ConnectionGUID: TZpa1Dv1TM6cDjXFMPAKhw==
X-CSE-MsgGUID: KpceE+fSQCWA8FfX8NYj1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="177447682"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 03:43:19 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 03:43:19 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 03:43:19 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.17) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 03:43:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJaDSB8aZWOckw3ky6RKlfJuJpjj6kguI0sZmIrfWXDuZUjimiB8sh7eFt2wiZzAgCT6VsQMSgQ9VP9FH2OIL5uY6ZsPBMG06tK6ijhY8eFY99sOO7a+bkx/CbSeErOqS8eq71rfIgMUKAoL6VEI6K3r1UIm/8ojLI9HY3t8/hB2XymGvPjt9KuBK5M9CyMbsXdhkYH7wSucfLTszmzdyoRY1vu9XB3FPmQRIy3wuhezkjY/p+7TkVRT3N1zfO97n0PwLraqJJDloohoSdj9orLMg0Zki2tWQRhhdBQRxy7m0w4ZbuJhOqpfDhSHRmkOX+z9KXJoXrW9FkydYeCRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jpvag8rrslXnSNnFWFATtqEahvdddO+gHhqtGP6nf4Y=;
 b=TGl/wR8vDn3jP0eKeyieOzqUiOoE2Bw9egHxDCP3Bp5X2XohYdRoNuXhWMZPcaf3QVBNZTx7ge0Kfqh1owrwOwkj0vCmm5NZMGZ6Vb846Ca2ba2BVPcaaMrBO/cz2WBd+hApFzyAPhXE9WLio5OTv0QULNP96bQKpNMY0/tg7Fq5BZshMqGySIq8hSIAy8qOKQliUAFpcavhNs0gbVQJTNvSzYWk1Ts6C6YPF+BsyCBqrIN38uSop19Nwz9IQF3tgKVsrE6FdecJ439eEpbHNX4dKa6bpYtMeAoPJ7g4v9s3lwbJgEGH5YxL/eYBEUb5knUFJ9CF5qpRRxydwVcAtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) by
 PH8PR11MB6830.namprd11.prod.outlook.com (2603:10b6:510:22e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.19; Wed, 24 Sep 2025 10:43:12 +0000
Received: from DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425]) by DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425%7]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 10:43:12 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 2/5] idpf: add XSk pool
 initialization
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 2/5] idpf: add XSk pool
 initialization
Thread-Index: AQHcIzh3Exe4hN7y+EaPlI6WCGw+O7SiAVwwgAA3KhA=
Date: Wed, 24 Sep 2025 10:43:11 +0000
Message-ID: <DM4PR11MB64556B4964ADE393E42C3009981CA@DM4PR11MB6455.namprd11.prod.outlook.com>
References: <20250911162233.1238034-1-aleksander.lobakin@intel.com>
 <20250911162233.1238034-3-aleksander.lobakin@intel.com>
 <PH0PR11MB50136480A130C818932FE6DB961CA@PH0PR11MB5013.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB50136480A130C818932FE6DB961CA@PH0PR11MB5013.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6455:EE_|PH8PR11MB6830:EE_
x-ms-office365-filtering-correlation-id: cbcadf96-e1ea-4dcc-f126-08ddfb5728aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?DgOxAVvCzhbJ16w+qCbFXiNdrKaRQwLci6zteANGLjWfiQuJSJcTDxw3P82y?=
 =?us-ascii?Q?JuE3Asz6RC3e4eklrNoC27kF9s6xo3c7z9DtarnmOfzh/g0LCG9zwbA2Vnt1?=
 =?us-ascii?Q?kAj1rHYCnQRO20mHbSCBc65vXTMRnMzsxMe7gboQW+xLQK4Oebq8TKK3eLOo?=
 =?us-ascii?Q?zv8fu4lyU4NHryf9OjSNabU0R0S+Hula50wZSysyymwYqQCOhcjInSH+Zbvx?=
 =?us-ascii?Q?kuGIuOsnzSYckuV4JGxeAeqBt5LXQjLGc3ovpykidrsbVgn1OT4oOjUpTe37?=
 =?us-ascii?Q?ehb8G5qb1ifUgJ7bC//nHCVP46IutrEknXgNqOKNZPYeO0xIM7yKreUi+kc1?=
 =?us-ascii?Q?/LNLopAnDUjOLFL49wkeCnsDLFxKIWe8e48OiLfZLnv0KpOvZLJ2kp+wOzqh?=
 =?us-ascii?Q?quHcv1nKF0F8Gq9jmybZ2pQSOokWrUtkfN2zzXqE+uuVjUUCKWiOilQsgVsU?=
 =?us-ascii?Q?+2T7V0IEGJPfT3TdzKC1xTeE2tbkEdCavShgh6pcA9MS52tOR+1lPw7GJPv/?=
 =?us-ascii?Q?ENU6XxhYLzK7NOKPSjhGJVgOKKQ0q9nxndWTwzp8uD8BSgoSu6d8SQIeShRP?=
 =?us-ascii?Q?gK99cs5hWWXaVE1kEGT5J1KhDTya3O+rMLsqATVRb3GyAB7xfR99FOIMuCCU?=
 =?us-ascii?Q?RfbZGQ/joEtOgQUpmyJgIkU7tyPuGnevFXYNfSyUnkO4b3skUXk0haEIUL3v?=
 =?us-ascii?Q?IteZXqVk1Zuj70q6n9nU+nB1WbOLo9D1KpWbQkoRIDLQqWMHXLqu/KPlUUbI?=
 =?us-ascii?Q?w0S9m6eXrhQ+18nSj0cmAYaHPo0uZ1HzF1wcfL0yE2e4Hgqm7sCTh0XtanmH?=
 =?us-ascii?Q?gNDHYTqPP0Sh0AifmhmMN6JczI6lW1CHnJtPcvsvZe69QghXvohDgYBlDfGR?=
 =?us-ascii?Q?Rk8wM9lua5/aCb5L2qVPog4ieFToPJ8DbCgiKef+cQp27JWkIlqUqTmQFz+w?=
 =?us-ascii?Q?2lr8HvZWLjfuHTd6hTQw08uAY+iTGzihC8IszoTOCGVeHdlSE2YWp0W1fKX9?=
 =?us-ascii?Q?lKtmDyzVGYp3BbzuLJ/m18817PGfIWMWnaOII9B4GUZnp3y56KAiV28Bdk86?=
 =?us-ascii?Q?YLXih2EiSUmcVP6bbVS+n2sF3J8k8Z6ZntKqNUiUPsr7J/xCI3VSIvbHmB43?=
 =?us-ascii?Q?lmJmljAzh+CtCL59sfXDFynp429xLQKHoAHMJp+miFMthquxOvlxCIVlgit2?=
 =?us-ascii?Q?iKnGTedX5rAdZVg6P8xLyb3+BRJu3vMIut+ntiT9g+5iB7YrB9XJU0gxDeiE?=
 =?us-ascii?Q?yC6Fa1y1fd4QlPN91nW6mJDB5uY38ZG/+u6qM24RxrCvz1Y3Ljr9/Iv4pWGn?=
 =?us-ascii?Q?CTrPjchf1kv8Krt6qW1bAVlvVopOyy/LrzkPOAfHmNK1SBWDe/AotffEcQpC?=
 =?us-ascii?Q?ieOuWew/DPh07ZL72VYdegd+Ii+aKUqosZ5VAGByJPTnxAAI4vlxHyWk9yVs?=
 =?us-ascii?Q?8TJgMzZ2JTJ/ittj28ri4Jr01o1hSbqkBUJSqUPWDt84KwhqjNsy0swD/Kd1?=
 =?us-ascii?Q?+HMhlx4mcpb6V3Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t1VEHSZfgEzKMReInzz7dxX4j+fmHUKS7mcNjCkVx3c+VLoWNQkmuoKyqB8g?=
 =?us-ascii?Q?oPkk6AYpIAp0XZ1YKxxPh0g+GLdqtyunieTdV1xUUkK0CcgXZODFIAanqj+A?=
 =?us-ascii?Q?/mOgI5eqxgCVLcOyPhHNUBnn9UY/HgdZhw1vA6Yr11stjjzjYilpHtquK1Ti?=
 =?us-ascii?Q?p/12K25mXP3uUJry1T2tCwSV7hyrXRh2qjPw2dZkP0FY3PgUojJtPh0hX0sX?=
 =?us-ascii?Q?2xzL8BYBGyh4DCnHfhmDuLEUJcK9YnpOZGusFUiDv7g8zLWtLLOOG8UR0+Sr?=
 =?us-ascii?Q?go34q3TbrIQATxN8qAE1/VPmgB4UaHQAmkq9cgk1dK/bPY/LVArhUicNoArI?=
 =?us-ascii?Q?KQWIfPOzF4JqA9x4TMwhFKxx3jte5IcindQ/5j3U6JsaHzN7MeJIDciEN5WW?=
 =?us-ascii?Q?5aoVZdA+08kJfHsOpv4cB0dT7nxd+2dorYDNK/63ACtp/ODTcxq+n4Vx542C?=
 =?us-ascii?Q?/oCZRUdXdqfHQ1PeOEw+ZQzAWhqLGlqxuyShzuH3QG+kqHuaXdHcUg20sV/H?=
 =?us-ascii?Q?PWJmITeRv6VA+UUE3DnkyTeRhtEHUs8ogas5csPbKpi1RNY+FETjFvwQiDMx?=
 =?us-ascii?Q?XlJpa0yjjxeUWsn0cIxyUcxd1zLC96UCGV4Ry9G9ewGeErNuAbDOZ/wgT3dk?=
 =?us-ascii?Q?dx1ER0vw5qBGciKWktPgKJpzCYKV0ITaqsFOKGD21SSj5tRkybxIlkf/KPsg?=
 =?us-ascii?Q?TD8iqhtGmINQHH0ShFwqC7FICsn17Lb0FJUZVFvCBnZs5/B/bplHvRGH4o13?=
 =?us-ascii?Q?aSPdqyaE+YICeFHQfi2kxeUy264Um0UhpTSREoAP0QiqaKfQhWUPuZgW+w/0?=
 =?us-ascii?Q?zl8fsMzUnyQzS3MBnkSNcMK+a+LxQZenuaOdTVWDbiir0EOLgc1/txcbiBIW?=
 =?us-ascii?Q?0MUlX84vCF20Z6oCypM5qB3b84Zyo7KeSbczKKAPvgzD14/6k3YXRHnJdN7N?=
 =?us-ascii?Q?oNjT5nt2bA0t/8s7Bykkp46hOdm/89la773yOp+DaVM4TuV0uXBrOkzoRtRA?=
 =?us-ascii?Q?4Pr4mzMgvkXjl5Qi9zgAMX0AuJQogz17DBmPXBQ7tFq4/roWMJmElFjdk3+A?=
 =?us-ascii?Q?tOZV2IPuv5o39cI8b6872VENqEgMZRL1Vf4H9yenBJanu3ML3GTo5xNpCgrB?=
 =?us-ascii?Q?gywdK3vMkpp4dDjKFUTa0fqeFwfSGT0wezsc35HlExFKijf2SZbGM/geUg0i?=
 =?us-ascii?Q?kMukKU/ciYv++0lWjZiAc9MiU731/pEFgyurd5c9u0nSM35bBtqzJ10QNn+X?=
 =?us-ascii?Q?VUFKef+GvAbmKtGz9OKTfx8fbVXMna+4RGHTHKRIro1LjVUjHgQlEn807VHs?=
 =?us-ascii?Q?LUkSLrWdOw26q1bKzH3Zo4+2+KLpf7qCT2hW7Ayk5xDX5nuw+O+p2AHP+gJl?=
 =?us-ascii?Q?9Lq6lSWKdOZuGFJntOuv6Zo0idENV7V0Tv68rJGE/PFFzTuwmU9MJCC/Pqdi?=
 =?us-ascii?Q?SylNsjfmsiqpvJJkh1eI7MG/WOhqeclga+PEzz6rmybuvI8AAdAUuOH9SW7T?=
 =?us-ascii?Q?171L6ogaZb16GmO9DopNd0UtL9+qRMjmfR4zDTUUspZQkM2sMIYyMQRoJcrf?=
 =?us-ascii?Q?UWK7TjDNYqvK5aKGbtY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cbcadf96-e1ea-4dcc-f126-08ddfb5728aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 10:43:11.8845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W3Z0DTtB+k/L7YWlx/+x7ZSNkTv7V8bt5nC/QgglzvBZZEP7Uif1pHCPV/CUU2/wmzHukBzv06KsZclmIDCbcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6830
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
> Subject: [Intel-wired-lan] [PATCH iwl-next 2/5] idpf: add XSk pool initia=
lization
>=20
> From: Michal Kubiak <michal.kubiak@intel.com>
>=20
> Add functionality to setup an XSk buffer pool, including ability to stop,
> reconfig and start only selected queues, not the whole device.
> Pool DMA mapping is managed by libeth_xdp.
>=20
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/Makefile      |   1 +
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   7 +
>  drivers/net/ethernet/intel/idpf/xdp.h         |   2 +
>  drivers/net/ethernet/intel/idpf/xsk.h         |  14 +
>  .../net/ethernet/intel/idpf/idpf_ethtool.c    |   8 +-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 299 ++++++++++++++++++
>  drivers/net/ethernet/intel/idpf/xdp.c         |  14 +
>  drivers/net/ethernet/intel/idpf/xsk.c         |  57 ++++
>  8 files changed, 398 insertions(+), 4 deletions(-)  create mode 100644

Tested-by: Ramu R <ramu.r@intel.com>

