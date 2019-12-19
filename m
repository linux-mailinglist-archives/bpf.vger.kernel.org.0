Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFA0125BD4
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 08:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfLSHHF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 02:07:05 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45976 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726155AbfLSHHE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Dec 2019 02:07:04 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJ73oZa005915
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 23:07:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=7lCBGfFk/lGSZBXUQEWwWyKDzntXPRhbtu55pUSGEnM=;
 b=WPZirxzrDMUk2bIAk6jGe1kqjSJNcP61OLLt0baYJ04kdcgAvAL/AbpROtEsYJsdCHJD
 rmQq/2YpnDQd1aXv5MXyoH/8lDBKSujvg2R5f451G/rdv0eYjeSlRh+VqyeQQQiR4e9x
 /gnKfXYeTHN1tj/41NsAZSBwvxSseiLjn7s= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wypvwksg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 23:07:03 -0800
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 18 Dec 2019 23:07:02 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 330CA2EC16E6; Wed, 18 Dec 2019 23:07:00 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/3] Implement runqslower BCC tool with BPF CO-RE
Date:   Wed, 18 Dec 2019 23:06:55 -0800
Message-ID: <20191219070659.424273-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_08:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=752 malwarescore=0 suspectscore=8 lowpriorityscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190059
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Based on recent BPF CO-RE, tp_btf, and skeleton changes, re-implement
BCC-based runqslower tool as portable pre-compiled BPF CO-RE-based tool. Make
sure it's built as part of selftests to ensure it doesn't bit rot.

As part of this patch set, also introduce new `format core` to `bpftool btf
dump` sub-command. It generates same compilable C header file with all the
types from BTF, but additionally ensures seamless use of generated header with
BPF CO-RE. Currently `format core` applies preserve_access_index attribute (if
supported by Clang) to all structs and unions, to improve user experience of
writing TRACING programs with direct kernel memory read access.

Andrii Nakryiko (3):
  bpftool: add extra CO-RE mode to btf dump command
  libbpf/tools: add runqslower tool to libbpf
  selftests/bpf: build runqslower from selftests

 .../bpf/bpftool/Documentation/bpftool-btf.rst |   7 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
 tools/bpf/bpftool/btf.c                       |  24 ++-
 tools/lib/bpf/tools/runqslower/.gitignore     |   2 +
 tools/lib/bpf/tools/runqslower/Makefile       |  60 ++++++
 .../lib/bpf/tools/runqslower/runqslower.bpf.c | 101 ++++++++++
 tools/lib/bpf/tools/runqslower/runqslower.c   | 187 ++++++++++++++++++
 tools/lib/bpf/tools/runqslower/runqslower.h   |  13 ++
 tools/testing/selftests/bpf/Makefile          |   7 +-
 9 files changed, 395 insertions(+), 8 deletions(-)
 create mode 100644 tools/lib/bpf/tools/runqslower/.gitignore
 create mode 100644 tools/lib/bpf/tools/runqslower/Makefile
 create mode 100644 tools/lib/bpf/tools/runqslower/runqslower.bpf.c
 create mode 100644 tools/lib/bpf/tools/runqslower/runqslower.c
 create mode 100644 tools/lib/bpf/tools/runqslower/runqslower.h

-- 
2.17.1

