Return-Path: <bpf+bounces-71269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4837BEC5D5
	for <lists+bpf@lfdr.de>; Sat, 18 Oct 2025 04:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD47E4E1AA4
	for <lists+bpf@lfdr.de>; Sat, 18 Oct 2025 02:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B02826CE39;
	Sat, 18 Oct 2025 02:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aymlx45Q"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251D521FF26;
	Sat, 18 Oct 2025 02:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760755585; cv=fail; b=r+ttgrqqzK1CONSaajH4TFf9N8gQLNUFoPj5B0E300M4FvbK1ueDtCwOvYSmE5HwMQn2krMflA+uyNdbLO2xc4wi4QuI4jzcOZNz4hhIcqVy1RUGk/Q5FhEYujeGrc4j5yGnT0Ml8ZQiyc42h812VZcVz4TOWgDukJGhvv+kr7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760755585; c=relaxed/simple;
	bh=kjlloB7yk2i+u9sabnMIAiN2SCHe/IetrHVuxapm9eY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LAYwAN2syeTjwKv8PROjaJRqhQ/8gCAkiB7kvqPBP1BCXSuuN5ll/vnY7XrvrkFiVv5hHyAZgUvCdauSN/Hrqflq+HTyvkIOiyNG35kHKpMayu0XLhwo7n1Q2UTYYlAuvyhNQ8VxKz1UNEWByx3Ps5F3u1D1jLYXhTnhpqel5dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aymlx45Q; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760755583; x=1792291583;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=kjlloB7yk2i+u9sabnMIAiN2SCHe/IetrHVuxapm9eY=;
  b=aymlx45Qh9xyQjzkC2ESuiyBdGVy3UHoai5O3e5arPaPVtr5N0MLenLp
   mVJbS3apWMrhsM4HlnOQjKXkOFxUsVh8BWCDuxvINXA71DLrjJHORJ0iS
   IGIg2dvafA9ivfqRy96ixDDhUcuqIoDDl3aS0jM/MxOSpfbs7LE/t2XRe
   fJEHhZllHkCpx2pfRZ7Ge7tRxgaCWVczrwEcdlM7D639gNvdgcqEzGT3i
   tnnLovxx5BiEQ6ok9sL7Ve+xm3X7uLZS9Ip4ueev1HUCjQDG3tJy3ceAN
   w4Aas23FDWJ2sAY2of+CE+Yy16p2E932B2YGJUWMZzP0NKSEBGSnKoMTz
   A==;
X-CSE-ConnectionGUID: p4Uz3Di4R2Gr+LVytm78Iw==
X-CSE-MsgGUID: TAhVKzyuQ3OOXl9+F8UsOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="62180463"
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="62180463"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 19:46:22 -0700
X-CSE-ConnectionGUID: zGBCWaeXSZSBYTAaxtcyTQ==
X-CSE-MsgGUID: 7DqQv58TRL68zwN3WoE6Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="187288875"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 19:45:35 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 13:09:17 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 17 Oct 2025 13:09:16 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.37) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 13:09:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoR1PGMi0UlANFQowCTYRQd1pNUJn5KdQXx57hi4RigaJHxT7LbiwhQAHzil8TtDYZrzN7qL9GLxjixTSxi0wfmeYOzv2rZTT5F2g33CKSfUrrDLt3GFBMy5aVpGVLGed2jRXpbid6Hp5s2gR+bsKwiIiBGgGuvk8sazxd9RoRULo4nnOpr6Da/bGCUO0nsEXEq28tGQwWs6DbUmonB/GTrfZvaEnw3sVcV8exx7FHlnmNXtpesfHsXPBs9/Haee3pH4P4MHfkT0jlMJx8AMafvTzHrUb3y3inHUKbMpoa3+XsU72cxTVyW1JCqVPjKSKBz2xJUbUja2/lNbed+62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ji3pNDFeC2f9Vn5mSyC5Put/fkZjvewNvIaDWlxlxI=;
 b=eHQ3uR6RD1pCc6nh2BNjx0WoGfFmO0YRchF/PArJ1iEYyZz2blfM6i6KI9zRAf7ZtWOeEQgKuk6jxKwSamZzr/o+ypUiiH3kOuCcedUX7WzM++ekl6BuuDNYb/ARc7O2l/K6QpuWKybMMtPLWt3m8ODlUogSuJHZlkMERPNZEzgioqXLT3FpRPyM41x7bof81NuZcy8hvw2Q10Gze2UakxO4M4BbpvXnTUASytib6aEENcDCth3AuepvisKonBcAkc/TXP7Z5fr2k4ZOnmPfYyaRm1UHXtM0j0rANuFzZXe/5DPZ7i4wJ5xUsEOmHRl202xMuF+xXh0UQxrDz8hNgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM4PR11MB7206.namprd11.prod.outlook.com (2603:10b6:8:112::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.11; Fri, 17 Oct 2025 20:09:14 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 20:09:14 +0000
Date: Fri, 17 Oct 2025 22:08:58 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <ilias.apalodimas@linaro.org>, <lorenzo@kernel.org>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<andrii@kernel.org>, <stfomichev@gmail.com>, <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v2 bpf 2/2] veth: update mem type in xdp_buff
Message-ID: <aPKiC0jZV6kLBvIq@boxer>
References: <20251017143103.2620164-1-maciej.fijalkowski@intel.com>
 <20251017143103.2620164-3-maciej.fijalkowski@intel.com>
 <87a51pij2l.fsf@toke.dk>
 <aPJ0YqfH+pdSIbVS@boxer>
 <87347hifgh.fsf@toke.dk>
 <87zf9pgzx2.fsf@toke.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zf9pgzx2.fsf@toke.dk>
X-ClientProxiedBy: TL2P290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::8)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM4PR11MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 51084ab1-1aac-4a78-0ef9-08de0db90b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?h3YFeswG/mVBWyprYvjM/PKGeXNpKM/9dk9txXk3/lZ0uSbVn/vRmP8oB3?=
 =?iso-8859-1?Q?Sq0g5mfuzX0eXJFd4XUL3FsWrMiKx39a5YsQ+S+HVMJ1eL2rJ4pgH/XVJl?=
 =?iso-8859-1?Q?ueWzp/bV8Uqb7Y5Gu4Ptby3N4yF2T25yBlcANfg4WozIA0n++DlaEjBuuc?=
 =?iso-8859-1?Q?9odTin9ZLSwMIdM97lxAFwucSgNqSISEfXarLmJNhE1m03q0mlZh01AWgw?=
 =?iso-8859-1?Q?st3jgGJIIFFjVL4/N7hoQc/xDfbZRxmk9ZbwOfsDA25ud0+Uy2uwaeKLtR?=
 =?iso-8859-1?Q?4FGOK7jyp9nU8Sjuc0YS1k2fUqzoCq8NWTH7mWzpZ8P4Q8RgF8lqZII4eR?=
 =?iso-8859-1?Q?ebrjHOT50u1nSY6hsxZxlFOIrKnEsYUkwbSo3ZUMKA+7hA6ahU+0W2Np7i?=
 =?iso-8859-1?Q?KzSMoGLcg5lvPR9xr3ZOudaAzgduaxTMw8ee9XyioaAIEXgA0BHJch59ia?=
 =?iso-8859-1?Q?+SyWe9Qlkctthl+j0ctuYpHRlUlQ2AFN32ZRCfFUd2YdOr/11Q6NcTLHgw?=
 =?iso-8859-1?Q?z79xRqCLI0PxabnbHmZ77iJ2Tg/DHG2rNy6uMVa/VBtk8XgeQ7RZkM9pQ6?=
 =?iso-8859-1?Q?VZWrqGmho+sb2NiU9MVf/tMVeDwWo76m+piDDyw7RbrKTB2AXTJLmpBY1x?=
 =?iso-8859-1?Q?C5felMtaC33Mlud6UVLBDvke7a8mUH7ATlyYWe88IW3Nwi+iPgLPaKW+0Q?=
 =?iso-8859-1?Q?fXCaPjPI9H/4S+kF8zR4FV2xqzAnqm3sPWz2ej8BWIr+m6It4V0fJK9KcO?=
 =?iso-8859-1?Q?pgkVLg0h8OHuqTQalo+vcGCFN50HIDS3gSRGwdvGg5AR8eIvrxpQvOCEks?=
 =?iso-8859-1?Q?3qNRxlzaqIiPqld5HbsKSH2k05V5qi4oklZ612pBQERzFDHJzaId3U984n?=
 =?iso-8859-1?Q?EREOsTBC9BfJYgQX4Bsgj9xnvXH2kPNdvjZeNyA8a3mPTn9S7lG0ANsXCQ?=
 =?iso-8859-1?Q?Hojq0ECtNqqF38JFfLpNAWQb6hH4Id19Pv8+CA1ZxQsY5e3I/10xYh9B3D?=
 =?iso-8859-1?Q?GmuO3fQ6I6g0E+NzRH/xU0Jcq2PUc4Q+lW8OwuMfl+ESi6FvPXovW2buJ0?=
 =?iso-8859-1?Q?ZoHOqXxUidamrNVfmkUfwpSLLlup4Fp1am9yxqd73kWZ0UbeuAy0aOki2/?=
 =?iso-8859-1?Q?XRQcSag5hoB2wbEdkCC/t0qe0SbMByzgqUPO99JSuPGA0PaBPQJGeJ0/c1?=
 =?iso-8859-1?Q?aqVffiW/mPHeCZOIoWG/ulgbvBh1N3beel2DzhnwBkCEH3przbJj2lOuRW?=
 =?iso-8859-1?Q?MIRNfqudtEWQzc06JcWQUOXJ5aZwiRoHGRAFlenaSqMKsrqGxdS+WqK97S?=
 =?iso-8859-1?Q?AMipOIyYgcYBPSxXHaJDjDuNOFvEWTQW0LZt6LUaSqj4UHOyBAUMpvcrq3?=
 =?iso-8859-1?Q?fgAFF3chyNxNH0lIF8Tbw05/VgmCY853wMjoxigHodvIRxiMHBApjimvEl?=
 =?iso-8859-1?Q?CFuFjiCZM2dt/TXirD/4nFKoSGvauOlCdmSVDg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?55kxcxnlXSTs1PaveVlsDbH3HQipnZuwrUXXuyfmLu5Mvd3Co6a44wSLie?=
 =?iso-8859-1?Q?WwX1tKKutlYyoyDQ+LB2d1TEebidrn/7piDqcBl/FZIPe0pUvubkQ8v2O0?=
 =?iso-8859-1?Q?1UTKecuV8fn62L2B1/lvwPNGkrG62rdBrqHxu1NMbfCAnke32frl6FFSJg?=
 =?iso-8859-1?Q?GreI7KP7WaINqPY5veMxtdYi3FUv014XHhDy5MXehQN/YmTbJeMxhzIcMV?=
 =?iso-8859-1?Q?lYs13ZB9RCLV9bMrgveEPDsyPXRxjU5i4LAUdnAJFOybBX+hyrID21FITh?=
 =?iso-8859-1?Q?Bes60HbQD5YJRs5jXm3f/L2jkUqh9U9cNU0+hOtyAjy+QgalIbXkkiM/xe?=
 =?iso-8859-1?Q?AOAWOd9UjpEQWn9FxvTMT0E7pHSRqWkuXxMYqFA6IZ00T2YUQUvF/dQEwB?=
 =?iso-8859-1?Q?oT9JOtt5jFhlLewExfTY6O7pILu+z/Kh7pnfIpaPBvEF+4zrYkJxVLIa9Z?=
 =?iso-8859-1?Q?0cgCy0F+vquC0kfRrWIpwFNlrXWpsbOT+xTl+TtqB2Ze8RZ8BBBIZfbIfJ?=
 =?iso-8859-1?Q?1XwkQDvOt6+7ne0SWzQPssR60f733NRUdIY6TpRVhQpq/x30gv2MpRMJbj?=
 =?iso-8859-1?Q?gcank6yHE1MWlUwHANgxPTn1kQRtNZggo0S88g+44sCfnc0vyOlsMGuGgm?=
 =?iso-8859-1?Q?9HFspQ2rUM+4jg3CzTPNOorDskAwMMDsKp/6+Herz5lJlZOdh5+SlUkSFq?=
 =?iso-8859-1?Q?YESk1H0ZSYPRA0EUtYxktjBJwV/rsD/OzDrD1I4GaSUZSV+yzEB+Z733Sd?=
 =?iso-8859-1?Q?FbnBBxOXywS1LuY5c08wXAcqb+PncvqTpWGOHo7SMMhL7Kx8zZsYTUjSif?=
 =?iso-8859-1?Q?tqxun+s/f8kZ7hMpTqcQYEOtFb9mol+nd0QcpIJIJ1YZZC1rrEpdZ6ylgs?=
 =?iso-8859-1?Q?ojXnJ3secnJ6xnTfVD8IAtEr6p0Aoxh0onR9sxsyPZsv8nzcObXeG5ta3N?=
 =?iso-8859-1?Q?Fn/s9izb4+LZgZ3XA1zVL4xLmsYbZGOyBZyWvcHXRcE6Ct6N7xyPvk25SZ?=
 =?iso-8859-1?Q?w48bBkDYQ2PKBx7eImot7sqw7Ot2FOl/JV2tKeKC847GyesRrlvKASombU?=
 =?iso-8859-1?Q?JR7WQY6/XmXHo1Vbq+revlajeK4oYCtTMuCztoRj74qBl+LB/aqSy9bCtB?=
 =?iso-8859-1?Q?xEgp7VJWcknEDr5sbGEwdbFs2ySMsTsr/TC3SDJkR2VllQ8efXCb6Oi/mi?=
 =?iso-8859-1?Q?Qsl6sEzEdawduOCd8qxszZbDHXX1DXPfAY16YAcv4M763sND4wAtBlGNPc?=
 =?iso-8859-1?Q?/UVxSOygWhkNxMJBvlXH5vpOyC3bVVLL4CNV5AJkjRz6tWjSYK3fcj1mBG?=
 =?iso-8859-1?Q?KuihJe2GKndqIcriaVlVzwb6tdp+tUUWxv3Om4JDN+zm/Y3N7tCVcvtY5Y?=
 =?iso-8859-1?Q?tJTnumSaXGde9kIYyc5jS1eTMSJv0f45tG5I0YCh68E+m/4AeisH1gGhZB?=
 =?iso-8859-1?Q?4Lw89Jcj3KdGmjAq/dSD3SYbqdzasFJhqR7o/xkSMGZxsHFMDYJCw6M2Wu?=
 =?iso-8859-1?Q?SRQYEsjONZYD1DLjdX7VtoiGKIZHu00Cx136HaIdMsqXg2YF/eWmrfwXtl?=
 =?iso-8859-1?Q?sfTYOV0gZbk0ptlNZRg4nUlX3AcZzYUrLVkUmszKrXA1feaoeT7jaLuJDB?=
 =?iso-8859-1?Q?tRzFsG/Qy6hmtnePbF2kq6UVep4zFrXDc79lDuX2SmynazRJIcciufdQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51084ab1-1aac-4a78-0ef9-08de0db90b09
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 20:09:13.9770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHcFExyLcE9yg8d0yYX2WQlmkEufGNnye4rNRmvfjIFzPxjkWxZMQSKrQhHGiXy7kAozHyyxavi2ixeAcOAys5Sqhs4qaW0lSbn0Wl8Fo54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7206
X-OriginatorOrg: intel.com

On Fri, Oct 17, 2025 at 08:12:57PM +0200, Toke Høiland-Jørgensen wrote:
> Toke Høiland-Jørgensen <toke@redhat.com> writes:
> 
> > Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> >
> >> On Fri, Oct 17, 2025 at 06:33:54PM +0200, Toke Høiland-Jørgensen wrote:
> >>> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> >>> 
> >>> > Veth calls skb_pp_cow_data() which makes the underlying memory to
> >>> > originate from system page_pool. For CONFIG_DEBUG_VM=y and XDP program
> >>> > that uses bpf_xdp_adjust_tail(), following splat was observed:
> >>> >
> >>> > [   32.204881] BUG: Bad page state in process test_progs  pfn:11c98b
> >>> > [   32.207167] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11c98b
> >>> > [   32.210084] flags: 0x1fffe0000000000(node=0|zone=1|lastcpupid=0x7fff)
> >>> > [   32.212493] raw: 01fffe0000000000 dead000000000040 ff11000123c9b000 0000000000000000
> >>> > [   32.218056] raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
> >>> > [   32.220900] page dumped because: page_pool leak
> >>> > [   32.222636] Modules linked in: bpf_testmod(O) bpf_preload
> >>> > [   32.224632] CPU: 6 UID: 0 PID: 3612 Comm: test_progs Tainted: G O        6.17.0-rc5-gfec474d29325 #6969 PREEMPT
> >>> > [   32.224638] Tainted: [O]=OOT_MODULE
> >>> > [   32.224639] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> >>> > [   32.224641] Call Trace:
> >>> > [   32.224644]  <IRQ>
> >>> > [   32.224646]  dump_stack_lvl+0x4b/0x70
> >>> > [   32.224653]  bad_page.cold+0xbd/0xe0
> >>> > [   32.224657]  __free_frozen_pages+0x838/0x10b0
> >>> > [   32.224660]  ? skb_pp_cow_data+0x782/0xc30
> >>> > [   32.224665]  bpf_xdp_shrink_data+0x221/0x530
> >>> > [   32.224668]  ? skb_pp_cow_data+0x6d1/0xc30
> >>> > [   32.224671]  bpf_xdp_adjust_tail+0x598/0x810
> >>> > [   32.224673]  ? xsk_destruct_skb+0x321/0x800
> >>> > [   32.224678]  bpf_prog_004ac6bb21de57a7_xsk_xdp_adjust_tail+0x52/0xd6
> >>> > [   32.224681]  veth_xdp_rcv_skb+0x45d/0x15a0
> >>> > [   32.224684]  ? get_stack_info_noinstr+0x16/0xe0
> >>> > [   32.224688]  ? veth_set_channels+0x920/0x920
> >>> > [   32.224691]  ? get_stack_info+0x2f/0x80
> >>> > [   32.224693]  ? unwind_next_frame+0x3af/0x1df0
> >>> > [   32.224697]  veth_xdp_rcv.constprop.0+0x38a/0xbe0
> >>> > [   32.224700]  ? common_startup_64+0x13e/0x148
> >>> > [   32.224703]  ? veth_xdp_rcv_one+0xcd0/0xcd0
> >>> > [   32.224706]  ? stack_trace_save+0x84/0xa0
> >>> > [   32.224709]  ? stack_depot_save_flags+0x28/0x820
> >>> > [   32.224713]  ? __resched_curr.constprop.0+0x332/0x3b0
> >>> > [   32.224716]  ? timerqueue_add+0x217/0x320
> >>> > [   32.224719]  veth_poll+0x115/0x5e0
> >>> > [   32.224722]  ? veth_xdp_rcv.constprop.0+0xbe0/0xbe0
> >>> > [   32.224726]  ? update_load_avg+0x1cb/0x12d0
> >>> > [   32.224730]  ? update_cfs_group+0x121/0x2c0
> >>> > [   32.224733]  __napi_poll+0xa0/0x420
> >>> > [   32.224736]  net_rx_action+0x901/0xe90
> >>> > [   32.224740]  ? run_backlog_napi+0x50/0x50
> >>> > [   32.224743]  ? clockevents_program_event+0x1cc/0x280
> >>> > [   32.224746]  ? hrtimer_interrupt+0x31e/0x7c0
> >>> > [   32.224749]  handle_softirqs+0x151/0x430
> >>> > [   32.224752]  do_softirq+0x3f/0x60
> >>> > [   32.224755]  </IRQ>
> >>> >
> >>> > It's because xdp_rxq with mem model set to MEM_TYPE_PAGE_SHARED was used
> >>> > when initializing xdp_buff.
> >>> >
> >>> > Fix this by using new helper xdp_convert_skb_to_buff() that, besides
> >>> > init/prepare xdp_buff, will check if page used for linear part of
> >>> > xdp_buff comes from page_pool. We assume that linear data and frags will
> >>> > have same memory provider as currently XDP API does not provide us a way
> >>> > to distinguish it (the mem model is registered for *whole* Rx queue and
> >>> > here we speak about single buffer granularity).
> >>> >
> >>> > In order to meet expected skb layout by new helper, pull the mac header
> >>> > before conversion from skb to xdp_buff.
> >>> >
> >>> > However, that is not enough as before releasing xdp_buff out of veth via
> >>> > XDP_{TX,REDIRECT}, mem type on xdp_rxq associated with xdp_buff is
> >>> > restored to its original model. We need to respect previous setting at
> >>> > least until buff is converted to frame, as frame carries the mem_type.
> >>> > Add a page_pool variant of veth_xdp_get() so that we avoid refcount
> >>> > underflow when draining page frag.
> >>> >
> >>> > Fixes: 0ebab78cbcbf ("net: veth: add page_pool for page recycling")
> >>> > Reported-by: Alexei Starovoitov <ast@kernel.org>
> >>> > Closes: https://lore.kernel.org/bpf/CAADnVQ+bBofJDfieyOYzSmSujSfJwDTQhiz3aJw7hE+4E2_iPA@mail.gmail.com/
> >>> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> >>> > ---
> >>> >  drivers/net/veth.c | 43 +++++++++++++++++++++++++++----------------
> >>> >  1 file changed, 27 insertions(+), 16 deletions(-)
> >>> >
> >>> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> >>> > index a3046142cb8e..eeeee7bba685 100644
> >>> > --- a/drivers/net/veth.c
> >>> > +++ b/drivers/net/veth.c
> >>> > @@ -733,7 +733,7 @@ static void veth_xdp_rcv_bulk_skb(struct veth_rq *rq, void **frames,
> >>> >  	}
> >>> >  }
> >>> >  
> >>> > -static void veth_xdp_get(struct xdp_buff *xdp)
> >>> > +static void veth_xdp_get_shared(struct xdp_buff *xdp)
> >>> >  {
> >>> >  	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> >>> >  	int i;
> >>> > @@ -746,12 +746,33 @@ static void veth_xdp_get(struct xdp_buff *xdp)
> >>> >  		__skb_frag_ref(&sinfo->frags[i]);
> >>> >  }
> >>> >  
> >>> > +static void veth_xdp_get_pp(struct xdp_buff *xdp)
> >>> > +{
> >>> > +	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> >>> > +	int i;
> >>> > +
> >>> > +	page_pool_ref_page(virt_to_page(xdp->data));
> >>> > +	if (likely(!xdp_buff_has_frags(xdp)))
> >>> > +		return;
> >>> > +
> >>> > +	for (i = 0; i < sinfo->nr_frags; i++) {
> >>> > +		skb_frag_t *frag = &sinfo->frags[i];
> >>> > +
> >>> > +		page_pool_ref_page(netmem_to_page(frag->netmem));
> >>> > +	}
> >>> > +}
> >>> > +
> >>> > +static void veth_xdp_get(struct xdp_buff *xdp)
> >>> > +{
> >>> > +	xdp->rxq->mem.type == MEM_TYPE_PAGE_POOL ?
> >>> > +		veth_xdp_get_pp(xdp) : veth_xdp_get_shared(xdp);
> >>> > +}
> >>> > +
> >>> >  static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
> >>> >  					struct xdp_buff *xdp,
> >>> >  					struct sk_buff **pskb)
> >>> >  {
> >>> >  	struct sk_buff *skb = *pskb;
> >>> > -	u32 frame_sz;
> >>> >  
> >>> >  	if (skb_shared(skb) || skb_head_is_locked(skb) ||
> >>> >  	    skb_shinfo(skb)->nr_frags ||
> >>> > @@ -762,19 +783,9 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
> >>> >  		skb = *pskb;
> >>> >  	}
> >>> >  
> >>> > -	/* SKB "head" area always have tailroom for skb_shared_info */
> >>> > -	frame_sz = skb_end_pointer(skb) - skb->head;
> >>> > -	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> >>> > -	xdp_init_buff(xdp, frame_sz, &rq->xdp_rxq);
> >>> > -	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
> >>> > -			 skb_headlen(skb), true);
> >>> > +	__skb_pull(*pskb, skb->data - skb_mac_header(skb));
> >>> 
> >>> veth_xdp_rcv_skb() does:
> >>> 
> >>> 	__skb_push(skb, skb->data - skb_mac_header(skb));
> >>> 	if (veth_convert_skb_to_xdp_buff(rq, xdp, &skb))
> >>> 
> >>> so how about just getting rid of that push instead of doing the opposite
> >>> pull straight after? :)
> >>
> >> Hi Toke,
> >>
> >> I believe this is done so we get a proper headroom representation which is
> >> needed for XDP_PACKET_HEADROOM comparison. Maybe we could be smarter here
> >> and for example subtract mac header length? However I wanted to preserve
> >> old behavior.
> >
> > Yeah, basically what we want is to check if the mac_header offset is
> > larger than the headroom. So the check could just be:
> >
> >     skb->mac_header < XDP_PACKET_HEADROOM
> >
> > however, it may be better to use the helper? Since that makes sure we
> > keep hitting the DEBUG_NET_WARN_ON_ONCE inside the helper... So:
> >
> >     skb_mac_header(skb) - skb->head < XDP_PACKET_HEADROOM
> >
> > or, equivalently:
> >
> >     skb_headroom(skb) - skb_mac_offset(skb) < XDP_PACKET_HEADROOM
> >
> > I think the first one is probably more readable, since skb_mac_offset()
> > is negative here, so the calculation looks off...
> 
> Wait, veth_xdp_rcv_skb() calls skb_reset_mac_header() further down, so
> it expects skb->data to point to the mac header. So getting rid of the

Oof. Correct.

> __skb_push() is not a good idea; but neither is doing the __skb_pull() as
> your patch does currently.
> 
> How about just making xdp_convert_skb_to_buff() agnostic to where
> skb->data is?
> 
> 	headroom = skb_mac_header(skb) - skb->head;
>         data_len = skb->data + skb->len - skb_mac_header(skb);

could we just use skb->tail - skb_mac_header(skb) here?

anyways, i'm gonna try out your suggestion on weekend or on monday and
will send a v3. maybe input from someone else in different time zones will
land in by tomorrow. thanks again:)

> 	xdp_prepare_buff(xdp, skb->head, headroom, data_len, true);
> 
> should work in both cases, no?
> 
> -Toke
> 
> 

