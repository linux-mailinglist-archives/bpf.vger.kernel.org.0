Return-Path: <bpf+bounces-67470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A603B442E5
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 18:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B5077AA4B4
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 16:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5724A2D6E6E;
	Thu,  4 Sep 2025 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KTyjsGH7"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC33F224AF2;
	Thu,  4 Sep 2025 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003724; cv=fail; b=cNWpW5CsSWwbMd5YnUIlteCHpTgZ5tBlJqxLoZyLNFxvnxbHETmRyHDyKn0rO3rsu2R3pxBNftw2+5yI/ZT3suy9Hi0BhQhYKp/Ac2pPCbO75vCW/kkALbT0yvlhgIYxXRU1phOlz+zTo/UialeDp0B7E1j3NHLFrB/Ltzn6xFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003724; c=relaxed/simple;
	bh=HK9Kk5Z/KlPbEq13gY11MtGP6ep2Qv+ilBfkEZTtalk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kufpCDVPmaAP6HJodfzDKCSDX4aDbLq8RJ7arrMQ8HwQ0kbzaqt1nm5zt7ym+mfLrK4LMNR57r8USn6yTctyBpqLu4XjUN2ywJxVvEY4CjF8O1Aep85kTVePn2aRdeyyG+hVSOwnFyF8YlqibisUEuADLWV5VN3FMcWFYCqk8/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KTyjsGH7; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757003723; x=1788539723;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HK9Kk5Z/KlPbEq13gY11MtGP6ep2Qv+ilBfkEZTtalk=;
  b=KTyjsGH7y4esTQAgpoJ8ON7xlg4mDC/W6O7n7GaYzFIGvSlBT4+mrgF7
   No52UYY9miMSU5X3aKK8zMPZxECrfFSPjak83w5JtD/dYrx0yboau398h
   ib2m0tg4F4r0FOryv4n16RPCNekTsuK2Pvi5ToU67/6EkxkdSaPvACLCU
   GxragsPFSg60tuuCX/s4XzdO71qVe2jWj9pK6l4k1PdpyZtRb97MggeUP
   LLdDMR3McTPkWqIJO+x6lOM1PFLnUG1652gi06BeiM9ChojjAkpiSnK0e
   N9Gea6rzmpUP+7V8a/e3zhow2Bw9rfw4rZPMiFcG99x9gkTekSwvMuF7g
   w==;
X-CSE-ConnectionGUID: kiAhWW/7QPiEHuO1XMwDcg==
X-CSE-MsgGUID: l7yBZGpOQKOzPFqJahCilw==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="58383727"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="58383727"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:35:22 -0700
X-CSE-ConnectionGUID: 9SE1Jpc6QnmBlqwxc/bsqQ==
X-CSE-MsgGUID: vnXblmDmR62RM2IM9JZpNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="177165420"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:35:22 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:35:21 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 09:35:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.58)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:35:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edEPbU/0DTN5T8oT/UmpLUeIDWRPhphBktdGFN/8HOpOMAnBtFdeNlAWhUBG7XW7qsWGa58EmPOfHxB+g76vKX+oRJAton5utKAJqiEiRgMRXRkVSoX+Itx08fZGbfNfC8Ctpm8ez4IhhHU9hsuctahhLPEtMbBMQL/Q8MyR4WZ4ndGbAtHWG28jxcTFAYSlhUc3iJoC1nSaLo1tW4cMYcTBczjfMtRDuQLlovoa93GNQNHhCJuCYwGN6my4JCkuK2AkvxjJmzM6nyoiuF+A+oqrXZBLl/cS0NbNdJM1CCxrdRZyIu3pDa7XZAz/ribXt/qi57k44y0oA5YcoZMmxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Cxrourx0TrHXiXtBAV2/QrlZ48s1fYS+zT7TpdPUSY=;
 b=NWOz0oXD1CCBdl6GG305xAh3splBH9V66UEvtkZdMCrZ9V+43/SWeDtV7n60PgWaxy2WIpgvI3YaIDAX/8blsSJBj3r20MANL/5H7mOkm9BDEpg2c7k7+QVXF4DsCgFb5cgW0bDRntcnbKiOPJvonKtyVZwNNdQQCgnGu+6VS6JzuJUwsTeXP7O04jd3JaWNjR8Y0EmcdhIbBGAJ3IymmhqGuAye3lUbUufsUXvZR+ieSW00YT3MEY6CYb7U8PJXZFqWE2yiWHiqn5anwB+pZmBWSzKiFY32S7Dc++Ctn5iChOvyqsEcdchjfjjClpaJ6P7JRwkb+etMDERAPelhmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) by
 SJ5PPF8225D2149.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::83a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 4 Sep
 2025 16:35:18 +0000
Received: from DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425]) by DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425%6]) with mapi id 15.20.9009.013; Thu, 4 Sep 2025
 16:35:18 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 07/13] idpf: add support for
 nointerrupt queues
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 07/13] idpf: add support
 for nointerrupt queues
Thread-Index: AQHcFqV4sGdo+Ifm4EKPGL5DKGGxdLSDMy1QgAAS6+A=
Date: Thu, 4 Sep 2025 16:35:18 +0000
Message-ID: <DM4PR11MB6455A8F3F8ADF06FF9A2B7D59800A@DM4PR11MB6455.namprd11.prod.outlook.com>
References: <20250826155507.2138401-1-aleksander.lobakin@intel.com>
 <20250826155507.2138401-8-aleksander.lobakin@intel.com>
 <PH0PR11MB50137C213B5616331E5960399600A@PH0PR11MB5013.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB50137C213B5616331E5960399600A@PH0PR11MB5013.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6455:EE_|SJ5PPF8225D2149:EE_
x-ms-office365-filtering-correlation-id: 449af131-585b-4657-507d-08ddebd10890
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?WaFybhXupnawzxGYgIRVcmjY11Uz+poHia4o3O7Z367wriolVWeroqMDWi92?=
 =?us-ascii?Q?0MfTCMTpQTguPi05K5YrAaGvdEUwaaEGOgDAaURs3GCEZkoyqArRKDdpc8JI?=
 =?us-ascii?Q?gsTOFDoD0YWhrQXKKbN7BRFac9+xMAaGH25J0HyrynEgQhnYJSzG2ravSLVs?=
 =?us-ascii?Q?iE9p7+A/tLiTjgIvkZ0v3/6ZhCVOAVyY2NWPsl8x+3/sm9aC1caH/6rhlzSg?=
 =?us-ascii?Q?33hkNRSUVLLKWmb8NasZTJl6BemByXnOUaVUj9/NuEeO0UHk0jn5bxUdroIE?=
 =?us-ascii?Q?/7IIyoX7pe+DsKvthcQvNHb3IW+6S4wjdhF0asgY/BqxuPendhC0T7I+NEMg?=
 =?us-ascii?Q?tPphmC94xoq2ht3UwPRmIQioPb3PKjHZtzi2ZnycqO1b/ASB1QO+GC+4TwLm?=
 =?us-ascii?Q?L3x9xD32MXEzx+AkgbY6j5OUAbCeeU0o6AQRsc085YZa61aFYsUHKa2XahQ9?=
 =?us-ascii?Q?sHFMSF6lBqcOp2VBCVRhvTpbuK1RjwDiAsEDpripdaEaHgzfA3BGM5qp27zv?=
 =?us-ascii?Q?feg7NtjfughoB/jcy7+laPGzVnrIR0v2Yc27kqTxpanuUgP6Vl0YyrKdxLkL?=
 =?us-ascii?Q?Hr0RaK0zmpqfjsHnXWcEoK0qMVfVxMOGFPOjSic7TfOGDyOYhAsmKWjTQoOY?=
 =?us-ascii?Q?dHXUvp5rcY+7R/31Sa8waY2zlhT3t81EsdZBfdkRZGGEE1CY8VIdR3SzFhCh?=
 =?us-ascii?Q?3jWiJV3xHmC+17QMbpDbHAxiW6aLTKZ2xFGCO8A8RV0/y1t0Mf3e0vaVxxyj?=
 =?us-ascii?Q?F8MF/DVZRogTqaR2Nii13VhyH4DPk/T8FyH0AjuqpVE/8o+niQ7XHsXX6Dwb?=
 =?us-ascii?Q?tYltGywp/+K955TlmqOyttkkaRTd1f/NjElU5RxmGWQh1vHto2rZDLx2Y/hQ?=
 =?us-ascii?Q?2x367iyeUbV6HLth8EZR42RF5H1isP7dvOaiWSMtfqc4AqjjDK5SqcVv6rqt?=
 =?us-ascii?Q?1iZxYSvrhtEl0erAxg0sPKBejHX8gD6fTH/O93nV82ejxgnPu4lSQ6pnt6p7?=
 =?us-ascii?Q?LEjCCBWtGrpTt9iVOZDVDytQuBaj9RjkcWLGIvJiTzOCUMFFcq+qpVj55hTS?=
 =?us-ascii?Q?nYCsaXPBPY0tALfGOVMW6p62BqmxoLY31a19YU9++TmzQeUS6Ok4iz2vTpwq?=
 =?us-ascii?Q?WtliVaTbCqKOdzQJE+6P5/a7LfTcFFXm28emHqD+33F/rIprL06cj4LIxuK0?=
 =?us-ascii?Q?jRJh2TLXe5q6cK8S/FbMMjCn7uKuGdgfHJvaHjx0TEShVSVCz7fjva1aFf+Z?=
 =?us-ascii?Q?Rt4ZAsUm4+eCV6vjXUGKylNgMWfd6nyAY+clJTxF9DPjYxZk4v/LqVJMfxgJ?=
 =?us-ascii?Q?BxhAHIgqoZC2RaSWi1DR6ZqSu+J0+OZK32f+hm2K88Q4IzrUMHDquJeHx59z?=
 =?us-ascii?Q?uWdWQKEUyX9qWmD5e9wGPu0uEPHhVlvtl//qsktZ5doS0Ca7pSufhSU0AavG?=
 =?us-ascii?Q?52K3AELMSaefPUxx7wamLy0Msgnc2tcj6HgEZfDucUNbUVJOaBqtlA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SIXy6RMiaPoyES/fUpXkrHs5o/OtSUCPDeeTwJIRKu+TYHGjC2jAfrTqeLHN?=
 =?us-ascii?Q?b+f0aMVdhyTIEXIWT7fZMGxueUmmqjx45f0GyqMftkL1GLHJx3/z8wxSmrAR?=
 =?us-ascii?Q?3rXL7rkTR0rbtJCgwYmZjTTcUuqUAhalwCWtcvJnlUTo3RbIK6n4swOxPRJv?=
 =?us-ascii?Q?FGiRbRB0ddRp6mcVh5F5MYKhGljkxQ3WZT3rkl0BdBxrAmc52zdGrObkx0dV?=
 =?us-ascii?Q?pKBoBWj/UURj0BidD6fR/HRLkx0WGLbMeDAnH717IM0gCpHlwVDLdE1DIUHC?=
 =?us-ascii?Q?1INW9nYfATa+Mkklige7KnY3xCtZJtzbUFIvdOzXgtY/mFZY2CPtUf8oa7Ha?=
 =?us-ascii?Q?iu9B+6KG7e8o9JZYabIQFdSVuWcxJmD/mWVMVodC1RAYwy981JIHgrKpodUh?=
 =?us-ascii?Q?fZvK02lQKzv1MCfgPipfVVVcXOJyp+bxTN8cI8D09IM0zYWh6pRb4MOyXfEg?=
 =?us-ascii?Q?L0AIcqhv0Jjwmnp3AzNMtYhqEQIMMgjg1s9d1wa4qjiReX+XJABZ2kPyOVNh?=
 =?us-ascii?Q?RChb8tJp7E+dNQq960RrkIHV+vzQL/KS+x9x76DJraRynFvia87h0cT7XvRu?=
 =?us-ascii?Q?ehCDpBWM4I2S5dsV5zZnCp2z5VNSBm1teHMfxPmdHleCEPuo3pMHoS0WakGO?=
 =?us-ascii?Q?eD0WAJ1QyX5rRlE+nOv718z6hWFM5ulbSMv4+G2hnxaY/qrMos5sVodLClAN?=
 =?us-ascii?Q?oQWwQCA5pSAxHWAMIBliqC4bx/ZmykEf2Xxsr1oLUHFfzx003rGwxaikXpbX?=
 =?us-ascii?Q?CWsreAuWS4Uk068TdF4bnNuJO/ofrOfeQTESm2N0T/ZTskPty0gxh5rkgLdq?=
 =?us-ascii?Q?O5p18RIa9uPYMP49CsQwvRAuq2HlAlq/cDGKQUKSL94Z9APWpU/G8tdAjrXT?=
 =?us-ascii?Q?dUbm8sFavYuiUKW0NjS8HW2IsDUXAri6IDiPxDbuYYZV0bF76A6/0n2vV7SR?=
 =?us-ascii?Q?s3qjGH5U41vBZgnmNz3jqaXQ4RtkFGalapVIPGelbQij8FG9DsL4opNKUO9X?=
 =?us-ascii?Q?NjBDJDLSluop8rzO06ABv/8LkVJ5KXYYEbXH3VFE7m9CO3Sa5357Ny7cga+X?=
 =?us-ascii?Q?KyfwOKjlwWWCvu+9LpoQ3+rBSfvaPp/4utWm+0ApYthCEg9tWMKdkqPQfyWq?=
 =?us-ascii?Q?kg77Ep6tiGoieLsq2DeRBopAIAM/itVVn+c3d5l9++1vCjv7sl17/OezEWqO?=
 =?us-ascii?Q?fF1iEz4I+XH1V/s/wBLA6OBPyEQ4ZrTl6lmQzmD9MNiznXfQBtRhpo8fTMe/?=
 =?us-ascii?Q?c0ZesViZhmMXg9wQum8mWZ/dlGaNoeK3qw00CbVdDCq6JNgDvjpDyhHs35B0?=
 =?us-ascii?Q?CKFtld8hKiTFo0ECERVRPRGFotNR+yCDZQneXxE4OAu/+WONEed/Yj4iFU6V?=
 =?us-ascii?Q?CmrZKk2z3WrqrvE9PzO5mDNSP8VzO2NdzBAvmaIZA0kLlL1tIypyXbcuxmyk?=
 =?us-ascii?Q?rMaxdyoQNIvdXK0m9OAzSN7y1f5k5Uzc9pN0GVEXMVyUQePAmizgXymB1dHC?=
 =?us-ascii?Q?KJ0pWZllICK6pnukWVRCBi+8MJtURENTXSNzFTZITQnTz/xDkf6+UpFKg+8a?=
 =?us-ascii?Q?noeGDMW6ERVEXko3Aa0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 449af131-585b-4657-507d-08ddebd10890
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 16:35:18.0312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KEXBCpPv1kmgkLnnRXZV1Z9urnj6ehQuxQSvWezR3eRwtoSpXsHvHGhBwgs5Iq3TpK643IHkcAWyKhZblmbsmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8225D2149
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Alexander Lobakin
> Sent: Tuesday, August 26, 2025 9:25 PM
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
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 07/13] idpf: add support fo=
r
> nointerrupt queues
>=20
> Currently, queues are associated 1:1 with interrupt vectors as it's assum=
ed
> queues are always interrupt-driven. For XDP, we want to use Tx queues
> without interrupts and only do "lazy" cleaning when the number of free
> elements is <=3D threshold (closest pow-2 to 1/4 of the ring).
> In order to use a queue without an interrupt, idpf still needs to have a =
vector
> assigned to it to flush descriptors. This vector can be global and only o=
ne for
> the whole vport to handle all its noirq queues.
> Always request one excessive vector and configure it in non-interrupt mod=
e
> right away when creating vport, so that it can be used later by queues wh=
en
> needed (not only XDP ones).
>=20
> Co-developed-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf.h        |  8 +++
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  4 ++
>  drivers/net/ethernet/intel/idpf/idpf_dev.c    | 11 +++-
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |  2 +-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  8 +++
>  drivers/net/ethernet/intel/idpf/idpf_vf_dev.c | 11 +++-
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 54 ++++++++++++++-----
>  7 files changed, 81 insertions(+), 17 deletions(-)
>


