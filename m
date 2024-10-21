Return-Path: <bpf+bounces-42646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FD19A6C02
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 16:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E491C21136
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 14:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D2D1F9416;
	Mon, 21 Oct 2024 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e2ctsFHI"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015FE1EF0A5;
	Mon, 21 Oct 2024 14:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520663; cv=fail; b=fD8TCV3ihXvmwXZD5xksbRnkAmClslQ/glUwaGOo+3cwJy1LbprAhQK3aBoI/uFnbXDrY2ub1sE818uKIdV+rrVXj37E6ihPA3PDHERJ3e2JajFpMaHh58wxbTXS+D/2CMAJH5pHaRPuWMdZ7YDULnLPOF/ZpMu5cH8E7smqFZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520663; c=relaxed/simple;
	bh=IK27REM9ekXIfqBzZ1Ptlh+TuuXuuThSFYcxlZ60lZ0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CwoHVY9tINuQY43EzlMPED2BlxPtqnsrWXcWKKRUkeNnsuzg7GkvFXFc/vhNSGKOZpQ8J0fZG9ImW9ICEVOgDr8tWC2URVaCW4NtCavP8GurrhKHy7+g5WofIAaCJwwM9LxECLOGqtMVN9N64C4dRU/Sn24KAvM7ZiqyaMTbg9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e2ctsFHI; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729520662; x=1761056662;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IK27REM9ekXIfqBzZ1Ptlh+TuuXuuThSFYcxlZ60lZ0=;
  b=e2ctsFHIyY0Q8shuF3hzbVQVWUdEWh0tmeBhmSvLVYMLLb0uxuFOCWQK
   tW0V4tGbk2sYfh/g3bNosxx9TDsY8tJQDPDcnrKvNxqW+i+4fJiXC6Y9i
   LtSdx9uLYzQo/5I2BGZ+vM/l6s1Frgara+O8lIzkYzfKv5U/N8awYuEfR
   5ywU2cAh99GcRUw6GPYygTtivHPKSiGqBr9qCco0wvnCVveEnD6cQRW9q
   dFUx820WyBoIAd8qPpDglHMmqBa50tYDDhJnkVtYgnt7OzE6YoT2BNdza
   htTKV9lVoOcMbsOJ7N1GdaMU7EyxDupVl7AUOrqkzxDWhY2iioRmR6l/4
   w==;
X-CSE-ConnectionGUID: a7/U0s+KQdKwnwhLgYuSFw==
X-CSE-MsgGUID: c8NfTuzVSl+GjXeBNvjkUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40132250"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40132250"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 07:24:21 -0700
X-CSE-ConnectionGUID: yDBhQ0ceQImN9HICvErItA==
X-CSE-MsgGUID: qNUDwt8wRdS1h3Mgz3mIIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79619962"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 07:24:20 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 07:24:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 07:24:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 07:24:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=leViUmPqFpBbcV9Ose14yA0/n0A6QEaokg4F2qc0Tu3Jp58NaKSH8vxvrZCEyDQz8J2fYRJ1xr4uitz2GNdL1sFUJ7uqfDH2l+X56sQapmHYQ227sgXzVr5KCpnh2kr1NEJHhxRKIS7EC8sKus/FMj9Z0S4EmhXEnMyPyCa7+sRAl2pSF0XesIcr9kU4v4MphTSp7iDpYNurwTFLEQCeV2cm0Zfo4yF5h/VoSABDMkX33FBDst6kr3pdrbZjUCLd2/BaQchXvoBqmv+pWMNGZjc6fMZA1A1yWz56zEyOhMj0ji6Dh1r+bWEgg3HV8kVwdHN3f2H9iNSWFcS0hCIfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLqy0trD2CySZavbRf237938yfsT4sCG21Sp4LVX2FI=;
 b=C8c764emcUhRYeqADHERWfjDTaoJu56gPgK0VTl5x/4QgIGFfJqOr+zFdYa+DP3s077pEE7Og0/afhzTShvb0cIKbEWfimlg9Keska762uvSK0m3TlxzyrFCty1j6C6b8DwWGQBZhppQwV5f4RIuKoOWQ6l00lmV2fsdYJZeMjEbJNPvzlr8busP+rmT6oBtnKPj1KqHjrmH8SB6lOuoLlobqlC6afClwz9JD/8/9gQwUoAQWCnJZGY8SRi5bcIdbb03AmzmLntd3vDhVwCVIW2MdDpJvDDJfLvw67q9UVpCqQ9GQ46lcrb8dnBi8ZQdocWDRm5WuDANrjiGsXoJ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA0PR11MB7258.namprd11.prod.outlook.com (2603:10b6:208:43d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 14:24:16 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 14:24:16 +0000
Message-ID: <516423c0-3be0-4ed4-9817-16ec276c16e6@intel.com>
Date: Mon, 21 Oct 2024 16:23:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 13/18] xsk: allow attaching XSk pool via
 xdp_rxq_info_reg_mem_model()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
 <20241015145350.4077765-14-aleksander.lobakin@intel.com>
 <ZxEH7/+6sSSTCHIK@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ZxEH7/+6sSSTCHIK@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB6PR0301CA0074.eurprd03.prod.outlook.com
 (2603:10a6:6:30::21) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA0PR11MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef568a8-b883-4804-30ac-08dcf1dc0ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVBGTXVrVHpqYTkvK09PY0RZU2xENVlXdFJQK1I1SWlqYTRlY2tlV0d2SlFP?=
 =?utf-8?B?c1Z5MDVHSTNDcy94bnBoZmFLalB5VTl0VEppOE5ydENiQ0ttd2JMamtiUGF2?=
 =?utf-8?B?U1pQRGtDWGxuUENYWU9taHJvNlU2ZUNrVlhOT3VIY2hpK1lJcE1HN0VVYXA2?=
 =?utf-8?B?T1FxbEtpdHN0amJRYW96VnhOVkp5YUx1Q3VWcitTK2FEWkt6WnJJbU00YUlC?=
 =?utf-8?B?bkp0NjJnODVHV0F1Y2lkdnJHWEc1VzQ0WU9La3dITU8wUTkxTVNUSlZmYVYy?=
 =?utf-8?B?SndYOE1VZ25UK3IwUmhUdmRnamp2U3ZnbEtWQmN5VGRvVHFNTHJxRFFaaXFM?=
 =?utf-8?B?Z3JCVWtwd0ZiTVYrSmpOeVhQUi9CYWR3L3Rvd0orU1B4M1FwUWJ3K2Via3hI?=
 =?utf-8?B?UjBEOVZDU3AxRlNBT3J6N3orSlExMlBiSzJjZmNLd1BHUEwzQ2F2RHVqVEtM?=
 =?utf-8?B?dkozQnVCSkRtWDlEcGNZdmowY3lGRlBXTTJkbkV1SFduSWpIeDc4bTltQXJ5?=
 =?utf-8?B?VnNhWVpCMUlUNnI3bUQzWXhuWDFwaHZMcldhdk1ENVpKMG5zVVFEcnZBR09p?=
 =?utf-8?B?S1g0elFhcmVkZEFDeHdmRS9BNjVPZkF2WmZ3QVdGK2s1Z2Y0L214dzJsWHFO?=
 =?utf-8?B?RE1ENlFyWXRVR1JqdmVhWGZ1dXNFdGozc0tlK1htQ1REckZscUdQaTFRZHoy?=
 =?utf-8?B?L1ZYQ3Yzc3c5SkdjV0pwSVFENXZhcnZncFIvMlhkRzhDRjQwNHQ1WmU3REMx?=
 =?utf-8?B?MkJUNmdVS0lHcFdjMFBOdWhQK0VPWHUxN3JrM1o0dE42cCt6bXRQRjQwREpJ?=
 =?utf-8?B?eWZGU2RSMGJTdmUrMzg5VVRBQXh5YmlDYmFzYVFOSWpUd2JPZFV2a2ZlTWFL?=
 =?utf-8?B?YVdzTGJmL3FHS2pNN0h4ZE96TWFvY20xUjV3b01CMXNpNVJBREdZazYvYjVl?=
 =?utf-8?B?cWtSb3F4RVpoOWxsMzdCL1ZMeHZzcTdzSzdhclpJNVRvd3RJSWl4d3BNaXd5?=
 =?utf-8?B?MEVCWGtJSWFNMGFpQVgwRG1nMWo0ZHQ5N3NWaDZLS3ZMVGFKYkVPc1p5cW5X?=
 =?utf-8?B?VkJnRWpJSDIvZjFwakNLQjR6b2I1OUVTTC96WnZ1aVIvcU92TXNVWGY2aGkw?=
 =?utf-8?B?N2VuTEgwWG5nczhLQVo1UkhCTUhVUlVTYUZvMFc2cEdQMHN4SEdBREw0Slph?=
 =?utf-8?B?dVdTZndrWUVFZEorOEtUMUF3RzNNUm96c210a3N4dUxUdjhTdklOcHQ0YzhX?=
 =?utf-8?B?YWtiaEZyS1lDcFI3UEZGUjVPRHJZYndZN1l3NXJ4MVkxYjYyQUtlMHpXVU9E?=
 =?utf-8?B?YUZ3ZDg5T0k0Y1VBaXZEQ2NRdzZTajlUWFpXNW5LdUlxd1hySTZWZEtLUkky?=
 =?utf-8?B?VUZtZWxwcEpmVmlQSGNyc2RTZmpUejcwTm1tb3htTUExKzUwNTJwRkROL3o1?=
 =?utf-8?B?elhMTWFxWEFheVpnZW9MVWhqdWUvUFJNMWtncFZ4MFJKNlRoNFhWRE5xRmx2?=
 =?utf-8?B?WFY0Qlk1ZVd0K3hDaUsxMC9DY2hiNUpmYXpJV05rcFFGejZuQnVmbG9idlRz?=
 =?utf-8?B?STNSNDNHVHVOa0FPR2hlbVZlNTJUYVVwNkdSQjBNbjhBTDEwZURGb045TWMz?=
 =?utf-8?B?d0dieWgwOW10b1c3TjFuT29SeU5vNkpFUkdpeThscCs1VFhoSzB1SlRpU0ll?=
 =?utf-8?B?dWUvZHJGQllmaUJvMHRZcDEzZXRQUG94ZFdrU3BFdXd5aVZJaTBjdUNHekE5?=
 =?utf-8?Q?8JfMB3KyHuHzRZXNjjczgSTc7BQlo9JBcsN2BBk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDBTS0FGa2k2clNvUms5SFE0UWlxanE2NEZnYkxJWTlNNHhqSWcxcFRTWjY0?=
 =?utf-8?B?TGVKWGQ3Qm5BOGFrUldzWFMxbjJjaWVoMWxJL1hrLy9yelMwMGtzcE9ldm1X?=
 =?utf-8?B?UTV6T1ZUWkVKVnlTSFZVV01MZ01xN2NabENoVlMzSWtRTWhTVkljMENJWVlU?=
 =?utf-8?B?bUJ3NDZtSWZnc1FhS0V6MGhvcXJnc2huMFZmZ3JhUjlKVXJjQ1BYR3pQZG9F?=
 =?utf-8?B?aENxbmkyaW55RmRTMW9KWEVWVG5nNFdDTkYwSjNRd0F3WDNwSVRzZkJTaUFh?=
 =?utf-8?B?a3J4Y0JvUnVmTFo1RnNiK3dBUVptSWszcTg1bEIyQTk2RktjMGVTbnkyMC92?=
 =?utf-8?B?TUIyKzQ3Q2NyZEsrZFVVbVUvK08rdGZQay9MSGt2cGNGalh4TXc3MzkwZ0Rp?=
 =?utf-8?B?M3ZCckNCejFrbEUxNEFCelNvdndqaE5yMDJpNmhCT2ZFVkFoL0tpUVVndjdh?=
 =?utf-8?B?QTg1aExpYkNPbW9IekRKa1p5RVdMdjZKcURqNEc1ME5xcjBzdzg0K0wyU0VB?=
 =?utf-8?B?b1dYUmVmN1QzYy84UDVyNEg0N3dTcjFBSnJ0cFNTL0R4d3BXWlBialJ1WnZ3?=
 =?utf-8?B?eEw2cTNXMnZ0Z1RlQ2FjbjBjT2J6dTE2bCt0UlpDd0tHV1RXdW85QktxWFdK?=
 =?utf-8?B?K0F4aXp0OTBoR3JPQVJ6Nk53d28zVnN4dnVCWGRCN2FFNWRXZENteEVablBu?=
 =?utf-8?B?VUpNV3VOOFZKdXUwME1uN2lTT3IrUkxqcXV1dzZtREJkVzJnWTJDMTdxdHQ3?=
 =?utf-8?B?b3IrTGlwV2Z4RzUzNlZuR2w0OHd1eFdWR0dkNGZzdTlRNHpnQ1RJT0ovVmZR?=
 =?utf-8?B?T3doRkRZNFIwOHFkSlZFWjFVS3AwVlc5NldNWVVTRG9mdWtSS0V5NUx4YkZJ?=
 =?utf-8?B?WlNFSEJpK2hLekFzaGNqcnVSTHd2cWYxTSswdjJyUHFlMmdTMW1wa2Vjc0Vp?=
 =?utf-8?B?aEtWNzVMQVdVTTRyK093ejd6dFpHWk9pUVhJd2grdVJkcWtEb0NlWmpDUGVI?=
 =?utf-8?B?MVBKRS9hemV4R3hMMVNVM25KWDYyRlpIMDMrb3cvREdyVEpDdEFNT1cydHZ5?=
 =?utf-8?B?c0s1SnJ0RWhKbnlwQ1RJL2VSNmtBL0Z3YlMraHRYRzNCVWs1bW9QTk5FNEI5?=
 =?utf-8?B?NnNtK0NxdDdUSytEMnBPalRaNytaSVVhbDNBSU1XNVN5eG9TcENCQU1pT2tu?=
 =?utf-8?B?OTNNTTNlWis3VHpMS2VpWW5taml6N2ZiUkJtbHdaNjFGUVo2NVUvZDg4M0Fh?=
 =?utf-8?B?U1FiVXh0d1lJVGo2VTJoVlQ3RDVzdGNsWkpMSFFLY0pFNWl2VkNjUk0vZDdW?=
 =?utf-8?B?bkpyc2NaNEVXcEh0RnY0VmhKUEVkV0lMNysxcyttVmY4V1pMclZTNllReitP?=
 =?utf-8?B?RTJvY2xrTHk4TE96N0c1YUdCclhqclY1d3JyRU1LN3h2eFo5eTJrVjlYVVNi?=
 =?utf-8?B?UlkzdmRnbWptZ1RBVWdBUEtqOFJQZnR3LzRiU2E3QlVycURUL2Z6RklxYmMr?=
 =?utf-8?B?N0ROWDA4MmFkaFNaZ1lwbThlazhHR3hQQVVnOWptYkpnS0dQUkVuL0h2ZG1o?=
 =?utf-8?B?ZDg1SXZsaWtpaEJWMGRWNzRxbG11MDBqQWJLTG1zcS82M0lhdkRYUlRwR0Vt?=
 =?utf-8?B?Ulk5L2wrdG5pb1FtamhETjZ3NS9UNnJGbmVMTFBHVDNOamtONmxNQWVueTdp?=
 =?utf-8?B?ancrWm1lbkpkb3NIQ0owOCs5Mmp5SUd3Y0h1amFUQjAya3VwZHUyK253RTEv?=
 =?utf-8?B?a0FWVVBRSGQxZmZHbGRvZ3drVUFVS2c4em84cGF1VTV4ajlpc3BJbXJ5ZWxV?=
 =?utf-8?B?YkMyWEF0RTdLeGRMZk82R3JUNWFiQXZUa3dReHBxekhlOFRKUWZ2bm9Kcm85?=
 =?utf-8?B?QURxOEJ6a2NXRnQ4K1VuckFzYU9LMlFRSDVtUC9XNXl0bjVYVzRvYmYzSUFT?=
 =?utf-8?B?ZkxvMTNQZkRNWW8rMjhwdk5sRWd1ZXNQRW9hYWZMOEI2SHI5aHIzQjBnMkpw?=
 =?utf-8?B?MVcyTk0xWTFlTHZRUzBZMG5qbWs3NXErMDN5UmdQZzIvSTFPakRvNmhSKzBu?=
 =?utf-8?B?VCtzNzFnRitXTXQzcEVYNDdiSzA5aTJrMHd1YnhGejFNOW5lWHUrbWxVT1h3?=
 =?utf-8?B?Q0NqUnV2M2lkSHJLWG9ORHN1Mm0rWFlZendmVGh4VzVFbUQ5b2dUT1VEOVZS?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef568a8-b883-4804-30ac-08dcf1dc0ae8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 14:24:16.0414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnugMXzgQAsW7+aWyzO6KWMittd6xpHiHLDIHSMAWjQ9t1l2EjsNIUr8Jm082KyS0eFMe/wNEhbi4MRfGU23quIZw3dEGKPHQOUVOKOrPXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7258
X-OriginatorOrg: intel.com

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu, 17 Oct 2024 14:49:51 +0200

> On Tue, Oct 15, 2024 at 04:53:45PM +0200, Alexander Lobakin wrote:
>> When you register an XSk pool as XDP Rxq info memory model, you then
>> need to manually attach it after the registration.
>> Let the user combine both actions into one by just passing a pointer
>> to the pool directly to xdp_rxq_info_reg_mem_model(), which will take
>> care of calling xsk_pool_set_rxq_info(). This looks similar to how a
>> &page_pool gets registered and reduce repeating driver code.
>>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> Makes sense, but why not address callsites in drivers while at it?
> Otherwise in case this would be merged this would be called twice. Not a
> big deal though.

You said yourself that this series is big enough already :D
This won't be called twice as here I call it only when
`allocator != NULL`, but all the callsites pass NULL when they
want to register an XSk pool. It's not NULL only in case of
Page Pool.

> 
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Thanks,
Olek

