Return-Path: <bpf+bounces-53396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00922A50D11
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC8C188933C
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 21:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8916F1F8677;
	Wed,  5 Mar 2025 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V6reei2R"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9736253326;
	Wed,  5 Mar 2025 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741208920; cv=fail; b=kxovmB6A1QcNutkZVkWwFQvyuDe6Ruo5Wa5LT8k6E5St1HTSm0w1XHYLnee8SEm5ap06Y/vaQ3Qx28MgI4NtZN6/1PeerDd/FdUED86iF7B1HRRBpINZduc0q3EpJir6x1uYbkkR5lU0C6MGF7zbnwIkv9sER72nnW0iHU9VB1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741208920; c=relaxed/simple;
	bh=vxqAOE4npG0ala1GLTHswYz9S22EZSR6//F4mOZNGE4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qxm1EJ3W8GQHHsF4HMqd5wJZV/nZvnw4xg4OVgoJUeQjkyoc9yKUmbMxWKtgnoMiu7caQ3WsAimatB9PPxK0h3tZ/ujsGpH4WLto+OyF5np/Xhs26XyOGLyS+Cajo9jLRCA5vimYObGQaJPmAdFBXoDMy4dK6N8WAjSmHT4KnYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V6reei2R; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741208918; x=1772744918;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=vxqAOE4npG0ala1GLTHswYz9S22EZSR6//F4mOZNGE4=;
  b=V6reei2ReWZ4M+BIBZzKIA2Zne9zA1E+PTtYWiD6MlNTBXEXvV4X3M/T
   AlCgjklEKFwMbKvtVuLEKCai2gT1eaN6yp41iAmucEgU4iw3xJqrGTra4
   Tb6YZZv+2nc4SSWOcbS9HQR/nvYEVto6qfLf5TyO9hlPMwMk5HwTNgudu
   WSwasLzLh8VfKb6ym2IYMru5Y4WMPweZhZvxqq4UhgvxSYQRB9Y4QlTcn
   CBtw2o4qGVXiaQ4kDBFpcljuO75CLkWtxHewA3E0fNSP5VZn/hogsKErn
   3fZgKh4ChqudltDG9+qobxCYw47TREdiSV7FyukCN0aOYMvCZ5Fv2w9bY
   w==;
X-CSE-ConnectionGUID: RCerG4hHSr67JRUCSkADqQ==
X-CSE-MsgGUID: 0NLPDim0Rl6/V4wSXNI7qA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52405604"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="52405604"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 13:08:35 -0800
X-CSE-ConnectionGUID: 6S0TgiezThSI8WHCBAMd4g==
X-CSE-MsgGUID: zCAxDk1gQiC5ngtQive0dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="156022567"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 13:08:34 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 13:08:34 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 13:08:34 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 13:08:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ua4/PWmDued3IJk5Q491OsZEOy9HZoQdRhwVCE4Li5bhrS8+JiS77+brCgpzMa4APvj8Tf/DaNPHeoAzA/E8Oin0zaJl3gKAOVOwlIZWt9BBEWVj440K/ph9jVQ/shRbzuG/V3S8vaDhKsLdlUUmwyg4i9PZfgV9pPl03+Mcg9XlTNHThS3OcD8QOJbyncqq00Uxz5RwCe7MhwWPNJRujJqh2Nw0i68c+jHYksB/y7NHYxHKATi84o+VFnoR1uvlXe9SAE588Vv3XBEj5uy9y7A+b9xBAuwdk/pK13IvbYARQInyMG2nDTBbJK9NVmRUtwpdPz9GrVFRnumPvzFUAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6SlAu41UZwJrLcjHV95RSMXi08gObBDOBFviBMm95M=;
 b=joisDh4dRyY5BNNXrMOP5MQVktkgxk8BX7LnIi+xBfveFVsa7BnmsVki+fKeIi9dhiOwm+rFeF7aC92CUPzvMP0/dq/AXlOOjPBwBVe7M4XinHmqrZOeL/S7rtal9+5ih6l42tIhPTctx/M+0Z7q30qN1HB3QACo5FpAlyTRDU7cCMyHl7WUNwZi8WD79x3h5LXTRCzJJdvz5Q7GAGL3q8PBYh5ZjYCFkkyrsG+cjUol4wmSRJC/JNaFdz+HvE++XeTXtpavgfZA9m6uEkQg5AyZ+47TUG8WNDp9/9543jcGQSrZ8uEkjqFWBWn16x4lSMA2Ax/dmrbTYTs+6DMr9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6141.namprd11.prod.outlook.com (2603:10b6:8:b3::13) by
 MN2PR11MB4630.namprd11.prod.outlook.com (2603:10b6:208:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Wed, 5 Mar
 2025 21:08:31 +0000
Received: from DM4PR11MB6141.namprd11.prod.outlook.com
 ([fe80::31fd:4de2:2775:396f]) by DM4PR11MB6141.namprd11.prod.outlook.com
 ([fe80::31fd:4de2:2775:396f%6]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 21:08:31 +0000
Date: Wed, 5 Mar 2025 15:08:25 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Daniel Gomez <da.gomez@kernel.org>
CC: Luis Chamberlain <mcgrof@kernel.org>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Daniel Gomez <da.gomez@samsung.com>, "Petr
 Pavlu" <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
	"Alexei Starovoitov" <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Bill Wendling
	<morbo@google.com>, Justin Stitt <justinstitt@google.com>,
	<linux-modules@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, bpf
	<bpf@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>, iovisor-dev
	<iovisor-dev@lists.iovisor.org>, <gost.dev@samsung.com>, Francois Dugast
	<francois.dugast@intel.com>
Subject: Re: [PATCH 2/2] moderr: add module error injection tool
Message-ID: <zmyiypw5dvqir2lxxmdqvpr6qfrol2xem2usu2b5t223txm4k6@7hkupacsf5sh>
References: <20250122-modules-error-injection-v1-2-910590a04fd5@samsung.com>
 <CAADnVQJ8tYSx-ujszq54m2XyecoJUgQZ6HQheTrohhfQS6Y9sQ@mail.gmail.com>
 <Z5lEoUxV4fBzKf4i@bombadil.infradead.org>
 <qnfhjhyqlagmrmk3dwfb2ay37ihi6dlkzs67bzxpu7izz6wqc5@aiohaxlgzx5r>
 <Z7je7Kryipdq6AV4@bombadil.infradead.org>
 <4xh2oviqumypm4r7jch25af5jtesof7wnejqybncuopayq6yiq@skayuieidaq7>
 <ccofyygi4rerybdmecqswldykihtabx6yco7ztylqnbmw4a5qw@ye7zoq7mcol2>
 <3ehu3r4hlsf7cpptofz2y5aq2bazidq4buxbddqj6gzvzd3eh3@wzlnbvdsc6ty>
 <e6jybeg4y6q6zqyhqma7q4icw7jllieq5rwwi5pguy242wioyp@hkelxx7tnzlg>
 <mghfn2piuln4oxg2zkmukjcjbt2hyieqsgfnckfzvjwrcbi4eh@vwh5nsvwajjq>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mghfn2piuln4oxg2zkmukjcjbt2hyieqsgfnckfzvjwrcbi4eh@vwh5nsvwajjq>
X-ClientProxiedBy: MW2PR16CA0017.namprd16.prod.outlook.com (2603:10b6:907::30)
 To DM4PR11MB6141.namprd11.prod.outlook.com (2603:10b6:8:b3::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6141:EE_|MN2PR11MB4630:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e09b33-b4a1-4275-3471-08dd5c29e1b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXVVeFYwdFhPMFIzUG41TUVOQnVUdkRYUStNblM2bEdMWGlzS1JWYko2TjNu?=
 =?utf-8?B?Tkx0TGEzdVQwbGxoYjJkVHpQVlJUMi92NlJ2QnJ3MU1ZOWI1Z2VVdjZGZGcw?=
 =?utf-8?B?Z2NZbkN6THhvNkZUN3RIRVg0T1FqSC9Qc1RUS09SMnBSbFBPakxOY2ZEdllQ?=
 =?utf-8?B?UE00SzRoeDFwYzF6WTVjOHNpNlFFeFMybjJ3YVpWc3hwek8rMzY5YnNJdE82?=
 =?utf-8?B?T0pIeS9wOGg3eWZZUVhhdVRoSGpEMjdreFcrUmFxMnBxNSs0STdic2Yxcjlj?=
 =?utf-8?B?RUVrclk0WnQxRzErb3VRZ2tmMDBOemVNZTdkY2FVcytad3lMbXFwdUQxRGdo?=
 =?utf-8?B?c2R2bVZFeFh0Y2hJRDV1Q05jWVkrODBXZGI0dkdLUGNxc0l4eW9IdzM1OFRp?=
 =?utf-8?B?c3J1blZOU0Y3R3ErRWhaMmFGRDNXN205R2lPY2gzbURRWHFNN2g2TGxtMmJl?=
 =?utf-8?B?WFlDWTA1TDF5K3RZeTAwZmZGMjBHbzlyKzFXeTk2eDNwVGZzbjRic1FvTDNM?=
 =?utf-8?B?WjRlZFdGS1IyR3JnOXl4Nm51eDZzeDRuQVY4U1owYWdLNUxuOVFmS1U1Nmcx?=
 =?utf-8?B?Z1JSOVI3enU2Vyt1d1dlck92bGVwUUdJSzJpa29WdE1qVUtxSXBFOEhlQWxu?=
 =?utf-8?B?RWs2emw2QzA2WnlwTHN2akp2MFA4bFQ2TFRYSDhmNGJVajRBV2FBTitmWklG?=
 =?utf-8?B?ZUZZVWNkTzFvYTlRZzZZd3dmcjRyekZLVUUzTHc4TkhKT2ZLdi9SZDlKdkNs?=
 =?utf-8?B?eUNpdTdMakVSeU9IZ0NKbW9vYTV0UjA1SlUrbnY3RzdkVFVMYVZEUWErM09x?=
 =?utf-8?B?dEg0d29oNjFJRmJzTFhUQ2dlQTJZUkZpeUk3MmxSTVJwOHZFaUZOOEgzQm9J?=
 =?utf-8?B?a0F4SEYwMmtwRTBZS0pzdTZMb3AwTUFURVpOQ0JVWWh5QWdhRDBOUktoTXY5?=
 =?utf-8?B?T0Jad2RtR0RNSmdQTklEeE9UdExpaUhqSkMxazQrdUVXY2dXWTRqbyswK0U3?=
 =?utf-8?B?bzB2RzdIOTBweHU0MTYwMVRmVFVSWjdXU0JESUVnVjRJbW9yWnhUZUFJWmlG?=
 =?utf-8?B?Z21abDN4NW92YlhoOHNHYmkvKytOS1hmU2NEVldRMHpEMjZ6SnNVeURaK2JD?=
 =?utf-8?B?YWNMTDRrSlJjY2p2Z2paYXlWMkFPblVKZUQ5MElFQVJIcFk2U3h5Q2hvdDM4?=
 =?utf-8?B?WVRWUG8yN1hnRE1UbHlxbnplWUJib3F5aEozWks3TEpUdlhWRUFRZXNIZXQv?=
 =?utf-8?B?SVJCY3g4SS9qOXVmQkQreWlHQTl2d0ZyL2VFTWs4cHRIVjdKd3BnTzVNK2xu?=
 =?utf-8?B?NWdNdFB5UXhyOG5DSXB2MGpYb3lUTlZEZ0g4ZEQ3Y2FaNVZaTDJvZ0hPUWx3?=
 =?utf-8?B?QkQ3WlZBOXFqTkJZMjBqMW5SQjU1d3cwaVIvQ1BoZnVqa3dnbFU2WjRpQWE1?=
 =?utf-8?B?TVhIMm1YUE1NNUdOTjd0aUNUbGp5ekhDeGRFbVpFTVh4U0h1cFZoNGpIVE5T?=
 =?utf-8?B?WmFFRlZXaUlFWHl4ZnIxdEd6M0tra2ZFQ2hrVm5IeGVESW9vWGZlTEtjZXpp?=
 =?utf-8?B?OFpBRWQyVUpPQ3dZV2hTQVhOL2tuYk4rZHExZXdqcmwvaUZQVWJpN3I0NjFV?=
 =?utf-8?B?aW5TWTlIUHRpSmJPUkxlb0JzWkhpUUVUa1dMRnpjOFVRWUF3NFkxWUFQak45?=
 =?utf-8?B?UkowNEhObWhNNUdhMWlrOVBwdXFZMkhscFdKcFIrLzBoczNlWXhXeEZrK2pK?=
 =?utf-8?B?OGpXcU4xNGxiV2FaUjVMZ1M5T2VyQ1dKSDJXV1V0czFleVlBYUN2TWIzUUJP?=
 =?utf-8?B?OW5xRGNhbmtlWHVyeDdVdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWljZURZOStrY3IxM21acFZTWkZNZmpMUDZ0K1pReXlzTSt3NWorR3lUVXNq?=
 =?utf-8?B?UWgxay92R1VtYXl4UkVLZThzb0RvbWtiT3NhTlZ4L2RpUWhyaDRnMG5OTlJp?=
 =?utf-8?B?VTZ4b29US1YyU1NteXpZamdkUFFhWDJxSUN2bUpVZUhmcTJtUzZQRWVFRnhN?=
 =?utf-8?B?OSt5WnpLdkt3RWZuRExHYlFWUUFZMWlUUjFza1AxSFpYK0hNTW11YnN3QUxR?=
 =?utf-8?B?YVRTWWZsQU53OHVhZVB1UWwra2ovWWdBZEMyd0F3UXh2S0VyeTVnZmtpU1lQ?=
 =?utf-8?B?ZGtxdmdiYU9mSGYxMUNOaHU0eGxTRmp4dGh2d0tQREJxNGdnYXFYV2hrYWI5?=
 =?utf-8?B?N1dqb2Z2QmIyMlg5VmVqZks2SWwyL25SRERDdTh4MTVoSDZjL001REpodGh4?=
 =?utf-8?B?ZEJtcUpSMGtrYXJRbVNRS0tsMzgvTzllUVVIcWdJY0ZFS1YyY3NGSkR1V05u?=
 =?utf-8?B?TkpyUzRBMktDcEpDZ1ZFY2crNlpTZDNzaUZyeVBkakZZSThXcTVVMlVoM1U4?=
 =?utf-8?B?ajdvR2JFYVBnQkVoSXUrdHhWNVpzeTlEYitaZVh6blkzNFJWdHk1OHBKRFAw?=
 =?utf-8?B?MXA1ZzdmanNpK0dTREF5QnA3ZURlQzlvYnc4am90SnhMZnZaQ3RrNE1JMGZn?=
 =?utf-8?B?UFZxZnk4TThPZjAwelJYckFLRlFvWmRIaGpaV1Fjd3ZYNUtSRHdWQ3VZN3lG?=
 =?utf-8?B?Z3h1L1JHNlkzbWpmRmZEcklDT0JweW1sUDlPK1Q0Y0NzU1VOZmpybXEycUdo?=
 =?utf-8?B?TDk2cC9OdjZ3YWJNUVU1Zjd5Vk94c21Za2lVRE1GM0lKcE82dk9UUnFuU0xj?=
 =?utf-8?B?ZlRUeU5hMEhMWGRNNG1URDdqK1NWeml4eURCbXFxOVVQSmtCUlptczU2blAz?=
 =?utf-8?B?TFJ1QU16emo2bnB0RlRMQWhYNVY5b0p2eUZOUnIyZW9OMzl3ajV3V3c0SWFo?=
 =?utf-8?B?U1Y4ZHlOK3ZWaHlOMGttR2dZankxWEZNaDJxbktUa3ZoTmhaMERpZWtsRHdv?=
 =?utf-8?B?ZVJ1elVaVHl3Y2xCdm1admdTN1ZFQmREc3RSTXljK1phdlVqUURpQ3BMUGxx?=
 =?utf-8?B?NDEzYk9GOTU0SnVJVUJTNkJNbURERE5Dc21jK21xVUxQL3NhYU5tMG15UmFW?=
 =?utf-8?B?NjZFRlNjeE94NjNlU0s2RktIUTRNRW5yWi96NE1Tb2ZFaGZjdVlMdndsODlv?=
 =?utf-8?B?SWJFMHljdUdiZUFWVkFLK0owbERxdGgxejdqelRXeXExS0JaL2NpelpkeVIr?=
 =?utf-8?B?V1c5Z3paanlPZHQ2QVNiY3EwMUIzbWRzWkNEaVpycjNOSXJFakIzOXBzWHRa?=
 =?utf-8?B?UlJLTlBsMUEveUdrTVFXOUxHMGdtSUhaK0p0QS9KT3BWK0xIck1IbGZnYXZQ?=
 =?utf-8?B?U0o2azNkeWg2ZisybDZKQlZaYU9VcWd2RVFLT0FGcUoxcFM2MktRSTBCMmNL?=
 =?utf-8?B?bFdLaUpRaXVCb0dGejdvRXAzWFJkeVprNzVDenNyY1JTeHpvVzVMbm1mZDlQ?=
 =?utf-8?B?bTVWOHlWa0VhOVVIeUo0ZzlwZUcyQ0FYM2RJM3J1WHlJVEhPNGNic3Bzcmh3?=
 =?utf-8?B?MEVmdHlPaEJ2WHVBd281ek9aZkF4b3pHb0xWK2p3YVhoLzUreDFmQ01KODJV?=
 =?utf-8?B?V25qQm5Lcnc1K2RjV0tRb0FCUm12eDFadC9sNkZZc2J0TlI4Mit6RUs4cFZV?=
 =?utf-8?B?T3ptWDZ2VytXS2VmekgwMXdWQUNQclJheVlwRmlvajFneXlLWnpIekdvQnJt?=
 =?utf-8?B?SkN6VmtTemxJWm5mK01rNHRWVmNaL2FYaHJ1OWRnZnJwaERSYVhRU2FCWXNl?=
 =?utf-8?B?V1h1NDJiY3FzMmNDSzROenNRTWQ5bGlLdmRRQXlXZklRYm9pNTBlV0FWcDBR?=
 =?utf-8?B?Nmw4Qm1pTU96WDJOOVIzelZMMWQ5bmxUelMyTlNwY1hWaEpKelhwN1lFN2N6?=
 =?utf-8?B?bXN1V21FUWlwV0h0d3Y4MFEwSjhIVFdBdXhCSUtnOVBDQW9IYmFVRStVSTAx?=
 =?utf-8?B?VVVCcmJneDY5T252QU1HNTRzQ3ZXazdraG0xMTBCOEVIR0lMWHRhM2xIUUlN?=
 =?utf-8?B?eWtqRjk2TFZ2ZVpKSnVkcUczZ2dod1hNREJZVTNKajBBMXVsN05Bd2dFWWpl?=
 =?utf-8?B?OWppd1Vna3BNS29GTzJNUFF3ZXBVZVc4RG14QXM3Ujl2MmVaL25RSU1TcmtN?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e09b33-b4a1-4275-3471-08dd5c29e1b6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 21:08:30.9161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIHCdIFd2+BoX08fZdxpnzMwL7oV5g7QngmjFz6asnPmzyrb2ygg+jGwLShavbSEwubKwdB5pb4kay6A0EIyUMlBPo3pckh5/0ol3zBlzn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4630
X-OriginatorOrg: intel.com

+Francois who added most of the error injection points in xe

On Wed, Mar 05, 2025 at 11:06:57AM +0100, Daniel Gomez wrote:
>On Fri, Feb 28, 2025 at 12:48:38PM +0100, Lucas De Marchi wrote:
>> On Fri, Feb 28, 2025 at 10:27:17AM +0100, Daniel Gomez wrote:
>> > On Mon, Feb 24, 2025 at 08:43:45AM +0100, Lucas De Marchi wrote:
>> > > On Sat, Feb 22, 2025 at 10:35:07PM +0100, Daniel Gomez wrote:
>> > > > On Fri, Feb 21, 2025 at 12:15:40PM +0100, Luis Chamberlain wrote:
>> > > > > On Wed, Feb 19, 2025 at 02:17:48PM -0600, Lucas De Marchi wrote:
>> > > > > > On Tue, Jan 28, 2025 at 12:57:05PM -0800, Luis Chamberlain wrote:
>> > > > > > > On Wed, Jan 22, 2025 at 09:02:19AM -0800, Alexei Starovoitov wrote:
>> > > > > > > > On Wed, Jan 22, 2025 at 5:12 AM Daniel Gomez <da.gomez@samsung.com> wrote:
>> > > > > > > > >
>> > > > > > > > > Add support for a module error injection tool. The tool
>> > > > > > > > > can inject errors in the annotated module kernel functions
>> > > > > > > > > such as complete_formation(), do_init_module() and
>> > > > > > > > > module_enable_rodata_after_init(). Module name and module function are
>> > > > > > > > > required parameters to have control over the error injection.
>> > > > > > > > >
>> > > > > > > > > Example: Inject error -22 to module_enable_rodata_ro_after_init for
>> > > > > > > > > brd module:
>> > > > > > > > >
>> > > > > > > > > sudo moderr --modname=brd --modfunc=module_enable_rodata_ro_after_init \
>> > > > > > > > > --error=-22 --trace
>> > > > > > > > > Monitoring module error injection... Hit Ctrl-C to end.
>> > > > > > > > > MODULE     ERROR FUNCTION
>> > > > > > > > > brd        -22   module_enable_rodata_after_init()
>> > > > > > > > >
>> > > > > > > > > Kernel messages:
>> > > > > > > > > [   89.463690] brd: module loaded
>> > > > > > > > > [   89.463855] brd: module_enable_rodata_ro_after_init() returned -22,
>> > > > > > > > > ro_after_init data might still be writable
>> > > > > > > > >
>> > > > > > > > > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
>> > > > > > > > > ---
>> > > > > > > > >  tools/bpf/Makefile            |  13 ++-
>> > > > > > > > >  tools/bpf/moderr/.gitignore   |   2 +
>> > > > > > > > >  tools/bpf/moderr/Makefile     |  95 +++++++++++++++++
>> > > > > > > > >  tools/bpf/moderr/moderr.bpf.c | 127 +++++++++++++++++++++++
>> > > > > > > > >  tools/bpf/moderr/moderr.c     | 236 ++++++++++++++++++++++++++++++++++++++++++
>> > > > > > > > >  tools/bpf/moderr/moderr.h     |  40 +++++++
>> > > > > > > > >  6 files changed, 510 insertions(+), 3 deletions(-)
>> > > > > > > >
>> > > > > > > > The tool looks useful, but we don't add tools to the kernel repo.
>> > > > > > > > It has to stay out of tree.
>> > > > > > >
>> > > > > > > For selftests we do add random tools.
>> > > > > > >
>> > > > > > > > The value of error injection is not clear to me.
>> > > > > > >
>> > > > > > > It is of great value, since it deals with corner cases which are
>> > > > > > > otherwise hard to reproduce in places which a real error can be
>> > > > > > > catostrophic.
>> > > > > > >
>> > > > > > > > Other places in the kernel use it to test paths in the kernel
>> > > > > > > > that are difficult to do otherwise.
>> > > > > > >
>> > > > > > > Right.
>> > > > > > >
>> > > > > > > > These 3 functions don't seem to be in this category.
>> > > > > > >
>> > > > > > > That's the key here we should focus on. The problem is when a maintainer
>> > > > > > > *does* agree that adding an error injection entry is useful for testing,
>> > > > > > > and we have a developer willing to do the work to help test / validate
>> > > > > > > it. In this case, this error case is rare but we do want to strive to
>> > > > > > > test this as we ramp up and extend our modules selftests.
>> > > > > > >
>> > > > > > > Then there is the aspect of how to mitigate how instrusive code changes
>> > > > > > > to allow error injection are. In 2021 we evaluated the prospect of error
>> > > > > > > injection in-kernel long ago for other areas like the block layer for
>> > > > > > > add_disk() failures [0] but the minimal interface to enable this from
>> > > > > > > userspace with debugfs was considered just too intrusive.
>> > > > > > >
>> > > > > > > This effort tried to evaluate what this could look like with eBPF to
>> > > > > > > mitigate the required in-kernel code, and I believe the light weight
>> > > > > > > nature of it by just requiring a sprinkle with ALLOW_ERROR_INJECTION()
>> > > > > > > suffices to my taste.
>> > > > > > >
>> > > > > > > So, perhaps the tools aspect can just go in:
>> > > > > > >
>> > > > > > > tools/testing/selftests/module/
>> > > > > >
>> > > > > > but why would it be module-specific?
>> > > > >
>> > > > > Gotta start somewhere.
>> > > > >
>> > > > > > Based on its current implementation
>> > > > > > and discussion about inject.py it seems to be generic enough to be
>> > > > > > useful to test any function annotated with ALLOW_ERROR_INJECTION().
>> > > > > >
>> > > > > > As xe driver maintainer, it may be interesting to use such a tool:
>> > > > > >
>> > > > > > 	$ git grep ALLOW_ERROR_INJECT -- drivers/gpu/drm/xe | wc -l  	23
>> > > > > >
>> > > > > > How does this approach compare to writing the function name on debugfs
>> > > > > > (the current approach in xe's testsuite)?
>> > > > > >
>> > > > > > 	fail_function @ https://docs.kernel.org/fault-injection/fault-injection.html#fault-injection-capabilities-infrastructure
>> > > > > > 	https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/intel/xe_fault_injection.c?ref_type=heads#L108
>> > > > > >
>> > > > > > If you decide to have the tool to live somewhere else, then kmod repo
>> > > > > > could be a candidate.
>> > > > >
>> > > > > Would we install this upon install target?
>> > > > >
>> > > > > Danny can decide on this :)
>> > > > >
>> > > > > > Although I think having it in kernel tree is
>> > > > > > simpler maintenance-wise.
>> > > > >
>> > > > > I think we have at least two users upstream who can make use of it. If
>> > > > > we end up going through tools/testing/selftests/module/ first, can't
>> > > > > you make use of it later?
>> > > >
>> > > > What are the features in debugfs required to be useful for xe that we can
>> > > > port to an eBPF version? I see from the link provided the use of probability,
>> > > > interval, times and space but these are configured to allways trigger the error.
>> > > > Is that right?
>> > >
>> > > I don't think we use them... we just set them to "always trigger" and
>> > > then create the conditions for that to happen.  But my question still
>> > > remains:  what is the benefit of using the bpf approach over writing
>> > > these files?
>> >
>> > The code to trigger the error injection still needs to exist with both
>> > approaches. My understanding from debugfs and the comment from Luis earlier in
>> > the thread is that with eBPF you can mitigate how intrusive in-kernel code
>> > changes are to allow error injection. Luis added the example here [1] for
>> > debugfs.
>> >
>> > [1] https://lore.kernel.org/all/20210512064629.13899-9-mcgrof@kernel.org/
>> >
>> > To compare patch 8 in [1] with eBPF approach: the patch describes
>> > all the necessary changes required to allow error injection on the
>> > add_disk() path. With eBPF one would simply annotate the function(s) with
>> > ALLOW_ERROR_INJECTION(), e.g. device_add() and replace the return value
>> > in eBPF code with bpf_override_return() as implemented in moderr tool for
>> > module_enable_rdata_after_init() for example.
>>
>> but that is all that we need with the fail_function in debugfs too:
>>
>> $ git grep ALLOW_ERROR_INJECTION -- drivers/gpu/drm/xe
>> drivers/gpu/drm/xe/xe_device.c:ALLOW_ERROR_INJECTION(xe_device_create, ERRNO); /* See xe_pci_probe() */
>> drivers/gpu/drm/xe/xe_device.c:ALLOW_ERROR_INJECTION(wait_for_lmem_ready, ERRNO); /* See xe_pci_probe() */
>> drivers/gpu/drm/xe/xe_exec_queue.c:ALLOW_ERROR_INJECTION(xe_exec_queue_create_bind, ERRNO);
>> drivers/gpu/drm/xe/xe_ggtt.c:ALLOW_ERROR_INJECTION(xe_ggtt_init_early, ERRNO); /* See xe_pci_probe() */
>> drivers/gpu/drm/xe/xe_guc_ads.c:ALLOW_ERROR_INJECTION(xe_guc_ads_init, ERRNO); /* See xe_pci_probe() */
>> drivers/gpu/drm/xe/xe_guc_ct.c:ALLOW_ERROR_INJECTION(xe_guc_ct_init, ERRNO); /* See xe_pci_probe() */
>> drivers/gpu/drm/xe/xe_guc_log.c:ALLOW_ERROR_INJECTION(xe_guc_log_init, ERRNO); /* See xe_pci_probe() */
>> drivers/gpu/drm/xe/xe_guc_relay.c:ALLOW_ERROR_INJECTION(xe_guc_relay_init, ERRNO); /* See xe_pci_probe() */
>> drivers/gpu/drm/xe/xe_pci.c: * ALLOW_ERROR_INJECTION() is used to conditionally skip function execution
>> drivers/gpu/drm/xe/xe_pci.c: * ALLOW_ERROR_INJECTION() macro but this is acceptable because for those
>> drivers/gpu/drm/xe/xe_pm.c:ALLOW_ERROR_INJECTION(xe_pm_init_early, ERRNO); /* See xe_pci_probe() */
>> drivers/gpu/drm/xe/xe_pt.c:ALLOW_ERROR_INJECTION(xe_pt_create, ERRNO);
>> drivers/gpu/drm/xe/xe_pt.c:ALLOW_ERROR_INJECTION(xe_pt_update_ops_prepare, ERRNO);
>> drivers/gpu/drm/xe/xe_pt.c:ALLOW_ERROR_INJECTION(xe_pt_update_ops_run, ERRNO);
>> drivers/gpu/drm/xe/xe_sriov.c:ALLOW_ERROR_INJECTION(xe_sriov_init, ERRNO); /* See xe_pci_probe() */
>> drivers/gpu/drm/xe/xe_sync.c:ALLOW_ERROR_INJECTION(xe_sync_entry_parse, ERRNO);
>> drivers/gpu/drm/xe/xe_tile.c:ALLOW_ERROR_INJECTION(xe_tile_init_early, ERRNO); /* See xe_pci_probe() */
>> drivers/gpu/drm/xe/xe_uc_fw.c:ALLOW_ERROR_INJECTION(xe_uc_fw_init, ERRNO); /* See xe_pci_probe() */
>> drivers/gpu/drm/xe/xe_vm.c:ALLOW_ERROR_INJECTION(xe_vma_ops_alloc, ERRNO);
>> drivers/gpu/drm/xe/xe_vm.c:ALLOW_ERROR_INJECTION(xe_vm_create_scratch, ERRNO);
>> drivers/gpu/drm/xe/xe_vm.c:ALLOW_ERRORALLOW_ERROR_INJECTION_INJECTION(vm_bind_ioctl_ops_create, ERRNO);
>> drivers/gpu/drm/xe/xe_vm.c:ALLOW_ERROR_INJECTION(vm_bind_ioctl_ops_execute, ERRNO);
>> drivers/gpu/drm/xe/xe_wa.c:ALLOW_ERROR_INJECTION(xe_wa_init, ERRNO); /* See xe_pci_probe() */
>> drivers/gpu/drm/xe/xe_wopcm.c:ALLOW_ERROR_INJECTION(xe_wopcm_init, ERRNO); /* See xe_pci_probe() */
>>
>> That is different from the patch you are pointing to because that patch
>> is trying to add arbitrary/named error injection points throughout the
>> code. However via debugfs it's still possible to add error injection to
>
>When reading the patch I assumed the block/failure-injection.c was needed for
>the knobs in sysfs/debugfs. But I see I was wrong and these are only needed for
>the arbitrary error injection points?

yeah. For working with ALLOW_ERROR_INJECTION() we have to refactor the
code so the functions follow its requirements. When that is true, then
we can simply use the fail_function/inject to trigger it.

>
>I see mm/fail_page_alloc.c has a similar approach with should_fail_alloc_page().
>
>> the beginning of a function by annotating that function with
>> ALLOW_ERROR_INJECTION. If a function is annotated with that, then if you
>> do e.g.
>>
>> 	echo xe_device_create > /sys/kernel/debug/fail_function/inject
>>
>> it will cause that function to fail. There are some additional files to
>> control _when_ that function should fail, but I'm failing to see a clear
>> benefit. See this example in the docs:
>
>Can you clarify if _when_ (in debugfs) allows you to access function arguments
>of a given annotated function with ALLOW_ERROR_INJECTION()? It seems that might
>be the only part that can be moved out of the kernel and handled in eBPF. Other
>than that, I don't see either a benefit of using one approach over the other.

afaik we can't change the behavior based on arguments when using the
debugfs approach.

Lucas De Marchi

>
>>
>> 	Documentation/fault-injection/fault-injection.rst:- Inject open_ctree error while btrfs mount::
>>
>> Lucas De Marchi
>

