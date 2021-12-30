Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592DA48204A
	for <lists+bpf@lfdr.de>; Thu, 30 Dec 2021 21:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242113AbhL3Ukc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Dec 2021 15:40:32 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60386 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242088AbhL3Ukb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 30 Dec 2021 15:40:31 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BUJfsJp008078
        for <bpf@vger.kernel.org>; Thu, 30 Dec 2021 12:40:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=EeMVG5faCAbgLV2ACVlqM/esj6mLhmAxQh3K2IStoT4=;
 b=loXEuTSp193O+Vbun4yvkj5q8J+x8N21di6FZlKAXLK60rpTDqtCKfjDxSaTopqvn5Nf
 2UpVJ0Wzip3PujeOmOz4JNTgCIcs3NWD/N7dxBI28LiVFy8HFcTwdA/AVZQ3w3F8P9nj
 qsA1mm6l7ecg+8o5AvZ7G8PJY1I4l/hz1+g= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d9hubsv7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 30 Dec 2021 12:40:31 -0800
Received: from twshared3399.25.prn2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 30 Dec 2021 12:40:30 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id A9C7010BBFC7; Thu, 30 Dec 2021 12:40:26 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <acme@kernel.org>
CC:     <christyc.y.lee@gmail.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, <ast@kernel.org>,
        Christy Lee <christylee@fb.com>
Subject: [PATCH bpf-next 0/3] libbpf 1.0: deprecate non-OPTS variants of bpf_object__open API
Date:   Thu, 30 Dec 2021 12:40:05 -0800
Message-ID: <20211230204008.3136565-1-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xZ9GfQzM6IkQT3Z02fIaf4Y0QQNvf4jH
X-Proofpoint-GUID: xZ9GfQzM6IkQT3Z02fIaf4Y0QQNvf4jH
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-30_08,2021-12-30_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=981 spamscore=0 phishscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112300117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Deprecate bpf_object__open(), bpf_object__open_buffer(), and
bpf_object__open_xattr() in favor of bpf_object__open_file() and
bpf_object__open_mem().

[0] Closes: https://github.com/libbpf/libbpf/issues/287

Christy Lee (3):
  libbpf: deprecate bpf_object__open() API
  libbpf: deprecate bpf_object__open_buffer() API
  libbpf: deprecate bpf_object__open_xattr() API

 Documentation/bpf/prog_lsm.rst                            | 2 +-
 tools/bpf/bpftool/Documentation/bpftool-gen.rst           | 2 +-
 tools/bpf/bpftool/iter.c                                  | 2 +-
 tools/build/feature/test-libbpf.c                         | 2 +-
 tools/lib/bpf/libbpf.c                                    | 2 +-
 tools/lib/bpf/libbpf.h                                    | 7 +++++--
 tools/perf/tests/llvm.c                                   | 2 +-
 tools/perf/util/bpf-loader.c                              | 7 +++++--
 tools/testing/selftests/bpf/prog_tests/btf.c              | 2 +-
 tools/testing/selftests/bpf/prog_tests/select_reuseport.c | 2 +-
 tools/testing/selftests/bpf/test_maps.c                   | 4 ++--
 tools/testing/selftests/bpf/test_sockmap.c                | 2 +-
 12 files changed, 21 insertions(+), 15 deletions(-)

--
2.30.2
