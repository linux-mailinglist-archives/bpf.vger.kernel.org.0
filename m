Return-Path: <bpf+bounces-12852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C153E7D14FC
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 19:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722D928258F
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 17:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D5E20321;
	Fri, 20 Oct 2023 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.rutgers.edu header.i=@cs.rutgers.edu header.b="dTogqq/d"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0701D529
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 17:37:39 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2107.outbound.protection.outlook.com [40.107.212.107])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDC311B
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 10:37:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TER+JTKsj78hGgp2uj0TXqD9kAoyTnmT4SI8CoGdIgi7IDwuW5fJVTGgGDa6p/JHvJbzs3+pdWVEkEnTqar+Jk7C7/L1q7IbCxgf1Y6M99EoSGHudL+hWt+E44nuu0L+fOZiyDw+XXR9eSdHHu/z4l5cH72nYiDu3ypA929w2d4yx8dshOVHcxMprKJ0QlHnMrZl5oHjtxrFZvACntguV4Q2UxuWhUt96H+J4qqUGUqrApzEfQ9woR43pfte8VxbvFoCgegQOjc0Bx0Sg3TEZ29qWJvbakW5WCxU/4o56Hp93KZKMA+LPIYZvvZOqvhBgQzSL50acrlwpy0MN5VOVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJOeeN/gyWl1w9QAYdN7Nw8HrtBVJCMf1FkQWENZV1g=;
 b=Kwj9rP/nCXIDvDEneQfklFc/DJjw003t+HTwHprY5dV4vh1qqQ8VkjJec8VbhrVM4U/irw/QaWfwQKagP8U8kuhMSWJIgmDjh2Ao33aY+muXNWKmNrwb+QTcUUDcBWx/PVkxivKrzasYNtQix3l1qKtu16IpZLhY/7FJ9tWwCbChqu9K3nfD0TebwWiV9QmXqjOvnjL8gH5z65qjfXkaXnHk1xUaS2W1vo3heRv4Ih6pAw0QSDIjbClpua+lGozkOpal11HICxv5eAjcbKW68PrOBOwqqlhVqYIir1f67mQ+obPZuOZ5rEXxerKH6SYakFh2jwSh/5L6yKgtVmZnjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs.rutgers.edu; dmarc=pass action=none
 header.from=cs.rutgers.edu; dkim=pass header.d=cs.rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJOeeN/gyWl1w9QAYdN7Nw8HrtBVJCMf1FkQWENZV1g=;
 b=dTogqq/d0/dymInlrmz8kTqqZOiVNSL96wUmDwaQ0HJEO2hq6gskZBbOnYTQMWIXrp0e/A7Rd9VmQnGpEBWDmEQk81NlsHnplCnPPFOmA6kq8H9du0CNMlqcRghGXEGqHhp//EowdjFdQZjGE5SavYYDgbK85xCO0UQa8yOzj/Y=
Received: from CO6PR14MB5188.namprd14.prod.outlook.com (2603:10b6:5:35c::11)
 by DM6PR14MB3948.namprd14.prod.outlook.com (2603:10b6:5:214::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 20 Oct
 2023 17:37:35 +0000
Received: from CO6PR14MB5188.namprd14.prod.outlook.com
 ([fe80::a4a1:2403:28aa:3db6]) by CO6PR14MB5188.namprd14.prod.outlook.com
 ([fe80::a4a1:2403:28aa:3db6%3]) with mapi id 15.20.6907.021; Fri, 20 Oct 2023
 17:37:34 +0000
From: Srinivas Narayana Ganapathy <sn624@cs.rutgers.edu>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: Shung-Hsi Yu <shung-hsi.yu@suse.com>, Andrii Nakryiko <andrii@kernel.org>,
	Langston Barrett <langston.barrett@gmail.com>, Srinivas Narayana
	<srinivas.narayana@rutgers.edu>, Santosh Nagarakatte <sn349@cs.rutgers.edu>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org"
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"martin.lau@kernel.org" <martin.lau@kernel.org>, "kernel-team@meta.com"
	<kernel-team@meta.com>, Harishankar Vishwanathan
	<harishankar.vishwanathan@rutgers.edu>, Matan Shachnai
	<m.shachnai@rutgers.edu>, Paul Chaignon <paul@isovalent.com>
Subject: Re: [PATCH v2 bpf-next 7/7] selftests/bpf: BPF register range bounds
 tester
Thread-Topic: [PATCH v2 bpf-next 7/7] selftests/bpf: BPF register range bounds
 tester
Thread-Index: AQHaAl4uasOKfGTXzkWn7Ehow4/czrBQvY+AgACzcICAAYJ8AA==
Date: Fri, 20 Oct 2023 17:37:34 +0000
Message-ID: <1DA1AC52-6E2D-4CDA-8216-D1DD4648AD55@cs.rutgers.edu>
References: <20231019042405.2971130-1-andrii@kernel.org>
 <20231019042405.2971130-8-andrii@kernel.org> <ZTDbGWHu4CnJYWAs@u94a>
 <ZTDgIyzBX9oZNeFw@u94a>
 <CAEf4BzYgJR6SAjbvd0uZ6w8D37Sy=Wjd2TROOGEAZDiEq7xb2g@mail.gmail.com>
In-Reply-To:
 <CAEf4BzYgJR6SAjbvd0uZ6w8D37Sy=Wjd2TROOGEAZDiEq7xb2g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3696.120.41.1.4)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs.rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR14MB5188:EE_|DM6PR14MB3948:EE_
x-ms-office365-filtering-correlation-id: f06d51c8-93ce-4609-991a-08dbd1933ed3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MoWY1hwv+3Zwl6VI/F0WTibYiogfIRHobt6mi8zCDJCI4b8B6STIaPS7D8FiiBFXalYxt0wuG5M0sXj+MriYuQW3FP38lq9pByKD3ceMmY7V3oyhNKmMzHg87EAlvqi8nFxjLvGI2PZL/n9JkP+3dxPaFnK8UUYQswxKP//2R4Kh/wTEmydNPg9xZZRtcE3sXNCSw0GkLuIjh+e75e2EvoPz0mL1iHOmcFhCexySW+OZGWDEt+8ARFso9LOzvbWA59pa3GlP7Xhp08d0yRbDHGHiH6/lSOoeaqheYxYAGRU8+VcIi1Q31X9B1+jGV/btQJQ5oUwb+M5TGEpHjcgQywbjgrAkItRWYuZGAX9IUcygwA0300V4p5f2uHa6TqAaXzj87cCpmAoWUc06si4g1Ni0crPpv6W4FibMZkUya09BDkStJONbtP/LF0qvJd2qIwC99PcohS38IQd+9hFks/1RWVrqZvtAT2A2EKYyr6x8ALNZgAifiD8jKKhDpVZ3hpRSO31Fu8wbJU3zu9IOLK5T+kjWyPsixT7sEGRlFngLmLGJocNgj/Bx8Ai+VLN2Bdpdg157GA39A/G9QkptpaLejPN7fLeiX7WGoEvIoSOCT35cFdEq/hJPLU28x4Z9snpPB4m8FVdYQCHeRZHftA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR14MB5188.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38070700009)(71200400001)(8936002)(2616005)(53546011)(8676002)(66476007)(41300700001)(316002)(91956017)(478600001)(966005)(33656002)(2906002)(6916009)(6486002)(64756008)(6506007)(54906003)(76116006)(66446008)(786003)(122000001)(86362001)(75432002)(38100700002)(4326008)(7416002)(66946007)(45080400002)(66556008)(83380400001)(6512007)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N25KcTFjN09QVytXRmRyOGRmZjRaREpWYU53aXVIenhEUllDTHlhbktOZG9S?=
 =?utf-8?B?VkpLTVRwNGw4aTQ3RUhrUDlzZEFHSUg1MGhlU3hOanZ6NllKVERzNCtGY0N6?=
 =?utf-8?B?VGxQUWhYNUVNV2I0S0wzaDBaRy96STZQK1gvUUM0TXhGeG1IMnBzV2I3dFVS?=
 =?utf-8?B?UU1ud1BSaTZZRkpqaUFadHdRSEk2bDdERFNVTjU4aUphWW1ubFR6RHNBOERs?=
 =?utf-8?B?UEYwNEtaazVRY1dxREhJdUZDZ1JXU2FqaEtnV2Nnd2dmeDJZcjZ1L3JkbXo3?=
 =?utf-8?B?K0Rlb2pGTGFKWDFVOEVXNTVDMVZVN3hMMlRzNi9mcS9sMW5GOVQ1TjRGall1?=
 =?utf-8?B?WWxPLzZ1NXB5TUZUa2huQ2NROWpGMlN6ZkFXNG5nSG42QlZmMXdVbkVZUFlj?=
 =?utf-8?B?bUs5UlROblBOOGNDNFRYVmpPNHZ3YzJuZCtGTytjaE9JTkdManhDNlFKSTZY?=
 =?utf-8?B?RGx5ZGxyN1pmVFR2QitsYmJ5R3pHYzcxRThyUmtEZWM2TE1sUXpIMXQ0Zzd0?=
 =?utf-8?B?NGQrSmNOZkE0YkJLc05PZTVDclFuRXBFc1dYUVhqMkxoVnpUOUZMdEJjQVN0?=
 =?utf-8?B?VmhlM2tUdi8zNjIxRUF4d3VUeUZja3g2SXduN1VVOGdCemFUN3JpR3hHdG5o?=
 =?utf-8?B?M2dTSU0xOXZ0dWVPWW8vT3pidjNaVGhGcTkwUmpFdU1OSVFuODI0WHZra1Bm?=
 =?utf-8?B?ZlFaK2ZPL3lZWFIyVE9Lc3hoSENpYWpnekxRdFhsRjdENlZYenNNczFQdFZp?=
 =?utf-8?B?TWptaDVRMDBScUhpMUoyWHU1QjBVN0xRdWh4a01iL2o2NHczcmEycmFDNXhj?=
 =?utf-8?B?bllSRXdtSDI3OFRST0RPcm1IazcrNVQxOWp1R3VMZHVVQUR2VmNhMzN0c2hv?=
 =?utf-8?B?VTV1eEVObzkvU1dMN2pEcW9DUFRVQ1IyQnJSYmZSaFd4YkN6dmNJRmdUMDBj?=
 =?utf-8?B?MXM5dWxZWTc4cVhtc0lNamtGMVhyeDJ2akMyWUh1SmMwdXZyanZQUlRaVUl0?=
 =?utf-8?B?OXZOT1Z2WlJDanRHZEwyN2ZBbVBZeWxhb3g0ckhWdHpDb2JRTksyZmtrblRm?=
 =?utf-8?B?aTl5UWZ2ejV0TFhQcXNiMWlwSlg4aWdxOXNtZVIzSmJtQXo2cFVTY1dTaU5h?=
 =?utf-8?B?ajJ5NWVHc04wNkh2aGY5bkcxUWFpOTJqVFR4aWFsb2RXVHFvNFdEUzRoRzh1?=
 =?utf-8?B?VVdvcFlLcVA0SjllN2VsUUFiaWtDN2txbjhjaHlKYzhQUzNoNlQzL2t1Y2xV?=
 =?utf-8?B?YzhKczdBT25ZSk11STlqcjBrZEw2bTBhNTgwOE5hejBTN3BmeWU4dS9od21q?=
 =?utf-8?B?MkErNDBVbXBlSjcwWHZ5SUVUVEV3N0VhMjBVTmdLN3hYeUJ4VGRrL0hFOGN5?=
 =?utf-8?B?VXI0ZHVtNHVYUitzMmxsZ2ZxWU1WK0V5T3Uvbk9iMHhxajMzN1R0S1ZoSXJl?=
 =?utf-8?B?MWVxMWRDTzFHOWZMSmxHNWJ6QVFRaG1URU5uYWpRWU5YbCtSWWkveUQrcFhE?=
 =?utf-8?B?OUxrR254V3pTbnNEMkNyanhjQjZFSHlMUmZ4NFZ3eStWY25WWnR2eFVOcHU2?=
 =?utf-8?B?NFNudUx5M001MXN0UFlnMTNyYXVGR1dnYnVrYkcvWnA0REFKRldwUlUveDRH?=
 =?utf-8?B?UDljRTFnZXdSbHF0Ry9hcXF6U3FsNmFRdXhnWmM3a2RodkVJd1FrRWh3dk1n?=
 =?utf-8?B?U1R5YUpqaE5JdWt5YTVmcTVtVys3THRsZkNhc1NiU0tQY2NCZVJKV0hEOEdQ?=
 =?utf-8?B?cTRsWnRaV0RZaWhFUnlmOXdiUTRsVXRoYXhNVWtSTGlSTTdscElWRG1tTjBp?=
 =?utf-8?B?cW5kT0FZZFRrSFppcFY5UW9TNWJYblFRN3pEaXBLalZFQWhmRlRUcFdjRTN3?=
 =?utf-8?B?dXJjRVRFVDd6c09qZVQvVTFqV1ZFaXdUUTY1RWlTZWtTZmdaUWM2SWZpQUp6?=
 =?utf-8?B?ZDlBMlMyRUdTbFhSMUp5cVFnVXpWbmdmS0FKbE5kTG9IQjZaUGJOdWNNNEVh?=
 =?utf-8?B?SnNUbkhPeHUvTXRDN2V2cEJWTDJqZmo3dUY5NFQ3QjZuMGxJOHFOcG1MNktw?=
 =?utf-8?B?dUxydU9FS2wwNHJVMmY2a1Z3eWlkZTlHL1YxcjZrRUVGQzVXRjZMYUFMQUxT?=
 =?utf-8?B?MGpjTERSalp1Ums4SllWZWhwUENwVjNIQzhQZ0hVSEVVYmxTMnVybkVSNTkz?=
 =?utf-8?B?TytZcldvZ2NjRGo5cmxsT1NPOHRvQ0IvTlQ3bVZ3Vi9ja21VelRrbXRHSUZi?=
 =?utf-8?B?QXJUNXg0SFYzRTRIMTdEVVRTd1NBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87648A7C8AAB3E45814F40FC6BAAD39A@namprd14.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cs.rutgers.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR14MB5188.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f06d51c8-93ce-4609-991a-08dbd1933ed3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 17:37:34.7212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NnHa0JggWLsA9QXv4tFsWzKfaD1bAGS6S3YA0iy9e9dTSz1bUu+U2MjbAQWJm6CtlTb+TlOCXNxLoDi1lxb2yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR14MB3948

SGkgYWxsLA0KDQpUaGFua3MsIEBTaHVuZy1Ic2ksIGZvciBicmluZ2luZyB1cCB0aGlzIGNvbnZl
cnNhdGlvbiBhYm91dA0KaW50ZWdyYXRpbmcgZm9ybWFsIHZlcmlmaWNhdGlvbiBhcHByb2FjaGVz
IGludG8gdGhlIEJQRiBDSSBhbmQgdGVzdGluZy4NCg0KPiBPbiAxOS1PY3QtMjAyMywgYXQgMToz
NCBQTSwgQW5kcmlpIE5ha3J5aWtvIDxhbmRyaWkubmFrcnlpa29AZ21haWwuY29tPiB3cm90ZToN
Cj4NCj4gT24gVGh1LCBPY3QgMTksIDIwMjMgYXQgMTI6NTLigK9BTSBTaHVuZy1Ic2kgWXUgPHNo
dW5nLWhzaS55dUBzdXNlLmNvbT4gd3JvdGU6DQo+Pg0KPj4gT24gVGh1LCBPY3QgMTksIDIwMjMg
YXQgMDM6MzA6MzNQTSArMDgwMCwgU2h1bmctSHNpIFl1IHdyb3RlOg0KPj4+IE9uIFdlZCwgT2N0
IDE4LCAyMDIzIGF0IDA5OjI0OjA1UE0gLTA3MDAsIEFuZHJpaSBOYWtyeWlrbyB3cm90ZToNCj4+
Pj4gQWRkIHRlc3RzIHRoYXQgdmFsaWRhdGUgY29ycmVjdG5lc3MgYW5kIGNvbXBsZXRlbmVzcyBv
ZiBCUEYgdmVyaWZpZXIncw0KPj4+PiByZWdpc3RlciByYW5nZSBib3VuZHMuDQo+Pj4NCj4+PiBO
aXRwaWNrOiBpbiBhYnN0cmFjdC1pbnRlcnByZXRhdGlvbi1zcGVhaywgY29tcGxldGVuZXNzIHNl
ZW1zIHRvIG1lYW4NCj4+PiBzb21ldGhpbmcgZGlmZmVyZW50LiBJIGJlbGlldmUgd2hhdCB3ZSdy
ZSB0cnlpbmcgdG8gY2hlY2sgaGVyZSBpcw0KPj4+IHNvdW5kbmVzc1sxXSwgYWdhaW4sIGluIGFi
c3RyYWN0aW9uLWludGVycHJldGF0aW9uLXNwZWFrKSwgc28gdXNpbmcNCj4+PiBjb21wbGV0ZW5l
c3MgaGVyZSBtYXkgYmUgbWlzbGVhZGluZyB0byBzb21lLiAoSSdsbCBsZWF2ZSBleHBsYW5hdGlv
biB0bw0KPj4+IG90aGVyIHRoYXQgdW5kZXJzdGFuZCB0aGlzIGNvbmNlcHQgYmV0dGVyIHRoYW4g
SSBkbywgcmF0aGVyIHRoYW4gbWFraW5nIGFuDQo+Pj4gaWxsIGF0dGVtcHQgdGhhdCB3b3VsZCBw
cm9iYWJseSBqdXN0IG1ha2UgdGhpbmdzIHdvcnN0KQ0KPj4+DQo+Pj4+IFRoZSBtYWluIGJ1bGsg
aXMgYSBsb3Qgb2YgYXV0by1nZW5lcmF0ZWQgdGVzdHMgYmFzZWQgb24gYSBzbWFsbCBzZXQgb2YN
Cj4+Pj4gc2VlZCB2YWx1ZXMgZm9yIGxvd2VyIGFuZCB1cHBlciAzMiBiaXRzIG9mIGZ1bGwgNjQt
Yml0IHZhbHVlcy4NCj4+Pj4gQ3VycmVudGx5IHdlIHZhbGlkYXRlIG9ubHkgcmFuZ2UgdnMgY29u
c3QgY29tcGFyaXNvbnMsIGJ1dCB0aGUgaWRlYSBpcw0KPj4+PiB0byBzdGFydCB2YWxpZGF0aW5n
IHJhbmdlIG92ZXIgcmFuZ2UgY29tcGFyaXNvbnMgaW4gc3Vic2VxdWVudCBwYXRjaCBzZXQuDQo+
Pj4NCj4+PiBDQyBMYW5nc3RvbiBCYXJyZXR0IHdobyBoYWQgcHJldmlvdXNseSBzZW5kIGt1bml0
LWJhc2VkIHRudW0gY2hlY2tzWzJdIGENCj4+PiB3aGlsZSBiYWNrLiBJZiB0aGlzIHBhdGNoIGlz
IG1lcmdlZCwgcGVyaGFwcyB3ZSBjYW4gY29uc2lkZXIgYWRkaW5nDQo+Pj4gdmFsaWRhdGlvbiBm
b3IgdG51bSBhcyB3ZWxsIGluIHRoZSBmdXR1cmUgdXNpbmcgc2ltaWxhciBmcmFtZXdvcmsuDQo+
Pj4NCj4+PiBNb3JlIGNvbW1lbnRzIGJlbG93DQo+Pj4NCj4+Pj4gV2hlbiBzZXR0aW5nIHVwIGlu
aXRpYWwgcmVnaXN0ZXIgcmFuZ2VzIHdlIHRyZWF0IHJlZ2lzdGVycyBhcyBvbmUgb2YNCj4+Pj4g
dTY0L3M2NC91MzIvczMyIG51bWVyaWMgdHlwZXMsIGFuZCB0aGVuIGluZGVwZW5kZW50bHkgcGVy
Zm9ybSBjb25kaXRpb25hbA0KPj4+PiBjb21wYXJpc29ucyBiYXNlZCBvbiBhIHBvdGVudGlhbGx5
IGRpZmZlcmVudCB1NjQvczY0L3UzMi9zMzIgdHlwZXMuIFRoaXMNCj4+Pj4gdGVzdHMgbG90cyBv
ZiB0cmlja3kgY2FzZXMgb2YgZGVyaXZpbmcgYm91bmRzIGluZm9ybWF0aW9uIGFjcm9zcw0KPj4+
PiBkaWZmZXJlbnQgbnVtZXJpYyBkb21haW5zLg0KPj4+Pg0KPj4+PiBHaXZlbiB0aGVyZSBhcmUg
bG90cyBvZiBhdXRvLWdlbmVyYXRlZCBjYXNlcywgd2UgZ3VhcmQgdGhlbSBiZWhpbmQNCj4+Pj4g
U0xPV19URVNUUz0xIGVudnZhciByZXF1aXJlbWVudCwgYW5kIHNraXAgdGhlbSBhbHRvZ2V0aGVy
IG90aGVyd2lzZS4NCj4+Pj4gV2l0aCBjdXJyZW50IGZ1bGwgc2V0IG9mIHVwcGVyL2xvd2VyIHNl
ZWQgdmFsdWUsIGFsbCBzdXBwb3J0ZWQNCj4+Pj4gY29tcGFyaXNvbiBvcGVyYXRvcnMgYW5kIGFs
bCB0aGUgY29tYmluYXRpb25zIG9mIHU2NC9zNjQvdTMyL3MzMiBudW1iZXINCj4+Pj4gZG9tYWlu
cywgd2UgZ2V0IGFib3V0IDcuNyBtaWxsaW9uIHRlc3RzLCB3aGljaCBydW4gaW4gYWJvdXQgMzUg
bWludXRlcw0KPj4+PiBvbiBteSBsb2NhbCBxZW11IGluc3RhbmNlLiBTbyBpdCdzIHNvbWV0aGlu
ZyB0aGF0IGNhbiBiZSBydW4gbWFudWFsbHkNCj4+Pj4gZm9yIGV4aGF1c3RpdmUgY2hlY2sgaW4g
YSByZWFzb25hYmxlIHRpbWUsIGFuZCBwZXJoYXBzIGFzIGEgbmlnaHRseSBDSQ0KPj4+PiB0ZXN0
LCBidXQgY2VydGFpbmx5IGlzIHRvbyBzbG93IHRvIHJ1biBhcyBwYXJ0IG9mIGEgZGVmYXVsdCB0
ZXN0X3Byb2dzIHJ1bi4NCj4+Pg0KPj4+IEZXSVcgYW4gYWx0ZXJuYXRpdmUgYXBwcm9hY2ggdGhh
dCBzcGVlZHMgdGhpbmdzIHVwIGlzIHRvIHVzZSBtb2RlbCBjaGVja2Vycw0KPj4+IGxpa2UgWjMg
b3IgQ0JNQy4gT24gbXkgbGFwdG9wLCB1c2luZyBaMyB0byB2YWxpZGF0ZSB0bnVtX2FkZCgpIGFn
YWluc3QgKmFsbCoNCj4+PiBwb3NzaWJsZSBpbnB1dHMgdGFrZXMgbGVzcyB0aGFuIDEuMyBzZWNv
bmRzWzNdIChiYXNlZCBvbiBjb2RlIGZyb20gWzFdDQo+Pj4gcGFwZXIsIGJ1dCBJIHNvbWVob3cg
bG9zdCB0aGUgbGluayB0byB0aGVpciBHaXRIdWIgcmVwb3NpdG9yeSkuDQo+Pg0KPj4gRm91bmQg
aXQuIEZvciByZWZlcmVuY2UsIGNvZGUgdXNlZCBpbiAiU291bmQsIFByZWNpc2UsIGFuZCBGYXN0
IEFic3RyYWN0DQo+PiBJbnRlcnByZXRhdGlvbiB3aXRoIFRyaXN0YXRlIE51bWJlcnMiWzFdIGNh
biBiZSBmb3VuZCBhdA0KPj4gaHR0cHM6Ly9naXRodWIuY29tL2JwZnZlcmlmL3RudW1zLWNnbzIy
L2Jsb2IvbWFpbi92ZXJpZmljYXRpb24vdG51bS5weQ0KPj4NCj4+IEJlbG93IGlzIGEgdHJ1bmNh
dGVkIGZvcm0gb2YgdGhlIGFib3ZlIHRoYXQgb25seSBjaGVjayB0bnVtX2FkZCgpLCByZXF1aXJl
cw0KPj4gYSBwYWNrYWdlIGNhbGxlZCBweXRob24zLXozIG9uIG1vc3QgZGlzdHJvczoNCj4NCj4g
R3JlYXQhIEknZCBiZSBjdXJpb3VzIHRvIHNlZSBob3cgcmFuZ2UgdHJhY2tpbmcgbG9naWMgY2Fu
IGJlIGVuY29kZWQNCj4gdXNpbmcgdGhpcyBhcHByb2FjaCwgcGxlYXNlIGdpdmUgaXQgYSBnbyEN
Cj4NCg0KV2UgaGF2ZSBzb21lIHJlY2VudCB3b3JrIHRoYXQgYXBwbGllcyBmb3JtYWwgdmVyaWZp
Y2F0aW9uIGFwcHJvYWNoZXMNCnRvIHRoZSBlbnRpcmV0eSBvZiByYW5nZSB0cmFja2luZyBpbiB0
aGUgZUJQRiB2ZXJpZmllci4gV2UgcG9zdGVkIGENCm5vdGUgdG8gdGhlIGVCUEYgbWFpbGluZyBs
aXN0IGFib3V0IGl0IHNvbWV0aW1lIGFnbzoNCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2JwZi9TSjJQUjE0TUI2NTAxRTkwNjA2NEVFMTlGNUQxNjY2QkZGOTNCQUBTSjJQUjE0TUI2NTAx
Lm5hbXByZDE0LnByb2Qub3V0bG9vay5jb20vVC8jdQ0KDQpPdXIgcGFwZXIsIGFsc28gcG9zdGVk
IG9uIFsxXSwgYXBwZWFyZWQgYXQgQ29tcHV0ZXIgQWlkZWQgVmVyaWZpY2F0aW9uIChDQVYp4oCZ
MjMuDQoNClsyXSBodHRwczovL3Blb3BsZS5jcy5ydXRnZXJzLmVkdS9+c242MjQvcGFwZXJzL2Fn
bmktY2F2MjMucGRmDQoNClRvZ2V0aGVyIHdpdGggQFBhdWwgQ2hhaWdub24gYW5kIEBIYXJpc2hh
bmthciBWaXNod2FuYXRoYW4gKENDJ2VkKSwgd2UNCmFyZSB3b3JraW5nIHRvIGdldCBvdXIgdG9v
bGluZyBpbnRvIGEgZm9ybSB0aGF0IGlzIGludGVncmFibGUgaW50byBCUEYNCkNJLiBXZSB3aWxs
IGxvb2sgZm9yd2FyZCB0byB5b3VyIGZlZWRiYWNrIHdoZW4gd2UgcG9zdCBwYXRjaGVzLg0KDQpU
aGFua3MsDQoNCi0tDQpTcmluaXZhcw0KVGhlIGZhc3Rlc3QgYWxnb3JpdGhtIGNhbiBmcmVxdWVu
dGx5IGJlIHJlcGxhY2VkIGJ5IG9uZSB0aGF0IGlzIGFsbW9zdCBhcyBmYXN0IGFuZCBtdWNoIGVh
c2llciB0byB1bmRlcnN0YW5kLg0KDQo=

