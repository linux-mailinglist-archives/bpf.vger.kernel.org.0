Return-Path: <bpf+bounces-22597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88E7861856
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 17:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997FA2843A6
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 16:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE7812883A;
	Fri, 23 Feb 2024 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2FC7Bhl"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA881272D9;
	Fri, 23 Feb 2024 16:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706778; cv=fail; b=P2oYn7xxBjMX0SnJYQ01ZURK8uyVkN6sO+Ri/dxbkeBurg5cNX7c3sWCRp3By8VkeJmAKA1XtxSPvvZkRnABLDALIRR68vQiq4ftlViSxpJX6Dj56nkbfsT9BTZHLEGRweNQQSoGJaNq3VH8J3tomR2t514Buyu2mPWgK6sqCVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706778; c=relaxed/simple;
	bh=eU97VxkxLYKkkzoUPOrCvH0Kt9l+QttGWXkFfCt90G8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TD5XW+3/utZrMPM32LF/h8PokdeCNJ1f8OjouUV8/iMllZCvolN7BDEI0na6sVmNj3ezld/mxmVqeVT77IuOe2McPKuC3Ao7daZsyFe075PFNAHlkz28MYpNJN4ygx8WJKFI19T80lsLCsF+jcwzqGmGzOjEjc2frJ7CDKl8Tp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2FC7Bhl; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708706776; x=1740242776;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=eU97VxkxLYKkkzoUPOrCvH0Kt9l+QttGWXkFfCt90G8=;
  b=C2FC7BhlYUjj0tW7Daj51/lMennXWAB/OBc2mSrSOP8vgFn5SEziM+gW
   0J5scAZv9ZzCOlViUCzKTuXm6yotAEusUf6gle1CwhFc4xL3cFyvqsKPg
   1R9RVAwZTacW5gK77mA8RV9+B8lMB8TgtZPeA2zcw/HDbFf2gtsrItcS+
   X1h41GFBbMheoY07HC6YeK9rmJToXihbam0ZJTEXiHkbkackiE5RiL5Pv
   2piNIIzcKhkxYm7NfDZVpC3sn0hFxXPO/g/n8BzYVa76FEB0U/An7Eiyw
   HhpS9niUiI+M6Em8SL+LlW2ngThVixu+HbSFz3hWpiN42R9PNq34pcH+u
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="5977071"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="5977071"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 08:46:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6328928"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 08:46:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 08:46:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 08:46:13 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 08:46:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6tiaOtILtMj9HCqdXT58R2ilealGRFI5fXPAaeNrCvwB5zwaEAQfIIMO8IU7sfYEkOQ/JI1pHl9TapKLYz3EqrQT/z+bPdGW8eV/1j/wNkurwtFeb24waHSISLz9MQ/z2fFwKVywb3jYgeeTzwNZOlxozQ+LoBPFATNZfidarXd9SogW1aK3+EMX8NJ85p/Xu3VLW7OPbRoMsYdHAyNFDGsNO8wF5oB0B+OxPkAV6N+oNvQBmXw0YT4bMY/Hfa7hCF83dxTlSoAWmq6pGaBmHOLBPydHsZrqqmtddLRVdCee6vRdfOCABvb4yCuYfye0bIuWO2D2YfWq3dGqRLrqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bUrvrnNe4e1oECkY24IvGiu4fwxtC3RjeBWNrn0sNQ=;
 b=VrF2KX8Y/ReAKnWWd49R+aQKsH4EYBGpHYYpcsUzV9dAy84IMtnfOjMKIMTh9I7ppDsF2RuURZS5XLgjsEdredVBvU38ib2qiDP//pPysOvztdIGRMvsnD5HTprKplSf30bdY2otyQA7mh4H0qf4gp+rnAbDL7lRkogLHrc0b2KalLZxCRAbAGyz/ewzbZqwjcRxE4k+g8NYml2A+s9Ijih2ZIqVtfyMh5ZWzvAv0DwmTlEbvhmkoS0O1XvzMyF5Gp/WjOzGA70kisYUCn2eSC9CsOBTXuiD5+XRrV1R0VUm2QbeAcTXQVJZlxSjGHmNoe92hwjwpHWFfUuaVvMXHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SN7PR11MB6825.namprd11.prod.outlook.com (2603:10b6:806:2a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Fri, 23 Feb
 2024 16:46:02 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7339.009; Fri, 23 Feb 2024
 16:46:02 +0000
Date: Fri, 23 Feb 2024 17:45:50 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <sdf@google.com>
CC: Kurt Kanzenbach <kurt@linutronix.de>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Song Yoong Siang
	<yoong.siang.song@intel.com>, Serge Semin <fancer.lancer@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, <netdev@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net] net: stmmac: Complete meta data only when enabled
Message-ID: <ZdjLvrBhW+NIcp85@boxer>
References: <20240222-stmmac_xdp-v1-1-e8d2d2b79ff0@linutronix.de>
 <CAKH8qBsCrYuT+18CsydQ5TeauRzu0Hdz7mZQ2c0W7er0KrJnkg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKH8qBsCrYuT+18CsydQ5TeauRzu0Hdz7mZQ2c0W7er0KrJnkg@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0264.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::20) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SN7PR11MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 056328ec-9db4-4a8b-2287-08dc348eebcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mt9tAAE8hdKsDCLaJO20IRsVFHJhyEczFz7GWsB3+37PNPDHtu6dBB5mq0Mk6/5OYpe9GI5epuQ7I1Lqkc3GS8egKW04Kiw8rFkcxL3lENjx1hcrXaELDeFaunmGSHNIS0VCqZni/HMk4SvjCul7t16bp4kCtDzHDiqDOs3Ib6lmfuFfvytf3vm0J9rgXIOP9vLzcGAV2l6lE3L1bnUhiUcjM3d1rfKLZOJvFnDKGuQLLZzup0XBkNOQ70lQqd+Wms1TkpHO4NSKfolBAYyaB5YaoZtpahPIzcJn3Rr7z/ooXhRxYQI68v40rAMMrqtd73Ffus+nl//YNnXDX5h44V3b1MhixD+wZoNHpuXW82V1ntcFFYv2icTlhXp+AXp3xuv+qrhbvdhrlcG5Z5ksAXDhJMVvQ/yNsij8KsBOt9y9szDL5FhOwdMGKw2Kul39NQsg4VNKqcbGl51jsgidu3xxdG22ZxjaQoejg0lU63cSc90e1v0eF3fqjDtnLB1smz0HVbn6VkFsWp3p3N1oRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkxUcWRQeDdqV2YzaGtpTllPSERyUitFY2h3cWdwYjlodS9kNHNQajRWY1cv?=
 =?utf-8?B?YUFjTm1aUS9rL1NIY24wOFN1aTQ1cnA4TE1lV3FhcGxQc0lYSnFSUDVyM0I1?=
 =?utf-8?B?OEtJRytYdU16aGFzaVo4OVhCZDI0V1o5Vk8zUmZ0QlRXTFIzTkt6R045Q1VS?=
 =?utf-8?B?VDBIZFZISGNNMjZWS1BFT0VLZi92SXJxZlJTdkhRaGtxc2NJQTFVRURsbU15?=
 =?utf-8?B?SExSaDFXMnBHR1JoMXJoVk8xcHg0d3d2V012VU1wRlZxU3BhM2FOaU1MaStE?=
 =?utf-8?B?UHZyeHhOaUdvd1dkLzdtbUF3RlhlVnU5NnlqZ3hleFM5ekU5bUh3TlJURGw3?=
 =?utf-8?B?N3ppWk1TVGxIWFlaVG04TndmK3Q3ditCaTF4ZzgvUHF1ZTVscWUzekVBTzA5?=
 =?utf-8?B?WXAxcEg3ZXpWYUFWOW1tRGUvOXcwSWNmTjBUM2NhYVpXcmI5M0dRckhQSC9V?=
 =?utf-8?B?SGFpM1FFekpnSExWaHFFUlpnWWF2andaR2hSdmRmT0RsTEh0VndrVXB2dDM3?=
 =?utf-8?B?ZmNPd21hUE8zanVOZU1rOXo4VE9pK2U0aW5GUkxKemJvWGdVK2xtaW1kM0gy?=
 =?utf-8?B?V3VjWktnMjJVMHkxeDNiOVRXUnNBdThJMng3ZncyalREM0dCYU41WTJHK3VG?=
 =?utf-8?B?cW00VTBCUEVtWWpGY1NwYTJCK3BlNHpQcmJScFdtQjdJYURwOHJON0JIa3Y4?=
 =?utf-8?B?ekhtdGhlR2lud2N6b3NSU1VQa3pObktFQlhMdXg0bFdDMmVWSGhRZndHZWk2?=
 =?utf-8?B?ZGIzdGpPa3BlSkVVcnNBT0grcGh5SXlmWTBxcDV4djZKQjNSRG5ZN0xHZ1ha?=
 =?utf-8?B?S0JlUGVqZ3hoa01hZEMxUUZmR0VxV2ZyKzZnb01uaHFiQzcxdnYyWGFoZHNX?=
 =?utf-8?B?TGlUVHhPVmpNQklCSytlejY5VGpuOUZ2d0Z2Sjc1SlV2M0xEQjRuWVQ1TjNX?=
 =?utf-8?B?Z1JGUVZYUjZKb3hvenlXb3hLNldBYThCZzRHbVkxdUdORXhLUWhZVkorc3J6?=
 =?utf-8?B?eVcxTVQ2OVJ0dmhoVlNFbGpsMk14YjdiTThBT1U1QWE4ZCtzTW9WZjNFMWlQ?=
 =?utf-8?B?OHJWN0VtcU5hVGxUWFlFWDdzL0JxdzNYb2ZTMjd1QUIwdHpwSVZJSE9TN2M2?=
 =?utf-8?B?ckI2L1B2WndBekN2YnhKUDEzUmxXOFVJLzdEQytWdVJjNW9yUTh5SEFaQXJn?=
 =?utf-8?B?OWdLRllLMlpLZ3haNGd5UnNuZHNrdGhaWDJuWFJpMnQyTGhETkFFSGZkSHlH?=
 =?utf-8?B?NVF6aG1xOHMyRUE3THdDZGMzak5OL0ozWWowNHlEV0FzaEtnVlY1WnhKT3Rj?=
 =?utf-8?B?THA5ckczY1VUU01BU05qa0V4dGJkSTBoUXhtUy9MMmVJbGo1ZzNwRkFmQWVy?=
 =?utf-8?B?UkhLV0RxVlVJVnRlSXNZdTdNdThmYXdBdzc2Smd1cDFxYWpyYTBhWWxJSHdm?=
 =?utf-8?B?KzNJL0c4b0hlRjIrSUxRcEdsc2dPL3VPSmNVTTRwTWE0QXIrRklkcWZVZE8r?=
 =?utf-8?B?MXA1Z2YwK29VVTNFbHJGY05WSVJvaC9sSmxBR3NFMlpyVHNjR21lOFRXR0RQ?=
 =?utf-8?B?dk51VEZnVk1OT2V4OFBoU3YvZG1Wa2tqWEl1WWVOQWRQdWxjKzRmcmFmNUpp?=
 =?utf-8?B?dWhpZjNNSkJCOHdINXE0cCtxL0NVSlZISGxQNDdHeXNFdnpjK2g3K2ZuUTZF?=
 =?utf-8?B?YVRZd2ZOZFFkVUlFSURXaFBpcGd6S3J2aE40NXBsd040YWgrbW8xV3ovTHhZ?=
 =?utf-8?B?cllUY01jOUZoOHpPV1czYXRNMTc0OW9qeTd6c2Y2VVBhN3dWMDZaZnRvMTFj?=
 =?utf-8?B?Z0RlZGhFV204TS91VmxjUWhVWEZYaDhzU0NWQmhYMUFOWkJjdjNkeWNYWW1G?=
 =?utf-8?B?UzhWRnZZTnhrRmNJV0lFVW9uM014UXZlVkU5dHBnMWRLNzd1UU5QSkpHSjZW?=
 =?utf-8?B?dTNEOFpoaWNyak1MU3ZtUGZESmFOcUN3aUNWRkNyT2xjbWh0R3FIcnE0Qkhj?=
 =?utf-8?B?LzVqcUkrWWM4UzRRZmNZQ0xtcm1GeXJtNlFndUl1NDZ2T3lKV3p1Q1k3RjAy?=
 =?utf-8?B?RnpoTGNKYnMwQng0SlNSR25ONTc5alc4dUNuQnIzci9VZDNITC9iaFlmMlcr?=
 =?utf-8?B?REErWDh3U3IwZmg5RmR0em94VXExWnhoK29kWlF3d25EdTNiaW1wV09KenQw?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 056328ec-9db4-4a8b-2287-08dc348eebcf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 16:46:02.7301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlrsM2OqU0Df6o5BWelVQUmxgJofDnTmDr4GVq1sq+k4pz9V5AWVbHGTCI/r+siKKGP3ck58M1TLxlyQcjiPPzr0KMyWqwVebIQHIywFEMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6825
X-OriginatorOrg: intel.com

On Thu, Feb 22, 2024 at 11:53:14AM -0800, Stanislav Fomichev wrote:
> On Thu, Feb 22, 2024 at 1:45 AM Kurt Kanzenbach <kurt@linutronix.de> wrote:
> >
> > Currently using XDP/ZC sockets on stmmac results in a kernel crash:
> >
> > |[  255.822584] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000

would be good to explain where it comes from, no?

xsk_tx_metadata_to_compl() works on meta == NULL, it does not set
compl->tx_timestamp and later on xsk_tx_metadata_complete() tries to
dereference that.

> > |[...]
> > |[  255.822764] Call trace:
> > |[  255.822766]  stmmac_tx_clean.constprop.0+0x848/0xc38
> >
> > The program counter indicates xsk_tx_metadata_complete(). However, this
> > function shouldn't be called unless metadata is actually enabled.
> >
> > Tested on imx93 without XDP, with XDP and with XDP/ZC.
> >
> > Fixes: 1347b419318d ("net: stmmac: Add Tx HWTS support to XDP ZC")
> > Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> > Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> > Tested-by: Serge Semin <fancer.lancer@gmail.com>
> > Link: https://lore.kernel.org/netdev/87r0h7wg8u.fsf@kurt.kurt.home/
> 
> Acked-by: Stanislav Fomichev <sdf@google.com>
> 
> LGTM, thanks!
> 
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index e80d77bd9f1f..8b77c0952071 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -2672,7 +2672,8 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
> >                         }
> >                         if (skb) {
> >                                 stmmac_get_tx_hwtstamp(priv, p, skb);
> > -                       } else {
> > +                       } else if (tx_q->xsk_pool &&
> > +                                  xp_tx_metadata_enabled(tx_q->xsk_pool)) {
> >                                 struct stmmac_xsk_tx_complete tx_compl = {
> >                                         .priv = priv,
> >                                         .desc = p,
> >
> > ---
> > base-commit: 603ead96582d85903baec2d55f021b8dac5c25d2
> > change-id: 20240222-stmmac_xdp-585ebf1680b3
> >
> > Best regards,
> > --
> > Kurt Kanzenbach <kurt@linutronix.de>
> >

