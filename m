Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DA4581822
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 19:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiGZRLj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 13:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiGZRLj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 13:11:39 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9075F13E1D
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 10:11:38 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QFQTuB003605
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 10:11:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=twfi/3CH9xGRGa0dDxeTjZbhJAqKpOKs2plo1snbig0=;
 b=NaQ5EXF+6znFGWtyYVx7nwaqBglDV/FJ2oYwI+YPmSPaQoD4zppUGSyTtcSY89TDw8Lx
 4SepEDryzBO31aT4L9P5MuL5TGmp7MtETmhxoUDIu4717weXSKmhGtSxsNAFohXFWwpi
 tFC7F4z8LdY3UQTpKG7RS+TtugBEXSMfWWE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hj1uspc9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 10:11:38 -0700
Received: from twshared34609.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 10:11:37 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id BBBDCD40E7A1; Tue, 26 Jul 2022 10:11:29 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [RFC PATCH bpf-next 0/7] bpf: Support struct value argument for trampoline base progs
Date:   Tue, 26 Jul 2022 10:11:29 -0700
Message-ID: <20220726171129.708371-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: NY8A5i85687YVAqGjAFtvyGC82Yq-fj5
X-Proofpoint-ORIG-GUID: NY8A5i85687YVAqGjAFtvyGC82Yq-fj5
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_05,2022-07-26_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
uses trampoline. struct argument size needs to be 16 or less so
it can fit in one or two registers. Based on analysis on llvm and
experiments, atruct argument size greater than 16 will be passed
as pointer to the struct.

Please see patch #4 and selftests for specific examples.

I labelled the patch as RFC so I can get some comments before proceeding.
The patch set is not complete as:
  (1). it does not support struct arguments which are passed in as pointers.
  (2). there might be some corner cases where on x86_64 even 16 bytes may
       pass by pointers. This needs further investigation.
  (3). tests are imcomplete, no fexit or fmod tests.

  [1] https://github.com/iovisor/bcc/issues/3657
  [2] https://github.com/llvm/llvm-project/blob/main/clang/lib/CodeGen/Targ=
etInfo.cpp

Yonghong Song (7):
  bpf: Always return corresponding btf_type in __get_type_size()
  bpf: Add struct argument info in btf_func_model
  bpf: x86: Rename stack_size to regs_off in {save,restore}_regs()
  bpf: x86: Support in-register struct arguments
  bpf: arm64: No support of struct value argument
  bpf: Populate struct value info in btf_func_model
  selftests/bpf: Add struct value tests with fentry programs.

 arch/arm64/net/bpf_jit_comp.c                 |   4 +
 arch/x86/net/bpf_jit_comp.c                   | 173 ++++++++++++++++--
 include/linux/bpf.h                           |   9 +
 kernel/bpf/btf.c                              |  54 +++++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  37 ++++
 .../selftests/bpf/prog_tests/tracing_struct.c |  51 ++++++
 .../selftests/bpf/progs/tracing_struct.c      |  64 +++++++
 7 files changed, 365 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_struct.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct.c

--=20
2.30.2

