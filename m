Return-Path: <bpf+bounces-64067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08880B0E00C
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 17:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5073718901CB
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 15:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7A82EBDD9;
	Tue, 22 Jul 2025 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BeCtE6i1"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6460F2E1C7A;
	Tue, 22 Jul 2025 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196636; cv=fail; b=r0WvF7cXhsNgm0Q7u1eVoF/eOE48N2U84G2Z2wW5OEu2a9fUiX7XbORbc4OvsXRjwaqlexUQZ8Sq/V3jpe11svDX82cj1tfH+WzjAsi+alC5gUJKLZhZHVrs/oXhXYu/QJ2RrKHQq6aPlsaPRQFbJxdsjNt0qYDpuXjRIxjkf8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196636; c=relaxed/simple;
	bh=az5cAdHPxdpYoJM2Mi4TJ+CcRulL3/nNDP9VuIEFwgY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sTpcDMwvJn/ofCFCKKcuEVcN+WM/d4FHSc1nefmL2JHaEtX/ad+imMaVgRON3hccovI9wzQpnZFV+0rZYHnYHavMYpdzCN1xA3KrIQvi9CSMu50uTWNeVEs8eqqBz7J/olMS00jVFS0hi7HG+sDKwNh+w/aKiOtRSw+8Bb9wCTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BeCtE6i1; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753196634; x=1784732634;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=az5cAdHPxdpYoJM2Mi4TJ+CcRulL3/nNDP9VuIEFwgY=;
  b=BeCtE6i1i5iuRhMDa4r273v/8B8MpnMLxX8fAN0pkvg9EOMkSpRoRQje
   6DeIAgy+12RUQcMbjUsN0n3xpwnbJbuo0OYmeBmneHsweZlFRw4cYFQYw
   aKxSWkE/9BH9wGgKKcC4/CYxh53htEJXy/LJdaoDtCuXL2KMakki7TRMB
   roByqcJkiy93R5VwWHBDL8c0X2+hrNOB/s1T1fbKAmOtxopR2YBJiNx4Q
   suDBLAw1D55/N8YOkPLckr5HuXnhREyeX2AcNJg9GfvsbzBkmwSU/2e6T
   dxX3YprmbJmYSdnBmasf8htpckbjgofDiyxeQ4kOXRMUdkJCqaFFJpmAP
   A==;
X-CSE-ConnectionGUID: jDCDB6E4TGOwl4VDjhIZ3w==
X-CSE-MsgGUID: LNnwI2IBRcWrutWrTA2m6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55394485"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="55394485"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 08:03:53 -0700
X-CSE-ConnectionGUID: xlV+SKYUSeOBCPbjnNokMg==
X-CSE-MsgGUID: 0TmiRkK3SPWNwxnf9uJYwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="190127870"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 08:03:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 08:03:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 08:03:52 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.48)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 08:03:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjsLaVu3awszajCYHZg1zNNDtmEMvhZu0eJxrqAGiCEP7F9Gj9VYKrMRsoqN/sfY0vgAOHfTiFwUAa39yKa5i1SeH62zo2Xwl8Mv351p7mAs9H8a0zgUXyZt/IBOxklWOc8SHNLXwL+gzi/ptU94OXlouaoaWFSjTRHVNl7FDYj1IovdKy5H2Cxfd5d7bVtw9nUoauPm1NflGzD0SAsY4wzaF7LVM4SnemXWuVzuandU1tTVmtGuxjEXA0SZ13nXYs9P5BRVDLIk27GgK6cLIcMgG6yoewrWIRUpBWHOKDR9G2wXHh9KuZuMmD/38kA56BrKAxx3WrCw51CYoEBJLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6RjuMn6dGnbqfM8U6lGhjYQKJKS0HgI8Ie1CSthq/8=;
 b=NcdcdLnIZug7vsB5lqWSyP17ty/9CX7BjSUI2QGZi03ZsEnzRul8B3ej2SE0kgL0GXcWwijMThmnuixaRrosrjrdjmim7i9w3TSVD2XJSx1aNqhjZk1ZcC30lV/p7atW7jsU1pov+LD4LpSUc3lk1YStJ96fx7pSPrl+8J2GylMEK1R4ljv7KJXdsZ6McT78qLnyYe8le0i6FsoK2NVw2Rp+i9GY66MS0ekZgx6o4TCxVBdRT77GoUs7KrK4KR+Bj0MPyzAV+mYI5aeMq4g2VhL4EPIuTiEmOxUrzC9p4FVBPGCws9fVJvzy3iZGx4Wmm9Ty2WrGNdMxGSRhKf/cdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 (2603:10b6:518:1::d32) by LV3PR11MB8457.namprd11.prod.outlook.com
 (2603:10b6:408:1b7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 15:03:46 +0000
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::ac04:7439:8737:a3ff]) by PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::ac04:7439:8737:a3ff%5]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 15:03:45 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"bjorn@kernel.org" <bjorn@kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "hawk@kernel.org" <hawk@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>
CC: "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: RE: [Intel-wired-lan] [PATCH net v2 1/2] stmmac: xsk: fix underflow
 of budget in zerocopy mode
Thread-Topic: [Intel-wired-lan] [PATCH net v2 1/2] stmmac: xsk: fix underflow
 of budget in zerocopy mode
Thread-Index: AQHb+w/B/b2lrloclUybMHZhseq4EbQ+PXYQ
Date: Tue, 22 Jul 2025 15:03:45 +0000
Message-ID: <PH3PPF7A88A980A84F2194C6E1E941DDE80E55CA@PH3PPF7A88A980A.namprd11.prod.outlook.com>
References: <20250722135057.85386-1-kerneljasonxing@gmail.com>
 <20250722135057.85386-2-kerneljasonxing@gmail.com>
In-Reply-To: <20250722135057.85386-2-kerneljasonxing@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF7A88A980A:EE_|LV3PR11MB8457:EE_
x-ms-office365-filtering-correlation-id: fa88dcf1-6682-4007-3d5b-08ddc930f467
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007|38070700018|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?GF25Z15WzqdxDyPqH6FkkKOr5klKGvOFEIQiT6Rl/F1phzFzI46JzGcQfQhU?=
 =?us-ascii?Q?NB7PHeSgURSKphGWKzKhCoP/0SJDNGC490Y1b4hr6h3asY9iU+1R0I9ofmIZ?=
 =?us-ascii?Q?b2WYuE9nOu3srkPumqEpoijTM71P6d2+kjdadJ1ucNOslQjZTKMMFw3Og0/J?=
 =?us-ascii?Q?b1CrncEbx74HlWq+WaxDdDkITIktfVSjAPJJt5dNXt4uNJ3iL7vdDKmf237C?=
 =?us-ascii?Q?IcCOB6gCvOFZGL3/4iuVcQjYcNvRQqRYEsCNWJ3oKUlm1ycu/uIcfzNJBNNU?=
 =?us-ascii?Q?Yi/TbqlR9ZKy/ERqRHSZ8GXElOZwMOz/jgTFrsq6/cKqewWZjBCn4HQNAJ+I?=
 =?us-ascii?Q?qsc+f0hdJH518bHAyIdzWqw/GE07rHywiAmN3Hy1VI+cVoehDKPxGg0JSUAB?=
 =?us-ascii?Q?NCwkJj1E3mUoj8EDEvtBg1w4wDU+g8Hn520crhkFmfIpxxrGLL/CSxp8G96z?=
 =?us-ascii?Q?ntJrWVgdXBaSwbMvNodOmUq17PhIjlNwDzPjPVxpt6DqvF446pp40FKcdoY7?=
 =?us-ascii?Q?BfXmFytit4WC9zSx05GLUpK0XEWXaI0JwCea43Hh5Wa4x/JrzGvBMl2s+JD8?=
 =?us-ascii?Q?q0hLikiMAaxqLgxTi7Uq66tLOrn7ZhWghpWKIfD2bht2Ouq0V25umkyCMtyv?=
 =?us-ascii?Q?XeHYUOZa1oNikEJcjrxedXp/3bBjr0QpQJ0xTkYuXP4bzXlwYY2DatVHyIlu?=
 =?us-ascii?Q?+zA7t51YMsxGFvtI5JsrfRmNClE4QAPapMPAUFosWD/xaNCYgDS5gbsGw9gS?=
 =?us-ascii?Q?Od2iAGY29YZilFHCM8dCrU7EyZpsy7MdGU8ie6S0oJMWHWA2HyIfr+DkPdMh?=
 =?us-ascii?Q?+J7al/eD5P4Vv424C0CKBoJhW++kWQqhYyHRGWbgVnleu+dXd9vLxPKH1H/h?=
 =?us-ascii?Q?PTlH6CGVLr0khgp2Xf4h4GXP63mYRIWIv7dFv90HKo9KtPPGseZLdBNPYAC+?=
 =?us-ascii?Q?G1Jy+VtIeulBkbNVXmNgIDdgNxM2akNRvECBTsjeNH+EN8p3DYczs61/64wN?=
 =?us-ascii?Q?Pm5Czzt527XrN39xmaiF5JXDJQ/Co767sJl+Op/BvLHhR/BZjr8+L1iFs8Nr?=
 =?us-ascii?Q?u6W2oozeVNK8dKvWi8RMUtaqdukQ2yGC+1ySIPp734MpO276OL2e5qC45QhY?=
 =?us-ascii?Q?+nVhYSNl8sH3Ffkh9RExPEh67iScjqeHc/vyYoqvCZDy6ro/L0hD+MrqFQB5?=
 =?us-ascii?Q?xgxmUM6PZLSFFa1Ap7pZOTIFDmUlhn7IrLOU6Rl8K+HipvTCOS0uMoq/FQn5?=
 =?us-ascii?Q?v7F+aX3uGTl4ki5XbAawHEE404IR+SAFtaDRCp060yhw3St7XG0fiJM9oeNv?=
 =?us-ascii?Q?hsFTY8FG3UtXwd7PYJ2bmjP1HeyGpNd2goXtI7jhX1wvsgPcyDp40pcSnjEM?=
 =?us-ascii?Q?HyhtU5PjcIaFC9Ztvzz2JH2fR8Kw/Iy3CxG1ea5fi+2cHeSXbpoqYU/9PEsw?=
 =?us-ascii?Q?235LOlvAZ5uh08TFATKdt1FLJ2xPkk6FgGaYYr+Da3uVjHwuVZ52pW51qmqM?=
 =?us-ascii?Q?rPkUZsfLLVMig4kmZDedIulZ/YsU8MWudSX5?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF7A88A980A.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X887Mm1k9gLtbkH5O5/i3PAnIyKXccGwwtNw2C4ukxatIW1k2vqnfnQfxKZU?=
 =?us-ascii?Q?ekUjMDwkyRaM4hBQUSRcbp4nq6Ta3MSqAeD1mF9Fysc7Co/FmHZXzUE3Zlrt?=
 =?us-ascii?Q?/qDyxMoRg6ubBnYsH5YiBYuBMzSS0o2niXTKv9NxOIqSJxFfjnPrsKXqwepy?=
 =?us-ascii?Q?3mnRuG2wqhnss17oMLtjpk8Bz9zD/kQ7SmRi0D6TgTxmq/10aFr/zh40L6KA?=
 =?us-ascii?Q?Akqk/yQdFN8Hh4iTx9CAKzXITvD0Nylj1dmLWBdFIdYGaOW6jwk/G/BNrARC?=
 =?us-ascii?Q?xI1qND62+F5QGZb6xJ4luZu54e/vpLoWTv7V+ivY7YsSIKrulcENvrsmjcCn?=
 =?us-ascii?Q?arR961ghRBdpUvEE+AGW0nHNeIJgxGQYIVKRHGerdA6UiWBD41aivpcxZADV?=
 =?us-ascii?Q?f3lG2qNDba86ZX1qm+K8uq9k62Vw0DkAFvARF4xC+q2IzXpa93KTIFokB63F?=
 =?us-ascii?Q?iycIfWViBA1iXLLHEyz2Tq12Z0KhVOxMGp2whG39vA/f31a7AfPm8v13kzBa?=
 =?us-ascii?Q?ftwRNE/8f3z3Yltv16FClgX9Ruw19aPYLxHrRFwmJwWR04KVfl4L9Yw4PFc1?=
 =?us-ascii?Q?DnTCqUtfUx9KWDsaYlRyUdJUEfOwlaskg2FX/GzvjvdyukyU1Kv6U14o8b1H?=
 =?us-ascii?Q?NpTz/Ve2XdyPJPe1WZlOVhv22V8tAv5BKPimuXEIaYtXiK9ywOypWYrERU/v?=
 =?us-ascii?Q?E/tbwP/2G6/Wk/C3BHBw0QqLGlP/UwSBnlt2Mr9P8z0Bc7e/V+R2VfNkNvVt?=
 =?us-ascii?Q?mwQVWQKvwgy1mPRHAz9qR06sStZCeLV7KeVTY97YxoZRNB7aGJjlQjdN0vj+?=
 =?us-ascii?Q?dnMeMYaVW7rViqoDlLen2wpzmaHnhLQkmGWtA1IghFJnjMMNG8ykQiZn4GmF?=
 =?us-ascii?Q?Kyfyq2L1h+A+8YlnUBGKDdKD3TE6z7ZNcqQcXcMzKjX4k7uvqq+nvdBegTyy?=
 =?us-ascii?Q?UpBxJk7ssEFDpqxYLM7Cg3DSZgAhzuGXmFyiBb5oCuMz7HjR+Go7pr+bQGAl?=
 =?us-ascii?Q?ow/weecu+oRTtC24fgRKxCXXkHCjMhQCTPx6xe0WbOxjf0b9yccWm2jD7u2e?=
 =?us-ascii?Q?oyedR7ThYYCSW++z295mBR39ujqd8fKEIZysnOvupfzZcCXL9qnpU3vk5tgS?=
 =?us-ascii?Q?TNWQZuxyP9joqt5kwdoFF7xiV9DhxgfKtDN5I+acJBZd8cb2U3umm8MMKIP7?=
 =?us-ascii?Q?h0HInCwCvVX5TNHKW0MoTNR1fTH+w1JJ4LX23apZXtaLpoPFzoI6rQFCCLzz?=
 =?us-ascii?Q?S36Q7oRGGnyB3HeXPyPpMwnS4AOj0AD6aPtVnmJiuALFgVrc+hXGp9xe5byt?=
 =?us-ascii?Q?UF1Zcl5PQ0TP0now2ntd0xdZzu5RB34PVA+owMipqDPRHo/T23cWJWzBOAhv?=
 =?us-ascii?Q?KKrJNdKNR+Gz+FW1KdZ+3XlcQrUtvD3JkllgWsSz8WJAqPS1f1kfnU7pM9ce?=
 =?us-ascii?Q?ngSwJmxGUsy0ship2RzgZIUBzVzBffpbgG7OUwowCzWJoxrQwQN5xAdZyRM3?=
 =?us-ascii?Q?84ay+n2+BfLN2y2lxMLfJwgXt2oyZXPwa4sEKPrEcfRRlRnALdGorYR+wAcl?=
 =?us-ascii?Q?ax4fe3SVyuT+0xQPTbz3VlPweEss4FR0kbeLW5J90wO8XL/t2YtFLUk4w+11?=
 =?us-ascii?Q?Xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF7A88A980A.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa88dcf1-6682-4007-3d5b-08ddc930f467
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 15:03:45.2208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adGtGAMtkapKLycNSUZSVNkOCNSjjS7AKGLDKrF2c+Iibv/On7ifKrG4LwkuljJlM6x1+ePzi1ejrmD86bWVTlLu9N5J2lIrx7xgmxJ9/gY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8457
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Jason Xing
> Sent: Tuesday, July 22, 2025 3:51 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; bjorn@kernel.org; Karlsson, Magnus
> <magnus.karlsson@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; jonathan.lemon@gmail.com;
> sdf@fomichev.me; ast@kernel.org; daniel@iogearbox.net;
> hawk@kernel.org; john.fastabend@gmail.com; mcoquelin.stm32@gmail.com;
> alexandre.torgue@foss.st.com
> Cc: linux-stm32@st-md-mailman.stormreply.com; bpf@vger.kernel.org;
> intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Jason Xing
> <kernelxing@tencent.com>
> Subject: [Intel-wired-lan] [PATCH net v2 1/2] stmmac: xsk: fix
> underflow of budget in zerocopy mode
>=20
> From: Jason Xing <kernelxing@tencent.com>
>=20
> An underflow can happen when the budget number of descs are consumed.
> as long as the budget is decreased to zero, it will again go into
> while (budget-- > 0) statement and get decreased by one, so the
> underflow issue can happen. It will lead to returning true whereas the
> expected value should be false.
>=20
> In this case where all the budget is used up, it means zc function
> should return false to let the poll run again because normally we
> might have more data to process. Without this patch, zc function would
> return true instead.
>=20
> Fixes: 132c32ee5bc0 ("net: stmmac: Add TX via XDP zero-copy socket")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v2
> Link: https://lore.kernel.org/all/20250721083343.16482-1-
> kerneljasonxing@gmail.com/
> 1. target net tree instead of net-next
> 2. revise commit message
> 3. use for loop to replace while loop
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index f350a6662880..c4cd4526ba05 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2596,7 +2596,7 @@ static bool stmmac_xdp_xmit_zc(struct
> stmmac_priv *priv, u32 queue, u32 budget)
>=20
>  	budget =3D min(budget, stmmac_tx_avail(priv, queue));
>=20
> -	while (budget-- > 0) {
> +	for (; budget > 0; budget--)
>  		struct stmmac_metadata_request meta_req;
>  		struct xsk_tx_metadata *meta =3D NULL;
>  		dma_addr_t dma_addr;
> --
> 2.41.3


