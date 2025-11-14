Return-Path: <bpf+bounces-74454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B936C5B6A4
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 06:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCF93B313D
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 05:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E44286412;
	Fri, 14 Nov 2025 05:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6gh1fOe"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB237BE49;
	Fri, 14 Nov 2025 05:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763099422; cv=fail; b=p7uFz2m/6s/RR+cvYa25rm9nwvuVESSzPiHYrEWA0CqmFDGBtU8I99IrF87CB33RF/2eMBYl6DRMZrkD3lN6SuF51PIjnuJEe7ZIH2cMFTIkhw3ZoU8CPBLF3/lc1dqZ7WYVAm7eX0TVHHMPgNGlM9xYpM48/c1WirDN+VKTuyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763099422; c=relaxed/simple;
	bh=Rny4dpv6chVuhAXlXzoskJkJCJjYRYN0ByGyzpKHdZ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KjKKLDiHfBMyDkE0MeQsQQfcte3PSnJlc+p/+7lIXxAQUcWKKOxLzRK42tUR0jUrsWxkDRsXrZRUvgeil/0xO6Nph7rnPVOEqQh6ccTMjYsdLDoUHUA8eGVGdBAqBbrfm4Wpvxb7Yc1pzqpxEKtwFWKg/LmhC9a9yzb0pmLyhXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K6gh1fOe; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763099420; x=1794635420;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Rny4dpv6chVuhAXlXzoskJkJCJjYRYN0ByGyzpKHdZ8=;
  b=K6gh1fOeQ2LfygrqCkRuoEX1pXXNBD3mtXi9fqTT0sjKgIKmohxIBgK8
   nQiXPqlzAjdwBwJjG9ViUbfVkL62PFMPv7EDQBGaDBS5Pe7uJSldvGQJ8
   RkG6RDiKvBp6kh4FE4FMDaeHOk99/lte3wntc45zxE5J6V37fDyeyRTSi
   9CNTVA6dvX+34MrWh5C9R5laFcDF5+DZNkjRj7UqIhC2P4hAqj4JFMr7M
   9W53XhqTcnlcipQSdj2MKdVbuRJLoCqF35QqivYJ9nhQgOcNh7CUfsC4d
   y4c0VkNYyVONA9BM1nq4E2LynzLKJl7b5D67UX9NJ+Amgf8QnsPE713MB
   g==;
X-CSE-ConnectionGUID: CQgfdaroQjCvA8DJULDHCg==
X-CSE-MsgGUID: rpdGbuO7QcCjxjhZJltz7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="64396163"
X-IronPort-AV: E=Sophos;i="6.19,304,1754982000"; 
   d="scan'208";a="64396163"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 21:49:06 -0800
X-CSE-ConnectionGUID: H3mvuDUZTjyrAiEXpnfceg==
X-CSE-MsgGUID: 8K8glPT7R0WeoxwMVVKmfQ==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 21:49:06 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 21:49:05 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 21:49:05 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.10) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 21:49:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UzEsqlObf5E3yvea7v6+72En/HF6IbUmJJ6DT8puAAYBKhyPUbRNtcnKvHPhpCSZPZgep97DRvoM5aGmwynbg3wPya1SyUlE7sGAhe2bXo8Fx6T88DBNDbdlhGF11sf8mhODj+DqbmvHBUlewpM9DWupdTEeL64FTd8tDQyxWignPBl2Ywx65sFhKHynG+tRS2AJknDKW56ltuTACG4Sv9vo+CMU17Zc8YKPVRr6/8+Qe5k2UFAUee2w1rw3VYoV2ufG/YrwWFiDFVFVGPwvLmv/jHJqFtbguwYOweNrrfwQrCqeQrBjnzkdf+Rg9QWbKI1I5lCmE9/mnguUVaTyTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8P62xeJnjAEedk1lV7Vjsu8KmeasM1yZDJrK814s6A=;
 b=uOKWGgpe+Xk/qWDUREt5OMuo6w0KsAfzJ93F8WQpyhnSprslPgEE/NTLag74r/JLJTFLzhZ3pqoCLK/X/YmTSxbCc6l926+reZ6OKW9qrs6Mu8TyY0KogDWQTdFMFHh/zLKlVjTxXAQmMMvXiNIHUM0DeG4I0gACObUmWEoCG36cqnne5lkRcKvPlMEfKhPMC03scBgbi/ZkmMGkbxPcjP7w01PGe6JoYPgj3ECiux/uYlILeVc42YeaRwE3cdL5GZc65sedmsLQWybqQQyVZBOjBq9fHgR8wmFr5av3gvID2tzvBf0XFkl3Fj+LLxr7yBZPi4A7G3QfhnFlYIh6GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::31) by SA1PR11MB7129.namprd11.prod.outlook.com
 (2603:10b6:806:29d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 05:49:02 +0000
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::67f8:8630:9f17:7876]) by DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::67f8:8630:9f17:7876%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 05:49:01 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Alessandro Decina <alessandro.d@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Paolo
 Abeni" <pabeni@redhat.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net v3 1/1] i40e: xsk: advance
 next_to_clean on status descriptors
Thread-Topic: [Intel-wired-lan] [PATCH net v3 1/1] i40e: xsk: advance
 next_to_clean on status descriptors
Thread-Index: AQHcVHcdoRwLk31UM0S4JzFaFUIXELTxq5pg
Date: Fri, 14 Nov 2025 05:49:01 +0000
Message-ID: <DS4PPF7551E65521D890986032AAA3CD25FE5CAA@DS4PPF7551E6552.namprd11.prod.outlook.com>
References: <20251113082438.54154-1-alessandro.d@gmail.com>
 <20251113082438.54154-2-alessandro.d@gmail.com>
In-Reply-To: <20251113082438.54154-2-alessandro.d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF7551E6552:EE_|SA1PR11MB7129:EE_
x-ms-office365-filtering-correlation-id: a9e198dc-8db6-4e9d-09dd-08de2341837e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?Rz6+ZGik4s9co/8yITh/YY7/Ftv7PzJ3HMb6ZtZkk1gvxE//ZZNjeCfExKbC?=
 =?us-ascii?Q?uclFOC+iL5hTMHC/ywNizBpMZ368ud1uaBrWTQlxCSf1dXMr4vlki9cbh62E?=
 =?us-ascii?Q?vT5xo2IPQNhLDYhi1bknrUoaNhgHXPuD0u/ko1PyDKNdNePp3ZcxvbNU0dyw?=
 =?us-ascii?Q?136/AGp5rdQ2SKt4RwpLaFJ17WQmnXLLbhSoZpUwUXrsUoCJAy6U7G9s27k9?=
 =?us-ascii?Q?cMP8YyMuaDHqUnqz+u7Nh5MJvHtAwjSE7ulkWNxINR69CeuqKbePK35QY+WB?=
 =?us-ascii?Q?T9todiqdOHibe81NIpvXDvQ9fNSvCjTEiw/CVNG/6uL5Bk0L+JRC0u5LzKhT?=
 =?us-ascii?Q?Dx+bkjMunD1cVcdNgy5gdmZwE8TgJz9Obo7ZmRdhlcyRWX4ic8Z4ftBqEAmn?=
 =?us-ascii?Q?/4YYBHZMEoQbQSrZxIxdk+mzahJc3b2kCpRtIjb6KLTef72OsBfdnnwWtpAc?=
 =?us-ascii?Q?6dbBgB24kXzPHXmQlsqIK62De/VN5HjrI45gchBpgfPMMYwuxea65x7pv4rL?=
 =?us-ascii?Q?8PNSMHKI/qpe9w5dOhma1vZ8R3hmLOmF2fb/nWyahj5TMFI+ImlJSk1SI7+z?=
 =?us-ascii?Q?jAfYE8s7HF/yDAVWELm5oSpevYFJ7EtJdQkzMVA1sGkYSucHae0l1VVfRnN4?=
 =?us-ascii?Q?+VdtMYmRpPhcx7Pdbzc1Ohtvsnp4F4vcqaZGLPxANG/VnxsHIseEFMS1z3k4?=
 =?us-ascii?Q?N7QDJIqWXHy1enHjEA1/YgIfzbTiFH5DvO7ENXL28XkjrENXUv/lqAOEJwuc?=
 =?us-ascii?Q?DY+m8NYy/v3ilQcdmIVdGP5JSVY2EBHPYgB2yI/qfQWZsrcW75Oy95GBD8SI?=
 =?us-ascii?Q?LPCl/rCQA2HvQrAujbgT2P5yo+vuVZ8zklEpngo2N5OrnvOH00P3ZVrrtey/?=
 =?us-ascii?Q?6kNRCQ+WED/TtYuqZrXs0uyi0gab51Z7Cy258tB+qAvbsWYR6U44rpm0UCeF?=
 =?us-ascii?Q?JvaBl7A36rRjJX8dQS6wG4gfByNkEoz55CLe+uj0l52IVCdiIN41JbUIkWPQ?=
 =?us-ascii?Q?ni1RMdqr+PNa4Qb3F1HvP0d89bkgneFp5tYx5ClvCuJkC4Wufly5jEepv95T?=
 =?us-ascii?Q?jvQRXzg3kcFgEfB/Ql/ldFuwZDJoOC1AyI6dyhpJnnl0dILPCg6iayP4Nb/o?=
 =?us-ascii?Q?itepvZflrtTLB/VS8QggRxP2PnF3o6x7BkcIsVonSkL0nRMkXLqQwahX3Dab?=
 =?us-ascii?Q?CMxYwIWorwifJut4+L5ZqN0HiS4V1/xH7kILst9VCismWx+yWD3pksVTT0/p?=
 =?us-ascii?Q?Z5Nwr+aUfM4V+xAX7VlLUFgjGLzpwxYc0lDGiTqxT0XKiTl7ct3bqo/fHOep?=
 =?us-ascii?Q?5xMNjiKWbrYYdH1VRJzrIx9gZrxjg9F/4NSiYHHEA35OnGtyY04q4OrDAtRk?=
 =?us-ascii?Q?2ZXoytpQOt/AHELsYNM130KrFnw5nYnHyrLXb8WjMtalB4cqz+Slq8GfSP3c?=
 =?us-ascii?Q?VT0qnrVRdpjcKgAlpEXGofnJtNn+7KFIainNkzDDhyN8T8sDMIxtc9RCsAQZ?=
 =?us-ascii?Q?fmpWlaQDHyUrQUAtaVAvNP9YdPt/UrP1fZhc?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF7551E6552.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ojJCoF0D4m/HjpiaqSMkvFmYM1fkv7b48purI6ns4wrj4CLF+4mVKaz0godx?=
 =?us-ascii?Q?OFWTugH2qmlKAjBek0LrNaUrPPpWrQ27c7zMut5qE//lsSWiWZShsMnjfNUV?=
 =?us-ascii?Q?gtckDQ3/+I4VGjOBXWEgtY+SeJxrDzitXXSscOMrztgYjiK12Xx65s/wqJHD?=
 =?us-ascii?Q?Zd9vbmiNuvcjz871F77vzFHT+dwkqsdL0tjVyiZCyaw2J24PehfhC9igoUfu?=
 =?us-ascii?Q?Zl8qDaaa2DYh2/M6g73OVhpoKDJzOqa/6VKBpXqafhaabr+o2YCkVBYUw9/4?=
 =?us-ascii?Q?L4VGAdiv6CwUzUw19O/dtYuWFYzBWFkgS2/sM2idLJJNnBKPCoGm2ASJAtDO?=
 =?us-ascii?Q?lfC7eGaYUTB/xw0Pg+Wa6yHO6TizCoEO6jtHMLUzG2OW6c8OBLYr7NpJsssw?=
 =?us-ascii?Q?DeD6eUsLFHNa6N/FHwmAkvGrZ7+9eMnp0x/Jp4gL/p8JavkYozCV2ugwwwH9?=
 =?us-ascii?Q?IMd1Ffue8eu7HeIg++hwiplkQ60qCsBcJce9qrShsnzHBiAn+ZJXnqpUbBy1?=
 =?us-ascii?Q?8JWuhf7aByWZjXR/DSx6e4tCFahL4ybe+cNr17vq6X4c6rx2vbSPnRvbNVvi?=
 =?us-ascii?Q?rQyAJ20gdSna3Gtv5brDygWNei8l4WNPVXrkEfd69IJK2uNKIhPUo+L9vlGS?=
 =?us-ascii?Q?zTSWfzDIqNlFJf0wKPNYcNSNmwQ9wsAqhSGyZvcyWcgfRQrYATTlCylmZxoI?=
 =?us-ascii?Q?ppaQEOwLQXrDQtU49rpVt+Xq5Z6NK88VSaPm1Y2/FbFM2H4UeACvgnvGaiXO?=
 =?us-ascii?Q?vL+PlXhTpT6WrhjQ8gMPmukFpt62wTFq4AQ/LVBT5gGd5KBQcAfSA6uU7zTT?=
 =?us-ascii?Q?uVuW8FXGWxnWHajr1KK9utgyDuynHgIVvRl8XZedMqG41uew2k8WD4/pVvkk?=
 =?us-ascii?Q?tf48J2dyGUO4mDaFu5Ee7VjGKfhOaMk0ZUclVtKi5UETH0C6EIz877sHRF1p?=
 =?us-ascii?Q?UEDXUsllaEmXzGb/yA16YpheW1ttGCc6fKvLmw+BtbEuLPhL0HQZ78hOt5lw?=
 =?us-ascii?Q?rJgngWfmELuDLV1JMBuQthXLuZcA5u38UbAaoNZexaDavhFUaNAjHxO8m930?=
 =?us-ascii?Q?+16/VqUgNUStavl3Mxp9PDfW9xVEkPjLBe9Y15h51eMJd0YdFoHhw5CtI9ii?=
 =?us-ascii?Q?r9w97AF5YwkLY0Hrizq8/a2HQgel4SD33u9/jjOTaY6q0V1mxviaLrSmDivt?=
 =?us-ascii?Q?PL4Myks4lZhCnpf+7VShmM8Rxf5vNsosVHrjMl1HtfeaLQBWtNivngSTCxqM?=
 =?us-ascii?Q?+p+t1FApfTcFzL8xjc6jwqUxIcLv0P1FscHc3XMbE/BaHPPZuc7AVkcm9BXu?=
 =?us-ascii?Q?t4sOP3i7745Vljxhd87GMyCzlqVICouxeT5xIyeYUFo1vqoIhmtoHCxXlACp?=
 =?us-ascii?Q?RK82XF8tjM37Ij5DZ2S11ycr7phxikkqdZNWpqgfTItmCo6FmCJKUKcvsrII?=
 =?us-ascii?Q?tQE+UDN42MeTOgGVgOPO7C/DSp8sZbiRnHYrkE7/hIRNEx5e8Martb7ICJlW?=
 =?us-ascii?Q?alHNkpbJWJwvh3IUZioQsIucIKF37ODgV1pfh1aqjyEiYd00NOEP0oKnO6js?=
 =?us-ascii?Q?LQf3q8wvLOXDIJSW75ERvlKreEkoJuEqR5aDiqXz9D8c9PAArb8AD/r8xbDh?=
 =?us-ascii?Q?LA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF7551E6552.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e198dc-8db6-4e9d-09dd-08de2341837e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 05:49:01.8889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DGwqmpXlcS6JWFNTxTCCMo5yDRWLfDofqPYnqjNJb5iIGf0bGsHJXGxOcElrjRCfre2Do0dkXQ8oveS+EAzzBwdgNRMxICgYoncSlcBJyis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7129
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Alessandro Decina
> Sent: Thursday, November 13, 2025 9:25 AM
> To: netdev@vger.kernel.org
> Cc: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; David S.
> Miller <davem@davemloft.net>; Alexei Starovoitov <ast@kernel.org>;
> Andrew Lunn <andrew+netdev@lunn.ch>; Daniel Borkmann
> <daniel@iogearbox.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Jesper Dangaard Brouer <hawk@kernel.org>;
> John Fastabend <john.fastabend@gmail.com>; Paolo Abeni
> <pabeni@redhat.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Stanislav Fomichev <sdf@fomichev.me>;
> Sarkar, Tirthendu <tirthendu.sarkar@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; bpf@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; linux-kernel@vger.kernel.org; Alessandro Decina
> <alessandro.d@gmail.com>
> Subject: [Intel-wired-lan] [PATCH net v3 1/1] i40e: xsk: advance
> next_to_clean on status descriptors
>=20
> Whenever a status descriptor is received, i40e processes and skips
> over it, correctly updating next_to_process but forgetting to update
> next_to_clean. In the next iteration this accidentally causes the
> creation of an invalid multi-buffer xdp_buff where the first fragment
> is the status descriptor.
>=20
> If then a skb is constructed from such an invalid buffer - because the
> eBPF program returns XDP_PASS - a panic occurs:
>=20
> [ 5866.367317] BUG: unable to handle page fault for address:
> ffd31c37eab1c980 [ 5866.375050] #PF: supervisor read access in kernel
> mode [ 5866.380825] #PF: error_code(0x0000) - not-present page [
> 5866.386602] PGD 0 [ 5866.388867] Oops: Oops: 0000 [#1] SMP NOPTI [
> 5866.393575] CPU: 34 UID: 0 PID: 0 Comm: swapper/34 Not tainted
> 6.17.0-custom #1 PREEMPT(voluntary) [ 5866.403740] Hardware name:
> Supermicro AS -2115GT-HNTR/H13SST-G, BIOS 3.2 03/20/2025 [
> 5866.412339] RIP: 0010:memcpy+0x8/0x10 [ 5866.416454] Code: cc cc 90
> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90
> 90 90 90 90 90 90 90 90 66 90 48 89 f8 48 89 d1 <f3> a4 e9 fc 26 c0 fe
> 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 [ 5866.437538] RSP:
> 0018:ff428d9ec0bb0ca8 EFLAGS: 00010286 [ 5866.443415] RAX:
> ff2dd26dbd8f0000 RBX: ff2dd265ad161400 RCX: 00000000000004e1 [
> 5866.451435] RDX: 00000000000004e1 RSI: ffd31c37eab1c980 RDI:
> ff2dd26dbd8f0000 [ 5866.459454] RBP: ff428d9ec0bb0d40 R08:
> 0000000000000000 R09: 0000000000000000 [ 5866.467470] R10:
> 0000000000000000 R11: 0000000000000000 R12: ff428d9eec726ef8 [
> 5866.475490] R13: ff2dd26dbd8f0000 R14: ff2dd265ca2f9fc0 R15:
> ff2dd26548548b80 [ 5866.483509] FS:  0000000000000000(0000)
> GS:ff2dd2c363592000(0000) knlGS:0000000000000000 [ 5866.492600] CS:
> 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [ 5866.499060] CR2:
> ffd31c37eab1c980 CR3: 0000000178d7b040 CR4: 0000000000f71ef0 [
> 5866.507079] PKRU: 55555554 [ 5866.510125] Call Trace:
> [ 5866.512867]  <IRQ>
> [ 5866.515132]  ? i40e_clean_rx_irq_zc+0xc50/0xe60 [i40e] [
> 5866.520921]  i40e_napi_poll+0x2d8/0x1890 [i40e] [ 5866.526022]  ?
> srso_alias_return_thunk+0x5/0xfbef5
> [ 5866.531408]  ? raise_softirq+0x24/0x70 [ 5866.535623]  ?
> srso_alias_return_thunk+0x5/0xfbef5
> [ 5866.541011]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 5866.546397]  ? rcu_sched_clock_irq+0x225/0x1800 [ 5866.551493]
> __napi_poll+0x30/0x230 [ 5866.555423]  net_rx_action+0x20b/0x3f0 [
> 5866.559643]  handle_softirqs+0xe4/0x340 [ 5866.563962]
> __irq_exit_rcu+0x10e/0x130 [ 5866.568283]  irq_exit_rcu+0xe/0x20 [
> 5866.572110]  common_interrupt+0xb6/0xe0 [ 5866.576425]  </IRQ> [
> 5866.578791]  <TASK>
>=20
> Advance next_to_clean to ensure invalid xdp_buff(s) aren't created.
>=20
> Rename i40e_inc_ntp to i40e_inc_ntp_ntc. Make it take an optional
> pointer to next_to_clean so it's harder for callers to accidentally
> forget to advance it.
>=20
> Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> Signed-off-by: Alessandro Decina <alessandro.d@gmail.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 33 ++++++++++++------
> -
>  .../ethernet/intel/i40e/i40e_txrx_common.h    |  2 ++
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 17 ++++++----
>  3 files changed, 34 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index cc0b9efc2637..d3dae895a058 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -2359,15 +2359,24 @@ void i40e_finalize_xdp_rx(struct i40e_ring
> *rx_ring, unsigned int xdp_res)  }
>=20
>  /**
> - * i40e_inc_ntp: Advance the next_to_process index
> + * i40e_inc_ntp_ntc: Advance the next_to_process and next_to_clean
> + indexes
>   * @rx_ring: Rx ring
> + * @next_to_process: Pointer to next_to_process
> + * @next_to_clean: Pointer to next_to_clean or NULL
> + *
> + * This function advances the next_to_process index. If next_to_clean
> + is not
> + * NULL, it is advanced as well.
>   **/
> -static void i40e_inc_ntp(struct i40e_ring *rx_ring)
> +void i40e_inc_ntp_ntc(struct i40e_ring *rx_ring, u16
> *next_to_process,
> +		      u16 *next_to_clean)
>  {
> -	u32 ntp =3D rx_ring->next_to_process + 1;
> +	u16 ntp =3D *next_to_process + 1;
>=20
>  	ntp =3D (ntp < rx_ring->count) ? ntp : 0;
> -	rx_ring->next_to_process =3D ntp;
> +	*next_to_process =3D ntp;
> +	if (next_to_clean)
> +		*next_to_clean =3D ntp;
> +
>  	prefetch(I40E_RX_DESC(rx_ring, ntp));
>  }
>=20
> @@ -2484,17 +2493,19 @@ static int i40e_clean_rx_irq(struct i40e_ring
> *rx_ring, int budget,
>  			i40e_clean_programming_status(rx_ring,
>  						      rx_desc->raw.qword[0],
>  						      qword);
> +			bool eop;
> +
>  			rx_buffer =3D i40e_rx_bi(rx_ring, ntp);
> -			i40e_inc_ntp(rx_ring);
> -			i40e_reuse_rx_page(rx_ring, rx_buffer);
>  			/* Update ntc and bump cleaned count if not in
> the
>  			 * middle of mb packet.
>  			 */
> -			if (rx_ring->next_to_clean =3D=3D ntp) {
> -				rx_ring->next_to_clean =3D
> -					rx_ring->next_to_process;
> +			eop =3D rx_ring->next_to_process =3D=3D
> +			      rx_ring->next_to_clean;
> +			i40e_inc_ntp_ntc(rx_ring, &rx_ring-
> >next_to_process,
> +					 eop ? &rx_ring->next_to_clean :
> NULL);
> +			if (eop)
>  				cleaned_count++;
> -			}
> +			i40e_reuse_rx_page(rx_ring, rx_buffer);
>  			continue;
>  		}
>=20
> @@ -2507,7 +2518,7 @@ static int i40e_clean_rx_irq(struct i40e_ring
> *rx_ring, int budget,
>  		rx_buffer =3D i40e_get_rx_buffer(rx_ring, size);
>=20
>  		neop =3D i40e_is_non_eop(rx_ring, rx_desc);
> -		i40e_inc_ntp(rx_ring);
> +		i40e_inc_ntp_ntc(rx_ring, &rx_ring->next_to_process,
> NULL);
>=20
>  		if (!xdp->data) {
>  			unsigned char *hard_start;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
> b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
> index e26807fd2123..3d7e4b3404f0 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
> @@ -17,6 +17,8 @@ void i40e_update_rx_stats(struct=20

...

> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

