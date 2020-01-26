Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7101498CB
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2020 05:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgAZEyG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Jan 2020 23:54:06 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12134 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729014AbgAZEyG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 25 Jan 2020 23:54:06 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00Q4rkDa006859;
        Sat, 25 Jan 2020 20:53:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=pZye3EByGutfC44QwPWDrpB6MR8Kn8YHUKJeClL4UB0=;
 b=FzLkn6HZwUu5ITgcqvOziyH3dKSumlAV/+Ws8Qau9BFSPtauo1/S3MGkfOFaYFYMACU+
 ssmp4AJEorwW3VgHQIdNfYU6u0dsCt0lD0L/EwWmmfyzmPO1JK7DsxOo6bTYT2YfpCRc
 LZ75eU9aWiO++XbrK7mwS+ycRq8aglMKWK8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xrknqjrj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 25 Jan 2020 20:53:46 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 25 Jan 2020 20:53:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+dkaK2Zd0gVVHnkRWtkBXUlz3SFUr0Bg3wTJZ0xPJ5AnYlLdhk35AyQCv+s/UYE0bWmkQzCGS5pTOiRRrDlltGV7Pt6a1LzBQbgRevDwEUKBMF2p5WIVXXGcoev7CbPQWUSfhZap/AC7p2G6C7WkxIWjnQOhXdeM8gxGpxwUij96nhBOeupl6TPafCa7HvemORB8hHCB2JwRyXbv9q2ke4tJGDmK7c6cBWjdZ5AQOoW69NnttE8sOUngJKCQAE5wi+10gvtAfpid+CCnD3babHG9gDD4w35rYghZIv/12p1V5Tcq/LR2EcA2kD/3xx5sGqbUBFEFagQtaU3MlLFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZye3EByGutfC44QwPWDrpB6MR8Kn8YHUKJeClL4UB0=;
 b=Jh0Me7R9ouvZrTuDAPkcn8XsX56iaHJr5vKROUF9rgBUb6dlclgtZvgY9b33k4zKu9RQJQiYA5DNZZu3F/CroN0TjY2y/GPg4fDWkHh8b5xER7bKbP9RaSO2ZqDdamB4joUJ5JE1khOSqw7mFPKeSEm/ymcQ9FWeH7m9bN/qQoWPGIFIsgFhK5KLiZCbanWaOgOz7W3jyz9qIyYwAu7WXLtxsU9w8Z8CDNRqXHFmFZ7j+lOGzXSlNpV5ms/if+bDg0JHh4PfExQicPwujgZ9et9moaLmTwX0JVmYo8BZB30TtELP7FXa7Ft4KkVeUA8AO9+VIYpPcRvvIXRzxToCSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZye3EByGutfC44QwPWDrpB6MR8Kn8YHUKJeClL4UB0=;
 b=biVWwaimT5GmWmM9XimrnCZYzxqOTToVdG0pYRmRMitwJH3K0yNH1t4rYnH6FBqKTSgO2FfFqlsTOH2YZKO30YhFn1TxJoqq1WKkrRUbGly+8qCW5/Q+J+AOw2wvjp7JyN6B0Fh1VW587no+3lKVCPDnh3cLQikBUFdLzB9/b2E=
Received: from DM6PR15MB3001.namprd15.prod.outlook.com (20.178.231.16) by
 DM6PR15MB3225.namprd15.prod.outlook.com (20.179.49.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Sun, 26 Jan 2020 04:53:18 +0000
Received: from DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::294e:884:76fd:743c]) by DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::294e:884:76fd:743c%4]) with mapi id 15.20.2665.017; Sun, 26 Jan 2020
 04:53:18 +0000
Received: from macbook-pro-52.local.dhcp.thefacebook.com (2620:10d:c090:180::3a87) by MWHPR1201CA0009.namprd12.prod.outlook.com (2603:10b6:301:4a::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend Transport; Sun, 26 Jan 2020 04:53:15 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Daniel Xu <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [PATCH v5 bpf-next 1/2] bpf: Add bpf_read_branch_records() helper
Thread-Topic: [PATCH v5 bpf-next 1/2] bpf: Add bpf_read_branch_records()
 helper
Thread-Index: AQHV0883dsMEY1am1k6zxPr4pjQGT6f8YWOA
Date:   Sun, 26 Jan 2020 04:53:17 +0000
Message-ID: <a8ccc62b-f480-c307-2c33-308561dd5cd0@fb.com>
References: <20200125223117.20813-1-dxu@dxuuu.xyz>
 <20200125223117.20813-2-dxu@dxuuu.xyz>
In-Reply-To: <20200125223117.20813-2-dxu@dxuuu.xyz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1201CA0009.namprd12.prod.outlook.com
 (2603:10b6:301:4a::19) To DM6PR15MB3001.namprd15.prod.outlook.com
 (2603:10b6:5:13c::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::3a87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 967e940d-83e3-4fe5-7d6d-08d7a21ba8e8
x-ms-traffictypediagnostic: DM6PR15MB3225:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR15MB3225F36EA8DF8BC7870A2826D3080@DM6PR15MB3225.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02945962BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(376002)(346002)(366004)(189003)(199004)(66946007)(66446008)(64756008)(66556008)(66476007)(186003)(16526019)(31686004)(5660300002)(6506007)(53546011)(478600001)(2906002)(6486002)(52116002)(316002)(31696002)(86362001)(71200400001)(110136005)(54906003)(6636002)(81166006)(81156014)(8936002)(36756003)(6512007)(2616005)(8676002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB3225;H:DM6PR15MB3001.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rjnnI9WuahnQZeCrzWIPQDimvr/lMw+Y/Gv3MaLAY7x0jJ1PV2KIE//X9lWbcUVgPX9v3jFb6fwNlw03qVRqdYQt2zHSn0u0iI7vpbHXaRyAlR0T6qa1li+E5d3V3sjhF26wkSZWEJrM3AOC8O4YSgC00YGuBJZ9U/yYH+cqFNXBTM/b8pLJzRBocmaJ/+eOoW+mUHCaVEnjp4BKNYxmyUaNbZASEfdBr5ZErQvmlsDRLgR6EI5AxCbuy7+SngUdL9MBOVknmZRuGrbIosE6qLk/QArbjfkyreNWNZCVOUFsbQduK09QoBOofT4RiIKNSBSpGJQlFDJVp5N3tAUFjUTCmpgp6OLpir+zAhd3nQ5tyyTimjOWqYoVZSg3tkGoojHwlHKkecm7N8fBdPaD0F+Mb/9YVAhiGoUug7hO5ZsE0v8G7Dq/adJRMx6rJzkj
x-ms-exchange-antispam-messagedata: f3GcyNA+cdMe4psCmw4hzXywxE6p+int5K2yJMesQLKg75jxQPHbUToiHdgpuMRHu+xesmTN29iwNXNlB0pCRaEOlTGG2KAbCxWO9fxjpZjZsaON213kDrrHevizg96v3b0N0HXgm+Op6r48OqfLoEkkvD8KCLPVWqckwgQoqw8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFCB1B714220AB4A8FC9E6691BF25716@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 967e940d-83e3-4fe5-7d6d-08d7a21ba8e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2020 04:53:17.9119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bYE6oWA64+i+1rmeXf5sbfT7l7H68RcBRYYxhscDEOTGIEVJJSwIPKU/6JWqj8kR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3225
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-25_09:2020-01-24,2020-01-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 bulkscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001260041
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDEvMjUvMjAgMjozMSBQTSwgRGFuaWVsIFh1IHdyb3RlOg0KPiBCcmFuY2ggcmVjb3Jk
cyBhcmUgYSBDUFUgZmVhdHVyZSB0aGF0IGNhbiBiZSBjb25maWd1cmVkIHRvIHJlY29yZA0KPiBj
ZXJ0YWluIGJyYW5jaGVzIHRoYXQgYXJlIHRha2VuIGR1cmluZyBjb2RlIGV4ZWN1dGlvbi4gVGhp
cyBkYXRhIGlzDQo+IHBhcnRpY3VsYXJseSBpbnRlcmVzdGluZyBmb3IgcHJvZmlsZSBndWlkZWQg
b3B0aW1pemF0aW9ucy4gcGVyZiBoYXMgaGFkDQo+IGJyYW5jaCByZWNvcmQgc3VwcG9ydCBmb3Ig
YSB3aGlsZSBidXQgdGhlIGRhdGEgY29sbGVjdGlvbiBjYW4gYmUgYSBiaXQNCj4gY29hcnNlIGdy
YWluZWQuDQo+IA0KPiBXZSAoRmFjZWJvb2spIGhhdmUgc2VlbiBpbiBleHBlcmltZW50cyB0aGF0
IGFzc29jaWF0aW5nIG1ldGFkYXRhIHdpdGgNCj4gYnJhbmNoIHJlY29yZHMgY2FuIGltcHJvdmUg
cmVzdWx0cyAoYWZ0ZXIgcG9zdHByb2Nlc3NpbmcpLiBXZSBnZW5lcmFsbHkNCj4gdXNlIGJwZl9w
cm9iZV9yZWFkXyooKSB0byBnZXQgbWV0YWRhdGEgb3V0IG9mIHVzZXJzcGFjZS4gVGhhdCdzIHdo
eSBicGYNCj4gc3VwcG9ydCBmb3IgYnJhbmNoIHJlY29yZHMgaXMgdXNlZnVsLg0KPiANCj4gQXNp
ZGUgZnJvbSB0aGlzIHBhcnRpY3VsYXIgdXNlIGNhc2UsIGhhdmluZyBicmFuY2ggZGF0YSBhdmFp
bGFibGUgdG8gYnBmDQo+IHByb2dzIGNhbiBiZSB1c2VmdWwgdG8gZ2V0IHN0YWNrIHRyYWNlcyBv
dXQgb2YgdXNlcnNwYWNlIGFwcGxpY2F0aW9ucw0KPiB0aGF0IG9taXQgZnJhbWUgcG9pbnRlcnMu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgWHUgPGR4dUBkeHV1dS54eXo+DQo+IC0tLQ0K
PiAgIGluY2x1ZGUvdWFwaS9saW51eC9icGYuaCB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysr
LQ0KPiAgIGtlcm5lbC90cmFjZS9icGZfdHJhY2UuYyB8IDQxICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDY1IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgv
YnBmLmggYi9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgNCj4gaW5kZXggZjFkNzRhMmJkMjM0Li4z
MzJhYTQzM2QwNDUgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC9icGYuaA0KPiAr
KysgYi9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgNCj4gQEAgLTI4OTIsNiArMjg5MiwyNSBAQCB1
bmlvbiBicGZfYXR0ciB7DQo+ICAgICoJCU9idGFpbiB0aGUgNjRiaXQgamlmZmllcw0KPiAgICAq
CVJldHVybg0KPiAgICAqCQlUaGUgNjQgYml0IGppZmZpZXMNCj4gKyAqDQo+ICsgKiBpbnQgYnBm
X3JlYWRfYnJhbmNoX3JlY29yZHMoc3RydWN0IGJwZl9wZXJmX2V2ZW50X2RhdGEgKmN0eCwgdm9p
ZCAqYnVmLCB1MzIgYnVmX3NpemUsIHU2NCBmbGFncykNCj4gKyAqCURlc2NyaXB0aW9uDQo+ICsg
KgkJRm9yIGFuIGVCUEYgcHJvZ3JhbSBhdHRhY2hlZCB0byBhIHBlcmYgZXZlbnQsIHJldHJpZXZl
IHRoZQ0KPiArICoJCWJyYW5jaCByZWNvcmRzIChzdHJ1Y3QgcGVyZl9icmFuY2hfZW50cnkpIGFz
c29jaWF0ZWQgdG8gKmN0eCoNCj4gKyAqCQlhbmQgc3RvcmUgaXQgaW4JdGhlIGJ1ZmZlciBwb2lu
dGVkIGJ5ICpidWYqIHVwIHRvIHNpemUNCj4gKyAqCQkqYnVmX3NpemUqIGJ5dGVzLg0KPiArICoN
Cj4gKyAqCQlUaGUgKmZsYWdzKiBjYW4gYmUgc2V0IHRvICoqQlBGX0ZfR0VUX0JSQU5DSF9SRUNP
UkRTX1NJWkUqKiB0bw0KPiArICoJCWluc3RlYWQJcmV0dXJuIHRoZSBudW1iZXIgb2YgYnl0ZXMg
cmVxdWlyZWQgdG8gc3RvcmUgYWxsIHRoZQ0KPiArICoJCWJyYW5jaCBlbnRyaWVzLiBJZiB0aGlz
IGZsYWcgaXMgc2V0LCAqYnVmKiBtYXkgYmUgTlVMTC4NCj4gKyAqCVJldHVybg0KPiArICoJCU9u
IHN1Y2Nlc3MsIG51bWJlciBvZiBieXRlcyB3cml0dGVuIHRvICpidWYqLiBPbiBlcnJvciwgYQ0K
PiArICoJCW5lZ2F0aXZlIHZhbHVlLg0KPiArICoNCj4gKyAqCQkqKi1FSU5WQUwqKiBpZiBhcmd1
bWVudHMgaW52YWxpZCBvciAqKmJ1Zl9zaXplKiogbm90IGEgbXVsdGlwbGUNCj4gKyAqCQlvZiBz
aXplb2Yoc3RydWN0IHBlcmZfYnJhbmNoX2VudHJ5KS4NCj4gKyAqDQo+ICsgKgkJKiotRU5PRU5U
KiogaWYgYXJjaGl0ZWN0dXJlIGRvZXMgbm90IHN1cHBvcnQgYnJhbmNoIHJlY29yZHMuDQo+ICAg
ICovDQo+ICAgI2RlZmluZSBfX0JQRl9GVU5DX01BUFBFUihGTikJCVwNCj4gICAJRk4odW5zcGVj
KSwJCQlcDQo+IEBAIC0zMDEyLDcgKzMwMzEsOCBAQCB1bmlvbiBicGZfYXR0ciB7DQo+ICAgCUZO
KHByb2JlX3JlYWRfa2VybmVsX3N0ciksCVwNCj4gICAJRk4odGNwX3NlbmRfYWNrKSwJCVwNCj4g
ICAJRk4oc2VuZF9zaWduYWxfdGhyZWFkKSwJCVwNCj4gLQlGTihqaWZmaWVzNjQpLA0KPiArCUZO
KGppZmZpZXM2NCksCQkJXA0KPiArCUZOKHJlYWRfYnJhbmNoX3JlY29yZHMpLA0KPiAgIA0KPiAg
IC8qIGludGVnZXIgdmFsdWUgaW4gJ2ltbScgZmllbGQgb2YgQlBGX0NBTEwgaW5zdHJ1Y3Rpb24g
c2VsZWN0cyB3aGljaCBoZWxwZXINCj4gICAgKiBmdW5jdGlvbiBlQlBGIHByb2dyYW0gaW50ZW5k
cyB0byBjYWxsDQo+IEBAIC0zMDkxLDYgKzMxMTEsOSBAQCBlbnVtIGJwZl9mdW5jX2lkIHsNCj4g
ICAvKiBCUEZfRlVOQ19za19zdG9yYWdlX2dldCBmbGFncyAqLw0KPiAgICNkZWZpbmUgQlBGX1NL
X1NUT1JBR0VfR0VUX0ZfQ1JFQVRFCSgxVUxMIDw8IDApDQo+ICAgDQo+ICsvKiBCUEZfRlVOQ19y
ZWFkX2JyYW5jaF9yZWNvcmRzIGZsYWdzLiAqLw0KPiArI2RlZmluZSBCUEZfRl9HRVRfQlJBTkNI
X1JFQ09SRFNfU0laRQkoMVVMTCA8PCAwKQ0KPiArDQo+ICAgLyogTW9kZSBmb3IgQlBGX0ZVTkNf
c2tiX2FkanVzdF9yb29tIGhlbHBlci4gKi8NCj4gICBlbnVtIGJwZl9hZGpfcm9vbV9tb2RlIHsN
Cj4gICAJQlBGX0FESl9ST09NX05FVCwNCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC90cmFjZS9icGZf
dHJhY2UuYyBiL2tlcm5lbC90cmFjZS9icGZfdHJhY2UuYw0KPiBpbmRleCAxOWU3OTNhYTQ0MWEu
LjVhMGFiN2M5YTFkYyAxMDA2NDQNCj4gLS0tIGEva2VybmVsL3RyYWNlL2JwZl90cmFjZS5jDQo+
ICsrKyBiL2tlcm5lbC90cmFjZS9icGZfdHJhY2UuYw0KPiBAQCAtMTAyOCw2ICsxMDI4LDQ1IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgYnBmX2Z1bmNfcHJvdG8gYnBmX3BlcmZfcHJvZ19yZWFkX3Zh
bHVlX3Byb3RvID0gew0KPiAgICAgICAgICAgIC5hcmczX3R5cGUgICAgICA9IEFSR19DT05TVF9T
SVpFLA0KPiAgIH07DQo+ICAgDQo+ICtCUEZfQ0FMTF80KGJwZl9yZWFkX2JyYW5jaF9yZWNvcmRz
LCBzdHJ1Y3QgYnBmX3BlcmZfZXZlbnRfZGF0YV9rZXJuICosIGN0eCwNCj4gKwkgICB2b2lkICos
IGJ1ZiwgdTMyLCBzaXplLCB1NjQsIGZsYWdzKQ0KPiArew0KPiArCXN0cnVjdCBwZXJmX2JyYW5j
aF9zdGFjayAqYnJfc3RhY2sgPSBjdHgtPmRhdGEtPmJyX3N0YWNrOw0KPiArCXUzMiBicl9lbnRy
eV9zaXplID0gc2l6ZW9mKHN0cnVjdCBwZXJmX2JyYW5jaF9lbnRyeSk7DQo+ICsJdTMyIHRvX2Nv
cHk7DQo+ICsNCj4gKyNpZm5kZWYgQ09ORklHX1g4Ng0KPiArCXJldHVybiAtRU5PRU5UOw0KPiAr
I2VuZGlmDQoNCkZvciBub24geDg2IHBsYXRmb3JtLCB3ZSB3aWxsIGdldCBhIGxvdCBvZiBjb21w
aWxlciB3YXJuaW5nIGZvcg0KdW51c2VkIHZhcmlhYmxlcz8NCg0KPiArDQo+ICsJaWYgKHVubGlr
ZWx5KGZsYWdzICYgfkJQRl9GX0dFVF9CUkFOQ0hfUkVDT1JEU19TSVpFKSkNCj4gKwkJcmV0dXJu
IC1FSU5WQUw7DQpbLi4uXQ0K
