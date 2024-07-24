Return-Path: <bpf+bounces-35548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D369A93B6A5
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 20:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D847B21616
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 18:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5168616A947;
	Wed, 24 Jul 2024 18:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUGjw3vg"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A3526281;
	Wed, 24 Jul 2024 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721845460; cv=fail; b=Sn06KaeczI5V+bB7qRZ/QtsPnVdv3UlYYKAloFlUadbDMkGMYYTge8iUtC4RMXwaGCRdyXEY+8TVrxMUpmtzrvaukFb6hYU5y2p16swx9xtqergEvDuP3t/dix4TjfhW4p8mg38D63z/AyJvIcPMIWZFz5i+WWM+BUJaV5jfcC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721845460; c=relaxed/simple;
	bh=TLoDPUYiJq9OvNM04cBu8BTqn0AaTD+8eNXVfDvQtCE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iceQNU9JYMHH00Y2RRJ3fR6XoMlXggO3+YoWG+smLHu0vDq+u0i+C+Kk502W962J59N/CrP+4C0s+PfpsYrSLIFVq3AeyQK1QgF8sJcTaa2rPS4g/YVV5G8RRWV6G3IR+LygOXjb3pQrVTnJjPMMk1Eoso3nL5yMt083ST26Dsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUGjw3vg; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721845459; x=1753381459;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TLoDPUYiJq9OvNM04cBu8BTqn0AaTD+8eNXVfDvQtCE=;
  b=XUGjw3vgHs4LVVwjgCivZk456ldZOVBXhQ+NRu1RnakfpgjRHafTOPyl
   ejf8hJ5Jwlan7MCQr6IUW6mwN0JWGhLA9p+6sn+hhArzL+IcilZZFjeT9
   LrjBGzIBEWXAFrcCvCjmQ5fq6LVW5QdkLCdJpUKOEzg3Ef/0m0iL/2/tv
   yZNoDcTz/LvueCeMbqouBmrSj6V+rmtbxssRFyfTmPTMUQnrO/ieDhSLs
   iWIlfrgZ+VH69moZ7i9nbvADkkiZ13eQQCVkInC5wTVJMNRnXbl0qnRZX
   3llj7FbmdSiIADVMgMqq0oRBIrv2UlILRtx+Md9AeSZBzuxXOL0NXMmmG
   Q==;
X-CSE-ConnectionGUID: g7hnfoPRSCqM1iiNzQtSlQ==
X-CSE-MsgGUID: sP5RHKQ8SdGxesgxV6lzmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19240955"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="19240955"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 11:24:18 -0700
X-CSE-ConnectionGUID: m3o5Cep/RDaxVkBgt+miKQ==
X-CSE-MsgGUID: j9R55gnAQhqkTI3vNmTCcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="57801675"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jul 2024 11:24:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 11:24:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 24 Jul 2024 11:24:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 11:24:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htxgpypD3CW0ly2W3aD9VdeGSM6eDoEpN9rBQizzX2UiTNklBpLYyHidplmlWr5R2u0r3+TuGo66xDRiasb4SMYJ4hW5OoDnWVuveqjvVaF9lPQifOF6WtlH/xrBunwacAJibxEtkduxMv/xW8ZBwGN76lIinFVsQ3fB40cveS7QuGTkQzilYmE0KQ/UA8xn2oHyVwIBJo8FOmkv0oGwcyWOy1b+0p897iR22D7RA1lILRR1ympmqtDLK0uTgw1EDenUrDVHL5CJAibuMx90Thq7GnEiBjwSxsjtqwkcqTSgUbY+3kF1kn0VDAFoccIUQ3EUXaoqQ9WRRrsr2mTQTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTJirIE4M79jLytrqSrMfqJJiX2O1e2T96tpuW6zCrI=;
 b=k2DhpxLU+NEAKrcCcBMT/hlIk+pmBR2RcASy/UeNhquoqnHi/R0N1D9hovSLxOgZShoOs/65bAE7JRvFr7WySmJtLTrqftdEotcGx3rZTowOP9aFi9Cx3ES825ebl0UCcSAfQC81VyGLrUzCbdUt5caLOp8dnJ2NCLba8Kx3qBXH3XIgzQuyBnwcNxzYCQ8cJ8A3IhQcC1uZJDAQl7hCbuFjQ4rZaroozZ0Zehz8wwO4tIr83g9DtbXyD23JUOuKq+qO3VBP7TmvoB1AeqmWTdl7LekYx8/1jlamBw1xcNHE11UkZGpOj/LbDxwFIK1cv5+Ddq7aVgaJgSaessHcdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5006.namprd11.prod.outlook.com (2603:10b6:a03:2db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Wed, 24 Jul
 2024 18:24:15 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 18:24:15 +0000
Message-ID: <d31bdb5f-8ab8-4bca-a4ca-ebba85d4d9d6@intel.com>
Date: Wed, 24 Jul 2024 11:24:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 2/6] ice: protect XDP configuration with a
 mutex
To: Larysa Zaremba <larysa.zaremba@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Maciej
 Fijalkowski" <maciej.fijalkowski@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, Michal Kubiak <michal.kubiak@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, Amritha Nambiar
	<amritha.nambiar@intel.com>
References: <20240724164840.2536605-1-larysa.zaremba@intel.com>
 <20240724164840.2536605-3-larysa.zaremba@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240724164840.2536605-3-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0228.namprd04.prod.outlook.com
 (2603:10b6:303:87::23) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5006:EE_
X-MS-Office365-Filtering-Correlation-Id: 4765bad6-3513-4b7a-17c7-08dcac0dd2a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXdDRzRLMUREWnlKZ3g3cHRNOFJlTzVwdE9iVnk4UVFoSVF6VjNBRzYwYWZW?=
 =?utf-8?B?RHUvcDg2WFFHLzF1N3dONXVDWFBVdmVWZzMyLzE4V1ZqQTVINnZCa1BhZFBQ?=
 =?utf-8?B?d01NTnB0QTkvTmRFSjB4QjFiNEdGQWRvb0xGTTY2NWxyemZsM1QxVDhLY2R1?=
 =?utf-8?B?M0xGUy9UQ2tlMGhzZVlYbkNnU3FJSGRmc0FyYm90L0lZOWErc3VSMEFlaWdZ?=
 =?utf-8?B?L25mRXc3b2Vkc0NHWW9mV2tjbEFJUms4N29PT2EwR3d0THFVY3dsdVdrczAy?=
 =?utf-8?B?Tld0dzdlY2krd1pZWDdSMzl2UTJ3K2c2Qm1HaDAwRUYzVFloY1dxU2J3aTFh?=
 =?utf-8?B?anBtL2dVbzF0Q2pxSkFKWVgrN0xETUxtWHd6cFlhcmh3Zm5USGlEaXF6QVlx?=
 =?utf-8?B?YXJwUnhxR0txcWZQMGVCN0xGanN6RHlJaEFJbU9WTjIrS216Z1B4dmpCYlR0?=
 =?utf-8?B?MFM3My9VZE5YRHdSTHcwOW1zSTNwanByRXNwWWhDNEd3eG13SlN0MmdOVjlv?=
 =?utf-8?B?T3YxL2dlVksycWpKaUJyUVZxeHZESU9yWVFRcU1iMzJmMjRPbC9VcysyUDll?=
 =?utf-8?B?cHFoVE43TWVIWjBpWjF1dndlaDFhUVlld2lnSklUVGZrS2lSSEtrNWdRY2dk?=
 =?utf-8?B?Vm93akh0d2l2amVRbDYrUDVNYUJ4LzFicGM5dUtxdHZUMnJWdlptZU9YTVc0?=
 =?utf-8?B?RHdhV2F2d3lmR0F0eEdyM2trQ2I3SDE1ZjJyVmpsZTNzRUVkUVBPN2ZWZllK?=
 =?utf-8?B?STByNnI4MWMvRy9ZRXRZUVc4aCtrR2JSbEVVMllEM21GNzhPMUY4NVV4cHNr?=
 =?utf-8?B?WGFUL1VNNWIrRjdVT2RiaUhJblNBMnJFVnc2Y2hJTXdQQnVjeDQyR3FTTFZ4?=
 =?utf-8?B?ZkhYY2dNbEdUYWYwaXZRNkNYa2ppbXVLaDBxOE8vcmpCUTFkWWNZMG9oY05E?=
 =?utf-8?B?TUdzbjZNRCtIbGdTdEVYZkloK0xFZW1zTUN5Z0VOWjd6b3ZtTjVmbmhvU1ZY?=
 =?utf-8?B?cWZZYmdXSXRlWHJMNENUeWFVQTROd0dGTXZyUkJCV2NiekdrV2pQOElJM3U5?=
 =?utf-8?B?YkJWR1R5dzk1OG14NFV0UU44bE0wbFhMZHZxcUpPQ3pMZlFXTUsraG1RZjFN?=
 =?utf-8?B?VFdraC9SUk1odmlyUjF2bkFGT1I5RHVBcldZR0pCRGlIS1JzM1d6VTNHR1FU?=
 =?utf-8?B?VVg5bnNYMEN5aHhOSUVOK2xtWUhYZFI2blZ3akpsRFpGNGQwVXpreURndnEx?=
 =?utf-8?B?d3g0d3VlcFRvcSt1QWR1QmQ2SkdPUlM0VUlhdTlpeVZndkF1eWJMV2ZTMWl3?=
 =?utf-8?B?b0Z1cTZLOStzbFVaNXR6MGVSbWNtNDYyOWVLcml4VzJFbElnVHIyQ3F3WC9E?=
 =?utf-8?B?ZlVVWXE1YUZOZ3lLSTgvdzg5M29RRml0TlMyb3g4QnMxcmlsMnNzQWJtazFl?=
 =?utf-8?B?YU04emg0UmlkTTdVQnA0ai90cUMrZmNaQkRYUGJIWUtDWUp1clNucU1qZTll?=
 =?utf-8?B?NVBNdjV4dnVYZTZ1MVRUM2kxcXhyYW5vWTI1OVc4Q3hILzRkaHJCTVFIdzdK?=
 =?utf-8?B?NklEQnZBQWQrZzlxa3Q0b1JqUVJUYkovSFUzZjBtdjRxSTB0dGl2TElUWXBt?=
 =?utf-8?B?UjhWMkdqbVBueVI1TEkvN2JpdXIzaUJQUEkraWc5SU5MeWFmOVpidkZCSzFS?=
 =?utf-8?B?S2NIMjZoc0hIZ2dRQi9IZHhsQ0YzWk9IVHZzL3ZUVk12VktQclVLRHdBRmNK?=
 =?utf-8?B?eXpVUUJmNFlwWklmMjlSSEljQ1FzU0NicWtXZU9jM3Z1V0tzcEs2TUpKMW8v?=
 =?utf-8?B?Mm1TaFluclQvM3pUcVVtUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXA5OUFKUVZhdnpYbjNTZUpLelFDTXR5OUd6UUZiMU1LZmpLTUJjSU1WNEIy?=
 =?utf-8?B?MHJ2dXVZUHlpejZ3WFpUUjRraWg4U1ExMlc4YTJST3JBUkVhcnJ6bjMwMUhu?=
 =?utf-8?B?V2RFQ28ydk5kd2ZpVlBGcWdqUzhvaG9RYkl0ZXZNNGhMeUo2c3Q3ZVNJblJB?=
 =?utf-8?B?ZXBEbTczRHJBaTVmWEkyWEwvNTJtY2szU0VFZ1VXVWlZTkRxQUplZzJHRHZh?=
 =?utf-8?B?dmlFa1hZOFdzYy9SR3VQYW4xTUYwYytnMnpyaE8zYU44dmRNUkdSdzNPQmtV?=
 =?utf-8?B?dUVnSmJkazFxNHV2VnlXMlVoUHNuTzYwb3MwKzFEZGFmcFdRd3lVSnhrVUlt?=
 =?utf-8?B?VENzbUlmV0MvYmV4dEN5RHNmUjFxaFFQenVOeUJVU3NWcGJqRVJ1QzJndUhN?=
 =?utf-8?B?RlFxeG5ZNHA3aHpCakJkTHhsMHhyc3lsdkNxQVBBWW5sSDE3bFE5SDhzQjUr?=
 =?utf-8?B?cDAzSWxUNWZaY0pBekZXWnVQQjdWcTVBUHpRODRVSlpFRmRtVWViOTQ1akRI?=
 =?utf-8?B?SEs4RTExLzFnbDExYWNUTzVXb2RLbDU2N1B5N0paOVptWVpJR091NlppSTFj?=
 =?utf-8?B?b09QM2c1QWJuUVdmZnlhN0FqMkVPUHNxd0daWFliRDg0d29sWlludjB0TnU3?=
 =?utf-8?B?cXMyMUc4MjZWWUF5a2pYVTFmcUVMOTdVSFdVcjRSZUFQUlV4V1kwcE1XNWty?=
 =?utf-8?B?NkEyd2szajRDUHA5dWNCVnEwV29VSVNNSHk5QnRKdG1FdnFocm5YTXZ6SThz?=
 =?utf-8?B?dlFXSHNlNXkyRWRlRXovZUc4N3lQUGNhdzZnenY0czg0OVdVMzh5TU9yc0FQ?=
 =?utf-8?B?SkticWg3d2JOSlg1VC9oak13eTBEMDY0WURmMnphaGR3RGx4ZnVyVWVmUEhG?=
 =?utf-8?B?Y2J3bDZPUE84cGpUSFJBblI5Q3E2a3FWbWl4ZE9XVEd0WkxUVzMvd2xHVzQx?=
 =?utf-8?B?emZiM01sZjQ2UW1HbU9ZdU4renhWejRKMGRoYkR2ZVl1K1VIYVF2VjdsQkhm?=
 =?utf-8?B?OGVzbnJOQUhnVXhQVGFqbmJ2TnZsRHZic2NFejl5UmdmT0RDYWdwVUFRL0I5?=
 =?utf-8?B?eXJ1cXpEdEoyb3gzaXgzSHNBdzh0S0hKdEVLZFU0RjdHY0YwdFNHQVowendh?=
 =?utf-8?B?ZHNCL2t2alpqN2RCSEw5SUtpTml6M3VVMjUybWdLYzBYNW9jNkZndGZYYUtH?=
 =?utf-8?B?NEpmajB3Y3hmUEVpWWdpb29VaDlSOHNjY2dsSk9jLzVEdXp5YUtCb0U2aUh5?=
 =?utf-8?B?QWdPS2xPUGxzWUtDZnl2TnhLZDBERHJ1S2ZVZGhiTEh6Y29ZanFHbXprSFZq?=
 =?utf-8?B?VHdHKzJneTF4Y2g0cTRHRnV1SVpNY2wvaStneUVjOTMxRzFPVkdIcXlZM1Uw?=
 =?utf-8?B?dFpjNk9ZcCsvOHI2NXF1RWNxc2xxYmZvVi9vSG55T3V2OERjS25ST3V5K1pt?=
 =?utf-8?B?eSs4bVAxK01TNmZnb3pnVkxCUm9EckZMTGNnTm9jY3hLQjZuaWVhMWJVWjhx?=
 =?utf-8?B?YVc5UUR6eC9rNjgxdlJma1hlWE9pUDRHd3FiaHdCYW9xVUZXc2pKVytIVDlO?=
 =?utf-8?B?dFhQL3h6dVhPRlErZmNXQkY2VVJybkRwcWNVcnQzck1pZ3NhTytwSUMwUDIv?=
 =?utf-8?B?a09aKzJyUGJualFBbWtQd0NhTnpKUmMxdEFmNGVFNHBDajB3QmVIZjBweTVP?=
 =?utf-8?B?UkNOT0E5NVZMN1h4WXZGVDBGQzYzZ2RaWTFlQzR6WlZIUVpmRUpETUlxR0tC?=
 =?utf-8?B?NnExV24zZ0Iyd241cndPaHMwVEFBa0h1Z3ZZVG1NcWowc3E0RXFRR1pxTFVv?=
 =?utf-8?B?Z1BZMjFjbDB4dE9NbTJzSnhCVFVIenlOWXozY241bWdONHVMUDJGUzdXU21Y?=
 =?utf-8?B?Rnpkb1VQNmtsMVozdEN2UUJqUmdhYkJCSnpSYzJ5cWlmVFg4algvZ09scWZE?=
 =?utf-8?B?cmNxK3Y4R2NGYW51M0FPRVRPQ3k3eGR3dGx3NTJoZ0lWY3pheFZXcGw2cDlq?=
 =?utf-8?B?QStzMlBzVFRvNWRqcXgwMmc2UzZ6UVdnS2FKQmQ4ZFlwaG16QnVNU0VXc1Aw?=
 =?utf-8?B?VldXSHlXeFFidm5aMk00MEpoMklQNjNPbk1TZm5MNzlad1RuaXZmZERhWXBM?=
 =?utf-8?B?NkhwUGtwQVBzcTMxUzcvVFR4Y3hXNlZQS056eWFnK2dyUXlEa2trV3lXUzNZ?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4765bad6-3513-4b7a-17c7-08dcac0dd2a7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 18:24:14.9648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwCV5UMITu8rTMEWQK/bwse4+TEJiDk7HI6aYlBTBF0TQ98vYZyky1diX2R9IM3TgzUF5PzZRco5vH+2arABOJgSCtceM/S7hhux542RYi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5006
X-OriginatorOrg: intel.com



On 7/24/2024 9:48 AM, Larysa Zaremba wrote:
> The main threat to data consistency in ice_xdp() is a possible asynchronous
> PF reset. It can be triggered by a user or by TX timeout handler.
> 
> XDP setup and PF reset code access the same resources in the following
> sections:
> * ice_vsi_close() in ice_prepare_for_reset() - already rtnl-locked
> * ice_vsi_rebuild() for the PF VSI - not protected
> * ice_vsi_open() - already rtnl-locked
> 
> With an unfortunate timing, such accesses can result in a crash such as the
> one below:
> 
> [ +1.999878] ice 0000:b1:00.0: Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring 14
> [ +2.002992] ice 0000:b1:00.0: Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring 18
> [Mar15 18:17] ice 0000:b1:00.0 ens801f0np0: NETDEV WATCHDOG: CPU: 38: transmit queue 14 timed out 80692736 ms
> [ +0.000093] ice 0000:b1:00.0 ens801f0np0: tx_timeout: VSI_num: 6, Q 14, NTC: 0x0, HW_HEAD: 0x0, NTU: 0x0, INT: 0x4000001
> [ +0.000012] ice 0000:b1:00.0 ens801f0np0: tx_timeout recovery level 1, txqueue 14
> [ +0.394718] ice 0000:b1:00.0: PTP reset successful
> [ +0.006184] BUG: kernel NULL pointer dereference, address: 0000000000000098
> [ +0.000045] #PF: supervisor read access in kernel mode
> [ +0.000023] #PF: error_code(0x0000) - not-present page
> [ +0.000023] PGD 0 P4D 0
> [ +0.000018] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [ +0.000023] CPU: 38 PID: 7540 Comm: kworker/38:1 Not tainted 6.8.0-rc7 #1
> [ +0.000031] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0014.082620210524 08/26/2021
> [ +0.000036] Workqueue: ice ice_service_task [ice]
> [ +0.000183] RIP: 0010:ice_clean_tx_ring+0xa/0xd0 [ice]
> [...]
> [ +0.000013] Call Trace:
> [ +0.000016] <TASK>
> [ +0.000014] ? __die+0x1f/0x70
> [ +0.000029] ? page_fault_oops+0x171/0x4f0
> [ +0.000029] ? schedule+0x3b/0xd0
> [ +0.000027] ? exc_page_fault+0x7b/0x180
> [ +0.000022] ? asm_exc_page_fault+0x22/0x30
> [ +0.000031] ? ice_clean_tx_ring+0xa/0xd0 [ice]
> [ +0.000194] ice_free_tx_ring+0xe/0x60 [ice]
> [ +0.000186] ice_destroy_xdp_rings+0x157/0x310 [ice]
> [ +0.000151] ice_vsi_decfg+0x53/0xe0 [ice]
> [ +0.000180] ice_vsi_rebuild+0x239/0x540 [ice]
> [ +0.000186] ice_vsi_rebuild_by_type+0x76/0x180 [ice]
> [ +0.000145] ice_rebuild+0x18c/0x840 [ice]
> [ +0.000145] ? delay_tsc+0x4a/0xc0
> [ +0.000022] ? delay_tsc+0x92/0xc0
> [ +0.000020] ice_do_reset+0x140/0x180 [ice]
> [ +0.000886] ice_service_task+0x404/0x1030 [ice]
> [ +0.000824] process_one_work+0x171/0x340
> [ +0.000685] worker_thread+0x277/0x3a0
> [ +0.000675] ? preempt_count_add+0x6a/0xa0
> [ +0.000677] ? _raw_spin_lock_irqsave+0x23/0x50
> [ +0.000679] ? __pfx_worker_thread+0x10/0x10
> [ +0.000653] kthread+0xf0/0x120
> [ +0.000635] ? __pfx_kthread+0x10/0x10
> [ +0.000616] ret_from_fork+0x2d/0x50
> [ +0.000612] ? __pfx_kthread+0x10/0x10
> [ +0.000604] ret_from_fork_asm+0x1b/0x30
> [ +0.000604] </TASK>
> 
> The previous way of handling this through returning -EBUSY is not viable,
> particularly when destroying AF_XDP socket, because the kernel proceeds
> with removal anyway.
> 
> There is plenty of code between those calls and there is no need to create
> a large critical section that covers all of them, same as there is no need
> to protect ice_vsi_rebuild() with rtnl_lock().
> 
> Add xdp_state_lock mutex to protect ice_vsi_rebuild() and ice_xdp().
> 
> Leaving unprotected sections in between would result in two states that
> have to be considered:
> 1. when the VSI is closed, but not yet rebuild
> 2. when VSI is already rebuild, but not yet open
> 
> The latter case is actually already handled through !netif_running() case,
> we just need to adjust flag checking a little. The former one is not as
> trivial, because between ice_vsi_close() and ice_vsi_rebuild(), a lot of
> hardware interaction happens, this can make adding/deleting rings exit
> with an error. Luckily, VSI rebuild is pending and can apply new
> configuration for us in a managed fashion.
> 
> Therefore, add an additional VSI state flag ICE_VSI_REBUILD_PENDING to
> indicate that ice_xdp() can just hot-swap the program.
> 
> Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
> Fixes: efc2214b6047 ("ice: Add support for XDP")
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

