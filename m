Return-Path: <bpf+bounces-46710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27D89EEB8B
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 16:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8701316B1F6
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 15:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBA621660C;
	Thu, 12 Dec 2024 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nS9pdoQZ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9861487CD;
	Thu, 12 Dec 2024 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016872; cv=fail; b=N4Hz6fHE5W06CO1ckSbl9VulvaFcrCi4R4ZblrkSztiWypQFYEw1WXzlwVAw7DOzENNP73hSbOrvQrOquWr5pOTHAqQya+EB0RRqDaTr8jFXUeWJzuoLhN/mU7v+LMfBZYdCW6/pHTe+vtyEBSHt9mFOmkjdHhxdorp0iIAbADU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016872; c=relaxed/simple;
	bh=rW8OnRhTO/N6CqrRB4+RohEKJ06or3s3IVS2Hs9RX4Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TBzYlMJkCf2IkDCJNG5mIcltyEDLJFk9j82N54W4vRJog4Hm3HdWmQX21oYyfS2JnehWjYxEfHA0EIOG/kYyC1pYZ9CpwzqJnEoS0AS2ffSt61KtV7fPbhljSaK7JCIPECmdBYqFEJMMiTQznZTkOzyDKkbHZE72zTlGW53tV/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nS9pdoQZ; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734016871; x=1765552871;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rW8OnRhTO/N6CqrRB4+RohEKJ06or3s3IVS2Hs9RX4Q=;
  b=nS9pdoQZdANAlLEVWa2pae7W1v5bw6s319sfxRKpo0tC8Owk+lkp2jDP
   E8682CAAu0rJbpu2gBWaxM/d9hlqzYRtiJu5pXGlR6XQUTh+saSw9Lk1Y
   lXVZDDFBXmAlsZcSh2Q8Lqe5PdmFRFp5fSI40iQNpU8oZ4SY7qkni5+xo
   qTLFHt1+SkHLXs3ZHVbOYzzTl/RwiGp0pIFfGmHGNvMqug8eX7EfPYGWa
   FNXMkyAQmPg6bWUZz1AxCfTN2CY/DtVE7dH5GWbL/28Tlc6+GXZ2qaI5j
   prN5wnv5G6IWgzq4HtsJ+ovTaoHsDCs/pRW0Q+iRcaEFKZDRVri+58DRH
   g==;
X-CSE-ConnectionGUID: ++8IgOCwTVec2uYRZMrywQ==
X-CSE-MsgGUID: C5fjp6xuR9qsE82erl9I/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="51854494"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="51854494"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 07:21:10 -0800
X-CSE-ConnectionGUID: w8tqj4FpR9aQrP53duF9rA==
X-CSE-MsgGUID: y1jLXPWWQJGQdF3px9/dNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133628622"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2024 07:21:09 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 12 Dec 2024 07:21:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 12 Dec 2024 07:21:09 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 07:21:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0Pdjqtargh0RsBxnbAfgfCaEkJmkmeqEdm4XdlBstQBzXH7Eu8B5dAub7NmV5WMRtMIV9UJjoZR6IfS5gkXE5rNge2lZaZrEkZ4eHZhs6xTddU8Had1Iu+l5+HajIEEs/Ya/1k7ZXngxImIQ/SD5UgsRMBbcrc1+vg4CiCR8QfiLBYFdxGPkQmmM86fkWgKWpQMV/Z2Tsn1KsBEs0w+oYa4jR9tM0KQ8mgme8seZBZh182MVc9iZsht8H9BBonoh9K/EaZiyxol0pJNsNzBAxhvit3qomwIVrUXYyIzKNNxXsPf87Zb9OshI74sK8mK+gjbVbzPgoB1g7XLU1YCHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bCsKnKFEsaAXB0KMtb0WrHl04Z6VsIzZ2QqMLq2Hqc=;
 b=TIbkEwnajIiiCsJx4RoKYhVoEJmtpKLvPVRr3a7Y+EuOCio5Kvgwzt6lN/do5baGuzeS/6fRSa9owEoaxuPRMylBfEnsMdKoob+GQoSXoWauQh3/0wFUwG131cb0ii+p4SQoA9Ho8VwQ9Fv7Id+OAn7yoLUXXRmV7CyQGqI66O6uIOkY5V20Iwr8RMSAOfg1HPbT2HRFr2y5j49b1rMprtQVom4mQqp6R3vuPudTzN0+FnSwGYOXCTMgygKns9NJGSTUcM7hUMUVsrATalzfH61uVvI4bLCM06n/atamuRFvA7uzP7Q9CLGCv1Z5bfpbRO9rAV2/YqkPd2dBmTxF/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by PH7PR11MB8480.namprd11.prod.outlook.com (2603:10b6:510:2fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Thu, 12 Dec
 2024 15:21:05 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%7]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 15:21:03 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, "David S . Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Gomes,
 Vinicius" <vinicius.gomes@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH iwl-next v2 1/1] igc: Improve XDP_SETUP_PROG process
Thread-Topic: [PATCH iwl-next v2 1/1] igc: Improve XDP_SETUP_PROG process
Thread-Index: AQHbS9Mj1En7w58Ui0COxbXiho+dnrLipwiAgAAQZQA=
Date: Thu, 12 Dec 2024 15:21:03 +0000
Message-ID: <PH0PR11MB583067FFF7CE494EEF50461ED83F2@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20241211134532.3489335-1-yoong.siang.song@intel.com>
 <Z1ruZwiTmph3iX9F@boxer>
In-Reply-To: <Z1ruZwiTmph3iX9F@boxer>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|PH7PR11MB8480:EE_
x-ms-office365-filtering-correlation-id: db261cff-34d4-4be3-a0fa-08dd1ac09772
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?I+Z6ZbCT6M2TV1TB4voipDjSard7yXB4N0fALaDMPJeD5cNXtKACwGjpWXSI?=
 =?us-ascii?Q?jRWxMDs82MtgQHlPhfrMk70flJdpNuAind1l1SwDGV81KufIYKxGa21EXObz?=
 =?us-ascii?Q?32q0QAAbR+gkezOPhbiqqlo44jnxCaazef3Do8UBY4vpZEXDoF8+GxFFvRx0?=
 =?us-ascii?Q?hr/spjj0KMWA58I/iecmWIRok7DDGRAHd6pZJz2anG4a0Bvx31rbdDSRUgZp?=
 =?us-ascii?Q?i1F++iqgKMxZtp9eV5zcEa2ivfNBUhIySSwjyx2TASJ8pPujXUp/Vd9gF62M?=
 =?us-ascii?Q?IE6E0QZGSO0CELmB39DHhBFyfitOFD7RPaJ7NcxDt7/6cEFMVmMTgv7hkdoe?=
 =?us-ascii?Q?lI+h81r0w23AdwFhHMvTO4Jf94uGY4y3t7rqSXN0RphnKndBTHNpB6DbyLAR?=
 =?us-ascii?Q?c8bvbvMd8X/EYaf3AQfqNLG0hpPJ27+kcHgekZTFUJRmIDBh34IZ89TgxCsF?=
 =?us-ascii?Q?UOo7FzzEaUjWICGXdyIgfPGD+PnhMo/uDj+fnkVG9fTy3cMj4R4qD91J3Hqz?=
 =?us-ascii?Q?9iTKm5KLYZYb1CGtw/tDPRFhWnIf20zwbIaMBLQeqLNn8/F335Z/wj/hAAi4?=
 =?us-ascii?Q?FJ3Y3taaTeUsc77klRhkN18Amtz7QJL9DOABcIcYUm+c+9kCiRT3caqsQmNy?=
 =?us-ascii?Q?VGJDtrXMSM98hsiKkJzggvJbMl6nedCJpEqTH5sodlu+C3e8mc/3KgTuKowZ?=
 =?us-ascii?Q?/ebrCMQAEFVD4BR1xqdQBH6TDSbiiEhLZ6tDjWKolAPZdstyPjBjNcw8NmFt?=
 =?us-ascii?Q?yHmb+pBRPa8XSff01rAgMGSRf/0F+ly7Kyb+UHy3EXa0AeDp67TsL/iBYzVN?=
 =?us-ascii?Q?/ViXY+q832PAk8l0jt84cCqyrH1B3Q2RerPPziB/NWOCRcx63Fg+ZOfHPMNK?=
 =?us-ascii?Q?HlvRFNbfde17RLwrOCkL0MfNMloJNsCws7BF/KU8zIpC11+05dnVHY4gKZBc?=
 =?us-ascii?Q?pkSWYfKc4gDggsZavy1yi2NTmYknunUSSI5C8YYuy5NRHQXt1AXL096b4me9?=
 =?us-ascii?Q?CJTn9UiYYsEGZLX+0beI522WbgK60Nzr6L9OtOUJTTduqFg98VRe2OCSYz92?=
 =?us-ascii?Q?P7yU3+Xw1NGkYSts+ZSRX0pLBFZq294257J9FGGeyoqr0CvyE2h7s57bHxh5?=
 =?us-ascii?Q?QY3kui8pD79ali/5Hgc4KIYD0hup3niN3bH/VtTOB33hE1EBVJj/I2MWNcF7?=
 =?us-ascii?Q?/D5UTAc4YKk+fw6i9aNb/9abGXIGOmEqGlt9BxSdQLSEH9XeE0sWBj4Gk3Ng?=
 =?us-ascii?Q?EjAXFEF0G6pYNl4luqjaqJgAyktqRw9VIfkWVFC2EAvn5SNJ02Rwuvcfe6Pw?=
 =?us-ascii?Q?gMor+3QOLnOD9yMr55xLfj6VyKEAcWfhCFC4FoCFH7tp6JU9cAI/Jtv/NKGJ?=
 =?us-ascii?Q?tX4enAJlrDF+YcKGwN8GJsyZ457i0HcatjtclZpBEc8QCP5Flg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a7CkC1wmnFgjeFRu+kO52218GvA6UaYilfU3leFCXYxZHf7EQfF5Eg0iEDYL?=
 =?us-ascii?Q?sVXveJzuh9ysmw9B6y89i/2AugU4kzWAHH/40X0h1zFtTRj62F6M51Walc2r?=
 =?us-ascii?Q?B9ddsug7Ue+MB/ybf35v/+Fn3e66pEREiAM/SsjMqjdwmcJRYuY6GZwRi/S9?=
 =?us-ascii?Q?jvuqlhJ/HH99oS17Eph10l2ZAlMepOiqk2Bekct1ibY3JkZQxlXJ/qRQ+hII?=
 =?us-ascii?Q?GIMNjNTE/Ti4iVL3DGQPmJCu0jXcRMzIA4uQJptanvD17ITR4kNvgm2tM3fJ?=
 =?us-ascii?Q?jiXhyEpua2ORIrqL0omRn479WsEqO8w8Yzz7wv0f83wDo3BJ4pfjdFaRt1it?=
 =?us-ascii?Q?fUmzIi7YBoY7Etpdwn5E1hXKMYYsPJQ94eIYpaUj6W8ZFJb+9DE3cVxdwyXI?=
 =?us-ascii?Q?NSEezTB93rmKPWKMnAGnmd8+mQLMNtfvlRLo+fyofhHIiquIHaDEc9SvNjS7?=
 =?us-ascii?Q?I+k6iZjQPFo5DggWS1I+Ir/q6SZaBP2zQfkHxLy7CJICrBWU5Db5EfgkBnnS?=
 =?us-ascii?Q?ZRGRb5tmE/SFbh2JCb3bPs9FZhscQVm7UlOk5FU/l5k9g+7R5Ye0pm19MBXF?=
 =?us-ascii?Q?85I9T/0Qd9pVV6qYhxxY0ruCaxde52ssIVzq0n7GSgQN781wKwif6GkdKiiL?=
 =?us-ascii?Q?WXFxAl7o4mpDZSeOFzP1KwKaziTXnwRbFv+PzQ9C0qviYvipzOcKErLsMobd?=
 =?us-ascii?Q?cjBaBnC1EDA2ptapdPLPn1U+r44VWUbXaF2Em7s+Zn5aX5GoU6i9SKsQeH9P?=
 =?us-ascii?Q?WipGt3iXaObw1ES8bJZYbgBDIEg8d3h1PxJ1wmPGRYzGrAUITi6Qa8rn3vz1?=
 =?us-ascii?Q?lN23AG7TDQIPWDhmdNAR2YIPSdQoqsRTEVThdsgw131yV2jiB9vIHg0jQu74?=
 =?us-ascii?Q?OH31ruMHFL1Ay8xNRVpcIyBZl9tJaek5xOyyhGkn9jSUEMtSCWcs0os29B3F?=
 =?us-ascii?Q?g+MFywU+qm9hg7jZ9LBnG++a2y21yHmbRwFP33eS+rG5FcAn2FhOPnlaSDHE?=
 =?us-ascii?Q?ZFyqn6KewCqdNCJBIArdFNB9hyR8fzRZ3I43eW3oP0PFY6o2I0MEttyKZ6tl?=
 =?us-ascii?Q?psc2nvt0XMQQhpiTcMveI9KvDVv06dn9BovhzQ2xe0uf9Bs1tji9JWA4KfwJ?=
 =?us-ascii?Q?v/ugK27Q199f5ndAYyod4bZZHKdmGfkFrt1p2zty8qf/66q2EEK9lDKciD/G?=
 =?us-ascii?Q?MB0gLdi+RREDvxksLAsJ8U17rE4RjyRmZxp2WFe9kCj7EYoYDCSwnwYM4NGB?=
 =?us-ascii?Q?JCh0a8RikGQWsqa54L5n/fFzR7Tfma7ND+3ptI72aBGp0KwAchFFMyFTyZx0?=
 =?us-ascii?Q?pOz8JWsIm0YSvvhC4isDB8biuW38iJ7fmAIw69nyPi542zOgGsPDzhM7nHMp?=
 =?us-ascii?Q?RELHYs1y+ehTLonUSwV3Fzrnb7dvqsRvxpIsvtVcb4fNdF3c9E4acf1LGTkV?=
 =?us-ascii?Q?WaInIJgGeJSM3VjpW3ShIQfE4DVDJcMG/XYOakVVr72t7FtbMTAnjBidY0W3?=
 =?us-ascii?Q?qkY2z3hT2Dvb5dtV3ik1pfW44WVxh2UvprRmOiDVQY2QuABovNcyXo8SfNiJ?=
 =?us-ascii?Q?mXM3fpwFM9yrSpNhBSPbhaUgngUHpeTyX0y1dyC250yLUjI83Vile12Cbu/q?=
 =?us-ascii?Q?OQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db261cff-34d4-4be3-a0fa-08dd1ac09772
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 15:21:03.3297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 020ladOaUJBVRT4V2piRGJQvkcpjhHBXmUmU22fz49psBsOxcVoowuT5CrsNJf38jUTokU8us3Qe/3G1GmmR/+AooVUan+L98C71jBPPCek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8480
X-OriginatorOrg: intel.com

On Thursday, December 12, 2024 10:09 PM, Fijalkowski, Maciej wrote:
>On Wed, Dec 11, 2024 at 09:45:32PM +0800, Song Yoong Siang wrote:
>> Improve XDP_SETUP_PROG process by avoiding unnecessary link down event.
>>

[...]

>
>I agree we could do better than igc_close/igc_open pair, but have you
>tried igc_down/igc_open instead?
>

Hi Fijalkowski Maciej,

Thanks for your comment. I did 2 experiments on your suggestion:
1. with igc_down/igc_open, kernel dump observed after load xdp prog,
    as shown in dmesg below:

[   87.957526] ------------[ cut here ]------------
[   87.962168] remove_proc_entry: removing non-empty directory 'irq/150', l=
eaking at least 'enp2s0'
[   87.971014] WARNING: CPU: 17 PID: 3690 at fs/proc/generic.c:717 remove_p=
roc_entry+0x19a/0x1b0
[   87.979581] Modules linked in: algif_hash(E) af_alg(E) nf_conntrack_netl=
ink(E) xfrm_user(E) xfrm_algo(E) xt_addrtype(E) br_netfilter(E) nft_masq(E)=
 xt_CHECKSUM(E) xt_MASQUERADE(E) xt_conntrack(E) ipt_REJECT(E) nf_reject_ip=
v4(E) xt_tcpudp(E) nft_compat(E) nft_chain_nat(E) nf_nat(E) nf_conntrack(E)=
 nf_defrag_ipv6(E) nf_defrag_ipv4(E) nf_tables(E) nfnetlink(E) bridge(E) st=
p(E) llc(E) overlay(E) binfmt_misc(E) intel_uncore_frequency(E) intel_uncor=
e_frequency_common(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(=
E) kvm_intel(E) processor_thermal_device_pci(E) kvm(E) processor_thermal_de=
vice(E) nls_iso8859_1(E) mei_hdcp(E) cmdlinepart(E) intel_rapl_msr(E) proce=
ssor_thermal_wt_hint(E) hid_sensor_als(E) processor_thermal_rfim(E) rapl(E)=
 spi_nor(E) processor_thermal_rapl(E) hid_sensor_trigger(E) intel_cstate(E)=
 wmi_bmof(E) mtd(E) industrialio_triggered_buffer(E) intel_rapl_common(E) k=
fifo_buf(E) mei_me(E) hid_sensor_iio_common(E) processor_thermal_wt_req(E) =
processor_thermal_power_floor(E) idma64(E)
[   87.979631]  processor_thermal_mbox(E) mei(E) industrialio(E) int340x_th=
ermal_zone(E) virt_dma(E) intel_pmc_core(E) int3400_thermal(E) pmt_telemetr=
y(E) intel_hid(E) acpi_thermal_rel(E) mac_hid(E) pmt_class(E) sparse_keymap=
(E) acpi_pad(E) acpi_tad(E) sch_fq_codel(E) msr(E) parport_pc(E) ppdev(E) l=
p(E) parport(E) ramoops(E) reed_solomon(E) pstore_blk(E) pstore_zone(E) efi=
_pstore(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) =
xor(E) raid6_pq(E) libcrc32c(E) dm_mirror(E) dm_region_hash(E) dm_log(E) hi=
d_sensor_custom(E) hid_sensor_hub(E) hid_generic(E) intel_ishtp_hid(E) hid(=
E) i915(E) prime_numbers(E) drm_buddy(E) ttm(E) i2c_algo_bit(E) mxl_gpy(E) =
polynomial(E) drm_display_helper(E) crct10dif_pclmul(E) cec(E) dwc3(E) dwma=
c_intel(E) crc32_pclmul(E) stmmac(E) ghash_clmulni_intel(E) rc_core(E) ulpi=
(E) spi_pxa2xx_platform(E) udc_core(E) sha512_ssse3(E) i2c_i801(E) dw_dmac(=
E) sha256_ssse3(E) pcs_xpcs(E) i2c_mux(E) nvme(E) dw_dmac_core(E) drm_kms_h=
elper(E) sha1_ssse3(E) e1000e(E) phylink(E) i2c_smbus(E)
[   88.068050]  spi_pxa2xx_core(E) igc(E) nvme_core(E) ahci(E) libahci(E) i=
ntel_ish_ipc(E) drm(E) dwc3_pci(E) intel_ishtp(E) video(E) pinctrl_alderlak=
e(E) wmi(E) pinctrl_intel(E) ax88179_178a(E) usbnet(E) mii(E) uas(E) usb_st=
orage(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[   88.181533] CPU: 17 UID: 0 PID: 3690 Comm: ip Tainted: G     U      E   =
   6.13.0-rc1-siang+ #36
[   88.190327] Tainted: [U]=3DUSER, [E]=3DUNSIGNED_MODULE
[   88.195136] Hardware name: Intel Corporation Alder Lake Client Platform/=
AlderLake-S ADP-S DDR5 UDIMM CRB, BIOS ADLSFWI1.R00.3032.B00.2201111106 01/=
11/2022
[   88.208957] RIP: 0010:remove_proc_entry+0x19a/0x1b0
[   88.213855] Code: 80 d8 5c b5 48 85 c0 48 8d 90 78 ff ff ff 48 0f 45 c2 =
49 8b 54 24 78 4c 8b 80 a0 00 00 00 48 8b 92 a0 00 00 00 e8 a6 c9 bb ff <0f=
> 0b e9 40 ff ff ff e8 aa 4b a8 00 66 2e 0f 1f 84 00 00 00 00 00
[   88.232613] RSP: 0018:ffffba1a83c1f3a8 EFLAGS: 00010282
[   88.237851] RAX: 0000000000000000 RBX: ffff8dc340294e40 RCX: 00000000000=
00000
[   88.245003] RDX: 0000000000000002 RSI: ffffffffb55a0e36 RDI: 00000000fff=
fffff
[   88.252153] RBP: ffffba1a83c1f3d8 R08: 0000000000000000 R09: ffffba1a83c=
1f210
[   88.259302] R10: ffffba1a83c1f208 R11: ffffffffb5f50ec8 R12: ffff8dc3c26=
06d80
[   88.266470] R13: ffff8dc3c2606e00 R14: 0000000000000000 R15: 00000000000=
00097
[   88.273626] FS:  00007f7018866b80(0000) GS:ffff8dcacf880000(0000) knlGS:=
0000000000000000
[   88.281734] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   88.287505] CR2: 00005603b5622d88 CR3: 0000000195582000 CR4: 00000000007=
52ef0
[   88.294663] PKRU: 55555554
[   88.297400] Call Trace:
[   88.299878]  <TASK>
[   88.302009]  ? show_regs+0x69/0x80
[   88.305444]  ? __warn+0x8d/0x140
[   88.308702]  ? remove_proc_entry+0x19a/0x1b0
[   88.312999]  ? report_bug+0x1c5/0x1d0
[   88.316692]  ? irq_work_queue+0x40/0x60
[   88.320558]  ? handle_bug+0x63/0xa0
[   88.324075]  ? exc_invalid_op+0x19/0x70
[   88.327938]  ? asm_exc_invalid_op+0x1b/0x20
[   88.332154]  ? remove_proc_entry+0x19a/0x1b0
[   88.336449]  ? remove_proc_entry+0x19a/0x1b0
[   88.340745]  unregister_irq_proc+0xe4/0x110
[   88.344960]  free_desc+0x41/0xd0
[   88.348218]  ? irq_domain_free_irqs+0x138/0x1b0
[   88.352773]  ? kfree+0x25b/0x2f0
[   88.356031]  irq_free_descs+0x4c/0x70
[   88.359720]  irq_domain_free_irqs+0x151/0x1b0
[   88.364107]  msi_domain_free_locked.part.0+0x186/0x1b0
[   88.369270]  msi_domain_free_irqs_all_locked+0x6d/0x90
[   88.374433]  pci_msi_teardown_msi_irqs+0x3f/0x50
[   88.379078]  pci_free_msi_irqs+0x12/0x40
[   88.383032]  pci_disable_msix+0x51/0x70
[   88.386894]  igc_reset_interrupt_capability+0x2c/0xc0 [igc]
ptp4l[88.192]: p[   88.392520]  __igc_open+0x356/0x630 [igc]
[   88.397927]  igc_open+0x31/0x60 [igc]
ort 1 (enp2s0): [   88.401635]  igc_xdp_set_prog+0xa0/0xf0 [igc]
[   88.407389]  igc_bpf+0x46/0x50 [igc]
SLAVE to LISTENI[   88.411012]  dev_xdp_install+0x85/0x140
[   88.416247]  ? __pfx_igc_bpf+0x10/0x10 [igc]
[   88.420546]  dev_xdp_attach+0x20f/0x5f0
[   88.424411]  dev_change_xdp_fd+0x1f3/0x230
[   88.428534]  do_setlink.constprop.0+0x695/0x11b0
[   88.433180]  ? _raw_spin_unlock+0x19/0x40
[   88.437220]  ? __nla_validate_parse+0x5a/0xe80
[   88.441694]  ? __handle_mm_fault+0xbb2/0x1060
[   88.446076]  ? ns_capable+0x2d/0x60
[   88.449592]  ? netlink_ns_capable+0x3c/0x50
[   88.453807]  rtnl_newlink+0x8bb/0xd10
[   88.457497]  ? count_memcg_events.constprop.0+0x1e/0x40
[   88.462750]  ? security_capable+0x69/0x190
[   88.466879]  ? __pfx_rtnl_newlink+0x10/0x10
[   88.471091]  rtnetlink_rcv_msg+0x35b/0x400
[   88.475212]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   88.479856]  netlink_rcv_skb+0x59/0x110
[   88.483721]  rtnetlink_rcv+0x15/0x20
[   88.487325]  netlink_unicast+0x23c/0x350
[   88.491273]  netlink_sendmsg+0x208/0x460
[   88.495228]  ____sys_sendmsg+0x3c1/0x3f0
[   88.499183]  ___sys_sendmsg+0x88/0xd0
[   88.502872]  ? debug_smp_processor_id+0x17/0x20
[   88.507426]  ? mod_objcg_state+0xb6/0x2f0
[   88.511464]  ? mod_objcg_state+0xb6/0x2f0
[   88.515502]  ? __memcg_slab_free_hook+0xdf/0x130
[   88.520147]  __sys_sendmsg+0x74/0xd0
[   88.523754]  __x64_sys_sendmsg+0x1d/0x30
[   88.527702]  x64_sys_call+0x92e/0x2140
[   88.531482]  do_syscall_64+0x4d/0x120
[   88.535170]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   88.540247] RIP: 0033:0x7f7018727b17
[   88.543853] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b9 0f 1f =
00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
[   88.562625] RSP: 002b:00007ffd53158938 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002e
[   88.570215] RAX: ffffffffffffffda RBX: 00000000675af93b RCX: 00007f70187=
27b17
[   88.577369] RDX: 0000000000000000 RSI: 00007ffd531589a0 RDI: 00000000000=
00003
[   88.584528] RBP: 0000000000000000 R08: 0000000000000001 R09: 00005603bd0=
ecd90
[   88.591686] R10: 00005603bd0ec360 R11: 0000000000000246 R12: 00000000000=
00001
[   88.598844] R13: 00007ffd53158a50 R14: 0000000000000000 R15: 00005603b55=
d8040
NG on ANNOUNCE_R[   88.606005]  </TASK>
[   88.609592] ---[ end trace 0000000000000000 ]---


2. with igc_down/igc_up, there is still link down and lost sync event,
    as shown in ptp4l log below:

ptp4l[183.164]: rms    8 max   15 freq  +1012 +/-   4 delay     8 +/-   0
ptp4l[184.164]: rms    3 max    6 freq  +1018 +/-   5 delay     8 +/-   0
ptp4l[185.164]: rms    4 max    6 freq  +1026 +/-   3 delay     8 +/-   0
[  185.998988] NET: Registered PF_ALG protocol family
ptp4l[186.064]: port 1 (enp2s0): link down
ptp4l[186.064]: port 1 (enp2s0): SLAVE to FAULTY on FAULT_DETECTED (FT_UNSP=
ECIFIED)
ptp4l[186.124]: selected local clock 22abbc.fffe.bb1234 as best master
ptp4l[186.124]: port 1 (enp2s0): assuming the grand master role
ptp4l[186.124]: port 1 (enp2s0): master state recommended in slave only mod=
e
ptp4l[186.124]: port 1 (enp2s0): defaultDS.priority1 probably misconfigured
[  188.375104] igc 0000:02:00.0 enp2s0: NIC Link is Up 1000 Mbps Full Duple=
x, Flow Control: RX/TX
ptp4l[188.896]: port 1 (enp2s0): link up
ptp4l[188.928]: port 1 (enp2s0): FAULTY to LISTENING on INIT_COMPLETE
ptp4l[192.100]: port 1 (enp2s0): new foreign master 44abbc.fffe.bb2144-1
ptp4l[194.100]: selected best master clock 44abbc.fffe.bb2144
ptp4l[194.100]: port 1 (enp2s0): LISTENING to UNCALIBRATED on RS_SLAVE
ptp4l[194.974]: port 1 (enp2s0): UNCALIBRATED to SLAVE on MASTER_CLOCK_SELE=
CTED
ptp4l[195.099]: rms  172 max  375 freq   +895 +/- 225 delay    10 +/-   2
ptp4l[196.099]: rms  126 max  245 freq   +739 +/-  98 delay    13 +/-   0
ptp4l[197.099]: rms   80 max   97 freq   +986 +/-  45 delay    13 +/-   0

Thanks & Regards
Siang

>> +		}
>> +	}
>>
>>  	return 0;
>>  }
>> --
>> 2.34.1
>>

