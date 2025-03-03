Return-Path: <bpf+bounces-53100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68381A4C6E6
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 17:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D30F3A639C
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631F72343AF;
	Mon,  3 Mar 2025 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XhS2s4PN"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AD821B9D9;
	Mon,  3 Mar 2025 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018530; cv=fail; b=VLrNrDmH7/80BNq9+b6u7+0X5ywyxv3WaWn1ysXu2RM5nJfgsfLaIrPWHdGEPmgJTmDKwUNZL43COyM028iNTa/SS68jzFMz5CGQOXEPAZNNAl62bt/zvtV77rzexd5b5VyMGWxgeEWOg0A+stpg2/6pMUPaDAGqZJvOCCKKvaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018530; c=relaxed/simple;
	bh=rF6OP6qFh92lLgQUgEFVhibrVwhuAo80+WsP+zTpzVI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rJpj9YYfL7dQWifBso0Rb80TSgHZywU9NgKB27C2QzISA6Ux9Iv1H5Q2aTQzTfy2kRB/6RKwSyfhIXzy93uDNJxiUUUJOVJ1bHe7S1+6L/bxfCGACZ8X0Gyniv7k5gSUplW5fUB/Tf8mlgQGzTddq2snLA2rpaApErlkgqINmKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XhS2s4PN; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741018529; x=1772554529;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rF6OP6qFh92lLgQUgEFVhibrVwhuAo80+WsP+zTpzVI=;
  b=XhS2s4PN/TPOtKJrH2j5e1Pzgl5Lb40JnzujpIMF71w+l9Q5yDszSWjG
   fkjsNYWZaiaM51QHZ+4SVGQGAsDQF2nF0gwKUBtT/Je8221Gbl/07h76D
   g/gUI1v5j+98RHTCw0BicwVQmGZu22XWyWf6+8mV7PPqeyXOKrlDpUTFq
   EfcVu7wEbV3xiH8oA9X50gXMU4+SQN/ZJzLI3zx/dgKZsM+P9pJuZXSCf
   yTOilOI6POFljHUAiUKtooLjnorV1r/1+1c2fWdw0aUUXl4hLxozrIXit
   38K6ImGfo/9Woab3Wy9PkkdLvvn7wXZ5qNLCWeIXLnl1fKXfcDMDjglYP
   w==;
X-CSE-ConnectionGUID: F2ghXfBnTiWNCFhpF+6dsg==
X-CSE-MsgGUID: 8JgwzwNMSTCfJT8bJgfYtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41608883"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="41608883"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 08:15:29 -0800
X-CSE-ConnectionGUID: UaVRP+A1TiK4DD7KphgtjA==
X-CSE-MsgGUID: fWRVCmsSRumtUTGcAQyUGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="141292946"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 08:15:28 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 3 Mar 2025 08:15:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 08:15:27 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 08:15:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k76veAocEAUJKVnS8JCu7hsCirDL2Hx5TxuCoSYoOIn81UFtPS00LjVVfe8dheFTaKGTLL3b6CR1E+fOgseaFAIMc+9anv2YJ99psLp65szQVJLjzNsTadb1A7UsTeZiJyWM6BUgy56Xqzc83QBl+uC1jr3xSvM4Uv4OfPqLeVneAGbLRwyUKDWi/zy5VfCs/vmmm0dDazdDRxi3cFYzBy3Cy3wMFRaCNxE7rGjNibtw4W3WZciLq4LWft5tC1FWkoiRFhCCZDh6Mnea+Ym/2vJpL0LTbGzpcRG7SKN7hxZ3zJyrYH2dJ2fBUwiv9RILHDtOygZQYp1SkLvwhdxFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FO0vSGbXr4JGtJlTTe4F45Dfxe4E7A+1ZZ07Qd/QjDo=;
 b=xiX9OgxqUXfkjC3Na42FbJKuVo5/gX7emva6iVOFnkkNieA8AGLYCz+CeCAiB0v1Lv2qiasC04gmJJJ99rCl05D05aPUPNay7Rp3P81G5J5isNLilmw3xqgnf7Sk7XDN1Uvf0bRJCrKEUY3U+57vZG49+mg17HZ+K7uKGbiCnRge2hHx680yUsp/p4OlPA+ctlAxtlvmlNSaW2IxX1QZS/XIMEGiw9aFDnFwROrE3FGTk+tT+OCcjiy6tJiyX4T4CSjTSDUbS8H8iMtbqkqMeOQkKagRXJTY7BM90nuqUP3luN08G7NMlb4eASqup+kB4CMzoa5A1CUMndcD0z+FuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB6523.namprd11.prod.outlook.com (2603:10b6:510:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Mon, 3 Mar
 2025 16:15:23 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 16:15:22 +0000
Date: Mon, 3 Mar 2025 17:15:11 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: "Vyavahare, Tushar" <tushar.vyavahare@intel.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/xsk: Add tail adjustment tests
 and support check
Message-ID: <Z8XVj9XESLIYSwaT@boxer>
References: <20250227142737.165268-1-tushar.vyavahare@intel.com>
 <20250227142737.165268-3-tushar.vyavahare@intel.com>
 <Z8CtO2enntB/lrnp@boxer>
 <IA1PR11MB6514D321A1123B8C280875018FCC2@IA1PR11MB6514.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA1PR11MB6514D321A1123B8C280875018FCC2@IA1PR11MB6514.namprd11.prod.outlook.com>
X-ClientProxiedBy: ZR0P278CA0031.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: df59f9cc-77e4-44d1-7dbe-08dd5a6e99ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xbR5QlE6oHxzuH3qCZh9daZPrXQiM2IgbtCQLN0hc7SnqbcCWf9kIkH0h+GM?=
 =?us-ascii?Q?sUJih/26EanFTUYJaZ9mLetSVa3CUe7dxWlHk8AiCQ+fEx+JAQ3Kw3lQUsOl?=
 =?us-ascii?Q?71NucdYy9JhlY5m0JHbG+HgmoIuoSqhCRHTRGJgFl1N4WpEb2Sv4AxUfkSlu?=
 =?us-ascii?Q?z0Kpl4lNHjo+Fy5zo4MD+M4dGhA/LYH6mfW9EMoxi8kF2mP+9azJZjiXzQ0b?=
 =?us-ascii?Q?c4fW5a0NAy8APOrcnYH0H+PMmh/cZ+Q4ci8+ZZAKQC9p1YUoQO+tSNOqn3LP?=
 =?us-ascii?Q?4hM1jWV4tZq553U+AgX62LIluC/PnYlbFlcRn8uwgJH9WTN6JwSXqFDR0GrJ?=
 =?us-ascii?Q?EaRBiZ9WE5Y8vgQuNSyYrjF2/r+h/mhCcfJOcZq1moaYSwg7gYsib6IdXDYi?=
 =?us-ascii?Q?xwi3d4om+4lQcuQ10iKwndemf/kpSQho1eYgYrjRcBT75lueutPSc98twhJM?=
 =?us-ascii?Q?eMunw3cwJRsOoHh1Z4vPWK9iKVdYeS3oZxQHwXvFN2s0xz3MioTJsaZODaSB?=
 =?us-ascii?Q?y43MDMLg/E0zBGEcX69gisZCdrto+MjH5fQ967WdsSc3oIhgcw6yvto6mOvl?=
 =?us-ascii?Q?KDfPqv4H1JmebPCRIKwgL1aWOcLUZ52Ea7Nc+m9LkwumNBUu/0wSlQ0Ml+FK?=
 =?us-ascii?Q?DlxXjYmsDJCApuyTPPPTup/qUAKqe7Fyjzs3IU1HxDiQ3l4XQkC+xLOFdY9T?=
 =?us-ascii?Q?qpBpctkfAES96ASFdJxwjqfubJ0urSWSYXBYARg66BxxBvLjncC8Ir9ouwW2?=
 =?us-ascii?Q?NQl0iWlKZyiWRe2EAeg+r2/frjbGV+4hvWkhZrDCmkRariO9a7ug4orEYUwS?=
 =?us-ascii?Q?ch3XDJBn+mCDJp8wRwdtyjzxcb//insi6CX1cc0opahbO0eKv8nNbRjF7H/i?=
 =?us-ascii?Q?Gl5XCZqsVQQ7mFo0UI1EhVZ2q6Lex/ILzRs3tNbpDOMd2ggXHGyyUOjuVYq1?=
 =?us-ascii?Q?fmsnu1XLJyfxfhivI0y94HcGeT93ua04ugBSVN4CkGdWoha87aMgvsiDHvg+?=
 =?us-ascii?Q?4+jSvoB7sAufs5REmmS6m/dEID4QsdlwQIOMTQfwj9MK2ITlkvow0d+6q4Ii?=
 =?us-ascii?Q?odt3b9TNgTw8jULB2CyLZAeoMcEX2kzoFjvqDGU9FHw7tBC5rg1LBXo+Gsn/?=
 =?us-ascii?Q?nipHT4+GtkJVT3lMzZClfpzFjBxuMcQu0brSt5hnJ43dFys9irO3dGk3ra1r?=
 =?us-ascii?Q?bayf/JFb7CiolY/sgtHnP2cfYQF+uh89BgtSvveSKuEdnvHHbTXCWiWJE/sA?=
 =?us-ascii?Q?AVWnajJIwP6vA5XhcGorSu4iDGG2eBTzOuhE+Ei/W6Kv/WsAyxmZgRfThSLC?=
 =?us-ascii?Q?Af3DNRvFlzD0Qp4ITnTgorCbe9VovS1cU59GXs2Ojw0MHDMOEV2Thq8OtTWg?=
 =?us-ascii?Q?zhFwL97xT+V2uaSs8lQtL0bIWgiL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ElvCTwZs6vUM+mfxBXZSalbjW5vQ0htDb+U1Gw7CyE18ARBdC4W+I4mKrHhl?=
 =?us-ascii?Q?RLgO/u8m5t5IrVzolEQuRW2Tcy2mIhG8z8nxjciQ1nPnxebhYVNLJqHZaf2+?=
 =?us-ascii?Q?ZdfOTkzPKNLfHx4atGyAH4rqKcqguf6vU6JPHVykYzR4GKfSdV0iG23tc634?=
 =?us-ascii?Q?dh/lT/p13rtGKnyuHIw52emDsIksqRjqUDNXcY8OMd8By65sUMF2jLx5XFvH?=
 =?us-ascii?Q?Ij5OGipS/HCjDzyqFw6LFyU3CKjckIaG8JQojm+j9ReLhnOF9ig30Tl5p7QL?=
 =?us-ascii?Q?+js4bPnRcyE0sIWGzGLuNMxE28Qu8CHFqeycP+HDmhplfzRwwYGXt9eCrDms?=
 =?us-ascii?Q?GtPZPXNqPTYgsTw9r4ZitfgcNoQ+ia72ic1ABOPZlziDaz/Zx3IlE+Vh5/Sk?=
 =?us-ascii?Q?Z+WOElyZ0HeQKuar+l+QmH33vAx5D4klFxtQ/UVypqQI9/8ELtcjiTlDdyji?=
 =?us-ascii?Q?GKgEsdf69z2qIKa0zy8SDrzKkDHJ+ekhLpnhw1dZzPS506bh5ff0BKbSnTC3?=
 =?us-ascii?Q?Td1ZtsfqRtpbyQX5nCPUbW8bv2jTINH2WgTq/7xxRRYVkf0G4h6dVNbLulF5?=
 =?us-ascii?Q?KEdI3JHq5rHoymr2uc0W3H7Z4/6IjwcHlizjik1KJ5RAerJdsl6lY/8GhOLZ?=
 =?us-ascii?Q?P1EC7Fn30SVu8hpy/AGiSVhMM63xZDqhEAtdLenQwVFw8kOsHnPup/mC2vLc?=
 =?us-ascii?Q?SEPYpCFLLunZ6jxVXUFFDFP4L8pRHsFKN7kmsioqeTc1Vv+mR67wWispd4+F?=
 =?us-ascii?Q?FRFX/UrJciLe1n6oJ3FzPbONnjYM47Sj7rwURGeRltWd5KyrAYsp4/k/WwZ+?=
 =?us-ascii?Q?/ZPJeFZD7hfMMdJU8dPeu/pGDISoLrBUkaqXEnHxE6OkrGiE2lTC3TTYlhxX?=
 =?us-ascii?Q?9AEbgsLhj36kdg1kTXDqdhYILHWbZwbafjyRK87l7a/UviR19L61m/NyWbrg?=
 =?us-ascii?Q?b/+HBYk6H8Hxe+J8unTX3GFwKZkGedkBE408j4nuGQpZcRBGgJcUyS56m3QT?=
 =?us-ascii?Q?l31Rl9AsrLAuchUViXu1GBKkteSy3oOloKRnyE0yrqkszRLjiQFAlJneKPsQ?=
 =?us-ascii?Q?TmSE0SOMIRwtdIFx7J9wyGcFtUBgBpgtoYeYAeIk+eLDkVf8d70DwLgnp09B?=
 =?us-ascii?Q?cC8+h/cnNwnHkDzFQb4epGixTBLoNZECGHeyG7PfoDhQu7roys7QHWlg/qnq?=
 =?us-ascii?Q?jGiWPF+i4qZeRdPyBR5wDNuQk6hQjoo7+is7bLL+KLyJRrdw08r54+wpidB/?=
 =?us-ascii?Q?SKCS5DXbJ7t2AZkYHJC0Kg2F8H7s3wv2DhA7xk/I1Ql6Qx9o3bBvCs+Mp4y8?=
 =?us-ascii?Q?X3TxuZW8PuPdvdOVUWPg92TqQZoy1sK9ix5jzFDnLe7M9fjns25cVHOwUR6U?=
 =?us-ascii?Q?pzCLuevhaNthwg0Bb8jtaFAXm1XQTi33gP2mZQCOOwyqfy3Z0NqeFXf7aizB?=
 =?us-ascii?Q?4nUQuBJj0Lelnzl5GhNMmEB5BEP1XHVbAU0d+cqnEFFDKkCzgA//Ws5mmk6Y?=
 =?us-ascii?Q?KyEO/Zh0E/C6hzVfbMsnQL1ggfHRRzSMXfbBVHYpOZy2g4wA28LvwlSCGWZw?=
 =?us-ascii?Q?tynLWOCoGZo47JytcXb6oIiUhM28SG9+uAxW1diAzXFhM3g4WKlb7bAkCxKw?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df59f9cc-77e4-44d1-7dbe-08dd5a6e99ab
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 16:15:22.8946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DpyaTjrC4a9O7e27XoZDpVUGqZXL3f9ptu4NEti/9RZAKso/HjUQIK4xN0/IbwxS6D8N4rjysUSQX5j1UkrY8GiTPp47bYatENwMZXOYEZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6523
X-OriginatorOrg: intel.com

On Fri, Feb 28, 2025 at 10:56:19AM +0100, Vyavahare, Tushar wrote:
> 
> 
> > -----Original Message-----
> > From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> > Sent: Thursday, February 27, 2025 11:52 PM
> > To: Vyavahare, Tushar <tushar.vyavahare@intel.com>
> > Cc: bpf@vger.kernel.org; netdev@vger.kernel.org; bjorn@kernel.org; Karlsson,
> > Magnus <magnus.karlsson@intel.com>; jonathan.lemon@gmail.com;
> > davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com;
> > ast@kernel.org; daniel@iogearbox.net; Sarkar, Tirthendu
> > <tirthendu.sarkar@intel.com>
> > Subject: Re: [PATCH bpf-next v2 2/2] selftests/xsk: Add tail adjustment tests
> > and support check
> > 
> > On Thu, Feb 27, 2025 at 02:27:37PM +0000, Tushar Vyavahare wrote:
> > > Introduce tail adjustment functionality in xskxceiver using
> > > bpf_xdp_adjust_tail(). Add `xsk_xdp_adjust_tail` to modify packet
> > > sizes and drop unmodified packets. Implement
> > > `is_adjust_tail_supported` to check helper availability. Develop
> > > packet resizing tests, including shrinking and growing scenarios, with
> > > functions for both single-buffer and multi-buffer cases. Update the
> > > test framework to handle various scenarios and adjust MTU settings.
> > > These changes enhance the testing of packet tail adjustments, improving
> > AF_XDP framework reliability.
> > >
> > > Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> > > ---
> > >  .../selftests/bpf/progs/xsk_xdp_progs.c       |  48 +++++++
> > >  tools/testing/selftests/bpf/xsk_xdp_common.h  |   1 +
> > >  tools/testing/selftests/bpf/xskxceiver.c      | 118 +++++++++++++++++-
> > >  tools/testing/selftests/bpf/xskxceiver.h      |   2 +
> > >  4 files changed, 167 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> > > b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> > > index ccde6a4c6319..2e8e2faf17e0 100644
> > > --- a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> > > +++ b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> > > @@ -4,6 +4,8 @@
> > >  #include <linux/bpf.h>
> > >  #include <bpf/bpf_helpers.h>
> > >  #include <linux/if_ether.h>
> > > +#include <linux/ip.h>
> > > +#include <linux/errno.h>
> > >  #include "xsk_xdp_common.h"
> > >
> > >  struct {
> > > @@ -70,4 +72,50 @@ SEC("xdp") int xsk_xdp_shared_umem(struct xdp_md
> > *xdp)
> > >  	return bpf_redirect_map(&xsk, idx, XDP_DROP);  }
> > >
> > > +SEC("xdp.frags") int xsk_xdp_adjust_tail(struct xdp_md *xdp) {
> > > +	__u32 buff_len, curr_buff_len;
> > > +	int ret;
> > > +
> > > +	buff_len = bpf_xdp_get_buff_len(xdp);
> > > +	if (buff_len == 0)
> > > +		return XDP_DROP;
> > > +
> > > +	ret = bpf_xdp_adjust_tail(xdp, count);
> > > +	if (ret < 0) {
> > > +		/* Handle unsupported cases */
> > > +		if (ret == -EOPNOTSUPP) {
> > > +			/* Set count to -EOPNOTSUPP to indicate to userspace
> > that this case is
> > > +			 * unsupported
> > > +			 */
> > > +			count = -EOPNOTSUPP;
> > > +			return bpf_redirect_map(&xsk, 0, XDP_DROP);
> > 
> > is this whole eopnotsupp dance worth the hassle?
> > 
> > this basically breaks down to underlying driver not supporting xdp multi-
> > buffer. we already store this state in ifobj->multi_buff_supp.
> > 
> > could we just check for that and skip the test case instead of using the count
> > global variable to store the error code which is counter intuitive?
> > 
> 
> Thanks, Multi-buff is supported it might be that growing is not supported
> but shrinking is supported. We have difference in result for shrinking and
> growing tests. We are handling these cases with the existing 'count'
> variable instead of introducing another variable to indicate or access in
> userspace.

These tests were supposed to exercise bugs against tail adjustment in
multi-buffer scenarios, hence my comment to base this on this setting.

I won't insist on simplifying it if you decide to keep this but please use
different variable for communication with user space. We're not short on
resources and count = -EOPNOTSUPP looks awkward.

> 
> Here's the result matrix:
> Driver/Mode	XDP_ADJUST_TAIL_SHRINK	XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF	XDP_ADJUST_TAIL_GROW	XDP_ADJUST_TAIL_GROW_MULTI_BUFF
> virt-eth DRV		PASS					PASS					FAIL(EINNVAL)			SKIP (EOPNOTSUPP)
> virt-eth SKB		PASS					PASS					FAIL(EINNVAL)			SKIP (EOPNOTSUPP)
> i40e SKB		PASS					PASS					FAIL(EINNVAL)			SKIP (EOPNOTSUPP)
> i40e DRV		PASS					PASS					PASS				PASS
> i40e ZC			PASS					PASS					PASS				PASS
> i40e SKB BUSY-POLL	PASS					PASS					FAIL(EINNVAL)			SKIP (Not supported)
> i40e DRV BUSY-POLL	PASS					PASS					PASS				PASS
> i40e ZC BUSY-POLL	PASS					PASS					PASS				PASS
> ice SKB			PASS					PASS					FAIL(EINNVAL)			SKIP (Not supported)
> ice DRV			PASS					PASS					PASS				PASS
> ice ZC			PASS					PASS					PASS				PASS
> ice SKB BUSY-POLL	PASS					PASS					FAIL(EINNVAL)			SKIP (Not supported)
> ice DRV BUSY-POLL	PASS					PASS					PASS				PASS
> ice ZC BUSY-POLL	PASS					PASS					PASS				PASS
> 
> > > +		}
> > > +
> > > +		return XDP_DROP;
> > > +	}
> > > +
> > > +	curr_buff_len = bpf_xdp_get_buff_len(xdp);
> > > +	if (curr_buff_len != buff_len + count)
> > > +		return XDP_DROP;
> > > +
> > > +	if (curr_buff_len > buff_len) {
> > > +		__u32 *pkt_data = (void *)(long)xdp->data;
> > > +		__u32 len, words_to_end, seq_num;
> > > +
> > > +		len = curr_buff_len - PKT_HDR_ALIGN;
> > > +		words_to_end = len / sizeof(*pkt_data) - 1;
> > > +		seq_num = words_to_end;
> > > +
> > > +		/* Convert sequence number to network byte order. Store this
> > in the last 4 bytes of
> > > +		 * the packet. Use 'count' to determine the position at the end
> > of the packet for
> > > +		 * storing the sequence number.
> > > +		 */
> > > +		seq_num = __constant_htonl(words_to_end);
> > > +		bpf_xdp_store_bytes(xdp, curr_buff_len - count, &seq_num,
> > sizeof(seq_num));
> > > +	}
> > > +
> > > +	return bpf_redirect_map(&xsk, 0, XDP_DROP); }
> > > +
> > >  char _license[] SEC("license") = "GPL"; diff --git

(...)

