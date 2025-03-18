Return-Path: <bpf+bounces-54325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E55A67715
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 16:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30D516B29D
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 14:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DB420E6EC;
	Tue, 18 Mar 2025 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NnNYG40R"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E211D1C5F32;
	Tue, 18 Mar 2025 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309898; cv=fail; b=J7x0Z+ji2PftXaTrz6RD00SZp7jt+BfKGwU98bR5fc+fl+IwvOKeoXDjAqBjOopWUxSVe4bIYiEaReLN+fP2HiC/oe8WpLpUyJf4iNkHMGUZjVC1aUmEbVr7cnZzd+tzM9+siJ7hRijn1lr1MgRGuEEX4DDQGIg87uHYXeR0yco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309898; c=relaxed/simple;
	bh=rIZeVbx50zEL1f7bJZCSJ7lf9joHhgYAFpUs9zhaaA4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PnXnCbTQiaJDW+bTVHwez1cvwEHw/UPhhhHb+I5EYNiekFQ3VP/EXfTSplgHCHo45zMhWdJJ8PWYmXgPj2Kzrg3PnwerCJcgzN9uXEUcH7H06S//vHKSrdQODlJfdrCJOyPBD1R9ufVjRlQ1srQ4hDwesgbbj94hEiKBgFZro54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NnNYG40R; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742309897; x=1773845897;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rIZeVbx50zEL1f7bJZCSJ7lf9joHhgYAFpUs9zhaaA4=;
  b=NnNYG40RxuOwTjyZHbn67+B+TzPZ8/UTS7/lZACk4lELKlHmaln+QTQz
   waJ2MxlC8Q/k/LWb/e9rkkIq3cpo7QaV16xM6Wyoa6jB5qRfPcvBiumuC
   DZ4gRf/GRxe8yu3e1b1PjZ0HkfkoR2TmG1w2sMEpu4KaK+L0KilhkCu12
   oV72Gira6dUONvhOg0HBCAu79iuGRwdJGKIJcL9t6pK2pX3mpM9p3Eexb
   6rS5s69d0K0lcMCYQzPxfgNHDLgj9SZVAlBsphc3GwUYm2yxE5RL/VcDy
   AbQ0PAFfPNNQH9LIbaTp3YTl5fxaBKXr2A2SIEjbvmmPBCJsKo4EjXTSh
   w==;
X-CSE-ConnectionGUID: eVUkuOHQRYmIgam+U67QKg==
X-CSE-MsgGUID: RGZ+BdI9SzaJTNGXk68uew==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="47233024"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="47233024"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 07:58:16 -0700
X-CSE-ConnectionGUID: SiyAF3RIRJq7temDXYrthw==
X-CSE-MsgGUID: xIBgX8evQuGOv0EuIXspQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="153131721"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 07:58:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 07:58:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 07:58:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 07:58:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2pFL8Kh9/4hEu083js/TlB6mrbMbWKAShqjzGkTdx7i1G8cVxl0Xfh7HUuOJHfBUlV/kUZ9iKepzXW6S8UEgFkvZBaHUhWpcpsoA4Fut6J0YlR9cB19EEW5n2ACRdFl21F3Oi9WMhAr6PKD1J8Fitm+xx3RTsC5iOwpVuuIsH17GoJHAxymtPLkgOzMjm8c16F1FH7iKm1pV6CHWeOYYzmYtd90mD6cEaT2JSv62cA31jKYNLXlgp0ZlBXbcm6gkV/euZ9rP/C6FGupGxQKcHF6zDecIivbQKdHbOjOCqDtn8CdeIXAf5RWPObdWfb81RtJpUVmDcUMy9F1kqqikQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBZFZdTqeATVZE+rxasCwU1XES31ZzHT66gO091Fjrg=;
 b=s4t4Sb29/VTIGiod9ConOHD8wCp0CadJLhg08m4m1IF/M7dmx8dmDWf9vLhLDTJ3EbBVby1uW07eRVR7aHqS/qXbbfEVs9+G5uW+Mc8jylKdKXPfptxbMoLTLTOQhMkJAsw5uc6DeXl7JIijOV59KxE3TUZLWhN4W5cWsV//OU3lgqn3qA+46w8uCjDnrHllrB2zV+bW/8D7Wha2z/DLg5XxDiM6kVA8cSRzPx8f04pf2Ye5Y/32Q218YthA5tw/KcRuMHlKFc5IjOl7H/gozL/rvhD+QeK/h5UvFpiir9Ay3daYsKvstnPSgNLuz227nj/9JVXnN+Fo0Jndk4CC2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB8327.namprd11.prod.outlook.com (2603:10b6:806:378::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 14:58:12 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 14:58:11 +0000
Date: Tue, 18 Mar 2025 15:58:05 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: "Vyavahare, Tushar" <tushar.vyavahare@intel.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/xsk: Add tail adjustment tests
 and support check
Message-ID: <Z9mJ/QSbTfa0IW4Z@boxer>
References: <20250305141813.286906-1-tushar.vyavahare@intel.com>
 <20250305141813.286906-3-tushar.vyavahare@intel.com>
 <Z9C0/2uFFQPGozkr@boxer>
 <IA1PR11MB6514B98679051D03FDDED9C78FDE2@IA1PR11MB6514.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA1PR11MB6514B98679051D03FDDED9C78FDE2@IA1PR11MB6514.namprd11.prod.outlook.com>
X-ClientProxiedBy: ZR2P278CA0042.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::13) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b9c8443-2ead-40bb-f2e8-08dd662d4d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OiFWX9dFt8HpQRcsrn/grHuw8c0yD7TnHRIpnYnQk4gy/Orve1AnnHNbkQHR?=
 =?us-ascii?Q?9VYJul6gyalEUL3rQ5QHIUn0L+JVFVnSypLzErwDM9j9VMveHZvOewtgrqZl?=
 =?us-ascii?Q?+wM7dwOXgUe16A8tlZ7PeBwfTGpIuzTbX9HxtRP7G8R9wv1zP5Jesj+mpkDR?=
 =?us-ascii?Q?H55+fkeygFopHmZ238y8O+HO04IIFVm7n04B4PODV6yUi4Ih7aUBWsbH7Zv7?=
 =?us-ascii?Q?cjXzAhV57qyHXm+q/9vVGMQHoc4gOB+MBU2hsFWFz7x99NkvEVq7c3a8yC6H?=
 =?us-ascii?Q?Nr+xheMFlR2FXICQzhELVgMe1R8dkonpwzyDtUnC6XFyl+8mXXg2RRfBQlm6?=
 =?us-ascii?Q?y9iIwkugxg34XvIURWeVTLe6SJgj/0jELwEOqjHMjV8PMHVBPzrI0yvOUXhk?=
 =?us-ascii?Q?qG4kNCf/CJnoerLkU3bX0mrLCUfvcdSGtHfFcQLlye4g7luygiSGn919f0UC?=
 =?us-ascii?Q?35n1eaRaSETjH+gWmudK43wgDGq3iRUDhUoBId92s9HfKrPgy9eqbOEmNFG7?=
 =?us-ascii?Q?i/SCTIV0MeykOHcuaEUU9j/Jv/ew9JU5hHQhV3X13OmRfCV6N/HMX+ehR5/H?=
 =?us-ascii?Q?JsB9gmNnWafZbcYqLbO3nlOBf9bs29J9LUA6DyPeZ2YCLfkTMCaUpIueN1vY?=
 =?us-ascii?Q?iGS+61Wf58KN2ZoYV5Z1gapOzN5TvH1qEPcyCSzsuXJpM/peTA4vtoxTbEIi?=
 =?us-ascii?Q?WBg88zHMFDrK/bc696fVEFf0GIW7y0fDy/EoQNRS+6vKUxSIcdeW/RcundbS?=
 =?us-ascii?Q?FZIwyKd5DBA/fqe3eXxK7nCsHL8g35U7nTJJwWuE9MssZxrwH59SXT9IEnZN?=
 =?us-ascii?Q?6S1JcMAWOk65HO/IKQGAC/HERXN7Pp8VCVs7wRjbJiKis4PhSpGb8Ltg7MrI?=
 =?us-ascii?Q?JpNbOcnPIBTSd8sX+LKoQQlLmJYpL7l5JhXIO+67dqz3MBr8qDpmBBppk2Qk?=
 =?us-ascii?Q?Zz4JkGlYiHw9ei9eQzMRbzfGWGokHIZD7SFu7Ii9/2+ivd2Vdis6+iMnLgoH?=
 =?us-ascii?Q?Bm2+UO7a2/oRNmltpV3lTlWsxwLA8EZXYPXgtPfcc1+A8thROA1EkIQLXg5F?=
 =?us-ascii?Q?9PQ7Mo9Jd+DAilZBUN3Jo+e3Nb0OVn5/51aqKwxYQaSEOqK9z0CJtfuvB8CZ?=
 =?us-ascii?Q?mKmOFgvkGssqipFV01dTjDvGeIWWoZWQKVqLsyUU9xfN0v29h3+5EfFXzb09?=
 =?us-ascii?Q?ur2B62OaL5mWZVAZ7AqKJNLwERPzBJdYP/XAs7NUa1X3JmRdR9Hm56sB+6sk?=
 =?us-ascii?Q?E00rV+xlIrpMa+LEbzboZCZQKxvZGn8hT+6FXRAWqEUGBPlsFVANVw91XbzJ?=
 =?us-ascii?Q?MbBij6q7blXh4i6SV3uCsB4ro4K9O0yqJA1afUfWPeKcPjpo3NbTipcrANvX?=
 =?us-ascii?Q?nI/NO+9SuIojiNUtooD4ifILdGz1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OEiumz2GB9rulN0A+LacZ517r4Cvg88NfJuFeSIqaKX2Y2UX3CeJpTz6aN8r?=
 =?us-ascii?Q?nDW+xiLbWMFOSh+RC4txXhm9NclKHLWrMwvZ//Wk6+qF0GE4T1zCyLCrAple?=
 =?us-ascii?Q?ZTdOgR/BqwUF27uzbpFV+omlSLkgkJXBaGxq8k5r8jWhTbGp83urZOeof4rR?=
 =?us-ascii?Q?iiO6r1Q5M0JO+/5jaVq9MR9aFAtgLQ0iv0Xo51exEQrOkf0dJhcFKpbeQo8e?=
 =?us-ascii?Q?m65HiRfNU+LE6h9tKWdEGHyB546WUrjM///tnqvmNAVh4AcH1gO9fQzlT6tt?=
 =?us-ascii?Q?yM5+y1+CO6/QuuHcYZ3w1TZcB7eAfc5GAvLkwjQVB4rUvTbeEQpp5i0bufhb?=
 =?us-ascii?Q?FVqDF53WyVzqIvQHZlkmaXNJyfP+jn7nfpUswnFysMrtP2RucKNXEdsosY/V?=
 =?us-ascii?Q?4WQs4Tvzo3BWA/xmAOv7ifIlL2OopAfueY9ibhHaHrtX5NYP0C6EQzH++GCa?=
 =?us-ascii?Q?c0qbKsSBKw2BGCTMlyuJUtA4rg8vMoHKFJUw9C1NaZkFBtgOqb0oPAGOeQm+?=
 =?us-ascii?Q?bMOGy9TqB7uUJCjLgaJ1daTa5PWPbkL6O6WqB7p56rxvxeyZ5Bd3ItOwfKOx?=
 =?us-ascii?Q?saO6fPSkz55N1ij6DkVbJxM6wPdsLhXftYdrk8+NIRsdsbPt1MfYayE9JB9l?=
 =?us-ascii?Q?s3WeQbkSdPqVzHNB+I0To2/jTihmSf4TR6LPmkXxWYUVF2/Tpoxu5q9L0FvQ?=
 =?us-ascii?Q?hDSxwimjnDwwm2sZxWDCQKX2UE/D/365OXKnzq8HX9xknIjL4C6gFptgjUTA?=
 =?us-ascii?Q?cbzlUh49T2pPafzw2lMGSKQFtSZbhgV3jnXkZeFvkUFRUprmP6LYzR3s4Pmg?=
 =?us-ascii?Q?YI8L2t+/WPzcmDelk9iGLFRWJvhaWHM+r8gktIJqaEAIEkXT8Her83+M1G2B?=
 =?us-ascii?Q?Bf96eMF+Blzctr48Hvr/FSojvyPxjlvyxewp1M3dJyJ9T+HpgfieU22X3kZH?=
 =?us-ascii?Q?v+PaxIDtvSqOG9XsxcSkGiEJ7McCNtkpNtVYHwlk2+boVFRUQEbGWoac+gFw?=
 =?us-ascii?Q?qMXGdhoWDs+RF7FC8u0L0rV8w33wOqh1t7aA8Rvht7MmevTrenduIosPOQB4?=
 =?us-ascii?Q?ANFJNbsOaZYhT3tTbz3Bvj9XckiC4zZ6qKyNli8Gr+DSvfW+WeYXMZZmqp1l?=
 =?us-ascii?Q?S0ZTO0d0DHOaOpMDZ8HMdCugEPUyC+ccYb2OTTP2FfLKR/Ij11CInbD7VhZh?=
 =?us-ascii?Q?t3AuD1Hlnfi1Ua1O0RdmSl2+ECyWEHyNaOmhhnTQFyPVAz0TEJDVTj85Xtf9?=
 =?us-ascii?Q?vLPduwCDEut9hVzTmYqXuLHGp+D4LEuE1kHa61dH7mVekqcWnovlgwuhcE5O?=
 =?us-ascii?Q?KlpxkJCKAiXzFfZZhlK0Ligfyw7Sq5ldg9efxEUC1QB31INxKsgzfusAmYJl?=
 =?us-ascii?Q?Q9t/e4ouQHcMe8u+aDF5j/N+HCgYIeMlARVEE1SXi3YpCyV70fSXRT2bijTp?=
 =?us-ascii?Q?GXUSLMbr5EBOfLjAQTu/7l6xRhIZxsIXI/z6eblOWSoEtydZTkh94+gCb5Rn?=
 =?us-ascii?Q?aDM0gs65tqcRrn6Xer+i7Z3SNPHnVP32BpYbpcAqln6Au9Ct1e5OcMdzAzCa?=
 =?us-ascii?Q?xzPyzbn9R4lwwJsigPn+GkgK08r7iLRigK9hTOiKJYkpsx7rnNVlNYQOD8eA?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9c8443-2ead-40bb-f2e8-08dd662d4d85
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 14:58:11.8264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FEpwCeGEg1+h7JGI4v278xYiebVUVbKBMwxSAgo6P2NfU69wXkriGFZBByS9/gimveHpkI3MffjS0+PJFZad9qnm0uPUUTIiBEvePWFajFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8327
X-OriginatorOrg: intel.com

On Tue, Mar 18, 2025 at 10:22:55AM +0100, Vyavahare, Tushar wrote:
> 
> 
> > -----Original Message-----
> > From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> > Sent: Wednesday, March 12, 2025 3:41 AM
> > To: Vyavahare, Tushar <tushar.vyavahare@intel.com>
> > Cc: bpf@vger.kernel.org; netdev@vger.kernel.org; bjorn@kernel.org; Karlsson,
> > Magnus <magnus.karlsson@intel.com>; jonathan.lemon@gmail.com;
> > davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com;
> > ast@kernel.org; daniel@iogearbox.net; Sarkar, Tirthendu
> > <tirthendu.sarkar@intel.com>
> > Subject: Re: [PATCH bpf-next v3 2/2] selftests/xsk: Add tail adjustment tests
> > and support check
> > 
> > On Wed, Mar 05, 2025 at 02:18:13PM +0000, Tushar Vyavahare wrote:
> > > Introduce tail adjustment functionality in xskxceiver using
> > > bpf_xdp_adjust_tail(). Add `xsk_xdp_adjust_tail` to modify packet
> > > sizes and drop unmodified packets. Implement
> > > `is_adjust_tail_supported` to check helper availability. Develop
> > > packet resizing tests, including shrinking and growing scenarios, with
> > > functions for both single-buffer and multi-buffer cases. Update the
> > > test framework to handle various scenarios and adjust MTU settings.
> > > These changes enhance the testing of packet tail adjustments, improving
> > AF_XDP framework reliability.
> > >
> > > Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> > > ---
> > >  .../selftests/bpf/progs/xsk_xdp_progs.c       |  49 ++++++++
> > >  tools/testing/selftests/bpf/xsk_xdp_common.h  |   1 +
> > >  tools/testing/selftests/bpf/xskxceiver.c      | 107 +++++++++++++++++-
> > >  tools/testing/selftests/bpf/xskxceiver.h      |   2 +
> > >  4 files changed, 157 insertions(+), 2 deletions(-)
> > >
> > > +	return testapp_adjust_tail(test, adjust_value, len); }
> > > +
> > > +static int testapp_adjust_tail_shrink(struct test_spec *test) {
> > > +	return testapp_adjust_tail_common(test, -4, MIN_PKT_SIZE, false); }
> > > +
> > > +static int testapp_adjust_tail_shrink_mb(struct test_spec *test) {
> > > +	return testapp_adjust_tail_common(test, -4,
> > > +XSK_RING_PROD__DEFAULT_NUM_DESCS * 3, true);
> > 
> > Am I reading this right that you are modifying the size by just 4 bytes?
> > The bugs that drivers had were for cases when packets got modified by value
> > bigger than frag size which caused for example underlying page being freed.
> > 
> > If that is the case tests do nothing valuable from my perspective.
> > 
> 
> In the v4 patchset, I have updated the code to modify the packet size by
> 1024 bytes instead of just 4 bytes.

Why this value?

> I will send v4.

