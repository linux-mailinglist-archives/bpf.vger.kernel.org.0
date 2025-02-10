Return-Path: <bpf+bounces-50986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 381DBA2EF46
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 15:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A351881962
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 14:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291992327AF;
	Mon, 10 Feb 2025 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6IhQ4N+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBB82327A3;
	Mon, 10 Feb 2025 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739196607; cv=fail; b=FirqevcmbTLQ4nq0QOv+Cgc5V6zWI2m3WYU1ZojyMqnod2gZ9e0WrqKfgd1UwHGZRr1IuxeDgBWUJvYW5HfUL7k52OwiZZYCJ4PZ64QgWCVa2WN0ATa9sLWR1TBQjIg8YL+7sWeiMLzYfRaoOBG0mBCj8AgVJ8LzQOu9Xm4ZTp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739196607; c=relaxed/simple;
	bh=TcLlsa7zdDLNXiXU5SUHbqNXqEOYMxwjmyplWFn80tg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r04Ri4YKDYvlDMPAEPBz8FR4CWkoT/TCkf62bwAjoBUKo4sTE+9fNQJFfzPm0QzBBM+v0jmOo9OQcPnGypT9M1dl9o5YDEoE3ClnMuqAgMlMGnmUvUqJd3EtJBteoEGX49oGiPZGuzSUsDBhndXRQmYr4VIJ1a7BNguI+vue2IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6IhQ4N+; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739196607; x=1770732607;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TcLlsa7zdDLNXiXU5SUHbqNXqEOYMxwjmyplWFn80tg=;
  b=e6IhQ4N+hNqRlWMf+Eqms69J8+3hXKNvR7uclMVA6MLJDEDyk6d1iAxW
   UBu0mpX2TnuhjtbHfkhqmuO1VzbjJbVPqzBMk23ejwMXIzvVksOaupDT5
   9K6Nw1tQJMm7boEWoSC1r0pinnyRLnOrbt3yQA6OodMKwvLyr/NCwuwCg
   3i6sGdjqspW2Dcf2Pfi+LKvZZegy0Qbhj/Z/tKJ4uBTwG+eQcNzSONZLY
   YJHKDqzl9uCz2Yf8DcuGNPYnPen/3v7xeVE9VO5x9elYYGlfBUBMjkJCH
   6372lUqDorsqSycAeyjGKVAjKM4pHJuLQ5N433MJtl74+oXQCci6JQ1U/
   Q==;
X-CSE-ConnectionGUID: 5vKxBWI6T2CNml2580elPQ==
X-CSE-MsgGUID: tLxb763eRiiCfuS+kKSmCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="42617541"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="42617541"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 06:10:05 -0800
X-CSE-ConnectionGUID: VvrJUcyiS4izriSCqxm6ag==
X-CSE-MsgGUID: TgFiEdSJQVK4SQsbUBuRww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="117265080"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Feb 2025 06:10:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 06:10:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 06:10:04 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 06:10:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lR77eJAvdcDD6pbKQJsjonFUMS7axVW1RzF9H0KIhq+3QqxFw0+viCpS45nIcdXWhcWIW1cyP+Kh8udd0CT/+kKl70QJC264Jeuwv8TpspPJy45F6runQxuWzMmM3d7KfgDUlB+dUlXN9kM6q1HoT8f8EgOQRB/57XK+DwQjJt65fVq+Qc4nnX/0THRya4JhqKsBu8iOrVS+YN2JgVj/Nn/5ijua4fA/KX6eVLpOeKpbQWFJFHZVQajCqvwZQN9Xmc6FEOv+k72iKaqgvnxBLLfn11rVzTk8JUIwiCtL0UnANcniOkKd6lOQnCvrFGRuGoTNqRRudPeSrQIJV9LWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcLlsa7zdDLNXiXU5SUHbqNXqEOYMxwjmyplWFn80tg=;
 b=s8bcbFwXYg72zT+hh45fZMae1wIq2Cdb8nOUDu1Qcy3pjkp2KWzhqMh42NXiVhgkR49bxBE51PbF8bfeEhYabj1/R3OsfhNh7Eyn10tj6UgBQ25lAB4BC+SwspBqmrLmjqinuvfolMejm+WuZY4q5d2hk+A+PnkMw/TpPMSEoj/ILtZ1ps6SdsWJaY1VGh81Du5xHQvKFrgWcPuwvEI10DCKjQtcxKyek2powq7zjaXOI+shi92hh3c4IChARj1F6w7gD9RjH6sNvRIhGxu8O7ZiUIvnDk9P3PoFjN0YeoouPM+5TBPeFSJ1T5UTOX5WYeeXM7zLN4jogDFUW/dF/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MN2PR11MB4760.namprd11.prod.outlook.com (2603:10b6:208:266::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 14:09:48 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 14:09:47 +0000
Message-ID: <79d05c4b-bcfb-4dd3-84d9-b44e64eb4e66@intel.com>
Date: Mon, 10 Feb 2025 15:05:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/8] bpf: cpumap: enable GRO for XDP_PASS
 frames
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250205163609.3208829-1-aleksander.lobakin@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250205163609.3208829-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0037.eurprd09.prod.outlook.com
 (2603:10a6:802:1::26) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MN2PR11MB4760:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eed9a15-9ed0-4734-33d0-08dd49dc939e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFdSdW5aVmhscUcrR3NjVHY3ZGhZUkxvcXltRU93Y1ZCMEFMZFNRZjRWWG1v?=
 =?utf-8?B?ZGRjZ2QxN3hpV0Q3OThXUGRNL1o4MmpuVnhCTktaM3BxTFV1SExwU2pGZThR?=
 =?utf-8?B?MFlkZEdISnRqTDVCR2dWd2JRYTBaNTdrYWRJL1NXN1RtaUdHSjRncGN1NDNp?=
 =?utf-8?B?QlZPSGZmVWpyL2FVbml3bXZlY3dxSTB4aVBHUXZqaU5Ga0EwYnhVRU9xVzlX?=
 =?utf-8?B?aEFQdW4xY1IwZzRYa1RqT09UN3JObGRaZlJTZ1gweW81VU16UXViSS9HMXA4?=
 =?utf-8?B?bGQxOGFmZ1RGMm1QMnZHOUxpQ1h4T2hMSnREVGVUMVdHUEZLOCtyK0o1YnI0?=
 =?utf-8?B?T3hGaUVsbVFqdGhzVEQ4V05IczhtUm9ka00zR0JiNTJnVmFkZzJ0cGdXbXZh?=
 =?utf-8?B?eXo5NG1tN0d2SEhWOFpWNEZKTm8xM29kdkhjK2ZYd2g2Y3dMUjRtY1JuMHJs?=
 =?utf-8?B?TWdLQUdwT1puOThFSlFISjRXV2krY0poc0hud2ozczRodVFXelgzc2Mxc1VT?=
 =?utf-8?B?UnhPa0NYd3dGamxxS0Vmd2RQMGFqU3ZnRWNrSWJjUjh5RUhJbFlvNmFDQ0Zu?=
 =?utf-8?B?V0g2cXhwbWRieFlEUzhKS01La2JXNUZic0tGbVQ1U08ydVI1SVRRSEgvKzFs?=
 =?utf-8?B?aEtMck5xYkVsUFhmWWliNVBpamxGam1yaDIvWC9qcHdSRktha255ZFRodkYv?=
 =?utf-8?B?OVQ3b3N2cHc3UldSdWFiVkxVWm5RWHZiY0llMHNTSSsrcFN2NEdhZzJuTU9T?=
 =?utf-8?B?bUprVHFtMXo1MFdKSDRDYnE4bk1JbHF3RFJiaDdHTFliUlFqZ0xXbDNYR2Rx?=
 =?utf-8?B?RXZLcWhzd1EyUEpnKzlUbFJoNzdpT1U1UFMvOXVLRzF0YVFqdW9qRUROemVx?=
 =?utf-8?B?UUNEUnlUc2Z1TzQ4UkpHaWVhNzJzd3lFK01zNXFBaGNwQU5iaWwweHdjVU5F?=
 =?utf-8?B?SzBtbC85a2JIY09kMUowNnBJaHoxS015NUVqUC8ySyszcDRnVkk0YW9vTHlD?=
 =?utf-8?B?S3gyMkxDQloxZmE4NHpTVmpDb0ZlUDJ3N3ozcWV0bUpBVXJQMzFFUDlLYTVX?=
 =?utf-8?B?bTZuM1F3Rkw0UCtvakdLR2FvaDBVK2RsZ2loRUY5RUJjRitIL1lVYzZoVjR1?=
 =?utf-8?B?QVkzT1BzZVV6Mm1NaUc4dzVyTks2UjVmZWhVWVdRbmNaL21HK3o1b0RPN21k?=
 =?utf-8?B?L1lLeXhhandNVTN2ZkxtYkdLa3hzamdBK3RaZkFjTDRBQmN5SXdHTit4aDJI?=
 =?utf-8?B?Skc0dTc1WWxHUWJ3VFFieUhLZmtBT1hEMjFodmdIQkNSa0VVemJvMWtoSHlL?=
 =?utf-8?B?Y0ptM2dwYkhsdU9EMXMrcldTdDN3dzdDemlNWW1taEtYeHRTbWVlaUlZVDBB?=
 =?utf-8?B?S1NEQ0l3R1oxbGVDZmRNRHd4SEk5bXlNUnZhVXJJMXBsdzRER2ZXc2lSKzBu?=
 =?utf-8?B?NENEUDgvTnZlMUx5cFQ0dlJDVGg1Y0tMbGU1ell0dFFmWEdkZFkxWnJ1dzg5?=
 =?utf-8?B?RFJjNFdXTEQxS3oxc0Q3RUVRaU0zT1d5eUNwNEdMaXgwK2k4b2dhamJuc292?=
 =?utf-8?B?RjlrK0t6NTR4S2R4T3NCU3k3d3d5b1JHVlBDeDl2bTZiK1JWQ2N6R3hoQ21s?=
 =?utf-8?B?OXJVVlYvOHp5ZnB0ZlRNTjkzZlJGYkVjbExScnBTTXJsUHcwMklSeGdJQk9s?=
 =?utf-8?B?ZmcrakQyUVNiMis0RDdMaDBiZnB4c0FPTDllK21PVzlvZ1QyWXE4clhlQytj?=
 =?utf-8?B?aU52aDJON2lEejVkZ1hhVDBOay9RbDA3NmxaNWZrZ0diVjVjMFlEbFZVLzNQ?=
 =?utf-8?B?Uy9ET3ZNdUxUdkgwTElnbk04UVBtcHozYm8yRzNOcUVMQk1wS3MzcTJsb1Mr?=
 =?utf-8?Q?5mqgiquKFgzyz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2ZZOG9hTGptdmxzQzFJa3ZRdGtLR3BpQmdiN0Z2cTZrMGdCUlFvZnVRVElh?=
 =?utf-8?B?TW42UXMxLzFHQmZQMVZyZEdFZ2NBVktQWlAySEExVmhrUWpNSFNlNEJxZ09E?=
 =?utf-8?B?anowK1VwbW41WHhRYVJPRzJtaWx1VFB2RXBQTERITkFWMHBoZkVKNUVjaVMw?=
 =?utf-8?B?RytFblZDZ0lsN0gxNWRvNkhKaHV3MDBzcVJyRzI4bWxoN3FIRzdkRUtQUHdl?=
 =?utf-8?B?MnArcjhiMkJkU29SRWJlak9xbFhIbTUvMXRDNHFLTm1JK2NXdlFhakMxdjlv?=
 =?utf-8?B?TkZrVi91NTRtQUJpTndwN0YrWDFCTTdlV1lPYzJIYkxlamdrVTJNajNLYnpK?=
 =?utf-8?B?cHo4NlBCU2lNT2U3L05JR1N0bTJYekZkNE1QdkcrMjJEVDh2TGdqeXkrbDFt?=
 =?utf-8?B?YmxiMEVnVzdKVFlmOC9TWWxBY0JheUEyWUE2eXFFNjFkZ0xBaUxOSFVXY3g1?=
 =?utf-8?B?QXNMVkNMOU5oR1dqYWlCRUtnRFNGSkNJRXpvOGJZL0JMeG9SOHRJYXJVODYy?=
 =?utf-8?B?bDdYY1FKbXo2R2c2SXgrdGlscHJaZGpKWE5tbEthdDl4T0c4NFBIY3hGNGVP?=
 =?utf-8?B?ZmwvVEhiVys3V2lGTFYrZCtHYnZ4MUtKb3djLzBBRU84SUhBa0ZLbFlJbGhH?=
 =?utf-8?B?TzE3dXYzdEQ0bGpnVVpqQ09xOHBxOUhPckREaFFScXhqSkNkWjVoVTdzRVFE?=
 =?utf-8?B?MWJvVFFZbFRKU2ZlQVpSKzR1aDc3Y2QreDd0UGRITzJibU9UR1dYM3BLVVhp?=
 =?utf-8?B?cU1lNXJMYmRpV0EySUNVOUh6Zkl1V3NIMUF0eDh5SnNTV2grVWRlV044Rk5R?=
 =?utf-8?B?d0xnek1DY3J6SHZJTjN4SGpPSzlhU0sxL3FLcU8yb0NBRktKajhhOFZ3WDhq?=
 =?utf-8?B?MnpFdnd1ZFN6dnBHZ3hMWjNFalUrank5aGtKRS9XQ0lueFRsclhSQ0V4L0Z3?=
 =?utf-8?B?ZzBaSHJLaHFDTXNuQUhuL3duMWtxZm5OM1dtS1ZZODdzT1ZNUkdzUDBJakhW?=
 =?utf-8?B?c09hVERwZ0RYK3BrbUpTbExPRGhrWGk3OW9Hc1dOMXU4V3FEMENnRG9kV1g2?=
 =?utf-8?B?MEtCckFvbURPNklCdmJxMzdJQXFyL1RYMUNkQkxxLzc2UWp5bEtnTXpkeGYz?=
 =?utf-8?B?RXBQcHNndW9TUWp0LzIzTWZZeXVXeVdtSHkyMmFmQk5tam12ZHhlWkUyaDVD?=
 =?utf-8?B?Vm9XWmtWWlRQaEF3VExsN2NoQ0Y2clNQMWZtZkRiL2JrOXkweUtveVVIWVA5?=
 =?utf-8?B?endFcnc4cHM5NXhlNHpzY3NJVVVMTDZFNXdjRFh3dzVZN0ZIL3hCRVByWjJX?=
 =?utf-8?B?cmFweWNMVmthckFtOCtkT1h6VURkaVhPalNNWjZweG94WWdsdEZPTjMraW1C?=
 =?utf-8?B?SXM4dVE4b0diaDNoT1hLaXdkcllVcmFPQ0F0V1Z1TlcvVWNQNTdJOXIxcHJs?=
 =?utf-8?B?dG94aWxSL3c3SjNqVHM1U2JuK1AvbzhsalBMcmM5YTM3YlpwUnIvMW82TUVO?=
 =?utf-8?B?eGxBck1idHdyOCtBRGo2S0EvRXNWR3hFdU1YblhDUGx3bHpwa0crYVgveXhV?=
 =?utf-8?B?K3dzM1FJSElSWlE3T3BTK2dieUdQYzQ3bUhmMGdOVWQ3RDYwVmREYWROSWt1?=
 =?utf-8?B?TUllWnBhcVh3dU5iV0Q1dFJsSWJUV1BBU09rNTM5c3lGdSsrNUtETjN4RlV0?=
 =?utf-8?B?SXBMTUE5Q1J1N0p4Rm1JRXg1MlpZM0JwR2J6UWs1NFJBMlpJRlF0eEdWcG9I?=
 =?utf-8?B?aTBvdy96YlI2YnpuY0Z2dEZnZzB4QnB4UUhqNitGVm9Zc2FyS3pOcFQzSHMz?=
 =?utf-8?B?eUxudThYejNYQzYxUWFqeVYxR1B2ZFpoNE1nSldGWFhZSWhEajdpQjdTd0tz?=
 =?utf-8?B?YUtXN0ViTGFrZUlOS2NJNmVHNVVtQkY5czJ0RFdWUTdrdXVjeGFCTE1Jc05t?=
 =?utf-8?B?MFlKYjU5djY4VUJqMmJ6UUI5ZklPb2FsNU9hT1JORGdLWU5oMzMxZ3luMUxO?=
 =?utf-8?B?Rk5mUGtiRXZrckVjb0JLNWpHVGJibnJCOE9UNXFMS0lzU2NnY3FYQ205K3Q3?=
 =?utf-8?B?cVBkZzhxUnJxT0wxbWV2L2ovS25RUm5DYWIvbWoyWG01Ly9rU2FuOUE4Y3ZJ?=
 =?utf-8?B?WnBZYkpIVzdHS1NCSk9uYTc2SGY0QjF5MXRFTGZvamR2SGdnVWJLajc5eHBw?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eed9a15-9ed0-4734-33d0-08dd49dc939e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 14:09:47.8000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mVcmwRxQOJkrOLepW5RBCNOstqxeeOQ8p68ue8XHL8ulzykQAcb0Xy8ZB3bztj4CeqrlnA3ffssuGooadyMxrjc50RSd+CilWMuYjV35aM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4760
X-OriginatorOrg: intel.com

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Wed, 5 Feb 2025 17:36:01 +0100

> Several months ago, I had been looking through my old XDP hints tree[0]
> to check whether some patches not directly related to hints can be sent
> standalone. Roughly at the same time, Daniel appeared and asked[1] about
> GRO for cpumap from that tree.

I see "Changes requested" on Patchwork. Which ones?

1/8 regarding gro_node? Nobody proposed a solution which would be as
efficient, but avoid using struct_group(), I don't see such as well.
I explain in the commitmsgs and cover letter everything. Jakub gave me
Acked-by on struct_group() in the v3 thread.

Thanks,
Olek

