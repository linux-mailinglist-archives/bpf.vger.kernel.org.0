Return-Path: <bpf+bounces-10364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B877A5D5D
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 11:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7A7B1C21247
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 09:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C603D3A5;
	Tue, 19 Sep 2023 09:05:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4CF3D39D
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 09:05:47 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD21C118
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 02:05:46 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J8jHPB020305;
	Tue, 19 Sep 2023 09:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=KE0GrbJloUg8oc4VX39mqrs93LfZWjIBeBQss/rZmug=;
 b=XeoLUN9f4B5YaS0AA8O3eS2uVbo6J76f+IsSXDUv2e2ctpOD4k1Bfhw6n3lpOdMb/+O2
 LpbpW+ttyVvllBHytfuh8hD6kyhFeP0UiVbYJHRj5cDG0QxRje9LQS83hBJU8fqZH/nN
 w4E0rNU1Lv61Q+xatOFsWE5ziCSaOc2EXaJBGz9yF1TUH35q5bgbPFRCgI7pNDgG9L35
 Uojc6HSMRYOiAobZ5Kh4UIdqiwUjn9DQY+dNp+XI2o8SwF9MpLEY0WhCm0kexhQ3c16x
 G3wfnh7oV0ZfKAGgQIVBzXXJLIcFSuuMho6d9g7/hSHWgG+aY3d9Fjq5oMAUErcF3D8s IA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t77n31yhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Sep 2023 09:05:22 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38J7tlH1005542;
	Tue, 19 Sep 2023 09:05:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t5q2yjxnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Sep 2023 09:05:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38J95DfK43319994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Sep 2023 09:05:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9344220049;
	Tue, 19 Sep 2023 09:05:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 040E220040;
	Tue, 19 Sep 2023 09:05:13 +0000 (GMT)
Received: from [9.171.67.55] (unknown [9.171.67.55])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Sep 2023 09:05:12 +0000 (GMT)
Message-ID: <3bdfe5b975210b3ca6235e139479254856f75ce3.camel@linux.ibm.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Check bpf_cubic_acked() is
 called via struct_ops
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, kernel-team@meta.com,
        Martin KaFai Lau
 <martin.lau@kernel.org>
Date: Tue, 19 Sep 2023 11:05:12 +0200
In-Reply-To: <20230919060258.3237176-3-song@kernel.org>
References: <20230919060258.3237176-1-song@kernel.org>
	 <20230919060258.3237176-3-song@kernel.org>
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
X-Proofpoint-GUID: lp8T8JVPqqohkOQcYb46tPx4z3ay9mLr
X-Proofpoint-ORIG-GUID: lp8T8JVPqqohkOQcYb46tPx4z3ay9mLr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_03,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1011 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=560 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-09-18 at 23:02 -0700, Song Liu wrote:
> Test bpf_tcp_ca (in test_progs) checks multiple tcp_congestion_ops.
> However, there isn't a test that verifies functions in the
> tcp_congestion_ops is actually called. Add a check to verify that
> bpf_cubic_acked is actually called during the test.
>=20
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
> =C2=A0tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 2 ++
> =C2=A0tools/testing/selftests/bpf/progs/bpf_cubic.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 3 +++
> =C2=A02 files changed, 5 insertions(+)

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

