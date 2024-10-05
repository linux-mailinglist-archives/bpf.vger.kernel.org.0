Return-Path: <bpf+bounces-41045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAF5991541
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 10:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7271283DB0
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 08:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BAC13C8E8;
	Sat,  5 Oct 2024 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oG522Lqp"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2271F95C;
	Sat,  5 Oct 2024 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728116482; cv=fail; b=MsXYkFWrSSgt9ZwzgwTRj6X7aYIkYfQoiQJSshvIV/1N9qEgq2fTMaqyi3rPfcqjOQxxb6QAEJv1wN27GjxMRm6ZcND4GhJkginSm4vM/RqymCqIRJWaI6xBqpMujsrNhmaxX2fH83hKFhHuOOeRoU1T4ImWWjIrykV4/dpQzzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728116482; c=relaxed/simple;
	bh=Tgp0rMP//3V8MkBwW7Z2l4xOjPXkqlDFJ00ES4ipfEk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lcJ13F1AF9ZA5eF7+Fk5iL90/bwm6Y1mx+Eoo8VTIE6rwWDnkdmIQEnRtt7eswSsWHPEDHKlysqyO1pjQ2DC63t6959nFrTaHfE6nbGxSuz0l7mOvBlg2q6zJ5Wpv96Hn3oDlvkLv7/O0CNIZOuntnCc8mg+//GgzYV+gA6DQH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oG522Lqp; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728116481; x=1759652481;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Tgp0rMP//3V8MkBwW7Z2l4xOjPXkqlDFJ00ES4ipfEk=;
  b=oG522LqpyNlFXo4I9nq+ow6jqH8p2wQq0yUS6uSlfMasjkcbqBvKk1V4
   n4HBrrHb6remWVeARUuZpZV54f3V3Two9Shf76tOOku/ai8aM1cNG0Ue1
   AYhjzZ5G8vtgPlAWQ7paRm/L8auAlDhXLSdyd3dNnG/08B1i+2TfGLLUM
   W6ZtoEtAdBzSLZTvJouPienYmB6pqISZ7sUYva7MsLK6zRep/OmZjzZlS
   Lr1CvJnioo7nDUTngllWegF6REXq+U21SEoM0tebF663TQyyYWoPeu5r0
   AMRstlrqa2gtjoNNRrWXZmX9/1h+YCbnE9HoC+SANEr4h5ZDN+UXK2gEz
   Q==;
X-CSE-ConnectionGUID: oTrEldYVRw+zWj0z+9r8Mg==
X-CSE-MsgGUID: 46CrffK0QrySxPaXkpWSMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="31128878"
X-IronPort-AV: E=Sophos;i="6.11,179,1725346800"; 
   d="scan'208";a="31128878"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 01:21:20 -0700
X-CSE-ConnectionGUID: LAosS42CTmqpy+aiUg8TVg==
X-CSE-MsgGUID: wDY822X/SBaZ6Rq+M9eQGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,179,1725346800"; 
   d="scan'208";a="74763447"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2024 01:21:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 5 Oct 2024 01:21:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 5 Oct 2024 01:21:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 5 Oct 2024 01:21:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 5 Oct 2024 01:21:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soD3PMjLRKgHFie/rT9dbL0/JDX961TlN9CvU3J+pblBGni/iW3cXtESUxTNuSEa8TBkuYPx8Rk/AUFxP8hz5OY1ZFSGHeoUSfsENhvvSRUkg34U6JF5OWjig3D6JWWbJg4ir5oggx9fNf04bjmCHRb67bSW86Eq4zWh6S5QHPTHbiO9CcN7AMIk4Gas/3TObBjkseFqb5P3p2WRitxCm8Orno2pozB3rfOZSwXZzC1PR6IakDaLOfhiUYdGpmCG3ILAaF52ZHSQhSEuOUcqNxzmDbeYFQ5JEwRNbu5Dlm2Lcv3w8kHYpyeVEdMDurQEnCNptfEm3o+temW5u3afXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHMm0QehgU1H6DCumJSfB/cdQvxESDfJFiFPQDDAUiE=;
 b=mwBgnAMg18z6oU6hnNO1eUFbffCkhE5G5ZAF1t2Ps71IsibSvn1ar5qQleno8j71N0DSKfxII8Lm5SJlXFufv0xqkd+EdiDDafsRSi08K33PlDMjE48C3F94tKvioTjBHmqsllwPGuFYFt8X2sC5OKv/Ione/ZNNymouymn3Ibc1t30xT7qPJ7w3NLwEweeX1n38RayugRgjOuPiMCVSYP8pCbTGr7wh68DIWGxxf+NLzqneJ8q+BoJ8VtjbwZ2YLJveQ7liSsQlCpFRQUFKxKfnXHNP4Hn0D4nnN9baFeGMJjxvcL2Ma4z65F/4faZsXiSrVZffHVVndmZHUSVSjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH8PR11MB6659.namprd11.prod.outlook.com (2603:10b6:510:1c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Sat, 5 Oct
 2024 08:21:16 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508%4]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 08:21:15 +0000
Date: Sat, 5 Oct 2024 16:20:59 +0800
From: Feng Tang <feng.tang@intel.com>
To: syzbot <syzbot+80b36e60457a005e0530@syzkaller.appspotmail.com>,
	<vbabka@suse.cz>
CC: <42.hyeyoo@gmail.com>, <akpm@linux-foundation.org>, <andrii@kernel.org>,
	<ast@kernel.org>, <bpf@vger.kernel.org>, <cl@linux.com>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <eddyz87@gmail.com>,
	<edumazet@google.com>, <haoluo@google.com>, <iamjoonsoo.kim@lge.com>,
	<john.fastabend@gmail.com>, <jolsa@kernel.org>, <kpsingh@kernel.org>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<martin.lau@linux.dev>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<penberg@kernel.org>, <rientjes@google.com>, <roman.gushchin@linux.dev>,
	<sdf@fomichev.me>, <song@kernel.org>, <syzkaller-bugs@googlegroups.com>,
	<vbabka@suse.cz>, <yonghong.song@linux.dev>
Subject: Re: [syzbot] [bpf?] [net?] KFENCE: memory corruption in
 pskb_expand_head
Message-ID: <ZwD268XX+eEoeNGo@feng-clx.sh.intel.com>
References: <6700f123.050a0220.49194.04b5.GAE@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6700f123.050a0220.49194.04b5.GAE@google.com>
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH8PR11MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 4acdd079-5fa8-42de-bbbc-08dce516ae27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JDn8LyvzyCWlrLARaAlmK+uCdFofo4pcSAe5LLYO3FOnc0MPcadzTZuT63hB?=
 =?us-ascii?Q?CW3mDpJfz5KWdU1/06rJLBe1DOiBGbccFqNYLX70tLmCzL5AxmRtqXQkKKM2?=
 =?us-ascii?Q?sVdjDu4Jm1wzNV+e1Yj9zV/oEXZXyCoOrgSDNqgWC7sJ2F6XCH9OAKbel1sX?=
 =?us-ascii?Q?SE1Z/aGB3v3xLCVAoqaJSftsET2GO3E+MGwNAg4dcuAqfHnelYNEkGZ5OYT5?=
 =?us-ascii?Q?43+ggGd44R8WxIqUQ+FUlBRnaY0W2OuOAmyr2aI7grzKw3u57Dyv2yeYPD8X?=
 =?us-ascii?Q?rRkZRvvSNaYUFuXmAwwsOa4d2qbq8i1JUU5xRZXVJ2w1JYA60mf3f2lJvqDi?=
 =?us-ascii?Q?zARgPDlbb7oHITux7bwVtEFahki3uEolbiBm2C3x0G6d0kWde1jH7DRIkSXx?=
 =?us-ascii?Q?jVuQJZqbMBtCYDJ11Y5AvMLUuMatcHW0ev4DhMQ6yt9gFvSARBCKAc5Qj3cV?=
 =?us-ascii?Q?rGQu7weiSwXleAkDNQRM0EJDz2x+EeQZ9pcukyZTEbTer87mjk9LpJjyVLT7?=
 =?us-ascii?Q?hK87117LLgtdUoX8Ip9SBFRKr+ly072pPsEJtAS7H7VTNw9c6nNQXRxZDee5?=
 =?us-ascii?Q?kfZD8D/Q1FSW0w+1EB98/wMZUJOx8jtJUWAY3Zi1POqisVYkVRgt+oxlcYHb?=
 =?us-ascii?Q?iqUyu24vW/udIaExOPzpdMzq9DNfuCqiLuMrZ7N8gnM5WK0ZfSu1PX6l2/Qq?=
 =?us-ascii?Q?SP7vehys0HXTW7hp1mL09pDfuTNgO8nWuB6L+OHqrh471p5ebhMFGn2OXg3u?=
 =?us-ascii?Q?SEx8HKExH7zF76D4CXnOs/Hq4PWTovlGunfXyDSTT60J/FDSQIhP251I1u6m?=
 =?us-ascii?Q?WRIBvuiCJWcw3XHm3fEC3rmdItbjP5cLrjNKPqyFJ6OFpoAu02V9jvI83G5Z?=
 =?us-ascii?Q?9Lgai4fQFbvwfOJTHSe1zyvDbPswioz/wqHDXgUspps9UINSgUVxgHuPmX15?=
 =?us-ascii?Q?YStmUnmmG91iWbO4ek+BOEN4YkuwsKNLtB0f0LKQ9AwX4hDIAgLzxbuvEUFL?=
 =?us-ascii?Q?xgNI5ehSsaOO50e9cYK5dknKk/1BpiNilGoXzEW3t3CXR103apDYFnalJlCY?=
 =?us-ascii?Q?kvVIwmPNSLIrTCI13boRofaNu5v/zbDxFU68yRQMdh4xE3yZhFUt27TF88Wm?=
 =?us-ascii?Q?C1ET9ts0WLVXQGUqLi4LU33UNtYnYkn62i9+DQZPbSLcLtSyn0H8m/SGfbAj?=
 =?us-ascii?Q?XuW06QwNePkEQScFD11TF9TRpp6V4j78m0pz1cGSmvzYyF16tohXwSETMTA?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C/YZWTJEfkdvarFyUlHAgzhG8fuM7USJiJbEDfz5GBBTwJhy0rpdsNTFXs/E?=
 =?us-ascii?Q?wfniQx18zZUyWClsG4YKBSFAwt2oO8njiKzroJQyJcmTpgjcUVDCbcIdFsdR?=
 =?us-ascii?Q?O184Dijuap4vx86eZUQQhzx8RgFX9RJUDU0NfZ0yai5Xbk7elmVCFGFLxTX3?=
 =?us-ascii?Q?tqdmytTKXl712YBCqK/jRrNRb3YxiGM/53LB3J5BJbxAcqNQGy/VsnZaVpnV?=
 =?us-ascii?Q?OXEx/CJhTP556CTO2SmyGyMirQfNrLXPINaJp09z+GTPEcnop/GqpyjdP4Vu?=
 =?us-ascii?Q?9ublnb0UNSYRkjeZT6j/SbBP3un2YthDB5x8OfFSSbRGi7VgdURgkvL69TsQ?=
 =?us-ascii?Q?ZHpko2EDiboaEyD/iFK6nCWVResWlylTvd7djLIjQlOJvnAcPVce35cj7uiE?=
 =?us-ascii?Q?hf4ZU6JB3aWZofZl+d6gXEEMeOsO6LHwLd8Rkt9mOFsWMAVJSQVALPALQZcN?=
 =?us-ascii?Q?8uOOifF4iVPNHf4EU9OE3YA7SO7CLieVN4jy56rD8Rw8DsnbCqGP0TzKl3P7?=
 =?us-ascii?Q?O6n9OKKU5SonSxLvd38KDnY0nXzAq11epMAoQAhaHgXsdWuEDO/I7kjAlrfQ?=
 =?us-ascii?Q?397ycSfeP6XSEO2lvRxuIda2pMX9s60SgKpoJsk6bPgl3mB99ZljVC7/sWIQ?=
 =?us-ascii?Q?IiVXaldTBG6TUbfE0pLXeAeQy25kwjrH4J3/z2Qsb6ljkijzgd0PanjisU+D?=
 =?us-ascii?Q?hlQyzDaREX3YQGIUtJUhZTMcIu0DXWLSWO8RkVD6JyBAubjKnHVoA170kblu?=
 =?us-ascii?Q?L3FR19VkLrt/2vMAWB9ROjnXmA9hUIBJhNpXldjNeg22sw/8SpTDcymYln6S?=
 =?us-ascii?Q?g3kcQ4B7v6kqS3vEiniJdHV0WPMKSq0ru2Bcdw5tKBTJKfSGGvvvCoEblElD?=
 =?us-ascii?Q?TLxdZU1flVTfS7WwWIw50AjAfNPDI0jUtF4LjGtl9SAMlKX4i0oWG0LlwQPO?=
 =?us-ascii?Q?UTgjAXRXEDJQjqZuF0XaOwU1gHOnVZh+1f/x9QmGTzNuIwIaK0W/CfLYVf+8?=
 =?us-ascii?Q?MLWpPuZH0k56Bj3LsTWca6h6OGdw7SRb+QXRHsj00LlxK5eyds/68GSSvoGO?=
 =?us-ascii?Q?o1eHA6fnUXSYiC9actRgC1VATbJyFS2kO2iS7+7iNL4khguu8+75dvUwWsx/?=
 =?us-ascii?Q?p0uKc7J9fgkj0zoST59oT/HPcQcafxl2xXkKV+qQ4552Ci1uFbdVGaN3Ndye?=
 =?us-ascii?Q?RwxrnxngmCBxzhPrmSpITNRaV402m7dNB5g44ioHW4O9Jj0IIiPB5FQvOeKl?=
 =?us-ascii?Q?Szx+pcPkalTdzAn/ZGPrMvu11aVS1emJ5XXpim9VdO3j0M6pa0/Xxlkj+SsZ?=
 =?us-ascii?Q?P81VBnyXvsGoPov2fq1THjxynLRVUhyyrXbpmGbaQAIEB1JjOkEfiQPx1qJO?=
 =?us-ascii?Q?orjPmb8D0MNqNIdiSqDqcl4lKdK40xfmbQyWxhE/Ai5wMwAoVQaVEvgu/wbH?=
 =?us-ascii?Q?kS+BptUJf82+8jDRzYtO7cugWhhydPQK24JbxIuk4lvCK9dVWuKnaUM73jMQ?=
 =?us-ascii?Q?ClampkJ6q+XQftfVTKY0zDf3kP6SogUp8gl31Ko+sEUR9sf7Z6gRMdE8xE89?=
 =?us-ascii?Q?cTtO1/9iUzbFwB1AzNRRpROaCbwVUxVjWGBOcTip?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4acdd079-5fa8-42de-bbbc-08dce516ae27
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 08:21:15.4609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9A579uO8HcBty2V304z0a8Q69ybbr4cznMxa1uJ4UkOEXVQjEq9OS2s5MKkH2RsSQM3txVBNsbpt/5EHqgjAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6659
X-OriginatorOrg: intel.com

On Sat, Oct 05, 2024 at 12:56:19AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c02d24a5af66 Add linux-next specific files for 20241003
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1404ab9f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=94f9caf16c0af42d
> dashboard link: https://syzkaller.appspot.com/bug?extid=80b36e60457a005e0530
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f633d0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1204ab9f980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/641e642c9432/disk-c02d24a5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/98aaf20c29e0/vmlinux-c02d24a5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c23099f2d86b/bzImage-c02d24a5.xz
> 
> The issue was bisected to:
> 
> commit d0a38fad51cc70ab3dd3c59b54d8079ac19220b9
> Author: Feng Tang <feng.tang@intel.com>
> Date:   Wed Sep 11 06:45:34 2024 +0000
> 
>     mm/slub: Improve redzone check and zeroing for krealloc()

Thanks for the report!

Marco Elver also reported similar issue [1]. We agreed to revert the patch
and work on a new version, and Vlastimil did zapped the patchset from his
'for-next' branch. I just rechecked and seems the pachset also sits on
another branch 'for-6.13/fixes' of slab tree.

Vlastimil, pls help to zap it from that branch also, thanks!

[1]. https://lore.kernel.org/all/CANpmjNM5XjwwSc8WrDE9=FGmSScftYrbsvC+db+82GaMPiQqvQ@mail.gmail.com/

- Feng

