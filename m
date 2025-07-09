Return-Path: <bpf+bounces-62778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B49B8AFE4CD
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 12:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385F0188B8EA
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 10:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4DD288512;
	Wed,  9 Jul 2025 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oHRj03mV"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC1B283CBE;
	Wed,  9 Jul 2025 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055227; cv=fail; b=q1WXnUFlN2N/tsW9kNIJRud86lzpjakMTAcGPuNwe8I25EICKcZiVKBRSq0U2f55knrX2z15M0LZG52kU1Bz/noB0zmVVtLGNoHnxgfXB96TpQ0nnsy3MraRvxdQdkt4ahk9tBv+Ee4WyhYIhWV9RjHQPQrJZW+GcpCn01/NHDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055227; c=relaxed/simple;
	bh=jbmwlAN4PxVMBAZc3MslrQPL/Jkh6fXOu86QNND/7Do=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lTdAYgoYdWIYt7zOYYv24QHjJvBbT/q9zW8hGhGcnsU+FDoL4XdKg70qYbVY+aezS/GRC+nMCgrfzDYaosL5LKsScw11It4Vvyf+af7nfLfGjfBYSHSCjwrDx6gwnmN++ICKX5qFBJY7R+zSITHhSpzVx7+XJzFMrUr3p74BHvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oHRj03mV; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752055225; x=1783591225;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jbmwlAN4PxVMBAZc3MslrQPL/Jkh6fXOu86QNND/7Do=;
  b=oHRj03mVvBDIStOgqQtdUsL+od6Vz+pcY5OMabM94b+y25q2EpFZyn+8
   R+dxiPZ8Ak96Vd5lV1NutxQinQ/sSv1bBHFv54LkSjRW4lUnHZ9mPCLca
   iUVUIoUJ5rxQ6RKHJXY8q6QefrebrWz3t2C1FcIKOF4GTA03rcH9daC6p
   qMrLjdSzqVoRBJqZG20rqkNh32+Gl1uqj0mt43/LQNNAJTEZC0xV+5BMw
   NI3iNmBrt0YA3R9Mg95gG9/1UjKkkw7QTEAg9C7rpZy8ygHz6CO4RFhhs
   dS3uotZBX+UzK9BDFgUjmkKlvGSeAhKurlkXkRFGxujpwTiSiSTjETm70
   Q==;
X-CSE-ConnectionGUID: +wVEPcN7Q3KCU/1Elw9YaA==
X-CSE-MsgGUID: qxjLNiDVQSevKcUv+h36Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54029110"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54029110"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 03:00:25 -0700
X-CSE-ConnectionGUID: cEbzcle6QjyZKl6BTWdJeg==
X-CSE-MsgGUID: ItjNuvKoTwOh655siZeFBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="179419175"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 03:00:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 03:00:23 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 03:00:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.78) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 03:00:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAPl7eeZwLDQ+QrcZWATFJ2R7K9yA17fU3XyPKX0sjqFGEDqtcrJ7ARr3uCW7KbTKeqCrZO3eLb6QpjShayDX2vD1An4A3HzG0DShHZBOROex3h7SHUbAl7vLEXSWl8OMCfHJxfj/P9aXFrZuQ37RTYRSamRhH4CiZCc3sVPBaBcTYK5DJ25kpd351nDXj0ccIsr4uFecx50rZ5Y+a8BCmd0A125mnYVKXORZxBdnr3f8sA1UjeWdDWT/Q3Lv2uV83t5WC3UsUiR/X9GnhC1PqN/ZcktcitFJIqDTRl9LtERq02FJ9kyDf87iofUuj3c2PJ8IpwBMmofIaVFa1gsyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/5GvGXP4LA6jal5yTYlgy6xfQy2dtmvZeIeWH9c6yA=;
 b=jJ69QDFWxDnnjPNEe0kU6AsiQO/v4yVewmvr7zQ+ca73PtFcvqze2EIT61CaWD0s3zL1gu+D1kuy97eXhaY8tEFtIN6Qxu7tnu8UH3sonMqhLM7JvaMc52XH1rHRBprmykCvAzFQ/HU6hoKNDaH/3ikAc3JRnaxxE/i7265zvYj/yjeLINCHCTtzlM9bXI7EzqolHqHCMxFcXVojPTltnaIDF882fZeMOJXWnniuvf5CDkUSX43Kah0T0gIyp0hf56xghX0nDWdR+uWI7KpCSMFxkCuc8YVOU5Ev68qPaM+j07ZMWjJs1oiV0+e4PQ8QaofOrJ22+K5L1FAKT8M9yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM4PR11MB7759.namprd11.prod.outlook.com (2603:10b6:8:10e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.27; Wed, 9 Jul 2025 10:00:22 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 10:00:22 +0000
Date: Wed, 9 Jul 2025 12:00:10 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>, <bpf@vger.kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<netdev@vger.kernel.org>, <magnus.karlsson@intel.com>, Eryk Kubanski
	<e.kubanski@partner.samsung.com>
Subject: Re: [PATCH v2 bpf] xsk: fix immature cq descriptor production
Message-ID: <aG49qrcYiapvMFFV@boxer>
References: <20250705135512.1963216-1-maciej.fijalkowski@intel.com>
 <d0e7fe46-1b9d-4228-bb0f-358e8360ee7b@intel.com>
 <aGvibV5TkUBEmdWV@mini-arch>
 <a113fe79-fa76-4952-81e4-f011147de8a3@intel.com>
 <aGwUsDK0u3vegaYq@mini-arch>
 <aG0nz2W/rBIbB7Bl@boxer>
 <beaab8ec-d11a-4147-b7f4-487a4c3fe45b@intel.com>
 <aG1aMOmnb-6K7syY@mini-arch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aG1aMOmnb-6K7syY@mini-arch>
X-ClientProxiedBy: DU7P251CA0002.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::26) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM4PR11MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b2c805-90bd-41e7-40cb-08ddbecf6af4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lsm0OWkVFn3tfF97FRbeeYoNgvF0nA0iZDXhDY3T4E0lnmMTUD1m9RQUOwrv?=
 =?us-ascii?Q?JH4QRXjXq+BeDhc6u+uIdHeK+Kgvp/piepIS29CDHX8C+yWvMUyK0QMHPCB3?=
 =?us-ascii?Q?8SyoCJPs8WoWeFemKXnFP/nCA+YQhYCr10W2oB+tBGQx128FMXGXqctKKmN5?=
 =?us-ascii?Q?zrmG2chp6IS20HKkdYKibEtD9+TLPmWGXmc9Ux2hT6f71IvRPyNjoFd9wgeC?=
 =?us-ascii?Q?zyaCy2JHr/cGYYYFy/Z7xK09/BYTgsrQYH8YVCiyuvZIvVfo4vJRKn1YHcjf?=
 =?us-ascii?Q?QF/2iDdkoBQY+uy5EK1DcdMYP0/fADj4tAL739fMd8yMrqLT6yDQCT7gIPiZ?=
 =?us-ascii?Q?+pKqx1y/jkYm3bwqFrJY2XIT/YiOQsAPM6pArAveQm6i0O+BQ2dqlb5eSlZL?=
 =?us-ascii?Q?LCwls/1kxHhxp1lKrM5le2p8Khv5GCarnCYmciZb94cv+7v8PitOW408bvOF?=
 =?us-ascii?Q?7+q32mHg18Bk8K6Zm3aXU5RC18iZDAs9YeH/wwtYz2EF3KFWReSiy8dMv7eP?=
 =?us-ascii?Q?Q3CSt5/7fCoGmgAxf2PZJyuNsK4+PC+u2CqHBGNot776kJgYK3jK6hArKdys?=
 =?us-ascii?Q?nf6EA7cGIUJho3zXOHZ7cLOS7fY91x47hArHE6gOrCB5WA66SeNNwmHCh6bl?=
 =?us-ascii?Q?fAM6MUVZGNfwznOC+SM/9g8nsfNCRwxiMs1XHimY1DwdCCTJWchQUxsUxhCt?=
 =?us-ascii?Q?lE+FMXYtqD1od426dvfJmKLKsi5vOHHWBw3gqBb8WtU+X4dMihjPMzaIR2d/?=
 =?us-ascii?Q?v1AOUj6kbMuUgqtHpj6O5IQiW85zzoSpoDB0vHSXxXPK4BmRiYHXocTRIFDh?=
 =?us-ascii?Q?bm1s/F71NIS2Zf+i2/dZB1PB8HUo7eQAFPn1TFR3G76uiunz4Sk2KG7Srtag?=
 =?us-ascii?Q?JE0tHjUdw5NAOC1xYl5MdMD2Q8twTI0pxRMOi5I2QznnbS7kKME3/ew4NUtY?=
 =?us-ascii?Q?CqLn0mY5aCj1K7VY1Ie2+8C5nsOo8yCae2u3lOgevRGdEgBePXwm7AmS/fpX?=
 =?us-ascii?Q?VA5ZXatMZ/x7Q6B+jup7KJQ2TmrITCz8cOSksVeyJbDfiwx4+WLngRgMj8Tt?=
 =?us-ascii?Q?nduBqIkG3/jujhm3IrfbLoWEX2d1uuBMonrNkw2Bg22QQUlWgGSdgAUb9v7k?=
 =?us-ascii?Q?8q8Ha+7Aq821EHeQxU1+0d27fIPlQiHKeIG8qvlPgCMH5LFJaIrGWnVCas+k?=
 =?us-ascii?Q?KTv7Lx7Dxb64KQ2Y0JyH7kTbR9sI5sT2DHl55rw525qNVrVeT4m9AdWE1rOp?=
 =?us-ascii?Q?4ijfi7k5/yOAYgvNjmLaerp5kUlqcXt2T0EfZIMUwcQ/HKrjZ0O2x7VOQh9d?=
 =?us-ascii?Q?uff5MEcnPIG3M+QobIKDSODseEvyrqstiKoRjzFibeve0c1T1DTDx8MKaQWX?=
 =?us-ascii?Q?AKUFplc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DDbxzN2e+1Q312B0s24ApqcWpO25QKepjSD4GPbFqFyIhthKR+6I0X8klwNR?=
 =?us-ascii?Q?103xtRWPyVNSeyWrRzDisv7xNwWIl+h0qw2P8LzzEkmwxBGZR0nZWh+QVdg8?=
 =?us-ascii?Q?9FI9BkI3Pat3nxtLxQxziBYYP/RdmPKsJbRCjPKH6Pcriu5xajv6jSaZugvJ?=
 =?us-ascii?Q?CwuRSo/M2FitPdQAInjJAc4xYcdN06WB+bK+c65jMDorcbUwOrmKizrPrQkM?=
 =?us-ascii?Q?Ovz0LTFnkkVFVd64GqWgA0oJOD6pabTAauvVmBwtIsh9sxbDsYyLYYEWEGra?=
 =?us-ascii?Q?Ncm1OhI0DhZhguBNCkBjX1TZQ6SmepE7wJzOLCdZZxOHMp3MmQyiDukf312N?=
 =?us-ascii?Q?ghzPWLiwS+ECbBgmQdWSOaekHi/4cj51P0QgEpzSsyjdVG0et/luj7syyIrJ?=
 =?us-ascii?Q?SnVzZMAJX+eZ7XS837gS362vUucfHodCANDx956aNsLkT1fnwaeclT87g1mY?=
 =?us-ascii?Q?piUBCpIa29Iekhl7yQTN4n6AU79QAByQ2dnfWcEJeSF0w7A2bb/q+Fppa7Rm?=
 =?us-ascii?Q?gM1Xm1Uf1krug7P/nuydtxv7vYlG8qFumGu3AuDC219GE12Lkp/TVoGS1veI?=
 =?us-ascii?Q?2UyDSVIwGy7Vf7r1wheq3uws3xf5m9m65ZuoxtdsCLJBIacDrRjaC6lqNiN8?=
 =?us-ascii?Q?iyP3lwx230zykYNMlMGahh/VvKMNPXTwFJAG77FXp0JVXIpVorHsKqWEv+yT?=
 =?us-ascii?Q?t9RMZ6stsjTy1qkdqWp4NmzZCUWjm1KiFBJfoRZAXa0sQLEbCvsGSsGLLzQA?=
 =?us-ascii?Q?OHtKJboEkYiwLApf7TuHb0drwySRyOPu0PscoKgmQx2a9zQzu4Qe0llSk0Bw?=
 =?us-ascii?Q?anVNXVc02xylzbmuKjzmiaN3Plvan4v2Asjf7cZDIYHR207xcenJD6vjGwzG?=
 =?us-ascii?Q?lkrZTgn42GtyihTfHdNf9ZlW7EJERXb64CmWL0auxLLI+eOqrmEltHN6bGuE?=
 =?us-ascii?Q?LwvCEuT4Kz00cFcVnkoDDjsGRNz3Jji40GPErn7hovmRaaDnn9MbDtycpb8w?=
 =?us-ascii?Q?YzIGpatLs2r7BJtFng5Dp2IazEBca4cY5wd6AT2BlSilEq5OG3UlXF/wI0Gw?=
 =?us-ascii?Q?84rl38rhR1FdNL/nf/8nzw2h7SJNOaKIOGZhDK9xSQ1+CZnu1y2JTITIh1YH?=
 =?us-ascii?Q?int0+rGgg30FNA737fjPofziXrdczv/v1iM0mkcjzXPyqGJbjOCJWkhNjZ4+?=
 =?us-ascii?Q?NHAkbyC7xeI4FSRWdH7BslAbiv2b8UDGwT1NMg6svzDu9nkcGC37EGTdn7d9?=
 =?us-ascii?Q?thO92cvJEP4HvZX0cedu+r/ZP/qVLmG6pgpw5geMu719WWeU1a/qRIIdZ+nr?=
 =?us-ascii?Q?l8gf9LcbvNVhNzAtoiUQ4gz164eHnhG+5uPAT0tKJlqKo7TLIWsaDXPCYISG?=
 =?us-ascii?Q?jSn5SvdPeYY7gpInOuyYTM+lOJTSVgEt1m1NLGHOhiIqd0PAEfs5JtBlDkg4?=
 =?us-ascii?Q?YJ4/gs2H2pg4IIiBbQwJRWp+I2he1ma6qHC4mxs15OzBKVk/8S2UtfpXP3/v?=
 =?us-ascii?Q?BBLa4eFLRaRcEJvZ6+39K5UwXLIR++WhbM25NipmRLAmiEXVQmlVlL5DuuqB?=
 =?us-ascii?Q?K6QjiKRms9Cz3CdPG24SCufis8Ff3aXur4G9FJeXi9BO56neAx3aOgSg8MO4?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b2c805-90bd-41e7-40cb-08ddbecf6af4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 10:00:21.9754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FiAhCG0OilfXdSkUnBBJvFrHFqUbhPkK87iSZqueqjlPQCw8hv5KRHysOhk0w6H1RsXRp7DKf1VDwhckwUTy1lEhIV4XUI0bczos2Xe4OTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7759
X-OriginatorOrg: intel.com

On Tue, Jul 08, 2025 at 10:49:36AM -0700, Stanislav Fomichev wrote:
> On 07/08, Alexander Lobakin wrote:
> > From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > Date: Tue, 8 Jul 2025 16:14:39 +0200
> > 
> > > On Mon, Jul 07, 2025 at 11:40:48AM -0700, Stanislav Fomichev wrote:
> > >> On 07/07, Alexander Lobakin wrote:
> > 
> > [...]
> > 
> > >>> BTW isn't num_descs from that new structure would be the same as
> > >>> shinfo->nr_frags + 1 (or just nr_frags for xsk_build_skb_zerocopy())?
> > >>
> > >> So you're saying we don't need to store it? Agreed. But storing the rest
> > >> in cb still might be problematic with kconfig-configurable MAX_SKB_FRAGS?
> > 
> > For sure skb->cb is too small for 17+ u64s.
> > 
> > > 
> > > Hi Stan & Olek,
> > > 
> > > no, as said in v1 drivers might linearize the skb and all frags will be
> > > lost. This storage is needed unfortunately.
> > 
> > Aaah sorry. In this case yeah, you need this separate frag count.
> > 
> > > 
> > >>
> > >>>> Can we pre-allocate an array of xsk_addrs during xsk_bind (the number of
> > >>>> xsk_addrs is bound by the tx ring size)? Then we can remove the alloc on tx
> > >>>> and replace it with some code to manage that pool of xsk_addrs..
> > > 
> > > That would be pool-bound which makes it a shared resource so I believe
> > > that we would repeat the problem being fixed here ;)
> > 
> > Except the system Page Pool idea right below maybe :>
>  
>  It doesn't have to be a shared resource, the pool (in whatever form) can be
>  per xsk. (unless I'm missing something)

It can not. when you attach multiple xsks to same {dev,qid} tuple pool is
shared.
https://elixir.bootlin.com/linux/v6.16-rc5/source/net/xdp/xsk.c#L1249

Not sure right now if we could store the pointer to xsk_addrs in
xdp_sock maybe. Let me get back to this after my time off.

BTW I didn't realize you added yourself as xsk reviewer. Would be nice to
have CCed Magnus or me when doing so :P

> 
> > >>> Nice idea BTW.
> > >>>
> > >>> We could even use system per-cpu Page Pools to allocate these structs*
> > >>> :D It wouldn't waste 1 page per one struct as PP is frag-aware and has
> > >>> API for allocating only a small frag.
> > >>>
> > >>> Headroom stuff was also ok to me: we either way allocate a new skb, so
> > >>> we could allocate it with a bit bigger headroom and put that table there
> > >>> being sure that nobody will overwrite it (some drivers insert special
> > >>> headers or descriptors in front of the actual skb->data).
> > > 
> > > headroom approach was causing one of bpf selftests to fail, but I didn't
> > > check in-depth the reason. I didn't really like the check in destructor if
> > > addr array was corrupted in v1 and I came up with v2 which seems to me a
> > > cleaner fix.
> > > 
> > >>>
> > >>> [*] Offtop: we could also use system PP to allocate skbs in
> > >>> xsk_build_skb() just like it's done in xdp_build_skb_from_zc() +
> > >>> xdp_copy_frags_from_zc() -- no way to avoid memcpy(), but the payload
> > >>> buffers would be recycled then.
> > >>
> > >> Or maybe kmem_cache_alloc_node with a custom cache is good enough?
> > >> Headroom also feels ok if we store the whole xsk_addrs struct in it.
> > > 
> > > Yep both of these approaches was something I considered, but keep in mind
> > > it's a bugfix so I didn't want to go with something flashy. I have not
> > > observed big performance impact but I checked only MAX_SKB_FRAGS being set
> > > to standard value.
> > > 
> > > Would you guys be ok if I do the follow-up with possible optimization
> > > after my vacation which would be a -next candidate?
> > 
> > As a fix, it's totally fine for me to go in the current form, sure.
> 
> +1

