Return-Path: <bpf+bounces-42289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB4A9A20A9
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 13:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877D72883E1
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 11:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210A41DBB2C;
	Thu, 17 Oct 2024 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JWyuO3py"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEAD17DFEF;
	Thu, 17 Oct 2024 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729163198; cv=fail; b=PsGcbAvF6H6ozw58n1BwKq/Nc36+gt+9NZPu/Bn66IpFBIMfei44FoJnRQMHans5r8dq9H6QgNKPf9W4T8gn0erSsbVXERIGKvHhIWzadUM+oE0hOp3Qvd5KvW/HwxJqiAXkceMnWnZtwpPMoM7ijHFWUvXUWUK+4upDr8lbERc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729163198; c=relaxed/simple;
	bh=jj38LTO+goDUWwTpgNMXyNsCQ2tFnkDytMgA1QyB8uo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MURM1AOzZnZicMpxmue/MZJV7SzHqzTfFCoOZCenBHea5nkWzWNVCrzeH89XCtjm7zmV0tltfnFhushc/9qiKX5P59dxsnOGr20yFb+eg1uOjwu6yPIqVacsU+hq7SjuIlZ03rZZU5Sm9wtC3Y3+vSDS19jb5htI7Hi6CtF6vNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JWyuO3py; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729163196; x=1760699196;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jj38LTO+goDUWwTpgNMXyNsCQ2tFnkDytMgA1QyB8uo=;
  b=JWyuO3pyg7Y+ymQWBDdfdRagyZa0Ivt/fjuvfHRzjfb2Bttrs/US3zIf
   1lUQTuZ9vlwl4uJ2a5nUBUFloI7VhclwgWTLWVISPtmvgQH8ep3syeyKK
   AOpDMT5iBwfy4QTAAvdS2ceZdzFUM0nnRtl9xgfMqOKVzzxy0H5Vpgsxe
   5iQAQa8ikAgdVBgHFJh7BH8EXPoaKtqDR7ypDRM7ymKDKHNXFtyQBsSmd
   RLWZVjvhJqIvYtmVikm7azEybX2HvYkFh9qnWYFfebukDZixwxE25F/pJ
   mxFBD/uTXYcTeo++/scYF07UDBbWHJGbE66fjyn/CWV++nBG/mg6akcgz
   g==;
X-CSE-ConnectionGUID: yEu6qdvlSDWCCDPt1x52WQ==
X-CSE-MsgGUID: cqv/nCmHQ92fTbXZszAJkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="16261689"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="16261689"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 04:06:35 -0700
X-CSE-ConnectionGUID: JHBXVqcfTWWGRxbyMJsMXg==
X-CSE-MsgGUID: x+Z42jdGQ+2sPtWNivmQog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="78553827"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 04:06:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 04:06:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 04:06:34 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 04:06:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXJiT44etYeiLGWq7Zoe0CQAaeJXbvrIgyiiPZYzBRGurqd3wZ/7F7UDY/dLOt2CSXrPJSmJokRjaNlqY2bM82PToVQKCyv6gBATwqeKB3Xs6NqmJ6qo1CW/h7ahN9Dv2T8Wb6WQstz/+Vm6alItx+Uu/GBNjgvRDi4cFjh4Pt4tmd+kzhCwNGgjdGTKP+y1q8x4eN+7z6m/X/DZ7kVuo6/mdj8lineW0mRgg/tOEFXt9mcH8Ewt/sV7lwfJKwFzwbP9ZIA5GNByU+9BUyJ9zWmxBri0l7U5FmbyIvV5nVZitj2mLmqzy46OPI+bYXrVcgeQO3jABZZr+8Jwcsqyrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5i0wJJOlhzx81ednqT0pn3JCT43jOODsz4N27pTcILI=;
 b=ssmWJ4pzHJdJ6EQHwXyNyedIsraRFOI2nANh2UyHI61yCbTcdCjLpdk1ZJgFM8BEoOc/lg3R7MzFQrA+Kb0/qCKlMFmLpIVuZQhyW5IihfoMrlQOfUyrGnP3ck5MklfuQfKe+YrRqucENGVFk3JtQfUI7fff/GK9iHy8Q4hhgEK1jHcYpoHmafXH6Az5opZ/4SxnPY/BA9PyojvxvC8Qh1scqej/P2do2WmaPC72SuI6TrJHMcMldSBDIOXXu3a+w70+7iY5A9wwQ4tRCFgOV1c1FbiFayEZV/mqfkgTXCNie5BacIaOlhjRu7yDWxd7RCLi690BRJYdP66hlSbdtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB7557.namprd11.prod.outlook.com (2603:10b6:8:14d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.18; Thu, 17 Oct 2024 11:06:31 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 11:06:31 +0000
Date: Thu, 17 Oct 2024 13:06:25 +0200
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
Subject: Re: [PATCH net-next v2 01/18] jump_label: export
 static_key_slow_{inc,dec}_cpuslocked()
Message-ID: <ZxDvsSPbnY5iCsAY@boxer>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
 <20241015145350.4077765-2-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241015145350.4077765-2-aleksander.lobakin@intel.com>
X-ClientProxiedBy: WA1P291CA0003.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::6) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 723c1e48-0c2e-42e0-a977-08dcee9bc1b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TTszsOC+Kpu80DOZHwB1+k2UDBnXT+iAoCnLRrAxurUKfq+nMd2v2KUtNuEP?=
 =?us-ascii?Q?3M1BGeiTpBo+HI8gu2LOt9MLKPNWetJ5Z0B+o33jNHVuV311xwA9fqwDz7Mt?=
 =?us-ascii?Q?wJJfbBjyAmZLCKPD3qgVK+OEfzz9P2zkKHzfGuFCGiXcJDyFJAh1f+MeMX3D?=
 =?us-ascii?Q?XAV43+eEhhbbdDUKQb88YrPU2ucPr2EQZ5uWppNonErDBpUnbsl65S9DUJbo?=
 =?us-ascii?Q?bt3ZAX9JkwMPY581zKvm4+Bk1Di+m4xEVl0xt/kvZns2z0elA27plqcrOLiT?=
 =?us-ascii?Q?qDoqvng8zv8I8Csu9gViO+f1YCEtDi50KpdiNKmwxU7nZoFBptLEbW+3O2fn?=
 =?us-ascii?Q?ToWEQLiB8O1GJhAvJ9FKakCGDo3FNrebWZSXEFp0jdufSPHHEngXShKsXZZ2?=
 =?us-ascii?Q?iqXFtbR0gDPFH+aUa57NvaeshO+YD1mhMvamvVSBFBey8mCVlrRdwDodPOWG?=
 =?us-ascii?Q?bt5r4koSgE6C2526OFQBylwwAGnRNkFmq8VKuLyXuBzk8YYpddzfWLtWG6TB?=
 =?us-ascii?Q?KBJSCbmNdapBxahfpy4M6KZPaMnld4Oqc4AWDXPkLjRY1viiWxZ2RAiMTrsi?=
 =?us-ascii?Q?aVdS9keUZeLKXFuTgLCFdeNn6rP+ZyhVfcT0OBmIHNKAPiVXYidGy9S8IrJq?=
 =?us-ascii?Q?9P1+jekKaRhNReNvl1WhmFqCEB73rRuyzmk5A80NS/xYefm3lkBza18X5jux?=
 =?us-ascii?Q?G7SGvXZt9HWqRR2tXQeIhAEBlDK66rIekXCY64oLcVLeGIsXG169OfDoaM9N?=
 =?us-ascii?Q?w7DvVrVtB1VxhARzMEkgkeo0inHhwOEAn0cgifeAL3OOsKsi6VYVrAuvNr+u?=
 =?us-ascii?Q?Trt25LkBZaNFQXXrEnsOTiOWaJpQMCsC7Pet4RP/cUX6rzOhXavDZYK7AQXV?=
 =?us-ascii?Q?3nfYBIBx1AtLMwT15TgIGi6snBIXymizYparA7Nh0JYP7rBY4J/vcFo5RnKv?=
 =?us-ascii?Q?9JNZV8eomNL9sPMfrIxiq8gMaRcfHJ/6vQ6gYwKn1N0hWFMfymszxR9AyC6+?=
 =?us-ascii?Q?jKWoMwvvQL8q2oGujC9kQNyQdDx03rUc1XfDk/Bq6gcsw+TY+HXCaMTjJ9EZ?=
 =?us-ascii?Q?qTKS+Xei65yUsEIXdtwNa3yRr8XGD/F9ij8p71AT3uH+CUB5j0Ou/B/c+KB7?=
 =?us-ascii?Q?Ep7lmjxAxEaHcDW3++1DFAE4UrmDk8ok+JkMjzf/rAXhduMcxvxsKCtQJcJ6?=
 =?us-ascii?Q?xLKtpT7ffyBh8GgD/cGx0vYWLfSYwv0t5oBIJo36CIcwwJpCwv8nJDtraM+8?=
 =?us-ascii?Q?42Mg+tuhLelfie2bgZ3W3TrxFI39sCl5safuE28Av/cwPD5PZoJrCxuLoUdG?=
 =?us-ascii?Q?6WukupdPX/EoOPV6nTW716Yf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D/+G8tj13+8oDHlwW06XLEG+DXmfvxZENXiY2Nxkce0ReyjvIjJlvOf6Pv/O?=
 =?us-ascii?Q?g2wYNlL9AYwpkqd3Mnho/VHMWacx76+qjtFFvmPxKdZCnlKF6g7fp1LFxUe2?=
 =?us-ascii?Q?owzFcs7kwMNfWX7IlC8vCgzNHrio4//HUF/+J8tpjA2gh47SJi4xOkVWXtS7?=
 =?us-ascii?Q?z+ft+yeayPKUiQmsCY8waK4hIVeTmaGDzfkKZLqiW9wV3X3cQRdjv1uWkRuL?=
 =?us-ascii?Q?QXHlBArJHeYY+OpKS2+JY9hhENy53gdC9qNcTSP7Gw/wAvO9kEeWDDKsaCH+?=
 =?us-ascii?Q?8Hd1hwkYj9Y42snybOu00YpB8/Z4uHv2oAsNVDyUrqUizHqGVhIU+gNM8etU?=
 =?us-ascii?Q?X3Pe6xHynUjnGvr3imj3kLxuyvMSzcu3VvkJv7PfPM3OMhSuqLUbcGyuiGt/?=
 =?us-ascii?Q?fLCy9vK4uYjFokX26yIhhg+DyL1dmlC9KdQvAParMhJWirJz1snAL7PsaBZN?=
 =?us-ascii?Q?13g8/Z6oDVS2hIZp41cptf2aXlf6yekv34ymCE16ozSjwqE5Fn/PUBR4qvQ2?=
 =?us-ascii?Q?LIgPc6njKXDyxevKdCF3IGITEdTbfM9hsM1+gJu1kPc14bsUsPsAamEDvwGc?=
 =?us-ascii?Q?wQ3uBXsthFS/2vgaon4XlE1OFdxhPXpkvtUr2YZfnYCx4jEsMlZw3k2jHLP5?=
 =?us-ascii?Q?x6tqmPSHKGm92/Lkbq/3VjkbotRcqUJWImns3JLPQXa1MbhJTo4hIXry5vNf?=
 =?us-ascii?Q?fLcOB9tzY7dkyjtDV8ou4O4zcoiUzlrQBqa863Mb0b4Rv9GAdpDXoW3r0Gqg?=
 =?us-ascii?Q?ffMyhSKrQ9cSdHM1CrQzJCwxFHBWz6z+TJyrqPUUquAJTk5OGbLnmIqetQyw?=
 =?us-ascii?Q?X1GOHg9X4oXdSTEdNltp0HZ0RA68gOZ/MbzECpfMseEVkkN2q2kNldg+Gf5B?=
 =?us-ascii?Q?wC/SmR3sKhgaI1UwNLJPUA2JBOxtKNXNc48C+xR8s+0Ym6F2GDeg19e5A9Z4?=
 =?us-ascii?Q?n7y6W1cIV2YD303xZCJ12jfJUoa8E41b2v3y2USBTj6KX3UTqwXq0jQc+E/j?=
 =?us-ascii?Q?i4qs3dTH+KV8UljtYBMbKXBmXVfPWwNejW7DsK1TZHmWns4L/l+NpuruDRBc?=
 =?us-ascii?Q?mco9NQ5JP4nAgfKLth31shOnwGVSGNUp8D96b5WmC2vsXToqvzgAX57EtRXv?=
 =?us-ascii?Q?uSOO6RW54WmQKL5doSV1j60oYWYe9AZrIm+8aZIyez0TnpzST7z9zufKMXkL?=
 =?us-ascii?Q?BOjned6EOZsg1pA+wzZdUTFbRKjFc5V0h7pAZONAmHFbpNqk9HZjkzlPn9LB?=
 =?us-ascii?Q?r/MW2womgYHeelnCeGwW+epKdrWglWlIQldglLElR1nge1jcuufQGEnFYZEN?=
 =?us-ascii?Q?wIbCkSChjan6nVbfm5jR1tQlIf29Nh7ipa4Mhv4i92ZvR3iMtc/UfSw1XLO+?=
 =?us-ascii?Q?lHNgKnPkMemM2oTKiLV2JID6Br5lNcuM4tVhD9Sk+Ozavf9NFs6apwcFWSa2?=
 =?us-ascii?Q?c52WQok2Lb2KmIORXGuACZkBpgx7KXHOKas8FDF9zUX5c5l3na127ObZrj1c?=
 =?us-ascii?Q?CznjHBVK1WyinZDUkKuBVFG/w5A2+VC2KqFiFzb8qizD7Rcy3lgqoMlXFQvU?=
 =?us-ascii?Q?eUw57Y8F1UYHYeOr1virQO0wDb+6XuGB4VVwCawuEvt1Np4B/PyO87imcMan?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 723c1e48-0c2e-42e0-a977-08dcee9bc1b1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 11:06:31.7863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DBKKQCt/D1BVTZN7mtW2oJ1v+NdlOimghdx5XQYVaATHF7Z0AvHt0Eh77qP9BMFO7XzdRslczILkPgL5ef/jdkrRVsEvbL9BAtA+t0tjBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7557
X-OriginatorOrg: intel.com

On Tue, Oct 15, 2024 at 04:53:33PM +0200, Alexander Lobakin wrote:
> Sometimes, there's a need to modify a lot of static keys or modify the
> same key multiple times in a loop. In that case, it seems more optimal
> to lock cpu_read_lock once and then call _cpuslocked() variants.
> The enable/disable functions are already exported, the refcounted
> counterparts however are not. Fix that to allow modules to save some
> cycles.

Hi Olek,

can you explain how is this at all related to the patchset that it
contains? AFAIK I don't see it being used in later changes?

> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  kernel/jump_label.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index 93a822d3c468..1034c0348995 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -182,6 +182,7 @@ bool static_key_slow_inc_cpuslocked(struct static_key *key)
>  	}
>  	return true;
>  }
> +EXPORT_SYMBOL_GPL(static_key_slow_inc_cpuslocked);
>  
>  bool static_key_slow_inc(struct static_key *key)
>  {
> @@ -342,6 +343,7 @@ void static_key_slow_dec_cpuslocked(struct static_key *key)
>  	STATIC_KEY_CHECK_USE(key);
>  	__static_key_slow_dec_cpuslocked(key);
>  }
> +EXPORT_SYMBOL_GPL(static_key_slow_dec_cpuslocked);
>  
>  void __static_key_slow_dec_deferred(struct static_key *key,
>  				    struct delayed_work *work,
> -- 
> 2.46.2
> 

