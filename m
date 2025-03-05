Return-Path: <bpf+bounces-53341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5DDA50277
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1543A9C61
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904CF24E4A0;
	Wed,  5 Mar 2025 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WRIdbv5r"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0328A1EDA2D;
	Wed,  5 Mar 2025 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185723; cv=fail; b=k1qqpfvpirWjc3XmEBwmw/SaCxaetDkErGptkG5mp69YJHwW41o7WlEl5uMD9VHIjkUNHlkynjr2vTpLLofo9MNocKy5r5DQAZFdPcebXdbuvORvIuL2pzYHnEorhQiz2AXGySx71CgKdg3z3oQ8uv1DngD14KGZgWUgzw8JF5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185723; c=relaxed/simple;
	bh=vtAkRuhA5jaU/gNLYSGQyXiH0FSxLte1YuyK33AfRjs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XoabIG3rP4ql1yNgfgMpfued3xL0VqSV3tKNYd0GJmxoNuTthAg0Swe0LVoaBCXIZre3ScWgZmQ6M52I5xvZ9anQXQ69QorOuMxyfar9QyvY58cYW5wVM1RkOP6UH6JnjxXFKF1TjmepfhFkywuU1B9r0Qx8cJ9ZobgFOrMx0eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WRIdbv5r; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741185721; x=1772721721;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vtAkRuhA5jaU/gNLYSGQyXiH0FSxLte1YuyK33AfRjs=;
  b=WRIdbv5rkPoYDm5NhTs83roNvjFyqec0FDqI2nYBlw5JkRFFVEmK4u5r
   WcwnVHNZ60HJWJssq1Owo6+FTEtJy61kmnb0lbQupDYJmhYy7YShQZrO8
   NFrSOyNBjrh9CAt8b2KFAZhh62JDVUnJ0i9JlqG9cpUZ9Fj+JLBltD5P0
   srqfOtU1rVTSOt7mNwYwoeWtnd7jKTD1ihGRbGEwrpjxYg+lgI4B1Bx3n
   XexGu3XZRUogGn6leoAAFZVxeOdM4UM4WxXYZiLf+OaEpjeeRsyNgdzgW
   Vvp2Ca8nL/c6m5cjReK2qr52qaNglx6B4C2ushQEUy0jGTVvPk2bNQoPf
   A==;
X-CSE-ConnectionGUID: IPlhSwBzQYe1otG76UZe/A==
X-CSE-MsgGUID: TaMDv23qQ1WhEMdUx1A8sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53563914"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="53563914"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 06:41:26 -0800
X-CSE-ConnectionGUID: dHOlXnKfQwaE9uGsBmXQfA==
X-CSE-MsgGUID: oD28kzuRQ5GmevDw48tMsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="118528217"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 06:41:24 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 06:41:23 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 06:41:23 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 06:41:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkcKv3/2odI+ba/N1bVC9dKNDabY0Z3NH+t34MvHznzNQ1SLMOTDS3pa7zwosu6wZ9r4MdVAC9x/90hoA/UPW9zct6Djd0u9u9sktLdVaah4XEuUvKv8BsljwrK9ej6lKskYylA+noZYNQTQCIAH3roVsDJL0EJCqMrEtrbrUcd0An9tWo4Ckh/kyxh2b43IO/odR5dBz5I4AlSJT+1CFSytHFnI5eihqrlixrxiICPhbT4JcCCeWR2FJAkU+QxY/en33FjOHrLnXNDcdF/ATJslE/gZPPcn9uEEHBAaRNPmBttNWAWHkyqI3N7plq0AQ7ZrMvDnTtSkg25UJsBHnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abwcSNczI85/Bq+sxEJlTUByh9M/KK+bKwOeUyibaLg=;
 b=CyB+ixPYBAnl6Aazi8sIcENnn/SmKVSuDyGKnSjqRGL7u9JdVDQBd0OXknMYvIMd/MbhXU6TCRYN1a7TVp4Czb6JBP0dVUuwojcRFiD8YiL6Ga9wv2dZe/9tFEPA2Pno5tOJFb7uaWXPGMY2lxi/6MPCCVD8XYuO9YYVJ7vl+FYdouj9kLRs3jNEiBDUrLFTlM/FXBjHXNUcYL/lh+uKnXYArwVeIKVcrvslY/BBw0QS4kRTV1UJs/UAFZxjLjKbmj6CdUlbLowzta4nk3Zhgp9Nn6+qTINXlb02UulGHrPCB8fOZT1vcT4JqrClMn8hucbjPTjcKJPHGbUky0lfiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6514.namprd11.prod.outlook.com (2603:10b6:208:3a2::16)
 by PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Wed, 5 Mar
 2025 14:40:33 +0000
Received: from IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::c633:7053:e247:2bef]) by IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::c633:7053:e247:2bef%4]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 14:40:33 +0000
From: "Vyavahare, Tushar" <tushar.vyavahare@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
Subject: RE: [PATCH bpf-next v2 2/2] selftests/xsk: Add tail adjustment tests
 and support check
Thread-Topic: [PATCH bpf-next v2 2/2] selftests/xsk: Add tail adjustment tests
 and support check
Thread-Index: AQHbiSfBClADKJ+qnUOZXYXidi1MJ7NbdpyAgAEBbdCABSSHgIADChMA
Date: Wed, 5 Mar 2025 14:40:33 +0000
Message-ID: <IA1PR11MB6514E55C4AF5D92919A1383A8FCB2@IA1PR11MB6514.namprd11.prod.outlook.com>
References: <20250227142737.165268-1-tushar.vyavahare@intel.com>
 <20250227142737.165268-3-tushar.vyavahare@intel.com> <Z8CtO2enntB/lrnp@boxer>
 <IA1PR11MB6514D321A1123B8C280875018FCC2@IA1PR11MB6514.namprd11.prod.outlook.com>
 <Z8XVj9XESLIYSwaT@boxer>
In-Reply-To: <Z8XVj9XESLIYSwaT@boxer>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6514:EE_|PH0PR11MB7493:EE_
x-ms-office365-filtering-correlation-id: c6244e08-ae43-4181-2751-08dd5bf3af84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?fOZH5MHUUgmFipPGd+FUCih16GZ4UK1hohNUj15NobBMpn1fonnNtrZOty1f?=
 =?us-ascii?Q?+11bIYNeiYOGxE3MTJWyHvAaGCuQdz7/eozNRjj4uDB+erANVpafQji1dMiJ?=
 =?us-ascii?Q?D7N+vhRxAj9R9Z2+ZFc9adjYAryNVOkVZtR5BxoyeIvBi48EyPCFqhCK8Ko1?=
 =?us-ascii?Q?GFt3e1kuDTvllevxhCmW5n35Cs/eNQIJVblLccmO3P53RDoGahq5rf5PXtpM?=
 =?us-ascii?Q?TgnnYOtVvjEIhhg6RrwJOdfG8seSfI6MHFr35qAiY8oiHv1r6VfNYHOLn/Yi?=
 =?us-ascii?Q?rOwEYcDXxHU2wBmeQ94MAx4XWW0LfO4BrBCk7HjxNbVbf2aX2x84z3mP3qAU?=
 =?us-ascii?Q?tnRyXnQXTFnX9bisShQ/MjpmAr/xuWFeKTr3d+eWbNGj+OWpOqmWCjdPHDiY?=
 =?us-ascii?Q?NNeR3JPeT8MeSHotPvbrQFlaU5P/oJb5Fh6AB9vltzD1yTyWOPIRz5Ki3l+0?=
 =?us-ascii?Q?ESQI0b7BSu1I7eXq2oCTVcj99OlWtVhoxqBpBkBXu29CUg99QUM89+g2jQVN?=
 =?us-ascii?Q?9xx3rDZxQnHJs4857KckSyG/72swA3jh5B3E5ZJS5Hmtlx4adWsT4YAOUzEu?=
 =?us-ascii?Q?kSK7EbDY1scpTXF1dDreQE/499LP09v3/jcAY0407FYJXE4WTxUBNVjIk+m0?=
 =?us-ascii?Q?JcXYenwV+ezgBSuDdSZa4uXbAhaXUyvW+93jPal/zNYHr8v+vOxAPpPIYPqm?=
 =?us-ascii?Q?NpX84p5Jw3IqaAZXGCkgugNAyK3Cg1+7qhd2/5M/rwePa2Sy996JAkzB9O5L?=
 =?us-ascii?Q?5ovUsC3X3DpNXARmgHwPtWc1ULDVOTiyx0C2ceAd/iWo+D18VMTVXodZeygd?=
 =?us-ascii?Q?MzVhoZ3kDnFLS8+x65Kq7x/oQZPDq4s9MZ+6DnjD3xcJ0slbd7shwZEQFTe6?=
 =?us-ascii?Q?JKrYpvCTPIz9cMUlv10MdP1/WuTTpXFcCAmcYJlvOj++8b7arZt4reBubAtn?=
 =?us-ascii?Q?tRRPNNeCXFvfC8ef2jMAJWzlWwS4CT5QnsYSZZlqWAqoIoXjzQw/ShCO9M9C?=
 =?us-ascii?Q?C1oUz43EfsLWhGCcTk2Z7SJcyXRLFXJjVahhmCYBv2lSJ2MEJI8QbdgvKLq2?=
 =?us-ascii?Q?GSgmSHr4IR5qqvax8BGf4lmMp8yuWhiLlLpg49zgPhp7h6jpMXR3BsnjMztk?=
 =?us-ascii?Q?LKgD43dvq6jlXo9N8kBQzWBMnE3pNrNxOEnnhZvdebkDrXQRSWQAyZsRxg6R?=
 =?us-ascii?Q?Tba14wrhpAK5SmWSgCdrt1N8OBLvaexjLzoFqkiOQNhy7RCHcWykZMbHTTvt?=
 =?us-ascii?Q?QhzyphcS497DARQFeitw27F8v7kDpHSUW66K1IXHgeQkt35EtLUZlouRrkUg?=
 =?us-ascii?Q?9p0zx0kUbdIoC6lb0ieFPtoUuz9yXGl2RXCFggevIyEPNyGRu0ZL4BilmZYb?=
 =?us-ascii?Q?YuF4z9HRH1Pot9NpoCSY4gjTdHdaO+HIhmk1HAC3Yq0unzMw7E1WuPJCuvvW?=
 =?us-ascii?Q?Tc6ozeCFeJ07O+PaNUzIXKirtvTCqZ8Q?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6514.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U0i2iqSQ8OuY5c353TPjvpwvPq5aDgMLuSKLOXJwWyjWXZTY7sqvJcWM2OkR?=
 =?us-ascii?Q?BYAgQRLvWy/IsVrvlI9jtwvl6pM3YgJ8EnTImU6sfgk7CLBkz1zjMmqxjJEG?=
 =?us-ascii?Q?CLNF/++5JyyQDJrA+pbwhBB5/gYLAMyEEPLwuHhpdfPBUwAWwvCFpUF3b/NO?=
 =?us-ascii?Q?mVX6CjrXcbMkP7CFfLJ8kBrSbjQ2Jr2cpmVRmrkKPtAiaywx0vI9jwtDvvy6?=
 =?us-ascii?Q?fCvXrlW+1184HUoov79qvqo/WhEsyoLi7GLc/qnPhDf+Y0I5oi4TJBrbFNAY?=
 =?us-ascii?Q?TZtY2NWCImtpc30Sgks/tbgn7nOYuM+qyxrp0y9jbXYuunwcoLpWbn4og+5A?=
 =?us-ascii?Q?t89xKf+A4vM0ptq7KZcoIE7cwZaQ4sMPYOMydkvgOMc+qVEjKHVNAe5W+Of+?=
 =?us-ascii?Q?Dc5a0nJG3yI/JJFUybdFJ3EiY6xCm7SXCXAI+9Uk2bGrnIFvtszCEVjQAlhk?=
 =?us-ascii?Q?pFv/u4Tpi33OQCIMQ3hRIgnyhcduZNWUn7SPhqAkWn7QtnHEOJ0QaMXNw+z+?=
 =?us-ascii?Q?67d47tOPloa7me0BlRx+D29+kdLF9zaPzRSFI7ZH3L4ZR3cYk1Z9QULAPINK?=
 =?us-ascii?Q?xZFdfEqJy+IQIbx8PQbslPOdZFiaat49dlPt/yh3Fp4Q/SicCQ0ITAc1d8zp?=
 =?us-ascii?Q?h0lhY44UzIfeB5I9pw3Y0Q2+K1NjHTeU5ypnDlBEzxqW8SiQxRUt7tdixQnw?=
 =?us-ascii?Q?focblM4zAPNgcdtcKXNbQC68mXrCxnRDr+342kHcCXNuRoNGoaLg2YnlH822?=
 =?us-ascii?Q?WWhMNz8/WdUMb9rbH51xfuepvDkZiB9g4tYuBcNDjhorbnqezBcb/aJ558d7?=
 =?us-ascii?Q?CJDKD9hAK+X5/s69V0kYUUf7yKkqvTWAiaemxl5hM0VXjTkIWoWns8ubJ+3o?=
 =?us-ascii?Q?KhObA50aS5iv1NqAgNYjnwmM2b1PA8y4woveAeRYHiKp/NZF/nIX5vNkLvf2?=
 =?us-ascii?Q?ekC2gDsQUCIaTgAnhGazHJRKVwrGuJGCt1OyU5/qoAI6jRFc9fjpxgWCrYA9?=
 =?us-ascii?Q?faBkUeBYO8Q2HummPR2kp8YQa8nWcS2P1Y24BYA5xaqlRzjYBixLjU4U1Fy6?=
 =?us-ascii?Q?78z56Wd6cEqbYz9tNl8cAKzlVBfO8g3xEa0GoKLLZm+vMI0PyjnNzvvOD+hQ?=
 =?us-ascii?Q?/PDto98OSVEtP/t/q7SxxBeXzYXb/s8hR6hXnIVNqOzoezdxuOesMXBqvXg+?=
 =?us-ascii?Q?HAMJOd7V/V4FbitpakJybcmz2IYmJdWDJmZ/SANtCZM/YSBXeBRTfM3cKG2A?=
 =?us-ascii?Q?a4kHp+rVD1ztLyLo57HOiWRPaLWCxiEG4oq0cjl5Iy3GDr0d9okX/BTpqRKX?=
 =?us-ascii?Q?+Y6HhZg4c5VUJ6RphA9NYSpBDyLcC32bRaTGffJ5XwaXx47GxKtCaOM0gD4y?=
 =?us-ascii?Q?RY5qm16V4vNYmhNnvqT9LEoYRTKyqtK3jTqh5NpAekeLdZz9cpR9rn13sFNn?=
 =?us-ascii?Q?vrF51oc203610VQKiSpDdkyLdCPziz8PD7oK05t4WimlRL3kNsuCRBWvIe9z?=
 =?us-ascii?Q?Seep41MuvsnWx/5nS51JaA8rjOm1mXHjLOTv3eYJudUasrrLfmdb5TEtJ2FC?=
 =?us-ascii?Q?xS4R9Uo9NUscm9zcHxfaLMqiTZJ8tHuqCn60aPusrKhr4VyA0/HLfd8mfVVC?=
 =?us-ascii?Q?7g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c6244e08-ae43-4181-2751-08dd5bf3af84
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 14:40:33.6109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ctABrBPl8osG+1roJ8fQQeG+LHuGIvb6fz20Ws6gnCGEKJ0PqOaMuQyNfmCfKvoYXs0unX/dFVg6cXfvXTRps/vUvqMMJQPScmtc+Mu8RZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7493
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Sent: Monday, March 3, 2025 9:45 PM
> To: Vyavahare, Tushar <tushar.vyavahare@intel.com>
> Cc: bpf@vger.kernel.org; netdev@vger.kernel.org; bjorn@kernel.org; Karlss=
on,
> Magnus <magnus.karlsson@intel.com>; jonathan.lemon@gmail.com;
> davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com;
> ast@kernel.org; daniel@iogearbox.net; Sarkar, Tirthendu
> <tirthendu.sarkar@intel.com>
> Subject: Re: [PATCH bpf-next v2 2/2] selftests/xsk: Add tail adjustment t=
ests
> and support check
>=20
> On Fri, Feb 28, 2025 at 10:56:19AM +0100, Vyavahare, Tushar wrote:
> >
> >
> > > -----Original Message-----
> > > From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> > > Sent: Thursday, February 27, 2025 11:52 PM
> > > To: Vyavahare, Tushar <tushar.vyavahare@intel.com>
> > > Cc: bpf@vger.kernel.org; netdev@vger.kernel.org; bjorn@kernel.org;
> > > Karlsson, Magnus <magnus.karlsson@intel.com>;
> > > jonathan.lemon@gmail.com; davem@davemloft.net; kuba@kernel.org;
> > > pabeni@redhat.com; ast@kernel.org; daniel@iogearbox.net; Sarkar,
> > > Tirthendu <tirthendu.sarkar@intel.com>
> > > Subject: Re: [PATCH bpf-next v2 2/2] selftests/xsk: Add tail
> > > adjustment tests and support check
> > >
> > > On Thu, Feb 27, 2025 at 02:27:37PM +0000, Tushar Vyavahare wrote:
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
> > > >  .../selftests/bpf/progs/xsk_xdp_progs.c       |  48 +++++++
> > > >  tools/testing/selftests/bpf/xsk_xdp_common.h  |   1 +
> > > >  tools/testing/selftests/bpf/xskxceiver.c      | 118 ++++++++++++++=
+++-
> > > >  tools/testing/selftests/bpf/xskxceiver.h      |   2 +
> > > >  4 files changed, 167 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> > > > b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> > > > index ccde6a4c6319..2e8e2faf17e0 100644
> > > > --- a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> > > > +++ b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> > > > @@ -4,6 +4,8 @@
> > > >  #include <linux/bpf.h>
> > > >  #include <bpf/bpf_helpers.h>
> > > >  #include <linux/if_ether.h>
> > > > +#include <linux/ip.h>
> > > > +#include <linux/errno.h>
> > > >  #include "xsk_xdp_common.h"
> > > >
> > > >  struct {
> > > > @@ -70,4 +72,50 @@ SEC("xdp") int xsk_xdp_shared_umem(struct
> > > > xdp_md
> > > *xdp)
> > > >  	return bpf_redirect_map(&xsk, idx, XDP_DROP);  }
> > > >
> > > > +SEC("xdp.frags") int xsk_xdp_adjust_tail(struct xdp_md *xdp) {
> > > > +	__u32 buff_len, curr_buff_len;
> > > > +	int ret;
> > > > +
> > > > +	buff_len =3D bpf_xdp_get_buff_len(xdp);
> > > > +	if (buff_len =3D=3D 0)
> > > > +		return XDP_DROP;
> > > > +
> > > > +	ret =3D bpf_xdp_adjust_tail(xdp, count);
> > > > +	if (ret < 0) {
> > > > +		/* Handle unsupported cases */
> > > > +		if (ret =3D=3D -EOPNOTSUPP) {
> > > > +			/* Set count to -EOPNOTSUPP to indicate to userspace
> > > that this case is
> > > > +			 * unsupported
> > > > +			 */
> > > > +			count =3D -EOPNOTSUPP;
> > > > +			return bpf_redirect_map(&xsk, 0, XDP_DROP);
> > >
> > > is this whole eopnotsupp dance worth the hassle?
> > >
> > > this basically breaks down to underlying driver not supporting xdp
> > > multi- buffer. we already store this state in ifobj->multi_buff_supp.
> > >
> > > could we just check for that and skip the test case instead of using
> > > the count global variable to store the error code which is counter in=
tuitive?
> > >
> >
> > Thanks, Multi-buff is supported it might be that growing is not
> > supported but shrinking is supported. We have difference in result for
> > shrinking and growing tests. We are handling these cases with the exist=
ing
> 'count'
> > variable instead of introducing another variable to indicate or access
> > in userspace.
>=20
> These tests were supposed to exercise bugs against tail adjustment in mul=
ti-
> buffer scenarios, hence my comment to base this on this setting.
>=20
> I won't insist on simplifying it if you decide to keep this but please us=
e
> different variable for communication with user space. We're not short on
> resources and count =3D -EOPNOTSUPP looks awkward.
>=20

I'll address the variable naming and include the changes in the v3 patchset=
.

> >
> > Here's the result matrix:
> > Driver/Mode	XDP_ADJUST_TAIL_SHRINK
> 	XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF	XDP_ADJUST_TAIL_GROW
> 	XDP_ADJUST_TAIL_GROW_MULTI_BUFF
> > virt-eth DRV		PASS					PASS
> 				FAIL(EINNVAL)			SKIP
> (EOPNOTSUPP)
> > virt-eth SKB		PASS					PASS
> 				FAIL(EINNVAL)			SKIP
> (EOPNOTSUPP)
> > i40e SKB		PASS					PASS
> 				FAIL(EINNVAL)			SKIP
> (EOPNOTSUPP)
> > i40e DRV		PASS					PASS
> 				PASS				PASS
> > i40e ZC			PASS					PASS
> 					PASS				PASS
> > i40e SKB BUSY-POLL	PASS					PASS
> 				FAIL(EINNVAL)			SKIP (Not
> supported)
> > i40e DRV BUSY-POLL	PASS					PASS
> 				PASS				PASS
> > i40e ZC BUSY-POLL	PASS					PASS
> 				PASS				PASS
> > ice SKB			PASS					PASS
> 					FAIL(EINNVAL)			SKIP
> (Not supported)
> > ice DRV			PASS					PASS
> 					PASS				PASS
> > ice ZC			PASS					PASS
> 				PASS				PASS
> > ice SKB BUSY-POLL	PASS					PASS
> 				FAIL(EINNVAL)			SKIP (Not
> supported)
> > ice DRV BUSY-POLL	PASS					PASS
> 				PASS				PASS
> > ice ZC BUSY-POLL	PASS					PASS
> 				PASS				PASS
> >
> > > > +		}
> > > > +
> > > > +		return XDP_DROP;
> > > > +	}
> > > > +
> > > > +	curr_buff_len =3D bpf_xdp_get_buff_len(xdp);
> > > > +	if (curr_buff_len !=3D buff_len + count)
> > > > +		return XDP_DROP;
> > > > +
> > > > +	if (curr_buff_len > buff_len) {
> > > > +		__u32 *pkt_data =3D (void *)(long)xdp->data;
> > > > +		__u32 len, words_to_end, seq_num;
> > > > +
> > > > +		len =3D curr_buff_len - PKT_HDR_ALIGN;
> > > > +		words_to_end =3D len / sizeof(*pkt_data) - 1;
> > > > +		seq_num =3D words_to_end;
> > > > +
> > > > +		/* Convert sequence number to network byte order. Store this
> > > in the last 4 bytes of
> > > > +		 * the packet. Use 'count' to determine the position at the end
> > > of the packet for
> > > > +		 * storing the sequence number.
> > > > +		 */
> > > > +		seq_num =3D __constant_htonl(words_to_end);
> > > > +		bpf_xdp_store_bytes(xdp, curr_buff_len - count, &seq_num,
> > > sizeof(seq_num));
> > > > +	}
> > > > +
> > > > +	return bpf_redirect_map(&xsk, 0, XDP_DROP); }
> > > > +
> > > >  char _license[] SEC("license") =3D "GPL"; diff --git
>=20
> (...)

