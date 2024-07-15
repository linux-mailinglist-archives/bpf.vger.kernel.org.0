Return-Path: <bpf+bounces-34842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B050931BB3
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 22:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD5D1C21BCB
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 20:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D557EF04;
	Mon, 15 Jul 2024 20:18:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E926DDA1
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 20:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721074724; cv=none; b=tlz4PtYUOpZRTROZ7T6+Y9l/tSkBCY7r3HFhWJB7Cs5C2nqL9KzE/6Lv1RFtz6e28ywa0qaShu5NrUHnj0CCWtqwKzI9byZWVtvfQV1AH4QWrDIo6FCgkuZ9bmEz75xNhD7go1L/KHPmpFOTqrnk06VD8DjY8Q/HbmEqZqSrXGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721074724; c=relaxed/simple;
	bh=HnobuM7bXCLhl3sztMKe5S+LopTjNlrznNQCECiX01k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uToXztNTDm39W1xFk0GAT2XpaanKi0WRZRgie0uAoVIhSr826i7hGcm9Oj1i/aoWcQ34B9shzfE9P4zYnTSw/e/zXIv2bnGHevY7AdN3Mk2BBURK4O3n139HQ4MaBMG+dUUOFfKnmG8A8DUlLg3E0q5XV7t/WfN/EoTuQQ2WAPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 72D6C69F5CDC; Mon, 15 Jul 2024 13:18:28 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	syzbot+ad9ec60c8eaf69e6f99c@syzkaller.appspotmail.com
Subject: [PATCH bpf-next 1/2] bpf: Fail verification for sign-extension of packet data/data_end/data_meta
Date: Mon, 15 Jul 2024 13:18:28 -0700
Message-ID: <20240715201828.3235796-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

syzbot reported a kernel crash due to
  commit 1f1e864b6555 ("bpf: Handle sign-extenstin ctx member accesses").
The reason is due to sign-extension of 32-bit load for
packet data/data_end/data_meta uapi field.

The original code looks like:
        r2 =3D *(s32 *)(r1 + 76) /* load __sk_buff->data */
        r3 =3D *(u32 *)(r1 + 80) /* load __sk_buff->data_end */
        r0 =3D r2
        r0 +=3D 8
        if r3 > r0 goto +1
        ...
Note that __sk_buff->data load has 32-bit sign extension.

After verification and convert_ctx_accesses(), the final asm code looks l=
ike:
        r2 =3D *(u64 *)(r1 +208)
        r2 =3D (s32)r2
        r3 =3D *(u64 *)(r1 +80)
        r0 =3D r2
        r0 +=3D 8
        if r3 > r0 goto pc+1
        ...
Note that 'r2 =3D (s32)r2' may make the kernel __sk_buff->data address in=
valid
which may cause runtime failure.

Currently, in C code, typically we have
        void *data =3D (void *)(long)skb->data;
        void *data_end =3D (void *)(long)skb->data_end;
        ...
and it will generate
        r2 =3D *(u64 *)(r1 +208)
        r3 =3D *(u64 *)(r1 +80)
        r0 =3D r2
        r0 +=3D 8
        if r3 > r0 goto pc+1

If we allow sign-extension,
        void *data =3D (void *)(long)(int)skb->data;
        void *data_end =3D (void *)(long)skb->data_end;
        ...
the generated code looks like
        r2 =3D *(u64 *)(r1 +208)
        r2 <<=3D 32
        r2 s>>=3D 32
        r3 =3D *(u64 *)(r1 +80)
        r0 =3D r2
        r0 +=3D 8
        if r3 > r0 goto pc+1
and this will cause verification failure since "r2 <<=3D 32" is not allow=
ed
as "r2" is a packet pointer.

To fix this issue for case
  r2 =3D *(s32 *)(r1 + 76) /* load __sk_buff->data */
this patch added additional checking in is_valid_access() callback
function for packet data/data_end/data_meta access. If those accesses
are with sign-extenstion, the verification will fail.

  [1] https://lore.kernel.org/bpf/000000000000c90eee061d236d37@google.com=
/

Reported-by: syzbot+ad9ec60c8eaf69e6f99c@syzkaller.appspotmail.com
Fixes: 1f1e864b6555 ("bpf: Handle sign-extenstin ctx member accesses")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/verifier.c |  5 +++--
 net/core/filter.c     | 21 ++++++++++++++++-----
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4f1d4a97b9d1..d7ca17bd314e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -919,6 +919,7 @@ static_assert(__BPF_REG_TYPE_MAX <=3D BPF_BASE_TYPE_L=
IMIT);
  */
 struct bpf_insn_access_aux {
 	enum bpf_reg_type reg_type;
+	bool is_ldsx;
 	union {
 		int ctx_field_size;
 		struct {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8da132a1ef28..3a04eab7a962 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5587,11 +5587,12 @@ static int check_packet_access(struct bpf_verifie=
r_env *env, u32 regno, int off,
 /* check access to 'struct bpf_context' fields.  Supports fixed offsets =
only */
 static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, =
int off, int size,
 			    enum bpf_access_type t, enum bpf_reg_type *reg_type,
-			    struct btf **btf, u32 *btf_id)
+			    struct btf **btf, u32 *btf_id, bool is_ldsx)
 {
 	struct bpf_insn_access_aux info =3D {
 		.reg_type =3D *reg_type,
 		.log =3D &env->log,
+		.is_ldsx =3D is_ldsx,
 	};
=20
 	if (env->ops->is_valid_access &&
@@ -6891,7 +6892,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
 			return err;
=20
 		err =3D check_ctx_access(env, insn_idx, off, size, t, &reg_type, &btf,
-				       &btf_id);
+				       &btf_id, is_ldsx);
 		if (err)
 			verbose_linfo(env, insn_idx, "; ");
 		if (!err && t =3D=3D BPF_READ && value_regno >=3D 0) {
diff --git a/net/core/filter.c b/net/core/filter.c
index 4cf1d34f7617..771872e43e3f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8572,13 +8572,16 @@ static bool bpf_skb_is_valid_access(int off, int =
size, enum bpf_access_type type
 		if (off + size > offsetofend(struct __sk_buff, cb[4]))
 			return false;
 		break;
+	case bpf_ctx_range(struct __sk_buff, data):
+	case bpf_ctx_range(struct __sk_buff, data_meta):
+	case bpf_ctx_range(struct __sk_buff, data_end):
+		if (info->is_ldsx || size !=3D size_default)
+			return false;
+		break;
 	case bpf_ctx_range_till(struct __sk_buff, remote_ip6[0], remote_ip6[3])=
:
 	case bpf_ctx_range_till(struct __sk_buff, local_ip6[0], local_ip6[3]):
 	case bpf_ctx_range_till(struct __sk_buff, remote_ip4, remote_ip4):
 	case bpf_ctx_range_till(struct __sk_buff, local_ip4, local_ip4):
-	case bpf_ctx_range(struct __sk_buff, data):
-	case bpf_ctx_range(struct __sk_buff, data_meta):
-	case bpf_ctx_range(struct __sk_buff, data_end):
 		if (size !=3D size_default)
 			return false;
 		break;
@@ -9022,6 +9025,14 @@ static bool xdp_is_valid_access(int off, int size,
 			}
 		}
 		return false;
+	} else {
+		switch (off) {
+		case offsetof(struct xdp_md, data_meta):
+		case offsetof(struct xdp_md, data):
+		case offsetof(struct xdp_md, data_end):
+			if (info->is_ldsx)
+				return false;
+		}
 	}
=20
 	switch (off) {
@@ -9347,12 +9358,12 @@ static bool flow_dissector_is_valid_access(int of=
f, int size,
=20
 	switch (off) {
 	case bpf_ctx_range(struct __sk_buff, data):
-		if (size !=3D size_default)
+		if (info->is_ldsx || size !=3D size_default)
 			return false;
 		info->reg_type =3D PTR_TO_PACKET;
 		return true;
 	case bpf_ctx_range(struct __sk_buff, data_end):
-		if (size !=3D size_default)
+		if (info->is_ldsx || size !=3D size_default)
 			return false;
 		info->reg_type =3D PTR_TO_PACKET_END;
 		return true;
--=20
2.43.0


