Return-Path: <bpf+bounces-12484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C11697CCE16
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 22:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48E31C20D4C
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 20:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAF42D7A6;
	Tue, 17 Oct 2023 20:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Zq+LyZXj"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E602E3F4
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 20:31:40 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8471992
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 13:31:38 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HHnI3i029582
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 13:31:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=2WMOENSkKRccQZEp65ZNBcF/F9fmJB4o267Z26WpgO4=;
 b=Zq+LyZXjGuit5RImkcrkxsriJtCH/O/ogMXJjnXcWOfQaE9rN9NopedA6MioE/7/15Am
 MJq2r9J9p3XcPVvRe5JgPxEYtfsLxt52Wn7y5doMwiUWPaFVXE4Tszgq0EcO4DuljOar
 lmVvVihV5x8wOa7KjY6RhWrxPYZCuB1ZWPeWyC66cH64Lql9OxIxD3bbuNYEJVc3Kwte
 H6Q4dI3b9fRV87nHxx+O9dQgW3ybmZZGPFCrZ3Hj0Nc/u7qK0Coa0ATPiWwBJJonI5iO
 y55jm0e+zVeYIE1n/knnyJIT8P7G3vhz2FBd/3pySUcnTWlMg/CAXJ2dbbLPZXrhh8mW Mw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ts7vj1wre-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 13:31:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vf2q50MJh9J0i/ij8oFaogYQf0J2ipgFscl5AF9XW53vARvaWy6XSnh9T5sFUEvRNMTetEQGJPTprm3srtatEmtPKtjJnsZBcXxvUk3+S7sOfAxTXO8qv8KTGAZpl2PdXT77yewjutir3ge8T3v+JJrPbuJ9Y9A7AtHbg6XkPpFG6FTCLmUJ7YLhwmhQxkBT2aZ6iSaIe26yAhslBTzbax7nO8HLs85M7d1EzN6aD2ZWVer9iiYTwfiOJBVCAtHmlLN0lvG81h7or7yQ6l9z9mPT6TdUapBjFoyOZy1AOJcf4auSBUBnDz9LTjInrPl8V5CsIMv29WMRh8XjLjmq5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WMOENSkKRccQZEp65ZNBcF/F9fmJB4o267Z26WpgO4=;
 b=Lok1twRVq3x7mJg789YAO5E+2wXo458G+V3z13aegaZCv5EGtX19ave69B1YBz57jTCKKhuViJHAm3zZ3TjV5azsTFtE/Cjn4vwyCllMH9Tk94OSo/rIMXfszymCthNLHTkuctWZcH4U/KeurQ94TUHN/h0WoRGdkX3kMeMY9aa7sH5W6UXHLfHTtoqN+rby4aThNBUCAMiwqqszjNSbICxoqoYcL1ySARcqqiiIg/QbvkhGlpY5TD85yDUhDDtUHX4YUk+YFWlIKkyJIVPu26MJfrz7tMEho1IxfdgOzcGShqsl7Gg48Aq3pwFvy/jadY6nayPirj7kDAJd4QHxqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BLAPR15MB4067.namprd15.prod.outlook.com (2603:10b6:208:271::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 20:31:31 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::526c:b078:a1d1:fba8]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::526c:b078:a1d1:fba8%4]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 20:31:31 +0000
From: Song Liu <songliubraving@meta.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        "fsverity@lists.linux.dev" <fsverity@lists.linux.dev>,
        Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team
	<kernel-team@meta.com>,
        Eric Biggers <ebiggers@kernel.org>, "tytso@mit.edu"
	<tytso@mit.edu>,
        "roberto.sassu@huaweicloud.com"
	<roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Add kfunc bpf_get_file_xattr
Thread-Topic: [PATCH bpf-next 1/5] bpf: Add kfunc bpf_get_file_xattr
Thread-Index: AQHZ/gM1jAkPDEgRp0q6fPvepF0WybBOW9CAgAAZ8IA=
Date: Tue, 17 Oct 2023 20:31:31 +0000
Message-ID: <0ABF7860-A331-4161-9599-C781E9650283@fb.com>
References: <20231013182644.2346458-1-song@kernel.org>
 <20231013182644.2346458-2-song@kernel.org>
 <CAEf4BzYbQzMU4T6KYt4UudXvZiPg4nQdQCxD9zqzoJLgqOE9bQ@mail.gmail.com>
In-Reply-To: 
 <CAEf4BzYbQzMU4T6KYt4UudXvZiPg4nQdQCxD9zqzoJLgqOE9bQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.100.2.1.4)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|BLAPR15MB4067:EE_
x-ms-office365-filtering-correlation-id: cb7379b4-aef8-4dd4-99c4-08dbcf500c94
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8PpDMz44S0WtZbDYhfs+ttcB89cc/V1Diq9G9qQ6Ctj3//0sGZvnS9bG1Lq0dCF4Rf30VqRbIGb5bt4VJtDusr0kKTvlDW4LX9Vjk5/1u1a/rfs4k6kT+nMFunwQ56V1AkUB/Ii23vuSA/SP5RUlHRpPaefxC1zyuvqkvPhEIrL9S6EerD5Lc/jH31XPXG4zU0zFOin+x3j54aoA5ymgddUqUEmctZVlhoP8VVfmfS4MQCSUVixy9d6ekv42Q1QNoDtS2YjVUSxZtJH2Gf7Dp8dnvBXz10PTy5JkwhKJYgPBguPx2x9Y+iwlQ4upfJeKQPxfo/aEqW/w2fq/oLZInU+O2uMR0mlJ6tAoK0YF5D2orj7lSCNmG92pPm0R9bSwKBRjy37c+KNU9r3NH9i99buGzKI6iGTvWp1ctbw0tXEk+9eZSFrjD2xZEi+Dpj5JsUTaS1xpoOkcwCPognBouQKDMgiMbDnWiVjrMjLCXrGaEhnCzrQOGoSeS/PoUvHQE/ZUtNPlE7ko5XqD57BarqwYQwtXjas6sj8ZVPPKRzUsMo2n2DtMJmVYYDsoMMtf895EvNBPX7aSy89PAs34nk3fYLuqUI3IbiJKa41QrMmzXCOPWhYucXo/JGfbaIytiZFWa2wZ1oX+mX4I2Ex81Q==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(366004)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66446008)(66476007)(54906003)(64756008)(6916009)(316002)(76116006)(66946007)(66556008)(2906002)(86362001)(91956017)(5660300002)(41300700001)(4326008)(8936002)(8676002)(7416002)(36756003)(9686003)(6512007)(33656002)(83380400001)(6486002)(478600001)(53546011)(38100700002)(6506007)(38070700005)(122000001)(71200400001)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SEhKUEoyS3lHWFVNc0hibzJkanlBaTdEREExaXNiSDM2NHNjT0U1dVpmaGs5?=
 =?utf-8?B?ZGszNXlnQ3lXV2gwclR4aTlja2pMOWZPM1JNb3FPNjdBeGtPcXZkREgxWlA1?=
 =?utf-8?B?L3JhZ05Pd0ZKbXpHRmR0VTQ4Njl2czZzRUpNaEhObWZRWXAxbVNmMFRWalU2?=
 =?utf-8?B?dmN6aS80YVQ4dXdEQzgrdVUwazlDeFF5MFppZ3VRNUF6a2Y5OUJWMVRjUEIy?=
 =?utf-8?B?eXVPR1QwQ01tOVZQTTh4ZUozM2c0VTZFQjBZd3lTV2tibmxPeUovSUs4UHdJ?=
 =?utf-8?B?OG83NWVsYnBpYkxmeWgycnhTRmREZStvUGNONjFvSlVUdGVUbUl2ZHQ1azJy?=
 =?utf-8?B?Y1B2Ty9MR1FOK1RqYUh6TmZEaCtUdlpzNmZoa216L0N5a3JqdE5wUXlIM29n?=
 =?utf-8?B?TGFkRmR1aW96TEJBZVZkSUYyMDdSYkszb2ZCTktGcDVvakV2YnhKd3JvdXJr?=
 =?utf-8?B?aGJyeUdienBDU2x1N3UxWkhIem1TOVhXYkp2L3Zrb3BwS1A0ZHBqclpaVisr?=
 =?utf-8?B?YkJpNUQ1anhFNXdMZzRJdG4xSkkzSlNGeGNQc3ZRRkxIQ3k4enJrK20rd3Bm?=
 =?utf-8?B?a0NONE5jU1psY2tiZE1WbVhlOHBQeG5MNUp0Vm15cmxWLy9IYkc2VUZ4SHpI?=
 =?utf-8?B?Uy9HN3B2NVArakgweEphcURzT2piTVQxbGplRTJnbmxneWVYdFJreGVBeEx6?=
 =?utf-8?B?U0NOcmhORHNaNGE3a2h1cDZjeXR4N3R0NVpNMm12RWhZbURaTUFqL2h4V0xP?=
 =?utf-8?B?Q0NlV2tKaW51ZCtkOG5sWjkvbEZha0JjakVlN2ZQclRrdGJwNlB0NmI2emdK?=
 =?utf-8?B?cEZBL1I4enFpUWpaUHRTcktNSElnQi9nYkhQUlZjbTAxQ1M5VlFPL1RlWS9w?=
 =?utf-8?B?OExoZWo4SDNXQUpkdmgyeUg4ZU01cHRqaCtCU3AvSk83WEErSGdGNnVUbEVi?=
 =?utf-8?B?b2xpODBVUkF6dktGcjU2eGZGYXNneHRNV1VhbE5RVjNONWxreVBOMUZxY2ho?=
 =?utf-8?B?OW5mc1QxMTRiU2hzS3hvZXpjaDdNVXlNSUI4L25mZDIvSDFWS3VoQ3doMk1o?=
 =?utf-8?B?TzdkSGxtazZucEYyMUs4NitVZzdZRjh6Ky9SaVhML0VTVUpiVnpBVW9VSzRO?=
 =?utf-8?B?dnVheUJidXRZVDJhVXNOUkJiYWdQVGdRUFRCZlRVTDlnVCtXd1hRd2JDVHVV?=
 =?utf-8?B?SHJIRW9nMEtFd3hiK0xLem03MmRKaWpJdkxqYm5NUlpTd3AwS0p4REJuRkt6?=
 =?utf-8?B?Q2pjU0JzZTVvZmw1TDNzRHJHSFdZa1N3QnNhL3dBQ0YybzNTcEowOXBjU216?=
 =?utf-8?B?QnFwdXN1cXZ4anFVbmxva2J2dmttakJzdnd2dGFLdUNzaVk3ODFJZVVJajQv?=
 =?utf-8?B?M1YrWEJ6NmRaVXRERFZYOHBDZlNWNHYrMDIvZERIVE9PQjJuMnIwT25WSFlV?=
 =?utf-8?B?REgwRno3R0VmT1gvallRb01WazdCRHNCQnNCdXZDbnlmY3FRRnUxcldDZW5C?=
 =?utf-8?B?UFBaTmlyZWtwMnpDYm1vRVhLbXlPVjRzczV4U3h0YzArRXluNVZYbnIwbUVQ?=
 =?utf-8?B?ZGVYcFFRNWlac2pPbEY2amxqaS9UZnhrZ2J2MmxBa05vTkUzRkNNR2JtMXdy?=
 =?utf-8?B?R0d5MlpLTGs4cTU2Sk0xbzYwUmtkelNXTUdYYmFOVEwvTVlveWk3ZnZTREpP?=
 =?utf-8?B?RWI4SFFEeEZFVkVmZ0JmUmtlRVZZdnhpN0FEMU9CRU43NmhXdkViVGpmbXpn?=
 =?utf-8?B?MG1SUVR5bnNPVjhmeHUwQVBHS0NwaHNYYzJzWlR6SndScmFQYlQ3STBIUDJ2?=
 =?utf-8?B?Um1ORjcxYlprcVlLQXp2NXhITTdiVHJHZEVJOUdyVHJGMDgvVEN0MGdyRWM2?=
 =?utf-8?B?MzJYeEptUXJ2WDRJRnNxMXZEZzczcmxmSkEzRWZ0cmpJSjhPQWFIay9RK2g0?=
 =?utf-8?B?QmQ0YlliWHRMSm5YOGRPellHY0Y2azhxd1d4Wk4wVjA5U3VHT3NBRzZra0pr?=
 =?utf-8?B?d0FObVI4QjN4Q2RmRW9jUGJ0UXBRWnJCdnZNSHZHYnd1ZE1NTm1aL2VVNVhW?=
 =?utf-8?B?UDRlbmlkUSs4L21jNHBSMXlWdXZUOXBRTEowaVBkQkhYRHVXd0Y3N3BBT0ht?=
 =?utf-8?B?ZGVESnE4c3RhZkh5Um9rZStLbGpWMUtKUWozb0F2TTcyMEFCUGRPQUF3MTFi?=
 =?utf-8?Q?MMTP0Dr6BxJWqemsEdbEyzk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EEB5485A8AB2E4BA2B6B7678932CAF0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7379b4-aef8-4dd4-99c4-08dbcf500c94
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 20:31:31.8408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DxmRCefdsUUDicZyhUmiu8RRTUYN+RpQgxtmP4AWeZQIsrn6cVikvjONkw2Y7LNUUDhjDr4qxnCzt6QXmVHIFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB4067
X-Proofpoint-GUID: evOP_GruNzN5msm3vvahbY89TXxOy3H9
X-Proofpoint-ORIG-GUID: evOP_GruNzN5msm3vvahbY89TXxOy3H9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_03,2023-10-17_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gT24gT2N0IDE3LCAyMDIzLCBhdCAxMTo1OOKAr0FNLCBBbmRyaWkgTmFrcnlpa28gPGFu
ZHJpaS5uYWtyeWlrb0BnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBPY3QgMTMsIDIw
MjMgYXQgMTE6MjnigK9BTSBTb25nIExpdSA8c29uZ0BrZXJuZWwub3JnPiB3cm90ZToNCj4+IA0K
Pj4gVGhpcyBrZnVuYyBjYW4gYmUgdXNlZCB0byByZWFkIHhhdHRyIG9mIGEgZmlsZS4NCj4+IA0K
Pj4gU2luY2UgdmZzX2dldHhhdHRyKCkgcmVxdWlyZXMgbnVsbC10ZXJtaW5hdGVkIHN0cmluZyBh
cyBpbnB1dCAibmFtZSIsIGEgbmV3DQo+PiBoZWxwZXIgYnBmX2R5bnB0cl9pc19zdHJpbmcoKSBp
cyBhZGRlZCB0byBjaGVjayB0aGUgaW5wdXQgYmVmb3JlIGNhbGxpbmcNCj4+IHZmc19nZXR4YXR0
cigpLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBTb25nIExpdSA8c29uZ0BrZXJuZWwub3JnPg0K
Pj4gLS0tDQo+PiBpbmNsdWRlL2xpbnV4L2JwZi5oICAgICAgfCAxMiArKysrKysrKysrKw0KPj4g
a2VybmVsL3RyYWNlL2JwZl90cmFjZS5jIHwgNDQgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPj4gMiBmaWxlcyBjaGFuZ2VkLCA1NiBpbnNlcnRpb25zKCspDQo+PiAN
Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2JwZi5oIGIvaW5jbHVkZS9saW51eC9icGYu
aA0KPj4gaW5kZXggNjFiZGU0NTIwZjVjLi5mMTRmYWU0NWUxM2QgMTAwNjQ0DQo+PiAtLS0gYS9p
bmNsdWRlL2xpbnV4L2JwZi5oDQo+PiArKysgYi9pbmNsdWRlL2xpbnV4L2JwZi5oDQo+PiBAQCAt
MjQ3Miw2ICsyNDcyLDEzIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBoYXNfY3VycmVudF9icGZfY3R4
KHZvaWQpDQo+PiAgICAgICAgcmV0dXJuICEhY3VycmVudC0+YnBmX2N0eDsNCj4+IH0NCj4+IA0K
Pj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBicGZfZHlucHRyX2lzX3N0cmluZyhzdHJ1Y3QgYnBmX2R5
bnB0cl9rZXJuICpwdHIpDQo+IA0KPiBpc196ZXJvX3Rlcm1pbmF0ZWQgd291bGQgYmUgbW9yZSBh
Y2N1cmF0ZT8gdGhvdWdoIHRoZXJlIGlzIG5vdGhpbmcNCj4gcmVhbGx5IGR5bnB0ci1zcGVjaWZp
YyBoZXJlLi4uDQoNCmlzX3plcm9fdGVybWluYXRlZCBzb3VuZHMgYmV0dGVyLiANCg0KPiANCj4+
ICt7DQo+PiArICAgICAgIGNoYXIgKnN0ciA9IHB0ci0+ZGF0YTsNCj4+ICsNCj4+ICsgICAgICAg
cmV0dXJuIHN0cltfX2JwZl9keW5wdHJfc2l6ZShwdHIpIC0gMV0gPT0gJ1wwJzsNCj4+ICt9DQo+
PiArDQo+PiB2b2lkIG5vdHJhY2UgYnBmX3Byb2dfaW5jX21pc3Nlc19jb3VudGVyKHN0cnVjdCBi
cGZfcHJvZyAqcHJvZyk7DQo+PiANCj4+IHZvaWQgYnBmX2R5bnB0cl9pbml0KHN0cnVjdCBicGZf
ZHlucHRyX2tlcm4gKnB0ciwgdm9pZCAqZGF0YSwNCj4+IEBAIC0yNzA4LDYgKzI3MTUsMTEgQEAg
c3RhdGljIGlubGluZSBib29sIGhhc19jdXJyZW50X2JwZl9jdHgodm9pZCkNCj4+ICAgICAgICBy
ZXR1cm4gZmFsc2U7DQo+PiB9DQo+PiANCj4+ICtzdGF0aWMgaW5saW5lIGJvb2wgYnBmX2R5bnB0
cl9pc19zdHJpbmcoc3RydWN0IGJwZl9keW5wdHJfa2VybiAqcHRyKQ0KPj4gK3sNCj4+ICsgICAg
ICAgcmV0dXJuIGZhbHNlOw0KPj4gK30NCj4+ICsNCj4+IHN0YXRpYyBpbmxpbmUgdm9pZCBicGZf
cHJvZ19pbmNfbWlzc2VzX2NvdW50ZXIoc3RydWN0IGJwZl9wcm9nICpwcm9nKQ0KPj4gew0KPj4g
fQ0KPj4gZGlmZiAtLWdpdCBhL2tlcm5lbC90cmFjZS9icGZfdHJhY2UuYyBiL2tlcm5lbC90cmFj
ZS9icGZfdHJhY2UuYw0KPj4gaW5kZXggZGY2OTdjNzRkNTE5Li45NDYyNjg1NzRlMDUgMTAwNjQ0
DQo+PiAtLS0gYS9rZXJuZWwvdHJhY2UvYnBmX3RyYWNlLmMNCj4+ICsrKyBiL2tlcm5lbC90cmFj
ZS9icGZfdHJhY2UuYw0KPj4gQEAgLTI0LDYgKzI0LDcgQEANCj4+ICNpbmNsdWRlIDxsaW51eC9r
ZXkuaD4NCj4+ICNpbmNsdWRlIDxsaW51eC92ZXJpZmljYXRpb24uaD4NCj4+ICNpbmNsdWRlIDxs
aW51eC9uYW1laS5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9maWxlYXR0ci5oPg0KPj4gDQo+PiAj
aW5jbHVkZSA8bmV0L2JwZl9za19zdG9yYWdlLmg+DQo+PiANCj4+IEBAIC0xNDI5LDYgKzE0MzAs
NDkgQEAgc3RhdGljIGludCBfX2luaXQgYnBmX2tleV9zaWdfa2Z1bmNzX2luaXQodm9pZCkNCj4+
IGxhdGVfaW5pdGNhbGwoYnBmX2tleV9zaWdfa2Z1bmNzX2luaXQpOw0KPj4gI2VuZGlmIC8qIENP
TkZJR19LRVlTICovDQo+PiANCj4+ICsvKiBmaWxlc3lzdGVtIGtmdW5jcyAqLw0KPj4gK19fZGlh
Z19wdXNoKCk7DQo+PiArX19kaWFnX2lnbm9yZV9hbGwoIi1XbWlzc2luZy1wcm90b3R5cGVzIiwN
Cj4+ICsgICAgICAgICAgICAgICAgICJrZnVuY3Mgd2hpY2ggd2lsbCBiZSB1c2VkIGluIEJQRiBw
cm9ncmFtcyIpOw0KPj4gKw0KPj4gKy8qKg0KPj4gKyAqIGJwZl9nZXRfZmlsZV94YXR0ciAtIGdl
dCB4YXR0ciBvZiBhIGZpbGUNCj4+ICsgKiBAbmFtZV9wdHI6IG5hbWUgb2YgdGhlIHhhdHRyDQo+
PiArICogQHZhbHVlX3B0cjogb3V0cHV0IGJ1ZmZlciBvZiB0aGUgeGF0dHIgdmFsdWUNCj4+ICsg
Kg0KPj4gKyAqIEdldCB4YXR0ciAqbmFtZV9wdHIqIG9mICpmaWxlKiBhbmQgc3RvcmUgdGhlIG91
dHB1dCBpbiAqdmFsdWVfcHRyKi4NCj4+ICsgKg0KPj4gKyAqIFJldHVybjogMCBvbiBzdWNjZXNz
LCBhIG5lZ2F0aXZlIHZhbHVlIG9uIGVycm9yLg0KPj4gKyAqLw0KPj4gK19fYnBmX2tmdW5jIGlu
dCBicGZfZ2V0X2ZpbGVfeGF0dHIoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBicGZfZHlucHRy
X2tlcm4gKm5hbWVfcHRyLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
dHJ1Y3QgYnBmX2R5bnB0cl9rZXJuICp2YWx1ZV9wdHIpDQo+PiArew0KPj4gKyAgICAgICBpZiAo
IWJwZl9keW5wdHJfaXNfc3RyaW5nKG5hbWVfcHRyKSkNCj4+ICsgICAgICAgICAgICAgICByZXR1
cm4gLUVJTlZBTDsNCj4gDQo+IHNvIGR5bnB0ciBjYW4gYmUgaW52YWxpZCBhbmQgbmFtZV9wdHIt
PmRhdGEgd2lsbCBiZSBOVUxMLCB5b3Ugc2hvdWxkDQo+IGFjY291bnQgZm9yIHRoYXQNCg0KV2Ug
Y2FuIGFkZCBhIE5VTEwgY2hlY2sgKG9yIHNpemUgY2hlY2spIGhlcmUuIA0KDQo+IA0KPiBhbmQg
dGhlcmUgY291bGQgYWxzbyBiZSBzcGVjaWFsIGR5bnB0cnMgdGhhdCBkb24ndCBoYXZlIGNvbnRp
Z3VvdXMNCj4gbWVtb3J5IHJlZ2lvbiwgc28gc29tZWhvdyB5b3UnZCBuZWVkIHRvIHRha2UgY2Fy
ZSBvZiB0aGF0IGFzIHdlbGwNCg0KV2UgY2FuIHJlcXVpcmUgdGhlIGR5bnB0ciB0byBiZSBCUEZf
RFlOUFRSX1RZUEVfTE9DQUwuIEkgZG9uJ3QgdGhpbmsNCndlIG5lZWQgdGhpcyBmb3IgZHlucHRy
IG9mIHNrYiBvciB4ZHAuIFdvdWxkIHRoaXMgYmUgc3VmZmljaWVudD8NCg0KVGhhbmtzLA0KU29u
Zw0KDQo+IA0KPj4gKw0KPj4gKyAgICAgICByZXR1cm4gdmZzX2dldHhhdHRyKG1udF9pZG1hcChm
aWxlLT5mX3BhdGgubW50KSwgZmlsZV9kZW50cnkoZmlsZSksIG5hbWVfcHRyLT5kYXRhLA0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgIHZhbHVlX3B0ci0+ZGF0YSwgX19icGZfZHlucHRy
X3NpemUodmFsdWVfcHRyKSk7DQo+PiArfQ0KDQo=

