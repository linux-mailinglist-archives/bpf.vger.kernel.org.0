Return-Path: <bpf+bounces-46128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90789E4C6A
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 03:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE24A18818DC
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 02:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D0C185955;
	Thu,  5 Dec 2024 02:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ThaaOMfu"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F042B9B7;
	Thu,  5 Dec 2024 02:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733366714; cv=fail; b=srmHf4VbJzx1R5SPCAH8+A59oFMp7fu/FYZiHox8BLEGtOkcCqUaExchYZQhUvahCvh1/a5vqjCxEpmTuvNlYjpDNkK2oocnLdMvX604R8Vhibg6zY9gn/ZgcI/ZCMF3Ta8FaNRvaWa1O8Vei6D/XXQB2i2HSGHoEyN3jjd87WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733366714; c=relaxed/simple;
	bh=2BX+a03YSOWwa5L3Q+MioDY0SalLwrd8PGINkwYybu0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IHLQp10zllWZ9j+5bVUoeId28YyEfWk40M5N9DKgLF80W/4MAtwGCcLvbx78Nt2REr9ZQLIt0Ae7l3qHVIIekAq17XKEPdUcOhxgn1FujH8bnFqQSl4NReO9azUjKQq22An9QGMCLgqIiVjnJDUah3Rh5aLJH3NjJgqXTF9VVmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ThaaOMfu; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733366712; x=1764902712;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2BX+a03YSOWwa5L3Q+MioDY0SalLwrd8PGINkwYybu0=;
  b=ThaaOMfuhfkbX2qJ7XAKkLwjL5l3dL73jHN1nPdHzT9DvBpj9EKJ6R/n
   WAT40KalNP6lTt3AnVXxkIZEGw2ouNYAAYs6BNqpIryZIgxPGQqT7cZ55
   tmItMsBNSNIA8veEHWtroLWJ4rcextBKIOreDvQgvi/b01qV6eI/TBOdN
   FnhHZ1+lRg0Tn6liGpI9ij4m0KWT9PqO58/bZcUZt5t5p5I1N0wGh3sps
   k44gFz+vFnV0zncGgO9jMB7DB1qeBMw7Ianrm93+vKDlSPFqLvbC/bzmL
   pUf2utvlQVwRPTHO8qpcbUQJpHmdKtLYXVQcdml9WzGN8nOdNnviz7KwJ
   g==;
X-CSE-ConnectionGUID: /aqb4rCaSVyVWX6j0mJkuw==
X-CSE-MsgGUID: mqLq5EYkTUS12Uf86g6s1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="32998514"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="32998514"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 18:45:06 -0800
X-CSE-ConnectionGUID: uAc/ZB04SIK8gckAGpw+Nw==
X-CSE-MsgGUID: Xe3y4JIjSzKnMdhiQuJ4Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="93797365"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2024 18:45:06 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Dec 2024 18:45:05 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Dec 2024 18:45:05 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Dec 2024 18:45:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJmA3u3O2IYO7K6tj7E7BzEspjFHO6BPdXN9AEUbNWcIZWE8hUzxue2b2REZ8wh0yHFFiGh1esjeRi9GdLgCz6vmLk6mranb8porWceqZ/puvSRBbq6XInqn3xd4IiQkHHVHXENbIfxEW7ZfLP7VHSmx0+Fk7hB9f+B6QsbDuTxznUvwnYJZ+BVQuAQwv3ft2TO2tIPLvIue1H+g7jDoyk/mcp94o6G/2el8R+FBOgfDkhcXOZwucoeiDzsu+g3mZssuN86KNZ45guckBrmxdJfj9iq7QpxuYz+R7x9l5e70GLIUbUBogoQKk4or3jnhIj2EgR2eFqN6hnBH1rypsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BX+a03YSOWwa5L3Q+MioDY0SalLwrd8PGINkwYybu0=;
 b=rSO7TpMDOYHQ2wXqQammO5dfmoTlGJYXxYZc2OuTpePmLeF9Jfqh37UTqaDt0g+Ms0a29hi+hzH1GRrg8tQCelrelFaro1ZhKOcI+mht7BN+LomihV0ITkAbBOMAIw2q6L6Vr+hXEeZ09aO0Eh4prIrKk+1CLnvSb4BnLYG/OpIoL6aYYK0teAr600hcQo2reCfDg1O3oHIwlHClIq+mD8uNVZytIYoi+J5b/TYMeKa/b6uSOPgjv102lO7eVyNSDJI7oSzBrsTE+WXebvowRFiP9NaS4igc6XfY6wNtse8zXjQD8GPEO9yDnH/kV/HcjgxKMGvIioE4Z8L+wwUzrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by CY5PR11MB6487.namprd11.prod.outlook.com (2603:10b6:930:31::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 02:45:02 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%7]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 02:45:01 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: "Gomes, Vinicius" <vinicius.gomes@intel.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Richard
 Cochran" <richardcochran@gmail.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH iwl-next 1/1] igc: Improve XDP_SETUP_PROG process
Thread-Topic: [PATCH iwl-next 1/1] igc: Improve XDP_SETUP_PROG process
Thread-Index: AQHbRkSDFElQ1g4Y8Uq3OPOpHrjao7LWz16AgAAQZJA=
Date: Thu, 5 Dec 2024 02:45:01 +0000
Message-ID: <PH0PR11MB5830F1658AB3F74BBA2C9634D8302@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20241204120233.3148482-1-yoong.siang.song@intel.com>
 <87wmgfvua8.fsf@intel.com>
In-Reply-To: <87wmgfvua8.fsf@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|CY5PR11MB6487:EE_
x-ms-office365-filtering-correlation-id: f8923717-2700-4fcb-3b10-08dd14d6d0ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?5TBLLZoq+5obfM++yYAeWliUcrg/YxyAs5YsaRC6sHbrBILq6dWUUwBNBlMm?=
 =?us-ascii?Q?EnXMi7QqDQJob9cHqb66uBdVZk/ZR1J2gGt1RdrCOwi9UWqUPXM0YI81eLJj?=
 =?us-ascii?Q?qTJRjfNw1NJkrKno5D8Y3CRLFzHzHaAUoldK6rr0Kv/8Ts9IPm1699Y4Osdo?=
 =?us-ascii?Q?sx+hSfdEaLxHjNrsZhgvOzwydQR6EzRbWDqBxEndNLOBu157QDModfMz+Otq?=
 =?us-ascii?Q?PD0rIF8LS4r5CghuxMPp1ylzfC9gDWhMpHbz2KTUvITHw244S0By11q/DvmF?=
 =?us-ascii?Q?GazecKX/bPKFls8Ge6xGlsmeQOBbTse1eUFOxLAf2t2xC/0D4bn19O4vzZXq?=
 =?us-ascii?Q?7MtNvuTwPHB/e+qCBspsPVvOuOQYy8t/30RdkKmFLoK568BFLF5a+nSGjpKy?=
 =?us-ascii?Q?gEJ6wnC3zIEDlSAWJTZw21KD/tpk+3JnfkJgcuyMJtmIlO2E/Ucvka0dTJBn?=
 =?us-ascii?Q?TLCC9CmHVlVTOI9gWSpMrA7AENaoVrO8otGXB5P6F9GpmR3pdtPOZ3DNg/cU?=
 =?us-ascii?Q?NxeSrjqB7j/mEeL0loxDgo6HhZWDUX8QYHlGfQ4UKDsXgAZeviVKRFWfxVHK?=
 =?us-ascii?Q?UWinU3GE5vTSfg524bdWdWFfFnPI8UHGS4BGlfwMUD3HgF+tL/Hw8IFtRdna?=
 =?us-ascii?Q?lBqSvqu8xPK2PsEw7uIggJNrX5mkJbVdKqtrvfk4QYx4+L8/R2n9GzdXzaA3?=
 =?us-ascii?Q?vtNoVufGs35ugnCO0gMwf1+3qMRoGvUoG4gTREDAhNZDiQr9Qb5K3gKQKJt0?=
 =?us-ascii?Q?1a8PvSrEzA6biQ3jjU8b/RBeRkJEs9IajOdJf+1aWvo3RDs+P4azKTGNwchj?=
 =?us-ascii?Q?JgzcNCu6YnCALhqRmCrQC+387RvMeuzk8fJiUqGkiCDoOUaEBBCzhjNvk08e?=
 =?us-ascii?Q?e/TC5dbqXXYFUzO1iz7rS3TWPKKWQwqyRzVtmM3R2nInCh4OnU5eQpfQ6M6a?=
 =?us-ascii?Q?MjiQJ0sLpVRz1Yop142Dm/MuaE2293a67SlE2n79rA29bh3KX0VPMzhLkUSM?=
 =?us-ascii?Q?ArTDIjfMPHSiJaKlm4nppP7jxgdUBRFuWsQ59DpwBpkUAaYpwJBiLDAU+zSs?=
 =?us-ascii?Q?O61TLef1wNJTexi8pvou0DcT4b+YHSdBYiDBtHKLCOB+DB7X4hUxWRlMGiMh?=
 =?us-ascii?Q?m9WJ2nABToMCFGFSv4S5uZZcib0koAJ+8sficJWXWsAWG9SWGUR0Sk7zTIVc?=
 =?us-ascii?Q?wqp3DSuK9rsaGTSeqHz8snr4EMVDFFb5Ja11jmtjBhEnvTiZHJHjtUXkHwCj?=
 =?us-ascii?Q?L29tqTiQadEY3WJ0wGuDqpcTlfAnuqQVwLPMTCdpyxCYooL50euaUl3En8Ng?=
 =?us-ascii?Q?O8zvUrz48bPfmHrSPpG4F0oFYVM/9W2jYuhSZMQIlJ21SPoNjVJFd42L1s1T?=
 =?us-ascii?Q?zM2BW+3qy2p9uRYJicWOpQrfY6vdNUpQjc6KGNNFDLChKxDKxC1TLYo93XxH?=
 =?us-ascii?Q?00l6C0HdHmg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W3vQlTdACeHGHqSmPl5YYutX6/QqxIDCnz5gpkmFhUDxrMqviAghx9asDzvI?=
 =?us-ascii?Q?t7F86qCpZLuGfCu8gkc7Rqv5At4EtXJ7bSUuKBryPM4apNr6hHEvSo/NVQBj?=
 =?us-ascii?Q?iVHoWjvSPQ1/Q9T+X/28xt19hqPN6/ysDJppn7fHU9Q3NJrbvQnCR90JpkOG?=
 =?us-ascii?Q?eSac++nIc3TSQHjxQFrRF+f781cNA1AIKHx9LNc3CXYpXOIbZKEk74CAXsp+?=
 =?us-ascii?Q?tNT14tM7OW4SLLWRtW5ju+Sdn72bg9+Sqh8iZzBeVG+2adtJ4uRp6WyRIZch?=
 =?us-ascii?Q?2Pqo1wa0VjWLJ//s9PNhjN81CtbaiqDVdzTOGnlGrJMXUcdjPKCPjPEp8DOc?=
 =?us-ascii?Q?TGBhrQ5IZfbI75QMRnkvTGnUnwkHrPyseBRr1iSUZ/ibJzmjGzCmD5NV/5/J?=
 =?us-ascii?Q?k4uuDgIyL+gOpxBcZdJ2zxluz3uCb8JPxTRozJ6tUC+DU7At6A7AYgHmKyu2?=
 =?us-ascii?Q?bdW+J95gT7vZ/+8CSVHXAzQYbkwVXwzkEKwlordSP1MIcurPDdA9m4kdIA3K?=
 =?us-ascii?Q?b1GtK8gDG0kwmM1bq3wMiGxA84YxclccN7HsXYMMgSog+WpvRBqDx8iFhuHl?=
 =?us-ascii?Q?fUNYXoXTMXMXHRG4vMRF4e4I8B2/cbT7YD9l3WwYR8RT3uIJgyloCAw6+ak9?=
 =?us-ascii?Q?75VpMN70qn3bP6QRiEb7hPuLC5VHsYIY8nETcc8tVurf1R7aLqycAohgfLh4?=
 =?us-ascii?Q?Lpq9dmN/xNslPlgtsbCa3eIzFRBoY7oviMC4ePUCcC2lhOi3EFOIuRCvdsJ0?=
 =?us-ascii?Q?fewjCRUST/htn/l6RMWojYUnOXHFRq/RXwwfXH4mueQiwj9tY6tftVtR9L9Y?=
 =?us-ascii?Q?Lia5DnaEYPA7eUSmmQEW0lnf+rVL1IXcamQ0ajvasQfBgA7AZsgZaZ2wWqQi?=
 =?us-ascii?Q?ZZ/MicyXhktFwL90G15AADEhoi1iFtv+qqJyr8iRNXO5X6GssMwDudD4iofD?=
 =?us-ascii?Q?mlJaOntje+eJ64by0JavEZdrs4gFHtKtvJjlJ6bkpgkXxMWlKpAKAzJhCWp7?=
 =?us-ascii?Q?0bUhIySKw7ZXi4eRLnuCOvkWMhpigmLGeQmAOp5SkjSPkls0O/mPygxQwWlX?=
 =?us-ascii?Q?3VRvsxRQcmHmEmt0ZQpCFO7Q+hitycrUpLt5BHwqBlSlc7xa60IlhOjtDAXM?=
 =?us-ascii?Q?fKnZ/ctwqZbprfe5SMk8HY0bsWvgjlg/cpqAhqE/S/7Zqri0P72Zl84QrspN?=
 =?us-ascii?Q?DskV5cevRifGul/TWvijqE3pvqAgdTgGwNU7rYNc9IiUZ7HF5IYUdyUKBSFI?=
 =?us-ascii?Q?0aIKcJ1YBEL/SVnJ5xobEkZWa3cq1GtI6jnd4bBW7TozbxIkcZKAVASc3gMm?=
 =?us-ascii?Q?YTCPuFWBaSxr64M9VSHQQQRNvhQMZgWVXRmPZQ7BBwixRvGLf0NnJ1BHM/zZ?=
 =?us-ascii?Q?i/USMotMDQZsuM3If5KP8op4ONT9uKix/le1PLZu7IOLH4YTIU4+AGi5LW82?=
 =?us-ascii?Q?G1sDyLpVOmFNioruvoFvXxhIZypO3o5IkTlP4J7ciMvxfv3mXwjyvvZuJdFL?=
 =?us-ascii?Q?vQxCItVQzPgClc7CmtmHZWcRM4HvH07vNUIqeDYyHDde8/kYvx8OstGxOmBA?=
 =?us-ascii?Q?Wepvzyhe9w+WMWbXryaOH4vhbD9GLWHSG88BOSaiBnnxcoZZ+9OKj+Ohpte5?=
 =?us-ascii?Q?sQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f8923717-2700-4fcb-3b10-08dd14d6d0ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 02:45:01.8108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j9o7T8z0cHj96/J6ylWyGt0tqZDAu3uwt0+fc1QpzWAB/US5K5cD0O9fD9F6djOdW5X5KHah1Q7Ylv07OurSMZviR8IgR0XNe8eWfVRpqKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6487
X-OriginatorOrg: intel.com

On Thursday, December 5, 2024 8:38 AM, Gomes, Vinicius <vinicius.gomes@inte=
l.com> wrote:
>Song Yoong Siang <yoong.siang.song@intel.com> writes:
>
>> Improve XDP_SETUP_PROG process by avoiding unnecessary link down/up even=
t
>> and hardware device reset.
>>
>
>Some examples of problems that these hardware resets are causing would
>be good.
>

Sure, maybe I can give an example of "before" and "after" behavior
on ptp4l clock sync log in commit msg in next submission.

>> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
>> ---
>
>The duplication of code doesn't look that good. Initialization is
>tricky, it seems to make it easy to update one place and forget to
>update the other.
>

The original idea of this patch is to avoid huge changes on
igc_open/igc_close functions. But I agree with you that
duplication of code is challenging to maintain. I will create
common function whenever necessary in next submission.

>A couple of ideas:
> - separate the code into functions that can be used from the "usual"
> igc_open()/igc_close() flow;
> - it seems that igc_close()/igc_open() are too big a hammer for
> installing a new XDP program: what do we really need? (my mental model
> is: 1. stop new traffic from going into any queue; 2. wait for any
> packets "in progress"; 3. install the program; 4. resume operations;
> what else?)

I think will need to reallocate DMA resource, if user enable XDP pool first=
,
then only setup XDP prog. Maybe I can reuse the reset sequence in
igc_xdp_enable_pool(). I will study further.

[...]
>
>Cheers,
>--
>Vinicius

Thanks & Regards
Siang


