Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD4AAE9C8
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2019 13:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfIJL5O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Sep 2019 07:57:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35656 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390926AbfIJL4q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Sep 2019 07:56:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id g7so19677641wrx.2
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2019 04:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YfOGR22A4l38lkUXccDczpuDVTPqgcNTsRkizO9Fy14=;
        b=HWPU3GzU3QVDWGFcOkzkKogiWC5zNxa38kUeFlNO9Kv0qUPHCTbSerropijK0SpZSN
         K/tSAc/9Oz+hLKCio0IEWK860DNV+gZDHBlDbqUjgdz4U7Db7F2HtGcT0V4b5XbfHCw6
         a0n8yMrG4npPrn6SWvm2vaGruTF3DZBFh4q1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YfOGR22A4l38lkUXccDczpuDVTPqgcNTsRkizO9Fy14=;
        b=NvpsmnVE6dXUGWom0jyXtH6/dJmeHUig+QYJAnaB+HWvy9DA89NmV2wD1u7xW2Fwfe
         7PI1rNFzInSVz1aMZdLWbg6Hj2t9zvTcqZutXDoyYle/ONjERnU45VnFxDIQMocV2CnN
         rfZjFFQRoBm2mRClL6caFpmgwMd9xdsBJNSR1g5zjjKGduQc9jRSLuvAXh+PUZFWc49E
         Z971HNn2wFp6UXW7GLeL1LjRPYkApTT+6b+v91hHCVUepYdazm0GCNH13K6pFmsNj6yW
         hK2alxuQVJcWt2iSU5lLJZ4lBUgRVa7V5xF2KRfuGkgat9IKwtKgY4jfzgnNcxMgKj4a
         9bSA==
X-Gm-Message-State: APjAAAVOZi9mpcekgJ89zg+BDNwclzLjXn8cT/zFLvD/UTExO7Nv0ZTD
        nv+xul4yBc3/xtF/+PUce5v2CQ==
X-Google-Smtp-Source: APXvYqwBvCNY+UARdEFe9ujlmg+pek1+2O0NHRq9kph8SAZQWqBrnPDrZyO43r/LIcfKjWSRpLGvmw==
X-Received: by 2002:adf:e48f:: with SMTP id i15mr2910963wrm.26.1568116604037;
        Tue, 10 Sep 2019 04:56:44 -0700 (PDT)
Received: from kpsingh-kernel.c.hoisthospitality.com (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id q19sm23732935wra.89.2019.09.10.04.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 04:56:43 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [RFC v1 12/14] krsi: Add an eBPF helper function to get the value of an env variable
Date:   Tue, 10 Sep 2019 13:55:25 +0200
Message-Id: <20190910115527.5235-13-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910115527.5235-1-kpsingh@chromium.org>
References: <20190910115527.5235-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

The helper returns the value of the environment variable in the buffer
that is passed to it. If the var is set multiple times, the helper
returns all the values as null separated strings.

If the buffer is too short for these values, the helper tries to fill it
the best it can and guarantees that the value returned in the buffer
is always null terminated. After the buffer is filled, the helper keeps
counting the number of times the environment variable is set in the
envp.

The return value of the helper is an u64 value which carries two pieces
of information.

  * The upper 32 bits are a u32 value signifying the number of times
    the environment variable is set in the envp.
  * The lower 32 bits are a s32 value signifying the number of bytes
    written to the buffer or an error code.

Since the value of the environment variable can be very long and exceed
what can be allocated on the BPF stack, a per-cpu array can be used
instead:

struct bpf_map_def SEC("maps") env_map = {
        .type = BPF_MAP_TYPE_PERCPU_ARRAY,
        .key_size = sizeof(u32),
        .value_size = 4096,
        .max_entries = 1,
};

SEC("prgrm")
int bpf_prog1(void *ctx)
{
        u32 map_id = 0;
        u64 times_ret;
        s32 ret;
        char name[48] = "LD_PRELOAD";

        char *map_value = bpf_map_lookup_elem(&env_map, &map_id);
        if (!map_value)
                return 0;

        // Read the lower 32 bits for the return value
        times_ret = krsi_get_env_var(ctx, name, 48, map_value, 4096);
        ret = times_ret & 0xffffffff;
        if (ret < 0)
                return ret;
        return 0;
}

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/uapi/linux/bpf.h                  |  42 ++++++-
 security/krsi/ops.c                       | 129 ++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h            |  42 ++++++-
 tools/testing/selftests/bpf/bpf_helpers.h |   3 +
 4 files changed, 214 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 32ab38f1a2fe..a4ef07956e07 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2715,6 +2715,45 @@ union bpf_attr {
  *		**-EPERM** if no permission to send the *sig*.
  *
  *		**-EAGAIN** if bpf program can try again.
+ *
+ * u64 krsi_get_env_var(void *ctx, char *name, char *buf,
+ *			size_t name_len, size_t buf_len)
+ *	Description
+ *		This helper can be used as a part of the
+ *		process_execution hook of the KRSI LSM in
+ *		programs of type BPF_PROG_TYPE_KRSI.
+ *
+ *		The helper returns the value of the environment
+ *		variable with the provided "name" for process that's
+ *		going to be executed in the passed buffer, "buf". If the var
+ *		is set multiple times, the helper returns all
+ *		the values as null separated strings.
+ *
+ *		If the buffer is too short for these values, the helper
+ *		tries to fill it the best it can and guarantees that the value
+ *		returned in the buffer  is always null terminated.
+ *		After the buffer is filled, the helper keeps counting the number
+ *		of times the environment variable is set in the envp.
+ *
+ *	Return:
+ *
+ *		The return value of the helper is an u64 value
+ *		which carries two pieces of information:
+ *
+ *		   The upper 32 bits are a u32 value signifying
+ *		   the number of times the environment variable
+ *		   is set in the envp.
+ *		   The lower 32 bits are an s32 value signifying
+ *		   the number of bytes written to the buffer or an error code:
+ *
+ *		**-ENOMEM** if the kernel is unable to allocate memory
+ *			    for pinning the argv and envv.
+ *
+ *		**-E2BIG** if the value is larger than the size of the
+ *			   destination buffer. The higher bits will still
+ *			   the number of times the variable was set in the envp.
+ *
+ *		**-EINVAL** if name is not a NULL terminated string.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2826,7 +2865,8 @@ union bpf_attr {
 	FN(strtoul),			\
 	FN(sk_storage_get),		\
 	FN(sk_storage_delete),		\
-	FN(send_signal),
+	FN(send_signal),		\
+	FN(krsi_get_env_var),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
diff --git a/security/krsi/ops.c b/security/krsi/ops.c
index 1f4df920139c..1db94dfaac15 100644
--- a/security/krsi/ops.c
+++ b/security/krsi/ops.c
@@ -6,6 +6,8 @@
 #include <linux/bpf.h>
 #include <linux/security.h>
 #include <linux/krsi.h>
+#include <linux/binfmts.h>
+#include <linux/highmem.h>
 
 #include "krsi_init.h"
 #include "krsi_fs.h"
@@ -162,6 +164,131 @@ static bool krsi_prog_is_valid_access(int off, int size,
 	return false;
 }
 
+static char *array_next_entry(char *array, unsigned long *offset,
+			      unsigned long end)
+{
+	char *entry;
+	unsigned long current_offset = *offset;
+
+	if (current_offset >= end)
+		return NULL;
+
+	/*
+	 * iterate on the array till the null byte is encountered
+	 * and check for any overflows.
+	 */
+	entry = array + current_offset;
+	while (array[current_offset]) {
+		if (unlikely(++current_offset >= end))
+			return NULL;
+	}
+
+	/*
+	 * Point the offset to the next element in the array.
+	 */
+	*offset = current_offset + 1;
+
+	return entry;
+}
+
+static u64 get_env_var(struct krsi_ctx *ctx, char *name, char *dest,
+		u32 n_size, u32 size)
+{
+	s32 ret = 0;
+	u32 num_vars = 0;
+	int i, name_len;
+	struct linux_binprm *bprm = ctx->bprm_ctx.bprm;
+	int argc = bprm->argc;
+	int envc = bprm->envc;
+	unsigned long end = ctx->bprm_ctx.max_arg_offset;
+	unsigned long offset = bprm->p % PAGE_SIZE;
+	char *buf = ctx->bprm_ctx.arg_pages;
+	char *curr_dest = dest;
+	char *entry;
+
+	if (unlikely(!buf))
+		return -ENOMEM;
+
+	for (i = 0; i < argc; i++) {
+		entry = array_next_entry(buf, &offset, end);
+		if (!entry)
+			return 0;
+	}
+
+	name_len = strlen(name);
+	for (i = 0; i < envc; i++) {
+		entry = array_next_entry(buf, &offset, end);
+		if (!entry)
+			return 0;
+
+		if (!strncmp(entry, name, name_len)) {
+			num_vars++;
+
+			/*
+			 * There is no need to do further copying
+			 * if the buffer is already full. Just count how many
+			 * times the environment variable is set.
+			 */
+			if (ret == -E2BIG)
+				continue;
+
+			if (entry[name_len] != '=')
+				continue;
+
+			/*
+			 * Move the buf pointer by name_len + 1
+			 * (for the "=" sign)
+			 */
+			entry += name_len + 1;
+			ret = strlcpy(curr_dest, entry, size);
+
+			if (ret >= size) {
+				ret = -E2BIG;
+				continue;
+			}
+
+			/*
+			 * strlcpy just returns the length of the string copied.
+			 * The remaining space needs to account for the added
+			 * null character.
+			 */
+			curr_dest += ret + 1;
+			size -= ret + 1;
+			/*
+			 * Update ret to be the current number of bytes written
+			 * to the destination
+			 */
+			ret = curr_dest - dest;
+		}
+	}
+
+	return (u64) num_vars << 32 | (u32) ret;
+}
+
+BPF_CALL_5(krsi_get_env_var, struct krsi_ctx *, ctx, char *, name, u32, n_size,
+	  char *, dest, u32, size)
+{
+	char *name_end;
+
+	name_end = memchr(name, '\0', n_size);
+	if (!name_end)
+		return -EINVAL;
+
+	memset(dest, 0, size);
+	return get_env_var(ctx, name, dest, n_size, size);
+}
+
+static const struct bpf_func_proto krsi_get_env_var_proto = {
+	.func = krsi_get_env_var,
+	.gpl_only = true,
+	.ret_type = RET_INTEGER,
+	.arg1_type = ARG_PTR_TO_CTX,
+	.arg2_type = ARG_PTR_TO_MEM,
+	.arg3_type = ARG_CONST_SIZE_OR_ZERO,
+	.arg4_type = ARG_PTR_TO_UNINIT_MEM,
+	.arg5_type = ARG_CONST_SIZE_OR_ZERO,
+};
+
 BPF_CALL_5(krsi_event_output, void *, log,
 	   struct bpf_map *, map, u64, flags, void *, data, u64, size)
 {
@@ -192,6 +319,8 @@ static const struct bpf_func_proto *krsi_prog_func_proto(enum bpf_func_id
 		return &bpf_map_lookup_elem_proto;
 	case BPF_FUNC_get_current_pid_tgid:
 		return &bpf_get_current_pid_tgid_proto;
+	case BPF_FUNC_krsi_get_env_var:
+		return &krsi_get_env_var_proto;
 	case BPF_FUNC_perf_event_output:
 		return &krsi_event_output_proto;
 	default:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 32ab38f1a2fe..a4ef07956e07 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2715,6 +2715,45 @@ union bpf_attr {
  *		**-EPERM** if no permission to send the *sig*.
  *
  *		**-EAGAIN** if bpf program can try again.
+ *
+ * u64 krsi_get_env_var(void *ctx, char *name, char *buf,
+ *			size_t name_len, size_t buf_len)
+ *	Description
+ *		This helper can be used as a part of the
+ *		process_execution hook of the KRSI LSM in
+ *		programs of type BPF_PROG_TYPE_KRSI.
+ *
+ *		The helper returns the value of the environment
+ *		variable with the provided "name" for process that's
+ *		going to be executed in the passed buffer, "buf". If the var
+ *		is set multiple times, the helper returns all
+ *		the values as null separated strings.
+ *
+ *		If the buffer is too short for these values, the helper
+ *		tries to fill it the best it can and guarantees that the value
+ *		returned in the buffer  is always null terminated.
+ *		After the buffer is filled, the helper keeps counting the number
+ *		of times the environment variable is set in the envp.
+ *
+ *	Return:
+ *
+ *		The return value of the helper is an u64 value
+ *		which carries two pieces of information:
+ *
+ *		   The upper 32 bits are a u32 value signifying
+ *		   the number of times the environment variable
+ *		   is set in the envp.
+ *		   The lower 32 bits are an s32 value signifying
+ *		   the number of bytes written to the buffer or an error code:
+ *
+ *		**-ENOMEM** if the kernel is unable to allocate memory
+ *			    for pinning the argv and envv.
+ *
+ *		**-E2BIG** if the value is larger than the size of the
+ *			   destination buffer. The higher bits will still
+ *			   the number of times the variable was set in the envp.
+ *
+ *		**-EINVAL** if name is not a NULL terminated string.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2826,7 +2865,8 @@ union bpf_attr {
 	FN(strtoul),			\
 	FN(sk_storage_get),		\
 	FN(sk_storage_delete),		\
-	FN(send_signal),
+	FN(send_signal),		\
+	FN(krsi_get_env_var),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
index f804f210244e..ecebdb772a9d 100644
--- a/tools/testing/selftests/bpf/bpf_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_helpers.h
@@ -303,6 +303,9 @@ static int (*bpf_get_numa_node_id)(void) =
 static int (*bpf_probe_read_str)(void *ctx, __u32 size,
 				 const void *unsafe_ptr) =
 	(void *) BPF_FUNC_probe_read_str;
+static unsigned long long (*krsi_get_env_var)(void *ctx,
+	void *name, __u32 n_size, void *buf, __u32 size) =
+	(void *) BPF_FUNC_krsi_get_env_var;
 static unsigned int (*bpf_get_socket_uid)(void *ctx) =
 	(void *) BPF_FUNC_get_socket_uid;
 static unsigned int (*bpf_set_hash)(void *ctx, __u32 hash) =
-- 
2.20.1

