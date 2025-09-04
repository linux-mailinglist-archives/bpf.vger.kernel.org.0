Return-Path: <bpf+bounces-67461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F9EB44267
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 18:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5FB45A2B66
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 16:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35E12F3C21;
	Thu,  4 Sep 2025 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S7U1+hvE"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2DF2F1FD8;
	Thu,  4 Sep 2025 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002451; cv=fail; b=X5dbVAMugu0ro4SE3y8OlLDOAA+tvZyq94aq+Z7PvB243okAWz5ABFdlLhAYv5POm8UApf4sGHXrnoDW7e/K7hPuGVSvblmZPptXICxPs/bu894+J16tL2l3wi1/XsCiVu6nGpe3JQ5DEnqBCYk/BqdikaG+Wx4/pphZByVu0rY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002451; c=relaxed/simple;
	bh=+6ymLhvk2rFZgd+AjeyeOLZTMgjzU7YdAJ/90zydOUQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l/IzOqHIYcYkJZMp9gkkYFGGbEetztWlNSefI5V4QM7vZYORHr4zxMt+2Jgo2txBlDpuSfwLoguaQqvKjxXyRVPPA1G/cwPX9wN3VWlnTQK2alAm6fJNEBY1cOnCY8xzgcz8A2NqTg0n+dKyN0cJX75qSlwL3wFBWXaUvqdosvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S7U1+hvE; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757002450; x=1788538450;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+6ymLhvk2rFZgd+AjeyeOLZTMgjzU7YdAJ/90zydOUQ=;
  b=S7U1+hvEuOdghalN4Uhu0CKirw4GHT262/W0duNUtVYhLwueSSiZSUrj
   yWFXSnklxt4biqASmxBiq5q34ImmY9faH1kmu0dGgRNFAK+PG8D++xeVS
   +k6ucRYsQlbgHQEKQXavW6ayy0D9u1dnIvbT9U8gsbaBSC+cGf2+E6ecm
   rmU6VWbGYxCE+kHxNntfmR+yRr8KwaWimgCxcQaXLRtpd1cjFDmrlLYJ+
   WqFIX2n94aNZk/INsAGvra4nm3aHq08O2VIqm3KHFDmqpaCmNVQpZtBTB
   oYY8gVyKWETLvjv/FCQNfxjI9Q0K1co0m7wEUnlA2IpOI5CrqYMwPHzZ7
   A==;
X-CSE-ConnectionGUID: kWECJNTJRWSnQJB28PbQlw==
X-CSE-MsgGUID: 1vEFy/mPS0S/JYUSe0dAXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="69963289"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="69963289"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:14:09 -0700
X-CSE-ConnectionGUID: sZ8eW9N1QOiQnjV2wDMWaw==
X-CSE-MsgGUID: I/zb6ah9Si+GnccDbn58AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="202771659"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:14:09 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:14:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 09:14:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.54)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:14:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AT+7E1hbFkxxESfbEVy7R58XcTslcfSjkc5+ug/miK+6cZe/M1wNNt+zSkkJpEribbHyLHTN+RSSJg/AA/yRi5jzPrweLWOeC8fFpfh6mWV1qKi+3g4RVXydovmN3o4dwKxU5r16w7GLfMURPRPOj8F8Zz1WDObUcmBVtjDx4mMJKTP7QSn/ARc2leSCKacyWFSU1e3S/VhyBaQiEAm7pan3e/jCoQ+48z6FRa1kOzh1bXG7ZyfVjMEqFX7aPSdJ/LIynUn88s9Os1PDDhHlxQqQT6lLPUUClhtNJwBtX9Lldi25PT3E2HHnmLQl/jonO1y4TrqS3mt75E1r2qYfgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJ4IGAAAvUFEzAHcI2RD6VEib5Pv0tEbbKNqDa2cTCk=;
 b=WyRta0rge36HyTvzCUE+Qrkgh707bruV0dlrcWxtA9ujRby4l2BbdRG92xjMQ8Rbf3tGViPn9N8sz8qPG0PY3lduBPA0UV7XS3WeaQAahswHu60/uEJ9ArwuLgcJv2+PmzComNOAdAzeYPK4xzP/ItO0AYfLFoT3lA3DrQY2FwjQaO8jzPu3bXb/VEyyc/tOUD4d4b44aF6OTLV/pZucoy3oTBGCldsETA6Iu+ZXYiATxKufL7Uu16VtfATRyppJ1YQcMRoSUTKBmq2RxI5Lh0hwELab++yNH2k0haFgZHifGaK7gVo8rJdvxhfld1FK1GKdV+TRuKAbmQ2QkynVzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) by
 MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.19; Thu, 4 Sep 2025 16:14:03 +0000
Received: from DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425]) by DM4PR11MB6455.namprd11.prod.outlook.com
 ([fe80::304a:afb1:cd4:3425%6]) with mapi id 15.20.9009.013; Thu, 4 Sep 2025
 16:14:03 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 12/13] idpf: add support for
 .ndo_xdp_xmit()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 12/13] idpf: add support
 for .ndo_xdp_xmit()
Thread-Index: AQHcFqWGH6KpPyMvXkK5+FUxs68NerSDM3FwgAALl2A=
Date: Thu, 4 Sep 2025 16:14:03 +0000
Message-ID: <DM4PR11MB6455AEED6453CF3E0382BD699800A@DM4PR11MB6455.namprd11.prod.outlook.com>
References: <20250826155507.2138401-1-aleksander.lobakin@intel.com>
 <20250826155507.2138401-13-aleksander.lobakin@intel.com>
 <PH0PR11MB5013E23D4355463542468E3E9600A@PH0PR11MB5013.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5013E23D4355463542468E3E9600A@PH0PR11MB5013.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6455:EE_|MN0PR11MB6088:EE_
x-ms-office365-filtering-correlation-id: 584e354a-3f8b-40c6-90ad-08ddebce110f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?4fI/GL/uFHSjxQ8m41YiWEjWH4WuB0dYnhf/0uz0GewIS+6wMgqYpxiIhxGK?=
 =?us-ascii?Q?v8aezH+vIxbQi/sSqlwvmWg/Dw+1vpORYkeoNo4du9gm7tVA9Xi1sT8eKXTy?=
 =?us-ascii?Q?e5JzSW05OmAZEaNxjJe0cyyqC6nZv/KHUJikBm03i961MyYBwi7DgsvSSLbD?=
 =?us-ascii?Q?Nvql9cphnoCwqBtntz+zySTLFApeSYvukVV2zzSC55n7vbcI+73cmOsf6Rq+?=
 =?us-ascii?Q?F8aJIlDb8VB2c08SKppfh8RoVJZTl8JzaDCFJtKZDuVbqUTH37UBBx9rBqrt?=
 =?us-ascii?Q?xUWETMK96E5IW0JQfs83vTjgW/gYCPUc2LEKWekXH+Qrd8pYjOlgdM0ENkze?=
 =?us-ascii?Q?L+GkcQRZ2JfbyLbz/I+znNdP1mILAYS8FTuCQ3zAzQf+n3iT3veW8aA6CoFM?=
 =?us-ascii?Q?xjOYIDRGvCXgnZmyjIue90UANJdOjmV8IxFNtuSd6pEdkCSEd+DrT2raGKwO?=
 =?us-ascii?Q?ri1PLqmt8WT7eAZ7FL9ObWv/6TQsIhxxfHJBB1XXRLSR6Sra7v+wM/PsWDhD?=
 =?us-ascii?Q?10MgOqoiLdfZ1wcST/O/bkqoAkpB9+NHGFqkbJNXbngmHTTmzHEcD6hriwUH?=
 =?us-ascii?Q?HSZ5O5s7S9wlPZ5JXYeO3MpFkiulHIRcFjar3xzHBoxhNBr8+lxzotVHWcy+?=
 =?us-ascii?Q?64OFd9J/fwflZ17JHZeHMrEESTqFAEZRcQk330xNSEDcQ1DJziy6tAH8Hrw8?=
 =?us-ascii?Q?EwmNnr0bc9OECOTKDUw9lbf4ZR2JIITGg4BlmP0WgeYl0xRdliXPGsHBVKKN?=
 =?us-ascii?Q?PMmhLK7XtXBD5y5YCKkK32TpckXI9CR9e/0+y8+qzJK6SI4ZEefTKo8NrVN4?=
 =?us-ascii?Q?l4kFqirkIHng1H2X/g4UtmoxQk872EAmy7QKKkPlpnR+FP8fWfpDTEeNeNeR?=
 =?us-ascii?Q?iD3l5jOmE7Kx4zAs2fHkKb0b5AQuLZuGC0jc4ho21Fz9SGQK9DnRwJ/7DwJN?=
 =?us-ascii?Q?qRPm1uFlIwijCo7O2GXg3Rtj6IphTpakIr97Ealbbo27VLlnzVctpXXUUCNO?=
 =?us-ascii?Q?wY3GAyFY/ZsdReEa6H+igrUbkvT0aend07gp1FxBGvIh47RNviAPWXzMMQuL?=
 =?us-ascii?Q?FAx0kvQLG/7ROcl+VrxK0In9iP6ryPRWADtZ6NLod5pPYkSnEprOj6TXDIM3?=
 =?us-ascii?Q?kRDETcgVlatkONCX7KTxfVTxOnDoYTg4KEIZLuD30dEYo4X1Ej1QwD6HEFUB?=
 =?us-ascii?Q?mF0ydbCWXYGHAlNPrJvK65xDDe1ycGwtGibePj1tZU7a34d4JfHz8TaYAzZE?=
 =?us-ascii?Q?WpVJuoLGYTKyWI4EQwhx+UuCHajRnKPbYbpHXYpMGJMYyQH8BpK7ze7Syo33?=
 =?us-ascii?Q?qf9IOYhaYoDuJjxBgmuJ9Oes1jKwM4VM5mfOTiVYmd3ivKN/5R+HgtHqSp5r?=
 =?us-ascii?Q?JjNjd3wL4raM1JAi9+cqd2odNepL7c5Npc/JExtDgLXI/awGkgdHXPTDlmfW?=
 =?us-ascii?Q?zjPmJYfykcjaIFWiKRn0SzawJQGapIUBia/txPkdBTjOwvXOpxh9fA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/UfUH32VNBaBFpGHzKVawMkaDqwbMAuEW1J48Ll6BHwa4aUfhvCV75QQu55v?=
 =?us-ascii?Q?xqUYv6M36OJz16pv4zrAADF5GJuA1mpp/aixk8bgHEMUpSI0UIQlJJ8Ezxqm?=
 =?us-ascii?Q?4hl5ayafo5R6frzHNg3l+D5LUIfXKg8+y/KneregRolNloJF6BcB2C3alaFT?=
 =?us-ascii?Q?77qKKBWqBUjEUnJzbGALVvBks4xOcodynRmxrrltWoRaQttbGvcvD9XVfBmM?=
 =?us-ascii?Q?/RNYsPX/AIZFlO1iOfeTkFLyMF+h7KPcwDsZIXbrAj5jWTQV57segyE+5xtg?=
 =?us-ascii?Q?DbZfkwCZvYIyyAa+CsIyTxOqhYD6aFmPlO0Lx9biVw29uFTcp9soPp44rXPA?=
 =?us-ascii?Q?KZxh9Ye99j0al2NTtoauzNdpFdAbT6gidfVBx/+SJe6WplJuNfZl2TvIYmjd?=
 =?us-ascii?Q?B9GFVmehubie+WguqX8BKVYcNcRSvm+hy3HXXt9HTY/VtDi2VVTw070JCjl2?=
 =?us-ascii?Q?4L+TIqmojEiXYxGULxGYP6/9YtBWyLe8s7YFGmU7k0/jMcxwnDlaNPw7Zf07?=
 =?us-ascii?Q?QbIwd582Dkpzy5dqMwT17o4GD4ey2cTsXh6+9Jf6KekiUnZ/ahWKgJ1w4arn?=
 =?us-ascii?Q?ANzw0wms7dPV/jc6ArhbE8jrHEkUfUws1/cl8git1YwMHluo7HjKbCCok7bA?=
 =?us-ascii?Q?8t30aDZ82jQd7IwqeiQmBOPei/B6dWu3iIc4NV35mcEj6jF5dWbomGdHWKV/?=
 =?us-ascii?Q?I+aIiDNIXCaxtJhEtkOJdEJD/D+TF/iYNWkBAi4e3wOC1EOA1ZcWJWwcLkBH?=
 =?us-ascii?Q?Apz6gAq4ZDg9G503wXyBTHVRmIdijibJ8TAkAW/D8yCYIsoD1b44WVEEe7l9?=
 =?us-ascii?Q?TOl4Nx/Cm5NFR5G3idM1R0qUZJWb9TX82q0+cOeGACCPei9BbeQfz2BVh18n?=
 =?us-ascii?Q?ezglUTxd38vGmkIKx9g9BcSPg2UbUA+QrEUfn8n8djHytR2Bied09G/fO3I1?=
 =?us-ascii?Q?LdijKp9Qbm9aNELN7Ee0xUdJJtHqwKm7/zOQ2KTDNvVhB7Nt3T8XOpUoO2uY?=
 =?us-ascii?Q?Z23Tbbpv6m9winH4QgrfmeWieZNkJgHOTQWro4yYepKTFjcVK4w0pHhRDA2v?=
 =?us-ascii?Q?ymAhUgrSlYZeilW4zde9jyZdFibss9R2QOubGKQMml1fijFjvzVYsYBf1Kf+?=
 =?us-ascii?Q?dOJXwfnoJKhBROdPeZnVttWT0eR7FMXqsDFLfltIZel9KdDVrw9Lp+0Wo5mP?=
 =?us-ascii?Q?DVa/ojP2WSWASbvM0SisD3tUuIpxYiotjtzVU+Z0IeMbv+RHyI19JY3t7Jc2?=
 =?us-ascii?Q?XwIy1S60drGhvMQaqd2nGh1LkaAwE8GDw8BZ97jaaRyIFugtwNNVfV/tFNbz?=
 =?us-ascii?Q?KKKiLHXtYdYR+/JB24MWw26N2OS6mYEdfybRD3z7DVg/Chr8hOuQv4Nxr6xt?=
 =?us-ascii?Q?6O7Dp21W/PAh1jmplppBTR7TXXE/6Z5lCZphmt9JMcU30OLzSC9diSm3Mvei?=
 =?us-ascii?Q?x/O6szRCgKc28p7vPmx767dlSebaKlmuA2vckYqQDK34iTRHrKf024muwbGc?=
 =?us-ascii?Q?oEzDIbMKKwjeTAqELhp+7Grko6kc7BdPhDDno+OROjwfgdi5ktUfwgjsv3b1?=
 =?us-ascii?Q?/VpyRN0GwgoSh5dEz24=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 584e354a-3f8b-40c6-90ad-08ddebce110f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 16:14:03.8053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d28X8j7s3pLqTSiV+3Fvzpg9X/RRCixmSR5hHv1L0lw76te/2ErGkc0RQ9WaObG8xkZbuw8OXkVx6+i2gq3+iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Alexander Lobakin
> Sent: Tuesday, August 26, 2025 9:25 PM
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
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 12/13] idpf: add support fo=
r
> .ndo_xdp_xmit()
>=20
> Use libeth XDP infra to implement .ndo_xdp_xmit() in idpf.
> The Tx callbacks are reused from XDP_TX code. XDP redirect target feature=
 is
> set/cleared depending on the XDP prog presence, as for now we still don't
> allocate XDP Tx queues when there's no program.
>=20
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/xdp.h      |  2 ++
>  drivers/net/ethernet/intel/idpf/idpf_lib.c |  1 +
>  drivers/net/ethernet/intel/idpf/xdp.c      | 20 ++++++++++++++++++++
>  3 files changed, 23 insertions(+)
>
Tested-by: R,Ramu <ramu.r@intel.com>


