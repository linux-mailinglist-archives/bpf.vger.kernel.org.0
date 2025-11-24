Return-Path: <bpf+bounces-75390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C19C823D2
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 20:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1672E3ABD0B
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 19:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A678B2C21F1;
	Mon, 24 Nov 2025 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AB7JH4PW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFBC296BC1;
	Mon, 24 Nov 2025 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764011438; cv=fail; b=cdW+HzxUs4xqHC0z7YzTzsqfvu+SBUKNUrulvi17Ywoxi5UfjEsIzTqvchjUI+zKtChnu/QUzUXDV4ZkoMugHfjzqs6NIuC5yb/ZFwP6S2Gq3p020jUy4BwGqBABVvafN0TAnciWplZEsaAd+AwewARraO6tDxG87o+NGqvsaK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764011438; c=relaxed/simple;
	bh=OLWmLbXjpFiALMP2mPrzh20hx3wdLOqMwktD+Dz1jyc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C31/6+qw1FVkfu3s/cxlqP5q935lssoLdscoik8r0NU77714e98JkMKgkxY+66z2jsrB4c/q+ScY4mjD3zVZKTCIq42ZnqcDQmkmBT7Arl70zvj+7LrOk4Q0eJb4pLiNKSjiW8gV+Fi/3UAQIjaCJKnU1UFQ0iqtFiMOwnrG1U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AB7JH4PW; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764011437; x=1795547437;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OLWmLbXjpFiALMP2mPrzh20hx3wdLOqMwktD+Dz1jyc=;
  b=AB7JH4PWBHqsEwrwevbacHFOmEIaCiVdkPi0jdSoGjkU012WMTmFffh4
   gw7KjI6PEvPr83BFYKz/BBGRHWSs/vEPovqr9a+ZGX4LK8LLvr434Ybyv
   gCfWbrGY1Ap7dO5tSlB6shl74TN3lI0M0nTWtRXMXkqZUyVnmnvJsTwrq
   H1HyPXPjLMisdZ3B233Ip+JcwkzNGtbIPQl1CBPGC1j2P2bVXBz1E2EIP
   wFhpMRxFAl1GDQaZJ9h81KSFJaSvIgSu1BuGZhjGJzPAa9/5UOlbZDMos
   x28unczUmuCbvVBxOK29PtbvVR0s9Vr0Yr4GvucmW7p4IqaXS6lvtbocv
   Q==;
X-CSE-ConnectionGUID: I5QfkpmpQxuFyWhLw5Iihg==
X-CSE-MsgGUID: EVAISMBISf2WadSYMCqcrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="65972663"
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="65972663"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 11:10:24 -0800
X-CSE-ConnectionGUID: PdKwq7nIQwyQLUFjqeWr9g==
X-CSE-MsgGUID: ohIIxI6+TB2/+/dnVsCKcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="196583767"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 11:10:21 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 24 Nov 2025 11:10:20 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 24 Nov 2025 11:10:20 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.61) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 24 Nov 2025 11:10:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbhTAwdNnEccawG4RHM3WsnZS536R1hYzRsjfXkg9aNflOIu821YQksy8XiS9EHhIYVp5d8oUCH+mUBZtWajqo/Ky6xbRzrSJh33STh9fAN0g6bTiDHH2glZUMgx7Hf6F9AyHjD9Sx0rXMAFuOt6azUB3nig1gyIrkWOo7DzTTfd5jSiBT186P3X+W2trcNbcQreWHBDwruOcc/VyEZJxKAZ+Jrfiim7bgCwosBYi+U50TVNC0qE7RuWtPIkP4W1nMh5ebNIl9rC+1NvM3+l296ZX2FeDcNiv+OwaQDSzPCmSuk8k6Zvhv0UYHZkNzGD66rfd+XliqV0ZPq0XF7PIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgOEh8LWYxPCbKX3xyjMTJCmTDuCYydYEUU6Qi6BAmk=;
 b=vPWjsKihOaLii3RE4xzGQewq3hLf+rdAV7eIfwRmD9FKyNWMNtbcwDDcK3SVC2nDqLEq2NriBnFYxZnnLwWKKKpfAAGZJA8OCW11rQy+ELTLRchX+0+gFMWjhpfzZ+IdG/RgahoFOctehmdLRh+M9E17M0v/q8LONMKKUtZFpja1BtsaBvw8Iq67dNWohr+MYVNonH/fkYcsSJMwPhMhBzWTB9kndJhbMgAo73fFytk1wrkxOEI4CDTaGsnB6DSrIs/lLw0mZ1OxTXXq9QsnTD2SnFlr2uGNzjH4M+FKCtWnhaXCKu4rE5cemyHR7vy1FCgCCgegy36Qp+pc3K0L5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA0PR11MB4557.namprd11.prod.outlook.com (2603:10b6:806:96::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.22; Mon, 24 Nov 2025 19:10:16 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9343.011; Mon, 24 Nov 2025
 19:10:16 +0000
Date: Mon, 24 Nov 2025 20:10:09 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>, Jason Xing
	<kernelxing@tencent.com>
Subject: Re: [PATCH net-next 2/3] xsk: add the atomic parameter around cq in
 generic path
Message-ID: <aSStkfeUrYRAKZeQ@boxer>
References: <20251124080858.89593-1-kerneljasonxing@gmail.com>
 <20251124080858.89593-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251124080858.89593-3-kerneljasonxing@gmail.com>
X-ClientProxiedBy: WA2P291CA0018.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::13) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA0PR11MB4557:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a26056-e5c9-4920-fd1c-08de2b8d19fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NKTOOMfcHZiFVy5jPjKMVqs3HL4CCuLVfc2+dt5z6UzGQbpMYtvBdITmXiAo?=
 =?us-ascii?Q?r3plKT6vt7Etrh/I+4P9qvmtRJ0v9ch3j75HT4zvIPjqWU3PHwaA83jx71rO?=
 =?us-ascii?Q?qS8JPglGi13qMQbr1nIC/fMQIeiM2hn+E1iJksEvFtDVh9lPYnL/8Pl0k6fN?=
 =?us-ascii?Q?6+NXhzihBVhGOHadVEJ47+r85l7am0Hh6U5kgAaPM/SouPkmOauuA78PqDbb?=
 =?us-ascii?Q?5TSxSR9xzQN2Li4IMSMhm9MJ6old1i4kGr3IujTmpi8dTox0oHal41p+3Igy?=
 =?us-ascii?Q?ftiojrVxEEV64O8gAYxNwUzRcRDA3lHsxziBphRsNZFiotjqcbJwwAMib/id?=
 =?us-ascii?Q?eQpJwCU9YFhhukdMrG5PhvAujBX2HaeMPQuAxCIn6jvmiRcMDSAtcDux6YFK?=
 =?us-ascii?Q?m6JtX9pcbpupDyzeKmczWrLozyH8iA/fzeBn0ovktkP8d+2Movj5xaxtnkuc?=
 =?us-ascii?Q?/z4hZmYrtlWDAZuCkoL6Ee+X2ji9jQ7DJq2dlxd5XvSyAmT4Uw2F/7GOdnPp?=
 =?us-ascii?Q?EPcXZVW3jNmMrm2/5o/KTR3pEJrro62HtCrUER4Zkm9BdC8fyFi13cvIvA7c?=
 =?us-ascii?Q?Qp8YXG0/VTsymIPuco7xmZIuoCKKC/tlBn36i7F1VZD2tx5bQMEcuIUE27fW?=
 =?us-ascii?Q?VLwCi33xP0IcLQGqP1HK4ZsbQw9QPWzEIw71mYv0vYyh1FjgPdh605tmxFXO?=
 =?us-ascii?Q?EhYOAINKiruhPLXVh97sHXyGIRUpGhTGqZg3+E+ClJv3VUxeRhv7tmTmh6iC?=
 =?us-ascii?Q?mN4r2ay08poRX7uLoPQjPF7tdlFXxL/hJH+UpBjQM9pFL3cPDsQ27pd8/51s?=
 =?us-ascii?Q?KI8E9ZITYTjxhpVW1WHet0qtLGISKOv33MCh3u6X63MacW2iUBgOaPC0Hssj?=
 =?us-ascii?Q?NAc78h1rnfSiGXg3UEtpjQvjNCqVIL/bfXvOyPtGBrnMMUZfPq6nMEGPrAVW?=
 =?us-ascii?Q?536yosHeGJWQlYXPyfG1Jx/bpqg/FvwSdBZTbC2hsrlEB1+h6mEwkiZIORJd?=
 =?us-ascii?Q?YxY3eYpNdIHWhZYvqzBWfDeQDJLbbCB2bgAmDx7bs+AaopwlQOsIIagce2DL?=
 =?us-ascii?Q?URUT0nN9DjurjwcXzSHrLCcxKW3hmMQwNZjG8LB0JE0RFN4DWZJfKhTxUiYH?=
 =?us-ascii?Q?aWvYZ2lGmdOm3qF6+4kQQWcoc4j6IZ7OE6m6sz5eVCofCYbjZuOGoXXamHP/?=
 =?us-ascii?Q?T7yCxSp7sAayeZKRkwSbBzPxW6UvcruvG7u9G1CDQjb0ZYTXDKtAb0U0qv1p?=
 =?us-ascii?Q?IQbjEAxQXEKO3RgqQSaE++KZ3zCV+WbzM0P3J72dz5qJ1CzqWCpAGNSlU2z+?=
 =?us-ascii?Q?oqM5wUgFfexWxHHgw1mQ00MI1ePNSpYI7iWoGaUjxVfDOZMlmjF9Pz4vK2uC?=
 =?us-ascii?Q?blysF6tvq0TXNxBW75qpYna0lvgRiiVUCqYJ3rfHQcjajN+dqhzsAYWF8uta?=
 =?us-ascii?Q?um9zfb+ryuwV052FlN2DjsB/qKoQUgFk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uBLs92glNOg1ZyF6p6X4nV1cfbj+Flw9G/Y74BNS/+wK7dOLT2U0hEo32J2e?=
 =?us-ascii?Q?Y/MaYKT3vBtYbk7efOpTSlHlk6PaZ5n4AnGf+Mkfej39xptwEst2C8P1vaNS?=
 =?us-ascii?Q?paiQ+Re9AulIwtLGnfUJ9IJSEIeYRYTzMR/1T1cPcPA0emzdHu1Gg2MS/an0?=
 =?us-ascii?Q?iwUUQ7y0eDou1WXz+N79HQEqJfuj6fVUZA7ifSAiydC248H1PR6ofPwpY/UM?=
 =?us-ascii?Q?oQVRHVXzNp1JCr+CU7q+RP7JGLy98noKwJeRW+P0tSOpqmAU24Vzsg/tlFay?=
 =?us-ascii?Q?bfrpMx6AiXe8uP5vpOiyDSev9q2HSDBZeMZijOjayd9jTAMe/iXq3q5ByDX3?=
 =?us-ascii?Q?YaxyuyTrOSIJfcHtca0NIXx51WZ/Eofg5vYvk8cRUUXc7HmtshB+iFPgzV7f?=
 =?us-ascii?Q?5ELsbHTqW07zoOWGXtn+mGy4QdfuZz5jVRfzX3fX/vJq7ulgJR38oIty63w6?=
 =?us-ascii?Q?Y6E5wjY29ztrb1WuNEr4isexXHQZ7sao5M6GPwQVL81olW6hogih4AZwSlZN?=
 =?us-ascii?Q?WrBKlMRA+gQhYOQnJzcTjraz90tYyiSBkwS8Dd98+thaxCo8f/xjrD6cBd5P?=
 =?us-ascii?Q?P/JJ671x4M5RM1YWMXJVDCh0WMPrgCl3GheJupankhGNz68p4ue+QuhU2DZU?=
 =?us-ascii?Q?qOrfKn5i5SZBEncSF6MMGZDIndCGaeg5ejMtRtLysc2eYdySM4znS2U1GMcI?=
 =?us-ascii?Q?2JQzIwxNpTJpYYbnNBLpR2lGXIehUR944V9LlOP9Z+K7FdqwKouivPwO/ezs?=
 =?us-ascii?Q?AGUtx1dKM0K7+QTLSTIkZ4KFJHZzC5Z5IZF8U+ymL6ajNTaH+rqtSytmjZL2?=
 =?us-ascii?Q?bLsk3AkERMTzU9Z4HxorRAu8DF/ujFQY42+73BP6ZfltthLMsLjrAskejrdk?=
 =?us-ascii?Q?jqJtyuWHGLgmZsy07SaizrQZW86WwyCIlqaR9H/bQL01f2HEpy8DRCjmGC8K?=
 =?us-ascii?Q?FiXIP0xyFG2M8V0zEbxeC6kCweOYEBFzvgQkgVlQQw5TZ6Hn2YyF3IS+kHAr?=
 =?us-ascii?Q?LLRhPcS6QTj1GOO0WRn9TPltqtEYOqNvRf+LHxv7UYBfJgXiJXBI20qvEkLy?=
 =?us-ascii?Q?5BaXMB28ER5JfjaegYV8XBl6bybtgM1jFbV5ZFyUHJNMYmW5/fxNiYgRxRg7?=
 =?us-ascii?Q?XJSXqM10UAss9DcYNN2kyo9gSO/j96qTrLf1Ji2k0Glu6q6kBnnImLfxMV3Y?=
 =?us-ascii?Q?Zy8ffa2SIbOyMX7zLO+LbWXUJt0IuByL/xfyWT7qEOMURNWIDu1iQf5qKrt6?=
 =?us-ascii?Q?0uYglx32jMsj0C7Lnj3CLNhIidVTY2uANYN2IPC/NnIOmrxiHe9F1gwyN18U?=
 =?us-ascii?Q?Dmzd6ygpIKk3ghAftwARvQ8WvzXBrCvj2+I7rO7mk6uktH3qg24KNTGa7fUg?=
 =?us-ascii?Q?wFd4Mc35MB9fFnQY+ZiVIQL1sVMS1VvY1zwS7ahq7aUG4XNIFH//Mx1QyaLy?=
 =?us-ascii?Q?9Rt6dBM/O1Z8BCdTYYvEVRyMR+Yclpg2I3bbKfmlfaiP9E+R2FDrDEUV91++?=
 =?us-ascii?Q?m2i7KIibqJSUU2YbCKcx3ruYwAYESvY5vxI7VEe8NmNfnkrillWTrISDZTKI?=
 =?us-ascii?Q?HMkFa0CAEk2rF67d4DUPdU8mekQKIuYur7ixfmNdzaLwm3jt+rhQeofPRkot?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a26056-e5c9-4920-fd1c-08de2b8d19fa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 19:10:16.1124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyJNmMiDvxMgBoDmsE/6uut6gwI7Mq1195p6zzsjB+44AwxvB+G3tE1HJM7THOsk0FPITpjILXW0i4dFgaWU9S7wIlMQM4oxhtUAVENXHXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4557
X-OriginatorOrg: intel.com

On Mon, Nov 24, 2025 at 04:08:57PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> No functional changes here. Add a new parameter as a prep to help
> completion queue in copy mode convert into atomic type in the rest of
> this series. The patch also keeps the unified interface.

Jason,

anything used in ZC should not get a penalty from changes developed to
improve copy mode. I'd rather suggest separate functions rather than
branches within shared routines.

> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk.c       |  8 ++++----
>  net/xdp/xsk_queue.h | 31 +++++++++++++++++++------------
>  2 files changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index bcfd400e9cf8..4e95b894f218 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -276,7 +276,7 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  		xs->rx_dropped++;
>  		return -ENOMEM;
>  	}
> -	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
> +	if (xskq_prod_nb_free(xs->rx, num_desc, false) < num_desc) {
>  		xs->rx_queue_full++;
>  		return -ENOBUFS;
>  	}
> @@ -519,7 +519,7 @@ u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pkts)
>  	 * packets. This avoids having to implement any buffering in
>  	 * the Tx path.
>  	 */
> -	nb_pkts = xskq_prod_nb_free(pool->cq, nb_pkts);
> +	nb_pkts = xskq_prod_nb_free(pool->cq, nb_pkts, false);
>  	if (!nb_pkts)
>  		goto out;
>  
> @@ -551,7 +551,7 @@ static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
>  	int ret;
>  
>  	spin_lock(&pool->cq_cached_prod_lock);
> -	ret = xskq_prod_reserve(pool->cq);
> +	ret = xskq_prod_reserve(pool->cq, false);
>  	spin_unlock(&pool->cq_cached_prod_lock);
>  
>  	return ret;
> @@ -588,7 +588,7 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
>  static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
>  {
>  	spin_lock(&pool->cq_cached_prod_lock);
> -	xskq_prod_cancel_n(pool->cq, n);
> +	xskq_prod_cancel_n(pool->cq, n, false);
>  	spin_unlock(&pool->cq_cached_prod_lock);
>  }
>  
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 44cc01555c0b..7b4d9b954584 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -378,37 +378,44 @@ static inline u32 xskq_get_prod(struct xsk_queue *q)
>  	return READ_ONCE(q->ring->producer);
>  }
>  
> -static inline u32 xskq_prod_nb_free(struct xsk_queue *q, u32 max)
> +static inline u32 xskq_prod_nb_free(struct xsk_queue *q, u32 max, bool atomic)
>  {
> -	u32 free_entries = q->nentries - (q->cached_prod - q->cached_cons);
> +	u32 cached_prod = atomic ? atomic_read(&q->cached_prod_atomic) : q->cached_prod;
> +	u32 free_entries = q->nentries - (cached_prod - q->cached_cons);
>  
>  	if (free_entries >= max)
>  		return max;
>  
>  	/* Refresh the local tail pointer */
>  	q->cached_cons = READ_ONCE(q->ring->consumer);
> -	free_entries = q->nentries - (q->cached_prod - q->cached_cons);
> +	free_entries = q->nentries - (cached_prod - q->cached_cons);
>  
>  	return free_entries >= max ? max : free_entries;
>  }
>  
> -static inline bool xskq_prod_is_full(struct xsk_queue *q)
> +static inline bool xskq_prod_is_full(struct xsk_queue *q, bool atomic)
>  {
> -	return xskq_prod_nb_free(q, 1) ? false : true;
> +	return xskq_prod_nb_free(q, 1, atomic) ? false : true;
>  }
>  
> -static inline void xskq_prod_cancel_n(struct xsk_queue *q, u32 cnt)
> +static inline void xskq_prod_cancel_n(struct xsk_queue *q, u32 cnt, bool atomic)
>  {
> -	q->cached_prod -= cnt;
> +	if (atomic)
> +		atomic_sub(cnt, &q->cached_prod_atomic);
> +	else
> +		q->cached_prod -= cnt;
>  }
>  
> -static inline int xskq_prod_reserve(struct xsk_queue *q)
> +static inline int xskq_prod_reserve(struct xsk_queue *q, bool atomic)
>  {
> -	if (xskq_prod_is_full(q))
> +	if (xskq_prod_is_full(q, atomic))
>  		return -ENOSPC;
>  
>  	/* A, matches D */
> -	q->cached_prod++;
> +	if (atomic)
> +		atomic_inc(&q->cached_prod_atomic);
> +	else
> +		q->cached_prod++;
>  	return 0;
>  }
>  
> @@ -416,7 +423,7 @@ static inline int xskq_prod_reserve_addr(struct xsk_queue *q, u64 addr)
>  {
>  	struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
>  
> -	if (xskq_prod_is_full(q))
> +	if (xskq_prod_is_full(q, false))
>  		return -ENOSPC;
>  
>  	/* A, matches D */
> @@ -450,7 +457,7 @@ static inline int xskq_prod_reserve_desc(struct xsk_queue *q,
>  	struct xdp_rxtx_ring *ring = (struct xdp_rxtx_ring *)q->ring;
>  	u32 idx;
>  
> -	if (xskq_prod_is_full(q))
> +	if (xskq_prod_is_full(q, false))
>  		return -ENOBUFS;
>  
>  	/* A, matches D */
> -- 
> 2.41.3
> 

