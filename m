Return-Path: <bpf+bounces-166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1CA6F8D95
	for <lists+bpf@lfdr.de>; Sat,  6 May 2023 03:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E2928115E
	for <lists+bpf@lfdr.de>; Sat,  6 May 2023 01:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FB915B1;
	Sat,  6 May 2023 01:31:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2123C15A6
	for <bpf@vger.kernel.org>; Sat,  6 May 2023 01:31:49 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B4EFC
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 18:31:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b8f32cc8c31so4430188276.2
        for <bpf@vger.kernel.org>; Fri, 05 May 2023 18:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683336705; x=1685928705;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=frvyVRQKd8P16QsNHAt3wOX14KYkv1sP6KmHiWvR3jI=;
        b=2j99yagPu6O5tI2XpRBORuGgFc6kEs9y2dUPHawi/JSma8OQ6E2MHhx4O9Ab7BS3rH
         MFxG1wkoBAw6cAjqYhFxrrUBhHLau6dVmxXofEFyBPd9cbm3H44Yk/SORp4v+WCmvBtJ
         GBSuFqUPhggJvx0aKRqAoeUbkMrlgDq+I7ufggQIf8HQw39KdqLnmJya5pApAns3z7xw
         TRx407FBy1LrTIc3P5B5Sah6jQCW+AK2c3TNaR6zPArS+6skFfFgURwxGShjHuhnsYz6
         q0MzhynNEJ263XZort+Gx3jOSQUzGCu1t/4Ot3e/YbFRKkMDSfVPkmn/H9fhdP79SQ5p
         BK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683336705; x=1685928705;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=frvyVRQKd8P16QsNHAt3wOX14KYkv1sP6KmHiWvR3jI=;
        b=H2gl+z1RaU5110XDedn1c98O8AkC4jXHGcAN7KU5lgmX8Agttz0GpKBKRNAupjbLUB
         d9pKlwi9B0w0TZzg88B414KOuegu2kGVe3Oh7SY2BypFat9M9+gUF7UHfSJ5WjPhGmdO
         otwgT7z1vlhEgLHOsBht3hNTmNKuz7SPP3HKJYUm4xlGAbYD3ko7gvgVArJslgLYaXnv
         rFeXpsDQYl87MYnUbGHNWmVMPNA39XxfuvPfd3buF2uROECpIxrpHBXky3DqlmprKgBG
         UTc9yrBb2bT2cx8cdOhVDIezkk747KY+kRcTwRgXMckBmvRH2U4jbO6Fx/2nSpP91k9i
         2+Mg==
X-Gm-Message-State: AC+VfDzFg79jqbsoFu18DEx1UeDVA0FIPdw8E+4fYNHvyou9Crer4ENZ
	LOohLN3Uo8qzGhYSmAWfm5vZkGeTvuT9hN49s4T3lNS+n412cJeLRQQdFKPD8U/24F/LaprQPLE
	kIA0Uk3gLdGETk83tsqs7KyPdihv9zfFUU0OIWg3O2Ihz9ZhqVYDnO9b+Rw==
X-Google-Smtp-Source: ACHHUZ4g3KQijz58tl0bKbhG9xiE0tgdgnNtq7pfO9dK2OQ/0sV35Cnjv+lvTJ/zUyNMkWNStVyoGJU3FDE=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:6826:a1a:a426:bb4a])
 (user=drosen job=sendgmr) by 2002:a25:e90f:0:b0:b96:7676:db47 with SMTP id
 n15-20020a25e90f000000b00b967676db47mr1478887ybd.13.1683336704703; Fri, 05
 May 2023 18:31:44 -0700 (PDT)
Date: Fri,  5 May 2023 18:31:30 -0700
In-Reply-To: <20230506013134.2492210-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230506013134.2492210-1-drosen@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230506013134.2492210-2-drosen@google.com>
Subject: [PATCH bpf-next v3 1/5] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
From: Daniel Rosenberg <drosen@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

bpf_dynptr_slice(_rw) uses a user provided buffer if it can not provide
a pointer to a block of contiguous memory. This buffer is unused in the
case of local dynptrs, and may be unused in other cases as well. There
is no need to require the buffer, as the kfunc can just return NULL if
it was needed and not provided.

This adds another kfunc annotation, __opt, which combines with __sz and
__szk to allow the buffer associated with the size to be NULL. If the
buffer is NULL, the verifier does not check that the buffer is of
sufficient size.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 Documentation/bpf/kfuncs.rst | 23 ++++++++++++++++++++++-
 include/linux/skbuff.h       |  2 +-
 kernel/bpf/helpers.c         | 30 ++++++++++++++++++------------
 kernel/bpf/verifier.c        | 17 +++++++++++++----
 4 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index ea2516374d92..7a3d9de5f315 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -100,7 +100,7 @@ Hence, whenever a constant scalar argument is accepted by a kfunc which is not a
 size parameter, and the value of the constant matters for program safety, __k
 suffix should be used.
 
-2.2.2 __uninit Annotation
+2.2.3 __uninit Annotation
 -------------------------
 
 This annotation is used to indicate that the argument will be treated as
@@ -117,6 +117,27 @@ Here, the dynptr will be treated as an uninitialized dynptr. Without this
 annotation, the verifier will reject the program if the dynptr passed in is
 not initialized.
 
+2.2.4 __opt Annotation
+-------------------------
+
+This annotation is used to indicate that the buffer associated with an __sz or __szk
+argument may be null. If the function is passed a nullptr in place of the buffer,
+the verifier will not check that length is appropriate for the buffer. The kfunc is
+responsible for checking if this buffer is null before using it.
+
+An example is given below::
+
+        __bpf_kfunc void *bpf_dynptr_slice(..., void *buffer__opt, u32 buffer__szk)
+        {
+        ...
+        }
+
+Here, the buffer may be null. If buffer is not null, it at least of size buffer_szk.
+Either way, the returned buffer is either NULL, or of size buffer_szk. Without this
+annotation, the verifier will reject the program if a null pointer is passed in with
+a nonzero size.
+
+
 .. _BPF_kfunc_nodef:
 
 2.3 Using an existing kernel function
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 738776ab8838..8ddb4af1a501 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4033,7 +4033,7 @@ __skb_header_pointer(const struct sk_buff *skb, int offset, int len,
 	if (likely(hlen - offset >= len))
 		return (void *)data + offset;
 
-	if (!skb || unlikely(skb_copy_bits(skb, offset, buffer, len) < 0))
+	if (!skb || !buffer || unlikely(skb_copy_bits(skb, offset, buffer, len) < 0))
 		return NULL;
 
 	return buffer;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bb6b4637ebf2..0ded98377d37 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2174,13 +2174,15 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
  * bpf_dynptr_slice() - Obtain a read-only pointer to the dynptr data.
  * @ptr: The dynptr whose data slice to retrieve
  * @offset: Offset into the dynptr
- * @buffer: User-provided buffer to copy contents into
- * @buffer__szk: Size (in bytes) of the buffer. This is the length of the
- *		 requested slice. This must be a constant.
+ * @buffer__opt: User-provided buffer to copy contents into.  May be NULL
+ * @buffer__szk: Size (in bytes) of the buffer if present. This is the
+ *               length of the requested slice. This must be a constant.
  *
  * For non-skb and non-xdp type dynptrs, there is no difference between
  * bpf_dynptr_slice and bpf_dynptr_data.
  *
+ *  If buffer__opt is NULL, the call will fail if buffer_opt was needed.
+ *
  * If the intention is to write to the data slice, please use
  * bpf_dynptr_slice_rdwr.
  *
@@ -2197,7 +2199,7 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
  * direct pointer)
  */
 __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset,
-				   void *buffer, u32 buffer__szk)
+				   void *buffer__opt, u32 buffer__szk)
 {
 	enum bpf_dynptr_type type;
 	u32 len = buffer__szk;
@@ -2217,15 +2219,17 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
 	case BPF_DYNPTR_TYPE_RINGBUF:
 		return ptr->data + ptr->offset + offset;
 	case BPF_DYNPTR_TYPE_SKB:
-		return skb_header_pointer(ptr->data, ptr->offset + offset, len, buffer);
+		return skb_header_pointer(ptr->data, ptr->offset + offset, len, buffer__opt);
 	case BPF_DYNPTR_TYPE_XDP:
 	{
 		void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset + offset, len);
 		if (xdp_ptr)
 			return xdp_ptr;
 
-		bpf_xdp_copy_buf(ptr->data, ptr->offset + offset, buffer, len, false);
-		return buffer;
+		if (!buffer__opt)
+			return NULL;
+		bpf_xdp_copy_buf(ptr->data, ptr->offset + offset, buffer__opt, len, false);
+		return buffer__opt;
 	}
 	default:
 		WARN_ONCE(true, "unknown dynptr type %d\n", type);
@@ -2237,13 +2241,15 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
  * bpf_dynptr_slice_rdwr() - Obtain a writable pointer to the dynptr data.
  * @ptr: The dynptr whose data slice to retrieve
  * @offset: Offset into the dynptr
- * @buffer: User-provided buffer to copy contents into
- * @buffer__szk: Size (in bytes) of the buffer. This is the length of the
- *		 requested slice. This must be a constant.
+ * @buffer__opt: User-provided buffer to copy contents into. May be NULL
+ * @buffer__szk: Size (in bytes) of the buffer if present. This is the
+ *               length of the requested slice. This must be a constant.
  *
  * For non-skb and non-xdp type dynptrs, there is no difference between
  * bpf_dynptr_slice and bpf_dynptr_data.
  *
+ * If buffer__opt is NULL, the call will fail if buffer_opt was needed.
+ *
  * The returned pointer is writable and may point to either directly the dynptr
  * data at the requested offset or to the buffer if unable to obtain a direct
  * data pointer to (example: the requested slice is to the paged area of an skb
@@ -2274,7 +2280,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
  * direct pointer)
  */
 __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 offset,
-					void *buffer, u32 buffer__szk)
+					void *buffer__opt, u32 buffer__szk)
 {
 	if (!ptr->data || __bpf_dynptr_is_rdonly(ptr))
 		return NULL;
@@ -2301,7 +2307,7 @@ __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 o
 	 * will be copied out into the buffer and the user will need to call
 	 * bpf_dynptr_write() to commit changes.
 	 */
-	return bpf_dynptr_slice(ptr, offset, buffer, buffer__szk);
+	return bpf_dynptr_slice(ptr, offset, buffer__opt, buffer__szk);
 }
 
 __bpf_kfunc int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 start, u32 end)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0fa96581eb77..7e6bbae9db81 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9743,6 +9743,11 @@ static bool is_kfunc_arg_const_mem_size(const struct btf *btf,
 	return __kfunc_param_match_suffix(btf, arg, "__szk");
 }
 
+static bool is_kfunc_arg_optional(const struct btf *btf, const struct btf_param *arg)
+{
+	return __kfunc_param_match_suffix(btf, arg, "__opt");
+}
+
 static bool is_kfunc_arg_constant(const struct btf *btf, const struct btf_param *arg)
 {
 	return __kfunc_param_match_suffix(btf, arg, "__k");
@@ -10830,13 +10835,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			break;
 		case KF_ARG_PTR_TO_MEM_SIZE:
 		{
+			struct bpf_reg_state *buff_reg = &regs[regno];
+			const struct btf_param *buff_arg = &args[i];
 			struct bpf_reg_state *size_reg = &regs[regno + 1];
 			const struct btf_param *size_arg = &args[i + 1];
 
-			ret = check_kfunc_mem_size_reg(env, size_reg, regno + 1);
-			if (ret < 0) {
-				verbose(env, "arg#%d arg#%d memory, len pair leads to invalid memory access\n", i, i + 1);
-				return ret;
+			if (!register_is_null(buff_reg) || !is_kfunc_arg_optional(meta->btf, buff_arg)) {
+				ret = check_kfunc_mem_size_reg(env, size_reg, regno + 1);
+				if (ret < 0) {
+					verbose(env, "arg#%d arg#%d memory, len pair leads to invalid memory access\n", i, i + 1);
+					return ret;
+				}
 			}
 
 			if (is_kfunc_arg_const_mem_size(meta->btf, size_arg, size_reg)) {
-- 
2.40.1.521.gf1e218fcd8-goog


