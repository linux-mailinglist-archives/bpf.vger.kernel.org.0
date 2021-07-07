Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57253BF076
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 21:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhGGTtV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 15:49:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230002AbhGGTtU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Jul 2021 15:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625687200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jm5cd0zOZ7Itm+FjlMPQhsBe4LoJlMQjbASHrTs/ggA=;
        b=R5qCsHGOgoTEfrP06iT+d+Pv2GQ60eL0ruZHqI2/HhZ7m5ZStGgaB2xiF4Rx+CDf+QrV7W
        Q3zWb2I1Hb1ddXTjYMgDzcQZn0aO4YPTxsrTQ/apCb1B6y1hmhg7YwNb4UwqRci/YklimZ
        bbrrxV3ChfM/6H7BMDIkxmVsrXIMx9I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-Ws8H4-7xNUyYQ4vWjKMYPg-1; Wed, 07 Jul 2021 15:46:38 -0400
X-MC-Unique: Ws8H4-7xNUyYQ4vWjKMYPg-1
Received: by mail-wm1-f72.google.com with SMTP id n37-20020a05600c3ba5b02901fe49ba3bd0so1412893wms.1
        for <bpf@vger.kernel.org>; Wed, 07 Jul 2021 12:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jm5cd0zOZ7Itm+FjlMPQhsBe4LoJlMQjbASHrTs/ggA=;
        b=ob31Dp4Sr50FeK9DyZIm/HDPX3W4xLduZX/3ggfoEtBxrtvnrm7Z8uImzE3dTleNOn
         EluqAD6s2VpkXW0iiyY5OkkX6jGV3vhBb8vDnTt9wyBTny5Sc4tkv/uf9NesG0Un2tvs
         6DY9Iggvk1jhUvh0UyUNWCaA2L3BuA2xor0OyQCmKzoGgdjCVhZQIBamMfPpCU2XwUCr
         Rx9BoGqd1Px506/RW1L5iupTXYHnwHMG6IUIaFxqqZi7S4Wx/Z14tLqOpgklSgG8Y397
         y58xGOPJzCbrghqen8T/8mTttYrKzxvkZJti+opmaIgc37iT2JONn+MA47Zsafbd+a7j
         /+4w==
X-Gm-Message-State: AOAM532+W0a7t1rqrXLhkXAEdC3I+Lif2rFzOh3cIGGZPOUY1euvkh7F
        EK1Z8BuFZAiicAWLDMCSWURb9q1tuwWYF6t8WbH+J78NaxIUhX2AOCz4HxsxXHJdntvBqcIe75i
        j8YUmin5LmGfW
X-Received: by 2002:a5d:5271:: with SMTP id l17mr5906661wrc.239.1625687197789;
        Wed, 07 Jul 2021 12:46:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBe+9LG+vQmU7WuM+qgcXfsAzLMlWz9Xa0cUggl+MXKe4W6WQVS7iSBwX1Zs5rJPTANSyCSQ==
X-Received: by 2002:a5d:5271:: with SMTP id l17mr5906648wrc.239.1625687197613;
        Wed, 07 Jul 2021 12:46:37 -0700 (PDT)
Received: from krava.redhat.com ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id l1sm6980416wme.11.2021.07.07.12.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 12:46:37 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH 2/7] bpf: Enable BPF_TRAMP_F_IP_ARG for trampolines with call_get_func_ip
Date:   Wed,  7 Jul 2021 21:46:14 +0200
Message-Id: <20210707194619.151676-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210707194619.151676-1-jolsa@kernel.org>
References: <20210707194619.151676-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Enabling BPF_TRAMP_F_IP_ARG for trampolines that actually need it.

The BPF_TRAMP_F_IP_ARG adds extra 3 instructions to trampoline code
and is used only by programs with bpf_get_func_ip helper, which is
added in following patch and sets call_get_func_ip bit.

This patch ensures that BPF_TRAMP_F_IP_ARG flag is used only for
trampolines that have programs with call_get_func_ip set.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/filter.h  |  3 ++-
 kernel/bpf/trampoline.c | 12 +++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 472f97074da0..ba36989f711a 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -559,7 +559,8 @@ struct bpf_prog {
 				kprobe_override:1, /* Do we override a kprobe? */
 				has_callchain_buf:1, /* callchain buffer allocated? */
 				enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
-				call_get_stack:1; /* Do we call bpf_get_stack() or bpf_get_stackid() */
+				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
+				call_get_func_ip:1; /* Do we call get_func_ip() */
 	enum bpf_prog_type	type;		/* Type of BPF program */
 	enum bpf_attach_type	expected_attach_type; /* For some prog types */
 	u32			len;		/* Number of filter blocks */
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 28a3630c48ee..b2535acfe9db 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -172,7 +172,7 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 }
 
 static struct bpf_tramp_progs *
-bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total)
+bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_arg)
 {
 	const struct bpf_prog_aux *aux;
 	struct bpf_tramp_progs *tprogs;
@@ -189,8 +189,10 @@ bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total)
 		*total += tr->progs_cnt[kind];
 		progs = tprogs[kind].progs;
 
-		hlist_for_each_entry(aux, &tr->progs_hlist[kind], tramp_hlist)
+		hlist_for_each_entry(aux, &tr->progs_hlist[kind], tramp_hlist) {
+			*ip_arg |= aux->prog->call_get_func_ip;
 			*progs++ = aux->prog;
+		}
 	}
 	return tprogs;
 }
@@ -333,9 +335,10 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr)
 	struct bpf_tramp_image *im;
 	struct bpf_tramp_progs *tprogs;
 	u32 flags = BPF_TRAMP_F_RESTORE_REGS;
+	bool ip_arg = false;
 	int err, total;
 
-	tprogs = bpf_trampoline_get_progs(tr, &total);
+	tprogs = bpf_trampoline_get_progs(tr, &total, &ip_arg);
 	if (IS_ERR(tprogs))
 		return PTR_ERR(tprogs);
 
@@ -357,6 +360,9 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr)
 	    tprogs[BPF_TRAMP_MODIFY_RETURN].nr_progs)
 		flags = BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_SKIP_FRAME;
 
+	if (ip_arg)
+		flags |= BPF_TRAMP_F_IP_ARG;
+
 	err = arch_prepare_bpf_trampoline(im, im->image, im->image + PAGE_SIZE,
 					  &tr->func.model, flags, tprogs,
 					  tr->func.addr);
-- 
2.31.1

