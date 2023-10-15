Return-Path: <bpf+bounces-12228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F73D7C991B
	for <lists+bpf@lfdr.de>; Sun, 15 Oct 2023 15:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4101C208D1
	for <lists+bpf@lfdr.de>; Sun, 15 Oct 2023 13:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504056FC3;
	Sun, 15 Oct 2023 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WwyQ0fXn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0358663BA;
	Sun, 15 Oct 2023 13:28:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893BEA6;
	Sun, 15 Oct 2023 06:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697376524; x=1728912524;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fkk1AS19kpGpY+8RLzZbSS7nil8hDayl9rhf2PEEozM=;
  b=WwyQ0fXnz/VNrADOQNgFZVmniPJQKy0ppTBBwVbX1Z/t+BZhF2feem8E
   bkLmAaVx+k8AeIMC9IoXwKRxD+51Luk9Y5sgga9yYP41bTqBrVptfVhz3
   8WkuH7pRrfuCYb/0+TQQ9fBog7q/F9UcKKFASN3c79foeFxcnl9K19UcC
   2vr28okEX01HDhHj8hZ2KF5nmW0VRb2htj7Yivkf110FcuZsgldWy+BBj
   6Xm6MzFFRz1JNTiXexCVZJ8L7CPdj3guKVbsHMtxRvMKLe7iW4bVdUkIc
   qbtrFhmOrQFT1f+qpEP2GX10i7nbZKmpcN01QubVctBGaeu7p2jWqlDKy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="382619184"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="382619184"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 06:28:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="731980484"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="731980484"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2023 06:28:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 15 Oct 2023 06:28:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 15 Oct 2023 06:28:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 15 Oct 2023 06:28:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 15 Oct 2023 06:28:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyYE7ADZO87vL2E1x0OQG33MCVZIYT76lOA7D0W8NdHXX3hGj2H3Zh9xmZ9uYcAvl4PvM7fDCurrHGQ556EhBWAwfqkuhJpWInlOBsGOcs7REmqYqa4DleTBjpawex2IGrF1jdj3Gx06hy5Z5nYLHBVl3xIXB4woIHXDKwdxkjLh9t70v2A16faJp9/ZjW1X0clXEblwHIiPjHZRwmQPrz0u5IqI35KhUkMxkwdW5AYBOgz5sd4OaVhcSSqN/SoeBzpgHvGB6Y9l+73MhpLY8t8XwgvSOzGkU7+P7dtdS6U8GTdfSwqdIP1bI+VDyyuNx+N+sa1+frP35A2EqMVTeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fkk1AS19kpGpY+8RLzZbSS7nil8hDayl9rhf2PEEozM=;
 b=UiUJ+SVLK19sduLZJtLxLuS3K9cO8xdZQpcLZ58FqRp7O+7J13JJY8bVXqoFtandPeWvtx3wvn0Qa7G372aueNi8hp4AfSqIyTDN//awxA/NpYWGKh95QkUV0yk3tGY/8EK/a/tTkLKJYf/jJG8RVESN12XSUptVaoBTBZfTC0QRYsoT0jwiII6R4+Otu9rtqwsmZGMKlkGY0peWQ0ADFaI+vpdi7QtwjLc9fAv0NKKMu/GFbTlngAS9fLD0SmZ9YQtoeR792refSj+k99pxn2fjLe0JAVJUan+wPyPhnveA83JNwKwKs5TfhJLhn0c1bUfRQtG4qgo0OPlOnmxOSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by CYYPR11MB8306.namprd11.prod.outlook.com (2603:10b6:930:c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Sun, 15 Oct
 2023 13:28:40 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c17:89e4:bb3d:d825]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c17:89e4:bb3d:d825%4]) with mapi id 15.20.6886.034; Sun, 15 Oct 2023
 13:28:40 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Stanislav Fomichev <sdf@google.com>
CC: Jesper Dangaard Brouer <hawk@kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org"
	<andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
	"song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "haoluo@google.com" <haoluo@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"toke@kernel.org" <toke@kernel.org>, "willemb@google.com"
	<willemb@google.com>, "dsahern@kernel.org" <dsahern@kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "bjorn@kernel.org" <bjorn@kernel.org>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>
Subject: RE: [PATCH bpf-next v3 09/10] selftests/bpf: Add TX side to
 xdp_hw_metadata
Thread-Topic: [PATCH bpf-next v3 09/10] selftests/bpf: Add TX side to
 xdp_hw_metadata
Thread-Index: AQHZ9jUEV4ZXXLmxgUyxxNLfHZOinLBBJEwAgACNCACAAdYyAIADa0zwgAEsNACAAsqxkA==
Date: Sun, 15 Oct 2023 13:28:40 +0000
Message-ID: <PH0PR11MB5830668B2EB0551FA6679B08D8D0A@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20231003200522.1914523-1-sdf@google.com>
 <20231003200522.1914523-10-sdf@google.com>
 <532af030-f2a6-5569-549b-bbd012ad2640@kernel.org>
 <ZSQsQMLUIum1hmOI@google.com> <ZSW2rn2zjJ0YfXXQ@google.com>
 <PH0PR11MB58301E7F051FFB67E2C6B379D8D2A@PH0PR11MB5830.namprd11.prod.outlook.com>
 <CAKH8qBtackkX1vNGVUiNLpNHxDW41Ztn7qzA58Pt-bq7boJi4g@mail.gmail.com>
In-Reply-To: <CAKH8qBtackkX1vNGVUiNLpNHxDW41Ztn7qzA58Pt-bq7boJi4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|CYYPR11MB8306:EE_
x-ms-office365-filtering-correlation-id: 0b6dd3c9-e3bf-4e81-3757-08dbcd82a534
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ch4ekDpoWpSZbdac6xJqu6BtsC3aKIzd65Rt0B5TxgqL1ZwMII+uC0kWvnhh6sWg0atprEkTge+0FPcJQH9Q7e3VT2X0IXG3AZk8MMM2UFHie/dQ+l2KbocZqmcWXXOFX7TjuUTTvBdG1CiyE1S75xMFLZD9OLDJeKcHLzg7GTPEP2whD+U+fQUSqGrCT5fWEIHKsJNxJPIBl/VDqNmjKguH1ceE9riNHsA1/sQMfLLxUmuxq3rRrX69DmPL6bnJXeR/GcAkjSiU/i//byADIp2Ytah+r81c3dv2vnE8aftyHrU8OuLLBLQPw1v+CCgQzMjRMs65QTpRKePFvU58lD4G5t3sUrLdQE4C7AD6Xpe4Njodxkx1SWVBUmx/34+wKI4yrAQpZ7jObBM965RsEB133wV5qhX0RZIbBl5K6m2vaDPmc0TyQnHwIV4S6eodTsrWvONWMKqRLRevkQM+jqvxTeAFm0PYgArbf4HxfPUxvqN0ehBRSfk/xZ1TGx//jhUY+jiVJ/GTYUlJWg2ieTZg27D2JH0u8CXdzWrpMCbPFWsoubSwTQZ2s35vN7PXd+fy2htxEgkAYOsjggtH5Xc3EL9VwQ+w9iDNqxDQ9Jl0stre5NSNZVZzCjfh1ZhC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(55016003)(82960400001)(122000001)(38070700005)(38100700002)(9686003)(26005)(6506007)(71200400001)(7696005)(64756008)(76116006)(66946007)(66556008)(54906003)(6916009)(316002)(66476007)(478600001)(66446008)(53546011)(2906002)(4744005)(7416002)(41300700001)(86362001)(33656002)(5660300002)(8936002)(8676002)(4326008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXdVbENCTWEzS3FGZnFqU1AwNFpLeFRLUllCMkFpclQ0L25kQmp6a3B1UGhr?=
 =?utf-8?B?R1N2M1hNejVwaU45b3YxZ2cxYU44aE9WUU8zWmdiK1doUmN2aHdLZmRSdmVy?=
 =?utf-8?B?a2RpQldIb2RFSVpsV2U5K1JXWkdmQThLZW02NEhwYnRwOVRqZ1lJR0JMVUNJ?=
 =?utf-8?B?OXNRdEUyWXBLeFJmWWEvVmczV2t2d2lVNnBhVWNKanBwTkhyZmtrRTBEaVlH?=
 =?utf-8?B?MXdwM1BMVkZrREwvM05UdDJobWdFOS9zME5vdksvTTZUd2pzN3VwV0MrcnhD?=
 =?utf-8?B?OFIrZk5PNmpISDM3TWRwSURTM0RieGRyWitIditSMGhZQ0pzaHVOUVBnbDRO?=
 =?utf-8?B?T3J4aFZVUDVndkJBVEc2c0xlL2ZzM2ozc0g5TGpQMFNmZ1N6NHBDRTJtOWJn?=
 =?utf-8?B?a253d0QyLzhvN1VMckZiOWVWL1QyQ0RQYW9LSm5iNVR5VUxZaGY0VXIvbkhi?=
 =?utf-8?B?MnZraCtzQi9ZTHRlZGNRU0ZOSlgyTWsrZ3JpUjRZK25VRFoxQVliZjk3ajhW?=
 =?utf-8?B?V05wYXp0S1FrYWNvekR6T1M5WmU2c3hGKytxbjVyWWwveW1wQVpPZjBnUHJz?=
 =?utf-8?B?bGg1MlVDUDUvQ0tRVjZHOUhUOHJsWnY1SW4zcDJqNzZtYldxSUM2ZXJRTHlB?=
 =?utf-8?B?dHJwRGNQMXZWUCtOS3RjZDZySW5PcWhkU2NSTjFVc1pZQUc0TkVRNE5NWmF4?=
 =?utf-8?B?eUZad2xQdHJUcFhaL2RUZVdqbGgzUC9rR3J3bGFWNWhUVDZ2Vyt4aTl1Nkp1?=
 =?utf-8?B?MnV0RkpsS1lFaUdxSjNyTWRTcGhDcWVldVhpTUxSYTdqMFhIZmtvay9TdzhF?=
 =?utf-8?B?alhRaVBEUHlobWhNVjBxWkdTeTJFRHloZUd3bEk5WXpzckllaGQ2clFDaHVs?=
 =?utf-8?B?NktDbmtnVm90RTRLeVE5d0RHUjBzZFdnOXFKNGQ2cTE1OWdxcEw0VUx4OG04?=
 =?utf-8?B?SERxcmU1anpPMW1PU2xkbmNqTjk5ZGQ4MGhIa1VtalVCdW51WGladlkyekJL?=
 =?utf-8?B?NUVzKzh2UHZXb0FuV09jdWV0Z0d5VXp0aUk5NEpmRXdvVzArRHlsWlNyMWdD?=
 =?utf-8?B?a1JHTnFCZWlTUi9uM1NDVFVQNGRUMGc3eitXQ0JjakFkbEg1V1FZU0ZETUR6?=
 =?utf-8?B?LzA0R0ZqUnFmT0hnazJYdlBBaGhSYkQrcGcrNlJkWUN1MmJ6UnhiM2Q0d3Bz?=
 =?utf-8?B?T1l0ZGJ1TDRoemNGYmdBZys1VWpOazUwazliVjBRY2F2WXM4UU1sdzU4Vk5I?=
 =?utf-8?B?L2RINDJtRVhUcjB4T3hXM3lrbDY2YWJ0TjI2NTN1V1ZYZnpkQU9zNE4rQnEy?=
 =?utf-8?B?OXNWdy90dHE5NXFQUDBxM1M3dFhXR3NaYk9JQldMSlNYbzdEZ09TR2hpSWVR?=
 =?utf-8?B?VmRwcHBCYWk0VXVzZUFkSnlHVTZ0REM5eFFHa3lrakRPWHB3WnlSOTYrcVcx?=
 =?utf-8?B?QzdITlFiUFg3b1hPZnAyL1BhemZWV0lQTGkvZVR3ajNjRDIvVE1xcVVoaDhF?=
 =?utf-8?B?cmRhb05hdTBpejFGMnNwOWdzdzdHNFBiRThYS3BCSGd1V3UzamJaeDZ4YlFY?=
 =?utf-8?B?ZTRmR3d3SW80WkNpTnpiRElsYWhOVVFrNWFIaklHbkFaVDJGYno0WFMwN05Q?=
 =?utf-8?B?dzNMWWVyWGZsRUFnM0xDdDF3cS80bllEM2hkWUxWRG1Xcm1kak05VFlCSUJn?=
 =?utf-8?B?YXdtdUZJU3lzYUlETUh4TGo2c2JER0FOQUFLS0dmVXR4ajlsL1JFdHppQkxu?=
 =?utf-8?B?RmQ5YUw3QUtYQW1adUVhUDV6eERtUUNXMmpUR3JMbmVETVRSR3lhZ25qRGVH?=
 =?utf-8?B?QXpNZmxUQzdHdHJjMlFUUkJqMDQ0a3I1SEoyTFNFUHFqd0g2SVVyWEdjcXcy?=
 =?utf-8?B?M3Y0T3RNQ3dCU2dTVkZPRmc1UnlhVUlaeEJxZWNVNnQyWXFUZ0E1eWtjVndL?=
 =?utf-8?B?ZjZBYldiNTZqSDV5a0RLT0pPMmZEeVRCZkRvMVJDUmxTZGQ3RCtXZDRnKy9K?=
 =?utf-8?B?L01MQVppZFBkVHZyeEEwL2s3NEdpdHpEYUR5STFaNkRzVVMwNTJWKzhpWXVN?=
 =?utf-8?B?U25lT2tpSEZIWW9CR0lRbW5WbUpEWCtWdjFlUWtMZWxPQnJmQnhZNU5iSUtj?=
 =?utf-8?B?ZUdtY2NKVS83Q1VDUkczeHZGT1NTdXNwNXdjUm9Wa0lKMVBTMlpDYWRMRnU2?=
 =?utf-8?B?Y2c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6dd3c9-e3bf-4e81-3757-08dbcd82a534
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2023 13:28:40.3885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nqi0TUEpnULQOd6DUOtbUAcVIriZB6uNueqr5V7qvcTytj/6kYhtqcoRBWVPTIYvXxRODIrmJBeFtmgCDwXMawUG62X4YS2TbIvGW3tMXi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8306
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gU2F0dXJkYXksIE9jdG9iZXIgMTQsIDIwMjMgMjo0OCBBTSBTdGFuaXNsYXYgRm9taWNoZXYg
PHNkZkBnb29nbGUuY29tPiB3cm90ZToNCj5PbiBUaHUsIE9jdCAxMiwgMjAyMyBhdCA2OjE04oCv
UE0gU29uZywgWW9vbmcgU2lhbmcgPHlvb25nLnNpYW5nLnNvbmdAaW50ZWwuY29tPiB3cm90ZToN
ClsuLi5dDQo+PiBTbywgIEkgc3VnZ2VzdCB0byBjaGFuZ2UgdGhlIG5hbWluZzoNCj4+ICAtIEhX
IFJYLXRpbWU6IHRoZSBtb21lbnQgTklDIHJlY2VpdmUgdGhlIHBhY2tldCAoYmFzZWQgb24gUEhD
KQ0KPj4gIC0gWERQIFJYLXRpbWU6IHRoZSBtb21lbnQgYnBmIHByb2cgcGFyc2UgdGhlIHBhY2tl
dCAoYmFzZWQgb24gdGFpKQ0KPj4gIC0gU1cgUlgtdGltZTogdGhlIG1vbWVudCB1c2VyIGFwcCBy
ZWNlaXZlIHRoZSBwYWNrZXQgKGJhc2VkIG9uIHRhaSkNCj4+ICAtIEhXIFRYLWNvbXBsZXRlLXRp
bWU6IHRoZSBtb21lbnQgTklDIHNlbmQgb3V0IHRoZSBwYWNrZXQgKGJhc2VkIG9uDQo+PiBQSEMp
DQo+PiAgLSBTVyBUWC1jb21wbGV0ZS10aW1lOiAgdGhlIG1vbWVudCB1c2VyIGFwcCBrbm93IHRo
ZSBwYWNrZXQgYmVpbmcNCj4+IHNlbmQgb3V0IChiYXNlZCBvbiB0YWkpDQo+DQo+U0cuIE1heWJl
IGFsc28gZG8gcy9TVy9Vc2VyLyA/IFRvIHNpZ25pZnkgdGhhdCBpdCdzIGEgdXNlcnNwYWNlLWxl
dmVsIHRpbWVzdGFtcHM/DQoNCnNvdW5kIGdvb2QuDQoNCj4NCj4+IFRoYW5rcyAmIFJlZ2FyZHMN
Cj4+IFNpYW5nDQo+Pg0KDQo=

