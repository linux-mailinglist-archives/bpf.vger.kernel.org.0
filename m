Return-Path: <bpf+bounces-21963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A6E854839
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 12:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9196728856A
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 11:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FF019475;
	Wed, 14 Feb 2024 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IK7gHaPd"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4537818EB0
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707909925; cv=fail; b=OicHenIdl2KO0GOZ7dW6FiUd/BId24+CHIZiTizKbNMr3Q8yFb8KTDdsqkrrTfyNkL2QlsjZTi8CWd+AVL+SVB4SOk6cxQqQO2vc7wAwP+RSJ9Xt2LZuRQOPfn2STRc9tatVLYFCaOhR1O2RXXHmZdX2eBSsRyOprA4DnlmGeO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707909925; c=relaxed/simple;
	bh=UZz/IOjvz3q47duPhUykux/tyhF4jVJqdSZxSjX3i+o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eGgvk9iePhriW65DnhfnsitNvWeMTCcl2KXR9SVwRFGIVM/xleUgcHZfioPXhNafIQwHBPka0YEfXLUADOHUmMwGwMHkqaoeYgDpAKe+4HOdxo3e3t6u+xwIWWptALK1WTgxbXJO1JC94ovhmBZSgQ8m8LhqwpPRPqigkW5OcfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IK7gHaPd; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707909923; x=1739445923;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=UZz/IOjvz3q47duPhUykux/tyhF4jVJqdSZxSjX3i+o=;
  b=IK7gHaPdFDfF8mvDiI3qQCTskm07ziTFd6rgjUtZls2aCJXR1gsISTuB
   OT/R2hZcXudYmJZd9KabNAw65NXKwcVQIGckxM0cHVsZGzVMJxkUv7JEg
   56i32QkKwpPSeVbBSeZrqYaM+MOQ8R3oA8SNSNH0YdPa3mt+68kSOCatl
   Ih5RgafF/BYHyosDob9zI/+1JTo8o7w63Fyi89DCCjG8YANBMpBVbi92z
   IKX9Fzkxqo+ykhmW1X7X0kaNJgFV22zHvlX0VwvTtx6QnLTuOdOd3SmBs
   cMBTUxGZ04/n4J51RzMNhxSGjE3l+1+Qzq98uY1sbvL+3T4VUhQoaM53d
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1857201"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="1857201"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 03:25:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="33967111"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 03:25:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 03:25:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 03:25:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 03:25:19 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 03:25:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBPPPv23uZQLeYrOqw5FRllq79MvvOPRvEQf8aIdGqXwTaAeQjNiW0LtUjRa9j1hrvK00dUdvhk5EP2Bk47k/cdBUT7Tk33UAa8hVRyscuIAruj1SXsYWUZ7WpiSFjaDBOpZQRgXUuJF04x5CY9TUDDWjdjOdgto5WXDo3gwVuJ/sFOt7pxXeJKhsISuoqQ/A/lZDE6jIFTHzozqS/UHrEhYwjlcu9FfDOXzJYqx2IQPzM8VAV00AeSD+6NJXHZ8ugJs/5mHwsGrj9JbRAXfc8+f+87CaWK3snexSVdfrwuDDyxa8FMApBjtukHVFOZxcMhyVUHx8t5nlsMDJihc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnOctem82Zm5/L/p4bffFwNgmUqZ5bPIs2PZBJy/c+0=;
 b=Gx+RoObX5f/bDLoxduDqD226IEOXrWIqQCMxqN2Oezhhx4hc4lOqsLHVBCZGEuycsYBP07D1tvV8uPtltpG+kK5w6l/TeOWPvEraT3H8VkksjOmNGvgG6X2RTklza/3QXic0ZGHIEnS4zgQfXVLWuj7oArN7lLHMhodbaDfEWNMVXWygZPkFO6SqSRZQegl79jh3tElZ3n/hRBiNogqQOKbZof2oT/EjFQ9giZHA2okn6Q7st8fbyi85DpOVjLrO9NwOUbQLkZj/pOhhW5PLfy++swkWx0HXIDyuYYaTTHdSW4y5CXH0YOqyYfAHcb90YmPPJdFPnJh+c8nSJibbCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS7PR11MB6013.namprd11.prod.outlook.com (2603:10b6:8:70::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.26; Wed, 14 Feb 2024 11:25:17 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 11:25:17 +0000
Date: Wed, 14 Feb 2024 12:25:04 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Leon Hwang <hffilwlqm@gmail.com>
CC: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf
	<bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Jakub Sitnicki
	<jakub@cloudflare.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Hengqi Chen
	<hengqi.chen@gmail.com>, <kernel-patches-bot@fb.com>
Subject: Re: [PATCH bpf-next 2/4] bpf, x64: Fix tailcall hierarchy
Message-ID: <ZcyjENeiN1/7KyHl@boxer>
References: <20240104142226.87869-1-hffilwlqm@gmail.com>
 <20240104142226.87869-3-hffilwlqm@gmail.com>
 <CAADnVQJ1szry9P00wweVDu4d0AQoM_49qT-_ueirvggAiCZrpw@mail.gmail.com>
 <7af3f9c6-d25a-4ca5-9e15-c1699adcf7ab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7af3f9c6-d25a-4ca5-9e15-c1699adcf7ab@gmail.com>
X-ClientProxiedBy: FR4P281CA0376.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::19) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS7PR11MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ce309f6-0975-48f9-d17a-08dc2d4f9f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wj/aUVLiyyWF4YCV/TxBQA8ilsxTWu/suBpSoUVlRvRO/DZUyXEMKPHNzAojFIKmCgziAmZNuqzopV5aBtycz/TAPFCswTwoRi2/ksK6FEcE9JAP1zzAh3zQcjaDz7eTYiaPdr2rCJFW0QH5l+lCcmHdY6WUwR9aLGoMu4iVIoLhjmYk7I7F2Ig/NPioqGDPaG0+Je0lhbPWikicudgErrSUYmTLa7lD2lxgiaIK1/zkJi1YGvA2uRor1jF5fP3JKS8PnXQvHrYLS2MH+6Lte0yIfCPCQN6wxi/DlTehLWOJLiWE6dglt4+lONtBvjZO5FM6yMc0fh/Rjb74KWcuM8xY+LFfPw8W/ir4TCEFtMhB4DwiYr1ZiISs4a3Jgo+edxdw6faOhLc7/R4q/ZTKYJUpLTzVvgY6sa6QUdX0nXQvLLCg6DqeAfwr98FYjoBq2b2lRGWlbkOJltmrXwC42WuLprBOQmrIYytWv/xBEOEfyo9kl7js5Z9wx9ICcKBDtVdfueadzduEEYKT+bWyFJpugLp8u8cg+GJ4SEdUWxb+LV1YlgPTz8nhuDbC5F3h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(346002)(39860400002)(396003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(4326008)(8676002)(8936002)(44832011)(5660300002)(7416002)(33716001)(83380400001)(26005)(38100700002)(86362001)(82960400001)(316002)(6916009)(66476007)(66946007)(66556008)(54906003)(53546011)(6506007)(478600001)(6512007)(9686003)(6666004)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVNoMUlQRHc0MEtOTGd1QiswWDRaK0ZaWlg2ejQzNy8zUFZER0NQR204WTBL?=
 =?utf-8?B?cmpFU1Vvalp3cy9uN0dHZFZDcGJVNW5NY1l1amN0N3RkTi96c0pGcVNYc1Vj?=
 =?utf-8?B?UXNMcEtEWVZSNFZFa3hBblJKTnBhekZrUkNwd1FydlRrbVVIbkltSUNMeWly?=
 =?utf-8?B?S1FUd1NsZnBvZmw4MElNVXJUK2IySHpFWm9uRFNiVGkraUNhMmF2RWpNdDJt?=
 =?utf-8?B?bUsyZDJ3QWR1QlNuRDFlM2pjK0NXeUpJN2ZRWWZCbTFHVkxMK0ZWYkdKTzlD?=
 =?utf-8?B?a2tsNjFGSHA0RWpHUWZVZkw4TWNsVE01dWx3MFpCRVJKRUhEVjZrc0g5YXZF?=
 =?utf-8?B?RFJ1bkliYm1raGczZ3ptZnArOFRxb040Q2o4QStWd3BYRmduQ1FJdjk4RW1I?=
 =?utf-8?B?QTNvdTJMYlpYR0NBYklicFRyNGZ1ZytoN3lkbEpnYlpJaHV2STJmRmRJY3Ni?=
 =?utf-8?B?R2djdU5jNkdnOEFWVVlmdHd3YVBUdXQrQ2pvRFNCREZvK2M1czNXbk04Y044?=
 =?utf-8?B?MEJtQzJZYmoyTis0RjNIS3N1dXNxS0JSMUhCVmw0eWRrdUp3dXcyQmpna0dj?=
 =?utf-8?B?T1V6dHZUTUQwTDNJdU5xOThZMy9nbzVsM2lvbnZsTHdYQ1V0SXhldjl2NEFY?=
 =?utf-8?B?ZGhTL3hMR1JWNXIvTzV4UGowR0daV0xVK2cxK3NkWFBnaUFDdTdISXUrcC9Q?=
 =?utf-8?B?OFRDRmZ5OTl5bm9Kci9POVFaYkYycFhjb2p3WHNmMFdlZXJWL2J5VElkdzkx?=
 =?utf-8?B?Ukprb0xHc0o5SU9UODFCRXJoZE1haE5ReWVWVklBWHRCK3BKNlNueHlkWGlB?=
 =?utf-8?B?K2lwU0FrTnplbEVaWDJGcURUN3d0aGNnc1dBVmVrV2JtZmdFWml6QWdWZTRl?=
 =?utf-8?B?Z0tFU0d2a2NHcThXeE5oR2YvWENrcUo3TkJUS09oMmQrN2xIWmNrWTcxSEh3?=
 =?utf-8?B?OHkxckJQWm5hK2dMczFQVkFNenU0dzZnMVVkVkRjZmJJbGU5VVU0ckJOMjAy?=
 =?utf-8?B?VHFpNXRUZU9yRXFiNlVxalBpclV4MVEzdWEzVWJvVzk2VlZuL3FleDV2VTYv?=
 =?utf-8?B?U0tsNURRMFJleTg0SGhJL3p2NnZRNjIwWk1LWjNmUTY2ZHczUHZHcHlZVTVK?=
 =?utf-8?B?WURXaUxzeHVtdXdlalI1eVAxZ09DM202NlBFSEsxUTU4YjFjSGFrMmFkQ1NM?=
 =?utf-8?B?WGd2NjJGdlBxRGpKVjU1ekVsdUFkYmk0ZHV3NVliMnRaVFhqVjFTMDdIMjJp?=
 =?utf-8?B?VW41dmZ4aGNzc1NHY2p3aWVRdFk2MGRZTS9HMEIwR2FsSHZuaUV2c0xDZUgv?=
 =?utf-8?B?OFdqNm91T3owa1NlNUZoNzB2akFwaVlCMmk5MU4yY05rQ0RsdGsxSTkyVmQr?=
 =?utf-8?B?TkVWbmxFUUhVWXI4VUFrQ2MyM1B2dWhmWDZCcWRoUENtT2E1WnJJb20xOXdz?=
 =?utf-8?B?NHhaRVViKzFFWEtMMG12Mk1PNkFId1dkNmszSHk3bmlCakF0bHRxZFRZYlNK?=
 =?utf-8?B?MjJyOGs5YWlNNWg4NS8zTXBnMVhkaitrNmVzN2w1V2RseUtlb2x6YytqdEhH?=
 =?utf-8?B?NjNOMnY2dmxLTWxYMWhyZXE4Wko4Nm5MODViYTFYQkprRDJweUxDRGRZMzYz?=
 =?utf-8?B?NjZ2UVpkZGREQkdpSWFPZWVPZ1hyWWJLMDQ0eU9mUmR0Vmo0bDg1RGJZSk10?=
 =?utf-8?B?Z0xJZVNnaXh3TXJnaEM1ZWcxZ0l6OUNUYVk0RjE2dTd4RHpkbUNyZjRpQXVn?=
 =?utf-8?B?alJQOTYrdXZOQnAwU2JycG0vOWxyL3dmdEp5eVBzUzN0SzI1Z05nZjZFY2F0?=
 =?utf-8?B?MFBuYjFXV1FMZi9hc1diTjlHczR2VGdlMWVuMGUzMTFYUlh6N1N5NmlTdU5S?=
 =?utf-8?B?NEw0SEx6UGNoeTlCVmkrelRERlVxN2FRY3JiY3JLbFRxcmZ6YjVnYmNQQjN1?=
 =?utf-8?B?ZTB2VjRlMGgzWWtHTURpeTNKZUFJWFRQa1hhUStVYUZFeVYzbHlVYVVkaHY3?=
 =?utf-8?B?UnQwcUl5Q1BCY3hHZEVJendIUlJQRWZMd3kwN01Ecm1sZWpVSk83N3U5Mlhw?=
 =?utf-8?B?Ung4Z2pkeFhCSjA4d0RkR0xBcTlRZGVqNmhZY0JLYktXelFrbi82aTMvelBo?=
 =?utf-8?B?Q2VFVVJrSEZNUWc2bHc3R3d0ajhzL2U5SW5DWktwdWZjYmU5OWtROWNURGhX?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce309f6-0975-48f9-d17a-08dc2d4f9f23
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 11:25:17.6443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eVOb6lGbhjjcGVsSq4JIYaWotPoWPRKoGm0XKy4LejWGJluDpgi0nT5Y47MiMQWwvuI+NIKIFK5vyaEW34dWW8imM5A1cbivi2yVaKT+Pzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6013
X-OriginatorOrg: intel.com

On Wed, Feb 14, 2024 at 01:47:45PM +0800, Leon Hwang wrote:
> 
> 
> On 2024/1/5 12:15, Alexei Starovoitov wrote:
> > On Thu, Jan 4, 2024 at 6:23 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
> >>
> >>
> > 
> > Other alternatives?
> 
> I've finish the POC of an alternative, which passed all tailcall
> selftests including these tailcall hierarchy ones.
> 
> In this alternative, I use a new bpf_prog_run_ctx to wrap the original
> ctx and the tcc_ptr, then get the tcc_ptr and recover the original ctx
> in JIT.
> 
> Then, to avoid breaking runtime with tailcall on other arch, I add an
> arch-related check bpf_jit_supports_tail_call_cnt_ptr() to determin
> whether to use bpf_prog_run_ctx.
> 
> Here's the diff:

This is diff against your previous proposed solution, would be good to see
how it currently looks being put together (this diff on top of your
patch), would save us some effort to dig the patch up and include diff.

> 
>  diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 4065bdcc5b2a4..56cea2676863e 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -259,7 +259,7 @@ struct jit_context {
>  /* Number of bytes emit_patch() needs to generate instructions */
>  #define X86_PATCH_SIZE		5
>  /* Number of bytes that will be skipped on tailcall */
> -#define X86_TAIL_CALL_OFFSET	(22 + ENDBR_INSN_SIZE)
> +#define X86_TAIL_CALL_OFFSET	(16 + ENDBR_INSN_SIZE)
> 
>  static void push_r12(u8 **pprog)
>  {
> @@ -407,21 +407,19 @@ static void emit_prologue(u8 **pprog, u32
> stack_depth, bool ebpf_from_cbpf,
>  	emit_nops(&prog, X86_PATCH_SIZE);
>  	if (!ebpf_from_cbpf) {
>  		if (tail_call_reachable && !is_subprog) {
> -			/* When it's the entry of the whole tailcall context,
> -			 * zeroing rax means initialising tail_call_cnt.
> -			 */
> -			EMIT2(0x31, 0xC0);       /* xor eax, eax */
> -			EMIT1(0x50);             /* push rax */
> -			/* Make rax as ptr that points to tail_call_cnt. */
> -			EMIT3(0x48, 0x89, 0xE0); /* mov rax, rsp */
> -			EMIT1_off32(0xE8, 2);    /* call main prog */
> -			EMIT1(0x59);             /* pop rcx, get rid of tail_call_cnt */
> -			EMIT1(0xC3);             /* ret */
> +			/* Make rax as tcc_ptr. */
> +			EMIT4(0x48, 0x8B, 0x47, 0x08); /* mov rax, qword ptr [rdi + 8] */
>  		} else {
> -			/* Keep the same instruction size. */
> -			emit_nops(&prog, 13);
> +			/* Keep the same instruction layout. */
> +			emit_nops(&prog, 4);
>  		}
>  	}
> +	if (!is_subprog)
> +		/* Recover the original ctx. */
> +		EMIT3(0x48, 0x8B, 0x3F); /* mov rdi, qword ptr [rdi] */
> +	else
> +		/* Keep the same instruction layout. */
> +		emit_nops(&prog, 3);
>  	/* Exception callback receives FP as third parameter */
>  	if (is_exception_cb) {
>  		EMIT3(0x48, 0x89, 0xF4); /* mov rsp, rsi */
> @@ -3152,6 +3150,12 @@ bool bpf_jit_supports_subprog_tailcalls(void)
>  	return true;
>  }
> 
> +/* Indicate the JIT backend supports tail call count pointer in
> tailcall context. */
> +bool bpf_jit_supports_tail_call_cnt_ptr(void)
> +{
> +	return true;
> +}
> +
>  void bpf_jit_free(struct bpf_prog *prog)
>  {
>  	if (prog->jited) {
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7671530d6e4e0..fea4326c27d31 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1919,6 +1919,11 @@ int bpf_prog_array_copy(struct bpf_prog_array
> *old_array,
>  			u64 bpf_cookie,
>  			struct bpf_prog_array **new_array);
> 
> +struct bpf_prog_run_ctx {
> +	const void *ctx;
> +	u32 *tail_call_cnt;
> +};
> +
>  struct bpf_run_ctx {};
> 
>  struct bpf_cg_run_ctx {
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 68fb6c8142fec..c1c035c44b4ab 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -629,6 +629,10 @@ typedef unsigned int (*bpf_dispatcher_fn)(const
> void *ctx,
>  					  unsigned int (*bpf_func)(const void *,
>  								   const struct bpf_insn *));
> 
> +static __always_inline u32 __bpf_prog_run_dfunc(const struct bpf_prog
> *prog,
> +						const void *ctx,
> +						bpf_dispatcher_fn dfunc);
> +
>  static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
>  					  const void *ctx,
>  					  bpf_dispatcher_fn dfunc)
> @@ -641,14 +645,14 @@ static __always_inline u32 __bpf_prog_run(const
> struct bpf_prog *prog,
>  		u64 start = sched_clock();
>  		unsigned long flags;
> 
> -		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
> +		ret = __bpf_prog_run_dfunc(prog, ctx, dfunc);
>  		stats = this_cpu_ptr(prog->stats);
>  		flags = u64_stats_update_begin_irqsave(&stats->syncp);
>  		u64_stats_inc(&stats->cnt);
>  		u64_stats_add(&stats->nsecs, sched_clock() - start);
>  		u64_stats_update_end_irqrestore(&stats->syncp, flags);
>  	} else {
> -		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
> +		ret = __bpf_prog_run_dfunc(prog, ctx, dfunc);
>  	}
>  	return ret;
>  }
> @@ -952,12 +956,31 @@ struct bpf_prog *bpf_int_jit_compile(struct
> bpf_prog *prog);
>  void bpf_jit_compile(struct bpf_prog *prog);
>  bool bpf_jit_needs_zext(void);
>  bool bpf_jit_supports_subprog_tailcalls(void);
> +bool bpf_jit_supports_tail_call_cnt_ptr(void);
>  bool bpf_jit_supports_kfunc_call(void);
>  bool bpf_jit_supports_far_kfunc_call(void);
>  bool bpf_jit_supports_exceptions(void);
>  void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64
> sp, u64 bp), void *cookie);
>  bool bpf_helper_changes_pkt_data(void *func);
> 
> +static __always_inline u32 __bpf_prog_run_dfunc(const struct bpf_prog
> *prog,
> +						const void *ctx,
> +						bpf_dispatcher_fn dfunc)
> +{
> +	struct bpf_prog_run_ctx run_ctx = {};
> +	u32 ret, tcc = 0;
> +
> +	run_ctx.ctx = ctx;
> +	run_ctx.tail_call_cnt = &tcc;
> +
> +	if (bpf_jit_supports_tail_call_cnt_ptr() && prog->jited)
> +		ret = dfunc(&run_ctx, prog->insnsi, prog->bpf_func);
> +	else
> +		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
> +
> +	return ret;
> +}
> +
>  static inline bool bpf_dump_raw_ok(const struct cred *cred)
>  {
>  	/* Reconstruction of call-sites is dependent on kallsyms,
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ea6843be2616c..80b20e99456f0 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2915,6 +2915,15 @@ bool __weak bpf_jit_supports_subprog_tailcalls(void)
>  	return false;
>  }
> 
> +/* Return TRUE if the JIT backend supports tail call count pointer in
> tailcall
> + * context.
> + */
> +bool __weak bpf_jit_supports_tail_call_cnt_ptr(void)
> +{
> +	return false;
> +}
> +EXPORT_SYMBOL(bpf_jit_supports_tail_call_cnt_ptr);
> +
>  bool __weak bpf_jit_supports_kfunc_call(void)
>  {
>  	return false;
> 
> Why use EXPORT_SYMBOL here?
> 
> It's to avoid the building error.
> 
> ERROR: modpost: "bpf_jit_supports_tail_call_cnt_ptr"
> [net/sched/act_bpf.ko] undefined!
> ERROR: modpost: "bpf_jit_supports_tail_call_cnt_ptr"
> [net/sched/cls_bpf.ko] undefined!
> ERROR: modpost: "bpf_jit_supports_tail_call_cnt_ptr"
> [net/netfilter/xt_bpf.ko] undefined!
> ERROR: modpost: "bpf_jit_supports_tail_call_cnt_ptr" [net/ipv6/ipv6.ko]
> undefined!
> 
> I'm not familiar with this building error. Is it OK to use EXPORT_SYMBOL
> here?
> 
> Thanks,
> Leon
> 

