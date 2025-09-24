Return-Path: <bpf+bounces-69544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2FBB9A47D
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 16:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062F23B2D86
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 14:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A557B308F13;
	Wed, 24 Sep 2025 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F+Hn3IX7"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3839928C870;
	Wed, 24 Sep 2025 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724619; cv=fail; b=suLMbY1z+cEjx/cL/ugGYMR+T8CuiV3lB5OU+teqlmu+FX23GFTBNRZiGZvNTMQU7lYwNte+dfrtA35MumZ+QsvjI9GJPJlmmcipOdpp6Kk7g697U5ul0cBATbcYOrbMsppMhERzAUWkC138oeI7mucfLLvDW5RHoOMW44ul/qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724619; c=relaxed/simple;
	bh=SGUMfARLGqvBZMVzV/jzINLnX+TtHaRBajEqYnqtN1c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ShyhkM4duA6+6lKeBe9KZnDVOYB7QX/fWdtU92w/BlEFBufuKD3mGzfOymhvGu3z/hY912YiSNqY48QDPX8VHzQeDwsH193EcZLpJwvkWmpHXRryOUKM13ApMvyyWT4OFpihwpeFAP9f9mL31ycGS89bWCcOBu6cbQJSWZMkOf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F+Hn3IX7; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758724615; x=1790260615;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=SGUMfARLGqvBZMVzV/jzINLnX+TtHaRBajEqYnqtN1c=;
  b=F+Hn3IX78XJrasKDwuQb0hXhnhWWfN+TG2u95P++EE3lKn012GxnXKHE
   ByaxsPMGRmDJIksrdFO4bFBr/4WSdEhrmGA5FphYGkLYXOAzH2CtYEcdv
   LKufQ5+xaN9txuxvSPaJAVuZgRSY1AtX5tqpHJUGFRQElmZbkU7lGef7Z
   CGcUuzLXFcu5DstnyynotLgcZCGvWqETNU9w4qDZ1170haAAKS5v9KN8/
   mRgWjsTnfGzKCEMw9TiwTq+j8qwixKJCjGyBL09dmkF9nOzWjdR+9Uh+j
   LGa3/mRbleGxq5J8SXHtOMhYbsvQRGlhj7vshvHugqJZS3dMne8kpIwzm
   Q==;
X-CSE-ConnectionGUID: iI9xJMIKSRuVBP0Iz64dxA==
X-CSE-MsgGUID: qwFdMtYrR0SnXSCsfavLbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60966013"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60966013"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 07:36:53 -0700
X-CSE-ConnectionGUID: /uZdLcQnQqayZ6wOcaIYNg==
X-CSE-MsgGUID: CWEo0z/UQj6gsnUUOUY4+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="182334256"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 07:35:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 07:35:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 07:35:47 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.38) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 07:35:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwH/x2d7ucaaCbCrR2aR6Y+z2RFvRrs1KuHi2qmcKiEOgNG0ICcWKKMHuERjnKefPlA0zCY5iaCjxDmgskD4OW8AZBreaX7DN62zKmzs7cUUHH4nidqF14ZbIsCR9GP+ctVSA+oPhRB25gKxKt6WNefYJKBQZSk1C826CRxArGDyR8wVCIZxjPymmUTctD55AWeZLTq/9T66j9NJqiKlmcK3uyx+W37Zg5skWM08ypxZHWdcvKO1lTuufaDGdOCiWNPUZRPK+DRmj7Zi7Q7/X6W1aSLMF7KACdsx98R0TseeFKm7vFLVMhzvlU9/6P/eHMzQ9Kr3BIggQxYKUmPOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDdnySQhj9oP/Om9VZIXL+Ok5VH1Ku8fX0bgslQBR3Y=;
 b=F0w7jo/6NxfcGuN3PYQ/DUOodwG37d3+SvSO9VaNtfycJOEInbfPeNfeXFwCl4ATGF+5nwGdvCeAe+z/IZO+UqL6wLUYj8Pfe/xdRj9z38Acfw0DUtn6x8IonMd3ScIl1doTw7HJ83EG1YW3oJUPo5yjmabZJFnpjkt5UusbysL0L/6r6m/1uEaqPiFWgYyjUvi/xjKAxP8nOyJzrVBckGJk04cF7MDEGl1t96cFyoTNgoSMu8j4x7u9C45x3edZXvlvHT9QjN3cUK4UxNX0WwiZIUY3/2XhCtBVOYEogeobgBt+0kZDls6kkIYc70LN08L2NJxWYWvN3r3iNUNWxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SN7PR11MB6604.namprd11.prod.outlook.com (2603:10b6:806:270::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 14:35:45 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 14:35:44 +0000
Date: Wed, 24 Sep 2025 16:35:37 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: Stanislav Fomichev <stfomichev@gmail.com>, <bpf@vger.kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<netdev@vger.kernel.org>, <magnus.karlsson@intel.com>
Subject: Re: [PATCH bpf-next 2/3] xsk: remove @first_frag from xsk_build_skb()
Message-ID: <aNQBuQYHGHuekAhV@boxer>
References: <20250922152600.2455136-1-maciej.fijalkowski@intel.com>
 <20250922152600.2455136-3-maciej.fijalkowski@intel.com>
 <aNGL5qS8aIfcSDnD@mini-arch>
 <CAL+tcoDp0k74jJtUo179J7mkcf1KCAPMy+fWh-Mn7oC236n-kQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDp0k74jJtUo179J7mkcf1KCAPMy+fWh-Mn7oC236n-kQ@mail.gmail.com>
X-ClientProxiedBy: TL0P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SN7PR11MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c69e0c-f418-4601-35d9-08ddfb77a51d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnIvT24yVTZKQVFKdTJxVnNCMm8yeDR4eWlCWXFxV2NVdFVBMHZSMDc1L3hy?=
 =?utf-8?B?R29WTDVkcDMzekdWUi9KajNvUFBETG4rNHEyRTZBV2R0Y2lBL29DZ0hNMDRy?=
 =?utf-8?B?TDc3ajBHMkFQcjQvZTFFd2J4T2c5UFE4UjNuSVJ2T3BZU3BaYWViZmJRLzd6?=
 =?utf-8?B?bEtwVU9wb2VFK212Ri9hR282QXRzYUpmNWMybjh3aE9GcGl6RlhWMkZkc012?=
 =?utf-8?B?SVlsWDM2cUhpODVheXNMMys2dXdWWDREdjlWMUFzMjd6Uzc3QStwSFdsaFdB?=
 =?utf-8?B?UTNXQjBUSTF5blk1RjRrQndLNU55eVJJYnZQaVU3S3ZuVFhsbnVNVHpkVUNY?=
 =?utf-8?B?bW1Rb2VXM252MXRTOC9HMTJWcmM3Z1lqc1NwZ0ZZSGhjS09sWnZiNHNQdDl2?=
 =?utf-8?B?N3JmSE9jN09MMHYwOWg1ZWNuZnN5d1NnRjlEWUhGOUVRMWROQ2dBZ1hIL0xS?=
 =?utf-8?B?YXVOMkNDS0dTeEV0SEhEcWNSRGNzN2lCRkFySkRUMStianltc2k5RDFnNFMv?=
 =?utf-8?B?YU1CbnQrbTZtNm0wUTRzbjFGaXRuc2g0UzhHdUZjemZzcThrSDFXZnNXeDVR?=
 =?utf-8?B?VnZWaHdyVEZpc2NOSnRVWmIrY2pFeGNDRGsrSjZPMHJENksyUkQwVUhDUjRv?=
 =?utf-8?B?UGdPMXBBeGhpcWlVanpYMGEwNWtzY1h2aU51TUFVN2oyZElJK2laUU8wK21s?=
 =?utf-8?B?ZWRuNU44azZ4TlBOQ08xZktMb1U3NGJWeTM4ZjZadXk2ZUVxeUlIeEZ5WlFo?=
 =?utf-8?B?bjIrRmQyUkJNVFVlK2RuNWtCMlp1OTdsL0hDdCtKOUZpeTByK0pSeHRJN3FY?=
 =?utf-8?B?c1VadE1XY01yQitnVU4vVXhnZDMwWkpmS01QdG55Sm16Nmx3YmtsdjF1eVFQ?=
 =?utf-8?B?UUFENmZqQUVVT09GWmhZbG5vYjZqc1p0R1dQNmV3ZDZjcERtY0pSUUZNUnJ2?=
 =?utf-8?B?U0R5WmhybW9ROWxPSmtMMEw3bkpWTEVZOHhoWmFEK2lVenJyNVdXYjFjd2k3?=
 =?utf-8?B?MkhPd2RBUEw3bVdLTy9Cc3FzMmFXd1hEQjl4Q2wzUUpRVmc2S3AyUlFxOVYv?=
 =?utf-8?B?L0xwOEpNRHR3OHEwSE52YnFCcnFzazRwUXUyNkJvNDlhOHZ4TGRjaU9IMzVs?=
 =?utf-8?B?ZmVydnc3bWQvRkhGMkpvd250YXFKaFkraHZJQ2VzVC9HQ3FvOVo0VWJKdW9z?=
 =?utf-8?B?YXVNRUZwdVBId2pGalBENHcxTERReTNiYlRlRHFCYmk2Z2FLUldDSmg0Ujl2?=
 =?utf-8?B?RnhscVlUSVZOMzlOblRzd1JrVDdjNnZUU3JVTENWNDRqeXpQc0E3S1J6S0pP?=
 =?utf-8?B?TDRpT21ZTGFXd1RrbWhMeFVaV3VIK1laUUxxOHdnNzlPT3V5UnNtWXhvNm5l?=
 =?utf-8?B?SzV0N01aNEJlK2NtSUtrc29POEphMGxVakVtWHVQdXI0ZEd6T0E0aFg5bGhn?=
 =?utf-8?B?S3hZYmJERHVjTm1ENDhST29SM0JFbE1QWWVjakxVb25JS0NtQThJMWtUaGdO?=
 =?utf-8?B?T1Y1bWxoZ1ZEK0twNU1XUUJKanFURTZha2g4eVJxUEpHNDc5cVhnQVh2NHgv?=
 =?utf-8?B?ZDd5NExFbGRQVzZjTGF2ZmVOc1FXOVZ1YlQ1S0tCSDU3NkU0QnpwZjNxNVF0?=
 =?utf-8?B?R1RyNm9DcFlNcExiV0laTG9zc1pocHBtNVFTSUlLTlRMQ3h6OHNxYXV4dHQ3?=
 =?utf-8?B?NEhNdEZJYThJV0FxR3lZNVFQd3daTG05ckdyK1lGOWdwOUxndjZEUUd3ck5U?=
 =?utf-8?B?aVVWK3BKeWs3TFN4SW9MRTdTSFlmU3dCSzdiMDFEWHMvTmE4akdnSzVwZ1F6?=
 =?utf-8?B?eTdWc2sxVDc3YlZUMFBmclpvVUlzRE0xclp3RmQ3a1M4aitaTG83aXJ3R3pF?=
 =?utf-8?B?Uml4UTU4enlDMFJ1QWgxMld1a2s4ZzZKbzAveVY2Y0RUZTlDcFlEN0wzWFBn?=
 =?utf-8?Q?IfRtPajHC5w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVdvd0Z2SlFGSW1KK3hMRWd6Ty93YjMvMUhiZ2RZMldYZkJaUStzdXVxTXBP?=
 =?utf-8?B?ckw2TTJzSWtYaEQvZnhBY3h0QW5xWmZvNVpGdTN6QkljaEhZMEcwQU5jSVNW?=
 =?utf-8?B?NFN4TFBrc1lHbC9CUG16aWk5WTJ6VDVBc1N5cFlrOENjWm5iN0xTV3RWTGdu?=
 =?utf-8?B?MUdxSXY4Y29WVnMrdE4zYngwVVVsdDVSMWRmUVlvQnYxS01aT0RkNmtaSXpB?=
 =?utf-8?B?QldjY1pod1JBVVBub3JDdkNnaUVNRFlKYWMxeHk2UVNEeFVzeDU1R1NHWGRE?=
 =?utf-8?B?V0hNNnZ0M2UyV0ZkbktFbWdCcHRzckNYSWVJVERSSFA2LzFCUk5wanJqaVJP?=
 =?utf-8?B?OEtNZVZ5NmVSOHU4UEdHT1Z0YUVhc1NuSFVwYmM5ZGpnMStyeGs3YjhOQU93?=
 =?utf-8?B?empvQVRSeDQ0REJQNmVQNFFJdkJrbG1KR2lRa3Zpb0RTOEV1SnFXNjRTVVF5?=
 =?utf-8?B?YTcwcWN1R0I0YnhUdkRTRDVRVEhmQlBPRmNZNitrYmI1dmwvWExxYS84V2kr?=
 =?utf-8?B?UXp5c2ZGa3NuRmNvSklFTVFLQXhRMEEvNGpoREtKYTFWVXYxK1RFZk1Tc01J?=
 =?utf-8?B?dC9HWCt1ZC95dnpiSUJrVlZBRTNWZjYvVUFNSW1vNmlFcHEwazBkUmR6eDFY?=
 =?utf-8?B?YllPMml5Y0NnUkdDR1ByN1VmTlFOczB2dlVVM29DcGVETGp3Nk5FZ1o1Z2FP?=
 =?utf-8?B?TnFhdlpiT2o4RFhUZmRLOUkvZ0JtSUw5OEdBeTN0N2poVGp2TVhid0gyeWNN?=
 =?utf-8?B?WWc5R01ncG5HbWEzbVd5Q0xXS2YxY2dqYVdoYXdXV1lBNWJpKzNQTmVrTUNH?=
 =?utf-8?B?elVYUjdHTDNHaEQ5Tm9xTG9jN0p2bmtmRHlyMm9Zbnk4RGlHdFJEYVIwSW0r?=
 =?utf-8?B?SktZNTM5N3JpTGJuZHVKUmp0N3ROMEZNTlpnSlZKNms2YUQ5RFYwNjZmckZ4?=
 =?utf-8?B?YkN1UjZQN3dNbVgxNzZBQjkwWGVVNU9pN05NRXlkUnpnSWh4d1d3WUZJQnM2?=
 =?utf-8?B?eXlWZ3c1amhnUm5NazZoOVNzS3F3VHp1dVRrV2dlR2FqN0RVUkowcjBBSzFx?=
 =?utf-8?B?eEdvNlAySjhXVmtLSTcvTnlMUmRTWDRSTzlBaFpzYlBnL0ZmVndjTVFZU0Nj?=
 =?utf-8?B?MTRzaDkrRnlHalhTUkZHK2hLekM2SWRvb3IrSHJzNFFoUm1KTDVaalZQTGd0?=
 =?utf-8?B?RnBmcjA5Mm9sSE01ODdMMERXVkNBVGhnU2xqOGpuQmV6T3E5YklOTHgrMVJQ?=
 =?utf-8?B?eE9hR2VVVVhpazI3RllFclowcXJOWDlFT0ZobEk5MGR3SHh0R0ZMZzhMR1Qw?=
 =?utf-8?B?SHBRRXJWNUlMRy9ZOTZndm9LMGJJM01IOG42aEdTRk1GQVY0NGJidW9pV0Fo?=
 =?utf-8?B?K0loNFVieDlaTkF5cFRINzErakRlaWwzUnY3QUtSeENDejlYa1QwM1dtbzhC?=
 =?utf-8?B?bmVnTlk3aThyeTlnOTJTYnJwakZieWM3MHVNaEZNbjVvcmUyck9CaGNNU3hR?=
 =?utf-8?B?SHk5WW1kSjJUeXUyNlF2akorMmozQWxIWlhhZXFZeEVTVTBuRE16WlM2blJ0?=
 =?utf-8?B?cTFWUVBpTnFubzQzb0t3ZmFlblM2MUNvRE4rUE11WERicCt6TzdVWWRPSzli?=
 =?utf-8?B?aVJ0MDRqVkF5U3dBdVhLcHNteU9QbFY4dFdVMnEwZGRUUWtCTEJ5ZlFHZnFs?=
 =?utf-8?B?eHI3YUZ0Y0xRb0M2U0N2ZGhsbXVoNUNLSUNtYUdWU09XR2tESXZnVEJLS2dR?=
 =?utf-8?B?dHV4Q1hmNnE3TW1Dc2pKbHU1TmsyWUVGTmk5eS8rSW5nRm80bXA3M3d2QXdl?=
 =?utf-8?B?amIzMjR2UUF3bEo4cHRJQ05rTitTcS8wYkZ4ZGZwSWd4NlJWTkxWWjJmcTV2?=
 =?utf-8?B?UzZhaC9aelVIWnp1WUwzbmtNakFHdm9NUUpsTytGM3pDN0FRRTRwdy8vOVZr?=
 =?utf-8?B?TFVCTzdQYkV0UnZTOWdFSElBT1VCbmZ6YTBwZXQ0UGdQRlcySUJTcGlvSkJJ?=
 =?utf-8?B?cElHeG5LemZhUUhDMVozck1RZkFPTFdyZHBiekpqNjhlNmc3YkNIYUsvSUJ3?=
 =?utf-8?B?cmh0NFVZcDRSWW1FSk81dGlHZlc1WnRlTjk5SThYcUZoL1VpdWIrbGlSQ2E4?=
 =?utf-8?B?U0sxOGNXOFZPZ0VMQzhDZGUxWDNNaXFTeVNWL0IzU0ZxMDVpKzg5WWdEOWc2?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c69e0c-f418-4601-35d9-08ddfb77a51d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:35:44.8628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GywrK2v/jFl2nt7FECAa4baKWM041I7uke2+UwknHVjmnEj7d8Eu+3Q7dQRvR9dFIPjmw0YwAnz//mBl5z7TqLzYn7o9XGcXsjTlEPiqQqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6604
X-OriginatorOrg: intel.com

On Tue, Sep 23, 2025 at 05:25:01PM +0800, Jason Xing wrote:
> On Tue, Sep 23, 2025 at 1:48 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 09/22, Maciej Fijalkowski wrote:
> > > Devices that set IFF_TX_SKB_NO_LINEAR will not execute branch that
> > > handles metadata, as we set @first_frag only for !IFF_TX_SKB_NO_LINEAR
> > > code in xsk_build_skb().
> > >
> > > Same functionality can be achieved with checking if xsk_get_num_desc()
> > > returns 0. To replace current usage of @first_frag with
> > > XSKCB(skb)->num_descs check, pull out the code from
> > > xsk_set_destructor_arg() that initializes sk_buff::cb and call it before
> > > skb_store_bits() in branch that creates skb against first processed
> > > frag. This so error path has the XSKCB(skb)->num_descs initialized and
> > > can free skb in case skb_store_bits() failed.
> > >
> > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > ---
> > >  net/xdp/xsk.c | 20 +++++++++++---------
> > >  1 file changed, 11 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 72194f0a3fc0..064238400036 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -605,6 +605,13 @@ static u32 xsk_get_num_desc(struct sk_buff *skb)
> > >       return XSKCB(skb)->num_descs;
> > >  }
> > >
> > > +static void xsk_init_cb(struct sk_buff *skb)
> > > +{
> > > +     BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
> > > +     INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
> > > +     XSKCB(skb)->num_descs = 0;
> > > +}
> > > +
> > >  static void xsk_destruct_skb(struct sk_buff *skb)
> > >  {
> > >       struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
> > > @@ -620,9 +627,6 @@ static void xsk_destruct_skb(struct sk_buff *skb)
> > >
> > >  static void xsk_set_destructor_arg(struct sk_buff *skb, u64 addr)
> > >  {
> > > -     BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
> > > -     INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
> > > -     XSKCB(skb)->num_descs = 0;
> > >       skb_shinfo(skb)->destructor_arg = (void *)(uintptr_t)addr;
> > >  }
> > >
> > > @@ -672,7 +676,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> > >                       return ERR_PTR(err);
> > >
> > >               skb_reserve(skb, hr);
> > > -
> > > +             xsk_init_cb(skb);
> > >               xsk_set_destructor_arg(skb, desc->addr);
> > >       } else {
> > >               xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> > > @@ -725,7 +729,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > >       struct xsk_tx_metadata *meta = NULL;
> > >       struct net_device *dev = xs->dev;
> > >       struct sk_buff *skb = xs->skb;
> > > -     bool first_frag = false;
> > >       int err;
> > >
> > >       if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
> > > @@ -742,8 +745,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > >               len = desc->len;
> > >
> > >               if (!skb) {
> > > -                     first_frag = true;
> > > -
> > >                       hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
> > >                       tr = dev->needed_tailroom;
> > >                       skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
> > > @@ -752,6 +753,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > >
> > >                       skb_reserve(skb, hr);
> > >                       skb_put(skb, len);
> > > +                     xsk_init_cb(skb);
> > >
> > >                       err = skb_store_bits(skb, 0, buffer, len);
> > >                       if (unlikely(err))
> > > @@ -797,7 +799,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > >                       list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
> > >               }
> > >
> > > -             if (first_frag && desc->options & XDP_TX_METADATA) {
> > > +             if (!xsk_get_num_desc(skb) && desc->options & XDP_TX_METADATA) {
> > >                       if (unlikely(xs->pool->tx_metadata_len == 0)) {
> > >                               err = -EINVAL;
> > >                               goto free_err;
> > > @@ -839,7 +841,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > >       return skb;
> > >
> > >  free_err:
> > > -     if (first_frag && skb)
> >
> > [..]
> >
> > > +     if (skb && !xsk_get_num_desc(skb))
> > >               kfree_skb(skb);
> > >
> > >       if (err == -EOVERFLOW) {
> >
> > For IFF_TX_SKB_NO_LINEAR case, the 'goto free_err' is super confusing.
> > xsk_build_skb_zerocopy either returns skb or an IS_ERR. Can we
> > add a separate label to jump directly to 'if err == -EOVERFLOW' for
> > the IFF_TX_SKB_NO_LINEAR case?

Right, I got hit with this when running xdpsock within VM now against
virtio-net driver. Since I removed @first_frag and sock_alloc_send_skb()
managed to give me -EAGAIN at start, skb was treated as valid pointer and
then I got splat when accessing either cb or skb_shared_info.

So either we NULL the skb for xsk_build_skb_zerocopy() error path (which
would be fine even for -EOVERFLOW as error path uses xs->skb pointer, not
the local one) or we introduce separate label as you suggest. No strong
opinions here.

> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 72e34bd2d925..f56182c61c99 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -732,7 +732,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> >                 skb = xsk_build_skb_zerocopy(xs, desc);
> >                 if (IS_ERR(skb)) {
> >                         err = PTR_ERR(skb);
> > -                       goto free_err;
> > +                       goto out;
> >                 }
> >         } else {
> >                 u32 hr, tr, len;
> > @@ -842,6 +842,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> >         if (first_frag && skb)
> >                 kfree_skb(skb);
> >
> > +out:
> >         if (err == -EOVERFLOW) {
> >                 /* Drop the packet */
> >                 xsk_inc_num_desc(xs->skb);
> >
> > After that, it seems we can look at skb_shinfo(skb)->nr_frags? Instead
> > of adding new xsk_init_cb, seems more robust?

Thanks! I'll do it.

> 
> +1. It would be simpler.
> 
> And I think this patch should be a standalone one because it actually
> supports the missing feature for the VM scenario.

Hi Jason,
in commit message, I wrote about enabling tx metadata for
xsk_build_skb_zerocopy() but code did not reflect that as you point out in
your later reply.

Unless there are any objections I will actually enable it there.

> 
> Thanks,
> Jason

