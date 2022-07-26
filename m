Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A3C5819E9
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 20:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiGZSr6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 14:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbiGZSr5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 14:47:57 -0400
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848BE33421
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 11:47:56 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id ED190F834E82; Tue, 26 Jul 2022 11:47:42 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1 2/3] bpf: Add xdp dynptrs
Date:   Tue, 26 Jul 2022 11:47:05 -0700
Message-Id: <20220726184706.954822-3-joannelkoong@gmail.com>
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

Add xdp dynptrs, which are dynptrs whose underlying pointer points
to a xdp_buff. The dynptr acts on xdp data. xdp dynptrs have two main
benefits. One is that they allow operations on sizes that are not
statically known at compile-time (eg variable-sized accesses).
Another is that parsing the packet data through dynptrs (instead of
through direct access of xdp->data and xdp->data_end) can be more
ergonomic and less brittle (eg does not need manual if checking for
being within bounds of data_end).

For reads and writes on the dynptr, this includes reading/writing
from/to and across fragments. For data slices, direct access to
data in fragments is also permitted, but access across fragments
is not.

Any helper calls that change the underlying packet buffer (eg
bpf_xdp_adjust_head) invalidates any data slices of the associated
dynptr.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/bpf.h            |  8 +++++-
 include/linux/filter.h         |  3 +++
 include/uapi/linux/bpf.h       | 20 +++++++++++++--
 kernel/bpf/helpers.c           | 10 ++++++++
 kernel/bpf/verifier.c          |  7 +++++-
 net/core/filter.c              | 46 +++++++++++++++++++++++++++++-----
 tools/include/uapi/linux/bpf.h | 20 +++++++++++++--
 7 files changed, 102 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7fbd4324c848..77e2c94cce52 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -410,11 +410,15 @@ enum bpf_type_flag {
 	/* DYNPTR points to sk_buff */
 	DYNPTR_TYPE_SKB		=3D BIT(11 + BPF_BASE_TYPE_BITS),
=20
+	/* DYNPTR points to xdp_buff */
+	DYNPTR_TYPE_XDP		=3D BIT(12 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	=3D __BPF_TYPE_FLAG_MAX - 1,
 };
=20
-#define DYNPTR_TYPE_FLAG_MASK	(DYNPTR_TYPE_LOCAL | DYNPTR_TYPE_RINGBUF |=
 DYNPTR_TYPE_SKB)
+#define DYNPTR_TYPE_FLAG_MASK	(DYNPTR_TYPE_LOCAL | DYNPTR_TYPE_RINGBUF |=
 DYNPTR_TYPE_SKB \
+				 | DYNPTR_TYPE_XDP)
=20
 /* Max number of base types. */
 #define BPF_BASE_TYPE_LIMIT	(1UL << BPF_BASE_TYPE_BITS)
@@ -2561,6 +2565,8 @@ enum bpf_dynptr_type {
 	BPF_DYNPTR_TYPE_RINGBUF,
 	/* Underlying data is a sk_buff */
 	BPF_DYNPTR_TYPE_SKB,
+	/* Underlying data is a xdp_buff */
+	BPF_DYNPTR_TYPE_XDP,
 };
=20
 void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 649063d9cbfd..80f030239877 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1535,5 +1535,8 @@ static __always_inline int __bpf_xdp_redirect_map(s=
truct bpf_map *map, u32 ifind
 int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset, void *to=
, u32 len);
 int __bpf_skb_store_bytes(struct sk_buff *skb, u32 offset, const void *f=
rom,
 			  u32 len, u64 flags);
+int __bpf_xdp_load_bytes(struct xdp_buff *xdp, u32 offset, void *buf, u3=
2 len);
+int __bpf_xdp_store_bytes(struct xdp_buff *xdp, u32 offset, void *buf, u=
32 len);
+void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len);
=20
 #endif /* __LINUX_FILTER_H__ */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0730cd198a7f..559f9ba8b497 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5270,13 +5270,15 @@ union bpf_attr {
  *		      the user should manually pull the skb with bpf_skb_pull and th=
en
  *		      try again.
  *
+ *		For skb-type and xdp-type dynptrs:
  *		    * the data slice is automatically invalidated anytime a
  *		      helper call that changes the underlying packet buffer
- *		      (eg bpf_skb_pull) is called.
+ *		      (eg bpf_skb_pull, bpf_xdp_adjust_head) is called.
  *	Return
  *		Pointer to the underlying dynptr data, NULL if the dynptr is
  *		read-only, if the dynptr is invalid, or if the offset and length
- *		is out of bounds or in a paged buffer for skb-type dynptrs.
+ *		is out of bounds or in a paged buffer for skb-type dynptrs or
+ *		across fragments for xdp-type dynptrs.
  *
  * s64 bpf_tcp_raw_gen_syncookie_ipv4(struct iphdr *iph, struct tcphdr *=
th, u32 th_len)
  *	Description
@@ -5366,6 +5368,19 @@ union bpf_attr {
  *		*flags* is currently unused, it must be 0 for now.
  *	Return
  *		0 on success or -EINVAL if flags is not 0.
+ *
+ * long bpf_dynptr_from_xdp(struct xdp_buff *xdp_md, u64 flags, struct b=
pf_dynptr *ptr)
+ *	Description
+ *		Get a dynptr to the data in *xdp_md*. *xdp_md* must be the BPF progr=
am
+ *		context.
+ *
+ *		Calls that change the *xdp_md*'s underlying packet buffer
+ *		(eg bpf_xdp_adjust_head) do not invalidate the dynptr, but they do
+ *		invalidate any data slices associated with the dynptr.
+ *
+ *		*flags* is currently unused, it must be 0 for now.
+ *	Return
+ *		0 on success, -EINVAL if flags is not 0.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5577,6 +5592,7 @@ union bpf_attr {
 	FN(tcp_raw_check_syncookie_ipv4),	\
 	FN(tcp_raw_check_syncookie_ipv6),	\
 	FN(dynptr_from_skb),		\
+	FN(dynptr_from_xdp),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 21a806057e9e..3c6e349790f5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1524,6 +1524,8 @@ BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, =
struct bpf_dynptr_kern *, src
=20
 	if (type =3D=3D BPF_DYNPTR_TYPE_SKB)
 		return __bpf_skb_load_bytes(src->data, src->offset + offset, dst, len)=
;
+	else if (type =3D=3D BPF_DYNPTR_TYPE_XDP)
+		return __bpf_xdp_load_bytes(src->data, src->offset + offset, dst, len)=
;
=20
 	memcpy(dst, src->data + src->offset + offset, len);
=20
@@ -1574,6 +1576,8 @@ BPF_CALL_5(bpf_dynptr_write, struct bpf_dynptr_kern=
 *, dst, u32, offset, void *,
=20
 		return __bpf_skb_store_bytes(skb, dst->offset + offset, src, len,
 					     flags);
+	} else if (type =3D=3D BPF_DYNPTR_TYPE_XDP) {
+		return __bpf_xdp_store_bytes(dst->data, dst->offset + offset, src, len=
);
 	}
=20
 	memcpy(dst->data + dst->offset + offset, src, len);
@@ -1617,6 +1621,12 @@ BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern=
 *, ptr, u32, offset, u32, len
 			return 0;
=20
 		return (unsigned long)(skb->data + ptr->offset + offset);
+	} else if (type =3D=3D BPF_DYNPTR_TYPE_XDP) {
+		/* if the requested data in across fragments, then it cannot
+		 * be accessed directly - bpf_xdp_pointer will return NULL
+		 */
+		return (unsigned long)bpf_xdp_pointer(ptr->data,
+						      ptr->offset + offset, len);
 	}
=20
 	return (unsigned long)(ptr->data + ptr->offset + offset);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0838653eeb4e..6bb1f68539a8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -681,6 +681,8 @@ static enum bpf_dynptr_type arg_to_dynptr_type(enum b=
pf_arg_type arg_type)
 		return BPF_DYNPTR_TYPE_RINGBUF;
 	case DYNPTR_TYPE_SKB:
 		return BPF_DYNPTR_TYPE_SKB;
+	case DYNPTR_TYPE_XDP:
+		return BPF_DYNPTR_TYPE_XDP;
 	default:
 		return BPF_DYNPTR_TYPE_INVALID;
 	}
@@ -6060,6 +6062,9 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
 				case DYNPTR_TYPE_SKB:
 					err_extra =3D "skb ";
 					break;
+				case DYNPTR_TYPE_XDP:
+					err_extra =3D "xdp ";
+					break;
 				default:
 					break;
 				}
@@ -7417,7 +7422,7 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn
 	} else if (base_type(ret_type) =3D=3D RET_PTR_TO_ALLOC_MEM) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		if (func_id =3D=3D BPF_FUNC_dynptr_data &&
-		    meta.type =3D=3D BPF_DYNPTR_TYPE_SKB)
+		    (meta.type =3D=3D BPF_DYNPTR_TYPE_SKB || meta.type =3D=3D BPF_DYNP=
TR_TYPE_XDP))
 			regs[BPF_REG_0].type =3D PTR_TO_PACKET | ret_flag;
 		else
 			regs[BPF_REG_0].type =3D PTR_TO_MEM | ret_flag;
diff --git a/net/core/filter.c b/net/core/filter.c
index 312f99deb759..3c8ba88eabb4 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3825,7 +3825,29 @@ static const struct bpf_func_proto sk_skb_change_h=
ead_proto =3D {
 	.arg3_type	=3D ARG_ANYTHING,
 };
=20
-BPF_CALL_1(bpf_xdp_get_buff_len, struct  xdp_buff*, xdp)
+BPF_CALL_3(bpf_dynptr_from_xdp, struct xdp_buff*, xdp, u64, flags,
+	   struct bpf_dynptr_kern *, ptr)
+{
+	if (flags) {
+		bpf_dynptr_set_null(ptr);
+		return -EINVAL;
+	}
+
+	bpf_dynptr_init(ptr, xdp, BPF_DYNPTR_TYPE_XDP, 0, xdp_get_buff_len(xdp)=
);
+
+	return 0;
+}
+
+static const struct bpf_func_proto bpf_dynptr_from_xdp_proto =3D {
+	.func		=3D bpf_dynptr_from_xdp,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_CTX,
+	.arg2_type	=3D ARG_ANYTHING,
+	.arg3_type	=3D ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_XDP | MEM_UNINIT,
+};
+
+BPF_CALL_1(bpf_xdp_get_buff_len, struct xdp_buff*, xdp)
 {
 	return xdp_get_buff_len(xdp);
 }
@@ -3927,7 +3949,7 @@ static void bpf_xdp_copy_buf(struct xdp_buff *xdp, =
unsigned long off,
 	}
 }
=20
-static void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len)
+void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len)
 {
 	struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(xdp);
 	u32 size =3D xdp->data_end - xdp->data;
@@ -3958,8 +3980,7 @@ static void *bpf_xdp_pointer(struct xdp_buff *xdp, =
u32 offset, u32 len)
 	return offset + len <=3D size ? addr + offset : NULL;
 }
=20
-BPF_CALL_4(bpf_xdp_load_bytes, struct xdp_buff *, xdp, u32, offset,
-	   void *, buf, u32, len)
+int __bpf_xdp_load_bytes(struct xdp_buff *xdp, u32 offset, void *buf, u3=
2 len)
 {
 	void *ptr;
=20
@@ -3975,6 +3996,12 @@ BPF_CALL_4(bpf_xdp_load_bytes, struct xdp_buff *, =
xdp, u32, offset,
 	return 0;
 }
=20
+BPF_CALL_4(bpf_xdp_load_bytes, struct xdp_buff *, xdp, u32, offset,
+	   void *, buf, u32, len)
+{
+	return __bpf_xdp_load_bytes(xdp, offset, buf, len);
+}
+
 static const struct bpf_func_proto bpf_xdp_load_bytes_proto =3D {
 	.func		=3D bpf_xdp_load_bytes,
 	.gpl_only	=3D false,
@@ -3985,8 +4012,7 @@ static const struct bpf_func_proto bpf_xdp_load_byt=
es_proto =3D {
 	.arg4_type	=3D ARG_CONST_SIZE,
 };
=20
-BPF_CALL_4(bpf_xdp_store_bytes, struct xdp_buff *, xdp, u32, offset,
-	   void *, buf, u32, len)
+int __bpf_xdp_store_bytes(struct xdp_buff *xdp, u32 offset, void *buf, u=
32 len)
 {
 	void *ptr;
=20
@@ -4002,6 +4028,12 @@ BPF_CALL_4(bpf_xdp_store_bytes, struct xdp_buff *,=
 xdp, u32, offset,
 	return 0;
 }
=20
+BPF_CALL_4(bpf_xdp_store_bytes, struct xdp_buff *, xdp, u32, offset,
+	   void *, buf, u32, len)
+{
+	return __bpf_xdp_store_bytes(xdp, offset, buf, len);
+}
+
 static const struct bpf_func_proto bpf_xdp_store_bytes_proto =3D {
 	.func		=3D bpf_xdp_store_bytes,
 	.gpl_only	=3D false,
@@ -8091,6 +8123,8 @@ xdp_func_proto(enum bpf_func_id func_id, const stru=
ct bpf_prog *prog)
 		return &bpf_tcp_raw_check_syncookie_ipv6_proto;
 #endif
 #endif
+	case BPF_FUNC_dynptr_from_xdp:
+		return &bpf_dynptr_from_xdp_proto;
 	default:
 		return bpf_sk_base_func_proto(func_id);
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 0730cd198a7f..559f9ba8b497 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5270,13 +5270,15 @@ union bpf_attr {
  *		      the user should manually pull the skb with bpf_skb_pull and th=
en
  *		      try again.
  *
+ *		For skb-type and xdp-type dynptrs:
  *		    * the data slice is automatically invalidated anytime a
  *		      helper call that changes the underlying packet buffer
- *		      (eg bpf_skb_pull) is called.
+ *		      (eg bpf_skb_pull, bpf_xdp_adjust_head) is called.
  *	Return
  *		Pointer to the underlying dynptr data, NULL if the dynptr is
  *		read-only, if the dynptr is invalid, or if the offset and length
- *		is out of bounds or in a paged buffer for skb-type dynptrs.
+ *		is out of bounds or in a paged buffer for skb-type dynptrs or
+ *		across fragments for xdp-type dynptrs.
  *
  * s64 bpf_tcp_raw_gen_syncookie_ipv4(struct iphdr *iph, struct tcphdr *=
th, u32 th_len)
  *	Description
@@ -5366,6 +5368,19 @@ union bpf_attr {
  *		*flags* is currently unused, it must be 0 for now.
  *	Return
  *		0 on success or -EINVAL if flags is not 0.
+ *
+ * long bpf_dynptr_from_xdp(struct xdp_buff *xdp_md, u64 flags, struct b=
pf_dynptr *ptr)
+ *	Description
+ *		Get a dynptr to the data in *xdp_md*. *xdp_md* must be the BPF progr=
am
+ *		context.
+ *
+ *		Calls that change the *xdp_md*'s underlying packet buffer
+ *		(eg bpf_xdp_adjust_head) do not invalidate the dynptr, but they do
+ *		invalidate any data slices associated with the dynptr.
+ *
+ *		*flags* is currently unused, it must be 0 for now.
+ *	Return
+ *		0 on success, -EINVAL if flags is not 0.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5577,6 +5592,7 @@ union bpf_attr {
 	FN(tcp_raw_check_syncookie_ipv4),	\
 	FN(tcp_raw_check_syncookie_ipv6),	\
 	FN(dynptr_from_skb),		\
+	FN(dynptr_from_xdp),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

