Return-Path: <bpf+bounces-11384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C957B84CA
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 18:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 960B6281786
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 16:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184891BDDB;
	Wed,  4 Oct 2023 16:18:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3600B1BDC5
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 16:18:25 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7D1A9
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 09:18:23 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394EC6pD023430
	for <bpf@vger.kernel.org>; Wed, 4 Oct 2023 09:18:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=r1t5xCtPnPJ8U+HJAdWQB/whgJtdl8ISlXAYm/j7HhY=;
 b=bE4JS6ffUjTqGA2883mNiqSRViyGjUY2Oc0efve39xpPgG9xQa2pglQFwP0zjJ18LM34
 zYeqg0yiaRHYr3LKHhFcW2zHAcbD6Gu8LGlcJa5wo+tvt+OuXxg4xLHl8dvYsgdVeKcg
 URgGVHVobTnL4gEcvHwOAOCVRY7Kwe6iOchx5h89dWkdvKzmd618r0HvZZZhwPz1p1mn
 7+266cmTmV0iBKYmLBzUgiPhWciPmUTIDRGD4cUf01F5oOlOPr2jEE2XiQ1shngzeQuG
 wdp+aE9idJCt8u5nMjJ6y3IARO7VQXjr44Q5cP4nLIEU5C4UamKC7iq8G6vz5fFkE9mg MQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3th30krtth-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 04 Oct 2023 09:18:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpNfxxeWpBMFa4PXbujpFkN2CsJfiU5kvual1DEwwhuegXrO42SwXcrYFogF5AnGJd7eR6Se1E6AGUMY0fXvSIRVXoPlKIQgJGKjSkPkauDuyIkIvhYhCUIzTkd9I6e6ZLUUi13dA6fFnf6Vtm/0POzfmfHyFz1KsaHIWquT9bhbKLs39nNx+VDttVM2qbgL6V5siI8qSe8WGJKmYFbOMSlp7PR4f76BFiayvLVb3z9VirnHhGfCMJSckOMJ7gbFej+LUw70mlJ5L/G1bkgw1QrP6YEWWxkhEPELv3fmavfxTzRvwV6f1wJF/rsBcx7tucR95CG8vEzOxsWp6+UHkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1t5xCtPnPJ8U+HJAdWQB/whgJtdl8ISlXAYm/j7HhY=;
 b=gmPxuVihqIUjtPm0e3Oh8rCkyAgn1amYI4ZovJ0mgqxsGanycfQVudMSB8LTUjcrMaOAhRe0FZXc7d0aVFEovmXZ9XwEtI6RGQtmWGweqNh8X3xaV6hqsxCEt8WFxZrTiGJV1+FDlO9kSfA5i1U/qewWAY5tHDBgArk/yb80M2iqPsdQtqF9iXj+B8pJfjjh3vHmORF3tFlkvnK+Jas/S3iGxwKtL7ubxfP6m1Jb4+SALN5WvJU3xog0K4Bq7yC4zTLB+FLjI4xl5va41vuw6aB5t2em+OVxnViGM27Z9ZbJ81snOfsffNgwVsfBID1U8cL06JYLTi91M03vf/UYgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BY3PR15MB4850.namprd15.prod.outlook.com (2603:10b6:a03:3b5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Wed, 4 Oct
 2023 16:18:19 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e0e7:7606:7fef:f9de]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e0e7:7606:7fef:f9de%5]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 16:18:19 +0000
From: Song Liu <songliubraving@meta.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Ilya Leoshkevich
	<iii@linux.ibm.com>, Song Liu <song@kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@meta.com>, Tejun Heo
	<tj@kernel.org>
Subject: Re: [PATCH v2 bpf-next] bpf: Avoid unnecessary -EBUSY from
 htab_lock_bucket
Thread-Topic: [PATCH v2 bpf-next] bpf: Avoid unnecessary -EBUSY from
 htab_lock_bucket
Thread-Index: AQHZ9lwCFOQR9ydaeUieAa0xHUISRbA481YAgAAHDQCAANWeAA==
Date: Wed, 4 Oct 2023 16:18:19 +0000
Message-ID: <095DCE9A-BC4D-415F-81F6-B6C20BA08B9A@fb.com>
References: <20231004004350.533234-1-song@kernel.org>
 <CAEf4BzbM6yvBwT3-_7NkzKgqdoXc_G3+_5Fnv96b_2U68=Hunw@mail.gmail.com>
 <CAADnVQKMxUg3Djh8UjRPdw7RE6yOiNUgYGjG_eCPqMtnguO+fA@mail.gmail.com>
In-Reply-To: 
 <CAADnVQKMxUg3Djh8UjRPdw7RE6yOiNUgYGjG_eCPqMtnguO+fA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|BY3PR15MB4850:EE_
x-ms-office365-filtering-correlation-id: a14c6025-d7a7-40bb-3574-08dbc4f585fb
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 nEPnMPRx/anx8Db+Dp8P+gTbTQLSXqMkyADL4Gowfnu9bt3moUDguHoVr4n1/kR5lqtUBJdL0QZEnI84aeI3zx2L6I2Pk65lTJRHQYPHsiKXeMohYyq40eDhTWdjikDtGkwjKdIFUwrF2SaG/zJ3ZhSBm/ZgBNJ5Fd4OxcqAZuY63N61Iz/PmwCHKIetZL618LflORmn0UKQRdrjwdvAQ96QK+CtOt4a+r8k8Dvs6sD7cQH4ceLor/Eq8LmH+JqFjjQRgGeiuKVV1qIaq6ZUXQwQMSE7RrsJ5qDyXjg3wwea4k7OivBchEoWMrvLwXDNDSoVm3hIaiC6aqF8vzYET1s205w5xbPXKpoqJAqs4uDEu+4ByzinPwkAQZlCkq7804iHH1wxd+giiSJMFZfw3LS+MF8xoN+8dDm3eTuOeOznFo2EMbauXFkfxijemvrRQPiLqJd4cQ66tO1SAoblLnXUX6o5gaafD6imUHpc3DNhk07Tzld6YKkuWy6ErMz8FLk28iwii7rB0QhGvIEeUTgBYgYTtLyCKakxKAOECCcvCZnzMNMhuk8hs4BEthMuoEzXgy5kvLEqkoxlFsIojxCGMgn0tDpHF47dh7e6AZBhn0MyorntlX/irdBiiLk1
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6506007)(478600001)(71200400001)(53546011)(6486002)(9686003)(83380400001)(2906002)(91956017)(6512007)(7416002)(64756008)(41300700001)(316002)(76116006)(66946007)(6916009)(5660300002)(66446008)(66476007)(66556008)(4326008)(8936002)(8676002)(36756003)(33656002)(54906003)(86362001)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Sk5hRlFPVDRSa0tDcGhzNUF5MHdTWWV4WDZITmcrUG8rUW1nNHRrN0kzRitG?=
 =?utf-8?B?aWZuWCt6dVVkSVEyNi84NUFZR25tcUVhRXJtWkNPWkMzZlVKbkhwelduSGJa?=
 =?utf-8?B?MFhQQWpucmVYajRGL1pWWXJDYmxxbTc3YTFFdTYxTi9WcEpOSlhXRnU1MVFT?=
 =?utf-8?B?TjRVVFMvdFBBTFptakhZRUxpaUI5dWxscXo5V1h0eUczbWp1blgvUmtDWjFG?=
 =?utf-8?B?UDN3UW04bzFxc0pVUi96aGxyT1dlWlBnbXRFL3dYVzhpc0NhZ3BLKzErcXZU?=
 =?utf-8?B?bWhNcXhCYUh3NzRDOUJObFlKSXhsdktQVVZpSExEZXM4OTVOd2g4SW5NYndV?=
 =?utf-8?B?L05LUlhjemNpaHlla0h5VE1iM0hQVWdXQmFuSVFwbkZud0FnYkp2UVhKOHdl?=
 =?utf-8?B?R1J0VERHMW9PbHRnT2hGQkZSMytFWkNKckxjSG9DS2R2QXFFUHA4L2Q0TjZr?=
 =?utf-8?B?TWVQQ1UyWFAzeDZQQ1BCcVgzblZNZlYrMjJSVUVpU2ErSWtRTis5c2FHSFMy?=
 =?utf-8?B?cWs3a1FjdWRCYTl2b21PVmF2bS9oT2RaRlRxZjBZeHc4bEZyYlR1UTZ0R2c2?=
 =?utf-8?B?cHpKQW1UUm90ejFWd2V5cEdEYU5LT2VyQ3pKZE5VZFdQUUxZYlJJQ3JMZGpW?=
 =?utf-8?B?dFFmU1VXZ2wrcDBNT2tMUVRnRmJrR2FXeTJJaTRKaS80b0p2VUZKVy9MV1Bp?=
 =?utf-8?B?Ny9TMDVYZnVBNWtPakh5RXhxdUI5dWFnT04veWJRbnBDSFM1Wmoxc3l2YnJY?=
 =?utf-8?B?aVcvelNCOUZkQTBmc21GYk5ERnc3UWZHazR3a1lPMkFHMDE3NDVFeGNJWmJL?=
 =?utf-8?B?NmVtS3pMdWpKUjVuMW5oekpRY053Mkg2KzUzQW9KN1B0RFJLOVRRclk2bmlU?=
 =?utf-8?B?OHB2UFBJTnd0UnFCOERRb05hcXo2K1dwWjUxc09yNjdjb2tQUGUyYklDbU4r?=
 =?utf-8?B?VGMzclJpSWNIdUZBOVlMSXVNeHlBTlZ1ZkNyYXd2eXJiSVJhcEh3c2JxNWJV?=
 =?utf-8?B?TGpoZG83R0xYWGgxK2RlWUkyNjVyZnN6U0VITWxPVk5jL2V0L1N6WjFKWUhx?=
 =?utf-8?B?MnhTSkVPUUhCVTJSZ0JhQTJpd3h6RkYrdG8raEJYeGo3VlU5VC9oWHN0RUQr?=
 =?utf-8?B?dDBRaGUzWjh5eGRzVThZWno3U0lVNVYxMzBTbEZ5cWpkZjA0MkQvM3VWL2lU?=
 =?utf-8?B?MkYrUVdtajh5RGtPWjluSEd0TzJ1cVgvamVydXgrNFd5NjlZa000b2xCcTR1?=
 =?utf-8?B?b3BsVkZ2bU9EUEtwMFF0K0ZwNnpJMXVKR3dqamVHdmdBWURTZVd4a1RNbFZ6?=
 =?utf-8?B?U3k0S0JlQWtkSk4rQlFIbnIxYU15Q3ZPSlB5ZHJ0RWp4bmp4anhYaWdTNDBJ?=
 =?utf-8?B?akRSSlo5RW84NnpKd3VscnFlWG9iKytVT3hCYVNBRmtxYlhPYUhCbGNmMUVX?=
 =?utf-8?B?dVBxM0tiUTZrREJuT2FOeDNpdzVwMktZcjhudXJXb0t2YW96S2NmN0RWVlpa?=
 =?utf-8?B?VS9Pc2ovWmxQZS9BaHJJbFZqR0ZnM294MHVUZUFna3pJZDY2dDBTU0pTQVhS?=
 =?utf-8?B?SDA0eGxTeXptM045UjAwWDA3VURneXRPbGRQbUdmZkQrN3BraDJvSmdGZ0hG?=
 =?utf-8?B?YnY0eGY0ZVJQejljcDR0YVQwK2lVQkN3TlZqNU92bStRb1ZJdEpQazA1SXRo?=
 =?utf-8?B?Y3BqVXVaTkVFc1F4dnVEUGRaY0R3SFdzTStMRUkyQkc5QVJta0dTb2ROa0NU?=
 =?utf-8?B?Qk9aYzM2OHVmYzJRY2Y4SENsV1VZd3dJRTMvUDVFd2hsbkdnQ3JoeFdDdkxh?=
 =?utf-8?B?YzkzczEvbGE4anV1a1djNXgvVUo2Uk5QNFZsN3NyYVlvWDdoQkEvVWR4RGht?=
 =?utf-8?B?Vi8vaW15eHJIUjM5K3ZrL0x1aXUzcmVzejFXYTNrRVNPK0NEaUJuNHlXaEts?=
 =?utf-8?B?UVkreTcvN21YTmozdnVwcVR5QXlwa3VKOWUzZCs1WkxYbHBzUHpFeWcrRnNO?=
 =?utf-8?B?aUJTZGRZQUNJVFJhWGc3WFhwajJBM2ZURzQyY0d3bEpJK3BHRURvekphaWEx?=
 =?utf-8?B?anBDYThKTjBDdUVZR3BIUlEvdmxLTy9HQkdsZ3czQ2daM2liZUJmcnlUOWVr?=
 =?utf-8?B?cEtVTk9Mc0ZXS1BKSzAyQnViQ2hlellYTitEaUJnbCtxaWdISGZDbzFYZ2Jy?=
 =?utf-8?Q?oGYpMURyOqyPpt38ZpzSvXU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABAB02D03A29344B8A39EF10094B5C2E@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a14c6025-d7a7-40bb-3574-08dbc4f585fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 16:18:19.6780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pf3usDaQJ15HUj2k+jLb0rR03x0kNP+ss1aO7QL06VV+c/UajETgGQaFCYkXmcEJGYuBB2Q3PCIPAAmVFDkFGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4850
X-Proofpoint-GUID: MEKke2cD0OY9GFzTrF3Mk58vZUY3VCww
X-Proofpoint-ORIG-GUID: MEKke2cD0OY9GFzTrF3Mk58vZUY3VCww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_07,2023-10-02_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gT24gT2N0IDMsIDIwMjMsIGF0IDg6MzMgUE0sIEFsZXhlaSBTdGFyb3ZvaXRvdiA8YWxl
eGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIE9jdCAzLCAy
MDIzIGF0IDg6MDjigK9QTSBBbmRyaWkgTmFrcnlpa28NCj4gPGFuZHJpaS5uYWtyeWlrb0BnbWFp
bC5jb20+IHdyb3RlOg0KPj4gDQo+PiBPbiBUdWUsIE9jdCAzLCAyMDIzIGF0IDU6NDXigK9QTSBT
b25nIExpdSA8c29uZ0BrZXJuZWwub3JnPiB3cm90ZToNCj4+PiANCj4+PiBodGFiX2xvY2tfYnVj
a2V0IHVzZXMgdGhlIGZvbGxvd2luZyBsb2dpYyB0byBhdm9pZCByZWN1cnNpb246DQo+Pj4gDQo+
Pj4gMS4gcHJlZW1wdF9kaXNhYmxlKCk7DQo+Pj4gMi4gY2hlY2sgcGVyY3B1IGNvdW50ZXIgaHRh
Yi0+bWFwX2xvY2tlZFtoYXNoXSBmb3IgcmVjdXJzaW9uOw0KPj4+ICAgMi4xLiBpZiBtYXBfbG9j
a1toYXNoXSBpcyBhbHJlYWR5IHRha2VuLCByZXR1cm4gLUJVU1k7DQo+Pj4gMy4gcmF3X3NwaW5f
bG9ja19pcnFzYXZlKCk7DQo+Pj4gDQo+Pj4gSG93ZXZlciwgaWYgYW4gSVJRIGhpdHMgYmV0d2Vl
biAyIGFuZCAzLCBCUEYgcHJvZ3JhbXMgYXR0YWNoZWQgdG8gdGhlIElSUQ0KPj4+IGxvZ2ljIHdp
bGwgbm90IGFibGUgdG8gYWNjZXNzIHRoZSBzYW1lIGhhc2ggb2YgdGhlIGhhc2h0YWIgYW5kIGdl
dCAtRUJVU1kuDQo+Pj4gVGhpcyAtRUJVU1kgaXMgbm90IHJlYWxseSBuZWNlc3NhcnkuIEZpeCBp
dCBieSBkaXNhYmxpbmcgSVJRIGJlZm9yZQ0KPj4+IGNoZWNraW5nIG1hcF9sb2NrZWQ6DQo+Pj4g
DQo+Pj4gMS4gcHJlZW1wdF9kaXNhYmxlKCk7DQo+Pj4gMi4gbG9jYWxfaXJxX3NhdmUoKTsNCj4+
PiAzLiBjaGVjayBwZXJjcHUgY291bnRlciBodGFiLT5tYXBfbG9ja2VkW2hhc2hdIGZvciByZWN1
cnNpb247DQo+Pj4gICAzLjEuIGlmIG1hcF9sb2NrW2hhc2hdIGlzIGFscmVhZHkgdGFrZW4sIHJl
dHVybiAtQlVTWTsNCj4+PiA0LiByYXdfc3Bpbl9sb2NrKCkuDQo+Pj4gDQo+Pj4gU2ltaWxhcmx5
LCB1c2UgcmF3X3NwaW5fdW5sb2NrKCkgYW5kIGxvY2FsX2lycV9yZXN0b3JlKCkgaW4NCj4+PiBo
dGFiX3VubG9ja19idWNrZXQoKS4NCj4+PiANCj4+PiBTdWdnZXN0ZWQtYnk6IFRlanVuIEhlbyA8
dGpAa2VybmVsLm9yZz4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBTb25nIExpdSA8c29uZ0BrZXJuZWwu
b3JnPg0KPj4+IA0KPj4+IC0tLQ0KPj4+IENoYW5nZXMgaW4gdjI6DQo+Pj4gMS4gVXNlIHJhd19z
cGluX3VubG9jaygpIGFuZCBsb2NhbF9pcnFfcmVzdG9yZSgpIGluIGh0YWJfdW5sb2NrX2J1Y2tl
dCgpLg0KPj4+ICAgKEFuZHJpaSkNCj4+PiAtLS0NCj4+PiBrZXJuZWwvYnBmL2hhc2h0YWIuYyB8
IDcgKysrKystLQ0KPj4+IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+Pj4gDQo+PiANCj4+IE5vdyBpdCdzIG1vcmUgc3ltbWV0cmljYWwgYW5kIHNlZW1z
IGNvcnJlY3QgdG8gbWUsIHRoYW5rcyENCj4+IA0KPj4gQWNrZWQtYnk6IEFuZHJpaSBOYWtyeWlr
byA8YW5kcmlpQGtlcm5lbC5vcmc+DQo+PiANCj4+PiBkaWZmIC0tZ2l0IGEva2VybmVsL2JwZi9o
YXNodGFiLmMgYi9rZXJuZWwvYnBmL2hhc2h0YWIuYw0KPj4+IGluZGV4IGE4YzdlMWM1YWJmYS4u
ZmQ4ZDRiMGFkZGZjIDEwMDY0NA0KPj4+IC0tLSBhL2tlcm5lbC9icGYvaGFzaHRhYi5jDQo+Pj4g
KysrIGIva2VybmVsL2JwZi9oYXNodGFiLmMNCj4+PiBAQCAtMTU1LDEzICsxNTUsMTUgQEAgc3Rh
dGljIGlubGluZSBpbnQgaHRhYl9sb2NrX2J1Y2tldChjb25zdCBzdHJ1Y3QgYnBmX2h0YWIgKmh0
YWIsDQo+Pj4gICAgICAgIGhhc2ggPSBoYXNoICYgbWluX3QodTMyLCBIQVNIVEFCX01BUF9MT0NL
X01BU0ssIGh0YWItPm5fYnVja2V0cyAtIDEpOw0KPj4+IA0KPj4+ICAgICAgICBwcmVlbXB0X2Rp
c2FibGUoKTsNCj4+PiArICAgICAgIGxvY2FsX2lycV9zYXZlKGZsYWdzKTsNCj4+PiAgICAgICAg
aWYgKHVubGlrZWx5KF9fdGhpc19jcHVfaW5jX3JldHVybigqKGh0YWItPm1hcF9sb2NrZWRbaGFz
aF0pKSAhPSAxKSkgew0KPj4+ICAgICAgICAgICAgICAgIF9fdGhpc19jcHVfZGVjKCooaHRhYi0+
bWFwX2xvY2tlZFtoYXNoXSkpOw0KPj4+ICsgICAgICAgICAgICAgICBsb2NhbF9pcnFfcmVzdG9y
ZShmbGFncyk7DQo+Pj4gICAgICAgICAgICAgICAgcHJlZW1wdF9lbmFibGUoKTsNCj4+PiAgICAg
ICAgICAgICAgICByZXR1cm4gLUVCVVNZOw0KPj4+ICAgICAgICB9DQo+Pj4gDQo+Pj4gLSAgICAg
ICByYXdfc3Bpbl9sb2NrX2lycXNhdmUoJmItPnJhd19sb2NrLCBmbGFncyk7DQo+Pj4gKyAgICAg
ICByYXdfc3Bpbl9sb2NrKCZiLT5yYXdfbG9jayk7DQo+IA0KPiBTb25nLA0KPiANCj4gdGFrZSBh
IGxvb2sgYXQgczM5MCBjcmFzaCBpbiBCUEYgQ0kuDQo+IEkgc3VzcGVjdCB0aGlzIHBhdGNoIGlz
IGNhdXNpbmcgaXQuDQoNCkl0IGluZGVlZCBsb29rcyBsaWtlIHRyaWdnZXJlZCBieSB0aGlzIHBh
dGNoLiBCdXQgSSBoYXZlbid0IGZpZ3VyZWQNCm91dCB3aHkgaXQgaGFwcGVucy4gdjEgc2VlbXMg
b2sgZm9yIHRoZSBzYW1lIHRlc3RzLiANCg0KU29uZw0KDQo+IA0KPiBJbHlhLA0KPiANCj4gZG8g
eW91IGhhdmUgYW4gaWRlYSB3aGF0IGlzIGdvaW5nIG9uPw0KDQo=

