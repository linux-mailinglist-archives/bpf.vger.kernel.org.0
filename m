Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CA33B78A5
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 21:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbhF2TcZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 15:32:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58180 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234594AbhF2TcY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Jun 2021 15:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624994996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jm5cd0zOZ7Itm+FjlMPQhsBe4LoJlMQjbASHrTs/ggA=;
        b=cCLo6L8xdEkdjjqJvWpg9bl8KYp0p1bhWd5aESB0bv5/sQqDzU+t1eiFCOM3WOYoX4cdwn
        CRaMWocCytNgYKn3jtt10kn1pxYoKc6FUkvi4hInMD0RRnwaEFydSjD9ipdUFgvlnxT6gS
        7XmktfwI5eNiJZi4vI3jTosy7ul/no0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-DKMX2oaSOpeDzM9FItwh8w-1; Tue, 29 Jun 2021 15:29:54 -0400
X-MC-Unique: DKMX2oaSOpeDzM9FItwh8w-1
Received: by mail-ed1-f72.google.com with SMTP id w1-20020aa7da410000b029039533674a84so7305699eds.9
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 12:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jm5cd0zOZ7Itm+FjlMPQhsBe4LoJlMQjbASHrTs/ggA=;
        b=Kanvb6e4emQA1Bipk/bN4H/oxWAjjif6oI1cdYzUsiuBUxw7lq/XXSxsD+aJ1/mEVR
         rJYXTWCjwmf9m0eolM5jCcMXTqgpfD4KwQIpTs//aPAfh3k7DD92trCLHvqYhmNfD4mX
         c/foqO1c+hjGWIGDhFwf7OuzouW0XDl3/vrHZ3iJaKjMQ+s9hCtum/HbI3+Fmz/uYSRr
         bhulnz4OlbWcYGCEiURyHn8cDz+dqLZK7ZB5iPvPlEAzXqvSpWDGg4wSwFn6DFgiMOck
         B3oh7Bhh1pdWbAE6k1IDN+neO1XMotLoXsEUTFfxaqP4oZurJ0frJoJaexugmOdHuADM
         r4hA==
X-Gm-Message-State: AOAM532pkqBeiJcLU7j0QSbHRZMfGMK2ttsTAF8ZKHJCLw4GG8Ws9hEg
        EpJF8JUI+obnhrMGNZaKh0bAO3OLwxOj8Rd9AEmK9bALrRB32MoQ8OEpSCtH3KhgleihXug5ZdK
        WMn8Uf8BPikwl
X-Received: by 2002:aa7:d8d4:: with SMTP id k20mr41688296eds.143.1624994993070;
        Tue, 29 Jun 2021 12:29:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5OvjTkKZzLuY/9wnAZ95R6xQ/Jmsq4KCZeL0+5Rkjq44ZUqUpAvXSe1v+Q79LdCNb87I4/g==
X-Received: by 2002:aa7:d8d4:: with SMTP id k20mr41688287eds.143.1624994992931;
        Tue, 29 Jun 2021 12:29:52 -0700 (PDT)
Received: from krava.redhat.com ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id n22sm472559eje.3.2021.06.29.12.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 12:29:52 -0700 (PDT)
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
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf-next 2/5] bpf: Enable BPF_TRAMP_F_IP_ARG for trampolines with call_get_func_ip
Date:   Tue, 29 Jun 2021 21:29:42 +0200
Message-Id: <20210629192945.1071862-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210629192945.1071862-1-jolsa@kernel.org>
References: <20210629192945.1071862-1-jolsa@kernel.org>
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

