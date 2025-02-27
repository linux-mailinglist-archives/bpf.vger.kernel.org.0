Return-Path: <bpf+bounces-52787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C26AA48806
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 19:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3FC168BCD
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 18:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4133A207A06;
	Thu, 27 Feb 2025 18:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fkjmx0i5"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B511B26B95D;
	Thu, 27 Feb 2025 18:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681705; cv=fail; b=tqXA8KDOxhnau1tbB3c8wfQ7jshDgspZwxqdji0dhOThnf16sqckMsnFhCaDqtU8EuJkOtfha+m9wfDwJUD2DuISdCn8VqauCZKhQKj0kL+xjH4PaHIc0k5qpjfhLcLwbpXE54gM/eCm9+lcFL8vICFJ4RjMbPKSl2RVk8bKo2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681705; c=relaxed/simple;
	bh=g7Uzs+lOBkE9lfeVvRFe7I6kRlSTyr/34XWM94lo6J4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rDFCVuSBIm1PCbI03ns3MeJahSKWIrudviqYpurrm0ajtr7OXk6mfamo4piC0SJyUAkYwuVNWQveCTXVLPIGDmtrZaC8gWaJs/JkFhySzJzpeV69tci98nouReLc7J1e3o6oUj4dey6L7dt0m0zOtxQyIMzV/4E+hHgkA9cROkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fkjmx0i5; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740681704; x=1772217704;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=g7Uzs+lOBkE9lfeVvRFe7I6kRlSTyr/34XWM94lo6J4=;
  b=Fkjmx0i5GwpxB4QOZMO0uPVTEP8Nq9TUTMdl8lgisBzeyhcqns9TdBJg
   yIajk65/XyFxj48A8iljTCvgWFvLG7zVUdrEH8xqZMbzmvF6hWXm85cXz
   HIiwkDNYNnU/xdgRNK57XQDwIDt6wxk+BXabMiuGHMzPkvVlvHZ1fgVwh
   5XHkQa3+glTElm+4fj9rmGHafKkBTSLj0gy4bRJM5X661hr9UJ0/h0ATW
   jLjNFN4nH4JMlEzCXaXVNIEB19soayJpxuhtXEvYGiUCBbqJwMfH9xOCo
   LrCHByb3VGeoGRwUf3VM2g7oTZZpbMae/q5KH267DwKtlFid0JozXTj4v
   w==;
X-CSE-ConnectionGUID: eKrIsla0T3yfI7EmLb1jvg==
X-CSE-MsgGUID: qp9YqophTyagntqx9wuz/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="52576424"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="52576424"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 10:41:41 -0800
X-CSE-ConnectionGUID: EewwpXHJT4+MyRlIYE4LPQ==
X-CSE-MsgGUID: V2jI6DqlS4qdihdMB2SwTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116978825"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 10:41:41 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 27 Feb 2025 10:41:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 27 Feb 2025 10:41:40 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 10:41:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E718tS7oZ8jtQjVdwbbzjWGklRq7SPoAc1WGaADianNs77wCkClzrcNy2EYHR0y8/199VRLDvixHyIel6L4KjfoOf3QlkS52wMDXrXiLZHbt70dxH0gJ1Ho+ysNlcmlkfSdbnwatjTHo0hiP7BbdeCunWY/enyhk5m52gIuMt2U/1lUZSIfiQP7vLObE/EXR1E4dQSDd3WZ4Ro76iMYmiC/hmHXiBBdYxyj4yrdWxtXr3J91LOpRAyrV4ob/1RualXNsWlBd22FFsyVuKBzZ7yguTfjfKz1F6pbZ/WAYqf6fLUyZqeefEBOkAgUCRo+b3jEdVquFq558Q216CBl9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqRZ5DGjA8yqANadDEqHHv/848jHvF95+NTu3k/B8SE=;
 b=y8ERevMF0U0dXZAXpByIaw/hm/D5mnaNHaUwdcVQI4EMKrQO80okSeoUOKk1yNMuwAYN4ExAfMDxA7SPdG9cjjMBTC2g6UHvN0X+erriX7PR7VLCohFPM8wfwqlL4auwEldVEQhU1iARlWGmAz83fATfJIDqtpWjOef4Bt9DBBjoNjINVL9WeDoATXxiz2Gh+AMEOrKTPqXrp1YsU6+NgXJqQKogLHZkcSznwZtyktVdpqXq23GiQrMMIKZOGpf8VUfIYKRwRE6eCwKaIUSpy/I/T/nV29KG6X1HVxM1RXjsPsafgC6lxObcKdLE7INnQEk/rv5i5zrcv18YtYaTtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 LV2PR11MB5997.namprd11.prod.outlook.com (2603:10b6:408:17f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 18:41:06 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8466.024; Thu, 27 Feb 2025
 18:41:06 +0000
Date: Thu, 27 Feb 2025 19:40:55 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, bpf <bpf@vger.kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>, Network Development
	<netdev@vger.kernel.org>, "Karlsson, Magnus" <magnus.karlsson@intel.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Amery Hung <ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next 0/3] bpf: introduce skb refcount kfuncs
Message-ID: <Z8Cxt+NrrO5L/AgP@boxer>
References: <20250220134503.835224-1-maciej.fijalkowski@intel.com>
 <CAADnVQKYkwV1jc3aLwWqzgP7TKaPvq_NjpwvYdOXOgDQ3QZfeA@mail.gmail.com>
 <Z73TS/tjk9okSqlC@boxer>
 <CAADnVQ++0o-YoFR=yUcbJvaLX2rmWjC2LHjc3yyCp+bkgWGn1Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ++0o-YoFR=yUcbJvaLX2rmWjC2LHjc3yyCp+bkgWGn1Q@mail.gmail.com>
X-ClientProxiedBy: WA1P291CA0012.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::9) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|LV2PR11MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: ead60025-329f-4fd0-5e1c-08dd575e4b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGozQjR5R2NyUjNRditGYmthd0dnS1VDNjgxU3p1VFU4Sm5XT3Azd3psUDE0?=
 =?utf-8?B?VlVxN3ZlcklMcGdRYnZQZGMyTEgyLzAyeEV6eTJiTUtobyttNUdqSWJCN3hG?=
 =?utf-8?B?QlFtd0Q0Q1ViK3BlYmRlVTFoZTNhdkpudVRMWnZxZjlicWdJTTBlUW1BQ0JR?=
 =?utf-8?B?SStOOGhERExFd1BiTHFVaklFSDhTWGI3S3EyN3lSaTAxM3Rpc0NwY2d0NVgx?=
 =?utf-8?B?QytDZVNLaEJGZFRBS0w5Q2RKTzUzaXRtajJGZWRHcVBMdFVSbW5TNW5nV3p4?=
 =?utf-8?B?ajRiR1M3aDdHVzhTRDdGc0tQcTEva0g0NlY4NU0rN2VUeWhmK2Z0T0VHeXMw?=
 =?utf-8?B?ZW0vVzlLQUpBYmJsSWlGMGVmeVRHOG1YVFZFbi9yZmFmRElSM1hhTjBoY1hV?=
 =?utf-8?B?eDlMS3NsckpySDlrL0wrcy9jb2g3Z21oNmd3N1F0Z3BvUWRVQ3QxeHJidmRV?=
 =?utf-8?B?d0JSeTgyUHBBUHN6UGZDd1d4ZlJUbXVNV0Q3R24vUDhNUHRjR2NTTkdFOVRV?=
 =?utf-8?B?KzBEZE5JTUFRRVNhWlhCRkxQS09KRHBnb3lNbXpQWHkyRHpVNDUvSmRnNHhT?=
 =?utf-8?B?V0t4SDBzL25kaGx1V0s3bis3bUpucE5sUTZGUzY4NjRjNFVOSFdYZGxqY1hU?=
 =?utf-8?B?Nk9aTXFvSitxMnY0cVZDV1c0QlVjNE5TcHNWWFhlOGYzQmFmUHk2NXFZWWhi?=
 =?utf-8?B?amMyMlltQURvcnFQcThHaUVHQmhBZVdTRmdRN1BoSTZHMDZlcnFvRUN6V3dG?=
 =?utf-8?B?MVhBK01CV09YZHF5YXlReWFnYlZtb3g3ZUVoL2JxaUhJMGFLZmpFbEVQNjJt?=
 =?utf-8?B?Ymp2VXRrN3pVZXkzSnVIUXpuNDArblliS2VPcXVEaFh6c2l1NUFrVHZZSGJy?=
 =?utf-8?B?MDlueElrQll0c3lYcHJpZmdjdjFpY1NWV2xOVk0zdjNHa25aSnZZeWM5Q3RO?=
 =?utf-8?B?SWlscnZTbFZLTzFUN2JRMFdJUDV0L0g3KzFmd05rQkl0dDg0UzU4WENtYkIw?=
 =?utf-8?B?L2Vsa1c5b3A3VGhsSDdnaVhGZnU0RlhjMjRCRm5OdldIREhSQU04dnhxdExJ?=
 =?utf-8?B?bmFRYXdhYTRucU80NVlCclcwbVVaY0g4aFJEaGkycFBxRld6Z1BZMkt2WUF1?=
 =?utf-8?B?eXQvYlZ6OUQ2Um5pekFUb044MHZXT2g0WkhNODJGZWhYbUM5OUJuNTRkQ3FP?=
 =?utf-8?B?Q3YyL2p3S1g3KzZIbkhrS1hNZ2dOT0lmZ0xwODlVOUkreVFyV2xaYlRkV01u?=
 =?utf-8?B?RVNDVThubytnaDhVbU9iOE1FMmJDOEN6OHdsczA5WUVRVGNBRExpZU92ZEVz?=
 =?utf-8?B?Qks3Zjlib0lmV3crUHhhOHZtU2xKMGt2dm1ZSlNnbUIrZFMweHNHTUdwOWNM?=
 =?utf-8?B?ejNCWURPbVppWHp5TVpsa1RDTkpsdUZSTzZxeW9Ub3hVZVNjUzhqZEszb2FD?=
 =?utf-8?B?VExCdGxRL2x5emF1RmdrOEpJWFZpY3JXNnJ4d3VVVG5iRGJEKy8vZ0JIY0Vw?=
 =?utf-8?B?NmtyUWVXT3JVTVpWdmRNUTZuZ3RjN01FbGJZRkNFWS9UREp6QXp6ckRScW1q?=
 =?utf-8?B?dTJzZ3lKZmtRdVNieFZLSVpYUytxUzI3YU9PRnhwZld6K3ZzbDUvUitLYm9O?=
 =?utf-8?B?ejJRbFNzUUF2SDk2ajNidGpTczJHaHpvRW5DczFUUmdJYTVDc29hM2JyUGM3?=
 =?utf-8?B?UGlkVEtDRTdWN1VmWFRlK28wRWo4ZzFUU1FwVURZZnYzY21xaDh5N3UrY2JI?=
 =?utf-8?B?MjdrUG4wZWlTZUUxem16ZzB5bVBPeXVjZHZ6WUhTYkorVjRIRHFOZnFlMUFp?=
 =?utf-8?B?NEhhWk1rREhRNExKdGtpZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFM1b3l5Qk9icWNBa0Vpa1NPQTVmUzFUZkRpUWFPYVA4UFI2WUdCM0c0WFBr?=
 =?utf-8?B?Mk9CV3p1UFZlMHlxMVdRQnNWUVMyZHZNa21rKzVKbEdrVmRGOElJUUJEcnBU?=
 =?utf-8?B?Uzh0SjRrVGk4eitJeUh2UXlVQ0xZSU9RNndGcmZqeXRpQ0I2TkZBdUw4dzR6?=
 =?utf-8?B?QTNSMVJZV2EzNHdrZ3llR1JrK05vY3p6VlNXTmliZlVjMUFUNnRXejVuNjdK?=
 =?utf-8?B?MFVnYVJVbXVSMDF6bGR5Z2ZaZlpCVFc2TmlDRDZJeUQ0Y1RTNFAycCtLOXRL?=
 =?utf-8?B?Ry95NHlMdnBLcFF1azhBUW5LdGRrN0hxbklWSmxwQlZPT0ZGV3djWWllR0J6?=
 =?utf-8?B?UXpVWDkzaXoxcjF4b0xka2V5Wk9sVERvNlAranZpYUY3YkFXNnRaMWxnUUFT?=
 =?utf-8?B?Tlhyd0ZsUnErZWNPRlA3WFNibjZDL3V4N1RrTTh0QTlYY1hGRGVLVmR6Ry9O?=
 =?utf-8?B?akVJM2tPT2ZveXNJcFdYUW1KRlVBNWFkQ0d0RGc5ZUVLc09BN2RGN21tRHR4?=
 =?utf-8?B?SmZvQkk0OTFGRzQrMGU2b3dDZ3c0cS9nSXhYYVVabXIwWHFhQVFmTW9tdTMz?=
 =?utf-8?B?N3FrL203MDdRTlMvY3o1U3k2NWJGNmFqdzlrbGg4MU1hK0J1UmdKN0pwNllm?=
 =?utf-8?B?TkE4QlFTSG90dzJOelc2dmM1b1ZaTTArT3I4QWpRU3dqMzV6WElBZit4V3Ex?=
 =?utf-8?B?cnVkby91MDRQeVJPUldYRUdoMHVlRlNyTUpteTBoL0g3WEFyYjlpc2czVG8w?=
 =?utf-8?B?RWtnRVJhY2JOMlRlSlBDa0xNdVRhaUYrdXYwc0dEcmU0SlB0SkRDTzBOWVB2?=
 =?utf-8?B?MmhUS1ZwaHE5MW80REEzL0NwczNXRUZWbFc3QnFpeG80bUJSM3ZTTUhma2x5?=
 =?utf-8?B?TGU0WURFdi9SZHN6VmlkUXF0ZkNKRkhicU03TzVtdjhHdzlkQVk5d1pZdkRs?=
 =?utf-8?B?VmN4TjVYK09uTjQxdFRXcG9qNENnc2h3Z09HNDJRV2xEKzZHcUxzWXNoZ0FW?=
 =?utf-8?B?R3hwekZLd2J3VE1sR2V2ZnlyWGF2V2NoNXFwZ2s4cEhpVGUvZ0l0RnhlWjk1?=
 =?utf-8?B?R2xsYktHMWNrSFBSTXdhejh4QkpISFEvSmxkZlpLM2pkNVFHSlNEL1pXVEUv?=
 =?utf-8?B?RURKZGxIN2FFc3JzMTNTYVhtdTMrUjlXSjR0Si9USDFjazlTaStJU3lIUnZE?=
 =?utf-8?B?NFNFclBQTUl4cGZieHVQRW1Wckltck5yMEF0UStITXdodmxIRm0yVlI0cExR?=
 =?utf-8?B?Z2lqZXBrMkVsSk9PUVBseUN3T2x6UnNCN0lkY2lGeERmWVVsZmJrRE9DMFZq?=
 =?utf-8?B?emlTZ3hRcUp4dm53ZStnQXJCOEFwS1JJZlN2SkZJU2REWVFMUVB6bzhCcERu?=
 =?utf-8?B?SDFNNFR1TmNlYmdTdG5zZFhsNlgxbGZsbGR0RkZOMFlYT2tQM3VNME5ScHJG?=
 =?utf-8?B?VmRDQ1lpZnJtYUcyZ3gzSTVtS2JEOEVzZG85UHF1c0dNR0duWlpIems5TmtG?=
 =?utf-8?B?N0tFSEtCbGk5WnlHK21scG1sUkJCVU1zeG8zc2NOS2NxcUp0OUFneXh1Umhj?=
 =?utf-8?B?d3FuZVFJb3ZKcTJQRmZTeWhwMmdrNERoZmJMRzRGYnFtVWQ5OHlNNkZtUGcx?=
 =?utf-8?B?Tzd1MEFoRENLVVFSU3NOeWdHSjdDWWZWeGhjcWhMZFRHLzR5TkhicHAxZGRG?=
 =?utf-8?B?WWFwdVBKTGNEaTE1bG9kd25xdEFyaXRCVU1OU1FTelIxcmo4WjRzMTFYK016?=
 =?utf-8?B?Sndad01vek9RdmVrb3ZBTk05anE4QlFtSmJNbXhmT1VlaHBGNXQzUVdUL2JG?=
 =?utf-8?B?SElWeE81VGNtMmN0c1FwSW5LczNrYzlvUzdpUGpEbVVlSTZ4dXdRaXFLY3ly?=
 =?utf-8?B?UnA1bVRYRzhEaEtTWWpocklTcEZHWDhFUVpIVk0yQW0xbC9mb1d0WW5nK0t4?=
 =?utf-8?B?UFFaNmMzQ2RDM0VScVVLVnhPb0dmOGFYbDN4Z09uc0dIZkEvTmtUMmF0cDR5?=
 =?utf-8?B?QzVuMXd6Yjh2NGkyQU5NWTdhMGNHbEh2U3MwL082Q1Q0NnJXTWRVYU5sNTk4?=
 =?utf-8?B?aGVCU1NjR3JzRnJjbHZmMk1vY3ZUU3NaTnJOU2dnL3kzZ0prRVF4MTJRRUxh?=
 =?utf-8?B?VUlTaHJJR0pSRmVHZEY2bEgzQW1DZVJEdDlyRHQxaHlTWVY4TkdCSXFkZG0x?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ead60025-329f-4fd0-5e1c-08dd575e4b96
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 18:41:06.4354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBJVxubn0QUTPAPAWOkZBjjsuiHzKRfzlUXMXoZksa6KrlwKjLHULaKxXcrG05gyORtODQQzvX9sr57DmrKX+gaXi55Pxv6p7SzSc3gs5KU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5997
X-OriginatorOrg: intel.com

On Wed, Feb 26, 2025 at 09:30:18AM -0800, Alexei Starovoitov wrote:
> On Tue, Feb 25, 2025 at 6:27 AM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Fri, Feb 21, 2025 at 05:55:57PM -0800, Alexei Starovoitov wrote:
> > > On Thu, Feb 20, 2025 at 5:45 AM Maciej Fijalkowski
> > > <maciej.fijalkowski@intel.com> wrote:
> > > >
> > > > Hi!
> > > >
> > > > This patchset provides what is needed for storing skbs as kptrs in bpf
> > > > maps. We start with necessary kernel change as discussed at [0] with
> > > > Martin, then next patch adds kfuncs for handling skb refcount and on top
> > > > of that a test case is added where one program stores skbs and then next
> > > > program is able to retrieve them from map.
> > > >
> > > > Martin, regarding the kernel change I decided to go with boolean
> > > > approach instead of what you initially suggested. Let me know if it
> > > > works for you.
> > > >
> > > > Thanks,
> > > > Maciej
> > > >
> > > > [0]: https://lore.kernel.org/bpf/Z0X%2F9PhIhvQwsgfW@boxer/
> > >
> > > Before we go further we need a lot more details on "why" part.
> > > In the old thread I was able to find:
> > >
> > > > On TC egress hook skb is stored in a map ...
> > > > During TC ingress hook on the same interface, the skb that was previously
> > > stored in map is retrieved ...
> > >
> > > This is too cryptic. I see several concerns with such use case
> > > including netns crossing, L2/L3 mismatch, skb_scrub.
> > >
> > > I doubt we can make such "skb stash in a map" safe without
> > > restricting the usage, so please provide detailed
> > > description of the use case.
> >
> > Hi Alexei,
> >
> > We have a system with two nodes: one is a fully fledged Linux system (big node)
> > and the other one a smaller embedded system. The big node runs Linux PTP for
> > time synchronization, the smaller node we have no control over (might run Linux
> > or something else). The problem is that we would like to use the Tx timestamps
> > from the small node in the Linux PTP application on the big node. When a packet
> > is sent out from the big node it arrives at the small node that send it out one
> > of its interfaces. It then replies with another packet back to the big node
> > with the Tx timestamp in it.
> >
> > Our current PoC for attacking this is to store the skb in a map (using this
> > patch set) when it is sent out from the big node then retrieve it from the map
> > when the reply from the small node is received. We then take the timestamp from
> > the packet and put it in the skb and send it up to the socket error queue so
> > that Linux PTP works out of the box.
> 
> This sounds like you're actually xmit-ing the skb out of the big node
> and storing it in a map via simple refcnt++.
> That may work in some setups, but in general is not quite correct
> from networking stack pov.
> You need to skb_clone() it and keep the clone, so only cloned skb
> can go into the socket error queue and up to user space.
> xmit-ing the same skb and sending to user space
> is going to cause issues.

This skb only goes to errqueue and then gets its refcount decremented
and dropped, we do not xmit that skb per-se.

> 
> Cleaner design would probably involve bpf_clone_redirect()
> and may be some form of bpf-qdisc where packet is waiting in the queue
> until its hwtimestamp is adjusted and its released from the queue
> into user space.

We were working on clone initially but map storage turned out to be much
cleaner approach, but we can re-iterate on that in case explanation
provided above regarding not xmitting stored skb still feels off for you.

> 
> What happens when small node doesn't send that timestamped packet?
> The map will eventually overflow, right?
> Overall it feels that stashing skb-s in a map isn't the right approach.

We did not handle that in our demo but I believe BPF timers would be
useful here, wouldn't they?

> 
> > Note that for the purpose of setting skb->hwtstamp and sending it up to the
> > error queue we are adding a kfunc (bpf_tx_tstamp) responsible for it, which is
> > not included in this set, so I understand it is not obvious what we achieved
> > with the current form of this patch set being discussed.
> >
> > We did not consider the restrictions that should be implemented from netns POV,
> > so that is a good point. How would you see this being fixed?
> >

