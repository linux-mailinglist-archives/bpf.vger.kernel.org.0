Return-Path: <bpf+bounces-37634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 885049587ED
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 15:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7088B23B7E
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 13:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0F31917D4;
	Tue, 20 Aug 2024 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cwpgS5Ej"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657A6190472;
	Tue, 20 Aug 2024 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160426; cv=fail; b=aSP77ksCx/Yp+E17deYQlSUT4hBjHdrunFByca0VCSK8HO1DVVHyuCLIodvf8/i0E/T6KGa+RGU01+p3AklG8nTXXPHDMntfBudkIevFIyo6KpK997YSIxaDgzYlJeH8fmvkeiFN894r1auwtLlWtSKCN3gV8S+QcU5x3HzdVNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160426; c=relaxed/simple;
	bh=qh9pydhYQDgoyrdDnjkthh5SbPAnEubl6Q31jqg/n8I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d0xQP/3KUjXMfSGqYu60901/AsWzDcydfgBoFmSRaufkmSty0ZToG6tH2AkRSbRiUurrvvcIiXS9BX71Bbov0eF33vO/ix5v5e/zzLean6QShZ1ynP9DA7eODRlcsDb+kw1mTPwiMBoY03WN9nkJpMYjOc7ZflV5Gpb2aGzF5GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cwpgS5Ej; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724160425; x=1755696425;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qh9pydhYQDgoyrdDnjkthh5SbPAnEubl6Q31jqg/n8I=;
  b=cwpgS5EjYnrmQ8P8Y9GFBaInczCzrUxJrodOUFTSM5l1tPC3HKc6XvkP
   Ciz1l5riHr2PKhOPnFygQzkHBkNOtE642w94N7CIqd8ifEzpLWqfjww7L
   F5zomcjCL3gzYAt2ybJKU24sR0zf/QvKgzO0bJ2ddhaEn7IeSmv6upIwC
   8eeX8daRJI0yvBIIRtZy5D4IIjdf90/H6l46f3gzKtQ0U4wKHlBG+oM2h
   aOoQEZd0rYyuKn60OCo4QmHLuZXc3sbGRjxiPbiU9UuwXLbyYJq6GAVjM
   r15rx5+qmudv6w7wN2cuzKwZSDN4G2jKJcMmeCmbdMKuOLRfGJN+tC8wm
   A==;
X-CSE-ConnectionGUID: CFX8Vb0zQd21wX56GL2h8A==
X-CSE-MsgGUID: gNc3UiG5Rpy/qzmEkQeFBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33127148"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="33127148"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 06:27:03 -0700
X-CSE-ConnectionGUID: c78qm6Q5QF2KumuGqbY86Q==
X-CSE-MsgGUID: GCR3jWTSQVSPoyKbdQ+ydg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="91455166"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 06:27:03 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 06:27:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 06:27:02 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 06:27:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pR8MQIaADNnrZNwvb0hKx9B4QVxEqh+cM+IpHvPQGkjbxbbTBR0nWrSsPB8RLMIsaiYqLTpNw0PZxsyTZh7Z4Ypfa1mvqmVvduAerI7s2DLhg7GYdWG5VoZ226rGZzpJ3pZ1Y6zAM8ZVPTZC6NbVSBIKmNAMeZSOh2Cza8zIzyHKf7gR/SgclmCSH+qCUrX9K2ePCYkaKMJhyWq4fCIad5IiRMOU5c/zZefmrRyXsZHp9Sl4tK+bjNcPIewgTr8BcBHGrc+jBsopvZjGwtkCDwV/dNamuq25nWzevaTVw+TU7LVyHhv2OK+TaBIv039yzXqXt156QQJbBJT12NBkrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60VsH6a1BX9aRv0g6QcDlCVPXboDAK9mdEJYZPr5zzw=;
 b=wB+e32khT6ywFmHuKTnS3dpkN/7jDpmMNWHP2Vd1gGey5z3l0cs541oMFYWYX81m1yuWZD6Zng3i06onn5ub/dchDFIhGfpgj1KaPtvzV/+oryy9ZVyNfJ43UWuBOfkvGAQQCNK39+lyPPe1rXjpRxcH8BgRRPQfdRkrlbABxa/iOaW6oY0nSf33zvRJxXMwGuHGjNF4vddVXFJZoClplUTV4RnBeiVpkPOvJ1cLDorR5Uuj9NREw4z8JifyPW403IYUrg6ktsrEToXGUUNvu+euDJeTrVQS51BK9tndPJss1UT0WUa116PvMfHRZ97zfV7hvFKz1yf5/MEAE6Ca/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM4PR11MB6408.namprd11.prod.outlook.com (2603:10b6:8:b7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.20; Tue, 20 Aug 2024 13:27:00 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 13:27:00 +0000
Date: Tue, 20 Aug 2024 15:26:52 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Jacob
 Keller" <jacob.e.keller@intel.com>, Eric Dumazet <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, Michal Kubiak <michal.kubiak@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, Amritha Nambiar
	<amritha.nambiar@intel.com>, Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: Re: [PATCH iwl-net v3 1/6] ice: move netif_queue_set_napi to
 rtnl-protected sections
Message-ID: <ZsSZnLt9k7zn8G6T@boxer>
References: <20240819100606.15383-1-larysa.zaremba@intel.com>
 <20240819100606.15383-2-larysa.zaremba@intel.com>
 <ZsSMt3O4a+Jq0e65@boxer>
 <ZsSQY14RCWlG/Bxd@lzaremba-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZsSQY14RCWlG/Bxd@lzaremba-mobl.ger.corp.intel.com>
X-ClientProxiedBy: ZR0P278CA0038.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::7) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM4PR11MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: b96777c7-2904-45ff-e370-08dcc11bc4b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U5rFX5G9k5Zj7eL8Ey//JnuhzFRkcFIrpQ1KmGmO3g/JFGr5z5/z2+AWGv8r?=
 =?us-ascii?Q?ugxR8P5pMiPolCwh3i/ZMTHq1ASgV9BQ2y6kIYzhAwe8MdwDWnhJthtR7+QQ?=
 =?us-ascii?Q?B+ZhOyV11524X8tYdl7mQS9Pd7IH6UGsQRKDqwcCHYwlRrS79c9mAnq6WiYM?=
 =?us-ascii?Q?TIXZ0LcCYv6o1WJYsfGpx5DOw9uBGQW+cNaD3CUHgzjHWO6XPmhjBYzhB+Pw?=
 =?us-ascii?Q?cXTT9kqsfnDB+i+PR/8Zug8f6b8NW1ZGOltuJvie++sMZgMUOf1g+PGM9xl0?=
 =?us-ascii?Q?cQxRuFOSVtwcG+aYJ9Pjh1Uei3SMw0xINtVL9+ecrLq8ionZgopwLz7c6eUz?=
 =?us-ascii?Q?6Xfwds48Ir1AsJCMG/wi38qn185FylKSPIko7apkl3oppWO1PAm7PrOkEoSk?=
 =?us-ascii?Q?TjEOTuj9l/+N0oOvkxGZnZfaePajgmiAu9ZHYe5QpaWm3JPrPlDk7ih6v8J/?=
 =?us-ascii?Q?j6+Pbnhyxa0TJC9nSkCVhQT45omHPrucpeFSaxn6EGnsrUc4rreyLbrbCwZ+?=
 =?us-ascii?Q?2rHmMi1BnyPoCYy52x8T7GQxx4dh9sTUWgmkQm7CIg7jW6KJ6MCMilY1Tjme?=
 =?us-ascii?Q?IaeDhXxVhZsunTqlCkS6piaYiPRFhbjPOsyRzedjo/smVGRb3bV9bKQ0mqr3?=
 =?us-ascii?Q?dM/yDZpYfAHHO5yYnVobQMrLwB4aqMFOrjoN6O9Okvd08DZKL8wnTfHTKWGI?=
 =?us-ascii?Q?GdaVeu0VPyUrcCh+3twdFgWor1zyDw7aaSC8bd17hNlM/yXJPRTKztvUHqhk?=
 =?us-ascii?Q?UeLW9w3e68C2qv2moo61Gr+vXiaMgNAuxEJCJGeAl/qeN36tiVHeTi6VqqLM?=
 =?us-ascii?Q?ZIB6LIGMcnFVVU5Oz7kSvZj1So9Z7T9CyP638Utv8LjeJgSmpWbrCwQPBk6i?=
 =?us-ascii?Q?syopgBoyZv8YUp3Y6tdfWpy87ENYnku1HCkscPBlXMMdVIIgsP5e0zOqbU1p?=
 =?us-ascii?Q?fHIGqWEIGTggXkdbxiLJV17JkRuiMr/LSkmpEw/vuO/PPRpecgXNJ4dskPth?=
 =?us-ascii?Q?OpjtcDQ5P+3ZpSn8qQI7uCZX8G/u5zQ+w6o6CkdXF05GWu4ZpRLZE0DlD1vj?=
 =?us-ascii?Q?J6lxxgHyLltDUmjB+n+JZJIbIKuHclXo33rWnWWJi2iIlSXCBm/0K9WJCqWm?=
 =?us-ascii?Q?C43fUvS9xG23AcYCWV11izfzrumY/VjKizLLgV0NH4Suo6RNYE0xvthmq8NI?=
 =?us-ascii?Q?ZOgrNlr/wmcS/7ZNUD2P5EpUJUtLH5wRvnG58/w02GHw209ipnXSqOjDlTcr?=
 =?us-ascii?Q?+J6LL4ZnFhniyFnKUZExcyh0d2vzKfP1eJimjUs2W1XI2tJLIGXkS740Bhy9?=
 =?us-ascii?Q?QSBqMDjUfOARqxWvE9wcG5LCaSpwqI6PvukNbyBrSQmxBA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yKZq3qtHXHc47D2n6QU98b8KSa205/EUUZu3Xsruy4cz9Sw+4AL0z6nIfr2G?=
 =?us-ascii?Q?ZJyKorPhLZGzqXIDpQ6x4BydQ36Zu0ZlEJi0bb40ntNuG9CyHJsaNAQZFicL?=
 =?us-ascii?Q?FcjV1AID1GM8jcEJCk2P80quMBshOe8+kt/KomVYXFbmzIgDg4xvIL784pI1?=
 =?us-ascii?Q?V6E3R1uu49XFl2LqME4epPEunSZCH/g8IEJ/DGCZnbfr5F0Xlc9Ec+H4svoC?=
 =?us-ascii?Q?pDvPPUAd5Hc2982B1ZU0tkvfg7UtBb0CGI8rXysCCldgvGRH0Nzlj08AFRcr?=
 =?us-ascii?Q?N4uoqYC1xPQL0FnkCInTHgVYSfzwrzjYdgM9IOQTcGRpK3Sfkr/JuxBcKsR2?=
 =?us-ascii?Q?TbTfR6Pqx0/QuDQKt5Slm0ETQCZZ0ZzClZcZ/7o2kwMs+U4qNVPTwnGw+OjM?=
 =?us-ascii?Q?pRCFHm9t+4K9+oMNrfVzI0wUOoIDyvDpclT/MLb2CNGAg8pudnO7xPZ1C2EG?=
 =?us-ascii?Q?3pXDBic5CNnASnvRbaiJ5f7kyMU5Q1Yb3sjQR+9yj8HSuCZjnAfEMD98O0NC?=
 =?us-ascii?Q?b+BY2ASXYvzpKQzAW0yV0J/pGpti6YWhiqCCvHgQUK91YrwbyqzObmesCFXN?=
 =?us-ascii?Q?CJ0ID/gr39HoyNTB+Bw/RS9UJVSAaePsYmxGAiycVzyhSiiqJdEQ74gWp6EN?=
 =?us-ascii?Q?8oXyzPGD0+ad5snm9pUL1ibEkei715BZoWI1mNCALLv6IqZNDmi8VSTwXpWN?=
 =?us-ascii?Q?zCViC17TPn9H6U4tj90WSPHTAP7Mugt7d07jKe85NZyH29fcEpL6UIkz+H6u?=
 =?us-ascii?Q?P37CZQ/p6DvKc1UAxDwNADSPcnqgdfTGscvmX3Uu/EeCVYDBYpYnCdD2IGjW?=
 =?us-ascii?Q?COv/xP8Ni8k87C68QP75aU7e2MScxBRuQaFPUUZqe7jxbCiHiW/TYpkRVPCi?=
 =?us-ascii?Q?vsq3t6TmY6/wbyMJo91+KQhgzRiyuBLCvZGWaW+MmbB5EubDP8S13fsFbPgN?=
 =?us-ascii?Q?TtXG4t1GfwV4f0OmzFGiOTChP962nNSgYpJBoyjs/IPOLGTF6JA3kdxzl2my?=
 =?us-ascii?Q?HBYdHlkknMTzUp0bIuzwlbHPLS7CqncDCKn5VGTlJpronxg9lfmvVtfiBT+3?=
 =?us-ascii?Q?9yrv1LiWG1MU3R8KEg6XeTkvH3YFpVhXqqmL0tFz2dS43CRIdbKpUh873d47?=
 =?us-ascii?Q?CmrUjGR86qPkbWWH9XOp52tu2hkjFRA94Z2S4NZB09nXB6dr55Up2OWMsv7O?=
 =?us-ascii?Q?pDAnd9RdgaHNvq4/VxZMWxWXWX2WSF7Sc42vizeKl5NGUeFHQo1PiMVAVBAj?=
 =?us-ascii?Q?65IpNY7A8Mi5TfqH1IgbcfCSIABtOhp6EMblLUnDzqqKABLHKM1ifHfWZuQk?=
 =?us-ascii?Q?7vdiKQvRfizkOuCXPAOoR4FWK557V91EnectuAbcy8pmV/Dlk8kYzkGGWVfN?=
 =?us-ascii?Q?cB4E7K65Lp9Tcej+GnJ1y4/b/w3Ly+ZPeukiaovM0T6/c2968KP9F52IIMlh?=
 =?us-ascii?Q?Qfnro8xY/zRJIS+Deq1KX2tetr/xhcEpes6ju9lpwqvZsUUQ9M/p9inqXb0m?=
 =?us-ascii?Q?IKgQkA+INIw4m1u4KOX7ktJlNUj+zg6zhsK4GcOtMps0fw/zXYZwW0iXqWS6?=
 =?us-ascii?Q?caBUneh8M4IQ5vdnzbFb6AZA4qPrHj88HAOYIYmq05cPPDRuVrH4+/SKVHfM?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b96777c7-2904-45ff-e370-08dcc11bc4b6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 13:26:59.9095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAgNhwshgIWJ3JMO8vNu7gcrDcqqIbWvuTMs7jmFPLMhBPA7iFPZCCJVh1lsJ6wo2mr+BD+FACoTvStpZmzPyoRHqgDzVYYcWMtdOfZPtYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6408
X-OriginatorOrg: intel.com

On Tue, Aug 20, 2024 at 02:47:31PM +0200, Larysa Zaremba wrote:
> On Tue, Aug 20, 2024 at 02:31:51PM +0200, Maciej Fijalkowski wrote:
> > On Mon, Aug 19, 2024 at 12:05:38PM +0200, Larysa Zaremba wrote:
> > > Currently, netif_queue_set_napi() is called from ice_vsi_rebuild() that is
> > > not rtnl-locked when called from the reset. This creates the need to take
> > > the rtnl_lock just for a single function and complicates the
> > > synchronization with .ndo_bpf. At the same time, there no actual need to
> > > fill napi-to-queue information at this exact point.
> > > 
> > > Fill napi-to-queue information when opening the VSI and clear it when the
> > > VSI is being closed. Those routines are already rtnl-locked.
> > > 
> > > Also, rewrite napi-to-queue assignment in a way that prevents inclusion of
> > > XDP queues, as this leads to out-of-bounds writes, such as one below.
> > > 
> > > [  +0.000004] BUG: KASAN: slab-out-of-bounds in netif_queue_set_napi+0x1c2/0x1e0
> > > [  +0.000012] Write of size 8 at addr ffff889881727c80 by task bash/7047
> > > [  +0.000006] CPU: 24 PID: 7047 Comm: bash Not tainted 6.10.0-rc2+ #2
> > > [  +0.000004] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0014.082620210524 08/26/2021
> > > [  +0.000003] Call Trace:
> > > [  +0.000003]  <TASK>
> > > [  +0.000002]  dump_stack_lvl+0x60/0x80
> > > [  +0.000007]  print_report+0xce/0x630
> > > [  +0.000007]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> > > [  +0.000007]  ? __virt_addr_valid+0x1c9/0x2c0
> > > [  +0.000005]  ? netif_queue_set_napi+0x1c2/0x1e0
> > > [  +0.000003]  kasan_report+0xe9/0x120
> > > [  +0.000004]  ? netif_queue_set_napi+0x1c2/0x1e0
> > > [  +0.000004]  netif_queue_set_napi+0x1c2/0x1e0
> > > [  +0.000005]  ice_vsi_close+0x161/0x670 [ice]
> > > [  +0.000114]  ice_dis_vsi+0x22f/0x270 [ice]
> > > [  +0.000095]  ice_pf_dis_all_vsi.constprop.0+0xae/0x1c0 [ice]
> > > [  +0.000086]  ice_prepare_for_reset+0x299/0x750 [ice]
> > > [  +0.000087]  pci_dev_save_and_disable+0x82/0xd0
> > > [  +0.000006]  pci_reset_function+0x12d/0x230
> > > [  +0.000004]  reset_store+0xa0/0x100
> > > [  +0.000006]  ? __pfx_reset_store+0x10/0x10
> > > [  +0.000002]  ? __pfx_mutex_lock+0x10/0x10
> > > [  +0.000004]  ? __check_object_size+0x4c1/0x640
> > > [  +0.000007]  kernfs_fop_write_iter+0x30b/0x4a0
> > > [  +0.000006]  vfs_write+0x5d6/0xdf0
> > > [  +0.000005]  ? fd_install+0x180/0x350
> > > [  +0.000005]  ? __pfx_vfs_write+0x10/0xA10
> > > [  +0.000004]  ? do_fcntl+0x52c/0xcd0
> > > [  +0.000004]  ? kasan_save_track+0x13/0x60
> > > [  +0.000003]  ? kasan_save_free_info+0x37/0x60
> > > [  +0.000006]  ksys_write+0xfa/0x1d0
> > > [  +0.000003]  ? __pfx_ksys_write+0x10/0x10
> > > [  +0.000002]  ? __x64_sys_fcntl+0x121/0x180
> > > [  +0.000004]  ? _raw_spin_lock+0x87/0xe0
> > > [  +0.000005]  do_syscall_64+0x80/0x170
> > > [  +0.000007]  ? _raw_spin_lock+0x87/0xe0
> > > [  +0.000004]  ? __pfx__raw_spin_lock+0x10/0x10
> > > [  +0.000003]  ? file_close_fd_locked+0x167/0x230
> > > [  +0.000005]  ? syscall_exit_to_user_mode+0x7d/0x220
> > > [  +0.000005]  ? do_syscall_64+0x8c/0x170
> > > [  +0.000004]  ? do_syscall_64+0x8c/0x170
> > > [  +0.000003]  ? do_syscall_64+0x8c/0x170
> > > [  +0.000003]  ? fput+0x1a/0x2c0
> > > [  +0.000004]  ? filp_close+0x19/0x30
> > > [  +0.000004]  ? do_dup2+0x25a/0x4c0
> > > [  +0.000004]  ? __x64_sys_dup2+0x6e/0x2e0
> > > [  +0.000002]  ? syscall_exit_to_user_mode+0x7d/0x220
> > > [  +0.000004]  ? do_syscall_64+0x8c/0x170
> > > [  +0.000003]  ? __count_memcg_events+0x113/0x380
> > > [  +0.000005]  ? handle_mm_fault+0x136/0x820
> > > [  +0.000005]  ? do_user_addr_fault+0x444/0xa80
> > > [  +0.000004]  ? clear_bhb_loop+0x25/0x80
> > > [  +0.000004]  ? clear_bhb_loop+0x25/0x80
> > > [  +0.000002]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > [  +0.000005] RIP: 0033:0x7f2033593154
> > > 
> > > Fixes: 080b0c8d6d26 ("ice: Fix ASSERT_RTNL() warning during certain scenarios")
> > 
> > Shouldn't you include:
> > Fixes: 91fdbce7e8d6 ("ice: Add support in the driver for associating queue with napi")
> > 
> > as we were iterating over XDP rings that were attached to q_vectors from
> > the very beginning?
> >
> 
> I probably should have done this.

Maybe this could be included while applying or sending the pull request by
Tony. I'll go through the rest of set today to see if I have any comments,
if there won't be anything outstanding then it won't make sense to send
next revision just to fix the fixes tags.

>  
> > > Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> > > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > > Reviewed-by: Amritha Nambiar <amritha.nambiar@intel.com>
> > > Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com>
> > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > ---
> > >  drivers/net/ethernet/intel/ice/ice_base.c |  11 +-
> > >  drivers/net/ethernet/intel/ice/ice_lib.c  | 129 ++++++----------------
> > >  drivers/net/ethernet/intel/ice/ice_lib.h  |  10 +-
> > >  drivers/net/ethernet/intel/ice/ice_main.c |  17 ++-
> > >  4 files changed, 49 insertions(+), 118 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> > > index f448d3a84564..c158749a80e0 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_base.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> > > @@ -190,16 +190,11 @@ static void ice_free_q_vector(struct ice_vsi *vsi, int v_idx)
> > >  	}
> > >  	q_vector = vsi->q_vectors[v_idx];
> > >  
> > > -	ice_for_each_tx_ring(tx_ring, q_vector->tx) {
> > > -		ice_queue_set_napi(vsi, tx_ring->q_index, NETDEV_QUEUE_TYPE_TX,
> > > -				   NULL);
> > > +	ice_for_each_tx_ring(tx_ring, vsi->q_vectors[v_idx]->tx)
> > >  		tx_ring->q_vector = NULL;
> > > -	}
> > > -	ice_for_each_rx_ring(rx_ring, q_vector->rx) {
> > > -		ice_queue_set_napi(vsi, rx_ring->q_index, NETDEV_QUEUE_TYPE_RX,
> > > -				   NULL);
> > > +
> > > +	ice_for_each_rx_ring(rx_ring, vsi->q_vectors[v_idx]->rx)
> > >  		rx_ring->q_vector = NULL;
> > > -	}
> > >  
> > >  	/* only VSI with an associated netdev is set up with NAPI */
> > >  	if (vsi->netdev)
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> > > index 03c4df4ed585..5f2ddcaf7031 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > > @@ -2286,9 +2286,6 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
> > >  
> > >  		ice_vsi_map_rings_to_vectors(vsi);
> > >  
> > > -		/* Associate q_vector rings to napi */
> > > -		ice_vsi_set_napi_queues(vsi);
> > > -
> > >  		vsi->stat_offsets_loaded = false;
> > >  
> > >  		/* ICE_VSI_CTRL does not need RSS so skip RSS processing */
> > > @@ -2621,6 +2618,7 @@ void ice_vsi_close(struct ice_vsi *vsi)
> > >  	if (!test_and_set_bit(ICE_VSI_DOWN, vsi->state))
> > >  		ice_down(vsi);
> > >  
> > > +	ice_vsi_clear_napi_queues(vsi);
> > >  	ice_vsi_free_irq(vsi);
> > >  	ice_vsi_free_tx_rings(vsi);
> > >  	ice_vsi_free_rx_rings(vsi);
> > > @@ -2687,120 +2685,55 @@ void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
> > >  }
> > >  
> > >  /**
> > > - * __ice_queue_set_napi - Set the napi instance for the queue
> > > - * @dev: device to which NAPI and queue belong
> > > - * @queue_index: Index of queue
> > > - * @type: queue type as RX or TX
> > > - * @napi: NAPI context
> > > - * @locked: is the rtnl_lock already held
> > > - *
> > > - * Set the napi instance for the queue. Caller indicates the lock status.
> > > - */
> > > -static void
> > > -__ice_queue_set_napi(struct net_device *dev, unsigned int queue_index,
> > > -		     enum netdev_queue_type type, struct napi_struct *napi,
> > > -		     bool locked)
> > > -{
> > > -	if (!locked)
> > > -		rtnl_lock();
> > > -	netif_queue_set_napi(dev, queue_index, type, napi);
> > > -	if (!locked)
> > > -		rtnl_unlock();
> > > -}
> > > -
> > > -/**
> > > - * ice_queue_set_napi - Set the napi instance for the queue
> > > - * @vsi: VSI being configured
> > > - * @queue_index: Index of queue
> > > - * @type: queue type as RX or TX
> > > - * @napi: NAPI context
> > > + * ice_vsi_set_napi_queues
> > > + * @vsi: VSI pointer
> > >   *
> > > - * Set the napi instance for the queue. The rtnl lock state is derived from the
> > > - * execution path.
> > > + * Associate queue[s] with napi for all vectors.
> > > + * The caller must hold rtnl_lock.
> > >   */
> > > -void
> > > -ice_queue_set_napi(struct ice_vsi *vsi, unsigned int queue_index,
> > > -		   enum netdev_queue_type type, struct napi_struct *napi)
> > > +void ice_vsi_set_napi_queues(struct ice_vsi *vsi)
> > 
> > this appears to be called only in ice_main.c. It should be moved there and
> > made a static function instead of having it in ice_lib.c.
> > 
> > Unless I overlooked something...
> >
> 
> You are not missing anything, but I think there is more value in keeping the 
> set-clear functions together and ice_lib.c is a good place for that.

Yeah I realized after sending the comment that clear func indeed has to be
exported so I'd say we can live with that.

> 
> > >  {
> > > -	struct ice_pf *pf = vsi->back;
> > > +	struct net_device *netdev = vsi->netdev;
> > > +	int q_idx, v_idx;
> > >  
> > > -	if (!vsi->netdev)
> > > +	if (!netdev)
> > >  		return;
> > >  
> > > -	if (current_work() == &pf->serv_task ||
> > > -	    test_bit(ICE_PREPARED_FOR_RESET, pf->state) ||
> > > -	    test_bit(ICE_DOWN, pf->state) ||
> > > -	    test_bit(ICE_SUSPENDED, pf->state))
> > > -		__ice_queue_set_napi(vsi->netdev, queue_index, type, napi,
> > > -				     false);
> > > -	else
> > > -		__ice_queue_set_napi(vsi->netdev, queue_index, type, napi,
> > > -				     true);
> > > -}
> > > +	ice_for_each_rxq(vsi, q_idx)
> > > +		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_RX,
> > > +				     &vsi->rx_rings[q_idx]->q_vector->napi);
> > >  
> > > -/**

(...)

