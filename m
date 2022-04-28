Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636C8513C0F
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 21:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiD1TS0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 15:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiD1TSZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 15:18:25 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E26929CA3
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 12:15:09 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SIPG3n031208
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 12:15:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=CgYqaJKs2gLAJj3Momt1y+dNmLsHhgYYBtgsBlhs+Jc=;
 b=fhVBGs4g3BiZE0vuH8I1hbu60HultXcxOynxaH1vP7ZrhOdCBTl0qE8YnxNBxNAdvxWc
 uCvIMWPhPd36f/wte91/GqLUXKd+79Emc63hJAEIVekLe3alRnoMdRLhKXLhS826iseX
 81PW6w2qhwyaxwrDr2UuZzDUkpLnbA8EVLI= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fqghnp652-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 12:15:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXHHz8apUHkUK+8uNiX4LBHkcllufr0Jxa7hJAoX6nN61/0/160MBYfmcEzs+MQREiczSQlkZCqy4aLHnn/xPq6PPUimquqhUibxy3toCPxyCmFOwdeqD3GgfxWnpVdxfzyYKgAOvifPSSjGOGT0L5iHaQVeausX1Sm4kxgQ+iVYXC/Yinh68J0Z85Nv4TPE9PH0sTnsUVq252cU1tYFfxdcLvF1ts8/CEkVtgv5pUAR0toCulccz2diMl1/aAHMqXrBS+bZa4lMRAMqcVq/osKSXFBVLjMI366orPOqVvA7G9Xehw13gqiRaqDjkXKj5o2Dt1PtP/zv71uMj9pl1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgYqaJKs2gLAJj3Momt1y+dNmLsHhgYYBtgsBlhs+Jc=;
 b=khqIEgU1vk0PC0GmOZPnnZPpjn9zFHKUHYwTNAM1EVZqdVmwUwWGgV6udhEt8F5Ox60oQ3cpiFTUu4Nnm9a4wdRwon8/05eBnewaDMhDehQNwQU6C6OHg78+z3iupSQ59b9TNGdlrtpfR3s2/sOACLuYhsCI23SvD1LXhxM58m5kUePYvHnDEqKHTBLYV+9SdL0yeTeUa7nLF/ajYtZgk2ytSSOaIbxypDCjtAVDiFfXIWk6CnegnvVgUrp5ni7YauC8V2+UPvSp5PGu5kDebq8XSIycOT0PJQvVtU/VqNNBkV7iFxR7UvXQTQjqYqsaHd+aEBXoCTn9W5GrrjGehw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by MN2PR15MB3648.namprd15.prod.outlook.com (2603:10b6:208:182::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Thu, 28 Apr
 2022 19:15:04 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%4]) with mapi id 15.20.5186.020; Thu, 28 Apr 2022
 19:15:04 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/5] bpf: implement sleepable uprobes by chaining
 tasks and normal rcu
Thread-Topic: [PATCH bpf-next 2/5] bpf: implement sleepable uprobes by
 chaining tasks and normal rcu
Thread-Index: AQHYWyCPxeAlzkBqGUmwvbIxciSxYq0Fop2AgAAOPgA=
Date:   Thu, 28 Apr 2022 19:15:04 +0000
Message-ID: <c9a7e3566dc9f7e8439ab8404830847e8a960a84.camel@fb.com>
References: <cover.1651103126.git.delyank@fb.com>
         <972caeb1e9338721bb719b118e0e40705f860f50.1651103126.git.delyank@fb.com>
         <CAEf4BzYBFFtHLerimNF5ZKXa6keyb6=NfPq-5YSoPymmrc820g@mail.gmail.com>
In-Reply-To: <CAEf4BzYBFFtHLerimNF5ZKXa6keyb6=NfPq-5YSoPymmrc820g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2f88b13-0473-4ae8-3777-08da294b669f
x-ms-traffictypediagnostic: MN2PR15MB3648:EE_
x-microsoft-antispam-prvs: <MN2PR15MB364814271FF0D99FF6DF0189C1FD9@MN2PR15MB3648.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dzH7G1Oukiu1Ce23HEYrxmrn8H0vZ+N4R26iq/VzKTSBypUEiXGNi/wJ2uO/Qak367LQ2znT0Z1XQxeKFx3ztxHE6jpJZKgllrL3ghwWUr6ChrgL8eUVce8Zfv9kXGGHu0nv7xu4QYsWlLcP9N7HIDGxEhEL3gnfa+wzS75rEtUU9JTm0NUahqVPfuK1IjpyUv+PhnUznXJvs+VGTQBafF/cPDtDPieuNVzxsIcZPlRp8HNk+SI5S3+M7OkJDMKVsdiopmOiLpMwiCzKEkevEKx9tbPA3oQE1BENsFDtdZQ2IOeToIKru7O2U7ij64EByB2+Q+Oz2FbLrm8uoC5RqjUuFImIyDIjJ1Fy3ACKu3QneiA4HCh8mhUfOocERx2hdWqEvddO5WGMQOzny8S31WbfTmE43sK11MJDojUvD5elNutQEHqt5S0PAIXuffpCAmpkFXn+m1VZADOiAHLYTQz51UofV97fGdW6h2IKSN47iV98ohUi/Ibhew7+eRRfo0/ku66aKrHagydTPAUB2FLYXyXCKJmZs+fXTXvGd16EYi1k5vqUNIlWwSWUBtuO0l8m7MM80oMrv0Zpqw5D+DwiX0BIRiLt2rxblEMxSO+8594JnphtqTprH7IQrXhgT5dtGDs6C/MKKY3nq+pguvVKnbbTU0wSkHjrvLVkVTsOTgqYtdK8C0BLxlFrEBhjYQGjug7qArxxw49E66mgPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(8936002)(54906003)(5660300002)(6512007)(38100700002)(2616005)(36756003)(316002)(38070700005)(66446008)(66556008)(64756008)(6506007)(53546011)(26005)(6486002)(66476007)(8676002)(4326008)(6916009)(508600001)(71200400001)(186003)(83380400001)(76116006)(86362001)(2906002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnFYSlRmUWVwaUU0eGlaazRYMEdla1ZFZ3dWaE9EZkhwR2VPREhuSUZCTkxO?=
 =?utf-8?B?L2U5VWpBVElWVW01K3lHQUF0UHRmdm00NjVnMzd0djFjRmFWd0hxQ1V3UmRT?=
 =?utf-8?B?SHRFY3ZsRC96UE9BcldwUUZMNjlCR3NYMmEwNXlYWVpDOVFtZGFUQm1pRlM3?=
 =?utf-8?B?NElFdUI1a2dTcmU2cW93NWFZS1V0cXBiU3BnZVhZSTVYMVl3eWZUWGRrUWNv?=
 =?utf-8?B?Y0VvQ0NDV3AwZjhyYWVHVkhQNktQWnlNMDZ2TGE2eDZodklkOUdQMWxyamEv?=
 =?utf-8?B?Y1U1RmZzSnVRQVVHazZNbWVYY2Y3SURKN0UwSTRNNllKd3daRmdwam9vZkEr?=
 =?utf-8?B?L21QUGxib0QwYllvY0k5bVAwWHIzSGt0V3RkWFd3RnNEbUV0eEVCMHppbG9o?=
 =?utf-8?B?ZzErNVhxeXlkR2wyekVJeGoxRWMwVmpGQkN0ZkVMcHcxcVVHNkpBRVF4c21x?=
 =?utf-8?B?MTBPc0tXbnVGSDJFZHRLS05nR2FmWFRSekNmQVFwODh1S3hnZ0JLYWdTY0RI?=
 =?utf-8?B?dHNvbnJjZS9CbVBuTEZkZjF5eVAvSjBDcGJ5OHl5TzA0d1UrWFdlWTJwM2x0?=
 =?utf-8?B?dVgzV0gwY3BiTjJKZHJKSXp6aTBFeFBxSWdoRDV2c25VT3l2c0FrZFoxd0Ny?=
 =?utf-8?B?aTY3OTBXSUNPOUhWL2JyN1IraGw3WWViRkozYjhEOFZ1dlA0NE4yTmhIT3Bz?=
 =?utf-8?B?NmI1aEVhWklMbTlFWXJsNVFhYXNHNU1qcWE2YTBPMUVwdktsUENsYWt4cHZW?=
 =?utf-8?B?cEgvbWNOMk0vRmJyREkzM0R1NHUvcFRXWldzZ2FOdlNhRjNKK0EvZGlUeUg5?=
 =?utf-8?B?MC9LRlE3ZjJhYWowQVN2QkI2Q0VWNjlERGRvdDlIRm1GTW1BMEx4MEtBZERp?=
 =?utf-8?B?QkJMcmRaakgwM3kycTdGNDBoalVvaXM0VlZZY3NaZEl3N1lvSGUvVC9NdTVK?=
 =?utf-8?B?cFRoTzJmUXI1VzRqQXhnb3hpZ1FKaFRHQ2Y5QUtYL2FMeDE5SVhjUVNyM3hh?=
 =?utf-8?B?NTZsKzdqRWoyVVRnZVF5YmNudkZJdS80TFVTMjMvWi9EMlZvS0pJMUFua096?=
 =?utf-8?B?b1JtWkp5c2cvV3NxaVl0dEc2MU5mcUNtVXE4dEZiZXZWV3hFbXZFcG9lL2NV?=
 =?utf-8?B?YlZ4aGVIOGR1aml3eXM3OWUyYWtSbXMxMVJad1Z5YmlPM2R3MVozTWtzUFFI?=
 =?utf-8?B?WGFKYzNqY3V6MDM2dUI4ditXcDdMM2F3T2dsamNZT0U4dEhvbFpyRGpnRzhP?=
 =?utf-8?B?SWV3Z1pPcjA1RDFkaXRiYktwV2tJZmxHOXM2bmRrVVF0Uk1wSS9ZT01Ub1o1?=
 =?utf-8?B?YlAzVU11QTlaZnhQV1ZibktxYWk4R1dGUU9KcVd6OW5mMkNqN2ExeHZVOE5u?=
 =?utf-8?B?RElwa1pkWVRjN2NhNGVqZi9EUHVyVms0QXl6R3drRHA1czJ5VHgvdVVIMkFH?=
 =?utf-8?B?SjVJV2NDeVJhVndWN09CUnpnS1ZVMU1OdjlNWFQwM3A2WjM0TytDZUs5ZlBl?=
 =?utf-8?B?U2JEMW1hdnBKZk91RzhxZWdzZ1ljRFR3UnVoakVwYzR3eHQrc09QT3lqdXd1?=
 =?utf-8?B?dWUwdXFubnk2bUF5alhBNmxsblZTZXJsRkt0K2xld1ZZUjdCMEV6M1dqdWlx?=
 =?utf-8?B?WndiUVFURTRkRE4wRnI1U3JTVDh2Rk1xM25qS1Y3a3BMcWRoMElLZWpTWUdW?=
 =?utf-8?B?UEp2NjZwYlkrZGd3YVB1b2lKdVRteGZrSjlnU3lGeDdiYWwzNmRkYmNrNFdP?=
 =?utf-8?B?MlUwY25VckVNU3VuL2s2MTFvcmxiVHVXVGlHKzhlOVZsa3dhM0U4bml6UXdl?=
 =?utf-8?B?WEVieG1wNUFLdS9DbXpKK1RGN0syNndnTndoRE5uVGxLM08rQkw1TWlWRmdZ?=
 =?utf-8?B?WFZ6Y0hYdlVyY3R3RGtsQmJjNlZ0dlg3bkJrVXJ1eG45dFd1ZDl2Q201dCsv?=
 =?utf-8?B?M1NJQkRudk1jVXpjcElUKy8vY0kxRkRuaWJoMFVyNkNhMFE4L2R5OFIrRkxY?=
 =?utf-8?B?b2pHdUdacnI1aHJNd01BaS9vM0gzTDMvanAxelhQWVM3TkpuTkY5dXdaTlgr?=
 =?utf-8?B?YWFHNmYzUU5WQm9SMDdDQzNDd0ZRWmw3aXdHMTRLeitkd0FXL09pRGMydmZy?=
 =?utf-8?B?Ykowb0s4R0d2aVYycEd4aG1zczBnLzg2eUNmRWp4TTVhYzR5dHBNTzYxTklt?=
 =?utf-8?B?T0FiY3RjbXErdWJrZ2RBUWZ3OHMwdUZPK2d6STJkT0x5SXZDaCtiU20rbzU2?=
 =?utf-8?B?QlNSMGhmTkJTOGY2eUQ0b3duUXh6ejA4YVJ4Zy9XNlRkNGoyVE1NeEJhdDl5?=
 =?utf-8?B?a1FDLy9Kb21NMFJqVlR2OTloemxRME1UVVRwYVZlRzBKNWpFdDZKUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE22EB3E219B294DBEB81632DB865649@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f88b13-0473-4ae8-3777-08da294b669f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 19:15:04.7030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jJ2VrChTFloTrp/0pLbBFurdhUTEs7jDVS6bsWfouOyuqqTyl0MR48KO3Zq+0T6c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3648
X-Proofpoint-GUID: WGTd51az1WErJ8H0xbNHcn4ak3Mid31e
X-Proofpoint-ORIG-GUID: WGTd51az1WErJ8H0xbNHcn4ak3Mid31e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-28_03,2022-04-28_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVGh1LCAyMDIyLTA0LTI4IGF0IDExOjE5IC0wNzAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+IE9uIFRodSwgQXByIDI4LCAyMDIyIGF0IDk6NTQgQU0gRGVseWFuIEtyYXR1bm92IDxkZWx5
YW5rQGZiLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gdXByb2JlcyB3b3JrIGJ5IHJhaXNpbmcgYSB0
cmFwLCBzZXR0aW5nIGEgdGFzayBmbGFnIGZyb20gd2l0aGluIHRoZQ0KPiA+IGludGVycnVwdCBo
YW5kbGVyLCBhbmQgcHJvY2Vzc2luZyB0aGUgYWN0dWFsIHdvcmsgZm9yIHRoZSB1cHJvYmUgb24g
dGhlDQo+ID4gd2F5IGJhY2sgdG8gdXNlcnNwYWNlLiBBcyBhIHJlc3VsdCwgdXByb2JlIGhhbmRs
ZXJzIGFscmVhZHkgZXhlY3V0ZSBpbiBhDQo+ID4gdXNlciBjb250ZXh0LiBUaGUgcHJpbWFyeSBv
YnN0YWNsZSB0byBzbGVlcGFibGUgYnBmIHVwcm9iZSBwcm9ncmFtcyBpcw0KPiA+IHRoZXJlZm9y
ZSBvbiB0aGUgYnBmIHNpZGUuDQo+ID4gDQo+ID4gTmFtZWx5LCB0aGUgYnBmX3Byb2dfYXJyYXkg
YXR0YWNoZWQgdG8gdGhlIHVwcm9iZSBpcyBwcm90ZWN0ZWQgYnkgbm9ybWFsDQo+ID4gcmN1IGFu
ZCBydW5zIHdpdGggZGlzYWJsZWQgcHJlZW1wdGlvbi4gSW4gb3JkZXIgZm9yIHVwcm9iZSBicGYg
cHJvZ3JhbXMNCj4gPiB0byBiZWNvbWUgYWN0dWFsbHkgc2xlZXBhYmxlLCB3ZSBuZWVkIGl0IHRv
IGJlIHByb3RlY3RlZCBieSB0aGUgdGFza3NfdHJhY2UNCj4gPiByY3UgZmxhdm9yIGluc3RlYWQg
KGFuZCBrZnJlZSgpIGNhbGxlZCBhZnRlciBhIGNvcnJlc3BvbmRpbmcgZ3JhY2UgcGVyaW9kKS4N
Cj4gPiANCj4gPiBPbmUgd2F5IHRvIGFjaGlldmUgdGhpcyBpcyBieSB0cmFja2luZyBhbiBhcnJh
eS1oYXMtY29udGFpbmVkLXNsZWVwYWJsZS1wcm9nDQo+ID4gZmxhZyBpbiBicGZfcHJvZ19hcnJh
eSBhbmQgc3dpdGNoaW5nIHJjdSBmbGF2b3JzIGJhc2VkIG9uIGl0LiBIb3dldmVyLCB0aGlzDQo+
ID4gaXMgZGVlbWVkIHNvbWV3aGF0IHVud2llbGRseSBhbmQgdGhlIHJjdSBmbGF2b3IgdHJhbnNp
dGlvbiB3b3VsZCBiZSBoYXJkDQo+ID4gdG8gcmVhc29uIGFib3V0Lg0KPiA+IA0KPiA+IEluc3Rl
YWQsIGJhc2VkIG9uIEFsZXhlaSdzIHByb3Bvc2FsLCB3ZSBjaGFuZ2UgdGhlIGZyZWUgcGF0aCBm
b3INCj4gPiBicGZfcHJvZ19hcnJheSB0byBjaGFpbiBhIHRhc2tzX3RyYWNlIGFuZCBub3JtYWwg
Z3JhY2UgcGVyaW9kcw0KPiA+IG9uZSBhZnRlciB0aGUgb3RoZXIuIFVzZXJzIHdobyBpdGVyYXRl
IHVuZGVyIHRhc2tzX3RyYWNlIHJlYWQgc2VjdGlvbiB3b3VsZA0KPiA+IGJlIHNhZmUsIGFzIHdv
dWxkIHVzZXJzIHdobyBpdGVyYXRlIHVuZGVyIG5vcm1hbCByZWFkIHNlY3Rpb25zIChmcm9tDQo+
ID4gbm9uLXNsZWVwYWJsZSBsb2NhdGlvbnMpLiBUaGUgZG93bnNpZGUgaXMgdGhhdCB3ZSB0YWtl
IHRoZSB0YXNrc190cmFjZSBsYXRlbmN5DQo+ID4gdW5jb25kaXRpb25hbGx5IGJ1dCB0aGF0J3Mg
ZGVlbWVkIGFjY2VwdGFibGUgdW5kZXIgZXhwZWN0ZWQgd29ya2xvYWRzLg0KPiANCj4gT25lIGV4
YW1wbGUgd2hlcmUgdGhpcyBhY3R1YWxseSBjYW4gYmVjb21lIGEgcHJvYmxlbSBpcyBjZ3JvdXAg
QlBGDQo+IHByb2dyYW1zLiBUaGVyZSB5b3UgY2FuIG1ha2Ugc2luZ2xlIGF0dGFjaG1lbnQgdG8g
cm9vdCBjZ3JvdXAsIGJ1dCBpdA0KPiB3aWxsIGNyZWF0ZSBvbmUgImVmZmVjdGl2ZSIgcHJvZ19h
cnJheSBmb3IgZWFjaCBkZXNjZW5kYW50IChhbmQgd2lsbA0KPiBrZWVwIGRlc3Ryb3lpbmcgYW5k
IGNyZWF0aW5nIHRoZW0gYXMgY2hpbGQgY2dyb3VwcyBhcmUgY3JlYXRlZCkuIFNvDQo+IHRoZXJl
IGlzIHRoaXMgaW52aXNpYmxlIG11bHRpcGxpZXIgd2hpY2ggd2UgY2FuJ3QgcmVhbGx5IGNvbnRy
b2wuDQo+IA0KPiBTbyBwYXlpbmcgdGhlIChob3dldmVyIHNtYWxsLCBidXQpIHByaWNlIG9mIGNh
bGxfcmN1X3Rhc2tzX3RyYWNlKCkgaW4NCj4gYnBmX3Byb2dfYXJyYXlfZnJlZSgpIHdoaWNoIGlz
IHVzZWQgZm9yIHB1cmVseSBub24tc2xlZXBhYmxlIGNhc2VzDQo+IHNlZW1zIHVuZm9ydHVuYXRl
LiBCdXQgSSB0aGluayBhbiBhbHRlcm5hdGl2ZSB0byB0cmFja2luZyB0aGlzICJoYXMNCj4gc2xl
ZXBhYmxlIiBiaXQgb24gYSBwZXIgYnBmX3Byb2dfYXJyYXkgY2FzZSBpcyB0byBoYXZlDQo+IGJw
Zl9wcm9nX2FycmF5X2ZyZWVfc2xlZXBhYmxlKCkgaW1wbGVtZW50YXRpb24gaW5kZXBlbmRlbnQg
b2YNCj4gYnBmX3Byb2dfYXJyYXlfZnJlZSgpIGl0c2VsZiBhbmQgY2FsbCB0aGF0IHNsZWVwYWJs
ZSB2YXJpYW50IGZyb20NCj4gdXByb2JlIGRldGFjaCBoYW5kbGVyLCBsaW1pdGluZyB0aGUgaW1w
YWN0IHRvIHRoaW5ncyB0aGF0IGFjdHVhbGx5DQo+IG1pZ2h0IGJlIHJ1bm5pbmcgYXMgc2xlZXBh
YmxlIGFuZCB3aGljaCBtb3N0IGxpa2VseSB3b24ndCBjaHVybg0KPiB0aHJvdWdoIGEgaHVnZSBh
bW91bnQgb2YgYXJyYXlzLiBXRFlUPw0KDQpIb25lc3RseSwgSSBkb24ndCBsaWtlIHRoZSBpZGVh
IG9mIGhhdmluZyB0d28gZGlmZmVyZW50IEFQSXMsIHdoZXJlIGlmIHlvdSB1c2UgdGhlDQp3cm9u
ZyBvbmUsIHRoZSBwcm9ncmFtIHdvdWxkIG9ubHkgZmFpbCBpbiByYXJlIGFuZCB1bmRlYnVnZ2Fi
bGUgY2lyY3Vtc3RhbmNlcy4gDQoNCklmIHdlIG5lZWQgc3BlY2lhbGl6YXRpb24gKGFuZCBJJ20g
bm90IGNvbnZpbmNlZCB3ZSBkbyAtIHdoYXQncyB0aGUgcmF0ZSBvZiBjZ3JvdXANCmNyZWF0aW9u
IHRoYXQgd2UgY2FuIHN1c3RhaW4/KSwgd2Ugc2hvdWxkIHRyYWNrIHRoYXQgaW4gdGhlIGJwZl9w
cm9nX2FycmF5IGl0c2VsZi4gV2UNCmNhbiBoYXZlIHRoZSBhbGxvY2F0aW9uIHBhdGggc2V0IGEg
ZmxhZyBhbmQgYnJhbmNoIG9uIGl0IGluIGZyZWUoKSB0byBkZXRlcm1pbmUgdGhlDQpuZWNlc3Nh
cnkgZ3JhY2UgcGVyaW9kcy4NCg0KPiANCj4gT3RoZXJ3aXNlIGFsbCBsb29rcyBnb29kIGFuZCBz
dXJwcmlzaW5nbHkgc3RyYWlnaHRmb3J3YXJkIHRoYW5rcyB0bw0KPiB0aGUgZmFjdCB1cHJvYmUg
aXMgYWxyZWFkeSBydW5uaW5nIGluIGEgc2xlZXBhYmxlIGNvbnRleHQsIGF3ZXNvbWUhDQo+IA0K
PiA+IA0KPiA+IFRoZSBvdGhlciBpbnRlcmVzdGluZyBpbXBsaWNhdGlvbiBpcyB3cnQgbm9uLXNs
ZWVwYWJsZSB1cHJvYmUNCj4gPiBwcm9ncmFtcy4gQmVjYXVzZSB0aGV5IG5lZWQgYWNjZXNzIHRv
IGR5bmFtaWNhbGx5IHNpemVkIHJjdS1wcm90ZWN0ZWQNCj4gPiBtYXBzLCB3ZSBjb25kaXRpb25h
bGx5IGRpc2FibGUgcHJlZW1wdGlvbiBhbmQgdGFrZSBhbiByY3UgcmVhZCBzZWN0aW9uDQo+ID4g
YXJvdW5kIHRoZW0sIGluIGFkZGl0aW9uIHRvIHRoZSBvdmVyYXJjaGluZyB0YXNrc190cmFjZSBz
ZWN0aW9uLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IERlbHlhbiBLcmF0dW5vdiA8ZGVseWFu
a0BmYi5jb20+DQo+ID4gLS0tDQo+ID4gIGluY2x1ZGUvbGludXgvYnBmLmggICAgICAgICAgfCA2
MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgaW5jbHVkZS9saW51
eC90cmFjZV9ldmVudHMuaCB8ICAxICsNCj4gPiAga2VybmVsL2JwZi9jb3JlLmMgICAgICAgICAg
ICB8IDEwICsrKysrLQ0KPiA+ICBrZXJuZWwvdHJhY2UvYnBmX3RyYWNlLmMgICAgIHwgMjMgKysr
KysrKysrKysrKysNCj4gPiAga2VybmVsL3RyYWNlL3RyYWNlX3Vwcm9iZS5jICB8ICA0ICstLQ0K
PiA+ICA1IGZpbGVzIGNoYW5nZWQsIDk0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+
ID4gDQo+IA0KPiBbLi4uXQ0KDQo=
