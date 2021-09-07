Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18C9402900
	for <lists+bpf@lfdr.de>; Tue,  7 Sep 2021 14:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344332AbhIGMi0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 08:38:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344270AbhIGMiS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Sep 2021 08:38:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB04D61106;
        Tue,  7 Sep 2021 12:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631018231;
        bh=pfY6ENVHNz42gxex9OGOfzBjdSNrpvHXb6CZxFAhg7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mAact9cH0J+yfgcBLyXuKMRcQ2x7pWobGwliObV0P/sc3/WmvF4a3sxJlkAW6b18Z
         VCkp44cY6coFkZWXMUYq37IOTVD1te4OJmK5HwjVRfbnvmls5UbRf5M82ZKSGVgtqK
         ckYcjjPjwWSGCTtYcFMyN+WjawnbmbewqSw64CBKwqh68r3xF3I1NBmXcRz/iwbrgY
         XYX+TEBblSCIHQ920ZNregz6hRLQjRCK4HM3Wb9o1a3EmixDqrwxe1f9hYu/WEOv7E
         MFVmmhV452P4tM0vAY7z0fe8X3HHmI6cm8T0/UJxdNFrm2DOotq+HOiHuWFTBGmoik
         2FE51F54iNmKg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, shayagr@amazon.com,
        john.fastabend@gmail.com, dsahern@kernel.org, brouer@redhat.com,
        echaudro@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com, toke@redhat.com
Subject: [PATCH v13 bpf-next 17/18] net: xdp: introduce bpf_xdp_adjust_data helper
Date:   Tue,  7 Sep 2021 14:35:21 +0200
Message-Id: <0b4db9979b649f326b22cd723ce447d24c3f9511.1631007211.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631007211.git.lorenzo@kernel.org>
References: <cover.1631007211.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For XDP frames split over multiple buffers, the xdp_md->data and
xdp_md->data_end pointers will point to the start and end of the first
fragment only. bpf_xdp_adjust_data can be used to access subsequent
fragments by moving the data pointers. To use, an XDP program can call
this helper with the byte offset of the packet payload that
it wants to access; the helper will move xdp_md->data and xdp_md ->data_end
so they point to the requested payload offset and to the end of the
fragment containing this byte offset, and return the byte offset of the
start of the fragment.
To move back to the beginning of the packet, simply call the
helper with an offset of '0'.
Note also that the helpers that modify the packet boundaries
(bpf_xdp_adjust_head(), bpf_xdp_adjust_tail() and
bpf_xdp_adjust_meta()) will fail if the pointers have been
moved; it is the responsibility of the BPF program to move them
back before using these helpers.

Suggested-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/xdp.h              |  8 +++++
 include/uapi/linux/bpf.h       | 32 +++++++++++++++++
 net/bpf/test_run.c             |  8 +++++
 net/core/filter.c              | 65 +++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h | 32 +++++++++++++++++
 5 files changed, 144 insertions(+), 1 deletion(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index cdaecf8d4d61..ce4764c7cd40 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -82,6 +82,11 @@ struct xdp_buff {
 	struct xdp_txq_info *txq;
 	u32 frame_sz; /* frame size to deduce data_hard_end/reserved tailroom*/
 	u16 flags; /* supported values defined in xdp_flags */
+	/* xdp multi-buff metadata used for frags iteration */
+	struct {
+		u16 headroom;	/* frame headroom: data - data_hard_start */
+		u16 headlen;	/* first buffer length: data_end - data */
+	} mb;
 };
 
 static __always_inline bool xdp_buff_is_mb(struct xdp_buff *xdp)
@@ -127,6 +132,9 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned char *hard_start,
 	xdp->data = data;
 	xdp->data_end = data + data_len;
 	xdp->data_meta = meta_valid ? data : data + 1;
+	/* mb metadata for frags iteration */
+	xdp->mb.headroom = headroom;
+	xdp->mb.headlen = data_len;
 }
 
 /* Reserve memory area at end-of data area.
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 1fd87bd5848b..4f56ba0fd1dd 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4883,6 +4883,37 @@ union bpf_attr {
  *		Get the total size of a given xdp buff (linear and paged area)
  *	Return
  *		The total size of a given xdp buffer.
+ *
+ * long bpf_xdp_adjust_data(struct xdp_buff *xdp_md, u32 offset)
+ *	Description
+ *		For XDP frames split over multiple buffers, the
+ *		*xdp_md*\ **->data** and *xdp_md *\ **->data_end** pointers
+ *		will point to the start and end of the first fragment only.
+ *		This helper can be used to access subsequent fragments by
+ *		moving the data pointers. To use, an XDP program can call
+ *		this helper with the byte offset of the packet payload that
+ *		it wants to access; the helper will move *xdp_md*\ **->data**
+ *		and *xdp_md *\ **->data_end** so they point to the requested
+ *		payload offset and to the end of the fragment containing this
+ *		byte offset, and return the byte offset of the start of the
+ *		fragment.
+ *		To move back to the beginning of the packet, simply call the
+ *		helper with an offset of '0'.
+ *		Note also that the helpers that modify the packet boundaries
+ *		(*bpf_xdp_adjust_head()*, *bpf_xdp_adjust_tail()* and
+ *		*bpf_xdp_adjust_meta()*) will fail if the pointers have been
+ *		moved; it is the responsibility of the BPF program to move them
+ *		back before using these helpers.
+ *
+ *		A call to this helper is susceptible to change the underlying
+ *		packet buffer. Therefore, at load time, all checks on pointers
+ *		previously done by the verifier are invalidated and must be
+ *		performed again, if the helper is used in combination with
+ *		direct packet access.
+ *	Return
+ *		offset between the beginning of the current fragment and
+ *		original *xdp_md*\ **->data** on success, or a negative error
+ *		in case of failure.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5062,6 +5093,7 @@ union bpf_attr {
 	FN(get_attach_cookie),		\
 	FN(task_pt_regs),		\
 	FN(xdp_get_buff_len),		\
+	FN(xdp_adjust_data),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 869dcf23a1ca..f09c2c8c0d6c 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -757,6 +757,8 @@ static int xdp_convert_md_to_buff(struct xdp_md *xdp_md, struct xdp_buff *xdp)
 	}
 
 	xdp->data = xdp->data_meta + xdp_md->data;
+	xdp->mb.headroom = xdp->data - xdp->data_hard_start;
+	xdp->mb.headlen = xdp->data_end - xdp->data;
 	return 0;
 
 free_dev:
@@ -871,6 +873,12 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (ret)
 		goto out;
 
+	/* data pointers need to be reset after frag iteration */
+	if (unlikely(xdp.data_hard_start + xdp.mb.headroom != xdp.data)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
 	size = xdp.data_end - xdp.data_meta + sinfo->xdp_frags_size;
 	ret = bpf_test_finish(kattr, uattr, xdp.data_meta, sinfo, size,
 			      retval, duration);
diff --git a/net/core/filter.c b/net/core/filter.c
index 99bec3a13bad..a342b5ae6dbd 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3827,6 +3827,10 @@ BPF_CALL_2(bpf_xdp_adjust_head, struct xdp_buff *, xdp, int, offset)
 	void *data_start = xdp_frame_end + metalen;
 	void *data = xdp->data + offset;
 
+	/* data pointers need to be reset after frag iteration */
+	if (unlikely(xdp->data_hard_start + xdp->mb.headroom != xdp->data))
+		return -EFAULT;
+
 	if (unlikely(data < data_start ||
 		     data > xdp->data_end - ETH_HLEN))
 		return -EINVAL;
@@ -3836,6 +3840,9 @@ BPF_CALL_2(bpf_xdp_adjust_head, struct xdp_buff *, xdp, int, offset)
 			xdp->data_meta, metalen);
 	xdp->data_meta += offset;
 	xdp->data = data;
+	/* update metada for multi-buff frag iteration */
+	xdp->mb.headroom = xdp->data - xdp->data_hard_start;
+	xdp->mb.headlen = xdp->data_end - xdp->data;
 
 	return 0;
 }
@@ -3910,6 +3917,10 @@ BPF_CALL_2(bpf_xdp_adjust_tail, struct xdp_buff *, xdp, int, offset)
 	void *data_hard_end = xdp_data_hard_end(xdp); /* use xdp->frame_sz */
 	void *data_end = xdp->data_end + offset;
 
+	/* data pointer needs to be reset after frag iteration */
+	if (unlikely(xdp->data + xdp->mb.headlen != xdp->data_end))
+		return -EFAULT;
+
 	if (unlikely(xdp_buff_is_mb(xdp)))
 		return bpf_xdp_mb_adjust_tail(xdp, offset);
 
@@ -3949,6 +3960,10 @@ BPF_CALL_2(bpf_xdp_adjust_meta, struct xdp_buff *, xdp, int, offset)
 	void *meta = xdp->data_meta + offset;
 	unsigned long metalen = xdp->data - meta;
 
+	/* data pointer needs to be reset after frag iteration */
+	if (unlikely(xdp->data_hard_start + xdp->mb.headroom != xdp->data))
+		return -EFAULT;
+
 	if (xdp_data_meta_unsupported(xdp))
 		return -ENOTSUPP;
 	if (unlikely(meta < xdp_frame_end ||
@@ -3970,6 +3985,51 @@ static const struct bpf_func_proto bpf_xdp_adjust_meta_proto = {
 	.arg2_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_2(bpf_xdp_adjust_data, struct xdp_buff *, xdp, u32, offset)
+{
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	u32 base_offset = xdp->mb.headlen, max_offset = xdp->mb.headlen;
+	int i;
+
+	if (xdp_buff_is_mb(xdp))
+		max_offset += sinfo->xdp_frags_size;
+
+	if (offset > max_offset)
+		return -EINVAL;
+
+	if (offset < xdp->mb.headlen) {
+		/* linear area */
+		xdp->data = xdp->data_hard_start + xdp->mb.headroom + offset;
+		xdp->data_end = xdp->data_hard_start + xdp->mb.headroom +
+				xdp->mb.headlen;
+		return 0;
+	}
+
+	for (i = 0; i < sinfo->nr_frags; i++) {
+		/* paged area */
+		skb_frag_t *frag = &sinfo->frags[i];
+		unsigned int size = skb_frag_size(frag);
+
+		if (offset < base_offset + size) {
+			u8 *addr = skb_frag_address(frag);
+
+			xdp->data = addr + offset - base_offset;
+			xdp->data_end = addr + size;
+			break;
+		}
+		base_offset += size;
+	}
+	return base_offset;
+}
+
+static const struct bpf_func_proto bpf_xdp_adjust_data_proto = {
+	.func		= bpf_xdp_adjust_data,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_ANYTHING,
+};
+
 /* XDP_REDIRECT works by a three-step process, implemented in the functions
  * below:
  *
@@ -7261,7 +7321,8 @@ bool bpf_helper_changes_pkt_data(void *func)
 	    func == bpf_sock_ops_store_hdr_opt ||
 #endif
 	    func == bpf_lwt_in_push_encap ||
-	    func == bpf_lwt_xmit_push_encap)
+	    func == bpf_lwt_xmit_push_encap ||
+	    func == bpf_xdp_adjust_data)
 		return true;
 
 	return false;
@@ -7614,6 +7675,8 @@ xdp_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_xdp_adjust_tail_proto;
 	case BPF_FUNC_xdp_get_buff_len:
 		return &bpf_xdp_get_buff_len_proto;
+	case BPF_FUNC_xdp_adjust_data:
+		return &bpf_xdp_adjust_data_proto;
 	case BPF_FUNC_fib_lookup:
 		return &bpf_xdp_fib_lookup_proto;
 	case BPF_FUNC_check_mtu:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 1fd87bd5848b..4f56ba0fd1dd 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4883,6 +4883,37 @@ union bpf_attr {
  *		Get the total size of a given xdp buff (linear and paged area)
  *	Return
  *		The total size of a given xdp buffer.
+ *
+ * long bpf_xdp_adjust_data(struct xdp_buff *xdp_md, u32 offset)
+ *	Description
+ *		For XDP frames split over multiple buffers, the
+ *		*xdp_md*\ **->data** and *xdp_md *\ **->data_end** pointers
+ *		will point to the start and end of the first fragment only.
+ *		This helper can be used to access subsequent fragments by
+ *		moving the data pointers. To use, an XDP program can call
+ *		this helper with the byte offset of the packet payload that
+ *		it wants to access; the helper will move *xdp_md*\ **->data**
+ *		and *xdp_md *\ **->data_end** so they point to the requested
+ *		payload offset and to the end of the fragment containing this
+ *		byte offset, and return the byte offset of the start of the
+ *		fragment.
+ *		To move back to the beginning of the packet, simply call the
+ *		helper with an offset of '0'.
+ *		Note also that the helpers that modify the packet boundaries
+ *		(*bpf_xdp_adjust_head()*, *bpf_xdp_adjust_tail()* and
+ *		*bpf_xdp_adjust_meta()*) will fail if the pointers have been
+ *		moved; it is the responsibility of the BPF program to move them
+ *		back before using these helpers.
+ *
+ *		A call to this helper is susceptible to change the underlying
+ *		packet buffer. Therefore, at load time, all checks on pointers
+ *		previously done by the verifier are invalidated and must be
+ *		performed again, if the helper is used in combination with
+ *		direct packet access.
+ *	Return
+ *		offset between the beginning of the current fragment and
+ *		original *xdp_md*\ **->data** on success, or a negative error
+ *		in case of failure.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5062,6 +5093,7 @@ union bpf_attr {
 	FN(get_attach_cookie),		\
 	FN(task_pt_regs),		\
 	FN(xdp_get_buff_len),		\
+	FN(xdp_adjust_data),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.31.1

