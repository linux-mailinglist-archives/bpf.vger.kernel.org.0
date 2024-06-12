Return-Path: <bpf+bounces-31906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED111904ABB
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 07:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24881B2180F
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 05:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765C33716D;
	Wed, 12 Jun 2024 05:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZCdvUMtI"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5966F33FE;
	Wed, 12 Jun 2024 05:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718169624; cv=fail; b=gScpsE4RP6pGwIi84kpL2nPz78bm6jNH1QakYR71vikgM0PnOf/hl1O/HpIyCDZ4YLAXyT4dST3HyM8FH0uiVQsddeMCL0TXmCyzzWno5wNzqNdWSkhaWAnue3ltS07b7Y8apcfsOycj7M6NfeaQ7XFMe6gW3esz3H+jW5oAq+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718169624; c=relaxed/simple;
	bh=iv9Kj1fzC24RXptexZGLK0Ed5CdPL0LiJibOvy0ir/Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=MKdMxSqShQ9UWWbBLr7IUhcwRf/USoSirj/zR0Eo8QPJ9S44Gk0d5gBo/66gO8MRFsbuOFoy9kiR8LbuR7axfLtRx9mu1Ad9X0seUfq84dWM6HW+3j24inooAjTqNCWfmzbMcVn+4fdpnLhE5fhqSDdxjK4YVOmJjoXJqsgWmdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZCdvUMtI; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718169623; x=1749705623;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=iv9Kj1fzC24RXptexZGLK0Ed5CdPL0LiJibOvy0ir/Y=;
  b=ZCdvUMtIkBwwHjc+wpvDcbD7h+DZ2JsSoPNxlnzxHysXUFXdGT3vUBrK
   v0A+Dbw+RLkcVEayCrJcDDW9o/0GhRXoV74lHpGaSbC+cuVzZfaJSO1ia
   uFcwdi4i3P+a67zazMkF/yCVx6FUhcT9M2epvzcTd+znNTzHG6vU9T6Kq
   HOTVfInt3LSBlGgAisIfKOJz6xgcD1m4Y7wXsHIaAP09ldlBSDsucOCPM
   mK27wb3Sk7Udv4ynqbgN6ENtlZoqwz6BzhZ6/9nFRHmoaUKb8rybh4Zdd
   v34je2N0kM0n5yciSH3O9Q7U8vfkbekiNcHGyfuDOZoMyfTzye8LBKIEc
   Q==;
X-CSE-ConnectionGUID: DDia7NDUQJCw8DuOHEJz2w==
X-CSE-MsgGUID: MXYELb1XRQ6VnmWh/JOwbQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="15071110"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="15071110"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 22:20:21 -0700
X-CSE-ConnectionGUID: 3NzZWh5RTuitsXIgvboa1w==
X-CSE-MsgGUID: og/r4Sx0RvWHeBARHH760Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="40139596"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 22:20:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 22:20:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 22:20:19 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 22:20:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/3Nu41Nfr7xuv/ghJDKeyglbOsZ9DPGdoPlKNZOEz4jBFUsuLfjVIyyig9MbgjIaYDlXzHPKqHVkwOYY8y32RzNEZCwL+rQzBarQG2eIZg2uuFhWTWQ3khRm8Rq4+AP0oeEiElTBgZUnFRNzKjq8LABviJKPQPumfGlsOoYWv0/FAGM392lisCXG5mh/Y0BZD6YLn90F3QlzAuSC94f8P2m5ul/Sg8d0mwUG/8JfsYoBoBy83WM+lXATJ/A6U+uGYZD4tWmqikaH8JD6uYlKFB20Vt8tePYnNUkmIYIh7Np3vI9PNqSdVI35xwbE5uzbrSHHDIp8DiMRBnBJvq+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpWOgOhrv4BVJ2XvSszDXQylv4tvNnJjtcsgkkZdvHs=;
 b=brtOMXRkcDEfaGkS/CFUTH6CTg/F0etontuU2SFLdxysIJdSRGLfht/2CdW7Fe+jRhEt6MCgjZkpWLfUAfyqtiTHPiGqqXrTpoXhOCovFKCvBK/H51uRceg/frZprXyQLNHf4LFe/cYtPFO23heCr36lME0vGELexOHRHRkOrd/PIWXii+VvwCfsNy8yZwboeM3j3MJWKgwQ0dWQNTKzsD5Uky8p0XPErb/aHUMwhLPTpkh9Sp2MXRVtQBvK2cGT0WEi7a9vkdjahCdDmv0/ZtmKDGNE08PPsWzV6PEp9/hoUTUFQyqu/Ihk7fLRaRC446mPYVE5kBfUMCJqdg9zBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7193.namprd11.prod.outlook.com (2603:10b6:930:91::14)
 by SA1PR11MB8521.namprd11.prod.outlook.com (2603:10b6:806:3ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Wed, 12 Jun
 2024 05:20:17 +0000
Received: from CY8PR11MB7193.namprd11.prod.outlook.com
 ([fe80::e0e2:4fb7:11bf:efc5]) by CY8PR11MB7193.namprd11.prod.outlook.com
 ([fe80::e0e2:4fb7:11bf:efc5%4]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 05:20:17 +0000
Message-ID: <363ad8d1-a2d2-4fca-b66a-3d838eb5def9@intel.com>
Date: Wed, 12 Jun 2024 08:20:42 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: fix order of args in call to bpf_map_kvcalloc
To: <patchwork-bot+netdevbpf@kernel.org>, Mohammad Shehar Yaar Tausif
	<sheharyaar48@gmail.com>
CC: <martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20240516072411.42016-1-sheharyaar48@gmail.com>
 <171591542924.18753.7459839871800509964.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@intel.com>
In-Reply-To: <171591542924.18753.7459839871800509964.git-patchwork-notify@kernel.org>
X-ClientProxiedBy: DUZP191CA0021.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::25) To CY8PR11MB7193.namprd11.prod.outlook.com
 (2603:10b6:930:91::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7193:EE_|SA1PR11MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ae07c3-fa23-45ee-5810-08dc8a9f588e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|376006|7416006|366008;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T29JbncwY1VEK1dQbG93UmFDbHRiRTNpQXUvaGxLd0FablA5ZVJQSnhhN1Rq?=
 =?utf-8?B?WWFWTFdDTEtyekVWdmc2OU51VDE0dytPYk44bTVpWmh0dVpDd3VJbllYSCtq?=
 =?utf-8?B?ZnhBR3dnc2JOc3hsWS8xQ1lwV0N3d3VvS1lKSWVqMzVqRFFqekhpNVFaTkxj?=
 =?utf-8?B?VXIvY2VobEtxczFJZFlDcU5PekRuR3ZzMVR4aG5KTXVnRFNxUEszRjJvWnh4?=
 =?utf-8?B?TlVaWmRORlRQVEdaMDNQMi9Ga1N1Zy9LRklCM21hbWUwRGFHZ2tYMVhhdDQ4?=
 =?utf-8?B?WTI4eUxwSjVhZHpRRXlCVUY0U1hqd0hEVmhDcW40OEdOWFRiU2M4V0dxZmRq?=
 =?utf-8?B?VlpWYW9DR2huU25LbU1LQytpQjF0c3hJa1A2ak1GZ2psOExIeDg4NnFiMUF6?=
 =?utf-8?B?N20wZE55Si9oUFA3SUlLa0Y5RXJzQXVBOGsrVVFqc0J5LzZTRS9jUmFRUWJG?=
 =?utf-8?B?QzRHdEhhdGN6TlBqSjFUNmpoYjhUd3ZnL09acExNY3hpM2t1OFQ2cTVGU0Qz?=
 =?utf-8?B?eXFLN3ZrQmMxdFROcUVXNERac0QvVFB2bk53Q1JXK0ZoUWs0VDdzdGIzNHBp?=
 =?utf-8?B?ZVJkSnZ4UURmZ1FWTmJvZjVYVGZjNS85RUhuaGprY1BHblNpYnArWWV6bUdB?=
 =?utf-8?B?R2wya1gzWHpUTjRaMGRydVJQb1hPWWxKUjJFZ3FlR3pRL2dRUWM0ZUl4NlU5?=
 =?utf-8?B?QUw2VklVRjg1ME1yRmtqWjFkOE94RWoxU3k0dTdrcW1ZMmhkaG96ZGF3bGU3?=
 =?utf-8?B?MWJLQ1Izd21hTDVpWDVNMDZlUktobWFpdXBYUU10dDRvcG5zSXNqaUxHR2pH?=
 =?utf-8?B?cHlwUExSUVNWWGNGaXVsODhWYVlMWmptc01Zd1Rjd1FWVjV5NVVDd08zem9H?=
 =?utf-8?B?Z29aRUo5Wkx2QVdMYmdUYm5sQzg1bUZjR3hSVUlwZW1UTkpidldtenFaaEJF?=
 =?utf-8?B?UDhFT2dYWSsyQzJ6em5WSHVWRXZaa08wNTRXMW5tK28xVzlzY1JMYXlZQjQ0?=
 =?utf-8?B?OTRmZUVjYW5sTC90dTlxUUpyRENLSnBoUWEyMGhrYTYrdXNrZjBMUXIyRk4x?=
 =?utf-8?B?bDh1clZQaDZkNGlCT3cydWFLYkVPcWxUVmlva0tnN2hFSVR0ejF2SWp4Vy9o?=
 =?utf-8?B?L0NvSWRNRXBuWFFjZ0w0U2ZHSFhiRi8yOHhuM3hvOU9FeU9XaC9LS0hGOVlC?=
 =?utf-8?B?d0ZRcHpqMWZlazZGdzhQeFR3dndIRFgxbkJkZm9kR0hPQXZXblErM1hnT2d1?=
 =?utf-8?B?aWRyOHZTQ2pQeGsyVjlpaG1sYnpEblZWbjhmOUxHZjgzenFidVdSaThHaUlo?=
 =?utf-8?B?T3AzdURWcUNpa2tRME9IbEt3emkrYnp4N1h2WnNhRmpidzh5Ym0zZC9veHVp?=
 =?utf-8?B?NDk2UTNRMzdXZXprejFNK1d0SHVTc1J1Nml4TlZwd1JFQzlvRktZOWZLSDRp?=
 =?utf-8?B?Y0hXTjBHakVmVVF0WEJVbEp0cE1ockxySXJFNVU5d1pkb0JRT2VDNWF3U01S?=
 =?utf-8?B?ejRkSkNLWjRqNm5XaE16QnFvNXppZnIrRE5lZXhQbDhLQVpmV250QlJQOTBZ?=
 =?utf-8?B?NWV1NUxXOFJIa1pDNlh2dkdORGdONUVYcEVWQWN0eXVaSml4M3paZ3lqSFpZ?=
 =?utf-8?B?TXVnZGlWWkVHMXpLNXZLNTRaVDVwaVVIZjBHbW1KODdubDhPZXhYZUxpOHhk?=
 =?utf-8?B?dG9wUUN4Qnd3Yk5ONlJSZGxtVmFuMy9UT1I1dWdYazdqd1pMb2VLMWRZaDlo?=
 =?utf-8?Q?vgzDSGONGSfs2puGQJ/B71YMw6POqz9pPTZuCXs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7193.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(376006)(7416006)(366008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkZMbjh2WkluWnloRGZ2d2NxMi9KZTNCZzM0MTJhT3orMm0vMWZtdmNiNzl2?=
 =?utf-8?B?VVhCdWxKVFR5Yld3NGFnRW1WTmk0dlprL1pOVjJVY0JHRlM0WlE3RmlKTjhI?=
 =?utf-8?B?ZXI3b0ZTWHhjU0p2djlzR0llVXk4bVMwT3J5UFFTRkJ6c1pBNnZHd3N1bjMx?=
 =?utf-8?B?ZGIrbnRsQ1c4d2JiaWRCUGVpV1VidTA5OUMzMG1ueHBOVXNrTGVyRjNuSTJv?=
 =?utf-8?B?RHdpOVN1bXN5S2MxeUFTSHBBblFkWXZEeUJxUk1JT1kvT2pLY2k4TlFTU2VQ?=
 =?utf-8?B?VDdXdnQvYlc3TEY3Z0p2VVphRTRaMGFvamJJbURuSGZscE55WmlEZmJsRG9p?=
 =?utf-8?B?RDBRMVdDWmtDUFJWdGc0SENmaUw5Q1JGaUFvbno4VG9OMmJvajQ1SEJBRzlq?=
 =?utf-8?B?QWZXSzFDeFFVVlRpWjhoQVA2UWY3Z3JtTlVNZzVwSmZjQ2RpdkMvSjRHSnFw?=
 =?utf-8?B?MGQ3M3BlZUlrb3dTU1h6VlV5eFZiUFBLbXRwYnBONnprZ0RxOVZtM0JTYmsx?=
 =?utf-8?B?d3A3U2dGVWIyZFJlM3Zxa1hFRlBKbW9FYzNYUTJIKy9hY0M3QTV6OWNaZzhP?=
 =?utf-8?B?U0htbWVpTUhyelZqaUs3THRoUE9RSE1ONm8yMjlFaEhQV3Y5UkZ3VElVRjJw?=
 =?utf-8?B?c1k3MHI1Qk5OdU9kZDNIcjc1bzNoTjBXZ0FVbVJ1SW9yMFpGdGFydHhoQ3VS?=
 =?utf-8?B?VFdpYXlPczh1TXVpeUhkZ2diR1lFbitpcXFqTEtHTnFNYjNRMVgwVDJzeUI2?=
 =?utf-8?B?VlpuMmhSdWhJZzFNYVBrL0U3YzUzcTlZMVJxaWxta3RjVkRYbWtabjAxMjdo?=
 =?utf-8?B?MEVRZm9lM21xTnI3RU5rcHNZYWJLbnBLR1BKeTBvYVNHbkRQUlg1SkpBY0Zj?=
 =?utf-8?B?NE41N09sL3dneXJadzF4UWlZcEd6RFdnd29VTUpiaWhlb3c0ZzBoK1h2RTZJ?=
 =?utf-8?B?OEtGYXhGb0k3YUxLSjl6SWtiaHlsMFVka3l3Ymkxd2pyYnpsWGhzSTRtNUxj?=
 =?utf-8?B?c3pYVW9SS2k0cXlKdFFZNVYwajFneDNoNWV4aTR3TEtFUndKZXRLR09ucjMv?=
 =?utf-8?B?M1B4OStFRDFyRWticnpJQnpXSDAwMEtuUHRjTTdXNVF4Q0xGT1RCZHd0N0lM?=
 =?utf-8?B?NjM2TDlYVmFNckQrSXRjbTVLTjFBcHJPMGFjSTBIcTBQYnNjSTNOdzdmMkZn?=
 =?utf-8?B?ZkdyZTZpaDA4Q3R0bDBNcWY1Y2N0R05FWjl2bXk5ajZCZWFRL09EVXB1aTZq?=
 =?utf-8?B?M05pNUdJN0pla25ramU2bEpkRFV3N3ZvSlBRLzZ1cWltSU9PZUZwYlFOVmVm?=
 =?utf-8?B?WnRJekdBelBQclYzSVJudFZGQ2VCc1FTUXhJQ3Rxb3dseHV3bFlWdU8wdGgy?=
 =?utf-8?B?NkNsNnBIcmZ6T1VaOGlWUTN2ajFpQ2VlUEV6emQ5OTNVN3RTOTNlUlRJSmJI?=
 =?utf-8?B?UU51ejVKeVVDUDQrRUcxK1MxTDh1Qk1nNW95eUwzTUtQL0JXWTF5ZVRsOExl?=
 =?utf-8?B?dStBclg0WW5GQStja1ZTTDI2ZTRFNU54emtTdmxmNCtOT3JXWTVCUzdtVHdF?=
 =?utf-8?B?SS84WVA1MzZCSXcrYTVtcWhzZzJUWm9NSFp6bHZQd0ZkQmd3MExUZUp6TkJh?=
 =?utf-8?B?RlJWOTJXSXRsNkJvd0RhMEpJaW94S2c0a2c2dFpXZkNTblB6RCtqaUpvNHZQ?=
 =?utf-8?B?NUs3UUZrMEJDM0czdHBaMXQvZW5oWWhSai9BbkFMYWcwamQ0RHhYU1RtQlZI?=
 =?utf-8?B?dXRVbUM1bXZBRUlYa1RkZXo2eUFjQm5lZTN1WUZSalFyeHkzRUNybXpUYmRa?=
 =?utf-8?B?UXlKWFNoTzdUb01XNVVZV05pald4SG5GTGp5RUVGeTU1ZGJBK2VjMWwwd3Av?=
 =?utf-8?B?R09IN1hQcnhmNDNuZEUrWHV0UXJqa0FiZ2NKZmRCaitZWXNWTUR6ZFhGd0Qy?=
 =?utf-8?B?QlNvNFRCajVpSGlXQjVvbzVyYklUOXNmZE91VWY0RXo0c1NFRGs3R3c3OSta?=
 =?utf-8?B?VldIQ3FDZ28wd1h6N2FneXRsR01ndExoSXNKMS9ET0NGSVZvVmVsSVRFekt3?=
 =?utf-8?B?cUNaUDdpUFdteldmRklzSjQxQ3ZQdmIwb0pRU2Q4ekIzS3hIYWFOUjVEcjBa?=
 =?utf-8?B?OHhqaXNiaXkrWlJhR3ZmZ1JCbHV3U2dUL1pRY01GeGFQbDliWU1YUTJKcmJV?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ae07c3-fa23-45ee-5810-08dc8a9f588e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7193.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 05:20:17.1950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xPo2PmTF6Iu/EsCCxoPjpsONdsmqNGlHhS5N9pXf9gaIEAEqDT57Iln09fvy/NW+jZAYPZLzrPxfCK5svVZ/4rqWcZkLFbkcCz8rPKy/60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8521
X-OriginatorOrg: intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksCgpPbiAxNy8wNS8yMDI0IDA2OjEwLCBwYXRjaHdvcmstYm90K25ldGRldmJwZkBrZXJuZWwu
b3JnIHdyb3RlOgo+IEhlbGxvOgo+IAo+IFRoaXMgcGF0Y2ggd2FzIGFwcGxpZWQgdG8gYnBmL2Jw
Zi1uZXh0LmdpdCAobWFzdGVyKQoKQ2FuIHlvdSBzZW5kIHRoaXMgcGF0Y2ggZm9yIHRoZSBjdXJy
ZW50IDYuMTAgY3ljbGUgYXMgYSBmaXggYXMgd2VsbD8KCkhFQUQ6CjJlZjU5NzFmZjM0NSBNZXJn
ZSB0YWcgJ3Zmcy02LjEwLXJjNC5maXhlcycgb2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L3Zmcy92ZnMKCmhlYWQgLW4gNiBNYWtlZmlsZSAKIyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMApWRVJTSU9OID0gNgpQQVRDSExFVkVMID0gMTAKU1VC
TEVWRUwgPSAwCkVYVFJBVkVSU0lPTiA9IC1yYzMKTkFNRSA9IEJhYnkgT3Bvc3N1bSBQb3NzZQoK
Z2NjIC0tdmVyc2lvbgpnY2MgKEdDQykgMTQuMS4xIDIwMjQwNTIyCgprZXJuZWwvYnBmL2JwZl9s
b2NhbF9zdG9yYWdlLmM6IEluIGZ1bmN0aW9uIOKAmGJwZl9sb2NhbF9zdG9yYWdlX21hcF9hbGxv
Y+KAmToKa2VybmVsL2JwZi9icGZfbG9jYWxfc3RvcmFnZS5jOjc4NTo2MDogZXJyb3I6IOKAmGt2
bWFsbG9jX2FycmF5X25vZGVfbm9wcm9m4oCZIHNpemVzIHNwZWNpZmllZCB3aXRoIOKAmHNpemVv
ZuKAmSBpbiB0aGUgZWFybGllciBhcmd1bWVudCBhbmQgbm90IGluIHRoZSBsYXRlciBhcmd1bWVu
dCBbLVdlcnJvcj1jYWxsb2MtdHJhbnNwb3NlZC1hcmdzXQogIDc4NSB8ICAgICAgICAgc21hcC0+
YnVja2V0cyA9IGJwZl9tYXBfa3ZjYWxsb2MoJnNtYXAtPm1hcCwgc2l6ZW9mKCpzbWFwLT5idWNr
ZXRzKSwKClRoYW5rIHlvdSwKUMOpdGVyCgo+IGJ5IEFuZHJpaSBOYWtyeWlrbyA8YW5kcmlpQGtl
cm5lbC5vcmc+Ogo+IAo+IE9uIFRodSwgMTYgTWF5IDIwMjQgMTI6NTQ6MTEgKzA1MzAgeW91IHdy
b3RlOgo+PiBUaGUgb3JpZ2luYWwgZnVuY3Rpb24gY2FsbCBwYXNzZWQgc2l6ZSBvZiBzbWFwLT5i
dWNrZXQgYmVmb3JlIHRoZSBudW1iZXIgb2YKPj4gYnVja2V0cyB3aGljaCByYWlzZXMgdGhlIGVy
cm9yICdjYWxsb2MtdHJhbnNwb3NlZC1hcmdzJyBvbiBjb21waWxhdGlvbi4KPj4KPj4gU2lnbmVk
LW9mZi1ieTogTW9oYW1tYWQgU2hlaGFyIFlhYXIgVGF1c2lmIDxzaGVoYXJ5YWFyNDhAZ21haWwu
Y29tPgo+PiAtLS0KPj4gIGtlcm5lbC9icGYvYnBmX2xvY2FsX3N0b3JhZ2UuYyB8IDQgKystLQo+
PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBI
ZXJlIGlzIHRoZSBzdW1tYXJ5IHdpdGggbGlua3M6Cj4gICAtIGJwZjogZml4IG9yZGVyIG9mIGFy
Z3MgaW4gY2FsbCB0byBicGZfbWFwX2t2Y2FsbG9jCj4gICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvYnBmL2JwZi1uZXh0L2MvNzFlZDZjMjY2MzQ4Cj4gCj4gWW91IGFyZSBhd2Vzb21lLCB0aGFu
ayB5b3UhCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQpJbnRlbCBGaW5sYW5kIE95ClJlZ2lzdGVyZWQgQWRkcmVzczog
UEwgMjgxLCAwMDE4MSBIZWxzaW5raSAKQnVzaW5lc3MgSWRlbnRpdHkgQ29kZTogMDM1NzYwNiAt
IDQgCkRvbWljaWxlZCBpbiBIZWxzaW5raSAKClRoaXMgZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVu
dHMgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIG1hdGVyaWFsIGZvcgp0aGUgc29sZSB1c2Ugb2Yg
dGhlIGludGVuZGVkIHJlY2lwaWVudChzKS4gQW55IHJldmlldyBvciBkaXN0cmlidXRpb24KYnkg
b3RoZXJzIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRl
ZApyZWNpcGllbnQsIHBsZWFzZSBjb250YWN0IHRoZSBzZW5kZXIgYW5kIGRlbGV0ZSBhbGwgY29w
aWVzLgo=


