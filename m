Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A36B2A8F09
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 06:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgKFFxf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 6 Nov 2020 00:53:35 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62330 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725440AbgKFFxf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 6 Nov 2020 00:53:35 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A65e8Bj029867
        for <bpf@vger.kernel.org>; Thu, 5 Nov 2020 21:53:34 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34mx9p8h59-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 21:53:34 -0800
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 21:53:31 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id DA7EE2EC8EF9; Thu,  5 Nov 2020 21:51:29 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <jeyu@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH bpf-next 0/5] Integrate kernel module BTF support
Date:   Thu, 5 Nov 2020 21:51:05 -0800
Message-ID: <20201106055111.3972047-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_01:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011060039
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set adds BTF generation for kernel modules using a compact split
BTF approach. Respective patches have all the details.

Kernel module BTFs rely on pahole's split BTF support, which is added in [0]
and will be available starting from v1.19. Support for it is detected
automatically during kernel build time.

This patch set implements in-kernel support for split BTF loading and
validation. It also extends GET_OBJ_INFO API for BTFs to return BTF's module
name and a flag whether BTF itself is in-kernel or user-provided. vmlinux BTF
is also exposed to user-space through the same BTF object iteration APIs.

Follow up patch set will utilize the fact that vmlinux and module BTFs now
have associated ID to provide ability to attach BPF fentry/fexit/etc programs
to functions defined in kernel modules.

bpftool is also extended to show module/vmlinux BTF's name.

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=378699&state=*

rfc->v1:
  - CONFIG_DEBUG_INFO_BTF_MODULES is derived automatically (Alexei);
  - vmlinux BTF now has explicit "vmlinux" name (Alexei);
  - added sysfs ABI documentation for /sys/kernel/btf/<module> (Greg).

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Andrii Nakryiko (5):
  bpf: add in-kernel split BTF support
  bpf: assign ID to vmlinux BTF and return extra info for BTF in
    GET_OBJ_INFO
  kbuild: build kernel module BTFs if BTF is enabled and pahole supports
    it
  bpf: load and verify kernel module BTFs
  tools/bpftool: add support for in-kernel and named BTF in `btf show`

 Documentation/ABI/testing/sysfs-kernel-btf |   8 +
 include/linux/bpf.h                        |   2 +
 include/linux/module.h                     |   4 +
 include/uapi/linux/bpf.h                   |   3 +
 kernel/bpf/btf.c                           | 412 ++++++++++++++++++---
 kernel/bpf/sysfs_btf.c                     |   2 +-
 kernel/module.c                            |  32 ++
 lib/Kconfig.debug                          |   9 +
 scripts/Makefile.modfinal                  |  20 +-
 tools/bpf/bpftool/btf.c                    |  28 +-
 tools/include/uapi/linux/bpf.h             |   3 +
 11 files changed, 466 insertions(+), 57 deletions(-)

-- 
2.24.1

