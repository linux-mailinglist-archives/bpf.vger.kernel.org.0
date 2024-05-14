Return-Path: <bpf+bounces-29704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92028C5869
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 17:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8CF1C222BC
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 15:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B645D17EB8B;
	Tue, 14 May 2024 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b6wzAdqH"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B43D144D0D;
	Tue, 14 May 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715698820; cv=fail; b=RyEip9+XgUfdiwLLMCgtmpl18mxPAwzZYEctBcOoaicKABzWIiL8Qx6y5h05xIHkdPu8jlGu8z64FxxfiiEGkAuy26My4TJXRk8EAJ7KRDdn3aXlW79kDhmCD6zCViuTkg85eDdncOiLpXFV9Se4sUbbgUqxsgwhLo+HGLK9/xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715698820; c=relaxed/simple;
	bh=rIBV6LSjPKtx1wojQKbbdwJW5Nsm0pt1tTdnZfKwoWE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XukSJnZgT/BH2SspOgEhZLh8M8Bltz6eEZZDQqghTxpHcgR1hCj9JQfG1HJCBfGXDtkeIMJXyIZ4Ein7GSRs7NWHnYAx1+llNiGBCQscER1OSMiYXZeArAajva5sVkaaZr0D/IFTyd9DVOwuTqDLgA1Gge6Yyp//VJhLlHcz05k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b6wzAdqH; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715698818; x=1747234818;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rIBV6LSjPKtx1wojQKbbdwJW5Nsm0pt1tTdnZfKwoWE=;
  b=b6wzAdqHo9LmMc7SkoNpxzSrRu9LeroJv+jDQcr0PPXCOGVBi18yIs6S
   zYK/eHjfgKQsat4VndXkJ5qh6z/5KHiQtRJupVgbXsiEd3mCrTYXzj4a8
   RkdFP7wgCOdD8ak63WzLsxNNJC1NkguSdc6D9WIJa9jgjvblHfXgZfXWb
   7r9g39uI3ecTsUG9bm2Ub7E8BK3cOKfISwOXYpieEFtivBIDDdBg/ujp2
   q2oPEMcCRWSK2frOKEjskA5Ddit9lcQhTYoQO1Z+8tthPi/J4ejHI7vDx
   EAUAsKYF4TzLTZmkM7TgdVU85OdjSgUzuttVaaTIZdl7O8g+g4+q8hxJg
   w==;
X-CSE-ConnectionGUID: HfFKUgb/RxuSAgGfWCRwBA==
X-CSE-MsgGUID: fH/fqSrgSES2n0CGGaJkZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="29207056"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="29207056"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 08:00:16 -0700
X-CSE-ConnectionGUID: DYe7sj9tSyqMuqY7lv7APQ==
X-CSE-MsgGUID: v0Vo92zRSTuwwBc5BBGtIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30546110"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 08:00:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 08:00:15 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 08:00:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 08:00:14 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 08:00:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlR58cyhXwCA19t2tfkGsAFdeZBoYwprGUbfkyqypRzVzQFmVyDcZyBPRnSmUmPC8pAigzmWtkZcVcQSXZILvTwnWkx6bjdE4tV3mT4EkLYRMW7G2eLqOPtNqzYXmjKFytHFijQCNGHPXCmMBwZKqIErp67UTCzoSJR5uvaxpPeTWpoeERdDffbTNY1ZT9s1Ri1Us+Wq+F5eHq3Bt01hopkqUrY0BjXuNuQNjio61+A4+4C04xQa+PDKfa6G9lOzuqscxt7NzNQks9fTGlpNvOn0fuv4nOCaN5VKGj+rewE+gmzjB+1cRl9YLcxFxLm3tOmaieBV8anID9TzOvRQHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIe+F1T4nOJplS5i7BjycX3dxlI9Prs7JtkCvIjCums=;
 b=hbkBfcSzc1jS7tANhsw9PmY+9+IPTK2aaV3jFhaAp0emDSBcfrZfCSuPRn8A9Gwvi+2kDaNNg3VNAEWjBXLUybtX4u8I6kfglaEcSVf/cPbx3U0m/P2fHj+GZUjfMtFVE+2mDWgFxzOdSrLrWHS6LyRoTs6nOQZ4VnMt6Mmu5xP/ol2IGzNxJDO91/noMFxTiXHNl5vUhKVhL0xq30CRhOoU2XrNWRPwHVUTdBF+mhw/oboSY02lAqF7RVGQOwDTC3eJKZKh9UpM2iSKjwX+jQ6V2u2MXjwN9F23NnNJ3VpbSETx5jUCIBUOgXNSDo9RAK8SRJKB6OIIhu+C21Wu2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by CY8PR11MB6939.namprd11.prod.outlook.com (2603:10b6:930:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 15:00:13 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%5]) with mapi id 15.20.7544.041; Tue, 14 May 2024
 15:00:12 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC: Jesper Dangaard Brouer <hawk@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Richard Cochran <richardcochran@gmail.com>, "John
 Fastabend" <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, Eric Dumazet <edumazet@google.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net-next v2 1/1] net: intel: Use *-y
 instead of *-objs in Makefile
Thread-Topic: [Intel-wired-lan] [PATCH net-next v2 1/1] net: intel: Use *-y
 instead of *-objs in Makefile
Thread-Index: AQHaoXHjkPUX/AAaokuzOzHnGTI1hLGW24ng
Date: Tue, 14 May 2024 15:00:12 +0000
Message-ID: <CYYPR11MB8429506961A4010D31B6D674BDE32@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240508180057.1947637-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240508180057.1947637-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|CY8PR11MB6939:EE_
x-ms-office365-filtering-correlation-id: c831c0a0-10b3-438b-7349-08dc74268e8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?4EO0Gio/ezpze+FFb9dZ4Z+F5uufYVyxnN02wWQI7UHYDu4NoJeJ05m5ZTNL?=
 =?us-ascii?Q?hvWBXSrmUK2ulzPnPh4DXyaH74WwnoexGxqt/al3UU7Nw6FREXKVlQEUY8BE?=
 =?us-ascii?Q?akwU30gGyVAMSu8MPafcplNsG6rGOQStug9Jj//2ZD1x5y9Jz9LBu97GF5Ya?=
 =?us-ascii?Q?AOP7PC2LMqSCQte22+uN3qnb5p0vk+qV/QQw39tpVY06VGzoAVYkG3ClmU1A?=
 =?us-ascii?Q?skgd1xlb7jvz79c5mQaNC7f55Lu5TA1XLamowo/+D1Igj5DF+G54J8Hr02HO?=
 =?us-ascii?Q?L/V4NIRLm//m0X1FYZ1EnSupUprZYfy+wLRfXGxD1dIkR6ew1U7M19GEEr3/?=
 =?us-ascii?Q?kgp96DHpuKNyxypXGkfs1/C/n0fwCVq96MCgE3ImAMZofApJ/570C2T0BVrU?=
 =?us-ascii?Q?IH08JARFzgq35kAvL1Cr5P05NEfTJNP6t5aVTqcoH3UYzn7Y8Vgrc+5IJvpO?=
 =?us-ascii?Q?3h2nNfxeIJU5mpkxZ40WVKCYSUwK6FPXHffGwFcuXOanTjf1SKHM2gLjUf8r?=
 =?us-ascii?Q?nk4IdfKXVMPdP2Nl27eqnZ/1KJjoZmEHQmSZe2Vrmdbm9nllgkRC5M3mC1Ny?=
 =?us-ascii?Q?onUFddy3+CSEkUCF05ZFLo5K8EusY+7m1hsFKBBhzJEJJjLlbaDCK0ZFB6BM?=
 =?us-ascii?Q?hL7+sK5ppmmj5uyBMAc2Q1GHFzMhYejEbHsAKV0L0Yceu7X/PPfzYkBrllJQ?=
 =?us-ascii?Q?czcU/i85eaU6NgiIT1wgmCbi5hH0pYJNVxEw/KgAjtkKM43lhzH5oxRQCAIA?=
 =?us-ascii?Q?w6pMxZw3LiUE5dIooJVKztidUioIU2O26KY1Y0cMkeZzaY7i/XBqMqYFFQSh?=
 =?us-ascii?Q?gVg36usqK1Y+Y0hPlt+847DUhzXimmfVRSGnbHhRsPMVPAMSGLP/ihgmZvkG?=
 =?us-ascii?Q?VqMqAbcEzkfZ2aYRdRwE6xP5lxtsyRKNFrAO2imTOYBkDFWlYwV3BPyB/NoW?=
 =?us-ascii?Q?pd7t2CwO0ka4IPq75AFsMlFjkBip1YmOd11z0zSGoRe0J8A20cUAnsPmwIXT?=
 =?us-ascii?Q?/l4VFgWDUgNUmDHSv5V0z2wkj5ao8LM52/i90Vz1BiuP+qAC7f0xrIxOb6Fw?=
 =?us-ascii?Q?CjSUTTPMOeaAD7YcJROR63CJ9wT0LFl8JBlUoGcgdQO97yEphr8Fewb4b83s?=
 =?us-ascii?Q?ueX7kOm7dHgs1ZJFpg9rsx4dlIu2+NY4Mq7YSRgX87sYYdd/MvkAp7FuLKfD?=
 =?us-ascii?Q?eYVeTkfXEdYJy6ozCFTF9NnYyw88ra81hxpGmmQqjrA6PrOaY3rpWkV6hZgh?=
 =?us-ascii?Q?GFCq0C8wRiTwla9v/6qYNaf9dvqHcyhEjTDR5BGEGyiy60nhv4KZAOIuMrjX?=
 =?us-ascii?Q?+D8waX4dI5e51P6qtHoMCAr1HnQyTfO6uPlIT66PWYqs3Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XfFBuWFw2IqQ7NVvDJXHgKLIou3Insk5j5ya9yRbIzhDJSxZsR7MegW/oPj6?=
 =?us-ascii?Q?kTLFekYiRrD6G7E97z5vaMEDXv2fWgjt0bJ4Lqv9UxetbAADrU8HeLC+bQw6?=
 =?us-ascii?Q?okwZYcmN0gFIKs6lMT/dL36kj7LdXiae8OfGQFHrxE3YxtsEMomiW9MzsZrl?=
 =?us-ascii?Q?17lUFohWsrMyKBpxwfUnyEn6PbP5U1Lo4AQqDdEyjVMWg8Hesv3TJ7E5IHpD?=
 =?us-ascii?Q?ZxodNNfvD3kELklKA2Wrgl+mh+bf/40/ij7PHK0SG9ZdsmXzovnRm1m3VZPX?=
 =?us-ascii?Q?FhmwOpbF/knLsrH35EzVtNSYOeCDImCurOBwWkDbpgPeD/nmvV+rnQrZdyRC?=
 =?us-ascii?Q?eE/wC3wnoxuoO9q+cvRUTHFEQEVlAvlTeFOX4I4BVmK5Ks+/CJ5vy6AKK5+6?=
 =?us-ascii?Q?g4D+O8HZYrf8HY6oPHj8h9Bg5PhandlCiXj6Eh7vxF2X7NSaTVPG6zHxflpy?=
 =?us-ascii?Q?Ky6SCQ5JDkCFcDAnyDfFI00H47NktdPlMIo/pdhJwjmvu7ciNe2BgBM1wbs6?=
 =?us-ascii?Q?ikSQrytIAR2H3031RWe4RGw+1JI8APiMDXuvibNtFZNHayXMcnWM1ORzAEf3?=
 =?us-ascii?Q?QXoDFCtFiGRAMliSc2LjPHOwcsDY2a6hTWnNmEsb2qFdzAtMb2sG7MHwCgRE?=
 =?us-ascii?Q?PVzYTvsPSP67fyalrWiilqLBYyMnlbiSUkw3NpdOgt1WanxuZVKtvQF3MwJh?=
 =?us-ascii?Q?zvI9ifbmDcowfQxvxNDIk1qoHp5DcHXFcdKm/65TOV+sweZhNixYxC/8tMTP?=
 =?us-ascii?Q?fsPl6wsyaqnqvO9BUAViaeAk+q+CopOT/zcURI5kuQg6qQpiCCCsuU9S1jw+?=
 =?us-ascii?Q?fX96oafABvRmjF41kGaMs25uveccXgJeAbIq8g3bSAb/z5YdprR0E920x8/C?=
 =?us-ascii?Q?J16Ii7TpYZwbMhET+1IeGKSn49+zU7t5cZeSsOOco4W59PXMP134N22p7rzs?=
 =?us-ascii?Q?6j1iZL6+hC1USKd3Es6s84wRL0QzRn2oI9l/AvB9POCxdXH3hKRiYy63n9Mu?=
 =?us-ascii?Q?7aZI4CgLrGSok/fYMTd1nzckz0nW00kQuZAVgNutMlL/T5rQQ5KguP18ul0Y?=
 =?us-ascii?Q?vM27l8Wwi6D9SvEaVtrhj1svR3XZoyWvKTGG5sl4iBiWrwkBAQrjNyPp0PlU?=
 =?us-ascii?Q?tKdEtTHavZzCxmbRzkhl04ehhVFSsaRiE21gairkcYAbNrjaCLYG0hqecfsJ?=
 =?us-ascii?Q?gFoKT2WzE8diCgBT0B2zMOCtaAZnirnaYJdvPQ7I40qlMv1XYK6YSc2liLky?=
 =?us-ascii?Q?3tjAmwHo8wikw3T4LrKrHCxZw3jHuRwC6GWtBplFeW6gHlw4MRROBiaaRFra?=
 =?us-ascii?Q?vVLkyfY/DjSyZ41Qh/mUSczFgyIqhBVafaIQti0MtoVDKi3K9o+HROoZim4a?=
 =?us-ascii?Q?9F2R+r9P4kiFTZAyr+3MAP3DEQaf20Gd6J8AzNAwo84gfca7iw5LUlopC21D?=
 =?us-ascii?Q?GPg14xyQhfbmlWjszMnGmodb4e4AI7aIyWpby7mZzFQ3TNEWjRAAHmH7FnLo?=
 =?us-ascii?Q?X3QjC0p5+SXcEz1skOp7ElV3AswDYKOFe9up7tqh6KyUzOvPewc0WOJLwF4f?=
 =?us-ascii?Q?uEeXt5r710cT4OPQiTjRQ3OCq7ZPy6nhjLXSG7/E7ZtbOrCoFSi0U1CEeHUr?=
 =?us-ascii?Q?aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c831c0a0-10b3-438b-7349-08dc74268e8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 15:00:12.8531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tXkzzMIpb1ZaWd/M9ApnTtjHW1Waxv0WvN25YYbDBOYjavoa04OZFjfB0+7stMFqq4QOqHjZokSEr1S3MT3Br7AjRtgJtz2raSpC+zpF/J+755dyKc7cLPFaASYiL2vZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6939
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
ndy Shevchenko
> Sent: Wednesday, May 8, 2024 11:30 PM
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; intel-wired-lan@=
lists.osuosl.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; bpf=
@vger.kernel.org
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>; Daniel Borkmann <daniel@iog=
earbox.net>; Richard Cochran <richardcochran@gmail.com>; John Fastabend <jo=
hn.fastabend@gmail.com>; Alexei Starovoitov <ast@kernel.org>; Loktionov, Al=
eksandr <aleksandr.loktionov@intel.com>; Lobakin, Aleksander <aleksander.lo=
bakin@intel.com>; Eric Dumazet <edumazet@google.com>; Nguyen, Anthony L <an=
thony.l.nguyen@intel.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <p=
abeni@redhat.com>; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH net-next v2 1/1] net: intel: Use *-y in=
stead of *-objs in Makefile
>
> *-objs suffix is reserved rather for (user-space) host programs while usu=
ally *-y suffix is used for kernel drivers (although *-objs works for that =
purpose for now).
>
> Let's correct the old usages of *-objs in Makefiles.
>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: added tags (Olek, Aleksandr), fixed misplaced line in one case (LKP)
>  drivers/net/ethernet/intel/e1000/Makefile   | 2 +-
>  drivers/net/ethernet/intel/e1000e/Makefile  | 7 +++----
>  drivers/net/ethernet/intel/i40e/Makefile    | 2 +-
>  drivers/net/ethernet/intel/iavf/Makefile    | 5 ++---
>  drivers/net/ethernet/intel/igb/Makefile     | 6 +++---
>  drivers/net/ethernet/intel/igbvf/Makefile   | 6 +-----
>  drivers/net/ethernet/intel/igc/Makefile     | 6 +++---
>  drivers/net/ethernet/intel/ixgbe/Makefile   | 8 ++++----
>  drivers/net/ethernet/intel/ixgbevf/Makefile | 6 +-----  drivers/net/ethe=
rnet/intel/libeth/Makefile  | 2 +-
>  drivers/net/ethernet/intel/libie/Makefile   | 2 +-
>  11 files changed, 21 insertions(+), 31 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


