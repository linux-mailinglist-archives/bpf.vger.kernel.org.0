Return-Path: <bpf+bounces-19494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A9C82C6ED
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 22:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DB5D1F23588
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 21:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DB617725;
	Fri, 12 Jan 2024 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jP/EqETk"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A0D17727
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 40CFMUsp020861
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 13:59:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=+5acbYChJsg6W/B5vHbdGS5EXSbh3+V4yJnPAP9S+jk=;
 b=jP/EqETk162WRo8ms0Aj56+ZzUgRB4WADcXoWlbVFhl28dv1BJToWSI2A2QheeivDEh6
 4lVhgudIT033Zapy5+SDaQEqCiyz47BAiKnqzqyMVt8iTWZQ7EAiGHnKHJ0+Gqfg6PJf
 R7nKIMwOLjHJrvfwgaNmHVpR3sl9SyOw4wGq7yqoFnfHHZcu2o15er5PKY4TdEFPZyKs
 wHvPXX9KatlCCKx/VUd225+0zIUg6lcDw0/5vbXJLtVJa+rRYBD4CXVJGIZIZdGX467F
 8sQCe2V5gQMD4i3F9BYJPg/3JvV9l64g+ZX1PogijMH469QwuRpSkYrOcKKAOmUl8mr6 fw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by m0089730.ppops.net (PPS) with ESMTPS id 3vjp7y7swe-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 13:59:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nm1MB6x93+9HYsb/FbuhPtGkkxRVIOZEVkAJvxK5vCi6plmscg3A58St77gbs5U+SyVmxUz0HVAvYUrmJL6b5HPC1KfTzgCz3agXUDM9e49UhFlc81RkAAFOH7sNC9id7p+b6HA+Mv+2YkSMIGmTFi6tMUwAqEMk5B6oj1afmIt7WWCcMMKgbic6qe8vgQqdDh6HbgvNltHVdBzNlCQWZRjKJVN4RuWLsX+fcee9rheeLtG9C7iuT5J4loY1wZqsTtJ0DTv+78p1jWzWqoh9F4Qqp/UYD8ETFNFGVqoiNJ4woRcGw9hT0PixkYypXmeXM6urwi7lawAXNatlk32s3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5acbYChJsg6W/B5vHbdGS5EXSbh3+V4yJnPAP9S+jk=;
 b=RnX2CybS0VwVLqhzsQrE8lyqb9+a0y5kJ+Cza4lDid8EFSAVM2LYDiMnR8iDgQwEcOTeQyY3xnkW3QWN+axljmel+Aj6vxNhoxXggReY8wjDC1Ld3zZUa0K3jF4u2Gp26gGmB5U3tZzhDvumRi8a2F1u2nfxRFWOoW+rSap21rWuSKb0JtYveQ8GZEmJUL1yVhSE35y47cCjakF7vrso3uXaYup22Nv8vZo25omYIqGiDBv06av3CJJI0ErI0YICVpy5fBZGt6fJAXMV+3vHeWLcoGe76H7lxCliRTYUaLYYTxvLL+3GHgyzvv4ZszhJWE4VoS+VKSxjQoVzrIcnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BLAPR15MB4065.namprd15.prod.outlook.com (2603:10b6:208:273::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 21:59:05 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f568:18bc:2915:d378]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f568:18bc:2915:d378%6]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 21:59:05 +0000
From: Song Liu <songliubraving@meta.com>
To: Daniel Xu <dxu@dxuuu.xyz>
CC: Song Liu <songliubraving@meta.com>, bpf <bpf@vger.kernel.org>,
        Alexei
 Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii
 Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Alan
 Maguire <alan.maguire@oracle.com>,
        Jordan Rome <jordalgo@meta.com>, Yonghong
 Song <yhs@meta.com>,
        Kernel Team <kernel-team@meta.com>
Subject: Re: RFC: Mark "inlined by some callers" functions in BTF
Thread-Topic: RFC: Mark "inlined by some callers" functions in BTF
Thread-Index: AQHaRNhGas8sywhOAEu7Lx4Jcjz6cbDVNwCAgAAE2QCAAAwTgIABc3WA
Date: Fri, 12 Jan 2024 21:59:05 +0000
Message-ID: <768D674E-6A13-4D09-A063-E9C50AF9FE51@fb.com>
References: <B653950A-A58F-44C0-AD9D-95370710810F@fb.com>
 <rclqt5yod7n5l3cjuptadouxw3xshcedibgfe4fc3qjy6psuf7@qj2cjmzu5iwe>
 <DF3DD763-E5F2-4032-8F54-E25AA1270E12@fb.com>
 <n7jdll2bwj7futzz227g2nlo53zwg774appc3paxhi3iv76ean@4oj7mxalthzz>
In-Reply-To: <n7jdll2bwj7futzz227g2nlo53zwg774appc3paxhi3iv76ean@4oj7mxalthzz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|BLAPR15MB4065:EE_
x-ms-office365-filtering-correlation-id: 834624d9-38b2-4e50-ef5f-08dc13b9b220
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 3GxFjtx0E+Ja2Exe9zXQezhPtYNSrCrxT63gLNpF0EJM6Yg+Q0MZcLVaxD3/ARHXH1Ub1pdS4iTvyfomvI2Ehnm/PeBGaHRaoGDBvt8nks5oR+AO5s8O2ptw3Hf8/NsUvbPx49djzcezz9dHThvTFBQHp3R+oPpPMo8zppM2CdR4TwUejcBJU74d2WlJy27P1uILapBSNu+kSc8esb/okDNdQkE6SYLvJWgkaWM6IaLKSJXHcfOloWHhgMbUZgIoY+KCMrJjznISfEtVp++wFlnkSLVkFwRCwfnn4lTCTcsSYLO09iX8RMrYb67F7zDNJRc4UkK6qXB4nmAO10CnLjBHo+ne/zjw2oQJJMchYJ7athTN6r/qm915UPX6CPRNAFz9FUFnqLJPLymAyopXZQ8j/4kELcdxZsw672nQuNkX14pgrMSfdfmMVMWwwA6tNV9HdViHV6hB5xpQTky+folPMpJP0D1eWPWjk4QQOyaOKVYYcJd1uuXjdw8Rp7cRiHbfawSIpP/O2pQBH8bawjBCn1e7+N82kLdT+qs6Zzx095JIC/ICR1c2AzY/gSgLLXI4FJ114Kb/dp91Jj1ifmoq8Fsr6AOZs/VPDPsmVtbMwn+EYD7bCwI4hg6oa75y
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(71200400001)(478600001)(53546011)(9686003)(6506007)(6512007)(107886003)(86362001)(38070700009)(122000001)(33656002)(36756003)(38100700002)(2906002)(91956017)(41300700001)(76116006)(83380400001)(4326008)(5660300002)(6916009)(66476007)(66446008)(54906003)(6486002)(8676002)(64756008)(316002)(66556008)(66946007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eW9KZHI3TkMwYzZaUjdMbW1CWFpiN0V5eXp1UmJKOVIycjdlMnVueVV2U1Jm?=
 =?utf-8?B?OGIyOVd6Ni9CWVl1emNWR1ZDVWZ3aEZqUVROeVhQeXRSYmw3d25DVDNBRDFS?=
 =?utf-8?B?TDlWRW1FcWlDR0FwL1hyMGU5aktFbXVjUjhUeCt6VEltN1JIR1dkZU9lVEwr?=
 =?utf-8?B?bFBGdDF5a2pNYjUzTTBXMEY5Ti80S0s5VDdNMnFpK05jdnlQeVYrcmg5bUlX?=
 =?utf-8?B?RXRHTGR3NEF6R2F0ZWlkQmxXYkNZZSs4OUkwOTRtRm1odEJTeHY5dW40TndE?=
 =?utf-8?B?ZThCT1loWnFoS3U5ckRVdjM4OGtSV0VIQUU0NnJlMzdCSkxQbTFFQ3NNQXln?=
 =?utf-8?B?QU1nb3dFSnRORTNaTTJrekRXVzZWVnhQNUJoNzU5TmpTMHhQNWhXNWhYd3pH?=
 =?utf-8?B?UCtSQ3ZqM2lqSEp5UDkwcUtOTVlrOFV2MDAzY2tYQUY0NlNvQW5DdFJMblJr?=
 =?utf-8?B?dW1Pa2orcU9NQ3g0NGQ2NFpUMytPRlRpdE04ODUxWFA3d2dzN2RlaFBmZlBS?=
 =?utf-8?B?M0l2TndaRjYrR2xKNDFDMDNaYS9uTVYvYmlDa3pTN1dobjVoZU1OUk02M2ZU?=
 =?utf-8?B?cWFJQzMyc0t4RStULzgyNDJyaS8xa2NFNkNKc3RpS1NhWnJOUHI0MXI5U1Vx?=
 =?utf-8?B?NHAyTTl1dllERGkzd24wN2UxTEtiQndIVzdUTEtORUpHNGg3bWVDRTNZOVJl?=
 =?utf-8?B?a3ErNHJsdml1SkYxVXc2N1lqUDB6WWlVclhHdkxGeXRmUVZOUHNwSG9kamtD?=
 =?utf-8?B?L1F1U1RKUy94cW9udktHeG5ab3dOeEloRHJKUDR6L1NDUEVHVFd0NFBySVNV?=
 =?utf-8?B?dUQrWGgrdVpsSUM2ck9Ga01zSW5VVkFrc3VTaklnWEN1TnpSbEtBTjd0N2Ru?=
 =?utf-8?B?Qk5FM0FORjkyc25VRHNvM3ZBUXdOd1Q4c05EazB0aUlVeTRWalJGRWxkMGR6?=
 =?utf-8?B?WG9jaGxBTFZkMlJaVVFmM2NuL2hROEFrV3U5WVJPMVBVM1pJK01QZDNlSS8x?=
 =?utf-8?B?cHQxZmRwbVFoek92YkM5K012OGpIcU1PVXZkN0VDSnZoQmZUcjd6T3NRdG1U?=
 =?utf-8?B?c3RrUFJxdDE0cUNmMnBiSS9FZzROVVJiWnBpYThPWHJ6b3B0L0laNDB0b1lY?=
 =?utf-8?B?ZldxNktpcUJVeHBQSnk4TE4zQ3dFWkprSmxacjNNeSsycGtRcWEvcnBVdnlt?=
 =?utf-8?B?ZWk1ajFDNFZSSXZzVmgxdnQ5cGttQ2p2OFVsdFlaK3czRDhzeXpabEk1Rkph?=
 =?utf-8?B?bC9EZjZIckw2QzhlZXVjKzYrUnVOVG9jRHFQMWQ3bHdOeERDeUlrQ2ZtNlo0?=
 =?utf-8?B?MlZyZ2ZsZnQ3RTl1N0REMFZCVVlhdVp2a2JncTBUSjBlZ1BTR24wb3F2NE9W?=
 =?utf-8?B?bVNRZW80WU5SRm4vbXl3WU5aU3JVVG02QUExa2hRVkliWklqdWVtcVFzbjZj?=
 =?utf-8?B?MHRGSTdvaVNUWVJXYmRJendXb0FlbmNobjF5cEdDdThaVnFibnZzSVNlWWRp?=
 =?utf-8?B?SUJCbUFVczlMVHhLaDBlNU1XcFJKMEpDNGp3cnhEbTF1V2VOLytnTmhJcmtV?=
 =?utf-8?B?alZXUUllQUpURmNiU0l5eTZzMEtLdC9OUmljS3lIMTdhbVYwYlNmUi9OcnIx?=
 =?utf-8?B?UmRZVW5NQXBIUmRrcWR4bkJXaTQxQUMxSmpQd1ZybFBsK0ZhZzNjOGt3QmFT?=
 =?utf-8?B?UjFGTmViaEdleGkrZS9wUVBhais0dm9DZ0VLdDZ2NzFPZEsrMWtzcEpuR28v?=
 =?utf-8?B?cGIzVndpY0JidHR6Z1ZkUFB4aGdWVXJScVVZSEVuYkpHWkU5WjdocjQ1L1NY?=
 =?utf-8?B?TVJocmROOFM5N0I5ZjJCcldwbmpQRUE0ZmlMUlpVTkZJUjRUSGYvYmFSYUVs?=
 =?utf-8?B?eFZoZWV0dzBKa2lTQ2xmSnNSNkNhTVg1OUl2Qnp6YWhkNzlZV0xYdGY1Z0g3?=
 =?utf-8?B?TTZBU0RlbS96T044WjZ4MUVQY0VSVDBDZnZ1amJ2Q2lzQk1JRlNnRDlTOU1J?=
 =?utf-8?B?cDhQWUZleXU5aTA1Sm5CcExmalZRaWFPUGtEMkJncG1HclovZnNFYTArdVBJ?=
 =?utf-8?B?KzI2czFoa25NM0VRM3Rma3lpbUMrV3ZWNE9UTm5WZzEyNnlnSEtjaEVPVGNi?=
 =?utf-8?B?UXdsRTgvekdmSDBhbDNwVk5yeExUOXpKVDlPUE93U3kzNzdXMDVBMEZuREd6?=
 =?utf-8?Q?ims3998fRpPrJfqpl6FIqvs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E385D924B3B9D4392EC7A37C118A623@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 834624d9-38b2-4e50-ef5f-08dc13b9b220
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 21:59:05.7794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Irs4O3piwDy8WpxREb9guwBTLjTEZIs+sS0cXsUajrJQTDF/1mqRijKPpiZ0oJwHikFhqydi0RtxNztCQhdZIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB4065
X-Proofpoint-ORIG-GUID: 6rfqimedEMfv9FXMqk7cHRRNX8xD5cVI
X-Proofpoint-GUID: 6rfqimedEMfv9FXMqk7cHRRNX8xD5cVI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-12_12,2024-01-12_01,2023-05-22_02

DQoNCj4gT24gSmFuIDExLCAyMDI0LCBhdCAzOjQ54oCvUE0sIERhbmllbCBYdSA8ZHh1QGR4dXV1
Lnh5ej4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEphbiAxMSwgMjAyNCBhdCAxMTowNjoyM1BNICsw
MDAwLCBTb25nIExpdSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gSmFuIDExLCAyMDI0LCBhdCAy
OjQ44oCvUE0sIERhbmllbCBYdSA8ZHh1QGR4dXV1Lnh5ej4gd3JvdGU6DQo+Pj4gDQo+Pj4gSGkg
U29uZywNCj4+PiANCj4+PiBPbiBUaHUsIEphbiAxMSwgMjAyNCBhdCAwOTo1MTowNVBNICswMDAw
LCBTb25nIExpdSB3cm90ZToNCj4+Pj4gVGhlIHByb2JsZW0NCj4+Pj4gDQo+Pj4+IElubGluaW5n
IGNhbiBjYXVzZSBzdXJwcmlzZXMgdG8gdHJhY2luZyB1c2VycywgZXNwZWNpYWxseSB3aGVuIHRo
ZSB0b29sDQo+Pj4+IGFwcGVhcnMgdG8gYmUgd29ya2luZy4gRm9yIGV4YW1wbGUsIHdpdGgNCj4+
Pj4gDQo+Pj4+ICAgW3Jvb3RAIH5dIyBicGZ0cmFjZSAtZSAna3Byb2JlOnN3aXRjaF9tbSB7fScN
Cj4+Pj4gICBBdHRhY2hpbmcgMSBwcm9iZS4uLg0KPj4+PiANCj4+Pj4gVGhlIHVzZXIgbWF5IG5v
dCByZWFsaXplIHN3aXRjaF9tbSgpIGlzIGlubGluZWQgYnkgbGVhdmVfbW0oKSwgYW5kIHdlIGFy
ZQ0KPj4+PiBub3QgdHJhY2luZyB0aGUgY29kZSBwYXRoIGxlYXZlX21tID0+IHN3aXRjaF9tbS4g
KFRoaXMgaXMgeDg2XzY0LCBhbmQgYm90aA0KPj4+PiBmdW5jdGlvbnMgYXJlIGluIGFyY2gveDg2
L21tL3RsYi5jLikNCj4+Pj4gDQo+Pj4+IFdlIGhhdmUgZm9sa3Mgd29ya2luZyBvbiBpZGVhcyB0
byBjcmVhdGUgb2ZmbGluZSB0b29scyB0byBkZXRlY3Qgc3VjaA0KPj4+PiBpc3N1ZXMgZm9yIGNy
aXRpY2FsIHVzZSBjYXNlcyBhdCBjb21waWxlIHRpbWUuIEhvd2V2ZXIsIEkgdGhpbmsgaXQgaXMN
Cj4+Pj4gbmVjZXNzYXJ5IHRvIGhhbmRsZSBpdCBhdCBwcm9ncmFtIGxvYWQvYXR0YWNoIHRpbWUu
DQo+Pj4gDQo+Pj4gQ291bGQgeW91IGNsYXJpZnkgd2hhdCBvZmZsaW5lIG1lYW5zPw0KPj4gDQo+
PiBUaGUgaWRlYSBpcyB0byBrZWVwIGEgbGlzdCBvZiBrZXJuZWwgZnVuY3Rpb25zIHVzZWQgYnkg
a2V5IHNlcnZpY2VzLiBBdCANCj4+IGtlcm5lbCBidWlsZCB0aW1lLCB3ZSBjaGVjayB3aGV0aGVy
IGFueSBvZiB0aGVzZSBmdW5jdGlvbnMgYXJlIGlubGluZWQuIA0KPj4gSWYgc28sIHRoZSB0b29s
IHdpbGwgY2F0Y2ggaXQsIGFuZCB3ZSBuZWVkIHRvIGFkZCBub2lubGluZSB0byB0aGUgZnVuY3Rp
b24uDQo+IA0KPiBOZWF0IGlkZWEhDQo+IA0KPj4+IEkgd29uZGVyIGlmIGxpYmJwZiBzaG91bGQg
anVzdCBnaXZlIGEgd2F5IGZvciBhcHBsaWNhdGlvbnMgdG8gcXVlcnkNCj4+PiBpbmxpbmUgc3Rh
dHVzLiBTZWVtcyBtb3N0IGZsZXhpYmxlLiAgQW5kIG1heWJlIGFsc28gYSBzcGVjaWFsIFNFQygp
IGRlZj8NCj4+IA0KPj4gQVBJIHRvIHF1ZXJ5IGlubGluZSBzdGF0dXMgbWFrZXMgc2Vuc2UuIFdo
YXQgZG8gd2UgZG8gd2l0aCBTRUMoKT8NCj4gDQo+IE9oLCBJIG1lYW50IHRoYXQgeW91IGNvdWxk
IG1ha2UgdGhlIFNFQygpIHBhcnNlciB0YWtlIGZvciBleGFtcGxlOg0KPiANCj4gICAgICBTRUMo
Imtwcm9iZS5ub2lubGluZS9zd2l0Y2hfbW0iKQ0KPiANCj4gb3Igc29tZXRoaW5nIGxpa2UgdGhh
dC4gUmF0aGVyIHRoYW4gYWRkIGZsYWdzIHRvIGJwZl9wcm9ncmFtIHdoaWNoIG1heQ0KPiBub3Qg
YmUgYXBwbGljYWJsZSB0byBldmVyeSBwcm9ncmFtIHR5cGUuDQoNClRoaXMgaXMgYW4gaW50ZXJl
c3RpbmcgaWRlYS4gVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbiENCg0KU29uZw0KDQo=

