Return-Path: <bpf+bounces-70500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9811BC151B
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 14:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4DE0B34EB8B
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 12:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EFC2DC783;
	Tue,  7 Oct 2025 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FfF2OmWN"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6D82DC32A;
	Tue,  7 Oct 2025 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839060; cv=fail; b=RpAGbq3bKtkEIB4r/8GmKUrR0Uc7dmZsb33sQxXw9Oa6NYzQaT3p/QhpVnfOTlk2qSU+PcskgS9Q4n9ZULoVxR/R/VoGCKWNZZ73beYRp+EJSwLeHaV8UWWHnGKQ7a6XJpMw2w+iW99V6rewsHenBXFt9SwgEGnAk9xGQITmn+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839060; c=relaxed/simple;
	bh=AOAaGU0pusr3XKMCpRr3N/OTn0pduzlOtFIvqL0TIrI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MnPbuUqI9dFW3WGn/cEA3EVAczNPa0SaBUWTJLh44YYj+qVsy0uBIOaSrR9Kr6JYimMHVB/qERy2qlKNYlKCUJL7j/INEF6/wRXrQObeiSkMYb2z2VTaSmpMYDsPMCQixMwfqLms1URKbAPn1kmiuFnQBGrUJYY0QAVfv7cdTxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FfF2OmWN; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759839059; x=1791375059;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AOAaGU0pusr3XKMCpRr3N/OTn0pduzlOtFIvqL0TIrI=;
  b=FfF2OmWN6A7IJofE+0WHtYbmfmHSgnj8W59nXJKPqZ5aP7qNyASTI/2Z
   eC1edaWVGPM4iLVbje6NRGoOvbFJBML8/lCuBJ00E4lClnzvrlwQun3A9
   kAkkR4OkyhaakR4+0aNw9tDjFbtpGCFv+anoKPAtxOHacyYdskG+L2jWs
   MzfyZMQ9ICrhb72Ry/Fu7CFlVRFA4hKlIC1cra/NAM9WSDlt8I1lT7Lui
   XHg/fNeOr2jcUe3UykS7A6OJGRS8ECwtBJBMx635lyLlH4D6XnIWLSiJP
   Zmg23tySU2oEpXNYTI9AqbSEhR4tLwAJNz0OjdKHPQyHDtDnpajb8FNmY
   w==;
X-CSE-ConnectionGUID: uH05sgBeQsy0Craul/bnUg==
X-CSE-MsgGUID: 5YwvAsX/R+uPulXygrhPkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="61904916"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="61904916"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 05:10:53 -0700
X-CSE-ConnectionGUID: 0zU/vp6uSiq4F3KBBA4YWg==
X-CSE-MsgGUID: +r6PhdUWRp+lOQO17iXqFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="211097360"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 05:10:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 05:10:05 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 05:10:05 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.44) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 05:10:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wc4BPiGpBQr0GZb5GEhNY5/1TUnmn8ZESZ3TjOTv8RN2py2SKQb5ORGsnsZHhAqgEz5Z0HdqSP9awS3yTlnJv786nUk9a+jz0//3WgcCz2OTKAsDbNT0kyv5/FDlGjLbTU6KojAx1gkiXfLKWaR2P7QjwltksbgkxQAU4v/GHdnIhUlVldtz/HeZbiv44vv2KRiL595HuUEdc96sBcRDPMEPL73KB9QAq64mCIgbH8RQ56WDYSUKu0U6JVFPsrf4DsgzoORk+VeN0j2F60uyed3g+k3CuQSnMBHbDs3w22KIlGMxhoJz0hnLPojvY153TYRMP1HPmnEbHtP/Ie5ldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umvHND1bidp546nhx/ALGT2f3hWvLXNTZsKVhEI1uU0=;
 b=celoIGoaip+TvruIZzDw6PS85wuhPdwmdypMO0UH6emq8hP4Is1pv977BEaa/KdvEmL3eqjKESZFocopdAysYJ7kFxFlsPAYVVF6GxbVj7TBWQOaizK6tI+2bRcFv+rL7PaUCZKg6pl7PkL4vXXqmIWSX/T7Ub4DuanKSG9HN0VGuw4SQu+yEulfcA0MDt7rUcqhJ5CkrYmGxQKTQZBD+nRdRDUUXnvwL0XUeztzsrJDZLzQQhLw1MGYEnvDEUnp2AWpUY46Jml3jXkM8Vf8MtlhRE/c4kDTfgSTrid2qHg1Paz+3whAbqFffXQ1eASv3G0ymrJnUeTCQbIBzmYvXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA0PR11MB7159.namprd11.prod.outlook.com (2603:10b6:806:24b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 12:09:58 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9203.007; Tue, 7 Oct 2025
 12:09:58 +0000
Message-ID: <fa7b9dc7-037f-42f7-87e5-19b3d8a3d2c3@intel.com>
Date: Tue, 7 Oct 2025 14:09:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [lvc-project] [PATCH net] xsk: Fix overflow in descriptor
 validation@@
To: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
CC: Song Yoong Siang <yoong.siang.song@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
	"Stanislav Fomichev" <sdf@fomichev.me>, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
	<davem@davemloft.net>, Magnus Karlsson <magnus.karlsson@intel.com>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20251006085316.470279-1-Ilia.Gavrilov@infotecs.ru>
 <c5a1c806-2c4c-47c5-b83a-cb83f93369b4@intel.com>
 <06da20bf-79f6-4ad7-92cc-75f19685b530@infotecs.ru>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <06da20bf-79f6-4ad7-92cc-75f19685b530@infotecs.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DBBPR09CA0048.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::36) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA0PR11MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 9816dfc5-eb4f-45f9-5a54-08de059a6f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmlTM2hTN1JCS1pWbzl4TlJSN1p1UUpOa0ZzZDNEVEZyV0Yxb2JCVUFNN3hU?=
 =?utf-8?B?K1hkWGxSWTJUOFVZWmhvd2VSR1ZwYWg2Q0ZFRGs2dThUWS80WWdRMnBmN256?=
 =?utf-8?B?QXA3bERwZU9oNUhDSjE0MVFYTHk4TUZONnl0NHhnc0ppMTNCZjlZK293bGtz?=
 =?utf-8?B?MkJTWlVzTFREeVZvZCtyVm4rSjBDSWZ6a0VPS0FTR0VQZ3EralJwd1JwcTFM?=
 =?utf-8?B?cTd6TWpWTjNUM1hIQVFaVWlKSW1mZDhvODY3b3ZMM0pEb0dXMUVGclM1RURl?=
 =?utf-8?B?bXNBZGtadHNJeS9ZZUZoTkFkVGF2N0t6UHNwYnI5UC81MklkR2dTUjV5Wkdx?=
 =?utf-8?B?aHVFT1huaVBPZTRBUThta2ErYk5PN3VlSjFmeFlhNFh6ME1OdVR1UUdwN1VB?=
 =?utf-8?B?NVRKVmpKbUZlQ0paVGlYZXo5alE2VVhZT0I0eEFKbnJBUnhqZnZqMTZiS1BM?=
 =?utf-8?B?amx0U2pHSkg4RHZVam5mbEZ5QkdqS0Q4dU9RUHNIZS9BSzV0TDkrRWMrbkRH?=
 =?utf-8?B?NzNyUmlQbzdBa0NnY1hNQi9NemtBUHpLRUF3VVUzSjVWNzJ0TndrVmJIUmRD?=
 =?utf-8?B?SG9ZaHdWMGpmbzdjVzJyS3BDc2sxNXNpYndJNXVWVVdLaTViRTRSOGJ1NE12?=
 =?utf-8?B?SlBUR2FEMVVQRjBHLy9JRDMwRG5CNjBZRVliY1U0WUtsbkNzeFZVK0xNSjhU?=
 =?utf-8?B?MkhOVWFGNmkzeEM3dDhRd04zUTdTTzg4ZmhzeHhnaUUvUnpvZzZnK0IrbHRR?=
 =?utf-8?B?UXFRb0RlcDVVTFU4THlwTXMrekxWZ2FSeGdsS1E4YUMzcjROUHJSaU5lL2dV?=
 =?utf-8?B?d0pETURxc21CM1c2MUplZWVYeW5LckgvSzRRSzFNTjFRWDNsMXFyczltaERS?=
 =?utf-8?B?cWtFbzAxNEtHbTdrMlRxSFcrOTlFc1VBYkhadVlud0UwS1ovRTdqVkd0R2Zh?=
 =?utf-8?B?a0hyMGhtS1Q0bk1WZ2pOOUFoQjdJT0dGTnozVHFKakh4MVNYMFFvcVlOVmZO?=
 =?utf-8?B?RUFUZVc2bkJKd09aOEgvZHlYSTN5MUU1d2xVelZwd0dlK1hJL1BDUG4wOXcz?=
 =?utf-8?B?R2QvdVdrMi9xcWJSRjBaV29hVHB1ZnFjWVl6Wm1udFZjOExxc1ZuS2swa3Ux?=
 =?utf-8?B?SDZRZ0xkZVZFeklPTy9raXY2VHpISktkQ3B2c1dVdmltZWl3VUNTaXNlRXBI?=
 =?utf-8?B?eUxZRTcrWkdxQ0lvMnFLa1BaTlhraVhNRHYzWG5IS3hXYWVFcXFMbzUwTCtV?=
 =?utf-8?B?cmZiYUFNUk1sZFUzbURxNDNxL2JQNmdBdjRma3RSc2R1UDlXSGpGY3pqZzVa?=
 =?utf-8?B?RnZDYmJwYXJJdHV3eFVvWjhjQTlKejk0Q1l4TDBna1A4dndyOEQ2UGhUR054?=
 =?utf-8?B?cHh2TVYxcHdFSzF6VHlpd0lFS2huRzVXMkUxREhGcU40blVlVjQzVXQrY1Rr?=
 =?utf-8?B?MERiU2xvdG4xdjJxek5OQ0s3SG4xU2llN1VKV3hEVVdpYjNCVk5JL2NwMkpQ?=
 =?utf-8?B?SFFJekN6Ti9QeVJySkFVY2JDVWFjbGpoUUZuQXpWMUdvdVBSOGw4MDhGaVR2?=
 =?utf-8?B?SnAzcCtrN2haTXpXQmVwVWF6UmMxdTlTYk1oUWRqT2xVM0VYVVBLUE5TS0ZV?=
 =?utf-8?B?S1ErWVpReEVyOTZPRkNlTVVaRnVuRHkxdzRoMmlFQ0xVMFVKclZROVljODZ1?=
 =?utf-8?B?bzV4SGFBTjlNZzVWMUdEZnluYWt5NmhOVTN1OHZCWUh1cUwyTUhnUHpxQXdE?=
 =?utf-8?B?dXhEVmdZemJXK3RqVzRFNmdmeVB2N1FaRitBM1liMWdMbXNFeVZrRGZEdWJl?=
 =?utf-8?B?T0hQQnB4T0w3Q241OTlQenY4K1c4bHNSUlMzUlZrZmIxdVlTc0JKR0dpVTZR?=
 =?utf-8?B?bHZ4TmRIMDJJWEs5REZqc0dYRWk3dXNJdHoxTldRZHVDek9xWWwvYzlSdGkx?=
 =?utf-8?Q?0rY7Dh6aBtf6mm6yBlC4UiLcn/j2UXcC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkpZWVRXN3lkcThOaGNqOEwxeEErZ1dDaTc3aDYvNVlTaDduM3IvSTQreGxF?=
 =?utf-8?B?WXhFTlgxSzNJV0JIb3RGUXFXS0tEZ2wzejA4UW1jTWRIOEV2bmxQdVM5MFIy?=
 =?utf-8?B?bkRKSmt4NEJHcTV5bklMU3BZTHFmQ2hRc0s4a0daU0RrTjlnakFFekVWa0Mv?=
 =?utf-8?B?Z2gvZlhzckdNRTNkUE5lS2VoWHA4UXFyQU56dTdCVjQ3V28zRnROQmZjS3Vr?=
 =?utf-8?B?SVh1d3prbVNnNUNMN2dYWjJZUC9mbnFZT2pqbzdCMnJURUtVMVFZdzU3STJ4?=
 =?utf-8?B?d3BDOTErWVVWRnd4US9YeU4vU3BhUCs0NEF0Vksvd1AvTVRUTHVkUmpQTjVm?=
 =?utf-8?B?SDBKcm4zckhndlNicVdmTUNkS2J6L1NpVTlNbXVPUVRjMDlwa0VreDhoUkZp?=
 =?utf-8?B?Um1yQXM3bW5ORmc3RjIzTWp3Q1NnSjFZTW5YT0tLaVlSbnF5RVdBdVpUanY4?=
 =?utf-8?B?QXo3cFRSaURLVXhDdG12bG4rMkh6YTdQVEV6V1RXOGQ5OVpvTi92QytCNlhy?=
 =?utf-8?B?dEJiNnBMakpGM1Q4ZkZROEQ5YTNVZnpLdXdTdVlQMTJlRU1zSFVoZENhbmdP?=
 =?utf-8?B?K3k1akFYdkd3Rm5rTGRnQlJlYWYrOFUrMk0yV2cyT0Qrems5Q1pwTndVOGY1?=
 =?utf-8?B?R2x2eXRGdlR0ZTg3VWVpRVVuZE56QktNdlRYdjQ5K3ZuUFdCaHVLOWNzdGEy?=
 =?utf-8?B?MUxUekQ2SkZKOVh4Yzk5K093N0ZDN0RoLzhsQ2cyUzRSUXI0QndUWGZNRzJp?=
 =?utf-8?B?STIvTW9CTWFJZ2pLd2dDanlaWndKV3N5Q3M4YnlTMWVuZnJEV2pEeEJldXd6?=
 =?utf-8?B?eFJHTmtOdFBpK0hKMjg5OXE3SkR2dng4UC9XTHhuM01rYmhib2JhbXdldkJt?=
 =?utf-8?B?QWJ2dC9xdXNnT2FrNUk2bU04N2JvN05OeVk2L3ZuWUhkOExZbmhEUHJuSnJH?=
 =?utf-8?B?cDNpQ0xSd3VhTUplZlNtaDliNlFnRm53cHVDS3NqL0xLakJORVY1MkdORytQ?=
 =?utf-8?B?RXkxYVRLYXFSV0daeUJRdXgvMWNpMVR1ZG1hUU5VSDZuN2hUcXJmSTc3eVdv?=
 =?utf-8?B?OFJPZE5QSXpFZ3U2YmloZ2xKMDlYTTVIeVo4a1JuKzl5SFVXMnVOYjVmYlNK?=
 =?utf-8?B?azdPL2NjUUNDd01FVElvbExWaHpXWmhrSjhXaTAxTTZEMFN5K3NiVTl2MDhL?=
 =?utf-8?B?NWpDZ1JCcGNWYkN6U2t5M1RLalltKzZydmFaaVlpYlpDcitzeWhEVms3bFFR?=
 =?utf-8?B?QnJmMEt4c3cwQzlWS2xza0VJUk9pRjRYYS94TXB2UEZQeEdiQkIxUjdncSs3?=
 =?utf-8?B?S0pZRUpyb3VzWFZzRTg4NGh4OHZuUFF6ZDgwTlF2ZEk5QStINzJsdEtQdDU5?=
 =?utf-8?B?ZWdmRGx3akhRV3JrZ3grcWxxL2dvMC9zY21kVmZ1blZ3bGdKVWxHU3dqTml1?=
 =?utf-8?B?Tk1EL2w1bjd4aVphaVh1TWUyd0RUdWxhRjIweWJWTm52U3AyTlZBa1dZNGIz?=
 =?utf-8?B?bEFnZjNLYmxoUnNoZkZ3Q0ZVWmNSWVRpOEE3N2FUTCt3d1J3akQ3eHo5VFlh?=
 =?utf-8?B?WjFTVUU2dUNDS1E0Z3c1aHp0YWN6WFV2SWFzUTV4WnQ2aGV5bitLQTh4U0xH?=
 =?utf-8?B?ZEdjVnZQUDRlQ0VlaUdHM2VYWHVxWkJvTzRWRXRSK1JERmx4UGJmU2YzaHZG?=
 =?utf-8?B?L1BzWmZjR0xuZEtFS05LUzFNclVvbCtpVFBoN2ZYNmszR0syNm9veXgrNEFZ?=
 =?utf-8?B?dVl6dVBlSFdtNmh3OERqbGRzbW9BYTF0dURVSS9jYnNZOU95a292RW5kdW5Q?=
 =?utf-8?B?ejNRSWxaTzBzYVBoZmxPSjZTUWMxelVOUmhZSjFJTUJrKzhqM0t2YnBNY0ht?=
 =?utf-8?B?U3Y3aHBJTjdScUo4QjREWmpaYWpFZmovYWM4YUlBTFRHbUhTazFDNnNWSWZY?=
 =?utf-8?B?WFZJNE9peTM0VThRN1pBOTRKZmJJbU1sYllFcDA2ZHRwVlRqZkFXM2M1czlU?=
 =?utf-8?B?TElRQ2p2bC9uSVdmUmJBTWRxV2pCUmdzV01JdFhIODNGRkpKM0JLNmNBZGRE?=
 =?utf-8?B?RkdWcXpFNXJkajVDRTJoOXpINUdQeWx2NDVOajdKREtRRjJZS3ZjTksxSU9Q?=
 =?utf-8?B?amJBOEdtVW82aklYYUpkbkwzZCtxaHpqRFg4YTdDTEVIK0RNMGtMb1VPTGFy?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9816dfc5-eb4f-45f9-5a54-08de059a6f3d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 12:09:58.5106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmpqhfP+Mhd0tdEVJp7Ef1UGLHfDFcEOhMFtQinM/3HhcGAQ4F4OZ6rkDaGNdontGqAmRLZ9EvX1of1wMoIZkz3WC/XXYvk2G5ukdOMf2lA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7159
X-OriginatorOrg: intel.com

From: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
Date: Tue, 7 Oct 2025 11:19:19 +0000

> On 10/6/25 18:19, Alexander Lobakin wrote:
>> From: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
>> Date: Mon, 6 Oct 2025 08:53:17 +0000
>>
>>> The desc->len value can be set up to U32_MAX. If umem tx_metadata_len
>>
>> In theory. Never in practice.
>>
> 
> Hi Alexander,
> Thank you for the review.
> 
> It seems to me that this problem should be considered not from the point of view of practical use, 
> but from the point of view of security. An attacker can set any length of the packet in the descriptor 
> from the user space and descriptor validation will pass.
> 
> 
>>> option is also set, then the value of the expression
>>> 'desc->len + pool->tx_metadata_len' can overflow and validation
>>> of the incorrect descriptor will be successfully passed.
>>> This can lead to a subsequent chain of arithmetic overflows
>>> in the xsk_build_skb() function and incorrect sk_buff allocation.
>>>
>>> Found by InfoTeCS on behalf of Linux Verification Center
>>> (linuxtesting.org) with SVACE.
>>
>> I think the general rule for sending fixes is that a fix must fix a real
>> bug which can be reproduced in real life scenarios.
> 
> I agree with that, so I make a test program (PoC). Something like that:
> 
> 	struct xdp_umem_reg umem_reg;
> 	umem_reg.addr = (__u64)(void *)umem;
> 	...
> 	umem_reg.chunk_size = 4096;
> 	umem_reg.tx_metadata_len = 16;
> 	umem_reg.flags = XDP_UMEM_TX_METADATA_LEN;
> 	setsockopt(sfd, SOL_XDP, XDP_UMEM_REG, &umem_reg, sizeof(umem_reg));
> 	...
> 	
> 	xsk_ring_prod__reserve(tq, batch_size, &idx);
> 
> 	for (i = 0; i < nr_packets; ++i) {
> 		struct xdp_desc *tx_desc = xsk_ring_prod__tx_desc(tq, idx + i);
> 		tx_desc->addr = packets[i].addr;
> 		tx_desc->addr += umem->tx_metadata_len;
> 		tx_desc->options = XDP_TX_METADATA;
> 		tx_desc->len = UINT32_MAX;
> 	}
> 
> 	xsk_ring_prod__submit(tq, nr_packets);
> 	...
> 	sendto(sfd, NULL, 0, MSG_DONTWAIT, NULL, 0);
> 
> Since the check of an invalid descriptor has passed, kernel try to allocate
> a skb with size of 'hr + len + tr' in the sock_alloc_send_pskb() function
> and this is where the next overflow occurs.
> skb allocates with a size of 63. Next the skb_put() is called, which adds U32_MAX to skb->tail and skb->end.
> Next the skb_store_bits() tries to copy -1 bytes, but fails.
> 
>  __xsk_generic_xmit
> 	xsk_build_skb
> 		len = desc->len; // from descriptor
> 		sock_alloc_send_skb(..., hr + len + tr, ...) // the next overflow
> 			sock_alloc_send_pskb
> 				alloc_skb_with_frags
> 		skb_put(skb, len)  // len casts to int
> 		skb_store_bits(skb, 0, buffer, len)

Oh, so you actually have a repro for this. This is good. I suggest you
resubmitting the patch and include this repro in the commit message, so
that it will be clear that it's actually possible to trigger the problem
in the kernel using a malicious/broken userspace application.

(also pls remove those double `@@` from the subject next time)

I'd also like to hear from Maciej and/or others what they think about
this problem (that the userspace can set packet len to U32_MAX). Should
we just go with this proposed u64 propagation or maybe we need to limit
the maximum length which could be sent from the userspace?

In any case, you raised a good topic.

> 
>> Static Analysis Tools have no idea that nobody sends 4 Gb sized network
>> packets.
>>
> 
> That's right. Static analyzer is only a tool, but in this case, the overflow
> highlighted by the static analyzer can be used for malicious purposes.

+1

Also I really do hope Infotecs stayed independent from the govs and
doesn't take part in any dual-purpose/gov-related projects.

Thanks,
Olek

