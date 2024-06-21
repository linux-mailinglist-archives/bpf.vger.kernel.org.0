Return-Path: <bpf+bounces-32705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976CC91203F
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 11:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF361B21139
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 09:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EC416DEAA;
	Fri, 21 Jun 2024 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nMaoMQKQ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADAF16E873;
	Fri, 21 Jun 2024 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718961223; cv=fail; b=EeipV4dlPv3pmhRkZXeIbTOOCqz8MdPG36mDWcZY5a76IJO3AIh07XWvzyQ+yXfHCSclNaIK8b+oseZTD77kwam2VgcFcohEjLfL7o7vKIMPsydyz8Y2HmZEWumgIsA7XyeikgF7/dBhiCnX3o9x7WQ5vUaZWsbmsyYABflaBHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718961223; c=relaxed/simple;
	bh=Exacec26OovYsLTTmY882KKCdRx+t5jkzeDaeKnrphg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lyEumGIfufOOUfi+S2I8oXn/s92n+Q1vWdINcoN5lO7DnERKpVn3nl9UkWsbJWmqWhIT+1TRGWN/bm5SFLkJExuvwwhvx/1y0/Yzj/vVKm8IXykfQbd3KolElFky667vJ7BMtxPqLByZhlTn0LzTIiJwVrvE+7NDMQsIXUlVFFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nMaoMQKQ; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718961222; x=1750497222;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Exacec26OovYsLTTmY882KKCdRx+t5jkzeDaeKnrphg=;
  b=nMaoMQKQFziu+jBlr5OwpXbIJNtkBW+0FfsLjedR+H2W60OGcNYOduP3
   anVQfWxWTKiU5GbH5CQgH3K1x6aXeYXM+HKll/VH4yf4ckN5tTZbUr1Z3
   HpIYyTSjxBH8LjQmKzSpqOt1lOuhTx7FluFDovGUm2HQgzgkpoPI8LweZ
   sdhm3Sd7Dvsko6xruumU+6oYNa3kwfkpCEni0Wy/VhIPn4jjfKUN6UIvD
   ppgfjNme9OPjbBTTN1Z4l5fXPrijtxoZxytBWDrXhx7OAm3Zrcu2ZAMB7
   Nq4adDvBtcmLAR19fDOm40YYQUS8yf+Fohj+9imjyTvoh7aof+587vSrD
   A==;
X-CSE-ConnectionGUID: q4r4hB/NQv+rl8fxxr3izw==
X-CSE-MsgGUID: GMwYMSTZRf2kJ59ZmczaNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="27123673"
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="27123673"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 02:13:40 -0700
X-CSE-ConnectionGUID: smq6KV8kRiKUMIQhmAHNrA==
X-CSE-MsgGUID: npHfyjFEQJGX4P9vs4RI/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="43201229"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jun 2024 02:13:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 02:13:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 02:13:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 02:13:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 02:13:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWLBs/O+SzuBh7SvOE1ZRzxKxRXp0dmbSC4i8YZuCF3kxAjw6I1vadPs4XhAurK8Wdv7pF2XK6OKgpFTDqV971s4VoHaWeENFSKzZXsyQnh3eP9lqJ5/6tEgHrRz626XMBnPbbMGHZg1JiRbDaiidO+QyCxZqp0G4S8bZ36AQQHzctLF7okG4blSZK5Io+srw09fUWo6TS0qlFsCh5o/gLv4fawE40tgchxBnJoSHu4NF6xZsr0nVXVTTPGJSrkSzUjY1Cu5yMDye7F3NEwFoMB6tgPWQe5ofnMYv0NIL0pt/UOaW8ivvB5c+f7fu6oTuEokxSdz9WnEHn1rRjU+CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+V4lst5dCoogYg81Vch8qwsf8VyyJhehTmliF3y95go=;
 b=IugtAILjRIXPnIVuvZ64WjRc7lduUxjEyHxFxhguik5K7boepg/kNOpI4+DG3quq4ajpQyzIPRj3bup3fTR+sqv7PGT50dZrLqYhXWygv9OZQTbfxxtBSIDgti8kYtdmD8O1LwgIQ+Sf/Rhr6N1gJ1fYCS/IjJtY26nKexvL/2Iw/bd8YPLEmIVmozAQ7H3ZwNiusEFonT/H3G9g/b0weqMKIPvVHYYPjcfMhtskjIXsZXq5t8MuUU9oRBH1m975C8hwpfRqmdorHoRT00QOmaAv6KPmhoSs4kHkGM8sYPOYb+1IUX+awJifkMN4pP6xJQjdUoms6S4ECBDySr4itA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB7832.namprd11.prod.outlook.com (2603:10b6:8:f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 09:13:32 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 09:13:31 +0000
Message-ID: <17c0b83b-b3f4-43c0-be3f-d72a56e4087e@intel.com>
Date: Fri, 21 Jun 2024 11:11:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 1/9] skb: introduce gro_disabled bit
To: Yan Zhai <yan@cloudflare.com>
CC: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, "Mina
 Almasry" <almasrymina@google.com>, Abhishek Chauhan
	<quic_abchauha@quicinc.com>, David Howells <dhowells@redhat.com>, David Ahern
	<dsahern@kernel.org>, Richard Gobert <richardbgobert@gmail.com>, "Antoine
 Tenart" <atenart@kernel.org>, Felix Fietkau <nbd@nbd.name>, "Soheil Hassas
 Yeganeh" <soheil@google.com>, Pavel Begunkov <asml.silence@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
	<linux@weissschuh.net>, <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <cover.1718919473.git.yan@cloudflare.com>
 <b8c183a24285c2ab30c51622f4f9eff8f7a4752f.1718919473.git.yan@cloudflare.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <b8c183a24285c2ab30c51622f4f9eff8f7a4752f.1718919473.git.yan@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0054.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::17) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: f47cb081-45ff-4127-ef5c-08dc91d26b47
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|7416011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2ZJVXczY29oeUIySWhPM1NUT3VrRncrUlpRaDl0bmw1bjZ4UGpYWGR5Wkk1?=
 =?utf-8?B?cjZSSXNldGQwamRiRmFoNHkxNVVSY2VTWHNZdkE0bjdlOFU2aXFUTHdSQ1hl?=
 =?utf-8?B?Z0NxdkdVQ1llMGM5N0VaYmN5N204NDRta2xLbGhsOW16M0FFSVp4RGdBSERJ?=
 =?utf-8?B?cnBYelZzeFdDRDE2ak5jSVVFdkFDL3lCR1l1dWlIQmpTc0pWcWI1QUp0Tk5k?=
 =?utf-8?B?TklnckhxSzNOM0dCYlhoY3VoOUFhaVJTNTUwMkJhVVd3QTI1OHRidUlYU1dZ?=
 =?utf-8?B?MmVuRlVwM3lDN0RRcjdZRkM1NS9LQXluckIveHlzbk4vemc2NkdhcWljbjBo?=
 =?utf-8?B?cmtJOXQwVHNFZFBOVjJGei84NXBJcE1sbnJRVWt3cFQ5Nk5kbHdzN3dlVmo4?=
 =?utf-8?B?d3QvV2w0YWg3RTc5cWtXY3Vad0dzUmRqWGNYQ204bXBGb1FMWTVHNndxR1Y3?=
 =?utf-8?B?OUtPRjQva0pHZHlSbWxqcko0TGxEdk1mYzFXRngrY2ZzWldlQXJ6UmlFTWZt?=
 =?utf-8?B?cTkvb0M0SVFnckx0b2x4WlNzRTZ6S3VGUDlvN0k3WmZ5OEhZM0xlVmpJb0FJ?=
 =?utf-8?B?WFM4RGtqVllpSWtLRVBWV3N0T2xGMVhId1piNDVOMGZCb3gwMEhFNENSdXl3?=
 =?utf-8?B?Z0VDZnBTd2wrU3VsOEUzc2lOU0dNSm4xK2dzVHN1K1ZVWWxQT3JWWWRDOUpC?=
 =?utf-8?B?Wlp6aXJQZGNYbU5GTFhIeHNwMVNmcjh1dDFVMkZTelVLSENDNUU1TmhUcFRw?=
 =?utf-8?B?UGdWbGpBSzRXR0FyN1dRRjBydzFoblAveWZIeXRYM2VvU0o5T2U1ZHJYQ3Bt?=
 =?utf-8?B?b0tzenM0RUQ0QXVpNFBId0dlWGlyOVJsQS95cllzQi9XYlp2UjVYSzhnS1Fn?=
 =?utf-8?B?djM0M2E2bVI5UzFjRGNnZFpJMXBkWGREU3ovbksrek93c05DUEw3djhua01x?=
 =?utf-8?B?WE9RcUh1Z2VYc1Q1eThIRHlqMVVMb2E2T2RKa2hPTmtGSHVuVGNFTGpRYkdK?=
 =?utf-8?B?ZTBEcVBDS1loNTdJU0JxM0ZhNXV0ODBzdHkrakhBa1FtL05ZZHg2b2l3RjRL?=
 =?utf-8?B?Q3NYbUdqZDdyc09zaU9aeEFHL1BUT2twSldYSmM1eDczODNzQTNpOHpRYmlo?=
 =?utf-8?B?Q3g4U3p0Sng2MTVzVTRBUCsrQmgyUURtanlDSGt1aFlFanAzVzhZekRoK2Zy?=
 =?utf-8?B?SEtEY0JZaUQ4czk3N0o1bng5V092OHBaR3RIdUY1N2VKU0tsWGhzNXpGR29Z?=
 =?utf-8?B?Y2dzc0t3amVKbVFNWWFnb0VCN253OFAxSnFDdGduWDR3LzdkcHpjTi9ZZlN5?=
 =?utf-8?B?YTgzejNKVUh2L29nTldRS21EOWNrU3JTclVzMUpYUVVxelJMcVFrNnh4YkMw?=
 =?utf-8?B?Z1lEQVFvcnUxR2RHNzdNWmc4eExCVHJ2bU9uYU9kRUgzclhKb0tuOVA3YWZm?=
 =?utf-8?B?K1g1U0QvcXRBdFQrWWJ5Tm5BL1E1d3hWNW8xZEtEOVN4SmQza01VdGtNRTRy?=
 =?utf-8?B?bVpva2lSVGlQOHEyTTRQM2E4QkV2ZnJaRyt1TnJzQTRad2UwTHl0VXNwa3pQ?=
 =?utf-8?B?eXJmZkRUTkpQMHRHb2Y2cGlKdUd5aFJTQmd1VzYxWFlqRGlOWjBCRWxvanhW?=
 =?utf-8?B?TTdicTB6d3J5NUFXYXRsZHFQUENKdm9MQ3VqU25FQ0gxR0hTOXlGd0xsMFgv?=
 =?utf-8?B?Qm9JbmEzbHFEbUlkOVpOMmNyT3YwdHA2dDdLTVFHblgxMC91Tml4cXhXMERY?=
 =?utf-8?Q?+a1YirtI2Ft7oKvI/PMHqY4WGY9Mzkidlt4TaiR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkU1RVZHVW5RN0JCVkVaTldWN2d3QVNENy93MXFsblFVNEE1Z1dNdGw0ZU9S?=
 =?utf-8?B?NFBFU21IQ1pvcTdJVUl6YkFhdE9XVjg2NytHQXVoUnpsTDh2aGdOeUhsWm9O?=
 =?utf-8?B?eFArdzRQTCtRaDF2Nnh2b2srbG90NlZBek13M0sreHVSRHpKUWpzVTNHR3RG?=
 =?utf-8?B?bGp1c21NN0lPOUU0RkdqUTFUcWs3TmxKTUY4ZkxvS2hpN3ZySW1LQ0xnU2ZX?=
 =?utf-8?B?ZXErdnlhRlozcU8zd1lVSUNjQmQ3b2lqakg5dVExWUxjNVIwem1NQlRJeE9Q?=
 =?utf-8?B?dkFqaGhQVEF1UDY1dnpta0VvQmgrUlBZdU4vZ3Zja0x0bkpTYUVrTHNkNTR0?=
 =?utf-8?B?cnRidGlUN0ZicHZzWHhkejJuY2FtNTh3WHJBajg1UTVDUXo3amcxaXBqWjBP?=
 =?utf-8?B?cUFuUWUyTHNWbWZWWkdoSzBKQXZOUTIwczluZEVvYVVUT0lFbFZIeXBmNXM0?=
 =?utf-8?B?d01wVWlIWFdpdXVpRDc3NTFIeUloUHlCYzhEbStLLzEvZ3c2bGVxTXNIUnRU?=
 =?utf-8?B?WXlqK2Y0OVR6QVJHM1BHbzA0bENNbVNZaHp3WENiTkNPK2dUSm53Ly9Pa1lV?=
 =?utf-8?B?NlAvVlRVWmpBQURZWU9iYU5zaTdCSHRBSlYzbXFMQm5mNHJOb1RMSFpydWdy?=
 =?utf-8?B?OTRjOXNsbTZrRloyWGhnWXdoRjR5Y1RDSDh6SXFwSnc4ZEtRVXViQzRIaU50?=
 =?utf-8?B?WXJHZktkS0dtTHpPN1R1MjNOY2ErUUhsYzVkdzVaSEpvOGxwYVR3ZmlLY2ZC?=
 =?utf-8?B?d1pjTnJsWm9JL3RsVWxHaGJNbWxRZWpxZEFyaWE1OTJDU2N6TkZ2V21uTTdW?=
 =?utf-8?B?eTB5YTUyUUowNVp6bWMrOU4zZWJCYVA0ekF4ZzdXaVZDY2hlczEwZVpBNElB?=
 =?utf-8?B?VzNFUXhhbStHSlpmT05GS01JVmJrVE9oaUFMUkgydGk2K0JWY2ZPY1RiakRn?=
 =?utf-8?B?NG12ZFhXaEZzMWYwMzMzRzdXK0cvRDdvZXlnMEYxTGhtNnY5VU52MGdRd2ZF?=
 =?utf-8?B?Z3dmeCtEclgxQ3NXOWl1VEFNRzdVVGgyd1pnRER5T2NibDRFRmN1R3lrRGNI?=
 =?utf-8?B?VC90OFpBbEgyTlc2UEpCeXlCM05FVElEUjg0ZExQRlRvSkcvdis4dmVTaTBv?=
 =?utf-8?B?eDZFUDkybyswM0lMdVgrVndITWxqYmI5TEVJcW1KL2FkSDk4MklqeEZxcFRK?=
 =?utf-8?B?eXVUMUxodGFwbitvY2YxZmVLTkRVQWI3ZnNqU05RTERaVVhqZU13dmtVclVi?=
 =?utf-8?B?Y05zcWtUODR2UFIvMW5WTkFDZTZDUnI3aXJZMy9NYnZ4UEk4c0JGUDF5d25J?=
 =?utf-8?B?VjF6b3hsdlVvYnVPckJyaFFDbmZIYlhPOFZZUDdkTEN4aENHNGVwSnpYVWRk?=
 =?utf-8?B?eXA4WEpFbTN5RmJMRWtoQnl6VXNRWFpHc1VONGJpNHh4aEJmYllBQ0hSQVU4?=
 =?utf-8?B?ZDYxaDFpclZ0SWZ6ancwa0dFMmx6K1c0UHl6c2VEQThZUis0cHV1bFBJWER2?=
 =?utf-8?B?eWUyUlVDSHlVSHN5ZEQrWUc5TlhKUU9tVFpyTmxmV1Y0a2hoTmxGYzVHcWV2?=
 =?utf-8?B?V2wxLzYzN2tsYmhxOGdFMjZKSk1kdmQvZ3BlU2NJWm54NXNEM1VQTXhiUncz?=
 =?utf-8?B?RnhyYWk0NVRFenE2N25DZlFTc25ZUnpNVnljT1hyK1l4U3lNZFcrelFCaVVB?=
 =?utf-8?B?MGFKM3FuaWhoWnIySDFEbnZYUjdTOENSNHBsVGVqTXRVWHNqdnR1TG9hNDVX?=
 =?utf-8?B?bU9SVTdiSUZnMExIMHdOMUNpUitoWm5kZTlXWDlLR0ZuYnVsZ0lUb0pwNjc0?=
 =?utf-8?B?cFZaZFdnMWovMUFlZkxteUFHTHA3dXd0YkNBUXNZL3YrcEhBUy9JRTVUejhx?=
 =?utf-8?B?cDBzVUVHNXBSMGgrc3pVdm1JaDBFTXJMMFF0Q1B4RVUrTmF3TkkwK0JIYU9u?=
 =?utf-8?B?UEFrQnZZWDlRUXpxbjduOER1NVRiSGhJM1FobW01MlJzbFJLNkMvRGdRMkNo?=
 =?utf-8?B?R2MySi9LMnNZVnVKL1FER0h5elhmRW1UUkdWcndIcC9mME1HQVI0TGpvT3ZF?=
 =?utf-8?B?ZGhFWXJaT0oxSE12OVV5WCtsNW5CdWlkQjRIRWJIWTF6bDE0OHB2cGlodnMx?=
 =?utf-8?B?UEt0WExkY3gwQ1Q2TUwzR2t1eEV6bStwa0k5STdrSmo4eDc5VE12WEQ4SjM3?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f47cb081-45ff-4127-ef5c-08dc91d26b47
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 09:13:31.1445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HsxqkFxPJjEsVUDCS0IuPuQqYNykLIO8EfBktr+yREdk1vcVB/XRdAK3CZC46MQFkalUT5aj1JJz4Wdp7WxCslYPFD6kLDpTx+Uk2NIWBEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7832
X-OriginatorOrg: intel.com

From: Yan Zhai <yan@cloudflare.com>
Date: Thu, 20 Jun 2024 15:19:10 -0700

> Software GRO is currently controlled by a single switch, i.e.
> 
>   ethtool -K dev gro on|off
> 
> However, this is not always desired. When GRO is enabled, even if the
> kernel cannot GRO certain traffic, it has to run through the GRO receive
> handlers with no benefit.
> 
> There are also scenarios that turning off GRO is a requirement. For
> example, our production environment has a scenario that a TC egress hook
> may add multiple encapsulation headers to forwarded skbs for load
> balancing and isolation purpose. The encapsulation is implemented via
> BPF. But the problem arises then: there is no way to properly offload a
> double-encapsulated packet, since skb only has network_header and
> inner_network_header to track one layer of encapsulation, but not two.

Implement it in the kernel then? :D

> On the other hand, not all the traffic through this device needs double
> encapsulation. But we have to turn off GRO completely for any ingress
> device as a result.
> 
> Introduce a bit on skb so that GRO engine can be notified to skip GRO on
> this skb, rather than having to be 0-or-1 for all traffic.
> 
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
>  include/linux/netdevice.h |  9 +++++++--
>  include/linux/skbuff.h    | 10 ++++++++++
>  net/Kconfig               | 10 ++++++++++
>  net/core/gro.c            |  2 +-
>  net/core/gro_cells.c      |  2 +-
>  net/core/skbuff.c         |  4 ++++
>  6 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index c83b390191d4..2ca0870b1221 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2415,11 +2415,16 @@ struct net_device {
>  	((dev)->devlink_port = (port));				\
>  })
>  
> -static inline bool netif_elide_gro(const struct net_device *dev)
> +static inline bool netif_elide_gro(const struct sk_buff *skb)
>  {
> -	if (!(dev->features & NETIF_F_GRO) || dev->xdp_prog)
> +	if (!(skb->dev->features & NETIF_F_GRO) || skb->dev->xdp_prog)
>  		return true;
> +
> +#ifdef CONFIG_SKB_GRO_CONTROL
> +	return skb->gro_disabled;
> +#else
>  	return false;
> +#endif
>  }
>  
>  #define	NETDEV_ALIGN		32
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index f4cda3fbdb75..48b10ece95b5 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1008,6 +1008,9 @@ struct sk_buff {
>  #if IS_ENABLED(CONFIG_IP_SCTP)
>  	__u8			csum_not_inet:1;
>  #endif
> +#ifdef CONFIG_SKB_GRO_CONTROL
> +	__u8			gro_disabled:1;
> +#endif
>  
>  #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
>  	__u16			tc_index;	/* traffic control index */
> @@ -1215,6 +1218,13 @@ static inline bool skb_wifi_acked_valid(const struct sk_buff *skb)
>  #endif
>  }
>  
> +static inline void skb_disable_gro(struct sk_buff *skb)
> +{
> +#ifdef CONFIG_SKB_GRO_CONTROL
> +	skb->gro_disabled = 1;
> +#endif
> +}
> +
>  /**
>   * skb_unref - decrement the skb's reference count
>   * @skb: buffer
> diff --git a/net/Kconfig b/net/Kconfig
> index 9fe65fa26e48..47d1ee92df15 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -289,6 +289,16 @@ config MAX_SKB_FRAGS
>  	  and in drivers using build_skb().
>  	  If unsure, say 17.
>  
> +config SKB_GRO_CONTROL
> +	bool "allow disable GRO on per-packet basis"
> +	default y
> +	help
> +	  By default GRO can only be enabled or disabled per network device.
> +	  This can be cumbersome for certain scenarios.
> +	  Toggling this option will allow disabling GRO for selected packets,
> +	  e.g. by XDP programs, so that it is more flexibile.
> +	  Extra overhead should be minimal.

I don't think we need a Kconfig option for that. Can't it be
unconditional? Is there any real eye-visible overhead?

> +
>  config RPS
>  	bool "Receive packet steering"
>  	depends on SMP && SYSFS
> diff --git a/net/core/gro.c b/net/core/gro.c
> index b3b43de1a650..46232a0d1983 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -476,7 +476,7 @@ static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff
>  	enum gro_result ret;
>  	int same_flow;
>  
> -	if (netif_elide_gro(skb->dev))
> +	if (netif_elide_gro(skb))
>  		goto normal;
>  
>  	gro_list_prepare(&gro_list->list, skb);
> diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
> index ff8e5b64bf6b..1bf15783300f 100644
> --- a/net/core/gro_cells.c
> +++ b/net/core/gro_cells.c
> @@ -20,7 +20,7 @@ int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
>  	if (unlikely(!(dev->flags & IFF_UP)))
>  		goto drop;
>  
> -	if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
> +	if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(skb)) {
>  		res = netif_rx(skb);
>  		goto unlock;
>  	}
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 2315c088e91d..82bd297921c1 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6030,6 +6030,10 @@ void skb_scrub_packet(struct sk_buff *skb, bool xnet)
>  	ipvs_reset(skb);
>  	skb->mark = 0;
>  	skb_clear_tstamp(skb);
> +#ifdef CONFIG_SKB_GRO_CONTROL
> +	/* hand back GRO control to next netns */
> +	skb->gro_disabled = 0;
> +#endif
>  }
>  EXPORT_SYMBOL_GPL(skb_scrub_packet);

Thanks,
Olek

