Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F07F487FFA
	for <lists+bpf@lfdr.de>; Sat,  8 Jan 2022 01:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiAHAmx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 19:42:53 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57854 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232027AbiAHAmx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 7 Jan 2022 19:42:53 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 207M3nJ7010907
        for <bpf@vger.kernel.org>; Fri, 7 Jan 2022 16:42:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=rlKho+LPhv0GQiqilnjROOzkBgmnQv75HqXP78g6sAo=;
 b=IRalkHW1/W9d9vLpeHns9IKMJmccN94oBk0/eZtlX27gulJk2lV0sby++G2SI5rjihgX
 AZdxiFBUonb8+sfxyzBleEHdT6DVd5/XUjMxoYV+SvZj7M9YWiT7Ny2cXLO/w4OpiLhG
 ifPfiDlqjHTc9x39qPyX0QSDoeSX/quUmv0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3de4xg1k89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 07 Jan 2022 16:42:52 -0800
Received: from twshared3399.25.prn2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 16:42:51 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id 7896F1694BC3; Fri,  7 Jan 2022 16:42:39 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <acme@kernel.org>
CC:     <christyc.y.lee@gmail.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-perf-users@vger.kernel.org>,
        Christy Lee <christylee@fb.com>
Subject: [PATCH bpf-next v2 0/5] libbpf 1.0: deprecate bpf_map__def() API
Date:   Fri, 7 Jan 2022 16:42:13 -0800
Message-ID: <20220108004218.355761-1-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 9NKS3bgpRRDfP9xY70gFgCWiSHoHVWlk
X-Proofpoint-ORIG-GUID: 9NKS3bgpRRDfP9xY70gFgCWiSHoHVWlk
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-07_10,2022-01-07_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201080001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_map__def() is rarely used and non-extensible. bpf_map_def fields
can be accessed with appropriate map getters and setters instead.
Deprecate bpf_map__def() API and replace use cases with getters and
setters.

Changelog:
----------
v1 -> v2:
https://lore.kernel.org/all/20220105230057.853163-1-christylee@fb.com/

* Fixed commit messages to match commit titles
* Fixed indentation
* Removed bpf_map__def() usage that was missed in v1

Christy Lee (5):
  samples/bpf: stop using bpf_map__def() API
  bpftool: stop using bpf_map__def() API
  perf: stop using bpf_map__def() API
  selftests/bpf: stop using bpf_map__def() API
  libbpf: deprecate bpf_map__def() API

 samples/bpf/xdp_rxq_info_user.c               | 10 +--
 tools/bpf/bpftool/gen.c                       | 12 ++--
 tools/bpf/bpftool/struct_ops.c                |  4 +-
 tools/lib/bpf/libbpf.h                        |  3 +-
 tools/perf/util/bpf-loader.c                  | 64 ++++++++-----------
 tools/perf/util/bpf_map.c                     | 28 ++++----
 .../selftests/bpf/prog_tests/flow_dissector.c |  2 +-
 .../selftests/bpf/prog_tests/global_data.c    |  2 +-
 .../bpf/prog_tests/global_data_init.c         |  2 +-
 .../selftests/bpf/prog_tests/sockmap_listen.c | 12 ++--
 .../selftests/bpf/prog_tests/tailcalls.c      | 36 +++++------
 11 files changed, 81 insertions(+), 94 deletions(-)

--
2.30.2
