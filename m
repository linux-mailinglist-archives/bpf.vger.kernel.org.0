Return-Path: <bpf+bounces-66462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422C9B34DCD
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 23:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8DD3B718C
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 21:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86513288C35;
	Mon, 25 Aug 2025 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hqb2rjyn"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCDD242D96;
	Mon, 25 Aug 2025 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756156746; cv=fail; b=p3JIOfM8OxdK9+slnewPOzict0QHPHd/SpnTpmhwaExoFG2JWg+3UK6OSBKOvgSYawbwG8WEjnJeXqNqW/5Drin94/5eJrIpoF2uHL+/vIrwJVyhY2KlTeQ2X6PWSV/f+hxk+E2AmlLsflV7Tl9J4ttFj1qCgb3zIC8FaAuhY5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756156746; c=relaxed/simple;
	bh=+eHBDXOiXC4ZZbDakx02ZfkrIN2P7jhiJo27Nctn61o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NWWk0mGE5JWAfATKdUH3gknjL9ga9JUwaKxwZr3RoruPuvwlBC7s5UwynowYtTvS+N+zrZovVoPAJblikOkNjjbgrXXozW4ADkA9/NQYquNyJKCVaQK8LEOOhLpBX5EEtEfoo7WMGBhT1XkwW9QPlpP6s1Ppq/jZN/ISpEe3NU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hqb2rjyn; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756156745; x=1787692745;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+eHBDXOiXC4ZZbDakx02ZfkrIN2P7jhiJo27Nctn61o=;
  b=Hqb2rjynb6/jEhCi+79oAEVZZMmbU/dkpaaKZxr3PU/vpeKeDga1w+ey
   vvIPopkOvOLzj5yh+dLukUYR/I++mRmP+d+XUyeDu2NFOfeEvgm1DCTFg
   NjlmDXaKdwLKZhZ1eQV3a/Jp2RYi90RGkm/mXDqziSPqbJigUQIFBp+A5
   mFhej4A+XG5sOGJZW1TfBvegLycsfGlBOFza0dzI144B1g75NUAygg+Ov
   MHIO8aVJjkUyFhiPlHa8Zznab8kGkhMZB3p+uHdbxXgBOMKFxQG0UHa7F
   ULy+13hfIyR0xp4j4CEjbAmHZxql7wrUm6eJ6pcIqmoKpj6TWvKRjABkh
   A==;
X-CSE-ConnectionGUID: N/kKlrrqSPKjUIW9dg1XpA==
X-CSE-MsgGUID: E8twQprRSXSZWJR38wj3Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="68973736"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="68973736"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 14:19:04 -0700
X-CSE-ConnectionGUID: AiKXgnS7STiodVC9v/B5RA==
X-CSE-MsgGUID: FnOd1bF/TISaUtpzawjdYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="174677622"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 14:19:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 14:19:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 25 Aug 2025 14:19:02 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.79)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 14:19:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBpff6JzUNcXU/glRalMBlASQwgpOBNRpjqeB6C0iY8Hqy+7jOe0pjMTjYbBJs/NpzYxuLxqt9iDAYTMOyMtgUD3QvDGVYo8+RYBoXfl9qwuJjD3yUfb3Q9b16VK/k0GxSYuJHdzfd2f1s4gjy5B8nLHvPY+cQonvrikIDCI02C6ynHwUa98iSXI42ECkh39yBXhLauRIgXWIy6CqpCFUUyzunRMglXZdQl3Xacsz8W+qaNHgvbP8BWikT3FQZN1jPZfQ35tEwyr5yZrurTjAzRPAtODb69IHd2Lm334gr1NCqG+5nMNUy6kQlF0bdxXuWAIgyRZkxfg1df1wcnqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbFzifc1stBF+cXV4453rfUTN+urnS+7KsK4r1pp+BY=;
 b=gLhmUrErCqpYrBZjlBbHm1YlB+18r9zJVbFnI8zWswB2/NbgG/of4b8cAfNT2e9QJr/F7zzrZ+GYK7Pw55XQP4R87a1hbmaHPd+kfCTXEOWncUk80fr2Ja56Mf40o2Uxbk/XKcsq74ZKZlU/hgC7mlVLF1pEzvTsfUAHxSUcZ+vDXwfAQKZ3ZmfCpWMppw3BcgopUbr93c+j0Idj3BwnrVpE4QutQnV+EwKqhTLNKM+1LJhGbZs4nDrTzVkzp6fVp1qVDNpoAitfLjj0CiyAVLZDDYydpFPdHZuCSoRMFqZOAvcaNBoyaOu+opPhq69aH8GanXKoRCaZgSWKy+0wuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS7PR11MB6014.namprd11.prod.outlook.com (2603:10b6:8:73::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Mon, 25 Aug 2025 21:19:00 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 21:19:00 +0000
Date: Mon, 25 Aug 2025 23:18:53 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<horms@kernel.org>, <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2 2/9] xsk: add descs parameter in
 xskq_cons_read_desc_batch()
Message-ID: <aKzTPW4fQ11fqb+b@boxer>
References: <20250825135342.53110-1-kerneljasonxing@gmail.com>
 <20250825135342.53110-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250825135342.53110-3-kerneljasonxing@gmail.com>
X-ClientProxiedBy: DU6P191CA0031.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::10) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS7PR11MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f53aea-ce39-4f6c-a464-08dde41d025a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UZoFRQLn1jUOgi7POSQUq24dhQ/MwaQiCP68NqlvgxqVnrFrXAuj8ayoZlKt?=
 =?us-ascii?Q?/8u4oi4lmjgyu7fF9bOUTx9zeCPXLb6sOEpQrdNH0SqYSyU9GVLuf5m7P3Ev?=
 =?us-ascii?Q?RwiEEx6DyfAFB6QQUm50uXeozO1m2GHWNPWQgjDWZiZKgy6scHCJASXv3YoS?=
 =?us-ascii?Q?Z6gThuBCZJLA/B/k2LLCPFlDk322qVNcsDMSM5fNjDyAgNjsM2zF9/0+jNbF?=
 =?us-ascii?Q?c2md/SvIAAmhiM6yyuzcHYCUQbu1A36wJT71SVR7g5frvNX1/hJTE4ZXX/da?=
 =?us-ascii?Q?+0GAnH/QCwtDyJSQ56mf5lAs4lWgZ6GmMhWm1NRwZeiKgSvpH/bzWCI8qBYT?=
 =?us-ascii?Q?IVfOjwW1KpanZhQ28q9//SzwPNrU8eHrJzXtYpgMwMwmRUdv2ft4aWUDlU5l?=
 =?us-ascii?Q?n4tW4C31EChbzg10rEquIiLcpijEGxudrN71zaeLWNiIcKTMEDZFsT1bamnF?=
 =?us-ascii?Q?6AvfCnWHomtZGQ6F0ZPriyC9pXcpkPzr8BVAlIXeVY3cUo20LuyuxhQeUN2K?=
 =?us-ascii?Q?x5o1Ridbg8OuAFjOZzFqHcxnEYKZJNv3rSsfqoksDHgRI1ShPZf0PNp8b180?=
 =?us-ascii?Q?wFiuItiVwOUb+XBC09XmlLUR3A30ppmg4eQcmm53Ly+McHnwtXgPV5fnwWXk?=
 =?us-ascii?Q?34iydBx6j7XocsyHTGp2HRnzcgZ6rzvelfuFl4HU7YBPYZXIBT1YqecZX8o8?=
 =?us-ascii?Q?1zHwUDg5PMZh6o//pP1vACYWj1ToAGTjOZrK4p9zKSB9edriGlPHViqudDLr?=
 =?us-ascii?Q?ESad5r1707b44IzPsD3rDcCAnR3xGMvC0AFQPh39Ll8NBcJutFm/4n9S+3bK?=
 =?us-ascii?Q?kvMlDdWl0opYyj5fbdd4PLy0w9oSZTGdmiph4l29Uoh7lX76JHAjKfMB559q?=
 =?us-ascii?Q?RWe2erdLVcmcDMjwwZkfIaHAbL/6tcPlFuoFNPXDcs1nksIaXTueQIEJ5AWv?=
 =?us-ascii?Q?Q48gIY3U+sove7SmQyQ/3oPxyuW3F9LaNQk3IdNRx1vCRAGllEqcJBk4yV/W?=
 =?us-ascii?Q?83v1Yr6bxXLWlZjJNTN2JdlVgotddxgKt1QRuwRv7S0VFTh0eNqSK4Sdkn8O?=
 =?us-ascii?Q?e9QmJIajkWJEyR6vJZem47Ui6GBxPr46sugp0FUT/db0E7bZthEbVSNQasg3?=
 =?us-ascii?Q?lX0myXXo0bRFqFTbRqpEHowaWKBAL/m5fBRhPE7CCSEYO/aAQJM5wPMJfOWg?=
 =?us-ascii?Q?DxSJd8f7jyK6l4tvDv89ddaayzNBg680S30LimlwbOBsz6Zi0tx0C5Vp/HfK?=
 =?us-ascii?Q?/HLP6O7VT9Xb0IZJKWWsTvzkIs2hkHjSmZ73oT6O+XGSRNlVzLYqRxXGfK1M?=
 =?us-ascii?Q?BeIt77bl7sf8o5Ccm/5/TAftvmv8SjIn3PMd0a4xnvaLBn+hIbnFdM3StLdM?=
 =?us-ascii?Q?N8pa8TceoohVt6taeK9UwMFYiRkgM91zQHMrCEuV5+5yOKUZvVLq+qXI1ioJ?=
 =?us-ascii?Q?HaE91Y3YIeY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZLhRKPcj0lpVD/T1p2gzC4QsksaqKpqPC4heTQvqpPWZI9Dd3gk1/T4PBgkT?=
 =?us-ascii?Q?2PB9K0BfNEh//1u5yWztad+nuUTIiCk2FCHNOg0RUqnoeacNGT67gNq1AJH/?=
 =?us-ascii?Q?QlSU8bkPB+5ypomIOT+x7G67kilgULAs8p0mjeaRtqJVm3pXw8Sco6HavfDm?=
 =?us-ascii?Q?2R3mYkiYdrNqd38dY0iKntKiGDjMi4cO4PNh2k3dffXD9VuO2kBoru8goMML?=
 =?us-ascii?Q?Fx2opbsJ7gIP4Vmvb5gIibajtFvq80RkoSYO9Po8uqC3rrWKTTB9GJ+QePtS?=
 =?us-ascii?Q?0odAiFzlNwJNPJOkz/gzKpU0sngxO4sEoLV8gwGNMjtA5aVTXbuKCAV2Oe0U?=
 =?us-ascii?Q?O6MJBPTqOyCkKF6cpkzC5wAhKcx/L0U5mgbyAhDdZkUzERqLStX2ZRv4Hkjx?=
 =?us-ascii?Q?ea+Ux2jYSxiHahErtnbOdr/BmuW/JBWRzD0xdHP5qzJFq/lhoCRzniA/+b3+?=
 =?us-ascii?Q?bZkeIXUTqhUk6/KxTs6W+v5V6V4u3mWVzCBJixRYD3/+tRGgWP50QOUbFUPd?=
 =?us-ascii?Q?h8CEebyoMKOP9B6dP5e1nvnDXQFZNTPfS/Q7wxEqb1jkrVolN5CntUI4ZTb4?=
 =?us-ascii?Q?NVI80mtWwkozfnKkxaK2bRuaAIdJ5gsBy4ePcwJxc0jQWDAlLij/o03yf+bO?=
 =?us-ascii?Q?BohhdcgTshIlZC+07VxCT/bhasQQOepcZHskzzII+69jT6gSJx0cQxbJSbnI?=
 =?us-ascii?Q?+X4FZCc7IalL2orDZdyfmennxtibgFvmb6hiDnv0+yntsK/uyPFcITy0LGdu?=
 =?us-ascii?Q?NeCY3regaE0aKsCyDC4KuOZ24l+n9NHn6xXL8aE3zfHCJYkZ6VOWaDbAQ8pq?=
 =?us-ascii?Q?eqJHHlCilpJA1HCq4wVobWpaaWHuHdrtFiL/hqje7FLIyAqScr5g3SbjGOd1?=
 =?us-ascii?Q?BdrbDspd9+VqL59/qX4sTLVR8wj2Ti0VmrHf05OnEUld2LBJHcJpy10aSZB+?=
 =?us-ascii?Q?l1u9R0gXmK+Rs7wTwSOPBjwWu8mhhMRHw4ibVWzJTJa61e21Y3Hf+Q5UdJZS?=
 =?us-ascii?Q?npHtOxeogdLmYuDKoPscg/FBGC/INSj0vl+5pczv+ZL7cegVWCxzf7mCBL7h?=
 =?us-ascii?Q?5a/H4i3H9ru5JFj7reiVN2HiP58JSLpbx9qzQ5iDrrjIS3NaABuguFXtx3eD?=
 =?us-ascii?Q?bBKhvKtSAzciojmpC5XJMqV5iTSKlPdCl8K/H1c0cY3naOlzcro85ZvSqNiz?=
 =?us-ascii?Q?I1TWJhaK3piIPRpi2f8+oQyCdsyuKplowT7GSgGnGaPG27g0Z1ZRrzrW8wvC?=
 =?us-ascii?Q?cjHnv4icyX1muq3e9riMLvJmeM/CR5iFRW7p4IGTSfa6b1wpN6AWADc1y9kr?=
 =?us-ascii?Q?FTw7O07oPeEnQEIYmjSfYDY5dgnAgXJbQD7ZJ+YXLvt5YfckyNOFmlS0jLkM?=
 =?us-ascii?Q?gq8hmkW3C9ZiysL33TP3MiFJjVD6Gnd5jVR+BL40W4VXmtVDpM4megxGeHjm?=
 =?us-ascii?Q?+PggN7QFGhXR/Dpz/rQ3OGHSMZqt5DTaHb3AeKqULIC0TzjHQ62xOmLmrfQH?=
 =?us-ascii?Q?h/P7dx3XRkIiezo1UXqAiWC5XhA0djvxoylXdOJKyRukKZm7E/87psG3jtkd?=
 =?us-ascii?Q?BA086yJGDU1OTrTI2zbA7ednCjeSwM5dIrT+YSehCAYTDaNHp6THrTK5duRT?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f53aea-ce39-4f6c-a464-08dde41d025a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 21:19:00.2497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3ZH2Psr2zJCrwlqKYQopuvQDUob/zwRIYOivLWzEtlFusrz1GcGEnzsDMC6jS/3zvQQSi1tTjNnUr2cc6dj/vaAIAdnkpMRPXGRSg/JwU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6014
X-OriginatorOrg: intel.com

On Mon, Aug 25, 2025 at 09:53:35PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Add a new parameter to let generic xmit call this interface in the
> subsequent patches.
> 
> Prior to this patch, pool->tx_descs in xskq_cons_read_desc_batch() is
> only used to store a small number of descs in zerocopy mode. Later
> another similar cache named xs->desc_batch will be used in copy mode.
> So adjust the parameter for copy mode.

Explain why you couldn't reuse tx_descs as-is. Pool can not work both in
copy and zero-copy modes at the same time so I don't see the reason why
you couldn't reuse this for your needs?

> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk.c       | 2 +-
>  net/xdp/xsk_queue.h | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index e75a6e2bab83..173ad49379c3 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -509,7 +509,7 @@ u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pkts)
>  	if (!nb_pkts)
>  		goto out;
>  
> -	nb_pkts = xskq_cons_read_desc_batch(xs->tx, pool, nb_pkts);
> +	nb_pkts = xskq_cons_read_desc_batch(xs->tx, pool, pool->tx_descs, nb_pkts);
>  	if (!nb_pkts) {
>  		xs->tx->queue_empty_descs++;
>  		goto out;
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 46d87e961ad6..47741b4c285d 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -235,10 +235,9 @@ static inline void parse_desc(struct xsk_queue *q, struct xsk_buff_pool *pool,
>  
>  static inline
>  u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
> -			      u32 max)
> +			      struct xdp_desc *descs, u32 max)
>  {
>  	u32 cached_cons = q->cached_cons, nb_entries = 0;
> -	struct xdp_desc *descs = pool->tx_descs;
>  	u32 total_descs = 0, nr_frags = 0;
>  
>  	/* track first entry, if stumble upon *any* invalid descriptor, rewind
> -- 
> 2.41.3
> 

