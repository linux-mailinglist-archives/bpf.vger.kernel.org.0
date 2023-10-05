Return-Path: <bpf+bounces-11473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 205927BA8C9
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 20:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8726C28228F
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 18:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994BB3F4B1;
	Thu,  5 Oct 2023 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1m+6G36"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85DE3B7A7;
	Thu,  5 Oct 2023 18:12:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D411793;
	Thu,  5 Oct 2023 11:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696529518; x=1728065518;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yjuvDEzc0yJ7VGlB+qUTiqz14AdRBI2Hdffjv6nHtno=;
  b=c1m+6G36ZOPIN42CMPXUPqxuOkuvp3be4cqNpS19+1bdwW+6k/Hm7XxP
   19g/qWDKgEh5+eFJfSNSmiwCzdpzLkWTAZ0SDXwUg29+wh2W5jHrpYCGU
   GXgRHCiCsrwrj3tGecrPv1V3xSxV1/cbP2DekdOf4n4Uv8kKZ7QNn01IQ
   b0B52sYLckPis3G6f607rfCBUAhDR5ArLcYtWV3KN8XVwbxQ3uVqG6tLZ
   677TVIJtH8IkBpZ0BHDqyGMcBbyApxbGe33SXrt7nmPEGotSYmLHu8zP7
   9NR8n90UiLYnjlZz1OqsQptRWuBqWn77sPZRf1+LLo7rMKh7IGoEmZ6J9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="362934078"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="362934078"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 11:11:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="875645492"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="875645492"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 11:11:57 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 11:11:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 11:11:56 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 11:11:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eM3q/wesPJbtc3+VtWLhsOEjSYqHQHR+1kPaL9AZgILRKmZZnqWg7DT8ndpk5ZrVmQEOSDZix75Dgb2+B4cKkTkRgzw2KjJmGmkwPJhdcxrB6sduidhkgYmQTAfcsfLZwXv4SuR6kptFE4W44XiVpOq+qVWqAmYkNGDu4b+F9ZUk/S++wacf0llzrboSz0XyKa8TX9sbwkDNNkTkRiCI2B86soVzeDHxZt1PaDxr3Js2YbFocNQGhyvX7d/QdZOuyaw7LGQSmuE3l9H3TscL16HRMR/k3ygkdPUDSDthqfKcUagUyfvmKH/7WcfJyU/da3AvfgINTb7sYz8NYhDI0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjuvDEzc0yJ7VGlB+qUTiqz14AdRBI2Hdffjv6nHtno=;
 b=csV+pf1VWrTZk5cphFOr3EjjqY+AkBcgW3LvJdsfTtaTmCGeWryBp5JUZL/pmGqYJ4j1t+HQfsicyso+YQOaK/83sIRRTv8j3KVI/czzTT9Apguno2+9N/ODl+hU5foKfMVJftIPpzH3xQ5qMAOuOwK0BxenyXHYBowqshVOwsrtIlePMBtL3v3OEeFgoYrBNzAcyiyGTLPN7x6/Y0rajgVX4h0MxHoH6HHoABlB15e9fwTalNNBxs+f+WcwB1JDAtWvAYv06U7Jnl+QVk2QthW7Lw4Hg6Sbyq6hllLSBN/2FSSyhYYQI0TBMfCGNAc4FpXJlnXKswjvet3O0mkTEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MN0PR11MB6111.namprd11.prod.outlook.com (2603:10b6:208:3cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Thu, 5 Oct
 2023 18:11:49 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::56f1:507b:133e:57cf]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::56f1:507b:133e:57cf%5]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 18:11:49 +0000
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
Subject: Re: [PATCH v3 03/13] mm/execmem, arch: convert simple overrides of
 module_alloc to execmem
Thread-Topic: [PATCH v3 03/13] mm/execmem, arch: convert simple overrides of
 module_alloc to execmem
Thread-Index: AQHZ6gIbIXJGUlk14kaIslF+Xg+n8bA7mssA
Date: Thu, 5 Oct 2023 18:11:49 +0000
Message-ID: <ce82a562db208250526f21a21e54bfc5b85f167a.camel@intel.com>
References: <20230918072955.2507221-1-rppt@kernel.org>
	 <20230918072955.2507221-4-rppt@kernel.org>
In-Reply-To: <20230918072955.2507221-4-rppt@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MN0PR11MB6111:EE_
x-ms-office365-filtering-correlation-id: 79a4e409-e6d2-4847-3c80-08dbc5ce8b7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DqSA+P3onQRNBSrX5mWGe8TcGlixjr5AwyJ/eMcHfWkzid6SkXSsXfDmQatZ+fiEGOpqzNpfB7pDcxOmJqdmJZim5fesbB8pGKcLbNkGBOjUUozWx4WcR8RkC+36p5ptNR9N/4ei3YkQzeEQOzwnnU9gIFkyfip9Ies5QaHuuWJ3q0nR0AWkubcX4vO6/dOmoTGyz2XL13+KyGVqpEkA64nnanI9Bw83cYYnIw5qMjg5kc1K+vCnHCjV/s6zrCXGj/8GUhmEQJns06i4wof0nSJzLhzZHivplDTdrzIERYd50845CEqkuSaNQPhzH0p6rj+jkjEVN4ulYquD3uDAChaEAOfbfnb9WCmPYA8fndcJUv51QUwatGoyPZDVLOJp9TSf5KNYESsXq/pUPHoUsdn06i81zpkpqphxrsoZas0JO3Kb+jweGAEs55vqAgjEhlj2JiupRzOHfgIwMpzrgzyGVuFBhgZrdw3fe+Jd5CsAyilmn4b/TsDzwRYgO3CVebhoiicUcD0zbqW3SHOhSFsuTsqwbVlVK58ds2eRKGX9AekjhPVo5Ao/aXXOYzIA8xSiJ0dGu8QKlhrhRJwAgC7fDRih2LWWJdZ6fSFOYvyufC+bLRfVEyNjKT2ndu+f
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(7406005)(41300700001)(66556008)(8676002)(38070700005)(4326008)(8936002)(91956017)(54906003)(66446008)(38100700002)(316002)(66946007)(110136005)(66476007)(478600001)(5660300002)(64756008)(76116006)(71200400001)(82960400001)(6506007)(7416002)(4744005)(2616005)(26005)(122000001)(6512007)(2906002)(6486002)(36756003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VStPR1BQWTRxREpaamFYQVMxQ0tNZUZnVWs0b0Z4NGw0WlhRQ1lHWlFtUlhy?=
 =?utf-8?B?QjN3V1I0amw5SzVpTG9MM2RyUG1GYlh6dGxPc29qTDNibnJBK0hBb2lwZWl5?=
 =?utf-8?B?Q2V2NGVkcWJERWc3SVBRaVFMNWtIVXdCVko5Y2xDU21lV1lUS1R2ZTY0cnp6?=
 =?utf-8?B?THl2T2FrTjRmNmlJdEJVTFRGbE5tOTFiYzJSZnFEME9nTko3OFFRWWVpS2hj?=
 =?utf-8?B?a0t1UDV1T3B1Q1JGeFR5Q0lJV2FGMzJXWC9lZ09aT1JaUVFoVDlwQUo4QjJY?=
 =?utf-8?B?TlEvL2dTbTNNdmNYOGdkL2hsZWZPdXdZeTVVdmhidzRMZjM1Zm51aGNkY0ZP?=
 =?utf-8?B?SVJkZ0RPclNiWWlRMjFRY2ZWVUY5cWliUEc5VStHV1cxZzhTKzAzRnhLaSth?=
 =?utf-8?B?cG91OUFTSWorbHBJTjhQOFZUcktXbXlmL2FmcDlHeVlURUhmSmJTaFZtZWJy?=
 =?utf-8?B?NWtsd1ZwOVFrMFV1RzlIY3pVdnJVL2tYekJXSEpuUldMV1BLWUNZNnBjVHFQ?=
 =?utf-8?B?SE52MG5Sd0grMVdKaUlDOVgxa25aeTdCR3hVUytSa0c5SXk1N0NjYTFDNEw3?=
 =?utf-8?B?ZHJqUDdvZ3F4cDRFMHU3ZFFpWmlTcnFCYlQ5SjJKdzBxdW42dmsxeVRrWmZY?=
 =?utf-8?B?T2J6M1RDMzYwYmdzMjRQMFdxTmdVcEY0cUkyT1dFR3FPbzlJTHBLVXhBY2Z2?=
 =?utf-8?B?MFVGL3JFdmloV2ZSTDZkS0ZWVnFvMG5TOWE2azE0Z0wwcXhJYlhCcnA2TmxQ?=
 =?utf-8?B?bGJIeHZFcHFCV3luZUVRb2U4ZW9aU0tsWmh4ZGV6bmdIMEsvbDA4SXFXVU8y?=
 =?utf-8?B?M3I0RWNmWEhHbHBmZGNuYlJjMGtJQ2JqZExYTE1yR2ZpZkZ5K0RPeGptWW9y?=
 =?utf-8?B?WWRvUkMreGhmSVYxQnVuOVo4UWhBek9MME1hVEI2RGhrWWI0TXgyUExUL2ZU?=
 =?utf-8?B?ZVJDbUhsTGYrL1R0Z1lseXkxUHRqOFV0R3FJblJMNFU5bGxqSmlUMEU1UGNx?=
 =?utf-8?B?UGJhUFZuM2xXNmgvRWJ0OVdKVHd2aU96cnRJUGh3cUJ3OHhUUnZaNlFLRGNG?=
 =?utf-8?B?Zjd6eXZDZWFOSXM0OEYzYXkrKzAzZjNpYnAveTBUVHJCYnczckxMVXk5UFMy?=
 =?utf-8?B?RytNWVdCUnBIV1dMMy8rQkpKandzc0lJWWNNbWRQUTJMZFQrU0RvVzN3T0tE?=
 =?utf-8?B?ai9ZOHVlWE1leXN3Ukt3ZWFGaGhpbnIweUE4VkFzMm1xbDZmdVJ4Z3lqMVhY?=
 =?utf-8?B?WTlqdlNnTHZWT01TMHhSYlF2d0pWS252a1NPV3FHbWw5Z0MwcFY0Y21GbzRL?=
 =?utf-8?B?U3JXd25Bd1FLY3YvTUZQcWpaMExJTnFkZHcvQW1ZVnpwdENONmM2VnU5R0pQ?=
 =?utf-8?B?Wmw4T2F0dUVBYnFocWFEdVEwWWF4MFUwTHdrU09kTjhya0ZXeVNqYnl3b0Y2?=
 =?utf-8?B?dmFvbWZrMXVzeVR3WVBBOWIxakI1Q3ZEUVZJZ3NwZ2pQUWJoRFdTQzZUSnUz?=
 =?utf-8?B?eGJZRGxuMVY0dVRORGd2bit1Z1RWVUtBNWt4VlpNY3Z4bWtqQ1BKZ1lCZkpR?=
 =?utf-8?B?U0k1L0NhcWs2MXk0V0Z6cUU2bHJ3YlRlKzhhWDJHcEtQZ3R2OFBpc0FNeEtV?=
 =?utf-8?B?NUFZQSs3YkdzYWVwd2JQVS9zUVlDdVJHc0wvb2lqKzNsSlZmK3pHb0NYM09t?=
 =?utf-8?B?cDE4UEpKcjRYRlcrZnU3Z1pMaWNBNUpuYUh6U1l6UHpWTElKUGFsTzRVS2x5?=
 =?utf-8?B?emNMYXYyMHNDRm8yakJiQ3Vrb1VjRGd6Zm5SYXFLQ05IYkhCL0RUZC85TnZq?=
 =?utf-8?B?bHFnemxvZ2E5SUcreWs3NVlJMVZtT2hCM09KQThGK2MrcUZURlJJQWZlUURx?=
 =?utf-8?B?MFg5NDh6S2ZhVk5lZUVKSVpFLy9PVXdCR3AwWUtEbnpNaUNpTVNPSjBjcnB6?=
 =?utf-8?B?dXhzWnErVDRCOXdIVGZYd09BMi9TRnRTMVk5OTgzUEZEaVdGVnVBNitPaU80?=
 =?utf-8?B?NVd0QjRRV2EycG9ybm8wV2x5a3E0eGxQWUVOdzhJVS9BWXA3RTNSdjBsMjlF?=
 =?utf-8?B?MzVud05HQ0VmRDl1UkZHR1RxQlBmUGxrRE9sWGJnTUpvRWxPYmNMYjFGWnBU?=
 =?utf-8?B?ekkxdjNmOVJ3eXd4Mi9aM3F2dDlzTDVUN29pZ2l4Vkt1TXpTejBLa21RZWFF?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02A3B455511F6F4589834950B9AC6B01@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a4e409-e6d2-4847-3c80-08dbc5ce8b7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 18:11:49.6587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: we+gHrJimaodpXrpsZfiNtWxQpFghB5bMBIprl72XUHWXPjKQbZsvelp0NtUcQdoRQq7sKZDIDOaKk8wJ3RvwKgo+ZPWW9EW4iIuKkKCmSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6111
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gTW9uLCAyMDIzLTA5LTE4IGF0IDEwOjI5ICswMzAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOgo+
ICsvKioKPiArICogc3RydWN0IGV4ZWNtZW1fcmFuZ2UgLSBkZWZpbml0aW9uIG9mIGEgbWVtb3J5
IHJhbmdlIHN1aXRhYmxlIGZvcgo+IGNvZGUgYW5kCj4gKyAqwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVsYXRlZCBkYXRhIGFsbG9jYXRpb25zCj4gKyAqIEBz
dGFydDrCoMKgwqDCoMKgYWRkcmVzcyBzcGFjZSBzdGFydAo+ICsgKiBAZW5kOsKgwqDCoMKgwqDC
oMKgYWRkcmVzcyBzcGFjZSBlbmQgKGluY2x1c2l2ZSkKPiArICogQHBncHJvdDrCoMKgwqDCoHBl
cm1pc3Npb25zIGZvciBtZW1vcnkgaW4gdGhpcyBhZGRyZXNzIHNwYWNlCj4gKyAqIEBhbGlnbm1l
bnQ6wqBhbGlnbm1lbnQgcmVxdWlyZWQgZm9yIHRleHQgYWxsb2NhdGlvbnMKPiArICovCj4gK3N0
cnVjdCBleGVjbWVtX3JhbmdlIHsKPiArwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBsb25nwqDCoCBz
dGFydDsKPiArwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBsb25nwqDCoCBlbmQ7Cj4gK8KgwqDCoMKg
wqDCoMKgcGdwcm90X3TCoMKgwqDCoMKgwqDCoCBwZ3Byb3Q7Cj4gK8KgwqDCoMKgwqDCoMKgdW5z
aWduZWQgaW50wqDCoMKgwqBhbGlnbm1lbnQ7Cj4gK307CgpOb3QgYSBzdHJvbmcgb3Bpbmlvbiwg
YnV0IHJhbmdlIGRvZXNuJ3Qgc2VlbSBhbiBhcHByb3ByaWF0ZSBuYW1lLiBJdAoqaGFzKiBhIHJh
bmdlLCBidXQgYWxzbyBvdGhlciBhbGxvY2F0aW9uIGNvbmZpZ3VyYXRpb24uIEl0IGdldHMKZXNw
ZWNpYWxseSBjb25mdXNpbmcgd2hlbiBtdWx0aXBsZSAicmFuZ2VzIiBoYXZlIHRoZSBzYW1lIHJh
bmdlLiBNYXliZQpleGVjbWVtX2FsbG9jX3BhcmFtcz8K

