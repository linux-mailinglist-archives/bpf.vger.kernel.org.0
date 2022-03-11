Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1796C4D685F
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 19:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239424AbiCKST7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Mar 2022 13:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237086AbiCKST6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 13:19:58 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC6A4AE28
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 10:18:55 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22BHj0RE018553
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 10:18:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=1bmCxAFVcVZnJ8/IOLTnpo1x6j3UGBxECAezaoupZD0=;
 b=AFxjpOFUzpxnYHBwAoz73zmLvpJ3B/yUXpUNDR6IfT++u2dRNkwbPml3KOQixvXJu3Ow
 18Du+p0Ui+Fw3O64+U4PcawpXTm1DZmUOOGGDzN9skcN2Njt6Mnbl09yCZxg2zLWEIbU
 yAF+OyMPftpsmKN+/wRXa2yhSiZlGKYZ8ek= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eqpk783gq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 10:18:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIV/EpG8W8Kk33/LetJkUdxzkXc/J2b7dYRqxGZpkJI6e9eENEAdZNCNxOrIDxPkMzVvb3n/fWDONy/6vqG7fW6JraGnrJr3Ohr6nyA+MRAdDeRIU1F8J1/VXJpa6DK/D5ilxWYuV84PFmjIdOa+vhtz7NxLCtpx115a2H+JW720l/6yixPpIprPDYWwi4XCL6gOfVo7v/Zl3VTnl0hJS4xyYl82Ao6mv+L6EXSvTnwQjTC/DsK6eO863Gc1aQzTW912TsgchvGjT3BYQ6npdR7K+3BTaz5V669rPSId+ogTQzqOtHNYdQ6UhJMsLcjW8OSHZxsOVZ1QLNmtFRb+Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bmCxAFVcVZnJ8/IOLTnpo1x6j3UGBxECAezaoupZD0=;
 b=MdCTOko48ufK9Pvu4wxcAWynxU8/h3w1fwNGYVykSM3q9VuJN3zqtMhiQG1jJOuanK4I90UlhJFPaq/pnQLm2PKh+pU0pwPh5y2qDVx4Aqbng9R4RalSbMrTyqVXctnt0+sMf1msCMY8czR7ZClQ+jr7miEAeTSwDZKB/xDvgiwlCBsT3A2umg/mfCgGs2pNcL0nwoUmHVo1mPvWh1QcerFbuVvVUiIbtJbTPMNBc8LFJf2IOX2jNpAnhRTpYHNEoBYb+jIhSZ1UcN7dPX+dQxD4nYGyGm53Amu8HesHLb+vbc/BKgSiFgeRVUuVTSF8AOifXp+sKcZ/FMHCGLPRLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by MWHPR15MB1470.namprd15.prod.outlook.com (2603:10b6:300:bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Fri, 11 Mar
 2022 18:18:53 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%6]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 18:18:51 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 0/5] Subskeleton support for BPF libraries
Thread-Topic: [PATCH bpf-next v2 0/5] Subskeleton support for BPF libraries
Thread-Index: AQHYNNyZXUIcFBmW1UKEgKE9kIRFLKy5ouQAgADa5gA=
Date:   Fri, 11 Mar 2022 18:18:51 +0000
Message-ID: <35a4dc621d45df496dab781b22d710e2dabaa1d3.camel@fb.com>
References: <cover.1646957399.git.delyank@fb.com>
         <9f4b3d01-d47f-bb3c-0ced-b83978c15dde@fb.com>
In-Reply-To: <9f4b3d01-d47f-bb3c-0ced-b83978c15dde@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: adf8a29d-892e-403f-437d-08da038b985c
x-ms-traffictypediagnostic: MWHPR15MB1470:EE_
x-microsoft-antispam-prvs: <MWHPR15MB1470136217DC8D1665315131C10C9@MWHPR15MB1470.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GnTgRJt+HyuzJqtGd2XmzH0ohFg4zYWPkKmebTFEjUraraXjuyARt/A2VPjmaqC4jNyCsjIdIMODw/AcoPl6AH8y1JAGFXalhMHmuNuTxymozkqG6wsx347fDAic1e3z/ZCZ1cZfrKPdS3BNFQcWhfBIklfEeiQaGHeRJUY7yRtCOQwhwSaP3RSchvCmwbfMrlFro1OLScNk88PQg5qyNvJ3yH8uTmh0M1PeZiU8whtlbOePRif8fY03P6NiNitYLxlsXw2UYF73/NO5AYbvFFYp8AbqbFwZ0T6AdsaQDlJRqyNXorxVVpKRpbTnIicucvzBJ9An/YePS4idUifVNK7r10uXPQ86Rm+vvCLTYkTs+yTBO67Sg4SsXz7IuO9FBjHFQQXpagucMtaTJfGe9we9b3C/WeX4aQ/Dy5SR+YXFYn/ADycwtyUGUaO+s9ZU7qr88bE3s2gbRwRCB3oynqBrwaiLwSIkQfRQnog1k71widG8kpOX4zwiMNLQ1HvJOfT6x3D42A+9C6eDulqbIRvsh3nRDtyBuIjweF3BYT1S8vNehXI8c5WvZQiQLmq4I+WNipF0E/z3jboLR2dJ/FO3GNtTITCTiedmsmkx/FIYWdSPqZOHNigLyzZURQXqiFKaGdKWGBLBgjEXGH658oPyKkP+Bw/wy90GDfQlsy6U5slClZw7hMoMImL78tUWM4K8QQ4uWrd3wvj/rhG2KA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(2906002)(53546011)(36756003)(6506007)(6486002)(38070700005)(508600001)(71200400001)(86362001)(8936002)(5660300002)(2616005)(66556008)(66476007)(66446008)(64756008)(8676002)(122000001)(91956017)(76116006)(186003)(66946007)(6512007)(38100700002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjlWL2w2TFhXTkUvalI3VzI5dmpvUVV4Y1hldmNBek0yRlpQNnArUWJ1bUVw?=
 =?utf-8?B?Q3ZHNHZMWVM1djVFcFVIVXpxK0hSU3lQRlVYak93U3d0QkdoQ2hjbUZrUmcr?=
 =?utf-8?B?bXQxUm5uOEV6N0RHOGlES1hVcVlCdG9ta0Vwa3VwaFYvU2RnMnF6eExjU1JV?=
 =?utf-8?B?aEVmZmxBL3JNVmUwU2VZb0NJMWpjTmRudGhRQkhnclpzcEJaOUd6Z1VQb09H?=
 =?utf-8?B?elRPMVI3Rk5xNTJwczFwK1YwNG5RVnM3NWZEdzdaTXBkc0NLYXZVQ3ArKzE5?=
 =?utf-8?B?TGpUSEU4SmR4Y3VmQVU5NHpEdUE2Y3g4Skw5OFJBMWVObDZIR1B4S2VHOVM2?=
 =?utf-8?B?ZWFUSEtaZVVNVFNTN2JoSTJkN3h3enFQbklIQmx4T0gyaFoxd3FidzJmOUEy?=
 =?utf-8?B?MkNkYXIrM3VkaGdqNGFId1pXdlZ6UkxkeCtqYmJpUWFwSyt3RmtyTE84TENJ?=
 =?utf-8?B?eVV3dmpJQjEvMlhEWlVKL21rVFllWE9jN0djeVJ3VXRDUXRUU2xVMVd5alJT?=
 =?utf-8?B?cHhFb3R1RVhEcnlXeFhjcUExQS9iRHVoOHQwUnRCdDE0dFlMakNRNm1VWWc4?=
 =?utf-8?B?ejNzbzVlTlAyaTJmaUpwNk1WeXFUS1ZMU0IzQ1pwdUpjcis5c0YzOEp3V1Bt?=
 =?utf-8?B?aTRObzNRYWxZZENRNUFBVzVNMy9BUVRONm84NklkNTc0Y1ZtekgzOUV3N3Mv?=
 =?utf-8?B?U1FOSWpHMmdSdlFIeTRpcEpXbHZEV0sxMmtiSFZhMEx3SWl2T3hoaG9rdW9K?=
 =?utf-8?B?TTFTMVFtSzI1K0ZYMUpaWUtxaFZDTXoxWkMxYy96enRKK0IrYWFSSG42YVhp?=
 =?utf-8?B?L3NyenVFaVZ1NUU3LysxZlh3S3BWODRqd0VnMTVpcERrK3lGeUEwYWdxT0Fm?=
 =?utf-8?B?Uk0yUFlaSVprWWpMV3IzVW5ITFRyck5jVzRJUTFVd0EwbjdkQ2pDRk5Sb1Vq?=
 =?utf-8?B?eDRKU1hRTys2ZWgwZkNtM2ZKQ3RzNEE1ZnVmWlZ2aDZRUDZ1bEgzQk5MbzNy?=
 =?utf-8?B?Rjh6Yzc3N3J1WHdXRGM2NWFzT2UxcFlWMWEyU3VwNm9XVXhmNGg0OVozTE5N?=
 =?utf-8?B?elR5WDJvUnM3M3ZBUmJXM0tLSHlzTTNkQ1BJWGx5TnRXakVTRnZIVUEvUTFT?=
 =?utf-8?B?SjIyQzRxSGJpMHYrdkYzdW1uTXNlcXRVeXR2L09JQU5QdXZhWmdyRFNmZXdU?=
 =?utf-8?B?S003RVNXYzJ0d1YvcThHOEw2UWJxRHlBV24razlvcC9KalR6Y0x6SW1SS2Fz?=
 =?utf-8?B?YXdzZk1sbUhCd3R2eTU5RW11cGxCQm52V3dhODZBRFRTakFrVTJnYnZneTcy?=
 =?utf-8?B?RCttSUZSam5VODBUWHp1NjZaeWxaMHlpNXh3R3FuMTBaekFhOUFUTnpiVGNs?=
 =?utf-8?B?SW1pd1BvK0lVMHQ4b2JZKytDbGpnWnQ3TlJTVnZkcVNSQ2hiMW0yTVFTSHg0?=
 =?utf-8?B?Z21HbWpHNXY3QmJsVURMZGVjS1hMSUsyQVQzQjhNYkJjaGIvWVNzenpMNjE3?=
 =?utf-8?B?MjNLR1JLVjlNbTVhOFVCVDRlaEM4RHBLMFp6NHprRC85NWNjRllEZkc5dVVN?=
 =?utf-8?B?LytIWENiWEdaQXBtWFRrK2FBYkhGU3lCMnZDbWRIM0hiaFNvdElmWVRsRTkv?=
 =?utf-8?B?MDg0NmR4cUpSd1h1T1FWZmRXaGhobG1JRnJBNmdySFBIUUV6UEF0em52Tmxv?=
 =?utf-8?B?SitVRkJsdnMrakpnZ0trZGVTZzhEZDRyWHhpb1ZXN1FiSE4yNGkwYlBUOXpz?=
 =?utf-8?B?NERJWEhjaE9QbFlLcnVjcU5DVXc5djhpeVZvNzBJd1lLQzROYnREOEw5bjlK?=
 =?utf-8?B?ME4xaENmeWlWejkxUEpwenZMYy9JaitPMXk2QW9rcnNxbjZtVFZERUR2R081?=
 =?utf-8?B?Z20wVzcrRmI0NUV4U0hOS2tZTG9NVVhUWFRONU04cWFVNjBGVGRKRUlJQWxi?=
 =?utf-8?B?eUMwWmJXZDd4MkxWcVZicWpMaDIyek5NT1lXYkhuVUwzV0NEMTBUL0tLVmJh?=
 =?utf-8?Q?EALxFcLBQTVcOuTnfROk0K3DH8MR6c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41F323253D06774695F2E8E7A4E43450@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf8a29d-892e-403f-437d-08da038b985c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 18:18:51.6617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ozEp+wIeRXQqeOpF+GfgCfePI+uXYbm9RcrinpGM/iJ9+08lKCS42mbH7J8l9jpf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1470
X-Proofpoint-GUID: TnzFnwZamp73Ki5p_i-4cYxRPVzg_UDz
X-Proofpoint-ORIG-GUID: TnzFnwZamp73Ki5p_i-4cYxRPVzg_UDz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-11_07,2022-03-11_02,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVGh1LCAyMDIyLTAzLTEwIGF0IDIxOjEwIC0wODAwLCBZb25naG9uZyBTb25nIHdyb3RlOg0K
PiANCj4gT24gMy8xMC8yMiA0OjExIFBNLCBEZWx5YW4gS3JhdHVub3Ygd3JvdGU6DQpbLi5dDQo+
IA0KPiBXaGVuIEkgdHJpZWQgdG8gYnVpbGQgdGhlIHBhdGNoIHNldCB3aXRoIHBhcmFsbGVsIG1v
ZGUgKC1qKSwNCj4gICAgIG1ha2UgLUMgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmIC1qDQo+
IEkgaGl0IHRoZSBmb2xsb3dpbmcgZXJyb3JzOg0KPiANCj4gL2Jpbi9zaDogbGluZSAxOiAzNDg0
OTg0IEJ1cyBlcnJvciAgICAgICAgICAgICAgIChjb3JlIGR1bXBlZCkgDQo+IC9ob21lL3locy93
b3JrL2JwZi1uZXh0L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi90b29scy9zYmluL2JwZnRv
b2wgDQo+IGdlbiBza2VsZXRvbiANCj4gL2hvbWUveWhzL3dvcmsvYnBmLW5leHQvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvYnBmL3Rlc3Rfa3N5bXNfd2Vhay5saW5rZWQzLm8gDQo+IG5hbWUgdGVz
dF9rc3ltc193ZWFrID4gDQo+IC9ob21lL3locy93b3JrL2JwZi1uZXh0L3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2JwZi90ZXN0X2tzeW1zX3dlYWsuc2tlbC5oDQo+IG1ha2U6ICoqKiBbTWFrZWZp
bGU6NDk2OiANCj4gL2hvbWUveWhzL3dvcmsvYnBmLW5leHQvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvYnBmL3Rlc3Rfa3N5bXNfd2Vhay5za2VsLmhdIA0KPiBFcnJvciAxMzUNCj4gbWFrZTogKioq
IERlbGV0aW5nIGZpbGUgDQo+ICcvaG9tZS95aHMvd29yay9icGYtbmV4dC90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9icGYvdGVzdF9rc3ltc193ZWFrLnNrZWwuaCcNCj4gbWFrZTogKioqIFdhaXRp
bmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4NCj4gbWFrZTogTGVhdmluZyBkaXJlY3RvcnkgDQo+
ICcvaG9tZS95aHMvd29yay9icGYtbmV4dC90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYnDQo+
IA0KPiBQcm9iYWJseSBzb21lIG1ha2UgZmlsZSByZWxhdGVkIGlzc3Vlcy4NCj4gSSBkaWRuJ3Qg
aGl0IHRoaXMgaXNzdWUgYmVmb3JlIHdpdGhvdXQgdGhpcyBwYXRjaCBzZXQuDQoNCkhtLCB0aGF0
J3MgaW50ZXJlc3RpbmcsIGNhbiB5b3UgcmVwcm9kdWNlIGl0PyBJIGJ1aWxkIGV2ZXJ5dGhpbmcg
d2l0aCAtaiBhbmQNCmhhdmUgbm90IHNlZW4gYW55IGJwZnRvb2wgaXNzdWVzLiBJIGFsc28gdXNl
IEFTQU4gZm9yIGJwZnRvb2wgYW5kIHRoYXQncyBub3QNCmNvbXBsYWluaW5nIGFib3V0IGFueXRo
aW5nIGVpdGhlci4NCg0KU0lHQlVTIHN1Z2dlc3RzIGEgbWVtb3J5IG1hcHBlZCBmaWxlIHdhcyBu
b3QgdGhlcmUuIEknbGwgdHJ5IGFuZCBjb21lIHVwIHdpdGgNCndheXMgdGhhdCBjYW4gaGFwcGVu
LCBlc3BlY2lhbGx5IGdpdmVuIHRoYXQgaXQncyBhIGBnZW4gc2tlbGV0b25gIGludm9jYXRpb24s
DQp3aGljaCBJIGhhdmVuJ3QgY2hhbmdlZCBhdCBhbGwuDQoNCi0tRGVseWFuDQo=
