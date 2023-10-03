Return-Path: <bpf+bounces-11269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4C47B6662
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 12:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 81C7A28199E
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 10:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E4A208B0;
	Tue,  3 Oct 2023 10:28:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D58D50B;
	Tue,  3 Oct 2023 10:28:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BBBAD;
	Tue,  3 Oct 2023 03:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696328885; x=1727864885;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TH2n2TxmUwPMi6S9pwhvNacJvlAhEEepN65dF8mONy0=;
  b=TPJ8019QPxT1U+ZGlNIJwqYt/OL/6dTGtEp6v8qTjZh271X2HbVxqNQx
   mIeIjAS3JLPQ3D3k7i0F+b1M8q5egImEwA0jHddlvAn6oROGrO9EYBKyC
   vs+7h6VA1MyRETDGkT/q901uferbyRDcxWc+CRkwE4aYwQWNb4B8FqpDV
   ELPVXJ5pyejoqE+Ko6BV2LFB8gmXckv3XEE2j2jFURncflDaZinDo5u1M
   HnppVTxvm1OTvr40cktLOl9V2Lwc0DHfRfK/Z5rX0F1IHL+n1QMKJs8UH
   c3mZ3BDDIWYeLkxIyOHh6+fXm9U6nhtTnGI9km6eJ7BOhLwgzm9o6rY26
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="362212592"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="362212592"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 03:28:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="924602009"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="924602009"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 03:28:03 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 03:28:03 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 03:28:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 03:28:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 03:28:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNkTWLCnVfRXmTyj9nZ7QJB9Zb6u7BpkWO8hJ6PFo4LlVUHXVQ01vhKUJ9uCDd4h2Q2OYWomg7ZqhXA7jrUFTdmRSCgORLFlaLa/sK01RXXvc1ev8itY/Ltxy8c4TZDuVPZ61kiYvkYBaFCkmjxxPeeANlmpccA6OjZR65V8mC5ZHibKKCyY7W5a7LW7M1WWvjxuDTWcMkqZssN7s+k79BAo0M+enmQM/t7Tfe5t3JNvaRTn7R5mY9PWs5lZ0wEgTCTJTZ/zYviuOlm60lfESlpWX5wQC1oi5v1Fjv+7bWTmiepS1NvLZVpDUXaWDECgaR2CyOYsFM4w8Gy6h4pC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5SybBmabLLAS0/7Jc3lIjTxDYMtvU7R/NVkDi7eezE=;
 b=V6tWKcd9TybW/+vIEmh9IIhyJAe6baw36Zj0o0IzWAj8Mu4K6tSCoXzBKfEByAi49oSMUmseNFzkB6E69fvyxkYrh9xASwIKEcoeX2YBtSXnzu+LUh4O246PWW1CMhyOSrmlXTdKDcxG03daQlwkTZLThuKGHreHzcG2lI3e5PD/4y+TnkoWDtUwyj1Gbugyj0moAUP0Kwan7BhFK0ESLI11c6zUqHGehkGpwQ4Gp1mLdehSyRSHnkPVegyVLlr/ooB4tnGwv+pAyGWfKoO0+F898I8am4tJZ76THMwL7ubS6jTkpiSes7bt7p7LOKUr5qSDJp4BSzVVqpQ3gLyU7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by LV2PR11MB6022.namprd11.prod.outlook.com (2603:10b6:408:17c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Tue, 3 Oct
 2023 10:28:01 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Tue, 3 Oct 2023
 10:28:00 +0000
Message-ID: <ccda3c93-40f8-c88a-3d34-f51247004552@intel.com>
Date: Tue, 3 Oct 2023 12:26:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v2] net/xdp: fix zero-size allocation warning in
 xskq_create()
To: Andrew Kanner <andrew.kanner@gmail.com>
CC: <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <jonathan.lemon@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <xuanzhuo@linux.alibaba.com>, <ast@kernel.org>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <daniel@iogearbox.net>,
	<linux-kernel-mentees@lists.linuxfoundation.org>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<syzbot+fae676d3cf469331fc89@syzkaller.appspotmail.com>
References: <20231002222939.1519-1-andrew.kanner@gmail.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20231002222939.1519-1-andrew.kanner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::17) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|LV2PR11MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e7b1dc-4ad2-42db-ac08-08dbc3fb6a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ny9xTCtQSndWTE9rZnZFemd1MnV3UGNKTVRlejNrWHdTemNJekdwZURrRkNR?=
 =?utf-8?B?dVg3WFVVTnh6ZmlDanJNemxycUNrWEVlMnZjWlRPN2FKQ1dkaTk4NVIwdkNX?=
 =?utf-8?B?R1JXVVpEMWQvK0tvdEpYcCtObXFFQjdQUTFuZlozbGRwQWZYOUpUc0p3QVM4?=
 =?utf-8?B?czYxbUtQcE1STUhNWkpXVThhbUE3a0E0Ky9RMFk1M3JLZkhHMnA5amg3WWs1?=
 =?utf-8?B?TEFqcDJGaGxqbXBXUkFadlJpSUllSnBWTk15ajNvRDVPd3BuQ0lFZVNWWXFE?=
 =?utf-8?B?Y0hxOEZrU1ljNWVaTWdJLzVvL3FFWlVRaFF1eHhpREVzVW1iM3BNSmQyaHRw?=
 =?utf-8?B?ZlkxWmUyWWw5dkpCc1ppcVJCZUxUMkRaOXJwR3NQWjdoN29jRVpTR2V3VkpL?=
 =?utf-8?B?bkg3UUxzNXhTVEkvbGJPMDdQUHBRYWdQSXVXejRPQS9RQmFiL0huY0o4eGFD?=
 =?utf-8?B?OEw0WUFXL05ZYm9ZSDhwWlpmZkFEZWJtcWJvUWpKQ1U0eEwxVk9ZbE9JL0t0?=
 =?utf-8?B?bGxhMDdqdTBxQU1vYWFMOXFSMk5PWmZmbTI5Tmg5VTllN0NKUzdwcGw2Y0Q4?=
 =?utf-8?B?R3A0Sk5BZ3pHTS9XLzJ1Vm1QT2F5c3lyK0FTQnMwcTR3QjN5bUZELzhkODBH?=
 =?utf-8?B?cmtvditEc2NMcUNuYnhwVVJBV2RmYlJCSnZBRVBYRndxNWszUVY4ZjhIVHh4?=
 =?utf-8?B?Si9QYnF1bVlRMU5hUHBVZ2ZRVm16b0FxdHp6U0kreWhYd0RIVVZmbU9zL1JL?=
 =?utf-8?B?clJ0TC9YT1N3Q0pKUVdQcUptRFhoNDJreldGdFA4S3gyQjdGZzc3aHd5Mmds?=
 =?utf-8?B?aElScmJaM29VMm1GNXd1WnBRaGRQcEhkRHFQSE9EZ2dXVitxV1dBYkkzOEtp?=
 =?utf-8?B?aENOcUZpRm9aMm1IVXFnZnI1QTVBWHFxM2lFSTU2UEUveW8wVS9rUzVVbUVp?=
 =?utf-8?B?TDN4VjFxL1FDSGw0VlhLWWllaDZnNFVYZUlUbkFHaTI0UFZ6cVNEU3FEdTBt?=
 =?utf-8?B?Y25Rb3RoZ3pvc2RmNHh6aEZTZ2d5WnZVTUQ5YzAzK05XVkQ0bmwyTExLUjZy?=
 =?utf-8?B?dlZpZ1NxMGlyWTdmdzNEOG9Xc0xZa2xZekFTZXpsQUNUY21JSWo2aWIzUElH?=
 =?utf-8?B?REErNFpsZzFNRnpLa3hWcEpHWWw0Snh0NG4rclBpa1RqV1JPbFFmNU95VFRV?=
 =?utf-8?B?SG5Bd1NDekF5VkpmeUNNREQvT3ZoRk10UjN6a29BUU9LWDRzSkp1UGhsbkdx?=
 =?utf-8?B?S1VZVWVOMUsxcm9yQ3VrYWJYUm1TL1gvVWs4aFRJVS9QQmpLeWpVeGlueUpS?=
 =?utf-8?B?WXVZMEFMZlJmUThCdmNVMW12YlVRSGRhS3plbW83VWdrZTNvWkU2d1lLeTR3?=
 =?utf-8?B?R1k5VytRR0tBYUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6512007)(4326008)(6916009)(31686004)(66556008)(66946007)(8676002)(8936002)(5660300002)(316002)(66476007)(478600001)(7416002)(45080400002)(2906002)(6506007)(6486002)(966005)(41300700001)(6666004)(26005)(38100700002)(83380400001)(2616005)(36756003)(86362001)(31696002)(82960400001)(99710200001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SytZVVBCQVNFbG90TllLRWt1OFc3cUI3RFpMbldUbldaRmhvZXRqcE14N0gy?=
 =?utf-8?B?eG1CL0RqckF3NlhuNUVWTGxaVnlOVkYwMnFXdS9HT3RUMmkyMW96RTNhZ0Fi?=
 =?utf-8?B?YVd3UlhuaExZRHMwRUlTejNYQXVoSzVmZmh2RVl0R1BLS0RwZmhKWGs5cy9x?=
 =?utf-8?B?ZWpLTFJxT2ZYZVJYNUJaNDdlRlVRSWppZndaZCs4bGZqZ2xubXROZGFQL09v?=
 =?utf-8?B?MmNkSHlVTExKVkMvZFNGRGJXYkVtZitoRDNnSFdldWx0dUsxSHJxK0Zlb3pv?=
 =?utf-8?B?UTArZWpwbEZ5VkxxNkRhZjlJdW1KQU4yeXZYZzQzb0FCbjNRV3JHdkpZaXhw?=
 =?utf-8?B?WW9xZy8wdGV6SHp5cUF6eG1scUt0OHRuQkRJUVFWU3ZuOUtyYVc0cHgxTWFB?=
 =?utf-8?B?ZDRDT0pKaC9UclRsMzQwUGRTeE40eFJ1WmxUNk40QlltSzdFM3FvOGprODBW?=
 =?utf-8?B?WHBsK3UwWlU4UzRURWhVSVFQeDl6VmRMN2xmMlNLTmJ2ZWdwTnZBRkJQMWJV?=
 =?utf-8?B?RXJ2aVp0dkJhNDBSalZ4Nm5UT2tpcEtUTml4TnQwbk1BeDkwampLalVxQlVw?=
 =?utf-8?B?TFg5TGJGQ3B3Y0kxMGsyQ1VtZnJtZThRck1RSXJMQkVWOWNHT1U5bVkvV2pS?=
 =?utf-8?B?MWxyZGE3TEYzY04zaFh3QXRNejVkeHRPcEpQZkZLRTZoSGNWZE1QR29mWkVC?=
 =?utf-8?B?ZGRkellXdENkM1FQNjcrUmpNcXFYNGtlZG1MNkw5TzJSbnFIbE1KRXRtdzkv?=
 =?utf-8?B?V2xCN0NrblJxYkdmNUhhRXJYM2l4Z2NRek14dzZzYkMwM29WNlAyUGFKSDhN?=
 =?utf-8?B?QVI0by9qdFZibFo4K2o1dTR5Z2h5QzViS051OFNrL21aTWplR0RWM0R2L1Vj?=
 =?utf-8?B?NytBUW8ycGF0eG1HSEJodG00ZFdYdzdrY1lyYTZYTWxMNFZ0cnl2TW5maXdZ?=
 =?utf-8?B?UXo5ZFpoQjVsWEUvZUpWcFdrd2JaUDJ4NStPRXV6WU94NEZnMEZwM0t2c3Va?=
 =?utf-8?B?dHY0d1JESmRzMjlUOG1sSG0xcjNpTVpaaDdPd1RPNlpDUHkyQWxIWHpLZmFU?=
 =?utf-8?B?a0VzNFVuQS90WXo2UWdvQlZ2T2FPWjdHQlBZMmJWTzZTVVExWkx2aGx3ZXQ2?=
 =?utf-8?B?UVRFWkhGNUtCZDJBNFdqK2JEYUozRENvdUk4QW15VUNGVFNBUHY3OTVBUE14?=
 =?utf-8?B?MEhhTjE1L0w4NGlHQlZIRGF3eW5aUHdCZHhFUzhPKzU4b2hvL0VMdmFxaWtS?=
 =?utf-8?B?LzlIV0JJZGFXUXBzTWhrN2grVzFhZHk5VDNvdW1CV29Lc1BkVG80eERQcUk2?=
 =?utf-8?B?UEkrZWU1Rms1dVUvWkFRQW1QMTNtRXJWWVlFVWgyeEVpK3FtNzZWM01WMzBO?=
 =?utf-8?B?ekdydVV0ZmViL3FsbnBxenVCYk1nRkU4QTkrM0RTOWVXZm41aFlPR2EzTXln?=
 =?utf-8?B?Nk9nZC9SNXptSDE5V2ozaXU4cW1GS3B2M0hBUmQ4QWxkeC9WdkllQ0dDQnBP?=
 =?utf-8?B?TXQvK21xdDVtVjJHeTAyWEovMEpKV0wyV3JuNFpHMDNRN0tRQ1YvNTRoTk9X?=
 =?utf-8?B?eWZJVnVxZGc3SWhSZUVOMUgwYVlaQXFYRUNyMTEyUlVMOXNOdXkraGZPK2Fa?=
 =?utf-8?B?K3pNZjJOYWJjQSsyNEp3WEhGUFlMUjR4WTUyaTk5VTFsbjJQWUtEeWdmb2ZM?=
 =?utf-8?B?blp3clRwZnluVndLdzRtMEhRdTY0cDZZZFVVNWtsQ0dpTmdyNjRMeVo1Wm1n?=
 =?utf-8?B?MFczUytKQnN2R3JMeGphblAzZGlkdkFWREN1Z2JYTWNLa1pxemVKYk1BYzQx?=
 =?utf-8?B?TDh6akdZNGFrTWlmRWhhUUdzOU1SSTRmSzQrUW0zOWZ4N3JXSHRDNUVHbFVr?=
 =?utf-8?B?NXl0MUR2dE55OHh1c1Rub3pyTEhzR1p0U0d5TFh3Nm9KUkFuZWp1b1pBMS9u?=
 =?utf-8?B?cW85YUZnR0t0bzJSYm9ZSGhVSThYNEwvTG1WQ0REQW5BN1VKN0laczI4emRE?=
 =?utf-8?B?cG0yRmN3S3psaDJkZkxoUHo5NExTeVkvL0htRnMvRTNBMW5YZS9IMFN6Kzdw?=
 =?utf-8?B?bktGaDZlN0JKK2xMVVZqTzZUcnRxWTRYMG01YTlzWEJGOFBHSXdJMTVneG1a?=
 =?utf-8?B?UUVBdXIvYy9qeFFlZ3RlMmhpOEtBQ3ZhNk9OZzY2dTN5Nk1NZUpLMkVXZ0NM?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e7b1dc-4ad2-42db-ac08-08dbc3fb6a9e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 10:28:00.2094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: El9Uw/UJAC6cTj/mKoolevs0BaCUpNKMYuZuHe/fkPPcPTMzsACmHtG0B7wUEnE49HRIfdjtWE7hpolfqU0vR1MwG2NFU444SGPvS+wQpIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6022
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Andrew Kanner <andrew.kanner@gmail.com>
Date: Tue,  3 Oct 2023 01:29:40 +0300

> Syzkaller reported the following issue:
>  ------------[ cut here ]------------
>  WARNING: CPU: 0 PID: 2807 at mm/vmalloc.c:3247 __vmalloc_node_range (mm/vmalloc.c:3361)
>  Modules linked in:
>  CPU: 0 PID: 2807 Comm: repro Not tainted 6.6.0-rc2+ #12
>  Hardware name: Generic DT based system
>  unwind_backtrace from show_stack (arch/arm/kernel/traps.c:258)
>  show_stack from dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
>  dump_stack_lvl from __warn (kernel/panic.c:633 kernel/panic.c:680)
>  __warn from warn_slowpath_fmt (./include/linux/context_tracking.h:153 kernel/panic.c:700)
>  warn_slowpath_fmt from __vmalloc_node_range (mm/vmalloc.c:3361 (discriminator 3))
>  __vmalloc_node_range from vmalloc_user (mm/vmalloc.c:3478)
>  vmalloc_user from xskq_create (net/xdp/xsk_queue.c:40)
>  xskq_create from xsk_setsockopt (net/xdp/xsk.c:953 net/xdp/xsk.c:1286)
>  xsk_setsockopt from __sys_setsockopt (net/socket.c:2308)
>  __sys_setsockopt from ret_fast_syscall (arch/arm/kernel/entry-common.S:68)
> 
> xskq_get_ring_size() uses struct_size() macro to safely calculate the
> size of struct xsk_queue and q->nentries of desc members. But the
> syzkaller repro was able to set q->nentries with the value initially
> taken from copy_from_sockptr() high enough to return SIZE_MAX by
> struct_size(). The next PAGE_ALIGN(size) is such case will overflow
> the size_t value and set it to 0. This will trigger WARN_ON_ONCE in
> vmalloc_user() -> __vmalloc_node_range().
> 
> The issue is reproducible on 32-bit arm kernel.
> 
> Reported-and-tested-by: syzbot+fae676d3cf469331fc89@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000c84b4705fb31741e@google.com/T/
> Link: https://syzkaller.appspot.com/bug?extid=fae676d3cf469331fc89
> Fixes: 9f78bf330a66 ("xsk: support use vaddr as ring")
> Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

[...]

Thanks,
Olek

