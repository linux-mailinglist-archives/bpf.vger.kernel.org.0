Return-Path: <bpf+bounces-8758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B19297898EC
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 22:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1C8281099
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 20:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B834B107B6;
	Sat, 26 Aug 2023 20:09:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC8AA53
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 20:09:01 +0000 (UTC)
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520021AD
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 13:08:59 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 1D09C2573ACAD; Sat, 26 Aug 2023 13:08:43 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] bpf: Prevent inlining of bpf_fentry_test7()
Date: Sat, 26 Aug 2023 13:08:43 -0700
Message-Id: <20230826200843.2210074-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_SOFTFAIL,
	TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

With latest clang18, I hit test_progs failures for the following test:
  #13/2    bpf_cookie/multi_kprobe_link_api:FAIL
  #13/3    bpf_cookie/multi_kprobe_attach_api:FAIL
  #13      bpf_cookie:FAIL
  #75      fentry_fexit:FAIL
  #76/1    fentry_test/fentry:FAIL
  #76      fentry_test:FAIL
  #80/1    fexit_test/fexit:FAIL
  #80      fexit_test:FAIL
  #110/1   kprobe_multi_test/skel_api:FAIL
  #110/2   kprobe_multi_test/link_api_addrs:FAIL
  #110/3   kprobe_multi_test/link_api_syms:FAIL
  #110/4   kprobe_multi_test/attach_api_pattern:FAIL
  #110/5   kprobe_multi_test/attach_api_addrs:FAIL
  #110/6   kprobe_multi_test/attach_api_syms:FAIL
  #110     kprobe_multi_test:FAIL

For example, for #13/2, the error messages are
  ...
  kprobe_multi_test_run:FAIL:kprobe_test7_result unexpected kprobe_test7_=
result: actual 0 !=3D expected 1
  ...
  kprobe_multi_test_run:FAIL:kretprobe_test7_result unexpected kretprobe_=
test7_result: actual 0 !=3D expected 1

clang17 does not have this issue.

Further investigation shows that kernel func bpf_fentry_test7(), used
in the above tests, is inlined by the compiler although it is
marked as noinline.

  int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
  {
        return (long)arg;
  }

It is known that for simple functions like the above (e.g. just returning
a constant or an input argument), the clang compiler may still do inlinin=
g
for a noinline function. Adding 'asm volatile ("")' in the beginning of t=
he
bpf_fentry_test7() can prevent inlining.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 net/bpf/test_run.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 57a7a64b84ed..0841f8d82419 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -543,6 +543,7 @@ struct bpf_fentry_test_t {
=20
 int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
 {
+	asm volatile ("");
 	return (long)arg;
 }
=20
--=20
2.34.1


