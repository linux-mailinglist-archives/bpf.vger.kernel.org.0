Return-Path: <bpf+bounces-51964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904C9A3C3CB
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 16:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECC937A7379
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 15:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664731FA267;
	Wed, 19 Feb 2025 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AAX1E80H"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01301F91D6;
	Wed, 19 Feb 2025 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979422; cv=fail; b=thUHJqmtPWlD2jAZBuxaX12qyY+/oGC0vSFnpBZ+4K6A7b5PF0hFn542mql/ICazujsAleC5qe0lhp81g7+p3d+HHozxm5GFA9CZZqDHzWdk/WHBim6/T7Q5x+PtipSByY03JxFNwKHnG6gKwqTRbD6xRRp+cBbHA5/gzFCAjm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979422; c=relaxed/simple;
	bh=3DL8bB6/6HijhXXJzYoGf5JRTtch7ZoRVdj64DZPfQg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G53/gzbn0i2J5nI/OOCzslTQEFOykE1Tm4PORzPBSQ0ssqGCCLoIykygVMcCKPc+PKeNPvomXBuxCq6g72snyaBoPwpIAuhVwQoodXAB+S0f5foHdIZgwWHWRPxEl5Q+oGwnFm7EyTIMXpu0pqaKUzuTIDp2YdP6XIvrplNdlRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AAX1E80H; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739979421; x=1771515421;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3DL8bB6/6HijhXXJzYoGf5JRTtch7ZoRVdj64DZPfQg=;
  b=AAX1E80HqlxMTTazL94SSdHNrvTz28Z3YOTPqFcbYYPs7A2UCqMB3z0K
   a9zC5bbuh8rXmZK6LIwAtrJTIGAbEMm1Fmf16iFkYAifQNSCRofy5D/FL
   SKvfoG9Di9dpHJPSKWcVAygMAHYLb558ngnwBvHYMhxpp7mvSIaCGVniL
   XBkSXFd/9bY+2GLWAK2rfbV7K5ovP3Ev4+LHQxYPfP3PHExadC3eM/iAT
   SBsGX7tN9ywjJanpvI3XrkCsZj+v4x90MJGjMXIu7ikuIgD0REVVvZZpy
   6lISN5mwKxyz8aeGRbRK+qXwFb9rJgz/a/WBxptf8VUxVZS4FR9k7odhH
   g==;
X-CSE-ConnectionGUID: OyHYDAsjRLSEvHCm09mRwg==
X-CSE-MsgGUID: JDUeds+eTvmf6QoJPxO1vQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="58262712"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="58262712"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 07:36:59 -0800
X-CSE-ConnectionGUID: tKbtPBRxSCeQNV6ZMKRy2g==
X-CSE-MsgGUID: YBWWHDKATFusohRvsZcRow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115275554"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 07:31:44 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 07:31:36 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 19 Feb 2025 07:31:36 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 07:31:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZKo4pg+B1aZUfVrbrEzqXg3D/mMgO15uOBk0wSqDvpiWiW0nofq59onWqJSZ0KaQf+RTEdHLbLAtkv9CDsdMvj4wI8DI7FejR0crs5poI5pkL4nSn5nUO/TTkhAsxXOJtOPZ9XqWDDDZ+n2J+1LnBpeP6Z6kkXm3pJHs5bfPAcVI4+CCJISnSU2LiiLFkdGuRtjWdLkygmA0qudv+vRPETk8uoFZtzsuIwkEcEB4bP7/Q8npO81aw/+Lsj3bgFEPAzTyWIVOqVyblIcKbCTNEZOILQW/eiI1f3gaa8PySheS8PrlwSa4QwR4utc2+IgYvt8F3cvP6Nep2kCzT27fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5joJfkx8EKl4xObD7II/ZUn3aCY/5K0L9Pw8OguxZ0=;
 b=mp9QE/jydpFNXU6/Rsyagcc2LVHvsqHMPKFMWlKNx+iSJcE+vhkoOd59WSUxfS763dGfReVD8RCj5mDeFdmxfQQkhfbal+Snxt1i8Q660WD/XWsCmFxJaamUR4lDJAITTW7SxNEla1/NrHNzDH9vdLbKk7oJyQk8V9H0UJI0cE680HYgQRE1uzFhMBx/kzYbIZCYML8WJ5cjEa3sAx4GM1x72uhO+OUoXR426y6kjm27LVBvmciZjQEkGAVlknb8g3mkVlMuRVVf4pJ06ARelty+0qeXqMVAuDBmvX+KerJ3RBvVJxGRBe8NR1UJJoM3NpbesCKSRy653W5Uqd7wTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6289.namprd11.prod.outlook.com (2603:10b6:208:3e7::9)
 by CO1PR11MB4849.namprd11.prod.outlook.com (2603:10b6:303:90::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 15:31:33 +0000
Received: from IA1PR11MB6289.namprd11.prod.outlook.com
 ([fe80::ec3c:2931:b0e8:c5b5]) by IA1PR11MB6289.namprd11.prod.outlook.com
 ([fe80::ec3c:2931:b0e8:c5b5%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 15:31:32 +0000
From: "Joshi, Sreedevi" <sreedevi.joshi@intel.com>
To: sreedevi.joshi <joshisre@ecsmtp.an.intel.com>, "edumazet@gmail.com"
	<edumazet@gmail.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>
CC: "Karlsson, Magnus" <magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "hawk@kernel.org" <hawk@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"almasrymina@google.com" <almasrymina@google.com>, "asml.silence@gmail.com"
	<asml.silence@gmail.com>, "lorenzo@kernel.org" <lorenzo@kernel.org>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "chopps@labn.net"
	<chopps@labn.net>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [RFC PATCH net 0/1] transport_header set incorrectly when using
 veth
Thread-Topic: [RFC PATCH net 0/1] transport_header set incorrectly when using
 veth
Thread-Index: AQHbeMHRHWNWYkkSpU+E75RLaL8DrrM75wVAgBLop1A=
Date: Wed, 19 Feb 2025 15:31:32 +0000
Message-ID: <IA1PR11MB628988D4CC8F4E9B1903B37589C52@IA1PR11MB6289.namprd11.prod.outlook.com>
References: <20250206180551.1716413-1-sreedevi.joshi@intel.com>
 <IA1PR11MB62899945E3D2DCED17259B1E89F12@IA1PR11MB6289.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB62899945E3D2DCED17259B1E89F12@IA1PR11MB6289.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6289:EE_|CO1PR11MB4849:EE_
x-ms-office365-filtering-correlation-id: 68a4fb5f-2440-474b-c3ee-08dd50fa7d0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?hhZ+V/ZvjmHyfF83BwbSSLUp0/u/ry9FtSqlu3okmthnQI50B1REYZhnFJAa?=
 =?us-ascii?Q?g3Yb/oncQb9BJjBCw+HLPmhyaHu2R3oYEeRs21snmzJ7d7zbeI4Y9E7E/BId?=
 =?us-ascii?Q?j1OOUNFXmKLqezQLc0+gpCIwOoPwP4Mr2/ukBKC74HMmp30mRphRHsJHXdq1?=
 =?us-ascii?Q?eRJN1MktmyBcDsQoJs+Fvwqd5fjDBdFpxJg88uBxZINNPr8XeKd6WPs5mD/V?=
 =?us-ascii?Q?Cvd8V4ma73dKqld0mrutJ3f/kIVMcbFuMALcRorQuylESOkQMtFt4M899xVi?=
 =?us-ascii?Q?Atrb3k/oKRTWseEE4RA3nNOu5ciF1iYnIJhbsOZH23rYGf9yK7p3f2eV3OOD?=
 =?us-ascii?Q?H148nAM4JJPrsdmZghFVeNlzMXmfb9Kj+grEHLBW+ZokxRUwnQYLQiENhmpf?=
 =?us-ascii?Q?8atyny48W+RodRZy2dsWM7eO9wyNWnBWz1Be159uvZEJQTzYACxHYSJmox3Q?=
 =?us-ascii?Q?SKmiZak43tcZG5mR+WktETyR/5MRVMdTrYQHTfLtM5epbFoWiOsv9ds0ALJ5?=
 =?us-ascii?Q?3EXe5DsA06xfWuGvX7KRq8bnfDx53hbrgibeIdTT7I5u0c/WCzXidDTPMOb6?=
 =?us-ascii?Q?GprAbQy/OlAE0sT6FLamLEagMgzE8GYcjKxfSLh2GNu9Axmnvw/4G/G7K4Ff?=
 =?us-ascii?Q?byfWKrra8R4TPADHcAzCaCWDnSGog6LruOVmyVFyCzKy6rwx1qaLanBpZWgf?=
 =?us-ascii?Q?4cFhabMBRNZtq52ccJw1VB2WtUNtN60DvvcPmbmoLXAjeZ/sjMiYC2GMo+JP?=
 =?us-ascii?Q?GV5GR0Md50w+FP2LDJtgTuxRZPaukWj57Gs2xoipaIaJLZT9tnfFmcVERKfA?=
 =?us-ascii?Q?GRlK9X1c/XG+FGW6tqtwD3KMeSJCIxfNRtiF9w9RuQ0Kbe4UcnfQmZzs8aPn?=
 =?us-ascii?Q?N44K/qstQZ24+N70ghtMP4sDiT+O8NuLEEzJ0UACWiLzqgAcDvR1HImoMf9Y?=
 =?us-ascii?Q?UV/bXZpe0c/xWXVxNdZBw0sqM5+H7H0KBeJAI1MPnmSMyxA2Lw/BQ5c5HAkw?=
 =?us-ascii?Q?BePCcMdV1TED1YD3D2TLGvJ1hRJ2kFnNWy/EBStBLUh39JsPif3Ls3Aj0PDx?=
 =?us-ascii?Q?kZwjPzw+loLvcHrWPd+1UYPehF6nLsT6akzEwCLPSyhxwtvGfzDjJLdhK7kp?=
 =?us-ascii?Q?Oq4Bc+A4U2WV6iFIalvKE7Et2YLx/UQSxr8GCzYSX+9Y4GI4FcqzZa4YyykB?=
 =?us-ascii?Q?QIqNouu2MCYb9mY1qib9p9f94E0FwsaHdfFgBZVqqGNhYG0QRtjd+kbKpxdq?=
 =?us-ascii?Q?Rsq3nm+7NjNHHv15DH1bVKPy32/00SmJDxL1NFwryOyFBjKkVI/RGATzVRXC?=
 =?us-ascii?Q?VCiTufutUwMURTLRqouSbrpj9ntsp7GcD0oDqOJnaKMf7R/uESGojjbpo8fU?=
 =?us-ascii?Q?a9CAtTLlmbcbQctkCVAwYSFCVPVPXwxYCjg0u9qdZGsr5jLSmXPZC2yeH4lU?=
 =?us-ascii?Q?sFG2D2o/EyVWjS7XrhM3kWhKltu2UHuU?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9IxGxjnOQld4eFbyDCN8LV5J2WfdOse9toQvJ08tsFADMhattMkJZ70V+IwN?=
 =?us-ascii?Q?7txoBToyxTbjPRNiZoRMhn820NhoGzcH+0QzFnFRyHWpDKvU9A4Y1Bk6qdsR?=
 =?us-ascii?Q?3ILN6HUxCY2dRrYAMhoKhWneI3Y1voAV5B/oTTFK+s8V1CsA5tKsBqBPRoUx?=
 =?us-ascii?Q?0aBLQReOio0piugKkEkkZnoemHHuonJhVVd5nEQAkXETGubRamKoOh6CNOcl?=
 =?us-ascii?Q?AHf5vwia8ybMzjgZjkbdDO23zduJUjpdVMocqgWzwBToUgRAnmqlDs0u/utQ?=
 =?us-ascii?Q?nR82qlSM1M+DIrBs+EPVNbQBP6cmX87C57UXf21fROXXTITEQQ07rpyVurRD?=
 =?us-ascii?Q?oRGdgIu3xbyHZJRVVGDsA3s9w0VOOTrLl42BPNyrLySwdGOizR9Imtf2E24M?=
 =?us-ascii?Q?u2yL4s3y8jh/SETsi8UKkXPiSGk5MuqsxsAe7bmgyMVriRJDjTafrdjI4+TJ?=
 =?us-ascii?Q?3dEe1tpzDVueyBXyMiu8CQlMiyioiKSrFPis5i9OseQewTMiQImzTk8LsxQu?=
 =?us-ascii?Q?xrc3JoNVs9omCo8nUtCiv9gSPgevuta3iVzjDyM77e6cPo5eF9cZMLdaKICG?=
 =?us-ascii?Q?RJuCu3/cLf24f9h1ZtcmLj6q8Y+WRy3LTES16ye0uBUM08Mhq0eZZ8YjCg8N?=
 =?us-ascii?Q?/+wzgRhiqBb5A9hhKjqMtwnv1EGE5tkRKNfm6Dcw4eGBWthmz6Xl56BMRHq+?=
 =?us-ascii?Q?w11/MpSSy76Vfh0KPpIYr3Rpc0A+5jP2Bz7gp1zXRa1bVhgdI9E6+DlIOiSG?=
 =?us-ascii?Q?AahEooLLoYR8UXviioh/zh7eeOjB5RY9t8gVY4FeSnhMzgadB8JbR5sho6EQ?=
 =?us-ascii?Q?rJfJOX/BQecNkkN0m4TS3wuAie80KvANw0FM1sx267/sULr4i/Ih+WO1wn/6?=
 =?us-ascii?Q?GdRdEbzYWMYo3ypCPzHdX1C7DDAb1SAT8Gh20qdvWLg/OWptnGtiB2NpQCHe?=
 =?us-ascii?Q?8DBu7ueuAsfdF0mAPKkL23fe0EDzbft/mkoV4KjwvvnyMEUj2NIvTf6ZzHP/?=
 =?us-ascii?Q?PyZGyaHD0RKN0/pQE2GScHwc1sNCNDPIKxcTiupmFFyJhXntZbpLS2SwsEfg?=
 =?us-ascii?Q?DdN7ieaI+MoX2SxJUubCf6DmeBjX0qm+Qztxbx1qMFTqG9wKXRlEJRLEAQ1x?=
 =?us-ascii?Q?2jkbldMe9PMTsZDaEnIX9QHALmzuGLl2BUAg6y8VhUFsmj0ddBc3laif1g7C?=
 =?us-ascii?Q?8qvAxw3MeL+o1s83h5EAqsaUY+gdMzHUM86UfmQb+hel8WnrdZeQCLKpCc1N?=
 =?us-ascii?Q?NM/O+7xnYCH2HiyOP6YRgzLp1KcWGT94jwRcFjg1fidOo4BCzo85irI4o+GW?=
 =?us-ascii?Q?5k+/VEmWXETyRwiXGUkd3UrcNNf4JmuMIcWKLb+CiC1gfCE9Hu3fbeKAtBTy?=
 =?us-ascii?Q?cCCZu3PVMrU5AjDlZowxwlVW0arLuhOtOIiAR76ue074Lh1V3TF5cYawUtWt?=
 =?us-ascii?Q?xwFeShwTh+P9gzd4tIyd++WrSTw71hZ6HyGFiwQS4gX6wu77hfDS0Jrg8zl5?=
 =?us-ascii?Q?KynGEH5/UiwL7U+TyrWTe4jHtcrvwgntAAArN7Pqr7SOZmhxr1TEWRYR0Dt9?=
 =?us-ascii?Q?qcoeKK9neqvRpsqC6y/2QHMPPj4JwSputeYZ1QY2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a4fb5f-2440-474b-c3ee-08dd50fa7d0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 15:31:32.6155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JLHmRg1obzVv50dbKQyy2GuXAgHt6tLElxIfsFvdXu+tZ28iArgzwpcpJR79vXbGDbbVqTwKHi4hcKgase9lIUdqWEQoJDmATiEtFNZHCeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4849
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Joshi, Sreedevi
> Sent: Friday, February 7, 2025 9:28 AM
> To: sreedevi.joshi <joshisre@ecsmtp.an.intel.com>; edumazet@gmail.com; ku=
ba@kernel.org; pabeni@redhat.com; horms@kernel.org;
> ast@kernel.org; daniel@iogearbox.net
> Cc: Karlsson, Magnus <magnus.karlsson@intel.com>; Fijalkowski, Maciej <ma=
ciej.fijalkowski@intel.com>; hawk@kernel.org;
> john.fastabend@gmail.com; almasrymina@google.com; asml.silence@gmail.com;=
 lorenzo@kernel.org; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; chopps@labn.net; bigeasy@linutronix.de; n=
etdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> bpf@vger.kernel.org
> Subject: RE: [RFC PATCH net 0/1] transport_header set incorrectly when us=
ing veth
>=20
>=20
> > -----Original Message-----
> > From: sreedevi.joshi <joshisre@ecsmtp.an.intel.com>
> > Sent: Thursday, February 6, 2025 1:06 PM
> > To: edumazet@gmail.com; kuba@kernel.org; pabeni@redhat.com; horms@kerne=
l.org; ast@kernel.org; daniel@iogearbox.net
> > Cc: Karlsson, Magnus <magnus.karlsson@intel.com>; Fijalkowski, Maciej <=
maciej.fijalkowski@intel.com>; hawk@kernel.org;
> > john.fastabend@gmail.com; almasrymina@google.com; asml.silence@gmail.co=
m; lorenzo@kernel.org; Lobakin, Aleksander
> > <aleksander.lobakin@intel.com>; chopps@labn.net; bigeasy@linutronix.de;=
 netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > bpf@vger.kernel.org; Joshi, Sreedevi <sreedevi.joshi@intel.com>
> > Subject: [RFC PATCH net 0/1] transport_header set incorrectly when usin=
g veth
> >
> > From: Sreedevi Joshi <sreedevi.joshi@intel.com>
> >
> > When testing a use-case on veth by attaching XDP and tc ingress hooks, =
it was noticed that the transport_header is set incorrectly and
> > causes the tc_ingress hook that is using bpf_skb_change_tail() call to =
report a failure.
> >
> > Here is the flow:
> > veth ingress:
> > veth_convert_skb_to_xdp_buff()- [Example: skb->trannsport_header=3D6553=
5 skb->network_header=3D0]
> > ..>skb_pp_cow_data()
> > ....>skb_headers_offset_update() - adds offset without checking and thi=
s
> > 		results in transport_header value roll over.
> > 		[off: 192: results in  skb->transport_header =3D 191, skb->network_he=
ader=3D192] tc_ingress hook: bpf_skb_change_tail()
> >   - Since transport_header < network_header, min_len is negative and it=
 fails.
> >
> > Two possbible solutions:
> > option 1: introducing the check in the skb_headers_offset_update() to s=
kip adding offset
> > 	to transport_header when it is not set. (patch attached) option 2: res=
et transport header in veth_xdp_rcv_skb()
> >
> > Option 1 seems to be better as it will apply to any other interfaces th=
at may use skb_headers_offset_update and there seems to
> > similar logic in the same function to check if mac_header was set befor=
e adding offset.
> >
> > Seeking your inputs on this.
> >
> > NOTES:
> > 1. If veth is used without XDP hook attached, this issue is not observe=
d as the logic uses __netif_rx() directly and the transport header
> > is reset in __netif_receive_skb_core() as it detects it is not set.
> >
> > 2. Tested on i40e driver and confirmed it does not have this issue as t=
he
> > skb_headers_offset_update() is not in the processing path.
> >
> >
> > Instructions to reproduce the issue along with the XDP and tc ingress p=
rograms is attached below.
> >
> > -------------------------------8<-------------------------------
> > instructions:
> >
> > #build XDP and tc programs
> > clang -O2 -g -target bpf -D__TARGET_ARCH_x86 -c xdp_prog.c -o xdp_prog.=
o clang -O2 -g -target bpf -D__TARGET_ARCH_x86 -c
> > tc_bpf_prog.c -o tc_bpf_prog.o
> >
> > # create the veth pair
> > ip link add veth0 numtxqueues 1 numrxqueues 1 type veth peer name veth1=
 \
> >    numtxqueues 1 numrxqueues 1
> >
> > ip addr add 10.0.1.0/24 dev veth0
> > ip addr add 10.0.1.1/24 dev veth1
> > ip link set veth0 address 02:00:00:00:00:00 ip link set veth1 address 0=
2:00:00:00:00:01 ip link set veth0 up ip link set veth1 up
> >
> > if [ -f /proc/net/if_inet6 ]; then
> >     echo 1 > /proc/sys/net/ipv6/conf/veth0/disable_ipv6
> >     echo 1 > /proc/sys/net/ipv6/conf/veth1/disable_ipv6
> > fi
> >
> > #attach xdp hook and tc ingress hooks to veth1 xdp-loader load veth1 xd=
p_prog.o
> >
> > tc qdisc add dev veth1 clsact
> > tc filter add dev veth1 ingress bpf da obj tc_bpf_prog.o sec prog
> >
> > # generate traffic from veth0 egress -> veth1 ingress ping -c e 10.0.1.=
3 -I veth0
> >
> > # observe the trace pipe (make sure tracing is on) # The following prin=
ts will appear
> > # ping-5330    [072] ..s2. 18266.403464: bpf_trace_printk: Failure.. ne=
w len=3D52 ret=3D-22
> > cat /sys/kernel/debug/tracing/trace_pipe
> >
> > -------------------------------8<-------------------------------
> > xdp_prog.c:
> >
> > #include <linux/bpf.h>
> > #include <bpf/bpf_helpers.h>
> >
> > SEC("xdp") int netd_xdp_prog(struct xdp_md *xdp) {
> >         /* Squash compiler warning. */
> >         (void)xdp;
> >
> >         return XDP_PASS;
> > }
> >
> > char _license[] SEC("license") =3D "GPL";
> >
> > -------------------------------8<-------------------------------
> > test_bpf_prog.c:
> >
> > #include <linux/bpf.h>
> > #include <bpf/bpf_helpers.h>
> > #include <linux/pkt_cls.h>
> >
> > SEC("prog") int netd_tc_test_ingress(struct __sk_buff *skb)
> > {
> >         long ret;
> >
> >         /* extend skb length by 10 */
> >         ret =3D bpf_skb_change_tail(skb, skb->len + 10, 0);
> >         if (ret < 0) {
> >                 bpf_printk("Failure.. new len=3D%d ret=3D%d\n", skb->le=
n+10, ret);
> >                 return TC_ACT_SHOT;
> >         }
> >
> >         bpf_printk("Success new len:%d \n", skb->len+10);
> >
> >         return TC_ACT_UNSPEC;
> > }
> >
> > char _license[] SEC("license") =3D "GPL";
> >
> > -------------------------------8<-------------------------------
> >
> > Sreedevi Joshi (1):
> >   net: check transport_header before adding offset
> >
> >  net/core/skbuff.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > --
> > 2.25.1
> []
> Apologies for resending. Mail server had some issues earlier and didn't r=
each some recipients.

The following commit that was introduced in 6.12.8 addresses this issue. We=
 no longer
need to follow up on this RFC.

Thanks for your time!
Sreedevi

commit 9ecc4d858b92c1bb0673ad9c327298e600c55659
Author: Cong Wang <cong.wang@bytedance.com>
Date:   Thu Dec 12 19:40:54 2024 -0800

    bpf: Check negative offsets in __bpf_skb_min_len()

    skb_network_offset() and skb_transport_offset() can be negative when
    they are called after we pull the transport header, for example, when
    we use eBPF sockmap at the point of ->sk_data_ready().

    __bpf_skb_min_len() uses an unsigned int to get these offsets, this
    leads to a very large number which then causes bpf_skb_change_tail()
    failed unexpectedly.

    Fix this by using a signed int to get these offsets and ensure the
    minimum is at least zero.

    Fixes: 5293efe62df8 ("bpf: add bpf_skb_change_tail helper")
    Signed-off-by: Cong Wang <cong.wang@bytedance.com>
    Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
    Acked-by: John Fastabend <john.fastabend@gmail.com>
    Link: https://lore.kernel.org/bpf/20241213034057.246437-2-xiyou.wangcon=
g@gmail.com


