Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B3D5A3B1D
	for <lists+bpf@lfdr.de>; Sun, 28 Aug 2022 04:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiH1Cyy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 22:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiH1Cyx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 22:54:53 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA54FD2F
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 19:54:51 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27S2Dbgn011520
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 19:54:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=KbYaRCHnm1bzRxS2TgbOqriUPFKT5PjElkgGFGqfLfE=;
 b=RJ6a/41YtXCj/jva+afmFHZhWQY7pMD7XDgcy7lY93b/DE3KUu/imBKbT1b51oHoy7R0
 ninsbyCYO4f4hHq40inxqM/I5TGR88UtibG9+ZTWdmcPQ/Lxw1IGpUlc2Xv2zq+DQCb7
 /wL7Jv0ZXNg5PFEmSxfasvgUVsIabQA8ACA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j7ekmuavw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 19:54:51 -0700
Received: from twshared25017.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 27 Aug 2022 19:54:49 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 6FFB0EA747A8; Sat, 27 Aug 2022 19:54:38 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 0/7] bpf: Support struct argument for trampoline base progs
Date:   Sat, 27 Aug 2022 19:54:38 -0700
Message-ID: <20220828025438.142798-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: PRBkPf9gXOl48pKT7rY9Do3GkGFAfj1L
X-Proofpoint-GUID: PRBkPf9gXOl48pKT7rY9Do3GkGFAfj1L
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-27_10,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
        union {=20
                void            *kernel;
                void __user     *user;
        };
        bool            is_kernel : 1;
  } sockptr_t;
  int tcp_setsockopt(struct sock *sk, int level, int optname,
                     sockptr_t optval, unsigned int optlen);

This patch added struct value support for bpf tracing programs which
uses trampoline. Only <=3D 16 byte struct size is supported for now
which covers use cases in the above. For x86/arm64/bpf, <=3D 16
struct value will be passed in registers instead of by reference.
Only x86_64 is supported in this patch. arm64 support can be
added later.

 [1] https://github.com/iovisor/bcc/issues/3657

Changelog:
  v2 -> v3:
   - previously struct arguments (<=3D 16 bytes) are passed
     by reference for bpf programs. Suggested by Alexei,
     it is passed by value now.
   - in order to support passing <=3D 16 struct value, a
     new macro BPF_PROG2 is invented.
  rfc v1 -> v2:
   - changed bpf_func_model struct info fields to
     arg_flags[] to make it easy to iterate arguments
     in arch specific {save|restore}_regs() functions.
   - added fexit tests to test return values with
     struct arguments.

Yonghong Song (7):
  bpf: Allow struct argument in trampoline based programs
  bpf: x86: Support in-register struct arguments in trampoline programs
  bpf: Update descriptions for helpers bpf_get_func_arg[_cnt]()
  bpf: arm64: No support of struct argument in trampoline programs
  libbpf: Add new BPF_PROG2 macro
  selftests/bpf: Add struct argument tests with fentry/fexit programs.
  selftests/bpf: Use BPF_PROG2 for some fentry programs without struct
    arguments

 arch/arm64/net/bpf_jit_comp.c                 |   8 +-
 arch/x86/net/bpf_jit_comp.c                   |  68 ++++++++---
 include/linux/bpf.h                           |   4 +
 include/uapi/linux/bpf.h                      |   9 +-
 kernel/bpf/btf.c                              |  42 ++++++-
 tools/include/uapi/linux/bpf.h                |   9 +-
 tools/lib/bpf/bpf_tracing.h                   |  82 +++++++++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  48 ++++++++
 .../selftests/bpf/prog_tests/tracing_struct.c |  63 ++++++++++
 tools/testing/selftests/bpf/progs/timer.c     |   4 +-
 .../selftests/bpf/progs/tracing_struct.c      | 114 ++++++++++++++++++
 11 files changed, 417 insertions(+), 34 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_struct.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct.c

--=20
2.30.2

