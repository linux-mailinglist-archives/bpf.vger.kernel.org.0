Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B772836BD
	for <lists+bpf@lfdr.de>; Mon,  5 Oct 2020 15:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgJENlJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Oct 2020 09:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgJENlI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Oct 2020 09:41:08 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8185CC0613CE
        for <bpf@vger.kernel.org>; Mon,  5 Oct 2020 06:41:08 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id t40so793393qtc.19
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2020 06:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=yEe1kEsbhSYK+RyW/N1T2IZ1q36gT14dRVcQGhafZ2g=;
        b=dziruSe/oeMojVh1TV/r0NjxYoEL9ConsquPtn8oXjH3PwjMhIE3VDHKgxd6f/txHP
         swQ1EjzxZnDtyY35h4/WiCTNyl0TvrUiK6Y+AFGN23LzEnvHENG1KL6dCc+wIe9EES2h
         XOR54Wh9HViMSuyRig8AN/al03NjbgHvdBI66ufhNb3ciZBYKf0yEUUZYc+NTF7UZGAv
         1K7HlTb2vvItQF6S6Yt+J5Rz1+VTq0lvfKVnsLUk5CJFb5X/rlJ8me5XEZupwEaWm3ed
         QWqmArdn22KjuUzQtQyz+qKK27CiZtL9l83hXfeci7ae6GV2B3UWGbNK4VOpNDbLwhcr
         GoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=yEe1kEsbhSYK+RyW/N1T2IZ1q36gT14dRVcQGhafZ2g=;
        b=FKIcyePI6aTc99//y/3koh1gE6qQ5E8a5vEHVtGRRdeG8ww+uMxRYFOrddZ0VBWQ4i
         MVxlAxvN+bXZkRG01JavsEPTgO/++Ylru5SIJdQTYY22BrOOy/uhy/p40OjKFSAV+rU/
         4K4EuzthGK/do2x3wS3CXxBl8ZwrGIbExaJYuwYD8w10XL0fTO/yzN0B514rHc3E1y39
         umB5j3/ElnkICQk3Ii66BoySR+BxedeYp6eZ+nItWNbNUFSe/sPAUhJ/k+dRhGFnZHls
         F7Qnu3Blcy1fEbwrAyHI7VM+A3KTF6rUfDtd6TCQDQ9oDduaTjgWX8XedICaH1pt387x
         NLBg==
X-Gm-Message-State: AOAM532z5xSWwujXxmtGA1XUqOVZwt1jL445ZbkRnvHDzxlDpeRPy4BI
        Ew2/x7uurwrC7yv2nOiayrXjUn3Q8d+9TtVgJ0odPDsnGzidJhxcm53Gv5vduZbf0G1VODVWfJ+
        SJAAXy9XKweveqkjTkawh3i1USIyqf90X3xlWLhbxC1aGuijpgQmhxb6hwg==
X-Google-Smtp-Source: ABdhPJzaBiYcmqN3fF8zWyuCHlc4QW+SWRjSlNoXg6XHRVuPxrPAzpy079g1L809jaPf4OGHRnbZL//mEAc=
Sender: "lrizzo via sendgmr" <lrizzo@lrizzo2.svl.corp.google.com>
X-Received: from lrizzo2.svl.corp.google.com ([2620:15c:2c4:201:7220:84ff:fe09:96d1])
 (user=lrizzo job=sendgmr) by 2002:ad4:4d52:: with SMTP id m18mr14752577qvm.55.1601905267561;
 Mon, 05 Oct 2020 06:41:07 -0700 (PDT)
Date:   Mon,  5 Oct 2020 06:41:00 -0700
Message-Id: <20201005134100.302271-1-lrizzo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH] use valid btf in bpf_program__set_attach_target(prog,  0, ...);
From:   Luigi Rizzo <lrizzo@google.com>
To:     bpf@vger.kernel.org, Eelco Chaudron <echaudro@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     ppenkov@google.com, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_program__set_attach_target() will always fail with fd=0 (attach to a
kernel symbol) because obj->btf_vmlinux is NULL and there is no way to
set it.

Fix this by explicitly calling libbpf_find_kernel_btf() in the function.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 tools/lib/bpf/libbpf.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a4f55f8a460d..3a63db86666f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10352,10 +10352,13 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
 	if (attach_prog_fd)
 		btf_id = libbpf_find_prog_btf_id(attach_func_name,
 						 attach_prog_fd);
-	else
-		btf_id = __find_vmlinux_btf_id(prog->obj->btf_vmlinux,
-					       attach_func_name,
+	else {
+		struct btf *btf = libbpf_find_kernel_btf();
+
+		btf_id = __find_vmlinux_btf_id(btf, attach_func_name,
 					       prog->expected_attach_type);
+		btf__free(btf);
+	}
 
 	if (btf_id < 0)
 		return btf_id;
-- 
2.28.0.806.g8561365e88-goog

