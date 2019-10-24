Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3182AE38F3
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2019 18:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfJXQ4T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Oct 2019 12:56:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7904 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409921AbfJXQ4S (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Oct 2019 12:56:18 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9OGt1Od022070;
        Thu, 24 Oct 2019 09:56:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Y2G9q/ftsWSHCszUZPCqqMKnrAakV26w1Lo1uJpUB9c=;
 b=nv+8y1O03o/RIFfYsOGSFTubH8brzSTjY8Z2wu9Slvi0XaUTiJoIPKXqrmc/NGts/WFv
 uGtQM75+yl+gKTDG5qWIW38VGhmPP5zAW5S0+jDmAb7GZW0oHCJnkS6Fubty4qcMkNW/
 J8fAvdggLGtiviX769r4U+Qsj0cArtDlKBs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vtxhxcp89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 24 Oct 2019 09:56:15 -0700
Received: from ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 24 Oct 2019 09:56:08 -0700
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 24 Oct 2019 09:56:08 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 24 Oct 2019 09:56:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLWiQfY630NGszecSuLPq/Hn/YbKqye5SvuO7iJUeyT1KuJTGHn2Vgjxcz2wr4uDQezT8ipwEWhzxvPjNvyaCtdoqSsFzzvk1u87FbncEEDNpdj4vBTtZEfafXssMQQZ9hKLoXxYfdNhOkJQZbEHLLXu9l26Kw5KPQkZ44yTmVmfzyFksxBt6gb8Mm/2bhI2a6b+CeyeytAly0bWhRC0fxcpjW5q8dAQDclq7ZXldvu0Of3yFRHxYdOZfeyN0RWES7vujkQA+E2GDlCtorg1OycsHP2/rXlclWBhS1nIZumFtJZpNOoeoGAihNCu82uBsIFx48s3BQiGihliC95mjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2G9q/ftsWSHCszUZPCqqMKnrAakV26w1Lo1uJpUB9c=;
 b=hGCMRVY+V5rordQLa9x5QP8KnzqwWD2118peywDnRhMMf/0HpHVTDXUm8lUuVtcLczij75prk2F48Sl3ZipAa6HUK+03W7QSd6M4G3OrWMT4T4KuJrysqp0pMK2lxGXLx96C7z9siKC/iMNC9swcO+HwfvKdbtnBMrRSe9S3phkm/HX2ACCxY9Jo15Hu5ARWhZwhARYe8exmYC48k+xW+Uq44KHlx/BO9+c4A+4/kVOQARAzsf7HRrUyfAhti4gTePdarM+SRJs/SYQsBbngqpDg9f18UnyfUJpUDDZG6KEskrRLRctgXxvGe3Nse7jtcvJL+8o4kTBzBvVsV87WUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2G9q/ftsWSHCszUZPCqqMKnrAakV26w1Lo1uJpUB9c=;
 b=kJPDPDqlu+dRSRLzZe6ijDHUx/3lr/vc1wrDGD5KxWaHepaNqfULDHS2rG5vCikXX1SnwVKcB4ksrwDIVZbQwvkzG92CCUMJs3tQsFKKvHfJFbISoksRMkxNCo/he/RjE7c6Uq+LKLgd2EXgTUHd6vZDuwjSECOA98KZJ0cwHBw=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.60.27) by
 BYAPR15MB3429.namprd15.prod.outlook.com (20.179.58.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Thu, 24 Oct 2019 16:56:07 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::b92c:ebd2:58dc:6b8d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::b92c:ebd2:58dc:6b8d%5]) with mapi id 15.20.2387.021; Thu, 24 Oct 2019
 16:56:07 +0000
From:   Yonghong Song <yhs@fb.com>
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: initiated discussion to support attribute address_space in clang
Thread-Topic: initiated discussion to support attribute address_space in clang
Thread-Index: AQHViovtf36A5WULmUOUs3re8NDO8A==
Date:   Thu, 24 Oct 2019 16:56:06 +0000
Message-ID: <79a43f7f-b463-5f40-7830-f488d178b0a4@fb.com>
References: <87lfutgvsu.fsf@oracle.com>
In-Reply-To: <87lfutgvsu.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:301:39::32) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:112::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff2da382-a660-4b8c-6882-08d758a30fe3
x-ms-traffictypediagnostic: BYAPR15MB3429:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR15MB34293C8C0DC4AC2B05AEEC24D36A0@BYAPR15MB3429.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(346002)(366004)(39860400002)(199004)(189003)(8936002)(2906002)(14454004)(6116002)(4744005)(36756003)(76176011)(52116002)(31686004)(64756008)(66556008)(46003)(66446008)(2616005)(99286004)(386003)(6506007)(66476007)(6436002)(11346002)(446003)(102836004)(486006)(71200400001)(71190400001)(186003)(5660300002)(2501003)(6306002)(6512007)(256004)(305945005)(966005)(31696002)(7736002)(476003)(66946007)(8676002)(81156014)(86362001)(316002)(81166006)(561944003)(25786009)(478600001)(6486002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3429;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MrzeYq+qEC8lx1JKMPBBRx9XTlzcOzNFHlk6tzjZInEM4oIPGOGkEf/Q/KAqvAOKhB95Ud2WVaUzaCao6bqYm5sFs1OoEpIMK16AVaHa/9z1LcgcXgyM0pbHtwWhfWxTCJeuVFXpcxdy9w3bNKPkT7BKqm3gVm8wJERXm69CQzZn4Zqj4xxXlWM63CaSD/xkf2yP7DvPZJQiMHMuvfsoW8V2BxB8jxv9uuLhOVAIGbnop+gi+7bcm5jV9o0WTTmw9HrukWDoecVHfHUwU/XWzGDxgRmuVBB0fIpeWW9XmjkblOnrjji6FUU/7XOwsqcbm85jfb91puh/utEbRz+jnhC5ynP19VEJ/MpMo2jp4yzrwqiKpW/gB9+WF1pjD01FDifNCqDILHbmlz1Ugn239frtTIs6RW4xuS/2GNbpEZAWhoOqwN7sHvMb7/qEXuFlNO+Tzjb9ih6qXfjBdEbdyv6W0WSg7SHxAUYjsZom0+A=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <52D738E6DCEDA645AAF58A75615DB06E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2da382-a660-4b8c-6882-08d758a30fe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 16:56:06.8897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5z74Vbdl0+ZSf3bqMl96vnIZs8hm2xaFuKtLHRwsukJtIf4cRnx9xgXKhzCb9WnA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3429
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-24_10:2019-10-23,2019-10-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=944
 phishscore=0 clxscore=1011 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910240158
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SGksIEpvc2UsDQoNCkkganVzdCBpbml0aWF0ZWQgYSBkaXNjdXNzaW9uIChSRkMgcGF0Y2ggDQpo
dHRwczovL3Jldmlld3MubGx2bS5vcmcvRDY5MzkzKSBmb3IgbGx2bS9jbGFuZyB0byBzdXBwb3J0
IHVzZXIgDQphZGRyZXNzX3NwYWNlIGF0dHJpYnV0ZS4NCg0KSSBhbSBub3QgYWJsZSB0byBhZGQg
eW91ciBuYW1lIGluIHN1YnNjcmliZXIgbGlzdCBhcyB5b3UgcHJvYmFibHkNCm5vdCByZWdpc3Rl
cmVkIHdpdGggbGx2bSBtYWlsaW5nIGxpc3Qgb3IgcGhhYnJpY2F0b3IuDQoNCkp1c3QgbGV0IHlv
dSBrbm93IHNvIHdlIGNhbiBoYXZlIGFuIGV2ZW50dWFsIHByb3Bvc2FsIHdoaWNoDQp3aWxsIGJl
IGFsc28gZ29vZCBmb3IgZ2NjLiBQbGVhc2UgcGFydGljaXBhdGUgaW4gZGlzY3Vzc2lvbi4NCg0K
VGhhbmtzLA0KDQpZb25naG9uZw0K
