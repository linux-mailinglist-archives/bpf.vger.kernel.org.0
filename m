Return-Path: <bpf+bounces-11418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E37A7B99C6
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 03:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 47F98281E7A
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 01:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D05C1390;
	Thu,  5 Oct 2023 01:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="c7gSKrEH"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE00EC5
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 01:50:51 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2859F9E
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 18:50:49 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3950CiDm026535
	for <bpf@vger.kernel.org>; Wed, 4 Oct 2023 18:50:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=qFsc9hu5qzv+0rw+Fq33gOf+KQJcrO+49JUfBh3W6IY=;
 b=c7gSKrEHCnREQleagTScA6N59zucudk07/TiQM5srYHo9pnPwu3cncBsmNb0bDsbWu3z
 3gxkLKAeDgPH6RQGhK6aahzPifZGMfDlLV/CJ1QRXHhspqit0tuWXTVT3BNaxoGuDth4
 3ejoMD7bEUEkr1VE1UcvF3be7dOPStg8g93izXNBIUdw0Zk7xFaCFbFNwFS+C6607jRY
 NlM6y5CuJbYInSxQ5UzTvYkPk3WN0VxtL4/XTDJz8URaaeasnMzGYref+7IAmKqBQ2ph
 tLHutzBZkgL8chuT7ljwOR4VdBvyeIFkLB05JRgyHXPtcguhfyJD6S4fMbUTYyZo6JCd OQ== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tgnfk4u3j-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 04 Oct 2023 18:50:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzSg+b29PLPsdTj+ISQnthbflMUAHiZfH+Fgh88fK4rOdoQaPaQ/SYtdjbZ7U2j+MhrtFV7x6OIj2XZ4/LA7xw0wnyGSOZzyB1x8i2wKjyYTdWznnlx3GxSCOwKOJcKvrmYHOZ7mDtHjsB0q3AAUKPlf3T+Jw/vWA4fw/57SLO53eW4l/OE4I0G4gSLKDC635GyJzB8ByzJKAeGz011vHuIPiJ5oitJj92ZV/qNbKa1rWQ30gWVeQyNuWfCXhRRMEf1cq9m2E7eL/spb9NXhzQsh3YL1setVH7NA9ErzcF0oCKDFdzreRlWkAZVjrQ2ugXvWzFC/hYcMH+nkfjw0Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFsc9hu5qzv+0rw+Fq33gOf+KQJcrO+49JUfBh3W6IY=;
 b=L+jCuZtK4Cn2+0zK9YwLn0rWUToIdPynKPMwUglV3Y0nIcsMi3m0rRD2iNt5gSWdWe9l35MgaHjGWzDzOIuxFqKLaxGavCSf7Iu1spSaimG/xt34gqUztQ/bNHUV49KWoll1rq7GCOo7c8oOkS2nqXN62Z3IdABpi0RkKkRB8seHgNqM35lb/gWX1DMSaE+WwvBuIBoKfNb+XUGJE9xOr1knIla5cjWYg2aw6k2q47r4aHV0YaPnoY6UQuEcVGmHOzpT32oZ3+EDVx3SeXkIks7x+buElgG/LCcfKnAaS3YcEnw1ENtqCuWUsaejQvvftJPdBFrSaP5PoNmpigFDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by IA1PR15MB6350.namprd15.prod.outlook.com (2603:10b6:208:3fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Thu, 5 Oct
 2023 01:50:45 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e0e7:7606:7fef:f9de]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e0e7:7606:7fef:f9de%5]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 01:50:45 +0000
From: Song Liu <songliubraving@meta.com>
To: Song Liu <songliubraving@meta.com>
CC: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko
	<andrii.nakryiko@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, Song Liu
	<song@kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team
	<kernel-team@meta.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 bpf-next] bpf: Avoid unnecessary -EBUSY from
 htab_lock_bucket
Thread-Topic: [PATCH v2 bpf-next] bpf: Avoid unnecessary -EBUSY from
 htab_lock_bucket
Thread-Index: AQHZ9lwCFOQR9ydaeUieAa0xHUISRbA481YAgAAHDQCAANWeAIAAhFAAgAAbnwA=
Date: Thu, 5 Oct 2023 01:50:45 +0000
Message-ID: <A53BABCE-A22D-40B0-91BA-009B54AB8F09@fb.com>
References: <20231004004350.533234-1-song@kernel.org>
 <CAEf4BzbM6yvBwT3-_7NkzKgqdoXc_G3+_5Fnv96b_2U68=Hunw@mail.gmail.com>
 <CAADnVQKMxUg3Djh8UjRPdw7RE6yOiNUgYGjG_eCPqMtnguO+fA@mail.gmail.com>
 <095DCE9A-BC4D-415F-81F6-B6C20BA08B9A@fb.com>
 <FCAD3D3A-B230-40D8-A422-DED507B95C89@fb.com>
In-Reply-To: <FCAD3D3A-B230-40D8-A422-DED507B95C89@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|IA1PR15MB6350:EE_
x-ms-office365-filtering-correlation-id: fe430c62-63d2-4233-a4c3-08dbc5457d81
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 WBGxEwWR7+OpOjzVbz6PXUp+GjahMczES7BgYUCMXhjJR6sGl1+0EJKS0THm4pmRh4l/dh9HPUmloRUYnriHlWS/HQzSwW6ynOSx43d9ed/ENyskHVRpHczeR6Ivyp7FA5PZLs7gBpy9x3H5/LgM0Zcj4UokwGntXuuZBvRpqxJYRtj7bdgq/QWm6qssyU1NioTLNg8q1kFU6aox2fjemr6/QI5C2dsvp/sWP03OcqZ+AOhz0xGxs+4vTaWE44kyopl3UUcUIl+1vwZ4jiG6ND9zIJvZc1Bi2x98OvCuI4Xre3Hb2J16hXwDNPwhoc4aXd1iKS6jOVLDWK/UuTpvJnRQ0xdl4Fkqfd+DqnDKP1ktEBz3ANOe8CG3s77uosCa3kscLJPKX+OmJjJbnC0lQ3/Ra31MgnVY2Bdoge25w2I3grDkTQDJnA14z6a56SwEydO9EoeekOCvbKObtDRyAzc4AvOLWLxaQOGE9X6cvlCy/wX8EnR8eW2zWEDPVexuH6DqdPG9uUM7+/b+kxhCRMxPlYyGvIQBQAgJo6fiGsZuJx2iYJoJ2JLhBHgtxluGmzUHldUhJOMIZ11jgTMTjTrBAih9TbywrFgmZg5DWkL/WiWOVoAug/EPW8/9Pukz
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6200100001)(7416002)(2906002)(8676002)(5660300002)(6862004)(4326008)(8936002)(41300700001)(54906003)(64756008)(66946007)(91956017)(76116006)(66476007)(6512007)(66446008)(66556008)(316002)(6486002)(6506007)(478600001)(38070700005)(122000001)(9686003)(86362001)(71200400001)(83380400001)(36756003)(53546011)(33656002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OEpwcnRmUVhEeDFOU3Y2bER4d29BRU1vTytialVuMTRjUHA2bzB3ZUwwVW9k?=
 =?utf-8?B?Zjlzc0tTQTBtV0Q3ejJtUzhTQk51QmpzMkxidkMyNUpnM3lIZVF4YXF5SmNM?=
 =?utf-8?B?YWRNbWYzb3BKcnc0NGFrYW1NVzBaZlJyUlJ5dlp5bmR0SGRhOG1GbzJMZWRa?=
 =?utf-8?B?aXRqMnN5aFUrRnZhMGt0d3VxZGhzNEJIRFhySHpOZE9lK29iUFc0YXVaQlJs?=
 =?utf-8?B?WkFZdGRZSnBWRU1zYXZjNTBWZTNLN2hwTXdEYVRIMTNpb08vNHYrV1puSi9L?=
 =?utf-8?B?SFdrVGdDM1RmTkVZZFRJcXNBNXpPQzE2WjBqZEJ1ZU1KQWpDbnNid3RQWFZ6?=
 =?utf-8?B?WkxndWk5ZnFaRmlGc3dYbXcxMEdJaVhjeUxseGNUckR2VUI5ZlZ2NlU4WHdi?=
 =?utf-8?B?Q0VPNDdRRG5jMzd0cU9BTExaUEd6Nk5ObXBQcGlYM1RGQ01RY1lMS3VYMDdu?=
 =?utf-8?B?ZFpQQVZJWWxwQ0xqSWV1aVlrUnZ6M2FPUEJNVVhTTUtOczFlUE1nTTd6RlVt?=
 =?utf-8?B?YS9GMVpCTFdzaktPZHFlV09wOVdTYWlCR1FETFU2N1dsSFloK3plNmt6Skg3?=
 =?utf-8?B?S2xLMW92K1BTK2x5Vjdkb3pSTnV4cGwzdVBMRExiYThLVTNHOElCT3lwdDho?=
 =?utf-8?B?blJVcCtCcUdLUC9QK015Z2lRK2NZalB4bzZLU1B1Zm1QM2hkYVdwa0tzR3VD?=
 =?utf-8?B?L2NlY3pIbXZ0V25uc0R6c0FaQmVOTzVhL0FWOWloT2hKS1ZTZ0ppMS9zNU1V?=
 =?utf-8?B?dzRLcVM1M01zTHJFaVdKbVp1Y0dhei9RS3Z2MGwrajdNVWIvaENFd3FpTWc4?=
 =?utf-8?B?WnJVZDhoV1VBMXVOZDk4cDhERTVFUkxKVjBmUVI5Mm9paDRaV0JOUWxkNWFt?=
 =?utf-8?B?NU82K0Fvd1hmdVQ5VUQxekVMei9UQzBrM0EveWJhZGYwR3B4RXh4VkpnM1M1?=
 =?utf-8?B?RWl3VFR4bElvMDZQbEtvekJNSW5NYnkxc1hYSkhXZy9JRWJWWGp5YTlTQ0hC?=
 =?utf-8?B?UzVwbXNNa3NPMEYzeGFiRk94RkFVbkdySEQ0amVsSS9teUthc1hVRVRXWEdz?=
 =?utf-8?B?ZXJ5QVJ2Y3R1SHNFSG9SUnF6Q2NYVUgyRFZWTnBNVlFXNzUyVmQ5TWVVN3hO?=
 =?utf-8?B?OTlGTVEvWGhIT2ZQN3FBM2hremg4emJYeUVSVGJ5cmZUSitvWVJsS3RWTHNz?=
 =?utf-8?B?Q0NzaW1BR2xkY0w3S1dDQWhseTdmU1dQZ2xMWFQ4QmNiWGJLVmI5dTlwaHQ4?=
 =?utf-8?B?NjNhbVQ4alBZOHZKUWYrRFZEQTR5S0w0Ulc3MG11K2N0YjRtVDZCcU03dENr?=
 =?utf-8?B?Q1JqbEorNlk5U2JmTFZNazA3bEl6aTZ1ekxUb016N1FTY1owQlpZYnRLaG1O?=
 =?utf-8?B?aUtLbDR1RDUvcndSK21yMERzbklpekJrdHRWWnpuSGVRUW55QzZ1b0Qyb1c3?=
 =?utf-8?B?N0Fpd2NPUUM5MDZBL1hqK01Sdk9aaEowMmxOdlV6V244aHMrczc5TlM4eG9B?=
 =?utf-8?B?eE1TRTdXY0cxeTBGQmhDWVZncXNDNVZ6M3NCWHh1OTRqSzJZMkIySHN1NVUw?=
 =?utf-8?B?eUJxSUQ1L0lMcnZTKzJJVXloOStCbHR2WHAybU82UGZnWWVEdG9pWG1xT2tC?=
 =?utf-8?B?OVk2SmZUeDVUeFViTmdST2M4NGk3TCt2ckJZaWhTT0YxVEtjOEVRaGU4YnVQ?=
 =?utf-8?B?SnJqUVE0TUVYU2VwSnh0V2RDRFE4NFJOdzF1WUpDYlRnS2JndzhNbW8vVE1L?=
 =?utf-8?B?VDBtblkySkJhOEkzejh1MnNyOStLamtzbC9jN0dTT2hDNWJ5MzBiQVhhRlpk?=
 =?utf-8?B?bnh3WEpBNVc3MHVmRlhiMFpWcnlvWHo5Rk1LS3cyeGo2MUd4V2xocS9qcHBL?=
 =?utf-8?B?NXVxbWU3TU9qSVdrLzB6Y2VJYXdUYlBQV0hjL2FTTHZXU01aTytVcm9aMzRs?=
 =?utf-8?B?S0oyMUsyT05Oa3FVNmQwOFRGSElmS2JhWUZycjFFUXRvaS91UGlVZ09VVmRm?=
 =?utf-8?B?MWN3bHdiZldaR1Q1L3pkQ04wUHNyNDBIVGExYjBqSlk2bklmOHdBM3U2UHoz?=
 =?utf-8?B?ZWVmaldCb0FFK3lrbXIwSkVGbXNucEs0YzRVcmdDbXFVd25KSUo3dEw5cnJG?=
 =?utf-8?B?S3Q2QlFueFpWTHVrb3lwY2JBTWRUZ0FYcVJFMXZZYnRsbVl4V1QrdG1Gdjdx?=
 =?utf-8?Q?ocPXErOkU06vEuM9F7n3Cm8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1217D46F7822AD45AABD040C3CE47355@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fe430c62-63d2-4233-a4c3-08dbc5457d81
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 01:50:45.1603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wducdR3X6IwX2v8vPeScq4aoZk1fx1OIau8UWpsj3fYWag62BIZZ4Q2XFz5cgvtCZpgk9QXcTkYF/naOXtsvsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB6350
X-Proofpoint-ORIG-GUID: Biu4YcGjjCJ3x8-1--U4JayCrS7lnSYp
X-Proofpoint-GUID: Biu4YcGjjCJ3x8-1--U4JayCrS7lnSYp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_13,2023-10-02_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gT24gT2N0IDQsIDIwMjMsIGF0IDU6MTEgUE0sIFNvbmcgTGl1IDxzb25nbGl1YnJhdmlu
Z0BtZXRhLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+PiBPbiBPY3QgNCwgMjAyMywgYXQgOTox
OCBBTSwgU29uZyBMaXUgPHNvbmdsaXVicmF2aW5nQG1ldGEuY29tPiB3cm90ZToNCj4+IA0KPj4g
DQo+PiANCj4+PiBPbiBPY3QgMywgMjAyMywgYXQgODozMyBQTSwgQWxleGVpIFN0YXJvdm9pdG92
IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToNCj4+PiANCj4+PiBPbiBUdWUs
IE9jdCAzLCAyMDIzIGF0IDg6MDjigK9QTSBBbmRyaWkgTmFrcnlpa28NCj4+PiA8YW5kcmlpLm5h
a3J5aWtvQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4+IA0KPj4+PiBPbiBUdWUsIE9jdCAzLCAyMDIz
IGF0IDU6NDXigK9QTSBTb25nIExpdSA8c29uZ0BrZXJuZWwub3JnPiB3cm90ZToNCj4+Pj4+IA0K
Pj4+Pj4gaHRhYl9sb2NrX2J1Y2tldCB1c2VzIHRoZSBmb2xsb3dpbmcgbG9naWMgdG8gYXZvaWQg
cmVjdXJzaW9uOg0KPj4+Pj4gDQo+Pj4+PiAxLiBwcmVlbXB0X2Rpc2FibGUoKTsNCj4+Pj4+IDIu
IGNoZWNrIHBlcmNwdSBjb3VudGVyIGh0YWItPm1hcF9sb2NrZWRbaGFzaF0gZm9yIHJlY3Vyc2lv
bjsNCj4+Pj4+IDIuMS4gaWYgbWFwX2xvY2tbaGFzaF0gaXMgYWxyZWFkeSB0YWtlbiwgcmV0dXJu
IC1CVVNZOw0KPj4+Pj4gMy4gcmF3X3NwaW5fbG9ja19pcnFzYXZlKCk7DQo+Pj4+PiANCj4+Pj4+
IEhvd2V2ZXIsIGlmIGFuIElSUSBoaXRzIGJldHdlZW4gMiBhbmQgMywgQlBGIHByb2dyYW1zIGF0
dGFjaGVkIHRvIHRoZSBJUlENCj4+Pj4+IGxvZ2ljIHdpbGwgbm90IGFibGUgdG8gYWNjZXNzIHRo
ZSBzYW1lIGhhc2ggb2YgdGhlIGhhc2h0YWIgYW5kIGdldCAtRUJVU1kuDQo+Pj4+PiBUaGlzIC1F
QlVTWSBpcyBub3QgcmVhbGx5IG5lY2Vzc2FyeS4gRml4IGl0IGJ5IGRpc2FibGluZyBJUlEgYmVm
b3JlDQo+Pj4+PiBjaGVja2luZyBtYXBfbG9ja2VkOg0KPj4+Pj4gDQo+Pj4+PiAxLiBwcmVlbXB0
X2Rpc2FibGUoKTsNCj4+Pj4+IDIuIGxvY2FsX2lycV9zYXZlKCk7DQo+Pj4+PiAzLiBjaGVjayBw
ZXJjcHUgY291bnRlciBodGFiLT5tYXBfbG9ja2VkW2hhc2hdIGZvciByZWN1cnNpb247DQo+Pj4+
PiAzLjEuIGlmIG1hcF9sb2NrW2hhc2hdIGlzIGFscmVhZHkgdGFrZW4sIHJldHVybiAtQlVTWTsN
Cj4+Pj4+IDQuIHJhd19zcGluX2xvY2soKS4NCj4+Pj4+IA0KPj4+Pj4gU2ltaWxhcmx5LCB1c2Ug
cmF3X3NwaW5fdW5sb2NrKCkgYW5kIGxvY2FsX2lycV9yZXN0b3JlKCkgaW4NCj4+Pj4+IGh0YWJf
dW5sb2NrX2J1Y2tldCgpLg0KPj4+Pj4gDQo+Pj4+PiBTdWdnZXN0ZWQtYnk6IFRlanVuIEhlbyA8
dGpAa2VybmVsLm9yZz4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFNvbmcgTGl1IDxzb25nQGtlcm5l
bC5vcmc+DQo+Pj4+PiANCj4+Pj4+IC0tLQ0KPj4+Pj4gQ2hhbmdlcyBpbiB2MjoNCj4+Pj4+IDEu
IFVzZSByYXdfc3Bpbl91bmxvY2soKSBhbmQgbG9jYWxfaXJxX3Jlc3RvcmUoKSBpbiBodGFiX3Vu
bG9ja19idWNrZXQoKS4NCj4+Pj4+IChBbmRyaWkpDQo+Pj4+PiAtLS0NCj4+Pj4+IGtlcm5lbC9i
cGYvaGFzaHRhYi5jIHwgNyArKysrKy0tDQo+Pj4+PiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+Pj4gDQo+Pj4+IA0KPj4+PiBOb3cgaXQncyBtb3Jl
IHN5bW1ldHJpY2FsIGFuZCBzZWVtcyBjb3JyZWN0IHRvIG1lLCB0aGFua3MhDQo+Pj4+IA0KPj4+
PiBBY2tlZC1ieTogQW5kcmlpIE5ha3J5aWtvIDxhbmRyaWlAa2VybmVsLm9yZz4NCj4+Pj4gDQo+
Pj4+PiBkaWZmIC0tZ2l0IGEva2VybmVsL2JwZi9oYXNodGFiLmMgYi9rZXJuZWwvYnBmL2hhc2h0
YWIuYw0KPj4+Pj4gaW5kZXggYThjN2UxYzVhYmZhLi5mZDhkNGIwYWRkZmMgMTAwNjQ0DQo+Pj4+
PiAtLS0gYS9rZXJuZWwvYnBmL2hhc2h0YWIuYw0KPj4+Pj4gKysrIGIva2VybmVsL2JwZi9oYXNo
dGFiLmMNCj4+Pj4+IEBAIC0xNTUsMTMgKzE1NSwxNSBAQCBzdGF0aWMgaW5saW5lIGludCBodGFi
X2xvY2tfYnVja2V0KGNvbnN0IHN0cnVjdCBicGZfaHRhYiAqaHRhYiwNCj4+Pj4+ICAgICAgaGFz
aCA9IGhhc2ggJiBtaW5fdCh1MzIsIEhBU0hUQUJfTUFQX0xPQ0tfTUFTSywgaHRhYi0+bl9idWNr
ZXRzIC0gMSk7DQo+Pj4+PiANCj4+Pj4+ICAgICAgcHJlZW1wdF9kaXNhYmxlKCk7DQo+Pj4+PiAr
ICAgICAgIGxvY2FsX2lycV9zYXZlKGZsYWdzKTsNCj4+Pj4+ICAgICAgaWYgKHVubGlrZWx5KF9f
dGhpc19jcHVfaW5jX3JldHVybigqKGh0YWItPm1hcF9sb2NrZWRbaGFzaF0pKSAhPSAxKSkgew0K
Pj4+Pj4gICAgICAgICAgICAgIF9fdGhpc19jcHVfZGVjKCooaHRhYi0+bWFwX2xvY2tlZFtoYXNo
XSkpOw0KPj4+Pj4gKyAgICAgICAgICAgICAgIGxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsNCj4+
Pj4+ICAgICAgICAgICAgICBwcmVlbXB0X2VuYWJsZSgpOw0KPj4+Pj4gICAgICAgICAgICAgIHJl
dHVybiAtRUJVU1k7DQo+Pj4+PiAgICAgIH0NCj4+Pj4+IA0KPj4+Pj4gLSAgICAgICByYXdfc3Bp
bl9sb2NrX2lycXNhdmUoJmItPnJhd19sb2NrLCBmbGFncyk7DQo+Pj4+PiArICAgICAgIHJhd19z
cGluX2xvY2soJmItPnJhd19sb2NrKTsNCj4+PiANCj4+PiBTb25nLA0KPj4+IA0KPj4+IHRha2Ug
YSBsb29rIGF0IHMzOTAgY3Jhc2ggaW4gQlBGIENJLg0KPj4+IEkgc3VzcGVjdCB0aGlzIHBhdGNo
IGlzIGNhdXNpbmcgaXQuDQo+PiANCj4+IEl0IGluZGVlZCBsb29rcyBsaWtlIHRyaWdnZXJlZCBi
eSB0aGlzIHBhdGNoLiBCdXQgSSBoYXZlbid0IGZpZ3VyZWQNCj4+IG91dCB3aHkgaXQgaGFwcGVu
cy4gdjEgc2VlbXMgb2sgZm9yIHRoZSBzYW1lIHRlc3RzLiANCj4gDQo+IEkgZ3Vlc3MgSSBmaW5h
bGx5IGZpZ3VyZWQgb3V0IHRoaXMgKHNob3VsZCBiZSBzaW1wbGUpIGJ1Zy4gSWYgSSBnb3QgaXQg
DQo+IGNvcnJlY3RseSwgd2UgbmVlZDoNCj4gDQo+IGRpZmYgLS1naXQgYy9rZXJuZWwvYnBmL2hh
c2h0YWIuYyB3L2tlcm5lbC9icGYvaGFzaHRhYi5jDQo+IGluZGV4IGZkOGQ0YjBhZGRmYy4uMWNm
YTIzMjlhNTNhIDEwMDY0NA0KPiAtLS0gYy9rZXJuZWwvYnBmL2hhc2h0YWIuYw0KPiArKysgdy9r
ZXJuZWwvYnBmL2hhc2h0YWIuYw0KPiBAQCAtMTYwLDYgKzE2MCw3IEBAIHN0YXRpYyBpbmxpbmUg
aW50IGh0YWJfbG9ja19idWNrZXQoY29uc3Qgc3RydWN0IGJwZl9odGFiICpodGFiLA0KPiAgICAg
ICAgICAgICAgICBfX3RoaXNfY3B1X2RlYygqKGh0YWItPm1hcF9sb2NrZWRbaGFzaF0pKTsNCj4g
ICAgICAgICAgICAgICAgbG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOw0KPiAgICAgICAgICAgICAg
ICBwcmVlbXB0X2VuYWJsZSgpOw0KPiArICAgICAgICAgICAgICAgKnBmbGFncyA9IGZsYWdzOw0K
PiAgICAgICAgICAgICAgICByZXR1cm4gLUVCVVNZOw0KPiAgICAgICAgfQ0KDQpOby4uLiBJIHdh
cyB0b3RhbGx5IHdyb25nLiBUaGlzIGlzIG5vdCBuZWVkZWQuIA0KDQpUcnlpbmcgc29tZXRoaW5n
IGRpZmZlcmVudC4uDQoNClRoYW5rcywNClNvbmc=

