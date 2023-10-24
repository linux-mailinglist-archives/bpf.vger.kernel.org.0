Return-Path: <bpf+bounces-13097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127937D45E6
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 05:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB259281818
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 03:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448515226;
	Tue, 24 Oct 2023 03:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JIxoEnB/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4074C1FAD
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 03:25:33 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1196BC
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 20:25:30 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NMVs17030963
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 20:25:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ezOHkFKglXu76lK9/7tTmOkg6Q2hNbAigJD/SDvwVWA=;
 b=JIxoEnB/8nT3V8JEnetQqOyW8GknsHVMODWaqyNnCIqeoSi3wUNOzGvCokmU17l3VfbJ
 vqV+TRbNt9vrwfljINrc+CdKRt8mFuTk5S1MQNpzEUQAYklgS/biUhIQlr3WYz+dip3O
 0imxxrh6EUPo77g2wJiTZoP5V/dPSedkx3K3NKEJSsjTXNuc7LRvHF811ZyOAQpWvHEe
 v1qriBshAvcu8jt6qyre8d574sO5QtKD6StskHV4x1uT6x1YWZrAq5NeNDmDLKt77pNW
 24blQCYIWlAbVmgAYiqWI1nXO+EsPfuCSZT34dH4V8YE/h6tgRZd4U5MiYE9Onp9LEU3 rQ== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3twu6649m5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 20:25:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEbWf+UTcYantsznYsmt0n3W4s2cVWRjLfpZQ6ibpRtFTw7TYPDytt6xWQhV7wADK+CP/JRBmm5IR18vjDAU4mFiq0hqMexjl4+r2SphqkMyJq4LWVSr7GmvOjKWLI0g99Uk6XpekUL8zpt5jKQUwLE45BCQZa/GYuruqzE8XDtTVg+MPWV/vZUI2fu6vckB6Lh/asfiwT4EkLEcJh14pEw5xr24nL12bcR5WDcgYK0QBd1wZbUKj9VsyrBzyftvHfFkjTxMsh3cQ/7B83bmrGdD0DxwwQMTkc+ShBA209wXjzMMi7W+pTGCmOnobjviblNDjlkfJIaEcbw4FB1QPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezOHkFKglXu76lK9/7tTmOkg6Q2hNbAigJD/SDvwVWA=;
 b=lWSUb69IMMjb/p18LVqAgh+oJFz6GrwfTpA9rD85VFmBtwyDqYoyOrjkYpt0e0Nqr9bzhU0c9oog/fhphoDa69caMInb+3cVV32zlCnR9FXOHvD2h63CuNIbUXJQsQH4Mu4XUkbgxHlz0d4TH+HiIMHSu+OnBv5gP8yx6Z59NlFBKEvTwURkcOMd2k5fsOa4mdxyHnhb5Ri8aTMu9YMHPT5RyJh7dzVQNf+kzrhsJZHXMM2wTZZhU+WPW3oHillqPpzNpMKeOtoD0lsCej0NlHKokCYFKX1m/3yBbrClpL7G7SsTXgKpK+lOygL7cFyhFv4OeDqN26RrgkUDzlkZhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by LV2PR15MB5383.namprd15.prod.outlook.com (2603:10b6:408:179::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Tue, 24 Oct
 2023 03:25:27 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c495:8487:66f1:18be]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c495:8487:66f1:18be%4]) with mapi id 15.20.6933.014; Tue, 24 Oct 2023
 03:25:20 +0000
From: Song Liu <songliubraving@meta.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
        Eric Biggers <ebiggers@kernel.org>, Theodore Ts'o
	<tytso@mit.edu>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH v4 bpf-next 3/9] bpf: Introduce KF_ARG_PTR_TO_CONST_STR
Thread-Topic: [PATCH v4 bpf-next 3/9] bpf: Introduce KF_ARG_PTR_TO_CONST_STR
Thread-Index: AQHaBgISFv6qUEb2J0WhMNUtoh6w8rBYG8mAgAArlIA=
Date: Tue, 24 Oct 2023 03:25:19 +0000
Message-ID: <90721298-D511-4C37-B8BC-947215BFA59E@fb.com>
References: <20231023224100.2573116-1-song@kernel.org>
 <20231023224100.2573116-4-song@kernel.org>
 <CAADnVQJ-u_j8p7FMOpDHsUKjTa0E9sjA0G=zG8V484kuatNDvw@mail.gmail.com>
In-Reply-To: 
 <CAADnVQJ-u_j8p7FMOpDHsUKjTa0E9sjA0G=zG8V484kuatNDvw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.100.2.1.4)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|LV2PR15MB5383:EE_
x-ms-office365-filtering-correlation-id: 3347623e-d833-4b1b-8daf-08dbd440d9cf
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 mZgTXrbBzckX7eTbepa03aOEVvgqRP96ExJ/3q+A3MRDYy/TdbO4lxZqjRPau1V3ho6eOC4T0k9VMR3RnCFKCGTr9Bmlz/lydx8wLvEwiorNZU1GTG+0xCjyBKhhuTmQfxuItXQVcqHgZABOtqtrs1vi1s7MAnTbZvZ7pasIFCV+sS42RiI76Z4nuqN5dnJPWGm/Y8ZFvJ+Jhtv+nhiPsqmySkVdHMVhNV5MJQDzKFv9uqMHUIgR3DLN8ShAAw9pe+aJPwG4Z9WnkibyNML/FNye+2rX4E/mNTuBPCni5EIA8+M5VM5mFwEEH90ZQ5pVXDtqXBkCHC5c0fBccF3UuH6VidfVd1gCf/LucaPkUkFk5WYG8IqPabB3HkSltzgcR71FaZSmqnxlrDXEt1DuIjyJ65aEd/blxop8FBeQjVHrqUfc5K4G3WGib16oiCOqGrFNpBekVHLYBjdKMhuep5tvB6bds11I8u1vuuDhr3zM/DgBFchm0KAlQ5DNgdOJOMouBvZVhgxd+j+n/1gD2hpv681C7HLyy6oU9Ykm3XzVCVZN1vmfuDsXtFeQgY6sI+VlrxF9BFBHviF4v7YIppnoWzHB2TB6Uwq0BtAoA+ZcDfAJdDa5yFYrWWD0KjAr
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6512007)(9686003)(6506007)(8936002)(71200400001)(53546011)(83380400001)(4744005)(5660300002)(41300700001)(4326008)(2906002)(6486002)(7416002)(478600001)(8676002)(76116006)(64756008)(91956017)(66556008)(66946007)(38070700009)(316002)(6916009)(54906003)(66446008)(122000001)(86362001)(38100700002)(66476007)(36756003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bTNMcWtzL1BYSC90MXcwOUhFcjNMR2FTckMzRkhvQ3BObFZHRnM1SDZONCt3?=
 =?utf-8?B?TkcxdSs0WGtOU0IzclhEQzBXTlltbTRZZ2JNYXowSVlsTjdTY0JCaTNJQTJw?=
 =?utf-8?B?aDBadHc2YlVQMU8xYVFIVTIrd1hLM3ZZdkp6RUVDSkpvRDRFZ29icWhSaU5a?=
 =?utf-8?B?d2Q5TGptZzdWZUdrSUY5REVSVlZ1Zzk0TVRKOFI4R0pWNEdBVVE1VVVIQzIy?=
 =?utf-8?B?cy9oUjdrUkVKZXFnV0pBYmk0YUFtQ240VkNvbWFlbDZDRGs3WVJieWxmNndv?=
 =?utf-8?B?d0NKZzd1SnhlVUJodWFka0MxeTJsblNjNTU3UERlS2Y4U0xRcDNQZjZxSU9p?=
 =?utf-8?B?ZXpVV2kwb0xtOW5KMFN5d3h6eHZESnFOeDFkNXZPMlRLNkJXY2ZCREJldzVO?=
 =?utf-8?B?U1gzTk9SMzVjTTRmeTJDaEpZdUxxZzNXdkIzUkw4WDBaTXhrSEtTMlQrR2Nj?=
 =?utf-8?B?eUJKUnIwWnBmalVkQmNKTXByYkNHeXBRVDdtZXVMYldGODJIYkxydFlTNmtL?=
 =?utf-8?B?R3ZLU2J2UER3WDR5ZjErQWU0VldmTC93QjAvQmwzR1RzYm9NYTdxOWVZVFBn?=
 =?utf-8?B?cUgzZEJaNkNWcERBbjMvU0dKRTFFd3VOREVnS3FtckRiM1dmellscVNOUXFl?=
 =?utf-8?B?WnZ2aWlYNWtRWnpvTTVFVVh6R2I4V2RmWU1kOXBKd2Qzc0ZwQzJzRXk0c3Bo?=
 =?utf-8?B?Mk1zbWdTTGt1eDROdVprNTFSQXYvcGZiTEJSWXVUU0Q5SDRSeDZnSmxKQ2l2?=
 =?utf-8?B?ckoycXN4VEVMY0NNeDdwSHloUk00NE1ucnQzZWxUcE5jY25SSExOc0l3VnVl?=
 =?utf-8?B?ZVFyWkozUUlxZVNXMElGSXZXM0ZscWdETEZhUFlhSFBxNWdSYkp0czFJVGRH?=
 =?utf-8?B?UkJEK3IrNjF3WjBrOXpVUElGVHdxMzhlNWt2WEFuek80YkJ0YWQrTjlKd0gz?=
 =?utf-8?B?czBJVjRpOUZkUXZkYzltSTd1TWNodXUrSUU0NlhJOFVQeG1id2RTbzBKUEIx?=
 =?utf-8?B?VEZ6YlZPZnFYbDluS2JWbWdCZklwS1I0OUhDUytUMU43M0FFZXhyWWptcmlw?=
 =?utf-8?B?QjNDTW5vRldSdkdvY1lwSGNueXE1KzQxYm5jRWxGcGZ5SFVqdFVUeFFSd0V2?=
 =?utf-8?B?dkkxVHVWeFFXMlBHakxlbjNCbkxtS0xhV3FnRzdZclJwSzFTc292akF0NE5X?=
 =?utf-8?B?eis4VWNiU3E4bExGZkVaeWE1SG5tdU9MMFBkMzg0N25CZjZIOE8rUEQ5RzZy?=
 =?utf-8?B?TTk2cDlVbW9BdW0rcTZvWnUvK1hWWGt0MUhOT1ZGTGlhNzNWZ3kzUE4xSUFC?=
 =?utf-8?B?MWJyc28xdWxSdzhMak9CRC8xcGVscldqK3F1M053T2M5YkhmQ1JhcFZCU1A4?=
 =?utf-8?B?ZHJyRWUxYSt6WmFiVG5hTUhaVXUxS0p3dGhTc05YN3QwM1h4UE4wa1Vzb0Ev?=
 =?utf-8?B?N3UzV2lkSGt6KzNjM3kvazV4TElnRW1UWlB6S2drdVpjcWZmZEMraVZEWUh2?=
 =?utf-8?B?YVlTc2J5a2FCWVhnU3I5bzJocjVLeXZvTDYwT2M5RjJjbFEyRTVLbVk3bDNH?=
 =?utf-8?B?b3pNMFFwUG53Q2h0NDRRWTFUVWdzcXZxS3dReXlCaHB0MkpjVWRGdTlCMmhB?=
 =?utf-8?B?YkxKV3cvOUNpUFliVXBDdGVBQnlDS3dHNXRBeGpEbTBTK0p4ZGhXN1dCVnkx?=
 =?utf-8?B?SmtqbjhIMFI4RW9yR2Y0THZwR1VEYnFyUUJpVXVrRE1yanhmYmhlRkFrcnd2?=
 =?utf-8?B?VzZFRWxkTFFNeTF0dEtRS1J6aThPV3dFanhsQUpJMW0vOXQxTVVwS3cwTlhj?=
 =?utf-8?B?eXpNV2dMOWxlQlJlNmxkZEs0cUF4OWtXWHRlVndFWlI3cW45U00wSnVGbmlO?=
 =?utf-8?B?MndSaWFjQVRlK25JY1VaTE9sL3pidFRqcXFxdS9ONGE2eUlZcGV3NEd1Nmcw?=
 =?utf-8?B?KysrdWd0cU92WWVzd0oveHExV1dGa3Q0S3VKTlhsSXRjOGdxb2J2UG15eTZK?=
 =?utf-8?B?UTRsODNvMlE1akJIWmMvMkYzVTl4Wk1IUmRUZHpheGlUenhQRE55WXA3eWYz?=
 =?utf-8?B?dElGcFo3cGc5ZUc0bm00Tk0rQ2ZDRzkwUXVEMEZjL0IwdDFVdlg2VndmZXhr?=
 =?utf-8?B?Nk94akVVUE5LbE9wTlU4eis1czBlR1N4MmxNV09WNDJ5ZEQ2STluQXBoK2hX?=
 =?utf-8?Q?f8RTPGsNImOLzGpqC0mvuFo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <372E3A6ADDAA434B967C47345C67DC4B@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3347623e-d833-4b1b-8daf-08dbd440d9cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 03:25:20.0289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KIMMg4AUoTw3bIu56+QIVVlTjFKUpXrx6vG1M/Sd987lChhuo/SRkbMUJ3bQat8Le565UB76qvhICiSR9ctq1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR15MB5383
X-Proofpoint-ORIG-GUID: hkw6SFJwCg_aAy2UwrD9zCHNq82eiLBE
X-Proofpoint-GUID: hkw6SFJwCg_aAy2UwrD9zCHNq82eiLBE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_01,2023-10-19_01,2023-05-22_02

DQoNCj4gT24gT2N0IDIzLCAyMDIzLCBhdCA1OjQ54oCvUE0sIEFsZXhlaSBTdGFyb3ZvaXRvdiA8
YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIE9jdCAy
MywgMjAyMyBhdCAzOjQx4oCvUE0gU29uZyBMaXUgPHNvbmdAa2VybmVsLm9yZz4gd3JvdGU6DQo+
PiArDQo+PiArICAgICAgICBfX2JwZl9rZnVuYyBicGZfZ2V0X2ZpbGVfeGF0dHIoLi4uLCBjb25z
dCBjaGFyICpuYW1lX19jb25zdF9zdHIsDQo+IC4uLg0KPj4gKyAgICAgICAgICAgICAgIGNhc2Ug
S0ZfQVJHX1BUUl9UT19DT05TVF9TVFI6DQo+IA0KPiBDT05TVF9TVFIgd2FzIG9rIGhlcmUsIGJ1
dCBhcyBfX2NvbnN0X3N0ciBzdWZmaXggaXMgYSBiaXQgdG9vIHZlcmJvc2UuDQo+IEhvdyBhYm91
dCBqdXN0IF9fc3RyID8gSSBkb24ndCB0aGluayB3ZSdsbCBoYXZlIG5vbi1jb25zdCBzdHJpbmdz
IGluDQo+IHRoZSBuZWFyIGZ1dHVyZS4NCg0KSSB0aG91Z2h0IGFib3V0IHRoaXMuIFdoaWxlIHdl
IGRvbid0IGZvcmVzZWUgbm9uLWNvbnN0IHN0cmluZ3MgaW4gdGhlIA0KbmVhciBmdXR1cmUsIEkg
dGhpbmsgX19jb25zdF9zdHIgaXMgYWNjZXB0YWJsZS4gVGhlc2UgYW5ub3RhdGlvbnMgYXJlIA0K
cGFydCBvZiB0aGUgY29yZSBBUElzIG9mIGtmdW5jcy4gQXMgd2UgZW5hYmxlZCBvdGhlciBzdWJz
eXN0ZW1zIHRvIGFkZCANCmtmdW5jcyB3aXRob3V0IHRvdWNoaW5nIEJQRiBjb3JlLCBpdCBtYWtl
cyBzZW5zZSB0byBrZWVwIHRoZSBhbm5vYXRpb25zDQphcyBzdGFibGUgYXMgcG9zc2libGUuIE1h
a2luZyBfX2NvbnN0X3N0ciBhIGxpdHRsZSBzaG9ydGVyIGRvZXNuJ3Qgc2VlbSANCnRvIGp1c3Rp
ZnkgdGhlIHJpc2sgb2YgY2hhbmdpbmcgaXQgaW4gdGhlIGZ1dHVyZS4gDQoNCkFsc28sIHdlIGFs
cmVhZHkgaGF2ZSBsb25nZXIgYW5ub3RhdGlvbnMgbGlrZSBfX3JlZmNvdW50ZWRfa3B0ci4gU28g
SQ0KcGVyc29uYWxseSBwcmVmZXIgdG8ga2VlcCB0aGUgYW5ub3RhdGlvbiBhcyBfX2NvbnN0X3N0
ci4gDQoNCkRvZXMgdGhpcyBtYWtlIHNlbnNlPyANCg0KVGhhbmtzLA0KU29uZw0KDQo=

