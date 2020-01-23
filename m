Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2910814744E
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 00:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgAWXIv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 18:08:51 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46174 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727056AbgAWXIv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jan 2020 18:08:51 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 00NN3GZ9031178;
        Thu, 23 Jan 2020 15:08:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=90X1S3FaHJf9NzNgC5rr5F+hN6QmCbOt6GTRzEVH3sg=;
 b=F6v1eOA6uubAHpqDA/7y8ovVCrzMUFvGrTDwUdA/W7oFpY4qeNCM5J99lXfzjvhjvAtX
 kymJM8+KSkDLg3kEGeW2WFIxLe0AYA+CsDZ2Z4FkneX8HNh4YDLgFN9IQJLz1OLeatwZ
 dBjAO2345B6hdzOwv1+x0GC8JDU9DvcJhQ8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 2xqem01w5r-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Jan 2020 15:08:26 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 23 Jan 2020 15:08:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hul1S3C09zOAlCvv98lam7h4NGAtlunhpH0HgqQ12ZGV1MlqknPv4Wn8w1UAI13L7+WM1fsJ3OdgUAjKCob5LGckqqQ19V3IX34YsQ5T9bSwzA5KgESEWH8ZThZKnoNYRj8x8akQ9O6w0U/vqmnwa/x6HEzHz68HgF67yFgirYYdmcNxKgBqkNiKDMm9PMZ+Ou92UtfRXY63Oh+l++D7b/fTDKL2zPN1Swu7sgkJt01bZSdboUJUhfseJ8XdPGWY3hrUJShjgxgcdox1rOqkH4c0QT8YKxl7U7QZ+PQ/BSC5lS35CSWIhkyZuBntZ1oa8cT0FFkulJFq+WgNAkE6fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90X1S3FaHJf9NzNgC5rr5F+hN6QmCbOt6GTRzEVH3sg=;
 b=ldoYjbfGdGpumIW+ef37LwM+IrZSacPBPAXBfJRszkV1i27dggl0lDedT9c2i1CI/kj+uwsecMCyNJVCWCr5X68vIojbdUQAxCA+Ftt5AD3e/H3EbgBRBSHmQ+L5jNUYwzamnKslmos+GHVHiERd5Q6A9YZNxqDt989JP8rMw2y2c0PO/isHYF8q99LnJANnBKmRCOeHrjbyr/ddyGEX+LwHBh7jttcrEBf1yRDjqveCcw5vbwhFzt0FboijYCzwL5BKqr2sk3VVdxqNRTaa1SW/MZOIY2n9eEQQEPftnSwkayZEZBrt7poavMIkyztkNHG2m8SGrIN4nTWm45WI2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90X1S3FaHJf9NzNgC5rr5F+hN6QmCbOt6GTRzEVH3sg=;
 b=SJFbNxrdbl1mIUufSgkLSbBhiYdmCG7KJ3hbiXcC1bvs4wPNWT6ZSZh9fqFuqlwQWps0vncTx5js4EJAduUcJfgGo2WXT826lU8CzWpLHh/zeKnbgozaUOJKqaqFuvCz3KXlJq90kabmDeGp3KPV7FdpWCe1Ko22DYDVtwZr+is=
Received: from MN2PR15MB3213.namprd15.prod.outlook.com (20.179.21.76) by
 MN2PR15MB3006.namprd15.prod.outlook.com (20.178.252.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Thu, 23 Jan 2020 23:08:00 +0000
Received: from MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::6d1e:f2f7:d36:a42f]) by MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::6d1e:f2f7:d36:a42f%4]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 23:08:00 +0000
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:200::2:d66d) by MWHPR04CA0066.namprd04.prod.outlook.com (2603:10b6:300:6c::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend Transport; Thu, 23 Jan 2020 23:07:57 +0000
From:   Martin Lau <kafai@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     Daniel Xu <dxu@dxuuu.xyz>,
        John Fastabend <john.fastabend@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: Add bpf_perf_prog_read_branches()
 helper
Thread-Topic: [PATCH v2 bpf-next 1/3] bpf: Add bpf_perf_prog_read_branches()
 helper
Thread-Index: AQHV0WHOsrtDC0PlC0ePBDNERArXBKf3vCiAgADzN4CAACVegIAAAcsAgAAEKICAAAZwgA==
Date:   Thu, 23 Jan 2020 23:07:59 +0000
Message-ID: <20200123230755.p6qokh2bixbsljjk@kafai-mbp.dhcp.thefacebook.com>
References: <C03IYDPABSU1.1C6OL4DJ7ID1H@dlxu-fedora-R90QNFJV>
 <9341443f-b29a-e92e-0e12-7990927b4e33@iogearbox.net>
In-Reply-To: <9341443f-b29a-e92e-0e12-7990927b4e33@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0066.namprd04.prod.outlook.com
 (2603:10b6:300:6c::28) To MN2PR15MB3213.namprd15.prod.outlook.com
 (2603:10b6:208:3d::12)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:d66d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 018e449e-481d-48bb-a7d7-08d7a05916f4
x-ms-traffictypediagnostic: MN2PR15MB3006:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR15MB300616332EF88D921AD42DDDD50F0@MN2PR15MB3006.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(396003)(376002)(346002)(189003)(199004)(5660300002)(81166006)(2906002)(6916009)(81156014)(86362001)(8936002)(4326008)(1076003)(8676002)(54906003)(52116002)(9686003)(55016002)(186003)(6506007)(53546011)(316002)(16526019)(7696005)(66476007)(478600001)(66946007)(71200400001)(64756008)(66556008)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR15MB3006;H:MN2PR15MB3213.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z0/zJqS+wUCBXSi6LGCWn+tKj0BoJGvKvqwfhPDOV9mIHlqcAHBVZcka1xNy1YwHL1MbxsVp4Zq2TauGpJxsM7Fn30zSukDbu/x2c1+sqDBi2+G7tPlOrwky2GZ33tup6Wl5QX1Gt9IrfNEpqSm128sLK62uVitEtoYLWvrCd/BmPHA5BI0FFbRxW5wxnM3tYT1g0/JyNY7IApQ7O5PghYLOCtd9UO5aZVOGETdTXU2WXY1GNxUKKTgt6p63rq2iz2iqJCp2igvfcyxcHjJO77gDS9DMJp7+B+mUeChxfysO3PagPtW/xmtsUas0LTboyZ7tT/14YUfT9rr2PteXNQKqKjzB+B/LUcaRH3DiRofSdYJzv6jtfeF30w1sXCXaZe7SmbZI7AbvugwrP3i86W0PtTFrRyrKGoOdckITNNfZNZcfZoMwI21BfpwWHpbv
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F3BAEF5751A35C43A4E622407329F903@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 018e449e-481d-48bb-a7d7-08d7a05916f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 23:07:59.7698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jl2+05kCdqHdwT2F2+4gOEHHm+Xpf0tFByOj7/n4ohDNP53TSGc7vl829qty/5du
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3006
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-23_13:2020-01-23,2020-01-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001230172
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 23, 2020 at 11:44:53PM +0100, Daniel Borkmann wrote:
> On 1/23/20 11:30 PM, Daniel Xu wrote:
> > On Thu Jan 23, 2020 at 11:23 PM, Daniel Borkmann wrote:
> > [...]
> > >=20
> > > Yes, so we've been following this practice for all the BPF helpers no
> > > matter
> > > which program type. Though for tracing it may be up to debate whether=
 it
> > > makes
> > > still sense given there's nothing to be leaked here since you can rea=
d
> > > this data
> > > anyway via probe read if you'd wanted to. So we might as well get rid=
 of
> > > the
> > > clearing for all tracing helpers.
> >=20
> > Right, that makes sense. Do you want me to leave it in for this patchse=
t
> > and then remove all of them in a followup patchset?
>=20
> Lets leave it in and in a different set, we can clean this up for all tra=
cing
> related helpers at once.
>=20
> > > Different question related to your set. It looks like br_stack is onl=
y
> > > available
> > > on x86, is that correct? For other archs this will always bail out on
> > > !br_stack
> > > test. Perhaps we should document this fact so users are not surprised
> > > why their
> > > prog using this helper is not working on !x86. Wdyt?
> >=20
> > I think perf_event_open() should fail on !x86 if a user tries to config=
ure
> > it with branch stack collection. So there would not be the opportunity =
for
> > the bpf prog to be attached and run. I haven't tested this, though. I'l=
l
> > look through the code / install a VM and test it.
>=20
> As far as I can see the prog would still be attachable and runnable, just=
 that
> the helper always will return -EINVAL on these archs. Maybe error code sh=
ould be
> changed into -ENOENT to avoid confusion wrt whether user provided some in=
valid
+1 on -ENOENT.

> input args. Should this actually bail out with -EINVAL if size is not a m=
ultiple
> of sizeof(struct perf_branch_entry) as otherwise we'd end up copying half=
 broken
> branch entry information?
