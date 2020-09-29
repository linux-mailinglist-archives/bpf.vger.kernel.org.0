Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CDD27BC14
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 06:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbgI2EdV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 00:33:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:64720 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725283AbgI2EdV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Sep 2020 00:33:21 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08T4VTdB021986
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 21:33:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=s9mOQrn9uc3YDAJgiuUekVv7lNozplIXsZSePhQQ5cA=;
 b=P66/gG0liIEcyq/zQeynGz+l/KJrWltLD1Qo+/SnjM5GjT66pL2KcyoVVY4ir2Q323zx
 c5tRVLY7WmkIxa4eL8/XNgR0VnPtawC/KSawgobSyIK/TDqjqHt4d+VnU9mpMr6gRX+h
 zPHffr1WOA0QF9ri9iw1seZm+FNPq9ZwJ9E= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33tn4tgj3y-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 21:33:20 -0700
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 28 Sep 2020 21:33:17 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 0C25C2EC774D; Mon, 28 Sep 2020 21:30:53 -0700 (PDT)
From:   Andrii Nakryiko <andriin@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Tony Ambardar <tony.ambardar@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH bpf-next 0/3] libbpf: support loading/storing any BTF endianness
Date:   Mon, 28 Sep 2020 21:30:43 -0700
Message-ID: <20200929043046.1324350-1-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_01:2020-09-28,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 adultscore=0
 suspectscore=8 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 mlxlogscore=994 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290045
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add support for loading and storing BTF in either little- or big-endian
integer encodings, regardless of host endianness. This allows users of li=
bbpf
to not care about endianness when they don't want to and transparently
open/load BTF of any endianness. libbpf will preserve original endianness=
 and
will convert output raw data as necessary back to original endianness, if
necessary. This allows tools like pahole to be ignorant to such issues du=
ring
cross-compilation.

While working with BTF data in memory, the endianness is always native to=
 the
host. Convetion can happen only during btf__get_raw_data() call, and only=
 in
a raw data copy.

Additionally, it's possible to force output BTF endianness through new
btf__set_endianness() API. This which allows to create flexible tools doi=
ng
arbitrary conversions of BTF endianness, just by relying on libbpf.

Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Tony Ambardar <tony.ambardar@gmail.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Luka Perkov <luka.perkov@sartura.hr>

Andrii Nakryiko (3):
  selftests/bpf: move and extend ASSERT_xxx() testing macros
  libbpf: support BTF loading and raw data output in both endianness
  selftests/bpf: test BTF's handling of endianness

 tools/lib/bpf/btf.c                           | 310 ++++++++++++++----
 tools/lib/bpf/btf.h                           |   7 +
 tools/lib/bpf/libbpf.map                      |   2 +
 .../selftests/bpf/prog_tests/btf_endian.c     | 101 ++++++
 .../selftests/bpf/prog_tests/btf_write.c      |  34 --
 tools/testing/selftests/bpf/test_progs.h      |  63 ++++
 6 files changed, 419 insertions(+), 98 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_endian.c

--=20
2.24.1

