Return-Path: <bpf+bounces-64365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9557FB11CDC
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 12:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D951C1C83915
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 10:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9054E2E3B19;
	Fri, 25 Jul 2025 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjptihcN"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CA4232368;
	Fri, 25 Jul 2025 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753440726; cv=fail; b=clXLkC3mBWgT2awyzH56vHFWqM7vJ7Jy1Iw5a7yexSMqfUIBWWBuUSb+2Ub2FOJy4cwOgurufvba6yCJc9xJKOkP+ly3mtzWougd9YYuBeWFW6dVZV/xL1euuFNj8T87CQbmYafZ1JESF/mz1F5/MePoYLj2M/77GUs9N4oaDoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753440726; c=relaxed/simple;
	bh=xJupqImszK1KTDVlWwdtO4UoNNfOmNhKGFxxqleHMRM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YHC5u0vO5hcnS+fi+X9bgVPBwL4W5k+B6TXsXRSczukw6lRAUk7nD4KlAZiPaCtlHVAQ4zmW0ypc/1x9wid07PkHGbtJ/RpYUm7IlfLSK7jYbkqFHpTrCjnqJ3ShC7Nf2epVgsZKszQPjgMP4kZ/Xg4hVrojCIyiHShjS23vB9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TjptihcN; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753440723; x=1784976723;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xJupqImszK1KTDVlWwdtO4UoNNfOmNhKGFxxqleHMRM=;
  b=TjptihcNIIbOffz0WiEZRImRbzQZv2j1zQD4x3jkjZXB5VPuj+mU/7Kv
   cyaZLLCRNBbjRe62XuxTBmebhk8vllF4latQPw2oWNvR9O8dwYU+LvZmM
   PqHLOPu04rQ6f4mhWJvCoqnBYifzIOL7YLzc97d7xfM37Gs/1zl3iLafN
   E8hf3TgOBZ/PwgioM3lrFcSeXPY8An8BFdOQu19y9eVKo4wMFGa4aMyzt
   1wJyU5yL7LktsbwdwOutNde68ksw7zD3FHAysNo8CNFQ2rfCOqBlultsE
   g2NTdQX5TCHN6JG7XCW0C5NAOn8Wtd8wR5Z81Pk5Sl4Stgd18Zxyhkgzt
   Q==;
X-CSE-ConnectionGUID: Z/xYUPaHTD+Wj7Y3gkSqkw==
X-CSE-MsgGUID: XxURDdDfRLSeh/hJeiCAkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55860525"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55860525"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 03:52:03 -0700
X-CSE-ConnectionGUID: f9VVRRZwQI6wPpzHdFSBwQ==
X-CSE-MsgGUID: 5Kx1pSHoSW6FBy6qMsWDlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="160583136"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 03:52:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 03:52:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 03:52:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.57) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 03:52:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pm5uD4hekIBdnKMcK1Mkj/u6GOz+56Fja3o+L7yQyIEjIyXxpFeFmMvK/Tgw0mET62xEhsIRMtpIfOCDSTxc9dxq0uOOYd5GLYOoVXvObsuD5+LvcpPOsDlV7J8BIyfPM/r9L0w9tZfEs3BWCeB/t/4OD32qKZlTBWxAaC/VdP6dRt0//ROjPVOJngfZx5m8RJZYtEUUfvjgfE8dAIQs+AZpqfmoF8zoJbI/4ottbdaMXQjbs7k7Lrw7Q0eFmDprk1Km//uU2cAIAWgRlhF35gkAYk9KP4OYshGsnDSI5NqLJPD9wyWvxfNVaMbjSiXjJY6XtPOz0CxIQoLs0RZVNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4to0CnA5iQwQ6eKdywAp5g0tiYhkFidrf/MrGhJ4PI=;
 b=tW+ki4vvcQanrUfbVc7gLc+jo0TREhTBni6k4s7AgRmtffkrcvmdAcmpNzM41cnFuYNbfs32WkC2YnuMIpCyCcW4HaI/kZRHXPsEYZ0hvqHS1cuTzsTGljq5ygjm2mOrGrwLX5ukvNWkhlWW54jSuOn89v95qPqOrtEtSxKbm9+wf83DJWm0oJjhBA5f0GW0BMHVujitSRwsD4GYI46nq36vkTEvi9e/rTCYsfmtgySgfoIydbPNwQebfSAvhoJmk90tz0/X2izujIqsrqG2oNgj8kb5XSK7Sx97ETxjnRu44houQJlI9N7p8u16j+IIo+ipZUza3fv5Hm2zJR2qYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by LV1PR11MB8789.namprd11.prod.outlook.com (2603:10b6:408:2b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 10:51:32 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%4]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 10:51:32 +0000
Date: Fri, 25 Jul 2025 12:51:21 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <maciej.fijalkowski@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<bpf@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 4/5] ixgbe: xsk: support batched xsk Tx
 interfaces to increase performance
Message-ID: <aINhqcDpvw2FM9Ia@soc-5CG4396X81.clients.intel.com>
References: <20250720091123.474-1-kerneljasonxing@gmail.com>
 <20250720091123.474-5-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250720091123.474-5-kerneljasonxing@gmail.com>
X-ClientProxiedBy: VI1PR07CA0148.eurprd07.prod.outlook.com
 (2603:10a6:802:16::35) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|LV1PR11MB8789:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0541bc-3f3d-46b4-345e-08ddcb693789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5OdLXosKXe3DdpTWKUgAzcPUje1jgiru4ErKK5Ng4922aIr9ugsBab6mMxHz?=
 =?us-ascii?Q?Uy+Q6FmgriubXwCXSYf7bxnlgZy3qbcXE1RdSrFAjGYg9aNGrixw/c3SYdFm?=
 =?us-ascii?Q?LZbeseyWCqZ8xV9+DQ+sgcRjRTOdfgU63gnY4112udvt230yMBCZqN8sW7dz?=
 =?us-ascii?Q?+zu59hDLhqjDbzlEsgPP1p8JhcN7JfEJIv01Da1h+1eXUi7i8h8Z98SW0ODm?=
 =?us-ascii?Q?+lDixZiOrCDPIO6J/okCu/zeTMlP7rrB66aiFB24Zp4Py1Npol3Ao43mKY1D?=
 =?us-ascii?Q?tQHDssDzQRJ2BPF44XJ/8mcLcm/bXV8NilXbVZY6CCQQO+an15m03uUL4IYF?=
 =?us-ascii?Q?EM8+/Q3cjioUKXWhMFc2X/7/qeyN3gCdtadFOPp28Wn3UPwYUQ3NAiFO9DUD?=
 =?us-ascii?Q?ilQFayWEFBU7etQp4tJohFl3VSKoE7VkSSKjWx6pjuPsi7N10DKcuE/WC4XZ?=
 =?us-ascii?Q?mfdeGsSTOcug6PFLwbXPYgPcPqqlKt9pL9DHfOOr1IXFbTrc104bMIiQsFFB?=
 =?us-ascii?Q?kQEGgIunuu/QodeHQUjGdLS7rdZVPBSQEh6YRX+UoYlFkf4rm6GGpa8nN2lh?=
 =?us-ascii?Q?ObntmBuxeWUidjFG+Vjl7tr8BUL72vBUaEsQsP0dW7FMh+diOeYjOKzbgw1+?=
 =?us-ascii?Q?laxlYjM7d3gBSxUEBHIcglqWWe2RnN4rFe+9lRGcUffVNjnR2YGyPtjcjP9V?=
 =?us-ascii?Q?MeUkIEFoS0oQO4TwZcAL+iP8dbLjTDsgF3P/L5Gg3Xv8xfZYDCl/oUN2PR9G?=
 =?us-ascii?Q?L4hTIiUcGhdwD74/9zkY/ofSQyIMNUTRH/uVesC2CIVQu4UEbQEOVf3W3osg?=
 =?us-ascii?Q?O2kR4m8qK7usQFfEKyeT+5nbFxzo6Gjw6Uba34Yfeul042msfZvP1mErAqoP?=
 =?us-ascii?Q?3Hxf82EmrIXjFFUr4Hfltw2dnLjkLqR/4JoEJQVGeJTbI4D6SDxtrwYJCioj?=
 =?us-ascii?Q?vigslP3WyPxtCxT9ibrFGHcb0ZIGdildczmMKjfMHUpMnWvo4agUfhPmBjE9?=
 =?us-ascii?Q?8GaQ51CGvdSKFYbf0zAVnoTjK0dL/ZFF7jY0Eyh8YCXTEW0tPlwPy7Ps52LZ?=
 =?us-ascii?Q?CwqMh+Mh/rHCfNpXmHT2gfbA9GK/476LSkqmvw031j3of9F3OQnBbgMvZ8m2?=
 =?us-ascii?Q?Ip5/9r2ofmlT2NtrE2FR2Qavai5JAVDfhiNVNUGLGY+q1CFSp83KO7kDUdr5?=
 =?us-ascii?Q?aKxGyyDbe6z+CyFoXtkXZS7HE4i75H+hv+pCIVkQFdiVeEPcTEhC9SUY68La?=
 =?us-ascii?Q?Xq01NjfZcEbMMvtXRRtpx1HPpV0WPgHAQRjwbCZWE6dwt8E4JvoAjPDduhgP?=
 =?us-ascii?Q?fBMBQoQA1+KRKlfdo34NMHcN3AfyL1ARLLB1bwDtr0n3bcG+Z6gnD+WXbijC?=
 =?us-ascii?Q?dH9dASrVcMZ2vcb2HWAmY911QHO2nnB//gUYeLSHsOTWOT5A20mJnlGuwVVj?=
 =?us-ascii?Q?ujw+UmRlj04=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p7PwJ3apkW9XR1MOlg/eojEFvDlva7pDvr+LXuvG7FU1/ONo9BqQUXakEFzD?=
 =?us-ascii?Q?GmVPigcPAj43ZlvAIdMKIi6350EJMTnHk5LlcReQg8QlAq93MxA2djK237HQ?=
 =?us-ascii?Q?PhTTxVewWpWE7srd1WC4APUDw6BqHAE7NVhABVVXEdQEXHvr8VkMh8cM+Lrh?=
 =?us-ascii?Q?pVNUyAMPriCHDWseY21+nAlRtlcLs+exQs+ffclIF5DefvKbU3r2I+RtOLsK?=
 =?us-ascii?Q?cGXESEBPxpzytqJfhPhR0MiWgAHHn4nh4mePE5X8LsmGejfZQ1F3UpUgbj/F?=
 =?us-ascii?Q?dW8H9SjHf5Y7tWGC+/IaPp2FCML7fAmYVr6VtzzlMj7XCyWblVivlbSMsyzi?=
 =?us-ascii?Q?XZMqYFga/v5xEArrxx9AKrWO5y5BDrSKGIm7Pz+kuCf1Xpbn5oqPjIWFAEuh?=
 =?us-ascii?Q?bO+yJ7AnuAfDiB4MzzfWGlhHR5q7DOPZnG6t+E+JYpjInZS6jcgLBpGCg5ij?=
 =?us-ascii?Q?5POrc+Mx2/5DJe2R5rDmvc56jRrdgDYHoQFdPgvRdlKfJjgY2S4foZvICxI+?=
 =?us-ascii?Q?qhfydE1Gr4jvL9S0FdQvDqgf7Y+QIikyNJ1MjFE60R/ELjmqvZbSs5cEIbXj?=
 =?us-ascii?Q?Ly+tW19LhI/zX7EDg80NenyDAu4bF+24wYwhehpjztkztYg/r0FZWow6SDNB?=
 =?us-ascii?Q?d5+k41eSwr3Ropz5zDbly2tBhexN1LTmAHY9RPTAZ1hU2BuDWXsicCwtgPDM?=
 =?us-ascii?Q?DjXH1E41Hemas5pc/KvqT6+lZzmuPg5tZ0Wq0Shjv/tgJjBxfJecIaJ+z+Vl?=
 =?us-ascii?Q?OX/ACmZPesGIpOvYOAf46AS/XM2+EsHOWcE4+09ILJ4HFmyU3P9tptX2e5Si?=
 =?us-ascii?Q?mmJCtSM0zVdmg/JnlW5R6QAsTFBCttpg+PJY9W9t2z/bAaBIT0mW4ca5iHvH?=
 =?us-ascii?Q?W1tgrvK9XUOPjm5JYGCzzpBBSYPiuXHEQaJpoSJTRt0AziT+/5mdAbwQZ/6U?=
 =?us-ascii?Q?cN1gL5uXvP5gQfkwPysB6BQjKJnROZHv1EUW86kHARV3tX7NO5+MsOTunW7f?=
 =?us-ascii?Q?YAbwDqbvR/OFqP9CIkGR6dbIWyk+H0XMGOWtE5at1VVXnWPsXPsOIUFgg+F2?=
 =?us-ascii?Q?DcIY2Ga3237o+kjEt+mRi1IgJLv0b0DPffpZJUwcOfdPBg8ox2AEqsqG1Jua?=
 =?us-ascii?Q?i+VsbHK5gTeJgLZgoKDtCLHjybMFrUGmMguqdkibUzvYpOjgNXUzr3+lVAUq?=
 =?us-ascii?Q?FtHN5NGoZgRRPa9+NDgpg8Ut1OiqbLANzDAfFuj08hCMBPH6hJpsb60gFrxo?=
 =?us-ascii?Q?Ab+n71suH1kYs8r/tSfANlAf4EJho1XY3WR5pwwwwEl3ocVzUBpMRAtIyxJG?=
 =?us-ascii?Q?86Nh2HICrohuuViQr25lWu42DUlhu75spRSuiMdnBEcOaSqX37pnllOhUjd3?=
 =?us-ascii?Q?BG+IUnaWJGHBg9vZ8pZ6UA65Hl+wrxtk2guOOZQ88G9YWgCcoqMVGhqHbr9d?=
 =?us-ascii?Q?42yjDGJKjiz3QoiXQ75Oxs9HP2jp/JG68NTaoRPjYySN0IkMavfM+68XoVQQ?=
 =?us-ascii?Q?4fHe4G76k6WqBFyJvLNqgRQapnvRYHLdMaYmhVX/i8wXQjcXhEkU2WhQcZIc?=
 =?us-ascii?Q?S1eLOXKJsV73CRyWK0Jo/6QQ2e+lnQU1aawV3qvCG3oA2yp+ReRE/C9nSQTl?=
 =?us-ascii?Q?81UazgihA2VG++rPhYy+5ZsSxOiy6vEf2LBzhZvKSOJ+HAh7R6DZ+wI18yML?=
 =?us-ascii?Q?u0Vo0A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0541bc-3f3d-46b4-345e-08ddcb693789
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 10:51:32.2889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: souBtY1lubtSRoFSt1fJiioGgQzGeJkh1wae79MahpFFRH+1Qg7J+HSIZLs5rCyqp0K90O/fju7h7HpfZDhRmyUO8ChB8J6vUvDw9Cv939I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8789
X-OriginatorOrg: intel.com

On Sun, Jul 20, 2025 at 05:11:22PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Like what i40e driver initially did in commit 3106c580fb7cf
> ("i40e: Use batched xsk Tx interfaces to increase performance"), use
> the batched xsk feature to transmit packets.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 106 +++++++++++++------
>  1 file changed, 72 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> index f3d3f5c1cdc7..9fe2c4bf8bc5 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> @@ -2,12 +2,15 @@
>  /* Copyright(c) 2018 Intel Corporation. */
>  
>  #include <linux/bpf_trace.h>
> +#include <linux/unroll.h>
>  #include <net/xdp_sock_drv.h>
>  #include <net/xdp.h>
>  
>  #include "ixgbe.h"
>  #include "ixgbe_txrx_common.h"
>  
> +#define PKTS_PER_BATCH 4
> +
>  struct xsk_buff_pool *ixgbe_xsk_pool(struct ixgbe_adapter *adapter,
>  				     struct ixgbe_ring *ring)
>  {
> @@ -388,58 +391,93 @@ void ixgbe_xsk_clean_rx_ring(struct ixgbe_ring *rx_ring)
>  	}
>  }
>  
> -static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
> +static void ixgbe_set_rs_bit(struct ixgbe_ring *xdp_ring)
> +{
> +	u16 ntu = xdp_ring->next_to_use ? xdp_ring->next_to_use - 1 : xdp_ring->count - 1;
> +	union ixgbe_adv_tx_desc *tx_desc;
> +
> +	tx_desc = IXGBE_TX_DESC(xdp_ring, ntu);
> +	tx_desc->read.cmd_type_len |= cpu_to_le32(IXGBE_TXD_CMD_RS);
> +}
> +
> +static void ixgbe_xmit_pkt(struct ixgbe_ring *xdp_ring, struct xdp_desc *desc,
> +			   int i)
> +

`i` parameter seems redundant here, why not just pass desc + i as a parameter?

>  {
>  	struct xsk_buff_pool *pool = xdp_ring->xsk_pool;
>  	union ixgbe_adv_tx_desc *tx_desc = NULL;
>  	struct ixgbe_tx_buffer *tx_bi;
> -	struct xdp_desc desc;
>  	dma_addr_t dma;
>  	u32 cmd_type;
>  
> -	if (!budget)
> -		return true;
> +	dma = xsk_buff_raw_get_dma(pool, desc[i].addr);
> +	xsk_buff_raw_dma_sync_for_device(pool, dma, desc[i].len);
>  
> -	while (likely(budget)) {
> -		if (!netif_carrier_ok(xdp_ring->netdev))
> -			break;
> +	tx_bi = &xdp_ring->tx_buffer_info[xdp_ring->next_to_use];
> +	tx_bi->bytecount = desc[i].len;
> +	tx_bi->xdpf = NULL;
> +	tx_bi->gso_segs = 1;
>  
> -		if (!xsk_tx_peek_desc(pool, &desc))
> -			break;
> +	tx_desc = IXGBE_TX_DESC(xdp_ring, xdp_ring->next_to_use);
> +	tx_desc->read.buffer_addr = cpu_to_le64(dma);
>  
> -		dma = xsk_buff_raw_get_dma(pool, desc.addr);
> -		xsk_buff_raw_dma_sync_for_device(pool, dma, desc.len);
> +	cmd_type = IXGBE_ADVTXD_DTYP_DATA |
> +		   IXGBE_ADVTXD_DCMD_DEXT |
> +		   IXGBE_ADVTXD_DCMD_IFCS;
> +	cmd_type |= desc[i].len | IXGBE_TXD_CMD_EOP;
> +	tx_desc->read.cmd_type_len = cpu_to_le32(cmd_type);
> +	tx_desc->read.olinfo_status =
> +		cpu_to_le32(desc[i].len << IXGBE_ADVTXD_PAYLEN_SHIFT);
>  
> -		tx_bi = &xdp_ring->tx_buffer_info[xdp_ring->next_to_use];
> -		tx_bi->bytecount = desc.len;
> -		tx_bi->xdpf = NULL;
> -		tx_bi->gso_segs = 1;
> +	xdp_ring->next_to_use++;
> +}
>  
> -		tx_desc = IXGBE_TX_DESC(xdp_ring, xdp_ring->next_to_use);
> -		tx_desc->read.buffer_addr = cpu_to_le64(dma);
> +static void ixgbe_xmit_pkt_batch(struct ixgbe_ring *xdp_ring, struct xdp_desc *desc)
> +{
> +	u32 i;
>  
> -		/* put descriptor type bits */
> -		cmd_type = IXGBE_ADVTXD_DTYP_DATA |
> -			   IXGBE_ADVTXD_DCMD_DEXT |
> -			   IXGBE_ADVTXD_DCMD_IFCS;
> -		cmd_type |= desc.len | IXGBE_TXD_CMD;
> -		tx_desc->read.cmd_type_len = cpu_to_le32(cmd_type);
> -		tx_desc->read.olinfo_status =
> -			cpu_to_le32(desc.len << IXGBE_ADVTXD_PAYLEN_SHIFT);
> +	unrolled_count(PKTS_PER_BATCH)
> +	for (i = 0; i < PKTS_PER_BATCH; i++)
> +		ixgbe_xmit_pkt(xdp_ring, desc, i);
> +}
>  
> -		xdp_ring->next_to_use++;
> -		if (xdp_ring->next_to_use == xdp_ring->count)
> -			xdp_ring->next_to_use = 0;
> +static void ixgbe_fill_tx_hw_ring(struct ixgbe_ring *xdp_ring,
> +				  struct xdp_desc *descs, u32 nb_pkts)
> +{
> +	u32 batched, leftover, i;
> +
> +	batched = nb_pkts & ~(PKTS_PER_BATCH - 1);
> +	leftover = nb_pkts & (PKTS_PER_BATCH - 1);
> +	for (i = 0; i < batched; i += PKTS_PER_BATCH)
> +		ixgbe_xmit_pkt_batch(xdp_ring, &descs[i]);
> +	for (i = batched; i < batched + leftover; i++)
> +		ixgbe_xmit_pkt(xdp_ring, &descs[i], 0);
> +}
>  
> -		budget--;
> -	}
> +static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
> +{
> +	struct xdp_desc *descs = xdp_ring->xsk_pool->tx_descs;
> +	u32 nb_pkts, nb_processed = 0;
>  
> -	if (tx_desc) {
> -		ixgbe_xdp_ring_update_tail(xdp_ring);
> -		xsk_tx_release(pool);
> +	if (!netif_carrier_ok(xdp_ring->netdev))
> +		return true;
> +
> +	nb_pkts = xsk_tx_peek_release_desc_batch(xdp_ring->xsk_pool, budget);
> +	if (!nb_pkts)
> +		return true;
> +
> +	if (xdp_ring->next_to_use + nb_pkts >= xdp_ring->count) {
> +		nb_processed = xdp_ring->count - xdp_ring->next_to_use;
> +		ixgbe_fill_tx_hw_ring(xdp_ring, descs, nb_processed);
> +		xdp_ring->next_to_use = 0;
>  	}
>  
> -	return !!budget;
> +	ixgbe_fill_tx_hw_ring(xdp_ring, &descs[nb_processed], nb_pkts - nb_processed);
> +
> +	ixgbe_set_rs_bit(xdp_ring);
> +	ixgbe_xdp_ring_update_tail(xdp_ring);
> +
> +	return nb_pkts < budget;
>  }
>  
>  static void ixgbe_clean_xdp_tx_buffer(struct ixgbe_ring *tx_ring,
> -- 
> 2.41.3
> 
> 

