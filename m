Return-Path: <bpf+bounces-78544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 909A9D12507
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 12:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2BB63011AA1
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 11:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AED3557E4;
	Mon, 12 Jan 2026 11:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P4vcQFv1"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8432DA755;
	Mon, 12 Jan 2026 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768217573; cv=fail; b=S3Vig83QEndnqREefAD7FvnorYLmPPG3QmhVig40KipCjm9rkAUA8uV2OCDj4xHUuxL+Gru7ozfE1QwH/FKoSbj+0LWsHYytMkyzBlD1mJz9EO/Kgutj0K6koW2pgTLuiMFOVhQ9JOZixQ7jqO3gDG9qHIxISGu7gm3dDmmVxRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768217573; c=relaxed/simple;
	bh=3UWOTtHlliMTyBXVeHloKSMvTUL4l0RJWqR9VZlBvcA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CJCe27+YB1SPAu44QzNaj+RG0y6Rery/37UDW6Fxu+hchw0kmB2P34+MwKFBWrxMXAIiq5L+22gWFFcxr6iy9iNgPPXSnFWZNdFOfBcXEo8hD86GMWKmMBhm/ErIKNGyvw8bzR0pPJfJjtHYW8+1Gl0d4Ci/YZURysFSIrdpp0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P4vcQFv1; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768217571; x=1799753571;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3UWOTtHlliMTyBXVeHloKSMvTUL4l0RJWqR9VZlBvcA=;
  b=P4vcQFv1XFg9E6LK0IcmYaGBUkABpz3RKk9LWPKdNl/hSjuq4+Pcbu+6
   3HAn5O0EePJKN0/lBO7tr/PRY8/03ibyKIgmWGUX4DqciHfaKvvblM7g+
   oayow8FhUampTzyK9NHhQwpbthMsKRDtgE5Zm1+oON7BdZ/1w59TbomRE
   SVoCxP5n86B1GkYy2uc+wm347i5eFmWqApy3jF5rUQNtcINEVlDFaYQf0
   ZywEobxUGf59Z+U3fad7IEMxcr0Br+TRzVOlWhi8KqrbQg95pTg/XnMeQ
   KQi987LGbYHFlq38LQllKAoCeB1FlBrse5LRsYheMnXWbKS+sBltwZ5TB
   g==;
X-CSE-ConnectionGUID: VbqHCLXdReqU+wbpymyihg==
X-CSE-MsgGUID: QcxHfU44QI6ygkD1nxeIQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="68694047"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="68694047"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 03:32:50 -0800
X-CSE-ConnectionGUID: xmqbndTYTiu13iZziaybKA==
X-CSE-MsgGUID: WK0OTTrBREqu2Ec/ZoKnlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="204085318"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 03:32:49 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 03:32:48 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 03:32:48 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.20) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 03:32:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LU+I/2jbJG0TKk/luLztr/8PXuCHDkMus+uk13Z48Hjifnwzqet3r/tC53cMW43Rh5/Vgxel2Fzni4n4tz84yKr74G63q0Zh5MmJdY9KJCf9ruMc4Gjcz96ST/XXKMtco/CrDFJXvcjwJ4M/KSSyXoPR2su7i3lRbsatLMslU3nrbQaXa38WyUZjTFRUexHHyvlUmqjip1RG4puqBuqwQ80SYwDhynSatyuRhu0Tdsdw5cFA5gDVUYUZriUPcqEUbMXE1aTLgh3Bz8a4lkwfcB2JPz7j1T7cgs9jNBLNpb3BjSl9LtSNsQaAbRW1kcit/XM4NyTehqHF2EwVnJb7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UWOTtHlliMTyBXVeHloKSMvTUL4l0RJWqR9VZlBvcA=;
 b=LtwUYyBXP2m58272sbNzvbeCb8t0AUy3JPg+ZAnL7guMxA8TCDHv1wiebcoDBYe3NPDn/oAVbCxiWcKujm90fYzodG30MxKqW4dVH+xLB1h1G68LUzdI2vaBY+pb1olrxcfu8KYiD4r+OU+n5E5N+LG/D4tq3iuG5txrWa1uBwpsBM+S1371TtL4oTFJpoX6M9jweE9td/i9yCtVT2v3J4yycNm+JZhts34bCfQ2R2HmfYFNH/R7SGvUZu7+DBdueZgva+HzPjgtbGB/90HQlkXBzy1iNlfsxDC+tEehziz1ddMbfEAX1te2GVZEFN7q4CWtJ0+v/dRVYZZt32ySIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH3PPFD6B8A798D.namprd11.prod.outlook.com (2603:10b6:518:1::d51) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 11:32:45 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 11:32:45 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Michael Chan
	<michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "kernel-team@cloudflare.com"
	<kernel-team@cloudflare.com>
Subject: RE: [Intel-wired-lan] [PATCH net-next 06/10] ixgbe: Call
 skb_metadata_set when skb->data points past metadata
Thread-Topic: [Intel-wired-lan] [PATCH net-next 06/10] ixgbe: Call
 skb_metadata_set when skb->data points past metadata
Thread-Index: AQHcgnTlll5DGdyV80OEQrm8CR4tcLVOaWQQ
Date: Mon, 12 Jan 2026 11:32:45 +0000
Message-ID: <IA3PR11MB8986C2ACC481EA48109A764CE581A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
 <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-6-1047878ed1b0@cloudflare.com>
In-Reply-To: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-6-1047878ed1b0@cloudflare.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH3PPFD6B8A798D:EE_
x-ms-office365-filtering-correlation-id: 4b2ecfc2-976c-49ff-0f43-08de51ce4e8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Q2J5RGdsNWZ6SktiMFF6Zkx4UE03RkJxcUQ4YmpNMFQxdXMzNktrcmlGeFBh?=
 =?utf-8?B?eUlQeDdTK0hrSkpmQnpaeHd3K1dEc3d4ekxTQ2lrYTJBNXR2WDJmdnUvQnF3?=
 =?utf-8?B?QkhhVUpTR3dqRUJ6NFhqenJ1WUk1YlVtNEUreFpZRUEzVWhJR254SUZGa29r?=
 =?utf-8?B?UXBCTGlWSGN1SmRhaUZLak9kOVJBZlFZM251NSszamN2TzNWQXhNS015b3lm?=
 =?utf-8?B?VXgrTWpOdnNvcHZYN1N1Q3lFaHdHOXMzZzVHSi9ySmFMTXVudFU0SjZ0NnRa?=
 =?utf-8?B?YWRLWGt4YXdiQ1ZvMXVqaThyaDFKZmRBNUdweFdDSVlpVFJ6SU1YRFEvRDFz?=
 =?utf-8?B?d0hZSGE0aGh5dGp2KzFsS1RKWFJSa1ZWY3BqR25CekxQUG5YS242TTVZOHdu?=
 =?utf-8?B?M3Q1THdua080blFJS0gxczhxN1p2dFcrengrZnNjNHNIMXR0MWFrME12alZ4?=
 =?utf-8?B?Rlh4RWRqc2VHRnI3cmlmNmQ0NFRoNldjRVBlUXZWUFQyU0I2S0hwR0NLQ0Rh?=
 =?utf-8?B?ZjVJa3VtTGwrUEQrTExvSzVIc3J1VmM4UWxJMGFYYXdSc2ozVnhGMVFueU9F?=
 =?utf-8?B?Zlh0azhacVM5aWhtTk1uem1FaG8zQU91K2dyaXVoVUhIVUlVbmo1V2dxQTNR?=
 =?utf-8?B?dC9jbFlXUTVoZEV2YURjQ3BTdWNmamY5UWlZdjNIcmZadjkrQ1VaZmdTU2lW?=
 =?utf-8?B?SFJPc2JWNU1FSnI2eEt2ZkdWMjFWNG51TFgwS1VobTlrd21JbHU2RFRkSkc3?=
 =?utf-8?B?VGNsT1U0bXFyazcxT2xmVGJXbG5zTW5kWW1LQUREaFhCTzJyMEEzVEF0bFI2?=
 =?utf-8?B?NWtxT1ZiMGpseGpWcWU0bHZMeG5Ja2o3MlhnWDh2cWh6UnZpeVBNbGw4YVJF?=
 =?utf-8?B?NThHUkxIaS94bUpSSzZJQWx6ckttanZsaDZlelNBeFpHYTQweUJORm5Yb0lP?=
 =?utf-8?B?M2JDV011R2pRcm5hVHZrZVJVVXA2RVVGYmc4OUpHVkI3TEFrQXQwa2xMd216?=
 =?utf-8?B?SkZFelMyalNoeUVGOTBEWU50N2x0Q053aFRZNk5acUJQTm9GNVhwWXcrUlVB?=
 =?utf-8?B?WHVHTFZ2NHUwYlI3MjA2a1hoMkF4d0RiN0FZR09pbkJIaHJWMHlaeFZ6dGZG?=
 =?utf-8?B?dUlWWm8vRjg5cldaZi9LRlptenZlTHoyRjZtWXd2VjEzRlpjclczeG00WW9S?=
 =?utf-8?B?NDRTWDhJcUFiRkZTZG1qc3ZSU0d1Y3V6ZjhrazlTSThTb05McDN4S29wNGtn?=
 =?utf-8?B?dHpld1ZMN0lXZERFSXJKMDRXUjk4NjZ2VENObFh2bUo5enVNZENkS2ovL3ps?=
 =?utf-8?B?VTBHdjNyelJTL2FEay9OS1haZFI0azVidXpkMjJlY0RMMFltNmloekFXWXNZ?=
 =?utf-8?B?REZpRHpleDN3S21PZXBEQlA5WDFWWHZ5ZjQ2aytGeWxlS2JaOTVmNFBtL1o1?=
 =?utf-8?B?Z1M4SXkweUs1dGUyc0YvYW1qdDN2YktyOHd3WjB0VkxFSkpjeEdlckQ3ME52?=
 =?utf-8?B?eXlVOGRhYWplUGc3aU9iMlJsbnVQY25FNEQrZnBET3dMMkZ2b2ZqckZ6cnFv?=
 =?utf-8?B?VTgzdFdYaUh1TnJnemEwcHM2NGV6Y2RSYnZ1VzZUYi96WDBrTEhYVlVkdVNx?=
 =?utf-8?B?VE5WMEo5dmVWVjV1OU1MUVdxOHlUeUpNR1BNNGwwNm9TVkpEaFNyRW5NU0ZL?=
 =?utf-8?B?NDQ3eFhQcDlQRi9XdUswZHgzZ2pPMlRiYk1nL1d6Q2hjVzlNZmFtcWR3NWhM?=
 =?utf-8?B?bTRyY2VFZHVRUW1FRHk2aXBHcHpvckRMeGdyM2hMU2x4bEtmWVREeWszOTVt?=
 =?utf-8?B?bDdtTjVDWFFOblFrQUFLelpjQm9YSnhRTG1EQzJyUEFqZ2NhVUNhdVV5YnBH?=
 =?utf-8?B?Uzk1eXdzTEgyam5IOHVrczB4bVZOeEhHUU4zY3RoM0kwTVRuOEJyQ2dmZTdq?=
 =?utf-8?B?NU44azd6REJLZ3FGWVVpeFpmTXVuTG9GUGpRaXRwNDdtZnRJVURRTXQ0ekov?=
 =?utf-8?B?ZUNheEFwRVV3ZW1mNEpIUkV2NzhkLy9wVFprR2dqcTVhVHpSR2xtSSs2bXJP?=
 =?utf-8?Q?BZgpDe?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVQ0SWZtd1pQUGQyNjMzMjFtWjNLT2VmUlBXWmE0OE0wcjByK2NqdndMVkYv?=
 =?utf-8?B?MFd5L25laklHZzNkRmczZ3BDdnU3R3cxZVNBRHQzSEs2TDdmYWVqTWFDemth?=
 =?utf-8?B?Ulp5TDRpTFkxOGFwZHBvbldkMVg1VGdWTi9Cb1h4enI1Z2NleHU2aXg3U0JB?=
 =?utf-8?B?cUNrR1lSNWRMMjQwcVh4YmhZK09BbzdGYXdYcTYxeHFVVTNoak1CYmdwVDZy?=
 =?utf-8?B?YSs3Ym93R1NaQmxXTEdtdjZickZ1ZHRLQlcxRmI0NHpYVlZDaDJJWU1yN0hh?=
 =?utf-8?B?SFB3WDR0TmFMbThtbUlLZDZmTEZwdkZvTjBnVEtSZGx5ay8wdEZjODNQU1gv?=
 =?utf-8?B?aEJpRWt5L3U5QjNzbFhYa3pqNi9rTmRMMUZuMHU2RkRNL0QrY3VxOU9NT25i?=
 =?utf-8?B?YzBXQnBLMitlWE5ycmNjSEJRSXkvSjZiL3drbHRmUlhsQnhNbERaSXBYYk1v?=
 =?utf-8?B?TEoyZnFnckMwQTJVeXliZDFSTFJTNG9lREZtc09BVUZiUE9QYTdTV2ZJUXlB?=
 =?utf-8?B?TndmdXRXc1AxTURnV04zem15SnY4bWVxZHQyb3dLUDhlSER0TklWa1dzTFpI?=
 =?utf-8?B?d29HRXlselJlNGk4dU00K1dTd0R1REdTY0VSR25BR1Zjd25LUVlaanpVaXpa?=
 =?utf-8?B?NEUreDdPazVRVzBDOFNsS01FVEs5TjBiSWYxNUZITVFrZXMvSU5rRzJiRnBv?=
 =?utf-8?B?RmZ3dzNROHNHQ2dnWWdzZEdiKzczV2ZaVWJQZW5ocUROKytzWG53WHRBMmhy?=
 =?utf-8?B?RnIrMy9VR29JeFpoOVFwNzhhZXhaL0tUZUx2UllYK0Jxc0xFUURWUXE3RkNU?=
 =?utf-8?B?d0JtbzlvVm5wcng0cnNIZkkzUUlCbXRsdjNEQitUd0RHajFVN0dHTXA1TVQ4?=
 =?utf-8?B?MkF5d2RrQnp1OHhPbFVlREdOTVI1M043WTl1bTlVRURSWDhIbXdxVEI5Nm1z?=
 =?utf-8?B?WE96N2poOFcxaC9jc1BlOHhRQVdsRnpQaHNlZHFtUXZIZ1RiU0RxZjVLMXVV?=
 =?utf-8?B?Qmh2M2UrZGxRdWx3Q1V1MlhKdEVHT244SzJwK01RbjVNY1ZaQVdUSzJ3QlI0?=
 =?utf-8?B?YnpjMml3TkhrRnhLLzlFVkFWTm9PMnhMQWlWRVVEdHVMMWZOZ0hEeUU1RU43?=
 =?utf-8?B?YU12c2dyRmlLNXNMTkswYmhiWEpydEhnVTA1YWJHN09qeU93cHI2SUxXTThI?=
 =?utf-8?B?a1lIV1pvMnBUWkZnZFRLYVAyY0QwQkkwNm1obG9OQWhhVU03Z2VPcktoVTIv?=
 =?utf-8?B?UFlBRk0zeHZ1VU93d2tZRDhycDRrUGcvODJRaFJnS2ZjeXRiRnd4RU40Y0ph?=
 =?utf-8?B?Y0VzUmZ6bHZmbFllUXZJNzFyTmI0dWhYTVRqM0Z0S29IQ2orRXZtWS8zdjYw?=
 =?utf-8?B?aitySHBNZ2xXTkQ5Y0RsR0o4MnNGYi9WZ2tPY2FjK3g5Y2QxbWtueXFPa21h?=
 =?utf-8?B?a3haWTdFY3dLTmc0elNhQlJqaC92cGhnWk9Oc0ZXalZ4cDYxZFlWc3BKdUVi?=
 =?utf-8?B?R1RleWh0a2tpSlBSNmd6aVpES0tBRXpnekh5dm5ZMytFTWl3V29BaVkrWFVQ?=
 =?utf-8?B?dXFEUjRyQ2tPU09kdGR1U3FycVFGMk0zN3ZJcFhxZWFuMVVUb0t4OVRLZmYv?=
 =?utf-8?B?VzVhM0FNZW1uZzNMQUVUNWFNUzNtc2EwcmtERzhUcnR0RUhSRVpVMjYzVkRj?=
 =?utf-8?B?ZTFJZkQxL1BBQkdlc2llaEZxaDZ1UXhITmNKczZMRElGNTVFUVRuT0FMVXhB?=
 =?utf-8?B?UFFMcER3N25WZkpkK2h5aTMwYVpKTnBzd2V1V2VURDI5QUZlZmVOWG9pM0FQ?=
 =?utf-8?B?VDBYMm1PdDVPWWhFQitrdHpRRkIzUmRPcC8xTzZNalFweGd0c2sza2VUQlBC?=
 =?utf-8?B?c3pmN2tBZTFYR1FaQjJMcVJaOXp1dkpTQ0t6ZklHYmMxT0J1UmtlS1BrVGc1?=
 =?utf-8?B?Q2p6LzlSMFhyRGJDSE5mWjBSaXZYZU9vNjEyT3pHempQYmpUUGZ0Y2t4dXhH?=
 =?utf-8?B?K0p6OGo1QWdmSHoxSnh3aVcxU2V2eXB6elBEZUFqNGI2aE53SzdXOHFpRkJk?=
 =?utf-8?B?OWFISXY2UmxnOGF1VWJsWUY5T2lOSUxlRS9RanUxNHZBWi93WlZRYVl1QzZv?=
 =?utf-8?B?ZDVvNU5lZnFUbVg2NU04QmZra3BvRmFMVGJ5N25Fb3c5T1NFUUpjRHY2L2NU?=
 =?utf-8?B?cTVqY3lwNUpGN1FQb3U1Rm5DN21leVZGZzNWbC9LcVpBWnQ4Mi9rZVRvRWk5?=
 =?utf-8?B?UVdDVlhpUVIwMURhWU54OW0xcnZhYmRPbTJLamNwWUhCOHFTNWVScjhBMUw5?=
 =?utf-8?B?VDBiRnFIZ1pqY2g2SXZqRUlNUUYrbkNLMkw5bG45UHVxR085bm9hdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2ecfc2-976c-49ff-0f43-08de51ce4e8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 11:32:45.5664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XnuymkAUlqH+pYpM31TxgoLjACjNE7ht244RAN88XUjMGpunHVPU+DWgVONMYA3FYL/PK5vBj3ukQkYlbqpY1WYsT+po0lqszBZ+qOwWFoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD6B8A798D
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgSmFr
dWIgU2l0bmlja2kgdmlhIEludGVsLXdpcmVkLWxhbg0KPiBTZW50OiBTYXR1cmRheSwgSmFudWFy
eSAxMCwgMjAyNiAxMDowNSBQTQ0KPiBUbzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBDYzog
RGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0DQo+IDxl
ZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBh
b2xvIEFiZW5pDQo+IDxwYWJlbmlAcmVkaGF0LmNvbT47IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2Vy
bmVsLm9yZz47IE1pY2hhZWwgQ2hhbg0KPiA8bWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbT47IFBh
dmFuIENoZWJiaSA8cGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbT47DQo+IEFuZHJldyBMdW5uIDxh
bmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBOZ3V5ZW4sIEFudGhvbnkgTA0KPiA8YW50aG9ueS5sLm5n
dXllbkBpbnRlbC5jb20+OyBLaXRzemVsLCBQcnplbXlzbGF3DQo+IDxwcnplbXlzbGF3LmtpdHN6
ZWxAaW50ZWwuY29tPjsgU2FlZWQgTWFoYW1lZWQgPHNhZWVkbUBudmlkaWEuY29tPjsNCj4gTGVv
biBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+OyBUYXJpcSBUb3VrYW4gPHRhcmlxdEBudmlk
aWEuY29tPjsNCj4gTWFyayBCbG9jaCA8bWJsb2NoQG52aWRpYS5jb20+OyBBbGV4ZWkgU3Rhcm92
b2l0b3YgPGFzdEBrZXJuZWwub3JnPjsNCj4gRGFuaWVsIEJvcmttYW5uIDxkYW5pZWxAaW9nZWFy
Ym94Lm5ldD47IEplc3BlciBEYW5nYWFyZCBCcm91ZXINCj4gPGhhd2tAa2VybmVsLm9yZz47IEpv
aG4gRmFzdGFiZW5kIDxqb2huLmZhc3RhYmVuZEBnbWFpbC5jb20+Ow0KPiBTdGFuaXNsYXYgRm9t
aWNoZXYgPHNkZkBmb21pY2hldi5tZT47IGludGVsLXdpcmVkLQ0KPiBsYW5AbGlzdHMub3N1b3Ns
Lm9yZzsgYnBmQHZnZXIua2VybmVsLm9yZzsga2VybmVsLXRlYW1AY2xvdWRmbGFyZS5jb20NCj4g
U3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIG5ldC1uZXh0IDA2LzEwXSBpeGdiZTog
Q2FsbA0KPiBza2JfbWV0YWRhdGFfc2V0IHdoZW4gc2tiLT5kYXRhIHBvaW50cyBwYXN0IG1ldGFk
YXRhDQo+IA0KPiBQcmVwYXJlIHRvIGNvcHkgdGhlIFhEUCBtZXRhZGF0YSBpbnRvIGFuIHNrYiBl
eHRlbnNpb24gaW4NCj4gc2tiX21ldGFkYXRhX3NldC4NCj4gDQo+IEFkanVzdCB0aGUgZHJpdmVy
IHRvIHB1bGwgZnJvbSBza2ItPmRhdGEgYmVmb3JlIGNhbGxpbmcNCj4gc2tiX21ldGFkYXRhX3Nl
dC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpha3ViIFNpdG5pY2tpIDxqYWt1YkBjbG91ZGZsYXJl
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9peGdiZS9peGdiZV94
c2suYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2Jl
L2l4Z2JlX3hzay5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaXhnYmUvaXhnYmVf
eHNrLmMNCj4gaW5kZXggN2I5NDE1MDVhOWQwLi42OTEwNGY0MzJmOGQgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX3hzay5jDQo+ICsrKyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX3hzay5jDQo+IEBAIC0yMjgsOCAr
MjI4LDggQEAgc3RhdGljIHN0cnVjdCBza19idWZmDQo+ICppeGdiZV9jb25zdHJ1Y3Rfc2tiX3pj
KHN0cnVjdCBpeGdiZV9yaW5nICpyeF9yaW5nLA0KPiAgCSAgICAgICBBTElHTih0b3RhbHNpemUs
IHNpemVvZihsb25nKSkpOw0KPiANCj4gIAlpZiAobWV0YXNpemUpIHsNCj4gLQkJc2tiX21ldGFk
YXRhX3NldChza2IsIG1ldGFzaXplKTsNCj4gIAkJX19za2JfcHVsbChza2IsIG1ldGFzaXplKTsN
Cj4gKwkJc2tiX21ldGFkYXRhX3NldChza2IsIG1ldGFzaXplKTsNCj4gIAl9DQo+IA0KPiAgCXJl
dHVybiBza2I7DQo+IA0KPiAtLQ0KPiAyLjQzLjANClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9r
dGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg==

