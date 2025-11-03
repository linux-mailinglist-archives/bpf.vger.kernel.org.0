Return-Path: <bpf+bounces-73377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B905FC2DC2D
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 19:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D26634BD0A
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 18:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8463231E11D;
	Mon,  3 Nov 2025 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gkvh3+wC"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9093731D38E;
	Mon,  3 Nov 2025 18:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196112; cv=fail; b=plxbSeIWnlsk38Qkxd41ZzGVo9so23X7R1GfmYZz/xL4L66cWAAeBaPeHAqvU+0/5+e+pJBaVj/IlYInD3BewOg6a7rqbqInBGqWFhf6sKCERGAcQikpqMdGkqHSKo4u7uS+E/XLdM7rrl8CLjWulWbNTolOtwoeOhtfLlhEQy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196112; c=relaxed/simple;
	bh=FS8APazSvIZo8FhUuo9kXMltDue/GofuRY2SD86G1nw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XTEHmERr3BVdEPYZm9EiNVWuybVGMJY5j/Y7jUUk6yc8tZd7IcwbdXfwUMTzm0vIi50uNbkJvi5yQdNFA6AYw76g/lMj1jsAcB6Y3ZIuaHEXYn0ywouSSv39mox+vL170w5ChmNM7EDUWRXQPTHdNga3DQ+uX7goutbcm8GmlSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gkvh3+wC; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762196110; x=1793732110;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FS8APazSvIZo8FhUuo9kXMltDue/GofuRY2SD86G1nw=;
  b=gkvh3+wCDMYLg5h4/GMtPyjCu040VmW0K7HTNXcYFyU4zYPG3mjcOtpY
   Kr6eWjS3nbTI0RraWwsGVphv3gmiPPhTqX/wf5in9ez4U6bDEoh/c3CEw
   i8RXSQf5vTtIhHQgzu9y1KpIj/3mGHBVY4WimH0iCEYboPBOZ31KG4Kez
   7L5SBS5+k2H3mBMEJsgcmEM7BUxZ9Igg4Qn8QLIlyLugNUTdZI8fDzz3e
   r5vSITnVNo3ldKIn3D8xKn4S3uIOF/XCIAWjB3+z4wNmerJIXwwcMUgZQ
   NXwGPQjENOmHPixmGJBV2a2OhHkQDCOVBvRHvqkn4wAyTcDiQpNxWfjEm
   w==;
X-CSE-ConnectionGUID: IOSc2whuTxm0HzZp/nqvTw==
X-CSE-MsgGUID: GNlCKsM9SJCz6xkf6+A7xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64318487"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="64318487"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 10:55:09 -0800
X-CSE-ConnectionGUID: WPxvEd40T6+Fhoyori6bEg==
X-CSE-MsgGUID: E0VScPOjQI+iC9AmWZRYQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="191265307"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 10:55:08 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 10:55:07 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 10:55:07 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.42) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 10:55:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLIHoW0KxMyMVS+K1zPRvcMZgRa6WzHvwWclSPrXVNBm5mUzNdEJeCcp8xiZijFegqHWqeM+0SvDEq1ZDqwQ9gNZKKPOdS1rGXr0NprDuz1/yN6hfvH2MhKo7b3/ACbJ0G5rzroNtjewnNC6wdWtm1EpsoLxKIjcxXsBhd4RcFGiofoD/VHvoaKkyloWoGXnJvYj8QorjFN7OZXGIn1Ln0ab6WvKeFif14p6QKfhSFiY9XdGjKRYD4C2FPiyVz8gF/m7m93/oHNQEEjfXKpNCLjnjH2HqvOldgcwOIuw89dQpJeYkbfvOEPqZfHPfd7woIe/FxmoV/BzQy3X+3q6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0L1ilQRmrAtmiCNxOgCpjJxmZwi8Hu2+nHYxfv2L1dI=;
 b=xnRigP0gu/NzLs6shs38kdgfLHjisPQ9Hk0tsqGK2dS5zpf6/YeTWpFBq/Dd+ZdWdQ0IpN/LMT9A/1WvG5PnBHiIcbFkFl/3XW4++ZERIQBTwHagYnx+5pJqTiCVAhxKgXKcbImMFxVOp0AQRVfFiEK97QuRNRfRa1Mxq18rqdXOZiMVCUB3+Nswy17p5kMLe6+Tjv6TPfSa7Dukfv3mAfuAlxw+1U6LE9b+B/9C1lxWkctg06+XT4X+caum2XbwkmhDmV1RiDASKZL+iWmCdbh/213rKbqi7Mf+W/8jXPl3VzfJGTQtOb2i5855VwhJ31eNVrbkUX4KUko8UamZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB7577.namprd11.prod.outlook.com (2603:10b6:8:142::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Mon, 3 Nov 2025 18:55:01 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 18:55:01 +0000
Date: Mon, 3 Nov 2025 19:54:46 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: "Nabil S. Alramli" <dev@nalramli.com>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<lishujin@kuaishou.com>, <xingwanli@kuaishou.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<team-kernel@fastly.com>, <khubert@fastly.com>, <nalramli@fastly.com>
Subject: Re: [RFC ixgbe 1/2] ixgbe: Implement support for ndo_xdp_xmit in skb
 mode
Message-ID: <aQj6duztdHrvcv2w@boxer>
References: <20251009192831.3333763-1-dev@nalramli.com>
 <20251009192831.3333763-2-dev@nalramli.com>
 <aQjahdk/fl6EBcso@boxer>
 <6c83089b-3e0d-4c72-80a9-8049cff1dd57@nalramli.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6c83089b-3e0d-4c72-80a9-8049cff1dd57@nalramli.com>
X-ClientProxiedBy: BE1P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:82::28) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: a2cc4ba4-d2af-4a4c-7330-08de1b0a7dd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8ZfUri3WQrFCNWa6tAUnz1fxliz3PFzfrJUhcJwAUvvIUPb7iwfroZ1dSKSt?=
 =?us-ascii?Q?rZLEIfiVvu40RKnt+j67mfDsgbbFFFn3ZduA+TKOsASTDT8d/1nJN9MB72z3?=
 =?us-ascii?Q?oa90QHtMrtwS0Io0DCW2vvc5SHrysOvQZAd4hgHIrm3gwLYsfrkUij4/LNsq?=
 =?us-ascii?Q?6xDXE1VgpqWdLIDrpLQqA1QYKBXJ8+0kPClodc3+VjAEkfJFeruWVDkwKWfb?=
 =?us-ascii?Q?L7kdQeaJyl0q4S1EMTMmWfLj/D3ia1/aEm/fldTmfMOmSn0q1VRp8jPYEKZ8?=
 =?us-ascii?Q?05jlb0GcctUFP2DcwTldL+nli2E+6ru91vP10LXvoxlVWSingOQjOxFNgLXd?=
 =?us-ascii?Q?BV9nK3JkfA6G2m8dIjtgo3+VMOGV5rpPXTFT6gUTUZoTKoX95PERPuh6gXUT?=
 =?us-ascii?Q?RJhqounpxkkwVumI1/m3uJNYqmyfydGmGMEiePDv85w3AQXC9rBxA5kK+6qE?=
 =?us-ascii?Q?q7mPuvcu4grypbCPUsL7ie57I6FBN/hrBu0SA6Ow6JAC11maKURUdea32zq+?=
 =?us-ascii?Q?T8edPzFk1MYwcHVoicaX29paVy1gn0W/BChV/7p+SQxGzjwq7lSe8LlN6Ei8?=
 =?us-ascii?Q?4814yTITuhWHhDm6yPCtQF2pnjFz2H36dwhmjO87Cu9g1bADehNUjVSAKjV5?=
 =?us-ascii?Q?9H1tdgtRhu0pYDtTDghvtjXrc5wnTLvM6wlTv5a2UeIymWn9xxJsguNcN69H?=
 =?us-ascii?Q?ZZNZQm27JzCmZCLkNDNeNWtU5p8z4rrn2mKBimP849DdvYPV1B8HMY6o8gNf?=
 =?us-ascii?Q?v5Gfa1SCK9gf5AVqCj7WCrU8mHCD7LGKeHiyx0YsBQjVNsv4F92BPe65irYC?=
 =?us-ascii?Q?nzxFVxyoGHeE6W4Z63jwDbe6UrkCzSpJvOxFSLHjKHf//uTaSH/OlxJujfyN?=
 =?us-ascii?Q?3D5d6kU7EbI1UPJOLFgHElxlB5iKhPr5VpPvgy/GekUs+XfBv/hgBvLslov1?=
 =?us-ascii?Q?COfp05MYmCUr0pOvsvhif7Z8wwYzLwWaQFjglByGHDjlYai+0YdvExuN3qGz?=
 =?us-ascii?Q?p29KxXu3uYA/2DVs414GKnAwSisjyA5lvdB5/NQD+fhwMZ/2eFROzpMT5I/N?=
 =?us-ascii?Q?uOt/LoarXUaA6Mk8KLLhFgebuPpMelarKbD/kJ0uBpKmXwE/3e4sM2z7Kyip?=
 =?us-ascii?Q?OIMikoCjB7eyuMSCvH6QOGlH6JcOPktqtQzdov6FbbE03zRNAbGyc2O1WLRE?=
 =?us-ascii?Q?O/Kxg+6u8EA3tDUHgIeHc4/kmbKReCqUV4kAH9wGFf1EAuPPWEbdVQf7PMb/?=
 =?us-ascii?Q?VAEEMVKwCEBiGGiXDirNVENmvH4SK0Pc5E0p/uvTW9Yw/9feh1zaQq1krUIa?=
 =?us-ascii?Q?x5LR7AFd3czEDAw3LMySOKKA/gXTIpImErSyRHqgu8TyOH/lLLUZyLgdToGj?=
 =?us-ascii?Q?bK7rBDheCiXcg6K7rRnGtnpL8oM8y4/pa6lmO8a623Jq41ELf3mvpB8l/ORK?=
 =?us-ascii?Q?IWJwGvCyIa55Ipq7nUR2bf/XV/qIweTS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ECSyjMWovxgiqx6d+L1M9r7QbWTkP0XNE5YV0PZje5B2pCI4fFkEzLejs0hi?=
 =?us-ascii?Q?zIHQnTADF+GQcI5jlL5DKvQDkfw8WmgXeIZzLMpdZTsF6RLZYFR2YMofj1bk?=
 =?us-ascii?Q?VB0th9Xi0509VybJiTpOVUenhv090CKOw4Z4VhuSJy9SskXZSJly138hWxPM?=
 =?us-ascii?Q?i5e+jimMB7QOrMiT7/Xv0dIhoJvoin2pDy5DJi8mMwG6W4R2MQoTXMsKsWA+?=
 =?us-ascii?Q?R4YZKql4ZjpO+dHzSbnQ2bTp1JUcfXw1EML6PlWS5MY7fz6OQOoLKGQInijv?=
 =?us-ascii?Q?zcv95vnOrfQhfI0ep0hVjOdkCCGPyfSpyKQxdlkqrs5SpfT9fUrgPSk2l/sK?=
 =?us-ascii?Q?XKWWlhvfkeK++GBKfIXMnAvXAlFhIzi4CznwdRtZwHcMxOj5hcN5/MR1yRWm?=
 =?us-ascii?Q?ErR1PF1tHMXfgqFeGDonJdinjlRfpbolg2KDQ7Fnui9IvJUkxT3n65lyVV6O?=
 =?us-ascii?Q?SAC40fmXwjsyFYZKZyKfA7Pwv5Rk8zJCdmOjHOPWcGMRXLZakcqTwiXLVYDc?=
 =?us-ascii?Q?mZ6rwdUE7h4gyXQQM4W4VFK1JK3sv+2S7SYyNcD53ak9qo0q+g4vnh+e9rnR?=
 =?us-ascii?Q?SJIUVqlruOdm70dA83o7mb5/Oo8ZoIECrjtqsBDvsv7pzMc4WiIJYmrCci5G?=
 =?us-ascii?Q?ogPCtlOHC+gj3Wyg+TQDx9o1541ilrus0sM0rbia29Bc+1jslGMRN4W2m/O9?=
 =?us-ascii?Q?2RaMYPAjvlbiMK4iiaFW9tzR7/vLMYiEoIpYffrMvA4ZVeBMaybd3GESfw0l?=
 =?us-ascii?Q?Jlkz4jQBbBmqobnKK88gAHnpjSZw6sxYY9x4XMLgMc0YpnJvbVYvkHEHhHlE?=
 =?us-ascii?Q?twkmor6iRrtLkKwbcFEYbhKJoCen6s8G42DfkNlquDMDGlYOKgClhIp0ZKZv?=
 =?us-ascii?Q?sXUgsN5wLJfK/EM1ceyDmrPXMi4UlWKUet9acqH4dWEtPvvHXkzWj8TOtNxS?=
 =?us-ascii?Q?Xg+A940O1UqautoU2GtZfeHMUmcV1txIjEt48iRecK7c32iP5XoQgv6/lu/G?=
 =?us-ascii?Q?VyNsSlFizfxPnvL5EFQFSbIl17nvFCbZdJ90lcp4qsez34d2tLZEJqEA3FDC?=
 =?us-ascii?Q?22HQTubWTddCwV9NmjNDZe6vopbqRJxtMVJ6jA7ak2inJt9Y6oeE30KuLE8u?=
 =?us-ascii?Q?XfxDFh01lytxaFZ6UZcurSeMmpIY6bqxbMwb7a4luJpTdnFh06QRsXEXYO/X?=
 =?us-ascii?Q?O7SHAthY8+aETkAq8Ly7Kxj89E2+Aocpz1xop9GQYXhLMW/BXJ4Qn3hjBtqk?=
 =?us-ascii?Q?x9KWYoRyiJUIfdDbfJI/3juH+0OvZhI/H/8lUokgYf1R74m+KHP4AOv8XS1z?=
 =?us-ascii?Q?K4Dx3ZKeyXSsjE9vps/4Jj4bJzT8oz3DZU0rlJ68Tsbwd5Q+cbOJB1GIA7gX?=
 =?us-ascii?Q?/Z1i6EYhaVkbQcue0d9EzUiQUKk2PAE5R7Fok1WysDbIyZ/y+qhsMRZYMfF+?=
 =?us-ascii?Q?HlSGJAhhRH+1x4ImTNqxd5oQgJEeZBL7smnMBQxP7bOzpk82P9fHZUCltiD7?=
 =?us-ascii?Q?D6aBG4hYVMkxhk7OgRPKDMcpCH6Th06EuejtNs8mPL6UDlSayAjJQAiACsqU?=
 =?us-ascii?Q?fE2vYtBXNYd2kxO7YIeRolvY2FskhvROubu4Tu4HNS3rYs5VQceRoy5v31RT?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cc4ba4-d2af-4a4c-7330-08de1b0a7dd3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:55:00.9241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j72/4ul6qx3lZFLtzodBb6mehduWh/+CyNgeBwvF9Dmk9/KMg8p6yPp8+5J3XVL9LyL8XfEuKlPPa019wmm6fyWxCfFW1a9wP1aFhzmvd2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7577
X-OriginatorOrg: intel.com

On Mon, Nov 03, 2025 at 12:40:14PM -0500, Nabil S. Alramli wrote:
> On 11/3/25 11:38, Maciej Fijalkowski wrote:
> > On Thu, Oct 09, 2025 at 03:28:30PM -0400, Nabil S. Alramli wrote:
> >> This commit adds support for `ndo_xdp_xmit` in skb mode in the ixgbe
> >> ethernet driver, by allowing the call to continue to transmit the packets
> >> using `dev_direct_xmit`.
> >>
> >> Previously, the driver did not support the operation in skb mode. The
> >> handler `ixgbe_xdp_xmit` had the following condition:
> >>
> >> ```
> >> 	ring = adapter->xdp_prog ? ixgbe_determine_xdp_ring(adapter) : NULL;
> >> 	if (unlikely(!ring))
> >> 		return -ENXIO;
> >> ```
> >>
> >> That only works in native mode. In skb mode, `adapter->xdp_prog == NULL` so
> >> the call returned an error, which prevented the ability to send packets
> >> using `bpf_prog_test_run_opts` with the `BPF_F_TEST_XDP_LIVE_FRAMES` flag.
> > 
> > Hi Nabil,
> > 
> > What stops you from loading a dummy XDP program to interface? This has
> > been an approach that we follow when we want to use anything that utilizes
> > XDP resources (XDP Tx queues).
> > 
> 
> Hi Maciej,
> 
> Thank you for your response. In one use case we have multiple XDP programs
> already loaded on an interface in SKB mode using the dispatcher, and we want
> to use bpf_prog_test_run_opts to egress packets from another XDP program. We
> want to avoid having to unload the dispatcher or be forced to use it in native
> mode. Without this patch, that does not seem possible currently, correct?

Why does it have to be bpf_prog_test_run_opts?
You're trying to use an interface which was designed for native XDP from a
different layer. Generic XDP has support for redirect and tx.

> 
> >>
> >> Signed-off-by: Nabil S. Alramli <dev@nalramli.com>
> >> ---
> >>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  8 ++++
> >>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 43 +++++++++++++++++--
> >>  2 files changed, 47 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> >> index e6a380d4929b..26c378853755 100644
> >> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> >> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> >> @@ -846,6 +846,14 @@ struct ixgbe_ring *ixgbe_determine_xdp_ring(struct ixgbe_adapter *adapter)
> >>  	return adapter->xdp_ring[index];
> >>  }
> >>  
> >> +static inline
> >> +struct ixgbe_ring *ixgbe_determine_tx_ring(struct ixgbe_adapter *adapter)
> >> +{
> >> +	int index = ixgbe_determine_xdp_q_idx(smp_processor_id());
> >> +
> >> +	return adapter->tx_ring[index];
> >> +}
> >> +
> >>  static inline u8 ixgbe_max_rss_indices(struct ixgbe_adapter *adapter)
> >>  {
> >>  	switch (adapter->hw.mac.type) {
> >> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> >> index 467f81239e12..fed70cbdb1b2 100644
> >> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> >> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> >> @@ -10748,7 +10748,8 @@ static int ixgbe_xdp_xmit(struct net_device *dev, int n,
> >>  	/* During program transitions its possible adapter->xdp_prog is assigned
> >>  	 * but ring has not been configured yet. In this case simply abort xmit.
> >>  	 */
> >> -	ring = adapter->xdp_prog ? ixgbe_determine_xdp_ring(adapter) : NULL;
> >> +	ring = adapter->xdp_prog ? ixgbe_determine_xdp_ring(adapter) :
> >> +		ixgbe_determine_tx_ring(adapter);
> >>  	if (unlikely(!ring))
> >>  		return -ENXIO;
> >>  
> >> @@ -10762,9 +10763,43 @@ static int ixgbe_xdp_xmit(struct net_device *dev, int n,
> >>  		struct xdp_frame *xdpf = frames[i];
> >>  		int err;
> >>  
> >> -		err = ixgbe_xmit_xdp_ring(ring, xdpf);
> >> -		if (err != IXGBE_XDP_TX)
> >> -			break;
> >> +		if (adapter->xdp_prog) {
> >> +			err = ixgbe_xmit_xdp_ring(ring, xdpf);
> >> +			if (err != IXGBE_XDP_TX)
> >> +				break;
> >> +		} else {
> >> +			struct xdp_buff xdp = {0};
> >> +			unsigned int metasize = 0;
> >> +			unsigned int size = 0;
> >> +			unsigned int truesize = 0;
> >> +			struct sk_buff *skb = NULL;
> >> +
> >> +			xdp_convert_frame_to_buff(xdpf, &xdp);
> >> +			size = xdp.data_end - xdp.data;
> >> +			metasize = xdp.data - xdp.data_meta;
> >> +			truesize = SKB_DATA_ALIGN(xdp.data_end - xdp.data_hard_start) +
> >> +				   SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> >> +
> >> +			skb = napi_alloc_skb(&ring->q_vector->napi, truesize);
> >> +			if (likely(skb)) {
> >> +				skb_reserve(skb, xdp.data - xdp.data_hard_start);
> >> +				skb_put_data(skb, xdp.data, size);
> >> +				build_skb_around(skb, skb->data, truesize);
> >> +				if (metasize)
> >> +					skb_metadata_set(skb, metasize);
> >> +				skb->dev = dev;
> >> +				skb->queue_mapping = ring->queue_index;
> >> +
> >> +				err = dev_direct_xmit(skb, ring->queue_index);
> >> +				if (!dev_xmit_complete(err))
> >> +					break;
> >> +			} else {
> >> +				break;
> >> +			}
> >> +
> >> +			xdp_return_frame_rx_napi(xdpf);
> >> +		}
> >> +
> >>  		nxmit++;
> >>  	}
> >>  
> >> -- 
> >> 2.43.0
> >>
> >>
> 

