Return-Path: <bpf+bounces-75796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA01DC96009
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 08:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A9263423C3
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 07:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493232BE04D;
	Mon,  1 Dec 2025 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FNCWnmtN"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9353E2147F9;
	Mon,  1 Dec 2025 07:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764574186; cv=fail; b=JEGuy4VudytRSww2b/6vHHDYMjA2ff+H/NDLmRNBAdFXNS456PxDKE6IjsOZ2ZW7A1MbyP7Ga2pOHBzAyVGKSJguwTZn9MPJsMl9J9TmY36YU6lqqo23q0IhBHWgtH3aPZqLycqBghK7EIxvCzeueOZPXLJiiwxD+3/Xqc5rKPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764574186; c=relaxed/simple;
	bh=NvGnT1x0c2YNgsnylZFLedcFB1ozXB51lGwUE7BlEnI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IoJs1aDAJQWEssPuRHIx146SMlSB0967Xe8WcbG46CJ1o71X3eeBWuJ6lS4sBhK0FeK0QncgWKrrpcx9yJ9AthrBa3VSd8Tk6gE1QPwEBlwto9TaSVxYpOYMcRV1Vpu7LC0xWZqNSVvq1HNIHHMlnJSGNu349RNWxe/RQDn91Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FNCWnmtN; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764574184; x=1796110184;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NvGnT1x0c2YNgsnylZFLedcFB1ozXB51lGwUE7BlEnI=;
  b=FNCWnmtNR9Pzvw926obL61hT5EyUyzGVvdssmBla/EkRFXNHgAi4MO5k
   6USZIGDFQAbWuRlV1fQlYwYIktio3DsZvZVlpRFW7VcLdqIE9ycsWshur
   FzYG2cYl7iyrDxz0iVX57mvngSfKbRZ7ERvuBrNV+bCtxz+JzBvrsMrwL
   5K/SeDQ7AHWYWhKYbmoQVaXk3HWGLm+VlVmXJJqRFo9rYEqE+R8dM5kZE
   3kv3eKLsO0jWyQAv0aUlWM99xluLnSHl8TFtLLbFnrs2H4HnQAYAGiC/x
   IOgX636X9gmJ+0iR8j9Or7rGwte8T1dCe3TWMjFc5dKGzO2h/5qYaxJRG
   A==;
X-CSE-ConnectionGUID: ioT80hfcQvqYq7EZ+bnSFw==
X-CSE-MsgGUID: 8Go0fTrhQ7mJ4UMVPbcz2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="84109556"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="84109556"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 23:29:44 -0800
X-CSE-ConnectionGUID: ixQ4dt7yQPu3geH2MfrEEQ==
X-CSE-MsgGUID: iEivMNuOQtuTIQZJ3g7qXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="194099311"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 23:29:44 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 30 Nov 2025 23:29:42 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Sun, 30 Nov 2025 23:29:42 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.69) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 30 Nov 2025 23:29:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UevHS32vvRPMHcnq/BrbyKswtnbZ6EvZFV11f1qNX7h/Y9gTpv9xyZ6iI7i6W+Up0RMq3oDVNqS0e0l5wmOLgoyfsQu9xt+KadcHkldVqQnrZWUaCaUpwj2AKHthEWJUO+e5KIl2UJwbLJ4Fk3kFZnACAmZsXuDiNo93O8ORFHp/CP4BBRIk3J070LgZiUyNDSTqWDiReOUJkmYEz8jzV5cFv8bKqXxkin+b/iQju2VzwSQxv0z93VFmht8cHFZMs5qOaPZxUTLKLbCM0sRPpqy9VL9T6x3JkxpGumxPtkXemALlUesTDqwIVM+CiUM8oRlzkhPHyjDorUdmIU5ebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvGnT1x0c2YNgsnylZFLedcFB1ozXB51lGwUE7BlEnI=;
 b=rGABN2y/T9Fc7bD/1cx3AQtvKz/5QfAqYH17aTNnhDwGDpy+A6wZKr5ZGojCZVqlHNijEGhoDUVxb21iYCDW3ZjAN5PlBP2fcBuNobnSF6DG+F93OT271FnF4eGGbmk8k4Qkn5ZdxSzZr8LNyDuYvCewtBn0vhD51ybCl1b5k21exfGX6oVdR7jnZ98b8UbhlB+tsDmX9KryMEVyoKz482prlKDiDlvW4ZouQ8g3WRGrb3SCi3ekrv6mxxoNCDvBUh7m5314zUq1TlsQTLdv5rmY2mC9fJS1a4gpz7FKFjSGJYEVN+39eDvD6N7xUfIe+JCjUjdgJlaSKh0cMFgU2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ0PR11MB4862.namprd11.prod.outlook.com (2603:10b6:a03:2de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 07:29:40 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 07:29:39 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Mina Almasry <almasrymina@google.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, YiFei Zhu <zhuyifei@google.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Richard Cochran
	<richardcochran@gmail.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v1] idpf: export RX hardware
 timestamping information to XDP
Thread-Topic: [Intel-wired-lan] [PATCH net-next v1] idpf: export RX hardware
 timestamping information to XDP
Thread-Index: AQHcW7mOEioV57xnd0yuKi6/nWj2urUBgcBAgAqKGgCAAGS1gA==
Date: Mon, 1 Dec 2025 07:29:39 +0000
Message-ID: <IA3PR11MB8986359263651CCAEF537CAFE5DBA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251122140839.3922015-1-almasrymina@google.com>
 <DS4PPF7551E6552ECCF95AE9C177DEF07F8E5D0A@DS4PPF7551E6552.namprd11.prod.outlook.com>
 <CAHS8izOjZxEgBmYEhZanp57ukCYU5i5FdWfx5HO5+Ua2V3Owsg@mail.gmail.com>
In-Reply-To: <CAHS8izOjZxEgBmYEhZanp57ukCYU5i5FdWfx5HO5+Ua2V3Owsg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ0PR11MB4862:EE_
x-ms-office365-filtering-correlation-id: deffbdd4-650a-408b-fdbf-08de30ab6309
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?U2I0ZFJ5cXh5L0lub2JFZUl5ckNVdEtvY0VmY05GM2RtNCtkMnBhcUl4UHRr?=
 =?utf-8?B?OFZaWHIzMTcxVXJwMk93cmVqTzNXU0JLa2prYk54ODRYR1NBOEJYeTJmOFo2?=
 =?utf-8?B?RHd2aWRDS1JEVlI4dytWTitrVG5uTGZ4U0t6ZDR1YW5yc3NhcEJRY1dBazdl?=
 =?utf-8?B?bTF2L0tBdzExeXBpS3FFNjJJdWlwNjFIWGRDUm1WVEJHWDEvUENJVjY2eXk3?=
 =?utf-8?B?RXlmMmVVaFQ0c2c2VEJyVWxISWtTMG1NekEvcG96dUdzN1pGQnh3cmlvK3lv?=
 =?utf-8?B?dE45ZldjL0x3VGhuODhES2dxNnRoY01oanVzWVMyS0Y1L0pYczJrcFhJNVlr?=
 =?utf-8?B?Y0hiNzNWR3IzN2RQMGdyZTczSzd2SXhEdkJaR0RZYVowdU1VSmJIaEdXNjdw?=
 =?utf-8?B?UXBGR2JwUitqb1ZCSFI5cGNDaEZwM0U3K0hPaGpQQ1NjVE9tcTJkSmxjNnNP?=
 =?utf-8?B?MXZia2lzZHgxQ2ZLU3RHSWNhSDNDRVBNV1RzNk03RXBMVXlVY2JoRHJOaVJQ?=
 =?utf-8?B?UEtja09lZHh4eFduL1NabEVDNTEvSkgvVEo1R0FlMDVVZGUzUnJ2UkoxckdI?=
 =?utf-8?B?VEFJSFhOY09pd1ZycmFJK0wycG41dVoxZlN4aHkyS1JRdnlySFpQV1Rqb1Vv?=
 =?utf-8?B?Y2Y1YmpxNlY4YjBmUGcrU0hkVmRySzBBdFpHcC8yKzM3T3F1VGNNSEpNV3Jj?=
 =?utf-8?B?bkxtS2FmRGlEWE9rVi9sVUpLRU5Qc0ZjZkdmZUhzVjhWSEFIdEFySVRERjZL?=
 =?utf-8?B?UlovVUVuMG1OeHZJQUlvNlZuN01NbE9LUUwyWjdrMnpIeEZzaGFMemFLVFd1?=
 =?utf-8?B?NldURG9jSWpzZTNhbVR6bnkrVjRPOEpzTFRzaXYrYnpGNFI4UEd1Z3A4Z3BZ?=
 =?utf-8?B?aHdlcGgyUGhaakZXb2pNRWVRTTR5Z1BQVmxMNWF3NmlFYVhtdzJuZXA3NVV0?=
 =?utf-8?B?clVINHZoTDJBQ1VORWlad3ZnMDdha2lNZU1KUU1NWE92a0Q5VFFMYkJMYnZQ?=
 =?utf-8?B?UnlYNENaVEQvNkhUL0FTYXY2LzZiaDVNWUNsVERxbEFVdDl6L2N3aG1nUEkx?=
 =?utf-8?B?d3NrK1kraHVncWJIVTM5WEdtREtKUHJuZkNwRmJwUmtHYkgwaWppUzRTV3Bk?=
 =?utf-8?B?d2pNbGpmMHRxaUdkRVJuS01GUXdYQU9vdWNaNTVQWnNLclg0bWQwdEtocGpW?=
 =?utf-8?B?TXFGYy9zU2tQQzQ3NjNseCtPeHJmcVBrNVQxZkU1NGNaKzhJU1E4bWJ3enJW?=
 =?utf-8?B?U0xCTWx0dGFYN1VRbGZzREhHZ2daWVltVGJTVkV5TC9CLysybFlPRHh4YUpG?=
 =?utf-8?B?VlI5VWdtMUNLbjZKL0U4NlJnU0RhU05LRW1NQzFQL0tGbHJxUmt3dGRsbkla?=
 =?utf-8?B?Um54eEdSL0xpTEx0Q1V4b3h6NTUyMjRQNGxTYWtzL2tYT2NmeDBVN2x6TVR3?=
 =?utf-8?B?OWlFdUsweXJGWTBXUVRRL1NjZDB2KzFRWVBJRG05OFJraFk5S3R0Ryt0UUl1?=
 =?utf-8?B?T01rQURIbnl3YmNpeTBjR05xcDRVMmgwRDIrYldJWDRvdmNWcm1BcVVpdzk3?=
 =?utf-8?B?VGJUOHdwVjA3V1l0cnBBY0ZkZ05wbm1tMFZzSUQ1bTNpN0l0cWh1ZXpGaS9O?=
 =?utf-8?B?ZXBad21lZ3FLbGV1NEY0V21aMnhuWjN4a0k0cjlUWmd2ZUdGcm5KeGMzL0p6?=
 =?utf-8?B?MDU2WVhUakxlRWE4QnlPUFhjK3dpcTM5a1Z1S2k2ZzZhNUN5SE41Qm1rNi9T?=
 =?utf-8?B?K2NDRlVuMzFuOXo1SGI4cS9MVVVNQ3hUTTdaR1JxMzQ1dWFTZ2R4WjVyZFpp?=
 =?utf-8?B?cHlmUUloWVdPNHlXQkY2cXhaL2R3ODZzN2dCTFRCU1VPN2UvUDZsNkkzZTZx?=
 =?utf-8?B?TExiRlZQYkVEWVVPZzlTcXRlaW1SUVQzYkFwMVlSdmVNc0lHMHdUaTlITGNl?=
 =?utf-8?B?LzUwdXZhV3BsTU5LbXA2dFBaZmxGQzI1aGIxWW1mODg5R1RCY1ZQUi80d2k4?=
 =?utf-8?B?TkJmVkQrRVBSUHBON1NEcUYxWVF3ZTBPRHF2Ty95cXc4ODkwL2VSeHVBc3A2?=
 =?utf-8?Q?nvvGzG?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUNGMENobmRheW1vRU5CNCs3NWNWaGhwekwyNmJtNjZML0dlVFNJbTF6NFdH?=
 =?utf-8?B?N2dya0xYRkdNWVAzM0RMMEQyNkJFTGNOYVN5YlVwK0NEQ293TWZsSTZ1UzJu?=
 =?utf-8?B?YWdHeGhzWG5SZWlwZDJENnAxVHE0cUVxYnB6bGEyT0JVWWhJdEIrdHJkdTBo?=
 =?utf-8?B?TWN3TENMUmdoZmVKS0x0ckZNWmg4MUk0ZGhKVElSem5rYWJoQUFyMVhMc2VD?=
 =?utf-8?B?TGViT0NmejV2dkxDRzlrK0dNRVBBZ25nbkpETjNJOExtRjdjcW9xbHI3QVhm?=
 =?utf-8?B?YVd5TmhyMFlGMWJCNEJpelkxbHRmOGxybytndjR4VUV6V05ycitXU0g3ZjNp?=
 =?utf-8?B?MzQ1Y0ZUeVdtOWsxUEUwZzV5YlRGTXJTMGVBb3I3TkN3NmZzeFFmeC9obklP?=
 =?utf-8?B?ZnV0RXk2TTFOaTFSVmd4K0pCUzUzdDJxeE9KYUo3UnlaSVV6d2hOQ2c4Z2hF?=
 =?utf-8?B?QUNqZWRNRU1JeFlSVThlQlV3TXNvMkwwcHFzYTBYS0tSUk40RU5sM1BhdjBY?=
 =?utf-8?B?N3hnT1lhNzRieU9UVE9tRnRUcjdoZjNKUi9FcHNqNkZNbWxuVlNvSG9pMm93?=
 =?utf-8?B?ek05UVdQQTlONTVxdmN6THhyM1o4ZG5HYVYvc090S2dYM1dycUc5cXRleWd6?=
 =?utf-8?B?OGNFMG1tejdiM0FhK3drOFZKN1REVE9vQThRSC85RVdNcmcrNTRXR28xcWEz?=
 =?utf-8?B?c2N0VHpPWW4vTjJUdk8wQWZaeVZ6WmpORVVDL2g1bGNqUlBqd2xvOTVmb0Ji?=
 =?utf-8?B?Rmhrc3FRbUQwQ1hqNkNHTlo2ZkNwNS9rcnRMZnpzMW9xeWVUblFRMGd5VEhZ?=
 =?utf-8?B?V3BVUkl6OUM4Z2J3aHhmb24rVmVYd1hkZUdtR0lCZjFaL0ROY29OSGw0VWdZ?=
 =?utf-8?B?aGpsd2h5Vk13dGFSdHNXdzYyWk1rMjRGQVMvdG94YlJ3Uk5jZStwREU0TDMr?=
 =?utf-8?B?LzlpSmczYi9YYnhyRXcyeHFUZURnb1ZGRGkzNmNKcWRWbml1eGU1dWovd1FD?=
 =?utf-8?B?R0xhWVFIUnhxN2dON2hmSGdZVFR6THYvY3EweVdGbkljMVhoY3V3dUY4TWhB?=
 =?utf-8?B?UkdJL0MvK2dOVkw2MTRXbVR3cnRKRnUvUU1EVFNwUnFScEFTQWloRk8xRlVs?=
 =?utf-8?B?ZUttT1U4Qmx0RlRMNTIyL241TS9WV2dzOTJTYk5KNUdSdVlab0FvdFNNaHhm?=
 =?utf-8?B?OWVsSmNwY2FjQUxsdkVJQTEzd2NwQmpzdkVhVUgwYy9jeFZZeXFwQWNiOU9D?=
 =?utf-8?B?SklPTE14dTUyYlhKUFdIY3l1YWJZdzVLOG5qL1lBa21pOVJWREhCV0taSStU?=
 =?utf-8?B?UjFGNWI3Qlh2bzVQdWRUZ2xWcGREaG82eElxOFNqWjZsOUxsNlJnZTNBQzZ1?=
 =?utf-8?B?WU1jeGJETlk0RDd3Q0Q5VEZkNEFaR01PVXdjSlpEOXZGK2ZORWpJRzl5L3gx?=
 =?utf-8?B?UGlOcU5xQ0pqQng2U3BzR0grUFYwZXdURCt1bmFzSDVyNDU2a3hwY0pUdE1G?=
 =?utf-8?B?eFJ3elI0S1BHVVErNWlyOFNPU1Q2b3FTaVNJWjlkWE9xdHhNVCtVemx4VlZt?=
 =?utf-8?B?T0cwM0NYR3lZbHVXeGZMMzNNdCtXQldLaVRMS1NuOUpJNkw4Q2ZMaFF4allM?=
 =?utf-8?B?Z2U1cDhhZWkwL3J5Q1huOVpncHR3T1A1S2Y4ak5mNFh4UDdPNFVGcVlvVmpx?=
 =?utf-8?B?cVk5MjdsSDUrYlhHMWpPNmUwMEZMeHJJSkRham9ISFM2OHRWMFN1Q0NhYlli?=
 =?utf-8?B?VFJNZU9zdk9zY2lHc2FVZWdHaDRGZkpmdnA1Y004dk9WM2prd255cC92dlls?=
 =?utf-8?B?YkIrRjl6Tjl5R0QzcFJPWUhNMVNEQm5rUzVyMG1uTTNLSFJZcjlMb055Wi8y?=
 =?utf-8?B?MnFLZ01YUzJraWNzVEN6SzBvaW43QWVKd1lkWFlZcEpKRzAwVCtkOHU3Nmoy?=
 =?utf-8?B?VnpUQm5hbzVvQ1FlV3Q5NlBlYXVnc1krR1NZTnFhcHVNTHROTlpXQ2VwY0FU?=
 =?utf-8?B?b2xxUkNGQ1FTdkttQUJoUStkaExlRnZOWlRTT2dyWmNxMkwxa1dSTEgybndh?=
 =?utf-8?B?eWxwall6MnRYZ3ZET1EyVHoyRWJ0cWpHQzVpL0FFUytIN1Rrby9aOXJjSVFw?=
 =?utf-8?B?WmtKNWV3eGpvZXYxV05nMFN6YzhZRWtyajlSRXdicUN1M2YrcmFpTHYxNDRS?=
 =?utf-8?B?OWc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: deffbdd4-650a-408b-fdbf-08de30ab6309
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 07:29:39.1882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Gn+pYHcc0fv/21vo3dnRJiZGXAQlgPOfo13yprCvqaxTKHvN22/CV7eDIkV3LFYswSr6/6LNvLzfCvK3l9nyomKbDXDWPu7nCtrXkbE0o8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4862
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWluYSBBbG1hc3J5IDxh
bG1hc3J5bWluYUBnb29nbGUuY29tPg0KPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDEsIDIwMjUg
MjoyNyBBTQ0KPiBUbzogTG9rdGlvbm92LCBBbGVrc2FuZHIgPGFsZWtzYW5kci5sb2t0aW9ub3ZA
aW50ZWwuY29tPg0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgYnBmQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFlpRmVpIFpodSA8emh1eWlm
ZWlAZ29vZ2xlLmNvbT47IEFsZXhlaQ0KPiBTdGFyb3ZvaXRvdiA8YXN0QGtlcm5lbC5vcmc+OyBE
YW5pZWwgQm9ya21hbm4gPGRhbmllbEBpb2dlYXJib3gubmV0PjsNCj4gRGF2aWQgUy4gTWlsbGVy
IDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgSmFrdWIgS2ljaW5za2kNCj4gPGt1YmFAa2VybmVsLm9y
Zz47IEplc3BlciBEYW5nYWFyZCBCcm91ZXIgPGhhd2tAa2VybmVsLm9yZz47IEpvaG4NCj4gRmFz
dGFiZW5kIDxqb2huLmZhc3RhYmVuZEBnbWFpbC5jb20+OyBTdGFuaXNsYXYgRm9taWNoZXYNCj4g
PHNkZkBmb21pY2hldi5tZT47IE5ndXllbiwgQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGlu
dGVsLmNvbT47DQo+IEtpdHN6ZWwsIFByemVteXNsYXcgPHByemVteXNsYXcua2l0c3plbEBpbnRl
bC5jb20+OyBBbmRyZXcgTHVubg0KPiA8YW5kcmV3K25ldGRldkBsdW5uLmNoPjsgRXJpYyBEdW1h
emV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgUGFvbG8NCj4gQWJlbmkgPHBhYmVuaUByZWRoYXQu
Y29tPjsgTG9iYWtpbiwgQWxla3NhbmRlcg0KPiA8YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNv
bT47IFJpY2hhcmQgQ29jaHJhbg0KPiA8cmljaGFyZGNvY2hyYW5AZ21haWwuY29tPjsgaW50ZWwt
d2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmcNCj4gU3ViamVjdDogUmU6IFtJbnRlbC13aXJlZC1s
YW5dIFtQQVRDSCBuZXQtbmV4dCB2MV0gaWRwZjogZXhwb3J0IFJYDQo+IGhhcmR3YXJlIHRpbWVz
dGFtcGluZyBpbmZvcm1hdGlvbiB0byBYRFANCj4gDQo+IE9uIE1vbiwgTm92IDI0LCAyMDI1IGF0
IDI6MzPigK9BTSBMb2t0aW9ub3YsIEFsZWtzYW5kcg0KPiA8YWxla3NhbmRyLmxva3Rpb25vdkBp
bnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPiA+IEZyb206IEludGVsLXdpcmVkLWxhbiA8aW50ZWwtd2lyZWQtbGFuLWJv
dW5jZXNAb3N1b3NsLm9yZz4gT24NCj4gQmVoYWxmDQo+ID4gPiBPZiBNaW5hIEFsbWFzcnkNCj4g
PiA+IFNlbnQ6IFNhdHVyZGF5LCBOb3ZlbWJlciAyMiwgMjAyNSAzOjA5IFBNDQo+ID4gPiBUbzog
bmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgYnBmQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+ID4g
PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBDYzogWWlGZWkgWmh1IDx6aHV5aWZlaUBn
b29nbGUuY29tPjsgQWxleGVpIFN0YXJvdm9pdG92DQo+ID4gPiA8YXN0QGtlcm5lbC5vcmc+OyBE
YW5pZWwgQm9ya21hbm4gPGRhbmllbEBpb2dlYXJib3gubmV0PjsgRGF2aWQgUy4NCj4gPiA+IE1p
bGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5v
cmc+Ow0KPiA+ID4gSmVzcGVyIERhbmdhYXJkIEJyb3VlciA8aGF3a0BrZXJuZWwub3JnPjsgSm9o
biBGYXN0YWJlbmQNCj4gPiA+IDxqb2huLmZhc3RhYmVuZEBnbWFpbC5jb20+OyBTdGFuaXNsYXYg
Rm9taWNoZXYgPHNkZkBmb21pY2hldi5tZT47DQo+ID4gPiBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50
aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBLaXRzemVsLA0KPiBQcnplbXlzbGF3DQo+ID4gPiA8
cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47IEFuZHJldyBMdW5uDQo+IDxhbmRyZXcrbmV0
ZGV2QGx1bm4uY2g+Ow0KPiA+ID4gRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsg
UGFvbG8gQWJlbmkNCj4gPHBhYmVuaUByZWRoYXQuY29tPjsNCj4gPiA+IExvYmFraW4sIEFsZWtz
YW5kZXIgPGFsZWtzYW5kZXIubG9iYWtpbkBpbnRlbC5jb20+OyBSaWNoYXJkDQo+IENvY2hyYW4N
Cj4gPiA+IDxyaWNoYXJkY29jaHJhbkBnbWFpbC5jb20+OyBpbnRlbC13aXJlZC1sYW5AbGlzdHMu
b3N1b3NsLm9yZzsgTWluYQ0KPiA+ID4gQWxtYXNyeSA8YWxtYXNyeW1pbmFAZ29vZ2xlLmNvbT4N
Cj4gPiA+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBuZXQtbmV4dCB2MV0gaWRw
ZjogZXhwb3J0IFJYDQo+ID4gPiBoYXJkd2FyZSB0aW1lc3RhbXBpbmcgaW5mb3JtYXRpb24gdG8g
WERQDQo+ID4gPg0KPiA+ID4gRnJvbTogWWlGZWkgWmh1IDx6aHV5aWZlaUBnb29nbGUuY29tPg0K
PiA+ID4NCj4gPiA+IFRoZSBsb2dpYyBpcyBzaW1pbGFyIHRvIGlkcGZfcnhfaHd0c3RhbXAsIGJ1
dCB0aGUgZGF0YSBpcyBleHBvcnRlZA0KPiA+ID4gYXMgYSBCUEYga2Z1bmMgaW5zdGVhZCBvZiBh
cHBlbmRlZCB0byBhbiBza2IuDQo+ID4gPg0KPiA+ID4gQSBpZHBmX3F1ZXVlX2hhcyhQVFAsIHJ4
cSkgY29uZGl0aW9uIGlzIGFkZGVkIHRvIGNoZWNrIHRoZSBxdWV1ZQ0KPiA+ID4gc3VwcG9ydHMg
UFRQIHNpbWlsYXIgdG8gaWRwZl9yeF9wcm9jZXNzX3NrYl9maWVsZHMuDQo+ID4gPg0KPiA+ID4g
Q2M6IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+ID4gPg0KPiA+ID4gU2lnbmVk
LW9mZi1ieTogWWlGZWkgWmh1IDx6aHV5aWZlaUBnb29nbGUuY29tPg0KPiA+ID4gU2lnbmVkLW9m
Zi1ieTogTWluYSBBbG1hc3J5IDxhbG1hc3J5bWluYUBnb29nbGUuY29tPg0KPiA+ID4gLS0tDQo+
ID4gPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi94ZHAuYyB8IDI3DQo+ID4gPiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjcgaW5z
ZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pZHBmL3hkcC5jDQo+ID4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lk
cGYveGRwLmMNCj4gPiA+IGluZGV4IDIxY2UyNWIwNTY3Zi4uODUwMzg5Y2E2NmI2IDEwMDY0NA0K
PiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi94ZHAuYw0KPiA+ID4g
KysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi94ZHAuYw0KPiA+ID4gQEAgLTIs
NiArMiw3IEBADQo+ID4gPiAgLyogQ29weXJpZ2h0IChDKSAyMDI1IEludGVsIENvcnBvcmF0aW9u
ICovDQo+ID4gPg0KPiA+ID4gICNpbmNsdWRlICJpZHBmLmgiDQo+ID4gPiArI2luY2x1ZGUgImlk
cGZfcHRwLmgiDQo+ID4gPiAgI2luY2x1ZGUgImlkcGZfdmlydGNobmwuaCINCj4gPiA+ICAjaW5j
bHVkZSAieGRwLmgiDQo+ID4gPiAgI2luY2x1ZGUgInhzay5oIg0KPiA+ID4gQEAgLTM2OSw2ICsz
NzAsMzEgQEAgaW50IGlkcGZfeGRwX3htaXQoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgaW50DQo+
ID4gPiBuLCBzdHJ1Y3QgeGRwX2ZyYW1lICoqZnJhbWVzLA0KPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGlkcGZfeGRwX3R4X2ZpbmFsaXplKTsgIH0NCj4gPiA+DQo+
ID4gPiArc3RhdGljIGludCBpZHBmX3hkcG1vX3J4X3RpbWVzdGFtcChjb25zdCBzdHJ1Y3QgeGRw
X21kICpjdHgsIHU2NA0KPiA+ID4gKyp0aW1lc3RhbXApIHsNCj4gPiA+ICsgICAgIGNvbnN0IHN0
cnVjdCB2aXJ0Y2hubDJfcnhfZmxleF9kZXNjX2Fkdl9uaWNfMyAqcnhfZGVzYzsNCj4gPiA+ICsg
ICAgIGNvbnN0IHN0cnVjdCBsaWJldGhfeGRwX2J1ZmYgKnhkcCA9ICh0eXBlb2YoeGRwKSljdHg7
DQo+ID4gPiArICAgICBjb25zdCBzdHJ1Y3QgaWRwZl9yeF9xdWV1ZSAqcnhxOw0KPiA+ID4gKyAg
ICAgdTY0IGNhY2hlZF90aW1lLCB0c19uczsNCj4gPiA+ICsgICAgIHUzMiB0c19oaWdoOw0KPiA+
ID4gKw0KPiA+ID4gKyAgICAgcnhfZGVzYyA9IHhkcC0+ZGVzYzsNCj4gPiA+ICsgICAgIHJ4cSA9
IGxpYmV0aF94ZHBfYnVmZl90b19ycSh4ZHAsIHR5cGVvZigqcnhxKSwgeGRwX3J4cSk7DQo+ID4g
PiArDQo+ID4gPiArICAgICBpZiAoIWlkcGZfcXVldWVfaGFzKFBUUCwgcnhxKSkNCj4gPiA+ICsg
ICAgICAgICAgICAgcmV0dXJuIC1FTk9EQVRBOw0KPiA+ID4gKyAgICAgaWYgKCEocnhfZGVzYy0+
dHNfbG93ICYgVklSVENITkwyX1JYX0ZMRVhfVFNUQU1QX1ZBTElEKSkNCj4gPiA+ICsgICAgICAg
ICAgICAgcmV0dXJuIC1FTk9EQVRBOw0KPiA+IFJYIGZsZXggZGVzYyBmaWVsZHMgYXJlIGxpdHRs
ZeKAkWVuZGlhbi4NCj4gPiBZb3UgYWxyZWFkeSBjb252ZXJ0IHRzX2hpZ2ggd2l0aCBsZTMyX3Rv
X2NwdSgpLCBidXQgdGVzdCB0c19sb3cNCj4gZGlyZWN0bHkgYWdhaW5zdCB0aGUgbWFzay4NCj4g
PiBPbiBiaWfigJFlbmRpYW4gdGhpcyBjYW4gbWlzZGV0ZWN0IHRoZSBiaXQgYW5kIHNwdXJpb3Vz
bHkgcmV0dXJuIC0NCj4gRU5PREFUQS4NCj4gPiBQbGVhc2UgY29udmVydCB0c19sb3cgdG8gaG9z
dCBvcmRlciBiZWZvcmUgdGhlIGJpdCB0ZXN0Lg0KPiA+IFNlZSBleGlzdGluZyBJRFBGL0lDRSBw
YXR0ZXJucyB3aGVyZSBkZXNjcmlwdG9yIHdvcmRzIGFyZQ0KPiBsZVhYX3RvX2NwdSgp4oCRY29u
dmVydGVkIHByaW9yIHRvIEZJRUxEX0dFVCgpIC8gYml0IGNoZWNrcy4NCj4gPiBBbHNvLCBwZXIg
dGhlIFhEUCBSWCBtZXRhZGF0YSBrZnVuYyBkb2NzLCAtRU5PREFUQSBtdXN0IHJlZmxlY3QgdHJ1
ZQ0KPiBhYnNlbmNlIG9mIHBlcuKAkXBhY2tldCBtZXRhZGF0YTsgZW5kaWFubmVzc+KAkWNvcnJl
Y3QgdGVzdGluZyBpcyByZXF1aXJlZA0KPiB0byB1cGhvbGQgdGhlIHNlbWFudGljLg0KPiA+DQo+
IA0KPiBIZXksIHNvcnJ5IGZvciB0aGUgbGF0ZSByZXBseS4gSW5pdGlhbGx5IHdoZW4gSSByZWFk
IHRoZSByZXBseSwgSQ0KPiB0aG91Z2h0OiAid2h5IG5vdCwgbGV0cyBhZGQgYSBsZVhYX3RvX2Nw
dSIuDQo+IA0KPiBCdXQgbm93IHRoYXQgSSBsb29rIGNsb3NlciB0byBpbXBsZW1lbnQgdGhlIGNo
YW5nZSBhbmQgc3VibWl0IHYyLCBpdA0KPiBsb29rcyBjb3JyZWN0IGFzIHdyaXR0ZW4uIHRzX2xv
dyBpcyBkZWZpbmVkIGFzIGEgdTg6DQo+IA0KPiBgYGANCj4gc3RydWN0IHZpcnRjaG5sMl9yeF9m
bGV4X2Rlc2NfYWR2X25pY18zIHsgLi4uDQo+IHU4IHRzX2xvdzsNCj4gYGBgDQo+IA0KPiBTbyBp
dCBzaG91bGQgbm90IGJlIGZlZCBpbnRvIGFueSBsZVhYX3RvX2NwdSgpIGZ1bmN0aW9ucywgbm8/
DQo+IA0KPiBJIGFsc28gbG9va2VkIGF0IG90aGVyIHU4IG1lbWJlcnMgaW4gdGhpcyBzdHJ1Y3Qg
bGlrZSBgdTgNCj4gc3RhdHVzX2VycjBfcXcwYCBhbmQgYHU4IHN0YXR1c19lcnIwX3F3MWAsIGFu
ZCBib3RoIGFyZSB1c2VkIGluDQo+IGV4aXN0aW5nIGNvZGUgd2l0aG91dCBhIGNvbnZlcnNpb24u
IFNvIGl0IHNlZW1zIGNvcnJlY3QgYXMgd3JpdHRlbi4NCj4gQ2FuIHlvdSByZWNvbnNkaXJlcj8N
Cj4gDQpPaCwgeWVzLiBZb3UgYXJlIHJpZ2h0LiBGb3IgdTggYnl0ZSBlbmRpYW5uZXNzIGhhcyBu
byBzZW5zZS4gU29ycnkuDQoNClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVr
c2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg0KDQoNCg==

