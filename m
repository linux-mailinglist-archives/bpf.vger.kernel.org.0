Return-Path: <bpf+bounces-42293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D63C9A20C0
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 13:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D781C21C1E
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 11:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E39F1DBB36;
	Thu, 17 Oct 2024 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YHU7Ks2e"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F721D414F;
	Thu, 17 Oct 2024 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729163678; cv=fail; b=ZlheFJ5G39uy0QoM+5w2f0znwVx9zMGKVdXzdOOfVADSy6WMlpq+BuKhhNeTfGoEiJiF5tY+0Il09TwXrq6ffLo6b1LCIv65viypsWqZJzffcT9RFCUqHhWJE32s9KBxPXCcg3OXW0BIGyunnAq91KcmjD8gqw5UeUlnDjjkNsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729163678; c=relaxed/simple;
	bh=Aw+jOJnz/gSzCSVCGvgFaQ2cxDV4Kkwc+ztEeDsmsfE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JMcQAjeuAtjma3X3qmn1S8uHczuNgTHMhncgrJdT+u99d7ZWmitJE+5nXfxd72OP6XUYPbzqh/cwMnINBCHJehrH//Lm+r9Z/hkqIAf+xWuAF60PvqX/IXA8vciF3MT5Wt6tZFYJqu09v0d+XwPBYXgpHIdHzAdT+c7gn8q/JWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YHU7Ks2e; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729163675; x=1760699675;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Aw+jOJnz/gSzCSVCGvgFaQ2cxDV4Kkwc+ztEeDsmsfE=;
  b=YHU7Ks2eOp5rbkVOSOEb5RdYLRaZsS6jtax1WGOi5j+JiofyWQXhjiiz
   U5Xm1zoBwY4BDPWIKnMkubG5IdSG1JK1RgZpvIEIGzME1Escjo4ra5r92
   fs8WuJwbwrQTCXYlWl/hgsSyAzJqvwtyKiyDMA/zP1Pc0ozY04e1lkIE+
   Z9KuIVBgOqoLCsTiJGj5P5McPEFP0o1qE672NP0rzFh1zDu0y1SCpA1PD
   Du/JSFGkqCTQIjcSURIlhy16orBAsoK0isN/Ml4M98Wcu+8sZ8lc46pwm
   Xjln/z2UB/YhIzhU+h4ydBwJxkIUuIxd95AAUWIyszT8H1Icw4GqSaLg+
   A==;
X-CSE-ConnectionGUID: RJRj/Mn3Q765Fr4R5Rw+7w==
X-CSE-MsgGUID: 18kLGnyOTliwrdgMFu+9vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="28734531"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="28734531"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 04:14:35 -0700
X-CSE-ConnectionGUID: hyc/WgWCQQivzXTzADFgAQ==
X-CSE-MsgGUID: KtNBPgP0SFyR1+psRUz+mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="78952304"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 04:14:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 04:14:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 04:14:34 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 04:14:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnLF8Fu5JSECItCNGY8j1vI4UzSOQ38Q03mc3jN/6jLgHOjnT1q0EKs+4IxuqtD6PwfBc0J8nqSQEXo6Rm3j3vTo6YWAP4DvRkHgUnxxGhZmw2VjkBkopfcor90JtIzCBkcJj+LiQXumEbzqk5PNO+ixvcj+TAq0SkBUsP2fwpoqavtLG2WCDiznd5QlMIZGLXuZIrJKZw9fk/D889ywTPGv5GBFWyx7mcHSnE9O05ABUfTSp4XDc8ppfidujpKCf+XS3xmJe7psUjLTQTzNVzQnGhBSqLb+UUsyiSSBra0mn9Job1raEqPlEmyQSQ/3hN9fwSSszRhnr6jSMNUXQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRgA2EOVxcHFlOrbC9RZEctwf/qPV1x/lvXio/O+NSc=;
 b=m1XWFmiO+LDDCn5NDPdAyw9HlUbbT+1RKv0v8EvK4QbDpu0ZHOX0sptoxKVNKuP+ZPZ3z8vcPgFIWtxwmBdQ6FVaw2dDQghqpzfKWIMc55JvV+0uwr8iqh6JIQVoZfOBodQPsC65M9v04kx7kzeVSvHKR/6eWdRXpv0Y4kv09m07TEQwFeEK2akCQ+sX3T8u+8yj8Z/gcNsJm2Cu/k/CvTzQB2bXmHfWG7L1z0QoLecI1SqMl8FTt4e+zo9xKIJRfwhgrVYega0KITvs1oZL+omIb6EWoSRQdW+YnyvlvNYQi27OhCyoPN66uPEJg8ILcSv1GvtxW5NQBiBlTlhVVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH8PR11MB6998.namprd11.prod.outlook.com (2603:10b6:510:222::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 11:14:29 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 11:14:29 +0000
Date: Thu, 17 Oct 2024 13:14:22 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?=
	<toke@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 05/18] xdp, xsk: constify read-only arguments
 of some static inline helpers
Message-ID: <ZxDxjj4SPT0Y9KyP@boxer>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
 <20241015145350.4077765-6-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241015145350.4077765-6-aleksander.lobakin@intel.com>
X-ClientProxiedBy: WA2P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::24) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH8PR11MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a5cc62-654f-486f-b779-08dcee9cde7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6b4LzUUWDghrkZGIjOcNRXUjZtmGVFCJ6WS2wu5fNuijrrtbLQaoOb/IMGJG?=
 =?us-ascii?Q?EYx6Ogob452HdEipAjzHZtFr3c8kjalC+vmR/u70K8BWg7TruHlosFwoo4uh?=
 =?us-ascii?Q?c6ZTyo+UM6lEl7fPpMUWuJ446E9JvVwocadG4SE3QpM+huBU7N/YCLFod8ra?=
 =?us-ascii?Q?4ANfskFj7PZEx0xDXDWnW9nre1IdtK6m8Vvj9jYih9hVvJpDQjTb3WRy6aGR?=
 =?us-ascii?Q?JuJ/fTxgD5hb+bEW5QBZzVeZdF2T4+AlCIf0kqDzC2OJGKP9nb/nvZy4ZfJ9?=
 =?us-ascii?Q?2HYWDad/EmTd1mL529Y3T7QzzprBHbtoquH3wh8acPeSrm1BvW74t/Lx6gx8?=
 =?us-ascii?Q?y8uzGffrPLPMXKAmlcjF70CFaXNA5drxei6uQfWXoYKNNQEaox4s3QchN+SN?=
 =?us-ascii?Q?Q6wDfAxOL5yIdezpb55Om5zVow6qdWjdK4AfsuFw2r31F+y4szi+cl+zgPn5?=
 =?us-ascii?Q?13KF5GtcYdeHecYMK+c0FC9yYs0085dQCThqjp2P9NFckS97YW8U3CvSO1kr?=
 =?us-ascii?Q?Xrkq+S0EDStPgOMuFYvh0it6Kbn/rgfkOQiSt00bi18zJJntS1PDBOuqxF7w?=
 =?us-ascii?Q?krmvqJ1xTK/wxVi9IT6NcWUrC4zNqo6XI/SoJ8Xb9kNWChlhm6hoq2nGRZ5x?=
 =?us-ascii?Q?oC65Xd3Z9rL2jdN9ZPMUbLxbXxtDmra4E7R294lfA3WieKoCfgTzm//scQ/j?=
 =?us-ascii?Q?3tb6Jm7CZOcMxX48A2/z6i20vzs8HFWOc7IBwRwyha+wTjMAonLZ3zCR6W0l?=
 =?us-ascii?Q?kgXj8CN43piOgRzB7Tv6QBWsoO94YdDDNq9Adjz0OV4be3qaCvTa1ngDSN/C?=
 =?us-ascii?Q?i7r3MwGD4InlgCQQrW40j3NUA6EJhJnN+0n4nAp0iXcrcuM0XYZj/4jhAvYk?=
 =?us-ascii?Q?buAQI7FH8GZIYfmKB0HQb8DXV8mIOfF/kq8qfdXi3dpGVwgJ5YX8FR0hv2Sd?=
 =?us-ascii?Q?NzKj0ghC3BnU0Xu1I2srIoAlGSDfGaeLwE8MSp8dgrplhi4nm30ytNO8EZjk?=
 =?us-ascii?Q?zvCE+88DjsnVWG30Ay85Ym9cOHdW5Tgtu7++6rREV55ntac7h0oTKT2TgNV0?=
 =?us-ascii?Q?Vsukjfpw02XU8tOk1yauN7zx7WCPQBH5lJAk4GktbP/dUbjFojJanwDUzOz9?=
 =?us-ascii?Q?0Hor6xrUagw8ek9dpVfhAZLqfHVfHOD16XObuyFP1ihPCMdlBZ+gGDdyV7vn?=
 =?us-ascii?Q?bCOa/1JpT4V0hEj8EpjB1IRW2h5U/j+H5/BBRtRSg2XeEDy7oSTrW7lhohYT?=
 =?us-ascii?Q?beg2tAHpUTlo9PXImYtyAvAeV88ZJ7Xvh9zj9ZUK2jKxiNELeb5jXroWEGdr?=
 =?us-ascii?Q?GBQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u8FZDQ6Y+vJncUyfayJxzC3V4WUREyj3NGPB9Wafu6qRhyx3y4ERV0lZjRed?=
 =?us-ascii?Q?6Qnto01yT72SmN7f+vIoaOs3niVmfm2LZKBc6liWLWyxxPmvNazUSmcKEgVz?=
 =?us-ascii?Q?WhilRHfKnC/JBOVu/95gALdz+apWxumAPUHGGWiM9EQ3csKyvR3t0vD7JChC?=
 =?us-ascii?Q?Ssj8dxRyhEGmaurk+7RJiAkm9Z9EROWzWRqfhXCaOXvasBoa7MGvo6bL9hTk?=
 =?us-ascii?Q?HHv82WzqOCi/g9uJyKdfF8Z7rvg5J29KZTrv88r7BZmn561P9Rx2Mx4Ivucf?=
 =?us-ascii?Q?ZgM4CgD2I7HZx7IKJbjzYajcXjEOXPtUSNIKRuemtpnt8ZVs04M1OUo0NiOw?=
 =?us-ascii?Q?1/xbrKc6dIY3visofciqO/vw6gqtkD2mByaItoG2jnak/oFVbeA0qYX1EiFe?=
 =?us-ascii?Q?n0nBLsv5F/KwaQ/bq/C/+FY+G67Z1n7J71SeIBgt7Fr4PB2SrC5hzPA6XVEM?=
 =?us-ascii?Q?NKlVCueac/fpZisFJYBm0PtMBD5NbDzMA9EuNlQRw7ZNGx0c0IsOxxfIA75t?=
 =?us-ascii?Q?x/m9H8c/j+QoEbBKVw/kaeDUKuydKc1OQ/S/AEY/toLuYbt6Qk1DHJ0hPeDB?=
 =?us-ascii?Q?YAbeOQGDAszad6bpm2lNdaN1NndFlor3CJoNkwTwPq9hpoRs0EjZKqVNd8rI?=
 =?us-ascii?Q?M9x/l6gJ/PMQ4qILY3GhoFWbqtUjqzXKjHLeHarS+ITC/nH8qI3hEbyAizKJ?=
 =?us-ascii?Q?pSnkumXnUhs3BDSVT1oQNwqqzcDKdiTYn8mNMtcQof/fIYsK1PRgXJ5MgPyU?=
 =?us-ascii?Q?5/2mNBT72W7gWh3S5FfGk+jJxGxFsBc6Xf5z4x7qmYxcbICklNN7sBffZJ0C?=
 =?us-ascii?Q?YDiGjAnnMwicKmyzon4srqjjAhnGgguxcNw1wU2TQAorNnyvm+uCc+wm9LgP?=
 =?us-ascii?Q?l1c7ZlWd6+WseTfswAYfjTUIbS1z/JdYGINItMh7nIiUSAz85CSBp9Hydiqn?=
 =?us-ascii?Q?4n12i0zO0UcUFGZN1/v7s9OFPr5HGgnN9nSulC9oamidPgUzpZQ/0UrKxYU6?=
 =?us-ascii?Q?3vVVB33woVuMn66XpiNMutLW41TIQ46HkqUuNW795Ka9BVQkeT5/+2umatfY?=
 =?us-ascii?Q?rYaPsTiC2NwMBKNMVnhO4T3HwwJLMACQhM36oq9HLtutxwPePnP63UpTgjAW?=
 =?us-ascii?Q?s46pjTd9f/ZFEVvVyIM5Ek/u+T5FVD7AFugN9HoQI7LODK9J0I1kAsB/Sy3m?=
 =?us-ascii?Q?Tf2SeJYP4k53jDvR/r5+d/w3WxqXEb+LFBev1+9HyqcE2D76940IuH74BC0X?=
 =?us-ascii?Q?w7RKkclp8pvnIkoM+KkphSab9pPmuJKVw1ai9IS6WACNFGIot367he56yM2N?=
 =?us-ascii?Q?KYpgqD1uHZfMWB0LtMh3hAWqUlp+IhV5UJ+AYa/A7EEQxElc+139dlzvAHZZ?=
 =?us-ascii?Q?b3JUmhGNhkQ/xrVyrxj0cNk2i2XHf6FjteWmwVJLJkyqqn1RYyA5+FHfSypg?=
 =?us-ascii?Q?wyjeTTc37YTeEiLiT0+hot0U0Y0H/5WlH3T0STgLrA/QBiI6tztuzE5UDcfl?=
 =?us-ascii?Q?FMcx9V4EHWM4zCNb664t0OT2keLxcuTPeq+EJ3FK5tOTcJHf+QnMiqxox3bu?=
 =?us-ascii?Q?6BSyBSzNVjtbj/Ge7xQ7nLwLSrk79EvhG7dAo8Hm6SbrSxJVRBvuRsg1ebcI?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a5cc62-654f-486f-b779-08dcee9cde7b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 11:14:29.5923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UASjg6lBRX0c2fsav4GZX/F0VcUWzp6CMnf/8ouhHQ3/y1JgRPXWOVs4/eCESs049fnhtF7DDkt3/Untjxu2X02M5F7brW6Hlu49PGtx6U8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6998
X-OriginatorOrg: intel.com

On Tue, Oct 15, 2024 at 04:53:37PM +0200, Alexander Lobakin wrote:
> Lots of read-only helpers for &xdp_buff and &xdp_frame, such as getting
> the frame length, skb_shared_info etc., don't have their arguments
> marked with `const` for no reason. Add the missing annotations to leave
> less place for mistakes and more for optimization.

Same comment as in previous patch.
Good stuff regardless.

> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/net/xdp.h           | 29 +++++++++++++++++------------
>  include/net/xdp_sock_drv.h  | 11 ++++++-----
>  include/net/xsk_buff_pool.h |  2 +-
>  3 files changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index e6770dd40c91..197808df1ee1 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -88,7 +88,7 @@ struct xdp_buff {
>  	u32 flags; /* supported values defined in xdp_buff_flags */
>  };
>  
> -static __always_inline bool xdp_buff_has_frags(struct xdp_buff *xdp)
> +static __always_inline bool xdp_buff_has_frags(const struct xdp_buff *xdp)
>  {
>  	return !!(xdp->flags & XDP_FLAGS_HAS_FRAGS);
>  }
> @@ -103,7 +103,8 @@ static __always_inline void xdp_buff_clear_frags_flag(struct xdp_buff *xdp)
>  	xdp->flags &= ~XDP_FLAGS_HAS_FRAGS;
>  }
>  
> -static __always_inline bool xdp_buff_is_frag_pfmemalloc(struct xdp_buff *xdp)
> +static __always_inline bool
> +xdp_buff_is_frag_pfmemalloc(const struct xdp_buff *xdp)
>  {
>  	return !!(xdp->flags & XDP_FLAGS_FRAGS_PF_MEMALLOC);
>  }
> @@ -144,15 +145,16 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned char *hard_start,
>  	 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
>  
>  static inline struct skb_shared_info *
> -xdp_get_shared_info_from_buff(struct xdp_buff *xdp)
> +xdp_get_shared_info_from_buff(const struct xdp_buff *xdp)
>  {
>  	return (struct skb_shared_info *)xdp_data_hard_end(xdp);
>  }
>  
> -static __always_inline unsigned int xdp_get_buff_len(struct xdp_buff *xdp)
> +static __always_inline unsigned int
> +xdp_get_buff_len(const struct xdp_buff *xdp)
>  {
>  	unsigned int len = xdp->data_end - xdp->data;
> -	struct skb_shared_info *sinfo;
> +	const struct skb_shared_info *sinfo;
>  
>  	if (likely(!xdp_buff_has_frags(xdp)))
>  		goto out;
> @@ -177,12 +179,13 @@ struct xdp_frame {
>  	u32 flags; /* supported values defined in xdp_buff_flags */
>  };
>  
> -static __always_inline bool xdp_frame_has_frags(struct xdp_frame *frame)
> +static __always_inline bool xdp_frame_has_frags(const struct xdp_frame *frame)
>  {
>  	return !!(frame->flags & XDP_FLAGS_HAS_FRAGS);
>  }
>  
> -static __always_inline bool xdp_frame_is_frag_pfmemalloc(struct xdp_frame *frame)
> +static __always_inline bool
> +xdp_frame_is_frag_pfmemalloc(const struct xdp_frame *frame)
>  {
>  	return !!(frame->flags & XDP_FLAGS_FRAGS_PF_MEMALLOC);
>  }
> @@ -201,7 +204,7 @@ static __always_inline void xdp_frame_bulk_init(struct xdp_frame_bulk *bq)
>  }
>  
>  static inline struct skb_shared_info *
> -xdp_get_shared_info_from_frame(struct xdp_frame *frame)
> +xdp_get_shared_info_from_frame(const struct xdp_frame *frame)
>  {
>  	void *data_hard_start = frame->data - frame->headroom - sizeof(*frame);
>  
> @@ -249,7 +252,8 @@ int xdp_alloc_skb_bulk(void **skbs, int n_skb, gfp_t gfp);
>  struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf);
>  
>  static inline
> -void xdp_convert_frame_to_buff(struct xdp_frame *frame, struct xdp_buff *xdp)
> +void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
> +			       struct xdp_buff *xdp)
>  {
>  	xdp->data_hard_start = frame->data - frame->headroom - sizeof(*frame);
>  	xdp->data = frame->data;
> @@ -260,7 +264,7 @@ void xdp_convert_frame_to_buff(struct xdp_frame *frame, struct xdp_buff *xdp)
>  }
>  
>  static inline
> -int xdp_update_frame_from_buff(struct xdp_buff *xdp,
> +int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
>  			       struct xdp_frame *xdp_frame)
>  {
>  	int metasize, headroom;
> @@ -317,9 +321,10 @@ void xdp_flush_frame_bulk(struct xdp_frame_bulk *bq);
>  void xdp_return_frame_bulk(struct xdp_frame *xdpf,
>  			   struct xdp_frame_bulk *bq);
>  
> -static __always_inline unsigned int xdp_get_frame_len(struct xdp_frame *xdpf)
> +static __always_inline unsigned int
> +xdp_get_frame_len(const struct xdp_frame *xdpf)
>  {
> -	struct skb_shared_info *sinfo;
> +	const struct skb_shared_info *sinfo;
>  	unsigned int len = xdpf->len;
>  
>  	if (likely(!xdp_frame_has_frags(xdpf)))
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index 40085afd9160..f3175a5d28f7 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -101,7 +101,7 @@ static inline struct xdp_buff *xsk_buff_alloc(struct xsk_buff_pool *pool)
>  	return xp_alloc(pool);
>  }
>  
> -static inline bool xsk_is_eop_desc(struct xdp_desc *desc)
> +static inline bool xsk_is_eop_desc(const struct xdp_desc *desc)
>  {
>  	return !xp_mb_desc(desc);
>  }
> @@ -143,7 +143,7 @@ static inline void xsk_buff_add_frag(struct xdp_buff *xdp)
>  	list_add_tail(&frag->list_node, &frag->pool->xskb_list);
>  }
>  
> -static inline struct xdp_buff *xsk_buff_get_frag(struct xdp_buff *first)
> +static inline struct xdp_buff *xsk_buff_get_frag(const struct xdp_buff *first)
>  {
>  	struct xdp_buff_xsk *xskb = container_of(first, struct xdp_buff_xsk, xdp);
>  	struct xdp_buff *ret = NULL;
> @@ -200,7 +200,8 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
>  		XDP_TXMD_FLAGS_CHECKSUM | \
>  	0)
>  
> -static inline bool xsk_buff_valid_tx_metadata(struct xsk_tx_metadata *meta)
> +static inline bool
> +xsk_buff_valid_tx_metadata(const struct xsk_tx_metadata *meta)
>  {
>  	return !(meta->flags & ~XDP_TXMD_FLAGS_VALID);
>  }
> @@ -337,7 +338,7 @@ static inline struct xdp_buff *xsk_buff_alloc(struct xsk_buff_pool *pool)
>  	return NULL;
>  }
>  
> -static inline bool xsk_is_eop_desc(struct xdp_desc *desc)
> +static inline bool xsk_is_eop_desc(const struct xdp_desc *desc)
>  {
>  	return false;
>  }
> @@ -360,7 +361,7 @@ static inline void xsk_buff_add_frag(struct xdp_buff *xdp)
>  {
>  }
>  
> -static inline struct xdp_buff *xsk_buff_get_frag(struct xdp_buff *first)
> +static inline struct xdp_buff *xsk_buff_get_frag(const struct xdp_buff *first)
>  {
>  	return NULL;
>  }
> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index bb03cee716b3..3832997cc605 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -183,7 +183,7 @@ static inline bool xp_desc_crosses_non_contig_pg(struct xsk_buff_pool *pool,
>  	       !(pool->dma_pages[addr >> PAGE_SHIFT] & XSK_NEXT_PG_CONTIG_MASK);
>  }
>  
> -static inline bool xp_mb_desc(struct xdp_desc *desc)
> +static inline bool xp_mb_desc(const struct xdp_desc *desc)
>  {
>  	return desc->options & XDP_PKT_CONTD;
>  }
> -- 
> 2.46.2
> 

