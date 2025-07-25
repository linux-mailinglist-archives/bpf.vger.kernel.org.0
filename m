Return-Path: <bpf+bounces-64339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06762B11B1C
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 11:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22BC616444D
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 09:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3272D3A86;
	Fri, 25 Jul 2025 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="msGa1Zc7"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D7B239E91;
	Fri, 25 Jul 2025 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753436708; cv=fail; b=JoeinK4laASmUjhU+tETiJNNZtIKxO+zgbGF51xiLuPmOOcuHPy3YzPhCUiPO13nK04TAG0zoJvMwcYckSW9e4mBsdamzwENcVcPcBJLWW0nn08K8fcj60cMjtorEWrMddVSFgmf7rx9B4YLZVqqsjrQOAILPnUuZGXvxsHUztY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753436708; c=relaxed/simple;
	bh=2hR820Czr1Iei/KurTyBOY/b4rHuERC9Pqj0pMmpOFE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cYF3sRV74iC81QNkbt2n3Ht9DOfy9WgN8N3P5vkF13DQDdWF5lWYUCZe+04R99yu6csUZQ7uYxFOYbPWpPqT9H9EIG5Bo8KuZjRIUsgnqd6HYNUtfl72W6FdJxTLuK28Fgj9EV2O76ciKjhP57CCLxNYUbTCAApmIU6o9hEz+tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=msGa1Zc7; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753436707; x=1784972707;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2hR820Czr1Iei/KurTyBOY/b4rHuERC9Pqj0pMmpOFE=;
  b=msGa1Zc7i4nHY+QKw6cFTXeZwG+7P3J2FLZVM+cY4wtqeR9BE78BgJWO
   4KvPkFP4zvkaaut0OMYiJFyzrImkPAOuHXNn3VSWcExtvHeUUGLUfjzmv
   D/kK4KRTY0Z5MXLZPBYxfH5cgtRUlW7+v9BF9AqYO3yRW7tYOsRt1YKAj
   HhetwO/YtOiLuxfsdsOEgot2aG9F/zkyHpPOZznAczcvjIYwoo+CHqUCA
   nByhCxFJ6LlLm4MsxcT6acKdX3Fn5UHpiueFk2mbPOlmDf2R7ejXCMEJt
   uUWXjw/nUcdTq2q5FxwzaLbcTXaEXoByiw96WbLO5czwWh2F19lxOzDfS
   Q==;
X-CSE-ConnectionGUID: lH8OUmF8QtiMrGDvHlD4YA==
X-CSE-MsgGUID: j4G508oFTSCU5PlKtSKg0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="54981801"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="54981801"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 02:45:05 -0700
X-CSE-ConnectionGUID: lKm08gC1TsO107LEL9OvdA==
X-CSE-MsgGUID: h4pbxliwQte5svQtxsQ1DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="161559374"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 02:45:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 02:45:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 02:45:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.81) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 02:45:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCOqniIQAQLta/E17PMKLkPBg8xwAizfl6UYc/e89T5l5BFAojGTCaBFzOkq8kTKFaFv4Tt2zjXudf7gfE3dPFz/mELNvq+QznFP1dK0EDdg4YTWBKiOniN6mmlZa3HcotsVYtbAPl4bwgBYxgqOXB/J7X8bo4PlmiMPKxAV1jqT/UXf4nBP4M9dCZ45rpR3hT1TdUks56YBxwQfr59pBpdaSuZrKMVJNUL6t2zwUWgaWtb7j8PciS6sJiSJeq0yEOBWDybUPlJniWoPYcJ0ZbdTlTx5pNf5Bulxj8xZcF2GFFqRWlLk2M/oRDsaTRfJOyWA/FGcX2xKfIdUjY00Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32CVizhrMmb/tvJEUss9p6HpqNjRAx/EcfaTn716PXU=;
 b=b0dbpQBvCishvclX+FgTSRZeD+K1whJMrfVrejpfitXox2/LNAFtvkn3xVpp6IdtEcqVvkf7KPUWm46y1ES8rPd3BhPb2SC+LGl0PjuEd7jvl2Obj73N+BY176CdbadUrCMSKUPXT5SY53qCjDbQ8Djl8hR6BEzsI1MoxhrAoh78YEOrQ9VnZ0asqn3DBKLeIm3ttT4TKHysX/tkOkrap32osqGjXUPP3PHnPn9TFI42akWAsPc9o9asYST2l/UYt18A4CuCtJdFwFfZtoSubkz/kd8pEEgSIZpxjR0xd0egg/VzXdKcD8D3wH4UEtb23Dn9xqo8PHCH+Z8CEWKfZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SJ0PR11MB5022.namprd11.prod.outlook.com (2603:10b6:a03:2d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 09:45:02 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%4]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 09:45:01 +0000
Date: Fri, 25 Jul 2025 11:44:44 +0200
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
Subject: Re: [PATCH net-next 3/5] ixgbe: xsk: use ixgbe_desc_unused as the
 budget in ixgbe_xmit_zc
Message-ID: <aINSDD1BezlEn_gM@soc-5CG4396X81.clients.intel.com>
References: <20250720091123.474-1-kerneljasonxing@gmail.com>
 <20250720091123.474-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250720091123.474-4-kerneljasonxing@gmail.com>
X-ClientProxiedBy: WA2P291CA0035.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::11) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SJ0PR11MB5022:EE_
X-MS-Office365-Filtering-Correlation-Id: e28319f9-7cc0-4200-24f9-08ddcb5fecfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bXKHD35aeBQXCnPxiuMsnZBXTEiHxsZ55WC00zQ/sn3+V+xwklc820PvdF/e?=
 =?us-ascii?Q?XsOwIIiEBbT60oFNrd8hmoYMHrTnGo3UyFgUgBZ+UJdut1sV/D5eTOPq/gZw?=
 =?us-ascii?Q?HVjOePkLmAy/kN+3VnSJDsIxmn8EEIZ1GHd1gAb95eZHrF6CJbA3toKJ9GQk?=
 =?us-ascii?Q?x77wQu/1R9iX2N061bLq6dgymGQwcbSwO0b7XdCkPGIka54pTNjlE2hFZHhh?=
 =?us-ascii?Q?Bnz+5HIn9AC2WTB4Fin/c8e5jKaeeMT3oe877295BMdIoNpgkJJ1w4UDo5no?=
 =?us-ascii?Q?u0jMTOx+JkkmliP8rFFiKNWXjBKHawOQvI0rnFc6Cux9ekbmM+5k9Cwm2y5n?=
 =?us-ascii?Q?Qet5BIwrN5PRvG/LrQRLmv1sVIm9N1F0QvzwCfUC/XLG3r0aiTWFQi7N5L3R?=
 =?us-ascii?Q?fMHglFrnLKiBCJAPEfTuR4Y3dZGuAJOZEGFyt0p8EtYzhLSYWTLnrNlUj8C7?=
 =?us-ascii?Q?0zvGxL0oasg5DYeksBPLyD0BOaHi/jAkLK9vrfi2H331p7/XnpesNN+74kfa?=
 =?us-ascii?Q?4w5EaVSnz0fKSqa66xYOginz/2pucyOGnSxHjSMOspIF7XBrHSTMSxr47P9d?=
 =?us-ascii?Q?yzrn6V3f7HhFWa9QhGGyTjyRQljKTq8k6rEJy2tylL6gEsPMxV3rXu9xgn3G?=
 =?us-ascii?Q?tKB3sUxCQWKrRMg6iiZtF8/aopcV68dy+Kkwoc/RU8G9v8tNlxZmmQvTOwTB?=
 =?us-ascii?Q?GN/LDI9WleWenH31yGwE8ADsfPjsu8aqIvxRaNIXrRL/b8Qmg7mMgDQ4QMLe?=
 =?us-ascii?Q?1sz1hV/dTyx0U3p4SJZ+CA00okf/TlgxIVIxQLRxdkE1uD7kCnNAZKAnCrtK?=
 =?us-ascii?Q?4Mgn9trkKbA+tNGH6nqVy7vGzcPsQkAortlV/IgRtdCebq4EXR03lJD28ZoF?=
 =?us-ascii?Q?Z/KGxltCxG9w/15AQ8F9vomcIzSDMHjm739f0csxRWO4bfsDvqr8EzmhSb2P?=
 =?us-ascii?Q?MEMpGC7h8Lw7h4hKWVMMrOcle9omE4lB+y0FM/VxM3zFlIaCGzj3HaeZtEbX?=
 =?us-ascii?Q?2o9ifJM2sc/cRlQLB/ztdeKE0BNR2uPThraUMgEasH+S7CkUbiMn7Wx+Ku+e?=
 =?us-ascii?Q?Hmrj7Mfn8JFcdVI1WNafO6tdpOvuhbn3o81gonqCmIMWXSQkehjOQLCF6rxh?=
 =?us-ascii?Q?BXQRm/pTsNHuN6v6530Lm+eEPnN64JyQrdNnDYl9M0oEL6mw3+R9ANmxe8K/?=
 =?us-ascii?Q?I2RZACJtKOCouDOnVPWl9ck7Mm+W8eFRb28zeYahxs1RB7ELC/8jhhA5KWeX?=
 =?us-ascii?Q?5MPlLWy+QbQej3kyMoiisf91HI/IylH1Ha/HfLh7Erk7P+FPxXBPUMtQ3nWw?=
 =?us-ascii?Q?+SgsSC3DYapAr7nSkgn+meDZumQ9ox9MAh6NLASOU49nJ9P/RpAjgMARYG1E?=
 =?us-ascii?Q?elCX+PdD9JYyJg6DZANm/Iwv6aG3H++obLq5SCHgfJ4NWY6Ydw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3rZXX2hc8yHxpufgKpqebD1+p800DMMSFMikYRRAWCBzcFAb7Tw0kY6ncdVy?=
 =?us-ascii?Q?+CW7t5B6w7rpLscNKBc8qJaaeWME/25r6O3Rs6TiPC0aaComEwBqgkxwGRfm?=
 =?us-ascii?Q?Ozl9QMecIi9K5GcFXPAWB3vbOwdd1paePyUBDIHGeFNCOqg8oon0Aiga2CSN?=
 =?us-ascii?Q?4MZAzX5rbrYIwWYBmNeqtUP9r7RHFclKUMKFYAAoD4yv+zGGAU4KAAFen0tQ?=
 =?us-ascii?Q?hFEXeOg5vOx57dQTeYhSciFoTtuLlFg33103zlhP934ru79X0XmdlnU3boaA?=
 =?us-ascii?Q?FpgWJScKjgkPtVVpm7MHTNEXuOfhtOM0PVqbdRwMDrnTOX+NfjGU9MCxX2NT?=
 =?us-ascii?Q?h1mn5aMD0MciMGM+dbpFdkoZXRnlP+KKwp3+kDKKCzRkNNtoQ+nv6HN7t1Xd?=
 =?us-ascii?Q?9prwNnyyZSacuoR4hwG6rMZvBlyuWmq9YoKlP743aMT6QL6ey+AidegFT4ja?=
 =?us-ascii?Q?gPJGTPbC/LOgYtmfwlghJgky8GvDAOEF8NGbPZc177+hvjeUZdZF2u67EsPA?=
 =?us-ascii?Q?ErF72GyTw6qBi0L4x9WYKVI24yFmJDpNoNvnDhsd0CUG1VLUiJs4l43lr85+?=
 =?us-ascii?Q?05lFZ0t7W73MVVO9/FHlztFSxvBaS3QDxyxoYO4BaYdGZyu0DPZ+75ra224H?=
 =?us-ascii?Q?90XZCN6+l1EfZHlE7Th7966U+Pb6H0wLPQ+ulIo6MCSsCIzN3uDI0sBzsGc8?=
 =?us-ascii?Q?27tmU9uO3Wbaec8Cd8GisRfs2DlY30tM/lH8K0qkT60EcvqunVwtZO3OU4bu?=
 =?us-ascii?Q?RBTNef95kgRvMVe7vvr6mhTbWHek8LopZ9MBHRDyLQoPXYex0R2GVbkWW9BE?=
 =?us-ascii?Q?iYibo/AT1BjOFk8oxNxbccVn9N0XNojjDIx47RWtDBl1Ip4xcKDjc/fRtcYF?=
 =?us-ascii?Q?1PhockpLIEJdukzIx4RjYn0CVt3qe13NC62oFlfZyggERNK/28n6KPVeJicR?=
 =?us-ascii?Q?5w+ydSontKiQBIoQhWNtnEpcz4idpIVoFOb7wbJFwYpmqV0X54uBdzDfl1iU?=
 =?us-ascii?Q?GL0qwfLavFzmu4LyVPFGSerdJBFdhlf7vZP/KXjri7tuI26xgxURXB7nAvmg?=
 =?us-ascii?Q?iovNSNZTZyH93xp0aN1JyEmQz8eHJONPREtG4ULBK47o8nDB8my2vN/saIfL?=
 =?us-ascii?Q?2z0qMlkFAfqcCUPqc1oE9nuFcNksrXFhj7vQwgcreF6Ejl09aB4/jruQ5VNp?=
 =?us-ascii?Q?xbn70cWDvOQqGkCjzpD6VjrfDPQF7pUj0JmkSZd/o/3jv4BUNHrAJviQCU3E?=
 =?us-ascii?Q?VxEBRPkugfbLEmvik6dOyX2AIvi6nRM91puYA26JIdy70xCld7oSsQvRRjtt?=
 =?us-ascii?Q?npWtXUawOiJ5S2d/SjSfLBJU+lKYiIWs7u+Ae11pFHec2D5KcKeog3ejKcFN?=
 =?us-ascii?Q?qrAtQl3zrZeMu+D6L1SbcuauhRM/maL2aQY07T9oVuUjPIS1dVcv95vnjG16?=
 =?us-ascii?Q?qduDn4irsb2l1TpKWzo94mdAz14W9me5qDljyxl9I5rf5ArBw5IAmtOmF2sU?=
 =?us-ascii?Q?Q4fi9Ur/WE+RiRxtyE4QNmDa9q5B5ecDZhy7dqXMX9QQ05YGyKbqP6o+lVu4?=
 =?us-ascii?Q?tocdsRKw8BAa6RxYYA/+Fz5xDzmq8WyYZrw7Qon9Klni5TI4sTm9qEi28FDH?=
 =?us-ascii?Q?T9tACFUTT1T6hyDBRCviEbsf/89wuxilowJoVBW1O/ptfTjidtTl1H4BmrGj?=
 =?us-ascii?Q?Ijpa0Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e28319f9-7cc0-4200-24f9-08ddcb5fecfd
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 09:45:01.7234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNxWXciMk8VB9hb1COpUHrFcqz+8lEw1adhwPzQsl0/1zTy3gWuFmyo4rOO9N+AwcaqnhvUnU2AXPMG8x/H+95cMq3wPnR8Jnbbjj/cbz08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5022
X-OriginatorOrg: intel.com

On Sun, Jul 20, 2025 at 05:11:21PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> - Adjust ixgbe_desc_unused as the budget value.
> - Avoid checking desc_unused over and over again in the loop.
> 
> The patch makes ixgbe follow i40e driver that was done in commit
> 1fd972ebe523 ("i40e: move check of full Tx ring to outside of send loop").
> [ Note that the above i40e patch has problem when ixgbe_desc_unused(tx_ring)
> returns zero. The zero value as the budget value means we don't have any
> possible descs to be sent, so it should return true instead to tell the
> napi poll not to launch another poll to handle tx packets.

I do not think such reasoning is correct. If you look at the current mature 
implementation in i40e and ice, it always returns (nb_pkts < budget), so when 
the budget is `0`, the napi will always be rescheduled. Zero unused descriptors 
means that the entire ring is held by HW, so it makes sense to retry to 
reclaim some resources ASAP. Also, zero unused normal descriptors does not mean 
there is no UMEM descriptors to process.

Please, remove the following lines and the patch should be fine:

+     if (!budget)
+             return true;

> Even though
> that patch behaves correctly by returning true in this case, it happens
> because of the unexpected underflow of the budget. Taking the current
> version of i40e_xmit_zc() as an example, it returns true as expected. ]
> Hence, this patch adds a standalone if statement of zero budget in front
> of ixgbe_xmit_zc() as explained before.
> 
> Use ixgbe_desc_unused to replace the original fixed budget with the number
> of available slots in the Tx ring. It can gain some performance.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> index a463c5ac9c7c..f3d3f5c1cdc7 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> @@ -393,17 +393,14 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
>  	struct xsk_buff_pool *pool = xdp_ring->xsk_pool;
>  	union ixgbe_adv_tx_desc *tx_desc = NULL;
>  	struct ixgbe_tx_buffer *tx_bi;
> -	bool work_done = true;
>  	struct xdp_desc desc;
>  	dma_addr_t dma;
>  	u32 cmd_type;
>  
> -	while (likely(budget)) {
> -		if (unlikely(!ixgbe_desc_unused(xdp_ring))) {
> -			work_done = false;
> -			break;
> -		}
> +	if (!budget)
> +		return true;
>  
> +	while (likely(budget)) {
>  		if (!netif_carrier_ok(xdp_ring->netdev))
>  			break;
>  
> @@ -442,7 +439,7 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
>  		xsk_tx_release(pool);
>  	}
>  
> -	return !!budget && work_done;
> +	return !!budget;
>  }
>  
>  static void ixgbe_clean_xdp_tx_buffer(struct ixgbe_ring *tx_ring,
> @@ -505,7 +502,7 @@ bool ixgbe_clean_xdp_tx_irq(struct ixgbe_q_vector *q_vector,
>  	if (xsk_uses_need_wakeup(pool))
>  		xsk_set_tx_need_wakeup(pool);
>  
> -	return ixgbe_xmit_zc(tx_ring, q_vector->tx.work_limit);
> +	return ixgbe_xmit_zc(tx_ring, ixgbe_desc_unused(tx_ring));
>  }
>  
>  int ixgbe_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
> -- 
> 2.41.3
> 
> 

