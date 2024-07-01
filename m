Return-Path: <bpf+bounces-33508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFF791E554
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 18:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9B91C218F7
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 16:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B5E16D9DD;
	Mon,  1 Jul 2024 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AubR30vk"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A2715A87F;
	Mon,  1 Jul 2024 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851276; cv=fail; b=pg6GPWHam7m5m86/OdhYZFPrBKGEfO2YOvo3gywAS9k4O+uUJvfH41J3IgMEDLX+NpWCC1mkoYbWsSOztpD4Rrm1uVyRbl5uQZ9px34wWVXdxJgHyEYwhrJ1mn9c0KxNRcVokyIVQVigCz6m8m5Sdg1UXK3Q1lLXPFUEj+bSkkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851276; c=relaxed/simple;
	bh=MDi41zQN45wUltprAe6vn7KMnQ3cAhGMLp16D+Tgds4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DmKNpwC7yPdaso9NooSH4O87317CYcvJh31S2ZFJ0i0PyeGOHXUdVG7Gzb3ntKTH4awI6vXFzoXz/nEer38d8Pd+j5LlRDYKiB67GazGrT57pO2D5nR8mv8AA8PPM0BB04MazB73EHbRxCfR57GLCjEHW/HioTYG1MT1hrJLYIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AubR30vk; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719851274; x=1751387274;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MDi41zQN45wUltprAe6vn7KMnQ3cAhGMLp16D+Tgds4=;
  b=AubR30vkB/nK1GjI4g2Rg79ZWr5NcLsKcvHeiP7MDIx8y1dCFC2dYNKK
   vp03ay7YmeSE1jgUhyX7vcYQcEm5jqx0NSBOQGlnw6jBFRtfPhuGY5Fer
   Hk5fiR2QIQbjfe4QFk44bY1cFdygIkKgKcRHMWm/H0MIpydIJlTXo4rcp
   Ym9Xhgsr/T+Bzbp9GUdjyWRKccUhPbcWMCqe9SJZ2ELOCZAt57ZoHpGoO
   rDmYDC2OxHC3VWEVzHVq2syhDjTUyn/TpTRmBosQH8gomcRrY/TDVo0Bt
   DaL7xekLQS0xp4TsKNOQU4IVBkSQRpRLGXh1uDkrtVolGQR/vAEKRRuF5
   w==;
X-CSE-ConnectionGUID: NHJ5WkuKQg6JUlq6sNR5OQ==
X-CSE-MsgGUID: /SW0DqqfQESPBEVwpwjp0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="16718871"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="16718871"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 09:27:54 -0700
X-CSE-ConnectionGUID: PtjEP1E+QLmfqA0UIXkZAw==
X-CSE-MsgGUID: TsagpjmQScuGmBhhIzuHKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="50461314"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jul 2024 09:27:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 09:27:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 09:27:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 09:27:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnajQilsXZXEy3yGPAyt3KrU9wwl/JKzfNq9aU/lZQYKRENTIg5FBIEbqnGBcx305s3BbM3zYNasKvSTtfBE+4wQbx67+5odXAZHD9QiOsZu902oZnz1ZpBOpnPyFeffRLIZyXc02QBXK6yGQb/Xwh7oDT/bXvBLenXHa0CNhIIpv8uT4feHGu7K9ACf1/6WAYkmLf2srby1cy4ZskhzxMPZ+CKe9Jw/uc7PxgULAjW4DIcb9ChnpjrN+kJ9F7DigahtAKTXTHf8HM9u6YsHhy2FuwGRo3t28/0s4QAce8AZwNyJ1P1WgcaYxf731BNpkAbMal+sIxPlUznFQ1ey0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6+R6RicLmWybXfVhns9Uf+OGXu9I7ee/PwCVuqypoo=;
 b=lzo+IVWUvikfsAeQ85GXWbGb12LyZrLOoMs4o2BsewtridxgOtd/2PtGmI+GS3S69QHwu2xB+3aNrnYgaIMi6ebXKr8y7JKyob/QdYGE3uflfSZq/RVXF2/AqcvnRICEm0ZpEUntVn5UDTyRbJnQvCx8OZYyo/nHBivqQ2MuifFYJ4uOqhWxw82V66/OCSx+XJaU73ZIoOiHrM51/KYx11ph+JL9g6m62PEHVMfcrjBTuD5pLbM58YZqZeM04JN4ds1rBt6B6Iu4jp765KQK9KCXfVkBE9oJWl7LKRm55dDdF7nbfyA/3R5t69eRobgHKwV5st3Zc2ahDcVXfKPYOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM4PR11MB6454.namprd11.prod.outlook.com (2603:10b6:8:b8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.26; Mon, 1 Jul 2024 16:27:51 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%6]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 16:27:51 +0000
Date: Mon, 1 Jul 2024 18:27:44 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <tirthendu.sarkar@intel.com>
Subject: Re: [PATCH bpf-next v2 1/2] selftests/xsk: Ensure traffic validation
 proceeds after ring size adjustment in xskxceiver
Message-ID: <ZoLZAD/KlgcsrNdy@boxer>
References: <20240627043548.221724-1-tushar.vyavahare@intel.com>
 <20240627043548.221724-2-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240627043548.221724-2-tushar.vyavahare@intel.com>
X-ClientProxiedBy: MI2P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::7) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM4PR11MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 9824aba2-b2e8-4572-3ab0-08dc99eac074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7tyNvvOAv4RMQ7ui4znsx/mGTshPos/kvG0I1Q5Qwsmz2prvDivreYIVHQuF?=
 =?us-ascii?Q?TowhxMFJhodeB2VpMUX/qfAQc+UsKROaHEM0yv3iN+pD9e0EvWIwswzK1OQ0?=
 =?us-ascii?Q?MPSvyPPAxsynFakKmlYYsa7mq+vRfX97R4JjPmh8LOwpzlcTS1RZr1zdXd5H?=
 =?us-ascii?Q?hR2I9jHz9q+vIPrQ+jaUvFVOkj/8IDG/xNDUB05591Xylroc7+Tgxj3ND+Fe?=
 =?us-ascii?Q?fNzbTkSTNJwps3G6XspybYLDpLSfbYCGL2fjMvczHMKdhBXKocnKGM1lKc5d?=
 =?us-ascii?Q?BChsdDJ+tTac/b6800ybdVMv0tdbS1s/gqMZcs/piGXzNNg6gTpt0eNkl/lv?=
 =?us-ascii?Q?wcMv7KVo0Cz3woBMgLJmymETIMXKqk1+n2ahNBkCPrjMMZzdIvPin2MhrV7b?=
 =?us-ascii?Q?jSy9bHEtn/DwUpPdoBKO3bMu6NEalgVoxmyAb+PobXj7A4/KP2hf1v1W48mr?=
 =?us-ascii?Q?BbqZMwrp9VGZPRcRX7iicLKz7m1IbG/n2Pq/Q7Jdeq1SbuVkaPx0KN1AFZxf?=
 =?us-ascii?Q?JzP4hrhvDkRdKWqDO3HGNiks7nt7NpetQFxIr27dwHcIT29u05nffYYolEOv?=
 =?us-ascii?Q?PAeMXZLIZqNJJWt0BHhrjm6oQiVFIgWiCpDcRt1A00pasn+aPBLUwupG2Iba?=
 =?us-ascii?Q?uCk/oky6yw0pAQmHFe2F95phtxluMmJa06NjelNZiwPO7KYzv79vNlpCbeGs?=
 =?us-ascii?Q?8+lEB68KcP/pVRVWW8dxeZZLM4LUinNam+0b+WR6Xzc0Qo2fD4hWGxs73Ung?=
 =?us-ascii?Q?yPQ/Yf34URSU1y6DaDjkN4MoSQuw8bR06JaRLsXXKCcOuWT3sfwlavIqeg5/?=
 =?us-ascii?Q?0ZTLmuzAT3k5JYRLrrjDNHzolHFI6niOIlyVNhaEzQF3OHblpn6tNerXMtni?=
 =?us-ascii?Q?QHQL/avr64KYm3hSTpLzmlc1e2lOjb6uViFLSRbA+dOE1dw1sVQpNv9QgY9x?=
 =?us-ascii?Q?inXxUANdSOySMH1iJ5MZjo1pWLeXiE+apYvlwOIbmSCZAUvyFmOCrDIcGJd3?=
 =?us-ascii?Q?fHnBFRS39XSP2mR7LZQVPrO1oUYcaeutEMe8iIlSt5xEzgv134J3vsCL7KzZ?=
 =?us-ascii?Q?BObLiXEmY5u4sSnsUloUGqG9wW4Z/2/gOpeU3OhcxR9I6BqyyAmVj0CQMahD?=
 =?us-ascii?Q?A79DeVLXOSjkz9u5YDIhdirLKMbc0NgIlXqKobWyMx890MY2HMQS9mSPkzJt?=
 =?us-ascii?Q?OPldDVnM6KQM+heOWMt1R99ztNw5Skh6Ed3NlMroOKJZ3UT8gXoXAxvn50gA?=
 =?us-ascii?Q?oh3IJDE65gxi4lnhJKdd529Ttt+s2ANPWEQckkgUyBNsagJ+VXCc5/PQdpu4?=
 =?us-ascii?Q?sHyGXVhE2T3pR86l6vPzKTFeYUqpymVQtoRd1ijzEy7fUQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JA4qmtMO+ZlUj5mqRUHIZg/QOnBQe2H47ZAt9d94zbBSOW+jnD7VDtVnkuYb?=
 =?us-ascii?Q?kfT3rRCNAAU1VQcWTINRJNa9+SHDyeMqJ6AdTRuuPzyUBTO2OjnejaR4/wWn?=
 =?us-ascii?Q?yc2GnNkCtvjKzIt2/ZZ/MSnkIxv/mwiQqTrxq4+MOPt0pA7AQSUI5xozwtr4?=
 =?us-ascii?Q?4W3MUJkn2ib23SrtsqPwd7MLJDe9hVQUbOia+qrAn8vRhx/EiJ2NgOMrparT?=
 =?us-ascii?Q?HmmV0Spk68vjKrxBOofC1P4/tv5S4iVIoip5qmRQNZHqKbDHTQm3/NJlx/+d?=
 =?us-ascii?Q?Jy8wV9nGLQRYzqt4x8cnoHG7eDmHGEOD+qXym0JyDyLTcWE3qkVFeYwHUMIT?=
 =?us-ascii?Q?4WsTat1Dj/Cse1ISpCQ/+qfMrTd3noUip7IGYp8De7h6f7m0UXhrWF7fCFEa?=
 =?us-ascii?Q?JE5rfoK7/ZF8/ZPz3WJ0VTT7i0ODeKCDW4dlORojBwUdYLbwbsARJYA9p2KW?=
 =?us-ascii?Q?WsFJqgX5VbAxNHEoiekl6CUIfAbHMB/8Jfz2rChsTFPLyrtcsVRXXINTXsPG?=
 =?us-ascii?Q?14/qNwSpbvMW86usKtajnuN5tGPOo2OtW95CLEIYTOs+s7n2yVbLEYwi55rg?=
 =?us-ascii?Q?1ZLRZ/JJMaVF/wG38Ejbg3TJNLRxwrUu+BEXbI5PBosHo8j/sv4IH3T4CUUD?=
 =?us-ascii?Q?pWGi3epUj+kkDPDn6HEqzZSsPmJ5SMZS5gD1mkgDE7H15bFKpzzu6ErssRdV?=
 =?us-ascii?Q?104ZEcsR6hsXVcBdQSmoMHRZ/nULgxDm9M8CWjANKakia5kesuLK2cSgbtTO?=
 =?us-ascii?Q?Ghy3hlUJaiepvtpFwvZSKsSUqWfGaqJ7SQr4Zn+fYKLqHbsQKwmT9z9wE6+Y?=
 =?us-ascii?Q?fzDNdFBd9X/vk8lqvY9R/WzS0Zue57qKUJFgOssXkhAJK4eZl3CGnXLzleSM?=
 =?us-ascii?Q?4g6wqHIZ7MnG/SJJowyeBoscbhDLdyDdWHGrmBXHTXznlaDSJaD/3pVEh4kV?=
 =?us-ascii?Q?cPArtJmvHo95etCzLOFYXyZh8EQBbJjZ6zwFGhrIkXWM0vjtVhVKLMS1Epwa?=
 =?us-ascii?Q?bUttiI+3IpZwOnSVcKJE91TMLYXiCB2muanLOa5m6V2K1fqBHdSHLR8o8Ywo?=
 =?us-ascii?Q?4TmX3pXjhUukXNRDU17up24EXhEu18zTZcYrrcHdP69xZ6P40PHeucrUXxuY?=
 =?us-ascii?Q?h6S0zUTcPl0FlCZhlzs+7NcjcHPleWkKrJI30U4haqAgyMmSSrG1Ng6vfw6H?=
 =?us-ascii?Q?l5EKmimLsy4vcJlO6clNeZ93KhgN4o4tyt4dGMVpXKZLKHIlv41aAMODj5uz?=
 =?us-ascii?Q?wk5MgkM8xBU5Qbg2zk2tkxUpxpjoMHxe8+Q5jtDqdiICovHaZWJitPHiDmeJ?=
 =?us-ascii?Q?okvQAuAwTmCURTr5RHgIeSK10qmTCEch/lH3Mf10H1sDGlxujkOf7/ZS2m4k?=
 =?us-ascii?Q?PvfZhMogwVMd1qd4ZJ+S9BILnD33T6D+V7Y8Yngh/vjIs11krVt6wdo9Yxax?=
 =?us-ascii?Q?HDU/+19kLklkwzqs1YKtFMRS9CL5rHOcpc6Rm3JYo04sSNgGoTzT75jrkU3E?=
 =?us-ascii?Q?/XK7XwIgHFkonuARJwjWuHcgLQfgP576XCIwFbk1OLX8dalqyDHsNiyOe5Fn?=
 =?us-ascii?Q?fotLlxfpbPMO/M4yoqlBY4VcqmqlnuccCfdYUuPyQ1YdVns68t6Nb+UlGPGs?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9824aba2-b2e8-4572-3ab0-08dc99eac074
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 16:27:51.1299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddhL56ZgoQrcMWdwvfBbT6F+q96SBy7FMR5obIVlJGuuOthICIRAfcbRh6yv1VaKvkS6DTvhaT4ViQi9WlUmbV26SPelUP/xHOn2/uKeazs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6454
X-OriginatorOrg: intel.com

On Thu, Jun 27, 2024 at 04:35:47AM +0000, Tushar Vyavahare wrote:
> Previously, HW_SW_MIN_RING_SIZE and HW_SW_MAX_RING_SIZE test cases were
> not validating Tx/Rx traffic at all due to early return after changing HW
> ring size in testapp_validate_traffic().
> 
> Fix the flow by checking return value of set_ring_size() and act upon it
> rather than terminating the test case there.
> 
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Nit: your SOB should go as last tag

> 
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index 2eac0895b0a1..088df53869e8 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -1899,11 +1899,15 @@ static int testapp_validate_traffic(struct test_spec *test)
>  	}
>  
>  	if (test->set_ring) {
> -		if (ifobj_tx->hw_ring_size_supp)
> -			return set_ring_size(ifobj_tx);
> -
> -	ksft_test_result_skip("Changing HW ring size not supported.\n");
> -	return TEST_SKIP;
> +		if (ifobj_tx->hw_ring_size_supp) {
> +			if (set_ring_size(ifobj_tx)) {
> +				ksft_test_result_skip("Failed to change HW ring size.\n");
> +				return TEST_FAILURE;
> +			}
> +		} else {
> +			ksft_test_result_skip("Changing HW ring size not supported.\n");
> +			return TEST_SKIP;
> +		}
>  	}
>  
>  	xsk_attach_xdp_progs(test, ifobj_rx, ifobj_tx);
> -- 
> 2.34.1
> 
> 

