Return-Path: <bpf+bounces-28656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617978BCAEA
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 11:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A098B22D1C
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 09:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20611442E8;
	Mon,  6 May 2024 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k53u+/Rf"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDF5143868;
	Mon,  6 May 2024 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988326; cv=fail; b=FN7UCXTLSMMI4CdmwDrPPVeuTzO7uC7dAB8KTejjvqE0PL/u5xlJrgEg951QPkeL39YpSiE/X3LYDigqYGm4RPmXQoz6Dv60c4UFASgGcDJErjI/g1Fsdx6R/L8jpaiueU6lbZdRk0MKDVanlK/yD17PJLmUb6fcItDFGsgghJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988326; c=relaxed/simple;
	bh=Inl3x82cRgZlyOVYiHNKmQ7YgHzWa82W++POsIqhSUU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mdeIYB0gGTi797eT/Kdqs3qI3pWIV4OTidFg2OWF49FQfAFgxtze5SDjLDf59+ICvnnycfKC5I9t5lqnz2p71QO1iciWxhBThUjW57qHNklzSER1sQ+6PLNDopok4R0QPyrISYh2/1GD+cbvcUWX5mjCojp5lY92dM78UKAtN4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k53u+/Rf; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714988325; x=1746524325;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Inl3x82cRgZlyOVYiHNKmQ7YgHzWa82W++POsIqhSUU=;
  b=k53u+/RfFopNNQrspvJsazhRBQA1lmi9uJLv9mvWDbqvC2MLxpCnIvDz
   nquiJ+UmrVmSLXtuq+/1AeGW+xeTJQoqHbKbLkxRgKsMC46EeBKakguiN
   a1rH3yyqO/DcE4zd39jmAnUlGCa3kGUQ/JZtWp/D2UY2Cxke0hhcYqI32
   s5wDhOfZzb0k3dw+hoZYcdIaI7j2VA47nJ0WViv7FTo2cdbb1WIhO7qMx
   DnCGdf6w1yyu9bdCiZ2zDwWOr10mLRHAOdK4D5RejT/9IHjYfTgXsD+gb
   ZXt+UYL+ZRK0VcwCH4GYvS3Kap2B+Onp9BLHTfohjCiVorZPUYTsZ1p+O
   w==;
X-CSE-ConnectionGUID: o8kbHsfASvu47ENMpsisVg==
X-CSE-MsgGUID: nG4/hnNrRZm9dvOPPcVx+g==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10882966"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="10882966"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 02:38:44 -0700
X-CSE-ConnectionGUID: y9V57DFuQ3KMB2+T9MFkhA==
X-CSE-MsgGUID: Y++Hb/CnSuWIp4MiHzyr1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="28628360"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 May 2024 02:38:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 02:38:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 02:38:43 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 02:38:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxU5upFBMcFJRDTvUlOa5VArUHiy7JQ7xcxbPajmI/Qw1zsM61iKe2xRBiz1xCOfxTco0D2Am9gYw/kd4oXDYwJ7Xd5C+s15SBbudEmVr2Cwe85z4ZTcP2YflaqAxHBqU+U3w4+g/uDk+KKwDRipy+4iw1mRLWIk5tDgGI7mAq88a0E5JRr85444gRf6bFljT2g0TrG2nf+l1uJp+IuJGpd+LBKvelg7pnH6VL/ImfVy+n+fKs5GhXrt6R6xYZsogcOlOmaVEfykJbbwOX6GgZ19Tr0Ow2iwuELZdRktcDi4LaGQyqlBYCvOmPgzSzp+yEnnpM1LfoqeepL7MT6dCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPyyVNEThjzaz0XWyR/yyT8rxJDSpYedZqkfr0kA73k=;
 b=ONtMt7yO3FDeFS4SB99jz5ZD/1dtNHAttavtpY9arrsPSRlBY9wsFYYnnlgokQU0Y+MliqI6Cyl3y/+EFt4+/xJjahQ2dW223EnmXn4Q9h4xKuwuJbwbVsXdRdjjiwsbcDNCp2BG3OReTwyda8DQSkZ4BHWmd3KToBCLMJMvVZBjiWsj96sNZt7ml/hz7zsDtDbEv0zYrUPxag5Y5j7zJIeoQb7fiqiAJfH+uqumVd4u357sO2eFGXsW5piohTHIyz180lYXpZjBZLChATbxErWu3v5nwCv2tLyIO3JMyez1wQlweQUglCGxDSNx7z6CFXzLhQN3B87jMoUU3YSltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB7026.namprd11.prod.outlook.com (2603:10b6:510:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 09:38:40 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 09:38:39 +0000
Message-ID: <e92d281c-366c-4bd9-849a-ead484a61545@intel.com>
Date: Mon, 6 May 2024 11:38:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 6/7] page_pool: check for DMA sync shortcut
 earlier
To: Christoph Hellwig <hch@lst.de>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Magnus Karlsson
	<magnus.karlsson@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20240423135832.2271696-1-aleksander.lobakin@intel.com>
 <20240423135832.2271696-7-aleksander.lobakin@intel.com>
 <81df4e0f-07f3-40f6-8d71-ffad791ab611@intel.com>
 <20240426050229.GA4548@lst.de> <20240502055855.GA28572@lst.de>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240502055855.GA28572@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0028.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::8) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: f5974d55-8d19-49c7-c400-08dc6db04f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dU1rUnNVd29GNzJKUWw4QjNtTG14am1rUWliNzBPL1VnQ3drNzRVY29uSGhj?=
 =?utf-8?B?TDBWUCttMzZPeGFlT3pTRkN5Ry9acVFHcU5vaTd3Y1JQbGVwSkRHSjY3MS9x?=
 =?utf-8?B?cDhRbmgwVENEY0ExTGM3bEVWVjlzRnpjd2lQT1Q0TTU5dGt2MElzNEtEb1ZG?=
 =?utf-8?B?UnN6eUxFdjE1aXRqN1habytMQ3VXaWtwZ3JYcitzZ2NMbUcyUmxqN2doYkp3?=
 =?utf-8?B?eFl6UmcrVXZYdWdBTGcyVTZkUnZtSzFWejgzclNJSFE1OGdOUGJLd1RDVmdh?=
 =?utf-8?B?RU9OeGQrTDRxVXBqYmxMVXZTRmJVSFBVeEl1MDNjbFMvOWw5dWRSU2dBU0tn?=
 =?utf-8?B?OVpNdDBFRm14YStla0hQYVg1dUROcnF3ZnlFVDdsMHJSdnpwTFJnYmlVMWV4?=
 =?utf-8?B?b1czMWhFTjlvdHRDS1ZCVTJKNFQ4dldRSVhzVHRhMnlXQmVkcG12bDdhcGNO?=
 =?utf-8?B?SGlEL1dRdjIzMkVVYS9kVlBJcEE3cy8ycGV2azMxemFDWVlZZ240dktGR3Vw?=
 =?utf-8?B?ZXBybDFOTXVHUllWKzF0VEk1Yk9EMXJOVmwrTTh5ZkNxdmFrNDRLcmtmYmhp?=
 =?utf-8?B?Smc4cU5DYld6cit6Y0pFYzhqMlJLU05xZ0M5VUozTi94WlJUZnhEOW83N3lI?=
 =?utf-8?B?K3haZENEcmVxS3hnUU1aYkFQd3RBU1B2aTJFamNkTmwvY0RYRmp0TEM0WEUw?=
 =?utf-8?B?c2QyV29aMVNFbkxHMHZYaTE3U2xySktSOURaaER2V0NENWVmWWMxUnN2aU9j?=
 =?utf-8?B?VDZEZ1hFSnp5TVlnSkhtU08wOWJXTnhIMGFNY1k1K0NHT0ErdGs4VUtxQWRT?=
 =?utf-8?B?aUpqbWIzcitVYUNERk5zNEZjSElJOWhnQUgyTGdiaWxrbjVBZUVhZ2ZrcHJv?=
 =?utf-8?B?ZFZVeEJIbTFmWXBRRkVWczZSaHUxT1BUeDVLU0dJUkJicjE0QnVlZUV4RHpU?=
 =?utf-8?B?b3VwK0RmWTlXQkhuTkZPdWVLcGQ0TnpDMk1nb0Q1UVgvYUdOdHJPT1JodWR4?=
 =?utf-8?B?MEdHZ1k2V3hrVkxMMEdPRWZ3anNlUzYvNDhJcUFCMUFyQkswNjBFcFZsalg5?=
 =?utf-8?B?N1VNcXFUSExEelVVNzRQaGlwSnFnRlkrS0xrbjEwQlJ6aHhoNDJNRWIwczNk?=
 =?utf-8?B?dzZVaUVHazg2blJwd2hzc3lhMjhCVURsditySHJJdmcvdi9IZWtSTHlLMmZv?=
 =?utf-8?B?R0x5S2NDWVFxR3pBdlBobWR0RDZSS0lETytPaUxwK0FLRXcrYTlvZVpBK2lp?=
 =?utf-8?B?UE9RTXpsME1JaDg3NXEzdVVXTGk2KzJxZ1dEV3UvS05wL2F3a3lKQ0dBRmFZ?=
 =?utf-8?B?UFdQZjRmcVQ4QUhUaFE2U09CeE42RU5XbDRJTnYyVFVZQ3FjMzBHMnRoKy93?=
 =?utf-8?B?ZnNzT0NSMys3dFkwODd2QWhYeGVFY0xYTUYwdlMrcklUSlhpSERKaTIweG4w?=
 =?utf-8?B?V2F2TzVteHlGa0NHOWVpSVZyNENSSnlsUkh3ekpXV0tLKzlMOGxqYThqRFdZ?=
 =?utf-8?B?VERIK3RMR3Rhc0dTbGlLOEtjUDdQOWRjQ1FYZmtyMFNmdmNyTmZJN3hlYlFM?=
 =?utf-8?B?ajVMN29Xc3hmdmFuSzdOZnpkWnNOM284TkwwaSs4dEVteittRmJYVXhUSmV6?=
 =?utf-8?B?L00vYmZsQldDN0g4UytoNk8vVGk1VEFmNDNkenJXMkxxZW9QbHNHYWllc1lV?=
 =?utf-8?B?S1BLeXBQYkVUeVIvVklCelgvd0JGY01DQnc1M2NtcGh3V0JoMUpoKzRRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3RJbVl6bFJ0K2VmQ1FLb3VFQkFmZUMwUlBsbnVISDFrV0RBUVRELzl1dWdo?=
 =?utf-8?B?Ri9KZ3lIOFJCa2FFOThlLzRPNGNyT1d0UlBLK3F6R2xkRzRzajVrdUxCbDNU?=
 =?utf-8?B?SStNV0hzYWY1Mkk3dXpMbFVXZ29GNDFVTUY3QUpkeTJEb2c2b3p4a0ViL2dS?=
 =?utf-8?B?QnNUNnNVeVNHSHdORU1VYXkvdExvQmEwTXBuY1hjTi9tZWtqTDVZUFZ6WmFR?=
 =?utf-8?B?ZWJhZHBPZXlmN1RsQVpoRGFjSmVLL2VNODVLL3J1VXN5MVFVV09vTTh0ZTFV?=
 =?utf-8?B?MHV0OEdaelhCd0VkT3dnZ3JRSDRScERHZVVpdFFMcmRrVUg1S29QaGc4QXdZ?=
 =?utf-8?B?b2NLcERQMUFOR1hFRE92d0pNMWFMUnpyWG9wSXluME52eTRnRDFUMlZmYXo5?=
 =?utf-8?B?T3FIS3JMcGpyQUd0ZWZmaGVrUWxxMmpZR29IMzFCRDd6cEx5TG00N3JpRjV6?=
 =?utf-8?B?SitrRVNSKzZxNDd0dnhKVDh6eFZNSFNqanN4THVzM3dUREowYTJ2bjRPRmxL?=
 =?utf-8?B?NXBOb2JKUFV1QUNBaVdkWEVYZWtsOER4LzMwTDFNb2EvTnh2ZkFTN3ZManR5?=
 =?utf-8?B?ZmVEeS9ERlU1YmFpL0YvNkdNNFlkMVo4MHp1dnRxY1dGYmtKaFN5SHBleUhm?=
 =?utf-8?B?VkZCQmM4M0ZGUHBNaUtIOGNrQllqa0tXayswRXlBMHVsRHFwQys1K1hIUGFS?=
 =?utf-8?B?WWNhOGVBOVNNUUlWMyt1cGpxZHdkNGRHOWk1aUVOd0lieWJNK2tMWjNOamhr?=
 =?utf-8?B?Q0JVU2tiam5zeFhUbTlhM3B1M2krNS9QMHB0Q3N6YkIwalZlQmdnLzkzUVJz?=
 =?utf-8?B?dTk5eEdPbWJCZHhHN0d4ZzlJUGdzaE44eFJ5RGtZNUI4MUZxQW1ya0VNMnRD?=
 =?utf-8?B?UHY4cVRKOU1DTDAwR1psbUkzb0RwTmY3Q1g4M3F1ZVE1dVhqTjVZQlhvQTdw?=
 =?utf-8?B?K1J4TmlYcFdjWWN5OHJJS05sOHdZYitzbE92UExLUkdWWjY0dmZqRnNDakZX?=
 =?utf-8?B?d3luNUZ1dFQ0V29hendPYjZwdlB5aXV6TFB5Mm94b3drdjRSY2xiN0NwZGhO?=
 =?utf-8?B?ZE85by81YmVWTUtucStRMk51a2Z2UG5kZzJWSTFNODdkbnNlNFhTbktEMFVK?=
 =?utf-8?B?dExaVWJJRllCM3JtbU5NV1BFWGN5Zlh5MitCSUR6eDZxbktSaDN6Z0FQS3VS?=
 =?utf-8?B?ZDI5NVRGY2xNQ202dFE5R2x3VDM3Ni9Yd05QemxJN2E3eStSTDZSUTBTR1U4?=
 =?utf-8?B?UVAvZDRZM3JGRWN3YlJNK2xkbG1SOElzVS9SMy9kKzFMVjhsOThoYkhEM3pn?=
 =?utf-8?B?azJpUWhLM0RMQjVWUXU5bTlWaWFjNVNDcWhtWnB5a0owWHdqdExGaHBMVy9v?=
 =?utf-8?B?bHVDR3UrUWxURWQyMFVwdnhCQThQTlNEaHUwTU9SVkFGM3UwUFlqOVAxOE9I?=
 =?utf-8?B?OTZpc1N1YTRMc2dJRlNaV3ZhcE5BNWhqOFhSSVZvMElYQUJJckJUVTYwMmF2?=
 =?utf-8?B?OEJ1MmlhNTJ5bk1HblJQUVRYbFV0ZDNkRFRkRVhjSTQ4WE9kOTRCNytRZ2ov?=
 =?utf-8?B?Mlg5a003Mi9NSEVoaDNJdldrenRFWTdGK1cyU01hS3A2VTJaNDAzL1BrMHFG?=
 =?utf-8?B?WUJyN1Q1Q0ROQXA0bnpNN0NCdEdYRllDbXF5THVBV2xoOTMxZVZhb1ZOWmFC?=
 =?utf-8?B?R0hBajN3UDZ5QXNUdHdkU3VXL0dvN2lUdU0rTHp3ZXhTYVVBUDhIdCs5cHJR?=
 =?utf-8?B?SUR4aEI1VUNKRFlueGpWNDF5MUtPSVp5djBrSFJFRWg3SnNjdG1pM00wUXg0?=
 =?utf-8?B?ZVJWU2kwZnNqeVl4Sk1YVTdvZ21Ca0xLUnhyZjlzNEl6azEwZkFNeFcwR0V2?=
 =?utf-8?B?a0FMQWFIVHFucnhTSWxIZ0RXS1V3T2tZa0htek0vWldPTHF5Nm45eDkwUDVz?=
 =?utf-8?B?VG5yVU9DclpJbXk1Nzk3L3NtUXcrdTVxeTBaUFFuSzR6amwyOXQwZW9QemlM?=
 =?utf-8?B?THIwTzN4bnpaeWpBYWZ1eWg2VHNnQ0lrSm9NYlZmY2QrbjRMUEFzMG04L1BV?=
 =?utf-8?B?Vm84czQ0OUxTSVpoSVZPWnNqUE5kUEdxaXNtN2l2WGkzZ1c2SmptMncvNXc2?=
 =?utf-8?B?RUIzTXdyMUJJQm4zbTJoUi9HZHJMWnJHS0E2enBCVVFHNW9WTS9JcHhSMWVS?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5974d55-8d19-49c7-c400-08dc6db04f40
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 09:38:39.3619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aX9o0J+3E+xKnhcbJY6u7OFiLjDWKDtAUMClqP7FEQZ5jsbTjJQ70zWXUSL49INthyp3+GTkBxEP3rVZQ56Nwvotcpi7SssOD2OhTGxhEJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7026
X-OriginatorOrg: intel.com

From: Christoph Hellwig <hch@lst.de>
Date: Thu, 2 May 2024 07:58:55 +0200

> Hi Alexander,
> 
> do you have time to resend the series?  I'd love to merge it for
> 6.10 if I can get the updated version ASAP.

Hi!

Sorry, I was on a small vacation.
Do I still have a chance to get this into 6.10?

Thanks,
Olek

