Return-Path: <bpf+bounces-54386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA55EA694B7
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 17:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD85C189D1A0
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 16:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7961DED44;
	Wed, 19 Mar 2025 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hDkIPj+z"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5192B8C0B;
	Wed, 19 Mar 2025 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401219; cv=fail; b=tc+ucBLI4dml2cyYDE+eMxsrNBXgZjc5Xmy4Uphg5RQ+yCpJ/DEwWj1j4QWI6K8++XEpAtN/0S0BAdJ4vWw9DpA5EmFzIFG/4dg2TDCflPxtKL929OetZO3XGY68qK+LLr5ZPXEI+0H7SCfdrG6fYNQYqf/kr9RXirOIWBnQ6Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401219; c=relaxed/simple;
	bh=QE2U8SJ2ln/XxgsO62p16uFOYj7kUe3bt2i967APpNI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jZM4+cHxSg6TM0Qxfiyg3tWjWlMxLMUYhScyBD08XNIWDjFOwcALPr+NYSRbEkENPMxCD3JWORiAJDuBE+kmRsaD6Tw+EzO/KrE3G5GWoquDi8GoPdHtXbekmlii1HKZWU1QRmhRVBXD4cPzOdNiswmVW+fkiiqkQ5SSQvPpnj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hDkIPj+z; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742401217; x=1773937217;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QE2U8SJ2ln/XxgsO62p16uFOYj7kUe3bt2i967APpNI=;
  b=hDkIPj+zQs3r4SxaMhfIG9szk6lr7KvJes7IB5V9WV/XzUrrZMISdJkt
   i+YqxPrkdLYl5Hyg0h1UOv7i7XV60BnjfIODzbIPoJtBANGk1tSoI9y0S
   qJgsNpCbpzbcSzGPAj3kOKto3r6EksurAj4lWWYhTmBrlDnbfHU/3EPM6
   O+mJfQqGE1VmlgBYRKGp1UEyHLAVHeRZVTsQi2G3gRyPcNWHJCc2EOSKB
   woWbQKtE3GxiXG1k6tuwEN6v9dZLal3WJyfJ5d5oV1tv+tijik5ATBdkQ
   Jn7SAIlFJSEyxHhfSGzl3MDK2VZ7NewsfZyV7FuX4UOylyJluf84AR79O
   Q==;
X-CSE-ConnectionGUID: RwMlm6hJRLOYOrpzmZpRLw==
X-CSE-MsgGUID: YIIJquZ6RFSWxMA5hdvK5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="68955056"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="68955056"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 09:20:16 -0700
X-CSE-ConnectionGUID: 1pqfRKMTQX6rFMtJ9LjBGw==
X-CSE-MsgGUID: bObcL+3+T5m44JTgZcHDPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="159877009"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2025 09:20:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Mar 2025 09:20:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 09:20:15 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 09:20:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymLFhRNdH9M47NCVpStRtVpVZ/ZqNciG+9pZYV1QZoBEZhmP3mHGgOazaGFBrV7Zxj6R7rxf1JLxm4x676JwmOEsPRGKjhN0id9E1u4mctNT6RTuVaQ1TiFXemN+ZtSAbjqTdgWM10XPj0AQaXOAoCciualuO9ftGrKBn6vvynP9EVsVsyjm8HfZTkjjshVSzfxsqZzj/f6CbwKrVo9/yRCI7f+qmX0jAKVe2IlIFKkK04qqAMgwCYdOLDviybI+Ui7ALliY8oqGsdfT3oM/XnYojw3DgN0+5GUAu0B5tD33ov9xktamuJsm3VQGfOmLtJCxRZyEczAOr62RZasJow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2B3Jyi6Hm08+sK/Ga2u5l0Ah4vmQcBwgAqtbjT5BNZQ=;
 b=NR75z5opXkkClDC4UzyckJ/Gq2yIk62fmlcwA0c4QBVZVF/BG2yofKVE9B4zrTy8mGf4ynckxiuc33VaGZX8HUP5sfQBQbqrnumUCe7ZeiK6BgTBnJ94RwmTLfYo270oCD6tu/AOeD297YQrtwqyRJTdPaFdTVubMXznvl4j826Yf8pbb8HdjgxSrwB3YKYzg4wJj5rL03hPoi206weuu/S222gPV8uAPJTDH9Ap4GsnmO4rpQ/WAib1R3BAxlCpMw6rlpf3QBKQ/pWBhTuMq+woRJEijmGani/bm2p2/B1VFuQ2DfpRE4u3LSWifW9IzXrpTlMiOeuQclfWc9gp6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB8573.namprd11.prod.outlook.com (2603:10b6:806:3ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Wed, 19 Mar
 2025 16:19:56 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 16:19:56 +0000
Date: Wed, 19 Mar 2025 17:19:44 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Michal Kubiak
	<michal.kubiak@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 03/16] libeth: add a couple of XDP helpers
 (libeth_xdp)
Message-ID: <Z9ruoGbEg/4iJG9/@boxer>
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
 <20250305162132.1106080-4-aleksander.lobakin@intel.com>
 <Z9BDMrydhXrNlhVV@boxer>
 <fc94190c-3ea1-4034-a65d-7b5e8684812d@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fc94190c-3ea1-4034-a65d-7b5e8684812d@intel.com>
X-ClientProxiedBy: ZR0P278CA0085.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b82d58b-b3f0-4098-8425-08dd6701e329
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0vGJUNkkC9V6+SdsuQbTGpBgSb/2wiGkYRwRRMBKDFEMmXuZPVoacL2J1VBj?=
 =?us-ascii?Q?NjCZF/lmPMQth9309sInndWuRZiQb+z+iCVtOenoPrtBNYcXpZKQXJuSMFRl?=
 =?us-ascii?Q?CwlwSg3DGgKYOGx6/2SRC63C0ImcjRFzp0t//T0Y31+wFTY3SxbRvbdt+dOg?=
 =?us-ascii?Q?qMGoV+657gWeGHb7PFhNfwoEs6Saq6V8CFR+t28HcIR9lv6iRTLUgYdcH2Rt?=
 =?us-ascii?Q?c0gsA4BqxGQaXbMjUbLwZRZhIzmT9BLgfc1as6UDoxLoGWhj2oX0CYNkGlD2?=
 =?us-ascii?Q?d2C7jOlTw5mp+RrLXDKt1icD2OMYmAEyQlspChl4eMNUaF+ESTblsAEHRgfc?=
 =?us-ascii?Q?EIDyW5njHF1JBO4PxEPmpPq2WWzcHJQL+qJpEe3xznItqVOyoHKGWXXXPAf+?=
 =?us-ascii?Q?a02PV3WYmJ19lpFwDcD1YMsKGcHjonwyM/WfN2IGMr7Cjwvo/sILEJaCAhBi?=
 =?us-ascii?Q?v8VAQWZld6kPetsalHTggU8TzFSg+wL0cR5x38fJNicQwRdSCm4KsRnBHYcM?=
 =?us-ascii?Q?A6YGdJrnhVGq/Iq6JdZLRScnELf9mPCs+xaz73zACN4/SuDINxiZfOwlaEZg?=
 =?us-ascii?Q?c6T0LKmN4lBME+BaaT+h/ylm6HsslVmnnbjaGTB3AlyvcP9JMwWf6lstbpPR?=
 =?us-ascii?Q?mLM4QJ8ZhTHN5vc3rXlIiXgfee2FPLKMGT3F6UXOPJAGdHKv6l0viK4Zegef?=
 =?us-ascii?Q?nExRHrNV62AIn4BEpCLclFn6CkKggfX+TZyOC/yDUixbjGRfE1LtEysDeh9o?=
 =?us-ascii?Q?GQU0ioZQkqvjzcUdOKO74u3onWJ+H+fWZ6HM3r4rc3WnnEys6PyCLl8I4VV+?=
 =?us-ascii?Q?M8gbR43Clq3od4IepJcx/sy7SvpB+nNC4ltgQslSRiMns98OiTCVnszQjxqF?=
 =?us-ascii?Q?pD8LV2H7VpZxTO6UqJVG8+qVA/XS7uwdf24h+3bikEPn5to0+/GyYb/h1dSE?=
 =?us-ascii?Q?2OKfh68leyMW5B+xc5veteO24pYDI843lEOBG8h15YBcItDmMfI/w32K5t0I?=
 =?us-ascii?Q?c6oClRuyIjlwmbFcMfFwPUfMcbvXsLa8wnXi4er5NF68qP/aEzvQeUsoBlJe?=
 =?us-ascii?Q?l813kh5Nz+g1Cv7e0mGuclvkRbHz0IiUn6dLxg23+k4TBm6Zmzbg1xIul4df?=
 =?us-ascii?Q?PWFy5zxIyGha79L0Hm7EPT8dBGKA+/vEM2HE9/ILvLMaauSizH5cXrnpUnFq?=
 =?us-ascii?Q?sx7iXMFd8zgLsN6jNZhWceYhQTqvV7+X/GHSbV2rOoNd4cQuG/YfkmmGnrF5?=
 =?us-ascii?Q?HYPpYCXYvUhoFrSz5k3kBeO6bqRYc8/eKNFB9Vx8eGzWkQFQE/CFjP8P+j0G?=
 =?us-ascii?Q?gB+m1YlbOqOOF+rcD38we5A2ylTeuR4rsJX0RNNd41Z4YHcZs76c5JMi2Fx1?=
 =?us-ascii?Q?IUVu7le0lgoxtmgKFNUnTU7RXdkl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n5g/tBB/W5Ms9iuy8vE049ebInDey88Gktpl0oS29jiWrHq/Ec0XBtm/3MbZ?=
 =?us-ascii?Q?dyRza531O20Nplyrr35Amu1vcHGiBuji5lcTuQ0c6OUlErjzFrA7TxEwFFzL?=
 =?us-ascii?Q?U/bNcctQXreM3NV9vCRDmV1dCT0qyMAr8MZD0y3M76F6F+hSlotOjBajR4/n?=
 =?us-ascii?Q?Ih4wF+g6dA7I+byPMD/rtjViCvesxwXKlDrYm4KQl/oXtrW3fVDJzv31kT9M?=
 =?us-ascii?Q?xcMmfcGUGAIcCgxeFm8n/k5ovqiVj7K6Y+7NOkFFudufTW8dpbELmO1x6RMN?=
 =?us-ascii?Q?c+OsQz8mf2V96i805WLMBacXZXuFeGYIcZeRU+EZf+dtWj8gMPruLheAm2R5?=
 =?us-ascii?Q?1+Y29NIN4GG5AtI0PI4hLPum3PQKp1/aHjRwamHN1umcaHqaGoAPSF8tBHvN?=
 =?us-ascii?Q?zQwY2aqc1Q9ACJxRB4gtCC0zDIcLI0rBEH8uTzeOl0nfJP83gXSZt2PHbFJW?=
 =?us-ascii?Q?9XvssLDoHiDb0mHT0zX2uo363jlau5bJiAFLSPoTJD+x+dMuwOnjSGITmYT5?=
 =?us-ascii?Q?ZPIytDQUpnGk+ujD8K+sezIGlEO8qDGXoRfudBdvNq2bKDcRfASGBpjnuE6o?=
 =?us-ascii?Q?hOUJ0CN1SY2BcdlNf3zS1KplWBIl7D4hsep5jCITdO2pZfGGRPFuH5kRtrD8?=
 =?us-ascii?Q?UeBLPQbqhnqyn7PnbBQbXJgYHeIY1j5/fkKmk4LHTWMpTDIowpDBKf85kV/b?=
 =?us-ascii?Q?/s8eRrbwfVd87XuMr00X67q7dKpwV0Q0fDt+NknGaRfYoYj02IDCM3+9cs2b?=
 =?us-ascii?Q?ppJCyWS7oMOG1Iq7kvLk6EbLVfwy2v66ZcHFsWuiF5t76i+eLTk+96mGRr+F?=
 =?us-ascii?Q?PV94wDrzxSq5c1TQh8UdoYJiUlAqN8GYNWHnDUkTs/eI6qUF8/Cwd85wlnSH?=
 =?us-ascii?Q?qUXJS9Ssvy7ysBZNOVbx4AyX342WusSydC9Ca/IjcfDRARW0/88SbiO9pbpP?=
 =?us-ascii?Q?sVhofe3QMSvUUlSCJU2RqObemn3/urjvpWXjhg6gQ3KmtelUYvViuU2DdC6f?=
 =?us-ascii?Q?HZ10Rir3HTDuArexEnzUtKaeR+AuIXJ+3p5cPfRQjRBhLxjME0qprHx9xZfD?=
 =?us-ascii?Q?/OjUKFS1JzA6g9qZy7HinytWkdshYqfM+yur48dnANWe8ToXbCzWrANk4lwJ?=
 =?us-ascii?Q?bRJJGve2sztnm3c78QD5WaXKCx8zC7Q4Zyw0BnSvtbKy/tR2qfWcHRzjT2+e?=
 =?us-ascii?Q?3GDOL1ydP+HfumNr3+ZCUjaq5G2lTssnxrsEWD5s47HSdS/POxF28jP3bdtY?=
 =?us-ascii?Q?rXLM5MscSWhgEiMKeGDGYZH/2+wGClUK99daIQp2Eq2I5ILZw5xjCoZjXdav?=
 =?us-ascii?Q?1JfI0bF+UXqZSlHM0TJxjabcpqM7Mxm04EiDtPNJLgkRHap7sZFTe+4Xztw1?=
 =?us-ascii?Q?Ae5NwXsW2BRuiSI6NzaI1BgxglKqmDNeOXe8Z/lhZUVXeX2eHQY6VVFW6iK0?=
 =?us-ascii?Q?11pZ6PZMjj6BuffwSEogKx1pXTdDJj91vVgJIVfJkwIIYfIhJF/Og1OAPRbt?=
 =?us-ascii?Q?XDtkIxE6kokyQKsaSQQomPW+NzngwtP4UXlKOvkpAI9AlIhY15249rmoke5S?=
 =?us-ascii?Q?pEvzeRo3qP3f7v4bRoGTfhGwEDnmCxY76IfYTEbyXJBBaRuYh/IucXVVNNGg?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b82d58b-b3f0-4098-8425-08dd6701e329
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 16:19:56.1621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v011LrbORIcmhxDVP9NenAgKO/JC9+swuFk3m/CyEraZAGetyhqs+E/m/7pQg/RORj12yIZmjV4zodQbmidP1h92bUD9vZiviF4Y4Jnhrgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8573
X-OriginatorOrg: intel.com

On Mon, Mar 17, 2025 at 04:26:04PM +0100, Alexander Lobakin wrote:
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Date: Tue, 11 Mar 2025 15:05:38 +0100
> 
> > On Wed, Mar 05, 2025 at 05:21:19PM +0100, Alexander Lobakin wrote:
> >> "Couple" is a bit humbly... Add the following functionality to libeth:
> >>
> >> * XDP shared queues managing
> >> * XDP_TX bulk sending infra
> >> * .ndo_xdp_xmit() infra
> >> * adding buffers to &xdp_buff
> >> * running XDP prog and managing its verdict
> >> * completing XDP Tx buffers
> >>
> >> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # lots of stuff
> >> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > 
> > Patch is really big and I'm not sure how to trim this TBH to make my
> > comments bearable. I know this is highly optimized but it's rather hard to
> > follow with all of the callbacks, defines/aligns and whatnot. Any chance
> > to chop this commit a bit?
> 
> Sometimes "highly optimized" code means "not really readable". See
> PeterZ's code :D I mean, I'm not able to write it to look more readable
> without hurting object code or not provoking code duplications. Maybe
> it's an art which I don't possess.
> I tried by best and left the documentation, even with pseudo-examples.
> Sorry if it doesn't help =\

Do you mean doxygen descriptions or what kind of documentation - I must be
missing something?

You cut out all of the stuff I asked about in this review - are you going
to address any of those or what should I expect?

> 
> > 
> > Timers and locking logic could be pulled out to separate patches I think.
> > You don't ever say what improvement gave you the __LIBETH_WORD_ACCESS
> > approach. You've put a lot of thought onto this work and I feel like this
> 
> I don't record/remember all of the perf changes. Couple percent for
> sure. Plus lighter object code.
> I can recall ~ -50-60 bytes in libeth_xdp_process_buff(), even though
> there's only 1 64-bit write replacing 2 32-bit writes. When there's a
> lot, like descriptor filling, it was 100+ bytes off, esp. when unrolling.

I just wanted to hint that it felt like this feature could be stripped
from this huge patch and then on of top of it you would have it as 'this
is my awesome feature that gave me X improvement, eat it'. As I tried to
say any small pullouts would make it easier to comprehend, at least from
reviewer's POV...

> 
> > is not explained/described thoroughly. What would be nice to see is to
> > have this in the separate commit as well with a comment like 'this gave me
> > +X% performance boost on Y workload'. That would be probably a non-zero
> > effort to restructure it but generally while jumping back and forth
> 
> Yeah it would be quite a big. I had a bit of hard time splitting it into
> 2 commits (XDP and XSk) from one, that request would cost a bunch more.
> 
> Dunno if it would make sense at all? Defines, alignments etc, won't go
> away. Same for "head-scratching moments". Moreover, sometimes splitting

maybe ask yourself this - if you add a new ethernet driver, are you adding
this in a single commit or do you send a patch set that is structured in
some degree:) I have a feeling that this patch could be converted to a
patch set where each bullet from commit message is a separate patch.

> the code borns more questions as it feels incomplete until the last
> patch and then there'll be a train of replies like "this will be
> added/changes in patch number X", which I don't like to do :s

I agree here it's a tradeoff which given that user of lib is driver would
be tricky to split properly.

> I mean, I would like to not sacrifice time splitting it only for the
> sake of split, depends on how critical this is and what it would give.

Not sure what to say here. Your time dedicated for making this work easier
to swallow means less time dedicated for going through this by reviewer.

I like the end result though and how driver side looks like when using
this lib. Sorry for trying to understand the internals:)

> 
> > through this code I had a lot of head-scratching moments.
> > 
> >> ---
> >>  drivers/net/ethernet/intel/libeth/Kconfig  |   10 +-
> >>  drivers/net/ethernet/intel/libeth/Makefile |    7 +-
> >>  include/net/libeth/types.h                 |  106 +-
> >>  drivers/net/ethernet/intel/libeth/priv.h   |   26 +
> >>  include/net/libeth/tx.h                    |   30 +-
> >>  include/net/libeth/xdp.h                   | 1827 ++++++++++++++++++++
> >>  drivers/net/ethernet/intel/libeth/tx.c     |   38 +
> >>  drivers/net/ethernet/intel/libeth/xdp.c    |  431 +++++
> >>  8 files changed, 2467 insertions(+), 8 deletions(-)
> >>  create mode 100644 drivers/net/ethernet/intel/libeth/priv.h
> >>  create mode 100644 include/net/libeth/xdp.h
> >>  create mode 100644 drivers/net/ethernet/intel/libeth/tx.c
> >>  create mode 100644 drivers/net/ethernet/intel/libeth/xdp.c
> 
> Thanks,
> Olek

