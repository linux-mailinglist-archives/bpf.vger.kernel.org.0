Return-Path: <bpf+bounces-42637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9A89A6B78
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 16:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C871F216E0
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 14:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924A21F9EA3;
	Mon, 21 Oct 2024 14:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPO0EOc5"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B9B1E5705;
	Mon, 21 Oct 2024 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519301; cv=fail; b=b3HCe42N5g7XI+FwIb81kryhfAmcGQ4ViP3IvXi6PS6VdL/RxQEfd5pg4YyS4nVlIa8VzUyxhAOh98sir943wqygjbYPO6x+87ZFcWbcUXqyvn3oXjgz1PgX1BZPrN6uTfr8C+gnRd0G+cc14x2PhtX5c+TjY1umFVzIBJ3sPCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519301; c=relaxed/simple;
	bh=0xO0GRELvq2GRX4+uq0YmnT5Xuel/BTMcRIfume+H2c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AmS5cWpx0ttXw9Hn/jLa6JOBfMnnTsEObKAc/BJzADAzo2ooC1HaqMf5k9D2v1DBnGmjdGPmMrgc/PR9j2gmGTZaZ5ANqVUoW6QgvqDl3yVn/K+OIxXFZ+a9oUw382yZopW8LwPgRQW94Aesxr9tMKK973I0vPBPUT2dP1E0Zbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPO0EOc5; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729519299; x=1761055299;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0xO0GRELvq2GRX4+uq0YmnT5Xuel/BTMcRIfume+H2c=;
  b=JPO0EOc5mnhV6Cvmv8dq51imDVPUGWvMzkS3XRH9I4jMhdnHZUL4RLeM
   YoiYSDD+OrlIp2m1BrbvvKlQZfgIrbBMAYcih5MCPoE2saDxU4gjwnGGl
   gU6rrqZo9zL7olEFhSSHAv+D/oOe8beK1xZgCfK8COgY3kL2Dm2KuUyIS
   Gej44qUQPfr7mX3V8xLJyhHifAfxLEyFuFQc5ztZkxoOPzjgEE9zhui7o
   vAeNBULRz7xs8e/gUmvcnqosp5ZjUr97+9G7FF65Wjx9roM2HhvLFgkDY
   NhoXUf7ILEtJGaqJjFvbPaT8HHTFmt3QhlX7LH4F+EKM0VIBqmCh4rJO5
   Q==;
X-CSE-ConnectionGUID: KTvXeTTxQ2GZLTXrXMMhlA==
X-CSE-MsgGUID: xD0TktOaQuy45pLN+3O2dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51550238"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51550238"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 07:01:37 -0700
X-CSE-ConnectionGUID: Jz42PffuSTS0vRr4ypFQTQ==
X-CSE-MsgGUID: 2u0wd4K+RGyzaPMEc1EIIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="84596034"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 07:01:37 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 07:01:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 07:01:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 07:01:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1fnmajEcinoXcQTBAIrAT9nkgpaCQYY6sCqpZ/9+07uyIXsASV0u5oyyILy1I1qpDCoreXe17gHcTVb1sxG9QpRKl38KQvjViQzQv0JcVkKl4gv6Md/KNN5i/4v9/Y+4WU/0bmrRoX9Jjbk9UPaqRTGP+jCBy49dL3W5Bmf7ZHaH8MgwPY6tkx40+UH7kf/nATOoip4Oljz/PE20m6qngfUq74gCL2NKnlZwN8Ntg/HVdM8mWcVhOBAixrwpR4UNxVkuypyrFBtMiScY2Y02mQenjS6HBE2OVIICqxQqJkxa9EfSHB1MlxKoGwVJmLU4TtNoPhj0lmZZQ4+m3ABmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzP8R6o6TKsXh9qOGTT1GoAGmS9YwsWc1LN6cztODcw=;
 b=yXhHq7oGmfcxdCHxvsYOkDZeCRquQ9+UCCZdznn6Kn1EehZbIf80Yo5elrA0hZ0FjnOrQtPRkH8uSedizXa06yGp2pFtOGVeR1EpisNFHKdgtIUkacazOhXzJXLK00jAx6MMB0nWdd6VR/e2xrAjlRAo0e+N+cNxrq2kbFNJ6087hcjcOZKAk2/FJ/nTKAB21elBBTR6JZmR70jUQ22PuIg1lWzhTVUI3cJh3Sm0ppn5KJ+asAmO0DaxwZN22hn/3EWnj+qqp/2HMLSXfFSFltT25DILKRMmdAuhK0eG++DTKhpwkhmK/Gc9oiQW/L8L18b74uTaf4cdQMAEQUfTWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY5PR11MB6234.namprd11.prod.outlook.com (2603:10b6:930:25::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 14:01:26 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 14:01:26 +0000
Message-ID: <6935ab95-c723-4abe-9143-1e7665190b83@intel.com>
Date: Mon, 21 Oct 2024 16:00:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 07/18] net: Register system page pool as an
 XDP memory model
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
 <20241015145350.4077765-8-aleksander.lobakin@intel.com>
 <ZxD1s0UOJy11wt55@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ZxD1s0UOJy11wt55@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0336.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::15) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY5PR11MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: e387ea82-a304-433a-5659-08dcf1d8daa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnRQQ1dDUVFaelVRdmJmQWt5am5kODNMMk9HYVBsbWg3YmdTSVFSVWxDM0tQ?=
 =?utf-8?B?QXMrYjVTZk1tbnBhZFJ5d3U1cU5kK2Jud3h5U1BRc0VkZHF0bkp0SWhMUEVI?=
 =?utf-8?B?Ry82WkI4TWRwUUh2UGxVR1lTSDV5YXpxQkJzTTZRdXp3RGZRbWJnOGx5WUhJ?=
 =?utf-8?B?NWlWMHRGcE02N29aaTdJdEM4cE9PTlNKa29HU3pINXRQbHA0TkY1dUJpNmVQ?=
 =?utf-8?B?SUZ2eVY4Yjdud3hnejd1bGpuYTU2SHpheWtwQVhmZmlMM0RCbDhobHU5dzhC?=
 =?utf-8?B?WStCb1hueExlWWZ2SG1CcHFTaG5lL2Zld0taVWdUZ2x5MzdhZkF3S0pHQWRD?=
 =?utf-8?B?ZzJwakZrL213NnRKSkdueDA4ZDNnNEt5Wi90QzErdGsxbis2THBsbWFXT25N?=
 =?utf-8?B?SkNmUTFkd3BmNmJZZnQ3YUtsekxFVGN6eUwwbFdSQlpOSUxCcHpNY2k5TVl1?=
 =?utf-8?B?dXJUT2lwTTNYaFd3MkgrejlMUUJYeWQvTEEzWVVsLzBuYkRwZ3FYZnZkSG1N?=
 =?utf-8?B?UjA1aXI4MHFMbWV6ZFJEUTN2M1R2NDIxbXVuUXp0TEl3cm85U1d5bVI1U0dl?=
 =?utf-8?B?dDJFbXpWbENOTkE5UWVieEdYMVo1bURhN0tGRFFsSW1rYi9TdWhVd0Y0NDFN?=
 =?utf-8?B?QUViVEhOSnhOd3dFRFUzV2s1YlVDUWFrNStlVlAreWlMSjhOaUlTYThmUDdm?=
 =?utf-8?B?dGZ5ZmpGSm5xb0x6V0FrRHoyT2dtaU1YWmswWGpvTEx5MWRQZHJUVE9ocDNl?=
 =?utf-8?B?blVIWml3NmdFaTJHRGFXL09PcjlGbUExU3grSDFCWU8xWGxVR0RmblFWdDZ6?=
 =?utf-8?B?aGpoZElaODVldUw5Ukp5WW1sa0trZGFBa2swZmpQSnVwQ3ZiYWRDeFBsMjli?=
 =?utf-8?B?cEZDb1AzOG9PK2IrdCtsV2kzNDVGYnYvMy9wSVN4N3pjNUFnVno3YVlieWVO?=
 =?utf-8?B?YmR1RDcrWVBwTTFRRCtNTHcreDVTM1ZncWlzRzhHaDJnTmdmc2VrZ1BBdy9Z?=
 =?utf-8?B?QlBjVFZHTk5hUGlha2VNamovTGw5Wm1xQVFoeWdwK3RqTXFwNFN1bWtkN0VZ?=
 =?utf-8?B?QVorcExvaFFVNURoR29PcGRteTkwdWNwSytYRXlidXorY0p5OCtQOW5jdDMr?=
 =?utf-8?B?eUcvOEFPMnpuOXgxTVp4d3diNXJGYUsrQmVqRWtqV1RoUktYWGJ5QUZYdUsv?=
 =?utf-8?B?NkFUS2RZNUhLc1U2ci9jbzB2aE5zcmt5bWNEa0VVeEoyZ1RPM0RxcTV2cnVF?=
 =?utf-8?B?Z1J2dWVrOENqbzBQcWZyVzVmZnJlRTlDVEJuQy9rVjQ0SzhCR1RsUjloNDA1?=
 =?utf-8?B?a29WaEw4c0R0aEhOdHBmbFpOQ2lUaWFJaXhIQnVYUElURkUvVkhHQnc2SGdM?=
 =?utf-8?B?OEdiajBKSU5kblp0bkJzYklTWUlIYnNSenFHVlZiZ2czaWJraDlaenR1NDJm?=
 =?utf-8?B?L0hIZC91cGFUTGNqVG5TSWlQNDJ2a3lYeWc5RVdrd0NWZ3VFRWlBU1lpcUhY?=
 =?utf-8?B?RXdTRUZ1MVlZb2dQaU9NZG5XMFcyZGttbzVkK2Fsd2tCTlFFakFNQVdVTWN6?=
 =?utf-8?B?bHUxQVNzakFmeWhacVZ3aDVxMnh6eVkxTkt0a3ZHOE9MUkJsM2M0bVlKNjM4?=
 =?utf-8?B?M0t0dVpOcFByWnRRM3VVK1dRY2xHN29OR2owbDBKU2l3cmxIV0N0dWMxdEZl?=
 =?utf-8?B?Tit2SHNuZ0Jjelh5eXJSYSsxK2t1dXBFUUVrSHBYN0c4REZjOUlyRjhhVnhq?=
 =?utf-8?Q?RBL9TNI91CinU/dqEbrV/3QJYVsh92OEn9Zyn+w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkhzQkgrbFk4YUJ0aUNUcFpQOUt6eUpyVmlZUDl1SlRmR0VUamhaN0JkajZU?=
 =?utf-8?B?U2p1RXRBWDNveEZkbFBkMHdxSVN3SThhK2x5NHU1VkpRTVdRQWgrVFpUWmd5?=
 =?utf-8?B?d3FOYnhTTzlQWkZvQ01wdHBzQldOYlNuc3lkWXJ6enZnWEpQVXJvcWlpcEZF?=
 =?utf-8?B?eTZhR0dGazhCTm5obmlpT3RMc1lvZ3RpYmtXOFBmWHVqNFBtRGVnZlAwUHpO?=
 =?utf-8?B?MDZqT1IrMFdDV0dGWnMxMWNvWjBma0lsdWhLM2xpcWJsSVlkcDM2MGFQMndI?=
 =?utf-8?B?NzVYaWtXenNwN3pKZ0lmL0dCa1A1NnZnaWU4WlB2alpJYzg0V1NtZHFmeS9G?=
 =?utf-8?B?N21EUUdteEsvZmlCYUR0NnRwSXZPU0ZFeU5LRWRxN2RoNWVwKytiaEZXTE5I?=
 =?utf-8?B?OW1pTkRwa2U3M1kxeUtUaERXRFBlcHl3ZWJETSsxMThyM3Q4b1pTTzhqdWVN?=
 =?utf-8?B?WXM4YXMwK1g5QlpyQlVlVVZ2K3pleUlNVVIrNUc1UlpQZmFweTlSekl5QkVt?=
 =?utf-8?B?KzNhRm5Ddm9VUEpzbjBMWThYd1UyTVpLSnJGd1hVUWFuRjZheHNvZnBvU1hW?=
 =?utf-8?B?Uk5rQmdLMDNCbVE1WUhkenBLRE9OTytWN1VsNUQ2R3pLd2QrdUtJM3hUT2JH?=
 =?utf-8?B?aitWRFQ0alFPVVo1S0NXcDduWS9CMFh3UThtdkF0dXByL1NPbEhtbldlYXo2?=
 =?utf-8?B?RHhDTmtvUEo5VTJXWnlSc3R0T1hISnRhQ0JBaXdFdG9aMGh4MHNZZWFzZXJP?=
 =?utf-8?B?c01hRFlRSnFQamRyQ29QYzV0UlpzK3RqbUNFQThUT1pzTUFJL2Nydnp5VHJt?=
 =?utf-8?B?UFZnb2h0dk1lUTU4b1hVZUJwU1M1aGZqWjdjdnJTZFA4c1A3THJGZzFpY28z?=
 =?utf-8?B?eEZsSGs3UlI1RjNnbUw1KzBlV3Z0YUg1RVBQaVNXNGMwRk9WM0w0Rzlpc1VO?=
 =?utf-8?B?b0ZDM3BQTUhxMG41K0RDOTJ2a3U1em1lY0pjVzVTVW41UTJZK3NHZ01rSjJn?=
 =?utf-8?B?Z2UxQkFCRVZTY1MvV0VRUHJXbHNlbGl1SExpb2FKNFJnOWVleVFSUmJKRGZN?=
 =?utf-8?B?Q1VrYTQzREJTMjA1Ukt1eTlGOVZTUTBLc1piaDdtQlJaSHZWUlY0OU52bEtj?=
 =?utf-8?B?Z0p4RFFIMUpqU1pFZklidkxZTTY5Tm9WZGtkNXNRdE5WZjUrc3JDZEdVcGRT?=
 =?utf-8?B?SzhvOFl1SlMvNHowWFhRTG8yV3ROdUJidjZxd2FvZHNMQkRVMU1HbTE0ZFhQ?=
 =?utf-8?B?aUUzOGZSQ3J0MTkyRHBSTTcxOUdXL0gvNUszVE9OMFI5WVFxVDRoZU1GSVJh?=
 =?utf-8?B?ZU1JUUNMS0lsK1lYQitlR0puNEFIcWRvbDdjUU9iOHFmTU9nUEZzRnJjUFk3?=
 =?utf-8?B?Ti95TVhUOXNwbVdaQUlVTGhPV0hQdCsvcXhyMDJiMENrZ2hhZVhoOHd4Y3RJ?=
 =?utf-8?B?UENCQnVrMFBNNjRxN2VQRW44aCt1WUFuWTRQeXpMaFp4eVFDRnd5OTg0bVd2?=
 =?utf-8?B?ajgxRXR5SGszYk1CemNjOWF3NjNiTTZWVDhlKzdIRUtGU1duWjJBTlVUbEM4?=
 =?utf-8?B?cHBxS1NMeWpDK3lhNlpIUTMxNzExNUNiSnZyYk5BL1dEaGxrK1pXc3hGMjNk?=
 =?utf-8?B?UWpEWE1SemJCL0F3U2NrelhzVHAwcGU1MHQ0NDhMUC9qK20xQXZ0Z0kzUjJ4?=
 =?utf-8?B?OElIeXNpR0VZSlNRNEVzTnJOekhzNGFETFRuUlhFN1d1NWxFUDBoRDlKUFY4?=
 =?utf-8?B?OWlHeFh3dm5Od0RrMXRSNlNmRTBCbFVjTlJIUmlhYUt5OEE0TlZERlA4OU93?=
 =?utf-8?B?eVBuNnZlQXdDL2tMdjZQSUhaVnN5UjhSYkdOUzdXYVRyNE5FSDIrWWZYcnVI?=
 =?utf-8?B?by9seFQ1OHFDM2I3NEtUMzlIV2xyNlRCaWptWHhOSFc2MU5qdHlsVlhhUDNz?=
 =?utf-8?B?eUluaWpLeU1nWWxxWmwycTFmTnhLN1hRSXNoQmFVVGhyWEIxUXZjRWU0SHc5?=
 =?utf-8?B?WGlremZ3anlaSjdSdEVoRjVvZlRxK0pOQU10QVF6dEhDaCszTWp1MVVXenZ4?=
 =?utf-8?B?YXdadlpOWStiWWdkbk96QlkrWjZ0MlhtS0xNUW54ay84OGlzOGtyVFNFSi9y?=
 =?utf-8?B?Z255TWhmZENoVUpwMnZJN05weS9ROVUvSnBQODUxZW1UUU4xQjB1NUVEWW9r?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e387ea82-a304-433a-5659-08dcf1d8daa7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 14:01:26.6294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/6Zrh373qOcYdwwdBrldNppeqzJ6oQSeqFto1KwGNfH0VZjXVGHFKdr9q7/qgVCJ4pNdElSVbBF2FHuUhYH3hgAEp+pvllrsrnWL7BXjDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6234
X-OriginatorOrg: intel.com

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu, 17 Oct 2024 13:32:03 +0200

> On Tue, Oct 15, 2024 at 04:53:39PM +0200, Alexander Lobakin wrote:
>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>>
>> To make the system page pool usable as a source for allocating XDP
>> frames, we need to register it with xdp_reg_mem_model(), so that page
>> return works correctly. This is done in preparation for using the system
>> page pool for the XDP live frame mode in BPF_TEST_RUN; for the same
>> reason, make the per-cpu variable non-static so we can access it from
>> the test_run code as well.
> 
> Again, to me BPF_TEST_RUN has nothing to do with libeth/idpf XDP support
> :<

Sorry, I forgot to adjust the commit message =\

Registering system page_pools as memory models is needed to introduce
generic XSk buff -> skb conversion (patch 15).

> 
>>
>> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek

