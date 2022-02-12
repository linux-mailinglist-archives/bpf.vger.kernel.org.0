Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F5A4B3615
	for <lists+bpf@lfdr.de>; Sat, 12 Feb 2022 16:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbiBLPvq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 12 Feb 2022 10:51:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236734AbiBLPvp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Feb 2022 10:51:45 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C61B240A6
        for <bpf@vger.kernel.org>; Sat, 12 Feb 2022 07:51:39 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21CFNGnW007873
        for <bpf@vger.kernel.org>; Sat, 12 Feb 2022 07:51:38 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e6ba10ugm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 12 Feb 2022 07:51:38 -0800
Received: from twshared26726.23.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 12 Feb 2022 07:51:37 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 6518B10C38C0B; Sat, 12 Feb 2022 07:51:26 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <acme@kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, <christylee@fb.com>, <jolsa@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v6 perf/core 0/2] perf: stop using deprecated bpf APIs
Date:   Sat, 12 Feb 2022 07:51:23 -0800
Message-ID: <20220212155125.3406232-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: THioGfCPGY9Ko7_ZQ0J6r38Y2855qBI4
X-Proofpoint-GUID: THioGfCPGY9Ko7_ZQ0J6r38Y2855qBI4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-12_06,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 mlxlogscore=911 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202120097
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf's bpf_prog_load() and bpf__object_next() APIs are deprecated.
remove perf's usage of these deprecated functions. After this patch
set, the only remaining libbpf deprecated APIs in perf would be
bpf_program__set_prep() and bpf_program__nth_fd().

v5 -> v6:
  - rebase onto perf/core tree (Arnaldo);
v4 -> v5:
  - add bpf_perf_object__add() and use it where appropriate (Jiri);
  - use __maybe_unused in first patch;
v3 -> v4:
  - Fixed commit title
  - Added weak definition for deprecated function
v2 -> v3:
  - Fixed commit message to use upstream perf
v1 -> v2:
  - Added missing commit message
  - Added more details to commit message and added steps to reproduce
    original test case.

Christy Lee (2):
  perf: Stop using deprecated bpf_load_program() API
  perf: Stop using deprecated bpf_object__next() API

 tools/perf/tests/bpf.c       | 14 ++----
 tools/perf/util/bpf-event.c  | 13 +++++
 tools/perf/util/bpf-loader.c | 98 +++++++++++++++++++++++++++++-------
 3 files changed, 96 insertions(+), 29 deletions(-)

-- 
2.30.2

