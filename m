Return-Path: <bpf+bounces-18854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B67822977
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 09:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A772844F3
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 08:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90857182A4;
	Wed,  3 Jan 2024 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dzarWPBw"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE49182A7;
	Wed,  3 Jan 2024 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704270362; x=1735806362;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qqlvwpQlrkt6j9PqrkEkfGwmAYL5tX2M9F4tJy3egWM=;
  b=dzarWPBw0DfQeXH8Ots+W+U/GL2edLKB+ogtdpY5WGltayrdXqUecWaI
   7X6Bo2IYq+f9UrQbEfvFMsG57ydUsxzCEMFaoX11/4vmQUcz5FHRlwQn9
   iXv4jJDfD/SE/m3mX7d2nSMZBgUj0mtY/5vePKFotMNNQHI0lTRhIhSTc
   hTwdzUaTYVQaEYUpJbRsvDSkVVnjvI0NV42D/jpEYLFcdi85e0T4FS2BS
   RqXHP+L/SC4Io/dCAa7anZuTh6PFx/iYgyDiF8zLd9rtpYCUWV0FcEcvH
   NzLeOeD6lKItmSoJWh0hP0TPt6p9946NOsBA3eRFvhxM7UIW6mhLEUKFn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="4324412"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="4324412"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 00:26:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="953158518"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="953158518"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 00:25:59 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 00:25:59 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 00:25:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 00:25:58 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 00:25:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzabfzwDA92ThxDuf6inLBXj2itEvwhfavksy31+NgQ5pJ/ouUyE3vxwCy3JtwnOIpfZWR/mxqBGnyi4EiOlKm5Q1qjSP56w2k6avKcoJaayvC8S+liz3lQO8H8/NS1f+nqu9oQBH7YFJxOXANMC985swGF+ywpkCB1cLsnaC5sD6KQUi/e5+OSjSCq7PjQC1DbkUTiSSQ8Z2uH5LZeT53eXwlD/V2ianRI28BAw1LpoT4qPp9HNXhw+0VxFhaNowGloXxpgVdisaYp40C6F2D/jV4lFkQfrKTktMu/k/hMlVjAFfFyKg2SY9jfhumUmqwVKsaz4CY8NRkoTAEfoUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPPjqzH4maShF1n9PpyeqL0cPurPhI4/+eSaD0063dc=;
 b=S027EZ5iZgFOF8UAJnf+PY5GAC6eYt/PjEIVUMEJDc+POxHHGaE3Y2TneI6U9iU7LnHBYnUCzkMWvxAwopS9Xqdrt9BSqovJZuzuyxPmpd8aBBBnEZLj2Gd7mG9p2CoMEYujOvUU3J6DcxaI4nY2Uy8+uDC+wADa7O8p9zppFQrESe76bwqKeqbjEifMF83IRHSWNHvdw8jeb4A1IQMESxfJNCi9NJzrvc8B46guZTzP7tH3izMAhbd6mowirA9lyybpQdcEknhb9S59L0Q9Z3b5b4+NXLFg9FjpOPZfKtc11BpewlaXzuEdn8hHDAJvzyJnOfiOVPwyeySq6RL27g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by PH7PR11MB8550.namprd11.prod.outlook.com (2603:10b6:510:30c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 08:25:50 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::6ffc:93a3:6d7f:383c]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::6ffc:93a3:6d7f:383c%6]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 08:25:49 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: "Gomes, Vinicius" <vinicius.gomes@intel.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@google.com>, "Bezdeka,
 Florian" <florian.bezdeka@siemens.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "xdp-hints@xdp-project.net"
	<xdp-hints@xdp-project.net>
Subject: RE: [PATCH iwl-next,v1 1/1] igc: Add Tx hardware timestamp request
 for AF_XDP zero-copy packet
Thread-Topic: [PATCH iwl-next,v1 1/1] igc: Add Tx hardware timestamp request
 for AF_XDP zero-copy packet
Thread-Index: AQHaL3Lw985N7ti7QEetzWznCSMLw7DGtysAgAERVhA=
Date: Wed, 3 Jan 2024 08:25:49 +0000
Message-ID: <PH0PR11MB5830B6742A03D2B1AC4A0A6ED860A@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20231215162158.951925-1-yoong.siang.song@intel.com>
 <87il4b6b7r.fsf@intel.com>
In-Reply-To: <87il4b6b7r.fsf@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|PH7PR11MB8550:EE_
x-ms-office365-filtering-correlation-id: e4574f6c-8c5a-4f87-8574-08dc0c3597c0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5i7FhW/1vFFnXIz5SyDC8YkdlM2OlBb22iMEudY42FTrO1hA43QG6QeeiyjuadqZnSgH2Svx8QxkvD5A8AoVZVw+iR7/ii0yyusMMZEck9QaMz7PO1o10NMaIjIFhaHn6/wVWb8w+I857g5+HStKncD3eKYnpO+8/fXcpnSe850oLEA0huHsuVxQRwyCfO3IcDoRCi8Hq6bHQ5Tkx820eSs9TARrtcHs9qaatmUXrS/7v1SskjW7lGOznyn5nxoCgRLOtPYs4ISbaZWSZLW6qC/LYnMOCxRAE9sbSM9Cewnd56vJXKAnYoM3tYbIUEokQQndw2+V+dl+VCuMdjwYfM4mH5eO64MbbRw2AK6dIbMiqMZA5Un5SMJRqCPYAdP31S0FW1IKAzJdE2jR4ZJiP92ZRmqAPxEtnOpCSBMwK2FQvsYRWz0AXkfVXnK8hS4NNZEOOU7uwUG6mIa+tv3mRB27yhPwOKILjtqXS+U6954JORpl+9/OrmEeMFlshq+7XgwVk9Xuxfc8ccvvyHQFjLul2IQ3CIbR+tJBJjC+KQCXkWN0+QOhnN4CNk0tAWmiCcqP21BjIxN1wCot4BufOIv0KFzr0gvbG10nvz0qJzaJIS8fK+2BSFsnOLrPMKqGhV5794zajJ7ArJEev83h8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(7416002)(26005)(83380400001)(2906002)(38100700002)(122000001)(82960400001)(110136005)(316002)(54906003)(71200400001)(8676002)(8936002)(52536014)(5660300002)(30864003)(4326008)(478600001)(66446008)(6506007)(66946007)(76116006)(66556008)(66476007)(9686003)(64756008)(7696005)(53546011)(86362001)(38070700009)(33656002)(55016003)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3kwQLzY6ANAzLDO9uxHo96cYZ9hEaBF+TY/E7Cu00vzrcIM1tdmgAY1yuV8I?=
 =?us-ascii?Q?ijTREE+6LVmfg6yCgacE79KOL14At5Wlhd6tU7X4hHkOpSdmIl4GEHChY6Im?=
 =?us-ascii?Q?XNRSVzLaTgb0ENKEWwyStoPKJzCa0Cmt0ikkuYUQ8vaczhTyjgNPcd9FBfHk?=
 =?us-ascii?Q?kgSdzkmMjq+j222HBzLLj9UFWthdoZnJwGoN5gTTn06pLVwDdXMeoqgisiGx?=
 =?us-ascii?Q?96336kFqmHAzSJG77de/co9nAPAmUzklbLgxlbQsStu79SnGkuSdsse1+yzr?=
 =?us-ascii?Q?TeZIsFTkFWjK6/duc6vAKwu/0oo9La9PJpb22c94H0tS0bybiyUwqmO7FxZU?=
 =?us-ascii?Q?iOpMFfDzFA6/QH3BW/nl0UHWW8L9HPaFsIRRBQI0mvIJPSybNX+quRuIaiJT?=
 =?us-ascii?Q?lND34fo+zWbSukf4TBSxhNwP7vW7dIGu+UC+t7TFVVR2gSdzrJYlfl9uhukS?=
 =?us-ascii?Q?NEwomCZGpe4SS6TPGUA89M5RhxcFwbDT5iYIBYr6J2ttJmvQcA89/sOMTh4X?=
 =?us-ascii?Q?NRVNDuT0/Q6DS7WFBBsyR5FGwCCyit7eq8NmhTWcmnopY7lSsJIqbbVUOww9?=
 =?us-ascii?Q?O5hVfhQDRLTrGkV9G/F9ufQ9/FFU/2pzxZo/i+dq5nN/P+uCnBWcs0Ea/a7u?=
 =?us-ascii?Q?XmWAdcZiZng2CScoJfzJuSuc7qBrDtyLt0j3MHwRVnqmBvVh2jodULQQiF4H?=
 =?us-ascii?Q?3OsjrRXVnlkR4OWhxrOYiccPkDuIhpNFWzic6ioNs3/rvvOMqLoBYeUEXabz?=
 =?us-ascii?Q?ZAgacnMeZD/RN52ECaT4Wy5+iVnPzam60un0Qpo/B6yXnnzCcudNuTz1Ll+k?=
 =?us-ascii?Q?Amr12xMC1q4Io1093n94nw/Phs5oqTkFJBhvv0smkVwpqLS1R0IX3SAaEx30?=
 =?us-ascii?Q?gsg6himO44cA04GR1937JHT8nAl5iwFX7PpVBNBajQYpsiO712/Ij/cIXDkE?=
 =?us-ascii?Q?3lU5lUStevAvdIu2etpBtEdEHldXp3fEMloktNh4U8veixIFlrhXtlSiTNfK?=
 =?us-ascii?Q?p9qIFb4V8Mvw5yWU7bJ2W0oWyUwrl41vLoJMklYOuZQxqKznt7WpvM1goZMZ?=
 =?us-ascii?Q?KQkn9b1vyXif6Bi1BsGkD/xokK5M6YIJ9Znqx8GUINYYHudrLZG6Wahe2TiM?=
 =?us-ascii?Q?Xy0WqTK03tbyNNNUFn2oeJfEpEs0ZlxgTG6uow1VF2RiFTXmjYfKrCcvRinn?=
 =?us-ascii?Q?tBf12eg/qywhoj7FI/sFvY8C7faXEOCQxM6gep/jYh2TMxaWMRGnReTdNwMl?=
 =?us-ascii?Q?jHiyYYzZaV6/GQxpX/pJoVPjeM+vIpcheYH4WsSV3dQREO8HLi7Mk3rfFSN4?=
 =?us-ascii?Q?HJFViP41jsFh5ZhigcYCugzNjnF+cFKlo1Xr6EGxF7m9pyjm7aoMKBvun/H7?=
 =?us-ascii?Q?ExozCnRGjRjPHyjjhfkS6qzQZKYqX9P5+vexTWgnXvL2HAuHVKPW37fLhFQQ?=
 =?us-ascii?Q?jwWSENGMn8Xcs46539ERqR6q8/ZnQNfeFKbsX7PLJc9wK2MaBE+9D0riOpD/?=
 =?us-ascii?Q?xWA+lEkJ1EU0LLSMTHip2ODzjTrwvqwlGY+161TZ9BvP+M9UymElrP1lkPGW?=
 =?us-ascii?Q?5diWmH9mMrEv/Z+QNpO1LS0i8yUVI/weWkLeHvXZof+fcOdLdmrJX+ejU8lP?=
 =?us-ascii?Q?uQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4574f6c-8c5a-4f87-8574-08dc0c3597c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 08:25:49.8453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qok71YBjtjt+2byGzemZ1JHfhhFBRM5G5xInFoNbuGNnJie1pxZhCTkn4LAp8SNWmxeTa6p0JFluCu0TpdS5xubJlqFRzqT2dQ0fDauP4nE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8550
X-OriginatorOrg: intel.com

On Tuesday, January 2, 2024 10:51 PM, Gomes, Vinicius <vinicius.gomes@intel=
.com> wrote:
>Song Yoong Siang <yoong.siang.song@intel.com> writes:
>
>> This patch adds support to per-packet Tx hardware timestamp request to
>> AF_XDP zero-copy packet via XDP Tx metadata framework. Please note that
>> user needs to enable Tx HW timestamp capability via igc_ioctl() with
>> SIOCSHWTSTAMP cmd before sending xsk Tx timestamp request.
>>
>> Same as implementation in RX timestamp XDP hints kfunc metadata, Timer 0
>> (adjustable clock) is used in xsk Tx hardware timestamp. i225/i226 have
>> four sets of timestamping registers. A pointer named "xsk_pending_ts"
>> is introduced to indicate the timestamping register is already occupied.
>> Furthermore, the mentioned pointer also being used to hold the transmit
>> completion until the tx hardware timestamp is ready. This is because for
>> i225/i226, the timestamp notification comes some time after the transmit
>> completion event. The driver will retrigger hardware irq to clean the
>> packet after retrieve the tx hardware timestamp.
>>
>> Besides, a pointer named "xsk_meta" is added into igc_tx_timestamp_reque=
st
>> structure as a hook to the metadata location of the transmit packet. Whe=
n
>> a Tx timestamp interrupt happens, the interrupt handler will copy the
>> value of Tx timestamp into metadata via xsk_tx_metadata_complete().
>>
>> This patch is tested with tools/testing/selftests/bpf/xdp_hw_metadata
>> on Intel ADL-S platform. Below are the test steps and results.
>>
>> Command on DUT:
>> sudo ./xdp_hw_metadata <interface name>
>> sudo hwstamp_ctl -i <interface name> -t 1 -r 1
>> sudo ./testptp -d /dev/ptp0 -s
>>
>> Command on Link Partner:
>> echo -n xdp | nc -u -q1 <destination IPv4 addr> 9091
>>
>> Result:
>> xsk_ring_cons__peek: 1
>> 0x555b112ae958: rx_desc[6]->addr=3D86110 addr=3D86110 comp_addr=3D86110 =
EoP
>> rx_hash: 0xBFDEC36E with RSS type:0x1
>> HW RX-time:   1677762429190040955 (sec:1677762429.1900) delta to User RX=
-time
>sec:0.0001 (100.124 usec)
>> XDP RX-time:   1677762429190123163 (sec:1677762429.1901) delta to User R=
X-time
>sec:0.0000 (17.916 usec)
>> 0x555b112ae958: ping-pong with csum=3D404e (want c59e) csum_start=3D34
>csum_offset=3D6
>> 0x555b112ae958: complete tx idx=3D6 addr=3D6010
>> HW TX-complete-time:   1677762429190173323 (sec:1677762429.1902) delta t=
o
>User TX-complete-time sec:0.0100 (10035.884 usec)
>> XDP RX-time:   1677762429190123163 (sec:1677762429.1901) delta to User T=
X-
>complete-time sec:0.0101 (10086.044 usec)
>> HW RX-time:   1677762429190040955 (sec:1677762429.1900) delta to HW TX-
>complete-time sec:0.0001 (132.368 usec)
>> 0x555b112ae958: complete rx idx=3D134 addr=3D86110
>>
>> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
>> ---
>>  drivers/net/ethernet/intel/igc/igc.h      | 15 ++++
>>  drivers/net/ethernet/intel/igc/igc_main.c | 88 ++++++++++++++++++++++-
>>  drivers/net/ethernet/intel/igc/igc_ptp.c  | 42 ++++++++---
>>  3 files changed, 134 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet=
/intel/igc/igc.h
>> index ac7c861e83a0..c831dde01662 100644
>> --- a/drivers/net/ethernet/intel/igc/igc.h
>> +++ b/drivers/net/ethernet/intel/igc/igc.h
>> @@ -79,6 +79,9 @@ struct igc_tx_timestamp_request {
>>  	u32 regl;              /* which TXSTMPL_{X} register should be used */
>>  	u32 regh;              /* which TXSTMPH_{X} register should be used */
>>  	u32 flags;             /* flags that should be added to the tx_buffer =
*/
>> +	u8 xsk_queue_index;    /* Tx queue which requesting timestamp */
>> +	bool *xsk_pending_ts;  /* ref to tx ring for waiting timestamp event *=
/
>
>I think that this indirection level to xsk_pending_ts in the tx_buffer is =
a
>bit too hard to follow. What I am thinking is keeping a pointer to
>tx_buffer here in igc_tx_timestamp_request, perhaps even in a union with
>the skb, and use a similar logic, if that pointer is valid the timestamp
>request is in use.
>
>Do you think it could work?
>
>(Perhaps we would need to also store the buffer type in the request, but
>I don't think that would be too weird)
>

Hi Vinicius,

Thanks for your comments.=20
Keep a pointer to tx_buffer will work. I will make the pointer a union
with skb and use buffer_type to indicate whether skb or tx_buffer pointer s=
hould be use.
Is this sound better?=20
=20
>> +	struct xsk_tx_metadata_compl xsk_meta;	/* ref to xsk Tx metadata */
>>  };
>>
>>  struct igc_inline_rx_tstamps {
>> @@ -319,6 +322,9 @@ void igc_disable_tx_ring(struct igc_ring *ring);
>>  void igc_enable_tx_ring(struct igc_ring *ring);
>>  int igc_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags);
>>
>> +/* AF_XDP TX metadata operations */
>> +extern const struct xsk_tx_metadata_ops igc_xsk_tx_metadata_ops;
>> +
>>  /* igc_dump declarations */
>>  void igc_rings_dump(struct igc_adapter *adapter);
>>  void igc_regs_dump(struct igc_adapter *adapter);
>> @@ -528,6 +534,7 @@ struct igc_tx_buffer {
>>  	DEFINE_DMA_UNMAP_ADDR(dma);
>>  	DEFINE_DMA_UNMAP_LEN(len);
>>  	u32 tx_flags;
>> +	bool xsk_pending_ts;
>>  };
>>
>>  struct igc_rx_buffer {
>> @@ -553,6 +560,14 @@ struct igc_xdp_buff {
>>  	struct igc_inline_rx_tstamps *rx_ts; /* data indication bit
>IGC_RXDADV_STAT_TSIP */
>>  };
>>
>> +struct igc_metadata_request {
>> +	struct xsk_tx_metadata *meta;
>> +	struct igc_adapter *adapter;
>
>If you have access to the tx_ring, you have access to the adapter, no
>need to have it here.

Sure, I will remove it and use
adapter =3D netdev_priv(tx_ring->netdev);

>
>> +	struct igc_ring *tx_ring;
>> +	bool *xsk_pending_ts;
>> +	u32 *cmd_type;
>
>I think this also would be clearer if here you had a pointer to the
>tx_buffer instead of only 'xsk_pending_ts'.
>

No problem. I will try to use tx_buffer pointer.

>I guess for cmd_type, no need for it to be a pointer, we can affort the
>extra copy.
>

I use pointer because we need to bring out the value of cmd_type and put it=
 into tx_desc:
tx_desc->read.cmd_type_len =3D cpu_to_le32(cmd_type);
In this case, do you think it is make sense to keep cmd_type pointer?

>> +};
>> +
>>  struct igc_q_vector {
>>  	struct igc_adapter *adapter;    /* backlink */
>>  	void __iomem *itr_register;
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
>b/drivers/net/ethernet/intel/igc/igc_main.c
>> index 61db1d3bfa0b..311c85f2d82d 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -1553,7 +1553,7 @@ static bool igc_request_tx_tstamp(struct igc_adapt=
er
>*adapter, struct sk_buff *s
>>  	for (i =3D 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
>>  		struct igc_tx_timestamp_request *tstamp =3D &adapter->tx_tstamp[i];
>>
>> -		if (tstamp->skb)
>> +		if (tstamp->skb || tstamp->xsk_pending_ts)
>>  			continue;
>>
>>  		tstamp->skb =3D skb_get(skb);
>> @@ -2878,6 +2878,71 @@ static void igc_update_tx_stats(struct igc_q_vect=
or
>*q_vector,
>>  	q_vector->tx.total_packets +=3D packets;
>>  }
>>
>> +static void igc_xsk_request_timestamp(void *_priv)
>> +{
>> +	struct igc_metadata_request *meta_req =3D _priv;
>> +	struct igc_ring *tx_ring =3D meta_req->tx_ring;
>> +	struct igc_tx_timestamp_request *tstamp;
>> +	u32 *cmd_type =3D meta_req->cmd_type;
>> +	u32 tx_flags =3D IGC_TX_FLAGS_TSTAMP;
>> +	struct igc_adapter *adapter;
>> +	unsigned long lock_flags;
>> +	bool found =3D 0;
>> +	int i;
>> +
>> +	if (test_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags)) {
>> +		adapter =3D meta_req->adapter;
>> +
>> +		spin_lock_irqsave(&adapter->ptp_tx_lock, lock_flags);
>> +
>> +		for (i =3D 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
>> +			tstamp =3D &adapter->tx_tstamp[i];
>> +
>> +			if (tstamp->skb || tstamp->xsk_pending_ts)
>> +				continue;
>> +
>> +			found =3D 1;
>
>nitpick: found is a bool, 'true' would read better.
>

You are right. I will change it accordingly.

>> +			break;
>> +		}
>> +
>> +		if (!found) {
>> +			adapter->tx_hwtstamp_skipped++;
>
>I think this is one those cases, that an early return or a goto would
>make the code easier to understand.
>

Ok, I will unlock the tx_ptp_lock here and make an early return.

>> +		} else {
>> +			tstamp->start =3D jiffies;
>> +			tstamp->xsk_queue_index =3D tx_ring->queue_index;
>> +
>> +			tstamp->xsk_pending_ts =3D meta_req->xsk_pending_ts;
>> +			*tstamp->xsk_pending_ts =3D true;
>> +
>> +			xsk_tx_metadata_to_compl(meta_req->meta,
>> +						 &tstamp->xsk_meta);
>> +
>> +			/* set timestamp bit based on the _TSTAMP(_X) bit. */
>> +			tx_flags |=3D tstamp->flags;
>> +			*cmd_type |=3D IGC_SET_FLAG(tx_flags,
>IGC_TX_FLAGS_TSTAMP,
>> +						  (IGC_ADVTXD_MAC_TSTAMP));
>> +			*cmd_type |=3D IGC_SET_FLAG(tx_flags,
>IGC_TX_FLAGS_TSTAMP_1,
>> +						  (IGC_ADVTXD_TSTAMP_REG_1));
>> +			*cmd_type |=3D IGC_SET_FLAG(tx_flags,
>IGC_TX_FLAGS_TSTAMP_2,
>> +						  (IGC_ADVTXD_TSTAMP_REG_2));
>> +			*cmd_type |=3D IGC_SET_FLAG(tx_flags,
>IGC_TX_FLAGS_TSTAMP_3,
>> +						  (IGC_ADVTXD_TSTAMP_REG_3));
>> +		}
>> +
>> +		spin_unlock_irqrestore(&adapter->ptp_tx_lock, lock_flags);
>> +	}
>> +}
>> +
>> +static u64 igc_xsk_fill_timestamp(void *_priv)
>> +{
>> +	return *(u64 *)_priv;
>> +}
>> +
>> +const struct xsk_tx_metadata_ops igc_xsk_tx_metadata_ops =3D {
>> +	.tmo_request_timestamp		=3D igc_xsk_request_timestamp,
>> +	.tmo_fill_timestamp		=3D igc_xsk_fill_timestamp,
>> +};
>> +
>>  static void igc_xdp_xmit_zc(struct igc_ring *ring)
>>  {
>>  	struct xsk_buff_pool *pool =3D ring->xsk_pool;
>> @@ -2899,6 +2964,8 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
>>  	budget =3D igc_desc_unused(ring);
>>
>>  	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
>> +		struct igc_metadata_request meta_req;
>> +		struct xsk_tx_metadata *meta =3D NULL;
>>  		u32 cmd_type, olinfo_status;
>>  		struct igc_tx_buffer *bi;
>>  		dma_addr_t dma;
>> @@ -2909,14 +2976,23 @@ static void igc_xdp_xmit_zc(struct igc_ring *rin=
g)
>>  		olinfo_status =3D xdp_desc.len << IGC_ADVTXD_PAYLEN_SHIFT;
>>
>>  		dma =3D xsk_buff_raw_get_dma(pool, xdp_desc.addr);
>> +		meta =3D xsk_buff_get_metadata(pool, xdp_desc.addr);
>>  		xsk_buff_raw_dma_sync_for_device(pool, dma, xdp_desc.len);
>> +		bi =3D &ring->tx_buffer_info[ntu];
>> +
>> +		meta_req.adapter =3D netdev_priv(ring->netdev);
>> +		meta_req.tx_ring =3D ring;
>> +		meta_req.meta =3D meta;
>> +		meta_req.cmd_type =3D &cmd_type;
>> +		meta_req.xsk_pending_ts =3D &bi->xsk_pending_ts;
>> +		xsk_tx_metadata_request(meta, &igc_xsk_tx_metadata_ops,
>> +					&meta_req);
>>
>>  		tx_desc =3D IGC_TX_DESC(ring, ntu);
>>  		tx_desc->read.cmd_type_len =3D cpu_to_le32(cmd_type);
>>  		tx_desc->read.olinfo_status =3D cpu_to_le32(olinfo_status);
>>  		tx_desc->read.buffer_addr =3D cpu_to_le64(dma);
>>
>> -		bi =3D &ring->tx_buffer_info[ntu];
>>  		bi->type =3D IGC_TX_BUFFER_TYPE_XSK;
>>  		bi->protocol =3D 0;
>>  		bi->bytecount =3D xdp_desc.len;
>> @@ -2979,6 +3055,13 @@ static bool igc_clean_tx_irq(struct igc_q_vector
>*q_vector, int napi_budget)
>>  		if (!(eop_desc->wb.status & cpu_to_le32(IGC_TXD_STAT_DD)))
>>  			break;
>>
>> +		/* Hold the completions while there's a pending tx hardware
>> +		 * timestamp request from XDP Tx metadata.
>> +		 */
>> +		if (tx_buffer->type =3D=3D IGC_TX_BUFFER_TYPE_XSK &&
>> +		    tx_buffer->xsk_pending_ts)
>> +			break;
>> +
>
>One scenario that I am worried about the completion part is when tstamp
>and non-tstamp packets are mixed in the same queue.
>
>For example, when the user sends a 1 tstamp packet followed by 1
>non-tstamp packet. Some other ratios might be interesting to test as
>well, 1:10 for example. I guess a simple bandwith test would be enough,
>comparing "non-tstamp only" with mixed traffic.
>
>Perhaps are some bad recollections from the past, but I remember that
>the hardware takes a bit of time when generating the timestamp
>interrupts, and so those types of mixed traffic would have wasted
>bandwidth.
>

Sure. I will try to perform some bandwidth test and share the result.
I guess I will try to use iperf.=20
Any bandwidth test app that come into your mind?=20

>>  		/* clear next_to_watch to prevent false hangs */
>>  		tx_buffer->next_to_watch =3D NULL;
>>
>> @@ -6819,6 +6902,7 @@ static int igc_probe(struct pci_dev *pdev,
>>
>>  	netdev->netdev_ops =3D &igc_netdev_ops;
>>  	netdev->xdp_metadata_ops =3D &igc_xdp_metadata_ops;
>> +	netdev->xsk_tx_metadata_ops =3D &igc_xsk_tx_metadata_ops;
>>  	igc_ethtool_set_ops(netdev);
>>  	netdev->watchdog_timeo =3D 5 * HZ;
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c
>b/drivers/net/ethernet/intel/igc/igc_ptp.c
>> index 885faaa7b9de..b722bca40309 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_ptp.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/ktime.h>
>>  #include <linux/delay.h>
>>  #include <linux/iopoll.h>
>> +#include <net/xdp_sock.h>
>>
>>  #define INCVALUE_MASK		0x7fffffff
>>  #define ISGN			0x80000000
>> @@ -555,8 +556,15 @@ static void igc_ptp_clear_tx_tstamp(struct igc_adap=
ter
>*adapter)
>>  	for (i =3D 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
>>  		struct igc_tx_timestamp_request *tstamp =3D &adapter->tx_tstamp[i];
>>
>> -		dev_kfree_skb_any(tstamp->skb);
>> -		tstamp->skb =3D NULL;
>> +		if (tstamp->skb) {
>> +			dev_kfree_skb_any(tstamp->skb);
>> +			tstamp->skb =3D NULL;
>> +		} else if (tstamp->xsk_pending_ts) {
>> +			*tstamp->xsk_pending_ts =3D false;
>> +			tstamp->xsk_pending_ts =3D NULL;
>> +			igc_xsk_wakeup(adapter->netdev, tstamp->xsk_queue_index,
>> +				       0);
>> +		}
>>  	}
>>
>>  	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
>> @@ -657,8 +665,15 @@ static int igc_ptp_set_timestamp_mode(struct igc_ad=
apter
>*adapter,
>>  static void igc_ptp_tx_timeout(struct igc_adapter *adapter,
>>  			       struct igc_tx_timestamp_request *tstamp)
>>  {
>> -	dev_kfree_skb_any(tstamp->skb);
>> -	tstamp->skb =3D NULL;
>> +	if (tstamp->skb) {
>> +		dev_kfree_skb_any(tstamp->skb);
>> +		tstamp->skb =3D NULL;
>> +	} else if (tstamp->xsk_pending_ts) {
>> +		*tstamp->xsk_pending_ts =3D false;
>> +		tstamp->xsk_pending_ts =3D NULL;
>> +		igc_xsk_wakeup(adapter->netdev, tstamp->xsk_queue_index, 0);
>> +	}
>> +
>>  	adapter->tx_hwtstamp_timeouts++;
>>
>>  	netdev_warn(adapter->netdev, "Tx timestamp timeout\n");
>> @@ -677,7 +692,7 @@ void igc_ptp_tx_hang(struct igc_adapter *adapter)
>>  	for (i =3D 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
>>  		tstamp =3D &adapter->tx_tstamp[i];
>>
>> -		if (!tstamp->skb)
>> +		if (!tstamp->skb && !tstamp->xsk_pending_ts)
>>  			continue;
>>
>>  		if (time_is_after_jiffies(tstamp->start + IGC_PTP_TX_TIMEOUT))
>> @@ -705,7 +720,7 @@ static void igc_ptp_tx_reg_to_stamp(struct igc_adapt=
er
>*adapter,
>>  	int adjust =3D 0;
>>
>>  	skb =3D tstamp->skb;
>> -	if (!skb)
>> +	if (!skb && !tstamp->xsk_pending_ts)
>>  		return;
>>
>>  	if (igc_ptp_systim_to_hwtstamp(adapter, &shhwtstamps, regval))
>> @@ -729,10 +744,19 @@ static void igc_ptp_tx_reg_to_stamp(struct igc_ada=
pter
>*adapter,
>>  	shhwtstamps.hwtstamp =3D
>>  		ktime_add_ns(shhwtstamps.hwtstamp, adjust);
>>
>> -	tstamp->skb =3D NULL;
>> +	if (skb) {
>> +		tstamp->skb =3D NULL;
>> +		skb_tstamp_tx(skb, &shhwtstamps);
>> +		dev_kfree_skb_any(skb);
>> +	} else {
>> +		xsk_tx_metadata_complete(&tstamp->xsk_meta,
>> +					 &igc_xsk_tx_metadata_ops,
>> +					 &shhwtstamps.hwtstamp);
>>
>> -	skb_tstamp_tx(skb, &shhwtstamps);
>> -	dev_kfree_skb_any(skb);
>> +		*tstamp->xsk_pending_ts =3D false;
>> +		tstamp->xsk_pending_ts =3D NULL;
>> +		igc_xsk_wakeup(adapter->netdev, tstamp->xsk_queue_index, 0);
>> +	}
>>  }
>>
>>  /**
>> --
>> 2.34.1
>>
>
>--
>Vinicius

Thanks & Regards
Siang

