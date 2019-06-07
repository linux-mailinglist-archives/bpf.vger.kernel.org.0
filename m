Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDBAA3924D
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2019 18:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbfFGQiV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jun 2019 12:38:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39440 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729953AbfFGQiV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 7 Jun 2019 12:38:21 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x57Gbwnu007454
        for <bpf@vger.kernel.org>; Fri, 7 Jun 2019 09:38:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=P2Bhe+T7ArGtmnyGXtg3w06CcGyGgokWdtEP7eIkw0g=;
 b=e6c3ToQwWbrCnfEfU+sKDxbCSDyRUpzSu5uEzIeGY1gXJJupV0SMEKq7psf1punRvF9f
 MWmAwg+M25k4CpAb8vkSD5FBWUIykqohi0ktQi/2XwMPMeA0Z0uITz5Me+k2tUJdqx+Y
 jfgA4CLUvsbkCt0YKC2sQMT+qupOJpGqJjI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2sy0e8d9dy-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 07 Jun 2019 09:38:18 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 7 Jun 2019 09:38:03 -0700
Received: by devvm3632.prn2.facebook.com (Postfix, from userid 172007)
        id BBAC8CD9C6D4; Fri,  7 Jun 2019 09:38:01 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Hechao Li <hechaol@fb.com>
Smtp-Origin-Hostname: devvm3632.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, <daniel@iogearbox.net>, <ast@kernel.org>,
        <kernel-team@fb.com>, Hechao Li <hechaol@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v4 bpf-next 0/2] bpf: Add a new API libbpf_num_possible_cpus()
Date:   Fri, 7 Jun 2019 09:37:57 -0700
Message-ID: <20190607163759.2211904-1-hechaol@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-07_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=721 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906070111
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Getting number of possible CPUs is commonly used for per-CPU BPF maps
and perf_event_maps. Add a new API libbpf_num_possible_cpus() that
helps user with per-CPU related operations and remove duplicate
implementations in bpftool and selftests.

v4: Fixed error code when reading 0 bytes from possible CPU file

Hechao Li (2):
  bpf: add a new API libbpf_num_possible_cpus()
  bpf: use libbpf_num_possible_cpus in bpftool and selftests

 tools/bpf/bpftool/common.c             | 53 +++---------------------
 tools/lib/bpf/libbpf.c                 | 57 ++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h                 | 16 ++++++++
 tools/lib/bpf/libbpf.map               |  1 +
 tools/testing/selftests/bpf/bpf_util.h | 37 +++--------------
 5 files changed, 84 insertions(+), 80 deletions(-)

-- 
2.17.1

