Return-Path: <bpf+bounces-45178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7F59D2548
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 13:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EAD1280DB6
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 12:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0DF1CC150;
	Tue, 19 Nov 2024 12:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DIbBk+fb"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572071CBEBC;
	Tue, 19 Nov 2024 12:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732018031; cv=fail; b=bHmDMftDopQWFqCHnHSF0zVx3D+d7R3twlQXAyTpz1WuSe4ulqQzfM6sEglUJucesG8I/Sh1/VaZ/sjdWEVy/4XXpGLGtfdsS7AUaEaADgjN4jrZSeeWNH/EbDGExtJK8BMv/cyS6FlhiIyapccJd2djAt9pAvbJTbQdnGo5FaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732018031; c=relaxed/simple;
	bh=FQCJibBos8OU5ZNhFrGElcOkEajz4QBNEaHkXsnlRsU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oAftavmOA4r9bz/tWntlC+JLVKRVTH1vatJmkK36eW9+Z2AHM+AKtT2fFE36tDbJjiQCIW/8nkcCu6xDw7dse3PMsIc9qXsq/MY0qIf4R+tZXgzOfVJY95R6AVFAW32pqQHBghx7qEBaHwbfzsqviwR4Xj+9X9wza1/drLT+2Z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DIbBk+fb; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732018031; x=1763554031;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FQCJibBos8OU5ZNhFrGElcOkEajz4QBNEaHkXsnlRsU=;
  b=DIbBk+fbX+xJPNSaboHJgxrOQOkIq9BBFNU5o1bPPdbadGbpVhTFkTm7
   XqH9PDN10AI30O1cm/UjjpZOr9cGGb8H8NRv+in7KZYTq+uh683P2YEce
   CosGXwGlcq/7Ig39H1Milcs2Kx5S90+mnHgeF9vXG5EcD3inKOYhyrw8j
   feckesdKsp/szHd0/0mHEEg4FOSPDvnzFF5HKIQqIPVoUCLQm1y69xZ+C
   DPiy+ZU40yNFBx27vK9L/UOoXx7NLWjazGN63VHEgqGuZKO+cm+WWWn2h
   U7x3KTVSytss4koydWL7PFWdefFZ89qw/d51BRHAtPhITtJKQbYcZy1Ma
   w==;
X-CSE-ConnectionGUID: MMOiY9aOR1uW5rJIYcFVvA==
X-CSE-MsgGUID: 6zznbiUeSreb8wPF7b4EAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="32255917"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="32255917"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 04:07:09 -0800
X-CSE-ConnectionGUID: Xbol2gWsTfOxxfPEXYjlTA==
X-CSE-MsgGUID: ASUx0jQfRZiH8v5ccd965w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="90346641"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2024 04:07:09 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 19 Nov 2024 04:07:08 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 19 Nov 2024 04:07:08 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 04:07:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qhvnpv1OGl+f+retEjyuW1eqWNF3veViq8go+Dz6Q+US3w1HZ9jBfIg+7Wv4l17wx5HohQAk6S8FiorB5PSqxSaRoal/3J3WbVZAwdvnKpih2kLBzkkJsV1KfHv9BU9fqJgp+yjQwcD/PJGQJUSjgRc84bepFXvFK+dcSGRkOt9xNnMrWG/SMIgmmQZIqTLzIhA0z1vcUssEjLPjWk9uOy2Waf0V5J66C1uB5JtqfUkzMrLWgMa1s6wognHQ5nwfA1fpv9ec4xuUW7k0mGzkuOxrhRSJPHW2nminSfbiA/Cjl83ykHAk53AISGELa0TKJ4xDAxwADZnxMNxHtwGVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vB0FDWBWdGctgw5+CkFEv+S9ADQGTA3ImPvIvmjw4lE=;
 b=S6//YnXniFiGAPapfVatNzvyZWVhGBmXkcKuzw6byK+Sk5+XR+97RMp5oq2gDDSN2HSCwX/HQGLjahFV9C5MZipr6d6gOoP9kQ+E+Y2RQhv2tUeTJTdYT4jadP78A5+5Ni50iVHtF+oTfxYW83+9G2UmN6Tu3RfNeNJQA9Zo8NRtCfPm7LA3uGNBmwFN8bFlDHy3RO/BZwTvu/Qh72S3phkdAUSJc8viC8GcA2PlllDgsCka+77fvjB4eV2HB6bKlLXJ0Oy7Rt8mwjWCTXXW68JgETD4f0xutIvLwD/Ldq4htcswIjole2G6raR3nRAvt+nKJG8Mb2Suo1Qs3ontWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA3PR11MB7534.namprd11.prod.outlook.com (2603:10b6:806:305::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 12:07:05 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 12:07:02 +0000
Message-ID: <63df7a6a-bb4a-410d-9060-be47c9d9a157@intel.com>
Date: Tue, 19 Nov 2024 13:06:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 00/19] xdp: a fistful of generic changes
 (+libeth_xdp)
To: Jakub Kicinski <kuba@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
 <20241115184301.16396cfe@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241115184301.16396cfe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0021.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::25) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA3PR11MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dfca6de-221c-41f0-32e1-08dd0892ad62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnhKSVU1VnRnWHJCam8vdkROeWZJMFVib2ZRWW54STVCQyt5SmVPR0dzaVYv?=
 =?utf-8?B?a2c0T3E5WlF3Z0UweXhxcWM4QzFObFBmL0RMaFpHUFhOTG9JeGtONlNqTXJL?=
 =?utf-8?B?aDg1OGVCOEk5aXBteU1LU05uNURVR1gwcmdrK2trbHV2Zk1UTEhIQ2lwTnhW?=
 =?utf-8?B?R3ZzdHNjb3N4Z2VMRTlJelBEUnRERHlsYnpMeld3MUFlL3dOKzBCM3pUK0I3?=
 =?utf-8?B?ZTlLd1ZwOEY5ekZTeDRQb0hwRTVnUklKV1B0cnN6ak9aQkpEZkFJM1V6Yk9y?=
 =?utf-8?B?NnJFRUtkNjY5SVR3S0dUSDVVOHhEV0FuazBzME9nUXZsa05XeWJSNDFFN254?=
 =?utf-8?B?bGdwUlVtM0VaUmg0eFZYdHFHRjdqMEU4cUhjZmlkSThGSUNtaHMyYTBFTWhs?=
 =?utf-8?B?anBGUWRlMFFWc2ZsZlBsU3lUNGJ4NEJEWDF0a0VidTQ5Ry9naThNL2pxOE1P?=
 =?utf-8?B?Ly9PMWR2Ky9vK0loN0d3ekw0UWU0MWpLWTBqNkJ3SWZ3b1BoMkdjc3ovckhs?=
 =?utf-8?B?NW9vK3grL0tURjRsd1hNYXF5c2VGdklKNDN5ZDlEYm1VSFMxYm5Semk1TmNa?=
 =?utf-8?B?TGVpYmhzei9GbVpnUWlSc1dFays4U2Z0WThPUC9oU1JNYW9MN2VJWGcxNE9v?=
 =?utf-8?B?MUpBS3FtUmtzN05DNFJNUGh0akF4TkxTQzJGZ20ydGxMNHc0SEgzSlR5eXVr?=
 =?utf-8?B?ZlVYWEpLMXhOSUgzbm5BRm9LRzgvVDBmditHTU5GenhrREhjZi9wdXFRQTZJ?=
 =?utf-8?B?MDlzMkFURUxpL2NNNTNUVjVVV2pjM2VxUHM3YlZvekU2SDNTSmhTbTRkU0g0?=
 =?utf-8?B?MklSZGJTd29NSTl6aWVtbElxRFRGUExIUWVlSUlOc1RBZ1FIbWd1cUtVamR0?=
 =?utf-8?B?ZmpYYmtDTnFGejNOZ213SDd6NXZqTTdNOU9PWkJXeWdNcm4wNjJCUXcxN1Ns?=
 =?utf-8?B?V044K2JGR3ExekIxckhaanAzMldZQUhaS0xUT0lLd0s2bC82TGhQNFNzcE1p?=
 =?utf-8?B?MEJVM0lnSktadFdyMGd4ZnJIeUgwZlFjNU5va0J0R1FBcXNZb0pTL0RFM3dQ?=
 =?utf-8?B?QkJ0ZktFTlczNFVUQlVqQmRRU0VtVXpSMmFXYUsrNTN4RjB3cklacllyZCtR?=
 =?utf-8?B?U2JweWVZdTZHaFBXaklKcDFKc1RIN1crVDJiMDNKTzBpTGNxZi9HUEIxRkRN?=
 =?utf-8?B?NlRJYzNBRVFaRDZ5WE5oT2Z0SGNpT25aN0dTdFAzUzUrSzRzZ2lWSFlqM1F4?=
 =?utf-8?B?YURWd2VIQ2E5RDE1ckthUTJCdmJlNE0wK2Q2T0ROT1cvbVdYa3VjdmlxTTlE?=
 =?utf-8?B?eFAwVHJLTU1mRTA2U1RNZVZsVkg0WWxDOWRsMGhzQUtmVnZiVWlrSnBpODJY?=
 =?utf-8?B?NFFudHVRUU1WN25uT1RiRXV1dmJqbW0vblpoZ1lBSjZnaDl4S2dmNFkyaDhv?=
 =?utf-8?B?SlZxcGJpM3pIaU40VEFjcHd1L0FEcWFPWXlzcVZRUTF6Mm82VGVZSzNXTmgz?=
 =?utf-8?B?bzl3MUVCdzBsOVVMVE44L1BkVmxWWjlTZUVBcVVFYnpMVTBITFRhVDNaeGFI?=
 =?utf-8?B?NFkrcWI0S1REMjgzVW9PTzZxcjRUcytFcXlTVlNHaGRWRFlBeFg4UmtYV3dL?=
 =?utf-8?B?L2x1aGczaHhRNFBUV3BGVmR3Y3EyTVEzTEs0VTlaTmU2Sm9hc2crejJ4eXBW?=
 =?utf-8?B?OTYxUzI4dFA2OGdYR1I0WUtGODVzelRJWjFEbTEzaUpSaWc1N2tlaWw1UWhn?=
 =?utf-8?Q?P0CjeYKvsKmVch+qA8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWFSMUhCa2ZLbXVWdmRqNFdENW94UEtSVmRzczlKZCtrUTBoUzVyY2FVRFhu?=
 =?utf-8?B?VUl2TGE0ZFdOWXBDQ1cxSFdwQ2ZSWHZ2amN0aXd3L3UwdGxTeWZ5cXFFQXFp?=
 =?utf-8?B?YVAwYUN2bTZ0QzhnT28zbm1DN3U2cUc2Q050YzRaUmZrZk9XczFjdUxzT0Y0?=
 =?utf-8?B?VE4rQmFYbit4cGpHd3JHeUwwdExNSEdqR2lKY2o0MVYzck1QdGRMSEF0enZC?=
 =?utf-8?B?cnFJVDNiRnlIamM1N1NTREZrcjVBSUUzOGREQTFTc3pDWmVDYjRQV05yUjFz?=
 =?utf-8?B?a2lIVXlhdVd2Sm9Nc3o4YndUK1NIZUVxMUJ5Ump0RHBZelhxY2NGNTYxVlV2?=
 =?utf-8?B?R1F4ZENzbEVxZlNBdXArUEZ4bmV5Z0NIaE9ITlZka1lVeWRKTmt1ZjErYzBj?=
 =?utf-8?B?NzdFVWswWm83bjRBM3V4cnNWdXJJSlhoRUVMWmxvL2trczlLUjd4OHFyQVlu?=
 =?utf-8?B?Vk1acjdGRG42MVQvY2hEZE9zYm1GcVcrK2tHNDE4Y3FvYmFieGRydm5nWlFT?=
 =?utf-8?B?R1dGYkdYMG9nZG9oai9ZWEhMMkgvZnhFaCtUYlpNaGVvYzFZcTI1Y2ZtQ055?=
 =?utf-8?B?SzQ5M29rYU9LUytlRHQ4RU9xRlNyM1BEc0FYZDJjV08vTmVrbW1vNHZZVWtw?=
 =?utf-8?B?RGx6ei9jdExDdjNsUThlT2pEL1gwVDk2R3lxQkxtZ0QrbjBUcGJPNkxpM0Jm?=
 =?utf-8?B?V3NTQ1VDanNFWGNTeVhZMVpPT29idkJKUk9yU3dvT1VOMEdlcnk4djc3TnpU?=
 =?utf-8?B?QnB5YTFBQ1ZZdng4TlhSbzlwaEtFOW0rZkpIaGRuVzJvZFVsdTIya0d3V1hY?=
 =?utf-8?B?UDhpeUhtMUI2YzR5VG42UGg0M2VHUGNxTzNqekVWVGVKUTRBcmdLQlgvTnRY?=
 =?utf-8?B?enF4RlphTTROZmdyQjZ0TldvTk1BbjJtYmVWR0N1OUorMHNBc0VCZXBWRTl3?=
 =?utf-8?B?cUxzMDFHa2NJcmozT1h3eXR3bmxvY29CVUR1TTZkaWpaaFF1d2RtRnBUcFY0?=
 =?utf-8?B?c2RiMnB3bG1PRDlZWmhGNENVMXNwK2E5UUxIbVJTTjAwRE1nS3Jldm00T04r?=
 =?utf-8?B?Vk8xbWY3NVdORzNiU1o3R2RHdUxYTVFROE9YeVo5YXV3ekRSZTRkUGkrVDJ3?=
 =?utf-8?B?Mkh1SVNJdkllSDk3cFR5WEVyYjlNMytMempVZTR4cTB0YXRKUVR6Vkcwak41?=
 =?utf-8?B?bU53KzM3RThDdjZQdlNwSXBmUE1GQkU1bmQ4QUJUWXhGY3cxVFFMTTNQN0xK?=
 =?utf-8?B?cWJIdUJPeXYzRXdrUllVRlRCd3BQbHBYV0dMSWFTeDBSdE4vMysxYlZ4TjVz?=
 =?utf-8?B?a3FSVHhPUGRMdlYySDlyYUhwWVlrbEZxVFVmL3RScjdlZjNNR3pzUmJYNDNm?=
 =?utf-8?B?a1BUcUYzbVdrdzBTRDhJcXRiWUpoUjh2bDNIeVJPUnlOZnJRc1pOWk5GTWRC?=
 =?utf-8?B?NmRua2FzNDU3ZWU4MGM1aU5jMThxUWNhWUUvRlg2M0tvckVLTlRld3NqWkty?=
 =?utf-8?B?b3FVY0kxQmtra09KRVp6Qm0xRm0rR3lqcTM3REN0a2tZaUpGdVJYMTJIWEtV?=
 =?utf-8?B?ZHRJdmdOM3E1M0JXK0JycUNRWlhKZi9nZ2lYVFJXN0swR1h3YlZHZTVPSm5E?=
 =?utf-8?B?Zk5HSENEaUtpc3VKMWh0NVQ1RWlRQ2VVZjdSU29zTlpWOUx0VW4vRXB0Y1oz?=
 =?utf-8?B?UDlES0ptNi9Zek5WeERIK1dySW5jT0tDR0Znb2VETXJHRThCOThnSlhFSnZt?=
 =?utf-8?B?VjJpTitPN29RajVra1JvQWxOUEk1R1VIdTBpbS9zTnF4K21VZ1RxQ1RvazRX?=
 =?utf-8?B?SWFPM0FVVnFPaFp2NnRmUXBBWERhTmMvUlN6NkNpeUhUNk1uUEVOZ2QrdzZj?=
 =?utf-8?B?bkFGTUVWeFh3SXhCeDltRU9mN2NVaHNxSUNneG9UK1I5NFlvb3VBTDNtZFJj?=
 =?utf-8?B?RTlRQ001T05hTnFVRUhmMUNKSXVZN2xad3RtbEs2NHRMY0dsZjhXNkJjZCs4?=
 =?utf-8?B?eGpXeUc4VmVYWUExdDVxKzNQaDRUQXFyZ01DQnEzQ1pmZTJnL3lad3lnSURk?=
 =?utf-8?B?R1h6aVZGUEdRUVhSd3hDQ2wrU2NNbDF0VTNQM3dnSnZRVlZzenRWR2NrMmZM?=
 =?utf-8?B?TERXRGF3UXhDR2dnZ0JjNTVFdmFYdURmais3RWtKb1hxWk5DS04zK0NmQkZp?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfca6de-221c-41f0-32e1-08dd0892ad62
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 12:07:02.6100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yt7jBqLTmxlZHOW82rRMYax2bWy42kSPwIND265x8bzuc3bPJqVYEf58c55tHTCKv/S7/e8XDl7rwNwtwxJHGLAgstP2M9VRi8YbAJ8dDAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7534
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 15 Nov 2024 18:43:01 -0800

> On Wed, 13 Nov 2024 16:24:23 +0100 Alexander Lobakin wrote:
>> Part III does the following:
>> * does some cleanups with marking read-only bpf_prog and xdp_buff
>>   arguments const for some generic functions;
>> * allows attaching already registered XDP memory model to Rxq info;
>> * allows mixing pages from several Page Pools within one XDP frame;
>> * optimizes &xdp_frame structure and removes no-more-used field;
>> * adds generic functions to build skbs from xdp_buffs (regular and
>>   XSk) and attach frags to xdp_buffs (regular and XSk);
>> * adds helper to optimize XSk xmit in drivers;
>> * extends libeth Rx to support XDP requirements (headroom etc.) on Rx;
>> * adds libeth_xdp -- libeth module with common XDP and XSk routines.
> 
> This clearly could be multiple series, please don't go over the limit.

Sorta.
I think I'll split it into two: changing the current logic + adding new
functions and libeth_xdp. Maybe I could merge the second one with the
Chapter IV, will see.

Thanks,
Olek

