Return-Path: <bpf+bounces-70666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867E9BC9B1E
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 17:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568793E3ACE
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 15:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147232ECD32;
	Thu,  9 Oct 2025 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mr3ICwoR"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E442EBBAD;
	Thu,  9 Oct 2025 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760022364; cv=fail; b=tKtQngpVNcUUsplJRlqbO9V4+UpFu2GReUGgHa+JaOKRImQ6dVi5QLMEK/UervqBgPNnV+AHqPC6lixqyD7odSB405eM/0bXN6DofISveUnimBneZL3ZKYe22u301OMCh54LMWy6ZXFTkJWnD+GtL5UbdF8NQXeSdwCNOZ+Gggo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760022364; c=relaxed/simple;
	bh=qZNzrJUhr/L4KPBNn766Q0a9PDktCkQGzsVBprVehWI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uRQY4A+07ffgMQMktLE30drQrtSipyRZSqQiu75tTlFVerozgfvb+bOrWxqtaqZrZbN6Ef1yMOmVPQ9ZhYbtGVwRJjGXsyAGeR/sFDTYoEGCQxEwvQAm2W4b6PolvMNU32pauCFuJIQYnC1NftwNPua9OqnMeVtMKS6BWp7AAWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mr3ICwoR; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760022362; x=1791558362;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qZNzrJUhr/L4KPBNn766Q0a9PDktCkQGzsVBprVehWI=;
  b=mr3ICwoRWMTkU5DhRvDaPGLg9d1t7xoMifvRJKP+PChHGJKfLsRZ8FjZ
   +57BnVm7kfy7xF9ardbiijwapAafP9T4tzR6zrY2WbXQ11qOQwOUoRxac
   anXOq0ESB5Se1BwOdvMOndypCpwkZRXtMIBru5xxlfi3QsFkm0eCsaqgf
   m4JlTnezEzwfvjtKJH0xkLaLEGHh3IGnsxo1Ybho8iOf/GgEZtB39KHdx
   SJDY9MRKaxZFLE0Km6MELNYu+vyQmnYW/sI/yPPMeSOJpjNcwpjlnEJJT
   6JaruUX9aKmJEZhyY6EvpuvJgWTbfiGTcgbnn7LRChFykk1Dmlz9T/e8l
   g==;
X-CSE-ConnectionGUID: OafZbdQVQv+M/f5746ongg==
X-CSE-MsgGUID: 4KElPEULQOyTCaRwvHnLbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="61442136"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="61442136"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 08:06:01 -0700
X-CSE-ConnectionGUID: C0EUa34FSR2UkyWxGMB5hw==
X-CSE-MsgGUID: KWt1vLJpQXGYCC5X4lvMNA==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 08:06:01 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 08:06:00 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 08:06:00 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.10) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 08:06:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGY7un/xtxHlc+lKj3fXTjL2q+cQYuXNaKaPO8eDUqofJgYSEqOQf9/o6yUxVYWFlos8UCsI5RZRY25L7wRZiQVBZcLvJiLZZRVR83CouGzXfZCwdOPtX6BrUGUl0nStOcZMtzaDUEjCpKXgsbZm0Q9bXxE6i8eUH7CtMFyNXcEKXvhbZIRFLx7lTAwgmba8d+3BSpdb9AGFqBy4tLSON3MRY5ATdwyZpbwJkYumT6a59eK0d9FDWb2FZf69NhcBgDaOENJ7vi9a66bDnEwYBAAeSqMqYPbPNjCRCRFHEemzMBfnQKJcuhLXww2RLpdn0flK+9OKkvqPv6pV8XrTCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eYIrlutVJEIMCBPYYDlQtWu8miZxBTCqm7ocyk2pLE=;
 b=cgjEjgqd5ebWvXtn5Rc7z0K9BvDF4zwR2HuRPCyVvy/Hnax6WKfUO3VDiWbOAMycfgqwxLJOrY9GY3LZOJ24aMmfhjpmIBWVNJ8rAZ8qxOV8BLyw1EBAXtc46Olhs18cZ/GKOSCpcJhn4tLyNfzcRKi7kfHO+v3b2V9HyvfUx2RLHnB2SnNZv1QGWBY1zaksrF+374gAoLRAPDotQvpuC+KqtyPItlTmF7iobsOycBxz6BvqI1RkcsEiE8xAGeK5lNclv14ob32pFR8Nsj8+2bAtOlA/iBrabEXTz7MaN86ENuy0zD21Dca5N8+AEwXkpkcz3hwM4SVb/3QkPfLShw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by BL3PR11MB6410.namprd11.prod.outlook.com (2603:10b6:208:3b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 15:05:58 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 15:05:58 +0000
Message-ID: <4da73606-7bfd-4064-b319-d0097955af60@intel.com>
Date: Thu, 9 Oct 2025 17:05:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] xsk: harden userspace-supplied &xdp_desc validation
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: Magnus Karlsson <magnus.karlsson@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Kees Cook <kees@kernel.org>,
	<nxne.cnse.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
	<stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251008165659.4141318-1-aleksander.lobakin@intel.com>
 <aOfGZvSxC8X2h8Zb@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <aOfGZvSxC8X2h8Zb@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::9) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|BL3PR11MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 2076f3d9-3889-43c3-d043-08de07455a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2NVQTdSTWl5ZHVDbEkwb2dDbktxOFlyTlB6TTBXQkFRUXBlMXVPck03dHVu?=
 =?utf-8?B?K3RqMVlXWjZqL2dPUmV5cmIwaExEazRqUEFPZ3pOTksvYlAxejJWU291SzNn?=
 =?utf-8?B?blIvSW5pME9VbmEwdmFDbUxNNnlSNXB2ZzNvQmFJV2hwcTNFWDd2RUZDWllD?=
 =?utf-8?B?T1dnZ2NKdlNXTkFCNUd0TnVySEh6bXpsNDZOaE82ZklhaUxWaGh3LzhiaGl2?=
 =?utf-8?B?WFJUeENHRnBmMEI5VGlBYlF3L0lhQzJZUDM0Zm54RnNaR3ZJZkh0Q3lXTWJs?=
 =?utf-8?B?bVN3cUV1T2lNRzZMejVvd0VIU2xhQTlwcVpES2d2ZU01TDNDZ2hRK2Z1ZXZ0?=
 =?utf-8?B?NHBtcDVwa0s1bUF2eGdWaFVTcVdpSlVtNmtnWC8wM0pYTTczZlJrMWU3Vjh1?=
 =?utf-8?B?SGZrd1p0MUNmWXIvcCt6SE5KcTdNNGVMODlhSmE0OGlrTy9zbU5nVTdhR3hR?=
 =?utf-8?B?eCs4RXo2a3VIQ3BOWFBCc3V4a3h3M01QQjZTTXZEL1FWU2RtZGR6aWxEbkcw?=
 =?utf-8?B?UUsrOXpBZHcweWFTS1J1dUpmUzJlNDF1T1ppM09XZFZYWnQ3YnlOQlNudUpN?=
 =?utf-8?B?eXprbFJmRElQb1EraGhPbGVuZkc4UitFY2duSDNYV25Tam1nV2NSL01zOHpV?=
 =?utf-8?B?ZXdmM0phcDZPdTdNbkZFRjlkWFdsSlArSWZQVVdmYk5RT3RXeEFWMnA0aURV?=
 =?utf-8?B?RVBSQ3gxS0VPcHI0YmsxQlQ5cVlQVDRlSFFIUDdOemNYSzJIZk4vL0U5OVo5?=
 =?utf-8?B?ZmhkL2Q4Q3NiWWYrekxSZVFmbVo1c2RTWXpSOEhwUUszeEQxbGVpU0FtQTVv?=
 =?utf-8?B?T0lwSmdtZkFFWjZHY2w5dUw2aVNnTkw3ZEJGUHAwclVtb3htVUNCQzlzZytD?=
 =?utf-8?B?ZDlPNUdGMmNmeEgvaFJzTlNjeVRwSG5lcG9hUC82UEw1c1ZiU2w3dVpSYXR1?=
 =?utf-8?B?QkxBOXNSem9Rc3FYNk9CMWMyaFBzU0FVNHJGMmprcGlCVzkyVFRMTUkrVnRE?=
 =?utf-8?B?eFlVMWlSR2dqVmZQR2hZSjR1UEFreldDYS84ZXpxOTVnQWw5OTZtK0VHWkZq?=
 =?utf-8?B?SjRUK0JGd25EQ3A1R3V5MUYzbi9BMlVSN1QzcnU4RlllWXp0dENmMVB5eFBy?=
 =?utf-8?B?OHFhaGRrZW9rQjBnbENTaHZ3RzhTSlB6a0Iwd21pL1E1WG9KMllqdFhrOHNv?=
 =?utf-8?B?SXdEYUQyREoxeHoxNHlQd0hJWUt0QTNPaUZaY3VxZDFSN2FGTVh2cmZINmhz?=
 =?utf-8?B?MkcxNkQ1dnhxT1ZtNVlySTV2T0JZa0dzenpvekszbXFxTHh3enRyb21CWVFa?=
 =?utf-8?B?WjR1ZGtUSlFxdGJxeHJOdUF6bmNBSGs0czU4NlJiN2FOcElzSHFTOWRwc0FR?=
 =?utf-8?B?SHY4aVljeXJzSGpCN3h4RDRQeGdPLzM3a2tLc3BudURJczdBTXlBZktHREp6?=
 =?utf-8?B?TWJoa2o5a1lhVElQcFFPd3JKVWJmZ0NpTVlSeDQrYytZRSs5S2pkNVc2QmlF?=
 =?utf-8?B?NlZlRkR2dzIzYmZVNkU1Q0JSNnpXbm1uYnVZZ3VDVGUwZWJlMkJmOWdoQURy?=
 =?utf-8?B?U01wU2VEV0Q4QXVwcnhZZXVQVk13RXhpZlQxY084OFNLYzlFaG9vd3dINFBT?=
 =?utf-8?B?SEVRTnk1LzdTKzBzTkJmWjlZcHEvSFMzejJiRUM1QzhNSFRLbXZGVURKRlNk?=
 =?utf-8?B?ZGpwNXdneUxNMDQzL051bXZ5SEFkdGgyYTNqK2VWMy9MSjA0ZVkwcXQ3Z1ZZ?=
 =?utf-8?B?WlcwVVZFMFRrNUlONEJ5U21qRFFGZzc0SitiSzNNZU0rSzNDYjNQSnlTRE9C?=
 =?utf-8?B?ZlJvK1gvTFBKd0xXdmR6Vis5a01WeVVoZ3N3eWYzQmdKa2JIcEo0cy9UaEZz?=
 =?utf-8?B?TjlZZWhucytYQUtZSFJURVJDZ0RmSDBjakVhMlo5NDF1RVlNMk52dmVyZ1Jt?=
 =?utf-8?Q?NsoMyuTx1DftdbznOvG/97lzHMBsraOe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnBROGJvSHdmelROV0Q0VVc4YVFFdDJnNTFRbFUvKzNIUUQ0UmlRSFBzRWZL?=
 =?utf-8?B?VktYQldKMTRxcDZPN2ZPSzBJSWlZSG00bzFhMnFpR3dFT1RISXNrdUJUL0l1?=
 =?utf-8?B?ak0yN2QzUkNqWWxld1RocW1GV3djMGxBZloydE5KQ0ltUnJCWmJZR241a1Ni?=
 =?utf-8?B?S2UrRUZ1U3RWWXlLdTlzb2xqZGl5czFLYVR2SmlIWGZXa2U3L0RqZkRic2s5?=
 =?utf-8?B?NnpHUTBVRkpoVndiWjFIc2dRVXg3QmxNWFl4bUpYc3lwSGN3VnZwZjFXM0dh?=
 =?utf-8?B?Wk5IQzVyTnpaSzdmc0JtbWEvUU1EQmxUL2pHUkxiNjVpN0FQZlJ4eTBXQ3Qz?=
 =?utf-8?B?aGpkWGdaMkt6QXlDeE5IWEFDWmJzcHA5dnRBbGpaUzNScFo0Ny9qM2FZQThv?=
 =?utf-8?B?bFlMc3hFYWRDalRaWTREUVA5VnBaVmxwaTI3a2dLSzNWbnZOL2phTHh6N3VH?=
 =?utf-8?B?SFJvalAyZG1XUCtGQUxzMHhJWjlpbWZreTMvd2Q2amx5d3BVYWRmbjFuQTJy?=
 =?utf-8?B?cnZNMnAzZUttaVkySS9GZmJGNnBLV0RNSS8wOFlVbXJwKzNQbXlRM05wMjdl?=
 =?utf-8?B?RWJocndlLzMrZmc0ZVhKWCtyOG9EUFVMRzRmYi8zWElDcUVLR0xTQ0JFNzYw?=
 =?utf-8?B?QkVOTWNRSk1tNlJUVmFEK2taS2grUWhUaG9IcURMMG1tYW5hcEJ2bXZ3SHhO?=
 =?utf-8?B?Qk9velN0bXRoUHVSN3BnT0ZieU5hMXVZT1l5QXBKbmZuU2dIUGh0a1JRZGdR?=
 =?utf-8?B?aFpjSWtxejJ4VDloSUxCSUVPUUxvVWVNT29PZDM2MXVqNmp2clh2dWhvR21I?=
 =?utf-8?B?V3Jyc2FnYjFqWmZEK0w2ZDNQanJkZ2FsV29VbmdJUTV3N21vQVNKcGdBZ0pI?=
 =?utf-8?B?MGxnUnkvV2xBRGl0UEpTa0RyRzFiMlpUSS81UlllSzhOS3ZjUkNySzZHUVhG?=
 =?utf-8?B?ZDJ6RXI1RkxBeEpUUUdWN2Jhd2Nzd3ZvYmtiaG9MN2FFVDhaOHZNVWxDNHFX?=
 =?utf-8?B?TGRwSUF1NEJMejRCYTI2UjFvRVlsTGw2MWRWQllKQ3FSbyt4VXdRTTIvNkxw?=
 =?utf-8?B?L3pjWXptR0ZVUTJDaHQvN2dnamd4QTVEZmQyRHRKUUNlTTJVend0VzBPbUtm?=
 =?utf-8?B?WjBDLzQydnRvb1N1djZIRkNNVml3U050UWVFeGh2WmZCMUJlVW50c3FmOU9Q?=
 =?utf-8?B?Y1FHUW1XY2NxeFYvYzlPREJreUtUL2FPSXNxYUJrTzhIQjBWSTlQTVg3enp2?=
 =?utf-8?B?YjF6VjE4dDEzUUIrMm04K1NyeUxZVm9aNWRrdVhTRjNYNUoxVHZZR0w3c3hh?=
 =?utf-8?B?NjBORk04NVRJZTljRnRlVkErZ283V0tiSktVNnpEVTEyTkRXVjQvZ01JdEcr?=
 =?utf-8?B?aXdjRlBBY203bjR0RVBiTjMyQWpvcGh2ZVZTNG53SGFHeTlDTlVLdGM0VVp1?=
 =?utf-8?B?dDNsYjgxZC83OXovMy9EbnFTaVNNQVgzZXZpa0VPRU1jNkk5cGovWG5EQmhv?=
 =?utf-8?B?Y3RXbk1qSXppd1hROXZnSUY3U2ZsYzhyTkRSdVVYWkVhVUpCZExNd0JKZkRw?=
 =?utf-8?B?TFBUZWRpUHJ1YnBwbWdOM2RLY3R3MVA4cFl6a2ZLS0N1NGIzQ1hWSmY3Y1JV?=
 =?utf-8?B?c3pWcWNucC9jbEJwMUlwSzJKVW5sb3Jtell4ZC9YMkpOZzZLK2QvZGVDZEQy?=
 =?utf-8?B?Y0g1UjMvb0YzZGgyMmV6S3JTL1B0RDJQOFREbUNBUWNZSWVqL1p0a2RDUXhV?=
 =?utf-8?B?U3haM0lMaEIyNUh2bk5kUVF4Z1JUbE1UR0NqR0lqaE0yUldMeHZabmsrYmRh?=
 =?utf-8?B?cEpDVUpqaEFaSEVkSTJndFlMNHJaSmpoaEhoMExnUnlFeTljeTF3QmxuY2Ji?=
 =?utf-8?B?aFlDV05FN0swU21OQ2dzYUV4NTBlNXVwMEhmckwvUXBEZ252N1RYSHhvU0R5?=
 =?utf-8?B?YmZNZ3NKUS9OU1dDUGhkZTIyeXo1cHZ3NkRKbFJKS2JrQnRhYXVldmk0dHpq?=
 =?utf-8?B?RDJwMEd0M2FMa1pnWWJsc1A3ZzgvV1V0eXY4VEsxOGhMVDAxeGNQWmJPbDEw?=
 =?utf-8?B?Y1g3YnVlUE1DV0RYc0hxQUtmMW1vUXBUc2hhREpONXQ3UlNlRWo4dGlXdGVv?=
 =?utf-8?B?OG1oc1RrMHY3NnVaSGtyMHZTbEU1ME4wcW05NG1VTTM1ckczbGptUkRGYVdr?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2076f3d9-3889-43c3-d043-08de07455a05
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 15:05:58.0104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tSVJ8I7c6J73KZoX+WXQTTNPaz7HI7xL6DRIdthQwMSq5r1iSQeFXKL60hdPHZJb7bLoLN/OrZVK9oVtkuLygZ/IGwdXjQ9IEIGLgZQ2V78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6410
X-OriginatorOrg: intel.com

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu, 9 Oct 2025 16:27:50 +0200

> On Wed, Oct 08, 2025 at 06:56:59PM +0200, Alexander Lobakin wrote:
>> Turned out certain clearly invalid values passed in &xdp_desc from
>> userspace can pass xp_{,un}aligned_validate_desc() and then lead
>> to UBs or just invalid frames to be queued for xmit.
>>
>> desc->len close to ``U32_MAX`` with a non-zero pool->tx_metadata_len
>> can cause positive integer overflow and wraparound, the same way low
>> enough desc->addr with a non-zero pool->tx_metadata_len can cause
>> negative integer overflow. Both scenarios can then pass the
>> validation successfully.
> 
> Hmm, when underflow happens the addr would be enormous, passing
> existing validation would really be rare. However let us fix it while at
> it.

It depends on how big pool->addrs_cnt can be. I haven't dug deep into
the internals, is this value also userspace-supplied or generated by the
core code and is always valid?

Also see below (xp_aligned_validate_desc()).

> 
>> This doesn't happen with valid XSk applications, but can be used
>> to perform attacks.
>>
>> Always promote desc->len to ``u64`` first to exclude positive
>> overflows of it. Use explicit check_{add,sub}_overflow() when
>> validating desc->addr (which is ``u64`` already).
>>
>> bloat-o-meter reports a little growth of the code size:
>>
>> add/remove: 0/0 grow/shrink: 2/1 up/down: 60/-16 (44)
>> Function                                     old     new   delta
>> xskq_cons_peek_desc                          299     330     +31
>> xsk_tx_peek_release_desc_batch               973    1002     +29
>> xsk_generic_xmit                            3148    3132     -16
>>
>> but hopefully this doesn't hurt the performance much.
> 
> Let us be fully transparent and link the previous discussion here?

As per a quick discussion with the maintainers yesterday, we would like
to not mention FSB-sponsored code/companies in any way...

> 
> I was commenting that breaking up single statement to multiple branches
> might affect subtly performance as this code is executed per each

The compilers successfully merge such stuff.

The only overhead introduced is the calls to
__builtin_{add,sub}_overflow(), they are definitely inlined (compiler
intrinsics), also check_{add,sub}_overflow() are wrapped with
unlikely(), but still may take a couple instructions.

> descriptor. Jason tested copy+aligned mode, let us see if zc+unaligned
> mode is affected.
> 
> <rant>
> I am also thinking about test side, but xsk tx metadata came with a
> separate test (xdp_hw_metadata), which was rather about testing positive
> cases. That is probably a separate discussion, but metadata negative
> tests should appear somewhere, I suppose xskxceiver would be a good fit,
> but then, should we merge the existing logic from xdp_hw_metadata?
> </rant>

I'd love to write a test that would prove that invalid descriptors are
successfully rejected, but rather separately from this particular fix.

[...]

>> @@ -143,14 +143,24 @@ static inline bool xp_unused_options_set(u32 options)
>>  static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
>>  					    struct xdp_desc *desc)
>>  {
>> -	u64 addr = desc->addr - pool->tx_metadata_len;
>> -	u64 len = desc->len + pool->tx_metadata_len;
>> -	u64 offset = addr & (pool->chunk_size - 1);
>> +	u64 len = desc->len;
>> +	u64 addr, offset;
>>  
>> -	if (!desc->len)
>> +	if (!len)
> 
> This is yet another thing being fixed here as for non-zero tx_metadata_len
> we were allowing 0 length descriptors... :< overall feels like we relied
> too much on contract with userspace WRT descriptor layout.
> 
> If zc perf is fine, then:
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
>>  		return false;
>>  
>> -	if (offset + len > pool->chunk_size)
>> +	/* Can overflow if desc->addr < pool->tx_metadata_len */
>> +	if (check_sub_overflow(desc->addr, pool->tx_metadata_len, &addr))
>> +		return false;
>> +
>> +	offset = addr & (pool->chunk_size - 1);

If there's an overflow and @addr went crazy, @offset can still be valid
as it's capped by pool->chunk_size here.

>> +
>> +	/*
>> +	 * Can't overflow: @offset is guaranteed to be < ``U32_MAX``
>> +	 * (pool->chunk_size is ``u32``), @len is guaranteed
>> +	 * to be <= ``U32_MAX``.
>> +	 */
>> +	if (offset + len + pool->tx_metadata_len > pool->chunk_size)
>>  		return false;
>>  
>>  	if (addr >= pool->addrs_cnt)

But if pool->addrs_cnt is always valid, insanely big @addr would be
rejected here, right.

Thanks,
Olek

