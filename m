Return-Path: <bpf+bounces-12112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C787C7B1A
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 03:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86F21C20A61
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 01:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4252BA35;
	Fri, 13 Oct 2023 01:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zjwm5jye"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38185A29;
	Fri, 13 Oct 2023 01:14:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE9AA9;
	Thu, 12 Oct 2023 18:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697159640; x=1728695640;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5uS4nFxQpDN+N7RP7jFeXTjILO90oXx2TYA3z5rPaNY=;
  b=Zjwm5jyesSC5ODR02my+rtIC365xHCO3CLqfIEwFH/TvWqSyfr2LOQrJ
   869CwiGSRLWylWfcDJsuH+iXOSTE842rp7uULCZ4A+A+W6uTJOX3WNuxT
   4LL4xxvX28e/ChhikfteLpCth0P6CmdiJhdTgqTPhCY/SWrdLvF10UIV6
   Zb+CGhTj7Xh9Ur1xcjRTeLfFKH5iOG5pGKCJAyZlnMCRKg0X3nyiJagTr
   cgJZwvFwIQlZOfJ74sAFPzDKShDyYlOjplG0iLqcaquld533PRAGDSP/M
   DDKtdoQrx/7cHdwptAk+szCEpWAwDyoaSHo7o/VSmjwl7xoY3pO8tj9vf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="383938422"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="383938422"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 18:13:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="845216991"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="845216991"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 18:13:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 18:13:59 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 18:13:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 18:13:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 18:13:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgkiGg34KE+0+v+ZD7VQS74/Z/bicXGkTCcroyOPCWAGGIoJIzvF3frT4urAhYmdWf5fwFLOmN/ZObskaUbiwrN8ngH2V/+fMoOoeLtdqTThMicLFfVpZHWQItKvD9FBIwBQMZ6eIQUO3FmEBMk2vbTY1a4f+Qd3FKqbv9cTpYyxHVHh07Wm9hZpN/a0jklrUZTCaL98yVmVmWM1eyQKm9cMnvSwR5B3a//ViqTSzwECyIe0gj2EjznmJBtJIUblpQYawzPfas5yW36hsM6UjpgqKI5dXJ8XGzhpcA3wLuCDmmsF/RvNoW9a+VZJxl3Ocw9+U0UNWuuwVXYrPoMzCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uS4nFxQpDN+N7RP7jFeXTjILO90oXx2TYA3z5rPaNY=;
 b=L2s63oBQ0uP7w2ajBioB/St5EIfuRe//L1o8n0PG257blKNWR7LsnxYcqqg+OMEhD2P1NjMO5yXBEcCMF6HcZosujSRYvzTv5WP8ZRqGtA2kRfelVWbBjb73/ds1265IIHoGB1tp8/xY4ozhRtfTK0vWBPh3NHmsXGSZcLyyTeZqssKZhRceTb8DYmG8C2kln00OPaxX3s+pI3JUYJaaoIJN6ylj1CagwAiuP4xzu6uy48PPq6GKzMrsra1FxVtjqGcDL5rZwAcieHxd/zGmFkC2ol60fPdhGFzXBZ/kxvgHcLANtYqWCkIt33p4eGPfbF15d650x+dpBS0/Y0j7lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by PH0PR11MB7660.namprd11.prod.outlook.com (2603:10b6:510:26f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 13 Oct
 2023 01:13:55 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c17:89e4:bb3d:d825]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c17:89e4:bb3d:d825%4]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 01:13:55 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Stanislav Fomichev <sdf@google.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, "song@kernel.org" <song@kernel.org>, "yhs@fb.com"
	<yhs@fb.com>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "haoluo@google.com"
	<haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "toke@kernel.org" <toke@kernel.org>, "willemb@google.com"
	<willemb@google.com>, "dsahern@kernel.org" <dsahern@kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "bjorn@kernel.org" <bjorn@kernel.org>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>
Subject: RE: [PATCH bpf-next v3 09/10] selftests/bpf: Add TX side to
 xdp_hw_metadata
Thread-Topic: [PATCH bpf-next v3 09/10] selftests/bpf: Add TX side to
 xdp_hw_metadata
Thread-Index: AQHZ9jUEV4ZXXLmxgUyxxNLfHZOinLBBJEwAgACNCACAAdYyAIADa0zw
Date: Fri, 13 Oct 2023 01:13:55 +0000
Message-ID: <PH0PR11MB58301E7F051FFB67E2C6B379D8D2A@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20231003200522.1914523-1-sdf@google.com>
 <20231003200522.1914523-10-sdf@google.com>
 <532af030-f2a6-5569-549b-bbd012ad2640@kernel.org>
 <ZSQsQMLUIum1hmOI@google.com> <ZSW2rn2zjJ0YfXXQ@google.com>
In-Reply-To: <ZSW2rn2zjJ0YfXXQ@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|PH0PR11MB7660:EE_
x-ms-office365-filtering-correlation-id: bd4f3eb7-4cb4-45e7-4ecb-08dbcb89abbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3qDecy05xR6eMF6zZ0X7sOlkBlFpLW1M8cOvgjPGTNtmbIAlDn0AHj/9NtMvt88TFtBQYYg9Yocki64ZOMyymy2lmLPCvUQb+kh6at9BDBg8sJEiGgwIyQRsxG6jhmxvSBexByzAB0VhSioObJfwMO91JKTrAIM5DWnwFK61pQX+eCugR/dwzgToWj0vvWNfxiYT33sD6Dy/x3DS+MqOpKsVSriq4oebNLAW1pUYwebCZcDT2oqt1Hp9fsL7Yx5tIO9l3QV5aJIZRRB43TNxlzb2daNkcjrzuOnMfVO9eVFg0/AC7vTYqfjGKLUPp+s5MeSJvhkIDkAUh23zyaCDzmopOWe9QHIEMwTHQXpvAgzhunaH3L9JKZ0vHwT+7FL5WkSjz1+WtHFDUzKb4hV5ucGGjh9aUo3o7QkBJP3aHv57iB6ml9KGaSnl/uX5JSV6sYxaHLJhyTz8Lc0vUtVFaK2GRvBzhGhu6nAmTPBKnrOsAHSD4sep1xzEtzspWIAw276024xwHSKcbi2W9G1al0xicsWXjZnmoc7nCSDDxM4zuvkPjv5wqdd3BXfy5/KNp5wLEiFswwf3eRkUfl54EeHrT+KcaxDvEHrBkWSxTVs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(7696005)(9686003)(53546011)(7416002)(478600001)(71200400001)(6506007)(26005)(83380400001)(2906002)(30864003)(54906003)(5660300002)(66446008)(66946007)(110136005)(316002)(64756008)(66476007)(76116006)(4326008)(8936002)(41300700001)(52536014)(8676002)(82960400001)(86362001)(122000001)(38070700005)(33656002)(55016003)(38100700002)(66556008)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3ZyMzJBUWs0YUVPTjNYRFdsZldXbGlFbnJIWXE4MG9tN2l6NFNwYmxjUFVt?=
 =?utf-8?B?YkhGS1lEY3pLUEE0cUg0dG85OW1lQlVvZDk2YUZHeGRNOTUyVUUyOGwyR2JD?=
 =?utf-8?B?bk1UUWpOa3RGaG1jM3NPdWhLOUwrRkJHU3pYVWZmZnVhT2hpVW5zb0JtYzBv?=
 =?utf-8?B?Q1hpb3BWZXBrS2lKbURaZDZrZWhRK2JYdXc4bnlGMUlRbFFNSTdwbUg3YmIx?=
 =?utf-8?B?cFAyWWNoMHg2RmVHTmErUUxZYldUR3l1NmRpQ0k0dkVCOEk0UkJXQlJKdm5K?=
 =?utf-8?B?RlRzY0RJVFBEdFNhMXlqMFZSMHlBU1lzeXE2dkVJbEhBU1AvUC9uWGtnR0Zq?=
 =?utf-8?B?YndESWFFMGZ3OUFHOXVRc1Y2VWpUaklRMDZJcHFRVzhNdklHL2tLZUpOWjZq?=
 =?utf-8?B?MzU1ZGJDMmRZQ25QdlMzcUlNeTBHeWY3VWIzaUduNFBhSit4aEV5cVk4cy9V?=
 =?utf-8?B?NUtTazhuYkR5SzRJSzhTQmtybDRNNE52d0NmK20zWS85ZWtONG9qUGNMQUY2?=
 =?utf-8?B?ZWJtTitRem5RejZoMUV3ZnlzQjlBQlQ5QlpYeDhqbFhMRXVXK3I1ak96Ymh2?=
 =?utf-8?B?U1VpTDAyYU11cUV3ZStxMnJsVjFoT2JKQVRTTW44TzF6c2NWUVN6S21EeDhr?=
 =?utf-8?B?L2c4MHk5KzV4SlpFMHJiRjZlQ0tMdlFHYXR2RkhoNjJWdTVlUzJ2S2k4ZjMy?=
 =?utf-8?B?czBDaURHanBMM2g4OHJ0TjN6MmpnUWFGbGZybzl6RzR4K21zZi9rVk1MalBC?=
 =?utf-8?B?SWZTanRkeEp5K2h6M2VVTStXYUprTkpiVkhxRHU5RUF6T1hZeEV3aEVZZ0Q3?=
 =?utf-8?B?ZVBmRlJNS1p3R29XaUNQWkR1eEE4UlBPRXByMWV3dElpamZCM2JFKzkyYlVU?=
 =?utf-8?B?dkMxOTRCS21jcDRwZ1ZnWTRXai9PalNWQTdkL3FtWkE2NXowR2NQMjJhL05k?=
 =?utf-8?B?Um00SjdrYlhYa2Y2bTlaLzBmM3puTU5RcklQcW5aNWVJMXNid2xpTHhta3lq?=
 =?utf-8?B?OEtJMjlJNGlJTGt1NEVmbzhkTmthTFRMY3JMUjhFRmtrUXg0N2p4Mk85NXpy?=
 =?utf-8?B?WXVCaXRtSGJHL3Yzd0hLd3c0S2QyVUhhSVMzT2RKVUVldGE4dU1mdnpBTm1Y?=
 =?utf-8?B?WDZzNXFGdXFUQmtpY0JqSWo4ekI4eVd0Z2NKMFBxRVp2M0RHSHBKT2Vmc1hw?=
 =?utf-8?B?U2t3UmlDR3FmaXJ2aG1OcU5ySDFKdE92eVZiVjVQajN4R1BlOExLckYvUW05?=
 =?utf-8?B?SUJFYWE1YUhkeWNCcWtseGhxcjJ2K1VHUTdsSmpYdnY2dW1kTWNUZDA4NjJP?=
 =?utf-8?B?Um1DU3pLMENqRDN5UDEyRlNqdlZEaG9VMmUxa2daTjlncFdwRWtkazQxZmxP?=
 =?utf-8?B?ei9MTDc2UzNDa0lkQ2R1azZVYlp4TDMvZlhOSVV3emNnLzQ2RGUwM2xyL0ww?=
 =?utf-8?B?Q2dlUG5BdC83UzZQR0o2c2NYZTFqeFFYOUd1RFpkb3Z2M0k5VFI5bGhvMk8z?=
 =?utf-8?B?NzQ3N0ZLQmNoVENTU0tBS3c2eTFUME5tZE1BRkY3VlNjaVN0RGhpNzQ3N1Fj?=
 =?utf-8?B?U2JPSXYyZllzZGtLWjJ1bXBuYW9GaFQwbmY2WWlESlNhcTZMUGhtTWsyWVdN?=
 =?utf-8?B?TmhEdWc3NVhkYTh4UDRlSTEzcVRkWWJNeGFUc0p2dDFPYjVyT1BLWDR6bVky?=
 =?utf-8?B?M01GM2NJcGV4OVlkdDJ1TzFiazNrM0ZyRGlTN0RRc1ZHWkppUWpMaU5mWE1i?=
 =?utf-8?B?aC9SSU9sTUxTL3pWc0E2eHVBUk10OVpGVUplei9WV1Eya05QWUZJMDN3bFF2?=
 =?utf-8?B?R3pkdlMzaXc2bWZIK2kyREZwUXQyNVhoRGFLVHdDbytPc0l6RVRhMG54L3ZI?=
 =?utf-8?B?VUVITDZHR0F0Qy9qZTQvcEZoR0JGTkptdE5qQlNsMkxXSmFiZGo2Q3pYK1Ns?=
 =?utf-8?B?YW84WHQxQmwvMHA0aUZVZ1plM1VSTGJPc2xKTlVUK0htSXFFZFJ3OUU4Tk9q?=
 =?utf-8?B?bjF3UUF3bS9yZ2F0OS8xVmY4eDRUQ0N3WkVFMVdvM2ZZZ2s5Lzg2YmJZSjR2?=
 =?utf-8?B?UWlWTXBvdFlVaGRhZmsyN2pIcjk5RlRURXlWa2VqR1pYbWZ4VlpNRXl1NXcz?=
 =?utf-8?B?RzdEMVBMSXNQdTFtb1hHMGY0NGljMkd3NmZHWkFtS0d3d2Y0Z1NsdzlBNDZD?=
 =?utf-8?B?N2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4f3eb7-4cb4-45e7-4ecb-08dbcb89abbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 01:13:55.5375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oZkbQv/kU0Z5T/OFX3/oG5M8dLGmDchurEo9gSqEwQxz27kD5AZBO2bpvmHBvWB9n4OUGp2cXCyeuj/zyMZtS7M1zw9X99mbakgTJOrL3Yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7660
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gV2VkbmVzZGF5LCBPY3RvYmVyIDExLCAyMDIzIDQ6NDAgQU0sIFN0YW5pc2xhdiBGb21pY2hl
diA8c2RmQGdvb2dsZS5jb20+IHdyb3RlOg0KPk9uIDEwLzA5LCBTdGFuaXNsYXYgRm9taWNoZXYg
d3JvdGU6DQo+PiBPbiAxMC8wOSwgSmVzcGVyIERhbmdhYXJkIEJyb3VlciB3cm90ZToNCj4+ID4N
Cj4+ID4NCj4+ID4gT24gMDMvMTAvMjAyMyAyMi4wNSwgU3RhbmlzbGF2IEZvbWljaGV2IHdyb3Rl
Og0KPj4gPiA+IFdoZW4gd2UgZ2V0IGEgcGFja2V0IG9uIHBvcnQgOTA5MSwgd2Ugc3dhcCBzcmMv
ZHN0IGFuZCBzZW5kIGl0IG91dC4NCj4+ID4gPiBBdCB0aGlzIHBvaW50IHdlIGFsc28gcmVxdWVz
dCB0aGUgdGltZXN0YW1wIGFuZCBjaGVja3N1bSBvZmZsb2Fkcy4NCj4+ID4gPg0KPj4gPiA+IENo
ZWNrc3VtIG9mZmxvYWQgaXMgdmVyaWZpZWQgYnkgbG9va2luZyBhdCB0aGUgdGNwZHVtcCBvbiB0
aGUgb3RoZXIgc2lkZS4NCj4+ID4gPiBUaGUgdG9vbCBwcmludHMgcHNldWRvLWhlYWRlciBjc3Vt
IGFuZCB0aGUgZmluYWwgb25lIGl0IGV4cGVjdHMuDQo+PiA+ID4gVGhlIGZpbmFsIGNoZWNrc3Vt
IGFjdHVhbGx5IG1hdGNoZXMgdGhlIGluY29taW5nIHBhY2tldHMgY2hlY2tzdW0NCj4+ID4gPiBi
ZWNhdXNlIHdlIG9ubHkgZmxpcCB0aGUgc3JjL2RzdCBhbmQgZG9uJ3QgY2hhbmdlIHRoZSBwYXls
b2FkLg0KPj4gPiA+DQo+PiA+ID4gU29tZSBvdGhlciByZWxhdGVkIGNoYW5nZXM6DQo+PiA+ID4g
LSBzd2l0Y2hlZCB0byB6ZXJvY29weSBtb2RlIGJ5IGRlZmF1bHQ7IG5ldyBmbGFnIGNhbiBiZSB1
c2VkIHRvIGZvcmNlDQo+PiA+ID4gICAgb2xkIGJlaGF2aW9yDQo+PiA+ID4gLSByZXF1ZXN0IGZp
eGVkIHR4X21ldGFkYXRhX2xlbiBoZWFkcm9vbQ0KPj4gPiA+IC0gc29tZSBvdGhlciBzbWFsbCBm
aXhlcyAodW1lbSBzaXplLCBmaWxsIGlkeCtpLCBldGMpDQo+PiA+ID4NCj4+ID4gPiBtdmJ6Mzp+
IyAuL3hkcF9od19tZXRhZGF0YSBldGgzDQo+PiA+ID4gLi4uDQo+PiA+ID4gMHgxMDYyY2I4OiBy
eF9kZXNjWzBdLT5hZGRyPTgwMTAwIGFkZHI9ODAxMDAgY29tcF9hZGRyPTgwMTAwDQo+PiA+ID4g
cnhfaGFzaDogMHgyRTFCNTBCOSB3aXRoIFJTUyB0eXBlOjB4MkENCj4+ID4gPiByeF90aW1lc3Rh
bXA6ICAxNjkxNDM2MzY5NTMyMDQ3MTM5IChzZWM6MTY5MTQzNjM2OS41MzIwKQ0KPj4gPiA+IFhE
UCBSWC10aW1lOiAgIDE2OTE0MzYzNjkyNjE3NTY4MDMgKHNlYzoxNjkxNDM2MzY5LjI2MTgpIGRl
bHRhIHNlYzotDQo+MC4yNzAzICgtMjcwMjkwLjMzNiB1c2VjKQ0KPj4gPg0KPj4gPiBJIGd1ZXNz
IHN5c3RlbSB0aW1lIGlzbid0IGNvbmZpZ3VyZWQgdG8gYmUgaW4gc3luYyB3aXRoIE5JQyBIVyB0
aW1lLA0KPj4gPiBhcyBkZWx0YSBpcyBhIG5lZ2F0aXZlIG9mZnNldC4NCj4+ID4NCj4+ID4gPiBB
Rl9YRFAgdGltZTogICAxNjkxNDM2MzY5MjYxODc4ODM5IChzZWM6MTY5MTQzNjM2OS4yNjE5KSBk
ZWx0YQ0KPnNlYzowLjAwMDEgKDEyMi4wMzYgdXNlYykNCj4+ID4gVGhlIEFGX1hEUCB0aW1lIGlz
IGFsc28gc29mdHdhcmUgc3lzdGVtIHRpbWUgYW5kIGNvbXBhcmVkIHRvIFhEUA0KPj4gPiBSWC10
aW1lLCBpdCBzaG93cyBhIGRlbHRhIG9mIDEyMiB1c2VjLiAgVGhpcyBudW1iZXIgaW5kaWNhdGUg
dG8gbWUNCj4+ID4gdGhhdCB0aGUgQ1BVIGlzIGxpa2VseSBjb25maWd1cmVkIHdpdGggcG93ZXIg
c2F2aW5nIHNsZWVwIHN0YXRlcy4NCj4+DQo+PiBZZXMsIEkgZG9uJ3QgZG8gYW55IHN5bmNocm9u
aXphdGlvbiBhbmQgZG9uJ3QgZGlzYWJsZSB0aGUgc2xlZXAgc3RhdGVzLg0KPj4NCj4+ID4gPiAw
eDEwNjJjYjg6IHBpbmctcG9uZyB3aXRoIGNzdW09M2I4ZSAod2FudCBkZTdlKSBjc3VtX3N0YXJ0
PTU0DQo+PiA+ID4gY3N1bV9vZmZzZXQ9Ng0KPj4gPiA+IDB4MTA2MmNiODogY29tcGxldGUgdHgg
aWR4PTAgYWRkcj0xMA0KPj4gPiA+IDB4MTA2MmNiODogdHhfdGltZXN0YW1wOiAgMTY5MTQzNjM2
OTU5ODQxOTUwNQ0KPj4gPiA+IChzZWM6MTY5MTQzNjM2OS41OTg0KQ0KPj4gPg0KPj4gPiBDb3Vs
ZCB3ZSBhZGQgc29tZXRoaW5nIHRoYXQgd2UgY2FuIHJlbGF0ZSB0eF90aW1lc3RhbXAgdG8/DQo+
PiA+DQo+PiA+IExpa2Ugd2UgZG8gd2l0aCB0aGUgb3RoZXIgZGVsdGEgY2FsY3VsYXRpb25zLCBh
cyBpdCBoZWxwcyB1cyB0bw0KPj4gPiB1bmRlcnN0YW5kL3ZhbGlkYXRlIGlmIHRoZSBudW1iZXIg
d2UgZ2V0IGJhY2sgaXMgc2FuZS4gTGlrZSBuZWdhdGl2ZQ0KPj4gPiBvZmZzZXQgYWJvdmVzIHRl
bGxzIHVzIHRoYXQgc3lzdGVtIHRpbWUgc3luYyBpc24ndCBjb25maWd1cmVkLCBhbmQNCj4+ID4g
dGhhdCBzeXN0ZW0gaGF2ZSBjb25maWd1cmVzIEMtc3RhdGVzLg0KPj4gPg0KPj4gPiBJIHN1Z2dl
c3QgZGVsdGEgY29tcGFyaW5nICJ0eF90aW1lc3RhbXAiIHRvICJyeF90aW1lc3RhbXAiLCBhcyB0
aGV5DQo+PiA+IGFyZSB0aGUgc2FtZSBjbG9jayBkb21haW4uICBJdCB3aWxsIHRlbGwgdXMgdGhl
IHRvdGFsIHRpbWUgc3BlbmQNCj4+ID4gZnJvbSBIVyBSWCB0byBIVyBUWCwgY291bnRpbmcgYWxs
IHRoZSB0aW1lIHVzZWQgYnkgc29mdHdhcmUgInBpbmctcG9uZyIuDQo+PiA+DQo+PiA+ICAxNjkx
NDM2MzY5LjU5ODQtMTY5MTQzNjM2OS41MzIwID0gMC4wNjY0IHNlYyA9IDY2LjQgbXMNCj4+ID4N
Cj4+ID4gV2hlbiBpbXBsZW1lbnRpbmcgdGhpcywgaXQgY291bGQgYmUgKDEpIHByYWN0aWNhbCB0
byBzdG9yZSB0aGUNCj4+ID4gInJ4X3RpbWVzdGFtcCIgaW4gdGhlIG1ldGFkYXRhIGFyZWEgb2Yg
dGhlIGNvbXBsZXRpb24gcGFja2V0LCBvciAoMikNCj4+ID4gc2hvdWxkIHdlIGhhdmUgYSBtZWNo
YW5pc20gZm9yIGV4dGVybmFsIHN0b3JhZ2UgdGhhdCBjYW4gYmUga2V5ZWQgb24NCj4+ID4gdGhl
IHVtZW0gImFkZHIiPw0KPj4NCj4+IFNvdW5kcyBnb29kLiBJIGNhbiBwcm9iYWJseSBqdXN0IHN0
b3JlIGxhc3QgcnhfdGltZXN0YW1wIHNvbWV3aGVyZSBpbg0KPj4gdGhlIGdsb2JhbCB2YXIgYW5k
IGRvIGEgZGVsdGEgb24gdHg/IFNpbmNlIHRoZSB0ZXN0IGlzIHNpbmdsZSB0aHJlYWRlZA0KPj4g
YW5kIHNlcXVlbnRpYWwsIG5vdCBzdXJlIHdlIG5lZWQgdGhlIG1lY2hhbmlzbSB0byBwYXNzIHRo
ZSB0c3RhbXAgYXJvdW5kLg0KPj4gTE1LIGlmIHlvdSBkaXNhZ3JlZSBhbmQgSSdtIG1pc3Npbmcg
c29tZXRoaW5nLg0KPg0KPkkgZW5kZWQgdXAgcmVzaHVmZmxpbmcgY3VycmVudCBjb2RlIGEgYml0
IHRvIGJhc2ljYWxseSB1c2UgY2xvY2sgdGFpIGFzIGEgcmVmZXJlbmNlIGZvcg0KPmV2ZXJ5IGxp
bmUuIEZlZWxzIGxpa2UgaXRzIGEgYml0IHNpbXBsZXIgd2hlbiBldmVyeXRoaW5nIGlzIHJlZmVy
ZW5jZWQgYWdhaW5zdCB0aGUNCj5zYW1lIGNsb2NrPw0KPg0KPkZvciBSWCBwYXJ0LCBJIHJlbmFt
ZSBleGlzdGluZyBYRFAvQUZfWERQIHRvIEhXL1NXIGFuZCBkdW1wIHRoZW0gYm90aA0KPnJlbGF0
aXZlIHRvIHRhaS4NCj4NCj4weDE5NWQxZjA6IHJ4X2Rlc2NbMF0tPmFkZHI9ODAxMDAgYWRkcj04
MDEwMCBjb21wX2FkZHI9ODAxMDANCj5yeF9oYXNoOiAweEVFMkJCRDU5IHdpdGggUlNTIHR5cGU6
MHgyQQ0KPnJ4X3RpbWVzdGFtcDogIDE2OTY5NjkzMTIxMjUyMTIxNzkgKHNlYzoxNjk2OTY5MzEy
LjEyNTIpDQo+SFcgUlgtdGltZTogICAxNjk2OTY5MzEyMTI1MjEyMTc5IChzZWM6MTY5Njk2OTMx
Mi4xMjUyKSB0byBDTE9DS19UQUkgZGVsdGENCj5zZWM6LTAuMTMzOSAoLTEzMzg2Mi45NjggdXNl
YykNCj5TVyBSWC10aW1lOiAgIDE2OTY5NjkzMTE5OTEyODM0MjEgKHNlYzoxNjk2OTY5MzExLjk5
MTMpIHRvIENMT0NLX1RBSSBkZWx0YQ0KPnNlYzowLjAwMDEgKDY1Ljc5MCB1c2VjKQ0KPjB4MTk1
ZDFmMDogcGluZy1wb25nIHdpdGggY3N1bT0zYjhlICh3YW50IGRlNWYpIGNzdW1fc3RhcnQ9NTQg
Y3N1bV9vZmZzZXQ9Ng0KPjB4MTk1ZDFmMDogY29tcGxldGUgdHggaWR4PTAgYWRkcj04DQo+dHhf
dGltZXN0YW1wOiAgMTY5Njk2OTMxMjE1Mjk1OTc1OSAoc2VjOjE2OTY5NjkzMTIuMTUzMCkNCj5T
VyBSWC10aW1lOiAgIDE2OTY5NjkzMTE5OTEyODM0MjEgKHNlYzoxNjk2OTY5MzExLjk5MTMpIHRv
IENMT0NLX1RBSSBkZWx0YQ0KPnNlYzowLjAxMDEgKDEwMTM5Ljg2MiB1c2VjKQ0KPkhXIFJYLXRp
bWU6ICAgMTY5Njk2OTMxMjEyNTIxMjE3OSAoc2VjOjE2OTY5NjkzMTIuMTI1MikgdG8gSFcgVFgt
DQo+Y29tcGxldGUtdGltZSBkZWx0YSBzZWM6MC4wMjc3ICgyNzc0Ny41ODAgdXNlYykNCj5IVyBU
WC1jb21wbGV0ZS10aW1lOiAgIDE2OTY5NjkzMTIxNTI5NTk3NTkgKHNlYzoxNjk2OTY5MzEyLjE1
MzApIHRvDQo+Q0xPQ0tfVEFJIGRlbHRhIHNlYzotMC4xNTE1ICgtMTUxNTM2LjQ3NiB1c2VjKQ0K
Pg0KPkZvciBUWCBwYXJ0LCBJIGFkZCBhIGJ1bmNoIG9mIHJlZmVyZW5jZSBwb2ludHM6DQo+MSkg
U1cgUlgtdGltZSAobWV0YS0+eGRwX3RpbWVzdGFtcCkgdnMgQ0xPQ0tfVEFJIChha2EgdGFpLWF0
LWNvbXBsZXRlLXRpbWUpDQo+MikgSFcgUlgtdGltZSAobWV0YS0+cnhfdGltZXN0YW1wKSB2cyBI
VyBUWC1jb21wbGV0ZS10aW1lIChuZXcgYWZfeGRwDQo+dGltZXN0YW1wKQ0KPjMpIEhXIFRYLWNv
bXBsZXRlLXRpbWUgdnMgQ0xPQ0tfVEFJDQo+DQo+V2hhdCBkbyB5b3UgdGhpbms/IFNlZSB0aGUg
cGF0Y2ggYmVsb3cuDQoNCkhpIFN0YW5pc2xhdiwNCg0KRm9yIG1lLCB0aGUgIkNMT0NLX1RBSSIg
aW4gdGhlIHByaW50aW5nIGlzIGEgYml0IGNvbmZ1c2luZyBiZWNhdXNlDQogMS4gVGhlcmUgYXJl
IHR3byB2YWx1ZSBvZiB0YWkgd2hpY2ggcmVmZXIgdG8gZGlmZmVyZW50IG1vbWVudCBidXQgaGF2
aW5nIHRoZSBzYW1lIG5hbWUgIkNMT0NLX1RBSSINCiAyLiBTVyBSWC10aW1lIGlzIGFsc28gYSBj
bG9jayB0YWkuDQoNClNvLCAgSSBzdWdnZXN0IHRvIGNoYW5nZSB0aGUgbmFtaW5nOg0KIC0gSFcg
UlgtdGltZTogdGhlIG1vbWVudCBOSUMgcmVjZWl2ZSB0aGUgcGFja2V0IChiYXNlZCBvbiBQSEMp
DQogLSBYRFAgUlgtdGltZTogdGhlIG1vbWVudCBicGYgcHJvZyBwYXJzZSB0aGUgcGFja2V0IChi
YXNlZCBvbiB0YWkpDQogLSBTVyBSWC10aW1lOiB0aGUgbW9tZW50IHVzZXIgYXBwIHJlY2VpdmUg
dGhlIHBhY2tldCAoYmFzZWQgb24gdGFpKQ0KIC0gSFcgVFgtY29tcGxldGUtdGltZTogdGhlIG1v
bWVudCBOSUMgc2VuZCBvdXQgdGhlIHBhY2tldCAoYmFzZWQgb24gUEhDKQ0KIC0gU1cgVFgtY29t
cGxldGUtdGltZTogIHRoZSBtb21lbnQgdXNlciBhcHAga25vdyB0aGUgcGFja2V0IGJlaW5nIHNl
bmQgb3V0IChiYXNlZCBvbiB0YWkpDQoNClRoYW5rcyAmIFJlZ2FyZHMNClNpYW5nDQoNCj4NCj5O
b3RlOiBhbGwgMyBvZiB0aGUgYWJvdmUgc2hvdWxkLCBpbiB0aGVvcnksIGJlIG1vcmUgb3IgbGVz
cyBjb25zdGFudCAod2l0aCBpcnENCj5tb2RlcmF0aW9uIC8gZXRjIGRpc2FibGVkKS4gQnV0IGZv
ciBtZSBvbiBtbHg1ICgyKSB0aGV5IGFyZSBub3QgYW5kIGxvb2tzIGxpa2UgaHcgcngNCj50aW1l
c3RhbXAgaml0dGVycyBhIHF1aXRlIGEgYml0LiBJIGRvbid0IGhhdmUgYSBjbHVlIHJpZ3Qgbm93
IG9uIHdoeSwgd2lsbCB0cnkgdG8gdGFrZSBhDQo+c2VwYXJhdGUgbG9vaywgYnV0IGl0J3MgdW5y
ZWxhdGVkIHRvIHRoZSB0eCBzaWRlLg0KPg0KPg0KPmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9icGYveGRwX2h3X21ldGFkYXRhLmMNCj5iL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2JwZi94ZHBfaHdfbWV0YWRhdGEuYw0KPmluZGV4IGFiODNkMGJhNjc2My4uNjRhOTBkNzQ3
OWMxIDEwMDY0NA0KPi0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi94ZHBfaHdfbWV0
YWRhdGEuYw0KPisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi94ZHBfaHdfbWV0YWRh
dGEuYw0KPkBAIC01Nyw2ICs1Nyw4IEBAIGNvbnN0IGNoYXIgKmlmbmFtZTsNCj4gaW50IGlmaW5k
ZXg7DQo+IGludCByeHE7DQo+IGJvb2wgc2tpcF90eDsNCj4rX191NjQgbGFzdF9od19yeF90aW1l
c3RhbXA7DQo+K19fdTY0IGxhc3Rfc3dfcnhfdGltZXN0YW1wOw0KPg0KPiB2b2lkIHRlc3RfX2Zh
aWwodm9pZCkgeyAvKiBmb3IgbmV0d29ya19oZWxwZXJzLmMgKi8gfQ0KPg0KPkBAIC0xNjcsNiAr
MTY5LDE2IEBAIHN0YXRpYyBfX3U2NCBnZXR0aW1lKGNsb2NraWRfdCBjbG9ja19pZCkNCj4gCXJl
dHVybiAoX191NjQpIHQudHZfc2VjICogTkFOT1NFQ19QRVJfU0VDICsgdC50dl9uc2VjOyAgfQ0K
Pg0KPitzdGF0aWMgdm9pZCBwcmludF90c3RhbXBfZGVsdGEoY29uc3QgY2hhciAqbmFtZSwgY29u
c3QgY2hhciAqcmVmbmFtZSwNCj4rX191NjQgdHN0YW1wLCBfX3U2NCByZWZlcmVuY2UpIHsNCj4r
CV9fczY0IGRlbHRhID0gKF9fczY0KXJlZmVyZW5jZSAtIChfX3M2NCl0c3RhbXA7DQo+Kw0KPisJ
cHJpbnRmKCIlczogICAlbGx1IChzZWM6JTAuNGYpIHRvICVzIGRlbHRhIHNlYzolMC40ZiAoJTAu
M2YgdXNlYylcbiIsDQo+KwkgICAgICAgbmFtZSwgdHN0YW1wLCAoZG91YmxlKXRzdGFtcCAvIE5B
Tk9TRUNfUEVSX1NFQywgcmVmbmFtZSwNCj4rCSAgICAgICAoZG91YmxlKWRlbHRhIC8gTkFOT1NF
Q19QRVJfU0VDLA0KPisJICAgICAgIChkb3VibGUpZGVsdGEgLyAxMDAwKTsNCj4rfQ0KPisNCj4g
c3RhdGljIHZvaWQgdmVyaWZ5X3hkcF9tZXRhZGF0YSh2b2lkICpkYXRhLCBjbG9ja2lkX3QgY2xv
Y2tfaWQpICB7DQo+IAlzdHJ1Y3QgeGRwX21ldGEgKm1ldGE7DQo+QEAgLTE4MiwyMiArMTk0LDE1
IEBAIHN0YXRpYyB2b2lkIHZlcmlmeV94ZHBfbWV0YWRhdGEodm9pZCAqZGF0YSwgY2xvY2tpZF90
DQo+Y2xvY2tfaWQpDQo+IAlwcmludGYoInJ4X3RpbWVzdGFtcDogICVsbHUgKHNlYzolMC40Zilc
biIsIG1ldGEtPnJ4X3RpbWVzdGFtcCwNCj4gCSAgICAgICAoZG91YmxlKW1ldGEtPnJ4X3RpbWVz
dGFtcCAvIE5BTk9TRUNfUEVSX1NFQyk7DQo+IAlpZiAobWV0YS0+cnhfdGltZXN0YW1wKSB7DQo+
LQkJX191NjQgdXNyX2Nsb2NrID0gZ2V0dGltZShjbG9ja19pZCk7DQo+LQkJX191NjQgeGRwX2Ns
b2NrID0gbWV0YS0+eGRwX3RpbWVzdGFtcDsNCj4tCQlfX3M2NCBkZWx0YV9YID0geGRwX2Nsb2Nr
IC0gbWV0YS0+cnhfdGltZXN0YW1wOw0KPi0JCV9fczY0IGRlbHRhX1gyVSA9IHVzcl9jbG9jayAt
IHhkcF9jbG9jazsNCj4tDQo+LQkJcHJpbnRmKCJYRFAgUlgtdGltZTogICAlbGx1IChzZWM6JTAu
NGYpIGRlbHRhIHNlYzolMC40ZiAoJTAuM2YNCj51c2VjKVxuIiwNCj4tCQkgICAgICAgeGRwX2Ns
b2NrLCAoZG91YmxlKXhkcF9jbG9jayAvIE5BTk9TRUNfUEVSX1NFQywNCj4tCQkgICAgICAgKGRv
dWJsZSlkZWx0YV9YIC8gTkFOT1NFQ19QRVJfU0VDLA0KPi0JCSAgICAgICAoZG91YmxlKWRlbHRh
X1ggLyAxMDAwKTsNCj4tDQo+LQkJcHJpbnRmKCJBRl9YRFAgdGltZTogICAlbGx1IChzZWM6JTAu
NGYpIGRlbHRhIHNlYzolMC40ZiAoJTAuM2YNCj51c2VjKVxuIiwNCj4tCQkgICAgICAgdXNyX2Ns
b2NrLCAoZG91YmxlKXVzcl9jbG9jayAvIE5BTk9TRUNfUEVSX1NFQywNCj4tCQkgICAgICAgKGRv
dWJsZSlkZWx0YV9YMlUgLyBOQU5PU0VDX1BFUl9TRUMsDQo+LQkJICAgICAgIChkb3VibGUpZGVs
dGFfWDJVIC8gMTAwMCk7DQo+LQl9DQo+KwkJX191NjQgcmVmX3RzdGFtcCA9IGdldHRpbWUoY2xv
Y2tfaWQpOw0KPisNCj4rCQkvKiBzdG9yZSByZWNlaXZlZCB0aW1lc3RhbXBzIHRvIGNhbGN1bGF0
ZSBhIGRlbHRhIGF0IHR4ICovDQo+KwkJbGFzdF9od19yeF90aW1lc3RhbXAgPSBtZXRhLT5yeF90
aW1lc3RhbXA7DQo+KwkJbGFzdF9zd19yeF90aW1lc3RhbXAgPSBtZXRhLT54ZHBfdGltZXN0YW1w
Ow0KPg0KPisJCXByaW50X3RzdGFtcF9kZWx0YSgiSFcgUlgtdGltZSIsICJDTE9DS19UQUkiLCBt
ZXRhLQ0KPj5yeF90aW1lc3RhbXAsIHJlZl90c3RhbXApOw0KPisJCXByaW50X3RzdGFtcF9kZWx0
YSgiU1cgUlgtdGltZSIsICJDTE9DS19UQUkiLCBtZXRhLQ0KPj54ZHBfdGltZXN0YW1wLCByZWZf
dHN0YW1wKTsNCj4rCX0NCj4gfQ0KPg0KPiBzdGF0aWMgdm9pZCB2ZXJpZnlfc2tiX21ldGFkYXRh
KGludCBmZCkgQEAgLTI0NSw3ICsyNTAsNyBAQCBzdGF0aWMgdm9pZA0KPnZlcmlmeV9za2JfbWV0
YWRhdGEoaW50IGZkKQ0KPiAJcHJpbnRmKCJza2IgaHd0c3RhbXAgaXMgbm90IGZvdW5kIVxuIik7
ICB9DQo+DQo+LXN0YXRpYyBib29sIGNvbXBsZXRlX3R4KHN0cnVjdCB4c2sgKnhzaykNCj4rc3Rh
dGljIGJvb2wgY29tcGxldGVfdHgoc3RydWN0IHhzayAqeHNrLCBjbG9ja2lkX3QgY2xvY2tfaWQp
DQo+IHsNCj4gCXN0cnVjdCB4c2tfdHhfbWV0YWRhdGEgKm1ldGE7DQo+IAlfX3U2NCBhZGRyOw0K
PkBAIC0yNjAsOSArMjY1LDE3IEBAIHN0YXRpYyBib29sIGNvbXBsZXRlX3R4KHN0cnVjdCB4c2sg
KnhzaykNCj4gCW1ldGEgPSBkYXRhIC0gc2l6ZW9mKHN0cnVjdCB4c2tfdHhfbWV0YWRhdGEpOw0K
Pg0KPiAJcHJpbnRmKCIlcDogY29tcGxldGUgdHggaWR4PSV1IGFkZHI9JWxseFxuIiwgeHNrLCBp
ZHgsIGFkZHIpOw0KPi0JcHJpbnRmKCIlcDogdHhfdGltZXN0YW1wOiAgJWxsdSAoc2VjOiUwLjRm
KVxuIiwgeHNrLA0KPi0JICAgICAgIG1ldGEtPmNvbXBsZXRpb24udHhfdGltZXN0YW1wLA0KPisN
Cj4rCXByaW50ZigidHhfdGltZXN0YW1wOiAgJWxsdSAoc2VjOiUwLjRmKVxuIiwNCj4rbWV0YS0+
Y29tcGxldGlvbi50eF90aW1lc3RhbXAsDQo+IAkgICAgICAgKGRvdWJsZSltZXRhLT5jb21wbGV0
aW9uLnR4X3RpbWVzdGFtcCAvIE5BTk9TRUNfUEVSX1NFQyk7DQo+KwlpZiAobWV0YS0+Y29tcGxl
dGlvbi50eF90aW1lc3RhbXApIHsNCj4rCQlfX3U2NCByZWZfdHN0YW1wID0gZ2V0dGltZShjbG9j
a19pZCk7DQo+Kw0KPisJCXByaW50X3RzdGFtcF9kZWx0YSgiSFcgVFgtY29tcGxldGUtdGltZSIs
ICJDTE9DS19UQUkiLCBtZXRhLQ0KPj5jb21wbGV0aW9uLnR4X3RpbWVzdGFtcCwgcmVmX3RzdGFt
cCk7DQo+KwkJcHJpbnRfdHN0YW1wX2RlbHRhKCJTVyBSWC10aW1lIiwgIkNMT0NLX1RBSSIsDQo+
bGFzdF9zd19yeF90aW1lc3RhbXAsIHJlZl90c3RhbXApOw0KPisJCXByaW50X3RzdGFtcF9kZWx0
YSgiSFcgUlgtdGltZSIsICJIVyBUWC1jb21wbGV0ZS10aW1lIiwNCj5sYXN0X2h3X3J4X3RpbWVz
dGFtcCwgbWV0YS0+Y29tcGxldGlvbi50eF90aW1lc3RhbXApOw0KPisJfQ0KPisNCj4gCXhza19y
aW5nX2NvbnNfX3JlbGVhc2UoJnhzay0+Y29tcCwgMSk7DQo+DQo+IAlyZXR1cm4gdHJ1ZTsNCj5A
QCAtMjc2LDcgKzI4OSw3IEBAIHN0YXRpYyBib29sIGNvbXBsZXRlX3R4KHN0cnVjdCB4c2sgKnhz
aykNCj4gCX0gXA0KPiB9IHdoaWxlICgwKQ0KPg0KPi1zdGF0aWMgdm9pZCBwaW5nX3Bvbmcoc3Ry
dWN0IHhzayAqeHNrLCB2b2lkICpyeF9wYWNrZXQpDQo+K3N0YXRpYyB2b2lkIHBpbmdfcG9uZyhz
dHJ1Y3QgeHNrICp4c2ssIHZvaWQgKnJ4X3BhY2tldCwgY2xvY2tpZF90DQo+K2Nsb2NrX2lkKQ0K
PiB7DQo+IAlzdHJ1Y3QgeHNrX3R4X21ldGFkYXRhICptZXRhOw0KPiAJc3RydWN0IGlwdjZoZHIg
KmlwNmggPSBOVUxMOw0KPkBAIC00MTgsMTQgKzQzMSwxNCBAQCBzdGF0aWMgaW50IHZlcmlmeV9t
ZXRhZGF0YShzdHJ1Y3QgeHNrICpyeF94c2ssIGludCByeHEsIGludA0KPnNlcnZlcl9mZCwgY2xv
Y2tpZF90DQo+DQo+IAkJCWlmICghc2tpcF90eCkgew0KPiAJCQkJLyogbWlycm9yIHRoZSBwYWNr
ZXQgYmFjayAqLw0KPi0JCQkJcGluZ19wb25nKHhzaywgeHNrX3VtZW1fX2dldF9kYXRhKHhzay0N
Cj4+dW1lbV9hcmVhLCBhZGRyKSk7DQo+KwkJCQlwaW5nX3BvbmcoeHNrLCB4c2tfdW1lbV9fZ2V0
X2RhdGEoeHNrLQ0KPj51bWVtX2FyZWEsIGFkZHIpLCBjbG9ja19pZCk7DQo+DQo+IAkJCQlyZXQg
PSBraWNrX3R4KHhzayk7DQo+IAkJCQlpZiAocmV0KQ0KPiAJCQkJCXByaW50Zigia2lja190eCBy
ZXQ9JWRcbiIsIHJldCk7DQo+DQo+IAkJCQlmb3IgKGludCBqID0gMDsgaiA8IDUwMDsgaisrKSB7
DQo+LQkJCQkJaWYgKGNvbXBsZXRlX3R4KHhzaykpDQo+KwkJCQkJaWYgKGNvbXBsZXRlX3R4KHhz
aywgY2xvY2tfaWQpKQ0KPiAJCQkJCQlicmVhazsNCj4gCQkJCQl1c2xlZXAoMTAqMTAwMCk7DQo+
IAkJCQl9DQo+DQo+DQo+PiA+ID4gMHgxMDYyY2I4OiBjb21wbGV0ZSByeCBpZHg9MTI4IGFkZHI9
ODAxMDANCj4+ID4gPg0KPj4gPiA+IG12Yno0On4jIG5jICAtTnUgLXExICR7TVZCWjNfTElOS19M
T0NBTF9JUH0lZXRoMyA5MDkxDQo+PiA+ID4NCj4+ID4gPiBtdmJ6NDp+IyB0Y3BkdW1wIC12dngg
LWkgZXRoMyB1ZHANCj4+ID4gPiAJdGNwZHVtcDogbGlzdGVuaW5nIG9uIGV0aDMsIGxpbmstdHlw
ZSBFTjEwTUIgKEV0aGVybmV0KSwgc25hcHNob3QNCj4+ID4gPiBsZW5ndGggMjYyMTQ0IGJ5dGVz
DQo+PiA+ID4gMTI6MjY6MDkuMzAxMDc0IElQNiAoZmxvd2xhYmVsIDB4MzVmYTUsIGhsaW0gMTI3
LCBuZXh0LWhlYWRlciBVRFAgKDE3KQ0KPnBheWxvYWQgbGVuZ3RoOiAxMSkgZmU4MDo6MTI3MDpm
ZGZmOmZlNDg6MTA4Ny41NTgwNyA+DQo+ZmU4MDo6MTI3MDpmZGZmOmZlNDg6MTA3Ny45MDkxOiBb
YmFkIHVkcCBja3N1bSAweDNiOGUgLT4gMHhkZTdlIV0gVURQLCBsZW5ndGggMw0KPj4gPiA+ICAg
ICAgICAgIDB4MDAwMDogIDYwMDMgNWZhNSAwMDBiIDExN2YgZmU4MCAwMDAwIDAwMDAgMDAwMA0K
Pj4gPiA+ICAgICAgICAgIDB4MDAxMDogIDEyNzAgZmRmZiBmZTQ4IDEwODcgZmU4MCAwMDAwIDAw
MDAgMDAwMA0KPj4gPiA+ICAgICAgICAgIDB4MDAyMDogIDEyNzAgZmRmZiBmZTQ4IDEwNzcgZDlm
ZiAyMzgzIDAwMGIgM2I4ZQ0KPj4gPiA+ICAgICAgICAgIDB4MDAzMDogIDc4NjQgNzANCj4+ID4g
PiAxMjoyNjowOS4zMDE5NzYgSVA2IChmbG93bGFiZWwgMHgzNWZhNSwgaGxpbSAxMjcsIG5leHQt
aGVhZGVyIFVEUCAoMTcpDQo+cGF5bG9hZCBsZW5ndGg6IDExKSBmZTgwOjoxMjcwOmZkZmY6ZmU0
ODoxMDc3LjkwOTEgPg0KPmZlODA6OjEyNzA6ZmRmZjpmZTQ4OjEwODcuNTU4MDc6IFt1ZHAgc3Vt
IG9rXSBVRFAsIGxlbmd0aCAzDQo+PiA+ID4gICAgICAgICAgMHgwMDAwOiAgNjAwMyA1ZmE1IDAw
MGIgMTE3ZiBmZTgwIDAwMDAgMDAwMCAwMDAwDQo+PiA+ID4gICAgICAgICAgMHgwMDEwOiAgMTI3
MCBmZGZmIGZlNDggMTA3NyBmZTgwIDAwMDAgMDAwMCAwMDAwDQo+PiA+ID4gICAgICAgICAgMHgw
MDIwOiAgMTI3MCBmZGZmIGZlNDggMTA4NyAyMzgzIGQ5ZmYgMDAwYiBkZTdlDQo+PiA+ID4gICAg
ICAgICAgMHgwMDMwOiAgNzg2NCA3MA0KPj4gPiA+DQo+PiA+ID4gU2lnbmVkLW9mZi1ieTogU3Rh
bmlzbGF2IEZvbWljaGV2IDxzZGZAZ29vZ2xlLmNvbT4NCj4+ID4gPiAtLS0NCj4+ID4gPiAgIHRv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi94ZHBfaHdfbWV0YWRhdGEuYyB8IDIwMg0KPisrKysr
KysrKysrKysrKysrLQ0KPj4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDE5MiBpbnNlcnRpb25zKCsp
LCAxMCBkZWxldGlvbnMoLSkNCj4+ID4gPg0KPj4gPiA+IGRpZmYgLS1naXQgYS90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9icGYveGRwX2h3X21ldGFkYXRhLmMNCj4+ID4gPiBiL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2JwZi94ZHBfaHdfbWV0YWRhdGEuYw0KPj4gPiA+IGluZGV4IDYxMzMyMWVi
ODRjMS4uYWI4M2QwYmE2NzYzIDEwMDY0NA0KPj4gPiA+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2JwZi94ZHBfaHdfbWV0YWRhdGEuYw0KPj4gPiA+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2JwZi94ZHBfaHdfbWV0YWRhdGEuYw0KPj4gPiA+IEBAIC0xMCw3ICsxMCw5IEBA
DQo+PiA+ID4gICAgKiAgIC0gcnhfaGFzaA0KPj4gPiA+ICAgICoNCj4+ID4gPiAgICAqIFRYOg0K
Pj4gPiA+IC0gKiAtIFRCRA0KPj4gPiA+ICsgKiAtIFVEUCA5MDkxIHBhY2tldHMgdHJpZ2dlciBU
WCByZXBseQ0KPj4gPiA+ICsgKiAtIFRYIEhXIHRpbWVzdGFtcCBpcyByZXF1ZXN0ZWQgYW5kIHJl
cG9ydGVkIGJhY2sgdXBvbg0KPj4gPiA+ICsgY29tcGxldGlvbg0KPj4gPiA+ICsgKiAtIFRYIGNo
ZWNrc3VtIGlzIHJlcXVlc3RlZA0KPj4gPiA+ICAgICovDQo+PiA+ID4gICAjaW5jbHVkZSA8dGVz
dF9wcm9ncy5oPg0KPj4gPiA+IEBAIC0yNCwxNCArMjYsMTcgQEANCj4+ID4gWy4uLl0NCj4+ID4g
PiBAQCAtNTEsMjIgKzU2LDI0IEBAIHN0cnVjdCB4c2sgKnJ4X3hzazsNCj4+ID4gWy4uLl0NCj4+
ID4gPiBAQCAtMTI5LDEyICsxMzYsMjIgQEAgc3RhdGljIHZvaWQgcmVmaWxsX3J4KHN0cnVjdCB4
c2sgKnhzaywgX191NjQNCj4+ID4gPiBhZGRyKQ0KPj4gPiBbLi4uXQ0KPj4gPiA+IEBAIC0yMjgs
NiArMjQ1LDExNyBAQCBzdGF0aWMgdm9pZCB2ZXJpZnlfc2tiX21ldGFkYXRhKGludCBmZCkNCj4+
ID4gPiAgIAlwcmludGYoInNrYiBod3RzdGFtcCBpcyBub3QgZm91bmQhXG4iKTsNCj4+ID4gPiAg
IH0NCj4+ID4gPiArc3RhdGljIGJvb2wgY29tcGxldGVfdHgoc3RydWN0IHhzayAqeHNrKSB7DQo+
PiA+ID4gKwlzdHJ1Y3QgeHNrX3R4X21ldGFkYXRhICptZXRhOw0KPj4gPiA+ICsJX191NjQgYWRk
cjsNCj4+ID4gPiArCXZvaWQgKmRhdGE7DQo+PiA+ID4gKwlfX3UzMiBpZHg7DQo+PiA+ID4gKw0K
Pj4gPiA+ICsJaWYgKCF4c2tfcmluZ19jb25zX19wZWVrKCZ4c2stPmNvbXAsIDEsICZpZHgpKQ0K
Pj4gPiA+ICsJCXJldHVybiBmYWxzZTsNCj4+ID4gPiArDQo+PiA+ID4gKwlhZGRyID0gKnhza19y
aW5nX2NvbnNfX2NvbXBfYWRkcigmeHNrLT5jb21wLCBpZHgpOw0KPj4gPiA+ICsJZGF0YSA9IHhz
a191bWVtX19nZXRfZGF0YSh4c2stPnVtZW1fYXJlYSwgYWRkcik7DQo+PiA+ID4gKwltZXRhID0g
ZGF0YSAtIHNpemVvZihzdHJ1Y3QgeHNrX3R4X21ldGFkYXRhKTsNCj4+ID4gPiArDQo+PiA+ID4g
KwlwcmludGYoIiVwOiBjb21wbGV0ZSB0eCBpZHg9JXUgYWRkcj0lbGx4XG4iLCB4c2ssIGlkeCwg
YWRkcik7DQo+PiA+ID4gKwlwcmludGYoIiVwOiB0eF90aW1lc3RhbXA6ICAlbGx1IChzZWM6JTAu
NGYpXG4iLCB4c2ssDQo+PiA+ID4gKwkgICAgICAgbWV0YS0+Y29tcGxldGlvbi50eF90aW1lc3Rh
bXAsDQo+PiA+ID4gKwkgICAgICAgKGRvdWJsZSltZXRhLT5jb21wbGV0aW9uLnR4X3RpbWVzdGFt
cCAvIE5BTk9TRUNfUEVSX1NFQyk7DQo+PiA+ID4gKwl4c2tfcmluZ19jb25zX19yZWxlYXNlKCZ4
c2stPmNvbXAsIDEpOw0KPj4gPiA+ICsNCj4+ID4gPiArCXJldHVybiB0cnVlOw0KPj4gPiA+ICt9
DQo+PiA+ID4gKw0KPj4gPiA+ICsjZGVmaW5lIHN3YXAoYSwgYiwgbGVuKSBkbyB7IFwNCj4+ID4g
PiArCWZvciAoaW50IGkgPSAwOyBpIDwgbGVuOyBpKyspIHsgXA0KPj4gPiA+ICsJCV9fdTggdG1w
ID0gKChfX3U4ICopYSlbaV07IFwNCj4+ID4gPiArCQkoKF9fdTggKilhKVtpXSA9ICgoX191OCAq
KWIpW2ldOyBcDQo+PiA+ID4gKwkJKChfX3U4ICopYilbaV0gPSB0bXA7IFwNCj4+ID4gPiArCX0g
XA0KPj4gPiA+ICt9IHdoaWxlICgwKQ0KPj4gPiA+ICsNCj4+ID4gPiArc3RhdGljIHZvaWQgcGlu
Z19wb25nKHN0cnVjdCB4c2sgKnhzaywgdm9pZCAqcnhfcGFja2V0KSB7DQo+PiA+ID4gKwlzdHJ1
Y3QgeHNrX3R4X21ldGFkYXRhICptZXRhOw0KPj4gPiA+ICsJc3RydWN0IGlwdjZoZHIgKmlwNmgg
PSBOVUxMOw0KPj4gPiA+ICsJc3RydWN0IGlwaGRyICppcGggPSBOVUxMOw0KPj4gPiA+ICsJc3Ry
dWN0IHhkcF9kZXNjICp0eF9kZXNjOw0KPj4gPiA+ICsJc3RydWN0IHVkcGhkciAqdWRwaDsNCj4+
ID4gPiArCXN0cnVjdCBldGhoZHIgKmV0aDsNCj4+ID4gPiArCV9fc3VtMTYgd2FudF9jc3VtOw0K
Pj4gPiA+ICsJdm9pZCAqZGF0YTsNCj4+ID4gPiArCV9fdTMyIGlkeDsNCj4+ID4gPiArCWludCBy
ZXQ7DQo+PiA+ID4gKwlpbnQgbGVuOw0KPj4gPiA+ICsNCj4+ID4gPiArCXJldCA9IHhza19yaW5n
X3Byb2RfX3Jlc2VydmUoJnhzay0+dHgsIDEsICZpZHgpOw0KPj4gPiA+ICsJaWYgKHJldCAhPSAx
KSB7DQo+PiA+ID4gKwkJcHJpbnRmKCIlcDogZmFpbGVkIHRvIHJlc2VydmUgdHggc2xvdFxuIiwg
eHNrKTsNCj4+ID4gPiArCQlyZXR1cm47DQo+PiA+ID4gKwl9DQo+PiA+ID4gKw0KPj4gPiA+ICsJ
dHhfZGVzYyA9IHhza19yaW5nX3Byb2RfX3R4X2Rlc2MoJnhzay0+dHgsIGlkeCk7DQo+PiA+ID4g
Kwl0eF9kZXNjLT5hZGRyID0gaWR4ICUgKFVNRU1fTlVNIC8gMikgKiBVTUVNX0ZSQU1FX1NJWkUg
Kw0KPnNpemVvZihzdHJ1Y3QgeHNrX3R4X21ldGFkYXRhKTsNCj4+ID4gPiArCWRhdGEgPSB4c2tf
dW1lbV9fZ2V0X2RhdGEoeHNrLT51bWVtX2FyZWEsIHR4X2Rlc2MtPmFkZHIpOw0KPj4gPiA+ICsN
Cj4+ID4gPiArCW1ldGEgPSBkYXRhIC0gc2l6ZW9mKHN0cnVjdCB4c2tfdHhfbWV0YWRhdGEpOw0K
Pj4gPiA+ICsJbWVtc2V0KG1ldGEsIDAsIHNpemVvZigqbWV0YSkpOw0KPj4gPiA+ICsJbWV0YS0+
ZmxhZ3MgPSBYRFBfVFhfTUVUQURBVEFfVElNRVNUQU1QOw0KPj4gPiA+ICsNCj4+ID4gPiArCWV0
aCA9IHJ4X3BhY2tldDsNCj4+ID4gPiArDQo+PiA+ID4gKwlpZiAoZXRoLT5oX3Byb3RvID09IGh0
b25zKEVUSF9QX0lQKSkgew0KPj4gPiA+ICsJCWlwaCA9ICh2b2lkICopKGV0aCArIDEpOw0KPj4g
PiA+ICsJCXVkcGggPSAodm9pZCAqKShpcGggKyAxKTsNCj4+ID4gPiArCX0gZWxzZSBpZiAoZXRo
LT5oX3Byb3RvID09IGh0b25zKEVUSF9QX0lQVjYpKSB7DQo+PiA+ID4gKwkJaXA2aCA9ICh2b2lk
ICopKGV0aCArIDEpOw0KPj4gPiA+ICsJCXVkcGggPSAodm9pZCAqKShpcDZoICsgMSk7DQo+PiA+
ID4gKwl9IGVsc2Ugew0KPj4gPiA+ICsJCXByaW50ZigiJXA6IGZhaWxlZCB0byBkZXRlY3QgSVAg
dmVyc2lvbiBmb3IgcGluZyBwb25nICUwNHhcbiIsIHhzaywNCj5ldGgtPmhfcHJvdG8pOw0KPj4g
PiA+ICsJCXhza19yaW5nX3Byb2RfX2NhbmNlbCgmeHNrLT50eCwgMSk7DQo+PiA+ID4gKwkJcmV0
dXJuOw0KPj4gPiA+ICsJfQ0KPj4gPiA+ICsNCj4+ID4gPiArCWxlbiA9IEVUSF9ITEVOOw0KPj4g
PiA+ICsJaWYgKGlwNmgpDQo+PiA+ID4gKwkJbGVuICs9IHNpemVvZigqaXA2aCkgKyBudG9ocyhp
cDZoLT5wYXlsb2FkX2xlbik7DQo+PiA+ID4gKwlpZiAoaXBoKQ0KPj4gPiA+ICsJCWxlbiArPSBu
dG9ocyhpcGgtPnRvdF9sZW4pOw0KPj4gPiA+ICsNCj4+ID4gPiArCXN3YXAoZXRoLT5oX2Rlc3Qs
IGV0aC0+aF9zb3VyY2UsIEVUSF9BTEVOKTsNCj4+ID4gPiArCWlmIChpcGgpDQo+PiA+ID4gKwkJ
c3dhcCgmaXBoLT5zYWRkciwgJmlwaC0+ZGFkZHIsIDQpOw0KPj4gPiA+ICsJZWxzZQ0KPj4gPiA+
ICsJCXN3YXAoJmlwNmgtPnNhZGRyLCAmaXA2aC0+ZGFkZHIsIDE2KTsNCj4+ID4gPiArCXN3YXAo
JnVkcGgtPnNvdXJjZSwgJnVkcGgtPmRlc3QsIDIpOw0KPj4gPiA+ICsNCj4+ID4gPiArCXdhbnRf
Y3N1bSA9IHVkcGgtPmNoZWNrOw0KPj4gPiA+ICsJaWYgKGlwNmgpDQo+PiA+ID4gKwkJdWRwaC0+
Y2hlY2sgPSB+Y3N1bV9pcHY2X21hZ2ljKCZpcDZoLT5zYWRkciwgJmlwNmgtPmRhZGRyLA0KPj4g
PiA+ICsJCQkJCSAgICAgICBudG9ocyh1ZHBoLT5sZW4pLCBJUFBST1RPX1VEUCwgMCk7DQo+PiA+
ID4gKwllbHNlDQo+PiA+ID4gKwkJdWRwaC0+Y2hlY2sgPSB+Y3N1bV90Y3B1ZHBfbWFnaWMoaXBo
LT5zYWRkciwgaXBoLT5kYWRkciwNCj4+ID4gPiArCQkJCQkJIG50b2hzKHVkcGgtPmxlbiksDQo+
SVBQUk9UT19VRFAsIDApOw0KPj4gPiA+ICsNCj4+ID4gPiArCW1ldGEtPmZsYWdzIHw9IFhEUF9U
WF9NRVRBREFUQV9DSEVDS1NVTTsNCj4+ID4gPiArCWlmIChpcGgpDQo+PiA+ID4gKwkJbWV0YS0+
Y3N1bV9zdGFydCA9IHNpemVvZigqZXRoKSArIHNpemVvZigqaXBoKTsNCj4+ID4gPiArCWVsc2UN
Cj4+ID4gPiArCQltZXRhLT5jc3VtX3N0YXJ0ID0gc2l6ZW9mKCpldGgpICsgc2l6ZW9mKCppcDZo
KTsNCj4+ID4gPiArCW1ldGEtPmNzdW1fb2Zmc2V0ID0gb2Zmc2V0b2Yoc3RydWN0IHVkcGhkciwg
Y2hlY2spOw0KPj4gPiA+ICsNCj4+ID4gPiArCXByaW50ZigiJXA6IHBpbmctcG9uZyB3aXRoIGNz
dW09JTA0eCAod2FudCAlMDR4KSBjc3VtX3N0YXJ0PSVkDQo+Y3N1bV9vZmZzZXQ9JWRcbiIsDQo+
PiA+ID4gKwkgICAgICAgeHNrLCBudG9ocyh1ZHBoLT5jaGVjayksIG50b2hzKHdhbnRfY3N1bSks
DQo+PiA+ID4gK21ldGEtPmNzdW1fc3RhcnQsIG1ldGEtPmNzdW1fb2Zmc2V0KTsNCj4+ID4gPiAr
DQo+PiA+ID4gKwltZW1jcHkoZGF0YSwgcnhfcGFja2V0LCBsZW4pOyAvKiBkb24ndCBzaGFyZSB1
bWVtIGNodW5rIGZvciBzaW1wbGljaXR5DQo+Ki8NCj4+ID4gPiArCXR4X2Rlc2MtPm9wdGlvbnMg
fD0gWERQX1RYX01FVEFEQVRBOw0KPj4gPiA+ICsJdHhfZGVzYy0+bGVuID0gbGVuOw0KPj4gPiA+
ICsNCj4+ID4gPiArCXhza19yaW5nX3Byb2RfX3N1Ym1pdCgmeHNrLT50eCwgMSk7IH0NCj4+ID4g
PiArDQo+PiA+ID4gICBzdGF0aWMgaW50IHZlcmlmeV9tZXRhZGF0YShzdHJ1Y3QgeHNrICpyeF94
c2ssIGludCByeHEsIGludCBzZXJ2ZXJfZmQsIGNsb2NraWRfdA0KPmNsb2NrX2lkKQ0KPj4gPiA+
ICAgew0KPj4gPiA+ICAgCWNvbnN0IHN0cnVjdCB4ZHBfZGVzYyAqcnhfZGVzYzsgQEAgLTI1MCw2
ICszNzgsMTMgQEAgc3RhdGljIGludA0KPj4gPiA+IHZlcmlmeV9tZXRhZGF0YShzdHJ1Y3QgeHNr
ICpyeF94c2ssIGludCByeHEsIGludCBzZXJ2ZXJfZmQsIGNsb2NraWRfdA0KPj4gPiA+ICAgCXdo
aWxlICh0cnVlKSB7DQo+PiA+ID4gICAJCWVycm5vID0gMDsNCj4+ID4gPiArDQo+PiA+ID4gKwkJ
Zm9yIChpID0gMDsgaSA8IHJ4cTsgaSsrKSB7DQo+PiA+ID4gKwkJCXJldCA9IGtpY2tfcngoJnJ4
X3hza1tpXSk7DQo+PiA+ID4gKwkJCWlmIChyZXQpDQo+PiA+ID4gKwkJCQlwcmludGYoImtpY2tf
cnggcmV0PSVkXG4iLCByZXQpOw0KPj4gPiA+ICsJCX0NCj4+ID4gPiArDQo+PiA+ID4gICAJCXJl
dCA9IHBvbGwoZmRzLCByeHEgKyAxLCAxMDAwKTsNCj4+ID4gPiAgIAkJcHJpbnRmKCJwb2xsOiAl
ZCAoJWQpIHNraXA9JWxsdSBmYWlsPSVsbHUgcmVkaXI9JWxsdVxuIiwNCj4+ID4gPiAgIAkJICAg
ICAgIHJldCwgZXJybm8sIGJwZl9vYmotPmJzcy0+cGt0c19za2lwLCBAQCAtMjgwLDYgKzQxNSwy
Mg0KPj4gPiA+IEBAIHN0YXRpYyBpbnQgdmVyaWZ5X21ldGFkYXRhKHN0cnVjdCB4c2sgKnJ4X3hz
aywgaW50IHJ4cSwgaW50IHNlcnZlcl9mZCwNCj5jbG9ja2lkX3QNCj4+ID4gPiAgIAkJCSAgICAg
ICB4c2ssIGlkeCwgcnhfZGVzYy0+YWRkciwgYWRkciwgY29tcF9hZGRyKTsNCj4+ID4gPiAgIAkJ
CXZlcmlmeV94ZHBfbWV0YWRhdGEoeHNrX3VtZW1fX2dldF9kYXRhKHhzay0NCj4+dW1lbV9hcmVh
LCBhZGRyKSwNCj4+ID4gPiAgIAkJCQkJICAgIGNsb2NrX2lkKTsNCj4+ID4gPiArDQo+PiA+ID4g
KwkJCWlmICghc2tpcF90eCkgew0KPj4gPiA+ICsJCQkJLyogbWlycm9yIHRoZSBwYWNrZXQgYmFj
ayAqLw0KPj4gPiA+ICsJCQkJcGluZ19wb25nKHhzaywgeHNrX3VtZW1fX2dldF9kYXRhKHhzay0N
Cj4+dW1lbV9hcmVhLCBhZGRyKSk7DQo+PiA+ID4gKw0KPj4gPiA+ICsJCQkJcmV0ID0ga2lja190
eCh4c2spOw0KPj4gPiA+ICsJCQkJaWYgKHJldCkNCj4+ID4gPiArCQkJCQlwcmludGYoImtpY2tf
dHggcmV0PSVkXG4iLCByZXQpOw0KPj4gPiA+ICsNCj4+ID4gPiArCQkJCWZvciAoaW50IGogPSAw
OyBqIDwgNTAwOyBqKyspIHsNCj4+ID4gPiArCQkJCQlpZiAoY29tcGxldGVfdHgoeHNrKSkNCj4+
ID4gPiArCQkJCQkJYnJlYWs7DQo+PiA+ID4gKwkJCQkJdXNsZWVwKDEwKjEwMDApOw0KPj4gPg0K
Pj4gPiBJIGRvbid0IGZ1bGx5IGZvbGxvdyB3aHkgd2UgbmVlZCB0aGlzIHVzbGVlcCBoZXJlLg0K
Pj4NCj4+IFRvIGF2b2lkIHRoZSBidXN5cG9sbCBoZXJlIChzaW5jZSB3ZSBkb24ndCBjYXJlIHRv
byBtdWNoIGFib3V0IHBlcmYgaW4NCj4+IHRoZSB0ZXN0KS4gQnV0IEkgYWdyZWUsIHNob3VsZCBi
ZSBvayB0byBkcm9wLCB3aWxsIGRvLg0KPg0KPkkgdGFrZSB0aGF0IGJhY2ssIEkgaGF2ZSB0byBr
ZWVwIGl0LiBPdGhlcndpc2UgSSBkb24ndCBoYXZlIGEgZ29vZCBib3VuZCBvbiB3aGVuIHRvDQo+
c3RvcC9hYm9ydCB3aGVuIHdhaXRpbmcgZm9yIGNvbXBsZXRpb24uIChhbmQgdGhlIG51bWJlciBv
ZiBsb29wcyBuZWVkcyB0byBnbw0KPmZyb20gNTAwIHRvIHVuc3VyZS1ob3ctbWFueSkuDQo=

