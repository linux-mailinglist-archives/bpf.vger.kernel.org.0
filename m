Return-Path: <bpf+bounces-59571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3838AACD0B7
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 02:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40CA87A98E4
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 00:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B269BB665;
	Wed,  4 Jun 2025 00:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="OsN/9HIA"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A4C3FD1
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 00:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748997516; cv=none; b=acX70fgbRpuA4qEU0a4iClOdaLJ8ZHWf5abwI96iX9KEt48sSMd/EL7VmsiXdm5HizMgDWKjnsEMOSCSAxtdquU6HZsI8+bYaMoqe+782eFZu+GKvYjHB1vOgIa28p77Iqk0DDy7SVuOG3LueE6Vd38lg6Qr0oTZzJJ3byHF47k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748997516; c=relaxed/simple;
	bh=OzvBwXuHngBxf2JH5xlnsRI8Xs71JymjNTCwf+429ag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pjCbsi1o1H9Kws+8GYHWp5TDFVfycbRa+E+euLVWeOXrUl97GI97dlEuX7qBDqBxTIzRz12RMwANhNhDqSIYWlfGrUxXo1UUp/5xlM54vUW8LXeL4479JPIj1wZd+WfPzjcEAOT5cj6lKNVwHyF4W3KavSz3awmugX1S/4kZGX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=OsN/9HIA; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 553MunHs023549
	for <bpf@vger.kernel.org>; Tue, 3 Jun 2025 17:38:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	s2048-2021-q4; bh=35urPN2HMODvHqMd0XTYwQ6N3l1gLTunRO3hico90z0=; b=
	OsN/9HIA4VtgYBPBvlQ8pxVE0AncRNjuTXgQZS35FtD9x4CbluwEBphiZxQgD3a3
	Ar2Ec/Luo7H5lN/zae3477zZ1Xi8G7IIDzhbg/9zGim3H/pNTNJIvwSGnmgr6JqE
	QFNQ8i1jOqR6AZlnOZelwF87A5aa6/LDFay4vDH4Fv3+VhcDwXsz/tve6WpqzQGh
	F2B4Lk81E/iU68BExwI8OCF5mMYtLqwkVR7vJsO056g3Xghp7WGbU6LF7Kt4t0fi
	9cpcdv9hJsn7D4PIME5tEwc3l5/C8yw12hL4arjyw45juJl5IatxjEYhMiBczAfR
	zlfqfYWSWPncP0B2cPOG3w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 471x0pxgp8-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 03 Jun 2025 17:38:33 -0700 (PDT)
Received: from twshared71637.05.prn6.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Wed, 4 Jun 2025 00:38:30 +0000
Received: by devvm7589.cco0.facebook.com (Postfix, from userid 669379)
	id 094AC343F71; Tue,  3 Jun 2025 17:38:22 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <andrii@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <eddyz87@gmail.com>, <mykolal@fb.com>, <kernel-team@meta.com>
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: add cmp_map_pointer_with_const test
Date: Tue, 3 Jun 2025 17:37:58 -0700
Message-ID: <20250604003759.1020745-2-isolodrai@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250604003759.1020745-1-isolodrai@meta.com>
References: <20250604003759.1020745-1-isolodrai@meta.com>
Reply-To: <ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=UrljN/wB c=1 sm=1 tr=0 ts=683f9589 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=6IFa9wvqVegA:10 a=VabnemYjAAAA:8 a=ucs8h2RCo5JdfC4RZmEA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDAwMiBTYWx0ZWRfX/ECIa5jgGInz opjJpqq8jTwOxTbAKHe7er/Xh5uJURcw2fa8jUR3VsS6XpGIFIUxFpHqLItqcolQifDsHCprViL VXowx4wDeJT65aPFN4l4YUB1oygu0croYiP8Yig41cEvFOyDbcjeT5haxW8r1+dgxB9DHzW3XX6
 g/d0cPIwYoKvbo2aEqrcTNJQ6V5zEPnFfwKZR3BIJS1hi9EEpeYr7s6fRMmsXeyEMYVZ7auNhcv dZJrgF8pTvKSsMElZ4w31CzvuUnfqxOZ5nhMuPz9QhClMBt7LmZwyJAwvzuDhKpvVinYPKjkFQo FmE3MyeAcqk+Hwl0E/H0er1X1wtVdYj9C8L+NkjNQ4JAuEY0V6w0wpD830JwDVbweXar0bwXvSe
 aVYjoN4qiwzlKUVhxbEceKQfXAapfxUTv2UCK/P/QJtPZtjWfi6qDHOf++AlimexxGzrJ2HA
X-Proofpoint-ORIG-GUID: XZgg7D4dUuobAZmqUgNbzIzwaSX9toMR
X-Proofpoint-GUID: XZgg7D4dUuobAZmqUgNbzIzwaSX9toMR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_03,2025-06-03_02,2025-03-28_01

Add a test for CONST_PTR_TO_MAP comparison with a non-0 constant. A
BPF program with this code must not pass verification in unpriv.

Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
---
 .../selftests/bpf/progs/verifier_unpriv.c       | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/=
testing/selftests/bpf/progs/verifier_unpriv.c
index 28200f068ce5..85b41f927272 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -634,6 +634,23 @@ l0_%=3D:	r0 =3D 0;						\
 	: __clobber_all);
 }
=20
+SEC("socket")
+__description("unpriv: cmp map pointer with const")
+__success __failure_unpriv __msg_unpriv("R1 pointer comparison prohibite=
d")
+__retval(0)
+__naked void cmp_map_pointer_with_const(void)
+{
+	asm volatile ("					\
+	r1 =3D 0;						\
+	r1 =3D %[map_hash_8b] ll;				\
+	if r1 =3D=3D 0xcafefeeddeadbeef goto l0_%=3D;		\
+l0_%=3D:	r0 =3D 0;						\
+	exit;						\
+"	:
+	: __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
 SEC("socket")
 __description("unpriv: write into frame pointer")
 __failure __msg("frame pointer is read only")
--=20
2.47.1


