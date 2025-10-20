Return-Path: <bpf+bounces-71407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17883BF22B8
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 17:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 546CF4F9416
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 15:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9585226E146;
	Mon, 20 Oct 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exGJ1cJJ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165A926CE06;
	Mon, 20 Oct 2025 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974902; cv=fail; b=gaRieLIKFlOKz5byAew1pMp97g4uO0kRHUA7FzrS2zOC+MRSQTGd+Wn7BfU+S2kuI3Ie40WzxELK5HnrqFUD+D/uV0ocgWMSrU+KF+dwQBbvIUEdb69Nn5lcbTTXNXameDq5DojSZLTYs+iDTjVMfYr1B3IlIIA052ltyI8luOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974902; c=relaxed/simple;
	bh=MB4IGeI3lu5Wo0lzEdqVxRXc3tcjFNSoLZ6U6PZXusk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=td6Ib/GBcaUvHKB41OXjvGFxt8380lDGtRjwX3Bl8cF+GvoprAI6QHkGrAwReWFe++tQCwjKQLlNxVX8gfLAUWTYblSfrf79NnFsIzq1ZVdJeiHVDaBL+cRioB4MzG/lHsq4pxFSdEOyMmFbmuC2YTJ0hxPi1j5H/YUiMTCGMyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=exGJ1cJJ; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760974900; x=1792510900;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MB4IGeI3lu5Wo0lzEdqVxRXc3tcjFNSoLZ6U6PZXusk=;
  b=exGJ1cJJNqFOSeIbsdvwxcfEcN5doMnYVWmiPL2QPbQwyeRX5Bc9lbZl
   caND1KKWt4KQe0FvZynjgrcok5wUMPW0W+4Vmo7qByANF37d8XO9BWRRy
   sH5IrqLPpcf9wgql7XzpcKIktqpQt9c3VnO4yofGfz2VZk9feTpjOSqz3
   wSLrPlqLUNpkslScsVYcXQWtiQGFI1+XW/BCnI2UR0NPzPJYO8XO/oJm+
   JRhSW3mpXRJ8vZn7cHGM+vbEJo58KkYWHs8qxTHXWJA8hdXSUMZf4XKRM
   6x6I/vlQclI7jSsPJIJoI+rnosHejaSZgqbpQEBP3p82BgzEOJ/Eu1GdH
   Q==;
X-CSE-ConnectionGUID: oiWyQeFuS2GuprqcngiukA==
X-CSE-MsgGUID: pdw8hY/fTQWMXnMui6zBbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="50661359"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="50661359"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 08:41:40 -0700
X-CSE-ConnectionGUID: NH8DD8HyQsW0V3PMCkUz+g==
X-CSE-MsgGUID: sQY3KkSARKOq/0nKP2wifQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="183766919"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 08:41:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 08:41:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 08:41:38 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.69) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 08:41:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGRMZ66qY/82UZhU1/NhJIYvKw9PYoHcIKkfK3tEko4VeyeKJRADNMZjZQC7pAXmK5A54836dzeIjUrRUr3ozsj4F5eadhhP+vmkDwPTKuCncmQizlUA1/89OmloTS7FFwwITaUMQbf3PMYZCaoxBwmwLipjGgzVb+Vabped+g3k30sfJ1jcRapHE5K+66GfBs8rtCheXbazftxBNnzpr80ER5vKvjZH3AwPfncK7BaRnT07cgqJ7wzZ5ZwLOs+UQaxhC0mi8MZWODed7aqkipio7WDy4HRqRKF+eBOoPiovjwgOsdBfZd3PkTGBlqM43UHr3NUYXjVPn1qdlr/NCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NyYEONhYO4ehmts7Q4BlArm9elCVHRrQyCNu6YYQ+s=;
 b=fVC6ZWUDhDjDiDTfyRwF/AzZjlmNFUHWrtE9Ew+dTgIy0sjk6vKpZwdFQCTByHDH+gpLlqZLKY5o4mNZPobZG0ijMqtsbKuWv6a7JBzSwoB7MJh7RwpMBMZjIxX5xax1PFtCmRtWn+5MkrlCXRkHaKm5IwWiS0EdMsfx1526Y2H3P+QfNJ5msuyXprX0YhbZyNHOT1Z5s2E35YUVRdmVcTZc2z4FPgf4WRC6uiL7J0M228/+ubIX8S8JHosB9urpkE9V6pA7s/VQKmVIsSy+tQnxw7gu2pGqyJC6SPPVflTeYze0/rmUbyIAXd4o+pkQE2eSLgkbsgnb8UrisQWSaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH3PR11MB7843.namprd11.prod.outlook.com (2603:10b6:610:124::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 15:41:36 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 15:41:36 +0000
Message-ID: <42b9b376-897e-4984-909b-218bd1e3214a@intel.com>
Date: Mon, 20 Oct 2025 17:41:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf/cpumap.c: Remove unnecessary TODO comment
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <davem@davemloft.net>,
	<kuba@kernel.org>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<sdf@fomichev.me>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
	<kpsingh@kernel.org>, <haoluo@google.com>, <jolsa@kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <skhan@linuxfoundation.org>,
	<david.hunter.linux@gmail.com>, <khalid@kernel.org>,
	<linux-kernel-mentees@lists.linuxfoundation.org>
References: <20251019165923.199247-1-mehdi.benhadjkhelifa@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251019165923.199247-1-mehdi.benhadjkhelifa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0030.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::26) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH3PR11MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: f7ec3487-8adb-4808-79ba-08de0fef2741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1c1ZGpWMnhHY2QyYUhVcUVQS3FtbUhpaWVHWDNpUkQvcGU0Nm1tN0Y3OU4z?=
 =?utf-8?B?ZVdGTTlZQU90VUcyWUpMR2p5NGJyV08wblQ3RUwxNnc3UVJnK0Z5QjFSNW1p?=
 =?utf-8?B?S095eDd0UWlGc2w4eWNOTWQzNzUrRjhKbk13RUtFbU5xdHR2VE5pUFdiYUdY?=
 =?utf-8?B?UFNVZTY4Uk5BRVQ3b00zK1ZjaGJ6aWlFWXZ6Vk9IYXNTOXViYWUxWG5Nam9a?=
 =?utf-8?B?RENmdUhFZTVlK2tvTkNwSFpmTWlBYWhCd3ozcllZekJKQTJQTXZ5akdTQmN2?=
 =?utf-8?B?UTV2elFyTnRUQ1lJRFBOcHFTWVhCUHZEdUlQZVFjSXBUZXVVUTlhcGVDdE0r?=
 =?utf-8?B?K3dndWZIS3B5ZzFlVWFQelZXTFVzaXNQZTFSREE1WWV1VkRzRFNQcEJ2OWZV?=
 =?utf-8?B?ZFpkcjlDdXZlSlZuRXMzVHpNVW16OTZldDZBY0g4OWZMaEFnbm9zUkFRK25N?=
 =?utf-8?B?NVlPQWNwZ1VpaHp4SGpuVkZIY1JNVW44dW9ia1hDUW1BODFhcGVTeEFMemp6?=
 =?utf-8?B?Z2FQVVZxbms5RGx5YTZXcHNZTnkvNXJOUDlGOENLWGd6OEF4aldjalgrTG5I?=
 =?utf-8?B?YUl0VDJOODJocW5SWEpOYlVYSUY4VE85VkFIRHBDNlkva1pMdUdhb3ljamFC?=
 =?utf-8?B?aG1NMUNJSmJRZC8zNUpoaGZKc1BHNWVIMmtrNkdja0xFSzNRc2h3YythaHdl?=
 =?utf-8?B?SEdKZnlrZ3dmN2Z2SUhqbFFRWDBoOHY1bzVLeDNzNmpZS3Zua29JMWQ2eTR1?=
 =?utf-8?B?T2s4MFR2OW85akxQak9BRi9OQmlCWkk2NmtSN0NLWGtuYkdDOXhIckxFdDZ2?=
 =?utf-8?B?dk53VGZmd1d5bkNDcWRsNHRrMFZUSjdOSFd3SU81d2VlNnYwQmF2MzV0MHlz?=
 =?utf-8?B?KzAweGJrQlpuWWZnTi8xNnZpL3FQZXo4UTVCYnlFVkZ1S0hnSTg3YUhlaGZM?=
 =?utf-8?B?am9LOGU1ODEzaHJXN3YycUZ4YkRiZ0p1dnJaMkVKRWd1WkM5ckh5Wkl4eXRo?=
 =?utf-8?B?RnNSV1ZiN1NsTzN2TFZDSW5tRE1pWGkwcE1hRkg1YzQ0OEFmaDJVVEtDYWda?=
 =?utf-8?B?a2QydjM4RUY1TG9GcmdoSExqcHpVNmxvcGg1SS8rRGZMOHA1dzFSUVR2OUFu?=
 =?utf-8?B?bWJ1eU5NRGtCUkxlUFBPM2IveXFodGtqWCtRckkzblhhQjNqVjRHRzBJRjNF?=
 =?utf-8?B?VDVuMFM4UHM1REVtMFdLcnM4TExjTk52Q09pak5nQ05iSk43RmpzaFFlY3VH?=
 =?utf-8?B?QXNhQ3UreEk0YVQxb3MwdjNwYnQ4NkljU1U1ck1hOC9BQTg1RXBJTzFUeG1T?=
 =?utf-8?B?MTlJSXZrRkYvTDF6Ny9Obm96b1k1SGI3RFNybEgvMDFtOHNTY0hmY1h6c1pK?=
 =?utf-8?B?NHFET3RoVCtibGRpZXdhKzV2OEcwMmtmdGY1L2FpR3lNZUp0ZTZralNidG4r?=
 =?utf-8?B?dEtSd3N1Q25Qamw3ZVl5R0dSTVhzS1RJTDNSTVNTZDM1N2xCVjhNNzVrQjN5?=
 =?utf-8?B?a2V4RnlGbUMzNEsyaEpnREViaGF1VkNkbVYyaDRXdDJtUTlZZVVGWEJ3VWRI?=
 =?utf-8?B?V0hBNDh3VHRUQXBVOWhRQldHaEJkNFNDSHJrTTQrSHRqRk5xdS83aFFuVGZK?=
 =?utf-8?B?dVRpRk5HQnZKVHNzY0JmNmlLQ3QxWnlNSTArZG9HV1FQRUFRL1ViaFJLdGhn?=
 =?utf-8?B?TEw2UjNnNlR6U0hoZFFFSlYzbFJSNTRaL3VlaXoxRm5wNW91TytacUkzejdR?=
 =?utf-8?B?Rjl5U2ZzN3ZjalB0SERUZlZJTGJxYUdJbUtORnlRenJMWU1Cb2VUbWhVOXlr?=
 =?utf-8?B?UHRQd1Y1eUlreGFFYmlFYTRKejIrenhQOGRscHlkbmNvVkhpVXVYalFqZEow?=
 =?utf-8?B?WE5iN3Niek55Si9lcHkwSWI3RGhiMnZ0SEZ3WlJnYncxbEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWVFZVdjM3hZeGRMVWUxRGJveDVEQnVZRGxJMXdXaWpGTzc1a2JiY2RtVjhZ?=
 =?utf-8?B?akd6bnZSUHhHUXpnT3VqNjU1aTRJUHVSL2xxNW1JUjFRblRPZStYUVgveDMz?=
 =?utf-8?B?WGIrdERLWDZZTGJjZGc0ZWFGWWl6TzIvdExwemdRbnh3MHF2eVVoWURzTkpy?=
 =?utf-8?B?ak54ajZUSnFKY3hta0F4dUp2Sm1JNVJtVlprZVVuOGJzeG9YWW9UMlRvclBM?=
 =?utf-8?B?RHhMV2pvampjWUZpR0YxNFhURy9uVXdTWkJuUU90dUNNd2JWUHErbldrSndQ?=
 =?utf-8?B?MEdOeW40LzVIVG9TRE1vSFZERHN0TzRsK0ZFMFJsdU14YXg3K094WlZvSFB6?=
 =?utf-8?B?cFUwdjBIVm1IQjdmVE5tSkxuUlByNXA2dnlyZ1VDWE95Mk5BRDBMT2NTM1hl?=
 =?utf-8?B?WDdFK29VYXdLOHIwUXk3YjBRVStuRWhtSXFIY2NLVzlza05NN0VBZGlnbTJm?=
 =?utf-8?B?ODA0U0VsY21zaUp6NnBvOUVXTWNIZFh2Q21YUG84OE92cnZYM1hOQk5tNE9Q?=
 =?utf-8?B?ZFZLRnlSZ2NMdUFmY011QWxaQTRPZ09mOE5ZcDc3SkJqYXNuM1pXZ3IrNW51?=
 =?utf-8?B?UklJbERqN0lXWWp3ZW9RODgzZjdpckVORkJmWldBVHZkR3pXbGZLeEM3TitF?=
 =?utf-8?B?V3RJTHVieXZ0dTZZOXBaa2xKeWp2bTFuSXhKNmQzMExSc1NKRUhDbk02b2x4?=
 =?utf-8?B?dDRqK2xlcGNNWFMvRHNsRlk4eUk2K2RDWWhwdDIvc1BGT2I1SE1vYy9jOHdC?=
 =?utf-8?B?M2t6Z2ZvempJR0VXVGZqSW50a255a3c5NHJyVHkzNjZDdzJ1UCt1OGZvWkov?=
 =?utf-8?B?RmxKNlN4em5pdDZIMi9xd1R1MVoxZHFDeXU0dmxGWWtXTk5GdHg1SzZRT0NZ?=
 =?utf-8?B?b2JRUldpMjZ5TDNKWTErZUJ6UnNndzg1Y3A4elpUcWkvRXpFZDcxMm1FMndY?=
 =?utf-8?B?T3hKeGdwQVFxRzVLOXhaQnAya0RlWEFCcEpqTS8ydGplQy9zdG1sR3F5Q2kr?=
 =?utf-8?B?V3VSNnlhTmYyL0dNSElOMXkybStoV2c3VFFFZVQ2OUFXV29ONlV3cDQrS29F?=
 =?utf-8?B?a1UxcDJnRGpXNDBwNW9VWkJhTTRnVWkyRUMvdHMyalBuakkrR2R2T0xadncx?=
 =?utf-8?B?RUoxUDhnKzYvcHdnRUo2R0VXWFNwMmR2N2JQVjArQVZUWnJ0QTg4NmZwUkdh?=
 =?utf-8?B?YzF4UnExNTNtVjF3R0ZCeDZLSjgzaDlUQ1JHZUFMeGhTSUVIeTZrRkN6WGVN?=
 =?utf-8?B?MW4vaTczbDR2bEVXTFNlRmxVeXFOQmpMbDNtcVI4cGxxVWFPWEN1a2RtS3ZR?=
 =?utf-8?B?YlZRYktKd0dEeGRmM1pxcnBxYW9NalhvYlQveDluZG4wZ3ljSWgrSXBMR0M2?=
 =?utf-8?B?b3R0Q2NLNXNqQklucHM1U1V3ZnVPUVMzRWx4bVVPVm1ZVUZvT2RDMFFBcWhl?=
 =?utf-8?B?K2g1c1IyT2VlajdsQ0RYUjZ3THh3d0sxc1dVL05YSkZ0OEc3T1RQcEg5MHVP?=
 =?utf-8?B?ZmN3aXphMmFrbkk2aE82MGpXTkFLWk54dWpxSFAxbE82eXdrZlQwRnNzUEZx?=
 =?utf-8?B?WGR6cXlnSTBlcG4xZUxlV1ZYTUsvbHRkMU1YUjR6QktiNVhubGRjYlMyK1Mz?=
 =?utf-8?B?N09FcGhtUnpHY2RodTFqaDhUUEVwNDJoc3lCQkJNUzlHNzdYUkdHMGlxV1NF?=
 =?utf-8?B?OGhJbDdkSUhPZ0JITTIzOVVRbjhweGRCSURvb3V1aUJRR0s4Slk5a0phQWlt?=
 =?utf-8?B?L0RHdkloakFJeDlVMy9mMEZnMmd0ei9SNm02N2x0SmdScU45L2ZDYm5pYTNk?=
 =?utf-8?B?S3JrNnJhQjczUnVBSkpoWStmVEREbDluSHBzZ3pISC85ZXpaSTJMYW43bUNx?=
 =?utf-8?B?QXJ5R1ZiQ1lsZ00rR3BaQWtzRm1kZEJEcmg4U3JIRkJVOWYzd0kxcmhETWdh?=
 =?utf-8?B?QVY1NENxL1lRMlF3S1ZVNTduYjJlVi9RNjZ6MDBrMXoxMlJBK0J5bDZYLzE3?=
 =?utf-8?B?ZXorV1R2N2FCQUNlV2kwYjFYVVdTaEhhWkZnVjhyQ09adVBvcnlqZVhDVFpW?=
 =?utf-8?B?OUpHQ3FMTlJtYUgxSGRtbTRGN3ZXSk8yL05MSklYQUpVOC9KdUZpWTVEL2Vs?=
 =?utf-8?B?Qjd4ZVh5dzVUTjhBdVN2d2lxOHRNMGNNWmtMVnZ2TVVLZnBTckZuU3RTU0JI?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ec3487-8adb-4808-79ba-08de0fef2741
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 15:41:36.6316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqdV6N1zjOq47XlQCWRWHO6kLzLpDiPDBCeKlRkg2iMppEEfcz/AjY1uypsHIhfPu4fhy3uxXXTHdGkuPMkpzXlLyu8c9Wh+IMzPnHQQTxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7843
X-OriginatorOrg: intel.com

From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Date: Sun, 19 Oct 2025 17:58:55 +0100

> After discussion with bpf maintainers[1], queue_index could
> be propagated to the remote XDP program by the xdp_md struct[2]

But it's not done automatically, so not aware users may get confused.

Instead of just removing the TODO, I believe you should leave a comment
here that the RxQ index gets lots after the frame is redirected, so if
someone really wants it, he/she should use <what the second link says>.

> which makes this todo a misguide for future effort.
> 
> [1]:https://lore.kernel.org/all/87y0q23j2w.fsf@cloudflare.com/
> [2]:https://docs.ebpf.io/linux/helper-function/bpf_xdp_adjust_meta/
> 
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Thanks,
Olek

