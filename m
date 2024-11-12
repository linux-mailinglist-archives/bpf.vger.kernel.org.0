Return-Path: <bpf+bounces-44646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F24A89C603D
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 19:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F75FB3EC68
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 15:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085A2200B9E;
	Tue, 12 Nov 2024 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijCz5dgw"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F29200121;
	Tue, 12 Nov 2024 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731425040; cv=fail; b=sMx98H2PSIk0gFH9JGQH4OndK7gSX0H+cxazT8txt9xhZR27zYS6+DiwapYb6EZgw+huQHe7WYrFqEkQ7yq4ZtsfdPR58+CzWiasROshZLXp7Wvqc8ixQM1emfRjdZWdB0zgpc7XX7bh85zYv7Jjg1upoX9BzDpTRwh/PPCInj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731425040; c=relaxed/simple;
	bh=qFTkl8/5rV2HvOUjBboRoln7z2SkDB+PmNcCkjKn9uQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lUQ72wNgYbDhdHRKisJrZNQWzmx9woBfDDyw1TFx2MqtGFh4lvyyR3rhN4oLwc5sMFHTwCeOvBlV8Yll3Mj7xSKpdPN1GpI5kMfOk1s8ltnbOxqOijaGakAedDmyhe5gGmwvufQ/O/wUUdi8cXPx0CJG00LHLcF9kaZlAcu5zCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ijCz5dgw; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731425040; x=1762961040;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qFTkl8/5rV2HvOUjBboRoln7z2SkDB+PmNcCkjKn9uQ=;
  b=ijCz5dgw5fg+5XuxCU/Tr8m+Fo8JVEBQVOF5C16j4fAX4WdBTwjh/b2o
   laR6SBOMqQlqiYW1UELxihDR4hcS3J50FcUYhPpEVeYk3RqmuKzlW12PY
   eUI8BtepJXf8dY0yLkUewltFWAuMpWextfnO7mrYhOt7kXGZLje93bktP
   uPQqrVqWsal5ryLd4NGuXvybk13Lb7lDaNMNj9I/kkf7OVWTm6GNW3arS
   ti4Os1LuCoVjmjbrO2/4JUD/PBHzlWq1HV3ZVLHUtrv4l64E13SEeEdMq
   79aO8LeM4HjF7EWlPCmnHIH8YXn5+fho9lZuJbL4FZRGBjjwshD0IeS5p
   g==;
X-CSE-ConnectionGUID: ndIytJD0TM6dO2EpkC26Zg==
X-CSE-MsgGUID: 63LSQh10QWiPBJhFsOSu5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53817544"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="53817544"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 07:23:59 -0800
X-CSE-ConnectionGUID: MtXRNQLOQxemSFk3wa87vg==
X-CSE-MsgGUID: ktlfZVg4Tduq8BW77GYh3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="125017740"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 07:23:58 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 07:23:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 07:23:57 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 07:23:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEjCBY4sq6nvFEvV2otOHSosxsz/uM1MDA3CaZbwUYQWDcpgwTdHEYAbFrsjNbUtdV6hTBHw/gnvQquhiJdXbP3F8FDho3kjp8tKa12mBsSQ73qwabZWZRl2o2gYtympxwNHW3lbM6KbCqAwdfsOLdZVs6b0TaPNJ46I3+3EkgtBpSVDEQPzues3D+VH6EXWvgmhgYx/dXrzocSdWONEj1HvtWK/6F6h/eMQwcT/TzCsZtOJr/dR7bgCCphnCpGL/+veoCbFN/y2Go3EZuhM5bgLb35Hm//CB0DJUKhC7WRJbu5cAAm5z1knJxHoYX/vzmK/RSuFyFI4D2Gx0IsaFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xV+z9b4I5QpHgoznQEqTftXkPW5E7+i2O/38F7KPC8=;
 b=Ae43iM/INujQKrHUNVEiC7ArWPCIF+t9Vp2jgo+uKk82XAt3ei4xpnEpM9+e3c5SP22xohxNm/yOGjZMEWmTlled/6wFhtwBOpZq5EvAZaEM/SY70g68rbaCBFocqY9uHhbPnG+gr5rbQWmPhM2hMLAWvrxYiyrc1q1i8iXd4Pa7e+OdsqhYaWagHkXW2Ge1MW14ovrCqstjW1NdQbHyB2olf5C4vMTQ/q2cVrIBh6dBEvburWbsHHRhypxSY4xMp0ojNaDBHESGJ9w2kAdvbG5x2B9PkV9Cued8OxNgcv6hsGCJEzfQAul+8V54+oB6EOvD/0TNI3Nj5vDbxj8PzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB4975.namprd11.prod.outlook.com (2603:10b6:a03:2d0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 15:23:55 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 15:23:55 +0000
Message-ID: <32c8ef18-8c9b-4580-b064-2ed9ba25772b@intel.com>
Date: Tue, 12 Nov 2024 16:23:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 00/19] xdp: a fistful of generic changes
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
References: <20241107161026.2903044-1-aleksander.lobakin@intel.com>
 <20241108082741.43bf10e7@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241108082741.43bf10e7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0026.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::10) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB4975:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e89e8d4-02b2-4796-8f0e-08dd032df9d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UE00OE94SWVyNSt3V1JhOG1zNnhPLzFqNG52UThKZ3BXU3JTTWJXNy9NUjg2?=
 =?utf-8?B?TkhPZi9CaXRKK3FUdTFub0VPK2pjbHBJWHFvY0hFcHN1THJoUTMySXNVUlhQ?=
 =?utf-8?B?Qjl2QVZqM1RNdmtySFQ5aHpOWnlqTnMvNjEzaVNOT2lVYkZaQS8wcS9tdFlC?=
 =?utf-8?B?T0plNS9NTXEwOXRScFh1cnhWOEFvT2k2RzFpMzNqSTJKM3Y2aVd1U1BJNWdD?=
 =?utf-8?B?SzlNeURkZHlSeFVUUlNpL2ZVMHhVZG9HZ1FSSWlhdWNjTldxTnAzakJJRVVn?=
 =?utf-8?B?TlpWSnB4a2I2dkxhbHNudVk1cDFLM3dONFoybHo2MWZaL0h5eXJRajh5emNq?=
 =?utf-8?B?NlA3ekNyNWdEYjcvMVhvcnlCalljTXQreEpUMTQ5Z2xHV0RyQVhJOW44T2hi?=
 =?utf-8?B?RHdha0JUbnJlZVlJMG1YdlZiUjVZU0JsVnJMRWF1a0pWN3B0T3NpNlpyWTI0?=
 =?utf-8?B?RzhFcHVhK21vMjRtalEyclNmYWR3OUNiaTVkdkZLY2w3cXNlZjdsWk81UE9P?=
 =?utf-8?B?VkluUkJQcXI5WTdGTmkxVmt0SHdYYlIrNHZVSVNEM25ZTlFnVFJOUHBLbFBw?=
 =?utf-8?B?bkcvUGNzeFJLRy9kZ0JUUVhCaFByd0Z2dFY1OVVaSDdNK1RNckY5cVFmZlA0?=
 =?utf-8?B?MEMrZVNiT3RPVTBhandFVWtBUW5hUitNNzkxNTduWlA5dTRsNGUxcmZoM2lL?=
 =?utf-8?B?RlE4V0V6Nk1Gb1hIVWpKUHJHVFFDN2VMeXd0TXhzSnFQOUVJS2JwYm9TSmVF?=
 =?utf-8?B?MHVYdlFJQVFSajJFT3pSbkxua3lHVE9vc0srQXFJWXpjWERUV1RTbjhLN1Uz?=
 =?utf-8?B?TTFWWm1ZVmpJSzRoM1RpU1plTnl5K0VLMGRZNG1zQVFCZTZOc1gxYjZtcUJ2?=
 =?utf-8?B?ZDFUQWgzQkNndW50TjJGWVY0c1VzRXNVdUcyWkhqZmZ0UTFudDhkb1ZEMzBE?=
 =?utf-8?B?V2lVQWErT1hrVWFiMWJ5Sit5RHRTaUxnUnoxV0hFenVybWVOT2tiQXpxbzJD?=
 =?utf-8?B?STRUeVI0ZktJVU13Nk5xWjVONU5KUmpaS2FHejJZaXBzeENUazZtVzJuOUJW?=
 =?utf-8?B?WWJhLzRGWkVrVWNQbE9vK0xzZE40bWo5WUthOXBFOVNHTFRKaHJiUUV4NmRr?=
 =?utf-8?B?L0l5Zk1PeTZWN25aK3NhZERtY29VWkEvQXFLS3laeThPVkFlSVNmSEltQnhD?=
 =?utf-8?B?THJ0ZUxWa3U3RWk5MTZmbFZuZnpWLytXalBDSTlWZm9jbVlIZERLUEVaM3Fz?=
 =?utf-8?B?Smtrc0pFenltTElzcFJ4N2tlRFNldWl3UlhwR3p3emdHOFNFM0wvd3FtZ1Y2?=
 =?utf-8?B?L0U2OW9hdWdlL3V5OWY4Qm5JNHJLR1J5NXQwVlpDNFp4dmUxVnZnNVkxZ1RY?=
 =?utf-8?B?cjg4RVIvK0gzMWVKQko5bVBObjNsMytSMVcrZGNwaVYrV3lRYnkyek9hdEN3?=
 =?utf-8?B?NUMvV3dPMWl1T3JmVGxjUWFueWZVeEFiVWtOY01IaStMRTVxSzlIelpjbnlh?=
 =?utf-8?B?SUU2cmhDYlBMK2FSWldPamxNOUR1WkFVQURobGpBMXpha2pMYmUrQzJPd092?=
 =?utf-8?B?VTBqd0xNQXpHSnc4L2lsTW82SU1kZHFNUEJ4dVlXUUo2endBdWQ4YXdYSUU2?=
 =?utf-8?B?ZWRJSVo4SElLWlJob1BKTjFrSG53TTdDRStwMHhKYzZCd0ZDV1V1Z09uNWZi?=
 =?utf-8?B?emV6SjBjN25xTjVXbktxY1lvNnMxQzcwd3hHOFJIMUQxZkRUNFNKNGdqYk5D?=
 =?utf-8?Q?oFA179TY5uKzFq+QHqInsgira0jxn8vyvQINLGD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVBpY1YwZTJPRlNlTUhkSmgwTFg3ZmxWbXA4WWVmTklBZWI4SHdUbzZ2QlZZ?=
 =?utf-8?B?blk2R3FYNUJDdWxpSGh2VmxmbG1iUExEQWVEdWorL3lMdXFOek02K2ZobXhY?=
 =?utf-8?B?YkN6WUN6YklJWW9VV3pVdTVKNlBIUmpRS0Y0Qk1hdzA2TnJIU1FwSnY5SWxS?=
 =?utf-8?B?T0tnT3NxdC81OWFLTElnK2Y0V1U0ZWJ6N0FLNEpMY3Avc3lxRW9UWTdZbm11?=
 =?utf-8?B?WkFwQXpySkVtU28xcEYrcWZDY1Zpa0pqcnZXaEx5c1BHNEtFZm9VcHZqdVpt?=
 =?utf-8?B?NFgvTC9BQThqMDlneWRZNFRPcS9nRjY0Uk16TFdzcmZENDZXU29pSU9FSzFw?=
 =?utf-8?B?MTlGSWhMRllla1IrSmxGWURlUFdCelJ1b2Q2bzN2UmlTVUtwcE9WUWYyVStv?=
 =?utf-8?B?SHh2V2Y2RmlzK3FQSDNOemxrRktMcXBnVUVub01XUXQ1Y3dMZXhUaEw0R0FE?=
 =?utf-8?B?L24ySjQ1WjBycHc5QnFvajJXRnNaQlNMRWtxY0VrcTI4ODFQalFMM3VBaitB?=
 =?utf-8?B?TFZidzIwZFBrUGszTmdoL3VpbFVNenhnYWg0Sm43RWJkRHR0YWtNb0FUMmN6?=
 =?utf-8?B?SWttc1ZmRW1MZUo3SmYxU0xQdWJFVUNOcXpXQ2VBOEhuMnpqQzhwYjA4d2Z4?=
 =?utf-8?B?SEVLTWtWaW9tTVdmYmdTeFkxcndicjU0S0NCUTVRZE13eUFiRXNrbWtSRHQv?=
 =?utf-8?B?cnF5MVgvaGhmZVd5YjQrK1d3RGNlM3BZbVpKc3BrOWJSTEswQ3U5cE9KaVFP?=
 =?utf-8?B?UFM4WThnNzBPcFRyT1ZGc3E5bXp5TDdZQjczSHhOK3M0anZtT1gvUmY2V3Ra?=
 =?utf-8?B?UUtjYnZnY2lMeTVXSnFjNVR3QUtVa3U4L29jZ3ZuSkpIejRDaWQxYm1mU2Va?=
 =?utf-8?B?MXVpV2xDRGhodjA3clQ2MWhLeWFHTzFhd004WEM1THpJajRGWFhXN1U2alIx?=
 =?utf-8?B?Mk5XZXlTZFNuVEJjZUk1NENSNTMxcG5MUmU4WkZNUkxpNHNTRUNPY1pGUEFK?=
 =?utf-8?B?Vzd4UUkwSWd1MjJNeE1ySGc5bDQ1d01YWDM2UXNlZUF6K3h5RjFUZnpVTy9N?=
 =?utf-8?B?Z0R5R0l0MkZUdlNaeWtsWXRMTkVGOE9MVGhuaGIwcnZjb2VXSkd2UHgrdUc4?=
 =?utf-8?B?akd3TFdYcExyS3ZVQXlROXhpRnBKOXkydytlYzdsSWZnUU1UUmtndmlxQmJM?=
 =?utf-8?B?aEE4Um9sbnBkVkZlVWJuSlZHb0U0U2dCMnB0eFRKQ2gxQUhCRVI2cmhaaDc4?=
 =?utf-8?B?Z1hFRUZrdGlkWlg0clJvYWlNcjVKV1IxVmpiTy9xTW83TU9PNzhKSm5ITDlC?=
 =?utf-8?B?ZW5Dem5RRzVsSno1elVHejNPTXNqWDE1ZDJZRHZiR1Z4M0swNVRWWG05SHFs?=
 =?utf-8?B?dnJTWEF3TS9Wb2xYOGdlRTBGL2pQMkNHWk9OTktTZU1penQ2WG1RMW9pTnJ6?=
 =?utf-8?B?cXNLMFVYVm5PZlRPQVRmVVlYb1VyQmJGbmw2SmcvVlczMjVGUGs3WjJxVU5N?=
 =?utf-8?B?L29EbmtWRWFVZVhYbW9FSEFNd3kva1dkYm52TTVtNndOT29YUmhkSWlIelNJ?=
 =?utf-8?B?eENaUkFkZmROV0VPbElxOE9HSGdocFQ2SE9ldkVndjJSRW9hVWQyd0ovcS9u?=
 =?utf-8?B?b0ZQNzlGYjFWejhLVFRqaU9jV3grRk9CV2tKV0UzNC9CeWsyQzRYMlhsRFVk?=
 =?utf-8?B?UkNJeGc0TWpPeEkvd3ZpQzJGNzliWWwxOE1vY1JrQTAvOWsvNkIyeGdBUHkx?=
 =?utf-8?B?N0NsQ0RxbnZ5ajhCdVN4TTY4eTJMNHlSZnNMbDdwSnV4MUk2SnZuWkFpd0xj?=
 =?utf-8?B?RnBvUDkrUlEyT2ZoYzlWTE1FYyt1S1YwK1VlWGtMVWVjOHYrZkJvZUlpTVRU?=
 =?utf-8?B?Wndtbi92MzNsb0l0Z0dQb09vWEtPZ2tET0JxTWZIK1ZKM0RKMXFDS1Jlb3gw?=
 =?utf-8?B?VmMvQS9RcWgyUThLd08vd3BlTUE2eEdvQkFBaXdOWmlUODRnb0ZaRFpXNGI5?=
 =?utf-8?B?cGgvZTMxR3FQMll0QzRRQWNrcmVrV05xSlh2Njd0djE0UjVEeDZyektXZnc2?=
 =?utf-8?B?dEp0djA4d0hTQXdtSnQxMk9IcENEWTNUK1N5REQ0bTFta3dHdE1MQ0JTenZo?=
 =?utf-8?B?dGxPVTF1OXRxRjhYaVg1MGNiMTlSTGlrejAyQ2hhYmdUYlhGK0pZYWlxb2Jq?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e89e8d4-02b2-4796-8f0e-08dd032df9d7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 15:23:35.9358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPgGok409mDAXkmEx00DApkZwoFJ6SSGy3ZYdgespQM9VWCVeEfsCU+yffmmodvDF50ugZi6rM5OZ4ageTW9pCXK4OrMT4Tt82STn1z63Dc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4975
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 8 Nov 2024 08:27:41 -0800

> On Thu,  7 Nov 2024 17:10:07 +0100 Alexander Lobakin wrote:
>> XDP for idpf is currently 5 chapters:
>> * convert Rx to libeth;
>> * convert Tx and stats to libeth;
>> * generic XDP and XSk code changes (this);
>> * actual XDP for idpf via libeth_xdp;
>> * XSk for idpf (^).
> 
> include/net/libeth/xsk.h:93:2-3: Unneeded semicolon
> include/net/libeth/xdp.h:660:2-3: Unneeded semicolon
> include/net/libeth/xdp.h:957:2-3: Unneeded semicolon
> 
> :(

OMG, shame on me >_<
How did you catch that? IIRC I didn't have anything in
`checkpatch --strict`...

Thanks,
Olek

