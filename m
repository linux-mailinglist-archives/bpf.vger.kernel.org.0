Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D24C2F59F6
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2019 22:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732170AbfKHVdR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Nov 2019 16:33:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732513AbfKHVdO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Nov 2019 16:33:14 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83D0C859FE
        for <bpf@vger.kernel.org>; Fri,  8 Nov 2019 21:33:14 +0000 (UTC)
Received: by mail-lj1-f200.google.com with SMTP id h9so1547642ljc.6
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2019 13:33:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=GBjYCkvy2GbEH7Q23GeY3ESuFtUK5AcyN8OZ2vuJJlc=;
        b=GPaSx2REo2X28nJG7xoClwboHf9dJYyE3S4Q4S46PxCe0rBLqedsHPhDK8Sjh98rui
         jM9Kh4HqJbv/lnOfpWR7h818jmXd6JMb/VlrtpQxP/si3SJ6ilhTD1crBR6KqSbxZ5pP
         uqU0FXKwSyUb9CQVv7wppnts53xldghdz3UvpZeNxYosJdXoE40IcHwN0qakImPfgxwk
         jp8bYhJWDO6p1lA5ctos8ETAoZMQIOfeUIBb43TTb5fDh1BMIPboai7ohFLpz0dLncAj
         OuDy7H+kTN3f1pBquhfF0hvv8tSGpzdoQzSynecN42X3YVDBJviUnR9Bwhoh1PXvSktN
         JFYQ==
X-Gm-Message-State: APjAAAUl3qehIUOnf86YBQat22IeXPeOWZAuvjJiXnrov3K06KO/0Ot+
        GBsa95czQzpUaDjDeDJX9fcdU1r2Bd9DOF2OlBxNfzkXpLoWcdXWQ7aMZgLX+KQiafH5sYSvXWp
        79x7CoY3F5Mvj
X-Received: by 2002:ac2:5b1d:: with SMTP id v29mr7905212lfn.54.1573248793110;
        Fri, 08 Nov 2019 13:33:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqyctTL3kNwz/34TK8mIxExHhHL9/rEa+UQvCWQxPGhApNLDQroCsBY/4KDberzmnIS0GFFUkQ==
X-Received: by 2002:ac2:5b1d:: with SMTP id v29mr7905193lfn.54.1573248792938;
        Fri, 08 Nov 2019 13:33:12 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id c19sm2977825ljj.61.2019.11.08.13.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 13:33:12 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CD3C91800BD; Fri,  8 Nov 2019 22:33:11 +0100 (CET)
Subject: [PATCH bpf-next v2 6/6] libbpf: Add getter for program size
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Fri, 08 Nov 2019 22:33:11 +0100
Message-ID: <157324879178.910124.2574532467255490597.stgit@toke.dk>
In-Reply-To: <157324878503.910124.12936814523952521484.stgit@toke.dk>
References: <157324878503.910124.12936814523952521484.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

This adds a new getter for the BPF program size (in bytes). This is useful
for a caller that is trying to predict how much memory will be locked by
loading a BPF object into the kernel.

Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c   |    5 +++++
 tools/lib/bpf/libbpf.h   |    1 +
 tools/lib/bpf/libbpf.map |    1 +
 3 files changed, 7 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 582c0fd16697..facd5e1a3a0b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4790,6 +4790,11 @@ int bpf_program__fd(const struct bpf_program *prog)
 	return bpf_program__nth_fd(prog, 0);
 }
 
+size_t bpf_program__size(const struct bpf_program *prog)
+{
+	return prog->insns_cnt * sizeof(struct bpf_insn);
+}
+
 int bpf_program__set_prep(struct bpf_program *prog, int nr_instances,
 			  bpf_program_prep_t prep)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index f0947cc949d2..10875dc68ec8 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -213,6 +213,7 @@ LIBBPF_API void bpf_program__set_ifindex(struct bpf_program *prog,
 
 LIBBPF_API const char *bpf_program__title(const struct bpf_program *prog,
 					  bool needs_copy);
+LIBBPF_API size_t bpf_program__size(const struct bpf_program *prog);
 
 LIBBPF_API int bpf_program__load(struct bpf_program *prog, char *license,
 				 __u32 kern_version);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index d1a782a3a58d..9f39ee06b2d4 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -203,4 +203,5 @@ LIBBPF_0.0.6 {
 		bpf_program__get_type;
 		bpf_program__is_tracing;
 		bpf_program__set_tracing;
+		bpf_program__size;
 } LIBBPF_0.0.5;

