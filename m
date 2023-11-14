Return-Path: <bpf+bounces-15044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD117EA9DA
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 05:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D364C1C20A9C
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 04:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9468DBE5B;
	Tue, 14 Nov 2023 04:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xxvjB+WV"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCC9BA45
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 04:55:01 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5C5A4
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 20:55:00 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5af592fed43so61731817b3.2
        for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 20:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699937699; x=1700542499; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xHw9c1x/1MrkMxN4PZXPTW4efkpHjKlYOHaTk46Psr4=;
        b=xxvjB+WVyoR9xN2W63eGBy5PE1XSrzv4tQt7oOjmakVOLiV1qvNXZ9VNHArIY+CsJb
         FGDe6zlWZO7fU72ds1m5fHQxs884hYEwsYr2p1uT5IayTb14vOZEi+0nYJOPkWdXWFUM
         /mErUfAUSGtg5J71YfgH0NGGB4bLNL4jk3F+xG3i6GaBXUAT2Y2B6SH3i5AOPzfTZD4J
         0CeAFPGE/Y5nJ3sD9qcHufPxvl2l2Jjk1GfzwUTCKGns9bbvQKksrJewMjAkfgJOshmU
         FwgmZWMTf/v/b1BMJNrY60ouD+XuC+VKu0+q6nUGDwOBymNAwtzdcHKk0diel0pgsS0E
         +suQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699937699; x=1700542499;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHw9c1x/1MrkMxN4PZXPTW4efkpHjKlYOHaTk46Psr4=;
        b=JUBskt5BVgAG2Kihq4eRLiXevkoo4UVcPATLIo9o44c/dBsBzMev4mE8q6FJYjNBBe
         9Oaq1VfVQJBzDrVoChmCVOqFA7Qmbx7u0S3eEYHsoJXBae3/a8pXeaJeeqv962LVoR3u
         H2zUAkt2eIKhkJmwEjzaRfvg/Ywe7KiUPsQkv00eDLzht1w1pH2sjd0jiuCHLT6bdIt2
         GKtcC+4s8sIHMWjecQCuidJ38TLlD3AIadhqcAzBUw1VYz6k7cwmQmVHmrNaUVrwiK9Y
         uWelSI7dyFYwT6K7Bh1QpjjEGYyUHbTAydiTrzVozHZMj4B8EOi9gYl4/Aw8ieK8zQYw
         MsNQ==
X-Gm-Message-State: AOJu0YzoGyQM7UxRmVZAe6cBTCxya/BLVOzHED17lDXLsRnVeh0fYfKm
	5pkEbjUhaI/13vZZuES/A+F/60mnIFSfBFBxBaLSEsaJZbQTeAuMVbK+NqC/N/pp8pDpx1vnWZA
	HnFokgVB2s4NzIFcZapOZsaS9+RQXcCrR6UHbr7noxG5LF1FJSA==
X-Google-Smtp-Source: AGHT+IG4r1voAGEi9crD9gREjLeW/8OoJQZBOb+nEPlqefEdITsoiFaKTw9vKoTI2Vczqput0kGzjDQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:aad4:0:b0:d9a:6007:223a with SMTP id
 t78-20020a25aad4000000b00d9a6007223amr189049ybi.8.1699937698880; Mon, 13 Nov
 2023 20:54:58 -0800 (PST)
Date: Mon, 13 Nov 2023 20:54:53 -0800
In-Reply-To: <20231114045453.1816995-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231114045453.1816995-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231114045453.1816995-3-sdf@google.com>
Subject: [PATCH bpf-next 2/2] bpf: bring back removal of dev-bound id from idr
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit ef01f4e25c17 ("bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD
and PERF_BPF_EVENT_PROG_UNLOAD") stopped removing program's id from
idr when the offloaded/bound netdev goes away. I was supposed to
take a look and check in [0], but apparently I did not.

The purpose of idr removal is to avoid BPF_PROG_GET_NEXT_ID returning
stale ids for the programs that have a dead netdev. This functionality
is verified by test_offload.py, but we don't run this test in the CI.

Introduce new bpf_prog_remove_from_idr which takes care of correctly
dealing with potential double idr_remove() via separate skip_idr_remove
flag in the aux.

Verified by running the test manually:
test_offload.py: OK

0: https://lore.kernel.org/all/CAKH8qBtyR20ZWAc11z1-6pGb3Hd47AQUTbE_cfoktG59TqaJ7Q@mail.gmail.com/

Fixes: ef01f4e25c17 ("bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD and PERF_BPF_EVENT_PROG_UNLOAD")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf.h  |  2 ++
 kernel/bpf/offload.c |  3 +++
 kernel/bpf/syscall.c | 15 +++++++++++----
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4001d11be151..d2aa4b59bf1e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1414,6 +1414,7 @@ struct bpf_prog_aux {
 	bool xdp_has_frags;
 	bool exception_cb;
 	bool exception_boundary;
+	bool skip_idr_remove;
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
 	/* function name for valid attach_btf_id */
@@ -2049,6 +2050,7 @@ void bpf_prog_inc(struct bpf_prog *prog);
 struct bpf_prog * __must_check bpf_prog_inc_not_zero(struct bpf_prog *prog);
 void bpf_prog_put(struct bpf_prog *prog);
 
+void bpf_prog_remove_from_idr(struct bpf_prog *prog);
 void bpf_prog_free_id(struct bpf_prog *prog);
 void bpf_map_free_id(struct bpf_map *map);
 
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 1a4fec330eaa..6f4fe492ee2a 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -112,6 +112,9 @@ static void __bpf_prog_offload_destroy(struct bpf_prog *prog)
 	if (offload->dev_state)
 		offload->offdev->ops->destroy(prog);
 
+	/* Make sure BPF_PROG_GET_NEXT_ID can't find this dead program */
+	bpf_prog_remove_from_idr(prog);
+
 	list_del_init(&offload->offloads);
 	kfree(offload);
 	prog->aux->offload = NULL;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0ed286b8a0f0..bc813e03e2cf 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2083,10 +2083,19 @@ static int bpf_prog_alloc_id(struct bpf_prog *prog)
 	return id > 0 ? 0 : id;
 }
 
-void bpf_prog_free_id(struct bpf_prog *prog)
+void bpf_prog_remove_from_idr(struct bpf_prog *prog)
 {
 	unsigned long flags;
 
+	spin_lock_irqsave(&prog_idr_lock, flags);
+	if (!prog->aux->skip_idr_remove)
+		idr_remove(&prog_idr, prog->aux->id);
+	prog->aux->skip_idr_remove = 1;
+	spin_unlock_irqrestore(&prog_idr_lock, flags);
+}
+
+void bpf_prog_free_id(struct bpf_prog *prog)
+{
 	/* cBPF to eBPF migrations are currently not in the idr store.
 	 * Offloaded programs are removed from the store when their device
 	 * disappears - even if someone grabs an fd to them they are unusable,
@@ -2095,10 +2104,8 @@ void bpf_prog_free_id(struct bpf_prog *prog)
 	if (!prog->aux->id)
 		return;
 
-	spin_lock_irqsave(&prog_idr_lock, flags);
-	idr_remove(&prog_idr, prog->aux->id);
+	bpf_prog_remove_from_idr(prog);
 	prog->aux->id = 0;
-	spin_unlock_irqrestore(&prog_idr_lock, flags);
 }
 
 static void __bpf_prog_put_rcu(struct rcu_head *rcu)
-- 
2.42.0.869.gea05f2083d-goog


