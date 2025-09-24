Return-Path: <bpf+bounces-69507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160D9B984EC
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 07:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2652E0EBD
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 05:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFD923D7D7;
	Wed, 24 Sep 2025 05:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JyqXuFgi"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEE61E5201;
	Wed, 24 Sep 2025 05:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758693125; cv=fail; b=Z1CQ15CxgTt0REOfvpnTvHZjstYSfqcqjN/AznWVAk2Os5YhMovgMEyuustL8ub2QnLjyWCxmyo6WkV6OYDwHJhgYLzX4woik3Vcz+s5j/fSA2IEucmTg8oNUMR3doyYdsjbEhw5txsC8gxWbEnAwIa/4MtP691ggswczhzRguc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758693125; c=relaxed/simple;
	bh=nEzBa0P9A4eMaHZNmfcIMUGVT6SI4rgIB9CSlukhkkA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MSQdViiUZ4y5B32wZwXOQ+fldfKlNSgf4Aqj+KLADT+uqiI9KerBaJoM00ThDfHx9Fr02FDXoNmOxRFqo4gcXZHAld2wiVAMeuOsfBoKiZNOk98gh0JoZ+DPCV+d5OnR1f0STk9j8IaP/ns3vFAefS1uLX/EGKDFZm/UyT6DXKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JyqXuFgi; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758693123; x=1790229123;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nEzBa0P9A4eMaHZNmfcIMUGVT6SI4rgIB9CSlukhkkA=;
  b=JyqXuFgiuPC3IzdrbWP8LPl4GVZ1lI7CqK4StLE7WPeO5MkZmr0WdIKf
   rBAwi0FOSiLxfmVVkzTOrCraIQnA5qasPotugr21XeAwdfqTV3xMr0Njg
   nSaS1bd2cAQCo6MENVOtLEBAJMQIX4PwpQI7aYb3PmnjV1F6xDLd/ASw1
   m10GwZzqX3UAbFqgXNY7RvGFbDg2ikLXtMeJFZF10q0ZsXhXVdjcjesP9
   VwBF8dI2hgygXFMSYK4wShGpfH8+5+R5x4zMOUi2Or1+sMfWGWIzA9g3r
   m2s08HsE/V3DAUihF6eb4cnyK0aZAvkFbGcOi+caTQVexZCI6X2DaQEMx
   g==;
X-CSE-ConnectionGUID: 58BHrHNORaqiMADBqGqaoA==
X-CSE-MsgGUID: ced1HtglTAqkbw9voizShw==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="64822517"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="64822517"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 22:52:03 -0700
X-CSE-ConnectionGUID: vhEtKT4VR0W798pJHRKUVw==
X-CSE-MsgGUID: CuGKLaW0SjSHLMy5OIM2iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="177726417"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 22:52:03 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 23 Sep 2025 22:52:01 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 23 Sep 2025 22:52:01 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.6) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 22:52:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5pCexQz3hVOGn8cU2s43JUzbL+CkT4IiIj/7qgikEZPZvKkjT031fdRhn2VUsgB3raHhkRRRXw4RWbOBEkrQrfp7FePmmJEV3FnxrWhHKn53KA+UJUBoNJfsDEtomUHbVeF06YqRgMv1EvvHNUIGay4R7/ays123rRWGkECOgA5s3BbXYrZ8AYdeKCok548CNSsszLY9d3GNbEEKApM1SGXFDyh7Ukin89OCZp1rUB1qV4leWlVtvUheI4/F38Zn+ddfSqR8kDWnmVUUBNTeJnrYCZmachgcT5o/ie5Dt+LD60ra7sHZRS516+Yfvml7GvR24PszRU9BkRPtSXeVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTIFys7N4dfcGxDU9TYs7hGzYSALe8GRHAqC4czeu80=;
 b=J3fTVrNuQnXKYm6DQc2zw3uuGY3Zmx62XMKP1UX4zJxzZ/0SFOwMYc4SQKIz5reMeDfKYMMOCaOHU4eR9r7+N1rXxi0IWNRKTF83IFDbEyToT7EL0UVMbEATzpyOFQYgGHyzL0biQqNy44NaXyXsUC4oiq4ltlHI8zkkSRQrpiSkc9BmLhyYy+N+4cS/K+OHPIqd4En3xXO5ZIQ122hwX8TBUSWnAn90ZQqq3f2wcCiqp95oYYJd1FVw4XXfE2fyDnYt/0IaACIyijbY95VXPuhFzqOmUXUxzxFy1x0lYs8iOSWeqgbBE6Ua0Lvi5gQvKl29YkPvvasNDvFY3aj8kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) by
 DS0PR11MB9502.namprd11.prod.outlook.com (2603:10b6:8:295::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.20; Wed, 24 Sep 2025 05:51:53 +0000
Received: from DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425]) by DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425%7]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 05:51:53 +0000
From: "R, Ramu" <ramu.r@intel.com>
To: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Kubiak, Michal"
	<michal.kubiak@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Simon
 Horman" <horms@kernel.org>, NXNE CNSE OSDT ITP Upstreaming
	<nxne.cnse.osdt.itp.upstreaming@intel.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 4/5] idpf: implement Rx path
 for AF_XDP
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 4/5] idpf: implement Rx path
 for AF_XDP
Thread-Index: AQHcIzh7VTd95mXmUUWYARc8Elh1zbSggVzQgAFmgNA=
Date: Wed, 24 Sep 2025 05:51:53 +0000
Message-ID: <DM4PR11MB645596392B206C0B1457116C981CA@DM4PR11MB6455.namprd11.prod.outlook.com>
References: <20250911162233.1238034-1-aleksander.lobakin@intel.com>
 <20250911162233.1238034-5-aleksander.lobakin@intel.com>
 <PH0PR11MB50137497947DE469E760CD40961DA@PH0PR11MB5013.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB50137497947DE469E760CD40961DA@PH0PR11MB5013.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6455:EE_|DS0PR11MB9502:EE_
x-ms-office365-filtering-correlation-id: 160ee413-65fe-44f2-ecab-08ddfb2e7693
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?MLo3pwpDnufXzWeO40Akhiv8HTpPZW6Hf5JAUM/PWFU130iNEG6LJ/HLiecE?=
 =?us-ascii?Q?KQJjLecdh8z/yDOwm/zNgy+q+iBxuAvQcA+6bX+N0IkWuuKrLOCkGRAiK0by?=
 =?us-ascii?Q?u4Dmr76uPxK/5+w7iuuzXzbiKr5yex/taB2ZJKSKhKpN0xJzdaedaab4nDwU?=
 =?us-ascii?Q?ubjARGBS+afq7mVB1bcMBY15LwpgMVntkV0M0Tn1JuaTLkoxEq9ufiDi7s6l?=
 =?us-ascii?Q?gjgD8HC7WvprmsuzeNixzxNvR+ONF7k+OWsux2ZDRIzOo1JnIaNwW+Z4Jnrh?=
 =?us-ascii?Q?5I/kASX7ise3Xsgn6Ck4+KSYUnVaRKr/7KRBjRSNRtVg5uCBRxl56RTPCMeF?=
 =?us-ascii?Q?o2RaCQzqYUB2IrqkKCWAIpyccS5zEdfvcBdCLi1X6fvwhTt211UEjNz1xkdR?=
 =?us-ascii?Q?LTjVOX5mDVXID4JojS96c+5qGjRPLlDmp6yXuIMiN4IAu0Ejgd1KCKXxxYR1?=
 =?us-ascii?Q?OXvMhD+qh21VbaL/xX/r0GykEZ2HFZfB2faYrE2MFIHQZRkHjdqosCpI6c21?=
 =?us-ascii?Q?tWMccQPbdKEn7MfIH77U89CLQX6AraHtjEtDOWjrc6R5enj2BEuaCQ/v4xo6?=
 =?us-ascii?Q?xsW0B5PvABBdD18ZulQgP+oGRDZ7QJDsCGkmXrBNgCJaaN6lt6J2HW6Rjerc?=
 =?us-ascii?Q?17w51na30JTDrMz4B/ysD+pWs/WOzZasMRbXzQkq0x2/ynz+0wFPrB3r8Bze?=
 =?us-ascii?Q?TFWDDNz5OZvpjeQPUJ9Gew39gYTzQXYqp1pS8SaOULMTEHGVBxlPVER9U2yn?=
 =?us-ascii?Q?WBsXvMGziJ6uBS2gXkXu1ozrtKClwmJed/YNXfMNxxI/hg5iQfnt8Bwe04xv?=
 =?us-ascii?Q?SlnCs78rjefZ4JPp4/0keC73C9/I9aG5hXvpwGvEzav+KPsTA2ehhofaAVn9?=
 =?us-ascii?Q?vlHvH8jrsYF+ou5iUxdF4LVDEH/1PhG2zVSpF1FilacTz0go+a9w/qm7TmJh?=
 =?us-ascii?Q?LFeYb77pVi3l4EUtTr7hWE7zEVoAvTWye2YIvhZvWyp3ak/2wvzG0CYFOwfg?=
 =?us-ascii?Q?smkEKG0+x5BQT/qnlfjbm8z/lRIsuK0we/y75svuaD6Hw+gqSv+JrVVVP67k?=
 =?us-ascii?Q?w02WUZVhbVfgeRC/CTiAgDFhqP845diLs7HxaVrXJb9gz0nJK5cXwZlh3cPr?=
 =?us-ascii?Q?ix6agBkJRKsBzMpenHxuTOmhmmAa3AOxEiHgJh2wRjUz55ZST60fO794x81i?=
 =?us-ascii?Q?TNJMY3H2+JEcSzBa46ysggsX9Uu1I7jUx9el4eknyYx69pA7KanGzEbTnDTm?=
 =?us-ascii?Q?mJUFSHCPwLH0JdFs8C7mOclWk8IGjTwdvqMs75TOPchmUTe8b15UlRwYMJzT?=
 =?us-ascii?Q?H3baO9D2mYOlzuPKOiTfkO+iiazKdqrR/Tg2IP/EgBkXDaZauTU2TyoitnDc?=
 =?us-ascii?Q?qO+6X628Hl23ugltpfXbwHz2rk61qMXCevsM8DacMfYyV7UKCb9sK21Wtp4R?=
 =?us-ascii?Q?S/utTPO0X21kxo2ZRC86OqrA9imTIwr0FEWuGKSCrObfsRUe45s2DFReO/BB?=
 =?us-ascii?Q?p7ZcvU0Wjw5chWQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lf2NuLrayX9hVginD4T/Ir6oYdrv5WyxbOd85vHS/X22gMQybXK5B3eVx8aa?=
 =?us-ascii?Q?dW1+SoX5Z0cColyC9nW8N/0icfFLZGrhFrelkj7nEkGk45UY/8MvipoMLx2o?=
 =?us-ascii?Q?UPLU/FWbBhJ65GyUSug7SH34ZJixC/ktdAa6k/hzSckmwPJoGlCaDPlVrv9X?=
 =?us-ascii?Q?xU2UfPR6gVOIKWiDpEsuzSEeGwz/tEiJtnweaffudcqtFtlYYnZQw3PzFoJH?=
 =?us-ascii?Q?sLLteYAsccPc2Dznf73p6PtREhpY/MI1iSxEENgf6gUfTxzBovVgVqJiWvxG?=
 =?us-ascii?Q?HxXjqvxVBq/IweroYelUskZSVTXO6LBtOt9FX2pKQ6WYK7ccclge+InCpRqZ?=
 =?us-ascii?Q?Yi1t1kRQYY4W1vYBdm21gQyFH8Ww7P3hQLSkXzjltYzbev4vO4mH8PWm2adK?=
 =?us-ascii?Q?qdTQd7ow2kCkSlzaaXqMuh3LUj2mEHbrXYS8Rf0Th5XpUjh6i88SJdHFSY5y?=
 =?us-ascii?Q?jE/c/7iMjYxT4CQVtT0lzOgzS7KTX6zimeV3cyBIa/zSZYn1BXbfuP6HXoqe?=
 =?us-ascii?Q?HUF/CfLjr3CActake7Pxg7rEJn3UWSpuYS3V4/mtjJj4aLK0AXe5mdieAu6B?=
 =?us-ascii?Q?dYKsM1FadZ8DyvVIQ5MW7q9iukntQvZEnlI0qh+mpG8vdZUdiHYwLmYSL61J?=
 =?us-ascii?Q?lbyeP3mP4ctAIhxOZAsMApEzhKvXog0egAWcl3j0cJW65lqyWyPmueIGD42X?=
 =?us-ascii?Q?zgZsZVid34GT+Xv4C9TvnjGXzzQ7yu1XvZwixX9HyD5J+ziH4m8O//F/OJXD?=
 =?us-ascii?Q?R+SFWmkAcaYDRIAApDHIyizfZ8BnnTwOmDNZtc6JiXPLT4Ndnm9TrcW7WyVm?=
 =?us-ascii?Q?0VLN9v6ZcHB7kzgnVUhVJ1SNRppEd3UBLghh+nHYyEc2ehCgB/Wb2ptE7BcE?=
 =?us-ascii?Q?8upaA944ZZFppBwvNDbQWveHcylONgdaNIwNSxvtxJ90V47l8FzVjh6gs0R3?=
 =?us-ascii?Q?vsjavdHFThrrOxGmeRWGJuL1ZAlhJI2wM4D58IrKBF5G5pORap2Wz3Bi7yw0?=
 =?us-ascii?Q?ZEjwGkdrKLuUj5wiSQTSWvKaG1sPatsjn144oW5IaOxsb43Fi2UeD2xOtsbj?=
 =?us-ascii?Q?Ev34DbMzaoMqi78KhXkdU0ljER9IsELvJwS0oHutf2VL2qH+Tc9jZe3kRALF?=
 =?us-ascii?Q?VsVuqD2oBuLitFy6KlnUl5BFMHFH79Hpw6v3Q3qD6roDmq6Yh7csySLrzLeH?=
 =?us-ascii?Q?woNhMlJjl5zNoB4/Usj7tdxwCepxTGLm6uAJEoHlqfbjBoM8J9F0O+hpINL1?=
 =?us-ascii?Q?7FCrzQLwZkjr1efloqLeIa4EoTXVSBEFOMSPG0c2W85e6iGgspqf0xZote5x?=
 =?us-ascii?Q?PtD+K2lSlDM+WVYyYYG6Vusm34lpD71pwSGhzhoHxue0s80n0TS0cBR4Xei9?=
 =?us-ascii?Q?jXA77TIfvK6fBX8aNu74wXKLetcgE8X4r1GkdIGUweSHfBObMYqlkXmmcioa?=
 =?us-ascii?Q?GVxmXcBVqEAKviQriqKPbSQUIpdiN8c35xrk8kpdMe3n276blsczWbtHWnxk?=
 =?us-ascii?Q?D30buiucCNooUHd8joDLX2F/XmTB6kBU6Z4+QelSrS6jo37dg9THkaIx+UGK?=
 =?us-ascii?Q?KSTJ43Ed8KEOvxOBvzU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6455.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 160ee413-65fe-44f2-ecab-08ddfb2e7693
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 05:51:53.2620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6sNSNqcBaiQ8S/3aYjVo1fWzK6X+FqTCHs2dif40RKyWXE1kcXcficqTtZxFolCb4wuQ7jnsPL0DSuE/hXqghw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9502
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Alexander Lobakin
> Sent: Thursday, September 11, 2025 9:53 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Kubiak, Michal
> <michal.kubiak@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel
> Borkmann <daniel@iogearbox.net>; Simon Horman <horms@kernel.org>;
> NXNE CNSE OSDT ITP Upstreaming
> <nxne.cnse.osdt.itp.upstreaming@intel.com>; bpf@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next 4/5] idpf: implement Rx path f=
or
> AF_XDP
>=20
> Implement Rx packet processing specific to AF_XDP ZC using the libeth XSk
> infra. Initialize queue registers before allocating buffers to avoid redu=
ndant ifs
> when updating the queue tail.
>=20
> Co-developed-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h |  38 ++-
>  drivers/net/ethernet/intel/idpf/xsk.h       |   6 +
>  drivers/net/ethernet/intel/idpf/idpf_lib.c  |   8 +-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c |  35 ++-
>  drivers/net/ethernet/intel/idpf/xdp.c       |  24 +-
>  drivers/net/ethernet/intel/idpf/xsk.c       | 315 ++++++++++++++++++++
>  6 files changed, 405 insertions(+), 21 deletions(-)
>=20
Tested-by: Ramu R <ramu.r@intel.com>

