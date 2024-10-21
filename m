Return-Path: <bpf+bounces-42645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020E29A6BF5
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 16:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B941C21BD0
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 14:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63B81F9435;
	Mon, 21 Oct 2024 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VueqAwI7"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0939B1DDF5;
	Mon, 21 Oct 2024 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520474; cv=fail; b=JOb1rcEg67I7IOvvaA8U4pQCPLnlM9tiY/pt6jL70qFEr1YSxCZqJAPp+DTiWG+/i7kG1UuZKGk2OgbLn5TnwIwapFbFvLwObduxlziQaFrmZHVuObuGtddBlH5FWIuGUpf4RmjYe0RAXfUHO8AZDJ05HBnIC9zJzzD3FcFrzIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520474; c=relaxed/simple;
	bh=e2AhdIsFej/XUVD5lFe+Qy/8xa2sy7R2T5vzXQb1usY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WmHJx3Pb2ffyQsEBtq5Z52NTwswXXAPpb6CsG7AnR9uwJSonO6gBRcFG/K6PWmz9LGC9SEoxvWnvBsMg5xRoAP1pu2DU0s0NzQ9eVAJ5FnsCNOZx6CvrfUqdivbvuAOQH/K2WLtFfpsRnx7hNs/5vGyqRL/mAJ8L/RLsKK4U+bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VueqAwI7; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729520473; x=1761056473;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e2AhdIsFej/XUVD5lFe+Qy/8xa2sy7R2T5vzXQb1usY=;
  b=VueqAwI7aHN6feBZbGpu4Zsf2XOg4/bEdrNMYLvMNbZBdCYXPwfPOgYE
   6QamMplcaCT0Tbe0IpYmFFkyEX9Q4vYDL5AapsmHqvXRWhOnnUmek2jvb
   sWHSU5SVptH7RJsYxO+AUFkuAXNVkj7lBeDoo9lkXtipPSDeQcJVMBweb
   tz0WaumR+rXI4KS2HBedFyC+3791tLYHJqhAbAf1+efV3fyVDdWlVvPnl
   CaUijbYM4NlcEV4r7Z3h7ljTjdJOeE3WwMgUuTrPTU5ylGvR/4vQs24B2
   9eieZRBiy9tmFWtQ4yLQkMFEsHRr7jcS4HP2PcfgBVaJtBwi+CvneU8Gi
   w==;
X-CSE-ConnectionGUID: RNy7onulSUOnk3/oNyJFrA==
X-CSE-MsgGUID: gG1pCU/cS1WHqeCjTf+6iA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28781012"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28781012"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 07:21:12 -0700
X-CSE-ConnectionGUID: hUV7+ECiTe2Tp3kWnyVtuQ==
X-CSE-MsgGUID: Sv0hRlbRQ6S8gXmetKyO/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79178981"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 07:21:10 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 07:21:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 07:21:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 07:21:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMZQR4nVCIFzjuliCay+PJmQMwQKM9EVsukonhMxZxwXSwBfkR5YlRfN8eCR5kp1Fueul7COvWL31P46aK/sBJ8Aa/AeYF42eBC6WnIZTGvs0nBpYJyJtTDYbWM1XvMHEgm0As/EUJxTGETd7fAgJmS9OTKcJgz8JsGC2oB7fGeMI1AsDW2CvUAXNHqsOrt+CsFVUoEIQcUVHqjK0dHKBIpSf512COTL1ZKhVN2RZrEn07D9E0lllPpYt+salyIictapxmuUZjylm1Z3rdJERwjyx2iT9/ALum8wKHkCGVK+k56AyGmb03583hpPBe7dhA6JSCTZqiQ54UsLYauSlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVowvQigbwohGAepia61Wd9eRf8QWU/0gNrPVYJmotY=;
 b=azWKnm0vjBw7cFjVv45EuNgugRPG7UimJpnrzFOGcS2mToH3Wus0meoOiclOgXGCmCSJQgc6Zv5zBf1fjvTX6E9FEwZFmHFZBHse+gkZ9xwqv8t+wbSj0f8LSynAElUgwVqg5MljoOKXSnG4N4PejeQyY4HIVpbGFZsDqEGVnRwhpAwaY2dKIsqjpOwy46J36+HK04EplU+w0H3rfvkN7nW0J+e0pTbsihZh2bjURX5/BvLr6sMMMwyRk2kMYQ0wXDKy0EdEmvv9lvbvA1H6oGr7WyyXI4XD6Gc5RDdED3uJfYzMVRnm+bUG62m6P7oGt90yu1rOCF8VqvG0+Hi9pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA0PR11MB7258.namprd11.prod.outlook.com (2603:10b6:208:43d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 14:21:02 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 14:21:02 +0000
Message-ID: <4dda1ca6-f684-4b6a-8972-3915921cbf6d@intel.com>
Date: Mon, 21 Oct 2024 16:20:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 12/18] xdp: add generic
 xdp_build_skb_from_buff()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
 <20241015145350.4077765-13-aleksander.lobakin@intel.com>
 <ZxEEWYWrUxFh33xD@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ZxEEWYWrUxFh33xD@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA0PR11MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a9f504-3061-4f24-4030-08dcf1db975a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjQwNEJtcEZnSmNPRktPd3F0eFVOQ2ErZERSY1d5QS90amtPY0hwVUNYc3cw?=
 =?utf-8?B?eERDWEdCYmFYZlpodm04QTBKbGVLN2JOMW9uTy9HTTNGanBCbHJhcUNDMXQ5?=
 =?utf-8?B?TkkwZTVkYTd2UEYvRiszc0VRZzlQam1kUW82WWRydXJobVNVeW5heEFuYktM?=
 =?utf-8?B?cnlSZmVzMStCb1NJNXVNeEE0T2owNmJ1aEtNSVlnREh4UjJZdENwb0pSZFov?=
 =?utf-8?B?bFBoS3h1K1BPQjZFd0tIMlRCY29rZmZka3B3UVBxNWtPbEhQTmY3dk9HVk5U?=
 =?utf-8?B?Q090Z2ptaW00NmJTUEplbnQ5UU9HSVlibWVYbWhwZG5iVy9kSHdUa0dCMlRQ?=
 =?utf-8?B?eGp6eUpRY1lOMDc4NUdsbFJIQ2ozYnEvd2c4cEEvZVZyd1RlMXh4R3ZFWGJr?=
 =?utf-8?B?N3RMRk9IazBsRkZ4UUxuUFV3MkJHd1pHVCs3SUlDanhhcjlvdHVqeWZxdlVx?=
 =?utf-8?B?cG9vMEJtV21RNWtwMk5hYXVFYnJmditiTHFUczVVQkJnK2tseUJJT2hCUHVw?=
 =?utf-8?B?QjgzUWR4RDcxWUtMUHlLbS9mbzAxRVhDb2d6UlgxeFFUTFh3Zk85YXAzVEpk?=
 =?utf-8?B?Z2tyd3dibTdtbzZaZkdDWFpNOElzY2NidUR0YkN2eDNybkpEeDlKR1BOSkow?=
 =?utf-8?B?VzdJVThZVnVmTTcxaEliVm9SaFI1OG5hUVlHZmZPSDQwd2hqdy9iN3cvQzNs?=
 =?utf-8?B?eEdqeVEwNDJYT1lVRFhzTzR0djZPWUxMSStLd1RuZ2tHOWVraXkxOXF5QUF1?=
 =?utf-8?B?QVE3K0NSUnN1RGJRdUpqMVpmMitvWk81SDI5QlRzMytxZk9JazVmU0M4YlJI?=
 =?utf-8?B?K3dITndHemFwRjl0VzJsTlJuWjhtM2JINTNFTjE0dzBXQ2tST0gxdjd6NG1v?=
 =?utf-8?B?RnZKd1krRUlWaFl1bWZoN1QrMGpPWExEZ2ZVdm1iZnk2UjZadTZyUUlnb1VS?=
 =?utf-8?B?N1V0WFdPNmFGM3lQY3lJNDVwQjN3L2lpZVBVVld4dWZYb0tURUQ3akxiWUZj?=
 =?utf-8?B?NjhqZ3N4RE1MdU5YWTFuM2xSR2xtV24yUVF3bjJ2U3JUZnNnaEc1M0pHQThG?=
 =?utf-8?B?ckh0UW1mY2p3Mml4cEdmb3hPck9JSTZyYkhDUmJsYnBHY1dVR2p4K0pocGcx?=
 =?utf-8?B?ZDZIb0FKelNTL1RkNWxGQmM3WlFndll3YmVTY1M0TDlCNlh4YzcyRW9yKzNF?=
 =?utf-8?B?ZUJQZWVpbFJxcFM2eTFMZG1XMjROdjhzMFNuY2R1ZTBKSzZ0R0RDa2NxMm9M?=
 =?utf-8?B?Vk9ObzJXeFlLa0NGTCtMT2RFU3h4UkorZ1JTcEEzRENsUHVVYWZHOG1RdEpM?=
 =?utf-8?B?OUVLN3E2UklDVklYbW9QZENqTlE5cEU3Q0F6c3VRUXJJUzVZenpsdWcvV0cy?=
 =?utf-8?B?akQvU01wVm1WSXRKMjNJLzAxdE9XanluSU5uSlFPd1FZSlQwT01aODFDRjdy?=
 =?utf-8?B?Wkc1NGpzQ1phREVRbFl0QVBFQkxxM3krNG1IaytPaCtMOHpsS1Q4bDY5TE03?=
 =?utf-8?B?eHJvL1dObzVZNVJqMEtWMmt6L1hMYkM3VUFUejdhWUNaSW5HV09CMXhkdXJ4?=
 =?utf-8?B?Vk10dEE3VWpLa0NBTi9nZHNremI0MG54dWNIN0lXeTJDSzU5azhkOWVNamdG?=
 =?utf-8?B?cGI1RVhpZFBld0ZkVGFYZ2MvT2tHM0pQQWRuYVdlbkx6Q2gzZjl0Z0l0Wk1n?=
 =?utf-8?B?eG1NUHdQRzZCQzJyUG05NjJ3VGJOKzdnSlAwMXpYMG5KUCtCSGFMaDQzcEox?=
 =?utf-8?Q?zggH6s1/3Mi8QHNQ+s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akJLbW5aUGJ1aU14UjVuTTAyckFEYjlvTHYxYUpKT2EwSFAyNlRiNjdJUEtx?=
 =?utf-8?B?ekJQR080NTZqWFpxNTVUcitFQURkYkNFdG9BVHFWRFEyUWFGd2pyQ0tScHQ5?=
 =?utf-8?B?NkZOUVlaV2xCdkJ4QUxnWG1CQmtJLy81M3BPSXF1QVdNTEFwRXN3K1dOUkQ5?=
 =?utf-8?B?U2lScHlIZEtRSXhjZFFSdnA2eWNLK09SMWxjaUNnTDFoWG9EQXViL09ybWFL?=
 =?utf-8?B?emRSejd3cGdqb1dlbUFUd1hJbHY0SndNRHZSaVE1bTduKzlVUXBuVytVVGtL?=
 =?utf-8?B?REM3L1NyaGFwVU9WVXRDenBVTHVGWWF6Mnl2MzV4a1FOSWk1dS9oUGs1Rm9u?=
 =?utf-8?B?WWM5RjFPa3o5SjZLay9TZFp0S1BtMlJQK3JqckVwcDNXanBFTmVJaEhicHgw?=
 =?utf-8?B?UU02dEtiK2RVT0RtWWVQaHRMVmtDQm81QW9VV3VzUjhreHZ1SkFyN1hacnpU?=
 =?utf-8?B?QmZMbzhrNkpkODlOc2hiRkk0MnNlOGl4bzlXYWhlUzdxNkJUSmczUVNrWDla?=
 =?utf-8?B?eDR1WmZKSDZURXhRcTAzRTl5NEk1YTJmZXNrMUZhRTErZjZzaVRiTUo4MWV5?=
 =?utf-8?B?NVVNY2tRd2ZnWlplNlNWZFpabDFkU2Y2NmNXeXFRT0h3bVBpNEFielRXZFRR?=
 =?utf-8?B?R2FaUjVTMVNyZlBZUU5KTkFhNXpPWWcySk4xQkdOZUUrRW53czJsc1BqQVdv?=
 =?utf-8?B?ek0wWlE0aHhZSm5FVy9QbzNKZ24yMW5sdmpkT1FCTm1LQ1NUaUw4UHZyU0NH?=
 =?utf-8?B?YXNaTkpWNklBZE44SVRaUlBLeVVTUHFGVXpsYjBOL21GN1lGSE1RMThpZ3A0?=
 =?utf-8?B?S0J6SWJ6aTZMdjdDenpsdTFnY1JPdmdaOTI3ZUQ2Z1FQNzhoTElJTGVaZDI3?=
 =?utf-8?B?TFh5UWtRa0ZXeE1Fc1crRCtUVW5OTURsSGtmSDI2ZGRVUmhOZXRrME1DTHVY?=
 =?utf-8?B?VU1qNVRrcXVpYXB6TlUxTVFGaVcyN3dLRmpFNS9hQWRkZ093bVBhSjR2Y3hy?=
 =?utf-8?B?SGQ4NkRSQUNtaTkyRnVqVjhDdERyR2NGdGV6Q3ZtT3psRUlTVzFWd0x2b1I4?=
 =?utf-8?B?REQyaDd0T3E1NGo2a09wOWZOVzcxeEwyYzVRcGd2WkVJTTZuU1pwSDJadkpp?=
 =?utf-8?B?ZjcwS1lxbzVsL1VnVm9ROGpBc0xoY0NHK2VuQlVPMVNsOXVsMndMK0JnVUM2?=
 =?utf-8?B?WDgyTnpjTDFhS1lzbDFpaVN4akcwb24wMXgweXl5MERlVFBiOU05V0t3NWx2?=
 =?utf-8?B?UVl1SEJIOHlkU3IvRGF0aU1ocTRBN25zSkVnRUhkeGRhSTNUbGMyWWlJckxR?=
 =?utf-8?B?dEVaZjJBQlk1MURSWDFycm1HTnlUbjV5UHJsTGt6TmlTZ1VrQTJ3QU9GM3Rx?=
 =?utf-8?B?TVludS9IeXBYR0dsTndBdWNMNDJ4UDRRUksrOEJIQjA1Znc3SndaS0J0bURF?=
 =?utf-8?B?NmlxRWJCTmwzYTJNUWxtR1E4c2lrMmxiWlFBbWRNazJTNUMySU1qKzZmNXJW?=
 =?utf-8?B?bU5hMlYrM2RveGJVSTFLZitMcFNIOTVmTkk5VEpYNVFkaE43QTQwaDEzTjEv?=
 =?utf-8?B?bzJBUFZHVGdrdUZpT3JGOGQ2REgxV3BoU1A1VXVRbG9XRWh2Qy9DVnkyVXIr?=
 =?utf-8?B?QXYrWDdacGVEdWt4c1E0NEkyY3A5N05wTW9BazNOcDYwRGhFNFZ3ckZpbGxK?=
 =?utf-8?B?NGxRb0xqZjVjV1NxU2UrK0djTnNnamNna013dkZqcDh2dGs2aHNoeWREK0hI?=
 =?utf-8?B?cysxRXJNa2dIeFhJK2x1aHoyVnZseS9USm5ZelBrQWV3djhKVWVpUnVFYlVR?=
 =?utf-8?B?UGlFUXZGelI0SUFNQ2MwWFozaExZMTIzdkVESEtrdmNPMjZ1cWFVWVBEN0pz?=
 =?utf-8?B?c1l6N1FZWW9UVExnZWZlNVRWVlFXbTNLTGZqM21aOExreUh0SmIvUEZ6ZEZM?=
 =?utf-8?B?L0NwemJXSVBBa2JrVkpybXUzWFo2ZXpTS1RaVEpoT251YXFFSTJkWmxQbHFp?=
 =?utf-8?B?YWtOWUJtVFdxc1V1cFlKT3JFa2RBRkh0eG9sSHJJZlVlS1FORFViZE1aQXdL?=
 =?utf-8?B?ZFBLSklPTlA5YUM2T21OUjgzTG9QUW5NZ0VyNEEvaXBQdFJnZkR1LzlZblpM?=
 =?utf-8?B?Qkd4Q2E3cGF1U0hCZXhWNmZoTHB4U21zNFdqUU14bTRhZlB4d2pjWjVuU0Rx?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a9f504-3061-4f24-4030-08dcf1db975a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 14:21:02.1811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/Wpt2ooxTvBxXWyejkUa3W6vh7FccLJgVyz0jy7LXGynX59XYOd2NBcJ0UV5p387kFYF3HohnDwS38NepE4icB/IiHpiX/mHgeBG6ji/wM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7258
X-OriginatorOrg: intel.com

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu, 17 Oct 2024 14:34:33 +0200

> On Tue, Oct 15, 2024 at 04:53:44PM +0200, Alexander Lobakin wrote:
>> The code which builds an skb from an &xdp_buff keeps multiplying itself
>> around the drivers with almost no changes. Let's try to stop that by
>> adding a generic function.

[...]

>> +	skb_record_rx_queue(skb, rxq->queue_index);
>> +
>> +	if (unlikely(nr_frags)) {
>> +		u32 ts;
> 
> nit: spell out truesize? ts confuse my brain with timestamp TBH

Ack.

> 
>> +
>> +		ts = sinfo->xdp_frags_truesize ? : nr_frags * xdp->frame_sz;
>> +		xdp_update_skb_shared_info(skb, nr_frags,
>> +					   sinfo->xdp_frags_size, ts,
>> +					   xdp_buff_is_frag_pfmemalloc(xdp));
>> +	}
>> +
>> +	skb->protocol = eth_type_trans(skb, rxq->dev);
> 
> could we leave this out to be set by drivers? i see in ice for example
> netdev ptr is retrieved in different ways here.

As for ice, it's for representors only + unlikely() + we could override
it manually there later (set skb->dev + call eth_skb_pkt_type()).
OTOH this looks more consistent with xdp_build_skb_from_frame() + saves
some object code (you won't need to generate a call to eth_type_trans()
in each driver).

> 
>> +
>> +	return skb;
>> +}
>> +EXPORT_SYMBOL_GPL(xdp_build_skb_from_buff);
>> +
>>  struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
>>  					   struct sk_buff *skb,
>>  					   struct net_device *dev)
>> -- 
>> 2.46.2

Thanks,
Olek

