Return-Path: <bpf+bounces-45266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CA79D3DF0
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 15:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBF5FB26034
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 14:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C23C1AC420;
	Wed, 20 Nov 2024 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eWxHvQZc"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B81A939;
	Wed, 20 Nov 2024 14:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732113670; cv=fail; b=BXUSM/53yTdJlGfKxwxzsUhRYjwNe4YDnN1Z3G8x7D6PcLu8cdd4w0XrAwVENDrJJJ8gP33C+U7m+txh/IRsw8dvYs7V6DmdVlzHhtJoJMhtWqUNtqA9arRJG9Cs1JdYbLdAaKJ7XvAVMuwuQqKSSOIjpQ+CZZkqd2q4XFN+XnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732113670; c=relaxed/simple;
	bh=w2eLerCaPgI6CuCHPYiWIa3OkUKsLGlkHM+pT85fLKU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EraHozaxpMRb6zr5K0ezD1IyG07Euoep92R2K38wfW/MCfITclb5MC7NxTtsna1QCN4QfEp0qVAFSfocR4k4O/Wu/E3HrqnXGXInMLd19GCBdI+cNDfg1sCqCYEsv07tCnbJvpYzt8MhNMr8C6zif2aT3nUqhRIby5ehXr1NpwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eWxHvQZc; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732113669; x=1763649669;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w2eLerCaPgI6CuCHPYiWIa3OkUKsLGlkHM+pT85fLKU=;
  b=eWxHvQZcpU0MBnSxZdq5O7vSSZ21Sx36gpHh/520ByjhWsoWeEvEX7Rv
   leoNAEoEJ2tznaMxndQ85yTC+q/PQaebSqiXBVsFIqfK1efLfTJEF+q5b
   Q/hDWuWuWw/Ji1AhiqIM2wS5sOAyvjnS1MC78hU5vO286ZFzOFBRc3b2U
   dpL2mHBPbhi6NBhMC/1Zjd88Wrk7wD2oR4RBGSuXGsWppggyX3CVszv1l
   JcCX9KVsFXU/9ZbNaF1ql707L7TqrfsTIjU7BqYe35IinvdVRzGoJkZNo
   m1nJ10L8vBEyV8tdI9OqUXAz4eyswDn0lnUa8RiFLvcd5d0lHMCiXA4aj
   w==;
X-CSE-ConnectionGUID: mXfJ6OxSSCyLa98M1+WLZg==
X-CSE-MsgGUID: rD959ktnRWOveBSrNkdgeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="31546536"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="31546536"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 06:40:48 -0800
X-CSE-ConnectionGUID: 91nS5TI0S/+iSywlBLNYSw==
X-CSE-MsgGUID: cY4FTYbeSm6lQOETBQZFjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="89927398"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2024 06:40:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 20 Nov 2024 06:40:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 20 Nov 2024 06:40:46 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 06:40:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vij0U6r3KU+xAvI1D56wDZMxRBNHVhSypad86zynhN9579uBfOii5AeDnz7quVyXCtnsxKRAM02LO1dWQTglHT/bWaF2qHBvf99uFHeW9e67s8FPveogfF10ysLf7Xir5TT4m3PuTSQ0VT9VFbPOxAhs0tiBH43/ojDtH1DCHrAdfguUNYZ53KEKbirp03Xoj/Z/2lcB6yZvvMXUxPP49Vki2/xBrpQ2SthKMwVATFW5cLSrCkTCGKXwvhSdEXinH4qr4ngzdA+vVfUjt/nIJBFwRjk7jxwUIGyqHlIwPvHf6Kp1X/OLSISfzITxbwQy73fKnnAdZGJ1EdGOiAkG6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmjwB6PYcx3kjojLTRKX2kEPTkdXAStFeMTEvnaoZeQ=;
 b=DfLyBqMPjAHtoNureTvMEElSovf2xhLqkooIK55kUitm/UvnJeDjYRMFAgZWeCrk4dzwKFKZOm6KSmQOEMbsFGfwXAEq0cMUjjcl/4TenpHs/0VckBGgVQ+tR6NLFGpqDOmaNQGwQI60oCq96eyv7vQ+5bpXWhtRq7SsdKJMmJGjA+jyQ8+yDMsbjwkpCx0PFmNS8rOxzcpBNlKXojzctfeXnlI2d/RLPCUalrU1Yb2DcaDnMkCejSWY/+H40p7dap1iGWR40G27tGreBQRm9Z9T02sfzTh8XqR7bsxc/T5sjuFxgNWpfk0K6G5MYZPof32p7F2CpdI3qwk9civxXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB4893.namprd11.prod.outlook.com (2603:10b6:a03:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Wed, 20 Nov
 2024 14:40:43 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%6]) with mapi id 15.20.8158.021; Wed, 20 Nov 2024
 14:40:42 +0000
Message-ID: <85a32259-d523-49ed-9441-634e4c2e881b@intel.com>
Date: Wed, 20 Nov 2024 15:40:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 00/19] xdp: a fistful of generic changes
 (+libeth_xdp)
To: Jakub Kicinski <kuba@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
 <20241115184301.16396cfe@kernel.org>
 <63df7a6a-bb4a-410d-9060-be47c9d9a157@intel.com>
 <20241119062543.242dc6a9@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241119062543.242dc6a9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0038.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::7) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB4893:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d2b486d-8f32-4e0d-3865-08dd09714f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TktYMnQycEVqdkxPVXlDUE9VaGlLd0ZLRUJsRkZkRlRvaGNoaTFXRzhvcm5p?=
 =?utf-8?B?eGw0cG1nMDNrc3d6cmcrZ29ETkFOTjhxNWNaWnNpOXVRTTM2Mm9OVlFiMGR5?=
 =?utf-8?B?NXo1WVNldUEzRWVoaGNBSkZ2UGo4ekNIYm54UlhUZ1dpY045bUVtWEROWEs4?=
 =?utf-8?B?Qnl5NDJSM1NFWThsbmpZOFdMdUU2RGlheTNrb2dOZUppREtDOFdiQTMxaVln?=
 =?utf-8?B?aGdwQ0xtekMzeVZaUGM1allSMzZFTmtFSHlkUHlRVXZFR0ZDM3pyeWxsd0Vi?=
 =?utf-8?B?ZWFrbDNIa1BqcEVQTEJoVWZKclhxNDBDeTZUbHRwTWhzMUNtVHhqZFN1dGZj?=
 =?utf-8?B?VTJpakZXSjJsNDNkenNJckxkdnE1NEhIazBhdmRvNXg1Slhpa1h4cFlxYlpo?=
 =?utf-8?B?STM0YnBEZ1VMUWMxMHBERjRHeGxnTURnV0VVc2dTUkhNdUlqL3dMcUhnR01W?=
 =?utf-8?B?Z0NQcVh4QkdmYjdadmpCYXpHdVBQTmg3dFJtVXJTTTJSRXlCZm5Jd0ZoZ0Nl?=
 =?utf-8?B?dE1vRkJYR2IzNXVWeFA5b1hZalNpR1JWcEhPRkZYa2xiMEpUT0xDa1Bydmdq?=
 =?utf-8?B?QmxWQ1dFTGNWbUZwSC9hWExvZ3hNMDkrOStDQStybEcycFBGczgwaC9yN2tS?=
 =?utf-8?B?dW5iSmtoQnlTTXRtZ2ZndVdZTThNUnBzSVUwNkM4dTc1NFlNZGhzang1L0FF?=
 =?utf-8?B?YisvU25wYUs1aDFtWC9IUmVqb1ozN3JFL2FRQWRURGhqT2RkdUU0YlZpTG55?=
 =?utf-8?B?ekpsemFPa2RkVWdBaFRBemdFUUVRZ3FZNE4wenA0dnNmMy85SmV2TDEzK0lO?=
 =?utf-8?B?UkFyUWliaWNXT0UzV3VFYUhmcGJ6ZDJaY1ZkcXU3WnNaVnkwSDNsd3ZaL0hU?=
 =?utf-8?B?MjZMNTVscVdaV01leDR0MjJoL0VvMmZCSVhOWTlnNFgwZjhxbVgxZ0FabnVV?=
 =?utf-8?B?Yys5SERuaUhEVVJFZGRkam5Ma1VycUFRdWpBZVM3ZE9Ta0h0VG1Fb01abVhW?=
 =?utf-8?B?TzE1S1pyU3M1MmlLUEhDWDFCVnJHQU1kQnBieHJvaGhzUG8xTVVROWp4WnlG?=
 =?utf-8?B?aFpCOGhGL08zalhLMW1zNzhxTFc4R1FPaUFsaytGNWo0SnhlUUVvbGNvTFd3?=
 =?utf-8?B?MVMrdzJZOVRWeGl6aFpSTS8zY3JwTGF4N1RGbmtsWXpOMklRc080T3B0SUZ3?=
 =?utf-8?B?OFVqc3Y4UzZtbFBsUDNXb29JZUZXYWZnZm52OHBXakVJK1MwaWhmSm40Ykxo?=
 =?utf-8?B?RVpYMTlCU1FXVVFLcDIxQXp6QTQyaHZkTmhkd2VJV3V3SFNCeFlHcWFNZ0Zz?=
 =?utf-8?B?TnZEaDR1RUpramxIeDZJcHl1Q3dmWkZoM0RZSzJoVGpFTTFNWVY3Q1FtdVpp?=
 =?utf-8?B?QU1XaG0rTnVsK0YyS3p1YS96VkRnbUJJVjJjL0JCaVVFVThyQlMrNktlQ29W?=
 =?utf-8?B?bWxHaXpPRytqVTgvcEJYbXRGbVUwODJZTjUraVJJdU1nYUJHQzVhamZyT2l5?=
 =?utf-8?B?QWlzMWVERDdYdzlGS2U3UmpobXVvVTBaOHE2WUpyOFZpdi82TGhCbnFBd1Mv?=
 =?utf-8?B?cmhkUmNLY3ZyTWZKeFBlUUtRUUtoR1lIdFgyYk5KZDdNSTFUc2FOWkdORE9q?=
 =?utf-8?B?OS92eDhxTlNFS1U0TjJsbjM1ZE1INWJXSU9XYTdNRmcxVWQ4cnNhaXJtS2RZ?=
 =?utf-8?B?UVNueU9WNDJKMHBuNW1TTFZncEIwSXo2SUJ0ak1QZjBXMTBRT2dzY2VUdTFi?=
 =?utf-8?Q?/33OS0fpuCNvF8Sba4Rpn/X36yEI1phH/6S+Yx/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEFKb1RScmlFTHRnSXZVNGRyTThGcDFmZERaZGJIbFI0aDVjeU5TRTB6TFlo?=
 =?utf-8?B?eFQxd2k1N3NRem9nT2hEWVBNU0tnU1R1cTNIQzFhenBJRGZHRGdubFlhSUJn?=
 =?utf-8?B?NUtKVWxjTHVEU1VSVnh3eUkrNFNaUHZwQ2MvRDlFL0hwVDBDUWwxdTE0VEJa?=
 =?utf-8?B?VkF4QWk1WFBSUGRITlMvTCsxODFtTUJPUEdwMm5BOXFBR1NORVVrQm9XbUNX?=
 =?utf-8?B?SUdWMWZwNlE0K1Y1RHJFTXJNb0dMK0hEeTFmSG9EeHMwZzFmTGlOaDFFaHpW?=
 =?utf-8?B?UTdUK1pWT0JtMG9yZFptdUVaUndYUXJkWTkvMVh2eFYvZkN1V09HeG9nVFNQ?=
 =?utf-8?B?WjNWMlliNEpYUFc2d09qbkdvenNSSE90NXFNaFlZejFWU3QyVFJoM2tSQmFz?=
 =?utf-8?B?Z3VnSUxCMHZhSE5OeU1Zb3NCaG83Z1h2NERBZnF3cC93bHduZ1I3SnJxTTVs?=
 =?utf-8?B?T2NLNHd0RWtQWGZGZjg1djE5aUcvVzMzMkExSWJ5Y04yK1Z2NTlKOUoxdWV3?=
 =?utf-8?B?UGNmUVpGV01XWUJIS2ZXbDc1VG9RV2lVbzd5ZG12bm9RQlVyZ2ZaZkhVNTlC?=
 =?utf-8?B?Vkc2V2lEdlBUMnpjMWFKdWgyV0wraWtvOUhuY2hnY0M4b1orMjR6bUJaMVBv?=
 =?utf-8?B?V3UrQmxzSnFyMzg3bkFqTUZJdE5QT1kxd2U2UGVrOEpzeGRaQ2gxTk1Fa2VF?=
 =?utf-8?B?M1FvT2pLeXRqZFYvQlFOSHpYOWE4bmVFK2xSOGZlUDUrRkZEb2wzS0FUMEd3?=
 =?utf-8?B?V0p5K1BHQ3RwTTF5Qm1oKzJYZlFSeDlRSlFDb0xCZ3VkMGErRnd4dnYvVytk?=
 =?utf-8?B?bk0zZXJra0ZTVVRUQUNBT2JXRmZOMWZBWDNVWEhPUWhzYXNOZnQzSWpSOW1K?=
 =?utf-8?B?QnRWOEhJcU82b1VMREhTVWhEbXFIMC9Mei8wNDhoeXE1SVBCbUlYczJPR05Q?=
 =?utf-8?B?SmdCeUw0VXRjZEtWNEgza2dVYmNQSWpvR2NzV0VrcWxOZ1FoNEpqWkJSNmtW?=
 =?utf-8?B?cmc1SjRzcHlkSGFpbTd6U0Vza1FHTjQwbHVVcFJZREV3ZGp0aEgraS85RzU0?=
 =?utf-8?B?TkVKYkRWWmlRS0V0WlMvUmlSTEhZOFFZR05rU2pidjROYmJwMi90OGdHWUdz?=
 =?utf-8?B?STV6emVOWGdWaERnelVSblpuN3FEVDZUb2dqQ2NyVWxkYzBLemNBR3prc1Y1?=
 =?utf-8?B?QUJiaTVQUFJUSjNma2tUaHVxQmZyeCtOd0NETEZkYmF2YU80VkozRk5IdkNT?=
 =?utf-8?B?SDJEQUd4MWFodEM2REp1TCtGdndiSGc1Q3NnbHBhU3N2Z3hqWnFDam9MK0Rh?=
 =?utf-8?B?dUpQbjNGeWVDV24vUmVndm1Md2Q1aVNEczllc1BRc055WkJsVDFBcEQ0SUFy?=
 =?utf-8?B?ZUFtU2w0cDFqN3BPV2xmbTJnOFVXM3JSR2h4OG40QlFhcWRRSmdyY01pbSt2?=
 =?utf-8?B?WjdORUFTSGFqSFdaVk45OWl1bHM2dnFsTERyeXQwUzdoQk5TUFQvcFQzSW9v?=
 =?utf-8?B?eFRJODFkRVI1a05DOXhpaEpLSEZvY05OazZrZ2o1Q1pwbWJEb0JxaDJRc3h1?=
 =?utf-8?B?enFsd0JrRVJvd3dFUzJDU3M4a3VQN0ZDQkhtSjBtVEFyd0o5cGtta2VJcTdp?=
 =?utf-8?B?VXNhTmQzRWZaSTZYNGVoSHM5VXhyL2JQaXpEV1ZiKy9HMVBhckRkdEhYSUR3?=
 =?utf-8?B?cHVoN1A0cFdZOVVjN09rSHRDb1FvczlzaXZQSUpmYkFhWVVsaHlrbzNySmhS?=
 =?utf-8?B?RkN2Ni9rekxJYi9JeUNnQnFReWVIZFpRcGRtaWFSeHBQK3RVeW55M2dvUHVG?=
 =?utf-8?B?TkhkSStHM0tYUXkyaTFtNEtnOWxKTmh6cnBnZmdNdUtPRERKQm9TL1g0VVpJ?=
 =?utf-8?B?T0ZnSmdvZUxSWkJ1d3oyT0w1eG1aYVFUZVNpdEJnNmZpNXA4OUw3UHhGS25v?=
 =?utf-8?B?TmtPMU5Db0dxb00xWW1DR2cybFZ5SkhJSFBnOXlEdWt6U2VGRFhOTHhoYlNV?=
 =?utf-8?B?SFZVdjhPSWZ2ZFlpMFkrQ2JmU3g4VFdqYjFVYlIvQ0ZFYXlpWnU5UUt2SVg0?=
 =?utf-8?B?c2JmbmtYZkRkQjVhTWFzMDczUnUxbGUxNTVrZnFSbDZXcHZUMW9zMm5ITFN4?=
 =?utf-8?B?YWZ1aFFrcVhJdHJqb0p0aFRNTDQ3Y3RLMVhMRWdPcnNRYVAxekR3Z3hML0pv?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2b486d-8f32-4e0d-3865-08dd09714f62
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 14:40:42.7663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xa/AivhLJ6iFCzMYb59EtMihwvANBd9MIaRQqORTJiyFOWFrj2IrYfBFIkDDtkFK/2Kbjmx7eIHCfnf1tGX1VdU1i3KWtWUvLk4DLbwkbw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4893
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 19 Nov 2024 06:25:43 -0800

> On Tue, 19 Nov 2024 13:06:56 +0100 Alexander Lobakin wrote:
>>> This clearly could be multiple series, please don't go over the limit.  
>>
>> Sorta.
>> I think I'll split it into two: changing the current logic + adding new
>> functions and libeth_xdp. Maybe I could merge the second one with the
>> Chapter IV, will see.
> 
> FWIW I was tempted to cherry-pick patches 2, 4, 5, 6, and 7, since they
> look uncontroversial and stand on their own. But wasn't 100% sure I'm
> not missing a dependency. Then I thought - why take the risk, let me
> complain instead :) Easier to make progress with smaller series..

Sure, I understand. I wasn't sure it's not too much for one series, in
such cases, I let the reviewers choose :)

Thanks,
Olek

