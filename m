Return-Path: <bpf+bounces-44068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6A09BD6E0
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 21:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57A51F2393F
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 20:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D3E205E32;
	Tue,  5 Nov 2024 20:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eCIMOj4s"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3C71E766B
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 20:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837969; cv=none; b=TxYW19Ha3gAUcW0dYPoqOZFYVdHh+Tz7kENDyzHE1sVXpSfwXYwVGdo7JOdfYIs8UYEzCyxQugkRVwtS9b00E7yPzWFoo/CwlUC1hAFEwnFSftmKxYUFvYwf/v6+Kdy0l3pfoylXKmdugC86BepELZFsnrpCwWUPdmnEavlDa4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837969; c=relaxed/simple;
	bh=Oh5AM5PcZqf2mj4gsemxJykbC7rq/45VAaF1cV/Od6M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DFjxTz9aqiPj86zqzK0aJWOua6vV+8GpVKV4bS4y63fd5SuiM2aZ2/21JRgZ5KUddmO0bKCSVxa3ODfVW5Bvy+rGKcqHktskZJEFU6+ySnTUGzcvAbGg7LnIr07Ll0X8NQohu9kOpjpkk7L3uJWchMdaivnn1GP5dimey63Vu/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eCIMOj4s; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5KACTc031182;
	Tue, 5 Nov 2024 20:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=F5OSe8
	t18VofXLsgBudwamYyLpB9/qIVk9xnuXmRZRc=; b=eCIMOj4sJJAgRkq8FPOQ6H
	cojQZUW9JTaPbm0KIOdp3Yfw9b1pjy+c6WO1p5Anpms69T9aZIKFidY2GJN5/YTz
	qvaWIbQnqdl+ZXwHOAZ38nv8+V//c3sp/xXJCO3R2OMg1s8uizWsJ3hCieKRPwR3
	TqaFz0IRs141cOWk2OL5sDR3df1WDfPuYafiXFcMEdc6xLF280BcySTx3JUWgops
	fqyot/CAUGt187qlQ0hqurfUXecDaM/N7heOWMlFoGAN/ycUYUGeWleE1m5Fz7rk
	4C/euJpa/QXcOV0JaklxPuOOdHUz4F0J/rQfKyX2WKvsrf+9DgJPN6EBH2+upiNQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42qt5h81h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 20:18:47 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A5KIlIZ016739;
	Tue, 5 Nov 2024 20:18:47 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42qt5h81h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 20:18:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5JD1KG019080;
	Tue, 5 Nov 2024 20:18:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p0mj4q1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 20:18:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A5KIi7t48365980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Nov 2024 20:18:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7ED5020040;
	Tue,  5 Nov 2024 20:18:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A50720043;
	Tue,  5 Nov 2024 20:18:42 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Nov 2024 20:18:42 +0000 (GMT)
Message-ID: <f623ff5d0855ea22e60ff607420fcdde8be9c9af.camel@linux.ibm.com>
Subject: Re: [PATCH bpf] selftests/bpf: Use -4095 as the bad address for
 bits iterator
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov
 <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Hao Luo
 <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
        Daniel
 Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
        Stanislav
 Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend
 <john.fastabend@gmail.com>,
        Byeonguk Jeong <jungbu2855@gmail.com>,
        Yafang
 Shao <laoar.shao@gmail.com>, houtao1@huawei.com,
        xukuohai@huawei.com
Date: Tue, 05 Nov 2024 21:18:42 +0100
In-Reply-To: <20241105043057.3371482-1-houtao@huaweicloud.com>
References: <20241105043057.3371482-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: t8vbqukmATHQNHXfS75I9GLMzA1F9l2J
X-Proofpoint-ORIG-GUID: hLcPl5I7BlNRLiLnscKTdgU2Lm8UaxIe
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 mlxscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050155

On Tue, 2024-11-05 at 12:30 +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>=20
> As reported by Byeonguk, the bad_words test in verifier_bits_iter.c
> occasionally fails on s390 host. Quoting Ilya's explanation:
>=20
> =C2=A0 s390 kernel runs in a completely separate address space, there is
> no
> =C2=A0 user/kernel split at TASK_SIZE. The same address may be valid in
> both
> =C2=A0 the kernel and the user address spaces, there is no way to tell by
> =C2=A0 looking at it. The config option related to this property is
> =C2=A0 ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE.
>=20
> =C2=A0 Also, unfortunately, 0 is a valid address in the s390 kernel
> address
> =C2=A0 space.
>=20
> Fix the issue by using -4096 as the bad address for bits iterator, as
> suggested by Ilya. Verify that bpf_iter_bits_new() returns -EINVAL
> for
> NULL address and -EFAULT for bad address.

The code uses -4095, which I think is better, since it's the current
value of MAX_ERRNO, therefore, IS_ERR_VALUE() sees it as an error. It's
also not aligned, which may be an additional reason it may not be
dereferenceable on some CPUs.

Other than this discrepancy in the commit message:

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

> Fixes: ebafc1e535db ("selftests/bpf: Add three test cases for
> bits_iter")
> Reported-by: Byeonguk Jeong <jungbu2855@gmail.com>
> Closes: https://lore.kernel.org/bpf/ZycSXwjH4UTvx-Cn@ub22/
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
> =C2=A0.../selftests/bpf/progs/verifier_bits_iter.c=C2=A0 | 32 +++++++++++=
+++++-
> --
> =C2=A01 file changed, 28 insertions(+), 4 deletions(-)
>=20
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
> b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
> index 156cc278e2fc..7c881bca9af5 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
> @@ -57,9 +57,15 @@ __description("null pointer")
> =C2=A0__success __retval(0)
> =C2=A0int null_pointer(void)
> =C2=A0{
> -	int nr =3D 0;
> +	struct bpf_iter_bits iter;
> +	int err, nr =3D 0;
> =C2=A0	int *bit;
> =C2=A0
> +	err =3D bpf_iter_bits_new(&iter, NULL, 1);
> +	bpf_iter_bits_destroy(&iter);
> +	if (err !=3D -EINVAL)
> +		return 1;
> +
> =C2=A0	bpf_for_each(bits, bit, NULL, 1)
> =C2=A0		nr++;
> =C2=A0	return nr;
> @@ -194,15 +200,33 @@ __description("bad words")
> =C2=A0__success __retval(0)
> =C2=A0int bad_words(void)
> =C2=A0{
> -	void *bad_addr =3D (void *)(3UL << 30);
> -	int nr =3D 0;
> +	void *bad_addr =3D (void *)-4095;
> +	struct bpf_iter_bits iter;
> +	volatile int nr;
> =C2=A0	int *bit;
> +	int err;
> +
> +	err =3D bpf_iter_bits_new(&iter, bad_addr, 1);
> +	bpf_iter_bits_destroy(&iter);
> +	if (err !=3D -EFAULT)
> +		return 1;
> =C2=A0
> +	nr =3D 0;
> =C2=A0	bpf_for_each(bits, bit, bad_addr, 1)
> =C2=A0		nr++;
> +	if (nr !=3D 0)
> +		return 2;
> =C2=A0
> +	err =3D bpf_iter_bits_new(&iter, bad_addr, 4);
> +	bpf_iter_bits_destroy(&iter);
> +	if (err !=3D -EFAULT)
> +		return 3;
> +
> +	nr =3D 0;
> =C2=A0	bpf_for_each(bits, bit, bad_addr, 4)
> =C2=A0		nr++;
> +	if (nr !=3D 0)
> +		return 4;
> =C2=A0
> -	return nr;
> +	return 0;
> =C2=A0}


