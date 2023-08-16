Return-Path: <bpf+bounces-7876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2B377DA1A
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 08:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FB82814AC
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 06:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CC1C2D6;
	Wed, 16 Aug 2023 06:05:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEED1844;
	Wed, 16 Aug 2023 06:05:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982FB211E;
	Tue, 15 Aug 2023 23:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692165900; x=1723701900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0v4iGbQxru2WdZaHKmXHkKtYQgOKnHr6tFXVvGMDY3Y=;
  b=FpwPjrdgrExx5Ew2rvt1njGGVaNshNaFf1bDFs+3bzESXXnNkfSivQux
   zdvUJB7SmnuRutVb/HFfI8v2PMs5T/WwAeUiC+E3+3HGnXi7Hn8vNjV0I
   qxwsuMgLExprBIod/Pv01RYHNFyX/yUXWDkNGMH33JiGyQaw0+c5QaRuD
   dS/afonRKt7K7Ppo353e1Yd1Nvr1LudpkVMRZfCqeL0ev1lmh6hbIl5LN
   fRHeL/SBSqK94iVO35WgQdsNkI9E2egkN5NUiEihPokdEPfxt06A6ZS8K
   Udr1PguXgQm7+/QJC6OXZjaxBtwpTnThQWudMkmIxqperg/GJHnpNuvCS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="372447771"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="372447771"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 23:05:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="710992022"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="710992022"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 15 Aug 2023 23:04:59 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 23:04:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 23:04:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 23:04:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWclHFEZeUtOgUGoLPljf5RBFwcnHIHms2W5fgljUlF7ie16TZMBtbhhaRpqW1XL5l8pwXp1LzxCmRGd+Y4VioL9ENRDgE1ackhXscRP2o4Fvar+G/eXV80XoYGf490hmUVPm0xblccRqKcuycQuhZtX1JpIT2QbJWP6S8DhCNt99H8DRrBMG44lFbKCLS9jJDFq+D2R8EJj8q21uB/SP++Rw1X0f1UYokM2gXV8DmFzzaIK0v8USJo5ulxmEjS2VszyyRjtb5LnRtYXMW1x/1Vx+Yyiig5xnMNTjK2otROBvdSvUlwTUx8xyudxWHBPiAR9dDoeQzCE+p7FovCnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0v4iGbQxru2WdZaHKmXHkKtYQgOKnHr6tFXVvGMDY3Y=;
 b=L/Lr6cpX+PCyhDcckJupLkTpmCuAZHlc4b+O5jN3qDaqL4w+RqAlcz/I4zilu/6op17JMoguQI1O+rNmiif7Idzr+JkBKCPaBGM6ecQt0vi6VowNknZwK6HmkSIG9Fk4bLHGAm40Zv078mQU3/6sG7jobwZhvwomTIvhVP115XZiFrHZJLGm83YBqRW62LC9IQDZticWZxdHXvNzUjV4lXD20IRS+dHRmUR8GYe4IuPdRPl5vSiJ9olGh5KyIOp22jNqEI/MyAu6mPYvjspFfMiDRds09ApnTVsIIgpNU5arUwkRb8EAduvjzlm9oUtp12sEfCXuhiHPWHfnjcp4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6655.namprd11.prod.outlook.com (2603:10b6:806:26d::20)
 by SN7PR11MB6653.namprd11.prod.outlook.com (2603:10b6:806:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 06:04:52 +0000
Received: from SN7PR11MB6655.namprd11.prod.outlook.com
 ([fe80::7819:614a:ebaa:fee8]) by SN7PR11MB6655.namprd11.prod.outlook.com
 ([fe80::7819:614a:ebaa:fee8%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 06:04:52 +0000
From: "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
To: Stanislav Fomichev <sdf@google.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
Subject: RE: [PATCH bpf-next v2] xsk: fix xsk_build_skb() error: 'skb'
 dereferencing possible ERR_PTR()
Thread-Topic: [PATCH bpf-next v2] xsk: fix xsk_build_skb() error: 'skb'
 dereferencing possible ERR_PTR()
Thread-Index: AQHZz40CNd1kiPkCgk6BVSZjYj2p9K/rq0UAgACMj/A=
Date: Wed, 16 Aug 2023 06:04:52 +0000
Message-ID: <SN7PR11MB665573AB14515B617C3D2EA69015A@SN7PR11MB6655.namprd11.prod.outlook.com>
References: <20230815150325.2010460-1-tirthendu.sarkar@intel.com>
 <ZNvB9AUzNIzwMW6+@google.com>
In-Reply-To: <ZNvB9AUzNIzwMW6+@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6655:EE_|SN7PR11MB6653:EE_
x-ms-office365-filtering-correlation-id: 5d57fb37-16f2-412b-7741-08db9e1eb4ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rOJXdh60ptYP2gL+rRE7YMQGv/aeZBWn13+/NFWOJgDamJtNuZxtZ4MyfHjKdunPKFXUX1xt4oRHOUOEctxAaYi4yZ3Ihx5kYyDfIRG8Z6NL8VGPwVyETTwWUXkvNWOm8K4DQo2OgvKG9Fh0ku9DwUPE8iBprQcB6qOEBClAISQzmjsS8twUQGHpQWkyXZEJj/1i3kmPsZJaGDn3PVkxQBFENlLuiiShiJtqa2CVjfvQqGP3XK8hcsnwCUWhI6x1DobLBZydn65xr0N03+4WuiBiKuS6Sho1FnWUApgrjEUuZIBax0ztlN9BfDU9RxBCL6GY+7m0+0SAf89IgJv7iyle31Bo7OIS4gqqrC0FPcQ4sjmFDJHIKy9kNyW9YAz/4pOpwX8eQDUxN3yEjyx+p4x5VP7ABxDwE8jUQqXFU4dVWlQ0qbze2QPerwpZxoOy+4TyVyLFUB/sl7YpJUp+WI5urnUavziYNUkFHUJJblEDLGTa0+qftbHMCuhp92GDoZp43ZH8oMna3mKylxoa2NKjdmk+6ONlsw+C3A8OyARxX4764hiSFXuRPO7mDHktFCtLu7/1QVBmjJAC4mCv7MA040gr7hr4f0IjRrw7LAI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6655.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(1800799009)(451199024)(186009)(71200400001)(64756008)(54906003)(66446008)(76116006)(66476007)(66556008)(66946007)(7696005)(6506007)(2906002)(478600001)(9686003)(966005)(26005)(6916009)(7416002)(5660300002)(83380400001)(52536014)(41300700001)(316002)(8936002)(4326008)(8676002)(66899024)(122000001)(38100700002)(38070700005)(82960400001)(33656002)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0FpTkh1ZmFIdEF1czB1TlRkRnd2VTV6bEY1WVphSzJFc2laNmw4VURUVStt?=
 =?utf-8?B?MERDeHc0MVJjY0pXVXZxQ29jb1paQ3YrUE1RNHJqbDU3bExnUWp3SjIyVURl?=
 =?utf-8?B?NVdYUllHQlFLekRpTWkzWm52VXErbUMxMXNsUGJrYmJmN053ejNlU1Z6dzFk?=
 =?utf-8?B?cFU3alBDVk55RjdNU0k3aExpeU44cUpzeGU4cDNIQWNkYlhBRWhEUkNaTlkz?=
 =?utf-8?B?SHlvazVIR25pWkJKYVp1QnZkU2hIdU5pSk5yTnZPRG1vN3V1MURvOUkvcWIw?=
 =?utf-8?B?bHVVc0FJRmR3S25YRjcvYWdkeGRkc0x3d1JrVTNWNkR4NzJualRDTjNKZG5B?=
 =?utf-8?B?VUtZL0dONEJjd1Fqb0tMK2pmN0ZUVWNyK2FOUzZmSDVQYy9WMHNuTFBqU0xq?=
 =?utf-8?B?WlIyR3pwTzA5YlMxQWUxVE03RXE0UU9IOFZvTTlBakZFRDJXeDliSmJ5VWsw?=
 =?utf-8?B?WXhHbkR2SnJEUy9tTXNqazQrMXVaWWhzekVhOU1Vc0tybnpxUUwyTHQ2RzNS?=
 =?utf-8?B?Mnh5Nmt3US91ckdmdW5DaFFGaVNUMEpxK2xPY1A2QjdUbGZQcEZFcGJCSDFZ?=
 =?utf-8?B?YWFjVDVzSnBXNWtMZmUrTDRLVStaeXlUVFlycFhnQVRzUkxobmx5WWU1cFND?=
 =?utf-8?B?enIwLy9KK0tRTmFtbnYvalB2TUl2dm5SU1l3L1ZNQlBGZUk5TFUySjMyMnlT?=
 =?utf-8?B?c3FEaW5EdExVL0JVOGY1ODJTNDBQQ3FxMXlUYkk1R3BtcVQ2RXhkV3V2TU1a?=
 =?utf-8?B?dDZmWTVoZWNyZTByUCthd3llNk9YcHM3WTRBMW5IN2xBR010VG5DVXNLS1VW?=
 =?utf-8?B?eCtHSkhDMWd6WC9hK29wcnJGbWJSWlpQZXBrQjFMaXJxMW9FQ2pkcTZHd3Rz?=
 =?utf-8?B?b200clRFZ0R3RjNYOUJHU3lzQnhCS05VSFR1UUlKNmJsZkNiamJUaFErYysv?=
 =?utf-8?B?UjFMV1ZkOHFYQmVXam8zZEtKeDZYY01oZ0dJR0F3eGpXcGdxTEtMT0MzUjhF?=
 =?utf-8?B?MzJOZUg1OUhWQmVzSkFUblprWjdOYjhYa0lVUFdIRXN5bHM5aVUzM29jMjky?=
 =?utf-8?B?WjNrWmlQdTByeVo4THlTU2dpYWFoOGRrcWV0K2NreHhhZk03VHQ4U1Z1Vk9h?=
 =?utf-8?B?MEhPYzVyVjAvT3MvaWhOT080eXVlTzJzRlZYYk5pbFArcU5UdVplNU9seXd6?=
 =?utf-8?B?dHRBMGxtVEpoSDVQaUpyUC9QUTNFTXhvQzR6NksxdGdnV29iQ3RyaDlWYkVJ?=
 =?utf-8?B?K0R6enR4dGMzYzU2V0cwbC9YcVQ0MGppeW1nazRwMmd2N05MK3dNODlQUnZz?=
 =?utf-8?B?NU1VcUduQzF1d0svUzdPTmdSQ2pQaGxqZVF3ajZDTWhrMUdWUSsyaHlSNUVG?=
 =?utf-8?B?UEMzc1JDYUloVmExdDlBNjJoelplazJ3dHc5MUthbjJHVi9XYU9SWkhobFdR?=
 =?utf-8?B?UkJZS294dzdMUWJqL1RZcWlDYVpYdGo5dGFDaDlTV2pNdFJRZ1F2UXd6M2N0?=
 =?utf-8?B?ZDR5RjJnSHZQSm91TDN2ZDhYNklhSHdFNmp3V1YvOFRrSnlGV0FxN2tpTkx6?=
 =?utf-8?B?WmNVN2lOTllkSXlvUXl6R1ErWU9LRUd5VUh5dVkwdXF0QkwvN0lUMFRmVVhH?=
 =?utf-8?B?K2phYmNuMyt5U1dEK3BHVDQwTkxvcFlZNXl6MWpCVCtKU2dtYk12cWxENGVU?=
 =?utf-8?B?RkpwTzI5NW5SdXRubmp6emdKZm9IQjl1TVdpQzd6QzJFWWZ6QmwxS20yMHhn?=
 =?utf-8?B?TEpXcS81U29PTjYzL3FIMWo3TURob1ZvdHhLTUFTMk5YRjdWV0hRWmtDRFJI?=
 =?utf-8?B?bWdDVXFoOTJER2t2NVd4TlZsZjhNVDI0RnNsK1I1dnltTWtPU3Z1QjN2S1ds?=
 =?utf-8?B?ajFnS0xqRWRtT2hseFB0dGFxM0JWeVRGVkxvQU9uSVRkdFBuVk1UTmJIeFk2?=
 =?utf-8?B?VGYreTlQSWFBQWNYUHV3eHVST29SNUpxbzhrSFNoQ1ZlV3o0L0VDVC9hYTVz?=
 =?utf-8?B?Qy9vSVFGWnFJVGhZTDl4TFV2UUtaanVOd08xNndQOUpWaVhsNWg1SmRBRm1V?=
 =?utf-8?B?Zjl6enRyY3FIRmdxOERycmVXeWN0UnUyU3YyMEx6SUZjWWNBSFJWdExDbnFN?=
 =?utf-8?Q?rg7CT3gkzlXH9NstyeTwsd+TX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6655.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d57fb37-16f2-412b-7741-08db9e1eb4ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 06:04:52.2180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 66ylZcvI/PcWKWQjRZZ1AQAodur0XxGLojsD4Qum7XrfTiwNqd0xPsA6jftZ3efYqlqSJ0SHBgyxt0fxj+Nec6aVjs4Sk739a1ZW12KR674=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6653
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGFuaXNsYXYgRm9taWNoZXYg
PHNkZkBnb29nbGUuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMTUsIDIwMjMgMTE6NTEg
UE0NCj4gT24gMDgvMTUsIFRpcnRoZW5kdSBTYXJrYXIgd3JvdGU6DQo+ID4geHNrX2J1aWxkX3Nr
Yl96ZXJvY29weSgpIG1heSByZXR1cm4gYW4gZXJyb3Igb3RoZXIgdGhhbiAtRUFHQUlOIGFuZA0K
PiB0aGlzDQo+ID4gaXMgcmVjZWl2ZWQgYXMgc2tiIGFuZCB1c2VkIGxhdGVyIGluIHhza19zZXRf
ZGVzdHJ1Y3Rvcl9hcmcoKSBhbmQNCj4gPiB4c2tfZHJvcF9za2IoKSB3aGljaCBtdXN0IG9wZXJh
dGUgb24gYSB2YWxpZCBza2IuDQo+ID4NCj4gPiBTZXQgLUVPVkVSRkxPVyBhcyBlcnJvciB3aGVu
IE1BWF9TS0JfRlJBR1MgYXJlIGV4Y2VlZGVkIGFuZA0KPiBwYWNrZXQgbmVlZHMNCj4gPiB0byBi
ZSBkcm9wcGVkIGFuZCB1c2UgdGhpcyB0byBkaXN0aW5ndWlzaCBhZ2FpbnN0IGFsbCBvdGhlciBl
cnJvciBjYXNlcw0KPiA+IHdoZXJlIGFsbG9jYXRpb24gbmVlZHMgdG8gYmUgcmV0cmllZC4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRpcnRoZW5kdSBTYXJrYXIgPHRpcnRoZW5kdS5zYXJrYXJA
aW50ZWwuY29tPg0KPiA+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVs
LmNvbT4NCj4gPiBSZXBvcnRlZC1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5h
cm8ub3JnPg0KPiA+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIzMDcyMTA0
MzQuT2pncUZjYkItbGtwQGludGVsLmNvbS8NCj4gPiBGaXhlczogY2YyNGY1YTVmZWVhICgieHNr
OiBhZGQgc3VwcG9ydCBmb3IgQUZfWERQIG11bHRpLWJ1ZmZlciBvbiBUeA0KPiBwYXRoIikNCj4g
Pg0KPiA+IENoYW5nZWxvZzoNCj4gPiAJdjEgLT4gdjI6DQo+ID4gCS0gUmVtb3ZlZCBlcnIgYXMg
YSBwYXJhbWV0ZXIgdG8geHNrX2J1aWxkX3NrYl96ZXJvY29weSgpDQo+ID4gCVtTdGFuaXNsYXYg
Rm9taWNoZXZdDQo+ID4gCS0gdXNlIGV4cGxpY2l0IGVycm9yIHRvIGRpc3Rpbmd1aXNoIHBhY2tl
dCBkcm9wIHZzIHJldHJ5DQo+ID4gLS0tDQo+ID4gIG5ldC94ZHAveHNrLmMgfCAyMiArKysrKysr
KysrKysrLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA5
IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL25ldC94ZHAveHNrLmMgYi9uZXQv
eGRwL3hzay5jDQo+ID4gaW5kZXggZmNmYzg0NzJmNzNkLi41NWY4YjliMGUwNmQgMTAwNjQ0DQo+
ID4gLS0tIGEvbmV0L3hkcC94c2suYw0KPiA+ICsrKyBiL25ldC94ZHAveHNrLmMNCj4gPiBAQCAt
NjAyLDcgKzYwMiw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZg0KPiAqeHNrX2J1aWxkX3NrYl96
ZXJvY29weShzdHJ1Y3QgeGRwX3NvY2sgKnhzLA0KPiA+DQo+ID4gIAlmb3IgKGNvcGllZCA9IDAs
IGkgPSBza2Jfc2hpbmZvKHNrYiktPm5yX2ZyYWdzOyBjb3BpZWQgPCBsZW47IGkrKykgew0KPiA+
ICAJCWlmICh1bmxpa2VseShpID49IE1BWF9TS0JfRlJBR1MpKQ0KPiA+IC0JCQlyZXR1cm4gRVJS
X1BUUigtRUZBVUxUKTsNCj4gPiArCQkJcmV0dXJuIEVSUl9QVFIoLUVPVkVSRkxPVyk7DQo+ID4N
Cj4gPiAgCQlwYWdlID0gcG9vbC0+dW1lbS0+cGdzW2FkZHIgPj4gUEFHRV9TSElGVF07DQo+ID4g
IAkJZ2V0X3BhZ2UocGFnZSk7DQo+ID4gQEAgLTY1NSwxNSArNjU1LDE3IEBAIHN0YXRpYyBzdHJ1
Y3Qgc2tfYnVmZiAqeHNrX2J1aWxkX3NrYihzdHJ1Y3QNCj4geGRwX3NvY2sgKnhzLA0KPiA+ICAJ
CQlza2JfcHV0KHNrYiwgbGVuKTsNCj4gPg0KPiA+ICAJCQllcnIgPSBza2Jfc3RvcmVfYml0cyhz
a2IsIDAsIGJ1ZmZlciwgbGVuKTsNCj4gPiAtCQkJaWYgKHVubGlrZWx5KGVycikpDQo+ID4gKwkJ
CWlmICh1bmxpa2VseShlcnIpKSB7DQo+ID4gKwkJCQlrZnJlZV9za2Ioc2tiKTsNCj4gPiAgCQkJ
CWdvdG8gZnJlZV9lcnI7DQo+ID4gKwkJCX0NCj4gPiAgCQl9IGVsc2Ugew0KPiA+ICAJCQlpbnQg
bnJfZnJhZ3MgPSBza2Jfc2hpbmZvKHNrYiktPm5yX2ZyYWdzOw0KPiA+ICAJCQlzdHJ1Y3QgcGFn
ZSAqcGFnZTsNCj4gPiAgCQkJdTggKnZhZGRyOw0KPiA+DQo+ID4gIAkJCWlmICh1bmxpa2VseShu
cl9mcmFncyA9PSAoTUFYX1NLQl9GUkFHUyAtIDEpICYmDQo+IHhwX21iX2Rlc2MoZGVzYykpKSB7
DQo+ID4gLQkJCQllcnIgPSAtRUZBVUxUOw0KPiA+ICsJCQkJZXJyID0gLUVPVkVSRkxPVzsNCj4g
PiAgCQkJCWdvdG8gZnJlZV9lcnI7DQo+ID4gIAkJCX0NCj4gPg0KPiA+IEBAIC02OTAsMTIgKzY5
MiwxNCBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnhza19idWlsZF9za2Ioc3RydWN0DQo+IHhk
cF9zb2NrICp4cywNCj4gPiAgCXJldHVybiBza2I7DQo+ID4NCj4gPiAgZnJlZV9lcnI6DQo+ID4g
LQlpZiAoZXJyID09IC1FQUdBSU4pIHsNCj4gPiAtCQl4c2tfY3FfY2FuY2VsX2xvY2tlZCh4cywg
MSk7DQo+ID4gLQl9IGVsc2Ugew0KPiA+IC0JCXhza19zZXRfZGVzdHJ1Y3Rvcl9hcmcoc2tiKTsN
Cj4gPiAtCQl4c2tfZHJvcF9za2Ioc2tiKTsNCj4gPiArCWlmIChlcnIgPT0gLUVPVkVSRkxPVykg
ew0KPiANCj4gRG9uJ3QgdGhpbmsgdGhpcyB3aWxsIHdvcms/IFdlIGhhdmUgc29tZSBvdGhlciBl
cnJvciBwYXRocyBpbiB4c2tfYnVpbGRfc2tiDQo+IHRoYXQgYXJlIG5vdCAtRU9WRVJGTE9XIHRo
YXQgc3RpbGwgbmVlZCBrZnJlZV9za2IsIHJpZ2h0Pw0KPiANCg0KVGhlcmUgYXJlIDQgcG9zc2li
bGUgZXJyb3IgcGF0aHMgaW4geHNrX2J1aWxkX3NrYigpOg0KMS4gc29ja19hbGxvY19zZW5kX3Nr
YjogIHNrYiBpcyBOVUxMOyByZXRyeQ0KMi4gc2tiX3N0b3JlX2JpdHMgOiBmcmVlIHNrYiBhbmQg
cmV0cnkNCjMuIE1BWF9TS0JfRlJBR1MgZXhjZWVkZWQ6IEZyZWUgc2tiLCBjbGVhbnVwIGFuZCBk
cm9wIHBhY2tldA0KNC4gYWxsb2NfcGFnZSBmYWlscyBmb3IgZnJhZzogcmV0cnkgcGFnZSBhbGxv
Y2F0aW9uIGZvciBmcmFnIHcvbyBmcmVlaW5nIHNrYg0KDQpPZiB0aGVzZSAxXSBhbmQgM10gY2Fu
IGFsc28gaGFwcGVuIGluIHhza19idWlsZF9za2JfemVyb2NvcHkoKSBhbmQgdGhlIA0KZXJyb3Ig
cmV0dXJuZWQgaXMgZWl0aGVyIC1FT1ZFUkZMT1cgb3Igc29tZXRoaW5nIGVsc2UgYW5kIHRoZSBz
YW1lDQplcnJvciBoYW5kbGluZyBuZWVkcyB0byBiZSBkb25lLg0KDQo+IEkgZmVlbCBsaWtlIHdl
IGFyZSB0cnlpbmcgdG8gc2hhcmUgc29tZSBzdGF0ZSBiZXR3ZWVuIHhza19idWlsZF9za2IgYW5k
DQo+IHhza19idWlsZF9za2JfemVyb2NvcHkgd2hpY2ggd2UgcmVhbGx5IHNob3VsZG4ndCBzaGFy
ZS4gU28gaG93IGFib3V0DQo+IHdlIHRyeSB0byBoYXZlIGEgc2VwYXJhdGUgY2xlYW51cCBwYXRo
IGluIHhza19idWlsZF9za2JfemVyb2NvcHk/DQo+IA0KDQpUaGUgb25seSB0aGluZ3MgdGhhdCBh
cmUgY29tbW9uIGJldHdlZW4gKmNvcHkgYW5kICp6ZXJvY29weSAgcGF0aHMgYXJlIA0Kc2V0dGlu
ZyAgdGhlIHNrYiBoZWFkZXJzIChkZXN0cnVjdG9yL2FyZ3MsIG1hcmssIHByaW9yaXR5KSBhbmQg
ZXJyb3IgaGFuZGxpbmcuDQoNCldoaWxlIHdlIGNhbiBwb3RlbnRpYWxseSBzcGxpdCBvdXQgdGhl
IHBhdGhzIGludG8gaW5kZXBlbmRlbnQgZnVuY3Rpb25zLCB0aGUNCnNhbWUgc2tiIGhlYWRlciBz
ZXR0aW5ncyBhbmQgZXJyb3IgaGFuZGxpbmcgd2lsbCBzdGlsbCBuZWVkIHRvIGJlIGR1cGxpY2F0
ZWQgaW4NCmJvdGggZnVuY3Rpb25zLg0KDQo+IFdpbGwgc29tZXRoaW5nIGxpa2UgdGhlIGZvbGxv
d2luZyAodW50ZXN0ZWQgLyB1bmNvbXBpbGVkKSB3b3JrIGluc3RlYWQ/DQo+IA0KPiBJT1csIGlk
ZWFsbHksIHhza19idWlsZF9za2Igc2hvdWxkIGxvb2sgbGlrZToNCj4gDQo+IAlpZiAoZGV2LT5w
cml2X2ZsYWdzICYgSUZGX1RYX1NLQl9OT19MSU5FQVIpIHsNCj4gCQlyZXR1cm4geHNrX2J1aWxk
X3NrYl96ZXJvY29weSh4cywgZGVzYyk7DQo+IAl9IGVsc2Ugew0KPiAJCXJldHVybiB4c2tfYnVp
bGRfc2tiX2NvcHkoeHMsIGRlc2MpOw0KPiAJCS8qIF5eIGN1cnJlbnQgcGF0aCB0aGF0IHNob3Vs
ZCByZWFsbHkgYmUgYSBzZXBhcmF0ZSBmdW5jICovDQo+IAl9DQo+IA0K

