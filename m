Return-Path: <bpf+bounces-64370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFB9B11E0A
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 14:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2509D584CF6
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 12:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11DD242D72;
	Fri, 25 Jul 2025 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+moJUT0"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC3D226173;
	Fri, 25 Jul 2025 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753444826; cv=fail; b=XFpK/irtTpwOQ7iPkCFf3EEj+Aael1E/ByYRFbU4yulzejyapoWglqT7tLSmTFdjsMs5Bwj8bIkg5qThqDK7nXseylEuJFWBhNbby5g3Zuhn9Qw49R99F3BdHLGMcMcYHqnS9W5CgxQgjKsxG2OSixOARJ6p7RiJXoT0t03tPr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753444826; c=relaxed/simple;
	bh=wOXTjU6bL0fOsZNdzYz54aTHaQZCZW4GKZ5ObJbIhIA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RlGoqv/sVSPmppK/qKTnCTAI5kWycbl3PVKNZdP7yIbH786CTgHBdtII6HhmRu6xbF6/gPWh6visSKCJ2QJko0wJeBMYY772DgOS0wuMunZ9x79HrzV0ESO6NRR8qcQlT5cramNYzyCwyijQlE+5tPMK89WU1URY3oz59j8KkWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g+moJUT0; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753444824; x=1784980824;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=wOXTjU6bL0fOsZNdzYz54aTHaQZCZW4GKZ5ObJbIhIA=;
  b=g+moJUT011fd/VtgF/LHEFcMX2tiolcpY9NW/5CKwJf21hZe9Gy7PS9T
   GCKr2Bubi0O4PvgWE+OzwoandclgJqpNdXosCU5vHwfE/TLxZxbIU44UX
   LLiSHzYZ5hNOD8RQj0G72tPp+9X8UxUPGEAvOp0KM05PcqRUxae9REaJT
   dYMWDH8BzeMnwotOhR31UQ6tYNSoofvFehIHXJRx81YRmjdtb6oUuuMNS
   IBOF6THDBix62a1R+rXNpYCht71sV+topMGRzisNNwgC4VFyibd5tp29w
   P5rMX9rK7g7fn41O2qG9jLGjl6gRfDmhQaPEolnHOd3idAWR/Vw+JQpjE
   g==;
X-CSE-ConnectionGUID: i0ItuoeTSWivhwAkbeX31A==
X-CSE-MsgGUID: 3Yt78kUgSb6uEYY6zRzBwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59431857"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="59431857"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 05:00:23 -0700
X-CSE-ConnectionGUID: 5sQmHcozT9iQ+OMI73ULmQ==
X-CSE-MsgGUID: /SdgLKTjQTiiylNMnkthIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="160470171"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 05:00:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 05:00:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 05:00:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 05:00:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7oq0LDXr5dJN2U1ASsJSAl/EvQ/15iwQ8vKHoKCIEh0ywTqtBvArbWdKnAVN8Fr3wY5qTb3VUbEEZzQjPS+rcPldzcptmZX3rweK73DSJPW8lh+2YFHQeoBR2pfkZVmBEfSi1ULzlTZ9kjz2JpFjvH2SaObAh+g3ZlOnHVSdYe33aBoXSJwfTcM4Vyd+9tdoiSw7C7UwEcQWi0YLiAeFwogmtFNxk+56/IYOJ8Z7xKhUT1HZ8dGIvkVu/Gpzvo0JHNd9P944jLobf5lUqFbnQGwxfca27yftxI8SZ0IkqgrXrkWzrJnHj1+apmkomqmzr2MhgBdMssngbF7eUrLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Plwbhp+3pNnKqddNwlyIYem1TkwvTa4a4r4EfAZg1zg=;
 b=uHYvQrZb9iNCbLJ4UUknZFc9fUSmdCF9CB5+Sb3Mn0nJ2x8fTpGIzI4waBjer9scwGkNzrFzUqJmf+h06MI3vCfonn+LNJW3hOMAY863QDcPoIoEdIRxkRJ5ZMSZ5HnF7DV3Ti+nci0oJemmdHbyP1n0kdzN3UXIk82YYwAda869dd9vGcpNG56cx1y/DqZDB2DN5/Di0uXg0jPOmVf4MlMot1xqhW4kBrTWk66g38b+jCLcObDlJsy0QP/CCLZT+Kc48qiT08AXZ12tODnpM7tA/IIvuXeMFH7UqvExTW8VvatmKvC873ob6KZL7B49k/HR29HjcloUCUaDItMiCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ5PPF64191BB3C.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::82f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 11:59:52 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%6]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 11:59:52 +0000
Date: Fri, 25 Jul 2025 13:59:45 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>, <sdf@fomichev.me>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Jason Xing
	<kernelxing@tencent.com>
Subject: Re: [PATCH net-next 5/5] ixgbe: xsk: add TX multi-buffer support
Message-ID: <aINxsWiORTv4t+fs@boxer>
References: <20250720091123.474-1-kerneljasonxing@gmail.com>
 <20250720091123.474-6-kerneljasonxing@gmail.com>
 <aINVrP8vrxIkxhZr@boxer>
 <CAL+tcoD0W2owb211ZAO7M3qWU=EFGx+S9O7GNKidj0+oowfpdw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoD0W2owb211ZAO7M3qWU=EFGx+S9O7GNKidj0+oowfpdw@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0077.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::15) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ5PPF64191BB3C:EE_
X-MS-Office365-Filtering-Correlation-Id: eaae7034-7cc6-4152-7933-08ddcb72c341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UjZkOEtVK25lTlJ6dU90ZUVNRzJJdi9XNCtxM2JtdzhoakkwelhJa2d1SWlp?=
 =?utf-8?B?SVAxMkJMSlRlN0VBcExDZHplc1BRRG5mb09wcllkTXFKVnJNcE1ZTmNXb2lR?=
 =?utf-8?B?Q0xGMXd6WEovaGdOMk5ReTJJRlZEUmtHOUl0anQxTVZOa0FRY3BZWS94L3A5?=
 =?utf-8?B?VjRrenRGNGpOZndqTzlFekNSSjFqTEUzYVFicHd5TFhSUFJxZWpnWVRZN29X?=
 =?utf-8?B?aGNkcXo1M2VZaVdSYU41eHRuMHc1VHlCcFBHTUxGRkZMQmQ5eXF6bjRVdTRM?=
 =?utf-8?B?Q1pTcUsrS3BCMkZMK1ZIb1ZhM25rUDA3VjNrYWFveFhOV3N2a2djZkViUFZp?=
 =?utf-8?B?WlF2RDh2UEVmRTFmZEVjN29STnNvR3pITHRzVy9QdUVEZmlqVnRTS3dHeHNQ?=
 =?utf-8?B?V01Lc3dPcUhIV3ZQd3pKbDFpZk53b2dTaDJDK1FSZkR1ZDQ2M3N6NTVtYUYz?=
 =?utf-8?B?VDUzNURrY2w4V2p0aXMxN0svei9rYW14cmFYVThQSEhvTGVKbDRqVFQ3OXBa?=
 =?utf-8?B?S2xYZEFhQmpoY21LUm0xK2xLV2xTcTBzbHhuQXBVYUZrYUsyV083V0hQdWNZ?=
 =?utf-8?B?N3BFMWpIaytxTHZWY0pQVGNJRHdUM24wRlRGbWhzd0tUS3lwaFF5ODEyd3Bh?=
 =?utf-8?B?SjlUNUlzVVNUQUNzengrejNsNDVLWTViMEdRREZma0xET0FFdE1nVkNDVW1W?=
 =?utf-8?B?NkFWdms5TDRPZmpzeERkVFVMV1grc2FQWFgwcXNpelA0d29qMDNzSEJYOVlP?=
 =?utf-8?B?VzhsbGdrdEVSZHg0TkFDNGtnRTJ0dUNwbzBPUU5mME9zV09yaEhWeHp5dnNZ?=
 =?utf-8?B?aUtKOVRpbnJRUmV1dU9sYUVybWk3R2d0S2VCQ2Y5WkROUzBKSnRReFJ5a0tK?=
 =?utf-8?B?VGhOSDA1ZzMreTlOb3BWMUpvcXZMakZxMzhBQUdZMkEzaHlLMlZEUlNDRWdo?=
 =?utf-8?B?eTVRS0pUS1Roczlyb3d1a0w5U05WbGVFSVl6M0tsUzRMeUxZTmJ2ZXZLT1NX?=
 =?utf-8?B?RENuQytGbE5SMWdtdEhMZ1E5d3NsU2IrUC9GMHY5WWwwOEFtQzJST1V1LytX?=
 =?utf-8?B?OGRodWRrTURBdG1wNUhZQ2dKWG9rMENTWFRobFRtQlY1b2N0dnFCOFcveWJR?=
 =?utf-8?B?VWFmQzIxc090QnhIWlBMMWJhZ1lHQVdaRHNiY1gvR0NHaEdvUTVWRkRlWXFx?=
 =?utf-8?B?aUkvSmE1aVo2NjFBaEthYkUySTdzbmE5YlpCcHJ4SHFRZFZERFQ4YXdqUW5J?=
 =?utf-8?B?cTY3cDh6d3c0MFZQSGZVU0hDUjlDNXNTR1lEaDY2UmQ2UHN5Qm1HeTMyNzNs?=
 =?utf-8?B?bXE5SzJyRVZGVHQyNlJacm03NHd6YXFpczBGTlpITkQ5RmdTK3lvbVBLWkUw?=
 =?utf-8?B?L3FJNFJhSVFXMGgrQmZpazk3bjRUMTdVTUZ3Q21USDhRN05XeEhkdjNRb3R0?=
 =?utf-8?B?dnE3WFNMR1NjSW9TZ0MzMG5QZ1Y0T2IxN2ZoakpBV2ZKaURjQzJPdmJ6QzBx?=
 =?utf-8?B?SE5GeXIvVzNKaU12M1lMYXhYczZqSVl4bmxzQlo1OFNPUFp0Tm1ISW5qVTVX?=
 =?utf-8?B?UlJZQnp2cUd6RFNjVVlnWWRiL3p6d0xqdEdGN3BnUUxoeGZucGJIZWNZZ1or?=
 =?utf-8?B?aDhFL1F4SFpMRy9xTTFMNks1U0JTNmFzZk54ZnJOWStUWDlKUmhHRlJlM3ZH?=
 =?utf-8?B?ejhWaDJNTTR2Q1diZkR6R2Z3bkVVbm93NWkrdjIwdWhPNnBkaDY1V1A3czJN?=
 =?utf-8?B?Mk00TG5Qc1JHRFZIR2tKVmxUM1RlQ2RQWVVjOEliWUFURUJ5S2h3NzArK0dk?=
 =?utf-8?B?aEN4eVVNR0FhQ2t1QytIanlIYTAyeHBqUFI5SlE4Rld5MHcyU3gxeWtISlQ0?=
 =?utf-8?B?WWJ6ZE9KT0lSNkdiRGhXcFA1Q051bjBoa0x1UjE1cE9nUnRtTVBGRFJQVHRG?=
 =?utf-8?Q?ZdTjvGrJ5mg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUVDZGtid3lFdVVCcC9HTmJtV3liR21JVUNvVDNhUUJ4WGdyVkthY2xwZEFC?=
 =?utf-8?B?bGNmbEQ1ZDVXNllNODVjdEhsUUdmbjJjbEFuUktVVFFQdUI4MzZYcXBQb1FH?=
 =?utf-8?B?TW1uYUVXY3lPNDA4S0tRUVVWTys3Z3RxaGthYzNUQWQwYW5OTTVBSW4xQk1j?=
 =?utf-8?B?aUp1SnFkMXh5ZDdTQkZZVHlIZ09mM2x4RzNZOUVpSmNMNGs2VlMyVGtmVTlV?=
 =?utf-8?B?UGFEVisyU1Jib2RZYTNTRWpRaTg5dUFtZ1NmYzBkeGtheWdDd3VGWWZPWXB1?=
 =?utf-8?B?YkVCNDhIbDdUZjJyWUc5aHRWcnNFMFdMYTk4M1FrT2dtYW5RaitHU1puemsr?=
 =?utf-8?B?cXVOSGdVNzNSQk42R3RkMUNkb3RDNldjbGdnUGMzZDdqeGNkTVQ1M2JUK1JK?=
 =?utf-8?B?akhKU0JuMXhsNVpKTFRST3FJeGJYOVdwSnJSZmNEcHVYUmtPaUNCU1FEN3JB?=
 =?utf-8?B?UmFSZmdxQTlGWFZWMS9GRkd4Rjc2b2Qxak5OREx6WGUzUDhEYUxmWEI2UXZl?=
 =?utf-8?B?MG5MS0d6djk4NEE5Yy9ZK2ZDVkZwZnJiUnFrKzIyVGlUdllHejNFbUlSUEhi?=
 =?utf-8?B?UVEvcmVFS051bGl5eWxJS3RjSzFZMStqbU5EUG5NTWt0OUtDMHVUTkhNVWJp?=
 =?utf-8?B?Q3dyeWJBN2NoSzdseUlaS2RiZU11b2xpQ216eXFaQzNmZ2hFRnhDRW5qczNL?=
 =?utf-8?B?cXljdFA1dGVPb3BvVkZkRVlTb0pabUc2VVBwL2lIcndKazBjVFJ4U2dWbFZu?=
 =?utf-8?B?ekZmZVhaa01JaHpwVkNnTE41bllQdTJMMFp2SWZQZ1hxYysyVUc3VmM2Z0dZ?=
 =?utf-8?B?bEdWQ1NyK1ZXR1RzN3IwRW1hMWwrNS9GNS94R2dZbmVxYmxyb0hBSHd0ZVdP?=
 =?utf-8?B?N29tNzNrRk5LTFppMHBhNGhFeStaY29TNG9lQkxUMW1uM1VqOXR3NVVaL0Vv?=
 =?utf-8?B?Titqak9Ib3pKMVo1SDIrTCtEVUt6UlczT01QUmN6cE9FRytIU1lqQi9WWHZn?=
 =?utf-8?B?Slg2VitrSDBWSGFTd3JwZlhORVRBOUZQZ0xrWVMzem9YUUtBM1VVTkcrcHZ5?=
 =?utf-8?B?a1NTSHBRWVdjNitPWlNYaUZJRjlIREd1Z2IxZGhweFo2Yk1hVmVVbk5EZUpL?=
 =?utf-8?B?LzRXRW0yNTJlTHA4Ty9WOElCbDNUTlFIVU1DNG5vTUhzeE82UnJNT3Q5Z0hE?=
 =?utf-8?B?VzVlTCt0WDZndGMxaUpnYTB3Z3h5enZVRWFvc3A1Mno4cFpzcEh1R3V4Y0JX?=
 =?utf-8?B?aENrSFNLZ0JjZEFmS3puM0J2alVVU1lTaDI0QUhheXU4ZWwwUElRcDZQczZu?=
 =?utf-8?B?aWxFOXdMTmVkeVQ3NDVVNVFjVk1yWHQwNFRnditmWXlLZ2F4M2Jla2xCR1pw?=
 =?utf-8?B?ckhIdU1SQW15aVhhQjJmc1NCZDZ0S3Jlc1pzdklTaW4xQmIyVS9HMnJUMno5?=
 =?utf-8?B?UEs4bUpVUzV5UFo1VG9DR1MyNjRDTEs0dnBtRmc5UXNkdEU2TUNKKy9FV3Nt?=
 =?utf-8?B?OElOd1pYeElxRUoxRUp3OGl2U0ZiTWVTZHRvcURMNVdCUm1kMlBwV0pZb2Vm?=
 =?utf-8?B?ZHFwYVVxZDhEYm5jdldnTmtHUkxDQzN3OGFId21UZGU5MnZBSkpYelUxQlZl?=
 =?utf-8?B?OWIvNlpPZjFnVFdaWmdZRDc3a3h5enZJSTBlTVVFd083QmRNUEl1TTVrYWF4?=
 =?utf-8?B?WFFoUFB0RGU4TWUyWEZRYk9iaUh5QyttSVZZVnV3NFMvQmVzdFhaV1hEODhD?=
 =?utf-8?B?b2ZTeTE5Y2lnMFNWTW56VFFkNlNZU2FnbDRnVW16L21LWnYwTnU4UXE4dW9s?=
 =?utf-8?B?aG5oS2lQajZlanJTcDBxU3ZRWHRTVi8yOGtBYzQxR0pxR0R5b1EvMmZJWkx1?=
 =?utf-8?B?T0hxTzlHRVJ2OU1JbFlxdVZCR2JZQkRMeWdnVExldXFYY2I3VU1ibFJucjUr?=
 =?utf-8?B?aVZNS2laQVc4TGxidkIxc0xqamFUQkZMdC93TVZ0cUw5QTY5eUQ5aUUwcjVp?=
 =?utf-8?B?RFJTWUt6L0gvS2xHOXVpVzFUeGl6OC9xUUdlSXA4YWFsYVNRQmw0MVlvcjJB?=
 =?utf-8?B?TUhzNisrU0pHQ2MrUStMbWpnK25Kam9RQTBGRjdWS1EwdTFaUndTckhETWdC?=
 =?utf-8?B?T3NucDNFcFRXdnJmTWQyakpBR3NhTlAyVU5UTDVSNmZXMHJVSlZZRklMdEVW?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eaae7034-7cc6-4152-7933-08ddcb72c341
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 11:59:52.0399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WdFy+bIbxcoMMfTzUfJHUz6hQKZLK4MTgVBP+j19FkeHLI65n3gNsEOgL/4HvVfSK+2JgLHsgb2kWNVhxsG7XX+Rb8Ne+9B01diHJUpwZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF64191BB3C
X-OriginatorOrg: intel.com

On Fri, Jul 25, 2025 at 06:09:09PM +0800, Jason Xing wrote:
> Hi Maciej,
> 
> On Fri, Jul 25, 2025 at 6:00 PM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Sun, Jul 20, 2025 at 05:11:23PM +0800, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Use the common interface to see if the desc is the end of packets. If
> > > so, set IXGBE_TXD_CMD_EOP bit instead of setting for all preceding
> > > descriptors. This is also how i40e driver did in commit a92b96c4ae10
> > > ("i40e: xsk: add TX multi-buffer support").
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 4 ++++
> > >  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 4 +++-
> > >  2 files changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > > index a59fd8f74b5e..c34737065f9e 100644
> > > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > > @@ -52,6 +52,8 @@
> > >  #include "ixgbe_txrx_common.h"
> > >  #include "devlink/devlink.h"
> > >
> > > +#define IXGBE_MAX_BUFFER_TXD 4
> > > +
> > >  char ixgbe_driver_name[] = "ixgbe";
> > >  static const char ixgbe_driver_string[] =
> > >                             "Intel(R) 10 Gigabit PCI Express Network Driver";
> > > @@ -11805,6 +11807,8 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> > >       netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> > >                              NETDEV_XDP_ACT_XSK_ZEROCOPY;
> > >
> > > +     netdev->xdp_zc_max_segs = IXGBE_MAX_BUFFER_TXD;
> >
> > Hi Jason,
> >
> > nack to this as you would allow fragmented frames on Rx side which is not
> > supported even with your patchset.
> 
> I'm not sure about this one, to be honest when I observed no
> performance impact with this patch. How could we support the idea of
> this patch, I wonder? Do we need to correspondingly adjust the
> hardware? Sorry that I wasn't able to find such information in the
> datasheet :(

setting xdp_zc_max_segs will cause xsk control path to allow multi-buffer
traffic for zero-copy driver. ixgbe_clean_rx_irq_zc() is not adjusted for
that.

> 
> >
> > Generally ixgbe needs some love, i have several patches in my backlog plus
> > I think Larysa will be focusing on this driver.
> 
> Though ixgbe is an old driver, we still have thousands of machines
> running with this driver. Looking forward to your patch then.

I am taking a note here and will try to raise the priority around ixgbe
work, thanks!

> 
> Thanks,
> Jason
> 
> >
> > please stick to enabling xsk batching on tx side.
> >
> > > +
> > >       /* MTU range: 68 - 9710 */
> > >       netdev->min_mtu = ETH_MIN_MTU;
> > >       netdev->max_mtu = IXGBE_MAX_JUMBO_FRAME_SIZE - (ETH_HLEN + ETH_FCS_LEN);
> > > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > > index 9fe2c4bf8bc5..3d9fa4f2403e 100644
> > > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > > @@ -424,7 +424,9 @@ static void ixgbe_xmit_pkt(struct ixgbe_ring *xdp_ring, struct xdp_desc *desc,
> > >       cmd_type = IXGBE_ADVTXD_DTYP_DATA |
> > >                  IXGBE_ADVTXD_DCMD_DEXT |
> > >                  IXGBE_ADVTXD_DCMD_IFCS;
> > > -     cmd_type |= desc[i].len | IXGBE_TXD_CMD_EOP;
> > > +     cmd_type |= desc[i].len;
> > > +     if (xsk_is_eop_desc(&desc[i]))
> > > +             cmd_type |= IXGBE_TXD_CMD_EOP;
> > >       tx_desc->read.cmd_type_len = cpu_to_le32(cmd_type);
> > >       tx_desc->read.olinfo_status =
> > >               cpu_to_le32(desc[i].len << IXGBE_ADVTXD_PAYLEN_SHIFT);
> > > --
> > > 2.41.3
> > >

