Return-Path: <bpf+bounces-55996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B80A8A5E0
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 19:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C386B1894AE1
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 17:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB9B221567;
	Tue, 15 Apr 2025 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ch06itwx"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107CA2206A6;
	Tue, 15 Apr 2025 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744738936; cv=fail; b=P2Uu/cIA/e9t5Hnv+SVT5YMcgeQhw74PCjrE+57J7RleGtHL8iZgJbYQomZba5yDUurho+/dghkxjSsPLD5a2bhu9YOiUNlker81eIo7tFlJrGQNKjlD9d2EOhluDBTUTQTBmDSxEhfy3zPFPJq933bhUu8eY5BmVYgGK3IL/Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744738936; c=relaxed/simple;
	bh=5izJGhFtMdBBEyrvYUZDiFpMGogIuc6/n4zfbeLjL8Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qqS0rT6hf99y+WFJ6TUZGs8T6RnCvCndzK5l+lb8maRNTU/kejPwEnxu/kf64+fjoL2BW4lxXQkGTCMjirf26teeEeMIZjg6V0FYslF7y6x/1rpBSpW8brd4whdtpZ3OYGUeDxOVD/u4Qr1yiCzc85uRZghbb6Sm6lJX2xlBf8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ch06itwx; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744738935; x=1776274935;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5izJGhFtMdBBEyrvYUZDiFpMGogIuc6/n4zfbeLjL8Y=;
  b=ch06itwxXfVsKh6uTdwDc1XLPYBwPUhBfs6D6ZkUaGKgedbo9T0hVfLj
   SCuebSVfBSibM9EVIHhs2MWtjWiKyNJXeX6P0Yjt4tEGI90esDfAV0Zzy
   ew8rxPHEw+SukqTI2Z8NLXvIG62BMX9K2AKzHayIqQRZAfFTHKtXDiiAw
   JpI4J/ArG0vPm73P/sWiZacNcEdysvUcT1hg4YQxsJeULrIyx48kN0u1t
   uC7zWyj0Y080QfqjtGsQYmk2wEs/U2d9oIpSYSglJUdaMmfMlCrv1tIT3
   ykzKqq5mko7CNcD0/0lCQzgFSQk23zENECWBLnJmWd6nsacYZ8qe4Zzi5
   A==;
X-CSE-ConnectionGUID: 180EPfjiRHO0OVyUkid+1A==
X-CSE-MsgGUID: ZL8hL4QyQyyWGmQi7oWOWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="50088435"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="50088435"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 10:42:14 -0700
X-CSE-ConnectionGUID: ic284tryT5eQmHdYw5Zztg==
X-CSE-MsgGUID: oIKcpizbRwuEKLnRstJOpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="134290584"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 10:42:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 10:42:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 10:42:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 10:42:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlPUpNa2vwCxRAf1H8hWe73AzuOrSfuL3xoHN71Q4t/EVBzeQbpdwJO3uXaQQQBytFJAa+v/W4PrJk/txy/fs/q08GOneAu2CvC+OrdAJfDU4qmCRCwwzJtWM+YOG1N/Bct+FhY5PFVQVm56gZ49+u2IhHZVKbS7dFeNoVrgeP5G/RUxJXG+sP212nNZTi/aoSbY70hnydXrKMdZdg5MtUQ3zviKCV8vQ14pliXI0cL2pbIZlUlZkANQ8TR6Wk4P9kd+cLqXyiCXf+wNb1ywQSTik/aMG5CxpSpqQ6gMQOzZObf1fubQIMUMNSDzBfPphjPT83hLTIt+o2XTYhyu7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WC5T7g4qwDnZXsyGEYIOaYLQrAAW69dpXtCkDNVQQFk=;
 b=wq5X7AbqaCkX/vhmE1peK9SmqVUqKMQdpbJ+tYuKvXjV4zz+/LagoJeFpS9ck2SP2OrEKgeodkSaclYkiL/qQqa8vfALKVyfZHJyG2aqLMCxPRMEXiQ5HKQdLQJXP2sjumMu07srZdlbEFa2ussH00RlAZhIbVxJ0ftawmIXxqp9zxme5QTSJtIvx3d2MyzfMqQYZSV0Je286CRazCIncDHpZksl2T+iKJJ4+GOkuhWA/uRogVUwYkewrRYmL95+6ZnnsIVwmIQqUfazEpUtSKDaAQGi80QyQ1EzdpvC8vlolBXeuU1FSr5SaVxBrld5rK4neIC0cwPVB494ncaf7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA0PR11MB4607.namprd11.prod.outlook.com (2603:10b6:806:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 17:41:32 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 17:41:31 +0000
Message-ID: <33a18692-1f95-497e-b648-8857ed9484b3@intel.com>
Date: Tue, 15 Apr 2025 10:41:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/3] net: ti: icssg-prueth: Fix kernel warning
 while bringing down network interface
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
 <20250415090543.717991-2-m-malladi@ti.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250415090543.717991-2-m-malladi@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0347.namprd04.prod.outlook.com
 (2603:10b6:303:8a::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA0PR11MB4607:EE_
X-MS-Office365-Filtering-Correlation-Id: c5eeab27-2efb-40aa-cb6c-08dd7c44c230
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmFGdDBtbk1ISVk5aWJkNGhZeVFZQ0lQNVFhOXRvaDU3QTFXZnJSWVl0bFc2?=
 =?utf-8?B?VFNEcSsrbFlUaFhvU3ViM1l6UzlIUml1dlJXNCt1L3luaElzM3IyQXFnM3VY?=
 =?utf-8?B?UGJRMm0yWlUrWEZwS3FnaEhZdlBsSkJ4RW1JWU1BL01Jam5OMVF3VUFWd3VT?=
 =?utf-8?B?RGNLVlVOVVI3TWI0ei9YUlRHTU5IY2UyYkgvb1B5OU9VQm5DU295NGRYWTU1?=
 =?utf-8?B?NDUrcERrK1JqL01XeWFWaFZjZzhHR3lnQWk2dTNyU1NIN3ZGalFUTmZnQkU4?=
 =?utf-8?B?K2lGdkZwY3M4eHpWWXpMdjYwWWZzZlZ3OHpaNXNVUEN5aVdLOWZzUHpqUUY1?=
 =?utf-8?B?dnQ5dHRpNnhMK2FDTXY3RXYyeUhxS0ViNXFRNk1mZWVyMGh0MWVMQXgrZTll?=
 =?utf-8?B?NG9mYyt4c0FUSVVPdzFMYXFNZU41Sy9aR2dYampjNnFuT2FZdzdQT1NGbjBs?=
 =?utf-8?B?OXRNV0x6Q0lGTlp5bTNlTEZ4YlMvaG5MbWdOZDVUV0NhcTVLNzljWnNzY2Y2?=
 =?utf-8?B?K3kvTVZGRTVvR1dTOU5PZVphdnR2eWVpT21rSUhRS2lxeW5kemxNMHVsYlRB?=
 =?utf-8?B?TkszUUhKbFRyQnQ0bStvUWxiM3UwemhkYi9majc3T0NGa2NnbTRweHJRM2hS?=
 =?utf-8?B?NVAveElKNmJ2Rk03SGNUQ2xIRGM4NXAvclVNNXFIdWJicVJvZXdOcWp3eGow?=
 =?utf-8?B?NVltaVVncDNsYzJaODMxSzkwNExvZzh6Z1M2ZmRuMWJLUTRsUllib1ZHRDB1?=
 =?utf-8?B?S0lQaGw4MmJsRHNTUkFyNDkrNENTNXpxT2JHd3pOeUhtZW5zTXA2RElqNjE1?=
 =?utf-8?B?SXlyTmhhU1p5bmNwdVV0L0RPQnlxMVk2ai9aaHJBbWpCekVNS3cvR25JcHJE?=
 =?utf-8?B?Si8xQ21Ddmw0QmpVTnBzL3YrY3hET21DdzhxNlo0azFUM0lJayt6cllrdFVZ?=
 =?utf-8?B?U1dZRkFyU3lCY050Wkdidmk5eHJtaXpZWjNiMlVZcVh1NzNiZENjbVdSaVVS?=
 =?utf-8?B?VzdqbGFwVFluOStKL2ticGZ0Ky9iVFJWdXhyMDRSNkJNZ1pRZlk2eFVJQnhn?=
 =?utf-8?B?MWh2WHhtQ1VxbWpPdG9yQVlEUnllUmdGLzEzdjJNOWxOQUFDTE9sZnNpNmdn?=
 =?utf-8?B?ZWVFeE9vWDBqK0pHS1JXTHpOZ1owSlQ4VWZ2S05YaWFtcWRDbzdtNWlPUnY1?=
 =?utf-8?B?YjlsNW1EYzRKWjlxT1c4MVRscXozMUlqQXB5QndOY0FtL3YxUmU1RjFxa1dW?=
 =?utf-8?B?V3B5RExTSWt4TllobnFhbmk4NjN6dUVnYXBzdGhYN3I5Y2V2NGtva1NmUC85?=
 =?utf-8?B?NE9qdjB5MWVhNlp0Sms2RlFjZEExTWdpYzN0SlNoNHF3WUVJRzBVNHRGUWlQ?=
 =?utf-8?B?eS85Z2tWa3hyRXZ6VENZQW5ZUDVxeFBvZUh0VGw2U1lmaTRyN1h1azdwVDFR?=
 =?utf-8?B?SXI0YnJTSVUxNkxFRUVwYVVOdFhqZHpQYSs4MkxoY1VDWjZLMWhVMGZWQ0NU?=
 =?utf-8?B?UCs3WHlSaCtmVjR5TWt4cUdVUlZoQnphblFWdGpYc244QjVhdExlNnlZUHZk?=
 =?utf-8?B?U3RWaWI2MEp3WkRIT251a3B5SkJFUUQ1MVphMUMxYjk3K2RRYXJqcGxITWpP?=
 =?utf-8?B?Rm0wZFB2Ni9MS25VUEUramdET3BIUFdETFZscEZrZnpmcEJpK0lvdW9GVERB?=
 =?utf-8?B?T3dPV2J0MUMrK2djcGlKVXdJd3BFWU9qVmZlWHFtMTd0QWRQV2tpUnA3UUhY?=
 =?utf-8?B?M3VFSVJhREtQT20yOEV5SmhrYlQzNHpNL0ZLdEpYTHZFS3Nkd3I0RUd3eFNV?=
 =?utf-8?B?aWdkZjFSbFJpZklmWE9peUJTT3NVNUEyWFNYOXRYVXAxMWh2cHlFcmNJeDJr?=
 =?utf-8?B?b25mN2pQeGVSYzEyUU5CSDJYNlk2ZmRXcjZXREU3bGRmK1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzFQeDd3T0RpeXVBWDJHampuVkZlTHExeTA0Z0J6dTR1TVFkNlJHMzhNUnBN?=
 =?utf-8?B?NlJQRHlDWkV4WHdWWmpJK0JzMk1ReHlITGF2eCtLQnkzWmVLbTZTajJTSmFi?=
 =?utf-8?B?Zyt4eTR3ZFFRbDlBU0Q4UXE2M2hzdmFCZ2NRUkRUaVB6b1VwaWp1RTlzajA0?=
 =?utf-8?B?WXJMcERMYWZjVG1TajdhY3doMGVGVFMvZTB1aXhoZE91V09zUHZXYmpIeWV0?=
 =?utf-8?B?b3Z3OFlIT0xKb3R5ZlU4YkMyMHpRd3ROYzhrblpva1FMazFDQTFQa0ZMSVhq?=
 =?utf-8?B?dFdCbk42WTBKa1U5NDJ1dVp5TFZHVEVOc1pLdnVLYjVKQUlmTDQ1bS9VSHdU?=
 =?utf-8?B?dnd1dG1wR3RZSHMxZE9Sd2tqbkFra1pMbmwyTW9UYWtVaE9SelBGaGZtWXR1?=
 =?utf-8?B?RHB3cW1xRWhia05CU1Z4SnVWOUxXZjlJdHBEaG5hVEk5STA4UUl2TUVYY1N5?=
 =?utf-8?B?U1ppd2JIVjE1RmlCd2t4UzR2anZ5bVY0VmJPNDJidDBBcEozUnJiWUgydVBN?=
 =?utf-8?B?ZXA4emc0NmZ3OWRicVN5bE9CVmNlTmN2VnpDdGpGUDl5TFFjMno2SFQrK2F6?=
 =?utf-8?B?a2t0cW5TWm9SdXpvSjhDQVcvOC9acEg2Y1JPaVVsZ25sMTdGekwyQzg5WElq?=
 =?utf-8?B?SUJZdFhRRHRPZFdZRWt4eFNqTXV2d1gyM1o0MjhzaWxwSjk4V2xXWm9ZTEw4?=
 =?utf-8?B?TEk3ZldERjNPMi95eHZISGRKM1ZaeUZab0N3SE9Fd3hLdC9IRWh6djd2ZU1C?=
 =?utf-8?B?STBuV3BPL3ZEa05jSkFNWEhrY3haNDlXSGR6Zjl0azBmRmV3RTlWR1pJUzdY?=
 =?utf-8?B?bkRrd2pBZEJ0cXJxWHVOa3h5QWUvVmpWbnhvZ3R6bjJ1cklwMmtGb2EzQ24z?=
 =?utf-8?B?MkRZT3ZmdDFWb2tqVzVzTnc2bS8yWEp0SHFGaWVpbi9SeDVaYXRWUGtaS3d4?=
 =?utf-8?B?TzZqSnU1TkdWbXJpRGV0S2JGcktSMVVKVjVOSkwxbTEwL0VKQUMvTUxJSXJW?=
 =?utf-8?B?a0pjUXA2TmtmaU85SmYvVTZtZ2tGcmZGMWFESG9hVDl3TjFLdG5ONE5PQUNF?=
 =?utf-8?B?QVVUWGFCNXVyVFFnRW9MK2t6VmJCdys3M2ZtamhaTzdCYXFPcGJzalNHcmlo?=
 =?utf-8?B?UkpGQXo4R0dIb2xMVExLNXNLRk9vV1dUdFFRSmN1ODg3WTNpVC9NdGVWeUVy?=
 =?utf-8?B?bkpldERoZUtXSE5EeHBwaGFzREp1VlVuMjFlY3M3SkYwSEplK1JRTEExbzdj?=
 =?utf-8?B?VHFScHVCSXRiM2NMeks2NTBySUV3YllFbGJQNVlYamErRFBwWFhuTXVNQXds?=
 =?utf-8?B?OFpzWXpOcUpZeXdEQ21mMG9IM0puaXFEYlE0K2l5bnR2T3NSd1hUVjJaZ2N3?=
 =?utf-8?B?R0xrWXYvQjh3VWlKZ3pzcGtCZnAzOEM5WnU5enROcW04QjJydllUQlo1NTFv?=
 =?utf-8?B?a241ZHVUVi8rMGFKOVZRY1lZMTFNNGppNG5UTzFjaWpvOHhmeXh1aEFDZWFV?=
 =?utf-8?B?VnpMNXJmTmxZT2FzTm1kaWI2VzJUYlI1V3FPK2dYSjZFWUdmU0VwTWxJL3N3?=
 =?utf-8?B?eW5lQTl5cjJYRVh5MXVtcVplbEVaWUtyWGpBdkpTb0pNZzRuK3dYRDZCa0NE?=
 =?utf-8?B?MzFzbVVRSTE5UlZ5L1FrUlVVRjdFQll2OGJaSEZJTjJ5M1ZxU0lGdHY2dG1s?=
 =?utf-8?B?MlZ4RVRoSmdIRExLV1lCQTloY21HUVU4RHJsZmtLUWFOV0Nkc1hkMHQ0YVg5?=
 =?utf-8?B?ekoyYjhsaG1Xa0ZCTU5pN0lhbVpkQUU1T3F4UVdaeDlLQnV5VHRPQWlMU1Rt?=
 =?utf-8?B?dVNvQ3UrZEpOT05zM3FJQkl0K1dHc1VhMi9NU2R2RjBiMUlZZ01CM1RVYzlB?=
 =?utf-8?B?cjUvcWFKN1hGaFpzVlYxWmRUcHRDbGhITFBoZ2NnSXBCaDhrWWtNVi9GR3E2?=
 =?utf-8?B?NkxBS2RvQW4xNlhBMEo1Z29jVjljSlV2aVlOWkhZZjUwVGtURVFmY09CUUJh?=
 =?utf-8?B?ZjY0VCtIdjdIT2JUZE9MMTBNVjdSc2NLUnpHazJxMVNNUHZ2TEhIRHcralhB?=
 =?utf-8?B?cFFJZytYRzVEcFo4RGcwSmQ2NGFBQ1FTWlBXRVZ4MkVIbU9ZT1dxVUVqcmZT?=
 =?utf-8?B?NFJkTzkzbUZkZmthemhxQ2JjbUFwMlhTNzJTRkR3aGx6ek9WalVPT1dwWGg2?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5eeab27-2efb-40aa-cb6c-08dd7c44c230
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 17:41:31.5415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lh1PWxN3b8H3RN1LxoP5OWzMjjZ3AC7B7muBUwTnd5iWqY+xPLZydYOuj1xqYOAenvRL3qI3w467D2U5cCFNMD26a1BbdA68BmUCU7BGUu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4607
X-OriginatorOrg: intel.com



On 4/15/2025 2:05 AM, Meghana Malladi wrote:
> During network interface initialization, the NIC driver needs to register
> its Rx queue with the XDP, to ensure the incoming XDP buffer carries a
> pointer reference to this info and is stored inside xdp_rxq_info.
> 
> While this struct isn't tied to XDP prog, if there are any changes in
> Rx queue, the NIC driver needs to stop the Rx queue by unregistering
> with XDP before purging and reallocating memory. Drop page_pool destroy
> during Rx channel reset as this is already handled by XDP during
> xdp_rxq_info_unreg (Rx queue unregister), failing to do will cause the
> following warning:
> 
> warning logs: https://gist.github.com/MeghanaMalladiTI/eb627e5dc8de24e42d7d46572c13e576
> 

I generally would prefer a minified warning in the commit message,
(perhaps in addition to the link) as such due to linkrot.

Regardless, the fix looks accurate to me.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Fixes: 46eeb90f03e0 ("net: ti: icssg-prueth: Use page_pool API for RX buffer allocation")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> ---
> 
> Changes from v3 (v4-v3):
> - Collected RB tag from Roger Quadros <rogerq@kernel.org>
> 
>  drivers/net/ethernet/ti/icssg/icssg_common.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
> index 14002b026452..ec643fb69d30 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -1215,9 +1215,6 @@ void prueth_reset_rx_chan(struct prueth_rx_chn *chn,
>  					  prueth_rx_cleanup);
>  	if (disable)
>  		k3_udma_glue_disable_rx_chn(chn->rx_chn);
> -
> -	page_pool_destroy(chn->pg_pool);
> -	chn->pg_pool = NULL;
>  }
>  EXPORT_SYMBOL_GPL(prueth_reset_rx_chan);
>  


