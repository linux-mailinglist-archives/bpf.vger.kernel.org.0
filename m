Return-Path: <bpf+bounces-72136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E89C0783C
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 19:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908F83B2A9A
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 17:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A07A33FE26;
	Fri, 24 Oct 2025 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLz40ttd"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A5A32A3E5;
	Fri, 24 Oct 2025 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761326190; cv=fail; b=Ae/S8dF0sNPpXzi4ou4DRSl0M1LaY8OENa4ODYrjsxtNtdux76GYGC43AHXARgWsK0k3/GpTEtuwSaLKJJHsidEZza6Qduzy0o2cQyYs7cZvzUozAlI0WO7+iyF7iPaxCEvArOuSJmoztEBLHuGkpkVk/dEBohEj+1bIA+PHvt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761326190; c=relaxed/simple;
	bh=NaAzwurl6BCLPf6tBpoj6/9soFIiC8ovV5fIFPq1jcU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WYlHPIJ44v5oDJdXQiFx576yHtQ1yV6E/By3M9B8OV0e7IFB6C/zPqc2XmFqZJIJPKnQk3tfBhVPLCRElhnwqS5YpiB9z7mDrvf++q3BliUX3UDSJs5wVqiKKiICYn9qcp5hgEjPE+OWtlp4CbduIFut/994G7OOCyZy75+HqU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLz40ttd; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761326189; x=1792862189;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NaAzwurl6BCLPf6tBpoj6/9soFIiC8ovV5fIFPq1jcU=;
  b=bLz40ttd2i1bgvnUjcwm761HKzyYs66e05aLaX8gtDR8Ym/t1AjYEdNy
   DHzrBsm+jZsQXnIuWitffJXI+ajQMliwipyl7Z+AnwIweYZgaWBydJDMi
   EADoY5/0dUejmOVI6cSpikeYQN1Oimi5YvgcqMyKqxQIXfhaN9pNilW7r
   BWiKx2N6u/94cWlC5sNP/vObfSbxAegl0aDBEsWrL0Nu/bpQqBIM2sYXX
   hJiR/K89kvHa878W++c4m525VAnhzI6FjrO7MaQWyKqfdDrIR//ynqBah
   FZE5Q2/vUPbGKLVi+H3jyFpb3XIYbu1289kEEy2kxaVkD9BRieEXe5oQp
   A==;
X-CSE-ConnectionGUID: lmLkq8nYRp+s0HeC0+CdKg==
X-CSE-MsgGUID: d3wt5bRzRV+DH566Fwr/Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63546891"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="63546891"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 10:16:28 -0700
X-CSE-ConnectionGUID: IJ70J9onTgeePj7nQeOvkg==
X-CSE-MsgGUID: RsRQcFaLRj2lSWje4P/uwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="185246348"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 10:16:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 10:16:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 10:16:27 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.35) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 10:16:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhgubeemRDBfyE5adGLA5Qqs/0zj5Xl836sUTO+qtXI4a0CSiifAnxRvrwwRck+E+MnQvm5Lxa5Y094i77geOZX6qlb54+cfEFFO1YyBeRIUk+rY8FKlrcmyehDh57IxqRI9kr5Sb/JJQR19x50UpgHxtiDCkYw8iHrVTS+QZWaNEZddQ04Gj8zRJenjrcYQnTv/Z2ILYucNhSeceLsRwX4B0n4/qqATRJ0wKmCEPUJWJQtEkdU7qC/xerSnkgrVNryKN6Isdfa8knh5RAG2QwP5L/RLdOoQy+aQZ6m23Rs7zJVGtuJz5gAq3gUbUBvAyQluP7XV3I7eG8hs/EH0HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWlO5yysomHGImxivpFia09k/dqTlOvcHlQiudvtp7c=;
 b=q2q6ID0IUFhcQLsCtfD84hlnC2eOP5wvyskwinJwtdk3fGfg8Vt545DYkNzWDoVTxcHXA3MS0iIjcH5B0EcE7LjWQR1K3JMhcEIcEkbRvZgay2FT2QpanWhcShzfsoAoeA8blg/QN7cfgt3xtRMu2/4zo0u6L9MTATLHmryNuhgmlYCiAyoHYL1YxaqV2ONZjGwuRkCxrvOg6FlezEiAuRHuliOkIsjUzTjt9bSWdwYBomO15z4E62dAfv0kgEDQcqtvTNB5hWEVC/Kre7gbtZ+fhHMpYjg1c/XUbUh7lf+BIyCDZW8TwqkKusMUw90d6J+8Aj9golfFHTAn9qn6fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB7367.namprd11.prod.outlook.com (2603:10b6:208:421::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 17:16:19 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 17:16:17 +0000
Date: Fri, 24 Oct 2025 19:16:09 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
CC: <netdev@vger.kernel.org>, <csmate@nop.hu>, <kerneljasonxing@gmail.com>,
	<bjorn@kernel.org>, <sdf@fomichev.me>, <jonathan.lemon@gmail.com>,
	<bpf@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
Subject: Re: [PATCH net v2] xsk: avoid data corruption on cq descriptor number
Message-ID: <aPu0WdUqZCB3xQgb@boxer>
References: <20251024104049.20902-1-fmancera@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251024104049.20902-1-fmancera@suse.de>
X-ClientProxiedBy: TL0P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::16) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6b4868-466e-4fcb-e11b-08de13210b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dT0dTjL7pK2KEVd71fXbb+glhIeZe/LZajjLtOJlC4ZoIuxDK3qAZypEmxon?=
 =?us-ascii?Q?uwgXY5+xBdtkAfiCjnvOZI+XU70qBu0J2gWAaUjuxbJ9nOnq3YVpEeFqgXRj?=
 =?us-ascii?Q?0WeL7/e9gUhmfupOLK/sXrbj+tHTcOS9kMlc4/fM8y9bo3TFTHKKeX0oWS9q?=
 =?us-ascii?Q?ZkpbJcr8RuKNfr1mWa2ftuoTwKQkC0UjFenONCYcUvD/OOU6iCBvQ19X1PpK?=
 =?us-ascii?Q?NJXUPDYVSn/+P2QSGHRebuP3B3tjklQgR2wN6fA9+AYrKpR5Byf8JwhOEdl+?=
 =?us-ascii?Q?NqU8ezm0YxX5j7diJ7GKbl7YjAmNnAmVQJQnchWnAkid2uf6AumEhJv7SUzv?=
 =?us-ascii?Q?ST22M8Fhe6l6Ab3u11+quYUhhUfIZZ9/SgTXqD2EdG9i72L8xaajPQEM95wZ?=
 =?us-ascii?Q?doSjHciez3X48Grkih0sNLFcjGR7hLGs9nuO/97UleXhAVaTqh1OO8PA7mr/?=
 =?us-ascii?Q?GSEe8kQMNtF6Rz8dOsb5SjjTODeNjRy2DtGM+Kz3g5iT4DGbnYzrQ+E61YlT?=
 =?us-ascii?Q?EVK1ulMAkOrkBvBDKcoUdTioVxznGXIT8hTxssleT8WeXcbL4QAoCrnlQ0kb?=
 =?us-ascii?Q?sOjykilySJYhe/AYc7IFwdWTjJ4rvSI7BzHxuP1ZxFfCHD4H3ez5fVUjLMAo?=
 =?us-ascii?Q?NCW21aLXNlaJTX+YOfSy0WAAhS9RTtul0GvxKPDPLCbcH/CrKg4OKtBsMbNc?=
 =?us-ascii?Q?n1TL0Iw8ofjVvAEgkxpwh/QmpYzN0/AFrsnt+vCEU0yQFKpSwlMvwJNJxK/I?=
 =?us-ascii?Q?Fsl7o1z6+DB3bJxWEeqzYlx6CGlTMmA6Tjnvms3tOu+aoCeGH2x2L4A7r0o/?=
 =?us-ascii?Q?Wt+XW5anLunaG6ZQBfQGH2G7NhWNp3eQuIHq3IzOrfT2tgefWD+TgOTp8yy7?=
 =?us-ascii?Q?fKjtF+9ilUDN/DtsFZZcaSA7HhOx4dN2pIXsb3x3Ac+pKfVbRuFLyYxEdG2K?=
 =?us-ascii?Q?16ZX4LT/NCpwgKAFxzvOhqMX1LBkmvmN1Ur0QtpVcaVs4zR0hp1PnelTzWeZ?=
 =?us-ascii?Q?ZDSxK7eF24bq7GiHsqh4M+EW8PoZJ1Svv0xdZW/F2xZruQdagCFU98c8PBse?=
 =?us-ascii?Q?29zdmJ2y5Jw6d0IcCq/kBxxZfg3hcHtwtsetzRqs/4chyD8R+AXLp8yC5ByV?=
 =?us-ascii?Q?gLEuDi2IKDGYn4+8sopo/PeiyxwNFmBTJIBPMMHNWMsN/JxfSPp3reJ4baiy?=
 =?us-ascii?Q?CrRkdzVCfb/MrGtcVdHp4o1dHnIEh92ZTN3tO0AftOpDQIDu43SL3vMhoPYC?=
 =?us-ascii?Q?YiceTVqseyjsLdEQhCoQnyPPCLEIH4OACYk2if9PlahrDIoNz4sIQaewMn9R?=
 =?us-ascii?Q?DB9CCFFy3LjvoAOUM0GKFLDe5q8CIFwesFVv9vNHKGM7r+w119pWWShwjjAh?=
 =?us-ascii?Q?VskZcZw25B0IHN7TFFPVgGUFrJwMiZm7562PRbksTdIRj621Fwt+Pw1kNhXD?=
 =?us-ascii?Q?R4q3VZcs6kxHA1GWhfml/cHm0RsryVTIoPmzMPoY2vcVvmQEVrUXfg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dENkpilh/pyZmf2ff/snqtjMQBuLyRJ+FtlQWhNWUhnG2S73hSbkqSgsFojW?=
 =?us-ascii?Q?kr7K7qIQ5VVAg7aL/Ol3DKEgac2Dw0zweuh5PMrR09ScGxkGNu5DIsPx6c0z?=
 =?us-ascii?Q?VW/AXiDL49zKsgPg4JQyShoksALHYt41mXwicEcgzOL/x+4B9J/WbusPJxOP?=
 =?us-ascii?Q?/IEO9oizMn4n/RKHaHuLNsXUS0MwM6kzkAEaksp0ZjQKetV9K4X0fS9qay8C?=
 =?us-ascii?Q?wa9k+s9cAY/xrSxvHb7HFaIof9cFTpuqapZhTZtxIpaKrRsKSKCc1S0YLRFC?=
 =?us-ascii?Q?EWrFglfM7Ut2AN29XnFv53fyCkWQgJoA+zk/xUQghuP6htpKzAIloAFhWsXa?=
 =?us-ascii?Q?HDLxRwSszW1zuNNTjk/zG7pRLeoy8YR/iD4RgTlPnP1OPmWjh/7gyZqacj1U?=
 =?us-ascii?Q?uBkjBlc5lsRScYYbojAMJ5KfV9+FF9kPQKPWkinNQ//VDV4vmiwqeGXMqkob?=
 =?us-ascii?Q?HdoGAGP/iQuB/jNN2c38UZRl48oIGRqLjbmzwB4qab9tOl5siAqQvwDU+SrX?=
 =?us-ascii?Q?4YlDmYDbSjP8Vs8KT40MVVOTdbpFL9/j0annxwW6UIhSJjEbcl6DLwbXitTg?=
 =?us-ascii?Q?4Jugz8wC1lTMU3oldqIvr6APLNXK/9PQuk18WiyYAJ8J/t0QgLHzlYpBtAch?=
 =?us-ascii?Q?tpsyHTS+bGZB7v+uPVcUGNOSteJa4yIGpI54AWPcfEQbBelCmk9r8c14F3Sq?=
 =?us-ascii?Q?WFrPvehPyuhMRLvgEZu6zG1cr9DsOaVmI1fZpIir5lexdxzH5H8DFBfrL2nx?=
 =?us-ascii?Q?VcqErmyHSwZePdxKil8GThOaYdQWl3LHBVvLHvFpV1A6UVAYbFWkQ4Znx/LC?=
 =?us-ascii?Q?nmbDGhA511dkPEw4OXLPrvVJEJLZ6/P5Qv5s2kGRfp1vUTbzaOXsk/BWCUJz?=
 =?us-ascii?Q?kx14OPev6Gn28tiX8a7+aKg0/SMECRCndfsEFgbz1loBwJkT/Utb6rZumcEu?=
 =?us-ascii?Q?/PXzoshJtecxMvxr0N6V0aUnKY40GXcdc2JtJu9ToQE13GJfnLv6prkUmUwA?=
 =?us-ascii?Q?X6TIfxrnnodkLz4hQaIVHrUB1i0GbEfwFb1a2OSZOukl5Dx46TwLlfEICNLR?=
 =?us-ascii?Q?jnd84wOl1DfRFrkx94JVZXIzjBUFMEx/PFVnopCOkR5/pbuVRR6pgAnfrZ79?=
 =?us-ascii?Q?wvBertIhiYGC3AytuKdKjt6jXl2Flhll3S83agl4pl1Unr2kOg7ZUKSX53Ni?=
 =?us-ascii?Q?Urj/AFq2mz7Pqo4RdW/P15PdO9JKzgDDBbDpuNgftQq6Vqi+Mb/HJY1baSHB?=
 =?us-ascii?Q?Yp8J51pxRv+2tupft2OLqW+zARP/Ua2xJTylQpQUtlbpRT6LzcDGPNT2vudA?=
 =?us-ascii?Q?P75HOVDiEuc+QlPFm+JpYgMJ7QGjAEAS2igZfy4VDkkqKnJYD6VXuinEjigy?=
 =?us-ascii?Q?J0Hxs6BO8iX8RJ6UiyOCbYe07finDC0GIpcV+jHZjc5irVH351CxWYbMFIgQ?=
 =?us-ascii?Q?iD8jbP+K96mYUV0S8p3wn6f4xkae8aCWqwof/b6FUjTyQvWJDuuiZB9lHAVX?=
 =?us-ascii?Q?AagJC3LnEpext2IE/HPGcknHrVK2ZsDeqXostq0AXbZil1OZaiY3OIubpku1?=
 =?us-ascii?Q?VFUHlsVRLapMS194V+ll5LKXPe2zuhG8teFDj9fb8a0ZdykgbeKWRk60RM5x?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6b4868-466e-4fcb-e11b-08de13210b28
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 17:16:17.8164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwpSwTvI9j6r49fYTMCHk/VLuWoucN+zjcXPUemqNqYrtgZUMmfU67PHjKYcbxE3z0xdH1t66u7Vl0fay719ZWwJeO4h4bOkDfLxFZ43H4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7367
X-OriginatorOrg: intel.com

On Fri, Oct 24, 2025 at 12:40:49PM +0200, Fernando Fernandez Mancera wrote:
> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> production"), the descriptor number is stored in skb control block and
> xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
> pool's completion queue.
> 
> skb control block shouldn't be used for this purpose as after transmit
> xsk doesn't have control over it and other subsystems could use it. This
> leads to the following kernel panic due to a NULL pointer dereference.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: Oops: 0000 [#1] SMP NOPTI
>  CPU: 2 UID: 1 PID: 927 Comm: p4xsk.bin Not tainted 6.16.12+deb14-cloud-amd64 #1 PREEMPT(lazy)  Debian 6.16.12-1
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
>  RIP: 0010:xsk_destruct_skb+0xd0/0x180
>  [...]
>  Call Trace:
>   <IRQ>
>   ? napi_complete_done+0x7a/0x1a0
>   ip_rcv_core+0x1bb/0x340
>   ip_rcv+0x30/0x1f0
>   __netif_receive_skb_one_core+0x85/0xa0
>   process_backlog+0x87/0x130
>   __napi_poll+0x28/0x180
>   net_rx_action+0x339/0x420
>   handle_softirqs+0xdc/0x320
>   ? handle_edge_irq+0x90/0x1e0
>   do_softirq.part.0+0x3b/0x60
>   </IRQ>
>   <TASK>
>   __local_bh_enable_ip+0x60/0x70
>   __dev_direct_xmit+0x14e/0x1f0
>   __xsk_generic_xmit+0x482/0xb70
>   ? __remove_hrtimer+0x41/0xa0
>   ? __xsk_generic_xmit+0x51/0xb70
>   ? _raw_spin_unlock_irqrestore+0xe/0x40
>   xsk_sendmsg+0xda/0x1c0
>   __sys_sendto+0x1ee/0x200
>   __x64_sys_sendto+0x24/0x30
>   do_syscall_64+0x84/0x2f0
>   ? __pfx_pollwake+0x10/0x10
>   ? __rseq_handle_notify_resume+0xad/0x4c0
>   ? restore_fpregs_from_fpstate+0x3c/0x90
>   ? switch_fpu_return+0x5b/0xe0
>   ? do_syscall_64+0x204/0x2f0
>   ? do_syscall_64+0x204/0x2f0
>   ? do_syscall_64+0x204/0x2f0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   </TASK>
>  [...]
>  Kernel panic - not syncing: Fatal exception in interrupt
>  Kernel Offset: 0x1c000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 
> The approach proposed stores the first address also in the xsk_addr_node
> along with the number of descriptors. The head xsk_addr_node is
> referenced in skb_shinfo(skb)->destructor_arg. The rest of the fragments
> store the address on the list.
> 
> This is less efficient as 4 bytes are wasted when storing each address.

Hi Fernando,
it's not about 4 bytes being wasted but rather memory allocation that you
introduce here. I tried hard to avoid hurting non-fragmented traffic,
below you can find impact reported by Jason from similar approach as
yours:
https://lore.kernel.org/bpf/CAL+tcoD=Gn6ZmJ+_Y48vPRyHVHmP-7irsx=fRVRnyhDrpTrEtQ@mail.gmail.com/

I assume this patch will yield a similar performance degradation...

> 
> Fixes: 30f241fcf52a ("xsk: Fix immature cq descriptor production")
> Closes: https://lore.kernel.org/netdev/0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu/
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
> v2: fix erroneous page handling and fix typos on commit message.
> ---
>  net/xdp/xsk.c | 52 ++++++++++++++++++++++++++++-----------------------
>  1 file changed, 29 insertions(+), 23 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7b0c68a70888..965cf071b036 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -37,18 +37,14 @@
>  #define MAX_PER_SOCKET_BUDGET 32
>  
>  struct xsk_addr_node {
> +	u32 num_descs;
>  	u64 addr;
>  	struct list_head addr_node;
>  };
>  
> -struct xsk_addr_head {
> -	u32 num_descs;
> -	struct list_head addrs_list;
> -};
> -
>  static struct kmem_cache *xsk_tx_generic_cache;
>  
> -#define XSKCB(skb) ((struct xsk_addr_head *)((skb)->cb))
> +#define XSK_TX_HEAD(skb) ((struct xsk_addr_node *)((skb_shinfo(skb)->destructor_arg)))
>  
>  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
>  {
> @@ -569,12 +565,11 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
>  	spin_lock_irqsave(&pool->cq_lock, flags);
>  	idx = xskq_get_prod(pool->cq);
>  
> -	xskq_prod_write_addr(pool->cq, idx,
> -			     (u64)(uintptr_t)skb_shinfo(skb)->destructor_arg);
> +	xskq_prod_write_addr(pool->cq, idx, XSK_TX_HEAD(skb)->addr);
>  	descs_processed++;
>  
> -	if (unlikely(XSKCB(skb)->num_descs > 1)) {
> -		list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
> +	if (unlikely(XSK_TX_HEAD(skb)->num_descs > 1)) {
> +		list_for_each_entry_safe(pos, tmp, &XSK_TX_HEAD(skb)->addr_node, addr_node) {
>  			xskq_prod_write_addr(pool->cq, idx + descs_processed,
>  					     pos->addr);
>  			descs_processed++;
> @@ -582,6 +577,7 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
>  			kmem_cache_free(xsk_tx_generic_cache, pos);
>  		}
>  	}
> +	kmem_cache_free(xsk_tx_generic_cache, XSK_TX_HEAD(skb));
>  	xskq_prod_submit_n(pool->cq, descs_processed);
>  	spin_unlock_irqrestore(&pool->cq_lock, flags);
>  }
> @@ -597,12 +593,12 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
>  
>  static void xsk_inc_num_desc(struct sk_buff *skb)
>  {
> -	XSKCB(skb)->num_descs++;
> +	XSK_TX_HEAD(skb)->num_descs++;
>  }
>  
>  static u32 xsk_get_num_desc(struct sk_buff *skb)
>  {
> -	return XSKCB(skb)->num_descs;
> +	return XSK_TX_HEAD(skb)->num_descs;
>  }
>  
>  static void xsk_destruct_skb(struct sk_buff *skb)
> @@ -619,16 +615,16 @@ static void xsk_destruct_skb(struct sk_buff *skb)
>  }
>  
>  static void xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
> -			      u64 addr)
> +			      struct xsk_addr_node *head, u64 addr)
>  {
> -	BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
> -	INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
> +	INIT_LIST_HEAD(&head->addr_node);
> +	head->addr = addr;
> +	head->num_descs = 0;
>  	skb->dev = xs->dev;
>  	skb->priority = READ_ONCE(xs->sk.sk_priority);
>  	skb->mark = READ_ONCE(xs->sk.sk_mark);
> -	XSKCB(skb)->num_descs = 0;
>  	skb->destructor = xsk_destruct_skb;
> -	skb_shinfo(skb)->destructor_arg = (void *)(uintptr_t)addr;
> +	skb_shinfo(skb)->destructor_arg = (void *)head;
>  }
>  
>  static void xsk_consume_skb(struct sk_buff *skb)
> @@ -638,11 +634,12 @@ static void xsk_consume_skb(struct sk_buff *skb)
>  	struct xsk_addr_node *pos, *tmp;
>  
>  	if (unlikely(num_descs > 1)) {
> -		list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
> +		list_for_each_entry_safe(pos, tmp, &XSK_TX_HEAD(skb)->addr_node, addr_node) {
>  			list_del(&pos->addr_node);
>  			kmem_cache_free(xsk_tx_generic_cache, pos);
>  		}
>  	}
> +	kmem_cache_free(xsk_tx_generic_cache, XSK_TX_HEAD(skb));
>  
>  	skb->destructor = sock_wfree;
>  	xsk_cq_cancel_locked(xs->pool, num_descs);
> @@ -720,7 +717,11 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  
>  		skb_reserve(skb, hr);
>  
> -		xsk_skb_init_misc(skb, xs, desc->addr);
> +		xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> +		if (!xsk_addr)
> +			return ERR_PTR(-ENOMEM);
> +
> +		xsk_skb_init_misc(skb, xs, xsk_addr, desc->addr);
>  		if (desc->options & XDP_TX_METADATA) {
>  			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
>  			if (unlikely(err))
> @@ -736,7 +737,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  		 * would be dropped, which implies freeing all list elements
>  		 */
>  		xsk_addr->addr = desc->addr;
> -		list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
> +		list_add_tail(&xsk_addr->addr_node, &XSK_TX_HEAD(skb)->addr_node);
>  	}
>  
>  	len = desc->len;
> @@ -773,6 +774,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  				     struct xdp_desc *desc)
>  {
>  	struct net_device *dev = xs->dev;
> +	struct xsk_addr_node *xsk_addr;
>  	struct sk_buff *skb = xs->skb;
>  	int err;
>  
> @@ -804,7 +806,12 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  			if (unlikely(err))
>  				goto free_err;
>  
> -			xsk_skb_init_misc(skb, xs, desc->addr);
> +			xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> +			if (!xsk_addr) {
> +				err = -ENOMEM;
> +				goto free_err;
> +			}
> +			xsk_skb_init_misc(skb, xs, xsk_addr, desc->addr);
>  			if (desc->options & XDP_TX_METADATA) {
>  				err = xsk_skb_metadata(skb, buffer, desc,
>  						       xs->pool, hr);
> @@ -813,7 +820,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  			}
>  		} else {
>  			int nr_frags = skb_shinfo(skb)->nr_frags;
> -			struct xsk_addr_node *xsk_addr;
>  			struct page *page;
>  			u8 *vaddr;
>  
> @@ -843,7 +849,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
>  
>  			xsk_addr->addr = desc->addr;
> -			list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
> +			list_add_tail(&xsk_addr->addr_node, &XSK_TX_HEAD(skb)->addr_node);
>  		}
>  	}
>  
> -- 
> 2.51.0
> 

