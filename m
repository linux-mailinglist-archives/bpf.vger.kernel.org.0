Return-Path: <bpf+bounces-69833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEABBA37C8
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 13:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7312A6248E7
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 11:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1325299A85;
	Fri, 26 Sep 2025 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ui1d9yJO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5062367D7;
	Fri, 26 Sep 2025 11:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758885876; cv=fail; b=tsfN1bgIubzj0Vu878sfbaYtARL2wBZk7zfjHNHUMAcdKPbfRg4Iskw7L9FtsKMfFfgqCge/kU56dO5lyYvCrLO6eQpTE8RQ8NNB4HJm3n84jj794iNGTCA5ODZFHz7gfbqxGJdIMhr5FvrZpeGgJ0hOso4YudSa1btZPPCmPXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758885876; c=relaxed/simple;
	bh=n7FeJjOfZHXC3X3Wohw7VCfcmpeWOZgCL2qNgx5Fh2U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XuLamBDjnD6UyvnOc43WcVUS/fkWBblRmrv6dS8iDmd7ZD861sEEHQR5+zRcx/YYyM4DszDSbC7k8ttF+VzzX1IBxtjevUkc4QzM7ZRTwpLs8fZmVK3FLeJHEMrTQCYRAdF5xQuOv38gid2va2/J0lf96MV0Yd+X8XifCSEMWpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ui1d9yJO; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758885874; x=1790421874;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=n7FeJjOfZHXC3X3Wohw7VCfcmpeWOZgCL2qNgx5Fh2U=;
  b=Ui1d9yJOcBKii4RUMCIlTHx6oQ3QJByawsIGbU8xM4+Iu1MRFAPqUhat
   8020KcQ1GDaKyXqEh8a5akm4UIinoIgKw3lApDxV3y0qOAOiI3XsiqP9m
   UkDSCEsAIbbrPJUs0h4BbDHisnuLkrXqxh5QLBvg+t40tFTd6DJm250mT
   tdZZqGemHM7F0az8USY1MI4ByAR+g7iKXqoQGKsfq7//NznIAHXzlNdbS
   869942l2sRwIT+8RbzK/6PySi9ArvQkvv4a+R14N2hbwfclraKKr+uLgu
   QCY9dkrOzCde/4jx0+v0kTE4yFfhGkZffg2gQv5EZuljaFO+kP443HOv9
   g==;
X-CSE-ConnectionGUID: ++9aNKOWTCiQIKv/ecbjAw==
X-CSE-MsgGUID: pKZ/uiRUREqbERh4ie39cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="64848647"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="64848647"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 04:24:33 -0700
X-CSE-ConnectionGUID: LGnV/aArS8eN8Ex0fKBlvw==
X-CSE-MsgGUID: JqQX5cUBQvGDe14hynYMFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="177433215"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 04:24:32 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 04:24:30 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 04:24:30 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.30) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 04:24:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9lMPYO6MOq7QNvwucpygzRE1FdO7GRhze9NR1MZ00CPzn9odwI9NjELiKY7sCstmG/J4PcmJI/S0SVB3wXmnm8XpFr9p0tF1PK1Y9TGhKT7uGzOOPAWehejX3LwislgagffcIS4tkgtiM0qT/OR7obgPNrQLx+DcWhGSOTncB6+SWEbMh9Faw4W00iQMBg04ZX3wHWrOqy2VSgOwtYiMR4paPuEIR6qXrMtr08bMB5UVAPO9JRJSIghAmt+3cNQFAt/qtWZM+t46cJbzSgCZxDZkboz5amlfQ3NuUgVb2T7LS6KEhkinDJEKTqrzWHt6BhQrP9soeXksgDnVfsUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYu7hSaTIF7nZ0aGQk7pfui5N8aNrUmMCJ5z1BHxKvI=;
 b=go9HB3vSNaqT4lHIo41DePJeSjJvSHpnuAaJoFk9Qz9nTWtdlQNNNrX0FFCN/5k1/25G6xdR82p9zH8dH+PuThOQUOmHwQOlIfTO+ZMlE0V+RGkjsTa1L1V5NyeNubcQvGt5R+B6dXbzZemX8nM0bH6qpzHRqvw5etft/Gs5sDEIlOCdie7NeZpKZgpwdcnaKoou7zRv8HPReCJVk1mLSbCDNr6MfHGynXMlWJlcNsUJr4uBiDyg3jnW7luPabVqTN+6tMEDqL994KiHE97UA7ujeghJLi0oRNm6tB3qhCr11iijrRIQaT61kCHKaImjHQr+q6DvBfjBWbFO9agbgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB4781.namprd11.prod.outlook.com (2603:10b6:a03:2d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 11:24:27 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 11:24:27 +0000
Date: Fri, 26 Sep 2025 13:24:12 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Octavian Purdila <tavip@google.com>
CC: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <sdf@fomichev.me>, <ahmed.zaki@intel.com>,
	<aleksander.lobakin@intel.com>, <toke@redhat.com>, <lorenzo@kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>, Kuniyuki Iwashima
	<kuniyu@google.com>
Subject: Re: [PATCH net] xdp: use multi-buff only if receive queue supports
 page pool
Message-ID: <aNZ33HRt+SxltbcP@boxer>
References: <20250924060843.2280499-1-tavip@google.com>
 <20250924170914.20aac680@kernel.org>
 <CAGWr4cQCp4OwF8ESCk4QtEmPUCkhgVXZitp5esDc++rgxUhO8A@mail.gmail.com>
 <aNUObDuryXVFJ1T9@boxer>
 <20250925191219.13a29106@kernel.org>
 <CAGWr4cSiVDTUDfqAsHrsu1TRbumDf-rUUP=Q9PVajwUTHf2bYg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWr4cSiVDTUDfqAsHrsu1TRbumDf-rUUP=Q9PVajwUTHf2bYg@mail.gmail.com>
X-ClientProxiedBy: VI1PR08CA0206.eurprd08.prod.outlook.com
 (2603:10a6:802:15::15) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB4781:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e5c156-76ec-4cb1-0870-08ddfcef40c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGhhWTIrL1g4RnVXTG9sNWxkaDBWaDhxbG1pMmNNRTZmQ004eWc4Ly84Skt3?=
 =?utf-8?B?UVVJdEozNHZ1dmlTcTJEeThUdytKd0dod2dpTk1PUGdjSG5xNDJoZkxhWDVV?=
 =?utf-8?B?MFpWTHZpVlRrSkdEdndqMWJkMlA0ZFN0ZlB4QWo2NkV5Umgxei9YL0pXUlNv?=
 =?utf-8?B?bEtEMkRuQnIybjRhWFRDZUw5RjJsZnV5NUdQa1krN1JhOU9PZXNydkhYdjM2?=
 =?utf-8?B?TnFCemIxR2h5YzQ4OTZpZGRNdkxsaGhTbVJhdy9IZDJJWmJBNURtT2d2aGtG?=
 =?utf-8?B?Z1ZITHlrOTBUU0x4UWJUaVRxQWlhZmFQUmsxWFByK0s4Y2JJTFVKQ0paWGcw?=
 =?utf-8?B?eUt6NyswSllicGhWaDlTamZNZDY5WHBIa3hIQk45R1BCVjcxZXE4TFFNdGpF?=
 =?utf-8?B?ZDZWdHppaU1Nb2xYdVNRMGplQlpVSjEwako2UG1nMGVwbHc5S1ZyS2tRRUtt?=
 =?utf-8?B?ZnBZSTZxUGk0dDJaNFNYNkI1dVlBV05PWUJFaGs3cXN2NnorSzNVRUFlTFBy?=
 =?utf-8?B?VEQzdms1bGpQM0JyODQxZ3YzcEtYQzBKM3pLVzRDKy93OEZhaWFwalI1R1Fi?=
 =?utf-8?B?eTgxUXcxSXJncVIwVGVmdlE3MXo3OW5NS1FQSS9lMjFNZmV4Zmt3MzliNnVO?=
 =?utf-8?B?cEZRNy9iT0hXbFl5R29KWU9CZkFuc2hyYXZ1aGtnN0dKLzQ2ZWd4OHFmVTVR?=
 =?utf-8?B?M0R5dGk3cjNwNCtBQmRzTE0vNHhqQm8xVU1YeXJ6OE9sQ3J2L2FuN3Nndk5x?=
 =?utf-8?B?R1A3UW5qT3pkbm4zL1pmZm41NHBZQXorTWU5UjArZ0piVkNRSlZEQnVGOGJm?=
 =?utf-8?B?cDI3cWJLTUl4dWRwSGJ3ZkRTM096V3ppdFBWMTN3YmxPdGU5Tk93WDVMYi9w?=
 =?utf-8?B?ZDRrQUZTUkVxZ05tck9INzhEOXd5NWk5dzVIRkdMQkhiU25ESmxReHlhbUZJ?=
 =?utf-8?B?VWVZSjVpTjdvSzBieEhyNm5JVG1xQVc3Rjc0SExpYU1kQnRCbU9GUHpYdzVV?=
 =?utf-8?B?L2c3b3hHYjJqUi8wVXpoakYySjhRbDZGOUFudnFpOXBLYTE4WXNId09vU2dN?=
 =?utf-8?B?ZlRRR205QUUwR0dvYU9XdXFlRWl5T0p2NHNRZGdJNTRkZ0Q3NExwWi82Z1A4?=
 =?utf-8?B?TlJsS0E3bVdhWGRLajR6Q2cwZEphL0g1OVZseWVYOHM1K1Z2NEtzcHdMWFhz?=
 =?utf-8?B?UmhXS2dEN0JVdW14TFVOQjU3QytkcllVdkw2aTZ0U2FGUENpQjBuL0tBTnlv?=
 =?utf-8?B?N1ZQTjduL0E4MGZHQmpPMWNUR2VkYnBtdWI4R3hMUytLemtJM2tlR2s5ZE9T?=
 =?utf-8?B?OVVZNWVJSTB6d1V1ZTF3cjF6ZHdWcldKblJUbWZabDNScEFTdU10eU9HcW4r?=
 =?utf-8?B?VTFWeFErc3d4VVFFcGNYc3plUmdYeDVwL29yMHNPZFVES0hNSmQ4MXd5eEZF?=
 =?utf-8?B?Ym9JaStsaTRGVzIyZ1JDWlppb090cjJLbE14M2p3ZDZuSkpRL2R5d0pxK0pH?=
 =?utf-8?B?T093dXkwRmRsSFAyNDlHRDNxWWlzVHFkdEo5cHlXbjJQZFZLbFdhVTBUSENK?=
 =?utf-8?B?ajNIOVFTMW56bTJsTlFSaC9FZ1hWVGw1QkxJN3EzQkRSODZzSzV0M0Y0MG5G?=
 =?utf-8?B?WmNxeFBQemRTMFRFMjNoNTRJSFYweG1Sc2thR056anpTTkU2LzZUTzVDTzBl?=
 =?utf-8?B?T3U4TVpLczYwa1Q4MVc0eUhldzNGY0dadHk2dkRsYStPbTdsTEFHWXZsMGNC?=
 =?utf-8?B?aG1KNlNUL3lrdzc4THhHUEdDb3ZmSndMd2ZPZklxNndtbE5SV3VsNzNRd3g1?=
 =?utf-8?B?cFNaM2NVQVY3emRvaDMrL05uZE1MdG1oUWJiYnhYZmtqNzQ4SzJHMy9XLzRB?=
 =?utf-8?B?NXhhT2NlMk9jSXIrQTlCN0F0YXhyZFFrMjNiRXdwY3FQWXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3hGKzJNcWNCdjF5RDZ6SitwWVZTNFFkTER6dVpvRWV4Z2ZXY3pic24rUWY4?=
 =?utf-8?B?UGF3a1p3dmVCSlkyTllyRU5yUm9vaUR2c1JSZ3RwUW5SanFLOHJkRUx3Tzly?=
 =?utf-8?B?UHFlWUxvZEs4c2dNTms0ZXNadmlqcm0wZXY3cllxaGlaRnIzQ1dJc05ZUU5X?=
 =?utf-8?B?ZFFaUkhzUnNwVjhpWXNhMEU0ODZpQ09jUUZ2MDRTemZRU216T0VzWFh4ejFQ?=
 =?utf-8?B?ZlpZa2lhQld6UW5VSGVxQzFKMjF0RXhxd25CWFFnZk5EMFRPYmduLy9YcUtp?=
 =?utf-8?B?U05tTTNMbk1aakkwRTY1K2IzMThBcmVBM1U0NWRrMkRDc1BjS0FyRUpobTBO?=
 =?utf-8?B?MUY0amF6a3dtV1FvVVkwaHlwaEFTZmxjQmpEeEVOTlhxa1BqU1B0ZFh3enJ6?=
 =?utf-8?B?RmFwdGRRQUlnMEJ0dk9ucWpCbzZpRmxsVzd5OUJMc3B5aUhaM0RBa3pGV0hF?=
 =?utf-8?B?TC9lQUZqVVQ0RkpZUzdaL3A0Vi9OYkU5SHFTVEdFUVlXaHFNWTZJa1liUGps?=
 =?utf-8?B?cWZyRTZ2ZzRnL0pLOGN4dHhER3hEb2ZnbkZEMkhWVEZkcWcvVy9LcG91WGxI?=
 =?utf-8?B?TUkxQzNPUCtUZjk4emU4NVBFTnVYZW9PME9xd2hiaHMwZW5lbWl1aXFCbGNw?=
 =?utf-8?B?WHhWTXhEUkJ1NldUTVhOSklYcEhkVndMNDFYLytsYWtVR0R2eDFTaVQ2TElJ?=
 =?utf-8?B?RkZESDgzRmd0VTk2RlJITnF5SHhPTDBRS0k1ZG5pM2U2NldrOVVlWnNuUmpI?=
 =?utf-8?B?RzBMdUNIMXZQS0p4MXJKU3ZrazZCbXZJV3JMSjdWbVNzaHUrak5GWFd4dXlp?=
 =?utf-8?B?RHIrbkczUU5kVE13T0tobk81VEcrQ3BPT3oyaGYvSWhxRmI0cGltOFl0Mi9B?=
 =?utf-8?B?Tnh1blErWlpRUUViNE1CSXdHMmMybFBvTjdkTmtrVUNBRlVEOVhEZFVGUTB1?=
 =?utf-8?B?MUFHUjh1RWRsM2w4ak80WUt6RzFUWTlhOEpySFo5NFlsZlVRQUtiN0lKR2dT?=
 =?utf-8?B?cFhBZ3BsKzE5NGMxMnVrSlVoZEF6a0Fhb1FYRDlPOTVXTlpNbUcrSVcreU5a?=
 =?utf-8?B?SzlzUGlRNHJwMk5jY0VZQmZCb0hKKzZLMVE5MDFWOGhsYlJwS3pTRmFJZmhX?=
 =?utf-8?B?Sm5JSk1OUWFhTGJxQ0FyU0pURXRST3M5U1hCenpucVN6eW95Qk5iTzFjYzkv?=
 =?utf-8?B?V3BNMFFkWTE4a3BaNlNBR3JYbVhLUWt0QVBFanAzd2FJSjhmNjZ3UmtUVkpB?=
 =?utf-8?B?dTB4aDd1ZzBXRXZoZ0xKRU03ZXdmNnFlUFoycVZ3dXhrL010SXlKN3ByaXBE?=
 =?utf-8?B?anRLRytSQ1lxMmRSRW5odjBIL2dtMVlsaEl5YytWY1RwemV4M091WVZQM2Jz?=
 =?utf-8?B?SVBjVkF0RngyeHI4clJ3eXJFcHdqY3hqSmxJK2R3NGxpT2pWekxGNkdudjlB?=
 =?utf-8?B?TGhMK1hMUUZzMFNVM3EzNitlbWo4T3BTZW03TEl4em9CQnU3ZVA3czlBNDVQ?=
 =?utf-8?B?K0dlTWhXZ0dBNGQ3RjBnaHl6K0NiWmpxRlRRK1JWTnZtZXNTbDBJNmlwaGY1?=
 =?utf-8?B?dFppQldiTjhROEtia3BvdjdrMnFrTkp5ekRQekErc0dJNXh5QlVORFVKTGR2?=
 =?utf-8?B?YlU1MmoySGNReUFFWmpxaHlxREkvR0Rib2s3WWJZRHpHeVpHV3RHWXRtWEtK?=
 =?utf-8?B?eXM2ZVRhKzU4eEhOdE5KazRLWmtiWmwxejhQRnptT092T0dLeDRxUHkrRnMr?=
 =?utf-8?B?Tm01ckVlblo0aldQTDY3dzZvK29PekN2b0cvdk5zV2F2eXIwL2FtWUdoZXVy?=
 =?utf-8?B?dTFjdHZoaGNPZ3NEL3Q0VklVZkY5VzkrV0Z4K2h5UzQyUkpZdDF0TThKS3ha?=
 =?utf-8?B?Q0R2dUVqMlFJRWQ1cU85cURlaENDYkNyK1JKRkJSUnUwZ2dLc1EzVVAxTmxn?=
 =?utf-8?B?RUZaeFNZc2NqdTVLc0NSQnlHbW9jUFNZU2h0MUtPVWpLcGkzbERCd2hvalcv?=
 =?utf-8?B?WFl0enZMT1FEWUV2WDlvQnZzVEI2QnAxUnlFV1RyakQ3MWVUaDJVczdpQVFE?=
 =?utf-8?B?amoxa0lPTG0zUWx1SUc2cFNGYytmbmRNK2ZIY3BuNjc0RDlNb2RkYnkxRHBh?=
 =?utf-8?B?dDg1SGV3a2Z0L0xpRU1CTTlxYkh0TWluWWRBMWlSNWlsdS8yQXJTZHNjZG1H?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e5c156-76ec-4cb1-0870-08ddfcef40c7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 11:24:27.2609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJN7GV19IcGhJFtLjfy1rLHYexLo84zRmVjuN/QBqqT2ttdgItyrwB9fAu6eZNZS68spTWkqqdDY+wqeQZdrsmqa7k6X59DX7IJuGuwVqnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4781
X-OriginatorOrg: intel.com

On Fri, Sep 26, 2025 at 12:33:46AM -0700, Octavian Purdila wrote:
> On Thu, Sep 25, 2025 at 7:12 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Thu, 25 Sep 2025 11:42:04 +0200 Maciej Fijalkowski wrote:
> > > On Thu, Sep 25, 2025 at 12:53:53AM -0700, Octavian Purdila wrote:
> > > > On Wed, Sep 24, 2025 at 5:09 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > > > >
> > > > > On Wed, 24 Sep 2025 06:08:42 +0000 Octavian Purdila wrote:
> > >  [...]
> > > > >
> > > > > This can also happen on veth, right? And veth re-stamps the Rx queues.
> > >
> > > What do you mean by 're-stamps' in this case?
> > >
> > > >
> > > > I am not sure if re-stamps will have ill effects.
> > > >
> > > > The allocation and deallocation for this issue happens while
> > > > processing the same packet (receive skb -> skb_pp_cow_data ->
> > > > page_pool alloc ... __bpf_prog_run ->  bpf_xdp_adjust_tail).
> > > >
> > > > IIUC, if the veth re-stamps the RX queue to MEM_TYPE_PAGE_POOL
> > > > skb_pp_cow_data will proceed to allocate from page_pool and
> > > > bpf_xdp_adjust_tail will correctly free from page_pool.
> > >
> > > netif_get_rxqueue() gives you a pointer the netstack queue, not the driver
> > > one. Then you take the xdp_rxq from there. Do we even register memory
> > > model for these queues? Or am I missing something here.
> > >
> 
> Ah, yes, you are right. So my comment in the commit message about
> TUN/TAP registering a page shared memory model is wrong. But I think
> the fix is still correct for the reported syzkaller issue. From
> bpf_prog_run_generic_xdp:
> 
>         rxqueue = netif_get_rxqueue(skb);
>         xdp_init_buff(xdp, frame_sz, rxq: &rxqueue->xdp_rxq);
> 
> So xdp_buff's rxq is set to the netstack queue for the generic XDP
> hook. And adding the check in netif_skb_check_for_xdp based on the
> netstack queue should be correct, right?

Per my limited understanding your change is making skb_cow_data_for_xdp()
a dead code as I don't see mem model being registered for these stack
queues - netif_alloc_rx_queues() only calls xdp_rxq_info_reg() and
mem.type defaults to MEM_TYPE_PAGE_SHARED as it's defined as 0, which
means it's never going to be MEM_TYPE_PAGE_POOL.

IMHO that single case where we rewrite skb to memory backed by page pool
should have it reflected in mem.type so __xdp_return() potentially used in
bpf helpers could act correctly.

> 
> > > We're in generic XDP hook where driver specifics should not matter here
> > > IMHO.
> >
> > Well, IDK how helpful the flow below would be but:
> >
> > veth_xdp_xmit() -> [ptr ring] -> veth_xdp_rcv() -> veth_xdp_rcv_one()
> >                                                                |
> >                             | xdp_convert_frame_to_buff()   <-'
> >     ( "re-stamps" ;) ->     | xdp->rxq = &rq->xdp_rxq;
> >   can eat frags but now rxq | bpf_prog_run_xdp()
> >          is veth's          |
> >
> > I just glanced at the code so >50% changes I'm wrong, but that's what
> > I meant.
> 
> Thanks for the clarification, I thought that "re-stamps" means the:
> 
>     xdp->rxq->mem.type = frame->mem_type;
> 
> from veth_xdp_rcv_one in the XDP_TX/XDP_REDIRECT cases.
> 
> And yes, now I think the same issue can happen because veth sets the
> memory model to MEM_TYPE_PAGE_SHARED but veth_convert_skb_to_xdp_buff
> calls skb_pp_cow_data that uses page_pool for allocations. I'll try to
> see if I can adapt the syzkaller repro to trigger it for confirmation.

That is a good catch.


