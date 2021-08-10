Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200AD3E504A
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 02:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbhHJAQv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 20:16:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60676 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231439AbhHJAQv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Aug 2021 20:16:51 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17A0EXFX015482;
        Mon, 9 Aug 2021 17:16:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=dczCciALeruPWiGF1KtaXFN23o8L+mChzsy84C3v9Z8=;
 b=Bz0ns/rHxyl61v0l2FWwegk8WdtcH8b/DJPAZf9YfSP2nO/Dk+i15t3g5abUIZHP/tcx
 9xeVAqY0qZENuEohKtFrYK2334vNCODSUEE7WFD2SeLfiEKnvjPkq0UHLCdm/UlpRqML
 FHsgiEA9Ks7D17ujmG3kMl0j9RQXyXsWti0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aba791h0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 Aug 2021 17:16:17 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 17:16:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SF+Axh4Wgar8sxoI21s2lcvPYdIB1b29iD77D3ifQiFNQVJWMjJuXx7NEUPZhO7oDC4AeohEG3iy9AXGQT8lc+A7X61EUbCwLatNfaarrurv7SOYptRFahg/qcYwDeDj96b/s3SLxZY8PuHOqSp35Z0vPyBZzpEviM4SquwQQ/O7cJgtzCwtj5i5gqGp4rW6FXHuWI+WUiE7P2w18sAP5NaRRUISKXcIMt7p/ZsDq8F0KSCmoJB1UyuDCmWNSBI+3XD3nUMYLjtQybG6Jd9gOEwWJr0s7VjExRYzavlOcCsQlbh0cefDnn7lzrhVRWU+5MPr7g3FmktK2S+tpq+aLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dczCciALeruPWiGF1KtaXFN23o8L+mChzsy84C3v9Z8=;
 b=KBUSn+LuXsYkb+pZbBf5C0bK7lRIXVlNyEj7zupkg1/PqY5eRUbKQ2OhdUHxAusjbsqTq07usFbuonLHWmvfP7wcUGrJ29o5py9F4y8PM+AY4gmCYvKOfTcUvk93rZuxxtn7tqefYqLGWxhzuCfK4gX3Wcw2BU2wo7XVvbtTzWxohqMCs3f1JWD0vtI+P8+chltPXFAsO861FgpouAdpgxe//mhXN002IyQYz3K+5Z8+Jna44YS9/AhGmZclSaEgA9CYLV3tA5oIn2US55y4GohtUd03GtALJXmIz4GBznFxkSyfd7tKR4BvBjpH00Y9E3av4JvRorb6aIZpzUwYBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB4807.namprd15.prod.outlook.com (2603:10b6:806:1e2::18)
 by SA1PR15MB4626.namprd15.prod.outlook.com (2603:10b6:806:19d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Tue, 10 Aug
 2021 00:16:15 +0000
Received: from SA1PR15MB4807.namprd15.prod.outlook.com
 ([fe80::3def:e448:e99c:780e]) by SA1PR15MB4807.namprd15.prod.outlook.com
 ([fe80::3def:e448:e99c:780e%5]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 00:16:15 +0000
From:   Yucong Sun <fallentree@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "andrii@kernel.org" <andrii@kernel.org>,
        "sunyucong@gmail.com" <sunyucong@gmail.com>
Subject: Re: [PATCH bpf-next 4/5] Display test number when listing test names
Thread-Topic: [PATCH bpf-next 4/5] Display test number when listing test names
Thread-Index: AQHXjXd1OV5Mylx+PUy/vZANJMN6uKtr2RCA//+QhAA=
Date:   Tue, 10 Aug 2021 00:16:15 +0000
Message-ID: <B8181A09-AD7A-4A1F-A972-A3ADE3C60686@fb.com>
References: <20210809233633.973638-1-fallentree@fb.com>
 <20210809233633.973638-4-fallentree@fb.com>
 <9d7cf6ad-00ee-0ad0-99c9-04eb8ef4896c@iogearbox.net>
In-Reply-To: <9d7cf6ad-00ee-0ad0-99c9-04eb8ef4896c@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: iogearbox.net; dkim=none (message not signed)
 header.d=none;iogearbox.net; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 195212d0-2262-4a49-ed43-08d95b94112d
x-ms-traffictypediagnostic: SA1PR15MB4626:
x-microsoft-antispam-prvs: <SA1PR15MB46264104EC08F574F294A3B5BBF79@SA1PR15MB4626.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:270;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D9r/CIxYa40OY/MqkUyzN2NSQDT1pRMbyBYnvC6BrDUUyOYLAhugsGwaVWLG923Rd6FNTFbaL+HycXOOezkbZ8ISlLkd81y3TUV0DOENEv4Nj2MSFDQZ2M+GswgUmUbzcwwsfkn/1LBTBwiTkxLrhmIAcR/guLJNHOAcUCJFeD2w5piGb6SoDpy7mRQtuEdVQdIJb9BdK2F1bx4Z3jQwDh5d6U+EwC9od8zT+XDvQmdDDouvdOiw7jueTn661tRomyeIRRXhJZBwFB8AksRv0nNaBa9aBgJYAa/dsfOudUdySISVbby+RwkMQxQwsvqe5rgOKbfaCgVlonwxeZxlNbSqQmXyXc4Yt8PUyaroII7X+umQUz8AQhysZTt5Xg5CliEmBDXy3yRmWH53DRk/ZAY4VxdGQlLn70/EzId4wAa3Mt1X0TTRVRl1FkqVxxNSKV1mQUOPnoCofS29Wv332y4x1BexERgfZGPop4DpwEzNvSyzpX9blM9oZyHtLoCIpi9c7dJqF2WU6u6z5YdjBurfitu5c8y3eu18tW8rwOUIXrmpaK2TtbCVUS0mdHAsriGcoEvwqTq34ptnG5KKW5CKYodeMGZ9Vc21nJg0fTkMS5nUMsA2JzEPfz4j5Cpu6Ck+kbAmevFHd6QqNAdK8NDx3o3UlTMKqy1nXrC3UFANXKUtB9idAeGoU0iV6dvOjf0OxAEKQkzNuKAo+TI7CjJjFp6265k98qQ/rWEXYc0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4807.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(38100700002)(122000001)(86362001)(508600001)(38070700005)(316002)(91956017)(6512007)(4326008)(64756008)(66556008)(66476007)(66446008)(2906002)(6486002)(54906003)(8936002)(83380400001)(53546011)(186003)(5660300002)(8676002)(33656002)(4744005)(76116006)(66946007)(2616005)(110136005)(6506007)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekxhRWp1am1wYVhiNVZSVG1lNU15ZjNvUFN0R2Q1TC9jL2tBbjVVVDlBU3RI?=
 =?utf-8?B?azl2S0IxRUVraktvOTlRMnE2Rm0yeXBaWU9EdEs2OTFPdGg0TFJKelpoWUNn?=
 =?utf-8?B?UmxiVjRxMVkzQXRrSGZLS2c4bnIwSFpyZmJLT3pWWmQrempaSU5ydXlqUWlP?=
 =?utf-8?B?RENSZlpRTXpRZ09zNDdGc095NU9oZm1UVHpPZEd4LzFQTjlLUklPL01UTjFn?=
 =?utf-8?B?WXlSbStzM2ptSXVadGw1YXhhcG41eTdRRDh2TWJTSFB2c2tIcjBRVVBzQjZl?=
 =?utf-8?B?d1VtSnFMMTMycHg2c25lM1YvMGY1T093SGRpTnJWelZoaUtCLzdERE1RNUUr?=
 =?utf-8?B?YzBkWmVmQVFERXlMY2ZsY2tTTDZRZGpCbzhldXdhTUl6TG15N1ppbzVWNFFR?=
 =?utf-8?B?dStlSGNIMndlWit2a2pBMzJra0lVbzdScnRnWkxMVzh5NzExMXp3SkpXN2g0?=
 =?utf-8?B?VS81SmRLbWRoK0J0eCtVWnlvcXY5aFpXQlZNbHpwS0I3T3NjbWRWN2ZXNW5M?=
 =?utf-8?B?SjZyTGlRTzRiNFlISGRmZDZrVEZlWGJrY1FmUE1SUDRhbzE5bmZDOXRaVXdO?=
 =?utf-8?B?dHZnYXZURjRiTWNuWVFRQWlxUm4yNkhWS1BaQ0ZHb09mbzMvcDFab1Z1OTNV?=
 =?utf-8?B?dC9sN093Y1lyNkh3MHY1Mjc3TGx5azErNzd4NS9TUDEzUmllZWZsbUthMFNo?=
 =?utf-8?B?N2RqOWE4Zko2UStHL3hsQ3FxajArTlVLcGpSeTQ0Ym55emRVd2ZXYUJHckxj?=
 =?utf-8?B?TzFwb3dXRHFDRGZJais3ZmdabzF1c2FrWXRma05Md1I4TklmeDhLWmVTSSsx?=
 =?utf-8?B?dXF1bHpad3kwcVorbkVGRGQrMElZcXNGY2doa2pTMVZ1QjJNWDd6Z2N1UUNP?=
 =?utf-8?B?Q3llcnNJeTcrTFJkZ09ibEdtcVJsT3d1b25NVVFEK0tINEgzRllJUytIM1hh?=
 =?utf-8?B?VGNFdlQyKzEwazlNMWZscWJIa1hhNWFKZ1B0K1NnZWZ1N3VWK0hSNFNwUzFS?=
 =?utf-8?B?VkJwQ2cwc1RYaEpFYmJpM05ETWQ1TzRqZmxrdmxiQ2RpbzVSZ1lwNHhsNm5V?=
 =?utf-8?B?WGxPVmp1dVVvTzhaWTRNd2tUZmR4VkM1RWJEaitxZkIvN1dKOUhKY094UDZm?=
 =?utf-8?B?dHdJeFJpOVRuR3JoNzRmbU44T2tkaitBU05RZUJ0MTFPRUNFWnU3QXZhTlpH?=
 =?utf-8?B?RkV4aUR1NVg0NnBlb0dpZ2hsakd1aURSVytqVUJTdUtmV2ZMZjV6emlCU0lo?=
 =?utf-8?B?dm8yMWRRWGJEQUxUUXY3VmQyNmpSdTJyV1NxZFZvNFpuZzBUcEZNOCtXKzVD?=
 =?utf-8?B?V0dzb1NWeDYxellWcTRORzZFTTBBV1lLYTVQUmthTjF6MldPNkhnSUNGZ0dv?=
 =?utf-8?B?VmFHb1dxZlZhUDNqeU5vbGxVNGIxTTNvUjY1SlFYeGFtbHI1eWRFdjVNekdk?=
 =?utf-8?B?djVMQ3hOcE00VVVUeDhzcnA2OWRtQm4raGc4bk14QllMMUF6NlRmakVybjlP?=
 =?utf-8?B?WHZkMzJwSWhmS0lvSUtmdkZxdEVyWHhDRG5HNEJhU1lmb3pjWHRkY0tYODA0?=
 =?utf-8?B?RFlRdmxPRER0QkhNZDNTcWpzeHFESEV6WHBzMmU0MUNUSFNDNTFVcFQ0L2JV?=
 =?utf-8?B?dngxNGhDalllV2NQQUhJVzA4ZmpTRFRCcHZKb3lWZmtOdWNBQ3E1dWM3Q3Vr?=
 =?utf-8?B?aTlJa1d1TE9zYXdtR3huRDNzK0VpU1hrWGVvNVJ3Q04wbWNneFBkYk1Lak5W?=
 =?utf-8?B?L0tGSkxQeml2dnYzcHhlMU1lZGkyOFJXdFhIOWJ5UllUdHFnd3hQUUgzeVNz?=
 =?utf-8?Q?KYH+VH175LyfALbXBBI8CAZuswEjSf0ivm7oU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AAE5AF4173A894488E3F9D8C98AC067@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4807.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 195212d0-2262-4a49-ed43-08d95b94112d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 00:16:15.0906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1vCp5IZIxHNMN8i4GIcSp0NTME3DekFjYfXzKBZbNwySqgJXwjIEiUjBgZwquOQSBXMnQXwFLa4fT1kHEuHDDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4626
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 14NU2Ohjph7Q07XwMmrifcVAvZSahdvQ
X-Proofpoint-ORIG-GUID: 14NU2Ohjph7Q07XwMmrifcVAvZSahdvQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_09:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

VGhhbmtzLCBJIHJlLWdlbmVyYXRlZCB0aGUgcGF0Y2ggc2VyaWVzIHdpdGggYSBjb3ZlciBsZXR0
ZXIsIGFsc28gYWRkZWQgbW9yZSBkZXNjcmlwdGlvbiB0byBlYWNoIHBhdGNoLCBQVEFMLg0KDQpD
aGVlcnMuDQoNCu+7v09uIDgvOS8yMSwgNDo1NSBQTSwgIkRhbmllbCBCb3JrbWFubiIgPGRhbmll
bEBpb2dlYXJib3gubmV0PiB3cm90ZToNCg0KICAgIEhpIFl1Y29uZywNCg0KICAgIHRoYW5rcyBm
b3IgeW91ciBwYXRjaGVzIQ0KDQogICAgT24gOC8xMC8yMSAxOjM2IEFNLCBZdWNvbmcgU3VuIHdy
b3RlOg0KICAgID4gLS0tDQoNCiAgICBQbGVhc2UgbWFrZSBzdXJlIGFsbCBvZiB5b3VyIHBhdGNo
ZXMgaGF2ZSBwcm9wZXIgU2lnbmVkLW9mZi1ieSBhbmQgYXQgbGVhc3QgYQ0KICAgIG1pbmltYWwg
Y29tbWl0IG1lc3NhZ2UgKGluc3RlYWQgb2YgZW1wdHkgb25lKS4NCg0KICAgIFRoYW5rcywNCiAg
ICBEYW5pZWwNCg0KICAgID4gICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVzdF9wcm9n
cy5jIHwgMyArKy0NCiAgICA+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KICAgID4gDQogICAgPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvYnBmL3Rlc3RfcHJvZ3MuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi90ZXN0
X3Byb2dzLmMNCiAgICA+IGluZGV4IDgyZDAxMjY3MTU1Mi4uNWNjODA4OTkyYjAwIDEwMDY0NA0K
ICAgID4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Rlc3RfcHJvZ3MuYw0KICAg
ID4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Rlc3RfcHJvZ3MuYw0KICAgID4g
QEAgLTg2Nyw3ICs4NjcsOCBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQogICAg
PiAgIAkJfQ0KICAgID4gICANCiAgICA+ICAgCQlpZiAoZW52Lmxpc3RfdGVzdF9uYW1lcykgew0K
ICAgID4gLQkJCWZwcmludGYoZW52LnN0ZG91dCwgIiVzXG4iLCB0ZXN0LT50ZXN0X25hbWUpOw0K
ICAgID4gKwkJCWZwcmludGYoZW52LnN0ZG91dCwgIiMgJWQgJXNcbiIsDQogICAgPiArCQkJCXRl
c3QtPnRlc3RfbnVtLCB0ZXN0LT50ZXN0X25hbWUpOw0KICAgID4gICAJCQllbnYuc3VjY19jbnQr
KzsNCiAgICA+ICAgCQkJY29udGludWU7DQogICAgPiAgIAkJfQ0KICAgID4gDQoNCg0K
