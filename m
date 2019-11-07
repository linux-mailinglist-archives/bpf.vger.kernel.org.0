Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16414F3BFB
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2019 00:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfKGXKY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Nov 2019 18:10:24 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27548 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725924AbfKGXKY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 Nov 2019 18:10:24 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xA7N79HI009199;
        Thu, 7 Nov 2019 15:10:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=t3n0+2nz9NVj4xkf+1ODujFHLXlti/+dstQsvqmYvmY=;
 b=LMLVwdbNWwMcM2dx+kGf3ls86+UuKVC+TgWF3koMSfXrXedGakkqPqcwkjVOFlFIi1b1
 Cd/+ehakQ091F23Rn3wNY1Il0RcXC9MUqUXMSwOeOdhcq564zRPcF4KJvl9xz2aT+re+
 B/xCmzAN3AgWJuboDUTwEeOAXxrw2e3b/6w= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2w4tyjgkkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 07 Nov 2019 15:10:12 -0800
Received: from ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 7 Nov 2019 15:10:11 -0800
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 7 Nov 2019 15:10:11 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 7 Nov 2019 15:10:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N43z5/qOGjTAASbkSEo3kwyFAqPWRqf2Xt8QYuXfoz+mSnANvwjuJ0EhAhUGXi9rvLPp2OnmPFOC/kUVj9Lf2xFqIz6ck+IViLhTn8tPZRDMFsjqBe2BtykzDOVg96+MP36oksF8Zvpx6YJEikOZGoP+W83Hua3a0u5mRYO8HMMg/rHb5ufYya/6T/VWSFxfmZOL+4SrU72oyjuxrQTHDN/aUrJqGujEWkcFg4XLAsyHx0rwE+mbDT1xFXki3U6ATL9DPnDU7T/yqshBXX5hN0YDF2CTyIiEqygLC1RuEHo/QHF/kJyGy6pD4qKVwuFb11tdMZO7k1e+io8+AzWNSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3n0+2nz9NVj4xkf+1ODujFHLXlti/+dstQsvqmYvmY=;
 b=gZtHNvnKqro6gEeY0R9pahcF3nfdLwSmuRfoRap8bWI5yLptmpCJK3ZiiRNu3AgIQ+3OtiMb87t5mZ7Ol3K1WgUskM52Q5kw9osW4/cZHxFqLFONeGc0mG2pQtvp+Loz/7MFP/dSPnRwKrN1HbtX9786jNX13eR/FFzji4+odsC98oZaVqS8N4EQswk/4dz1m44zGhM8hUZdQNzY/UnNYHnUTgFMRgansAS/NOKOGB4AqD6s/0W9T1Qn/mpWGVsjVgW2hl3dqkOJ2lLKGyhq2HUEl0JN8yhBp2Kx7WGtiORi09fAc0AemFlNlv1wfFgTNW4R3+poCBuRGfGnnQlY7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3n0+2nz9NVj4xkf+1ODujFHLXlti/+dstQsvqmYvmY=;
 b=Wx1dSyJ8z9swKhBuiXl3Am4FPyx6LM24KKiQOl1QXn55eM3lpeH442fVJsdL8KISuXQUzMcSgicr7iF4dgcvzR+fY8RaMVjgFJsQUtJ10olmZwDjLqqdJFi4nNXmsiskdFvuMiwcS13ED+hav84oRkRflrlJVXUh3nMfUzjpxpM=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1360.namprd15.prod.outlook.com (10.173.228.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Thu, 7 Nov 2019 23:10:10 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2430.020; Thu, 7 Nov 2019
 23:10:10 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v2] [tools/bpf] workaround a verifier failure for
 test_progs
Thread-Topic: [PATCH bpf-next v2] [tools/bpf] workaround a verifier failure
 for test_progs
Thread-Index: AQHVlYzzY8oy/UGX40SNwIDzKyfPe6eAVeWA
Date:   Thu, 7 Nov 2019 23:10:10 +0000
Message-ID: <BDA6DC5F-1C36-4E62-967E-43FA0DCC6231@fb.com>
References: <20191107170045.2503480-1-yhs@fb.com>
In-Reply-To: <20191107170045.2503480-1-yhs@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:200::1:11cf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d14461b-513e-43f4-ae23-08d763d7a34f
x-ms-traffictypediagnostic: MWHPR15MB1360:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB1360BA2B2B0BD54ADF0A515AB3780@MWHPR15MB1360.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:390;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(39860400002)(136003)(376002)(189003)(199004)(64756008)(76116006)(66556008)(25786009)(4326008)(14454004)(8676002)(256004)(6436002)(46003)(6862004)(7736002)(54906003)(99286004)(2616005)(305945005)(66476007)(66946007)(6116002)(6636002)(446003)(5660300002)(81156014)(66446008)(37006003)(478600001)(102836004)(81166006)(11346002)(6512007)(486006)(476003)(316002)(2906002)(53546011)(229853002)(8936002)(76176011)(86362001)(6246003)(6506007)(186003)(33656002)(50226002)(6486002)(71190400001)(71200400001)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1360;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EJxCQvn+xumkH8ZUIM6kAsp9EBQr/w2nrqyp8RlaDsEX0gmrjUJ4U7OIXIz+A+lRbr6g/41zz5BTg9JvpEsdLe1bNga8kPzbSBdCuZmTnVsR8iJnF75Eu73MU7UTNrF+WqU1k+AInocaTJnzjb2Ns4lbzUvFTKhjd/reN50Ag6cBXRKgQJ3vJPrxPOzkjL1kwyxhY4EJTSg5IiZB2Y0Hkm3tDsqe3U/dwdXAgPCtL76v6pquu2utTbCi/xNzL7ERuZtks8gh8qrtjA4uI2pLq+nQGf7CuudnOBwr4x+r5eBIlT8oFAz+mDt/ZKimBTJoVfyATzOu7BpweXHroDHsaY7AOFRkL9S2Ym3ppweMyx7PCjeOWKxEwXGufN3NqjewHIYR54LBZRdzgA8+hRnIEMEt8Q512U8b++U24NhBzXm1491MCAMfFq13F+UyVbwd
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CDEB4A30D7D7A54B93BCD244906AFC92@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d14461b-513e-43f4-ae23-08d763d7a34f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 23:10:10.2632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2dw30ftKo5TwQVGB0qfQ3PcYtspcvvNIMf9xeIIMI1O49LI2yWaSk/BfZXIB4miFGSeMsVWv64MFUh3Cl0VTHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1360
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-07_07:2019-11-07,2019-11-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 mlxscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=637 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911070212
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Nov 7, 2019, at 9:00 AM, Yonghong Song <yhs@fb.com> wrote:
>=20

[...]

> Let us workaound this issue until we found a compiler and/or
> verifier solution. The workaround in this patch is
> to make variable 'ret' volatile, which will force a reload
> and then '&' operation to ensure better value range.
> With this patch, I got the below byte code for the loop,
>  0000000000000328 LBB0_9:
>     101:       r4 =3D r10
>     102:       r4 +=3D -288
>     103:       r4 +=3D r7
>     104:       w8 &=3D 255
>     105:       r1 =3D r10
>     106:       r1 +=3D -488
>     107:       r1 +=3D r8
>     108:       r2 =3D 7
>     109:       r3 =3D 0
>     110:       call 106
>     111:       *(u32 *)(r10 - 64) =3D r0
>     112:       r1 =3D *(u32 *)(r10 - 64)
>     113:       if w1 s< 1 goto -28 <LBB0_5>
>     114:       r1 =3D *(u32 *)(r10 - 64)
>     115:       if w1 s> 7 goto -30 <LBB0_5>
>     116:       r1 =3D *(u32 *)(r10 - 64)
>     117:       w1 &=3D 7
>     118:       w1 +=3D w8
>     119:       r7 +=3D 8
>     120:       w8 =3D w1
>     121:       if r7 !=3D 224 goto -21 <LBB0_9>
> Insn 117 did the '&' operation and we got more precise
> value range for 'w8' at insn 120.

Thanks for adding this information.=20

> The test is happy then.
>  #3/17 test_sysctl_loop1.o:OK
>=20
> Signed-off-by: Yonghong Song <yhs@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>



