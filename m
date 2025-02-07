Return-Path: <bpf+bounces-50772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23484A2C54E
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 15:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C7618885B3
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 14:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943AE23FC52;
	Fri,  7 Feb 2025 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KpTOFOPk"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC4921E08D;
	Fri,  7 Feb 2025 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938629; cv=fail; b=Yv416boGx8ICVcNL8q8Ar4ed6pIpSLR7h9tpxbuh8/RSmiWVsQ5ZHoAiUw9Hfi7xx/u2t6hDL62+XO1dH5QB1KW6CAqZCoXIkEIOB1eStyQnYuu3ZHMWflPwluX29YQdQFSFpf/emfoO8Isxr1+IZNddKiwBDVAaWTPFm11mK+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938629; c=relaxed/simple;
	bh=NEQef56yIKEFJVV/7+rRfdFUvsXcLkQ+/gP1B+xMMAA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jwktbg/gHC0lcBAYpus97ZXnLc5Jlomd9MwYuXRyun8/mtSmwb1XCdm+SDjXAjFRkziKrVWNuA9E92PUaljOIYrtssSHKYjlKMKGaH4n4xuvEx3DhJl2HnLAD/mKRaofVGiRov5R5sZHK/j7CNoTpUi7jJhTkaerJHZR2I7IkOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KpTOFOPk; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738938627; x=1770474627;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NEQef56yIKEFJVV/7+rRfdFUvsXcLkQ+/gP1B+xMMAA=;
  b=KpTOFOPk+UxIaCPJKYthDSPMJXTEohR8fNdzEXzmATpmzpq0vR6qxFcp
   5g9DtNUxpoPJdXtg5PozWj89KpW74W2zZS955cDgH2+Kgrxg6WrytGvwv
   KRKGLyfpUx2LZWxkeYHZod7Hky7L8850ACnBZoT8urHntR4KCduM2VPIN
   ovWTQlz95OqSeuHRPc19Phf8B3Svs0P5NOBcZAYlyp+rgrxV1mo1a6PwE
   UgkF9+psDg93zp3FtpAiRJtDkMOJchlfEGlxTn9ovabb/ZltmJF4DGtyP
   8vyl0mOTqES0sE1oE/E8Jg0xSL3MdOxBH60Qz8ltl7R1OMVbzk/lzAU51
   A==;
X-CSE-ConnectionGUID: tNuTaoRyQqSunGAfZXw9bg==
X-CSE-MsgGUID: x5UGZWILSPuZCJ6HoVrM1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="50218884"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="50218884"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 06:30:18 -0800
X-CSE-ConnectionGUID: eZ5y5owbRGGMR9idiuCcNQ==
X-CSE-MsgGUID: u5YLIjBkSJ+v/+Pxa66O8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116146535"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2025 06:30:15 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 06:30:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 06:30:14 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 06:30:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mq8h8GA5zFkviEGCoFph8v7+zAkDATwDm+HjFPOympw5C/iKGDEtojjRqKlVi14HIEZ+c5Q8OlFUTaj9hVuEOHJZly6NwJuvnM1RW0eQjmjNWoZI7/UqUMiVeiKgYslHli4MTFRqqtk1vanpoYqMjsUFgDkUq3y5A/yZZa6RyzbEFehISrNf71hCD1Cn7wvT0hwATogLySQ3IucPtyEn7r+Xf1AZe6X2CgyR9Jb++7hCygUxWF38rXS2lTK8RH/zsBvMRqnu4FwZM3KRGtDmxSXqx5Oz0e6KzcNZzNlz21hY/QyE+9DawcBXP5xhhptJwNP9UZf+Rqy4y2UKJKuwGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfjROpaZSgsVlv9+Fx91/FaLBuLBchiSiT2zqIRiGBI=;
 b=H3+5kdLVHnTsgusfILpmqgdsFbAfZPuHX3kwSp9QjONmxiQFycsBaPs17NaA49u6ACK/GxBIJpNwTkEInJ3o+GQ1QFBwhADOPcr4IYVPTZGHqt12UedFyngxP80BFXcUSV+DOtkwwNLbJjKB2ftmdTTFLjYPiDDYFlGq/zIHXOrmBku/BaKYw8Yr6Mbnw0gDiZfxW95pFkIBVs+f9i3PaXYKhsfMwhjb7qTlSPkFo6FKFNQNkHC8vTh5w4FxhBY1YBgjWBthwPbAJ1TczpyvGSGEesYfQEPgEzmCls3qsdWMKXyfn8PDXjT8i7mGb2WchSeubyQbByrtqHtWIOLTvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6289.namprd11.prod.outlook.com (2603:10b6:208:3e7::9)
 by SA1PR11MB8253.namprd11.prod.outlook.com (2603:10b6:806:250::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 14:30:11 +0000
Received: from IA1PR11MB6289.namprd11.prod.outlook.com
 ([fe80::ec3c:2931:b0e8:c5b5]) by IA1PR11MB6289.namprd11.prod.outlook.com
 ([fe80::ec3c:2931:b0e8:c5b5%4]) with mapi id 15.20.8422.009; Fri, 7 Feb 2025
 14:30:11 +0000
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
Subject: RE: [RFC PATCH net 1/1] net: check transport_header before adding
 offset
Thread-Topic: [RFC PATCH net 1/1] net: check transport_header before adding
 offset
Thread-Index: AQHbeMHc0THX0Up++Eu0q/bXqBFYb7M75/qg
Date: Fri, 7 Feb 2025 14:30:11 +0000
Message-ID: <IA1PR11MB6289CFC1875FB14C00F31FB689F12@IA1PR11MB6289.namprd11.prod.outlook.com>
References: <20250206180551.1716413-1-sreedevi.joshi@intel.com>
 <20250206180551.1716413-2-sreedevi.joshi@intel.com>
In-Reply-To: <20250206180551.1716413-2-sreedevi.joshi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6289:EE_|SA1PR11MB8253:EE_
x-ms-office365-filtering-correlation-id: 09df5cda-253e-4213-0b6d-08dd4783edc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?oo5VgUP20LtgPfWty0ayxDi+V+5sgxsUO5W0h6KKsXx4u4hhsFr7XHV0cJ1W?=
 =?us-ascii?Q?D0QhR8TZnzBZ2Fih36iXYIxAOkVB+5bmF8BVv1EMMzQcpQYhsiSKx8753WlR?=
 =?us-ascii?Q?W2BvwXkWd8o8VTeGSHsyy6NhYpXFMPu6pRMmTNt0Hu/KJhzB0tEyA9WZOf8J?=
 =?us-ascii?Q?Uc/u9/NQMKD/6ppYEYyf6f+t3JzT4CBJdVcu9OlzmNGnoGkNKedaWDZloSS5?=
 =?us-ascii?Q?dBHEUagTDja1NweyR7KM3bvbQTLemzRusgwCYSeaEtoYcB89+RU7Rzx1AAiI?=
 =?us-ascii?Q?lJewi+FkXlhVHg3G0jZS9MO/DuW5n0pI6oh1Es94ZO0EdMpbrCVoYj0U+Rm/?=
 =?us-ascii?Q?WIJiRWZvTrBjzzx2kr70R31hkYSeznzJ0CXkAEVQfPrx98yJIpExxMowPgoS?=
 =?us-ascii?Q?XpZkYYAuI+jV8ip7KVaDyLyTwWG53kRlISIha0H100dYJHKZvawaDAnfeiiQ?=
 =?us-ascii?Q?fluzaOyS8fgZPP0u06UEguPJ8R/BeDghcrkl1GDPXUhz+TzDx1aVEQZkPQ6q?=
 =?us-ascii?Q?zJr1AQfNSfMZ0rYPOhegaWBwwqprWQtwX3g2MXgGHE7NqatPVLIs6wZCx4f5?=
 =?us-ascii?Q?cj2RgWc25eGBffDkZJto40ADicGnv6jPYoaAbtZtR76BIvdfYDF8Bo8CcvcU?=
 =?us-ascii?Q?cyJOOX7pDfqGDXVgaeFqXNo3HBCGlKOHBIiXF2I4ZCe+p2v51T20Y17iR++Y?=
 =?us-ascii?Q?sRSeFgIQ/mHBj7tlaQamCaKkLTBYJoVjSwfftD6X1+3Vx20/QW4pk3pPwuYx?=
 =?us-ascii?Q?PJgfnF3H803oYyJhhH7f1OtEQbrTNqmn1+T8wHV0J9sQ6DRuNIkcJHtDaC/r?=
 =?us-ascii?Q?QNHGBWezQO9/eH3uwswD0sHsNLnkeO4uLDBSrcD+8fZFy/ut5XpDgNj9AOqO?=
 =?us-ascii?Q?RTtOyMhAWuH21V7NfFgztCzXknkqOZiYSPnBsiJEr8CjO5Mqw0m9q3A3NwKw?=
 =?us-ascii?Q?c7Q3rW62e/A4hFtXguXGIHi2hMwaVTSJjferusOMjrKioAidYvm+KO0rlKx1?=
 =?us-ascii?Q?0TeB+tgT+mMJ3uiLeMfEDa3zZQFejAHE3nZxkzQ4jQcExlEKimztBbejvpp7?=
 =?us-ascii?Q?1yYxkfFdcWsJFd9BvPc+EVXUcmnqYaCjexyb0RP0xpjvDmAHKcPjU5Rtp9Th?=
 =?us-ascii?Q?OO4kjyQP2AWj6XztPTdQhEWp1J6uz4s4zFE4Qvc1+TdcaI6zDJQkBoF9TAtN?=
 =?us-ascii?Q?95JbbJvZ66wTC8j9A4DystZn0KLE0oHMLTqXmlNDbExrYv99k09anPeEEYGc?=
 =?us-ascii?Q?kdWz76K3C4wnlXsOrX3MByyyzl9FN0NtlF4cx186N229GQbPS2DPsSdL8SN/?=
 =?us-ascii?Q?xLYOQCCl3VmKepErW/LION1jvt4rbKXoVeu97aowPbVqyoqi/slIOP+or8uQ?=
 =?us-ascii?Q?0a2nqVrl2ytU2Z16uQEwlaATj3Kha82hYP5+1pcWoiQUwtKaaaqBedlqbkZN?=
 =?us-ascii?Q?kje4h1L3AItAaJDD+L3cyijKV5j59x4N?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MwuU0gGCdJyfvTuevyRA8ZMq3T4UaomFU5fM2G50R3STJja54/spb9jau+mp?=
 =?us-ascii?Q?654kFi3NrnkEjeQShlGyB6fK8ne81qqbslK0n8QlnY2S5NF8l2ZadR5czX0A?=
 =?us-ascii?Q?gIDnB4x88Q22yaiMzPjfLLmT1wOpqiPTl2/2ruxdQsCk2kOzIoSPRi2mW7ef?=
 =?us-ascii?Q?XNEO2/i1ibYPu7cxb16dDJrppPSQ1SYjxbEm+K9R5bq1y5n/mwg/gSXORcV+?=
 =?us-ascii?Q?HjpIG/zy4QJd+aBoiU86V4/JZt8RH5awtXEvlTCkpS7RX7YZITSsKNRFHhUK?=
 =?us-ascii?Q?m6h2hVz4GKZ8oteExvSlErXXeRy/dyLT+YOKvgnbJrA+12ksmr06nCoQiNqZ?=
 =?us-ascii?Q?b8ZP6Nlqf3hsdLjSTiNGe+TA2rDq4Y+oiu21vKh5XNa5XCnPV9CIkmRgID4q?=
 =?us-ascii?Q?r5GsAVd4dqXk/vaTEOGNFyHSKefljWKEpuqPr4dWJmBX3L+d9DtO1Rq/SVcb?=
 =?us-ascii?Q?Mjy81sdwa3/0RT4ZqAn4ZALXZLK9rwrTf5Txyp2eUUesR6oaWlh3RlQvv7/e?=
 =?us-ascii?Q?lIB1CYGPdgnGuiV4UTtwUiqDEzFj2VNrCFmPeNL+zVXk2mRCDwr0U9y4whIR?=
 =?us-ascii?Q?hRO+1fKh5pOMbbkeI67lc/tH9KRGBbI1oqyBp/ypwjLA8//Ru0e976ZmIgUs?=
 =?us-ascii?Q?QPSn79rVIwWAvEGTFDzaSPdfpRVta20Zg1YbTEtgTQc/5gKt7PfWyvkocOag?=
 =?us-ascii?Q?0sKTx1S87BaMoZ1/Kxh/afknvBcZ1Y9LPzaPYmRLd2lcwKx/8n08PtNNEPKd?=
 =?us-ascii?Q?F16K+Ocqw64N1nos9miHmVSERkYihCvVnS0S89BAJAZoganqwGZm3Ftg8cU1?=
 =?us-ascii?Q?DMapgeTH+JT0w3kDtj350vblCC31brhmYIfH08c+7a+FQAlgVo9nQOs95REu?=
 =?us-ascii?Q?UNqlz6NmxK1wxe0e4to+8rSOcZGNqoDFLyJkUdLDNy2ZvaQwHrnUE4KYrZP2?=
 =?us-ascii?Q?7OinzrBrMEG0gqLI1pEOZWJK27awJ5FvcJPrgMgoV4YFFmJdsM2iULEo/vEm?=
 =?us-ascii?Q?7WDAeDF9J1SOdWkRTsH7+wi1jysN0CVbzK7AbDAX18Gn3UpW6RcmhUWIeqSp?=
 =?us-ascii?Q?dhdeGLzaJu0fgHy4H3smjsA5GYQRPiYzcYz7q6S3AxbLGOXcGXcKP6CYNuiq?=
 =?us-ascii?Q?tSnedQvPbEyL6OaAimyb9UMrQw2Yt4evycBeaeFQ60eMBZjRh3S6knLKdEHg?=
 =?us-ascii?Q?ieDFOVcrxUKUnR4WHsiLhtXzPeYMac+VXqAbXoVEe31/udNEysq4Y3OwwKJQ?=
 =?us-ascii?Q?Y3mkroy2SzWzDOousl88E5dydXkyXp1wW3bBUBNsWtlgODiPkZQ4jzM0/quB?=
 =?us-ascii?Q?/m7Dl/3E/4PVYiWXtVeUQalzxC5s+Fzhgb95oF9cB7/wZbRTwp0PbSthcIBI?=
 =?us-ascii?Q?jCwua8NyMaw2xUzE7mozYw4wTmFKgBrIVnyPUUSbAIV5jt7bt1/4yrz2X99K?=
 =?us-ascii?Q?AAv88l2mJYMq2gb+OKAH/s8mrG5mrpLV2TU6C7BFGiKR8RcBtQLbX6eCskZc?=
 =?us-ascii?Q?Du5AeUxFAm5nqyFPHIlTqOLOv91cDIH0GJgaCPrZWoqebWIKStM3RF8d0KmB?=
 =?us-ascii?Q?iufGryNEyiutePT7InSrrDKPKDDNMMIuyO5nhbA/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 09df5cda-253e-4213-0b6d-08dd4783edc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 14:30:11.1956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IbIT02E1HSFiAGRTlOAp/88rcDW3aezciXVSB7l6+EUvX5F3s7mmcWu/mLmCIF6aDEi0gFDKCDLFiuh+z48kD4b0cN3RN3iDARGsdCtU/ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8253
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
> Subject: [RFC PATCH net 1/1] net: check transport_header before adding of=
fset
>=20
> From: Sreedevi Joshi <sreedevi.joshi@intel.com>
>=20
> skb_headers_offset_update() adds offset to the transport_header
> of skb without checking if it was set. When the transport header
> is not set, it's value is 65535. Adding offset to this causes it to
> roll over and makes the transport_header value to be less than
> network_header.
> When a tc ingress hook is attached and it invokes bpf_skb_change_tail()
> (to strip off extra bytes at the end of packet or to attach some
> extra bytes), the logic in __bpf_skb_change_tail() that calculates
> the min_len fails due to the transport_header being incorrectly set.
>=20
> This issue was discovered when testing with veth interface with both xdp =
and
> tc ingress hooks are attached. veth_convert_skb_to_xdp_buff() calls
> skb_pp_cow_data() and it results in this function being called. Since
> transport_header is incremented without checking, it results in the condi=
tion
> where transport_header < network_header. __netif_receive_skb_core() when =
it
> receives this skb, skips reset of the transport header as it is already s=
et.
>=20
> This is specific to XDP path. When there is no XDP hook, the logic takes =
a
> different route (__netif_rx()) and the reset of the transport header happ=
ens in
> __netif_receive_skb_core() before it reaches tc ingress hook.
>=20
> Fixes: f5b1729443fd ("net: Add skb_headers_offset_update helper function.=
")
> Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
> ---
>  net/core/skbuff.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index a441613a1e6c..79b10abd95f1 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -2098,7 +2098,8 @@ void skb_headers_offset_update(struct sk_buff *skb,=
 int off)
>  	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL)
>  		skb->csum_start +=3D off;
>  	/* {transport,network,mac}_header and tail are relative to skb->head */
> -	skb->transport_header +=3D off;
> +	if (skb_transport_header_was_set(skb))
> +		skb->transport_header +=3D off;
>  	skb->network_header   +=3D off;
>  	if (skb_mac_header_was_set(skb))
>  		skb->mac_header +=3D off;
> --
> 2.25.1

[] resending due to mail server issues.

