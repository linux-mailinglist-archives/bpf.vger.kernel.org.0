Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9F86E679D
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 16:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjDRO4X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 10:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjDRO4O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 10:56:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8273BBA6
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 07:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681829752; x=1713365752;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dqilThP98GsGzzzSbGhKj2QyhNyDzOGW9K6xICagjNw=;
  b=YmQRhhWBginO1RVWcQPBDD354Etp9aew3fTyzgDkbXVa+XBBWo4fPR4P
   xF0NjBRGvpswtEpgRSgQ1NBsR7Bz9YyTIp1GwjfjPnxRPT9FpfIO95QPd
   38sQ/VrE5xF7d+Z2ZIVq1JZje3dyOWAcoVNtp6QJcwxeChRns+Ff2KWe/
   xgNAVVPy+iy3xWF+PyDYYmUgIHJaW3SsZ4eztcUlNRsWRlasFBUSz/1da
   x+WiyLBMEvPvA0zJ43AGHIUTUGRDJZ8RsB+2rWbXcprYZ/uCsBvWj9PDz
   DP4SXCogoSZhgBDOvu6NSFCJkgiOGePZzU8LRlxpF2Soel/+nxR+IsSF8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="408097078"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="408097078"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 07:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="780522640"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="780522640"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Apr 2023 07:53:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Apr 2023 07:53:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 18 Apr 2023 07:53:45 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 18 Apr 2023 07:53:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqW0Y/485laTQXhINAfsoBvi5WGYyzmfkm04+bPuq7zpUeeV9EDqdfpr0K/8BcsGtjmDOB8Stb591BpZFpqVEJvACnv3yjIJPHZZADH5BhjUWEegSy3ijWvzY+ytyxSNSavZriJqx7lYhIa7RfXBL8WVwtF0BymlFS9Ij3ATAzJkeOveP+TB2p+ZOuB7wv719+jppCkV2ZINkfhT4JR2uu0gsIhYUhGryPH4FLVIux1BO+be87/nHXgwkvGZo9NS6ITeyljpNYL/h09w8pFmbyIn/zV1aJ7ZS9h6/58F346wtct+Lx1LpcSX/lm1gH9pqiXTTVkq79i2IZugB+lxtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqilThP98GsGzzzSbGhKj2QyhNyDzOGW9K6xICagjNw=;
 b=J9OuX2bcpg85icgY7iEvB8jQ60kh5heOvAyAJ7TtH3e0LYvh7e7OvyTZYaNAQAWt9St6g7c6csxZW+r8WgJ1N1iUALlvLJjBfoBgfMKfUJ9GiwNX0DlDbcc1T6vmcpDmJMjLfNT2tjhqPE/Rm1CRgzirZzf4tP04+5hnXbz9/V3LcY77BNRX9tEjssAWyHJCnaStmrNAHT+aEKjqbmfy0SmTO4unahHzatmNhheuPgHb2xU86k5pO8c3kx5NrA+qSP39bvRc7mxZy9frYxwljnIqfxnnK6wB/moQPai5VH/dN9zIpNQAyrNtgD4WEwxckOdwjtMLJP9bQZ/O60GvFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by BN9PR11MB5244.namprd11.prod.outlook.com (2603:10b6:408:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 14:53:40 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::1c4e:86ae:810d:1fee]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::1c4e:86ae:810d:1fee%2]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 14:53:40 +0000
From:   "Song, Yoong Siang" <yoong.siang.song@intel.com>
To:     "Brouer, Jesper" <brouer@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        =?utf-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
CC:     "Brouer, Jesper" <brouer@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "martin.lau@kernel.org" <martin.lau@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
        "Zaremba, Larysa" <larysa.zaremba@intel.com>,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH bpf-next V2 0/5] XDP-hints: XDP kfunc metadata for driver
 igc
Thread-Topic: [PATCH bpf-next V2 0/5] XDP-hints: XDP kfunc metadata for driver
 igc
Thread-Index: AQHZcfoI9V6NvnDgXkCLqXnH5km0Xq8xJpLg
Date:   Tue, 18 Apr 2023 14:53:40 +0000
Message-ID: <PH0PR11MB583075A0520F8760657FC4BED89D9@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <168182460362.616355.14591423386485175723.stgit@firesoul>
In-Reply-To: <168182460362.616355.14591423386485175723.stgit@firesoul>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|BN9PR11MB5244:EE_
x-ms-office365-filtering-correlation-id: 0d859540-d99c-4399-fcfd-08db401cb27a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EVQh/bg25bYp6uKmzHkCV0FTW2Ah2jjPMwlEXgt1uG3zSFT8/qhUecU/EwCSEJQnpaNutS6ND5oUEZaNAQt4pOQwx72+BzNxBUYdhKrbzYkYAmDD5n3ohZcu/z4wtCnKQ84Dru+GF98Hvf0uyyHA/ZYM2dr1+dXiGbcFby949U10wFfOTEhMrkCBVb5a6I705D3J7c4XxlikgKHKcM0PJKQVxJ8acY1xRqYe+KneuK8ptVClTExRzer3jSHGr9jwnYzYtLl/wGJLKKzDN+haMKE0sgTPoK06yd2xe//bEnOWD/ugNXlVz4CZflwn+R3GDKsJEt1taviKbrYObpisgv4bDQHgmnCO1Aw6ulGWjRluT32OGMfpk30bwm2phEtH5sdUeiStECpDMjgZJA2OeMp4zVlSn0JJPd0EcetLHon39ea+6CKXZpwc+N3MENlcGOt7vbCGMGxxGSdBayd98r9+r5uUDAGqk/hnLLGCoBytigqWt+nTbO96ZjVAKNfppPiDIQL69r45TKWgzOcVb9njMXCBwU+fckOk5a3rYRUKzT/bHAgvzC55LlcJwxbk6hWXCNQLfSTHMNRYazByjQE4ZN8/RiKXFpGLhx93Y5ECKV0hqxx3IrBnpFrwzuJG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(7416002)(52536014)(5660300002)(86362001)(83380400001)(55236004)(186003)(9686003)(53546011)(122000001)(82960400001)(26005)(6506007)(38100700002)(8676002)(38070700005)(8936002)(33656002)(478600001)(54906003)(110136005)(7696005)(71200400001)(316002)(55016003)(76116006)(41300700001)(66446008)(66476007)(66556008)(4326008)(64756008)(66946007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0ozLzFKMFVYVnQ2UFEwUmJKem9aSWRhbFBCVnhIdXZyeFFBeVB1dko4OU5O?=
 =?utf-8?B?VDFORmxiNTF0QUlvaGhnR0NjU2NVbkZMOVlDSFM3bHQyWHhMYmIrdHNUK05H?=
 =?utf-8?B?VkJPTHFaSGdzMXp3bCsza3QyemdSZTY5ZG1WZlArYUFZL3dKQkR6TitwTi9O?=
 =?utf-8?B?OUxGTUJ2VzBTZE15SXpkbDVZeDJMV2VwZVlXbHd0bGVoSUgrVTBVYXhNTG1D?=
 =?utf-8?B?Y3BoMllnRDFTT0k3SitXV0JtWTYxem9VNC94aU12QURlYk0xaHZZNVFsWEJT?=
 =?utf-8?B?dFh4em5mOGMwNmdSYjhzWm5CaHhJWmhtNU9VUG01ZndrbG4xb2dVamxON1ZV?=
 =?utf-8?B?emlCQUNKWWZwWVRUUWk1dHg4a2tKYVFSbzROT3NHYmRpbm9kWmVYMkw0TXFR?=
 =?utf-8?B?SnQ4T2xFWGJyTDI2V2cvRUhJKzJqMjl5ckEyRnB6bDVpcG1Pd3JNYm93Qi9P?=
 =?utf-8?B?NHNBZ1BBN1pHSDl2aC95L09oTjcwcTlYanB1Y0VsZ1gyREdrRFpTQ251cmdD?=
 =?utf-8?B?Z0h3eE1CS2RvempPZy82MTdUWlp0TzZXdW5sVEhSUUZaUVhFeVN6aE1aZEhQ?=
 =?utf-8?B?S0NTZzRxR0gvNmtNVkRSUUpWS3lQemYwK3B6UWg1SGltc2NLbENURXJDa3Qx?=
 =?utf-8?B?OU5peWx3aEtadktKVEhSNGhBbEY4eThSVDA5ODAvZEpnclNEMjg3YkJLd3dQ?=
 =?utf-8?B?alkwMisyYXMrNG01eHlOdzh1NG1vQ1hDY05ISjhzN2tiSU8rN1NXSEp0Ky9C?=
 =?utf-8?B?aEJUTmQ5NkUwa2tvbEdZTWovYjhKUzBiR0Z1eVZLLy83WDZIM2xJVUhVSlNJ?=
 =?utf-8?B?cTZXeUxOZUxjZDBNNFJoeFo5VnFlMWIwTTZhNTlaaWJTYTB2RWFZS0FrNTU1?=
 =?utf-8?B?ZEREU1JSa045empnaWx0K0tiNTNjcVUrS2k2Y3pGUlo3cFhaalRxL2JBRzRo?=
 =?utf-8?B?OXkwMmxYcVFzOTVYc3BORG51dHVXSXA0cC9WbUVqT0dNMVRmMGk1RTh2cWM3?=
 =?utf-8?B?YkFqelhHU1lOUXBVZU5iRis5dVlSS045QTNvdkN1alM4QWpmdUtobFlsK2Zv?=
 =?utf-8?B?TWVGK0ZzeDVOVHo3THpuc1dSbzhPQmNVQUZlQ2RJanh5d3lXaitHZm4xTW12?=
 =?utf-8?B?MEd5ak5Wc3VFMHB0WERUM3F5VlFQbXJDMlpwMlpnTTYwdUw0eU41TFluYlJN?=
 =?utf-8?B?VXJ0SzJnWG5QVExIbGRtSTI1ZlJYOTJIQTRMQStRUmozUytmWjY0aUhVaDkw?=
 =?utf-8?B?cTE2ejFSRlRkK3JqaE1GWkpXUU4vQnFZOGt4bGZKN1Y4NnhlVTdOWXZOekh0?=
 =?utf-8?B?SUlYektud3lVNHVnMWFZNFhlOG4zSWRRRmpyZlM3WnBpWHBFenB0cjdrZTlR?=
 =?utf-8?B?YUlkbk1jQUNYN29OYlZxVzRnU3AvanF0MXpIUEwzU3hEaTUyYm1yWC84b2NZ?=
 =?utf-8?B?UXJCQ3FZUkkwaWMrRERIZkwybWxqTzFTaWFzM21OUEU5b3poQU1EUVRDWXZu?=
 =?utf-8?B?ejJ1WkZwMEtQR1A5bnI1NldnQWJ5c1d1TTFxbmdFMnNoekNrRVdzeSt2NW0z?=
 =?utf-8?B?czdicnl2Y29GY0pMVERXbEN4WXdXalVrOGlWck5ZVHFlMmpKQVdwQzFQc0pP?=
 =?utf-8?B?WVRCOXVaUG5ST1BvbjZiVWhSS2FpSWtLMjZaQWozZmlWNmg3UndkWk8raEVQ?=
 =?utf-8?B?Rm5EV2hSWjV0TkRMRUZvTFQ4TDgxdXZTSnJuaVB2YjdLYU1jcWp4NTlJOUFy?=
 =?utf-8?B?QytRNTJOWlA3YUExNHhzSUJibGlPS2JPRStkNGp2di8xYUdsN1lHVmlndFFB?=
 =?utf-8?B?WXFTR0NrT2RWRVF2dXBTZmR6WXBzbXRQRStwbHhnMm5sbWpXUERFTlRjbTEv?=
 =?utf-8?B?RUx3TDZGc0Zzd2tHUWp6ZFNZRGhXNHhtejMxc3pSZXpXWURuYWt6WEtSZkZl?=
 =?utf-8?B?RERhWU9vSTdjaHN0aEcwTU4xNU5WNi9TSjJITm9Gbk9yWXVNaDhpZUlrakRr?=
 =?utf-8?B?Lys2OEJHMVR0a3RoT1AvRW91MjA5TzFkOW5hYzZmbGxTWCtVZGZKWnZ4QjFU?=
 =?utf-8?B?cXExVnlDM0NQbDJEbFlPVit2cXBvd2ViQnFUcVM0NmFpdWh4V0hGamczckQ4?=
 =?utf-8?B?RE90cjN4VjdBQVBHY1Z6MWVORGVnYngvZkRSa0FHZ25WOTJXTmgybDdkY3ZJ?=
 =?utf-8?B?QUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d859540-d99c-4399-fcfd-08db401cb27a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 14:53:40.0204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 07UpyXFS25M4VRmSJ2XX3OqZPo6SPqqO7O/HiQDRSJjvb2EHkIScwxPU6QHa85m99+zq0OFCOls7f9D1ismaR/r1gTT5aHVQSzP7Yf0YrDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5244
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlc2RheSwgQXByaWwgMTgsIDIwMjMgOTozMSBQTSwgSmVzcGVyIERhbmdhYXJkIEJyb3Vl
ciA8YnJvdWVyQHJlZGhhdC5jb20+IHdyb3RlOg0KPkltcGxlbWVudCBib3RoIFJYIGhhc2ggYW5k
IFJYIHRpbWVzdGFtcCBYRFAgaGludHMga2Z1bmMgbWV0YWRhdGEgZm9yIGRyaXZlcg0KPmlnYy4N
Cj4NCj5GaXJzdCBwYXRjaCBmaXggUlggaGFzaGluZyBmb3IgaWdjIGluIGdlbmVyYWwuDQo+DQo+
TGFzdCBwYXRjaCBjaGFuZ2UgdGVzdCBwcm9ncmFtIHhkcF9od19tZXRhZGF0YSB0byB0cmFjayBt
b3JlIHRpbWVzdGFtcHMsDQo+d2hpY2ggaGVscHMgdXMgY29ycmVsYXRlIHRoZSBoYXJkd2FyZSBS
WCB0aW1lc3RhbXAgd2l0aCBzb21ldGhpbmcuDQo+DQo+LS0tDQo+VG8gbWFpbnRhaW5lcnM6IEkn
bSB1bmNlcnRhaW4gd2hpY2ggZ2l0IHRyZWUgdGhpcyBzaG91bGQgYmUgc2VudCBhZ2FpbnN0LiBU
aGlzIGlzDQo+cHJpbWFyeSBOSUMgZHJpdmVyIGNvZGUgKG5ldC1uZXh0KSwgYnV0IGl0J3MgQlBG
L1hEUCByZWxhdGVkIChicGYtbmV4dCkgdmlhDQo+eGRwX21ldGFkYXRhX29wcy4NCj4NCj5KZXNw
ZXIgRGFuZ2FhcmQgQnJvdWVyICg1KToNCj4gICAgICBpZ2M6IGVuYWJsZSBhbmQgZml4IFJYIGhh
c2ggdXNhZ2UgYnkgbmV0c3RhY2sNCj4gICAgICBpZ2M6IGFkZCBpZ2NfeGRwX2J1ZmYgd3JhcHBl
ciBmb3IgeGRwX2J1ZmYgaW4gZHJpdmVyDQo+ICAgICAgaWdjOiBhZGQgWERQIGhpbnRzIGtmdW5j
cyBmb3IgUlggaGFzaA0KPiAgICAgIGlnYzogYWRkIFhEUCBoaW50cyBrZnVuY3MgZm9yIFJYIHRp
bWVzdGFtcA0KPiAgICAgIHNlbGZ0ZXN0cy9icGY6IHhkcF9od19tZXRhZGF0YSB0cmFjayBtb3Jl
IHRpbWVzdGFtcHMNCj4NCj4NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnYy5o
ICAgICAgICAgIHwgIDM1ICsrKysrKw0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2Mv
aWdjX21haW4uYyAgICAgfCAxMTYgKysrKysrKysrKysrKysrKy0tDQo+IC4uLi9zZWxmdGVzdHMv
YnBmL3Byb2dzL3hkcF9od19tZXRhZGF0YS5jICAgICB8ICAgNCArLQ0KPiB0b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9icGYveGRwX2h3X21ldGFkYXRhLmMgfCAgNDcgKysrKysrLQ0KPiB0b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9icGYveGRwX21ldGFkYXRhLmggICAgfCAgIDEgKw0KPiA1IGZpbGVz
IGNoYW5nZWQsIDE4NiBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4NCj4tLQ0KDQpU
aGlzIHBhdGNoc2V0IGxndG0uDQpUaGFua3MgZm9yIHRoZSBjaGFuZ2VzLg0KDQpUaGFua3MgJiBS
ZWdhcmRzDQpTaWFuZw0K
