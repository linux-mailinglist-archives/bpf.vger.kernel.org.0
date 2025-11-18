Return-Path: <bpf+bounces-74938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF32C68C08
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 11:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id E96A328A9F
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 10:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD1C338596;
	Tue, 18 Nov 2025 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J2tDYk7Q"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262FB33C51A;
	Tue, 18 Nov 2025 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460905; cv=fail; b=Wl8koZ8rsewBcey2V9SKCgjnjZvq9/ONivPPA9qrhaLLAKuV4ZB8+P/5GDKd6IsYmC4yzWUCs+y2yRAWH/jpnZCb9Ru5LHZMHLIAscDSupDrQQ/poh4dblwydtO8Y009scmf2TK+89jEBaLh9aX2z6TIxH+RZZHHIF3VHu+PAD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460905; c=relaxed/simple;
	bh=FBwsq4U7OP6MPQaQDdfPCLBH0jMQwUmzspnoGSkn0uQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lhal4ZRM9vWw1+YycbQ5EydMiqp/vUmJp4EYvCX77O2ct0QlGthjL5pfcbAMo0I42H5Jdoqn5/lHjzoN2KAwiPs8O+gwUI+thlrfiMUaWkJYOqG1FLgzbwUyNf5QEDzg5dBkv15XuzOnHd+RL4khUOnACpOBgK/+Zfu1R8fTEDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J2tDYk7Q; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763460901; x=1794996901;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=FBwsq4U7OP6MPQaQDdfPCLBH0jMQwUmzspnoGSkn0uQ=;
  b=J2tDYk7QqUqM3aaX+vlLaP1/wHx2WQTnINMGpeie6+SDbKJ7WFDWkLnu
   EYj8IaKn2Eb2GNw/kdyJh/zzvvLeQThPRoX2qrEcyvFr0By+SGalgwSAz
   aUPNTp+Gq0QatChsO1YDrAu796glfpaFW4XFr1aZ5C/VXyFJqyRyIkxDd
   /vO23ex2OjM6xHFlcVWPgzcmoBK75YCc2VP5u76KQpmxvjlNrw6Dksl+/
   HnC/uaSWSuMEQsFTpbKfeutI2LjuXtWCK2SSTbn+nQ5FdkYrgiUQ52aQz
   asJ6QxNNk0CVCQQ/ygZz2MmIfEVa2ZuBkR1bvq0jwZeGXQfzabASJLfRF
   g==;
X-CSE-ConnectionGUID: zOCxaKnMQ1e+OMhE/Sf5EQ==
X-CSE-MsgGUID: AQUFAi3jTHiYWlujc5IONw==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="76155570"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76155570"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 02:14:59 -0800
X-CSE-ConnectionGUID: siyvjtEYRuivAfx5qr6kEg==
X-CSE-MsgGUID: xv9zak6pRbOiiYiO+Z2FEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="221620347"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 02:14:58 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 02:14:58 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 02:14:57 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 02:14:57 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.2) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 02:14:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srcE50pO9k99/q+NhRwcOBg4J+qWdfkJP+USsAoN+d/75FYGJ+vHYBdkiguGcFSIORaggUYb5/sxuF/IMaLQicwHFsi4HB2C2e7xWXmkZWnfAD6JmLgW4/kd6Sv/h8S7d3wcrtb4oG6uSJBIKue2tdPjxWJ8LHVEIujFGVzs6syRiLMAe4XBo8tAc0Qv7sTxMMqElAoBH5rjUre+AInUCDINye7xU61OXYeZxCWmXdOnsfoGM7Zb3befPQABiOVsAjoN31yRZ9VWqtdVBkdt3zjRNFCHuYBgtOQgUhXC8iVP5SckqlooAP0I7Xs/9DPEMN8czJsiVoU5O4UzVOapIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8YoLli9dgoXQh8g5pq44fTZ5DRK71rcAx1Iyy6tm3k=;
 b=f+rkQRYytww0AbKFmbwxybd8JQHmctnZ/o4ZzQyBrUezTb+Rr05Q8UWWOEFPdPJgrAYTF4T4fIXyCjHTPeGrkIfl1vVmiF3P4Ywh9/yWzwAmLVS5ypD2NQU4oiwf8G/s46524NZAvGpFCDu8is2TI8jITk2viAcaIj94Bwi+S6TdCi7pWDkeWvxkxlKFeAk1j5w99aBw0r8CA4PoHRK4Z4R4me+Ly06pknmx0kuuppAUbf3dR25OqalztCFSafHd5loBVr1FwWIMgbETexR3jrae1FwzR5u77ZkZ6y2U1YbG573052mzv16gJeOustnOZqmuE1/CkDuszyYiMBG7GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB5828.namprd11.prod.outlook.com (2603:10b6:806:237::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 10:14:49 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 10:14:48 +0000
Date: Tue, 18 Nov 2025 11:14:38 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: Magnus Karlsson <magnus.karlsson@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<bjorn@kernel.org>, <magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>,
	<sdf@fomichev.me>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <joe@dama.to>,
	<willemdebruijn.kernel@gmail.com>, <fmancera@suse.de>, <csmate@nop.hu>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>, Jason Xing
	<kernelxing@tencent.com>
Subject: Re: [PATCH RFC net-next 2/2] xsk: introduce a cached cq to
 temporarily store descriptor addrs
Message-ID: <aRxHDvUBcr+jx49C@boxer>
References: <aQTBajODN3Nnskta@boxer>
 <CAL+tcoDGiYogC=xiD7=K6HBk7UaOWKCFX8jGC=civLDjsBb3fA@mail.gmail.com>
 <aQjDjaQzv+Y4U6NL@boxer>
 <CAL+tcoBkO98eBGX0uOUo_bvsPFbnGvSYvY-ZaKJhSn7qac464g@mail.gmail.com>
 <CAJ8uoz2ZaJ5uYhd-MvSuYwmWUKKKBSfkq17rJGO98iTJ+iUrQg@mail.gmail.com>
 <CAL+tcoBw4eS8QO+AxSk=-vfVSb-7VtZMMNfZTZtJCp=SMpy0GQ@mail.gmail.com>
 <aRdQWqKs29U7moXq@boxer>
 <CAL+tcoAv+dTK-Z=HNGUJNohxRu_oWCPQ4L1BRQT9nvB4WZMd7Q@mail.gmail.com>
 <aRtHvooD0IWWb4Cx@boxer>
 <CAL+tcoBTuOnnhAUD9gwbt8VBf+m=c08c-+cOUyjuPLyx29xUWw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoBTuOnnhAUD9gwbt8VBf+m=c08c-+cOUyjuPLyx29xUWw@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0025.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::20) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: d00c754d-e83b-4af3-ebce-08de268b4e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWhUbThxS2UzR0Q1TkVNU096WG5EOTdnNzZLMzZMd2RkUjV2WVE4Z2lDbFE1?=
 =?utf-8?B?TUtBVG5yMTdIeHVXVUJxNHRjemNMUHBMZ1hGNm8zRWE5cUxISjJKVDg5S3hr?=
 =?utf-8?B?SjY5TnhYdCtIMUUwQWtla0JHYi92VmJkVVpiUlFQRWhDOVdRMmxtMUxkVk1r?=
 =?utf-8?B?TUZUeEF0TnpaUGxjeVFpTWFKWHBCcE5rcmlvODFoaU13T2syaFJESURUQWNW?=
 =?utf-8?B?RHN3YmlobUdTR3BRTWJWdTE5L0ZFZ1FsbDJ4YkNKNTQ4Z1AxUlcrb3Z1Skpp?=
 =?utf-8?B?TmNOTlgyYldIdE1PT0pndGdYT0pyamhVZzMrZWt2SHduR2dTYmhLQmxLSGNX?=
 =?utf-8?B?OEJYazVsMWdPZWZ4Qi9GM2laMThCVU1FRWdOYXE0YlloR2UycXVFZERJSVAr?=
 =?utf-8?B?TWR2YnZzcEdEN1E1d0J6YW9BL2piU2lHSStQS0pTYUt3N1paaU5pZUd3Nm1L?=
 =?utf-8?B?ZFNueXUrSmJOUVJuenppVWZBVHZxRnVtbkI0R04wU2t0YXlwRGZqYnlCOWQ4?=
 =?utf-8?B?VE13UHRHd3N6MjQ2Vk15cEtIUERSS2I2c2c3dmlYdFhkUm9tU1ppbTYzYzhY?=
 =?utf-8?B?T3VXZkY2ZThJVUdrOU04USt4dWo5blhpa3RGaW5YdndUSHVhbjZVUTVOc2hx?=
 =?utf-8?B?Q25ZUk00bkY0aC8xNHJmMmRLdDBmNndTYUMzT2pIVzlub0RlT2lhZFVmN2dN?=
 =?utf-8?B?NERMRGNDbklVM1d2YjQxNG1QSnB3S0tlWE5CQklGTmhBYkVPWjRMVzl1RnpO?=
 =?utf-8?B?Wmc1b0NZaGUwbDdXWWN3SndqMjRjbHFXczM1ZTBab243ZnNodTA3NFkrSDhP?=
 =?utf-8?B?cytXeTNwQnE0SlJnQ0pSMlY5RWJqamNQRzVrSmlqZnlxVnBxenpWMGFiYmY2?=
 =?utf-8?B?b2ZyNFhxRmJBc2d5MGRiLzRTOUM3dVJHRHVIWmhlbHZaRmRIYitteWU0VmJ0?=
 =?utf-8?B?Y3lQNGhvejhBMElmNkt1MWNIWDZ6bmdudmRMMkEvS2d6L3pYQWtPbG5vTmp5?=
 =?utf-8?B?TlgvYUFaMit3VGk0L1JsWkJUMWc1VkZBd0FOQVh6VDNCSmYxSHdWeTkrZllw?=
 =?utf-8?B?VjEwQ2VVRXo3ck9JMUJxcHBuVjkwL3VrRlBFbThORlRSUWZQcm1nbGFKUDdI?=
 =?utf-8?B?ZStLSloyYm1KU1NyM3VJSC96VVRjNHRDc1gyZXI3eEF3T0dXZHNMSHFzVmhW?=
 =?utf-8?B?Q1QrclBkWmlxcGVOS3dMRDdNV2xHYm84UUdwczRkeHZZbWRpMEdKWGw0NjRC?=
 =?utf-8?B?SE5GbWgydVNsTS9rakM0RmJsN3JPbUFkaVFOc0tlSmhhVzFkY1Jjd2pMUVN2?=
 =?utf-8?B?aFVWbDZoSWhTWlNVbEZ1QVR1MGpzT0VIMUx5MmpWYzBHOEc4a1AzbVJiR3JS?=
 =?utf-8?B?eGZxeFBsUUlrRTVhS0huTDNsc3psL1lvRXBpSHBxQllnaDBSZlZMR05LN2ov?=
 =?utf-8?B?ZWRrdXcraU9WelR4a3BMUXNMSGp5WEZqbmVxMXJTVzNZRXpOQjZ2MUR5OTV0?=
 =?utf-8?B?YjlXUEpoQlFiL25aTmlQclByVi9ZUFJHMkp0Q0VZV0dXOS9QcUQ1YTdyamQz?=
 =?utf-8?B?Q3VIejM3cXZHZnRDOXpQQVlDRVhuL0hhNE5pVWo2djV5V3h4L1luQ3VGSWRU?=
 =?utf-8?B?S1RGTVo0N08xUnFzZmxUb3p5RnYzcWVzcUt1NkNNU3NRazZleEZodkVuQzNs?=
 =?utf-8?B?blJUKy9ZYXo3bDJkQ2hxaU9vM0dhWFYxQ2JpZjlmL2pBRzRJMDgwMytiNDB2?=
 =?utf-8?B?NWdzeEh3YXpYdXVobjFvblhQdjV4cy9ucVd3b09ZaXdxTDdtYXpvMlhaOVp6?=
 =?utf-8?B?Sk1lVFZUUVlLT0p0YTd5ZVZ2bG5jYytCelI4azkrV3VNUGpSQ01qSEs5MXlI?=
 =?utf-8?B?c29qOWVkQjRVNndOM3lIK2kzTkFpaXRkYkp2elZTdTB3eHJUVG1pQ0VRbmh0?=
 =?utf-8?B?cENHUHROa2FkZGJ1azk3Z2xCdkM3Z2xaSHlPRmIwTzhuS3VucWdmVGlZdkRo?=
 =?utf-8?B?NE9neHJpYzJ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3NuWUJFZEQ1cG5QZURyTUNNWkdWdW5nd0ZwY0pQVXpiRUlKZW8vYnRnQkw2?=
 =?utf-8?B?RmhVUm5zWVNTT0hORVdEOWlESlU2QmtQOUJCVzd6Um5qcmNXQjFRTFEyazk5?=
 =?utf-8?B?dzgzQTk0bHlSU3FWMUxWNUU5Rys0dUJucHUrenYxanFMZjdLeVVuY2JJL0FP?=
 =?utf-8?B?Z2ZjTkFNbktvNHdnZ2ZhQkJWeFlMYXZiWlJCQ1IrOXVhZ25XQ2pXV1RNdk1j?=
 =?utf-8?B?L0FTQkF4Tm9VeWdDcVlXN0szb2JqSnpVNWlzSUxaTUx5WU03MmNwOSswcjlr?=
 =?utf-8?B?dU1VNWRWaGRTTmdQanlNSVpXd0lSZEFzc2RNVG5PWERMUjI2eUlyUnlWV0Vt?=
 =?utf-8?B?dkVDRGVmRVRHekoyVjB6RWhDN05YNlQzTG00TFZ2eFdlb2tHMTl6dHpNZnox?=
 =?utf-8?B?VnBzTlAyTzFrWW8zQkcxcjJGZTZqNnUzdFoveGl0b2hPdy9MbUVtMHlFZk1t?=
 =?utf-8?B?eUJrYnc5aWJQVFJnUDVEVXp2czVSL3V5eWlXemhGak5JZXpURGtzTDdBTkdi?=
 =?utf-8?B?K2RhRGR5RzZyY3NLb2dIcEN5SzVEbVo0SjdEaHNRRW9LZm5HWkJ5SVZ0SndQ?=
 =?utf-8?B?S09xRHNmZHRDcjhVYVVNckdzWXpjL254ZnhpaHRpVU53SnBudzR5Q1ZWVFJT?=
 =?utf-8?B?Q0taSjVRQndod3NhN0p0bDd5NmFHdU95Z1FIYkwyc0lPTWlGNUFYUUc0NnFt?=
 =?utf-8?B?aFZwcEJBTXNsUnNWQ0Q2MDNOQmw2V3FRWkNScWRFb2szT3FBRmt5eDZXTjMx?=
 =?utf-8?B?MHprd0t0K0pkcm16OGMrSFJmZTlsNEJXSElNR0J2QnNLUG54U3NLNlVqQjI2?=
 =?utf-8?B?UmFkdjYxbUlJWXJsWFVtc2hCdE9JTXdOQ1k0TXh6eHh5YXhVbUtEM0tKdGtO?=
 =?utf-8?B?N0x4NnZxOVNPdEt4UkNXNUc4RXZXMzhkTG1FWDBjdnF6VGdTTlRsdnd6c3ZJ?=
 =?utf-8?B?WE0rQnZ0OGlxcVJDb1gyZmd2ZjVMb1BpMWxnS3Q0Q3E5Tmk0MEUvWmVtODdT?=
 =?utf-8?B?MVc1Mzg2OVJTRUk2N3J2dVBkN2pVOC9WT3prWW9MQjRGVkhMZzNBWnI0cHdy?=
 =?utf-8?B?eGVmMnVENTdKT0pDWTd0ZldrTWZzRlBOeVJoMVIyVU9KMkRlcDk3WkpjaUpn?=
 =?utf-8?B?dldlcGloZGNnOVdCbTY4MDY0OHJiNlRVSUIvT3hYbmVxcXcvVTlHMXRCdCtJ?=
 =?utf-8?B?ZTBQYzBkOHQ1QmE3elFaOFZDOTg4aW05UGhweWJ3K3d6Vm1tTW1pQVBRSlR0?=
 =?utf-8?B?T2N4cjdMWlM5eTVGWWlHSWgwSzNTbUExUk16NTUzY0szWFhRdXdRQXN6THhE?=
 =?utf-8?B?WW0xTGtZYTlPeVFUaHpvbUltbkpUdlJZZW9CSW05TnZSa3g4Z3l1ZGdTM2ho?=
 =?utf-8?B?UE4vMjNLakJvTnFFblFsVktOZm9GT2s0TTJOZm1OVHUzNkdCOFlLR1o0YTFY?=
 =?utf-8?B?TUM3cUNYeVpzaGRhcG5SOTh6c0swSXpjYXpoSU0welppVER4eWtWbE1RSzUy?=
 =?utf-8?B?T2JsRmYxWVE1c3J5c0NUREcva1EwbnpGc2EwTndTcHI4SWswRkl3RmFESG5q?=
 =?utf-8?B?YUZUWW5nNWdmYlBTTCtxRmlvRmN0aFhPQlo3aEdUMXFOekZLaEZSbElZS1hF?=
 =?utf-8?B?VklFdGtCdFRub2FIajhOQ0xlTG9JS00rN3ZGRG42cTFaTmRWUG9tVDZYVG81?=
 =?utf-8?B?a3E1SWRDVVVpck9qeWdQQ245bzBNb3hQcHRsaDFqM0xTclBwNGZlWUJqN0pv?=
 =?utf-8?B?VktSOFc0MGRFcGhlaXdEaUNQdWRwbTUydUNYL2o1M0F3cWJhQ2xUbHlmVGIy?=
 =?utf-8?B?eFpCNlRDN25laXd4dW5hcXdUTEFDK2tYWkN2TGg2MUpNdnIrcFFTY21HVU91?=
 =?utf-8?B?RnFwa0F0SE9iWE1tVWpUTk5WcjVCNEhqdjNwSWVqQkFFZDJzQUp0enEwMXhk?=
 =?utf-8?B?a3BqemFHcDRZZ0JwL3QvaVluMzJLdFNaSXV0SXYvY0JNNnNvNmxTWGJWbTVj?=
 =?utf-8?B?UnlhQWhhZm9HTDNsK05Hbm9vQU9jVHhQeCtzUDdPcXgvOXB6SVZkVHZrS0tT?=
 =?utf-8?B?bnF6QlhzMjlTa0pWWkhSNWdSSlIvNjJ1OUdQWHY0M3AzN2UxMnBWQi85UXNu?=
 =?utf-8?B?V3JkTlNVMjlLaXZTWndyaHMyOFFOemxQR2F6ZkV4NG53aUpLdno5UCtDbVpu?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d00c754d-e83b-4af3-ebce-08de268b4e0d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 10:14:48.7977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fszYUoyRZ5pN2zYRzMMhC03GjkofsG+p4kYOpxVF6To4Z5OcU8sAKWwtSS+m2jseYRpUYcteNd9DjS4uSru9FlDRTXRSZ0Bv0mRBFZOZ1KQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5828
X-OriginatorOrg: intel.com

On Tue, Nov 18, 2025 at 08:01:52AM +0800, Jason Xing wrote:
> On Tue, Nov 18, 2025 at 12:05 AM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Sat, Nov 15, 2025 at 07:46:40AM +0800, Jason Xing wrote:
> > > On Fri, Nov 14, 2025 at 11:53 PM Maciej Fijalkowski
> > > <maciej.fijalkowski@intel.com> wrote:
> > > >
> > > > On Tue, Nov 11, 2025 at 10:02:58PM +0800, Jason Xing wrote:
> > > > > Hi Magnus,
> > > > >
> > > > > On Tue, Nov 11, 2025 at 9:44 PM Magnus Karlsson
> > > > > <magnus.karlsson@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, 11 Nov 2025 at 14:06, Jason Xing <kerneljasonxing@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi Maciej,
> > > > > > >
> > > > > > > On Mon, Nov 3, 2025 at 11:00 PM Maciej Fijalkowski
> > > > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > > > >
> > > > > > > > On Sat, Nov 01, 2025 at 07:59:36AM +0800, Jason Xing wrote:
> > > > > > > > > On Fri, Oct 31, 2025 at 10:02 PM Maciej Fijalkowski
> > > > > > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Oct 31, 2025 at 05:32:30PM +0800, Jason Xing wrote:
> > > > > > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > > > > > >
> > > > > > > > > > > Before the commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> > > > > > > > > > > production"), there is one issue[1] which causes the wrong publish
> > > > > > > > > > > of descriptors in race condidtion. The above commit fixes the issue
> > > > > > > > > > > but adds more memory operations in the xmit hot path and interrupt
> > > > > > > > > > > context, which can cause side effect in performance.
> > > > > > > > > > >
> > > > > > > > > > > This patch tries to propose a new solution to fix the problem
> > > > > > > > > > > without manipulating the allocation and deallocation of memory. One
> > > > > > > > > > > of the key points is that I borrowed the idea from the above commit
> > > > > > > > > > > that postpones updating the ring->descs in xsk_destruct_skb()
> > > > > > > > > > > instead of in __xsk_generic_xmit().
> > > > > > > > > > >
> > > > > > > > > > > The core logics are as show below:
> > > > > > > > > > > 1. allocate a new local queue. Only its cached_prod member is used.
> > > > > > > > > > > 2. write the descriptors into the local queue in the xmit path. And
> > > > > > > > > > >    record the cached_prod as @start_addr that reflects the
> > > > > > > > > > >    start position of this queue so that later the skb can easily
> > > > > > > > > > >    find where its addrs are written in the destruction phase.
> > > > > > > > > > > 3. initialize the upper 24 bits of destructor_arg to store @start_addr
> > > > > > > > > > >    in xsk_skb_init_misc().
> > > > > > > > > > > 4. Initialize the lower 8 bits of destructor_arg to store how many
> > > > > > > > > > >    descriptors the skb owns in xsk_update_num_desc().
> > > > > > > > > > > 5. write the desc addr(s) from the @start_addr from the cached cq
> > > > > > > > > > >    one by one into the real cq in xsk_destruct_skb(). In turn sync
> > > > > > > > > > >    the global state of the cq.
> > > > > > > > > > >
> > > > > > > > > > > The format of destructor_arg is designed as:
> > > > > > > > > > >  ------------------------ --------
> > > > > > > > > > > |       start_addr       |  num   |
> > > > > > > > > > >  ------------------------ --------
> > > > > > > > > > > Using upper 24 bits is enough to keep the temporary descriptors. And
> > > > > > > > > > > it's also enough to use lower 8 bits to show the number of descriptors
> > > > > > > > > > > that one skb owns.
> > > > > > > > > > >
> > > > > > > > > > > [1]: https://lore.kernel.org/all/20250530095957.43248-1-e.kubanski@partner.samsung.com/
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > > > > > > ---
> > > > > > > > > > > I posted the series as an RFC because I'd like to hear more opinions on
> > > > > > > > > > > the current rought approach so that the fix[2] can be avoided and
> > > > > > > > > > > mitigate the impact of performance. This patch might have bugs because
> > > > > > > > > > > I decided to spend more time on it after we come to an agreement. Please
> > > > > > > > > > > review the overall concepts. Thanks!
> > > > > > > > > > >
> > > > > > > > > > > Maciej, could you share with me the way you tested jumbo frame? I used
> > > > > > > > > > > ./xdpsock -i enp2s0f1 -t -q 1 -S -s 9728 but the xdpsock utilizes the
> > > > > > > > > > > nic more than 90%, which means I cannot see the performance impact.
> > > > > > > > >
> > > > > > > > > Could you provide the command you used? Thanks :)
> > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > [2]:https://lore.kernel.org/all/20251030140355.4059-1-fmancera@suse.de/
> > > > > > > > > > > ---
> > > > > > > > > > >  include/net/xdp_sock.h      |   1 +
> > > > > > > > > > >  include/net/xsk_buff_pool.h |   1 +
> > > > > > > > > > >  net/xdp/xsk.c               | 104 ++++++++++++++++++++++++++++--------
> > > > > > > > > > >  net/xdp/xsk_buff_pool.c     |   1 +
> > > > > > > > > > >  4 files changed, 84 insertions(+), 23 deletions(-)
> > > > > > > > > >
> > > > > > > > > > (...)
> > > > > > > > > >
> > > > > > > > > > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > > > > > > > > > > index aa9788f20d0d..6e170107dec7 100644
> > > > > > > > > > > --- a/net/xdp/xsk_buff_pool.c
> > > > > > > > > > > +++ b/net/xdp/xsk_buff_pool.c
> > > > > > > > > > > @@ -99,6 +99,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
> > > > > > > > > > >
> > > > > > > > > > >       pool->fq = xs->fq_tmp;
> > > > > > > > > > >       pool->cq = xs->cq_tmp;
> > > > > > > > > > > +     pool->cached_cq = xs->cached_cq;
> > > > > > > > > >
> > > > > > > > > > Jason,
> > > > > > > > > >
> > > > > > > > > > pool can be shared between multiple sockets that bind to same <netdev,qid>
> > > > > > > > > > tuple. I believe here you're opening up for the very same issue Eryk
> > > > > > > > > > initially reported.
> > > > > > > > >
> > > > > > > > > Actually it shouldn't happen because the cached_cq is more of the
> > > > > > > > > temporary array that helps the skb store its start position. The
> > > > > > > > > cached_prod of cached_cq can only be increased, not decreased. In the
> > > > > > > > > skb destruction phase, only those skbs that go to the end of life need
> > > > > > > > > to sync its desc from cached_cq to cq. For some skbs that are released
> > > > > > > > > before the tx completion, we don't need to clear its record in
> > > > > > > > > cached_cq at all and cq remains untouched.
> > > > > > > > >
> > > > > > > > > To put it in a simple way, the patch you proposed uses kmem_cached*
> > > > > > > > > helpers to store the addr and write the addr into cq at the end of
> > > > > > > > > lifecycle while the current patch uses a pre-allocated memory to
> > > > > > > > > store. So it avoids the allocation and deallocation.
> > > > > > > > >
> > > > > > > > > Unless I'm missing something important. If so, I'm still convinced
> > > > > > > > > this temporary queue can solve the problem since essentially it's a
> > > > > > > > > better substitute for kmem cache to retain high performance.
> > > >
> > > > Back after health issues!
> > >
> > > Hi Maciej,
> > >
> > > Hope you're fully recovered:)
> > >
> > > >
> > > > Jason, I am still not convinced about this solution.
> > > >
> > > > In shared pool setups, the temp cq will also be shared, which means that
> > > > two parallel processes can produce addresses onto temp cq and therefore
> > > > expose address to a socket that it does not belong to. In order to make
> > > > this work you would have to know upfront the descriptor count of given
> > > > frame and reserve this during processing the first descriptor.
> > > >
> > > > socket 0                        socket 1
> > > > prod addr 0xAA
> > > > prod addr 0xBB
> > > >                                 prod addr 0xDD
> > > > prod addr 0xCC
> > > >                                 prod addr 0xEE
> > > >
> > > > socket 0 calls skb destructor with num desc == 3, placing 0xDD onto cq
> > > > which has not been sent yet, therefore potentially corrupting it.
> > >
> > > Thanks for spotting this case!
> > >
> > > Yes, it can happen, so let's turn into a per-xsk granularity? If each
> > > xsk has its own temp queue, then the problem would disappear and good
> > > news is that we don't need extra locks like pool->cq_lock to prevent
> > > multiple parallel xsks accessing the temp queue.
> >
> > Sure, when you're confident this is working solution then you can post it.
> > But from my POV we should go with Fernando's patch and then you can send
> > patches to bpf-next as improvements. There are people out there with
> > broken xsk waiting for a fix.
> 
> Fine, I will officially post it on the next branch. But I think at
> that time, I have to revert both patches (your and Fernando's
> patches)? Will his patch be applied to the stable branch only so that
> I can make it on the next branch?

Give it some time and let Fernando repost patch and then after applying
all the backport machinery will kick in. I suppose after bpf->bpf-next
merge you could step in and in the meantime I assume you've got plenty of
stuff to work on. My point here is we already hesitated too much in this
matter IMHO.

> 
> >
> > >
> > > Hope you can agree with this method. It borrows your idea and then
> > > only uses a _pre-allocated buffer_ to replace kmem_cache_alloc() in
> > > the hot path. This solution will direct us more to a high performance
> > > direction. IMHO, I‘d rather not see any degradation in performance
> > > because of some issues.
> >
> > I have to disagree here even though my work was around perf improvements
> > in the past. Code has to be correct and we have to respect bug reports. So
> > clarity and correctness comes before performance. If we silently accept
> > some breakage then in the future nothing would spot syzbot from preparing
> > a bug reproducer. Addressing this consumes developer's/maintainer's time.
> 
> No no no, I meant we're all striving for high performance direction
> under the condition all the bugs are addressed. So the current series
> surely brings more complexity but it can be good in the long run. Of
> course, I know what you meant here :)
> 
> Thanks,
> Jason
> 

