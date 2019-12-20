Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D178127FA1
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 16:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfLTPmg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 10:42:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51493 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbfLTPmR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 10:42:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id d73so9395243wmd.1
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2019 07:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CYWJ2URo8mjs0x8nMZWhI4jpk+MpL4wZVs4eBeXrsUE=;
        b=gaLV8RaqsIk6PcheutwFOcwCTJTOq+9pY0YnqLS9Xr93Q6kmHhWykg7wh6QBTREgG/
         Q1ZxTakEI+XXkWBgO3FP19dUWHEKr00AV9goO9XBHAvtb52oMkP4GoZrjJwGS8BGgFji
         h9oePflZ4Ps1KAlC+m+cMvbA0ELtIGKOq+cys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CYWJ2URo8mjs0x8nMZWhI4jpk+MpL4wZVs4eBeXrsUE=;
        b=X2INZwej6z1i5zVjoXjJOa5ER1nVGsid/5IKYS0j5eOz6Yw9yFsfNBvdom01C1YEmI
         xPD9SbdiUQ2lzAN8CnX5Abyk+nAHgcVSPq+puZAq5fBg0kUbZQ774QhS5mYPRqzWyXNz
         0rPgOBdibciD6CLJIYNkeXNmoc8z90xBoIetuclhEg3ST13gGEIcgDasFkJvDfEpdStT
         hqqUPjFssv9QJT7Z4a2h/7LeHGdc+VU0YsWkFPeQElBP697wH4loRdFanGiWTSPEjDwr
         +r9JFOxThUkNEcfMu8JUCprjaeU/o5+veiJI0+XKsNgLViGYRK7A+6X2q8ghEmF14Op/
         pa/Q==
X-Gm-Message-State: APjAAAWC6uHWzothlJsCNuW74CU6/1eeryw21zCymAi9UKtO8KLOBkaF
        6hnGgiftR5+O0hVQ7PnRexrTJg==
X-Google-Smtp-Source: APXvYqxza4vYJuCwfGbOtBIg2+UIbNuLIe8LlwTs049KCCz0BjChZd60j+gUte33pdPrBrNKcZPDLg==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr10365683wmk.59.1576856535130;
        Fri, 20 Dec 2019 07:42:15 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:308:c46b:b838:66cf:6204])
        by smtp.gmail.com with ESMTPSA id x11sm10118062wmg.46.2019.12.20.07.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:42:14 -0800 (PST)
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
        Brendan Jackman <jackmanb@chromium.org>,
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
Subject: [PATCH bpf-next v1 09/13] bpf: lsm: Add a helper function bpf_lsm_event_output
Date:   Fri, 20 Dec 2019 16:42:04 +0100
Message-Id: <20191220154208.15895-10-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220154208.15895-1-kpsingh@chromium.org>
References: <20191220154208.15895-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

This helper is similar to bpf_perf_event_output except that
it does need a ctx argument which is more usable in the
BTF based LSM programs where the context is converted to
the signature of the attacthed BTF type.

An example usage of this function would be:

struct {
         __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
         __uint(key_size, sizeof(int));
         __uint(value_size, sizeof(u32));
} perf_map SEC(".maps");

BPF_TRACE_1(bpf_prog1, "lsm/bprm_check_security,
	    struct linux_binprm *, bprm)
{
	char buf[BUF_SIZE];
	int len;
	u64 flags = BPF_F_CURRENT_CPU;

	/* some logic that fills up buf with len data */
	len = fill_up_buf(buf);
	if (len < 0)
		return len;
	if (len > BU)
		return 0;

	bpf_lsm_event_output(&perf_map, flags, buf, len);
	return 0;
}

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/uapi/linux/bpf.h       | 10 +++++++++-
 kernel/bpf/verifier.c          |  1 +
 security/bpf/ops.c             | 21 +++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 10 +++++++++-
 4 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index fc64ae865526..3511fa271c9b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2823,6 +2823,13 @@ union bpf_attr {
  * 	Return
  * 		On success, the strictly positive length of the string,	including
  * 		the trailing NUL character. On error, a negative value.
+ *
+ * int bpf_lsm_event_output(struct bpf_map *map, u64 flags, void *data, u64 size)
+ *	Description
+ *		This helper is similar to bpf_perf_event_output except that it
+ *		it does not need a context argument.
+ *	Return
+ *		0 on success, or a negative error in case of failure.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2940,7 +2947,8 @@ union bpf_attr {
 	FN(probe_read_user),		\
 	FN(probe_read_kernel),		\
 	FN(probe_read_user_str),	\
-	FN(probe_read_kernel_str),
+	FN(probe_read_kernel_str),	\
+	FN(lsm_event_output),		\
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0d1231d9c1ef..ff050fd71e9f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3641,6 +3641,7 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		if (func_id != BPF_FUNC_perf_event_read &&
 		    func_id != BPF_FUNC_perf_event_output &&
 		    func_id != BPF_FUNC_skb_output &&
+		    func_id != BPF_FUNC_lsm_event_output &&
 		    func_id != BPF_FUNC_perf_event_read_value)
 			goto error;
 		break;
diff --git a/security/bpf/ops.c b/security/bpf/ops.c
index eb8a8db28109..e9aae2ce718c 100644
--- a/security/bpf/ops.c
+++ b/security/bpf/ops.c
@@ -129,6 +129,25 @@ int bpf_lsm_detach(const union bpf_attr *attr)
 const struct bpf_prog_ops lsm_prog_ops = {
 };
 
+BPF_CALL_4(bpf_lsm_event_output,
+	   struct bpf_map *, map, u64, flags, void *, data, u64, size)
+{
+	if (unlikely(flags & ~(BPF_F_INDEX_MASK)))
+		return -EINVAL;
+
+	return bpf_event_output(map, flags, data, size, NULL, 0, NULL);
+}
+
+static const struct bpf_func_proto bpf_lsm_event_output_proto =  {
+	.func		= bpf_lsm_event_output,
+	.gpl_only       = true,
+	.ret_type       = RET_INTEGER,
+	.arg1_type      = ARG_CONST_MAP_PTR,
+	.arg2_type      = ARG_ANYTHING,
+	.arg3_type      = ARG_PTR_TO_MEM,
+	.arg4_type      = ARG_CONST_SIZE_OR_ZERO,
+};
+
 static const struct bpf_func_proto *get_bpf_func_proto(enum bpf_func_id
 		func_id, const struct bpf_prog *prog)
 {
@@ -137,6 +156,8 @@ static const struct bpf_func_proto *get_bpf_func_proto(enum bpf_func_id
 		return &bpf_map_lookup_elem_proto;
 	case BPF_FUNC_get_current_pid_tgid:
 		return &bpf_get_current_pid_tgid_proto;
+	case BPF_FUNC_lsm_event_output:
+		return &bpf_lsm_event_output_proto;
 	default:
 		return NULL;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index fc64ae865526..3511fa271c9b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2823,6 +2823,13 @@ union bpf_attr {
  * 	Return
  * 		On success, the strictly positive length of the string,	including
  * 		the trailing NUL character. On error, a negative value.
+ *
+ * int bpf_lsm_event_output(struct bpf_map *map, u64 flags, void *data, u64 size)
+ *	Description
+ *		This helper is similar to bpf_perf_event_output except that it
+ *		it does not need a context argument.
+ *	Return
+ *		0 on success, or a negative error in case of failure.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2940,7 +2947,8 @@ union bpf_attr {
 	FN(probe_read_user),		\
 	FN(probe_read_kernel),		\
 	FN(probe_read_user_str),	\
-	FN(probe_read_kernel_str),
+	FN(probe_read_kernel_str),	\
+	FN(lsm_event_output),		\
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
-- 
2.20.1

