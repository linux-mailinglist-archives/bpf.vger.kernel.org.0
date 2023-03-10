Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19526B339F
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 02:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCJBYU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 20:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjCJBYT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 20:24:19 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33343EBD9A
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 17:24:18 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32A049o6014149
        for <bpf@vger.kernel.org>; Thu, 9 Mar 2023 17:24:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=/znqWZyY5t+FzMG0CxGrxM7C1Z4z5m8YyhaOAuLqjl0=;
 b=egmPr9G9oIpObQ5dtMEeOkJggfxmuPRDZyhDYtd0m2ARzvCFJI5KJwSXOflsjoWyrEIP
 6mgzaAfOmi0KzSmWzd+Lu9QqqK/oGwoqY8hUo4WaSFzgfZcdKEOUoWDwrGo3HytADh24
 bZ0UiZk+Mm4Gyrs3UjQkpKx2Ntz4KiWNC+4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p7sp58e21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 09 Mar 2023 17:24:17 -0800
Received: from twshared19568.39.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 9 Mar 2023 17:24:16 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 031EA19D1896D; Thu,  9 Mar 2023 17:24:10 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Workaround verification failure for fexit_bpf2bpf/func_replace_return_code
Date:   Thu, 9 Mar 2023 17:24:10 -0800
Message-ID: <20230310012410.2920570-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Y5MdoAXNJUxQxV3qVIJXNKOffMa0o0D_
X-Proofpoint-GUID: Y5MdoAXNJUxQxV3qVIJXNKOffMa0o0D_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_14,2023-03-09_01,2023-02-09_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With latest llvm17, selftest fexit_bpf2bpf/func_replace_return_code
has the following verification failure:

  0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
  ; int connect_v4_prog(struct bpf_sock_addr *ctx)
  0: (bf) r7 =3D r1                       ; R1=3Dctx(off=3D0,imm=3D0) R7_=
w=3Dctx(off=3D0,imm=3D0)
  1: (b4) w6 =3D 0                        ; R6_w=3D0
  ; memset(&tuple.ipv4.saddr, 0, sizeof(tuple.ipv4.saddr));
  ...
  ; return do_bind(ctx) ? 1 : 0;
  179: (bf) r1 =3D r7                     ; R1=3Dctx(off=3D0,imm=3D0) R7=3D=
ctx(off=3D0,imm=3D0)
  180: (85) call pc+147
  Func#3 is global and valid. Skipping.
  181: R0_w=3Dscalar()
  181: (bc) w6 =3D w0                     ; R0_w=3Dscalar() R6_w=3Dscalar=
(umax=3D4294967295,var_off=3D(0x0; 0xffffffff))
  182: (05) goto pc-129
  ; }
  54: (bc) w0 =3D w6                      ; R0_w=3Dscalar(umax=3D42949672=
95,var_off=3D(0x0; 0xffffffff)) R6_w=3Dscalar(umax=3D4294967295,var_off=3D=
(0x0; 0xffffffff))
  55: (95) exit
  At program exit the register R0 has value (0x0; 0xffffffff) should have=
 been in (0x0; 0x1)
  processed 281 insns (limit 1000000) max_states_per_insn 1 total_states =
26 peak_states 26 mark_read 13
  -- END PROG LOAD LOG --
  libbpf: prog 'connect_v4_prog': failed to load: -22

The corresponding source code:

  __attribute__ ((noinline))
  int do_bind(struct bpf_sock_addr *ctx)
  {
        struct sockaddr_in sa =3D {};

        sa.sin_family =3D AF_INET;
        sa.sin_port =3D bpf_htons(0);
        sa.sin_addr.s_addr =3D bpf_htonl(SRC_REWRITE_IP4);

        if (bpf_bind(ctx, (struct sockaddr *)&sa, sizeof(sa)) !=3D 0)
                return 0;

        return 1;
  }
  ...
  SEC("cgroup/connect4")
  int connect_v4_prog(struct bpf_sock_addr *ctx)
  {
  ...
        return do_bind(ctx) ? 1 : 0;
  }

Insn 180 is a call to 'do_bind'. The call's return value is also the retu=
rn value
for the program. Since do_bind() returns 0/1, so it is legitimate for com=
piler to
optimize 'return do_bind(ctx) ? 1 : 0' to 'return do_bind(ctx)'. However,=
 such
optimization breaks verifier as the return value of 'do_bind()' is marked=
 as any
scalar which violates the requirement of prog return value 0/1.

There are two ways to fix this problem, (1) changing 'return 1' in do_bin=
d() to
e.g. 'return 10' so the compiler has to do 'do_bind(ctx) ? 1 :0', or (2)
suggested by Andrii, marking do_bind() with __weak attribute so the compi=
ler
cannot make any assumption on do_bind() return value.

This patch adopted adding __weak approach which is simpler and more resis=
tant
to potential compiler optimizations.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/progs/connect4_prog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/connect4_prog.c b/tools/te=
sting/selftests/bpf/progs/connect4_prog.c
index ec25371de789..7ef49ec04838 100644
--- a/tools/testing/selftests/bpf/progs/connect4_prog.c
+++ b/tools/testing/selftests/bpf/progs/connect4_prog.c
@@ -32,7 +32,7 @@
 #define IFNAMSIZ 16
 #endif
=20
-__attribute__ ((noinline))
+__attribute__ ((noinline)) __weak
 int do_bind(struct bpf_sock_addr *ctx)
 {
 	struct sockaddr_in sa =3D {};
--=20
2.34.1

