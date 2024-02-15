Return-Path: <bpf+bounces-22087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C3B85679C
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 16:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576581F220E0
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 15:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8666133435;
	Thu, 15 Feb 2024 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cYy1dgdq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C6D13248B;
	Thu, 15 Feb 2024 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011015; cv=fail; b=UtnyxcdwTGHB/LB4fd5Br59MlM8546g+hMEmwOMZoP3kwbCuDvUuzwKwI6KhiLJKC07e3ZlA5TC6XWm0883HvxZ3NFXqGQhwtjx6cbKcwvwcICczohXhy3iajUHH87z2DJq8rhyAeugXOEflKHG+L1f6nzd9xhmF7TYI96gPgq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011015; c=relaxed/simple;
	bh=4DlrJPiLbk2BC43TEac0ePi4FkEks+NbTXvuqvfrcgo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H9xsigQKIvBMUsZgfAaM1T5vTX+FdBR7tHsbDryY9Kp1lI6Cztu+MLcreMSuOvrS1ogKQJ6Ml9bQR/NmBJDecm/x1GmilUZmYH+lrLMQFqN/MHjpm+eZJ4p/xtX0RrMvOX272j1BsARiU0rbzlCEnkut1pamX6Ij0DpaB33xcSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cYy1dgdq; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708011013; x=1739547013;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4DlrJPiLbk2BC43TEac0ePi4FkEks+NbTXvuqvfrcgo=;
  b=cYy1dgdqg0uf8s253tQRe+e13UhrbTXANPZz3aGyEUJAm5sUpRjmNUcs
   as4L07gqeFO1ECb/x++6NhNpMOgmiEsweXrmr1oKkrp1qily4Fq6daDb1
   8fQY3Ue/hT//3I+zyuTqwoXXcD19q1WdP6IPDHJFOe1uvvaUPZzafj3L/
   x3fkcVTBocOITWmkKG98a+jToOLjVwGKTAkMlUXppRX3U3JrqlzBHm2Wl
   p9Ej2RgyZNCSAbvz7cIUsbME1dvvLOsn4vMFPO+piUAaXUwCu6KDY3k7S
   u/GZY6aRcAgoqHxUuC0lj6shwDT18Bm1MmcqSZeBAP45lUZsxWGFmx5s6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1978402"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="1978402"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 07:30:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="8255603"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Feb 2024 07:30:12 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 07:30:11 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 07:30:11 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 07:30:11 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Feb 2024 07:30:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hU6xz2xqCMLM9gMCv0Xe0Euy6bcob8ujuPFulJ8QUbiYLOxDfVr5zlvxmTJu3Q4OkVyorneJ3DLYVmrATYqMyqNz8XcfLtdZwLhffqg9XCNs8N7FTGJ1C8OzwHrY3uYRF2Zzwf6YI9gDFq6183mzhc74p8BWQ+LyOf65JIZ9GSsG4fsXNgJ2uEYBCuozq1XDutCdL0lbhhXGBZUhki56YLZ16mnFmF1RYXHDvsPFwXH2l5NRGVdgOxYabu155sv+YQnWgaAnyLDLB7UxU1kLrfHLC+0llEwBjwOUNN6+qYoH7lOR7BpeVyKiUy+qHfuv65ckWDWh8LfKW+4Md9o2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbWIeKuEWMK2ahkK+1dlh2jiEbhlbGvvloplEilpSw4=;
 b=LN4sXwUvDNfzfw+Np+hpfNa2m0DLqjdB8/JTyOTIzrQ0fiSms2dQV/bXW5Xti/kxiPoZAohfEXc7oB6uZlT8j/I3Ey8/tiJU3oQDSJwuDZYpvU0F1pVyRAdffVCj0/mlleUdgEJ6lokj5+pl/DyiUAp0YmzoFNgL2EC8BDGNHQaHm0+6v3VlQmIztyuRpPQ19AfSd4EZoh1eTmHfsRkY7E+U5YW+SpxwAXlVbAMRGD4fCe4Ub182TCahRWdQe9pGmT7DB8Ggw9ekSfHuosA+9il973I2FzAR1Z3uRqkbnhjXePAAef2NfNQp5IIi7tiODCcS1djU2rrVdFnKU11JoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB4895.namprd11.prod.outlook.com (2603:10b6:a03:2de::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.30; Thu, 15 Feb
 2024 15:30:09 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::c806:4ac2:939:3f6]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::c806:4ac2:939:3f6%6]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 15:30:09 +0000
Message-ID: <4a1ef449-5189-4788-ae51-3d1c4a09d3a2@intel.com>
Date: Thu, 15 Feb 2024 16:30:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] Change BPF_TEST_RUN use the system page pool
 for live XDP frames
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20240215132634.474055-1-toke@redhat.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20240215132634.474055-1-toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::7) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: b2511fca-86c2-4a43-e46b-08dc2e3afe7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TljQs0gYSlZf13IcWzqL3seX2y/PLZVT9XZthE7AmLMpOzqxjGiQbmkoytD1E5qbCt42+jme1fRLZh0OYxgoKG2aL/xHzPVdWuCfePBgA81jCHEOjAGAAUJ8Es74W++TmJTeiGbzE1lKxe+/xqKFYXqY0kyN5BwhmkJmKtaXHyA6dwoWOnVCMbf297+MzQejU9RYprS31g5v9f+mlVf4jQMpGRTLOp+OV2lT2s7rmkJOeZrOeBpTg7iqCiIHbbK4nDZgi+oZNlfa10JWfh+E/AbRvFp5d7jo+taLoXxBMgPl51tVrrQSyOblll05HfbwPURDP/c7+O/5Ynf6tPlMtxnu6KxIaBVZMyjfpXdUjSLoklOyJbENpbgLts5aUYCBzwi6+kNBg1d2WxdczPFRhcsXXdAHQt4rUhKw2P4NCXxf4QZGNV+b6RdjOHfb1Ux0SL8EuslJMSv0/evLCnFg3IefP/C8RGlvUCQCAcT1kuDYAcBovexO3QzuPLDlO/epoB64+/XNyFQ+t67ff2VtRTb27FzteVB8soF4HZsAfH6SpnO19qQtchKOa5MUj3L/PiPfNxZhWUC3o8FP27cLzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(36756003)(86362001)(31696002)(31686004)(4326008)(6916009)(8676002)(82960400001)(8936002)(66476007)(66556008)(66946007)(5660300002)(7416002)(83380400001)(38100700002)(2906002)(41300700001)(6666004)(316002)(54906003)(26005)(2616005)(6506007)(966005)(6512007)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWlZc1d0WXJrRFVnOUN6ejFKRy9xeGNaNG9mWGRmUnJTcUd6bFkvN1FHNTRT?=
 =?utf-8?B?ZmlDMDJwWmxmSCs4TDJ1WnozTDQyUGFPZXdSOGZFZk03QlRPZVpPUlVOUXZm?=
 =?utf-8?B?cldOTUE2c2RuYURlUG53aHh3T2lZTVZtM0tJVEkwWVRuYVBsN0ZESGswY0Iw?=
 =?utf-8?B?ZVgyNGUySVJzYkFUNDlHVXNtZjNWMnRHQzd0eEpXdlI5bVgxRTZPc1RKNkdu?=
 =?utf-8?B?MW5LWXFuelM0VGd0bk1HWThUTnUrbmtpZklHbGZnSDV1R0RGMHR3Vit0d0ND?=
 =?utf-8?B?VlNFeDBsWis2ZVRNTHo4eFZya3MxWEQvMDN0NXByWkloUTlMRnhHb09yc0hl?=
 =?utf-8?B?YkNQcEE2bUN6SUg5Z2V4NmdEUjFpcU5MVjlRa0poNVNkYkdPNkprWnJkUFBk?=
 =?utf-8?B?QWczOGZFbG9KOVNZYXJoYXZEeER2T3Q3SmVFWnQ5eFNCSGpOUWtCU0o5VmJV?=
 =?utf-8?B?MGsrdTE1TmxBYXp0SUwxSGtrSWhocTBaRzVjRndRWWVjeUV0TUtPNm1tUXlp?=
 =?utf-8?B?TVFmV2luOTQ0djRyUjJqL3FTR1UzdVJTaG5jSnArNERORkdXT0ZQQmVTTVNw?=
 =?utf-8?B?OXdad2lZejhUdnU5dHEvUzdUalJYV2c2anY2OTRlU2RlS3c2NGwzN2xMakpR?=
 =?utf-8?B?RFVxczVzS280L0dKcjVWOTdDRTQyK3VwQk1qTVBKQ1pQVE1Tbi8xTjRSMnU5?=
 =?utf-8?B?QnlxVS8xRE5obGpOZytSS2tXaWVLZ0ZOQWxlUThPRi9rSDRGZVc0RFRRdTZa?=
 =?utf-8?B?dGtZNGFORmhLK0xZWVNQVFh5aEpQVUxremlMblZIVDZzRHlXNTVHNG1Qd2RW?=
 =?utf-8?B?SEpveWNFVFBibmxnZXBPeGloUzhoa2ZSdU5xdTh0N245WCtWNk9icTJtN0ZI?=
 =?utf-8?B?QWxqQ2RNZzhCWjNEOUpqUlhRNy9iMWJtejRzYzRUa2l0bVUxYTNBT04yOFI4?=
 =?utf-8?B?bnI0WGdFRm9EaTc4YjFHV2V1YUs3NkNqaWRaYzFvNGFQSlU2ZGcyMVNwZEtl?=
 =?utf-8?B?ZzNtVzRWeVFqTlZKa21mUENaclJyQUxSMlhLV25rUytrdWRua1JWUTVGNjNo?=
 =?utf-8?B?aGRuaW1BdjFJeUhCRmlVNkxEdVJGTUh6cVRhWTRNU0htTXFDTDlEWFROMkFD?=
 =?utf-8?B?aTRqbU9MWkpSOTcwVUtXMkJYVmg4Mk1kb2lvcDIvVVdIWUJOZFowNmpWWVVT?=
 =?utf-8?B?OGhQZE1ORjBkTmU2aTh5QUZJd3Z5M0FCbHR5Ri9reVhEV1k0djBvTnVGWDdu?=
 =?utf-8?B?elVjTmRtZ0VkVEcrMUdkZ2lzWmxObkxhamZobHVpazVvKy9UWGZibGh2MHVy?=
 =?utf-8?B?QjlZOTVuMSsvM2E4QUlYMzMvaTBpOXJ1L0YxVzV2dDJMcVVxdVVMaFFZZUNQ?=
 =?utf-8?B?aHpTS2owLzV0UWVtY3pPMUVENW4zUTNxT2xhNE5na3Myam1saW5yemxEczh5?=
 =?utf-8?B?SW5NT1dPWWh1WFFHQVRFb3ZGQ25WSTBId081MGM5Q1A5Nkh0eHoxK2ltaWJO?=
 =?utf-8?B?K2ZPSm9MRXRBWVYwQXRTdmlQekhQZTY0a2NaRVZ4WnJkTUw1cy9SR2FIdThF?=
 =?utf-8?B?eE9JaStQN2gwYVVpT2JmRGd1b0thenZZdVZxSCtpc2F5RjVmVnhQMkhtQVYr?=
 =?utf-8?B?V3dnOWc3ZE5mVTlBZ1JrODJQK0l4K0lIN3pLUHVtVUpYeU83cnB6RURkOWYr?=
 =?utf-8?B?eGFIVDlFRCtGcHFPRktteklPWkFRa0diMDBlbDBBWUV4dWtEVE9wWHA0b3dr?=
 =?utf-8?B?RlBZQlFqZmpqOUNaVHBkRG4zNVBzYUF0ZkpJcER6SXBvemdyNU1Rd0JtMXVZ?=
 =?utf-8?B?am50M3RoZU9qRFRhS0dXWFVYU0lYUENsS3BvZ2Z0L0xsKytTcm9lanpmRkk0?=
 =?utf-8?B?OWZNVis5dDNtQnBnaXp3TS9iRWZEamVTOHNzbWRJd2Q0ZmFLZ21vVEswZFVM?=
 =?utf-8?B?SW4ySWZsQXhhZHlKYXFHQWhDMGhUMnFHdjA3ajJKMzg2N05JWW1sZU5sdEY0?=
 =?utf-8?B?a3lYa1V1cGJDSGRzOTV0WTlEQ3pJejBJS3VQMVFJQlVnc1RCcGR6TVY3bC9S?=
 =?utf-8?B?SG5wUG96dnoyNU5Kd3I5d1lZc0RjZVhXdk5RMGNVRG5xbDRmTDVjd2VGcmJ1?=
 =?utf-8?B?MEFYaXBKYkh2cWMvb2grMzFaYkxQdUR4MzB3Nk90Rlo1YUxOVDJYMWwyNmhY?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2511fca-86c2-4a43-e46b-08dc2e3afe7b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 15:30:09.4920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPl8qe0+4cdKrwFXVYOigCiYbdo5HihK81AuVNQcBGK+uwyaZylXwT1bBmHf7FuBOLIxVA+a7W+kUY3oaMqS5dvR+kMKhQcaSUvqo26Or/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4895
X-OriginatorOrg: intel.com

From: Toke Høiland-Jørgensen <toke@redhat.com>
Date: Thu, 15 Feb 2024 14:26:29 +0100

> Now that we have a system-wide page pool, we can use that for the live
> frame mode of BPF_TEST_RUN (used by the XDP traffic generator), and
> avoid the cost of creating a separate page pool instance for each
> syscall invocation. See the individual patches for more details.

Tested xdp-trafficgen on my development tree[0], no regressions from the
net-next with my patch which increases live frames PP size.

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>

(with some cosmetics like[1])

> 
> Toke Høiland-Jørgensen (3):
>   net: Register system page pool as an XDP memory model
>   bpf: test_run: Use system page pool for XDP live frame mode
>   bpf: test_run: Fix cacheline alignment of live XDP frame data
>     structures
> 
>  include/linux/netdevice.h |   1 +
>  net/bpf/test_run.c        | 138 +++++++++++++++++++-------------------
>  net/core/dev.c            |  13 +++-
>  3 files changed, 81 insertions(+), 71 deletions(-)
> 

[0] https://github.com/alobakin/linux/commits/idpf-libie-new
[1] https://github.com/alobakin/linux/commit/62b4cb03486a

Thanks,
Olek

