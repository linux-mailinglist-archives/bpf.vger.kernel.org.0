Return-Path: <bpf+bounces-35399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF8E93A3CA
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 17:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D23F1F242C8
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 15:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CE8156F5F;
	Tue, 23 Jul 2024 15:34:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F16013B599
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721748899; cv=none; b=TIF0wjh/aw7oi3zg866U8tW5MmYQtMcEGPRD8AADMNetBGRwDpQCHWkutubDpRFlTM0A7W6VyWnDXevTFJz8vzlmFhjP3JIbi9jVdVUyI4Fj8TFpnVHZavWLsbse3zOyqqgv+cnFp19A4eXhSTAutYGfcb3m2gRHUy8pK7SOU8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721748899; c=relaxed/simple;
	bh=/FtLXNLEZEA4AnIHyiALw2vvNw3Q+UXnhYXFntSGy88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ru/0rJi+rtylbSZkgUBcs336ogcENV1Whhil4GMIA4hv7HaqDSAS8poX6ZaqLL8pW36RH/+7KLkM1p0Y4JWW1TVf4O+IEUZeCYWCXJn+0jL2Voe2lkyya5htJkBbyrxNieC1mfoCcY4GKDaHYt9KQrMvkMK6F0Fw76yt3hpCD94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 6933A6E94311; Tue, 23 Jul 2024 08:34:44 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add tests for ldsx of pkt data/data_end/data_meta accesses
Date: Tue, 23 Jul 2024 08:34:44 -0700
Message-ID: <20240723153444.2430365-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240723153439.2429035-1-yonghong.song@linux.dev>
References: <20240723153439.2429035-1-yonghong.song@linux.dev>
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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


