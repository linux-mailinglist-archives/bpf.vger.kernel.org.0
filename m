Return-Path: <bpf+bounces-50770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 798C0A2C531
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 15:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE2C188621D
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 14:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFA923ED6C;
	Fri,  7 Feb 2025 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XAYa3S7+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DD62206A0;
	Fri,  7 Feb 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938473; cv=fail; b=LHSyrxLlC8nKEk+e60DklLwITZNzXlsclZTkgX7+vaolW2T2ikRLWou7rIMI6eimaXuR3T+4A4oLQbmb5mpX51JFzwr0Cp6RcPlH1X2EzbwEc6HTXLILipwmedfhZHRg3evwQGOFGBFJvG+iWPys/53DCIYycQPf1F4xNOxrLE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938473; c=relaxed/simple;
	bh=1N9b4OkaXMOwfjrioSp1JtMEUXAYJnMkMk6ex/Suw/Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=McFRws6OI4uO94zJbGVhUmQFKzCvB1PkMGTE1sIZQorIDx9cbVu7iF8/yHVHq+IUPKOxf7IK63si5/J5KN5HHo/0DNHBXYma7lOTQw5ccWpw5A5IMfwqgxCJccNJ6ETgcjX0Ci5Z2VDDGPF1gVbvr+7R0TLsjBa/8b4mRrPqeN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XAYa3S7+; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738938471; x=1770474471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1N9b4OkaXMOwfjrioSp1JtMEUXAYJnMkMk6ex/Suw/Q=;
  b=XAYa3S7+woe5zndinTVdwD9cMFOm7kXYcPPKEA8MSoSIBix/VvoBmVE1
   xVLdmj7Rbt4vEL9AEuKXyMrTTaNlkug6RDjiBChWyqDuOOS841AmJ1YNB
   v4V4kHXAenW+g7U9ElK7rBJxIMW0UjVubzqEqZEIR89n5IXuw+FFizNLO
   V7alNj/Dcw0PzWQGtVQ3R5WyPIFZLmQAFd/ZF9nWYCj6S/ZgEV1q7Kepe
   GqSrUw3MJewPKmjvFPKjFVDvOiO1WPIfLi51gPdQhQQwVJSRMGYvFZPwK
   ZKi9UBZC/q9L+vR8z3oBDOY1s/3IrlKUvcQQktcjmXSqw9/UP0JBo/wsF
   A==;
X-CSE-ConnectionGUID: nAHHVWlaQ0GtPUE0N+KH1w==
X-CSE-MsgGUID: Y8iReTsIQYC4Z3mGZxXvFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="62057148"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="62057148"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 06:27:51 -0800
X-CSE-ConnectionGUID: /29Tf2d3SfS/oxdBdr1eZg==
X-CSE-MsgGUID: ZPvTjasKR3GbxcSe3ntzZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116146046"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2025 06:27:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 06:27:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 06:27:49 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 06:27:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8chZ04qPDD6ejBC0sDLYJhg5EB/BLyIvtGXiHOjCRmhTjxEorHmTRMozy+qRgy5tK3KuxW3MRvQctvgs/6sml0ZvSR7/IaTLgENnGu7A+/qNpEcOWXYSQMiROTZFrOX96hOHKqUTkGdbKPjMWh4YZCRUfrhseLICyrvSI9dUC6z+FqtmcECLlCya9WZWZ0kJJyCySH+BBRsyKCjpAMtgYvhNedGn7nZb4n2yapVnruSgfe860jXEAr+Ai0kTSgN6M2kSQPqsE1TcEoH1qqb1RaHlOBK9LwRSRsc6NVoKXX0e91RV9lYcLZsv4cOqeUXi5VtbSde+/UOSuDpVCtaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Omv0/5lnEj6N1Vtos9gVrkkgj5+NJifIL0MCMD/WvsA=;
 b=y+pRwgyd6dCH5pvWos8WcccDQYYA3g3BK2bDOIKIEK3WKVGQ2+pMqImReykwl7LYx8hysK8VRJcTnDBDgcpD73vF4meuDWFhvwILjwmqP5jqxFANdhF87z53ErSXXK81BiShfYdlhKwFtyypDEY2yklsX0ZbGfk7DQMAzt7aFFPO58mU9tkjfz/kxMJBoI29GSyVqLFfmkfZ6LA+xLoOP85WVp5EtNmJ/uyo4Yy/X0TGVq4j7t9fE7y4FpL1TpT5g44CrP4BTnMCTeQHUS39rrYhhTWUjKEyemvvJatCqAbsB9jIxfKvlHv5okwNdpQs4jlOtjaAli7/9ifJRzxmgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6289.namprd11.prod.outlook.com (2603:10b6:208:3e7::9)
 by MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 14:27:46 +0000
Received: from IA1PR11MB6289.namprd11.prod.outlook.com
 ([fe80::ec3c:2931:b0e8:c5b5]) by IA1PR11MB6289.namprd11.prod.outlook.com
 ([fe80::ec3c:2931:b0e8:c5b5%4]) with mapi id 15.20.8422.009; Fri, 7 Feb 2025
 14:27:46 +0000
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
Thread-Index: AQHbeMHRHWNWYkkSpU+E75RLaL8DrrM75wVA
Date: Fri, 7 Feb 2025 14:27:46 +0000
Message-ID: <IA1PR11MB62899945E3D2DCED17259B1E89F12@IA1PR11MB6289.namprd11.prod.outlook.com>
References: <20250206180551.1716413-1-sreedevi.joshi@intel.com>
In-Reply-To: <20250206180551.1716413-1-sreedevi.joshi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6289:EE_|MW5PR11MB5787:EE_
x-ms-office365-filtering-correlation-id: b891bf0e-82d1-4db3-5bdc-08dd478397b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ktttK8MpLjB4AqiYh6o7zj7s5hpkWc1R2CCOZrbPnCzABqkg9wZCIaPt2KVd?=
 =?us-ascii?Q?5WzId+KB6QVPYezBckawwv2yXe7sqav84ZnSXqQtFRjzvjRmRB8P0am2Y/bF?=
 =?us-ascii?Q?XW8aPxZQWhW1KD+Og08elnjwbFJXf/OpU7WOvVWHqpRgPq7pMyWhrNJ7l205?=
 =?us-ascii?Q?ObAZxOyLQcT7ti56Q2M3SxS/hesrf6nY33pbaZCXnLL1LK0MAHGcsu7uvz/P?=
 =?us-ascii?Q?8Bm0axL8nFLReOGqPjddYFkONiBalkSQrWSpJxPkWCs7bTwomec7I2JfJlQv?=
 =?us-ascii?Q?V+vF5j0jNhiaPtZWzzU1miPqFulp/pAgeeMZAA2YOYV5S4O4O33cfDFp27bS?=
 =?us-ascii?Q?BpLcOCMXWUemjOutqU11LDm1/joRC/tlIeWmkzC3W067z1erDHscZV1oFS25?=
 =?us-ascii?Q?fPzpRpHDpwuAjARczChkt27psk41TgpTqe53KHglhKDHJ8W8/StTv73ZiRQl?=
 =?us-ascii?Q?KbrTYCMm8T4Eg3V9Lx0NwGQzuAufosoigUxnRV1x0hnu7HMYVRLh1i8yEfyF?=
 =?us-ascii?Q?wRjRuNuz0HBqUzt6L584aduqATFDLKUe3Q4s1XLqbuDOBLEWAZxrNy2OphGp?=
 =?us-ascii?Q?tne4aGVFs4fs2jQpJY6pSE9icKQjEsc3yW1mV3aJwr4r6TcL+/SmN989PVIo?=
 =?us-ascii?Q?tcvfjwLSJxYPjDmas2poJsxq9CBle2yA0mJ7fGiImncsnaRhgHSe74SpXi41?=
 =?us-ascii?Q?jRUIK6N8D42CoHYaIcJaFFHzAW898nx1PNfyPzOY1IMyi8Cbo65wvea7Bk3S?=
 =?us-ascii?Q?kqKB/fPD+yLwPG7iOxw78gblCNVkxeZnBRrqZEE+BFkCjjwxA8apUNoIoi5u?=
 =?us-ascii?Q?L9BGsRs66QhWSdSfmfLRbUQO7TF7mfH58GakJTkeEHDSJWDh88ZedOi2rhb6?=
 =?us-ascii?Q?HWQcWXQI/TsXNdgEaJBpxKKNTE1RjN+tmnzZSzOGSfPvGhs2LOx+SbOurzsa?=
 =?us-ascii?Q?GCvqBE9l/bedcOpDDWtVgb27UlwkLFQAfMDjv/rbuDUPuIxtG0oCupe2Y7LF?=
 =?us-ascii?Q?o12gT3YlsJpVhd1SPijkixbmVvR+9jYrNt9x9XdaM3SYFmRo1lP4qYNhmOHf?=
 =?us-ascii?Q?4Ca0R0qMG5Snn3EKE/GkmZ4jTYGwirhQLRDJeNpafKrAlWpIR0HKz82tBfEN?=
 =?us-ascii?Q?pJe1p5zgZbpU/70B30MjHZEyG5aAqK27isOYi0c9p9cExpaVdF5MalDRYhI3?=
 =?us-ascii?Q?znMRQsfD1E4kdgSkRCql57Vbm2JiRhwrD8wuPQIumJ8pRHVwneeysGwT2PKU?=
 =?us-ascii?Q?EULxaK6IIHbVGWjerwynJWSINlPAbSJbzNNcMlz2GGZRszyUXguxC4Wxa9kS?=
 =?us-ascii?Q?5Qj8tmulFNz+XlHMXNl5qLK/NKnIdY4d0riKCRyl+g5E2Rn4B0Goleap52AT?=
 =?us-ascii?Q?4iMB2nFySMyHw3/gkmG8GMK9KdNj59uq0B35LabUv0nM3lFgJ6uUXWj2iqku?=
 =?us-ascii?Q?pwW2zJw4oRtCcZCJvU/j93KCglphNHPN?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L6Efqgsmg7Tw4eCdlxOwoDP68gJn2AoZh5s9OiNCWmyF7Prbx0riMXWdWGEz?=
 =?us-ascii?Q?wmRr8YvhD0F0H+aCqZg2I6r8SosMLHPCHT/77l2l/9kOIzdl6Bhwx8z+3V/o?=
 =?us-ascii?Q?StIKCA56sOLKOfoUMElQZuxh5R7fZ2mbxd+ReI4usdIWg1ONt38ENGpKtMWF?=
 =?us-ascii?Q?YVz5xg6aGVa0sLsjHtEPe3z8tUJBZzKOz/dSZwyRWpuCEpZ82RfxxByZ7Rh9?=
 =?us-ascii?Q?l9/glgq8jLKMUGVixt/28jj/zXh1/in+xHwAffQuXlaXpQIFkjkeGCiJqKvs?=
 =?us-ascii?Q?YXFtO4OU1POaETPehrLVoZRdXNHeX32MRw40F+kvzEB1rtqz4rlSqpl9StTg?=
 =?us-ascii?Q?Ol89C3Ue0w60t+CZvC+Dj+6GukLXZPVDjJOVBFJVgfKJI+7hG0jdWHi+kXlE?=
 =?us-ascii?Q?XJIdY/mE13Dacowbp5jKq6ra31IfSlo7rtlwVSlG4lcERTW7xHWX8v5kMLuq?=
 =?us-ascii?Q?INR4rLSum+wAXmbLk9fNFmKK788WMv7dWwDf34ItCq9fLsxOs+r6Ia4Wu3xm?=
 =?us-ascii?Q?CDJQrlGFoPKiDWeVezrSvNuXOuJ12dZuoQTxrD8MgAjRvmlzZlLIVNtyG9Re?=
 =?us-ascii?Q?RYW2xH3ao1dZRxnCRDKKamv8Uzr50qV1JHUc3ibAflULU7hp2fdNmY1HqLo4?=
 =?us-ascii?Q?gIreZFzM0lgDoP09f3I7DjLPaKyBKTI6FnzG6S+MbkgBaHhWmKTyGb6T2GV0?=
 =?us-ascii?Q?UVuFqdkR36VtrZ/IpC5dTp4QJogOZyjoTBA0M9wTDvah/i+me4zAMp3PeSsM?=
 =?us-ascii?Q?vHzB+VxP+BMOIYEjqFKuAbD8t2EIM9yLQnQA3cG0qMWwidX09D8uYRBNY/vA?=
 =?us-ascii?Q?AHh65KYNs2QwrS8G7Z3sjAPdrgSD6R6/3qW6rTTPMxHPmoy6JARW32Zh3zuG?=
 =?us-ascii?Q?D/LNRYstWsKiWkCxQAE2ioc8nSPdHuR6niOp3YCCw5/zGhzBWz4ME39hIR9Z?=
 =?us-ascii?Q?M77uNsG/w7iGh2+xcIYv2JJyt7zMiefStiqfOfIvo9MqfOiRxUFhUIX/r1Cb?=
 =?us-ascii?Q?oUY6Q0l5SKrPqJrs8ibsmlRUhTO1nqGGZi0q/ZjYTt48zloOx/w+eRQ8ORLZ?=
 =?us-ascii?Q?+k2UdkR87UxQFWqqUPfcrhi1A3tRyyOTeaprVIInNyDNzTOUTr8YFCwcztU6?=
 =?us-ascii?Q?1BGGfrp3P+BK4aKLG7Vk+4BIxtKLYcd0Z673cAFQpcj7lxNOLxODcY7hl20P?=
 =?us-ascii?Q?s0TW8dl8Y5GSXGU98v/L6keE0f57ntHzYpVrFuekSMtBngyYfwlRGPA6Xzlz?=
 =?us-ascii?Q?ysKKj4dJw0B8M2u+XI8Kzxi0rMFJilamc3VcM3W1OLYJungVPPs+ukYmSjlu?=
 =?us-ascii?Q?gHbT1pPWkoKkf0Th4jUMMlPWPg3TXCTllOyodySOAdlxnrBkz9Lh72OURyHp?=
 =?us-ascii?Q?Rl/gzl9I87+JaONboGo/2v1zv6+sRLyYyJbk1UOEoOtPx8cDo6hA6R1wtxRU?=
 =?us-ascii?Q?PrRK0SReP09JdRz0fVZ3ZnVy0Ick38v0DGgjtgCFS8+0phKMfbPi/+3dCsYN?=
 =?us-ascii?Q?QkOaEE8k9/RXJHayAPU2K0NKvU+wKM7v/vDW9T5GntPpKDQqwIKOlzhRXd+B?=
 =?us-ascii?Q?nRtRs6Vhh98ayL3pWp4igT+HaGzLotldn1frj/mP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b891bf0e-82d1-4db3-5bdc-08dd478397b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 14:27:46.7592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QmvWmR2Z6JU1Emg+GyjwPdCgQUiJ+zLiUm0piUt8W/+0Dr4gCvJY1soefYuAt6VLqAaiA+H/6MebrvhcunosnCuazYIOe+l5F6LyQf+970w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5787
X-OriginatorOrg: intel.com


> -----Original Message-----
> From: sreedevi.joshi <joshisre@ecsmtp.an.intel.com>
> Sent: Thursday, February 6, 2025 1:06 PM
> To: edumazet@gmail.com; kuba@kernel.org; pabeni@redhat.com; horms@kernel.=
org; ast@kernel.org; daniel@iogearbox.net
> Cc: Karlsson, Magnus <magnus.karlsson@intel.com>; Fijalkowski, Maciej <ma=
ciej.fijalkowski@intel.com>; hawk@kernel.org;
> john.fastabend@gmail.com; almasrymina@google.com; asml.silence@gmail.com;=
 lorenzo@kernel.org; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; chopps@labn.net; bigeasy@linutronix.de; n=
etdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> bpf@vger.kernel.org; Joshi, Sreedevi <sreedevi.joshi@intel.com>
> Subject: [RFC PATCH net 0/1] transport_header set incorrectly when using =
veth
>=20
> From: Sreedevi Joshi <sreedevi.joshi@intel.com>
>=20
> When testing a use-case on veth by attaching XDP and tc ingress hooks, it=
 was noticed that the transport_header is set incorrectly and
> causes the tc_ingress hook that is using bpf_skb_change_tail() call to re=
port a failure.
>=20
> Here is the flow:
> veth ingress:
> veth_convert_skb_to_xdp_buff()- [Example: skb->trannsport_header=3D65535 =
skb->network_header=3D0]
> ..>skb_pp_cow_data()
> ....>skb_headers_offset_update() - adds offset without checking and this
> 		results in transport_header value roll over.
> 		[off: 192: results in  skb->transport_header =3D 191, skb->network_head=
er=3D192] tc_ingress hook: bpf_skb_change_tail()
>   - Since transport_header < network_header, min_len is negative and it f=
ails.
>=20
> Two possbible solutions:
> option 1: introducing the check in the skb_headers_offset_update() to ski=
p adding offset
> 	to transport_header when it is not set. (patch attached) option 2: reset=
 transport header in veth_xdp_rcv_skb()
>=20
> Option 1 seems to be better as it will apply to any other interfaces that=
 may use skb_headers_offset_update and there seems to
> similar logic in the same function to check if mac_header was set before =
adding offset.
>=20
> Seeking your inputs on this.
>=20
> NOTES:
> 1. If veth is used without XDP hook attached, this issue is not observed =
as the logic uses __netif_rx() directly and the transport header
> is reset in __netif_receive_skb_core() as it detects it is not set.
>=20
> 2. Tested on i40e driver and confirmed it does not have this issue as the
> skb_headers_offset_update() is not in the processing path.
>=20
>=20
> Instructions to reproduce the issue along with the XDP and tc ingress pro=
grams is attached below.
>=20
> -------------------------------8<-------------------------------
> instructions:
>=20
> #build XDP and tc programs
> clang -O2 -g -target bpf -D__TARGET_ARCH_x86 -c xdp_prog.c -o xdp_prog.o =
clang -O2 -g -target bpf -D__TARGET_ARCH_x86 -c
> tc_bpf_prog.c -o tc_bpf_prog.o
>=20
> # create the veth pair
> ip link add veth0 numtxqueues 1 numrxqueues 1 type veth peer name veth1 \
>    numtxqueues 1 numrxqueues 1
>=20
> ip addr add 10.0.1.0/24 dev veth0
> ip addr add 10.0.1.1/24 dev veth1
> ip link set veth0 address 02:00:00:00:00:00 ip link set veth1 address 02:=
00:00:00:00:01 ip link set veth0 up ip link set veth1 up
>=20
> if [ -f /proc/net/if_inet6 ]; then
>     echo 1 > /proc/sys/net/ipv6/conf/veth0/disable_ipv6
>     echo 1 > /proc/sys/net/ipv6/conf/veth1/disable_ipv6
> fi
>=20
> #attach xdp hook and tc ingress hooks to veth1 xdp-loader load veth1 xdp_=
prog.o
>=20
> tc qdisc add dev veth1 clsact
> tc filter add dev veth1 ingress bpf da obj tc_bpf_prog.o sec prog
>=20
> # generate traffic from veth0 egress -> veth1 ingress ping -c e 10.0.1.3 =
-I veth0
>=20
> # observe the trace pipe (make sure tracing is on) # The following prints=
 will appear
> # ping-5330    [072] ..s2. 18266.403464: bpf_trace_printk: Failure.. new =
len=3D52 ret=3D-22
> cat /sys/kernel/debug/tracing/trace_pipe
>=20
> -------------------------------8<-------------------------------
> xdp_prog.c:
>=20
> #include <linux/bpf.h>
> #include <bpf/bpf_helpers.h>
>=20
> SEC("xdp") int netd_xdp_prog(struct xdp_md *xdp) {
>         /* Squash compiler warning. */
>         (void)xdp;
>=20
>         return XDP_PASS;
> }
>=20
> char _license[] SEC("license") =3D "GPL";
>=20
> -------------------------------8<-------------------------------
> test_bpf_prog.c:
>=20
> #include <linux/bpf.h>
> #include <bpf/bpf_helpers.h>
> #include <linux/pkt_cls.h>
>=20
> SEC("prog") int netd_tc_test_ingress(struct __sk_buff *skb)
> {
>         long ret;
>=20
>         /* extend skb length by 10 */
>         ret =3D bpf_skb_change_tail(skb, skb->len + 10, 0);
>         if (ret < 0) {
>                 bpf_printk("Failure.. new len=3D%d ret=3D%d\n", skb->len+=
10, ret);
>                 return TC_ACT_SHOT;
>         }
>=20
>         bpf_printk("Success new len:%d \n", skb->len+10);
>=20
>         return TC_ACT_UNSPEC;
> }
>=20
> char _license[] SEC("license") =3D "GPL";
>=20
> -------------------------------8<-------------------------------
>=20
> Sreedevi Joshi (1):
>   net: check transport_header before adding offset
>=20
>  net/core/skbuff.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> --
> 2.25.1
[]=20
Apologies for resending. Mail server had some issues earlier and didn't rea=
ch some recipients.=20


