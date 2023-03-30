Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D167B6D08B5
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 16:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjC3OwL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 10:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjC3OwK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 10:52:10 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BF58A7B;
        Thu, 30 Mar 2023 07:52:08 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id n14so18660012qta.10;
        Thu, 30 Mar 2023 07:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680187927; x=1682779927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZYKdU7edcggf788yfZLdWl4nPAu93UTKZlfVfQz6qs=;
        b=6XV0z3nB2pOP2OTNQRoT/aYjiiC/Hqvhma5qewRtLM3nwcS0CNXIcdeX2ub3XK/KV2
         O85MU/8yRpNtr4DmHZgcfnwqlAwfG8hiVM3xVRfPupDYfjynSV5wadO70mA2hVF2pErY
         xS30DGBnEFffXhAr4Mll5MP1Y93RskOQHkeDBt5orKsBdle1AFyNU6TKGLef16b/jcld
         T3hbdITmHbh8/wTtiY1lj6QlSlOcCQprnavlgsuioTH+0aia+l9I3CXlalNyUiVhcKJG
         g2bK1eSpg+RGsM4V0cGxlxuOkZQ2G50qOZXmBX/8pQl9PmeuKbhQPu1nY87JsLt0iYL1
         lm7A==
X-Gm-Message-State: AO0yUKUT5mIdlT6L/acgai7rqDj6oZ9pSxuiKQuW3ZcM/ROQHaVMszyK
        57HJRP/UV/SOhzAZgpWjlnG8CJu1yHAfLGis
X-Google-Smtp-Source: AK7set9sAe+QCJglmayBw/dL9L3tcWOIWQy2pxPF9gTB0sEc+xfGPKoKyZpa9DYRCESi+9Ou5dkChw==
X-Received: by 2002:a05:622a:4c:b0:3e3:7d6d:f5 with SMTP id y12-20020a05622a004c00b003e37d6d00f5mr36619507qtw.29.1680187927141;
        Thu, 30 Mar 2023 07:52:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:d9ee])
        by smtp.gmail.com with ESMTPSA id h22-20020ac85056000000b003d5aae2182dsm9301250qtm.29.2023.03.30.07.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 07:52:06 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, memxor@gmail.com
Subject: [PATCH bpf-next 1/2] bpf: Handle PTR_MAYBE_NULL case in PTR_TO_BTF_ID helper call arg
Date:   Thu, 30 Mar 2023 09:52:02 -0500
Message-Id: <20230330145203.80506-1-void@manifault.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When validating a helper function argument, we use check_reg_type() to
ensure that the register containing the argument is of the correct type.
When the register's base type is PTR_TO_BTF_ID, there is some
supplemental logic where we do extra checks for various combinations of
PTR_TO_BTF_ID type modifiers. For example, for PTR_TO_BTF_ID,
PTR_TO_BTF_ID | PTR_TRUSTED, and PTR_TO_BTF_ID | MEM_RCU, we call
map_kptr_match_type() for bpf_kptr_xchg() calls, and
btf_struct_ids_match() for other helper calls.

When an unhandled PTR_TO_BTF_ID type modifier combination is passed to
check_reg_type(), the verifier fails with an internal verifier error
message. This can currently be triggered by passing a PTR_MAYBE_NULL
pointer to helper functions (currently just bpf_kptr_xchg()) with an
ARG_PTR_TO_BTF_ID_OR_NULL arg type. For example, by callin
bpf_kptr_xchg(&v->kptr, bpf_cpumask_create()).

Whether or not passing a PTR_MAYBE_NULL arg to an
ARG_PTR_TO_BTF_ID_OR_NULL argument is valid is an interesting question.
In a vacuum, it seems fine. A helper function with an
ARG_PTR_TO_BTF_ID_OR_NULL arg would seem to be implying that it can
handle either a NULL or non-NULL arg, and has logic in place to detect
and gracefully handle each. This is the case for bpf_kptr_xchg(), which
of course simply does an xchg(). On the other hand, bpf_kptr_xchg() also
specifies OBJ_RELEASE, and refcounting semantics for a PTR_MAYBE_NULL
pointer is different than handling it for a NULL _OR_ non-NULL pointer.
For example, with a non-NULL arg, we should always fail if there was not
a nonzero refcount for the value in the register being passed to the
helper. For PTR_MAYBE_NULL on the other hand, it's unclear. If the
pointer is NULL it would be fine, but if it's not NULL, it would be
incorrect to load the program.

The current solution to this is to just fail if PTR_MAYBE_NULL is
passed, and to instead require programs to have a NULL check to
explicitly handle the NULL and non-NULL cases. This seems reasonable.
Not only would it possibly be quite complicated to correctly handle
PTR_MAYBE_NULL refcounting in the verifier, but it's also an arguably
odd programming pattern in general to not explicitly handle the NULL
case anyways. For example, it seems odd to not care about whether a
pointer you're passing to bpf_kptr_xchg() was successfully allocated in
a program such as the following:

private(MASK) static struct bpf_cpumask __kptr * global_mask;

SEC("tp_btf/task_newtask")
int BPF_PROG(example, struct task_struct *task, u64 clone_flags)
{
        struct bpf_cpumask *prev;

	/* bpf_cpumask_create() returns PTR_MAYBE_NULL */
	prev = bpf_kptr_xchg(&global_mask, bpf_cpumask_create());
	if (prev)
		bpf_cpumask_release(prev);

	return 0;
}

This patch therefore updates the verifier to explicitly check for
PTR_MAYBE_NULL in check_reg_type(), and fail gracefully if it's
observed. This isn't really "fixing" anything unsafe or incorrect. We're
just updating the verifier to fail gracefully, and explicitly handle
this pattern rather than unintentionally falling back to an internal
verifier error path. A subsequent patch will update selftests.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 20eb2015842f..52738f9dcb15 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7204,6 +7204,10 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 		}
 		break;
 	}
+	case PTR_TO_BTF_ID | PTR_MAYBE_NULL:
+	case PTR_TO_BTF_ID | PTR_MAYBE_NULL | MEM_RCU:
+		verbose(env, "Possibly NULL pointer passed to helper arg%d\n", regno);
+		return -EACCES;
 	case PTR_TO_BTF_ID | MEM_ALLOC:
 		if (meta->func_id != BPF_FUNC_spin_lock && meta->func_id != BPF_FUNC_spin_unlock &&
 		    meta->func_id != BPF_FUNC_kptr_xchg) {
-- 
2.39.0

