Return-Path: <bpf+bounces-61280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7128AE3FB6
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 14:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9F13A9189
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 12:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAF61CAA96;
	Mon, 23 Jun 2025 12:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B9dsXbEZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD9A2451F0
	for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 12:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680760; cv=none; b=XjmgH+c4e6r+BU+THwUg2G71+kTmLqoAUzWvDUoF8thNjb9rprS5tBSsvqGFTz7prHUqTUeboYcjfsAaVrHllWCmRS+l303S/sdKE8Q//kfr0dQA20tCRbccoJq1uE41sZB1fkf1LDHTVZ301/opEN1i0FMNIVMGsmpbIUvwmyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680760; c=relaxed/simple;
	bh=J5xE9/bI1a+Dj6JaxrJqt/gS56GaWfcQ2w5drIb20fQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M4ml+GeXt9brsjQKz0I2pzfsKMB9TUtEgKysOsmIXe0i0oqYh2lOAfKlpS7e67JV5Cvr0j6TW9ASRgMuMQGNIuLR9/k4Omopn9BC9Cysp+7D89g9rztR7DaxHoXUR5hF7+FguCUIB25oewQZkMWK9nNZ5n9QYpvrnQiGzsm6Dlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B9dsXbEZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NBGpbh012293;
	Mon, 23 Jun 2025 12:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=J5xE9/
	bI1a+Dj6JaxrJqt/gS56GaWfcQ2w5drIb20fQ=; b=B9dsXbEZGZLgR3zwobUXc9
	fJ61ZNmVqo9dRB1MGmgP6MfwlfL2M63liF8+bePedQsjUMHqFqFCkoXuXtHI4iVf
	igMltR18Syxp8a89+/QeDCGyUjzltaoUnyZYExfaL00TTk7eDyBMMzR4WUtPhoCt
	fQ7qWMP6x3Sn/EjqxOL9o+MlAwniYNraJJrLXpgsWkzCzE8sgPOtTCB8jwyKjrju
	DZdiBwfTm2q+B5Ujx/+LgCL9MoOi+58HxBOe+WM+kEORkGQz27ODYsFjxhoJgIRv
	DpN5C9SLq4yYlz8fuRK1iwX8L0jve5RXZO+zMPyE+FUWUuzegRlihvVmTUC6pHsQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dme11ju2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 12:12:19 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55NBtkIv026033;
	Mon, 23 Jun 2025 12:12:19 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dme11jtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 12:12:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55NB21uC015025;
	Mon, 23 Jun 2025 12:12:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e72teh4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 12:12:17 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55NCCG8f60096914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 12:12:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47A582004B;
	Mon, 23 Jun 2025 12:12:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D28FF20040;
	Mon, 23 Jun 2025 12:12:14 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Jun 2025 12:12:14 +0000 (GMT)
Message-ID: <46be3ce7314e2f41a34acf5b1c78cf1e4b7022cd.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v6 4/4] selftests/bpf: Add tests for string
 kfuncs
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Viktor Malik <vmalik@redhat.com>,
        Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel
 Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau	 <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu	 <song@kernel.org>,
        Yonghong Song
 <yonghong.song@linux.dev>,
        John Fastabend	 <john.fastabend@gmail.com>,
        KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>,
        Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Date: Mon, 23 Jun 2025 14:12:14 +0200
In-Reply-To: <6c716452-5743-4708-a0cc-34166a742c93@redhat.com>
References: <cover.1750402154.git.vmalik@redhat.com>
	 <17543560f4a1e269aec6596e72fe3fff8ef1dd2e.1750402154.git.vmalik@redhat.com>
	 <fdbb8caa-77f6-4143-ad0b-4f32d9e6d8e6@redhat.com>
	 <CAADnVQKj3iTJyhXiQbcSo=6rJarfY_uMQi9yhytmjX-y24GXkQ@mail.gmail.com>
	 <6c716452-5743-4708-a0cc-34166a742c93@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Tc6WtQQh c=1 sm=1 tr=0 ts=685944a3 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=20KFwNOVAAAA:8 a=f8jJ-nJ9vMlnWP3bw48A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rYfgSOWmBmxi3vt4UTCoo71pL6TOACWP
X-Proofpoint-ORIG-GUID: I6-qZkG_Ti0rZHxPyZaTKW7fLP9pnBj2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA3MSBTYWx0ZWRfX40+/iWQVIzQc GSUCwwt9AjnB/FmvnHepejdG+/EAF7BULrHaXgHaN+ApK/85e+hdUtJNi2XAT/Ubsp/77jB5krP 3OM1yq3kp9gtBsin5x3Z2daQ2PWo0a3zgY42SgL+bf1B5bH9huSHcowm+MK+behJZm/9CCa/FSR
 Sot5bk+zuIZYyYIdUIVgvx+5KOqr2HBN/0yw1jfk8S4li1pa7asQwUDya1QO2E53YCs9T1VKN9r B0J5FOEPDnc+PGHKigTRYrMSo4vtbaP4N81G7ratHNatEL9pLDvF2JqA65+idsBPj0cOjG0+FD8 0kAHRVtLHqozkRf8uGn52nujdPnE0XiBwNcOq1W9yipBonIVI2bsbNJg7703T4o8SCwj/HhtYaj
 GsHPreZR3QXmgfVi+SgnmB3OhMIncSyQmtNzCu9xnehx1eEMJDErv6x1BaAqV7qOkYrLkn6a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=729 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1011 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230071

On Mon, 2025-06-23 at 08:05 +0200, Viktor Malik wrote:
> On 6/20/25 20:06, Alexei Starovoitov wrote:
> > On Fri, Jun 20, 2025 at 5:33=E2=80=AFAM Viktor Malik <vmalik@redhat.com=
>
> > wrote:
> > >=20
> > > > +SEC("syscall") __retval(USER_PTR_ERR) int
> > > > test_strnstr_user_ptr2(void *ctx) { return bpf_strnstr("hello",
> > > > user_ptr, 1); }
> > >=20
> > > For some reason, these tests are failing on s390x. I'll
> > > investigate.
> >=20
> > I suspect this is the reason for failures:
> >=20
> > +char *user_ptr =3D (char *)1;
> > +char *invalid_kern_ptr =3D (char *)-1;
>=20
> Actually, the kernel address works fine, it's the userspace addresses
> causing the problem (user_ptr and NULL). On s390,
> __get_kernel_nofault
> always returns 0 for these addresses instead of going to the
> exception
> table.
>=20
> > Ilya,
> >=20
> > Please suggest user/kern addresses to use for these tests.
>=20
> FWIW, I've also tried a couple other random userspace addresses, for
> all
> of them __get_kernel_nofault returned 0.
>=20
> In string kfuncs, 0 is treated as the end of the string (not an
> error),
> so, unless some s390 expert has a better solution, the best I can
> think
> of here is to disable the userspace addresses tests on s390.
>=20
> Viktor

Unfortunately NULL is a valid kernel pointer on s390; this is very
annoying, but unlikely to change any time soon.

Also, s390 has overlapping kernel and user address spaces. This means
that you cannot deduce by the value of an address whether it's a
kernel or a user address; something like 0x400000 can be both valid
kernel and user address. Normal dereferences access the kernel address
space; in order to access the user address space, one has to use magic
machine instructions.

So I would disable both NULL and invalid user_ptr tests on s390, since
they do not apply. I would still test for an invalid kernel_ptr though;
accessing (char *)-1 should cause an exception on s390.

