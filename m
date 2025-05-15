Return-Path: <bpf+bounces-58352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA1FAB9036
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 21:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0BF41B65090
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 19:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0051C26980C;
	Thu, 15 May 2025 19:52:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC04257452
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 19:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747338720; cv=none; b=slusp4+YFOCUTSf3izRVQuAD7nF5Azz91ORG08NHvFnLuuT3HBsTLRSc1BG2Ly/yNS96zi/tE9X64uVUsc3LFgRO7QEDM/mKbi26MRpu+UyOyCq04X5adwNMjLaUQ8temoeMCRImvyVmI2gjXIGHpcnH8YBA2qH8C9CuLHaHn6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747338720; c=relaxed/simple;
	bh=Im5+ysaA3kRHc08ZpkP0iPeUifUnJJLOWrjLYdv1dAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IxOViHrrGN73sjtwnupQnFx83fyZkdT45Zard+M9rfsrEm44h/5KpbQSh14w/wB99PVdeyWaXvXJo8hxbXHWuExt4muKyaxtK0eZ07sG0xDJqNUDNXjS6QFzm85v66Jq90gTMbM0kKunfNwYsxTaW1eglZTtA1zAxJO7cxHR1Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id AAD7078616B1; Thu, 15 May 2025 12:51:45 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix dynptr/test_probe_read_user_str_dynptr test failure
Date: Thu, 15 May 2025 12:51:45 -0700
Message-ID: <20250515195145.3127492-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When running bpf selftests with llvm18 compiler, I hit the following
test failure:

  verify_success:PASS:dynptr_success__open 0 nsec
  verify_success:PASS:bpf_object__find_program_by_name 0 nsec
  verify_success:PASS:dynptr_success__load 0 nsec
  verify_success:PASS:test_run 0 nsec
  verify_success:FAIL:err unexpected err: actual 1 !=3D expected 0
  #91/19   dynptr/test_probe_read_user_str_dynptr:FAIL
  #91      dynptr:FAIL

I did some analysis and found that the test failure is related to
lib/strncpy_from_user.c function do_strncpy_from_user():

  ...
  byte_at_a_time:
        while (max) {
                char c;

                unsafe_get_user(c,src+res, efault);
                dst[res] =3D c;
                if (!c)
                        return res;
                res++;
                max--;
        }
  ...

Depending on whether the character 'c' is '\0' or not, the
return value 'res' could be different.

In prog_tests/dynptr.c, we have
  char user_data[384] =3D {[0 ... 382] =3D 'a', '\0'};
the user_data[383] is '\0'. This will cause the following
error in progs/dynptr_success.c:

  test_dynptr_probe_str_xdp:
  ...
        bpf_for(i, 0, ARRAY_SIZE(test_len)) {
                __u32 len =3D test_len[i];

                cnt =3D bpf_read_dynptr_fn(&ptr_xdp, off, len, ptr);
                if (cnt !=3D len)
                        err =3D 1; <=3D=3D=3D error happens here
  ...

In the above particular case, len is 384 and cnt is 383.

If user_data[384] is changed to
  char user_data[384] =3D {[0 ... 383] =3D 'a'};

The above error will not happen and the test will run successfully.

Cc: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/dynptr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/test=
ing/selftests/bpf/prog_tests/dynptr.c
index 62e7ec775f24..4cc61afa63b4 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -45,7 +45,7 @@ static struct {
=20
 static void verify_success(const char *prog_name, enum test_setup_type s=
etup_type)
 {
-	char user_data[384] =3D {[0 ... 382] =3D 'a', '\0'};
+	char user_data[384] =3D {[0 ... 383] =3D 'a'};
 	struct dynptr_success *skel;
 	struct bpf_program *prog;
 	struct bpf_link *link;
--=20
2.47.1


