Return-Path: <bpf+bounces-11338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C188B7B75D3
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 02:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 89D03281246
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 00:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DAA807;
	Wed,  4 Oct 2023 00:29:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543C4371;
	Wed,  4 Oct 2023 00:29:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C352C8E;
	Tue,  3 Oct 2023 17:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696379381; x=1727915381;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XrV/BBl9lgq1pEUPZ3Gc3Eq50h3n5IC1F28ZokrBkos=;
  b=VMRaUnQgbQwu7NGOCMq/WJq8RTVCLqW84WKpw/8vUl+E9H0CtpmtneBH
   JPwWe0ls+/N3emVaLdJZEx8lJ33m7g7U4h8//2uazp35TNXqkGmOEWE0x
   /Hmv48/23buRGOHCa5v6nCHtL95J1N59njM0+pW4eyhvHOllF6UMZZo9S
   diehjLDaGlgVSNiv2qYHefGfopkAWa3+zp5CuKHjSOHwYwtVT4gahKwXb
   pwpU6aLJmu77rTp08Rv/4hki0fE7P3X9ipghts8wSpx/xVFTNjsfqRs0q
   lO0m3XKHm2g3SB+nWZ3ENB5wywZuX9jk9crPOyaHrVbV26BvH8x7U6JsB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="363285193"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="363285193"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 17:29:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="780516223"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="780516223"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 17:29:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 17:29:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 17:29:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 17:29:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7TqniKcmQ19MR59C84kbIETxvhFDGMcwxWRsdTruwIIxXrK9BIf5UaaQrb6oVzmq61Yeu1AETFjn+ezUcy4QalbyZoeHKDbJCAeZJ3nOOrZnm7mQ608sauPBWjzgpP4ZHWjaiEpqmNsp0c+zoCia+RoJkwqsS+IQD1q+0FyU7u5dJQxzm50c+vjG/pvvj23H4gFeNGlmFjVLILn7ZmNlx9MoA1mUpxc99pzvKZ9FgEUkqiWNUgmp75m3+Ux0/rGoLo/QMGCQqO8oL37LWedooak0E8TjaHuNNWe5yob5RZg4DynrWP/QIDijehD+kYd8NR1ez7waNGjjhhGlsjA2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrV/BBl9lgq1pEUPZ3Gc3Eq50h3n5IC1F28ZokrBkos=;
 b=JRy+hEGvwS0os0TFLWc4V+H5MOS3jIiTEXi1tvuvmHSnojf/D7PUaqOMiLjBSWTUZVngnCIA6uAnof/7TyNlTqaBLoUywANPNJiQ7zSDeMxjVb8mELuMN/IC21+cPMV8sRpCZC9SH0BSKRacoR5FdDrRYgJaqSFPCwjnN5vI4av+7liBYFERfXGdaN+jmcjHVzNl1HOw6x1lq3YKwhhFUjW33yNgFDYLkmANzYv3avI57IyiWjhcsdbjSJbI5qpcadq7JCgDSQUTWIzsW8v8/lr+JHES/BhtzV96s0HYwDeWYCwF6uaqPZTiM77LI/hUUX0FpwNSimOsRFTBA5WCFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA0PR11MB8335.namprd11.prod.outlook.com (2603:10b6:208:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Wed, 4 Oct
 2023 00:29:36 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::56f1:507b:133e:57cf]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::56f1:507b:133e:57cf%5]) with mapi id 15.20.6838.030; Wed, 4 Oct 2023
 00:29:36 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rppt@kernel.org" <rppt@kernel.org>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "deller@gmx.de"
	<deller@gmx.de>, "mcgrof@kernel.org" <mcgrof@kernel.org>, "bjorn@kernel.org"
	<bjorn@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"nadav.amit@gmail.com" <nadav.amit@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "kent.overstreet@linux.dev"
	<kent.overstreet@linux.dev>, "puranjay12@gmail.com" <puranjay12@gmail.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "chenhuacai@kernel.org"
	<chenhuacai@kernel.org>, "tsbogend@alpha.franken.de"
	<tsbogend@alpha.franken.de>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "mpe@ellerman.id.au"
	<mpe@ellerman.id.au>, "linux-parisc@vger.kernel.org"
	<linux-parisc@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"will@kernel.org" <will@kernel.org>, "dinguyen@kernel.org"
	<dinguyen@kernel.org>, "naveen.n.rao@linux.ibm.com"
	<naveen.n.rao@linux.ibm.com>, "sparclinux@vger.kernel.org"
	<sparclinux@vger.kernel.org>, "linux-modules@vger.kernel.org"
	<linux-modules@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "song@kernel.org" <song@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Subject: Re: [PATCH v3 04/13] mm/execmem, arch: convert remaining overrides of
 module_alloc to execmem
Thread-Topic: [PATCH v3 04/13] mm/execmem, arch: convert remaining overrides
 of module_alloc to execmem
Thread-Index: AQHZ6gIZWrHN4KzvPkW19JB0bsAPF7A436+A
Date: Wed, 4 Oct 2023 00:29:36 +0000
Message-ID: <3483c4712306060ac56f07f5db9b146d69fc7e9e.camel@intel.com>
References: <20230918072955.2507221-1-rppt@kernel.org>
	 <20230918072955.2507221-5-rppt@kernel.org>
In-Reply-To: <20230918072955.2507221-5-rppt@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA0PR11MB8335:EE_
x-ms-office365-filtering-correlation-id: 2b0d6fdc-83c5-4df4-0fdf-08dbc470fd2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9HH0PU5XFyjSAOmyzsjDbimq+fNfToOR6FpXwgEsdRCDMlAwIEsfXMZMOBpNtjIjs4+jObfw0yiChOKOC9ufREoBpyOP2T+R1/XtfOgcA8AXKEJ2OuUMkTit045vxs2wJTjPFulXhmxQ4LOrstFT8vsPrjI3EuumA57ZPhJa7zd3Yp7U0u4yWb5YuGmdw0ULxXpjIC1UVDsji1RAeJ1LytDNyAfdOGN5c4bbYeraNZRpegq9QfMe4bsNs1gRb3sU70B7+gahrtgEdtR07xWc1+JWVmAPNJ9K1GHugZ8zpD5dsSguhTjYQGFoW2A7KzNLBoAaMTC5asa6Drj/zH4F3bGWELigqGyrsEvTSzoO9O6JemPeJVJeOuS4aIRNZnB3Y/R689wH3xNUiZGlJcU8NDjLShSdPiKr3S4FSUmxdT7R4vHrIEpQmn2x7Xu9D7mXrP+JIeCkwXFTxFmNdIA5ySiTP3WYfW0xqEYanQ1r3xXjuCXwqV3MPOaoVj8sNEKYdtocKLvrsn4Y63AkSMEISk5RfwNWcT0A0w7PMKT38C7L3Vyzb06DmivTvK5GRYwmTP5dqgdqx/YGiC49QO9D+pOQ/plXNIenmtZWD9mQnRXWNdA5bFZYSvlgZ5wbU92n
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(2906002)(2616005)(6512007)(82960400001)(38070700005)(86362001)(71200400001)(36756003)(41300700001)(122000001)(6506007)(38100700002)(64756008)(478600001)(6486002)(66446008)(316002)(66556008)(7416002)(7406005)(66476007)(54906003)(76116006)(8936002)(4326008)(91956017)(110136005)(5660300002)(26005)(8676002)(66946007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVZtU00yWHNHVzYyT21jRUxKV2hSTGU3STFkTitZUmQ1eVZmZGJYeE10UG52?=
 =?utf-8?B?R0JmUTNuTlVXTjFoakxoT1gxSEVnVktDWno1YVJQRnYxSWozaDBSRjE3Yzgx?=
 =?utf-8?B?OHVLVTB5K3IzN1lMMTFIU0VONUVYVGpjTUFlUjM2b25sT1EvNHRCVCtycUhl?=
 =?utf-8?B?eDVjRXl4TXNQYURjdTdQcHIzemRrL3NhMENzUVBRY1JYQS9hSmlia1JsdTNI?=
 =?utf-8?B?d0FpRUFwd3VZa3FPZE92V29BYUpXWHVGcWVDeEpCS1F0T2J6eW83dG5TNDdL?=
 =?utf-8?B?czZYbTdBRFkvODQrNEJBa2ZUTXU4WDlodzVJY0pad2cvSlk4Nmt2bERMN1p4?=
 =?utf-8?B?SUhPWDMweFd1bi92RWxzdHN4QXQvWEZBOEN0R3IySTBpSUc1QXBKbWxoazhp?=
 =?utf-8?B?cWQzY1J4S2RQT0FBWnFXdzZZamRrV3VWUzR2YW0vczl2UFRKZWg0YmowWXdH?=
 =?utf-8?B?cisyeWFWOTBpWkJCcVl5R3FITE5xMDJ2RlNoNGp4M3VPTXRRYm9TZXMzcC8r?=
 =?utf-8?B?U2kwcU1GV2RvaUx3R2FoYTVjMUJNeW5XL0lmTTFidmszVk9mVEZjZ25lWGE4?=
 =?utf-8?B?aDc1K2lGcFFaZmNIRFV6eXNPNWU5V3E0MUw2NFZKRWdYT3ozcC91azFEbmxx?=
 =?utf-8?B?cUQwL0l6WDBrZlBzUW1BeWJFU01CMzM4YUYwaXUxUi84Mkh0UXMxSnF2Ykx0?=
 =?utf-8?B?MGIrMUlYMjc2ZXVFWkI1eGd4bVNnQ3ZHZWpYcGhwckZKQUhoMEQ0WWJaQlNY?=
 =?utf-8?B?UGFmVkNWdk9hbmJKWkJBQnRYQ0lUbkVFTWZGWWM2dHJqc2RTZG0vSStUWnVu?=
 =?utf-8?B?OFl5RHlwVm5vb0o2U0NrajRZcG5OUW9mUHhrSHpiaDdqVGJxU2JUNjVrNFpM?=
 =?utf-8?B?SjZqMm10U3dXdkxVd2U5dmkzbGhCbUpUK1NDMEdDeGpoWDdsZDBQdjBWdWZ2?=
 =?utf-8?B?Wk13d2pyVkJ6dW5YYlRTaFArNkpFQ3dKY1lMaEtiWHhyOW96QkZTaGt1QWI5?=
 =?utf-8?B?QUlBU29sUGRaRmhaaFZZSlFYT2pDdDRrV3lGbWMzbW15Q1N4OStRR3RtYTVy?=
 =?utf-8?B?Ym9wV21kOHl5MUcyNVBkV2VYaytpLzlNTHVNd242V1ZGRDRRZTc3ZU9YMjJS?=
 =?utf-8?B?cG9haGVOaTZRUzI4UTBJTmIyODZ5WmJqNjUxS3JSR2lnZFllellmVzFyZ0pE?=
 =?utf-8?B?aDc2SllDOHcwMTV6VkJhTzJMN1A3TVRtS2s1MGZsWm9TbkthaUE0c0ZuMTVM?=
 =?utf-8?B?d2VBOEEyY1RBVWJmak5tWjlGL0dpZkZVUUdoTXZlUHBkcTFCYWYyNENVYVJq?=
 =?utf-8?B?OUY3alQrVjE0ZVExbUZmSkFjZkdVK3RtVW1XcElGbDd2MVdwRGsvSkZZcUN2?=
 =?utf-8?B?dnJrUGdqeXRtSWo2UmlDYWgvY0NNNUlwWTJJOFYzQTRJbWpodm9OWUkwbjJw?=
 =?utf-8?B?bmp4Uk45REEyeTU3MmlTYUlENDkvL1p0cGJnMGhsL2hIYlREdnVwSVJWWnZD?=
 =?utf-8?B?N1JZZWVOblI0U1RLZjgrdzlKdGRVenpzWHJkLy9wRlNuT2tnYitxQkE0ek9B?=
 =?utf-8?B?OHp6U3AwZjlVL3hDQy9pUjUxSlRCczBqQ00vWkgyeWVkZ1Vad3VvWDQ0elFW?=
 =?utf-8?B?bXNVUEdlWkV2bVBzMGZSTTc0eCs0Y0RDanBsWUVuQ1BqRng3bzJHcFo0VXFD?=
 =?utf-8?B?dkliYXhDRVIwU3NxSTg2aG9FTURrbTZraUVpL0N4UHp4OGp1OFp3K2lUc2cx?=
 =?utf-8?B?ZE5JekhmZU85UjJqam9CamxLNEpXVUo1bWl0eTAxMzF6V1NXOExqZVNmWXRJ?=
 =?utf-8?B?T1o5UDVYaHRpb2xGalJEUHlqUnovVmJEb2NQZFlOQTRNelFzTTJ2NHdXeW9R?=
 =?utf-8?B?YlJsSXQySDRZa1kyR0psaWZFeHRaY3BTcTBPVzM2R09oSEFzZlkwRjNVUnpB?=
 =?utf-8?B?c0RHbmI4WVJNditYaDU2eHFsME5GQVIrT3Q1VS9QK3VDS1VFMDZlL1RxcVIz?=
 =?utf-8?B?bm5DV3R5dkNNZHJxL1RiRTBacHFJUUZsbi9kejVXbFY4R2FJNmp1OTdkWitS?=
 =?utf-8?B?NWpOODdJUkU0aDFsZzBZb0VJamZwYTlCM1kydHNIOGRSUmY5Tkk1WXlHU2tU?=
 =?utf-8?B?eFZNY1dHV3FNZUFTL2RaVUtrSTN5TW5hRW9BeFYxekpJUklmRGUvYUpOM0pr?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF78903E73462B4EBCC0229FED6F8679@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0d6fdc-83c5-4df4-0fdf-08dbc470fd2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 00:29:36.6085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pzqvGhpuQfDKneozZDf+iyWl1X8nZnhZ+mrpE9AftosNOsrWC5A0GpQhe9l2wf2ti7hgn+gw/+bCrYWj2oB1fgfpD9zSj+J4n8Jl8GNz/MY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gTW9uLCAyMDIzLTA5LTE4IGF0IDEwOjI5ICswMzAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOgo+
IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvbW9kdWxlLmMgYi9hcmNoL3g4Ni9rZXJuZWwv
bW9kdWxlLmMKPiBpbmRleCA1ZjcxYTBjZjQzOTkuLjlkMzczNzVlMmYwNSAxMDA2NDQKPiAtLS0g
YS9hcmNoL3g4Ni9rZXJuZWwvbW9kdWxlLmMKPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvbW9kdWxl
LmMKPiBAQCAtMTksNiArMTksNyBAQAo+IMKgI2luY2x1ZGUgPGxpbnV4L2p1bXBfbGFiZWwuaD4K
PiDCoCNpbmNsdWRlIDxsaW51eC9yYW5kb20uaD4KPiDCoCNpbmNsdWRlIDxsaW51eC9tZW1vcnku
aD4KPiArI2luY2x1ZGUgPGxpbnV4L2V4ZWNtZW0uaD4KPiDCoAo+IMKgI2luY2x1ZGUgPGFzbS90
ZXh0LXBhdGNoaW5nLmg+Cj4gwqAjaW5jbHVkZSA8YXNtL3BhZ2UuaD4KPiBAQCAtMzYsNTUgKzM3
LDMwIEBAIGRvCj4ge8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBcCj4gwqB9IHdoaWxlICgwKQo+IMKgI2VuZGlmCj4gwqAKPiAtI2lmZGVmIENP
TkZJR19SQU5ET01JWkVfQkFTRQo+IC1zdGF0aWMgdW5zaWduZWQgbG9uZyBtb2R1bGVfbG9hZF9v
ZmZzZXQ7Cj4gK3N0YXRpYyBzdHJ1Y3QgZXhlY21lbV9wYXJhbXMgZXhlY21lbV9wYXJhbXMgX19y
b19hZnRlcl9pbml0ID0gewo+ICvCoMKgwqDCoMKgwqDCoC5yYW5nZXMgPSB7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoFtFWEVDTUVNX0RFRkFVTFRdID0gewo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmZsYWdzID0gRVhFQ01FTV9LQVNB
Tl9TSEFET1csCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAuYWxpZ25tZW50ID0gTU9EVUxFX0FMSUdOLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqB9LAo+ICvCoMKgwqDCoMKgwqDCoH0sCj4gK307Cj4gwqAKPiAtLyogTXV0ZXggcHJvdGVj
dHMgdGhlIG1vZHVsZV9sb2FkX29mZnNldC4gKi8KPiAtc3RhdGljIERFRklORV9NVVRFWChtb2R1
bGVfa2FzbHJfbXV0ZXgpOwo+IC0KPiAtc3RhdGljIHVuc2lnbmVkIGxvbmcgaW50IGdldF9tb2R1
bGVfbG9hZF9vZmZzZXQodm9pZCkKPiAtewo+IC3CoMKgwqDCoMKgwqDCoGlmIChrYXNscl9lbmFi
bGVkKCkpIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbXV0ZXhfbG9jaygmbW9k
dWxlX2thc2xyX211dGV4KTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyoKPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogQ2FsY3VsYXRlIHRoZSBtb2R1bGVfbG9h
ZF9vZmZzZXQgdGhlIGZpcnN0IHRpbWUKPiB0aGlzCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAqIGNvZGUgaXMgY2FsbGVkLiBPbmNlIGNhbGN1bGF0ZWQgaXQgc3RheXMgdGhlIHNh
bWUKPiB1bnRpbAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiByZWJvb3QuCj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBpZiAobW9kdWxlX2xvYWRfb2Zmc2V0ID09IDApCj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtb2R1bGVfbG9hZF9vZmZzZXQgPQo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGdldF9yYW5kb21fdTMyX2luY2x1c2l2ZSgxLCAxMDI0KSAqCj4gUEFHRV9TSVpFOwo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtdXRleF91bmxvY2soJm1vZHVsZV9rYXNscl9t
dXRleCk7Cj4gLcKgwqDCoMKgwqDCoMKgfQo+IC3CoMKgwqDCoMKgwqDCoHJldHVybiBtb2R1bGVf
bG9hZF9vZmZzZXQ7Cj4gLX0KPiAtI2Vsc2UKPiAtc3RhdGljIHVuc2lnbmVkIGxvbmcgaW50IGdl
dF9tb2R1bGVfbG9hZF9vZmZzZXQodm9pZCkKPiAtewo+IC3CoMKgwqDCoMKgwqDCoHJldHVybiAw
Owo+IC19Cj4gLSNlbmRpZgo+IC0KPiAtdm9pZCAqbW9kdWxlX2FsbG9jKHVuc2lnbmVkIGxvbmcg
c2l6ZSkKPiArc3RydWN0IGV4ZWNtZW1fcGFyYW1zIF9faW5pdCAqZXhlY21lbV9hcmNoX3BhcmFt
cyh2b2lkKQo+IMKgewo+IC3CoMKgwqDCoMKgwqDCoGdmcF90IGdmcF9tYXNrID0gR0ZQX0tFUk5F
TDsKPiAtwqDCoMKgwqDCoMKgwqB2b2lkICpwOwo+IC0KPiAtwqDCoMKgwqDCoMKgwqBpZiAoUEFH
RV9BTElHTihzaXplKSA+IE1PRFVMRVNfTEVOKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gTlVMTDsKPiArwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBsb25nIG1vZHVsZV9s
b2FkX29mZnNldCA9IDA7Cj4gK8KgwqDCoMKgwqDCoMKgdW5zaWduZWQgbG9uZyBzdGFydDsKPiDC
oAo+IC3CoMKgwqDCoMKgwqDCoHAgPSBfX3ZtYWxsb2Nfbm9kZV9yYW5nZShzaXplLCBNT0RVTEVf
QUxJR04sCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIE1PRFVMRVNfVkFERFIgKwo+IGdldF9tb2R1bGVfbG9hZF9vZmZzZXQo
KSwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgTU9EVUxFU19FTkQsIGdmcF9tYXNrLCBQQUdFX0tFUk5FTCwKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Vk1fRkxVU0hfUkVTRVRfUEVSTVMgfAo+IFZNX0RFRkVSX0tNRU1MRUFLLAo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBOVU1B
X05PX05PREUsCj4gX19idWlsdGluX3JldHVybl9hZGRyZXNzKDApKTsKPiArwqDCoMKgwqDCoMKg
wqBpZiAoSVNfRU5BQkxFRChDT05GSUdfUkFORE9NSVpFX0JBU0UpICYmIGthc2xyX2VuYWJsZWQo
KSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbW9kdWxlX2xvYWRfb2Zmc2V0ID0K
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdldF9yYW5k
b21fdTMyX2luY2x1c2l2ZSgxLCAxMDI0KSAqCj4gUEFHRV9TSVpFOwoKTWlub3I6CkkgdGhpbmsg
eW91IGNhbiBza2lwIHRoZSBJU19FTkFCTEVEKENPTkZJR19SQU5ET01JWkVfQkFTRSkgcGFydCBi
ZWNhdXNlCkNPTkZJR19SQU5ET01JWkVfTUVNT1JZIGRlcGVuZHMgb24gQ09ORklHX1JBTkRPTUla
RV9CQVNFICh3aGljaCBpcwpjaGVja2VkIGluIGthc2xyX2VuYWJsZWQoKSkuCg==

