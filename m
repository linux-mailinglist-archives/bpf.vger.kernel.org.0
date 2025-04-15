Return-Path: <bpf+bounces-55998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46997A8A5ED
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 19:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D667C3A6672
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 17:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8047A13A;
	Tue, 15 Apr 2025 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EiAjygtG"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFC4634;
	Tue, 15 Apr 2025 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744739137; cv=fail; b=ESHG6Er+UHCzMrxOndnnv4DJ4fBfNVMsv7tX2pR1TMq0XsGRxzYFB/9eD+WRI/Obe7iiVSQPBGZBLrt0YdBjBMqzHpcSKZaFWUwJXZMPUhyAVZSyKPsHhpjtkkfADgMbqE1X6KxfGzsEaxpMq4l5ex7uTFs7DnHYdZIDRpHvEuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744739137; c=relaxed/simple;
	bh=lgZaPnTG+THgSuAy7AXgSE/Zn1NInnKeGyDXZwPNe2s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iRIhc2PyHrL2jSv+s07NIu3sO7yj/istuhL92Pbryju8We+drJP3Yrnc0dqt2CDbw9fOXM/Hqw8ehY4t6cNF3C7/vQU8woS/LRJN5i710JykVqUdYD+JortR48ayustwDPTyogRFy8ZXjsCjznSS3YnOOfZuRa7BmguKhw0iXsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EiAjygtG; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744739133; x=1776275133;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lgZaPnTG+THgSuAy7AXgSE/Zn1NInnKeGyDXZwPNe2s=;
  b=EiAjygtGisapGLQYSBG9rBnwek48yUhe7P/q52EApmBoLWnDc90fv00O
   fjVtc6gmY8YVHHjRndMumJQD+E8aNgsbkFDmXaQ2XR63dkeEFDHRAQnWV
   2uQU9cq324UtDYY8WYZRgVG6AZzkgj2kKIberAzqABbD4IMllN5BXuFoa
   4+rcJdnEw+4nmlS5CDs5ULlDvsXhpL015gTd5a28clxiBLTy5SJCv9NGl
   5giHtgu3XFEcVLN2pprWCbKutQdizt++hTcJf2mUKFAtyCxswMIiH1svM
   UyxbZyAomk5bCKljipeynbjGWSlxZ4uhUJd/IVdcprRnk9WosFTbbFaME
   A==;
X-CSE-ConnectionGUID: iY2gKSJYQGuTF2/VwZB9mw==
X-CSE-MsgGUID: ogfZeloZR/qeqmLuLNAEpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="71655964"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="71655964"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 10:45:32 -0700
X-CSE-ConnectionGUID: KuEChjICSqilwEZCfrmcaA==
X-CSE-MsgGUID: 3nyvIseIR06MeXf0RT/6hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130058881"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 10:45:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 10:45:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 10:45:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 10:45:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/5ZGCfmfe6rfpMnra2tz/xv3iJZ9KeL1JDtqi2qFxsKr1XjVJqTQe7GbGPGQ+cIVWEJSPr55pIzM6fFbhp8zdguM8vx0GShH93gUzGmLtR09Y5sWpgf7uz2QDTJy+HRmTXXWwwCfb2qG6uNVKbPfsfMcVOeSVQKJYggRAF3iouT6+fN3gROOd8OXgQBdUaxzg2kX3pKHwFWFEVDdUlAVQMh1f37LMh9jQLwIypuHsbT+VMWVrLxh02mVDTJOheZ7LBqpbaRs+EhGmtXEtCP9hfianKcnZPpiSQMdp55Fsrz9RTe9nM538JZa0i/Pysfu1Fw2oPU3YS4/nUO4RTiRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmJRA1I2Xbvf4AK69yk48YG8HL30WQxLVtarBqsytTA=;
 b=eb+uXUUpMZ+gW/e+1h2+UdtZV0UsP+MDbtVpqiORcIemhDFAcuqQbbZkrlXcFjEGnj3Nqk0ZU51yDBEH+0DmBA87xqkjQeNfID2sWktJ9S5PCIDKPPUShSvHmt0O0x/NXPsez8oDmJvkX7piJ28nvLeZKA1W1nhogDg1xRsxP8SftywZtXIx7465KVRjvwqacf+kfXREAHJLZnrhWdT8gjpas+YUUq3eHFgow06ahOx2zbLu9XkLek1cEcDdgNXDbFVQFzMMAqxZJ3zxtJVbqHXcTfN2xWECWKMQuIUPG5ySN5kVSma8b13nF0nT3AJMxYePOIm02GPE8XOSCMJXRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB6819.namprd11.prod.outlook.com (2603:10b6:930:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 17:45:11 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 17:45:11 +0000
Message-ID: <0750ffc8-8185-4b72-980a-3e96c7075100@intel.com>
Date: Tue, 15 Apr 2025 10:45:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 3/3] net: ti: icss-iep: Fix possible NULL pointer
 dereference for perout request
To: Meghana Malladi <m-malladi@ti.com>, <dan.carpenter@linaro.org>,
	<javier.carrasco.cruz@gmail.com>, <diogo.ivo@siemens.com>,
	<horms@kernel.org>, <john.fastabend@gmail.com>, <hawk@kernel.org>,
	<daniel@iogearbox.net>, <ast@kernel.org>, <richardcochran@gmail.com>,
	<pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
References: <20250415090543.717991-1-m-malladi@ti.com>
 <20250415090543.717991-4-m-malladi@ti.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250415090543.717991-4-m-malladi@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:303:16d::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 10826209-e8e9-4982-24f4-08dd7c45451e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTZ3ZzNsUEhrZEdYaGV4VkI3VjNBNTZabmxmcFRFZ0dDcDNXUm01RUhGOFpK?=
 =?utf-8?B?NkxXck5JZEFJUUV1SUVCNWxEY3dvcWhXM3IybTZvV1ZndkFheDlaMWdqZFhy?=
 =?utf-8?B?VDdKTnZtR1RNWUx1cldMN3ZteThscU5uSS9iMTVqUEtZbGMxUnhYcWdTaCto?=
 =?utf-8?B?OHFHSnBDVmcrR3RTSVVGOHZvTFEyMG5iY0daZFJ6YjlRT0xPaGxLM3d2YXVX?=
 =?utf-8?B?UG5ERkZSRnBoNVQzTGtKN1ozbXNnZlAzL2lFWkdUYXA0NXd1aFhNTWh1YnFB?=
 =?utf-8?B?KzZHZGl3d2VXVWoyUWdkVWJBTUNzQWhHVG5JMTRQNmJZOTgxRW9UUDl2dlVx?=
 =?utf-8?B?TENNMHZTL21tK0RQNXUvSjVjT3JwZTVTNUVkNmh5aFVqeXRmQzFVNkdzVW1Y?=
 =?utf-8?B?MnVaRzdrK08vYVVEeXNaQUVkMnE2NTdtZnBsaU8zVGs3bm42Yk9uaWVuUEgr?=
 =?utf-8?B?ODRvdGRyZEg4dUoxa0JUK2lsV2lNWHZDMmNtWTIyVDk4dHpRUHlnaXhncEZj?=
 =?utf-8?B?bXRqeVhDMVFUclkrT2hjYWJLYmdyNktGRFAxdGkwbkNBOStvT0xFNjJsRkJh?=
 =?utf-8?B?L0VpZnJQeUZWZWZTTXBJRmpPZVoxRVgyMDNPd0FzNVhvZCtPc2w5Rk1hZFRm?=
 =?utf-8?B?U2RDVGdOaFo2MGtaRjFtV0J1NVovVjlTWWFoVXdvYmZLWTZ5QmgvYlgzMDdM?=
 =?utf-8?B?eWUwaEpzSER5ZVJuUEhxcEpnY0wwK3RLVFNzOWwxYkg2NVZqSEhpbXhoQjQz?=
 =?utf-8?B?TmlsaytPNDVXQUhiL0xCdWNwcCs1ZmQzR3BRcWUyRi9CYlN6M2ptOXNWT3F5?=
 =?utf-8?B?eWhQck5ObVFVeDZ0VjkwNUhYWWFRaWs3ZUpvaG5ZU1J5ZFVoaGVhOHlzL1Vy?=
 =?utf-8?B?alB4STJXZWIranpBNW4vWnJ6bW1MZ0JnZE8vbFdVOU90TDcwRzdQb2k4S3RX?=
 =?utf-8?B?SmdwMk45dHRsY0tTbENOTlhCN2RvcXZnMXRteThPWFVSM2lyK3V0ajFaQ2NG?=
 =?utf-8?B?QkFVTmp5R1diZ0VubEJiN2hoajdJeW11QkxkTlA2RUxMZkk0WlRyeVVkMjB6?=
 =?utf-8?B?bnlxV0d3MGhrUDNCR2p2Uks0bG1kOFc5L3NTN01jV2hwckhPRUVYVmlBak9h?=
 =?utf-8?B?YXVNUk9JN08xWG9RZU1pZTlHN1VZSEdSV3pKSVZPZ0syT09IMG1CeWczdk4r?=
 =?utf-8?B?RGhjUU5RUXVOcDIzTkJ0dm9uL2hqRHVxendqU3IrVUdnOXI0SWNETzcyZ0hF?=
 =?utf-8?B?ckpERXZEczF4K2lsZjgvbEpwVmZsM1lseDd5R0pjYS9kRGhYUGIxVVNIVVlo?=
 =?utf-8?B?SjdQeUI5Tlg3bi9YMWd0SXJBQ29VekwyUGtEMmQySXhBalZweFo0Kzk0K0FX?=
 =?utf-8?B?VmVHY0NOQlVkK1ZDeVVIL0xadWUwMm5XeTE5dkk2cnBXVEh5VTZTVGxDcjZh?=
 =?utf-8?B?TUtlaVRDTTBQSGpqOFZLWENnbjh3WDdweU04S3FENVlCQTdJY0c5MVMwWjE2?=
 =?utf-8?B?eHE2WlJ6OGV1UXJXbUZjb08zSitMbVZmTFhjZFpaNm02VlpVdUJKelJPdUk3?=
 =?utf-8?B?Z1FnRW9IdCtmVkdkY3RzWTVlT0VmSjhLN1N5RnFFK01YSkJoY3dMM0pnVHFv?=
 =?utf-8?B?Rms3Z2wzUVhpZVZRNndPRzFVcjNUVk9YaTd5d2Q4a21nTW5RZmtMc0JMbEQ5?=
 =?utf-8?B?NTJhWW9wUzM1eTlzanZ2VDZ2a0NIWk1qNERZaDFHMHZnQXRzY0lvZ2VaamFn?=
 =?utf-8?B?NGo3L0NrdEZJbC9VeGNkY2xJeEJjeWRrMWRhWW9lK0p0YW1NYzBWalBveXhz?=
 =?utf-8?B?SHYzQ0VsOWJ0K2lINnpWNCt5cGd2ZmduWHhrbnBwV0NWVmZEMVBEUkFTVE1q?=
 =?utf-8?B?OXltR2x4MVpBUmtKYVdxeklXZUs1V2p4WEpXOXZNL2swb09VdmlQQVRsYkRX?=
 =?utf-8?B?MDdVaE8zQkp3dTFEcktVR0x6YURjZE1ERlVaVEwrRW1CZGhkaERKVTZNcUdy?=
 =?utf-8?B?NHFHaVd0U25RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1puVEpLbW1wUVhJbGoyV3FuR3VFUHZjYWxmV0M5TDE1aXh3RU5LQ2ExTmhO?=
 =?utf-8?B?aFg4aDZ1QnEzS3oxQ0NsUXl6Smp5SDIweHBvRE1nUSsvK1lubzVFQTZqY094?=
 =?utf-8?B?cWVTZjZvQUdBa1dYMkR4U24yNVhzbUY3OHJjdGU5ZGs4elpLYXRzbjZHRWpq?=
 =?utf-8?B?eWFzd21XbFF0U0U1QnZwUlNwOWtPN29RaUZ6WkxrQkdmRWgvYlRVTFdMTzJ2?=
 =?utf-8?B?TzRvVDY1TlZ2MndRNGZtWFFiYkpBNU45TDVha0hvcUpqbFNRMW90ZUQxZ2U1?=
 =?utf-8?B?Qi9Ta0VpeGRYOTdxdXJKaWdta0ZMalZ0VTY0SE5zblJraHZpVzBCMm1NODlp?=
 =?utf-8?B?YlYwVnpGQ2J4UG9zNmErN2Fzcml5TEljdllCbVc3SjNiOE44em9wbUoraDVG?=
 =?utf-8?B?Uy9aaU9SU09hSnF0QmdIWHN6WUlTbXNSblR0dHdSRldOYjdvcHlvMVdNU0Q3?=
 =?utf-8?B?aGtvMWFkMVZYUGxrYjFEc0hWT0dNcS8zWE5SYkVLcHlwRi9nN0xGTWRnaUdG?=
 =?utf-8?B?a2w2SUVSRWJyeVljaUZUOElpdVNPdWNUSEIrRmk5ZmZLbEVHOENtL1FoTkxL?=
 =?utf-8?B?RlhEK3BucVpvRit5SEovZHRvUW9lRWd6dHEweGxMV1pGRmNLUnIycHRaeDlp?=
 =?utf-8?B?M1ptZmdaQk5WanhCUGNyRmorZG44a2ZDWWk5bjFoQU1iWTVqZVpQRGowRjRH?=
 =?utf-8?B?ZWNIWnM1dVF0MWlPVHcwdEVFU0xXZzNhNm10cWdISVZlM3N6Q2V1OFVtWVQy?=
 =?utf-8?B?bDQwWFFnL0hnOElGSnFrbkxMZCt3VzVLVTl0Z3hvdHBqNnluZStsbStZeDd0?=
 =?utf-8?B?OHE4eTRBTEh2ZS9Ed3NjUzI4aG5BK01SMC8vRVR5T1JEYmtxT0d2NC9ydmox?=
 =?utf-8?B?UE1JMFgrdjlEMHJTQ0VmTEhzcFgvK1d2WHlCM0thdkRvaXRzZnh6ZkI0Q29U?=
 =?utf-8?B?R2QxYW16em43YWo0aEx1S0VvTzNNOGxWRFllUGtRNTVuVE1hUHZZUTVxdXpZ?=
 =?utf-8?B?enM5WXJkTlRJRFh5akIzbEpRUVYxSERNdDVTdGdHVk1ZM1JyeXFQdzVMQzFp?=
 =?utf-8?B?SjIyVlR4bHMxTnlkak15QUJBSE9CK2JmZGlxeVJSZi84MkJ3Y3BCSWxlL3Rr?=
 =?utf-8?B?Y2RCVldzejBaUDEzNzNjV2d2R056TTYwdmQyL09ESWRZYVgrdTgvd1B6TE83?=
 =?utf-8?B?ejh0WWovMlBwa1hCdHN3bzFRRlJtU3NkcklnK05ZcE1MazNnSmI4cnk3NWFY?=
 =?utf-8?B?WU5CRGVGc2cxSkVtZTNPc3lMeG85a0hPWEk4REYrWTBYRVJOZFNPRE1ad2VW?=
 =?utf-8?B?VjlZNWhSdmVzc1pJSlZtb2c4OVlZNFJQM2w5ZHE3Wng4OU1kbGtOVTYzMlVn?=
 =?utf-8?B?Sjl1czl1MExMdXkrNm81QmQ5aFFJVGJWUU1xTHhhMnExQlRvYnFxUjJCYWs4?=
 =?utf-8?B?Q0FZTlI3K0lCaWpDazVBVFdXUDRtQnlBNGRpb2cxbGVOMFRGdVFybVIyUmpt?=
 =?utf-8?B?eTFoOXVzM3dabFJ5Ynl4WUk3RWRpU25PVk95YWdYTWVRYTk4QmtsdmxNcXVo?=
 =?utf-8?B?czRXblNSbFdCeVJOS1ROQXdDNkdrOGtLTUlweUVRdTljOUpNV2Jsa3U4Z2Ny?=
 =?utf-8?B?ZTRzcjVUUHVVWi84OWJiZWllcVpJWlQxN1RzRlgwYWVlY0VxckhwL1FqSjhO?=
 =?utf-8?B?QVlBRVlHeU50b1I4REU4cWhvTURXb2huWExCeFQ1VFY4b0NxNERjZkVvSm9o?=
 =?utf-8?B?SjZYVXkrYnhXMm1LSkpJM3p4c2FLVWh0NzF1U1pHYW9QTkZmMXFPd2toTGVy?=
 =?utf-8?B?VFBlL3pwYXRZNExxaVFQWm9JQzNWM08vT0lzSWZnVC9qVzVoTG1JSzB3RVYw?=
 =?utf-8?B?amxkclAzNmtZdU5yRTV4T1Z6M1VJV3ErMWo3TUtSUlpnNTNrcTUvZ0toczFZ?=
 =?utf-8?B?cEV6dXJqcjF4N0RhSlQ4dWo3RHpVTWJXT1lDV3JPZjRGbkU5WWRNZ1hqNXoz?=
 =?utf-8?B?RFhtQzR4NlVDZ0xEWlFvaU5wSWhNOUpqby94MXQ1bjcwWFl2YU5mNXhrVmw2?=
 =?utf-8?B?SENMZXZYU2pZdlcweGpuTzcwTTJzQzZRODVid2F0ejIzNUpVU3pBZ3NFdWxr?=
 =?utf-8?B?c044VUhmVHRiaUdrZ0hDRXRqUk1ielFPYlJYVkFTdnNYSTVmNVdKUHVTWEF5?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10826209-e8e9-4982-24f4-08dd7c45451e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 17:45:11.1630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rG71tAw8lO0QyINSz/5i76n3I8qhQqwT4JTzEeFqd3xskdNZoCvZL2ZmSX51reFBuJf7AOoSY4C9iaZS1Q14IFVJM6x3xWtJuk8FN9Co51I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6819
X-OriginatorOrg: intel.com



On 4/15/2025 2:05 AM, Meghana Malladi wrote:
> The ICSS IEP driver tracks perout and pps enable state with flags.
> Currently when disabling pps and perout signals during icss_iep_exit(),
> results in NULL pointer dereference for perout.
> 
> To fix the null pointer dereference issue, the icss_iep_perout_enable_hw
> function can be modified to directly clear the IEP CMP registers when
> disabling PPS or PEROUT, without referencing the ptp_perout_request
> structure, as its contents are irrelevant in this case.
> 
> Fixes: 9b115361248d ("net: ti: icssg-prueth: Fix clearing of IEP_CMP_CFG registers during iep_init")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/7b1c7c36-363a-4085-b26c-4f210bee1df6@stanley.mountain/
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Changes from v3 (v4-v3):
> - Fix the logic in icss_iep_perout_enable_hw() to clear IEP registers
>   when disabling periodic signal
> 
>  drivers/net/ethernet/ti/icssg/icss_iep.c | 121 +++++++++++------------
>  1 file changed, 58 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
> index b4a34c57b7b4..2a1c43316f46 100644
> --- a/drivers/net/ethernet/ti/icssg/icss_iep.c
> +++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
> @@ -430,64 +446,39 @@ static int icss_iep_perout_enable_hw(struct icss_iep *iep,
>  		if (ret)
>  			return ret;
>  
> -		if (on) {
> -			/* Configure CMP */
> -			regmap_write(iep->map, ICSS_IEP_CMP1_REG0, lower_32_bits(cmp));
> -			if (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT)
> -				regmap_write(iep->map, ICSS_IEP_CMP1_REG1, upper_32_bits(cmp));
> -			/* Configure SYNC, based on req on width */
> -			regmap_write(iep->map, ICSS_IEP_SYNC_PWIDTH_REG,
> -				     div_u64(ns_width, iep->def_inc));
> -			regmap_write(iep->map, ICSS_IEP_SYNC0_PERIOD_REG, 0);
> -			regmap_write(iep->map, ICSS_IEP_SYNC_START_REG,
> -				     div_u64(ns_start, iep->def_inc));
> -			regmap_write(iep->map, ICSS_IEP_SYNC_CTRL_REG, 0); /* one-shot mode */
> -			/* Enable CMP 1 */
> -			regmap_update_bits(iep->map, ICSS_IEP_CMP_CFG_REG,
> -					   IEP_CMP_CFG_CMP_EN(1), IEP_CMP_CFG_CMP_EN(1));
> -		} else {
> -			/* Disable CMP 1 */
> -			regmap_update_bits(iep->map, ICSS_IEP_CMP_CFG_REG,
> -					   IEP_CMP_CFG_CMP_EN(1), 0);
> -
> -			/* clear regs */
> -			regmap_write(iep->map, ICSS_IEP_CMP1_REG0, 0);
> -			if (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT)
> -				regmap_write(iep->map, ICSS_IEP_CMP1_REG1, 0);
> -		}
> +		/* Configure CMP */
> +		regmap_write(iep->map, ICSS_IEP_CMP1_REG0, lower_32_bits(cmp));
> +		if (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT)
> +			regmap_write(iep->map, ICSS_IEP_CMP1_REG1, upper_32_bits(cmp));
> +		/* Configure SYNC, based on req on width */
> +		regmap_write(iep->map, ICSS_IEP_SYNC_PWIDTH_REG,
> +			     div_u64(ns_width, iep->def_inc));
> +		regmap_write(iep->map, ICSS_IEP_SYNC0_PERIOD_REG, 0);
> +		regmap_write(iep->map, ICSS_IEP_SYNC_START_REG,
> +			     div_u64(ns_start, iep->def_inc));
> +		regmap_write(iep->map, ICSS_IEP_SYNC_CTRL_REG, 0); /* one-shot mode */
> +		/* Enable CMP 1 */
> +		regmap_update_bits(iep->map, ICSS_IEP_CMP_CFG_REG,
> +				   IEP_CMP_CFG_CMP_EN(1), IEP_CMP_CFG_CMP_EN(1));

Nice to see this also has a marked improvement with removing a level of
indentation.

> @@ -498,11 +489,21 @@ static int icss_iep_perout_enable(struct icss_iep *iep,
>  {
>  	int ret = 0;
>  
> +	if (!on)
> +		goto disable;
> +
>  	/* Reject requests with unsupported flags */
>  	if (req->flags & ~(PTP_PEROUT_DUTY_CYCLE |
>  			  PTP_PEROUT_PHASE))
>  		return -EOPNOTSUPP;
>  

This likely causes a textual conflict with my .supported_perout_flags
patch. It looks like it wouldn't be too difficult to resolve though.

> +	/* Set default "on" time (1ms) for the signal if not passed by the app */
> +	if (!(req->flags & PTP_PEROUT_DUTY_CYCLE)) {
> +		req->on.sec = 0;
> +		req->on.nsec = NSEC_PER_MSEC;
> +	}
> +

Regards,
Jake

