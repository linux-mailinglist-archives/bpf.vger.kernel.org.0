Return-Path: <bpf+bounces-37034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6219506A9
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 15:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2FE2861EB
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 13:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB47119CD0A;
	Tue, 13 Aug 2024 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mgomr1n5"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC51860EC4;
	Tue, 13 Aug 2024 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723556246; cv=fail; b=ZbLP5TxIUCJ0OXc6F2vXZUZzfQYmvEZ5k3ZgZoL8LiKk6Mojzq9wuuByP/twlKlW3cduRp9oPQVW8uUM0d797vT/JRba0RTxjplmyQC9Q01ZpYGIkvR77KJ7lG0gbQ//Bz8135UW07ZCkm8JrFJIy5SyAjTA0PfPxav/stS6nOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723556246; c=relaxed/simple;
	bh=I1unFJsgAHyA0HMg4kVic4rPrvrGx2mMA4o4XZhncH4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mQ2N5Zj3GAOmvrtoEEBRlN38wlVQ1e0L4N0yCI29ehJAcgW+kLc90k6rY1InZMQl0SL/sFSVxBzKPdiJNlzlap5CHS7Pj9J7zzrsarI9EfQnY05nXVsp7Ng3fODEh8bRXy/prW7oAIcgn9Sd3DhkjoVxK2I9wnuQD97zXqQiKQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mgomr1n5; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723556244; x=1755092244;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=I1unFJsgAHyA0HMg4kVic4rPrvrGx2mMA4o4XZhncH4=;
  b=Mgomr1n55fMP6grPHJDKhikaLLGKaoeJqbXP2GhAeqRmCU35ZaQsjyTl
   AGY4mkali897CjIRiPpGg+CjS61/SuDMHKjCZFa+kgc7Q3eOjFPLKOZ8F
   u5Zu1F8lMdB/jlF9ryFWvFGpoCQhvYJqdgb58aVrgbgWQftp2dQENY/aa
   RHeO3iuK+sd1ufIJf9z4JciMVKfFED0uZ+XaioFzSiyz6MP+XDUAI5+iY
   P+/08n48AeUxYtdie4dH1jHxQoAg+HVSxtyT8xpKinj9P/CkPk8GEjFTn
   w+jM8gOM3waxVlPTFhAr4H3q4G8Aedmt+s9s0s2waSGUF/SbEsIcI60MV
   Q==;
X-CSE-ConnectionGUID: BaABPTFbQNm2+yRDsSrdGw==
X-CSE-MsgGUID: NGvFuNIyTymeBpaAGPEFXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21580675"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="21580675"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 06:37:22 -0700
X-CSE-ConnectionGUID: NlL/6rpnTSmRA3eK9gVmjQ==
X-CSE-MsgGUID: /3gYQwgSQrOIJsidrOMJFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="63518015"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 06:37:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 06:37:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 06:37:22 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 06:37:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtUZBDhYFgdEDurgTW/N3/hDY/VWqKso+Wq7t0hE8izL9gl5a2E8HP2bnXUhMxdrTLozjAnZVeN8GjLHQenIVqsbADEFzXN9YcxqFogTnOHo70lO/GYJAiQvjOkgBGm2+Cs3Bs1Q+x38t3F4zb/WaLD+CW8jBhLuFEz7U6NGkkMKyb7/ljcOgUBO82NSN9mCrdfsloXak8AQToo9/w9CHHkZppEEdZPYG+MgzA2LBhLhNUqc2fh/HhMgVnkOdVL3ai2yypb6Ks6JMmUkZYFegUYALBBB59OLdKmewjCwTwajLZMItZGKjL6V0SPyVqpk3R7p6shg9sWlOEAmeZc8Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPj/lCALHixIaK2nGOsxj5Pmq9jdaBd5d830l2h3Vvg=;
 b=rFXWs7SK99ThN/45v8mNQ6Pwbb/v0iSp2vDhvNfEeFfLQtJPwwZiCnkFbnSEbRDW/T4Mv1Tk9aYEARh4WHC/Va4mOL/khdZru0jL2zwpXmbyfjl35diw/HAD8YnsCwb7IR9bmUhrMl3F7Cya4mluMwyKtk7zONUyoyribKyE27KKah565wtILuD1NGPkgCbQlkaCIAFLNOPCM+SYnWVOzmz8kEiqPH0NZkPOwWMUnArPXq0g7Qp2G7VfzaWDE0tRSGk8QXuxH7RxTaEZiP9CInzvp65vhjEoJXSexx4i/r+653l+DiI9k6aTnnzXA1H1iH784yUfPKZw2l9iW6QUdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DS7PR11MB7857.namprd11.prod.outlook.com (2603:10b6:8:da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 13 Aug
 2024 13:37:14 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%4]) with mapi id 15.20.7828.030; Tue, 13 Aug 2024
 13:37:14 +0000
Date: Tue, 13 Aug 2024 15:36:57 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Jacob
 Keller" <jacob.e.keller@intel.com>, Eric Dumazet <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, Michal Kubiak <michal.kubiak@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, Amritha Nambiar
	<amritha.nambiar@intel.com>
Subject: Re: [PATCH iwl-net v2 2/6] ice: protect XDP configuration with a
 mutex
Message-ID: <ZrthebTBERMWN1DR@lzaremba-mobl.ger.corp.intel.com>
References: <20240724164840.2536605-1-larysa.zaremba@intel.com>
 <20240724164840.2536605-3-larysa.zaremba@intel.com>
 <ZrtELQV3zZENOvn+@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZrtELQV3zZENOvn+@boxer>
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DS7PR11MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: 0466d257-627a-4df4-33ec-08dcbb9d0a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?diSRdXnJQZPSjXapGInVLrGv1jJjd3NLFeaPFU3/BleKSNZ0Db4E8jIYXlxU?=
 =?us-ascii?Q?c4EDkbA7rHZOzrEkbBRKO3TRHJLFo4qjK2+hZ++9AFext21fsJU/mHt7moa7?=
 =?us-ascii?Q?tEdiremxlzgIWwQj2j/lRUZ7ZHb/EIx7f5ZD6DCUpaJLG0/wTOgFX+Hp3Pjf?=
 =?us-ascii?Q?5HffN1Dy0myV+VNo+Epv3RiczzhtzOGLBqeoqiYOVJs9bovob4VyEocQai+X?=
 =?us-ascii?Q?WPSBVuWGle/UOj73M4F8L1+i7FnE6Uc3UV5O2V7gSUU3PAL6yPyJ4oebV5u5?=
 =?us-ascii?Q?aQRoJE51z2iQH6fHDD8wfmobIsEPNef71HM1CWicrmDP3UEAnUSpmzVXC4rb?=
 =?us-ascii?Q?D1emSepwn8izisfEHY1WtjuugP8baabwAcDS3/mxuX1/ONFfI1K3kqDGwNc8?=
 =?us-ascii?Q?VL6qzFQPWN+pn03Bruc4UsVF78jeYW81nVlcSriEUinSBaXVhfDj263Jn28n?=
 =?us-ascii?Q?vK+ARicuB66CMvV5pvIhaZ7JgL3uoIeEiLJ3gbi2pc9rc30sKLP8gPrfkqL+?=
 =?us-ascii?Q?dfrsdOAB9tRz1Ci4hmlt2YB0U23rgt5ETIf3dKeN8C+MvZFqbuFo+mSJSd0z?=
 =?us-ascii?Q?gmD++7A9ehV1QtAy/yHF5FO+QsWhfrDiqBL/8KQoS+qt8L43AcMAvXnJoN/I?=
 =?us-ascii?Q?Ibevkk2udsRwqmrbtxJb7WsPXZwrsqL0yfmMpQohFJicxmH0iEynuNgakvv4?=
 =?us-ascii?Q?zP8CPNYKWbyzOVwsEPs/9ok2qdzDXI+Jrq5AHPS/aai4gGOp8i9PIy/xZ191?=
 =?us-ascii?Q?EJnh9L5KBceyXdplLrVbHjwYl0z3sLWd0KL3YGtPIjUxMzA+hkPG4T82jNVl?=
 =?us-ascii?Q?YkJhWp0u8Ej4TD67P3wBv9WESVUA/ckXljA5EBQOY4sql2POO/yNpEv+FtKG?=
 =?us-ascii?Q?f4jitl4coauBFf9DZmRD6DLBbsyABuv+FEtFDxDMWoFVcgopjrwryQsfS3YU?=
 =?us-ascii?Q?IIVAicHK1bGAvtx/6wKpBKAL5QYmKIgpxCheC4Z4UiXQu5x1I7uo37d6Tv7h?=
 =?us-ascii?Q?MQCZgo9sCY8lKAYaKMZq0q5Y0ERvqoonqK2D+86itldgheyV2Yt9bZjYimGQ?=
 =?us-ascii?Q?MGWa4juh9hNg1jXQZiR0bbUaddzBB3im0Z4nVlNh1mo2/FHGJL7dbEFMJ73I?=
 =?us-ascii?Q?4p8YlAE8d7HhgOxpDuOv/SH5G6ZjvlerICXXIINUZ0cysP/yClvHYyZ3vpfs?=
 =?us-ascii?Q?9kefpFv2wp1cpLXKV0Oz7dzUgvV41R+pfitscgI/E1jVBTW41IxTKxNvQD5i?=
 =?us-ascii?Q?JDfAQ+uglqaBD2bYVE2135dmi4EgmAK58LLjoQ10W6f8r2ujRwvvjW2+rBlD?=
 =?us-ascii?Q?7WQKlh6xouMfqzXLgJLSWVxOZa9URE9gtk+tVZdffjixxA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4i7oemUatTOj2h8UhyXOVIKzuDfOPtkmGDdZIz1lT8iG1vhh3c1IZY5b1Rs2?=
 =?us-ascii?Q?OKuTvrZxLLm1GJg41rtqvLiZL9iQB63raBU/bi0yO/LwioLZqE4tXtdhhX1A?=
 =?us-ascii?Q?k6WSEqmozAUEg+XLfH9+e3sr8vhQYtt1JZIdnitwWdgIugf9sWT1bpbxwJjb?=
 =?us-ascii?Q?SHBniF9s5HtvvshKe0A2DuzQuTYU8Y9ZgajvZvPnaGJTU7GpIYJ99qT0rbZ8?=
 =?us-ascii?Q?lddr0L3Jur+whs4MDCSoE9B6UAVtXnjtHJdHbEhVCz68dYumyzKBbNgHMlzo?=
 =?us-ascii?Q?snGXP5zxfFs8v/t8AahCuUgxyPz7gjAEllQXsUeeVgWbjSrfjolFMWQXX0/E?=
 =?us-ascii?Q?/sH/DORrI7hlfftwICu4x7FBE8sp0kgLnsxAdbUPmFmsCYT7KIEE2+BqXPU8?=
 =?us-ascii?Q?paOBvcUKpLVYeu1/9pggh1YhsrGPlMHhXH6X+NUr44eW9gYSDcZJI8DPdRQj?=
 =?us-ascii?Q?RrGlcLjSRMN93ZU9Z0vHLhrTk/1mkCZoiBl9yAXyt49TY5vYOKPDGMEnwODI?=
 =?us-ascii?Q?bxKtTj0lh80hdJrI3DUpDh15WN0GCgpJ6sNYMQ9XGvtdUivUuObrAeo3rSVW?=
 =?us-ascii?Q?a/9EDqLM6bHnUfWi3x5UF4JHlswxXACTrKOJ4lQoCNzIf/fdnK8tOEzur9AO?=
 =?us-ascii?Q?XoZd/mL3FFmcuRnf1TIMsmMXEYS9zT3SRL5Y4T8dLTcA1j39DFoMQjwL+Jua?=
 =?us-ascii?Q?DfWPonPw9l+dI1jmlcnDdl5P2fzaAJL3inFU5BvNJcrKAFWrRtapG9tUXxsj?=
 =?us-ascii?Q?IMRbpqDNq/NdHJ7cTdOdYMahauviihcK2rNjc/FS+UBihZAlao4QM0FJbZFl?=
 =?us-ascii?Q?bjjuO9XAkAKr8ebGdnzB1LHwZAV3dJcO6GkRAxtCu8dDhGGINDnFOA8cSZbg?=
 =?us-ascii?Q?rdUYskOe2OLB7XQygw15Tiebf6bOZTeQpgp2QBHEv1LfR0qoFsFrJgRwpB3Y?=
 =?us-ascii?Q?D2SI8zs7fAQsDhZH9eHfGDZdrKxeBCgP9JXa2mYFScOc6zkjERituLOYYC5T?=
 =?us-ascii?Q?L7PJqeGCCAdxx0mlJn4tFdxueFAQ4q2x1BPdqYrfoCdc/xzqaBG9P/pyn0UT?=
 =?us-ascii?Q?abkaCluzfwkR7FysP8GgHGkbOpB4GB/Q1JCsTUuRplg4+VoxNaE+VEiT+qqP?=
 =?us-ascii?Q?3oTqp5VMySLkAMs0Fyt+CrMDl2xtKKBMh583X3lChF7RU+n/ajcdxfXoljdW?=
 =?us-ascii?Q?o0VIITWhnS4csolSAPqNIeJXpRtjkQeiKY0iMwBM5sNHTYptBr6D2Vd7qKBh?=
 =?us-ascii?Q?LoVHD54dsRaLIjUHkMimjsuBFBnObCjIfg3cH0/DTOmoxFrQxRlZvJsUOw38?=
 =?us-ascii?Q?PjyEK9GgRMrfCcMcJPYeFK2JKr3X6eiubEyCbUPS+NN4CJqm3M/zAvx4jZvB?=
 =?us-ascii?Q?gvnw1UXShVfvXk98kFBQdOKPnPWbxz2CEQfzKkL85z9K71m9aClR5rsELB7a?=
 =?us-ascii?Q?8gPrh5oV3x78dB1jOPx5MHM44NrqS+rLgd4WMEZF2F8t2HG1M2V5m5vBCdYA?=
 =?us-ascii?Q?hC2sjQyFTFPzP5ep7iPrwSB3EUnfVfLgmb4dt5bVKsFm93IvrTR4pqFAYonS?=
 =?us-ascii?Q?dgmG8cq+/l5E4Ww6InJ0uD4ZZ8ZaE+Wog/fh6ygF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0466d257-627a-4df4-33ec-08dcbb9d0a82
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 13:37:14.2365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r03Lx06jY/NAC8/yUZKYZf00fCVzCEGpZYlTZ18FnAsNhaVcrLB5Xkhhy+qi5/cgH6BIsbmND/GBPP9QabGGyjVtJN86i1gjxe2rYqKKS08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7857
X-OriginatorOrg: intel.com

On Tue, Aug 13, 2024 at 01:31:57PM +0200, Maciej Fijalkowski wrote:
> On Wed, Jul 24, 2024 at 06:48:33PM +0200, Larysa Zaremba wrote:
> > The main threat to data consistency in ice_xdp() is a possible asynchronous
> > PF reset. It can be triggered by a user or by TX timeout handler.
> > 
> > XDP setup and PF reset code access the same resources in the following
> > sections:
> > * ice_vsi_close() in ice_prepare_for_reset() - already rtnl-locked
> > * ice_vsi_rebuild() for the PF VSI - not protected
> > * ice_vsi_open() - already rtnl-locked
> > 
> > With an unfortunate timing, such accesses can result in a crash such as the
> > one below:
> > 
> > [ +1.999878] ice 0000:b1:00.0: Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring 14
> > [ +2.002992] ice 0000:b1:00.0: Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring 18
> > [Mar15 18:17] ice 0000:b1:00.0 ens801f0np0: NETDEV WATCHDOG: CPU: 38: transmit queue 14 timed out 80692736 ms
> > [ +0.000093] ice 0000:b1:00.0 ens801f0np0: tx_timeout: VSI_num: 6, Q 14, NTC: 0x0, HW_HEAD: 0x0, NTU: 0x0, INT: 0x4000001
> > [ +0.000012] ice 0000:b1:00.0 ens801f0np0: tx_timeout recovery level 1, txqueue 14
> > [ +0.394718] ice 0000:b1:00.0: PTP reset successful
> > [ +0.006184] BUG: kernel NULL pointer dereference, address: 0000000000000098
> > [ +0.000045] #PF: supervisor read access in kernel mode
> > [ +0.000023] #PF: error_code(0x0000) - not-present page
> > [ +0.000023] PGD 0 P4D 0
> > [ +0.000018] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [ +0.000023] CPU: 38 PID: 7540 Comm: kworker/38:1 Not tainted 6.8.0-rc7 #1
> > [ +0.000031] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0014.082620210524 08/26/2021
> > [ +0.000036] Workqueue: ice ice_service_task [ice]
> > [ +0.000183] RIP: 0010:ice_clean_tx_ring+0xa/0xd0 [ice]
> > [...]
> > [ +0.000013] Call Trace:
> > [ +0.000016] <TASK>
> > [ +0.000014] ? __die+0x1f/0x70
> > [ +0.000029] ? page_fault_oops+0x171/0x4f0
> > [ +0.000029] ? schedule+0x3b/0xd0
> > [ +0.000027] ? exc_page_fault+0x7b/0x180
> > [ +0.000022] ? asm_exc_page_fault+0x22/0x30
> > [ +0.000031] ? ice_clean_tx_ring+0xa/0xd0 [ice]
> > [ +0.000194] ice_free_tx_ring+0xe/0x60 [ice]
> > [ +0.000186] ice_destroy_xdp_rings+0x157/0x310 [ice]
> > [ +0.000151] ice_vsi_decfg+0x53/0xe0 [ice]
> > [ +0.000180] ice_vsi_rebuild+0x239/0x540 [ice]
> > [ +0.000186] ice_vsi_rebuild_by_type+0x76/0x180 [ice]
> > [ +0.000145] ice_rebuild+0x18c/0x840 [ice]
> > [ +0.000145] ? delay_tsc+0x4a/0xc0
> > [ +0.000022] ? delay_tsc+0x92/0xc0
> > [ +0.000020] ice_do_reset+0x140/0x180 [ice]
> > [ +0.000886] ice_service_task+0x404/0x1030 [ice]
> > [ +0.000824] process_one_work+0x171/0x340
> > [ +0.000685] worker_thread+0x277/0x3a0
> > [ +0.000675] ? preempt_count_add+0x6a/0xa0
> > [ +0.000677] ? _raw_spin_lock_irqsave+0x23/0x50
> > [ +0.000679] ? __pfx_worker_thread+0x10/0x10
> > [ +0.000653] kthread+0xf0/0x120
> > [ +0.000635] ? __pfx_kthread+0x10/0x10
> > [ +0.000616] ret_from_fork+0x2d/0x50
> > [ +0.000612] ? __pfx_kthread+0x10/0x10
> > [ +0.000604] ret_from_fork_asm+0x1b/0x30
> > [ +0.000604] </TASK>
> > 
> > The previous way of handling this through returning -EBUSY is not viable,
> > particularly when destroying AF_XDP socket, because the kernel proceeds
> > with removal anyway.
> > 
> > There is plenty of code between those calls and there is no need to create
> > a large critical section that covers all of them, same as there is no need
> > to protect ice_vsi_rebuild() with rtnl_lock().
> > 
> > Add xdp_state_lock mutex to protect ice_vsi_rebuild() and ice_xdp().
> > 
> > Leaving unprotected sections in between would result in two states that
> > have to be considered:
> > 1. when the VSI is closed, but not yet rebuild
> > 2. when VSI is already rebuild, but not yet open
> > 
> > The latter case is actually already handled through !netif_running() case,
> > we just need to adjust flag checking a little. The former one is not as
> > trivial, because between ice_vsi_close() and ice_vsi_rebuild(), a lot of
> > hardware interaction happens, this can make adding/deleting rings exit
> > with an error. Luckily, VSI rebuild is pending and can apply new
> > configuration for us in a managed fashion.
> > 
> > Therefore, add an additional VSI state flag ICE_VSI_REBUILD_PENDING to
> > indicate that ice_xdp() can just hot-swap the program.
> 
> couldn't this be a separate patch?
> 

I think, this is an integral part of the synchronization concept, without it 
locking the rebuild would not have much sense.

> > 
> > Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
> > Fixes: efc2214b6047 ("ice: Add support for XDP")
> > Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice.h      |  2 ++
> >  drivers/net/ethernet/intel/ice/ice_lib.c  | 26 +++++++++++++++--------
> >  drivers/net/ethernet/intel/ice/ice_main.c | 19 ++++++++++++-----
> >  drivers/net/ethernet/intel/ice/ice_xsk.c  |  3 ++-
> >  4 files changed, 35 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> > index 99a75a59078e..3d7a0abc13ab 100644
> > --- a/drivers/net/ethernet/intel/ice/ice.h
> > +++ b/drivers/net/ethernet/intel/ice/ice.h
> > @@ -318,6 +318,7 @@ enum ice_vsi_state {
> >  	ICE_VSI_UMAC_FLTR_CHANGED,
> >  	ICE_VSI_MMAC_FLTR_CHANGED,
> >  	ICE_VSI_PROMISC_CHANGED,
> > +	ICE_VSI_REBUILD_PENDING,
> >  	ICE_VSI_STATE_NBITS		/* must be last */
> >  };
> >  
> > @@ -411,6 +412,7 @@ struct ice_vsi {
> >  	struct ice_tx_ring **xdp_rings;	 /* XDP ring array */
> >  	u16 num_xdp_txq;		 /* Used XDP queues */
> >  	u8 xdp_mapping_mode;		 /* ICE_MAP_MODE_[CONTIG|SCATTER] */
> > +	struct mutex xdp_state_lock;
> >  
> >  	struct net_device **target_netdevs;
> >  
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> > index 5f2ddcaf7031..bbef5ec67cae 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > @@ -447,6 +447,7 @@ static void ice_vsi_free(struct ice_vsi *vsi)
> >  
> >  	ice_vsi_free_stats(vsi);
> >  	ice_vsi_free_arrays(vsi);
> > +	mutex_destroy(&vsi->xdp_state_lock);
> >  	mutex_unlock(&pf->sw_mutex);
> >  	devm_kfree(dev, vsi);
> >  }
> > @@ -626,6 +627,8 @@ static struct ice_vsi *ice_vsi_alloc(struct ice_pf *pf)
> >  	pf->next_vsi = ice_get_free_slot(pf->vsi, pf->num_alloc_vsi,
> >  					 pf->next_vsi);
> >  
> > +	mutex_init(&vsi->xdp_state_lock);
> > +
> >  unlock_pf:
> >  	mutex_unlock(&pf->sw_mutex);
> >  	return vsi;
> > @@ -2973,19 +2976,24 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
> >  	if (WARN_ON(vsi->type == ICE_VSI_VF && !vsi->vf))
> >  		return -EINVAL;
> >  
> > +	mutex_lock(&vsi->xdp_state_lock);
> > +	clear_bit(ICE_VSI_REBUILD_PENDING, vsi->state);
> > +
> >  	ret = ice_vsi_realloc_stat_arrays(vsi);
> >  	if (ret)
> > -		goto err_vsi_cfg;
> > +		goto unlock;
> >  
> >  	ice_vsi_decfg(vsi);
> >  	ret = ice_vsi_cfg_def(vsi);
> >  	if (ret)
> > -		goto err_vsi_cfg;
> > +		goto unlock;
> >  
> >  	coalesce = kcalloc(vsi->num_q_vectors,
> >  			   sizeof(struct ice_coalesce_stored), GFP_KERNEL);
> > -	if (!coalesce)
> > -		return -ENOMEM;
> > +	if (!coalesce) {
> > +		ret = -ENOMEM;
> 
> Knee-jerk reaction would be to deconfig things that ice_vsi_cfg_def()
> setup above.
> 
> So I think the order of kfree and ice_vsi_decfg should be swapped,
> something like:
> 
> 	if (!coalesce) {
> 		ret = -ENOMEM;
> 		goto err_mem_alloc;
> 	}
> 
> err_vsi_cfg_tc_lan:
> 	kfree(coalesce);
> err_mem_alloc:
> 	ice_vsi_decfg(vsi);
> unlock:
> 	mutex_unlock(&vsi->xdp_state_lock);
> 	return ret;
> 
> 
> or am I missing something?
> 

You are correct, v3 it is :D

> > +		goto unlock;
> > +	}
> >  
> >  	prev_num_q_vectors = ice_vsi_rebuild_get_coalesce(vsi, coalesce);
> >  
> > @@ -2996,19 +3004,19 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
> >  			goto err_vsi_cfg_tc_lan;
> >  		}
> >  
> > -		kfree(coalesce);
> > -		return ice_schedule_reset(pf, ICE_RESET_PFR);
> > +		ret = ice_schedule_reset(pf, ICE_RESET_PFR);
> > +		goto err_vsi_cfg_tc_lan;
> >  	}
> >  
> >  	ice_vsi_rebuild_set_coalesce(vsi, coalesce, prev_num_q_vectors);
> >  	kfree(coalesce);
> > -
> > -	return 0;
> > +	goto unlock;
> >  
> >  err_vsi_cfg_tc_lan:
> >  	ice_vsi_decfg(vsi);
> >  	kfree(coalesce);
> > -err_vsi_cfg:
> > +unlock:
> > +	mutex_unlock(&vsi->xdp_state_lock);
> >  	return ret;
> >  }
> >  
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > index 8ed1798bb06e..e50526b491fc 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -611,6 +611,7 @@ ice_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
> >  	/* clear SW filtering DB */
> >  	ice_clear_hw_tbls(hw);
> >  	/* disable the VSIs and their queues that are not already DOWN */
> > +	set_bit(ICE_VSI_REBUILD_PENDING, ice_get_main_vsi(pf)->state);
> >  	ice_pf_dis_all_vsi(pf, false);
> >  
> >  	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
> > @@ -3011,7 +3012,8 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
> >  	}
> >  
> >  	/* hot swap progs and avoid toggling link */
> > -	if (ice_is_xdp_ena_vsi(vsi) == !!prog) {
> > +	if (ice_is_xdp_ena_vsi(vsi) == !!prog ||
> > +	    test_bit(ICE_VSI_REBUILD_PENDING, vsi->state)) {
> >  		ice_vsi_assign_bpf_prog(vsi, prog);
> >  		return 0;
> >  	}
> > @@ -3083,21 +3085,28 @@ static int ice_xdp(struct net_device *dev, struct netdev_bpf *xdp)
> >  {
> >  	struct ice_netdev_priv *np = netdev_priv(dev);
> >  	struct ice_vsi *vsi = np->vsi;
> > +	int ret;
> >  
> >  	if (vsi->type != ICE_VSI_PF) {
> >  		NL_SET_ERR_MSG_MOD(xdp->extack, "XDP can be loaded only on PF VSI");
> >  		return -EINVAL;
> >  	}
> >  
> > +	mutex_lock(&vsi->xdp_state_lock);
> > +
> >  	switch (xdp->command) {
> >  	case XDP_SETUP_PROG:
> > -		return ice_xdp_setup_prog(vsi, xdp->prog, xdp->extack);
> > +		ret = ice_xdp_setup_prog(vsi, xdp->prog, xdp->extack);
> > +		break;
> >  	case XDP_SETUP_XSK_POOL:
> > -		return ice_xsk_pool_setup(vsi, xdp->xsk.pool,
> > -					  xdp->xsk.queue_id);
> > +		ret = ice_xsk_pool_setup(vsi, xdp->xsk.pool, xdp->xsk.queue_id);
> > +		break;
> >  	default:
> > -		return -EINVAL;
> > +		ret = -EINVAL;
> >  	}
> > +
> > +	mutex_unlock(&vsi->xdp_state_lock);
> > +	return ret;
> >  }
> >  
> >  /**
> > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > index a65955eb23c0..2c1a843ba200 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > @@ -379,7 +379,8 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
> >  		goto failure;
> >  	}
> >  
> > -	if_running = netif_running(vsi->netdev) && ice_is_xdp_ena_vsi(vsi);
> > +	if_running = !test_bit(ICE_VSI_DOWN, vsi->state) &&
> > +		     ice_is_xdp_ena_vsi(vsi);
> >  
> >  	if (if_running) {
> >  		struct ice_rx_ring *rx_ring = vsi->rx_rings[qid];
> > -- 
> > 2.43.0
> > 

