Return-Path: <bpf+bounces-12833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C827D1199
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 16:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060ED1C20FF4
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 14:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA52E1DA2D;
	Fri, 20 Oct 2023 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bQDcI0VI"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5121D6B8;
	Fri, 20 Oct 2023 14:30:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A0A19E;
	Fri, 20 Oct 2023 07:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697812199; x=1729348199;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tmWG5+i75xThO9WwXdBmEHwEL6wu11lkCMDpD6b8n8g=;
  b=bQDcI0VItNPkT9zehHTJhpoDZujZxtit+QT+3PUsdqpjeIS8crebK0ev
   oRIq2HJneCXMqx1e4AmAxtozr4/0oz7K79zbhM0qRi3BXN7dRuimQPJYx
   CwvjkIIQHMx9KrcoEeIErC3f1vP9JMy5fc2OHeQDKwDWbwBUuv13HbYev
   WqX0KHaKy7wAwiEI5KUqoJOcJ1tMr1toUFCfU3rfQxyNjjNfoKsiz6sv2
   17tITBPpR9XNxKqs0A4FQUN3MJ6HSlhsC7Na7T14LFYFCmX5fTpaiFQZa
   DIXBLyr6odW7Lm+5ftjz6WLMQEfSJ5xz+4dwY1sOK66csja6x2PO5UuzX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="386317065"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="386317065"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 07:29:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="873923075"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="873923075"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 07:29:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 07:29:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 07:29:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 07:29:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDRJRfzYAaghsC0g3Ri0gNd3R0cpwx36OLgrHUSB5aLqBSGVvKqNOBX9R6HkRcGwQED2BekNNewT1hZxCxvWU350Uk4pM1oDp5yVP6Via1dXZWmwkvzo7IfhLMdvqTBDF9QMf/MWl016bbSFCRN2rrVv655xqw37j6yYW5ufEp7G5PG77DUeH2JxrcRRlOwXA0HUxUU4Qr2Ehlm3aeD3HiMdC1i+sTdXIuwyTz4TwqQdp8rErYFXhty7P4ARIQlZyiPtKmcv8v1ollaVj/7w+PgMkFYnXEgP6/73F9W90e4MX9MDDx/ZAc105HaeCwot0WQLeYy4LIdtZHRXs5sJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmWG5+i75xThO9WwXdBmEHwEL6wu11lkCMDpD6b8n8g=;
 b=a9tet8igxaks+64Cf4LsYo7tlnSWIuaMg2uqThdM5o6ifCPMCYhCHSiIvJWzec4P0OsUIqsCy1IjKOFxVyJwWjOHZm1EVV4DrR9nX5eeIbGhBS4FWRtw2J17cWkuJjc2EWAa2dHeUcLO07T0qiTT2uSplS0Uk2hwaLC7M1TZucjnP98scNeUTTgGavkKD1N8xAbP4cYQPuaAXbrrPQouBMmyteTmlIeFTyTUcYXN12/vf9QBmwzCUGICioDkT9UlN8DxCf2GB+StmvM9CLraUmBgLEouKeMtMmukl0TdPOs/bws6qdnfwuOW746qJ/v6fNZHybAFLKug7r2dd70tQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 14:29:55 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c17:89e4:bb3d:d825]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c17:89e4:bb3d:d825%5]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 14:29:55 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Stanislav Fomichev <sdf@google.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
CC: "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "song@kernel.org"
	<song@kernel.org>, "yhs@fb.com" <yhs@fb.com>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
	"haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, "toke@kernel.org"
	<toke@kernel.org>, "willemb@google.com" <willemb@google.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "bjorn@kernel.org" <bjorn@kernel.org>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "hawk@kernel.org"
	<hawk@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>
Subject: RE: [PATCH bpf-next v4 01/11] xsk: Support tx_metadata_len
Thread-Topic: [PATCH bpf-next v4 01/11] xsk: Support tx_metadata_len
Thread-Index: AQHaArS21PETzj7svEutHtAxjVR5+LBSvcCQ
Date: Fri, 20 Oct 2023 14:29:55 +0000
Message-ID: <PH0PR11MB58308320DB2CEC982E55BF20D8DBA@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20231019174944.3376335-1-sdf@google.com>
 <20231019174944.3376335-2-sdf@google.com>
In-Reply-To: <20231019174944.3376335-2-sdf@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|SA1PR11MB6733:EE_
x-ms-office365-filtering-correlation-id: d18787d9-c035-46c4-3c3a-08dbd17907a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ui65zoCSwZ4g8yfwAc9UKgmbHZMp0cBU8/KJSikEBM0XCzSPZT5de+Wtdpjg7Sq4yFmmvrWqkyuCwSBTESXcTnYdYxVtiZmGt90o141qkxs6yLnRxwh4H7tVivNhVSbYfKwngpwSA1gvtLlnVfDtPLNc6Q/DzGzescf3fx+9Tu3VX0ixYdGKoRvVbddsoGWVAccpagH5DbahfGzXD754YjQ11TuhEIVjmMVAKgLaCHy6KBsSEJnjYhEU5W3H9tL4lHdHcQi3az1TvmU8WanHbLikHFDmHJn41r0mBegxr6A6E7GixzFZijpxyohLs36Jsm+CVuseUr3Q9A1nS5nvR/kJ7vYPH0ymjhU+BMr2hTpIOPXgkjR1lkdVH1ecoRsCVr4bfUDb0BrslLDx/z878NP6GKxBTsdZHI035vc2t0KhalnG5udHR3B/BdvHJ1n03pyQ25niCbbworVUoEgi/cSz0yL7urPCZItiONcKxzIxacMx8ccGwQxoPG1IWJs1TocY0CgiJoUA5TmReV/47qBV5p3X22ttK/UCdqAfNquK2suXgC6oypXOW+2OvEqXATNtr3hQ/xbHTU0f1Jd0vksNSkQtwuWLPw2L/zGe8ccF1gfmGJlzyEV/xeMT8xE3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(136003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(83380400001)(53546011)(26005)(9686003)(6506007)(7696005)(71200400001)(38070700009)(33656002)(86362001)(122000001)(82960400001)(38100700002)(41300700001)(4326008)(8936002)(8676002)(52536014)(478600001)(5660300002)(2906002)(7416002)(66946007)(64756008)(66556008)(54906003)(66476007)(66446008)(76116006)(110136005)(55016003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjZyeHdJcDhsbmt2bkZFcHAzU0hkaEtLbXJNUUdZWDFXK3h4Vkk0OXNwaS93?=
 =?utf-8?B?QUQ5bHJTK0k4czhpeFJvWW9VaW8vQmduRHdKRTFLQVl5aWRyQmRsWWpPMVU1?=
 =?utf-8?B?M2ZZbFZqNE5ONVViT3hNQjdvb3lzd3BTWGNDQjRTRFUyWnpXRVF2YXA2ekp5?=
 =?utf-8?B?QWY4K3lvaW9vQi9vVE1EYXQvWWJETTE5YWs3SUFEOVlHeGRNV2NoVGpQaWJJ?=
 =?utf-8?B?OGpsMnlhREFEakJmTG1FWVBBam1NM05Gd2w3dm9sbERSdnRvWVdOWmlZcHZU?=
 =?utf-8?B?aDJVenVYT1ZnMEhwaTMxY0RaTzlFQWoyTXhsQ3JjYVFCL0VybTJ2THVSeU00?=
 =?utf-8?B?bGIzSXlzdVFucGE5Z2pPT2h2ajRzeUhtS0Z5SXB0K3Bra1Z4SFlDMFJueERi?=
 =?utf-8?B?WkJxWmI5ZTFEeDRVVDJReFVlRWFhVFIrWkJuRmw0cG1zb29SKzM4dytaZkRN?=
 =?utf-8?B?d1BWRXAraVNSNHpwRXBmOFB5NE03VzhnZFdIUEx3djZyL0ZHQVRtY3gzb3U1?=
 =?utf-8?B?V0lTdnEyRXMzVjk2d2haSGliMTdyY1d6S2dUdjBnRkRXZnM3NFZSaDErWVVm?=
 =?utf-8?B?SFUxZU5PMFBybkVJOGVTMnErelRKdkEyVjN4WjcvQjhKWjZ1SGdXMlF2dFJt?=
 =?utf-8?B?VXRZVWFNYXIwN2dOd29rZWtwWWF4OERLY0gyNk5COUZmVEtHZDhUZUpuVnBw?=
 =?utf-8?B?RmN3UkZlMjlIU29EbGY0ODFiVUhGZDFrbDZCemt6TnNoUzlRTkEyWWpxU1Rn?=
 =?utf-8?B?WEFYZTJ3cHhHZEhYcGZvWmVack9qUDhlOG9IblNNeFk0T3NwMjV2bkdaVUMy?=
 =?utf-8?B?S2xhcG8yMUZ2VWNUUENvOE1RWW9oOEdBd3BtMVM1MHU1dmhKTWU1dnZsTnpw?=
 =?utf-8?B?dWFmRzdseGU4a0UrUUx5d0VGem1yS2dUZXNoRDRpSEhJSG9iZmpTMml3SFFy?=
 =?utf-8?B?MnlGNFFYYjdRYU1VblFFVVJjK0VaWE55REFveG5keDBNYnN2WWpTRDdISXBt?=
 =?utf-8?B?N0hBYkFDdWVUZmZaZmRoeEcxN3NuM3BPVXJTaHppRjVxaFpkdjhSYjFkaWQ5?=
 =?utf-8?B?WkNzVlcvdmFYZU9HNnNoWkhaZmZpWlhIOUZ5OVpXTHhMVlZEdmxodktueXcx?=
 =?utf-8?B?QlAvdm4rZVd6empvQi9WbDlONGx4eHBrenJXUXZUUzE3WVFmcy9CcWRIQVFy?=
 =?utf-8?B?MmwxYmN5UnFPby9PSkp2QnNjOGdxT1ZPRnl3djJTZzRLZ0VpVkRja2Nkdk0r?=
 =?utf-8?B?T3VVejNvQkk3bHYwaEdxYTlHbExRcjB2NC9SM3ZZZy9SelNGcU5yRmtYL3pG?=
 =?utf-8?B?aGRWMnJUT2g5ZXhOZjZsSTdFQjlkVTUrZ0E3VFFGUktCRVk4bjdhcWdZNXZG?=
 =?utf-8?B?b3pMbUxVc1NTM3NsZkMwcGZsc1lBRjU0RUJFWkV3bUo5eXhMdjJjYXRUL2Ju?=
 =?utf-8?B?QllOV2NNNXkvWjVJUlZDbERpdUpRdy9KbVlHUitlVUNmTW4rbm83QXBaazl0?=
 =?utf-8?B?b3c2bXlVQTRubXBoa05XMW5NODhNdDd4YkZmb2VXZkVGN0tsU0k1OUhMQ1Za?=
 =?utf-8?B?WE4wWHJSbnlMK2Q1aGVJMUpMekxudlV4dVl3VFU0allKRVI0dThZaVEzbkNE?=
 =?utf-8?B?M0g3ejFFTHh3MnFVQ3NDQzl4US9LQ3ZIaS9VZ2IzdVN1ZWVYMFdhNlRXOVJN?=
 =?utf-8?B?UkI0STMwMXVVMjAwckZuYkJKdlRiMFNqaG9YOXZuUjVwa1FrNkJmOVZmcElo?=
 =?utf-8?B?cEwyZ3ExRjJXZ3dUREg0VmIxYW5rQUVTN0UyZDdPZWE5YmQ5UTZiejNSdmpz?=
 =?utf-8?B?TnNvdGdTWDl3S0dSQVhLM0w1cFpBM2VhdDdGZEEzK3ZCS2Y1aDJzdHVPaEUz?=
 =?utf-8?B?QmNTV0QyS1FVQlE0My8rSndidTkrdlFsNDZvOW5kdDdLSzNrcldTcVI4aWdv?=
 =?utf-8?B?U01qRWhwejFyNlpWa0NBM21paE44VmphQ0FhQnNpSGFXTmpjc1dDdEMwRUdW?=
 =?utf-8?B?b1ljNzFnbVpVR3JwaVIzMzNkM1FNbGdQYjh5UWZxNkNTVjJkN1hpQTBZUEVo?=
 =?utf-8?B?MTRhRU8xZ1lGSGtqUmxpZmZlK1V2aCt6c1R0M2toMmlyN2xRMFJIdlE3MUV4?=
 =?utf-8?B?RytPTkNScnpHNEVMeEVwVkFJNEdvNVVTdmFtQmszbnY0SGdKT2Q3bk41WjZo?=
 =?utf-8?B?aXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d18787d9-c035-46c4-3c3a-08dbd17907a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 14:29:55.2235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: puQvNMFNFyGJbDRCawrzRZB8b/PDbL0y5DreIxjfuqtt9xhoRcW5Di+jnEXIJE+/5gxBJYAet3D+LQyNBCwkDSU76lxEayhXgRkTSd+nXHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6733
X-OriginatorOrg: intel.com

T24gRnJpZGF5LCBPY3RvYmVyIDIwLCAyMDIzIDE6NTAgQU0gU3RhbmlzbGF2IEZvbWljaGV2IDxz
ZGZAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+Rm9yIHplcm9jb3B5IG1vZGUsIHR4X2Rlc2MtPmFkZHIg
Y2FuIHBvaW50IHRvIHRoZSBhcmJpdHJhcnkgb2Zmc2V0DQo+YW5kIGNhcnJ5IHNvbWUgVFggbWV0
YWRhdGEgaW4gdGhlIGhlYWRyb29tLiBGb3IgY29weSBtb2RlLCB0aGVyZQ0KPmlzIG5vIHdheSBj
dXJyZW50bHkgdG8gcG9wdWxhdGUgc2tiIG1ldGFkYXRhLg0KPg0KPkludHJvZHVjZSBuZXcgdHhf
bWV0YWRhdGFfbGVuIHVtZW0gY29uZmlnIG9wdGlvbiB0aGF0IGluZGljYXRlcyBob3cgbWFueQ0K
PmJ5dGVzIHRvIHRyZWF0IGFzIG1ldGFkYXRhLiBNZXRhZGF0YSBieXRlcyBjb21lIHByaW9yIHRv
IHR4X2Rlc2MgYWRkcmVzcw0KPihzYW1lIGFzIGluIFJYIGNhc2UpLg0KPg0KPlRoZSBzaXplIG9m
IHRoZSBtZXRhZGF0YSBoYXMgdGhlIHNhbWUgY29uc3RyYWludHMgYXMgWERQOg0KPi0gbGVzcyB0
aGFuIDI1NiBieXRlcw0KPi0gNC1ieXRlIGFsaWduZWQNCj4tIG5vbi16ZXJvDQo+DQo+VGhpcyBk
YXRhIGlzIG5vdCBpbnRlcnByZXRlZCBpbiBhbnkgd2F5IHJpZ2h0IG5vdy4NCj4NCj5TaWduZWQt
b2ZmLWJ5OiBTdGFuaXNsYXYgRm9taWNoZXYgPHNkZkBnb29nbGUuY29tPg0KDQpMR1RNLg0KUmV2
aWV3ZWQtYnk6IFNvbmcgWW9vbmcgU2lhbmcgPHlvb25nLnNpYW5nLnNvbmdAaW50ZWwuY29tPg0K
DQo+LS0tDQo+IGluY2x1ZGUvbmV0L3hkcF9zb2NrLmggICAgICAgICAgICB8ICAxICsNCj4gaW5j
bHVkZS9uZXQveHNrX2J1ZmZfcG9vbC5oICAgICAgIHwgIDEgKw0KPiBpbmNsdWRlL3VhcGkvbGlu
dXgvaWZfeGRwLmggICAgICAgfCAgMSArDQo+IG5ldC94ZHAveGRwX3VtZW0uYyAgICAgICAgICAg
ICAgICB8ICA0ICsrKysNCj4gbmV0L3hkcC94c2suYyAgICAgICAgICAgICAgICAgICAgIHwgMTIg
KysrKysrKysrKystDQo+IG5ldC94ZHAveHNrX2J1ZmZfcG9vbC5jICAgICAgICAgICB8ICAxICsN
Cj4gbmV0L3hkcC94c2tfcXVldWUuaCAgICAgICAgICAgICAgIHwgMTcgKysrKysrKysrKy0tLS0t
LS0NCj4gdG9vbHMvaW5jbHVkZS91YXBpL2xpbnV4L2lmX3hkcC5oIHwgIDEgKw0KPiA4IGZpbGVz
IGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+DQo+ZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbmV0L3hkcF9zb2NrLmggYi9pbmNsdWRlL25ldC94ZHBfc29jay5oDQo+aW5k
ZXggN2RkMGRmMmY2ZjhlLi41YWU4OGEwMGYzNGEgMTAwNjQ0DQo+LS0tIGEvaW5jbHVkZS9uZXQv
eGRwX3NvY2suaA0KPisrKyBiL2luY2x1ZGUvbmV0L3hkcF9zb2NrLmgNCj5AQCAtMzAsNiArMzAs
NyBAQCBzdHJ1Y3QgeGRwX3VtZW0gew0KPiAJc3RydWN0IHVzZXJfc3RydWN0ICp1c2VyOw0KPiAJ
cmVmY291bnRfdCB1c2VyczsNCj4gCXU4IGZsYWdzOw0KPisJdTggdHhfbWV0YWRhdGFfbGVuOw0K
PiAJYm9vbCB6YzsNCj4gCXN0cnVjdCBwYWdlICoqcGdzOw0KPiAJaW50IGlkOw0KPmRpZmYgLS1n
aXQgYS9pbmNsdWRlL25ldC94c2tfYnVmZl9wb29sLmggYi9pbmNsdWRlL25ldC94c2tfYnVmZl9w
b29sLmgNCj5pbmRleCBiMGJkZmYyNmZjODguLjE5ODVmZmFmOWIwYyAxMDA2NDQNCj4tLS0gYS9p
bmNsdWRlL25ldC94c2tfYnVmZl9wb29sLmgNCj4rKysgYi9pbmNsdWRlL25ldC94c2tfYnVmZl9w
b29sLmgNCj5AQCAtNzcsNiArNzcsNyBAQCBzdHJ1Y3QgeHNrX2J1ZmZfcG9vbCB7DQo+IAl1MzIg
Y2h1bmtfc2l6ZTsNCj4gCXUzMiBjaHVua19zaGlmdDsNCj4gCXUzMiBmcmFtZV9sZW47DQo+Kwl1
OCB0eF9tZXRhZGF0YV9sZW47IC8qIGluaGVyaXRlZCBmcm9tIHVtZW0gKi8NCj4gCXU4IGNhY2hl
ZF9uZWVkX3dha2V1cDsNCj4gCWJvb2wgdXNlc19uZWVkX3dha2V1cDsNCj4gCWJvb2wgZG1hX25l
ZWRfc3luYzsNCj5kaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L2lmX3hkcC5oIGIvaW5j
bHVkZS91YXBpL2xpbnV4L2lmX3hkcC5oDQo+aW5kZXggOGQ0ODg2MzQ3MmI5Li4yZWNmNzkyODJj
MjYgMTAwNjQ0DQo+LS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2lmX3hkcC5oDQo+KysrIGIvaW5j
bHVkZS91YXBpL2xpbnV4L2lmX3hkcC5oDQo+QEAgLTc2LDYgKzc2LDcgQEAgc3RydWN0IHhkcF91
bWVtX3JlZyB7DQo+IAlfX3UzMiBjaHVua19zaXplOw0KPiAJX191MzIgaGVhZHJvb207DQo+IAlf
X3UzMiBmbGFnczsNCj4rCV9fdTMyIHR4X21ldGFkYXRhX2xlbjsNCj4gfTsNCj4NCj4gc3RydWN0
IHhkcF9zdGF0aXN0aWNzIHsNCj5kaWZmIC0tZ2l0IGEvbmV0L3hkcC94ZHBfdW1lbS5jIGIvbmV0
L3hkcC94ZHBfdW1lbS5jDQo+aW5kZXggMDZjZWFkMmI4ZTM0Li4zMzNmM2Q1M2FhZDQgMTAwNjQ0
DQo+LS0tIGEvbmV0L3hkcC94ZHBfdW1lbS5jDQo+KysrIGIvbmV0L3hkcC94ZHBfdW1lbS5jDQo+
QEAgLTE5OSw2ICsxOTksOSBAQCBzdGF0aWMgaW50IHhkcF91bWVtX3JlZyhzdHJ1Y3QgeGRwX3Vt
ZW0gKnVtZW0sIHN0cnVjdA0KPnhkcF91bWVtX3JlZyAqbXIpDQo+IAlpZiAoaGVhZHJvb20gPj0g
Y2h1bmtfc2l6ZSAtIFhEUF9QQUNLRVRfSEVBRFJPT00pDQo+IAkJcmV0dXJuIC1FSU5WQUw7DQo+
DQo+KwlpZiAobXItPnR4X21ldGFkYXRhX2xlbiA+IDI1NiB8fCBtci0+dHhfbWV0YWRhdGFfbGVu
ICUgNCkNCj4rCQlyZXR1cm4gLUVJTlZBTDsNCj4rDQo+IAl1bWVtLT5zaXplID0gc2l6ZTsNCj4g
CXVtZW0tPmhlYWRyb29tID0gaGVhZHJvb207DQo+IAl1bWVtLT5jaHVua19zaXplID0gY2h1bmtf
c2l6ZTsNCj5AQCAtMjA3LDYgKzIxMCw3IEBAIHN0YXRpYyBpbnQgeGRwX3VtZW1fcmVnKHN0cnVj
dCB4ZHBfdW1lbSAqdW1lbSwgc3RydWN0DQo+eGRwX3VtZW1fcmVnICptcikNCj4gCXVtZW0tPnBn
cyA9IE5VTEw7DQo+IAl1bWVtLT51c2VyID0gTlVMTDsNCj4gCXVtZW0tPmZsYWdzID0gbXItPmZs
YWdzOw0KPisJdW1lbS0+dHhfbWV0YWRhdGFfbGVuID0gbXItPnR4X21ldGFkYXRhX2xlbjsNCj4N
Cj4gCUlOSVRfTElTVF9IRUFEKCZ1bWVtLT54c2tfZG1hX2xpc3QpOw0KPiAJcmVmY291bnRfc2V0
KCZ1bWVtLT51c2VycywgMSk7DQo+ZGlmZiAtLWdpdCBhL25ldC94ZHAveHNrLmMgYi9uZXQveGRw
L3hzay5jDQo+aW5kZXggYmEwNzBmZDM3ZDI0Li5iYTRjNzdhMjRhODMgMTAwNjQ0DQo+LS0tIGEv
bmV0L3hkcC94c2suYw0KPisrKyBiL25ldC94ZHAveHNrLmMNCj5AQCAtMTI2NSw2ICsxMjY1LDE0
IEBAIHN0cnVjdCB4ZHBfdW1lbV9yZWdfdjEgew0KPiAJX191MzIgaGVhZHJvb207DQo+IH07DQo+
DQo+K3N0cnVjdCB4ZHBfdW1lbV9yZWdfdjIgew0KPisJX191NjQgYWRkcjsgLyogU3RhcnQgb2Yg
cGFja2V0IGRhdGEgYXJlYSAqLw0KPisJX191NjQgbGVuOyAvKiBMZW5ndGggb2YgcGFja2V0IGRh
dGEgYXJlYSAqLw0KPisJX191MzIgY2h1bmtfc2l6ZTsNCj4rCV9fdTMyIGhlYWRyb29tOw0KPisJ
X191MzIgZmxhZ3M7DQo+K307DQo+Kw0KPiBzdGF0aWMgaW50IHhza19zZXRzb2Nrb3B0KHN0cnVj
dCBzb2NrZXQgKnNvY2ssIGludCBsZXZlbCwgaW50IG9wdG5hbWUsDQo+IAkJCSAgc29ja3B0cl90
IG9wdHZhbCwgdW5zaWduZWQgaW50IG9wdGxlbikNCj4gew0KPkBAIC0xMzA4LDggKzEzMTYsMTAg
QEAgc3RhdGljIGludCB4c2tfc2V0c29ja29wdChzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBpbnQgbGV2
ZWwsIGludA0KPm9wdG5hbWUsDQo+DQo+IAkJaWYgKG9wdGxlbiA8IHNpemVvZihzdHJ1Y3QgeGRw
X3VtZW1fcmVnX3YxKSkNCj4gCQkJcmV0dXJuIC1FSU5WQUw7DQo+LQkJZWxzZSBpZiAob3B0bGVu
IDwgc2l6ZW9mKG1yKSkNCj4rCQllbHNlIGlmIChvcHRsZW4gPCBzaXplb2Yoc3RydWN0IHhkcF91
bWVtX3JlZ192MikpDQo+IAkJCW1yX3NpemUgPSBzaXplb2Yoc3RydWN0IHhkcF91bWVtX3JlZ192
MSk7DQo+KwkJZWxzZSBpZiAob3B0bGVuIDwgc2l6ZW9mKG1yKSkNCj4rCQkJbXJfc2l6ZSA9IHNp
emVvZihzdHJ1Y3QgeGRwX3VtZW1fcmVnX3YyKTsNCj4NCj4gCQlpZiAoY29weV9mcm9tX3NvY2tw
dHIoJm1yLCBvcHR2YWwsIG1yX3NpemUpKQ0KPiAJCQlyZXR1cm4gLUVGQVVMVDsNCj5kaWZmIC0t
Z2l0IGEvbmV0L3hkcC94c2tfYnVmZl9wb29sLmMgYi9uZXQveGRwL3hza19idWZmX3Bvb2wuYw0K
PmluZGV4IDQ5Y2I5ZjlhMDliZS4uMzg2ZWRkY2RmODM3IDEwMDY0NA0KPi0tLSBhL25ldC94ZHAv
eHNrX2J1ZmZfcG9vbC5jDQo+KysrIGIvbmV0L3hkcC94c2tfYnVmZl9wb29sLmMNCj5AQCAtODUs
NiArODUsNyBAQCBzdHJ1Y3QgeHNrX2J1ZmZfcG9vbCAqeHBfY3JlYXRlX2FuZF9hc3NpZ25fdW1l
bShzdHJ1Y3QNCj54ZHBfc29jayAqeHMsDQo+IAkJWERQX1BBQ0tFVF9IRUFEUk9PTTsNCj4gCXBv
b2wtPnVtZW0gPSB1bWVtOw0KPiAJcG9vbC0+YWRkcnMgPSB1bWVtLT5hZGRyczsNCj4rCXBvb2wt
PnR4X21ldGFkYXRhX2xlbiA9IHVtZW0tPnR4X21ldGFkYXRhX2xlbjsNCj4gCUlOSVRfTElTVF9I
RUFEKCZwb29sLT5mcmVlX2xpc3QpOw0KPiAJSU5JVF9MSVNUX0hFQUQoJnBvb2wtPnhza2JfbGlz
dCk7DQo+IAlJTklUX0xJU1RfSEVBRCgmcG9vbC0+eHNrX3R4X2xpc3QpOw0KPmRpZmYgLS1naXQg
YS9uZXQveGRwL3hza19xdWV1ZS5oIGIvbmV0L3hkcC94c2tfcXVldWUuaA0KPmluZGV4IDEzMzU0
YTFlNDI4MC4uYzc0YTEzNzJiY2I5IDEwMDY0NA0KPi0tLSBhL25ldC94ZHAveHNrX3F1ZXVlLmgN
Cj4rKysgYi9uZXQveGRwL3hza19xdWV1ZS5oDQo+QEAgLTE0MywxNSArMTQzLDE3IEBAIHN0YXRp
YyBpbmxpbmUgYm9vbCB4cF91bnVzZWRfb3B0aW9uc19zZXQodTMyIG9wdGlvbnMpDQo+IHN0YXRp
YyBpbmxpbmUgYm9vbCB4cF9hbGlnbmVkX3ZhbGlkYXRlX2Rlc2Moc3RydWN0IHhza19idWZmX3Bv
b2wgKnBvb2wsDQo+IAkJCQkJICAgIHN0cnVjdCB4ZHBfZGVzYyAqZGVzYykNCj4gew0KPi0JdTY0
IG9mZnNldCA9IGRlc2MtPmFkZHIgJiAocG9vbC0+Y2h1bmtfc2l6ZSAtIDEpOw0KPisJdTY0IGFk
ZHIgPSBkZXNjLT5hZGRyIC0gcG9vbC0+dHhfbWV0YWRhdGFfbGVuOw0KPisJdTY0IGxlbiA9IGRl
c2MtPmxlbiArIHBvb2wtPnR4X21ldGFkYXRhX2xlbjsNCj4rCXU2NCBvZmZzZXQgPSBhZGRyICYg
KHBvb2wtPmNodW5rX3NpemUgLSAxKTsNCj4NCj4gCWlmICghZGVzYy0+bGVuKQ0KPiAJCXJldHVy
biBmYWxzZTsNCj4NCj4tCWlmIChvZmZzZXQgKyBkZXNjLT5sZW4gPiBwb29sLT5jaHVua19zaXpl
KQ0KPisJaWYgKG9mZnNldCArIGxlbiA+IHBvb2wtPmNodW5rX3NpemUpDQo+IAkJcmV0dXJuIGZh
bHNlOw0KPg0KPi0JaWYgKGRlc2MtPmFkZHIgPj0gcG9vbC0+YWRkcnNfY250KQ0KPisJaWYgKGFk
ZHIgPj0gcG9vbC0+YWRkcnNfY250KQ0KPiAJCXJldHVybiBmYWxzZTsNCj4NCj4gCWlmICh4cF91
bnVzZWRfb3B0aW9uc19zZXQoZGVzYy0+b3B0aW9ucykpDQo+QEAgLTE2MiwxNiArMTY0LDE3IEBA
IHN0YXRpYyBpbmxpbmUgYm9vbCB4cF9hbGlnbmVkX3ZhbGlkYXRlX2Rlc2Moc3RydWN0DQo+eHNr
X2J1ZmZfcG9vbCAqcG9vbCwNCj4gc3RhdGljIGlubGluZSBib29sIHhwX3VuYWxpZ25lZF92YWxp
ZGF0ZV9kZXNjKHN0cnVjdCB4c2tfYnVmZl9wb29sICpwb29sLA0KPiAJCQkJCSAgICAgIHN0cnVj
dCB4ZHBfZGVzYyAqZGVzYykNCj4gew0KPi0JdTY0IGFkZHIgPSB4cF91bmFsaWduZWRfYWRkX29m
ZnNldF90b19hZGRyKGRlc2MtPmFkZHIpOw0KPisJdTY0IGFkZHIgPSB4cF91bmFsaWduZWRfYWRk
X29mZnNldF90b19hZGRyKGRlc2MtPmFkZHIpIC0gcG9vbC0NCj4+dHhfbWV0YWRhdGFfbGVuOw0K
PisJdTY0IGxlbiA9IGRlc2MtPmxlbiArIHBvb2wtPnR4X21ldGFkYXRhX2xlbjsNCj4NCj4gCWlm
ICghZGVzYy0+bGVuKQ0KPiAJCXJldHVybiBmYWxzZTsNCj4NCj4tCWlmIChkZXNjLT5sZW4gPiBw
b29sLT5jaHVua19zaXplKQ0KPisJaWYgKGxlbiA+IHBvb2wtPmNodW5rX3NpemUpDQo+IAkJcmV0
dXJuIGZhbHNlOw0KPg0KPi0JaWYgKGFkZHIgPj0gcG9vbC0+YWRkcnNfY250IHx8IGFkZHIgKyBk
ZXNjLT5sZW4gPiBwb29sLT5hZGRyc19jbnQgfHwNCj4tCSAgICB4cF9kZXNjX2Nyb3NzZXNfbm9u
X2NvbnRpZ19wZyhwb29sLCBhZGRyLCBkZXNjLT5sZW4pKQ0KPisJaWYgKGFkZHIgPj0gcG9vbC0+
YWRkcnNfY250IHx8IGFkZHIgKyBsZW4gPiBwb29sLT5hZGRyc19jbnQgfHwNCj4rCSAgICB4cF9k
ZXNjX2Nyb3NzZXNfbm9uX2NvbnRpZ19wZyhwb29sLCBhZGRyLCBsZW4pKQ0KPiAJCXJldHVybiBm
YWxzZTsNCj4NCj4gCWlmICh4cF91bnVzZWRfb3B0aW9uc19zZXQoZGVzYy0+b3B0aW9ucykpDQo+
ZGlmZiAtLWdpdCBhL3Rvb2xzL2luY2x1ZGUvdWFwaS9saW51eC9pZl94ZHAuaCBiL3Rvb2xzL2lu
Y2x1ZGUvdWFwaS9saW51eC9pZl94ZHAuaA0KPmluZGV4IDczYTQ3ZGE4ODVkYy4uMzQ0MTFhMmU1
YjZjIDEwMDY0NA0KPi0tLSBhL3Rvb2xzL2luY2x1ZGUvdWFwaS9saW51eC9pZl94ZHAuaA0KPisr
KyBiL3Rvb2xzL2luY2x1ZGUvdWFwaS9saW51eC9pZl94ZHAuaA0KPkBAIC03Niw2ICs3Niw3IEBA
IHN0cnVjdCB4ZHBfdW1lbV9yZWcgew0KPiAJX191MzIgY2h1bmtfc2l6ZTsNCj4gCV9fdTMyIGhl
YWRyb29tOw0KPiAJX191MzIgZmxhZ3M7DQo+KwlfX3UzMiB0eF9tZXRhZGF0YV9sZW47DQo+IH07
DQo+DQo+IHN0cnVjdCB4ZHBfc3RhdGlzdGljcyB7DQo+LS0NCj4yLjQyLjAuNjU1Lmc0MjFmMTJj
Mjg0LWdvb2cNCg0K

