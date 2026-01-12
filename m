Return-Path: <bpf+bounces-78539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A49FD124C7
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 12:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C70D301A1E7
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 11:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4089F3559DD;
	Mon, 12 Jan 2026 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vz7PjeJh"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C19352C33;
	Mon, 12 Jan 2026 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768217343; cv=fail; b=k97xrgB51SjkSTJ1f3zkWTFwdwRcs7Di8kqjH1V6P9bygC+AhPOlI7vKYQY/dD8SvdrhtB8G+Fxbozc3ObOPoNEE+m1do2zhQYTt3P0pcLV2EGGlEZwcbxBOFEuRxpZhax/McpHVysg5mbB/JaJQeu77Nmhr4UIVmb05eRqf6W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768217343; c=relaxed/simple;
	bh=wsTzV6wTTpLayad+/61n4xEEawy4fpHWebkAg4BhKwg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rdlPXhDT6uljHQJbuK+dAFiIZcA9iE3lRb8zOLJlG1fLX0Zjkyc8mvkjAz6yko+IVZT5PD9Xw5ltM0v2WDLGvzr/GerFVCZ+MA2ofzgDGMRqWgItqobBHQmYkKnDSLPfhDA5+bD2cU81Rw3IcslDE8XaH7hI1CU20upb5XEIVVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vz7PjeJh; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768217341; x=1799753341;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wsTzV6wTTpLayad+/61n4xEEawy4fpHWebkAg4BhKwg=;
  b=Vz7PjeJhVfm7cXx+N2pHJsqb4Bi87LI2n5c6Wxk05m/ha3ka4f4e43ZS
   +Ohq97q5TgT0PO/CDWX9ag8gFtNd7qr1BkHPf00xpY2oqTeZKQU7X3RNu
   eOf90G9Wv1ldEqS50hIgy4fBiZcZ9Yd7GQl1iVGMGj7NSMO+jQm+bzr7x
   5ZcrDfS1L0PxL44fbQkW0wJTrfC+CGIImGgQ9sVxbuJ4Otc3m81U8BqkH
   +oOj95ggFAp0FIUdsbICwNQDOO8nvZGDOM+57qIMASMBNAe/doCmeUiaN
   gxwiecIK8fKwVbMUbQKiYO09z22wNdisH1mLCLjKlRgZxtbaFhbT5s+2D
   g==;
X-CSE-ConnectionGUID: MAv8f/MUQv+9RS7kicApdw==
X-CSE-MsgGUID: 5FHbzSjGQWeOHqTUFlfsEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69565038"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69565038"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 03:29:00 -0800
X-CSE-ConnectionGUID: 7scoUX8mQH2p7SgqJA7gzw==
X-CSE-MsgGUID: riUugkxLR9Grbdm8MEaxNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="204481447"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 03:29:00 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 03:28:59 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 03:28:59 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.12) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 03:28:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YseJuXRpFEjPeqrBxbDD9+z/J+Jxt/6O/0J07X58b69XGIFHOzbWFlrOEG/F8uq40gQu36S/OQx2oTWkG62vWcjihdJbzImiAlYym3nprhDfza4hDJYl3XDsOpg4k7vE3glHVxRs+p3jyAned2vCb04SpYOB8F0R1vPHtJuPbsWUfVU/IIGOLqGxqXKq931PwO8YD+dmIWBFmNTh1ZYnpD0IXfqfFT92ThbbWwj3oTRw3/OSISR3D+T284WWROzhLVtpfKp8Qo3x5lLuuDK7/HX04oXGEJ5y3c+6K5V6NaPxbu9rhZFGKiLBUx53PnoNJNktCysc7crV4m/uOlniuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsTzV6wTTpLayad+/61n4xEEawy4fpHWebkAg4BhKwg=;
 b=kNT7+kg/bOkknj68XlXVyJOmMXFUETjLpbNlnWDI3mwJhYdAfM3sXVHJsl44/A4i+YcXO3Gwg40OE6upeY5IYIUNnOjvKi6tJh+RdQ/ToUgPZOFKOMemnFX9vAO5vdJ+HKtbx6Ba+LIXYiwZ57NgACXrmlTwzDFflMsKh9ujpJTWnusu2Ut3wplBFBwlByOmLNGkUbMBOU7JP56NbYEDP/WZulksB3HB6doALMi8HgIZOt1ufpXuBFoHM8GckTHlla5k6uX9QenwNEYZvy4tmxHsmnFQWITk6wB5N090Q24ZNjoNQ9Zvsbhl3gLEg4bE5OvFopHbdan1GxtVKNW6Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH3PPFD6B8A798D.namprd11.prod.outlook.com (2603:10b6:518:1::d51) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 11:28:51 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 11:28:51 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Michael Chan
	<michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "kernel-team@cloudflare.com"
	<kernel-team@cloudflare.com>
Subject: RE: [Intel-wired-lan] [PATCH net-next 01/10] net: Document
 skb_metadata_set contract with the drivers
Thread-Topic: [Intel-wired-lan] [PATCH net-next 01/10] net: Document
 skb_metadata_set contract with the drivers
Thread-Index: AQHcgnTiCJq0/rq5AkC3fwe6NtS2GrVOaEJg
Date: Mon, 12 Jan 2026 11:28:51 +0000
Message-ID: <IA3PR11MB89869E31C1570E0212B8FA4AE581A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
 <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-1-1047878ed1b0@cloudflare.com>
In-Reply-To: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-1-1047878ed1b0@cloudflare.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH3PPFD6B8A798D:EE_
x-ms-office365-filtering-correlation-id: f20219e8-5f81-47fc-361d-08de51cdc2fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SGRGbERHSUJrTW5CZ2kxVktLaVIyY1c4V3BGalNPQ0hiS3AySlM1S1ZRaWhM?=
 =?utf-8?B?N3l0SzdTWHV5NGxCUFk1NnRRcktTejZXQjNMTGo5UWVFWWhwUDM4dWdvellM?=
 =?utf-8?B?UGdMYWh1bmw0dUpGcTdEaklQYTJnSmhyNldxNWR5SEtzUjVvdW0yVXQ5UERk?=
 =?utf-8?B?OTBPSTFUZnEvYUE1ZmpKa1k4UEtmSFVYeVF4SUtXVk5xSm5sRjFyaTRUVDVx?=
 =?utf-8?B?WHNMclZxRUlDR0k5S0N5dWtURUk3Tm0zbTRCSFBtMVJMYjkxY2hzaUhHV3Ev?=
 =?utf-8?B?RTIvSVZRZWxYTjZaZzBkTFJNbitvQWNJeisvSzJqTE96bVFmQzdwUjRla1pN?=
 =?utf-8?B?NWMyTHo5V21SMy83Q2trMU83R1RxMFpxeFNmTmhRQ2FiWEYzczNLZ0hyQVJB?=
 =?utf-8?B?VjFMRU5UTEFZRWNCTWNwT2Q1KzJKaE94SGRpa2w5RnJlejZjTWZmK24vTksx?=
 =?utf-8?B?ZFRjcGVJVmtkQisrcHFrMkQ3YXEwY08wQTBUQ2lGTVNQaFprVVNNZVRpdDJB?=
 =?utf-8?B?bVBiRUg4Z2VZQitrWDhEOHlzcWM1cHY2di8xNVUzQVp1bWJQL3lxa2RkRVlY?=
 =?utf-8?B?SUNMem5UWXIxMkkvZVh6Y3NwM3doQVNralBUWGsvYWpzajFjWExxWjJqUDM4?=
 =?utf-8?B?NVJhVC9ybzVXelQ5eTExeG8ySDJmcU9mcm81Y2hWcWg4ZzRIdWFCa2txbExB?=
 =?utf-8?B?UC9EQUx6R2V2YSsvQ0t5dW9HaDRtaXp2WUtZR2pOWitUdzJHV2hjcEZYM3RJ?=
 =?utf-8?B?NkVLZE5aUVRNdFJuWUpkUUhWMGp3bnhJVlY5YmFaRk9PR1lFd1ZYT1lFSWUw?=
 =?utf-8?B?Y0hhZ2hTNUlmc1ZRSEovSDNQWmlBem5IUXA5WEVXTGxRdll3L3BING5sWjQ3?=
 =?utf-8?B?T2NvY3lWOXcrMnJXR01iRVVZTDJxNGwxcnFLak5rNVJ5dDhZU2R6RUNjeEds?=
 =?utf-8?B?VTRUOHpjZG1yVStETVlOVzJNMjExL2hxdTBLdi91NVNWTkpiY3dTbWc2T2FT?=
 =?utf-8?B?OVcvUXNwODd5YnpiM3c4Z1dUT1NiSEZMMzNERnlQRkE2U1BJNk5KVHhWY3RF?=
 =?utf-8?B?ZlRoYnNzam8raTFQbzBpeEFHWDRCSkFhR0kxQ2VvTlFZaFF3VCt4eXFzV0R1?=
 =?utf-8?B?WVE2V0xEOFlzelFjOWxtRUVjMkROYTNZZG03UWt1UUpHNkxselhKMzlZTWg0?=
 =?utf-8?B?S1RrSXpLZ3p2T09PWEhMbVZpU2pGbStzSzROajRYOGY0Q0NPbTF0Ujg1M3JO?=
 =?utf-8?B?OFg1ZlN1blQ3WXdWbHBTcEZYVytiaUZMcGp4eFE3Mk1HYzN2cERFTGYzWWtN?=
 =?utf-8?B?QUxhL0dBeG1BZWQwbmh6SjVDOUFVRTZDRCtWQlhPQmliakZUelRWNm9KV2No?=
 =?utf-8?B?ejZmYUhPRWR0NVRINzZsanY0ZWpoMzR1SWxhZG04WnUvV3dTOFFaZlZSUm9q?=
 =?utf-8?B?TTJFdzJzRmhGK1BTZ1pBNTlVa25tUVNDNlpaYWhXUldnMU1LYlcxTzdLUllM?=
 =?utf-8?B?U2FMMkNGRVBCSXU3RWJsa280dFoweDV1dy9TZmNMcEZ2SkFZMlgySnBqbkdz?=
 =?utf-8?B?bWozWXBUcVozVTd0QTUxZ3ltT2JkM1gxcHl4eDQ5S291bDJSeHlraW91L1Rs?=
 =?utf-8?B?NVhtRDZseWNiY0hjblpkSTFVYlVpWDAxSklYZG5HUll2SHpiWVNHN25CazFX?=
 =?utf-8?B?anhZbHZKK25NeVhYMGEzcXBPUEZTYlpSNXVZaXVWVzFUV1lnaWZ1c2IxVEFm?=
 =?utf-8?B?YW15VWoxcmpSalhnc0M1ZjVwUTRJM1JuTlkwZkRpNDFNZFFxY0J2dTN6dWhl?=
 =?utf-8?B?L0xTdHdOZUxUa1EyUzYvOExncEx5SVVjUjNhYTE5N0FyKzRFb2tWMDhkQXdI?=
 =?utf-8?B?Nm5lQ3hndm9YSVpkSG9wVExUb2NKYU9tb3NQanF2b1R0QmZ0U3Ixb1YyMG9W?=
 =?utf-8?B?QTlMQjBacG5WdE1mRFFySWp2VFNJZGF5b0RQaHlYSkNyKzdVMm9YU1hCRGxt?=
 =?utf-8?B?VWZRVWRHNGpXYmhsWmlGelZYSUhKck1zYWZWS2R4Y0p2QkU1aDN5TVpyZlJG?=
 =?utf-8?Q?0wYtuS?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUZNeU82cW42Z0ZVMVBCZUQzdk1ydEgyVFJqU3QzKy9uOEhBM3VqL1VFWjIx?=
 =?utf-8?B?Nm9acXBNaGg1YmltdENkZDFBcEVNZkdRNHJ0NU1haS82aHdKWWcvbkxXR0dh?=
 =?utf-8?B?WEM5bk5JdGpaSXRuNWJRbUFFV3lPeEh0citDMW5pdlJXaU1IamYvbGl6WVBI?=
 =?utf-8?B?dGlNTzZQbTRQVC9SREkxaTNZR3BzQmVRTGJhN0p5eHFJR3FaZnVaaHJBTGZs?=
 =?utf-8?B?UFh2NnZvUmQ3TXZGcnpDaEdXYjV3ZHV1QThLbVgzRXlPbkt6KzNEWGx5M3dJ?=
 =?utf-8?B?ek5jMTU4dm9nWVcxVHZLaS9yeEthU280c1h3emtkTk43Zzg3RDZOQ29sMzM4?=
 =?utf-8?B?aWt1OURGcGhKblQ2clhSeGxwVEgxUDdyWUtnTk1rZ0hMa2E4V0tNcmk1dEVn?=
 =?utf-8?B?TkpTbmMzdjdpcXlEZFlQZGtZL2w2V3F2aWZoSWFGQmhIN0liWHpBZ0s4cnV6?=
 =?utf-8?B?Wm9MeGppekJnZUU0YmJ6Q2hFOVVTTk1VUEhrNUpOKzR6VmJQTjJha0RKZjJo?=
 =?utf-8?B?Zjd1WFpmRXYvTEFIWXQzSnplbnhsWWpYSVF5OHcxNmVSeWUzWVFCZFI1dHMw?=
 =?utf-8?B?SFNzUFF1M3c4bDdIZXZoN2Y2YlRoMWMrUEhhVFEwOE1JamJ6U1I1aGpHblY5?=
 =?utf-8?B?SWJ5Q0d5OXpjd1pWdjZiVEplN21nVzdjbFkwUjkxNUl4cE43SjhCRk5aZThn?=
 =?utf-8?B?dkFUaGtzNFhMY0w5NktZMnMrZDU4R09xQ0pkbG5ObjNqNy9OUDBBWk53VGxD?=
 =?utf-8?B?OVhBTi9jamU3ZzNWR0ZNK1laVlZHakkreXlyNTQ4b0hTcG93RGVxdGgzeThi?=
 =?utf-8?B?SzNvNlBoQXBFTkdSdVMxdElvOVdVa3VPUWY1NHk5NDVuQUV5ZklqclZUb1dL?=
 =?utf-8?B?d0xVbk5LRnRWY25TMnM2UENnMzNKb0xwVmNoUDNHY282ZmdoYUJPUmYyVHYy?=
 =?utf-8?B?YlUwekc5R2xrTjZ4YTZ5Tk91Q2E1T2E0djduTEY0UUxxOVJyMjRZUHIrb3Vh?=
 =?utf-8?B?OGNQWkcvTTFoaU9qNlF1YjkvbTNjOFpWcDhoL3pzSENwNTJrL01heUNZbXpI?=
 =?utf-8?B?U3ZHYTd6UENGbnpSalEyNlMxYzBFcnFzM3JVT1Eyang4eitoVXY5TWYyQnlY?=
 =?utf-8?B?Sit0d2J0dzhld3hwLy9kWFIvQThDTCtCY2dWOC9EVm12bEZ0c2dzUWhuMk1l?=
 =?utf-8?B?cDgwNWxNdzFkZE9SM2pUaDAwMG9aWFpuMTAvamlPUXcvQW81bEpwNnJKTDdi?=
 =?utf-8?B?aFBSM0x4WkswdHBFM3hJODNQdnNieWIwcjZSa1drOTRTdjNsbDBlWTlFc3cw?=
 =?utf-8?B?bWFDWkUvcWt2cHRMenhkbGJMMzdnZ2t1SlF2Y1RUZ1lnR0pIaDVBczk4UE1H?=
 =?utf-8?B?UnhSakg2eXdCN3BtU2xFZmRkZnFObUV6bEdwT1JmNU9mVnRJOERVQmNKSHpm?=
 =?utf-8?B?b2JySG4xcDBPUml2aXJ0UkxXUE1jekp1c2NxdFRoTGhISmtTWC9aaG03UHVs?=
 =?utf-8?B?cW5jdXU0aEp0N3Y1dUd5R0dwdHJib1F1YUtYMC9wbXI1UHRBZ2UyeFJWYUFj?=
 =?utf-8?B?UVhGYkZmdU1FbUw1K0ZlSHA3eVRvYit4bC9aZ3VmLzI0OE5WVEtZajl3cjdn?=
 =?utf-8?B?UjZnSUNqNDgwS3Z3cHZmMWlZQjNzbFVJNVhKcDVqeXg4N2hOSlJZajNacHFG?=
 =?utf-8?B?UWZzSTgwSG54cDdYSlVqRW1iMlVFY2VDZkI2OEk2SG5jaUMxd3pSM0dvRitJ?=
 =?utf-8?B?NHFoR0JmdFdXZTZIS3o3MTFrdUEwKzI5ZVNpclZQL3VmSWxXdFYwc1pHenh2?=
 =?utf-8?B?NTZoYXVsSkFaRE9OdXYrRThXWm95eklMVUozdldscVU5WDJYeHFxS0o0VEhT?=
 =?utf-8?B?U0RnTS9aVjhSMkI3QVFjbDRDZjRaUVFNTFgwVTVUampSYkd6RDgrUnhuQmg0?=
 =?utf-8?B?cXhmVjkyOWZSZFRyZUE2M04wTDZWVUJwVkJ6VE1peUwzY0lSZTJuei9YbGIv?=
 =?utf-8?B?dUJ5TUd0Z3dKZ2xCK3pySE9heThGdlQ4d3dJNUVaY3ByemRDY0cwL2VqMEVk?=
 =?utf-8?B?M3U2U2xzUDRVTjZacjhTY21Ganh2N3p3V3RGYllxeXpvakw4dkZRSisrcVJ3?=
 =?utf-8?B?TXkxRlhDNEZxM1hZUUN5TFBYcEgyV2c3TURKWThmRlBUT1F0VUljZi9FOFJW?=
 =?utf-8?B?M0dWMUp5cTlKQzh6RHc1MktrSG5BK1Z1SXozaGQ1dGEyK1pNdDNVMVI3dlFR?=
 =?utf-8?B?ZXV3eU5NUFUzZ1NJTG5jNTUvbTA1ZGl2eHBlMFFuMlkxMzBZdzRZVTRRbkVP?=
 =?utf-8?B?Ym1RNDNXNVVsaW5CRTM4QWRwRW1TQmJ1U1RkRDQ5eEpWZ3ByaDAwZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20219e8-5f81-47fc-361d-08de51cdc2fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 11:28:51.3904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ADlPYxL8JqFOInIHmO5xTm3uClTLLX6Hl/WC38/njF7LktT4C7wuX2CQnK1/D1iLo0dFQKyqQK/89EYhcbmDilUsmNWIxtiAy9vjKC9qI1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD6B8A798D
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgSmFr
dWIgU2l0bmlja2kgdmlhIEludGVsLXdpcmVkLWxhbg0KPiBTZW50OiBTYXR1cmRheSwgSmFudWFy
eSAxMCwgMjAyNiAxMDowNSBQTQ0KPiBUbzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBDYzog
RGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0DQo+IDxl
ZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBh
b2xvIEFiZW5pDQo+IDxwYWJlbmlAcmVkaGF0LmNvbT47IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2Vy
bmVsLm9yZz47IE1pY2hhZWwgQ2hhbg0KPiA8bWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbT47IFBh
dmFuIENoZWJiaSA8cGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbT47DQo+IEFuZHJldyBMdW5uIDxh
bmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBOZ3V5ZW4sIEFudGhvbnkgTA0KPiA8YW50aG9ueS5sLm5n
dXllbkBpbnRlbC5jb20+OyBLaXRzemVsLCBQcnplbXlzbGF3DQo+IDxwcnplbXlzbGF3LmtpdHN6
ZWxAaW50ZWwuY29tPjsgU2FlZWQgTWFoYW1lZWQgPHNhZWVkbUBudmlkaWEuY29tPjsNCj4gTGVv
biBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+OyBUYXJpcSBUb3VrYW4gPHRhcmlxdEBudmlk
aWEuY29tPjsNCj4gTWFyayBCbG9jaCA8bWJsb2NoQG52aWRpYS5jb20+OyBBbGV4ZWkgU3Rhcm92
b2l0b3YgPGFzdEBrZXJuZWwub3JnPjsNCj4gRGFuaWVsIEJvcmttYW5uIDxkYW5pZWxAaW9nZWFy
Ym94Lm5ldD47IEplc3BlciBEYW5nYWFyZCBCcm91ZXINCj4gPGhhd2tAa2VybmVsLm9yZz47IEpv
aG4gRmFzdGFiZW5kIDxqb2huLmZhc3RhYmVuZEBnbWFpbC5jb20+Ow0KPiBTdGFuaXNsYXYgRm9t
aWNoZXYgPHNkZkBmb21pY2hldi5tZT47IGludGVsLXdpcmVkLQ0KPiBsYW5AbGlzdHMub3N1b3Ns
Lm9yZzsgYnBmQHZnZXIua2VybmVsLm9yZzsga2VybmVsLXRlYW1AY2xvdWRmbGFyZS5jb20NCj4g
U3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIG5ldC1uZXh0IDAxLzEwXSBuZXQ6IERv
Y3VtZW50DQo+IHNrYl9tZXRhZGF0YV9zZXQgY29udHJhY3Qgd2l0aCB0aGUgZHJpdmVycw0KPiAN
Cj4gUHJlcGFyZSB0byBjb3B5IFhEUCBtZXRhZGF0YSBpbnRvIGFuIHNrYiBleHRlbnNpb24gY2h1
bmsuIFRvIGFjY2Vzcw0KPiB0aGUgbWV0YWRhdGEgY29udGVudHMsIHdlIG5lZWQgdG8ga25vdyB3
aGVyZSBpdCBpcyBsb2NhdGVkLiBEb2N1bWVudA0KPiB0aGUgZXhwZWN0YXRpb24gLSBza2ItPmRh
dGEgbXVzdCBwb2ludCByaWdodCBwYXN0IHRoZSBtZXRhZGF0YSB3aGVuDQo+IHNrYl9tZXRhZGF0
YV9zZXQgZ2V0cyBjYWxsZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYWt1YiBTaXRuaWNraSA8
amFrdWJAY2xvdWRmbGFyZS5jb20+DQo+IC0tLQ0KPiAgaW5jbHVkZS9saW51eC9za2J1ZmYuaCB8
IDcgKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc2tidWZmLmggYi9pbmNsdWRlL2xpbnV4L3NrYnVmZi5o
IGluZGV4DQo+IDg2NzM3MDc2MTAxZC4uZGYwMDEyODMwNzZmIDEwMDY0NA0KPiAtLS0gYS9pbmNs
dWRlL2xpbnV4L3NrYnVmZi5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvc2tidWZmLmgNCj4gQEAg
LTQ1NTQsNiArNDU1NCwxMyBAQCBzdGF0aWMgaW5saW5lIGJvb2wgc2tiX21ldGFkYXRhX2RpZmZl
cnMoY29uc3QNCj4gc3RydWN0IHNrX2J1ZmYgKnNrYl9hLA0KPiAgCSAgICAgICB0cnVlIDogX19z
a2JfbWV0YWRhdGFfZGlmZmVycyhza2JfYSwgc2tiX2IsIGxlbl9hKTsgIH0NCj4gDQo+ICsvKioN
Cj4gKyAqIHNrYl9tZXRhZGF0YV9zZXQgLSBSZWNvcmQgcGFja2V0IG1ldGFkYXRhIGxlbmd0aC4N
Cj4gKyAqIEBza2I6IHBhY2tldCBjYXJyeWluZyB0aGUgbWV0YWRhdGENCj4gKyAqIEBtZXRhX2xl
bjogbnVtYmVyIG9mIGJ5dGVzIG9mIG1ldGFkYXRhIHByZWNlZGluZyBza2ItPmRhdGENCj4gKyAq
DQo+ICsgKiBNdXN0IGJlIGNhbGxlZCB3aGVuIHNrYi0+ZGF0YSBhbHJlYWR5IHBvaW50cyBwYXN0
IHRoZSBtZXRhZGF0YQ0KPiBhcmVhLg0KPiArICovDQo+ICBzdGF0aWMgaW5saW5lIHZvaWQgc2ti
X21ldGFkYXRhX3NldChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCB1OCBtZXRhX2xlbikNCj4gew0KPiAg
CXNrYl9zaGluZm8oc2tiKS0+bWV0YV9sZW4gPSBtZXRhX2xlbjsNCj4gDQo+IC0tDQo+IDIuNDMu
MA0KDQpSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25v
dkBpbnRlbC5jb20+DQo=

