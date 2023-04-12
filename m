Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F776DFA5E
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 17:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjDLPiX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 11:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjDLPiV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 11:38:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C38E49FD
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 08:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681313878; x=1712849878;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n13EKsWqwGAPJm3XviywqKy5Tzjjx2c6gpeK+30ld3k=;
  b=S9+0tNY9uo/4wByKE1wte4KLmxoho6ym7WDBcBOZRsHY3Z0YU52m/7zj
   NOOzn6vhQ8x3Qfm7sUcEdk+TfoDTDQUJCl2tWRBPCuuqdBJkAkOIUJzsZ
   yPTSmgmepFrJ3/OTNeN8ZF4qulKvfC1LKZZQrPlYcfLr7/aAvskCqtFLt
   nS/DlSnAmUwdpaPDifCwBShURMCSc6v8qegESA8/vOVIxvWDoMC8WFc9f
   BB5hkuqrJCZztNPQT9sOtAxB4VXrpifqKS5w5l8zVtQPC/vVXk5lAuacW
   ec+35EQzT5Z7GGNN3twUCe7+B4Z6oLbJonNavYWAar/pGThKSeRXSUkvw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="430222233"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="430222233"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 08:37:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="691583518"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="691583518"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 12 Apr 2023 08:37:21 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 08:37:10 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 08:37:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 08:37:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 08:37:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NziZEur7eTs5jZ65zPmLg2QhKDuYh39OvwDw3IdQ7ay4br1K7IMNX6+6J9mhKSoU6p4mh2AqBblgmYm9iUjFBPG1+twWcrYrG48aOczWfkbvGOPEm/j6g3l4fwfGpzii6SDhzsvfCg1e2ofJyeN2xMFB7yhcpx98QMuf+zZglMd7mxkSHJpyTk5OIziwwI4oPuS9ixrh8Jl8dlY1CCRURa6TE/HmBtQtrZxG4+6spwMF0uYyfOwNUiP9mhLP3tH7nPLLQQ/fdqhSPEeu+Z7QmrEvuTCMV8cc1996eKj9qa1JgKlDDYnprBYUqMBPOUlkD6UDwON/Hy6PPXNYk6yFtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n13EKsWqwGAPJm3XviywqKy5Tzjjx2c6gpeK+30ld3k=;
 b=mt6bVgMqa1lg/uR7WSRnx0q5yyz1PMdHmft7uSPeYxBS880wKjXSUES2xaQva2+wpffNebLGH+yVgCxPpzMbxOsJfajzLNvrTB0xNDHK28F+Z32cE2GkMGyuZsC7w+iV09yIPRT11YAoFy2lgQjtcJ22QOji6A1s2lcyaKj2CfOhxhRZewHWMHTiK4Cg8S320jeIb90cU3nXvslfOWKnpMT9dVeZgUIb9A3FnCJ9UpE0gEsJdHsrxPFxq53Pdw6ZO+eYJDlswHuErwf1G0pOwtOL7gi1QplszfoD0me0+opXW1sdk8Bc1sPDXCwsVOKo5VfqSIGtPVb8T45voKi5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by SN7PR11MB7490.namprd11.prod.outlook.com (2603:10b6:806:346::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Wed, 12 Apr
 2023 15:37:01 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::1c4e:86ae:810d:1fee]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::1c4e:86ae:810d:1fee%2]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 15:37:01 +0000
From:   "Song, Yoong Siang" <yoong.siang.song@intel.com>
To:     "Brouer, Jesper" <brouer@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "Brouer, Jesper" <brouer@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        "martin.lau@kernel.org" <martin.lau@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
        "Zaremba, Larysa" <larysa.zaremba@intel.com>,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "Ong, Boon Leong" <boon.leong.ong@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH bpf-next V3 5/6] igc: add XDP hints kfuncs for RX
 timestamp
Thread-Topic: [PATCH bpf-next V3 5/6] igc: add XDP hints kfuncs for RX
 timestamp
Thread-Index: AQHZXNeuS7IymFh/rkioE9W/4bejnq8nrPuggABBkLA=
Date:   Wed, 12 Apr 2023 15:37:01 +0000
Message-ID: <PH0PR11MB5830D7F46EE359FF9EF59CEAD89B9@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <167950085059.2796265.16405349421776056766.stgit@firesoul>
 <167950089764.2796265.5969267586331535957.stgit@firesoul>
 <PH0PR11MB5830A6488CD7AB8AB0C89A42D89B9@PH0PR11MB5830.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5830A6488CD7AB8AB0C89A42D89B9@PH0PR11MB5830.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|SN7PR11MB7490:EE_
x-ms-office365-filtering-correlation-id: f1d6fbb9-6413-4092-36c0-08db3b6bc255
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UtDHia7cutSToiFxsRLmCW5wiyK+Uor0hP4X9YG/PvPALKJ9VzsMN3BeVbPE5DFAExPWv5zZY+nRhK9v/vxAdZ5OJC3iDQOKoYynY52YcmlBSXz4DA3JVEUOfpx7mFIpnoNQecKkj0DwnAZMt++XBPGVBsKo+SmNXQuC4oEx/55M6GSIhIDDRHQBKpiyZCmityUexFJXOOKGB+P26cBogfv2/hjlX+es9JzEGsuvhtvNVLGuPwgpIsE2T6FFw+wsVQ3mlV7AvTBUebkgo64ss0KHM+7PNJXKxJAxX7M5f7Mxfd+JdZxEaEtaNVzKexDDzDepB+vD6KddhGBOSpoeUx0bKYcTrWgua02MJq1Lt2h89cq/j1TPYtgMQzpacCkE+DrDpGczVEsVYZhXijn/US8f9E7kVJiedtEiEQ8slZEba4R12kGFnsDf/xpwNO3ysGWfRNu1BKaa95sjXG4HPUU6F66ALWC3Cfg0SmAtDYyFyjwNsNE/mCrywSs5YsS8A3AdPhUCnZCTTMqU1mmV3c+dezGuiXiV/tQY/P76FjgEWgrvizWTmRKBR50g3GExKevns1iy1S6gCx89IATouJSuIOYKKxPLaXeNYu9QwmyG964xe0u2srp9nOwGhY2Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199021)(33656002)(86362001)(66946007)(71200400001)(76116006)(41300700001)(110136005)(7696005)(64756008)(66556008)(54906003)(316002)(8676002)(66446008)(66476007)(4326008)(478600001)(5660300002)(7416002)(8936002)(55016003)(38100700002)(82960400001)(38070700005)(2906002)(122000001)(2940100002)(186003)(6506007)(26005)(55236004)(9686003)(53546011)(52536014)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDBCdnlmbHJCblZHZ1FiaXBZVGFqaHE4WnBnYzRkVWMvTmNPQ1JzUVdrY0Fu?=
 =?utf-8?B?YkJsaURkWm5jMys5bE5OeVpnM0V5NndRcDV3VVB5ZWszRWRiNGVkMElHaFRU?=
 =?utf-8?B?WmJNZkNRVjVFS2pWT0duSDFaR1VLcGRhcVVVQWVHeWdSVE4xRjRKa0VIYlJC?=
 =?utf-8?B?clJnL2c1OEFZWDhuSlQ4LzVRZWNFNC9xdDNuS2UvMmxJdDlrU0M3OVgwSXdZ?=
 =?utf-8?B?OFZ3L3U0dzl6eWJBMWo5eUFFeDRsZSt4UGtydVFXT3RxOHlNTzRZTnhQd3lF?=
 =?utf-8?B?anFiaVhlWElwQVdFZkdlMGp6c0YvbjErbXYwemFyQUViMHRmd2E0Q2ZVeWNv?=
 =?utf-8?B?d2dVeGdRMVY2QUk1aDVBaitjNHVubkZlL3JlbjN1RXZHa2ZGQjlOaXdHVkpV?=
 =?utf-8?B?djVySDJKbGZocU1oRTFuRFNKQkJiWFpNdDZML1ExRm1QN1NSMWo1YTlFSkNr?=
 =?utf-8?B?M3ZOZDJ5OUF1ZzlvWGw1YnA5ZHc3YU1rY00rTm9HdHNiQ3NJOGFHTXRwaHlR?=
 =?utf-8?B?OXk2Wmw0bStPSVZqL25XYXRFai9pbVZWczIvaFFYWThUektKNVRKMEFwYlFL?=
 =?utf-8?B?YXE2SGQ0MkZoQUJtZVVJejFRdkgvMWw2dElySWpwaXJoUkJUU0duS2dRKyta?=
 =?utf-8?B?ZXhyaWNveUFLc2d6Y21SS2VOaDdwUVJxeFhvM241Nkcvd3pwOUFqUnpxZEdB?=
 =?utf-8?B?RTgzM2xyYTVQWGhNbUg4Y2pyZk8yaXVycHVQYjJnWkE5dmREYlIrMHZnT2N3?=
 =?utf-8?B?Z0hsZlZiT1loN3ExMnlwUVg1QTVkNTRDc25KYTE3YUhWZWl0dm9sd3dOc0hq?=
 =?utf-8?B?akNkaERxbUprazJJa2JSdzE0QWlIWVp4VEh6SHFKTnVMaFBPdVVWcnplcis3?=
 =?utf-8?B?WUE5N0RXK1cvSUJUNld5aUtEd1FSZmlRcjIwVURzbVJGbllySXF5dm9iUU4v?=
 =?utf-8?B?OFN5ZnRQdmdGaUpYZ0NiOHV0ekhIY0VlTjhhK3B2V3pIZjlmOGU4RDRhMURq?=
 =?utf-8?B?c3NSMFpzbVhLOHEycEVucDQ5Vk9Ud25XOHRoZVR0YnZGWVF6Y0JRcTZqVFNv?=
 =?utf-8?B?N3FXVVduQm9GZk1iNEJsREpMdS9KUnIvOU54aURpay9Bb2FtNnV5UmhlQjd5?=
 =?utf-8?B?TnNsRXB4UU5na3g0WlBMR1VVM1c1THd1L0MzeXpUUXRIVHQ3UERoWmt6UUlH?=
 =?utf-8?B?N0FlMUQyWnlIN2dnUWFMVzUweVp6Qm9oNFhKV1gzazdjVG1kWktyV3lyZUpK?=
 =?utf-8?B?dStTT0t1YXJudTV4WTNRMDZ3NlV0ZzlhcDFvRWc3OG9HRDZWdGFCOW92MWEw?=
 =?utf-8?B?azVvcDROck9abkpmTnIydWJFVEpNNDlmM1JkMkpFeStnWFFYM081THk2UENv?=
 =?utf-8?B?eUJ5dTRCUkVBV3pQbWpiZnROUzNQOS9tV1BMRmhGdCszems1QTk4WVVFeG9W?=
 =?utf-8?B?ZG04OXp1ZkErRE1IWUpZUllmTVRGSVhWWHVib1hKdlh2ZGorOHUvV2hpaC9n?=
 =?utf-8?B?Q1R0d24yRGl1RlRET1k2cGp4dnFVVGtKYXBTNUtZeUZMUklscER2VC9EWW5V?=
 =?utf-8?B?THZLT2JUTi9XYU9PS0FyOHJPMDllOC9iUjcrSFhvSUxQVmppUERvRHBQUENZ?=
 =?utf-8?B?YWtqdTRPL0xqVFRIL3BTM01nYkxXT0ZGN1hJTXhUOXp4MDY3SWltTHFEeTd6?=
 =?utf-8?B?eGE2QnF6eHBwZjl2VUFGanRoMHZJVGYyQTJybEp3SWNZZEEyMHF6Q2t6VDR0?=
 =?utf-8?B?VitRTFlqMU5vbWJBK2RjY09rdkVzbzVyUkwwKyt2Y3Y3bDFzWUpsZUVCbTAz?=
 =?utf-8?B?UFJsN0w2UTU4UU9TUHBqbW8xQzJWNlI4aTNRejF0VHFUdm9vdUhSbXhUbzht?=
 =?utf-8?B?ZFV4OHg1S1NsWHRpMXg0VnhNL1hiVFluNjRrNHRxOE9xRFZPUk1oMExHM0RK?=
 =?utf-8?B?UkgyREptQnd0aExIRVliNFZQZ0VnVHQ4ZmtJaHNkZnZRWWxzZTlYZFEzdmQz?=
 =?utf-8?B?V0dsaW1zTnJ4dVNYblVtb2dDbnh4RzI0Nk1mQy9XclB5ZnpKUTJSNG9DVmRl?=
 =?utf-8?B?VHZUeWFEaHE1YVYrM29iM1Q0NjliRWh4UGI1a3hTWjAwWWFKdy9SeDVMUk1J?=
 =?utf-8?Q?AY7GMs2+UrxxQ7OSJ8pL4YF6a?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d6fbb9-6413-4092-36c0-08db3b6bc255
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 15:37:01.0946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wzbvfBFmcRzhOMe/QraB4Fli59d4UdFIPjdUXNRrBKnWUFVFtD7mvg7m6a144wDUnWz5pTD+9m5GmG54tWAdRCw5TMoc28uZlSTd75glJBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7490
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gV2VkbmVzZGF5LCBBcHJpbCAxMiwgMjAyMyA3OjQxIFBNLCBTb25nIFlvb25nIFNpYW5nIHdy
b3RlOg0KPk9uIFRodXJzZGF5LCBNYXJjaCAyMywgMjAyMyAxMjowMiBBTSAsIEplc3BlciBEYW5n
YWFyZCBCcm91ZXINCj48YnJvdWVyQHJlZGhhdC5jb20+IHdyb3RlOg0KPj5UaGUgTklDIGhhcmR3
YXJlIFJYIHRpbWVzdGFtcGluZyBtZWNoYW5pc20gYWRkcyBhbiBvcHRpb25hbCB0YWlsb3JlZA0K
Pj5oZWFkZXIgYmVmb3JlIHRoZSBNQUMgaGVhZGVyIGNvbnRhaW5pbmcgcGFja2V0IHJlY2VwdGlv
biB0aW1lLiBPcHRpb25hbA0KPj5kZXBlbmRpbmcgb24gUlggZGVzY3JpcHRvciBUU0lQIHN0YXR1
cyBiaXQgKElHQ19SWERBRFZfU1RBVF9UU0lQKS4gSW4NCj4+Y2FzZSB0aGlzIGJpdCBpcyBzZXQg
ZHJpdmVyIGRvZXMgb2Zmc2V0IGFkanVzdG1lbnRzIHRvIHBhY2tldCBkYXRhIHN0YXJ0IGFuZA0K
PmV4dHJhY3RzIHRoZSB0aW1lc3RhbXAuDQo+Pg0KPj5UaGUgdGltZXN0YW1wIG5lZWQgdG8gYmUg
ZXh0cmFjdGVkIGJlZm9yZSBpbnZva2luZyB0aGUgWERQIGJwZl9wcm9nLA0KPj5iZWNhdXNlIHRo
aXMgYXJlYSBqdXN0IGJlZm9yZSB0aGUgcGFja2V0IGlzIGFsc28gYWNjZXNzaWJsZSBieSBYRFAg
dmlhDQo+PmRhdGFfbWV0YSBjb250ZXh0IHBvaW50ZXIgKGFuZCBoZWxwZXIgYnBmX3hkcF9hZGp1
c3RfbWV0YSkuIFRodXMsIGFuDQo+PlhEUCBicGZfcHJvZyBjYW4gcG90ZW50aWFsbHkgb3Zlcndy
aXRlIHRoaXMgYW5kIGNvcnJ1cHQgZGF0YSB0aGF0IHdlDQo+PndhbnQgdG8gZXh0cmFjdCB3aXRo
IHRoZSBuZXcga2Z1bmMgZm9yIHJlYWRpbmcgdGhlIHRpbWVzdGFtcC4NCj4+DQo+PlNpZ25lZC1v
ZmYtYnk6IEplc3BlciBEYW5nYWFyZCBCcm91ZXIgPGJyb3VlckByZWRoYXQuY29tPg0KDQpUZXN0
ZWQtYnk6IFNvbmcgWW9vbmcgU2lhbmcgPHlvb25nLnNpYW5nLnNvbmdAaW50ZWwuY29tPg0KDQpU
ZXN0ZWQgUnggSFdUUyBtZXRhZGF0YSBvbiBJMjI2LUxNIChyZXYgMDQpIE5JQy4NCkJlbG93IGFy
ZSB0aGUgZGV0YWlsIG9mIHRlc3Qgc3RlcHMgYW5kIHJlc3VsdC4NCg0KMS4gUnVuIHhkcF9od19t
ZXRhZGF0YSB0b29sLg0KICAgQERVVDogc3VkbyAuL3hkcF9od19tZXRhZGF0YSBldGgwDQoNCjIu
IEVuYWJsZSBSeCBIV1RTIGZvciBhbGwgaW5jb21pbmcgcGFja2V0cy4gTm90ZTogVGhpcyBzdGVw
IHNob3VsZCBub3QgbmVlZGVkLCBzbw0KICAgaXQgc2hvdWxkIGJlIGEgSFdUUyBlbmFibGVtZW50
IGJ1ZyBvbiBpZ2MgZHJpdmVyLiBJIHdpbGwgdGFrZSBhIGxvb2sgb24gaXQuDQogICBARFVUOiBz
dWRvIGh3c3RhbXBfY3RsIC1pIGV0aDAgLXIgMQ0KDQozLiBTZXQgdGhlIHB0cCBjbG9jayB0aW1l
IGZyb20gdGhlIHN5c3RlbSB0aW1lIHVzaW5nIHRlc3RwdHAgdG9vbC4NCiAgIEBEVVQ6IHN1ZG8g
Li90ZXN0cHRwIC1kIC9kZXYvcHRwMCAtcw0KDQo0LiBTZW5kIFVEUCBwYWNrZXQgd2l0aCA5MDkx
IHBvcnQgZnJvbSBsaW5rIHBhcnRuZXIgaW1tZWRpYXRlbHkgYWZ0ZXIgc3RlcCAzLg0KICAgQExp
bmtQYXJ0bmVyOiBlY2hvIC1uIHhkcCB8IG5jIC11IC1xMSA8RGVzdGluYXRpb24gSVB2NCBhZGRy
PiA5MDkxDQoNClJlc3VsdDoNCiAgIHhza19yaW5nX2NvbnNfX3BlZWs6IDENCiAgIDB4NTU5Mjg4
NjM2ODgwOiByeF9kZXNjWzJdLT5hZGRyPTEwMDAwMDAwMDIwMjAwMCBhZGRyPTIwMjEwMCBjb21w
X2FkZHI9MjAyMDAwDQogICByeF9oYXNoOiAweDBFNTUwMDUwDQogICByeF90aW1lc3RhbXA6ICAx
Njc3NzYyOTA2ODUwMjU5NjQwIChzZWM6MTY3Nzc2MjkwNi44NTAzKQ0KICAgWERQIFJYLXRpbWU6
ICAgMTY3Nzc2MjkwNjg1MDM3NDk4MSAoc2VjOjE2Nzc3NjI5MDYuODUwNCkgZGVsdGEgc2VjOjAu
MDAwMSAoMTE1LjM0MSB1c2VjKQ0KICAgQUZfWERQIHRpbWU6ICAgMTY3Nzc2MjkwNjg1MDM5NjU3
MSAoc2VjOjE2Nzc3NjI5MDYuODUwNCkgZGVsdGEgc2VjOjAuMDAwMCAoMjEuNTkwIHVzZWMpDQog
ICAweDU1OTI4ODYzNjg4MDogY29tcGxldGUgaWR4PTUxNCBhZGRyPTIwMjAwMA0KDQo+Pi0tLQ0K
Pj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnYy5oICAgICAgfCAgICAxICsNCj4+
IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfbWFpbi5jIHwgICAyMCArKysrKysr
KysrKysrKysrKysrKw0KPj4gMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspDQo+Pg0K
Pj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnYy5oDQo+PmIv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnYy5oDQo+PmluZGV4IGJjNjdhNTJlNDdl
OC4uMjk5NDE3MzRmMWExIDEwMDY0NA0KPj4tLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRl
bC9pZ2MvaWdjLmgNCj4+KysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnYy5o
DQo+PkBAIC01MDMsNiArNTAzLDcgQEAgc3RydWN0IGlnY19yeF9idWZmZXIgeyAgc3RydWN0IGln
Y194ZHBfYnVmZiB7DQo+PiAJc3RydWN0IHhkcF9idWZmIHhkcDsNCj4+IAl1bmlvbiBpZ2NfYWR2
X3J4X2Rlc2MgKnJ4X2Rlc2M7DQo+PisJa3RpbWVfdCByeF90czsgLyogZGF0YSBpbmRpY2F0aW9u
IGJpdCBJR0NfUlhEQURWX1NUQVRfVFNJUCAqLw0KPj4gfTsNCj4+DQo+PiBzdHJ1Y3QgaWdjX3Ff
dmVjdG9yIHsNCj4+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9p
Z2NfbWFpbi5jDQo+PmIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMN
Cj4+aW5kZXggYTc4ZDdlNmJjZmQ2Li5mNjYyODVjODU0NDQgMTAwNjQ0DQo+Pi0tLSBhL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfbWFpbi5jDQo+PisrKyBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfbWFpbi5jDQo+PkBAIC0yNTM5LDYgKzI1MzksNyBAQCBz
dGF0aWMgaW50IGlnY19jbGVhbl9yeF9pcnEoc3RydWN0IGlnY19xX3ZlY3Rvcg0KPj4qcV92ZWN0
b3IsIGNvbnN0IGludCBidWRnZXQpDQo+PiAJCWlmIChpZ2NfdGVzdF9zdGF0ZXJyKHJ4X2Rlc2Ms
IElHQ19SWERBRFZfU1RBVF9UU0lQKSkgew0KPj4gCQkJdGltZXN0YW1wID0gaWdjX3B0cF9yeF9w
a3RzdGFtcChxX3ZlY3Rvci0+YWRhcHRlciwNCj4+IAkJCQkJCQlwa3RidWYpOw0KPj4rCQkJY3R4
LnJ4X3RzID0gdGltZXN0YW1wOw0KPj4gCQkJcGt0X29mZnNldCA9IElHQ19UU19IRFJfTEVOOw0K
Pj4gCQkJc2l6ZSAtPSBJR0NfVFNfSERSX0xFTjsNCj4+IAkJfQ0KPj5AQCAtMjcyNyw2ICsyNzI4
LDcgQEAgc3RhdGljIGludCBpZ2NfY2xlYW5fcnhfaXJxX3pjKHN0cnVjdA0KPj5pZ2NfcV92ZWN0
b3IgKnFfdmVjdG9yLCBjb25zdCBpbnQgYnVkZ2V0KQ0KPj4gCQlpZiAoaWdjX3Rlc3Rfc3RhdGVy
cihkZXNjLCBJR0NfUlhEQURWX1NUQVRfVFNJUCkpIHsNCj4+IAkJCXRpbWVzdGFtcCA9IGlnY19w
dHBfcnhfcGt0c3RhbXAocV92ZWN0b3ItPmFkYXB0ZXIsDQo+PiAJCQkJCQkJYmktPnhkcC0+ZGF0
YSk7DQo+PisJCQljdHgtPnJ4X3RzID0gdGltZXN0YW1wOw0KPj4NCj4+IAkJCWJpLT54ZHAtPmRh
dGEgKz0gSUdDX1RTX0hEUl9MRU47DQo+Pg0KPj5AQCAtNjQ4MSw2ICs2NDgzLDIzIEBAIHUzMiBp
Z2NfcmQzMihzdHJ1Y3QgaWdjX2h3ICpodywgdTMyIHJlZykNCj4+IAlyZXR1cm4gdmFsdWU7DQo+
PiB9DQo+Pg0KPj4rc3RhdGljIGludCBpZ2NfeGRwX3J4X3RpbWVzdGFtcChjb25zdCBzdHJ1Y3Qg
eGRwX21kICpfY3R4LCB1NjQNCj4+Kyp0aW1lc3RhbXApIHsNCj4+Kwljb25zdCBzdHJ1Y3QgaWdj
X3hkcF9idWZmICpjdHggPSAodm9pZCAqKV9jdHg7DQo+PisNCj4+KwlpZiAoaWdjX3Rlc3Rfc3Rh
dGVycihjdHgtPnJ4X2Rlc2MsIElHQ19SWERBRFZfU1RBVF9UU0lQKSkgew0KPj4rCQkqdGltZXN0
YW1wID0gY3R4LT5yeF90czsNCj4+Kw0KPj4rCQlyZXR1cm4gMDsNCj4+Kwl9DQo+PisNCj4+Kwly
ZXR1cm4gLUVOT0RBVEE7DQo+Pit9DQo+PisNCj4+K2NvbnN0IHN0cnVjdCB4ZHBfbWV0YWRhdGFf
b3BzIGlnY194ZHBfbWV0YWRhdGFfb3BzID0gew0KPg0KPkhpIEplc3BlciwNCj4NCj5TaW5jZSBp
Z2NfeGRwX21ldGFkYXRhX29wcyBpcyB1c2VkIG9uIGlnY19tYWluLmMgb25seSwgd2UgY2FuIG1h
a2UgaXQgc3RhdGljIHRvDQo+YXZvaWQgZm9sbG93aW5nIGJ1aWxkIHdhcm5pbmc6DQo+DQo+ZHJp
dmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmM6NjQ5OTozMTogd2FybmluZzog
c3ltYm9sDQo+J2lnY194ZHBfbWV0YWRhdGFfb3BzJyB3YXMgbm90IGRlY2xhcmVkLiBTaG91bGQg
aXQgYmUgc3RhdGljPw0KPg0KPlRoYW5rcyAmIFJlZ2FyZHMNCj5TaWFuZw0KPg0KPj4rCS54bW9f
cnhfdGltZXN0YW1wCQk9IGlnY194ZHBfcnhfdGltZXN0YW1wLA0KPj4rfTsNCj4+Kw0KPj4gLyoq
DQo+PiAgKiBpZ2NfcHJvYmUgLSBEZXZpY2UgSW5pdGlhbGl6YXRpb24gUm91dGluZQ0KPj4gICog
QHBkZXY6IFBDSSBkZXZpY2UgaW5mb3JtYXRpb24gc3RydWN0IEBAIC02NTU0LDYgKzY1NzMsNyBA
QCBzdGF0aWMNCj4+aW50IGlnY19wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwNCj4+IAlody0+
aHdfYWRkciA9IGFkYXB0ZXItPmlvX2FkZHI7DQo+Pg0KPj4gCW5ldGRldi0+bmV0ZGV2X29wcyA9
ICZpZ2NfbmV0ZGV2X29wczsNCj4+KwluZXRkZXYtPnhkcF9tZXRhZGF0YV9vcHMgPSAmaWdjX3hk
cF9tZXRhZGF0YV9vcHM7DQo+PiAJaWdjX2V0aHRvb2xfc2V0X29wcyhuZXRkZXYpOw0KPj4gCW5l
dGRldi0+d2F0Y2hkb2dfdGltZW8gPSA1ICogSFo7DQo+Pg0KPj4NCg0K
