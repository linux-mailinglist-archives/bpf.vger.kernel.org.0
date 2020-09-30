Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8118527DF74
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 06:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbgI3E2A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 00:28:00 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19804 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725320AbgI3E2A (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 30 Sep 2020 00:28:00 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 08U4NUJF002065
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 21:27:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=FkLdBchCq8g87LClKzExveefLm8EC4fmBFOdd6xscJs=;
 b=giqHRwxGcjS+HvPIj88znp6e6qst0hisHqrIZkJcuXRFddsG6tPNE4oryROz55//tmWd
 HMtSfouo2+47q9/VUHIE5yCFGD5jzoXbcLaIIt8St69W9/h5b+qBaHj/XPNDwPt4lQf/
 FQTOQ8xLcAX17dWZpOUrH9e3xUJLK3TN2YU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 33tshr5ync-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 21:27:59 -0700
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 21:27:57 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id C4C282EC77F1; Tue, 29 Sep 2020 21:27:51 -0700 (PDT)
From:   Andrii Nakryiko <andriin@fb.com>
To:     <dwarves@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH dwarves 00/11] Switch BTF loading and encoding to libbpf APIs
Date:   Tue, 29 Sep 2020 21:27:31 -0700
Message-ID: <20200930042742.2525310-1-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_01:2020-09-29,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=13
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=589
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300032
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set switches pahole to use libbpf-provided BTF loading and enc=
oding
APIs. This reduces pahole's own BTF encoding code, speeds up the process,
reduces amount of RAM needed for DWARF-to-BTF conversion. Also, pahole fi=
nally
gets support to generating BTF for cross-compiled ELF binaries with diffe=
rent
endianness (patch #11).

Additionally, patch #6 fixes previously missed problem with invalid array
index type generation.

Patches #7-10 are speeding up DWARF-to-BTF convertion/dedup pretty
significantly, saving overall about 9 seconds out of current 27 or so.

Patch #8 revamps how per-CPU BTF variables are emitted, eliminating repea=
ted
and expensive looping over ELF symbols table.

Patch #10 admittedly has some hacky parts to satisfy CTF use case, but it=
s
speed ups are greatest. So I'll understand if it gets dropped, but it wou=
ld be
a pity.

More details could be found in respective patches.

Andrii Nakryiko (11):
  libbpf: update to latest libbpf version
  btf_encoder: detect BTF encoding errors and exit
  dwarves: expose and maintain active debug info loader operations
  btf_loader: use libbpf to load BTF
  btf_encoder: use libbpf APIs to encode BTF type info
  btf_encoder: fix emitting __ARRAY_SIZE_TYPE__ as index range type
  btf_encoder: discard CUs after BTF encoding
  btf_encoder: revamp how per-CPU variables are encoded
  dwarf_loader: increase the size of lookup hash map
  strings: use BTF's string APIs for strings management
  btf_encoder: support cross-compiled ELF binaries with different
    endianness

 btf_encoder.c  | 361 +++++++++++++++------------
 btf_loader.c   | 244 +++++++-----------
 ctf_encoder.c  |   2 +-
 dwarf_loader.c |   2 +-
 dwarves.c      |   8 +
 lib/bpf        |   2 +-
 libbtf.c       | 661 +++++++++++++++++++++----------------------------
 libbtf.h       |  41 ++-
 libctf.c       |  14 +-
 libctf.h       |   4 +-
 pahole.c       |   9 +-
 strings.c      |  91 +++----
 strings.h      |  32 +--
 13 files changed, 653 insertions(+), 818 deletions(-)

--=20
2.24.1

