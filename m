Return-Path: <bpf+bounces-11417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3F17B9985
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 03:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CB4BD281DE0
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 01:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF116136F;
	Thu,  5 Oct 2023 01:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cdp395i+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7B110EE;
	Thu,  5 Oct 2023 01:17:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9172DC0;
	Wed,  4 Oct 2023 18:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696468646; x=1728004646;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MTBJZj4te3MHhsWvMslenm/oZgpS8bgj3DgrhPal/r4=;
  b=Cdp395i+Jh/o5kR9GDaBUWBHNl91h0IFt2k5/4+YqhM30Baq77Pn6/e2
   uH6bWgoZ46AwGXNqhfQpfGs5+r9W6sk0aMORPZwqG44fbuHT+zD0+S34i
   FCr3Eo5boIwkDwtHvIOES/f3nBScRt2sPxP4399WDelsFYm20f+hpwc24
   ejVtkvSH3qN5NA18yLNFTg3fOhy5Zka9rt7AIQrqI5hjY+Kjz4IX8vdCt
   BjXA8MP3xPO74Luj9dr+02GGE1LqzQOyycEolknXDdlag2EDdT9jZiExU
   AIHEIk9ENk4AQlszYjsa5PZCJDvF7uShqhFGgnN/os8ce9/N8gjJASHp3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="380639942"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="380639942"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 18:16:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="821910682"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="821910682"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 18:16:51 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 18:16:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 18:16:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 18:16:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G04T3URYY7AaKo3JpBETLBn4mBVusngdsOdOdyejGHilwGh0MIy+If26KYpONjarxmPZsAPa3Z/t/XmivEJtdE6OgMO9s6yeFB5LIgc7YI54iGPuLgX4dOoR8OIkBX1N2NDBmCT0xj4Xliw0WVTZJJpOVSNgM7nq7pyATyEic8HJTjIpYurcXg8x8PXK6Wh0hKq5PPBfV9BXnNn+GB7+9k0moz3/JcLpxxCYYY+F7elp1Uh0JqP3+Rm3Rhp6WYtvLxnhn3U9SdQk/AizuE2rQ5OMfkXHZe2hY3sA4k4YHHewZQK+CzweK4HO0jDPtvdlutBxaddTUKgZZC0vI9aIPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTBJZj4te3MHhsWvMslenm/oZgpS8bgj3DgrhPal/r4=;
 b=Tb//XP69Awnbu4Em6/zvUVC1DdY29IedMb7I8X0Tll+kkfVOT0ge2VPcoC5s9UMCKUeQCQ/2GB8U8LalNpyz5fRcfE//luBOnVvO7fk/KS+ucEdMKWBZw8Oku0U7phmQttSEzIyes14cD/KUx+JJZ35MwzWXJPCsPAgFG8oF40IgLoynbt7xvMvrxosMrT+0/yIXYKS+5nXRaV7VoWFrN02kXDczCGXNTbpbLoBGyN9Y0pOVjaupOX51kVCtXBq03LBYGimzbesopKwOR1FJYpRQz7LXLfQAMMeOGiL719aWrF1ZSZ0iocVuKujnzE0Kab/tNV/mgvVgUXsfpbbzJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by DM4PR11MB6237.namprd11.prod.outlook.com (2603:10b6:8:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 01:16:31 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::8dbd:e1fa:90f1:2d55]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::8dbd:e1fa:90f1:2d55%4]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 01:16:31 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Stanislav Fomichev <sdf@google.com>
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
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "hawk@kernel.org"
	<hawk@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>
Subject: RE: [PATCH bpf-next v3 02/10] xsk: add TX timestamp and TX checksum
 offload support
Thread-Topic: [PATCH bpf-next v3 02/10] xsk: add TX timestamp and TX checksum
 offload support
Thread-Index: AQHZ9jT8GBnOMBc6bEysAo7c1IeSerA5JpOggADC4QCAAAJogIAAeQ/g
Date: Thu, 5 Oct 2023 01:16:30 +0000
Message-ID: <PH0PR11MB5830AA76FE2D8E03CF66E265D8CAA@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20231003200522.1914523-1-sdf@google.com>
 <20231003200522.1914523-3-sdf@google.com>
 <PH0PR11MB583036756C64ED287ECA2344D8CBA@PH0PR11MB5830.namprd11.prod.outlook.com>
 <ZR2lNjyyNZO4aQP0@google.com> <ZR2nXWne86J7pYQw@google.com>
In-Reply-To: <ZR2nXWne86J7pYQw@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|DM4PR11MB6237:EE_
x-ms-office365-filtering-correlation-id: f3be2689-d06f-464e-9ffc-08dbc540b50e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ic9D+EDljjVgeBKTC1TbuNegzwJkJy1FdY71aVcdKn0cKDm40jjwLbRbqo4GnFXoXYmQNTnGDNzfRj+/OfN/peUyq9ppBe6JpAcua85xQ+V5OQAzNAvYH4P5Iku/z6fJ9GLx1X1OBW8L0dokBJjqfRJc4HPrD4RP5Ya57h2A8+Y21H/dumcKUZ2CmQnOFR5YY9mlaxETO9iJLxviw32sGW/mBKu+tsnW24tzmsI/9vLTPVCkWOr9pzlgNSyV1ye3FA+8eHo6twozueHHEBdm1NA2gVe9oLRDXWiNZEDlVeoq4FeJaIgfwSI0WwuV4j3L0NkuWRkQBaP3lzbX7yU1Ko1pIw4XAwYbBVB4NIJO/fie8XevsjX1m2SUaidFezjgLOH56kEp7qDaj6A4/zxowuPLYMuZMQ0IwdKWhdeZDlGI/Ivt9bSuXyrL1aS0KBa8lB//RHtkO/056sh+2m9D8hOiEla5L+p68NKXU0GfHMKvk5FFHwGSXpS0zCiKdeWyPb4XeZkZZVZfpP2ttjD3V7QXa6G16XOTGBoFkHy6iYeWUq1SWbgpOwJnXXl3fid/bxkI8oRotCVI2B1D1xxaC11sNtIuQt9HMN4QM3u312vxJXQSsMzZTgcoshoI8l9O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(4744005)(2906002)(7416002)(122000001)(86362001)(33656002)(38070700005)(82960400001)(55016003)(38100700002)(53546011)(316002)(6916009)(66476007)(66556008)(66946007)(66446008)(64756008)(76116006)(54906003)(9686003)(7696005)(6506007)(41300700001)(71200400001)(52536014)(8676002)(5660300002)(26005)(8936002)(478600001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2I0NGQ1T043TEFySGNBYjlRbVJaRE1palNXcFRrMHFJZzZkWEwzdTZjMXo1?=
 =?utf-8?B?NmxzOEN0Q0xmQ05SelNMZ2wzMUFGaWRZZk5HVUFjblRmVHNOKzd0dUtFdm1Y?=
 =?utf-8?B?b2lQYVoyMlJZRTZXSE9yNFJkUkNLT2V1cG1EaGtwZE1CSzY4V0NiS0FMSHpv?=
 =?utf-8?B?ejZuN3JpKzdEemVPOFU1OVBpdXE4Wlpja3l3c05Ia1c1bVNucDVzMHdvTzRv?=
 =?utf-8?B?TnR6VFZGcE4vTG56R0FtQUk3RDN5T1dwY05wMWNGWmZTUjgxRStCRVJBVFcw?=
 =?utf-8?B?ZDFBQjhKNFZHanFUMWNSOG8wL1ZZZlBYTG0ydHhmOUlvNUtoRlFpRjBJOUoz?=
 =?utf-8?B?cEk0UlNoa2VEV0wvVmZ5Mkx3SkJNMWhSdXlDTisxVGVWTDM2Uklaa3J1Y01I?=
 =?utf-8?B?bUJ1NWRDT3hncllxc2cwQTV2Q2JYcHV2elNZY0Zsa0JydVc2OGZHaXJYYUVz?=
 =?utf-8?B?d1ZZT3pnRFN1dElJemJiUkdUUDIxc0xudFJoVjE5ME9UZTJwSmZyZnp3WnUx?=
 =?utf-8?B?aHdHTWVUSllzSWhrcTRXTjRFWjNRNUk1R3pIS1pJbmRsQ1VLR09nWkZiY2g5?=
 =?utf-8?B?K1Izekg1ditGa0Z1a09KTTBPRnFwUWNpRDZ5V01DYW9RQm92NVVZWFVrVXdQ?=
 =?utf-8?B?WkhHQzVzNGY2Y0xVdnExMG1RVWkzUmtUNVBEd2xUTGZ3OFNxWGM5UFZYMDdQ?=
 =?utf-8?B?Qnk4eVFaTjFCVmVSWVVLUkQ1UkR3UTBDOGpWMjhBcndvYU1rNnpueEkzSE8v?=
 =?utf-8?B?VzFiUnphOGtZK0dJY1ZWTFViaTJzUjkvQVB3M0tUeFI1RGtwN2ZqWTBiZlBz?=
 =?utf-8?B?KzJUdGJ1NTQzWDNoQmFzY0xRcnVZbjNsSFZ3RjFiS01JSy9vUlRyTk0raGRS?=
 =?utf-8?B?QkVva2pHVGU2aWVDUi9odnZJNGphaE1XRm0xa3BhYkJYZzFaTGpZRWlId0x0?=
 =?utf-8?B?RERGK2RQRHZsYmtXSG1FNHE2empCTGlOS25nOG9OUDNyZTIybWFUR1QrdjlR?=
 =?utf-8?B?UWpHZVpBVzM4bDBPUG9QNFROMHNsRy9oSDhyRU1LTExPTFlocVRrWEk3MXFK?=
 =?utf-8?B?cjBzVGV2MkVyY0Q0ZmR0VjZsUHc5alFBcGt6a0JmV29KQUk1Z0NJZnVsMmdk?=
 =?utf-8?B?blNYSVcwUUY4eUJoS0hOb1VkcXRTbkRjajM0aDFwczdtRmtZamc3T0JRQ3U1?=
 =?utf-8?B?ZThkQzZVL2h2c0huMlduVFFPVlozanF3RVRsNllhTGp5MWRCQ1pBSVFhbjM3?=
 =?utf-8?B?UGpsMGFKRVk5Nmx2MlVCZTNDbzNZQTNWQVZHTlVVYlAvMzhQM2g4MmhBWDMv?=
 =?utf-8?B?bjZpS241MVN0dkpBaTBId3h6bCthS0JaSUFrT2M0MlpSdG0wbDFrQXBSUWhX?=
 =?utf-8?B?OUtoVndnNUJzOEhNUFpyZG5WZ2xkZ1RHWFoyMjYza3U3WEszTTdwYXE0bUJG?=
 =?utf-8?B?SmRKakxMZFBRSkxmZ0lvSmtpV21PcUxDV2k5cnNJVnlWL01mUEM2TnhId3FV?=
 =?utf-8?B?RW1Ra2xMZjIwcDROZWhkU1pMczR6UEw4eWh4eFNTMUlzckN5Tm13Y2I3SC8y?=
 =?utf-8?B?d1UxUUQraCsrM0xNRFNUb1BLWVd0YXhpa0JGaVgySmFFbkw2U0J1Mzd3bUVV?=
 =?utf-8?B?UmR5ZVpldFJYMFhVUWFERkxnVWd2VmRNZlNGUVBvVGgwRnkraVZpUjMrV3R1?=
 =?utf-8?B?U09KZTk5cVhYamxjRzBFUTJmVG0vTUVSM1Ewa3k0cVg5VHNYUzE1SUdFYUlz?=
 =?utf-8?B?OGFQTkZYRnRvZWlzeUZJSkV6UXFwcklUTlVYU3ZGWkZQOXorNjRNYWN2Z0NT?=
 =?utf-8?B?UlR0VEo5UzYwcFVZVHRncDVIaXp1SDdCYXNNN2xia0ZVMmwrZWgzSUcydlpF?=
 =?utf-8?B?aGUyRFdTS3pzdUNUbzEvd1czZlBNNzlyTEJNdnZXWmRkR2c4NnExQmlHanNW?=
 =?utf-8?B?M2FWK0szRHNvNFh1SGZ0ekV5d1d4YURYazNSTWk5U2NsL0t5TlU1QVAxNFEx?=
 =?utf-8?B?VmRhSG85VmdRZ3AxbUVDRWtPbHZTelF4TzFBSWJFTWNpYXgxWmZtZUY1SUo0?=
 =?utf-8?B?WGFiVGRWclRFbjZkT1R1cUwydFFUQVQ0ZlUzc3pTTk1uSStQVDlvVmRSOWdL?=
 =?utf-8?B?RHBYSGJ3Y1FoUWlCVmhWK2RqSXptM0V1b05NUE5vd2d5RTg5NkVsMy9mbE53?=
 =?utf-8?B?T0E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f3be2689-d06f-464e-9ffc-08dbc540b50e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 01:16:30.9060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YLa4gPK+XKeVd97So3ujeOcvSOvdIbFf3NJSrGH8v8MBJD7fHJ7VjuF0DQY8/SLVPw4S1eX1OZMdIds/p1GiX72TM0UNYf7L0lHi2TwoQJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6237
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gVGh1cnNkYXksIE9jdG9iZXIgNSwgMjAyMyAxOjU3IEFNIFN0YW5pc2xhdiBGb21pY2hldiA8
c2RmQGdvb2dsZS5jb20+IHdyb3RlOg0KPlllYWgsIGxvb2tzIGxpa2UgdGhpcyBwYXJ0IGlzIG5v
dCBoYXBweSwgZG9lc24ndCBsb29rIGxpa2UgQklUKCkgaXMgZXhwb3J0ZWQgdG8gVUFQSSwNCj5w
ZXI6DQo+DQo+Y2hlY2sgZm9yICNkZWZpbmVzIGxpa2U6IDEgPDwgPGRpZ2l0PiB0aGF0IGNvdWxk
IGJlIEJJVChkaWdpdCksIGl0IGlzIG5vdCBleHBvcnRlZCB0bw0KPnVhcGkNCk5vdGVkLg0KPg0K
PlNvIEknbGwgcmV2ZXJ0IHRvIDw8IGxpa2UgaW4gdGhlIHJlc3Qgb2YgdGhpcyBmaWxlLg0KU3Vy
ZS4gSSBhbSBvayB0byBrZWVwIDw8DQoNCg==

