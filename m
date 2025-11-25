Return-Path: <bpf+bounces-75482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FFEC85FB8
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 17:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583AA3A92F4
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 16:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B825328B7D;
	Tue, 25 Nov 2025 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gzvi7iQD"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F1D1487E9;
	Tue, 25 Nov 2025 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764088301; cv=fail; b=Xv6XQQmRYInmvu+tfPQBcEH4Y8eDpZQv+f6GsLwilyxn/54Vl7C05NX4FywdBl+wbZR51yiF1E5J/9CQ+DP79hA0v2FKEFgq/DaeVvYjF+Pta1bX2nQFN6HWNzfDXHBPjjwGOep/e5F8oP13WodbK8RasfLRJLQm59GgrzN5QDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764088301; c=relaxed/simple;
	bh=+DuxkAXABH2o/jpAdWAR3Egk5cfebVw/fZC2TEmE4cI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tuokyIybjd9y5ddZcsb2+KLtjmt6mqcMtek/kt7YduVFnFk9Tn20JH9p21TW64jMol6XpHz914HETFncKXeWlDiljZxI9Co7yxBPy83Xk1KZM/5eVz+l2DZuXIylseL67y06z4S90OAvlaB9UBzqvt+TK0LpE84DihUdkyt4aJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gzvi7iQD; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764088299; x=1795624299;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=+DuxkAXABH2o/jpAdWAR3Egk5cfebVw/fZC2TEmE4cI=;
  b=gzvi7iQD7Y3hRbcZ3rI+5KklC7jI9kZfNHEy8ccnGUe5+aeQXuX5QImd
   /SfkP//HKYZl7YfCyJvydNpDSofg++uiMw14Mbpf9idHoC8g1JKqP5P9A
   Kk2soDvstseRypDGAXHQMHYuUzDvaN0ZDQVoqk//P1CzCXrOnEtgP0TyD
   fwT3TXeo8Xy4LGnNEGALJ3QUS0Wl6P76eS2MBk48fUNRBrxJCEkA17Uvw
   Z+P4POiSFciX2Llr8ZIvITAzgthinH6vW+G9+GhZWgHHxZUhxAJgLFqZE
   q+eOHkqa1zCYhjQ3+btmgzSdPpsj9MSEYBruh3gKBRq41tcfFYmYxGedT
   A==;
X-CSE-ConnectionGUID: fRW9g35WThS8Y6fmFNkR8Q==
X-CSE-MsgGUID: FD0sHGJ0QH6eH3oxA4nd0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="68701681"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="68701681"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 08:31:38 -0800
X-CSE-ConnectionGUID: xwtUbbpNQwWJUu51ko9btw==
X-CSE-MsgGUID: skGL3UT6TEq1PXNe1pOQnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="197618405"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 08:31:38 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 08:31:38 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 25 Nov 2025 08:31:38 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.1) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 08:31:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWr0qzzunoPs82w2k1Oyzs0yT6Yz7DB8DqBl80LPgN4L5Rx8yfWaL8UudkeNJjzPWcmkzIOjx5wYl7UuEVu8tY3HFejF/8rp4eZmJmZ8Rb+QWx0i4owTos98keaZ2Nb2BEXIfULBXv2fx+issFv+/EK3CetLFnLEuJkGnODHL6fRj1/IceQ2uV1zRTr8mcX4NLtxJWmfhQMAIPTGhr/glVUk5j0nAC4SztPVIAmtm8CFCKCnWmmceQY/Yc2xVx7BaR7gQIQ3E+7bMuakTOULtPa8S+VAubMZhyenC8rk3HyjctxKNxf/lAPmdZBagYJCK6LBnA+7YwBKcW4sV2iYow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2NQO+bw8DpxosxTtTSkYY4jHkc1C/jXuAx7+FtAoi0=;
 b=gbFnr33atMlNAtqVwesglC+uSTuxIHZgcRQPj1r/brNQciDCje0At7Yp3M3VDBh4Cd0mDkMmDwXFpfuKp2hwh3gJxcyGxDRl89Zn3LQAShRdJlS23b8+S8+24LzXyIhf7Ucf/xu8bALFvJlnj2W5CzPp50EqPaLNTrmtLwfE21EVUxb/X27vzjpdJzYTxvBKjkGSM0E9eeCGgA14Pbrxs6/TgIjaz9Cvm4Mu6edNFs3RujccI5mP8T/+8BEgUTcZLGZIDte5qiJmBcN+LoobVC487mrYZROv7J520WHRUz9WbVKcj50QTPVqC8sf+oWEdGHlw+RQTQcM1eWI9Q7k0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 16:31:35 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 16:31:35 +0000
Date: Tue, 25 Nov 2025 17:31:27 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: Fernando Fernandez Mancera <fmancera@suse.de>, <netdev@vger.kernel.org>,
	<csmate@nop.hu>, <bpf@vger.kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <sdf@fomichev.me>, <hawk@kernel.org>,
	<daniel@iogearbox.net>, <ast@kernel.org>, <john.fastabend@gmail.com>,
	<magnus.karlsson@intel.com>
Subject: Re: [PATCH net v6] xsk: avoid data corruption on cq descriptor number
Message-ID: <aSXZ37i5CgGKn2RF@boxer>
References: <20251124171409.3845-1-fmancera@suse.de>
 <CAL+tcoBKMfVnTtkwBRk9JBGbJtahyJVt4g8swsYRUk1b97LgHQ@mail.gmail.com>
 <955e2de1-32f6-42e3-8358-b8574188ce62@suse.de>
 <CAL+tcoD83=UXpDaLZZFU2_EDKJS9ew2njLmoH9xeXcg5+E3UDQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoD83=UXpDaLZZFU2_EDKJS9ew2njLmoH9xeXcg5+E3UDQ@mail.gmail.com>
X-ClientProxiedBy: VI1PR07CA0222.eurprd07.prod.outlook.com
 (2603:10a6:802:58::25) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA3PR11MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 334676be-3437-44b4-8707-08de2c4019d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnBsbStaSCtONzNjdzk5MW1vRCs1QTlCclRicXZhTE0rZCt3R3lRZEd0ck9Z?=
 =?utf-8?B?TDFZUXVxcEphUVd5enBlUDllTVNQUi9kMVZJenhMUk1LVmtESUZHRGhWT014?=
 =?utf-8?B?S1dMN3FtRVBsMjNsbksyQmluZ0pWN3VNelJFTnRaSHpJSk96ZGQrTFl0enRp?=
 =?utf-8?B?bjBLK0hsYm16cGZwZlhoaDdoVEhhVW51Wk5BU1NLazhyNTJZWllTbXF6dEx0?=
 =?utf-8?B?aW5TVnlCTWkxQko3S3dLbkcwSzdEQXpwUG5ydDdsSXlyV2ZoakF1VzVvV1J1?=
 =?utf-8?B?L3FqblNVUi83cEFDUTZ4UTFtaDB5cHpWSDBPYW9UbEVIRm5VQms5UGIvQ010?=
 =?utf-8?B?TCtCeGlkY243MmQ4Wlk5YnVuT0FjQVFENG5EWnlGNmt0QUNtQ09qYno1YVZ6?=
 =?utf-8?B?RC9hU1I1ZGgxaHlteUR0aWJGS1d6NFBxa2lWU2ZPZUM1OVVjcnJOL0VWMTAx?=
 =?utf-8?B?NUVyM2VBK3RxMnpUOS9QdXR3ZUpnMW5nUDh0eTlHUXJtMkFyM3h1SldkSUhT?=
 =?utf-8?B?Y29zbDZTMitnSm5SSDdGS2VCOEQ3UGJUN3dqZzZYbGRTeXE2MS9UZ0xDcE1S?=
 =?utf-8?B?RytpbnJUQ2RPYmlSNjNxK1BKbzNFOGFmckplSlFuaVFIQm84MGJvSVgzV1Ez?=
 =?utf-8?B?Vk9KYy8za2NUWjRJM2VNdHlxbU9yVlhVSE1LaUxHaGVJN0lvU0VSUm5Na2sv?=
 =?utf-8?B?SDdha3piY2x2Zkhldm9rclhFYW9JMnNNakJOVkNMSE9HV0hLOGhsQk1XcWdB?=
 =?utf-8?B?OXZSL1A3T01BMVFESHF0bUVBM0hwdTFhemI1TndhbGtabytDd3d3WnFJajVw?=
 =?utf-8?B?RzJJWGI0V2c5ZkdKTmRxcGQ0dUNSUS9hK3ZzMFlBcS9MdnFuYXYxVkljMm5H?=
 =?utf-8?B?QUJTNXJxTDJFSDNlTGs3aXpmOHhXdnlDSCtacmQ5aEFaL2RwS0pzSTI4TDhj?=
 =?utf-8?B?VTY0VWJxN3R1YXhWQ1plelBuQ0Q1MTdiT0d6ZVBnM1dPZE9IUzRtM1UrZWI1?=
 =?utf-8?B?NDcrMldXU3lLUzMwcCt2bFRlckRaMVk3Yi9iZ3RicEdTQ0RuaXNwSDFWSzdx?=
 =?utf-8?B?ZWRCRWt3TEEvamp0V3p5MEFTdEQrNFEyNm1hVGNQSjk5V1lLNlh0TjJsYytW?=
 =?utf-8?B?TmloaXlmcTBMVGg5R3F6Z1poR1FCRUtsVERZT250YklSQkJIR0lOQlpxYXJO?=
 =?utf-8?B?ZGtyeU5QMzE0bVl1b3kxYTBBbVpvcUJ4dlByY3RRa3E0ZzVtbmhDNms2Y0o2?=
 =?utf-8?B?bG1JcHk2dk9FUzdHc0F4NVl6Zm9TTGU1Rk5NYzFpUlFmd3R2aEN2RitRRGFv?=
 =?utf-8?B?Slp5SFFEM0JPbFdyMTFlbjJQRXV2ZGVNMG96cjRGUkVZc01xaEVUZFRZS2Jn?=
 =?utf-8?B?VnVzMDFSTWs0dGlPU3A0YTFtaUZZTlZzOUZKWXd5RzdJbXZRM1N0cE9JbUFJ?=
 =?utf-8?B?L2s1M3dRS3luZmtaWC9rZ29teXlrVnhLVXdSbVZSZkFSdFg2WEdVdi9ScjFh?=
 =?utf-8?B?OC9xNENCQU9HSXJXMGR0M253R1NTcmJjREg3cVBGSVdmUXMzZHFQNXB1Qmw0?=
 =?utf-8?B?Zmx1Y3N4bHVETWU3aTZZL2UrT2tuWE1xZkpQU3haQ3VyWExQZHA1dHVDTVNK?=
 =?utf-8?B?WkpUOGZWb3lmbmxySlpCZjUya3dwNE1mZm4vWkh4aGh0MkQrbCtBTlZmYm1n?=
 =?utf-8?B?bjZpZ2h5dnZURFRVWHloUkdUck53MHBkeFFXQTR0dXl1U0ZzbW1ldytwR000?=
 =?utf-8?B?ekJoRnVicFFvOUltZHFkOXdSaDJ2NEQ5cXE0d09WWUhjL3pDclJsUkpLYTlw?=
 =?utf-8?B?VG1BSHVQc0d6K3A5WDBkUDhJTXVEcE9jZWhaa0lWS2ZFSEc2alpIM0ZFdDM2?=
 =?utf-8?B?NjNWRCsxTnhrU212WlVDeFg3bXNEVUdXdVc2ODBWYUJmMGVUUm9IYXpBZkZK?=
 =?utf-8?B?a2JXSGI3bmVLYVFkQ2d5OFZtc1dhMU82ZUlUZ1RBOVB4dVlTT0lGWHNRbGd1?=
 =?utf-8?B?blEyeElLaWJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmNENU5qWUc4ZjRsYTJ4OG9PTlNKUFRHdTlxS0dBMUQxUjcrWFlnR0l6ZUls?=
 =?utf-8?B?a0ZacGRJUjFxMjgrUXdNR2VacXVuR2xSZTEvM1M4ZnpreXFUcW52MFJKaWp5?=
 =?utf-8?B?bktESExNb0NPdzgydGdBZVRwTXpidU9uZG1WclR6TTQvbmthdWtsZnFTZnBG?=
 =?utf-8?B?TkRiN3YzU0RUR2dwYnpqemRKU3MrcXo4NVN1U3FTSDJRaTROTnhBZ2tNWDVz?=
 =?utf-8?B?YTNzUi9JUGRBc0lzTEh5ZDZtTjV6ODg0MktjVGVPZXlidlhUUWkxSjdQdVlO?=
 =?utf-8?B?dGFxSnovcHRQOHFRaFdhMXN5MnhnNUdmUXM4LzBJb3EzQlVsL2F0UmhBL25O?=
 =?utf-8?B?Wld6TDVYRkt0NVBmNXM0Q0hQWjRXVTEyWXFKdWFCdnRieCtIL2ZwWXdEUTBK?=
 =?utf-8?B?U3JSSUZ6SDUvU3JBNVdMU2JMYTlnV3BDUXFTQURNQ0JzdHB0K3hkdGFpZmc1?=
 =?utf-8?B?VTFGeVNsdXBLUE9JbHFyaThDSWtBM1ByaXdPVEhiUzhuc2JnVXRTK29EeHNV?=
 =?utf-8?B?RDRQWXlTSmhrSzRWTEtrNW9DMEFxeTR2UGdQWkNRSkoreWk1YWNOZFZIak1x?=
 =?utf-8?B?M2NiUUlFd2lmT2JpZkRTK3JRZmFVNVpTaW5HcUU2cTdOSDE4cHpDejJBUDNN?=
 =?utf-8?B?S083dTBBc0JRRTg5OEx1ZEJJVGNBVGhiSENaUkJqdEVhdStSSDYyeWk4WEVE?=
 =?utf-8?B?UFZhTjczdlZaN3NQU28rK3l2T09xcStya28raWZnWnNJZk80RVIxMlUvY2NU?=
 =?utf-8?B?ajh0YUx3V3RwenJmampvcXBOaTdzc1lvbUJMbnZGUUc3ZUZqL01uOS83VGx6?=
 =?utf-8?B?bTg3c2llSlg3RHBJMTdmdDV4bjJIRUc3TDVMbHlUZG9ZY2Jkek5rTE9oWEJu?=
 =?utf-8?B?cDFtT0dtSzRiL1NvNVdMN3o5eWJ0MVU1cXZGejN5bGFmSFJGYUFBY0hJQ2wz?=
 =?utf-8?B?ekU5WnpQNElTNXYweGdMYjBHbVc2dWFJQTNOMHZjaytFbktMMmp0cWY0RVZH?=
 =?utf-8?B?aSt0R3loNi9RSTlOMHNJVlBmdjJPa0N1blpsd3pPR3J0L2tTSUcwY2x0aEMv?=
 =?utf-8?B?dTZzd1hxWVgwTnJwVjRJTWF0VCtockFYOVVlZVp3Y2diVHV6WU0zNjN3dUNz?=
 =?utf-8?B?ajF5T3cxcXduMUNlblM4L09SZWdQeUdIVXg1am1Yd2FzTVZZYXh5czhTQ2d2?=
 =?utf-8?B?aGxHQ2Ftc2RPV2QySjcrbWxqVSs3SXVFYUUzSEpnZkRyU3J4MEx0Uk13aUtF?=
 =?utf-8?B?MERFTDdwSHZHUDkvdTRqOUIyYUxzWEg3Qk1NbVJpNFhPNUxYUkxycFVoNkhn?=
 =?utf-8?B?bE5xT3VpbUM1OTE3N3FRWUFIMFltb09YZnVPM082UndoV25tUGNkVkFJZE9F?=
 =?utf-8?B?Vk9FcjhlSUtBZGw0eVdlOUdQSDIzMjJZWDBoZ1k0MFRBdFdxK2k0dnhJUnY2?=
 =?utf-8?B?V21LdlBrNmprY2p2MWFiWGdNVnVNT3V4cjhSWEFUcUJwbnF5eWxsa3BQRXBz?=
 =?utf-8?B?THRXWWJQN1hPNGk3emdKQ3hLeW1Pb3BPT1VOYkIrRi9UTGNhKzJpdUJPSk40?=
 =?utf-8?B?RWJCaGJkdlBFRUVCa0k5M1U2UkZOWVFRbjVVK21QY0luN2tmN0lSV1Z3YnJi?=
 =?utf-8?B?MUIvczBZSTN5WWlkLzN6cGZrbWFZRWx6NkZvVGdydmhFMkRVODdTa01Kay8z?=
 =?utf-8?B?V0tKMCtMNUZpOXZmV2NBWmFLT3FaNU9sdHJzUW1aRWVMWnAvYklxU2tPMlph?=
 =?utf-8?B?d3c4bWxHWkFTeWN5eXF4YmdIdGdyV0NLbStVVzgvM3l4VDVGbFUxaGM1RjE5?=
 =?utf-8?B?c2tqM2dxdXFHNDh3bFJqeG5ZMkxlZERRTmJTVHdBTHBocHl0a05vSjJmeEp4?=
 =?utf-8?B?bUJKUE9uYnZTeEhBckVNenFkZStvU1F6b1NNbXk5U3ZYREE4OEFLZVowVjZU?=
 =?utf-8?B?enNmZGdGT093UWw1VzM2STFERGxZYnR1SFVHcUsxbjNHbUY4dVNacFd2ekwr?=
 =?utf-8?B?Q3dhNFBSelhKQWYvWTFQQlVDdHM2andJZHpTZnUyMzVtLzZ0Uy9IbWxNcnR3?=
 =?utf-8?B?bUdMVlhSd3VkcnRVUVBPd3UzbzB1TC9hQTY0b2NkVU1sUjk1WnkvV2x0OTE5?=
 =?utf-8?B?L3creGxHQUdLb2Vtbzl2Njh3T1g0UDFmZk9Qd0U0bUtOSXNPaDZHcE1xQTQz?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 334676be-3437-44b4-8707-08de2c4019d2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 16:31:35.7343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARdup5qmw1g9dfPVrmB4hZjDPq1cX06DY7DmUCJ2vah948Vj14zYHP2UT9TnlGbViKf2CRELjlsJ2RQafzMn+gzj7syoH0+wq+ivKHKWGoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9136
X-OriginatorOrg: intel.com

On Tue, Nov 25, 2025 at 08:11:37PM +0800, Jason Xing wrote:
> On Tue, Nov 25, 2025 at 7:40 PM Fernando Fernandez Mancera
> <fmancera@suse.de> wrote:
> >
> > On 11/25/25 12:41 AM, Jason Xing wrote:
> > > On Tue, Nov 25, 2025 at 1:14 AM Fernando Fernandez Mancera
> > > <fmancera@suse.de> wrote:
> > >>
> > >> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> > >> production"), the descriptor number is stored in skb control block and
> > >> xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
> > >> pool's completion queue.
> > >>
> > >> skb control block shouldn't be used for this purpose as after transmit
> > >> xsk doesn't have control over it and other subsystems could use it. This
> > >> leads to the following kernel panic due to a NULL pointer dereference.
> > >>
> > >>   BUG: kernel NULL pointer dereference, address: 0000000000000000
> > >>   #PF: supervisor read access in kernel mode
> > >>   #PF: error_code(0x0000) - not-present page
> > >>   PGD 0 P4D 0
> > >>   Oops: Oops: 0000 [#1] SMP NOPTI
> > >>   CPU: 2 UID: 1 PID: 927 Comm: p4xsk.bin Not tainted 6.16.12+deb14-cloud-amd64 #1 PREEMPT(lazy)  Debian 6.16.12-1
> > >>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> > >>   RIP: 0010:xsk_destruct_skb+0xd0/0x180
> > >>   [...]
> > >>   Call Trace:
> > >>    <IRQ>
> > >>    ? napi_complete_done+0x7a/0x1a0
> > >>    ip_rcv_core+0x1bb/0x340
> > >>    ip_rcv+0x30/0x1f0
> > >>    __netif_receive_skb_one_core+0x85/0xa0
> > >>    process_backlog+0x87/0x130
> > >>    __napi_poll+0x28/0x180
> > >>    net_rx_action+0x339/0x420
> > >>    handle_softirqs+0xdc/0x320
> > >>    ? handle_edge_irq+0x90/0x1e0
> > >>    do_softirq.part.0+0x3b/0x60
> > >>    </IRQ>
> > >>    <TASK>
> > >>    __local_bh_enable_ip+0x60/0x70
> > >>    __dev_direct_xmit+0x14e/0x1f0
> > >>    __xsk_generic_xmit+0x482/0xb70
> > >>    ? __remove_hrtimer+0x41/0xa0
> > >>    ? __xsk_generic_xmit+0x51/0xb70
> > >>    ? _raw_spin_unlock_irqrestore+0xe/0x40
> > >>    xsk_sendmsg+0xda/0x1c0
> > >>    __sys_sendto+0x1ee/0x200
> > >>    __x64_sys_sendto+0x24/0x30
> > >>    do_syscall_64+0x84/0x2f0
> > >>    ? __pfx_pollwake+0x10/0x10
> > >>    ? __rseq_handle_notify_resume+0xad/0x4c0
> > >>    ? restore_fpregs_from_fpstate+0x3c/0x90
> > >>    ? switch_fpu_return+0x5b/0xe0
> > >>    ? do_syscall_64+0x204/0x2f0
> > >>    ? do_syscall_64+0x204/0x2f0
> > >>    ? do_syscall_64+0x204/0x2f0
> > >>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >>    </TASK>
> > >>   [...]
> > >>   Kernel panic - not syncing: Fatal exception in interrupt
> > >>   Kernel Offset: 0x1c000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> > >>
> > >> Instead use the skb destructor_arg pointer along with pointer tagging.
> > >> As pointers are always aligned to 8B, use the bottom bit to indicate
> > >> whether this a single address or an allocated struct containing several
> > >> addresses.
> > >>
> > >> Fixes: 30f241fcf52a ("xsk: Fix immature cq descriptor production")
> > >> Closes: https://lore.kernel.org/netdev/0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu/
> > >> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > >> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> > >
> > > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> > >
> > > Could you also post a patch on top of net-next as it has diverged from
> > > the net tree?
> > >
> >
> > I think that is handled by maintainers when merging the branches. A
> > repost would be wrong because linux-next.git and linux.git will have a
> > different variant of the same commit..
> 
> But this patch cannot be applied cleanly in the net-next tree...

What we care here is that it applies to net as that's a tree that this
patch has been posted to.
> 
> >
> > Please, let me know if I am wrong here.
> 
> I'm not quite sure either.
> 
> Thanks,
> Jason
> 
> >
> > Thanks,
> > Fernando.

