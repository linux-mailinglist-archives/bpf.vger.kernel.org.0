Return-Path: <bpf+bounces-42634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 911129A6B2F
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 15:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A22282637
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 13:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1C71F8EE0;
	Mon, 21 Oct 2024 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLoBBExH"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3161C383A2;
	Mon, 21 Oct 2024 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519017; cv=fail; b=P5Y/WMgID8asf8mP/pK8LmT6ustNj09mMH+8hsTSaDznPNmymdhkB9QJtXg4Bt2YrA8Y5nVMDk4g4ACGz3J6xaLfMeSLliikukmki4b1r61JjOlfsVnVzkrq113+VvDIUAkekSHJrvB4rGZrYsQGzHdqxF9ylA7YBSPc94CeTig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519017; c=relaxed/simple;
	bh=YrIorWlx6T9BI4CHFllWYf3z8c/oIzX200suhBPLRhk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=leDkyskwezxxUxgqBOzrpiDZb71b2TjSEBpijvbiVSopNL1r3HTObXArI5fnEXQpp8lwT0jafI4kwY90rUz/w3/J13Z/c4LeAo3ldddBTDMoBvPzJyjwIFWIQOKRYT593a9ec7orVDs6MhAEEOUwlYeTkWhZ9RbfssVw4MLM5fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GLoBBExH; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729519015; x=1761055015;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YrIorWlx6T9BI4CHFllWYf3z8c/oIzX200suhBPLRhk=;
  b=GLoBBExH8xSgBVKQzfzqLYGqPv0pnm9MaqntVVytHpgg7/j2NnUhGE1+
   Ju6R9osflSNAQuIhzWx+6R/8BBy24znOYRDphyIhJ4VWWmt6GtfKoTS47
   B1kQ5lpPCYH3Z1Q1M4Ai5aX+m/PA/Bu9V6zCjnaHG2ejQZu6ksG2dnNWY
   86CWm8J2NKCR8iE45CTDqUCB8dK8ijI9bat3skeQWsUA/N2kWaAbCKVa5
   P7dqxZ7G8pHt+3ohflKaweXlVvtrhs6oj0CeZAyLDHDbGzV/m4sC0Lf1F
   ZEUW1fesjsBf1rR7jEjm9cg+ut3puNEN1Hcrfi8koLUMuIgieCkapR5C5
   A==;
X-CSE-ConnectionGUID: 0qSoWIOTRK27hNeRscDMDg==
X-CSE-MsgGUID: gzTYZQCVRYC6IdQl5cZdQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40128501"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40128501"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 06:56:54 -0700
X-CSE-ConnectionGUID: 8IOm6rdXQgmpwscg8q5TIA==
X-CSE-MsgGUID: hL1l6mtUR1SgPc9CNSKstQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79934692"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 06:56:54 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 06:56:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 06:56:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 06:56:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVh3NgHdOV/34vuqaQgJDbaRcS7pTKt4eFKSUC+2+mCmu1hae4xjTCWxhfYoJ14AmIOoi2DHyzTpknPBGjc0hHYI16dctMKRYEojn3QpsUgyBn44Ep3XdgZAdTL3QKSPWFhiuK/NV7CM9ESB818PafXeOjdslq7hco9wGkpiyad2LfKtJkiSCdq2HiZqnkPxN5kGJF5igZXc1lBLwPFVr94q2efa4Dusqgyqf2pXOOvG+SuBYP1QXmAlg2tUKJ8U8HXIcSUmemljUZriDqF87fFLiqu2tdWV3Tfq1Zr8HMIH/VPesdjY5hXpILfbgL4SM4dlRIwgHmEGEvtmWhGLKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUSuCoJuYugF9GZNmIBUr7tM1B0FVZesf6PL28IC4fY=;
 b=O7z7sTd7TmB+DDSfemOMTqyA3l2UPax8JQNu78zOGJvqcbDLM8GLgtCpxqs23FJw/LuGoO8u04oNXi86MTnFVqzeUfL0093oLggmiJJVoflBKB7KfLhDnUYo13UBappjWpBJ8XYGF6PyTcL7LYhZx2ob4a0DoyKRd9TJORFXnexJk7nk9et5+VYoMeGNlCRnnE7D2nDgm4q8+lybryzUhVtnO0q+kIyIio44L5bIaxlSVdDN6/cKEyeVslXVGGUHrBaQytQYVTbsEUyETkaNoL4D6DzyHrwLKNuMp8BRnSOsm0YwR46yxCqKZGK5Ady0V8Rf+StDRc+KIBZIVl4Qbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ2PR11MB8369.namprd11.prod.outlook.com (2603:10b6:a03:53d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Mon, 21 Oct
 2024 13:56:51 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 13:56:51 +0000
Message-ID: <8d1fe1cb-5f20-4a41-87b9-65adc6aa5414@intel.com>
Date: Mon, 21 Oct 2024 15:56:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 04/18] bpf, xdp: constify some bpf_prog *
 function arguments
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
 <20241015145350.4077765-5-aleksander.lobakin@intel.com>
 <ZxDxNisU45KrF80e@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ZxDxNisU45KrF80e@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0328.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::13) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ2PR11MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a69470-707e-48f2-2e98-08dcf1d83673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rmlqa0FYOTZ4b0ZYRjhWT0JJckJjV05DRHg2OGsycTZtdWR6d1NPeERlenBL?=
 =?utf-8?B?Z3ByQnpZaE53aHQ3bXJCWFJzK0YxUTZZRU16aUFQVTFiYW1KZ3doR21RaHdy?=
 =?utf-8?B?TnFmM1crVEwyR3F5SlFZUEo4QURLcGFIc0MxcFptbUZGVWoyVVRRSG0zZ0J3?=
 =?utf-8?B?bEwyeDJEa0loN1p2dVhNNVBxM1hCKzJiZC9CYi9TdHVyajZ6TGRtcVppR3JO?=
 =?utf-8?B?anpOak5Fb2JaQk1BMUpucnExbk1OWEFyVUJzK29hVEJRV1FTb1BsOExBdVlT?=
 =?utf-8?B?c29ZN0w3NDJjdFlILzZvQlF4cThXVVp2eEFPS0l2VzhmeStyS3lzNEJBTnB1?=
 =?utf-8?B?OFlRVXIwUms0NmUwa3FxTXFuYVpJSDVJNEtvMnI1dVdCNjJKQmJPYXdBN3pV?=
 =?utf-8?B?YkhLUUppbFJidy85eW9wdElEOGVCSFA2RENJUmVlQjh1WU4zWWZEYzJFOEtG?=
 =?utf-8?B?V0tvVkt3U2VRY3VPdFppN0ZUQXlaU3JHWG85ck1lYkFsTk96L0Q1Y1RJM0FN?=
 =?utf-8?B?OGEwckkxYi9Ld2RHYXNWRmkrak9rbkIzcmhGK0diOW40dnliTEVVaEI0UnJL?=
 =?utf-8?B?Vy83Y1lvQmJMVkZlSVp1ZFZIZzFVQ0dyNWo4L2p0Mzg0VWVoQVN6aFpyOHEy?=
 =?utf-8?B?YyttaTZ2TXhkM2w4WHR6Q0JIdEdlV1Vub2FiOUNkZnFsT3g2QlNnL3lja1dv?=
 =?utf-8?B?TWRYZUhWWmZyb09keGJ0Mi9pVHR3azJUUzF1TmRuWExSaHNEV3ZMSm5Jbith?=
 =?utf-8?B?TUUwTVMycGRVT0xjUlNwRFpwN1hnazMrSGRLdGQ2bU9nQzNBZThscFRMSnNM?=
 =?utf-8?B?VnlNL1R2MDFsc3ZQbG5vMFJkYWVneENicmhnUlFOUXYyOEk4K1FlSGt6Qzhs?=
 =?utf-8?B?RTkva041dldUTVdaNTZUazlwYUpmeFJudlRjK1dXdnJLQ2E4a1N2ZURTV0dH?=
 =?utf-8?B?R2dUVmFTVSthSWM4M1NkaDFZNXJtMjhFZkltakd2R0NpRWcwT1JVMHAxNmQy?=
 =?utf-8?B?VUZJaWlPTWo0bVhpUHA2V3BVR1BKL3Z6WnYrMFZoRktFZVhUSU5XWCtQZkFM?=
 =?utf-8?B?aGN2dkt2MHR5a3Nrc2o0QlVoa0FBN1pvOGppLzdvWDc0YVJveW5WYlJoUGs0?=
 =?utf-8?B?M3JDM0tVZkFhRG9qTnVBaWZDWFdIUmRuN2pZdGd4L205SEhkTFBWL0E0QVpY?=
 =?utf-8?B?RnJsaE9VdTlpL3N5U2V2OTNGRHdXUzBFbkZGTnBQbjFpZkp0aFNZN3BhVzZ5?=
 =?utf-8?B?WlR5MWNCbXpMN1FOQXhwQUQ0Rm5sOG40TjJVTENLUzdrU1NBSFcxbWJuVkZW?=
 =?utf-8?B?QjFRNTFxZjM0dWx4UzBwNVlpUDFQWHBSVTBFY2tDcnZWbzdaYXhsMXBmcm5Q?=
 =?utf-8?B?V1pKbCt0RlRHL0hFam1qaWJUbG4wa0FPMG1TY0lMaHhBdUtOYVV1T1dSZ2Vl?=
 =?utf-8?B?Y2Zhb20xNmpiOXBYTkVDaU5lOUJEaERYWVM4THJhTDYrempYWE42dkU3SStT?=
 =?utf-8?B?WDRkdlpCK0JzMG1QZHZEcjhqcVl1R0UrcnAyWWs4bW93NkZuOW1wUlRHYmJn?=
 =?utf-8?B?MEhnVmFrcUNlM3RCb21TRWhlUnlxR1dhamtPalNqTC85VUFZVm82dVBTOStO?=
 =?utf-8?B?enZLamNienhqWlhXeTgrV1pxTHhzNWVYUjg5RWQ5L0xMTVluNjdTOFRMTFZh?=
 =?utf-8?B?aEFkeHFZQks3Z1FZSTBhck1TYURXSDNQVjhUR3R5L0IwbHp1U25pNDZESTVv?=
 =?utf-8?Q?1pgCbsCzo8RyndorgxmaBjVZZmJsl2cGldt0L0e?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG1NdHArL21uZFpxMWN4eFVSRmhLSldDRWdhVHU1c0RWUTE2TlduZll0Qlkw?=
 =?utf-8?B?SCtRTHlPL2hHWW1RL1haSnZsTmwvNE1YcmtkazNLOEgyRTBDREFiTGV1dXFm?=
 =?utf-8?B?bElTYnhJeXo0WFNlSWNmekh3alQ2azdVSXlPZDVhUjJxdHZPeXBzT0VxdTRa?=
 =?utf-8?B?R0d2blZzNFJ3bkV2WXNGRDBCdUFRZDEwcGlQY2Y5bVg2ejAwQy83QUZIRElZ?=
 =?utf-8?B?aCtldi80ZzN2VldMQ2hKSERNeDE0b0w2TWVuNEpyZ3hQdG9SUFU4SGdTRG5W?=
 =?utf-8?B?U2MwMmVtd3A1MjZJaksxU3VTMnA0VER2Z3ovbGdFUWNpelE3QlRhZlFPRld4?=
 =?utf-8?B?K05peENkSWFuMWtFSXNhZW1rUVZZZGhzNGd0QWU3cGY0cHhwbml1QzRhaFhE?=
 =?utf-8?B?N2RPOXRjT2ptcmgraDNvNjVJN2tlZTkvSWhKZHJVVGNjaE5mYzBYRVJrNm0r?=
 =?utf-8?B?a01jKzhEUHhRNTNodUt2SU5rU0M3YjNEVmplbTNEcUVGc2xsT1NXT2JDVjMx?=
 =?utf-8?B?M04rUHRpemsweHFCcU5SanV4RFJlc0JvL1BvbHMvcEhrSE1laE5QQzlwTXVo?=
 =?utf-8?B?dFE1cml5ZTh0SGZ6UzkwOVJiWTZJMDBSTzllK1hyR2N2Q0dWT1hKRXJ3Vmsv?=
 =?utf-8?B?bnR3TkRBeThBanpnVldQSGNwZ21zSXdrUFJZRW85dEZMUzBUd0l3M1VCa21M?=
 =?utf-8?B?UDc3VU1PR2RENHFnNER1SHprdDhqNUVydWZ3a1hTY3RvdkgrRmFjVlN0R1Bm?=
 =?utf-8?B?L3R0L1BEa3JGSXBBV2dQVldqeW5vcVJzcld2R2hhQzg2aGQwTStmcWhYN053?=
 =?utf-8?B?T255andtalp5dWp0a3QyektwODZDa2I3QkgrMUdyZThqaVpOZ3ZMV0V1dWZl?=
 =?utf-8?B?RElmWWtiR1Nmckdra2o4cVNCMENqcVdvcWdJNFhvbzd6eXVpS3hKMGFnYzdM?=
 =?utf-8?B?SnZzOTAxc3JlYVdDMS93RVZTcER2MjdobkpxWGswVWozK2RNejdKZlVETWIx?=
 =?utf-8?B?b3RtYmlaSHRZYVEzWUIxelNYbHY1ZjliS0FCZy9EWnZWSld2TUtjaUFRMDZn?=
 =?utf-8?B?elpsRnBSWHQ2cEJGS2hZTTFYUnFRd0txaE45SDd5SENhK0pzRVZrUzlLdWE5?=
 =?utf-8?B?aEc4UHlidzZuQjNieGZtSjg0aFlKQ1FpSmxkbDlkSWtrcHJKc3I4QXl3ZjF1?=
 =?utf-8?B?QVIwR3kzbTk2cVFDL1ZHUWhydDZQMUdkVnZzU0dzOWZIdU4ySWpueHVLZWpX?=
 =?utf-8?B?N2UrSENiYklzQ014SEUvS2dzdHNEcDB1blhnZjRmRDFCTmZ6SzhPY1hHc01G?=
 =?utf-8?B?Y0wvcDdWMDBaQVI5NlQwREJvcVpvc2UyaHNYUE9iTUhMSWhDTG93Q0hnVnVp?=
 =?utf-8?B?V0RRZGczNGRBd1BQc0cvb2NtRkFEdWM5RXhxUHY3SURTRlROWllSYWpLZ2o3?=
 =?utf-8?B?Um96bkNqSmxBd1BUckc5Sm8vM3cvempiaDEwSzNSUWNzQlBVOWltQkczcGkv?=
 =?utf-8?B?Z2ZlbVRZS2NGb2xVTW5lM3FXRjhWaW8zelNLOHg5aWN2WThDdTg4WFprTGM3?=
 =?utf-8?B?eUlYbmVhSWtXSUdnRjZNc1l1QVQ5M3BGdjJ6bFFsd3lQdnZRVko2dDliOTVF?=
 =?utf-8?B?ZEVXeE4zTDJUNEVXYzIxVmFOSDBLZ2t5VGtTRldZR3dGYlhtelR4am9OWFRv?=
 =?utf-8?B?eDYybTFMK0JXbXpzelZNSjdYMk5FbkxXbHQ3azdPaGJpRzVCd25SZTRQTU4z?=
 =?utf-8?B?SnpoVThFY0dMcERtd2wrdXF2SjdvK1NWVnEvblFLRUxZMnlMaXQrc1Naait0?=
 =?utf-8?B?dUxrQU53ZENOUWo0ZnQrRmxJM2NnQlZJLytEdVNyaVd1Njdvc0RjZEV1M3Ji?=
 =?utf-8?B?YXJMOUdjb21JdkhIaGNyK1c0ZXNaTlVGNFl3U01tV1h6cG93UG56b1oxVXpD?=
 =?utf-8?B?RjFDdXFkWFpvR05OTnkvUUJmMGc2WXN3elI2QW0wSGZFUHhTMng5emxoMnl4?=
 =?utf-8?B?WXBzejFNdFdaZnVTYlE2Q2RLS1NLc2JodXFWbTZQTTlab3RSR3h3WFc5d09E?=
 =?utf-8?B?Z0JJdTBnMmQ3WXd5dDdraFRTRmh5SlUvVmVGYW5vb3B1U1YzL0k1QlhVbzQ2?=
 =?utf-8?B?T2hRZzE2S1pScFFvaXpPVmdVRDBWNkhDcGZXeFpmRjVqK3hzT05jZlYwcGZH?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a69470-707e-48f2-2e98-08dcf1d83673
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 13:56:51.1472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZWp2CMJm8So5iV5hJ/Wr8Jve9/jTohGP1Cnk+Hj0nZuvgnw3DuNEAjmQnaUOHwj2FncIoyCPUna9zQHg2nWHwvnVyT9SW+1XwXH1+MFSkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8369
X-OriginatorOrg: intel.com

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu, 17 Oct 2024 13:12:58 +0200

> On Tue, Oct 15, 2024 at 04:53:36PM +0200, Alexander Lobakin wrote:
>> In lots of places, bpf_prog pointer is used only for tracing or other
>> stuff that doesn't modify the structure itself. Same for net_device.
>> Address at least some of them and add `const` attributes there. The
>> object code didn't change, but that may prevent unwanted data
>> modifications and also allow more helpers to have const arguments.
> 
> I believe that this patch is not related to idpf XDP support at all. This
> could be pulled out and send separately and reduce the amount of code
> jungle that one has to go through in this set ;)

First of all, this series is called "core code changes".

Second is that without this patch I simply can't introduce libeth_xdp in
its current form, as in some functions I pass const pointers, but here
they won't be const -> compile-time error.

Thanks,
Olek

