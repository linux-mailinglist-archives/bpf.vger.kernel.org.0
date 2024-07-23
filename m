Return-Path: <bpf+bounces-35398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B3393A3C9
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 17:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341E21C22975
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 15:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB595153810;
	Tue, 23 Jul 2024 15:34:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EA313B599
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721748896; cv=none; b=hiKub8ttOkk+2iraRq7tl7pBdXB9Rcm49fmUG/UK2pV3U0up2RBP1riGttaKX3vTUkwlBejSc2TBnQc69MQx5Vvgru1b4movAyPWhqwY4lB7dNftL0g8UxfO3fQSpW1f4dIdL7LIEOqKj6MCLf2Sp4uIJCWSDpH4Tg31SVLWudI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721748896; c=relaxed/simple;
	bh=vWaduycU4Xa9QQMObEn5LHKJADi+zWaIzwrewN3WuDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aIv5gP8dpvfK2NRt84YjBRrt0wGTC8WW+csmkKU/lN01W/bKyAEV330YXPSMSZaRwSpGAfVOmv0qKc1U25jzweGzpyR1Nw79hTvtHd/ST++epRIYILSsMkvFKn8eu8/8HLoxlO/r7VFu5OVHQiuCdKyCddUv0+S8PfaT24GO6xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 5345E6E942F6; Tue, 23 Jul 2024 08:34:39 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	syzbot+ad9ec60c8eaf69e6f99c@syzkaller.appspotmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 1/2] bpf: Fail verification for sign-extension of packet data/data_end/data_meta
Date: Tue, 23 Jul 2024 08:34:39 -0700
Message-ID: <20240723153439.2429035-1-yonghong.song@linux.dev>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/verifier.c |  5 +++--
 net/core/filter.c     | 21 ++++++++++++++++-----
 3 files changed, 20 insertions(+), 7 deletions(-)

Changelog from v2:
  - Rebase due to conflict

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5694ff5ad52d..cebbb1d568cb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -920,6 +920,7 @@ static_assert(__BPF_REG_TYPE_MAX <=3D BPF_BASE_TYPE_L=
IMIT);
  */
 struct bpf_insn_access_aux {
 	enum bpf_reg_type reg_type;
+	bool is_ldsx;
 	union {
 		int ctx_field_size;
 		struct {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6de17b99c74d..58b590752197 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5626,12 +5626,13 @@ static int check_packet_access(struct bpf_verifie=
r_env *env, u32 regno, int off,
 /* check access to 'struct bpf_context' fields.  Supports fixed offsets =
only */
 static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, =
int off, int size,
 			    enum bpf_access_type t, enum bpf_reg_type *reg_type,
-			    struct btf **btf, u32 *btf_id, bool *is_retval)
+			    struct btf **btf, u32 *btf_id, bool *is_retval, bool is_ldsx)
 {
 	struct bpf_insn_access_aux info =3D {
 		.reg_type =3D *reg_type,
 		.log =3D &env->log,
 		.is_retval =3D false,
+		.is_ldsx =3D is_ldsx,
 	};
=20
 	if (env->ops->is_valid_access &&
@@ -6945,7 +6946,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
 			return err;
=20
 		err =3D check_ctx_access(env, insn_idx, off, size, t, &reg_type, &btf,
-				       &btf_id, &is_retval);
+				       &btf_id, &is_retval, is_ldsx);
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


