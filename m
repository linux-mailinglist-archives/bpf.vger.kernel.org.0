Return-Path: <bpf+bounces-36696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B4094C3D2
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 19:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135EF1F2393E
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 17:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26DA190489;
	Thu,  8 Aug 2024 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="jfQ5OSej"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3AB13D8A3
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138647; cv=none; b=iKdcYK+hpZRGOZ8nvxgx96AsPAS0k0uMYC6f8UKZfByVtj0Ruj1C+0aGbpOjNDe7HnyXRFcr9fQfVer/g52p82qY8dmC7r6ss0rY2eiOrj6JrqbLnMhIMRoh/X4rnjbMAaoJUw+I+6ygRjGAjEfqm4XkCT97wNKLmwVQx1WkGU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138647; c=relaxed/simple;
	bh=tJGag/k8pGf8WyBtQNWHZrVBh8Ob3X5f+zumQaa6nxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ag1QKZ0v7rxZ+c+g8aSdbYbtsffxVeYMd/38W9w2rk16l2/rOz6VNasr5KYbnDpXc6NpDFq4L5qC12Sj9f+VYu/f8/aMH8bv0ixNHSQqqTN8DSd5v1qrfRYtGUH8GWEUobHyt3Fr9AJpKNZbiIXgVw2XSiXCd02nYe1uJ6Y97xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=jfQ5OSej; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1723138640; x=1723743440; i=linux@jordanrome.com;
	bh=wSh3pdhzRZK0EAhRZz5vSl9+QNPpDNlEHU/SFT8X7Gs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jfQ5OSejgxzASL+eS69EPOvxUGye0yO8WpmF2ZQqLDmeUuiw8JbgaLQsUjWA6qXg
	 khD+mMK7ZYFgvcyQu/3U9HQ/fSk6qs21TMe3vRsFWNOyXOfEJK6p0h1ALF7g9Ywo6
	 ur1iFYCwaW6fff7ZEUN+TXKWOGICavK6Lv0/izHTj7f4auBi2x8qCMdkeOSlrvjUp
	 aPIERze6RQK4acdKVp9ig7jPnyKjkV4kTJO2TWjmYw/FNijOLvscHvGgFa9wd+TjT
	 6OO0I5f7FPfb108dG6/hoQIW9dFaTjFr6JOxyMrsDpmZRQvbLu4x8Rvvo9p2VMxFP
	 m+2pwtLO02obt2ebGg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([173.252.127.113]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LsBB3-1sDLOM2v4Z-0145Ye; Thu, 08 Aug
 2024 19:31:41 +0200
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: [bpf-next v1] bpf: Add bpf_copy_from_user_str() helper
Date: Thu,  8 Aug 2024 10:31:31 -0700
Message-ID: <20240808173131.1128412-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZBnnLB3emelsfSYIc2KiffsxiDNMzZRCgKGN+uKrvH2hpcYPOvB
 65AVrY0tZBV5n3A8mCnOZB9k0tbeKZbYXYYCXSLIIZ+m/cg77ZCqiAJS+N8J7SmtDLFMFTQ
 4ngBne3fgSyOBhBZua+w75pVk6eNXtcgfMbra+BBr8eZtjUEh5RibrT0KiZAsmAS20QsTFc
 ULLOZuXcBjiseCKjGqz4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mxxF0KhcW8k=;tFwai5Oyx24EV/xD9PEcYymtlbY
 1aYsDa9KOfeBQx0FGTWBGxwicGoXQTlTTCJwa5sv+Xexb9/4Y6ANhXP+Ywopm7WF/CU6zF88D
 DVPZYoAt7iXOGIE/VKgerel2XP5mJbFokvNCL6gFeQvdlZIfn1iBLnYa4iCjTMI4q/fKpiKBl
 q/QltY7bprruzhkQ1mem9MMjh7ODb5DcCXF8ktzReCLph3PYzoLbOG+rDP4yQmehPOtjBrDrq
 g1VuOLJML8ER+sYQ6w1SgcleYmfN4VFa1MlLsfL1dRa7NSMaHGukeGXBkynFyRcYXSZfse1nx
 x+A3qo1lvydsBOOtthjc6m54Bpv9tYP1zsT4FdjCsgxRB122veYHCUltAAQ1DiMSFGD1+3lV+
 NAgNo0Pk3BT8C+RzBKcPURrCIvQHtWNlYmB5mv3fOLXrmNiTZc/MFQmur/Gd4ExFbyXsyxMyv
 3H9z+g/2mGm4Z5h9PpMcUEPhrRNpdQvHAZbRLOa5zkj/uRRHdZhuyOiyLhxUGSHfWodT6tUfm
 hxnyQ0abfmA6nkgyM3R9WtlLk+J+/6szjrKHtXTfbnOo7VlKGy7cqH/4f29PJMMuWAZv6ZaLi
 5ANrD+n+YrE+HXNttDMmcYPj7rnPSSBx+KI7sgFaN0FKnTTEbyH8kTYaKLLFG1k9zT+5SlncA
 0qB6Moowv9jTmXYjhvZQ3kjU2Cv1gsOOY9pptHHkvA1qxY5ZSSWsh4FCx7Wbu2zeJF9/DmizZ
 6itpcQ3SE7b8wWhOjBBxEYEMxoaBPUuyA==

This adds a helper for bpf programs to copy a user string
in a sleepable context (one that can page fault).

This matches the non-sleepable 'bpf_probe_read_user_str'.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 include/linux/bpf.h                           |  1 +
 include/uapi/linux/bpf.h                      | 22 +++++++++++++++++++
 kernel/bpf/helpers.c                          | 21 ++++++++++++++++++
 kernel/trace/bpf_trace.c                      |  2 ++
 tools/include/uapi/linux/bpf.h                | 22 +++++++++++++++++++
 .../selftests/bpf/prog_tests/attach_probe.c   |  2 ++
 .../selftests/bpf/prog_tests/read_vsyscall.c  |  1 +
 .../selftests/bpf/progs/read_vsyscall.c       |  3 ++-
 .../selftests/bpf/progs/test_attach_probe.c   | 17 ++++++++++++++
 9 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b9425e410bcb..15963f85c016 100644
=2D-- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3235,6 +3235,7 @@ extern const struct bpf_func_proto bpf_skc_to_udp6_s=
ock_proto;
 extern const struct bpf_func_proto bpf_skc_to_unix_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto;
 extern const struct bpf_func_proto bpf_copy_from_user_proto;
+extern const struct bpf_func_proto bpf_copy_from_user_str_proto;
 extern const struct bpf_func_proto bpf_snprintf_btf_proto;
 extern const struct bpf_func_proto bpf_snprintf_proto;
 extern const struct bpf_func_proto bpf_per_cpu_ptr_proto;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 35bcf52dbc65..ee94e6b55224 100644
=2D-- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4217,6 +4217,8 @@ union bpf_attr {
  * 		*current*\ **->mm->arg_start** and *current*\
  * 		**->mm->env_start**: using this helper and the return value,
  * 		one can quickly iterate at the right offset of the memory area.
+ *
+ *		For sleepable programs use **bpf_copy_from_user_str**\ ().
  * 	Return
  * 		On success, the strictly positive length of the output string,
  * 		including the trailing NUL character. On error, a negative
@@ -5792,6 +5794,25 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_copy_from_user_str(void *dst, u32 size, const void *user_ptr)
+ * 	Description
+ * 		Copy a NUL terminated string from an unsafe user address
+ * 		*unsafe_ptr* to *dst*. The *size* should include the
+ * 		terminating NUL byte. In case the string length is smaller than
+ * 		*size*, the target is not padded with further NUL bytes. If the
+ * 		string length is larger than *size*, just *size*-1 bytes are
+ * 		copied and the last byte is set to NUL.
+ *
+ * 		On success, returns the number of bytes that were written,
+ * 		including the terminal NUL. See **bpf_probe_read_user_str**\ () for
+ * 		examples of why this is better than **bpf_copy_from_user**\ ().
+ *
+ *		This helper can only be used by sleepable programs.
+ * 	Return
+ * 		On success, the strictly positive length of the output string,
+ * 		including the trailing NUL character. On error, a negative
+ * 		value.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -6006,6 +6027,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(copy_from_user_str, 212, ##ctx)		\
 	/* */

 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don=
't
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d02ae323996b..418c6a545d64 100644
=2D-- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -676,6 +676,27 @@ const struct bpf_func_proto bpf_copy_from_user_proto =
=3D {
 	.arg3_type	=3D ARG_ANYTHING,
 };

+BPF_CALL_3(bpf_copy_from_user_str, void *, dst, u32, size,
+	   const void __user *, user_ptr)
+{
+	int ret =3D strncpy_from_user(dst, user_ptr, size);
+
+	if (unlikely(ret < 0))
+		memset(dst, 0, size);
+
+	return ret;
+}
+
+const struct bpf_func_proto bpf_copy_from_user_str_proto =3D {
+	.func		=3D bpf_copy_from_user_str,
+	.gpl_only	=3D false,
+	.might_sleep	=3D true,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg2_type	=3D ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	=3D ARG_ANYTHING,
+};
+
 BPF_CALL_5(bpf_copy_from_user_task, void *, dst, u32, size,
 	   const void __user *, user_ptr, struct task_struct *, tsk, u64, flags)
 {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d557bb11e0ff..d890879b10b7 100644
=2D-- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1533,6 +1533,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, con=
st struct bpf_prog *prog)
 		return &bpf_get_task_stack_proto;
 	case BPF_FUNC_copy_from_user:
 		return &bpf_copy_from_user_proto;
+	case BPF_FUNC_copy_from_user_str:
+		return &bpf_copy_from_user_str_proto;
 	case BPF_FUNC_copy_from_user_task:
 		return &bpf_copy_from_user_task_proto;
 	case BPF_FUNC_snprintf_btf:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf=
.h
index 35bcf52dbc65..7cde1c21ef56 100644
=2D-- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4217,6 +4217,8 @@ union bpf_attr {
  * 		*current*\ **->mm->arg_start** and *current*\
  * 		**->mm->env_start**: using this helper and the return value,
  * 		one can quickly iterate at the right offset of the memory area.
+ *
+ *		For sleepable programs use **bpf_copy_from_user_str**\ ().
  * 	Return
  * 		On success, the strictly positive length of the output string,
  * 		including the trailing NUL character. On error, a negative
@@ -5792,6 +5794,25 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_copy_from_user_str(void *dst, u32 size, const void *user_ptr)
+ *	Description
+ *		Copy a NUL terminated string from an unsafe user address
+ *		*unsafe_ptr* to *dst*. The *size* should include the
+ *		terminating NUL byte. In case the string length is smaller than
+ *		*size*, the target is not padded with further NUL bytes. If the
+ *		string length is larger than *size*, just *size*-1 bytes are
+ *		copied and the last byte is set to NUL.
+ *
+ *		On success, returns the number of bytes that were written,
+ *		including the terminal NUL. See **bpf_probe_read_user_str**\ () for
+ *		examples of why this is better than **bpf_copy_from_user**\ ().
+ *
+ *		This helper can only be used by sleepable programs.
+ *	Return
+ *		On success, the strictly positive length of the output string,
+ *		including the trailing NUL character. On error, a negative
+ *		value.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -6006,6 +6027,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(copy_from_user_str, 212, ##ctx)		\
 	/* */

 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don=
't
diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools=
/testing/selftests/bpf/prog_tests/attach_probe.c
index 7175af39134f..6c0c047fd527 100644
=2D-- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -286,6 +286,8 @@ static void test_uprobe_sleepable(struct test_attach_p=
robe *skel)
 	ASSERT_EQ(skel->bss->uprobe_byname3_res, 10, "check_uprobe_byname3_res")=
;
 	ASSERT_EQ(skel->bss->uretprobe_byname3_sleepable_res, 11, "check_uretpro=
be_byname3_sleepable_res");
 	ASSERT_EQ(skel->bss->uretprobe_byname3_res, 12, "check_uretprobe_byname3=
_res");
+	ASSERT_EQ(skel->bss->uprobe_byname3_sleepable_res_str, 13, "check_uprobe=
_byname3_sleepable_res_str");
+	ASSERT_EQ(skel->bss->uretprobe_byname3_sleepable_res_str, 14, "check_ure=
tprobe_byname3_sleepable_res_str");
 }

 void test_attach_probe(void)
diff --git a/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c b/tool=
s/testing/selftests/bpf/prog_tests/read_vsyscall.c
index 3405923fe4e6..26bd927fb438 100644
=2D-- a/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
@@ -22,6 +22,7 @@ struct read_ret_desc {
 	{ .name =3D "probe_read_user", .ret =3D -EFAULT },
 	{ .name =3D "probe_read_user_str", .ret =3D -EFAULT },
 	{ .name =3D "copy_from_user", .ret =3D -EFAULT },
+	{ .name =3D "copy_from_user_str", .ret =3D -EFAULT },
 	{ .name =3D "copy_from_user_task", .ret =3D -EFAULT },
 };

diff --git a/tools/testing/selftests/bpf/progs/read_vsyscall.c b/tools/tes=
ting/selftests/bpf/progs/read_vsyscall.c
index 986f96687ae1..c601592c4660 100644
=2D-- a/tools/testing/selftests/bpf/progs/read_vsyscall.c
+++ b/tools/testing/selftests/bpf/progs/read_vsyscall.c
@@ -7,7 +7,7 @@

 int target_pid =3D 0;
 void *user_ptr =3D 0;
-int read_ret[8];
+int read_ret[9];

 char _license[] SEC("license") =3D "GPL";

@@ -40,6 +40,7 @@ int do_copy_from_user(void *ctx)
 	read_ret[6] =3D bpf_copy_from_user(buf, sizeof(buf), user_ptr);
 	read_ret[7] =3D bpf_copy_from_user_task(buf, sizeof(buf), user_ptr,
 					      bpf_get_current_task_btf(), 0);
+	read_ret[8] =3D bpf_copy_from_user_str(buf, sizeof(buf), user_ptr);

 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/test_attach_probe.c b/tools=
/testing/selftests/bpf/progs/test_attach_probe.c
index 68466a6ad18c..c6cefb2f916c 100644
=2D-- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
+++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
@@ -14,8 +14,10 @@ int uretprobe_byname_res =3D 0;
 int uprobe_byname2_res =3D 0;
 int uretprobe_byname2_res =3D 0;
 int uprobe_byname3_sleepable_res =3D 0;
+int uprobe_byname3_sleepable_res_str =3D 0;
 int uprobe_byname3_res =3D 0;
 int uretprobe_byname3_sleepable_res =3D 0;
+int uretprobe_byname3_sleepable_res_str =3D 0;
 int uretprobe_byname3_res =3D 0;
 void *user_ptr =3D 0;

@@ -87,11 +89,24 @@ static __always_inline bool verify_sleepable_user_copy=
(void)
 	return bpf_strncmp(data, sizeof(data), "test_data") =3D=3D 0;
 }

+static __always_inline bool verify_sleepable_user_str_copy(void)
+{
+	int ret;
+	char data[9];
+
+	ret =3D bpf_copy_from_user_str(data, sizeof(data), user_ptr);
+
+	return bpf_strncmp(data, sizeof(data), "test_data") =3D=3D 0 && ret =3D=
=3D 9;
+}
+
+
 SEC("uprobe.s//proc/self/exe:trigger_func3")
 int handle_uprobe_byname3_sleepable(struct pt_regs *ctx)
 {
 	if (verify_sleepable_user_copy())
 		uprobe_byname3_sleepable_res =3D 9;
+	if (verify_sleepable_user_str_copy())
+		uprobe_byname3_sleepable_res_str =3D 13;
 	return 0;
 }

@@ -111,6 +126,8 @@ int handle_uretprobe_byname3_sleepable(struct pt_regs =
*ctx)
 {
 	if (verify_sleepable_user_copy())
 		uretprobe_byname3_sleepable_res =3D 11;
+	if (verify_sleepable_user_str_copy())
+		uretprobe_byname3_sleepable_res_str =3D 14;
 	return 0;
 }

=2D-
2.43.5


