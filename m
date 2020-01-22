Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 373B7144BF6
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2020 07:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgAVGs6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jan 2020 01:48:58 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39490 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725836AbgAVGs6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Jan 2020 01:48:58 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00M6kQJx018004;
        Tue, 21 Jan 2020 22:48:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=3K/cFoSTlZO0Nx6JZYAdaGWDagvEEb3x7Buj6dVwPhk=;
 b=l+WVNAK/Ak02Vs2G264ANG0445qT18Pf1S1OSR8VG+YnHhlmh5FppWkFo1AvTUgztMkU
 aRuIsXtEz/7bWG3bzAiH7bCRDYT4fADVGkcW6z2zUR7UezVq8H2UOqE2wt922rop+yh2
 qoU8gnweBXmcoVEBkGwY0LjAugED70hw9Nw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xp9a4st1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Jan 2020 22:48:56 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 21 Jan 2020 22:48:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABrD30bUVNNBwWoqVrg4E2TdVP61we+iBWbsIo5wbDJhwIho7GhRkboaMNR7eu9Zm+91Kl0cTFYSG8ciarBHulgt/6o+ZbId+ffAHp45uC0rHffL0JfDxjmp0wHjCiwbJOh2iA8q8EIzncNgn7RGjdPHeIlhdSqSEK7Yp5KAJFIW1e5+lU01fEY9gWQE5DKjOpaBlO+m/QRAuconKd8RoMKjwD6CtwYRYGda6GfOMguT4dMwttL3dPpg10AhzmwJB6CiivgiA32r2eTG7f3FF7jqTguHxbYyzd6uE0+BMWwhds8y9XYnxhMEfP0Fc8Cg4Na65pDNebvFHzWx56BZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3K/cFoSTlZO0Nx6JZYAdaGWDagvEEb3x7Buj6dVwPhk=;
 b=O+4WTeRnuAPcu+A8Ci9Fkm5jeEGKT8nqOC/sZj/KVM3D9y59YyhGXXh/OR8Icn+1U67R5pim4Sxz1TTdE8KP88dlFGkJc07kYik8+wer32KY9WwEK6pLm+o66Bb+W1GY7ferJt1TuZWwuT6t/gzmIrbu6R72DNmjRp8f7jiwiobRLW9O1krReHO8r7oRZQMJc5t7Aq33c5bZB69yn7zApwYjUj2WVN7Uf8BCI1hln2ZGBGHmoXqXYV6YdqhsyVNDYkRyCIy5SNLlD71DBfJ7AEfGMrpqJ4+t6YfJg5vBdf3oAMWD0ACDhFy2fCy8Z0wXWS5ohYluK5/xwIoJ7EmIFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3K/cFoSTlZO0Nx6JZYAdaGWDagvEEb3x7Buj6dVwPhk=;
 b=HGA3f9ZEvziGTJU6698EU4AhsgJC+c0HSIxX4OsODYsvh/i4E5Ldxp5WmtE5sM40jOuyYbWenau9ObhoNcTAaI51qsBiTj2gffwNwFfeWnkEsNJyI50cwC9YRWMWOTRjvJIU5f1Fi0SrOnmpe8dmailUT7nL7jAmnoQzu8URebM=
Received: from DM6PR15MB3001.namprd15.prod.outlook.com (20.178.231.16) by
 DM6PR15MB3580.namprd15.prod.outlook.com (10.141.165.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.21; Wed, 22 Jan 2020 06:48:51 +0000
Received: from DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::1d74:b392:183e:c8c2]) by DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::1d74:b392:183e:c8c2%6]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 06:48:51 +0000
Received: from macbook-pro-52.local.dhcp.thefacebook.com (2620:10d:c090:180::abe3) by MW2PR2101CA0032.namprd21.prod.outlook.com (2603:10b6:302:1::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.5 via Frontend Transport; Wed, 22 Jan 2020 06:48:50 +0000
From:   Yonghong Song <yhs@fb.com>
To:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: [LSF/MM/BPF TOPIC] BPF unit testing
Thread-Topic: [LSF/MM/BPF TOPIC] BPF unit testing
Thread-Index: AQHV0PAB7kknaz96o0qhzen3DYMP7Q==
Date:   Wed, 22 Jan 2020 06:48:51 +0000
Message-ID: <59e057cb-2432-0b16-d47c-3878c9d7e61f@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR2101CA0032.namprd21.prod.outlook.com
 (2603:10b6:302:1::45) To DM6PR15MB3001.namprd15.prod.outlook.com
 (2603:10b6:5:13c::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::abe3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17b1ecf6-80c8-4847-17bf-08d79f0723fc
x-ms-traffictypediagnostic: DM6PR15MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR15MB3580F3886E7FDFC959D4BD9DD30C0@DM6PR15MB3580.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(366004)(376002)(189003)(199004)(31686004)(81156014)(8936002)(2906002)(81166006)(66946007)(66446008)(64756008)(66556008)(66476007)(8676002)(6512007)(6916009)(2616005)(4326008)(316002)(478600001)(36756003)(6486002)(86362001)(5660300002)(54906003)(71200400001)(52116002)(6506007)(16526019)(186003)(31696002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB3580;H:DM6PR15MB3001.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zg15toEUC0j241qnviv893kpkWRHwnaPm7CpvEFmT1CeZPW0Q75mouhn8vvkkqen8IMnaTQMs2JlCXE/sbZ0P4YpExmrfagwudA1+by7QlWg2AKadMogtleq3oRQqpDJHG+qS4rN0UXyI1jGHpEtM/Y6m+rlGpL9+l9WwByqamX4ctqMzM4DjSrJVdHRJo1yK7nVjFGTgSphNGI7sI5EfBy++anSKniw8ExULkCwrdbBT7nbFzwI4D8KhehZnc6yn1Jb+bGf95Z7sJR5gHPjvwSkPIAXLH++zYQcc24BeMWjrTEYNg4pS+zoTAiMxh05nnpPy8F1jm8/JsoLUZLrWzQlK2r2f4qJXN9Y+1RGTFvjQeEE5zE7Up6QcnG5toqwoJTm4j0d52qhPDFqLLGoUJZNL8n0vkfTLb+Td4lmy07+eDmnBnqwg/YeADnnj0ep
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DF8975B33B4B54EAF860B6EE4E123B3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b1ecf6-80c8-4847-17bf-08d79f0723fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 06:48:51.4904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7eIb6xnoWVYdiFn6USJtc1U8HPLjFCN+32fwvUhmbAyXwSax+zib1k6JjPxmfVo0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3580
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=637 mlxscore=0 phishscore=0 clxscore=1011 suspectscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001220060
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

QlBGIFVuaXQgVGVzdGluZw0KPT09PT09PT09PT09PT09PQ0KDQpVbml0IHRlc3RzIGFyZSB2ZXJ5
IGltcG9ydGFudCBiZWZvcmUgZGVwbG95aW5nIHRoZSBhcHBsaWNhdGlvbg0KdG8gcHJvZHVjdGlv
bi4gRm9yIEJQRiwgYnBmX3Byb2dfdGVzdF9ydW4oKSBzdWJjb21tYW5kDQppcyBkZXNpZ25lZCBm
b3IgdW5pdCB0ZXN0aW5nLiBVc2VyIHByb3ZpZGVzIGlucHV0IGRhdGENCihlLmcuLCBwYWNrZXQp
IGFuZCBpbnB1dCBjb250ZXh0LCB0aGUgYnBmIHByb2dyYW0gd2lsbA0KYmUgZXhlY3V0ZWQgaW4g
dGhlIGtlcm5lbCwgYW5kIHBvdGVudGlhbGx5IG1vZGlmaWVkDQpwYWNrZXQgYW5kIGNvbnRleHQg
YXJlIHJldHVybmVkIHRvIHRoZSB1c2VyIHNwYWNlDQpmb3IgY2hlY2tpbmcuIEN1cnJlbnRseSwg
Y2VydGFpbiBicGYNCnByb2dyYW1zIHdpdGggX19za19idWZmIGNvbnRleHRzLCB4ZHAgcHJvZ3Jh
bXMgYW5kDQpmbG93IGRpc3NlY3RvciBwcm9ncmFtcyBhcmUgc3VwcG9ydGVkLg0KDQpGb3IgYmV0
dGVyIEJQRiB1bml0IHRlc3RpbmcsIGZpcnN0bHksIHdlIHJlYWxseSB3YW50DQpicGZfcHJvZ190
ZXN0X3J1bigpIHRvIHN1cHBvcnQgYWxsIHByb2dyYW0gdHlwZXMuDQpTZWNvbmRseSwgdGhlIGN1
cnJlbnQgdmVyaWZpY2F0aW9uIGZvciBvbmx5IHJldHVybmluZyBwYWNrZXRzDQphbmQgY29udGV4
dHMgbWF5IG5vdCBiZSBlbm91Z2guIElmIHRoZSBicGYgcHJvZ3JhbSBtb2RpZmllcw0KYSBwYXJ0
aWN1bGFyIGtlcm5lbCBkYXRhIHN0cnVjdHVyZSBmaWVsZCwgdXNlciBtYXkgd2FudCB0bw0KdmVy
aWZ5IGl0IGlzIGluZGVlZCBjaGFuZ2VkIHdpdGhvdXQgbW9kaWZ5aW5nDQpicGYgcHJvZ3JhbXMu
IExhc3RseSwgV2UgbWF5IGhhdmUgc29tZSBicGYgaGVscGVycw0KaGFyZCB0byBzdXBwb3J0LCBl
LmcuLCBicGZfcmVkaXJlY3QuDQoNCldlIHdvdWxkIGxpa2UgdG8gZGlzY3VzcyB0aGUgYWJvdmUg
dGhyZWUgaXNzdWVzIHNvDQpicGYgdW5pdCB0ZXN0aW5nIGNhbiBiZWNvbWUgbXVjaCBiZXR0ZXIu
DQoNCi0tIFlvbmdob25nDQo=
