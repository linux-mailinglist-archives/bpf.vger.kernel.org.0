Return-Path: <bpf+bounces-48012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF028A03283
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 23:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3B01886291
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 22:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DA91E00AB;
	Mon,  6 Jan 2025 22:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JipTApXA"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C534A04;
	Mon,  6 Jan 2025 22:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736201919; cv=fail; b=r+RH56daoyg9uz/g3b/D49sYvCeacg2/3H3y3YAltY5ULDiKUSbsx819+afmK/s8uG0p/L52nbegeie7/D+MBHX9lk6/AbRv2IKFSKC8vB4vH2p/WKKW5aiThQDNHP+Yj8OQ9+NSgL/51AdJ45mi7uxBoFaa7ryT07TyjKdiE+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736201919; c=relaxed/simple;
	bh=unXHBr+dWJ6uQl0YzJwl3JsG1YR6o9/uCU1TC0VWbNo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SBGJqQ9N7uOVqADU2/fO3ZLTHsDixpwjpCCHJTgtXUVetEoSIFdoirfvE9jjxo8yzge7tXcClaECDgAWgDA4mb0V1D2XMN8JAAqFtFuA0oVxA6udOQQB+ZXzHY/YmwlnkSZ9tX+UqGGUp1nclPqEXSP/sngk9J/4alOripzyZc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JipTApXA; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736201917; x=1767737917;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=unXHBr+dWJ6uQl0YzJwl3JsG1YR6o9/uCU1TC0VWbNo=;
  b=JipTApXAOoEcHCa54wVRb1t3tuSKe7zyC428Bm5VKWPASa8T7PleM2aV
   yXiCKLx7RRtR0xnVmrMa5iOSm7L6ZQuJSjJ9C+ec7c3PTvqtOLLNZk0Pl
   JkgRvPIdPI22H2yt0bI98nDWTdGGT8KxRIfezseEnU8WuyLsGc182Ayjg
   N4ktar36iKKhhCfqwZoXNoA3l1yfwF//+VSf/wYwhjdixLNyhoqDxUTXW
   /e4zrXBw2Ll8M+AWCGLNJs5WCx7XQv4Z9Z1rrfNlfvBAYbdaRX46Mi3Gw
   AHgiRVLSznVPSeNw5DPy2yQ2E4HYzwNlVBNT5btVDhOVyBvoXYbxSfxOe
   w==;
X-CSE-ConnectionGUID: bVz6SdSzROmQPDvE2DYnpQ==
X-CSE-MsgGUID: rV/p9PAmSYyDH/NoDDzLGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="36060698"
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="36060698"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 14:18:25 -0800
X-CSE-ConnectionGUID: S61gEqdtRtaL6gdkCojYcA==
X-CSE-MsgGUID: ygV5Q3FKSMW0VD5Y4WK0Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107187484"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Jan 2025 14:18:24 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 6 Jan 2025 14:18:23 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 6 Jan 2025 14:18:23 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 6 Jan 2025 14:18:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYixzeDaK99j96XQDWeTSozwMrFxu4OQdKpstalz4aKgv0131EVGfaRiIrYzFo5/jZ89oyast4a8KLnorH2MNvMCVCL9rfABMTb5dT/BqYV318TqZX0sMAXsMqr8ErfvjlhUyQ3W6gwVtO/vSCGjSfX2k2IO3yXXKw+5bsjOWOvbGtYSD0PBBD3w1xBlSJ1C++rgRQm/CpsDMWI9fQjuO/7QTnA3x/tr497xBfUwM9FMJPFXCM/SHgqftTnOGfYkC7jwaWezhtT3RVoaZ32sAP4Tdy8v/QrJ9C/+wUR9BqsbSUt8jCrqe9BWChET2RCqLV888H2duIzwkHKy4GIRaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWrbM6ZCG8tiZS4uc960t3hjv7pgHCreU91mzAN36AI=;
 b=SK9GkaWMyEAzuhzpLIoUT8Kad8TJ6P61lmwI1SPHZ3Essvz6eVWD5Fz5LFdzWCXUxLIEFu0hW4d2PX7XJ/QKU6pnJntaLD63mBXlZtF/vIhhwrxF/SxuN11XDaV7czWYMgiPLgmjxTJ05KrlxnSzd9en5/slY8LwdajkBkUARg/XPSdDUcVkL2KwGBG4TQw4MV+fuz1yeLKttvaJoC+Rg1gLY2mPbgjgdFNJD7Q3VdYZ1l4BtpNzPb0rVIPGPeFsZVzPU8go0zZjHsUUmlGRO7az6log9V7r4BD5sKQ0XDtJLWQH8vFFVyMUdC8IzUokteyuyWbgLyf+f3mGtkOZLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CYYPR11MB8330.namprd11.prod.outlook.com (2603:10b6:930:b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 22:18:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 22:18:03 +0000
Date: Mon, 6 Jan 2025 14:18:01 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Song Liu via Lsf-pc <lsf-pc@lists.linux-foundation.org>, Vishnu ks
	<ksvishnu56@gmail.com>
CC: <hch@infradead.org>, <yanjun.zhu@linux.dev>,
	<lsf-pc@lists.linux-foundation.org>, <linux-block@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-nvme@lists.infradead.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints
 for Next-Generation Backup Systems
Message-ID: <677c56994576b_f58f29445@dwillia2-xfh.jf.intel.com.notmuch>
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
 <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
 <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
 <CAPhsuW6W=08Vf=W6GZ9DCzwu4wq_AgNOayo50vxvqFMr9CcDcg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6W=08Vf=W6GZ9DCzwu4wq_AgNOayo50vxvqFMr9CcDcg@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:303:6b::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CYYPR11MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: a289a3b1-6f23-4444-887e-08dd2e9ffd03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UE5BNVBxSkF3VG9rZjN3TGVnRE9OQ3dsV05BWnZaNXd3ODdqVS9RVlluN1hv?=
 =?utf-8?B?UXB6eVRGS3lxVDRKUXhVUVJMQnYwN0pvdHM0RTBLU3JNZGRjSXZuaEsrWlRx?=
 =?utf-8?B?emR6L21iZDlJRVpocWFHNlZQVS8vVmVYdXVOYm85YmlMeUhXZGJ3bEN3UCtR?=
 =?utf-8?B?dDJPUGUyUm9sN2txcjRocXJqT1ArdGt6ZE1JeDhvdW5pc3RKdWJaNjBubmRF?=
 =?utf-8?B?eXF6aU9nMEthcTZVZE4yVTZYbzZMc3ZXdWJXOTBSczAreUNRNUVOOTJLdXpF?=
 =?utf-8?B?Tkd4TUZUWGg5ckdZVEpuR0g0VG9HTWo4Zlk0Tk5GZGJZUGhUdDZNOVVrSjRv?=
 =?utf-8?B?cmkxc3FNc2V4WXdiNjhHUXhURjZDd2dSVnpIMERTbzFCWExta3owTUdNcmRK?=
 =?utf-8?B?M2cvQ2lrUGhlTHdhblUyeDRQMnB6WTkxcXhWczI5UTJUSytJQXJzNktVRDZX?=
 =?utf-8?B?TkNCWjZxMm4rUVA1RUhjQllXYjVaOW5ZRStCNnlyMnRzZnpBV0YrU2NxVU9q?=
 =?utf-8?B?UEdVcFVWNW81OW5LRDR2bFl1L0dBWDNDMk1xU0ZaRHluUFdmQkkyZEdmOVBF?=
 =?utf-8?B?Sm85K3pySGxKNHoxRTNVTHJucjh0dCszUXJGbS9RSVB4UEZwN0hZcWdObytC?=
 =?utf-8?B?YmZjd3VOL0lRb0VyOU90VzNoOFd3N3hRcjRLQW5nUkVxdXRxQ0dlK0gwM3lm?=
 =?utf-8?B?OG9wcGtiV0REZC9TeUpNUFdrTXFTWUxIOG0rcExMWlFZaVdZMnlYT0FwSjF5?=
 =?utf-8?B?V0RXRkJrN1NCcTNKVGp5TDI4NFR0RmpMLzg2ODk5QldYS1JnQ1l0RDlwYVJF?=
 =?utf-8?B?dm9ldjc2MHhKNTFMYWM1RlB3bk9ibGlUbjZMNzdLQTZjeFN5K3owQUhPM2Nr?=
 =?utf-8?B?UXFLSVBocnJSRVYwK3kzL0NKMnhlZGJFYnpZN2xrSGw4ZUcyME1xYjFQSkEx?=
 =?utf-8?B?ZDFnUVBXV0lBZ2kwQjBGZTV0aDNtNGY0dytMTndLRUJnTGRXM3MrbFNPMjlu?=
 =?utf-8?B?dEJ1Rmc1djNtdGNPNVd2MU1SeEVEOVNrbmI1WlZqWmNOaXcvMS9BMHAxRVN3?=
 =?utf-8?B?RmpsYWgydDlTd1hxYURuTkZwaFp6U3NSbVhrV2lHMTVUVGVJUitVL3k4dXlF?=
 =?utf-8?B?VXB5VDNCYytVRzdWMmdiRXVLZlgvSXNCY3BWc2wzdkRlT1lwZFAwbmQ3aEFT?=
 =?utf-8?B?bWhMeGJISHZyUFZ3WTc3MFQ5aG93MFIrUkdDVUV0YlRZM2crUGRrRGhLdW8z?=
 =?utf-8?B?SnpoeHAvOTRGTU1CWFY1MUdHVUtoQUtWaklnTUtBdGlncW1FbHlySHg2c2ZT?=
 =?utf-8?B?UUhzUzU4cGZYaU1acG9HWFVDL0V0SkRxK0xydWF5VmFYTjRoV3Z2MFBxWjRi?=
 =?utf-8?B?YXJla2RrdW9QT3N0bE1lT1cyZFBkQnJGNmcwNEQ2YUtVd3ZyMzJVOUsweFIy?=
 =?utf-8?B?cmt6SVVoQ21HNmFDTzFiVU9GclJ5Ri9PR1JiSEVkT0dOekJjUi9TNCtmb2hy?=
 =?utf-8?B?YmNoZzVjRE1sUmlnS3lFSERSNUx5Q0tlVU1OcGJWQ3d1VGhXSWo1SU5rVURN?=
 =?utf-8?B?clBPdXZMKzlCaHpRdWlKQmNYa2JlcEdBbDdrYnpGQnNwc1hvTHhRNEZBWk9m?=
 =?utf-8?B?SjJOK2RXUXZxa3ZiYmhjSnc5TEUyNXRSb29ObnZLZXFSRVh1UXl0WUxOYXBz?=
 =?utf-8?B?dG45b0d6RERiSkszdXlnczdnZElpZllMQ290ZTIyd0pUdzhQckJjVk9xa1F0?=
 =?utf-8?B?d1FyQlpHTWJTMEJCSkRJdnFkeDRQS1NvMTcyaDcxcUYxTlhWeDFzYy9oYTZK?=
 =?utf-8?B?WVFidjRlU1p4SDlycUk2SXVseW50b0Z1eUtRS254VTBOaU1yVzNxUWZCY05m?=
 =?utf-8?B?NWpjcGdPUGZvT3U5VDZ0a0xodlRyUVJPYW10ZE5KOGtGNEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFVkNkwyV0RpMVBUNWwvK1IzTlRnTkZTMXZGUnJTdDEzVm9RYXFONkhQS3oz?=
 =?utf-8?B?ZXNpclczZ01EditnK1k2OXlyTy9DVkh2WDErK1l3d1QydjBNSTlsTkxXaFc3?=
 =?utf-8?B?aVVyOEl0aXorVURyMFVZVGs1UkVYT0pQYkttRUgzOVdDQ1F6SE1KcHBxZy9z?=
 =?utf-8?B?VGV3cDFNWElqdXFOeFQ1ZXZKNmJrMExQTTBlazlDVmdpb0JCd3JHSGhLRjBa?=
 =?utf-8?B?ekVzVjhNUmNOWE1RekpRTVREdDBBQkFhcHhCby91M1JDaGE1MGo5MG02SE9a?=
 =?utf-8?B?MTVqem5uaGl6YlB3aXIwalI2d1o5dXNhVTVvZW5ZZUMzNUVTWW9MNTZIL3c3?=
 =?utf-8?B?RUtJaTM3RzVTRjF1d09EbzlobVVRUFJXYURYU3FGRTBjL3Z6ZFh2by9ONVZG?=
 =?utf-8?B?cGFmVEtwOHIyb2h6VGo0WWtndjRXRVEzZUtXTnFsY1B0dmQ1OVlETGlvSmp0?=
 =?utf-8?B?SHpXK3pWRHh2RDZEeEsvcmhnYXFvMDZuSkFtVk1xQVJmUkFFTTQyWFUxRzlM?=
 =?utf-8?B?NkVHYjFMUDluaVFSYVAwbmUzZnRxdDZ5R0NXMUVJT09vMzduTkZRbVFSMTY2?=
 =?utf-8?B?ZENWbSt1SlEreW5QbUtKZG9EaFpieUdlakFNeUM1LzAydFBTRGZucG55WnAx?=
 =?utf-8?B?SW9GdCtPUkUzVzZWRWx1UmpFZGh2YlZBZUY3SVhiRU9GOW1kMHZ5Q1U0NGZz?=
 =?utf-8?B?N1p0SWkwWDlFbXlINHlKL2xKVXZPRzVaVHVLTXpjSG5hWGc0T211eTd3K3JB?=
 =?utf-8?B?S3N1blNoYTZiYlJFcVNkSWZMeTIrNXZmN3ZLVUtybk9HQ0g5SDljVkFkMEpq?=
 =?utf-8?B?Y09qTWpTdWw0NlQvTnFrRERZVG93am12NDdycFNIeVZMaE5SdTFwdWJ4Ukky?=
 =?utf-8?B?UjNtazhoQ2ZKMGp4Q2c2cG1HTVNiQ2xScGdQSEk5MGllMWVleGRYR096a0dE?=
 =?utf-8?B?R3ZRREV5MGZERklEZ0JrNU40elhHMGMyNmhoT0swdktadzQ1MFpRbk5BRzVE?=
 =?utf-8?B?eHJUcFd4SWlsT2hqSDBnamNHOHZMODFJNGJCU1FnVzJlMVJsazgvNWpTMDV5?=
 =?utf-8?B?MC9BQUN6Z1Y0d0ZkVk9CVlFUMUtRdHM4THlnRlBKSmFJL25uTWlSdXZObUJU?=
 =?utf-8?B?ODd6elkzYTVoNVB3VjVhQjZCS1BFNlRycDZWUnU3dXJJUW95eHBnWDdCQmsz?=
 =?utf-8?B?dXBUeXdNeldWUVZwTkJKY2ZYdTc3ZER4SGR3K2JKS2xKRGtuWDQ5ZTZFaFBB?=
 =?utf-8?B?cFpDRUxHSVFsQ0NIQVZqenNGUXZrRFV0SDVQZk12bzFFdUprK2NpSTlheGFG?=
 =?utf-8?B?N3lIbUE4U1VPdW9qZW5vZEtNTys3Yk1WcnhHdHRqWGM5Vzd1QXd4Q1NPOU1E?=
 =?utf-8?B?NEdzTUZNaXJwc0lIU2VCNHh5QVVYR1oxak1hcUwvcEs1RkVuOC96UFJtU043?=
 =?utf-8?B?RG9oMm4vekNkLy9keTBRajVZeTg0RDVDWVcwdE5EYnF5ZDhyZzRScWd2cUVY?=
 =?utf-8?B?QWpKZ2NSbVZDYWt0YWc0emtJVUMzbU90TXo2ei9ib0xGdW9Sayt6RlZaSHhH?=
 =?utf-8?B?Qm5FV29DQ2kvVlIwWmRSNXd6ZkdBd2FxV01vd3gxK200Q0xPQ29QN2JxeVd6?=
 =?utf-8?B?ODVOZTlGa0Z3Tjd6Tm1UMFJ0YXNLUEN4cGRZRVdTQTBvWSt1TzVacnZIMnBE?=
 =?utf-8?B?dkZMWlFwTlZtTG81c1gvZStEMTJPSzExWG1LMmYvaVk1UDZSL0w5WTNpSW1w?=
 =?utf-8?B?TTd0WGw5TmdXc2VNeU1SWVJ4VGgxcjVBZGZLNFFNWXBPTnVpNDNGYk1NbEJZ?=
 =?utf-8?B?TGF3UXR1WkNZa1lFT3BDM0dCbm1xb0RUOXUvaXFNNkhpU0lXcEVZM0ZQRXp5?=
 =?utf-8?B?RXNLcWgvV29XK1NHME1YOEFlQ1NRS1lQVERGenF4eHV0ZFZ6SjZjRGFmUU9E?=
 =?utf-8?B?bytwTDJWM09VVkUxQVNUZ0lCSHc2NW1HaWM4MlBYWjdDRXIycUpJL3d4bnBJ?=
 =?utf-8?B?dWpobzhmdGVTT1FqcE5YaXUyZlVJNlVsRHJkU003UzNZeUtJWldrck96N3VJ?=
 =?utf-8?B?RjNFbC92dFR1Q1FNV05rU2dRWUZrWDM1YkVYSFdETlp3VTRwZG5NRFo5K29n?=
 =?utf-8?B?SndRMWpMLzJGS1RuUzU4QVJIa3Y4YU0zYVZVWXdhVWRKWU41SFRrQS9xZjAy?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a289a3b1-6f23-4444-887e-08dd2e9ffd03
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 22:18:03.7366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XoIvOo6dCBkQsLTY4U853epFO45ECAe3tXk31JQ2afcSCxeG0U3r/EMVap407tWbgzERcUWvfSX+03UjvPGYSkbAkV6/JMU2K2I7xy47T8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8330
X-OriginatorOrg: intel.com

Song Liu via Lsf-pc wrote:
> On Sat, Jan 4, 2025 at 9:52 AM Vishnu ks <ksvishnu56@gmail.com> wrote:
> >
> [...]
> >
> > @Song: Our approach fundamentally differs from md/raid in several ways:
> >
> > 1. Network-based vs Local:
> >    - Our system operates over network, allowing replication across
> > geographically distributed systems
> >    - md/raid works only with locally attached storage devices
> 
> md-cluster (https://docs.kernel.org/driver-api/md/md-cluster.html)
> does support RAID in a cluster.

Also,

https://docs.kernel.org/admin-guide/blockdev/drbd/index.html

