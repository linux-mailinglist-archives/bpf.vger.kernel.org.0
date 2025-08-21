Return-Path: <bpf+bounces-66257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314EEB30348
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 21:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124FAAA17AE
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 19:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC5334DCCB;
	Thu, 21 Aug 2025 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+r1JuY/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CEE34AAFE;
	Thu, 21 Aug 2025 19:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806290; cv=fail; b=Il9jpuRvE4n/cil2ARenJdwKg/lbO6IltAmxTviCsnYAN2pQYO1dv0QNrd4lp3Iv7oAO5nGLXS3Bx8RWE+b53oDdK+TY2Vqd+snQc7BH0YhlajdvEOP7YZVqZJsmuf6yUHZtHVAr6v6wOgSrljC8XLyiLCxGxP7vlLMWEg9JD40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806290; c=relaxed/simple;
	bh=Sz3T//M842h+gjRO/RJ/bvptXKwmFridZAnimCsWEp0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q0SriUOSyVjKD50R1OMl+ergSrT3S88Jvchc4cj/1PMhoFr/lGZKI4OEhkISQOZx5Lb1KHLTT+nGYXwmOAk70j+v0X1o/6L/77N9Q/OFARwm09sdTf1qSODpEvomLgFFRXwdfbIezZj4p5XYeItjVfDFqp8Cbz2J0SXabfW0XPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n+r1JuY/; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755806289; x=1787342289;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Sz3T//M842h+gjRO/RJ/bvptXKwmFridZAnimCsWEp0=;
  b=n+r1JuY/yBRVeqOZExl+SeC4M2DdMnmMyJ0suoY+DJpdXowKLGR4AB8D
   DbYlqsl5k0bwYUbK1QPnLHCuWfRh7jW9u4sbgb/ONB6n+OQbWndvkDKbc
   uU/Yyvf0HRjacxebjgWwK17SO/AoQIuiDbdIe4UbLCQtCpPxcPtuqSWQi
   il8cAy1iAa2eQpMxoEAZwz+4cj7imRCgP8RsZLYBjt0jp4bHmYN4xqU7L
   MOSwmnjizdBMNHpYFezhswp3fx6Tk8vKiy85zk1vzTl94SlUrgNe0IxQz
   1rUP7tAxRvmUyuUros7AVYUbNH3uLb+BDp9AAXm9J0ooLjU2uJylwb68p
   g==;
X-CSE-ConnectionGUID: agn2p5Y0RqGFbH94ehS45Q==
X-CSE-MsgGUID: gnTq/lTJQPG8IZcjAkUwuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="57131034"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="57131034"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 12:58:07 -0700
X-CSE-ConnectionGUID: JkB1l1sdSNeRw4uWRaWwaQ==
X-CSE-MsgGUID: 0KKkwdTiQQSSZru1cDfVWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168119560"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 12:58:08 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 12:58:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 12:58:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.45)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 12:58:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JyXzCM3uf4q2UQRLmoSSt48WFzB7Q10my/LVO81qynjLiexEX+m6qmSCJrjyQyBxrdb1NlCfyKBBBGmH3qbuKNtPXonmH8fkRGLbTL87zrwo1a0GUUMzii9nc6W7no4Epi52z8C2TRZ0zXkLFVL8phJ8lEP4Voqr2RJ69Q0yAZTVvru8Ef1dUGxYg2nEhN1n3/dYeWF4zuZzDJClhjdVlcVZLk1uUxb0q4JcWEgTSnkCyEm4Ie+1nYBRu7On6vGDWIueYCLzAbJe4Z/fo/9vBpGUSEDGmXmYIPitDhAHRDKaoa0kKavrfeqkPpJzERQQkXRUaKO1xkeZXBik8IUTFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sz3T//M842h+gjRO/RJ/bvptXKwmFridZAnimCsWEp0=;
 b=jE+A31jTw3G2D73ahLoO51PXa0GNbVmh4fxThJj0o9Y9m/ZQ6bbZzqautdkKbUWsRSSbHGsL+ZewC27fpP/6QEXo/tC/Pf1x3dfVSV2JqUmR1wFqZoM8YAp7fB3I0EnYeS7NKHePe49Ebf1AaI1R+bmIdsa1zMBrSj+Af8EJ28E0r4UrdS4EYPVNXcw4UeNsnvS52mJn7tIhzenZeDxZer6VI6YdiEVrswGT1Og4Xjc8XSDO4U/8TXZraKE5jkWtVwSNumkUmsr9c+nhyp2NCZEkagkuvEDVz8tczLvPykfcEqFujmPt8b0A3hd6vMa5S3AQg14j+azJuVFjcqJQ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB6378.namprd11.prod.outlook.com (2603:10b6:510:1fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 19:57:59 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 19:57:58 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "olsajiri@gmail.com" <olsajiri@gmail.com>
CC: "songliubraving@fb.com" <songliubraving@fb.com>, "alx@kernel.org"
	<alx@kernel.org>, "alan.maguire@oracle.com" <alan.maguire@oracle.com>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>, "andrii@kernel.org"
	<andrii@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"mingo@kernel.org" <mingo@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"David.Laight@aculab.com" <David.Laight@aculab.com>, "yhs@fb.com"
	<yhs@fb.com>, "oleg@redhat.com" <oleg@redhat.com>, "eyal.birger@gmail.com"
	<eyal.birger@gmail.com>, "kees@kernel.org" <kees@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "thomas@t-8ch.de" <thomas@t-8ch.de>,
	"haoluo@google.com" <haoluo@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 0/6] uprobes/x86: Cleanups and fixes
Thread-Topic: [PATCH 0/6] uprobes/x86: Cleanups and fixes
Thread-Index: AQHcEpkjDd6hPInHJ0SrykSo1ewNHLRtJ52AgABFqoCAABekAIAAAamA
Date: Thu, 21 Aug 2025 19:57:58 +0000
Message-ID: <2e6ce8cae61f622d3e19ed1bab0b12c0084aa385.camel@intel.com>
References: <20250821122822.671515652@infradead.org>	 <aKcqm023mYJ5Gv2l@krava>
	 <a11bdc1f59609073f182c2c04dbd72cecde61788.camel@intel.com>
	 <aKd44ArsaKg9kl73@krava>
In-Reply-To: <aKd44ArsaKg9kl73@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB6378:EE_
x-ms-office365-filtering-correlation-id: 2cc2f814-8184-4ad6-9a03-08dde0ed0735
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?blYrL2JPamNuZUM0YldMQmcrQVdSQThzUUYvTmp4RkdOaWxBRC9hdGVpdWhx?=
 =?utf-8?B?UWMxQ25BVVljUUNXNjNnL0JtMlhUVlFwMExjSzdZd214ejVPK1FIYlRlVzRo?=
 =?utf-8?B?SnRKMzBvdDRvYnAyVFE0blZrK3A0OU5KLzNPaERVTFhRTUc2bmVSZ25xR29y?=
 =?utf-8?B?YXF1d3NoM2tQNGRMQUxwZTRuR2ZuaUZTa1dVR2F3Y0NPT1dLNDJOdmE5cHVB?=
 =?utf-8?B?OUpFeEI1V0ZOU1JZM2VsNEMzNzN0emIzSEtrV0NsQUFnSGw1QVZCM1RDdmRI?=
 =?utf-8?B?OFZadjQydXVMbWJ6ZVRDUXQ5N1VBYUUzWWRBNmEwZUozVDcyZ3FHNk51YTF1?=
 =?utf-8?B?N2U3OUZuL2N5RllsMTNaWXlvelRDUWs1TlJEdUt4dEtpRy9oUG41U0NjK1Zx?=
 =?utf-8?B?V3RYYzhzeGxIblV0UnJyTmlBYlZBZUhKVWdaSDJkbm11RjJxYVlhb2Rsb2tL?=
 =?utf-8?B?ZnMwQmM0alNRcFhYMzZQYUZuaXVMMVhDUDhSSjVGeE1jTkV6M3I0NFFVVDBw?=
 =?utf-8?B?WFFiUmczbzdOYzBPSnQ0Qjc2UUs0UjdZWXh2R1dULzZoV1dVV1JxTmk2WWVF?=
 =?utf-8?B?N3RvbGgwajRNNG9ib3ZLbzN4ajdzdWh5WE1hTWxBZ3VOQ3Rxa3UrekJLdkJr?=
 =?utf-8?B?VXFraUpzS3VTQTc2ZTM3RnhrQ1ZpTXpHRk54Vm9HTytiUE5lTmJkQUREWXlL?=
 =?utf-8?B?UEtORVpRWUk3elZVU1pteDlTRGVzMWEwNkRSekxuaEkxY1B3OTQ4L0xDeEt4?=
 =?utf-8?B?aUNjc2FnbUIwbzhwWUtLYnFHc3FPS0lMNUgrVzNSdzFkQXczWkEyK2xIY0dD?=
 =?utf-8?B?Sm93T2VmVC9scnBFRzJMc1dvd2J0Y2hDZXRsOXlBTFZjNDA1b2RtWVorNU1o?=
 =?utf-8?B?Q3hXQndEbVJsL2hwd0I1TWRJdXRBNFc4N05FdXR3NWdZc0NXdHZkVDhDbzVh?=
 =?utf-8?B?b1p3alFIQ0tBNlF4YmN3c0VCbUtkTjBweEhxbTZUUndpb29UUGphNk5sbkRm?=
 =?utf-8?B?dXE3VmpScmxIU3QrNnNpdm85RWxQUlVZSDVuYnJuelJ4Q251c3pwSUd2STVy?=
 =?utf-8?B?VGxoQTcxeTJZemYrdHJ5MDl1djNoYXV0U2cwOTZEZHEzZEhjYWR0SmVnZS9U?=
 =?utf-8?B?emdLcnduUThwNEhSTU9NaEhRWnZCTzdKZ1hwTWk3M2haUmdtZUJUbGpmcnRO?=
 =?utf-8?B?SmJlZHl1ZVRPSWFVd0tuR3R3NWdvVjNaRFZaNXRWTmJ5SGtjbCttcnJwYkli?=
 =?utf-8?B?a2JrM3dEVVlwMzN4bURpTk93M05GUXBNUDZCOXZENGg5eXlSK2pqck1FdE55?=
 =?utf-8?B?THQ4ME5OWURDRlkxZTJSaS9hZ0EyazUwcHc5dnd1U1d6b045SDhGMGROOHVx?=
 =?utf-8?B?YUluWTBUajV4dndXUHVEQUdkclpJOG94TWtBblZKZkpsSEtCSE9vYzhhWjZ2?=
 =?utf-8?B?eWRqbDNyWlc0cmlraDQrYVlWd0RQYWo3Wi9EaDlUSzVHaW5kamJFbEJnOS9o?=
 =?utf-8?B?bVBHSzUvUmlEM3lDZm0vdmo3WTZwWUtVVDErNU9UdEorZGtNNTBBaHk2K0Z3?=
 =?utf-8?B?NmRFU3plWWlCVDNyS0xjSmhmblNrT0lQbmFWU0c1S3gzaDhvR1N3aWphYkgz?=
 =?utf-8?B?b0JvZUpvbXhXK202aUNrZkNjL0kxTDc4OEF0NjhkTlJwZURJUGNyZHZDeEFq?=
 =?utf-8?B?NVVEUVc0NkJPQld1b1NNeUF4ZGpEWDEvYW15RDVlTktMdFpUczlLOE01L2JX?=
 =?utf-8?B?MmN0NE9SeUYrNzhCZ3pENDYyZE9HRG5VdHRCRDU4Z1NoaWdXRzVjc2RwSlRR?=
 =?utf-8?B?K3plU0VJY21FRDl2a1JVdDhDZTMzOVVmcUZKbXA4Nk9vK0xCR3JKalNuR3la?=
 =?utf-8?B?aC9qenBLbmZ3c3JRUmlPM2RnTWR0TEtDSmxkekdORTlWclg0cnBkcHlLbEZI?=
 =?utf-8?B?WHVPRHZldktJNy9MRStDQ3FCdEgxRmFIY2k2U1NzQ0REQXAzNW53QUNoUWkv?=
 =?utf-8?B?Yk1OWGR1VjZBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjlxdjJ1VGV0N1dUcmNwOU9mUUxGc3lMYy9ubUhnNkFnVk13SG43TEJBVmlE?=
 =?utf-8?B?b1BkQUdmSXFuZ0FLbHlydEhsWXIzZWJZWDdRb1lDTm9BYnUwTkdyLy9jZmZP?=
 =?utf-8?B?d2RldnpIL0NqTklhbXhzbDhBWkR0Wk44VDczcVZmL1dxUUFWNm1IcXhKazFB?=
 =?utf-8?B?VmdDWkZydHAxQy9FTWRpV0J1MG9KVGFBNjl1R2cxVlF6d2luRmc2ekxqSlpp?=
 =?utf-8?B?aE96alFwVGVVTk1xbmdRMjQvK1VXRWVScmFOR2Q1V0JXVGg2WGtUZFRob2lx?=
 =?utf-8?B?VGlpRURSSmlnUW5YLzY1TURXYWt5aEhCb2IyT1E3WWR2ZGlrVlg1alV1NDdj?=
 =?utf-8?B?RXhqWVUrT1hnVGR5N0FNQU5YdHhydkdrcnM3MXZsdmRoa0tzU2Q4Y214VitJ?=
 =?utf-8?B?Qm95MUtwVDhxazA1NGxwaXZnZENzNVU4eDhsem9HREROcXhDRlVnMzZ5L2Jw?=
 =?utf-8?B?TDRoRU1ubmRUQ1RXNGlzSzRCMDBkWmFRaytPVlQzZHFqNGRwNnNob1lUeHRm?=
 =?utf-8?B?czhHV2VqQW5FZnF5ZnZzMEJQK1htZnZzYlNyMWhtQm1qRHRXT1VmWHhjRnox?=
 =?utf-8?B?OURWdFZ4WTdkWGl0OVczUStuVjJNcXhvRmhvNm83Y3FZZnpnbjJLekpPS0Vl?=
 =?utf-8?B?M3g2Vkc4Q21tNW1oN3h5VFhVbjFRdnRaSXBDVFVVSTBHNzVWZXI5ZkkvUWJ4?=
 =?utf-8?B?MVJRYWdLcEFPRWtmNWgyVnlPajZKNGF4alg2alFOMytCODExZ3RQR0ljazlH?=
 =?utf-8?B?S2pHTXd0NUh0ZkFHSjc2dnV1aS9abExFZTZBTDgvQjVZY2Z6a1liS3kvZTc3?=
 =?utf-8?B?eGgxa1FKQTFQQm0yYlFwSm54bm1JUnh0Y2l5SW5EU1gyY1JmOHZIR0FDb25K?=
 =?utf-8?B?U3c4V1ZMM1l6bGVkZEJBMUZFMExkOERmaCtUc24zL3pqNTUzVERkQ285YzN5?=
 =?utf-8?B?ZU5XZWYvZFNNZHZZVGJSdnc2TGNYVDhFQzdwY3lldVU1L1U3VWpXdjJpZzZr?=
 =?utf-8?B?ZjdkUW5OYlgwSnhLdmpMb3VOL2g4MWtubktaZzYwKzhrSUhVeUkzd0pTc0dJ?=
 =?utf-8?B?VWhGOFFVSWZSQ0owSURGZ1dLMVpZWDRpK0FKaDE1RXNTdGZlcmJqZVJTR0g5?=
 =?utf-8?B?bi9OR2Vaamc0QnpKUDMza3FGNExvUmNmS001VnVTMmFocExGOHBNam5GVW9W?=
 =?utf-8?B?TkpRV1Y1MGkzMllCZnhoM3Z1V0pFMlE1UlJMeXM4aEZqVWNVL3kzWXZTWVBW?=
 =?utf-8?B?c3I1a0R4OXRZZCtyYnk2cW0yVXluSElpSTVKdEFWdmY2UlQ5RVZVcEdYWUkv?=
 =?utf-8?B?TmxDQUVHdXdJTlA2ZjNxZzlGV24rTVFHcVcwU0QybWdhbm4yRlBwYUdmbFdt?=
 =?utf-8?B?YmFVWWwwNStyR2FmMFJIVDVKbWNxZVhZeXovbWFMMUNYTlJZdFdKYXlVSjBt?=
 =?utf-8?B?UHJUQWhZN2dmdlZwcHR1bEkvaTRYUGRoU3NmNEk2UWI5UGt0OHpwUEVUNFhO?=
 =?utf-8?B?cFdhaGI4ZjJFVGRobWtWeHUvaTRTSU9RcmtpUVNJazZ5VHFMZjNwVlM3Vksx?=
 =?utf-8?B?aHlTd0pSbTRBNzVESFBiZk1udmw4bUc5L2NzUzVmek5NdVVFZHN1WkZRZUt3?=
 =?utf-8?B?cHZtcTRMcFlFbHlwemJzLzQ1QWpQRy9MWUplZkcxN2ZUQTBrck1TNkhjMkl2?=
 =?utf-8?B?Y1Vlb0t3b1ByT0FNYXhNOFRhdTBYWjc3MkR3T051ckVjRzc1ZUpJZXZhcVhk?=
 =?utf-8?B?QzRIczhRTlphMjVLV1NkNTRzQmF3WjBkdkdPZEgvbzQwbmhLSXZQRWFuTExX?=
 =?utf-8?B?VFZVM2hXZ0NKTDFUZDZIbEFuazE1a0pTRTdEd0t0M1lOR3V5b2hnK0w1NGRL?=
 =?utf-8?B?QUsybjhCUVREWVJXSWlrZlB5QUhzMFkxeHA5VnhIME52dDFyVmtrVGhSTVEz?=
 =?utf-8?B?dUx4NTE5Z1JMdW1ZTHZpdUt0Y2szTXVNRlZ5VCs1NDFrbDR2YmFRbGUwWFlr?=
 =?utf-8?B?WFFHMWdHbzE2a0VlY29scFFJY205R3kwOTREMDVYL2hGRVFybmVRS1Qzd014?=
 =?utf-8?B?WEdpT0VycHV4aGRIYUg2aUJlc3RqbUhhYmRZa3l3TDBIU3Jna0ZOZmFSeEVJ?=
 =?utf-8?B?ZlhqcVRrZEZ4ZldRMTVobzlWQ1h6MUp2Y1NublV0TnBySWVPSjlDNnBad1pO?=
 =?utf-8?B?MXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7B61F69C2C06441AE5155FD3C8421FB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc2f814-8184-4ad6-9a03-08dde0ed0735
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 19:57:58.8681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ztNG5o9PQLrn2TJfMN0RRIg5JPkQrH34/PWpzP2lkeQHP/VNrnSlU+ipex6lU4KwGYpKY8oEgiFUo4HgPHRThLnSiIxixE3KC9nJthp0xrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6378
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTA4LTIxIGF0IDIxOjUyICswMjAwLCBKaXJpIE9sc2Egd3JvdGU6DQo+IHll
cywNCj4gDQo+IMKgICMgY2F0IC9wcm9jL2NwdWluZm/CoCB8IGdyZXAgdXNlcl9zaHN0ayB8IGhl
YWQgLTENCj4gwqAgZmxhZ3PCoMKgwqDCoMKgwqDCoMKgwqDCoCA6IGZwdSB2bWUgZGUgcHNlIHRz
YyBtc3IgcGFlIG1jZSBjeDggYXBpYyBzZXAgbXRyciBwZ2UgbWNhIGNtb3YgcGF0IHBzZTM2IGNs
Zmx1c2ggZHRzIGFjcGkgbW14IGZ4c3Igc3NlIHNzZTIgc3MgaHQgdG0gcGJlIHN5c2NhbGwgbngg
cGRwZTFnYiByZHRzY3AgbG0gY29uc3RhbnRfdHNjIGFydCBhcmNoX3BlcmZtb24gcGVicyBidHMg
cmVwX2dvb2Qgbm9wbCB4dG9wb2xvZ3kgbm9uc3RvcF90c2MgY3B1aWQgYXBlcmZtcGVyZiB0c2Nf
a25vd25fZnJlcSBwbmkgcGNsbXVscWRxIGR0ZXM2NCBtb25pdG9yIGRzX2NwbCB2bXggc214IGVz
dCB0bTIgc3NzZTMgc2RiZyBmbWEgY3gxNiB4dHByIHBkY20gcGNpZCBzc2U0XzEgc3NlNF8yIHgy
YXBpYyBtb3ZiZSBwb3BjbnQgdHNjX2RlYWRsaW5lX3RpbWVyIGFlcyB4c2F2ZSBhdnggZjE2YyBy
ZHJhbmQgbGFoZl9sbSBhYm0gM2Rub3dwcmVmZXRjaCBjcHVpZF9mYXVsdCBlcGIgc3NiZCBpYnJz
IGlicGIgc3RpYnAgaWJyc19lbmhhbmNlZCB0cHJfc2hhZG93IGZsZXhwcmlvcml0eSBlcHQgdnBp
ZCBlcHRfYWQgZnNnc2Jhc2UgdHNjX2FkanVzdCBibWkxIGF2eDIgc21lcCBibWkyIGVybXMgaW52
cGNpZCByZHNlZWQgYWR4IHNtYXAgY2xmbHVzaG9wdCBjbHdiIGludGVsX3B0IHNoYV9uaSB4c2F2
ZW9wdCB4c2F2ZWMgeGdldGJ2MSB4c2F2ZXMgc3BsaXRfbG9ja19kZXRlY3QgdXNlcl9zaHN0ayBh
dnhfdm5uaSBkdGhlcm0gaWRhIGFyYXQgcGxuIHB0cyBod3AgaHdwX25vdGlmeSBod3BfYWN0X3dp
bmRvdyBod3BfZXBwIGh3cF9wa2dfcmVxIGhmaSB2bm1pIHVtaXAgcGt1IG9zcGtlIHdhaXRwa2cg
Z2ZuaSB2YWVzIHZwY2xtdWxxZHEgcmRwaWQgYnVzX2xvY2tfZGV0ZWN0IG1vdmRpcmkgbW92ZGly
NjRiIGZzcm0gbWRfY2xlYXIgc2VyaWFsaXplIHBjb25maWcgYXJjaF9sYnIgaWJ0IGZsdXNoX2wx
ZCBhcmNoX2NhcGFiaWxpdGllcw0KPiANCj4gDQo+IGFsc28gSSBoYWQgdG8gbWVyZ2UgaW4gYnBm
LW5leHQvbWFzdGVyIHRvIGJlIGFibGUgdG8gYnVpbGQgaXQsDQo+IHdoYXQgaXNzdWVzIGRpZCB5
b3Ugc2VlPw0KPiANCg0KQWguIEkgaGFkIHZhcmlvdXMgY29tcGlsZSBpc3N1ZXMuIFNvbWUgb2Yg
d2hpY2ggd2VyZSBJIGd1ZXNzIHRoZSBjb21tb24gaXNzdWUgb2YNCm5lZWRpbmcgdGhlIGxhdGVz
dCB0b29scywgYnV0IGFsc28gc29tZSBvdGhlcnMuIElJUkMgc29tZSBzcGluIGxvY2sgZGVmaW5p
dGlvbnMNCndlcmUgbWlzc2luZy4gSSBndWVzcyBpdCBwcm9iYWJseSB3YXMgdGhlIGxhY2sgb2Yg
bWVyZ2luZyB0aGF0IGJyYW5jaC4gQnV0IEkgd2FzDQpqdXN0IGdvaW5nIHRvIHJ1biB0aGUgdGVz
dCwgc28gaWYgeW91IGFscmVhZHkgaGF2ZSwgSSdsbCBza2lwIGl0Lg0K

