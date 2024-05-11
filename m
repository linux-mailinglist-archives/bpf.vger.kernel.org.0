Return-Path: <bpf+bounces-29578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A198C2E5E
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 03:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001C51C2175E
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 01:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67847D52F;
	Sat, 11 May 2024 01:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B482hnK0"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD511D2F0;
	Sat, 11 May 2024 01:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715390232; cv=fail; b=Te0Y4J0HwzB7s5wJcdYOW7c5CmooGoLmjocQGqMRbRi32jUhiod/vaJv7264YO9GL64AVUn9xtY7PUruIZN9nBAFO9sHWSKYPmjoXnWL7QalaKHqWUVX7/Dx4eDvecjMeB47w6ChV2K35WvXgikloqKDhXVUdvOQWBTXJilOOmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715390232; c=relaxed/simple;
	bh=5PTzYr/zMAQfcfgoe3DJspHWOjU+6tJzSsnBVB3YmXI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nyj011xmi/M17IAeVp+2OsqsNlaHO4O8150EAw2vcI4ZkAO19oQU/h1YDajMpNm4E+DskACvK3BCFhU1UlfxyQRKhvUROsdUw0lnRtknbAZOzTQ4pZTDLo6hqjCaoJwfAeRHDlIRIJs5XM2msDQHgR1djyMX1y1Yx+wLWAU89hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B482hnK0; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715390231; x=1746926231;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5PTzYr/zMAQfcfgoe3DJspHWOjU+6tJzSsnBVB3YmXI=;
  b=B482hnK08CNDqhKx5mnDU7dd1N5PtYFuM7Xgo4YctbmsmaiXOEHP+gr+
   VHYrqA+kYavC2kR4+Wr09V8ivADpZWLqRZG0yg0w93hGLMdivIVwXCS0N
   iuc7W0cmjrxjHsRULUHTShnNbGjtmRMWC3J9zgDoR4VhndWD2Khd8wp3Y
   dOz2oq8MTX04CGYW1OiEmbPRgZ8zVxOFRpqVQumKYWCQ7wdqIhFEF7wnp
   GtAuRXjhQCEeHK9oRxzaKerNpBGRFf99nvoy553UP6MQSriKDI4J+1DmD
   ZMf65fwv9IznCG90sZkK78Un4UB0ykxLZ0aJruq+55EkR57OF3lQ/K1hY
   A==;
X-CSE-ConnectionGUID: vsVrzJ8CTcK91vF0GqjkpA==
X-CSE-MsgGUID: LVmB4ED9QsiQl2nQ3urWFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="14344266"
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; 
   d="scan'208";a="14344266"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 18:17:09 -0700
X-CSE-ConnectionGUID: ldpt4ZymTeOiapl5UqqoAw==
X-CSE-MsgGUID: W/r22RCZRtywZHrnbM4v7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; 
   d="scan'208";a="29797147"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 18:17:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 18:17:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 18:17:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 18:17:08 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 18:17:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1sjcsoF6z750nbN+vWhoAycs6j/VLzHt4bIMnRNqTMuV9eOoLVk+eOw6IjC+/YOJSGrXaH6kjmwUzxeGtbFV9v01ZaciBRDRIflzK8YzilYBUN+W7Ib1EalIG5B4147d1xoReSo/1htgUj2lTnFAwErvSF41thMp6OK23wd0wlL+/xykdrS9biNSANhLYL9T8JS0qI+7I9GC/Fm6bwL5xE9ya8Irc4bv7O2y1QphSXrg6xdhXFBlBECKI7yTG+LJGilwlRjRnr+cjYTxN1BePvxCSnp35GpBl7By7QAAsjgCFmGm78ykCEbqqL+D1bJqgAcWSDtbMD3mvhFU4/7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oA9wvVkSIyDvJRcmIXB9NFWj96/UWxVuOaqtXhLW2k=;
 b=jqLMEQA4sPOxQX0pT3sVtI1uUOE/tmgZVdMpIzcpeUoaw1ZzYbh5jE5ES7PpDaTc0u5nnDbLb6Ivo4TF0/pni7u4iba1hbWYkyRkPx/EZaKNjzIj9urinFN9eMmEMBTFULVXWcVAVl5ld0/zIwkD7qYrj63/WYvvPZ+r3U7Q7lE7+fyaegbZDRkp9nN8z1WV6FM/LVXlSR3jFgbH5mwq1iHPNAgzl7HtJA6YPk+fU9LYl82NGhbybOtrfDmQYlC72oHd1qnwOFVy2X39oW6zKSt2j3IZjg3gxl90QUKnsJa+YPkNrj3bXrSHd6OV79sIFoQO5qT8XCu83rdKxH3eTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 PH8PR11MB6610.namprd11.prod.outlook.com (2603:10b6:510:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Sat, 11 May
 2024 01:17:04 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::abaf:6ba7:2d70:7840]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::abaf:6ba7:2d70:7840%2]) with mapi id 15.20.7544.052; Sat, 11 May 2024
 01:17:04 +0000
From: "Wang, Xiao W" <xiao.w.wang@intel.com>
To: Conor Dooley <conor@kernel.org>
CC: "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "luke.r.nels@gmail.com" <luke.r.nels@gmail.com>,
	"xi.wang@gmail.com" <xi.wang@gmail.com>, "bjorn@kernel.org"
	<bjorn@kernel.org>, "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "eddyz87@gmail.com"
	<eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "sdf@google.com" <sdf@google.com>, "haoluo@google.com"
	<haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "pulehui@huawei.com"
	<pulehui@huawei.com>, "Li, Haicheng" <haicheng.li@intel.com>
Subject: RE: [PATCH] riscv, bpf: Optimize zextw insn with Zba extension
Thread-Topic: [PATCH] riscv, bpf: Optimize zextw insn with Zba extension
Thread-Index: AQHaoGtgQt2dALTuk0aEsDxXE25q4rGQ+B6AgABIbUA=
Date: Sat, 11 May 2024 01:17:04 +0000
Message-ID: <DM8PR11MB57513749704B776A9E51151BB8E02@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20240507104528.435980-1-xiao.w.wang@intel.com>
 <20240510-essay-subwoofer-e055375ff1cb@spud>
In-Reply-To: <20240510-essay-subwoofer-e055375ff1cb@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|PH8PR11MB6610:EE_
x-ms-office365-filtering-correlation-id: b5938b18-efcc-4781-be34-08dc715811a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?Windows-1252?Q?pXARCVmF4pkpv4oGLZD1WYWFth8SIg7cf5dQIpCD4vn0uZTWwtnH4Hsg?=
 =?Windows-1252?Q?yZH3UjZGIB+pAVJNKa1mMw1tstitmhLAlq2VDvziJA5clS3IrsAM1uCN?=
 =?Windows-1252?Q?qyimSNAofXnd4D/YjQ14bXEdfnFVTsLtAd7nHatgRM0alFIpuOdQBaPv?=
 =?Windows-1252?Q?CrZnFLHdTJg4/NiboHX6+jKnV6k9tgaNIogYOu7M3UMIvhDCCTSGzcJI?=
 =?Windows-1252?Q?i/tdH345SRc4cNli3Zymn86TXzNUaghQjKfmuC3X8z99AXwMuuvMN0tx?=
 =?Windows-1252?Q?UHo9BmVtL7PDQPc+7U2dheqIqD9Yfz1YTLInUUCtSe/hC+1keZf57pP/?=
 =?Windows-1252?Q?s7wC9vavibXYGo4SLuNEbNapNS1S4H4xMMJHjpYlOWIwjDL9nLn9lLZr?=
 =?Windows-1252?Q?ySDDDuXxIJArrnmTw8ujaMrPmDTVBpZJsfK3FFQPCdFko1+UH7HqbjBa?=
 =?Windows-1252?Q?/TOx/iDm92IYStmHCS/kCmmUk50XhmU2XZGwTYGZ9Er6Yd72TJt0dMZZ?=
 =?Windows-1252?Q?Ik24DUihvamy/YKP41RTSii5Tygn3c78qOErddRglZEmRDx4x5wTWTqJ?=
 =?Windows-1252?Q?5Cr0gFsM/PFd0RCbYTGArYGo1ON8GIsQbWjSy8wxdigt/zNr5PxD+u0/?=
 =?Windows-1252?Q?oDt2hrYWgEip1E8M577/mx5LF30iOScNPyG2BUSC4/fItNiIn5cQaybL?=
 =?Windows-1252?Q?+aJDPoQVgwtWwy9PZH7vTBN8G/I14xlZeqcgKnGDlAZjdUH5PJYmlz3R?=
 =?Windows-1252?Q?g6x3NbGkK7WkWQdeVbAxpcMgDRmkMP5yVX2jv7QsRPcVDHaCkJ59uKUp?=
 =?Windows-1252?Q?tJZFgzgMrVmEZiPKc4rqa1r0WyPL/AkmfNJorheCMV0MeQPHZzFspf7y?=
 =?Windows-1252?Q?PLpFrdBidBhgl4WTvCpKgffpIHF3IwuPXJCBSKVcV0Q7WQqc0ooFR2iL?=
 =?Windows-1252?Q?+cEcK8DedTnv7cSVCMCF7tpoojRKHxi/DfSeb3x3i1hCpJvztw/Imwmf?=
 =?Windows-1252?Q?1Gm3nN7G33nqmAz1AFPO9HDQMwZulwZXLwoJ1R4MN0UdoWOcNuQ6F+W+?=
 =?Windows-1252?Q?eufRyq73CHb3nASn2UnSK653djCd+RfdTtWJzvRYb42qRGxhvhjlew4/?=
 =?Windows-1252?Q?0khrkDKFe5+BQ1TomNHhLWXNQ2jXZfyrVEkZiRZEglMmpk/urvyzMt9d?=
 =?Windows-1252?Q?4Ftcg1qt/weDUFDmp6MOHCVe7F4NasZIMan8cOAAugtbr234GooB8JQ5?=
 =?Windows-1252?Q?7as/b1wdeicLTgBns4p3rPkrLB8VA76PvPC2QZT2I1PvNMB+uIAxANZ8?=
 =?Windows-1252?Q?p1vyehMm2VfhSfrxzgtrQ1FMhUOKrMzrDW/eenwadkgEYcMbDuL0e1oR?=
 =?Windows-1252?Q?dX0Pdnz4JkUfLUDxmbTgRZ5Yp1GptCrjtVQ98fYDDfpvSxA6u3J+Wn/p?=
 =?Windows-1252?Q?ed0iymHjSu3LvwYCkElT9A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?aB05xWqxCFQL6p0UbF0KukuAxHTUh1XdM1cjt/VV3MZ+ih08BeOoQg2f?=
 =?Windows-1252?Q?Mqa06ZTfGYaQixJsOGImQp4QbUQwfEba+ExaoAeW3ThAap0h7lWiUUSc?=
 =?Windows-1252?Q?Y1Aqy7T5DMgaNYkLtOskJcYqm0b0YfmkrzC1pz9q/7/aXKj0mnl11B7p?=
 =?Windows-1252?Q?HKQIskKD15dVcvf7JG1AaIei0Ogp+sO5LkIUmlyxQbCGZxTXdMz7tqtg?=
 =?Windows-1252?Q?5kkQ+beTGxZLhbOzkRkZi8OMNEPLyrZo5qzz3hjPfvQx3y1PshzMsZsy?=
 =?Windows-1252?Q?LjkepcanMx5bFDPaBsju0XSSZ2aQLUcUCxkj5A/oTaYsrD6X+8MAoese?=
 =?Windows-1252?Q?WKEyGXjTHHvmhuDm8BlXdgO8z+IzQB9Vsdi1UlSzw9T4BwJHoQb3VjsM?=
 =?Windows-1252?Q?JBLrp879wCo0XoN1UIBMIBZ+4i2cy040mUah78OsCyoOlE8Hg9+/nbW3?=
 =?Windows-1252?Q?+fIjuF2hiXTp6RljcQA1Xr95ld5D4hWlL7XPdkfW94iK/5XEMsBIPwRt?=
 =?Windows-1252?Q?CURBzO1KuUqMnoHoaf1c0zOmkn2eP/FwHKSiVcZMzTVtgm2lyLCjKbha?=
 =?Windows-1252?Q?wCvXAYltIzVY9+ZxuZmE/FO+H12w9vdN0BzcTbDKWxRwJaOKaJC7UYP9?=
 =?Windows-1252?Q?TmBe7WDIdLQSEZHvZ5yXx6/tIhR0lXbD8Hva3dJ4hEnsvbeEJ6XnGKWR?=
 =?Windows-1252?Q?gxyOG+2i840dZwcf8esOb65NSEP6oECKt/CG55cJIz2NbkVOCo/0g/sJ?=
 =?Windows-1252?Q?53Rh46KGXgF18JsJR/geDxdaelnSmaSLFCiQuPMJdf71L10pyKGEmlou?=
 =?Windows-1252?Q?+8o64XDo802ZQw+2wZras/9dz+F+70etuP5LN+KNCXFjPvWxuM0cTBzm?=
 =?Windows-1252?Q?NpioCtA+rkjQ/CVrcwbq8n6hoq4eObCh5vRpClQo2UI1VfWdwV9S4hxb?=
 =?Windows-1252?Q?JkMkCNxSkywmli0ZNyO3RvIEnspcZzmVludgkwAUuk8qWG4C7AIjcPqR?=
 =?Windows-1252?Q?SMZRpMs7MXhe6mx48Hw3rEexqminRjW8r8Y4DfxZeYZXHbj99BldV9AL?=
 =?Windows-1252?Q?k0bdLQg1CIeY7SMXtCPsHkLTOKvqRDCMRyOOMbnG/PrFneT0g/UJTDca?=
 =?Windows-1252?Q?7uCE5OhCzUj/y2EMWH+wAtZfbvx6lFK0dzc6cr9Swarrf7WxqoCMUQts?=
 =?Windows-1252?Q?oSH/MeOFVeQ7T95yy5TO/rkns23QAQe/BZkBb4u4bC02uEC/4B3l91E0?=
 =?Windows-1252?Q?2jcetq9TGzVBu3MzbalFV8sE75291cAyTP+swsw1yqEv+N+rblpqMhw3?=
 =?Windows-1252?Q?I8PZREpwzaUlyecEaFt6XF4Y2enOAXkrtxsSN7Hf5Cf6x7mcxSNT4+aS?=
 =?Windows-1252?Q?PPGHGSMXKLSyt7XV0x08UO0JJxEgrKdox+fHQSRuAjMZi0Qlf2I9w0TX?=
 =?Windows-1252?Q?AhVUY6emcWUUOp+EyvAUng8rzRUIY13sZx+fj2zNAVAKWkEVgJdusDS9?=
 =?Windows-1252?Q?Vn0ofPV2hWhVioxxc1bhFsFAyLWNss6B4i69vitp6NlRxjHZx0+9AphG?=
 =?Windows-1252?Q?kVhYhMKFuzX5hNSFeVDRLR59GPFKrfoljS2dzj4ZKFxBuuE5AEjazR0n?=
 =?Windows-1252?Q?ORzn2tj8/Lc8KstLnDpySt4m9Vc9c8lynwWd2OA9GoLaG1j/yFQqedu2?=
 =?Windows-1252?Q?vSVPRqwHUqjaJ0xvIzqx41q5Bbo1TvvO?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5938b18-efcc-4781-be34-08dc715811a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2024 01:17:04.6793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4N+JrSk4WHZKH7UYV+EeDfAXUMVxiVP0b/cqkIpuy07o0ez8xuHelDvuxWg5JuLufIjcxGSgaWvZOkqcLegpAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6610
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Saturday, May 11, 2024 4:56 AM
> To: Wang, Xiao W <xiao.w.wang@intel.com>
> Cc: paul.walmsley@sifive.com; palmer@dabbelt.com;
> aou@eecs.berkeley.edu; luke.r.nels@gmail.com; xi.wang@gmail.com;
> bjorn@kernel.org; ast@kernel.org; daniel@iogearbox.net; andrii@kernel.org=
;
> martin.lau@linux.dev; eddyz87@gmail.com; song@kernel.org;
> yonghong.song@linux.dev; john.fastabend@gmail.com; kpsingh@kernel.org;
> sdf@google.com; haoluo@google.com; jolsa@kernel.org; linux-
> riscv@lists.infradead.org; linux-kernel@vger.kernel.org; bpf@vger.kernel.=
org;
> pulehui@huawei.com; Li, Haicheng <haicheng.li@intel.com>
> Subject: Re: [PATCH] riscv, bpf: Optimize zextw insn with Zba extension
>=20
> On Tue, May 07, 2024 at 06:45:28PM +0800, Xiao Wang wrote:
> > The Zba extension provides add.uw insn which can be used to implement
> > zext.w with rs2 set as ZERO.
> >
> > Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> > ---
> >  arch/riscv/Kconfig       | 19 +++++++++++++++++++
> >  arch/riscv/net/bpf_jit.h | 18 ++++++++++++++++++
> >  2 files changed, 37 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 6bec1bce6586..0679127cc0ea 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -586,6 +586,14 @@ config RISCV_ISA_V_PREEMPTIVE
> >  	  preemption. Enabling this config will result in higher memory
> >  	  consumption due to the allocation of per-task's kernel Vector
> context.
> >
> > +config TOOLCHAIN_HAS_ZBA
> > +	bool
> > +	default y
> > +	depends on !64BIT || $(cc-option,-mabi=3Dlp64 -march=3Drv64ima_zba)
> > +	depends on !32BIT || $(cc-option,-mabi=3Dilp32 -march=3Drv32ima_zba)
> > +	depends on LLD_VERSION >=3D 150000 || LD_VERSION >=3D 23900
> > +	depends on AS_HAS_OPTION_ARCH
> > +
> >  config TOOLCHAIN_HAS_ZBB
> >  	bool
> >  	default y
> > @@ -601,6 +609,17 @@ config TOOLCHAIN_HAS_VECTOR_CRYPTO
> >  	def_bool $(as-instr, .option arch$(comma) +v$(comma) +zvkb)
> >  	depends on AS_HAS_OPTION_ARCH
> >
> > +config RISCV_ISA_ZBA
> > +	bool "Zba extension support for bit manipulation instructions"
> > +	depends on TOOLCHAIN_HAS_ZBA
> > +	depends on RISCV_ALTERNATIVE
> > +	default y
> > +	help
> > +	   Adds support to dynamically detect the presence of the ZBA
> > +	   extension (address generation acceleration) and enable its usage.
>=20
> Recently I sent some patches to reword other extensions' help text,
> because the "add support to dynamically detect" had confused people a
> bit. Dynamic detection is done regardless of config options for Zba.
> The wording I went with in my patch for Zbb was:
> 	   Add support for enabling optimisations in the kernel when the
> 	   Zbb extension is detected at boot.
> Could you use something similar here in the opening sentence please?

Agree with you. Yes, I would reword it in next version.

Thanks,
Xiao

>=20
> Thanks,
> Conor.

