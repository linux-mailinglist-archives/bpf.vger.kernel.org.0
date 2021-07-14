Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09DF3C81F3
	for <lists+bpf@lfdr.de>; Wed, 14 Jul 2021 11:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238966AbhGNJrf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 05:47:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238189AbhGNJrc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Jul 2021 05:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626255880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=onwZSv1Gm5ECjGOwSW4DJSwBbehKx10mVnDmGzm070k=;
        b=Cx70hRaH0mv95wXQLj7Il+5zHfT7lVCBqXyCRT0IhQI9Q09azg2UOuvq5m9yhL0Xy2FWZc
        uzzwJcsut2f/eFQAXGjBOC1vTWl3yAK0kXlkWTPiAHUot8D1TWQXc7I68uja3oSSlQwBeK
        80vQBw2QpwnEBB88GKhlU+z0s6zndPU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-aZtmLjkbNv65TB8X2_JnlQ-1; Wed, 14 Jul 2021 05:44:37 -0400
X-MC-Unique: aZtmLjkbNv65TB8X2_JnlQ-1
Received: by mail-wr1-f69.google.com with SMTP id 32-20020adf82a30000b029013b21c75294so1203287wrc.14
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 02:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=onwZSv1Gm5ECjGOwSW4DJSwBbehKx10mVnDmGzm070k=;
        b=KztxMKxCLIagvWC717iCxHhp+uqoR15D68kQ1y/NX8IiHPy+gPKhrqHFZ8cig6xdwZ
         t84YbsIihEGSdBNDoPS0aFGqdM7Os34aP6DzLZA0b4AE0n66estQSzQDJO9qa+/DIoNO
         2a0hNBbGH8dsv+qCGO1RPVbrgc67zy1WYFkhohe4LHhax1waUbGGKywW9NAFQueMTFX3
         +TiSfopcBM49uL1x5plmyjAF4sSvHb9eVSytqf0JegsRnoMLdU81lnFA6aKAIGdiHvuV
         AwJLCdFK26Pe6Q5zQDnTh7Y6/NQaoKBZhpgv9kQEU/1CZ6VDeHiQxkYPzDtreFKkKMhH
         SBqw==
X-Gm-Message-State: AOAM531KjXFmHT/lDMCQeHIf2qd5PO/OqwZsP2s8TqNjAGp7kFTYb1sK
        cP1D8PrmyQGvx8+iAGIsBCpseU+rc2devuKG1k6MWmuK5/EZa/qH1oenqjpxVVKyxPo/CQoy6HE
        Zm9QEY28/Mw82
X-Received: by 2002:a7b:ca43:: with SMTP id m3mr10071497wml.74.1626255876117;
        Wed, 14 Jul 2021 02:44:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZLzYFJUVgvmfR7kLuWngd5KlZkneeiRF9AalFugBgeOOC7+/dgr0yJmi1hXaj4rNp29qerQ==
X-Received: by 2002:a7b:ca43:: with SMTP id m3mr10071480wml.74.1626255875882;
        Wed, 14 Jul 2021 02:44:35 -0700 (PDT)
Received: from krava.redhat.com ([5.171.203.6])
        by smtp.gmail.com with ESMTPSA id g7sm4438007wmq.22.2021.07.14.02.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 02:44:35 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     kernel test robot <lkp@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCHv4 bpf-next 4/8] bpf: Add bpf_get_func_ip helper for kprobe programs
Date:   Wed, 14 Jul 2021 11:43:56 +0200
Message-Id: <20210714094400.396467-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714094400.396467-1-jolsa@kernel.org>
References: <20210714094400.396467-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding bpf_get_func_ip helper for BPF_PROG_TYPE_KPROBE programs,
so it's now possible to call bpf_get_func_ip from both kprobe and
kretprobe programs.

Taking the caller's address from 'struct kprobe::addr', which is
defined for both kprobe and kretprobe.

[removed duplicate include]
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       |  2 +-
 kernel/bpf/verifier.c          |  2 ++
 kernel/trace/bpf_trace.c       | 16 ++++++++++++++++
 tools/include/uapi/linux/bpf.h |  2 +-
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 31dd386b64ec..3ea5874f603b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4780,7 +4780,7 @@ union bpf_attr {
  *
  * u64 bpf_get_func_ip(void *ctx)
  * 	Description
- * 		Get address of the traced function (for tracing programs).
+ * 		Get address of the traced function (for tracing and kprobe programs).
  * 	Return
  * 		Address of the traced function.
  */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d27aa23fb572..9998ffc00bbd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5969,6 +5969,8 @@ static int check_get_func_ip(struct bpf_verifier_env *env)
 			return -ENOTSUPP;
 		}
 		return 0;
+	} else if (type == BPF_PROG_TYPE_KPROBE) {
+		return 0;
 	}
 
 	verbose(env, "func %s#%d not supported for program type %d\n",
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 022cbe42ac57..8af385fd5419 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -961,6 +961,20 @@ static const struct bpf_func_proto bpf_get_func_ip_proto_tracing = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
+BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
+{
+	struct kprobe *kp = kprobe_running();
+
+	return kp ? (u64) kp->addr : 0;
+}
+
+static const struct bpf_func_proto bpf_get_func_ip_proto_kprobe = {
+	.func		= bpf_get_func_ip_kprobe,
+	.gpl_only	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+};
+
 const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1092,6 +1106,8 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_override_return:
 		return &bpf_override_return_proto;
 #endif
+	case BPF_FUNC_get_func_ip:
+		return &bpf_get_func_ip_proto_kprobe;
 	default:
 		return bpf_tracing_func_proto(func_id, prog);
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 83e87ffdbb6e..4894f99a1993 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4783,7 +4783,7 @@ union bpf_attr {
  *
  * u64 bpf_get_func_ip(void *ctx)
  * 	Description
- * 		Get address of the traced function (for tracing programs).
+ * 		Get address of the traced function (for tracing and kprobe programs).
  * 	Return
  * 		Address of the traced function.
  */
-- 
2.31.1

