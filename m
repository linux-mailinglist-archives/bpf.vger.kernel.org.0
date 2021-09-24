Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83AA4416A0E
	for <lists+bpf@lfdr.de>; Fri, 24 Sep 2021 04:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243919AbhIXCjC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Sep 2021 22:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbhIXCjB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Sep 2021 22:39:01 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6305C061574
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 19:37:28 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g184so8456236pgc.6
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 19:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=asaqErtRaKKMr0BDq2a1lqQmX1vTntoiAJe7GmeyNlk=;
        b=e9YWeKmaTDIxwCRdRXNpwm7ybl89DkTJbszxxGxhyR0xIF78WUmtwV6WlyaXMB8Dsc
         MQorqIE3ypuxLniubbHBAVN+JYIHdZQJjeaeMDTIEe3fvIfVjMIJWFBkYQfELxdcRrVy
         rqftJfPlG87/gr2sHk+rHV8Ywb8GgtgwxQZQEW1uYPZ/SlvE1gmTSI2Fp//NA365JwjE
         nc+pPK2mQUGLdTvFzpI73y/L8yET1DqNoRVuHGCbzIFMUiZ0QVUAEemN7PkSPASOrw5I
         nsCW5XuDRqC/ti4eweRxBLahuhdvsGoboVv0gp6Z68x5/pw6KBtR5zg+/F4lgLN28eN9
         MqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=asaqErtRaKKMr0BDq2a1lqQmX1vTntoiAJe7GmeyNlk=;
        b=kdDtwZa+QDkjIXlMGZSQ+jnngqfXax0ObDvLdzXVEeqtT+XXIuciXN0XIWkU1yQTmF
         TiAZyQIF3YiG6v2IIArwdoEqd3FAJ2E9xeNGo7B3w5cHW2E5yx776KFR9d47+ItpvJX2
         uK2ypfwxn6JYsUn13F67YU9JvfDFEHCPs2DK30Jeq8MrS8SNj5GMQ6Q1j45LgJt7oiy5
         0JYegyC+7PvBsP+9DM63t8N6SI42zDQ10ZflSRtSbJXKK59GDdQYufFUN+SSL/iD6P+Y
         gFvmXqgRvk5exU7/C9f7eLHg4h57UC7uDFMl8dq1iiVUKAOWGrsb1B7OFDC3UjvfSXyM
         LqUA==
X-Gm-Message-State: AOAM530GV2mleAl7gZ2IgmlyQpu63kgl6JhVJwrNxwmeXbiS0YejxJyL
        88zgJIGYjgIvRCSzCSdT3PXA/PQm1ixqXQ==
X-Google-Smtp-Source: ABdhPJwpRptR6Nu9X9VA1UyFcufCMrfwtwibZyYxC0/uaubor8bxWpHW9KVksK/24IiQVto801N8KA==
X-Received: by 2002:a63:de46:: with SMTP id y6mr1765494pgi.364.1632451047917;
        Thu, 23 Sep 2021 19:37:27 -0700 (PDT)
Received: from localhost ([2405:201:6014:d058:a28d:3909:6ed5:29e7])
        by smtp.gmail.com with ESMTPSA id z24sm7859111pgu.54.2021.09.23.19.37.27
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 19:37:27 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Subject: [PATCH bpf] libbpf: Fix segfault in static linker for objects without BTF
Date:   Fri, 24 Sep 2021 08:07:25 +0530
Message-Id: <20210924023725.70228-1-memxor@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When a BPF object is compiled without BTF info (without -g),
trying to link such objects using bpftool causes a SIGSEGV due to
btf__get_nr_types accessing obj->btf which is NULL. Fix this by
checking for the NULL pointer, and return error.

Reproducer:
$ cat a.bpf.c
extern int foo(void);
int bar(void) { return foo(); }
$ cat b.bpf.c
int foo(void) { return 0; }
$ clang -O2 -target bpf -c a.bpf.c
$ clang -O2 -target bpf -c b.bpf.c
$ bpftool gen obj out a.bpf.o b.bpf.o
Segmentation fault (core dumped)

After fix:
$ bpftool gen obj out a.bpf.o b.bpf.o
libbpf: failed to find BTF info for object 'a.bpf.o'
Error: failed to link 'a.bpf.o': Unknown error -22 (-22)

Fixes: a46349227cd8 (libbpf: Add linker extern resolution support for functions and global variables)
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/linker.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 10911a8cad0f..2df880cefdae 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -1649,11 +1649,17 @@ static bool btf_is_non_static(const struct btf_type *t)
 static int find_glob_sym_btf(struct src_obj *obj, Elf64_Sym *sym, const char *sym_name,
 			     int *out_btf_sec_id, int *out_btf_id)
 {
-	int i, j, n = btf__get_nr_types(obj->btf), m, btf_id = 0;
+	int i, j, n, m, btf_id = 0;
 	const struct btf_type *t;
 	const struct btf_var_secinfo *vi;
 	const char *name;

+	if (!obj->btf) {
+		pr_warn("failed to find BTF info for object '%s'\n", obj->filename);
+		return -EINVAL;
+	}
+
+	n = btf__get_nr_types(obj->btf);
 	for (i = 1; i <= n; i++) {
 		t = btf__type_by_id(obj->btf, i);

--
2.33.0

