Return-Path: <bpf+bounces-71579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D437EBF72B4
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 16:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F8A19C2652
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 14:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1090B340A46;
	Tue, 21 Oct 2025 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SUrTiSmf"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8A234028A;
	Tue, 21 Oct 2025 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058088; cv=fail; b=cjKfPxJp+uIFJgrAQSY5+JQpYGPhkZeRCzwzUj+3w9of+Pb0/ja18Naf80XzaLjidtvXETcS29MkYThEd92P/6o/fGAUsiO6r+KZgaYp8jSltyKhyXUmWYmeuyiQU5vPiF1yq3PaO2LwfXTnBMRDfWe00ZZAYCjEE1LgDOFo/MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058088; c=relaxed/simple;
	bh=3uEAd9AVekW4linmtCaLe1LQzJzEZfQS6/mpJZ2LR1M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DIgxJyIo8NZzsTPNAmflkJe6nuDCjrBMqg9wy2cei2M/TJg8qB+NUWMLAcUfUljCrz4yxOjc1eT8g40tdet8tIgSzko/OQ2LKGhN3a8rt592Y8UhBWG93AKP/irJftOQxFafV2U+qhu+NP0xU02Xp7vNE+OmLDsdl3HUfikMuZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SUrTiSmf; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761058087; x=1792594087;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=3uEAd9AVekW4linmtCaLe1LQzJzEZfQS6/mpJZ2LR1M=;
  b=SUrTiSmfMo1Df5NdDtDDT2ITo7DhGrbf3rhosjLCF8W3aAVnlG57aSNt
   DTfQK9tCHGOhzydccmufYDDWTdhGPG8FfWpLbqpATj04caOvUz8Bwn20i
   t/perTFOH1tlj3cjuog0ovbE8I6RxKA5bvpdDR9diL9hj3ENSe3HqYeBZ
   71UK5e8S5+CJsa625RVnZaGzR+V4Msirn48iaFoo/kZCK9vN8nHv4UyeB
   nRdujucSNaX0XisYkzohJtqP9g7cz2A/ySYrNmcuQobl7TsIbHLxxGZ1t
   7Bkq5VW6iGpRlLbnwOqjcD+RR1EJMxqW18X8tv+u7jACbqd6n+K34ThHa
   A==;
X-CSE-ConnectionGUID: PeKTKfWbTdGLb0rFYkwYoQ==
X-CSE-MsgGUID: SuxBI+UdQeySwtq+nM0K2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63225305"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="63225305"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 07:48:06 -0700
X-CSE-ConnectionGUID: mIySZCbgSFinJIwfZ9GUEw==
X-CSE-MsgGUID: b0TXUuhuTDqfEcQqbhCwjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="182769874"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 07:48:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 07:48:05 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 07:48:05 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.49) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 07:48:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukj4lGJLH0P+n75nJeSjdr2mwtmdtR5tYG40xvObFavcs3Oh06e59P2BffJuqgThcSXg6obOjXfvU4Nqp5+pVe5OKzLHnsVwS0e7/OCze5CYiGJjABxFioSGq9nbiyuorS9piB92UvwIYysalsp/41u4qCxl8lx0u5OMSBX3g6XLPXSIOBjFFTMthXP9H2Rr5+bhzRGOaeoAdLjbIUi5MDpokLt46rUzGKbnEgV7LwSaNxNpdZLSdsqbBJchZCG32+go9IC+pqKeuL3bpxIpMq4/rWOFCJ+CCng0/j8REMQyrGTaq4D0AOYTM4niQKpqwXhSkPe/4T5p7BunmZZzcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zly17/Wd/d0ZLZcE3ChKe5l3BQK0vQTFNJzrmoH2zTk=;
 b=aC8dgW+zVpc1PW39YVv3VyNb+HQ4CcWhoqAILbJyNJbcmDRX9L048hiqrJReVK6BRVP3qV5A9bNRXwI1R/d2bzjBMjULOHhj51mN53cjbQYrYWIbZ5ElWLwBrzZKiZISURV7urRvdGENNO67hdletQhuLgVK0NdhadWdPdDaujD5+GC0tnADGO+6ymRKZ2yXmLEEipQGf8hFWAwazmH0/EUiTffudA24rHg4YAEFRRDvqpelHvsIrWmQ/uBHW+jLTndXRF0HuJcf1UnRcgAYBDXrcFZTTx8U/44UQKo+gJGi/CCc8MBR46o5uOxw/Ttrua2sljWXPxGuteZo1J/+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA2PR11MB5195.namprd11.prod.outlook.com (2603:10b6:806:11a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 14:48:03 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 14:48:03 +0000
Date: Tue, 21 Oct 2025 16:47:55 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: mc36 <csmate@nop.hu>, <alekcejk@googlemail.com>, Jonathan Lemon
	<jonathan.lemon@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>, =?iso-8859-1?Q?Bj=F6rn_T=F6pel?=
	<bjorn@kernel.org>, <1118437@bugs.debian.org>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: Re: null pointer dereference in interrupt after receiving an ip
 packet on veth from xsk from user space
Message-ID: <aPedG99fdFBnbIqz@boxer>
References: <0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu>
 <CAL+tcoA5qDAcnZpmULsnD=X6aVP-ztRxPv5z1OSP-nvtNEk+-w@mail.gmail.com>
 <643fbe8f-ba76-49b4-9fb7-403535fd5638@nop.hu>
 <CAL+tcoDqgQbs20xV34RFWDoE5YPXS-ne3FBns2n9t4eggx8LAQ@mail.gmail.com>
 <d8808206-0951-4512-91cb-58839ba9b8c4@nop.hu>
 <CAL+tcoA0TKWQY4oP4jJ5BHmEnA+HzHRrgsnQL9vRpnaqb+_8Ag@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoA0TKWQY4oP4jJ5BHmEnA+HzHRrgsnQL9vRpnaqb+_8Ag@mail.gmail.com>
X-ClientProxiedBy: TL0P290CA0007.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::11) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA2PR11MB5195:EE_
X-MS-Office365-Filtering-Correlation-Id: 59953c5a-1730-4ed0-d1e6-08de10b0d679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGtYU1k1cTV6Y01tcldBSXRvUEZPL1p1QVpYRnZnREtBK0dzdllWdHF3OU9l?=
 =?utf-8?B?bFlNaWRNUXRVVnVPYlhwT3FGNlczandpWS9MWHZxVlkxbWQ0KytmNFdvL3c1?=
 =?utf-8?B?VGY0Q1NTYVk0Tmk4ZnZDVm9PRDZKbjdNZkJiS21McTYzZ25wb2k4U2hYZlgw?=
 =?utf-8?B?QWZ0cVRJbjJzNkF6cHZuTkVJbGpFeGZHVTU1VEdxWlRMMjhCRDg3cW9MRDk2?=
 =?utf-8?B?WWZyUE1BM05mcml0L3VUam05Zi9iVVZiTS9ZQTNZWVFlUWhENVQ1ZG91RExp?=
 =?utf-8?B?ZmpyZXNVRjlTRkZpcDNQRTBzcTkwR2VZK0FOd0Eza0FMTDhoamJYM2dUbmcy?=
 =?utf-8?B?b0VZNm9qOHNtcW5mU2hQdzBZWml3UGczTmR3T29tdXBtNFpaTksvT3I5WjU2?=
 =?utf-8?B?emF6cmlmcFgvWkxNbGdSQXk5QUZVK3YrdDlEOXgzQXMxUG82MkZDRTkwLzN2?=
 =?utf-8?B?SThqYTBYa0xIUGZtSVViRm00ZDB3Q0JvZkczeTY2WVNCenEzVjJlSnM5UEZ6?=
 =?utf-8?B?ZmQzWEZHeXdqYTE5ZlZQUk9qYXZtV1hVVUdDWHQrUlRGa1d5WVA5ZGp6TEg2?=
 =?utf-8?B?cFpSRU5xd1NwZDczbXM3SmFjbFl2a2twS3RyQUZBWUd4cmtUTmdDcGtzSmRZ?=
 =?utf-8?B?YjNyWEVGOTlmYVZlaTh0VElkVTMyT09pY2pTaHczaFFQVXUrcUtGNEpUcEJR?=
 =?utf-8?B?dEhhOEs0TkVhNnRFU0JHY282QXI2MTlMZmNpYzUzKzA5UUpUUzRJWHE1dzhQ?=
 =?utf-8?B?WDB4cWxDZW5Cbks3cEZRWUZXQm1PUkNmanZ1UW5vOVBNS3dLaFZhaGFKMXlj?=
 =?utf-8?B?eng3N01Pa1NjTnBNaWxaby84aXI4amRvdTZUQkptbVBLNlRTTlhackNZb0hi?=
 =?utf-8?B?YzRuRmRMT0VWd1RoU0NMVTd1NU5qYk53aUIwY1FOaXdGMFVVVUczc3hPQ2Y3?=
 =?utf-8?B?OXo3MlFpbjF1OFhCVGpDc3ZuajBiWE53ZWpWMXBWcklNNU4yUU43aWFhQW4y?=
 =?utf-8?B?cklqbWZsS0hoQWMvQm00K1RBM0xIZFd2R1JMUDRRZ3JpRFpJRkpmcFlLSHdk?=
 =?utf-8?B?bk1zMXFJWlBkdit2YUJPUG1WcFdhaCtSNC8zR2xLakFXNEdROUwzVUxxT205?=
 =?utf-8?B?bzFTVkcwdTRvNXFHK09WZWl4MGNhd2s0cWw2RmFXbkJ4Y1RncldpNXJEcWty?=
 =?utf-8?B?NFR5cm44aCs4MUhKaTNub2Y1cWZTY0JhMHJzRlRack9OenRVSWpRWFIxZlNH?=
 =?utf-8?B?NmxEYVVBUlF5NzMxVWFaSXZVQ1R2VHRlMHhrUGlQdmIvUUNnNlEweGFaZzlG?=
 =?utf-8?B?MGorUk4xYzBobUZadkV5cXRwMGRoNXorejJoVUQzMU9vckRVeHMrbTZ0VmEw?=
 =?utf-8?B?V3B4VE10OEFjMFZpUUtZVFQxSHU4N3lMS0JmOVJBNENwYmFBazFvRk80ZzNy?=
 =?utf-8?B?WDhKSlp5aGF0UXhwUnJ3TExCMms0YUVTLy9vNnpDeVlFK29aKzlGY0dpZkwz?=
 =?utf-8?B?L2FFdnFsMElJMUtIZGVTa0FmRThRZ0wyR2RHcldPQWtTajJBYUJqOFRsaFpz?=
 =?utf-8?B?TnFOTHRqM1Z0czZ5UmM3YVhrMmwxZXM0bVBpdUY3NGVUWXhUaVpHcTM1S21j?=
 =?utf-8?B?aWErVFdFdkVxbnR4Rml1SURBYWYwRkJyUUFhaWZTaVJRQTh3Y1BKdmVhbU1T?=
 =?utf-8?B?SUljb0x2L1ZmYWhNZUU5MDY3aWdKSTNFRlNteWlmU0QyeHo3YjAxNElQRk1T?=
 =?utf-8?B?d0JIclAvREhvZ3FIb2xQMlEzNkUwMWtWWDM1NWFaaXVPK3E4c0hZTHJtRWxw?=
 =?utf-8?B?cTBEUE1oS1RWSG5LL0plVFFNb1FJZVhwZHlFUlFVbVpkYWFWUzJwMHQzbTE2?=
 =?utf-8?B?Zms4UVIxekZOd2dhWmQ0aTFBRkloa0RFeUxHTXFSR3IvL29VRlZkZFFNaktG?=
 =?utf-8?Q?hAGXAiwXuz+R5RqfbZ7QIhW5LqZt+VGn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFBDaWw0aGh4UnhUcXB6clpGOTJxL1ByZWZEakIyTitreWFGUE4wOEJqZ2RD?=
 =?utf-8?B?ZkovcmowbGQ2ZnZuL0IvOW11Zkw0QzEyS01ZaVNaWEU3TFVIQ01wZ3Q3aGtz?=
 =?utf-8?B?OHo1L3Q4bFNFT2V2REd1Z0FOSVREZlBCOWx6VEhNd3cvZXZaaHhrd1RJVjQz?=
 =?utf-8?B?bFlCbHVKT2F5b1VBa1pOQjJtU0RhR1FvQzNqbTc3aCsvVGFZVEljNWVMNmUy?=
 =?utf-8?B?NUdBNGxaczFobFJXNTZJdEkyTi9ncCs0U0xmYVlYWGE1Qml2cUVMNnBaWXh4?=
 =?utf-8?B?M0dQWkMyQkJualRBVnlRNXRMNnhJOVJHeDArVmxDbTVNUkk2REtuRnNtKzk5?=
 =?utf-8?B?VXMvTndjMzhMbjFuQ1ZkZDh5b2hJc1kxSko2a2ZFUVV0MEVsZWp1aWMxOUl1?=
 =?utf-8?B?U0dwS041dWFFcDlnUzNLMXpwaXdhME4weHRIT3E3enVHU2d3dnZsUnlTTGV1?=
 =?utf-8?B?enpOZ0xMS3AvY2ViaTN3R0cvR3FnWE9aN2treDFkak9rdTA2eFZUeUNjdFM3?=
 =?utf-8?B?U2ZDTWNDS01XZnVrdjQ1YzU4SkoydHNhL2I0Vk5xcURtVmx3Y2Nkek9Ga2ZR?=
 =?utf-8?B?Q3NnbG1NUmx1N2ZVaCtxM0N3MFN0cmxHTjFSa1hPNENaazV0d1hLZnI1Z3da?=
 =?utf-8?B?RkpVNXh4TDZiaHVTbTl4UGFQK012UnpoUFgvNnJ3a29PcXVqSHFzY0FRMFdT?=
 =?utf-8?B?TWx0QVhUc1RybWtwWTBMWkpFTlhLd3FnSnFOd0JMQS9zNzFGTkV2Y2Njd1Fp?=
 =?utf-8?B?cW5FSWtLajB5UU9RNFpDS2ZMWEYwaTRudWJXdDNBMlNCZEs3K3VYTUpXRjMx?=
 =?utf-8?B?K3RMQlNsWUVvemFnVjZBWGdUOEFnczd1S1dCckJHMFVuVHo3VFh2aTIzYmJX?=
 =?utf-8?B?RDJHNmpUa1piakNxWDJyOVBONE1nSFoyWXo4M2ZDeTZMc1RTUzdQZElNbVZN?=
 =?utf-8?B?bGdWZU5EdmlkUGtaS2JZZ2xPa1RTelN1Uk1tY1UrNHlNcG44T05DTll0K05w?=
 =?utf-8?B?SFliTldJWGRib1I1aXdNa0ZteEF3eHluWVZYMFdLNDFVKytQUW5POW9VZkdE?=
 =?utf-8?B?dkExSEtaZUphalFnaWl5Y0tMZ0x6T0hwbjdOczA1QVRoRWxjVkNjL3hEcld2?=
 =?utf-8?B?aGlCVENhTkhxbkRNNS9iWmdsQVhhSGFRSWtVdGdScHlTV2o4aVlvdk4rd0tR?=
 =?utf-8?B?SWExM3JOY0d0Qm84RksyeVhjb0FQVDZraDZZZVdhWXRwOWlUVnVPVkJOZEZV?=
 =?utf-8?B?ZFJFZGdRYm8xRUo2QTlEUUJCNGVhTGRGeUF3SDMxcFROeWZSQVFQRDUzbWVP?=
 =?utf-8?B?L1A4VEE3bW1PT3ZkMkFRaThwSjJJUG9WTHhlc01HNzhsbjBxTEVuRGFRMmdK?=
 =?utf-8?B?SjJER25WMkhiR2I1WGl1YW9jM0s2RXg2bmY5eVdIS0JGZ1B5Q2laaXNiTTIw?=
 =?utf-8?B?c1FEWE1QYyt3U1RPOHZwUys0cVNtaWRGUjFnbkhxUG50c3dCWmJLMlF1N0tP?=
 =?utf-8?B?WXZ2SU9ONXFxSVFzNUdtVDJVRlBSWEdSb0VVRjZPdS9Gdmdnb3dvZ0hib1Mv?=
 =?utf-8?B?ekdjd01LV3hHNDlTWVJPVnVDUTRFQlQwdjduUFdLUlJWblB0RzM5d0pkc3Zs?=
 =?utf-8?B?VDRpeGF3cmhwRlE4aUtUOWh5cEQyK1gwM2tCS05sbnV3ZmRndzBqN0E4UHp6?=
 =?utf-8?B?dElnUkJzUzZ0NHh1NEl5cGhVRE53UXNkZTVjUEJUVWxycWcwdkNPOUZuclpZ?=
 =?utf-8?B?WkhGYlhNRWFNaHNMOFZKRnpKQXFMYWoyYWZIbG1BZVhkUG90d0pBNVkxTVFB?=
 =?utf-8?B?L3IzUjdnY1JuLzFlZ1ZCcXJPUzZ0aEFGR1FXS3lOTTNPNGxDOWhGdUJ4Qkwv?=
 =?utf-8?B?djFFQ2Q1YTlUNWdTY2xKb1kyRnNMOXZjOVZHUkZ1S3ovMkd0MWZBMGF6T1Fk?=
 =?utf-8?B?b002WXFTdi93UHZsMnRaMTc5MmhndUo0T3Fpdk9HWElZeUZ6VzBGaVNqTFB1?=
 =?utf-8?B?VXZJYVV6TklnY20vSXFIeUhEOUk2MHVNR2szeWJsYlEvRjNkc2FXQkMyQTJF?=
 =?utf-8?B?emlUY0xucjVNc0ExZDhYUHBCRHBRYVB6NVhVcmZmNVhPRnFCRjFhRU5BZkpw?=
 =?utf-8?B?VFRPamVRM09RdnNCTkljb2J2ODNrT0VNUkN6WFBwa0JDTjBnY0Yrb1Y2MTY4?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59953c5a-1730-4ed0-d1e6-08de10b0d679
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 14:48:03.3415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkXwHTM/asWSPUfTN5i266HBrIebnxogdcJ6BUsFmziNBFTt9INLu+vJt3fEffdVjQ2otfZY+8EDWq1WHSjxCsMVx1YzlycMX+m6ejhMWfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5195
X-OriginatorOrg: intel.com

On Tue, Oct 21, 2025 at 07:02:06PM +0800, Jason Xing wrote:
> On Tue, Oct 21, 2025 at 5:31 AM mc36 <csmate@nop.hu> wrote:
> >
> > hi,
> >
> > On 10/20/25 11:04, Jason Xing wrote:
> > >
> > > I followed your steps you attached in your code:
> > > ////// gcc xskInt.c -lxdp
> > > ////// sudo ip link add veth1 type veth
> > > ////// sudo ip link set veth0 up
> > > ////// sudo ip link set veth1 up
> >
> > ip link set dev veth1 address 3a:10:5c:53:b3:5c
> 
> Great, it indeed helps me reproduce the issue, so I managed to see the
> exact same stack. Let me dig into it more deeply.

splat comes from skb_orphan() calling skb->destructor() with ::cb field
being already taken by IP layer. A hotfix would simply be moving this call
before we memset cb in ip_rcv_core():

diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 273578579a6b..db30645f8c35 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -535,14 +535,14 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *skb, struct net *net)
        iph = ip_hdr(skb);
        skb->transport_header = skb->network_header + iph->ihl*4;

-       /* Remove any debris in the socket control block */
-       memset(IPCB(skb), 0, sizeof(struct inet_skb_parm));
-       IPCB(skb)->iif = skb->skb_iif;
-
        /* Must drop socket now because of tproxy. */
        if (!skb_sk_is_prefetched(skb))
                skb_orphan(skb);

+       /* Remove any debris in the socket control block */
+       memset(IPCB(skb), 0, sizeof(struct inet_skb_parm));
+       IPCB(skb)->iif = skb->skb_iif;
+
        return skb;

 csum_error:

However, I do not understand why setting mac addr on one veth interface
triggers this path.

> 
> Thanks,
> Jason

