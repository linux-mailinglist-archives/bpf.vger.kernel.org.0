Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C72AA94ACB
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2019 18:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfHSQss (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Aug 2019 12:48:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28388 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726553AbfHSQsr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 19 Aug 2019 12:48:47 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x7JGi3Uc019003;
        Mon, 19 Aug 2019 09:48:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=eFrHHJ6VuAbpxCIXz/DOEzXYf0Kk6QYUoqPlZfNQSuo=;
 b=aH5Tuf+4wa4IyTnQZIZp+7SsXMpy7VgBuiZfQpDZAylyWQMEOJlv0H9amEKbPPnhP2BK
 WvyNkJ5NliRviO6+hXZyhmoIgOs+rBuROc3ykGtbhQRpk2jNmpGAjP0ASwh96q0TraDj
 zrrlNcSr5tlfQexDQ3jrK8RONbTVnveo9kU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2ufvyj8suw-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 19 Aug 2019 09:48:24 -0700
Received: from ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 19 Aug 2019 09:48:23 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 19 Aug 2019 09:48:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drHejCIOzAYgZb9HEytNL8hOSyfwhgYbZxtow5OJ3fgvXUW0AYAAMJlWW16HsW0IglY1JPoOgPEoyRgZGa09rwT9dFoU83hFn/OqYmaRENTSPSVZtmvqv7lTwnvZNRYkpvi6nfpPqyGvsvuLqx3MRVBv26vQCBkTW/kLVJKrq8/ay2z9lfaDOYSNxMtLk7dG+QybEoho+O+CIjWSPKZeI5FUZ45v8fT0nefwJS3RRMzknPvKnDaJOuUECaxzRlFmYG9ZGuS9IChB3aujVqVsgrEWkcv95YKp33Cgddarjf/JDgbN5uY0xsKWwwlj1CwWPwly6XKGmUBnxvDCMjuPJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFrHHJ6VuAbpxCIXz/DOEzXYf0Kk6QYUoqPlZfNQSuo=;
 b=h9A7QKSHMHEoAa5FV6TDjPjq6OrqWIwFGvftyRahMnWqp3DYb6M3MbSsGNNRYpJbWv0Vthpymawv5c4ZM4bmCaTc0DGwrDYjTApk8ieuuTNZxjtPlJ5SBdSsvHWDSzQ09xJnRRNB9opBarR0ej7VxJlQtbdYUbYwcZgDsPj/5C+U2gaQc57bCyuwKYchPkFw1iYgnqDlzc3v54iLY83DDrl57YWYSW1ZJ5lpaLdHYCEx2PrJzy+y9MCJuQqmLvOgBli+DricNtM85XaEWg6j9ZPnXI/4YLar0HNQPzTEETFpQDj5u0rGTkM+MdSrXOWwc18nEj/bJ4fDIYL1lXt4Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFrHHJ6VuAbpxCIXz/DOEzXYf0Kk6QYUoqPlZfNQSuo=;
 b=R57fF/h34dhhSjMMkqFLnwE8TJzAoH0HMEt4JG/oxfnTaW/U9jgfwnZBwVWDHKPgc64pgPHBUqTQqSTKUZ0liYHnL8s2702+m1VtS1WGyfJ3lRSUPihbtDe96C2iER2kq3Ff81OAzQZhWONwi1FUTqYl5fym8CQWgDDWcrt8PWg=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2936.namprd15.prod.outlook.com (20.178.237.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.23; Mon, 19 Aug 2019 16:48:22 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d95b:271:fa7e:e978]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d95b:271:fa7e:e978%5]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 16:48:22 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Andrey Ignatov <rdna@fb.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH bpf v2] selftests/bpf: fix endianness issues in
 test_sysctl
Thread-Topic: [PATCH bpf v2] selftests/bpf: fix endianness issues in
 test_sysctl
Thread-Index: AQHVVn0okd2PMHpik0uKOq+MKCEMk6cCrtSA
Date:   Mon, 19 Aug 2019 16:48:22 +0000
Message-ID: <1f27f05f-cb0d-fa38-9486-7c9551698a10@fb.com>
References: <20190819105908.64863-1-iii@linux.ibm.com>
In-Reply-To: <20190819105908.64863-1-iii@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0071.namprd21.prod.outlook.com
 (2603:10b6:300:db::33) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:4efb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b378be81-7e66-4edc-bf4d-08d724c50be5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2936;
x-ms-traffictypediagnostic: BYAPR15MB2936:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2936B49AFFE5F29C450D7D19D3A80@BYAPR15MB2936.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:529;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(6246003)(446003)(186003)(7736002)(99286004)(478600001)(4326008)(76176011)(8676002)(53936002)(71190400001)(71200400001)(486006)(6512007)(476003)(110136005)(2616005)(2906002)(256004)(14444005)(11346002)(46003)(6116002)(386003)(6506007)(53546011)(305945005)(102836004)(316002)(6436002)(6486002)(25786009)(54906003)(229853002)(14454004)(66446008)(66556008)(86362001)(66476007)(52116002)(31696002)(66946007)(64756008)(81156014)(31686004)(8936002)(36756003)(5660300002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2936;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eYoZoWWesGzwf0XnKIO1kZirTJpdmyuRH0k6ieNm30tYjHi3zFmQmYltAYGous3t6oQCcWYH64INjGXcgOpbkY+HnsDpo1orL42uW0U5o+jQXDGpwEfyWZq2OsgeYBOk0D8VQOebod/ieI/uii1hFXbLeEdBisPtq7TEZrxgYT0wj5oMNC8R2kFGDCKJpJzPhpNsMksSEkKrrZO1wOoGzUJrFMbPO/Gz05eFVAb6pj8Ujd0ER7Mtdn7OzkvH2lxaUoqPENQabgpM2DxbG9mdCEZ02ZSQLpahy5YUTGpGe51VBcdK10Er3E6ysqCLs+0tB0qACTvoyv6FNSqlj6gFF5vKlUBb4Ib7uY/JUFvjmFI9wPUupBp66YtgzRhcrlLLg+3r60nM+ZLoG7oX5QcwInUMTZOlF7f8Htt1eF5MYO0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DE3F0F7BAA36443BC9CFA37FDF56DEF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b378be81-7e66-4edc-bf4d-08d724c50be5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 16:48:22.6186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: //KRMKMjli7hzUt0BcvIyNJblrjjmgZpx8ttt/IZ8//50mTIbHB/xUPU+iKOE07J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2936
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=462 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190177
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDgvMTkvMTkgMzo1OSBBTSwgSWx5YSBMZW9zaGtldmljaCB3cm90ZToNCj4gQSBsb3Qg
b2YgdGVzdF9zeXNjdGwgc3ViLXRlc3RzIGZhaWwgZHVlIHRvIGhhbmRsaW5nIHN0cmluZ3MgYXMg
YSBidW5jaA0KPiBvZiBpbW1lZGlhdGUgdmFsdWVzIGluIGEgbGl0dGxlLWVuZGlhbi1zcGVjaWZp
YyBtYW5uZXIuDQo+IA0KPiBGaXggYnkgd3JhcHBpbmcgYWxsIGltbWVkaWF0ZXMgaW4gYnBmX250
b2hsIGFuZCB0aGUgbmV3IGJwZl9iZTY0X3RvX2NwdS4NCj4gDQo+IEFsc28sIHNvbWV0aW1lcyB0
ZXN0cyBmYWlsIGJlY2F1c2Ugc3lzY3RsKCkgdW5leHBlY3RlZGx5IHN1Y2NlZWRzIHdpdGgNCj4g
YW4gaW5hcHByb3ByaWF0ZSAiVW5leHBlY3RlZCBmYWlsdXJlIiBtZXNzYWdlIGFuZCBhIHJhbmRv
bSBlcnJuby4gWmVybw0KPiBvdXQgZXJybm8gYmVmb3JlIGNhbGxpbmcgc3lzY3RsKCkgYW5kIHJl
cGxhY2UgdGhlIG1lc3NhZ2Ugd2l0aA0KPiAiVW5leHBlY3RlZCBzdWNjZXNzIi4NCj4gDQo+IEZp
eGVzOiAxZjVmYTlhYjZlMmUgKCJzZWxmdGVzdHMvYnBmOiBUZXN0IEJQRl9DR1JPVVBfU1lTQ1RM
IikNCj4gRml4ZXM6IDlhMTAyN2U1MjUzNSAoInNlbGZ0ZXN0cy9icGY6IFRlc3QgZmlsZV9wb3Mg
ZmllbGQgaW4gYnBmX3N5c2N0bCBjdHgiKQ0KPiBGaXhlczogNjA0MWM2N2YyOGQ4ICgic2VsZnRl
c3RzL2JwZjogVGVzdCBicGZfc3lzY3RsX2dldF9uYW1lIGhlbHBlciIpDQo+IEZpeGVzOiAxMWZm
MzRmNzRlMzIgKCJzZWxmdGVzdHMvYnBmOiBUZXN0IHN5c2N0bF9nZXRfY3VycmVudF92YWx1ZSBo
ZWxwZXIiKQ0KPiBGaXhlczogNzg2MDQ3ZGQwOGRlICgic2VsZnRlc3RzL2JwZjogVGVzdCBicGZf
c3lzY3RsX3tnZXQsc2V0fV9uZXdfdmFsdWUgaGVscGVycyIpDQo+IEZpeGVzOiA4NTQ5ZGRjODMy
ZDYgKCJzZWxmdGVzdHMvYnBmOiBUZXN0IGJwZl9zdHJ0b2wgYW5kIGJwZl9zdHJ0b3VsIGhlbHBl
cnMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBJbHlhIExlb3Noa2V2aWNoIDxpaWlAbGludXguaWJtLmNv
bT4NCg0KQWNrZWQtYnk6IFlvbmdob25nIFNvbmcgPHloc0BmYi5jb20+DQo=
