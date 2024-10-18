Return-Path: <bpf+bounces-42397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B25E29A3AF9
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 12:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E191281553
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 10:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08762010E0;
	Fri, 18 Oct 2024 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FNdfsWPi"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9E2188A18;
	Fri, 18 Oct 2024 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246235; cv=fail; b=nBUxMw0H4XEYUKPHHsMyimbszg3VljpWgU7mjG6mUINmy8BO8MgDMLq5Fj0trKiqS2OgnIgpJuHJ41ANT/8jqg0FWH7+SrZfEjM2k+lHv0fnO/4yPBhLvZ+FizIxFjkA4KmFRF/dqqZsSAJ5WZSA233rdoIR0UgHib2FaKBST88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246235; c=relaxed/simple;
	bh=WNPE3alNqZPd8jkGjAYBoe/wvF3XlGTdNhU2YJylUaU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a5ot0tePLo39ZJw6hNTBsMUlTo1LGBnzBp98zYw/d3a31y4YsCbUS8gXKjpIJyRBMY99+dNlxMdnzYsKpD2nEo7U1TOdNj8FXOAXSYO6tZ3/RudGskQiRA8BCfA8o1RdV7tI76oEnx4UB7q53c4w1bnJfMjgObRMonZ06YxJJPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FNdfsWPi; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729246233; x=1760782233;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WNPE3alNqZPd8jkGjAYBoe/wvF3XlGTdNhU2YJylUaU=;
  b=FNdfsWPiH48/qxPl/utpH6SM1LpwTSdo1HmKskTmWfydPk+MnxSs5Jqy
   sOMi5qkKcWj+BMVOHiwIDsviFX3h+qm+CV1yANH/piIwwQvuO1LhQDQay
   iMJt/q763RaNPThTqlLlzVESqmwW0eNlrnZ4Gv7ouinubOM/QmhAsChBK
   Mcli3HDM0aepeItHqqJmnw+22TVlsBThPFxD7EZf2aCSOdAXBY93m991l
   9CATjfetPzRyJzMjeuh9Gqm9JYyN3/IM39CHaKxfFLpC/aU3N06oT/NNF
   RLGKbBE2KiIXo1GZqKzSYKvYHNAD7r3RIJU1F50eGhqBRy9zj1g40FTVM
   A==;
X-CSE-ConnectionGUID: NwiwQpkbS9298ed9wAwZSQ==
X-CSE-MsgGUID: s65BuhmeRE2Pow0A3WahTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28236231"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="28236231"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 03:10:33 -0700
X-CSE-ConnectionGUID: HtLiJ4dGQC6j/wIluqRoYA==
X-CSE-MsgGUID: m21gl8DnRxCjYIvLh2L21g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="82797562"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 03:10:32 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 03:10:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 03:10:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 03:10:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOk3MjGXwU1/7fBTeiQTJUx5WKg/sX5cygktSyHpiwTGV+DDpElIaXa1DA2kN3wAzuCJzVWaNAWxh/CzXCOs6PxTbQ/TdYAZTXuIG0LXIpUh4e4iVSsAQutqCbNZ/wIF8v2w2DwIYhIjhuOhuH4jroN3fjRAzvQO0CXlnkG6O9Gl7+2Q2xCcGt9ygWqrgMeheNgAdpQ3aswn82WZ31K2xnonwX8w3L/v6yDRQAQCE7tYUg7zIk6HMhTNRpBjjjKIVSBV0pZRZWgKaTKggK47/2zwpDxH3nTN1DWPZ3yJVQUJgDyhJrMTIC3tsPPk1uOnFSGM2yEt7eScj4Ptzp0zuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7D+ZlaVU5gzhO57aonfJvmoixuqv/1nw6lsO/bwuO6s=;
 b=UuqSMfcKoKAuDC8vPxmSAVgo/n9duoscHUs2kTyIRPwn6kAvgEdYXud71qLzv4ZYO7MmCYpVB0oXfFETl62WxIIKUoAeKpCxONM8ZChOySeiI1+alCvNoB3LYLkb+9rv/ZbyRUkqzFETtDilI5RB1Yr+3rRfG5D4xAws2Iv87VKP10yfUqcKXkuXDuWb3dLxQCtkMh9TvAl9hKPOjMofOGj116/fVLDGkrc5GrORRQ5mJHpoF8JUQrQ0TEyiJnXTYwCIsk6XSFenH6QCWq7i/XpoTqvYPEqriuexy0SAjZjmmY8Fx6qXoHOjht6Zbd2aEiSQ26RUkpVpoNVnVoZvCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CO1PR11MB4802.namprd11.prod.outlook.com (2603:10b6:303:94::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.21; Fri, 18 Oct 2024 10:10:27 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 10:10:26 +0000
Date: Fri, 18 Oct 2024 12:10:19 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	"John Fastabend" <john.fastabend@gmail.com>, Richard Cochran
	<richardcochran@gmail.com>, Sriram Yagnaraman
	<sriram.yagnaraman@ericsson.com>, Benjamin Steinke
	<benjamin.steinke@woks-audio.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Sriram Yagnaraman
	<sriram.yagnaraman@est.tech>
Subject: Re: [PATCH iwl-next v9 0/6] igb: Add support for AF_XDP zero-copy
Message-ID: <ZxI0C/DOY/o8nyzT@boxer>
References: <20241018-b4-igb_zero_copy-v9-0-da139d78d796@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241018-b4-igb_zero_copy-v9-0-da139d78d796@linutronix.de>
X-ClientProxiedBy: WA0P291CA0024.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::26) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CO1PR11MB4802:EE_
X-MS-Office365-Filtering-Correlation-Id: d29b4fb7-fdea-4542-c590-08dcef5d1668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h/HZXe5TmOaldbKD84hkr3sPjMS7K0PuLsNvJ9hYxXkxo0BneRoHCaOwnfHF?=
 =?us-ascii?Q?/qIkWXuXy8Qi3mL/RkLCCy/cDcHx4E9mvEEUJzkTcGqyGyoZQU6rNsMsCPW/?=
 =?us-ascii?Q?Fi9X0VOvInxktREEoV0iCdvAc58K6gTu+r5jk8elOivDXzhGdq7/Pmb2rGl0?=
 =?us-ascii?Q?qf3t5E5nNykEv5Ha3gw0vH2vTwfxZDgtIVBLRbLFaf3M6Oo8MTdw1cQb2Q4Q?=
 =?us-ascii?Q?VQym4SB693qmtBC/6NaJMNIwJ9Je4E+avutjunIzVhWNiXe9NPp7trjsJARU?=
 =?us-ascii?Q?V6g+PoVkyQmTaYJlfUQfmvfK5lSKTmHtDvjPLCq6kpRDfVmSMZ8m7dteqeap?=
 =?us-ascii?Q?i1NNTfDMVOztfRJLTM52+dacvouRPjab4yzQ4U5KF2wOSNgtGaB5vWcSAHAI?=
 =?us-ascii?Q?9CxjXhzgzpYP4y1lcnj3yz3zZKBAR1Lgox1/bgJukYuIU2Os5qF/RFhENUa9?=
 =?us-ascii?Q?zDlZ4bdpRW60xb8d9Fv8ebV/59dKgO+Pl6AJ5ePuX+lXRLG6QSJniSXiG6sg?=
 =?us-ascii?Q?1/CHRq7DHF2r4+S2CJCzz4b/NO3folEfY1Zg7U2qrQrJuLYZkCkTkYTQQqG/?=
 =?us-ascii?Q?/4RjrZbQAkuQk6DeSDAIpANJuTisJmo4hMfuJxxK+YSxWBgKzqg/bR9Kl7QV?=
 =?us-ascii?Q?ol+YdswnsdoZKQoUb4Yce816FtiDCXy/hmbh3XDoltdAVb3kr4OtJu+AdC2J?=
 =?us-ascii?Q?Dzj0JBFxLSEBLsSbegXFhl9hk0MrPobxfSJNzH9v3LAB2vkwWOBnnkTLOq56?=
 =?us-ascii?Q?JuqzZ42+hOiAKc3+13xd9SLLnImWZVEAhP7X7Cqvx4n6nYdbonOJz1TU7Swq?=
 =?us-ascii?Q?Hb0Yp+eV96cn1a2qrV3/5EaHTTRbd9a7dNKg7weRq5yaInVE2rMqorXAbpQ2?=
 =?us-ascii?Q?trbGTVAgo/2F7pMT3esWHTMxzY6YBbNox7i7FuHqoxUjKVzQXQ2OY95BttVR?=
 =?us-ascii?Q?TSwXziVV0BRplCVT4ihRvD66jEhvhp7kYwjKbTxHUTdUOa7D6Dm3LaqUGCt/?=
 =?us-ascii?Q?stptdfb9j8kzBhzgBj1h/STqN89EEAsHxY5lIvr4k6uarH3NR+TmOf6vsuDb?=
 =?us-ascii?Q?3Pr1ZYa+USz3H6U59aAZ/4Re0MrYZLtC5db/QpH0spVmZwZ0yTHrAl/dBTh6?=
 =?us-ascii?Q?MpzaFX09ObyDEVigWmtK1mIWGlBif5QxEfwIl7+Sl8LrLOGpiITkntIAryEL?=
 =?us-ascii?Q?Wyodd7qgqMvNh9Ge5nycKsfjUW0VwM1IH+Xa1PH43dirY6AySMDdTxQ6lPBa?=
 =?us-ascii?Q?l1bEHtB6r79Oz75WBOKGp2kExmxszdEttynyBTh00RgGrKM2DCd9I4kHhaKl?=
 =?us-ascii?Q?minnSXI9OHUGFToIYPxoLs2S?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c5SfwfPFmNFX5KEF/H73U+PqrDsDar6IvjfylvORg/F5RP5oApJJUbeI0HSl?=
 =?us-ascii?Q?rh9BZkWvfGts9taBN7hiEBhEf6zR7xjlZR3ok5gj+yWFc4gP0bCI55+bLqzZ?=
 =?us-ascii?Q?GNT75+NIoHtgn+R3leYcI/YLa079oXqz8d349GarI3Bq63BqJG7P5/9/q+I5?=
 =?us-ascii?Q?fKST1+6gpaiDDrxaErHOdf5RDw0y9Z/NU9y6m3LAA1HMDMdqQ5u/r+qXXbkj?=
 =?us-ascii?Q?/TLtwVpuCL9VSM/NNAb0k23u9jkNVwPlhaQHoAM74kQgGNtbPgA6dqCMg2xH?=
 =?us-ascii?Q?qUiyLVm1ezTWJoprzrP6kCxdwSQCMxNYlMGBoVlSZ9IRWUxSO0oKxl+46DoR?=
 =?us-ascii?Q?wf7jgk8rJejMKbGufb87usterOWEetH80Q2hB3rk6tSgDumiInC0SgV0n37Q?=
 =?us-ascii?Q?761s7kyv3Uy3V4Gb9KT8TfAo1eGVcBthnSNeDciMYo6QWnI9LVbjyVXZsfWA?=
 =?us-ascii?Q?0Xhobaquh0Zh5Lt5JZsFEKysqnnCmdqILDCzb4ZtwByj4OZGqTllCS53rieo?=
 =?us-ascii?Q?3tBCqymC6Esydjl3uEzqGZOo3/0UgtHfI0cp12/MOj0vkk64YbPXjQyPsI1f?=
 =?us-ascii?Q?gxC5OoCHYvjSCg3zOCdd15XZIXnHJo1gThSAYHs+566akqVsiYpHeoVzwxXL?=
 =?us-ascii?Q?AoREX2SNCBkcSdxwUFWAa9HQhWdoJ/1faZp5D4KOod6eiMa6X+OdTgzIH8Xe?=
 =?us-ascii?Q?inMQlZg0XWNOFI4ysXzij5Ouf5eh5fF2nkbjvU9fVxWPXSu8wa5ISxTbCMMv?=
 =?us-ascii?Q?YkwYipUgqRNgVRTr0bBI2aeE62UdRaHFMtc4Vzd9ZvLFiqfg6w0pNyw41uEr?=
 =?us-ascii?Q?TyWIckvY5rJaA31VXt1zuX/H3SNRS0kH1bG++rGPUaCZ56kMss0tZ7G11ogt?=
 =?us-ascii?Q?wzzoUXD/UvHfk/KJaVNKYNrkobHV4t5d3Tcqjiw3aOeskMQTJLXp8TlNAuYj?=
 =?us-ascii?Q?8LK/YZYu24eBrVmf+ohmhoIEzAlHcoDfH06SHY6WDlijlKXJMEL4qfhlLzgW?=
 =?us-ascii?Q?zIl5MLZbDlLzuiKOl28K7T52lblbRwvp2rRjV82S/Cjp/4oG4JRFdcDVzu+U?=
 =?us-ascii?Q?/nmDM+Kk0dXmmFWiWP9T69IlUVG89NCV322qJazWYPH3wOrSQMiwi+j9xwuk?=
 =?us-ascii?Q?1zERTWHQM8zlWR/ZPa7TfBsNhzE5F0dC1mLu14iv7ar3YtwBtZp8HxtltiKu?=
 =?us-ascii?Q?7VQYJLaCGL2Y69CmnRnszDgF0VYBK6+O903wzYSgCieaTEdnIJrZ9noMFUxI?=
 =?us-ascii?Q?xdaz898lV/StPTAwTJ2y8PhZ8FXxsELhvfwJDCwhcpMSi23rhRB+BryGwdF8?=
 =?us-ascii?Q?+lv+tBzz2cCE3LcpWrzQDdwshUwZGAVgvYYX8n73rU+WIAuwhzn0HJtBrtlY?=
 =?us-ascii?Q?pZb7dRbQzVb0voELK2ZLSLtsvPX48yFlTfP/QFCKCUCF9YpedagDt1NntKSX?=
 =?us-ascii?Q?2w+I9WT03XLE+Bvhgser0oHpIXN0No0GC3F0eLaD0iJKuun2eO2BaYYz3aOI?=
 =?us-ascii?Q?ZP5MALfl+Hr08Enj3z/7Eu6I/fu91xdcMWqnyRoaZ7SY5ryim6fpJ+oHi2Zy?=
 =?us-ascii?Q?otqYvRvFH1pAJFW3nfK8bXenKNM7O8dcZkvjdYzW9gfOlJ00InmFam90N640?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d29b4fb7-fdea-4542-c590-08dcef5d1668
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 10:10:26.7836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3G6b6/c0YGbpC3GsPlJW+EjFnbxM3NUjSJK9/L65AXMum4hQriOiZtFEiVc6yTCIDSlboAkZGQWlZnGDO+0OuKitYffNdUsmT60fbovYb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4802
X-OriginatorOrg: intel.com

On Fri, Oct 18, 2024 at 10:39:56AM +0200, Kurt Kanzenbach wrote:
> This is version v8 of the AF_XDP zero-copy support for igb. Since Sriram's
> duties changed I am sending this instead. Additionally, I've tested this on
> real hardware, Intel i210 [1].
> 

From my side the series is good to go.

> Changes since v8:
> 
>  - Collect tags
>  - Pass read once xsk_pool pointer to igb_xmit_zc() (Maciej)
>  - Change return type of igb_run_xdp_zc() from skb* to int (Maciej)
>  - Link to v8: https://lore.kernel.org/r/20241011-b4-igb_zero_copy-v8-0-83862f726a9e@linutronix.de
> 
> Changes since v7:
> 
>  - Collect tags
>  - Split patches (Maciej)
>  - Use read once xsk_pool pointer in igb_alloc_rx_buffers_zc() (Maciej)
>  - Add FIXME about RS bit in Tx path (Maciej)
>  - Link to v7: https://lore.kernel.org/r/20241007-b4-igb_zero_copy-v7-0-23556668adc6@linutronix.de
> 
> Changes since v6:
> 
>  - Rebase to v6.12
>  - Collect tags
>  - Merged first patch via -net
>  - Inline small functions (Maciej)
>  - Read xdp_prog only once per NAPI cycle (Maciej)
>  - Use u32 for stack based variables (Maciej)
>  - Link to v6: https://lore.kernel.org/r/20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de
> 
> Changes since v5:
> 
>  - Rebase to 6.11
>  - Fix set-but-unused variable warnings
>  - Split first patches (Maciej)
>  - Add READ/WRITE_ONCE() for xsk_pool and xdp_prog (Maciej)
>  - Add synchronize_net() (Maciej)
>  - Remove IGB_RING_FLAG_AF_XDP_ZC (Maciej)
>  - Add NETDEV_XDP_ACT_XSK_ZEROCOPY to last patch (Maciej)
>  - Update Rx ntc handling (Maciej)
>  - Move stats update and xdp finalize to common functions (Maciej)
>  - "Likelyfy" XDP_REDIRECT case (Maciej)
>  - Check Tx disabled and carrier in igb_xmit_zc() (Maciej)
>  - RCT (Maciej)
>  - Link to v5: https://lore.kernel.org/r/20240711-b4-igb_zero_copy-v5-0-f3f455113b11@linutronix.de
> 
> Changes since v4:
> 
>  - Rebase to v6.10
>  - Fix issue reported by kernel test robot
>  - Provide napi_id for xdp_rxq_info_reg() so that busy polling works
>  - Set olinfo_status in igb_xmit_zc() so that frames are transmitted
> 
> Link to v4: https://lore.kernel.org/intel-wired-lan/20230804084051.14194-1-sriram.yagnaraman@est.tech/
> 
> [1] - https://github.com/Linutronix/TSN-Testbench/tree/main/tests/busypolling_i210
> 
> Original cover letter:
> 
> The first couple of patches adds helper funcctions to prepare for AF_XDP
> zero-copy support which comes in the last couple of patches, one each
> for Rx and TX paths.
> 
> As mentioned in v1 patchset [0], I don't have access to an actual IGB
> device to provide correct performance numbers. I have used Intel 82576EB
> emulator in QEMU [1] to test the changes to IGB driver.
> 
> The tests use one isolated vCPU for RX/TX and one isolated vCPU for the
> xdp-sock application [2]. Hope these measurements provide at the least
> some indication on the increase in performance when using ZC, especially
> in the TX path. It would be awesome if someone with a real IGB NIC can
> test the patch.
> 
> AF_XDP performance using 64 byte packets in Kpps.
> Benchmark:	XDP-SKB		XDP-DRV		XDP-DRV(ZC)
> rxdrop		220		235		350
> txpush		1.000		1.000		410
> l2fwd 		1.000		1.000		200
> 
> AF_XDP performance using 1500 byte packets in Kpps.
> Benchmark:	XDP-SKB		XDP-DRV		XDP-DRV(ZC)
> rxdrop		200		210		310
> txpush		1.000		1.000		410
> l2fwd 		0.900		1.000		160
> 
> [0]: https://lore.kernel.org/intel-wired-lan/20230704095915.9750-1-sriram.yagnaraman@est.tech/
> [1]: https://www.qemu.org/docs/master/system/devices/igb.html
> [2]: https://github.com/xdp-project/bpf-examples/tree/master/AF_XDP-example
> 
> v3->v4:
> - NULL check buffer_info in igb_dump before dereferencing (Simon Horman)
> 
> v2->v3:
> - Avoid TX unit hang when using AF_XDP zero-copy by setting time_stamp
>   on the tx_buffer_info
> - Fix uninitialized nb_buffs (Simon Horman)
> 
> v1->v2:
> - Use batch XSK APIs (Maciej Fijalkowski)
> - Follow reverse xmas tree convention and remove the ternary operator
>   use (Simon Horman)
> 
> ---
> Kurt Kanzenbach (1):
>       igb: Add XDP finalize and stats update functions
> 
> Sriram Yagnaraman (5):
>       igb: Remove static qualifiers
>       igb: Introduce igb_xdp_is_enabled()
>       igb: Introduce XSK data structures and helpers
>       igb: Add AF_XDP zero-copy Rx support
>       igb: Add AF_XDP zero-copy Tx support
> 
>  drivers/net/ethernet/intel/igb/Makefile   |   2 +-
>  drivers/net/ethernet/intel/igb/igb.h      |  58 ++-
>  drivers/net/ethernet/intel/igb/igb_main.c | 248 ++++++++-----
>  drivers/net/ethernet/intel/igb/igb_xsk.c  | 562 ++++++++++++++++++++++++++++++
>  4 files changed, 787 insertions(+), 83 deletions(-)
> ---
> base-commit: 283f6fbb370dc1adf455be5d5ac41d58d215fd8b
> change-id: 20240711-b4-igb_zero_copy-bb70a31ecb0f
> 
> Best regards,
> -- 
> Kurt Kanzenbach <kurt@linutronix.de>
> 

