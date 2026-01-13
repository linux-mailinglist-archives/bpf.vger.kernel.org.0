Return-Path: <bpf+bounces-78723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B55D19DB3
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 16:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD627301679B
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 15:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DD1381715;
	Tue, 13 Jan 2026 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GuMk6lLK"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2D92D8DBB;
	Tue, 13 Jan 2026 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317196; cv=fail; b=tEIQasEIs9USzs1eQYkmvPpkP6SNySJ9cNpdD9PdDjOFAwHGimMcy3Gzu9T50CsrKPYe7OzuFxnbBWHc9F4pjOE7HBhl9DgTIadmzj+20627tCrPf1tswx19Vr0gO9PTBMteCL2GS+J83txWXizQz6Zp0GmLa3E3U2u83rwZ8Wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317196; c=relaxed/simple;
	bh=BH9tyVQkdJJOfUYYZYLCIKVccw6kQsjBTLsfn0dyoN4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RRh8jVHFsAyJHJLBF4+/gOjgD/XFk/7ktg2w8w9dPRXbWCer4I2Gqvp26XXGo6AvrtenR6OUDmQyYBv/A3i6jANk99BOYqZy/lq/MXoZT1SPd7LnfWqAbhPh56keq6awrAjHxf8XTmKzjY/wh9e8B0RCm5IBT3XKpAWWbmgEXpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GuMk6lLK; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768317195; x=1799853195;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BH9tyVQkdJJOfUYYZYLCIKVccw6kQsjBTLsfn0dyoN4=;
  b=GuMk6lLKHKiy+5w41v50uQoREIHRk9hEiAlWnFXiDIiUlY7R2rntDy0o
   Cc2kSwWVS+LQYnUyKjMZGVv1joCKrEyjvyytVJWlzwyNKTK9HsfEt/Rd+
   LnitQHQQH/eoX5RkzUXmjYcgXZa2YdTxDRAJEXVk5Be1oheVPM/jn/Hj9
   /du8nxI4c+z4r0hENp5N6EEGpHG9RAKMU048wuyotyczfovNiwdJ2U7xR
   TGp6Vl6lwALBZFxM+UgvFjnnvj4em8ak1I6C1C60JmYmhVnA1NbURsKWN
   9j7mzD5SXLW/eUQzCkBLNgJB/c9g9qelDmv4bsbqInX+UKifxqD1NPquE
   g==;
X-CSE-ConnectionGUID: d7x5AVOgR6a4oqvhRfXsTA==
X-CSE-MsgGUID: B3Ae3rfxRl6iIemIsLOO/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="73446144"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="73446144"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 07:13:14 -0800
X-CSE-ConnectionGUID: 10qTj8PZRwuBz+0FwogXdA==
X-CSE-MsgGUID: 4cYPPR15QxaZ+mwig4IMBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="209244538"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 07:13:14 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 07:13:13 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 13 Jan 2026 07:13:13 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.61) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 07:13:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsWtCxb5lN4YEFVlkk9HtsCp9AxjV/ydYC01QPhaXKTG/1lJEOyTpcfSJ+d3b3EQzZZz9j31d2LCvV5kAEWauElRND/mDd93iBLj7k6+bMFD8nZVXVRz215VXBiIRz/u75/zFQeOq6Ipvs+pI8hzcPFDtLA6rdTpSPPJvcUyD+iZXhZG7zHgf3Qw61EtgiR570BHR3ziZDxWXYbOLR5izdVOFq5wsrTfHAUSjElcWW3SFIHvcAC4OjFdW8hbU7xYLtjiilpBIhw1PJtB85jlx0z5xYXVt5B3ppt7IIj34xYMl9LZZItrOXysusUWLCzfhleaklkjoHkq67jdWiJx1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A64ziaokVGv87cA5Vo8L3xr0VHYkHiUcj1l4Yr95+9M=;
 b=hSIVjIl/p2tvuJ2mZJxU66pgk0IfyZZoMMFemNVsUdl9wcqYfctchy/CeXJAb1YDluC6sWpL5YOWqvV3mJwLtZbsmlg3GgQV+x2jaqgi2KDNPz8Mx9+3dWsGp+0IJ+fsFTRbXNoyTaV9yAa6XVG6CcjpxowdEu6ne+rt67xdjESBp0cYqwFdqb1+FeTAyKVCfWGgSUfsr3X6Ol3+/fj4j5zkt4kHm/bTQpVyUhdcMAOME6A5DMf7lzVg1G66bfeKY6mqyjyHLqOTnJTW6w33nkmllWO4fXGUFwKjPZBG2sxsrBzle1oe3qKFcpEb41HKsjvYikh3o7pm+Hz3dY98tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH3PPFEEDD586DA.namprd11.prod.outlook.com (2603:10b6:518:1::d5e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 15:13:08 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 15:13:08 +0000
Message-ID: <207d97d0-8750-44e1-8618-78e936f54750@intel.com>
Date: Tue, 13 Jan 2026 16:09:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4] idpf: export RX hardware
 timestamping information to XDP
To: Paul Menzel <pmenzel@molgen.mpg.de>, Mina Almasry <almasrymina@google.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, YiFei Zhu <zhuyifei@google.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
	<intel-wired-lan@lists.osuosl.org>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>
References: <20251223194649.3050648-1-almasrymina@google.com>
 <43dafae2-e1f1-44ce-91c1-7fc236966f58@molgen.mpg.de>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <43dafae2-e1f1-44ce-91c1-7fc236966f58@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0202CA0010.eurprd02.prod.outlook.com
 (2603:10a6:803:14::23) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH3PPFEEDD586DA:EE_
X-MS-Office365-Filtering-Correlation-Id: e838a717-2d5c-4fff-8577-08de52b64267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVc4YXlsNFFITDZERHVUVkFzVWNDTjVjSU9SQUpWbHdnZVdyVkJWNmFzbDIr?=
 =?utf-8?B?eVdWbWc0U1JKYzA2QXl3a0c4UEI5Y2hxVzhKN1I3eCt4WXBnZnF2Ym5TbFVX?=
 =?utf-8?B?T0JobHhMb3M1K2Z3aEZiTWZRUXdya1BPelZ1YkVoYitlaGFtQS9aci9MS1d5?=
 =?utf-8?B?bnhwWlIwdWR5UWdFMXhZN0hKek1lYi9qNWt6a1B0OWpKZjU4UDhoQVVPQWhR?=
 =?utf-8?B?K3ZqT0tJdm1qK1VaS3czMndKY1I2eWJvMHlrcEllVjdRVjB3cmwzN091U2xz?=
 =?utf-8?B?Vm1Mb002aUVtcXcrd2ttbnpNNzJMeWc0OEs4aGlJanRJQytmMzNrbVBaR2g3?=
 =?utf-8?B?VWxleGd5cjFLT1FwamdsOHhXWGdZd2dsVFp5aUxyL2NZQzBwMUJXK2dJdm83?=
 =?utf-8?B?NXRVLzN1a1NlV05jU003c0ZDdDNSNkpPQmplakE3T3hPSEdHWTVjVWFTTFBi?=
 =?utf-8?B?RnZIQ3N3QzArQkE3bkVTZXBSR0FaNUx1TnNCa0hPZFY1SHFoUEI3Vnc3Tkhv?=
 =?utf-8?B?UXdhWk1tbE1PY2g1Qy9iUFNPeFNsTEh6L3d6VEhVaUk0Q2RaMm1MR3drd2lv?=
 =?utf-8?B?bURIMTA4aE1zVkwxL09ZdllpTDNpMFNXS0dkZnV4S1NpZkhEUWtxUlh1dFpa?=
 =?utf-8?B?SEVGK21Eenl0SVR2ejVyMmZwTmtETENwaTMzT0hIbTRmT2kvVmxuTHFUdzFl?=
 =?utf-8?B?K05mSEpYdUVwQ2JHU0FFMU1Jbkgvd2I5eU5DMlFWNDBUM1BiL3FNclRKSTQw?=
 =?utf-8?B?SUxUcFpwVEIydVJtVXRWdG02b2lSQks2UWI4eHEwNjltM1BiK0pFcFAvTzB1?=
 =?utf-8?B?cTdZS0VlaGhGUTZPT21NNEtXNnhrOXBVVzBYZFNwNHRwekhWdHJkSDNQN0ZI?=
 =?utf-8?B?OC9URzNHMUpJV1lGa2ZPQ1c2Z2wvYjRvVElPeUtkekZDNk85ODNvNzFkZWRJ?=
 =?utf-8?B?WmppakRnQndZamYzT3E3cFlKYm03NTIwMWhpRXJyS3VsdjFnVEsrQ3FWall5?=
 =?utf-8?B?YlpDQm5wN1RYYnJSVkNxZjJDREZpOWRoUEFSMUdOOVRCci9RbUMzejRzUmI3?=
 =?utf-8?B?ZkQyQWkyR2Zzc0N5M3VlVkJ3VGJuZTkrcklkRFZnM1FKSjVPb3VudUpiVEsw?=
 =?utf-8?B?QWdoYjRrSk5XRTBCYlYxdGFoaHBma2s5NlRkV3lTeXRJSmtDR01jdWdHb2tw?=
 =?utf-8?B?dVZ6cU9OWktYMlhHVC91VUwzMmRtRkowTEtmQnMxNkxveUYxK3pHWkg3L3J0?=
 =?utf-8?B?alRZWGNHb1BpZ1ZHcnoyQU5ndDlNTXpCaXVGSXl0RVQ0ZFUwcjNuSDJxTlNR?=
 =?utf-8?B?eThYSm5XWG9FS0NwMGhuNVN4Q0g3RUY3RW1iMTNGMys4V3NpMDJ3OWZ5Ykhl?=
 =?utf-8?B?K3dwUFhRZXd6UGd5Yy9yUVlHZ3VsaVkvY3pRZjFiYVdaWTFtZXFVZStaWEN5?=
 =?utf-8?B?REs2Slg1TEFWV3lCOUxoSkpXRDd0d3RTSVJ1c0p5bjZOZ3ozbzJaN3MzY2hE?=
 =?utf-8?B?bzJpSmlrR2NaUFNOUkZBdGkrUi9oeXNESlE2Qk5qWWppYnM4OVpWa3lrT0Nx?=
 =?utf-8?B?aXl6am9NTVFYRjEvbS9EQ2NPcGVmM09Vc2RRbFNGS3FpSkdmR0FDcXRDUC9r?=
 =?utf-8?B?Tmk3NkpRczN3RTQzbDI5b0p0ZEVyNURkcDc1bHBialhxS1h2M0dYOVMxRTJS?=
 =?utf-8?B?Q3N3OGtVM1pnaXliaUlkTUJUUXJNbjJ3TFllTWNmR3c5a21sU3kwYm1jemZW?=
 =?utf-8?B?cmZDdzFpUXlNNnBXdjFzMFQ4dmlIc2MrSjVVWElyUlRVeU4ybG1oS21JZS91?=
 =?utf-8?B?bG84UUhwUU1lbVZxRE9CMDlXcHV6TkdCOWlmUTZqTjlrbmF5bThYYy9VbXpo?=
 =?utf-8?B?bUJ2b0RkZDZBVXl0ekIrWTFnUzFINUxnRmtOckxSbFpnaE11S0FZOXVjMXov?=
 =?utf-8?Q?Wi7uVDmjMq9fDtFgu42b21GfnCzghMIE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGNqc1laMDBzSUJRYXJkMWdUR0JZQ0JVRW9TU1R0VDJvNlEwbmt2SmwvR2ZY?=
 =?utf-8?B?L2VrZlgxWWliK2NaTzBVSllJUEpKbXFMWWhGZDB2K1RBajcxVDRRLzhreC9w?=
 =?utf-8?B?YkxBRFRWbGQ3T3E0N0ZVMXJQR1doTCttaTVxYWVlSDR4RHhWUHhMOEVEWHM2?=
 =?utf-8?B?b1hwR3BSd3RBYVhRaGRLNVg4Y0xFaVN1NzArMGl5bkd6MFc0UmwzT3NSM3Ax?=
 =?utf-8?B?YWd3MmJ5NTJoUUdINFRXNm0vYnFNeDhSNnZvNlJ5aDdRRlBOdHRWdE1LRlZx?=
 =?utf-8?B?Vkc4L1dDV1dOQXBLdWtpRWx0VTByVzJIV2syS0FnL2dvNCtETXBQZWlmdi96?=
 =?utf-8?B?ekllZ2M0Nmg4WGdCaFhmbzFuY3IzV1UrUlozR0J5ZGNzcDc2VERROHBWczU1?=
 =?utf-8?B?Y3lFTURMRGwwS2crV3lmV0NaNFAreVN5aXZIaXROWk1oK2ppeCttT1VMdGt5?=
 =?utf-8?B?VE84ZEpKV1lDVXZtNUNCQ1VVSW9DbTNJSGM2RmJDWHR2ZHVMT04yai80SnZx?=
 =?utf-8?B?ZnVkOVpQc2tLNGJPWXRsL3JoWVIvV291ZktReElmYjJVRkYra2xHSFpnR2hN?=
 =?utf-8?B?bnhFNTd5eGYwWUdUY25iK0xBalZKMkZBbzcxOFFLQlNkTVNsV1FTcEp0ZXNs?=
 =?utf-8?B?QWxEcHg3R1Njd3JXUnk2MHAxdk1JSmx1dTM3TzNEWjVwN2dDVUNDV0sxQ1NI?=
 =?utf-8?B?c1o1Sjd0M2MydElGWnBGRm5oTTJOYXUyVml2Ykd6UUVGSWR1bTh5UnQ4bUNV?=
 =?utf-8?B?QnVlVWpBdk1IS0NsbnFGTDdHWk9UVDlUZi9ZOW1nN0ozMDJSYUtyWHNFTDVW?=
 =?utf-8?B?RXErdmtsTlNVT1FYdkFjWTB6dUdJZFI5Q3hBVzFhM21DSjlqdUpaSjJocTlj?=
 =?utf-8?B?SWJVeWlCbGVjWGF6VHVCWTNXWnZoSHVJcXNuZHpWVU1ET2lLRlBlTVJTR2t5?=
 =?utf-8?B?Y3Zkb09GM211dThEaS9HQVNtbW1mRFd5M0xHREJiekQ5S1QrM2dpTjRvU2VH?=
 =?utf-8?B?djgvbVJxWEFXN0hTcXpCYzRNZ1lwb1lPRldhMHpKTG0ya05zZHVuZDUxb3Ez?=
 =?utf-8?B?czRPS1Evb1hFWFlWUW9ubUJLZzNKcWthdHZCUStSQkxOclArWGtKUXZCZHQr?=
 =?utf-8?B?WGY0R1RDSTlNVDhVbUh4TkVmdFczeDV1QUY5WXdlSkdKd2FsSGgyemRGWDRZ?=
 =?utf-8?B?c1RPL21RM1dxdlVuR1NXc0ErZUQ2WGN2WE9rdnlhNm03Y2VydWl1clVmZWg4?=
 =?utf-8?B?RjlGT293QnZCYU9uV2dFVDh5KzE5RW91c2NLbmJ4NzhkL3RoallmRjl3OVVt?=
 =?utf-8?B?UEpNOXh5SlhRU0VDb2s2aWRiSnk2M1ZhZ1dqTUo0c1hBbmtHeldVSFltTWJ5?=
 =?utf-8?B?NXU5ODd4Mk9YUFc1bTFPNC9VZ3R3M2ZhR1pWVjczYklsOER4ejVLR01aNHBN?=
 =?utf-8?B?RjNDYjRFbGcyR3QyNy9XQlJvTERiRWhkU0wwN3FzZkw5YW1FR0VRb1ozcTR5?=
 =?utf-8?B?bWRBYnhsMFM2NE5UMzU3clRKNlpyelBTMmRpbHJDVFJSSTJtdHlxV1FjaEdk?=
 =?utf-8?B?dzIyeDlTNVBKMC9tOHg5Z1NFYXUyb3hiRmZCZ0dFaStUZldQRm5naVpRVU5O?=
 =?utf-8?B?QU5lT1grMXFCbDd0eGx2QjdIb08zNVdDZ3p6SGlzT1ZIb3UrZUJPNXpPWXIr?=
 =?utf-8?B?VUpGVGppMkl2NlUvUzZ0TmRPN3ZDRGZFRkdrSVFNQU1LY2l5cEVwVTZwRUo4?=
 =?utf-8?B?eVhac3YvelUzdHpmclo4UzVDdDBRWUMvZmdJOTRlKyt3aUp1RVBSWDlQenJY?=
 =?utf-8?B?cW5zak9ZOFpIODZtQXE5YjZITU5VNmZhZUxXOW5wZHFTblBxeUV2dmdMc1M3?=
 =?utf-8?B?ZVM3cXdrbG9vMmJkVEVKVm5tWWdPb2xQdWhUN2M0VjdhcnNna3R6cVd4RTJV?=
 =?utf-8?B?NFUyZW1XVkhxT1dxbU02L3BrcVlQYmVlWHVHUlpwYUdTMkV6eVdHc2VUUXVT?=
 =?utf-8?B?ckFuQnZRY2J5c0ZBQzJ6MElRODE5N2tpeHdDNnFrb1pEVFJnckY3UmZJWm1K?=
 =?utf-8?B?WUJsSmdyU2ljQnl6YlRkUFNzMVBPQXQ3L2NJSmZ1bXZyVkV2M3E3cXM4VTRu?=
 =?utf-8?B?eWhwbDFtcnU0Sm5xb1J6cU1aTUhRcFpzK1hWV3JJR2QxUm91a1ZGYXFSZ0Nt?=
 =?utf-8?B?SlVYUHhrWEdjVDZNMnZZZWR5RjRDVzRqaVlOeS8rT2VGTURNY25hZ1RaNTFk?=
 =?utf-8?B?MDRvTVpOMndmdU80RnJGOXlyNjl0blk5c3V4NkttSFpjWDJPOC9Cd3RobHhD?=
 =?utf-8?B?amFNU0R4K3JSNGdISCtscitCQzcwT1d0Tm1NbHdPZGw0cmYvNFFGeVlGbXlq?=
 =?utf-8?Q?mtYvSnZr8nlpfZe0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e838a717-2d5c-4fff-8577-08de52b64267
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 15:13:08.7687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDm1pzDao6XHO9NRi7pqGnAzlLvvbJAXD5tvFaoFG4bTfnW6BllsGGSlf9gRdEHqjVGXOODm8+WbV4oMhXXjs5UK0YNrCcK0IMqLNupFPyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFEEDD586DA
X-OriginatorOrg: intel.com

From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Sat, 10 Jan 2026 09:35:58 +0100

> Dear Mina,
> 
> 
> Thank you for your patch. Some minor comments, should you resend.

[...]

>> @@ -166,6 +173,19 @@ idpf_xdp_get_qw2(struct idpf_xdp_rx_desc *desc,
>>   #endif
>>   }
>>   +static inline void
>> +idpf_xdp_get_qw3(struct idpf_xdp_rx_desc *desc,
>> +         const struct virtchnl2_rx_flex_desc_adv_nic_3 *rxd)
>> +{
>> +#ifdef __LIBETH_WORD_ACCESS
>> +    desc->qw3 = ((const typeof(desc))rxd)->qw3;
>> +#else
>> +    desc->qw3 = ((u64)le32_to_cpu(rxd->ts_high) << 32) |
>> +            ((u64)le16_to_cpu(rxd->fmd6) << 16) |
>> +            le16_to_cpu(rxd->l2tag1);
>> +#endif
> 
> It’s done elsewhere in the file, but I wonder why use the preprocessor
> and not plain C code, and let the linker(?) remove the unneeded branch?

Do you mean IS_ENABLED()?
In the libeth_xdp code, several paths won't build with IS_ENABLED(),
here in idpf it might work out, but I did it the same way as in
libeth_xdp for consistency.

> 
>> +}
>> +
>>   void idpf_xdp_set_features(const struct idpf_vport *vport);
>>     int idpf_xdp(struct net_device *dev, struct netdev_bpf *xdp);
> 
> 
> Kind regards,
> 
> Paul

Thanks,
Olek

