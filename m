Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664032F695B
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 19:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbhANSUJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 13:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbhANSTa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 13:19:30 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB95C061798
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 10:18:18 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id r5so2193976wma.2
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 10:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fUuyMVv5zUjRbWSI86/K8i8mxU4aDwFKnpIfaPRRyd0=;
        b=UxKmx5GKbSUh2YzKDNgLB+yoQc0VYtJXqfXrEJvBaORIrIwrD7P/C7L8B4HuMSCHjw
         1QdUiERxokUmKAWJtx87gAUZa534PT32Kf5GigRCtc75hal3MQuTeczSbG6M2mlY074x
         ecOL4I6dexen0dApNr4AIxEzFo/8BgLRzN5quXgBDmD16SjhSKo6/2C3ASiICnJdV3oR
         BGcIZWYYbVIelQPeYdgjVSKKO5o4AMiPHwj6MxO45/iilBN3QR4pafJH+P1MD1ckxc+E
         cvRj9zD0IJg1Ow78mSdxb1/zPfh1dp0z8yBF5uHc9VxgI2zxVBYppAOgehzgVNpZIBat
         S83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fUuyMVv5zUjRbWSI86/K8i8mxU4aDwFKnpIfaPRRyd0=;
        b=Xa4ihj0eo7nRrK3IbozpIzH+ZLF4jXOGyLUSJNkYNygcEagTbidqobU9wwm50MnHOz
         G4ngQrxoPED3icj16Zz0w1bFa8lI0L9uTvRc+kg7lqbPJdly29ilks5a6OVo5+0xUIKH
         i+9dO0kDqhTMJHMl9ZlBD8YYK9RMf0DtsWcpsf3whVNxzbTVH6FtsmDN3RCfnEM4FLgv
         SqunPnOSkeUBHGvIbIGfEA8BVgtcjedr5XmoPDGiA49YpbvVtO/NHiLXUNHXDfuDMzx/
         XigqEGdfB4+cDo7SfP1k9n9NRrZA7CGLwTWEzBWtCxZswO0ecBrl8+nCbFjfafG3pZRV
         ezsw==
X-Gm-Message-State: AOAM531dhFGswGQFc4EGhkNCINUQCnkptGW1Ifj0k7WKdrpV6vVEIhLR
        +WKgGOguifgUkfEQDVo/lNMUDqP7dKauDxL72zWAodsKiyL4qIP1UqiHm9YY8aRcum80sQGgFw9
        QWATGSDxEGyP8RDbyDFILsZgiD7PHKZC5KSK3a5Xylk6NVbU+Qj+u+w9xJPweB/E=
X-Google-Smtp-Source: ABdhPJwBnKwc9l7iO1D5wc3fCsMaQZXd3zZsVAOysCDpB5aD30UwBvcD4pK3yC5lvC0jt29BUrAlzL6iMu98Xw==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:b78a:: with SMTP id
 h132mr5017956wmf.141.1610648296771; Thu, 14 Jan 2021 10:18:16 -0800 (PST)
Date:   Thu, 14 Jan 2021 18:17:45 +0000
In-Reply-To: <20210114181751.768687-1-jackmanb@google.com>
Message-Id: <20210114181751.768687-6-jackmanb@google.com>
Mime-Version: 1.0
References: <20210114181751.768687-1-jackmanb@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v7 05/11] bpf: Move BPF_STX reserved field check into
 BPF_STX verifier code
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn.topel@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I can't find a reason why this code is in resolve_pseudo_ldimm64;
since I'll be modifying it in a subsequent commit, tidy it up.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 kernel/bpf/verifier.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cfc137b81ac6..d8a85f4e5b95 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9528,6 +9528,12 @@ static int do_check(struct bpf_verifier_env *env)
 		} else if (class == BPF_STX) {
 			enum bpf_reg_type *prev_dst_type, dst_reg_type;
 
+			if (((BPF_MODE(insn->code) != BPF_MEM &&
+			      BPF_MODE(insn->code) != BPF_ATOMIC) || insn->imm != 0)) {
+				verbose(env, "BPF_STX uses reserved fields\n");
+				return -EINVAL;
+			}
+
 			if (BPF_MODE(insn->code) == BPF_ATOMIC) {
 				err = check_atomic(env, env->insn_idx, insn);
 				if (err)
@@ -10012,13 +10018,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			return -EINVAL;
 		}
 
-		if (BPF_CLASS(insn->code) == BPF_STX &&
-		    ((BPF_MODE(insn->code) != BPF_MEM &&
-		      BPF_MODE(insn->code) != BPF_ATOMIC) || insn->imm != 0)) {
-			verbose(env, "BPF_STX uses reserved fields\n");
-			return -EINVAL;
-		}
-
 		if (insn[0].code == (BPF_LD | BPF_IMM | BPF_DW)) {
 			struct bpf_insn_aux_data *aux;
 			struct bpf_map *map;
-- 
2.30.0.284.gd98b1dd5eaa7-goog

