Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269402AC680
	for <lists+bpf@lfdr.de>; Mon,  9 Nov 2020 22:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgKIVCc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 9 Nov 2020 16:02:32 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36744 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727070AbgKIVCc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Nov 2020 16:02:32 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0A9KlJZN015758
        for <bpf@vger.kernel.org>; Mon, 9 Nov 2020 13:02:31 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 34nr4psw09-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2020 13:02:30 -0800
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 9 Nov 2020 13:02:28 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id DB9BE2EC924B; Mon,  9 Nov 2020 13:00:25 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <jeyu@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 bpf-next 0/5] Integrate kernel module BTF support
Date:   Mon, 9 Nov 2020 13:00:19 -0800
Message-ID: <20201109210024.2024572-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-09_13:2020-11-05,2020-11-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011090138
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

v2->v3:
  - get rid of unnecessary gotos (Song);
v2->v1:
  - drop WARNs, add fewer pr_warn()'s instead (Greg);
  - properly initialize sysfs binary attribute structure (Greg);
  - add __maybe_unused to any_section_objs, used conditionally by module BTF;
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
 kernel/bpf/btf.c                           | 402 ++++++++++++++++++---
 kernel/bpf/sysfs_btf.c                     |   2 +-
 kernel/module.c                            |  32 ++
 lib/Kconfig.debug                          |   9 +
 scripts/Makefile.modfinal                  |  20 +-
 tools/bpf/bpftool/btf.c                    |  28 +-
 tools/include/uapi/linux/bpf.h             |   3 +
 11 files changed, 456 insertions(+), 57 deletions(-)

-- 
2.24.1

