Return-Path: <bpf+bounces-61814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1ECAEDBA0
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 13:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779013B22AD
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 11:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCA3283FFC;
	Mon, 30 Jun 2025 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMq9Db++"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FA7283FDE;
	Mon, 30 Jun 2025 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284205; cv=fail; b=ZZ/r/WR+7XNM9tZxSR0Tg1ZzoHmHGoltFd3qm5ilAjKlln3SPLo/5pqwRQPKNRBnFjMRcDjbd5Yve07UXAAdeYo2FOi7K0yE2FgRXQNplLeNjWRmGo/JhkuQTZ8PYL35/QX181j1QoLR79zZHlQO1jxImACdO9H/xwU1C/DVhxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284205; c=relaxed/simple;
	bh=MxIem86x88mMNwn5IcMi9id3MDgNmigZ4tCDttUCP60=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LUJ+xo7iSh49MGHssS/S5whJEylFi2EKH5xkH4IjbZ37Af4ovySMThDtwPdGPmcPYvgJhiJOo3eG6igVAPJouHv2trZWoY/8nz2dWh5WDWe+Gx9G9NwchBbR7ia9Ou0CRkhdU3c2jCQ/whI/d6WuRsSCQ3IvsGWDiiovrPJ1NPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMq9Db++; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751284204; x=1782820204;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MxIem86x88mMNwn5IcMi9id3MDgNmigZ4tCDttUCP60=;
  b=VMq9Db++dEeU5LbI9QjqEARtHj8B5F+NW3sy82HlMCfOEFrMjWOiojkc
   w4Z+dUHog5ekshLc9U8tl324P7nBOxHgdH0eF8oL6jsehJiOlKBesbnif
   bQwv+tiAuAu3wO4ZV3xyO+ABKhPfsUsDyxV0EJXJEGNT3+Uts9Y8EW7Xl
   fQMQHEUuACdtssA6gAgQ7+60h/oiOUTiwOBao1ssYBLI5E0exH5V6KmMY
   TytfaZJ2nzQzS7mpVKwdf6Bn4SHNV62J9e3Ja+Mx7YqSoC4v2OB/JA7AV
   i60JWzfyrH6DiXs5NmiSKjbTUhTM/eMGe5n/J1+uRDNwoLb47pzGsb6jv
   w==;
X-CSE-ConnectionGUID: 5l+Yel8lTWKn8Rw1p8VL9g==
X-CSE-MsgGUID: AjGaaOzpTOa8GHVwkj7Dug==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="64103046"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="64103046"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 04:50:03 -0700
X-CSE-ConnectionGUID: RqnCX5g5ToijtVnD0iXQaA==
X-CSE-MsgGUID: FF1kNveGRye7YgdXdam4lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="184460492"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 04:50:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 04:50:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 04:50:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.83)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 04:50:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnQR8eNJyoXHS0QJB2gWiwDU7Y+R5rKpnXAnMHIu765oBO+IA+9NPz07PsY9pF6oc6axjMtR4bBz7BWL5OIzXWivGRoG9261OxDQQfOSAVGlWkyGrJrwSM3c2OFmpB8KZ8pvXCOsvO/vF/N1jJ+MgK2+5ZvSzrKwS91piKZOj5NhSI+HKGJJdexpsgIILhpon3/pBQr0viDtHsFkm5o7XiAWkh41YWyYBSgZ1qQDHj4VnZokM78UmKFNDZlKU1bQS9zcUX7ynnEQY+LTVMxUV/wnC6O73he8o2eaZZsUDaRvDAEDnsWzy7ES/VxQ+VhCckby8T2hSCpoHc0NmN8Fvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4+9g9oJMeymLPLcabW9J6e2kedKyc0Xcpnx1xZriGA=;
 b=XhtcwF0hisl7esL/48rFb5sKnM/TQBMdBDbgUrFMxcoG343gFflPFneo6V9ovIAe0BBSaZXwuCApCbDFPNvfOXuPdQCVTn0gPfq7jzSkMdP4Y4MFMRqhHqLRHm2tmXA3K7/xFo4hWQMUto31MXeEBZs0agmHtiDBCVmw/zMGxoKwdqq+JLXvZuBGJTdul/ACHgqgxW9/tL02YXKpBdiVlDxO23GLv+BZeCFlExP3LE8G2VJrzfL76CHXIiaSMXlOCdUVcNIXAxj0ISgZ1dp+BeqGmj0Hca/tJ1bx/qsCXeVdlwDz/SWbv0ESc0c5NfFZcvS3cOMpQ2XrcWkkgUL6wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MN2PR11MB4663.namprd11.prod.outlook.com (2603:10b6:208:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Mon, 30 Jun
 2025 11:49:19 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%2]) with mapi id 15.20.8880.024; Mon, 30 Jun 2025
 11:49:19 +0000
Date: Mon, 30 Jun 2025 13:49:11 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<joe@dama.to>, <willemdebruijn.kernel@gmail.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v4 1/2] net: xsk: update tx queue consumer
 immediately after transmission
Message-ID: <aGJ5t2hvN9wX+vxh@boxer>
References: <20250627085745.53173-1-kerneljasonxing@gmail.com>
 <20250627085745.53173-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250627085745.53173-2-kerneljasonxing@gmail.com>
X-ClientProxiedBy: WA0P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MN2PR11MB4663:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e083a5-4c75-4bf5-b158-08ddb7cc25ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wDNjmkyb/enEBQ1nXUVqYRCiNEIFTbhBBeL3vDLToOtvMJw2y5Dib/icERXB?=
 =?us-ascii?Q?IPsrGBcWUAlblQDSOsebuJ7dWXKAc1/DZvcMEpMmGVfqZL79GEbc3xGNSqBo?=
 =?us-ascii?Q?2DmVnO5nHXQxjCuoAfep8e98DdG4sSDp/+2K9zlFiO+/v4gMJknPV0Az616A?=
 =?us-ascii?Q?BR9B+gbmThjDbkUTuD9hC2U1GMjvDaviqwW42ra5nyX8z9lcO0nGQGXCBjYU?=
 =?us-ascii?Q?qd9XtHdnWOxvBa43UrggVUTyPBVO9REGuX16GQxUBPbad/VqOiXJonMUIm0U?=
 =?us-ascii?Q?V7ki8NSflIJwtQguKcDEItFsIG0aK/OUcrBNmwOtCdMunEe1BiWPlSz8ZrsF?=
 =?us-ascii?Q?kpMZ1eV52JW+2FhCmQ87kq8AGvuHgvzsOTbiQc06mlvBMK+lB+I17fEUfCzf?=
 =?us-ascii?Q?rjPj7o7ymyaGzknRRQWaXjsW5DTx7tJ6/Pd2MkSgkPQOmuRHJfRnK9QoReFN?=
 =?us-ascii?Q?vQeFZCSDAYH18mCVGj+KNL2g0Rekt7yo5Tqz/VY8s4EFLaAa2Gqyx+Qi3hzs?=
 =?us-ascii?Q?bqgfqCExPfY0cgqXOaRkiW36X8wfgM5DAEJR9rTJTyTw07ghauOSHlq3fs9c?=
 =?us-ascii?Q?+CO+DdDHtCdWiLEVxl4mUR1M+YDE9Q8E3SQ65BvVnK+WQpJKh5Uvhh63hYB3?=
 =?us-ascii?Q?lxtK6Z7rQZiIz+EvFeWEqLzPqOL29arVFlhZjhLkt/HhVXbKY2nYvgx2T7eQ?=
 =?us-ascii?Q?2sgXmhkpVnRmbs/XJRD5IfkBhzUlkaQKo3YkqrTfd1gUC8ObLKfd3L3fT7T1?=
 =?us-ascii?Q?fVDVbzX1gC8taTpOSo+h+jtHgbT5cAbgj1KVj7g+DS8JUcPYQ2EC3UWOplk1?=
 =?us-ascii?Q?9AjYIbDGZfvtpm3fKn0xCaRWq6h/PWsoEDdOVYoMsPnzlyb2OcbW1T1Eq4vA?=
 =?us-ascii?Q?dko2CGELpF7VoiuWSg9ZB4OE9+VLG0rs39KR58wBfvLJhAKOfUS/roq7y7LT?=
 =?us-ascii?Q?rQBwXbUv8xMkOpteK2WK5hDSxrd6Jo52Nxz6nx4Q9iYHjkzshv2hILYmbJHf?=
 =?us-ascii?Q?yvkpZGiZHhFmpHIhg5+HFBiQllprphhaOxnYbv7r8WQQT2+ypnQAZBDrjoT+?=
 =?us-ascii?Q?QL9+H0uO5Qlr7kwg43rXOPwbYdUJ4icy2UZRSZATz2v1fMAK1UyBoOy7pZ2U?=
 =?us-ascii?Q?QoJhslsbx2VuFKbKVdlQYj5tErfhHb4gITdhETvAyKnvvHBDp5jwzGgZWRAI?=
 =?us-ascii?Q?bTd1YTkibMa5a5ecOjIWf70ZmY8Hy67RPjJmZRXi/GZMjg6lGJ8K4bfY5nvY?=
 =?us-ascii?Q?x91eNy8MdtDeb8tgascoJOITl00KiqmgyzYQBCtlUowlbSchL3t9fuONkH+J?=
 =?us-ascii?Q?evQu/trJmDL6CB0cjpjyjUxMH7KCfpCz7bZC5VHsihMkO7sh4Xp39FGqhf1D?=
 =?us-ascii?Q?wS/kGZARM8ufEnILL1lZJbI1iTp0eINV3gseWki8p03uOR0MC2oQ0cSo0LlD?=
 =?us-ascii?Q?WLjHkMHmxrM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u2Ms9Dy/mUSlH7O/CKoZBjLI90ODcXbn7cCC84zKoTcAwkeylH3L05VZnjYU?=
 =?us-ascii?Q?kGCuqfdeSddMP3rBDBz0iRqosbf/Qjjk7zUbbcVE4o+cgu5z/6RvLhyXEDW7?=
 =?us-ascii?Q?jHukO+cpurKTVuLqMm3v1MdpvC7OTPWN2yGXRLUYlmEFfbhWOhrKeaNpgTiP?=
 =?us-ascii?Q?mzL0oOVhsl0OfgH0Cgl8gd00pwKym5gR+bslw1gN4MtPEb9VS8ExwUqVFdES?=
 =?us-ascii?Q?g60GaJjnLwAzRdW0HFV7oH2Xf2/g+Sn94CaXPoIQixL0HU+hKhgXvXJ1otJN?=
 =?us-ascii?Q?0Fl43zdXi8MQrYEkuTXi0nDGodZFpUE7eoRzPbv6gdpmXXKAGODoA/n6Nwp+?=
 =?us-ascii?Q?0g/XlXHybSOhrfyBpU0IjQlcO0PccD6i6zaYDDDmkHi/e/eUK6mctphIeRn1?=
 =?us-ascii?Q?HgPe404uc3UrpcGdGZuy7IR4ccRjn+UMPfEJdm0HdhrWCfmg3zjeheujGMPM?=
 =?us-ascii?Q?WzwCGKhbACioVQyXtLR5w6a0ZUDf4mpxtEKYQHp8umTAR46Y8sYwniT1cc7t?=
 =?us-ascii?Q?Yz95xUy3eZiVlBdFez7VBAhLXm0E7xFzM6z0nUJJyzmmb8l7lJQOIDeQJrFU?=
 =?us-ascii?Q?bayXEuCkBWLIyBqrq9wyBjllvcmJWU1hB8xdLKeOQX7BGmPq14q1vpyfeqfZ?=
 =?us-ascii?Q?fNVzZRTSZz8lQ/cOQpExE/d9aznmkzpBCucjsdh96m0iLRF4j5/oGKBPmrFK?=
 =?us-ascii?Q?Ax1BIyyDdze6P2xSesRu2sAc7igYpGfkxMfjRjUx5dfss3w6J/BbtBJewujm?=
 =?us-ascii?Q?Jf0PLadxCZMigWpazbf7SUpa4vPFhh3cOMUijrRXaedhpeY80Z36kIBYMPm9?=
 =?us-ascii?Q?McJpiL8RcIhs7TN7500/5laS9tZItolijAnOBVhDo+nD/pV0RhbLp0AqtRmQ?=
 =?us-ascii?Q?RzbKWyp60QcP43LZIStChSyZb+8vTX+/ynwI0dUnkau7P9ElbuFyrcbaHl+k?=
 =?us-ascii?Q?iuNysdsMOizbOqlnQgM5q4gxKc9F3p5Gwsw70uEGjV2acYBfso+ZgrdSousU?=
 =?us-ascii?Q?JO7czUstVF2/3H7fkHZO21Ec4veSNZO15HKkUTKexJ0Jfkuc3jLi8P2YYHFQ?=
 =?us-ascii?Q?geCk91KW/S8avl+APKcj7NubmGlhpdRkjeLWrcNK+btCwtfhs5vddx6dbeH8?=
 =?us-ascii?Q?f1f9bDyb+Czi4CtXBfsuST5hukWPHKsb+NtxcHQpZit5uZtXckLhYWNIjqor?=
 =?us-ascii?Q?48Ny4J18Ce0noDxV9N0hipIIL/vTHyAcB9nhB1o1jYdhQ9AG7hs30AXBFpwR?=
 =?us-ascii?Q?JFlwNsVACl9DytDDm4Y9utaAfPtk9O7x9FutB78sveUlHF9tXNlEGpetQH2e?=
 =?us-ascii?Q?axYgRPIDzpOF5ZsmpXIr4SQLnRYKM5W7AIC8dUjdO8S3Qmenec4ozRp95olZ?=
 =?us-ascii?Q?t+0TEVk7Tg/dyjF3/i85vwJWDb3NKvMcKxI4WJD+R55gR311n17LbkIHBnbn?=
 =?us-ascii?Q?6RgBUJgX7u/bvTA1KDOgV2TUwLLbGQFXCaV5KOiv6TV9/dZT73kXklPgV3yk?=
 =?us-ascii?Q?FFn2lLsevGWzxvNDvWWSTpIzd/BXXoo5GZoeW4zOvOxKDYEx0p8pCPqklhQh?=
 =?us-ascii?Q?vORzYdb6j3tYX9Vvw4wvA/Q3CMT/y5n7OavgOUxe2EHOqphmFVFPxTZFf49o?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e083a5-4c75-4bf5-b158-08ddb7cc25ac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 11:49:19.0960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kombh/vY5zN9REvWew93uArAae/nfcykvKcJLDpPGAbawGJf98pbQQHNTT/J/3yrvafQxuBLS7zwyBx4NNGl91e6E0Hz2hh6V8ZEHan0+UA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4663
X-OriginatorOrg: intel.com

On Fri, Jun 27, 2025 at 04:57:44PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> For afxdp, the return value of sendto() syscall doesn't reflect how many
> descs handled in the kernel. One of use cases is that when user-space
> application tries to know the number of transmitted skbs and then decides
> if it continues to send, say, is it stopped due to max tx budget?
> 
> The following formular can be used after sending to learn how many
> skbs/descs the kernel takes care of:
> 
>   tx_queue.consumers_before - tx_queue.consumers_after
> 
> Prior to the current patch, in non-zc mode, the consumer of tx queue is
> not immediately updated at the end of each sendto syscall when error
> occurs, which leads to the consumer value out-of-dated from the perspective
> of user space. So this patch requires store operation to pass the cached
> value to the shared value to handle the problem.
> 
> More than those explicit errors appearing in the while() loop in
> __xsk_generic_xmit(), there are a few possible error cases that might
> be neglected in the following call trace:
> __xsk_generic_xmit()
>     xskq_cons_peek_desc()
>         xskq_cons_read_desc()
> 	    xskq_cons_is_valid_desc()
> It will also cause the premature exit in the while() loop even if not
> all the descs are consumed.
> 
> Based on the above analysis, using @sent_frame could cover all the possible
> cases where it might lead to out-of-dated global state of consumer after
> finishing __xsk_generic_xmit().
> 
> The patch also adds a common helper __xsk_tx_release() to keep align
> with the zc mode usage in xsk_tx_release().
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
> v4
> Link: https://lore.kernel.org/all/20250625101014.45066-1-kerneljasonxing@gmail.com/
> 1. use the common helper
> 2. keep align with the zc mode usage in xsk_tx_release()
> 
> v3
> Link: https://lore.kernel.org/all/20250623073129.23290-1-kerneljasonxing@gmail.com/
> 1. use xskq_has_descs helper.
> 2. add selftest
> 
> V2
> Link: https://lore.kernel.org/all/20250619093641.70700-1-kerneljasonxing@gmail.com/
> 1. filter out those good cases because only those that return error need
> updates.
> Side note:
> 1. in non-batched zero copy mode, at the end of every caller of
> xsk_tx_peek_desc(), there is always a xsk_tx_release() function that used
> to update the local consumer to the global state of consumer. So for the
> zero copy mode, no need to change at all.
> 2. Actually I have no strong preference between v1 (see the above link)
> and v2 because smp_store_release() shouldn't cause side effect.
> Considering the exactitude of writing code, v2 is a more preferable
> one.
> ---
>  net/xdp/xsk.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 72c000c0ae5f..bd61b0bc9c24 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -300,6 +300,13 @@ static bool xsk_tx_writeable(struct xdp_sock *xs)
>  	return true;
>  }
>  
> +static void __xsk_tx_release(struct xdp_sock *xs)
> +{
> +	__xskq_cons_release(xs->tx);
> +	if (xsk_tx_writeable(xs))
> +		xs->sk.sk_write_space(&xs->sk);
> +}
> +
>  static bool xsk_is_bound(struct xdp_sock *xs)
>  {
>  	if (READ_ONCE(xs->state) == XSK_BOUND) {
> @@ -407,11 +414,8 @@ void xsk_tx_release(struct xsk_buff_pool *pool)
>  	struct xdp_sock *xs;
>  
>  	rcu_read_lock();
> -	list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> -		__xskq_cons_release(xs->tx);
> -		if (xsk_tx_writeable(xs))
> -			xs->sk.sk_write_space(&xs->sk);
> -	}
> +	list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list)
> +		__xsk_tx_release(xs);
>  	rcu_read_unlock();
>  }
>  EXPORT_SYMBOL(xsk_tx_release);
> @@ -858,8 +862,7 @@ static int __xsk_generic_xmit(struct sock *sk)
>  
>  out:
>  	if (sent_frame)
> -		if (xsk_tx_writeable(xs))
> -			sk->sk_write_space(sk);
> +		__xsk_tx_release(xs);
>  
>  	mutex_unlock(&xs->mutex);
>  	return err;
> -- 
> 2.41.3
> 

