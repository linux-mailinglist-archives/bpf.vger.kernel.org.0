Return-Path: <bpf+bounces-29062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CD48BFBD5
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 13:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CCE21F22392
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 11:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CCC81AD0;
	Wed,  8 May 2024 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iNhxOMEX"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA8876037;
	Wed,  8 May 2024 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167234; cv=fail; b=HHU5fu33iJ2qGY3r7qmCtj91FaOJ0PrnEjyJ+gXawrfsX5T+BbvIedkBjdtNM/bCCTNTUOsGKosY1VRdHZ05w+REaaMC9gTe9Ck8T0PEQqjV9n8N/GbmqE9/L44lLMMDYLHFVc1glw7oG/Exabtncc0YZ29DbRbNsDgEoCWc+gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167234; c=relaxed/simple;
	bh=/Jey5IN0YpzIOjRJrSBUQvLqyR/Y/yGBVTCbRVLIC68=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HytqK+EOc5sSWFzWmjCFhajwjpzIEFPQEgOoqkxloAl543V+BIwtAtkVzw+VUsbcuwOhIdH1GILhWIIoiGo8f4jgE5oF+XDrvQJ8JuAKV2pNn+5hJUiMgM0e8+cPyVIEhRkQDlEvwqlTB1mRvotCuoPz/gaMvXAcjhTXx0FTAYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iNhxOMEX; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715167233; x=1746703233;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/Jey5IN0YpzIOjRJrSBUQvLqyR/Y/yGBVTCbRVLIC68=;
  b=iNhxOMEXSbHDlwYZ0cSl+1gschqCx86PPdwJl1klK1NMk94WLpfOeITZ
   NBSh8OKwn+64pJRl6NLW7abgR0hDoFUs9QfwIJnUYWI6ln4lwEevEmpmc
   cyuAirPlc5xz4VPMjVmxPY/pzV0pvap380eOZ54SnbprCsAcGY6sRfxmL
   zIGhIKcyLIJZI3B2EWcVnvb3veCLH9FJn1hire+nETyEj4M+sKp3Km7uX
   BfFXrdpuBHagEL/wYYA5ixd94qrPBXMdHIKuycbJr711imMmQYW4dBTkV
   JfwENzTAabwjeO2faE7qqNDpIYGUAkRI7/ARF03OgD8Rsn6edbF5tw/c0
   w==;
X-CSE-ConnectionGUID: /mvOCw7vTdmLx7DPxkk0+Q==
X-CSE-MsgGUID: cv5KatI/S6ig0iJyJzTSaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="14824672"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="14824672"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 04:20:32 -0700
X-CSE-ConnectionGUID: OFrR6qGoRTSVoZcl5DLJFQ==
X-CSE-MsgGUID: MLLgzuw4Qb+zWy50706Zvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28908973"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 04:20:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 04:20:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 04:20:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 04:20:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 04:20:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjv1MWUkjkLbRyUsJ5SMIubLwaW147jieF14O+DDVQy9fy6jdveLJoWoER4KXQQClFCGjAS+MoF1/DS23yJtjH0eBbis2AuABP9JJZlGrHfhDFNc3vLm7oMQS45lDzfJfo3vUaigPRUbOv9ZIl1saY8RQEaucwPsg0oEZbvvm5XKglmLdgdBvgHsNzuY4k0j1NokEN/jNcfMw+OX+nGfQcChTTYFfNxBE+nVtVEdos5g5MIthVhi8u2dG5XPsVVWJfGraZC2TEQyfbBzjQW99NMFWRzjfesuVZnYAfzgs+yZlFIoNYY0qLZxcUiEJ6Wybf3ZkRLmuxyQf4T/Mxcchw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Jey5IN0YpzIOjRJrSBUQvLqyR/Y/yGBVTCbRVLIC68=;
 b=K7otJVknumkDBonBNK35vP5tpmvZKRMy3enqMgYq1+gBIPabfjXzGUO6Q5bGshmO+ERo9zLDbxGhUzxiWQPrNL9GXWxFKyxW7+PsNXISTTtWcdsloN12vMtNXlg9Ca7trLFwRRC2yicGZCUS4IDqdStjllns3fA7C7oW+Ks4GBlU8xMshQ7KbHnVxigyfqAeLqyvEcqofniJBfWzD7egiiQH6U4c6s+068GUjV+ybiWmVeHoQ/fXAEkDw8UdIc6ANLKuu7LhI7d67oaCTQqicEKLYy0te5GnSkD0Q7YTfuaonMfud1IpdLk5X/T80Jai6G+VCFGztxELF1JD/1SLLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 SA2PR11MB5084.namprd11.prod.outlook.com (2603:10b6:806:116::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 11:20:23 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::abaf:6ba7:2d70:7840]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::abaf:6ba7:2d70:7840%2]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 11:20:23 +0000
From: "Wang, Xiao W" <xiao.w.wang@intel.com>
To: Pu Lehui <pulehui@huawei.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "luke.r.nels@gmail.com"
	<luke.r.nels@gmail.com>, "xi.wang@gmail.com" <xi.wang@gmail.com>,
	"bjorn@kernel.org" <bjorn@kernel.org>
CC: "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "eddyz87@gmail.com"
	<eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "sdf@google.com" <sdf@google.com>, "haoluo@google.com"
	<haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "Li, Haicheng"
	<haicheng.li@intel.com>
Subject: RE: [PATCH] riscv, bpf: Optimize zextw insn with Zba extension
Thread-Topic: [PATCH] riscv, bpf: Optimize zextw insn with Zba extension
Thread-Index: AQHaoGtgQt2dALTuk0aEsDxXE25q4rGLuImAgAF5qZA=
Date: Wed, 8 May 2024 11:20:22 +0000
Message-ID: <DM8PR11MB5751A0943E23FE46AC4B7D89B8E52@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20240507104528.435980-1-xiao.w.wang@intel.com>
 <6836eb5c-f135-4e58-987b-987ab446b27c@huawei.com>
In-Reply-To: <6836eb5c-f135-4e58-987b-987ab446b27c@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|SA2PR11MB5084:EE_
x-ms-office365-filtering-correlation-id: a16a01b1-0183-4430-53a2-08dc6f50da43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?a1loWkhWM2VNZVdNS1UzNjRYSVovTTlaejdwelZJbnVFWk9hK2NOSU1ia05T?=
 =?utf-8?B?RnJDYzF2d09sV29SREhHWC82dTFuTXB4WDlLOFBkUTFGcGtMM1llemVSaG44?=
 =?utf-8?B?ZnRobDdTa05qRERmUjNLVWR2THVDajh1V3FuRHJ6T09mTFdmbWw3V0xsa3RR?=
 =?utf-8?B?Tnd5MTk3Qm90M1MvTkw4dDVTdWFkblcvS0xka2loVjcwdG5Bc1M0ZktGS0ho?=
 =?utf-8?B?bXArU2YxRDQ5TXZqTjlWcEFFYUdzTlh0ZWVTSmZSMGlmeGV4TEJ3OE1yYmJ5?=
 =?utf-8?B?MklQN1FCcytGWVE1ZVlDc0xBTnZOcHMwTDYrWkkrU3RIaVdhZXN3bmdWSzJs?=
 =?utf-8?B?QitMVFJNblY5U3BFd1FZdStYN0JDTmUva3BLcUh4S0hEcTBvNUlybHpmVVQ1?=
 =?utf-8?B?ME5FZTFOWC8yMHlWcVRaNSs4OEpGUUU4aGZiaVpyaC96ZjRZc09ZVUw4eUNF?=
 =?utf-8?B?bno0WjRjR29WSVgxdjk4RGN0VTY2cUlLVWFKaG1uYkpNOG9DUm5XT1ZkMlU3?=
 =?utf-8?B?MHUxOUw4YmEzVFoya0hqSXBUTmtZSU5XRVpxS1I5TG03QUFGeVd3dFdMbHU3?=
 =?utf-8?B?d05EMnRpd2xueVZuV1FQUG1tUHl4TVZ3RExvNE5YblJHQmJEV2RjMlg4NSth?=
 =?utf-8?B?azRQL3RWMWF1YTRuSXdQNFRBUTBwU3o0VFlvYVFROXFLdW5RbnpzVDJPdWhL?=
 =?utf-8?B?eTJtc3dsRlRQaE9NQTNyVlQ5cUJFdGdQalNZc24zeHFVRXREWWpRNjNPdS8r?=
 =?utf-8?B?c0JQYzlVYnBybFhtODUxUHJ1WUt4YVIwbjRrT05tOHp3SS9XcitpcWRPYmVM?=
 =?utf-8?B?UlhrMVNlUFZHNFhQdUREckdoZ1JrR0xnbjgwQldUY2ZRejM2bXdsclhvMHc1?=
 =?utf-8?B?MytvYUtNK2crV2czbGtHM2sxRzlFTWFtM3BNRFVtWXBTaElpdldSQURneGdv?=
 =?utf-8?B?RjVpVVZOSC9EL081cnVoZzlMNTExMFBrWlBScWJRSmIwaXRBaG9XRUdBdXp4?=
 =?utf-8?B?d2dMblhXY2hVQitVcFBxV1B0YVAveFdudmw1NEZaWGx3dHU4NTRVOTlwVm52?=
 =?utf-8?B?b3FYTU10S3ZKWmMvL1hwdnB5c0lDQ0lwTk42Um55ZU1TUEwxMWcyRjRsY0RI?=
 =?utf-8?B?Yy9iMzViR2FvVTNiR3N0VXlhUVlZUzJGUTQyNE02L3h6d0lKVUZsNjFBVWJT?=
 =?utf-8?B?M1pYMjRvVkhKRnZBUGJ4UTcrUkVCRnlzMjBIeFdjUGpwbkNRMS9qRkVNekFw?=
 =?utf-8?B?UFlUbW1Cdk9PQVB5SXdjUjFFNmMvbTI2UWVlZmlNQ25seHZtTm0wQ2RqSEI5?=
 =?utf-8?B?dk54QUl4ZTE0bVMyOXFJY3F1VFhCeWxrSDNXeGlrZGx5N3pvVkt6QnF6c2hm?=
 =?utf-8?B?elpkM2lrMGd2VDlPazBySFU4NU8wbHRUWGs5NzNSUyttUnV0TXZUVURsek1E?=
 =?utf-8?B?aXBjRTk3eHpCMVR4b1c4Y0lYaWFKUVhkNjdwRjJzNUNIWUpNK2FqNGV1V0gr?=
 =?utf-8?B?Y1pMdG1wMFV1bWh0eEkzd1gzY1dia0x0SzhGSDI0ZEliSU5kRk1reUdvcFBQ?=
 =?utf-8?B?ZVB6djk2MGd4TUZudG0vVG9qaG1SVCt5a2Z2SjdPdndxdk16WVA3NHBNTjR3?=
 =?utf-8?B?SVduRmp2dlF0QWpKa1h0T0pLOE4veEJOZWF5RGl0RXM5SFVyaFN2L3cvRVFQ?=
 =?utf-8?B?eDRGYnVTR0IrOWM4dFJDam90OTY0UDR5REFMREZYeTZtNlVBVml4b3JwYndS?=
 =?utf-8?B?WnEzZ1RROUpBRkdDVGVESWlZWWxlUnU2UVJ0QUJ0LzFSd3UxNk1JajFZZzhY?=
 =?utf-8?B?QkcxMW40NmFHc3VJaUtkQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NU95cldQa1pndGZIRkpGbGZRdWN5c1ZKUTIvY3FTZHQ4dkNBQ2d4NUMyekxx?=
 =?utf-8?B?Mk9zK0l4SXNxTWswa1k3Qm9rWHZZdmFFajZEcVc1cGZYSkFacUkwOFh6QWNp?=
 =?utf-8?B?Z0hwVFBuZ0VZUllTbzVvMjRRUFJWQ0FLbFVUQlFIWHRjcW84bnBwemxsYnBI?=
 =?utf-8?B?Z09pVVoxak5lOVRyU052bGNYcytLalNpN25EVlVKMjczTURPQnR2ZCtXSHdT?=
 =?utf-8?B?R0dSTUFnaHQrbUdRRkFHYlRlZnk5YUxNQjFkZGdmRTg3YVBYb1N2Q0RyNThU?=
 =?utf-8?B?dkg3KzB3V3VJdm5vQWQ3S290UzdCQ20vTlJaSTA0M2hzSmEyQ00xZ1phNldV?=
 =?utf-8?B?M0lDRTB5cFRhNzZOaHNOcDk1TmxVWU5aTDdUS01qeXM0ZWpSNllKaVpHZkJL?=
 =?utf-8?B?b1VEVVlhU0JRT0o2bmFPZDNHRCt3cXQ2UERtTDdBa25xdDB4T1d6RCs2QWZ4?=
 =?utf-8?B?NGtaZlJMUVRYb0c4TEZ0cUErODM3c3JSTGR2cTRxVnNhdHRMV1VndHFVVnVp?=
 =?utf-8?B?cXZOQ0ZuOXVlaVVKY2wrUExlQm9GUFZYWDl1SG5PWGMyUzJZZElMVTBvSnh5?=
 =?utf-8?B?aFhLNTFRZkdDK1ArVWdtQXBOZGtwRGRnWFI0R0p4ajVYY1BlcHB5NnRtVjNl?=
 =?utf-8?B?RjBUOXREM2JCZU1tRTNLNUhaVTFHZmI4dTBaMS9JYVlnSnNnU1dBWnpnRE5n?=
 =?utf-8?B?cHIxZ2xwWTRsUkpxenhqR0JZazdIVU56Z0FtUXdwNW5PaHFQL3ZPb1dXV1kv?=
 =?utf-8?B?SFpQYnoxT01KYktwK2RuV1duMys1QTBRcTh1ZjFGS2VoR2dVbGhGYlFmcnhO?=
 =?utf-8?B?N0h1RjRZWUE4a3VKQWRlWVJqT1dpYzh2RSt6aEdRdE1yYnBkY3Q1MFpTeHoz?=
 =?utf-8?B?WUhQTytadVExMURlVm1iREtvTmdGVkR6TkVlNEFLcWFQUitWTFNnS1RseU9r?=
 =?utf-8?B?YzRKK0diNHpobmV5aU1vbDJQL0Nsd3E3dCtrSFI1ZmtNR2U3THZDZ2RWSVpP?=
 =?utf-8?B?MjgwOGRRTW5KQWlSRitjQjdmTmtzdE5oci95QWthNVQvMDkzTWFYN3BkOWhm?=
 =?utf-8?B?S0w5Ukk2MjNmS3RhaXkyZDFoUzk5RkMvcUZ3UEdqWjcvaWNTOTNmOG00OURJ?=
 =?utf-8?B?S1RKVTl0eE1ZWGpiRmNsY0NKU3ZuSVBWOWxCR1E0VmdKZ1BLQitkUTN2R29Y?=
 =?utf-8?B?WVZpZk5mV3V1ZDNRR0kvNnJqWDM2NHJKWjFYbWduTXcxTmMvUlRKTGxWZEFE?=
 =?utf-8?B?KzZkZjg1clp1eTZKQkcrMkRQR1M3ZVV4aW54MEZGSUZKN0xFM0tNaGZmeXk3?=
 =?utf-8?B?eXVETDVsOHRCMEViQzVUWlhEb1JpNXdva25RK1ZDWHp1TjV5c3JQS1ltTitQ?=
 =?utf-8?B?ek12WnNHWEo0SU5MV1RPK3k0YWk0dkdRMjZTN1V2Q081RFQ5MjlQRUVBckU5?=
 =?utf-8?B?VFVsanBRb0hpWGlNaGhkWHpraDBOYUxWejRVU2J1MHR6d1JSU2FFalBOOElk?=
 =?utf-8?B?M2p6RklORzU3d21KN08wVGlUNjNpVUE0K2NVSjFScThBUTBDSnBDcHVmRlJN?=
 =?utf-8?B?amE5Mmd1ckVMckdXWkNvbUF3aDdCaWh2eVNGVXM0WVlSQTg4WGIrMFJoaEM3?=
 =?utf-8?B?Q2p4UHdHeEU5ZkdvMjd4WWlOR0ZaZlJFdTN5V0tGdVFCMDJqVWhpYVZWbVVn?=
 =?utf-8?B?WitaR3d2SlJCdWdIaEJ1elg0U1JPUkhOamtHUHgraDlSKzluRWVvMHRUcHpn?=
 =?utf-8?B?dkprbDI5c3VaM2JEOWl6MmVZdDdpN2o1Wkl0Sit2SGFYbzl3YnA3WGZnd2Jw?=
 =?utf-8?B?YStzK2NlZG9vTFBueGhDSzZ4TkhZL0prckxYTTA2bG9uQXBtSE51dTJjZzJw?=
 =?utf-8?B?dEhhQWdmVnhQdURFYnFEMjRZdGp1d0NYdys1alN4MnZZejB0QWxCOUw1cmQz?=
 =?utf-8?B?ZjV4VDJqNmd2bGt4WUtJSVN4K2xraDByRDl3YUU1YU9EcHFEKzQrWGtZUE9D?=
 =?utf-8?B?RFhzVThVb2UyUEg1RzhzcjVPK0dPc1lPdFIrVGFvdGdiTXlTSm5DbGcraVBG?=
 =?utf-8?B?elJxQmVuVTBoeTdxeE5LWnZuYUVQWEQwcDVLV0pWTmVYYVRpMmdQbU9vQ0tP?=
 =?utf-8?Q?7HH+j1wjebcCUP3QaUcCPeqdS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16a01b1-0183-4430-53a2-08dc6f50da43
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 11:20:22.9554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uPFSUYmv116MW7JKQa+cE9IyrTIxNEXH3KAIh7P5G+7LdFXSp448/6jleFUhuOb6fAOFYEuZ/NYZ/lbv7Xzmlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5084
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUHUgTGVodWkgPHB1bGVo
dWlAaHVhd2VpLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWF5IDcsIDIwMjQgODo0NyBQTQ0KPiBU
bzogV2FuZywgWGlhbyBXIDx4aWFvLncud2FuZ0BpbnRlbC5jb20+OyBwYXVsLndhbG1zbGV5QHNp
Zml2ZS5jb207DQo+IHBhbG1lckBkYWJiZWx0LmNvbTsgYW91QGVlY3MuYmVya2VsZXkuZWR1OyBs
dWtlLnIubmVsc0BnbWFpbC5jb207DQo+IHhpLndhbmdAZ21haWwuY29tOyBiam9ybkBrZXJuZWwu
b3JnDQo+IENjOiBhc3RAa2VybmVsLm9yZzsgZGFuaWVsQGlvZ2VhcmJveC5uZXQ7IGFuZHJpaUBr
ZXJuZWwub3JnOw0KPiBtYXJ0aW4ubGF1QGxpbnV4LmRldjsgZWRkeXo4N0BnbWFpbC5jb207IHNv
bmdAa2VybmVsLm9yZzsNCj4geW9uZ2hvbmcuc29uZ0BsaW51eC5kZXY7IGpvaG4uZmFzdGFiZW5k
QGdtYWlsLmNvbTsga3BzaW5naEBrZXJuZWwub3JnOw0KPiBzZGZAZ29vZ2xlLmNvbTsgaGFvbHVv
QGdvb2dsZS5jb207IGpvbHNhQGtlcm5lbC5vcmc7IGxpbnV4LQ0KPiByaXNjdkBsaXN0cy5pbmZy
YWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBicGZAdmdlci5rZXJuZWwu
b3JnOw0KPiBMaSwgSGFpY2hlbmcgPGhhaWNoZW5nLmxpQGludGVsLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gcmlzY3YsIGJwZjogT3B0aW1pemUgemV4dHcgaW5zbiB3aXRoIFpiYSBleHRl
bnNpb24NCj4gDQo+IA0KPiBPbiAyMDI0LzUvNyAxODo0NSwgWGlhbyBXYW5nIHdyb3RlOg0KPiA+
IFRoZSBaYmEgZXh0ZW5zaW9uIHByb3ZpZGVzIGFkZC51dyBpbnNuIHdoaWNoIGNhbiBiZSB1c2Vk
IHRvIGltcGxlbWVudA0KPiA+IHpleHQudyB3aXRoIHJzMiBzZXQgYXMgWkVSTy4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFhpYW8gV2FuZyA8eGlhby53LndhbmdAaW50ZWwuY29tPg0KPiA+IC0t
LQ0KPiA+ICAgYXJjaC9yaXNjdi9LY29uZmlnICAgICAgIHwgMTkgKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICAgYXJjaC9yaXNjdi9uZXQvYnBmX2ppdC5oIHwgMTggKysrKysrKysrKysrKysrKysr
DQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9hcmNoL3Jpc2N2L0tjb25maWcgYi9hcmNoL3Jpc2N2L0tjb25maWcNCj4gPiBpbmRl
eCA2YmVjMWJjZTY1ODYuLjA2NzkxMjdjYzBlYSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3Jpc2N2
L0tjb25maWcNCj4gPiArKysgYi9hcmNoL3Jpc2N2L0tjb25maWcNCj4gPiBAQCAtNTg2LDYgKzU4
NiwxNCBAQCBjb25maWcgUklTQ1ZfSVNBX1ZfUFJFRU1QVElWRQ0KPiA+ICAgCSAgcHJlZW1wdGlv
bi4gRW5hYmxpbmcgdGhpcyBjb25maWcgd2lsbCByZXN1bHQgaW4gaGlnaGVyIG1lbW9yeQ0KPiA+
ICAgCSAgY29uc3VtcHRpb24gZHVlIHRvIHRoZSBhbGxvY2F0aW9uIG9mIHBlci10YXNrJ3Mga2Vy
bmVsIFZlY3Rvcg0KPiBjb250ZXh0Lg0KPiA+DQo+ID4gK2NvbmZpZyBUT09MQ0hBSU5fSEFTX1pC
QQ0KPiA+ICsJYm9vbA0KPiA+ICsJZGVmYXVsdCB5DQo+ID4gKwlkZXBlbmRzIG9uICE2NEJJVCB8
fCAkKGNjLW9wdGlvbiwtbWFiaT1scDY0IC1tYXJjaD1ydjY0aW1hX3piYSkNCj4gPiArCWRlcGVu
ZHMgb24gITMyQklUIHx8ICQoY2Mtb3B0aW9uLC1tYWJpPWlscDMyIC1tYXJjaD1ydjMyaW1hX3pi
YSkNCj4gPiArCWRlcGVuZHMgb24gTExEX1ZFUlNJT04gPj0gMTUwMDAwIHx8IExEX1ZFUlNJT04g
Pj0gMjM5MDANCj4gPiArCWRlcGVuZHMgb24gQVNfSEFTX09QVElPTl9BUkNIDQo+ID4gKw0KPiA+
ICAgY29uZmlnIFRPT0xDSEFJTl9IQVNfWkJCDQo+ID4gICAJYm9vbA0KPiA+ICAgCWRlZmF1bHQg
eQ0KPiA+IEBAIC02MDEsNiArNjA5LDE3IEBAIGNvbmZpZyBUT09MQ0hBSU5fSEFTX1ZFQ1RPUl9D
UllQVE8NCj4gPiAgIAlkZWZfYm9vbCAkKGFzLWluc3RyLCAub3B0aW9uIGFyY2gkKGNvbW1hKSAr
diQoY29tbWEpICt6dmtiKQ0KPiA+ICAgCWRlcGVuZHMgb24gQVNfSEFTX09QVElPTl9BUkNIDQo+
ID4NCj4gPiArY29uZmlnIFJJU0NWX0lTQV9aQkENCj4gPiArCWJvb2wgIlpiYSBleHRlbnNpb24g
c3VwcG9ydCBmb3IgYml0IG1hbmlwdWxhdGlvbiBpbnN0cnVjdGlvbnMiDQo+ID4gKwlkZXBlbmRz
IG9uIFRPT0xDSEFJTl9IQVNfWkJBDQo+ID4gKwlkZXBlbmRzIG9uIFJJU0NWX0FMVEVSTkFUSVZF
DQo+ID4gKwlkZWZhdWx0IHkNCj4gPiArCWhlbHANCj4gPiArCSAgIEFkZHMgc3VwcG9ydCB0byBk
eW5hbWljYWxseSBkZXRlY3QgdGhlIHByZXNlbmNlIG9mIHRoZSBaQkENCj4gPiArCSAgIGV4dGVu
c2lvbiAoYWRkcmVzcyBnZW5lcmF0aW9uIGFjY2VsZXJhdGlvbikgYW5kIGVuYWJsZSBpdHMgdXNh
Z2UuDQo+IA0KPiBJdCB3b3VsZCBiZSBiZXR0ZXIgdG8gYWRkIFpiYSdzIGZ1bmN0aW9uIGRlc2Ny
aXB0aW9uIGxpa2UgWmJiLg0KDQpPSywgd291bGQgYWRkIHNvbWUgZGVzY3JpcHRpb24gb24gbmV4
dCB2ZXJzaW9uLg0KDQpUaGFua3MsDQpYaWFvDQoNCj4gDQo+ID4gKw0KPiA+ICsJICAgSWYgeW91
IGRvbid0IGtub3cgd2hhdCB0byBkbyBoZXJlLCBzYXkgWS4NCj4gPiArDQo+ID4gICBjb25maWcg
UklTQ1ZfSVNBX1pCQg0KPiA+ICAgCWJvb2wgIlpiYiBleHRlbnNpb24gc3VwcG9ydCBmb3IgYml0
IG1hbmlwdWxhdGlvbiBpbnN0cnVjdGlvbnMiDQo+ID4gICAJZGVwZW5kcyBvbiBUT09MQ0hBSU5f
SEFTX1pCQg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L25ldC9icGZfaml0LmggYi9hcmNo
L3Jpc2N2L25ldC9icGZfaml0LmgNCj4gPiBpbmRleCBmNGI2YjNiOWVkZGEuLjE4YTc4ODViYTk1
ZSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3Jpc2N2L25ldC9icGZfaml0LmgNCj4gPiArKysgYi9h
cmNoL3Jpc2N2L25ldC9icGZfaml0LmgNCj4gPiBAQCAtMTgsNiArMTgsMTEgQEAgc3RhdGljIGlu
bGluZSBib29sIHJ2Y19lbmFibGVkKHZvaWQpDQo+ID4gICAJcmV0dXJuIElTX0VOQUJMRUQoQ09O
RklHX1JJU0NWX0lTQV9DKTsNCj4gPiAgIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW5saW5lIGJvb2wg
cnZ6YmFfZW5hYmxlZCh2b2lkKQ0KPiA+ICt7DQo+ID4gKwlyZXR1cm4gSVNfRU5BQkxFRChDT05G
SUdfUklTQ1ZfSVNBX1pCQSkgJiYNCj4gcmlzY3ZfaGFzX2V4dGVuc2lvbl9saWtlbHkoUklTQ1Zf
SVNBX0VYVF9aQkEpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICAgc3RhdGljIGlubGluZSBib29sIHJ2
emJiX2VuYWJsZWQodm9pZCkNCj4gPiAgIHsNCj4gPiAgIAlyZXR1cm4gSVNfRU5BQkxFRChDT05G
SUdfUklTQ1ZfSVNBX1pCQikgJiYNCj4gcmlzY3ZfaGFzX2V4dGVuc2lvbl9saWtlbHkoUklTQ1Zf
SVNBX0VYVF9aQkIpOw0KPiA+IEBAIC05MzcsNiArOTQyLDE0IEBAIHN0YXRpYyBpbmxpbmUgdTE2
IHJ2Y19zZHNwKHUzMiBpbW05LCB1OCByczIpDQo+ID4gICAJcmV0dXJuIHJ2X2Nzc19pbnNuKDB4
NywgaW1tLCByczIsIDB4Mik7DQo+ID4gICB9DQo+ID4NCj4gPiArLyogUlY2NC1vbmx5IFpCQSBp
bnN0cnVjdGlvbnMuICovDQo+ID4gKw0KPiA+ICtzdGF0aWMgaW5saW5lIHUzMiBydnpiYV96ZXh0
dyh1OCByZCwgdTggcnMxKQ0KPiA+ICt7DQo+ID4gKwkvKiBhZGQudXcgcmQsIHJzMSwgWkVSTyAq
Lw0KPiA+ICsJcmV0dXJuIHJ2X3JfaW5zbigweDA0LCBSVl9SRUdfWkVSTywgcnMxLCAwLCByZCwg
MHgzYik7DQo+ID4gK30NCj4gPiArDQo+ID4gICAjZW5kaWYgLyogX19yaXNjdl94bGVuID09IDY0
ICovDQo+ID4NCj4gPiAgIC8qIEhlbHBlciBmdW5jdGlvbnMgdGhhdCBlbWl0IFJWQyBpbnN0cnVj
dGlvbnMgd2hlbiBwb3NzaWJsZS4gKi8NCj4gPiBAQCAtMTE1OSw2ICsxMTcyLDExIEBAIHN0YXRp
YyBpbmxpbmUgdm9pZCBlbWl0X3pleHRoKHU4IHJkLCB1OCBycywgc3RydWN0DQo+IHJ2X2ppdF9j
b250ZXh0ICpjdHgpDQo+ID4NCj4gPiAgIHN0YXRpYyBpbmxpbmUgdm9pZCBlbWl0X3pleHR3KHU4
IHJkLCB1OCBycywgc3RydWN0IHJ2X2ppdF9jb250ZXh0ICpjdHgpDQo+ID4gICB7DQo+ID4gKwlp
ZiAocnZ6YmFfZW5hYmxlZCgpKSB7DQo+ID4gKwkJZW1pdChydnpiYV96ZXh0dyhyZCwgcnMpLCBj
dHgpOw0KPiA+ICsJCXJldHVybjsNCj4gPiArCX0NCj4gDQo+IExvb2tzIGdvb2QgdG8gbWUuIEl0
IHNlZW1zIHRoYXQgWmJhIGhhcyBmZXdlciB1c2VzIGluIHJ2NjQgYnBmIGppdC4NCj4gDQo+ID4g
Kw0KPiA+ICAgCWVtaXRfc2xsaShyZCwgcnMsIDMyLCBjdHgpOw0KPiA+ICAgCWVtaXRfc3JsaShy
ZCwgcmQsIDMyLCBjdHgpOw0KPiA+ICAgfQ0K

