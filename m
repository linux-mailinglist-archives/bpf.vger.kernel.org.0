Return-Path: <bpf+bounces-50963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C0CA2EC6F
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 13:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AFAC1884E4A
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 12:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D096222569;
	Mon, 10 Feb 2025 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UsMEIDcm"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2FE28E7;
	Mon, 10 Feb 2025 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739190541; cv=fail; b=G87Sp7AdzCf4CQcAbcUQ9Hu8U0d7M/yFdBny8sX1BnUrehvDvkVsabLFUIBbcp5rlObsAOTYOlG27H8px5smlx/c5vd75ABB8YXkfEr8pkJV6xbW4VxmkbcDPoQ/bYNVL0IhmWNwf7NjxIp5EIzsnzCCyA2JupzIzgg2r7CI/0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739190541; c=relaxed/simple;
	bh=1o2CYrvgbA0uub/1dcxAbSN6oqAPZ+YSY/3e85wTkSw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AqIfG6Pqn3d9vlfr6Wx2lFqU+9/CnWuuwsmYLlitxSJDVZmoMb+sqevDIMyS9huB1+/4bwe+tKOBvE0rd6LH61/i7QKu0fdR33jKw7bNazv8/c2Lw1QHr8bHhqHQDxHgsafCcr7jqVarYq+vrAehL3/FvZljxF0vmuaGCUsV+CA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UsMEIDcm; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739190539; x=1770726539;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1o2CYrvgbA0uub/1dcxAbSN6oqAPZ+YSY/3e85wTkSw=;
  b=UsMEIDcmZ4+JBagKqyNzQmOq9nvzBhiPqhXZqPMbjoXq5IClqDJXOtfy
   sqbTFcW5bnmxbKtJzJ96SlC1ilsea7ZcW092GFp2vpTWlV8vEd3bAatfC
   KuqXFrJdSyCWrHZCVK/a0M4mO8AdRkTMNsY9yPOnVoZmbMUkUSHiDoU/r
   +GkVTtWtefDwS1dyYeQ3wefu9oGgElprQfr/R+tG3X3weIZxfTkA5Jq4R
   v5ilgi+ZRKR645GX20r0d8frhMHoDLxWgHv42w9TuhgHq9i2pMBvRYHlu
   bF4iZS55l6MDQvGJoFqsyC0+PYCcZ+TT6VtYmJ4FSE529Ux4utx7TRC7g
   w==;
X-CSE-ConnectionGUID: GHKg8yceQrKG6zWzNL9/oA==
X-CSE-MsgGUID: kJ5QF+rUS3K9NOLLglE2kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="40037185"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="40037185"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 04:28:58 -0800
X-CSE-ConnectionGUID: RrDb035EToa56wU2Kix0NQ==
X-CSE-MsgGUID: U3MQFCqMTISXz5zqzg9F0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113060609"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Feb 2025 04:28:59 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 04:28:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 04:28:57 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 04:28:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIm9mvPTbIEOmK/rR7rY4cLaFwC1jfButHgyWphWbgnP1KXFNDrAgY6tDpQA3984LWcD49BT36jqQSxXwvSx6fq4UcATryClBl9cyYkpyKsVgE1ewbYZ/DpgsiNz4AQFyfkEKg3nGZyLITnG0JoyZuQ5z6Z0cPJHbn7X3+u57x31iJoMqXzYM0x/tBqckvSb6jTnsldKEKgMKvT3XUgHCVvlYJ5SBpj5Kmy6mB4myHMtSc0RFQ43wERS7yIpE+8J9mbrAs8VIT+P6YI4wwx4YW+HVNvswqBQSO2DKXzYq23nvMDO62RRjotMj25wsR5+XF8PpR0l5zPp/T3YvWBcyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhfB1P8+MLvIGZnOXjozupiak4ypPgC1yYcgu2xcapo=;
 b=AW/C5EN9PnAanoqT5z2Ff+lA6q3/NUYRqjyDMHkiKWYu48+vEPef2bmJoLmuzJV8wkmEng1e3dOuxuSIvLOhGId+HeUR4cVR5NQHPLwlLaavhuf1FRvIDrj01Ueoi8F+6qTq49KFnak4SfA8KJ+XXAkLaCFKn2h8uo0tRrnYWZGS96KkeemXEz/TWB80OOkleD6st3fuW5wyS9eIhQsX9R5B+gKEpaP/ohv7DgjRfUmKiFr5/rG+SLgJFu+XhZnxIgEe2VSbTF5n9qMqSaLWDLFH4k7hVcKbFxFjCesVVFtmm0UtpgI6DMqkQRhi9PfzxYAQ/HaFAD4HN/OAiiTYUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB6351.namprd11.prod.outlook.com (2603:10b6:8:cc::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.14; Mon, 10 Feb 2025 12:28:55 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 12:28:55 +0000
Date: Mon, 10 Feb 2025 13:28:42 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Simon Horman <horms@kernel.org>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Jose E. Marchesi" <jose.marchesi@oracle.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Jason Baron <jbaron@akamai.com>, "Casey
 Schaufler" <casey@schaufler-ca.com>, Nathan Chancellor <nathan@kernel.org>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/4] unroll: add generic loop unroll helpers
Message-ID: <Z6nw+s8nPw7JoVeb@boxer>
References: <20250206182630.3914318-1-aleksander.lobakin@intel.com>
 <20250206182630.3914318-2-aleksander.lobakin@intel.com>
 <20250209110725.GB554665@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250209110725.GB554665@kernel.org>
X-ClientProxiedBy: ZR2P278CA0037.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::19) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e2237d-9539-432b-4e81-08dd49ce7c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qxa/Yfc5iPyqY0JjKqXrhoJL0Wq8YHdmXHA4VuLMQ7GBeK7lqc/rSLJ3q9OK?=
 =?us-ascii?Q?WfTDezTyVxNGXH4scU9vNIDyyDoHDenPhv1DArK5Vb26rw1QU+smhbLlESjL?=
 =?us-ascii?Q?GshRXRKTazFVS9MdYxIWuh+e+WDLaFqim45+3CsBQt/V7/aJNckZWFBg4oW+?=
 =?us-ascii?Q?t7WBTw8TvfJW6JNaectbLUn67QXjQcT8TiZ1ddBd/ddQ93x8WyiVxH6cr5Nl?=
 =?us-ascii?Q?KbgxE93JywsdIV3h1NDufPUvBDQKufPWY7Wr55aMukU7bcRC3Z9TAQp6Ofaf?=
 =?us-ascii?Q?5Ep0uHdDGzat7dUjPnBxcbRMYfz/nEg7ujBIt0FuQ8EwwFOB1rxQSZxCtWPZ?=
 =?us-ascii?Q?OGdw2j3i+XCxoa1BYcFleZb8WZ6pP/y9EdI5D5xhSaQhBTvgY04jiaNtDlcq?=
 =?us-ascii?Q?GYyufMFMryKdyr6LIuTrGDqr1bbASahHlurhmU5yp07/OFblzGlNw/XAAehf?=
 =?us-ascii?Q?KJO8fvBpOoPHzrrCWNFZVAQn9dQQQIA+/pTadQL0AAmTIL33CDwyGu4w5PwP?=
 =?us-ascii?Q?wAUHM++l4q+39KzqOzWQ/DWW0vdjKEScTljnZ96BX1/my+PbOanbIGVWoNnX?=
 =?us-ascii?Q?jRsLW544IMBZuNbPO9tVcuR21hUsrJxWcBxvjajgFswCEACE0mfNBn33MY/2?=
 =?us-ascii?Q?wwRKUJ/Pu/HVce6ufaBnJjO+sGqOCl5Zl32CzgTXchi3ZsDRiltCK7aUXlRD?=
 =?us-ascii?Q?cuhbQxLMvHQS4PLDhsGZZxJSyIjtDMm3t7OHH7sco8jd40jfXaKuzk6r8Pat?=
 =?us-ascii?Q?pha/3aYYPDT98Zr/f2saNFohGxlAX43N1xMzlxmq+iFFZEGtDX2hF/m/8xzb?=
 =?us-ascii?Q?iKg8IPl3NYETcgZPN728XsH1+/hTSrodiaT9hX0vCGlXV6v04GFqH4LOmWXH?=
 =?us-ascii?Q?tmWkokHWs8ePjRjrzXFhsNWuVyVH8ZTjDQFl2OSKMt5YkTJnuDNIk6cpe4E9?=
 =?us-ascii?Q?L46hA+9iKFoYqKCnsambEKM/ZWwvzudHqrOuzp8sRTl3RVvVrn4fc/RQ/+CP?=
 =?us-ascii?Q?AJpynXy9pBeDSJDKhnwbvHE6EAE9TScL11TPBtX70/zJGkTZQjg7qMwiB3GE?=
 =?us-ascii?Q?hm5+5xu5zdcN+bU2JbJuA+vvhcQq7Sykhn8c5URc766PswbUHKFcOk4Q6W82?=
 =?us-ascii?Q?YDUGnNlu2SkB40DlrP6qxWcI2rKz3UPJXSUaq7mx+RZDjqUPkzdjJ1QQf39o?=
 =?us-ascii?Q?pcdavCnH61OKstd//UTHNpOppAhIGbjQ/ETtUxmuuVZY6y0wbYsJ47m/1GHa?=
 =?us-ascii?Q?jG6ZLRXu41KsqONY48dLAKRliJgmD98Iqp9gq+vXfO9dHHatWg44JJriYj/r?=
 =?us-ascii?Q?M8d5FGc/vF2WtlI+QN6bcyxq1EQkE3ksf1cZ2KliP2OhSBHySd10wG+27PSn?=
 =?us-ascii?Q?I6GE2Rn97me9Iyw0f95GNfFOslKY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S/o1Jm20iCin5ZdS1zt7Q0zDsqxhWGB/PpfN/E0eIHmlyut995yj5SFAl3Ju?=
 =?us-ascii?Q?QeROI7RlK4gDzgq10K6bTJh8na3UJuw0Xl4JI9ge30mq0Pr1yOPFZcgu/SrY?=
 =?us-ascii?Q?2Kqg+PszZ0TX7Gwsi5daQok8WYVto5cjm1iyKj+Dr2Ubcwz7sKG0kM0a3WZK?=
 =?us-ascii?Q?dnB0oJvItnpIT5S4np0MtQCJR23xzBSnrB0mIVnfj2nkfY518v6/3ur1sucy?=
 =?us-ascii?Q?Ew54E2309m5wIjhc/KtTFrszpgnvS6gboSvF/gTenMiwDYiXufEaZ/HDB6rz?=
 =?us-ascii?Q?FeUMjJponXa2l6Ej5/PiTGqBVTUi47yfZmQNgGg0gKxnTvc7ggnbYVlUVtJi?=
 =?us-ascii?Q?yee1jMYD/TGQ5Mq6XJ8nMcEhMpN5xo6Lzq2y2XjCIMEozFgtGgD5WcFJM5br?=
 =?us-ascii?Q?yVtAytbt5sxJcFnve5e7Pkdv5ksaizru+p0YWTRDWMpLz+8ngAu/NrLv9ZEQ?=
 =?us-ascii?Q?+3f1MCtlxlQxd9QeLOq69TcACOHGyjmoiwYmTGRhY+aXttu5oVcte3/x6jU3?=
 =?us-ascii?Q?r1TQ23aUkUlK9eqww72snWEe9D3fk58uIhwotwweqc6cV2CNCLcmTnloQzq5?=
 =?us-ascii?Q?1xRsOssbYO49GsZ2SoJraudXPKDIX7GU9BXnglAWzL1w0EoEvGMXJ73pJIuF?=
 =?us-ascii?Q?vEnjlyUJE8O2PG9nKaiBQw5Y59P4BSEp6mGGucAPFoSv95rBp6bq1VUKkAXv?=
 =?us-ascii?Q?cjdtdZJZjQcgW2ignxPzoDKdPO9V+//nSv4PlxPaAYmKPQTzAvddGd60Oku3?=
 =?us-ascii?Q?pv/9QwOfiTB9pyw/3d9hEUZCL1DlOqh4MTgqj92+WiTpG2y7uuQmvM+Rqe/A?=
 =?us-ascii?Q?Amykee32vzBgnqWutubjGZh1WnprOJj7igscYGB+27T+YZ0HgCEnKslJvAOx?=
 =?us-ascii?Q?htzUgeXaJGEMDgSLf9/U/ZbOhAPcsSwDNZ1kglmPsijK7w28kXVxT0HioNQY?=
 =?us-ascii?Q?RIs3wkvycGdg1RS4g2o5VrwXdOCvEd1jVwyWYQAjd6iNs66qgR4BVu1Dx4Q2?=
 =?us-ascii?Q?km+/WFvKTsHVKzdt8rfQPQbLDGuVM+j/NiwKm5icfRcc+kRg8Fif2eDPuumi?=
 =?us-ascii?Q?ZUuIgk7EVbdipLnvj6HdX+tAQHeDxKQkNIgPBoktj+UIJGAm31JvA8P4DKeD?=
 =?us-ascii?Q?/YqH6C2iRpw2ZEsQgI0zMTMOZoWJL+n+eu+5t7jx1MsKgCtc9ge2CAoOwzhP?=
 =?us-ascii?Q?YoxEN9FgFuqd/oBEW7+YvNmlYlP6UmNUP5GqVL+VCAFv5CRlJzA5JQmQk2yG?=
 =?us-ascii?Q?z16/7lSJ75FyNp4NqSmllECnH0Zn/IOMwtEvergfG8Xr8QgJ/jdE0hTKSnXl?=
 =?us-ascii?Q?NVNdfaADl0E7PlZyTdSWi93lgfHDa9rqwL/GnAEBumV8//QZDtNWpYq60pTf?=
 =?us-ascii?Q?g2CcGu7ZEZyaHpcZcwIr0LZ9mOYtvQgeu35G1htP7QiW2oBdPkKKOb3VIuuH?=
 =?us-ascii?Q?VsejUCaRVdmGup5A0hbijfV4x4UbsB0ciqC4XL2qumVIgFagM/WIx9wuOOPx?=
 =?us-ascii?Q?UIc/KEZo64aYCQIWmxKdkjZBTbi5/Qgj4oBYI741J0QsV5mdyxOp6ITrdfWR?=
 =?us-ascii?Q?uc6TSQBhnIZM1it8dQ7PUZZZbfZpYt1nG6/9FNthyE5zxQDn0gvPlsGJfr++?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e2237d-9539-432b-4e81-08dd49ce7c61
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 12:28:55.6649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7EziCSrXCliw20gp8MvVFKC0NdExeZluLSk5vgcoat0x64r8jr1pL596Y8K0L/TDuQL4HK2cmTn3VBGORzn/y9XZxQ5Y1lvFzhd6YAMrKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6351
X-OriginatorOrg: intel.com

On Sun, Feb 09, 2025 at 11:07:25AM +0000, Simon Horman wrote:
> On Thu, Feb 06, 2025 at 07:26:26PM +0100, Alexander Lobakin wrote:
> > There are cases when we need to explicitly unroll loops. For example,
> > cache operations, filling DMA descriptors on very high speeds etc.
> > Add compiler-specific attribute macros to give the compiler a hint
> > that we'd like to unroll a loop.
> > Example usage:
> > 
> >  #define UNROLL_BATCH 8
> > 
> > 	unrolled_count(UNROLL_BATCH)
> > 	for (u32 i = 0; i < UNROLL_BATCH; i++)
> > 		op(priv, i);
> > 
> > Note that sometimes the compilers won't unroll loops if they think this
> > would have worse optimization and perf than without unrolling, and that
> > unroll attributes are available only starting GCC 8. For older compiler
> > versions, no hints/attributes will be applied.
> > For better unrolling/parallelization, don't have any variables that
> > interfere between iterations except for the iterator itself.
> > 
> > Co-developed-by: Jose E. Marchesi <jose.marchesi@oracle.com> # pragmas
> > Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> Hi Alexander,
> 
> This patch adds four variants of the unrolled helper.  But as far as I can
> tell the patch-set only makes use of one of them, unrolled_count().
> 
> I think it would be best if this patch only added helpers that are used.

That is debatable but I think I tend to agree here. If we add say 3 unused
macros then nothing stops someone from coming up with a patch that deletes
them because they are unused, right?

> 
> ...

