Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1CA11E85C
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2019 17:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfLMQbL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Dec 2019 11:31:11 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2370 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728057AbfLMQbL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 13 Dec 2019 11:31:11 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBDGPoCQ007860;
        Fri, 13 Dec 2019 08:31:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Yv6VjnLkQPt1liNPma1omNc+SU5rmy//XuipGnejGRo=;
 b=I2i/NqQxlW/YFZml2J+ZnEp3gEVNXmTls672zGn6sb/Ax24SQ1qNYSddDV6zR/Kl4m2+
 FiWolUmPOCJwU8T9j+y7APHANl1YIijVsQI3x8cs2lb6woWRwXNPSYshGIkpkIrT2bn7
 z8sMgbM6kn1O3p3dYYNbw0osAPNI9lw/YUs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wvd4v8a7m-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 13 Dec 2019 08:31:08 -0800
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 13 Dec 2019 08:30:40 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 13 Dec 2019 08:30:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5DlJUu6BoM25qz+VFkvhQFQi9u/52LxiKpJOz2K7e+ckFZj4PfAOoqzn0FOSp5pvtA4nPWBoNo1EqLMh3Uf4eJFoXo+B3iGYFUFiQeB1yB3bT0mysk9TlZoNh4/sz7wuqmssI98pZ88KeNxvgdSSvlHh2wiA1QlrMvfUkLHVt1bZYprDy6+9ePK9KYTrelx8/bF4XCayzLBnB4o5sQCCObLxdxxcvhMtWx9uozsQhmDl4AXqE/W5StbNNn9gGdtSnY95x4Yu2w4T0Cuf3s5Nm33Wc6ggs9Virk6UManRf2KUcl98G/PiQ084+2LvOkED4hZKi462f6N8GgjGE0XQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yv6VjnLkQPt1liNPma1omNc+SU5rmy//XuipGnejGRo=;
 b=e8LMixoBt+bKaagisE7HjkZhhEmL7bv4otJRMEa0WdwHizSRUDy9N/oPiOX1F9v4TYO+gVpni6Vi52IXzcDhnfnbtCjF+Ojnt2TS32KnSTkFKFYemKhWCOAgQ5kxI6ckxz7Vh1WObDtwO/+OVIAZrqERDZRjj8gSmd3Vj9EbStCPKjlxcqpD/P+3QK606ZLZUXn4ln163E9SY50Ot8XlBLejg4OgK8WAPg9yKdFoRKk6PpeOx2t05lhcnVGLNYOvpur8NdgWK6Hrn1UcvR38Ta8//NwF6eu6jP5wsU1sA2ri/g6G6q/hpjPZW+aWmC4gdz6CWNUC2P3ehsmlIf+rrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yv6VjnLkQPt1liNPma1omNc+SU5rmy//XuipGnejGRo=;
 b=Jl66MuNtjUraRI40XyZohmBD3ZPGWzbCQ9eu6Hf/eca2JboX7BgOb1Tv9d5nx++5uLtD4AoDkJkdt6u9GcBnlkjxhxmQnDkqcvkEAheXcL/adXYyCVYrDMbB42lkuIS9zVFAnKlKE2g3Ma1xcwrvNa8nCbcOtppuo4UTEbTsyu0=
Received: from MN2PR15MB3213.namprd15.prod.outlook.com (20.179.21.76) by
 MN2PR15MB2688.namprd15.prod.outlook.com (20.179.146.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Fri, 13 Dec 2019 16:30:39 +0000
Received: from MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::6d1e:f2f7:d36:a42f]) by MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::6d1e:f2f7:d36:a42f%4]) with mapi id 15.20.2538.017; Fri, 13 Dec 2019
 16:30:39 +0000
From:   Martin Lau <kafai@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Jakub Sitnicki <jakub@cloudflare.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next 00/10] Switch reuseport tests for test_progs
 framework
Thread-Topic: [PATCH bpf-next 00/10] Switch reuseport tests for test_progs
 framework
Thread-Index: AQHVsNYkeI4UmWlGhkW+qwn2TbAJNKe3jOUAgAC2uYA=
Date:   Fri, 13 Dec 2019 16:30:38 +0000
Message-ID: <20191213163035.res63motipcpkbqz@kafai-mbp>
References: <20191212102259.418536-1-jakub@cloudflare.com>
 <20191213053635.4k42db43u6jbivi5@ast-mbp>
In-Reply-To: <20191213053635.4k42db43u6jbivi5@ast-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR18CA0046.namprd18.prod.outlook.com
 (2603:10b6:320:31::32) To MN2PR15MB3213.namprd15.prod.outlook.com
 (2603:10b6:208:3d::12)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:e580]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8281836-3021-4ebb-ed6a-08d77fe9c9cf
x-ms-traffictypediagnostic: MN2PR15MB2688:
x-microsoft-antispam-prvs: <MN2PR15MB2688E312078FB1F892E1F7C3D5540@MN2PR15MB2688.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(346002)(39860400002)(366004)(376002)(136003)(189003)(199004)(66476007)(5660300002)(71200400001)(86362001)(81156014)(81166006)(66446008)(4744005)(66946007)(6916009)(64756008)(66556008)(6506007)(8676002)(54906003)(8936002)(316002)(52116002)(478600001)(186003)(4326008)(6512007)(9686003)(6486002)(1076003)(2906002)(33716001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR15MB2688;H:MN2PR15MB3213.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uk13vIbZbj9G/k6hqOYKGQnTziJWmQ4Xn61yRQxhPGN9yTjojk16oS5FnJ+rTbiYb5Lu3VHFrYfq0k2/8d8Dc36XmNvEEU3sr740jQ3/7RvdqT2JlK5Hr9I+0o73kg60rEViyhSZsNfwy2rvF70arhWQ1NmATyd10B3FXYth5hdcqUe9dB5lH8osjaZsv7gVdXsUWavStnTvKcm4tiPq4nTQ2Fd/IYTIKHjXwNO5z+ZrEa5LvwUXGFFBHU5A9NvO2QdTWMdTerHITemrWZmpMCTQUe6fuqczQ4fBPuT9o/E9ZWHZ+hpfWsYVPKh0x8B5vEVujQfI2ZH/mPbELLWPq2fySd3zy+gdnm70xk9bG0JU8+JwsDWeMEWTn3k78UjtKdnkGpMvH9NvZq+QIUVLndkoqkJ7rNXyH2vmm/TZFrwta3xgpZjpgml4Y8gn5yVh
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FF680E67BF047946B99686D626750D6C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f8281836-3021-4ebb-ed6a-08d77fe9c9cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 16:30:38.7948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mnpswqIKdiAhFlsDbcwEcscWc5r+3YJ6YDjJEh8xUAJ1zaUWCb1BmE3QVGdyANby
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2688
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_05:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=824
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912130134
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 12, 2019 at 09:36:36PM -0800, Alexei Starovoitov wrote:
> On Thu, Dec 12, 2019 at 11:22:49AM +0100, Jakub Sitnicki wrote:
> > This change has been suggested by Martin Lau [0] during a review of a
> > related patch set that extends reuseport tests [1].
> >=20
> > Patches 1 & 2 address a warning due to unrecognized section name from
> > libbpf when running reuseport tests. We don't want to carry this warnin=
g
> > into test_progs.
> >=20
> > Patches 3-8 massage the reuseport tests to ease the switch to test_prog=
s
> > framework. The intention here is to show the work. Happy to squash thes=
e,
> > if needed.
> >=20
> > Patches 9-10 do the actual move and conversion to test_progs.
> >=20
> > Output from a test_progs run after changes pasted below.
>=20
> Thank you for doing this conversion.
> Looks great to me.
>=20
> Martin,
> could you please review ?
Looks awesome.  Appreciate for moving this to test_progs!

Acked-by: Martin KaFai Lau <kafai@fb.com>
