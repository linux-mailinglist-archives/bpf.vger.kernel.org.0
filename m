Return-Path: <bpf+bounces-56503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2D1A9946C
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 18:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815FA1BC1A34
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 16:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8654B28BA8E;
	Wed, 23 Apr 2025 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gpvB/gvf"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3220C28A3F9
	for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745424123; cv=fail; b=f2cLZV4RL5Wn3m5SqOaoy26U6le3/uCT4EfX+Y26gdK8XuTbK7rhKDTzRhpGkqKfsF76NR/JiETS9Up3TLuI2Imh26QYQHs6Oy2mJNKB3FZSH994HZPveuoM8FkSvJ5XNEtM552VQQ36jwP0pz5UevfxwTsVPbG8ACoXGW/BdYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745424123; c=relaxed/simple;
	bh=M7iJiMswMCNR/RZQyy8Aswv8WTpYvtAAxJIFuLtd/dM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ATHQPxHUObVKzR1pDPZgUiBpHjwarsuRh3KiBc5vLd0vGNDu1fIahTD6C2dYwfnhfxNFPrjutzNNAYI4spdzC4PcmlhNoh9Vhv30dNnkRsC87TCdGHyTl2cBUEH3iRZP8D5y7RQsFUu8U6irU40SQem4+BQZHcP5PDr00R32yLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gpvB/gvf; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745424121; x=1776960121;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=M7iJiMswMCNR/RZQyy8Aswv8WTpYvtAAxJIFuLtd/dM=;
  b=gpvB/gvfSP+MV6EqMxt6/wnZX58WVxai4Sld2ntnw5U19NyL2ZF8hUOO
   EnX0xnVYDBDQFnu9+AYh0qeyP3Zsb+NMaSNryA6twp2OKd3PIj1WBVMtX
   rjd8n4AZfRrWt6zpfg/MVaWbxqFK8RDuV+tmtQHcCWCqFkB1h8JiL1zFF
   lWu0sxL72fa9KLMP8kT9Nt9DVyTNyg7V42jIW402Y2nHMrMNyz0cLTFje
   6Y4KJPv/CahYvkV/KTh7M93gj90ESR+1cIOcAp91Z2E35jHQF4NBBjgRu
   37kHniK+szcFu5fclkvApKdsT/aqsKrKZo7+1Ak9X4uWzTdDmT62og/Z8
   Q==;
X-CSE-ConnectionGUID: bzK1e4DgT+6Mg2tvToiuOQ==
X-CSE-MsgGUID: UlsCS+SuRUCTqETFsQjOlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="46935232"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46935232"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 09:01:48 -0700
X-CSE-ConnectionGUID: EURhNGKBR72uWSl0/8QVIA==
X-CSE-MsgGUID: xRaUaIIMQs+LBWgUU94NHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="136428933"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 09:01:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 09:01:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 09:01:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 09:01:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvQy16vkFcxIznsL8JsTrNGYfmwPvF4dZYaMQYZsRI9mF27j9CXxvxdHOzW8f6YVGU8zbtgak/z9s7PIG1jEtSgx2DfRABOAlxHrOdpQa1ZWCxP2VzrGecQfHRFQQ+Owfx+RRpaxzGSprm8wIk0pukPy589mlgDG0P54Uf/DeSsTyBfjB0vKEWI3RPY/cutHRxPgHrgKaahd2bCZpU7atu+WTS7kB0smp5o+nOVdYzFvRKX7oKGXZ2ZnrUccKYFomA9Ly4NfFZG67oGKWHByF/Qnks6Z+GHSYmLATbosWStX4Urp4YfswstVF91XH78cqlow1VRNjAn5GpaPFSf/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcdQJMtqXsKuqlWL0s34bzdn+DAs/MAmp+dkb/BvOq8=;
 b=JKYBgcV+dMme99X3U4lOzhK/d4nRyXlcXu9LyMkiios3LbDKgwbp/iVvCOZOgvm4QVnde4JweBsrCT77r/0PW22XsROxV/2sFtOPDd0q8sRF8ae9NyKIKSj7kvsp3Sc4nuuReWmMTemzFq3hfnRXIayZpcLcon82ZOuRe7lwcACafcdGASf4nvxQw4r4jMuCXlLCID72ndVG6NIP8bV85KFcz6hQ2jnCeFUvvUyKte86ZLml1b4UMnhKtU4EEEvpq0/JrK6a1Qkj0bu4XRbGVQ6Exc8m6vf/P5IVWHKMUl/hV74lAZ9Wt8E1rks2dgmE5/J/hScvW6T4ZlsrgzL8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB7050.namprd11.prod.outlook.com (2603:10b6:510:20d::15)
 by IA1PR11MB7811.namprd11.prod.outlook.com (2603:10b6:208:3f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Wed, 23 Apr
 2025 16:01:43 +0000
Received: from PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582]) by PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582%7]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 16:01:43 +0000
Date: Wed, 23 Apr 2025 12:01:40 -0400
From: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
To: <bpf@vger.kernel.org>
CC: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
Subject: [PATCH bpf 2/2] selftests/bpf: add test for softlock when modifying
 hashmap while iterating
Message-ID: <20250423160116.120118-3-brandon.kammerdiener@intel.com>
X-Mailer: git-send-email 2.49.0
References: <20250423160116.120118-1-brandon.kammerdiener@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250423160116.120118-1-brandon.kammerdiener@intel.com>
X-ClientProxiedBy: SJ0PR13CA0080.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::25) To PH7PR11MB7050.namprd11.prod.outlook.com
 (2603:10b6:510:20d::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7050:EE_|IA1PR11MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 8245260b-5f38-41d5-8cf2-08dd82802424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cfnhfybbVhYfcqIc5c6JA001OSggrsO6wNzTL6JmSvrvmZEez8TbinZTlRsP?=
 =?us-ascii?Q?o4rS+YBerPHxjcQyH73ixXqwjYYtHr3zBR4+2R5Xzi0aZ8G+3lM1q/ECFxjo?=
 =?us-ascii?Q?hjPwyyUnp0nW4bgFPnU+6HW0/B9rS8Nph5bh+xnVJszDNCes6HUzxTK+iS5B?=
 =?us-ascii?Q?wCx1GLeBYxf+mmgBpiw/++yv5Jq+XqHuQDDxLm1u1DQEFgYE/J88gKvXhOc6?=
 =?us-ascii?Q?Urx8JvmsD//MSQ7DkhkItonS6s9PDIJwMYZVvX3oP2G8cEprY/mQHRHM4CJb?=
 =?us-ascii?Q?r6IRTylkrEf/dUW8j6mniwrMxm3oUXaMMmA99Ef3g3BaSB7aYevvAfBXawfT?=
 =?us-ascii?Q?8zwTz0BwQytnTOXxc8Zgr+5f+qbCUCMfvXspFnmf6ZtVrGLi7m+sXC6M24K2?=
 =?us-ascii?Q?c3Pm5mP69/eftRNjw2WhoLJUEBc0wPmSRSLi7dofj6CTAxyafIxOETeJoDG0?=
 =?us-ascii?Q?SKBGh1L2CQ6/fp9QqPoPOGOc3q+9VBb1yonTnJB6Lq4AEUXk0kCdVqIxL29w?=
 =?us-ascii?Q?4ICcTldRkoOXmjAewwyo6UDQhiiAl4kLoWfzxYhnk4KqR2dUSWSErYfjcGB4?=
 =?us-ascii?Q?KA0rdaaEeXjmFHcVNHFh1S6GYKgXoIZ+PIWtbF4DdtLpigHAt62L+ekU0XzB?=
 =?us-ascii?Q?YCMSA2A3Ri780PiXJZdIaZdXMhms0vCdzzOMQKIU/6DbM5ex1t9MIiASEplr?=
 =?us-ascii?Q?CcNPHuziT8vM0GmSb2FytniPyGg0Ds0CEtLgkKGIk04c4m1cSe0fUEIEDVEO?=
 =?us-ascii?Q?tydc1GYfVCE/JJKW2WkZBRhIJQL71pT83lxwN9MT+r8QD1QPYYivjrijhiK5?=
 =?us-ascii?Q?tuomU7mUf+yH8d3Vkby4zASkngb3k/U9+rKqXp9Y9vEois7513kLim2vEdeb?=
 =?us-ascii?Q?4vbuBzKqe1TmRwlfrCjZB0HGCFnTxKwj+wZ7Pr6SS1CnoWa776gsIGfHP2ok?=
 =?us-ascii?Q?xSaeIdumDrp13ajhoQZ3o3/6GexB3zEWYYWNPHDpbX5ChkSqq6VhZjEaTn+W?=
 =?us-ascii?Q?ilMiRNG7At60irAvCLYzQKhgrOQTSCtbtpEEDQVOKbcB93059vf/I/r4AIid?=
 =?us-ascii?Q?aRLKm9+gJxPmznrMGv8d2SGrvHcPMYMffRhtkdKbOc3EKkb+yns5A0pjcgdW?=
 =?us-ascii?Q?q5Ol9y1KsTgacTKiq663mk4IitdSNHKGTAeujzF8SVitFizLPBJu/gThEE+a?=
 =?us-ascii?Q?MiC4RKJ4Qf+H914hH7Z3NuhAgfOwbRm9K0K8a6KRldgXoB+xlLiuYjEdLObh?=
 =?us-ascii?Q?BuuvEkEjIzwW+7TVP+c82L9cZTwzciw8xErDPLLh8h0cMJK1Sz+iQhOu622Q?=
 =?us-ascii?Q?OK1vMkCuZqR9lb9JpZgNUyWhsAE+XWXU1va5O8FdQr9bIKsKD1JkZubn8gnb?=
 =?us-ascii?Q?P+ObBwOmc+OR674ZMjZY+sJY1xfxhAi3DiSdDBuqf46HVGovRte1ANeCby9J?=
 =?us-ascii?Q?akbv6Sad4CI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D4pX/RtPkPwHhMfyXZaVwL1sa9buIaVX1H6ioTvMFQtlsKXXVbhOrLR+8wIu?=
 =?us-ascii?Q?jbum11+bHl7JRLvwKm16K6q9rg9Jw5Yrwhr+vvsVnmlOAMAt2Jz5EEHP8X82?=
 =?us-ascii?Q?GxCkgOv7E6TTceZHKX9Bv0M+84AdctJhWg/VXjq1XhkW7sn/rXiLtVFqf6CJ?=
 =?us-ascii?Q?yf1HX/isFgyWpNlTAAasgHK2JOk60OhtfLpOD64UiX9efZK1ewJs61JpQYws?=
 =?us-ascii?Q?EF56imOe50jrUgzCW52kRt5coVd2DZgB8KJ+Pzsn2AdmHz8HVTblFqrUQt7u?=
 =?us-ascii?Q?11ldDF/G62dGcn88TpWXjNmqUrLNrYShAKw1D12vdlT3xS9xfz9cNYBThcGU?=
 =?us-ascii?Q?ZYhHBpsYb9UOBfFCZ+t56IRPdt1pwqWG/T5ko5L3vj39R9aNXkMfuzOJ67EW?=
 =?us-ascii?Q?7TdHhzrHuWf5Ot2nohyDg4fGTSdQ+2pmoxUW6oph1nUR+7Yig+zZgjnsu7hU?=
 =?us-ascii?Q?vqmkIthiJQ+o0iY5NbuZDlYYBYVaFTC+vKSjiMcGBGqWp9YPIZzuTzf2FD2r?=
 =?us-ascii?Q?zimHHRuc8gd1atJQrK0yPDamphsbwcuNBNZeQvmPcGsdq0ajh1Nkh5LpEwed?=
 =?us-ascii?Q?eNJ/hglVW0is/tOfoSURh86eP7WsBskZNKTPVKQNRt8zRUsizFqGDqcQAJb6?=
 =?us-ascii?Q?ntC7hZRKT1iSyzi+PNoht/xxnehzPANEnCc187WhQPiuaeZsB9uY/znk3u8A?=
 =?us-ascii?Q?tFtHPGAIUcR8hjslolvT8FQwgCZAEt+bOGLeTgXtUSMMGXMTcuAuZzgGS83f?=
 =?us-ascii?Q?cnzyqj89M4VhKdeYLm+0QYbBzSoQah0KAKYPE/8xuC+uoaEBV8AaVKZlKGEz?=
 =?us-ascii?Q?rNw2h6QE1oxUVTwGx3KF4FnmfHZugl5W/VOzdINySrpwzO+lTfI+eKbkYwyN?=
 =?us-ascii?Q?d8X1h2W35MHmY4DEEfvICeA84hlFCdmttImXD+wqodmLzJ0ykvf4TV8fjby0?=
 =?us-ascii?Q?OSaDtMa5wEdUxbHrnO5498gu+s9/VxPOSqQ2hmCkanqZZz7Zc0II7udOinwD?=
 =?us-ascii?Q?Ok2c3kdy9xOjnfhoxmkTZOgY2Tvu+05T6FQ0hSe6IjCePlOdLNXp01owa/Pg?=
 =?us-ascii?Q?RVF6ZhnySexo3zdkoJAvAr3M67aD/CKPFWQG3L46jrAkVDstYOJqF33m8LV3?=
 =?us-ascii?Q?V9QdNj6Ve4ep7uVyNNZ1Cw/DjgtQSLEApZjy5svpsz4AQL8J4Qqx51iEmK8x?=
 =?us-ascii?Q?w/E8Gu4+TInw0HOtNBGFcLpMCZuQrAIqKwA6w1hSkrSH1aQCp39LcY/zFJQw?=
 =?us-ascii?Q?xOYt1R0lh8o0xx1BvsqkW+VZp6ow9V7YZK5RMuDDBpR7ci5WlrEjQpZC0L25?=
 =?us-ascii?Q?XcFJVRFpquphBHAQPTD04RjaZlcSoKt24uQhR/jQ02LCuDq96rTfjzuC3p4x?=
 =?us-ascii?Q?sefxWsWO7hJdKekxRNaCiaUcErxpKIBLnBpZ7z4SvuHSY8X8Tj7xAWAH4YqO?=
 =?us-ascii?Q?UT4lNT9xXk3ftZiGqzFYpuF5bSAXYnqm6MbF0dvkLvFLNudTPEWgUtHrElj8?=
 =?us-ascii?Q?csZJt91h4t4UK1McPKXYW3GYP1NUT9Q5CV7csE72TzSPnuKPBb0ZH2QZw0x9?=
 =?us-ascii?Q?+G6ugDvWl68sTgP1wq6bn5BUJUxgFkjGpTBhYzYLntCo9uE047fEb8rWrjlM?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8245260b-5f38-41d5-8cf2-08dd82802424
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 16:01:43.2859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZM9X27hk6Fj2vQvEHUUaI8SpQ6NQYJCCEjrhFiHg1/NZ7zwC9x/5r7JJ+Ia6EHU6bou0HLCZwof+dChyj5IKAzFMI5H1lc64YUwf66Kd9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7811
X-OriginatorOrg: intel.com

Add test that modifies the map while it's being iterated in such a way that
hangs the kernel thread unless the _safe fix is applied to
bpf_for_each_hash_elem.

---
 .../selftests/bpf/prog_tests/for_each.c       | 37 +++++++++++++++++++
 .../bpf/progs/for_each_hash_modify.c          | 30 +++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/for_each_hash_modify.c

diff --git a/tools/testing/selftests/bpf/prog_tests/for_each.c b/tools/testing/selftests/bpf/prog_tests/for_each.c
index 09f6487f58b9..f4092464d75e 100644
--- a/tools/testing/selftests/bpf/prog_tests/for_each.c
+++ b/tools/testing/selftests/bpf/prog_tests/for_each.c
@@ -6,6 +6,7 @@
 #include "for_each_array_map_elem.skel.h"
 #include "for_each_map_elem_write_key.skel.h"
 #include "for_each_multi_maps.skel.h"
+#include "for_each_hash_modify.skel.h"

 static unsigned int duration;

@@ -203,6 +204,40 @@ static void test_multi_maps(void)
 	for_each_multi_maps__destroy(skel);
 }

+static void test_for_each_hash_modify(void)
+{
+	struct for_each_hash_modify *skel;
+	int max_entries, i, err;
+	__u64 key, val;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1
+	);
+
+	skel = for_each_hash_modify__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "for_each_hash_modify__open_and_load"))
+		return;
+
+	max_entries = bpf_map__max_entries(skel->maps.hashmap);
+	for (i = 0; i < max_entries; i++) {
+		key = i;
+		val = i;
+		err = bpf_map__update_elem(skel->maps.hashmap, &key, sizeof(key),
+					   &val, sizeof(val), BPF_ANY);
+		if (!ASSERT_OK(err, "map_update"))
+			goto out;
+	}
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_pkt_access), &topts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+	duration = topts.duration;
+
+out:
+	for_each_hash_modify__destroy(skel);
+}
+
 void test_for_each(void)
 {
 	if (test__start_subtest("hash_map"))
@@ -213,4 +248,6 @@ void test_for_each(void)
 		test_write_map_key();
 	if (test__start_subtest("multi_maps"))
 		test_multi_maps();
+	if (test__start_subtest("for_each_hash_modify"))
+		test_for_each_hash_modify();
 }
diff --git a/tools/testing/selftests/bpf/progs/for_each_hash_modify.c b/tools/testing/selftests/bpf/progs/for_each_hash_modify.c
new file mode 100644
index 000000000000..82307166f789
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/for_each_hash_modify.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Intel Corporation */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 128);
+	__type(key, __u64);
+	__type(value, __u64);
+} hashmap SEC(".maps");
+
+static int cb(struct bpf_map *map, __u64 *key, __u64 *val, void *arg)
+{
+	bpf_map_delete_elem(map, key);
+	bpf_map_update_elem(map, key, val, 0);
+	return 0;
+}
+
+SEC("tc")
+int test_pkt_access(struct __sk_buff *skb)
+{
+	(void)skb;
+
+	bpf_for_each_map_elem(&hashmap, cb, NULL, 0);
+
+	return 0;
+}
--
2.49.0

