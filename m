Return-Path: <bpf+bounces-10613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E73D07AA9F3
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 09:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id DB3D31F22226
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 07:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55CF18027;
	Fri, 22 Sep 2023 07:19:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E9715AC7;
	Fri, 22 Sep 2023 07:19:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D71196;
	Fri, 22 Sep 2023 00:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695367193; x=1726903193;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y4Axx8IxF6E2y5Bg+3JtpDdq1HvcHuiC3Ph4K1ML7XE=;
  b=mKxQS01u2tJ1rhySSe7E3Urp3a3UlIO4NsWsc4MTFNQeTySKyM5uVx6c
   K+5wRbQgdH47kFbddq8hYYbOgsmWixv4F25XrKVqdppNlvqUd1CREUgMa
   +F3gJrDru69GiF/WJWUuxU42QsQLLpFZFMoN7slRgkkjGjNPpi563o5fo
   o4udqvYFV3dyv5w0z16x/0NjbJT+v6qOtnFoxM1lD1pVsBe63l5B9zyJh
   Kymgvi36/c+BWj1bpvFLYv4CtyeqLaF4E+H7UpNcoBs4Oh0UCaMKh5oOB
   mXAlcsSKIzELrvWP+aQRQdhrLw0grjmxblRDd0lctAwYeayn6SUaHXv8j
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="365820593"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="365820593"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 00:19:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="862840761"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="862840761"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2023 00:19:52 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 22 Sep 2023 00:19:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 22 Sep 2023 00:19:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 22 Sep 2023 00:19:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNrL+Xi2GscgenbG5bIJZAmd1aP9YZk/qNsX8ea6oOdequEuf83bZ5u/DTqvP8tUuB5a0kBzcjzHSyJ+kveKpLYh8hauaaie+N5GHSLt/ZpkmZj/Tz4FrpAjlKGggso4KSXVurTGtBVDrcNcGvq0LKf+7HvZCdSwoSU0xc15cg7VBKMj5X6kJwJOMIGITzwTCtjjbc0spGwzYxLHb0njJgUmexDDf0PA5jdc6DU+ZXWmEd4dmdA649/FRdNJjsH4ukKeBnY/Gb4KEzoijbUT8O6QrkrGxXJBPd/RxLEiCOpeoE/UZDR4Ee7EELu9+uQPpD+Sr43jjL9RykOFQQgONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4Axx8IxF6E2y5Bg+3JtpDdq1HvcHuiC3Ph4K1ML7XE=;
 b=jKgxpvQ7gMuXWgttrFELxjvHx0kZMpAgKM6kTQ7ja3I8kFXmk7vNCb3uUU/iS3KwjWfYquobBaXY9yKYzqM/ELVxJCsEoxhgvT+MRyt/JNMdgUKESirqheUwwnhK9v1dv70xbwGNmTpQAnQfBKaeHsnkUklNIP7gSJMMUcTYG8jOWAyYNMSISs36AmMggj2CinvdECH6xumFgC6/b+DCUkNR2SZ2VpqU+yLZ5pqtLWib53GcSWVdBZ0VZREODfWyR112s/oat1wzUBAREvR8Eq9QD+eSu/rQD5S1QHZxqNY1pubRLwcDRQ0955jg2mAGqRy5GFUmfWUa5D3vjzjk6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6514.namprd11.prod.outlook.com (2603:10b6:208:3a2::16)
 by MW5PR11MB5785.namprd11.prod.outlook.com (2603:10b6:303:197::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 07:19:45 +0000
Received: from IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::8c2d:d938:63c:6e59]) by IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::8c2d:d938:63c:6e59%6]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 07:19:45 +0000
From: "Vyavahare, Tushar" <tushar.vyavahare@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
Subject: RE: [PATCH bpf-next 6/8] selftests/xsk: iterate over all the sockets
 in the send pkts function
Thread-Topic: [PATCH bpf-next 6/8] selftests/xsk: iterate over all the sockets
 in the send pkts function
Thread-Index: AQHZ6hBA1SFMUbYkA0qmqn7urOnfyLAk3roAgAGWbIA=
Date: Fri, 22 Sep 2023 07:19:44 +0000
Message-ID: <IA1PR11MB6514369F204D924E723FE4888FFFA@IA1PR11MB6514.namprd11.prod.outlook.com>
References: <20230918093304.367826-1-tushar.vyavahare@intel.com>
 <20230918093304.367826-7-tushar.vyavahare@intel.com>
 <CAJ8uoz1QtRzeo8DxrpujjHGoPWd8FJASUWjfNrROuaJOCw+ZGA@mail.gmail.com>
In-Reply-To: <CAJ8uoz1QtRzeo8DxrpujjHGoPWd8FJASUWjfNrROuaJOCw+ZGA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6514:EE_|MW5PR11MB5785:EE_
x-ms-office365-filtering-correlation-id: 6271e88b-2c24-4542-a39b-08dbbb3c4c06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ffQeMMM84mowOZ7WnD8WJZxOZgbKzsaM9C9SD6sDdS0Mprh0lVgOtsRlj3Z0hp3fvYjoW5W/2CDXxEdtI/dX5cslDMeaMBnO2i4j3doH1Hxe2rTQDP4TIdmQ1ZScnJk6s58ptSuCr0B86NN0GvuFIGxwfXjFVySiu4arqQELaqEw7NT9oZlogiuQQdAdutacTw0oO5cO4zarJUL4gjLpsVFf4DYUHQi70l6LN+ezpwtVZ8ZyM9D4djwj7Qrlvh7vxhktnEAh/ALWGQQ59cec5cynVLUaKwPEsuUDIWwonO51AqtmeyDNofPb0lp0NokX98PQ3iRQ2rdlQASFAZCKOcj/W4YwikX49eKjDx2f0GJYmOefa/o05T1gJ13iy5IsPIFZNOn5JwxNaiOgdWvRVrx+SGJRh3luM333cEMvFXDffPbEM4vOeSfGvzBxB/No+Y4j/8mVnkt5lCKopr3v8usBUp5E5ZfUDDmEKw2gbLZryhfRk4rqi+Zp5MApLJkavGoOSkvNntDYJ770sJICIjLzoXV6d/5ebKSAsdorYU/t7pns53EsWax2YtsL+XvCFVMmeOpzBb8Uu14c7afzHjFi5HbaONg2mFOlhNC3XMVKF7cGts5c8lg15I5qy6H4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6514.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199024)(186009)(1800799009)(8676002)(8936002)(86362001)(52536014)(4326008)(5660300002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(54906003)(316002)(6916009)(41300700001)(7416002)(2906002)(33656002)(38100700002)(38070700005)(83380400001)(478600001)(55016003)(9686003)(122000001)(71200400001)(26005)(107886003)(6506007)(53546011)(7696005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2VTTWROQ2RtT2dmNUpqTDI5UFpFcmpiTUxCS1JTRDVlNHFySVBET0VwY0Uy?=
 =?utf-8?B?RnAxY1g3cTR5Y29ZMVUvbUxtR3J1TGVhT0psMTVjNGNZeE1sOTVJSDlrV3hU?=
 =?utf-8?B?MzA3bTdkSGluMFluSGloZ0ZxYVJ4aWNGTzVCbUduQnluTTUrTVliS1kzMDZQ?=
 =?utf-8?B?UjBWd0RGRWJXVEF2eEs5dVJFSnBabyszMFk1QzdVVUp0bjdNUzlEZEVYNXEw?=
 =?utf-8?B?KzdFd3k5d25pb3V0MGwydjhJcVd5WWJWRnpaaEo3MXBiMmNpai8rZWpXdlR5?=
 =?utf-8?B?L1NRU1d2NzNpTWRud2FnWjJ5UUMwaUlpbzFWRmpLZ01wRk50ZEN1c0xVV2dN?=
 =?utf-8?B?MDZwcGtoNi9zL2ZxT0FDUjEyUmVMS1NEaHJJcW1DK01BM0hqaFpGMFZnS2dS?=
 =?utf-8?B?QlI2clMrc0dsVkgydTA5SXpUNHR4RW5PRk5Da3ZHQW9HODRJT3ZkK0NuYmsw?=
 =?utf-8?B?ZFQrSUpnU0lhSTJPMjJSd2Rua0pYTDYwd0kwZEpVU25PVnZDcisrczdzU2tW?=
 =?utf-8?B?eEVLVG5mQnRBblkwdDhnbEhFNTRaMnU5YzBSSzUyUUUrUkttd3ZadkEra1lK?=
 =?utf-8?B?empFL3laTGtJb1M5ZXlDOFp2TmtnYVNVc08yWVNFVXlRSGNtcFdMYkZvRHM0?=
 =?utf-8?B?N09lU0xValJjMjBXdTY0VWhoQzY2QWN4TUMvV0xBWjdPekgxOU5CY2Z2UTBO?=
 =?utf-8?B?SnVmTWRObS9janhQQXo2WHMxV2tKR1RaT1o4SzRma3dJWnoyNHd5eGVHTFlG?=
 =?utf-8?B?Q0s3OHZNL3JDbWRmTDdYdEpnNE9xZ0hmYU4rSVFiWjZUOS9jazdpdnY3ZVpM?=
 =?utf-8?B?ZGx5SmtmUVp3cHhWYmJ0V3BKMHpReVdpYy81RDh1ZHlhTXdwbWE1NGU5RGxx?=
 =?utf-8?B?Q2VhQStNQWh6djBHZVZ0WnpUbjU4cWx6dU5KY3lpN0NjS1NzSXJxbWcwb1Ba?=
 =?utf-8?B?QU9YWmRSTk9uWHM4dzM5eHg0YWVRZUM0TTFXRGpHZEVralViakM3WTE3MEVo?=
 =?utf-8?B?R0M0OGxWSWFsSFA2TzJQcVNDRjBDVEJEUmttSUU0NGdLOGN3U3pWM3c2dkVN?=
 =?utf-8?B?MUMycnZKdUxGK1NiRTUzQXJZT3VERWJ5djQ2K3BqV2VEeGRMWGsyeGp6ZEJw?=
 =?utf-8?B?UHJvZFp6WithZ0M0VExtSFdHZm5McXd6TWpBOG1jNkpzNE12WnpiZjFRSUFH?=
 =?utf-8?B?cXVhYTh3RlRGU2VjM0pLcmtFVGtkMUQrWTAydG9aSWZjSDVjVHo0YWlQVmsx?=
 =?utf-8?B?SVVUV21qKzl0RE4yd3hSNmY0VmxoSlVra0Jka2dIblVBQzlMamw5UHFRdU5X?=
 =?utf-8?B?ZUlqd1VzdW0yTHc1K1RUcC95aTBoSnkzQXUrc3lGNnNWU01OL3JMSjQ3U01H?=
 =?utf-8?B?QllvYURMMVpOdStURmRiMjFUUlA1aEZCcnpOeW44VnZIMmZPdG9naCtPbHpk?=
 =?utf-8?B?dTBqemhiZXhlMnk0K1pCdHRzdVZjUzErVHlESDlMbG1neEk4aE54UjZPTkth?=
 =?utf-8?B?WWpXTmVuemJleStRTE9IaER3Z1Byanp6SFdRbFJZV3J6NDJsZHpZbm1JQk5C?=
 =?utf-8?B?Y3FZVUR0Y1BsK2Z6Y3lpQ216QzBkem0rMnllV0dHbDRteGZWTld4QVZqU2Z0?=
 =?utf-8?B?YXAzVmMrTDA0TFJSakdSdHltQjRHa1NkamIrdzVXVlFncGFTeHNpcjl4U1A2?=
 =?utf-8?B?RzIvUE5sVTB1MHc0djV2SzZlMnE0R21SOW4xdi93Vm5uSlA3SXBqOXVJZmk5?=
 =?utf-8?B?a2NBb1o0cTl1SThGeHoxNkZpT1FpVk1MTXlxV1hNMGR3bWNYRHhsUTg2cmJq?=
 =?utf-8?B?dXNzTTdrZElrMmswUEZjSHptSld0VWtRRm9EcjMwMjJBZUdVNVEybGlicmRC?=
 =?utf-8?B?c2Q1RW1rWWRDZXl2SmMrQ0hLMFpqakRIVklBWFRQVTlPNllVMFQyUjNjSWZo?=
 =?utf-8?B?b2dKRGp6VmhmVDNiK0FncE1NU0kwdTBPWjUyYlFZOTRLeXNPR2VNdjlDeTd3?=
 =?utf-8?B?TzJ6bVgxVTZ0MkRlbitld0VQZmhTZko4c0hlVlVIZ0lveVdwRTBWeHcrV0tJ?=
 =?utf-8?B?Rm9PbnhNWVpTZFkydVZJT29vMmE5bXBwSS9scGNDVVYzUTZGeDMwRUNhZmVo?=
 =?utf-8?B?UDhtMTZiWUNOUnNEU1lmdS9qL1F1c2JubVJ2enpFMjgyRGgzTDFjZXBCYUxl?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6514.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6271e88b-2c24-4542-a39b-08dbbb3c4c06
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 07:19:45.0387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xWizQ/4G5ya7B8C+dqtT3KpejsN0n1tV7T0qpsCsiocIfHeDp//u9cpqes+xV6tzfzQ20hH+Khdq1gPgk+BSIctcqMMHFbWBXwf0XCeWnl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5785
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFnbnVzIEthcmxzc29u
IDxtYWdudXMua2FybHNzb25AZ21haWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVy
IDIxLCAyMDIzIDEyOjMxIFBNDQo+IFRvOiBWeWF2YWhhcmUsIFR1c2hhciA8dHVzaGFyLnZ5YXZh
aGFyZUBpbnRlbC5jb20+DQo+IENjOiBicGZAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnOyBiam9ybkBrZXJuZWwub3JnOw0KPiBLYXJsc3NvbiwgTWFnbnVzIDxtYWdudXMu
a2FybHNzb25AaW50ZWwuY29tPjsgRmlqYWxrb3dza2ksIE1hY2llag0KPiA8bWFjaWVqLmZpamFs
a293c2tpQGludGVsLmNvbT47IGpvbmF0aGFuLmxlbW9uQGdtYWlsLmNvbTsNCj4gZGF2ZW1AZGF2
ZW1sb2Z0Lm5ldDsga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsNCj4gYXN0QGtl
cm5lbC5vcmc7IGRhbmllbEBpb2dlYXJib3gubmV0OyBTYXJrYXIsIFRpcnRoZW5kdQ0KPiA8dGly
dGhlbmR1LnNhcmthckBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggYnBmLW5leHQg
Ni84XSBzZWxmdGVzdHMveHNrOiBpdGVyYXRlIG92ZXIgYWxsIHRoZSBzb2NrZXRzIGluDQo+IHRo
ZSBzZW5kIHBrdHMgZnVuY3Rpb24NCj4gDQo+IE9uIE1vbiwgMTggU2VwdCAyMDIzIGF0IDExOjE1
LCBUdXNoYXIgVnlhdmFoYXJlDQo+IDx0dXNoYXIudnlhdmFoYXJlQGludGVsLmNvbT4gd3JvdGU6
DQo+ID4NCj4gPiBVcGRhdGUgc2VuZF9wa3RzKCkgdG8gaGFuZGxlIG11bHRpcGxlIHNvY2tldHMg
Zm9yIHNlbmRpbmcgcGFja2V0cy4NCj4gPiBNdWx0aXBsZSBUWCBzb2NrZXRzIGFyZSB1dGlsaXpl
ZCBhbHRlcm5hdGVseSBiYXNlZCBvbiB0aGUgYmF0Y2ggc2l6ZQ0KPiA+IGZvciBpbXByb3ZlIHBh
Y2tldCB0cmFuc21pc3Npb24uDQo+IA0KPiBJIGRvIG5vdCBrbm93IGlmIGl0IGlzICJpbXByb3Zl
ZCIgOy0pLCBidXQgaXQgaXMgZ29vZCB0byB0ZXN0IHNlbmRpbmcgZnJvbQ0KPiBtdWx0aXBsZSBz
b2NrZXRzLiBQbGVhc2UgbWFrZSB0aGF0IGNsZWFyZXIuDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IFR1c2hhciBWeWF2YWhhcmUgPHR1c2hhci52eWF2YWhhcmVAaW50ZWwuY29tPg0KPiA+IC0tLQ0K
PiA+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYveHNreGNlaXZlci5jIHwgNjQNCj4gPiAr
KysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQ1IGluc2VydGlv
bnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2JwZi94c2t4Y2VpdmVyLmMNCj4gPiBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2JwZi94c2t4Y2VpdmVyLmMNCj4gPiBpbmRleCBlNjcwMzJmMDRhNzQuLjBlZjA1NzVjMDk1
YyAxMDA2NDQNCj4gPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYveHNreGNlaXZl
ci5jDQo+ID4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3hza3hjZWl2ZXIuYw0K
PiA+IEBAIC0xMjA0LDEzICsxMjA0LDEzIEBAIHN0YXRpYyBpbnQgcmVjZWl2ZV9wa3RzKHN0cnVj
dCB0ZXN0X3NwZWMgKnRlc3QpDQo+ID4gICAgICAgICByZXR1cm4gVEVTVF9QQVNTOw0KPiA+ICB9
DQo+ID4NCj4gPiAtc3RhdGljIGludCBfX3NlbmRfcGt0cyhzdHJ1Y3QgaWZvYmplY3QgKmlmb2Jq
ZWN0LCBzdHJ1Y3QgcG9sbGZkICpmZHMsDQo+ID4gYm9vbCB0aW1lb3V0KQ0KPiA+ICtzdGF0aWMg
aW50IF9fc2VuZF9wa3RzKHN0cnVjdCBpZm9iamVjdCAqaWZvYmplY3QsIHN0cnVjdA0KPiA+ICt4
c2tfc29ja2V0X2luZm8gKnhzaywgYm9vbCB0aW1lb3V0KQ0KPiA+ICB7DQo+ID4gICAgICAgICB1
MzIgaSwgaWR4ID0gMCwgdmFsaWRfcGt0cyA9IDAsIHZhbGlkX2ZyYWdzID0gMCwgYnVmZmVyX2xl
bjsNCj4gPiAtICAgICAgIHN0cnVjdCBwa3Rfc3RyZWFtICpwa3Rfc3RyZWFtID0gaWZvYmplY3Qt
Pnhzay0+cGt0X3N0cmVhbTsNCj4gPiAtICAgICAgIHN0cnVjdCB4c2tfc29ja2V0X2luZm8gKnhz
ayA9IGlmb2JqZWN0LT54c2s7DQo+ID4gKyAgICAgICBzdHJ1Y3QgcGt0X3N0cmVhbSAqcGt0X3N0
cmVhbSA9IHhzay0+cGt0X3N0cmVhbTsNCj4gPiAgICAgICAgIHN0cnVjdCB4c2tfdW1lbV9pbmZv
ICp1bWVtID0gaWZvYmplY3QtPnVtZW07DQo+ID4gICAgICAgICBib29sIHVzZV9wb2xsID0gaWZv
YmplY3QtPnVzZV9wb2xsOw0KPiA+ICsgICAgICAgc3RydWN0IHBvbGxmZCBmZHMgPSB7IH07DQo+
ID4gICAgICAgICBpbnQgcmV0Ow0KPiA+DQo+ID4gICAgICAgICBidWZmZXJfbGVuID0gcGt0X2dl
dF9idWZmZXJfbGVuKHVtZW0sDQo+ID4gcGt0X3N0cmVhbS0+bWF4X3BrdF9sZW4pOyBAQCAtMTIy
Miw5ICsxMjIyLDEyIEBAIHN0YXRpYyBpbnQNCj4gX19zZW5kX3BrdHMoc3RydWN0IGlmb2JqZWN0
ICppZm9iamVjdCwgc3RydWN0IHBvbGxmZCAqZmRzLCBib29sIHRpbWVvDQo+ID4gICAgICAgICAg
ICAgICAgIHJldHVybiBURVNUX0NPTlRJTlVFOw0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gKyAg
ICAgICBmZHMuZmQgPSB4c2tfc29ja2V0X19mZCh4c2stPnhzayk7DQo+ID4gKyAgICAgICBmZHMu
ZXZlbnRzID0gUE9MTE9VVDsNCj4gPiArDQo+ID4gICAgICAgICB3aGlsZSAoeHNrX3JpbmdfcHJv
ZF9fcmVzZXJ2ZSgmeHNrLT50eCwgQkFUQ0hfU0laRSwgJmlkeCkgPA0KPiBCQVRDSF9TSVpFKSB7
DQo+ID4gICAgICAgICAgICAgICAgIGlmICh1c2VfcG9sbCkgew0KPiA+IC0gICAgICAgICAgICAg
ICAgICAgICAgIHJldCA9IHBvbGwoZmRzLCAxLCBQT0xMX1RNT1VUKTsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICByZXQgPSBwb2xsKCZmZHMsIDEsIFBPTExfVE1PVVQpOw0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgIGlmICh0aW1lb3V0KSB7DQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBpZiAocmV0IDwgMCkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBrc2Z0X3ByaW50X21zZygiRVJST1I6IFslc10NCj4gPiBQb2xsIGVy
cm9yICVkXG4iLCBAQCAtMTMwMyw3ICsxMzA2LDcgQEAgc3RhdGljIGludCBfX3NlbmRfcGt0cyhz
dHJ1Y3QNCj4gaWZvYmplY3QgKmlmb2JqZWN0LCBzdHJ1Y3QgcG9sbGZkICpmZHMsIGJvb2wgdGlt
ZW8NCj4gPiAgICAgICAgIHhzay0+b3V0c3RhbmRpbmdfdHggKz0gdmFsaWRfZnJhZ3M7DQo+ID4N
Cj4gPiAgICAgICAgIGlmICh1c2VfcG9sbCkgew0KPiA+IC0gICAgICAgICAgICAgICByZXQgPSBw
b2xsKGZkcywgMSwgUE9MTF9UTU9VVCk7DQo+ID4gKyAgICAgICAgICAgICAgIHJldCA9IHBvbGwo
JmZkcywgMSwgUE9MTF9UTU9VVCk7DQo+ID4gICAgICAgICAgICAgICAgIGlmIChyZXQgPD0gMCkg
ew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChyZXQgPT0gMCAmJiB0aW1lb3V0KQ0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIFRFU1RfUEFTUzsgQEAg
LTEzNDksMjcgKzEzNTIsNTANCj4gPiBAQCBzdGF0aWMgaW50IHdhaXRfZm9yX3R4X2NvbXBsZXRp
b24oc3RydWN0IHhza19zb2NrZXRfaW5mbyAqeHNrKQ0KPiA+ICAgICAgICAgcmV0dXJuIFRFU1Rf
UEFTUzsNCj4gPiAgfQ0KPiA+DQo+ID4gK2Jvb2wgYWxsX3BhY2tldHNfc2VudChzdHJ1Y3QgdGVz
dF9zcGVjICp0ZXN0LCB1bnNpZ25lZCBsb25nICpiaXRtYXApDQo+ID4gK3sNCj4gPiArICAgICAg
IGlmICh0ZXN0X2JpdCh0ZXN0LT5uYl9zb2NrZXRzLCBiaXRtYXApKQ0KPiA+ICsgICAgICAgICAg
ICAgICByZXR1cm4gdHJ1ZTsNCj4gDQo+IFRoaXMgZG9lcyBub3Qgc2VlbSB0byBiZSBjb3JyZWN0
LiBZb3UgYXJlIHRlc3Rpbmcgb25lIGJpdCBoZXJlLCBidXQgYXJlIHlvdQ0KPiBub3Qgc3VwcG9z
ZWQgdG8gdGVzdCB0aGF0IGFsbCBiaXRzIGhhdmUgYmVlbiBzZXQ/DQo+IA0KDQpZZXMsIEkgd2ls
bCBmaXggdGhhdC4NCg0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiArfQ0K
PiA+ICsNCj4gPiAgc3RhdGljIGludCBzZW5kX3BrdHMoc3RydWN0IHRlc3Rfc3BlYyAqdGVzdCwg
c3RydWN0IGlmb2JqZWN0DQo+ID4gKmlmb2JqZWN0KSAgew0KPiA+IC0gICAgICAgc3RydWN0IHBr
dF9zdHJlYW0gKnBrdF9zdHJlYW0gPSBpZm9iamVjdC0+eHNrLT5wa3Rfc3RyZWFtOw0KPiA+ICAg
ICAgICAgYm9vbCB0aW1lb3V0ID0gIWlzX3VtZW1fdmFsaWQodGVzdC0+aWZvYmpfcngpOw0KPiA+
IC0gICAgICAgc3RydWN0IHBvbGxmZCBmZHMgPSB7IH07DQo+ID4gLSAgICAgICB1MzIgcmV0Ow0K
PiA+ICsgICAgICAgdTMyIGksIHJldDsNCj4gPg0KPiA+IC0gICAgICAgZmRzLmZkID0geHNrX3Nv
Y2tldF9fZmQoaWZvYmplY3QtPnhzay0+eHNrKTsNCj4gPiAtICAgICAgIGZkcy5ldmVudHMgPSBQ
T0xMT1VUOw0KPiA+ICsgICAgICAgREVDTEFSRV9CSVRNQVAoYml0bWFwLCBNQVhfU09DS0VUUyk7
DQo+IA0KPiBTaG91bGQgYmUgd2l0aCB0aGUgZGVjbGFyYXRpb25zIGluIFJDVCBvcmRlci4NCj4g
DQoNClllcywgSSB3aWxsIGRvLg0KDQo+ID4NCj4gPiAtICAgICAgIHdoaWxlIChwa3Rfc3RyZWFt
LT5jdXJyZW50X3BrdF9uYiA8IHBrdF9zdHJlYW0tPm5iX3BrdHMpIHsNCj4gPiAtICAgICAgICAg
ICAgICAgcmV0ID0gX19zZW5kX3BrdHMoaWZvYmplY3QsICZmZHMsIHRpbWVvdXQpOw0KPiA+IC0g
ICAgICAgICAgICAgICBpZiAocmV0ID09IFRFU1RfQ09OVElOVUUgJiYgIXRlc3QtPmZhaWwpDQo+
ID4gLSAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ID4gLSAgICAgICAgICAgICAg
IGlmICgocmV0IHx8IHRlc3QtPmZhaWwpICYmICF0aW1lb3V0KQ0KPiA+IC0gICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiBURVNUX0ZBSUxVUkU7DQo+ID4gLSAgICAgICAgICAgICAgIGlmIChy
ZXQgPT0gVEVTVF9QQVNTICYmIHRpbWVvdXQpDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIHJldDsNCj4gPiArICAgICAgIHdoaWxlICghKGFsbF9wYWNrZXRzX3NlbnQodGVzdCwg
Yml0bWFwKSkpIHsNCj4gPiArICAgICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IHRlc3QtPm5i
X3NvY2tldHM7IGkrKykgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBwa3Rf
c3RyZWFtICpwa3Rfc3RyZWFtOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBw
a3Rfc3RyZWFtID0gaWZvYmplY3QtPnhza19hcnJbaV0ucGt0X3N0cmVhbTsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICBpZiAoIXBrdF9zdHJlYW0gfHwgcGt0X3N0cmVhbS0+Y3VycmVudF9w
a3RfbmINCj4gPiArID49IHBrdF9zdHJlYW0tPm5iX3BrdHMpIHsNCj4gDQo+IENhbiBwa3Rfc3Ry
ZWFtIGJlIE5VTEw/DQo+IA0KDQpZZXMsIGluIHRoZSBzd2FwX3hza19yZXNvdXJjZXMoKSBmdW5j
dGlvbiwgd2UgYXJlIHNldHRpbmcgJ3BrdF9zdHJlYW0nIHRvIE5VTEwuIFtwYXRjaCA0IGNoYW5n
ZV0NCg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX190ZXN0X2FuZF9zZXRf
Yml0KCgxIDw8IGkpLCBiaXRtYXApOw0KPiANCj4gdGVzdF9hbmRfc2V0PyBZb3UgYXJlIG5vdCB0
ZXN0aW5nIGFueXRoaW5nIGhlcmUgc28gaXQgaXMgZW5vdWdoIHRvIGp1c3Qgc2V0IGl0Lg0KPiAN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBf
X3NlbmRfcGt0cyhpZm9iamVjdCwgJmlmb2JqZWN0LT54c2tfYXJyW2ldLCB0aW1lb3V0KTsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICBpZiAocmV0ID09IFRFU1RfQ09OVElOVUUgJiYgIXRl
c3QtPmZhaWwpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsN
Cj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKChyZXQgfHwgdGVzdC0+ZmFp
bCkgJiYgIXRpbWVvdXQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gVEVTVF9GQUlMVVJFOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAo
cmV0ID09IFRFU1RfUEFTUyAmJiB0aW1lb3V0KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
cmV0ID0gd2FpdF9mb3JfdHhfY29tcGxldGlvbigmaWZvYmplY3QtPnhza19hcnJbaV0pOw0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIGlmICgocmV0IHx8IHRlc3QtPmZhaWwpICYmICF0aW1l
b3V0KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIFRFU1RfRkFJ
TFVSRTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJldCA9PSBURVNU
X1BBU1MgJiYgdGltZW91dCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiByZXQ7DQo+IA0KPiBXaHkgdGVzdGluZyB0aGUgc2FtZSB0aGluZ3MgYmVmb3JlIGFuZCBh
ZnRlciB3YWl0X2Zvcl90eF9jb21wbGV0aW9uPw0KPiBTaG91bGQgaXQgbm90IGJlIGZpbmUgdG8g
anVzdCBkbyBpdCBpbiBvbmUgcGxhY2U/DQo+IA0KDQpJIHdpbGwgY2hhbmdlIGl0Lg0KDQo+ID4g
KyAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+IC0gICAgICAgcmV0dXJu
IHdhaXRfZm9yX3R4X2NvbXBsZXRpb24oaWZvYmplY3QtPnhzayk7DQo+ID4gKyAgICAgICByZXR1
cm4gVEVTVF9QQVNTOw0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIGludCBnZXRfeHNrX3N0YXRz
KHN0cnVjdCB4c2tfc29ja2V0ICp4c2ssIHN0cnVjdA0KPiA+IHhkcF9zdGF0aXN0aWNzICpzdGF0
cykNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo+ID4NCg==

