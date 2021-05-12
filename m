Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E1B37EF36
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 01:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbhELW74 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 18:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345785AbhELVoA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 17:44:00 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF6FC08C5CB
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:19 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c13so6267953pfv.4
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i2IYG8EW9hvtHL7j1SorOuzsq3cQ3EMooNko0bSzuhU=;
        b=d1tsdYyqhPXAAT4g877jcDlJjdnBbmktNl/IRjZM9jChNeDM1avNbepU6/bjQ7A5Zy
         CdS4Dko9M0lEOe1trxUSprLEzcUDPvq+uvoqOzAxHbuY/pUk+LhWiMJH9e/Gx4iJdIXd
         vsWFh85Tkpy/EUapyC+U2rD+vtnF/Fkb+WinPKT77jyp4jlPP+OpgRi1is9K7Myk+ICm
         2w6NF1XvKPxV0UMzHbyhwPQFnGSW3dLcXiTIHOASLQdwmMdF6rUuGw6PSSauxC5OFwV3
         159sF2zu03V7M/i8GtN+aTADlaSj1CzK+SV5vDieGeUPL9fPRtIikq+3TSccMbM/PLt5
         zeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i2IYG8EW9hvtHL7j1SorOuzsq3cQ3EMooNko0bSzuhU=;
        b=mL3xNi9Kk22UA2jYiO56Yw7s+eTyN4cIsGhpXGdLc111TauaXxn70lBnPHoF6/nwSK
         5eH39Q0xtrUb2EDms4JvSiu6rNop9QktSn3rrRcMMbU6Fk+wOgc93A49qLug4uzJjhQ6
         zrl1BUuV8pkjxSNWXGXVpjUM2xb4BJUrrPkwTZvWTwzv7Zk94Dk7vk8uDEF0U8SjTyMw
         I9eXdHiGVcMeI02mN9IhDHDsJUtA/Lg/m5JSMmXO11xV+7rosD0oMbMOThmhnuEKOh6v
         w4/YZPy2DG0GLvkpMFQlw2L9yfCrm6EWw6ZfXub5vlkDYKi/aUko+ReZyX7sYIhvsBVR
         EzxA==
X-Gm-Message-State: AOAM5335O7aXT86o2Hn0UtIRY+b9bjKKLjwOadgGU2Q9XOMkP8tFF0u6
        ITHDJkC93PbVEmSRsj4cBok=
X-Google-Smtp-Source: ABdhPJxv9HunW3HCUZ0Aiick+sIxW2o63NurGsjXse1gvgBZik1lXl7ZdKICZjX+q/M2BDwAUyLo/A==
X-Received: by 2002:aa7:848f:0:b029:28f:916b:a220 with SMTP id u15-20020aa7848f0000b029028f916ba220mr38417358pfn.10.1620855198923;
        Wed, 12 May 2021 14:33:18 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id c128sm609222pfa.189.2021.05.12.14.33.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 May 2021 14:33:18 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 10/21] bpf: Add bpf_sys_close() helper.
Date:   Wed, 12 May 2021 14:32:45 -0700
Message-Id: <20210512213256.31203-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
References: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add bpf_sys_close() helper to be used by the syscall/loader program to close
intermediate FDs and other cleanup.
Note this helper must never be allowed inside fdget/fdput bracketing.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/uapi/linux/bpf.h       |  7 +++++++
 kernel/bpf/syscall.c           | 19 +++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 3 files changed, 33 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 3cc07351c1cf..4cd9a0181f27 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4754,6 +4754,12 @@ union bpf_attr {
  * 		Find BTF type with given name and kind in vmlinux BTF or in module's BTFs.
  * 	Return
  * 		Returns btf_id and btf_obj_fd in lower and upper 32 bits.
+ *
+ * long bpf_sys_close(u32 fd)
+ * 	Description
+ * 		Execute close syscall for given FD.
+ * 	Return
+ * 		A syscall result.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -4924,6 +4930,7 @@ union bpf_attr {
 	FN(snprintf),			\
 	FN(sys_bpf),			\
 	FN(btf_find_by_name_kind),	\
+	FN(sys_close),			\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f93ff2ebf96d..0f1ce2171f1e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4578,6 +4578,23 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	return bpf_base_func_proto(func_id);
 }
 
+BPF_CALL_1(bpf_sys_close, u32, fd)
+{
+	/* When bpf program calls this helper there should not be
+	 * an fdget() without matching completed fdput().
+	 * This helper is allowed in the following callchain only:
+	 * sys_bpf->prog_test_run->bpf_prog->bpf_sys_close
+	 */
+	return close_fd(fd);
+}
+
+const struct bpf_func_proto bpf_sys_close_proto = {
+	.func		= bpf_sys_close,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_ANYTHING,
+};
+
 static const struct bpf_func_proto *
 syscall_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -4586,6 +4603,8 @@ syscall_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sys_bpf_proto;
 	case BPF_FUNC_btf_find_by_name_kind:
 		return &bpf_btf_find_by_name_kind_proto;
+	case BPF_FUNC_sys_close:
+		return &bpf_sys_close_proto;
 	default:
 		return tracing_prog_func_proto(func_id, prog);
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 3cc07351c1cf..4cd9a0181f27 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4754,6 +4754,12 @@ union bpf_attr {
  * 		Find BTF type with given name and kind in vmlinux BTF or in module's BTFs.
  * 	Return
  * 		Returns btf_id and btf_obj_fd in lower and upper 32 bits.
+ *
+ * long bpf_sys_close(u32 fd)
+ * 	Description
+ * 		Execute close syscall for given FD.
+ * 	Return
+ * 		A syscall result.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -4924,6 +4930,7 @@ union bpf_attr {
 	FN(snprintf),			\
 	FN(sys_bpf),			\
 	FN(btf_find_by_name_kind),	\
+	FN(sys_close),			\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.30.2

