Return-Path: <bpf+bounces-45616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 808889D95AB
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 11:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E80285373
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 10:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F2E1CBE8C;
	Tue, 26 Nov 2024 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E0QdKTXk"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872821C8FCE;
	Tue, 26 Nov 2024 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732617438; cv=fail; b=Pl/jhChUimZ3OzU8gAbJc7KwRdCzfQvGwbsc0CQYLskFK+ve1hxoLQ0cfVBrTusmHPptMLbndNQR2k2RZyPmTAOv27IIhX7CWVzXbhvjrC3U5XaokXmicq0E+K8yUTQBr3mSPVJ9qeI5SSR5zwWWMsJghb/dK+gK8rJwpfdrV6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732617438; c=relaxed/simple;
	bh=i937ILl2rfhxxwsCbcTRMbR03xaG4mjTkZoHwS075aU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bW5ielASC20PYboESlQZACbH8G+6UtPq+0uczCRwWcRUsNF7HcbNrlR7XwZd09RpYyJDKomqpABbHJepWLUNrGvmIwi0VK84a6NJnCU+Cede0J0ov0pvweF6oJii504itx6o4c3xmxaUrcFt+cw4KMzg1D9ywtv6pgXCkoBXUvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E0QdKTXk; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732617437; x=1764153437;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i937ILl2rfhxxwsCbcTRMbR03xaG4mjTkZoHwS075aU=;
  b=E0QdKTXkuYlIbxMmtVYEAJIQk2QvhBqlhBG6MD2mP3Nc88TBX1NmMwEe
   bPTV0R9YLgISbt1KB2ThClW0q8dxmw1gQn7O8sakwpj0RsWtYfQ14b88A
   olS4mwn9KmJxy37uNg7s0HvGpPrz+MmFKTYIncsoZ1flrlNr9xefEsmhu
   kXsmoqMluwflumjv/x3nDD6IQkoG4hrYangpbGX63GS26FxJtcQxB3xt/
   gIPxh3jEMVmr6bP5eeuXPzJ1b9R86lPf3pnq/AqLdI48bAgjrKpcUV6cF
   ESCO0lab/1/fk8RCIrWcMd2HHKZncwKvfjbMV8gZ7INnuVq+wnUmDtXTt
   g==;
X-CSE-ConnectionGUID: hjdnOzNmS1OrucIAV8MsDQ==
X-CSE-MsgGUID: 2hVbAl61TzGavYHy4dRhYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="43431752"
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="43431752"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 02:37:16 -0800
X-CSE-ConnectionGUID: vtwDng2UR4G9BFsFEXxmlA==
X-CSE-MsgGUID: RzKllsNGRMWIl3wQ49d07w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="92038887"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Nov 2024 02:37:15 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 26 Nov 2024 02:37:15 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 26 Nov 2024 02:37:15 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 26 Nov 2024 02:37:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLtWItj1HlntJMnF6Gy3LNkMEPyqtsrrJ4d4RnCvmmyO9acHz8w9md/u7iRJwL48t2ktAq98bFQtmKfsmxOotqo4vmpz7cONFqHUNE8rdy/53S6FWVm5cfw/Conr+atD0ThFL9W5QaXs3Ccq5WRlmJPXS+mp5h8xFBEFMu3Q3tQnj9bjkQPbvspM0Tk0pjBsAwunf57uAzbE1q6dc9cfs4LAPEFn2ExA3/qp+DxjXlpu8X1h27QKQwasJsN2gINb2HA2RJYm5AetoWr8lYkyU4er8E030PlGQFEWAoT4+a3XpbiI+v7IZftYUrkNHbk6kIqL58ZCc+7oOtgLRMfD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rGq4QnZxe7QuZF2nC2Q+n4d20413BMlRVcfZ/T5oWM=;
 b=qmTjTZycSW32+3vxFalaufBXGB8I94XOPXyWCcqbzgSjfSlCp99opbSW/RZcaQiaR+jOhzimLGEGfB9pOs5RKh8UEdslOM1XlxSHFKPyL9aAIz4eqRu8ZvqG2CStUQf0fBMGcypSBKsArjwXHPyChSUNK+KJ1/MWPAbvHODO3MDHjUqbvoPNIBmC9+HkYPOsz2hGM5kiQnj/Z7x4NJyC3SboSsXYduQMHT28nMIES+1zeFCy5cJmXDFqx17tLsRO3dBdZ6bm+rCaUiILFvkXrWBNsuxcjDYnXQBBC4VHEwF13x83pku96aE/8ZA5XpJsBJNBZeOV4m1wdqmVyj4iqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV1PR11MB8817.namprd11.prod.outlook.com (2603:10b6:408:2b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Tue, 26 Nov
 2024 10:37:12 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%7]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 10:37:12 +0000
Message-ID: <6db67537-6b7b-4700-9801-72b6640fc609@intel.com>
Date: Tue, 26 Nov 2024 11:36:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
To: Daniel Xu <dxu@dxuuu.xyz>, Jakub Kicinski <kuba@kernel.org>, "Lorenzo
 Bianconi" <lorenzo.bianconi@redhat.com>
CC: Lorenzo Bianconi <lorenzo@kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, David Miller <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
References: <cover.1726480607.git.lorenzo@kernel.org>
 <amx5t3imrrh56m7vtsmlhdzlggtv2mlhywk6266syjmijpgs2o@s2z7dollcf7l>
 <ZwZe6Bg5ZrXLkDGW@lore-desk> <55d2ac1c-0619-4b24-b8ab-6eb5f553c1dd@intel.com>
 <ZwZ7fr_STZStsnln@lore-desk> <c3e20036-2bb3-4bca-932c-33fd3801f138@intel.com>
 <c21dc62c-f03e-4b26-b097-562d45407618@intel.com>
 <01dcfecc-ab8e-43b8-b20c-96cc476a826d@intel.com>
 <b319014e-519c-4c2d-8b6d-1632357e66cd@app.fastmail.com>
 <rntmnecd6w7ntnazqloxo44dub2snqf73zn2jqwuur6io2xdv7@4iqbg5odgmfq>
 <05991551-415c-49d0-8f14-f99cb84fc5cb@intel.com>
 <a2ebba59-bf19-4bb9-9952-c2f63123b7cd@app.fastmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <a2ebba59-bf19-4bb9-9952-c2f63123b7cd@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0268.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::21) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV1PR11MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: 79176979-b594-432e-aef4-08dd0e06494c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dER3S1JDczR1bnVWMGU1amhHRkdiQnFUUzBBQ01IS0NYWENEVXhLbHBCZEln?=
 =?utf-8?B?dkJUQ3RESVFlcEI1RGx2dkNYVG5WcTJJUjB4NEs0N0gvM2F2MUIrUnNndE5T?=
 =?utf-8?B?b2VDZWZGeFg1NFhGQVBPSUQ0c01wV3ExZjNPZVMrT2xXcFAvME1YdUZLTG11?=
 =?utf-8?B?bEMwdkZYVk5pVjZka2lvMjBpWnFNaXZuOFoxc3BRYzByRTk0cVA4MkdNSFE1?=
 =?utf-8?B?aU5QdVo0djN0dEdSTGRsZjgyeWppTGdOeEdnRHhibGRESlp1VGVIRWM4c2xY?=
 =?utf-8?B?d1crWThZODY5a0VISjdFUmNESXNVR3JudThhL2tXbGNYcUlSSllnNDFvK205?=
 =?utf-8?B?bDRndUE0elNuVk15M3ltbk5zbmo0OWVENzZTbTF6dEptazRmV1haT21rUkN6?=
 =?utf-8?B?SmNBT09jTDZOdWJTb2ZxbjkwdjdoM2VHMlY3OVZnNEVCTjBId3NUOU91Z0ov?=
 =?utf-8?B?d0dyY2pUMVRKb1kxREVhTXFHUHNmdk5IcklndTUvbitIVjFzVVZ3R20vU2pn?=
 =?utf-8?B?cXBIRmNBM1B3dE03dVQ1YUFUbWxxbVI1dm5FUjY0WUxCVThsZ1FlOXptVERl?=
 =?utf-8?B?WmV4TlVibnVOanFqZ3FTbENqL3VVenVaV3lPZFA1Z1ZaZFp2M0IyazFLaDAw?=
 =?utf-8?B?VUNjenl5WHkrTzVuN2VzdmRLOEhXRm8vZitrakljNzl3eFQ5V0JLb1I5d0dX?=
 =?utf-8?B?aGU4NWdOVHNXL01JcU5xTGlzZDA4UWZuMUdSTjR1bmRSdU44anFSU0QwRGlY?=
 =?utf-8?B?K0c4Z05meUVrcW11TkVOWWJnUVRtZEVIOHoxRUpEWDVXd0JZWmV0NytpQXAr?=
 =?utf-8?B?cmczLzdtd1lSRnJ4WWJERE4rRUYyZ3NMZjZEUW8ycjlmQ3RoL29tU0dibXo4?=
 =?utf-8?B?NWtpMmVHYUZXMHc5U1hITUtKSlRHb3RaUS85SHpFUHN4eW9LZFBvTFRoblFX?=
 =?utf-8?B?UE9wSzVLSGdQa05EdmpGcUloTkxoc2NYTVEyVy95TkZMdm0rUXhFREUvUTcr?=
 =?utf-8?B?bXA3c3lqL2wrMW0rNkhoSkM3bWlzZUh1RHpEaWZrYnJpZU5KWjVpLzNkMjJj?=
 =?utf-8?B?Q2N6VWN6UytDbUJPVjF6T3VtRHpyOWFOTFVwRlFwNUl3NjdlN0VQM3cvSHgz?=
 =?utf-8?B?d05xNkZwTFpSV2VsaXY2Q09XYkJWUEl6ZVJheHVHMW8wYUs1bHNLVGJuSndX?=
 =?utf-8?B?ZzNaZVI0NEE4Y2J5R1ViWGRIZVNKSWVETC9GWkZ4RGlTR2tvcTdoajBWYkVn?=
 =?utf-8?B?aWhmdlpqWitwRUdhUzFPSlYrMmVMcmhTYTF5djIrcE4yZ1JZSGFUME41TVhR?=
 =?utf-8?B?QUhRSm9WVy9ERU1GdjlPazg3eWVnK3ZTeFB5enFDVWJBS2JSd3pXbFlWQmFF?=
 =?utf-8?B?a3Q2aDFabkt4dFY2VU5tVm10QkIxV2s5cERDRytMVkR4c05zZzc1YXJWcmxS?=
 =?utf-8?B?Y3BHalFXTi9PZ1k4QnA5TmptOU9tdE1NeUhxYkJsa0Y3eTdnRnh2UUV2cHU3?=
 =?utf-8?B?ZkIwcS9pOEtPaUxSd1BpR1FPUDBCTkJQeEJZeVBta29uRlMzWVBTVkh6ZHVp?=
 =?utf-8?B?TjA3ckM2N2Vtd1JBNGFYYUVBb2lMbWRGK1dUVmJzcXZrKzI1QUtoWVBwY1lO?=
 =?utf-8?B?U1VManJwcmNpby9ZTXBXbUR5Mll4K0o0dkRhT09hQXdnemxKTWpGVFpvVW1R?=
 =?utf-8?B?dWFsL0p2amQ4VFJZSGoyNEM5aW1qUlhMbE9KTmMxMzEwVkpXOWVHRFBJSk94?=
 =?utf-8?B?bEE4a2lBQzhNS1NCNVZWMVNpTlI0Y05pc1dIS0JJT3laazBLSVZVOHlZRWk5?=
 =?utf-8?B?OVRuZEJBQjZVS1o4YThqQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXZmOWhsdnozbjQyWVcrbFJvS2JXL3Z2YjNKWGRPREQ0ZUZPTFl5a3hMV1VG?=
 =?utf-8?B?RlU1ZGtJZUdtMXhFVExQYnBSY1pJUWhTZ01LbkZERElzNmVEK210MHUzMitk?=
 =?utf-8?B?VVZpVk5Nd2xENjFSTnI2aGVldzRXVkg4QnlWc0JoVFppZVlKUUJlOHZ0bEpV?=
 =?utf-8?B?VXRwdVloTXVTVmt3ZlBYcWdHS1BWOU1XRXR0YU92K21sNDNKUlVNc2NYSElN?=
 =?utf-8?B?VGVza25aVy9JVE1ZNytIQ1JheDFIQmZhZURHYWNEMkV4Q0xDN2lWNHdkU0cy?=
 =?utf-8?B?RUMrRERSdllSS2xqZmkvNW5YMlQxa0Q5YVVkVVU3a2p3cU5PRlNOK1ZvWDcx?=
 =?utf-8?B?K0RFaHpKeUt3ZlhUeG9tcHZ0WURXU3F6RHR5UFk2RVFEaE5mKzFzeG9xTmFt?=
 =?utf-8?B?Q0I3RWNRUkVva1JXSXlCV1hlSXdMQi80bkt5MlJxYnN2UDdzR3Y4UDAvMFY5?=
 =?utf-8?B?aVJQL2Z0L29SaGxxeTcwUFNYcjlGbWluNmN2czQ2Mnc3QURyQ0c2ZFdpMUtG?=
 =?utf-8?B?TkI4bkh5M2o3ajdhZHlHUkdpRUV5YTBXS2ZLNTZCT1pNbisra2d3OEU4TFph?=
 =?utf-8?B?OWROSUN4emRxTGZGU3MrVjhFZTI1MUY1TXFLZFczNGcxZG9XbkVlZGZPMTRt?=
 =?utf-8?B?YmVJR2JFVjhUempiS2VSWUYvM0VSVEYxZ0prbVlQZDZSOWFOeWlSZVVNN05a?=
 =?utf-8?B?dE5lUkNOZjJGVzlZNHVsYU41cExZUGZ5YkJ0MU1kcFpSRWttWXkrNmVXbXN4?=
 =?utf-8?B?WnBXWkVST25CY0t2U1hlNjBkYVVsc3lLalp4TTVhL0NDcWhlZnNYTWFkdmU1?=
 =?utf-8?B?VGN5QlJwTmw5bDU0RWhRTGwrTzFTTHR4U2pEcVIwdjJVRFY0YTg2Q2RNalln?=
 =?utf-8?B?cTlnbmZwUVExQWlCclhtdEE1Z2RtQUQxekNvYUliaDlEYnZSUjJJQUxJZVNX?=
 =?utf-8?B?dDdvQ3cxNnRudWZKUkdQN1J2WlBRajFsVHJUdTFvelRwKy9wNmROcjZDbDgx?=
 =?utf-8?B?bGVvVTFrRk9VbHFHa1VnWFJDaG9UUmk0M29RdkxNajJQZmI2ZkM3RW1lYU9i?=
 =?utf-8?B?UzR3L2F6a0w5bEtzdnQrdGFKd2MxVHRSMXdYcVRMUjlQSTdLYTBVRlErQ2xk?=
 =?utf-8?B?MzF1OGw4OFViZXlEVklCS0phQ0IzSXRmOHdwbi8raS85OEtYNTVuaEZNREhM?=
 =?utf-8?B?a0dmeW1vcWRVNTJMU24veUVRVWJZRmpMdytLTU00L28yVEZJQk5nb0dpcGlp?=
 =?utf-8?B?Zy8vSDN6NWoyS05YTUVTVEwyeEpmK0pPN2ZyYkxxUElmOVdEUWJkOEozbWRM?=
 =?utf-8?B?aWJLZUxFSnI4dU1qZGlNVzdjT1ZKYytzN3hWMlVvYlN3Z2Rnakx3Qk1UV1Ex?=
 =?utf-8?B?QlpjNWpNcXVWYXl0SU9md2craktPYVNhdDFDTFhrRHpZVWNRV1ZoKzlrbWF0?=
 =?utf-8?B?TVJLRTRIM0N6YkZaRmJFQmY3Ni94K1FDSGRTc2U5a3lDSDFmd3VqcFg2VjBT?=
 =?utf-8?B?WE52eW84N1Y5cFpFNkhPaFB6VGc0MXk2dHd5WTBldFJBTFFXb1ZGcmVvQW1T?=
 =?utf-8?B?QUFyRHZ3Mm10TnJsMElkSWQxeHVBemt1VmFxZG5IUmJsWmpZNER3WTlobHNu?=
 =?utf-8?B?TXd3YWJ0eXl1WUVoaTdGd29NaFZSMW1ISWZVSHZlMTdlbm9xOVkxemI2ZzJY?=
 =?utf-8?B?WCtrRGVHUXRORzdVR3pSL2tmRis0dG5qTTFhT0xrU2NNZ1NzMldvSlNkdlVa?=
 =?utf-8?B?T0FDTWViUGY0N0ZGS1FsOCtQb1hKTjB1Vk1QckZYVFlxU1FueXFZbDB6RVlQ?=
 =?utf-8?B?NTBnTklHSG1OMjJNR0dmd0lZenVxa2wwbFlvZDlySzRHYk5WRTVCSHBEa0Jy?=
 =?utf-8?B?RU5NNTZCYUZoUHZOamRlNjZaK0wxeG8yZEJnQmVSYlRtNU52UGFIZkovWit0?=
 =?utf-8?B?OXhYcjhMOWFVN2FGb1JtdU1FZjBSdStZR3ZQQzRnT2lVaXJlV25jOXBreVdI?=
 =?utf-8?B?T01BM2Jtdko1ZktCYjM1alVscmF1RXNkREJGUWtEQnRvRWZYSUV0ZmF3S3lK?=
 =?utf-8?B?WVEyUEZxSEtHRmgvZmszU1BJbDExbDlkWHBwaERyMWtRN2R1SXo5R0Zzdytr?=
 =?utf-8?B?Y1ZYVXJKbnIrbUp4cDZXNjZ6aXZ0UjFvc051ei9HSFpkV1ZrUzd3SHJQakVj?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79176979-b594-432e-aef4-08dd0e06494c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 10:37:12.1321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H23OTSzqGRd1LGgIfqRJ1zPwwJr7t6ZKyh6eYywzns0Z6H4e5oq/Lc6zGlU7C7ITqMpMzFmQeUs//HkBW010G3XctXhZevImcnVCsDRD6o4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8817
X-OriginatorOrg: intel.com

From: Daniel Xu <dxu@dxuuu.xyz>
Date: Mon, 25 Nov 2024 16:56:49 -0600

> 
> 
> On Mon, Nov 25, 2024, at 9:12 AM, Alexander Lobakin wrote:
>> From: Daniel Xu <dxu@dxuuu.xyz>
>> Date: Fri, 22 Nov 2024 17:10:06 -0700
>>
>>> Hi Olek,
>>>
>>> Here are the results.
>>>
>>> On Wed, Nov 13, 2024 at 03:39:13PM GMT, Daniel Xu wrote:
>>>>
>>>>
>>>> On Tue, Nov 12, 2024, at 9:43 AM, Alexander Lobakin wrote:
>>
>> [...]
>>
>>> Baseline (again)
>>>
>>> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
>>> Run 1	3169917	        0.00007295	0.00007871	0.00009343		Run 1	21749.43
>>> Run 2	3228290	        0.00007103	0.00007679	0.00009215		Run 2	21897.17
>>> Run 3	3226746	        0.00007231	0.00007871	0.00009087		Run 3	21906.82
>>> Run 4	3191258	        0.00007231	0.00007743	0.00009087		Run 4	21155.15
>>> Run 5	3235653	        0.00007231	0.00007743	0.00008703		Run 5	21397.06
>>> Average	3210372.8	0.000072182	0.000077814	0.00009087		Average	21621.126
>>>
>>> cpumap v2 Olek
>>>
>>> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
>>> Run 1	3253651	        0.00007167	0.00007807	0.00009343		Run 1	13497.57
>>> Run 2	3221492	        0.00007231	0.00007743	0.00009087		Run 2	12115.53
>>> Run 3	3296453	        0.00007039	0.00007807	0.00009087		Run 3	12323.38
>>> Run 4	3254460	        0.00007167	0.00007807	0.00009087		Run 4	12901.88
>>> Run 5	3173327	        0.00007295	0.00007871	0.00009215		Run 5	12593.22
>>> Average	3239876.6	0.000071798	0.00007807	0.000091638		Average	12686.316
>>> Delta	0.92%	        -0.53%	        0.33%	        0.85%			        -41.32%
>>>
>>>
>>> It's very interesting that we see -40% tput w/ the patches. I went back
>>
>> Oh no, I messed up something =\
>>
>> Could you please also test not the whole series, but patches 1-3 (up to
>> "bpf:cpumap: switch to GRO...") and 1-4 (up to "bpf: cpumap: reuse skb
>> array...")? Would be great to see whether this implementation works
>> worse right from the start or I just broke something later on.
> 
> Patches 1-3 reproduces the -40% tput numbers. 

Ok, thanks! Seems like using the hybrid approach (GRO, but on top of
cpumap's kthreads instead of NAPI) really performs worse than switching
cpumap to NAPI.

> 
> With patches 1-4 the numbers get slightly worse (~1gbps lower) but it was noisy.

Interesting, I was sure patch 4 optimizes stuff... Maybe I'll give up on it.

> 
> tcp_rr results were unaffected.

@ Jakub,

Looks like I can't just use GRO without Lorenzo's conversion to NAPI, at
least for now =\ I took a look on the backlog NAPI and it could be used,
although we'd need a pointer in the backlog to the corresponding cpumap
+ also some synchronization point to make sure backlog NAPI won't access
already destroyed cpumap.

Maybe Lorenzo could take a look...

Thanks,
Olek

