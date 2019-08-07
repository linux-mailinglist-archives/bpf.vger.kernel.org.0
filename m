Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC1F1843A8
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 07:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfHGFYu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Aug 2019 01:24:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:4584 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725834AbfHGFYu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Aug 2019 01:24:50 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x775NkG6010018;
        Tue, 6 Aug 2019 22:24:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=zCV7qVxlfQtu8qBoUochrrA+bP2jxEtucipNfat/3hk=;
 b=AfoH3pnCtxuWd6mXd6MXfgfgHCL4psbXQYwL5qkgjo2GRMqXB6Y25t6ZIKjUfzfgmbVq
 GZEMmlhzkBRz026YRjS0LUqV+ZlL3KocgLhbLMTPYalTKHAVvC6FJFkB+eOq5+cQFcmi
 pPY/kUIcIntQb/2TsR8hTjCYk0GMIm/zZL8= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2u7dega80g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 22:24:44 -0700
Received: from prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 6 Aug 2019 22:24:44 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 6 Aug 2019 22:24:43 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 6 Aug 2019 22:24:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8YTvUZPkqON8qxeWFB/OOvU825hBFUIvyeJlMdg7w2v4W0g9Zy7khFaUk44qKhItUA6F8Qr8mfWJxl3OFM6Q3Bbntt5xVIfx9XKEVNbZlxqfRAmVFxvPUWrFXOE7w9hNkSd7VoNErU5Tmqj5MmB0FyXHcWCx9RJkepOCToZZUzYimYSF1P/oA9HXw41zNfNA5ryw24yCOF0E8wngedHx6jyyyFWF/3lg70Z69qPEkI/HVqUMo0b21ioCaPhqYyp3ibhV9Kz1neaLhldvKauitI2Uu3YhtyR33XNVCmKX3gCCHZEjH7GorOjpIYJdQQG2u3y4+y5L2kfDb2qdKtuqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCV7qVxlfQtu8qBoUochrrA+bP2jxEtucipNfat/3hk=;
 b=UDMVqWM9B2D6/E/PENGMvHg3fADW56x87dtItL5JlBbuBd7pH1vpfXszKrfNezvfYX1/cDwmykzA4vIorGHqg65q0r/pZXwmrh4fcDnRKotByoiJgNJx43OVd/cvxYgbb1caqweKMGA2qTH49+7eT1BKs2wK4pnijsmKBh0a6L0q1SdHFz5/BE/sFfmG/hlMM97IZ3OdMF56Vpgf2zZLvljQfC84KEggDtGWH/FB5BnVLUCd5VvQrxrf6K+0OMpwbQZWsEECF5rHfEn/FFPXsnyw7IeBScR+VGxNaMhu4rNnuI3fiC3a0GXShVkCpl5Gr1hy8WUAJx5ZWirF9sYOpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCV7qVxlfQtu8qBoUochrrA+bP2jxEtucipNfat/3hk=;
 b=RKtsW/+OnrR6i1ZH0x9hMyy2iLlh3RVU7hnjnmun337CBggf9RjgLoKckbrX+0725tMnzqbRLWKzcZRgspBweNGTIbMiGWlxDEvvX/LY0c+fyOOUau2kvb0zf9egzSj2Zmxd0fCZlRhSE6ug90xZ27Tm3BYCUzNu/in2kO8Z+Xo=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2903.namprd15.prod.outlook.com (20.178.236.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Wed, 7 Aug 2019 05:24:42 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::e499:ecba:ec04:abac]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::e499:ecba:ec04:abac%5]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 05:24:42 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Daniel Xu <dxu@dxuuu.xyz>, Song Liu <songliubraving@fb.com>,
        "Andrii Nakryiko" <andriin@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 0/3] Add PERF_EVENT_IOC_QUERY_KPROBE ioctl
Thread-Topic: [PATCH 0/3] Add PERF_EVENT_IOC_QUERY_KPROBE ioctl
Thread-Index: AQHVTLBUsCK/wKyu6keZv9Yfx2ZBkqbvJ28A
Date:   Wed, 7 Aug 2019 05:24:42 +0000
Message-ID: <35d25c32-b4df-1e67-27a0-8fefe0ab27e6@fb.com>
References: <20190806233826.2478-1-dxu@dxuuu.xyz>
In-Reply-To: <20190806233826.2478-1-dxu@dxuuu.xyz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR07CA0054.namprd07.prod.outlook.com (2603:10b6:100::22)
 To BYAPR15MB3384.namprd15.prod.outlook.com (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1dec]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 042a30a3-68a2-445b-c8cd-08d71af78cf4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2903;
x-ms-traffictypediagnostic: BYAPR15MB2903:
x-microsoft-antispam-prvs: <BYAPR15MB290308C2DE95FE91D4FB04CBD3D40@BYAPR15MB2903.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(189003)(199004)(6636002)(66446008)(71190400001)(71200400001)(5660300002)(76176011)(6436002)(52116002)(53936002)(386003)(6506007)(86362001)(31696002)(53546011)(6486002)(6512007)(186003)(36756003)(4326008)(8676002)(316002)(46003)(486006)(54906003)(81166006)(102836004)(6246003)(476003)(2616005)(446003)(229853002)(14444005)(256004)(66556008)(8936002)(66946007)(2906002)(14454004)(99286004)(478600001)(6116002)(11346002)(81156014)(64756008)(5024004)(31686004)(305945005)(66476007)(7736002)(110136005)(25786009)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2903;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1MXZ2DkJ6zLC9J78rJADsaKUVVO3Yq99Z+Gu49fLl48HZetaoevAjKsQwZSRrxEAIf4AnfYF9kDjaRCxg5/7nFWINLZD+NYvHGk+2NJCZMpEVyA4dXBnvB4aWaijSx1r5gOJ4+h7vDz9r1XFWM6QVef4oVAyjemxTPJU46RDmYzZJh6mChBTMSztAFzEOTgvS55qRQ7wDOQ9XYkxgm6CA3/X531se2acKdLx1oYGB/RMSEBnfZKXRpJB7DCIpuzORt3BBjyPBPNGjohvVw1H7zTpGT0UipJSlc5oJba4YD0wxtf87ObcLff9i4rdwJzjEu6hsPB4YyrHPC+Wevgfg42Y9O7b2Jud33zvyIC4cIX+WNUgtq4w9EDAhsEgLHNCKp7gVD199r0hnKBkIltoMRxfpxxVZOpOOr0c1L1FEz8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <930B79EE099ED14087F1103A92CDA140@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 042a30a3-68a2-445b-c8cd-08d71af78cf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 05:24:42.2320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yhs@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2903
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070057
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDgvNi8xOSA0OjM4IFBNLCBEYW5pZWwgWHUgd3JvdGU6DQo+IEl0J3MgdXNlZnVsIHRv
IGtub3cga3Byb2JlJ3Mgbm1pc3NlZCBhbmQgbmhpdCBzdGF0cy4gRm9yIGV4YW1wbGUgd2l0aA0K
PiB0cmFjaW5nIHRvb2xzLCBpdCdzIGltcG9ydGFudCB0byBrbm93IHdoZW4gZXZlbnRzIG1heSBo
YXZlIGJlZW4gbG9zdC4NCj4gVGhlcmUgaXMgY3VycmVudGx5IG5vIHdheSB0byBnZXQgdGhhdCBp
bmZvcm1hdGlvbiBmcm9tIHRoZSBwZXJmIEFQSS4NCj4gVGhpcyBwYXRjaCBhZGRzIGEgbmV3IGlv
Y3RsIHRoYXQgbGV0cyB1c2VycyBxdWVyeSB0aGlzIGluZm9ybWF0aW9uLg0KDQpQcm9iYWJseSB3
b3J0aHdoaWxlIHRvIGZ1cnRoZXIgZWxhYm9yYXRlIHRoZSB1c2UgY2FzZS4NClRoZSBkZWJ1Z2Zz
IGRvZXMgaGF2ZSBhIHdheSB0byBjb3VudCBrcHJvYmUgbm1pc3NlZCBhbmQgbmhpdA0KdGhyb3Vn
aCAvc3lzL2tlcm5lbC9kZWJ1Zy90cmFjaW5nL2twcm9iZV9wcm9maWxlLg0KQnV0IHRoZXJlIGlz
IG5vIHVhcGkgdG8gY291bnQgdGhlIG5taXNzZWQgYW5kIG5oaXQgZm9yDQpGRC1iYXNlZCBrcHJv
YmUgaW50ZXJmYWNlLiBicGYgcHJvZ3JhbSBpdHNlbGYgbWlnaHQgYmUgYWJsZQ0KdG8gY291bnQg
bmhpdCwgYnV0IHN0aWxsIG5vIHVhcGkgdG8gZ2V0IHRoZSBubWlzc2VkIGNvdW50ZXJzLg0KDQo+
IA0KPiBEYW5pZWwgWHUgKDMpOg0KPiAgICB0cmFjaW5nL2twcm9iZTogQWRkIFBFUkZfRVZFTlRf
SU9DX1FVRVJZX0tQUk9CRSBpb2N0bA0KPiAgICBsaWJicGY6IEFkZCBoZWxwZXIgdG8gZXh0cmFj
dCBwZXJmIGZkIGZyb20gYnBmX2xpbmsNCj4gICAgdHJhY2luZy9rcHJvYmU6IEFkZCBzZWxmIHRl
c3QgZm9yIFBFUkZfRVZFTlRfSU9DX1FVRVJZX0tQUk9CRQ0KPiANCj4gICBpbmNsdWRlL2xpbnV4
L3RyYWNlX2V2ZW50cy5oICAgICAgICAgICAgICAgICAgfCAgNiArKysNCj4gICBpbmNsdWRlL3Vh
cGkvbGludXgvcGVyZl9ldmVudC5oICAgICAgICAgICAgICAgfCAyMyArKysrKysrKysrDQo+ICAg
a2VybmVsL2V2ZW50cy9jb3JlLmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTEgKysrKysN
Cj4gICBrZXJuZWwvdHJhY2UvdHJhY2Vfa3Byb2JlLmMgICAgICAgICAgICAgICAgICAgfCAyNSAr
KysrKysrKysrKw0KPiAgIHRvb2xzL2luY2x1ZGUvdWFwaS9saW51eC9wZXJmX2V2ZW50LmggICAg
ICAgICB8IDIzICsrKysrKysrKysNCj4gICB0b29scy9saWIvYnBmL2xpYmJwZi5jICAgICAgICAg
ICAgICAgICAgICAgICAgfCAxMyArKysrKysNCj4gICB0b29scy9saWIvYnBmL2xpYmJwZi5oICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgMSArDQo+ICAgdG9vbHMvbGliL2JwZi9saWJicGYubWFw
ICAgICAgICAgICAgICAgICAgICAgIHwgIDUgKysrDQo+ICAgLi4uL3NlbGZ0ZXN0cy9icGYvcHJv
Z190ZXN0cy9hdHRhY2hfcHJvYmUuYyAgIHwgNDMgKysrKysrKysrKysrKysrKysrKw0KPiAgIDkg
ZmlsZXMgY2hhbmdlZCwgMTUwIGluc2VydGlvbnMoKykNCj4gDQo=
