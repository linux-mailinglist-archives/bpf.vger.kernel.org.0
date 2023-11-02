Return-Path: <bpf+bounces-14003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3323E7DF9C3
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 19:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD500280D2C
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 18:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24392111C;
	Thu,  2 Nov 2023 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="dUjs0doi"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A0D2134A
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 18:16:26 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7B911B
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 11:16:21 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2Gs7Md011436
	for <bpf@vger.kernel.org>; Thu, 2 Nov 2023 11:16:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=YFXrFwgvUbjynfdiTXMBbseWJfBYjtZd7rLyDUvIx9I=;
 b=dUjs0doizrAcYLhkT+pb78tlwEZpEylSvq2FlRm3l15XrVt4Zp+ocN76TeqPTWBHw/t9
 U+QhChKoQ3DBcvBf2n0yVfoZK7QpPadjFSXuoygy89KGwoL1cxnFjuYheJyEWu3I8zrA
 AfayFzHBzxFw8TxIt3CuwXAdC3uYFExyTcY1fyQza/W/r1JcnGOOezXH2jcsyFSWeM8H
 ZTXqi6ya/I0WMuc5IwHwbgJgjrL+hnQKTFwmbohMU7r8fiLQDm6QnySbbPKvOutPcMyW
 vvJNl3bCev31MxHcbxiYpMsGbsOdHdx6q8BjyPQjeRhCvkUgHHY5A/Il6238Y7EPrh5N ZQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u46jkm4d1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 11:16:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdC9+hgCpVJdEy0R3ZBeF/FuHuDuu6kPoQ3AUhvWe2YphNdyh24fAyOc6xK4OCKXdR01Tz5dsdPA87JHMejuqrjZ49/azfYWIO6vxnzdrwFYGOg9AopvMXGPaW2aGt6ZtjG+mATvnAujXCnQhG9mJnO4aBTOku/UBSnr2mBXCDWtRfQLW/yW2g6xNk8eGggA525/C+dXRkymu7U2+88eBcVm1FqRcgAp/UF/58G/gV06I8XH2ywit+xw7UZKOLbIl4SJvWmbA/37jLRpAvhvlZWTSjXmx3wkyfMFVaQKlGyGy1DhvwnnZMtFZxmndww21MCJJZQBadiYdDggOlZfvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFXrFwgvUbjynfdiTXMBbseWJfBYjtZd7rLyDUvIx9I=;
 b=k9rIHZstOj4AS4KoLmgiFFaZr3PaomYe5GbQZh82p7Jn+U02Ok5B/Kh5ePUjl5BP9FpQLQBIAAPfUu72Tr8TYTldy7sNMeXFkOs5kE6Lk1cHQebBWntA1agI21GyNeqceY79JeDPx4WsixkyNnWPiTb40PeAnLm6vAXvUJgTNgdKcuGJPwPXwddHVRkswzZKUWF25re7bx/N8oIPQ7ZVe3dC2c8eBxNnxuzdhxP+V8yBNCOShYmIRrm9Qw9qjSypPiphBaEmTcVMjO4K7ixdJO1fmh5AwKNh4VxP52xFyxtskE/bQSauHOlNGxJibAdiFGXeHDQfyLz00OQ0pFjh4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5117.namprd15.prod.outlook.com (2603:10b6:510:c4::8)
 by SA0PR15MB3821.namprd15.prod.outlook.com (2603:10b6:806:8e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 18:16:17 +0000
Received: from PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::9255:45ad:aadf:e172]) by PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::9255:45ad:aadf:e172%6]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 18:16:17 +0000
From: Song Liu <songliubraving@meta.com>
To: Song Liu <songliubraving@meta.com>
CC: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Song Liu <song@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "fsverity@lists.linux.dev"
	<fsverity@lists.linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel
 Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin
 KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Eric
 Biggers <ebiggers@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        "roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH v6 bpf-next 1/9] bpf: Expose bpf_dynptr_slice* kfuncs for
 in kernel use
Thread-Topic: [PATCH v6 bpf-next 1/9] bpf: Expose bpf_dynptr_slice* kfuncs for
 in kernel use
Thread-Index: AQHaBtWtXGZzUbSmaEqOAh6YLQP6IbBnTUAAgAADvYCAAAHqAIAADs0AgAAB6wA=
Date: Thu, 2 Nov 2023 18:16:17 +0000
Message-ID: <B1DDF0D9-5365-4421-83AF-E7F6C0439422@fb.com>
References: <20231024235551.2769174-1-song@kernel.org>
 <20231024235551.2769174-2-song@kernel.org>
 <CAEf4Bzbr8dgksh2z+4nEkAFdV9gquhR+HROULKdTkWrUpSM9-Q@mail.gmail.com>
 <CAEf4BzbDFDX30Y_Hcmd__hgDp+m6X+htr-wTeBtaoauEnrEdLw@mail.gmail.com>
 <CAEf4BzaD+FV_PM8_4yWnZVed9pXE-KX6CwpYEmiUDpMRQDNEXQ@mail.gmail.com>
 <15A85D6B-56E5-4C9F-B7AB-A62F3DA8294C@fb.com>
In-Reply-To: <15A85D6B-56E5-4C9F-B7AB-A62F3DA8294C@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.100.2.1.4)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5117:EE_|SA0PR15MB3821:EE_
x-ms-office365-filtering-correlation-id: e8309296-e09a-4c7c-fef8-08dbdbcfce8f
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 xALUCp3kYePbeqb3Sk0hda0p+7FmMwIY6xGE+P8BFXDcjXOfQNAXgjRyuJLLtAtk+UcuPgWQnehBbvzy2JW1d1wfkzSiFwmNavDIkCMXHPCOUiNdhdSri5PsL7Z9h6DPYJ877msj79tI2nuWPrD85WFF41B/wBqzNfC2og4lZKAmbJeBE4RoWRWp81DRit541TTauxn2oHW3u/h6GvAMhdkG5iu7tztFXlnNAyd8SDxDcYRhy5/LlDnfmX8jxPOSFwTjnq+kzm0xtqJR8yLoJmrtq6Cy07fx21LZl78zaRFrV31hLas1MLFKHkCfhJhDrP2QnFAJIla1wRhBanEFN48I0bYXBd578YDtttuVG3koEGKAbJsbj9r/28TKjyLW+5rfGUR+biqUk1rMjHa6iJDvGJnzorZAL7MFRG/HCBTYBRHOfH98BTB3qn02K/JjN1nuOqiA8XrrPj22oLoF9w3dO6ftL8wtoMeD1qBg7XguM7csWHm0vQ5sVYbqr8UHkz8UQF0SYrvLn/PH9P48pTtuLBz80wMMv+nJNAWyVbrVTS8WeE1PmdKRUkKRm35OH6v7Uh2M1PHiPyjDF4w9qUYod/BN29zJbNE2hYd66Z421Y505RppxzVwx7lC0lXT
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5117.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(6486002)(66946007)(66476007)(66556008)(66446008)(64756008)(91956017)(54906003)(6506007)(316002)(76116006)(53546011)(478600001)(33656002)(36756003)(86362001)(9686003)(6512007)(8936002)(83380400001)(8676002)(6862004)(7416002)(4326008)(2906002)(41300700001)(5660300002)(38070700009)(71200400001)(38100700002)(6200100001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YnQ3RVNmNHk1Y2VlYmJ5eVVCUi9MWTZwelRnTnV2Sk53WE9md0pJcnJlTHo0?=
 =?utf-8?B?SkEvQzhqK3pjODNpeU1TcUdqS2poazgrTHM5alFlWlJ6UkV4WjNhWVBIWFgr?=
 =?utf-8?B?UVBsNnhuZ0RwWWFCWkUwU241MXRZSlBMV0taYnlyVjM4OHV1ZkRKYTlsSllF?=
 =?utf-8?B?ZnA5WmE2cW5iSTA0cHN4YXQ4U3ZSTVUwOHlWdStDRENiMUtUSjBxcDl6aFNZ?=
 =?utf-8?B?MXJNRnhsdFBuK2NzTFdDWkh2UU1ERmwydThzbW81Zk5zQlJVOGJsYjBKdHdk?=
 =?utf-8?B?UXY1MFFWalJwV016eHVJRjdMeEd2Vm1LSkJuRDA2WWpHRXNjVVpNSUxjYlJ4?=
 =?utf-8?B?SlpKclRib2QwWEUxSWNscmVML3hXVU5Kelk2V0FSeWRvejdSd2ZxYlErYzdN?=
 =?utf-8?B?MGtCRncwQ2FvOWxHMVFxNEZURFpEY0J1V0hDeDdOUkdEb3dmT3ZqMjkyamZ4?=
 =?utf-8?B?eU8xNytsT3ZqQUZhRi9lWlJ1eDdEVUI3QnhydlpEWmpUZW8yd3c2MEtKNXR2?=
 =?utf-8?B?dE5DS0dnNzNEM3dKRndvUlR0TjcyZVdqd1ZWcGQ0QnlxNEx3THcrQ1R3dy82?=
 =?utf-8?B?ZTJyTEtmcVBLcEpaODlRd0RPYTF3NXNPajVrTCs5QnFPM01Fc1J3YjB3ek4w?=
 =?utf-8?B?Q0dPVjVOblNJZERIYVY3T2JuQzZibkxnTFhtaFZLMDl1d3ZNNHJiWDZWRFJJ?=
 =?utf-8?B?YkJvVkpoYTNKdkFIcnQrWk1sTUw3YXVxSGZQRG82dm15dXBSeGJyMlNGdXl2?=
 =?utf-8?B?UlZ5QU5UR0locVpBaXp2T0pSZ28zQnJzMENOaktLZit6Zk9qVTZTUmZwbDZi?=
 =?utf-8?B?RTY2Ylk1WGd2Q3FGVS85QVlqK3RFaFowcFdzd1NRY1MyUnZzVWVYT2lyZzZE?=
 =?utf-8?B?Qjg5bUtXU2tMYkErdTlkbzI1ZlFnV1dWajRxei9IRXB3QTJYL0Fha2V5QlRj?=
 =?utf-8?B?SWxONEhYU1ZiN1BBaHVxR3pBSDE3UFNGeUYwcUJDQWx5VWpHMFRhWmdTSjJk?=
 =?utf-8?B?bFFyVDZpM0JnV0NkV3N3NmtWWDJsdEhEOFZ3NE1yL0ZwWTBUbWxMVHRiYjdw?=
 =?utf-8?B?a3BqVUhJdFRsNDg4bGZqSVMrdlJRTXN1MnFvamZmN2cyNFZGTWpQeDc4ODlM?=
 =?utf-8?B?M3JleGZOcllpcDV3YXYxTEREYXFOdmUza2JBeHFvYnJBTzVRVWs0ZmJLdTlD?=
 =?utf-8?B?VVI1bFNxRG00K1dkTXd2ajFaNWpUWlR5ZzNBVk84ejI2RElWOU9HOVlWOGVq?=
 =?utf-8?B?ZStoYllJVnRibzNHdjV2ZjdUWG5WdDdrSkR4SGJ0L3JPQ0djWTdQazgwSmIx?=
 =?utf-8?B?bjQwK29lTlY0RWFZZHZGSFhwTGYyMHEyTEhpcEliV2dRWXB0WkZxekZmVnlW?=
 =?utf-8?B?bDFQQU5WQWlMSjNtb2NwZUtjSW1JVk55cEt1WDNkMTAzcFZpTTNXM3ljR0Rh?=
 =?utf-8?B?cUwzUThNOUFmM2xVTkRxOThGVDF6U2NqYUZqdjg5TURpZVlnU1E0aDZGOG5T?=
 =?utf-8?B?ZW5mWmpxRWN4NlZ4SWlvbHN2bk9sSnFvZWpYamY2RnY5a1oxQjhqWC9nYmxh?=
 =?utf-8?B?c3ZXdFgvTVhrdGF3d01FdDRNeXE4aTQvTlBVK2lydFJnM0FkbzRJVjZRUW1S?=
 =?utf-8?B?QVZ2ZDZaUS8ramdnN1FkcytjMzBTSnhWTURPS0hLclkrQklDRzNEWDVmNXd5?=
 =?utf-8?B?YUNHVXRGd1dmVEtTeXBDQUJxTEhUSU9abFBHbkw5LzNpWUx1UVgzclN3dnlq?=
 =?utf-8?B?RzZCc2ZIMFltY3lrOFZIQXdIQU9FRjl0NHJyRUlLREQ1VSswanhRWVBQRXpk?=
 =?utf-8?B?ZGwxTi9HdjJJME1mYVVnazRUQk5nZ2NaQlNuQVdOcDJJNHdJaFFaY1lzR3Vj?=
 =?utf-8?B?WjA3bFc1cExJdVpxZHpSZmtSTk1Xcm15SjljWEZrVFdjdU1ZU0YzRDQ2cmJ2?=
 =?utf-8?B?REIrbU4weXpSVi9DajFpUEV1OERFc0k3MTJJczIwN3V4OUFUVHYyMEpDUGFh?=
 =?utf-8?B?Wi9MOGFzaFVWYm1EcVB5MWtCZThCS2pwcFBLa1g0UEhDU3B4QmhBeHVwdnRN?=
 =?utf-8?B?ZlNKejVya1YxckxPbG4zT3l5MzhlRWFkVWRhMFJkRkFaOU5MOGNPSThRREVr?=
 =?utf-8?B?Zm9DS05GTGc3cHNkcFBTclV4MUxrWExzSnFOWXJmNDhTVXRVdDh2TzhDNzc1?=
 =?utf-8?Q?HdXfq+ebyVJ8SDU1PIn/bAE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F93F989ACC796142B9445F740A78A25B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5117.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8309296-e09a-4c7c-fef8-08dbdbcfce8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 18:16:17.3073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vXN2dT5r4TWeRp7U2UlA56eLno4AXPyRsAY3JqioRTvMJT0X3Ey4qv0KK5br1yyubQa+TunpJr2IwJ2ZdxOqxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3821
X-Proofpoint-ORIG-GUID: JxT6rFJ-5fSU1nvLl9k69Ezz3KQZ_TC0
X-Proofpoint-GUID: JxT6rFJ-5fSU1nvLl9k69Ezz3KQZ_TC0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_08,2023-11-02_03,2023-05-22_02

DQoNCj4gT24gTm92IDIsIDIwMjMsIGF0IDExOjA54oCvQU0sIFNvbmcgTGl1IDxzb25nbGl1YnJh
dmluZ0BtZXRhLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+PiBPbiBOb3YgMiwgMjAyMywgYXQg
MTA6MTbigK9BTSwgQW5kcmlpIE5ha3J5aWtvIDxhbmRyaWkubmFrcnlpa29AZ21haWwuY29tPiB3
cm90ZToNCj4+IA0KPj4gT24gVGh1LCBOb3YgMiwgMjAyMyBhdCAxMDowOeKAr0FNIEFuZHJpaSBO
YWtyeWlrbw0KPj4gPGFuZHJpaS5uYWtyeWlrb0BnbWFpbC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+
IE9uIFRodSwgTm92IDIsIDIwMjMgYXQgOTo1NuKAr0FNIEFuZHJpaSBOYWtyeWlrbw0KPj4+IDxh
bmRyaWkubmFrcnlpa29AZ21haWwuY29tPiB3cm90ZToNCj4+Pj4gDQo+Pj4+IE9uIFR1ZSwgT2N0
IDI0LCAyMDIzIGF0IDQ6NTbigK9QTSBTb25nIExpdSA8c29uZ0BrZXJuZWwub3JnPiB3cm90ZToN
Cj4+Pj4+IA0KPj4+Pj4ga2Z1bmNzIGJwZl9keW5wdHJfc2xpY2UgYW5kIGJwZl9keW5wdHJfc2xp
Y2VfcmR3ciBhcmUgdXNlZCBieSBCUEYgcHJvZ3JhbXMNCj4+Pj4+IHRvIGFjY2VzcyB0aGUgZHlu
cHRyIGRhdGEuIFRoZXkgYXJlIGFsc28gdXNlZnVsIGZvciBpbiBrZXJuZWwgZnVuY3Rpb25zDQo+
Pj4+PiB0aGF0IGFjY2VzcyBkeW5wdHIgZGF0YSwgZm9yIGV4YW1wbGUsIGJwZl92ZXJpZnlfcGtj
czdfc2lnbmF0dXJlLg0KPj4+Pj4gDQo+Pj4+PiBBZGQgYnBmX2R5bnB0cl9zbGljZSBhbmQgYnBm
X2R5bnB0cl9zbGljZV9yZHdyIHRvIGJwZi5oIHNvIHRoYXQga2VybmVsDQo+Pj4+PiBmdW5jdGlv
bnMgY2FuIHVzZSB0aGVtIGluc3RlYWQgb2YgYWNjZXNzaW5nIGR5bnB0ci0+ZGF0YSBkaXJlY3Rs
eS4NCj4+Pj4+IA0KPj4+Pj4gVXBkYXRlIGJwZl92ZXJpZnlfcGtjczdfc2lnbmF0dXJlIHRvIHVz
ZSBicGZfZHlucHRyX3NsaWNlIGluc3RlYWQgb2YNCj4+Pj4+IGR5bnB0ci0+ZGF0YS4NCj4+Pj4+
IA0KPj4+Pj4gQWxzbywgdXBkYXRlIHRoZSBjb21tZW50cyBmb3IgYnBmX2R5bnB0cl9zbGljZSBh
bmQgYnBmX2R5bnB0cl9zbGljZV9yZHdyDQo+Pj4+PiB0aGF0IHRoZXkgbWF5IHJldHVybiBlcnJv
ciBwb2ludGVycyBmb3IgQlBGX0RZTlBUUl9UWVBFX1hEUC4NCj4+Pj4+IA0KPj4+Pj4gU2lnbmVk
LW9mZi1ieTogU29uZyBMaXUgPHNvbmdAa2VybmVsLm9yZz4NCj4+Pj4+IC0tLQ0KPj4+Pj4gaW5j
bHVkZS9saW51eC9icGYuaCAgICAgIHwgIDQgKysrKw0KPj4+Pj4ga2VybmVsL2JwZi9oZWxwZXJz
LmMgICAgIHwgMTYgKysrKysrKystLS0tLS0tLQ0KPj4+Pj4ga2VybmVsL3RyYWNlL2JwZl90cmFj
ZS5jIHwgMTUgKysrKysrKysrKystLS0tDQo+Pj4+PiAzIGZpbGVzIGNoYW5nZWQsIDIzIGluc2Vy
dGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPj4+Pj4gDQo+Pj4+PiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC9icGYuaCBiL2luY2x1ZGUvbGludXgvYnBmLmgNCj4+Pj4+IGluZGV4IGI0ODI1
ZDNjZGIyOS4uM2VkM2FlMzdjYmRmIDEwMDY0NA0KPj4+Pj4gLS0tIGEvaW5jbHVkZS9saW51eC9i
cGYuaA0KPj4+Pj4gKysrIGIvaW5jbHVkZS9saW51eC9icGYuaA0KPj4+Pj4gQEAgLTEyMjIsNiAr
MTIyMiwxMCBAQCBlbnVtIGJwZl9keW5wdHJfdHlwZSB7DQo+Pj4+PiANCj4+Pj4+IGludCBicGZf
ZHlucHRyX2NoZWNrX3NpemUodTMyIHNpemUpOw0KPj4+Pj4gdTMyIF9fYnBmX2R5bnB0cl9zaXpl
KGNvbnN0IHN0cnVjdCBicGZfZHlucHRyX2tlcm4gKnB0cik7DQo+Pj4+PiArdm9pZCAqYnBmX2R5
bnB0cl9zbGljZShjb25zdCBzdHJ1Y3QgYnBmX2R5bnB0cl9rZXJuICpwdHIsIHUzMiBvZmZzZXQs
DQo+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKmJ1ZmZlcl9fb3B0LCB1MzIgYnVm
ZmVyX19zemspOw0KPj4+Pj4gK3ZvaWQgKmJwZl9keW5wdHJfc2xpY2VfcmR3cihjb25zdCBzdHJ1
Y3QgYnBmX2R5bnB0cl9rZXJuICpwdHIsIHUzMiBvZmZzZXQsDQo+Pj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdm9pZCAqYnVmZmVyX19vcHQsIHUzMiBidWZmZXJfX3N6ayk7DQo+Pj4+
PiANCj4+Pj4+ICNpZmRlZiBDT05GSUdfQlBGX0pJVA0KPj4+Pj4gaW50IGJwZl90cmFtcG9saW5l
X2xpbmtfcHJvZyhzdHJ1Y3QgYnBmX3RyYW1wX2xpbmsgKmxpbmssIHN0cnVjdCBicGZfdHJhbXBv
bGluZSAqdHIpOw0KPj4+Pj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvaGVscGVycy5jIGIva2Vy
bmVsL2JwZi9oZWxwZXJzLmMNCj4+Pj4+IGluZGV4IGU0NmFjMjg4YTEwOC4uYWY1MDU5ZjExZTgz
IDEwMDY0NA0KPj4+Pj4gLS0tIGEva2VybmVsL2JwZi9oZWxwZXJzLmMNCj4+Pj4+ICsrKyBiL2tl
cm5lbC9icGYvaGVscGVycy5jDQo+Pj4+PiBAQCAtMjI3MCwxMCArMjI3MCwxMCBAQCBfX2JwZl9r
ZnVuYyBzdHJ1Y3QgdGFza19zdHJ1Y3QgKmJwZl90YXNrX2Zyb21fcGlkKHMzMiBwaWQpDQo+Pj4+
PiAqIGJwZl9keW5wdHJfc2xpY2Ugd2lsbCBub3QgaW52YWxpZGF0ZSBhbnkgY3R4LT5kYXRhL2Rh
dGFfZW5kIHBvaW50ZXJzIGluDQo+Pj4+PiAqIHRoZSBicGYgcHJvZ3JhbS4NCj4+Pj4+ICoNCj4+
Pj4+IC0gKiBSZXR1cm46IE5VTEwgaWYgdGhlIGNhbGwgZmFpbGVkIChlZyBpbnZhbGlkIGR5bnB0
ciksIHBvaW50ZXIgdG8gYSByZWFkLW9ubHkNCj4+Pj4+IC0gKiBkYXRhIHNsaWNlIChjYW4gYmUg
ZWl0aGVyIGRpcmVjdCBwb2ludGVyIHRvIHRoZSBkYXRhIG9yIGEgcG9pbnRlciB0byB0aGUgdXNl
cg0KPj4+Pj4gLSAqIHByb3ZpZGVkIGJ1ZmZlciwgd2l0aCBpdHMgY29udGVudHMgY29udGFpbmlu
ZyB0aGUgZGF0YSwgaWYgdW5hYmxlIHRvIG9idGFpbg0KPj4+Pj4gLSAqIGRpcmVjdCBwb2ludGVy
KQ0KPj4+Pj4gKyAqIFJldHVybjogTlVMTCBvciBlcnJvciBwb2ludGVyIGlmIHRoZSBjYWxsIGZh
aWxlZCAoZWcgaW52YWxpZCBkeW5wdHIpLCBwb2ludGVyDQo+Pj4+IA0KPj4+PiBIb2xkIG9uLCBu
b3BlLCB0aGlzIG9uZSBzaG91bGRuJ3QgcmV0dXJuIGVycm9yIHBvaW50ZXIgYmVjYXVzZSBpdCdz
DQo+Pj4+IHVzZWQgZnJvbSBCUEYgcHJvZ3JhbSBzaWRlIGFuZCBCUEYgcHJvZ3JhbSBpcyBjaGVj
a2luZyBmb3IgTlVMTCBvbmx5Lg0KPj4+PiBEb2VzIGl0IGFjdHVhbGx5IHJldHVybiBlcnJvciBw
b2ludGVyLCB0aG91Z2g/DQo+IA0KPiBSaWdodC4ga2Z1bmMgc2hvdWxkIG5vdCByZXR1cm4gZXJy
b3IgcG9pbnRlci4gDQo+IA0KPj4+IA0KPj4+IFNvIEkganVzdCBjaGVja2VkIHRoZSBjb2RlIChz
aG91bGQgaGF2ZSBkb25lIGl0IGJlZm9yZSByZXBseWluZywNCj4+PiBzb3JyeSkuIEl0IGlzIGEg
YnVnIHRoYXQgc2xpcHBlZCB0aHJvdWdoIHdoZW4gYWRkaW5nIGJwZl94ZHBfcG9pbnRlcigpDQo+
Pj4gdXNhZ2UuIFdlIHNob3VsZCBhbHdheXMgcmV0dXJuIE5VTEwgZnJvbSB0aGlzIGtmdW5jIG9u
IGVycm9yDQo+Pj4gY29uZGl0aW9ucy4gTGV0J3MgZml4IGl0IHNlcGFyYXRlbHksIGJ1dCBwbGVh
c2UgZG9uJ3QgY2hhbmdlIHRoZQ0KPj4+IGNvbW1lbnRzLg0KPj4+IA0KPj4+PiANCj4+Pj4gSSdt
IGdlbmVyYWxseSBza2VwdGljYWwgb2YgYWxsb3dpbmcgdG8gY2FsbCBrZnVuY3MgZGlyZWN0bHkg
ZnJvbQ0KPj4+PiBpbnRlcm5hbCBrZXJuZWwgY29kZSwgdGJoLCBhbmQgY29uY2VybnMgbGlrZSB0
aGlzIGFyZSBvbmUgcmVhc29uIHdoeS4NCj4+Pj4gQlBGIHZlcmlmaWVyIHNldHMgdXAgdmFyaW91
cyBjb25kaXRpb25zIHRoYXQga2Z1bmNzIGhhdmUgdG8gZm9sbG93LA0KPj4+PiBhbmQgaXQgc2Vl
bXMgZXJyb3ItcHJvbmUgdG8gbWl4IHRoaXMgdXAgd2l0aCBpbnRlcm5hbCBrZXJuZWwgdXNhZ2Uu
DQo+Pj4+IA0KPj4+IA0KPj4+IFJlYWRpbmcgYnBmX2R5bnB0cl9zbGljZV9yZHdyIGNvZGUsIGl0
IGRvZXMgbG9vayBleGFjdGx5IGxpa2Ugd2hhdCB5b3UNCj4+PiB3YW50LCBkZXNwaXRlIHRoZSBj
b25mdXNpbmdseS1sb29raW5nIDAsIE5VTEwsIDAgYXJndW1lbnRzLiBTbyBJIGd1ZXNzDQo+Pj4g
SSdtIGZpbmUgZXhwb3NpbmcgaXQgZGlyZWN0bHksIGJ1dCBpdCBzdGlsbCBmZWVscyBsaWtlIGl0
IHdpbGwgYml0ZSB1cw0KPj4+IGF0IHNvbWUgcG9pbnQgbGF0ZXIuDQo+PiANCj4+IE9rLCBub3cg
SSdtIGF0IHBhdGNoICM1LiBUaGluayBhYm91dCB3aGF0IHlvdSBhcmUgZG9pbmcgaGVyZS4gWW91
IGFyZQ0KPj4gYXNraW5nIGJwZl9keW5wdHJfc2xpY2VfcmRydygpIGlmIHlvdSBjYW4gZ2V0IGEg
ZGlyZWN0bHkgd3JpdGFibGUNCj4+IHBvaW50ZXIgdG8gYSBkYXRhIGFyZWEgb2YgbGVuZ3RoICp6
ZXJvKi4gU28gaWYgaXQncyBTS0IsIGZvciBleGFtcGxlLA0KPj4gdGhlbiB5ZWFoLCB5b3UnbGwg
YmUgZ3JhbnRlZCBhIHBvaW50ZXIuIEJ1dCB0aGVuIHlvdSBhcmUgcHJvY2VlZGluZyB0bw0KPj4g
d3JpdGUgdXAgdG8gc2l6ZW9mKHN0cnVjdCBmc3Zlcml0eV9kaWdlc3QpIGJ5dGVzLCBhbmQgdGhh
dCBjYW4gY3Jvc3MNCj4+IGludG8gbm9uLWNvbnRpZ3VvdXMgbWVtb3J5Lg0KDQpCeSB0aGUgd2F5
LCB0aGUgc3ludGF4IGFuZCBjb21tZW50IG9mIGJwZl9keW5wdHJfc2xpY2UoKSBpcyBjb25mdXNp
bmc6DQoNCiAqIEBidWZmZXJfX29wdDogVXNlci1wcm92aWRlZCBidWZmZXIgdG8gY29weSBjb250
ZW50cyBpbnRvLiAgTWF5IGJlIE5VTEwNCiAqIEBidWZmZXJfX3N6azogU2l6ZSAoaW4gYnl0ZXMp
IG9mIHRoZSBidWZmZXIgaWYgcHJlc2VudC4gVGhpcyBpcyB0aGUNCiAqICAgICAgICAgICAgICAg
bGVuZ3RoIG9mIHRoZSByZXF1ZXN0ZWQgc2xpY2UuIFRoaXMgbXVzdCBiZSBhIGNvbnN0YW50Lg0K
DQpJdCByZWFkcyAodG8gbWUpIGFzLCAiaWYgYnVmZmVyX19vcHQgaXMgTlVMTCwgYnVmZmVyX19z
emsgc2hvdWxkIGJlIDAiLiANCg0KSXMgdGhpcyBqdXN0IG15IGNvbmZ1c2lvbiwgb3IgaXMgdGhl
cmUgYSByZWFsIGlzc3VlPyANCg0KVGhhbmtzLA0KU29uZw0KDQoNCj4+IA0KPj4gU28gSSdsbCB0
YWtlIGl0IGJhY2ssIGxldCdzIG5vdCBleHBvc2UgdGhpcyBrZnVuYyBkaXJlY3RseSB0byBrZXJu
ZWwNCj4+IGNvZGUuIExldCdzIGhhdmUgYSBzZXBhcmF0ZSBpbnRlcm5hbCBoZWxwZXIgdGhhdCB3
aWxsIHJldHVybiBlaXRoZXINCj4+IHZhbGlkIHBvaW50ZXIgb3IgTlVMTCBmb3IgYSBnaXZlbiBk
eW5wdHIsIGJ1dCB3aWxsIHJlcXVpcmUgdmFsaWQNCj4+IG5vbi16ZXJvIG1heCBzaXplLiBTb21l
dGhpbmcgd2l0aCB0aGUgc2lnbmF0dXJlIGxpa2UgYmVsb3cNCj4+IA0KPj4gdm9pZCAqIF9fYnBm
X2R5bnB0cl9kYXRhX3J3KGNvbnN0IHN0cnVjdCBicGZfZHlucHRyX2tlcm4gKnB0ciwgdTMyIGxl
bik7DQo+PiANCj4+IElmIHB0ciBjYW4gcHJvdmlkZSBhIGRpcmVjdCBwb2ludGVyIHRvIG1lbW9y
eSBvZiBsZW5ndGggKmxlbiosIGdyZWF0Lg0KPj4gSWYgbm90LCByZXR1cm4gTlVMTC4gVGhpcyB3
aWxsIGJlIGFuIGFwcHJvcHJpYXRlIGludGVybmFsIEFQSSBmb3IgYWxsDQo+PiB0aGUgdXNlIGNh
c2VzIHlvdSBhcmUgYWRkaW5nIHdoZXJlIHdlIHdpbGwgYmUgd3JpdGluZyBiYWNrIGludG8gZHlu
cHRyDQo+PiBmcm9tIG90aGVyIGtlcm5lbCBBUElzIHdpdGggdGhlIGFzc3VtcHRpb24gb2YgY29u
dGlndW91cyBtZW1vcnkNCj4+IHJlZ2lvbi4NCj4gDQoNCg==

