Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D273B391E
	for <lists+bpf@lfdr.de>; Fri, 25 Jun 2021 00:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhFXWTh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 18:19:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:38012 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhFXWTh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Jun 2021 18:19:37 -0400
IronPort-SDR: QbFZ+qbNsvTU6JYLl0K/7Ka1uXDJ+XojRI1CegoKbs/aKVMzrpFRA2FpYXb4cWBa0bTG8LpIEd
 fHc2xQaPOqMw==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="268700774"
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="268700774"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 15:17:17 -0700
IronPort-SDR: Pi9PV7/+ojKSapl8MsizMLBjAqSRLzISh29luLluKbO7OVa9XfTCFvkqjAMj0Ii2akR5duR3+M
 nYs1fOJq+Myg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="487938923"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga001.jf.intel.com with ESMTP; 24 Jun 2021 15:17:17 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 24 Jun 2021 15:17:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Thu, 24 Jun 2021 15:17:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Thu, 24 Jun 2021 15:17:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNDtZX7UDW/i+I1o88hUkrn3CSTUSj6ESkpMUo7AulvVmjiHSWP6Ve/IymyCWwXw7TrRIDaR3rGQIsy6Y117KfBgf2IplRXHAyusAQGVHYQW78GJcvLFLpDaHiBuz8TfQYrbxJ27SvA5Gn+puvS0lSIJkHj6ZoHtSsj1y3g3eTnb/z58fkBDaYmYnd2b5Jk/EZqeXjCWlE4tEhsRqzQpwrPOnqf9ftyoDbRxionOYurriMrrkCtrsvWyIYrhm8LIxsNkkFsyJgALWqd2uHJTB4T705rr2uqgVHy8fA0IUv+GmjS8Qg2KM2b6MI/rsLqdxjB3zltT6/X3MKGdgCnXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F21v6JseWiAN4eaW3luIh/1FdGfSme5kJ5rCnnSBNYs=;
 b=EdSt9FTpkCgmJLLjWSJ3KyCYB6d+FRuKpyUyBegXexmEtyCYS/8ovwpCwqP3j6XmiwbgEQQSxCktiQjNRfMFzdjfvoud1KI378miJW5PZaSW8Bj6/vhVKJrk7qDVf9RwwLLPrFAA7ekFGSFfNbZmZxd9B51sUYsdkSz85NN0OA6XlNJxDozVsVCaTqU/PKOfri619lwo0/4wcJtcBphQ98gdFiTQ4qybPML2A5W2SlrWahsqhBrJ9YP5LseJ7BJoHahdxSC7z/RnaYAIPqw0JpfsCeAqHHby9itwqcwuF5ViKYQrsLaRaQ4IRenPhswr0+awTwFUojnbr+ij5+SMtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F21v6JseWiAN4eaW3luIh/1FdGfSme5kJ5rCnnSBNYs=;
 b=J8N+0RzAV/0+JVugbF7twDB7m9IQvBCfcOqsyy/DCYcXgR/2Lt/Vj86mtREmTbvpE6S69M1sey/AoeaUJnXiNMMy7ARmwHYN9SE4OEczHgeZugz7U4oWpDyxp6k/AFHOmVpriwAM3YVCwG4tixBBWW3Cb3pk3taCLDS66fBeeqI=
Received: from CY4PR11MB1624.namprd11.prod.outlook.com (10.172.68.12) by
 CY4PR1101MB2088.namprd11.prod.outlook.com (10.172.75.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.21; Thu, 24 Jun 2021 22:17:14 +0000
Received: from CY4PR11MB1624.namprd11.prod.outlook.com
 ([fe80::d9f8:2dbd:528:b467]) by CY4PR11MB1624.namprd11.prod.outlook.com
 ([fe80::d9f8:2dbd:528:b467%4]) with mapi id 15.20.4242.025; Thu, 24 Jun 2021
 22:17:14 +0000
From:   "Desouza, Ederson" <ederson.desouza@intel.com>
To:     "brouer@redhat.com" <brouer@redhat.com>
CC:     "Swiatkowski, Michal" <michal.swiatkowski@intel.com>,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        "Lobakin, Alexandr" <alexandr.lobakin@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "saeed@kernel.org" <saeed@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
Subject: Re: A look into XDP hints for AF_XDP
Thread-Topic: A look into XDP hints for AF_XDP
Thread-Index: AQHXaI1NCoqWOcnh50mPov3W8E+846sjlEyAgAAhr4CAAAZHgA==
Date:   Thu, 24 Jun 2021 22:17:14 +0000
Message-ID: <22999687621ecba7281a905a3dbbc148fee12581.camel@intel.com>
References: <be4583429b45d618e592585c35eed5f1c113ed68.camel@intel.com>
         <20210624215411.79324c9d@carbon>
         <adfc8f598e5de10fa40a4e791a1e8722edae1136.camel@intel.com>
In-Reply-To: <adfc8f598e5de10fa40a4e791a1e8722edae1136.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.2 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [2601:1c0:6902:8a70:9eb6:d0ff:fed2:f387]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4442bd27-85b9-4a9a-f240-08d9375dd236
x-ms-traffictypediagnostic: CY4PR1101MB2088:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1101MB208824B0D06A242252623D64F6079@CY4PR1101MB2088.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F7SNesSGaY70A3D1bpNfuLt/KMa8IOat25/dQwv3ziDiM/qql2CVeYWIZTfc6VFrcJSRQdc9Q0HtBuZiOkP0gaZl/b3cs2H68RXCSb6voKfDm3cZN/r6T7Pbi1Z5NAlY7rBac8msLD9CP8HdXDsgyKx3b4DRdOIEclOykWvwNFMm3gNwlanVxQ+o/Ip/vHypNdMIwd0VqE9h0zGFpWZbcELJiHWc9eNUgQW7KYXCJM9b1zfPgfKac9VP5MxJCztydNIQB+gy2go+UuvnVLZgSzdOew/4gjc6novq40vER09Tas00DzjJ3vJF0TcWeuvYYxyUJRLKyKvX2/h827x3hGobAKmdxiUx/PPkMSegQgdPAQxK7mqs63HGOY01xWnO6R7ejoYKQL56gymcGVHqc3vGjpEKsjpD3n+m7UUCa7uC/CpVUJcPc9pqf2mVh04ibz2QyOZrywr6j2RF5o64XBwDQ8EI69JbVLe+l3Yz5fuN/gxdfmQK0zOWiRBdwNLVOzb7Pz5cWwLzS1DlqiHZJ0y0Ssq1subcisDt2jUvTyb0CuXZLcGMA6OglQ71K6Fe+oM0Ylb3h5DNRUHp9EZ9zkjLXIrSGfFOrJVCCTGo8n/wVuBDBoVjzKvwGm0nR/XT2yt2+gy5sA5QdBPLt+egAYUuddrttMkSPQkKvuCklECOrnmO3xBbqe81U2Sik+tyQzMCWV9+mrr47FoXyecY91N8IScSxEGX32uKjHwLyqqAItSdPIAO9zZThHbv24neVDdq/JlTh9hZVJbhlyx2oibA43IAycEKUvMH+tOayKO94rg8lYeNDwR1KX5kdee4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1624.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39860400002)(136003)(346002)(6506007)(6486002)(186003)(71200400001)(66556008)(64756008)(5660300002)(66446008)(36756003)(83380400001)(2616005)(66946007)(122000001)(966005)(8676002)(38100700002)(4326008)(91956017)(478600001)(2906002)(76116006)(86362001)(54906003)(6916009)(66476007)(6512007)(316002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUdlMkRsMDBNQWt3WEhZREMwWjI5V3ErRklremovR3cvTkV1V3lidVJkZGk4?=
 =?utf-8?B?b2lPNFNxUTBzalFIb2NCY3YzQ0pWaXQzYXFyMHNPcG9veDJpTVlFR0V2Ni9H?=
 =?utf-8?B?MFFzMUt6a29lVmFSZm9pRk45WU5YSjhvLzVrZk1rRGloZ2c1b2tSbVVJRXVW?=
 =?utf-8?B?NHBJcDdZTmY2dVg3K0Z1aHprRnd2YWFKWjBoSVNMNXhLNE9teVhyYWdSTDJr?=
 =?utf-8?B?dm9xMWtoRHFnTnFOUkFUb0ZjOXA0bEpKSldIZUIzNUM1a2RuWk9WUlY1ZThm?=
 =?utf-8?B?dGticTNlQjVISmdxaDlZNjdTbDRXSlA2Sm95ais3ell6UVJiTlI1Qkt5NHZi?=
 =?utf-8?B?NDJmZk5vVklwa2M0eTIvTE4yRm9FakFFb2Q3UkxDZTkzanQ0Z2dUWStza05L?=
 =?utf-8?B?dWV3TEIyWHdDV2xKc05FNy82Mzk2aXhZVEIxZ3lFR2tHWEpoNDBTUklYajIz?=
 =?utf-8?B?RTRHRDZYbDNFSHBTcHl3RWljN2ZmV3JWV3VVbzZCeXFWdXREQU9RdWwrdldF?=
 =?utf-8?B?WVR1MmplKzljaG0vOUVMUHplb3ZwT1ZRSDVjZmEwNFdKdWJTUnBKb1NxRXlK?=
 =?utf-8?B?NGpUaVVyT0M3Zm14cjljWlZhMGNSL3pTNWQ2ZHlQSHpTRm85bVFCNHhsa2U3?=
 =?utf-8?B?VEZwSDdYaEVVbU9hR2p1dzFlVXNwcERKaUx2LzhVUzlHVVJlZUNwVlh4TzRJ?=
 =?utf-8?B?UjlkU1hBUkJZMC81TnI0VmVjUWwxdWptUjMvSXluWTUrWnhrOXBodTBrSi90?=
 =?utf-8?B?aENLSzhuQkg1RUphR2ZnS1VVaDV1ZGYzNTJ0RDBoM2ZXa20zMVVNK2tIeVEw?=
 =?utf-8?B?MUk1bDZrQ3pWTDZKdTB2eFJPQkdiekxJK0ZMeGUrWEJPdWp6S2lncHpDMWND?=
 =?utf-8?B?a2hVSzZsdWpyMGhBa2E5RDlpaWRPS2hSRWduNnp2UmhJcU51aGt4bmttdmx0?=
 =?utf-8?B?ZG9mbFpCUWZ5S1Ric2Njb2U4bXhIQ0xoUmFsOXFXcnVvdkMyV2w5NWRWaG9U?=
 =?utf-8?B?NmNwSE9zdVc2ZFNmMkszQlZxL29Kd1hrZFNhV2praHg3eERjbzFQMXNFYzRB?=
 =?utf-8?B?Vm9vSXJqTFdITnkxdTkxbHFPWXk4K1djWmNEMkNiNnNNT05YcFM0QWpzcFF5?=
 =?utf-8?B?aW1JNDVwQzBpMXBFN0Y4T3pUT1l0MlZMY3Q1L2xLbjNyRGx1ZlkyNlU1V0hm?=
 =?utf-8?B?aHBpMlhvanljNzEzS2hYSXBHUmNqVVQ2bm5tVW52S21QTUlCM0Y1RXJxdThX?=
 =?utf-8?B?RTUvSkJPYXdIWUs3MWdDN2l5ZXpFL2RHSVVLMnU1YXcrOTlXTk9EalIxUlpi?=
 =?utf-8?B?aTJmYS9aVVpiVkJ1M21vNEZNTy95SUlaVlZZZHJWdTB5NURjekpPTGZmVnAy?=
 =?utf-8?B?TWpHQmdDWlVnMHo0NXpzbWZoYXRaVWtvUmRja1FQQSt3bG9mcTd3Ujhkb05t?=
 =?utf-8?B?QWR4NU13QWNQNDVwS2dnOUs3NStMeEtHd0pDdmgyLzc2dzlJUndwaVJzdFdn?=
 =?utf-8?B?cVJkdzZnRWl4cEdrYWJYd1pCZEtRTW5XSW5VN21xSkhzM0d0YjVmNlpMOWox?=
 =?utf-8?B?MXhHZFh2VHozbk80RTBUamJnaU9sQUp3Vy9FdGk5THJYcnAvTDhLaFlVMHlW?=
 =?utf-8?B?SXFFQmV2OFRKeVdadGk5TUE3cXpFbVRSdjFNNnB3MWQ5Vm1ROWZ0VEl2cWRv?=
 =?utf-8?B?K1pjT1VwYVFaVFkyMmc3U2k5bXBjVHpnY3FRV1IzRjBONEdtdlJEakk0SzlC?=
 =?utf-8?B?U0M1RXkvU1l4cXhlTkZsWHd3dndtQkxwUlNuVHNmTTFBM1pPSEhSQUlUWDB5?=
 =?utf-8?B?RjNjZkNxT2pVUWhGZlNobHNXbmhtOVFCaFZhK2Mzc0IyYXpSRTZOZFMyZkh2?=
 =?utf-8?B?dDNoRTJLQjVjL3gwczY0Mk5wL0N5aUN0WWdybW1paUZYc2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <826EED491D95FD46B809ABDF9E5E754A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1624.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4442bd27-85b9-4a9a-f240-08d9375dd236
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 22:17:14.4339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zZH3IS2YICOqhUm1jjeSD+Q44t5DL6MWsHbZJ6N8XKCeh1zDnP4tYYckubootbVZAwB0SvCo3RBQOXUbByPkIqbCtOuRRr7ogEZ8eNq4IXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2088
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVGh1LCAyMDIxLTA2LTI0IGF0IDE0OjU0IC0wNzAwLCBFZGVyc29uIGRlIFNvdXphIHdyb3Rl
Og0KPiBPbiBUaHUsIDIwMjEtMDYtMjQgYXQgMjE6NTQgKzAyMDAsIEplc3BlciBEYW5nYWFyZCBC
cm91ZXIgd3JvdGU6DQo+ID4gT24gVGh1LCAyNCBKdW4gMjAyMSAwMDoxMDoxMiArMDAwMA0KPiA+
ICJEZXNvdXphLCBFZGVyc29uIiA8ZWRlcnNvbi5kZXNvdXphQGludGVsLmNvbT4gd3JvdGU6DQo+
ID4gDQo+ID4gPiBGb2xsb3dpbmcgY3VycmVudCBkaXNjdXNzaW9ucyBhcm91bmQgWERQIGhpbnRz
LCBpdCdzIGNsZWFyIHRoYXQNCj4gPiA+IGN1cnJlbnRseSB0aGUgZm9jdXMgaXMgb24gQlBGIGFw
cGxpY2F0aW9ucy4gQnV0IG15IGludGVyZXN0IGlzIGluIHRoZQ0KPiA+ID4gQUZfWERQIHNpZGUg
b2YgdGhpbmdzIC0gdXNlciBzcGFjZSBhcHBsaWNhdGlvbnMuDQo+ID4gDQo+ID4gSSBhZ3JlZSwg
dGhhdCBtb3N0IG9mIHRoZSBkaXNjdXNzaW9uIGlzIGZvY3VzZWQgb24gQlBGLXByb2dyYW1zIGJl
aW5nDQo+ID4gbG9hZGVkIGludG8gdGhlIGtlcm5lbCB2aWEgbGliYnBmLiAgSSBhY3R1YWxseSBh
bHNvIGNhcmUgYWJvdXQgZ2V0dGluZw0KPiA+IHRoaXMgd29ya2luZyBmb3IgQUZfWERQLg0KPiA+
IA0KPiA+IFdlJ3ZlIGRpc2N1c3NlZCB0aGlzIHdpdGggTWFnbnVzIChtZWV0aW5nIHllc3RlcmRh
eSkgYW5kIEkgdGhpbmsgd2UNCj4gPiBhZ3JlZSB0aGF0IHRoaXMgaXMgYWxzbyBzb21ldGhpbmcg
d2Ugd2FudCBmb3IgQUZfWERQLiAgSUlSQyB0aGUgcGxhbiBpcw0KPiA+IHRvIHVzZSBvbmUgYml0
IHRvIGluZGljYXRlIGlmIGEgcGFja2V0IGlzIGNhcnJ5aW5nIGluZm8gaW4gbWV0YWRhdGENCj4g
PiBhcmVhLCBhcyAoMSkgQUZfWERQIGRlc2NyaXB0b3IgZG9uJ3QgaGF2ZSByb29tIGZvciBzdG9y
aW5nIHRoZSBCVEYtSUQsDQo+ID4gYW5kICgyKSBpZiBiaXQgaXMgbm90IHNldCwgdGhlbiB3ZSBj
YW4gYXZvaWQgdG91Y2hpbmcgdGhhdCBjYWNoZS1saW5lLg0KPiA+IElmIHRoZSBiaXQgaXMgc2V0
LCB0aGVuIHRoZSBCVEYtSUQgaXMgc3RvcmVkIGluIG1ldGFkYXRhIGFyZWENCj4gPiAocHJlZmVy
YWJseSBhcyB0aGUgbGFzdCBtZW1iZXIsIGFzIGN0eC0+ZGF0YV9tZXRhIGlzIGEgbWludXMgb2Zm
c2V0DQo+ID4gZnJvbSBjdHgtPmRhdGEsIG1ha2luZyBpdCBhY2Nlc3NpYmxlIHZpYSBhIGZpeGVk
IG9mZnNldCBmcm9tIGRhdGEpLg0KPiA+IA0KPiA+IEZvciB0aGUgQlBGLXByb2dyYW1zIGl0IHdv
dWxkIG1ha2Ugc2Vuc2UgdG8gc3RvcmUgdGhlIEJURi1JRCBpbg0KPiA+IHhkcF9idWZmL3hkcF9m
cmFtZSBhbmQgbWFrZSBpdCBhY2Nlc3NpYmxlIHZpYSB4ZHBfbWQgKGN0eCBzZWVuIGZyb20NCj4g
PiBCUEYtcHJvZykuICBUbyBoZWxwIEFGX1hEUCB0aGUgKnByb3Bvc2FsKiBpcyB0byAoYWxzbykg
c3RvcmUgaXQgaW4NCj4gPiBtZXRhZGF0YSBhcmVhIGl0c2VsZi4NCj4gPiANCj4gPiANCj4gPiA+
IEluIHRoZXJlLCB0aGVyZSdzIG5vdCBtdWNoIGhlbHAgZnJvbSBCUEYgQ08tUkUgLSB3aG8ncyBn
b2luZyB0byByZXdyaXRlDQo+ID4gPiB1c2VyIHNwYWNlIHN0cnVjdHMsIGFmdGVyIGFsbD8gDQo+
ID4gDQo+ID4gV2VsbCwgQUZBSUsgbW9zdCBvZiB0aGUgb2Zmc2V0IHJlbG9jYXRpb24gaGFwcGVu
cyBpbiB1c2VyLXNwYWNlIGJ5DQo+ID4gbGliYnBmLiAgV2hpY2ggQWxleGVpIGFsc28gaW5kaWNh
dGUgaW4gdGhlIG90aGVyIHRocmVhZFsxXS4gVG8gYmV0dGVyDQo+ID4gdW5kZXJzdGFuZCBCVEYv
Q08tUkUgSSd2ZSBjb2RlZCB1cCBhbiBleGFtcGxlIGhlcmVbMl0uIA0KPiA+IA0KPiA+ICBbMV0g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYnBmL0NBQURuVlFLdjVTTEJmbkJXbkVCRnFmMC1EUXYr
Tlp1aXhHaUNWeDFoZXdmUUZoSFNLZ0BtYWlsLmdtYWlsLmNvbS8NCj4gPiAgWzJdIGh0dHBzOi8v
Z2l0aHViLmNvbS94ZHAtcHJvamVjdC9icGYtZXhhbXBsZXMvYmxvYi9tYXN0ZXIva3RyYWNlLUNP
LVJFL2t0cmFjZTAxX2tlcm4uYw0KPiA+IA0KPiA+IEknbSB0cnlpbmcgdG8gdW5kZXJzdGFuZCBo
b3cgbGliYnBmIGRvZXMgdGhpcy4gIFNvLCBJIGFkZGVkIGEgLS1kZWJ1Zw0KPiA+IG9wdGlvbiB0
aGF0IG1ha2VzIGxpYmJwZiBwcmludCB2ZXJib3NlIG1lc3NhZ2VzLiBTZWUgY29tbWl0WzNdIHRo
YXQNCj4gPiBhbHNvIGNvbnRhaW5zIG91dHB1dCBleGFtcGxlLg0KPiA+IA0KPiA+ICBbM10gaHR0
cHM6Ly9naXRodWIuY29tL3hkcC1wcm9qZWN0L2JwZi1leGFtcGxlcy9jb21taXQvMDU0MmQ4YTdh
MzI3YjY0MmQxMDUNCj4gPiANCj4gPiBTb21lIG9mIHRoZSAtLWRlYnVnIG91dHB1dDoNCj4gPiAN
Cj4gPiAgbGliYnBmOiBsb2FkaW5nIGtlcm5lbCBCVEYgJy9zeXMva2VybmVsL2J0Zi92bWxpbnV4
JzogMA0KPiA+ICBbLi4uXQ0KPiA+ICBsaWJicGY6IENPLVJFIHJlbG9jYXRpbmcgWzBdIHN0cnVj
dCBza19idWZmX19fbG9jYWw6IGZvdW5kIHRhcmdldCBjYW5kaWRhdGUgWzI5NjVdIHN0cnVjdCBz
a19idWZmIGluIFt2bWxpbnV4XQ0KPiA+ICBsaWJicGY6IHByb2cgJ3VkcF9zZW5kX3NrYic6IHJl
bG8gIzE6IG1hdGNoaW5nIGNhbmRpZGF0ZSAjMCBbMjk2NV0gc3RydWN0IHNrX2J1ZmYuaGFzaCAo
MDo1NSBAIG9mZnNldCAxNDgpDQo+ID4gIGxpYmJwZjogcHJvZyAndWRwX3NlbmRfc2tiJzogcmVs
byAjMTogcGF0Y2hlZCBpbnNuICMxIChBTFUvQUxVNjQpIGltbSA0IC0+IDE0OA0KPiA+ICBsaWJi
cGY6IHByb2cgJ3VkcF9zZW5kX3NrYic6IHJlbG8gIzI6IGtpbmQgPGJ5dGVfb2ZmPiAoMCksIHNw
ZWMgaXMgWzddIHN0cnVjdCBza19idWZmX19fbG9jYWwubGVuICgwOjAgQCBvZmZzZXQgMCkNCj4g
PiAgbGliYnBmOiBwcm9nICd1ZHBfc2VuZF9za2InOiByZWxvICMyOiBtYXRjaGluZyBjYW5kaWRh
dGUgIzAgWzI5NjVdIHN0cnVjdCBza19idWZmLmxlbiAoMDo2IEAgb2Zmc2V0IDExMikNCj4gPiAg
bGliYnBmOiBwcm9nICd1ZHBfc2VuZF9za2InOiByZWxvICMyOiBwYXRjaGVkIGluc24gIzggKEFM
VS9BTFU2NCkgaW1tIDAgLT4gMTEyDQo+ID4gIGxpYmJwZjogcHJvZyAndWRwX3NlbmRfc2tiJzog
cmVsbyAjMzoga2luZCA8dGFyZ2V0X3R5cGVfaWQ+ICg3KSwgc3BlYyBpcyBbN10gc3RydWN0IHNr
X2J1ZmZfX19sb2NhbA0KPiA+ICBsaWJicGY6IHByb2cgJ3VkcF9zZW5kX3NrYic6IHJlbG8gIzM6
IG1hdGNoaW5nIGNhbmRpZGF0ZSAjMCBbMjk2NV0gc3RydWN0IHNrX2J1ZmYNCj4gPiAgbGliYnBm
OiBwcm9nICd1ZHBfc2VuZF9za2InOiByZWxvICMzOiBwYXRjaGVkIGluc24gIzI0IChBTFUvQUxV
NjQpIGltbSA3IC0+IDI5NjUNCj4gPiANCj4gPiBBcyBpbmRpY2F0ZWQgaW4gWzFdIGEgQlRGIG1h
dGNoaW5nIGlzIGJlaW5nIGRvbmUgaW4gdXNlcnNwYWNlLiBGaXJzdA0KPiA+IGxpYmJwZiBsb2Fk
cyBrZXJuZWxzIEJURiBmcm9tICcvc3lzL2tlcm5lbC9idGYvdm1saW51eCcuICBUaGVuIGl0IGhh
dmUNCj4gPiB0aGUgQlRGIGZyb20gQlBGLXByb2cgJ3NrX2J1ZmZfX19sb2NhbCcgd2hpY2ggZmlu
ZHMgdGFyZ2V0ICdzdHJ1Y3QNCj4gPiBza19idWZmJyBhcyBidGZfaWQgMjk2NS4gIEFmdGVyd2Fy
ZHMgaXQgcGF0Y2hlcyB0aGUgcmVsb2NhdGlvbnMgaW4gdGhlDQo+ID4gYnl0ZSBjb2RlLg0KPiA+
IA0KPiANCj4gSG1tbS4uLiB0aGF0J3Mgc29tZXRoaW5nIEkgZGVmaW5pdGVseSB3YW50IHRvIHRy
eSA9RA0KDQpXYWl0IC0gaXQgbWF5IGJlIGRvbmUgaW4gdXNlciBzcGFjZSBieSBsaWJicGYsIGJ1
dCBpdCBuZWVkcyB0aGUNCmluc3RydW1lbnRlZCBvYmplY3QgY29kZS4gSXQgd29uJ3Qgd29yayBm
b3IgcHVyZSB1c2VyIHNwYWNlDQphcHBsaWNhdGlvbnMsIGxpa2UgdGhvc2Ugd2hpY2ggdXNlIEFG
X1hEUC4gVW5sZXNzIHdlJ3JlIGdvaW5nIHRvIGJ1aWxkDQp0aGVtIGluIGEgc3BlY2lhbCB3YXks
IGxpa2Ugd2UgZG8gZm9yIHRoZSBrZXJuZWwgc2lkZSBvZiBCUEYNCmFwcGxpY2F0aW9ucy4NCg0K
PiANCj4gPiANCj4gPiA+IFNvLCBJIGRlY2lkZWQgdG8gZ2l2ZSBhIHRyeSBhdCBhIHBvc3NpYmxl
IGltcGxlbWVudGF0aW9uLCB1c2luZyBpZ2MNCj4gPiA+IGRyaXZlciBhcyBJJ20gbW9yZSB1c2Vk
IHRvIGl0LCBhbmQgY29tZSBoZXJlIGFzayBzb21lIHF1ZXN0aW9ucyBhYm91dA0KPiA+ID4gaXQu
DQo+ID4gPiANCj4gPiA+IEZvciB0aGUgY3VyaW91cywgaGVyZSdzIG15IGJyYW5jaCB3aXRoIGN1
cnJlbnQgd29yazoNCj4gPiA+IA0KPiA+ID4gaHR0cHM6Ly9naXRodWIuY29tL2VkZXJzb25kaXNv
dXphL2xpbnV4L3RyZWUveGRwLWhpbnRzDQo+ID4gPiANCj4gPiA+IEl0J3Mgb24gdG9wIG9mIEFs
ZXhhbmRyIExvYmFraW4gYW5kIE1pY2hhbCBTd2lhdGtvd3NraSB3b3JrIC0gYnV0IEkNCj4gPiA+
IGRlY2lkZWQgdG8gaW5jb3Jwb3JhdGUgc29tZSBvZiB0aGUgQ08tUkUgcmVsYXRlZCBmZWVkYmFj
aywgc28gSSBjb3VsZA0KPiA+ID4gaGF2ZSBzb21ldGhpbmcgdGhhdCBhbHNvIHdvcmtzIHdpdGgg
QlBGIGFwcGxpY2F0aW9ucy4gUGxlYXNlIG5vdCB0aGF0DQo+ID4gPiBJJ20gbm90IHRyeWluZyB0
byBqdW1wIGFoZWFkIG9mIHRoZW0gaW4gaW5jb3Jwb3JhdGluZyB0aGUgZmVlZGJhY2sgLQ0KPiA+
ID4gcHJvYmFibHkgdGhleSBoYXZlIHNvbWV0aGluZyBtb3JlIHJvYnVzdCBoZXJlIC0gYnV0IGlm
IHlvdSBzZWUgc29tZQ0KPiA+ID4gdmFsdWUgaW4gbXkgcGF0Y2hlcywgZmVlbCBmcmVlIHRvIHJl
dXNlL2luY29ycG9yYXRlIHRoZW0gKGlmIHRoZXkgYXJlDQo+ID4gPiBqdXN0IGFuIGV4YW1wbGUg
b2Ygd2hhdCBub3QgdG8gZG8sIGl0J3Mgc3RpbGwgYW4gZXhhbXBsZSA9RCApLg0KPiA+ID4gSSBh
bHNvIGFkZGVkIHNvbWUgWERQIFpDIHBhdGNoZXMgZm9yIGlnYyB0aGF0IGFyZSBzdGlsbCBtb3Zp
bmcgdG8NCj4gPiA+IG1haW5saW5lLg0KPiA+ID4gDQo+ID4gPiBJbiB0aGVyZSwgSSBiYXNpY2Fs
bHkgZGVmaW5lZCBhIHNhbXBsZSBvZiAiZ2VuZXJpYyBoaW50cyIsIHRoYXQgaXMNCj4gPiA+IGJh
c2ljYWxseSBhbiBzdHJ1Y3Qgd2l0aCBjb21tb24gaGludHMsIHN1Y2ggYXMgUlggYW5kIFRYIHRp
bWVzdGFtcCwNCj4gPiA+IGhhc2gsIGV0Yy4gSSBhbHNvIGluY2x1ZGVkIHR3byBtb3JlIG1lbWJl
cnMgdG8gdGhhdCBzdHJ1Y3Q6IGZpZWxkX21hcA0KPiA+ID4gYW5kIGV4dGVuc2lvbl9pZC4gVGhl
IGZpcnN0LCBzaG93cyB3aGljaCBtZW1iZXJzIGFyZSBhY3R1YWxseSB2YWxpZCBpbg0KPiA+ID4g
dGhlIGRhdGEsIHRoZSBzZWNvbmQgaXMgYW4gYXJiaXRyYXJ5IGlkIHRoYXQgZHJpdmVycyBjYW4g
dXNlIHRvIHNheQ0KPiA+ID4gInRoZXJlJ3MgZXh0cmEgZGF0YSIgYmV5b25kIHRoZSBnZW5lcmlj
IG1lbWJlcnMsIGFuZCBob3cgdG8gaW50ZXJwcmV0DQo+ID4gPiB3aGF0J3MgdGhlcmUgaXMgZHJp
dmVyIHNwZWNpZmljLiBBIEJURiBpcyBhbHNvIGNyZWF0ZWQgdG8gcmVwcmVzZW50DQo+ID4gPiB0
aGlzIHN0cnVjdCwgYW5kIHJlZ2lzdGVyaW5nIGlzIGRvbmUgdGhlIHNhbWUgd2F5IFNhZWVkJ3Mg
cGF0Y2ggZGlkLg0KPiA+ID4gDQo+ID4gPiBVc2VyIHNwYWNlIGRldmVsb3BlcnMgdGhhdCBuZWVk
IHRvIGdldCB0aGUgc3RydWN0IGNhbiB1c2Ugc29tZXRoaW5nDQo+ID4gPiBsaWtlIHRvIGdldCBp
dCBmcm9tIHRoZSBkcml2ZXI6DQo+ID4gPiANCj4gPiA+ICAgIyB0b29scy9icGYvYnBmdG9vbC9i
cGZ0b29sIG5ldCB4ZHAgc2hvdw0KPiA+ID4gICB4ZHA6DQo+ID4gPiAgIGVucDZzMCg1KSBtZF9i
dGZfaWQoNjApIG1kX2J0Zl9lbmFibGVkKDEpDQo+ID4gPiANCj4gPiA+IEFuZCB1c2UgdGhlIGJ0
Zl9pZCB0byBnZXQgdGhlIHN0cnVjdDoNCj4gPiA+IA0KPiA+ID4gICAjIGJwZnRvb2wgYnRmIGR1
bXAgZmlsZSAvc3lzL2tlcm5lbC9idGYvaWdjIGZvcm1hdCBjDQo+ID4gPiANCj4gPiA+IEN1cnJl
bnRseSB0aG91Z2gsIHRoYXQncyBiYWQgLSBhcyBpbiB0aGlzIGNhc2UgdGhlIHN0cnVjdCBoYXMg
bm8NCj4gPiA+IHR5cGVzLCBvbmx5IHRoZSBmaWVsZCBuYW1lcy4gV2h5Pw0KPiA+IA0KPiA+IEkg
ZG9uJ3QgZm9sbG93LCB3aGF0IGlzIG5vdCB3b3JraW5nPw0KPiANCj4gSSBnZXQgc29tZXRoaW5n
IGxpa2UgdGhpczoNCj4gDQo+ICAgc3RydWN0IHhkcF9oaW50cyB7DQo+ICAgICAgICAgIHlldF9h
bm90aGVyX3RpbWVzdGFtcDsNCj4gICAgICAgICAgcnhfdGltZXN0YW1wOw0KPiAgICAgICAgICB0
eF90aW1lc3RhbXA7DQo+ICAgICAgICAgIGhhc2gzMjsNCj4gICAgICAgICAgZXh0ZW5zaW9uX2lk
Ow0KPiAgICAgICAgICBmaWVsZF9tYXA7DQo+ICAgfTsNCj4gDQo+IE5vdGUgaG93IHRoZXJlJ3Mg
bm8gdHlwZSBiZWZvcmUgdGhlIGZpZWxkcywgb25lIGhhcyB0byBmaWd1cmUgb3V0IGlmDQo+IGBy
eF90aW1lc3RhbXBgIGlzIHUzMiBvciB1NjQuDQo+IA0KPiANCj4gPiANCj4gPiA+IFdpdGggdGhl
IGRyaXZlciBzcGVjaWZpYyBzdHJ1Y3QgKG9yIGJ5IHVzaW5nIHRoZSBnZW5lcmljIG9uZSwgaWYg
bm8NCj4gPiA+IHNwZWNpZmljIGZpZWxkcyBhcmUgbmVlZGVkKSwgdGhlIGFwcGxpY2F0aW9uIGNh
biB0aGVuIGFjY2VzcyB0aGUgWERQDQo+ID4gPiBmcmFtZSBtZXRhZGF0YS4gSSd2ZSBhbHNvIGFk
ZGVkIHNvbWUgaGVscGVycyB0byBhaWQgZ2V0dGluZyB0aGUNCj4gPiA+IG1ldGFkYXRhLg0KPiA+
ID4gDQo+ID4gPiBJIGFkZGVkIHNvbWUgZXhhbXBsZXMgb24gaG93IHRvIHVzZSB0aG9zZSAodGhl
eSBtYXkgYmUgdG9vIHNpbXBsaXN0aWMpLA0KPiA+ID4gc28gaXQncyBwb3NzaWJsZSB0byBnZXQg
YSBmZWVsIG9uIGhvdyB0aGlzIEFQSSBtaWdodCB3b3JrLg0KPiA+ID4gDQo+ID4gPiBNeSBnb2Fs
cyBmb3IgdGhpcyBlbWFpbCBhcmUgdG8gY2hlY2sgaWYgdGhpcyBhcHByb2FjaCBpcyB2YWxpZCBh
bmQgd2hhdA0KPiA+ID4gcGl0ZmFsbHMgY2FuIHlvdSBzZWUuIEkgZGlkbid0IHNlbmQgYSBwYXRj
aCBzZXJpZXMgeWV0IHRvIG5vdCBqdW1wDQo+ID4gPiBhaGVhZCBBbGV4YW5kciBhbmQgTWljaGFs
IHdvcmsgKEkgY2FuIHJlYmFzZSBvbiB0b3Agb2YgdGhlaXIgd29yaw0KPiA+ID4gbGF0ZXIpIGFu
ZCBiZWNhdXNlIHRoZSBpZ2MgUlggYW5kIFRYIHRpbWVzdGFtcCBpbXBsZW1lbnRhdGlvbiBJJ20g
dXNpbmcNCj4gPiA+IHRvIHByb3ZpZGUgbW9yZSByZWFsIGxvb2tpbmcgZGF0YSBpcyBub3QgeWV0
IGNvbXBsZXRlLg0KPiA+ID4gDQo+ID4gPiBBbm90aGVyIGdvYWwgaXMgdG8gZW5zdXJlIHRoYXQg
QUZfWERQIHNpZGUgaXMgbm90IGZvcmdvdHRlbiBpbiB0aGUgWERQDQo+ID4gPiBoaW50cyBkaXNj
dXNzaW9uID1EDQo+ID4gDQo+ID4gVGhhbmtzIGZvciBwb2ludGluZyB0aGF0IG91dCA6LSkNCj4g
PiANCj4gPiA+IE5hdHVyYWxseSwgaWYgc29tZW9uZSBmaW5kcyBhbnkgaXNzdWUgdHJ5aW5nIHRo
b3NlIHBhdGNoZXMsIHBsZWFzZSBsZXQNCj4gPiA+IG1lIGtub3chDQo+ID4gDQo+IA0KDQo=
