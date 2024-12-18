Return-Path: <bpf+bounces-47252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE629F6A17
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 16:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBFBC7A5E80
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 15:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFFB1E9B09;
	Wed, 18 Dec 2024 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NcxRhtxv"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990C2433D1;
	Wed, 18 Dec 2024 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734535926; cv=fail; b=B8MaZS5mk45HfUEH3cDfblXj5etBTtUcIkGas4U5lUPetpq3956QMsV182nQUFBiKeP8DLFXTTMFqJ+O7Om6u8qTuqApEry10YMQUtuS8uVcN5XoApJjTOZPQOoxLQigxJ6ADgkFcvhcqd8dzbwMvQHsHZwElDlT8zPoM9G4Xi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734535926; c=relaxed/simple;
	bh=Slk2EOLEP5FhRzJbtm5My0oGK4oNS7f6HieLp8gAlck=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WhF5XJkMmCpcVPkQSJDKkLoe8rXZlsccSiwOYqOE1ny3RAQ38N5+ihEygjBNZt/TwVPtnjt/MzW0a5G6ElNkGeBurN+prJE1K7lsFQHf5T+k261LunjZI+09VXtQxalP55USTweF2d5c5cfaX8JlZixRzrpZCuTEBjrFb97ec4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NcxRhtxv; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734535925; x=1766071925;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Slk2EOLEP5FhRzJbtm5My0oGK4oNS7f6HieLp8gAlck=;
  b=NcxRhtxv1L9Td4cGixR/gYSr8T0sXHqyTAWe5b2lhs3GLUoqNpItOQP8
   AsZuePGZVomFWOvogHFvjriIldrgrnU/j6widtultgpwTCTUKEPt7U4eR
   CxczNlRe1r6m2sJIywDvizm5mrnfRwmV46ji3R8y3faINhJj8JLR9ZMzG
   ebaqXlTbC0NHc2U1TpH4Y3o/muRipYwd4DDqXFZwVbTSjv7KevptnTMuv
   wgtd4TWAa/4fqiSmMh2RcDFNVBAzwvVxcDmtES/HSi9h2brAvqXyPzjUT
   hz9bcJFY436rbODtb9Asx4fROjNRSos6r1QblF3uP6clhqGRKaxVdLEJy
   A==;
X-CSE-ConnectionGUID: /RJ8/8Z3TYGSgd4QuQdeWA==
X-CSE-MsgGUID: 1xR0dsOWRgWGEbffVcTmWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="45707655"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="45707655"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 07:32:03 -0800
X-CSE-ConnectionGUID: 9ohPUxl8ToWjTHoi9wXrOQ==
X-CSE-MsgGUID: sgAEKbnHTvi+8JRA8Mry3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="98307617"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2024 07:32:02 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 18 Dec 2024 07:32:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 18 Dec 2024 07:32:01 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 18 Dec 2024 07:31:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5njw3QeSD6EhQu98AXNJI0FXNJTeWEmG3q0uiCbWb+MQHbFNlHdw2/mj2tPVYvFVOcjGZQme9VDlnPgYDnkgTSMENEugODP+J7dn+zUW0tCMs1eJLAU6bkh+yvEIYZoDl4dsfojfIlJiGc6R5nM9h/gBVm9pZqu/Lhy0u22779XStgZ+aMaPR37QNCVi3gvvtybs6qDhTP29paabXVwgrLsTML6RGH/xgjW5yfpdx0w/gsLXChT3RKOF0cBuWrhDGWFv6LaQUWVkNmBSjNuSUU9h6JkA/xhN00bt2OmR2im0AFPT5S7SJacpW7Exech7PE6NdK40B5c4ff0Iqmrvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e87T/G1w+SU95TmS4ni7plw0+D1aWjQZb2XsP+WShy0=;
 b=f/JWkNqCLp0ujTBdLF2ABlUuw1Z2OhrnaB6R6HNPokW6o+e0C7Bdp69rzYd7EI2MumazQ+EbisJfsisH8rNr6r6GyNhgdPTfA7/IL3NmwQ9ros8NM2rneHU0qLzwQyBicVu3gXCAK/5iJ3ERSJZQ3gTIYeX7u4Req8sxwVS9oVnZsHmk+BTwIBsq9WsUiSFq5ayMRgSy7HHWhsMPKolATEZ67z6jWzxYLov9BIzBt9FUON5YX0uhG3HF1BrE9h7CNzkbfRXIFw7EKNxNCt19NgjzjSf4Jqx/z8ELkzO+JnViKn/HDxEi+Angvzc8VdiP2ieXT6VGpyMe1MNbSSGUow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB6898.namprd11.prod.outlook.com (2603:10b6:806:2a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Wed, 18 Dec
 2024 15:31:29 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8272.013; Wed, 18 Dec 2024
 15:31:29 +0000
Message-ID: <3ad7bdd2-80d2-4d73-b86f-4c0aeeee5bf1@intel.com>
Date: Wed, 18 Dec 2024 16:30:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/5] gve: guard XDP xmit NDO on existence of xdp
 queues
To: Praveen Kaligineedi <pkaligineedi@google.com>
CC: <netdev@vger.kernel.org>, <jeroendb@google.com>, <shailend@google.com>,
	<willemb@google.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <horms@kernel.org>, <hramamurthy@google.com>,
	<joshwash@google.com>, <ziweixiao@google.com>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20241218133415.3759501-1-pkaligineedi@google.com>
 <20241218133415.3759501-3-pkaligineedi@google.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241218133415.3759501-3-pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d85107-ed2c-4a60-5027-08dd1f790ad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZURWOFNVYk00Ynd6d0JnQXNhRXc4MkdQVXdCMGYwV3NJcE5jb0NJVnNvT00r?=
 =?utf-8?B?bjI1RnBmR2hUSHlkajhiVXpHUzlGUk1TaHBiT2hTdWJGaDArRW1FeTg0UjRI?=
 =?utf-8?B?TndDemgrQ2I3cnRNUG1nRTlFMXZaTHMvTi8rOXEzeENlUjIrdmNXMWNnYzha?=
 =?utf-8?B?MHVWY0M0OVpGU3habHJoZW5PdFFMV244aFlBQm10SjJUNkNTRWVaN2k4M2FU?=
 =?utf-8?B?ZEdrTGlNT2xpQWdlL0drVVpoK3dtWjhVT3F5NDFycFpSNFJyNFQ5eHZMZFdo?=
 =?utf-8?B?OHlMUlF0SHZBQ3dmWERsV2VQbmFWRWlSMnovZ0RXVEE2RVpENVppYnMrVVZW?=
 =?utf-8?B?UllMb1hxQkQzQjNjeEF2UEVSTCtrRnoyWHdCaUFPUmM1K1IxeG9wVzFtQXR0?=
 =?utf-8?B?cCt6RFBDRjhhQVVPbktlbnQ2bnBqczJCSXNxaytnT0ZneWhrdkUxbEhxMUNq?=
 =?utf-8?B?R3JpaXo3T2NXWGNXSCtBU082SzRsRVBGVFBySEpDaVVlSG1lNDBRWkcrUmJN?=
 =?utf-8?B?cE9EY1VZdm96cmZnZU1ZTHdIRnpVWWIyeDFkUUhZbU5WN1dhM0RFTG5iRUlZ?=
 =?utf-8?B?WHZUalVQM01yRUVWTm9LTmcrRFpWamJ0VThVRTNwQlQ0MUV3V2hjMXhIZzdY?=
 =?utf-8?B?dUZyUWdmV3E0OGNQd0V2M1ppV2l3aTlBeDFGRm1CcE5UaEZYQ2dNL1NFaGJk?=
 =?utf-8?B?SG9ueENSTk03ZTJFdGgrOS9ydmRYeDEwaTR1NzZnUUJNcktjVmVkOTNzNFky?=
 =?utf-8?B?WnVFeEJ5R3Jra0wyZ1VIWm1BWnBrWkZxemtXY2Jla3N6Um41SW1vcldGdWll?=
 =?utf-8?B?OWk2TjVqa2hsc0lLZCtMTG5xT2hyaS9aNW94dS9sSHZyVkh5WHEzenVsZkNU?=
 =?utf-8?B?b1RiQTFIcDdKbUg5SFRKM1JCQkIzSkFGNDU4LzlLSDZLVFRHZElkODFoZzVY?=
 =?utf-8?B?MlRmOE12bUFBb2RHTnpHWlpNalk3M01HdVBIK1pvTUdpNUZyQ1MzWEhXUkdI?=
 =?utf-8?B?ZDMvSHhpV1phK3FxUFNTcDd4TS9jUkpRUjhrR1hRT2NaYUtHZHBNRWlxNXBs?=
 =?utf-8?B?cmJqZGxsNjdhdVdIaStkRWt0VHNUUFlHMU0xVFUzTW5wM1hDRzFmdmE3NTRu?=
 =?utf-8?B?Wm5vWEVJVEZQV25adE1ZZjhGL2tjbHFSK0twbDJZNHZDbncyRlEwUjV5cWNk?=
 =?utf-8?B?M3VwOUwzQktDUU90a3RzUWpIcUJhck5ZR1dPM0hUQ2VGQVpjblh1NHh6eSsz?=
 =?utf-8?B?R2FPWUpIYldqTU5TWEpmZ1UyR1ZqM0RXeEpSbWhMZlBSVG5nNmZjczJVbk9I?=
 =?utf-8?B?Rk9pazdaZHBEZ2JRWjJZUXQ1Qm95ZytaYm9UckxXVXgrUEZTNXpQbGYyV3Yy?=
 =?utf-8?B?dVp6a2QvS2NuT29yUmtvbm1JWDZ6aE1CY2V6aFR3SlNHVFRYbE1WMy80b0xV?=
 =?utf-8?B?WDZ3YWNyeFdXaDMyR2FuUmJ4WVdGaXowRmRpZjNrZ2puWnAxTVhXYWpCK3Vy?=
 =?utf-8?B?MCtlQmFJZnFvbUM4WFBPWG9teWJsM2JoZSsxVWZIZStVQXNRNldzWk1SVHBj?=
 =?utf-8?B?OEZzSDBNMkRDd3ppdjVKNmd4RlFERnFBM014QVBOa2ppNDd2RmxIak9kMkFz?=
 =?utf-8?B?Tk5tTEhnR0U3OTJ6aDVacENraWRHSHFCVFdUMXlhbXZibENYZGxDUGxzWGta?=
 =?utf-8?B?MEltSkwvb2F4M0pDTGpGUndEdUlXV01Fand4TG5BV3lvanl2SXJiNTRpclVD?=
 =?utf-8?B?VGlJYjZSUlM1L0RYMWlGU0k3R0EvTjZvMUJ2Mmc5RWYwTk5nTGkwVG01alRw?=
 =?utf-8?B?bDlsa1VGalZ5bXgvM2dhQVFRR25FVWpoZHpvS3l3REcvTWFQQmRxNlBJRExD?=
 =?utf-8?Q?+fGafr3DdGClf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTJCUWhFSlNLMFQvK2VFY0xQODF1cFh6ak1IbUNNNHVqOWRKblhrVTY4MlBZ?=
 =?utf-8?B?YUhNenJhZlpjVEZmZnJvL3pEWHZjYUdxTmMwaUpuQ0ErdGhjOWF4M1ZGQi9Y?=
 =?utf-8?B?bmtUNkZCeER4NEdMQWpsQURSSjk2WXJ5dUVJenhLOUhtSWU0ZklEaXdVQTZN?=
 =?utf-8?B?WHl2cnRxbHM1MjBTVGRSTWpicmNXNkhxakMwTlQ2QmRySVpudXo5ZktZcU1i?=
 =?utf-8?B?R2p0RkY5dDVRYUc0TE1xbEFUTXluWUkvYmVvVVAzNHNSdGZSam15V1N0V3NO?=
 =?utf-8?B?Yk1aYlZEczBQVDNCeCtUUk9vTWdtUjNQOGJSYmwyOE1HSW5FNVVBZzE1QU9S?=
 =?utf-8?B?dDZ5TXFkaDVZY2F6MFAwajVWT25EbUs5QmZnMkY4SVA4R3ovc1g2RTdIN2N1?=
 =?utf-8?B?Q29uSW8wcGJ3aG00QTJIMXd3UnNNTjhPcU1qckprNGcrbHdUWHNTdHJDY0lV?=
 =?utf-8?B?RlVtVGN6V0ZsRkRUczltaU0reTg3OENSSWRDb05YNGVqSVV6Qkg2OFoxZGJq?=
 =?utf-8?B?dFhVdGJORVhXWnAwV040cUNqay9uRFdhMnhLWW1SdG4xY2lESUhBQkZJbXlr?=
 =?utf-8?B?dHdaV3IrRGVDKzR0TFpVMjdSTXg3SC85R2JIcGdUVnNYYU9yYXJiV3RoTDRJ?=
 =?utf-8?B?aXgrZERodlhsalJ4Y1VhRUNZQTYyYng4cktpYXI2emFpOUk5eHhibjJac1kz?=
 =?utf-8?B?U0wvTENmbDVqRVUyZldHT1RaN3B3T2d5RlhGUnVySTMzdUFEMFVHMjNob0FZ?=
 =?utf-8?B?OXkyeXVmZEV0d3I5SXJuaU5lbWxlTlk1a1lIenlsU2pNYTY3SitlUEI2ZmlF?=
 =?utf-8?B?Y3Nja3g5WGtLVUt5VllCUFZGZm5BOUIzTnltUVczOXVYRmEzTW1lTXhDU1ZJ?=
 =?utf-8?B?ekFFaTI0TTI0YjVUVDlkV1NrRDc3NXl6K2t6aE5GYWJDU3NEQ1dObEVoemNV?=
 =?utf-8?B?RWdRbGtjS1ZyRlJ0dlpqL0dldkRyWHBpVE5OcUQ5NzVaWGplSzI5VkhRcHQw?=
 =?utf-8?B?ekh0dGRGaEhISUN1azMxQzJ0WjcrQnlpaHlpTFRMcFdqZWNhalZXMDdnWHVr?=
 =?utf-8?B?d2NiOTV3blpyRmJqMm1UNlY1c2VLM0g5SU1NZ01XSmdobm1GVE9zV1VlS1lC?=
 =?utf-8?B?NWxyMHJMckRpakVoUW9tY3NXMzRRNE05dVBXMFNQY0NEby9LRm9rdnlOQk03?=
 =?utf-8?B?b1l2OHdsOFkva1hWcFVzVGRWbHpLYkdiLzcyTWZmLzFoQUFLakxod2tTT290?=
 =?utf-8?B?dy9LeGN6K1hZVWJ6UlovalBRdHZ1ejAwU0dHbjB2UkwxM2VZWVo1TmR6anYv?=
 =?utf-8?B?MGZ6RTc0N3pwZ3RFanc4UzR0Z0ppN0htNkxaaENpVDFVYmNsOWU0UzVueHY4?=
 =?utf-8?B?ZEYvSFJ5UUkzbmJxZmJrQ3A1RmRDc0ZHeU1HT0lBWXdSNDhCaUlDUmE5dTVk?=
 =?utf-8?B?OEZueWNlb1RVay9KblY3TnJVMnpnOStrZU83UlRzZmVNbDBvQ1pCYm9UMmZM?=
 =?utf-8?B?YmVQZVdwRU5UT0NpQ25zVzNxZnRsSk91N0lpWG5YWjh6aHJmaFBMYVlRNlF0?=
 =?utf-8?B?a2R5dHYycjVTdUVkNlA2aHB6bGVEQnhueTlsRU9zbXEyYis3OWJXZ1BGdmpj?=
 =?utf-8?B?UTU4OFdueUhxbG5BWkpZdjFkWXdqSnlQMEVVWVhablZPV2RqVkVweUcydzJw?=
 =?utf-8?B?S1ROLzVZYS92UW1KdlI4VWRhYnRBL0x1bE5aaS9kUUFnU1Y3TDlGTDkzeDBN?=
 =?utf-8?B?UTYrRkRzVU9LVmdvMUtKNVdsTVVIV09FUUlLbXRKSyttZ3NGOXVqZ1lwMXd6?=
 =?utf-8?B?Nyt0S1FZT001NUlpN1R3cXBSOEZSUkp5OVlGbnVxU1pDK0VCWkRxUmRtbW5P?=
 =?utf-8?B?MURBekR5ZklyRTNIbnRGcWZSSWp3V3poekxac0NxZkZEdGFiQUdTb2s0aHBH?=
 =?utf-8?B?RlNudk5YQml2SWdGUlFMVVhsUTJlL0JPZlBoVGd1VWc4TEIrYXdyYjA5dVJL?=
 =?utf-8?B?QnlOamlDZEs5NXNoUmVoMGJFalM0THNtNjRSUE05UDFpM1J1dERCUHpxaEJT?=
 =?utf-8?B?WTltN25CQmpvQ04rVS9uR0IreTV6VWpIUGVsWCtrMy9oeTV2RksvQ3V1b21o?=
 =?utf-8?B?c3ducVNRcllyZys0d1NMY0dSL3kyMjlTaW5TSUV0SzhTcSt2ZkdXVGxoRHY1?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d85107-ed2c-4a60-5027-08dd1f790ad3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:31:29.2057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLXs9LjvtMtFHBxy2fQtTD4anZdbdHbE/OL57j/DJbzyquIXH52Y9dObPqRvuRB/uXxCdCKKZOkE+vq2kAhOzZZtUFPZdSUus1e5zaMbNpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6898
X-OriginatorOrg: intel.com

From: Praveen Kaligineedi <pkaligineedi@google.com>
Date: Wed, 18 Dec 2024 05:34:12 -0800

> From: Joshua Washington <joshwash@google.com>
> 
> In GVE, dedicated XDP queues only exist when an XDP program is installed
> and the interface is up. As such, the NDO XDP XMIT callback should
> return early if either of these conditions are false.
> 
> In the case of no loaded XDP program, priv->num_xdp_queues=0 which can
> cause a divide-by-zero error, and in the case of interface down,
> num_xdp_queues remains untouched to persist XDP queue count for the next
> interface up, but the TX pointer itself would be NULL.
> 
> The XDP xmit callback also needs to synchronize with a device
> transitioning from open to close. This synchronization will happen via
> the GVE_PRIV_FLAGS_NAPI_ENABLED bit along with a synchronize_net() call,
> which waits for any RCU critical sections at call-time to complete.
> 
> Fixes: 39a7f4aa3e4a ("gve: Add XDP REDIRECT support for GQI-QPL format")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Shailend Chand <shailend@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_main.c | 3 +++
>  drivers/net/ethernet/google/gve/gve_tx.c   | 5 ++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index e171ca248f9a..5d7b0cc59959 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1899,6 +1899,9 @@ static void gve_turndown(struct gve_priv *priv)
>  
>  	gve_clear_napi_enabled(priv);
>  	gve_clear_report_stats(priv);
> +
> +	/* Make sure that all traffic is finished processing. */
> +	synchronize_net();

Wouldn't synchronize_rcu() be enough, have you checked?

>  }
>  
>  static void gve_turnup(struct gve_priv *priv)
> diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
> index 83ad278ec91f..852f8c7e39d2 100644
> --- a/drivers/net/ethernet/google/gve/gve_tx.c
> +++ b/drivers/net/ethernet/google/gve/gve_tx.c
> @@ -837,9 +837,12 @@ int gve_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
>  	struct gve_tx_ring *tx;
>  	int i, err = 0, qid;
>  
> -	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
> +	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK) || !priv->xdp_prog)
>  		return -EINVAL;

The first condition (weird xmit flags) is certainly EINVAL.
Lack of installed XDP prog is *not*.

You need to use xdp_features_{set,clear}_redirect_target() when you
install/remove XDP prog to notify the kernel that ndo_start_xmit is now
available / not available anymore.

If you want to leave this check, I'd suggest changing it to

	if (unlikely(!priv->num_xdp_queues))
		return -ENXIO;

	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
		return -EINVAL;

>  
> +	if (!gve_get_napi_enabled(priv))
> +		return -ENETDOWN;
> +
>  	qid = gve_xdp_tx_queue_id(priv,
>  				  smp_processor_id() % priv->num_xdp_queues);

Thanks,
Olek

