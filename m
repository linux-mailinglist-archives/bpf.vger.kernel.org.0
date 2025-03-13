Return-Path: <bpf+bounces-53963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28647A5FB63
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 17:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C956D1886F74
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 16:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4180269808;
	Thu, 13 Mar 2025 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X5E5gnX3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24E7268FDA;
	Thu, 13 Mar 2025 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882816; cv=fail; b=dgGmTsdlHAmLHgmOK0NfffDDpKVk3hnXSV6CeOWGGJji7YrG35bsFq/nYJM0dyxDtLi46E5N/6UiBnv1jKcYu7Ohk9KdsobzyzVRskfh6ruG5prsMrDLYHWira5NdUPZKfEm7Ll/v6gYhJpvgwH89Kd8I2o5Wqmj8ptuJkhAGRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882816; c=relaxed/simple;
	bh=vk/xZ/2hoGc7IX73Q3l2oIyAgGSsF5HILuCxXnX7u0s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VTt0b4l5AJXh3JeKCdE9fb/TpOHW3A1lOTrVRkav64GVMJzpXGzLBx4yMzmGbixunuO+BvV67yapcOsv/lXTjzsz8SdBvoMPsutyIcDi6rTd4a7EmVS/tvlEKyE0dRb6ZAoHhBEcsipQ/C42m2wCw+qiFN6rw0T8yg5BjEiTkSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X5E5gnX3; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741882815; x=1773418815;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vk/xZ/2hoGc7IX73Q3l2oIyAgGSsF5HILuCxXnX7u0s=;
  b=X5E5gnX3g5XxAeuHxblsn3uU+xPMGMwFN4rvIL5CkgRIapuUTzOQLG6K
   rnAcZze46erXhuIHqw3PlfECNCLKPCrwXqL19QTZR86ZwhIpeV/y4Sqvf
   NxOmWR7X6v7dyEJqrT6zGTyFM/Wz3wDykDKVg0+g6i47+5EZ69eC2dOyd
   c3GNpriBUoCaTFvohBFDB6n2q/f9A61d01ViEqGgcA8HlaRORfoXj2oYp
   bXMCyEDes+wuqCuDXDIOgiBDjw1rjcmSZO+B2AsIBpytwoQf0KzhD755c
   Do7K13PRh5FSHZugUQz3WAhohOqVuAol2WRZLAKkgYYJjXF1xCGegM3eV
   Q==;
X-CSE-ConnectionGUID: 7oZQzbqPQhS4QPWfErSf5A==
X-CSE-MsgGUID: q1FMUYa/Q/i/FFHV/SdDNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53662437"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="53662437"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 09:20:14 -0700
X-CSE-ConnectionGUID: 6ejdKRP/RZuDlBD3Xj87pg==
X-CSE-MsgGUID: KGqpLnWYQ3yP7y1tkvGGOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121708852"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 09:20:13 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 13 Mar 2025 09:20:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Mar 2025 09:20:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 09:20:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtRJFwC+1POs7tZXGmfJ27UTIGYF2WvabKcqPymemUdXHNqhqKQZYKNUBdlVdKYfW9ZalQwGnO/GUQdqyhQOQWqrZJSL5m1OYMlS9xfkN9j8X3owfk7PLVEZpEvdbjJrRvQWyIr2fu3FZWvNTpLmWbRyrvyvT8eJWHFuqTvOhU49VdGA04MRRIWobO/mbfcq4KMbnECfs4osboHf9m1CoeZk9apA8JBeZu5jD9sk2RrVDiU6DBBH1OsLMXAwDuXclIdZ4sMvG9M+HljATcpuOqgsVWNVOo1p0ESH++EPsZeilMGzAaykhoaXLGffKLHCcm8Q+j2vqGp/1kQFCv2Kug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPt1oLXqUUN/YzlgZ/orSlk8dTT0KPsAhKFFyllRbI4=;
 b=UpNpTcnAFjZwOovGhywLUeVp6oU8iudRSnbTC0fZVF5ub8aiTcLBLihtx/PkcSqWP4soSqxMMBQNbz0HzuldxmyuosO7AaJJlD5taJJ9lw8whXZjyxoauXMCWHGvWYIrs5MlyHjDP+gcQ8PmUMEpCq/XI4OPJkEv8/ztlFArYpDd0M9DnXL1mA5wA0zEVkPQ0KWHRq0dpLr+yZ+0Xybeuawlh8IY5r5yYRPT94Bo7abR4xF47HHu/cL0FFicX4UyLmIZ5av6CmdqrdaKfy+IveZG7FwOYe3asTvPQYIQiHgszkIoVFry8E9JbNAbwKQnDdCzrbClCbSbebZd8Ii/1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS7PR11MB6197.namprd11.prod.outlook.com (2603:10b6:8:9b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 16:19:37 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 16:19:37 +0000
Message-ID: <e29e48e7-cc5e-4f32-ad99-d685fef9eb79@intel.com>
Date: Thu, 13 Mar 2025 17:19:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/16] idpf: add support for nointerrupt queues
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
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
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
 <20250305162132.1106080-11-aleksander.lobakin@intel.com>
 <Z8riNXXSw/ZBrD+B@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <Z8riNXXSw/ZBrD+B@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::11) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS7PR11MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: f823f4db-c79e-4d2b-f2a5-08dd624ad93d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1ZaZmtlZmR2ekxBMDUvd3RHckVsZ2t5ZmpoeXlveTZSSVdkdUcwL1JKSUxt?=
 =?utf-8?B?NnpHZXZmbzcwc0tHTlRXUUcvMDh6clNxbVFzL3lDNUEvd2dzZnh0NHJBZm9V?=
 =?utf-8?B?bWtaUFovM3FJTFlaa09iRWkzWmV0UGxramsxOFV6VzRnVWs2NHNHQTlLZEsz?=
 =?utf-8?B?Mks0MTRnK09CRk1ndjQwa0RuRURJM0RTd1JxZ0xDQzJ5djFQMStjTnl4RC96?=
 =?utf-8?B?OFNOTStLaHZZV2JCbmM3bGFudEdybzNmR1MxejFrcm9nZHcrZWY5T29xa0xu?=
 =?utf-8?B?K2U0U1RsZC9CUkprbVZoTy95OTJQMDVIcXRHT1BjM1JJT1pEb2FhVmpJdzcy?=
 =?utf-8?B?UnlkZFJtdTVSQ0RFWWdVYVU4eC8zNmFaLzZ0dnhOUXRqRXJHaFUzMmh1aVlB?=
 =?utf-8?B?Z3BxcTdwUmxDb3RueW1MNUhFa085bTI1VHVqTTNXL2w5elNqMDNXYzBQUHk0?=
 =?utf-8?B?ODFlRXgxU3drZ2NqNmdQUHpEdVBma2VxcEZJTGlwbDBvRnNZa25wMnBJUVdz?=
 =?utf-8?B?SDg0WHVzb0ZGdm9PMWNRVXhHTEtHNTd1bnpEbmJ6dHQzQm5pdkNoZmM0VGph?=
 =?utf-8?B?cnRkV2xrb1Z3Q21DKzVRaDZmRGQ0YVpTRUEzYy9XbjNYQzFvdTJSQy8rU3Zh?=
 =?utf-8?B?RVI4Ynd5d05LUzJ1dXVJUVhXcjlzV1lsS0g2eEtqdllaVXh1OEVEZk9tUkpG?=
 =?utf-8?B?bjZRS3lmQ2czcjRIV3VScUgyQTR2Tyt0RVlxUlEzdHhpeEpvNVhILzJXb2g5?=
 =?utf-8?B?UmFVWmd6Y3Iyc3ErcisxQ0JaZnlDa29kSUFlZEJheGQ3OG1oNkdXZUdnUGtR?=
 =?utf-8?B?SCtlaDJ6ekd6OVAveGZOSHA2Y25nTVJkb1M1RnN0OUFsR0RBeTJIa0kwWUlH?=
 =?utf-8?B?VzhYaGlCcENpSWpvbTBnTy9SWHVPM2FhdEgwOWpWUTBTQ1NOZGd3R0FoWDNv?=
 =?utf-8?B?ME9oZTJFQ3QrbnVBdExtc21ic01BRU45UDdiRjkyK1pydjRQd1NyR2diSVNS?=
 =?utf-8?B?Q1B6cldPeXIzSXRVMHhlbUdOVnNJNG5uVWk3c0R5WkozZHIrVlZ3YXMwSlNE?=
 =?utf-8?B?U2lpTy82TmtmOU42UWxvWmU3ZmlUNk83K3d3Qk5NYmd5NmNWUldPVCtPUnBR?=
 =?utf-8?B?VkpvKzhPME9YRU5UREUrT2dRRjFEVzJMbFJlanNwWXROQUdILzBHYlA5VmRy?=
 =?utf-8?B?TW51ZkJvNG4xU25YeUZlUkZ6NnVFUnk2UnM3K1BBRHRrUUs3eWgvRFhFQyt6?=
 =?utf-8?B?RDFnOHlhQTcrTHA2UEs5WldwN3A0K25ndmozU3FNUVFJWHdDT0VjSllkZmc3?=
 =?utf-8?B?bk5DT2poMFpjd1dlc1lMVzlvN0d6U2t4NTM1dWp0aVBsSGZWTDVqb2FmZ29x?=
 =?utf-8?B?VXFWWVdLdW43TmVVUHQrVzVxVG9VN1N6KzR6ZWd4em00OVlMQ2VGVEMwa2sz?=
 =?utf-8?B?ejZPWlVSNjZFY0pkZ2ZQZjlPNFpaQnVuNGwxZzR6aStiRExTY2R5eU9rL29l?=
 =?utf-8?B?SXFjd3o3U21FWTBUUUpZemE2V3NpV2NqR3N4UW92SFpoZ2tMNEM2MXg1NUhH?=
 =?utf-8?B?aEUwWTkrdWErSXR1RWlaVGk3VUtPYmYvd2tleURmMnYxajVzdlA1dDlXN09O?=
 =?utf-8?B?ZlZDMHpGN2RXRzVXb3NUU3dXb1hOUXNJeElqazRXM3BnYTRhN2RzVDZpSjEy?=
 =?utf-8?B?dkIxSFlodmVueThRWFVoZXUzSUtHazNGU1Q5Z1VGT21DNTZ3QTVJck0yRDhp?=
 =?utf-8?B?anJSR212SUxPNkFtNEE2dUpLRVRJMGQwZUtlaFg3cVkzTCtjVWoxd2FQbnZF?=
 =?utf-8?B?ZTdyZnJkMEZsOXZQZVdKdzlweHZtQUVSS2tPbjFlQTdOUE1hKytrVk41OHQz?=
 =?utf-8?Q?uaCUfOEs+dVKh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZytzYkhYUnNCNlo1emdkRjNreDJudVpyL2FQNlpmdzdaQXQ2VEFJYUtxdXEz?=
 =?utf-8?B?bGRuSEhrM011MWZEaWx5bVh2S21mVm5tSDB5TERpWmpUbXF3UVQ0VHBqTHdS?=
 =?utf-8?B?VWx4NStvY09iK0xKcUdya0FyNGhONEtpankyYnZZNkxrLytYV3JIMFNITUMv?=
 =?utf-8?B?N0pFNFJaUm5maC9GRXNNZjZUUUtVM0ZZVXZIa29QajZ1alQwQWNFaTBWWUpM?=
 =?utf-8?B?YUdDZUR6cWdQd1kxRHN6TDh1dTVBTitScSt0eGV0cDkzbGYrVC9qNm92LzYr?=
 =?utf-8?B?MEZNZlV0UEYzTVp3QXpTZm9UclRSWHJEaWV2d1VKeWxYMy9zWWN5OXlHWGs2?=
 =?utf-8?B?VjlPQ2h2UWVZN1RqQW1ueGdGaTFzSVZGVUdvQ1RqaHVzSlVvRE9WTlRhZ21R?=
 =?utf-8?B?c1d4MThXcy9Yd0RXeG93cXJrN0FSVTkxZSt4TWkrQU5xS0xSdEc0ZUYxalVM?=
 =?utf-8?B?ZFRUZWlsZU9wM25JRzh4R1ViREhrcmY2ekhmNFkxQ0txeHFIOWQvakEyQ2Ny?=
 =?utf-8?B?RUcwd3ZHdTNXczhxSE5CN1pOeDVJVEhiT2lseWVBeTJMalFvbGpkb2V2ZTRX?=
 =?utf-8?B?YklJYnlwZnYzVVBDZzkzTHhLTGh0UGxUNmRwVlRPaGV0RnU0VkNFa2FjQXJy?=
 =?utf-8?B?c0gvbEtzTlFEa1BIMFV3bnkybEtvbHZGZ3l6cUJrZ1MxTitlRzZscXRuZEtp?=
 =?utf-8?B?MytvS1VBRXZLVnhxa2ZpakZ6V3lOcVJZeEZ3bkVLOFR3WjF5Q0I3TU5ieDNS?=
 =?utf-8?B?a0NqNUVKdS9oelhjZ2gwekJ1T2dlb04wbWFHVUNyODFLYytQOWI4WEprZmN4?=
 =?utf-8?B?NStDR0kvTTgzdHBWT2p6bVNQeVk5aEVRKzRiVFlzUU9NNFlZRUlDRnpPczQ5?=
 =?utf-8?B?akNZYjNJTU9wRGJYS2pUZU02SUR6a3VBbFBiQ2JLY3RRaVJYTzNCM1RSZ0pp?=
 =?utf-8?B?QXRjKzkvSVNHMmk3cXptSFlPelo1MDVjNVprWWtEckpCZUc1YXhMSzR1OVBw?=
 =?utf-8?B?bSt3VEdKa3o1SGJDZGl5cmFuREdCVlRacWZmZXFCTTlCQzg1dCtOME1tNzFo?=
 =?utf-8?B?RFFJTllsUmNxeDRNS3dZVzlyejUvWVZNMjFZZUFuL1F0b1U2VytWZFZZaFhx?=
 =?utf-8?B?ZGtBbkJKdE05YWx3WVR0RStEdGljV3diT3V5NWFrUXlVWXlrYSt5dWRGL1Fs?=
 =?utf-8?B?WDNPeGV2cVhZTWtLbEg5U3l3UW1yV0libVVzeE41SE10U1EzT1cxNlNxNTNB?=
 =?utf-8?B?WmFwZUY4Z3dzMWd6N3BPaU1BZVJsTEhXTGsxN0p1Y09GL3liYjM4WkJsT2Fi?=
 =?utf-8?B?dFcrRnM0VnRVdVZiN3pFbm1QME95TExVMmU0TERIZVFXU2pUZjlqdFllcFVW?=
 =?utf-8?B?WmtUYmRDWm1nemM4Uk8ydzhKeTNqd2wyQTZNYUlGRnpnUDFzZ2FXTExLcm1Z?=
 =?utf-8?B?aUhyTkk3WVJaR05ER0kyT0NHQzlPMTIrUlBoYmhZcHdnZjFWdUF5QlZ4YUZH?=
 =?utf-8?B?ZkJOeVhiRlRuVysvTGZsbUZNUmpFejA3MldDaW95YlNLbFVvNDFhTUlkd2ll?=
 =?utf-8?B?cEl3R0hDeWdUd1RxVXUyWjNaV21oZXo1N25rR1hCcTJBZ3VXakJFS1BWQUdQ?=
 =?utf-8?B?d1diblUwaHZOQ0ZCanpUV3RwbjZUL01sVXNuNjkwSVh0a0Fxb3hMVjY5T2JZ?=
 =?utf-8?B?Q0VNUXJaUEZOZEFKZGNYc2VvM3RuenYxNW10ZHpzLzd5L3E1aS9wK2NyczlU?=
 =?utf-8?B?d1Ryd0xJZVorR2o4NDErcVYxL1pWWHlUZlFFUWRyTE1VZGZwS3VndWEwRVFo?=
 =?utf-8?B?ZVI1NFNGbzRJNXplR1VSTWU4RFRkQ2ZNSkxRQjlwZnp4b3l3OTZzMDZRNkRo?=
 =?utf-8?B?aks0ekJwWVRmWXRkOXJlZ0ZUaklBZ1VIdEZyZDhUTDZTOHcwcWp2aUp1T2px?=
 =?utf-8?B?SEFoWndqV29mSTQ1dW9rVmVtUGg5a1UrWHJ4cks0dXZPZXR3SnpGcUE3ZERE?=
 =?utf-8?B?RVhhYndFTGpSL3A4alpPaGtSSWJGcWtHVWllKzV2RmNXbkRXRkk2YUdDNER4?=
 =?utf-8?B?ZW50eHNLaU1pVGt1amFVMi9NcDNaYzFobFFEL21iVTBheStraEtMbDRiSTdh?=
 =?utf-8?B?YVNmTlBZV2N2SUVoMUxIeUdDSTErY2hNczlUMkdhMUhCMTkyOXJWenNqanQr?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f823f4db-c79e-4d2b-f2a5-08dd624ad93d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 16:19:37.1908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YN4ww1Rph+ZvxzjJ2zmvByVpNPDDixE98gkLFEtJvjZJdeC28cHbhEB2tzqS38mTnJ7H2dy/h2zbWhikd3aI1C0FqOfn9F1gbYISSNlHGo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6197
X-OriginatorOrg: intel.com

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Fri, 7 Mar 2025 13:10:29 +0100

> On Wed, Mar 05, 2025 at 05:21:26PM +0100, Alexander Lobakin wrote:
>> Currently, queues are associated 1:1 with interrupt vectors as it's
>> assumed queues are always interrupt-driven.
>> In order to use a queue without an interrupt, idpf still needs to have
>> a vector assigned to it to flush descriptors. This vector can be global
>> and only one for the whole vport to handle all its noirq queues.
>> Always request one excessive vector and configure it in non-interrupt
>> mode right away when creating vport, so that it can be used later by
>> queues when needed.
> 
> Description sort of miss the purpose of this commit, you don't ever
> mention that your design choice for XDP Tx queues is to have them
> irq-less.

Because this is not directly related to XDP and maybe some time later
more code could make use of noirq queues, who knows :>

But I'll mention why this is needed, ok.

> 
>>
>> Co-developed-by: Michal Kubiak <michal.kubiak@intel.com>
>> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> ---
>>  drivers/net/ethernet/intel/idpf/idpf.h        |  8 +++
>>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  4 ++
>>  drivers/net/ethernet/intel/idpf/idpf_dev.c    | 11 +++-
>>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |  2 +-
>>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  8 +++
>>  drivers/net/ethernet/intel/idpf/idpf_vf_dev.c | 11 +++-
>>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 53 +++++++++++++------
>>  7 files changed, 79 insertions(+), 18 deletions(-)

Thanks,
Olek

