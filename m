Return-Path: <bpf+bounces-18852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5548B8228B7
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 08:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CF1285188
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 07:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D1B179B7;
	Wed,  3 Jan 2024 07:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bSED9DB4"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9451E17998
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 07:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4036M3tt021300;
	Wed, 3 Jan 2024 07:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=2BLAhuI1WXj8n0dgQxyalBNCvcKDzcvTsfbR/YtJ8sY=;
 b=bSED9DB4xFEQXN2sgYrBzmY9GiQV0j06qOKHWvoB2ei+tXdM6mG2VyQOooQmIfBaLHC7
 8tm34UmadUrZd5z3zMNfztZrnQE8dMzvExoWXcJY1Zz6uhiE/RPZCprTQzdfUGNTjtX5
 JzYYRJmRwj77E2juApaEACRloh+socDrz/AaxkZmhWfSpHUqfH2LLZmVBVJ55JYtPP6W
 pNyggMbLzFUi8B14orjm9X/gzw+8wIyEMQ8q6poIpmUNZt/Ny3UWewiJAD+qzEhYe0q5
 4C2lZ+uQIm6hkbx3kz2yQSJ7O7Tax81cOu3oQ0Kq0SLeYvhSNLyoiAVbiTK+2bo6B5yG 9g== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vd28e1jhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 07:05:19 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4035PTKD024498;
	Wed, 3 Jan 2024 07:05:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vb08291gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 07:05:18 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40375GpA23396876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jan 2024 07:05:16 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F0802004B;
	Wed,  3 Jan 2024 07:05:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83BE020040;
	Wed,  3 Jan 2024 07:05:15 +0000 (GMT)
Received: from [9.171.70.156] (unknown [9.171.70.156])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jan 2024 07:05:15 +0000 (GMT)
Message-ID: <958781f9b02cb1d5ef82a0d78d65ecdbb3f26893.camel@linux.ibm.com>
Subject: Re: [PATCH bpf 2/3] selftests/bpf: Double the size of test_loader
 log
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov
 <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko
 <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik
	 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Date: Wed, 03 Jan 2024 08:05:15 +0100
In-Reply-To: <6f05eb0d-4807-4eef-99ba-2bfa9bd334af@linux.dev>
References: <20240102193531.3169422-1-iii@linux.ibm.com>
	 <20240102193531.3169422-3-iii@linux.ibm.com>
	 <6f05eb0d-4807-4eef-99ba-2bfa9bd334af@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 78VlsA_YR2NOjcE8RLSWAEGyur6yA3o0
X-Proofpoint-GUID: 78VlsA_YR2NOjcE8RLSWAEGyur6yA3o0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_02,2024-01-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011
 suspectscore=0 mlxscore=0 impostorscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401030057

On Tue, 2024-01-02 at 16:41 -0800, Yonghong Song wrote:
>=20
> On 1/2/24 11:30 AM, Ilya Leoshkevich wrote:
> > Testing long jumps requires having >32k instructions. That many
> > instructions require the verifier log buffer of 2 megabytes.
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0 tools/testing/selftests/bpf/test_loader.c | 2 +-
> > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/tools/testing/selftests/bpf/test_loader.c
> > b/tools/testing/selftests/bpf/test_loader.c
> > index 37ffa57f28a1..b0bfcc8d4638 100644
> > --- a/tools/testing/selftests/bpf/test_loader.c
> > +++ b/tools/testing/selftests/bpf/test_loader.c
> > @@ -12,7 +12,7 @@
> > =C2=A0 #define str_has_pfx(str, pfx) \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(strncmp(str, pfx, __bu=
iltin_constant_p(pfx) ? sizeof(pfx)
> > - 1 : strlen(pfx)) =3D=3D 0)
> > =C2=A0=20
> > -#define TEST_LOADER_LOG_BUF_SZ 1048576
> > +#define TEST_LOADER_LOG_BUF_SZ 2097152
>=20
> I think this patch is not necessary.
> If the log buffer size is not enough, the kernel
> verifier will wrap around and overwrite some initial states,
> but all later states are still preserved. In my opinion,
> there is really no need to increase the buffer size in this case,
> esp. it is a verification success case.

What I observed in this case was that bpf_check() still returned=C2=A0
-ENOSPC and failed the prog load. IIUC you are referring to the
functionality introduced by the following commit:

commit 1216640938035e63bdbd32438e91c9bcc1fd8ee1
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Thu Apr 6 16:41:49 2023 -0700

    bpf: Switch BPF verifier log to be a rotating log by default

The commit message says, among other things:

    The only user-visible change is which portion of verifier log user
    ends up seeing *if buffer is too small*.

So if we don't increase the log size, we would still have to deal with
-ENOSPC. An alternative would be to reallocate the log buffer and try
again. But I thought that for the test code we better keep it as simple
as possible.
=20
> > =C2=A0 #define TEST_TAG_EXPECT_FAILURE "comment:test_expect_failure"
> > =C2=A0 #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"


