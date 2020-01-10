Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56D7A13649B
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2020 02:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbgAJBQF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jan 2020 20:16:05 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38340 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730444AbgAJBQF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Jan 2020 20:16:05 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00A1F9UW010544
        for <bpf@vger.kernel.org>; Thu, 9 Jan 2020 17:16:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=e+gDvuT2hgZtRMKqqGUusvX0U37u60BzxgV6ceSNYZc=;
 b=Y/KzxKxkaYsXg4T4NPmPfwJiA4X/dZ2VKKNbUeByGNQ3R4bamnyASIttJ6/iNZ/jO5av
 0Nqgf20cUb8lWUDwv/d1Qq+6YW4DC95IT99Qa4oKR50Yqg5zSnK3v3TKiO+VoAuDN6PK
 Ky/b1nZhVuKkqerujm/flA2A4GAMV8YLszU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xe7u4jpug-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2020 17:16:04 -0800
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 9 Jan 2020 17:16:03 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id EBE8D37046CE; Thu,  9 Jan 2020 17:15:57 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/2] bpf: add bpf_send_signal_thread() helper
Date:   Thu, 9 Jan 2020 17:15:57 -0800
Message-ID: <20200110011557.1949757-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_06:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 mlxlogscore=742 malwarescore=0 suspectscore=13 clxscore=1015
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001100010
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 8b401f9ed244 ("bpf: implement bpf_send_signal() helper")
added helper bpf_send_signal() which permits bpf program to
send a signal to the current process.

This patch implemented a new helper bpf_send_signal_thread()
to send a signal to the current thread. This helper can simplify
user space code if the thread context of bpf sending signal
is needed in user space. Please see Patch #1 for details of
use case and kernel implementation.

Patch #2 added some bpf self tests for the new helper.

Yonghong Song (2):
  bpf: add bpf_send_signal_thread() helper
  tools/bpf: add a selftest for bpf_send_signal_thread()

 include/uapi/linux/bpf.h                      | 18 +++++++++--
 kernel/trace/bpf_trace.c                      | 27 +++++++++++++++--
 tools/include/uapi/linux/bpf.h                | 18 +++++++++--
 .../selftests/bpf/prog_tests/send_signal.c    | 30 ++++++++++++-------
 .../bpf/progs/test_send_signal_kern.c         |  9 ++++--
 5 files changed, 82 insertions(+), 20 deletions(-)

-- 
2.17.1

