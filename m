Return-Path: <bpf+bounces-10366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BB47A5D63
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 11:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1221C211B8
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 09:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9AF3D3AC;
	Tue, 19 Sep 2023 09:07:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963635399
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 09:07:06 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913B6E6
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 02:07:05 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J8bBos018154;
	Tue, 19 Sep 2023 09:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=2dsrb2hQ6H172fmkD+1htloR09/QZRDZveP+bCKcYYE=;
 b=n4fXINoKCX8dG50NCTGo4RPA2Xb7Bt4omymWbkoRt10O6EaO+Aek1RCUzw0y05I5CuH9
 ZhTlp6dqWqWwWGXAbkGM3WiAmPydLBJ/7tAGA9YnWrLwWAk7pSC/dRhmhEgAh2J/QeS8
 l9euLSYbkqxKmJOMRj0k/1hOVZQg6z8WjkucUmzw8Tz+7ZaUnOw2nkCZVEENwcHPf7UY
 6ZajIcSPdmG/e1qeL0jIVru4i/k+3F6J1goYQ+e7HoJpU5z/8qpuGvPQDbHk5zIiNYcK
 LMv1bvPT8FOvpDV2ald5LpFS/aaezTfFXKKfNi9/Kaqp0ijmCLZ2KaLdbyJBa54LeZMQ 8A== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t77n31q68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Sep 2023 09:06:39 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38J8vO9G031177;
	Tue, 19 Sep 2023 09:04:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t5r6kjj9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Sep 2023 09:04:14 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38J94CTZ14746126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Sep 2023 09:04:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49C1120043;
	Tue, 19 Sep 2023 09:04:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D575B20040;
	Tue, 19 Sep 2023 09:04:11 +0000 (GMT)
Received: from [9.171.67.55] (unknown [9.171.67.55])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Sep 2023 09:04:11 +0000 (GMT)
Message-ID: <46773a5423f050e1f763fbf6a24fbd8ec2ae86e7.camel@linux.ibm.com>
Subject: Re: [PATCH bpf 1/2] s390/bpf: Let arch_prepare_bpf_trampoline
 return program size
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, kernel-team@meta.com
Date: Tue, 19 Sep 2023 11:04:11 +0200
In-Reply-To: <20230919060258.3237176-2-song@kernel.org>
References: <20230919060258.3237176-1-song@kernel.org>
	 <20230919060258.3237176-2-song@kernel.org>
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
X-Proofpoint-GUID: EY4LgwSIgwGRmbpdJq8Iky8EEEfK3vp3
X-Proofpoint-ORIG-GUID: EY4LgwSIgwGRmbpdJq8Iky8EEEfK3vp3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_03,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=818 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-09-18 at 23:02 -0700, Song Liu wrote:
> arch_prepare_bpf_trampoline() for s390 currently returns 0 on
> success. This
> is not a problem for regular trampoline. However, struct_ops relies
> on the
> return value to advance "image" pointer:
>=20
> bpf_struct_ops_map_update_elem() {
> =C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0 for_each_member(i, t, member) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D bpf_struct_ops_prepare=
_trampoline();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 image +=3D err;
> =C2=A0=C2=A0=C2=A0 }
> }
>=20
> When arch_prepare_bpf_trampoline returns 0 on success, all members of
> the
> struct_ops will point to the same trampoline (the last one).
>=20
> Fix this by returning the program size in arch_prepare_bpf_trampoline
> (on
> success). This is the same behavior as other architectures.
>=20
> Signed-off-by: Song Liu <song@kernel.org>
> ---
> =C2=A0arch/s390/net/bpf_jit_comp.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)

Thanks!

Fixes: 528eb2cb87bc ("s390/bpf: Implement
arch_prepare_bpf_trampoline()")
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

