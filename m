Return-Path: <bpf+bounces-69225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 498C2B91D88
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 17:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E53188D67E
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 15:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069AA2DE6F3;
	Mon, 22 Sep 2025 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nVUNjBhP"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B621CF9EC;
	Mon, 22 Sep 2025 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758553568; cv=fail; b=AtMR331z8pyu0rUHWqT4w+t6jD61d08+8Lad3wVvP4N9THcBzxj8WfZwvUYBQ/GZGDwI0GnbX5Q4RaCcAXEYJG0p5+R+uIu3/lt9VhjZNwnI8NC9vedWeauA/0o2wk5ukqHA2Jnk2bAC8tkIUjMkw247KFEZan+Rbr4EiRRjXco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758553568; c=relaxed/simple;
	bh=grE3lJeRYxfUXEbLLxBkBucil6zCjb8UZf4BILAlRKs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FEbW6fDYGFQVRvVIrnqYL8GspAuNlh0drMpEsKHEUQkuG47iC82jH2bkptlmNRbu1+rndEEokAJWBbNZMfRH+eF4PkrKJ528KvXrJHsuNwfSe/0H6iJVzx9i8B+f3gZ0uMErB5pdP/WHBy6rDh5T6Z/ZVEaBKM+SCHqsx6gGL1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nVUNjBhP; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758553567; x=1790089567;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=grE3lJeRYxfUXEbLLxBkBucil6zCjb8UZf4BILAlRKs=;
  b=nVUNjBhPzyGwZ8Cp5VvBVb2TWUQLfMKUpjRwDZpSWxgS5a/mxmNBzyCB
   FpSItr69eAVdw4shQce6NwHOY2pkARrXf0GicJMCrWcErZF/JzQqvtZhL
   k6JAKi0MzIPSvXQ3CERKdPsOS7zCPmF7LS8AuHS1m5uY6bI5pG5J5wzo9
   eZH+gqNaDqclgZejtrx1jB/humnxCjd4WkWEZJmu3jnsAn19m5MMOHXyt
   Sl7XyT/vatyXdyoIKt+hnlCPaMTGQDV2EXetAT+E9AkDZ82qC99GEL5eP
   GR6xRAXhx1+T6lpnZbeBESAjnXqWIpY/G7uxkuQIJEvsUO/eoalnZRC3W
   A==;
X-CSE-ConnectionGUID: 6VlHIYD5RK6RmcaSiz3ZRg==
X-CSE-MsgGUID: l20Ea4S2S46XiKlvQ7C0Fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="72182183"
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="72182183"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 08:06:06 -0700
X-CSE-ConnectionGUID: pXJpHv50SkyWfOBWxZ2vnQ==
X-CSE-MsgGUID: egFu3qD6RF29ifMoG3gHsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="175766862"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 08:06:04 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 08:06:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 22 Sep 2025 08:06:03 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.28)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 08:06:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F69yj21uUgWj6K214WqbURbAxvj9oCrVt8RO8oKlGm+d/2gwDIY6EaZUFFTtSoWBXylgpm51EyuaAhRygt23P9Y0Y8KLpPqXps1nwiUvT5WPuhf0ElAZIg2izs3vcrp0CMs/bcExK1f8674xyrd9lZSy4MVAFrKIwWhV3FMSVOLRGQSlKOn1dmvHTePKdSeB3IlBVb/CYzRywjKKwRniPtm4SkgrcaTZ33rIH6fp3C/4dAp2PxW7G6cz8qgPk77PI7fHvGJGMeyWfdKvJkKdh1TCWf6DkiOaJoXGYvemdsfTEAI8VoAaiDR8e+Si4GARDCm9PNlMxpgqa4Ic5ZlHdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1OXPxVAlaGkJbT6H1ecfGOO9F+KX77m+hvpUYp8b+4=;
 b=DrdLLuGfM29JeXzRienaNGIvTMUivkBB8VCjzIXD8h58gXDO2LAkDoIOvW8f38KwrHYzUVBDFa0dDaayJpq1BgrhqRMK0PoJyorrnK1lh01C7Cba4OtMBDbk196pzGKxFidQyVS3IyeQgmCponhIDEK/crt6ujRFoxLMztUIEyedLoya8mbRtNuI9r8VMsHFMdy6XYORXrsu+o+3rnOIEApplfTaY62uHeqYhq5GNwzxR4iGc6lvzibQv7hLAdwgloIbf/EHMgapk3idLgWlRJ8hcv72n5Ppd8hWU2OtWpG4Ux7ZZprcS0Le0T+jD09bTnUgtouxx5Ig9ExAhjNNCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MN6PR11MB8103.namprd11.prod.outlook.com (2603:10b6:208:473::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 15:05:57 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 15:05:57 +0000
Date: Mon, 22 Sep 2025 17:05:48 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Amery Hung <ameryhung@gmail.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<alexei.starovoitov@gmail.com>, <andrii@kernel.org>, <daniel@iogearbox.net>,
	<paul.chaignon@gmail.com>, <kuba@kernel.org>, <stfomichev@gmail.com>,
	<martin.lau@kernel.org>, <mohsin.bashr@gmail.com>, <noren@nvidia.com>,
	<dtatulea@nvidia.com>, <saeedm@nvidia.com>, <tariqt@nvidia.com>,
	<mbloch@nvidia.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v6 1/7] bpf: Clear pfmemalloc flag when freeing
 all fragments
Message-ID: <aNFlzBjGfG9A7RDa@boxer>
References: <20250919230952.3628709-1-ameryhung@gmail.com>
 <20250919230952.3628709-2-ameryhung@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250919230952.3628709-2-ameryhung@gmail.com>
X-ClientProxiedBy: TL2P290CA0019.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MN6PR11MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a444b29-5ff1-40ec-7f75-08ddf9e98901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eKs+tsCMUgIC0dQzqta6IyH6Q68nkUHSWrqkBt7Qnc/UGun8+WNJXFzgXH5G?=
 =?us-ascii?Q?56Hqr61xR1lsB4hT6zVCiSZaEkZ84A9GRIr5g2rChJ0ExT+O3kjuwKTsH0hr?=
 =?us-ascii?Q?+La8FkVfnvNhGOWqlUW75KB6oA7cMI7bvnZ6pd3HxNPBW514Kbl3x9vJ+zjH?=
 =?us-ascii?Q?Cm8uAnB12ycW34y4lYZ/2UztGURDFBTQPR2MggbeEXMlrNKkTXFp96YXvHI2?=
 =?us-ascii?Q?uLFRMwytVjPcbZ++fBVFhDo7/1FwlU0eDzRPxdzlASEBCMglR9QlsHoTOfIV?=
 =?us-ascii?Q?zpvue3gs5aJsAvoERokAn0eDOXE4SliEjVYjukYEo09IRuoFGNxInls4qDlB?=
 =?us-ascii?Q?1go/3/yNgNVoDUa4PD8DBpsl9yWoCo/COa9zwm08Qt0gqgqHil2zeH2GDQ/w?=
 =?us-ascii?Q?cJ795mGWVT4Mx0eefMrC7XtRmoS+kt2ZxNNUYOvG4fEHgj9kwCkrnN5Frzlo?=
 =?us-ascii?Q?7lj62Yz/p0JfUUZVg7rizBcevV6sn3lIH3bWg5SGz77iFE0eKF8+ibcjlA2o?=
 =?us-ascii?Q?Nq1hRlXOt+y/yWNGBPCWNZJYRSRZ5P5rcLmFP0RLjEqsHsKDsyE9rlJKps+4?=
 =?us-ascii?Q?V7J0MQzH6I2ct08VFT7YVIOBnHMXe5D1SwWi+jfIRKzAkxdyjBDLK6PZn6pd?=
 =?us-ascii?Q?Fzw5DbDFAj7rXL46lf1/DmTt5Pt/CCZzYXAJp1hYqKEBWFtwY2VX1U9+YlPr?=
 =?us-ascii?Q?K34bGl5Sf82hv9/OHMpsSwA9R2CglFoaQIR30QU/Y9r5jhd7bzSCKkp4dCo6?=
 =?us-ascii?Q?Z66BJ31B+TkGeFylNxfiKGLUjq/J6C4p0Ato2gZceOx8CecBtuDrIkHdUK7T?=
 =?us-ascii?Q?ZcbMbWNdEPBpuErjamxoqT3qNVcSSzYMfN7sL1DgXdlMvlsBfhU4BzXQxIPw?=
 =?us-ascii?Q?ujRjzB6aXsvjqz+ioTMQ5pfn2EsxscTb7PFQX0kCF8ufngRGLzWg7IlSWLnW?=
 =?us-ascii?Q?Bp+L9kQr9b+2FdeOiuMggr3BqVdSprguxm0VRM3GhGLvKDQ+J2R5eFDVU1lU?=
 =?us-ascii?Q?gxMZgbFIJJh3r7fAuS+R1nSknColxMJprSpIMq7s3WuYxr+oMsyimIaTZWar?=
 =?us-ascii?Q?wjum8L21zqvnhMzZZsLhK27FfdH8H+MX916osf18NSCswWEp/hhMiwXzTVFb?=
 =?us-ascii?Q?3wYuU1nKgrqueRabvAMf46kACBtIJAZQBT8fSAklSymXs8Y8SE/tfwjek7Bi?=
 =?us-ascii?Q?sttwrVmeLqEXPm6wQdrHoonCq9g5oNG29lRD2pakN53BcVeGzKeIkyQPpsoD?=
 =?us-ascii?Q?ZATx9B2MMvoyP4cnlD57hxnBeXW4Iw3UfpNx1KwVWwc5YeRaOb7B1Zh3SOcg?=
 =?us-ascii?Q?nA7ekNVHzmTOzHLGZ9MFD08fSpgIQNH6grLGBR11UF1QsvvPbIKiVsaQIafd?=
 =?us-ascii?Q?hvU4lSzF0rR3d4Y9vvwN4Un18dJyiqwWrOBwy6zzNFkSTawAlHuOfT+yBgry?=
 =?us-ascii?Q?C1bc758RCvg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PW2tL7P4D3Cmxug2Val0H4mB2a2dxgKhfZ6FdtqXpricxSvOaSmXJULCGJXe?=
 =?us-ascii?Q?lrMhZ5kpWV9On23KaVVgFiBGUEG/1QC/d678+ZQqaXgQdAD8Rcl2jCIOve1z?=
 =?us-ascii?Q?nIsok7GVmOHEQNW1c6BiZH83IKs9mc+bk2eiJdSmNJDjfEtz73ccpGmrPPfX?=
 =?us-ascii?Q?hkorHCEP91nodCDnK7att2JQsKcrrGnO12z2K4cRCajsmnQzOnuNBDLfeljG?=
 =?us-ascii?Q?nM6gvdqkCLypqqW/5Rp5puIE/fnv1KmpwbxyOgOSsMgCunqO867BLl5Lit2e?=
 =?us-ascii?Q?IKo3Vnqv4Gbte9/buMnbDB/NPNNMM5XEGhVuvT8mVzK++hbLD1EDHdG/qS82?=
 =?us-ascii?Q?dNEJAyFoZ/Xu230t8KY2bjsmQ0fQOZD2Ga+8n5GwqxHq2LzveYtHRNH5XTaT?=
 =?us-ascii?Q?JdFGmxbi/23uOFhUZ4yfk73Laeb2LG2xTNUfGOvzFL6IwWYYT3NLAPQVcIMR?=
 =?us-ascii?Q?Rbx4bCVTzx306K8ay6DQPsgSPKwx4bA3mO1oDS3OKiOdA8is+zaRNnJAc6df?=
 =?us-ascii?Q?S0bz75sfAM9MOjDn7/c9GomH6kS4rOAj+C4QY6fz0tmeeUemcEFgod+gatKF?=
 =?us-ascii?Q?tVe31ciiqYVnwKQeXb7lI04CuvLG7Qy0QdMv58vYlSuGuDJkMyZnfTsscmni?=
 =?us-ascii?Q?mlOyk1uzC2TjPftToVKCyX3DmwajpOf0jaB6HQQMMfHzTarREBShTMogHMIo?=
 =?us-ascii?Q?GLA2iNTZbWPVBnw3jMZlgecpHKShvuCc8wjmXo6NmnWFZAVg4ZwmTYKJbhQ8?=
 =?us-ascii?Q?glfOoSnlNHQVcyqOqlHcVZK481ES+ZJ5WHtTx7IVLiMeN1oNxI/My9hbY4WF?=
 =?us-ascii?Q?S7NPUTghPBHRPT/cvsqWSH2IQwjoY8/j5qaZ5VYWndFPgSggQflSiV8FVywl?=
 =?us-ascii?Q?Pn4C/sBpzsyRo+AZcLjANryuBOo4OhERxUXhDZJaaxTT9C28VGgUTfcXFdUa?=
 =?us-ascii?Q?4KcVZkfZLYcQn+5cdyRdF33Ew1HT0eIjE89M1pyPWxLixnn3q2wQWMp//6z0?=
 =?us-ascii?Q?Dy4twM2izQvEpHNQSaxavCZAjywil4dYO8IHnaamjwZklKtQnhc/1UX20oq4?=
 =?us-ascii?Q?w5/PdgT1AakDI7Brex8WV7fpKQzPqEwjwZh/GggkNE4RCtumWyMVA8AC1CLH?=
 =?us-ascii?Q?KpHsNhbysm3qAk7QtxQuEhKUzAFFTAyGeS7XbPi7s/EB+gWgH0+4c561p5fG?=
 =?us-ascii?Q?TAqk6uz2RW4rjf6zst04EFmOR0KJW0/6mhFsgH3/n32xx3ScV+hsQHn9pw9s?=
 =?us-ascii?Q?8pN9QF+vQYxvlIIn7e4zMBCnzmzaUwMt5YpHLF7h4yMAefRJCjUpedz0aMDo?=
 =?us-ascii?Q?DtU+nyz/ooMrQtzkV3p+boD4YalrEkfzADB3AyT3fE8DvK4ixSksEahJzNhN?=
 =?us-ascii?Q?pvcF0UrkCM+LF2G0hHy7LWPg7+FH4w00BFvWROxz94Rt8x6JhwlfziF/P15C?=
 =?us-ascii?Q?PeNhkuotLLVwPzpB9NfoQ0Da8OlYI5qzB/uzNMEok0d52KBB0oEJtC00Cvec?=
 =?us-ascii?Q?g4QJfCR8KdYlFuyKbtuj+RpmFy5cELdfSSNk4zaTFzv146lMupxkuShDUPAz?=
 =?us-ascii?Q?rTxvh0Lduf0FElE5EAmC056GXtbVyb5gnA+d3iWUmw9F3c3/Wgelu4bNo+K3?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a444b29-5ff1-40ec-7f75-08ddf9e98901
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 15:05:57.8828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqSJnjU4aNIyvot+9JI6R4wYT1UtY2vUm+zQCFrZLhbX67OzifpfKGipPJ5o01Yu4z3NTHiDcMcXxRthiutyzhEPx3cRjpJUxKoqe9qc3vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8103
X-OriginatorOrg: intel.com

On Fri, Sep 19, 2025 at 04:09:46PM -0700, Amery Hung wrote:
> It is possible for bpf_xdp_adjust_tail() to free all fragments. The
> kfunc currently clears the XDP_FLAGS_HAS_FRAGS bit, but not
> XDP_FLAGS_FRAGS_PF_MEMALLOC. So far, this has not caused a issue when
> building sk_buff from xdp_buff since all readers of xdp_buff->flags
> use the flag only when there are fragments. Clear the
> XDP_FLAGS_FRAGS_PF_MEMALLOC bit as well to make the flags correct.
> 
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  include/net/xdp.h | 5 +++++
>  net/core/filter.c | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index b40f1f96cb11..f288c348a6c1 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -115,6 +115,11 @@ static __always_inline void xdp_buff_set_frag_pfmemalloc(struct xdp_buff *xdp)
>  	xdp->flags |= XDP_FLAGS_FRAGS_PF_MEMALLOC;
>  }
>  
> +static __always_inline void xdp_buff_clear_frag_pfmemalloc(struct xdp_buff *xdp)
> +{
> +	xdp->flags &= ~XDP_FLAGS_FRAGS_PF_MEMALLOC;
> +}
> +
>  static __always_inline void
>  xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
>  {
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 63f3baee2daf..5837534f4352 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4210,6 +4210,7 @@ static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
>  
>  	if (unlikely(!sinfo->nr_frags)) {
>  		xdp_buff_clear_frags_flag(xdp);
> +		xdp_buff_clear_frag_pfmemalloc(xdp);
>  		xdp->data_end -= offset;
>  	}
>  
> -- 
> 2.47.3
> 

