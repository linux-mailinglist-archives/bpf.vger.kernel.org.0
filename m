Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7452A283CA0
	for <lists+bpf@lfdr.de>; Mon,  5 Oct 2020 18:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgJEQjj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Oct 2020 12:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgJEQjj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Oct 2020 12:39:39 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A76C0613CE
        for <bpf@vger.kernel.org>; Mon,  5 Oct 2020 09:39:39 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id w2so6183624qvr.19
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2020 09:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=xipzbpHviIqYiBak+nQbcMG39Ykhca1EiWbnf/u43KQ=;
        b=Oy97KAhcVtDtLVZ0aDrcZz/nQfGI57BikM/0SqHHarC4ZSiU6POQakiPJPQRbP6V6j
         ZJeWgb6qWp9vgu3O02RoA5T2kzE/p8JTqtqDqCckRllodzSZqjwpUXYMgtoCxoy94M0v
         P54C1XtCW7HLBUlPAzMGtMNitbIX8BZePVLMY9XKjfVoJyIWtAw3j20GR5OzJeQo7SqD
         vSz/kjur0Obyv9RwqoxUEtVBFmPLaaRdT8aiEg1/FIvw0b9lVisakJ4AcVUO070DvNDy
         TQn6YpndbRPcj5qQQfQZ9aao9Nj7f6Fx4IQt2SHUDPX3TcshXI0Bs8kHZLnZ/dyRqjz7
         pWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=xipzbpHviIqYiBak+nQbcMG39Ykhca1EiWbnf/u43KQ=;
        b=GKnez1tUec2SQR7szLCVnvMSVJbxQCj5PSYy9t3/jvKG7RL0EM98K9UTk3td8D7IgH
         C1mh/w1FJmTN+UH5E7w1GKtHUSOp3dhLf/Hwj+pa9sRF9Db5HD2VLNUZkPKgyXZbAWDn
         5IhkOT8hv3VFxfCTkZ8dhX9sM0ham3bTRDW5Z3w5nXhUiqRwYGs9a3aeXbl+P2FXMY4J
         md0ddQYlTH/eZMPzQzbFDBfCZLi43tkKGqUkm/oH+7TNUmhgS8Prnb2PDAbPbazsiN9P
         uw4ZxkBe+HIz9AEIU0B5kY+aLpn7aJhzO2T+H4XLOaeto0yjrfqDb6PI5D1OwjHalxxU
         dusA==
X-Gm-Message-State: AOAM530ZmoQ21ZU4VjxmCt4ZGRvDLAUz0KmhWxcNAI1HS5Aoy/x7L9iB
        W2TQQyUcGY7tLUrG/GD1kzh+le3HhofDO29gixKx7zzMv8QZYb9BHyq/gIKHhXkbXKBdfhMMXgs
        y1jWYxzXu3J6LbAd2gi8aX0mlzKZrd6M7DLEWwQOZe29CqHZweG0TxCw1UQ==
X-Google-Smtp-Source: ABdhPJyixxchRFYwvchE717rEpDpBqfstb13Dj0I4zXi7ODfwV54qLA89ddxT59kKnsyB8G/mrLWvqdIAKo=
Sender: "lrizzo via sendgmr" <lrizzo@lrizzo2.svl.corp.google.com>
X-Received: from lrizzo2.svl.corp.google.com ([2620:15c:2c4:201:7220:84ff:fe09:96d1])
 (user=lrizzo job=sendgmr) by 2002:a0c:a203:: with SMTP id f3mr536084qva.33.1601915978418;
 Mon, 05 Oct 2020 09:39:38 -0700 (PDT)
Date:   Mon,  5 Oct 2020 09:39:34 -0700
Message-Id: <20201005163934.331875-1-lrizzo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v2] use valid btf in bpf_program__set_attach_target(prog,  0, ...);
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

