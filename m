Return-Path: <bpf+bounces-74998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDD3C6B354
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 19:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 8FBC128F97
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 18:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0950D363C78;
	Tue, 18 Nov 2025 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="buqZcho/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D92347BC1;
	Tue, 18 Nov 2025 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490545; cv=fail; b=kFyn6SPPyrTTlytps7PcKOq0UdWPMMg2EmNQsi2qht422R8D1KfO+fOfKQ6emv4on3kCtdrgf1ZKGz+/uLOU4nGeIQn7HFt2jyOTYZrAQOggCHQaYLX0G2EcKTFVkPY1KujxlzHCT74N+riXU3PbNwPgC6yPpfng2X+0D7dvyVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490545; c=relaxed/simple;
	bh=kLmJ5ox2Tp6M6sH48X1aHSRTO32cbEtIF1e6yHrkEjc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Iqe4SGvVR1ZawIJS53vAxscBC2aKDWDk8gIyL+BbA4kBehkDpofcX5DOSW/qen8kO9+p24iI+iUkAujULjygtau6BV1mcSN0Z+VmT3/qe/GIeHNQ22RvrtzkrONXKjTepA4fMIweXlN/66EZ3Asx4yCUBleho4DL2maPrzeRGqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=buqZcho/; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763490544; x=1795026544;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=kLmJ5ox2Tp6M6sH48X1aHSRTO32cbEtIF1e6yHrkEjc=;
  b=buqZcho/9qTNENOqBc1cEYmkc0331xTpiNdiOTULfiXMvYPkctoz6slW
   pqLXaVF5jFkTrg+YMi1q18w1UULr12g7l2vTlkKDibiErQjowMrp8wkuN
   4SUZas2gVnFsw6t90yTq+/nb5oJFLbKhFTM/uuMLK2tMz6npNiY2cZwUR
   b1A19aNSTS5qxGBGR/S9QOmbcRWpYcHzGhL/NaqeLGe3cR6ap4H2MNg+T
   9GyaJ59BeTeXoHf9H2AGIHp/LFeHosPfms9wAN3I/BFiSJdRASYVVV+Xp
   0T/DYXVxXwz/ebI08g88Hu1MLdeoEEXbdJYSGekKQDtxW83zmEpBnlbmx
   w==;
X-CSE-ConnectionGUID: gsxFNMlzR0Ct40S/OQH33w==
X-CSE-MsgGUID: 5nOFaTILSs2eQ5s26qZy8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76200825"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76200825"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 10:29:03 -0800
X-CSE-ConnectionGUID: EKtGOi6gTTSWdq+oNzyUmA==
X-CSE-MsgGUID: W/zREmS4RFOk9SdHp/EPmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="191257721"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 10:29:02 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 10:29:02 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 10:29:02 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.5) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 10:29:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9A0Ih4bwlMVdp2mnIbhvhX9eTeQeYc5CPkgZq499KNuadOmWEPirX8oRjmmJlSO+mdmRpdjCaCsDM0qMJMqW+vL9nJRnI27K9H3GG05JKVFP82GjXwltTcQscUaJihlW1M3pivCd7AoEyY7FmTiMMCxGUe6DLqLWxPoCgFWXrGI0deMwO/G0TWupx/9pEClfTHtqdxHuJXtgDs2+9MQIt05+KNXSK+53pI6S+w6dtCXXoUH+O0LmxrVVMLvuyRkuw2gSkhiOk2/zdEbDYLADFLOWRcmaweX5Ikd44RZuV2uENydbFPHkiJdd4d5XsPIHoWOr839R3OuZqoywpOdMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufJ+h0At3GYCoiuenl3nK1+Lbe8FJr75Kgx+4DAOsSI=;
 b=e00IvhysdsHSMrKSWFAakWi6Tekaddi6o2AY5ov5hBl4LNDwH9lcpVy1898lID8Y6HSU/3X8ZPovspQ+sIhpIHxxf0qq/tAM1NoDf+VfvEpChy5+csRSOl9roDTwwYH9YOVwXYltWjPEzB1FWpw/BARXMnKZkqvNProWfuZdyZ2lEcx+XTj4x5zhq+rqeJoeUW7vyo3m6vb9F5m35jk2jrQX3h3XKU09OQlQXYVHILfky5RV0GrQ3xnvCXSjTkbueiimmRn8Gb0Q3njlZiLeBfNB+nUuguNnDTjO7xqUgaAQa5dJI/GbOBgGZ/ckBSmrToQLzodTRhcpWs/Z1zPJEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS4PPF69AE895C5.namprd11.prod.outlook.com (2603:10b6:f:fc02::2b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 18:28:59 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 18:28:59 +0000
Date: Tue, 18 Nov 2025 19:28:49 +0100
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
Message-ID: <aRy64Wr2UBhr4KLF@boxer>
References: <aQjDjaQzv+Y4U6NL@boxer>
 <CAL+tcoBkO98eBGX0uOUo_bvsPFbnGvSYvY-ZaKJhSn7qac464g@mail.gmail.com>
 <CAJ8uoz2ZaJ5uYhd-MvSuYwmWUKKKBSfkq17rJGO98iTJ+iUrQg@mail.gmail.com>
 <CAL+tcoBw4eS8QO+AxSk=-vfVSb-7VtZMMNfZTZtJCp=SMpy0GQ@mail.gmail.com>
 <aRdQWqKs29U7moXq@boxer>
 <CAL+tcoAv+dTK-Z=HNGUJNohxRu_oWCPQ4L1BRQT9nvB4WZMd7Q@mail.gmail.com>
 <aRtHvooD0IWWb4Cx@boxer>
 <CAL+tcoBTuOnnhAUD9gwbt8VBf+m=c08c-+cOUyjuPLyx29xUWw@mail.gmail.com>
 <aRxHDvUBcr+jx49C@boxer>
 <CAL+tcoCPiDq807u4wmqNx+j_jMmYYzNVA5ySGmp_V5gDLYz02A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoCPiDq807u4wmqNx+j_jMmYYzNVA5ySGmp_V5gDLYz02A@mail.gmail.com>
X-ClientProxiedBy: TL0P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS4PPF69AE895C5:EE_
X-MS-Office365-Filtering-Correlation-Id: d1939e59-a734-4b69-6e00-08de26d0570a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTBxelU1V3REWWxEbkpjdlFjN2VqV3VLMlVyeGE0azl2akZhZmVHZnc3cElO?=
 =?utf-8?B?a255YVdXc3AxQysrZFhDb0pIZjNKTkVDTmZBd05JUGJtaWdOenhVenpDUCtI?=
 =?utf-8?B?TExhMUw5dTBFMnppNWMyaTdWTFpnSThTY3NpMXR4QnJlaC9VSXBOUSs3RjA1?=
 =?utf-8?B?THVxUVprOUxVdEVYNWlrQ2YzNFBSdzlqUGhkNmplRWdRVGRrbmV4bXlMMmRC?=
 =?utf-8?B?N2kvOUxxMDV4SGUvUndOWUxscSszOGlBblNQYlNBMUswZDQyNnhOd3hySHZx?=
 =?utf-8?B?azhWMEgrbHdIclE0QnZUSEhqZDljbVJPdjZQdk1kcUJsU096NWJWeUlHZUdU?=
 =?utf-8?B?M05HMitxOTcxMXhudXU0V0xXc0hpekg0WjNYWVR6bHFYb2J3Vjk1Um9JWnh4?=
 =?utf-8?B?T1l2aWRxMHFSTzJwUTgxRTgxenByT0FZUC9yLzZpSldBcnBqaWY3a1l0MmtT?=
 =?utf-8?B?UWpzbFR4U0JnZzZSRXBaM0syYnFGaHRGY1ZBU2ZiRWxHeVhmaWZ6eXlWK01L?=
 =?utf-8?B?TjROOVBBbDRnZ0t1bEp5SElEQ1RtZlM5c2tIeXpoUUgvaGxTNUpZU04zamxq?=
 =?utf-8?B?bGpZMkM5TnRzSFZ2b2c0SkRRYWdDRC9tdWlHK3pvNXBudVVyaHR2WG9TdVU5?=
 =?utf-8?B?RVJvZ2dXRFhPQVVSSjc4RGpJbE9QNEoyMklRM1ptRFRnVlBYWE9RNnlwWXZ1?=
 =?utf-8?B?RURPNjk3N2F1OUt2alBsNFhMQzY2QUZ3eTZ2ZkFUNkpUVHRMb1lIV0xRR1kw?=
 =?utf-8?B?U20rbFhhbHNMRm9OQ1hTS3dTcDJ5UDZlTGV6cGNJMGlRSTVHWHJ0OVFvVlpB?=
 =?utf-8?B?NkgwdmJYTzdPWmdzWU5nRjVKVUsxeFM4YnY0ZU56M1lqblZUZ3lweGJ4WjJa?=
 =?utf-8?B?T0Q0SEZ4Tk9Bd0ticU9CZUlzSXVqUUNsMFJvdElFbmlGSk9MWUdJRmwwMk9N?=
 =?utf-8?B?bnZBUWtQeGtIcE9FbVcyZWR2UU9YMTNXTWJHdVpRL2hCcFB6ZzdYVWxkTzhU?=
 =?utf-8?B?LzcxT3hWQzZZTXU0QjFkZ25OR1dHY3FWbEFSTVJweGw2dVVXOHBPY2dxbzBQ?=
 =?utf-8?B?cUExaHNCeUZjRWtCZFdXV3lwdGYxTVB2YUJVa2E0VTlBTTl2N3d4WlhTaEcr?=
 =?utf-8?B?Mi9xKzJ1ZkRNV003TldLejBjd0FpMW1GZ2RnRFAzbmx6TGJVUkEzajZ5c2Fk?=
 =?utf-8?B?bFhPa29nZG8vMTJIQmdQRmZKTXpYN29YaDAyRUh1dFR1akZFVGhXWTVGdXJv?=
 =?utf-8?B?akdQTWw5RG01d2N1dGdRTFl5MjlCV3d0NmNnWTVKUlhoNitRN2NwWXphY1BJ?=
 =?utf-8?B?b1JldzRMTHFQUmxlS290RUVMSi80dmIzRFBMWGdzQjh3bnVrbkVhWW15M2Vi?=
 =?utf-8?B?aW9paXdCclJzTjdWN3RCbE9qRm1ZTzNkQk9zL05BSzd0c3d1NHlmaDNMelVI?=
 =?utf-8?B?QU5kOC96eWRWZWNmeVN5WGYxbVlxNGFidTdBaTNDRWVNaWZLb2lmM2JMTHox?=
 =?utf-8?B?RjVKc01IQU5RYlU1RUJzNG9vZ2VlU2ZPOURyVlB3a3BjcERwREp5dTBUcVJ4?=
 =?utf-8?B?bTdRd2NMQjJCbFVWUHNqVDFaSVlpYXNFRDRDR2NualQwUDlLZTR4R0ZxVjdv?=
 =?utf-8?B?aW9pY3UrZ0p6OW1JLzBGUkFKRzBRREh0WXlLR3lZMTk5V3ovRkJrK0JKVnBo?=
 =?utf-8?B?S2ZnUGN1YVlDNWlINkp3ZU4vdE8zRFJCMXc5RnMwTUtFSk9mQW9sYkFyZXl3?=
 =?utf-8?B?dXVRREpYNExFektqRzNZdTUybW5NTEhVRVQwaEhkTlc4UkFiRkU1WElSWmta?=
 =?utf-8?B?cXMyVTlnb0hRcmFRei91WVQ4MUh6bzNTMVgrTFY4NS9EeFREY1lWZzRkVHYw?=
 =?utf-8?B?L20ybDkwMW9iNWtZMUJGVmlCcmt2VEtSdllDbUZQRTBUdDRtM1JPY2NkQS9X?=
 =?utf-8?B?a21KSlJxK1kyUkV2Z05VOUt5Y2hwVkliclJ2TGlFNm50ZnJuWUZQVDlYbEkw?=
 =?utf-8?B?VDFWdE0wWmRnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlI3OUxERWtxbkYyU1BjY2Zxa0VINFdUOWtDbjlSeFFjbUpQUnFtV1k3bGFR?=
 =?utf-8?B?STU2REdKVFBsUG1WTXVUT0FaWGFxcDFuM29nRFRMTjVoK3pPVFN5S2pnZDhS?=
 =?utf-8?B?bGhINVVMZkFPZjZLZ0NmWXFDYTFOSEJmSllTMG40MWZEVjRZWWs5TXJuRTZY?=
 =?utf-8?B?aUdjdThLcFc2YlFHYWdQSTAzcUJxS0VKUEdINjNncjNhUjBzYk02MnJPcGtC?=
 =?utf-8?B?ZVY3c05FRU9XVExadmRXTE8zM3V5ZkRNbTBod2VkMHJaUzUwRlpla3Blb2NY?=
 =?utf-8?B?KzFiMHpEY3QyV21wSlRudmVuL2tvY04rSzRCNzNiQnBHR002c1NIZVVrTUls?=
 =?utf-8?B?MmNtanFiSmlmSG9KdVpxUjZsSDdEL1FDTlFUZm1DeUtmRUlqMFRtZ1k5Q1pY?=
 =?utf-8?B?MHR3cDVTS2JJUnlFZ245K2NxV3ZMcUdReGhKRDRiWTFzUUVNblNORENLQ0Nv?=
 =?utf-8?B?ck9MVTI2akRwRkNMcDhGdDFjdThNeUJnU1ExZTFTVzZIalBQTDkyd25MbSti?=
 =?utf-8?B?Q3dLMU4wZHA0THk1eGJDU25ZcDVvaDZ3QThyNnY3RkZHVEpKOXJYa1p2ejNU?=
 =?utf-8?B?elpWM2NRcFdOVkllazNCTEVxb1hBWDVuZGcyY2dXbXdCbVlXa01wVkZPQ0xz?=
 =?utf-8?B?YzdRMkYvd2VUZ3N4ME5xaEN6SkVHejVjOStQam13MXgxb1J4NFNURzN0TVdz?=
 =?utf-8?B?VzBRK0Z1VFlHdjVYRUdTMzU2UW9oRWFnVDBBNlVCZFBRYW9CMkFDNGhUNm0w?=
 =?utf-8?B?eU5uR2gwbjNDQ0tSMUZMeUdaTzRIMHdnZWtIaU5WZkF6dDZaVE1HaWNHNXRx?=
 =?utf-8?B?V1R0Qjg4cDIrVGM0eGdFc3pVeGw5UjA1eUNyc0l0SjhSby9RNWMxYnpLTkFU?=
 =?utf-8?B?NHBYQStkbEJWZXJiL2ZSQW1FbmRJdGlKMGdqbml3cDlCZlNOVU13Q3dzT1dY?=
 =?utf-8?B?RXlOYmVpMklNM0MzbXNsd215Q3VDQmtPN0crZzJHSW01bTdrUWkwMStWSndQ?=
 =?utf-8?B?WFVQdlBseWtwdk1hWVVSLy9ISXNUam5kR29raEdJcjBkem9pUDlQaStrT00r?=
 =?utf-8?B?K1dEOEl2WFM2c2oxdUV2c2ZhRTBrQTQyNHVIaHJERWhkSUFnLzJwZjkvUDRZ?=
 =?utf-8?B?YUdpT1Btdk9NVWRFTDZxMSt1K0pmaXAvUUZlamZhOEVXT2ZKOWVIOXl5eklB?=
 =?utf-8?B?dTdma1lmSGxrVG83bWs0SjlZcU1LN0FIOWViN3RuT01qUmRJL3BuaUJacVM0?=
 =?utf-8?B?MGt0L0lOeTdBRnlkdUlFd0lHRVdFTzFrdFFEZVZOQkdZVzFjTVZ4cmdEM1c2?=
 =?utf-8?B?ekRGLzlZOC9FU2Z6S3FHZjVKSGZzdXd4K0lvNFRnVXRscFBZMUM1SWg3aXFk?=
 =?utf-8?B?eDdPdTZ1MXkxeEVxNVczYjViMWgwKzZUcGcrQVMxV1UrdkNoQ3pzUk4xOEM0?=
 =?utf-8?B?eGliQXRGdnViV3BBWlFFRStrZVZpRC9JK0xFOWZydGtXK1ZjVE9GeEFQMEpv?=
 =?utf-8?B?TjVpK3FycUNGQVNOTXI4WnZuQzdZWHl2NS9mNHBibnBqYS9QMjZldnVKZFF2?=
 =?utf-8?B?ME1YVERoTkZqUUtRa0FncXMrSXlNd1FWUnFyWUdHeDljM1JWSVVaOXZFc1cx?=
 =?utf-8?B?c0orWndJUEZ2cFpjUW53Q0NleHdoSVRXb1EzQXJFb0JhQUVpeHhoZXlPamNS?=
 =?utf-8?B?REpTRUUzeHE1Uk9tRDMwMzVLaC9PSjZrN0Q2Y3Fnb3IrMDdob1hLRTlTYWRZ?=
 =?utf-8?B?SUtEZmFtTmMrUTlkL2xIRmdrVnRUZG00N2EwZExVVlNGUkdNYi90QWl1ZUpS?=
 =?utf-8?B?Mmx1Vzkrb09DMHBtMDhKYUNKZWZKSCs4ZGcyWUNZUFBESTdYdUdFSUExTnUy?=
 =?utf-8?B?a3AxVFRGTG1lekdVTktJYXZDZm9aOUZZRGp3MGZkLytXMlc1WUFsKythMjJ5?=
 =?utf-8?B?U0R2ekExazFHRjltdU5nUThTM0VWS0ZEU0pWT3lYRkVWS2N2eXZZOHE0V0ZZ?=
 =?utf-8?B?Z3d0NW9UMmdzdW9XUDV3a0IycExkSCtWdzJDdGtCUTlvNm1VTjYyU3pYVzcw?=
 =?utf-8?B?a1ljNkNqMHhLVGJUbEI0YjZ6RWVHVngvTjZqVDM4SmRueHRET1hadUpKYVZn?=
 =?utf-8?B?N1BlL2xnRmExckxHSkw0WlJXcUczenRTWlE5SFNOTTRuMkhPbDhHL3A1dGsw?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1939e59-a734-4b69-6e00-08de26d0570a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 18:28:59.1183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPeKJgroLB5YyqQZSmjrqYz7r2cmcvgXYE/ZVbXq/5rTiUzuYPRov6Fo00L4tWo5d6gAffqGaIACvkFHqcu3h3u9Fd8K0p1X6H6N2wpf5tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF69AE895C5
X-OriginatorOrg: intel.com

On Tue, Nov 18, 2025 at 07:40:52PM +0800, Jason Xing wrote:
> On Tue, Nov 18, 2025 at 6:15 PM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Tue, Nov 18, 2025 at 08:01:52AM +0800, Jason Xing wrote:
> > > On Tue, Nov 18, 2025 at 12:05 AM Maciej Fijalkowski
> > > <maciej.fijalkowski@intel.com> wrote:
> > > >
> > > > On Sat, Nov 15, 2025 at 07:46:40AM +0800, Jason Xing wrote:
> > > > > On Fri, Nov 14, 2025 at 11:53 PM Maciej Fijalkowski
> > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > >
> > > > > > On Tue, Nov 11, 2025 at 10:02:58PM +0800, Jason Xing wrote:
> > > > > > > Hi Magnus,
> > > > > > >
> > > > > > > On Tue, Nov 11, 2025 at 9:44 PM Magnus Karlsson
> > > > > > > <magnus.karlsson@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, 11 Nov 2025 at 14:06, Jason Xing <kerneljasonxing@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi Maciej,
> > > > > > > > >
> > > > > > > > > On Mon, Nov 3, 2025 at 11:00 PM Maciej Fijalkowski
> > > > > > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Sat, Nov 01, 2025 at 07:59:36AM +0800, Jason Xing wrote:
> > > > > > > > > > > On Fri, Oct 31, 2025 at 10:02 PM Maciej Fijalkowski
> > > > > > > > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, Oct 31, 2025 at 05:32:30PM +0800, Jason Xing wrote:
> > > > > > > > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > > > > > > > >
> > > > > > > > > > > > > Before the commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> > > > > > > > > > > > > production"), there is one issue[1] which causes the wrong publish
> > > > > > > > > > > > > of descriptors in race condidtion. The above commit fixes the issue
> > > > > > > > > > > > > but adds more memory operations in the xmit hot path and interrupt
> > > > > > > > > > > > > context, which can cause side effect in performance.
> > > > > > > > > > > > >
> > > > > > > > > > > > > This patch tries to propose a new solution to fix the problem
> > > > > > > > > > > > > without manipulating the allocation and deallocation of memory. One
> > > > > > > > > > > > > of the key points is that I borrowed the idea from the above commit
> > > > > > > > > > > > > that postpones updating the ring->descs in xsk_destruct_skb()
> > > > > > > > > > > > > instead of in __xsk_generic_xmit().
> > > > > > > > > > > > >
> > > > > > > > > > > > > The core logics are as show below:
> > > > > > > > > > > > > 1. allocate a new local queue. Only its cached_prod member is used.
> > > > > > > > > > > > > 2. write the descriptors into the local queue in the xmit path. And
> > > > > > > > > > > > >    record the cached_prod as @start_addr that reflects the
> > > > > > > > > > > > >    start position of this queue so that later the skb can easily
> > > > > > > > > > > > >    find where its addrs are written in the destruction phase.
> > > > > > > > > > > > > 3. initialize the upper 24 bits of destructor_arg to store @start_addr
> > > > > > > > > > > > >    in xsk_skb_init_misc().
> > > > > > > > > > > > > 4. Initialize the lower 8 bits of destructor_arg to store how many
> > > > > > > > > > > > >    descriptors the skb owns in xsk_update_num_desc().
> > > > > > > > > > > > > 5. write the desc addr(s) from the @start_addr from the cached cq
> > > > > > > > > > > > >    one by one into the real cq in xsk_destruct_skb(). In turn sync
> > > > > > > > > > > > >    the global state of the cq.
> > > > > > > > > > > > >
> > > > > > > > > > > > > The format of destructor_arg is designed as:
> > > > > > > > > > > > >  ------------------------ --------
> > > > > > > > > > > > > |       start_addr       |  num   |
> > > > > > > > > > > > >  ------------------------ --------
> > > > > > > > > > > > > Using upper 24 bits is enough to keep the temporary descriptors. And
> > > > > > > > > > > > > it's also enough to use lower 8 bits to show the number of descriptors
> > > > > > > > > > > > > that one skb owns.
> > > > > > > > > > > > >
> > > > > > > > > > > > > [1]: https://lore.kernel.org/all/20250530095957.43248-1-e.kubanski@partner.samsung.com/
> > > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > > I posted the series as an RFC because I'd like to hear more opinions on
> > > > > > > > > > > > > the current rought approach so that the fix[2] can be avoided and
> > > > > > > > > > > > > mitigate the impact of performance. This patch might have bugs because
> > > > > > > > > > > > > I decided to spend more time on it after we come to an agreement. Please
> > > > > > > > > > > > > review the overall concepts. Thanks!
> > > > > > > > > > > > >
> > > > > > > > > > > > > Maciej, could you share with me the way you tested jumbo frame? I used
> > > > > > > > > > > > > ./xdpsock -i enp2s0f1 -t -q 1 -S -s 9728 but the xdpsock utilizes the
> > > > > > > > > > > > > nic more than 90%, which means I cannot see the performance impact.
> > > > > > > > > > >
> > > > > > > > > > > Could you provide the command you used? Thanks :)
> > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > [2]:https://lore.kernel.org/all/20251030140355.4059-1-fmancera@suse.de/
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >  include/net/xdp_sock.h      |   1 +
> > > > > > > > > > > > >  include/net/xsk_buff_pool.h |   1 +
> > > > > > > > > > > > >  net/xdp/xsk.c               | 104 ++++++++++++++++++++++++++++--------
> > > > > > > > > > > > >  net/xdp/xsk_buff_pool.c     |   1 +
> > > > > > > > > > > > >  4 files changed, 84 insertions(+), 23 deletions(-)
> > > > > > > > > > > >
> > > > > > > > > > > > (...)
> > > > > > > > > > > >
> > > > > > > > > > > > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > > > > > > > > > > > > index aa9788f20d0d..6e170107dec7 100644
> > > > > > > > > > > > > --- a/net/xdp/xsk_buff_pool.c
> > > > > > > > > > > > > +++ b/net/xdp/xsk_buff_pool.c
> > > > > > > > > > > > > @@ -99,6 +99,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
> > > > > > > > > > > > >
> > > > > > > > > > > > >       pool->fq = xs->fq_tmp;
> > > > > > > > > > > > >       pool->cq = xs->cq_tmp;
> > > > > > > > > > > > > +     pool->cached_cq = xs->cached_cq;
> > > > > > > > > > > >
> > > > > > > > > > > > Jason,
> > > > > > > > > > > >
> > > > > > > > > > > > pool can be shared between multiple sockets that bind to same <netdev,qid>
> > > > > > > > > > > > tuple. I believe here you're opening up for the very same issue Eryk
> > > > > > > > > > > > initially reported.
> > > > > > > > > > >
> > > > > > > > > > > Actually it shouldn't happen because the cached_cq is more of the
> > > > > > > > > > > temporary array that helps the skb store its start position. The
> > > > > > > > > > > cached_prod of cached_cq can only be increased, not decreased. In the
> > > > > > > > > > > skb destruction phase, only those skbs that go to the end of life need
> > > > > > > > > > > to sync its desc from cached_cq to cq. For some skbs that are released
> > > > > > > > > > > before the tx completion, we don't need to clear its record in
> > > > > > > > > > > cached_cq at all and cq remains untouched.
> > > > > > > > > > >
> > > > > > > > > > > To put it in a simple way, the patch you proposed uses kmem_cached*
> > > > > > > > > > > helpers to store the addr and write the addr into cq at the end of
> > > > > > > > > > > lifecycle while the current patch uses a pre-allocated memory to
> > > > > > > > > > > store. So it avoids the allocation and deallocation.
> > > > > > > > > > >
> > > > > > > > > > > Unless I'm missing something important. If so, I'm still convinced
> > > > > > > > > > > this temporary queue can solve the problem since essentially it's a
> > > > > > > > > > > better substitute for kmem cache to retain high performance.
> > > > > >
> > > > > > Back after health issues!
> > > > >
> > > > > Hi Maciej,
> > > > >
> > > > > Hope you're fully recovered:)
> > > > >
> > > > > >
> > > > > > Jason, I am still not convinced about this solution.
> > > > > >
> > > > > > In shared pool setups, the temp cq will also be shared, which means that
> > > > > > two parallel processes can produce addresses onto temp cq and therefore
> > > > > > expose address to a socket that it does not belong to. In order to make
> > > > > > this work you would have to know upfront the descriptor count of given
> > > > > > frame and reserve this during processing the first descriptor.
> > > > > >
> > > > > > socket 0                        socket 1
> > > > > > prod addr 0xAA
> > > > > > prod addr 0xBB
> > > > > >                                 prod addr 0xDD
> > > > > > prod addr 0xCC
> > > > > >                                 prod addr 0xEE
> > > > > >
> > > > > > socket 0 calls skb destructor with num desc == 3, placing 0xDD onto cq
> > > > > > which has not been sent yet, therefore potentially corrupting it.
> > > > >
> > > > > Thanks for spotting this case!
> > > > >
> > > > > Yes, it can happen, so let's turn into a per-xsk granularity? If each
> > > > > xsk has its own temp queue, then the problem would disappear and good
> > > > > news is that we don't need extra locks like pool->cq_lock to prevent
> > > > > multiple parallel xsks accessing the temp queue.
> > > >
> > > > Sure, when you're confident this is working solution then you can post it.
> > > > But from my POV we should go with Fernando's patch and then you can send
> > > > patches to bpf-next as improvements. There are people out there with
> > > > broken xsk waiting for a fix.
> > >
> > > Fine, I will officially post it on the next branch. But I think at
> > > that time, I have to revert both patches (your and Fernando's
> > > patches)? Will his patch be applied to the stable branch only so that
> > > I can make it on the next branch?
> >
> > Give it some time and let Fernando repost patch and then after applying
> > all the backport machinery will kick in. I suppose after bpf->bpf-next
> > merge you could step in and in the meantime I assume you've got plenty of
> > stuff to work on. My point here is we already hesitated too much in this
> > matter IMHO.
> 
> I have no intention to stop that patch from being merged :)
> 
> I meant his patch will be _only_ merged into the net/stable branch and
> _not_ be merged into the next branch, right? If so, I can continue my
> approach only targetting the next branch without worrying about his
> patch which can cause conflicts.

net/bpf branches are merged periodically to -next variants, AFAICT. New
kernels carry the fixes as well. Purpose of net/bpf branches is to address
the stable kernels with developed fixes.

> 
> Thanks,
> Jason

