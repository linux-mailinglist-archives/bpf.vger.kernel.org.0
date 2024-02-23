Return-Path: <bpf+bounces-22556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1094C860B0E
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 07:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5678284B96
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 06:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D151401D;
	Fri, 23 Feb 2024 06:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f+uOeTFm"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BA6134BF;
	Fri, 23 Feb 2024 06:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708671548; cv=fail; b=fq9wZACCJYxZeAXoxxMCNW3GupWePsN77d+RbiM3KaASecGLZvuyHo/4qpMThYe436JI4Sz6ErvNHGMT7ccuf8//1B+cixO9Qo79txi2EGKAbfrOocfsxm/ls/zih2FA0LeNSHOP7uSabMTm5Jw9L5sQ8bgFs9JF8xKbXALcLXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708671548; c=relaxed/simple;
	bh=S8K7E5yjxuvvTISxTHbHgufa6hsyVOKJxVQDpyRsKJc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gVZG9GgsqZC+yq9izTkiY7bo3AREfEndVL1bxo9YHDCmbWFzJpColYlejdyROs5Phnncd4Hk/rHT2jWIZR4Ld8G5c9EjMug81XLWY51XDFBHnCyxvTagmzuo7B5woiFlmwWDW03TCklnp+7p8b+0kbRsUIolTYN9seUvoUARtuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f+uOeTFm; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708671546; x=1740207546;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S8K7E5yjxuvvTISxTHbHgufa6hsyVOKJxVQDpyRsKJc=;
  b=f+uOeTFmAx2v/RObN4iJnT1awQfSsqp4HOJ8SFz/pRDgh0hiuFxXM0D3
   4pGu1PaLReawlaJrSBWQdgCQ/YUvub9Q8JNWyp6NGu0JrX4164NKGbqCH
   UpbGqTGdLvulhr4Ghe8uIQumB5T9sXFR/76kL7EJQSsMeGgfvc/uPWouc
   1IIqLnXqsHLlddpLAZAOn+Q5tdhi6xbru3SfgVSCj/6ZTW4tg63FoI2k2
   oYWQaaXugOdQyHQfDAnxnaakAcLPVJpAdt+gKRUMX11LCqaURXWBBvD16
   UYtCFYiHA4qT+vYtvW1yPS7P78LIFT48VKoP2TMEf/CDjdWbV720h/1gn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13668872"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13668872"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 22:59:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10392652"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 22:59:05 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 22:59:04 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 22:59:03 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 22:59:03 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 22:59:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMD567a0Rlatz2uBNoW9VE/P9lTXdS6rrWKnYZdC823AZw2NqvEKzi4hk5RZ1BCSlGR5G1ySVRMNvu5CGAnNPy7r0S4RJvfj40IqsqSRiQ5PJjqhZA5u/QbQYsIRGV+CsRTvRYbUKSGJo7w7vPiKf+BJW4VVhayKB3hWdTRLGj9bMVALIvS9+qDvIAWDjPfQBoz0YBCKfrWz0T6kIJCh8eJm/TwfanYDT6Ugzyh63r6wQrjTaSmNNwxFA3QujiqT+f8XE1R6qJiOMnJxtq4WaT7do4LqUJ6XNOIPw7Lk4PGkioxV5viyE+//C+mloW1ZPDyLZrkJc+domXy1lw/Daw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8K7E5yjxuvvTISxTHbHgufa6hsyVOKJxVQDpyRsKJc=;
 b=nNlGfGw+81gBJkUOxBGhyizSWf5HYJ/9ioTPPQy71/0rK7y/b3D8W9VylNRSyskafWk3uw7IfEuVnxmK/mrc7R5jiRGSqGcJybjMi7WV0EGkZuMlUGxFaocluN7mAt/9gmzqLovuIAtVIcE9eRR/YM9opEgOJVAyA6Rfx/uidETH4NpItmTu3oz93QGxexxk2d79q7rC6+NcFvbR7a/0PThbD/F4QALWyJXQjmoQLnQRgzev07jYNOgXp6He2s2+dj25gMlFC60a/sn/DAj8ihWAI2+90nwyyLXR7isOFgCZJv5a/EbwMOnwoZHWBgn8EJhon9EVXjIvfYHaKZ7iAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6521.namprd11.prod.outlook.com (2603:10b6:510:213::21)
 by DM4PR11MB6357.namprd11.prod.outlook.com (2603:10b6:8:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Fri, 23 Feb
 2024 06:58:56 +0000
Received: from PH7PR11MB6521.namprd11.prod.outlook.com
 ([fe80::f188:a73d:bdb4:c93e]) by PH7PR11MB6521.namprd11.prod.outlook.com
 ([fe80::f188:a73d:bdb4:c93e%5]) with mapi id 15.20.7339.009; Fri, 23 Feb 2024
 06:58:55 +0000
From: "Voon, Weifeng" <weifeng.voon@intel.com>
To: Russell King <linux@armlinux.org.uk>, Choong Yong Liang
	<yong.liang.choong@linux.intel.com>
CC: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, David E Box
	<david.e.box@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, "Mark
 Gross" <markgross@kernel.org>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <Jose.Abreu@synopsys.com>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, "Andrew
 Halaney" <ahalaney@redhat.com>, Serge Semin <fancer.lancer@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"Sit, Michael Wei Hong" <michael.wei.hong.sit@intel.com>, "Lai, Peter Jun
 Ann" <peter.jun.ann.lai@intel.com>, "Abdul Rahim, Faizal"
	<faizal.abdul.rahim@intel.com>
Subject: RE: [PATCH net-next v5 1/9] net: phylink: provide
 mac_get_pcs_neg_mode() function
Thread-Topic: [PATCH net-next v5 1/9] net: phylink: provide
 mac_get_pcs_neg_mode() function
Thread-Index: AQHaX7wldK1LhNzF+keQLCZ6YcdPm7ELmBuAgAvwXwA=
Date: Fri, 23 Feb 2024 06:58:55 +0000
Message-ID: <PH7PR11MB65210C62342088CF5C484A2888552@PH7PR11MB6521.namprd11.prod.outlook.com>
References: <20240215030500.3067426-1-yong.liang.choong@linux.intel.com>
 <20240215030500.3067426-2-yong.liang.choong@linux.intel.com>
 <Zc47T/qv8Xg2SA21@shell.armlinux.org.uk>
In-Reply-To: <Zc47T/qv8Xg2SA21@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6521:EE_|DM4PR11MB6357:EE_
x-ms-office365-filtering-correlation-id: bc331a0d-dcfc-4843-3a10-08dc343ce6e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IOLdxGzOJD6ueHZoOffN8kb9tn3n2Dhvq4bGaT8G0PJ7tcvk62ymMu0W/GM2uv9JkMJ3V/2XLvq56SXs578KV0N3fEko3bBd/27ilhsdlrjwsD1j6PZQxh+MBddnDg8EHo5YXemSuDvP8DIYc1b+IQ961hUt6l/Hjnoag+hEX8V3ZC66modWrzJsDX2Y3mRHsUkXVaRn59n8L7NGmUa0h3IXl6mB2lLub3eqClz76e8I5m7hBdXHErgqD6ezKS9zQvI5cWzL90ZDlL7nCb22tfeIz1NmAvza2aWIauWk0NxZuJB3kAtXCN91/chLK5mViyRAiXdesC25FamnZVg22sbB7PWB3ybKE36nma1kybA7J7i9WldrWBViJv5pqAznDGXTE1aebXdfOPe+A3G5xsxA+retjwhiZlssS9CJ8VgwCKzGV7dHeL1l6mvVKKLgEwsYWSdnLIxt5AldFljTBoqR9P+HDcnG7adfN4IvQ7nPolvTdUbWBqTWCmfUzvpE5Y1lq3BBScEOKM2iftoS8O2hLdJOvbhI5cxkHuysgpnMzcGMNPQwEny8zEDwS6vclXlubR0EtdonFI4QYIBUPgyMA7SJjVqyhk92oXM9BMRA98BH7mqYB+/npLrd5dKA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6521.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7/IUgbSGa0Px+952D1zU+IbdN30+Dq5euxdvhssNo3HqPkKrfjTR/p2OLtQS?=
 =?us-ascii?Q?PsN/29hEjzTerPMdl5/+MDPzEbbBJ7wmkVRLYZfEc4/WpC7qFBsAfs/KpqkG?=
 =?us-ascii?Q?7TdeVYotaEaGHIU5tgFg1zq5WSmbGdzdOV9iGwx4ZXMWyjGiEU8Kllx4oBnh?=
 =?us-ascii?Q?MPcsasAfyMv80SuWpoNPiLZqy/aZ6MnkJdzP76Tx/N45udJuj3Ygthl1vP4q?=
 =?us-ascii?Q?QWJuhaLdUzwdlr2UFJCLwbgoC6Sb6wPk/GowYxyiFfIYLg0uhDf9CJ8EA412?=
 =?us-ascii?Q?DE3UgmTu/jvW+3fBZ4GtVfSGExJpawGtz5LkRZxCG3PKJLfRKe27rFkOCd2/?=
 =?us-ascii?Q?daTXFK5AoNZ7tSxkVc0KGIaZh7D1TNmmTc3+hxOAJt4vu+izJgRgupcSE7Mb?=
 =?us-ascii?Q?mIYnZs5CGMhf+ICp1ywR8qFn/BA5xB6g0QB41Kzn2v0oTMzZCtngG3YcnVJ+?=
 =?us-ascii?Q?lAHq7ZeD6Mgyi0qSrmzCOJ77zLmWarmQnMNneCOd9N0QyMuByWFxWaKT+WKI?=
 =?us-ascii?Q?QwIGYSOOaMtihBpCbFS7AZManCCPw1muOLgXbDDZ1s0TcQi4pyXPNBIB5+0c?=
 =?us-ascii?Q?Edi4zAO1G9CZm2Vmsf4hQtenATNy0lpXo3jllDxeE0nkP/eewnDuiE6gjkBe?=
 =?us-ascii?Q?JS1wu7ouslAU1yd1GE++qqxanb4i24QdWG4M8hgO9m65qGyFPcacSmdOMeZ6?=
 =?us-ascii?Q?xbpIp8WRuEkq/NJTZDpAa7Sc4U1m6BLoetiJVTSxjvShS6CCZB4/VVALd4zg?=
 =?us-ascii?Q?RkKomiy0O7yF/OeCNMFKWCaVAuAVRhLLCNRneMCitf7cuAeqIA9bZfJDaKLz?=
 =?us-ascii?Q?n95YrStb5ZdTQ5fqRoZ691UF+AVMV0Nhc0SrB1Uxp3kBpL0vNmhIIoDDupmN?=
 =?us-ascii?Q?1KbVh+qS5t0PEwhvyn9xYmVnJg43rAn8rBFiAaSsryYAogGVWlBVvEaz2MLo?=
 =?us-ascii?Q?PxnSpqGGUBpS92H1fUe7w1RcUQAygJj3rih6Tj3REDHK+/hTGgcUR3YYFRhh?=
 =?us-ascii?Q?+Z9GvpX+DmbSkda3UOJDRwgWG935Khu9L7WW5ObKmJG3m0oHRxTSOFKJ8e1w?=
 =?us-ascii?Q?+gvUc0deQyqbdId72cLYxx4d/DNbbTrMFkTSw+wnYNEGPt5H2WW8FoK43X8P?=
 =?us-ascii?Q?2RG318d46rNI4p+eJWjjx1q7inZfLf0+T/ChdAsj1ZJCZaxJWCuCxonc3q6x?=
 =?us-ascii?Q?oh8BXtSutqGEjwY4TLsjIz+Uu189qjS0WZgUC5XVvKJaXeDbmtklEmFNScQA?=
 =?us-ascii?Q?wGJbXszJATocSYqI5wkbH0TOGmAlBxj8YUap8hfQTGKr4YjU2YlzTx2MXR1H?=
 =?us-ascii?Q?yFw7KE7FLd8b1/4S+CgZ/txwmOCpEfJ9oM+6AMMnHQxgkHh3mZVr7eENHB/B?=
 =?us-ascii?Q?WDFof+otoh+0rGsL8+AHpvXJWvCir8Yd+N1uynx+oOqHgziayteFITaUwZgK?=
 =?us-ascii?Q?FiWe92sHZxXVm7o82AnKU/HH+hIe89xE9G3zFARD2FInFFI1fAFpUkzAE3yy?=
 =?us-ascii?Q?ajPQvhpiSmz6aKMJNyXb6erVeBU3CYEEeYZomk8N/xaGr2lNohcWyjFibdFc?=
 =?us-ascii?Q?V89Pi8tsUXuktogRuYY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6521.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc331a0d-dcfc-4843-3a10-08dc343ce6e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 06:58:55.6400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7i6imOzmO4Fz1Y0yBHgdsGxUmWh2Jd275CNrKjy9Kfw3fleho0vCIwhssolleZM8VIBSKFtbzkfNGVB0WiVqbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6357
X-OriginatorOrg: intel.com

> > For instance, if the interface switches from 2500baseX to SGMII mode,
> > and the current link mode is MLO_AN_PHY, calling
> 'phylink_pcs_neg_mode'
> > would yield PHYLINK_PCS_NEG_OUTBAND. Since the MAC and PCS driver
> > require PHYLINK_PCS_NEG_INBAND_ENABLED, the
> 'mac_get_pcs_neg_mode'
> > function will calculate the mode based on the interface, current link
> > negotiation mode, and advertising link mode, returning
> > PHYLINK_PCS_NEG_OUTBAND to enable the PCS to configure the correct
> settings.
>=20
> This paragraph doesn't make sense - at least to me. It first talks about
> requiring PHYLINK_PCS_NEG_INBAND_ENABLED when in SGMII mode. On
> this:

The example given here is a very specific condition and that probably why t=
here are some confusions here. Basically, this patch provides an optional f=
unction for MAC driver to change the phy interface on-the-fly without the n=
eed of reinitialize the Ethernet driver. As we know that the 2500base-x is =
messy, in our case the 2500base-x does not support inband. To complete the =
picture, we are using SGMII c37 to handle speed 10/100/1000. Hence, to enab=
le user to switch link speed from 2500 to 1000/100/10 and vice versa on-the=
-fly, the phy interface need to be configured to inband SGMII for speed 10/=
100/1000, and outband 2500base-x for speed 2500. Lastly, the newly introduc=
ed "mac_get_pcs_neg_mode"callback function enables MAC driver to reconfigur=
e pcs negotiation mode to inband or outband based on the interface mode, cu=
rrent link negotiation mode, and advertising link mode.

>=20
> 1) are you sure that the hardware can't be programmed for the SGMII
> symbol repititions?
>=20

No, the HW can be program for SGMII symbol repetitions.

> 2) what happens if you're paired with a PHY (e.g. on a SFP module) which
> uses SGMII but has no capability of providing the inband data?
> (They do exist.) If your hardware truly does require inband data, it is g=
oing to
> be fundamentally inoperative with these modules.
>=20

Above explanation should have already cleared your doubts. Inband or outban=
d capability is configured based on the phy interface.

> Next, you then talk about returning PHYLINK_PCS_NEG_OUTBAND for the
> "correct settings". How does this relate to the first part where you basi=
cally
> describe the problem as SGMII requring inband? Basically the two don't
> follow.

It should be a typo mistake. SGMII should return PHYLINK_PCS_NEG_INBAND_ENA=
BLED.

>=20
> How, from a design point of view, because this fundamentally allows drive=
rs
> to change how the system behaves, it will allow radically different behav=
iours
> for the same parameters between different drivers.
> I am opposed to that - I want to see a situation where we have uniform
> behaviour for the same configuration, and where hardware doesn't support
> something, we have some way to indicate that via some form of capabilitie=
s.
>=20

Hi Russell,
If I understand you correctly, MAC driver should not interfere with pcs neg=
otiation mode and it should be standardized in the generic function, e.g., =
phylink_pcs_neg_mode()?

> The issue of whether 2500base-X has inband or not is a long standing issu=
e,
> and there are arguments (and hardware) that take totally opposing views o=
n
> this. There is hardware where 2500base-X inband _must_ be used or the lin=
k
> doesn't come up. There is also hardware where 2500base-X inband is not
> "supported" in documentation but works in practice. There is also hardwar=
e
> where 2500base-X inband doesn't work. The whole thing is a total mess
> (thanks IEEE 802.3 for not getting on top of this early enough... and wha=
t's
> now stated in 802.3 for 2500base-X is now irrelevant because they were to=
o
> late to the
> party.)
>=20

Agreed. And I have also seen some of your comments regarding the 2500SGMII =
and 2500BASEX.


