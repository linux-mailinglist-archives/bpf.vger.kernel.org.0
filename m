Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67622D6ED3
	for <lists+bpf@lfdr.de>; Fri, 11 Dec 2020 04:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387712AbgLKDnE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 22:43:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42924 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405282AbgLKDmH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Dec 2020 22:42:07 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BB3SWC8017010
        for <bpf@vger.kernel.org>; Thu, 10 Dec 2020 19:41:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=gnWjv4SGnB/Wf2eIvjZM1oBCGkW66TSq3gpXUs0nwpg=;
 b=AgLniz4VjUuXSqwsN6+OT4Cnkd2zxev13msMBqDY3TxQy/4xIJgeTxANlaC4HpJssuGZ
 lNUWp9CPbs9GtnQ3ZDUaE+WaQAKhzluPN9jpCp1A3TE7V1ju/QbeVZGtwmrdFkmk5a3n
 taGRRLKfBgmBgEa2rbEfFOZYmu0SWVLRiJQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35byu089s4-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 10 Dec 2020 19:41:26 -0800
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Dec 2020 19:41:24 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 4C8B637059A5; Thu, 10 Dec 2020 19:41:21 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 0/2] bpf: permits pointers on stack for helper calls
Date:   Thu, 10 Dec 2020 19:41:21 -0800
Message-ID: <20201211034121.3452172-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-11_01:2020-12-09,2020-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=907 mlxscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=13
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012110019
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch permits pointers on stack for helper calls if permission is
granted. Patch #1 described the detailed usecase and Patch #2
added a test.

Changelog:
  v2 -> v3:
    - do not permit spilled reg state NOT_INIT on stack. (Daniel)
  v1 -> v2:
    - fix a verifier test failure due to verifier change.

Yonghong Song (2):
  bpf: permits pointers on stack for helper calls
  selftests/bpf: add a test for ptr_to_map_value on stack for helper
    access

 kernel/bpf/verifier.c                             | 4 +++-
 tools/testing/selftests/bpf/progs/bpf_iter_task.c | 3 ++-
 tools/testing/selftests/bpf/verifier/unpriv.c     | 5 +++--
 3 files changed, 8 insertions(+), 4 deletions(-)

--=20
2.24.1

