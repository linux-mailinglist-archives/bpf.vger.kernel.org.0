Return-Path: <bpf+bounces-54287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 825EBA66F9B
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 10:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EFC416AF12
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 09:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD4520767C;
	Tue, 18 Mar 2025 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XuFq8jGg"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D44206F1A;
	Tue, 18 Mar 2025 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742289790; cv=fail; b=GWsQhGpq2I+luH+edJuRv2ZoM5AgzZbKahN5BZ+jn6UT6+00VG8UfS7eLBxZIoxR7PJkIeTZv10yh4oBS2DMNUBZ+ghgmkR9/8sc3RDetQz4+6kNNw5+VSpBwto3bwiuWEYjHcU3mFQEepv0e5LIeDBQmk0NY4QRjkGX7PjFHpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742289790; c=relaxed/simple;
	bh=IemWtusGQNOaKazbMFsvuJC4fF+arLPJsiz3pm3hoTs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n6AnlL+HrTR5aBOh8O4yYkut2MQKkMjmg8HLrExnPVnvDWCdqUhapUh92/3GDPJ/FH3cAtgE8hcV7MK/UbEku+hYuWsk1rDws3ThE6uI4MfaVVDg0KBuLMbXbHCcQzIgWyD7hH16FvAoJ/h6SPalNOo8GayCAFmaxeMRtBydwuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XuFq8jGg; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742289785; x=1773825785;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IemWtusGQNOaKazbMFsvuJC4fF+arLPJsiz3pm3hoTs=;
  b=XuFq8jGgY01qrwq4bw+IPXhHys04/rimJVACPgIhLES6ybWdlx7GxQPg
   lHclBy3zBRYGb1T05FTEpqr3Ds9Ui1KNjyc49JXu6wo4EkZ70h0yqHoey
   LXS7SlKzUICrSmdWQC2Qx/g/oX2AsKXM6Pu3ptS+VRK2poKDhlNKVVb7N
   XDdPRxN16RoPUyDgLSaaM7E5OfEZfY77SUdzLE8O3ht1ZXFL0lvApiPW2
   Tdo87wuOzA4pDqkZXZHQxas0Qh1AMIqYLKM7Nn5y/FUb5xhB76kMq+xpt
   a90+m9sCGaNk3K1OsFWqArUo5HVj2DEE0gBjvUIL5IRapy1GHHA4AJstV
   A==;
X-CSE-ConnectionGUID: PsRz7R4vTrSsUopBv13Elg==
X-CSE-MsgGUID: orzKYgN+QuKsN+49UfFCyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43156098"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="43156098"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 02:23:04 -0700
X-CSE-ConnectionGUID: t80JxMdnTEKgmnI/AXGsiA==
X-CSE-MsgGUID: Tl3RJn33RpyZ7ZqeZv130g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="121934929"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 02:23:04 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 18 Mar 2025 02:23:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 18 Mar 2025 02:23:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 02:23:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H33opT70ddfAA1dUP6CUuXhHc4W7OoKuG5iQcRJxi8O3pePp2G60Gb7PU3q9Fk+t02UZ6KeROuUjUXWtx7C0rpTAxAlxA9gu0NUwlsMhq5Gqnltv/YpDO1vRm+LDGWwzW2TSQ+KICx54mIqnh59s5TUcJ8KoMsamrblmD7w7nlfD6WlwqBxjRxGENh1DoT0AGV+dnTAeoFpYtsxUp41mtdR5VBzZDy+myEQ5U6flCuRJ06sGoBp+GfP81pZuDeDht9ZBYQ4ZkgnfVA5ri8slKUfJyzr7lgNAzwi2sB36QxP5XlOsslpK1Gzbkij+nQ650XaEtM3Rv+MWsX3Ig8ggJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMPsSoe5GISOLrblNYEZOIBquXPVJBARGyvuVSk6u7Y=;
 b=jJB1NapllhWwtg4t0voYoGJoKkXV8kXEloHiK8hx34HOJoenIa8MPYd87DNGxVrcZGXtgewXVEUbXwhHP6nGu1uX3V3ekshTj4r8bpziVUNWk8ORsNhaa8vJNKXf8Dg1K1w8cV0yctNEPaFSSk8ullWHbN+cTWfXaPNK5U9jAl2CzJfbF6YU4RvLhJfpp7zgcUCv5+MgEWbTdWcnHp4rTj1AR1Nug9v295r12N8F0Gk52DbEA3HlwXaCXF5bUG3ZNa8PdTbfNRa1uMFd+TInXba1b+pmkSsgnDYajRjMctibP7duId0vyHd5nRspfnb6BKKkLvtxOiZAcbAPFcsfZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6514.namprd11.prod.outlook.com (2603:10b6:208:3a2::16)
 by DS7PR11MB7738.namprd11.prod.outlook.com (2603:10b6:8:e0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Tue, 18 Mar 2025 09:22:55 +0000
Received: from IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::c633:7053:e247:2bef]) by IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::c633:7053:e247:2bef%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 09:22:55 +0000
From: "Vyavahare, Tushar" <tushar.vyavahare@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
Subject: RE: [PATCH bpf-next v3 2/2] selftests/xsk: Add tail adjustment tests
 and support check
Thread-Topic: [PATCH bpf-next v3 2/2] selftests/xsk: Add tail adjustment tests
 and support check
Thread-Index: AQHbjd1v/YORudaNxUqqCfJ6VIiP07NuiUOAgAooXWA=
Date: Tue, 18 Mar 2025 09:22:55 +0000
Message-ID: <IA1PR11MB6514B98679051D03FDDED9C78FDE2@IA1PR11MB6514.namprd11.prod.outlook.com>
References: <20250305141813.286906-1-tushar.vyavahare@intel.com>
 <20250305141813.286906-3-tushar.vyavahare@intel.com> <Z9C0/2uFFQPGozkr@boxer>
In-Reply-To: <Z9C0/2uFFQPGozkr@boxer>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6514:EE_|DS7PR11MB7738:EE_
x-ms-office365-filtering-correlation-id: d653f1ef-7294-45f1-f402-08dd65fe773c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?UT5kg34oMRU51aBJAT6UgbFfmkjzhShdqmga+1o51HJNKQU7gf6pcwBZsUPI?=
 =?us-ascii?Q?Vj6pb0ZhZ1SRXj/xm3fPa08vSHDn35XFyOwhfkwl3JRvg35pm+J5asWMiwBm?=
 =?us-ascii?Q?iqQS5nFAnV1DJbu7pT4+Tty+xHazqyvBPs6fZehjzgjxK7RI4ztjgbJCdiHI?=
 =?us-ascii?Q?xBeOrW5swTRGPJlbf2hREkviTGgq1SySCboOD2yQd0gfnqPq9hztsq+/Az4n?=
 =?us-ascii?Q?B5knY+/OviDxzzZq6FTZB/fhgNHzIK78dnZvFxKOJOpeOnBcpFAmgYvo0nnC?=
 =?us-ascii?Q?TkHDl68gQMe8kNdbGnKh4XW/XzFHRb4ioy2ei+3qTy8GbavnZ5xLWIkJ7RgW?=
 =?us-ascii?Q?HT2EV1FwI5YRPCdrod2CD4kty+SEnk+/m8tE275ZeflIVYoNzC9PrcvAopRW?=
 =?us-ascii?Q?q14ooRQqC6nG5g2THBXWVC0I8O7fqMniEBW4v9XKKaVkw2cZJX/Z7BzGOURV?=
 =?us-ascii?Q?/itXPENGwIIOSdm22c6dqI0sCW8uhRol6L98WOXMiMMgBfSou7SBnrbj4jmc?=
 =?us-ascii?Q?TdptR5OnCvj9e+LTwBbGITZak0sRFIbyj/PJc/R0nduHqKgW4tEEQwwmYNeG?=
 =?us-ascii?Q?/eho/JJHLPzleDsLQJX2UTF20l9xOxLBeTuvweFdNAdXPtwtEW3P1qH7EDkn?=
 =?us-ascii?Q?11XDhplT08TIvBwMmJ9ZvHbMQn54HD6OXD3CBi6ZQxCTSE2VOrNwCSklCOnd?=
 =?us-ascii?Q?OkBiMZ5HIDyvky0bxpNqL5aq0Loc+dacg/Y0is0MlUDQH9FI5v37YHL4no1P?=
 =?us-ascii?Q?BV0SejVuoWH3BvukunwXLXrweVmI3aTtq4LjHgZIct6orfsH7fw2YRef0CE0?=
 =?us-ascii?Q?TKYR/hRlBbO1aFjRbyBwXsnqhX/mkeXYIhcFqcKgDSEznfqWYlY9WEEZH+gh?=
 =?us-ascii?Q?MFCn3g45wo3SUB7APlAc616bQQnGLAaNxuEwods/jSXoEe4PwYH+y1wYNebR?=
 =?us-ascii?Q?eP0wHkp1O9m2efxAbLpdv059rPxfA3cuQMJZyIqouTLjQuHEE4RJGyR8Yb6n?=
 =?us-ascii?Q?XBespBZ1d9l0WjUCqqwdCneafQ4PJf3tOXda51iz0zSZ2ooEm+MuGX9AWumr?=
 =?us-ascii?Q?BD0n2y+YmY6Z6I93XwvXPUoocbBsdWkQLl5BrWJvy0ylo+wyq1WdmZQna+qp?=
 =?us-ascii?Q?8Zu0rw1cXS/i6OZNqlzFCQ1TFmU1YbsEG8xMTrZmDgkCsZwupDFq9KViK57l?=
 =?us-ascii?Q?nEP1/ezctfbZqLtseEgMyprDE5r0RXPGOCbgqo42/3KsuQGuBDmqQ4JrOMx3?=
 =?us-ascii?Q?g7zgFeDrCz3cgM7rq8h4iE1bHwKfVTTa3mNjLF5tlPXQHvt9m50rXYLu/C8G?=
 =?us-ascii?Q?TEonMMEXp0jYitvdL2w8NE7/k6KZ74GpF7kCYFy5TkPyMfsjq+MOEao/to3b?=
 =?us-ascii?Q?u2loz+QjH5kGUZDCi501tkhL7yCd6/lEJChRwyzZeVADZDMcAzLz/oF1emPp?=
 =?us-ascii?Q?daB3TVon+DPqtgLF6o4r3vK1l6D/ctO+?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6514.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lS2a/oIs8cGQeolsB6cO/UP0/6cdmRuhaV9CYoTzE275B3nk0040e5iR3DTn?=
 =?us-ascii?Q?FHJEUFJ4+nOFKI8IrSUoo+pKGL4MYDUiAagPY1q393GgJGE2c5H0BwiP8zwc?=
 =?us-ascii?Q?8CW7oBbEeSsdJ4skAlPAPqbNH9VuJ0x+JX14f/gRvvMk/SobTLHXuq1p4xva?=
 =?us-ascii?Q?PEfB4vuKaiWIHI6udWqRr14reBAXMlXv9Ettz+fiUZx/5fAU0mqhbKGKsvrS?=
 =?us-ascii?Q?+Rn9Jjvgv/I8XpVQiCCYpLo/8FyWJeBnImZEahqeGF0Dk+cTW8uXPqu3EC85?=
 =?us-ascii?Q?79JcPM6bQ4I+vVP5ka1y2Qvt26KXHyNYbNy9F65OnepaxI0R8E9bBjrkkOsO?=
 =?us-ascii?Q?/nqnNi46+xMh5OwqqlL/86oLEjfZr/6m/+25sG9WrsIRrWcLPhcxpotNQp+v?=
 =?us-ascii?Q?TrQgIe90tfxMz3bZDEW2FstXj13xygyX+9lVOCQR63liBxWc8v8/MRkOQmJS?=
 =?us-ascii?Q?ALb5JnVBiTJlciWeZq+Frve9SU3rVNX3aCoXOVd2qd0SmqgGlPuNw3ZwJ8rU?=
 =?us-ascii?Q?jwinP3qAOkQh+9ix2pUS1VgZOrOWarSoxy5cpi5bVoH5rA4rpDKSjEsNKcCd?=
 =?us-ascii?Q?ruD/FDu82F1o/LjN1ss+JVWvj5ZgrBMYMZTGsv4xdDzorkoIJQm0ay0FW+lI?=
 =?us-ascii?Q?4ZP6EdTU/gO2nhbHnR8A9BSXICqqRRCuw/16FBRk2G3qgxVkr3a720ysaxYH?=
 =?us-ascii?Q?7DE6XlJIBDa1iu7ahJpTeYjcPpNU0uJa2xWBYvs0KE3iPSNY1iMboE6Vh4lZ?=
 =?us-ascii?Q?9/ieHxVMfoLkK0jBy4zThKv5lsBhcjSDoI+riNAVsKEBAIpjCzd/aT/pwJIw?=
 =?us-ascii?Q?0ZX7ohOGREVKBWytBU2ygSDThFuzNb+JXFL4mEE6KPDoG+dU6Xb+qG7gmhTL?=
 =?us-ascii?Q?EBmLnwe8soTFX0X1St/BqKSsNfiz0PyZzFRsprcWiAGK+wvBPcKCugCqAbwJ?=
 =?us-ascii?Q?cqOYDfugIze61H3zcqlAEYU4c2uuWctIpxs6c8QShMW3VOGwHWtti6kJijUI?=
 =?us-ascii?Q?O1HGL1vcDQVhrU7c/ooH/0kaz5cbvjNpFFjQI6RFJgwR1ry8+OkBNpxdcSc9?=
 =?us-ascii?Q?03zHbuxI075wpyDB5KRzVw9Y9iR2XVCB+lZr78OH+5bneMYqCLnntoV/H/Xa?=
 =?us-ascii?Q?Igd4tK84mhqnVI/X0x/R7TymR52OkHFVKMFry//O8GTrpIHrc6wvYJqTs8bs?=
 =?us-ascii?Q?f9KaEF0tcehB0VvAAnQwgAGcPYq0GNFATcD/XvfMMCvKGQHnxeScFVCfQOA7?=
 =?us-ascii?Q?7+MAwDAZz3Fdgiset8PJv6767tADX+spFI3a15wXUOOfcyIKnmIyb1HxzhhQ?=
 =?us-ascii?Q?YomJnRG7Z/ri49AUGLDc93G8jN1+M+flGR+gXZX2zoCNQ2YC5JDOdUaJP3E9?=
 =?us-ascii?Q?hnUumuVg9bU7kERiWi6W1bbyiNt6xzAghfPE7918ZNjtaz66b7fjrL2SmGsT?=
 =?us-ascii?Q?QEmyX5RWIiCA4U8lcxRmVSdHuMoJBGrDrJ6LRgQoHi9mBWnorokLkkqgZcKh?=
 =?us-ascii?Q?QIRo20rUBM08LECVg9k9AwGUuWFtQJjMXcTFnS8rtvnhPlgV47W9qol0R9ZG?=
 =?us-ascii?Q?IJ8wC0iorIWcjgMGfEnxLOKPJ44lnYNrrr060q8XeAOg2+XfPSryBuC44qzM?=
 =?us-ascii?Q?Jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6514.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d653f1ef-7294-45f1-f402-08dd65fe773c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 09:22:55.2739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F4eT9n1WBtOQp9Xp/WZC5zV5ujaUwLR1E9s2/GOg+/N0TOOD4N08bJ8UwxzOUmbSK8EdaHQV3AXtgq2FCyGKYOk70uK6qMrAE908tI0atGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7738
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Sent: Wednesday, March 12, 2025 3:41 AM
> To: Vyavahare, Tushar <tushar.vyavahare@intel.com>
> Cc: bpf@vger.kernel.org; netdev@vger.kernel.org; bjorn@kernel.org; Karlss=
on,
> Magnus <magnus.karlsson@intel.com>; jonathan.lemon@gmail.com;
> davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com;
> ast@kernel.org; daniel@iogearbox.net; Sarkar, Tirthendu
> <tirthendu.sarkar@intel.com>
> Subject: Re: [PATCH bpf-next v3 2/2] selftests/xsk: Add tail adjustment t=
ests
> and support check
>=20
> On Wed, Mar 05, 2025 at 02:18:13PM +0000, Tushar Vyavahare wrote:
> > Introduce tail adjustment functionality in xskxceiver using
> > bpf_xdp_adjust_tail(). Add `xsk_xdp_adjust_tail` to modify packet
> > sizes and drop unmodified packets. Implement
> > `is_adjust_tail_supported` to check helper availability. Develop
> > packet resizing tests, including shrinking and growing scenarios, with
> > functions for both single-buffer and multi-buffer cases. Update the
> > test framework to handle various scenarios and adjust MTU settings.
> > These changes enhance the testing of packet tail adjustments, improving
> AF_XDP framework reliability.
> >
> > Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> > ---
> >  .../selftests/bpf/progs/xsk_xdp_progs.c       |  49 ++++++++
> >  tools/testing/selftests/bpf/xsk_xdp_common.h  |   1 +
> >  tools/testing/selftests/bpf/xskxceiver.c      | 107 +++++++++++++++++-
> >  tools/testing/selftests/bpf/xskxceiver.h      |   2 +
> >  4 files changed, 157 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> > b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> > index ccde6a4c6319..34c832a5a98c 100644
> > --- a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> > +++ b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> > @@ -4,6 +4,8 @@
> >  #include <linux/bpf.h>
> >  #include <bpf/bpf_helpers.h>
> >  #include <linux/if_ether.h>
> > +#include <linux/ip.h>
> > +#include <linux/errno.h>
> >  #include "xsk_xdp_common.h"
> >
> >  struct {
> > @@ -14,6 +16,7 @@ struct {
> >  } xsk SEC(".maps");
> >
> >  static unsigned int idx;
> > +int adjust_value =3D 0;
> >  int count =3D 0;
> >
> >  SEC("xdp.frags") int xsk_def_prog(struct xdp_md *xdp) @@ -70,4 +73,50
> > @@ SEC("xdp") int xsk_xdp_shared_umem(struct xdp_md *xdp)
> >  	return bpf_redirect_map(&xsk, idx, XDP_DROP);  }
> >
> > +SEC("xdp.frags") int xsk_xdp_adjust_tail(struct xdp_md *xdp) {
> > +	__u32 buff_len, curr_buff_len;
> > +	int ret;
> > +
> > +	buff_len =3D bpf_xdp_get_buff_len(xdp);
> > +	if (buff_len =3D=3D 0)
> > +		return XDP_DROP;
> > +
> > +	ret =3D bpf_xdp_adjust_tail(xdp, adjust_value);
> > +	if (ret < 0) {
> > +		/* Handle unsupported cases */
> > +		if (ret =3D=3D -EOPNOTSUPP) {
> > +			/* Set adjust_value to -EOPNOTSUPP to indicate to
> userspace that this case
> > +			 * is unsupported
> > +			 */
> > +			adjust_value =3D -EOPNOTSUPP;
> > +			return bpf_redirect_map(&xsk, 0, XDP_DROP);
>=20
> so in this case you will proceed with running whole traffic? IMHO test sh=
ould
> be stopped for very first notsupp case, but not sure if it's worth the ha=
ssle.
>=20

When the expected packet length does not match, the test will fail on the
very first packet in receive_pkts(). After this initial failure, check if
the adjust_tail function is supported, but only for cases where the test
involves adjust_tail and fails.

> > +		}
> > +
> > +		return XDP_DROP;
> > +	}
> > +
> > +	curr_buff_len =3D bpf_xdp_get_buff_len(xdp);
> > +	if (curr_buff_len !=3D buff_len + adjust_value)
> > +		return XDP_DROP;
> > +
> > +	if (curr_buff_len > buff_len) {
> > +		__u32 *pkt_data =3D (void *)(long)xdp->data;
> > +		__u32 len, words_to_end, seq_num;
> > +
> > +		len =3D curr_buff_len - PKT_HDR_ALIGN;
> > +		words_to_end =3D len / sizeof(*pkt_data) - 1;
> > +		seq_num =3D words_to_end;
> > +
> > +		/* Convert sequence number to network byte order. Store this
> in the last 4 bytes of
> > +		 * the packet. Use 'adjust_value' to determine the position at
> the end of the
> > +		 * packet for storing the sequence number.
> > +		 */
> > +		seq_num =3D __constant_htonl(words_to_end);
> > +		bpf_xdp_store_bytes(xdp, curr_buff_len - adjust_value,
> &seq_num,
> > +sizeof(seq_num));
>=20
> what is the purpose of that? test suite expects seq_num to be at the end =
of
> the packet so you have to double it here?
>=20

The test suite expects the seq_num to be at the end of the packet, so it
needs to be doubled to ensure it is placed correctly in the final packet
structure.

> > +	}
> > +
> > +	return bpf_redirect_map(&xsk, 0, XDP_DROP); }
> > +
> >  char _license[] SEC("license") =3D "GPL"; diff --git
> > a/tools/testing/selftests/bpf/xsk_xdp_common.h
> > b/tools/testing/selftests/bpf/xsk_xdp_common.h
> > index 5a6f36f07383..45810ff552da 100644
> > --- a/tools/testing/selftests/bpf/xsk_xdp_common.h
> > +++ b/tools/testing/selftests/bpf/xsk_xdp_common.h
> > @@ -4,6 +4,7 @@
> >  #define XSK_XDP_COMMON_H_
> >
> >  #define MAX_SOCKETS 2
> > +#define PKT_HDR_ALIGN (sizeof(struct ethhdr) + 2) /* Just to align
> > +the data in the packet */
> >
> >  struct xdp_info {
> >  	__u64 count;
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.c
> > b/tools/testing/selftests/bpf/xskxceiver.c
> > index d60ee6a31c09..bcc265fc784c 100644
> > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > @@ -524,6 +524,8 @@ static void __test_spec_init(struct test_spec *test=
,
> struct ifobject *ifobj_tx,
> >  	test->nb_sockets =3D 1;
> >  	test->fail =3D false;
> >  	test->set_ring =3D false;
> > +	test->adjust_tail =3D false;
> > +	test->adjust_tail_support =3D false;
> >  	test->mtu =3D MAX_ETH_PKT_SIZE;
> >  	test->xdp_prog_rx =3D ifobj_rx->xdp_progs->progs.xsk_def_prog;
> >  	test->xskmap_rx =3D ifobj_rx->xdp_progs->maps.xsk; @@ -992,6 +994,31
> > @@ static bool is_metadata_correct(struct pkt *pkt, void *buffer, u64 a=
ddr)
> >  	return true;
> >  }
> >
> > +static bool is_adjust_tail_supported(struct xsk_xdp_progs *skel_rx) {
> > +	struct bpf_map *data_map;
> > +	int adjust_value =3D 0;
> > +	int key =3D 0;
> > +	int ret;
> > +
> > +	data_map =3D bpf_object__find_map_by_name(skel_rx->obj,
> "xsk_xdp_.bss");
> > +	if (!data_map || !bpf_map__is_internal(data_map)) {
> > +		ksft_print_msg("Error: could not find bss section of XDP
> program\n");
> > +		exit_with_error(errno);
> > +	}
> > +
> > +	ret =3D bpf_map_lookup_elem(bpf_map__fd(data_map), &key,
> &adjust_value);
> > +	if (ret) {
> > +		ksft_print_msg("Error: bpf_map_lookup_elem failed with error
> %d\n", ret);
> > +		return false;
>=20
> exit_with_error(errno) to be consistent?
>=20

Will do.

> > +	}
> > +
> > +	/* Set the 'adjust_value' variable to -EOPNOTSUPP in the XDP program
> if the adjust_tail
> > +	 * helper is not supported. Skip the adjust_tail test case in this
> scenario.
> > +	 */
> > +	return adjust_value !=3D -EOPNOTSUPP;
> > +}
> > +
> >  static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 le=
n,
> u32 expected_pkt_nb,
> >  			  u32 bytes_processed)
> >  {
> > @@ -1768,8 +1795,13 @@ static void *worker_testapp_validate_rx(void
> > *arg)
> >
> >  	if (!err && ifobject->validation_func)
> >  		err =3D ifobject->validation_func(ifobject);
> > -	if (err)
> > -		report_failure(test);
> > +
> > +	if (err) {
> > +		if (test->adjust_tail && !is_adjust_tail_supported(ifobject-
> >xdp_progs))
> > +			test->adjust_tail_support =3D false;
>=20
> how about setting is_adjust_tail_supported() as validation_func? Would th=
at
> work? Special casing this check specially for tail manipulation tests see=
ms a bit
> odd.
>=20

Setting is_adjust_tail_supported() as the validation_func would not work
directly. This function is designed to check if the bpf_xdp_adjust_tail
helper is supported by the XDP program, rather than to validate test
results. It assesses the capability of the XDP program, not the outcome of
the tests.=20

> > +		else
> > +			report_failure(test);
> > +	}
> >
> >  	pthread_exit(NULL);
> >  }
> > @@ -2516,6 +2548,73 @@ static int testapp_hw_sw_max_ring_size(struct
> test_spec *test)
> >  	return testapp_validate_traffic(test);  }
> >
> > +static int testapp_xdp_adjust_tail(struct test_spec *test, int
> > +adjust_value) {
> > +	struct xsk_xdp_progs *skel_rx =3D test->ifobj_rx->xdp_progs;
> > +	struct xsk_xdp_progs *skel_tx =3D test->ifobj_tx->xdp_progs;
> > +
> > +	test_spec_set_xdp_prog(test, skel_rx->progs.xsk_xdp_adjust_tail,
> > +			       skel_tx->progs.xsk_xdp_adjust_tail,
> > +			       skel_rx->maps.xsk, skel_tx->maps.xsk);
> > +
> > +	skel_rx->bss->adjust_value =3D adjust_value;
> > +
> > +	return testapp_validate_traffic(test); }
> > +
> > +static int testapp_adjust_tail(struct test_spec *test, u32 value, u32
> > +pkt_len) {
> > +	u32 pkt_cnt =3D DEFAULT_BATCH_SIZE;
>=20
> you don't need this variable
>=20

will do.

> > +	int ret;
> > +
> > +	test->adjust_tail_support =3D true;
> > +	test->adjust_tail =3D true;
> > +	test->total_steps =3D 1;
> > +
> > +	pkt_stream_replace_ifobject(test->ifobj_tx, pkt_cnt, pkt_len);
> > +	pkt_stream_replace_ifobject(test->ifobj_rx, pkt_cnt, pkt_len +
> > +value);
> > +
> > +	ret =3D testapp_xdp_adjust_tail(test, value);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!test->adjust_tail_support) {
> > +		ksft_test_result_skip("%s %sResize pkt with
> bpf_xdp_adjust_tail() not supported\n",
> > +				      mode_string(test), busy_poll_string(test));
> > +	return TEST_SKIP;
>=20
> missing indent
>=20

will do.

> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int testapp_adjust_tail_common(struct test_spec *test, int
> adjust_value, u32 len,
> > +				      bool set_mtu)
> > +{
> > +	if (set_mtu)
> > +		test->mtu =3D MAX_ETH_JUMBO_SIZE;
>=20
> could you remove this and instead of bool_set_mtu just pass the value of
> mtu?
>=20

will do.

> static int testapp_adjust_tail(struct test_spec *test, u32 value, u32 pkt=
_len,
> u32 mtu) {
> 	(...)
> 	if (test->mtu !=3D mtu)
> 		test->mtu =3D mtu;
> 	(...)
> }
>=20
> static int testapp_adjust_tail_shrink(struct test_spec *test) {
> 	return testapp_adjust_tail(test, -4, MIN_PKT_SIZE,
> MAX_ETH_PKT_SIZE); }
>=20
> static int testapp_adjust_tail_shrink_mb(struct test_spec *test) {
> 	return testapp_adjust_tail(test, -4,
> XSK_RING_PROD__DEFAULT_NUM_DESCS * 3,
> 				   MAX_ETH_JUMBO_SIZE);
> }
>=20
> no need for _common func.
>=20

will do.

> > +	return testapp_adjust_tail(test, adjust_value, len); }
> > +
> > +static int testapp_adjust_tail_shrink(struct test_spec *test) {
> > +	return testapp_adjust_tail_common(test, -4, MIN_PKT_SIZE, false); }
> > +
> > +static int testapp_adjust_tail_shrink_mb(struct test_spec *test) {
> > +	return testapp_adjust_tail_common(test, -4,
> > +XSK_RING_PROD__DEFAULT_NUM_DESCS * 3, true);
>=20
> Am I reading this right that you are modifying the size by just 4 bytes?
> The bugs that drivers had were for cases when packets got modified by val=
ue
> bigger than frag size which caused for example underlying page being free=
d.
>=20
> If that is the case tests do nothing valuable from my perspective.
>=20

In the v4 patchset, I have updated the code to modify the packet size by
1024 bytes instead of just 4 bytes.
I will send v4.

> > +}
> > +
> > +static int testapp_adjust_tail_grow(struct test_spec *test) {
> > +	return testapp_adjust_tail_common(test, 4, MIN_PKT_SIZE, false); }
> > +
> > +static int testapp_adjust_tail_grow_mb(struct test_spec *test) {
> > +	return testapp_adjust_tail_common(test, 4,
> > +XSK_RING_PROD__DEFAULT_NUM_DESCS * 3, true); }
> > +
> >  static void run_pkt_test(struct test_spec *test)  {
> >  	int ret;
> > @@ -2622,6 +2721,10 @@ static const struct test_spec tests[] =3D {
> >  	{.name =3D "TOO_MANY_FRAGS", .test_func =3D testapp_too_many_frags},
> >  	{.name =3D "HW_SW_MIN_RING_SIZE", .test_func =3D
> testapp_hw_sw_min_ring_size},
> >  	{.name =3D "HW_SW_MAX_RING_SIZE", .test_func =3D
> > testapp_hw_sw_max_ring_size},
> > +	{.name =3D "XDP_ADJUST_TAIL_SHRINK", .test_func =3D
> testapp_adjust_tail_shrink},
> > +	{.name =3D "XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF", .test_func =3D
> testapp_adjust_tail_shrink_mb},
> > +	{.name =3D "XDP_ADJUST_TAIL_GROW", .test_func =3D
> testapp_adjust_tail_grow},
> > +	{.name =3D "XDP_ADJUST_TAIL_GROW_MULTI_BUFF", .test_func =3D
> > +testapp_adjust_tail_grow_mb},
> >  	};
> >
> >  static void print_tests(void)
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.h
> > b/tools/testing/selftests/bpf/xskxceiver.h
> > index e46e823f6a1a..67fc44b2813b 100644
> > --- a/tools/testing/selftests/bpf/xskxceiver.h
> > +++ b/tools/testing/selftests/bpf/xskxceiver.h
> > @@ -173,6 +173,8 @@ struct test_spec {
> >  	u16 nb_sockets;
> >  	bool fail;
> >  	bool set_ring;
> > +	bool adjust_tail;
> > +	bool adjust_tail_support;
> >  	enum test_mode mode;
> >  	char name[MAX_TEST_NAME_SIZE];
> >  };
> > --
> > 2.34.1
> >

