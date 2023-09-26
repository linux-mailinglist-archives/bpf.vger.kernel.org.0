Return-Path: <bpf+bounces-10869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD7E7AECBF
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 14:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 0BA54B2099C
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 12:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6D727727;
	Tue, 26 Sep 2023 12:27:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B72A846A
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 12:27:06 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C2D101
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 05:27:04 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QC6BXW005878;
	Tue, 26 Sep 2023 12:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=gbDD7N+qB4LuHaVpBfYwbz7btRyLsMeJdBRDrtkfMwM=;
 b=T+jGbtISdgYbTBvXhwBz+1eh9JrTYgbKAH5awNrMGfYe2wV78ZOISAZqN+uxkTrEJO3m
 jfHzQAr1zKJVv4jOSYsB6DA37gIJ1PHAD2VYzN8MwEye4Vzhmyh+e4GOAez9NNteZ+/d
 bimcSFd4HQ/zT+IPCFsL78AEvUaWlRFTpFo5/qevfyXkab+gad1ruhw/XmjzqgUuKJ9G
 m2dIXw/dBvo2F8OidaVtL/XiHZSxvDwiiCwucwJhiFx+TlBSkrRgYBtnBRJ0dpBU3wQ8
 4qNNNAzZKrStwMA5ISA9kg2HbUyK/lLbcW6/Dxzu84NEBUtU0hMUB049qhHknnlNpWK4 nQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbxngh25m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Sep 2023 12:26:49 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38QBwRb1011003;
	Tue, 26 Sep 2023 12:26:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabukb6pb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Sep 2023 12:26:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38QCQkMo24052476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Sep 2023 12:26:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D92B20043;
	Tue, 26 Sep 2023 12:26:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4FB720040;
	Tue, 26 Sep 2023 12:26:45 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Sep 2023 12:26:45 +0000 (GMT)
Message-ID: <898b73dfc592c4a49de4777e4776b0b8b7c6bb66.camel@linux.ibm.com>
Subject: Re: [PATCH v2 bpf-next 0/8] Allocate bpf trampoline on bpf_prog_pack
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, kernel-team@meta.com
Date: Tue, 26 Sep 2023 14:26:45 +0200
In-Reply-To: <20230925215324.2962716-1-song@kernel.org>
References: <20230925215324.2962716-1-song@kernel.org>
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
X-Proofpoint-GUID: 9rMBVF1Y2Wp2-Ud2shJOxS_RECjgL9Sj
X-Proofpoint-ORIG-GUID: 9rMBVF1Y2Wp2-Ud2shJOxS_RECjgL9Sj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_08,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0
 mlxlogscore=734 impostorscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-09-25 at 14:53 -0700, Song Liu wrote:
> This set enables allocating bpf trampoline from bpf_prog_pack on x86.
> The
> majority of this work, however, is the refactoring of trampoline
> code.
> This is needed because we need to handle 4 archs and 2 users
> (trampoline
> and struct_ops).
>=20
> 1/8 is a dependency that is already applied to bpf tree.
> 2/8 through 7/8 refactors trampoline code. A few helpers are added.
> 8/8 finally let bpf trampoline on x86 use bpf_prog_pack.
>=20
> Changes in v2:
> 1. Add missing changes in net/bpf/bpf_dummy_struct_ops.c.
> 2. Reduce one dry run in arch_prepare_bpf_trampoline. (Xu Kuohai)
> 3. Other small fixes.
>=20
> Song Liu (8):
> =C2=A0 s390/bpf: Let arch_prepare_bpf_trampoline return program size
> =C2=A0 bpf: Let bpf_prog_pack_free handle any pointer
> =C2=A0 bpf: Adjust argument names of arch_prepare_bpf_trampoline()
> =C2=A0 bpf: Add helpers for trampoline image management
> =C2=A0 bpf, x86: Adjust arch_prepare_bpf_trampoline return value
> =C2=A0 bpf: Add arch_bpf_trampoline_size()
> =C2=A0 bpf: Use arch_bpf_trampoline_size
> =C2=A0 x86, bpf: Use bpf_prog_pack for bpf trampoline
>=20
> =C2=A0arch/arm64/net/bpf_jit_comp.c=C2=A0=C2=A0 |=C2=A0 55 +++++++++-----
> =C2=A0arch/riscv/net/bpf_jit_comp64.c |=C2=A0 24 ++++---
> =C2=A0arch/s390/net/bpf_jit_comp.c=C2=A0=C2=A0=C2=A0 |=C2=A0 43 ++++++---=
--
> =C2=A0arch/x86/net/bpf_jit_comp.c=C2=A0=C2=A0=C2=A0=C2=A0 | 124 +++++++++=
++++++++++++++++-----
> --
> =C2=A0include/linux/bpf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 +++-
> =C2=A0include/linux/filter.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0kernel/bpf/bpf_struct_ops.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 19 +++-=
-
> =C2=A0kernel/bpf/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 21 +++---
> =C2=A0kernel/bpf/dispatcher.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 5 +-
> =C2=A0kernel/bpf/trampoline.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 93 ++++++++++++++++++------
> =C2=A0net/bpf/bpf_dummy_struct_ops.c=C2=A0 |=C2=A0=C2=A0 7 +-
> =C2=A011 files changed, 277 insertions(+), 128 deletions(-)
>=20
> --
> 2.34.1

Regarding the s390x part, arch_prepare_bpf_trampoline() needs to call
__arch_prepare_bpf_trampoline() twice: the first time in order to
compute various offsets, the second time to actually emit the code. So
I would suggest to either keep the loop or use the following fixup:

--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2645,7 +2645,15 @@ int arch_prepare_bpf_trampoline(struct
bpf_tramp_image *im, void *image,
        struct bpf_tramp_jit tjit;
        int ret;
=20
+       /* Compute offsets. */
        memset(&tjit, 0, sizeof(tjit));
+       ret =3D __arch_prepare_bpf_trampoline(im, &tjit, m, flags,
+                                           tlinks, func_addr);
+       if (ret < 0)
+               return ret;
+
+       /* Generate the code. */
+       tjit.common.prg =3D 0;
        tjit.common.prg_buf =3D image;
        ret =3D __arch_prepare_bpf_trampoline(im, &tjit, m, flags,
                                            tlinks, func_addr);

With that:

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>  # on s390x

for the series.

