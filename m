Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112C4590B74
	for <lists+bpf@lfdr.de>; Fri, 12 Aug 2022 07:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbiHLFYZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Aug 2022 01:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiHLFYY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Aug 2022 01:24:24 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6523A00E4
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 22:24:23 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BLdn7G029465
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 22:24:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=3jBZ1P7UZZuEt7QT7JQnkK5OeVjwf7sSo5ZT/rN+3Qo=;
 b=WPXAz+Go0H7ZHudVQhiNjpRAc/W0MLx1m369IGDh1pqqdv4OZvOan20kflJypqRb5e/b
 A6Zpx5YDK0wqo5mksZsTcG8Wq1kUrnI32hdnED5ZfqvE4/ueO724NO628t8UqJg1YowI
 yN5MOVESjCVDm0B6/q839qV/xGxMZQs88KY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hw9vr1x7r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 22:24:23 -0700
Received: from twshared6324.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 11 Aug 2022 22:24:21 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 2C50DDF8C3BB; Thu, 11 Aug 2022 22:24:19 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 0/6] bpf: Support struct argument for trampoline base progs
Date:   Thu, 11 Aug 2022 22:24:19 -0700
Message-ID: <20220812052419.520522-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: a4pca7jhbDCu_KxQcTkJ34THZvNnOWO8
X-Proofpoint-GUID: a4pca7jhbDCu_KxQcTkJ34THZvNnOWO8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_04,2022-08-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently struct arguments are not supported for trampoline based progs.
One of major reason is that struct argument may pass by value which may
use more than one registers. This breaks trampoline progs where
each argument is assumed to take one register. bcc community reported the
issue ([1]) where struct argument is not supported for fentry program.
  typedef struct {
        uid_t val;
  } kuid_t;
  typedef struct {
        gid_t val;
  } kgid_t;
  int security_path_chown(struct path *path, kuid_t uid, kgid_t gid);
Inside Meta, we also have a use case to attach to tcp_setsockopt()
  typedef struct {
        union {
                void            *kernel;
                void __user     *user;
        };
        bool            is_kernel : 1;
  } sockptr_t;
  int tcp_setsockopt(struct sock *sk, int level, int optname,
                     sockptr_t optval, unsigned int optlen);

This patch added struct value support for bpf tracing programs which
uses trampoline. For x86_64, struct argument size needs to be 16 or less so
it can fit in one or two registers. struct argument is not supported
for arm64 in this patch set.

 [1] https://github.com/iovisor/bcc/issues/3657

Changelog:
  rfc v1 -> v2:
   - changed bpf_func_model struct info fields to
     arg_flags[] to make it easy to iterate arguments
     in arch specific {save|restore}_regs() functions.
   - added fexit tests to test return values with
     struct arguments.

Yonghong Song (6):
  bpf: Add struct argument info in btf_func_model
  bpf: x86: Rename stack_size to regs_off in {save,restore}_regs()
  bpf: x86: Support in-register struct arguments
  bpf: arm64: No support of struct argument
  bpf: Populate struct argument info in btf_func_model
  selftests/bpf: Add struct argument tests with fentry/fexit programs.

 arch/arm64/net/bpf_jit_comp.c                 |   8 +-
 arch/x86/net/bpf_jit_comp.c                   | 137 ++++++++++++++----
 include/linux/bpf.h                           |   4 +
 kernel/bpf/btf.c                              |  30 +++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  41 ++++++
 .../selftests/bpf/prog_tests/tracing_struct.c |  55 +++++++
 .../selftests/bpf/progs/tracing_struct.c      |  93 ++++++++++++
 7 files changed, 334 insertions(+), 34 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_struct.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct.c

--=20
2.30.2

