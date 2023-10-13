Return-Path: <bpf+bounces-12131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B417C82A3
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 11:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E2E282E6E
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 09:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D489B11C95;
	Fri, 13 Oct 2023 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fzaA3KIN"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C58D107A4;
	Fri, 13 Oct 2023 09:58:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1059D7;
	Fri, 13 Oct 2023 02:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697191087; x=1728727087;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kj7sekA9CBPptOTBUYptix7npHNZEO8bRSHQWelzF/w=;
  b=fzaA3KINcqkYn48YdLw9Mx5xPBnFDNwdXNqurTbTZltlKP9c7dJw1rvs
   Ks/CM1IvKGB+37BJXv+WaZodqB/E/EDwdqBb5UPZ3A0l4oDGMxhXQ8D09
   0Gy2koGTTkrqGtZtLTtzsoCTSQ47yedV9WyZisMo1DskiGyYoEAL8XkB+
   bQBVsd3Hz+Sy2ry4zN3BoKdshlkcWr6SfitV6Rhyww39SUIQOYTyPI256
   aje1W41Hp7OhYJGIjSQFyTVN5PSwqq6qFHpB/sfNiY4hch3BHKoMFVrSs
   BSLYC0IuxQQgPp4G5s5LyJE2/RAeyCfoeoK3zL2D9QWoDSqD44Vpyytic
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="451621696"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="451621696"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 02:58:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="878476120"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="878476120"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 02:58:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 02:58:05 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 02:58:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 02:58:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 02:58:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYy/l+evjYhlFstTDX40KmF1X8qDGCJ9a7Fx6vYgdSFUJLJC2YsSCJquHsKOpd/h+hjwyWxZPSCs+ItRD4VECdr9nZr94ZO9HQkbkOugWrdbjdeCUzsPJ+/1Y+BTaMTXNiKBroGlweSKIrIrvB12+O+MpZuc2vPau1puT9QpUPcuGKuhtal+hjKGXIK00jwnh9agYJPrRsbd0rCdEiNPS1AkepDuauVi7WuBTgxI8NF90ggzdFdJ1iPvD5KkLNMowFxG+mx5VIo3D0Krg3YOFLpwJHKY8ZfLO7THONaQlC5gxDnA+6Nt/EgaRiZHwlaBfpGpTtkxT5rh0vdbweLnPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kj7sekA9CBPptOTBUYptix7npHNZEO8bRSHQWelzF/w=;
 b=lY6m5/zpeZy+VivoO25v+xbQGrSkBpkyeHEHXDBYNod4q/Y0COGPuJKMJNo1yZKGwlPLItqmtSaZze+qrwR8er9Pt2xdw0e2Vol7174SuavG8rQXJ+h/LN8FXG4l36z82iSLGZ2YLYX3xao9RcB98HbeD+J6NbdK/MQiwgUxYpBs3m7mZUlTKgAOWb75n+LqQkIGcbqgjB/tGSlAapMKtx34IqkuqVieQ8k5pr+cYIua/xL76xF7AiN+rDaQ1h/Rt4oLWIiDEqz+AHQkwJu+aDkh1OOKlcWJj4tQkHK1u2z2iXX+qBSJ2a1XWkb1i686IZnHODq+vkCVPX6GBgkYhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5354.namprd11.prod.outlook.com (2603:10b6:408:11b::7)
 by DM4PR11MB7303.namprd11.prod.outlook.com (2603:10b6:8:108::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 09:57:58 +0000
Received: from BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::b847:9728:1c20:4631]) by BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::b847:9728:1c20:4631%5]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 09:57:58 +0000
From: "Arland, ArpanaX" <arpanax.arland@intel.com>
To: "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH net] i40e: sync next_to_clean and
 next_to_process for programming status desc
Thread-Topic: [Intel-wired-lan] [PATCH net] i40e: sync next_to_clean and
 next_to_process for programming status desc
Thread-Index: AQHZ9p2mqPZ2pL9/7EGlxG7DqA7+abBHZ1uA
Date: Fri, 13 Oct 2023 09:57:57 +0000
Message-ID: <BN9PR11MB535411D7CE84B1968F113ED580D2A@BN9PR11MB5354.namprd11.prod.outlook.com>
References: <20231004083454.20143-1-tirthendu.sarkar@intel.com>
In-Reply-To: <20231004083454.20143-1-tirthendu.sarkar@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5354:EE_|DM4PR11MB7303:EE_
x-ms-office365-filtering-correlation-id: 18633cc6-8db0-4e0a-e3de-08dbcbd2e0d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bm0vWswNLpYXoBjruNqjKuHUoZmmXzB56HJ62VPuTR0+ORm/W4dVQDE/2szIr+7TODpWHfebA1O4pntuix2IrPdLCZFZd0Z0ZmGKc4IVRIMvxsoA07gXw+kCjF05TCvX4HO+4sO/t6ohFyTJX2NoTDVbTeL9pWlTGEEjm0voTdZomVRmx9tW5gQUcAMQ9qznbInR+pjXzno/4anIIS1EGos3ai13N7a9pJJsJ0MoCDMk+XaxezqvIcXVPpmYtRVA8WucI2CBEsjOOS9L34V7WXRvS9UjZh3nZ+i9B5xwYVeV253pT70KzV22XYXfsqfo1SAbvn9al4HnyWLYetX451shsrfTim2RXNCBrKseHrvbvg9vE/OnarLJ7QnEEyMBfDmc/Og1bmzk+ZPXqICAurm7evXYImqPQxFVN35yDkqsSDe3IKfbWQ0AE66OBnN62B1qVDz+3slK2bvaiyye6Be6NBFH1W8y5+GOWk+sguk0xiS+DdU0X/Ifwsf01hPyo+bOBM1JW2Tn85OOapm68bh/km1XRjeYDX/8/3AspOVaqoTORtvLKQhI3W1C/P490rucxldUP5rrB2bVmnGQCgEvSmKp9gmJVBCctenSB9FhoNprYKDE9DSG4lPb/hHpwdQa2YwVGujKHbzjcJsgrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5354.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(86362001)(33656002)(55016003)(26005)(66476007)(4326008)(41300700001)(8936002)(66574015)(8676002)(66946007)(66556008)(66446008)(110136005)(64756008)(107886003)(54906003)(76116006)(316002)(2906002)(52536014)(83380400001)(7696005)(6506007)(966005)(53546011)(71200400001)(478600001)(5660300002)(82960400001)(9686003)(122000001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2p3QzFZR3d0QUZXa1hWK1prR2VaT1lCSUY5QlFpak9XcDdBNERQUU16eE8y?=
 =?utf-8?B?TWIzbnlzVFV4cGJFd3VzM1R3aVNITUZIVEN0bXNvMzdmK2hDK0RabmdtQklB?=
 =?utf-8?B?VVptOUM4bmtBcjFnZzhRZjJwemNraHJoRjBGMkNML3hDTUhXeG8zUTYzVGJN?=
 =?utf-8?B?bkV5YnpUTTNFM2N6N29IMTZJR1UyaUx4VHZYWUNZN0cvakt0dzY1bVJCMHBx?=
 =?utf-8?B?cG91TGpNRklFWjB1TGtGWXRhanUrc0ZHTHlzNVVyZHQ4NEJ6SmxNU3JtcjEz?=
 =?utf-8?B?K2lnVnpZSjkzWm80UHVRQ1FrMmZqWi9XMUdLSEsvYmZ5YUVDakdySTRjL0xZ?=
 =?utf-8?B?NXpES1JyMGhQR05QNEhuWVFPY3BRMW5LSmR0UzY4MHlyMUxsajNWREZrSUFG?=
 =?utf-8?B?QlJ5Tmo2aXYrWGZDR1JMMkc3ckp4bGFJZGxuRWY1WENSRWV0eFpXZktoYU53?=
 =?utf-8?B?a3JFdmNac0VNR2RlY2QrREs2OGkyT0Q0SlVDMjFtQ09ST0s2SmFidUxDcUs5?=
 =?utf-8?B?WEREaWhHQTJ5cjlUeDA5K1FJYTBoNGx4S3ZVTllaekF6NUFoL2FYVWdBalMz?=
 =?utf-8?B?dEJoR1BCSTFkQTJHSkRLVllsY0dWZUFBZHVxYWxManBCVlpyZVA0ZXgxNTNL?=
 =?utf-8?B?WkJSRklrNzNHVWo1K0VtL1NuVlltNGd1RUR1aDdzRFJUaS90czRYY3llUWIv?=
 =?utf-8?B?MVFIa2ZBRTF0Yklwa1RzYTRobEdDY1IwUFZzQkNzSkVPQVdrRlVBNVFhS21k?=
 =?utf-8?B?YlZuSDJzWGhqTGg4UWxkMGRkS0sva0FNZW1NU1o1a0FOR1hibERRQ3lqc0xQ?=
 =?utf-8?B?TXhDN2U0cTRYSGNoN2ZCeWRkck92eVVRbHF3QTFVdHVGMEdDZXBlekhqWEZZ?=
 =?utf-8?B?QWdWR1pVZXB3dUFySmtRM0orT3BZRXBoSHlMTEJoazlYTE55Q1dFZjgybUZk?=
 =?utf-8?B?aldhWHh6ODRwUndFaTZ4Zy9oQXpzQmIyUkZnS2VJVWdEUVJPc1U2NVluWjI0?=
 =?utf-8?B?ZVBVbk1aMEVacDRVblRBSmJRYW9KN1gyQ3NHMGZvRWwycXZSOFUrY3FXcGJo?=
 =?utf-8?B?dk1uRk1ZeWNkc2dERlhkV211YUJOaXFUZk82aGRrb2RPUGVObi9XQVczcS9B?=
 =?utf-8?B?Z2g2NkhwQjZ6d3k1MmdFTTJFSWxneVV4VVRkOXZ3QVl0MGd0ZFhEa2ZNd0px?=
 =?utf-8?B?M2VwQXA0c1dyTjgrZHJnQWF4SmhnbVcvd1RXdDBlbkU4UDJmMGZQU0F0eHUx?=
 =?utf-8?B?ZmNISWNVSlVtYjQ0dzZGTkttcjgySFFic0FIQ1o5MUF0Z0dMRHpqOThVcEVy?=
 =?utf-8?B?QXJKVHU3Y3RVN0wybWxDbDJDQXlHUE1Ba20yVS81Mi9NSWpGNFluVFFybzVV?=
 =?utf-8?B?ekFtaVUxMzZYWDRXL1NTQWxCaWFjUWRjNy90VmM3UlJkV0J4WTk4c3RyeVph?=
 =?utf-8?B?MUlEcGE0dTBIMnd1T1VwTjFqZTl4ZjdpZFVqQk52S2d4T1hVcVRQaEV4N3dZ?=
 =?utf-8?B?Y3FFSkhPaWFjRW9zUTRuQlV2ZC8yNElFdUFEM085NmRtd0RYdUhDQTlJcE9N?=
 =?utf-8?B?TC9SZTYwYm5jY1hrazFrTDNMMklkN2MyN0QrajJNbjRpK0hGM1ZLcGVxRWp0?=
 =?utf-8?B?VCtHamZkRnhnZ0RHUUhjVWNuVjRqdkJ6NlN0eXh3STNaOHc2Qzc1a3lBRTNB?=
 =?utf-8?B?VGZ1NzAvZnBnYW44WSt0WEIwUTVndEpyWU5OUWdmdUxMVm0yZS9NM2tYYy80?=
 =?utf-8?B?cE9lMTlJNE9pWkc1bnViOGVhWW1RaldCZ1pEdnpjdWJEWWduNElqUjk5ekJa?=
 =?utf-8?B?OTk0aUgvNi9jL1JuVm11NVlkbkxQVTZHN2drbXVWWkQ1cjl3MVp2T3Roem5I?=
 =?utf-8?B?NkZFYjhnQXBnYVJXblo5Tk90ZEIxdW5ZVDgvZGRHK2NWVTVpc2xobWQ5V0hx?=
 =?utf-8?B?MlE4OG90K2Z1RWZXZUZPSTQrdTJPR043dEVZMC9WU3hwekt2eFFaV0FYVzJJ?=
 =?utf-8?B?RGZCYzIwblRyRVFQajhzRWptam00RWlheGF1OHJKQm5OanIydW9JSzF3U0Mz?=
 =?utf-8?B?MEpkL1VncW5Pblp6SUhtUENaVXhlZWRnSVJnZldLRG43aTUyMTh6a3dnNCtn?=
 =?utf-8?Q?Zg0UvjULVlbBimKzgo27vT89L?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5354.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18633cc6-8db0-4e0a-e3de-08dbcbd2e0d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 09:57:57.8426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F4go4Pqn7vU0iUVAIV/AaGWxJmbDyAzzLIGFpm2kBdqLXJ+KGhmdNrX9yERWxF0EXj+TsYfZx1U5d1TUH1YKrWymlgk8x55lwyChKXELAv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7303
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBUaXJ0aGVuZHUg
U2Fya2FyDQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciA0LCAyMDIzIDI6MDUgUE0NCj4gVG86
IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+IENjOiBGaWphbGtvd3NraSwgTWFj
aWVqIDxtYWNpZWouZmlqYWxrb3dza2lAaW50ZWwuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9y
ZzsgQnJhbmRlYnVyZywgSmVzc2UgPGplc3NlLmJyYW5kZWJ1cmdAaW50ZWwuY29tPjsgTmd1eWVu
LCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgYnBmQHZnZXIua2VybmVs
Lm9yZzsgS2FybHNzb24sIE1hZ251cyA8bWFnbnVzLmthcmxzc29uQGludGVsLmNvbT4NCj4gU3Vi
amVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIG5ldF0gaTQwZTogc3luYyBuZXh0X3RvX2Ns
ZWFuIGFuZCBuZXh0X3RvX3Byb2Nlc3MgZm9yIHByb2dyYW1taW5nIHN0YXR1cyBkZXNjDQo+DQo+
IFdoZW4gYSBwcm9ncmFtbWluZyBzdGF0dXMgZGVzYyBpcyBlbmNvdW50ZXJlZCBvbiB0aGUgcnhf
cmluZywgbmV4dF90b19wcm9jZXNzIGlzIGJ1bXBlZCBhbG9uZyB3aXRoIGNsZWFuZWRfY291bnQg
YnV0IG5leHRfdG9fY2xlYW4gaXMgbm90LiBUaGlzIGNhdXNlcyBJNDBFX0RFU0NfVU5VU0VEKCkg
bWFjcm8gdG8gbWlzYmVoYXZlIHJlc3VsdGluZyBpbiBvdmVyd3JpdGluZyB3aG9sZSByaW5nIHdp
dGggbmV3IGJ1ZmZlcnMuDQo+DQo+IFVwZGF0ZSBuZXh0X3RvX2NsZWFuIHRvIHBvaW50IHRvIG5l
eHRfdG9fcHJvY2VzcyBvbiBzZWVpbmcgYSBwcm9ncmFtbWluZyBzdGF0dXMgZGVzYyBpZiBub3Qg
aW4gdGhlIG1pZGRsZSBvZiBoYW5kbGluZyBhIG11bHRpLWZyYWcgcGFja2V0LiBBbHNvLCBidW1w
IGNsZWFuZWRfY291bnQgb25seSBmb3Igc3VjaCBjYXNlIGFzIG90aGVyd2lzZSBuZXh0X3RvX2Ns
ZWFuIGJ1ZmZlciBtYXkgYmUgcmV0dXJuZWQgdG8gaGFyZHdhcmUgb24gcmVhY2hpbmcgY2xlYW5f
dGhyZXNob2xkLg0KPg0KPiBGaXhlczogZTkwMzFmMmRhMWFlICgiaTQwZTogaW50cm9kdWNlIG5l
eHRfdG9fcHJvY2VzcyB0byBpNDBlX3JpbmciKQ0KPiBTdWdnZXN0ZWQtYnk6IE1hY2llaiBGaWph
bGtvd3NraSA8bWFjaWVqLmZpamFsa293c2tpQGludGVsLmNvbT4NCj4gUmVwb3J0ZWQtYnk6IGhx
LmRlditrZXJuZWxAbXNkZmMueHl6DQo+IFJlcG9ydGVkIGJ5OiBTb2xvbW9uIFBlYWNoeSA8cGl6
emFAc2hhZnRuZXQub3JnPg0KPiBDbG9zZXM6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9z
aG93X2J1Zy5jZ2k/aWQ9MjE3Njc4DQo+IFRlc3RlZC1ieTogaHEuZGV2K2tlcm5lbEBtc2RmYy54
eXoNCj4gVGVzdGVkIGJ5OiBJbmRyZWsgSsOkcnZlIDxpbmN4QGR1c3RiaXRlLm5ldD4NCj4gU2ln
bmVkLW9mZi1ieTogVGlydGhlbmR1IFNhcmthciA8dGlydGhlbmR1LnNhcmthckBpbnRlbC5jb20+
DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX3R4cnguYyB8
IDkgKysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+DQoNClRlc3RlZC1ieTogQXJwYW5hIEFybGFuZCA8YXJwYW5heC5hcmxhbmRAaW50
ZWwuY29tPiAoQSBDb250aW5nZW50IHdvcmtlciBhdCBJbnRlbCkNCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkludGVsLXdpcmVkLWxhbiBtYWlsaW5nIGxp
c3QNCkludGVsLXdpcmVkLWxhbkBvc3Vvc2wub3JnDQpodHRwczovL2xpc3RzLm9zdW9zbC5vcmcv
bWFpbG1hbi9saXN0aW5mby9pbnRlbC13aXJlZC1sYW4NCg==

