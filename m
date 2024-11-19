Return-Path: <bpf+bounces-45177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC66D9D253A
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 13:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58A6EB212B6
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 12:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D344D1CB9E8;
	Tue, 19 Nov 2024 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gjlVngJ4"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA2214E2C0;
	Tue, 19 Nov 2024 12:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732017926; cv=fail; b=lOqtjzRmILHshVkFeIjfewhuDB7NDbd2yqwyghMKMm/4NZFB4CjsAH/wyhV06It+Sjx76LW7J2KQTT7u73Eg+VVuayS6iysKk9N/jcFSqdgnjhXsOlgjlvBRXRDrHXeod33MKs6gK8XrB1zDo5e3ZUvGJQl5XfjBTLy0OZMcWVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732017926; c=relaxed/simple;
	bh=qwhTCCxp5tkgMk/n+zVkM1cBALb/UwgT7kM/FsW3/P4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q2GIARZrwxL33Ys6SfzD0WxbHggQ7Ek8Pp27CKLqtfex6k8eQASlg0SrCO/NyesqsObPOdGqaGuS7H56HLxGsi/uoCB8Tif4yjNmtfWFQuZqzU0NQ9qbA2/cSZee0HfQ/JMpxvkYuC1kI/LT7K4qSctemVCl/IBWrgQIJrsB7/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gjlVngJ4; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732017924; x=1763553924;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qwhTCCxp5tkgMk/n+zVkM1cBALb/UwgT7kM/FsW3/P4=;
  b=gjlVngJ4XnVRIhIGv61HCMoiRHS5CrJofA2ZlY9KslBmyOxc43iM5Zd4
   W97os7VryFbhYnhoXmiLtfgBqupuWhIhLXHuuRekUidc0+Hrd0qdU3RIV
   /8C3dcb9uooL3FZHQdGJplVdMCc9thNuZDr+DZ3BEwW/roHO/H2v7ivkq
   WRwTzEViq9PM0VfoGx/MjFzNfLkqvj9Us4X71TtrOTwMfYtYWx+i6XRBc
   7zy3upZ4OE75fgwMlG7R0I1fNOac7yI9GR37aftPK22vF1XEvs46dixV1
   XVNnQ6VQ4mBeIulaPtOs+HFNzOmhqxalC/EUJwv/elPzbOiIuOHexYQmB
   A==;
X-CSE-ConnectionGUID: IRkN33jeSjaIw6cz9T9zdA==
X-CSE-MsgGUID: OuRYq9EgTQq7KS/A+q369w==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="43080887"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="43080887"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 04:05:23 -0800
X-CSE-ConnectionGUID: 113/hN/3Q6e2gKjFSuR5VQ==
X-CSE-MsgGUID: V4l2uCHISA2Zi/agSkpEVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="93606585"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2024 04:05:23 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 19 Nov 2024 04:05:22 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 19 Nov 2024 04:05:22 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 04:05:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bk2WTHM8BmqNQYsIJT2WpxkTOK85c2wwseMLehfYQ+h/6XJ7WKmKPEqhB9hdXAb2+a/g8kB/YuF+D70HPHho81XBU05lzNew3nHlHOqd5WjYFZGEMYQJz6l8i+nNCn16ooPZjzuPnmJSeuaCKwKmqclgcQW4rYcKPQK/kjq2PS1sPJEC/rNqi7l/iKsLQXdMWijH40cwpl26URFxRx2+gEc4m5jGZCuxHleYJH0JrDYEcV/CJqPV4dHRAFAOZEzRhJhE6teX7TKWevzO9zsimwwJ74YfjFUFbs/WbSpN5WTEqmiJEtkiAPZNte1KSmuPPcNGXIs9s8gR4qrD/BIAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cn4FMAODo2oKe4HCh3xhdNCUJlzPdOcY52MpGvrCKnk=;
 b=Zx1x68MLVRKbCznVXTR8tNSjD7M+Kvbtli2HbqYShIXVQbtOXAD43JslEWFcDNVva37mH4F1blI5XDHGFrVwPLG/ZnvqrAEGmSB1iEvleLSn/clewxgOjUxS/U4vAwYnvh7nVM+wlJ0K0SeEWdGA5UjkZiB9i7oPISb1OhLdYvxPRUqzM26g1SghBX+pA21WtT0Y3SVR+apz/svCUyTHV9OW1+jg7cLYKwIjATMUVQ2nxFZkdqvdbC0N/KucapppMOFN5GT+ejrT+FktbXFjzJiUKRIoD4ONh/X1hwiJpx99B7Sni553FReFOaRpY4OSQQP4ek/RiOlNDLQaFnWqTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY8PR11MB7057.namprd11.prod.outlook.com (2603:10b6:930:53::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 12:05:19 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 12:05:19 +0000
Message-ID: <b37c2b10-ac0c-48e3-9352-77963a6d7c7b@intel.com>
Date: Tue, 19 Nov 2024 13:05:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 12/19] xdp: add generic
 xdp_build_skb_from_buff()
To: Amit Cohen <amcohen@nvidia.com>
CC: Ido Schimmel <idosch@idosch.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>,
	"nex.sw.ncis.osdt.itp.upstreaming@intel.com"
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
 <20241113152442.4000468-13-aleksander.lobakin@intel.com>
 <ZzYR2ZJ1mGRq12VL@shredder> <ZzYUXPq_KtjpNffW@shredder>
 <59d1cb78-8323-426a-b1b5-e5163b29569c@intel.com>
 <LV2PR12MB59435D8F548C8DA2E317DC6FCB262@LV2PR12MB5943.namprd12.prod.outlook.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <LV2PR12MB59435D8F548C8DA2E317DC6FCB262@LV2PR12MB5943.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0004.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::15) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY8PR11MB7057:EE_
X-MS-Office365-Filtering-Correlation-Id: c189b742-1a77-4116-d722-08dd08926f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2ZWYUhySnhQbmg0U3RrY2Y2K25jL2pNZzRyTjErd2J0aDZFNlp4M2Q3eFR0?=
 =?utf-8?B?OHFodWx0VkIraEJUL0VGM3dZSU1lVExhUElxb3FnbEtsNFphM0tQY2JlS01N?=
 =?utf-8?B?b3lpV3gvemNDRWRPU1l4UlBseExiaUVJeWd6aUhGS29zUlBLV0t2T28yMVMr?=
 =?utf-8?B?WFFNRlpJNG5qNjFyOGk1alViQzhDSDB3TUJmbnk1QTlGM0ZtcVE4QW1YdG5z?=
 =?utf-8?B?K25DZC91UHZoY3ZZcWFEWmR5dGhWTE0vRElyVlExVUR3OHg5aFZBYXJRK2d1?=
 =?utf-8?B?UHc5bnlLR0hwYkJtcjhNVGt0YjZLWXZrQk5NdndpeUJCRXE1OEx2clpvWktW?=
 =?utf-8?B?bnNZSEdZVVZQUm5RT3hLZTdEenFKN2NlMDBqdzBLcWllZCsvSDNNc21wbnNx?=
 =?utf-8?B?SFZ4SkRqRVM0V2FrT1dUTStVWGcrcGxTOFFES2FHZHpkMHdDaWE0aEQzSUJR?=
 =?utf-8?B?eHViZDFScUNkWllHU1VkY3hhYU1yVytVdXJuZ3ZZRGpOeUp1L1hGbkROTzZL?=
 =?utf-8?B?TDBNUnJPbVlIS0ZsTFJOTDFHQzV5c3lubHlWSTJRWm9rZ1JYSnB4MjZsZWRr?=
 =?utf-8?B?VlJLTGFWVndpV1RaWThDNVJydXM2QXhvekluWThxVHVWczBtZjd0a0NKbWM1?=
 =?utf-8?B?R2k1dVZkMDZwQnN6NDJiNTZTV0RYSU1ySWJKMERWOWJyTmlxMkJPWXBvVlRq?=
 =?utf-8?B?WE42bHZVYlBMUzVaNDlQczVWZW9xN1RwYU4wVnltNnlRdHF3SFoza0N0ZHZQ?=
 =?utf-8?B?aGxFTGd6WXdOYTlLd2ZFS3RybWpZUnNYdDZSUktXaUtHT1p2YVlRajVWVE03?=
 =?utf-8?B?TjRURE1BTnpYRFgvWVBOaEh0bWZ3Zm5iQXUzRlN6Q1kzQlhuOVhieVBDU2dE?=
 =?utf-8?B?Z05ReVVaK3ZIQTlXc3o1cDVMcllPajlhOUdoMUd3cms2eVZhRW1keWtBRENz?=
 =?utf-8?B?SjlNVGcvai9MZVJDMTVMOFFaeHFTQWhOdllYNzdaT1MxSk9QcWFTbmZzVEZT?=
 =?utf-8?B?aS9WOTIwQXdNdENNRkZKa1pWMTBPb282SDBpWGlPRjBJNEpPc0RvbXFCU3Fp?=
 =?utf-8?B?L1RqNzl1cjdabTYyZVMrQ1I5cjU1QjhpQmVkVjZPUnJkME5CMkQ1MDV6L2Nq?=
 =?utf-8?B?QzUrUlU5aVRkOWo2LzJTNlZib0pkaGV1N3dqUi9ma0thL0ljTFN0aHVLRzYy?=
 =?utf-8?B?UE5Ycmt2N2Vhck1OK1ptNENSSUcvMTdZY2VjTWN0bHdCT1pmdEhwOFdnSnhW?=
 =?utf-8?B?QnBqanYzTWMvcDhLUTlhTGZ3dGZHcS9kSlhBOEVnSDBhdVhMQ0NHL0FPVzB2?=
 =?utf-8?B?S3JabExzMlhQaUlQdnVZbjFHL2xJTGxQVnVDR1NkQnVhZllqQ1JKMU5DTHhq?=
 =?utf-8?B?UkU1MzVPdUlHN29WRDR2NFZSSkVKZktMaE00Vmttd041OThJRCtYNXM1VFp6?=
 =?utf-8?B?aFNpUi9JcGY3bkpRRU9EYUkrMXQxb3lmQTlWVHIyekVGNTJ4d1V2dHI5U3ZT?=
 =?utf-8?B?RC8yYUZTRXpKck12Q1VJZm9PeG9GK1BjcU1uM3dXYkVHL2Jyc29mblJweW1u?=
 =?utf-8?B?NUU0cW1aVHE1V25rUHRmTlc5VnFMTnBsZXpwa0N3d20zaVJsTHMyeUhoamJD?=
 =?utf-8?B?UlJJbEhRWHVhTW9iZlhKZjJYTGZ3cVRsQThYcFMwSkcyWVFFa2dndldYRkh6?=
 =?utf-8?B?cFBKY1pYdVRBVmUwWFg2VE9ET1FaNXJ6eVdPZ2p1aHEvUVIrajlYb1dtR2hE?=
 =?utf-8?Q?MeSLVOBUFb90SlpFhw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVBybGZxaWw5WEJTUkFINGIyUGRSdm11Z2RhVVB2VU9sNVN0ekdKcGVyODl3?=
 =?utf-8?B?OGhUTkRnMmNZZk9PVExaZUpDYk1Xb2xvNWwwaC9RVmIwcFZjSDdLbGZkOGJ6?=
 =?utf-8?B?QldaVk9HMEQ1WkppS2lUSjZSNkpRWHFQd0xZZTd5Nm5DQktXN21MSTJLTnUw?=
 =?utf-8?B?V3JSNlhHV2NvSjdQdEdpbXdDMlcvenBrMDFEWDhtZ053UGdQRHhoVWJPRi85?=
 =?utf-8?B?aDZnYUhhcC9LNUEybmVkQnVmQlp0SVpPQTNra0xNb01ZQ0x0NjlpL1lHWm5E?=
 =?utf-8?B?Y0lFZDdmbzJubkhVV2pocmdNLytXbGMrQlFNVVl4Z2F2b3hLdDNRbms5YVlE?=
 =?utf-8?B?UmkxRnFud1BlSjlBNU1pZTNrSXdVMzBlWVFqMUJqcmRWemd6L2lYWlJ2WHZj?=
 =?utf-8?B?WVpNQzJmalZwMXhhUk50S3RaY2crMDFjTE9NeTZPYkV2Qi9ndHpncWxkeHd3?=
 =?utf-8?B?Zno5MmNpNDZmZUYwYXBMMmYyODVNSi9CS0FZMCtrS1BzN0xxeVdaRCtlSjcx?=
 =?utf-8?B?K3FHaythNHZoVnU2bDY2c0tEY3hvTmV5RFlPWit3MG9zdWx5cFJERmhIc0Vl?=
 =?utf-8?B?WGdmR0pwR1JrVUpUMU9YYXBUeWVIdDhJUmk4TW5FbTZkaW03Z2RoWFFxZnQ2?=
 =?utf-8?B?bzVleS9vdTQvWUVwSyt0TTIwbklaeitMcHRhS1pZcWc3a3NVR09rSDZyWTAw?=
 =?utf-8?B?SzV2QWVpbHUyaGxIT2dxR2lFaW16VEU2eXdJOUhhd0NWVmJIZ2FoMXNZUm9W?=
 =?utf-8?B?MWNja3J6YXZiTUFlTklmQVZrOHc4WTFuQnBSUHB5WEFCWHRxL2M2bVFRcHIv?=
 =?utf-8?B?c2FYSXpTbmVMeTBBamhLc29rNjVzK2xHSUdDUmFNOVhEYURPMnBPdWJKS0VU?=
 =?utf-8?B?QmdkYUZUVGk5OXJLSnExZWVjczBoUWlHUUV3bGJYRzAxNHI5S2R5V2w5ZGxt?=
 =?utf-8?B?SDA2czZMV3NwdUE3czVTRUlaVUVlYmJmVTc0TzdTWFlHOFdvZURseTdIMkls?=
 =?utf-8?B?a25mc0tnYnpMWFlzVVNNYzcvbktSQmp4TFIxdU41Q2N2dUtWVWprZERpOGxK?=
 =?utf-8?B?VWhvbW9kbUFWZVJBaDdmTG1nRk9icDM1RDBVR2ZnWEtEbFFNamJMR3RJdE15?=
 =?utf-8?B?M2RDeW5nRzFkT3dkSnF4MzVwd2FpclZWSG1jQXp3eHp3b0RSbVR6WUR5K0hJ?=
 =?utf-8?B?bGNhYUlDYk1OM1lPbXphZFQycDVIczZpSGd1Z3VTQ295Rmw2Tncvb052aXoy?=
 =?utf-8?B?RW1QcWhLcm1LL2JXNHhTeFYybnN6VDVIZnlGWWVZSmVIbElCZGZiLzRKVkF3?=
 =?utf-8?B?K2VobUk4T2F1aVFjMFRJQk9jaGs5eXV2YUNKekxncUVuLzRZZzR2YXBGRGtz?=
 =?utf-8?B?VndMQ3dpRUdISitraWtZL3B1RUx6QVpaOUNTK3llMTRCTldUYkpWQUlaK3Qv?=
 =?utf-8?B?UDhsZDA4SnRkV3o5bU9lVFQwSkJMT1d3aUZZeWdSRGZBL2VtTkd5K09MbG5N?=
 =?utf-8?B?d2FRdlpPcGQxb1BRN1ZnbDg2VzlmbC9rTWZnNVZ5NW9QRjU4UHVzcHNwQTFB?=
 =?utf-8?B?c1oySnlENDZUMlJzYXBTSkVDNW5rK09NNFVQdWgwMUh2ZzRPZ29URWJ5Kzc2?=
 =?utf-8?B?cE1WZWxHb2xZK21DM3g5T1gycmJuczhtTUE2VHhrUDd6d1I2ekRxNFU2eXZK?=
 =?utf-8?B?bndXRy9ZMHIwcDJTL1Y0SFNoaDdZY1E4dG44cEdObDJpcWptTnh4MXNVaVdT?=
 =?utf-8?B?OFV4SWxSUXZjTGJ6Z0EvWGk1Y2xRVi9kYlBwL3c0VXJtd3FlTEJ6SGpteTNh?=
 =?utf-8?B?ZitGRkhwUENvOUNjZUNpRGllLzRHS0dOVGhPYXZiclJHdzU5T2FSZ3FrRW9K?=
 =?utf-8?B?T1VQZVYvUFBvNUlrYnBXRzFuMldNUHJrbytGelBScVVGWGRwTnBNc1IyY2NS?=
 =?utf-8?B?VWlqTm5WWFR2MzJVcWwxcENEK3ErM0F4dTZhVHZJd2hZeTBXRzVmNmpuNFVt?=
 =?utf-8?B?K3BKWXcwYXNVWDV2TkdMQ3NRV0oxWGgxd3ExcWg4cjFWZVpodVZNWmdlQllK?=
 =?utf-8?B?Q3BBWEFoNFVBUFVpUUk1R3d3Y0lVMzF4Z00yQ2tRVU9ick4vWnYwSFdiN3dT?=
 =?utf-8?B?Mmx2eVVMU0J3L1k0cElYV2FWc2FKMGhmSEFGdjRBeW9CMlNJM0hyeXNpbXJI?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c189b742-1a77-4116-d722-08dd08926f76
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 12:05:18.7395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GoUYhPUYnM2vlQl5f570gC1Ds9lsr6lGmb/bf1KPrstZdudRCZwpGumfT/iJpvECfWJrxdYaMF9kjNheU0bdoJf9ofT0U+FSVBXupJqYREA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7057
X-OriginatorOrg: intel.com

From: Amit Cohen <amcohen@nvidia.com>
Date: Sun, 17 Nov 2024 12:42:11 +0000

> 
> 
>> -----Original Message-----
>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Sent: Friday, 15 November 2024 16:35
>> To: Ido Schimmel <idosch@idosch.org>
>> Cc: David S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
>> <pabeni@redhat.com>; Toke Høiland-Jørgensen <toke@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel Borkmann
>> <daniel@iogearbox.net>; John Fastabend <john.fastabend@gmail.com>; Andrii Nakryiko <andrii@kernel.org>; Maciej Fijalkowski
>> <maciej.fijalkowski@intel.com>; Stanislav Fomichev <sdf@fomichev.me>; Magnus Karlsson <magnus.karlsson@intel.com>;
>> nex.sw.ncis.osdt.itp.upstreaming@intel.com; bpf@vger.kernel.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH net-next v5 12/19] xdp: add generic xdp_build_skb_from_buff()
>>
>> From: Ido Schimmel <idosch@idosch.org>
>> Date: Thu, 14 Nov 2024 17:16:44 +0200
>>
>>> On Thu, Nov 14, 2024 at 05:06:06PM +0200, Ido Schimmel wrote:
>>>> Looks good (no objections to the patch), but I have a question. See
>>>> below.
>>>>
>>>> On Wed, Nov 13, 2024 at 04:24:35PM +0100, Alexander Lobakin wrote:
>>>>> The code which builds an skb from an &xdp_buff keeps multiplying itself
>>>>> around the drivers with almost no changes. Let's try to stop that by
>>>>> adding a generic function.
>>>>> Unlike __xdp_build_skb_from_frame(), always allocate an skbuff head
>>>>> using napi_build_skb() and make use of the available xdp_rxq pointer to
>>>>> assign the Rx queue index. In case of PP-backed buffer, mark the skb to
>>>>> be recycled, as every PP user's been switched to recycle skbs.
>>>>>
>>>>> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
>>>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>>>
>>>> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>>>>
>>>>> ---
>>>>>  include/net/xdp.h |  1 +
>>>>>  net/core/xdp.c    | 55 +++++++++++++++++++++++++++++++++++++++++++++++
>>>>>  2 files changed, 56 insertions(+)
>>>>>
>>>>> diff --git a/include/net/xdp.h b/include/net/xdp.h
>>>>> index 4c19042adf80..b0a25b7060ff 100644
>>>>> --- a/include/net/xdp.h
>>>>> +++ b/include/net/xdp.h
>>>>> @@ -330,6 +330,7 @@ xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
>>>>>  void xdp_warn(const char *msg, const char *func, const int line);
>>>>>  #define XDP_WARN(msg) xdp_warn(msg, __func__, __LINE__)
>>>>>
>>>>> +struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp);
>>>>>  struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp);
>>>>>  struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
>>>>>  					   struct sk_buff *skb,
>>>>> diff --git a/net/core/xdp.c b/net/core/xdp.c
>>>>> index b1b426a9b146..3a9a3c14b080 100644
>>>>> --- a/net/core/xdp.c
>>>>> +++ b/net/core/xdp.c
>>>>> @@ -624,6 +624,61 @@ int xdp_alloc_skb_bulk(void **skbs, int n_skb, gfp_t gfp)
>>>>>  }
>>>>>  EXPORT_SYMBOL_GPL(xdp_alloc_skb_bulk);
>>>>>
>>>>> +/**
>>>>> + * xdp_build_skb_from_buff - create an skb from an &xdp_buff
>>>>> + * @xdp: &xdp_buff to convert to an skb
>>>>> + *
>>>>> + * Perform common operations to create a new skb to pass up the stack from
>>>>> + * an &xdp_buff: allocate an skb head from the NAPI percpu cache, initialize
>>>>> + * skb data pointers and offsets, set the recycle bit if the buff is PP-backed,
>>>>> + * Rx queue index, protocol and update frags info.
>>>>> + *
>>>>> + * Return: new &sk_buff on success, %NULL on error.
>>>>> + */
>>>>> +struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
>>>>> +{
>>>>> +	const struct xdp_rxq_info *rxq = xdp->rxq;
>>>>> +	const struct skb_shared_info *sinfo;
>>>>> +	struct sk_buff *skb;
>>>>> +	u32 nr_frags = 0;
>>>>> +	int metalen;
>>>>> +
>>>>> +	if (unlikely(xdp_buff_has_frags(xdp))) {
>>>>> +		sinfo = xdp_get_shared_info_from_buff(xdp);
>>>>> +		nr_frags = sinfo->nr_frags;
>>>>> +	}
>>>>> +
>>>>> +	skb = napi_build_skb(xdp->data_hard_start, xdp->frame_sz);
>>>>> +	if (unlikely(!skb))
>>>>> +		return NULL;
>>>>> +
>>>>> +	skb_reserve(skb, xdp->data - xdp->data_hard_start);
>>>>> +	__skb_put(skb, xdp->data_end - xdp->data);
>>>>> +
>>>>> +	metalen = xdp->data - xdp->data_meta;
>>>>> +	if (metalen > 0)
>>>>> +		skb_metadata_set(skb, metalen);
>>>>> +
>>>>> +	if (is_page_pool_compiled_in() && rxq->mem.type == MEM_TYPE_PAGE_POOL)
>>>>> +		skb_mark_for_recycle(skb);
>>>>> +
>>>>> +	skb_record_rx_queue(skb, rxq->queue_index);
>>>>> +
>>>>> +	if (unlikely(nr_frags)) {
>>>>> +		u32 tsize;
>>>>> +
>>>>> +		tsize = sinfo->xdp_frags_truesize ? : nr_frags * xdp->frame_sz;
>>>>> +		xdp_update_skb_shared_info(skb, nr_frags,
>>>>> +					   sinfo->xdp_frags_size, tsize,
>>>>> +					   xdp_buff_is_frag_pfmemalloc(xdp));
>>>>> +	}
>>>>> +
>>>>> +	skb->protocol = eth_type_trans(skb, rxq->dev);
>>>>
>>>> The device we are working with has more ports (net devices) than Rx
>>>> queues, so each queue can receive packets from different net devices.
>>>> Currently, each Rx queue has its own NAPI instance and its own page
>>>> pool. All the Rx NAPI instances are initialized using the same dummy net
>>>> device which is allocated using alloc_netdev_dummy().
>>>>
>>>> What are our options with regards to the XDP Rx queue info structure? As
>>>> evident by this patch, it does not seem valid to register one such
>>>> structure per Rx queue and pass the dummy net device. Would it be valid
>>>> to register one such structure per port (net device) and pass zero for
>>>> the queue index and NAPI ID?
>>>
>>> Actually, this does not seem to be valid either as we need to associate
>>> an XDP Rx queue info with the correct page pool :/
>>
>> Right.
>> But I'd say, this assoc slowly becomes redundant. For example, idpf has
>> up to 4 page_pools per queue and I only pass 1 of them to rxq_info as
>> there are no other options. Regardless, its frames get processed
>> correctly thanks to that we have struct page::pp pointer + patch 9 from
>> this series which teaches put_page_bulk() to handle mixed bulks.
>>
>> Regarding your usecase -- after calling this function, you are free to
>> overwrite any skb fields as this helper doesn't pass it up the stack.
>> For example, in ice driver we have port reps and sometimes we need to
>> pass a different net_device, not the one saved in rxq_info. So when
>> switching to this function, we'll do eth_type_trans() once again (it's
>> either way under unlikely() in our code as it's swichdev slowpath).
>> Same for the queue number in rxq_info.
> 
> With this series, maintaining 'struct xdp_mem_allocator' in hash-table looks unnecessary.
> If so, xdp_reg_mem_model() does not need 'allocator' when mem_type is Page-Pool.
> 
> Is there a reason for not removing 'mem_id_ht'? With this patch, the nodes are no longer used.

Let me review this once again since I need to rebase it anyway.
Maybe we really could drop more code.

Thanks,
Olek

