Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CAD4DA126
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 18:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347116AbiCOR3r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 13:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345617AbiCOR3p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 13:29:45 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B692BBC27
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 10:28:33 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 22FGWZx3028783
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 10:28:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=s9c/uzoa/OnBpV4fIIgfsIiEY9HyyH5heAe88D+RqRA=;
 b=cPoL6whZSXvnofZaKrsAdnPZ9o6AZBhib38z9XJ043kpSRKzYCFhzIfi/7b/NPf6oA2p
 5Ibkd+9k9nojc7j0bgkay7OUCXHzu6g6Se1xUTeqziv7GgEvEk4uDVj+SVW39PFVOHYu
 pVNl3zN0Qjn4vuuKbTCCQRWa+YY/WuPXiHc= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by m0089730.ppops.net (PPS) with ESMTPS id 3et99mgyh1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 10:28:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naJ9WtPOGzLhsLdVsQ77YDmh8XL+EKZV0Igkd5UWHe/x1bUuwYTM969CVyCS0xqrQ1E02V8C/L9CeUQJ8HheORYIVanQGhmuzITGWHKOoiNGsBgdvHqLd3CEZ0vZxDVZAqo+I4QLWST1MDrB1fA3/Uw1HE6Xfu4vz1XwCdc4nSDefTvYvbBble4+FXAAIS+FmB+IckzIrhCoVbsfXwMv74B05loteQZBdVjBQp1OfudGU2CYSyEbaLbJwjN4vwoXMlIxOLGsFV93VVxZy6cth7AnJccj7WUo5KHcrC9JPc/x7gZ4lkhARDMhQijFhZy/5ueB6sSKbyMasQMT9dv1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9c/uzoa/OnBpV4fIIgfsIiEY9HyyH5heAe88D+RqRA=;
 b=kqh2WQlxeb4vxauFa1SI99M7CAKStwcXOLAsk0hAFCOg41kIQRk0XBgRuJEY0BVDK132h03PLXvajFm5zVaeMMvkD8eSZ2iMtLiiFjF9NiVUAGoD+hGiEJO+n+or3hfW/mp1SOCHki9QE3/NYdDky5EKRf//KFeeLoqe8TLO4c/b413g15eVmQYLIS5RUZ0ofK3ZeEeDsaZAZ9tflkbGqRIaZ5e07O0n2LciaB50sWJs+G71S3ks6cEEV8kl9nyR9zhCEtaA7BTJj2Nig/Zazq5zzF5QZ/4Zt7Fz2wyzPjglFlWcg94KwnKYrkMusQI7JgVAxlB8cYT/KVPsvaQk2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by BN6PR15MB1812.namprd15.prod.outlook.com (2603:10b6:405:5a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 17:28:29 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%6]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 17:28:29 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 4/5] bpftool: add support for subskeletons
Thread-Topic: [PATCH bpf-next v2 4/5] bpftool: add support for subskeletons
Thread-Index: AQHYNNydupPAactdBUG4tOXk3PpOhqy61V6AgASzJoCAATCHAA==
Date:   Tue, 15 Mar 2022 17:28:29 +0000
Message-ID: <534afc41cb3066ed049f0ab15ef65d32d30a33d3.camel@fb.com>
References: <cover.1646957399.git.delyank@fb.com>
         <d3ee2b3bb282e8aa0e6ab01ca4be522004a7cba0.1646957399.git.delyank@fb.com>
         <CAEf4BzaeycEUjZVCd+7sxFaQWfbqhmsMd_G_bydS15+45LcDvA@mail.gmail.com>
         <e3e84d87c2a0c13ae9f20e44493c1578e06b6618.camel@fb.com>
In-Reply-To: <e3e84d87c2a0c13ae9f20e44493c1578e06b6618.camel@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c934dd48-bb39-459c-e2a4-08da06a938a0
x-ms-traffictypediagnostic: BN6PR15MB1812:EE_
x-microsoft-antispam-prvs: <BN6PR15MB1812C4D7926B5675EB196006C1109@BN6PR15MB1812.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5GovIwz/xeaz3MGfI3boefNetw7TYrr4E0w2Hq6n74wHPoW4YlwV+WmVzbT8Vn9caPfLexpzBqRNbp4jwNTz/TSta4wnGA5UoITA+/Q2gSAHWq9M2LW5cIX/PWRFtfCisSKFoYMVP7PxCGBVQHyYGj0XjX2aiusMO/lMeFFraC6Qalu0qS23P9MF/YRU6+sDVbrxhEYnBC3wYKtByGNVQH6Tt1PeQo5y/XAb+1BT/9H26rtylIOpfomnBeJsbScPbE7FuuOk2W2X/Tfo1LrKvO8F4EYu9oX/KewR9ts3QgS2A/nEx2r2mfpThrvPgDSoSs46BaIg3/bsMid2qgiwbcQ0Z6OvapP3+og+sFJbeO4+apOttPImrK95HFRVAnVOmmmieKDLNfbRkKfBUM/rb7pbbx6I7G5ylt6TJUKaER2KedhP+SYLJdj/39ObJdGR3cnNQ6dKWBQQB3AmmsqfczV125qxiUPpQPNR/Q+WO/kUCfM+4jj4mQ3NMb8/k1HloocsqJI5WGy037x21zsz6KmaNhwqeOtt2ZqeVICbZK5R/GR5Z6Q0QHMCU4FO1EKGwQamHc36N1yJAVsZKLM+WIvD2nac4chm4dhc5jMNY8Cc1vVGJCOti/ZZfnz6TycALHhyw8QoC4bsea4UC/CuS/fANMo3ZYNDUDAO2o0LVI/f5bts0h1vpL7eRxyNAlO82YSxnTQd9dRnRFNfMTJr/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(122000001)(6506007)(38070700005)(91956017)(4326008)(8676002)(76116006)(64756008)(66556008)(66946007)(66446008)(66476007)(6916009)(38100700002)(54906003)(6512007)(316002)(186003)(2906002)(6486002)(508600001)(71200400001)(2616005)(8936002)(36756003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aW1wMVZ5bGZVcklLNEh0YVNyWll1VGVwWmlXK0NhZXJGZXdnRlpnWVJIdkNP?=
 =?utf-8?B?enN0Y2dNREFsZjFqYVFXak1UTDdsS1FmVThmTExYMElwaXlWVjRISFlUaVBO?=
 =?utf-8?B?RkpvSm13Q3o0MGlFY1BZNlorRi9UY0VJSmJaekZteTlmUkgxNWNQa2Fjd3RV?=
 =?utf-8?B?T3ZjOElPWUEvU3QyN0t2ZkhNUTgvZklxY3NYWlRiWCs2OXJtclh6eWtLRGlk?=
 =?utf-8?B?REtXdi9TVjFRVHo1SFd3T2ltUWZSRFVzOFRycFhtZVozcXM4OHBhTWQxWnQ2?=
 =?utf-8?B?TTdqWWljM05aQmZGaTBJR2lKSTZ1SEZFR1FiSWsvZEkxakVRdzVFZTJwOHhm?=
 =?utf-8?B?L3o2Y0FNQURud1VoUUxkTnpwMThNcnBFYkpFMFNDUStVdTRsV0x6Q1Rmb1Bh?=
 =?utf-8?B?bldvdXVhZHNVanhPdzVySkUrV2JuMDBYdDUwR0YwODIxVkd4RUZCdUU3dUNZ?=
 =?utf-8?B?ZDdBdjA3LzJwNnd2Sm51eE1TN2FDbW9SSDBDc0hIeG13V1R2aWFRTUJEdlpD?=
 =?utf-8?B?Y1R0SGJjZ0E1SFJORnd2RDg4VEdOZ05wZG1kM3MwOThkd2pycFFxeFpaUlFT?=
 =?utf-8?B?R2ZNZVpHb3lHQUVkcVkvbklwYUpvbnFBYVplWWpyR3RCZDRjSkUrTkRSS0hU?=
 =?utf-8?B?MVNTNTJMa1JzUnlwZHpSL1V0NzAzMUV0L25uVVJaQnUvaXA2REpKSWdXUjlR?=
 =?utf-8?B?dTFXMzMxaUNZNG8yNVlUWmxBcE9GWTAzeTBtTTdlVVFURndzUkJUSDdZWENP?=
 =?utf-8?B?aEkwbnVKZ2hrajBsZVo2bDhZMW50RENjWW1UMGcrSjlIamZqVng1elNFdm9I?=
 =?utf-8?B?d1YwZ09kVDhMRFlTQmVzbU1LWTk1SHhNMGl0QjBLVFh4MjY2YVVYcXFzeEYw?=
 =?utf-8?B?eFEwdldJbFlrdUMzZjNNaVdqWnRoNmdzU0M0c0cyOU9PQmtodjE5aVRFc0xV?=
 =?utf-8?B?SVBFZllRMVZqNUhnenVZTEhoS3ljYzBhaDQyN000ekcwVHZQN1hDZk9XTVk1?=
 =?utf-8?B?U3JSNDhOMElpTGJtZUhQWGlWcjE0NHRnNHhoNWdxeWllVS9JSUE4RmtXVnJB?=
 =?utf-8?B?N1NicUpDMTRFS3ZRd0grdVhZQUZuY0JKa1VjaUhabzQ0N0VuTzdsRXlmQXJs?=
 =?utf-8?B?V01ISms2M2JSTVdHWFhCa0pWZ04xRHYvU3pOdFJiZmt4eTFleG5aWDVteTRj?=
 =?utf-8?B?a1ZyS3JzZFZ5OTdMa1ZkYmtFWndWZ29qc3ZMMWZlc1NKT0EzNjJEN3REN01r?=
 =?utf-8?B?MU5wMVl4NzhBUzNwVlh4Q3Z6RmNNUUV0NEJyakFBSW84VmE5WkJtVnMzKzN2?=
 =?utf-8?B?aVJ5andPelBKVzJlMS8wV0JxMVltYkhqOTZwK3NzeitOMzlCSmk4NStNWG4v?=
 =?utf-8?B?M3k1MzNDUFFFN3RpVHdESzVDVmZnUm1pWWhGNlloK0JDY2IxZ012ZUQ0SnRS?=
 =?utf-8?B?aWgrNmxBL0N0eFZFSTVncDdXSCt5YTZmR1VRNUd2R3hpb1BkNW4vb0V3d0hv?=
 =?utf-8?B?b3hmWHRReGthUExEN091bjVxdDQvTTFPYWsxYjk3Y0xEOENYVXBNM1A0MTdY?=
 =?utf-8?B?ZEt1ekt2SzF3WFZPWHRaekp6cEcvYU96VFlRV3ZET3dZaEMwWmVyNUlQRmVs?=
 =?utf-8?B?RitxNXB1ZWdjOWcxdW1Od05VcEc5cDl1WXNPWXZiWUVBUjQ4TU1ZU3FTbUdQ?=
 =?utf-8?B?WnE2SGNqWG9YdU5JcGkvR25Yb1RBemQvWlg1cjhtOE1CUENNMng4Ry94aC9x?=
 =?utf-8?B?VVNVdGZHVWNiN3U2VWk2ck5YcmJHa3Z5dldWTXNpRUdNd2MvWkFlTjc1d3FP?=
 =?utf-8?B?bXhtR0FITlQ5NmtCSjQ4K0ZUZmZTQUFWQ2QzUGdYU0FmOTdDZlhtNjYrNThQ?=
 =?utf-8?B?TmpIT2liYi8xQmRzK2JEdDlaWndZalNqWjFIeFZMWlc0K2tTdkdqNzVBd3p0?=
 =?utf-8?B?SDVob0hvZEMvRVZYd0FkaU9jWjVHL1RYcW1sZC9pVUd3ZXJ0d3VYT1BGYW5C?=
 =?utf-8?Q?L3G7ehEpZnzBydasaHxL2ROJtuoXC8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C951E5002D9D24381954C7AACCB1B3B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c934dd48-bb39-459c-e2a4-08da06a938a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 17:28:29.4872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4rHRAwD74oeL8HwfJZrHUTS1wtc4SdBwLUDb7i3AGmyFFJeAqzurvuTiXYX34/EQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1812
X-Proofpoint-GUID: KNperUzrPbIQJYsdxOHuAof04C98nLRV
X-Proofpoint-ORIG-GUID: KNperUzrPbIQJYsdxOHuAof04C98nLRV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_08,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTAzLTE0IGF0IDE2OjEzIC0wNzAwLCBEZWx5YW4gS3JhdHVub3Ygd3JvdGU6
DQo+IFRoYW5rcywgQW5kcmlpISBUaGUgbml0cy9yZWZhY3RvcnMgYXJlIHN0cmFpZ2h0Zm9yd2Fy
ZCBidXQgaGF2ZSBzb21lIHF1ZXN0aW9ucw0KPiBiZWxvdzoNCj4gDQo+IE9uIEZyaSwgMjAyMi0w
My0xMSBhdCAxNToyNyAtMDgwMCwgQW5kcmlpIE5ha3J5aWtvIHdyb3RlOg0KPiA+ID4gKw0KPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgLyogc2FuaXRpemUgdmFyaWFibGUgbmFtZSwgZS5n
LiwgZm9yIHN0YXRpYyB2YXJzIGluc2lkZQ0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICogYSBmdW5jdGlvbiwgaXQncyBuYW1lIGlzICc8ZnVuY3Rpb24gbmFtZT4uPHZhcmlhYmxlIG5h
bWU+JywNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAqIHdoaWNoIHdlJ2xsIHR1cm4g
aW50byBhICc8ZnVuY3Rpb24gbmFtZT5fPHZhcmlhYmxlIG5hbWU+Jy4NCj4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAqLw0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgc2FuaXRp
emVfaWRlbnRpZmllcih2YXJfaWRlbnQgKyAxKTsNCj4gPiANCj4gPiBidHcsIEkgdGhpbmsgd2Ug
ZG9uJ3QgbmVlZCBzYW5pdGl6YXRpb24gYW55bW9yZS4gV2UgbmVlZGVkIGl0IGZvcg0KPiA+IHN0
YXRpYyB2YXJpYWJsZXMgKHRoZXkgd291bGQgYmUgb2YgdGhlIGZvcm0gPGZ1bmNfbmFtZT4uPHZh
cl9uYW1lPiBmb3INCj4gPiBzdGF0aWMgdmFyaWFibGVzIGluc2lkZSB0aGUgZnVuY3Rpb25zKSwg
YnV0IG5vdyBpdCdzIGp1c3QgdW5uZWNlc3NhcnkNCj4gPiBjb21wbGljYXRpb24NCj4gDQo+IEhv
dyB3b3VsZCB3ZSBoYW5kbGUgc3RhdGljIHZhcmlhYmxlcyBpbnNpZGUgZnVuY3Rpb25zIGluIGxp
YnJhcmllcyB0aGVuPw0KDQpBaCwganVzdCByZWFsaXplZCAzMTMzMmNjYjc1NjIgKGJwZnRvb2w6
IFN0b3AgZW1pdHRpbmcgc3RhdGljIHZhcmlhYmxlcyBpbiBCUEYNCnNrZWxldG9uKSBzdG9wcGVk
IHRoYXQuIEknbGwgcmVtb3ZlIHRoZSBzYW5pdGl6YXRpb24gdGhlbi4NCg0KWy4uLl0NCg0KDQo+
ID4gd2UgZG9uJ3Qga25vdyB0aGUgbmFtZSBvZiB0aGUgZmluYWwgb2JqZWN0LCB3aHkgd291bGQg
d2UgYWxsb3cgdG8gc2V0DQo+ID4gYW55IG9iamVjdCBuYW1lIGF0IGFsbD8NCj4gDQo+IFdlIGRv
bid0IHJlYWxseSBjYXJlIGFib3V0IHRoZSBmaW5hbCBvYmplY3QgbmFtZSBidXQgd2UgZG8gbmVl
ZCBhbiBvYmplY3QgbmFtZQ0KPiBmb3IgdGhlIHN1YnNrZWxldG9uLiBUaGUgc3Vic2tlbGV0b24g
dHlwZSBuYW1lLCBoZWFkZXIgZ3VhcmQgZXRjIGFsbCB1c2UgaXQuDQo+IFdlIGNhbiBzYXkgdGhh
dCBpdCdzIGFsd2F5cyB0YWtlbiBmcm9tIHRoZSBmaWxlIG5hbWUsIGJ1dCBnaXZpbmcgdGhlIHVz
ZXIgdGhlDQo+IG9wdGlvbiB0byBvdmVycmlkZSBpdCBmZWVscyByaWdodCwgZ2l2ZW4gdGhlIHBh
cmFsbGVsIHdpdGggc2tlbGV0b25zIChhbmQgd2hhdA0KPiB3b3VsZCB3ZSBkbyBpZiB0aGUgZmls
ZSBuYW1lIGlzIGEgcGlwZSBmcm9tIGEgc3Vic2hlbGwgaW52b2NhdGlvbj8pLg0KDQpJbiBwYXJ0
aWN1bGFyLCB3aXRoIHRoZSBjdXJyZW50IHRlc3Qgc2V0dXAsIGlmIHdlIGRvbid0IHVzZSB0aGUg
bmFtZSBwYXJhbSwgd2UnZA0KZW5kIHVwIGluZmVycmluZyBuYW1lcyBsaWtlIHRlc3Rfc3Vic2tl
bGV0b25fbGliX2xpbmtlZDMgZnJvbSB0aGUgZmlsZW5hbWUuIFRoZQ0KdGVzdHMgY2FzZSBpcyBh
IGJpdCBjb250cml2ZWQgYW5kIHdlIGNhbiB3b3JrIGFyb3VuZCBpdCBidXQgdGhlcmUgbWF5IGJl
IG90aGVyDQpzaW1pbGFyIHNpdHVhdGlvbnMgb3V0IHRoZXJlLg0KDQoNCi0tIERlbHlhbg0K
