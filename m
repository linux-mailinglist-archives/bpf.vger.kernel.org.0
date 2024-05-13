Return-Path: <bpf+bounces-29651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EDF8C45CA
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 19:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 432BCB24627
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 17:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C5F208A1;
	Mon, 13 May 2024 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IW20ub14"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79701CD3F;
	Mon, 13 May 2024 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620358; cv=fail; b=B3HOfQe64G7aCwoMvgvVimWY8RMxswej1lSIL19/1sD+pvbMP0urzpQ8/HiwHwklU6ezYoMCSs362qh0AzVzq77DkaK1QAxSXYt+/yBKNSdOk/wiOUvcZ7EHkkfCZPCmzdlnJtvt/JNbb+aJU4UppwRCfcf7xoqeOsbU2FGDoLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620358; c=relaxed/simple;
	bh=HpXSrPcvhVzrJ/809G+Gz0Cyv8D4MCo6XsqSlY6BbFg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=igmkqZnOZo9zp709f6PKcmDLjMfkRBtRKQfJuUVqsuXBvVHvt54SfMBRIILdboMh1s5+6UZ8NJMYCvCa5V8ATXF+J0sJHtQDnc5b7GHoaxfj99Bg5kgkc2fZVVpLmKCmBZK+wVRWK2Zn+casGKGEqQkr1Gi6z7y03MNEqqRbfE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IW20ub14; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715620357; x=1747156357;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HpXSrPcvhVzrJ/809G+Gz0Cyv8D4MCo6XsqSlY6BbFg=;
  b=IW20ub14BOqZENkXT0KSSgr9hivJvq+iacBMhCaiNZ+q4pbTsvzJsBGw
   404rTIpY3lBsySWgNEhvC15kiasgsjMGc9+UNkxs9HXNhv08yNjEJQmjW
   pgONyG6ri9EUQ0eqH5582DuTfGGUQGm8qx09SkdJaXo2A4GzdFAjbqYly
   MzlJFlfTj2d8vTcJwELmUt5K7I/DKaPg1juxs2r7OfQX6FK6Z3QfeXrip
   AX3XxzBbDeH+kfeANxcnvAl+pAs7rlMc/T+znJOq55Ca+tZi/x102X0HG
   pgFBVN89s4yRQVbYzieVZ8ArkIH0arpK9d45rAZPqwoZZny767YitUZ8z
   w==;
X-CSE-ConnectionGUID: byK21pvoTr+heQt+wjgMBg==
X-CSE-MsgGUID: wNV4s96zS0yhk0uiIFsTkg==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11743042"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="11743042"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 10:12:36 -0700
X-CSE-ConnectionGUID: UnRUZy/RR/yxeiDlbHRJPQ==
X-CSE-MsgGUID: +076CkguTw27qUzy8s9yFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="30959004"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 May 2024 10:12:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 13 May 2024 10:12:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 13 May 2024 10:12:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 13 May 2024 10:12:34 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 13 May 2024 10:12:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXelhBn4vdfqvn5GLYx4X5zJkzL871gSBruup+wHyQHcQg3U5FsccGiP3bggsyBE0z5yd4sg3mO5t+FNqJdy1yIc64tvEF48KyNIFsOcYyyXnwvu5FC6OsX+s3cOZMgj2cNS6xNBM0uC4rIOsJ/rmPYjoHLsr7T4qipmoHLwDqDstmNtnjVp/T66/taqMpXMBya0tKiEzO4sAwPcUgWvs0yioDE8BpLT+AYS/B+i3QGFXnEjgZZ2tnHuPQJMbs42WTHb9xOhw5Q5nbeYcxFzla6PG00TIM0ijf5e/SUx0sW/CDvCuYMpfGK7pxtnhuDrmTfgGwGhT7NhOyIymRRPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpXSrPcvhVzrJ/809G+Gz0Cyv8D4MCo6XsqSlY6BbFg=;
 b=GWcW+KyioSi1UAvTeY16sZRipZnhHzXqrD9SXJs7sv90tAkczD/0OpNgNWFapvm7KQInAgzZiiTZsroec/dUhWPIblXMCaBl7qhd5wBoU67tknOXoNp5D5JKopl1MrOCKqgv+oYE12sZPnSZX6qJsLdxFACWInOVE+kjJVS8HO6zv0EwkSbggHtpDZysUc3w/DwcpCCfB2AIGeUnRuPWpaX3Yo8iXCrd3+5ZGFPlnuDKbxK/S1jEfpolXF/oM4uPAvqfZ3THfbLM4sZ8B9cIfsmEPE4b0k28w5eyJ7bzJs7SNMW2im7lamgJQ9mkDUc7Bqc4IncCLF96ucMh2vQkzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW4PR11MB6886.namprd11.prod.outlook.com (2603:10b6:303:224::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 17:12:31 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%3]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 17:12:31 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "olsajiri@gmail.com" <olsajiri@gmail.com>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>
CC: "songliubraving@fb.com" <songliubraving@fb.com>, "luto@kernel.org"
	<luto@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "ast@kernel.org"
	<ast@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "yhs@fb.com"
	<yhs@fb.com>, "oleg@redhat.com" <oleg@redhat.com>,
	"linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCHv5 bpf-next 6/8] x86/shstk: Add return uprobe support
Thread-Topic: [PATCHv5 bpf-next 6/8] x86/shstk: Add return uprobe support
Thread-Index: AQHaoGz/NDbwXOtepku5mG5JmKvX1LGMCSqAgAKMVwCAAIRoAIADdFkAgAJm6gCAAHtzAA==
Date: Mon, 13 May 2024 17:12:31 +0000
Message-ID: <c56ae75e9cf0878ac46185a14a18f6ff7e8f891a.camel@intel.com>
References: <20240507105321.71524-1-jolsa@kernel.org>
	 <20240507105321.71524-7-jolsa@kernel.org>
	 <a08a955c74682e9dc6eb6d49b91c6968c9b62f75.camel@intel.com>
	 <ZjyJsl_u_FmYHrki@krava>
	 <a8b7be15e6dbb1e8f2acaee7dae21fec7775194c.camel@intel.com>
	 <Zj_enIB_J6pGJ6Nu@krava>
	 <20240513185040.416d62bc4a71e79367c1cd9c@kernel.org>
In-Reply-To: <20240513185040.416d62bc4a71e79367c1cd9c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW4PR11MB6886:EE_
x-ms-office365-filtering-correlation-id: 499b65fb-2319-4cdd-111d-08dc736fe022
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VzRqS0h2bVNNa29ETXYyMjFsRmdYTGVwdTlnNlg0V0x0WjZvRUtzdFRTSmpv?=
 =?utf-8?B?eStVVDA4UHBwTkNzNG92eTF0VjkvdlJoMnNlenUvdVpaN2JiZWdjNXlQMEpN?=
 =?utf-8?B?WXhjdm9aZGZGMUlhbG1SNUJtRmNnNy9RNWh2SUVaVWlOdzdhc2ZMVXRNMnJQ?=
 =?utf-8?B?YVlNTVhJelNwdzJrK0xQTXFaTGhIK1lQaDBSdjBHWHZ4N0wyLzc2V3NMT2Iz?=
 =?utf-8?B?bU1QdXB2MlZ5Mkh5dGNtNXNYeXZPbHhqT2NOZTdwbDdTa3RNN3VBSTVkbXFx?=
 =?utf-8?B?RzBZWlFJTmhkNlU5SjRnZGE1eFNDODR0VVIvVnNLQkwzd2ZMUU1vMFVRVDc3?=
 =?utf-8?B?YjkrR2lMZDd2amJMRCtBOCtSRnF2cmZXZjVzUFRhSFB2bUczSkdmWlZCdVYz?=
 =?utf-8?B?U05oZ3dsTVZJeFJrUnJJMzBOOVZxa0dZU2JXbS92Y2ZZRXJZaTVMYm5JTG04?=
 =?utf-8?B?dWpZTzAvQmhBSXI4cjI4VXhEd3REaWErVnB1bVVqbWE0bzVnaTdyOWVYNTJC?=
 =?utf-8?B?WU0zKzBxbWdQbWU0L0s4bHRReEhrN1RCQS9iVnhpbHRubVUrM3ZEQjMyTmlI?=
 =?utf-8?B?UGNMeGdWdmlSV1VGd1R3RFoxRzd2eXp1ekE5ZUJEd01GVXZQU2dLUVV6WndH?=
 =?utf-8?B?RXZ6NWJPNmdCM3RGMDhKUmsrZ3A0bTlpVmFqdXE5V0tYS2lYRnNnYzJrSXd4?=
 =?utf-8?B?V3VQQ21SbXpkc05SaEU1VU9FS0l5dmplYzRnNTlrc3B3emxhdnFsMHdobzRS?=
 =?utf-8?B?ZlhHTlRDQ0hJMkk5MDBXQmUvbjVCVmlxNzRVN29reEw5Kzl6WnJXcjJqT1Q0?=
 =?utf-8?B?QzZIczdFdkQ0b3hvWVRBYkFYNE5QcUs1c1VQSHJVcUc5SVBTbjE2b0pKU1di?=
 =?utf-8?B?N28xa2JONWtKOEtncnR2bTlqMEVDR29KbnVSU2txR0VySlBGMHl2Q1JpRTRl?=
 =?utf-8?B?TjRyQ2RJQXpBS1dsWWRsd3BBQzdKSCtlMGRnRkU2SkxhM2cvRDMxS1VWS2JV?=
 =?utf-8?B?ZTZPSFFYT3l4UjlyMzYxNkk1TW5wc1luWDFsQlBFTXBTY0IwSTBVR3g5SHN3?=
 =?utf-8?B?WjFIam5LbzY1NGRvKzUzaUd5UC9kbUNnUWxNelltWWJ1MU9DRzl5Ulgwajkz?=
 =?utf-8?B?N0pLSit0T3JmOURMYW5vaFkrQmJwS0dDSSs0ZHJESFQ1aXZCT2NTVy9JcFFR?=
 =?utf-8?B?OHcwZFVzOGNRQXY1MjhuNkJFTHE5THZPL0ZQRVpuVTA3QjVpamJmcExGVHhF?=
 =?utf-8?B?WE1CTmtrMDl2V0xFY1NmZTZyNGczZ1BUTWIvRFZYSHQ0TVhOdkdUdWRsZDJl?=
 =?utf-8?B?bEFLV2E3Y0RwR1dWaWQyQjNPVFdXMkttaGtOSnFDVForMWx1OEI5S1dKOU9t?=
 =?utf-8?B?ZWlpdmNzanRpNXB3NURnZG5iQVBSVlkzNDB6Ym5Uc1hEdFM1elZ0ZUh1YVNw?=
 =?utf-8?B?b1NEa0xjemlJV0NnTExCMjJTZ095a3pReTV3WUsyOHNEcVdCeXNPQ1Y3UURB?=
 =?utf-8?B?VEprZ0tuWEkzcG5vMmVVOUljUGRQeXQySFg3THovbVFCWWlqT2lnOHVGbTJu?=
 =?utf-8?B?bEs2cC9JQUR6SzcvWGhBOThBelVUeFo1Nm5lMi9JQjA0Z25SMGpFQUh0WEd6?=
 =?utf-8?B?OG5YemFEVExWaUlyZ1VaSDU5ZXZRbVlLcnZ3bHZvUitWZDBJeEZLR01jY3o3?=
 =?utf-8?B?TWRReGs5QlhlYlRqM0JFK2NIQnpoaWxvdURBaGtWRERqaUFMOXJ5UEpIYmQw?=
 =?utf-8?B?U3BSTi8yV0c4S3NSY3RVeENDOE5PNGx3MStFamhmYUtIaGxaeXlEMkkwbTlt?=
 =?utf-8?B?WlBoSFFSNGxDSStvV2VsQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlVIaWdEYTNQZjNNbVg3S3VXWURQMWoxSlNaRFcySXdPOTdNby9iRGtIWisv?=
 =?utf-8?B?QkFSaUFVZ01sSDRRcS9hMGJEUXNoRzFWbjJRcUdVS3FRUEtuZ0xPV2VVV1o1?=
 =?utf-8?B?d3VPQ0xmY3JRK3Raekk2dEVST2l4U05Ya3pSaGp5M3dEM0ZXdUp2RldQZGlY?=
 =?utf-8?B?RGkrM0NBd1dLU29CT1I5czgybitXczI4eHpLR0c2a05aU3lyT3RzVk9NZjhW?=
 =?utf-8?B?Y3BXZjJlUjkxZzg2MGp1QlVxaTJtcFlVQjhOR1dtd2NsSFBWb1JuMitjZnhM?=
 =?utf-8?B?eDljc2hkNktaOTFtYXRtK1kra0wxTko1bk85b0o0S1ZveVRZY1JiQ0R2ZWFl?=
 =?utf-8?B?akZzZGxyVUZ1S1h0dmx4NEt4Y2c2WUMzMFJnZzNyTTdFS0hTVWpwMHNpZG9G?=
 =?utf-8?B?ZmwzQXJiRFZMYUJ4V0I5YmVva05tcVFaRXVsWHN1V2g0bFVkMU9heUJjQUUz?=
 =?utf-8?B?YUl4VjV6Q0cyODBLY0FSVm5qb3JGbjQvMTBVQW82cnhrZGpkUlFsb1p4czdO?=
 =?utf-8?B?bFFha05tNWtUc3k0cG8rQWdVTVdPOFdYTlMwUnRNd3RHOFVDYm9LRGpSRSsv?=
 =?utf-8?B?cTFkcUFSS2tCeTVhYkE3K1FGSUZmYTNKNDJ3Zmd6djAzTDZUcjlCY08yRWtM?=
 =?utf-8?B?OXBpNFBWQXREK2NZRnljS1ovUzdhb0l0WWJxU09ydHZGWlZuYmxPWXRTOXVP?=
 =?utf-8?B?SG90VjlQeDduOHFFbWwzN0FkL0wyVkljTnhmdHZiSDdNbU1UcnE0ZzN6ZG5U?=
 =?utf-8?B?Y1RKZ0ltOVlTNE5JYVFKdzM0TnQyUnFYMy95Qm5RK25rM29FWkV0SW10T29y?=
 =?utf-8?B?anViMnM3UEhWV1ZQYUFEUk5vVnM1dk1LR1JvTGlDMFJ3cjVNZVV2WVVaUWl4?=
 =?utf-8?B?RXhqdjVjMVpSZ3gyRW1BaVZmZFkwd010SnZXaXpENkRlNmtxMHQ5eEtPWVU4?=
 =?utf-8?B?bDdEdTFPWGQ5VVNyT1B3WEpmV25MeGZiMzQ3a0JvVTF5Ym9wQ1piOHpVb2Vu?=
 =?utf-8?B?VS9rQVZ4bEZ5U21vRkYrUTdPNUNieXFNVFZmUlVqV3R3YU82RllJVHZkRzJm?=
 =?utf-8?B?NkpNU1hYRGFyVFNTOTJHSkI3VlJLdm9OSWlkbXpKWDRaQmt5dk9jNHVESVNH?=
 =?utf-8?B?NXNMalUvcUJNdm9iazdsWVZPNkpNbHFKTU1hdEJhbGxMVkZEaXpoM2J4aWlQ?=
 =?utf-8?B?dG1uWXJ0UmJEdENYb3N0Z000cFFwNlRTRkNFMlhpWXF0Q2cxbnFPM3dpTEFv?=
 =?utf-8?B?ZHkzTGVFLy9XMG5rN29zN0FrcDhxOExRK1VEQmp5L3Z3QmtOR3NLZTBjZEZU?=
 =?utf-8?B?VGR2Yjc0QjgwWmhpeWMvS1hiT05lWmdkY29WL2RMdjdjeFJDRTRnZFlXaldq?=
 =?utf-8?B?OEVEZnhmMlRyeUgyNmdNN3lwOGNjQ3BYbUVxYTRzU1p0WVhvYVBQNTVEbk9D?=
 =?utf-8?B?Y2xMRGNOa2hJMk9zSEpsMnAwV3dFK2FTTGw2ZGdsYjVad216R2x1TXJMajhI?=
 =?utf-8?B?U2c4VlY1SVcyZDNYOEZPWmxCNExXT3BwMkdqL25Icnd6Vmt2RCs1Qzc0Ymd4?=
 =?utf-8?B?NDVYR3VCSk5OYk9NWVduUmZLNUl3UjUyUVlMY2hydHdPVzlmK3Vud0syU2di?=
 =?utf-8?B?UUlHRjZXL2hoRC8vRkVXeGE5ajdPNFBMTGZEUVhtSm01QmFyWDNaaDlOMkZL?=
 =?utf-8?B?eSs2KzlXN1hCMHdCbEk1T3poT2hTWm9mR3c2elZ3enZRYzlwNDduS1d4ZndV?=
 =?utf-8?B?Nit4Z1ovTEVxYmNZUXpNUkhOV05CNlVwV3BVaWJlTkplNG4vZHI5U3I3QUJh?=
 =?utf-8?B?U1A0a0JIc2tCdlRjUm1LNitMaWNhRGdsOW9IbEp4dlpWT0R4WWFyUHY3bCtT?=
 =?utf-8?B?eUM0UnJhd3hod29ucUVXL2gwQjgzYllnUEZUS0dnTDB4b3hiay9OaHJlTUhu?=
 =?utf-8?B?SDNnN2liWGU1VkJBNzhybFozeXBjcEQwd0UxckhhRVk2d1pEcTVCc2EwT0cr?=
 =?utf-8?B?Um5iKzNXazNNakR5d1BVVk4wNGMzeU9yUkdvYlpnN0lnbW5XMEpNdjYvQlRa?=
 =?utf-8?B?K0dHNUhSRzI3QXd6bWlDL0N5bEExb0tjTEgxcEpKMGF0S3QreGxaZ1RiWk5J?=
 =?utf-8?B?WXZ0TFo3TlA4R0d2bXVjYjVRNmNkckkvZEh4S2ZSbllrY2lKbGZETk1mMm5S?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A34234D48A4EE4BB27F52BF11E9F173@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499b65fb-2319-4cdd-111d-08dc736fe022
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 17:12:31.8292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NtZG6kk9YUoQVP1DFlEINw/ICdloqBCbupyLlbEQKkZYzxb1jEhMz2YnTfrBb0wlOwjBBA8ws0wG83m+M/PKyq028P7rW81atzNsW5KamiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6886
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA1LTEzIGF0IDE4OjUwICswOTAwLCBNYXNhbWkgSGlyYW1hdHN1IHdyb3Rl
Og0KPiA+IEkgZ3Vlc3MgaXQncyBkb2FibGUsIHdlJ2QgbmVlZCB0byBrZWVwIGJvdGggdHJhbXBv
bGluZXMgYXJvdW5kLCBiZWNhdXNlDQo+ID4gc2hhZG93IHN0YWNrIGlzIGVuYWJsZWQgYnkgYXBw
IGR5bmFtaWNhbGx5IGFuZCB1c2Ugb25lIGJhc2VkIG9uIHRoZQ0KPiA+IHN0YXRlIG9mIHNoYWRv
dyBzdGFjayB3aGVuIHVyZXRwcm9iZSBpcyBpbnN0YWxsZWQNCj4gPiANCj4gPiBzbyB5b3UncmUg
d29ycmllZCB0aGUgb3B0aW1pemVkIHN5c2NhbGwgcGF0aCBjb3VsZCBiZSBzb21laG93IGV4cGxv
aXRlZA0KPiA+IHRvIGFkZCBkYXRhIG9uIHNoYWRvdyBzdGFjaz8NCg0KU2hhZG93IHN0YWNrIGFs
bG93cyBmb3IgbW9kaWZpY2F0aW9uIHRvIHRoZSBzaGFkb3cgc3RhY2sgb25seSB0aHJvdWdoIGEg
ZmV3DQpsaW1pdGVkIHdheXMgKGNhbGwsIHJldCwgZXRjKS7CoFRoZSBrZXJuZWwgaGFzIHRoZSBh
YmlsaXR5IHRvIHdyaXRlIHRocm91Z2gNCnNoYWRvdyBzdGFjayBwcm90ZWN0aW9ucyAoZm9yIGV4
YW1wbGUgd2hlbiBwdXNoaW5nIGFuZCBwb3BwaW5nIHNpZ25hbCBmcmFtZXMpLA0KYnV0IHRoZSB3
YXlzIGluIHdoaWNoIGl0IGRvZXMgdGhpcyBhcmUgbGltaXRlZCBpbiBvcmRlciB0byB0cnkgdG8g
cHJldmVudA0KcHJvdmlkaW5nIGV4dHJhIGNhcGFiaWxpdGllcyB0byBhdHRhY2tlcnMgd2FudGlu
ZyB0byBjcmFmdCB0aGVpciBvd24gc2hhZG93DQpzdGFja3MuDQoNCkJ1dCB0aGUgSFcgZmVhdHVy
ZXMgaGF2ZSBvcHRpb25hbCBhYmlsaXRpZXMgdG8gYWxsb3cgZXh0cmEgcGF0dGVybnMgb2Ygc2hh
ZG93DQpzdGFjayBtb2RpZmljYXRpb24gZm9yIHVzZXJzcGFjZSBhcyB3ZWxsLiBUaGlzIGNhbiBm
YWNpbGl0YXRlIHVudXN1YWwgcGF0dGVybnMNCm9mIHN0YWNrIG1vZGlmaWNhdGlvbiAobGlrZSBp
biB0aGlzIHNlcmllcykuIEZvciwgeDg2IHRoZXJlIGlzIHRoZSBhYmlsaXR5IHRvDQphbGxvdyBh
biBpbnN0cnVjdGlvbiAoY2FsbGVkIFdSU1MpIHN1Y2ggdGhhdCB1c2Vyc3BhY2UgY2FuIGFsc28g
d3JpdGUgYXJiaXRyYXJ5DQpkYXRhIHRvIHRoZSBzaGFkb3cgc3RhY2suIEFybSBoYXMgc29tZXRo
aW5nIGxpa2VzIHRoYXQsIHBsdXMgYW4gaW5zdHJ1Y3Rpb24gdG8NCnB1c2ggdG8gdGhlIHNoYWRv
dyBzdGFjay4NCg0KVGhlcmUgd2FzIHNvbWUgZGViYXRlIGFib3V0IHdoZXRoZXIgdG8gdXNlIHRo
ZXNlIGZlYXR1cmVzLCBhcyBnbGliYyBjb3VsZCBub3QNCnBlcmZlY3RseSBtYXRjaCBjb21wYXRp
YmlsaXR5IGZvciBmZWF0dXJlcyB0aGF0IHBsYXkgd2l0aCB0aGUgc3RhY2sgbGlrZQ0KbG9uZ2pt
cCgpLiBBcyBpbiwgd2l0aG91dCB1c2luZyB0aG9zZSBleHRyYSBIVyBjYXBhYmlsaXRpZXMsIHNv
bWUgYXBwcyB3b3VsZA0KcmVxdWlyZSBtb2RpZmljYXRpb25zIHRvIHdvcmsgd2l0aCBzaGFkb3cg
c3RhY2suDQoNClRoZXJlIGhhcyBiZWVuIGEgbG90IG9mIGRlc2lnbiB0ZW5zaW9uIGJldHdlZW4g
c2VjdXJpdHksIHBlcmZvcm1hbmNlIGFuZA0KY29tcGF0aWJpbGl0eSBpbiBmaWd1cmluZyBvdXQg
aG93IHRvIGZpdCB0aGlzIGZlYXR1cmUgaW50byBleGlzdGluZyBzb2Z0d2FyZS4gSW4NCnRoZSBl
bmQgdGhlIGNvbnNlbnN1cyB3YXMgdG8gbm90IHVzZSB0aGVzZSBleHRyYSBIVyBjYXBhYmlsaXRp
ZXMsIGFuZCBsZWFuDQp0b3dhcmRzIHNlY3VyaXR5IGluIHRoZSBpbXBsZW1lbnRhdGlvbi7CoFRv
IHRyeSB0byBzdW1tYXJpemUgdGhlIGRlYmF0ZSwgdGhpcyB3YXMNCmJlY2F1c2Ugd2UgY291bGQg
Z2V0IHByZXR0eSBjbG9zZSB0byBjb21wYXRpYmlsaXR5IHdpdGhvdXQgZW5hYmxpbmcgdGhlc2Ug
ZXh0cmENCmZlYXR1cmVzLg0KDQpTbyBzaW5jZSB0aGlzIHNvbHV0aW9uIGRvZXMgc29tZXRoaW5n
IGxpa2UgZW5hYmxpbmcgdGhlc2UgZXh0cmEgY2FwYWJpbGl0aWVzIGluDQpzb2Z0d2FyZSB0aGF0
IHdlcmUgcHVycG9zZWx5IGRpc2FibGVkIGluIEhXLCBpdCByYWlzZXMgZXllYnJvd3MuIEdsaWJj
IGhhcyBzb21lDQpvcGVyYXRpb25zIHRoYXQgbm93IGhhdmUgZXh0cmEgc3RlcHMgYmVjYXVzZSBv
ZiBzaGFkb3cgc3RhY2suIFNvIGlmIHdlIGNvdWxkIGRvDQpzb21ldGhpbmcgdGhhdCB3YXMgc3Rp
bGwgZnVuY3Rpb25hbCwgYnV0IHNsb3dlciBhbmQgbW9yZSBzZWN1cmUsIHRoZW4gaXQgc2VlbXMN
CnJvdWdobHkgaW4gbGluZSB3aXRoIHRoZSB0cmFkZW9mZnMgd2UgaGF2ZSBnb25lIHdpdGggc28g
ZmFyLg0KDQpCdXQgc2hhZG93IHN0YWNrIGlzIG5vdCBpbiB3aWRlc3ByZWFkIHVzZSB5ZXQsIHNv
IHdoZXRoZXIgd2UgaGF2ZSB0aGUgZmluYWwNCnRyYWRlb2ZmcyBzZXR0bGVkIGlzIHN0aWxsIG9w
ZW4gSSB0aGluay4gRm9yIGV4YW1wbGUsIG90aGVyIGxpYmNzIGhhdmUgZXhwcmVzc2VkDQppbnRl
cmVzdCBpbiB1c2luZyBXUlNTLg0KDQpJJ20gYWxzbyBub3QgY2xlYXIgb24gdGhlIHR5cGljYWwg
dXNlIG9mIHVyZXRwcm9iZXMgKGRlYnVnZ2luZyB2cyBwcm9kdWN0aW9uKS4NCkFuZCB3aGV0aGVy
IHNoYWRvdyBzdGFjayArIGRlYnVnZ2luZyArIHByb2R1Y3Rpb24gd2lsbCBoYXBwZW4gc2VlbXMg
cHJldHR5DQp1bmtub3duLg0KDQo+IA0KPiBHb29kIHBvaW50LiBGb3IgdGhlIHNlY3VyaXR5IGNv
bmNlcm5pbmcgKGUuZy4gbGVha2luZyBzZW5zaXRpdmUgaW5mb3JtYXRpb24NCj4gZnJvbSBzZWN1
cmUgcHJvY2VzcyB3aGljaCB1c2VzIHNoYWRvdyBzdGFjayksIHdlIG5lZWQgYW5vdGhlciBsaW1p
dGF0aW9uDQo+IHdoaWNoIHByb2hpYml0cyBwcm9iaW5nIHN1Y2ggcHJvY2VzcyBldmVuIGZvciBk
ZWJ1Z2dpbmcuIEJ1dCBJIHRoaW5rIHRoYXQNCj4gbmVlZHMgYW5vdGhlciBzZXJpZXMgb2YgcGF0
Y2hlcy4gV2UgYWxzbyBuZWVkIHRvIGRpc2N1c3Mgd2hlbiBpdCBzaG91bGQgYmUNCj4gcHJvaGli
aXRlZCBhbmQgaG93IChlLmcuIGF1ZGl0IGludGVyZmFjZT8gU0VMaW51eD8pLg0KPiBCdXQgSSB0
aGluayB0aGlzIHNlcmllcyBpcyBqdXN0IG9wdGltaXppbmcgY3VycmVudGx5IGF2YWlsYWJsZSB1
cHJvYmVzIHdpdGgNCj4gYSBuZXcgc3lzY2FsbC4gSSBkb24ndCB0aGluayBpdCBjaGFuZ2VzIHN1
Y2ggc2VjdXJpdHkgY29uY2VybmluZy4NCg0KUGF0Y2ggNiBhZGRzIHN1cHBvcnQgZm9yIHNoYWRv
dyBzdGFjayBmb3IgdXJldHByb2Jlcy4gQ3VycmVudGx5IHRoZXJlIGlzIG5vDQpzdXBwb3J0Lg0K
DQpQZXRlcnogaGFkIGFza2VkIHRoYXQgdGhlIG5ldyBzb2x1dGlvbiBjb25zaWRlciBzaGFkb3cg
c3RhY2sgc3VwcG9ydCwgc28gSSB0aGluaw0KdGhhdCBpcyBob3cgdGhpcyBzZXJpZXMgZ3JldyBr
aW5kIG9mIHR3byBnb2FsczogbmV3IGZhc3RlciB1cmV0cHJvYmVzIGFuZA0KaW5pdGlhbCBzaGFk
b3cgc3RhY2sgc3VwcG9ydC4NCg0KDQo=

