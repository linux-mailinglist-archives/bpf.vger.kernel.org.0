Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037473C81ED
	for <lists+bpf@lfdr.de>; Wed, 14 Jul 2021 11:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238933AbhGNJrN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 05:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56528 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238923AbhGNJrM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Jul 2021 05:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626255861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jm5cd0zOZ7Itm+FjlMPQhsBe4LoJlMQjbASHrTs/ggA=;
        b=Qwn8KMxfTojYxcZ63zQvWSgXlx01/5vJSB0TcI4zFpKhKonLKD2ArcH4mXN2ZJztJcKiHc
        lDd05+aZMOJ4lEX0mw3gsbJpKMuIx3NIs0MjQqzF9TKEnMKdg6IE/J4ovvnJGgQNr56jo5
        s4jbqqUvtvjdGBaiSdJmuj/q/lJKMqg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-zmWo5Lp3N7-XS9qDOK273w-1; Wed, 14 Jul 2021 05:44:20 -0400
X-MC-Unique: zmWo5Lp3N7-XS9qDOK273w-1
Received: by mail-wr1-f71.google.com with SMTP id z6-20020a5d4c860000b029013a10564614so1210328wrs.15
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 02:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jm5cd0zOZ7Itm+FjlMPQhsBe4LoJlMQjbASHrTs/ggA=;
        b=rhJ+ERyB+6cFMdakZj2wmgITSZJEIlljq+Fbnymahy99yWb7QWAjQb06/lr1KHSvxO
         AdRZjn5xHUjVa/gkrjPmwMfUIvqlBDkIcbQAS2F/B0mN+iDFOb4f2DZ92P52lEEBPyvu
         1e9YMwtTemiW3Vwh1tEq7hmZZBfq9TxZ9aBYMmG8ILNNE4Yw38c7vChGBPY4KZdea4C1
         eC6tf2/geZO3eOmtAvdf4amYfhyxJzNXS2nV+u2bLuk2Lc0IHpFIPp1q94/Gagxrw38T
         XYrGUMT80/5O077pNnAMoosTxzyqGNEbexfiGkTbaoV5efSYJcdWhPlvrdcnqyPpURc8
         JxJw==
X-Gm-Message-State: AOAM532q/mXdJXohcT+VvyA6eBOo893vpPmNLZdCsU6WC9KR+sjPLxZR
        TsV9EiM3JSB7Amc/CXzvQ6DZ+mhBROxB0abznssY/iI7y2juaN2S9ZbhBZz9gjbOSQXpuWKXPeq
        /i/f+Urc0Fl+f
X-Received: by 2002:a1c:f206:: with SMTP id s6mr9850233wmc.102.1626255859148;
        Wed, 14 Jul 2021 02:44:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyF2knkhR2JGKJXdyuYnd2E9BYmdfbnj8CH969zHq91hrlXkVOGyBKLQFuJ08BZMZSrW+0TjQ==
X-Received: by 2002:a1c:f206:: with SMTP id s6mr9850211wmc.102.1626255858921;
        Wed, 14 Jul 2021 02:44:18 -0700 (PDT)
Received: from krava.redhat.com ([5.171.203.6])
        by smtp.gmail.com with ESMTPSA id g3sm1939223wru.95.2021.07.14.02.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 02:44:18 -0700 (PDT)
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
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCHv4 bpf-next 2/8] bpf: Enable BPF_TRAMP_F_IP_ARG for trampolines with call_get_func_ip
Date:   Wed, 14 Jul 2021 11:43:54 +0200
Message-Id: <20210714094400.396467-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714094400.396467-1-jolsa@kernel.org>
References: <20210714094400.396467-1-jolsa@kernel.org>
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

