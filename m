Return-Path: <bpf+bounces-74765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB71C6538D
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 17:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A280B3547A5
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 16:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560ED2D5410;
	Mon, 17 Nov 2025 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0e5ZIKf"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590762D061D;
	Mon, 17 Nov 2025 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763397487; cv=fail; b=b86dr81tQrKzqoEmo2YwwzOks59Py8o7zFXqOq5NwbZEV85wahdjbNvW7DQQUrRH7GQjgkSFgHLBO1lWANcQ62HDSQbbsHBUKdBJ0sInIWE/Mqya8vZFUrgHrB7Xj9zOnGvOWlbOBf+G9EsN3WPsukNK42aKXzZmo5Uz2jEj2Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763397487; c=relaxed/simple;
	bh=ZiFVpPeC1jOm218rjdwx/cbrtay36XB4cZJdaGyfa/o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hzcpe+lN14tVC+pzAPLVxZctEnqo4MDSyWc25cpLyt6w28VkZDLjyWVTQftUFjH/ZtC4xPY6jIjI6NjSnc4L6vCxl2iLq9sztnTH0qMAGtU+VishFH06/Ntqsr9rjutfschAtlHaYRMT9WDy39UxMAQq86F8Gyu5hRgxDSzniOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0e5ZIKf; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763397486; x=1794933486;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZiFVpPeC1jOm218rjdwx/cbrtay36XB4cZJdaGyfa/o=;
  b=K0e5ZIKfAvZK/ecQVrXB7DyegEgCiEDsnW0ZkR0TIQD1H1BiSqNbOkAq
   XjL+Nuv9DOkHf6KOT/qY/1ed0Vy1g5mEPnUAEXAaQMYjHlbYOCfn5g9jV
   J1Th9i5md1+KbSUSjw6IVbF89/tNYgsW6UHaztBrQJV0ukO+k2puYKC6S
   urdgCLrdThWoL1fuKhPUj5UF7HNfgi6XJg2d9gotcBTP6UvQBlyF2Gvh1
   66U+0JescYO9fQ/hMpskwKfXt77GlkXxsVUlxxCeFqZiendlc1xyxGmiA
   s0OZuxzM8zeVe2dUq0nwdjXfviOpSWMuEHUpIEoE3YTBvHybJuYQAl8iW
   Q==;
X-CSE-ConnectionGUID: roExVn8KTqGCkLujE0E2Pg==
X-CSE-MsgGUID: DEIMsqPUTtqRMzCZ9ybOvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="76864593"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="76864593"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 08:38:04 -0800
X-CSE-ConnectionGUID: UD1KU93VQN+K//XhmGVk3g==
X-CSE-MsgGUID: tHWz94AzTB+7nWeBIrdkDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="190734093"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 08:38:03 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 08:38:02 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 08:38:02 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 08:38:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URsZl9Q+/99vfhtox7Fe+cIVvt2SWSFQCOjaekX4E8S5RrxSMxAX/Iw3dGX+FW3OVJM7xfoJBvxZylx3m3/j7pt7kOfI1nzOLndybcb+VpnZ0NwNJh+/eQul1nkIFbmpMz2ZL8eJxd3KDrO1CPB7H5Xv1o2QiTJd0Y/MlZ6iFfAw//VThD11mvzO6k3Yt5YWdME91DDJu19bnhLI2wtfOz+vMxnnNmHMoK8XMwEBhsI4L2i3nnE5oVaFg4rN9eOIAk7YzWTQQHuAUuK5wU0VU1f41ZwoJu+RhuQ+srjpMrJqPl5KSaD6+j2wuUD4D4bqA6t38wGde0IMXlKX3E5RFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJW/BJSUER7yDRFWuqOyy4P1sbrna1wpM/5mFRdaUvs=;
 b=EQY8GvpRqJ6TSaybapo8fqXXPsplpgz8XWDArT/xf3NSHROZOFZorgSJqREC3rRM/XI7ma/W7NxNMPmoFK9q/G/6fcPOyVMYNChZDjyGdjV/HAiQLY5wNCYc5qDZg4f5V+1mPHKCCdBQJtBCVsQLbRkpbrteobye1WzDdRGWliWHEBbAZHAUx2WeQqdh/TukpKnKOh2A2/1KNAnsn8FwlEvIdmYsecWBf+4dPpxVtYPp6M6drpA4gNPa0DFgYtHRHfJUHMMymdIiYpdqjePlwf1M06Ep6CX9K4cAEBRaWVzJNPqqAHgUnod4DcGKQHql39zPOXMhUaa5vnr/D10kqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ5PPF867D7FF5E.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::83d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 16:38:00 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 16:38:00 +0000
Date: Mon, 17 Nov 2025 17:37:49 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alessandro Decina <alessandro.d@gmail.com>
CC: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Alexei
 Starovoitov" <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Tirthendu Sarkar <tirthendu.sarkar@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <bpf@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 1/1] i40e: xsk: advance next_to_clean on status
 descriptors
Message-ID: <aRtPXS8haLNHu8H1@boxer>
References: <20251113082438.54154-1-alessandro.d@gmail.com>
 <20251113082438.54154-2-alessandro.d@gmail.com>
 <aRcoGvqbT9V/HtoD@boxer>
 <aRgysZAaRwNSsMY3@lima-default>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aRgysZAaRwNSsMY3@lima-default>
X-ClientProxiedBy: DU2PR04CA0199.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::24) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ5PPF867D7FF5E:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c36eb6-3198-4669-d536-08de25f7ab91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GpMhW6fbtiBjslc1tUgJsBd1k6SFruyLo9N/b33LMrpEJNY4enVgA/3xcAQB?=
 =?us-ascii?Q?JgNn5jiAbX7lt+fhcH3IbegRJr/BdnQlxm3ZlEDZ6pVdReDuhCDS9kWOs01Z?=
 =?us-ascii?Q?OBm7m38BDqJRPp6yWpD58JxEnsPe+KfLv7QsVFM1jABbRbFffJ1JeII1r9bY?=
 =?us-ascii?Q?Vr2TxBQCxoLCK2JnXqTUiSkl8QpKOavS84nbhIPA3VTWkL3fiMZO2OZrXnh3?=
 =?us-ascii?Q?7yZLtb1KSPix9cByJSbqvTNwALBiXFR3d9FyaajNAtsNHGfWrZedEdTTOXzh?=
 =?us-ascii?Q?QhiCMaIHFHMbA4muFN2JHs6oGDlvQnE0BZmB0WzPz2BQBXb3TqBZ3ptYqnMu?=
 =?us-ascii?Q?HIea0odfCSiR6c9JdcxsBwyo0yoiqSZlHUeH41Qu6GQyazLEmEu86aR8Llj9?=
 =?us-ascii?Q?1Q9EJ9f1J1avu767zK5VeGIRJHe2AVaOmCjmxkz7YicCSiopbxSCTULnWWon?=
 =?us-ascii?Q?H847xKG+nBd7w0gqsbxIiODgZxb8oMKH4zPuszN7AR2X5FyHQblVkhZtC/o+?=
 =?us-ascii?Q?e1doaAJBK5m3/7MpZWqUhPwue1GBCZyez7YeX0oiCAK7EDwtRaaL48dJSiKk?=
 =?us-ascii?Q?TKgUmQpcawsjmyx0dTN0OlcsPYE+2jN14md0UErI49byAx/91AqfCOWd3Euu?=
 =?us-ascii?Q?XwT08IEr9P+wgQOPt+IS/jRMp4PoZbBuIWF9knWNPjl2nN8qED+jrzOGwtTO?=
 =?us-ascii?Q?MvlaNwoF93HJqHN5AqE0sF1onIjQ/Ol73h2avq2hEnbeKQVqnmB80oqv5AZW?=
 =?us-ascii?Q?1a7cVcod5NWyM5j2JtB9FZJDh403nv4eBjLjgTkjAiWxVDQTUyqVCY99D5tP?=
 =?us-ascii?Q?6RJcHSPy6vj2fzu9mCv1jbtpov8yHcTEI2phliAYuP4p7+je84/ixmCOzr4v?=
 =?us-ascii?Q?rSZ04HY2sBr5Oa7rWL6DydLyyHVcd7OM1H1Xxuto12GsfLHHSBP1fJVD5Gd+?=
 =?us-ascii?Q?lVoGo/fykZlTXHb0OXvIcpCZWsDRHyUCLxxlqX3idfw49zdVmEHshK3XWtqp?=
 =?us-ascii?Q?Srg1YS7NrHYksfPrdXXD23BETCwJB/Kbo9yNKvu+52qR5iOSpYKI9hCBOwvG?=
 =?us-ascii?Q?VlpiZ5d2D2SouEGnG+5NvEqP29OMxwYPsJvalx5TUE5HgG+IbLfs+RT4c03P?=
 =?us-ascii?Q?ZLFDqiwMkSojpSl6COsL3puN62F7OFTIRp15K7VGSxt/rJNFQY4MSg9SaZsb?=
 =?us-ascii?Q?SRKPjGQlQBiwli12AkB6DAyh7p9A9YRs78CNKXPoWDYsbDuYIVsWdU271HmV?=
 =?us-ascii?Q?b63dGaiGsboiEd9VaTwSvahWurvB4JaResdh9xCQY05EmofQvHSUExcr0CgK?=
 =?us-ascii?Q?iC0Lv/ilwFz4nPZMhou3XNOBnapnIwkjJsVZK/WxOM5e+i1CvIHStaKJnp46?=
 =?us-ascii?Q?Rp8hcubgXBDHosYOITVszeYLV9rYCTlVfWBprVWQQFxDzAcrRajbde8yIkw5?=
 =?us-ascii?Q?nnSK4tQ7NnijPhT3Dc4tqJ6yJw00PugputZ6yFzzsKacQkuoy8HC7A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oSabFlWZkPFGDI2MBGJ/KLpJjv/1NxPW8UkIhcnCume7E8GFw6TxDg7JoS3T?=
 =?us-ascii?Q?v2ckS2zSUEl9js1iSN+laY/n6O/GmelxOQUIUoA+agRwveB4R+W+X0SOEwy+?=
 =?us-ascii?Q?0HEdX7WUvQKNAg8nqf/fDDcCO1H7+LfNQdqbepFAF6rMYUlIKNlsSYqzZFTK?=
 =?us-ascii?Q?xm4cagLc1LkYUMERwN+xxYnYR+H35SnjesHH8ZGIJk6dC6R1atsiI8B/Z0Xu?=
 =?us-ascii?Q?LoFVgADLEHTMdzrbvcmhmQrEf7XOyjr7wLUCjTp5tdqNKuJ7EfKoSj9POdpQ?=
 =?us-ascii?Q?tc2Ir7OaTMr7Spk9R//Hov0NtbZj2mz623cRkqK84o6tWRHJSroa/2PkC+OA?=
 =?us-ascii?Q?to+88t/EclzBDGPmoamphOfTwjIUU6mC6Wx6pYo5Fd28+xJyrnde378GMb3i?=
 =?us-ascii?Q?XNqWD4EhCSLYxdeb/i91Ftmu7JqMXpSOrV+oljPdES3a3fP1KTO60m5z7JAk?=
 =?us-ascii?Q?g8+OS63tBB0Fvvvt/kX9BKzsQsbGdmoNiQIFLy63o7H7y+hTXuFr+hfWZZ8Y?=
 =?us-ascii?Q?oXViDSa/U7WfdHSNCpZ5lxxRJGyGl5aQXHalJZSg8wYFR3rmWIib9tt8JA7n?=
 =?us-ascii?Q?A/nDXWqQTb+ijErMMbzcG1adkcKOdnj1MR9SHfsj4O2Og5V8ZGC9UcLREE2p?=
 =?us-ascii?Q?WRz2S8+taSIX9mog47EeHXIF8x2/5aZrCBMu8cRKjM3FLC0MDDVDqheOIxin?=
 =?us-ascii?Q?nB4f5Pfsfuc0LhJbAIAeCODPdFWA38EvPbzQU00Xb/04Xeyw2uQzAHl+Bi9E?=
 =?us-ascii?Q?WHtqBMUPw6PrE+qJMDpfkxyMgInVTJYb391psr537K2dEzdl2G7A5QKvAe8R?=
 =?us-ascii?Q?jpnG1M7HkF1QVw4RCDYmUTl3OQydpQTv1hJGCa+vSThPC1UQSUuHO9xHXVE/?=
 =?us-ascii?Q?tlktk1f1i6YRt1lgty8rmqrToJ8uoheU3iwCHwUrNrRbN3Ig+WeXHY2Bowmu?=
 =?us-ascii?Q?45c8c0wahJfOstFdnq4/SICUpmvqnAagtq+Or3Sv3h9aWoZGpFXyVpUXyiwY?=
 =?us-ascii?Q?bLl5nCjmkQoFIBWp8t7DNJdTtO28vHvCaKKvZVjauKkdwHhoX+tT8tfPhP9/?=
 =?us-ascii?Q?hjs5mmngGVTiQHCvt/tXEavI8yUo01Lq5p0ts33Wn3nlUaQ94LVitQZIFaH5?=
 =?us-ascii?Q?H/sPlyWj0RvCv6TR/pfeUstQ778IE6gXij5DkpUjGvhIkvAKdPSUJEgYro1f?=
 =?us-ascii?Q?NDYKuzk1oPlq3foi5oLgncaJzdkGwt4x6Etwnyj7ZfOu17q4nKrkFAy+u/h6?=
 =?us-ascii?Q?h7kaLsW6R5EMzHuCJg0l4zZrgHJPsOB6ctt7/aqM3vAXRx+bmQaGplVpDCnm?=
 =?us-ascii?Q?Kpu+I9b5REACJwJCv0Rbs//9lbeKX6Bvt9n3STlmp4yGfE7WRmygBxRJ423a?=
 =?us-ascii?Q?uytnSG10LrtcUPSNr8avybVR5MplH9S0LmpjQUnDCv936WzT68EHZ2YTTbfw?=
 =?us-ascii?Q?i19tRLRIONbi8uUFMDiv788JjY1zeIJfjzeHWcrvf++VwGzRqSscq2xg281i?=
 =?us-ascii?Q?2DAwMUzdN88QNnN5d4KGVTlNnThyiziSYcYXjOPzTIwfLkDaJZCME3ZqdVfF?=
 =?us-ascii?Q?ksvoCMXBcb3bkFN+kjpU1NL+NUjTNV09t0AWOPW27j0yCGfZgA7wOKOG9GAg?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c36eb6-3198-4669-d536-08de25f7ab91
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 16:38:00.2428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnxHNMgHOUG7ZUUoxwKGqoFN3suzyunGxEHlWtq56AvfpuJifMqvRzg218/kOhmKcdRqng17P39jlNHuklqOUVfWqwEdu2bI1gJwZ+UTdGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF867D7FF5E
X-OriginatorOrg: intel.com

On Sat, Nov 15, 2025 at 06:58:41PM +1100, Alessandro Decina wrote:
> On Fri, Nov 14, 2025 at 02:01:14PM +0100, Maciej Fijalkowski wrote:
> > Woah, that's not what I had on mind...I meant to pull whole block that
> > takes care of FDIR descriptors onto common function. That logic should be
> > shared between normal Rx and ZC Rx. The only different action we need to
> > take is how we release the buffer.
> > 
> > Could you try pulling whole i40e_rx_is_programming_status() branch onto
> > function within i40e_txrx_common.h and see how much of a work would it
> > take to have this as a common function?
> 
> Just before I send another rev, you mean something like this? 
> https://github.com/alessandrod/linux/commit/a6fa91d5b5d1cc283a2f1faa378085c44bda8b4a
> 
> My rationale for i40e_inc_ntp_ntc was that _that_ is where the bug lies:
> letting ntp and ntc get out of sync. By introducing a function that
> forces you to _have_ to think about ntc and explicitly pass NULL if you
> don't want to sync it, bugs like this become less easy to introduce.
> 
> That said I don't mind either way! Let me know if you want me to send v4
> with the i40e_clean_programming_status() change.

This revision is much more clear to me. Only thing that might be bothering
someone is doubled i40e_rx_bi() call in i40e_get_rx_buffer(). Not sure if
we can do about it though as we need to use ntp from before potential
increment.

...maybe pass rx_buffer to i40e_get_rx_buffer() ?

> 
> Ciao,
> Alessandro

