Return-Path: <bpf+bounces-36210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 932B1944553
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 09:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59341C21B3F
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 07:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05954166313;
	Thu,  1 Aug 2024 07:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mKs6ICSV"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2A113D636;
	Thu,  1 Aug 2024 07:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722496832; cv=fail; b=LDVsFY0SZ2oIUVap+c9ock+JBFdLrtQ/5lZwPYsUDjxna2ecCXz+X0fTWHwMoUrS+k7nkSmajQf2gzAb0wVFShHxsXs27ElUsWFfKerPxC0sWuBh+K8sdRV4JOWeygeKzcDo5q2Mcour4ZhLd4cFqvuzj2RCxcpd6b84Izi5B/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722496832; c=relaxed/simple;
	bh=yEKd2JNv56mR7VZz86tTIrPd8vs3g6rfwrVMnzr04po=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CMF4Wx33dJogOBpizzzrqqOPr0KOmK6+b1/MqxYrhw5DJrY/ZAqwLt3KaGuoWqsBj3ZVg+W+8Rchxz1GZg5HSxpfsGxXxrfeWbrDq4D9Ov30pPBK0n2I02TRx3J0retny0Tx2wAodZ0MfUkXC7rxSkSGNJx5sHqLJY5/ZCzmKoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mKs6ICSV; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722496831; x=1754032831;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yEKd2JNv56mR7VZz86tTIrPd8vs3g6rfwrVMnzr04po=;
  b=mKs6ICSVu5PPFHRJdh0XZTSZoQZ3Psfasd+BOjBJUcM/mdRcP+YGtUSP
   6QJ6zjtqNNy1eiWYmivMAUz6ouA2LoMtFIPR0YAokJvCZFrCHuAIQaPaO
   XQBEvKrdUP2NBdJVWPLo8pt0kIooCd1kYI87jEZw2WHwR3b4Fdtiy5CTt
   jjEdypNsRoUGbK1hzay2L1nL+w7DtyyG/ODPj8rDiPtfblONkEkBwExWU
   DJfa89DzXvMquEJt0Oev5XpnAB8bCsSOWCeQceVFh0bqiqLGJkcZgN9BN
   RjAecpI7rJlJSuLiJSiVgoGCVZlT9OElIGCQBDKiOSZk138iXOQ2dY9mK
   A==;
X-CSE-ConnectionGUID: OHTrE9juSX6BDeLMdDbTZQ==
X-CSE-MsgGUID: l5SqyxSJSHafTSKxV0cvlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="24194436"
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="24194436"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 00:20:30 -0700
X-CSE-ConnectionGUID: Y0bidTUkTyuNuwQbGt0mLw==
X-CSE-MsgGUID: RGbg9Hg9Qo2nIdvITla1Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="59263039"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Aug 2024 00:20:29 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 00:20:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 1 Aug 2024 00:20:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 00:20:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehmRVG728kTWg/X20HaCTeUc7+Q7XGOAHrYtpjuUVnbc8/3TqpRM0YwXerD5m6wOZUPgtJ1WeKzlFKU1JdZGgDd+gyFpZLnk06HOpGFVta4sOynSKIFMYzm+WDaWNZ9QLS6NmzGils4HiWXRtj9LHYk4tLUfy2Qju9DgvUvqN+NQ6KtM8OYCLBRQp29n80zdALi8RfC3s0+wi7OhfVBs6BdTkAxQNJCmTaSFUpYFgYgS0A9bDF0OhaP775u+UqLhNXNxewzufP7yy3LZR3IN38xwh5YXNs/iAnYEtyErNuTzzsfZU6Zh/mnflTmAMlIf1xNfcRA16Yy/E1J2idJjHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCyV+r+ZyT7n9UigXLx7qLkSeygqp+3PAqTqszxNwK8=;
 b=Zqwgd9o30Hj3st5OBhbNJGKnPaD/51rB+Z/0GNkVcP8IsjAdaqLwkCEUQrOepbDMlPxQmt0qLla87RRvHdQq5IDJ9qwIvaDe4Yzxr2UBEsbSCSnYrY/2UBEvOCdwNGvk+tNWoMEgjxUaZhXiMPmzt3l6+rVGrbT2Cj+j0qgaMKU3ZuQAKsPlTUaowOmmTIRpQNGs6JcaP9BoMmH2xcBDjIcinLImCCORqffeR6yI/IUNMwYajr2MYAb0pAUA4HowXipLlUrSn/7zbT68b+Vun+GfUr/K21Da7k9VW5znLIGy2myrUDU5KPNKwEoGLNVKz7sMOZlAux9GiuOtZHIhYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by PH8PR11MB6832.namprd11.prod.outlook.com (2603:10b6:510:22c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Thu, 1 Aug
 2024 07:20:26 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%3]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 07:20:26 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>, Jonathan Corbet
	<corbet@lwn.net>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Shinas Rasheed <srasheed@marvell.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	Brett Creeley <brett.creeley@amd.com>, "Blanco Alcaine, Hector"
	<hector.blanco.alcaine@intel.com>, "Hay, Joshua A" <joshua.a.hay@intel.com>,
	"Neftin, Sasha" <sasha.neftin@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [PATCH iwl-next,v1 2/3] igc: Add default Rx queue configuration
 via sysfs
Thread-Topic: [PATCH iwl-next,v1 2/3] igc: Add default Rx queue configuration
 via sysfs
Thread-Index: AQHa4h84HPiCRxyxF0yMxQmh+zwEy7IPCdUAgAL14HA=
Date: Thu, 1 Aug 2024 07:20:26 +0000
Message-ID: <PH0PR11MB58307F45C9803E808D7F984AD8B22@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20240730012312.775893-1-yoong.siang.song@intel.com>
 <87plqvjj5h.fsf@kurt.kurt.home>
In-Reply-To: <87plqvjj5h.fsf@kurt.kurt.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|PH8PR11MB6832:EE_
x-ms-office365-filtering-correlation-id: d76a3f81-cebe-490c-0c09-08dcb1fa6a25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?cvJdOJZyqSF+1Zg8YbzS678pHBbnKUY3B+757Ou0qudTnWcwPnrpqO+MLe4j?=
 =?us-ascii?Q?8PQ+kTH41VDkUOljXTVw7u924xNbDyu7rElWrOtBOE4rtpWkMVTcABZDMpij?=
 =?us-ascii?Q?eTJDaudXonbr/vwVWtR6ASmIuN1xhMXE11NNGttcOukT9oGIXgIrmwJIouGA?=
 =?us-ascii?Q?DRI3fjRvSLcdueaR/XGjT0lwHlFGPY03TAyc2Q/3IG72JCBhyDH+DJ0Ns8vL?=
 =?us-ascii?Q?/KBEmtlgDojx8AfQQuTEQ0R4L+vnI/ISRwA5DPyv449heRUtpIPJALRoXif6?=
 =?us-ascii?Q?6tDKNJKjJ8ZXuuW3QWJ+v59RSmyxqCc2e/0RYjv9u2s2Pt0Z3/T7yzqCdJ+Z?=
 =?us-ascii?Q?zMt2AiFayQ4kEr/rRAibhtRlsYs13tXxAqV/Bl3GuTb0yqkEhA/BqcMWv9tQ?=
 =?us-ascii?Q?Zd/Vsj2J7SXjeILQeSytVqOysG6Xz1Io4JSf2vBoMwrCumsqNZHW6kzGXQ+C?=
 =?us-ascii?Q?SqJONw+R/GNWDjTTFLAzVIsO/3bQKFkVPMoN1uaLZF5mKZeeRcsJbsGdBsoW?=
 =?us-ascii?Q?EIaNtecN50I+kz+S7eDqKlySuqekco3TMb3e6ADOg8GImctJI6lCqt7JaOLB?=
 =?us-ascii?Q?q7C/UWoE3T6mYuSRH8JzZByuBzd78VpNbSXibq7hS0Cef+h9nlx02O8A95P/?=
 =?us-ascii?Q?V56a/5chCCr/+65P9vtY8JnYFIc9Jln38DfyiTWYkPbEfwb46Kp2zzUXC4y9?=
 =?us-ascii?Q?YMz09nCTWC4tgQYV6paJVmwc6Rz0HG4b+L9v7xqrmMVr5X6Q7j/bTlTnKx/F?=
 =?us-ascii?Q?PRYSwvceTXIzJm/d45jbvLLoppsFKOKzGb7wXJmIrIwMSTUjYejQ9C2LBumP?=
 =?us-ascii?Q?XnvbcfYZRwoHbqgMEG4fYsUXSE+YhjW3Yp62bqktXZ/yaxcj9tgPKeGWGIRF?=
 =?us-ascii?Q?EwxUrzfcCzd92NVqEJ+faiNEP8C7656ToTH7LUSKWGms1rR4GrhiAd+/V5J4?=
 =?us-ascii?Q?dNAFtglG10RG4OxfhZ7wz3DksxF0LiahtEpNeCN9eUZYGFzd2iFUGMyhH901?=
 =?us-ascii?Q?T2RpbG1+7ksN2yNuweKFIEnntZdPWxdRhSikBBak+rRXvXO4eP5h5gmscoLZ?=
 =?us-ascii?Q?p6DDbzOdfX0503y5W8aSBPCRXNEbnpRlYNxvpHkuIVX6VTDjxxkdQA7R7h7u?=
 =?us-ascii?Q?DRRSDCijW81qtfPuuGhu5Tz1vOK/KUxMrk04sGIgkDOefKWGY8qDEKOWgjNW?=
 =?us-ascii?Q?1r0fH0wkHY5ZPxuQ2WjahbvPZ2KEkdrFbGK17HxaGsWfiHZgeq5nWCkbLk2E?=
 =?us-ascii?Q?x25uvy8n+0K/YaRCYe2WkxVlm5O0UEzUNsrtBfiOQH2y1MC3syWADDUg5oBG?=
 =?us-ascii?Q?04aoPtg5X2oV2eIT7cGWbKyjNN62thryUUYPFKHhgVGzJTXxYXSpYvolutHp?=
 =?us-ascii?Q?LnDxe8QzeVLP5X/bfVq+lv5J5UGqxBGiKLHaiYiTANrRJ7xRSqr+UFheAIOB?=
 =?us-ascii?Q?/eeYWUhhZyM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xKgICA0xv/qBSVV1uCjHwQPKkvGQng06flH/IGJyNIEaRbAa/4hGjvURyNBc?=
 =?us-ascii?Q?QvbGxXfkINQGY5uH1Y8xmMH8+0eYQTham7qCqXMgm1dfYmjWJeajZcPW3qIk?=
 =?us-ascii?Q?Mzx86sozo2L8t2rxQ/Tlp3jsGA/dF3VPzFseCQRTvXXhFhMO+SXXtmwWrw5A?=
 =?us-ascii?Q?nSrVulJrRwO7IeJsWuHv0PSOg7lxyRspsVAc1OSd8R2guDYgbGItA1oW6pvj?=
 =?us-ascii?Q?FJ0jcGFuWfMC5nPZOcGIajDXy8JAg5bGHaFDe6mrAtn/9xh6sKyDgh6PbdMi?=
 =?us-ascii?Q?x/mv8bmoQr6+HVrxUeUicZ7TuelOdxRaGhUOq4rJy9+wR2jsbwKPg1blOdn9?=
 =?us-ascii?Q?S6V2sz2BOLnF2F2a8OsfVSF5SAm0sU1uYt5swQMWUBo0fK2v2bBKlXNYFxTd?=
 =?us-ascii?Q?cQYfOkMgSCryXQOA87TXWrwD9YQCSEUwUYfSEkRiiF/N4JIRkO2ubc/UgmHU?=
 =?us-ascii?Q?XUKPnCv+hLBgWg//CvhPRbIZFP7IZ/fQksQtoy+o4ZkId4G5DrgfOpDLXHdy?=
 =?us-ascii?Q?sGSA7QfGispCEvIgYhWM97H1z+CCvnEgxN5Fi57yFwDBpe5yZRyrzcm3radq?=
 =?us-ascii?Q?4lQdb2GAk+DRq+8WM4apoYl366QWdlK0kKPDQFEQJUuLKSK1w3u6uy3e3Qhm?=
 =?us-ascii?Q?SnmM82DborMaQ2k0VB0Qn0mhD6A4UujR2OmMa2p7pyOA5nCmHhPGPb/v2V6L?=
 =?us-ascii?Q?pIIfUMSgQ+mkk+L30Ils9yNSMXasSbZ6Rtlm2WAXuA7cNYGhM9ltczwfWHyq?=
 =?us-ascii?Q?MKNDQf2VDcwVUGiNQPCGfrrugbucIlM2w5+OzFK4oHSkNCkpNEqgqg1diBCC?=
 =?us-ascii?Q?g1aaJyadLyEOj5RSsaF+BW9y5Nw7gdhMN1CHdh0qda+vBDPkISDegH/bumFS?=
 =?us-ascii?Q?lvOHrHsEJ6JKS/TI4/Si+WFvsik1jYh8USzBIkNbz3TViUDYr3tf8ENurWSb?=
 =?us-ascii?Q?ReaA2pip9RGGCa2F6aPkAN3tlixCAJWfr/EZzJSc/wj4PRU5cx/SJxbpuMv/?=
 =?us-ascii?Q?P2lGGSMOP8sMmKptFNW11jL/FyuWV5pCp/DjnGlMWO/eRbqvDmY+DLhQ6GRs?=
 =?us-ascii?Q?jhB8ZrtXbqKM0RAcYDnjX9vtIlIFvdv+7P61KmhCUjJ8YyuchLDQdze4RhHd?=
 =?us-ascii?Q?AfjZZWpdTFkUVIuCECqkBmW8814EQIxUcJix8l33WiaRocLufcE0zopJHUg7?=
 =?us-ascii?Q?ftjb+6WAmkegbJGOjPAPoprMDTiyviASM/VnLfvv4lQGLLBpqxQU1C+0dofB?=
 =?us-ascii?Q?hwwQh/rSDAEKNJo+JLxN5BCRQwKZUKfNipBrQd4kocEhCdULeY/JfWOeWYER?=
 =?us-ascii?Q?nYLJw88qJnfLH+ZQmI7hDj1Qo2DqokHKD44PZCtXi5LC8M1dFTeqvKNiAfiF?=
 =?us-ascii?Q?FK6T7+0crdQaIofj92TvewxtDaX8nf6tHENYkIRQBPrGT30hM5q6nLpu0FxM?=
 =?us-ascii?Q?3NgL81z7dTAeaMmE9qLRLCyRZv7pYryJv/17IyxEqBkLyyh/fphK4SNIxlwi?=
 =?us-ascii?Q?VOadrGWOpxZctDc85CV9u3JkUycHSP/+2ogIr+ksexlZRJ7nimJRMYYI4nkP?=
 =?us-ascii?Q?X7VscW6/kYa6Cim+vhNX12evkBC6gghDkjfJCgjlabNzF2cf4O3mKJnumCbK?=
 =?us-ascii?Q?3Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d76a3f81-cebe-490c-0c09-08dcb1fa6a25
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 07:20:26.0362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Ja90x4efAIflXhki3FbKwfvGFMrflKPOZ+I154IpGz5Jhu6DeiyM2lk9dsQoepiEOACdlX31ukFwLxr2E/lg2J1MAtPgj+D18LMM99+7NI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6832
X-OriginatorOrg: intel.com

On Tuesday, July 30, 2024 5:59 PM, Kurt Kanzenbach <kurt@linutronix.de> wro=
te:
>> --- a/drivers/net/ethernet/intel/igc/igc_regs.h
>> +++ b/drivers/net/ethernet/intel/igc/igc_regs.h
>> @@ -63,6 +63,12 @@
>>  /* RSS registers */
>>  #define IGC_MRQC		0x05818 /* Multiple Receive Control - RW */
>>
>> +/* MRQC register bit definitions */
>
>Nit: Now, the MRQC register definitions are scattered over two files:
>igc_regs.h and igc.h. igc.h has
>
>#define IGC_MRQC_ENABLE_RSS_MQ		0x00000002
>#define IGC_MRQC_RSS_FIELD_IPV4_UDP	0x00400000
>#define IGC_MRQC_RSS_FIELD_IPV6_UDP	0x00800000
>
>Maybe combine them into a single location?
>

Hi Kurt Kanzenbach,

Thanks for your review comment.
Sure, I will try to combine them into single location.

>> +#define IGC_MRQC_ENABLE_MQ		0x00000000
>> +#define IGC_MRQC_ENABLE_MASK		GENMASK(2, 0)
>> +#define IGC_MRQC_DEFAULT_QUEUE_MASK	GENMASK(5, 3)
>> +#define IGC_MRQC_DEFAULT_QUEUE_SHIFT	3
>
>Nit: FIELD_GET() and FIELD_PREP() can help to get rid of the manual
>shifting. See below.
>

Noted.
[...]

>> +	return (mrqc & IGC_MRQC_DEFAULT_QUEUE_MASK) >>
>> +		IGC_MRQC_DEFAULT_QUEUE_SHIFT;
>
>Nit: return FIELD_GET(IGC_MRQC_DEFAULT_QUEUE_MASK, mrqc);
>

Noted.
[...]

>> +	mrqc &=3D ~IGC_MRQC_DEFAULT_QUEUE_MASK;
>> +	mrqc |=3D queue << IGC_MRQC_DEFAULT_QUEUE_SHIFT;
>
>Nit: mrqc |=3D FIELD_PREP(IGC_MRQC_DEFAULT_QUEUE_MASK, queue);
>

Noted.
[...]

>Thanks,
>Kurt

Thanks & Regards
Siang

