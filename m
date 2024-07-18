Return-Path: <bpf+bounces-34984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578DE934758
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 07:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634951C21805
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 05:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACCC40855;
	Thu, 18 Jul 2024 05:02:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733CE1B86EE
	for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 05:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721278964; cv=none; b=LOhdLlM2Vr9LAH9pG8kb/lvJZYWLJokriBCdOhuDshV1wX3wu8JsTvcTwe5hO0c5I/M3aIc6SElCO5mSmDoxgPL5ytThgfAE/npMoGw5d6y+xywELJfObNvLBakdeMD1BsDfzep0pvAGP6a6SSnqCIqqG9a/r7JwoXJCgY3m6o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721278964; c=relaxed/simple;
	bh=weMNOz8+Icphu7iStqPx+w3sjpgACIPScYhaIt5doIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTionLma6NQA8xbKvXymqAUYu1b+CMthxcqQ+oj/33LTsYcA7vA7QgztBF8SixardpVOQrBX6gZUfNhkAMqttvgZnfNMewLe2uBufY3OUB6kleqWmLFuzhjZRptqM5EXMrfy3wXGxsvNjfzXqw9s0Z5sticj5Qiowg5AL1NVk88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 6A06D6B665C3; Wed, 17 Jul 2024 22:02:28 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for ldsx of pkt data/data_end/data_meta accesses
Date: Wed, 17 Jul 2024 22:02:28 -0700
Message-ID: <20240718050228.3543663-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240718050223.3543253-1-yonghong.song@linux.dev>
References: <20240718050223.3543253-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The following tests are added to verifier_ldsx.c:
  - sign extension of data/data_end/data_meta for tcx programs.
    The actual checking is in bpf_skb_is_valid_access() which
    is called by sk_filter, cg_skb, lwt, tc(tcx) and sk_skb.
  - sign extension of data/data_end/data_meta for xdp programs.
  - sign extension of data/data_end for flow_dissector programs.

All newly-added tests have verification failure with message
"invalid bpf_context access". Without previous patch, all these
tests succeeded verification.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/progs/verifier_ldsx.c       | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)

Changelog from v1:
  - Simplify test case and still trigger the verification failure.

diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/te=
sting/selftests/bpf/progs/verifier_ldsx.c
index d4427d8e1217..52edee41caf6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -144,6 +144,118 @@ __naked void ldsx_s32_range(void)
 	: __clobber_all);
 }
=20
+SEC("xdp")
+__description("LDSX, xdp s32 xdp_md->data")
+__failure __msg("invalid bpf_context access")
+__naked void ldsx_ctx_1(void)
+{
+	asm volatile (
+	"r2 =3D *(s32 *)(r1 + %[xdp_md_data]);"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("LDSX, xdp s32 xdp_md->data_end")
+__failure __msg("invalid bpf_context access")
+__naked void ldsx_ctx_2(void)
+{
+	asm volatile (
+	"r2 =3D *(s32 *)(r1 + %[xdp_md_data_end]);"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("LDSX, xdp s32 xdp_md->data_meta")
+__failure __msg("invalid bpf_context access")
+__naked void ldsx_ctx_3(void)
+{
+	asm volatile (
+	"r2 =3D *(s32 *)(r1 + %[xdp_md_data_meta]);"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("tcx/ingress")
+__description("LDSX, tcx s32 __sk_buff->data")
+__failure __msg("invalid bpf_context access")
+__naked void ldsx_ctx_4(void)
+{
+	asm volatile (
+	"r2 =3D *(s32 *)(r1 + %[sk_buff_data]);"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm_const(sk_buff_data, offsetof(struct __sk_buff, data))
+	: __clobber_all);
+}
+
+SEC("tcx/ingress")
+__description("LDSX, tcx s32 __sk_buff->data_end")
+__failure __msg("invalid bpf_context access")
+__naked void ldsx_ctx_5(void)
+{
+	asm volatile (
+	"r2 =3D *(s32 *)(r1 + %[sk_buff_data_end]);"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm_const(sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tcx/ingress")
+__description("LDSX, tcx s32 __sk_buff->data_meta")
+__failure __msg("invalid bpf_context access")
+__naked void ldsx_ctx_6(void)
+{
+	asm volatile (
+	"r2 =3D *(s32 *)(r1 + %[sk_buff_data_meta]);"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm_const(sk_buff_data_meta, offsetof(struct __sk_buff, data_meta))
+	: __clobber_all);
+}
+
+SEC("flow_dissector")
+__description("LDSX, flow_dissector s32 __sk_buff->data")
+__failure __msg("invalid bpf_context access")
+__naked void ldsx_ctx_7(void)
+{
+	asm volatile (
+	"r2 =3D *(s32 *)(r1 + %[sk_buff_data]);"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm_const(sk_buff_data, offsetof(struct __sk_buff, data))
+	: __clobber_all);
+}
+
+SEC("flow_dissector")
+__description("LDSX, flow_dissector s32 __sk_buff->data_end")
+__failure __msg("invalid bpf_context access")
+__naked void ldsx_ctx_8(void)
+{
+	asm volatile (
+	"r2 =3D *(s32 *)(r1 + %[sk_buff_data_end]);"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm_const(sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
 #else
=20
 SEC("socket")
--=20
2.43.0


