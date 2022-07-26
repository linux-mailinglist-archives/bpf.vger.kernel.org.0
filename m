Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A00C5819EB
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 20:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbiGZSsE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 14:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239617AbiGZSsC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 14:48:02 -0400
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CB833421
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 11:48:00 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id DAC23F834E80; Tue, 26 Jul 2022 11:47:42 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
Date:   Tue, 26 Jul 2022 11:47:04 -0700
Message-Id: <20220726184706.954822-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220726184706.954822-1-joannelkoong@gmail.com>
References: <20220726184706.954822-1-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_SOFTFAIL,TVD_RCVD_IP autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add skb dynptrs, which are dynptrs whose underlying pointer points
to a skb. The dynptr acts on skb data. skb dynptrs have two main
benefits. One is that they allow operations on sizes that are not
statically known at compile-time (eg variable-sized accesses).
Another is that parsing the packet data through dynptrs (instead of
through direct access of skb->data and skb->data_end) can be more
ergonomic and less brittle (eg does not need manual if checking for
being within bounds of data_end).

For bpf prog types that don't support writes on skb data, the dynptr is
read-only (writes and data slices are not permitted). For reads on the
dynptr, this includes reading into data in the non-linear paged buffers
but for writes and data slices, if the data is in a paged buffer, the
user must first call bpf_skb_pull_data to pull the data into the linear
portion.

Additionally, any helper calls that change the underlying packet buffer
(eg bpf_skb_pull_data) invalidates any data slices of the associated
dynptr.

Right now, skb dynptrs can only be constructed from skbs that are
the bpf program context - as such, there does not need to be any
reference tracking or release on skb dynptrs.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/bpf.h            |  8 ++++-
 include/linux/filter.h         |  4 +++
 include/uapi/linux/bpf.h       | 42 ++++++++++++++++++++++++--
 kernel/bpf/helpers.c           | 54 +++++++++++++++++++++++++++++++++-
 kernel/bpf/verifier.c          | 43 +++++++++++++++++++++++----
 net/core/filter.c              | 53 ++++++++++++++++++++++++++++++---
 tools/include/uapi/linux/bpf.h | 42 ++++++++++++++++++++++++--
 7 files changed, 229 insertions(+), 17 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 20c26aed7896..7fbd4324c848 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -407,11 +407,14 @@ enum bpf_type_flag {
 	/* Size is known at compile time. */
 	MEM_FIXED_SIZE		=3D BIT(10 + BPF_BASE_TYPE_BITS),
=20
+	/* DYNPTR points to sk_buff */
+	DYNPTR_TYPE_SKB		=3D BIT(11 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	=3D __BPF_TYPE_FLAG_MAX - 1,
 };
=20
-#define DYNPTR_TYPE_FLAG_MASK	(DYNPTR_TYPE_LOCAL | DYNPTR_TYPE_RINGBUF)
+#define DYNPTR_TYPE_FLAG_MASK	(DYNPTR_TYPE_LOCAL | DYNPTR_TYPE_RINGBUF |=
 DYNPTR_TYPE_SKB)
=20
 /* Max number of base types. */
 #define BPF_BASE_TYPE_LIMIT	(1UL << BPF_BASE_TYPE_BITS)
@@ -2556,12 +2559,15 @@ enum bpf_dynptr_type {
 	BPF_DYNPTR_TYPE_LOCAL,
 	/* Underlying data is a ringbuf record */
 	BPF_DYNPTR_TYPE_RINGBUF,
+	/* Underlying data is a sk_buff */
+	BPF_DYNPTR_TYPE_SKB,
 };
=20
 void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
 		     enum bpf_dynptr_type type, u32 offset, u32 size);
 void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
 int bpf_dynptr_check_size(u32 size);
+void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
=20
 #ifdef CONFIG_BPF_LSM
 void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index a5f21dc3c432..649063d9cbfd 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1532,4 +1532,8 @@ static __always_inline int __bpf_xdp_redirect_map(s=
truct bpf_map *map, u32 ifind
 	return XDP_REDIRECT;
 }
=20
+int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset, void *to=
, u32 len);
+int __bpf_skb_store_bytes(struct sk_buff *skb, u32 offset, const void *f=
rom,
+			  u32 len, u64 flags);
+
 #endif /* __LINUX_FILTER_H__ */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 59a217ca2dfd..0730cd198a7f 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5241,11 +5241,22 @@ union bpf_attr {
  *	Description
  *		Write *len* bytes from *src* into *dst*, starting from *offset*
  *		into *dst*.
- *		*flags* is currently unused.
+ *
+ *		*flags* must be 0 except for skb-type dynptrs.
+ *
+ *		For skb-type dynptrs:
+ *		    *  if *offset* + *len* extends into the skb's paged buffers, the=
 user
+ *		       should manually pull the skb with bpf_skb_pull and then try a=
gain.
+ *
+ *		    *  *flags* are a combination of **BPF_F_RECOMPUTE_CSUM** (automa=
tically
+ *			recompute the checksum for the packet after storing the bytes) and
+ *			**BPF_F_INVALIDATE_HASH** (set *skb*\ **->hash**, *skb*\
+ *			**->swhash** and *skb*\ **->l4hash** to 0).
  *	Return
  *		0 on success, -E2BIG if *offset* + *len* exceeds the length
  *		of *dst*'s data, -EINVAL if *dst* is an invalid dynptr or if *dst*
- *		is a read-only dynptr or if *flags* is not 0.
+ *		is a read-only dynptr or if *flags* is not correct, -EAGAIN if for
+ *		skb-type dynptrs the write extends into the skb's paged buffers.
  *
  * void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len)
  *	Description
@@ -5253,10 +5264,19 @@ union bpf_attr {
  *
  *		*len* must be a statically known value. The returned data slice
  *		is invalidated whenever the dynptr is invalidated.
+ *
+ *		For skb-type dynptrs:
+ *		    * if *offset* + *len* extends into the skb's paged buffers,
+ *		      the user should manually pull the skb with bpf_skb_pull and th=
en
+ *		      try again.
+ *
+ *		    * the data slice is automatically invalidated anytime a
+ *		      helper call that changes the underlying packet buffer
+ *		      (eg bpf_skb_pull) is called.
  *	Return
  *		Pointer to the underlying dynptr data, NULL if the dynptr is
  *		read-only, if the dynptr is invalid, or if the offset and length
- *		is out of bounds.
+ *		is out of bounds or in a paged buffer for skb-type dynptrs.
  *
  * s64 bpf_tcp_raw_gen_syncookie_ipv4(struct iphdr *iph, struct tcphdr *=
th, u32 th_len)
  *	Description
@@ -5331,6 +5351,21 @@ union bpf_attr {
  *		**-EACCES** if the SYN cookie is not valid.
  *
  *		**-EPROTONOSUPPORT** if CONFIG_IPV6 is not builtin.
+ *
+ * long bpf_dynptr_from_skb(struct sk_buff *skb, u64 flags, struct bpf_d=
ynptr *ptr)
+ *	Description
+ *		Get a dynptr to the data in *skb*. *skb* must be the BPF program
+ *		context. Depending on program type, the dynptr may be read-only,
+ *		in which case trying to obtain a direct data slice to it through
+ *		bpf_dynptr_data will return an error.
+ *
+ *		Calls that change the *skb*'s underlying packet buffer
+ *		(eg bpf_skb_pull_data) do not invalidate the dynptr, but they do
+ *		invalidate any data slices associated with the dynptr.
+ *
+ *		*flags* is currently unused, it must be 0 for now.
+ *	Return
+ *		0 on success or -EINVAL if flags is not 0.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5541,6 +5576,7 @@ union bpf_attr {
 	FN(tcp_raw_gen_syncookie_ipv6),	\
 	FN(tcp_raw_check_syncookie_ipv4),	\
 	FN(tcp_raw_check_syncookie_ipv6),	\
+	FN(dynptr_from_skb),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1f961f9982d2..21a806057e9e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1425,11 +1425,21 @@ static bool bpf_dynptr_is_rdonly(struct bpf_dynpt=
r_kern *ptr)
 	return ptr->size & DYNPTR_RDONLY_BIT;
 }
=20
+void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr)
+{
+	ptr->size |=3D DYNPTR_RDONLY_BIT;
+}
+
 static void bpf_dynptr_set_type(struct bpf_dynptr_kern *ptr, enum bpf_dy=
nptr_type type)
 {
 	ptr->size |=3D type << DYNPTR_TYPE_SHIFT;
 }
=20
+static enum bpf_dynptr_type bpf_dynptr_get_type(const struct bpf_dynptr_=
kern *ptr)
+{
+	return (ptr->size & ~(DYNPTR_RDONLY_BIT)) >> DYNPTR_TYPE_SHIFT;
+}
+
 static u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr)
 {
 	return ptr->size & DYNPTR_SIZE_MASK;
@@ -1500,6 +1510,7 @@ static const struct bpf_func_proto bpf_dynptr_from_=
mem_proto =3D {
 BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, struct bpf_dynptr_ker=
n *, src,
 	   u32, offset, u64, flags)
 {
+	enum bpf_dynptr_type type;
 	int err;
=20
 	if (!src->data || flags)
@@ -1509,6 +1520,11 @@ BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len,=
 struct bpf_dynptr_kern *, src
 	if (err)
 		return err;
=20
+	type =3D bpf_dynptr_get_type(src);
+
+	if (type =3D=3D BPF_DYNPTR_TYPE_SKB)
+		return __bpf_skb_load_bytes(src->data, src->offset + offset, dst, len)=
;
+
 	memcpy(dst, src->data + src->offset + offset, len);
=20
 	return 0;
@@ -1528,15 +1544,38 @@ static const struct bpf_func_proto bpf_dynptr_rea=
d_proto =3D {
 BPF_CALL_5(bpf_dynptr_write, struct bpf_dynptr_kern *, dst, u32, offset,=
 void *, src,
 	   u32, len, u64, flags)
 {
+	enum bpf_dynptr_type type;
 	int err;
=20
-	if (!dst->data || flags || bpf_dynptr_is_rdonly(dst))
+	if (!dst->data || bpf_dynptr_is_rdonly(dst))
 		return -EINVAL;
=20
 	err =3D bpf_dynptr_check_off_len(dst, offset, len);
 	if (err)
 		return err;
=20
+	type =3D bpf_dynptr_get_type(dst);
+
+	if (flags) {
+		if (type =3D=3D BPF_DYNPTR_TYPE_SKB) {
+			if (flags & ~(BPF_F_RECOMPUTE_CSUM | BPF_F_INVALIDATE_HASH))
+				return -EINVAL;
+		} else {
+			return -EINVAL;
+		}
+	}
+
+	if (type =3D=3D BPF_DYNPTR_TYPE_SKB) {
+		struct sk_buff *skb =3D dst->data;
+
+		/* if the data is paged, the caller needs to pull it first */
+		if (dst->offset + offset + len > skb->len - skb->data_len)
+			return -EAGAIN;
+
+		return __bpf_skb_store_bytes(skb, dst->offset + offset, src, len,
+					     flags);
+	}
+
 	memcpy(dst->data + dst->offset + offset, src, len);
=20
 	return 0;
@@ -1555,6 +1594,7 @@ static const struct bpf_func_proto bpf_dynptr_write=
_proto =3D {
=20
 BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset, =
u32, len)
 {
+	enum bpf_dynptr_type type;
 	int err;
=20
 	if (!ptr->data)
@@ -1567,6 +1607,18 @@ BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern=
 *, ptr, u32, offset, u32, len
 	if (bpf_dynptr_is_rdonly(ptr))
 		return 0;
=20
+	type =3D bpf_dynptr_get_type(ptr);
+
+	if (type =3D=3D BPF_DYNPTR_TYPE_SKB) {
+		struct sk_buff *skb =3D ptr->data;
+
+		/* if the data is paged, the caller needs to pull it first */
+		if (ptr->offset + offset + len > skb->len - skb->data_len)
+			return 0;
+
+		return (unsigned long)(skb->data + ptr->offset + offset);
+	}
+
 	return (unsigned long)(ptr->data + ptr->offset + offset);
 }
=20
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0d523741a543..0838653eeb4e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -263,6 +263,7 @@ struct bpf_call_arg_meta {
 	u32 subprogno;
 	struct bpf_map_value_off_desc *kptr_off_desc;
 	u8 uninit_dynptr_regno;
+	enum bpf_dynptr_type type;
 };
=20
 struct btf *btf_vmlinux;
@@ -678,6 +679,8 @@ static enum bpf_dynptr_type arg_to_dynptr_type(enum b=
pf_arg_type arg_type)
 		return BPF_DYNPTR_TYPE_LOCAL;
 	case DYNPTR_TYPE_RINGBUF:
 		return BPF_DYNPTR_TYPE_RINGBUF;
+	case DYNPTR_TYPE_SKB:
+		return BPF_DYNPTR_TYPE_SKB;
 	default:
 		return BPF_DYNPTR_TYPE_INVALID;
 	}
@@ -5820,12 +5823,14 @@ int check_func_arg_reg_off(struct bpf_verifier_en=
v *env,
 	return __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
 }
=20
-static u32 stack_slot_get_id(struct bpf_verifier_env *env, struct bpf_re=
g_state *reg)
+static void stack_slot_get_dynptr_info(struct bpf_verifier_env *env, str=
uct bpf_reg_state *reg,
+				       struct bpf_call_arg_meta *meta)
 {
 	struct bpf_func_state *state =3D func(env, reg);
 	int spi =3D get_spi(reg->off);
=20
-	return state->stack[spi].spilled_ptr.id;
+	meta->ref_obj_id =3D state->stack[spi].spilled_ptr.id;
+	meta->type =3D state->stack[spi].spilled_ptr.dynptr.type;
 }
=20
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
@@ -6052,6 +6057,9 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
 				case DYNPTR_TYPE_RINGBUF:
 					err_extra =3D "ringbuf ";
 					break;
+				case DYNPTR_TYPE_SKB:
+					err_extra =3D "skb ";
+					break;
 				default:
 					break;
 				}
@@ -6065,8 +6073,10 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg,
 					verbose(env, "verifier internal error: multiple refcounted args in =
BPF_FUNC_dynptr_data");
 					return -EFAULT;
 				}
-				/* Find the id of the dynptr we're tracking the reference of */
-				meta->ref_obj_id =3D stack_slot_get_id(env, reg);
+				/* Find the id and the type of the dynptr we're tracking
+				 * the reference of.
+				 */
+				stack_slot_get_dynptr_info(env, reg, meta);
 			}
 		}
 		break;
@@ -7406,7 +7416,11 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 		regs[BPF_REG_0].type =3D PTR_TO_TCP_SOCK | ret_flag;
 	} else if (base_type(ret_type) =3D=3D RET_PTR_TO_ALLOC_MEM) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
-		regs[BPF_REG_0].type =3D PTR_TO_MEM | ret_flag;
+		if (func_id =3D=3D BPF_FUNC_dynptr_data &&
+		    meta.type =3D=3D BPF_DYNPTR_TYPE_SKB)
+			regs[BPF_REG_0].type =3D PTR_TO_PACKET | ret_flag;
+		else
+			regs[BPF_REG_0].type =3D PTR_TO_MEM | ret_flag;
 		regs[BPF_REG_0].mem_size =3D meta.mem_size;
 	} else if (base_type(ret_type) =3D=3D RET_PTR_TO_MEM_OR_BTF_ID) {
 		const struct btf_type *t;
@@ -14132,6 +14146,25 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
 			goto patch_call_imm;
 		}
=20
+		if (insn->imm =3D=3D BPF_FUNC_dynptr_from_skb) {
+			if (!may_access_direct_pkt_data(env, NULL, BPF_WRITE))
+				insn_buf[0] =3D BPF_MOV32_IMM(BPF_REG_4, true);
+			else
+				insn_buf[0] =3D BPF_MOV32_IMM(BPF_REG_4, false);
+			insn_buf[1] =3D *insn;
+			cnt =3D 2;
+
+			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta +=3D cnt - 1;
+			env->prog =3D new_prog;
+			prog =3D new_prog;
+			insn =3D new_prog->insnsi + i + delta;
+			goto patch_call_imm;
+		}
+
 		/* BPF_EMIT_CALL() assumptions in some of the map_gen_lookup
 		 * and other inlining handlers are currently limited to 64 bit
 		 * only.
diff --git a/net/core/filter.c b/net/core/filter.c
index 5669248aff25..312f99deb759 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1681,8 +1681,8 @@ static inline void bpf_pull_mac_rcsum(struct sk_buf=
f *skb)
 		skb_postpull_rcsum(skb, skb_mac_header(skb), skb->mac_len);
 }
=20
-BPF_CALL_5(bpf_skb_store_bytes, struct sk_buff *, skb, u32, offset,
-	   const void *, from, u32, len, u64, flags)
+int __bpf_skb_store_bytes(struct sk_buff *skb, u32 offset, const void *f=
rom,
+			  u32 len, u64 flags)
 {
 	void *ptr;
=20
@@ -1707,6 +1707,12 @@ BPF_CALL_5(bpf_skb_store_bytes, struct sk_buff *, =
skb, u32, offset,
 	return 0;
 }
=20
+BPF_CALL_5(bpf_skb_store_bytes, struct sk_buff *, skb, u32, offset,
+	   const void *, from, u32, len, u64, flags)
+{
+	return __bpf_skb_store_bytes(skb, offset, from, len, flags);
+}
+
 static const struct bpf_func_proto bpf_skb_store_bytes_proto =3D {
 	.func		=3D bpf_skb_store_bytes,
 	.gpl_only	=3D false,
@@ -1718,8 +1724,7 @@ static const struct bpf_func_proto bpf_skb_store_by=
tes_proto =3D {
 	.arg5_type	=3D ARG_ANYTHING,
 };
=20
-BPF_CALL_4(bpf_skb_load_bytes, const struct sk_buff *, skb, u32, offset,
-	   void *, to, u32, len)
+int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset, void *to=
, u32 len)
 {
 	void *ptr;
=20
@@ -1738,6 +1743,12 @@ BPF_CALL_4(bpf_skb_load_bytes, const struct sk_buf=
f *, skb, u32, offset,
 	return -EFAULT;
 }
=20
+BPF_CALL_4(bpf_skb_load_bytes, const struct sk_buff *, skb, u32, offset,
+	   void *, to, u32, len)
+{
+	return __bpf_skb_load_bytes(skb, offset, to, len);
+}
+
 static const struct bpf_func_proto bpf_skb_load_bytes_proto =3D {
 	.func		=3D bpf_skb_load_bytes,
 	.gpl_only	=3D false,
@@ -1849,6 +1860,32 @@ static const struct bpf_func_proto bpf_skb_pull_da=
ta_proto =3D {
 	.arg2_type	=3D ARG_ANYTHING,
 };
=20
+/* is_rdonly is set by the verifier */
+BPF_CALL_4(bpf_dynptr_from_skb, struct sk_buff *, skb, u64, flags,
+	   struct bpf_dynptr_kern *, ptr, u32, is_rdonly)
+{
+	if (flags) {
+		bpf_dynptr_set_null(ptr);
+		return -EINVAL;
+	}
+
+	bpf_dynptr_init(ptr, skb, BPF_DYNPTR_TYPE_SKB, 0, skb->len);
+
+	if (is_rdonly)
+		bpf_dynptr_set_rdonly(ptr);
+
+	return 0;
+}
+
+static const struct bpf_func_proto bpf_dynptr_from_skb_proto =3D {
+	.func		=3D bpf_dynptr_from_skb,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_CTX,
+	.arg2_type	=3D ARG_ANYTHING,
+	.arg3_type	=3D ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_SKB | MEM_UNINIT,
+};
+
 BPF_CALL_1(bpf_sk_fullsock, struct sock *, sk)
 {
 	return sk_fullsock(sk) ? (unsigned long)sk : (unsigned long)NULL;
@@ -7808,6 +7845,8 @@ sk_filter_func_proto(enum bpf_func_id func_id, cons=
t struct bpf_prog *prog)
 		return &bpf_get_socket_uid_proto;
 	case BPF_FUNC_perf_event_output:
 		return &bpf_skb_event_output_proto;
+	case BPF_FUNC_dynptr_from_skb:
+		return &bpf_dynptr_from_skb_proto;
 	default:
 		return bpf_sk_base_func_proto(func_id);
 	}
@@ -7991,6 +8030,8 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, con=
st struct bpf_prog *prog)
 		return &bpf_tcp_raw_check_syncookie_ipv6_proto;
 #endif
 #endif
+	case BPF_FUNC_dynptr_from_skb:
+		return &bpf_dynptr_from_skb_proto;
 	default:
 		return bpf_sk_base_func_proto(func_id);
 	}
@@ -8186,6 +8227,8 @@ sk_skb_func_proto(enum bpf_func_id func_id, const s=
truct bpf_prog *prog)
 	case BPF_FUNC_skc_lookup_tcp:
 		return &bpf_skc_lookup_tcp_proto;
 #endif
+	case BPF_FUNC_dynptr_from_skb:
+		return &bpf_dynptr_from_skb_proto;
 	default:
 		return bpf_sk_base_func_proto(func_id);
 	}
@@ -8224,6 +8267,8 @@ lwt_out_func_proto(enum bpf_func_id func_id, const =
struct bpf_prog *prog)
 		return &bpf_get_smp_processor_id_proto;
 	case BPF_FUNC_skb_under_cgroup:
 		return &bpf_skb_under_cgroup_proto;
+	case BPF_FUNC_dynptr_from_skb:
+		return &bpf_dynptr_from_skb_proto;
 	default:
 		return bpf_sk_base_func_proto(func_id);
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 59a217ca2dfd..0730cd198a7f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5241,11 +5241,22 @@ union bpf_attr {
  *	Description
  *		Write *len* bytes from *src* into *dst*, starting from *offset*
  *		into *dst*.
- *		*flags* is currently unused.
+ *
+ *		*flags* must be 0 except for skb-type dynptrs.
+ *
+ *		For skb-type dynptrs:
+ *		    *  if *offset* + *len* extends into the skb's paged buffers, the=
 user
+ *		       should manually pull the skb with bpf_skb_pull and then try a=
gain.
+ *
+ *		    *  *flags* are a combination of **BPF_F_RECOMPUTE_CSUM** (automa=
tically
+ *			recompute the checksum for the packet after storing the bytes) and
+ *			**BPF_F_INVALIDATE_HASH** (set *skb*\ **->hash**, *skb*\
+ *			**->swhash** and *skb*\ **->l4hash** to 0).
  *	Return
  *		0 on success, -E2BIG if *offset* + *len* exceeds the length
  *		of *dst*'s data, -EINVAL if *dst* is an invalid dynptr or if *dst*
- *		is a read-only dynptr or if *flags* is not 0.
+ *		is a read-only dynptr or if *flags* is not correct, -EAGAIN if for
+ *		skb-type dynptrs the write extends into the skb's paged buffers.
  *
  * void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len)
  *	Description
@@ -5253,10 +5264,19 @@ union bpf_attr {
  *
  *		*len* must be a statically known value. The returned data slice
  *		is invalidated whenever the dynptr is invalidated.
+ *
+ *		For skb-type dynptrs:
+ *		    * if *offset* + *len* extends into the skb's paged buffers,
+ *		      the user should manually pull the skb with bpf_skb_pull and th=
en
+ *		      try again.
+ *
+ *		    * the data slice is automatically invalidated anytime a
+ *		      helper call that changes the underlying packet buffer
+ *		      (eg bpf_skb_pull) is called.
  *	Return
  *		Pointer to the underlying dynptr data, NULL if the dynptr is
  *		read-only, if the dynptr is invalid, or if the offset and length
- *		is out of bounds.
+ *		is out of bounds or in a paged buffer for skb-type dynptrs.
  *
  * s64 bpf_tcp_raw_gen_syncookie_ipv4(struct iphdr *iph, struct tcphdr *=
th, u32 th_len)
  *	Description
@@ -5331,6 +5351,21 @@ union bpf_attr {
  *		**-EACCES** if the SYN cookie is not valid.
  *
  *		**-EPROTONOSUPPORT** if CONFIG_IPV6 is not builtin.
+ *
+ * long bpf_dynptr_from_skb(struct sk_buff *skb, u64 flags, struct bpf_d=
ynptr *ptr)
+ *	Description
+ *		Get a dynptr to the data in *skb*. *skb* must be the BPF program
+ *		context. Depending on program type, the dynptr may be read-only,
+ *		in which case trying to obtain a direct data slice to it through
+ *		bpf_dynptr_data will return an error.
+ *
+ *		Calls that change the *skb*'s underlying packet buffer
+ *		(eg bpf_skb_pull_data) do not invalidate the dynptr, but they do
+ *		invalidate any data slices associated with the dynptr.
+ *
+ *		*flags* is currently unused, it must be 0 for now.
+ *	Return
+ *		0 on success or -EINVAL if flags is not 0.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5541,6 +5576,7 @@ union bpf_attr {
 	FN(tcp_raw_gen_syncookie_ipv6),	\
 	FN(tcp_raw_check_syncookie_ipv4),	\
 	FN(tcp_raw_check_syncookie_ipv6),	\
+	FN(dynptr_from_skb),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

