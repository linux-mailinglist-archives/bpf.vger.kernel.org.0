Return-Path: <bpf+bounces-37036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEAC950733
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 16:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366C71F24922
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 14:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3506A19D07A;
	Tue, 13 Aug 2024 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z/ZGsZ/D"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2863A8CE;
	Tue, 13 Aug 2024 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558195; cv=fail; b=W6UM7pl8OcctYUQUjLUTN2eM8EVV78posn6KvvsFpHcwhDERWyBcG9240mr1I5VmpYLiuEQt387pkropQe7/Qb+BYkTj8a/FIE23ZttvMtUThPSODN12abMGgJkxiZrTQSZItGvGL7sggs7RL7/RNv/nkKplwfcHziDWnTMIn98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558195; c=relaxed/simple;
	bh=JV81lN8BVqgwZmH1OVNy+P+HyUVi1X7FSyzA88alNp0=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KNCxJ7yRf/kPEX3JhclYP5jqGIMLiTltRscFPJ4S91PLHPtY6IX13DwOBz9+2xG+CKZ+oIc+rgGIveaqhnoa38Jm8ZtyuQJ7GYhkvtI9ZfInrvBl8ov14BLb1/b21bM61PeRXhpDBlV/A6Mj0GPF9MMY9RhubES6228N7LnOhh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z/ZGsZ/D; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723558194; x=1755094194;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JV81lN8BVqgwZmH1OVNy+P+HyUVi1X7FSyzA88alNp0=;
  b=Z/ZGsZ/DHr++i/8XUcYXWJtLPfeCdQfw51UlXeTt8zFOP4tQoclmStD2
   fCVyYafwf7rqsf8oYtCF17r95nppQca3GOyFA0McspjdIv9CFP1ernFgv
   VN5WqO2gZQ/06TuVJUKrcDqU79gR7UsKNtROn7kwVS9AfMSOvc+vSM3VR
   6PjHPFdgyxCc8BJNL9tYf1MYrzwDbECbMhQkucceHP72MzwW0Qorht3c8
   5nlQljjtm7t1npbtLXAFA2Xi/xh/DwsMNms+Avi8AXX3GVLvMi5rZK4YZ
   6D8ctK5MJp2lybJg07OhndVg5WwhNHeLJ361q7RQgpS2gQ4kgFqkGkB4O
   w==;
X-CSE-ConnectionGUID: kY7pQtq4Q6SerQvAw4PB8w==
X-CSE-MsgGUID: kL+WP8ngTg21wlnrW/yLkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="33128415"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="33128415"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 07:09:53 -0700
X-CSE-ConnectionGUID: P64TMDwiTxmnsskREggGng==
X-CSE-MsgGUID: yQxalBoqQlmtglsFkav25g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="58763822"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 07:09:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 07:09:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 07:09:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 07:09:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 07:09:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cw0eBTLNb5XHjB5nBIfSTjxMsdOu3Xx/EjcTWXBcggjS5yJGoWJ00mqJAU1H5n8JFjykdSuKAsTWD2SZ5N37SSZMvFgBMygRMf8pwmk/bTUJkyE4yBGg6ODQqouJYl1CrS51NMtOfJAZEYWoBG4Q6VnEF2YaViG+PElga1yk/5YsO1rW71mPvukI9Y93oUHmaMHGCysaK8EDbe08zpjXpZfb0wjoR288t6CJ5pmYUAVUyv2sOkcrwAnQgh58jG6xs1PeMlak0FcoKmjPSG2GU3+eRYTx2kfPFAWXpWgx5rZLpS1B/T1JV5I2wx+6QaBt91+z2K3gTFqVJnlu0xSEag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fznTk1+1CmknwXwq6gWX55ZZzH1G3iMPyLh9PoE6yU=;
 b=aZiIeMXjqAPHMR6bZPDl7Sr5A+UHmAuFmeG2/NjKVe3C3JGkNwA1JOhuv74dr3Jmmpt1NWNOHnXUi6+zcjC/A9cuOW02PC/vtd2SQoKtQkmeb9uzRKQYb6LH8ONV8/fCoVK9i80yQGEjqJ7KAdxt2vFeXOO6Fq/kEyjnTZXgF/ur/SfRkUOC/+bk7W5chZgSUW48NNol6VBisRKNLMRIh9Qh0KcSuX/MUoBgqOmnmhyiBkNeIe2Xy/1ZXn22V1ndv31cJ7jhOV+U4pn3gxvwBM2Fe80cwzchVk7TaYYr+QWiqRw0aC7rFsWaXqtP/prffU7JERjGel0tyXE8VGNktQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB6851.namprd11.prod.outlook.com (2603:10b6:806:2a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29; Tue, 13 Aug
 2024 14:09:47 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7828.031; Tue, 13 Aug 2024
 14:09:46 +0000
Message-ID: <e0616dcc-1007-4faf-8825-6bf536799cbf@intel.com>
Date: Tue, 13 Aug 2024 16:09:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xdp-hints] Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch to
 GRO from netif_receive_skb_list()
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Daniel Xu <dxu@dxuuu.xyz>
CC: Alexander Lobakin <alexandr.lobakin@intel.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Larysa Zaremba <larysa.zaremba@intel.com>, "Michal
 Swiatkowski" <michal.swiatkowski@linux.intel.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	"toke@redhat.com" <toke@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
	David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Jesse
 Brandeburg" <jesse.brandeburg@intel.com>, John Fastabend
	<john.fastabend@gmail.com>, Yajun Deng <yajun.deng@linux.dev>, "Willem de
 Bruijn" <willemb@google.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<xdp-hints@xdp-project.net>
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <20220628194812.1453059-33-alexandr.lobakin@intel.com>
 <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
 <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
 <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>
Content-Language: en-US
In-Reply-To: <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::23) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: f9cfc97c-c43c-4b8a-690d-08dcbba1964b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXQ3eWduRkVRWnlrZ05xVWRReFphdGJ0S0ozY3BsREFyVjRFZm1YdTZFV0FF?=
 =?utf-8?B?aE5nVFc3d2JFL2Y3TktWU3NENE9PTmJqd2x5aHAzYldEK1djejFMTDFxbGhM?=
 =?utf-8?B?VnFpTmFSblp6TjBHQy9nUzZVRjFWMFNwUDVzSG81emhKUkw3dHI3aXhCMG1l?=
 =?utf-8?B?VDM5dVpQT2hMZFdGWmRtV1dMdENYbys5YUJKRWpWcG1Hd21EelRhYlZOemg2?=
 =?utf-8?B?dERSWnFQdTV4Z0RwTGFLaVluV3pDT2t6Tkp6VXU4MDBqMmhDay9DS0pDUWpa?=
 =?utf-8?B?MkpUMVBJZVlsVkE2RmNlYXZ3N1hOMGlhSGNTVWNKU1ppbHRKcWIxZVpvUGV3?=
 =?utf-8?B?aWQrRVpzb20rSFUxYkNOclBZc0d4cWdRWjNYSWFVQmRDN29wVUZTUUdCTEZI?=
 =?utf-8?B?dXgyRDdpK2RzVjYrNlR3KzIrTFBLNi9xdzh3d3Y2TnNlTjZnUkE3OUJmOWFJ?=
 =?utf-8?B?YUcxeTNxTVpXT200ZXdzS3VzRzViZXV5R1JQbCtINzE3NVU2UHlsWjJUeXZX?=
 =?utf-8?B?bEpyN3JWam5uMFRkMmRnVTF3V09FVFhyYWgxNlFnNmJ4dVhYalZBTlU1TVhs?=
 =?utf-8?B?anN6amNCdERPbUJ4bTZNaEtNVzF0MXRrTUJ4ckNrY1JFNjNENm1XU0V1WjNR?=
 =?utf-8?B?bnAxOUJ5SGZYakVYVWFpcVphNmd5WFpvLzREK2ZVY0Y5bEF6YXZjVUx4UlM4?=
 =?utf-8?B?bzhzT2g2RUNyTXFHdGN1b0hMYVNwZTY4YlZCL0NleDQzNE9jRjVZYlppdjZh?=
 =?utf-8?B?MlNxbURrTkZjZDlOQkZRTXkxTml1Tms5TTE2c25XQjlsY3BySzFZeHlzUlQ3?=
 =?utf-8?B?ZjErZ0h1WkVGNnMxd3d5RDNtNExYMW5VdkIxUjRlVFF6VFZWVzlkcmlzU3ZP?=
 =?utf-8?B?TlRRWTFzdHBqSGZxdTVURlR4OU9jTDhjeWRjVVRZdEZrd3ZEbXZuUC8zaTRv?=
 =?utf-8?B?L2JyK2QwS3dlUmNNMkkzTkJCVU16UUpqQmp5OExSOXIxYk0rc3o0aWlqVU5p?=
 =?utf-8?B?bFl2UFJnY2N1S0FtSHhtb1RWaFNQYXhyb1BRSXkwS3BpYzVyTHRpQ2pHaFhL?=
 =?utf-8?B?eHU5TXcydENyQ2Vibm8wcS9sbkdRTkUySGgrYXl5U21jdGlyL2pob251NkNx?=
 =?utf-8?B?SEdXc1c5eFlTSmhkMElheFZzNVNJSUVhZ0xaTVZRSW1qdEVSbWduQ09Oa2F1?=
 =?utf-8?B?SEptNmg3K21EVEZnZ0t2MTA4TTE5Y1RhZ1NaejJ5cEU5VXZzVHVJWUtxTVR5?=
 =?utf-8?B?bk41bnlxVTNNdGtHV212NGxyMGxLSW1sLzJiY0x1aTNGVm1tK0VQWDV2WjZl?=
 =?utf-8?B?akVHbnVTeDlRM1pEMkhkTnRzbkEwU3NzTXhnKzFxOTY0V2JnWXlsNUQrMUtu?=
 =?utf-8?B?dUdEOG41MHhUY0lIem9JWEVEMit0dGJPYVlvNE1DU2d3TldTZ2FyS2s0R1BU?=
 =?utf-8?B?Qy9zTytUTlExby92Ync4eEJWbk9aNm5aZFluMUpjSEZUb2ExZjBrWTEwWEl0?=
 =?utf-8?B?eFhBZ2NyeG9TUFdnY0svRG9nMFV6UFd3NVBDM1EyR3JEd2lycVpDZkN2Ukgx?=
 =?utf-8?B?YXpzTHFZZTcxNzYyNC9FaDFxZkY1MGg2UjIxT1p3VGNJMmxiUGdiRUw4d0NU?=
 =?utf-8?B?RmwxdjlZMEhvdFJoWmdDeWhyVyt0UVVCZlBSdjlrSlpLbENKcW41VUJRVThT?=
 =?utf-8?B?WkRaQlVkcmhPWENtYlZ6UFlreERwL0hoVW1md3NNNTlIN1pnQmpQcnY4VXNR?=
 =?utf-8?Q?bCEHs8zmwjO1ohG3ZHxC2ux7kUaOq/1Ht10wJr5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzlZMkErZzgvTHNEUEZTdzBoS3FSUWhUYi9lMEtCTncwdHVnYldoQzZxUWVM?=
 =?utf-8?B?bGNOdit5TG9PSktVeGVtVGpSL1JEOFQyU1RzVUpVN1lNQU9TYkV0TDZUaVpF?=
 =?utf-8?B?b25ucEZ4czc1MEtYc2tPMWZGS1FnOEt1NWZHWlpQcHlRRWVtUTNKdldkU3Zr?=
 =?utf-8?B?Rjg0OVZ1Yy9vOUttTTdlQjR4WjlBcTJIZFRueEZ5ZmVxNjhlTjF1a3UzRkRC?=
 =?utf-8?B?NWc4Z2ZlZ2thZFY0M0ViVzA2VFVYZ2xibFgwbW1LYXJYcmtqT1hzUEdhNkhv?=
 =?utf-8?B?bmMza0J2aC9mKzhJM244aG9ka3BvT1dBYnBoUm11c2hZZENESXIxblhrOTFU?=
 =?utf-8?B?RmpEMkxqQ1czc1JIZ2tYWk1yemM1MlhDUWxUOGxqNXBRZ2E3d2hiUUEyNjFQ?=
 =?utf-8?B?Y2FYd1BKKzJRV1FxbHlRb3BLUnNzd3Y5TnFMSzdhVE9nMUhBSEMzc3lJWCtl?=
 =?utf-8?B?NHdWY04wS1U2ZitMeUIzTDFybERMKzhHRU83N0JraXg5enBwcE4zWGMzcDhu?=
 =?utf-8?B?b25mUEhJYVR0SDNMZktUcFpLUURsSzB6bjJhVVNXazhJYU0ybXFEZm5WR3kx?=
 =?utf-8?B?RDFZZ2ZpUnRkZ3Vac2lpamJDSHR2WFR3MzV3aTBXenRvQUwrMFoyTTdwL045?=
 =?utf-8?B?N2Q2S05KSWUwM3d4Z0lLa2xIelZKajA2YzdBSm5VY3dLc1l1eWVBL2VHNmJZ?=
 =?utf-8?B?ck5jak1YUDBYSldIMzVtc3VFRmZXTml1YTNhSk1CMFBpOFNkbjJrbnhuMnl3?=
 =?utf-8?B?VW9hZTFtbFR3YW53ZkdpckhULzdOU0V0cTNZcTJmSWhsQWFadS84OVV0TWM0?=
 =?utf-8?B?NmU2cW8zc2ZYdVlBRkNycUxReVFJcXAySS9yY3dWeUlpb3o5dlgrLzIyclhD?=
 =?utf-8?B?WWFYK1V0Z2x1WVlGV0EwMlZ2NUFnM0ZhVzU4WG9zNDFVRnd5cEpBQlhZUDBL?=
 =?utf-8?B?REtvaW5OU3Zvb1laZWNDbTNReW15THZLdjFJbWFXTmlvVlMwdmlYUDZXT09D?=
 =?utf-8?B?ZnYyMmVhdHZQVVNoSjNBaTJkbVg2WmVWMEtiVjAwcFFmdmxkZC9aaWJ0Y0FN?=
 =?utf-8?B?anBxUS9ORWtydHVsM0k1bWdnZ1ZRSE1FZGtCSXFVZzZLbmMyN29obnVVVCtn?=
 =?utf-8?B?dEIwUXJhdnExMGtiS1NKWUhha0pxRGd0MytJK1FFakkxTUgrMWlvdldRVFhV?=
 =?utf-8?B?d0pQLzZHOEZ2NHgwc3dNRThwandpc0lXK2oya2NWUWFNaDRqS3lDeXlhMFhX?=
 =?utf-8?B?Wk5BYVNNcVhoTE1qNm9zVTVWWUZTWUZDVWhQb2VMSStIeDl2MU9CTzB2YXBa?=
 =?utf-8?B?dUpFWG1zRkpwSWJNQ3NHS2VIQ0NsQmZpazVkRkVCOWdXT1A3b2YyMFpSdUFP?=
 =?utf-8?B?Y1ZBWkJEZzIwdTdsdHNYVHZJRWNZdjFsTFRDbmw2S1dRVyszRGI0QnY3bjR1?=
 =?utf-8?B?VmpYa3lHRnFxaGNNZTM4NHJhZk54alVkUEpabCt1SFJMM0dkZGhIR3NQaDF6?=
 =?utf-8?B?UUduekw4WWRKdFZ1TjBpVTJNRndDSGNHMlVGdGw1elgxbU1UR0Z5N1RGSkU2?=
 =?utf-8?B?SDNPT2Fwd3A2WmxiUTRNWWRvRkN3bjZGcUNSeEl4MG9hK2srdG91cW1CYUQ1?=
 =?utf-8?B?aUo1S1pXTkhBdE9nMURxTmhNNzBmM1VoMmF1TmFZUXdiblBUalNnYktBNHFo?=
 =?utf-8?B?ais0NXkrU1ZBZXFqRUw0QmNiOU1Ud29hVGtVVERkQUFWNkh0bzU4R2FEQVFR?=
 =?utf-8?B?ZlYvRzVoS0p2bGRzLzB2dVVZRE8wL1J5NWxuODdkQ3paSW45UE83ODVJK2Jp?=
 =?utf-8?B?QzhGcjRMSW1mRzlLOFBVc1RvOEoycG5OWWd1Z09iQVc2em56OXI0QzFqUVhn?=
 =?utf-8?B?L1I3ZnZtblVPZmZGMWFpb3ZOcnY1cTFUTTdtdFhDTmhqRDBuYjg0ZmJRankw?=
 =?utf-8?B?eXI2cG0zWXBoRDlzL3l3ZXRNMnM5RUtKaTAzSnVxRHFpY2R5YkFONEJvbThl?=
 =?utf-8?B?L3JBRFpVdER2SWV2cWxZVTl1eEtMb280WUNTRzA3U3FSalJ0Ty84T2s0SHMv?=
 =?utf-8?B?ZlA2OFNKK3MxaGNzYlFlZVBaYldreTJjU25hRGRlSmlZOWhIenV3alU0bE5C?=
 =?utf-8?B?WFZXVFFMaFE1QmNhdVF6THJTOGVhcW5Gd0JQb3NmRUZwV3dNbGZyNDhFbnE0?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9cfc97c-c43c-4b8a-690d-08dcbba1964b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 14:09:46.7436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFppGWx2Cks7/h9IJSVvA/3UuNQZvduHzpNAmfys+GG+tHuJISKzXQD56S5uPbOY41T0tlIed+qtNWUVhbNK2efVnq8t6KEKcHOTYs8VJj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6851
X-OriginatorOrg: intel.com

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Thu, 8 Aug 2024 13:57:00 +0200

> From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
> Date: Thu, 8 Aug 2024 06:54:06 +0200
> 
>>> Hi Alexander,
>>>
>>> On Tue, Jun 28, 2022, at 12:47 PM, Alexander Lobakin wrote:
>>>> cpumap has its own BH context based on kthread. It has a sane batch
>>>> size of 8 frames per one cycle.
>>>> GRO can be used on its own, adjust cpumap calls to the
>>>> upper stack to use GRO API instead of netif_receive_skb_list() which
>>>> processes skbs by batches, but doesn't involve GRO layer at all.
>>>> It is most beneficial when a NIC which frame come from is XDP
>>>> generic metadata-enabled, but in plenty of tests GRO performs better
>>>> than listed receiving even given that it has to calculate full frame
>>>> checksums on CPU.
>>>> As GRO passes the skbs to the upper stack in the batches of
>>>> @gro_normal_batch, i.e. 8 by default, and @skb->dev point to the
>>>> device where the frame comes from, it is enough to disable GRO
>>>> netdev feature on it to completely restore the original behaviour:
>>>> untouched frames will be being bulked and passed to the upper stack
>>>> by 8, as it was with netif_receive_skb_list().
>>>>
>>>> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>>>> ---
>>>>  kernel/bpf/cpumap.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>>>>  1 file changed, 38 insertions(+), 5 deletions(-)
>>>>
>>>
>>> AFAICT the cpumap + GRO is a good standalone improvement. I think
>>> cpumap is still missing this.
> 
> The only concern for having GRO in cpumap without metadata from the NIC
> descriptor was that when the checksum status is missing, GRO calculates
> the checksum on CPU, which is not really fast.
> But I remember sometimes GRO was faster despite that.
> 
>>>
>>> I have a production use case for this now. We want to do some intelligent
>>> RX steering and I think GRO would help over list-ified receive in some cases.
>>> We would prefer steer in HW (and thus get existing GRO support) but not all
>>> our NICs support it. So we need a software fallback.
>>>
>>> Are you still interested in merging the cpumap + GRO patches?
> 
> For sure I can revive this part. I was planning to get back to this
> branch and pick patches which were not related to XDP hints and send
> them separately.
> 
>>
>> Hi Daniel and Alex,
>>
>> Recently I worked on a PoC to add GRO support to cpumap codebase:
>> - https://github.com/LorenzoBianconi/bpf-next/commit/a4b8264d5000ecf016da5a2dd9ac302deaf38b3e
>>   Here I added GRO support to cpumap through gro-cells.
>> - https://github.com/LorenzoBianconi/bpf-next/commit/da6cb32a4674aa72401c7414c9a8a0775ef41a55
>>   Here I added GRO support to cpumap trough napi-threaded APIs (with a some
>>   changes to them).
> 
> Hmm, when I was testing it, adding a whole NAPI to cpumap was sorta
> overkill, that's why I separated GRO structure from &napi_struct.
> 
> Let me maybe find some free time, I would then test all 3 solutions
> (mine, gro_cells, threaded NAPI) and pick/send the best?
> 
>>
>> Please note I have not run any performance tests so far, just verified it does
>> not crash (I was planning to resume this work soon). Please let me know if it
>> works for you.

I did tests on both threaded NAPI for cpumap and my old implementation
with a traffic generator and I have the following (in Kpps):

            direct Rx    direct GRO    cpumap    cpumap GRO
baseline    2900         5800          2700      2700 (N/A)
threaded                               2300      4000
old GRO                                2300      4000

IOW,

1. There are no differences in perf between Lorenzo's threaded NAPI
   GRO implementation and my old implementation, but Lorenzo's is also
   a very nice cleanup as it switches cpumap to threaded NAPI completely
   and the final diffstat even removes more lines than adds, while mine
   adds a bunch of lines and refactors a couple hundred, so I'd go with
   his variant.

2. After switching to NAPI, the performance without GRO decreases (2.3
   Mpps vs 2.7 Mpps), but after enabling GRO the perf increases hugely
   (4 Mpps vs 2.7 Mpps) even though the CPU needs to compute checksums
   manually.

Note that the code is not polished to the top and I also have a good
improvement for allocating skb heads from the percpu NAPI cache in my
old tree which I'm planning to add to the series, so the final
improvement will be even bigger.

+ after we find how to pass checksum hint to cpumap, it will be yet
another big improvement for GRO (current code won't benefit from
this at all)

To Lorenzo:

Would it be fine if I prepare a series containing your patch for
threaded NAPI for cpumap (I'd polish it and break into 2 or 3) +
skb allocation optimization and send it OR you wanted to send this
on your own? I'm fine with either, in the first case, everything
would land within one series with the respective credits; in case
of the latter, I'd need to send a followup :)

>>
>> Regards,
>> Lorenzo
>>
>>>
>>> Thanks,
>>> Daniel

Thanks,
Olek

