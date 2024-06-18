Return-Path: <bpf+bounces-32366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FDE90C1AE
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 04:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B24A6B211E1
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 02:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3F917BD3;
	Tue, 18 Jun 2024 02:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VjO+EVXi"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE7A291E
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 02:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718676125; cv=fail; b=qS1YVmJ/GOmOJ77+qERY4eYLes+BKH0O25pxeQ8kokLTn0v/OCLDm9SJkNa26FVBc8Ye1gWFjjDweG/Am4eV/Ddzddqpgg0Fx9/SFuZg7c6x0Ml7tUT3+VDRAIYU2/PSU/r6cCBsp/8l7TTViSAJg4qE6Jtowsidc2++Ed9fuTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718676125; c=relaxed/simple;
	bh=cK5p8fbvI2mYi2VjbFUHRn9UHPs+AX7fwuW5NwCYdNw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VRloae1yCfL96h+7trPuHxU2Eo51sGyz5EAbYDH+Nji5TyiYLyEMyYUDwNmw+lK55L6GBdOpSQWwzMMXJVFObQJ4tZ0DjNwKbm2OTEPgBkQCdTs1wT1Z0wj4KSZFY7p+hanckrLofL01F0vJ9zLS62sNEAuRUzXeLmKH0J9d768=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VjO+EVXi; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718676123; x=1750212123;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cK5p8fbvI2mYi2VjbFUHRn9UHPs+AX7fwuW5NwCYdNw=;
  b=VjO+EVXiKfSyTB9Z6bWpj9q9sGFWwhfFLUwCo8VeGvklr8GoEngzCq6o
   AjuNq0o5qzKyaktdLsi4ZJb1WiqYli/LZeXjs7hm0MGTenN3yo5CW47Ub
   pCZMph+4JCuDh2v295xDNMj/D5SO9W8+2TSw37RQ3UaTDMTmvq8MUq5z7
   qOqG1mDzfF91jZwMTfm5KGt4GxxwjD53HExrIIAYHyW3xIAcjRMI8xkrp
   IRcYZLdbLOBYcEvwx2I7tnZvuBhh0gwVoRZ+oTxLHY7QZ8lMK/LN/uX/+
   hEsMeX0AteYIMVzJ15N7UgVhjkjxZtbQCXgICyY5wFuJNJwx2Ef9Ly094
   g==;
X-CSE-ConnectionGUID: zf0aGYHOQkq7hccMMblbAw==
X-CSE-MsgGUID: 5Ahz6kdhSwiL0wah/aO4tQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="26212147"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="26212147"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 19:02:03 -0700
X-CSE-ConnectionGUID: ZkAs9kNhTBWMTELEOZy7sw==
X-CSE-MsgGUID: oGxh8M35SzWG2Ib/GeFf8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="41858392"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jun 2024 19:02:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 19:02:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 17 Jun 2024 19:02:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 19:02:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cB00mQFHkbZIxRs5RKnpY876bQRLXW9/EsT2wOhkpXRTi2K5aZZjs4P+6VfSU/UkZyexcSzJ7Ql8TMp3cfp6nx0sbHo3KJGFGRzAlTYgX0G7S95xo+Xx14gNaCxFWJ6mN4EyVhVo2Sl3UmePRq+6dHq1U56gpkNorsSI7RSbRCVWyBw6i9TOa43RzhYA9XpBhy9Mbq73drq9yOD6XClDdOwwroOLzq2rQSc7LwaIERbjcgZ/JGl2qdyigHHNIYPWKNc3cesuE9PBkrC61aAoTBMzjlA17TLyTjcjDoHGzcz2GJhgXfhkmRlxhXi+TX6HV/QOyXpkfZQWzIYagZyaOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhBCF/BxgtqJNCVQcpubr5rUQoaaI0XMhnHMeinxOsc=;
 b=QNuh9blxGLT3MedAtFoDJuzut0PR9REqKmUq6CuRBQsQxy18L7QaOWKDdTltg6oAxamt1NEQQG92TsnWE9OduJYgyOovouLiWCrqLjbo7EWx3/J8R5DZ3XxjweSrNiqrHxHXJeD1lx5pfhZ9szn7ceciLqeT+TGmgICcm9XgDc8r/kUQJYNeAEX/Ot9ICYJhIu6/jeUSYygeyR7qzPXvUMe2pv3dEcEtuRYEwKlk9hm1xAz1SQq31K7AKvLgUt5wOc6SxQ4KXI19TzOXKaDWVtMS0wjsrQ8b48Ya9l1/DcCvKrzXMwk+4aEFivG+mkrRFpOBXU7PQddVH266i4b/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by LV3PR11MB8674.namprd11.prod.outlook.com (2603:10b6:408:217::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 02:02:00 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::b3b:d200:42be:fe4c]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::b3b:d200:42be:fe4c%6]) with mapi id 15.20.7677.026; Tue, 18 Jun 2024
 02:01:59 +0000
Date: Tue, 18 Jun 2024 10:02:26 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@kernel.org>, <memxor@gmail.com>, <eddyz87@gmail.com>,
	<brho@google.com>, <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf] bpf: Fix remap of arena.
Message-ID: <ZnDqso7jseDC4aqp@xpf.sh.intel.com>
References: <20240617171812.76634-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240617171812.76634-1-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To SA2PR11MB4844.namprd11.prod.outlook.com
 (2603:10b6:806:f9::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR11MB4844:EE_|LV3PR11MB8674:EE_
X-MS-Office365-Filtering-Correlation-Id: acb82897-67a5-4208-ab9f-08dc8f3aa3b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FYlR9mNLFufXBNc+FrZak0X+oTwr9unhHMzc5Q/KmVqoSH+uh3IN8Ep3VWVP?=
 =?us-ascii?Q?Rcj7WIXLb8kbrDK+iS/ejtv2SMXgbU+1UCgAkUJhIHGJzFX08/Pw2+kuOA7r?=
 =?us-ascii?Q?jIEJquMW0gTpRc+Aq4adfqW0+avlL4YvOKOrQfG72tQIzRB1MxvgolIkTzfc?=
 =?us-ascii?Q?t+IZKfeAL02ERiXZ3RE/AZKfJ8qYRgnpS8RHmQglSJlD70+oylKjNhGwlas6?=
 =?us-ascii?Q?WDcJBxTB2Ee3aAUwv/UZkkchHJvupZbRPhvU7U8CfLXtHucMR+yCS3eDhdgZ?=
 =?us-ascii?Q?nkiOHhZ07f71PYJ3UhpPtU3C9qE93Mi09FL22GBpeWFz3wjwI+ruRcdZZFkK?=
 =?us-ascii?Q?fGz0kNEPig2GiUDCRY+Aufa8IfpuNt5IbZSsKSWuHlXbygjd+uN5ZdyEoXlF?=
 =?us-ascii?Q?OjDJo5MG5MGdvvOaALnsLkAZ+n361zBCIfqC4i0J862p3Po4nzuvEPPYqFAq?=
 =?us-ascii?Q?tNk+VVfPWK6XTqbvwL3YQrs6Pk4sGDrh0rrbRqDG4gFQtmh0HLmaFCpP6ymr?=
 =?us-ascii?Q?Hhp5jkGAGnKqb++cuCOQE7ddxlFKMAJp2lPsJMp1pAJyKHTVaDHH7Q2pwFoj?=
 =?us-ascii?Q?y1DSnfvHg9okj1tRdjATyohKo8/fvFAxWscV5fgjYOJ/KeiROdUz1KN606oZ?=
 =?us-ascii?Q?iGnqzs+XnUtinGHiCRPVEwotSuL775bupRKEoyQ1FvTJmLWlVowJKAlB7owD?=
 =?us-ascii?Q?twLD8hD2ek61DFzR+d7jpsW4ncp+O10C/sZcrMU+EGyAvOrsMXs2SKLRrkH6?=
 =?us-ascii?Q?dSF1IW/5SXsMtvwD+xL5lCa3OZtb+S6bJDYkRjLk1z1NM7sT6HmTMci8AeId?=
 =?us-ascii?Q?81EupLS5gTU9Zk67gBAji98uFL/nzihV8sE41GOgzJ2WtHg4ARCUs+YG9AtC?=
 =?us-ascii?Q?THQ11hYmr3Qn+6He0tI5LaDb5Dv5WoCkxATS7DOHE5+gg70oDqi69hrG6Z2C?=
 =?us-ascii?Q?xz+fwfwonjJMzQQL7O9ctsaoho8vAojOx4Nsp5UanVysbwKw2JlHkhlfufpZ?=
 =?us-ascii?Q?y+z9DLOMlGnaM/d01TLsi1VU/wXc8lToNhVLsuqnNw9nb+LLps83SoO8gi+4?=
 =?us-ascii?Q?Lgd6XzVUexUTu4Jpgfxj1JpV5Nr/+H5faNw4T7VMhgvc38F99UDpZJ8o4YT+?=
 =?us-ascii?Q?85n+ot57QqwL4eN4tKSoq/nCO7HQQtZo/HwwtB61le5Ncs/mKNBmjrcc44tc?=
 =?us-ascii?Q?ZvFi3wschGFHjb5We0qvhnd4jQt/SP0Q1d6jaS3ENi2wzPCPqbWTUnDmcovL?=
 =?us-ascii?Q?S1e4G8t/AQ9rDoxgBYxN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yDBsz7/Guha//dUHGK3+ZanYDx/ZN5wBvugGlkO8O7xx4VcE+IzSqEkbqwYx?=
 =?us-ascii?Q?HTleSfe1tvYv2o8xOrNunK+uCQaluTGyytOZ25tY8aSht07YPBHXoKj2g8Yw?=
 =?us-ascii?Q?L/Jik7TerEqhJyk4YlUwYWd5kfjFPibop8smroUgg4FDTBcDe+Z5Rdss+2Wv?=
 =?us-ascii?Q?5uI4zvEsh3qLAXMh5Ec5X9X8CSiulq3jFl4VXJwv0AVek1X3Sb+WeZn5uFGE?=
 =?us-ascii?Q?qdamqc1JV6zTizqiRXlHcz2qSxjLkWt/sIMiI65eKjOa0q4CZh5Djv9SWE2F?=
 =?us-ascii?Q?u2ymVJlVjcLq4w0NK9RXgvSDgq0yHVqHkSMfYpUss4aAONV3/jhBLLZONajU?=
 =?us-ascii?Q?6rYLu17vPe1w18Nb5ULN5wBrAgHVoc6FxEtr9Rjg5sb1WO33fIAutDoMrxR6?=
 =?us-ascii?Q?BhjnJGNOehT8kvldLpknpqgR5wB5MHCT30kyjfQex1geQKbx/7cZlCzr9UtF?=
 =?us-ascii?Q?uQLA+IH57Yb9FLvOzRVnalJfWdBOUtJs4j0Xi4tE0+C2JjMMP3N0a0U7bFYO?=
 =?us-ascii?Q?VlhEQxd1iyyuUevCNU14XCLZEa5sMdJD5seVZrf2Qj+fkjtaDP16bmR00rRW?=
 =?us-ascii?Q?Llln3D8iqYemQEnS5DAsGpPEJGUynTX9AcNPzlmTaVZLF8dMCwMRYsMW2KN4?=
 =?us-ascii?Q?BgkrE1erKFq+QTRfaq7xMFXRsA+BNgztd+/tylHX8Rd2cBzseFdjxQCuZxGQ?=
 =?us-ascii?Q?FqarSj19wTkuoOnTbG9CqZsixwD8rd9F2LyHhtwpVaIG3xZSItFOVDGH1NkF?=
 =?us-ascii?Q?f/mAU8bx8e6clZhSsqxW1STflL7LZTFQ6phGjeznVJ/0GJ86LoOueemodOqj?=
 =?us-ascii?Q?VqnWd21+1EWDL4IUb87NcxvKreE+qNEFPRubrP62kS3Bt6yxDJ4d469FFxe+?=
 =?us-ascii?Q?nqvC0mTrnRxZMbINHoblW4b350BEo+xIZUzAIr0tkNYUW0EDFtGr56/79PY8?=
 =?us-ascii?Q?LTIOhs+SG84EXTMjznLW2xFynNiM3F0QqquC+E1DRc7Z5WDCFEfQQAo+QNtg?=
 =?us-ascii?Q?50sjNu9Qz81yQtn2IkaPOrY6C99H8fHKP3Nygxq7D+IH/4T1bPlRJAD2JX+T?=
 =?us-ascii?Q?OOruUkGSPsNN4TZZWepcvsi+BnY9WzeDFWnuX2AcRy/J9CLVe1rHs6CoODiV?=
 =?us-ascii?Q?1D7QJO0fL/BWKIOJrHxjr/NcIIQt3VSKb7rXgbQdIpK7buxthOkILmpXYECP?=
 =?us-ascii?Q?nEqNwIl3KmqZsoM2qnt9HSopJKdmBaNix/egBsT/+hWUh1t2O7CmXU8t475P?=
 =?us-ascii?Q?cXnx6f3GO9nEwLCcw7wqKAFpSKnKi69GaNaKpvwxy7HhnIequwtNz09b+zUS?=
 =?us-ascii?Q?t70Ta05tH8i7hacl7XB4BpmTcNDXf5vixlPXIJ44DuVykrinrunRqe4CZo4N?=
 =?us-ascii?Q?PDjMJSBOEjEKyudyEsBJ5E4gyKXh5iPPO0rfKLjjpWj2zmOn4z4j+kXmp1Cp?=
 =?us-ascii?Q?8n3BQWyffhvDWc1XtHSC4/PD9SgX+HaKEzxAWzSWq9ptvf7rsB9Lh9Ddy5wn?=
 =?us-ascii?Q?6Y3fUOtmUAA0ks2P3HCGBWPmZowxStkgifeYh7IkNDaGJOlHsJeEb9GZ4rBF?=
 =?us-ascii?Q?tPhQmwH25kO/1Ozpce7gPgwZ05mjL/mzeFOZlk1o?=
X-MS-Exchange-CrossTenant-Network-Message-Id: acb82897-67a5-4208-ab9f-08dc8f3aa3b7
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 02:01:59.7993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dd1j0YbJm/W1ELShsU7cbOp1xLDSGI2amLeKnqa7Bx5LG8/tEO5Cvaht/JECnVQqZmrRaSNrGkmja2AEuAQFTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8674
X-OriginatorOrg: intel.com


The issue cannot be reproduced in the new patch below.

Best Regards,
Thanks!

On 2024-06-17 at 10:18:12 -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The bpf arena logic didn't account for mremap operation. Add a refcnt for
> multiple mmap events to prevent use-after-free in arena_vm_close.
> 
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Closes: https://lore.kernel.org/bpf/Zmuw29IhgyPNKnIM@xpf.sh.intel.com/
> Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/bpf/arena.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 583ee4fe48ef..fe35b45cf6f8 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -212,6 +212,7 @@ static u64 arena_map_mem_usage(const struct bpf_map *map)
>  struct vma_list {
>  	struct vm_area_struct *vma;
>  	struct list_head head;
> +	atomic_t mmap_count;
>  };
>  
>  static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
> @@ -221,20 +222,32 @@ static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
>  	vml = kmalloc(sizeof(*vml), GFP_KERNEL);
>  	if (!vml)
>  		return -ENOMEM;
> +	atomic_set(&vml->mmap_count, 1);
>  	vma->vm_private_data = vml;
>  	vml->vma = vma;
>  	list_add(&vml->head, &arena->vma_list);
>  	return 0;
>  }
>  
> +static void arena_vm_open(struct vm_area_struct *vma)
> +{
> +	struct bpf_map *map = vma->vm_file->private_data;
> +	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
> +	struct vma_list *vml = vma->vm_private_data;
> +
> +	atomic_inc(&vml->mmap_count);
> +}
> +
>  static void arena_vm_close(struct vm_area_struct *vma)
>  {
>  	struct bpf_map *map = vma->vm_file->private_data;
>  	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
> -	struct vma_list *vml;
> +	struct vma_list *vml = vma->vm_private_data;
>  
> +	if (!atomic_dec_and_test(&vml->mmap_count))
> +		return;
>  	guard(mutex)(&arena->lock);
> -	vml = vma->vm_private_data;
> +	/* update link list under lock */
>  	list_del(&vml->head);
>  	vma->vm_private_data = NULL;
>  	kfree(vml);
> @@ -287,6 +300,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>  }
>  
>  static const struct vm_operations_struct arena_vm_ops = {
> +	.open		= arena_vm_open,
>  	.close		= arena_vm_close,
>  	.fault          = arena_vm_fault,
>  };
> -- 
> 2.43.0
> 

