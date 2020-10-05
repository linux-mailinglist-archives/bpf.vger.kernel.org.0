Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1575A28429D
	for <lists+bpf@lfdr.de>; Tue,  6 Oct 2020 00:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgJEWmG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Oct 2020 18:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgJEWmG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Oct 2020 18:42:06 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A71C0613CE
        for <bpf@vger.kernel.org>; Mon,  5 Oct 2020 15:42:05 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id t4so3673309qtd.23
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2020 15:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=xipzbpHviIqYiBak+nQbcMG39Ykhca1EiWbnf/u43KQ=;
        b=glmegDwyzcp+D/agTU6hHG0h9N7d9liL8aX33J5E1yLWQWJ06RaiV+dJnEg4xwjCVi
         hhTNwHTFkwk6b6+o2mm6oBNRhNMYq34S7yPDSX34Lv8m81u3NVlU08nIDWoEg+CU/B3X
         VdMbi746d/Vr/OXrBUG6BUtVeYo/g0fc41F9SrXvADhDFP8K8XskEMAPmmpALYbOnMJs
         X0McL0d4fecHOtp0E/CjRdYGTAdgf4gRJwOkqKhP9vcUQDfAJ0rcT5SI++VrHLxiEF/q
         KbVBoLPGxfjGpzAehfHFdqTHyiRxNQNkbfXBwz0Up0zB99N/ZmDu8IlYPNHxh0zHe4X7
         2zrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=xipzbpHviIqYiBak+nQbcMG39Ykhca1EiWbnf/u43KQ=;
        b=WHZIlcTgLoCjwGu/zU6JvJQhuiINtBF9wypq/4cPeD/nq0i8lopxsDcrN8Ejg99dZH
         HC6/8KqmBmWPsY9cp8K2Xfc0gM4zz0ZgswydG6ZJLPFX39gkdOmKfL21ZOepYGnMUAH/
         uvD+Yb8KviMbyhKjrTjeDdnTfhyoXvhGcNDxGd2yI9RuxeHyvkSYlMk63t9cX/1lYpDe
         E5IZEtecDJD0n/p/Y5vOi+h2r91sFk0qj5UCn+DTWqpCeWOFMBn8anfTNOjHIybBLcB+
         RRg1dFhh2zOPKS9eTRsEuaMvAG/Cy59HtRRVqJbLtHZGhvV6gnXd7aNtmmAYaOHVqwT7
         mEQw==
X-Gm-Message-State: AOAM5311QTucHw0aQS73gnRfv4V+Q+nTPvFZkCMKcl9/r7psjlcnJGwp
        mL9fwhAYxoIz1aOY61Yhz8OqfJI4yBaI5iiZjnGFWzZm7E5598gwH/IsmFGvvQLrTJNbdKcMdq/
        XXi7G/UhzTUoXHOPNdg66jNHJRMwaOYHbe7GXtU18QR8B/IM7iJEUh5vU6A==
X-Google-Smtp-Source: ABdhPJyVlzQgO3xJoCn9JotPIVM2yXpsGWjCgJjtBq5hX1vo/PKytLJFa61vGg1mtKpBQRRBoZ1YmfBSZ1I=
Sender: "lrizzo via sendgmr" <lrizzo@lrizzo2.svl.corp.google.com>
X-Received: from lrizzo2.svl.corp.google.com ([2620:15c:2c4:201:7220:84ff:fe09:96d1])
 (user=lrizzo job=sendgmr) by 2002:a0c:a899:: with SMTP id x25mr1930826qva.46.1601937724807;
 Mon, 05 Oct 2020 15:42:04 -0700 (PDT)
Date:   Mon,  5 Oct 2020 15:42:01 -0700
Message-Id: <20201005224201.387694-1-lrizzo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v2] use valid btf in bpf_program__set_attach_target(prog,  0, ...);
From:   Luigi Rizzo <lrizzo@google.com>
To:     bpf@vger.kernel.org, Eelco Chaudron <echaudro@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>, rizzo.unipi@gmail.com,
        Andrii Nakryiko <andriin@fb.com>
Cc:     ppenkov@google.com, tommaso.burlon@gmail.com,
        Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_program__set_attach_target() will always fail with fd=0 (attach to a
kernel symbol) because obj->btf_vmlinux is NULL and there is no way to
set it.

Fix this by using libbpf_find_vmlinux_btf_id()

(on a side note: it is unclear whether btf_vmlinux is meant to be
just temporary storage for use in bpf_object__load_xattr(), or
a property of bpf_object, in which case it could be initialuzed
opportunistically, and properly released in bpf_object__close() ).

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 tools/lib/bpf/libbpf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a4f55f8a460d..33bf102259dd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10353,9 +10353,8 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
 		btf_id = libbpf_find_prog_btf_id(attach_func_name,
 						 attach_prog_fd);
 	else
-		btf_id = __find_vmlinux_btf_id(prog->obj->btf_vmlinux,
-					       attach_func_name,
-					       prog->expected_attach_type);
+		btf_id = libbpf_find_vmlinux_btf_id(attach_func_name,
+						    prog->expected_attach_type);
 
 	if (btf_id < 0)
 		return btf_id;
-- 
2.28.0.806.g8561365e88-goog

