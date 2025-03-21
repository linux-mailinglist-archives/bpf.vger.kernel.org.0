Return-Path: <bpf+bounces-54515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DD9A6B29B
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 02:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88351897A0B
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 01:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FF518B46E;
	Fri, 21 Mar 2025 01:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CXFw2d9F"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F154E169397;
	Fri, 21 Mar 2025 01:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742519942; cv=fail; b=nVWO8Ktlyngjk1P1NoktaTG+K0ATJcOy3anG6WpSiQVWRjo8nhRE5lJqL27nnLQt6uTUuZ+fZc2buBpNgfIRryKOJnVM67tzYLrsBZjS7LIXe3SV9F20wKmomoFNyeD3/VGYp6dvBxYupFX5kCXtPA3+TFrj1SPGPD7cXRqRyfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742519942; c=relaxed/simple;
	bh=nWuWf2BwIjGTOmb8tcaR6mFhvorqbZY6QeOOSVpyOQs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GWUw4CXkuEvQzl3f2FSTzvwRzOqfkBbMBD6g+2ahXqqMYtEAlS+ssz5IgbvaaCObonYnkt+niMJvEYlr8y79JsZ6dvkfIHDi69FRwaKrvZ0K01eRK5QmfeFia+7lgftFya/+jOGyhbvH2Toi9BByYIpIywn9cmSlUd6cthDzU08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CXFw2d9F; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742519939; x=1774055939;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nWuWf2BwIjGTOmb8tcaR6mFhvorqbZY6QeOOSVpyOQs=;
  b=CXFw2d9F9O3OizxYFbtXhdlbdzKHM3GkoB3qBJlQzpbQ0a4psIRo55Mf
   RZwzC7SgXpDLofnCNtUOMdsKg6fw76o+8a7P9MgEbjhhiE5CO8yPjG5G6
   WhsQ/iPvKhpKcnIbxKh2lfUnyd1Zf8T4SptqpPterq4luv2hALG5M9VMR
   hDN+FbuCNUkB5G/5ZAoa0FJ9LaYs0XJyvNXBZ/c5o7OvVka92grbh7JCQ
   R5DGb9R9CCbs/2ZntaUuCfuAZpy19IQ2Kom9TsV/4IC1sJnrdFiaPJvtM
   GBc9DRGon/Jm0kbocjx0ZBUzzZ244VFlsEG6GSAJZxNsJjIx0jMsuexUP
   g==;
X-CSE-ConnectionGUID: DSdPMqZsTlGCvf/0IZBuiA==
X-CSE-MsgGUID: RhFAytVrRueu0kYUaiB9og==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43657969"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43657969"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 18:18:58 -0700
X-CSE-ConnectionGUID: CgEWlQWSRR2MSYiAijmkPw==
X-CSE-MsgGUID: Lc9WJevZSfeTpjJFDPMRsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="146487504"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2025 18:18:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Mar 2025 18:18:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 18:18:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 18:18:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oh28hBxwO/EzuyCLLJmiHGmCTrCevkl/BLdQ1iKdPDOb5Odg7I7Yb36+fSIEQ6g4mVWNQ6CbB5MG1EsqloIxbnnDndwp1MoUdQHcjS1Jviof5mvyDrqJtZpjcMD9PhYbhywCQnNt45Bw1+K8YMMYgcryqeVfKfe5SapCzces7wVMsqz2dsholBMtvsaqOUUAkzFeKwqQqPP+a3XK192YmVVoFfWQFASVBY/2C0S1l/nk2+FC+iFgxNhSnXRnXDzkAhr9KiE/hUylU8JHtvWzaaXWEMZwzIBCb7xm9cfLTen20muyD8SDCl51vBorolEEsAO0F2jnBrtNmLhkduIlOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Epnr0k97Klj6WCmE6DfK2XNWk1oAFohUzVE5RSGMyGo=;
 b=l8g2hzlviZhfhLGJzIjLZqxDDnI14KBrEc98MkNQg2TMCFJc0yz100/VzYrWaPYoTNySrrYbbFUpyhNNkUTG6AsKaIvqSPDeOflGrAWMytz4RYLSOWC1cJ7ePFsDTL1GF/0UhGwAg2o4twtGqIoh6e/Zlr7v3SdSck+w2abRAXer3K8sjL5fu2x/zZtd99UW6ZFl4HvhDr5oC1fA2WL5R+BTNgm2UcZU6VCYr8P4X8BEu8LT7HU5ftU/94hWx3UQiJx3HcUD7VHcRKRNIwNOfhmUO+fCk9zLVrrCe+O4H2SmFo8rv1+h/znkHz/fSCvMNMn81OT4fQ6Y70yebevVnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6514.namprd11.prod.outlook.com (2603:10b6:208:3a2::16)
 by IA1PR11MB7199.namprd11.prod.outlook.com (2603:10b6:208:418::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 01:18:21 +0000
Received: from IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::c633:7053:e247:2bef]) by IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::c633:7053:e247:2bef%4]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 01:18:21 +0000
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
Thread-Index: AQHbjd1v/YORudaNxUqqCfJ6VIiP07NuiUOAgAooXWCAAF7zgIAD0dTA
Date: Fri, 21 Mar 2025 01:18:21 +0000
Message-ID: <IA1PR11MB65145E703957897F13B65A648FDB2@IA1PR11MB6514.namprd11.prod.outlook.com>
References: <20250305141813.286906-1-tushar.vyavahare@intel.com>
 <20250305141813.286906-3-tushar.vyavahare@intel.com> <Z9C0/2uFFQPGozkr@boxer>
 <IA1PR11MB6514B98679051D03FDDED9C78FDE2@IA1PR11MB6514.namprd11.prod.outlook.com>
 <Z9mJ/QSbTfa0IW4Z@boxer>
In-Reply-To: <Z9mJ/QSbTfa0IW4Z@boxer>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6514:EE_|IA1PR11MB7199:EE_
x-ms-office365-filtering-correlation-id: c7913e8a-8399-4f97-7cd8-08dd681644eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?tCb/jXdi1NcuZxTdqgd7sYwATJ5KsfP/98jGlmJVoK5ZzkQsNC6ntY9Vtu/+?=
 =?us-ascii?Q?vED9pK1vq5i6fch5muSR5k0hr8RleLL3ra3t+Shm/0k0GRyMbxkMmui2wozv?=
 =?us-ascii?Q?l70CkOxZl6dqJWCU90jG6zPNGcBesAAOjnsnbCl5F3VV9vdR+S/PtRpbC3Tj?=
 =?us-ascii?Q?SmjJToqOYETBDZ8fwR/MARyyB1C227qDsBeuIowfRqP+e86HQI15zhvSsXfs?=
 =?us-ascii?Q?kEFkwHMVNku3pzQzUwBGUbbR9Z8TkB17CwaotoiuvWCRJ204DxsmFTWsUxqP?=
 =?us-ascii?Q?6LsQYlT7Sbh58jgLsmj+ZyHFS7NQQDYVWiQZ/M2MPP2mCH9MUXOxFCGZcMAi?=
 =?us-ascii?Q?giPUyMDNaIOKmycS774hOJtmGobE7r8VIcOZa1c9TC/n8myQbGDuoJRaN8dI?=
 =?us-ascii?Q?ZK8luMMNUcmLNilRZ1oJtno+Y6FPztCLoGcmTI4RLvtsPU4Q7WUl9rRJawh5?=
 =?us-ascii?Q?jr2TLyHePYa+KbNytj+Xu15uWAVM93y6rzXH+fOFdQMJqog+rPcGe92msnti?=
 =?us-ascii?Q?JMqjL2ASSBApMde7BmpAFXyLlBCBsvJ6I004yAs08WTEAbzLYV9zmzKMjRIW?=
 =?us-ascii?Q?n08dU0YOgZEemG9SWo9EXwEYxx/YCX3lryStWZ7kMT1d4L4lWeV0c5CneTb4?=
 =?us-ascii?Q?Dl1zYm9PXmjnEUKBfibVlzjw8viW+qeSC6z7km7cQTwGKPz+65pzlNCwoBde?=
 =?us-ascii?Q?r93y/ibaD3Pe4m/hYYxbgJe5BTDOnL4EJNnh19WeUS3fM/dK2MeOXLE5irSt?=
 =?us-ascii?Q?EQBNthS04ZbUd0J7fXlyxJimG+ASLlKzmFjSI4Ny2f0V4Yq9JKuS36qbMwGv?=
 =?us-ascii?Q?XqA5GfPY+SckqCbsg7N1BV7mONoZ9lf2xMrqxzHAkTcJiFD5zcPtgRlNM2JI?=
 =?us-ascii?Q?pTVGxXjEwlEz8dP5xcl8zyLqW7oHMK7XdXNiE7x1vvVy2lgHikJ3VNN15h7a?=
 =?us-ascii?Q?OSU22jhYZVZj+QPyLmKmPwPj5qbOm+yMBRveQDWkka+2KMHz9vm9GAgPEisR?=
 =?us-ascii?Q?hD04KK8AROAf771d19/M6bPJWYnZZk42t3vG/p72VHCnBz2i7CtO8Wm3OQYQ?=
 =?us-ascii?Q?tMWSgVIf63wspTX27snRZILHgIt/s9JrX4vL9Ud8T98kNSDBYYU17zqWCcxI?=
 =?us-ascii?Q?NOUTQiEQVIU9KCEYgWJ9zI2EtlVMgCFgrzS9tuS6Jc/SCWFKrm2Nxx0tH7qy?=
 =?us-ascii?Q?2YQl00zZkOkHiZkTtouDU6QK1mXDXQCK5qPKIrZB5ovkelIN56Qkulj8DncB?=
 =?us-ascii?Q?tev5VeoSnyQogasHx92WHf13TKwuKhd9Hizdc2oLWK+z1Ndy/8abuSeTCFHw?=
 =?us-ascii?Q?x3z+EsHaMCJXIISxoqQe8paSaEMLAQc4LmF8cfB0NryAYCME8jMVEJm00cEj?=
 =?us-ascii?Q?eWEBfnOoKsSMp4d2dGyqzrgPJ9u6qWN6fo7cb6yENwPmb8dC+5zlI/SK++3d?=
 =?us-ascii?Q?nnOa6RXKeW3jKYYYsknKFsqeZ7dhh9iY?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6514.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cpmluaHvuhCxD46UjJyhLIOY4qtH+CW5cvGfLDhS6w2CgRXculK52hTvbA22?=
 =?us-ascii?Q?Pfnk7dfNWsLbkwdyQlKdu+5tpXp8+ebOGq7VcEj0b/TYpy9byNLJVo7YrOeA?=
 =?us-ascii?Q?uOi9/OyvuTuxIHg2jedPtbUt0y6z383tVYDIZunlzMaRhHtSNRos8Q+fJUT6?=
 =?us-ascii?Q?7FBHo+9RPruvAnxZSCBI75djvPgbx7ZG1K6SmKFw7anDA8iLKWZADdKv9oaG?=
 =?us-ascii?Q?t/LWojpZFR2ZJ/FOb9O5tpKTVs7U4vIwHnl6gb4Rxhsp7c6XysOXDM/b06rk?=
 =?us-ascii?Q?vMXSOHi1uEWkZKck/gfDSDRgnNN4e+t1M5Zv38rE5cMNzo1roo2sT73lHY6i?=
 =?us-ascii?Q?cLvc6ac7kKmRDDKvrQ3mRxzjOyhmiao46eiDskSd/L6soqkU1PK/+ZpERK8+?=
 =?us-ascii?Q?CFQSx9WbPJvbtvUNO/Yda0/dpTNjg+W6Kk/Y4Bu31KYCUw+5/xwAXB5ao6Y8?=
 =?us-ascii?Q?Ps8gUYIKHujKejeGLwgrwpH7XgBRq1b2y71biPf3UsnlzKkXujADjz0wzjFz?=
 =?us-ascii?Q?L25qfCxLpT2j/k8SAvPMp/QZhrE2O77HXfXBCClobTRz1t5aa4ei0htzxmkm?=
 =?us-ascii?Q?aUV3gJ9Id4EnNNc1xfwczQLXHO4tbos03O8g88mmH1wrnr/Ekdav72vL45kr?=
 =?us-ascii?Q?vdrKyPcKdCTGUVnpinzN2zWA6oou2aO+4emVTOFrvxx5q6y6d09BgVXu9IP7?=
 =?us-ascii?Q?mWgHivXXTGTQVw1Zumn7F/rlJZoXd6BjObcd+nmZNkK/9l7vydk9s0B3azuX?=
 =?us-ascii?Q?byIhEJNMpiz2sPaaDIRe+S3VF8cGvUSlnoyBSwEq86sDCmAuWxGoe/6F7L1X?=
 =?us-ascii?Q?ICOFcx+ul8n+cz5IGtrgsJNa5WZ7sCAO5ovd6vmOY3khoVh0fFJcThWhCCb9?=
 =?us-ascii?Q?jTcddwRRx4elIApbKFP4QB+N53Gy0b4UrtWMnnJfYIVqjoJ/v2u+Fj3zP3zP?=
 =?us-ascii?Q?YSVAN5D85ar2MZGW+nGlumlrjkYHexiKJEIl6/Uvnidb3D3L0twvQ068/Lxx?=
 =?us-ascii?Q?gTpsyOM84IOCvHMBldqFBTHIORxh3Vl2Hd8cmTsCRnQNhepqXtw4XXZyCQ0O?=
 =?us-ascii?Q?PX3SoGAcsCioKdX5OUjKXTgDamwlYPspm6PEgxesZzUxA8RPbZ0ADh/+P/E8?=
 =?us-ascii?Q?i4hk/1SfpfAnADhiqIf5ifBMqm6mrlcNWfX10JU/e9JSeOrJ3GZyfv+ZuSQX?=
 =?us-ascii?Q?zszjfaOcU02boC1F5SCR0I93+xKkGBWtj//zIe11Jlw9jH5o/fJcS8ji3G8Z?=
 =?us-ascii?Q?p4JaFG7EuABPKRLiIJksJyDpxZTiE8048rGmeSTVW3FXx+KwWiXmdqbdqOEJ?=
 =?us-ascii?Q?PlXAxSzEIIgN2l6U0OGUzsGb1rRwGCwkAfvec1qDNuZzi+gDqmQYcU48LZfi?=
 =?us-ascii?Q?I/gn8Sw3tG9WSNLiWVMw3uCVmEDsJMPVa37IGj8+2HRrOpLrInUSDMyeA90q?=
 =?us-ascii?Q?THboNU/ubdKBBmSwaIPJ6+xh1BIbNlaQT792N/Tk3X4uD7hRVJDxRYv2At8h?=
 =?us-ascii?Q?B9S8y4cToDRftslVmvIArFI69ZRMkN69zdWYKOzhDplsvnLN6oCKERCS57cf?=
 =?us-ascii?Q?mY+hN7T08RCjkp5fyzIrCLuWGOzW74ZmAvaAtAslV3EzBbSABPQVJGJOLWcp?=
 =?us-ascii?Q?IA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c7913e8a-8399-4f97-7cd8-08dd681644eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 01:18:21.0952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZFipbnCCRvQvJ3zuWRH8t3lhd4CUPBxUxRDulG0m8XF0k+u8LK0HZd4ZBo2OL5pCMO3rOpgrKPv6IP9Djexuf8IS8sLXe+T2eYAhNO2q/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7199
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Sent: Tuesday, March 18, 2025 8:28 PM
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
> On Tue, Mar 18, 2025 at 10:22:55AM +0100, Vyavahare, Tushar wrote:
> >
> >
> > > -----Original Message-----
> > > From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> > > Sent: Wednesday, March 12, 2025 3:41 AM
> > > To: Vyavahare, Tushar <tushar.vyavahare@intel.com>
> > > Cc: bpf@vger.kernel.org; netdev@vger.kernel.org; bjorn@kernel.org;
> > > Karlsson, Magnus <magnus.karlsson@intel.com>;
> > > jonathan.lemon@gmail.com; davem@davemloft.net; kuba@kernel.org;
> > > pabeni@redhat.com; ast@kernel.org; daniel@iogearbox.net; Sarkar,
> > > Tirthendu <tirthendu.sarkar@intel.com>
> > > Subject: Re: [PATCH bpf-next v3 2/2] selftests/xsk: Add tail
> > > adjustment tests and support check
> > >
> > > On Wed, Mar 05, 2025 at 02:18:13PM +0000, Tushar Vyavahare wrote:
> > > > Introduce tail adjustment functionality in xskxceiver using
> > > > bpf_xdp_adjust_tail(). Add `xsk_xdp_adjust_tail` to modify packet
> > > > sizes and drop unmodified packets. Implement
> > > > `is_adjust_tail_supported` to check helper availability. Develop
> > > > packet resizing tests, including shrinking and growing scenarios,
> > > > with functions for both single-buffer and multi-buffer cases.
> > > > Update the test framework to handle various scenarios and adjust MT=
U
> settings.
> > > > These changes enhance the testing of packet tail adjustments,
> > > > improving
> > > AF_XDP framework reliability.
> > > >
> > > > Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> > > > ---
> > > >  .../selftests/bpf/progs/xsk_xdp_progs.c       |  49 ++++++++
> > > >  tools/testing/selftests/bpf/xsk_xdp_common.h  |   1 +
> > > >  tools/testing/selftests/bpf/xskxceiver.c      | 107 ++++++++++++++=
+++-
> > > >  tools/testing/selftests/bpf/xskxceiver.h      |   2 +
> > > >  4 files changed, 157 insertions(+), 2 deletions(-)
> > > >
> > > > +	return testapp_adjust_tail(test, adjust_value, len); }
> > > > +
> > > > +static int testapp_adjust_tail_shrink(struct test_spec *test) {
> > > > +	return testapp_adjust_tail_common(test, -4, MIN_PKT_SIZE,
> > > > +false); }
> > > > +
> > > > +static int testapp_adjust_tail_shrink_mb(struct test_spec *test) {
> > > > +	return testapp_adjust_tail_common(test, -4,
> > > > +XSK_RING_PROD__DEFAULT_NUM_DESCS * 3, true);
> > >
> > > Am I reading this right that you are modifying the size by just 4 byt=
es?
> > > The bugs that drivers had were for cases when packets got modified
> > > by value bigger than frag size which caused for example underlying pa=
ge
> being freed.
> > >
> > > If that is the case tests do nothing valuable from my perspective.
> > >
> >
> > In the v4 patchset, I have updated the code to modify the packet size
> > by
> > 1024 bytes instead of just 4 bytes.
>=20
> Why this value?
>=20

Thanks for the clarification, Maciej. Based on our discussion, add
comments and modify the code for buffer resizing logic in the test
cases to shrink/grow by specific byte sizes for testing purposes.

> > I will send v4.

