Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1B948E0E9
	for <lists+bpf@lfdr.de>; Fri, 14 Jan 2022 00:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiAMXdG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jan 2022 18:33:06 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29226 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230181AbiAMXdF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Jan 2022 18:33:05 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20DN6Mpw006692
        for <bpf@vger.kernel.org>; Thu, 13 Jan 2022 15:33:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=38wPiwz0SQBaVW/c4knZ9z2HmHAMBBcstg4uMh3b9eU=;
 b=E75ZbAZxZUdSBTgCBr0jyyRLBIw0yFnv0Lb/0RhZpve8Z+RuaMRO5gnA9s+E+RzuDcKH
 hIbazp7oImIIbFsieg2ffgk0c5zK8USyFhUt9QmwqFQFejN8O8PAndNvHVJw89vOuNOg
 foMDniUzHbqTJ2vLFqHC2GzAwO+sVRHTjUk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3djapgp4pu-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 13 Jan 2022 15:33:04 -0800
Received: from twshared29821.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 15:33:04 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id EEDC98F97AA5; Thu, 13 Jan 2022 15:32:56 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>, <yhs@fb.com>
CC:     Kenny Yu <kennyyu@fb.com>
Subject: [PATCH bpf-next 0/3] Add bpf_access_process_vm helper and sleepable bpf iterator programs
Date:   Thu, 13 Jan 2022 15:31:55 -0800
Message-ID: <20220113233158.1582743-1-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: OasTz1oO4x1llAmyRyzsiAVqRzVdgzOv
X-Proofpoint-ORIG-GUID: OasTz1oO4x1llAmyRyzsiAVqRzVdgzOv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_10,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=595 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201130140
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch series makes the following changes:
* Adds a new bpf helper `bpf_access_process_vm` to read user space
  memory from a different task.
* Adds the ability to create sleepable bpf iterator programs.

As an example of how this will be used, at Meta we are using bpf task ite=
rator
programs and this new bpf helper to read C++ async stack traces of a runn=
ing
process for debugging C++ binaries in production.

Kenny Yu (3):
  bpf: Add bpf_access_process_vm() helper
  libbpf: Add "iter.s" section for sleepable bpf iterator programs
  selftests/bpf: Add test for sleepable bpf iterator programs

 include/linux/bpf.h                           |  1 +
 include/uapi/linux/bpf.h                      | 10 +++++
 kernel/bpf/helpers.c                          | 19 ++++++++
 kernel/trace/bpf_trace.c                      |  2 +
 tools/include/uapi/linux/bpf.h                | 10 +++++
 tools/lib/bpf/libbpf.c                        |  1 +
 .../selftests/bpf/prog_tests/bpf_iter.c       | 16 +++++++
 .../selftests/bpf/progs/bpf_iter_task.c       | 43 +++++++++++++++++++
 8 files changed, 102 insertions(+)

--=20
2.30.2

